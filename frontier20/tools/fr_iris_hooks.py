"""Focused Defpack Iris draw consumer in the genuine native bloom pass."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]


def apply(project):
    project = Path(project).resolve()
    assert project == (ROOT / 'staging/project').resolve()
    path = project / 'scripts/scrDrawBloom/scrDrawBloom.gml'
    text = path.read_text('utf8')
    begin, end = '// BEGIN FRONTIER IRIS BLOOM', '// END FRONTIER IRIS BLOOM'
    block = begin + '\n    scrFRIrisBloomDraw();\n' + end
    if block in text:
        assert text.count(begin) == 1
        return
    assert begin not in text and text.count('    scrNTTEFullProjectileBloomDraw();') == 1
    text = text.replace('    scrNTTEFullProjectileBloomDraw();',
        '    scrNTTEFullProjectileBloomDraw();\n' + block, 1)
    path.write_text(text, encoding='utf8')

