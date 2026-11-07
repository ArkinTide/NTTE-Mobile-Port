// Frontier's source callbacks own topology, encounters and presentation.
// Native GenCont owns wall finalization, collision, player spawn and saves.
function scrFRRegisterAreas() {
    var _names=["cove","cyberspace","deeplabs","devzone","graveyard","robocenter"];
    for(var _i=0;_i<array_length(_names);++_i) {
        var _key="area:"+_names[_i],_area=301+_i;
        global.fr_area_ids[$ _key]=_area;
        global.fr_area_ids[$ _names[_i]]=_area;
        global.fr_area_keys[$ string(_area)]=_names[_i];
        scrNTTEFullAreaGeneratorRegister(_area,scrFRAreaBuild,scrFRAreaPopulate,scrFRAreaStart,scrFRAreaSetup);
    }
}
function scrFRAreaTryResolve(_area) {
    if(!is_string(_area) || _area=="") return _area;
    var _name=_area;
    if(string_pos("area:",_name)==1) _name=string_delete(_name,1,5);
    if(variable_global_exists("fr_area_ids")) {
        if(variable_struct_exists(global.fr_area_ids,_area)) return global.fr_area_ids[$ _area];
        if(variable_struct_exists(global.fr_area_ids,_name)) return global.fr_area_ids[$ _name];
    }
    switch(_name) {
        case "campfire":return area_campfire;
        case "desert":return area_desert;
        case "sewers":return area_sewers;
        case "scrapyard":case "scrapyards":return area_scrapyards;
        case "caves":return area_caves;
        case "city":return area_city;
        case "labs":return area_labs;
        case "palace":return area_palace;
        case "vault":return area_vault;
        case "mansion":return area_mansion;
        case "cursed caves":case "cursed_caves":return area_cursed_caves;
        case "jungle":return area_jungle;
        case "hq":return area_hq;
        case "crib":return area_crib;
        case "pizza sewers":case "pizza_sewers":return area_pizza_sewers;
        case "coast":return 201;
        case "oasis":return 202;
        case "pizza":return 203;
        case "lair":return 204;
        case "trench":return 205;
        case "red":return 206;
        case "undergrowth":return 207;
    }
    return undefined;
}
function scrFRAreaResolve(_area) {
    var _resolved=scrFRAreaTryResolve(_area);
    if(is_undefined(_resolved)) throw "Unknown Frontier area: "+string(_area);
    return _resolved;
}
function scrFRSourceAreaIsString(_area) {
    // Custom NTT areas are strings. Native save IDs retain that source type
    // at explicit area type checks, without changing ordinary number tests.
    if(is_string(_area)) return true;
    return is_real(_area) && ((_area>=201 && _area<=207) || (_area>=301 && _area<=306));
}
function scrFRSourceAreaIsReal(_area) {
    return is_real(_area) && !scrFRSourceAreaIsString(_area);
}
function scrFRAreaKey(_area) {
    if(is_string(_area)) {
        if(string_pos("area:",_area)==1) _area=string_delete(_area,1,5);
        switch(_area) {case "cove":case "cyberspace":case "deeplabs":case "devzone":case "graveyard":case "robocenter":return _area;}
    }
    if(variable_global_exists("fr_area_keys") && variable_struct_exists(global.fr_area_keys,string(_area)))
        return global.fr_area_keys[$ string(_area)];
    return "";
}
function scrFRAreaActive(_area) {
    if(!scrFREnabled()) return false;
    var _name=scrFRAreaKey(_area);
    return _name!="" && scrFRScriptExists("area",_name,"area_make_floor");
}
function scrFRAreaPortalBlocked() {
    if(!scrFREnabled()) return false;
    // Bulwark's authored death is a 90-tick CustomObject, followed by a
    // zero-health CustomEnemy whose real native corpse supplies the exit.
    // The host's no-corpse recovery must not clear the room in that gap.
    var _blocked=false;
    with(FRCustomObject) if(name=="fr_RoboBossDeath") {_blocked=true;break;}
    return _blocked;
}
function scrFRAreaCall(_area,_callback,_args=[]) {
    var _name=scrFRAreaKey(_area);
    if(_name=="") throw "Frontier area callback requested for a foreign area: "+string(_area);
    return scrFRModCallArray("area",_name,_callback,_args);
}
function scrFRAreaMetadata(_area,_callback,_fallback) {
    var _value=scrFRAreaCall(_area,_callback);
    return is_undefined(_value) ? _fallback:_value;
}
function scrFRAreaInfo(_area) {
    var _key=scrFRAreaKey(_area);
    if(!scrFRAreaActive(_area)) return undefined;
    // Menu/console callers ask for static metadata before a run exists.
    // Cyberspace's authored exit reads GameCont.lastarea and only has a
    // meaningful destination during a live run; resolve that callback then.
    var _id=scrFRAreaResolve(_key),_next=instance_exists(GameCont)
            ? scrFRAreaMetadata(_id,"area_next",[area_desert,1]):[area_desert,1],
        _music=scrFRAreaMusicInfo(_id);
    return {key:_key,area_id:_id,subareas:scrFRAreaMetadata(_id,"area_subarea",1),
        goal:scrFRAreaMetadata(_id,"area_goal",110),next_area:scrFRAreaResolve(_next[0]),next_subarea:_next[1],
        background:scrFRAreaMetadata(_id,"area_background_color",c_black),
        shadow:scrFRAreaMetadata(_id,"area_shadow_color",c_black),ambient:_music[1],music:_music[0],music_b:_music[0],boss_music:"",boss_intro:""};
}
function scrFRAreaMusicInfo(_area) {
    var _key=scrFRAreaKey(_area),_vars=global.fr_module_vars[$ "area:"+_key];
    switch(_key) {
        case "cove":return [_vars.musCove,amb7];
        case "cyberspace":return [_vars.sndBlank,_vars.ambCyberspace];
        case "deeplabs":return [_vars.sndBlank,_vars.ambDeeplabs];
        case "devzone":return [mus3b,amb6];
        case "graveyard":return [instance_exists(GameCont) && GameCont.proto ? _vars.musGraveyardB:_vars.musGraveyard,amb5];
        case "robocenter":return [_vars.musRobocenter,_vars.ambRobocenter];
    }
    throw "Frontier area music is not mapped: "+_key;
}
function scrFRAreaMusic() {
    if(!instance_exists(GameCont) || !scrFRAreaActive(GameCont.area)) return false;
    // area_setup already selected the source track. Only restore it when a
    // continuation has no live audio; preserve custom encounter music.
    var _info=scrFRAreaMusicInfo(GameCont.area);
    if(oldarea!=GameCont.area || !audio_is_playing(song)) {
        scrNTTEFullMusicStart(_info[0]);oldarea=GameCont.area;
    }
    if(audio_exists(_info[1]) && (amb!=_info[1] || !audio_is_playing(amb))) {
        if(audio_exists(amb)) audio_stop_sound(amb);
        amb=_info[1];snd_play_ambience(amb,true);
    }
    return true;
}
function scrFRAreaSetup() {
    var _area=GameCont.area;
    scrFRAreaCall(_area,"area_setup");
    background_set_colour(scrFRAreaMetadata(_area,"area_background_color",c_black));
    with(BackCont) shadow_color=scrFRAreaMetadata(_area,"area_shadow_color",c_black);
    if(scrFRAreaMetadata(_area,"area_darkness",false)) scrNTTEFullAreaDarknessNative();
    with(MusCont) oldarea=_area;
}
function scrFRAreaBuild() {
    var _area=GameCont.area,_generation=id;
    if(!scrFRAreaActive(_area)) throw "Frontier builder called before its offline modules were initialized";
    if(!instance_exists(FloorMaker)) instance_create(10000,10000,FloorMaker);
    with(FloorMaker) goal=_generation.goal;
    var _budget=65536,_stalled=2048,_last=instance_number(Floor);
    while(instance_exists(FloorMaker) && _budget-->0 && _stalled-->0) {
        var _makers=scrFRInstances(FloorMaker);
        for(var _i=0;_i<array_length(_makers);++_i) if(instance_exists(_makers[_i])) with(_makers[_i]) {
            xprevious=x;yprevious=y;
            if(instance_number(Floor)>goal) {
                if(point_distance(x,y,10016,10016)>48) {
                    instance_create(x,y,Floor);
                    if(!instance_exists(MenuGen)) instance_create(x+16,y+16,RadChest);
                }
                instance_destroy();
            } else {
                x+=lengthdir_x(32,direction);y+=lengthdir_y(32,direction);
                scrFRAreaCall(_area,"area_make_floor");
            }
        }
        if(instance_number(Floor)>_last) {_last=instance_number(Floor);_stalled=2048;}
    }
    if(instance_exists(FloorMaker)) throw "Frontier source area generation did not converge: "+scrFRAreaKey(_area);
    if(!instance_exists(Floor)) throw "Frontier source area generated no traversable terrain: "+scrFRAreaKey(_area);
}
function scrFRAreaPopulate() {
    scrPopulate();
    scrFRAreaCall(GameCont.area,"area_pop_extras");
}
function scrFRAreaStart() {scrFRAreaCall(GameCont.area,"area_start");}

