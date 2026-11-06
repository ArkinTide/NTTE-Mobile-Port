// Execute the same compiled upstream lib dispatchers with and without their
// optional-phase input filter. These fixtures never substitute a dispatcher.
function scrFRLibPhaseTestTrace(_phase,_args) {
    var _hook=scrFROther(other);
    assert(is_array(_hook) && array_length(_hook)>=3,"NTUF phase filter lost authored hook tuple ownership");
    var _scope="unexpected";
    if(instance_is(id,Player)) _scope="Player";
    else if(instance_is(id,GameCont)) _scope="GameCont";
    assert(_scope!="unexpected","NTUF phase callback changed native self");
    if(array_length(_args)>0) assert(array_length(_args)==2 && _args[0]<_args[1],"NTUF phase callback lost source ID cursor interval");
    array_push(global.fr_lib_phase_test_trace,{phase:_phase,scope:_scope,kind:_hook[0],module:_hook[1],
        token:_hook[2],args:array_length(_args)});
    if(variable_global_exists("fr_lib_phase_test_load_mid") && is_string(global.fr_lib_phase_test_load_mid)
       && !(global.fr_initialized[$ global.fr_lib_phase_test_load_mid]??false)) scrFRModuleInit(global.fr_lib_phase_test_load_mid);
}
function scrFRLibPhaseTestLate() {scrFRLibPhaseTestTrace("late_step",[]);}
function scrFRLibPhaseTestEnd() {scrFRLibPhaseTestTrace("end_step",[]);}
function scrFRLibPhaseTestUpdate(_before,_after) {scrFRLibPhaseTestTrace("update",[_before,_after]);}
function scrFRLibPhaseTestEndUpdate(_before,_after) {scrFRLibPhaseTestTrace("end_update",[_before,_after]);}
function scrFRLibPhaseTestScripts() {
    return {late_step:scrFRLibPhaseTestLate,end_step:scrFRLibPhaseTestEnd,
        update:scrFRLibPhaseTestUpdate,end_update:scrFRLibPhaseTestEndUpdate};
}
function scrFRLibPhaseTestDispatch(_lib,_hooks,_oracle) {
    _lib.activeHooks=_hooks;global.fr_lib_phase_oracle=_oracle;global.fr_lib_phase_test_trace=[];
    if(variable_global_exists("fr_lib_phase_test_load_mid") && is_string(global.fr_lib_phase_test_load_mid)) {
        global.fr_initialized[$ global.fr_lib_phase_test_load_mid]=false;scrFRLibPhaseRegistryChanged();
    }
    var _calls=["late_step","end_step","create_update","create_end_update"];
    for(var _i=0;_i<array_length(_calls);++_i) {
        // The real authored scan dispatches only if a new non-effect native
        // instance exists. It still creates and consumes its own marker.
        var _actor=instance_create(10016,10016,Dummy);
        _lib.updateid=real(_actor)-1;_lib.endupdateid=real(_actor)-1;
        with(GameCont) scrFRModCallArray("mod","lib",_calls[_i],[]);
        assert(_lib.updateid>=real(_actor)-1 && _lib.endupdateid>=real(_actor)-1,
            "NTUF optional phase filter rewound the native source cursor");
        instance_destroy(_actor,false);
    }
    return global.fr_lib_phase_test_trace;
}
function scrFRLibPhaseTestCompare(_lib,_hooks,_label,_expected) {
    var _oracle=scrFRLibPhaseTestDispatch(_lib,_hooks,true),
        _filtered=scrFRLibPhaseTestDispatch(_lib,_hooks,false);
    assert(json_stringify(_oracle)==json_stringify(_filtered),
        "NTUF optional phase filter changed source dispatch trace: "+_label+" oracle="+json_stringify(_oracle)+" filtered="+json_stringify(_filtered));
    assert(array_length(_filtered)==_expected,"NTUF phase oracle fixture did not exercise expected ownership: "+_label);
    return {label:_label,callbacks:array_length(_filtered),trace:_filtered};
}
function scrFRLibPhaseTests() {
    var _lib=scrFRLibGlobal(),_old_hooks=_lib.activeHooks,_old_update=_lib.updateid,_old_end=_lib.endupdateid,
        _old_order=array_concat(global.fr_module_order,[]),_old_races=[],_results=[],
        _a="mod:__phase_a",_missing="mod:__phase_missing",_load="mod:__phase_load",
        _skill="__phase_skill",_skillkey="skill:__phase_skill",_weapon="weapon:__phase_weapon",
        _racekey="race:fish",_keys=[_a,_missing,_load,_skillkey,_weapon],
        _had_race=variable_struct_exists(global.fr_module_scripts,_racekey),
        _old_race_scripts=global.fr_module_scripts[$ _racekey],_old_race_init=global.fr_initialized[$ _racekey],
        _old_race_vars=global.fr_module_vars[$ _racekey];
    with(Player) {array_push(_old_races,[id,race]);race=Race.Fish;}
    assert(array_length(_old_races)>0,"NTUF phase ownership fixture has no real native Player");
    var _skillid=9999;
    assert(is_undefined(global.fr_skill_ids[$ _skill]) && is_undefined(global.fr_skill_keys[$ string(_skillid)]),"NTUF phase fixture skill identity is already allocated");
    try {
        scrFRRegisterModule(_a,scrFRLibPhaseTestScripts());scrFRModuleInit(_a);
        scrFRRegisterModule(_missing,{});scrFRModuleInit(_missing);
        scrFRRegisterModule(_load,scrFRLibPhaseTestScripts());
        scrFRRegisterModule(_skillkey,scrFRLibPhaseTestScripts());scrFRModuleInit(_skillkey);
        scrFRRegisterModule(_weapon,scrFRLibPhaseTestScripts());scrFRModuleInit(_weapon);
        if(!_had_race) scrFRRegisterModule(_racekey,scrFRLibPhaseTestScripts());
        else global.fr_module_scripts[$ _racekey]=scrFRLibPhaseTestScripts();
        global.fr_initialized[$ _racekey]=true;scrFRLibPhaseRegistryChanged();
        global.fr_skill_ids[$ _skill]=_skillid;global.fr_skill_keys[$ string(_skillid)]=_skillkey;
        scrFRSetSkill(_skill,0);
        var _hooks=[["mod",_a,"first"],["mod",_a,"duplicate"],["mod",_missing,"absent"],
            ["skill",_skill,"owned"],["race","fish","race"],["weapon",_weapon,"weapon-default"],
            ["mod",_load,"not-loaded"]];
        // Four dispatch entry points produce six callback phases in total:
        // late/end include their unchanged create_update/create_end_update.
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"unowned skill and unloaded module",24));
        scrFRSetSkill(_skill,1);
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"skill acquired without cache invalidation",30));
        with(Player) race=Race.Melting;
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"race changed without cache invalidation",24));
        global.fr_lib_phase_test_load_mid=_load;
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"prior callback loads later module in same dispatch",30));
        global.fr_lib_phase_test_load_mid=undefined;
        global.fr_initialized[$ _load]=false;scrFRLibPhaseRegistryChanged();
        scrFRModuleInit(_load);
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"module authored load",30));
        // Replace equal kind/module tuples, then reorder duplicates. Cached
        // indices must expose the live tuple token through logical other.
        _hooks[0]=["mod",_a,"replacement"];
        var _swap=_hooks[0];_hooks[0]=_hooks[1];_hooks[1]=_swap;
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"live tuple replacement and duplicate order",30));
        var _dynamic="mod:__phase_dynamic";
        scrFRRegisterModule(_dynamic,scrFRLibPhaseTestScripts());array_push(_keys,_dynamic);scrFRModuleInit(_dynamic);
        _hooks[2]=["mod",_dynamic,"dynamic-registration"];
        array_push(_results,scrFRLibPhaseTestCompare(_lib,_hooks,"dynamic registration and in-place key edit",36));
        var _filtered=scrFRLibPhaseHooks(_hooks,"late_step"),_entry=global.fr_lib_phase_cache.late_step;
        assert(array_length(_filtered)==7 && array_length(_entry.indices)==7,"NTUF phase filter discarded valid dynamic or ownership callbacks");
        var _foreign=[["mod","__unknown_phase_module","foreign"]];
        assert(array_length(scrFRLibPhaseHooks(_foreign,"late_step"))==1,"NTUF phase filter swallowed foreign source module errors");
        var _malformed=[42];
        assert(scrFRLibPhaseHooks(_malformed,"late_step")[0]==42,"NTUF phase filter swallowed malformed source hook errors");
        scrNTTESmokeLog("NTUF SOURCE PHASE ORACLE PASS "+json_stringify(_results));
    } finally {
        global.fr_lib_phase_oracle=false;
        global.fr_lib_phase_test_load_mid=undefined;
        scrFRSetSkill(_skill,0);
        variable_struct_remove(global.fr_skill_ids,_skill);variable_struct_remove(global.fr_skill_keys,string(_skillid));
        for(var _i=0;_i<array_length(_keys);++_i) {
            variable_struct_remove(global.fr_module_scripts,_keys[_i]);variable_struct_remove(global.fr_module_vars,_keys[_i]);
            variable_struct_remove(global.fr_initialized,_keys[_i]);
        }
        if(_had_race) {
            global.fr_module_scripts[$ _racekey]=_old_race_scripts;global.fr_module_vars[$ _racekey]=_old_race_vars;
            global.fr_initialized[$ _racekey]=_old_race_init;
        } else {
            variable_struct_remove(global.fr_module_scripts,_racekey);variable_struct_remove(global.fr_module_vars,_racekey);
            variable_struct_remove(global.fr_initialized,_racekey);
        }
        global.fr_module_order=_old_order;scrFRLibPhaseRegistryChanged();
        for(var _i=0;_i<array_length(_old_races);++_i) if(instance_exists(_old_races[_i][0])) _old_races[_i][0].race=_old_races[_i][1];
        if(instance_exists(_lib)) {_lib.activeHooks=_old_hooks;_lib.updateid=_old_update;_lib.endupdateid=_old_end;}
    }
    scrFRLibStorageTests();
}

