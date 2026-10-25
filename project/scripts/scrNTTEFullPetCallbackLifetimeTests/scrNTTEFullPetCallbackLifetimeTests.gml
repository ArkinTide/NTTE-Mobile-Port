// Real species callbacks first. Explicit callback-contract probes below are
// test hooks only, and do not certify any unexecuted source species branch.
function scrNTTEFullPetCallbackLifetimeF64Equal(_actual,_expected) {
    // Test-only exact IEEE754 equality, independent of the engine's epsilon.
    // These alarm values (100 minus 1 or 0.5, and 17) are exactly representable.
    var _bytes=buffer_create(16,buffer_fixed,1),_equal=false
    try {
        buffer_poke(_bytes,0,buffer_f64,_actual)
        buffer_poke(_bytes,8,buffer_f64,_expected)
        _equal=buffer_peek(_bytes,0,buffer_u32)==buffer_peek(_bytes,8,buffer_u32)
            && buffer_peek(_bytes,4,buffer_u32)==buffer_peek(_bytes,12,buffer_u32)
    } finally {
        buffer_delete(_bytes)
    }
    return _equal
}
function scrNTTEFullPetCallbackLifetimeState(_pet) {
    // Called within the real pet receiver before/after its native event.
    // Keyword self versus instance ID are recorded separately because NTT
    // source self and native GML self may have different numeric contracts.
    var _state={pet:string(_pet),pet_exists:instance_exists(_pet),
        receiver_id:string(id),receiver_self:string(self),
        receiver_exists_id:instance_exists(id),receiver_exists_self:instance_exists(self),
        receiver_id_matches:id==_pet,receiver_self_matches:self==_pet,
        receiver_scale:timescale,receiver_clock:current_frame,receiver_stopped:lockstep_stop,
        gen:instance_exists(GenCont),level:instance_exists(LevCont),menu:instance_exists(Menu),
        spiral:instance_exists(SpiralCont),floor_maker:instance_exists(FloorMaker)}
    if(instance_exists(GameCont)) {
        _state.game=string(GameCont.id);_state.loops=GameCont.loops
        _state.area=GameCont.area;_state.subarea=GameCont.subarea
    }
    if(instance_exists(_pet)) {
        _state.alarm=_pet.ntte_pet_alarm;_state.wave=_pet.wave;_state.visible=_pet.visible
        _state.leader=string(_pet.leader);_state.leader_exists=instance_exists(_pet.leader)
        _state.revive=string(_pet.revive);_state.revive_exists=instance_exists(_pet.revive)
        _state.prompt=string(_pet.prompt);_state.prompt_exists=instance_exists(_pet.prompt)
        if(instance_exists(_pet.prompt)) {_state.prompt_pick=_pet.prompt.pick;_state.prompt_visible=_pet.prompt.visible}
        _state.pet_loops=_pet.pet_loops;_state.ntte_game=string(_pet.ntte_game)
        _state.ntte_game_exists=instance_exists(_pet.ntte_game);_state.can_take=_pet.can_take
        _state.image_index=_pet.image_index;_state.image_speed=_pet.image_speed
        _state.sprite=string(_pet.sprite_index);_state.shadow=string(_pet.spr_shadow);_state.light=_pet.light
        _state.hiding=scrNTTEFullValue(_pet,"hiding",undefined)
        _state.hp=_pet.hp;_state.max_hp=_pet.max_hp;_state.speed=_pet.speed;_state.walk=_pet.walk
    }
    return _state
}
function scrNTTEFullPetCallbackLifetimeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && !instance_exists(LevCont) && !instance_exists(SpiralCont)
        && instance_exists(GameCont) && instance_exists(Player)
        && !instance_exists(LastDie) && !instance_exists(LastExecute),
        "Pet callback lifetime fixture requires a settled desktop room")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_rng_states=scrNTTEFullArrayCopy(global.rng_state),_stop=lockstep_stop,
        _frame=current_frame,_progress=global.ntte_full_progress,
        _progress_json=json_stringify(global.ntte_full_progress),_graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(_progress,_graph)
    try {
        lockstep_stop=false;current_frame=floor(current_frame)
        GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.underwater=false;GameCont.loops=0
        // Real native PitSquid constructor and real Octo species callbacks.
        // Its intro field is isolated here to exercise both source branches;
        // the connected combat test must still earn intro through real play.
        for(var _case=0;_case<6;++_case) {
            var _before=scrNTTEFullInstances(all),_pit=instance_create(64000,64000,NTTEFullPitSquid),
                _pet=scrNTTEFullPetCreate(64000,64128,"Octo"),_prompt=_pet.prompt,
                _delete=(_case==0)
            _pit.ntte_full_intro=(_case!=1)
            _pet.hiding=(_case!=5);_pet.image_index=(_case==4 ? 1.5:0)
            _pet.speed=0;_pet.walk=0;_pet.ntte_pet_alarm=100
            if(_case==2) _pet.leader=instance_find(Player,0)
            if(_case==3) _pet.visible=false
            var _alarm=_pet.ntte_pet_alarm,_state_before=undefined,_state_after={pet_exists:false},
                _scale_before=timescale,_clock_before=current_frame
            with(_pet) _state_before=scrNTTEFullPetCallbackLifetimeState(id)
            with(_pet) event_perform(ev_step,ev_step_normal)
            if(instance_exists(_pet)) with(_pet) _state_after=scrNTTEFullPetCallbackLifetimeState(id)
            scrNTTESmokeLog("PET CALLBACK OCTO EXACT BEFORE ASSERT "+json_stringify({
                source_case:_case,expect_delete:_delete,pit:string(_pit),pit_exists:instance_exists(_pit),
                pit_intro:instance_exists(_pit)?_pit.ntte_full_intro:undefined,
                before:_state_before,after:_state_after,prompt_live:instance_exists(_prompt),
                expected_alarm:_alarm-_scale_before,timescale_before:_scale_before,timescale_after:timescale,
                clock_before:_clock_before,clock_after:current_frame,rate:30/timescale}))
            assert(instance_exists(_pet)!=_delete && instance_exists(_prompt)!=_delete,
                "Actual hidden Octo intro self-deletion or native prompt Cleanup changed")
            if(!_delete) {
                scrNTTESmokeLog("PET CALLBACK OCTO LIVE EXPRESSION BEFORE ASSERT "+json_stringify({
                    source_case:_case,alarm_local:_alarm,alarm_local_type:typeof(_alarm),
                    alarm_live:_pet.ntte_pet_alarm,alarm_live_type:typeof(_pet.ntte_pet_alarm),
                    scale_live:timescale,scale_live_type:typeof(timescale),global_scale:global.time_scale,
                    expected_live:_alarm-timescale,expected_live_type:typeof(_alarm-timescale),
                    difference_live:_pet.ntte_pet_alarm-(_alarm-timescale),
                    absolute_live:abs(_pet.ntte_pet_alarm-(_alarm-timescale)),
                    tolerance_live:0.00001,tolerance_live_type:typeof(0.00001),
                    engine_epsilon:math_get_epsilon(),zero_strict:0<0.00001,zero_inclusive:0<=0.00001,
                    comparison_live:abs(_pet.ntte_pet_alarm-(_alarm-timescale))<0.00001}))
                assert(scrNTTEFullPetCallbackLifetimeF64Equal(_pet.ntte_pet_alarm,_alarm-timescale),
                    "Surviving Octo failed to continue the original base Pet Step")
                if(_case==2) assert(!_pet.hiding && _pet.light && _pet.spr_shadow==shd16,
                    "Owned Octo must unhide and survive the same PitSquid intro")
                if(_case==1 || _case==4) assert(_pet.hiding && !_pet.light && _pet.spr_shadow==-1,
                    "Nondeleting hiding Octo changed original hiding state")
            }
            assert(instance_exists(_pit) && _pit.hp==340,
                "Focused Octo lifetime callback altered the independent boss")
            scrNTTESmokeLog("PET CALLBACK REAL Octo native.Step case="+string(_case)+" delete="+string(_delete)+" actualPetAndPromptLive="+string(instance_exists(_pet))+" @"+string(30/timescale))
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }

        // Another genuine source Step self-delete: a guardian whose escape
        // opportunity vanished emits its source corpse and cleans its prompt.
        var _before=scrNTTEFullInstances(all),_pet=scrNTTEFullPetCreate(64000,64384,"Guardian"),
            _prompt=_pet.prompt,_corpses=instance_number(Corpse)
        _pet.can_escape=true;_pet.ntte_pet_alarm=100
        with(_pet) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_pet) && !instance_exists(_prompt) && instance_number(Corpse)==_corpses+1,
            "Actual Guardian rejected escape self-deletion/cleanup/corpse changed")
        scrNTTESmokeLog("PET CALLBACK REAL Guardian native.Step rejected escape deleted pet+prompt and emitted one corpse @"+string(30/timescale))
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // Existing dead references retain their original handling. This is a
        // stale-ID contract probe, not an execution of Cuz owner-death takeover.
        var _before=scrNTTEFullInstances(all),_pet=scrNTTEFullPetCreate(64000,64512,"Octo"),
            _gone=scrNTTEFullPetCreate(64512,64512,"Octo")
        instance_destroy(_gone)
        _pet.leader=_gone;_pet.hiding=false;_pet.ntte_pet_alarm=100
        with(_pet) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_pet) && _pet.leader==noone && _pet.can_take,
            "Original stale leader release changed while restoring self callback lifetime")
        scrNTTEFullMergedRuntimeTestCleanup(_before)

        // TEST-ONLY hook contract probes cover all four generic boundaries,
        // including live-return continuation. They are not claimed as species.
        for(var _kind=0;_kind<4;++_kind) for(var _delete=0;_delete<2;++_delete) {
            var _before=scrNTTEFullInstances(all),_pet=scrNTTEFullPetCreate(64000,64640,"Parrot"),
                _prompt=_pet.prompt,_trace={calls:0,delete_self:(_delete==1)},_alarm=100
            _pet.ntte_callback_probe=_trace;_pet.hooks={};_pet.ntte_pet_alarm=_alarm;_pet.corpse=false
            var _hook=method(_pet,function(_dir=0,_dis=0) {
                ntte_callback_probe.calls++
                if(ntte_callback_probe.delete_self) instance_destroy()
                return 17
            })
            if(_kind==0) _pet.hooks.anim=_hook
            if(_kind==1) _pet.hooks.step=_hook
            if(_kind==2) { _pet.max_hp=12;_pet.hp=0;_pet.hooks.death=_hook }
            if(_kind==3) { _pet.hooks.alarm=_hook;_pet.ntte_pet_alarm=0 }
            with(_pet) event_perform(ev_step,ev_step_normal)
            assert(_trace.calls==1 && instance_exists(_pet)==(_delete==0)
                && instance_exists(_prompt)==(_delete==0),
                "Test-only callback lifetime probe duplicated/skipped hook or leaked prompt")
            if(_delete==0) {
                assert(scrNTTEFullPetCallbackLifetimeF64Equal(_pet.ntte_pet_alarm,_kind==3 ? 17:_alarm-timescale),
                    "Live callback changed base continuation or returned alarm")
                if(_kind==2) assert(instance_exists(_pet.revive) && _pet.revive.creator==_pet,
                    "Surviving death hook lost original revive controller")
            }
            scrNTTESmokeLog("PET CALLBACK TEST-ONLY hook kind="+string(_kind)+" deletes="+string(_delete)+" calls1 and original live continuation/cleanup OK @"+string(30/timescale))
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        global.ntte_full_progress=_progress;global.rng_state=_rng_states
        lockstep_stop=_stop;current_frame=_frame;random_set_seed(_seed)
    }
    // Restore may change struct enumeration order; retain exact fields,
    // types, arrays and binary64 values using the mutation-tested comparator.
    assert(scrNTTEFullCuzConnectedValueEqual(global.ntte_full_progress,json_parse(_progress_json)),"Pet lifetime fixture leaked pet progress changes")
    scrNTTESmokeLog("PET CALLBACK LIFETIME native Octo/PitSquid intro six branches + Guardian escape self-delete + stale leader release + four test-only callback live/dead contracts OK @"+string(30/timescale)+"; Cuz takeover/campaign/iPhone still require connected validation")
}
