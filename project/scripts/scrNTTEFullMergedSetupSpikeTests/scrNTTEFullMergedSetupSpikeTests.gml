function scrNTTEFullMergedSetupSpikeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Setup spike regression needs explicit desktop smoke")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _seed=random_get_seed(),_frame=current_frame,
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _scan=variable_global_exists("ntte_full_merge_copy_scan_observer")?global.ntte_full_merge_copy_scan_observer:undefined,
        _copy_legacy=variable_global_exists("ntte_full_merge_copy_legacy_smoke")?global.ntte_full_merge_copy_legacy_smoke:false,
        _sound=variable_global_exists("ntte_full_merged_basic_sound_observer")?global.ntte_full_merged_basic_sound_observer:undefined,
        _test=variable_global_exists("ntte_full_merge_setup_test")?global.ntte_full_merge_setup_test:undefined,
        _mode=variable_global_exists("ntte_merge_native_collision_mode")?global.ntte_merge_native_collision_mode:false,
        _depth=variable_global_exists("ntte_full_merged_plain_depth")?global.ntte_full_merged_plain_depth:0,
        _request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined,
        _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
        _infammo=global.__debug_infammo,
        _results=[]
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_merge_native_collision_mode=true
    global.ntte_full_merge_setup_test={copy_now:false,copy:noone,reentered:0}
    try {
        scrNTTEFullMergedEffectsInit()
        var _owner=instance_find(Player,0)
        // Parentless, eventless unrelated objects model a dense room without
        // adding projectile behavior, RNG, sounds, or scheduler side effects.
        repeat(2048) instance_create(76000,76000,NTTEFullMergedSetupProbe)
        scrNTTEFullMergedEffectAddEvent("test_setup_spike","setup",function(_list) {
            scrNTTEFullMergedFlameSetup(_list)
            scrNTTEFullMergedPlasmaSetup(_list,0.5)
            scrNTTEFullMergedExplosionSetup(_list,{is_blood:true},2)
            for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) {
                ntte_setup_random=random(1)
                scrNTTEFullMergedBasicSoundAt(x,y,sndToxicBoltGas,0.7+random(0.1),0.3,320)
            }
        })
        for(var _legacy=1;_legacy>=0;--_legacy) {
            // The frozen old setup oracle must also select the old full-world
            // discovery; production now indexes copies independently.
            global.ntte_full_merge_copy_legacy_smoke=(_legacy==1)
            GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            global.ntte_full_merge_copy_scan_observer=[];global.ntte_full_merged_basic_sound_observer=[]
            var _p=instance_create(76200,76000,Bullet1)
            _p.team=team_player;_p.creator=_owner;_p.speed=0;_p.direction=17
            _p.damage=3;_p.knockback_speed=7*timescale;_p.ntte_setup_random=-1
            random_set_seed(621487)
            var _time=get_timer(),_out=[]
            repeat(16) {
                _out=_legacy?scrNTTEFullMergedSetupLegacyAddEffect(_p,"test_setup_spike")
                    :scrNTTEFullMergedProjectileAddEffect(_p,"test_setup_spike")
                assert(array_length(_out)==1 && _out[0]==_p,"Setup A/B replaced the explicit projectile input")
            }
            _time=get_timer()-_time
            var _visits=0
            for(var _s=0;_s<array_length(global.ntte_full_merge_copy_scan_observer);++_s)
                _visits+=global.ntte_full_merge_copy_scan_observer[_s].count
            var _state=[_p.object_index,_p.damage,_p.knockback_speed,_p.team,_p.speed,_p.direction,
                _p.temerge_flame.amount,_p.temerge_plasma.extra_amount,array_length(_p.temerge_explosion_list),
                _p.temerge_explosion_list[0].is_blood,_p.temerge_explosion_list[0]==_p.temerge_explosion_list[1],
                array_length(_p.temerge_destroy_event_ref_list),_p.ntte_setup_random,random(1),
                scrNTTEFullMergedProjectileHasEffect(_p,"test_setup_spike"),
                array_length(scrNTTEFullMergedEffectVars("destroy_event").destroy_event_vars_list)]
            array_push(_results,{state:json_stringify(_state),sound:json_stringify(global.ntte_full_merged_basic_sound_observer),
                scans:array_length(global.ntte_full_merge_copy_scan_observer),visits:_visits,time_us:_time})
            instance_destroy(_p,false)
        }
        global.ntte_full_merge_copy_legacy_smoke=false
        assert(_results[0].state==_results[1].state && _results[0].sound==_results[1].sound,
            "Setup scan removal changed actual flame/plasma/explosion callbacks, aliases, sound calls or RNG")
        assert(_results[0].scans==16 && _results[0].visits>=2048*16 && _results[1].scans==0 && _results[1].visits==0,
            "Dense-room setup did not remove precisely the old per-invocation full-world scans")
        // User's actual combination: Super Crossbow(stock12) feeding Golden
        // Crossbow(front43). The native Super Crossbow emits FIVE bolts here.
        // Keep the same dense unrelated room while using real Runtime fire.
        _owner.x=76600;_owner.y=76000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
        _owner.hspeed=0;_owner.vspeed=0;_owner.gunangle=0;_owner.accuracy=0;_owner.race=Race.Fish
        _owner.infammo=0;_owner.ntte_race_ultra=0;_owner.ntte_native_race=-1
        _owner.ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);_owner.wepangle=1;_owner.wkick=0
        UberCont.opt_shake=1;UberCont.opt_freeze=1;global.__debug_infammo=false
        global.ntte_full_merged_plain_depth=0;global.ntte_full_merged_request=undefined;global.ntte_full_merged_input_weapon=undefined
        GameCont.rad=100;GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
        var _weapon=scrNTTEFullWeaponMerge(wep_super_crossbow,wep_golden_crossbow),
            _handle=scrNTTEFullWeaponNative(_weapon),_cost=-1,_runtime_total=0
        _owner.wep=_handle;_owner.bwep=wep_none;_owner.ntte_state=scrNTTEFullWeaponNativeState(_handle)
        for(var _shot_index=0;_shot_index<12;++_shot_index) {
            var _local_before=scrNTTEFullInstances(all),_ammo=_owner.ammo[Ammo.Bolts]
            global.ntte_full_merge_copy_scan_observer=[]
            current_frame+=120
            var _fire_start=get_timer(),_fired=false
            with(_owner) _fired=scrFire(_handle,true)
            var _bolts=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local_before),Bolt)
            _runtime_total+=get_timer()-_fire_start
            assert(_fired && array_length(_bolts)==5 && array_length(global.ntte_full_merge_copy_scan_observer)==0,
                "Actual Super Golden Crossbow failed its five replacements or still scanned the full world in setup")
            for(var _b=0;_b<array_length(_bolts);++_b) {
                var _bolt=_bolts[_b]
                assert(_bolt.creator==_owner && _bolt.team==_owner.team && _bolt.sprite_index==sprBoltGold
                    && array_length(_bolt.temerge_vars_list)==1
                    && scrNTTEFullMergedProjectileHasEffect(_bolt,"piercing")
                    && scrNTTEFullMergedProjectileHasEffect(_bolt,"trail"),
                    "Actual Super Golden Crossbow lost native golden visuals, ownership or inherited Bolt effects")
            }
            var _spent=_ammo-_owner.ammo[Ammo.Bolts]
            if(_cost<0) _cost=_spent
            assert(_spent==_cost && _spent>0 && _owner.wep==_handle,
                "Repeated actual merged crossbow firing lost consistent real ammo or held inventory")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
        }
        // Source membership is deliberately an empty registration buffer while
        // a callback runs. Copying an already tagged source there must retain
        // the non-setup discovery fallback, including across another effect.
        GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
        scrNTTEFullMergedEffectAddEvent("test_copy_a","setup",function(_list) {
            if(!global.ntte_full_merge_setup_test.copy_now) return;
            global.ntte_full_merge_setup_test.copy_now=false
            var _source=_list[0],_copy=noone
            assert(!scrNTTEFullMergedProjectileHasEffect(_source,"test_copy_a"),"Active callback membership buffer changed")
            with(_source) _copy=scrNTTEFullMergedNativeCopy(false)
            global.ntte_full_merge_setup_test.copy=_copy
            // Nested registration must append through the normal buffer, while
            // keeping the current effect's copy pending until a later event.
            scrNTTEFullMergedProjectileAddEffect(_copy,"test_copy_b")
            global.ntte_full_merge_setup_test.reentered++
        })
        var _noop=function(_list) {}
        scrNTTEFullMergedEffectAddEvent("test_copy_a","step",_noop)
        scrNTTEFullMergedEffectAddEvent("test_copy_b","step",_noop)
        var _source=instance_create(76400,76000,Bullet1)
        _source.team=team_player;_source.creator=_owner;_source.speed=0
        scrNTTEFullMergedProjectileAddEffect(_source,"test_copy_a")
        scrNTTEFullMergedProjectileAddEffect(_source,"test_copy_b")
        global.ntte_full_merge_setup_test.copy_now=true
        scrNTTEFullMergedProjectileAddEffect(_source,"test_copy_a")
        var _copy=global.ntte_full_merge_setup_test.copy
        assert(instance_exists(_copy) && !scrNTTEFullMergedProjectileHasEffect(_copy,"test_copy_a")
            && scrNTTEFullMergedProjectileHasEffect(_copy,"test_copy_b")
            && _copy.temerge_test_copy_a_instance==_source && global.ntte_full_merge_setup_test.reentered==1,
            "Copy-in-active-callback did not exercise the source empty-buffer/multi-effect registration case")
        scrNTTEFullMergedEffectCallEvent("test_copy_a","step")
        assert(scrNTTEFullMergedProjectileHasEffect(_copy,"test_copy_a") && _copy.temerge_test_copy_a_instance==_copy,
            "Non-setup discovery stopped recovering callback-created copies")
        var _grand=noone,_invalid=noone
        with(_copy) _grand=scrNTTEFullMergedNativeCopy(false)
        with(_source) _invalid=scrNTTEFullMergedNativeCopy(false)
        instance_destroy(_invalid,false)
        scrNTTEFullMergedEffectCallEvent("test_copy_a","step")
        scrNTTEFullMergedEffectCallEvent("test_copy_b","step")
        assert(scrNTTEFullMergedProjectileHasEffect(_grand,"test_copy_a")
            && scrNTTEFullMergedProjectileHasEffect(_grand,"test_copy_b")
            && !scrNTTEFullMergedProjectileHasEffect(_invalid,"test_copy_a")
            && !scrNTTEFullMergedProjectileHasEffect(_invalid,"test_copy_b"),
            "Ordinary chained multi-effect copies or dead-copy pruning regressed")
        scrNTTESmokeLog("FULL MERGED SETUP SPIKE dense unrelated2048 old/new explicit input+real flame/plasma/explosion+alias/sound/RNG equivalence +callback reentry/multieffect copy fallback/dead pruning OK @"
            +string(30/timescale)+"; oldScans="+string(_results[0].scans)+" oldVisits="+string(_results[0].visits)
            +" newScans="+string(_results[1].scans)+" old_us="+string(_results[0].time_us)+" new_us="+string(_results[1].time_us)
            +" SuperGoldenCrossbow=12x5 RuntimeShots total_us="+string(_runtime_total)+" ammoPerShot="+string(_cost)
            +"; setup spike scope, nonsetup fallback retained, mobile device not tested")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_full_merge_copy_scan_observer=_scan;global.ntte_full_merged_basic_sound_observer=_sound
        global.ntte_full_merge_copy_legacy_smoke=_copy_legacy
        global.ntte_full_merge_setup_test=_test;global.ntte_merge_native_collision_mode=_mode
        global.ntte_full_merged_plain_depth=_depth;global.ntte_full_merged_request=_request
        global.ntte_full_merged_input_weapon=_input;global.__debug_infammo=_infammo
        global.ntte_full_native_weapon_models=_models
        current_frame=_frame;random_set_seed(_seed)
    }
}

