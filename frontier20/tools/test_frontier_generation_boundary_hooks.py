"""Save/wall installer interaction on copied frozen source, never the live stage."""
from pathlib import Path
from tempfile import TemporaryDirectory
import shutil
import unittest

import fr_save_hooks
import fr_wall_hooks


ROOT = Path(__file__).resolve().parents[1]
FROZEN = ROOT / "history/2.0-delivered-20261106/staging/project"
RELATIVE = "scripts/scrNTTEFullInRoomGeneration/scrNTTEFullInRoomGeneration.gml"
ANCHOR = "        _generation.ntte_full_set_area=_set_area"
BEGIN = "        if(_set_area) with(_generation) scrFRContinueGenerationBegin(true);"
DEFER = ("        // The appended geometry must merge before a compact collar is\n"
         "        // made. A temporary target collar can cover the entire old map.\n"
         "        _generation.ntte_full_sync_compact_defer=true")


class GenerationBoundaryHookTests(unittest.TestCase):
    def make_project(self, folder):
        project = Path(folder)
        files = [RELATIVE,
                 "scripts/scrSavegame/scrSavegame.gml",
                 "scripts/scrNTTEFullMergedNative/scrNTTEFullMergedNative.gml",
                 "objects/GenCont/Create_0.gml",
                 "scripts/scrNTTESolidWalls/scrNTTESolidWalls.gml",
                 "scripts/scrNTTEFullLairBorder/scrNTTEFullLairBorder.gml",
                 "objects/GenCont/Destroy_0.gml",
                 "scripts/scrNTTEFullCrystalHeart/scrNTTEFullCrystalHeart.gml",
                 "objects/SubTopCont/Draw_0.gml",
                 "objects/Player/Collision_Wall.gml",
                 "objects/WepPickup/Collision_Wall.gml",
                 "scripts/scrNTTEFullWallFakeNative/scrNTTEFullWallFakeNative.gml",
                 "scripts/scrNTTEFullTop/scrNTTEFullTop.gml"]
        for relative in files:
            target = project / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(FROZEN / relative, target)
        return project, project / RELATIVE

    def run_pair(self, project):
        fr_save_hooks.apply(project)
        fr_wall_hooks.apply(project)

    def test_frozen_and_repeated_incremental_forms_converge_and_stay_stable(self):
        for count in (0, 1, 2, 13):
            with self.subTest(pairs=count), TemporaryDirectory() as folder:
                project, path = self.make_project(folder)
                frozen = path.read_text("utf-8-sig")
                self.assertEqual(frozen.count(BEGIN), 1)
                self.assertNotIn("ntte_full_sync_compact_defer", frozen)
                boundary = "\n" + BEGIN
                if count:
                    boundary = ("\n" + DEFER + "\n" + BEGIN + "\n") * count
                original = frozen.replace("\n" + BEGIN, boundary, 1)
                path.write_text(original, encoding="utf8", newline="\n")
                self.run_pair(project)
                first = path.read_bytes()
                result = first.decode("utf8")
                self.assertEqual(result.count(BEGIN), 1)
                self.assertEqual(result.count(DEFER), 1)
                self.assertIn(ANCHOR + "\n" + DEFER + "\n" + BEGIN, result)
                # Three full subsequent build orders must not accumulate more
                # save hooks or otherwise rewrite any of these frozen scripts.
                snapshot = {p.relative_to(project): p.read_bytes()
                            for p in project.rglob("*") if p.is_file()}
                for _ in range(3):
                    self.run_pair(project)
                    self.assertEqual(snapshot, {p.relative_to(project): p.read_bytes()
                                               for p in project.rglob("*") if p.is_file()})

    def test_unpatched_anchor_and_transient_save_first_form(self):
        for boundary in ("", "\n" + BEGIN + "\n" + DEFER + "\n" + BEGIN):
            with self.subTest(boundary=boundary), TemporaryDirectory() as folder:
                project, path = self.make_project(folder)
                original = path.read_text("utf-8-sig")
                path.write_text(original.replace("\n" + BEGIN, boundary, 1), encoding="utf8")
                self.run_pair(project)
                result = path.read_text("utf8")
                self.assertEqual(result.count(BEGIN), 1)
                self.assertEqual(result.count(DEFER), 1)

    def test_boundary_cleanup_preserves_all_unrelated_text_newlines_and_bom(self):
        for newline in ("\n", "\r\n"):
            for bom in (b"", b"\xef\xbb\xbf"):
                with self.subTest(newline=repr(newline), bom=bool(bom)), TemporaryDirectory() as folder:
                    project = Path(folder)
                    path = project / RELATIVE
                    path.parent.mkdir(parents=True)
                    prefix = "// unrelated prefix  \n" + ANCHOR
                    suffix = "\n\n        unrelated_generation(); // keep  \n"
                    original = prefix + ("\n" + DEFER + "\n" + BEGIN + "\n") * 13 + suffix
                    path.write_bytes(bom + original.replace("\n", newline).encode("utf8"))
                    fr_save_hooks.apply_inroom_generation_boundary(project, [])
                    # The final block's existing trailing newline also belongs
                    # to the suffix and is retained exactly.
                    expected = prefix + "\n" + DEFER + "\n" + BEGIN + "\n" + suffix
                    self.assertEqual(path.read_bytes(), bom + expected.replace("\n", newline).encode("utf8"))
                    first = path.read_bytes()
                    fr_save_hooks.apply_inroom_generation_boundary(project, [], compact_defer=True)
                    self.assertEqual(first, path.read_bytes())

    def test_malformed_or_displaced_boundary_fails_without_writing(self):
        malformed = [
            "\n" + DEFER,  # Incomplete pair.
            "\n" + BEGIN + "\n" + BEGIN,  # Unknown repeated save-only hook.
            "\n" + DEFER + "\n" + BEGIN.replace("(true)", "(false)"),
            "\n" + DEFER.replace("true", "false") + "\n" + BEGIN,
            "\n" + BEGIN + "\n        unrelated();\n" + DEFER + "\n" + BEGIN,
            "\n" + DEFER.replace("compact collar", "different collar") + "\n" + BEGIN,
        ]
        for boundary in malformed:
            with self.subTest(boundary=boundary), TemporaryDirectory() as folder:
                project = Path(folder)
                path = project / RELATIVE
                path.parent.mkdir(parents=True)
                original = ("// before\n" + ANCHOR + boundary + "\n// after\n").encode("utf8")
                path.write_bytes(original)
                with self.assertRaisesRegex(RuntimeError, "Frontier generation boundary"):
                    fr_save_hooks.apply_inroom_generation_boundary(project, [], compact_defer=True)
                self.assertEqual(original, path.read_bytes())


if __name__ == "__main__":
    unittest.main()
