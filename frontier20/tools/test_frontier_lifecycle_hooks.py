"""Pause lifecycle hook boundaries on disposable project fragments."""
import json
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from fr_lifecycle_hooks import apply


class LifecycleHookTests(unittest.TestCase):
    def make_project(self, folder):
        project = Path(folder)
        files = {
            "objects/UberCont/Create_0.gml": "native_boot();\nif(!instance_exists(FRWorld)) instance_create(0,0,FRWorld);\nnative_tail();\n",
            "objects/UberCont/Step_1.gml": "if(paused) {\n\t\t    instance_deactivate_all(true)\n\t\t    instance_activate_object(GameCont)\n}\n",
            "objects/FRWorld/Draw_0.gml": 'scrFRHook("draw",[]);\n',
            "objects/FRWorld/Draw_64.gml": 'scrFRHook("draw_gui",[]);\n',
            "objects/FRWorld/Draw_73.gml": 'scrFRHook("draw_gui_end",[]);\n',
            "scripts/scrGameFreeze/scrGameFreeze.gml": "instance_deactivate_all(1)\n",
            "scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml":
                'function scrCleanupSessionInstances() {\n\twith all {\n'
                '\t\tif(object_index==UberCont) continue\n\t\tinstance_destroy(id,false)\n\t}\n'
                '\tif (variable_global_exists("debugclear_restore")) global.debugclear_restore = undefined\n}\n',
            "objects/SitDown/Alarm_0.gml":
                'scrNTTEFullProgressSave()\nwith all {\n'
                '    if(object_index==UberCont || object_index==GameCont) continue\n'
                '    instance_destroy(id,false)\n}\ninstance_create(0, 0, Credits)\n',
            "objects/BackButton/Other_10.gml":
                'if(instance_exists(Menu)) {\n\t    with all {\n'
                '        if(object_index!=UberCont) instance_destroy(id,0)\n    }\n'
                '\t\tscr_camera_set_position(0, 0)\n}\n',
            "objects/FRWorld/FRWorld.yy": json.dumps({"eventList": []}),
        }
        for relative, text in files.items():
            path = project / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text, encoding="utf8")
        return project, files

    def test_only_native_pause_keeps_registry_and_storage_alive(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            report = apply(project)
            self.assertEqual(report["active_storage"], ["FRWorld", "libGlobal"])
            step = (project / "objects/UberCont/Step_1.gml").read_text("utf8")
            self.assertLess(step.index("scrFRPausePrepare();"), step.index("instance_deactivate_all(true)"))
            self.assertLess(step.index("instance_deactivate_all(true)"), step.index("scrFRPauseKeepAlive();"))
            self.assertLess(step.index("scrFRPauseKeepAlive();"), step.index("instance_activate_object(GameCont)"))
            self.assertIn("if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrFRLifecycleTestsPauseKeepAlive();", step)
            self.assertEqual((project / "scripts/scrGameFreeze/scrGameFreeze.gml").read_text("utf8"),
                             original["scripts/scrGameFreeze/scrGameFreeze.gml"])
            self.assertNotIn("instance_activate_all", step)
            self.assertNotIn("instance_activate_object(FRCustomObject)", step)
            cleanup = (project / "scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml").read_text("utf8")
            self.assertLess(cleanup.index("scrFRSessionPrepare();"), cleanup.index("with all"))
            self.assertLess(cleanup.index("scrFRSessionPreserve(id)"), cleanup.index("instance_destroy(id,false)"))
            self.assertLess(cleanup.index("instance_destroy(id,false)"), cleanup.index("scrFRSessionRetired();"))
            self.assertEqual(report["session_storage"], ["FRWorld", "libGlobal"])
            for relative in ("objects/SitDown/Alarm_0.gml", "objects/BackButton/Other_10.gml"):
                boundary = (project / relative).read_text("utf8")
                self.assertLess(boundary.index("scrFRSessionPrepare();"), boundary.index("with all"))
                self.assertLess(boundary.index("scrFRSessionPreserve(id)"), boundary.index("instance_destroy(id"))
                self.assertLess(boundary.index("instance_destroy(id"), boundary.index("scrFRSessionRetired("))
            victory = (project / "objects/SitDown/Alarm_0.gml").read_text("utf8")
            self.assertIn("scrFRSessionRetired(true);", victory)
            boot = (project / "objects/UberCont/Create_0.gml").read_text("utf8")
            self.assertLess(boot.index("scrFRRestartTestsColdSelectProbe();"), boot.index("scrFRWorldEnsure();"))
            first = {str(path.relative_to(project)): path.read_bytes() for path in project.rglob("*") if path.is_file()}
            apply(project)
            second = {str(path.relative_to(project)): path.read_bytes() for path in project.rglob("*") if path.is_file()}
            self.assertEqual(first, second)
            world = json.loads((project / "objects/FRWorld/FRWorld.yy").read_text("utf8"))
            self.assertEqual(sum(e["eventType"] == 12 and e["eventNum"] == 0 for e in world["eventList"]), 1)

    def test_unknown_native_pause_anchor_rejects_before_writing(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            step = project / "objects/UberCont/Step_1.gml"
            step.write_text("different_pause();\n", encoding="utf8")
            with self.assertRaisesRegex(AssertionError, "lifecycle anchor changed"):
                apply(project)
            self.assertEqual((project / "objects/UberCont/Create_0.gml").read_text("utf8"),
                             original["objects/UberCont/Create_0.gml"])
            self.assertFalse((project / "objects/FRWorld/CleanUp_0.gml").exists())

    def test_upgrade_from_previous_pause_hook_does_not_duplicate(self):
        with TemporaryDirectory() as folder:
            project, _ = self.make_project(folder)
            path = project / "objects/UberCont/Step_1.gml"
            text = path.read_text("utf8")
            text = text.replace("\t\t    instance_deactivate_all(true)",
                                "\t\t    instance_deactivate_all(true)\n"
                                "\t\t    scrFRPauseKeepAlive(); // FRONTIER PAUSED REGISTRY\n"
                                "\t\t    if(os_type==os_windows && scrNTTEFullSmokeEnabled()) scrFRLifecycleTestsPauseKeepAlive();")
            path.write_text(text, encoding="utf8")
            apply(project)
            first = path.read_bytes()
            result = first.decode("utf8")
            self.assertEqual(result.count("scrFRPausePrepare();"), 1)
            self.assertEqual(result.count("scrFRPauseKeepAlive();"), 1)
            self.assertEqual(result.count("scrFRLifecycleTestsPauseKeepAlive();"), 1)
            self.assertLess(result.index("scrFRPausePrepare();"), result.index("instance_deactivate_all(true)"))
            apply(project)
            self.assertEqual(first, path.read_bytes())

    def test_unknown_cleanup_anchor_rejects_before_writing(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            path = project / "scripts/scrCleanupSessionInstances/scrCleanupSessionInstances.gml"
            path.write_text("different_session_cleanup();\n", encoding="utf8")
            with self.assertRaisesRegex(AssertionError, "lifecycle anchor changed"):
                apply(project)
            self.assertEqual((project / "objects/UberCont/Create_0.gml").read_text("utf8"),
                             original["objects/UberCont/Create_0.gml"])
            self.assertFalse((project / "objects/FRWorld/CleanUp_0.gml").exists())

    def test_early_boot_selector_upgrade_is_pure_and_idempotent(self):
        with TemporaryDirectory() as folder:
            project, _ = self.make_project(folder)
            path = project / "objects/UberCont/Create_0.gml"
            path.write_text('native_boot();\n'
                'if(os_type==os_windows && scrNTTEFullSmokeEnabled() && '
                'scrNTTEFullSmokeAsyncCase("FrontierRestartTests")) '
                'scrFRRestartTestsColdSelectProbe(); // FRONTIER COLD SELECT ACCEPTANCE\n'
                'scrFRWorldEnsure(); // FRONTIER OWNED PERSISTENT BOOT\nnative_tail();\n', encoding="utf8")
            apply(project)
            first = path.read_bytes()
            self.assertNotIn(b"scrNTTEFullSmokeAsyncCase", first)
            self.assertEqual(first.count(b"scrFRRestartTestsColdSelectProbe();"), 1)
            self.assertIn(b"if(scrFRRestartTestsColdRequested())", first)
            apply(project)
            self.assertEqual(first, path.read_bytes())

    def test_changed_victory_boundary_rejects_atomically(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            (project / "objects/SitDown/Alarm_0.gml").write_text("different_victory();\n", encoding="utf8")
            with self.assertRaisesRegex(AssertionError, "lifecycle anchor changed"):
                apply(project)
            self.assertEqual((project / "objects/UberCont/Create_0.gml").read_text("utf8"),
                             original["objects/UberCont/Create_0.gml"])
            self.assertFalse((project / "objects/FRWorld/CleanUp_0.gml").exists())


if __name__ == "__main__":
    unittest.main()
