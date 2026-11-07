"""Verify one complete NTTE/NTUF development run; never build or publish.

Large VM/package hashes are only recomputed with --full-hashes. A failed
verification never overwrites the existing successful development report.
"""
from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
import math
import os
from pathlib import Path
import re
import struct
import sys


ROOT = Path(__file__).resolve().parents[1]
BASELINE_SHA256 = "7ddd6d24b6710ae0a962966b5fe497ecce2996d1d36f5ac3f597674393c95eae"
PASS_MARKER = "PASS full internal selected implemented branches"
PERFORMANCE_PREFIX = "FRONTIER PERFORMANCE RESULT "
ENCOUNTER_PREFIX = "FRONTIER PERFORMANCE REAL TURRET ENCOUNTER "
BUBBLES_PREFIX = "NTUF BUBBLES STARTUP real new-run acceptance PASS "
GROUND_WEAPON_PREFIX = "FRONTIER GROUND WEAPON observed "
GROUND_WEAPON_PASS_PREFIX = ("PASS FRONTIER GROUND WEAPON natural same-seed floor/tile/packed manual drop, "
                             "settling, collision and physical-source re-pickup at30/60Hz ")
WORMHOLE_PREFIX = "FRONTIER WORMHOLE NTTE OBJ observed "
WORMHOLE_PASS_PREFIX = ("PASS FRONTIER actual Wormhole all six NTTE OBJ source entries, strict damage/context "
                        "negatives and untouched native/explicit Explosion controls ")
SHA_PATTERN = re.compile(r"[0-9a-f]{64}")
ORIGINAL_PACKAGES = {
    "Android": (303929165, "f7c38ac38698e76b5627b2ad8cff19599c936d5258ce9f942a2f2787acd4d475"),
    "iOS": (212527732, "00a948e485dc3dbdd21880f16bb2c2b501fddef4c718d6b2f5989b36e572f46f"),
}
REQUIRED_PYTHON_MODULES = {
    "test_frontier_compiler.py", "test_fr_localization.py", "test_frontier_lifecycle_hooks.py",
    "test_frontier_lib_performance_hooks.py", "test_frontier_performance_hooks.py",
    "test_frontier_content_hooks.py", "test_frontier_generation_boundary_hooks.py", "test_frontier_wall_hooks.py",
}
EXPECTED_SCENES = {
    (60, 1, 1, 0, None), (60, 306, 1, 0, None),
    (60, 306, 1, 3, None), (30, 306, 1, 0, None),
    (60, 301, 1, 0, None), (60, 302, 1, 0, None),
    (60, 303, 1, 0, 18334), (60, 304, 3, 0, None),
    (60, 305, 2, 1, None), (60, 2, 1, 3, None),
    (60, 3, 2, 3, None), (60, 4, 1, 3, None),
    (60, 5, 1, 3, None), (60, 6, 1, 3, None),
    (60, 7, 1, 3, None),
}


class VerificationError(RuntimeError):
    pass


def require(condition, message):
    if not condition:
        raise VerificationError(message)


def sha256(path):
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8-sig"))


def rooted(base, value):
    path = Path(value)
    if not path.is_absolute():
        path = base / path
    path = path.resolve()
    require(path.is_relative_to(base.resolve()), f"Path escapes {base}: {value}")
    return path


def relative(root, path):
    return path.relative_to(root).as_posix()


def valid_sha(value, label):
    require(isinstance(value, str) and SHA_PATTERN.fullmatch(value), f"Invalid SHA256: {label}")
    return value


def finite_positive(value, label):
    require(isinstance(value, (int, float)) and not isinstance(value, bool)
            and math.isfinite(value) and value > 0, f"Invalid positive measurement: {label}")
    return value


