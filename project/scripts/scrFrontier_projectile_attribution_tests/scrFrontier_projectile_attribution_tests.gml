function scrFRProjectileAttributionTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _player=instance_find(Player,0),_raw=scrFRWeaponResolve("bouncer enfilader"),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state);
    try {
        scrFRCustomProjectileFamilyTests();
        with(_player) {
            x=47500;y=47500;gunangle=0;accuracy=0;
            wep=_raw;bwep=wep_wrench;fr_source_wep=undefined;fr_source_bwep=undefined;
            ntte_state=scrNTTENewState(_raw);bntte_state=scrNTTENewState(wep_wrench);
            reload=0;can_shoot=true;infammo=true;
            scrFire(_raw,false,true);
        }
        var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),BouncerBullet);
        assert(array_length(_shots)==14,"Actual bouncer source weapon did not create fourteen bullets");
        for(var _i=0;_i<array_length(_shots);++_i) assert(_shots[_i].creator==_player
            && _shots[_i].team==_player.team && _shots[_i].hitid==_player.hitid,
            "Direct authored weapon lost caller identity while assigning its own creator/team");
        var _proxy=scrFRPlayerFireExt(0,_raw,47600,47500,_player.team,_player,0),
            _proxy_shots=scrFRMatching(BouncerBullet,"creator",_proxy);
        assert(array_length(_proxy_shots)==14,"Actual NPC firing proxy failed to create the source burst");
        for(var _i=0;_i<array_length(_proxy_shots);++_i) assert(_proxy_shots[_i].hitid==_player.hitid,
            "Authored NPC proxy failed to inherit its real owner's damage identity");
        with(_proxy) event_perform(ev_step,ev_step_end);
        assert(!instance_exists(_proxy),"Real FireCont EndStep failed to remove its temporary proxy");
        for(var _i=0;_i<array_length(_proxy_shots);++_i) assert(_proxy_shots[_i].creator==_player
            && _proxy_shots[_i].team==_player.team && _proxy_shots[_i].hitid==_player.hitid,
            "Real FireCont EndStep lost owner/team/damage identity when releasing authored bullets");
        var _npc=instance_create(47700,47500,Bandit),_parent,_derived,_explosion,_emitter,_delayed;
        with(_npc) {
            _parent=scrFRInstanceCreate(x,y,FRCustomProjectile);
            _parent.team=team;_parent.creator=id;
        }
        with(_parent) {
            _derived=scrFRInstanceCreate(x,y,BouncerBullet);
            _derived.team=team;_derived.creator=creator;
            _explosion=scrFRInstanceCreate(x,y,Explosion);
            _emitter=scrFRInstanceCreate(x,y,FRCustomObject);
            _emitter.team=team;_emitter.creator=creator;
        }
        with(_emitter) {
            _delayed=scrFRInstanceCreate(x,y,BouncerBullet);
            _delayed.team=team;_delayed.creator=creator;
        }
        assert(_parent.hitid==_npc.hitid && _derived.hitid==_npc.hitid
            && _derived.team==_npc.team && _derived.creator==_npc
            && _derived.ntte_monster_projectile,
            "Source NPC and derived projectile failed to preserve native damage provenance");
        assert(!variable_instance_exists(_emitter,"hitid") && _delayed.hitid==_npc.hitid
            && _delayed.creator==_npc && _delayed.team==_npc.team && _delayed.ntte_monster_projectile,
            "A delayed source CustomObject emitter lost damage identity or hostile provenance");
        assert(_explosion.hitid==HitId.Explosion,
            "Source creation overwrote an explicit constructor damage identity");
        _derived.hitid=[sprBullet1,"AUTHORED OVERRIDE"];
        assert(is_array(_derived.hitid) && _derived.hitid[1]=="AUTHORED OVERRIDE",
            "Authored projectile damage identity override did not remain writable");
        scrFRFireworkAttributionTests(_player);
        scrFRHookpoleFiringScopeTests(_player);
        scrFRWormholeDiscAttributionTests(_player);
        scrNTTESmokeLog("PASS FRONTIER actual source bouncer14, NPC FireCont EndStep14, hostile delayed emitter, Firework source destroy/burst, constructor and authored attribution overrides");
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_players);
        random_set_seed(_seed);global.rng_state=_rng;
    }
}

