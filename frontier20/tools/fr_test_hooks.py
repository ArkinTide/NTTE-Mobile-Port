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


def instrument_bubbles_hud(project):
    """Observe completion of the actual primary-player charge HUD branch."""
    paths=list((Path(project)/'scripts').glob('frCode_Frontier_CharHuds_mod_*/*.gml'))
    assert len(paths)==1,paths
    relative=paths[0].relative_to(project).as_posix()
    anchor=('scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHud, '
            '0, _frl__hudX, _frl__hudY);')
    patch(Path(project),relative,"BUBBLES STARTUP REAL HUD",
          'if(os_type==os_windows && scrNTTEFullSmokeEnabled() '
          '&& instance_exists(FRIntegrationTest)) '
          'scrFRBubblesStartupTestsObserve("hud",_frl__player);',anchor=anchor)


def instrument_bubbles_mobile_input(project):
    """Exercise real touch producers; substitute only desktop test devices."""
    path=Path(project)/"objects/JoystickAttack/Other_10.gml"
    text=path.read_text(encoding="utf8")
    marker="// FRONTIER BUBBLES EXPLICIT TOUCH DEVICE FIXTURE\n"
    if marker not in text:
        replacements={
            "get_nearest_touch(":"scrFRBubblesStartupTestsTouchNearest(",
            "device_mouse_x_to_gui(":"scrFRBubblesStartupTestsTouchX(",
            "device_mouse_y_to_gui(":"scrFRBubblesStartupTestsTouchY(",
            "device_mouse_check_button(":'scrFRBubblesStartupTestsTouchButton("held",',
            "device_mouse_check_button_pressed(":'scrFRBubblesStartupTestsTouchButton("pressed",',
            "device_mouse_check_button_released(":'scrFRBubblesStartupTestsTouchButton("released",',
        }
        for before,after in replacements.items():
            assert before in text and after not in text,(path,before)
            text=text.replace(before,after)
        path.write_text(marker+text,encoding="utf8")
    guard=('if(os_type==os_windows && scrNTTEFullSmokeEnabled() '
           '&& instance_exists(FRIntegrationTest)) ')
    patch(Path(project),"objects/Slash/Collision_hitme.gml","BUBBLES STARTUP NATURAL HIT BEFORE",
          'var _fr_bubbles_natural_hit=undefined;\n'+guard+
          '_fr_bubbles_natural_hit=scrFRBubblesStartupTestsHitBegin(id,other.id);',
          anchor='var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);',before=True)
    patch(Path(project),"objects/Slash/Collision_hitme.gml","BUBBLES STARTUP NATURAL HIT AFTER",
          guard+'scrFRBubblesStartupTestsHitEnd(_fr_bubbles_natural_hit);')


def instrument_menu_audio(project):
    """Record actual returned native voices only in the explicit smoke build."""
    replacements = {
        "scripts/snd_play/snd_play.gml": [(
            "return audio_play_sound_on(UberCont.mainsound, _sound_index,\n"
            "\t\t\tfalse, 2, UberCont.opt_sndvol * _gain, 0, _pitch)",
            "return scrFRMenuAudioTestsRecord(audio_play_sound_on(UberCont.mainsound, _sound_index,\n"
            "\t\t\tfalse, 2, UberCont.opt_sndvol * _gain, 0, _pitch), _sound_index, \"native-on\")", 1)],
        "scripts/snd_play_loop/snd_play_loop.gml": [(
            "return audio_play_sound(_sound_index, 1000, true)",
            "return scrFRMenuAudioTestsRecord(audio_play_sound(_sound_index, 1000, true), _sound_index, \"native-loop\")", 1)],
        "scripts/snd_play_pitch/snd_play_pitch.gml": [(
            "return audio_play_sound_on(UberCont.mainsound,\n"
            "        _sound_index, false, 2, _gain, 0, _pitch)",
            "return scrFRMenuAudioTestsRecord(audio_play_sound_on(UberCont.mainsound,\n"
            "        _sound_index, false, 2, _gain, 0, _pitch), _sound_index, \"native-pitch\")", 1)],
        "scripts/snd_play_music/snd_play_music.gml": [(
            "var _s = audio_play_sound(_sound_index, 128, _looped)",
            "var _s = scrFRMenuAudioTestsRecord(audio_play_sound(_sound_index, 128, _looped), _sound_index, \"native-music-ambient\")", 2)],
        "scripts/scrFrontier_legacy_api/scrFrontier_legacy_api.gml": [(
            "return audio_play_sound_on(UberCont.mainsound,_sound,true,1,UberCont.opt_sndvol,0,1);",
            "return scrFRMenuAudioTestsRecord(audio_play_sound_on(UberCont.mainsound,_sound,true,1,UberCont.opt_sndvol,0,1),_sound,\"frontier-loop\");", 1)],
    }
    planned = []
    for relative, rows in replacements.items():
        path = project / relative
        raw = path.read_bytes()
        bom = b"\xef\xbb\xbf" if raw.startswith(b"\xef\xbb\xbf") else b""
        text = raw.decode("utf-8-sig")
        newline = "\r\n" if "\r\n" in text else "\n"
        normal = text.replace("\r\n", "\n")
        for before, after, count in rows:
            if normal.count(after) == count and before not in normal:
                continue
            assert normal.count(before) == count and after not in normal, (relative, before)
            normal = normal.replace(before, after)
        planned.append((path, bom + normal.replace("\n", newline).encode("utf8")))
    for path, payload in planned:
        if path.read_bytes() != payload:
            path.write_bytes(payload)