// Frozen old unconditional setup-scan path; all effect bodies remain real.
function scrNTTEFullMergedSetupLegacyCallEvent(_name,_event,_args=undefined) {
    scrNTTEFullMergedEffectsInit()
    var _vars=scrNTTEFullMergedEffectVars(_name)
    if(is_undefined(_vars)) return;
    scrNTTEFullMergedEffectsDiscoverCopies(_name)
    var _instances=scrNTTEFullMergedEffectsLive(_vars.instance_list)
    if(!array_length(_instances)) {
        // Dead snapshots still need replay before the empty scheduler unbinds.
        scrNTTEFullMergedEffectsReplayDestroy(_vars)
        var _scheduler=scrNTTEFullValue(_vars.event_instance_map,_event,noone)
        if(_scheduler==id) { variable_struct_set(_vars.event_instance_map,_event,noone);instance_destroy(id,false) }
        _vars.instance_list=[]
        return;
    }
    var _tagged=[]
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _p=_instances[_i]
        if(is_undefined(scrNTTEFullValue(_p,"temerge_event_last_team",undefined))) {
            _p.temerge_event_last_team=_p.team;_p.team=round(_p.team);array_push(_tagged,_p)
        }
    }
    var _registry=scrNTTEFullValue(global.ntte_full_merge_effect_registry,_name,undefined),_callbacks=[]
    if(is_struct(_registry)) _callbacks=scrNTTEFullValue(_registry.events,_event,[])
    for(var _i=0;_i<array_length(_callbacks);++_i) {
        _vars.instance_list=[]
        var _call_args=[_instances]
        if(is_array(_args)) for(var _a=0;_a<array_length(_args);++_a) array_push(_call_args,_args[_a])
        var _new=scrNTTEFullMergedEffectsCall(id,id,_callbacks[_i],_call_args)
        if(is_array(_new)) _instances=_new
        else if(!is_undefined(_new) && _new!=0) throw "Merged effect returned a non-array instance list"
        for(var _a=0;_a<array_length(_vars.instance_list);++_a) array_push(_instances,_vars.instance_list[_a])
        _instances=scrNTTEFullMergedEffectsLive(_instances);_vars.instance_list=_instances
    }
    for(var _i=0;_i<array_length(_tagged);++_i) if(instance_exists(_tagged[_i])) {
        var _p=_tagged[_i],_last=scrNTTEFullValue(_p,"temerge_event_last_team",undefined)
        if(!is_undefined(_last)) {
            // Preserve the literal original condition; do not invent restoring
            // a rounded tag after an effect intentionally changes faction.
            if(_p.team==_last) _p.team=_last
            _p.temerge_event_last_team=undefined
        }
    }
    _vars.instance_list=_instances
    if(_event=="draw" && scrNTTEFullValue(_vars.event_instance_map,_event,noone)==id) {
        for(var _i=0;_i<array_length(_instances);++_i) if(_instances[_i].depth<depth+1) depth=min(depth,_instances[_i].depth-1)
    }
    scrNTTEFullMergedEffectsReplayDestroy(_vars)
}
function scrNTTEFullMergedSetupLegacyAddEffect(_input,_name,_setup_args=undefined) {
    scrNTTEFullMergedEffectsInit()
    var _vars=scrNTTEFullMergedEffectVars(_name,true),_instances=scrNTTEFullMergedEffectsList(_input),
        _entry=scrNTTEFullValue(global.ntte_full_merge_effect_registry,_name,undefined)
    if(!is_struct(_entry)) throw "Original merged effect is not implemented: "+_name
    if(is_struct(_entry)) for(var _i=0;_i<array_length(_entry.event_order);++_i) {
        var _event=_entry.event_order[_i]
        if(_event=="setup") {
            var _saved=_vars.instance_list
            _vars.instance_list=_instances;scrNTTEFullMergedSetupLegacyCallEvent(_name,_event,_setup_args)
            _instances=_vars.instance_list;_vars.instance_list=_saved
        }
        else scrNTTEFullMergedEffectScheduler(_name,_event,_instances)
    }
    _vars.instance_list=scrNTTEFullMergedEffectsLive(_vars.instance_list)
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _p=_instances[_i]
        if(!instance_exists(_p) || array_get_index(_vars.instance_list,_p)>=0) continue
        array_push(_vars.instance_list,_p)
        var _tag="temerge_"+_name+"_instance"
        if(!variable_instance_exists(_p,_tag)) variable_instance_set(_p,_tag,_p)
        if(_name=="destroy_event" && !variable_instance_exists(_p,"temerge_destroy_event_vars")) scrNTTEFullMergedEffectsStoreDestroy(_vars,_p)
    }
    return _instances
}