def verify_performance(smoke):
    rows = [json.loads(line[len(PERFORMANCE_PREFIX):]) for line in smoke.splitlines()
            if line.startswith(PERFORMANCE_PREFIX)]
    require(len(rows) == 15, "Expected exactly 15 populated performance scenes")
    actual = []
    for row in rows:
        scene = row["scene"]
        actual.append((scene["rate"], scene["area"], scene["sub"], scene["loops"], scene.get("seed")))
        require(row["profile_instrumented"] is False and row["profile"] == {},
                "Performance sample contains diagnostic profiling instrumentation")
        for field in ("seconds", "simulation_seconds", "simulation_per_second", "enemies", "objects", "floors"):
            finite_positive(row[field], f"{scene}: {field}")
        require(row["source_ticks"] == 120 and row["actor_ticks"] == 120
                and row["simulation_seconds"] == 4, "Performance sample did not run the real 120-tick fixture")
        measured = row["simulation_seconds"] / row["seconds"]
        require(math.isclose(measured, row["simulation_per_second"], rel_tol=1e-12, abs_tol=1e-12),
                "Performance speed disagrees with original elapsed measurements")
    require(len(set(actual)) == 15 and set(actual) == EXPECTED_SCENES,
            "Performance scene selection differs from the 15 authored populated fixtures")
    encounters = [json.loads(line[len(ENCOUNTER_PREFIX):]) for line in smoke.splitlines()
                  if line.startswith(ENCOUNTER_PREFIX)]
    require(len(encounters) == 1, "Expected one natural Deep Labs turret encounter")
    encounter = encounters[0]
    for field in ("generated", "active", "visible_active"):
        finite_positive(encounter[field], f"Deep Labs real encounter: {field}")
    dense = next(row for row in rows if row["scene"].get("seed") == 18334)
    return {"rows": rows, "dense_deeplabs": dense, "natural_turret_encounter": encounter,
            "minimum_simulation_per_second": min(row["simulation_per_second"] for row in rows),
            "maximum_simulation_per_second": max(row["simulation_per_second"] for row in rows),
            "scope": "Desktop populated-fixture measurements; not phone FPS or universal speed guarantees"}


