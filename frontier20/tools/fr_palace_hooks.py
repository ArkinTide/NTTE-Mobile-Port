"""Preserve the authored Palace crush trap on the host's wall/physics system."""
from pathlib import Path
from fr_content_hooks import patch


def apply(project):
    project = Path(project)
    paths = list((project / "scripts").glob("frCode_Frontier_Palace_mod_*/*.gml"))
    assert len(paths) == 1, paths
    relative = paths[0].relative_to(project).as_posix()
    raw = paths[0].read_text(encoding="utf8")
    start = raw.index("function fr_Objects_Frontier_Palace_mod_gml_crushBlock_wall_create(")
    end = raw.index("\n// Original ", start)
    body = raw[start:end]
    marker = "fr_palace_block_proxy = true;"
    if marker not in body:
        anchor = "creator = _frl__creator;"
        assert body.count(anchor) == 1
        body = body.replace(anchor, anchor + "\n" + marker, 1)
        paths[0].write_text(raw[:start] + body + raw[end:], encoding="utf8")
    raw = paths[0].read_text(encoding="utf8")
    start = raw.index("function fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_create(")
    end = raw.index("\n// Original ", start)
    body = raw[start:end]
    marker = "fr_palace_smush = true;"
    if marker not in body:
        anchor = "swipswap = false;"
        assert body.count(anchor) == 1
        body = body.replace(anchor, anchor + "\n" + marker
                            + "\nfr_palace_smush_age = -1;\nfr_palace_smush_targets = {};", 1)
        anchor = "on_hit = fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_hit;"
        assert body.count(anchor) == 1
        body = body.replace(anchor, "on_hit = scrFRPalaceSmushHit;", 1)
        paths[0].write_text(raw[:start] + body + raw[end:], encoding="utf8")
    patch(project, "objects/Wall/Collision_Wall.gml", "PALACE MOVING WALL",
          "if(scrFRPalaceBlockWallPair(id,other.id)) exit;",
          anchor="if (id > other.id) instance_destroy()", before=True)
    # Tests stay in their own explicit desktop case. Inserting them into the
    # staged dispatcher leaves the maintained native tests file untouched.
    patch(project, "scripts/scrFrontier_tests/scrFrontier_tests.gml", "PALACE BLOCK TEST DRIVER",
          'if(fr_test_case=="palace-block") {\n'
          '    if(!variable_instance_exists(id,"fr_palace_blocks")) {\n'
          '        if(!scrFRReadyTick()) return;\n'
          '        if(++fr_test_ticks<45) return;\n'
          '        scrFRPalaceBlockTestsStart(id);\n'
          '    }\n'
          '    if(scrFRPalaceBlockTestsStep(id)) {\n'
          '        scrNTTESmokeLog("PASS full internal selected implemented branches; not complete MOD coverage");\n'
          '        game_end();\n'
          '    }\n'
          '    return;\n'
          '}', anchor="function scrFRIntegrationTestStep() {")
    patch(project, "scripts/scrNTTEFullSmoke/scrNTTEFullSmoke.gml", "PALACE BLOCK TEST ENTRY",
          'if(scrNTTEFullSmokeAsyncCase("FrontierPalaceBlockTests")) {scrFRIntegrationTestStart("palace-block");return;}',
          anchor='        if(scrNTTEFullSmokeAsyncCase("Release127PerfTests"))', before=True)
    return {"moving_wall_proxy": True, "impact_lifetime_after_native_collision": True,
            "impact_damage_once_per_victim": True, "native_case": "FrontierPalaceBlockTests"}
