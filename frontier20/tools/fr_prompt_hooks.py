"""Expose the authored LibPrompt selection in the native interaction HUD.

The source library keeps ownership of pick dispatch and its overlap selector.
Only an explicitly selected staging project is modified.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path


def hook_specs():
    return [{
        "path": "scripts/scrDrawPlayerHUD/scrDrawPlayerHUD.gml",
        "anchor": "    draw_align(fa_center,fa_top);\n\twith (_player) array_foreach(",
        "replacement": "    draw_align(fa_center,fa_top);\n"
                       "    if(scrFRPromptHUD(_player)) return; // FRONTIER SOURCE PROMPT HUD\n"
                       "\twith (_player) array_foreach(",
        "marker": "// FRONTIER SOURCE PROMPT HUD",
    }, {
        "path": "scripts/scrNTTEFullPrompt/scrNTTEFullPrompt.gml",
        "anchor": "    return _winner\n}\nfunction scrNTTEFullPromptPlayerStep() {",
        "replacement": "    return scrFRPromptWinner(_player,_winner,_depth,_distance) // FRONTIER SHARED PROMPT WINNER\n"
                       "}\nfunction scrNTTEFullPromptPlayerStep() {",
        "marker": "// FRONTIER SHARED PROMPT WINNER",
    }, {
        "path": "scripts/scrNTTEFullPrompt/scrNTTEFullPrompt.gml",
        "anchor": "    if(instance_exists(_winner)) {\n        _winner.nearwep=_winner",
        "replacement": "    if(instance_exists(_winner) && !scrFRPromptIs(_winner)) { // FRONTIER SOURCE OWNS PICK\n"
                       "        _winner.nearwep=_winner",
        "marker": "// FRONTIER SOURCE OWNS PICK",
    }, {
        "path": "objects/ButtonAct/Other_10.gml",
        "anchor": "\n/*if volume_control_command {",
        "replacement": "\nscrFRPromptCapturePick(global.index); // FRONTIER KEEP TOUCH PICK EDGE\n"
                       "\n/*if volume_control_command {",
        "marker": "// FRONTIER KEEP TOUCH PICK EDGE",
    }, {
        "path": "scripts/scrFrontierModules/scrFrontierModules.gml",
        "anchor": '"late_step":fr_dependencies_libGeneral_mod_gml_late_step',
        "replacement": '"late_step":scrFRPromptLateStep',
        "marker": '"late_step":scrFRPromptLateStep',
    }]


def apply(project):
    project = Path(project).resolve()
    report = []
    changed = {}
    for hook in hook_specs():
        path = project / hook["path"]
        source = changed.get(path,path.read_text("utf-8-sig"))
        if hook["replacement"] in source:
            report.append({"path": hook["path"], "status": "already-applied"})
            continue
        if hook["marker"] in source or source.count(hook["anchor"]) != 1:
            raise RuntimeError("Frontier prompt hook anchor changed: " + hook["marker"])
        changed[path]=source.replace(hook["anchor"],hook["replacement"],1)
        report.append({"path": hook["path"], "status": "patched"})
    for path,source in changed.items():
        path.write_text(source,"utf-8",newline="\n")
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.apply) if args.apply else hook_specs(), indent=2))
