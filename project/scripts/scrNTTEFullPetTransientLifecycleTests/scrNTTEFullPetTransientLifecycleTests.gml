// Separate dedicated-process case. Existing WorldEventsRoomRestartTests keeps
// its default scope; only this entry enables the extra source lifecycle checks.
function scrNTTEFullPetTransientLifecycleTests() {
    scrNTTEFullWorldEventsRoomRestartTests()
    with(NTTEFullWorldEventsRoomRestartTest) ntte_pet_transient_test=true
}
function scrNTTEFullPetTransientLifecycleBeginRate() {
    pet_anim_done=false;pet_anim_ids=[];pet_late_ids=[];pet_baseline_ids=[]
    pet_end_checks=0;pet_start_checks=0;pet_observer=id;pet_late_created=false
}
function scrNTTEFullPetTransientLifecycleSpawn() {
    var _types=[NTTEFullPetGuardianShield,NTTEFullCrystalShieldDisappear,
        NTTEFullBloodLust,NTTEFullCrystTrail,NTTEFullWaterStreak],_created=[]
    for(var _i=0;_i<array_length(_types);++_i) {
        var _effect=instance_create(Player.x,Player.y,_types[_i])
        assert(!_effect.persistent && _effect.visible && sprite_exists(_effect.sprite_index),
            "Original native pet-effect clone lost nonpersistent visible source lifecycle/art: "+object_get_name(_types[_i]))
        if(variable_instance_exists(_effect,"creator")) _effect.creator=Player.id
        array_push(_created,_effect)
    }
    return _created
}
function scrNTTEFullPetTransientLifecycleAnimateBegin() {
    pet_anim_previous_disappear=scrNTTEFullInstances(NTTEFullCrystalShieldDisappear)
    pet_anim_ids=scrNTTEFullPetTransientLifecycleSpawn()
    pet_anim_elapsed=0;pet_anim_draw=draw_frames
    scrNTTEFullWorldEventsRoomRestartAwait(7)
}
function scrNTTEFullPetTransientLifecycleAnimateStep() {
    pet_anim_elapsed+=timescale
    assert(pet_anim_elapsed<180,"Original pet short effects failed actual scheduled animation/Alarm termination")
    var _alive=false
    for(var _i=0;_i<array_length(pet_anim_ids);++_i) _alive=_alive || instance_exists(pet_anim_ids[_i])
    var _disappear=scrNTTEFullInstances(NTTEFullCrystalShieldDisappear)
    for(var _i=0;_i<array_length(_disappear);++_i)
        if(array_get_index(pet_anim_previous_disappear,_disappear[_i])<0) _alive=true
    if(_alive) return;
    assert(pet_anim_elapsed>=6 && draw_frames>pet_anim_draw,
        "Pet transient animation witness ended without genuine scheduled Step/Draw frames")
    pet_anim_done=true
    scrNTTESmokeLog("PET TRANSIENT NATURAL LIFETIME five source clones ended by actual animation/Alarm chain, logicalTicks="
        +string(pet_anim_elapsed)+" Draws="+string(draw_frames-pet_anim_draw)+" @"+string(rates[pass_index]))
    scrNTTEFullWorldEventsRoomRestartAwait(3)
}
function scrNTTEFullPetTransientLifecycleLatePortal() {
    if(pet_late_created || portal.sprite_index!=sprBigPortalDisappear
        || portal.image_index<portal.image_number-1) return;
    // Create in the final native Disappear frame. Their original natural
    // lifetimes exceed the remaining animation time; no timer is stretched.
    pet_late_ids=scrNTTEFullPetTransientLifecycleSpawn()
    pet_baseline_ids=[instance_create(Player.x,Player.y,PopoShield),
        instance_create(Player.x,Player.y,AcidStreak)]
    pet_baseline_ids[0].creator=Player.id
    for(var _i=0;_i<array_length(pet_baseline_ids);++_i)
        assert(!pet_baseline_ids[_i].persistent,"Native baseline pet effect unexpectedly persistent")
    pet_late_created=true
}
function scrNTTEFullPetTransientLifecycleRoomEnd() {
    assert(pet_late_created && array_length(pet_late_ids)==5 && array_length(pet_baseline_ids)==2,
        "Actual engine RoomEnd lacks source-clone/native baseline witnesses")
    for(var _i=0;_i<array_length(pet_late_ids);++_i)
        assert(instance_exists(pet_late_ids[_i]),"Source short effect expired before measured room disposal")
    for(var _i=0;_i<array_length(pet_baseline_ids);++_i)
        assert(instance_exists(pet_baseline_ids[_i]),"Native baseline effect expired before measured room disposal")
    assert(id==pet_observer && persistent,"Positive persistent observer control changed before RoomEnd")
    pet_end_checks++
}
function scrNTTEFullPetTransientLifecycleRoomStart() {
    for(var _i=0;_i<array_length(pet_late_ids);++_i)
        assert(!instance_exists(pet_late_ids[_i]),"Source pet transient survived real engine room disposal")
    for(var _i=0;_i<array_length(pet_baseline_ids);++_i)
        assert(!instance_exists(pet_baseline_ids[_i]),"Native baseline transient survived real engine room disposal")
    assert(id==pet_observer && instance_exists(pet_observer) && persistent,
        "Actual restart lost the positive persistent observer control")
    pet_start_checks++
}
function scrNTTEFullPetTransientLifecycleAfterHop() {
    assert(pet_late_created && pet_end_checks==hops+1 && pet_start_checks==hops+1,
        "Pet source lifecycle lacks actual engine RoomEnd/RoomStart witnesses")
    scrNTTESmokeLog("PET TRANSIENT REAL RESTART hop="+string(hops+1)
        +" five source clones + two native baselines alive at real RoomEnd, absent at RoomStart; persistent observer retained @"
        +string(rates[pass_index]))
    pet_late_created=false
}
