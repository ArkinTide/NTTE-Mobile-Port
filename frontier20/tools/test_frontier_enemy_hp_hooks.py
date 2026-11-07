"""Construction ancestry, exact-leaf boundaries, idempotence and atomic guards."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from fr_enemy_hp_hooks import apply, enemy_types, EFFECTS, ROOT, MARKER


class EnemyHPHookTests(unittest.TestCase):
    def fixture(self, folder):
        project = Path(folder)
        for name, parent in [('enemy', None), ('NTTEBase', 'enemy'),
                             ('NTTEGold', 'NTTEBase'), ('NTTEProp', 'prop')]:
            obj = project / 'objects' / name
            obj.mkdir(parents=True)
            model = '{"parentObjectId":' + (
                '{"name":"' + parent + '","path":"objects/x/x.yy",}' if parent else 'null') + ',}'
            (obj / (name + '.yy')).write_text(model, encoding='utf8')
            (obj / 'Create_0.gml').write_text('event_inherited();\nmax_hp=16;hp=max_hp;\n', encoding='utf8')
        effects = project / EFFECTS
        effects.parent.mkdir(parents=True)
        effects.write_text('old_effects();\n', encoding='utf8')
        return project

    def snapshot(self, project):
        return {str(p.relative_to(project)): p.read_bytes() for p in project.rglob('*') if p.is_file()}

    def test_exact_leaf_and_idempotence(self):
        with TemporaryDirectory() as folder:
            project = self.fixture(folder)
            self.assertEqual(enemy_types(project), ['NTTEBase', 'NTTEGold'])
            report = apply(project)
            self.assertEqual(report['native_final_leaf_count'], 2)
            self.assertFalse(report['rerolled_luck'])
            self.assertFalse(report['reapplied_drop_modifiers'])
            for name in ['NTTEBase', 'NTTEGold']:
                source = (project / 'objects' / name / 'Create_0.gml').read_text('utf8')
                self.assertTrue(source.rstrip().endswith(
                    f'if(object_index=={name}) scrNTTEFullEnemyCreationHPFinish(); {MARKER}'))
            self.assertNotIn(MARKER, (project / 'objects/NTTEProp/Create_0.gml').read_text('utf8'))
            first = self.snapshot(project)
            apply(project)
            self.assertEqual(first, self.snapshot(project))

    def test_unknown_or_nonfinal_hook_is_atomic(self):
        for tail in ['if(object_index==NTTEWrong) scrNTTEFullEnemyCreationHPFinish(); '+MARKER,
                     'if(object_index==NTTEGold) scrNTTEFullEnemyCreationHPFinish(); '+MARKER+'\nmax_hp=4;']:
            with self.subTest(tail=tail), TemporaryDirectory() as folder:
                project = self.fixture(folder)
                target = project / 'objects/NTTEGold/Create_0.gml'
                target.write_text(tail, encoding='utf8')
                before = self.snapshot(project)
                with self.assertRaises(AssertionError):
                    apply(project)
                self.assertEqual(before, self.snapshot(project))

    def test_early_exit_or_missing_leaf_is_atomic(self):
        for contents in ['event_inherited();\nif(foo) exit;\n', None]:
            with self.subTest(contents=contents), TemporaryDirectory() as folder:
                project = self.fixture(folder)
                target = project / 'objects/NTTEGold/Create_0.gml'
                if contents is None:
                    target.unlink()
                else:
                    target.write_text(contents, encoding='utf8')
                before = self.snapshot(project)
                with self.assertRaises(AssertionError):
                    apply(project)
                self.assertEqual(before, self.snapshot(project))

    def test_three_delivery_projects_cover_every_current_native_enemy(self):
        for relative in ['project', 'android-delivery/project', 'frontier20/staging/project']:
            project = ROOT / relative
            names = enemy_types(project)
            self.assertEqual(len(names), 56, relative)
            for name in names:
                source = (project / 'objects' / name / 'Create_0.gml').read_text('utf-8-sig')
                self.assertEqual(source.count(MARKER), 1, (relative, name))
                self.assertTrue(source.rstrip().endswith(
                    f'if(object_index=={name}) scrNTTEFullEnemyCreationHPFinish(); {MARKER}'))

    def test_absent_pending_field_and_luck_result_are_guarded_at_native_boundary(self):
        source = (ROOT / 'project' / EFFECTS).read_text('utf-8-sig')
        finalizer = source.split('function scrNTTEFullEnemyCreationHPFinish()', 1)[1]
        self.assertLess(finalizer.index('variable_instance_exists(id,"ntte_full_scarier_creation_pending")'),
                        finalizer.index('if(!ntte_full_scarier_creation_pending)'))
        self.assertIn('if(!ntte_full_scarier_creation_pending) return;', finalizer)
        self.assertIn('if(!variable_instance_exists(id,"ntte_full_scarier_creation_pending")) return;', finalizer)
        self.assertNotIn('self[$ "ntte_full_scarier_creation_pending"]', finalizer)
        self.assertIn('if(_defer_scarier) ntte_full_scarier_creation_luck=true\n            else hp = 1', source)
        self.assertIn('if !_fr_custom {', source)


if __name__ == '__main__':
    unittest.main()
