function scrNTTEFullDiscWeaponFireTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_seed=random_get_seed(),_p=instance_find(Player,0),
        _progress=global.ntte_full_progress,_progressSerialized=json_stringify(_progress),
        _debug=global.__debug_infammo
    try {
        global.__debug_infammo=false
        // weapon_sprt in both source modules checks pack:lair before the
        // returning-blade indicator. Keep the fixture's unlocks private.
        global.ntte_full_progress=json_parse(_progressSerialized)
        assert(global.ntte_full_progress!=_progress,"Disc fire fixture did not isolate original progress identity")
        global.ntte_full_progress.unlocks[$ "pack:lair"]=true
        _p.x=85000;_p.y=85000;_p.gunangle=0;_p.accuracy=0;_p.infammo=0;_p.wepangle=-1
        var _weapons=[wep_ntte_sawblade_gun,wep_ntte_sawblade_cannon]
        for(var _i=0;_i<2;++_i) {
            _p.wep=_weapons[_i];_p.ntte_state=scrNTTENewState(_p.wep)
            var _state=_p.ntte_state,_cap=_state.ammo,_cost=_i==0?1:7,
                _old=scrNTTEFullInstances(NTTEFullBatDisc),_disc=noone
            with(_p) scrFire(wep,false)
            with(NTTEFullBatDisc) if(array_get_index(_old,id)<0) _disc=id
            assert(instance_exists(_disc) && _disc.state==_state && _disc.wep==_state
                && _disc.creator==_p && _disc.team==_p.team && _disc.big==(_i==1)
                && _disc.ammo==_cost && _state.ammo==_cap-_cost && _state.outstanding==_cost,
                "Actual sawblade weapon lost native class, ownership or exact magazine binding")
            assert(abs(_disc.speed-12*timescale)<0.0001 && _disc.damage==2
                && _disc.mask_index==mskFlakBullet && _p.wkick==(_i==0?8:12),
                "Actual sawblade weapon doubled constructor speed or retained generic stats/post")
            _state.loaded=false;_disc.image_index=1
            global.ntte_full_progress.unlocks[$ "pack:lair"]=false
            assert(!scrNTTEFullWeaponAvailable(_p.wep)
                && scrNTTEFullWeaponStateSprite(_p.wep,_state)==scrNTTERefSprite("Weapon."+(_i==0?"bat disc launcher":"bat disc cannon")+".sprWepLocked"),
                "Returning sawblade bypassed original pack:lair availability and locked sprite")
            global.ntte_full_progress.unlocks[$ "pack:lair"]=true
            assert(scrNTTEFullWeaponAvailable(_p.wep),"Sawblade returning-indicator fixture failed original pack:lair prerequisite")
            assert(scrNTTEFullWeaponStateSprite(_p.wep,_state)==scrNTTERefSprite("Weapon."+(_i==0?"bat disc launcher":"bat disc cannon")+".sprWepHoming"),
                "Sawblade held weapon failed original returning-blade sprite indicator")
            with(_disc) scrNTTEFullBatDiscCleanup()
            assert(_state.ammo==_cap && _state.outstanding==0,"Actual sawblade cleanup did not return exact rounds")
        }
        // Actual fire -> EndStep setup -> Alarm -> Destroy/Cleanup, with
        // both infinite-ammo sources. Physical count must never be set to0
        // just because no magazine rounds were charged.
        for(var _mode=0;_mode<3;++_mode) for(var _wi=0;_wi<2;++_wi) {
            global.__debug_infammo=_mode==2;_p.infammo=_mode==1
            _p.wep=_weapons[_wi];_p.ntte_state=scrNTTENewState(_p.wep)
            var _state=_p.ntte_state,_cap=_state.ammo,_cost=_wi==0?1:7,
                _refund=_mode==0?_cost:0,_old=scrNTTEFullInstances(NTTEFullBatDisc),_disc=noone
            with(_p) scrFire(wep,false)
            with(NTTEFullBatDisc) if(array_get_index(_old,id)<0) _disc=id
            assert(instance_exists(_disc) && _disc.ammo==_cost && _disc.refund==_refund
                && _state.ammo==_cap-_refund && _state.outstanding==_refund,
                "Actual sawblade fire conflated physical blade count with infinite-ammo refunds mode="+string(_mode))
            if(_wi==1) {
                with(_disc) event_perform(ev_step,ev_step_end)
                assert(_disc.sprite_index==scrNTTERefSprite("BatDiscBig") && _disc.alarm[0]==30,
                    "Actual cannon did not schedule original split timer")
                var _split_angle=_disc.direction
                with(_disc) event_perform(ev_alarm,0)
                assert(!instance_exists(_disc) && _state.ammo==_cap-_refund && _state.outstanding==_refund,
                    "Big blade credited the magazine before its child blades returned")
                var _children=scrNTTEFullInstances(NTTEFullBatDisc),_count=0
                for(var _j=0;_j<array_length(_children);++_j) {
                    var _child=_children[_j]
                    if(_child.state!=_state) continue
                    assert(!_child.big && _child.ammo==1 && _child.refund==_refund/7
                        && _child.creator==_p && _child.team==_p.team
                        && abs(angle_difference(_child.direction,_split_angle+360*_count/7))<0.001,
                        "Cannon radial child lost original physical count, refund or ownership")
                    _count++;instance_destroy(_child)
                }
                assert(_count==7,"Cannon failed seven-way split while infinite ammo was enabled")
            } else instance_destroy(_disc)
            assert(_state.ammo==_cap && _state.outstanding==0,
                "Finite/infinite blade lifecycle duplicated or lost magazine credits")
        }
        global.__debug_infammo=false;_p.infammo=1
        _p.wep=wep_ntte_energy_bat;_p.ntte_state=scrNTTENewState(_p.wep);_p.speed=0
        var _old_slashes=scrNTTEFullInstances(NTTEFullEnergyBatSlash),_slash=noone
        with(_p) scrFire(wep,false)
        with(NTTEFullEnergyBatSlash) if(array_get_index(_old_slashes,id)<0) _slash=id
        assert(instance_exists(_slash) && _slash.creator==_p && _slash.team==_p.team
            && _slash.image_yscale==1 && _p.wepangle==1 && _slash.damage==18 && _slash.force==12
            && _slash.friction==0 && _p.wkick==-4,
            "Actual Energy Bat still uses generic swing or lost source flip/force/post")
        _p.wep=wep_ntte_bubble_bat;_p.ntte_state=scrNTTENewState(_p.wep)
        var _old_bubbles=scrNTTEFullInstances(NTTEFullBubbleSlash),_bubble=noone
        with(_p) scrFire(wep,false)
        with(NTTEFullBubbleSlash) if(array_get_index(_old_bubbles,id)<0) _bubble=id
        assert(instance_exists(_bubble) && _bubble.creator==_p && _bubble.image_yscale==-1
            && _bubble.damage==16 && _bubble.force==12 && _bubble.friction==0,
            "Actual Bubble Bat retained generic 12-damage swing or lost alternating native flip")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);random_set_seed(_seed)
        global.ntte_full_progress=_progress;global.__debug_infammo=_debug
        assert(global.ntte_full_progress==_progress && json_stringify(global.ntte_full_progress)==_progressSerialized,
            "Disc fire fixture changed original progress identity or serialized contents")
    }
    scrNTTESmokeLog("FULL NATIVE DISC WEAPON FIRE: actual scrFire blade gun/cannon exact magazines/speed, infinite ammo, EnergyBat source class/flip/post OK @"+string(30/timescale))
}
