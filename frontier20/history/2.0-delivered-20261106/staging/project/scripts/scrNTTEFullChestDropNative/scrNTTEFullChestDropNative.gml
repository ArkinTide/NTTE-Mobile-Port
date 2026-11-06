// Original WeaponChest collisions d7cfc0/d7e8b0 and wepdrops field061e.
// Per-level source counter remains independent of Epsilon RNGStates/dropseed.
// ntte.game_start190..232 and ntte_setup_WepPickup2806..2856: one guarantee
// per run, also satisfied by an earlier natural drop from the same raw pool.
function scrNTTEFullSecretWeaponInit() {
    var _explosives=[],_screwdrivers=[],_weapons=[],_modules=scrNTTEFullWeaponDropTable();
    for(var _w=0;_w<128;++_w) array_push(_weapons,{weapon:_w,raw:_w});
    for(var _i=0;_i<array_length(_modules);++_i) array_push(_weapons,_modules[_i]);
    for(var _i=0;_i<array_length(_weapons);++_i) {
        var _entry=_weapons[_i],_w=_entry.weapon;
        if(_w<=0 || _w>maxwep) continue;
        // Canonical English registry text, independent of selected UI language.
        var _name=string_upper(wep_name[_w]);
        if(wep_type[_w]==Ammo.Explosives) {
            var _include=array_contains([wep_hyper_launcher,wep_toxic_launcher,wep_sticky_launcher,
                wep_cluster_launcher,"claymore","blaster","puncher","buster","pulser","airstrike","herald"],_entry.raw),
                _tokens=["GRENADE","BAZOOKA","NUKE","BUBBLE","ABRIS","ROCKLET"];
            for(var _j=0;_j<array_length(_tokens);++_j) if(string_pos(_tokens[_j],_name)>0) _include=true;
            if(_include) array_push(_explosives,_w);
        }
        if(string_pos("SCREWDRIVER",_name)>0) array_push(_screwdrivers,_w);
    }
    GameCont.ntte_weapon_spawn=[{wep:_explosives,area:area_sewers,subarea:1,open:0},
        {wep:_screwdrivers,area:area_scrapyards,subarea:1,open:1}];
}
function scrNTTEFullSecretWeaponPickup() {
    if(scrNTTEFullValue(id,"ntte_secret_processed",false) || !instance_exists(GameCont)) return false;
    // New native runs initialize in GameCont.Create. Legacy continued runs have
    // no history of earlier drops; do not recreate already-consumed guarantees.
    ntte_secret_processed=true;
    var _rules=scrNTTEFullValue(GameCont,"ntte_weapon_spawn",[]),_changed=false;
    if(array_length(_rules)==0) return false;
    var _raw=scrNTTEFullWeaponRaw(wep),_record=scrNTTEFullWeaponDropNativeRecord(_raw);
    if(!is_undefined(_record)) _raw=_record.weapon;
    for(var _i=0;_i<array_length(_rules);++_i) {
        var _rule=_rules[_i],_spawn=array_get_index(_rule.wep,_raw)>=0;
        if(!_spawn && GameCont.area==_rule.area && GameCont.subarea==_rule.subarea
            && scrNTTEFullValue(id,"roll",false)) {
            var _chest=position_meeting(xstart,ystart,ChestOpen);
            if(_rule.open!=0 && _chest) _rule.open--;
            else {
                var _excluded=[];
                for(var _w=0;_w<=maxwep;++_w) if(array_get_index(_rule.wep,_w)<0) array_push(_excluded,_w);
                wep=scrNTTEFullWeaponDecide(0,GameCont.hard+_chest+2*curse,scr_weapon_is_golden(wep)>0,_excluded,id);
                _spawn=true;_changed=true;
            }
        }
        if(_spawn) {array_delete(_rules,_i,1);break;}
    }
    GameCont.ntte_weapon_spawn=_rules;
    if(_changed) {
        // Preserve pickup ammo/curse/physical position; only the selected weapon
        // and its presentation metadata change, as in the original setup hook.
        name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep);sprite_index=scr_weapon_get_sprite(wep);
    }
    return _changed;
}
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
        _generators=scrNTTEFullInstances(GenCont),
        _secret=json_stringify(scrNTTEFullValue(GameCont,"ntte_weapon_spawn",[]))
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
                // Source setup observes the already-open chest. Run just that
                // pending pickup setup after the real collision/Destroy, as
                // the first live Step would; do not advance loot physics.
                for(var _j=0;_j<array_length(_after);++_j) if(array_get_index(_before,_after[_j])<0)
                    if(instance_is(_after[_j],WepPickup)) with(_after[_j]) scrNTTEFullSecretWeaponPickup()
                for(var _j=0;_j<array_length(_after);++_j) if(array_get_index(_before,_after[_j])<0)
                    if(instance_is(_after[_j],WepPickup) && scrNTTEFullWeaponRaw(_after[_j].wep)==wep_ntte_ultra_quasar_rifle) _has=true
            }
            finally {
                var _after=scrNTTEFullInstances(all)
                for(var _j=array_length(_after)-1;_j>=0;--_j) if(array_get_index(_before,_after[_j])<0 && instance_exists(_after[_j])) instance_destroy(_after[_j],false)
                global.ntte_chest_preview=_oldpreview
                GameCont.ntte_weapon_spawn=json_parse(_secret)
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
        GameCont.ntte_weapon_spawn=json_parse(_secret)
        for(var _g=0;_g<array_length(_generators);++_g) instance_activate_object(_generators[_g])
    }
    return _selected
}
