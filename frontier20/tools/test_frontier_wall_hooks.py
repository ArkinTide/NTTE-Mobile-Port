"""Exercise the packed-colour installer against fresh and earlier stages."""
from pathlib import Path
import shutil
from tempfile import TemporaryDirectory
import unittest

from fr_wall_hooks import (apply, _replace, apply_player_wall_contact, PLAYER_WALL_PATCHES,
                          apply_pickup_wall_contact, PICKUP_WALL_BEFORE, PICKUP_WALL_AFTER)


ROOT=Path(__file__).resolve().parents[1]
OLD_CREATE=('area=GameCont.area;solid=true;visible=false;mask_index=mskWall;\n'
            '    // Retain actual source weather/area colour per packed piece.\n'
            '    ntte_fill_color=scrFRWallBackgroundColor();')
NEW_CREATE=OLD_CREATE+'ntte_fill_color_area=area;'
PIECE='_v.area=_state.area;_v.image_blend=_state.blend;_v.image_alpha=_state.alpha;'
OLD_PIECE=PIECE+'\n    _v.ntte_fill_color=_state.color;'
NEW_PIECE=PIECE+'\n    scrFRWallCopyFillColor(_v,_state);'
BORDER='_state={area:_created.area,blend:_created.image_blend,alpha:_created.image_alpha};'
NEW_BORDER=('_state={area:_created.area,blend:_created.image_blend,alpha:_created.image_alpha,\n'
            '                    color:scrFRWallFillColor(_created),color_area:_created.area};')


