// Same actual native path on old and fixed production. On the old baseline,
// fail ONLY after observing the extra partner following Cleanup -> real Vat.
function scrNTTEFullTwinsHistoryBaselineRefReadOnly(_value) {
    var _row={value_type:typeof(_value),numeric:is_numeric(_value),struct_value:is_struct(_value),array_value:is_array(_value)}
    if(!_row.struct_value && !_row.array_value) _row.value_text=string(_value)
    if(_row.numeric) _row.raw_numeric=_value
    try {
        _row.exists=instance_exists(_value)
        if(_row.exists) {
            _row.instance_id=string(_value.id)
            _row.instance_id_type=typeof(_value.id)
            _row.object_name=object_get_name(_value.object_index)
        }
    } catch(_error) { _row.inspect_error=_error.message }
    return _row
}
function scrNTTEFullTwinsHistoryBaselineReadOnly(_pet,_phase) {
    var _row={phase:_phase,pet_exists:instance_exists(_pet),menu_count:instance_number(Menu),
        gencont_count:instance_number(GenCont),levcont_count:instance_number(LevCont),
        floormaker_count:instance_number(FloorMaker),active_lockstep_stop:lockstep_stop,
        game_count:instance_number(GameCont)}
    if(instance_exists(_pet)) _row.pet={visible:_pet.visible,partner_noone:_pet.partner==noone,
        partner_exists:instance_exists(_pet.partner),game_exists:instance_exists(_pet.ntte_game),
        game_matches:_pet.ntte_game==instance_find(GameCont,0),
        species_step_callable:is_callable(scrNTTEFullValue(_pet.hooks,"step",undefined))}
    scrNTTESmokeLog("TWINS HISTORY BASELINE STEP READONLY "+json_stringify(_row))
}
function scrNTTEFullPetTwinsHistoryBaselineTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),_progress=global.ntte_full_progress,_stop=lockstep_stop,
        _raw_menu_count=instance_number(Menu),
        _parked=scrNTTEFullInstances([Menu,NTTEFullPet,NTTEFullPrompt,NTTEFullPetRevive,NTTEFullMutantVat,Portal,LastDie,WepPickup])
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};lockstep_stop=false
    scrNTTESmokeLog("TWINS HISTORY BASELINE SCENE READONLY "+json_stringify({menu_before_parking:_raw_menu_count,
        menu_after_parking:instance_number(Menu),gencont_after_parking:instance_number(GenCont),
        levcont_after_parking:instance_number(LevCont),active_lockstep_stop:lockstep_stop}))
    try {
        var _p=instance_find(Player,0),_x=176000,_y=176000,_hp=_p.hp
        assert(instance_exists(_p),"Twins baseline fixture needs actual Player")
        _p.x=_x;_p.y=_y;_p.speed=0;_p.visible=true;_p.can_pick=true;_p.ntte_pet=[];_p.ntte_pet_max=1
        GameCont.ntte_pet_max=1;GameCont.ntte_pet_history=[]
        KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.press_pick[_p.index]=false
        instance_create(_x,_y,LastDie)
        var _a=scrNTTEFullPetCreate(_x,_y,"Twins")
        scrNTTEFullTwinsHistoryBaselineReadOnly(_a,"before-first-native-step")
        with(_a) event_perform(ev_step,ev_step_normal)
        scrNTTEFullTwinsHistoryBaselineReadOnly(_a,"after-first-native-step")
        assert(instance_exists(_a),"Baseline actual Pet Step destroyed receiver despite controlled scene")
        var _b=_a.partner
        var _link_diagnostic={observer_id:scrNTTEFullTwinsHistoryBaselineRefReadOnly(id),
            observer_self:scrNTTEFullTwinsHistoryBaselineRefReadOnly(self),
            observer_other:scrNTTEFullTwinsHistoryBaselineRefReadOnly(other),
            first:scrNTTEFullTwinsHistoryBaselineRefReadOnly(_a),
            first_partner:scrNTTEFullTwinsHistoryBaselineRefReadOnly(_a.partner),
            second:scrNTTEFullTwinsHistoryBaselineRefReadOnly(_b)}
        if(instance_exists(_b)) {
            _link_diagnostic.second_partner=scrNTTEFullTwinsHistoryBaselineRefReadOnly(_b.partner)
            _link_diagnostic.second_partner_equals_first=_b.partner==_a
            _link_diagnostic.second_partner_equals_first_id=_b.partner==_a.id
            _link_diagnostic.second_partner_equals_observer_id=_b.partner==id
            _link_diagnostic.second_partner_equals_observer_other=_b.partner==other
            if(instance_exists(_b.partner)) {
                _link_diagnostic.second_partner_instance_id_equals_first_id=_b.partner.id==_a.id
                _link_diagnostic.second_partner_object_matches_first=_b.partner.object_index==_a.object_index
            }
            _link_diagnostic.first_skin=_a.bskin;_link_diagnostic.second_skin=_b.bskin
            _link_diagnostic.first_leader=scrNTTEFullTwinsHistoryBaselineRefReadOnly(_a.leader)
            _link_diagnostic.second_leader=scrNTTEFullTwinsHistoryBaselineRefReadOnly(_b.leader)
        }
        scrNTTESmokeLog("TWINS HISTORY BASELINE LINK READONLY "+json_stringify(_link_diagnostic))
        assert(instance_exists(_b) && instance_exists(_b.partner) && _b.partner.id==_a.id,"Baseline fresh native Twins creation failed")
        _b.x=_x+160;_b.y=_y
        with(_b.prompt) event_perform(ev_step,ev_step_normal)
        KeyCont.press_pick[_p.index]=true
        with(_p) event_perform(ev_step,ev_step_normal)
        KeyCont.press_pick[_p.index]=false
        assert(_a.prompt.pick==_p.index,"Baseline actual native Player pickup prompt failed")
        with(_a) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        with(_b) event_perform(ev_step,ev_step_normal)
        assert(_a.leader==_p && _b.leader==_p && !_a.stat_found && !_b.stat_found
            && array_length(_p.ntte_pet)==1 && _p.ntte_pet[0]==_a && _p.hp==_hp,
            "Baseline actual native Twins acquisition/one-slot synchronization failed")
        instance_destroy(_a)
        assert(array_length(GameCont.ntte_pet_history)==1,"Baseline real Cleanup failed to record history")
        var _row=GameCont.ntte_pet_history[0],_before=scrNTTEFullInstances(NTTEFullPet),
            _vat=instance_create(_x+512,_y,NTTEFullMutantVat)
        _vat.type="Pet";_vat.pet_data=_row;_vat.hp=0
        with(_vat) event_perform(ev_step,ev_step_normal)
        var _restored=noone
        with(NTTEFullPet) if(pet=="Twins" && array_get_index(_before,id)<0) _restored=id
        assert(!instance_exists(_vat) && instance_exists(_restored),"Baseline real Vat Step/Destroy restoration failed")
        var _count_before=0,_count_after=0,_restored_before=_restored.partner
        with(NTTEFullPet) if(pet=="Twins") _count_before++
        with(_restored) event_perform(ev_step,ev_step_normal)
        with(NTTEFullPet) if(pet=="Twins") _count_after++
        scrNTTESmokeLog("TWINS HISTORY BASELINE READONLY "+json_stringify({actual_fps:30/timescale,
            history_fields:variable_struct_get_names(_row[3]),live_partner:instance_exists(_b),
            original_pair_member_destroyed:!instance_exists(_a),vat_destroyed:!instance_exists(_vat),
            restored_before_noone:_restored_before==noone,restored_before_same_live_partner:_restored_before==_b,
            pet_count_before_native_step:_count_before,pet_count_after_native_step:_count_after,
            owner_hp_unchanged:_p.hp==_hp,source_history_cleared:array_length(_restored.history)==0}))
        assert(_count_after==_count_before,
            "SOURCE TWINS HISTORY DUPLICATE: actual acquire -> Cleanup -> real Vat -> native Pet Step created an extra partner")
    } finally {
        with(NTTEFullPet) {history=[];instance_destroy()}
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullVanillaFixtureEnd(_state);global.ntte_full_progress=_progress;lockstep_stop=_stop
    }
    scrNTTESmokeLog("SOURCE TWINS HISTORY BASELINE: actual native acquire/Cleanup/Vat/Pet Step preserves partner count OK @"+string(30/timescale))
}
