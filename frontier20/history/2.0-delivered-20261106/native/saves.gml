// Frontier checkpoint data lives inside the native NTTE session chunk. The
// host regenerates the room on Continue; tasks, bindings, audio channels and
// live actors are recreated by their original setup hooks, never deserialized.
function scrFRContinueFields() {
    return [
        ["area:AlternateAreaHandler",["prevArea","tempRolls","rollingEnabled","defaultAreas"]],
        ["area:deeplabs",["deeplabsSpecial"]],
        ["area:graveyard",["variaThundershockBroken","VariaThundershockBroken"]],
        ["mod:CustomIDPDHandler",["spawnedPortals"]],
        ["mod:Frontier_Events",["nightLoop","nightCredits"]],
        ["mod:Frontier_IDPD",["fr_deactivemuts_array","fr_spawnedaugments_array"]],
        ["mod:Frontier_Main",["desertSubarea"]],
        ["mod:Frontier_Pickups",["deeplabsWepIndex"]],
        ["mod:TrinketReservation",["lastCounts"]],
        ["mod:wibbly",["wantRadMaxBuffer"]],
        ["race:bubbles",["lastKills","lastLoop","lastTime","lastBubbles"]],
        ["skill:AugmentBloodlust",["augmentBloodlustCount"]],
        ["skill:AugmentImpactWrists",["droneCharge"]],
        ["skill:AugmentLastWish",["storedHPPickups","storedAmmoPickups","storedTotalPickups","procced","procTime"]],
        ["skill:AugmentLuckyShot",["augmentLuckyShotCount"]],
        ["skill:SurgerySlot",["skillNameAdjective","skillNameNoun","statGainType","statLoseType","statGainAmount","statLoseAmount","skillGainText","skillLoseText"]],
        ["skill:SurgerySlot2",["skillNameAdjective","skillNameNoun","statGainType","statLoseType","statGainAmount","statLoseAmount","skillGainText","skillLoseText"]],
        ["skill:SurgerySlot3",["skillNameAdjective","skillNameNoun","statGainType","statLoseType","statGainAmount","statLoseAmount","skillGainText","skillLoseText"]],
        ["skill:SurgerySlot4",["skillNameAdjective","skillNameNoun","statGainType","statLoseType","statGainAmount","statLoseAmount","skillGainText","skillLoseText"]]
    ];
}

function scrFRContinueAssetFields() {
    return [
        ["skill:SurgerySlot",["sprChosenIcon"]],
        ["skill:SurgerySlot2",["sprChosenIcon"]],
        ["skill:SurgerySlot3",["sprChosenIcon"]],
        ["skill:SurgerySlot4",["sprChosenIcon"]],
        ["area:cyberspace",["prevIdle","prevWalk","prevHurt","prevDead"]]
    ];
}

function scrFRContinueGenerationFields() {
    // These authored flags can be consumed while building/starting a room.
    // Rebuild with the entry value, then retain the checkpoint's run value.
    return [["area:deeplabs",["deeplabsSpecial"]],
        ["area:graveyard",["variaThundershockBroken","VariaThundershockBroken"]]];
}

