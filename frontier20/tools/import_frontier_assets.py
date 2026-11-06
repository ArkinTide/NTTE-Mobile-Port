"""Offline, namespaced Frontier artwork importer; never modifies a game project.

Literal NTT sprite declarations retain strip frames and origin, including the
seven generated weapon-shine frames used by sprite_add_weapon. Every original
media file is inventoried; undeclared files stay explicitly unresolved rather
than receiving invented animation metadata. The only writes are below the
frontier20/generated-assets tree. Assets remain authored by Frontier contributors.
"""
from __future__ import annotations

import argparse
import ast
import base64
import copy
import hashlib
from io import BytesIO
import json
import operator
from pathlib import Path
import re
import shutil
import sys
import uuid

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'original/Frontier'
PROJECT = ROOT.parent / 'project'
OUTPUT = ROOT / 'generated-assets'
BASE = ROOT / 'base-assets'
NAMESPACE = uuid.UUID('61be679e-c275-5047-ac78-824c983b80e4')
FUNCTIONS = {'sprite_add', 'sprite_add_weapon', 'sprite_add_base64', 'sound_add'}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def load_yy(path):
    # GameMaker writes JSON with trailing commas. Do not import historical
    # resource helpers: those also carry now-retired one-time project mutators.
    text = path.read_text(encoding='utf-8-sig')
    return json.loads(re.sub(r',(?=\s*[}\]])', '', text))


def save(path, value):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')


def uncomment(text):
    pattern = r'"(?:\\.|[^"\\])*"|`[^`]*`|/\*[\s\S]*?\*/|//[^\n]*'
    return re.sub(pattern, lambda m: re.sub(r'[^\n]', ' ', m[0])
                  if m[0].startswith(('//', '/*')) else m[0], text)


def balanced_call(text, at):
    depth, quote, escaped = 1, None, False
    start = at + 1
    args = []
    i = start
    while i < len(text):
        ch = text[i]
        if quote:
            if escaped:
                escaped = False
            elif ch == '\\' and quote != '`':
                escaped = True
            elif ch == quote:
                quote = None
        elif ch in '"`':
            quote = ch
        elif ch in '([{':
            depth += 1
        elif ch in ')]}':
            depth -= 1
            if depth == 0:
                args.append(text[start:i].strip())
                return args, i + 1
        elif ch == ',' and depth == 1:
            args.append(text[start:i].strip())
            start = i + 1
        i += 1
    raise ValueError('Unterminated declaration')


def string_value(expr):
    if expr.startswith('`') and expr.endswith('`'):
        return expr[1:-1]
    if not re.fullmatch(r'"(?:\\.|[^"\\])*"', expr):
        raise ValueError('nonliteral string')
    # GML paths use ordinary forward slashes in this archive.
    return json.loads(expr)


def number(expr):
    operators = {ast.Add: operator.add, ast.Sub: operator.sub,
                 ast.Mult: operator.mul, ast.Div: operator.truediv,
                 ast.FloorDiv: operator.floordiv}
    def visit(node):
        if isinstance(node, ast.Constant) and type(node.value) in (int, float):
            return node.value
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.USub, ast.UAdd)):
            return (-1 if isinstance(node.op, ast.USub) else 1) * visit(node.operand)
        if isinstance(node, ast.BinOp) and type(node.op) in operators:
            return operators[type(node.op)](visit(node.left), visit(node.right))
        raise ValueError('nonliteral numeric expression')
    value = visit(ast.parse(expr, mode='eval').body)
    if value != int(value):
        raise ValueError('noninteger sprite metadata')
    return int(value)


def uid(key):
    return str(uuid.uuid5(NAMESPACE, key))


def native_name(kind, key, original):
    stem = re.sub(r'[^A-Za-z0-9_]', '_', Path(original).stem)[:24]
    return ('sprFR_' if kind == 'sprite' else 'sndFR_') + stem + '_' + digest(key.encode())[:12]


