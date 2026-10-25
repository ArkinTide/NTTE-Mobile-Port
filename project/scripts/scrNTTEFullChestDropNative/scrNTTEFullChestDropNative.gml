// Original WeaponChest collisions d7cfc0/d7e8b0 and wepdrops field061e.
// Per-level source counter remains independent of Epsilon RNGStates/dropseed.
function scrNTTEFullChestDropReset() { GameCont.ntte_source_wepdrops=0; }
function scrNTTEFullChestDropBegin() {
    var _state=scrNTTEFullSourceSeedState(),_count=scrNTTEFullValue(GameCont,"ntte_source_wepdrops",0)
    scrNTTEFullSourceRandomSeed(_state.wepseed+_count,_state)
    GameCont.ntte_source_wepdrops=_count+1
}
function scrNTTEFullChestDropEnd() {
    var _state=scrNTTEFullSourceSeedState()
    scrNTTEFullSourceRandomSeed(_state.levseed,_state)
}
function scrNTTEFullChestDecide(_extra,_curse=false) {
    // Original scrDecideWep reads self.curse; native call sites additionally
    // carry a boolean argument. The physical context wins (notably big cursed
    // chests, whose Epsilon caller explicitly passes false).
    var _context={x:x,y:y,curse:scrNTTEFullValue(id,"curse",_curse)}
    return scrNTTEFullWeaponDropDecide(_context,_extra,scrNTTEFullSourceRandom)
}
// Original9940 scrDecideWepGold 004d11f0: the first six stay in
// loop pools, duplicate filtering precedes one irandom, and the chosen
// value is always written to the physical calling instance's wep field.
function scrNTTEFullGoldChestCandidates(_nearest) {
    var _list=[wep_golden_wrench,wep_golden_machinegun,wep_golden_shotgun,
        wep_golden_crossbow,wep_golden_grenade_launcher,wep_golden_laser_pistol]
    if(GameCont.loops>0) _list=array_concat(_list,[wep_golden_plasma_gun,wep_golden_slugger,
        wep_golden_splinter_gun,wep_golden_screwdriver,wep_golden_bazooka,wep_golden_assault_rifle])
    for(var _i=array_length(_list)-1;_i>=0;--_i)
        if(scrNTTEFullWeaponDropDuplicates(_list[_i],_nearest)) array_delete(_list,_i,1)
    // Source appends registered MOD raw names only when weapon_gold() >.5.
    // NTTE's registered raw modules all return0/undefined; three optional
    // gold LWO variants return-1 only when passed an existing gold model.
    // Native variant aliases must not enter this raw-module enumeration.
    return _list
}
function scrNTTEFullGoldChestDecide() {
    var _nearest=instance_nearest(x,y,Player),_list=scrNTTEFullGoldChestCandidates(_nearest)
    wep=array_length(_list)>0?_list[scrNTTEFullSourceIRandom(array_length(_list)-1)]:wep_golden_screwdriver
    if(object_index==WepPickup) roll=true
    return wep
}
function scrNTTEFullGoldChestLoot() {
    // Original GoldChest loops in each genuine new WepPickup's context;
    // each Ambidextrous copy gets an independent single source choice.
    repeat(1+scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)) {
        var _pickup=scrWeaponPickupCreate(x,y,wep_screwdriver,true)
        with(_pickup) {
            scrDecideWepGold()
            ammo=scr_weapon_get_type(wep)!=Ammo.None
            name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);sprite_index=scr_weapon_get_sprite(wep)
        }
    }
}
function scrNTTEFullChestPreviewSoundMuted() {
    return variable_global_exists("ntte_chest_preview") && global.ntte_chest_preview
}
function scrNTTEFullBiggestWeaponChestLevelStart() {
    var _native_seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),_source_random=_source.random,
        _count=scrNTTEFullValue(GameCont,"ntte_source_wepdrops",0),_last_count=_count,
        _nochest=GameCont.nochest,_rng=[],_selected=noone,
        _oldpreview=variable_global_exists("ntte_chest_preview")?global.ntte_chest_preview:false,
        _generators=scrNTTEFullInstances(GenCont)
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    GameCont.ntte_can_spawn_ultra_quasar_rifle=true
    // Native generation providers run from GenCont.Destroy; original NTTE's
    // level_start callback runs after that controller is gone. Temporarily
    // hide those controllers so the genuine chest's generation guard agrees.
    for(var _g=0;_g<array_length(_generators);++_g) instance_deactivate_object(_generators[_g])
    // Snapshot ONLY original exact normal/big boxes. The source excludes
    // cursed-big and giant classes even though all inherit WeaponChest here.
    var _chests=[]
    with(WeaponChest) if(object_index==WeaponChest || object_index==BigWeaponChest) array_push(_chests,id)
    try {
        for(var _i=0;_i<array_length(_chests);++_i) if(instance_exists(_chests[_i])) {
            var _chest=_chests[_i],_before=scrNTTEFullInstances(all),_copy=noone,_has=false
            global.ntte_chest_preview=true
            try {
                with(_chest) _copy=scrNTTEFullMergedNativeCopy(false)
                with(_copy) event_perform(ev_collision,PortalShock)
                var _after=scrNTTEFullInstances(all)
                for(var _j=0;_j<array_length(_after);++_j) if(array_get_index(_before,_after[_j])<0)
                    if(instance_is(_after[_j],WepPickup) && scrNTTEFullWeaponRaw(_after[_j].wep)==wep_ntte_ultra_quasar_rifle) _has=true
            }
            finally {
                var _after=scrNTTEFullInstances(all)
                for(var _j=array_length(_after)-1;_j>=0;--_j) if(array_get_index(_before,_after[_j])<0 && instance_exists(_after[_j])) instance_destroy(_after[_j],false)
                global.ntte_chest_preview=_oldpreview
            }
            if(_has) {
                _last_count++
                var _huge=scrNTTEFullLairChestCreate(_chest.x,_chest.y,"HugeWeaponChest",true)
                if(instance_exists(_huge) && instance_is(_huge,NTTEFullHugeWeaponChest)) {
                    _huge.curse=_chest.curse
                    if(_huge.curse>0) {
                        _huge.sprite_index=scrNTTERefSprite("HugeCursedChest")
                        _huge.spr_dead=scrNTTERefSprite("HugeCursedChestOpen")
                        _huge.snd_open=sndBigCursedChest
                    }
                }
                instance_destroy(_chest,false);_selected=_huge
                break
            }
        }
    }
    finally {
        random_set_seed(_native_seed);_source.random=_source_random
        global.rng_state=_rng;GameCont.nochest=_nochest
        GameCont.ntte_source_wepdrops=_last_count
        GameCont.ntte_can_spawn_ultra_quasar_rifle=false
        global.ntte_chest_preview=_oldpreview
        for(var _g=0;_g<array_length(_generators);++_g) instance_activate_object(_generators[_g])
    }
    return _selected
}
