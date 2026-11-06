// Controlled real native Pet/Player/Cleanup/Vat and Session buffer tests.
// No physical-device, natural Labs event-selection or full Continue claim.
function scrNTTEFullTwinsHistorySame(_a,_b) {
    // Native instance scopes and refs can denote the same live instance while
    // direct == is false (actual 6797 readonly evidence). Dead values stay raw.
    if(instance_exists(_a) && instance_exists(_b)) return _a.id==_b.id;
    return _a==_b;
}
function scrNTTEFullTwinsHistoryCount() {
    var _count=0
    with(NTTEFullPet) if(pet=="Twins") _count++
    return _count
}
function scrNTTEFullTwinsHistoryClear() {
    with(NTTEFullPet) { history=[]; instance_destroy() }
    with(Player) ntte_pet=[]
    GameCont.ntte_pet_history=[]
}
function scrNTTEFullTwinsHistoryPair(_x,_y,_reverse=false) {
    var _p=instance_find(Player,0),_hp=_p.hp
    _p.x=_x;_p.y=_y;_p.speed=0;_p.visible=true;_p.can_pick=true;_p.ntte_pet=[];_p.ntte_pet_max=1
    GameCont.ntte_pet_max=1
    KeyCont.hold_fire[_p.index]=false;KeyCont.hold_spec[_p.index]=false;KeyCont.press_pick[_p.index]=false
    var _a=scrNTTEFullPetCreate(_x,_y,"Twins")
    assert(_a.partner==noone && !_a.ntte_twins_missing_partner && scrNTTEFullTwinsHistoryCount()==1,
        "Fresh Twins did not begin never-paired")
    with(_a) event_perform(ev_step,ev_step_normal)
    var _b=_a.partner
    assert(instance_exists(_b) && scrNTTEFullTwinsHistorySame(_b.partner,_a) && _a.bskin!=_b.bskin && scrNTTEFullTwinsHistoryCount()==2,
        "Actual fresh Pet Step failed exactly one opposite-skin partner")
    if(_reverse) {var _swap=_a;_a=_b;_b=_swap}
    _b.x=_x+160;_b.y=_y
    with(_b.prompt) event_perform(ev_step,ev_step_normal)
    with(_p) event_perform(ev_step,ev_step_normal)
    assert(_a.leader==noone && _a.prompt.pick<0,
        "Negative native Player Step acquired Twins without pickup press")
    KeyCont.press_pick[_p.index]=true
    with(_p) event_perform(ev_step,ev_step_normal)
    KeyCont.press_pick[_p.index]=false
    assert(_a.prompt.pick==_p.index,"Actual Player Step did not select Twins pickup prompt")
    with(_a) { event_perform(ev_step,ev_step_normal); event_perform(ev_step,ev_step_normal) }
    with(_b) event_perform(ev_step,ev_step_normal)
    assert(scrNTTEFullTwinsHistorySame(_a.leader,_p) && scrNTTEFullTwinsHistorySame(_b.leader,_p) && !_a.stat_found && !_b.stat_found
        && !_a.can_take && !_b.can_take && _a.persistent && _b.persistent
        && array_length(_p.ntte_pet)==1 && _p.ntte_pet[0]==_a && _p.hp==_hp
        && scrNTTEFullTwinsHistoryCount()==2,
        "Native Twins acquisition lost shared leader/one slot/found/persistence or duplicated pair/hurt owner")
    scrNTTESmokeLog("TWINS HISTORY NATIVE PAIR READONLY "+json_stringify({reverse_pickup:_reverse,
        acquired_skin:_a.bskin,partner_skin:_b.bskin,acquired_partner_type:typeof(_a.partner),
        acquired_partner_direct_equal:_a.partner==_b,acquired_partner_id_equal:_a.partner.id==_b.id,
        one_owner_slot:array_length(_p.ntte_pet)==1}))
    return [_a,_b]
}
function scrNTTEFullTwinsHistoryVat(_row,_expected_partner,_expect_missing,_tag,_expect_fresh_pair=false) {
    var _before=scrNTTEFullInstances(NTTEFullPet),_count=scrNTTEFullTwinsHistoryCount(),
        _p=instance_find(Player,0),_hp=_p.hp,_vat=instance_create(172000,172000,NTTEFullMutantVat)
    _vat.type="Pet";_vat.pet_data=_row;_vat.hp=0
    with(_vat) event_perform(ev_step,ev_step_normal)
    var _pet=noone
    with(NTTEFullPet) if(pet=="Twins" && array_get_index(_before,id)<0) {
        assert(_pet==noone,"Actual vat restored more than one pet: "+_tag)
        _pet=id
    }
    assert(!instance_exists(_vat) && instance_exists(_pet) && scrNTTEFullTwinsHistoryCount()==_count+1,
        "Actual vat Step/Destroy did not restore one source history pet: "+_tag)
    assert(scrNTTEFullTwinsHistorySame(_pet.partner,_expected_partner) && _pet.ntte_twins_missing_partner==_expect_missing
        && _pet.bskin==_row[3].bskin && _pet.team==_row[3].team && !_pet.stat_found
        && array_length(_pet.history)==0,
        "Actual vat lost live/dead/portable-missing partner/skin/team or source history clearing: "+_tag)
    repeat(3) with(_pet) event_perform(ev_step,ev_step_normal)
    assert(scrNTTEFullTwinsHistoryCount()==_count+1+_expect_fresh_pair && _p.hp==_hp,
        "Restored Twins native Pet Step duplicated companion or hurt owner: "+_tag)
    if(_expect_fresh_pair) assert(instance_exists(_pet.partner) && scrNTTEFullTwinsHistorySame(_pet.partner.partner,_pet) && _pet.partner.bskin!=_pet.bskin,
        "Never-paired portable history failed exactly one fresh opposite-skin partner: "+_tag)
    var _histories=array_length(GameCont.ntte_pet_history)
    instance_destroy(_pet)
    assert(array_length(GameCont.ntte_pet_history)==_histories,
        "Vat-restored pet regenerated forbidden repeated history: "+_tag)
    scrNTTESmokeLog("TWINS HISTORY VAT "+_tag+" @"+string(30/timescale)
        +" partner_exists="+string(instance_exists(_expected_partner))+" missing="+string(_expect_missing))
}
function scrNTTEFullTwinsHistoryPhysicalCase(_live,_reverse=false) {
    scrNTTEFullTwinsHistoryClear()
    var _pair=scrNTTEFullTwinsHistoryPair(170000,170000,_reverse),_a=_pair[0],_b=_pair[1],_bskin=_a.bskin,
        _rawlive=json_parse(json_stringify({partner:_b}))
    instance_destroy(_a)
    assert(array_length(GameCont.ntte_pet_history)==1,"Actual acquired Twins Cleanup did not record one history")
    var _row=GameCont.ntte_pet_history[0]
    assert(variable_struct_exists(_row[3],"partner") && scrNTTEFullTwinsHistorySame(_row[3].partner,_b) && _row[3].bskin==_bskin,
        "Actual Cleanup omitted the source Twins partner reference")
    if(!_live) { _b.history=[];instance_destroy(_b) }
    var _rawdead=json_parse(json_stringify({partner:_b}))
    scrNTTESmokeLog("TWINS HISTORY RAW JSON READONLY "+json_stringify({live_case:_live,reverse_pickup:_reverse,
        live_type:typeof(_rawlive.partner),later_type:typeof(_rawdead.partner),
        live_equal:_rawlive.partner==_b,later_equal:_rawdead.partner==_b,
        physical_non_noone:_b!=noone,physical_exists:instance_exists(_b)}))
    assert(_row[3].partner!=noone,"Dead physical instance reference unexpectedly became noone")
    scrNTTEFullTwinsHistoryVat(_row,_row[3].partner,false,(_live?"physical-live":"physical-dead")+(_reverse?"-scope":"-ref"))
    scrNTTEFullTwinsHistoryClear()
}
function scrNTTEFullTwinsHistoryJSONCase(_mode) {
    scrNTTEFullTwinsHistoryClear()
    var _p=instance_find(Player,0),_a=noone,_b=noone,_hp=_p.hp
    if(_mode=="fresh" || _mode=="fresh-empty-history") {
        _a=scrNTTEFullPetCreate(170000,170000,"Twins")
        assert(scrNTTEFullPetTake(_a,_p),"Fresh continuation setup acquisition failed")
        if(_mode=="fresh-empty-history") _a.history=[]
    } else {
        var _pair=scrNTTEFullTwinsHistoryPair(170000,170000)
        _a=_pair[0];_b=_pair[1]
        if(_mode=="dead") { _b.history=[];instance_destroy(_b) }
    }
    var _data=json_parse(json_stringify(scrNTTEFullPetExport()))
    for(var _i=0;_i<array_length(_data.pets);++_i)
        assert(!variable_struct_exists(_data.pets[_i].values,"partner")
            && !variable_struct_exists(_data.pets[_i].values,"ntte_twins_missing_partner"),
            "Portable Twins values leaked physical reference/internal adapter flag")
    if(_mode=="legacy-pair" || _mode=="legacy-orphan")
        for(var _i=0;_i<array_length(_data.pets);++_i) {
            variable_struct_remove(_data.pets[_i],"missing_partner")
            _data.pets[_i].values.history=["bskin","team","stat_found"]
        }
    if(_mode=="legacy-orphan") {
        _data.pets=[_data.pets[0]];_data.pets[0].partner=-1
    }
    assert(scrNTTEFullPetImport(_data),"Real PetImport rejected portable/legacy fixture")
    assert(!instance_exists(_a) && !instance_exists(_b),"PetImport retained original physical IDs")
    var _new=_p.ntte_pet[0],_count=scrNTTEFullTwinsHistoryCount()
    if(_mode=="pair" || _mode=="legacy-pair") {
        assert(_count==2 && instance_exists(_new.partner) && scrNTTEFullTwinsHistorySame(_new.partner.partner,_new)
            && _new.partner.bskin!=_new.bskin && !_new.ntte_twins_missing_partner
            && scrNTTEFullTwinsHistorySame(_new.partner.leader,_p) && array_length(_p.ntte_pet)==1,
            "Portable live pair lost remapped IDs/opposite skins/shared owner/one slot")
    } else if(_mode=="dead") {
        assert(_count==1 && _new.partner==noone && _new.ntte_twins_missing_partner,
            "Portable orphan did not retain initialized-but-missing state")
    } else assert(_count==1 && _new.partner==noone && !_new.ntte_twins_missing_partner,
            "Never-paired/legacy orphan behavior changed")
    if(_mode=="fresh-empty-history") assert(array_length(_new.history)==0,
        "Import repopulated deliberately empty one-use vat history")
    repeat(3) with(_new) event_perform(ev_step,ev_step_normal)
    var _expect=(_mode=="fresh" || _mode=="fresh-empty-history" || _mode=="legacy-orphan")?2:_count
    assert(scrNTTEFullTwinsHistoryCount()==_expect && _p.hp==_hp,
        "Native post-import Step duplicated initialized partner or failed fresh/legacy pair creation")
    // A portable missing partner can be lost again before its eventual vat.
    if(_mode=="dead") {
        instance_destroy(_new)
        assert(array_length(GameCont.ntte_pet_history)==1,"Imported orphan Cleanup failed history")
        var _history=GameCont.ntte_pet_history[0]
        assert(_history[3].partner==noone && _history[3].ntte_twins_missing_partner,
            "Second Cleanup lost portable missing-partner state")
        scrNTTEFullTwinsHistoryVat(_history,noone,true,"json-orphan-lost-again")
    }
    if(_mode=="legacy-pair") {
        var _partner=_new.partner
        instance_destroy(_new)
        assert(array_length(GameCont.ntte_pet_history)==1,"Legacy-imported Twins Cleanup failed history")
        var _history=GameCont.ntte_pet_history[0]
        assert(variable_struct_exists(_history[3],"partner") && scrNTTEFullTwinsHistorySame(_history[3].partner,_partner),
            "Importing old history erased new source partner registration")
        scrNTTEFullTwinsHistoryVat(_history,_partner,false,"legacy-json-pair-lost-again")
    }
    scrNTTESmokeLog("TWINS HISTORY JSON "+_mode+" @"+string(30/timescale)
        +" count_before_step="+string(_count)+" count_after_step="+string(_expect))
    scrNTTEFullTwinsHistoryClear()
}
function scrNTTEFullTwinsHistorySessionCase(_live,_fresh=false) {
    scrNTTEFullTwinsHistoryClear()
    var _p=instance_find(Player,0),_a=noone,_b=noone,_buffer=-1,_again=-1,
        _tag=_fresh?"fresh":(_live?"live":"dead")
    if(_fresh) {
        _a=scrNTTEFullPetCreate(170000,170000,"Twins")
        assert(scrNTTEFullPetTake(_a,_p),"Never-paired history setup could not acquire new pet")
    } else {
        var _pair=scrNTTEFullTwinsHistoryPair(170000,170000,true)
        _a=_pair[0];_b=_pair[1]
    }
    instance_destroy(_a)
    if(!_live && !_fresh) { _b.history=[];instance_destroy(_b) }
    var _runtime_history=GameCont.ntte_pet_history,_runtime_partner=_runtime_history[0][3].partner
    GameCont.ntte_full_pet_save=scrNTTEFullPetExport()
    try {
        _buffer=buffer_create(4096,buffer_grow,1)
        scrSavegameSession(_buffer,false)
        var _bytes=buffer_tell(_buffer)
        assert(GameCont.ntte_pet_history==_runtime_history && _runtime_history[0][3].partner==_runtime_partner,
            "Session exporter mutated source-shaped runtime history")
        buffer_seek(_buffer,buffer_seek_start,0)
        assert(buffer_read(_buffer,buffer_u8)==SavegamePart.SessionData,"Native binary session marker changed")
        var _json=buffer_read(_buffer,buffer_string),_session=json_parse(_json),_saved=undefined
        for(var _i=0;_i<array_length(_session.session_data);++_i)
            if(_session.session_data[_i].name=="ntte_pet_history") _saved=_session.session_data[_i].value
        assert(is_struct(_saved) && _saved.schema==1 && array_length(_saved.rows)==1
            && !variable_struct_exists(_saved.rows[0].data[3],"partner")
            && !variable_struct_exists(_saved.rows[0].data[3],"ntte_twins_missing_partner")
            && (_live ? _saved.rows[0].partner==0:(_saved.rows[0].partner==-1 && _saved.rows[0].missing_partner==!_fresh)),
            "Actual binary Session JSON leaked raw history ref or lost portable relationship")
        assert(scrNTTEFullPetHistoryExport(_saved)==_saved,
            "A pending portable envelope was wrapped or rewritten by a second save")
        with(NTTEFullPet) {history=[];instance_destroy()}
        _p.ntte_pet=[];GameCont.ntte_pet_history=[]
        buffer_seek(_buffer,buffer_seek_start,0)
        scrSavegameSession(_buffer,true)
        assert(is_struct(GameCont.ntte_pet_history),"Actual binary Session did not read portable history envelope")
        assert(scrNTTEFullPetImport(GameCont.ntte_full_pet_save),"Session PetImport failed")
        assert(!instance_exists(_a) && !instance_exists(_b),"Session kept old physical Twins IDs")
        var _history=GameCont.ntte_pet_history
        assert(is_array(_history) && array_length(_history)==1,"Post-session history did not return to native source shape")
        // Save -> actual Session load -> PetImport -> save again must regenerate
        // the same portable relationship without retaining the first IDs.
        GameCont.ntte_full_pet_save=scrNTTEFullPetExport()
        _again=buffer_create(4096,buffer_grow,1)
        scrSavegameSession(_again,false)
        var _again_bytes=buffer_tell(_again)
        buffer_seek(_again,buffer_seek_start,0)
        assert(buffer_read(_again,buffer_u8)==SavegamePart.SessionData,"Second native Session marker changed")
        var _again_session=json_parse(buffer_read(_again,buffer_string)),_again_history=undefined
        for(var _i=0;_i<array_length(_again_session.session_data);++_i)
            if(_again_session.session_data[_i].name=="ntte_pet_history") _again_history=_again_session.session_data[_i].value
        assert(json_stringify(_again_history)==json_stringify(_saved),
            "Save/load/save changed portable lost-Twins relationship or wrapped history twice")
        with(NTTEFullPet) {history=[];instance_destroy()}
        _p.ntte_pet=[];GameCont.ntte_pet_history=[]
        buffer_seek(_again,buffer_seek_start,0)
        scrSavegameSession(_again,true)
        assert(scrNTTEFullPetImport(GameCont.ntte_full_pet_save),"Second native Session PetImport failed")
        _history=GameCont.ntte_pet_history
        assert(is_array(_history) && array_length(_history)==1,"Second native Session history decode failed")
        var _partner=noone
        if(_live) {
            with(NTTEFullPet) if(pet=="Twins") _partner=id
            assert(instance_exists(_partner) && _partner!=_b && scrNTTEFullTwinsHistorySame(_history[0][3].partner,_partner)
                && _partner.ntte_twins_missing_partner && _partner.partner==noone,
                "Session live history did not remap surviving companion ID/missing backlink")
        } else assert(_history[0][3].partner==noone && _history[0][3].ntte_twins_missing_partner==!_fresh,
            "Session dead history lost already-paired state")
        scrNTTEFullTwinsHistoryVat(_history[0],_partner,!_live && !_fresh,"session-history-"+_tag,_fresh)
        scrNTTESmokeLog("TWINS HISTORY NATIVE SESSION "+_tag+" @"+string(30/timescale)
            +" actual_buffer_bytes="+string(_bytes)+" second_buffer_bytes="+string(_again_bytes))
    } finally {
        if(buffer_exists(_buffer)) buffer_delete(_buffer)
        if(buffer_exists(_again)) buffer_delete(_again)
        scrNTTEFullTwinsHistoryClear()
    }
}
// BEGIN NTTE TWINS JSON VALUE CONTRACT
// Reuse the independently native-tested JSON comparator: exact fields/types,
// recursive array order, binary64 values; struct enumeration order is immaterial.
function scrNTTEFullTwinsHistoryJSONValueContract() {
    var _base=[["Parrot","mod","petlib",{bskin:1,team:0,stat_found:false,
        audit_payload:["unchanged",{nested:17}]}]],_text=json_stringify(_base),
        _reordered=[["Parrot","mod","petlib",{audit_payload:["unchanged",{nested:17.0}],
            stat_found:false,team:0.0,bskin:1.0}]]
    assert(scrNTTEFullCuzConnectedValueEqual(_base,_reordered)
        && scrNTTEFullCuzConnectedValueEqual(_base,json_parse(_text)),
        "Twins JSON comparator rejected reordered fields or exact JSON values")
    var _keys=variable_struct_get_names(_base[0][3])
    for(var _i=0;_i<array_length(_keys);++_i) {
        var _key=_keys[_i],_changed=json_parse(_text)
        variable_struct_remove(_changed[0][3],_key)
        assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted missing field "+_key)
        _changed=json_parse(_text);_changed[0][3][$ "extra_"+_key]=0
        assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted extra field "+_key)
    }
    var _changed=json_parse(_text);_changed[0][3].audit_payload[1].nested=18
    assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted nested value change")
    _changed=json_parse(_text);_changed[0][3].stat_found=0
    assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted bool to number")
    _changed=json_parse(_text);_changed[0][3].bskin="1"
    assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted number to string")
    _changed=json_parse(_text);_changed[0][3].audit_payload=[{nested:17},"unchanged"]
    assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted reordered array")
    // Construct the adjacent representable binary64 directly, avoiding a
    // compiler decimal-literal fold or an epsilon-based equality predicate.
    var _bytes=buffer_create(8,buffer_fixed,1)
    try {
        buffer_poke(_bytes,0,buffer_f64,17)
        buffer_poke(_bytes,0,buffer_u8,buffer_peek(_bytes,0,buffer_u8)+1)
        var _adjacent=buffer_peek(_bytes,0,buffer_f64)
        assert(!scrNTTEFullPetCallbackLifetimeF64Equal(17,_adjacent),"Twins JSON negative control did not create a distinct F64")
        _changed=json_parse(_text);_changed[0][3].audit_payload[1].nested=_adjacent
        assert(!scrNTTEFullCuzConnectedValueEqual(_base,_changed),"Twins JSON comparator admitted one-ULP nested number change")
    } finally { buffer_delete(_bytes) }
    scrNTTESmokeLog("TWINS JSON VALUE CONTRACT PASS recursive exact fields/types/F64; array order; reordered keys accepted; mutation controls rejected")
}
// END NTTE TWINS JSON VALUE CONTRACT
function scrNTTEFullTwinsHistoryOrbitCase() {
    scrNTTEFullTwinsHistoryClear()
    var _players=scrNTTEFullAreaGeneratorSnapshot(Player),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _p=instance_find(Player,0),_origin_x=512,_origin_y=512,_parked=[],
        _nearby=scrNTTEFullInstances([hitme,damagesource,Portal,NTTEFullPrompt,WepPickup,
            NothingDeath,SitDown,ReviveCircle,CrystalShield])
    // Native x/y quantize to float32: at170000 the ULP is0.015625, already
    // larger than the strict0.001 geometric contract. Use ordinary room
    // coordinates and park existing nearby physical interactions instead.
    for(var _i=0;_i<array_length(_nearby);++_i) {
        var _candidate=_nearby[_i]
        if(_candidate.id!=_p.id && point_distance(_candidate.x,_candidate.y,_origin_x,_origin_y)<512) {
            array_push(_parked,_candidate);instance_deactivate_object(_candidate)
        }
    }
    try {
        var _pair=scrNTTEFullTwinsHistoryPair(_origin_x,_origin_y),_a=_pair[0],_b=_pair[1]
        _p.ntte_twins_orbit_wave=0;_p.wave=0;_p.speed=0;_p.can_walk=false;_p.can_shoot=false
        KeyCont.moving[_p.index]=0;KeyCont.hold_spec[_p.index]=false;KeyCont.press_spec[_p.index]=false
        KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false;KeyCont.press_swap[_p.index]=false
        _a.orbit_pull=1;_b.orbit_pull=1;_a.speed=0;_b.speed=0
        with(_a) event_perform(ev_step,ev_step_normal)
        with(_b) event_perform(ev_step,ev_step_normal)
        scrNTTESmokeLog("TWINS NATIVE ORBIT FIXTURE READONLY "+json_stringify({origin_x:_origin_x,
            origin_y:_origin_y,parked_nearby:array_length(_parked),player_real:real(_p.id),
            a_real:real(_a.id),b_real:real(_b.id),a_leader_real:real(_a.leader.id),b_leader_real:real(_b.leader.id)}))
        var _start_x=_a.x,_start_y=_a.y,_quadrants=[false,false,false,false],_frames=round(120/timescale),_tick=0
        repeat(_frames) {
            ++_tick
            // Draw may run zero or several times between logic updates.
            _p.wave=choose(0,6.19)
            with(_p) event_perform(ev_step,ev_step_normal)
            with(_a) event_perform(ev_step,ev_step_normal)
            with(_b) event_perform(ev_step,ev_step_normal)
            var _dx=_a.x-_p.x,_dy=_a.y-_p.y
            _quadrants[(_dx<0?1:0)+(_dy<0?2:0)]=true
            if(!(abs(point_distance(_a.x,_a.y,_p.x,_p.y)-26)<0.001
                && abs(_a.x+_b.x-2*_p.x)<0.001 && abs(_a.y+_b.y-2*_p.y)<0.001))
                scrNTTESmokeLog("TWINS NATIVE ORBIT FAILURE READONLY "+json_stringify({tick:_tick,
                    rate:30/timescale,player_real:real(_p.id),player_x:_p.x,player_y:_p.y,
                    player_phase:_p.ntte_twins_orbit_wave,player_wave:_p.wave,
                    a_x:_a.x,a_y:_a.y,b_x:_b.x,b_y:_b.y,
                    a_radius:point_distance(_a.x,_a.y,_p.x,_p.y),b_radius:point_distance(_b.x,_b.y,_p.x,_p.y),
                    opposite_error_x:_a.x+_b.x-2*_p.x,opposite_error_y:_a.y+_b.y-2*_p.y,
                    a_visible:_a.visible,b_visible:_b.visible,a_speed:_a.speed,b_speed:_b.speed,
                    a_leader_real:real(_a.leader.id),b_leader_real:real(_b.leader.id),
                    a_orbit_pull:_a.orbit_pull,b_orbit_pull:_b.orbit_pull}))
            assert(abs(point_distance(_a.x,_a.y,_p.x,_p.y)-26)<0.001
                && abs(_a.x+_b.x-2*_p.x)<0.001 && abs(_a.y+_b.y-2*_p.y)<0.001,
                "Actual native Twins Steps lost source orbit radius or opposite partner positions")
        }
        assert(abs(_p.ntte_twins_orbit_wave-120)<0.001
            && _quadrants[0] && _quadrants[1] && _quadrants[2] && _quadrants[3]
            && point_distance(_a.x,_a.y,_start_x,_start_y)<0.001,
            "Twins did not complete a full logical orbit independently of the native Draw bob phase")
        scrNTTESmokeLog("TWINS NATIVE ORBIT: actual Player/Pet Steps complete 360 degrees over 120 logic ticks; 26 radius/opposite pair; Draw phase independent @"+string(30/timescale))
    } finally {
        scrNTTEFullTwinsHistoryClear()
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
    }
}
function scrNTTEFullTwinsHistoryCompatibilityCase() {
    scrNTTEFullTwinsHistoryClear()
    var _vars={bskin:1,team:team_none,stat_found:false,audit_payload:["unchanged",{nested:17}]},
        _data=["Parrot","mod","petlib",_vars],_legacy=[_data]
    GameCont.ntte_pet_history=_legacy
    assert(!scrNTTEFullPetHistoryImport([]) && GameCont.ntte_pet_history==_legacy,
        "Legacy raw source-shaped history was reinterpreted as a portable envelope")
    var _encoded=scrNTTEFullPetHistoryExport(_legacy)
    assert(_encoded.rows[0].data==_data && _encoded.rows[0].data[3]==_vars
        && !variable_struct_exists(_vars,"partner") && !variable_struct_exists(_vars,"ntte_twins_missing_partner"),
        "Non-Twins history exporter mutated the source payload")
    GameCont.ntte_pet_history=json_parse(json_stringify(_encoded))
    assert(scrNTTEFullPetHistoryImport([]) && scrNTTEFullCuzConnectedValueEqual(GameCont.ntte_pet_history,_legacy),
        "Portable JSON changed non-Twins nested history payload")
    var _vat=instance_create(172000,172000,NTTEFullMutantVat)
    _vat.type="Pet";_vat.pet_data=GameCont.ntte_pet_history[0];_vat.hp=0
    with(_vat) event_perform(ev_step,ev_step_normal)
    var _parrot=noone
    with(NTTEFullPet) if(pet=="Parrot") _parrot=id
    assert(instance_exists(_parrot) && _parrot.bskin==1 && _parrot.team==team_none && !_parrot.stat_found
        && _parrot.audit_payload[0]=="unchanged" && _parrot.audit_payload[1].nested==17 && array_length(_parrot.history)==0,
        "Genuine non-Twins vat restore lost passthrough skin/team/custom nested payload/history clearing")
    with(_parrot) event_perform(ev_step,ev_step_normal)
    instance_destroy(_parrot)
    assert(array_length(GameCont.ntte_pet_history)==1,"Non-Twins vat cleanup repeated one-use history")
    // Old actual saves lacked Twins partner history. Preserve their previous
    // never-paired fallback, instead of inventing a missing-partner state.
    _legacy=[["Twins","mod","petlib",{bskin:1,team:team_none,stat_found:false}]]
    GameCont.ntte_pet_history=_legacy
    assert(!scrNTTEFullPetHistoryImport([]) && GameCont.ntte_pet_history==_legacy,
        "Legacy raw Twins history array was modified")
    _vat=instance_create(172000,172000,NTTEFullMutantVat)
    _vat.type="Pet";_vat.pet_data=_legacy[0];_vat.hp=0
    with(_vat) event_perform(ev_step,ev_step_normal)
    var _twin=noone
    with(NTTEFullPet) if(pet=="Twins") _twin=id
    assert(instance_exists(_twin) && _twin.partner==noone && !_twin.ntte_twins_missing_partner
        && array_length(_twin.history)==0,"Legacy vat fallback did not preserve never-paired/empty-history state")
    repeat(3) with(_twin) event_perform(ev_step,ev_step_normal)
    assert(scrNTTEFullTwinsHistoryCount()==2 && instance_exists(_twin.partner) && _twin.partner.bskin!=_twin.bskin,
        "Legacy history with no partner should create exactly one fresh opposite-skin pair")
    instance_destroy(_twin)
    assert(array_length(GameCont.ntte_pet_history)==1,"Legacy vat main pet re-registered source-cleared history")
    scrNTTEFullTwinsHistoryClear()
    scrNTTESmokeLog("TWINS HISTORY COMPATIBILITY: raw arrays untouched/non-Twins nested payload+genuine vat/legacy never-paired fallback/empty one-use history OK @"+string(30/timescale))
}
function scrNTTEFullPetTwinsHistoryNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),_progress=global.ntte_full_progress,_stop=lockstep_stop,
        _pinst_list=global.playerinstance_list,_pinst_graph={nodes:[]},_raw_menu_count=instance_number(Menu),
        _parked=scrNTTEFullInstances([Menu,NTTEFullPet,NTTEFullPrompt,NTTEFullPetRevive,NTTEFullMutantVat,Portal,LastDie,WepPickup])
    scrNTTEFullAreaSnapshotContainer(_pinst_list,_pinst_graph)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};lockstep_stop=false
    scrNTTESmokeLog("TWINS HISTORY NATIVE SCENE READONLY "+json_stringify({menu_before_parking:_raw_menu_count,
        menu_after_parking:instance_number(Menu),gencont_after_parking:instance_number(GenCont),
        levcont_after_parking:instance_number(LevCont),active_lockstep_stop:lockstep_stop}))
    try {
        assert(instance_exists(Player),"Twins history fixture needs actual Player")
        instance_create(170000,170000,LastDie)
        scrNTTEFullTwinsHistoryPhysicalCase(true,true)
        scrNTTEFullTwinsHistoryPhysicalCase(false)
        scrNTTEFullTwinsHistoryPhysicalCase(false,true)
        scrNTTEFullTwinsHistoryJSONCase("pair")
        scrNTTEFullTwinsHistoryJSONCase("dead")
        scrNTTEFullTwinsHistoryJSONCase("fresh")
        scrNTTEFullTwinsHistoryJSONCase("fresh-empty-history")
        scrNTTEFullTwinsHistoryJSONCase("legacy-pair")
        scrNTTEFullTwinsHistoryJSONCase("legacy-orphan")
        scrNTTEFullTwinsHistorySessionCase(true)
        scrNTTEFullTwinsHistorySessionCase(false)
        scrNTTEFullTwinsHistorySessionCase(false,true)
        scrNTTEFullTwinsHistoryJSONValueContract()
        scrNTTEFullTwinsHistoryCompatibilityCase()
        scrNTTEFullTwinsHistoryOrbitCase()
    } finally {
        scrNTTEFullTwinsHistoryClear()
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        global.playerinstance_list=_pinst_list
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_pinst_graph.nodes})
        scrNTTEFullVanillaFixtureEnd(_state);global.ntte_full_progress=_progress;lockstep_stop=_stop
    }
    scrNTTESmokeLog("SOURCE TWINS HISTORY: actual native Player pickup/Pet Steps/Cleanup/live+dead partner/Vat Step+Destroy; portable+legacy JSON remap; native Session binary history reload and genuine vat; no extra partner/owner damage OK @"+string(30/timescale))
}
