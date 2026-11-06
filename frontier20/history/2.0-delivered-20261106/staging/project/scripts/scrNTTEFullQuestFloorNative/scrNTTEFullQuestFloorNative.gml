// tescrapyard1250..1470. Actual artifact chest, floor controller and persistent
// source quest:part:index state. Crabbone physical ownership is shared with its
// weapon adapter; the complete merged chain remains one transferred weapon.
function scrNTTEFullQuestWeaponHasPart(_weapon,_part,_state=undefined) {
    var _parts=scrNTTEFullCrabboneParts(_weapon)
    for(var _i=0;_i<array_length(_parts);++_i) {
        if(scrNTTEFullCrabbonePartIndex(_parts[_i],_i==0?_state:undefined)==_part) return true
    }
    return false
}
function scrNTTEFullQuestChestCreate() {
    sprite_index=scrNTTERefSprite("QuestChest");spr_dead=scrNTTERefSprite("QuestChestOpen");spr_shadow=shd32;snd_open=sndWeaponChest
    wep=scrNTTEFullCrabboneCreateModel(-1);on_step=scrNTTEFullQuestChestStep;on_open=scrNTTEFullQuestChestOpen
}
function scrNTTEFullQuestChestStep() {
    if(random(60)<timescale) {
        var _sparkle=instance_create(random_range(bbox_left,bbox_right),random_range(bbox_top,bbox_bottom),NTTEFullVaultFlowerSparkle)
        _sparkle.sprite_index=scrNTTERefSprite("QuestSparkle");_sparkle.depth=depth-1
    }
}
function scrNTTEFullQuestChestOpen(_opener) {
    var _pickup=scrWeaponPickupCreate(x,y,wep)
    _pickup.ammo=true
// BEGIN NTTE PALACE ARTIFACT CONTINUE TEST OPENED
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactContinueTest)) try { scrNTTEFullPalaceArtifactContinueOpened(id,_opener,_pickup); }
catch(_ntte_palace_artifact_error) { scrNTTEFullPalaceArtifactContinueAbort(_ntte_palace_artifact_error); }
// END NTTE PALACE ARTIFACT CONTINUE TEST OPENED
// BEGIN NTTE HQ STOLEN CONTINUE TEST OPENED
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullHQStolenContinueTest)) try { scrNTTEFullHQStolenContinueOpened(id,_opener,_pickup); }
catch(_ntte_hq_stolen_error) { scrNTTEFullHQStolenContinueAbort(_ntte_hq_stolen_error); }
// END NTTE HQ STOLEN CONTINUE TEST OPENED
// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST OPENED
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryOpened(id,_opener,_pickup); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST OPENED
}
// Public source artifact-auto-stack exclusion: merely standing on a floor is
// insufficient; the real quest controller must own that exact live Floor.
function scrNTTEFullQuestFloorTouch(_actor) {
    if(!instance_exists(_actor) || instance_exists(enemy)) return false
    var _controllers=scrNTTEFullInstances(NTTEFullQuestFloorCont)
    for(var _i=0;_i<array_length(_controllers);++_i) {
        var _floor=_controllers[_i].target
        if(instance_exists(_floor)) with(_actor) if(place_meeting(x,y,_floor)) return true
    }
    return false
}
function scrNTTEFullQuestFloorPromptMeet(_player) {
    if(!instance_exists(creator) || !instance_exists(_player) || instance_exists(enemy)) return false
    return scrNTTEFullQuestWeaponHasPart(_player.wep,creator.part_index,scrNTTEFullValue(_player,"ntte_state",undefined))
}
function scrNTTEFullQuestFloorCreate() {
    part_index=-1;last_weapon_pickup_num=-1;last_weapon_pickup_id=noone;target=noone
    visible=true;prompt=scrNTTEFullPromptCreate(id,loc("NTTE:PetMimic:Prompt","DROP"),mskWepPickup)
    prompt.on_meet=scrNTTEFullQuestFloorPromptMeet
}
function scrNTTEFullQuestFloorSparkle(_part,_target) {
    var _sparkle=instance_create(random_range(_target.bbox_left,_target.bbox_right),random_range(_target.bbox_top,_target.bbox_bottom),NTTEFullVaultFlowerSparkle)
    _sparkle.sprite_index=scrNTTERefSprite("QuestSparkle");_sparkle.depth=min(_target.depth-1,1)
    switch(_part) {
        case 0:_sparkle.sprite_index=scrNTTERefSprite("AllyLaserCharge");break
        case 1:_sparkle.sprite_index=scrNTTERefSprite("ElectroPlasmaTrail");break
        case 2:_sparkle.sprite_index=sprIDPDPortalCharge;break
        case 3:_sparkle.sprite_index=sprLaserCharge;break
    }
}
function scrNTTEFullQuestFloorDrop(_player) {
    var _ok=false
    if(instance_exists(prompt)) with(prompt) _ok=scrNTTEFullQuestFloorPromptMeet(_player)
    if(!_ok) return noone
    if(_player.curse>0) { snd_play_hit(sndCursedReminder,0.05);return noone }
    var _model=scrNTTEFullWeaponModel(_player.wep)
    if(!is_struct(_model)) _model=scrNTTEFullCrabbonePhysical(_player.wep,_player.ntte_state)
    var _state=scrNTTEFullWeaponNativeState(_model),_previous=scrNTTEFullValue(_model,"ammo_wep",wep_none)
    // A native numeric artifact may only have its physical chain in state.
    if(_previous==wep_none) _previous=scrNTTEFullValue(_state,"ammo_wep",wep_none)
    _player.wep=scrNTTEFullWeaponNative(_previous)
    _player.ntte_state=scrNTTEFullWeaponNativeState(_previous)
    if(_player.wep==wep_none) with(_player) {
        scrSwapWeps(false);clicked=false;swapmove=1;drawempty=30
    }
    _model.ammo=1;_state.ammo=1;_model.ammo_wep=wep_none;_state.ammo_wep=wep_none
    var _pickup=scrWeaponPickupCreate(x,y,_model)
    _pickup.image_index=1
    snd_play_hit(sndWeaponPickup,0.1);scrNTTEFullDiscWeaponSound(sndStatueXP,0.6+random(0.2),0.8)
    scrNTTEFullUnlockSet("quest:part:"+string(part_index),true)
    return _pickup
}
function scrNTTEFullQuestFloorRemember() {
    var _num=instance_number(WepPickup),_first=instance_exists(WepPickup)?WepPickup.id:noone,_persistent=false
    with(WepPickup) if(persistent) _persistent=true
    if(last_weapon_pickup_num!=_num || last_weapon_pickup_id!=_first || _persistent) {
        last_weapon_pickup_num=_num;last_weapon_pickup_id=_first
        var _state=false,_pickups=scrNTTEFullInstances(WepPickup)
        for(var _i=0;_i<array_length(_pickups);++_i) if(_pickups[_i].visible
            && scrNTTEFullQuestWeaponHasPart(_pickups[_i].wep,part_index,scrNTTEFullValue(_pickups[_i],"ntte_state",undefined))) { _state=true;break }
        scrNTTEFullUnlockSet("quest:part:"+string(part_index),_state)
    }
}
function scrNTTEFullQuestFloorStep() {
    if(!instance_exists(target)) { instance_destroy();return }
    if((current_frame%10)<timescale && !instance_exists(enemy)) {
        var _sparkle=false
        with(target) _sparkle=place_meeting(x,y,Player)
        var _players=scrNTTEFullInstances(Player)
        for(var _i=0;_i<array_length(_players) && !_sparkle;++_i) {
            var _player=_players[_i]
            if(scrNTTEFullQuestWeaponHasPart(_player.wep,part_index,scrNTTEFullValue(_player,"ntte_state",undefined))
                || scrNTTEFullQuestWeaponHasPart(_player.bwep,part_index,scrNTTEFullValue(_player,"bntte_state",undefined))) _sparkle=true
        }
        if(_sparkle) {
            var _chest=asset_get_index("NTTEFullLockedHugeQuestChest"),_targets=[]
            if(object_exists(_chest)) with(_chest) if(is_unlockable) array_push(_targets,id)
            if(array_length(_targets)<=0) array_push(_targets,target)
            for(var _i=0;_i<array_length(_targets);++_i) scrNTTEFullQuestFloorSparkle(part_index,_targets[_i])
        }
    }
    if(instance_exists(prompt) && prompt.pick>=0) {
        var _player=noone,_pick=prompt.pick
        with(Player) if(index==_pick) _player=id
        if(scrNTTEFullPlayerActive(_player)) scrNTTEFullQuestFloorDrop(_player)
    }
    scrNTTEFullQuestFloorRemember()
}
