// tepickups.mod.gml:400..493. General airborne bag/object wrapper; the actual
// Backpack chest reward/merged weapon implementation belongs to common pickups.
function scrNTTEFullBackpackPickupCreate() {
    sprite_index=mskPickup; mask_index=mskPickup; visible=false
    target=noone; target_x=x; target_y=y; z=0; zfriction=0.7; zspeed=random_range(2,4)
    speed=random_range(1,3)*timescale; direction=random(360); ntte_backpack_cleaned=false
}

function scrNTTEFullBackpackPickupEndStep() {
    if (lockstep_stop) return;
    if (instance_exists(target)) {
        z+=zspeed*timescale; zspeed-=zfriction*timescale
        if (z>0 || zspeed>0) {
            with (target) {
                x=other.x; y=other.y-other.z; xprevious=x; yprevious=y
                other.target_x=x; other.target_y=y
                if (instance_is(id,enemy)) {
                    sprite_index=spr_hurt
                    var _fly=variable_instance_exists(id,"canfly") ? canfly:false
                    if (!_fly) { other.canfly=_fly; canfly=true }
                }
                if (mask_index!=mskNone) { other.mask_index=mask_index; mask_index=mskNone }
            }
            var _ts=max(timescale,0.000001),_dx=hspeed/_ts,_dy=vspeed/_ts
            if (place_meeting(x+_dx,y+_dy,Wall)) {
                if (place_meeting(x+_dx,y,Wall)) hspeed*=-1
                if (place_meeting(x,y+_dy,Wall)) vspeed*=-1
            }
        }
        else instance_destroy()
    }
    else {
        // NTT GameObject means runtime game instances. Native Epsilon has no
        // equivalent shared ancestor; require the exact original fields before
        // considering all instances as replacement candidates.
        var _found=noone,_n=instance_number(all)
        for(var _i=0;_i<_n;++_i) {
            var _v=instance_find(all,_i)
            if (_v.id<=id || _v.id<=target) continue
            if (!variable_instance_exists(_v,"xstart") || !variable_instance_exists(_v,"ystart")) continue
            if (_v.xstart!=target_x || _v.ystart!=target_y) continue
            if (variable_instance_exists(_v,"backpackpickup_grab") && !is_undefined(_v.backpackpickup_grab)) continue
            _found=_v; break
        }
        if (instance_exists(_found)) {
            _found.backpackpickup_grab=true; target=_found
            scrNTTEFullBackpackPickupEndStep()
        }
        else instance_destroy()
    }
}

function scrNTTEFullBackpackPickupCleanup() {
    if (ntte_backpack_cleaned) return;
    ntte_backpack_cleaned=true
    if (!instance_exists(target)) return;
    with (target) {
        x=other.x; y=other.y; xprevious=x; yprevious=y
        mask_index=other.mask_index; direction=other.direction; speed=other.speed
        if (variable_instance_exists(other.id,"canfly")) canfly=other.canfly
        repeat(3) {
            var _dust=instance_create(x,y,Dust)
            with (_dust) { motion_add(random(360),3*timescale); motion_add(other.direction,timescale); depth=0 }
        }
    }
}

function scrNTTEFullBackpackPickupSmoke() {
    var _bag=instance_create(10080,10048,NTTEFullBackpackPickup)
    var _chest=instance_create(10080,10048,WeaponChest),_mask=_chest.mask_index
    _bag.target=_chest; _bag.zspeed=4
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    assert(_chest.x==_bag.x && _chest.y==_bag.y-_bag.z && _chest.mask_index==mskNone,"BackpackPickup did not suspend/hide target collision")
    _bag.z=0; _bag.zspeed=-1
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    assert(!instance_exists(_bag) && _chest.mask_index==_mask && _chest.y==10048,"BackpackPickup landing failed mask/position restore")
    instance_destroy(_chest,false)
    _bag=instance_create(10080,10048,NTTEFullBackpackPickup); _chest=instance_create(10080,10048,WeaponChest)
    _bag.target=_chest
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    var _tx=_bag.target_x,_ty=_bag.target_y
    instance_destroy(_chest,false)
    var _replacement=instance_create(_tx,_ty,WeaponChest)
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    assert(_bag.target==_replacement && _replacement.backpackpickup_grab && _replacement.mask_index==mskNone,"BackpackPickup failed newer same-origin replacement adoption")
    instance_destroy(_bag); assert(_replacement.mask_index==_mask,"BackpackPickup early destroy failed target mask restore")
    instance_destroy(_replacement,false)
    var _loops=GameCont.loops; GameCont.loops=0
    _bag=instance_create(10080,10048,NTTEFullBackpackPickup)
    var _enemy=instance_create(10080,10048,NTTEFullBabyScorpion); _bag.target=_enemy
    with (_bag) scrNTTEFullBackpackPickupEndStep()
    assert(_enemy.canfly && _enemy.sprite_index==_enemy.spr_hurt,"BackpackPickup enemy suspension lost hurt/fly state")
    instance_destroy(_bag)
    assert(!_enemy.canfly,"BackpackPickup cleanup failed original enemy fly-state restore")
    instance_destroy(_enemy,false); GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD BACKPACK PICKUP AIRBORNE/LANDING/MASK + REPLACEMENT ADOPTION + ENEMY FLY RESTORE OK")
}
