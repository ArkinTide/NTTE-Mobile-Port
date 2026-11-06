function scrNTTEFullMergedRuntimeTestShots(_list,_object) {
    var _out=[]
    for(var _i=0;_i<array_length(_list);++_i)
        if(instance_exists(_list[_i]) && instance_is(_list[_i],_object)) array_push(_out,_list[_i])
    return _out
}
function scrNTTEFullMergedRuntimeTestCleanup(_before) {
    var _all=scrNTTEFullInstances(all)
    for(var _i=array_length(_all)-1;_i>=0;--_i)
        if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
}
function scrNTTEFullMergedRuntimeTestFireRef(_at,_info) {
    _info.source=id;_info.caller=other.id;_at.direction_rotation+=20
}
function scrNTTEFullMergedRuntimeTestSetupRef(_token,_list,_info) {
    for(var _i=0;_i<array_length(_list);++_i) _list[_i].ntte_runtime_test_token=_token
}
function scrNTTEFullMergedRuntimeDispatchTests() {
    scrNTTEFullMergedCaptureSourceTests();

    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_tick=current_frame,
        _depth=variable_global_exists("ntte_full_merged_plain_depth") ? global.ntte_full_merged_plain_depth:0,
        _request=variable_global_exists("ntte_full_merged_request") ? global.ntte_full_merged_request:undefined
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    try {
        var _p=instance_find(Player,0)
        _p.x=51000;_p.y=51000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.hspeed=0;_p.vspeed=0;_p.gunangle=0;_p.accuracy=0;_p.race=Race.Fish
        _p.infammo=0;_p.ntte_race_ultra=0;_p.ntte_native_race=-1
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        UberCont.opt_shake=1;UberCont.opt_freeze=1;GameCont.temerge_effect_vars_map={}
        _p.wepangle=1;_p.wkick=0;_p.bwep=wep_wrench
        var _weapon=scrNTTEFullWeaponMerge(wep_shotgun,wep_revolver),_handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle;_p.ntte_state=scrNTTEFullWeaponNativeState(_handle)
        var _held_state=_p.ntte_state,_fired=false
        with(_p) _fired=scrFire(_handle,true)
        var _new=scrNTTEFullMergedRuntimeNew(_before),_bullets=scrNTTEFullMergedRuntimeTestShots(_new,Bullet1)
        assert(_fired && array_length(_bullets)==5 && array_length(scrNTTEFullMergedRuntimeTestShots(_new,Bullet2))==0
            && _p.ammo[Ammo.Bullets]==95 && _p.ammo[Ammo.Shells]==100 && _p.wep==_handle
            && _p.ntte_state==_held_state && _held_state.weapon==_handle,
            "Actual scrFire merged Shotgun/Revolver lost five-shot logarithmic replacements, manual cost, held handle or canonical state")
        for(var _i=0;_i<array_length(_bullets);++_i)
            assert(_bullets[_i].creator==_p && array_length(_bullets[_i].temerge_vars_list)==1,
                "Actual final native bullet lost creator or stock metadata deduplication")
        assert(_weapon.temerge.wep_fire_frame==current_frame && _weapon.temerge.fire_frame==current_frame,
            "Actual merged dispatch did not store root stock/front firing times")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Actual native Burst stock: its immediate shot and two later Alarm0
        // emissions share one replacement frame, with real live creator aim.
        // Native AssaultRifle costs3: source merged cost round(3^.795)=2,
        // cost interval3 pays only replacement1, while2/3 still emit freely.
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.x=51000;_p.y=51000;_p.gunangle=0
        _p.hspeed=0;_p.vspeed=0
        _weapon=scrNTTEFullWeaponMerge(wep_assault_rifle,wep_revolver)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _burst_result=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p}),_controllers=scrNTTEFullMergedRuntimeTestShots(_burst_result.shots,Burst)
        assert(array_length(_controllers)==1 && array_length(scrNTTEFullMergedRuntimeTestShots(_burst_result.shots,Bullet1))==1
            && _burst_result.frame.shot_replace_count==1 && !_burst_result.frame.shot_is_delayed,
            "Actual Burst stock failed its first immediate replacement/accounting frame")
        var _burst=_controllers[0]
        _p.x+=30;_p.y+=40;_p.gunangle=90;current_frame+=2
        with(_burst) event_perform(ev_alarm,0)
        current_frame+=2
        with(_burst) event_perform(ev_alarm,0)
        _new=scrNTTEFullMergedRuntimeNew(_before);_bullets=scrNTTEFullMergedRuntimeTestShots(_new,Bullet1)
        scrNTTESmokeLog("MERGED BURST DIAG count="+string(array_length(_bullets))+" replacements="+string(_burst_result.frame.shot_replace_count)
            +" ammo="+string(_p.ammo[Ammo.Bullets])+" xy="+string(_p.x)+","+string(_p.y)+" angle="+string(_p.gunangle)
            +" has="+string(_burst_result.frame.has_shot)+" stockTag="+string(variable_instance_exists(_burst,"ntte_merged_runtime_stock")))
        assert(array_length(_bullets)==3 && _burst_result.frame.shot_replace_count==3 && _p.ammo[Ammo.Bullets]==98
            && _burst_result.frame.ammo_cost==2 && _burst_result.frame.shot_replace_cost_interval==3
            && _p.x==51030 && _p.y==51040 && _p.gunangle==90,
            "Actual deferred stock Burst lost shared frame/manual costs, new bullets or creator restoration")
        var _last=_bullets[array_length(_bullets)-1]
        assert(abs(angle_difference(_last.direction,90))<0.001,
            "Actual deferred stock replacement ignored real creator's changed aim")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Front native Burst receives its stock ancestor on every later child.
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.gunangle=0;_p.hspeed=0;_p.vspeed=0
        _weapon=scrNTTEFullWeaponMerge(wep_heavy_revolver,wep_assault_rifle)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _heavy=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _controllers=scrNTTEFullMergedRuntimeTestShots(_heavy.shots,Burst)
        assert(array_length(_controllers)==1,"HeavyBullet→Burst inheritance fixture did not create its real deferred front")
        _bullets=scrNTTEFullMergedRuntimeTestShots(_heavy.shots,Bullet1)
        var _damage=_bullets[0].damage,_force=_bullets[0].knockback_speed,_merge=_bullets[0].temerge_vars_list[0]
        current_frame+=2;with(_controllers[0]) event_perform(ev_alarm,0)
        _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bullet1)
        assert(array_length(_bullets)==2 && _bullets[1].damage==_damage && _bullets[1].knockback_speed==_force
            && array_length(_bullets[1].temerge_vars_list)==1 && _bullets[1].temerge_vars_list[0]==_merge,
            "Actual front Burst later native projectile lost shared HeavyBullet setup/damage/force or applied it twice")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Nested stock recursion and cost suppression must charge once for the
        // final emission; the intermediate native bullet is always removed.
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);GameCont.rad=100
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_assault_rifle)
        scrNTTEFullWeaponMerge(_weapon,wep_revolver)
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _nested=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _controllers=scrNTTEFullMergedRuntimeTestShots(_nested.shots,Burst)
        assert(array_length(_controllers)==1 && array_length(scrNTTEFullMergedRuntimeTestShots(_nested.shots,Bullet1))==1
            && _p.ammo[Ammo.Bullets]==98,"Actual nested merge double-charged or left an intermediate projectile")
        current_frame+=2;with(_controllers[0]) event_perform(ev_alarm,0)
        current_frame+=2;with(_controllers[0]) event_perform(ev_alarm,0)
        _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bullet1)
        assert(array_length(_bullets)==3 && _p.ammo[Ammo.Bullets]==98
            && array_length(_bullets[2].temerge_vars_list)==2,
            "Actual nested deferred merge lost source ancestor/cost propagation")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Source EffectRef fire/setup callbacks retain shot self and creator
        // other; callback records are not silently skipped as non-callables.
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _weapon=scrNTTEFullMergedRuntimePart(scrNTTEFullWeaponMerge(wep_revolver,wep_revolver))
        _handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _frame=scrNTTEFullMergeFireFrame(_weapon,_p)
        scrNTTEFullMergeTransactionBegin(_p,_p,_frame)
        var _plain=scrNTTEFullMergedRuntimePlain(_p,_weapon,{creator:_p},true)
        scrNTTEFullMergeTransactionEnd(_frame)
        var _stock=scrNTTEFullMergedRuntimeTestShots(_plain.shots,Bullet1)[0]
        _stock.temerge_on_fire=scrNTTEFullMergedEffectRef(scrNTTEFullMergedRuntimeTestFireRef)
        _stock.temerge_on_setup=scrNTTEFullMergedEffectRef(scrNTTEFullMergedRuntimeTestSetupRef,[7])
        with(_p) scrNTTEFullMergedRuntimeReplace([_stock],_frame,{x:x,y:y,direction:gunangle},accuracy,[],true)
        _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bullet1)
        var _info=_bullets[0].temerge_vars_list[0].setup_vars
        assert(array_length(_bullets)==1 && _info.source==_stock && _info.caller==_p
            && _bullets[0].ntte_runtime_test_token==7 && abs(angle_difference(_bullets[0].direction,20))<0.001,
            "Actual merged callback refs lost self/other, bound args, setup container or fire geometry mutation")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Beetle UltraB guaranteed1:1 cost retention. The retained stock is
        // genuinely native, unattributed and offset perpendicular to its front.
        _p.race=NTTEFullRace.Beetle;_p.ntte_race_ultra=2;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_revolver);_handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _ultra=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        _bullets=scrNTTEFullMergedRuntimeTestShots(_ultra.shots,Bullet1)
        var _kept=noone,_front=noone
        for(var _i=0;_i<array_length(_bullets);++_i) {
            if(_bullets[_i].creator==noone) _kept=_bullets[_i]
            else if(_bullets[_i].creator==_p) _front=_bullets[_i]
        }
        assert(array_length(_bullets)==2 && instance_exists(_kept) && instance_exists(_front)
            && !_kept.temerge_can_setup && abs(angle_difference(_kept.direction,_front.direction))==90
            && _p.ammo[Ammo.Bullets]==99,"Actual Beetle UltraB lost raw cost probability, retained stock identity, direction or source ownership rules")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.race=Race.Fish;_p.ntte_race_ultra=0
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,0);GameCont.rad=0
        _weapon=scrNTTEFullWeaponMerge(wep_grenade_launcher,wep_revolver);_handle=scrNTTEFullWeaponNative(_weapon);_p.wep=_handle
        var _explosions=instance_number(Explosion),_failure=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p})
        assert(!_failure.has_shot && array_length(scrNTTEFullMergedRuntimeProjectiles(_failure.shots))==0
            && instance_number(Explosion)==_explosions && UberCont.opt_shake==1,
            "Actual merged ammo failure left stock projectiles, fired a grenade Destroy or leaked temporary stock options")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Disabled merge is still an installable native handle and must retain
        // ordinary raw native ammo consumption when scrFire asks to consume.
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        scrNTTEFullWeaponMergeActive(_weapon,false)
        _p.wep=_handle
        with(_p) scrFire(_handle,true)
        _new=scrNTTEFullMergedRuntimeNew(_before)
        assert(array_length(scrNTTEFullMergedRuntimeTestShots(_new,Grenade))==1 && _p.ammo[Ammo.Explosives]==99,
            "Inactive merged native handle did not retain ordinary raw grenade firing/ammo cost")
        assert(global.ntte_full_merged_plain_depth==_depth && is_undefined(global.ntte_full_merged_request),
            "Actual dispatcher leaked plain-firing recursion scope or non-Player request")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models
        global.ntte_full_merged_plain_depth=_depth;global.ntte_full_merged_request=_request
        current_frame=_tick;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED RUNTIME DISPATCH: actual scrFire logarithmic Shotgun/front costs/native handles+states, actual stock and front Burst/deferred/nested ancestor accounting+effects, EffectRef contexts, Beetle UltraB native retention, ammo-failure no-Destruct and inactive native consumption OK @"+string(30/timescale))
}

