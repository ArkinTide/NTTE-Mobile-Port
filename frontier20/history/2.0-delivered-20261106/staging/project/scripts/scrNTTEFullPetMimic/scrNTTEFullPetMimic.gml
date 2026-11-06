// Source petlib.Mimic; native per-weapon state travels with its dropped item.
function scrNTTEFullPetMimicCreate() {
    spr_idle=scrNTTERefSprite("PetMimicIdle"); spr_walk=scrNTTERefSprite("PetMimicWalk")
    spr_hurt=scrNTTERefSprite("PetMimicHurt"); spr_icon=scrNTTERefSprite("PetMimicIcon")
    spr_open=scrNTTERefSprite("PetMimicOpen"); spr_hide=scrNTTERefSprite("PetMimicHide")
    spr_shadow_y=-1; spr_bubble_y=-1; depth=-1; mask_index=mskFreak; maxspeed=2; push=0
    wep=wep_none; wep_inst=noone; ammo=true; curse=0; open=false; hush=0; hushtime=0; ntte_state=undefined
    prompt_mimic=scrNTTEFullPromptCreate(id,"DROP")
    array_push(history,"wep","curse","ammo","ntte_state")
    stat.weapons=scrNTTEFullValue(stat,"weapons",[])
    hooks={anim:method(id,scrNTTEFullPetMimicAnim),step:method(id,scrNTTEFullPetMimicStep),alarm:method(id,scrNTTEFullPetMimicAlarm),hurt:method(id,scrNTTEFullPetMimicHurt),draw:method(id,scrNTTEFullPetMimicDraw),cleanup:method(id,scrNTTEFullPetMimicCleanup)}
}
function scrNTTEFullPetMimicAnim() {
    if(sprite_index!=spr_hurt || image_index>=sprite_get_number(spr_hurt)-image_speed) {
        if(speed>0) sprite_index=spr_walk
        else if(sprite_index!=spr_walk || (image_index>=3 && image_index<3+image_speed)) sprite_index=instance_exists(leader) ? spr_idle:spr_hide
    }
}
function scrNTTEFullPetMimicDrop(_wep,_curse,_ammo,_state) {
    var _item=scrWeaponPickupCreate(x,y,_wep)
    _item.curse=_curse; _item.ammo=_ammo; _item.roll=_ammo; _item.ntte_state=_state
    return _item
}
function scrNTTEFullPetMimicRemember(_wep) {
    if(array_get_index(stat.weapons,_wep)<0) array_push(stat.weapons,_wep)
}
function scrNTTEFullPetMimicStep() {
    if(instance_exists(prompt_mimic)) prompt_mimic.visible=false
    if(instance_exists(leader)) {
        if(place_meeting(x,y,Player)) {
            walk=0; sprite_index=spr_open
            if(!open) {
                open=true
                if(scr_weapon_is_valid(wep)) {
                    wep_inst=scrNTTEFullPetMimicDrop(wep,curse,ammo,ntte_state)
                    wep=wep_none; ntte_state=undefined
                }
                snd_play(sndGoldChest,0.9+random(0.2),0.8-hush); snd_play(sndMimicSlurp,0.9+random(0.2),0.8-hush)
                var _fx=instance_create(x,y,FXChestOpen); _fx.depth=depth-1; hush=min(hush+0.2,0.3); hushtime=60
            }
            if(!scr_weapon_is_valid(wep) && !place_meeting(x,y,WepPickup) && instance_exists(prompt_mimic)) {
                prompt_mimic.visible=true
                if(prompt_mimic.pick>=0) {
                    var _player=noone,_index=prompt_mimic.pick
                    with(Player) if(index==_index) _player=id
                    if(instance_exists(_player) && _player.can_pick && scr_weapon_is_valid(_player.wep)) {
                        if(_player.curse<=0) {
                            wep_inst=scrNTTEFullPetMimicDrop(_player.wep,0,false,_player.ntte_state)
                            snd_play_hit(sndSwapGold,0.1); snd_play_hit(_player.wep==wep_guitar ? sndGuitarPickup:sndWeaponPickup,0.1)
                            var _fx=instance_create(x+orandom(4),y+orandom(4),CaveSparkle); _fx.depth=depth-1
                            _player.wep=wep_none; _player.curse=0; _player.ntte_state=undefined
                            with(_player) { scrSwapWeps(); clicked=false }
                        } else snd_play_hit(sndCursedReminder,0.05)
                    }
                }
            }
            var _nearest=instance_nearest(x,y,WepPickup)
            if(instance_exists(_nearest)) scrNTTEFullPetMimicRemember(_nearest.wep)
        } else if(open) {
            open=false; wep_inst=noone
            if(!scr_weapon_is_valid(wep) && place_meeting(x,y,WepPickup)) {
                var _nearest=noone,_distance=infinity,_pet=id
                with(WepPickup) if(visible) {
                    var _d=point_distance(x,y,_pet.x,_pet.y)
                    if(_d<_distance) { _distance=_d; _nearest=id }
                }
                var _touching=false
                with(_nearest) _touching=place_meeting(x,y,_pet)
                if(_touching) {
                    curse=_nearest.curse; ammo=false; wep=_nearest.wep
                    ntte_state=scrNTTEFullValue(_nearest,"ntte_state",undefined); instance_destroy(_nearest)
                }
            }
        }
        scrNTTEFullPetMimicRemember(wep)
    }
    if(hushtime<=0) hush=max(hush-0.1*timescale,0)
    else hushtime-=timescale
    if(instance_exists(wep_inst)) { wep_inst.x=x; wep_inst.y=y; wep_inst.speed=0 }
    if((current_frame mod (10+orandom(2)))<timescale) instance_create(x+orandom(12),y+orandom(12),CaveSparkle)
}
function scrNTTEFullPetMimicDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
    if(open) { var _pet=id; with(WepPickup) if(place_meeting(x,y,_pet)) event_perform(ev_draw,0) }
}
function scrNTTEFullPetMimicAlarm(_leader_dir,_leader_dis) {
    if(instance_exists(leader) && _leader_dis>16) {
        if(!is_undefined(path_dir)) { scrNTTEFullPetWalk(path_dir,12); right=lengthdir_x(1,direction)>=0 ? 1:-1; return irandom_range(3,walk) }
        else if(_leader_dis>48) { scrNTTEFullPetWalk(_leader_dir+orandom(10),20+random(max(0,_leader_dis-64))); right=lengthdir_x(1,direction)>=0 ? 1:-1 }
    }
    return 30+irandom(30)
}
function scrNTTEFullPetMimicHurt(_damage,_direction,_force=0) {
    if(sprite_index!=spr_open) { sprite_index=spr_hurt; image_index=0 }
    return true
}
function scrNTTEFullPetMimicCleanup() { if(instance_exists(prompt_mimic)) instance_destroy(prompt_mimic,false) }
function scrNTTEFullPetMimicTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[]),_old_x=_p.x,_old_y=_p.y
    _p.ntte_pet=[]
    var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Mimic"); scrNTTEFullPetTake(_pet,_p)
    _pet.wep=wep_revolver; _pet.curse=1; _pet.ntte_state={sentinel:42}; _pet.ammo=false
    with(_pet) scrNTTEFullPetMimicStep()
    var _item=_pet.wep_inst
    assert(_pet.open && instance_exists(_item) && _item.wep==wep_revolver && _item.curse==1 && _item.ntte_state.sentinel==42,
        "Pet Mimic did not expose original stored weapon/curse and full native state")
    _p.x+=80
    with(_pet) scrNTTEFullPetMimicStep()
    assert(!_pet.open && !instance_exists(_item) && _pet.wep==wep_revolver && _pet.ntte_state.sentinel==42 && !_pet.ammo,
        "Pet Mimic did not re-store ground weapon without duplicating pickup ammo")
    _p.x=_old_x; _p.y=_old_y
    _pet.wep=wep_ntte_sawblade_gun; _pet.ntte_state=scrNTTENewState(_pet.wep)
    _pet.ntte_state.ammo=1; _pet.ntte_state.outstanding=2; _pet.ntte_state.epoch=7
    var _saved=json_parse(json_stringify(scrNTTEFullPetExport()))
    assert(scrNTTEFullPetImport(_saved),"Mimic continuation schema failed")
    _pet=_p.ntte_pet[0]
    assert(_pet.pet=="Mimic" && _pet.wep==wep_ntte_sawblade_gun && _pet.ntte_state.ammo==3
        && _pet.ntte_state.outstanding==0 && _pet.ntte_state.epoch==8 && is_callable(_pet.hooks.step),
        "Mimic continuation lost stored weapon methods or failed native outstanding/epoch normalization")
    scrNTTEFullPetMimicNearestTests(_pet)
    var _prompt=_pet.prompt_mimic
    instance_destroy(_pet)
    assert(!instance_exists(_prompt),"Pet Mimic cleanup leaked DROP prompt")
    _p.ntte_pet=_old_pets
    scrNTTESmokeLog("SYSTEMS PET MIMIC: actual drop/re-store/curse/full state/no ammo duplication, JSON outstanding/epoch restore, prompt cleanup OK")
}
// Original petlib selects the nearest visible pickup before checking contact.
function scrNTTEFullPetMimicNearestTests(_pet) {
    _pet.x=120000; _pet.y=120000; _pet.wep=wep_none; _pet.ntte_state=undefined
    _pet.wep_inst=noone; _pet.open=true; _pet.image_angle=0; _pet.image_xscale=1; _pet.image_yscale=1
    var _near=scrWeaponPickupCreate(_pet.x+21,_pet.y,wep_revolver)
    var _far=scrWeaponPickupCreate(_pet.x+19,_pet.y+10,wep_shotgun)
    try {
        _near.image_angle=0; _near.image_xscale=1; _near.image_yscale=1; _near.speed=0
        _far.image_angle=0; _far.image_xscale=1; _far.image_yscale=1; _far.speed=0
        assert(_pet.mask_index==mskFreak && _near.mask_index==mskWepPickup && _far.mask_index==mskWepPickup,
            "Mimic nearest fixture must retain original native masks")
        assert(point_distance(_pet.x,_pet.y,_near.x,_near.y)<point_distance(_pet.x,_pet.y,_far.x,_far.y),
            "Mimic nearest fixture origin ordering invalid")
        var _near_touch=false,_far_touch=false,_any_touch=false
        with(_near) _near_touch=place_meeting(x,y,_pet)
        with(_far) _far_touch=place_meeting(x,y,_pet)
        with(_pet) _any_touch=place_meeting(x,y,WepPickup)
        assert(!_near_touch && _far_touch && _any_touch,"Mimic nearest native mask counterexample invalid")
        with(_pet) scrNTTEFullPetMimicStep()
        assert(!_pet.open && _pet.wep==wep_none && instance_exists(_near) && instance_exists(_far),
            "Mimic must select nearest visible weapon before contact; farther touching weapon must remain")
        _near.visible=false; _pet.open=true; _far.curse=1; _far.ntte_state={nearest_sentinel:73}
        with(_pet) scrNTTEFullPetMimicStep()
        assert(!_pet.open && _pet.wep==wep_shotgun && _pet.curse==1 && !_pet.ammo
            && _pet.ntte_state.nearest_sentinel==73 && instance_exists(_near) && !instance_exists(_far),
            "Mimic nearest visible contact failed to restore full weapon state")
        scrNTTESmokeLog("SYSTEMS PET MIMIC NEAREST: native default masks, nearest noncontact preserved, hidden nearest excluded, touching pickup curse/state/no-ammo restored OK")
    } finally {
        if(instance_exists(_near)) instance_destroy(_near)
        if(instance_exists(_far)) instance_destroy(_far)
    }
}