function scrFRContinueAssetName(_value,_kind="sprite") {
    // GameMaker exposes names per resource family, not asset_get_name.
    // Module asset checkpoints contain sprites; source weapon records also
    // store a projectile object. Numeric IDs can overlap between families,
    // so the owning field must supply its real type explicitly.
    switch(_kind) {
        case "sprite":
            assert(sprite_exists(_value),"Frontier checkpoint sprite is unavailable");
            return sprite_get_name(_value);
        case "object":
            assert(object_exists(_value),"Frontier checkpoint object is unavailable");
            return object_get_name(_value);
    }
    throw "Unknown Frontier checkpoint asset family: "+string(_kind);
}
function scrFRContinueEncode(_value,_asset=false,_depth=0,_asset_kind="sprite") {
    assert(_depth<16,"Frontier checkpoint contains excessive nesting");
    if(is_undefined(_value)) return {fr_type:"undefined"};
    assert(!is_method(_value),"Frontier checkpoint cannot contain code");
    if(is_array(_value)) {
        var _out=[];
        for(var _i=0;_i<array_length(_value);++_i) array_push(_out,scrFRContinueEncode(_value[_i],_asset,_depth+1,_asset_kind));
        return _out;
    }
    if(_asset && is_numeric(_value) && _value>=0) {
        var _name=scrFRContinueAssetName(_value,_asset_kind);
        assert(is_string(_name) && _name!="","Frontier checkpoint asset has no stable name");
        return {fr_type:"asset",name:_name};
    }
    if(is_numeric(_value)) {
        // Surgery uses infinity as a loss bound. Native JSON cannot represent
        // it; no authored counter approaches these finite safety bounds.
        if(_value>power(10,300)) return {fr_type:"positiveInfinity"};
        if(_value< -power(10,300)) return {fr_type:"negativeInfinity"};
        assert(_value==_value,"Frontier checkpoint contains NaN");
        return _value;
    }
    if(is_string(_value) || is_bool(_value)) return _value;
    throw "Frontier checkpoint field contains a live or unsupported value";
}

function scrFRContinueDecode(_value,_asset=false,_depth=0,_asset_kind="sprite") {
    assert(_depth<16,"Frontier checkpoint contains excessive nesting");
    if(is_array(_value)) {
        var _out=[];
        for(var _i=0;_i<array_length(_value);++_i) array_push(_out,scrFRContinueDecode(_value[_i],_asset,_depth+1,_asset_kind));
        return _out;
    }
    if(is_struct(_value)) {
        switch(_value[$ "fr_type"]??"") {
            case "undefined":return undefined;
            case "positiveInfinity":return infinity;
            case "negativeInfinity":return -infinity;
            case "asset":
                assert(_asset && is_string(_value[$ "name"]??undefined),"Unexpected checkpoint asset field");
                var _index=asset_get_index(_value.name);
                assert(_index>=0,"Frontier checkpoint asset is unavailable: "+_value.name);
                assert(scrFRContinueAssetName(_index,_asset_kind)==_value.name,
                    "Frontier checkpoint asset family mismatch: "+_value.name);
                return _index;
            default:throw "Unknown Frontier checkpoint value type";
        }
    }
    assert(is_numeric(_value) || is_string(_value) || is_bool(_value),"Invalid Frontier checkpoint scalar");
    assert(!_asset || !is_numeric(_value) || _value<0,"Frontier checkpoint cannot contain a raw asset handle");
    return _value;
}

// Lightweight source weapons own charge/combo data separately from native
// numeric weapon IDs. Their source structs contain data only; sprite/object
// handles and custom weapon IDs are stored by declaration name.
function scrFRContinueWeaponEncode(_value,_field="",_depth=0) {
    assert(_depth<16,"Frontier source weapon checkpoint contains excessive nesting");
    assert(!is_method(_value),"Frontier source weapon checkpoint cannot contain code");
    if(is_struct(_value)) {
        var _fields=variable_struct_get_names(_value),_record={};
        for(var _i=0;_i<array_length(_fields);++_i)
            _record[$ _fields[_i]]=scrFRContinueWeaponEncode(_value[$ _fields[_i]],_fields[_i],_depth+1);
        return {fr_type:"sourceWeaponRecord",fields:_record};
    }
    if(is_array(_value)) {
        var _array=[];
        for(var _i=0;_i<array_length(_value);++_i) array_push(_array,scrFRContinueWeaponEncode(_value[_i],_field,_depth+1));
        return _array;
    }
    if(_field=="wep" && is_numeric(_value)) {
        var _key=global.fr_weapon_keys[$ string(_value)];
        if(!is_undefined(_key)) return {fr_type:"sourceWeaponId",name:_key};
    }
    // Wormhole's spriteIndex is its 1..5 ammo/variant array index, not a
    // sprite resource. Only actual resource-bearing fields receive names.
    var _asset=(_field=="sprt")
        || (_field=="wormholeSpawnObject" && is_numeric(_value) && object_exists(_value));
    return scrFRContinueEncode(_value,_asset,_depth,_field=="wormholeSpawnObject"?"object":"sprite");
}

