// Only the upstream loader/import/ping entry points are replaced. The real
// libGeneral, libSaves, libEvents, libWeps, libPickups, libMuts and libAreas
// implementations are compiled and retain their script and hook registries.
function scrFRLibBootstrap() {
    var _items=scrFRMatching(FRCustomObject,"name","libGlobal");
    var _lib=array_length(_items)>0?_items[0]:noone;
    if(!instance_exists(_lib)) _lib=instance_create(0,0,FRCustomObject);
    _lib.name="libGlobal"; _lib.persistent=true;
    _lib.loadedPackages={}; _lib.scriptReferences={};
    _lib.activeReferences=[]; _lib.activeHooks=[];
    _lib.updateid=real(instance_create(0,0,FRMarker));
    _lib.endupdateid=_lib.updateid; _lib.level_loading=false;
    _lib.canLoad=false; _lib.bind_late_step=noone; _lib.bind_end_step=noone;
    _lib.previousmutations=[]; _lib.lastUpdatedFrame=scrFRSourceFrame();
    var _vars=global.fr_module_vars[$ "mod:lib"],_fields=["loadedPackages","scriptReferences","activeReferences","activeHooks","updateid","endupdateid","level_loading","canLoad","bind_late_step","bind_end_step","previousmutations"];
    for(var _i=0;_i<array_length(_fields);++_i) _vars[$ _fields[_i]]=variable_instance_get(_lib,_fields[_i]);
    _lib.scriptReferences[$ "import"]=["mod","lib","import"];
    _lib.scriptReferences[$ "getRef"]=["mod","lib","getRef"];
    global.fr_lib_global=_lib;
    return _lib;
}

function scrFRLibImport(_package) {
    var _key=scrFRModuleKey("mod",_package);
    assert(variable_struct_exists(global.fr_module_scripts,_key),"Frontier offline dependency missing: "+string(_package));
    var _lib=scrFRLibGlobal();
    if(instance_exists(_lib)) _lib.loadedPackages[$ _package]=2;
    return true;
}

function scrFRLibGlobal() {
    // lib::step legitimately replaces its persistent storage after a clock
    // gap. Follow that instance without bootstrapping or resetting hooks.
    if(variable_global_exists("fr_lib_global") && instance_exists(global.fr_lib_global)
       && (global.fr_lib_global[$ "name"]??"")=="libGlobal") return global.fr_lib_global;
    var _items=scrFRMatching(FRCustomObject,"name","libGlobal");
    global.fr_lib_global=array_length(_items)>0?_items[0]:noone;
    return global.fr_lib_global;
}

function scrFRLibPing() { return false; }

function scrFROfflineLoader(_module) {
    // Download/update modules have no gameplay callbacks. Assets and required
    // dependencies are installed as native resources before initialization.
    return variable_struct_exists(global.fr_module_scripts,scrFRModuleKey("mod",_module));
}

function scrFRSourceScale() {
    if(variable_global_exists("fr_source_scale_override") && !is_undefined(global.fr_source_scale_override)) return global.fr_source_scale_override;
    return (variable_global_exists("fr_render_context") && global.fr_render_context)?timescale:1;
}

function scrFRSourceScaleSet(_value) { global.fr_source_scale_override=_value; return _value; }
// Authored anim_end/animation_end macros predict the next source callback.
// Native image_speed is per host frame, while ordinary source callbacks run
// once per 30 Hz logic tick. Cover that whole interval so 60 Hz animation
// cannot wrap between two checks. Draw retains its one-host-frame horizon.
function scrFRAnimationEnd() {
    var _advance=image_speed;
    if(timescale>0) _advance*=scrFRSourceScale()/timescale;
    var _next=image_index+_advance;
    return _next>=image_number || _next<0;
}
function scrFRLogicSerial() { return instance_exists(FRWorld)?FRWorld.logic_serial:floor(current_frame); }

function scrFRSourceFrame() {
    if(variable_global_exists("fr_render_context") && global.fr_render_context) return current_frame;
    // Native hurt timers and source timers must share UberCont's clock. The
    // private serial only identifies a dispatched logical tick for bindings.
    return floor(current_frame);
}

function scrFRInvokeDraw(_scope,_reference,_args) {
    var _old=global.fr_render_context;
    var _old_scale=global.fr_source_scale_override;
    global.fr_render_context=true;
    global.fr_source_scale_override=undefined;
    try { return scrFRInvoke(_scope,_reference,_args); }
    finally { global.fr_render_context=_old; global.fr_source_scale_override=_old_scale; }
}