function scrFRLibStorageTestNoop() {}
function scrFRLibStorageQueryTestCompare(_label,_count,_known=[]) {
    var _oracle=variable_global_exists("fr_lib_storage_oracle")?global.fr_lib_storage_oracle:false;
    try {
        // Keep the full original generic query as an independent oracle. Do
        // not sort: native instance order and real-number IDs are observable.
        var _raw=scrFRMatching(FRCustomObject,"name","libGlobal");
        assert(array_length(_raw)==_count,"NTUF storage query fixture count changed: "+_label);
        for(var _i=0;_i<array_length(_known);++_i) assert(array_contains(_raw,real(_known[_i])),
            "NTUF storage query fixture lost a known native identity: "+_label);
        global.fr_lib_storage_oracle=false;
        var _native=scrFRLibStorageInstances();
        assert(json_stringify(_raw)==json_stringify(_native),
            "NTUF fresh native storage query differs from exact original order/identities: "+_label);
        global.fr_lib_storage_oracle=true;
        assert(json_stringify(_raw)==json_stringify(scrFRLibStorageInstances()),
            "NTUF storage query test switch stopped using the original query: "+_label);
    } finally {global.fr_lib_storage_oracle=_oracle;}
}
function scrFRLibStorageQueryTests() {
    var _before=scrNTTEFullInstances(all),_parked=noone,_seed=random_get_seed();
    try {
        scrFRLibStorageQueryTestCompare("missing",0);
        var _a=instance_create(0,0,FRCustomObject);_a.name="libGlobal";
        scrFRLibStorageQueryTestCompare("unique",1,[_a]);
        var _b=instance_create(0,0,FRCustomObject);_b.name="libGlobal";
        scrFRLibStorageQueryTestCompare("dynamic duplicate",2,[_a,_b]);
        var _unrelated=instance_create(0,0,FRCustomObject);_unrelated.name="__not_libGlobal";
        // Native instance_change(false) intentionally skips the new Create,
        // giving the same real class a legal missing-name field edge case.
        var _nameless=instance_create(0,0,FRMarker);
        with(_nameless) instance_change(FRCustomObject,false);
        assert(instance_is(_nameless,FRCustomObject) && !variable_instance_exists(_nameless,"name"),
            "NTUF storage query missing-name fixture unexpectedly initialized its name");
        scrFRLibStorageQueryTestCompare("unrelated and missing name",2,[_a,_b]);
        _a.name="__renamed_libGlobal";
        scrFRLibStorageQueryTestCompare("rename immediately excludes",1,[_b]);
        _unrelated.name="libGlobal";
        scrFRLibStorageQueryTestCompare("rename immediately admits",2,[_b,_unrelated]);
        _parked=_b;instance_deactivate_object(_parked);
        scrFRLibStorageQueryTestCompare("deactivated storage",1,[_unrelated]);
        instance_activate_object(_parked);_parked=noone;
        scrFRLibStorageQueryTestCompare("reactivated storage",2,[_b,_unrelated]);
        instance_destroy(_b,false);
        scrFRLibStorageQueryTestCompare("destroyed storage",1,[_unrelated]);
        var _replacement=instance_create(0,0,FRCustomObject);_replacement.name="libGlobal";
        scrFRLibStorageQueryTestCompare("new identity after destruction",2,[_unrelated,_replacement]);
        instance_destroy(_unrelated,false);instance_destroy(_replacement,false);
        scrFRLibStorageQueryTestCompare("missing after retirement",0);
        scrNTTESmokeLog("PASS NTUF exact fresh native libGlobal query source order, real IDs, dynamic duplicate/rename/replacement, missing name and deactivation/reactivation");
    } finally {
        if(_parked!=noone) instance_activate_object(_parked);
        scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed);
    }
}
function scrFRLibStorageTestTrace(_phase) {
    assert(instance_is(id,GameCont),"NTUF lib storage oracle changed callback native self");
    var _tuple=scrFROther(other),_expected=global.fr_lib_storage_test_expected,
        _fields=variable_struct_get_names(_expected),_vars=global.fr_module_vars[$ "mod:lib"];
    for(var _i=0;_i<array_length(_fields);++_i) assert(
        json_stringify(_vars[$ _fields[_i]])==json_stringify(_expected[$ _fields[_i]]),
        "NTUF unique storage read changed source field "+_fields[_i]);
    array_push(global.fr_lib_storage_test_trace,_phase+":"+_tuple[2]);
}
function scrFRLibStorageTestLevel() {scrFRLibStorageTestTrace("level_start");}
function scrFRLibStorageTestMutation(_current,_previous) {
    assert(json_stringify(_previous)==json_stringify(global.fr_lib_storage_test_expected.previousmutations),
        "NTUF storage oracle changed mutation callback arguments");
    scrFRLibStorageTestTrace("mutation_update");
}
function scrFRLibStorageTestRecord(_tag,_module) {
    return {loadedPackages:{oracle:_tag},scriptReferences:{oracle:_tag},
        activeReferences:[["mod",_module,_tag]],
        activeHooks:[["mod",_module,_tag+"-first"],["mod",_module,_tag+"-duplicate"]],
        updateid:_tag=="selected"?170001:170002,endupdateid:_tag=="selected"?170003:170004,
        level_loading:true,canLoad:_tag,
        bind_late_step:scrFRBindStep(scrFRLibStorageTestNoop),
        bind_end_step:scrFRBindEndStep(scrFRLibStorageTestNoop),previousmutations:[_tag]};
}
function scrFRLibStorageTestRun(_case,_oracle,_module,_baseline) {
    var _before=scrNTTEFullInstances(all),_vars=scrFRLQClone(_baseline),
        _fallback=scrFRLibStorageTestRecord("fallback",_module),
        _selected=scrFRLibStorageTestRecord("selected",_module),_fields=variable_struct_get_names(_fallback);
    try {
        global.fr_module_vars[$ "mod:lib"]=_vars;
        for(var _i=0;_i<array_length(_fields);++_i) _vars[$ _fields[_i]]=_fallback[$ _fields[_i]];
        var _initial=[];
        if(_case!="missing") {
            var _storage=instance_create(0,0,FRCustomObject);_storage.name="libGlobal";
            for(var _i=0;_i<array_length(_fields);++_i)
                variable_instance_set(_storage,_fields[_i],_selected[$ _fields[_i]]);
            if(_case!="missing timestamp") _storage.lastUpdatedFrame=scrFRSourceFrame()-(_case=="stale"?2:0);
            array_push(_initial,_storage);
        }
        if(_case=="duplicate") {
            var _duplicate=instance_create(0,0,FRCustomObject);_duplicate.name="libGlobal";
            array_push(_initial,_duplicate);
        }
        var _unique=_case=="unique",_pre_selected=_case!="missing" && _case!="duplicate";
        assert(fr_dependencies_lib_mod_gml_GlobalGet("canLoad")==(_pre_selected?"selected":"fallback"),
            "NTUF storage oracle fixture lost original unique/duplicate/missing lookup semantics");
        global.fr_lib_storage_test_expected=_unique?_selected:_fallback;
        global.fr_lib_storage_test_trace=[];global.fr_lib_storage_oracle=_oracle;
        with(GameCont) scrFRModCallArray("mod","lib","step",[]);
        var _matches=scrFRMatching(FRCustomObject,"name","libGlobal");
        assert(array_length(_matches)==1,"NTUF lib storage step failed its original unique-storage recovery");
        var _live=_matches[0],_rebuild=!_unique;
        if(_unique) assert(_live==_initial[0],"NTUF direct reads replaced a valid source storage instance");
        else for(var _i=0;_i<array_length(_initial);++_i) assert(!instance_exists(_initial[_i]),
            "NTUF source storage rebuild retained a duplicate or stale owner");
        assert(_live.lastUpdatedFrame==scrFRSourceFrame() && !_live.level_loading,
            "NTUF storage optimization changed source timestamp or level-start state");
        var _trace=global.fr_lib_storage_test_trace,_tag=_unique?"selected":"fallback",
            _expected=["level_start:"+_tag+"-first","level_start:"+_tag+"-duplicate",
                "mutation_update:"+_tag+"-first","mutation_update:"+_tag+"-duplicate"];
        assert(json_stringify(_trace)==json_stringify(_expected),
            "NTUF real source storage step changed callback order or duplicate ownership: "+_case);
        assert(json_stringify(_live.previousmutations)!=json_stringify([_tag]),
            "NTUF storage oracle skipped the original mutation-update write");
        var _unchanged=json_stringify(_live.previousmutations);
        global.fr_lib_storage_test_trace=[];
        with(GameCont) scrFRModCallArray("mod","lib","step",[]);
        assert(array_length(global.fr_lib_storage_test_trace)==0
            && json_stringify(_live.previousmutations)==_unchanged,
            "NTUF unchanged mutation fastpath added a callback or wrote a changed mutation array");
        return {label:_case,rebuilt:_rebuild,callbacks:_trace,stamp:_live.lastUpdatedFrame,
            unchanged_callbacks:array_length(global.fr_lib_storage_test_trace),unchanged_mutations:_unchanged};
    } finally {
        global.fr_module_vars[$ "mod:lib"]=_baseline;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}
function scrFRLibStorageTests() {
    assert(!instance_exists(GenCont) && !instance_exists(Menu),"NTUF lib storage oracle requires a live native level");
    var _ref={value:1},_other_ref={value:1},_nil=undefined;
    assert(scrFRLibMutationsEqual([],[]) && scrFRLibMutationsEqual([1,"a"],[1,"a"])
        && !scrFRLibMutationsEqual([1],[1,2]) && !scrFRLibMutationsEqual([1],[2])
        && !scrFRLibMutationsEqual(undefined,[]) && !scrFRLibMutationsEqual({},[])
        && scrFRLibMutationsEqual([_ref],[_ref]) && !scrFRLibMutationsEqual([_ref],[_other_ref])
        && scrFRLibMutationsEqual([_nil],[_nil])==!(_nil!=_nil),
        "NTUF unchanged mutation helper changed exact source element/length/type equality");
    var _lib=scrFRLibGlobal(),_name=_lib.name,_vars=global.fr_module_vars[$ "mod:lib"],
        _owner=global.fr_lib_global,_order=array_concat(global.fr_module_order,[]),
        _module="__storage_oracle",_key="mod:"+_module,_results=[];
    assert(array_length(scrFRMatching(FRCustomObject,"name","libGlobal"))==1,
        "NTUF lib storage oracle started with unexpected duplicate storage");
    try {
        scrFRRegisterModule(_key,{level_start:scrFRLibStorageTestLevel,mutation_update:scrFRLibStorageTestMutation});
        scrFRModuleInit(_key);_lib.name="__held_lib_storage_oracle";
        scrFRLibStorageQueryTests();
        var _cases=["unique","duplicate","missing","stale","missing timestamp"];
        for(var _i=0;_i<array_length(_cases);++_i) {
            var _raw=scrFRLibStorageTestRun(_cases[_i],true,_module,_vars),
                _direct=scrFRLibStorageTestRun(_cases[_i],false,_module,_vars);
            assert(json_stringify(_raw)==json_stringify(_direct),
                "NTUF uniquely selected storage reads differ from actual source oracle: "+_cases[_i]);
            array_push(_results,_direct);
        }
        scrNTTESmokeLog("NTUF SOURCE STORAGE ORACLE PASS "+json_stringify(_results));
    } finally {
        global.fr_lib_storage_oracle=false;global.fr_lib_storage_test_expected=undefined;
        global.fr_lib_storage_test_trace=[];global.fr_module_vars[$ "mod:lib"]=_vars;
        if(instance_exists(_lib)) _lib.name=_name;
        global.fr_lib_global=_owner;global.fr_module_order=_order;
        variable_struct_remove(global.fr_module_scripts,_key);variable_struct_remove(global.fr_module_vars,_key);
        variable_struct_remove(global.fr_initialized,_key);scrFRLibPhaseRegistryChanged();
    }
}