function scrFRContinueWeaponDecode(_value,_field="",_depth=0) {
    assert(_depth<16,"Frontier source weapon checkpoint contains excessive nesting");
    if(is_array(_value)) {
        var _array=[];
        for(var _i=0;_i<array_length(_value);++_i) array_push(_array,scrFRContinueWeaponDecode(_value[_i],_field,_depth+1));
        return _array;
    }
    if(is_struct(_value)) {
        var _type=_value[$ "fr_type"]??"";
        if(_type=="sourceWeaponRecord") {
            var _fields=_value.fields,_keys=variable_struct_get_names(_fields),_record={};
            for(var _i=0;_i<array_length(_keys);++_i)
                _record[$ _keys[_i]]=scrFRContinueWeaponDecode(_fields[$ _keys[_i]],_keys[_i],_depth+1);
            return _record;
        }
        if(_type=="sourceWeaponId") {
            var _key=_value.name;
            if(string_pos("weapon:",_key)==1) _key=string_delete(_key,1,7);
            return scrFRWeaponResolve(_key);
        }
    }
    return scrFRContinueDecode(_value,_field=="sprt"
        || (is_struct(_value) && (_value[$ "fr_type"]??"")=="asset"),_depth,
        _field=="wormholeSpawnObject"?"object":"sprite");
}

function scrFRContinuePlayerWeaponsExport() {
    var _fields=["fr_source_wep","fr_source_bwep"],_slots=[];
    for(var _i=0;_i<array_length(_fields);++_i)
        array_push(_slots,scrFRContinueWeaponEncode(scrNTTEFullValue(id,_fields[_i],undefined)));
    return {schema:1,slots:_slots};
}

function scrFRContinueNativeStateRecord(_state,_decode) {
    if(!is_struct(_state) || !variable_struct_exists(_state,"fr_source_weapon")) return _state;
    var _copy={},_keys=variable_struct_get_names(_state);
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_value=_state[$ _key];
        if(_key=="fr_source_weapon")
            _value=_decode ? scrFRContinueWeaponDecode(_value):scrFRContinueWeaponEncode(_value);
        _copy[$ _key]=_value;
    }
    return _copy;
}

function scrFRContinuePlayerNativeState(_field,_value,_decode) {
    if(_field=="ntte_state" || _field=="bntte_state") return scrFRContinueNativeStateRecord(_value,_decode);
    if(_field=="ntte_extra_states" && is_array(_value)) {
        var _copy=[];
        for(var _i=0;_i<array_length(_value);++_i) array_push(_copy,scrFRContinueNativeStateRecord(_value[_i],_decode));
        return _copy;
    }
    return _value;
}

function scrFRContinuePlayerWeaponsImport() {
    // The native charge controller is a disposable actor. A cold process may
    // reuse its old numeric ID for an unrelated actor; rebuild from slot data.
    fr_charge_controller=noone;fr_charge_native_input=false;
    var _saved=scrNTTEFullValue(id,"fr_source_weapon_save",undefined);
    var _fields=["fr_source_wep","fr_source_bwep"],_states=["ntte_state","bntte_state"],_imported=false;
    for(var _i=0;_i<array_length(_fields);++_i) {
        var _state=scrNTTEFullValue(id,_states[_i],undefined);
        if(is_struct(_state) && variable_struct_exists(_state,"fr_source_weapon")) {
            variable_instance_set(id,_fields[_i],_state.fr_source_weapon);_imported=true;
        } else if(is_struct(_saved) && (_saved[$ "schema"]??0)==1) {
            variable_instance_set(id,_fields[_i],scrFRContinueWeaponDecode(_saved.slots[_i]));_imported=true;
        }
    }
    return _imported;
}

function scrFRContinueMergedWeaponsRestore(_objects) {
    // The native graph first reconstructs all aliases. Decode only the source
    // weapon leaf; leave NTTE's existing merged models and native states intact.
    for(var _i=0;_i<array_length(_objects);++_i) {
        var _object=_objects[_i];
        if(!is_struct(_object) || !variable_struct_exists(_object,"fr_source_weapon")) continue;
        var _source=_object.fr_source_weapon;
        if(is_struct(_source) && (_source[$ "fr_type"]??"")=="sourceWeaponRecord")
            _object.fr_source_weapon=scrFRContinueWeaponDecode(_source);
    }
}