function scrFRWormholeNTTEAttributionValid(_shot,_player) {
    return _shot.creator==_player && _shot.team==_player.team
        && _shot.hitid==_player.hitid && scrFRWeaponTestsDamageIdentity(_shot,_player)
        && (_shot[$ "fr_damage_context_hitid"]??HitId.None)==_player.hitid;
}

function scrFRWormholeNTTEAttributionTests(_player) {
    var _before=scrNTTEFullInstances(all),_raw=scrFRWeaponResolve("FR_Wormhole"),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_source_seed=scrFRSourceRandomGetSeed(),
        _native_seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _vars=global.fr_module_vars[$ "weapon:FR_Wormhole"],_copies=[],_rows=[],
        _lists=[_vars.typelessWormholeList,_vars.bulletWormholeList,_vars.shellWormholeList,
            _vars.boltWormholeList,_vars.explosiveWormholeList,_vars.energyWormholeList],
        _profiles=[["BoneArrow",3],["BatDisc",3],["BubbleBomb",4],
            ["ElectroPlasma",5],["QuasarBeam",5],["LightningDisc",5]];
    for(var _i=0;_i<array_length(_lists);++_i) {
        var _copy=ds_list_create();ds_list_copy(_copy,_lists[_i]);array_push(_copies,_copy);
    }
    try {
        // Enumerate the authored registry rather than duplicating its spawn
        // parameters or testing only the random entry from the normal sweep.
        var _registered=0;
        for(var _l=0;_l<array_length(_lists);++_l) for(var _e=0;_e<ds_list_size(_lists[_l]);++_e) {
            var _candidate=ds_list_find_value(_lists[_l],_e);
            if(_candidate[1]=="OBJ" && _candidate[2]=="telib") _registered+=1;
        }
        assert(_registered==array_length(_profiles),"Wormhole NTTE OBJ acceptance no longer covers every authored entry");
        for(var _p=0;_p<array_length(_profiles);++_p) {
            var _profile=_profiles[_p],_entry=undefined,_list=_lists[_profile[1]];
            for(var _e=0;_e<ds_list_size(_list);++_e) {
                var _candidate=ds_list_find_value(_list,_e);
                if(_candidate[0]==_profile[0] && _candidate[1]=="OBJ" && _candidate[2]=="telib") {
                    _entry=_candidate;break;
                }
            }
            assert(is_array(_entry),"Actual Wormhole source registry lost NTTE OBJ entry: "+_profile[0]);
            with(_player) {
                x=48600;y=47500;gunangle=0;accuracy=0;race=Race.Fish;speed=0;
                wep=_raw;bwep=wep_wrench;ntte_state=scrNTTENewState(_raw);bntte_state=scrNTTENewState(wep_wrench);
                fr_source_wep=undefined;fr_source_bwep=undefined;
                ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);infammo=true;reload=0;can_shoot=true;
                scrFRWeaponPrepare(_raw,true);
            }
            var _state=scrFRWeaponSlotRead(_player,"wep"),_fire_before=scrNTTEFullInstances(all);
            assert(is_struct(_state),"Wormhole NTTE OBJ test did not initialize its real source weapon");
            _state.wormholeType=_profile[1];_state.spriteIndex=_profile[1];
            _state.wormholeSpawnObject=_entry[0];_state.wormholeSpawnType=_entry[1];
            _state.wormholeSpawnMod=_entry[2];_state.wormholeProjectileMin=_entry[3];_state.wormholeProjectileMax=_entry[4];
            _state.wormholeProjectileSpread=_entry[5];_state.wormholeProjectileSpeedMin=_entry[6];_state.wormholeProjectileSpeedMax=_entry[7];
            with(_player) scrFire(_raw,false,true);
            var _type=asset_get_index("NTTEFull"+_profile[0]),
                _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_fire_before),_type);
            assert(array_length(_shots)>=_entry[3],"Actual Wormhole source fire omitted NTTE OBJ burst: "+_profile[0]);
            for(var _s=0;_s<array_length(_shots);++_s) {
                assert(scrFRWormholeNTTEAttributionValid(_shots[_s],_player),
                    "Actual Wormhole NTTE OBJ lost shooter damage identity/context: "+_profile[0]);
            }
            var _probe=_shots[0];_probe.hitid=HitId.None;
            assert(!scrFRWormholeNTTEAttributionValid(_probe,_player)
                && !scrFRWeaponTestsDamageIdentity(_probe,_player),
                "Wormhole NTTE OBJ oracle admitted a missing native damage identity");
            _probe.hitid=_player.hitid;_probe.fr_damage_context_hitid=HitId.None;
            assert(!scrFRWormholeNTTEAttributionValid(_probe,_player),
                "Wormhole NTTE OBJ oracle admitted a lost real caller context");
            _probe.fr_damage_context_hitid=_player.hitid;
            var _row={rate:30/timescale,name:_profile[0],shots:array_length(_shots),
                hitid:_probe.hitid,context:_probe.fr_damage_context_hitid,owner_hitid:_player.hitid};
            array_push(_rows,_row);scrNTTESmokeLog("FRONTIER WORMHOLE NTTE OBJ observed "+json_stringify(_row));
        }
        var _native,_explicit;
        with(_player) {
            // The untouched NTTE native factory has no authored source handoff.
            // Its default must remain unchanged outside this compatibility bridge.
            _native=scrNTTEFullSystemsCreate("ElectroPlasma",48700,47500);
            _explicit=scrFRModCall("mod","telib","obj_create",48720,47500,"Explosion");
        }
        assert(_native.hitid==HitId.None && !variable_instance_exists(_native,"fr_damage_context_hitid"),
            "Wormhole compatibility changed the native NTTE constructor globally");
        assert(_explicit.hitid==HitId.Explosion && _explicit.fr_damage_context_hitid==_player.hitid,
            "NTTE object bridge overwrote an explicit native Explosion death cause");
        scrNTTESmokeLog("PASS FRONTIER actual Wormhole all six NTTE OBJ source entries, strict damage/context negatives and untouched native/explicit Explosion controls "+json_stringify(_rows));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_players);
        for(var _i=0;_i<array_length(_lists);++_i) {
            ds_list_copy(_lists[_i],_copies[_i]);ds_list_destroy(_copies[_i]);
        }
        scrFRSourceRandomSetSeed(_source_seed);random_set_seed(_native_seed);global.rng_state=_rng;
    }
}