def verify_bubbles_startup(smoke, artifacts, case_directory, skin):
    rows = [json.loads(line[len(BUBBLES_PREFIX):]) for line in smoke.splitlines()
            if line.startswith(BUBBLES_PREFIX)]
    require(len(rows) == 4, f"Bubbles skin {skin} must complete new-run and death-menu Retry at both rates")
    require([(row["language"], row["rate"],row["trial"]) for row in rows]
            == [("English", 30,"new"),("English",30,"retry"),
                ("Simplified Chinese", 60,"new"),("Simplified Chinese",60,"retry")],
            f"Bubbles skin {skin} lacks the actual English30/Chinese60 language/rate paths")
    screenshots = []
    for row in rows:
        require(row["requested_rate"] == row["option_rate"] == row["rate"]
                and math.isclose(row["scale"], 30 / row["rate"], rel_tol=1e-12, abs_tol=1e-12),
                f"Bubbles skin {skin} actual native engine rate/logic scale differs from its requested setting")
        require(row["skin"] == skin and row["weapon"] == 187 + skin,
                f"Bubbles skin {skin} did not use its authored native starter")
        require(row["native_runs"] == row["source_runs"] == 1 and row["source_ticks"] == 180,
                f"Bubbles skin {skin} skipped/replayed new-run initialization or natural play")
        require(row["weapon_swing"] is True, f"Bubbles skin {skin} did not fire its real starting weapon")
        hits=row.get("attack_hits",[])
        require([hit.get("mode") for hit in hits] == ["desktop-hold","mobile-tap","mobile-hold"],
                f"Bubbles skin {skin} lacks exact desktop and genuine touch-producer collision hits")
        require(all(hit["damage"] == hit["hp_loss"] == (6 if skin == 0 else 9) for hit in hits),
                f"Bubbles skin {skin} starter damage did not survive real Slash collision")
        for field, minimum in (("steps", 60), ("ends", 60), ("draws", 30), ("huds", 30), ("bubbles", 1)):
            finite_positive(row[field], f"Bubbles skin {skin}: {field}")
            require(row[field] >= minimum, f"Bubbles skin {skin} did not exercise the actual {field} path")
        suffix="-retry" if row["trial"] == "retry" else ""
        name = f"frontier-bubbles-startup-{skin}-{int(row['rate'])}{suffix}.png"
        require(name in artifacts, f"Missing hash-bound Bubbles natural gameplay screenshot: {name}")
        path = case_directory / name
        with path.open("rb") as handle:
            header = handle.read(24)
        require(header[:8] == b"\x89PNG\r\n\x1a\n" and header[12:16] == b"IHDR"
                and int.from_bytes(header[16:20], "big") >= 100
                and int.from_bytes(header[20:24], "big") >= 100,
                f"Bubbles natural gameplay screenshot is not a populated-size PNG: {name}")
        screenshots.append(name)
    for stage in ("real menu created", "first real CharSelect.Mouse4 selected Bubbles",
                  "genuine scrRunStart/scrCreatePlayers returned",
                  "genuine death-menu Retry returned",
                  "actual GameOver PauseButton Retry requested",
                  "Retry observer recreated after genuine session cleanup"):
        require(sum(line.startswith("NTUF BUBBLES STARTUP " + stage) for line in smoke.splitlines()) == 2,
                f"Bubbles skin {skin} lacks both genuine {stage} consumers")
    require(sum(line.startswith("NTUF BUBBLES STARTUP real room disposal then ordinary async GenCont")
                for line in smoke.splitlines()) == 4,
            f"Bubbles skin {skin} did not generate all four real new/Retry rooms")
    require(sum(line.startswith("NTUF BUBBLES STARTUP real touch release edge ")
                for line in smoke.splitlines()) == 8,
            f"Bubbles skin {skin} did not exercise both adjacent release parities in all four trials")
    require(sum(line.startswith("NTUF BUBBLES STARTUP saved unlock reloaded;")
                for line in smoke.splitlines()) == 1,
            f"Bubbles skin {skin} did not reload its actual saved unlock")
    return {"skin": skin, "new_runs": rows, "screenshots": screenshots,
            "scope": "Native desktop menu/new-run/death-menu Retry, real touch producer and Slash HP loss; not physical Android/iOS validation"}


def verify_ground_weapons(smoke):
    rows = [json.loads(line[len(GROUND_WEAPON_PREFIX):]) for line in smoke.splitlines()
            if line.startswith(GROUND_WEAPON_PREFIX)]
    combinations = [("floor", "lwo"), ("tiles", "lwo"), ("packed", "lwo"),
                    ("floor", "original"), ("floor", "ntuf"), ("floor", "fusion")]
    expected = [(rate, form, kind) for rate in (30, 60) for form, kind in combinations]
    require(len(rows) == 12, "Ground weapon case must complete exactly twelve natural scenes")
    require([(row["rate"], row["form"], row["weapon_kind"]) for row in rows] == expected,
            "Ground weapon scenes lack the same-seed terrain, original, NTUF or fusion 30/60 controls")
    for row in rows:
        label = f"Ground weapon {row['rate']}/{row['form']}/{row['weapon_kind']}"
        require(row["seed"] == 9181 and row["incoming_x"] == row["player_x"] == -5
                and row["incoming_y"] == row["player_y"] == 160,
                f"{label} changed the paired scene's original seed or exchange position")
        for field in ("swapped", "existed", "visible", "repicked", "source_preserved", "physical_state_preserved"):
            require(row[field] is True, f"{label} did not preserve its real {field} path")
        # Native place_meeting returns numeric zero in the observed JSON,
        # while a Boolean false is the same strict non-overlap result.
        require(row["overlap"] is False or (isinstance(row["overlap"], (int, float))
                and not isinstance(row["overlap"], bool) and row["overlap"] == 0),
                f"{label} left the actual dropped weapon inside a wall")
        require(not isinstance(row["ground_copies"], bool) and row["ground_copies"] == 1
                and not isinstance(row["ground_after_repick"], bool) and row["ground_after_repick"] == 0,
                f"{label} lost or duplicated its physical ground weapon")
        for field in ("drop_x", "drop_y", "x", "y", "speed", "displacement"):
            value = row[field]
            require(isinstance(value, (int, float)) and not isinstance(value, bool) and math.isfinite(value),
                    f"{label} has an invalid native geometry measurement: {field}")
        require(0 <= row["displacement"] <= 32,
                f"{label} escaped to a remote compact-wall edge instead of its local contact")
        measured = math.hypot(row["x"] - row["drop_x"], row["y"] - row["drop_y"])
        # All twelve real engine point_distance measurements are binary32.
        # Compare exact binary32 rounding, instead of demanding the engine
        # return Python hypot's different binary64 representation.
        try:
            native_measured = struct.unpack("<f", struct.pack("<f", measured))[0]
        except (OverflowError, struct.error):
            raise VerificationError(f"{label} distance cannot be represented by its native measurement") from None
        require(row["displacement"] == native_measured,
                f"{label} displacement disagrees with the actual pickup coordinates")
    summaries = [json.loads(line[len(GROUND_WEAPON_PASS_PREFIX):]) for line in smoke.splitlines()
                 if line.startswith(GROUND_WEAPON_PASS_PREFIX)]
    require(len(summaries) == 1 and summaries[0] == rows,
            "Ground weapon final real acceptance array is absent or differs from its natural observations")
    return {"rows": rows, "seed": 9181, "maximum_displacement": max(row["displacement"] for row in rows),
            "scope": "Engine-scheduled native manual exchange, ground movement/collision and physical-state re-pickup; no phone validation"}


