"""Native Frontier checkpoint consumers; preview never adopts a gameplay run."""
from pathlib import Path


_GENERATION_ANCHOR = "        _generation.ntte_full_set_area=_set_area"
_GENERATION_BEGIN = "        if(_set_area) with(_generation) scrFRContinueGenerationBegin(true);"
_GENERATION_DEFER = ("        // The appended geometry must merge before a compact collar is\n"
                     "        // made. A temporary target collar can cover the entire old map.\n"
                     "        _generation.ntte_full_sync_compact_defer=true")


def apply_inroom_generation_boundary(project, report, *, compact_defer=False):
    """Own the adjacent save/wall boundary, including exact older duplicates.

    The two installers used to insert between each other's idempotency anchors.
    Accept only their known contiguous blocks; never move a call across unrelated
    source or silently repair a changed statement. Preserve the file's encoding
    and newline convention when removing repeated blocks.
    """
    path = Path(project) / "scripts/scrNTTEFullInRoomGeneration/scrNTTEFullInRoomGeneration.gml"
    raw = path.read_bytes()
    source = raw.decode("utf-8-sig")
    newline = "\r\n" if "\r\n" in source else "\n"
    if "\r" in source.replace("\r\n", "") or (newline == "\r\n" and "\n" in source.replace("\r\n", "")):
        raise RuntimeError("Frontier generation boundary has mixed or unsupported newlines")
    source = source.replace("\r\n", "\n")
    if source.count(_GENERATION_ANCHOR) != 1:
        raise RuntimeError("Frontier generation boundary anchor changed")
    start = source.index(_GENERATION_ANCHOR) + len(_GENERATION_ANCHOR)
    if source[start:start+1] != "\n":
        raise RuntimeError("Frontier generation boundary anchor line changed")
    end, tokens = start, []
    while True:
        cursor = end
        while source[cursor:cursor+1] == "\n":
            cursor += 1
        for kind, block in (("defer", _GENERATION_DEFER), ("begin", _GENERATION_BEGIN)):
            if source.startswith(block, cursor) and source[cursor+len(block):cursor+len(block)+1] in {"", "\n"}:
                tokens.append(kind)
                end = cursor + len(block)
                break
        else:
            break
    # A single original save hook, repeated complete wall/save pairs, or the
    # transient original hook followed by such pairs are the only old forms.
    rest = tokens[1:] if tokens[:1] == ["begin"] else tokens
    if len(rest) % 2 or any(rest[i:i+2] != ["defer", "begin"] for i in range(0, len(rest), 2)):
        raise RuntimeError("Frontier generation boundary hook order changed")
    outside = source[:start] + source[end:]
    if ("scrFRContinueGenerationBegin" in outside
            or "ntte_full_sync_compact_defer" in outside
            or "The appended geometry must merge before a compact collar is" in outside):
        raise RuntimeError("Frontier generation boundary has a malformed or displaced hook")
    blocks = [_GENERATION_BEGIN]
    if compact_defer or "defer" in tokens:
        blocks.insert(0, _GENERATION_DEFER)
    updated = source[:start] + "\n" + "\n".join(blocks) + source[end:]
    encoded = updated.replace("\n", newline).encode("utf-8")
    if raw.startswith(b"\xef\xbb\xbf"):
        encoded = b"\xef\xbb\xbf" + encoded
    if encoded != raw:
        path.write_bytes(encoded)
    report.append({"file": str(path), "status": "already-applied" if encoded == raw else "patched"})


