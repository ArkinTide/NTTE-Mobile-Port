// Reserved byte-sized IDs do not renumber native A/B/C/D skins or cskingot arrays.
function scrNTTEFullSkinKey(_id) {
    if(is_string(_id)) return _id
    var _keys=["angler fish","bat eyes","bonus robot","coat venuz","cool frog","orchid plant","red crystal"]
    return _id>=200 && _id<=206 ? _keys[_id-200]:""
}
function scrNTTEFullSkinNativeId(_key) {
    for(var _id=200;_id<=206;++_id) if(scrNTTEFullSkinKey(_id)==_key) return _id
    return -1
}
function scrNTTEFullSkinMatches(_race,_skin) {
    var _key=scrNTTEFullSkinKey(_skin)
    return _key!="" && scrRaceGetNumericID(scrNTTEFullSkinRace(_key))==_race
}
function scrNTTEFullSkinSlots(_race) {
    var _slots=[]
    for(var _id=0;_id<scrRaceGetMaxSkinCount(_race);++_id) array_push(_slots,_id)
    for(var _id=200;_id<=206;++_id) if(scrNTTEFullSkinMatches(_race,_id)
        && scrNTTEFullFeatureReady("skin:"+scrNTTEFullSkinKey(_id))) array_push(_slots,_id)
    return _slots
}
function scrNTTEFullSkinSaved(_race) {
    var _key=scrNTTEFullLoadoutGet("skin:"+string(_race),"")
    if(_key=="") return -1
    var _id=scrNTTEFullSkinNativeId(_key)
    return _id>=200 && scrNTTEFullSkinMatches(_race,_id) && scrNTTEFullSkinAvailable(_key)
        && scrNTTEFullFeatureReady("skin:"+_key) ? _id:-1
}
function scrNTTEFullSkinMenuSprite(_race,_skin,_sprite) {
    if(scrNTTEFullRaceNumeric(_race)>=0) return scrNTTEFullRaceMenuSprite(_race,_skin,_sprite)
    return scrNTTEFullSkinMatches(_race,_skin) ? scrNTTEFullSkinSprite(scrNTTEFullSkinKey(_skin),_sprite):_sprite
}
function scrNTTEFullSkinRaceSprite(_race,_skin,_kind,_default) {
    var _base=asset_get_index("sprMutant"+string(_race)+_kind)
    return _base>=0 ? scrNTTEFullSkinSprite(scrNTTEFullSkinKey(_skin),_base):_default
}
function scrNTTEFullSkinPlayerSprite(_sprite,_mode="weapon") {
    return scrNTTEFullSkinTargetSprite(id,_sprite,_mode)
}
function scrNTTEFullSkinTargetSprite(_target,_sprite,_mode="weapon") {
    var _race=scrNTTEFullValue(_target,"race",-1),_skin=scrNTTEFullValue(_target,"bskin",scrNTTEFullValue(_target,"skin",0))
    return scrNTTEFullSkinMatches(_race,_skin) ? scrNTTEFullSkinSprite(scrNTTEFullSkinKey(_skin),_sprite,_mode):_sprite
}
function scrNTTEFullSkinUnlocked(_key) {
    if(!scrNTTEFullUnlockSet("skin:"+_key,true)) return false
    // NTTE OWNED: UnlockSet already queued the original skin notification.
    return true
}
function scrNTTEFullSkinShotCapture() {
    if(scrNTTEFullWeaponSkinFiring()) return -2
    if(!scrNTTEFullSkinMatches(scrNTTEFullValue(id,"race",-1),scrNTTEFullValue(id,"bskin",-1))) return -2
    // scrFire consumes this token synchronously, before the next event can
    // compact the native instance table. Nested shots own separate tokens.
    return scrNTTEFullMergedCaptureBegin()
}
function scrNTTEFullSkinShotsApply(_capture) {
    if(!is_struct(_capture)) return;
    var _slots=instance_count-_capture.ntte_merged_capture_count,
        _births=scrNTTEFullMergedCaptureEnd(_capture),_owner=id,_observed=undefined
    // Explicit smoke-only cost/order observer; ordinary play allocates no
    // diagnostic arrays and performs no projectile/world census.
    if(variable_global_exists("ntte_full_skin_shot_scan_observer") && is_array(global.ntte_full_skin_shot_scan_observer)) {
        _observed={captureVisits:0,applyVisits:_slots,applied:[]}
        array_push(global.ntte_full_skin_shot_scan_observer,_observed)
    }
    // Native with(projectile) visits newest first. Preserve that order and
    // the original creator filter while visiting only this firing's births.
    for(var _i=array_length(_births)-1;_i>=0;--_i) {
        var _shot=_births[_i]
        if(!instance_exists(_shot) || !instance_is(_shot,projectile)) continue
        with(_shot) if(scrNTTEFullValue(id,"creator",noone)==_owner) {
            if(is_struct(_observed)) array_push(_observed.applied,id)
            sprite_index=scrNTTEFullSkinTargetSprite(_owner,sprite_index,"weapon")
            sprite_index=scrNTTEFullSkinTargetSprite(_owner,sprite_index,"body")
            if(variable_instance_exists(id,"spr_fade")) spr_fade=scrNTTEFullSkinTargetSprite(_owner,spr_fade,"body")
        }
    }
}
function scrNTTEFullSkinSwapNative(_sound) {
    if(scrNTTEFullSkinMatches(race,bskin)) return scrNTTEFullSkinSwap(scrNTTEFullSkinKey(bskin),_sound)
    return _sound
}
// Original ntte.draw_gui_end accumulates real seconds across NTTE play and
// awards Bonus Robot at eight hours when a Robot player is present.
function scrNTTEFullSkinTimeStatTick() {
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    var _time=scrNTTEFullValue(global.ntte_full_progress.stats,"time",0)+timescale/30
    variable_struct_set(global.ntte_full_progress.stats,"time",_time)
    if(_time>=28800) {
        var _robot=false
        with(Player) if(race==Race.Robot) _robot=true
        if(_robot) scrNTTEFullSkinUnlocked("bonus robot")
    }
}


