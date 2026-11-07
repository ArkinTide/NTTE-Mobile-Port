"""Idempotent Storms crown17 hooks at native menu/save/world consumers."""
from pathlib import Path


def _insert(project, relative, anchor, insertion, report, before=False):
    path = Path(project) / relative
    source = path.read_text("utf-8-sig")
    replacement = insertion + anchor if before else anchor + insertion
    if replacement in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier crown consumer anchor changed: {path}: {anchor}")
    source = source.replace(anchor, replacement, 1)
    path.write_text(source, "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def apply(project):
    report = []
    # Migrate the old always-unlocked row before the generic idempotent hook
    # checks its function anchor, avoiding a second early-return insertion.
    loadout=Path(project)/"scripts/scrNTTEFullCrownLoadoutNative/scrNTTEFullCrownLoadoutNative.gml"
    old='if(scrFRCrownKey(_crown)!="") return [scrFRCrownSprite("Loadout"),0];'
    new='if(scrFRCrownKey(_crown)!="") return [sprFRStormsLoadout,_unlocked?0:1];'
    text=loadout.read_text("utf-8-sig")
    if old in text:
        assert text.count(old)==1
        loadout.write_text(text.replace(old,new,1),"utf8",newline="\n")

    def hook(folder, anchor, insertion, before=False):
        return _insert(project, f"scripts/{folder}/{folder}.gml", anchor, insertion, report, before)

    hook("scrNTTEFullSystems", "function scrNTTEFullCrownKey(_crown) {",
         '\n    if(scrFRCrownKey(_crown)!="") return "storms";\n')
    hook("scrNTTEFullSystems", "function scrNTTEFullCrownAvailable(_crown,_loadout=false) {",
         '\n    if(scrFRCrownKey(_crown)!="") return scrFRCrownAvailable(_loadout);\n')
    hook("scrNTTEFullSystems", "    crownmax=16",
         '\n    scrFRCrownMetadataInit();\n')
    hook("scrNTTEFullSystems", 'function scrNTTEFullCrownSprite(_crown,_kind="Icon") {',
         '\n    if(scrFRCrownKey(_crown)!="") return scrFRCrownSprite(_kind);\n')
    hook("scrCrownCheck", 'function scrCrownSetCurrent(_crown, _is_start_crown = false) {',
         '\n    _crown=scrFRCrownResolve(_crown);\n')
    hook("scrCrownCheck", 'function scrCrownCheck(_crown) {',
         '\n    _crown=scrFRCrownResolve(_crown);\n')
    hook("scrNTTEFullCrownLoadoutNative", '    return _slots',
         '    if(scrFRCrownReady()) array_push(_slots,17);\n', before=True)
    hook("scrNTTEFullCrownLoadoutNative", 'function scrNTTEFullCrownLoadoutAvailable(_race,_crown) {',
         '\n    if(scrFRCrownKey(_crown)!="") return scrFRCrownLoadoutAvailable(_race);\n')
    hook("scrNTTEFullCrownLoadoutNative", '    return _count',
         '    if(scrFRCrownLoadoutAvailable(_race)) _count+=1;\n', before=True)
    hook("scrNTTEFullCrownLoadoutNative", 'function scrNTTEFullCrownLoadoutSprite(_crown,_unlocked=true) {',
         '\n    if(scrFRCrownKey(_crown)!="") return [sprFRStormsLoadout,_unlocked?0:1];\n')
    hook("scrLoadoutMenuInit", 'function scr_loadout_race_get_start_crown(_race_id) {',
         '\n    var _fr_saved=save_get_value("ccrown",_race_id,crwn_none);\n'
         '    if(_fr_saved==17) return scrFRCrownLoadoutAvailable(_race_id)?17:crwn_none;\n')
    hook("scrLoadoutMenuInit", 'function scr_loadout_race_set_start_crown(_race_id, _crown_id) {',
         '\n    if(_crown_id==17) {\n'
         '        if(!scrFRCrownLoadoutAvailable(_race_id)) return false;\n'
         '        save_set_value("ccrown",_race_id,17);return true;\n    }\n')
    hook("scrLoadoutMenuInit", 'function scr_loadout_race_is_crown_unlocked(_race_id, _crown_id) {',
         '\n    if(_crown_id==17) return scrFRCrownLoadoutAvailable(_race_id);\n')
    hook("scrLoadoutMenuInit", 'function scr_loadout_race_unlock_crown(_race_id, _crown_id) {',
         '\n    if(_crown_id==17) return scrNTTEFullUnlockSet("loadout:crown:storms",true);\n')
    hook("scrCrowns", '    // Source MOD crowns already announce their global ownership once.',
         '    if(_crown_id==17) return true;\n', before=True)
    _insert(project, 'objects/CrownObject/Alarm_2.gml', 'crown = GameCont.crown',
            '\n\nif(scrFRCrownObject()) exit;\n', report)
    _insert(project, 'objects/LevCont/Create_0.gml', '\tvar _x = view_xview + view_width / 2,',
            '    if(scrFRCrownAvailable()) array_push(_crowns,17);\n', report, before=True)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.project), ensure_ascii=True, indent=2))
