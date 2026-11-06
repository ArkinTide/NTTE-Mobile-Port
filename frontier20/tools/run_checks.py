"""Frontier-only real VM checks; private desktop, isolated saves, muted assets.

Creates independent receipts. Never overwrites the frozen NTTE release results.
"""
from pathlib import Path
import argparse, ctypes, hashlib, json, shutil, struct, subprocess, sys, time
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "build-windows"
RUNTIME = Path("C:/ProgramData/GameMakerStudio2-LTS2026/Cache/runtimes/runtime-2026.0.0.23")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("cases", nargs="*", help="Explicit native harness cases")
    ap.add_argument("--baseline", action="store_true", help="Run the frozen NTTE 1.2.7 case selection against this VM")
    ap.add_argument("--keep-going", action="store_true")
    ap.add_argument("--timeout", type=int, default=180)
    ap.add_argument("--stall-timeout", type=int, default=180,
                    help="Fail when the smoke log makes no progress for this many seconds")
    ap.add_argument("--trace", action="store_true", help="Trace authored dispatch during initial live test frames")
    args = ap.parse_args()
    assert args.timeout > 0 and args.stall_timeout > 0
    if args.baseline:
        assert not args.cases, "Choose explicit cases or the frozen baseline selection"
        args.cases=json.loads((ROOT.parent/"release127/selected-cases.json").read_text("utf-8-sig"))
        assert len(args.cases)==62 and len(set(args.cases))==62
    assert args.cases, "Select at least one native case"
    sys.path.insert(0, str(ROOT.parents[1] / "hardmode-port"))
    import test_volume

    vm = BUILD / "nuclearthronemobile.win"
    data = bytearray(vm.read_bytes())
    digest = hashlib.sha256(data).hexdigest()
    compiled = json.loads((BUILD / "last-success.json").read_text("utf-8-sig"))
    assert compiled["vm_sha256"] == digest, "VM differs from last successful compile; do not run failed build output"
    assert data[:4] == b"FORM", "Expected compiled GameMaker VM archive"
    at, muted = 8, 0
    while at < len(data):
        tag, size = struct.unpack_from("<4sI", data, at)
        if tag == b"SOND":
            count = struct.unpack_from("<I", data, at + 8)[0]
            for i in range(count):
                entry = struct.unpack_from("<I", data, at + 12 + i * 4)[0]
                struct.pack_into("<f", data, entry + 20, 0)
                muted += 1
        at += 8 + size
    assert muted > 100, "Mute assertion failed; do not launch unmuted"
    silent = BUILD / "frontier-silent.win"
    silent.write_bytes(data)
    silent_digest = hashlib.sha256(data).hexdigest()
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S%fZ")
    run = ROOT / "tests" / stamp
    run.mkdir(parents=True)
    (run / "compiled-build.json").write_text(json.dumps(compiled, indent=2), encoding="utf8")
    (run / "compile.log").write_bytes((BUILD / "compile.log").read_bytes())
    user = ctypes.windll.user32
    user.CreateDesktopW.restype = ctypes.c_void_p
    user.CreateDesktopW.argtypes = [ctypes.c_wchar_p, ctypes.c_wchar_p, ctypes.c_void_p,
                                  ctypes.c_ulong, ctypes.c_ulong, ctypes.c_void_p]
    desktop = "NTTEFrontierAudit" + stamp
    desk = user.CreateDesktopW(desktop, None, None, 0, 0x1ff, None)
    assert desk, "Private desktop unavailable; do not launch on user's desktop"
    failures = []
    try:
        for case in args.cases:
            out = run / case
            out.mkdir()
            smoke = BUILD / "ntte-smoke.txt"
            smoke.write_text("", encoding="utf8")
            si = subprocess.STARTUPINFO()
            si.dwFlags |= subprocess.STARTF_USESHOWWINDOW
            si.wShowWindow = 0
            si.lpDesktop = desktop
            log = out / "runner.log"
            start = time.monotonic()
            start_wall = time.time()
            last_progress = start
            smoke_size = 0
            termination_reason = None
            with log.open("wb") as f:
                proc = subprocess.Popen([
                    str(RUNTIME / "windows/x64/Runner.exe"), "-game", str(silent),
                    "-inawindow", "--ntte-full-smoke", "--ntte-full-case=" + case,
                    *(["--ntuf-trace"] if args.trace else []),
                    "-debugoutput", str(out / "debug.log")], cwd=BUILD,
                    stdout=f, stderr=subprocess.STDOUT, startupinfo=si,
                    creationflags=subprocess.CREATE_NO_WINDOW)
                volume = test_volume.configure(proc)
                while proc.poll() is None:
                    text = smoke.read_text("utf8", errors="replace")
                    errors = log.read_text("utf8", errors="replace")
                    now = time.monotonic()
                    if len(text) != smoke_size:
                        smoke_size = len(text)
                        last_progress = now
                    if "\nERROR " in text or "ERROR!!!" in errors:
                        termination_reason = "runtime_error"
                    elif now - start > args.timeout:
                        termination_reason = "overall_timeout"
                    elif now - last_progress > args.stall_timeout:
                        termination_reason = "no_smoke_progress"
                    if termination_reason:
                        proc.terminate()
                        proc.wait(timeout=5)
                        break
                    time.sleep(0.25)
                test_volume.verify(volume)
            text = smoke.read_text("utf8", errors="replace")
            (out / "smoke.txt").write_text(text, encoding="utf8")
            artifacts = {}
            for path in [*BUILD.glob("frontier-*"), *BUILD.glob("ntuf-*")]:
                if (path.is_file() and path.suffix.lower() in {".png", ".json"}
                        and path.stat().st_mtime >= start_wall):
                    shutil.copy2(path, out / path.name)
                    artifacts[path.name] = hashlib.sha256(path.read_bytes()).hexdigest()
            passed = (proc.returncode == 0 and
                      "PASS full internal selected implemented branches" in text and
                      "\nERROR " not in text and
                      "ERROR!!!" not in log.read_text("utf8", errors="replace"))
            receipt = dict(case=case, status="PASS" if passed else "FAIL",
                           exit=proc.returncode, elapsed_seconds=round(time.monotonic()-start, 2),
                           termination_reason=termination_reason,
                           vm_sha256=digest, silent_vm_sha256=silent_digest,
                           input_sha256=compiled.get("input_sha256"),
                           artifacts_sha256=artifacts,
                           muted_resources=muted, desktop="private, never activated",
                           physical_device_tested=False,
                           utc=datetime.now(timezone.utc).isoformat())
            (out / "receipt.json").write_text(json.dumps(receipt, indent=2), encoding="utf8")
            print(case + ": " + receipt["status"] + " (" + str(receipt["elapsed_seconds"]) + "s)", flush=True)
            print("Evidence: " + str(out), flush=True)
            if not passed:
                print(text[-4500:], flush=True)
                print(log.read_text("utf8", errors="replace")[-1500:], flush=True)
                failures.append(case)
                if not args.keep_going:
                    break
    finally:
        user.CloseDesktop.argtypes = [ctypes.c_void_p]
        user.CloseDesktop(desk)
    if failures:
        raise SystemExit("Failed: " + ", ".join(failures))


if __name__ == "__main__":
    main()
