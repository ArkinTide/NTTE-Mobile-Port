"""Explicit desktop-only Frontier integration cases on isolated native saves."""
from pathlib import Path
from fr_content_hooks import ROOT, add_object, patch
from frontier_compiler import FrontierEmitter
from fr_gml_parser import definitions


def instrument_portal_storm(project):
    """Observe actual branches only in the explicit desktop test build."""
    paths=list((Path(project)/'scripts').glob('frCode_Frontier_Events_mod_*/*.gml'))
    assert len(paths)==1,paths
    path=paths[0]
    text=path.read_text(encoding='utf8')
    begin=text.index('function fr_Frontier_Events_mod_gml_PortalStorm_step() {')
    end=text.index('\n// Original ',begin)
    body=text[begin:end]
    if 'scrFREventTestsPortalChance(100)' in body:
        return
    assert body.count('scrFRSourceRandom(100)')==1
    condition='((distance_to_object(ProtoStatue) > 64) && (distance_to_object(Player) < 224))'
    assert body.count(condition)==1
    guard='(os_type==os_windows && scrNTTEFullSmokeEnabled())'
    body=body.replace('scrFRSourceRandom(100)',f'({guard} ? scrFREventTestsPortalChance(100) : scrFRSourceRandom(100))',1)
    body=body.replace(condition,f'({guard} ? scrFREventTestsPortalEligibility(ProtoStatue, Player) : {condition})',1)
    path.write_text(text[:begin]+body+text[end:],encoding='utf8')


def instrument_path_grid(project):
    """Capture the actual wall-marked native grid in explicit desktop tests."""
    paths=list((Path(project)/'scripts').glob('frCode_libGeneral_mod_*/*.gml'))
    assert len(paths)==1,paths
    path=paths[0]
    text=path.read_text(encoding='utf8')
    begin=text.index('function fr_dependencies_libGeneral_mod_gml_path_create(')
    end=text.index('\n// Original ',begin)
    body=text[begin:end]
    if 'scrFRPathGridTestObserve(' in body:
        return
    anchor='var _frl__x1 = ((_frl__xtarget - _frl__gridx) / _frl__tileSize);'
    assert body.count(anchor)==1
    observation=('if(os_type==os_windows && scrNTTEFullSmokeEnabled()\n'
                 '    && variable_global_exists("fr_path_grid_observe") && global.fr_path_grid_observe)\n'
                 '    scrFRPathGridTestObserve(_frl__grid,_frl__gridx,_frl__gridy,_frl__tileSize);\n')
    body=body.replace(anchor,observation+anchor,1)
    path.write_text(text[:begin]+body+text[end:],encoding='utf8')


