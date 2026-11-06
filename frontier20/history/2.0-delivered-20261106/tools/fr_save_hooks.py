"""Native Frontier checkpoint consumers; preview never adopts a gameplay run."""
from pathlib import Path


def _insert(project, relative, anchor, insertion, report, before=False):
    path = Path(project) / relative
    source = path.read_text("utf-8-sig")
    replacement = insertion + anchor if before else anchor + insertion
    if replacement in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier save consumer anchor changed: {path}: {anchor}")
    path.write_text(source.replace(anchor, replacement, 1), "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def apply(project):
    report = []
    path = "scripts/scrSavegame/scrSavegame.gml"
    _insert(project, path, "        GameCont.ntte_full_pet_save=scrNTTEFullPetExport()",
            "        GameCont.fr_continue_save=scrFRContinueExport()\n", report, before=True)
    _insert(project, path, "\t\tscrSavegamePlayers(_buffer, true)",
            '\n        scrFRContinueImport(scrNTTEFullValue(GameCont,"fr_continue_save",undefined))\n', report)
    _insert(project, path, "\ttry {\n\t\tscrSavegameSession(_buffer, true)",
            "    global.fr_loading_save=true;\n", report, before=True)
    _insert(project, path, "\tfinally {",
            "\n        global.fr_loading_save=false;", report)
    _insert(project, path, "function scrSavegamePlayers(_buffer, _is_load) {",
            '\n    if(!_is_load && scrFREnabled()) with(Player) fr_source_weapon_save=scrFRContinuePlayerWeaponsExport();\n', report)
    _insert(project, path, '_value = self[$ _key]',
            '\n                    if(scrFREnabled()) _value=scrFRContinuePlayerNativeState(_key,_value,false);\n', report)
    _insert(project, path, 'if (_vname=="ntte_last_harpoon") _value=noone',
            '\n                        if(scrFREnabled()) _value=scrFRContinuePlayerNativeState(_vname,_value,true);\n', report)
    _insert(project, path, "                scrNTTEFullWeaponNativeAfterLoad();",
            '\n                scrFRContinuePlayerWeaponsImport();\n', report)
    path_file = Path(project) / path
    source = path_file.read_text("utf-8-sig")
    original = 'if (!is_method(_value) && scrNTTEFullBonusSaveField(_key))'
    replacement = ('if (_key!="fr_source_wep" && _key!="fr_source_bwep" '
                   '&& _key!="fr_charge_controller" && _key!="fr_charge_native_input" '
                   '&& _key!="fr_charge_primary" && _key!="fr_charge_secondary" '
                   '&& !is_method(_value) && scrNTTEFullBonusSaveField(_key))')
    if replacement not in source:
        previous = 'if (_key!="fr_source_wep" && _key!="fr_source_bwep" && !is_method(_value) && scrNTTEFullBonusSaveField(_key))'
        anchor = original if source.count(original) == 1 else previous
        if source.count(anchor) != 1:
            raise RuntimeError("Frontier source weapon save filter anchor changed")
        source = source.replace(anchor, replacement, 1)
        path_file.write_text(source, "utf-8", newline="\n")
        report.append({"file": str(path_file), "status": "patched"})
    else:
        report.append({"file": str(path_file), "status": "already-applied"})
    _insert(project, "scripts/scrNTTEFullMergedNative/scrNTTEFullMergedNative.gml",
            'var _key=_keys[_i],_entry=variable_struct_get(_value,_key)',
            '\n            if(_key=="fr_source_weapon" && scrFREnabled()) _entry=scrFRContinueWeaponEncode(_entry);\n', report)
    _insert(project, "scripts/scrNTTEFullMergedNative/scrNTTEFullMergedNative.gml",
            '    scrUGWeaponImportRebase(_data,_objects);',
            '    scrFRContinueMergedWeaponsRestore(_objects);\n', report, before=True)
    _insert(project, "objects/GenCont/Create_0.gml", "with(GameCont) scrNTTEPortalDeathReset();",
            "scrFRContinueGenerationBegin();\n", report, before=True)
    # fr_area_hooks owns the single ordered finalization boundary: source
    # level_start first, then same-room checkpoint restoration. Inserting
    # independently at its native comment duplicates the two hooks on rebuild.
    _insert(project, "scripts/scrNTTEFullInRoomGeneration/scrNTTEFullInRoomGeneration.gml",
            "        _generation.ntte_full_set_area=_set_area",
            "\n        if(_set_area) with(_generation) scrFRContinueGenerationBegin(true);\n", report)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    print(json.dumps(apply(parser.parse_args().project), ensure_ascii=True, indent=2))
