"""Verify localization boundaries on the supplied Frontier source corpus."""
from pathlib import Path
import json
import shutil
import tempfile
import unittest

from test_frontier_compiler import emit
from fr_localization_data import ROOT, audit, dictionary, plain
from fr_localization_hooks import apply, hook_specs


class FrontierLocalizationTests(unittest.TestCase):
    def test_supplied_display_corpus_and_baked_fonts_have_complete_coverage(self):
        result=audit()
        self.assertEqual(result["untranslated"],[])
        self.assertGreater(result["translated_literals"],1100)
        self.assertEqual(result["status"],"PASS")
        self.assertTrue(all(not row["missing"] for row in result["fonts"].values()))

    def test_source_metadata_is_localized_but_weapon_identity_is_not(self):
        source=(ROOT/"original/Frontier/Weapons/FR_Blunderbuss.wep.gml").read_text("utf-8-sig")
        display=emit(source,"weapon_name","Weapons/FR_Blunderbuss.wep.gml")
        self.assertIn('return scrFRLocalize("BLUNDERBUSS");',display)
        raw=emit('#define main\nname="fr_Blunderbuss";hitid=[-4,"GRAPESHOT"];'
                 'mod_script_call("wep","FR_Blunderbuss","weapon_name");',
                 "main","Weapons/FR_Blunderbuss.wep.gml")
        self.assertNotIn("scrFRLocalize",raw)
        self.assertIn('name = "fr_Blunderbuss"',raw)
        self.assertIn('"wep", "FR_Blunderbuss", "weapon_name"',raw)

    def test_native_popup_and_loc_are_frontier_scoped(self):
        source='#define main\ntext="OPEN?";mytext="BUBBLES";var text; text="Internal local";global.text="Internal global";return loc("Frontier:Key","OPEN?");'
        code=emit(source,"main","Objects/Frontier_Objects.mod.gml")
        self.assertIn('mytext = scrFRLocalize("BUBBLES")',code)
        self.assertIn('scrFRLoc("Frontier:Key", "OPEN?")',code)
        self.assertNotIn('scrFRLocalize("Internal local")',code)
        self.assertNotIn('scrFRLocalize("Internal global")',code)
        dependency=emit('#define weapon_name\ntext="OPEN?";return loc("Frontier:Key","BUBBLES");',
                        "weapon_name","dependencies/another.mod.gml")
        self.assertNotIn("scrFRLocalize",dependency)
        self.assertNotIn("scrFRLoc(",dependency)
        self.assertIn('loc("Frontier:Key", "BUBBLES")',dependency)

    def test_actual_skin_trinket_and_weather_metadata_are_localized(self):
        for module,name in (("Skins/RobotBluescreened.skin.gml","skin_name"),
                            ("Trinkets/TrinketReservation.mod.gml","trinket_text"),
                            ("Frontier_Events.mod.gml","MeteorShower_text")):
            with self.subTest(module=module,name=name):
                source=(ROOT/"original/Frontier"/module).read_text("utf-8-sig")
                self.assertIn("return scrFRLocalize(",emit(source,name,module))

    def test_actual_star_pistol_display_is_localized_and_its_module_key_stays_raw(self):
        module="Weapons/FR_StarPistol.wep.gml"
        source=(ROOT/"original/Frontier"/module).read_text("utf-8-sig")
        code=emit(source,"weapon_name",module)
        self.assertIn('return scrFRLocalize("LITTLE DIPPER");',code)
        self.assertEqual(dictionary()["LITTLE DIPPER"],"小北斗")
        dispatch=emit('#define main\nvar held="FR_StarPistol";var slots=[held];'
                      'return mod_script_call("weapon",slots[0],"weapon_name");',
                      "main",module)
        self.assertIn('"FR_StarPistol"',dispatch)
        self.assertIn('"weapon_name"',dispatch)
        self.assertNotIn("scrFRLocalize",dispatch)

    def test_actual_custom_popup_shadow_uses_cjk_at_the_final_draw_boundary(self):
        module="Objects/Frontier_Objects.mod.gml"
        source=(ROOT/"original/Frontier"/module).read_text("utf-8-sig")
        code=emit(source,"draw_text_tilt_shadow",module)
        self.assertEqual(code.count("scrFRDrawTextTransformedColor("),2)
        self.assertNotIn("\ndraw_text_transformed_color(",code)
        # Both arbitrary main text and unmodified subtext pass through this
        # draw-only adapter; the source object's stored identities stay raw.
        self.assertIn("_frl_str",code)

    def test_presentation_hooks_are_idempotent_and_do_not_replace_ntte_dictionary(self):
        with tempfile.TemporaryDirectory(prefix="fr-localization-") as temporary:
            project=Path(temporary)
            for spec in hook_specs():
                target=project/spec["path"]
                target.parent.mkdir(parents=True,exist_ok=True)
                shutil.copyfile(ROOT/"staging/project"/spec["path"],target)
            first=apply(project)
            original=(ROOT/"staging/project"/hook_specs()[0]["path"]).read_text("utf-8-sig")
            changed=(project/hook_specs()[0]["path"]).read_text("utf-8-sig")
            dictionary_marker="function scrNTTEFullLocalizeDictionary()"
            self.assertEqual(original[original.index(dictionary_marker):],changed[changed.index(dictionary_marker):])
            self.assertTrue(all(row["status"] in {"patched","already-applied"} for row in first))
            self.assertTrue(all(row["status"]=="already-applied" for row in apply(project)))

    def test_reviewed_display_dictionary_is_generated_without_drift(self):
        source=(ROOT/"native/localization_data.gml").read_text("utf-8")
        body=source.split("static _data={",1)[1].split("\n    };",1)[0]
        generated=json.loads("{"+body+"}")
        self.assertEqual(generated,dictionary())
        self.assertEqual(plain('@wMENU\n  #@sENTRY'),"MENU / ENTRY")


if __name__=="__main__":
    unittest.main()
