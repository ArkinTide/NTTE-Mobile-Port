// Exact data/behavior from tecaves.mod.gml:56..87,1974..2027.
function scrNTTEFullCrystalPropCreate(_kind) {
    ntte_crystal_prop_kind=_kind
    var _base=_kind==0 ? "BigCrystalProp":(_kind==1 ? "CrystalPropRed":"CrystalPropWhite")
    curse=_kind==0 && GameCont.area==area_cursed_caves
    if (curse) _base="InvBigCrystalProp"
    spr_idle=scrNTTERefSprite(_base+"Idle")
    spr_hurt=scrNTTERefSprite(_base+"Hurt")
    spr_dead=scrNTTERefSprite(_base+"Dead")
    max_hp=_kind==0 ? 48:2; size=_kind==0 ? 2:1
    sprite_index=spr_idle; mask_index=-1
}

function scrNTTEFullCrystalPropAfterCreate() {
    snd_hurt=sndHitRock; snd_dead=sndCrystalPropBreak
    // Native Crystal's original positional jitter, before the NTTE wrapper.
    move_contact_solid(random(360),random(12))
    if (!place_free(x,y+12)) move_contact_solid(random(90)+45,random(12))
    if (ntte_crystal_prop_kind==0) {
        spr_shadow=-1; depth=-1
        instance_create(x,y,PortalClear)
        repeat(choose(2,3)) instance_create(x,y,curse ? NTTEFullInvCrystalBat:NTTEFullCrystalBat)
    }
}

function scrNTTEFullCrystalWhiteStep() {
    if (lockstep_stop) return;
    if (random(20)<timescale) {
        var _spark=instance_create(x+orandom(7),y+3+orandom(7),LaserCharge)
        with (_spark) {
            sprite_index=sprSpiralStar
            image_index=choose(0,irandom(image_number-1))
            depth=other.depth-1
            motion_set(90,random_range(0.2,0.5)*timescale)
            alarm[0]=random_range(15,30)
        }
    }
    if (random(25)<timescale) {
        var _hit=instance_create(x+orandom(7),y+3+orandom(7),BulletHit)
        _hit.sprite_index=sprThrowHit; _hit.image_xscale=0.2+random(0.3)
        _hit.image_yscale=_hit.image_xscale; _hit.depth=depth-1
    }
}