function scrFRWormholeDiscAttributionTests(_player) {
    var _before=scrNTTEFullInstances(all),_raw=scrFRWeaponResolve("FR_Wormhole"),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_source_seed=scrFRSourceRandomGetSeed(),
        _vars=global.fr_module_vars[$ "weapon:FR_Wormhole"],_copies=[],
        _lists=[_vars.typelessWormholeList,_vars.bulletWormholeList,_vars.shellWormholeList,
            _vars.boltWormholeList,_vars.explosiveWormholeList,_vars.energyWormholeList];
    for(var _i=0;_i<array_length(_lists);++_i) {
        var _copy=ds_list_create();ds_list_copy(_copy,_lists[_i]);array_push(_copies,_copy);
    }
    try {
        with(_player) {
            x=48400;y=47500;gunangle=0;accuracy=0;race=Race.Fish;
            wep=_raw;bwep=wep_wrench;ntte_state=scrNTTENewState(_raw);bntte_state=scrNTTENewState(wep_wrench);
            fr_source_wep=undefined;fr_source_bwep=undefined;
            ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);infammo=true;reload=0;can_shoot=true;
            scrFRWeaponPrepare(_raw,true);
        }
        var _state=scrFRWeaponSlotRead(_player,"wep");
        assert(is_struct(_state),"Actual Wormhole initialization did not create its source weapon state");
        // Select the authored Disc entry deterministically; the actual native
        // fire path still runs its real source factory, burst and ownership.
        var _entry=undefined;
        for(var _i=0;_i<ds_list_size(_vars.boltWormholeList);++_i) {
            var _candidate=ds_list_find_value(_vars.boltWormholeList,_i);
            if(_candidate[0]==Disc) {_entry=_candidate;break;}
        }
        assert(is_array(_entry),"Actual Wormhole registry lost its authored Disc entry");
        _state.wormholeType=3;_state.spriteIndex=3;_state.ammoCost=7;
        _state.wormholeSpawnObject=_entry[0];_state.wormholeSpawnType=_entry[1];
        _state.wormholeSpawnMod=_entry[2];_state.wormholeProjectileMin=_entry[3];_state.wormholeProjectileMax=_entry[4];
        _state.wormholeProjectileSpread=_entry[5];_state.wormholeProjectileSpeedMin=_entry[6];_state.wormholeProjectileSpeedMax=_entry[7];
        with(_player) scrFire(_raw,false,true);
        var _shots=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Disc);
        assert(array_length(_shots)>=12,"Actual Wormhole source fire did not emit its authored Disc burst");
        for(var _i=0;_i<array_length(_shots);++_i) {
            var _shot=_shots[_i];
            assert(_shot.creator==_player && _shot.team==_player.team && _shot.hitid==HitId.Disc
                && _shot.fr_damage_context_hitid==_player.hitid && scrFRWeaponTestsDamageIdentity(_shot,_player),
                "Actual Wormhole Disc lost native constructor identity or source damage context");
        }
        var _probe=_shots[0];_probe.hitid=HitId.None;
        assert(!scrFRWeaponTestsDamageIdentity(_probe,_player),"Disc acceptance hid a missing native damage identity");
        _probe.hitid=HitId.Disc;_probe.fr_damage_context_hitid=HitId.None;
        assert(!scrFRWeaponTestsDamageIdentity(_probe,_player),"Disc acceptance hid a lost source damage context");
        var _ordinary;
        with(_player) _ordinary=scrFRInstanceCreate(48500,47500,BouncerBullet);
        _ordinary.hitid=HitId.Disc;
        assert(!scrFRWeaponTestsDamageIdentity(_ordinary,_player),"Disc exception admitted an incorrect ordinary projectile identity");
        scrNTTESmokeLog("PASS FRONTIER actual Wormhole Disc burst, explicit native death cause, source caller context and three negative attribution controls");
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_players);
        for(var _i=0;_i<array_length(_lists);++_i) {
            ds_list_copy(_lists[_i],_copies[_i]);ds_list_destroy(_copies[_i]);
        }
        scrFRSourceRandomSetSeed(_source_seed);
    }
}