function scrFRContinueModuleExport(_spec,_asset=false) {
    var _out={};
    for(var _i=0;_i<array_length(_spec);++_i) {
        var _key=_spec[_i][0],_fields=_spec[_i][1];
        if(!variable_struct_exists(global.fr_module_vars,_key)) continue;
        var _vars=global.fr_module_vars[$ _key],_record={};
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j];
            if(variable_struct_exists(_vars,_field)) _record[$ _field]=scrFRContinueEncode(_vars[$ _field],_asset);
        }
        _out[$ _key]=_record;
    }
    return _out;
}

function scrFRContinueModuleImport(_saved,_spec,_asset=false) {
    if(!is_struct(_saved)) return;
    for(var _i=0;_i<array_length(_spec);++_i) {
        var _key=_spec[_i][0],_fields=_spec[_i][1];
        if(!variable_struct_exists(global.fr_module_vars,_key)) continue;
        var _record=_saved[$ _key];
        if(!is_struct(_record)) continue;
        var _vars=global.fr_module_vars[$ _key];
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j];
            if(variable_struct_exists(_record,_field)) _vars[$ _field]=scrFRContinueDecode(_record[$ _field],_asset);
        }
    }
}

function scrFRContinuePoolExport() {
    var _out=[],_keys=variable_struct_get_names(global.fr_skill_pool);
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _number=real(_keys[_i]),_key=scrFRSkillKey(_number);
        array_push(_out,[is_undefined(_key)?_number:_key,global.fr_skill_pool[$ _keys[_i]]]);
    }
    return _out;
}

function scrFRContinuePoolImport(_pool) {
    global.fr_skill_pool={};
    if(!is_array(_pool)) return;
    for(var _i=0;_i<array_length(_pool);++_i) {
        var _entry=_pool[_i];
        assert(is_array(_entry) && array_length(_entry)==2,"Invalid Frontier checkpoint skill pool");
        scrFRSkillSetActive(_entry[0],_entry[1]);
    }
}

function scrFRContinueEventsExport() {
    var _out=[];
    with(FRCustomObject) if(name=="Event") {
        if(variable_instance_exists(id,"mod_type") && variable_instance_exists(id,"mod_name") && variable_instance_exists(id,"event"))
            array_push(_out,[mod_type,mod_name,event]);
    }
    return _out;
}

function scrFRContinueExport() {
    if(!scrFREnabled() || !instance_exists(GameCont)) return undefined;
    var _cache=[],_list=scrFRModGet("mod","Frontier_Pickups","deeplabsCacheWeps");
    if(is_numeric(_list) && ds_exists(_list,ds_type_list))
        for(var _i=0;_i<ds_list_size(_list);++_i) array_push(_cache,scrFRContinueEncode(_list[| _i]));
    return {schema:1,modules:scrFRContinueModuleExport(scrFRContinueFields()),
        assets:scrFRContinueModuleExport(scrFRContinueAssetFields(),true),
        cache:_cache,pool:scrFRContinuePoolExport(),events:scrFRContinueEventsExport(),
        generation:scrNTTEFullValue(GameCont,"fr_continue_generation_entry",scrFRContinueModuleExport(scrFRContinueGenerationFields()))};
}

function scrFRContinueDestroyList(_kind,_module,_field) {
    var _old=scrFRModGet(_kind,_module,_field);
    if(is_numeric(_old) && ds_exists(_old,ds_type_list)) ds_list_destroy(_old);
}

