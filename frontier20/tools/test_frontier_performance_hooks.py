"""Profiling flavor roundtrips must restore all four originals byte-for-byte."""
from pathlib import Path
from tempfile import TemporaryDirectory
import unittest

from fr_performance_hooks import TARGETS, apply


class PerformanceHookTests(unittest.TestCase):
    def make_project(self, folder):
        project = Path(folder)
        files = {}
        for index, (directory, name, _) in enumerate(TARGETS):
            newline = "\r\n" if index % 2 else "\n"
            source = ("// unaffected prefix\nfunction " + name + "(_code,_args) {\n"
                      '    var _text="braces } \\\" {"; // comment }\n'
                      "    /* ignored { and } */\n"
                      "    if(_code) {return {value:42};}\n    return undefined;\n}\n"
                      "// unaffected following comment with }\n"
                      "function following_function() {return 9;}\n")
            source = source.replace("\n", newline)
            if index == 3:
                source = "\ufeff" + source
            path = project / "scripts" / directory / (directory + ".gml")
            files[path] = source.encode("utf8")
        path = project / "scripts/scrFrontier_performance_tests/scrFrontier_performance_tests.gml"
        files[path] = b"#macro FR_PROFILE_COMPILED false\r\nfunction probe() {return FR_PROFILE_COMPILED;}\r\n"
        for path, content in files.items():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)
        return project, files

    def contents(self, files):
        return {path: path.read_bytes() for path in files}

    def test_enabled_enabled_disabled_disabled_restores_every_original(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            self.assertFalse(apply(project)["instrumented"])
            self.assertEqual(original, self.contents(original))
            self.assertTrue(apply(project, enabled=True)["instrumented"])
            enabled = self.contents(original)
            for directory, name, _ in TARGETS:
                text = (project / "scripts" / directory / (directory + ".gml")).read_text("utf8")
                self.assertEqual(text.count("// FRONTIER PROFILE " + name), 1)
                self.assertEqual(text.count("scrFRProfileEnter("), 1)
                self.assertEqual(text.count("scrFRProfileExit("), 1)
            self.assertIn(b"FR_PROFILE_COMPILED true", next(content for path, content in enabled.items() if "performance_tests" in str(path)))
            apply(project, enabled=True)
            self.assertEqual(enabled, self.contents(original))
            apply(project, enabled=False)
            self.assertEqual(original, self.contents(original))
            for content in self.contents(original).values():
                self.assertNotIn(b"// FRONTIER PROFILE", content)
                self.assertNotIn(b"_fr_profile_token", content)
                self.assertNotIn(b"finally", content)
            apply(project, enabled=False)
            self.assertEqual(original, self.contents(original))

    def test_old_standardized_baseline_wrapper_is_removed(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            # Reproduce the previous installer's standardized layout directly,
            # including both line endings. The floor baseline may retain it
            # even after every Frontier-owned native script is regenerated.
            for directory, name, key in TARGETS:
                path = project / "scripts" / directory / (directory + ".gml")
                text = path.read_bytes().decode("utf8")
                opening = text.index("{", text.index("function " + name + "("))
                following = text.index("// unaffected following")
                closing = text.rfind("}", opening, following)
                nl = "\r\n" if "\r\n" in text else "\n"
                prefix = (nl + "// FRONTIER PROFILE " + name + nl
                          + "var _fr_profile_token=scrFRProfileEnter(" + key + ");" + nl + "try {" + nl)
                suffix = nl + "} finally {scrFRProfileExit(_fr_profile_token);}" + nl
                path.write_bytes((text[:opening + 1] + prefix + text[opening + 1:closing] + suffix + text[closing:]).encode("utf8"))
            apply(project)
            self.assertEqual(original, self.contents(original))

    def test_changed_wrapper_rejects_without_partial_writes(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            apply(project, enabled=True)
            directory, _, _ = TARGETS[-1]
            path = project / "scripts" / directory / (directory + ".gml")
            path.write_bytes(path.read_bytes().replace(b"scrFRProfileExit(_fr_profile_token);", b"changed_exit();"))
            before = self.contents(original)
            with self.assertRaisesRegex(AssertionError, "standardized wrapper changed"):
                apply(project)
            self.assertEqual(before, self.contents(original))

    def test_missing_macro_rejects_without_partial_writes(self):
        with TemporaryDirectory() as folder:
            project, original = self.make_project(folder)
            path = project / "scripts/scrFrontier_performance_tests/scrFrontier_performance_tests.gml"
            path.write_bytes(b"function no_macro() {}\n")
            before = self.contents(original)
            with self.assertRaisesRegex(AssertionError, "build macro changed"):
                apply(project, enabled=True)
            self.assertEqual(before, self.contents(original))


if __name__ == "__main__":
    unittest.main()