function scrFRHookpoleFiringScopeTests(_player) {
    var _before=scrNTTEFullInstances(all),_raw=scrFRWeaponResolve("FR_GildedHookpole"),
        _holder=instance_create(48100,47500,FRCustomObject),_index=_player.index,
        _press=KeyCont.press_fire[_index],_hold=KeyCont.hold_fire[_index];
    try {
        // The VM compares reals with epsilon 1e-5, so 0 < 1e-6 itself is
        // false. Scale both sides to retain the physical 1e-6 threshold.
        var _zero=0,_outside=0.000002;
        assert(abs(_zero)*1000000<1 && !(abs(_outside)*1000000<1),
            "Hookpole orthogonal-motion precision rejected zero or accepted two micro-units");
        // This caller deliberately has no gunangle. The production dispatch
        // must supply the actual shooter context rather than borrowing one
        // from the test driver, companion or asynchronous emitter.
        assert(!variable_instance_exists(_holder,"gunangle"),"Weapon scope probe unexpectedly supplied a fake shooter field");
        with(_player) {
            x=48160;y=47500;speed=0;gunangle=90;accuracy=0;race=Race.Fish;
            wep=_raw;bwep=wep_wrench;ntte_state=scrNTTENewState(_raw);bntte_state=scrNTTENewState(wep_wrench);
            fr_source_wep=undefined;fr_source_bwep=undefined;
            ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);infammo=true;reload=0;can_shoot=true;clicked=false;
        }
        KeyCont.press_fire[_index]=true;KeyCont.hold_fire[_index]=true;
        with(_holder) with(_player) scrPlayerFiring(true);
        scrNTTESmokeLog("FRONTIER HOOKPOLE native input "+json_stringify({
            shooter:real(_player),caller:real(_holder),weapon:_raw,
            gunangle:_player.gunangle,hspeed:_player.hspeed,vspeed:_player.vspeed,
            speed:_player.speed,direction:_player.direction,scale:timescale,
            recoil:_player.wkick,reload:_player.reload,can_shoot:_player.can_shoot,
            shanks:array_length(scrFRMatching(Shank,"creator",_player))}));
        assert(_player.vspeed<0 && abs(_player.hspeed)*1000000<1,
            "Actual native hookpole input used its external caller's angle for authored shooter movement");
        var _direct=scrFRMatching(Shank,"creator",_player);
        assert(array_length(_direct)==2,"Actual native hookpole input failed to emit its two authored shanks");
        for(var _i=0;_i<array_length(_direct);++_i)
            assert(_direct[_i].direction==90 && _direct[_i].team==_player.team,
                "Authored nested with lost actual shooter gun angle/team after callback reentry");
        var _proxy;
        with(_holder) _proxy=scrFRPlayerFireExt(180,_raw,48260,47500,_player.team,_player,0);
        assert(_proxy.hspeed<0 && abs(_proxy.vspeed)*1000000<1,
            "NPC hookpole weapon callback used the caller instead of its native firing proxy");
        var _npc=scrFRMatching(Shank,"creator",_proxy);
        assert(array_length(_npc)==2,"NPC hookpole source callback failed to emit two authored shanks");
        for(var _i=0;_i<array_length(_npc);++_i)
            assert(_npc[_i].direction==180 && _npc[_i].team==_player.team,
                "NPC hookpole authored nested with read an external caller angle or team");
        with(_proxy) event_perform(ev_step,ev_step_end);
        for(var _i=0;_i<array_length(_npc);++_i)
            assert(_npc[_i].creator==_player && _npc[_i].hitid==_player.hitid,
                "NPC hookpole source ownership was lost during real FireCont finalization");
        var _merge=scrNTTEFullWeaponMerge(_raw,{wep:wep_revolver}),_handle=scrNTTEFullWeaponNative(_merge),
            _fusion_before=scrNTTEFullInstances(all);
        with(_player) {
            wep=_handle;ntte_state=scrNTTEFullWeaponNativeState(_merge);speed=0;gunangle=270;
            reload=0;can_shoot=true;
        }
        with(_holder) with(_player) scrFire(_handle,false,true);
        var _fusion=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_fusion_before),Shank);
        assert(array_length(_fusion)==2 && _player.vspeed>0 && abs(_player.hspeed)*1000000<1,
            "A Hookpole fusion leaf lost its shooter context through the real native merged entry");
        for(var _i=0;_i<array_length(_fusion);++_i)
            assert(_fusion[_i].direction==270 && _fusion[_i].creator==_player,
                "A Hookpole fusion leaf changed authored nested-with direction or owner");
        scrNTTESmokeLog("PASS FRONTIER actual native Hookpole input/NPC/fusion shooter-other scope, two shanks, movement and final ownership");
    } finally {
        KeyCont.press_fire[_index]=_press;KeyCont.hold_fire[_index]=_hold;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}