class WallColourInstallerTests(unittest.TestCase):
    def fixture(self,folder,fresh=False):
        project=Path(folder)
        relatives=[f'scripts/{name}/{name}.gml' for name in (
            'scrNTTESolidWalls','scrNTTEFullLairBorder','scrNTTEFullInRoomGeneration',
            'scrNTTEFullCrystalHeart','scrNTTEFullWallFakeNative','scrNTTEFullTop')]
        relatives+=['objects/GenCont/Destroy_0.gml','objects/SubTopCont/Draw_0.gml',
                    'objects/Player/Collision_Wall.gml','objects/WepPickup/Collision_Wall.gml']
        for relative in relatives:
            path=project/relative
            path.parent.mkdir(parents=True,exist_ok=True)
            shutil.copyfile(ROOT/'staging/project'/relative,path)
        walls=project/'scripts/scrNTTESolidWalls/scrNTTESolidWalls.gml'
        code=walls.read_text('utf-8-sig').replace(NEW_CREATE,OLD_CREATE).replace(NEW_PIECE,OLD_PIECE)
        if fresh:
            code=code.replace(OLD_CREATE,'area=GameCont.area;solid=true;visible=false;mask_index=mskWall;')
            code=code.replace(OLD_PIECE,PIECE)
        walls.write_text(code,'utf-8',newline='\n')
        border=project/'scripts/scrNTTEFullLairBorder/scrNTTEFullLairBorder.gml'
        border.write_text(border.read_text('utf-8-sig').replace(NEW_BORDER,BORDER),'utf-8',newline='\n')
        return project,walls,border

    def test_upgrade_prior_colour_stage_without_duplicate_assignments(self):
        with TemporaryDirectory() as folder:
            project,walls,border=self.fixture(folder)
            report=apply(project)
            self.assertEqual(sum(row['status']=='upgraded' for row in report),2)
            self.assertIn(NEW_CREATE,walls.read_text('utf-8'))
            self.assertIn(NEW_PIECE,walls.read_text('utf-8'))
            self.assertNotIn('ntte_fill_color=_state.color;',walls.read_text('utf-8'))
            self.assertIn(NEW_BORDER,border.read_text('utf-8'))
            once={str(path.relative_to(project)):path.read_bytes() for path in project.rglob('*.gml')}
            apply(project)
            self.assertEqual(once,{str(path.relative_to(project)):path.read_bytes() for path in project.rglob('*.gml')})

    def test_fresh_native_three_field_caller_and_colour_install_is_idempotent(self):
        with TemporaryDirectory() as folder:
            project,walls,border=self.fixture(folder,fresh=True)
            apply(project)
            self.assertEqual(walls.read_text('utf-8').count('scrFRWallCopyFillColor(_v,_state);'),1)
            self.assertEqual(border.read_text('utf-8').count('color_area:_created.area'),1)
            once=walls.read_bytes(),border.read_bytes()
            apply(project)
            self.assertEqual(once,(walls.read_bytes(),border.read_bytes()))

    def test_changed_piece_anchor_fails_without_writing(self):
        with TemporaryDirectory() as folder:
            path=Path(folder)/'piece.gml'
            path.write_text(OLD_PIECE.replace('_state.area','_state.biome'),'utf-8')
            before=path.read_bytes()
            with self.assertRaisesRegex(RuntimeError,'wall fix anchor changed'):
                _replace(path,PIECE,NEW_PIECE,[],legacy=OLD_PIECE)
            self.assertEqual(before,path.read_bytes())

    def test_player_contact_uses_original_tile_and_is_idempotent(self):
        with TemporaryDirectory() as folder:
            project=Path(folder)
            target=project/'objects/Player/Collision_Wall.gml'
            target.parent.mkdir(parents=True)
            frozen=ROOT/'history/2.0-delivered-20261106/staging/project/objects/Player/Collision_Wall.gml'
            original=frozen.read_text('utf-8-sig')
            target.write_text(original,'utf-8')
            apply_player_wall_contact(project,[])
            result=target.read_text('utf-8')
            expected=original
            for before,after in PLAYER_WALL_PATCHES:
                self.assertEqual(expected.count(before),1)
                expected=expected.replace(before,after,1)
            self.assertEqual(result,expected)
            self.assertIn('if(instance_is(other.id,NTTEFullWallFake)) exit;',result)
            self.assertIn('move_bounce_solid(true)',result)
            self.assertIn('scrWallDestroy(other.id)',result)
            first=target.read_bytes()
            apply_player_wall_contact(project,[])
            self.assertEqual(first,target.read_bytes())

    def test_player_contact_changed_or_duplicate_anchor_is_transactional(self):
        frozen=ROOT/'history/2.0-delivered-20261106/staging/project/objects/Player/Collision_Wall.gml'
        source=frozen.read_text('utf-8-sig')
        patched=source
        for before,after in PLAYER_WALL_PATCHES:
            patched=patched.replace(before,after,1)
        for malformed in (source.replace('with (other) {','with (other.id) {'),
                          source+'\n'+PLAYER_WALL_PATCHES[0][0],
                          patched+'\n'+PLAYER_WALL_PATCHES[0][0],
                          patched+'\n'+PLAYER_WALL_PATCHES[1][0]):
            with self.subTest(malformed=malformed[-80:]),TemporaryDirectory() as folder:
                project=Path(folder)
                target=project/'objects/Player/Collision_Wall.gml'
                target.parent.mkdir(parents=True)
                target.write_text(malformed,'utf-8')
                before=target.read_bytes()
                with self.assertRaisesRegex(RuntimeError,'Player wall contact'):
                    apply_player_wall_contact(project,[])
                self.assertEqual(before,target.read_bytes())

    def test_pickup_contact_preserves_native_event_and_is_idempotent(self):
        with TemporaryDirectory() as folder:
            project=Path(folder)
            target=project/'objects/WepPickup/Collision_Wall.gml'
            target.parent.mkdir(parents=True)
            frozen=ROOT/'history/2.0-delivered-20261106/staging/project/objects/WepPickup/Collision_Wall.gml'
            original=frozen.read_text('utf-8-sig')
            self.assertEqual(original.count(PICKUP_WALL_BEFORE),1)
            target.write_text(original,'utf-8')
            apply_pickup_wall_contact(project,[])
            result=target.read_text('utf-8')
            self.assertEqual(result,original.replace(PICKUP_WALL_BEFORE,PICKUP_WALL_AFTER,1))
            self.assertIn('scrNTTEFullMergedNativeCollisionBegin(id,other.id)',result)
            self.assertIn('scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision)',result)
            self.assertIn('speed *= 0.4',result)
            self.assertNotIn('scrNTTESolidWallMaterialize(',result)
            first=target.read_bytes()
            apply_pickup_wall_contact(project,[])
            self.assertEqual(first,target.read_bytes())

    def test_pickup_contact_changed_or_duplicate_anchor_is_transactional(self):
        frozen=ROOT/'history/2.0-delivered-20261106/staging/project/objects/WepPickup/Collision_Wall.gml'
        source=frozen.read_text('utf-8-sig')
        patched=source.replace(PICKUP_WALL_BEFORE,PICKUP_WALL_AFTER,1)
        for malformed in (source.replace('move_bounce_solid(true)','move_bounce_solid(false)'),
                          source+'\n'+PICKUP_WALL_BEFORE,
                          patched+'\n'+PICKUP_WALL_BEFORE,
                          patched+'\n'+PICKUP_WALL_AFTER):
            with self.subTest(malformed=malformed[-80:]),TemporaryDirectory() as folder:
                project=Path(folder)
                target=project/'objects/WepPickup/Collision_Wall.gml'
                target.parent.mkdir(parents=True)
                target.write_text(malformed,'utf-8')
                before=target.read_bytes()
                with self.assertRaisesRegex(RuntimeError,'pickup wall contact'):
                    apply_pickup_wall_contact(project,[])
                self.assertEqual(before,target.read_bytes())


if __name__=='__main__':
    unittest.main()