def weapon_shine(image):
    # Reproduces the already-recovered NTT sprite_add_weapon helper used by
    # NTTE. This is a pure image transform, independent of historical importers.
    base = image.convert('RGBA')
    w, h = base.size
    images = [base.copy()]
    white = Image.new('RGBA', base.size, (255, 255, 255, 0))
    white.putalpha(base.getchannel('A'))
    images.append(white)
    old = -h
    for shift in (1, (w + 2) // 3, (4 * w + 4) // 5, w - 1, w + h):
        frame = base.copy()
        for y in range(h):
            start = old + y - h // 2
            for x in range(max(0, start), min(w, start + shift - old)):
                alpha = base.getpixel((x, y))[3]
                if alpha:
                    frame.putpixel((x, y), (255, 255, 255, alpha))
        images.append(frame)
        old = shift
    return images


def emit_sprite(entry, images, template):
    name, origin = entry['resource'], entry['origin']
    target = OUTPUT / 'sprites' / name
    target.mkdir(parents=True, exist_ok=True)
    descriptor = copy.deepcopy(template)
    descriptor.update(name=name, **{'%Name': name})
    descriptor['parent'] = {'name': 'Frontier', 'path': 'folders/Frontier.yy'}
    descriptor.update(width=images[0].width, height=images[0].height,
                      origin=9, bboxMode=0, collisionKind=1,
                      bbox_left=0, bbox_top=0,
                      bbox_right=images[0].width - 1, bbox_bottom=images[0].height - 1)
    union = None
    for image in images:
        bbox = image.getchannel('A').getbbox()
        if bbox:
            union = bbox if union is None else (min(union[0], bbox[0]), min(union[1], bbox[1]), max(union[2], bbox[2]), max(union[3], bbox[3]))
    if union:
        descriptor.update(bbox_left=union[0], bbox_top=union[1], bbox_right=union[2]-1, bbox_bottom=union[3]-1)
    layer = copy.deepcopy(descriptor['layers'][0])
    layerid = uid(name + '/layer')
    layer['name'] = layer['%Name'] = layerid
    descriptor['layers'] = [layer]
    frame_template = copy.deepcopy(descriptor['frames'][0])
    track = descriptor['sequence']['tracks'][0]
    key_template = copy.deepcopy(track['keyframes']['Keyframes'][0])
    descriptor['frames'] = []
    track['keyframes']['Keyframes'] = []
    frame_hashes = []
    for i, image in enumerate(images):
        frameid = uid(name + '/frame/' + str(i))
        frame = copy.deepcopy(frame_template)
        frame['name'] = frame['%Name'] = frameid
        descriptor['frames'].append(frame)
        key = copy.deepcopy(key_template)
        key.update(id=uid(name + '/key/' + str(i)), Key=float(i))
        key['Channels']['0']['Id'] = {'name': frameid, 'path': f'sprites/{name}/{name}.yy'}
        track['keyframes']['Keyframes'].append(key)
        image.save(target / (frameid + '.png'))
        layerdir = target / 'layers' / frameid
        layerdir.mkdir(parents=True, exist_ok=True)
        image.save(layerdir / (layerid + '.png'))
        frame_hashes.append(digest(image.tobytes()))
    descriptor['sequence'].update(length=float(len(images)), xorigin=origin[0], yorigin=origin[1], playbackSpeed=1.0, playbackSpeedType=1)
    save(target / (name + '.yy'), descriptor)
    return {'width': images[0].width, 'height': images[0].height, 'frames': len(images), 'rgba_sha256': frame_hashes}


def emit_sound(entry, source, template):
    name = entry['resource']
    target = OUTPUT / 'sounds' / name
    target.mkdir(parents=True, exist_ok=True)
    descriptor = copy.deepcopy(template)
    descriptor.update(name=name, **{'%Name': name}, soundFile=name + source.suffix.lower(), volume=1.0, duration=0)
    descriptor['parent'] = {'name': 'Frontier', 'path': 'folders/Frontier.yy'}
    # Music/ambience streams; short sound effects remain compressed in-memory.
    stream = source.name.lower().startswith(('mus', 'amb'))
    descriptor.update(compression=3 if stream else 1, preload=not stream)
    shutil.copyfile(source, target / descriptor['soundFile'])
    save(target / (name + '.yy'), descriptor)


def replacement_declarations(path, module, text):
    """Recover the authored replacements, including the two literal tables.

    Their runtime calls use dynamic paths, but frame counts and origins are
    explicitly declared beside each path in the source. Keep those distinct
    from add-call compiler substitutions and do not infer strip metadata.
    """
    result = []
    for match in re.finditer(r'\bsprite_replace\s*\(', text):
        values, end = balanced_call(text, match.end()-1)
        if len(values) < 3 or not values[1].startswith(('"', '`')):
            continue
        declared = string_value(values[1])
        frames = number(values[2])
        if len(values) == 5:
            origin = [number(x) for x in values[3:5]]
            resolution = 'Explicit sprite_replace origin'
        elif len(values) == 3 and re.fullmatch(r'[A-Za-z_]\w*', values[0]):
            target = load_yy(PROJECT / f'sprites/{values[0]}/{values[0]}.yy')
            origin = [target['sequence']['xorigin'], target['sequence']['yorigin']]
            resolution = 'Retain native target origin: ' + values[0]
        else:
            raise ValueError('Unsupported replacement declaration: ' + module)
        result.append({'function': 'sprite_replace', 'line': text.count('\n', 0, match.start())+1,
                       'start': match.start(), 'end': end, 'declared': declared,
                       'frames': frames, 'origin': origin, 'metadata_resolution': resolution})
    # These are the only source tables passed to dynamic sprite_replace.
    for match in re.finditer(r'global\.augmentBaseSprites\s*=\s*\[', text):
        section_start = text.rfind('#define', 0, match.start())
        section = text[section_start:match.start()]
        constants = {m[1]: string_value(m[2]) for m in
                     re.finditer(r'\b(_\w+)\s*=\s*("(?:\\.|[^"\\])*")', section)}
        rows, end = balanced_call(text, match.end()-1)
        row_cursor = match.end()
        for row in rows:
            row = row.strip()
            if not row:
                continue
            row_at = text.index(row, row_cursor, end)
            row_cursor = row_at + len(row)
            values, _ = balanced_call(row, row.index('['))
            frames, origin = number(values[-3]), [number(x) for x in values[-2:]]
            for variant in values[1:-3]:
                if variant == 'undefined':
                    continue
                declared = string_value(variant)
                declared = re.sub(r'\$\{([^}]+)\}', lambda m: constants[m[1]], declared)
                at = text.index(variant, row_at, row_cursor)
                result.append({'function': 'sprite_replace_variant', 'line': text.count('\n', 0, at)+1,
                               'start': at, 'end': at+len(variant), 'declared': declared,
                               'frames': frames, 'origin': origin,
                               'metadata_resolution': 'Explicit augmentBaseSprites row'})
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--emit', action='store_true', help='Write isolated native .yy and artwork resources')
    args = parser.parse_args()
    if not SOURCE.is_dir():
        raise SystemExit('Extracted original Frontier source missing')
    OUTPUT.mkdir(parents=True, exist_ok=True)
    media = {}
    for path in sorted(SOURCE.rglob('*')):
        if path.is_file() and path.suffix.lower() in {'.png', '.ogg', '.wav', '.mp3'}:
            relative = path.relative_to(SOURCE).as_posix()
            if relative.casefold() in media:
                raise ValueError('Ambiguous case-insensitive asset path: ' + relative)
            media[relative.casefold()] = {'path': relative, 'bytes': path.stat().st_size, 'sha256': digest(path.read_bytes())}
    calls, unresolved, variants = [], [], {}
    code_paths = sorted(path for path in SOURCE.rglob('*') if path.is_file() and path.suffix.lower() in {'.gml', '.ntgml'})
    code_paths += sorted((ROOT / 'dependencies').glob('*.gml'))
    for path in code_paths:
        module = path.relative_to(SOURCE).as_posix() if path.is_relative_to(SOURCE) else path.relative_to(ROOT).as_posix()
        text = uncomment(path.read_text(encoding='utf-8-sig'))
        for match in re.finditer(r'\b(sprite_add(?:_weapon|_base64)?|sound_add)\s*\(', text):
            function = match[1]
            line = text.count('\n', 0, match.start()) + 1
            call = {'module': module, 'line': line, 'start': match.start(), 'function': function}
            try:
                values, end = balanced_call(text, match.end()-1)
                call['end'] = end
                if function == 'sprite_add_base64':
                    data = base64.b64decode(string_value(values[0]), validate=True)
                    origin = [number(x) for x in values[2:4]]
                    frames = number(values[1])
                    source_key = '@embedded/' + digest(data) + '.png'
                    extra = {'embedded_base64': base64.b64encode(data).decode('ascii')}
                else:
                    declared = string_value(values[0])
                    full = (path.parent / declared).resolve()
                    if not full.is_relative_to(SOURCE.resolve()):
                        raise ValueError('Asset path leaves original Frontier tree')
                    requested = full.relative_to(SOURCE.resolve()).as_posix().casefold()
                    # NTT's mod paths are case insensitive on this platform.
                    if requested not in media:
                        raise ValueError('Source asset missing: ' + requested)
                    source_key = media[requested]['path']
                    extra = {}
                    if function == 'sound_add':
                        origin, frames = None, None
                        if len(values) != 1:
                            raise ValueError('Unexpected sound_add signature')
                    elif function == 'sprite_add_weapon':
                        if len(values) != 3:
                            raise ValueError('Unexpected sprite_add_weapon signature')
                        frames, origin = 1, [number(x) for x in values[1:3]]
                    else:
                        if len(values) != 4:
                            raise ValueError('Unexpected sprite_add signature')
                        if values[1] == 'race_skins()':
                            constant = re.search(r'^#define\s+race_skins\s+return\s+(\d+)\s*;', text, re.M)
                            if constant is None:
                                raise ValueError('race_skins() lacks a literal module definition')
                            frames = int(constant[1])
                            extra['frame_count_resolution'] = 'Module race_skins() returns ' + constant[1]
                        else:
                            frames = number(values[1])
                        origin = [number(x) for x in values[2:4]]
                kind = 'sound' if function == 'sound_add' else 'sprite'
                variant_key = json.dumps([kind, source_key.casefold(), frames, origin, function == 'sprite_add_weapon'], separators=(',', ':'))
                resource = native_name(kind, variant_key, source_key)
                variants.setdefault(variant_key, {'kind': kind, 'path': source_key, 'resource': resource, 'strip_frames': frames, 'origin': origin, 'weapon_shine': function == 'sprite_add_weapon', 'declarations': [], **extra})['declarations'].append({'module': module, 'line': line})
                call.update(resource=resource, asset=source_key, variant=variant_key)
            except (ValueError, SyntaxError, IndexError, json.JSONDecodeError) as error:
                call['error'] = str(error)
                # Keep expressions, never embedded credential-bearing loaders.
                call['arguments'] = [value[:300] for value in locals().get('values', [])]
                unresolved.append(call.copy())
            calls.append(call)
        for declaration in replacement_declarations(path, module, text):
            call = {key: declaration[key] for key in ('function', 'line', 'start', 'end')}
            call['module'] = module
            declared = declaration['declared']
            full = (path.parent / declared).resolve()
            if not full.is_relative_to(SOURCE.resolve()):
                raise ValueError('Replacement path leaves original Frontier tree: ' + declared)
            requested = full.relative_to(SOURCE.resolve()).as_posix().casefold()
            if requested not in media:
                raise ValueError('Replacement media missing: ' + requested)
            source_key = media[requested]['path']
            origin, frames = declaration['origin'], declaration['frames']
            variant_key = json.dumps(['sprite', source_key.casefold(), frames, origin, False], separators=(',', ':'))
            resource = native_name('sprite', variant_key, source_key)
            variants.setdefault(variant_key, {'kind': 'sprite', 'path': source_key, 'resource': resource,
                'strip_frames': frames, 'origin': origin, 'weapon_shine': False, 'declarations': []})[
                'declarations'].append({'module': module, 'line': declaration['line'],
                                       'metadata_resolution': declaration['metadata_resolution']})
            call.update(resource=resource, asset=source_key, variant=variant_key)
            calls.append(call)
    base_media = json.loads((BASE / 'manifest.json').read_text('utf-8'))['assets']
    for native in base_media:
        data = (BASE / native['path']).read_bytes()
        if digest(data) != native['sha256']:
            raise ValueError('Frozen native artwork changed: ' + native['path'])
        source_key = '@base/' + native['path']
        key = json.dumps(['sprite', source_key.casefold(), native['frames'], native['origin'], False], separators=(',', ':'))
        variants[key] = {'kind': 'sprite', 'path': source_key, 'resource': native['resource'],
            'strip_frames': native['frames'], 'origin': native['origin'], 'weapon_shine': False,
            'declarations': [], 'provenance': native['provenance'], 'source_sha256': native['sha256']}
    sprite_template = load_yy(PROJECT / 'sprites/mskBandit/mskBandit.yy')
    sound_template = load_yy(PROJECT / 'sounds/amb0/amb0.yy')
    entries = []
    for key, entry in sorted(variants.items()):
        if entry['kind'] == 'sprite':
            if entry['path'].startswith('@embedded/'):
                data = base64.b64decode(entry['embedded_base64'])
            elif entry['path'].startswith('@base/'):
                data = (BASE / entry['path'][6:]).read_bytes()
            else:
                data = (SOURCE / entry['path']).read_bytes()
            with Image.open(BytesIO(data)) as strip:
                strip = strip.convert('RGBA')
                count = max(1, entry['strip_frames'])
                if entry['strip_frames'] < 1:
                    entry['strip_count_note'] = 'Zero subimage declaration uses one full source image.'
                if strip.width < count:
                    raise ValueError('Invalid strip division for ' + entry['path'])
                width = strip.width // count
                if strip.width % count:
                    entry['trailing_strip_columns'] = strip.width % count
                    entry['strip_division_note'] = 'Integer frame width; source has trailing columns outside declared frames.'
                images = [strip.crop((i*width, 0, (i+1)*width, strip.height)) for i in range(count)]
                if entry['weapon_shine']:
                    if len(images) != 1:
                        raise ValueError('Weapon sprite needs one source frame')
                    images = weapon_shine(images[0])
                if args.emit:
                    entry.update(emit_sprite(entry, images, sprite_template))
                else:
                    entry.update(width=width, height=strip.height, frames=len(images))
        elif args.emit:
            emit_sound(entry, SOURCE / entry['path'], sound_template)
        # Embedded artwork is materialized, never duplicated as base64 in the
        # public manifest. Callsite hashes still identify it reproducibly.
        entries.append({k:v for k,v in entry.items() if k != 'embedded_base64'})
    referenced = {entry['path'].casefold() for entry in entries}
    unused = [value for key, value in media.items() if key not in referenced]
    resources = [{'id': {'name': entry['resource'], 'path': f"{'sprites' if entry['kind']=='sprite' else 'sounds'}/{entry['resource']}/{entry['resource']}.yy"}} for entry in entries]
    summary = {'source_files': len(media), 'source_png': sum(x['path'].lower().endswith('.png') for x in media.values()), 'source_sounds': sum(not x['path'].lower().endswith('.png') for x in media.values()), 'asset_calls': len(calls), 'resolved_calls': len(calls)-len(unresolved), 'unresolved_calls': len(unresolved), 'sprite_resources': sum(e['kind']=='sprite' for e in entries), 'sound_resources': sum(e['kind']=='sound' for e in entries), 'unreferenced_files': len(unused), 'emitted': args.emit}
    summary['frozen_native_sprite_strips'] = len(base_media)
    save(OUTPUT / 'manifest.json', {'summary': summary, 'assets': entries, 'calls': calls, 'unresolved': unresolved, 'unreferenced': unused, 'original_media': list(media.values())})
    save(OUTPUT / 'asset-manifest.json', {'summary': summary, 'artwork': [{'source': call['module'], 'line': call['line'], 'native_resource': call['resource'], 'function': call['function'], 'asset': call['asset']} for call in calls if 'resource' in call], 'unresolved': unresolved})
    lookup = {}
    for entry in entries:
        lookup.setdefault(entry['path'].casefold(), []).append({k:entry[k] for k in ('resource', 'kind', 'strip_frames', 'origin', 'weapon_shine')})
    save(OUTPUT / 'path-lookup.json', lookup)
    save(OUTPUT / 'resources.json', resources)
    if args.emit:
        hashes = []
        expected = [OUTPUT / name for name in ('manifest.json', 'asset-manifest.json', 'path-lookup.json', 'resources.json')]
        for entry in entries:
            folder = OUTPUT / ('sprites' if entry['kind'] == 'sprite' else 'sounds') / entry['resource']
            expected.extend(path for path in folder.rglob('*') if path.is_file())
        for path in sorted(expected):
            hashes.append({'path': path.relative_to(OUTPUT).as_posix(), 'sha256': digest(path.read_bytes()), 'bytes': path.stat().st_size})
        save(OUTPUT / 'file-hashes.json', hashes)
    print(json.dumps(summary))
    if unresolved:
        print(json.dumps(unresolved, ensure_ascii=True)[:15000])


if __name__ == '__main__':
    main()
