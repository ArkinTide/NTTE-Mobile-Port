"""Transactional installer checks on real frozen ProtoChest source fixtures.

Runtime storage/menu/new-run/pickup/fire lives in native/proto_chest_tests.gml;
these tests do not claim to execute GameMaker or touch a player save.
"""
from pathlib import Path
from tempfile import TemporaryDirectory
from itertools import product
import unittest

import repair_proto_chest_persistence as repair
import fr_save_hooks


ROOT = Path(__file__).resolve().parents[1]
FROZEN = ROOT / "history/2.0-delivered-20261106/staging/project"
FILES = (
    "scripts/scrNTTEFullWeaponLoadoutNative/scrNTTEFullWeaponLoadoutNative.gml",
    "scripts/scrSave/scrSave.gml",
    "objects/ProtoChest/Create_0.gml",
    "objects/ProtoChest/Other_5.gml",
)


class ProtoChestPersistenceInstallerTests(unittest.TestCase):
    def fixture(self, directory, crlf=False, bom=False):
        project = Path(directory)
        for relative in FILES:
            target = project / relative
            target.parent.mkdir(parents=True, exist_ok=True)
            data = (FROZEN / relative).read_text("utf-8-sig").replace("\r\n", "\n")
            encoded = data.replace("\n", "\r\n" if crlf else "\n").encode("utf8")
            target.write_bytes((b"\xef\xbb\xbf" if bom else b"") + encoded)
        return project

    def snapshot(self, project):
        return {relative: (project / relative).read_bytes() for relative in FILES}

    def test_real_old_source_fails_durable_boundary_then_patch_is_idempotent(self):
        for crlf, bom in ((False, False), (True, False), (True, True)):
            with self.subTest(crlf=crlf, bom=bom), TemporaryDirectory() as directory:
                project = self.fixture(directory, crlf=crlf, bom=bom)
                old = self.snapshot(project)
                self.assertIn(b'save_set_value("etc", "protowep", protowep)', old[FILES[1]])
                self.assertNotIn(b"scrNTTEFullProtoWeaponRestore", old[FILES[2]])
                self.assertNotIn(b"protowep_model", old[FILES[0]])
                self.assertEqual(len(repair.apply([project])), 4)
                changed = self.snapshot(project)
                self.assertEqual(repair.apply([project]), [])
                self.assertEqual(changed, self.snapshot(project))
                for relative, data in changed.items():
                    self.assertEqual(data.startswith(b"\xef\xbb\xbf"), bom, relative)
                    if crlf:
                        self.assertNotIn(b"\n", data.replace(b"\r\n", b""), relative)
                    else:
                        self.assertNotIn(b"\r", data, relative)
                # The patch preserves the ordinary native file/JSON transaction;
                # it changes only the one protowep write expression in scrSave.
                before = old[FILES[1]].replace(b'save_set_value("etc", "protowep", protowep)', b'scrNTTEFullProtoWeaponSave(protowep)')
                self.assertEqual(changed[FILES[1]], before)
                self.assertIn(b'json_stringify(scrNTTEFullLoadoutWeaponPack(_model))', changed[FILES[0]])
                self.assertIn(b'!(scrGameIsEventRun() || scrGameIsCustomMode())', changed[FILES[3]])
                self.assertIn(b'!(scrGameIsEventRun() || scrGameIsCustomMode())', changed[FILES[2]])

    def test_existing_v1_create_upgrades_once_and_retains_custom_event_isolation(self):
        for crlf, bom in ((False, False), (True, True)):
            with self.subTest(crlf=crlf, bom=bom), TemporaryDirectory() as directory:
                project = self.fixture(directory, crlf=crlf, bom=bom)
                repair.apply([project])
                create = project / FILES[2]
                guard = b'if (!instance_exists(CoopController) && !(scrGameIsEventRun() || scrGameIsCustomMode())) {'
                old_guard = b'if (!instance_exists(CoopController)) {'
                create.write_bytes(create.read_bytes().replace(guard, old_guard, 1))
                before = self.snapshot(project)
                report = repair.apply([project])
                self.assertEqual([row["path"] for row in report], [str(create)])
                after = self.snapshot(project)
                self.assertEqual(after[FILES[2]], before[FILES[2]].replace(old_guard, guard, 1))
                self.assertEqual(after[FILES[2]].count(b'scrNTTEFullProtoWeaponRestore(wep)'), 1)
                self.assertEqual(repair.apply([project]), [])
                self.assertEqual(self.snapshot(project), after)

    def test_known_helpers_upgrade_transactionally_without_duplicate_functions(self):
        for previous, (crlf, bom) in product((repair.HELPERS_V1, repair.HELPERS_V2),
                                            ((False, False), (True, True))):
            with self.subTest(previous=previous[:32], crlf=crlf, bom=bom), TemporaryDirectory() as directory:
                project = self.fixture(directory, crlf=crlf, bom=bom)
                repair.apply([project])
                helpers = project / FILES[0]
                newline = "\r\n" if crlf else "\n"
                final = repair.HELPERS.lstrip().replace("\n", newline).encode()
                old = previous.lstrip().replace("\n", newline).encode()
                self.assertEqual(helpers.read_bytes().count(final), 1)
                helpers.write_bytes(helpers.read_bytes().replace(final, old, 1))
                before = self.snapshot(project)
                report = repair.apply([project])
                self.assertEqual([row["path"] for row in report], [str(helpers)])
                after = self.snapshot(project)
                self.assertEqual(after[FILES[0]], before[FILES[0]].replace(old, final, 1))
                self.assertEqual(after[FILES[0]].count(b"function scrNTTEFullProtoWeaponSave("), 1)
                self.assertEqual(after[FILES[0]].count(b"function scrNTTEFullProtoWeaponRestore("), 1)
                self.assertEqual(after[FILES[0]].count(b"function scrNTTEFullProtoWeaponTopologyValid("), 1)
                self.assertEqual(repair.apply([project]), [])

    def test_proto_topology_guards_precede_unsafe_native_getters(self):
        # These assertions protect the boundary where the shared codec's
        # alias graph enters native getter loops; native tests exercise actual
        # cyclic snapshots, constructors, valid aliases and Room End storage.
        helpers = repair.HELPERS
        save = helpers.split("function scrNTTEFullProtoWeaponSave(", 1)[1].split(
            "function scrNTTEFullProtoWeaponRestore(", 1)[0]
        restore = helpers.split("function scrNTTEFullProtoWeaponRestore(", 1)[1]
        self.assertLess(save.index("scrNTTEFullProtoWeaponTopologyValid(_model)"),
                        save.index("scrNTTEFullWeaponRaw(_model)"))
        self.assertLess(save.index("scrNTTEFullProtoWeaponTopologyValid(_model)"),
                        save.index("scr_weapon_is_valid(_model)"))
        self.assertLess(restore.index("scrNTTEFullProtoWeaponTopologyValid(_model)"),
                        restore.index("scr_weapon_is_valid(_model)"))
        self.assertLess(restore.index("scrNTTEFullProtoWeaponTopologyValid(_weapon)"),
                        restore.index("scr_weapon_is_valid(_weapon)"))
        topology = helpers.split("function scrNTTEFullProtoWeaponTopologyValid(", 1)[1].split(
            "// The Proto Chest survives", 1)[0]
        self.assertNotIn("scr_weapon_is_valid", topology)
        self.assertNotIn("scrNTTEFullWeaponRaw", topology)
        self.assertNotIn("ntte_native_state", topology)
        self.assertNotIn("proto_shared", topology)
        self.assertIn("_parts[_i]==_part", topology)
        self.assertIn("_wrappers[_i]==_raw", topology)

    def test_unknown_installed_helpers_reject_every_project_before_any_write(self):
        with TemporaryDirectory() as directory:
            first = self.fixture(Path(directory) / "first")
            second = self.fixture(Path(directory) / "second")
            repair.apply([second])
            helpers = second / FILES[0]
            current = repair.HELPERS.lstrip().encode()
            edited = repair.HELPERS_V1.lstrip().replace("_replace=false", "_replace=undefined", 1).encode()
            helpers.write_bytes(helpers.read_bytes().replace(current, edited, 1))
            before = self.snapshot(first), self.snapshot(second)
            with self.assertRaisesRegex(RuntimeError, "anchor changed"):
                repair.apply([first, second])
            self.assertEqual((self.snapshot(first), self.snapshot(second)), before)

    def test_changed_anchor_rejects_every_project_before_any_write(self):
        with TemporaryDirectory() as directory:
            first = self.fixture(Path(directory) / "first")
            second = self.fixture(Path(directory) / "second")
            damaged = second / FILES[1]
            damaged.write_bytes(damaged.read_bytes().replace(b'"etc", "protowep", protowep', b'"etc", "changed", protowep'))
            first_before, second_before = self.snapshot(first), self.snapshot(second)
            with self.assertRaisesRegex(RuntimeError, "anchor changed"):
                repair.apply([first, second])
            self.assertEqual(self.snapshot(first), first_before)
            self.assertEqual(self.snapshot(second), second_before)

    def test_frontier_unpack_leaf_restore_is_once_and_alias_graph_is_retained(self):
        with TemporaryDirectory() as directory:
            project = self.fixture(directory)
            repair.apply([project])
            report = []
            path = FILES[0]
            anchor = '    return scrNTTEFullWeaponNativeDecode(_data.root,_objects)'
            insertion = '    scrFRContinueMergedWeaponsRestore(_objects);\n'
            fr_save_hooks._insert(project, path, anchor, insertion, report, before=True)
            first = (project / path).read_bytes()
            fr_save_hooks._insert(project, path, anchor, insertion, report, before=True)
            self.assertEqual((project / path).read_bytes(), first)
            self.assertEqual(first.count(insertion.encode()), 1)
            self.assertIn(b'scrNTTEFullWeaponNativeDecode(_entry[1],_objects)', first)
            self.assertLess(first.index(insertion.encode()), first.index(anchor.encode()))


if __name__ == "__main__":
    unittest.main()
