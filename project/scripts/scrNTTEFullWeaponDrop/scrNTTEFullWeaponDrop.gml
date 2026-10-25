// NTT9940 scrDecideWep 004CE030 and ds_list_shuffle_w 0069B0C0.
// This is the native NTT drop path. telib.weapon_decide has a different API.
// Never seed/shuffle the base GameMaker random stream in this provider.
function scrNTTEFullWeaponDropInit() {
    global.ntte_full_weapon_drop_decide=scrNTTEFullWeaponDropDecide
}
function scrNTTEFullWeaponDropRecord(_raw) {
    var _table=scrNTTEFullWeaponDropTable()
    for(var _i=0;_i<array_length(_table);++_i) if(_table[_i].raw==_raw) return _table[_i]
    return undefined
}
function scrNTTEFullWeaponDropNativeRecord(_weapon) {
    var _raw=scrNTTEFullWeaponRaw(_weapon)
    if(!is_numeric(_raw)) return undefined
    // These native IDs are source modes/fields of a single registered LWO;
    // they never add entries to the source candidate pool.
    if(_raw==wep_ntte_bone_shotbow || _raw==wep_ntte_bone_slugbow) _raw=wep_ntte_bone_scythe
    if(_raw==wep_ntte_golden_teleport_gun) _raw=wep_ntte_teleport_gun
    if(_raw==wep_ntte_golden_trident) _raw=wep_ntte_trident
    if(_raw==wep_ntte_golden_tunneller) _raw=wep_ntte_tunneller
    if(_raw>=wep_ntte_ancient_artifact && _raw<=wep_ntte_missing_artifact) _raw=wep_ntte_bone
    var _table=scrNTTEFullWeaponDropTable()
    for(var _i=0;_i<array_length(_table);++_i) if(_table[_i].weapon==_raw) return _table[_i]
    return undefined
}
// Native Epsilon keeps numeric IDs and per-physical-weapon ntte_state instead
// of replacing slots with NTT LWO structs. Preserve the *source conversion
// state* explicitly; merely allocating ntte_state is not an NTT LWO init.
function scrNTTEFullWeaponDropLWOInit(_weapon,_state,_phase) {
    var _record=scrNTTEFullWeaponDropNativeRecord(_weapon)
    if(is_undefined(_record) || !_record.lwo || !is_struct(_state)) return false
    if(_phase=="step" ? !_record.step_init:(_phase!="fire" || !_record.fire_init)) return false
    if(!variable_struct_exists(_state,"weapon") || _state.weapon!=_weapon) return false
    _state.ntte_drop_literal_lwo=true
    return true
}
function scrNTTEFullWeaponDropSlotIsLWO(_owner,_primary) {
    var _weapon=_primary ? _owner.wep:_owner.bwep
    if(is_struct(_weapon) || scrNTTEFullWeaponIsNative(_weapon)) return true
    var _state=scrNTTEFullValue(_owner,_primary ? "ntte_state":"bntte_state",undefined)
    return is_struct(_state) && scrNTTEFullValue(_state,"weapon",undefined)==_weapon
        && scrNTTEFullValue(_state,"ntte_drop_literal_lwo",false)
}
// Root hook: invoke from scrNTTEPlayerStep on each running Player step. Both
// slots run the source step script, including an inactive secondary slot.
function scrNTTEFullWeaponDropPlayerStep() {
    for(var _i=0;_i<2;++_i) {
        var _primary=_i==0,_weapon=_primary ? wep:bwep,
            _record=scrNTTEFullWeaponDropNativeRecord(_weapon)
        if(is_undefined(_record) || !_record.lwo || !_record.step_init) continue
        var _field=_primary ? "ntte_state":"bntte_state",_state=scrNTTEFullValue(id,_field,undefined)
        if(!is_struct(_state) || scrNTTEFullValue(_state,"weapon",undefined)!=_weapon) {
            _state=scrNTTENewState(_weapon);variable_instance_set(id,_field,_state)
        }
        scrNTTEFullWeaponDropLWOInit(_weapon,_state,"step")
    }
}
// Root hooks: actual scrFire entry and the *accepted* native charge branch.
// Source weapon_fire_init already runs on the first charging invocation;
// the Epsilon port defers scrFire until release. Never run on idle input or
// pickup creation. Native firing temporarily swaps the firing slot to wep.
function scrNTTEFullWeaponDropFire(_weapon) {
    var _record=scrNTTEFullWeaponDropNativeRecord(_weapon)
    if(is_undefined(_record) || !_record.lwo || !_record.fire_init || wep!=_weapon) return false
    return scrNTTEFullWeaponDropLWOInit(_weapon,scrNTTEState(),"fire")
}
function scrNTTEFullWeaponDropResolve(_raw) {
    if(!is_string(_raw)) return _raw
    var _record=scrNTTEFullWeaponDropRecord(_raw)
    return is_undefined(_record)?wep_none:_record.weapon
}
function scrNTTEFullWeaponDropArea(_raw,_context) {
    if(!is_string(_raw)) return scr_weapon_get_area(_raw)
    var _record=scrNTTEFullWeaponDropRecord(_raw)
    if(is_undefined(_record) || _record.weapon<=0) return -1
    if(_record.unlock!="" && !scrNTTEFullUnlockGet(_record.unlock)
        && !(_raw=="trident" && scrNTTEFullUnlockGet("wep:trident"))) return -1
    if(_raw=="super teleport gun") return scrNTTEFullValue(_context,"curse",0)>0?13:-1
    if(_raw=="ultra quasar rifle" && (!scrNTTEFullValue(GameCont,"ntte_can_spawn_ultra_quasar_rifle",false)
        || !scrNTTEFullUnlockGet("race:beetle"))) return -1
    if(_raw=="crabbone") {
        var _area=-1
        with(Player) {
            var _w=scrNTTEFullWeaponRaw(wep),_b=scrNTTEFullWeaponRaw(bwep)
            // The source reads primary's quest-part metadata even when the
            // secondary slot caused the crabbone raw-type match.
            if((_w==wep_ntte_bone || _b==wep_ntte_bone
                || (_w>=wep_ntte_ancient_artifact && _w<=wep_ntte_missing_artifact)
                || (_b>=wep_ntte_ancient_artifact && _b<=wep_ntte_missing_artifact))
                && !(_w>=wep_ntte_ancient_artifact && _w<=wep_ntte_missing_artifact)) { _area=4;break }
        }
        return _area
    }
    return _record.area
}
function scrNTTEFullWeaponDropCandidates(_tutorial=false) {
    var _list=[]
    // NTT has127 native weapons. Epsilon128 is an additional electric guitar.
    for(var _w=1;_w<=127;++_w) {
        var _type=scr_weapon_get_type(_w)
        // Source type mask0x13 (NTT bullet0, shell1, energy4).
        if(!_tutorial || _type==Ammo.Bullets || _type==Ammo.Shells || _type==Ammo.Energy) array_push(_list,_w)
    }
    var _table=scrNTTEFullWeaponDropTable()
    // Every registered MOD raw name is appended, even during the tutorial;
    // invalid/locked areas are tested only AFTER the complete-list shuffle.
    for(var _i=0;_i<array_length(_table);++_i) array_push(_list,_table[_i].raw)
    return _list
}
function scrNTTEFullWeaponDropShuffle(_list,_random=undefined) {
    if(is_undefined(_random)) _random=scrNTTEFullDropRandom
    for(var _remaining=array_length(_list);_remaining>0;) {
        // The source consumes the final n=1 draw as well.
        var _index=floor(_random(_remaining))
        --_remaining
        var _temp=_list[_index];_list[_index]=_list[_remaining];_list[_remaining]=_temp
    }
    return _list
}
function scrNTTEFullWeaponDropDuplicates(_raw,_nearest) {
    if(!instance_exists(_nearest) || _nearest.race==Race.Steroids) return false
    var _w=_nearest.wep,_b=_nearest.bwep
    if(!is_string(_raw)) return _raw==_w || _raw==_b
    var _record=scrNTTEFullWeaponDropRecord(_raw)
    // NTT compares the candidate raw string against slots literally. A raw
    // native ID represents its string; a physical LWO handle/struct never
    // equals that raw ID. Do not flatten an existing model to its raw type.
    if(is_undefined(_record)) return false
    return (_record.weapon==_w && !scrNTTEFullWeaponDropSlotIsLWO(_nearest,true))
        || (_record.weapon==_b && !scrNTTEFullWeaponDropSlotIsLWO(_nearest,false))
}
function scrNTTEFullWeaponDropSelect(_list,_min,_max,_context,_nearest,_random=undefined,_area=undefined) {
    if(is_undefined(_area)) _area=scrNTTEFullWeaponDropArea
    _list=scrNTTEFullWeaponDropShuffle(_list,_random)
    for(var _i=0;_i<array_length(_list);++_i) {
        var _raw=_list[_i],_difficulty=_area(_raw,_context)
        if(_difficulty<0 || _difficulty<_min || _difficulty>_max) continue
        if(scrNTTEFullWeaponDropDuplicates(_raw,_nearest)) continue
        if(!is_string(_raw)) {
            if(_raw==wep_super_disc_gun && scrNTTEFullValue(_context,"curse",0)<=0) continue
            if((_raw==wep_golden_disc_gun || _raw==wep_golden_nuke_launcher) && !UberCont.hardmode) continue
            if(_raw==wep_gun_gun && !scrCrownCheck(crwn_guns)) continue
        }
        return scrNTTEFullWeaponDropResolve(_raw)
    }
    return wep_screwdriver
}
function scrNTTEFullWeaponDropBounds(_extra,_curse,_robots,_refined) {
    var _mode=UberCont.hardmode?1:0,_hard=ceil((GameCont.hard-_mode*13)/(1+_mode*2)),_min=-1
    // Cursed lower bound is calculated BEFORE adding the Robot count.
    if(_curse>0) _min=median(3,1,_hard+_extra)
    _extra+=_robots
    if(_refined) _min=median(6,1,_hard+_extra)
    return [_min,_hard+_extra]
}
function scrNTTEFullWeaponDropDecide(_context,_extra=0,_random=undefined) {
    var _refined=scr_ultra_get(Race.Robot,UltraSkill.RefinedTaste),
        _bounds=scrNTTEFullWeaponDropBounds(_extra,scrNTTEFullValue(_context,"curse",0),scrPlayerCountRace(Race.Robot),_refined)
    if(_refined) instance_create(_context.x,_context.y,RobotA)
    var _nearest=instance_nearest(_context.x,_context.y,Player),
        _tutorial=scrNTTEFullValue(UberCont,"showtutorial",instance_exists(TutCont))
    return scrNTTEFullWeaponDropSelect(scrNTTEFullWeaponDropCandidates(_tutorial),_bounds[0],_bounds[1],_context,_nearest,_random)
}
function scrNTTEFullWeaponDropUnitTests() {
    var _saved=scrNTTEFullValue(GameCont,"ntte_full_pickup_seed",undefined),_hard=GameCont.hard,
        _mode=UberCont.hardmode,_crown=GameCont.crown,_player=instance_find(Player,0),
        _wep=_player.wep,_bwep=_player.bwep,_race=_player.race,_native_seed=random_get_seed()
    GameCont.ntte_full_pickup_seed=1
    var _list=scrNTTEFullWeaponDropShuffle([1,2,3,4,5])
    assert(_list[0]==4 && _list[1]==3 && _list[2]==2 && _list[3]==5 && _list[4]==1 && GameCont.ntte_full_pickup_seed==2078669041,
        "Native minstd shuffle order or final n=1 draw changed")
    assert(random_get_seed()==_native_seed,"Native NTT weapon shuffle polluted base GameMaker RNG")
    var _calls={count:0},_identity=method(_calls,function(_n) {count++;return _n-1}),
        _area=function(_raw,_ctx) { return _raw==wep_revolver?5:1 },_context={x:0,y:0,curse:0}
    _player.wep=wep_revolver;_player.bwep=wep_revolver;_player.race=Race.Fish
    assert(scrNTTEFullWeaponDropSelect([wep_revolver,wep_machinegun],0,1,_context,_player,_identity,_area)==wep_machinegun
        && _calls.count==2,"Source selection filtered candidates before shuffling or did not inject RNG")
    assert(scrNTTEFullWeaponDropSelect([wep_revolver],0,10,_context,_player,_identity,_area)==wep_screwdriver,
        "Original exhausted candidate scan must fall back to screwdriver")
    _player.race=Race.Steroids
    assert(scrNTTEFullWeaponDropSelect([wep_revolver],0,10,_context,_player,_identity,_area)==wep_revolver,
        "Steroids source duplicate exception changed")
    GameCont.hard=0;UberCont.hardmode=false
    var _bounds=scrNTTEFullWeaponDropBounds(0,1,0,false)
    assert(_bounds[0]==1 && _bounds[1]==0,"Source impossible min/max was silently widened")
    GameCont.hard=19;UberCont.hardmode=true
    _bounds=scrNTTEFullWeaponDropBounds(1,1,2,true)
    assert(_bounds[0]==5 && _bounds[1]==5,"Native hardmode/Robot lower-bound order changed")
    var _area_all=function(_raw,_ctx) {return 5}
    UberCont.hardmode=false;GameCont.crown=Crown.None
    assert(scrNTTEFullWeaponDropSelect([wep_super_disc_gun],0,10,_context,noone,_identity,_area_all)==wep_screwdriver
        && scrNTTEFullWeaponDropSelect([wep_golden_nuke_launcher],0,10,_context,noone,_identity,_area_all)==wep_screwdriver
        && scrNTTEFullWeaponDropSelect([wep_golden_disc_gun],0,10,_context,noone,_identity,_area_all)==wep_screwdriver
        && scrNTTEFullWeaponDropSelect([wep_gun_gun],0,10,_context,noone,_identity,_area_all)==wep_screwdriver,
        "Native curse/hardmode/Crown special weapon conditions changed")
    _context.curse=1;UberCont.hardmode=true;GameCont.crown=Crown.Guns
    assert(scrNTTEFullWeaponDropSelect([wep_super_disc_gun],0,10,_context,noone,_identity,_area_all)==wep_super_disc_gun
        && scrNTTEFullWeaponDropSelect([wep_golden_nuke_launcher],0,10,_context,noone,_identity,_area_all)==wep_golden_nuke_launcher
        && scrNTTEFullWeaponDropSelect([wep_golden_disc_gun],0,10,_context,noone,_identity,_area_all)==wep_golden_disc_gun
        && scrNTTEFullWeaponDropSelect([wep_gun_gun],0,10,_context,noone,_identity,_area_all)==wep_gun_gun,
        "Native source special weapon conditions no longer admit valid candidates")
    _context.curse=0;_player.race=Race.Fish
    _player.wep={wep:wep_ntte_bone};_player.bwep=wep_ntte_bubble_rifle
    assert(!scrNTTEFullWeaponDropDuplicates("crabbone",_player)
        && scrNTTEFullWeaponDropDuplicates("bubble rifle",_player)
        && scrNTTEFullWeaponDropArea("crabbone",_context)==4,
        "Source raw-string/LWO slot comparisons or conditional bone area changed")
    var _candidates=scrNTTEFullWeaponDropCandidates(false),_table=scrNTTEFullWeaponDropTable()
    assert(array_length(_candidates)==161 && _candidates[126]==127 && _candidates[127]=="tewrapper"
        && _candidates[160]=="ultra quasar rifle","Source native127+MOD34 candidate order changed")
    assert(scrNTTEFullWeaponDropArea("tewrapper",_context)==-1 && scrNTTEFullWeaponDropArea("super teleport gun",_context)==-1,
        "Wrapper or noncursed super teleport gun leaked into native drops")
    _player.wep=_wep;_player.bwep=_bwep;_player.race=_race
    GameCont.hard=_hard;UberCont.hardmode=_mode;GameCont.crown=_crown;GameCont.ntte_full_pickup_seed=_saved
    scrNTTESmokeLog("FULL NATIVE WEAPON DROP: original minstd shuffle, candidate161 registration order, injected RNG, post-shuffle filtering, Robot/curse bounds and fallback OK @"+string(30/timescale))
}
function scrNTTEFullWeaponDropLifecycleUnitTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),_buffer=-1
    try {
        var _table=scrNTTEFullWeaponDropTable(),_step_count=0,_fire_only=0
        for(var _i=0;_i<array_length(_table);++_i) if(_table[_i].lwo) {
            if(_table[_i].step_init) { _step_count+=1; } else { _fire_only+=1; }
        }
        assert(_step_count==9 && _fire_only==5,"Original LWO source phase map changed")
        _player.x=43816;_player.y=43816;_player.race=Race.Fish
        _player.wep=wep_revolver;_player.bwep=wep_none;_player.curse=0;_player.bcurse=0
        _player.can_pick=true;_player.max_extra_weps=0;_player.extra_weps=[];_player.ntte_extra_states=[]
        _player.ntte_state=scrNTTENewState(wep_revolver);_player.bntte_state=undefined
        KeyCont.press_pick[_player.index]=false;KeyCont.press_swap[_player.index]=false
        var _drop=scrWeaponPickupCreate(_player.x,_player.y,wep_ntte_teleport_gun)
        _drop.speed=0;_drop.autopick=true
        assert(!scrNTTEFullValue(scrNTTEFullValue(_drop,"ntte_state",undefined),"ntte_drop_literal_lwo",false),
            "Native pickup creation prematurely performed source LWO step/fire init")
        with(_drop) with(_player) event_perform(ev_collision,WepPickup)
        assert(!instance_exists(_drop) && _player.wep==wep_ntte_teleport_gun
            && scrNTTEFullWeaponDropDuplicates("teleport gun",_player),
            "New raw MOD pickup must match native source candidate before its first step")
        with(_player) scrNTTEPlayerStep()
        var _state=_player.ntte_state
        assert(scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && !scrNTTEFullWeaponDropDuplicates("teleport gun",_player),
            "Actual native Player step did not perform source step LWO initialization")
        with(_player) scrSwapWeps(false)
        assert(_player.bwep==wep_ntte_teleport_gun && _player.bntte_state==_state
            && scrNTTEFullWeaponDropSlotIsLWO(_player,false)
            && !scrNTTEFullWeaponDropDuplicates("teleport gun",_player),
            "Native swap detached physical LWO conversion state from the secondary slot")
        with(_player) scrSwapWeps(false)
        _player.x+=16
        var _replacement=scrWeaponPickupCreate(_player.x,_player.y,wep_wrench)
        _replacement.speed=0;_replacement.autopick=true
        with(_replacement) with(_player) event_perform(ev_collision,WepPickup)
        var _ground=noone
        with(WepPickup) if(wep==wep_ntte_teleport_gun && scrNTTEFullValue(id,"ntte_state",undefined)==_state) {_ground=id;break}
        assert(instance_exists(_ground) && _ground.ntte_state==_state && _state.ntte_drop_literal_lwo,
            "Real native replacement lost initialized physical LWO state on the ground")
        _player.bwep=wep_none;_player.bntte_state=undefined
        _ground.autopick=true;_ground.speed=0
        with(_ground) with(_player) event_perform(ev_collision,WepPickup)
        assert(!instance_exists(_ground) && _player.ntte_state==_state
            && !scrNTTEFullWeaponDropDuplicates("teleport gun",_player),
            "Real ground re-pickup reverted initialized LWO to raw-string duplicate behavior")
        _player.x+=16
        var _fresh=scrWeaponPickupCreate(_player.x,_player.y,wep_ntte_quasar_rifle)
        _fresh.speed=0;_fresh.autopick=true
        with(_fresh) with(_player) event_perform(ev_collision,WepPickup)
        assert(!instance_exists(_fresh) && _player.wep==wep_ntte_quasar_rifle
            && scrNTTEFullWeaponDropDuplicates("quasar rifle",_player),
            "Fresh fire-only weapon inherited an unrelated weapon's LWO flag")
        with(_player) scrNTTEPlayerStep()
        assert(is_struct(_player.ntte_state) && !scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && scrNTTEFullWeaponDropDuplicates("quasar rifle",_player),
            "Allocating native state during a frame incorrectly initialized fire-only LWO")
        _player.infammo=true
        with(_player) scrFire(wep,false,true)
        assert(scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && !scrNTTEFullWeaponDropDuplicates("quasar rifle",_player),
            "Actual native scrFire failed source fire-only LWO initialization")
        var _stale=_player.ntte_state
        _player.wep=wep_ntte_annihilator
        assert(!scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && scrNTTEFullWeaponDropDuplicates("annihilator",_player),
            "A stale physical state marked a different new weapon as already initialized")
        _player.ntte_state=scrNTTENewState(wep_ntte_annihilator)
        _player.can_shoot=true;_player.ntte_red_ammo=3
        KeyCont.hold_fire[_player.index]=true;KeyCont.press_fire[_player.index]=true
        with(_player) scrNTTEHandleInput(wep,true)
        assert(_player.ntte_state.charge>0 && scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && !scrNTTEFullWeaponDropDuplicates("annihilator",_player),
            "Accepted native charging did not initialize source LWO before trigger release")
        _player.wep=wep_ntte_entangler;_player.ntte_state=scrNTTENewState(wep_ntte_entangler)
        _player.can_shoot=false
        with(_player) scrNTTEHandleInput(wep,true)
        assert(!scrNTTEFullWeaponDropSlotIsLWO(_player,true)
            && scrNTTEFullWeaponDropDuplicates("entangler",_player),
            "Blocked native charging initialized a source LWO without any fire invocation")
        _player.wep=wep_ntte_quasar_rifle;_player.ntte_state=_stale
        _player.bwep=wep_ntte_clam_shield;_player.bntte_state=undefined
        KeyCont.hold_fire[_player.index]=false;KeyCont.press_fire[_player.index]=false
        with(_player) scrNTTEPlayerStep()
        assert(scrNTTEFullWeaponDropSlotIsLWO(_player,false)
            && !scrNTTEFullWeaponDropDuplicates("clam shield",_player),
            "Inactive secondary did not execute its source LWO step initialization")
        _buffer=buffer_create(1024,buffer_grow,1)
        scrSavegamePlayers(_buffer,false);buffer_seek(_buffer,buffer_seek_start,0)
        scrSavegamePlayers(_buffer,true)
        var _loaded=noone
        with(Player) if(array_get_index(_before,id)<0) {_loaded=id;break}
        assert(instance_exists(_loaded) && _loaded.wep==wep_ntte_quasar_rifle
            && scrNTTEFullWeaponDropSlotIsLWO(_loaded,true)
            && !scrNTTEFullWeaponDropDuplicates("quasar rifle",_loaded),
            "Actual native save continuation lost physical LWO conversion state")
    }
    finally {
        if(buffer_exists(_buffer)) buffer_delete(_buffer)
        var _after=scrNTTEFullInstances(all)
        for(var _i=array_length(_after)-1;_i>=0;--_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_keys);scrNTTEFullAreaGeneratorRestore(_back)
    }
    scrNTTESmokeLog("FULL NATIVE WEAPON DROP LWO: actual raw pickup, source step/fire phases, secondary swap, ground replacement/re-pickup, stale-state guard and native save continuation OK @"+string(30/timescale))
}

