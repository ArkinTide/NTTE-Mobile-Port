"""Only audited dispatch, pure reads and the exact fresh storage query change."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from fr_lib_performance_hooks import (apply, PHASES, SNAPSHOT_FIELDS,
                                      storage_snapshot_block, storage_snapshot_wrapper,
                                      MUTATION_START, mutation_source_loop, mutation_guard_block,
                                      STORAGE_QUERY, STORAGE_COLLECTOR, STORAGE_QUERY_COUNT)


class LibPerformanceHookTests(unittest.TestCase):
    def make_project(self, folder):
        project = Path(folder)
        loop = 'scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks"))'
        source = ('// Original fixture:step\nfunction fr_dependencies_lib_mod_gml_step() {\n'
                  'var _frl__global = ' + STORAGE_QUERY + ';\n'
                  'native_unique_storage_test_and_rebuild();\nif (native_unique()) {\n'
                  + storage_snapshot_block() + '\n'
                  'scrFRIndexGet(_frl__global, 0).lastUpdatedFrame = scrFRSourceFrame();\n'
                  '}\n' + MUTATION_START + '\n'
                  'native_original_callback_with_fresh_GlobalGet();\n'
                  'fr_dependencies_lib_mod_gml_GlobalSet("previousmutations", _frl_mutations);\n'
                  '}\n}\nnative_rest_of_step();\n}\n\n')
        source += ('// Original fixture:GlobalGet\nfunction fr_dependencies_lib_mod_gml_GlobalGet() {return '
                   + STORAGE_QUERY + ';}\n\n'
                   '// Original fixture:GlobalSet\nfunction fr_dependencies_lib_mod_gml_GlobalSet() {return '
                   + STORAGE_QUERY + ';}\n\n'
                   '// Original fixture:init\nfunction fr_dependencies_lib_mod_gml_init() {native_ref('
                   + STORAGE_QUERY + ');native_other(scrFRMatching(FRCustomObject, "name", "different"));}\n\n')
        for name in [*PHASES, "level_start", "weapon_prefire"]:
            source += ("// Original fixture:" + name + "\nfunction fr_dependencies_lib_mod_gml_" + name + "() {\n"
                       "native_before();\nwith (" + loop + ") native_source_dispatch();\nnative_after();\n}\n\n")
        files = {
            "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml": source,
            "scripts/scrFrontier_registry/scrFrontier_registry.gml": "function register() {\n    array_push(global.fr_module_order,_key);\n}\n",
            "scripts/scrFrontier_offline_lib/scrFrontier_offline_lib.gml": "function init() {\n    global.fr_initialized[$ _key]=true;\n}\n",
        }
        for relative, text in files.items():
            path = project / relative
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text, encoding="utf8")
        return project, files

    def test_only_optional_phase_inputs_change_and_repeat_is_identical(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            report = apply(project)
            self.assertEqual(report["ownership_dispatch"], "original")
            self.assertEqual(report["unique_storage_direct_reads"], 11)
            self.assertTrue(report["unchanged_mutation_fastpath"])
            self.assertEqual(report["fresh_native_storage_queries"], 4)
            relative = "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml"
            text = (project / relative).read_text("utf8")
            self.assertEqual(text.count(storage_snapshot_wrapper()), 1)
            restored = text.replace(storage_snapshot_wrapper(), storage_snapshot_block())
            self.assertEqual(text.count(STORAGE_COLLECTOR), STORAGE_QUERY_COUNT)
            self.assertNotIn(STORAGE_QUERY, text)
            restored = restored.replace(STORAGE_COLLECTOR, STORAGE_QUERY)
            raw = mutation_source_loop(restored)
            self.assertEqual(restored.count(mutation_guard_block(raw)), 1)
            restored = restored.replace(mutation_guard_block(raw), raw)
            for phase in PHASES.values():
                new = 'scrFRLibPhaseHooks(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks"),"' + phase + '")'
                self.assertEqual(text.count(new), 1)
                restored = restored.replace(new, 'fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")')
            self.assertEqual(restored, original[relative])
            first = {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()}
            apply(project)
            self.assertEqual(first, {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()})

    def test_source_anchor_change_fails_before_writing(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            path = project / "scripts/scrFrontier_registry/scrFrontier_registry.gml"
            path.write_text("changed();\n", encoding="utf8")
            with self.assertRaisesRegex(AssertionError, "lifecycle anchor changed"):
                apply(project)
            relative = "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml"
            self.assertEqual((project / relative).read_text("utf8"), original[relative])

    def test_storage_anchor_change_fails_before_any_write(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            path = project / "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml"
            changed = path.read_text("utf8").replace('GlobalGet("canLoad")', 'GlobalGet("other")', 1)
            path.write_text(changed, encoding="utf8")
            before = {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()}
            with self.assertRaisesRegex(AssertionError, "unique storage read anchor changed"):
                apply(project)
            self.assertEqual(before, {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()})

    def test_real_compiled_source_has_exact_pure_storage_read_block(self):
        source = (Path(__file__).resolve().parent.parent / "generated-code/dependencies_lib_mod_gml.gml").read_text("utf8")
        self.assertEqual(source.count(storage_snapshot_block()), 1)
        self.assertEqual(len(SNAPSHOT_FIELDS), 11)
        self.assertEqual(source.count(STORAGE_QUERY), STORAGE_QUERY_COUNT)
        # The target contains only assignments and field reads. All source
        # uniqueness/rebuild logic, callbacks and general GlobalGet stay out.
        for field in SNAPSHOT_FIELDS:
            self.assertIn('GlobalGet("' + field + '")', storage_snapshot_block())
        self.assertNotIn("scrFRModCall", storage_snapshot_block())
        raw = mutation_source_loop(source)
        self.assertIn('"mutation_update"', raw)
        self.assertIn('GlobalGet("previousmutations")', raw)
        # Guarding must preserve the complete original callback loop byte for
        # byte, including fresh reads inside callback arguments and its write.
        guarded = mutation_guard_block(raw)
        self.assertEqual(guarded.count(raw), 1)
        self.assertTrue(guarded.endswith(raw + '\n// FRONTIER LIB UNCHANGED MUTATIONS END'))

    def test_storage_query_anchor_change_fails_before_any_write(self):
        for altered in ('scrFRMatching(FRCustomObject, "name", "different")', STORAGE_COLLECTOR):
            with self.subTest(altered=altered), TemporaryDirectory() as folder:
                project, _ = self.make_project(folder)
                path = project / "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml"
                path.write_text(path.read_text("utf8").replace(STORAGE_QUERY, altered, 1), encoding="utf8")
                before = {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()}
                with self.assertRaisesRegex(AssertionError, "storage (query|collector) anchors changed"):
                    apply(project)
                self.assertEqual(before, {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()})

    def test_mutation_anchor_change_fails_before_any_write(self):
        with TemporaryDirectory() as folder:
            project, _ = self.make_project(folder)
            path = project / "scripts/frCode_lib_mod_fixture/frCode_lib_mod_fixture.gml"
            changed = path.read_text("utf8").replace('GlobalSet("previousmutations", _frl_mutations)', 'GlobalSet("different", _frl_mutations)', 1)
            path.write_text(changed, encoding="utf8")
            before = {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()}
            with self.assertRaisesRegex(AssertionError, "mutation source write changed"):
                apply(project)
            self.assertEqual(before, {str(p.relative_to(project)): p.read_bytes() for p in project.rglob("*") if p.is_file()})


if __name__ == "__main__":
    unittest.main()
