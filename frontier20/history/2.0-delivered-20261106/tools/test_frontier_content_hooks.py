"""Native content hook regressions on disposable project fragments only."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from fr_content_hooks import apply_native_enemy_fields, apply_status_timer_cleanup, apply_path_grid_bounds, apply_cyberspace_revive
from fr_test_hooks import instrument_path_grid
from test_frontier_compiler import emit


class NativeEnemyFieldTests(unittest.TestCase):
    def make_project(self,folder):
        project=Path(folder)
        host=Path(__file__).resolve().parents[2]/'project'
        for relative in ('objects/HyperCrystal/Create_0.gml','objects/IDPDSpawn/Create_0.gml'):
            target=project/relative
            target.parent.mkdir(parents=True)
            target.write_text((host/relative).read_text(encoding='utf-8-sig'),encoding='utf8')
        return project

    def test_hyper_crystal_orbit_is_initialized_before_source_controller(self):
        with TemporaryDirectory() as folder:
            project=self.make_project(folder)
            create=project/'objects/HyperCrystal/Create_0.gml'
            apply_native_enemy_fields(project)
            once=create.read_text(encoding='utf8')
            self.assertIn('crystals = 0\n// BEGIN FRONTIER HYPER CRYSTAL ORBIT ARRAY\ncrystal=[];',once)
            self.assertEqual(once.count('crystal=[];'),1)
            self.assertIn('cnumber = (3 + (GameCont.loops * 2))',once)
            apply_native_enemy_fields(project)
            self.assertEqual(once,create.read_text(encoding='utf8'))

    def test_idpd_spawn_exposes_native_alarm_freak_decision_before_replacement(self):
        with TemporaryDirectory() as folder:
            project=self.make_project(folder)
            create=project/'objects/IDPDSpawn/Create_0.gml'
            original=create.read_text(encoding='utf8')
            apply_native_enemy_fields(project)
            once=create.read_text(encoding='utf8')
            self.assertIn('elite = 0\n// BEGIN FRONTIER IDPD SPAWN FREAK\n'
                          'freak=(GameCont.loops-(GameCont.area==0)>=3);',once)
            self.assertEqual(once.count('freak=(GameCont.loops-(GameCont.area==0)>=3);'),1)
            self.assertIn('alarm[0] = 40 + instance_number(IDPDSpawn) * 3',once)
            self.assertIn('elite = !rng_float(RNGStates.Enemies, 5)',once)
            self.assertEqual(original.count('GameCont.popolevel++'),once.count('GameCont.popolevel++'))
            apply_native_enemy_fields(project)
            self.assertEqual(once,create.read_text(encoding='utf8'))


class StatusTimerCleanupTests(unittest.TestCase):
    def make_script(self,folder):
        project=Path(folder)
        source=Path(__file__).resolve().parents[1]/'original/Frontier/Frontier_StatusEffects.mod.gml'
        code=emit(source.read_text(encoding='utf-8-sig'),'step','Frontier_StatusEffects.mod.gml')
        path=project/'scripts/frCode_Frontier_StatusEffects_mod_fixture/frCode_Frontier_StatusEffects_mod_fixture.gml'
        path.parent.mkdir(parents=True)
        path.write_text(code,encoding='utf8')
        return project,path,code

    def test_dead_status_target_is_pruned_without_changing_live_timer(self):
        with TemporaryDirectory() as folder:
            project,path,original=self.make_script(folder)
            self.assertEqual(apply_status_timer_cleanup(project)['status'],'patched')
            updated=path.read_text(encoding='utf8')
            repair=(' else {\n'
                    '// BEGIN FRONTIER RETIRED STATUS TARGET\n'
                    'targets = fr_Frontier_StatusEffects_mod_gml_array_delete(targets, _frl_i);\n'
                    'continue;\n'
                    '// END FRONTIER RETIRED STATUS TARGET\n'
                    '}')
            self.assertEqual(updated.replace(repair,'',1),original)
            self.assertEqual(updated.count(repair),1)
            self.assertLess(updated.index(repair),updated.index('if ((_frl_value <= 0))'))
            self.assertNotIn('var _frl_value = undefined',updated)
            self.assertNotIn('var _frl_value = 0',updated)
            self.assertEqual(apply_status_timer_cleanup(project)['status'],'already-applied')
            self.assertEqual(updated,path.read_text(encoding='utf8'))

    def test_changed_status_timer_anchor_fails_closed(self):
        with TemporaryDirectory() as folder:
            project,path,original=self.make_script(folder)
            changed=original.replace(' - scrFRSourceScale());',' - 99);',1)
            self.assertNotEqual(changed,original)
            path.write_text(changed,encoding='utf8')
            with self.assertRaisesRegex(AssertionError,'Frontier status timer anchor'):
                apply_status_timer_cleanup(project)
            self.assertEqual(changed,path.read_text(encoding='utf8'))


class PathGridBoundaryTests(unittest.TestCase):
    def make_script(self,folder):
        project=Path(folder)
        source=Path(__file__).resolve().parents[1]/'dependencies/libGeneral.mod.gml'
        code=emit(source.read_text(encoding='utf-8-sig'),'path_create','dependencies/libGeneral.mod.gml')
        # The production hook owns only this definition, followed by the next
        # source-map marker in the full compiled module.
        code+='\n// Original next definition\nfunction unrelated() {}\n'
        path=project/'scripts/frCode_libGeneral_mod_fixture/frCode_libGeneral_mod_fixture.gml'
        path.parent.mkdir(parents=True)
        path.write_text(code,encoding='utf8')
        return project,path,code

    def test_only_outer_wall_cells_are_guarded_in_real_source_path(self):
        with TemporaryDirectory() as folder:
            project,path,original=self.make_script(folder)
            self.assertEqual(apply_path_grid_bounds(project)['status'],'patched')
            updated=path.read_text(encoding='utf8')
            before='if (position_meeting(x, y, scrFRSelf(self))) {'
            after=('// FRONTIER PATH GRID HALF-OPEN WALL CELLS\n'
                   'if (x >= _frl__gridx && y >= _frl__gridy\n'
                   '    && x < _frl__gridx + _frl__areaWidth && y < _frl__gridy + _frl__areaHeight\n'
                   '    && position_meeting(x, y, scrFRSelf(self))) {')
            self.assertEqual(updated.replace(after,before,1),original)
            self.assertEqual(apply_path_grid_bounds(project)['status'],'already-applied')
            self.assertEqual(updated,path.read_text(encoding='utf8'))
            instrument_path_grid(project)
            instrumented=path.read_text(encoding='utf8')
            self.assertEqual(instrumented.count('scrFRPathGridTestObserve('),1)
            self.assertIn('os_type==os_windows && scrNTTEFullSmokeEnabled()',instrumented)
            instrument_path_grid(project)
            self.assertEqual(instrumented,path.read_text(encoding='utf8'))

    def test_changed_path_wall_collision_anchor_fails_closed(self):
        with TemporaryDirectory() as folder:
            project,path,original=self.make_script(folder)
            changed=original.replace('if (position_meeting(x, y, scrFRSelf(self))) {',
                                     'if (true) {',1)
            self.assertNotEqual(changed,original)
            path.write_text(changed,encoding='utf8')
            with self.assertRaisesRegex(AssertionError,'Frontier path grid wall anchor'):
                apply_path_grid_bounds(project)
            self.assertEqual(changed,path.read_text(encoding='utf8'))


class CyberspaceReviveHookTests(unittest.TestCase):
    def make_project(self,folder):
        project=Path(folder);root=Path(__file__).resolve().parents[1]
        source=root/'dependencies/wibbly.mod.gml'
        code=emit(source.read_text(encoding='utf-8-sig'),'PlayerManager_step','dependencies/wibbly.mod.gml')
        code+='\n// Original next definition\nfunction unrelated() {}\n'
        script=project/'scripts/frCode_wibbly_mod_fixture/frCode_wibbly_mod_fixture.gml'
        script.parent.mkdir(parents=True);script.write_text(code,encoding='utf8')
        destroy=project/'objects/Player/Destroy_0.gml'
        destroy.parent.mkdir(parents=True)
        destroy.write_text((root.parent/'project/objects/Player/Destroy_0.gml').read_text(encoding='utf-8-sig'),encoding='utf8')
        return project,script,destroy

    def test_real_respawn_branch_reconciles_once_and_native_revive_is_untouched(self):
        with TemporaryDirectory() as folder:
            project,script,destroy=self.make_project(folder)
            original_script=script.read_text(encoding='utf8');original_destroy=destroy.read_text(encoding='utf8')
            native=project/'objects/Revive/Collision_Player.gml'
            native.parent.mkdir(parents=True);native.write_text('ordinary native co-op event',encoding='utf8')
            apply_cyberspace_revive(project)
            updated_script=script.read_text(encoding='utf8');updated_destroy=destroy.read_text(encoding='utf8')
            addition=('\n// BEGIN FRONTIER CYBERSPACE RESPAWN TOTALS\n'
                      'scrFRCyberspaceRespawnReady(id);\n// END FRONTIER CYBERSPACE RESPAWN TOTALS')
            entry=('// BEGIN FRONTIER CYBERSPACE RESPAWN ENTRY\n'
                   'scrFRCyberspaceRespawnBegin(id);\n// END FRONTIER CYBERSPACE RESPAWN ENTRY\n')
            capture=('// BEGIN FRONTIER CYBERSPACE DEAD PLAYER STATE\n'
                     'scrFRCyberspaceRememberPlayer(id);\n// END FRONTIER CYBERSPACE DEAD PLAYER STATE\n')
            self.assertEqual(updated_script.replace(addition,'',1).replace(entry,'',1),original_script)
            self.assertEqual(updated_destroy.replace(capture,'',1),original_destroy)
            self.assertLess(updated_script.index('accuracy = 0;'),updated_script.index('scrFRCyberspaceRespawnReady(id);'))
            self.assertLess(updated_script.index('scrFRCyberspaceRespawnBegin(id);'),updated_script.index('scrFRCyberspaceRespawnReady(id);'))
            self.assertEqual(native.read_text(encoding='utf8'),'ordinary native co-op event')
            apply_cyberspace_revive(project)
            self.assertEqual(updated_script,script.read_text(encoding='utf8'))
            self.assertEqual(updated_destroy,destroy.read_text(encoding='utf8'))

    def test_changed_respawn_owner_rejects_before_mutating_player_death(self):
        with TemporaryDirectory() as folder:
            project,script,destroy=self.make_project(folder)
            old_destroy=destroy.read_text(encoding='utf8')
            changed=script.read_text(encoding='utf8').replace('accuracy = 0;','accuracy = 1;',1)
            script.write_text(changed,encoding='utf8')
            with self.assertRaisesRegex(AssertionError,'Cyberspace Wibbly respawn totals anchor'):
                apply_cyberspace_revive(project)
            self.assertEqual(changed,script.read_text(encoding='utf8'))
            self.assertEqual(old_destroy,destroy.read_text(encoding='utf8'))


if __name__=='__main__':
    unittest.main(verbosity=2)
