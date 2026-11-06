"""Install source-owned Frontier area callbacks in native world consumers.

Importing this module performs no edits. The caller selects a project copy.
"""
from pathlib import Path
import re


def _path(project, folder):
    return Path(project) / "scripts" / folder / (folder + ".gml")


def _insert(path, anchor, insertion, report, before=False):
    source = path.read_text("utf-8-sig")
    replacement = insertion + anchor if before else anchor + insertion
    if replacement in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier area consumer anchor changed: {path}: {anchor}")
    path.write_text(source.replace(anchor, replacement, 1), "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def _replace(path, anchor, replacement, report):
    source = path.read_text("utf-8-sig")
    if replacement in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier area consumer anchor changed: {path}: {anchor}")
    path.write_text(source.replace(anchor, replacement, 1), "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def _generation_finalize(path, report):
    """Own one ordered source-start/Continue-restore lifecycle boundary.

    Both installers previously inserted immediately before the same native
    comment. Each separated the other's insertion from its anchor, so every
    rebuild added another pair and restored the checkpoint before level_start.
    Normalize those exact legacy statements too, for existing stage copies.
    """
    source = path.read_text("utf-8-sig")
    anchor = "// Complete authored placement before creating static exterior collision."
    block = ("// BEGIN FRONTIER GENERATION FINALIZE\n"
             "scrFRGenerationLevelStart();\n"
             "scrFRContinueGenerationEnd();\n"
             "// END FRONTIER GENERATION FINALIZE\n")
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier finalization anchor changed: {path}")
    clean = re.sub(r"(?m)^// (?:BEGIN|END) FRONTIER GENERATION FINALIZE\r?\n", "", source)
    clean = re.sub(r"(?m)^[ \t]*scrFR(?:GenerationLevelStart|ContinueGenerationEnd)\(\);[ \t]*\r?\n?", "", clean)
    updated = clean.replace(anchor, block + anchor, 1)
    if updated == source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    path.write_text(updated, "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def apply(project):
    """Patch exact real generation, terrain and transition consumption sites."""
    report = []
    script_hooks = [
        ("scrNTTEFullLairWorld", "function scrNTTEFullPortalBlocked() {",
         '\n    if(scrFRAreaPortalBlocked()) return true;\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaInfo(_key) {",
         '\n    var _fr_area=scrFRAreaInfo(_key);\n'
         '    if(!is_undefined(_fr_area)) return _fr_area;\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaKey(_area) {",
         '\n    if(scrFRAreaActive(_area)) return scrFRAreaKey(_area);\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaMapLabel(_area,_subarea) {",
         '\n    var _fr_label=scrFRAreaLabel(_area,_subarea);\n'
         '    if(!is_undefined(_fr_label)) return _fr_label;\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaFloorSprite(_area,_style=false,_explo=false) {",
         '\n    if(scrFRAreaActive(_area)) return scrFRAreaFloorSprite(_area,_style,_explo);\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaFloorSetup(_area,_explo=false) {",
         '\n    if(scrFRAreaFloorSetup(_area,_explo)) return;\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaDetailSprite(_area) {",
         '\n    if(scrFRAreaActive(_area)) return scrFRAreaSprite(_area,sprDetail1);\n'),
        ("scrNTTEFullAreas", "function scrNTTEFullAreaWallSprite(_area,_part) {",
         '\n    if(scrFRAreaActive(_area)) return scrFRAreaWallSprite(_area,_part);\n'),
        ("scrNTTEFullLairPopulation", "function scrNTTEFullAreaPopEnemies(_area) {",
         '\n    if(scrFRAreaPopEnemies(_area)) return true;\n'),
        ("scrNTTEFullLairPopulation", "function scrNTTEFullAreaPopProps(_area) {",
         '\n    if(scrFRAreaPopProps(_area)) return true;\n'),
        ("scrNTTEFullMusic", "function scrNTTEFullMusicArea() {",
         '\n    if(scrFRAreaMusic()) return true;\n'),
        ("scrNTTEFullRoadmapNative", "function scrNTTEFullRoadmapStep(_waypoint,_last,_warps) {",
         '\n    var _fr_roadmap=scrFRAreaRoadmap(_waypoint,_last);\n'
         '    if(!is_undefined(_fr_roadmap)) return _fr_roadmap;\n'),
        ("scrArea", "function scrAreaGetGenerationGoal() {",
         '\n    if(instance_exists(GameCont) && scrFRAreaActive(GameCont.area))\n'
         '        return scrFRAreaMetadata(GameCont.area,"area_goal",110);\n'),
        ("scrArea", "function scrAreaGetName(_area, _macrolike_format=false) {",
         '\n    var _fr_name=scrFRAreaDebugName(_area);\n'
         '    if(!is_undefined(_fr_name)) return _macrolike_format\n'
         '        ? string_replace_all(string_lower(_fr_name)," ","_"):_fr_name;\n'),
    ]
    for folder, anchor, insertion in script_hooks:
        _insert(_path(project, folder), anchor, insertion, report)
    # This flag belongs to the native tip consumer, so retain its guard and
    # mark Frontier tips initialized through the same path.
    _insert(_path(project, "scrNTTEFullLoadingTipsNative"),
            '_gen.ntte_loading_tips_setup=true;_gen.tip_ntte=""',
            '\n    if(scrFRAreaTip(_gen)) return true;\n', report)
    # A later explicit NativeInit must retain the registered custom builders.
    _insert(_path(project, "scrNTTEFullInRoomGeneration"),
            'function scrNTTEFullAreaNativeInit() {',
            '\n    if(variable_global_exists("fr_area_ids")) scrFRRegisterAreas();\n', report)
    # NTT callbacks read the original spawn and exclusion radius directly
    # from GenCont. Publish native equivalents before area/event setup; the
    # normal async and synchronous Create paths share this lifecycle edge.
    _insert(Path(project) / "objects/GenCont/Create_0.gml",
            'scrNTTEFullAreaGeneratorPrepare();',
            'scrFRGenerationMetadataSetup();\n', report, before=True)
    _insert(Path(project) / "objects/GenCont/Create_0.gml",
            'scrNTTEFullAreaGeneratorPrepare();',
            '\nscrFRGenerationEventsSetup();\n', report)
    _generation_finalize(Path(project) / "objects/GenCont/Destroy_0.gml", report)
    event = Path(project) / "objects/GameCont/Other_5.gml"
    _insert(event, 'var _ntte_destination=scrNTTEFullAreaTakeDestination();',
            '// Frontier source finish queues its actual next destination.\n'
            'scrFRAreaFinish();\n', report, before=True)
    _insert(event, 'if(is_struct(_ntte_destination)) {',
            '\n    scrFRAreaConsumeEntry(_ntte_destination);\n', report)
    _insert(event, 'hard += scrGameIsHardmode() ? 2 : 1',
            '// Frontier transit sees the resolved destination and old departure.\n'
            'scrFRAreaTransit();\n\n', report, before=True)
    debug = _path(project, "scr_create_debug_overlay_views")
    _insert(debug, 'array_push(_area_list, area_hq)',
            '\n\t\t_area_list=scrFRAreaDebugAreas(_area_list)', report)
    _replace(debug, '_subareas = scrAreaGetMaxSubarea(_area),',
             '_subareas = scrFRAreaDebugSubareas(_area),', report)
    _replace(debug, '_has_secret = true',
             '_has_secret = !scrFRAreaDebugCustom(_area)', report)
    _insert(debug, '\t\t\t\twith (GameCont) {',
            '\n\t\t\t\t\tscrFRAreaDebugClearDestination()', report)
    console = _path(project, "handle_console_command")
    _insert(console, '            case "area":',
            '\n                if(scrFRAreaDebugConsole(cmd)) break;', report)
    _insert(console, '                    GameCont.route = 0',
            '                    scrFRAreaDebugClearDestination();\n', report, before=True)
    _insert(console,
            'var _areas = [0, 1, 2, 3, 4, 5, 6, 7, 100, 101, 102, 103, 104, 105, 106, 107]',
            '\n\t\t\t\t_areas=scrFRAreaDebugAreas(_areas)', report)
    _replace(console, '_nsub = scrAreaGetMaxSubarea(_ar)',
             '_nsub = scrFRAreaDebugSubareas(_ar)', report)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.project), ensure_ascii=True, indent=2))
