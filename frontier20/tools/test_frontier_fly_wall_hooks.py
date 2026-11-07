"""The fly installer must not invalidate the preceding wall hook on restage."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

import fr_fly_wall_hooks as fly
from fr_wall_hooks import _replace


class FlyWallHookTests(unittest.TestCase):
    def fixture(self, source, newline="\n", bom=False):
        temporary = TemporaryDirectory(dir=Path(__file__).resolve().parents[1] / "review")
        self.addCleanup(temporary.cleanup)
        project = Path(temporary.name)
        path = project / fly.RELATIVE
        path.parent.mkdir(parents=True)
        path.write_bytes((b"\xef\xbb\xbf" if bom else b"") + source.replace("\n", newline).encode("utf8"))
        return project, path

    def check_restage(self, source, newline="\n", bom=False):
        project, path = self.fixture(source, newline, bom)
        fly.apply(project)
        expected = path.read_bytes()
        for _ in range(3):
            # Exercise the real earlier installer after our insertion.
            _replace(path, fly.ROUND_ANCHOR,
                     fly.WALL_PREFIX.rstrip() + "\n" + fly.ROUND_ANCHOR, [])
            fly.apply(project)
            self.assertEqual(path.read_bytes(), expected)
        text = path.read_text("utf-8-sig")
        self.assertEqual(text.count("scrFRWallTopConstrainSpawn(id);"), 1)
        self.assertEqual(text.count("scrFRFlyWallSpawn(id);"), 1)
        self.assertLess(text.index(fly.ROUND_ANCHOR), text.index("scrFRFlyWallSpawn(id);"))

    def test_new_install_and_earlier_wall_hook_are_byte_stable(self):
        self.check_restage("function fixture() {\n" + fly.WALL_PREFIX + fly.ROUND_ANCHOR + "\n}\n")

    def test_legacy_position_upgrades_once(self):
        block = ("// BEGIN FRONTIER JUNGLE FLY WALL DESCENT\n"
                 "scrFRFlyWallSpawn(id);\n// END FRONTIER JUNGLE FLY WALL DESCENT\n\n")
        self.check_restage("function fixture() {\n" + fly.WALL_PREFIX + block + fly.ROUND_ANCHOR + "\n}\n")

    def test_failed_restage_duplicate_is_repaired(self):
        block = ("// BEGIN FRONTIER JUNGLE FLY WALL DESCENT\n"
                 "scrFRFlyWallSpawn(id);\n// END FRONTIER JUNGLE FLY WALL DESCENT\n\n")
        self.check_restage("function fixture() {\n" + fly.WALL_PREFIX + block
                           + fly.WALL_PREFIX + fly.ROUND_ANCHOR + "\n}\n")

    def test_crlf_and_bom_do_not_accumulate_hook_whitespace(self):
        self.check_restage("function fixture() {\n" + fly.WALL_PREFIX + fly.ROUND_ANCHOR + "\n}\n",
                           newline="\r\n", bom=True)


if __name__ == "__main__":
    unittest.main()
