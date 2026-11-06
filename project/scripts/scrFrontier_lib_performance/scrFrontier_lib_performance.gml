// Filter optional no-op phases before the original lib with/switch dispatcher.
// Skill ownership, race checks, scopes, order, duplicates and cursor updates
// remain in the authored code. Only static callback presence is cached.
function scrFRLibStorageOracle() {
    return variable_global_exists("fr_lib_storage_oracle") && global.fr_lib_storage_oracle
        && os_type==os_windows && scrNTTEFullSmokeEnabled();
}

function scrFRLibStorageInstances() {
    if(scrFRLibStorageOracle()) return scrFRMatching(FRCustomObject,"name","libGlobal");
    // The original query first uses this same native with to collect every
    // FRCustomObject ID, then filters its name. No alias, optional identity or
    // NTTE pet expansion applies to this exact class/field/value triple.
    // Keep each scan fresh: callbacks may rename, replace, duplicate, destroy
    // or deactivate the storage between reads in the original source.
    var _items=[];
    with(FRCustomObject) {
        if(variable_instance_exists(id,"name")) {
            if(name=="libGlobal") array_push(_items,real(id));
        }
    }
    return _items;
}

function scrFRLibMutationsEqual(_previous,_current) {
    if(!is_array(_previous) || !is_array(_current) || array_length(_previous)!=array_length(_current)) return false;
    for(var _i=0;_i<array_length(_current);++_i) if(_previous[_i]!=_current[_i]) return false;
    return true;
}

function scrFRLibMutationsUnchanged(_current) {
    if(scrFRLibStorageOracle()) return false;
    // Keep the original lookup, including duplicate/missing-storage fallback.
    // On a real change the entire authored loop still performs its own fresh
    // reads, callbacks and write. Only its pure equal-array scan is skipped.
    return scrFRLibMutationsEqual(fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"),_current);
}

function scrFRLibPhaseRegistryChanged() {
    global.fr_lib_phase_revision=(variable_global_exists("fr_lib_phase_revision")?global.fr_lib_phase_revision:0)+1;
}

function scrFRLibPhasePresent(_kind,_module,_phase) {
    var _key=scrFRModuleKey(_kind,_module);
    // Foreign/native modules retain their original dispatch and errors.
    if(!variable_struct_exists(global.fr_module_scripts,_key)) return true;
    // A prior hook can load this module during the same source dispatch.
    // Keep future modules in the snapshot so that later authored calls see
    // their current visibility; their normal call adapter remains the gate.
    if(!(global.fr_initialized[$ _key]??false)) return true;
    var _code=global.fr_module_scripts[$ _key][$ _phase];
    return !is_undefined(_code) && _code!=0;
}

function scrFRLibPhaseHooks(_hooks,_phase) {
    if(variable_global_exists("fr_lib_phase_oracle") && global.fr_lib_phase_oracle
       && os_type==os_windows && scrNTTEFullSmokeEnabled()) return _hooks;
    if(!is_array(_hooks)) return _hooks;
    if(!variable_global_exists("fr_lib_phase_cache")) global.fr_lib_phase_cache={};
    var _revision=variable_global_exists("fr_lib_phase_revision")?global.fr_lib_phase_revision:0,
        _count=array_length(_hooks),_entry=global.fr_lib_phase_cache[$ _phase],
        _valid=is_struct(_entry) && _entry.revision==_revision && array_length(_entry.signatures)==_count;
    // Compare the meaningful scalar fields on every call. This detects source
    // reorder, append, remove and in-place tuple edits without array identity
    // assumptions. Cached indices always select the current original tuples.
    for(var _i=0;_i<_count;++_i) {
        var _hook=_hooks[_i];
        if(!is_array(_hook) || array_length(_hook)<2 || !is_string(_hook[0]) || !is_string(_hook[1])) return _hooks;
        if(_valid) {
            var _signature=_entry.signatures[_i];
            if(_signature[0]!=_hook[0] || _signature[1]!=_hook[1]) _valid=false;
        }
    }
    if(!_valid) {
        var _signatures=[],_indices=[];
        for(var _i=0;_i<_count;++_i) {
            var _hook=_hooks[_i];
            array_push(_signatures,[_hook[0],_hook[1]]);
            if(scrFRLibPhasePresent(_hook[0],_hook[1],_phase)) array_push(_indices,_i);
        }
        _entry={revision:_revision,signatures:_signatures,indices:_indices,
            builds:is_struct(_entry)?_entry.builds+1:1};
        global.fr_lib_phase_cache[$ _phase]=_entry;
    }
    var _result=[];
    for(var _i=0;_i<array_length(_entry.indices);++_i) array_push(_result,_hooks[_entry.indices[_i]]);
    return _result;
}
