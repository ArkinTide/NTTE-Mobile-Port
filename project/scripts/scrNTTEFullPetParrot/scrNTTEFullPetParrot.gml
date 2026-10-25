// Source petlib.Parrot. All perched bob values are exact authored alpha bounds.
function scrNTTEFullPetParrotCreate() {
    spr_idle=scrNTTERefSprite(bskin==1 ? "PetParrotBIdle":"PetParrotIdle")
    spr_walk=scrNTTERefSprite(bskin==1 ? "PetParrotBWalk":"PetParrotWalk")
    spr_hurt=scrNTTERefSprite(bskin==1 ? "PetParrotBHurt":"PetParrotHurt")
    spr_icon=scrNTTERefSprite(bskin==1 ? "PetParrotBIcon":"PetParrotIcon")
    spr_note=scrNTTERefSprite("PetParrotNote"); spr_shadow=shd16; spr_shadow_y=4; spr_bubble_y=-2
    depth=-3; snd_note=sndSaplingSpawn; maxspeed=3.5
    perched=noone; perched_x=0; perched_y=0; pickup=noone; pickup_x=0; pickup_y=0; pickup_held=false; path_wall=[Wall]
    stat.pickups=scrNTTEFullValue(stat,"pickups",0)
    hooks={anim:method(id,scrNTTEFullPetParrotAnim),step:method(id,scrNTTEFullPetParrotStep),alarm:method(id,scrNTTEFullPetParrotAlarm),hurt:method(id,scrNTTEFullPetParrotHurt),draw:method(id,scrNTTEFullPetParrotDraw),skin:method(id,scrNTTEFullPetParrotSkin)}
}
function scrNTTEFullPetParrotSkin() {
    var _names=["idle","walk","hurt","icon"]
    for(var _i=0;_i<array_length(_names);++_i) {
        var _part=_names[_i]
        scrNTTEFullPetSkinField("spr_"+_part,scrNTTERefSprite("PetParrot"+(bskin==1 ? "B":"")+string_upper(string_char_at(_part,1))+string_delete(_part,1,1)))
    }
}
function scrNTTEFullPetParrotAnim() {
    if(sprite_index!=spr_hurt || image_index>=sprite_get_number(spr_hurt)-image_speed)
        sprite_index=speed>0 ? spr_walk:spr_idle
    if(sprite_index!=spr_hurt && instance_exists(SpiralCont) && !place_meeting(x,y,Floor)) sprite_index=spr_walk
}
function scrNTTEFullPetParrotStep() {
    if(variable_instance_exists(id,"wading")) {
        if(speed>0 || instance_exists(perched)) { canwade=false; wading=0 }
        else canwade=true
    }
    if(instance_exists(pickup)) {
        if(pickup_held) {
            if(point_distance(pickup.x,pickup.y,pickup_x,pickup_y)<maxspeed) {
                pickup.x=x; pickup.y=y+4; pickup.xprevious=pickup.x; pickup.yprevious=pickup.y
                if(pickup.blink<30) { pickup.blink=30; pickup.visible=true }
                pickup_x=pickup.x; pickup_y=pickup.y
            } else pickup=noone
        } else if(place_meeting(x,y,pickup)) {
            pickup_held=true; pickup_x=pickup.x; pickup_y=pickup.y
            if(!variable_instance_exists(pickup,"ntte_statparrot")) { pickup.ntte_statparrot=true; stat.pickups++ }
        }
        if(speed>=maxspeed*timescale-friction) speed+=abs(sin(wave/4))*timescale*timescale
    } else pickup_held=false
    if(instance_exists(perched) && perched.speed<=0 && !instance_exists(pickup)
        && scrNTTEFullValue(perched,"race",-1)!=Race.Horror) {
        x=perched.x; y=perched.y; perched_x=0
        perched_y=sprite_get_bbox_top(perched.sprite_index)-sprite_get_yoffset(perched.sprite_index)-4
        spr_bubble_y=-2+perched_y
    } else {
        if(perched!=noone) {
            perched=noone; x+=perched_x; y+=perched_y; spr_bubble_y-=perched_y; perched_x=0; perched_y=0
            scrNTTEFullPetWalk(random(360),16); right=lengthdir_x(1,direction)>=0 ? 1:-1
            if(!instance_exists(leader)) can_take=true
        }
        if(instance_exists(leader) && leader.visible && scrNTTEFullValue(leader,"race",-1)!=Race.Horror
            && point_distance(x,y,leader.x,leader.bbox_top-8)<8 && leader.speed<=0 && !instance_exists(pickup)) {
            perched=leader; snd_play(sndBouncerBounce,1.5+orandom(0.1))
        }
    }
}
function scrNTTEFullPetParrotDraw(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp) {
    if(instance_exists(perched)) {
        var _perch=perched
        _x+=perched_x; _y+=perched_y
        // The recreated runner calls the original PlayerSit object SitDown;
        // its explicit player field identifies the same sitting owner.
        var _owner=perched
        with(SitDown) if(player==_owner) _perch=id
        var _bob=scrNTTEFullPetParrotBob(_perch.sprite_index,_perch.image_index)
        _x+=_bob[0]*scrNTTEFullValue(_perch,"right",1); _y+=_bob[1]
    }
    draw_sprite_ext(_spr,_img,_x,_y,_xsc,_ysc,_ang,_col,_alp)
}
function scrNTTEFullPetParrotAlarm(_leader_dir,_leader_dis) {
    if(instance_exists(leader)) {
        if(instance_exists(pickup)) {
            if(!pickup_held) {
                scrNTTEFullPetWalk(point_direction(x,y,pickup.x,pickup.y)+orandom(5),random_range(6,10))
                right=lengthdir_x(1,direction)>=0 ? 1:-1; return walk
            }
        } else {
            pickup_held=false
            var _nearest=noone,_distance=400,_pet=id
            // NTT's Pickup parent is flattened in the recreated runner.
            // These are its native health/ammo/rogue and custom counterparts.
            var _types=[HPPickup,AmmoPickup,CursedPickup,NTTEFullCustomPickup]
            for(var _t=0;_t<array_length(_types);++_t) with(_types[_t]) if(mask_index==mskPickup) {
                var _d=point_distance(x,y,_pet.x,_pet.y),_claimed=false,_candidate=id
                if(_d<_distance && !collision_line(x,y,_pet.x,_pet.y,Wall,false,false)) {
                    with(NTTEFullPet) if(scrNTTEFullValue(id,"pickup",noone)==_candidate) _claimed=true
                    if(!_claimed) { _nearest=id; _distance=_d }
                }
            }
            if(instance_exists(_nearest)) { pickup=_nearest; return 1 }
        }
        if(perched!=leader) {
            if(!is_undefined(path_dir)) {
                scrNTTEFullPetWalk(path_dir+orandom(4),random_range(4,8)); right=lengthdir_x(1,direction)>=0 ? 1:-1; return walk
            } else {
                scrNTTEFullPetWalk(_leader_dir+orandom(30),random_range(10,20)); right=lengthdir_x(1,direction)>=0 ? 1:-1
                if(_leader_dis>32) return walk
            }
        } else if(random(4)<1) {
            snd_play(snd_note,1.8+random(0.2),0.33)
            snd_play(choose(leader.snd_wrld,leader.snd_chst,leader.snd_crwn),1.6,0.4)
            hspeed=4*right*timescale
            var _note=instance_create(x+8*right+perched_x,y-4+perched_y,Wind)
            _note.sprite_index=spr_note; _note.depth=depth-1; _note.hspeed=random_range(1,1.4)*right*timescale
            _note.gravity=-abs(_note.speed/10)*timescale; _note.friction=0.1*timescale*timescale
            return 40+random(20)
        }
    }
    if(!instance_exists(leader) || instance_exists(perched)) {
        right=choose(-1,1); return 30+random(30)
    }
    return 20+random(20)
}
function scrNTTEFullPetParrotHurt(_damage,_direction,_force=0) {
    if(!instance_exists(perched)) {
        sprite_index=spr_hurt; image_index=0
        if(speed==0) {
            scrNTTEFullPetWalk(_direction,4); right=lengthdir_x(1,direction)>=0 ? 1:-1
            move_contact_solid(direction,6)
        }
    }
    return true
}
function scrNTTEFullPetParrotTests() {
    var _p=instance_find(Player,0),_old_pets=scrNTTEFullValue(_p,"ntte_pet",[]),_old_max=scrNTTEFullValue(_p,"ntte_pet_max",1)
    _p.ntte_pet=[]; _p.ntte_pet_max=2
    var _a=scrNTTEFullPetCreate(_p.x+64,_p.y,"Parrot"),_b=scrNTTEFullPetCreate(_p.x+72,_p.y,"Parrot")
    scrNTTEFullPetTake(_a,_p); scrNTTEFullPetTake(_b,_p)
    var _pickup=instance_create(_a.x,_a.y,HPPickup),_before=_a.stat.pickups
    _pickup.mask_index=mskPickup; _pickup.blink=1; _pickup.visible=false
    with(_a) scrNTTEFullPetParrotAlarm(0,64)
    assert(_a.pickup==_pickup,"Parrot failed to reserve actual nearby pickup")
    with(_b) scrNTTEFullPetParrotAlarm(0,72)
    assert(_b.pickup!=_pickup,"Two parrots claimed the same actual pickup")
    with(_a) scrNTTEFullPetParrotStep()
    assert(_a.pickup_held && _a.stat.pickups==_before+1,"Parrot contact did not grab pickup/count source stat")
    with(_a) scrNTTEFullPetParrotStep()
    assert(_pickup.x==_a.x && _pickup.y==_a.y+4 && _pickup.blink==30 && _pickup.visible,
        "Parrot did not carry or preserve actual pickup")
    assert(_a.stat.pickups==_before+1,"Parrot counted same carried pickup twice")
    instance_destroy(_pickup,false); _a.pickup=noone; _a.pickup_held=false
    var _old_speed=_p.speed; _p.speed=0; _a.x=_p.x; _a.y=_p.bbox_top-8
    with(_a) scrNTTEFullPetParrotStep()
    assert(_a.perched==_p,"Parrot failed original stationary leader perch condition")
    with(_a) scrNTTEFullPetParrotStep()
    assert(_a.x==_p.x && _a.y==_p.y && _a.perched_y==sprite_get_bbox_top(_p.sprite_index)-sprite_get_yoffset(_p.sprite_index)-4,
        "Parrot perched position lost sprite-relative source offset")
    var _bob=scrNTTEFullPetParrotBob(sprMutant1Idle,0)
    assert(_bob[0]==0 && _bob[1]==0,"Parrot alpha frame zero must be zero-relative")
    _bob=scrNTTEFullPetParrotBob(sprMutant1Idle,1)
    assert(_bob[0]==0 && _bob[1]==1,"Parrot exact Fish second-frame alpha bob changed")
    _p.speed=_old_speed
    instance_destroy(_a); instance_destroy(_b); _p.ntte_pet=_old_pets; _p.ntte_pet_max=_old_max
    scrNTTESmokeLog("SYSTEMS PET PARROT: actual pickup reservation/exclusion/contact/carry/blink/stats, stationary perch, exact alpha bob frame zero OK")
}