// Dense-room old/fullscan vs indexed-copy replay, plus the reported real weapon.
function scrNTTEFullMergedCopyIndexNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _scan=variable_global_exists("ntte_full_merge_copy_scan_observer")?global.ntte_full_merge_copy_scan_observer:undefined,
        _legacy=variable_global_exists("ntte_full_merge_copy_legacy_smoke")?global.ntte_full_merge_copy_legacy_smoke:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode")?global.ntte_merge_native_collision_mode:false,
        _test=variable_global_exists("ntte_copy_index_test")?global.ntte_copy_index_test:undefined,
        _depth=variable_global_exists("ntte_full_merged_plain_depth")?global.ntte_full_merged_plain_depth:0,
        _request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined,
        _input=variable_global_exists("ntte_full_merged_input_weapon")?global.ntte_full_merged_input_weapon:undefined,
        _sound=variable_global_exists("ntte_full_merged_basic_sound_observer")?global.ntte_full_merged_basic_sound_observer:undefined,
        _infammo=global.__debug_infammo,_results=[],_weapons=[]
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    try {
        repeat(2048) instance_create(78100,78000,NTTEFullMergedSetupProbe)
        var _dense=scrNTTEFullInstances(all),_owner=instance_find(Player,0)
        for(var _impl=0;_impl<2;++_impl) {
            global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
            global.ntte_merge_native_collision_mode=false
            global.ntte_full_merge_copy_legacy_smoke=(_impl==0)
            GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            global.ntte_copy_index_test={copy_now:true,created:[],trace:[]}
            global.ntte_full_merge_copy_scan_observer=[]
            scrNTTEFullMergedEffectsInit()
            scrNTTEFullMergedEffectAddEvent("test_copy_index","step",function(_list) {
                var _state=global.ntte_copy_index_test
                for(var _i=0;_i<array_length(_list);++_i)
                    array_push(_state.trace,[_list[_i].ntte_copy_label,random(1)])
                if(!_state.copy_now) return;
                _state.copy_now=false
                var _copy=noone,_grand=noone,_dead=noone
                with(_list[0]) _copy=scrNTTEFullMergedNativeCopy(false)
                _copy.ntte_copy_label=2
                with(_copy) _grand=scrNTTEFullMergedNativeCopy(false)
                _grand.ntte_copy_label=3
                with(_list[0]) _dead=scrNTTEFullMergedNativeCopy(false)
                _dead.ntte_copy_label=4;instance_destroy(_dead,false)
                _state.created=[_copy,_grand,_dead]
            })
            scrNTTEFullMergedEffectAddEvent("test_copy_index_other","step",function(_list) {})
            var _p=instance_create(78400,78000,Bullet1)
            _p.ntte_copy_label=1;_p.team=team_player;_p.creator=_owner;_p.speed=0
            scrNTTEFullMergedProjectileAddEffect(_p,"test_copy_index")
            scrNTTEFullMergedProjectileAddEffect(_p,"test_copy_index_other")
            random_set_seed(652801)
            scrNTTEFullMergedEffectCallEvent("test_copy_index","step")
            var _created=global.ntte_copy_index_test.created,_vars=scrNTTEFullMergedEffectVars("test_copy_index")
            assert(array_length(_vars.instance_list)==1
                && !scrNTTEFullMergedProjectileHasEffect(_created[0],"test_copy_index")
                && scrNTTEFullMergedProjectileHasEffect(_created[0],"test_copy_index_other"),
                "Copy index changed source empty-callback-buffer timing or other-effect immediate registration")
            // Deliberately reverse pending order: discovery must recover the
            // same instance_find order as the legacy full-world enumeration.
            _vars.ntte_copy_pending=[_created[2],_created[1],_created[0]]
            scrNTTEFullMergedEffectCallEvent("test_copy_index","step")
            var _all=scrNTTEFullInstances(all),_ordered=[]
            for(var _i=0;_i<array_length(_all);++_i) if(_all[_i]==_p || array_get_index(_created,_all[_i])>=0)
                array_push(_ordered,_all[_i].ntte_copy_label)
            var _registered=[]
            for(var _i=0;_i<array_length(_vars.instance_list);++_i) array_push(_registered,_vars.instance_list[_i].ntte_copy_label)
            assert(json_stringify(_registered)==json_stringify(_ordered) && array_length(_registered)==3,
                "Indexed copy order differs from native instance_find after chained copy/deletion")
            assert(!scrNTTEFullMergedProjectileHasEffect(_created[2],"test_copy_index"),"Dead pending copy registered")
            assert(!array_length(_vars.ntte_copy_pending),"Finished discovery retained registered/dead pending copies")
            var _visits=0
            for(var _i=0;_i<array_length(global.ntte_full_merge_copy_scan_observer);++_i)
                _visits+=global.ntte_full_merge_copy_scan_observer[_i].count
            array_push(_results,{state:json_stringify([global.ntte_copy_index_test.trace,_registered,random(1)]),visits:_visits})
            scrNTTEFullMergedRuntimeTestCleanup(_dense)
        }
        assert(_results[0].state==_results[1].state && _results[0].visits>=4096 && _results[1].visits<=3,
            "Pending-copy index changed callback order/RNG or retained full-room visits")
        // Reported weapons in both assembly directions: source/front order
        // changes the original replacement quantities and native objects.
        // Fire repeatedly, then execute the actual grouped non-setup callbacks
        // which run in the same rendered interval after each shot.
        for(var _direction=0;_direction<2;++_direction) for(var _impl=0;_impl<2;++_impl) {
            global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
            GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            global.ntte_merge_native_collision_mode=false
            global.ntte_full_merge_copy_legacy_smoke=(_impl==0)
            global.ntte_full_merge_copy_scan_observer=[];global.ntte_full_merged_basic_sound_observer=[]
            global.ntte_full_merged_plain_depth=0;global.ntte_full_merged_request=undefined;global.ntte_full_merged_input_weapon=undefined
            global.__debug_infammo=false;global.ntte_full_native_weapon_models=scrNTTEFullArrayCopy(_models)
            _owner.x=78600;_owner.y=78000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
            _owner.hspeed=0;_owner.vspeed=0;_owner.gunangle=0;_owner.accuracy=0;_owner.race=Race.Fish
            _owner.infammo=0;_owner.ntte_race_ultra=0;_owner.ntte_native_race=-1
            _owner.ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);_owner.wepangle=1;_owner.wkick=0;_owner.bwep=wep_none;_owner.reload=0
            // Both implementations start at the exact same shared grenade
            // clock. Subtracting different accumulated clocks can otherwise
            // produce different floating-point rounding in identical fuses.
            GameCont.temerge_grenade_frame=0
            GameCont.rad=100;UberCont.opt_shake=1;UberCont.opt_freeze=1
            random_set_seed(421670);global.rng_state=scrNTTEFullArrayCopy(_streams);current_frame=_frame
            var _weapon=_direction==0?scrNTTEFullWeaponMerge(wep_grenade_launcher,wep_shotgun):scrNTTEFullWeaponMerge(wep_shotgun,wep_grenade_launcher),
                _handle=scrNTTEFullWeaponNative(_weapon),
                _rows=[],_time=0
            _owner.wep=_handle;_owner.ntte_state=scrNTTEFullWeaponNativeState(_handle)
            for(var _shot=0;_shot<12;++_shot) {
                var _local=scrNTTEFullInstances(all)
                current_frame+=120
                var _start=get_timer(),_fired=false
                with(_owner) _fired=scrFire(_handle,true)
                var _shells=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local),_direction==0?Bullet2:Grenade)
                // scrFire's native Shotgun front emits seven pellets. The
                // stock Grenade contributes one replacement trigger, so no
                // stock-pellet logarithmic reduction applies to this front.
                if(_direction==0) assert(_fired && array_length(_shells)==7,"Actual Grenade Launcher / Shotgun lost seven native front pellets")
                // Reverse direction uses seven native stock candidates;
                // source logarithmic replacement accepts five Grenades.
                else assert(_fired && array_length(_shells)==5,"Actual Shotgun / Grenade Launcher lost five logarithmic replacements")
                var _map=GameCont.temerge_effect_vars_map,_names=variable_struct_get_names(_map)
                for(var _phase=0;_phase<3;++_phase) {
                    var _event=["begin_step","step","end_step"][_phase]
                    for(var _e=0;_e<array_length(_names);++_e) {
                        var _vars=_map[$ _names[_e]],_scheduler=scrNTTEFullValue(_vars.event_instance_map,_event,noone)
                        if(instance_exists(_scheduler)) with(_scheduler) scrNTTEFullMergedEffectCallEvent(ntte_effect_name,ntte_effect_event)
                    }
                }
                _time+=get_timer()-_start
                var _shot_rows=[]
                for(var _b=0;_b<array_length(_shells);++_b) {
                    var _pellet=_shells[_b]
                    assert(instance_exists(_pellet) && _pellet.creator==_owner && _pellet.team==_owner.team,
                        "Actual native front lost ownership or faction")
                    if(_direction==0) assert(scrNTTEFullMergedProjectileHasEffect(_pellet,"grenade")
                        && array_length(_pellet.temerge_explosion_list)==1,"Actual grenade pellet lost timer or explosion payload")
                    var _payload=_direction==0?[_pellet.temerge_grenade_frame-GameCont.temerge_grenade_frame,
                        _pellet.temerge_explosion_list[0].is_small,_pellet.temerge_explosion_list[0].is_blood]:[_pellet.alarm[0]]
                    array_push(_shot_rows,[_pellet.x,_pellet.y,_pellet.speed,_pellet.direction,_pellet.damage,_pellet.knockback_speed,
                        _pellet.sprite_index,_payload])
                }
                array_push(_rows,[_shot_rows,_owner.ammo,_owner.reload,_owner.wkick,_owner.hspeed,_owner.vspeed,GameCont.rad])
                scrNTTEFullMergedRuntimeTestCleanup(_local)
                GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            }
            var _visits=0
            for(var _i=0;_i<array_length(global.ntte_full_merge_copy_scan_observer);++_i)
                _visits+=global.ntte_full_merge_copy_scan_observer[_i].count
            array_push(_weapons,{rows:json_stringify(_rows),seed:random_get_seed(),streams:json_stringify(global.rng_state),
                sounds:json_stringify(global.ntte_full_merged_basic_sound_observer),visits:_visits,time_us:_time})
        }
        for(var _direction=0;_direction<2;++_direction) {
            var _a=_weapons[2*_direction],_b=_weapons[2*_direction+1]
            if(_a.rows!=_b.rows) {
                var _at=1,_length=min(string_length(_a.rows),string_length(_b.rows))
                while(_at<=_length && string_char_at(_a.rows,_at)==string_char_at(_b.rows,_at)) _at+=1
                scrNTTESmokeLog("COPY INDEX DIAG direction="+string(_direction)+" firstrowchar="+string(_at)
                    +" old="+string_copy(_a.rows,max(1,_at-90),220)+" new="+string_copy(_b.rows,max(1,_at-90),220))
            }
            if(_a.seed!=_b.seed || _a.streams!=_b.streams || _a.sounds!=_b.sounds)
                scrNTTESmokeLog("COPY INDEX DIAG direction="+string(_direction)+" seed="+string(_a.seed)+"/"+string(_b.seed)
                    +" streamsEqual="+string(_a.streams==_b.streams)+" oldSounds="+_a.sounds+" newSounds="+_b.sounds)
            assert(_a.rows==_b.rows && _a.seed==_b.seed && _a.streams==_b.streams && _a.sounds==_b.sounds,
                "Indexed actual repeated grenade-shotgun direction "+string(_direction)+" altered shots/effects/ammo/reload/motion/sounds or RNG")
        }
        assert(_weapons[0].visits>=2048*12 && _weapons[1].visits==0,
            "Actual repeated grenade-shotgun still scanned dense room during grouped effect callbacks")
        scrNTTESmokeLog("FULL MERGED COPY INDEX: native vs legacy copy-of-copy+dead+reverse-pending trace/RNG/order OK @"+string(30/timescale)
            +"; actual GrenadeLauncher/Shotgun 12x7 pellets + reverse12x5 native grenades/effects/ammo/motion/sound/RNG equivalent, collisionmode=false all rows; oldVisits="+string(_weapons[0].visits)
            +" newVisits="+string(_weapons[1].visits)+" old_us="+string(_weapons[0].time_us)+" new_us="+string(_weapons[1].time_us)
            +"; phone timing not measured")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_full_merge_copy_scan_observer=_scan;global.ntte_merge_native_collision_mode=_mode;global.ntte_copy_index_test=_test
        global.ntte_full_merge_copy_legacy_smoke=_legacy
        global.ntte_full_merged_plain_depth=_depth;global.ntte_full_merged_request=_request;global.ntte_full_merged_input_weapon=_input
        global.ntte_full_merged_basic_sound_observer=_sound;global.__debug_infammo=_infammo;global.ntte_full_native_weapon_models=_models
        global.rng_state=_streams;current_frame=_frame;random_set_seed(_seed)
    }
}

