"""Minimal shared NTTE ProtoChest persistence repair; ordinary IDs stay numeric.

Apply only to explicitly selected maintained projects. No release copies or
save files are changed by this tool. All anchors are checked before any write.
"""
from pathlib import Path
import argparse
import hashlib
import json


HELPERS_V1 = r'''
// The Proto Chest survives runs/processes; an inventory handle does not.
// Keep its original numeric slot as a backward-compatible stock fallback,
// and put the complete physical weapon graph in a separate JSON string.
function scrNTTEFullProtoWeaponSave(_weapon,_replace=false) {
    // Startup reads the old numeric field before the chest/NTUF registries
    // are needed. An unrelated autosave must retain that unopened snapshot.
    var _stored=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    if(!_replace && _weapon==_stored && !is_struct(_weapon)
        && !scrNTTEFullWeaponIsNative(_weapon)
        && is_string(_snapshot) && string_length(_snapshot)>0) return;
    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model);
    if(!scr_weapon_is_valid(_model)) {_model=wep_rusty_revolver;_raw=_model;}
    _snapshot=is_struct(_model)?json_stringify(scrNTTEFullLoadoutWeaponPack(_model)):"";
    save_set_value("etc","protowep",_raw);
    save_set_value("etc","protowep_model",_snapshot);
}
function scrNTTEFullProtoWeaponRestore(_weapon) {
    var _saved=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    // A live chest transfer keeps its existing physical handle. Only the
    // matching durable numeric slot may adopt the saved reset snapshot.
    if(_weapon==_saved && is_string(_snapshot) && string_length(_snapshot)>0) {
        try {
            var _model=scrNTTEFullLoadoutWeaponUnpack(json_parse(_snapshot));
            if(is_struct(_model) && scr_weapon_is_valid(_model)) {
                var _part=_model;
                while(true) {
                    if(is_struct(_part) && is_struct(scrNTTEFullValue(_part,"ntte_native_state",undefined))) {
                        _part.ntte_native_state.weapon=scrNTTEFullWeaponNative(_part);
                        _part.ntte_native_state=scrNTTEStateRestored(_part.ntte_native_state);
                    }
                    if(scrNTTEFullWeaponHasMerge(_part)==false) break;
                    _part=scrNTTEFullWeaponMergedPart(_part);
                }
                return scrNTTEFullWeaponNative(_model);
            }
        } catch(_error) {
            // A damaged companion cannot invalidate an ordinary legacy slot.
        }
    }
    // Older versions wrote bare temporary handles. If their model is gone,
    // no composition remains to reconstruct; never expose an invalid pickup.
    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;
}
'''


_SAVE_V1 = '''    // Startup reads the old numeric field before the chest/NTUF registries
    // are needed. An unrelated autosave must retain that unopened snapshot.
    var _stored=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    if(!_replace && _weapon==_stored && !is_struct(_weapon)
        && !scrNTTEFullWeaponIsNative(_weapon)
        && is_string(_snapshot) && string_length(_snapshot)>0) return;'''
_SAVE_FINAL = '''    // A scalar equal to the permanent slot came from that durable slot,
    // not from a proven live transfer. Preserve it until the chest restores it,
    // even if a new physical model now occupies the same old temporary number.
    // Only explicit Room End storage may replace this unopened snapshot.
    var _stored=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model","");
    if(!_replace && _weapon==_stored && !is_struct(_weapon)) return;'''
_RESTORE_V1 = '''    // Older versions wrote bare temporary handles. If their model is gone,
    // no composition remains to reconstruct; never expose an invalid pickup.
    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;'''
_RESTORE_FINAL = '''    if(_weapon==_saved && !is_struct(_weapon)) {
        // Permanent scalar slots are static IDs only. A currently registered
        // physical handle may merely reuse an old process's numeric value;
        // its unrelated model cannot reconstruct the lost stored composition.
        // Historical scalars within today's static ID range are ambiguous:
        // preserve ordinary weapon compatibility rather than guess a fusion.
        return is_numeric(_weapon) && _weapon==floor(_weapon)
            && _weapon>0 && _weapon<=maxwep ? _weapon:wep_rusty_revolver;
    }
    // A different valid handle is a current-run live transfer. Keep its
    // physical object, aliases and state rather than substituting a snapshot.
    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;'''
