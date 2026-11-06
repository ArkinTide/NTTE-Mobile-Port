"""Connect authored Frontier unlock presentation to the native death screen.

Only the explicit staging project is modified. Original libSaves remains intact;
its step/draw callbacks are wrapped, retaining artwork, queues and confirmation.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path


def hook_specs():
    return [
        {
            "path": "scripts/scrNTTEFullUnlockPresentation/scrNTTEFullUnlockPresentation.gml",
            "anchor": "function scrNTTEFullUnlockPendingPortrait() {",
            "replacement": "function scrNTTEFullUnlockPendingPortrait() {\n"
                           "    if(scrFRUnlockPendingPortrait()) return true; // FRONTIER UNLOCK DEATH GATE",
            "marker": "// FRONTIER UNLOCK DEATH GATE",
        },
        {
            "path": "scripts/scrFrontierModules/scrFrontierModules.gml",
            "anchor": '"UnlockCont_step":fr_dependencies_libSaves_mod_gml_UnlockCont_step',
            "replacement": '"UnlockCont_step":scrFRUnlockStep',
            "marker": '"UnlockCont_step":scrFRUnlockStep',
        },
        {
            "path": "scripts/scrFrontierModules/scrFrontierModules.gml",
            "anchor": '"UnlockCont_draw":fr_dependencies_libSaves_mod_gml_UnlockCont_draw',
            "replacement": '"UnlockCont_draw":scrFRUnlockDraw',
            "marker": '"UnlockCont_draw":scrFRUnlockDraw',
        },
        {
            "path": "objects/GameOver/Create_0.gml",
            "anchor": "scrLetterbox(true)",
            "replacement": "// FRONTIER LATE UNLOCK DEATH GATE\n"
                           "if(scrFRUnlockPendingPortrait()) {instance_destroy();exit;}\n"
                           "scrLetterbox(true)",
            "marker": "// FRONTIER LATE UNLOCK DEATH GATE",
        },
    ]


def apply(project):
    project = Path(project).resolve()
    changed = {}
    report = []
    for hook in hook_specs():
        path = project / hook["path"]
        source = changed.get(path, path.read_text("utf-8-sig"))
        if hook["replacement"] in source:
            report.append({"path": hook["path"], "marker": hook["marker"], "status": "already-applied"})
            continue
        if hook["marker"] in source or source.count(hook["anchor"]) != 1:
            raise RuntimeError("Frontier unlock hook anchor changed: " + hook["marker"])
        changed[path] = source.replace(hook["anchor"], hook["replacement"], 1)
        report.append({"path": hook["path"], "marker": hook["marker"], "status": "patched"})
    for path, source in changed.items():
        path.write_text(source, "utf-8", newline="\n")
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.apply) if args.apply else hook_specs(), ensure_ascii=True, indent=2))