// Frozen old same-event full-world before/after Quasar FX capture.
function scrNTTEFullMergedQuasarSetupLegacy(_list,_info) {
    scrNTTEFullMergedProjectileAddScale(_list,0.25*_info.scale_goal)
    scrNTTEFullMergedProjectileAddDamage(_list,3*_info.scale_goal)
    scrNTTEFullMergedProjectileAddForce(_list,2*_info.scale_goal)
    scrNTTEFullMergedProjectileAddEffect(_list,"piercing",[1])
    if(_info.is_ring) {
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i])
            scrNTTEFullMergedProjectileAddEffect(id,"wall_piercing",[sqrt(damage)])
    }
    else {
        // NTT's Effect pseudo-family has no native root in Epsilon. Only the
        // two exact newly-created FX sprites below are eligible for retinting.
        // Original _minID/instance_max bounds the births of this synchronous
        // callback. Keep that boundary without enumerating the whole room.
        var _before=scrNTTEFullInstances(all),_moving=[]
        global.ntte_quasar_legacy_visits+=array_length(_before)
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i]) && _list[_i].speed!=0) array_push(_moving,_list[_i])
        // telib.array_shuffle1945: forward Fisher-Yates, final draw included.
        for(var _i=0;_i<array_length(_moving);++_i) {
            var _j=irandom_range(_i,array_length(_moving)-1),_swap=_moving[_i]
            _moving[_i]=_moving[_j];_moving[_j]=_swap
        }
        scrNTTEFullMergedProjectileAddEffect(_moving,"laser",[_info.line_dis_max])
        var _after=scrNTTEFullInstances(all)
        global.ntte_quasar_legacy_visits+=array_length(_after)
        var _effects=scrNTTEFullMergedRuntimeDifference(_before,_after)
        for(var _i=0;_i<array_length(_effects);++_i) {
            var _fx=_effects[_i]
            if(_fx.sprite_index==sprPlasmaTrail) _fx.sprite_index=_info.spr_hit
            else if(_fx.sprite_index==scrNTTERefSprite("AllyLaserCharge")) _fx.sprite_index=_info.spr_trail
        }
    }
}