assert HELPERS_V1.count(_SAVE_V1) == HELPERS_V1.count(_RESTORE_V1) == 1
HELPERS_V2 = HELPERS_V1.replace(_SAVE_V1, _SAVE_FINAL, 1).replace(_RESTORE_V1, _RESTORE_FINAL, 1)

_TOPOLOGY = r'''// Validate only the weapon links which native getters traverse. Shared
// metadata/state references are harmless and must retain their physical aliases.
// Keep both walks iterative so damaged graphs cannot recurse or loop forever.
function scrNTTEFullProtoWeaponTopologyValid(_weapon) {
    var _part=scrNTTEFullWeaponModel(_weapon),_parts=[];
    while(true) {
        if(is_struct(_part)) {
            for(var _i=0;_i<array_length(_parts);++_i)
                if(_parts[_i]==_part) return false;
            array_push(_parts,_part);
        }
        var _raw=_part,_wrappers=[];
        while(is_struct(_raw)) {
            for(var _i=0;_i<array_length(_wrappers);++_i)
                if(_wrappers[_i]==_raw) return false;
            array_push(_wrappers,_raw);
            if(!variable_struct_exists(_raw,"wep")) return false;
            _raw=_raw.wep;
        }
        if(!is_numeric(_raw)) return false;
        if(_raw!=floor(_raw) || _raw<0 || _raw>maxwep) return false;
        if(!is_struct(_part)) return true;
        if(!variable_struct_exists(_part,"temerge")) return true;
        var _merge=_part.temerge;
        if(!is_struct(_merge)) return true;
        if(!variable_struct_exists(_merge,"is_active")) return false;
        if(!variable_struct_exists(_merge,"wep")) return false;
        var _fronts=_merge.wep;
        if(!is_array(_fronts)) return false;
        if(array_length(_fronts)<1) return false;
        _part=scrNTTEFullWeaponModel(_fronts[0]);
    }
}
'''
_SAVE_MODEL_V2 = '''    var _model=scrNTTEFullWeaponModel(_weapon),_raw=scrNTTEFullWeaponRaw(_model);'''
_SAVE_MODEL_FINAL = '''    var _model=scrNTTEFullWeaponModel(_weapon);
    if(!scrNTTEFullProtoWeaponTopologyValid(_model)) _model=wep_rusty_revolver;
    var _raw=scrNTTEFullWeaponRaw(_model);'''
_RESTORE_MODEL_V2 = '''            var _model=scrNTTEFullLoadoutWeaponUnpack(json_parse(_snapshot));
            if(is_struct(_model) && scr_weapon_is_valid(_model)) {'''
_RESTORE_MODEL_FINAL = '''            var _model=scrNTTEFullLoadoutWeaponUnpack(json_parse(_snapshot));
            if(!scrNTTEFullProtoWeaponTopologyValid(_model))
                throw "Invalid Proto Chest weapon topology";
            if(is_struct(_model) && scr_weapon_is_valid(_model)) {'''
_LIVE_V2 = '''    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;'''
_LIVE_FINAL = '''    if(!scrNTTEFullProtoWeaponTopologyValid(_weapon)) return wep_rusty_revolver;
    return scr_weapon_is_valid(_weapon)?scrNTTEFullWeaponNative(_weapon):wep_rusty_revolver;'''
assert HELPERS_V2.count(_SAVE_MODEL_V2) == HELPERS_V2.count(_RESTORE_MODEL_V2) == HELPERS_V2.count(_LIVE_V2) == 1
HELPERS = (_TOPOLOGY + HELPERS_V2.lstrip()).replace(_SAVE_MODEL_V2, _SAVE_MODEL_FINAL, 1).replace(
    _RESTORE_MODEL_V2, _RESTORE_MODEL_FINAL, 1).replace(_LIVE_V2, _LIVE_FINAL, 1)


