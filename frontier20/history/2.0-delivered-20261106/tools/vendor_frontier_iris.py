"""Vendor only the Defpack Iris dependency required by Frontier's default weapons.

The installed source is read-only. Its complete hash and every selected body and
PNG hash are recorded; this is not an installation or advertisement of Defpack.
No download/load code or credentials are copied.
"""
from pathlib import Path
import argparse
import base64
import hashlib
import json
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path(r'D:/Steam/steamapps/common/Nuclear Throne/mods/Defpack/defpack tools/Defpack Tools.mod.gml')
EXPECTED = '834848d637cc87ea5e40795e776d8da7077943a32e6f3fa6ab7c5596388ae669'
TARGET = ROOT / 'dependencies/Frontier_IrisProjectiles.mod.gml'
REPORT = ROOT / 'analysis/defpack-iris-vendor.json'
FACTORIES = ['create_fire_bullet', 'create_gamma_bullet', 'create_toxic_bullet',
             'create_psy_bullet', 'create_lightning_bullet']
DEFINITIONS = [
    'script_ref_call_self', 'chance_raw', 'angle_approach',
    'instance_nearest_matching_ne', 'shell_hit', 'iris_bullet_anim',
    'iris_bouncer_step', 'bouncer_spin', 'bullet_init', 'create_bullet',
    'create_slash_bullet', 'bullet_hit', 'bullet_destroy', 'bullet_anim',
    'bullet_wall', 'recycle_gland_roll', 'create_psy_bullet', 'psy_step',
    'psy_hit', 'create_gamma_bullet', 'gamma_projectile', 'gamma_hit', 'nothing',
    'create_lightning_bullet', 'new_thunder_hit', 'new_thunder_destroy',
    'create_toxic_bullet', 'toxic_hit', 'poison', 'toxic_destroy',
    'create_fire_bullet', 'fire_bullet_hit', 'fire_step', 'fire_destroy',
]


def sha(data):
    return hashlib.sha256(data).hexdigest()


