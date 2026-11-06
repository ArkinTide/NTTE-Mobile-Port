"""Explicit staging installer for the native Frontier race and hidden skins."""
from __future__ import annotations

import argparse
import copy
import hashlib
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]


def hook_specs():
    races = "scripts/scrRaces/scrRaces.gml"
    native = "scripts/scrNTTEFullRaceNative/scrNTTEFullRaceNative.gml"
    skins = "scripts/scrNTTEFullSkinNative/scrNTTEFullSkinNative.gml"
    main_source = "Frontier_Main.mod.gml"
    main_script = "frCode_" + re.sub(r"\W", "_", Path(main_source).stem)[:38] + "_" + hashlib.sha256(main_source.encode()).hexdigest()[:10]
    main = "scripts/" + main_script + "/" + main_script + ".gml"
    hooks = []

    def start(path, signature, code, label):
        insertion = "\n    // BEGIN FRONTIER " + label + "\n    " + code + "\n    // END FRONTIER " + label + "\n"
        hooks.append({"path": path, "anchor": signature, "replacement": signature + insertion,
                      "marker": "// BEGIN FRONTIER " + label})

    start(races, "function scr_race_is_unlocked(_race) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceAvailable();", "RACE AVAILABLE")
    start(races, "function scr_race_set_unlocked(_race, _unlocked = true) {",
          "if(scrFRRaceIs(_race)) {scrFRRaceUnlockSet(_unlocked);return;}", "RACE UNLOCK SET")
    start(races, "function scr_race_is_skin_unlocked(_race, _skin = 1) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceSkinAvailable(_skin);\n    if(scrFRSkinMatches(_race,_skin)) return true;", "RACE SKIN AVAILABLE")
    start(races, "function scr_race_set_skin_unlocked(_race, _skin=SkinLetter.B, _unlock=true) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceUnlockSet(_unlock,_skin);\n    if(scrFRSkinMatches(_race,_skin)) return true;", "RACE SKIN UNLOCK SET")
    start(races, "function scr_race_get_sprite(_race, _sprite_name, _default = -1, _skin = SkinLetter.A) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceNativeSprite(_sprite_name,_skin,_default);\n    if(scrFRSkinMatches(_race,_skin)) return scrFRSkinRaceSprite(_race,_skin,_sprite_name,_default);", "RACE BODY SPRITE")
    start(races, "function scr_race_get_sound(_race, _sound_name, _default = -1) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceNativeSound(_sound_name,_default);", "RACE VOICE")
    start(races, "function scr_race_get_skin_subimage(_race, _skin) {",
          "if(scrFRRaceIs(_race)) return clamp(_skin,0,1);\n    if(scrFRSkinMatches(_race,_skin)) return 0;", "RACE MENU SUBIMAGE")
    start(races, "function scrRaceGetStringID(_race_number_id, _capitalization = false) {",
          'if(scrFRRaceIs(_race_number_id)) return _capitalization?"Bubbles":"bubbles";', "RACE STRING ID")
    start(races, "function scrRaceGetNumericID(_race_string_id) {",
          "if(scrFRRaceIs(_race_string_id)) return 19;", "RACE NUMERIC ID")
    for function, kind in [("scrRaceGetName", "name"), ("scrRaceGetPassiveSkillDescription", "passive"),
                           ("scrRaceGetActiveSkillDescription", "active"), ("scrRaceGetThroneButtDescription", "thronebutt"),
                           ("scrRaceGetUnlockDescription", "lock"), ("scrRaceGetUnlockCauseText", "unlock")]:
        start(races, f"function {function}(_race) {{",
              f'if(scrFRRaceIs(_race)) return scrFRRaceText("{kind}");', "RACE TEXT " + kind.upper())
    for function, kind in [("scrRaceGetSkinUnlockDescription", "skin_lock"), ("scrRaceGetSkinUnlockCauseText", "skin_unlock")]:
        start(races, f"function {function}(_race, _skin_id) {{",
              f'if(scrFRRaceIs(_race)) return scrFRRaceText("{kind}",_skin_id);', "RACE TEXT " + kind.upper())
    start(races, "function scrRaceGetStarterWeapon(_race) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceStarterWeapon();", "RACE STARTER")
    start(races, "function scrRaceGetMaxSkinCount(_race, _show_secret=false) {",
          "if(scrFRRaceIs(_race)) return 2;", "RACE SKIN COUNT")
    for function, kind in [("scrRaceGetUltraSkillName", "ultra_name"), ("scrRaceGetUltraSkillText", "ultra_text")]:
        start(races, f"function {function}(_race, _ultra) {{",
              f'if(scrFRRaceIs(_race)) return scrFRRaceText("{kind}",_ultra);', "RACE TEXT " + kind.upper())
    start(races, "function scrRaceGetUltraSkillSound(_race, _ultra) {",
          'if(scrFRRaceIs(_race)) return scrFRRaceVar(_ultra==1?"sndBubblesUltraA":"sndBubblesUltraB");', "RACE ULTRA SOUND")
    start("scripts/scrUltras/scrUltras.gml", "function scr_ultra_set(_race, _ultra, _value) {",
          "if(scrFRRaceIs(_race)) {scrFRUltraSet(_race,_ultra,_value);return;}", "RACE ULTRA SET")
    start(native, "function scrNTTEFullRaceMenuSprite(_race,_skin,_sprite) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceMenuSprite(_skin,_sprite);", "RACE MENU ART")
    start(native, "function scrNTTEFullRaceSelectSprite(_race,_unlocked,_default) {",
          'if(scrFRRaceIs(_race)) return scrFRRaceNativeSprite("Select");', "RACE SELECT ART")
    start(native, "function scrNTTEFullRaceSelectFrame(_race,_unlocked) {",
          "if(scrFRRaceIs(_race)) return !_unlocked;", "RACE SELECT FRAME")
    start("scripts/scrNTTEFullRaceMenuDecorationNative/scrNTTEFullRaceMenuDecorationNative.gml",
          "function scrNTTEFullRaceNewMarker(_icon,_hover=false) {",
          "if(scrFRRaceSelectMarkerOwned(_icon)) return scrFRRaceSelectMarker(_icon,_hover);", "RACE SELECT NEW MARKER")
    for name in ["new", "robot"]:
        start(main, "function fr_Frontier_Main_mod_gml_CharSelect_draw_" + name + "(_frl__inst=undefined) {",
              "if(scrFRRaceSelectMarkerOwned(_frl__inst)) {scrFRInstanceDestroy();return;}", "NATIVE SELECT OVERLAY " + name.upper())
    start(native, "function scrNTTEFullRaceUltraDraw(_icon,_x,_y) {",
          "if(scrFRRaceIs(_icon div 3)) {draw_sprite(scrFRRaceUltraSprite((_icon mod 3)+1,true),0,_x,_y);return;}", "RACE ULTRA HUD")
    start(native, "function scrNTTEFullRaceTip(_race) {",
          'if(scrFRRaceIs(_race)) return scrFRRaceCall("race_ttip");', "RACE TIPS")
    start(skins, "function scrNTTEFullSkinMenuSprite(_race,_skin,_sprite) {",
          "if(scrFRRaceIs(_race)) return scrFRRaceMenuSprite(_skin,_sprite);\n    if(scrFRSkinMatches(_race,_skin)) return scrFRSkinSprite(_skin,_sprite);", "HIDDEN SKIN MENU")
    start(skins, "function scrNTTEFullSkinRaceSprite(_race,_skin,_kind,_default) {",
          "if(scrFRSkinMatches(_race,_skin)) return scrFRSkinRaceSprite(_race,_skin,_kind,_default);", "HIDDEN SKIN BODY")
    start(skins, 'function scrNTTEFullSkinTargetSprite(_target,_sprite,_mode="weapon") {',
          'var _fr_race=scrNTTEFullValue(_target,"race",-1),_fr_skin=scrNTTEFullValue(_target,"bskin",scrNTTEFullValue(_target,"skin",0));\n    if(scrFRSkinMatches(_fr_race,_fr_skin)) return scrFRSkinSprite(_fr_skin,_sprite);', "HIDDEN SKIN TARGET")
    start("scripts/scrNTTEFullPetGuardianActive/scrNTTEFullPetGuardianActive.gml",
          "function scrNTTEFullPetGuardianActive() {",
          "scrFRRaceGuardianActive();", "GUARDIAN RACE ABILITY")

    def replace(path, anchor, replacement, label):
        hooks.append({"path": path, "anchor": anchor, "replacement": replacement, "marker": label})

    for name in ["new", "robot"]:
        replace(main, "scrFRBindDraw(fr_Frontier_Main_mod_gml_CharSelect_draw_" + name + ", (depth - 1), scrFRSelf(self));",
                "{} // FRONTIER NATIVE SELECT MARKER " + name.upper(), "FRONTIER NATIVE SELECT MARKER " + name.upper())
    replace(races, "NUM_ALL_RACE_TYPES = 19,", "NUM_ALL_RACE_TYPES = 20, // FRONTIER BUBBLES ID 19", "FRONTIER BUBBLES ID 19")
    replace(native, 'assert(Race.NUM_ALL_RACE_TYPES==19,"Native race count excludes additional identities")',
            'assert(Race.NUM_ALL_RACE_TYPES>=20,"Native race count excludes additional identities") // FRONTIER RACE COUNT', "FRONTIER RACE COUNT")
    replace("scripts/scrPlayerCreate/scrPlayerCreate.gml", "\tscrNTTEFullRaceNativeChange()",
            "\tscrNTTEFullRaceNativeChange()\n    scrFRRacePlayerChange(); // FRONTIER PLAYER CREATE", "FRONTIER PLAYER CREATE")
    replace("scripts/scrSavegame/scrSavegame.gml", "                scrNTTEFullRaceNativeAfterLoad();",
            "                scrNTTEFullRaceNativeAfterLoad();\n                scrFRRacePlayerAfterLoad(); // FRONTIER PLAYER RESTORE", "FRONTIER PLAYER RESTORE")
    replace("objects/Player/Step_2.gml", "scrNTTEFullTridentPlayerEndStep();",
            "scrNTTEFullTridentPlayerEndStep();\nscrFRRacePlayerEndStep(); // FRONTIER PLAYER STEP", "FRONTIER PLAYER STEP")
    replace("scripts/scrCampfireMenuCreate/scrCampfireMenuCreate.gml", "if(_skin_id>=200 || scrNTTEFullRaceNumeric(_race)>=0) {",
            "if(_skin_id>=200 || scrNTTEFullRaceNumeric(_race)>=0 || scrFRRaceIs(_race)) { // FRONTIER SKIN BUTTON", "FRONTIER SKIN BUTTON")
    replace("scripts/PlayerInstance/PlayerInstance.gml", "_pinst.cwep = scrRaceGetStarterWeapon(_pinst.race)",
            "_pinst.cwep = scrFRRaceIs(_pinst.race) ? scrFRRaceStarterWeapon(_pinst.skin):scrRaceGetStarterWeapon(_pinst.race) // FRONTIER PLAYER STARTER", "FRONTIER PLAYER STARTER")
    replace("scripts/PlayerInstance/PlayerInstance.gml", "        with scrPlayerCreate(_pinst.index, _pinst.race, _pinst.skin) {",
            "        // FRONTIER SKIN STARTER: changing A/B must retain each player's own starter.\n        if(scrFRRaceIs(_pinst.race) && (_pinst.cwep==FR_BUBBLES_CUTLASS || _pinst.cwep==FR_BUBBLES_SHOVEL)) _pinst.cwep=scrFRRaceStarterWeapon(_pinst.skin);\n        with scrPlayerCreate(_pinst.index, _pinst.race, _pinst.skin) {", "FRONTIER SKIN STARTER")
    replace("scripts/scrCampfireMenuCreate/scrCampfireMenuCreate.gml", "_pinst.cwep = scrRaceGetStarterWeapon(_race)",
            "_pinst.cwep = scrFRRaceIs(_race) ? scrFRRaceStarterWeapon(_pinst.skin):scrRaceGetStarterWeapon(_race) // FRONTIER SELECT STARTER", "FRONTIER SELECT STARTER")
    replace("scripts/scrCampfireMenuCreate/scrCampfireMenuCreate.gml", "var _default_weapon = scrRaceGetStarterWeapon(_race),",
            "var _default_weapon = scrFRRaceIs(_race) ? scrFRRaceStarterWeapon(_pinst.skin):scrRaceGetStarterWeapon(_race), // FRONTIER LOADOUT STARTER", "FRONTIER LOADOUT STARTER")
    anchor = '    draw_sprite_ext(_ntte_race>=0 ? scrNTTEFullRaceSprite(race,"UltraIcon",0):sprite_index,_ntte_race>=0 ? num-1:_index,_x,_y,1,1,0,_blend,1)'
    replace("objects/UltraIcon/Draw_0.gml", anchor,
            '    if(scrFRRaceIs(race)) draw_sprite_ext(scrFRRaceUltraSprite(num),0,_x,_y,1,1,0,_blend,1); // FRONTIER ULTRA BUTTON\n    else ' + anchor.strip(), "FRONTIER ULTRA BUTTON")
    return hooks