function scrNTTEFullMergedRuntimeDifferenceOldTest(_before,_after) {
    var _out=[]
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0) array_push(_out,_after[_i])
    return _out
}
function scrNTTEFullMergedRuntimeDifferenceTests() {
    var _ref=instance_find(Player,0),_seed=random_get_seed(),_cases=[
        [[],[]],[[],[3,1,3]],[[2,1,2],[1,3,2,3,5]],
        [[_ref],[real(_ref),_ref,22,22]],[[real(_ref)],[_ref,real(_ref),22]],
        [[-1,0,999999999999],[999999999999,2,0,-1,2]]]
    for(var _c=0;_c<array_length(_cases);++_c) {
        var _case=_cases[_c],_old=scrNTTEFullMergedRuntimeDifferenceOldTest(_case[0],_case[1]),_new=scrNTTEFullMergedRuntimeDifference(_case[0],_case[1])
        assert(array_length(_old)==array_length(_new),"Difference count changed")
        for(var _i=0;_i<array_length(_old);++_i) assert(_old[_i]==_new[_i] && typeof(_old[_i])==typeof(_new[_i]),"Difference changed order/duplicate/ref type")
    }
    var _before=[],_after=[],_old=[],_new=[],_sink=0
    for(var _i=0;_i<2048;++_i) {array_push(_before,100000+_i);array_push(_after,100000+_i)}
    array_push(_after,200010,200020,200010)
    for(var _trial=0;_trial<5;++_trial) {
        var _start=get_timer()
        repeat(8) _sink+=array_length(scrNTTEFullMergedRuntimeDifferenceOldTest(_before,_after))
        array_push(_old,get_timer()-_start);_start=get_timer()
        repeat(8) _sink+=array_length(scrNTTEFullMergedRuntimeDifference(_before,_after))
        array_push(_new,get_timer()-_start)
    }
    array_sort(_old,true);array_sort(_new,true)
    assert(_new[2]<_old[2],"Difference did not improve large-world CPU cost")
    assert(random_get_seed()==_seed,"Difference consumed RNG")
    scrNTTESmokeLog("MERGED DIFFERENCE "+json_stringify({before_count:2048,old_median_us:_old[2],new_median_us:_new[2],ratio:_new[2]/max(1,_old[2]),mobile_device_tested:false,sink:_sink}))
}

