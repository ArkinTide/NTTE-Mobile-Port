// Dedicated-process asynchronous scheduled AI acceptance. Ownership/terrain
// are controlled inputs; this does not certify source pet discovery or Prompt.
function scrNTTEFullSlaughterFetchNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Slaughter natural fetch requires explicit desktop smoke")
    var _object=asset_get_index("NTTEFullSlaughterFetchNaturalTest")
    assert(object_exists(_object) && !instance_exists(_object),"Slaughter fetch observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        restored=false;old_save_map=UberCont.saveData;fixture_save_map=ds_map_create()
        ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        rate=game_get_speed(gamespeed_fps)
        assert((rate==30 || rate==60) && abs(timescale-30/rate)<0.0001,"Slaughter fetch needs actual native30/60")
        player=instance_find(Player,0);phase=0;case_index=0;elapsed=0;draw_frames=0;draw_start=0
        names=["source-string","numeric-bone","physical-bone","ancient","guarded","stolen","missing",
            "merged-bone-stock","merged-artifact-stock","inactive-bone-stock","nonbone",
            "bone-front-only","invisible","far","wall"]
        global.ntte_full_progress=json_parse(json_stringify(state.progress))
        GameCont.area=area_desert;GameCont.loops=0;GameCont.crown=Crown.None
        GameCont.gocrib=false;GameCont.nochest=1;GameCont.noradch=1
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    }
}
function scrNTTEFullSlaughterFetchNaturalFinish() {
    if(restored) return;
    restored=true
    scrNTTEFullWorldEventsNaturalWorldRestore(state)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
}
function scrNTTEFullSlaughterFetchNaturalSetup() {
    // Dispose the preceding completed scenario, never a measured pickup.
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    player.x=48000;player.y=48000;player.xprevious=player.x;player.yprevious=player.y
    player.speed=0;player.can_walk=false;player.can_aim=false
    player.hp=100000;player.max_hp=100000;player.nexthurt=current_frame+100000
    player.wep=wep_revolver;player.bwep=wep_revolver;player.ntte_pet=[];player.ntte_pet_max=1
    scr_camera_set_position(player.x,player.y,fa_center,fa_middle)
    scrNTTEFullFloorFill(player.x,player.y,9,9)
    pet_inst=scrNTTEFullPetCreate(player.x+24,player.y,"Slaughter")
    assert(scrNTTEFullPetTake(pet_inst,player),"Controlled source Slaughter ownership failed")
    assert(pet_inst.sprite_index==pet_inst.spr_spwn && pet_inst.my_bone==noone && pet_inst.target==noone,
        "Slaughter natural fixture skipped original spawn/empty targeting state")
    var _weapon=wep_ntte_bone
    switch(case_index) {
        case 0:_weapon="crabbone";break
        case 1:break
        case 2:_weapon=scrNTTEFullCrabboneCreateModel(-1,3);break
        case 3:case 4:case 5:case 6:_weapon=scrNTTEFullCrabboneCreateModel(case_index-3,2);break
        case 7:_weapon=scrNTTEFullWeaponMerge(scrNTTEFullCrabboneCreateModel(-1,2),wep_revolver);break
        case 8:_weapon=scrNTTEFullWeaponMerge(scrNTTEFullCrabboneCreateModel(0,2),scrNTTEFullCrabboneCreateModel(1,1));break
        case 9:
            _weapon=scrNTTEFullWeaponMerge(scrNTTEFullCrabboneCreateModel(-1,2),wep_revolver)
            scrNTTEFullWeaponMergeActive(_weapon,false);break
        case 10:_weapon=wep_revolver;break
        case 11:_weapon=scrNTTEFullWeaponMerge(wep_revolver,scrNTTEFullCrabboneCreateModel(-1,2));break
    }
    pickup=scrWeaponPickupCreate(pet_inst.x+24,pet_inst.y,_weapon)
    pickup_handle=pickup.wep;pickup_model=scrNTTEFullWeaponModel(pickup_handle)
    pickup_state=scrNTTEFullValue(pickup,"ntte_state",undefined)
    pickup_data=is_struct(pickup_model)?json_stringify(pickup_model):string(pickup_handle)
    assert(case_index!=0 || pickup_handle==wep_ntte_bone,"Source crabbone factory did not resolve native stock")
    if(case_index>=2 && case_index<=9)
        assert(scrNTTEFullWeaponIsNative(pickup_handle) && is_struct(pickup_model),"Physical Slaughter input bypassed actual native handle factory")
    if(case_index==12) pickup.visible=false
    if(case_index==13) {pickup.x=player.x+1024;pickup.xprevious=pickup.x}
    if(case_index==14) {
        pickup.x=player.x+96;pickup.xprevious=pickup.x
        for(var _dy=-192;_dy<=192;_dy+=16) instance_create(player.x+64,player.y+_dy,Wall)
        assert(collision_line(pet_inst.x,pet_inst.y,pickup.x,pickup.y,Wall,false,false),"Actual source Slaughter wall exclusion lacks a blocking native Wall")
    }
    expected_fetch=case_index<10;saw_target=false;saw_carry=false;alarm_cycles=0
    previous_alarm=pet_inst.ntte_pet_alarm;initial_bites=pet_inst.stat.bites
    elapsed=0;draw_start=draw_frames;phase=1
}
function scrNTTEFullSlaughterFetchNaturalStepBody() {
    assert(game_get_speed(gamespeed_fps)==rate && abs(timescale-30/rate)<0.0001,
        "Slaughter natural fetch lost actual rate/logic scale")
    elapsed+=timescale
    assert(elapsed<=480,"Scheduled Slaughter fetch timeout case="+names[case_index]+" phase="+string(phase))
    player.speed=0;player.can_walk=false;player.can_aim=false
    player.hp=100000;player.nexthurt=current_frame+100000
    if(phase==0) {scrNTTEFullSlaughterFetchNaturalSetup();return;}
    assert(instance_exists(pet_inst) && instance_exists(pickup),"Measured Slaughter pet/pickup disappeared before completion")
    if(pet_inst.ntte_pet_alarm>previous_alarm+0.1) alarm_cycles++
    previous_alarm=pet_inst.ntte_pet_alarm
    if(pet_inst.target==pickup) saw_target=true
    if(phase==1) {
        if(expected_fetch) {
            if(pet_inst.my_bone!=pickup) return;
            assert(saw_target && alarm_cycles>0 && pet_inst.stat.bites==initial_bites+1
                && draw_frames-draw_start>=8 && elapsed>=6,
                "Slaughter carry skipped genuine scheduled target/alarm/bite animation/Draw")
            assert(pickup.wep==pickup_handle && scrNTTEFullWeaponModel(pickup.wep)==pickup_model
                && scrNTTEFullValue(pickup,"ntte_state",undefined)==pickup_state,
                "Source Slaughter carry replaced physical handle/model/state identity")
            if(is_struct(pickup_model)) assert(json_stringify(pickup_model)==pickup_data,
                "Slaughter fetch consumed or rewrote physical ammo/merge data")
            saw_carry=true
            if(case_index==2) {
                // A real opposing enemy supplies the next natural attack.
                // Target, bite sprite/frame and carry/toss state remain source-owned.
                enemy_witness=instance_create(pet_inst.x+16,pet_inst.y,Bandit)
                enemy_witness.hp=1000;enemy_witness.max_hp=1000
                elapsed=0;draw_start=draw_frames;phase=2;return;
            }
        }
        else {
            assert(pet_inst.target!=pickup && pet_inst.my_bone!=pickup,
                "Source Slaughter selected excluded pickup case="+names[case_index])
            if(alarm_cycles<3 || elapsed<120 || pet_inst.sprite_index==pet_inst.spr_spwn) return;
            assert(draw_frames-draw_start>=8,"Negative Slaughter fetch lacked actual scheduled Draws")
        }
    }
    if(phase==2) {
        if(pet_inst.my_bone==pickup) return;
        assert(saw_carry && pet_inst.sprite_index==pet_inst.spr_fire && pet_inst.image_index<3
            && abs(pickup.hspeed)>0 && draw_frames>draw_start,
            "Physical bone was released without actual next enemy bite/source toss velocity")
        assert(pickup.wep==pickup_handle && scrNTTEFullWeaponModel(pickup.wep)==pickup_model
            && scrNTTEFullValue(pickup,"ntte_state",undefined)==pickup_state,
            "Natural Slaughter toss duplicated or replaced the real physical pickup")
    }
    scrNTTESmokeLog("SLAUGHTER FETCH NATURAL "+names[case_index]+" expected="+string(expected_fetch)
        +" actualAlarms="+string(alarm_cycles)+" Draws="+string(draw_frames-draw_start)+" @"+string(rate))
    if(++case_index<array_length(names)) {phase=0;return;}
    var _rate=rate
    scrNTTEFullSlaughterFetchNaturalFinish()
    scrNTTESmokeLog("FULL SLAUGHTER NATURAL FETCH: real scheduled spawn/alarm/target/bite/carry of source string, numeric/physical bone, four artifacts, merged/inactive stock; physical next enemy-bite toss identity; nonbone/front-only/invisible/distant/wall exclusions OK @"+string(_rate)+"; controlled ownership, no discovery/Prompt claim")
    instance_destroy(id,false)
}
function scrNTTEFullSlaughterFetchNaturalStep() {
    try {scrNTTEFullSlaughterFetchNaturalStepBody()}
    catch(_error) {scrNTTEFullSlaughterFetchNaturalFinish();throw _error}
}