// Source tetrench4415..4445 uses an instance_max boundary for new laser FX.
// Exercise real laser setup and nested birth captures against the frozen old
// full-world difference, including moving, stationary and ring replacements.
function scrNTTEFullMergedQuasarCaptureNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode")?global.ntte_merge_native_collision_mode:false,
        _legacy=variable_global_exists("ntte_quasar_legacy_visits")?global.ntte_quasar_legacy_visits:0,
        _results=[],_owner=instance_find(Player,0)
    try {
        repeat(2048) instance_create(79200,79000,NTTEFullMergedSetupProbe)
        var _dense=scrNTTEFullInstances(all)
        for(var _impl=0;_impl<2;++_impl) {
            global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
            global.ntte_merge_native_collision_mode=false;global.ntte_quasar_legacy_visits=0
            GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            GameCont.underwater=false;GameCont.crown=Crown.None;UberCont.opt_prtcls=true
            var _rows=[],_fx_count=0
            for(var _case=0;_case<4;++_case) {
                var _local=scrNTTEFullInstances(all),_shots=[],_moving=_case==0?1:(_case==2?0:3),
                    _hit=scrNTTERefSprite("UltraQuasarBeamHit"),_trail=scrNTTERefSprite("UltraQuasarBeamTrail"),
                    _info={scale_goal:1.5,is_ring:_case==3,line_dis_max:180,spr_hit:_hit,spr_trail:_trail}
                // Existing matching FX must not be retinted by either path.
                var _old_hit=instance_create(79600,79000,PlasmaTrail),_old_trail=instance_create(79600,79000,Dust)
                _old_trail.sprite_index=scrNTTERefSprite("AllyLaserCharge")
                var _old_hit_sprite=_old_hit.sprite_index,_old_trail_sprite=_old_trail.sprite_index
                for(var _i=0;_i<3;++_i) {
                    var _shot=instance_create(79400+40*_i,79000,Bullet1)
                    _shot.creator=_owner;_shot.team=team_player;_shot.damage=2;_shot.knockback_speed=3*timescale
                    _shot.direction=15*_i;_shot.speed=_i<_moving?8*timescale:0
                    _shot.image_xscale=1;_shot.image_yscale=1
                    array_push(_shots,_shot)
                }
                random_set_seed(714201+_case);global.rng_state=scrNTTEFullArrayCopy(_streams);current_frame=_frame
                var _outer=scrNTTEFullMergedCaptureBegin()
                if(_impl==0) scrNTTEFullMergedQuasarSetupLegacy(_shots,_info)
                else scrNTTEFullMergedQuasarBeamSetup(_shots,_info)
                var _new=scrNTTEFullMergedCaptureEnd(_outer),_shot_rows=[],_effect_rows=[],_hits=0
                for(var _i=0;_i<3;++_i) {
                    var _p=_shots[_i]
                    array_push(_shot_rows,[_p.x,_p.y,_p.xprevious,_p.yprevious,_p.speed,_p.direction,_p.damage,
                        _p.knockback_speed,_p.image_xscale,_p.image_yscale,_p.temerge_piercing_amount,
                        scrNTTEFullValue(_p,"temerge_wall_piercing_count",-1),_p.creator==_owner,_p.team])
                }
                for(var _i=0;_i<array_length(_new);++_i) if(instance_exists(_new[_i])) {
                    var _fx=_new[_i]
                    // The outer capture includes schedulers as well as the
                    // inner capture's FX, proving independent nested tokens.
                    if(instance_is(_fx,NTTEFullMergedEffectScheduler)) {
                        array_push(_effect_rows,["scheduler",_fx.ntte_effect_name,_fx.ntte_effect_event])
                        continue
                    }
                    var _creator=scrNTTEFullValue(_fx,"creator",noone)
                    array_push(_effect_rows,[object_get_name(_fx.object_index),_fx.x,_fx.y,_fx.speed,_fx.direction,
                        _fx.sprite_index,_fx.image_index,_fx.image_blend,_fx.image_alpha,
                        _fx.image_xscale,_fx.image_yscale,_creator==_owner,_creator==noone])
                    if(_fx.sprite_index==_hit) _hits+=1
                    assert(_fx.sprite_index!=sprPlasmaTrail && _fx.sprite_index!=scrNTTERefSprite("AllyLaserCharge"),
                        "New Quasar laser FX escaped source hit/trail sprite replacement")
                    _fx_count+=1
                }
                assert(_old_hit.sprite_index==_old_hit_sprite && _old_trail.sprite_index==_old_trail_sprite,
                    "Quasar capture retinted a pre-existing matching FX")
                if(_case<2) assert(_hits==_moving,"Real Quasar laser lost one hit FX per moving replacement")
                else assert(_hits==0,"Stationary/ring Quasar replacement incorrectly emitted beam FX")
                array_push(_rows,[_shot_rows,_effect_rows,random_get_seed(),global.rng_state])
                scrNTTEFullMergedRuntimeTestCleanup(_local)
                GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            }
            array_push(_results,{rows:json_stringify(_rows),visits:global.ntte_quasar_legacy_visits,fx:_fx_count})
            scrNTTEFullMergedRuntimeTestCleanup(_dense)
        }
        assert(_results[0].rows==_results[1].rows && _results[0].fx==_results[1].fx && _results[1].fx>=4,
            "Quasar birth capture changed ordered FX/quantities/creator/colors/projectile motion or RNG")
        assert(_results[0].visits>=2048*2*3 && _results[1].visits==0,
            "Quasar birth capture retained full-room before/after traversal")
        scrNTTESmokeLog("FULL MERGED QUASAR CAPTURE: exact old/new real laser moving/still/ring, preexisting FX, nested capture, quantities/colors/creator/motion/RNG equivalent @"
            +string(30/timescale)+"; old world visits="+string(_results[0].visits)+" new="+string(_results[1].visits)
            +" fx="+string(_results[1].fx)+"; phone timing not measured")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_mode;global.ntte_quasar_legacy_visits=_legacy
        global.rng_state=_streams;current_frame=_frame;random_set_seed(_seed)
    }
}