// Test-only marker instances, not production capture machinery.
function scrNTTEFullMergedCaptureFixtureNew() {
    return instance_create(300000,300000,NTTEFullOutlineDrawDebrisProbe)
}
function scrNTTEFullMergedCaptureFixtureEqual(_a,_b) {
    if(array_length(_a)!=array_length(_b)) return false
    for(var _i=0;_i<array_length(_a);++_i)
        if(_a[_i]!=_b[_i] || typeof(_a[_i])!=typeof(_b[_i])) return false
    return true
}

// Independent source oracle: numeric creation-ID interval, no port snapshots
// and no candidate helper inside the oracle. Source instance_max uses a
// marker; these eventless fixtures keep marker creation out of production.
function scrNTTEFullMergedCaptureSourceRange(_min,_max) {
    var _out=[]
    for(var _number=real(_min)+1;_number<real(_max);++_number)
        with(_number) array_push(_out,id)
    return _out
}
function scrNTTEFullMergedCaptureSourceAssert(_token,_min,_label) {
    var _seed=random_get_seed(),_streams=json_stringify(global.rng_state),
        _self=id,_other=other.id,_count=instance_number(all),_actual=scrNTTEFullMergedCaptureEnd(_token),
        _marker=scrNTTEFullMergedCaptureFixtureNew(),_expected=scrNTTEFullMergedCaptureSourceRange(_min,_marker)
    assert(scrNTTEFullMergedCaptureFixtureEqual(_actual,_expected),"Source birth capture order/type mismatch: "+_label)
    assert(random_get_seed()==_seed && json_stringify(global.rng_state)==_streams,"Source capture changed RNG: "+_label)
    assert(id==_self && other.id==_other,"Source capture leaked event context: "+_label)
    assert(instance_number(all)==_count+1,"Capture created extra entities: "+_label)
    instance_destroy(_marker,false)
    scrNTTESmokeLog("PASS source birth capture "+_label+" count="+string(array_length(_actual))+" @"+string(30/timescale))
}
function scrNTTEFullMergedCaptureSourceTests() {
    var _rng=random_get_seed(),_streams=json_stringify(global.rng_state),_created=[],
        _before=scrNTTEFullInstanceEnumerationOld(all),_old=scrNTTEFullMergedCaptureFixtureNew()
    array_push(_created,_old)
    try {
        for(var _case=0;_case<10;++_case) {
            instance_activate_object(_old)
            // An older inactive actor with a high ID must never count as born.
            if(_case==6) instance_deactivate_object(_old)
            var _min=scrNTTEFullMergedCaptureFixtureNew(),_token=scrNTTEFullMergedCaptureBegin()
            array_push(_created,_min)
            switch(_case) {
                case 0: repeat(8) array_push(_created,scrNTTEFullMergedCaptureFixtureNew());break
                case 1:
                    instance_destroy(_old,false)
                    _old=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_old)
                    break
                case 2:
                    var _gone=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_gone)
                    instance_destroy(_gone,false)
                    array_push(_created,scrNTTEFullMergedCaptureFixtureNew())
                    break
                case 3:
                    var _parent=instance_create(300000,300000,NTTEFullMergedCaptureLifecycleProbe)
                    array_push(_created,_parent)
                    var _sink={child:noone}
                    _parent.capture_sink=_sink;_parent.spawn_on_destroy=true
                    instance_destroy(_parent)
                    if(instance_exists(_sink.child)) array_push(_created,_sink.child)
                    break
                case 4:
                    var _hidden=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_hidden)
                    instance_deactivate_object(_hidden);instance_activate_object(_hidden)
                    break
                case 5:
                    var _hidden=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_hidden)
                    instance_deactivate_object(_hidden)
                    break
                case 6:
                    instance_activate_object(_old)
                    array_push(_created,scrNTTEFullMergedCaptureFixtureNew())
                    break
                case 7:
                    var _inner=scrNTTEFullMergedCaptureBegin()
                    var _new=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_new)
                    var _inside=scrNTTEFullMergedCaptureEnd(_inner)
                    assert(array_length(_inside)==1 && _inside[0]==_new,"Nested source capture changed newborn ref")
                    array_push(_created,scrNTTEFullMergedCaptureFixtureNew())
                    break
                case 8:
                    var _parent=instance_create(300000,300000,NTTEFullMergedCaptureLifecycleProbe)
                    array_push(_created,_parent)
                    with(_parent) event_user(0)
                    array_push(_created,_parent.ntte_child)
                    break
                case 9:
                    var _gone=scrNTTEFullMergedCaptureFixtureNew();array_push(_created,_gone)
                    with(_gone) {instance_destroy();array_push(_created,scrNTTEFullMergedCaptureFixtureNew())}
                    break
            }
            scrNTTEFullMergedCaptureSourceAssert(_token,_min,"lifecycle-"+string(_case))
        }
    }
    finally {
        for(var _i=0;_i<array_length(_created);++_i) {
            instance_activate_object(_created[_i])
            if(instance_exists(_created[_i])) instance_destroy(_created[_i],false)
        }
    }
    assert(random_get_seed()==_rng && json_stringify(global.rng_state)==_streams,"Birth capture fixtures changed RNG")
    assert(scrNTTEFullMergedCaptureFixtureEqual(_before,scrNTTEFullInstanceEnumerationOld(all)),"Birth capture fixtures changed old ordered actors")
    scrNTTESmokeLog("PASS source-faithful synchronous birth capture lifetime/order/type/context @"+string(30/timescale))
}