function scrFRContinueRebuild() {
    var _seed=random_get_seed(),_streams=json_stringify(global.rng_state);
    try {
        // These authored registries normally initialize in game_start. They
        // contain code/object/assets, so rebuild them from declarations.
        scrFRContinueDestroyList("area","deeplabs","tubeObjectName");
        scrFRContinueDestroyList("area","deeplabs","tubeObjectVars");
        scrFRModCallArray("area","deeplabs","BigTubeObjects_init",[]);
        scrFRModCallArray("area","cyberspace","Processor_compat_additions",[]);
        var _lists=["typelessWormholeList","bulletWormholeList","shellWormholeList","boltWormholeList","explosiveWormholeList","energyWormholeList"];
        for(var _i=0;_i<array_length(_lists);++_i) scrFRContinueDestroyList("weapon","FR_Wormhole",_lists[_i]);
        scrFRModCallArray("weapon","FR_Wormhole","WormholeList_init",[]);
        scrFRModCallArray("mod","Frontier_Main","altareas_import_frontier",[]);
        scrFRModCallArray("mod","Frontier_Main","detailsPlus_import_frontier",[]);
        scrFRModCallArray("mod","Frontier_IDPD","customIDPD_import",[]);
        scrFRModSet("area","robocenter","arenaGened",false);
        // All pending gameplay coroutines belonged to the discarded room.
        // Keeping one can let an old event cleanup alter the resumed music.
        global.fr_tasks=[];
    } finally {random_set_seed(_seed);global.rng_state=json_parse(_streams);}
}

function scrFRContinueStatuses() {
    var _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects");
    for(var _i=0;_i<array_length(_effects);++_i) {
        var _effect=_effects[_i],_targets=[];
        with(Player) if(variable_instance_exists(id,_effect.key) && variable_instance_get(id,_effect.key)>0)
            array_push(_targets,id);
        _effect.targets=_targets;
    }
}

function scrFRContinuePlayerGenerationState() {
    // Native Player JSON already persists these numeric delta arrays. Keep
    // them across source level_start too, without freezing Fish/Back Muscle's
    // shared typ_amax/typ_ammo baseline in a second saved table.
    var _saved=[],_fields=["bubbles_bubbleCharge","bubbles_bubbleCooldown","fr_source_wep","fr_source_bwep",
        "fr_ammo_max_delta","fr_ammo_gain_delta"];
    with(Player) {
        var _values={};
        for(var _i=0;_i<array_length(_fields);++_i)
            if(variable_instance_exists(id,_fields[_i]))
                _values[$ _fields[_i]]=scrFRContinueWeaponEncode(variable_instance_get(id,_fields[_i]));
        array_push(_saved,{index:index,fields:_values});
    }
    return _saved;
}

function scrFRContinuePlayerGenerationRestore(_saved) {
    if(!is_array(_saved)) return;
    for(var _i=0;_i<array_length(_saved);++_i) {
        var _entry=_saved[_i],_player=scrFRPlayerFind(_entry.index),_fields=variable_struct_get_names(_entry.fields);
        if(!instance_exists(_player)) continue;
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j],_value=scrFRContinueWeaponDecode(_entry.fields[$ _field]);
            if(_field=="fr_source_wep" || _field=="fr_source_bwep") {
                // Native physical slot state owns this record. Restore one
                // decoded instance there and rebuild Player's aliases below;
                // a detached Player-only copy is discarded by the next sync.
                var _slot=_field=="fr_source_wep"?"wep":"bwep",
                    _physical=scrFRWeaponSlotPhysical(_player,_slot,false);
                if(is_struct(_value) && is_struct(_physical)
                    && _physical.weapon==scrFRWeaponRaw(_value))
                    _physical.fr_source_weapon=_value;
                continue;
            }
            variable_instance_set(_player,_field,_value);
        }
        // Only adopt an already-existing matching slot; generation is never
        // allowed to create a saved weapon or flatten a native fusion tree.
        scrFRWeaponSlotsSync(_player);
    }
}

