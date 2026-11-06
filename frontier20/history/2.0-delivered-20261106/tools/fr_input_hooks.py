"""Bridge authored movement edges and LibMenu hit boxes to real touch input."""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re


def source_script(source):
    name = "frCode_" + re.sub(r"\W", "_", Path(source).stem)[:38] + "_" + hashlib.sha256(source.encode()).hexdigest()[:10]
    return "scripts/" + name + "/" + name + ".gml"


def hook_specs():
    joystick = "objects/JoystickMove/Other_10.gml"
    hooks = []

    def add(path, anchor, replacement, marker):
        hooks.append({"path": path, "anchor": anchor, "replacement": replacement, "marker": marker})

    for anchor, replacement in [
        ("var i = get_nearest_touch(rad)", "var i = scrFRTouchNearest(rad) // FRONTIER TOUCH MOVE NEAREST"),
        ("device_mouse_x_to_gui(index)", "scrFRTouchX(index) /* FRONTIER TOUCH MOVE X */"),
        ("device_mouse_y_to_gui(index)", "scrFRTouchY(index) /* FRONTIER TOUCH MOVE Y */"),
        ("device_mouse_check_button_released(index, mb_left)", "scrFRTouchReleased(index) /* FRONTIER TOUCH MOVE RELEASE */"),
    ]:
        add(joystick, anchor, replacement, replacement)
    add(joystick,
        "if UberCont.opt_hiddensticks {",
        "scrFRTouchMovementSample(global.index,index); // FRONTIER TOUCH MOVE EDGES\n\nif UberCont.opt_hiddensticks {",
        "// FRONTIER TOUCH MOVE EDGES")
    add("scripts/InputHandling/InputHandling.gml",
        "}\n\nfunction scrSetCardinalDirectionInputs(_index) {",
        "    scrFRTouchPoll(); // FRONTIER TOUCH MENU RAW SAMPLES\n}\n\nfunction scrSetCardinalDirectionInputs(_index) {",
        "// FRONTIER TOUCH MENU RAW SAMPLES")
    anchor = 'if(_action=="okay") {'
    add("scripts/scrFrontier_core_api/scrFrontier_core_api.gml", anchor,
        'var _fr_touch_edge=scrFRTouchMovementValue(_index,_action,_prefix); // FRONTIER TOUCH SOURCE EDGES\n'
        '    if(!is_undefined(_fr_touch_edge)) return _fr_touch_edge;\n    ' + anchor,
        "// FRONTIER TOUCH SOURCE EDGES")
    anchor = "function fr_dependencies_libMenu_mod_gml_menubutton_check() {"
    add(source_script("dependencies/libMenu.mod.gml"), anchor,
        anchor + '\n    if(scrFRMenuTouchOwns()) return scrFRMenuTouchCheck(argument[0],argument[1],argument[2],argument[3],\n'
        '        argument_count>4?argument[4]:0,argument_count>5?argument[5]:0,argument_count>6?argument[6]:undefined); // FRONTIER REAL TOUCH MENU',
        "// FRONTIER REAL TOUCH MENU")
    for name in ("blinklengthfix", "blink50fix"):
        anchor = "var _frl_" + name + " = undefined;"
        add(source_script("Mutations/AugmentExtraFeet.skill.gml"), anchor,
            "var _frl_" + name + " = 0; // FRONTIER TOUCH DASH INITIAL " + name,
            "// FRONTIER TOUCH DASH INITIAL " + name)
    anchor = "function scrFRPromptHUDTests() {"
    add("scripts/scrFrontier_prompt_hud_tests/scrFrontier_prompt_hud_tests.gml", anchor,
        anchor + "\n    scrFRInputTouchTests(); // FRONTIER ACTUAL TOUCH INPUT FIXTURE",
        "// FRONTIER ACTUAL TOUCH INPUT FIXTURE")
    return hooks


def apply(project):
    project = Path(project).resolve()
    changed, report = {}, []
    for hook in hook_specs():
        path = project / hook["path"]
        text = changed.get(path, path.read_text("utf-8-sig"))
        if hook["replacement"] in text:
            report.append({"path": hook["path"], "status": "already-applied"})
            continue
        if hook["marker"] in text or text.count(hook["anchor"]) != 1:
            raise RuntimeError("Frontier input hook anchor changed: " + hook["marker"])
        changed[path] = text.replace(hook["anchor"], hook["replacement"], 1)
        report.append({"path": hook["path"], "status": "patched"})
    for path, text in changed.items():
        path.write_text(text, "utf-8", newline="\n")
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.apply) if args.apply else hook_specs(), indent=2))
