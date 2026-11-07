"""Keep the initialized Frontier runtime across native pause and new runs.

The host still owns suspension and resumption. Only the persistent registry
controller and libGlobal storage remain active; source simulation stays gated.
"""
from __future__ import annotations

import json
from pathlib import Path


def apply(project):
    project = Path(project).resolve()
    writes = {}
    specs = [
        ("objects/UberCont/Create_0.gml",
         "if(!instance_exists(FRWorld)) instance_create(0,0,FRWorld);",
         "scrFRWorldEnsure(); // FRONTIER OWNED PERSISTENT BOOT"),
        ("objects/UberCont/Create_0.gml",
         "scrFRWorldEnsure(); // FRONTIER OWNED PERSISTENT BOOT",
         'if(scrFRRestartTestsColdRequested()) '
         'scrFRRestartTestsColdSelectProbe(); // FRONTIER COLD SELECT ACCEPTANCE\n'
         "scrFRWorldEnsure(); // FRONTIER OWNED PERSISTENT BOOT"),
        ("objects/UberCont/Step_1.gml", "\t\t    instance_deactivate_all(true)",
         "\t\t    scrFRPausePrepare(); // FRONTIER CAPTURE LIVE LIBRARY\n"
         "\t\t    instance_deactivate_all(true)\n"
         "\t\t    scrFRPauseKeepAlive(); // FRONTIER PAUSED REGISTRY\n"
         "\t\t    if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrFRLifecycleTestsPauseKeepAlive();"),
        ("scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml",
         "function scrCleanupSessionInstances() {",
         "function scrCleanupSessionInstances() {\n    scrFRSessionPrepare(); // FRONTIER SESSION RETIRE"),
        ("scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml",
         "\twith all {",
         "\twith all {\n        if(scrFRSessionPreserve(id)) continue; // FRONTIER SESSION STORAGE"),
        ("scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml",
         "\tif (variable_global_exists(\"debugclear_restore\")) global.debugclear_restore = undefined",
         "\tif (variable_global_exists(\"debugclear_restore\")) global.debugclear_restore = undefined\n"
         "    scrFRSessionRetired(); // FRONTIER RETIRED CONTINUATIONS"),
        ("objects/SitDown/Alarm_0.gml", "with all {",
         "scrFRSessionPrepare(); // FRONTIER VICTORY SESSION RETIRE\n"
         "with all {\n    if(scrFRSessionPreserve(id)) continue; // FRONTIER VICTORY STORAGE"),
        ("objects/SitDown/Alarm_0.gml", "instance_create(0, 0, Credits)",
         "scrFRSessionRetired(true); // FRONTIER VICTORY RETIRED CONTINUATIONS\n"
         "instance_create(0, 0, Credits)"),
        ("objects/BackButton/Other_10.gml", "\t    with all {",
         "\t    scrFRSessionPrepare(); // FRONTIER MENU SESSION RETIRE\n"
         "\t    with all {\n            if(scrFRSessionPreserve(id)) continue; // FRONTIER MENU STORAGE"),
        ("objects/BackButton/Other_10.gml", "\t\tscr_camera_set_position(0, 0)",
         "\t\tscrFRSessionRetired(); // FRONTIER MENU RETIRED CONTINUATIONS\n"
         "\t\tscr_camera_set_position(0, 0)"),
    ]
    for relative, before, after in specs:
        path = project / relative
        text = writes.get(path, path.read_text(encoding="utf-8-sig"))
        if after in text:
            continue
        # An incremental stage may still have the earlier post-deactivation
        # block. Replace it as one unit before adding the pre-pause capture.
        if relative == "objects/UberCont/Step_1.gml":
            prior = (before + "\n"
                     "\t\t    scrFRPauseKeepAlive(); // FRONTIER PAUSED REGISTRY\n"
                     "\t\t    if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrFRLifecycleTestsPauseKeepAlive();")
            if prior in text:
                assert text.count(prior) == 1, (relative, "Frontier lifecycle anchor changed")
                writes[path] = text.replace(prior, after, 1)
                continue
        if relative == "objects/UberCont/Create_0.gml" and "COLD SELECT ACCEPTANCE" in after:
            prior = ('if(os_type==os_windows && scrNTTEFullSmokeEnabled() && '
                     'scrNTTEFullSmokeAsyncCase("FrontierRestartTests")) '
                     'scrFRRestartTestsColdSelectProbe(); // FRONTIER COLD SELECT ACCEPTANCE\n' + before)
            if prior in text:
                assert text.count(prior) == 1, (relative, "Frontier cold select anchor changed")
                writes[path] = text.replace(prior, after, 1)
                continue
        assert text.count(before) == 1, (relative, "Frontier lifecycle anchor changed")
        writes[path] = text.replace(before, after, 1)

    world = project / "objects/FRWorld"
    model_path = world / "FRWorld.yy"
    model = json.loads(model_path.read_text(encoding="utf-8-sig"))
    if not any(e["eventType"] == 12 and e["eventNum"] == 0 for e in model["eventList"]):
        model["eventList"].append({
            "$GMEvent": "v1", "%Name": "", "collisionObjectId": None,
            "eventNum": 0, "eventType": 12, "isDnD": False,
            "name": "", "resourceType": "GMEvent", "resourceVersion": "2.0",
        })
    for event, hook in (("Draw_0.gml", "draw"), ("Draw_64.gml", "draw_gui"), ("Draw_73.gml", "draw_gui_end")):
        path = world / event
        before = f'scrFRHook("{hook}",[]);'
        after = f'scrFRWorldDraw("{hook}");'
        text = path.read_text(encoding="utf-8-sig")
        assert after in text or text.count(before) == 1, (event, "Frontier world draw anchor changed")
        writes[path] = text if after in text else text.replace(before, after, 1)
    writes[world / "CleanUp_0.gml"] = "scrFRWorldCleanup();\n"
    for path, text in writes.items():
        path.write_text(text, encoding="utf8", newline="\n")
    model_path.write_text(json.dumps(model, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
    return {"runtime_owner": True, "pause_simulation": False,
            "active_storage": ["FRWorld", "libGlobal"], "session_storage": ["FRWorld", "libGlobal"]}