def verify_wormhole_ntte_objects(smoke):
    rows = [json.loads(line[len(WORMHOLE_PREFIX):]) for line in smoke.splitlines()
            if line.startswith(WORMHOLE_PREFIX)]
    minimum_shots = {"BoneArrow": 6, "BatDisc": 6, "BubbleBomb": 8,
                     "ElectroPlasma": 7, "QuasarBeam": 2, "LightningDisc": 5}
    expected = [(rate, name) for rate in (30, 60) for name in minimum_shots]
    require(len(rows) == 12 and [(row["rate"], row["name"]) for row in rows] == expected,
            "Wormhole must execute all six authored NTTE OBJ entries once at both native rates")
    for row in rows:
        label = f"Wormhole {row['rate']}/{row['name']}"
        shots = row["shots"]
        require(isinstance(shots, (int, float)) and not isinstance(shots, bool)
                and math.isfinite(shots) and shots == int(shots),
                f"{label} has an invalid actual projectile count")
        require(shots >= minimum_shots[row["name"]], f"{label} omitted part of its authored burst")
        for field in ("owner_hitid", "hitid", "context"):
            value = row[field]
            require(isinstance(value, (int, float)) and not isinstance(value, bool)
                    and math.isfinite(value) and value >= 1 and value == int(value),
                    f"{label} has a missing or invalid native {field}")
        require(row["owner_hitid"] == row["hitid"] == row["context"],
                f"{label} lost its real caller's native damage identity/context")
    summaries = [json.loads(line[len(WORMHOLE_PASS_PREFIX):]) for line in smoke.splitlines()
                 if line.startswith(WORMHOLE_PASS_PREFIX)]
    require(len(summaries) == 2 and summaries[0] == rows[:6] and summaries[1] == rows[6:],
            "Both actual Wormhole strict negative/native/Explosion control markers are required")
    return {"rows": rows, "minimum_shots": minimum_shots,
            "scope": "Actual source Wormhole registry/fire, six NTTE OBJ entries and native damage/context controls at30/60Hz"}


