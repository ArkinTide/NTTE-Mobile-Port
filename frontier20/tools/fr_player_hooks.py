"""Exact native controller compatibility hooks, applied only to Frontier stage."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def hook_specs():
    return [
        {"path": "objects/Player/Create_0.gml", "anchor": "scrNTTEFullAnglerTrailEnsure();",
         "code": "scrFRPlayerCompatInit();", "label": "LEGACY PLAYER STATE"},
        {"path": "objects/GameCont/Create_0.gml", "anchor": "scrAmmoInit()",
         "code": "scrFRPlayerCompatGameInit();", "label": "LEGACY CONTROLLER STATE"},
        {"path": "objects/GameCont/Step_0.gml", "anchor": "max_rad = max(1, level) * 60 * _mult",
         "code": "max_rad=scrFRPlayerCompatRadMax(max_rad);", "label": "LEGACY RADIATION CAPACITY"},
    ]


def apply(project):
    project=Path(project).resolve()
    assert project==(ROOT/"staging/project").resolve(),"Frontier development stage only"
    changes={}
    report=[]
    for hook in hook_specs():
        path=project/hook["path"]
        source=changes.get(path,path.read_text(encoding="utf-8-sig"))
        marker="// BEGIN FRONTIER "+hook["label"]
        replacement=hook["anchor"]+"\n"+marker+"\n"+hook["code"]+"\n// END FRONTIER "+hook["label"]
        if replacement in source:
            report.append({"label":hook["label"],"status":"already-applied"});continue
        if marker in source or source.count(hook["anchor"])!=1:
            raise RuntimeError("Frontier player compatibility anchor changed: "+hook["label"])
        changes[path]=source.replace(hook["anchor"],replacement,1)
        report.append({"label":hook["label"],"status":"patched"})
    for path,source in changes.items():path.write_text(source,encoding="utf8")
    reload_path=project/"objects/Player/Step_0.gml"
    source=reload_path.read_text(encoding="utf-8-sig")
    old="var _reload_speed = 1"
    new='var _reload_speed = scrFREnabled() ? max(0.05,reloadspeed):1'
    if new in source:
        report.append({"label":"LEGACY RELOAD SPEED","status":"already-applied"})
    elif source.count(old)==1:
        reload_path.write_text(source.replace(old,new,1),encoding="utf8")
        report.append({"label":"LEGACY RELOAD SPEED","status":"patched"})
    else:
        raise RuntimeError("Frontier native reload-speed anchor changed")
    return {"hooks":report}