// Real Prism copies a native Lightning root, performs its actual Alarm0, then
// copies arbitrary fields to its newly constructed descendants. Those tag
// births must join the same deferred effect membership as legacy discovery.
function scrNTTEFullMergedPrismCopyIndexNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode")?global.ntte_merge_native_collision_mode:false,
        _legacy=variable_global_exists("ntte_full_merge_copy_legacy_smoke")?global.ntte_full_merge_copy_legacy_smoke:false,
        _plain=variable_global_exists("ntte_full_merged_plain_depth")?global.ntte_full_merged_plain_depth:0,
        _scan=variable_global_exists("ntte_full_merge_copy_scan_observer")?global.ntte_full_merge_copy_scan_observer:undefined,
        _results=[],_owner=instance_find(Player,0)
    try {
        repeat(2048) instance_create(82000,82000,NTTEFullMergedSetupProbe)
        var _dense=scrNTTEFullInstances(all)
        for(var _impl=0;_impl<2;++_impl) {
            global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
            GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
            GameCont.area=1;GameCont.underwater=false;global.ntte_full_merged_plain_depth=0
            global.ntte_merge_native_collision_mode=false;global.ntte_full_merge_copy_legacy_smoke=(_impl==0)
            global.ntte_full_merge_copy_scan_observer=[]
            random_set_seed(542409);global.rng_state=scrNTTEFullArrayCopy(_streams);current_frame=_frame
            var _pet=scrNTTEFullPetCreate(82400,82000,"Prism"),_source=noone
            _pet.leader=_owner;_owner.accuracy=1
            with(_owner) _source=scrNTTEFullMergedLightningCreate(82400,82000,0,4)
            _source.damage=13;_source.hitid=[991];_source.prism_contract_token={value:73}
            scrNTTEFullMergedEffectAddEvent("test_prism_copy","step",function(_list) {
                for(var _i=0;_i<array_length(_list);++_i) _list[_i].ntte_prism_copy_visit=_i
            })
            scrNTTEFullMergedProjectileAddEffect(_source,"test_prism_copy")
            var _old=scrNTTEFullInstances(Lightning),_copy=noone,_hits=instance_number(LightningHit)
            with(_pet) _copy=scrNTTEFullPetPrismSplit(_source)
            var _nodes=scrNTTEFullMergedRuntimeDifference(_old,scrNTTEFullInstances(Lightning)),
                _vars=scrNTTEFullMergedEffectVars("test_prism_copy")
            assert(instance_exists(_copy) && array_length(_nodes)==3 && instance_number(LightningHit)==_hits+1,
                "Merged Prism fixture lost source three-segment post-Alarm Lightning branch")
            assert(scrNTTEFullMergedProjectileHasEffect(_copy,"test_prism_copy") && array_length(_vars.instance_list)==2,
                "Prism root copy lost synchronous registration or descendants registered too early")
            for(var _i=0;_i<array_length(_nodes);++_i) if(_nodes[_i]!=_copy)
                assert(!scrNTTEFullMergedProjectileHasEffect(_nodes[_i],"test_prism_copy"),
                    "Prism manual tag copy registered before original next-event discovery")
            scrNTTEFullMergedEffectCallEvent("test_prism_copy","step")
            assert(array_length(_vars.instance_list)==4 && !array_length(_vars.ntte_copy_pending),
                "Prism manual tag children were omitted or left pending after actual grouped callback")
            var _rows=[]
            for(var _i=0;_i<array_length(_vars.instance_list);++_i) {
                var _p=_vars.instance_list[_i]
                assert(_p.creator==_owner && _p.team==_owner.team && _p.damage==13
                    && _p.hitid[0]==991 && _p.prism_contract_token.value==73 && _p.ntte_prism_copy_visit==_i,
                    "Prism registered descendants lost shared fields, creator or callback order")
                array_push(_rows,[_p==_source,_p==_copy,_p.x,_p.y,_p.speed,_p.direction,_p.image_angle,_p.image_xscale,
                    _p.ammo,_p.ntte_prism_copy_visit,_p.prism_duplicate,_p.can_prism_duplicate])
            }
            var _visits=0
            for(var _i=0;_i<array_length(global.ntte_full_merge_copy_scan_observer);++_i)
                _visits+=global.ntte_full_merge_copy_scan_observer[_i].count
            array_push(_results,{rows:json_stringify(_rows),seed:random_get_seed(),streams:json_stringify(global.rng_state),visits:_visits})
            scrNTTEFullMergedRuntimeTestCleanup(_dense)
        }
        assert(_results[0].rows==_results[1].rows && _results[0].seed==_results[1].seed && _results[0].streams==_results[1].streams,
            "Indexed real Prism Lightning manual field copies changed order, fields, geometry or RNG")
        assert(_results[0].visits>=2048 && _results[1].visits==2,
            "Prism manual tag index traversed unrelated room instances or missed exact two children")
        scrNTTESmokeLog("FULL MERGED PRISM COPY INDEX: real native root copy/Alarm0/two manually-tagged descendants, deferred membership/order/owner/fields/geometry/RNG equivalent @"
            +string(30/timescale)+"; oldVisits="+string(_results[0].visits)+" newVisits="+string(_results[1].visits))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_mode;global.ntte_full_merge_copy_legacy_smoke=_legacy
        global.ntte_full_merged_plain_depth=_plain;global.ntte_full_merge_copy_scan_observer=_scan
        global.rng_state=_streams;current_frame=_frame;random_set_seed(_seed)
    }
}
