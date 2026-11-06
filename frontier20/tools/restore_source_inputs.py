"""Restore externalized upstream GML from the user's own verified inputs.

No network access, credentials, asset downloads, or game execution. The actual
published runtime project already contains the accepted generated GML. This
helper is only for offline source/compiler reproduction.
"""
import argparse
import base64
import hashlib
import json
from pathlib import Path, PurePosixPath
import zipfile


def sha(data):
    return hashlib.sha256(data).hexdigest()


def safe_relative(value):
    assert isinstance(value, str) and value and "\\" not in value and ":" not in value
    assert all(part not in {"", ".", ".."} for part in value.split("/"))
    path = PurePosixPath(value)
    assert not path.is_absolute()
    return path


def reconstruct(record, own):
    assert record["format"] == "NTUF-source-fragments-1"
    assert len(own) == record["original_bytes"] and sha(own) == record["original_sha256"], "Own source does not match inventoried upstream input"
    chunks, offset = [], 0
    for segment in record["segments"]:
        if "text_base64" in segment:
            chunk = base64.b64decode(segment["text_base64"], validate=True)
            assert b"iVBORw0KGgo" not in chunk, "Code segment unexpectedly contains PNG media"
            assert own[offset:offset + len(chunk)] == chunk, "Upstream code fragment differs"
        else:
            count = segment["encoded_bytes"]
            chunk = own[offset:offset + count]
            assert sha(chunk) == segment["external_png_base64_sha256"]
            image = base64.b64decode(chunk, validate=True)
            assert len(image) == segment["png_bytes"] and sha(image) == segment["png_sha256"]
            assert image.startswith(b"\x89PNG\r\n\x1a\n")
        chunks.append(chunk)
        offset += len(chunk)
    result = b"".join(chunks)
    assert offset == len(own) and result == own and sha(result) == record["original_sha256"]
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-root", type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument("--frontier-archive", type=Path, required=True)
    parser.add_argument("--dependency-inputs", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    root = args.source_root.resolve(strict=True)
    dependencies = args.dependency_inputs.resolve(strict=True)
    output = args.output.resolve()
    assert not output.exists(), "Choose a new ignored local output directory"
    assert not output.is_relative_to(root), "Restore into a separate local work directory, not the public source tree"
    restored = []
    with zipfile.ZipFile(args.frontier_archive) as archive:
        for path in sorted(root.rglob("*.source.json")):
            record = json.loads(path.read_text(encoding="utf8"))
            name = safe_relative(record["original_path"])
            if name.parts[:2] == ("original", "Frontier"):
                own = archive.read(PurePosixPath("Frontier", *name.parts[2:]).as_posix())
            elif name.parts[0] == "dependencies":
                dependency = (dependencies / Path(*name.parts[1:])).resolve(strict=True)
                assert dependency.is_relative_to(dependencies)
                own = dependency.read_bytes()
            else:
                raise AssertionError("Unexpected embedded-media source category: " + str(name))
            result = reconstruct(record, own)
            target = (output / Path(*name.parts)).resolve()
            assert target.is_relative_to(output)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(result)
            restored.append({"path": name.as_posix(), "sha256": sha(result), "bytes": len(result)})
    print(json.dumps({"status": "PASS", "restored": restored, "network_used": False}, indent=2))


if __name__ == "__main__":
    main()