function scrFREnabled() {
    // A stale flag is insufficient after a complete world teardown. Native
    // callers must not dispatch source hooks without their owning controller.
    return variable_global_exists("fr_enabled") && global.fr_enabled && instance_exists(FRWorld);
}
function scrFRReadyTick() {
    // The native pause UI can still query area metadata or submit a choice.
    // Readiness remains available, but no source AI, alarm or task may tick.
    return scrFREnabled() && !lockstep_stop && !UberCont.paused && FRWorld.logic_tick;
}

function scrFRWorldEnsure() {
    // instance_exists deliberately excludes inactive instances. Restore the
    // registered persistent owner before deciding a new bootstrap is needed.
    if(variable_global_exists("fr_world_owner") && global.fr_world_owner!=noone) {
        instance_activate_object(global.fr_world_owner);
        if(instance_exists(global.fr_world_owner)
            && global.fr_world_owner.object_index==FRWorld) return global.fr_world_owner;
    }
    if(instance_exists(FRWorld)) return instance_find(FRWorld,0);
    return instance_create(0,0,FRWorld);
}

function scrFRPausePrepare() {
    // lib::step may have legitimately replaced its persistent storage since
    // the last native lookup. Resolve that live owner before deactivation;
    // looking it up afterwards cannot discover an inactive replacement.
    if(variable_global_exists("fr_enabled") && global.fr_enabled) scrFRLibGlobal();
}

function scrFRPauseKeepAlive() {
    // Only the runtime registry and its library storage survive the native
    // deactivation barrier. Gameplay actors and bindings stay inactive.
    if(!variable_global_exists("fr_enabled") || !global.fr_enabled) return;
    scrFRWorldEnsure();
    if(variable_global_exists("fr_lib_global") && global.fr_lib_global!=noone)
        instance_activate_object(global.fr_lib_global);
    if(instance_exists(FRWorld)) FRWorld.logic_tick=false;
}

function scrFRWorldCleanup() {
    if(variable_global_exists("fr_world_owner") && global.fr_world_owner==id) {
        global.fr_world_owner=noone;global.fr_enabled=false;
    }
}

function scrFRWorldDraw(_hook) {
    if(!UberCont.paused && !lockstep_stop) scrFRHook(_hook,[]);
}

function scrFRWorldInit() {
    if(variable_global_exists("fr_world_owner") && global.fr_world_owner!=noone && global.fr_world_owner!=id) {
        instance_activate_object(global.fr_world_owner);
        if(instance_exists(global.fr_world_owner) && global.fr_world_owner.object_index==FRWorld) {
            instance_destroy();return;
        }
    }
    global.fr_world_owner=id;
    global.fr_boot_generation=(variable_global_exists("fr_boot_generation")?global.fr_boot_generation:0)+1;
    logic_accumulator=0; logic_tick=true; logic_serial=0;
    fr_previous_game=noone; global.fr_render_context=false;global.fr_source_scale_override=undefined;
    scrFRRuntimeInit();
    global.fr_boot_errors=[];
    global.fr_collect_errors=(os_type==os_windows && scrNTTEFullSmokeEnabled());
    // __load contains only authored declarations outside #define. Runtime
    // tables are registered before any init can obtain a qualified reference.
    for(var _i=0;_i<array_length(global.fr_module_order);++_i) {
        var _key=global.fr_module_order[_i];
        var _code=global.fr_module_scripts[$ _key][$ "__load"];
        if(!is_undefined(_code)) scrFRInvokeHere(_code,[]);
    }
    var _priority=["mod:lib","mod:libGeneral","mod:libMenu","mod:libSaves","mod:libEvents","mod:libWeps","mod:libPickups","mod:libMuts","mod:libAreas","mod:wibbly","mod:custom_options"];
    for(var _i=0;_i<array_length(_priority);++_i) scrFRModuleInit(_priority[_i]);
    for(var _i=0;_i<array_length(global.fr_module_order);++_i)
        if(global.fr_module_order[_i]!="mod:campfire") scrFRModuleInit(global.fr_module_order[_i]);
    // Source campfire:init snapshots mod_get_names("race") once. All race
    // modules must be initialized before that snapshot; registered modules
    // alone must remain invisible to the source's loaded-module queries.
    scrFRModuleInit("mod:campfire");
    if(array_length(global.fr_boot_errors)>0)
        throw "Frontier bootstrap failed in "+string(array_length(global.fr_boot_errors))+" modules; see isolated INIT FAILURE records";
    scrFRWeaponsInit();
    scrFRCrownMetadataInit();
    global.fr_enabled=true;
}

function scrFRModuleInit(_key) {
    if(global.fr_initialized[$ _key]??false) return;
    if(!variable_struct_exists(global.fr_module_scripts,_key)) return;
    global.fr_initialized[$ _key]=true;
    var _code=global.fr_module_scripts[$ _key][$ "init"];
    if(!is_undefined(_code)) {
        if(global.fr_collect_errors) {
            // Collect independent initialization failures in the isolated
            // harness, then abort before enabling gameplay. Shipping boots
            // retain fail-fast behavior and never continue a failed module.
            try {scrFRInvokeHere(_code,[]);}
            catch(_error) {
                var _record={module:_key,error:_error};
                array_push(global.fr_boot_errors,_record);
                scrNTTESmokeLog("FRONTIER INIT FAILURE "+json_stringify(_record));
            }
        } else scrFRInvokeHere(_code,[]);
    }
}