function scrFRGenerationMetadataSetup() {
    if(!scrFREnabled() || (self[$ "fr_generation_metadata_ready"]??false)) return;
    // NTT exposes the original spawn and enemy exclusion radius on GenCont.
    // Native GenCont.Create places players at 10016,10016 and scrPopulate
    // uses 120 for that same exclusion. Publish that real generation contract
    // before authored area_setup/event_setup, rather than manufacturing state
    // in individual event controllers or only in continuation fixtures.
    spawn_x=10016;
    spawn_y=10016;
    safedist=120;
    fr_generation_metadata_ready=true;
}
function scrFRGenerationEventsSkip() {
    return instance_exists(GenCont) && scrNTTEFullValue(GenCont,"fr_event_setup_complete",false);
}
function scrFRGenerationEventsSetup() {
    if(!scrFREnabled() || (self[$ "fr_event_setup_complete"]??false)) return;
    assert(self[$ "fr_generation_metadata_ready"]??false,
        "Frontier event setup preceded native generation metadata");
    // A synchronous generator can finish inside one native call, before
    // Lib's next binding tick sees it. Dispatch only event setup here after
    // area_setup has supplied goal/spawn metadata and before terrain builds.
    var _generator=real(id);
    with(GameCont) scrFRModCallArray("mod","libEvents","update",[_generator-1,_generator]);
    fr_event_setup_complete=true;
}
function scrFRLibLevelStart() {
    // Lib opts hooks in through getRef. Dispatch that exact subscription list:
    // campfire and wibbly own independent generation-edge handlers and must
    // not also receive a broadcast, while Bubbles subscribes as a race.
    var _lib=scrFRLibGlobal();
    if(!instance_exists(_lib)) return;
    var _hooks=_lib.activeHooks;
    for(var _i=0;_i<array_length(_hooks);++_i) {
        var _hook=_hooks[_i],_kind=_hook[0],_module=_hook[1];
        if(!scrFRScriptExists(_kind,_module,"level_start")) continue;
        switch(_kind) {
            case "skill":
                with(GameCont) if(scrFRGetSkill(_module)>0)
                    scrFRModCallArray(_kind,_module,"level_start",[]);
                break;
            case "race":
                var _race=scrFRRaceResolve(_module);
                with(Player) if(race==_race)
                    scrFRModCallArray(_kind,_module,"level_start",[]);
                break;
            case "wep":case "weapon":
                var _weapon=scrFRWeaponResolve(_module);
                with(Player) {
                    var _primary=is_struct(wep)?wep.wep:wep,
                        _secondary=is_struct(bwep)?bwep.wep:bwep;
                    if(_primary==_weapon) scrFRModCallArray(_kind,_module,"level_start",[1]);
                    if(_secondary==_weapon) scrFRModCallArray(_kind,_module,"level_start",[0]);
                }
                break;
            default:
                with(GameCont) scrFRModCallArray(_kind,_module,"level_start",[]);
                break;
        }
    }
    global.fr_module_vars[$ "mod:lib"].level_loading=false;
    _lib.level_loading=false;
}
function scrFRGenerationLevelStart() {
    if(!scrFREnabled() || (self[$ "fr_source_level_started"]??false)
        || scrNTTEFullValue(id,"ntte_full_set_area",true)==false) return;
    fr_source_level_started=true;
    // The original Lib level_start dispatch is a branch inside lib::step,
    // not a standalone function. Run its subscribed gameplay hooks while the
    // real room is finalized, then disarm that branch for the next tick.
    scrFRLibLevelStart();
    global.fr_module_vars[$ "mod:lib"].level_loading=false;
    var _lib=scrFRLibGlobal();
    if(instance_exists(_lib)) _lib.level_loading=false;
}
function scrFRAreaPopEnemies(_area) {
    if(!scrFRAreaActive(_area)) return false;
    scrFRAreaCall(_area,"area_pop_enemies");
    return true;
}
function scrFRAreaPopProps(_area) {
    if(!scrFRAreaActive(_area)) return false;
    scrFRAreaCall(_area,"area_pop_props");
    return true;
}
function scrFRAreaSprite(_area,_source) {
    if(!scrFRAreaActive(_area)) return undefined;
    var _field="";
    switch(_source) {
        case sprFloor1:_field="sprFloor";break;
        case sprFloor1B:_field="sprFloorB";break;
        case sprFloor1Explo:_field="sprFloorExplo";break;
        case sprWall1Top:_field="sprWallTop";break;
        case sprWall1Bot:_field="sprWallBot";break;
        case sprWall1Out:_field="sprWallOut";break;
        case sprWall1Trans:_field="sprWallTrans";break;
        case sprDebris1:_field="sprDebris";break;
        case sprDetail1:_field="sprDetail";break;
        case sprTopPot:_field="sprTopDecal";break;
    }
    if(_field=="") return _source;
    var _vars=global.fr_module_vars[$ "area:"+scrFRAreaKey(_area)];
    // Top decorations are optional. Source areas that do not replace this
    // sprite retain the base prop, as NTT's area_sprite chain does.
    if(_field=="sprTopDecal" && !variable_struct_exists(_vars,_field)) return _source;
    var _value=_vars[$ _field];
    if(!sprite_exists(_value)) throw "Frontier area sprite is missing: "+scrFRAreaKey(_area)+"."+_field;
    return _value;
}
function scrFRAreaSourceSprite(_sprite) {
    if(!instance_exists(GameCont) || !scrFRAreaActive(GameCont.area)) return _sprite;
    return scrFRAreaSprite(GameCont.area,_sprite);
}
function scrFRAreaFloorSprite(_area,_style=false,_explo=false) {
    return scrFRAreaSprite(_area,_explo?sprFloor1Explo:(_style?sprFloor1B:sprFloor1));
}
function scrFRAreaFloorSetup(_area,_explo=false) {
    if(!scrFRAreaActive(_area)) return false;
    area=_area;traction=1;
    sprite_index=scrFRAreaFloorSprite(_area,styleb,_explo);
    if(!_explo) {
        // The native Create callback has already assigned the normal styled
        // depth. Call the original setup once, without area_sprite side effects.
        scrFRAreaCall(_area,"area_setup_floor");
    }
    return true;
}
function scrFRAreaWallSprite(_area,_part) {
    var _base;
    switch(_part) {
        case "Top":_base=sprWall1Top;break;
        case "Bot":_base=sprWall1Bot;break;
        case "Out":_base=sprWall1Out;break;
        case "Trans":_base=sprWall1Trans;break;
        case "Debris":_base=sprDebris1;break;
        default:throw "Unknown Frontier wall sprite part: "+string(_part);
    }
    return scrFRAreaSprite(_area,_base);
}
function scrFRAreaLabel(_area,_subarea) {
    if(!scrFRAreaActive(_area)) return undefined;
    if(!instance_exists(GameCont)) return scrFRAreaKey(_area);
    var _old=GameCont.subarea,_result;
    try {GameCont.subarea=_subarea;_result=scrFRAreaCall(_area,"area_name");}
    finally {GameCont.subarea=_old;}
    return is_undefined(_result)?_result:scrFROptionText(_result,"",false);
}
function scrFRAreaTip(_generator) {
    if(!instance_exists(GameCont) || !scrFRAreaActive(GameCont.area) || !instance_exists(_generator)) return false;
    var _tip=scrFRAreaCall(GameCont.area,"area_text");
    if(!is_undefined(_tip)) _generator.tip=scrFROptionText(_tip,"",false);
    return true;
}
function scrFRAreaRoadmap(_waypoint,_last) {
    if(!scrFRAreaActive(_waypoint[0])) return undefined;
    var _args=[_last.x,_last.y,_last.area,_last.subarea,_waypoint[1],_waypoint[2]],
        _pos=scrFRAreaCall(_waypoint[0],"area_mapdata",_args);
    if(!is_array(_pos) || array_length(_pos)<2) _pos=[_last.x,9,_waypoint[1]==1];
    return {x:_pos[0],y:_pos[1],area:_waypoint[0],subarea:_waypoint[1],loops:_waypoint[2],
        showdot:array_length(_pos)>2?_pos[2]:false,showline:_last.area==-1 || _last.loops==_waypoint[2],warp:undefined};
}
function scrFRAreaSet(_area,_subarea=1,_loops=undefined) {
    if(!instance_exists(GameCont)) throw "Frontier area_set requires an active run";
    if(is_undefined(_loops)) _loops=GameCont.loops;
    _area=scrFRAreaResolve(_area);
    // Source portals set destination subarea0 before the ensuing finish.
    // Native portals keep the active world unchanged until Room End.
    var _destination=scrNTTEFullAreaSet(_area,max(1,_subarea),_loops);
    if(_subarea==0 && scrFRAreaActive(_area))
        _destination.fr_entry_finish={area:_area,subarea:0,loops:_loops,
            from_area:GameCont.area,from_subarea:GameCont.subarea};
    return _destination;
}
function scrFRAreaGenerationSetup() {
    var _stack=global.fr_area_generation_setups;
    if(array_length(_stack)>0) scrFRCallArray(_stack[array_length(_stack)-1],[]);
}
function scrFRAreaGenerate(_area,_subarea,_loops,_x,_y,_set_area=true,_overlap_floor=0,_setup=undefined) {
    _area=scrFRAreaResolve(_area);
    if(is_undefined(_set_area)) _set_area=true;
    if(is_undefined(_overlap_floor)) _overlap_floor=0;
    if(!variable_global_exists("fr_area_generation_setups")) global.fr_area_generation_setups=[];
    var _callback=undefined,_count=array_length(global.fr_area_generation_setups);
    if(!is_undefined(_setup) && _setup!=noone) {
        array_push(global.fr_area_generation_setups,_setup);_callback=scrFRAreaGenerationSetup;
    }
    try {return scrNTTEFullAreaGenerate(_area,_subarea,_loops,_x,_y,_set_area,_overlap_floor,_callback);}
    finally {array_resize(global.fr_area_generation_setups,_count);}
}
function scrFRAreaConsumeEntry(_destination) {
    if(!is_struct(_destination)) return;
    var _entry=scrNTTEFullValue(_destination,"fr_entry_finish",undefined);
    if(!is_struct(_entry) || _entry.from_area!=area || _entry.from_subarea!=subarea
        || _entry.area!=_destination.area || _destination.subarea!=1
        || _entry.loops!=_destination.loops || !scrFRAreaActive(_entry.area)) return;
    var _area=area,_subarea=subarea,_loops=loops;
    try {
        area=_entry.area;subarea=0;loops=_entry.loops;
        scrFRAreaCall(area,"area_finish");
    } finally {area=_area;subarea=_subarea;loops=_loops;}
}
function scrFRAreaFinish() {
    if(!scrFRAreaActive(area)) return false;
    var _area=area,_subarea=subarea,_loops=loops,
        _pending=scrNTTEFullValue(id,"ntte_full_pending_destination",undefined);
    try {
        scrFRAreaCall(_area,"area_finish");
        if(!is_struct(_pending)) scrFRAreaSet(area,subarea,loops);
    } finally {area=_area;subarea=_subarea;loops=_loops;}
    return true;
}
function scrFRAreaTransit() {
    // Room-end also fires after the world controller has been disposed.
    // A stale global flag cannot authorize callbacks on a torn-down run.
    if(!scrFREnabled()) return;
    // NTT broadcasts transit to loaded area modules, including the route-only
    // AlternateAreaHandler. Snapshot order prevents nested registrations.
    var _modules=global.fr_module_order;
    for(var _i=0;_i<array_length(_modules);++_i) {
        var _module=_modules[_i];
        if(string_pos("area:",_module)==1 && scrFRScriptExists("area",_module,"area_transit"))
            scrFRModCallArray("area",_module,"area_transit",[]);
    }
    area=scrFRAreaResolve(area);lastarea=scrFRAreaResolve(lastarea);
    maxsubarea=scrAreaGetMaxSubarea(area);
    finalsubarea=subarea==maxsubarea;
}
function scrFRAreaDebugCustom(_area) {
    return is_real(_area) && ((_area>=201 && _area<=207) || (_area>=301 && _area<=306));
}
function scrFRAreaDebugAreas(_base) {
    // Keep native ordering, then append each stable custom identity once.
    var _areas=array_create(array_length(_base)),
        _extra=[201,202,203,204,205,206,207,301,302,303,304,305,306];
    array_copy(_areas,0,_base,0,array_length(_base));
    for(var _i=0;_i<array_length(_extra);++_i) {
        var _found=false;
        for(var _j=0;_j<array_length(_areas);++_j) if(_areas[_j]==_extra[_i]) {_found=true;break;}
        if(!_found) array_push(_areas,_extra[_i]);
    }
    return _areas;
}
function scrFRAreaDebugSubareas(_area) {
    // Devzone is a 99-floor test sequence, rather than 99 separate menu rows.
    // Its later floors remain reachable through the numeric console command.
    return _area==304 ? 1:scrAreaGetMaxSubarea(_area);
}
function scrFRAreaDebugName(_area) {
    switch(_area) {
        case 201:return "Coast";
        case 202:return "Oasis";
        case 203:return "Pizza Sewers";
        case 204:return "Lair";
        case 205:return "Trench";
        case 206:return "Red Caves";
        case 207:return "Undergrowth";
        case 301:return "Cove";
        case 302:return "Cyberspace";
        case 303:return "Deep Labs";
        case 304:return "Devzone";
        case 305:return "Graveyard";
        case 306:return "Robo Center";
    }
    return undefined;
}
function scrFRAreaDebugClearDestination() {
    if(!instance_exists(GameCont)) return;
    GameCont.ntte_full_pending_destination=undefined;
    GameCont.ntte_full_source_pending_generation=undefined;
    // A debug warp abandons any restored room that has not regenerated yet.
    if(variable_global_exists("fr_continue_generation")) global.fr_continue_generation=undefined;
    if(variable_global_exists("fr_continue_events")) global.fr_continue_events=undefined;
}
function scrFRAreaDebugParse(_text) {
    var _parts=string_split_array(string_lower(string_trim(_text)),"-"),_key=_parts[0];
    if(string_pos("area:",_key)==1) _key=string_delete(_key,1,5);
    var _areas=scrFRAreaDebugAreas([]),_area=undefined;
    for(var _i=0;_i<array_length(_areas);++_i) {
        var _candidate=_areas[_i];
        if(_key==string(_candidate) || _key==scrNTTEFullAreaKey(_candidate)) {_area=_candidate;break;}
    }
    if(is_undefined(_area)) return undefined;
    if(array_length(_parts)>2) throw "Custom area syntax: <name or ID>-<subarea>";
    var _subarea=array_length(_parts)>1 ? real(_parts[1]):1;
    if(_subarea!=floor(_subarea) || _subarea<1 || _subarea>scrAreaGetMaxSubarea(_area))
        throw "Custom area subarea is outside its valid range";
    return {area:_area,subarea:_subarea};
}
function scrFRAreaDebugConsole(_commands) {
    if(array_length(_commands)<2) return false;
    var _destination=scrFRAreaDebugParse(_commands[1]);
    if(is_undefined(_destination)) return false;
    if(!instance_exists(GameCont) || !instance_exists(Player)) throw "Goto requires an active player";
    var _loops=array_length(_commands)>2 ? real(string_replace(_commands[2],"l","")):0;
    if(_loops<0 || _loops!=floor(_loops)) throw "Goto Loop must be a nonnegative integer";
    scrFRAreaDebugClearDestination();
    with(GameCont) {
        route=0;area=_destination.area;subarea=_destination.subarea;loops=_loops;
        is_level_ended=false;can_advance_stage=false;
        maxsubarea=scrAreaGetMaxSubarea(area);finalsubarea=subarea==maxsubarea;
        hard=scrAreaGetDifficulty(area,subarea,loops);
        waypnt[waypoints]=area;waysub[waypoints]=subarea;waylps[waypoints]=loops;waypoints++;
    }
    print("Teleporting to "+scrAreaGetMapName(_destination.area,_destination.subarea,_loops,false,false));
    var _player=instance_find(Player,0),_portal=instance_create(_player.x,_player.y,Portal);
    with(_portal) {sprite_index=sprPortalDisappear;event_perform(ev_other,ev_animation_end);}
    return true;
}
function scrFRAreaTests() {
    var _names=["cove","cyberspace","deeplabs","devzone","graveyard","robocenter"];
    for(var _i=0;_i<array_length(_names);++_i) {
        var _area=301+_i,_name=_names[_i],_info=scrFRAreaInfo(_area);
        assert(scrFRAreaResolve(_name)==_area && scrFRAreaResolve("area:"+_name)==_area,"Frontier area identity mismatch: "+_name);
        assert(is_struct(_info) && _info.area_id==_area,"Frontier source area metadata missing: "+_name);
        assert(is_struct(scrNTTEFullAreaNativeBuilder(_area)),"Frontier source generator not registered: "+_name);
        assert(sprite_exists(scrFRAreaFloorSprite(_area)) && sprite_exists(scrFRAreaFloorSprite(_area,true)),"Frontier source floor resources missing: "+_name);
        assert(sprite_exists(scrFRAreaWallSprite(_area,"Top")) && sprite_exists(scrFRAreaWallSprite(_area,"Trans")),"Frontier source wall resources missing: "+_name);
    }
    assert(scrFRAreaResolve("coast")==201 && scrFRAreaResolve("red")==206,"Frontier integration changed NTTE stable area IDs");
    var _debug_areas=scrFRAreaDebugAreas([area_campfire,area_desert,area_hq]),
        _debug_twice=scrFRAreaDebugAreas(_debug_areas);
    assert(array_length(_debug_areas)==16 && array_length(_debug_twice)==16,
        "Goto omitted a custom area, duplicated it, or changed native candidates");
    for(var _i=0;_i<13;++_i) {
        var _area=_i<7 ? 201+_i:301+_i-7,
            _parsed=scrFRAreaDebugParse(scrNTTEFullAreaKey(_area)+"-1");
        assert(is_struct(_parsed) && _parsed.area==_area && _parsed.subarea==1,
            "Named Goto did not preserve the stable area identity");
    }
    var _last_dev=scrFRAreaDebugParse("304-99"),_named_cove=scrFRAreaDebugParse("area:cove-1");
    assert(scrFRAreaDebugSubareas(304)==1 && _last_dev.area==304 && _last_dev.subarea==99
        && _named_cove.area==301 && is_undefined(scrFRAreaDebugParse("1-3")),
        "Goto Devzone bounds or native-command fallback changed");
    scrFRAreaMenuConsoleTests();
    if(instance_exists(GameCont)) {
        var _pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined),
            _seed=scrNTTEFullValue(GameCont,"ntte_full_source_pending_generation",undefined),
            _generation=variable_global_exists("fr_continue_generation")?global.fr_continue_generation:undefined,
            _events=variable_global_exists("fr_continue_events")?global.fr_continue_events:undefined;
        try {
            GameCont.ntte_full_pending_destination={area:301,subarea:1,loops:0};
            GameCont.ntte_full_source_pending_generation=42;
            global.fr_continue_generation={game:GameCont.id};global.fr_continue_events={game:GameCont.id};
            scrFRAreaDebugClearDestination();
            assert(is_undefined(GameCont.ntte_full_pending_destination)
                && is_undefined(GameCont.ntte_full_source_pending_generation)
                && is_undefined(global.fr_continue_generation) && is_undefined(global.fr_continue_events),
                "Debug warp retained the abandoned room destination or Continue generation");
        } finally {
            GameCont.ntte_full_pending_destination=_pending;GameCont.ntte_full_source_pending_generation=_seed;
            global.fr_continue_generation=_generation;global.fr_continue_events=_events;
        }
    }
    return true;
}

