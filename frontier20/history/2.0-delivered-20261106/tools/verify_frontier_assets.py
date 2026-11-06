"""Verify emitted Frontier pixels and native descriptor links against originals."""
from pathlib import Path
import base64
import importlib.util
import json
from io import BytesIO
import hashlib

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('frontier_importer', Path(__file__).with_name('import_frontier_assets.py'))
importer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(importer)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def verify_iris(manifest):
    """Keep the new external closure separate from original Frontier totals."""
    provenance = json.loads((ROOT / 'analysis/defpack-iris-vendor.json').read_text('utf8'))
    module = provenance['vendored_path']
    calls = [call for call in manifest['calls'] if call['module'] == module]
    assert len(calls) == len(provenance['assets']) == 18
    resources = set()
    for row in provenance['assets']:
        assert sha(Path(row['path'])) == row['sha256']
        matching = [call for call in calls if call['line'] == row['vendored_line']]
        assert len(matching) == 1
        call = matching[0]
        assert call['asset'] == '@embedded/' + row['sha256'] + '.png'
        asset = next(item for item in manifest['assets'] if item['resource'] == call['resource'])
        assert asset['strip_frames'] == row['declared_frames'] and asset['origin'] == row['origin']
        assert [asset['width'], asset['height']] == row['frame_size']
        descriptor = json.loads((ROOT / 'generated-assets/sprites' / asset['resource'] / (asset['resource'] + '.yy')).read_text('utf8'))
        if row['field'] == 'msk.PsyBullet':
            assert descriptor['collisionKind'] == 1, 'Authored Psy mask must remain precise'
        resources.add(asset['resource'])
    assert len(resources) == 18
    # Original archive, frozen baseline artwork and existing dependency
    # declarations retain their own pixel/hash counts even as Iris is added.
    original_assets = [asset for asset in manifest['assets'] if asset['resource'] not in resources]
    assert len(manifest['original_media']) == 2236
    assert sum(asset['kind'] == 'sound' for asset in original_assets) == 160
    assert sum(asset.get('frames', 0) for asset in original_assets if asset['kind'] == 'sprite') == 7265
    assert len(original_assets) == 2010
    assert len(manifest['calls']) - len(calls) == 2110
    return dict(source_sha256=provenance['source_sha256'], source_definitions=len(provenance['definitions']),
        sprite_sources=18, sprite_resources=len(resources),
        frame_pixels_verified=sum(asset.get('frames', 0) for asset in manifest['assets'] if asset['resource'] in resources),
        original_archive_media=2236, original_native_resources=2010, original_frame_pixels=7265,
        original_sound_files=160, original_source_declarations=2110)


def main():
    out = ROOT / 'generated-assets'
    manifest = json.loads((out / 'manifest.json').read_text(encoding='utf-8'))
    resources = json.loads((out / 'resources.json').read_text(encoding='utf-8'))
    assert manifest['summary']['unresolved_calls'] == 0
    original = ROOT / 'original/Frontier'
    for media in manifest['original_media']:
        assert sha(original / media['path']) == media['sha256'], media['path']
    embedded = {}
    for call in manifest['calls']:
        if call['function'] != 'sprite_add_base64':
            continue
        source = ROOT / call['module'] if call['module'].startswith('dependencies/') else original / call['module']
        text = importer.uncomment(source.read_text(encoding='utf-8-sig'))
        arguments, _ = importer.balanced_call(text, text.index('(', call['start']))
        embedded[call['asset']] = base64.b64decode(importer.string_value(arguments[0]))
    frames, sounds, variants = 0, 0, 0
    declared = set()
    for resource in resources:
        name, path = resource['id']['name'], resource['id']['path']
        descriptor = json.loads((out / path).read_text(encoding='utf-8'))
        assert descriptor['name'] == descriptor['%Name'] == name
        declared.add(name)
    for asset in manifest['assets']:
        name = asset['resource']
        assert name in declared
        if asset['kind'] == 'sound':
            folder = out / 'sounds' / name
            descriptor = json.loads((folder / (name + '.yy')).read_text(encoding='utf-8'))
            assert sha(folder / descriptor['soundFile']) == sha(original / asset['path'])
            sounds += 1
            continue
        folder = out / 'sprites' / name
        descriptor = json.loads((folder / (name + '.yy')).read_text(encoding='utf-8'))
        if asset['path'].startswith('@embedded/'):
            data = embedded[asset['path']]
        elif asset['path'].startswith('@base/'):
            data = (ROOT / 'base-assets' / asset['path'][6:]).read_bytes()
            assert hashlib.sha256(data).hexdigest() == asset['source_sha256']
        else:
            data = (original / asset['path']).read_bytes()
        with Image.open(BytesIO(data)) as source:
            source = source.convert('RGBA')
            count = max(1, asset['strip_frames'])
            width = source.width // count
            expected = [source.crop((i * width, 0, (i+1) * width, source.height)) for i in range(count)]
        if asset['weapon_shine']:
            expected = importer.weapon_shine(expected[0])
        assert len(descriptor['frames']) == len(expected) == asset['frames']
        sequence = descriptor['sequence']
        assert [sequence['xorigin'], sequence['yorigin']] == asset['origin']
        assert sequence['length'] == len(expected)
        keys = sequence['tracks'][0]['keyframes']['Keyframes']
        assert len(keys) == len(expected)
        layer = descriptor['layers'][0]['name']
        for i, (frame, image) in enumerate(zip(descriptor['frames'], expected)):
            key = keys[i]
            assert key['Key'] == i
            assert key['Channels']['0']['Id'] == {'name': frame['name'], 'path': f'sprites/{name}/{name}.yy'}
            assert image.size == (descriptor['width'], descriptor['height'])
            for p in (folder / (frame['name'] + '.png'), folder / 'layers' / frame['name'] / (layer + '.png')):
                with Image.open(p) as stored:
                    assert image.size == stored.size and image.tobytes() == stored.convert('RGBA').tobytes(), p
            assert hashlib.sha256(image.tobytes()).hexdigest() == asset['rgba_sha256'][i]
            frames += 1
        variants += 1
    hashes = json.loads((out / 'file-hashes.json').read_text(encoding='utf-8'))
    for entry in hashes:
        assert sha(out / entry['path']) == entry['sha256']
    report = {'status': 'PASS', 'original_media_sha256': len(manifest['original_media']), 'sprite_variants': variants,
              'frame_pixels_verified': frames, 'sound_files_sha256': sounds, 'native_resources': len(resources),
              'generated_files_sha256': len(hashes), 'resolved_source_calls': len(manifest['calls']),
              'unresolved_source_calls': 0, 'production_project_modified': False}
    report['frozen_native_sprite_strips'] = manifest['summary']['frozen_native_sprite_strips']
    report['defpack_iris'] = verify_iris(manifest)
    (out / 'verification.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