function scrFRWorldBegin() {
    logic_tick=false;
    if(!scrFREnabled() || lockstep_stop) return;
    if(UberCont.paused) {
        // UberCont's clock advances under the frozen native pause picture.
        // Keep the library heartbeat current without dispatching its step or
        // allowing its gap-recovery branch to rebuild persistent storage.
        var _lib=scrFRLibGlobal();
        if(instance_exists(_lib)) _lib.lastUpdatedFrame=scrFRSourceFrame();
        return;
    }
    logic_accumulator+=timescale;
    if(logic_accumulator>=1) {
        logic_accumulator-=1; logic_tick=true; logic_serial++;
        scrFRHook("begin_step",[]);
    }
}

function scrFRWorldStep() {
    if(!scrFREnabled() || lockstep_stop) return;
    if(UberCont.paused) {
        // UberCont advances current_frame in normal Step, after this world's
        // Begin Step. Match lib::step's usual heartbeat phase so the first
        // resumed Step is one source tick later, rather than a false gap of2.
        var _lib=scrFRLibGlobal();
        if(instance_exists(_lib)) _lib.lastUpdatedFrame=scrFRSourceFrame();
        return;
    }
    if(!scrFRReadyTick()) return;
    scrFRTasksTick(1);
    if(instance_exists(GameCont)) {
        if(fr_previous_game!=GameCont.id) {
            fr_previous_game=GameCont.id;
            scrFRHook("game_start",[]); scrFRWeaponsRefresh();
        }
    } else fr_previous_game=noone;
    scrFRHook("step",[]);
    scrFRCrownStep();
}

function scrFRWorldEnd() {
    if(!scrFRReadyTick() || lockstep_stop || UberCont.paused) return;
    // lib owns late_step/end_step through its two FRBinding objects. Calling
    // them again here doubles updates and activeHooks callbacks every tick.
}

function scrFRHook(_hook,_args=[]) {
    if(!scrFREnabled()) return;
    var _keys=global.fr_hook_cache[$ _hook];
    if(is_undefined(_keys)) {
        _keys=[];
        for(var _i=0;_i<array_length(global.fr_module_order);++_i) {
            var _key=global.fr_module_order[_i];
            if(string_pos("mod:",_key)!=1) continue;
            if(variable_struct_exists(global.fr_module_scripts[$ _key],_hook)) array_push(_keys,_key);
        }
        global.fr_hook_cache[$ _hook]=_keys;
    }
    var _failures=global.fr_collect_errors?[]:undefined;
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _code=global.fr_module_scripts[$ _keys[_i]][$ _hook];
        if(global.fr_collect_errors) {
            try {
                if(string_pos("draw",_hook)==1) scrFRInvokeDraw(id,_code,_args);
                else scrFRInvokeHere(_code,_args);
            } catch(_error) {
                var _record={module:_keys[_i],hook:_hook,error:_error};
                array_push(_failures,_record);
                scrNTTESmokeLog("FRONTIER HOOK FAILURE "+json_stringify(_record));
            }
        } else {
            if(string_pos("draw",_hook)==1) scrFRInvokeDraw(id,_code,_args);
            else scrFRInvokeHere(_code,_args);
        }
    }
    if(!is_undefined(_failures) && array_length(_failures)>0)
        throw "Frontier "+_hook+" failed in "+string(array_length(_failures))+" modules; see isolated HOOK FAILURE records";
    scrFRSkillHooks(_hook,_args);
    if(_hook=="game_start" || _hook=="game_end" || _hook=="level_end") scrFRRaceEventAll(_hook,_args);
}

function scrFRDarkDraw(_phase,_xview,_yview) {
    if(!scrFREnabled()) return;
    var _world=matrix_get(matrix_world),_color=draw_get_color(),_alpha=draw_get_alpha();
    try {
        // NTT callbacks draw in room coordinates, while the native darkness
        // surface uses view-relative coordinates.
        matrix_set(matrix_world,matrix_build(-_xview,-_yview,0,0,0,0,1,1,1));
        scrFRHook(_phase,[]);
    } finally {
        // random_get_seed is the initial seed, not the current RNG state.
        // Reseeding here replayed the same random prefix after every frame,
        // preventing authored chance-based events from ever progressing.
        matrix_set(matrix_world,_world);draw_set_color(_color);draw_set_alpha(_alpha);
    }
}

