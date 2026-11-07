"""Keep elevated JungleFly on a reachable wall-to-floor descent."""
from pathlib import Path
import re
from fr_content_hooks import patch


RELATIVE = "scripts/scrNTTEFullTop/scrNTTEFullTop.gml"
ROUND_ANCHOR = "        x=round(x); y=round(y);"
WALL_PREFIX = ("        // Keep ordinary wall-top occupants within a reachable lip.\n"
               "        // Deliberate islands, flying ravens and props retain their source placement.\n"
               "        scrFRWallTopConstrainSpawn(id);\n")


def migrate_legacy_position(project):
    """Keep the preceding wall hook's contiguous installation anchor intact.

    The first fly installer inserted between ConstrainSpawn and round. The
    existing wall installer then failed to recognise its full replacement on
    restaging and inserted a second prefix. Migrate only our exact marked
    legacy block and those exact duplicate prefixes, retaining one wall call.
    """
    path = project / RELATIVE
    raw = path.read_bytes()
    bom = b"\xef\xbb\xbf" if raw.startswith(b"\xef\xbb\xbf") else b""
    text = raw.decode("utf-8-sig")
    newline = "\r\n" if "\r\n" in text else "\n"
    normalized = text.replace("\r\n", "\n")
    assert normalized.count(ROUND_ANCHOR) == 1, (RELATIVE, "fly landing round anchor")
    blocks = list(re.finditer(
        r"^[ \t]*// BEGIN FRONTIER JUNGLE FLY WALL DESCENT\n"
        r"scrFRFlyWallSpawn\(id\);\n"
        r"[ \t]*// END FRONTIER JUNGLE FLY WALL DESCENT\n?", normalized, re.M))
    assert len(blocks) <= 1, (RELATIVE, "fly landing duplicate marker")
    if blocks and blocks[0].start() < normalized.index(ROUND_ANCHOR):
        block = blocks[0]
        normalized = normalized[:block.start()] + normalized[block.end():]
        prefixes = list(re.finditer(re.escape(WALL_PREFIX), normalized))
        assert prefixes and normalized.count("scrFRWallTopConstrainSpawn(id);") == len(prefixes), (
            RELATIVE, "legacy fly landing wall prefix changed")
        # Removing the old marked insertion can leave a blank line between
        # the surviving call and round. Reconstruct one contiguous prefix
        # rather than retaining that non-matching legacy whitespace.
        for duplicate in reversed(prefixes):
            normalized = normalized[:duplicate.start()] + normalized[duplicate.end():]
        normalized = normalized.replace(ROUND_ANCHOR, WALL_PREFIX + ROUND_ANCHOR, 1)
        updated = normalized.replace("\n", newline)
        path.write_bytes(bom + updated.encode("utf8"))


def apply(project):
    project = Path(project)
    migrate_legacy_position(project)
    # The wall installer owns the complete prefix + round replacement.
    # Inserting after round preserves that idempotence boundary on restage.
    patch(project, RELATIVE, "JUNGLE FLY WALL DESCENT", "scrFRFlyWallSpawn(id);",
          anchor=ROUND_ANCHOR)
    return {"file": RELATIVE, "kind": "JungleFly elevated placement and original low-gravity landing"}