function scrFRContinueImport(_saved) {
    // Missing schema is an ordinary pre-2.0 NTTE save. Let the source's first
    // game_start create its new state without changing native saved progress.
    if(!scrFREnabled() || !instance_exists(GameCont) || !is_struct(_saved) || (_saved[$ "schema"]??0)!=1) return false;
    scrFRContinueRebuild();
    scrFRContinueModuleImport(_saved[$ "modules"],scrFRContinueFields());
    scrFRContinueModuleImport(_saved[$ "assets"],scrFRContinueAssetFields(),true);
    var _cache=_saved[$ "cache"],_list=scrFRModGet("mod","Frontier_Pickups","deeplabsCacheWeps");
    if(is_array(_cache)) {
        ds_list_clear(_list);
        for(var _i=0;_i<array_length(_cache);++_i) ds_list_add(_list,scrFRContinueDecode(_cache[_i]));
    }
    scrFRContinuePoolImport(_saved[$ "pool"]);
    scrFRContinueStatuses();
    // Cyberspace setup must record the original Robot skin again rather than
    // treating the saved cyberspace skin as its restoration target.
    if(GameCont.area==scrFRAreaResolve("cyberspace")) {
        var _vars=global.fr_module_vars[$ "area:cyberspace"],_from=["prevIdle","prevWalk","prevHurt","prevDead"],_to=["spr_idle","spr_walk","spr_hurt","spr_dead"];
        with(Player) if(race=="robot" || race==Race.Robot) {
            for(var _i=0;_i<array_length(_from);++_i) {
                var _array=_vars[$ _from[_i]];
                if(is_array(_array) && index<array_length(_array) && !is_undefined(_array[index])) variable_instance_set(id,_to[_i],_array[index]);
            }
        }
    }
    global.fr_continue_events={game:GameCont.id,events:_saved[$ "events"]??[]};
    global.fr_continue_adopted_game=GameCont.id;
    global.fr_continue_generation={game:GameCont.id,entry:_saved[$ "generation"],exit:_saved[$ "modules"],
        players:scrFRContinuePlayerGenerationState()};
    if(instance_exists(FRWorld)) FRWorld.fr_previous_game=GameCont.id;
    with(UberCont) {scrFRWeaponsRefresh();scrFRSkillsInit();}
    return true;
}

function scrFRContinueAdoptGame() {
    return instance_exists(GameCont) && variable_global_exists("fr_continue_adopted_game")
        && global.fr_continue_adopted_game==GameCont.id;
}

function scrFRContinueGenerationBegin(_sync=false) {
    if(!scrFREnabled() || !instance_exists(GameCont)) return;
    if(!_sync && variable_global_exists("ntte_full_sync_generation") && global.ntte_full_sync_generation) return;
    if(variable_global_exists("fr_continue_generation") && is_struct(global.fr_continue_generation)
        && global.fr_continue_generation.game==GameCont.id)
        scrFRContinueModuleImport(global.fr_continue_generation.entry,scrFRContinueGenerationFields());
    GameCont.fr_continue_generation_entry=scrFRContinueModuleExport(scrFRContinueGenerationFields());
}

function scrFRContinueGenerationEnd() {
    if(!scrFREnabled() || !instance_exists(GameCont) || !variable_global_exists("fr_continue_generation")) return;
    if(scrNTTEFullValue(id,"ntte_full_set_area",true)==false) return;
    // A checkpoint resumes after authored level_start has rebuilt its actors.
    // Never consume it early and then let Bubbles/weapon hooks reset the data.
    if(!scrNTTEFullValue(id,"fr_source_level_started",false)) return;
    var _pending=global.fr_continue_generation;
    global.fr_continue_generation=undefined;
    if(is_struct(_pending) && _pending.game==GameCont.id) {
        scrFRContinueModuleImport(_pending.exit,scrFRContinueGenerationFields());
        // This is the saved room, not a newly entered area. Normal authored
        // level_start still rebuilds its actors, then checkpoint abilities
        // and source weapon charge resume from the loaded Player state.
        scrFRContinuePlayerGenerationRestore(_pending.players);
    }
}