function scrFRFireworkAttributionTests(_player) {
    var _rocket;
    with(_player) {
        _rocket=scrFRModCall("mod","Frontier_Projectiles","FireworkRocket_create",47900,47500);
        _rocket.team=team;_rocket.creator=id;
    }
    var _authored=_rocket.hitid,_step=global.fr_module_scripts[$ "mod:Frontier_Projectiles"][$ "FireworkExtraBursts_step"];
    assert(is_array(_authored) && _authored[1]=="FIREWORK ROCKET",
        "Actual Firework rocket factory lost its authored damage identity");
    with(_rocket) instance_destroy();
    var _emitters=scrFRMatching(FRCustomObject,"on_step",_step);
    assert(array_length(_emitters)==1,"Actual Firework destruction failed to create its delayed source emitter");
    var _emitter=_emitters[0];
    assert(!variable_instance_exists(_emitter,"hitid") && _emitter.creator==_player
        && _emitter.fr_damage_context_hitid==_authored,
        "Actual Firework delayed emitter lost the destroyed rocket's damage context");
    with(_emitter) {burstTime=0;scrFRActorCallback("on_step");}
    var _bursts=scrFRMatching(FRCustomProjectile,"on_step",
        global.fr_module_scripts[$ "mod:Frontier_Projectiles"][$ "FireworkBurstBullet_step"]);
    assert(array_length(_bursts)==1,"Actual Firework delayed source callback failed to emit a burst bullet");
    var _burst=_bursts[0];
    assert(_burst.creator==_player && _burst.team==_player.team && _burst.hitid==_authored,
        "Actual Firework delayed burst lost source owner/team/precise damage identity");
    with(_burst) instance_destroy();
    var _explosions=scrFRInstances(SmallExplosion),_authored_explosion=false;
    for(var _i=0;_i<array_length(_explosions);++_i) {
        var _identity=_explosions[_i].hitid;
        if(is_array(_identity) && _identity[0]==sprExplosion && _identity[1]=="FIREWORK EXPLOSION")
            _authored_explosion=true;
    }
    assert(_authored_explosion,"Actual Firework burst destruction lost its explicit explosion identity override");
}

