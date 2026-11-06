// tecoast2603..2804: actual Palanking airborne death and pickup/enemy slap.
function scrNTTEFullPalankingSlashCreate(_ground=false) {
    sprite_index=scrNTTERefSprite(_ground ? "GroundSlash":"PalankingSlash")
    image_speed=(_ground ? 0.5:0.3)*timescale; depth=_ground ? 0:-4
    mask_index=_ground ? -1:mskSlash; friction=0.5*timescale*timescale
    damage=3; knockback_speed=8*timescale; typ=0; candeflect=true
}
function scrNTTEFullPalankingTossTarget(_target,_angle,_pickup=false) {
    var _toss=instance_create(_target.x,_target.y,NTTEFullPalankingToss)
    _toss.direction=_angle; _toss.speed=4*timescale; _toss.creator=_target
    _toss.depth=_target.depth; _toss.mask_index=_target.mask_index
    _toss.spr_shadow_y=scrNTTEFullValue(_target,"spr_shadow_y",0)
    if (_pickup) _toss.zspeed*=2/3
    _target.mask_index=mskNone
    return _toss
}
function scrNTTEFullPalankingSlashStep() {
    if (lockstep_stop) return;
    var _pickups=scrNTTEFullInstances(scrNTTEFullWorldPickupTypes())
    for(var _i=0;_i<array_length(_pickups);++_i) {
        var _p=_pickups[_i]
        if (_p.mask_index==mskPickup && place_meeting(x,y,_p)) {
            var _angle=direction+angle_difference(point_direction(x,y,_p.x,_p.y),direction)/3
            scrNTTEFullPalankingTossTarget(_p,_angle,true)
        }
    }
}
function scrNTTEFullPalankingSlashHit(_target) {
    if (lockstep_stop || !instance_exists(_target) || !scr_can_hit(_target)) return;
    scr_projectile_hit(_target,damage,knockback_speed)
    if (instance_exists(_target) && _target.hp>0 && !instance_is(_target,prop) && (instance_is(_target,Player) || _target.size<=1)) {
        var _angle=direction+angle_difference(point_direction(x,y,_target.x,_target.y),direction)/3
        scrNTTEFullPalankingTossTarget(_target,_angle)
        if (instance_is(_target,Player)) _target.smoke=6+random(6)
        snd_play(sndHammerHeadEnd,0.8,0.5)
    }
}
function scrNTTEFullPalankingDieCreate() {
    sprite_index=scrNTTERefSprite("PalankingHurt"); spr_dead=scrNTTERefSprite("PalankingDead")
    image_speed=0.4*timescale; image_alpha=0; depth=-3; hitid=[spr_dead,"PALANKING"]
    friction=0.4*timescale*timescale; team=-1; size=3; z=0; zspeed=9; zfriction=1; raddrop=80
    snd_dead=scrNTTERefSound("PalankingDead")
}
function scrNTTEFullPalankingDieStep() {
    if (lockstep_stop) return;
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    if (z<=0) instance_destroy()
}
function scrNTTEFullPalankingDieDraw() {
    var _hurt=image_index<1
    if (_hurt) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(scrNTTERefSprite("PalankingBott"),image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,1)
    draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,image_blend,1)
    if (_hurt) gpu_set_fog(false,0,0,0)
}
function scrNTTEFullPalankingSmashRing(_x,_y,_distance,_death=false) {
    for(var _angle=0;_angle<360;_angle+=360/16) {
        var _slash=scr_projectile_create(_x+lengthdir_x(_distance,_angle),_y+lengthdir_y(_distance*2/3,_angle)-4,NTTEFullPalankingSlashGround,_angle,_death ? 3+random(1):1)
        if (!_death) _slash.team=-1
        if (random(4)<1) {
            var _hit=instance_create(_x+lengthdir_x(_distance+16,_angle),_y+lengthdir_y((_distance+16)*2/3,_angle),MeleeHitWall)
            with (_hit) { motion_add(90-30*dcos(_angle),(1+random(2))*timescale); image_angle=direction+180; image_speed=random_range(0.3,0.6)*timescale }
        }
        repeat(irandom(2)) {
            var _dust=instance_create(_x+orandom(8)+lengthdir_x(_distance,_angle),_y-random(12)+lengthdir_y(_distance,_angle),Dust)
            with (_dust) motion_add(_angle,random(5)*timescale)
        }
    }
}
function scrNTTEFullPalankingDieDestroy() {
    snd_play(sndWallBreakRock,0.8,0.8); snd_play(sndExplosionL,0.5,0.6); snd_play_hit(sndBigBanditMeleeHit,0.3); snd_play(snd_dead)
    scrNTTEFullTrenchShake(x,y,30)
    var _sprite=scrNTTERefSprite("PalankingChunk"),_angle=random(360),_num=sprite_get_number(_sprite)
    for(var _i=0;_i<_num;++_i) {
        var _debris=instance_create(x,y+16,Debris)
        with (_debris) { motion_set(_angle+orandom(30),(2+random(10))*timescale); sprite_index=_sprite; image_index=_i; alarm[0]+=random(240) }
        repeat(irandom(2)) instance_create(x,y+16,Debris)
        _angle+=360/_num
    }
    var _corpse=scrNTTEFullCorpseDrop(id,0,0)
    if (instance_exists(_corpse)) _corpse.depth=0
    repeat(3) scrNTTEFullWorldPickupDrop(50,0)
    scrNTTEFullRadDrop(x,y+16,raddrop,direction,speed)
    scrNTTEFullPalankingSmashRing(x,y+24,24,true)
}
