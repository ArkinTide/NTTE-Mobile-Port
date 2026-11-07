"""Menu repair hooks preserve IDs and remain safe across repeated staging."""
from pathlib import Path
import json
import shutil
import tempfile
import unittest
from fr_menu_hooks import ROOT, apply

FILES=(
    'scripts/scrNTTEFullCrownLoadoutNative/scrNTTEFullCrownLoadoutNative.gml',
    'objects/CustomModeWeaponSelector/Other_11.gml',
    'objects/CustomModeWeaponSelector/Other_10.gml',
    'scripts/scr_create_debug_overlay_views/scr_create_debug_overlay_views.gml',
)

class FrontierMenuHooksTests(unittest.TestCase):
    def test_menu_stage_is_repeatable_without_changing_stable_id_ledger(self):
        ledger=(ROOT/'staging/identity-ledger.json').read_bytes()
        with tempfile.TemporaryDirectory(prefix='fr-menu-') as temporary:
            project=Path(temporary)
            for relative in FILES:
                target=project/relative;target.parent.mkdir(parents=True,exist_ok=True)
                shutil.copyfile(ROOT/'staging/project'/relative,target)
            (project/'nuclearthronemobile.yyp').write_text('{"resources":[]}', 'utf8')
            apply(project)
            first={p.relative_to(project).as_posix():p.read_bytes() for p in project.rglob('*') if p.is_file()}
            apply(project)
            self.assertEqual(first,{p.relative_to(project).as_posix():p.read_bytes() for p in project.rglob('*') if p.is_file()})
            populate=(project/FILES[1]).read_text('utf8')
            self.assertIn('scrFRCustomWeaponGroups()',populate)
            view=(project/FILES[3]).read_text('utf8')
            self.assertIn('scrFRDebugFonts()',view)
            self.assertIn('scrFRDebugAreaLabel(_area,_subarea)',view)
            self.assertNotIn('scrAreaGetMapName(_area, _subarea, 0, false, false),',view)
        self.assertEqual(ledger,(ROOT/'staging/identity-ledger.json').read_bytes())

    def test_locked_storms_has_real_second_frame_and_native_loadout_origin(self):
        resource=ROOT/'native/menu-assets/sprFRStormsLoadout'
        data=json.loads((resource/'sprFRStormsLoadout.yy').read_text('utf8'))
        self.assertEqual(len(data['frames']),2)
        self.assertEqual((data['width'],data['height']),(32,32))
        self.assertEqual((data['sequence']['xorigin'],data['sequence']['yorigin']),(16,16))
        for frame in data['frames']:
            self.assertTrue((resource/(frame['name']+'.png')).is_file())
            self.assertTrue((resource/'layers'/frame['name']/(data['layers'][0]['name']+'.png')).is_file())
        self.assertNotEqual((resource/(data['frames'][0]['name']+'.png')).read_bytes(),
                            (resource/(data['frames'][1]['name']+'.png')).read_bytes())

if __name__=='__main__': unittest.main()