def _load(path):
    return json.loads(re.sub(r",(?=\s*[}\]])", "", path.read_text("utf-8-sig")))


def apply(project):
    project = Path(project).resolve()
    ledger = _load(ROOT / "staging/identity-ledger.json")["weapons"]
    for name, expected in [("FR_BubblesCutlass", 187), ("FR_BubblesShovel", 188)]:
        if ledger.get("weapon:" + name) != expected:
            raise RuntimeError("Frontier Bubbles early starter identity changed: " + name)
    yyp = project / "nuclearthronemobile.yyp"
    data = _load(yyp)
    # Validate every anchor before making any modification to the project.
    changed = {}
    report = {"script": "scrFRRaces", "hooks": []}
    for hook in hook_specs():
        path = project / hook["path"]
        source = changed.get(path, path.read_text("utf-8-sig"))
        if hook["replacement"] in source:
            report["hooks"].append({"marker": hook["marker"], "status": "already-applied"})
            continue
        if hook["marker"] in source or source.count(hook["anchor"]) != 1:
            raise RuntimeError("Frontier race hook anchor changed: " + hook["marker"])
        changed[path] = source.replace(hook["anchor"], hook["replacement"], 1)
        report["hooks"].append({"marker": hook["marker"], "status": "patched"})
    for path, source in changed.items():
        path.write_text(source, "utf-8")
    script = copy.deepcopy(_load(project / "scripts/scr_hit/scr_hit.yy"))
    script["name"] = script["%Name"] = "scrFRRaces"
    path = "scripts/scrFRRaces/scrFRRaces.yy"
    directory = (project / path).parent
    directory.mkdir(parents=True, exist_ok=True)
    (project / path).write_text(json.dumps(script, ensure_ascii=False, indent=2) + "\n", "utf-8")
    (directory / "scrFRRaces.gml").write_text((ROOT / "native/races.gml").read_text("utf-8"), "utf-8")
    if not any(item["id"]["path"] == path for item in data["resources"]):
        data["resources"].append({"id": {"name": "scrFRRaces", "path": path}})
    yyp.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", "utf-8")
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--apply", type=Path, help="Explicit staging project to modify")
    args = parser.parse_args()
    print(json.dumps(apply(args.apply) if args.apply else hook_specs(), ensure_ascii=True, indent=2))
