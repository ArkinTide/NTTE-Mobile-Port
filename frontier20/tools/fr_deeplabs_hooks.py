"""Select the local-surface Spin Turret renderer in a caller-selected stage.

The original generated renderer remains intact for the GPU regression oracle.
"""
from pathlib import Path


def apply(project):
    project = Path(project)
    files = list((project / "scripts").glob("frCode_deeplabs_area_*/*.gml"))
    if len(files) != 1:
        raise RuntimeError(f"Expected one generated Deeplabs module, found {len(files)}")
    path = files[0]
    text = path.read_text("utf-8-sig")
    old = 'on_draw = fr_Areas_deeplabs_area_gml_SpinTurret_draw;'
    new = 'on_draw = scrFRDeeplabsSpinTurretDraw;'
    if new in text:
        if text.count(new) != 1 or old in text:
            raise RuntimeError("Deeplabs local renderer hook is ambiguous")
        return {"file": str(path), "status": "already-applied"}
    if text.count(old) != 1:
        raise RuntimeError("Deeplabs Spin Turret draw hook anchor changed")
    path.write_text(text.replace(old, new, 1), "utf-8", newline="\n")
    return {"file": str(path), "status": "patched"}


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    print(json.dumps(apply(parser.parse_args().project), ensure_ascii=True, indent=2))