// Frozen pre-birth-token membership and sprite-transform oracle. These smoke
// helpers enumerate the full projectile family independently of the candidate.
function scrNTTEFullSkinShotLegacyCaptureTest() {
    var _latest=-1,_visits=0
    with(projectile) {_latest=max(_latest,id);_visits++}
    return {latest:_latest,visits:_visits}
}
function scrNTTEFullSkinShotsLegacyApplyTest(_capture) {
    var _owner=id,_observed={captureVisits:_capture.visits,applyVisits:0,applied:[]},_latest=_capture.latest
    with(projectile) {
        _observed.applyVisits++
        if(id>_latest && scrNTTEFullValue(id,"creator",noone)==_owner) {
            array_push(_observed.applied,id)
            sprite_index=scrNTTEFullSkinTargetSprite(_owner,sprite_index,"weapon")
            sprite_index=scrNTTEFullSkinTargetSprite(_owner,sprite_index,"body")
            if(variable_instance_exists(id,"spr_fade")) spr_fade=scrNTTEFullSkinTargetSprite(_owner,spr_fade,"body")
        }
    }
    return _observed
}
function scrNTTEFullSkinShotRowsTest(_latest,_owner) {
    var _rows=[]
    with(projectile) if(id>_latest && scrNTTEFullValue(id,"creator",noone)==_owner)
        array_push(_rows,[object_index,x,y,xstart,ystart,speed,direction,damage,knockback_speed,
            sprite_index,mask_index,image_index,image_angle,spr_fade,team,creator==_owner,hitid])
    return _rows
}
function scrNTTEFullSkinShotBirthCaptureNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Skin shot regression needs explicit desktop smoke")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),
        _observer=variable_global_exists("ntte_full_skin_shot_scan_observer")?global.ntte_full_skin_shot_scan_observer:undefined,
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _depth=variable_global_exists("ntte_full_merged_plain_depth")?global.ntte_full_merged_plain_depth:0,
        _request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined,
        _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
        _infammo=global.__debug_infammo,_owner=instance_find(Player,0),_cases=0,_old_visits=0,_new_visits=0
    try {
        global.ntte_full_merged_state_fire=undefined;global.ntte_full_merged_plain_depth=0
        global.ntte_full_merged_request=undefined;global.ntte_full_merged_input_weapon=undefined
        global.__debug_infammo=false
        _owner.race=Race.Eyes;_owner.bskin=201
        var _local=scrNTTEFullInstances(all),_old=instance_create(82000,82000,Bolt)
        _old.creator=_owner;_old.sprite_index=sprBoltGold;_old.spr_fade=sprMutant3Idle
        var _legacy=undefined,_outer=undefined,_inner=undefined
        with(_owner) {_legacy=scrNTTEFullSkinShotLegacyCaptureTest();_outer=scrNTTEFullSkinShotCapture()}
        var _first=instance_create(82000,82000,Bolt)
        _first.creator=_owner;_first.sprite_index=sprBoltGold;_first.spr_fade=sprMutant3Idle
        with(_owner) _inner=scrNTTEFullSkinShotCapture()
        var _second=instance_create(82000,82000,Bullet1),_other=instance_create(82000,82000,Bolt),
            _decoy=instance_create(82000,82000,NTTEFullMergedSetupProbe),_gone=instance_create(82000,82000,Bullet1)
        _second.creator=_owner;_second.sprite_index=sprMutant3Idle;_second.spr_fade=sprMutant3Idle
        _other.creator=noone;_other.sprite_index=sprBoltGold;_other.spr_fade=sprMutant3Idle
        _decoy.creator=_owner;_decoy.sprite_index=sprMutant3Idle
        instance_destroy(_gone,false)
        var _legacy_record=undefined,_expected=undefined,_rng=random_get_seed(),_native_rng=json_stringify(global.rng_state)
        with(_owner) {_legacy_record=scrNTTEFullSkinShotsLegacyApplyTest(_legacy);_expected=json_stringify(scrNTTEFullSkinShotRowsTest(_legacy.latest,id))}
        _first.sprite_index=sprBoltGold;_first.spr_fade=sprMutant3Idle
        _second.sprite_index=sprMutant3Idle;_second.spr_fade=sprMutant3Idle
        global.ntte_full_skin_shot_scan_observer=[]
        with(_owner) scrNTTEFullSkinShotsApply(_inner)
        assert(_first.sprite_index==sprBoltGold && _first.spr_fade==sprMutant3Idle
            && _second.sprite_index==scrNTTERefSprite("EyesBatIdle") && _second.spr_fade==scrNTTERefSprite("EyesBatIdle"),
            "Nested skin token changed earlier shot or lost body/fade mapping")
        assert(json_stringify(global.ntte_full_skin_shot_scan_observer[0].applied)==json_stringify([_second]),
            "Inner skin token included unrelated/nonprojectile/dead births")
        with(_owner) scrNTTEFullSkinShotsApply(_outer)
        var _actual=json_stringify(scrNTTEFullSkinShotRowsTest(_legacy.latest,_owner))
        assert(_actual==_expected && json_stringify(global.ntte_full_skin_shot_scan_observer[1].applied)==json_stringify(_legacy_record.applied),
            "Outer skin token changed literal old newest-first membership, typed refs or sprites")
        assert(_old.sprite_index==sprBoltGold && _old.spr_fade==sprMutant3Idle && _other.sprite_index==sprBoltGold
            && _other.spr_fade==sprMutant3Idle && _decoy.sprite_index==sprMutant3Idle,
            "Skin token touched old same-owner shots, other creators or nonprojectile births")
        assert(random_get_seed()==_rng && json_stringify(global.rng_state)==_native_rng,"Skin token consumed RNG")
        // Both old fast-return gates remain: no matching skin, or an explicit
        // physical weapon skin already responsible for projectile remapping.
        var _disabled=undefined
        _owner.bskin=0;with(_owner) _disabled=scrNTTEFullSkinShotCapture()
        assert(_disabled==-2,"Ordinary unskinned fire stopped using the constant-time disabled path")
        _owner.bskin=201;global.ntte_full_merged_state_fire={actor:_owner,part:{wep:wep_golden_crossbow,ntte_weapon_skin:"bat eyes"}}
        with(_owner) _disabled=scrNTTEFullSkinShotCapture()
        assert(_disabled==-2,"Tagged weapon skin was transformed twice")
        with(_owner) scrNTTEFullSkinShotsApply(_disabled)
        global.ntte_full_merged_state_fire=undefined
        scrNTTEFullMergedRuntimeTestCleanup(_local)
        // Actual raw scrFire comparisons, without a production oracle switch.
        // The selected ordinary native weapons, their constructors, damage and
        // sound helpers never inspect bskin except the two skin hooks. Neutral
        // bskin suppresses candidate hooks only while the old raw shot fires;
        // restoring it before literal old Apply recreates the previous path.
        var _weapons=[wep_golden_crossbow,wep_golden_shotgun,wep_golden_grenade_launcher]
        for(var _density=0;_density<2;++_density) {
            var _dense=scrNTTEFullInstances(all)
            if(_density==1) repeat(2048) {
                var _p=instance_create(83000,83000,Bullet1)
                _p.creator=noone;_p.speed=0
            }
            for(var _skin=200;_skin<=206;++_skin) for(var _w=0;_w<array_length(_weapons);++_w) {
                var _results=[],_weapon=_weapons[_w],_expected_count=_w==1?8:1
                for(var _impl=0;_impl<2;++_impl) {
                    var _shot_before=scrNTTEFullInstances(all)
                    scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
                    _owner.x=83600;_owner.y=83000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
                    _owner.hspeed=0;_owner.vspeed=0;_owner.gunangle=37;_owner.accuracy=0.75
                    _owner.race=scrRaceGetNumericID(scrNTTEFullSkinRace(scrNTTEFullSkinKey(_skin)));_owner.bskin=_skin
                    _owner.ntte_race_ultra=0;_owner.ntte_native_race=-1;_owner.infammo=0
                    _owner.wep=_weapon;_owner.bwep=wep_none;_owner.ntte_state=scrNTTENewState(_weapon)
                    _owner.ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);_owner.wepangle=1;_owner.wkick=0
                    GameCont.rad=100;GameCont.underwater=false;UberCont.opt_shake=1;UberCont.opt_freeze=1
                    global.ntte_full_skin_shot_scan_observer=[]
                    random_set_seed(532100+_skin*10+_w);global.rng_state=scrNTTEFullArrayCopy(_streams);current_frame=_frame
                    var _capture=undefined,_fired=false,_record=undefined,_capture_start=get_timer()
                    with(_owner) _capture=scrNTTEFullSkinShotLegacyCaptureTest()
                    var _capture_us=get_timer()-_capture_start,_birth_count=instance_count,_start=get_timer()
                    if(_impl==0) {
                        _owner.bskin=-1
                        with(_owner) _fired=scrFire(_weapon,true)
                        _owner.bskin=_skin
                        with(_owner) _record=scrNTTEFullSkinShotsLegacyApplyTest(_capture)
                    }
                    else {
                        with(_owner) _fired=scrFire(_weapon,true)
                        assert(array_length(global.ntte_full_skin_shot_scan_observer)==1,"Actual raw fire lost its skin capture/apply pair")
                        _record=global.ntte_full_skin_shot_scan_observer[0]
                    }
                    var _elapsed=get_timer()-_start+(_impl==0?_capture_us:0),_new_slots=instance_count-_birth_count,
                        _rows=scrNTTEFullSkinShotRowsTest(_capture.latest,_owner),
                        _state=[_rows,_owner.ammo,_owner.reload,_owner.wkick,_owner.hspeed,_owner.vspeed,
                            BackCont.viewx2,BackCont.viewy2,BackCont.shake,GameCont.rad],_row_ids=[]
                    with(projectile) if(id>_capture.latest && creator==_owner) array_push(_row_ids,id)
                    assert(_fired && array_length(_rows)==_expected_count
                        && json_stringify(_record.applied)==json_stringify(_row_ids),
                        "Actual skin fire changed native projectile count, creator filter or newest-first transform order")
                    if(_impl==1) assert(_record.captureVisits==0 && _record.applyVisits==_new_slots,
                        "Actual skin fire visit observer differs from the same-event native birth table")
                    if(_w==0) for(var _b=0;_b<array_length(_rows);++_b)
                        assert(_rows[_b][9]==scrNTTEFullSkinTargetSprite(_owner,sprBoltGold,"weapon"),
                            "Actual golden crossbow lost its selected skin projectile")
                    array_push(_results,{state:json_stringify(_state),seed:random_get_seed(),streams:json_stringify(global.rng_state),
                        probe:random(1),visits:_record.captureVisits+_record.applyVisits,time_us:_elapsed})
                    scrNTTEFullMergedRuntimeTestCleanup(_shot_before)
                }
                assert(_results[0].state==_results[1].state && _results[0].seed==_results[1].seed
                    && _results[0].streams==_results[1].streams && _results[0].probe==_results[1].probe,
                    "Skin birth capture changed actual raw fire sprites/fade/motion/ammo/reload or either RNG stream: skin="+string(_skin)+" weapon="+string(_weapon))
                if(_density==1) assert(_results[0].visits>=4096 && _results[1].visits<_results[0].visits/100,
                    "Dense skin fire still visits preexisting projectiles or lost native newborns")
                _old_visits+=_results[0].visits;_new_visits+=_results[1].visits;_cases++
                scrNTTESmokeLog("SKIN BIRTH FIRE "+json_stringify({rate:30/timescale,density:_density*2048,skin:_skin,weapon:_weapon,
                    oldVisits:_results[0].visits,newVisits:_results[1].visits,oldUs:_results[0].time_us,newUs:_results[1].time_us,equivalent:true}))
            }
            scrNTTEFullMergedRuntimeTestCleanup(_dense)
        }
        scrNTTESmokeLog("PASS skin same-event birth capture: nested/order/dead/creator/body/fade and both fast paths; actual "+string(_cases)
            +" old/new raw native fires across all 7 skins vs literal old sprite/RNG/ammo/motion oracle @"+string(30/timescale)
            +"; oldVisits="+string(_old_visits)+" newVisits="+string(_new_visits)+"; mobile timing unmeasured")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_skin_shot_scan_observer=_observer;global.ntte_full_merged_state_fire=_scope
        global.ntte_full_merged_plain_depth=_depth;global.ntte_full_merged_request=_request;global.ntte_full_merged_input_weapon=_input
        global.__debug_infammo=_infammo;global.rng_state=_streams;current_frame=_frame;random_set_seed(_seed)
    }
}