function scrFRAreaMenuConsoleTests() {
    // Reproduce the menu state without destroying the live isolated fixture.
    // No gameplay ticks run while the controller is inactive.
    var _game=instance_find(GameCont,0),_previous_debug=global.console_active,
        _previous_orig=UberCont.opt_orig_console,_previous_console=UberCont.opt_console;
    if(instance_exists(_game)) instance_deactivate_object(_game);
    try {
        assert(!instance_exists(GameCont),"Console menu regression still has a live GameCont");
        var _areas=scrFRAreaDebugAreas([0,1,2,3,4,5,6,7,area_hq]);
        for(var _i=0;_i<array_length(_areas);++_i) {
            var _area=_areas[_i],_subareas=scrFRAreaDebugSubareas(_area);
            assert(_subareas>=1,"Menu console omitted an area's subarea metadata");
            for(var _sub=1;_sub<=_subareas;++_sub)
                assert(is_string(scrAreaGetMapName(_area,_sub,0,false,false)),
                    "Menu console map label is unavailable without GameCont");
        }
        assert(scrFRAreaInfo(302).subareas==1
            && scrFRAreaDebugParse("cyberspace-1").area==302,
            "Menu console cannot enumerate/parse Cyberspace without a run");
        // This builds the same complete Goto/skills views as the console key.
        scr_create_debug_overlay_views();
        scrNTTESmokeLog("PASS FRONTIER actual menu console views without GameCont");
    } finally {
        if(_game!=noone) instance_activate_object(_game);
        global.console_active=_previous_debug;
        UberCont.opt_orig_console=_previous_orig;UberCont.opt_console=_previous_console;
    }
    if(instance_exists(_game)) {
        var _lastarea=_game.lastarea;
        try {
            _game.lastarea=area_labs;
            assert(scrFRAreaInfo(302).next_area==area_labs,
                "Menu safety changed the real Cyberspace return destination");
        } finally {_game.lastarea=_lastarea;}
    }
}