function scrFRContinueEventsRestore() {
    if(!variable_global_exists("fr_continue_events") || !is_struct(global.fr_continue_events)) return false;
    if(!instance_exists(GameCont) || global.fr_continue_events.game!=GameCont.id) {global.fr_continue_events=undefined;return false;}
    if(!instance_exists(GenCont)) return false;
    var _events=global.fr_continue_events.events;
    global.fr_continue_events=undefined;
    assert(is_array(_events),"Invalid Frontier checkpoint events");
    var _credits=scrFRModGet("mod","Frontier_Events","nightCredits");
    try {
        for(var _i=0;_i<array_length(_events);++_i) {
            var _entry=_events[_i];
            assert(is_array(_entry) && array_length(_entry)==3,"Invalid Frontier checkpoint event reference");
            for(var _j=0;_j<3;++_j) assert(is_string(_entry[_j]),"Checkpoint event references must be symbolic");
            assert(scrFRModLoaded(_entry[0],_entry[1]),"Saved Frontier event module unavailable");
            scrFRModCallArray("mod","libEvents","event_set_active",[_entry[0],_entry[1],_entry[2],true]);
        }
    } finally {scrFRModSet("mod","Frontier_Events","nightCredits",_credits);}
    return true;
}

function scrFRContinueWormholeTests() {
    var _p=instance_find(Player,0),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _seed=random_get_seed(),_streams=scrFRArrayClone(global.rng_state),_orders=[],
        _lists=["typelessWormholeList","bulletWormholeList","shellWormholeList","boltWormholeList","explosiveWormholeList","energyWormholeList"],
        _raw=scrFRWeaponResolve("FR_Wormhole"),_seen=0;
    assert(instance_exists(_p),"Real Wormhole checkpoint fixture needs the native Player");
    for(var _i=0;_i<array_length(_lists);++_i) {
        var _list=scrFRModGet("weapon","FR_Wormhole",_lists[_i]);
        assert(ds_exists(_list,ds_type_list),"Real Wormhole projectile registry was not initialized");
        array_push(_orders,{list:_list,values:scrFRListToArray(_list)});
    }
    try {
        with(_p) {
            wep=_raw;bwep=wep_none;
            ntte_state=scrNTTENewState(_raw);bntte_state=undefined;
            fr_source_wep=undefined;fr_source_bwep=undefined;
            scrFRWeaponPrepare(_raw,true);
        }
        var _state=scrFRWeaponSlotRead(_p,"wep");
        assert(is_struct(_state),"Actual Wormhole lwo_initialize did not create its native source record");
        for(var _variant=0;_variant<5;++_variant) {
            var _index=_state.spriteIndex;
            assert(is_numeric(_index) && _index>=1 && _index<=5 && _index==_state.wormholeType,
                "Authored Wormhole spriteIndex is not its ammo/variant array index");
            _seen|=1<<(_index-1);
            var _encoded=scrFRContinueWeaponEncode(_state);
            assert(is_numeric(_encoded.fields.spriteIndex) && _encoded.fields.spriteIndex==_index,
                "Wormhole checkpoint replaced a plain variant index with an unrelated sprite asset");
            var _restored=scrFRContinueWeaponDecode(json_parse(json_stringify(_encoded))),
                _sprites=scrFRModGet("weapon","FR_Wormhole","sprWeapon"),
                _art=scrFRModCallArray("weapon","FR_Wormhole","weapon_sprt",[_restored]);
            assert(_restored.spriteIndex==_index && _restored.wormholeType==_state.wormholeType
                && _restored.ammoCost==_state.ammoCost && _art==_sprites[_index]
                && _restored.wormholeSpawnObject==_state.wormholeSpawnObject,
                "Actual Wormhole source variant, cost, projectile or artwork changed through native JSON");
            with(_p) scrFRModCallArray("weapon","FR_Wormhole","wormhole_next_projectile",[_state,true]);
        }
        assert(_seen==31,"Real Wormhole checkpoint fixture missed an authored ammo/variant index");
        scrNTTESmokeLog("PASS FRONTIER actual Wormhole lwo_initialize + five source ammo/variant advances + native JSON + source artwork/projectile identity");
    } finally {
        for(var _i=0;_i<array_length(_orders);++_i) {
            var _entry=_orders[_i];ds_list_clear(_entry.list);scrFRListAddArray(_entry.list,_entry.values);
        }
        scrNTTEFullAreaGeneratorRestore(_players);
        random_set_seed(_seed);global.rng_state=_streams;
    }
}

