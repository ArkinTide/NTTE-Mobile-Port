"""Bind each real VM build to every staged source and resource byte."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import hashlib
import json
import sys
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[1]
BUILD = ROOT / "build-windows"
PROJECT = ROOT / "staging/project"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def snapshot(*, full=True):
    text_suffixes = {".gml", ".yy", ".yyp", ".vsh", ".fsh"}
    paths = sorted(p for p in PROJECT.rglob("*")
                   if p.is_file() and (full or p.suffix.lower() in text_suffixes))
    # Independent small resource reads dominate this large native project.
    # Keep the exact sorted manifest while allowing bounded filesystem I/O.
    with ThreadPoolExecutor(max_workers=8) as pool:
        digests=list(pool.map(sha,paths))
    items = {p.relative_to(PROJECT).as_posix(): digest for p,digest in zip(paths,digests)
             if p.suffix.lower() in text_suffixes}
    assets = ROOT / "generated-assets/manifest.json"
    data = {"staged_text": items, "verified_asset_manifest_sha256": sha(assets)}
    if full:
        data["staged_files"] = {p.relative_to(PROJECT).as_posix(): digest for p,digest in zip(paths,digests)}
    encoded = json.dumps(data, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return {"input_sha256": hashlib.sha256(encoded).hexdigest(), **data}


def main():
    pending = BUILD / "compile-inputs.json"
    if sys.argv[1] == "capture":
        data = snapshot()
        data["captured_utc"] = datetime.now(timezone.utc).isoformat()
        pending.write_text(json.dumps(data, indent=2), encoding="utf-8")
    elif sys.argv[1] == "complete":
        before = json.loads(pending.read_text(encoding="utf-8"))
        # Complete an already-running older capture with its original schema.
        # Release acceptance requires the new complete staged_files binding.
        after = snapshot(full="staged_files" in before)
        assert before["input_sha256"] == after["input_sha256"], "Staged build inputs changed during compile"
        archive = ROOT / "analysis/build-inputs" / (before["input_sha256"] + ".json")
        archive.parent.mkdir(parents=True, exist_ok=True)
        if not archive.exists():
            archive.write_text(json.dumps(before, indent=2), encoding="utf-8")
        receipt = {"status": "COMPILED_NOT_PLAYABLE_VERIFIED",
                   "utc": datetime.now(timezone.utc).isoformat(),
                   "vm_sha256": sha(BUILD / "nuclearthronemobile.win"),
                   "log_sha256": sha(BUILD / "compile.log"),
                   "input_sha256": before["input_sha256"],
                   "input_manifest": archive.relative_to(ROOT).as_posix()}
        (BUILD / "last-success.json").write_text(json.dumps(receipt, indent=2), encoding="utf-8")
    else:
        raise SystemExit("Expected capture or complete")


if __name__ == "__main__":
    main()