def verify(root, run_value, selection_value, *, full_hashes=False):
    root = root.resolve()
    run = rooted(root, run_value)
    require(run.is_relative_to(root / "tests") and run.is_dir(), "Run must be an existing frontier20/tests directory")
    selection_path = rooted(root, selection_value)
    selection = read_json(selection_path)
    frontier, baseline, cases = (selection[key] for key in ("frontier_cases", "baseline_cases", "cases"))
    require(isinstance(frontier, list) and isinstance(baseline, list) and isinstance(cases, list), "Invalid case selections")
    require(len(frontier) == 26 and len(baseline) == 62 and len(cases) == 88 and selection["total"] == 88,
            "Final development selection must contain 26 Frontier + 62 frozen NTTE cases (88 total)")
    require(all(isinstance(case, str) and re.fullmatch(r"[A-Za-z0-9_]+", case) for case in cases),
            "Case names must be simple native harness identities")
    require(len(set(cases)) == 88 and cases == frontier + baseline,
            "Selection contains duplicate, reordered or inconsistent combined cases")
    require(all(case.startswith("Frontier") for case in frontier), "Unexpected Frontier case identity")
    require(selection.get("physical_device_tested") is False, "Desktop selection must not claim device testing")
    baseline_path = root.parent / "release127/selected-cases.json"
    require(sha256(baseline_path) == selection["baseline_selection_sha256"] == BASELINE_SHA256,
            "Frozen NTTE 62-case selection SHA256 changed")
    require(read_json(baseline_path) == baseline, "Frozen NTTE case list/order changed")

    compiled_path = run / "compiled-build.json"
    compiled = read_json(compiled_path)
    require(compiled["status"] == "COMPILED_NOT_PLAYABLE_VERIFIED", "Unexpected build receipt status")
    vm_hash = valid_sha(compiled["vm_sha256"], "compiled VM")
    input_hash = valid_sha(compiled["input_sha256"], "compiled input")
    log_hash = valid_sha(compiled["log_sha256"], "compile log")
    require(sha256(run / "compile.log") == log_hash, "Archived compile log SHA256 differs from build receipt")
    current_build = read_json(root / "build-windows/last-success.json")
    require(current_build == compiled, "Run is not bound to the current successful build receipt")
    manifest_path = rooted(root, compiled["input_manifest"])
    require(manifest_path.is_relative_to(root / "analysis/build-inputs"), "Build manifest is outside its archive")
    manifest = read_json(manifest_path)
    require(isinstance(manifest.get("staged_files"), dict) and manifest["staged_files"],
            "Build manifest lacks the complete staged-file binding")
    require(isinstance(manifest.get("staged_text"), dict), "Build manifest lacks staged text")
    for key, value in manifest["staged_files"].items():
        require(isinstance(key, str) and key and not Path(key).is_absolute() and ".." not in Path(key).parts,
                "Invalid staged manifest member")
        valid_sha(value, key)
    require(all(manifest["staged_files"].get(key) == value for key, value in manifest["staged_text"].items()),
            "Staged text and complete file manifest disagree")
    valid_sha(manifest["verified_asset_manifest_sha256"], "asset manifest")
    content = {key: value for key, value in manifest.items() if key not in {"input_sha256", "captured_utc"}}
    canonical_hash = hashlib.sha256(json.dumps(content, sort_keys=True, separators=(",", ":")).encode("utf8")).hexdigest()
    require(canonical_hash == manifest["input_sha256"] == input_hash, "Canonical build-input manifest binding differs")

    actual_receipts = {path.parent.name: path for path in run.glob("*/receipt.json")}
    require(set(actual_receipts) == set(cases),
            f"Incomplete/extra run cases: missing={sorted(set(cases)-set(actual_receipts))}, extra={sorted(set(actual_receipts)-set(cases))}")
    results, silent_hash, muted_count, performance = {}, None, None, None
    bubbles_startup, ground_weapons, wormhole_ntte_objects = {}, None, None
    for case in cases:
        receipt_path = actual_receipts[case]
        receipt = read_json(receipt_path)
        require(receipt["case"] == case and receipt["status"] == "PASS" and receipt["exit"] == 0
                and receipt.get("termination_reason", "missing") is None, f"Case did not complete successfully: {case}")
        require(receipt["vm_sha256"] == vm_hash and receipt["input_sha256"] == input_hash,
                f"Case belongs to a different VM/input: {case}")
        candidate = valid_sha(receipt["silent_vm_sha256"], case + " silent VM")
        if silent_hash is None:
            silent_hash, muted_count = candidate, receipt["muted_resources"]
        require(candidate == silent_hash and receipt["muted_resources"] == muted_count and muted_count > 100,
                f"Case has inconsistent muted VM/resources: {case}")
        require(receipt["physical_device_tested"] is False and receipt["desktop"] == "private, never activated",
                f"Case has unexpected desktop/device scope: {case}")
        finite_positive(receipt["elapsed_seconds"], case + " elapsed")
        smoke_path, runner_path = receipt_path.parent / "smoke.txt", receipt_path.parent / "runner.log"
        smoke = smoke_path.read_text("utf8")
        runner = runner_path.read_text("utf8", errors="replace")
        selected_lines = [line[5:] for line in smoke.splitlines() if line.startswith("CASE ")]
        require(selected_lines and set(selected_lines) == {case}, f"Smoke log did not execute the selected case: {case}")
        require(PASS_MARKER in smoke and not re.search(r"^ERROR(?:\s|$)", smoke, re.MULTILINE)
                and "ERROR!!!" not in runner and "ERROR!!!" not in smoke,
                f"Case smoke/runner log contains an error or lacks the real PASS marker: {case}")
        artifacts = receipt["artifacts_sha256"]
        require(isinstance(artifacts, dict), f"Invalid artifact hashes: {case}")
        for name, expected in artifacts.items():
            require(isinstance(name, str) and Path(name).name == name and name not in {".", ".."},
                    f"Invalid artifact filename: {case}")
            valid_sha(expected, case + " artifact " + name)
            artifact_path = rooted(receipt_path.parent, name)
            require(sha256(artifact_path) == expected, f"Artifact SHA256 mismatch: {case}/{name}")
        results[case] = {**receipt, "receipt": relative(root, receipt_path), "receipt_sha256": sha256(receipt_path),
                         "smoke_sha256": sha256(smoke_path), "runner_log_sha256": sha256(runner_path)}
        if case == "FrontierPerformanceTests":
            performance = verify_performance(smoke)
            performance["smoke"] = relative(root, smoke_path)
            performance["smoke_sha256"] = results[case]["smoke_sha256"]
        if case in {"FrontierBubblesStartupATests", "FrontierBubblesStartupBTests"}:
            skin = 0 if case == "FrontierBubblesStartupATests" else 1
            bubbles_startup[case] = verify_bubbles_startup(smoke, artifacts, receipt_path.parent, skin)
        if case == "FrontierGroundWeaponTests":
            ground_weapons = verify_ground_weapons(smoke)
        if case == "FrontierWeaponTests":
            wormhole_ntte_objects = verify_wormhole_ntte_objects(smoke)
    require(performance is not None, "Native performance case is absent")
    require(len(bubbles_startup) == 2, "Both genuine Bubbles skin new-run cases are required")
    require(ground_weapons is not None, "Native manual ground-weapon case is absent")
    require(wormhole_ntte_objects is not None, "Actual Wormhole NTTE object-entry coverage is absent")

    python_path = root / "review/python-regression.json"
    python = read_json(python_path)
    require(python["status"] == "PASS" and python["exit"] == 0, "Python regression did not pass")
    python_output_path = rooted(root, python["output"])
    python_output = python_output_path.read_text("utf8")
    match = re.search(r"^Ran (\d+) tests in ([0-9.]+)s$", python_output, re.MULTILINE)
    require(match is not None and int(match[1]) >= 94 and python_output.strip().endswith("OK")
            and not re.search(r"^(?:FAILED|ERROR:|FAIL:)", python_output, re.MULTILINE),
            "Python output lacks a successful complete test count (at least 94)")
    modules = python["modules"]
    require(isinstance(modules, list) and len(set(modules)) == len(modules)
            and REQUIRED_PYTHON_MODULES.issubset(modules),
            "Python module coverage is incomplete or duplicated")

    preservation_path = root / "review/original-package-preservation.json"
    preservation = read_json(preservation_path)
    require(preservation["status"] == "PASS" and preservation["current_repairs_packaged"] is False
            and preservation["original_packages_unchanged"] is True, "Original package preservation receipt failed")
    require(set(preservation["packages"]) == {"Android", "iOS"}, "Original package receipt lacks both platforms")
    package_checks = {}
    for platform, record in preservation["packages"].items():
        package_path = rooted(root, record["path"])
        valid_sha(record["sha256"], platform + " original package")
        require((record["bytes"], record["sha256"]) == ORIGINAL_PACKAGES[platform],
                f"Preservation receipt differs from the frozen original package identity: {platform}")
        require(package_path.is_file() and package_path.stat().st_size == record["bytes"],
                f"Original package absent or size changed: {platform}")
        if full_hashes:
            require(sha256(package_path) == record["sha256"], f"Original package SHA256 changed: {platform}")
        package_checks[platform] = {**record, "sha256_recomputed_this_verification": full_hashes}
    if full_hashes:
        require(sha256(root / "build-windows/nuclearthronemobile.win") == vm_hash, "Current VM SHA256 changed")
        require(sha256(root / "build-windows/frontier-silent.win") == silent_hash, "Current silent VM SHA256 changed")

    return {"status": "DEVELOPMENT_REGRESSION_VERIFIED", "utc": datetime.now(timezone.utc).isoformat(),
            "development_only": True, "current_repairs_packaged": False, "published": False, "uploaded": False,
            "physical_device_tested": False, "performed_actions": ["read existing development evidence", "write this review report"],
            "run": relative(root, run), "selection": relative(root, selection_path), "selection_sha256": sha256(selection_path),
            "total": 88, "frontier_cases": frontier, "baseline_cases": baseline, "baseline_selection_sha256": BASELINE_SHA256,
            "vm_sha256": vm_hash, "silent_vm_sha256": silent_hash, "input_sha256": input_hash,
            "large_vm_and_package_hashes_recomputed": full_hashes,
            "compiled_build": {**compiled, "receipt": relative(root, compiled_path), "receipt_sha256": sha256(compiled_path)},
            "input_manifest_sha256": sha256(manifest_path), "staged_file_count": len(manifest["staged_files"]),
            "results": results, "performance": performance, "bubbles_startup": bubbles_startup,
            "ground_weapons": ground_weapons,
            "wormhole_ntte_objects": wormhole_ntte_objects,
            "python": {**python, "tests": int(match[1]), "elapsed_seconds": float(match[2]),
                       "receipt_sha256": sha256(python_path), "output_sha256": sha256(python_output_path)},
            "original_package_preservation": {"receipt": relative(root, preservation_path),
                "receipt_sha256": sha256(preservation_path), "contents": preservation, "checks": package_checks},
            "limits": ["Selected native development regressions are not complete MOD coverage",
                       "No physical Android/iOS test or mobile validation was performed",
                       "Performance rows are desktop samples, not phone FPS guarantees",
                       "No packaging, GitHub publication, MEGA upload or repository rename is performed"]}


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run", required=True, help="Completed tests/<stamp> directory")
    parser.add_argument("--selection", required=True, help="review/final-regression-cases.json")
    parser.add_argument("--full-hashes", action="store_true", help="Also recompute current VM, silent VM and original APK/IPA SHA256")
    args = parser.parse_args(argv)
    output = ROOT / "review/development-regression.json"
    try:
        report = verify(ROOT, args.run, args.selection, full_hashes=args.full_hashes)
        temporary = output.with_name(output.name + ".tmp")
        temporary.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf8")
        os.replace(temporary, output)
    except (VerificationError, OSError, KeyError, TypeError, ValueError) as error:
        print(f"Development verification failed: {error}", file=sys.stderr)
        return 1
    print(f"Verified 88 development cases; report: {output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
