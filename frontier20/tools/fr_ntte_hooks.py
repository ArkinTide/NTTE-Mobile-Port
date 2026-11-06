"""Idempotent consumer hooks for ntte_compat.gml; no patching on import."""
from pathlib import Path
import re

from fr_gml_frontend import tokenize


def _edit(project, folder, anchor, insertion, report):
    path = Path(project) / "scripts" / folder / (folder + ".gml")
    source = path.read_text("utf-8-sig")
    if insertion in source:
        report.append({"script": folder, "status": "already-applied"})
        return
    if source.count(anchor) != 1:
        raise RuntimeError(f"NTTE adapter hook anchor changed: {folder}: {anchor}")
    path.write_text(source.replace(anchor, anchor + insertion, 1), "utf-8", newline="\n")
    report.append({"script": folder, "status": "patched"})


def _sprite_consumers(project, folder, report):
    path = Path(project) / "scripts" / folder / (folder + ".gml")
    source = path.read_text("utf-8-sig")
    # Dynamic replacements cannot be native case labels. Keep their original
    # constants and add an explicit runtime comparison at this consumer.
    source = re.sub(r"case scrFRNTTENativeSprite\((sprUG\w+)\):", r"case \1:", source)
    if folder == "scrDetailsPlusBatch":
        begin = "// BEGIN FRONTIER DYNAMIC ATLAS SPRITES"
        end = "// END FRONTIER DYNAMIC ATLAS SPRITES"
        source = re.sub(r"\n?"+re.escape(begin)+r".*?"+re.escape(end)+r"\n?", "", source, flags=re.S)
        labels = re.findall(r"case (sprUG\w+):", source)
        if labels:
            guard = "\n"+begin+"\n"+"\n".join("    if(_sprite==scrFRNTTENativeSprite("+name+")) return true;" for name in labels)+"\n"+end+"\n"
            source = source.replace("function scrDPBatchAtlasSprite(_sprite) {", "function scrDPBatchAtlasSprite(_sprite) {"+guard, 1)
    tokens = tokenize(source)
    edits = []
    for index, token in enumerate(tokens):
        if token.kind != "identifier" or not re.fullmatch(r"sprUG\w+", token.text):
            continue
        if index > 0 and tokens[index-1].text == "case":
            continue
        if index >= 2 and tokens[index - 1].text == "(" and tokens[index - 2].text == "scrFRNTTENativeSprite":
            continue
        edits.append((token.start, token.end, "scrFRNTTENativeSprite(" + token.text + ")"))
    for start, end, value in reversed(edits):
        source = source[:start] + value + source[end:]
    path.write_text(source, "utf-8", newline="\n")
    report.append({"script": folder, "native_sprite_consumers_wrapped": len(edits)})


def apply(project):
    """Patch a caller-selected project copy and return exact changed sites."""
    report = []
    _edit(project, "scrNTTEReferenceResources", "function scrNTTERefSprite(_key,_index=-1) {",
          '\n    var _fr_sprite=scrFRNTTESpriteOverride(_key,_index);\n'
          '    if(!is_undefined(_fr_sprite)) return _fr_sprite;\n', report)
    _edit(project, "scr_weapon_get_type", '    if(!scrNTTEFullWeaponAvailable(_weapon)) return scrNTTEFullWeaponLockedSprite(_weapon);',
          '\n    var _fr_native_weapon_sprite=scrFRNTTEWeaponSprite(_weapon);\n'
          '    if(!is_undefined(_fr_native_weapon_sprite)) return _fr_native_weapon_sprite;\n', report)
    _edit(project, "scrDetailsPlus", "function scrDPStatueSprites(_area) {",
          '\n    var _fr_statue=scrFRNTTEStatueSprites(_area);\n'
          '    if(!is_undefined(_fr_statue)) return _fr_statue;\n', report)
    _edit(project, "scrDetailsPlus", "function scrDPScorchSprites(_floor) {",
          '\n    var _fr_scorch=scrFRNTTEScorchSprites(_floor);\n'
          '    if(!is_undefined(_fr_scorch)) return _fr_scorch;\n', report)
    _edit(project, "scrNTTEFullPet", "function scrNTTEFullPetCreateEvent() {",
          '\n    name="NTTEPet";\n', report)
    _edit(project, "scrNTTEFullPet", "function scrNTTEFullPetSetSkin(_pet,_skin) {",
          '\n    if(is_array(_skin)) return scrFRNTTEPetSetSkin(_pet,_skin);\n', report)
    _edit(project, "scrNTTEFullPet", "function scrNTTEFullPetGetSprite(_pet,_mod_type,_mod_name,_skin,_part) {",
          '\n    if(is_array(_skin)) return scrFRNTTEPetSkinSprite(_skin,_part);\n', report)
    for folder in ("scrUndergrowthCallbacks", "scrUndergrowthNative", "scrUndergrowthArea",
                   "scrNTTEFullAreas", "scrDetailsPlusBatch"):
        _sprite_consumers(project, folder, report)
    return report


if __name__ == "__main__":
    import argparse
    import json
    parser = argparse.ArgumentParser()
    parser.add_argument("project", type=Path)
    args = parser.parse_args()
    print(json.dumps(apply(args.project), ensure_ascii=True, indent=2))
