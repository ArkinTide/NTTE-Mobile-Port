"""Prepare a local platform copy without changing the tracked source project."""
import argparse
from pathlib import Path
import shutil

ROOT = Path(__file__).resolve().parents[1]
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--platform', choices=['android', 'ios', 'windows'], required=True)
args = parser.parse_args()
output = ROOT / '.local' / args.platform / 'project'
if output.exists():
    raise SystemExit('Output already exists; keep your extracted assets and choose a clean checkout for another preparation.')
shutil.copytree(ROOT / 'project', output)
if args.platform == 'android':
    shutil.copytree(ROOT / 'platforms/android/project', output, dirs_exist_ok=True)
print('Prepared:', output / 'nuclearthronemobile.yyp')
print('Extract your own game assets in this local copy, then open it in GameMaker.')