def extract():
    raw = SOURCE.read_bytes()
    assert sha(raw) == EXPECTED, 'Installed Defpack changed; re-audit before vendoring'
    text = raw.decode('utf-8-sig')
    # Defpack has examples in comments. Preserve offsets while finding headers.
    from fr_gml_frontend import PATTERN
    masked = PATTERN.sub(lambda m: re.sub(r'[^\n]', ' ', m[0]) if m.lastgroup == 'comment' else m[0], text)
    matches = list(re.finditer(r'^[ \t]*#define[ \t]+(\w+)(?:[ \t]*\([^\r\n)]*\))?[^\S\r\n]*', masked, re.M))
    selected = {}
    for index, match in enumerate(matches):
        name = match[1]
        if name in DEFINITIONS:
            stop = matches[index + 1].start() if index + 1 < len(matches) else len(text)
            # Preserve the selected definition body exactly as installed.
            selected[name] = (text[match.start():stop], text.count('\n', 0, match.start()) + 1)
    assert set(selected) == set(DEFINITIONS)
    asset_audit = json.loads((ROOT / 'analysis/defpack-iris-asset-audit.json').read_text('utf8'))
    assert asset_audit['source_sha256'] == EXPECTED and len(asset_audit['assets']) == 18
    lines = [
        '// Focused Defpack Iris projectile dependency for Frontier default weapons.',
        '// Source: Defpack Tools.mod.gml; source/body/PNG hashes: analysis/defpack-iris-vendor.json.',
        '// Defpack authors/contributors retain attribution; no package license was found locally.',
        '// This module does not advertise the complete optional defpack tools module.',
        '#macro spr global.spr', '#macro msk global.spr.msk',
        '#macro neurons skill_get("excitedneurons")',
        '#macro brain_active skill_get(mut_laser_brain) > 0', '',
        '#define init', 'global.spr = {};', 'global.spr.msk = {};',
    ]
    assets = []
    for asset in asset_audit['assets']:
        path = Path(asset['path'])
        data = path.read_bytes()
        assert sha(data) == asset['sha256']
        field = asset['field']
        target = 'global.spr.' + field
        x, y = asset['origin']
        line = len(lines) + 1
        lines.append(f'{target} = sprite_add_base64("{base64.b64encode(data).decode()}", {asset["declared_frames"]}, {x}, {y});')
        assets.append({k: asset[k] for k in ('field', 'path', 'sha256', 'declared_frames', 'frame_size', 'origin', 'source_line', 'loader')}
                      | {'vendored_line': line})
    lines += [
        '// Original factory appends Upg then Bounce; original init used the reverse key.',
        'global.spr.LightningBulletUpgBounce = global.spr.LightningBulletBounceUpg;', '',
    ]
    definitions = []
    for name in DEFINITIONS:
        original, line = selected[name]
        adapted = original
        adaptations = []
        if name == 'script_ref_call_self':
            # NTT represents a callback as a three-item module reference. The
            # native static compiler represents a local callback as code; its
            # script_ref_call adapter already preserves self for either form.
            adapted = re.sub(r'mod_script_call_self\(scr\[0\], scr\[1\], scr\[2\]\)', 'script_ref_call(scr)', adapted)
            assert adapted != original
            adaptations.append('Use native script_ref_call codec for scalar compiled callback and legacy array reference; same self scope.')
        definitions.append({'name': name, 'source_line': line,
            'source_definition_sha256': sha(original.encode()),
            'vendored_definition_sha256': sha(adapted.encode()), 'adaptations': adaptations})
        lines.append(adapted)
    output = '\n'.join(lines)
    # Parse the whole focused closure before writing a compilable dependency.
    from fr_gml_parser import definitions as parse
    parsed = parse(output, 'dependencies/Frontier_IrisProjectiles.mod.gml')
    assert set(d.name for d in parsed) == set(DEFINITIONS) | {'__load', 'init'}
    report = {
        'source': str(SOURCE), 'source_sha256': EXPECTED,
        'source_read_only': True, 'module': 'mod:Frontier_IrisProjectiles',
        'vendored_path': TARGET.relative_to(ROOT).as_posix(), 'vendored_sha256': sha(output.encode()),
        'factories': FACTORIES, 'definitions': definitions, 'assets': assets,
        'license': 'No package-level LICENSE/COPYING/explicit grant found in installed Defpack. Preserve Defpack author and contributor attribution; no license is invented.',
        'attribution': 'Defpack contributors; Frontier credits jsburg for Defpack loader and burg for lightning. Authored source comments retained in selected definitions.',
        'scope': 'Five direct Iris factories and their source helper closure only. Complete defpack tools loaded/existence query remains false.',
        'adaptations': [
            'Replace full init/downloader/permissions/soda/other weapons with only 18 exact embedded sprite declarations.',
            'Add LightningBulletUpgBounce alias to original LightningBulletBounceUpg asset.',
            'Psy mask keeps precise per-frame collision semantics through native imported sprite collisionKind=1.',
            'script_ref_call_self uses native script reference codec; source callback scope retained.',
        ],
    }
    return output, report


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    output, report = extract()
    if args.write:
        TARGET.write_text(output, encoding='utf8', newline='')
        REPORT.write_text(json.dumps(report, indent=2, ensure_ascii=False) + '\n', encoding='utf8')
    else:
        assert TARGET.read_bytes() == output.encode(), 'Vendored Iris closure differs from audited installed source'
        assert json.loads(REPORT.read_text('utf8')) == report
    print(json.dumps({'status': 'VENDORED' if args.write else 'VERIFIED',
        'factories': len(FACTORIES), 'definitions': len(DEFINITIONS), 'assets': len(report['assets']),
        'vendored_sha256': report['vendored_sha256']}))


if __name__ == '__main__':
    main()