def apply(project):
    project = Path(project).resolve()
    assert project == (ROOT / "staging/project").resolve()
    instrument_portal_storm(project)
    instrument_path_grid(project)
    instrument_bubbles_hud(project)
    instrument_bubbles_mobile_input(project)
    instrument_menu_audio(project)
    patch(project,"objects/UberCont/Step_0.gml","RESTART OBSERVERS",
          'if(os_type==os_windows && scrNTTEFullSmokeEnabled()) {\n'
          '    scrFRRestartTestsObserve();\n'
          '    scrFRProtoChestTestsObserve();\n'
          '    scrFRCaptainChairTestsObserve();\n'
          '    scrFRMenuAudioTestsObserve();\n'
          '    scrFRBubblesStartupTestsObserveLifecycle();\n'
          '}',anchor='scrNTTEUpdateStep()')
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
    # Observe the actual native events only in explicitly selected desktop
    # Bubbles startup cases. Sample test buttons only after the actual native
    # physical producer, independently of Player/UberCont event ordering.
    bubbles_guard = ('if(os_type==os_windows && scrNTTEFullSmokeEnabled() '
                     '&& instance_exists(FRIntegrationTest)) ')
    patch(project,"objects/UberCont/Step_0.gml","BUBBLES STARTUP BEFORE REAL INPUT",
          bubbles_guard+'scrFRBubblesStartupTestsBeforeInputSample();',
          anchor='scrHandleInputsGeneral(global.index)',before=True)
    patch(project,"objects/UberCont/Step_0.gml","BUBBLES STARTUP REAL INPUT",
          bubbles_guard+'scrFRBubblesStartupTestsAfterInputSample();',
          anchor='scrHandleInputsGeneral(global.index)')
    patch(project,"objects/UberCont/Step_0.gml","GROUND WEAPON REAL INPUT",
          bubbles_guard+'scrFRGroundWeaponTestsAfterInputSample();',
          anchor='scrHandleInputsGeneral(global.index)')
    patch(project,"objects/Player/Step_0.gml","BUBBLES STARTUP REAL STEP",
          bubbles_guard+'scrFRBubblesStartupTestsObserve("step",id);',
          anchor='scrNTTEFullPlayerRateSync();')
    patch(project,"objects/Player/Step_2.gml","BUBBLES STARTUP REAL END",
          bubbles_guard+'scrFRBubblesStartupTestsObserve("end",id);')
    patch(project,"objects/Player/Draw_0.gml","BUBBLES STARTUP REAL DRAW",
          bubbles_guard+'scrFRBubblesStartupTestsObserve("draw",id);')
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
          'if(scrNTTEFullSmokeAsyncCase("FrontierBubblesStartupATests")) {scrFRIntegrationTestStart("bubbles-startup-a");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierBubblesStartupBTests")) {scrFRIntegrationTestStart("bubbles-startup-b");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierBubblesRandomTests")) {scrFRIntegrationTestStart("bubbles-random");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierMenuRepairTests")) {scrFRIntegrationTestStart("menu-repairs");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierFlyWallTests")) {scrFRIntegrationTestStart("fly-wall");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierOptionTests")) {scrFRIntegrationTestStart("options");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierUnlockTests")) {scrFRIntegrationTestStart("unlocks");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierVisualTests")) {scrFRIntegrationTestStart("visual");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierEventTests")) {scrFRIntegrationTestStart("events");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierPromptTests")) {scrFRIntegrationTestStart("prompts");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierWallFixTests")) {scrFRIntegrationTestStart("wall-fixes");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierPlayerWallTests")) {scrFRIntegrationTestStart("player-wall");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierGroundWeaponTests")) {scrFRIntegrationTestStart("ground-weapon");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierProtoChestTests")) {scrFRIntegrationTestStart("proto-chest");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierRestartTests")) {scrFRIntegrationTestStart("restart");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierCaptainChairTests")) {scrFRIntegrationTestStart("captain_chair");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierMenuAudioTests")) {scrFRIntegrationTestStart("menu_audio");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierScaryFaceTests")) {scrFRIntegrationTestStart("scary-face");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierSceneryWeatherTests")) {scrFRIntegrationTestStart("scenery-weather");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierSceneryWeather60Tests")) {scrFRIntegrationTestStart("scenery-weather60");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierLifecycleTests")) {scrFRIntegrationTestStart("lifecycle");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierProgressionTests")) {scrFRIntegrationTestStart("progression");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierPerformanceTests")) {scrFRIntegrationTestStart("performance");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierRobocenterPerformanceTests")) {scrFRIntegrationTestStart("robocenter-perf");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierDeeplabsPerformanceTests")) {scrFRIntegrationTestStart("deeplabs-perf");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierWeatherPerformanceTests")) {scrFRIntegrationTestStart("weather-perf");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierLocalizationTests")) {scrFRIntegrationTestStart("localization");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierMillipedeTests")) {scrFRIntegrationTestStart("millipede");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierContinueWriteTests")) {scrFRIntegrationTestStart("continue-write");return;}\n'
          'if(scrNTTEFullSmokeAsyncCase("FrontierContinueReadTests")) {scrFRIntegrationTestStart("continue-read");return;}',
          anchor='        if(scrNTTEFullSmokeAsyncCase("Release127PerfTests"))', before=True)
    return {"desktop_only":True,"cases":["core","weapons","areas","skills","race","bubbles-startup-a","bubbles-startup-b","options","unlocks","visual","events","prompts","continue-write","continue-read"]}