function scrNTTEFullWeaponDropTable() {
    static _table=[{"raw":"tewrapper","weapon":0,"area":-1,"unlock":"","lwo":false,"step_init":false,"fire_init":false},{"raw":"crabbone","weapon":159,"area":4,"unlock":"","lwo":true,"step_init":true,"fire_init":true},{"raw":"scythe","weapon":160,"area":19,"unlock":"wep:scythe","lwo":true,"step_init":true,"fire_init":true},{"raw":"teleport gun","weapon":153,"area":7,"unlock":"","lwo":true,"step_init":true,"fire_init":true},{"raw":"super teleport gun","weapon":154,"area":13,"unlock":"","lwo":true,"step_init":true,"fire_init":true},{"raw":"beetle pistol","weapon":131,"area":-1,"unlock":"","lwo":false,"step_init":false,"fire_init":true},{"raw":"rogue carbine","weapon":129,"area":-1,"unlock":"","lwo":false,"step_init":false,"fire_init":true},{"raw":"energy bat","weapon":144,"area":11,"unlock":"","lwo":false,"step_init":false,"fire_init":true},{"raw":"annihilator","weapon":164,"area":22,"unlock":"pack:red","lwo":true,"step_init":false,"fire_init":true},{"raw":"entangler","weapon":165,"area":22,"unlock":"pack:red","lwo":true,"step_init":false,"fire_init":true},{"raw":"tunneller","weapon":166,"area":22,"unlock":"pack:red","lwo":true,"step_init":false,"fire_init":true},{"raw":"bat disc launcher","weapon":147,"area":5,"unlock":"pack:lair","lwo":true,"step_init":true,"fire_init":true},{"raw":"bat disc cannon","weapon":148,"area":11,"unlock":"pack:lair","lwo":true,"step_init":true,"fire_init":true},{"raw":"pizza cutter","weapon":149,"area":7,"unlock":"pack:lair","lwo":true,"step_init":true,"fire_init":true},{"raw":"harpoon launcher","weapon":150,"area":4,"unlock":"pack:coast","lwo":false,"step_init":false,"fire_init":true},{"raw":"net launcher","weapon":151,"area":8,"unlock":"pack:coast","lwo":false,"step_init":false,"fire_init":true},{"raw":"clam shield","weapon":152,"area":6,"unlock":"pack:coast","lwo":true,"step_init":true,"fire_init":true},{"raw":"trident","weapon":163,"area":7,"unlock":"pack:coast","lwo":true,"step_init":true,"fire_init":true},{"raw":"bubble rifle","weapon":135,"area":6,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"bubble shotgun","weapon":136,"area":8,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"bubble minigun","weapon":137,"area":10,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"bubble cannon","weapon":138,"area":11,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"hyper bubbler","weapon":139,"area":15,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"bubble bat","weapon":134,"area":6,"unlock":"pack:oasis","lwo":false,"step_init":false,"fire_init":true},{"raw":"lightring launcher","weapon":132,"area":6,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"super lightring launcher","weapon":133,"area":13,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"tesla coil","weapon":145,"area":11,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"electroplasma rifle","weapon":140,"area":7,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"electroplasma shotgun","weapon":141,"area":8,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"electroplasma cannon","weapon":142,"area":14,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"quasar blaster","weapon":155,"area":9,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"quasar rifle","weapon":156,"area":16,"unlock":"pack:trench","lwo":true,"step_init":false,"fire_init":true},{"raw":"quasar cannon","weapon":157,"area":18,"unlock":"pack:trench","lwo":false,"step_init":false,"fire_init":true},{"raw":"ultra quasar rifle","weapon":158,"area":21,"unlock":"race:beetle","lwo":true,"step_init":false,"fire_init":true}]
    return _table
}
