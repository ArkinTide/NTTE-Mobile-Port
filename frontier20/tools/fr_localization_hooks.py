"""Localize Frontier actor names at native presentation boundaries only."""
from __future__ import annotations

import argparse
import json
from pathlib import Path


def hook_specs():
    return [{
        "path":"scripts/scrNTTEFullUnlockPresentation/scrNTTEFullUnlockPresentation.gml",
        "anchor":"function scrNTTEFullEnemyDisplayName(_inst) {\n    var _raw=scrNTTEFullEnemyName(_inst)\n",
        "replacement":"function scrNTTEFullEnemyDisplayName(_inst) {\n    var _raw=scrNTTEFullEnemyName(_inst)\n"
                      "    if(instance_exists(_inst) && _inst.object_index==FRCustomEnemy) "
                      "return scrFRLocalize(_raw); // FRONTIER ACTOR DISPLAY NAME\n",
        "marker":"// FRONTIER ACTOR DISPLAY NAME",
    },{
        "path":"scripts/scrNTTEFullUnlockPresentation/scrNTTEFullUnlockPresentation.gml",
        "anchor":"function scrNTTEFullAnnihilationEntryDisplay(_entry) {\n    var _raw=string_upper(_entry.text)\n",
        "replacement":"function scrNTTEFullAnnihilationEntryDisplay(_entry) {\n    var _raw=string_upper(_entry.text)\n"
                      "    if(string_pos(\"FRCustom\",_entry.object_name)==1) "
                      "return scrFRLocalize(_raw); // FRONTIER ANNIHILATION DISPLAY NAME\n",
        "marker":"// FRONTIER ANNIHILATION DISPLAY NAME",
    }]


def apply(project):
    project=Path(project).resolve()
    report=[]
    pending={}
    for hook in hook_specs():
        path=project/hook["path"]
        source=pending.get(path,path.read_text("utf-8-sig"))
        if hook["replacement"] in source:
            report.append({"path":hook["path"],"status":"already-applied"})
            continue
        if hook["marker"] in source or source.count(hook["anchor"])!=1:
            raise RuntimeError("Frontier localization anchor changed: "+hook["marker"])
        pending[path]=source.replace(hook["anchor"],hook["replacement"],1)
        report.append({"path":hook["path"],"status":"patched"})
    for path,source in pending.items():
        path.write_text(source,"utf-8",newline="\n")
    return report


if __name__=="__main__":
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply",type=Path)
    args=parser.parse_args()
    print(json.dumps(apply(args.apply) if args.apply else hook_specs(),indent=2))