def apply(project):
    project = Path(project).resolve()
    assert project == (ROOT / "staging/project").resolve()
    instrument_portal_storm(project)
    instrument_path_grid(project)
    # The host's resource-pack startup predates the smoke save override. Keep
    # even empty backup/cache directory operations inside this isolated run;
    # ordinary games still use the host's original save-directory semantics.
    for relative in ("scripts/load_resourcepacks/load_resourcepacks.gml",
                     "scripts/resourcepack_temp_cleanup/resourcepack_temp_cleanup.gml"):
        path = project / relative
        text = path.read_text(encoding="utf8")
        if "// FRONTIER SMOKE RESOURCE DIRECTORIES" not in text:
            assert "game_save_id +" in text, relative
            text = text.replace("game_save_id +", "(scrNTTESmokeEnabled() ? game_directory : game_save_id) +")
            path.write_text("// FRONTIER SMOKE RESOURCE DIRECTORIES\n" + text, encoding="utf8")
    source = "tests/frontier.gml"
    parsed = definitions((ROOT / "tools/test_fixture.gml").read_text(encoding="utf8"), source)
    names = {source: {d.name for d in parsed}}
    code = "\n\n".join(FrontierEmitter(source, d, names, {}, {}, {}).emit() for d in parsed)
    script_dir = project / "scripts/scrFrontier_test_fixture"
    script_dir.mkdir(exist_ok=True)
    import json
    model = json.loads((project / "scripts/scrFrontier_skills/scrFrontier_skills.yy").read_text(encoding="utf8"))
    model["name"] = model["%Name"] = "scrFrontier_test_fixture"
    (script_dir / "scrFrontier_test_fixture.yy").write_text(json.dumps(model, indent=2), encoding="utf8")
    (script_dir / "scrFrontier_test_fixture.gml").write_text(code+"\n", encoding="utf8")
    yyp_path = project / "nuclearthronemobile.yyp"
    yyp = json.loads(yyp_path.read_text(encoding="utf8"))
    rel = "scripts/scrFrontier_test_fixture/scrFrontier_test_fixture.yy"
    if not any(r["id"]["path"] == rel for r in yyp["resources"]):
        yyp["resources"].append({"id": {"name":"scrFrontier_test_fixture", "path":rel}})
    yyp_path.write_text(json.dumps(yyp, indent=2), encoding="utf8")
    add_object(project, "FRIntegrationTest", None, [
        (0,0,"Create_0.gml","visible=false;persistent=true;fr_test_ticks=0;fr_test_case=\"\";fr_test_target=noone;"),
        (3,2,"Step_2.gml","try {scrFRIntegrationTestStep();} catch(_error) {scrNTTESmokeLog(\"ERROR FRONTIER \"+json_stringify(_error));game_end();}"),
    ], True)
    trace_guard = 'if(variable_global_exists("fr_test_trace_requested") && global.fr_test_trace_requested) '
    for filename in ("Alarm_0.gml", "Alarm_1.gml", "Alarm_2.gml", "Destroy_0.gml"):
        path = project / "objects/GenCont" / filename
        text = path.read_text(encoding="utf8")
        marker = "// NTUF OPTIONAL GENERATOR TRACE " + filename
        if marker not in text:
            label = "GenCont." + filename.removesuffix(".gml")
            text = marker + "\n" + trace_guard + 'scrNTTESmokeLog("NTUF NATIVE ' + label + ' begin");\n' + text
            text += "\n" + trace_guard + 'scrNTTESmokeLog("NTUF NATIVE ' + label + ' end");\n'
            if filename == "Alarm_0.gml":
                for anchor, label in (("with (Floor) mcr_floor_make_walls;", "walls"),
                                      ("if(!scrNTTEFullAreaGeneratorPopulate()) scrPopulate()", "population"),
                                      ("with (Floor) mcr_floor_create_tops;", "tops")):
                    assert anchor in text
                    text = text.replace(anchor, trace_guard + 'scrNTTESmokeLog("NTUF NATIVE ' + label + ' begin");\n' + anchor
                                        + "\n" + trace_guard + 'scrNTTESmokeLog("NTUF NATIVE ' + label + ' end");', 1)
            path.write_text(text, encoding="utf8")
    lib_paths = list((project / "scripts").glob("frCode_lib_mod_*/*.gml"))
    assert len(lib_paths) == 1
    lib_path = lib_paths[0]
    text = lib_path.read_text(encoding="utf8")
    if "// NTUF OPTIONAL ID SCAN TRACE" not in text:
        scan = 'while (((_frl_updateid++) < _frl_newID)) {'
        finished = 'if ((_frl_newID > _frl_lastid)) {'
        assert text.count(scan) == text.count(finished) == 2
        text = text.replace(scan, 'if(variable_global_exists("fr_test_trace") && global.fr_test_trace) '
                            'scrNTTESmokeLog("NTUF ID SCAN begin old="+string(_frl_updateid)+" new="+string(_frl_newID));\n' + scan)
        text = text.replace(finished, 'if(variable_global_exists("fr_test_trace") && global.fr_test_trace) '
                            'scrNTTESmokeLog("NTUF ID SCAN end cursor="+string(_frl_updateid)+" last="+string(_frl_lastid));\n' + finished)
        lib_path.write_text("// NTUF OPTIONAL ID SCAN TRACE\n"+text, encoding="utf8")
    patch(project,"scripts/scrNTTEFullSmoke/scrNTTEFullSmoke.gml", "TEST ENTRY",
          'if(scrNTTEFullSmokeAsyncCase("FrontierCoreTests")) {scrFRIntegrationTestStart("core");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierWeaponTests")) {scrFRIntegrationTestStart("weapons");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierAreaTests")) {scrFRIntegrationTestStart("areas");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierSkillTests")) {scrFRIntegrationTestStart("skills");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierRaceTests")) {scrFRIntegrationTestStart("race");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierOptionTests")) {scrFRIntegrationTestStart("options");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierUnlockTests")) {scrFRIntegrationTestStart("unlocks");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierVisualTests")) {scrFRIntegrationTestStart("visual");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierEventTests")) {scrFRIntegrationTestStart("events");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierPromptTests")) {scrFRIntegrationTestStart("prompts");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierContinueWriteTests")) {scrFRIntegrationTestStart("continue-write");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierContinueReadTests")) {scrFRIntegrationTestStart("continue-read");return;}',
          anchor='        if(scrNTTEFullSmokeAsyncCase("Release127PerfTests"))', before=True)
    return {"desktop_only":True,"cases":["core","weapons","areas","skills","race","options","unlocks","visual","events","prompts","continue-write","continue-read"]}