function scrFRContinueTests() {
    assert(scrFREnabled() && instance_exists(GameCont),"Frontier continue tests require a live isolated run");
    var _saved=scrFRContinueExport(),_encoded=json_parse(json_stringify(_saved));
    assert(_encoded.schema==1,"Frontier checkpoint schema must survive native JSON");
    var _vars=global.fr_module_vars[$ "skill:SurgerySlot"],_before=_vars.statLoseType;
    try {
        _vars.statLoseType=["maxhealth",1,4,1,infinity];
        var _sample=scrFRContinueModuleExport(scrFRContinueFields());
        _vars.statLoseType=[];
        scrFRContinueModuleImport(json_parse(json_stringify(_sample)),scrFRContinueFields());
        assert(array_length(_vars.statLoseType)==5 && _vars.statLoseType[4]>power(10,300),"Surgery infinity bound lost during JSON");
        var _assets=scrFRContinueModuleExport(scrFRContinueAssetFields(),true);
        scrFRContinueModuleImport(json_parse(json_stringify(_assets)),scrFRContinueAssetFields(),true);
        var _sprite_asset=scrFRContinueEncode(sprSkillIconHUD,true),
            _object_asset=scrFRContinueEncode(FRCustomProjectile,true,0,"object");
        assert(_sprite_asset.name==sprite_get_name(sprSkillIconHUD)
            && _object_asset.name==object_get_name(FRCustomProjectile)
            && scrFRContinueDecode(json_parse(json_stringify(_sprite_asset)),true)==sprSkillIconHUD
            && scrFRContinueDecode(json_parse(json_stringify(_object_asset)),true,0,"object")==FRCustomProjectile,
            "Explicit sprite/object checkpoint resource names did not roundtrip through native JSON");
        var _rejected_wrong_family=false;
        try {scrFRContinueDecode(_object_asset,true);} catch(_expected_family_error) {_rejected_wrong_family=true;}
        assert(_rejected_wrong_family,"Checkpoint decoder accepted an object in a sprite field");
        var _weapons=variable_struct_get_names(global.fr_weapon_keys),_weapon=real(_weapons[0]),
            _lwo={wep:_weapon,chrg:17,primary:true,sprt:scr_weapon_get_sprite(_weapon),
                nested:{wormholeSpawnObject:FRCustomProjectile,spriteIndex:4}},
            _restored=scrFRContinueWeaponDecode(json_parse(json_stringify(scrFRContinueWeaponEncode(_lwo))));
        assert(_restored.wep==_weapon && _restored.chrg==17 && _restored.primary
            && _restored.sprt==_lwo.sprt && _restored.nested.wormholeSpawnObject==FRCustomProjectile
            && _restored.nested.spriteIndex==4,"Source lightweight weapon charge/artwork/object/variant identity lost during native JSON");
        var _native_state={weapon:_weapon,ammo:11,charge:3,fr_source_weapon:_lwo},
            _native_encoded=scrFRContinuePlayerNativeState("ntte_state",_native_state,false),
            _native_decoded=scrFRContinuePlayerNativeState("ntte_state",json_parse(json_stringify(_native_encoded)),true);
        assert(_native_encoded.fr_source_weapon.fr_type=="sourceWeaponRecord"
            && _native_state.fr_source_weapon==_lwo && _native_state.fr_source_weapon.sprt==_lwo.sprt
            && _native_decoded.weapon==_weapon && _native_decoded.ammo==11 && _native_decoded.charge==3
            && _native_decoded.fr_source_weapon.sprt==_lwo.sprt,
            "Native raw physical slot failed symbolic source-leaf roundtrip or mutated the live source weapon");
        assert(!scrFRContinueImport(undefined),"Old NTTE saves must remain readable without a Frontier payload");
        scrFRContinueWormholeTests();
    } finally {_vars.statLoseType=_before;}
    return {schema:1,module_count:array_length(scrFRContinueFields()),asset_module_count:array_length(scrFRContinueAssetFields()),status:"codec-passed"};
}