def _insert(project, relative, anchor, insertion, report, before=False):
    path = Path(project) / relative
    source = path.read_text("utf-8-sig")
    replacement = insertion + anchor if before else anchor + insertion
    if replacement in source:
        report.append({"file": str(path), "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"Frontier save consumer anchor changed: {path}: {anchor}")
    path.write_text(source.replace(anchor, replacement, 1), "utf-8", newline="\n")
    report.append({"file": str(path), "status": "patched"})


def apply(project):
    report = []
    path = "scripts/scrSavegame/scrSavegame.gml"
    _insert(project, path, "        GameCont.ntte_full_pet_save=scrNTTEFullPetExport()",
            "        GameCont.fr_continue_save=scrFRContinueExport()\n", report, before=True)
    _insert(project, path, "\t\tscrSavegamePlayers(_buffer, true)",
            '\n        scrFRContinueImport(scrNTTEFullValue(GameCont,"fr_continue_save",undefined))\n', report)
    _insert(project, path, "\ttry {\n\t\tscrSavegameSession(_buffer, true)",
            "    global.fr_loading_save=true;\n", report, before=True)
    _insert(project, path, "\tfinally {",
            "\n        global.fr_loading_save=false;", report)
    _insert(project, path, "function scrSavegamePlayers(_buffer, _is_load) {",
            '\n    if(!_is_load && scrFREnabled()) with(Player) fr_source_weapon_save=scrFRContinuePlayerWeaponsExport();\n', report)
    _insert(project, path, '_value = self[$ _key]',
            '\n                    if(scrFREnabled()) _value=scrFRContinuePlayerNativeState(_key,_value,false);\n', report)
    _insert(project, path, 'if (_vname=="ntte_last_harpoon") _value=noone',
            '\n                        if(scrFREnabled()) _value=scrFRContinuePlayerNativeState(_vname,_value,true);\n', report)
    _insert(project, path, "                scrNTTEFullWeaponNativeAfterLoad();",
            '\n                scrFRContinuePlayerWeaponsImport();\n', report)
    path_file = Path(project) / path
    source = path_file.read_text("utf-8-sig")
    original = 'if (!is_method(_value) && scrNTTEFullBonusSaveField(_key))'
    replacement = ('if (_key!="fr_source_wep" && _key!="fr_source_bwep" '
                   '&& _key!="fr_charge_controller" && _key!="fr_charge_native_input" '
                   '&& _key!="fr_charge_primary" && _key!="fr_charge_secondary" '
                   '&& !is_method(_value) && scrNTTEFullBonusSaveField(_key))')
    if replacement not in source:
        previous = 'if (_key!="fr_source_wep" && _key!="fr_source_bwep" && !is_method(_value) && scrNTTEFullBonusSaveField(_key))'
        anchor = original if source.count(original) == 1 else previous
        if source.count(anchor) != 1:
            raise RuntimeError("Frontier source weapon save filter anchor changed")
        source = source.replace(anchor, replacement, 1)
        path_file.write_text(source, "utf-8", newline="\n")
        report.append({"file": str(path_file), "status": "patched"})
    else:
        report.append({"file": str(path_file), "status": "already-applied"})
    _insert(project, "scripts/scrNTTEFullMergedNative/scrNTTEFullMergedNative.gml",
            'var _key=_keys[_i],_entry=variable_struct_get(_value,_key)',
            '\n            if(_key=="fr_source_weapon" && scrFREnabled()) _entry=scrFRContinueWeaponEncode(_entry);\n', report)
    _insert(project, "scripts/scrNTTEFullMergedNative/scrNTTEFullMergedNative.gml",
            '    scrUGWeaponImportRebase(_data,_objects);',
            '    scrFRContinueMergedWeaponsRestore(_objects);\n', report, before=True)
    _insert(project, "objects/GenCont/Create_0.gml", "with(GameCont) scrNTTEPortalDeathReset();",
            "scrFRContinueGenerationBegin();\n", report, before=True)
    # fr_area_hooks owns the single ordered finalization boundary: source
    # level_start first, then same-room checkpoint restoration. Inserting
    # independently at its native comment duplicates the two hooks on rebuild.
    apply_inroom_generation_boundary(project, report)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    print(json.dumps(apply(parser.parse_args().project), ensure_ascii=True, indent=2))
