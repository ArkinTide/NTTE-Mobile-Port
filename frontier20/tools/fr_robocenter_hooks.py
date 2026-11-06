"""Install stationary Robocenter beam work only in a caller-selected stage."""
from pathlib import Path


def apply(project):
    project = Path(project)
    files = list((project / "scripts").glob("frCode_robocenter_area_*/*.gml"))
    if len(files) != 1:
        raise RuntimeError(f"Expected one generated Robocenter module, found {len(files)}")
    path = files[0]
    text = path.read_text("utf-8-sig")
    original = ('var _frl_scanLength = fr_Areas_robocenter_area_gml_binary_search('
                '["area", "robocenter", fr_Areas_robocenter_area_gml_check_laser_style], 500);')
    optimized = 'var _frl_scanLength = scrFRRobocenterBeamLength(500);'
    if original in text:
        if text.count(original) != 2 or optimized in text:
            raise RuntimeError("Robocenter scan call anchors changed")
        text = text.replace(original, optimized)
    elif text.count(optimized) != 2:
        raise RuntimeError("Robocenter scan calls missing")

    start = text.index('function fr_Areas_robocenter_area_gml_WarningBeam_create(')
    end = text.index('function fr_Areas_robocenter_area_gml_Beam_create(', start)
    warning = text[start:end]
    marker = 'scrFRRobocenterWarningVisual();'
    if marker not in warning:
        before = 'yprevious = y;\nreturn scrFRSelf(self);'
        if warning.count(before) != 1:
            raise RuntimeError("Robocenter warning finalization anchor changed")
        warning = warning.replace(before, 'yprevious = y;\n' + marker + '\nreturn scrFRSelf(self);', 1)
        text = text[:start] + warning + text[end:]
    if text != path.read_text("utf-8-sig"):
        path.write_text(text, "utf-8", newline="\n")
    return {"file": str(path), "scan_calls": 2, "visual_warning": True}


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    print(json.dumps(apply(parser.parse_args().project), ensure_ascii=True, indent=2))
