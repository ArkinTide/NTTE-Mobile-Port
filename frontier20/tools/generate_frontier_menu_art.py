"""Rebuild Storms' native loadout frames from the original NTUF crown icon.

The textual .yy resource is maintained in native/menu-assets. PNGs are derived
from upstream original/Frontier/Sprites/Crowns/sprCrownStormsIcon.png; no encoded
artwork is embedded here. Requires Pillow, as does the main asset importer.
Run --check to verify the current binary files without writing them.
"""
from pathlib import Path
import argparse
import hashlib
from io import BytesIO
import json

ROOT = Path(__file__).resolve().parents[1]
RESOURCE = 'sprFRStormsLoadout'
SOURCE = ROOT / 'original/Frontier/Sprites/Crowns/sprCrownStormsIcon.png'
TEMPLATE = ROOT / 'native/menu-assets' / RESOURCE


def generate(source=SOURCE, output=TEMPLATE, check=False):
    from PIL import Image

    source, output = Path(source), Path(output)
    metadata = json.loads((TEMPLATE / (RESOURCE + '.yy')).read_text('utf8'))
    with Image.open(source) as upstream:
        icon = upstream.convert('RGBA')
    assert icon.size == (24, 32), 'Upstream Storms crown icon dimensions changed'
    unlocked = Image.new('RGBA', (32, 32), (0, 0, 0, 0))
    unlocked.paste(icon, (4, 0))
    shade = Image.new('L', unlocked.size, 40)
    locked = Image.merge('RGBA', (shade, shade, shade, unlocked.getchannel('A')))
    layer = metadata['layers'][0]['name']
    files = {}
    for frame, image in zip(metadata['frames'], (unlocked, locked), strict=True):
        buffer = BytesIO()
        image.save(buffer, format='PNG')
        encoded = buffer.getvalue()
        for relative in (Path(frame['name'] + '.png'),
                         Path('layers') / frame['name'] / (layer + '.png')):
            target = output / relative
            if check:
                assert target.read_bytes() == encoded, 'Derived crown artwork differs: ' + str(target)
            else:
                target.parent.mkdir(parents=True, exist_ok=True)
                target.write_bytes(encoded)
            files[relative.as_posix()] = hashlib.sha256(encoded).hexdigest()
    return {'resource': RESOURCE, 'source': str(source),
            'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
            'frame_size': [32, 32], 'origin': [16, 16],
            'derivation': '24x32 upstream icon padded x+4; RGB40 silhouette keeps identical alpha',
            'check_only': check, 'files_sha256': files}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, default=SOURCE)
    parser.add_argument('--output', type=Path, default=TEMPLATE)
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    print(json.dumps(generate(args.source, args.output, args.check), indent=2))