function scrFRCustomProjectileFamilyTests() {
    var _before=scrFRInstanceNumber(FRCustomProjectile),
        _projectile=instance_create(47800,47500,FRCustomProjectile),
        _slash=instance_create(47880,47500,FRCustomSlash),
        _native=instance_create(47960,47500,Slash),
        _probe=instance_create(47880,47500,FRCustomObject);
    try {
        _projectile.fr_family_probe=true;_slash.fr_family_probe=true;_native.fr_family_probe=true;
        _slash.mask_index=mskBullet1;_probe.mask_index=mskBullet1;
        var _found=scrFRMatching([FRCustomProjectile,FRCustomSlash],"fr_family_probe",true);
        assert(array_length(_found)==2 && array_contains(_found,real(_projectile)) && array_contains(_found,real(_slash)),
            "Source CustomProjectile family omitted a CustomSlash or duplicated an overlapping selector");
        assert(scrFRInstanceNumber(FRCustomProjectile)==_before+2
            && scrFRInstanceIs(_slash,FRCustomProjectile) && !scrFRInstanceIs(_native,FRCustomProjectile)
            && scrFRObjectParent(FRCustomSlash)==FRCustomProjectile,
            "Source CustomSlash ancestry did not remain consistent across query/number/instance_is/parent APIs");
        assert(instance_is(_slash,Slash) && !instance_is(_slash,FRCustomProjectile)
            && object_get_parent(FRCustomSlash)==Slash,
            "Source family compatibility changed native Slash inheritance or its collision behavior");
        with(_probe) assert(scrFRPlaceMeeting(x,y,FRCustomProjectile),
            "Source CustomProjectile place query could not collide with an actual CustomSlash mask");
        scrNTTESmokeLog("PASS FRONTIER source CustomProjectile/CustomSlash family, overlap de-duplication and native Slash parent/collision mask");
    } finally {
        instance_destroy(_projectile,false);instance_destroy(_slash,false);
        instance_destroy(_native,false);instance_destroy(_probe,false);
    }
}