def planned(project):
    project = Path(project)
    changes = {}

    def change(relative, anchor, replacement):
        path = project / relative
        raw = path.read_bytes()
        source = raw.decode("utf-8-sig")
        newline = "\r\n" if "\r\n" in source else "\n"
        source = source.replace("\r\n", "\n")
        if replacement in source:
            return
        anchors = (anchor,) if isinstance(anchor, str) else anchor
        match = next((item for item in anchors if source.count(item) == 1), None)
        if match is None:
            raise RuntimeError(f"ProtoChest persistence anchor changed: {path}")
        updated = source.replace(match, replacement, 1)
        encoded = updated.replace("\n", newline).encode("utf8")
        if raw.startswith(b"\xef\xbb\xbf"):
            encoded = b"\xef\xbb\xbf" + encoded
        changes[path] = encoded

    relative = "scripts/scrNTTEFullWeaponLoadoutNative/scrNTTEFullWeaponLoadoutNative.gml"
    stored = "function scrNTTEFullLoadoutWeaponStored(_race) {"
    installed = (project / relative).read_text(encoding="utf-8-sig").replace("\r\n", "\n")
    # Replace complete known old blocks, never reinsert helpers beside an
    # unknown edited implementation which happens to retain the old anchor.
    anchor = tuple(old.lstrip() + "\n" + stored for old in (HELPERS_V2, HELPERS_V1)) \
        if "function scrNTTEFullProtoWeaponSave(" in installed else stored
    change(relative, anchor,
           HELPERS.lstrip() + "\nfunction scrNTTEFullLoadoutWeaponStored(_race) {")
    change("scripts/scrSave/scrSave.gml",
           'save_set_value("etc", "protowep", protowep)',
           'scrNTTEFullProtoWeaponSave(protowep)')
    create_anchor = "wep = UberCont.protowep\ncurse = UberCont.protocurse"
    create_v1 = (create_anchor + "\nif (!instance_exists(CoopController)) {\n"
                 "    wep = scrNTTEFullProtoWeaponRestore(wep)\n"
                 "    UberCont.protowep = wep\n}")
    create_final = (create_anchor + "\n"
                    "if (!instance_exists(CoopController) && !(scrGameIsEventRun() || scrGameIsCustomMode())) {\n"
                    "    wep = scrNTTEFullProtoWeaponRestore(wep)\n"
                    "    UberCont.protowep = wep\n}")
    # Upgrade the complete installed v1 block before considering the pristine
    # two-line anchor contained inside it; never leave two restore consumers.
    change("objects/ProtoChest/Create_0.gml", (create_v1, create_anchor), create_final)
    relative = "objects/ProtoChest/Other_5.gml"
    raw = (project / relative).read_bytes()
    text = raw.decode("utf-8-sig").replace("\r\n", "\n")
    marker = "// Snapshot only permanent normal-run storage; custom/co-op retain their original isolated behavior."
    if marker not in text:
        newline = "\r\n" if b"\r\n" in raw else "\n"
        updated = text.rstrip() + "\n\n" + marker + "\n" + (
            "if (!instance_exists(CoopController) && !(scrGameIsEventRun() || scrGameIsCustomMode()))\n"
            "    scrNTTEFullProtoWeaponSave(UberCont.protowep,true)\n")
        encoded = updated.replace("\n", newline).encode("utf8")
        changes[project / relative] = (b"\xef\xbb\xbf" if raw.startswith(b"\xef\xbb\xbf") else b"") + encoded
    return changes


def apply(projects):
    changes = {}
    for project in projects:
        changes.update(planned(project))
    for path, encoded in changes.items():
        path.write_bytes(encoded)
    return [{"path": str(path), "sha256": hashlib.sha256(data).hexdigest()}
            for path, data in changes.items()]


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("project", nargs="+", type=Path)
    print(json.dumps(apply(parser.parse_args().project), indent=2))
