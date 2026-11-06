// NTTE 2.062 telabs.mod RogueMissile / SmallLastBall, source lines 2751..2878.
// Motion values in the source are logical 30 Hz units; the native runner moves
// by speed each render frame, so speed is scaled once and friction twice.
function scrNTTEFullRogueMissileCreate() {
    sprite_index=scrNTTERefSprite("SparkleBullet"); mask_index=mskPlasma
    image_angle=random(360); image_speed=0.4*timescale; depth=-9
    hitid=72; target=instance_nearest(x,y,enemy); target_x=x; target_y=y
    wobble_angle=random(360); team=-1; creator=noone
    projectile_direction_changes_angle=false
}

function scrNTTEFullRogueMissileStep() {
    if(lockstep_stop) return;
    if(instance_exists(target)) {target_x=target.x;target_y=target.y}
    var _distance=point_distance(x,y,target_x,target_y)
    speed=lerp(clamp(_distance/8,8,16)*timescale,speed,power(0.9,timescale))
    var _dir=point_direction(x,y,target_x,target_y)
    direction=_dir+angle_difference(direction,_dir)*power(0.85,timescale)
    var _wobble=5*dsin(wobble_angle)*timescale
    direction+=_wobble; image_angle+=_wobble; wobble_angle+=12*timescale
    if(current_frame_active) {
        var _trail=instance_create(x,y,PlasmaTrail)
        _trail.sprite_index=sprPopoPlasmaTrail; _trail.image_speed*=1.5
        _trail.image_xscale=speed/timescale/3; _trail.image_yscale=0.5
        _trail.image_angle=direction; _trail.depth=depth+1
    }
    if(_distance<24) instance_destroy()
}

function scrNTTEFullGuardianProjectileDraw() {
    draw_self()
    // Tagged custom projectiles now get exactly one source halo in bloom.
    // RogueMissile still uses this older inline halo without an ntte_bloom.
    if(scrNTTEFullValue(id,"ntte_bloom",0)>0) return;
    gpu_set_blendmode(bm_add)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,image_alpha*0.1)
    gpu_set_blendmode(bm_normal)
}

function scrNTTEFullRogueMissileDestroy() {
    var _explosion=scr_projectile_create(x,y,PopoExplosion,direction,speed/timescale/2)
    _explosion.sprite_index=sprRogueExplosion; _explosion.mask_index=mskExplosion
    _explosion.friction=0.4*timescale*timescale; _explosion.hitid=hitid
    snd_play_hit_big(sndExplosion,0.2)
}

function scrNTTEFullSmallLastBallCreate() {
    sprite_index=scrNTTERefSprite("SmallLastBall"); mask_index=mskPlasma
    image_speed=0.4*timescale; depth=-4; ntte_bloom=0.1
    damage=12; typ=1; knockback_speed=8*timescale
}

function scrNTTEFullSmallLastBallDestroy() {
    snd_play_hit_big(sndBigBallExplo,0.1)
    instance_create(x,y,PortalClear)
    var _start=random(360)
    for(var _ray=0;_ray<8;++_ray) for(var _num=0;_num<3;++_num) {
        var _bullet=scr_projectile_create(x,y,HorrorBullet,_start+_ray*45,4+0.8*_num)
        _bullet.sprite_index=scrNTTERefSprite("IDPDHorrorBullet"); _bullet.bskin="cool frog"
        _bullet.spr_fade=sprIDPDBulletHit
    }
    var _impact=instance_create(x,y,BulletHit)
    _impact.sprite_index=scrNTTERefSprite("CrystalHeartBulletHit")
    with(_impact) scrNTTEFullMergedNativeCopy(false)
    _impact.image_blend=c_aqua; _impact.depth=0
    _impact.image_xscale=1.25; _impact.image_yscale=1.25
}

function scrNTTEFullGuardianProjectileUnitTests() {
    var _before=scrNTTEFullInstances(all),_owner=instance_find(Player,0)
    var _missile=scrNTTEFullSystemsCreate("RogueMissile",42016,42016)
    _missile.creator=_owner; _missile.team=team_player; _missile.speed=8*timescale; _missile.direction=32
    assert(_missile.hitid==72 && _missile.sprite_index==scrNTTERefSprite("SparkleBullet"),"Guardian Rogue missile source visual/hitid changed")
    var _enemy=instance_create(42216,42016,Bandit)
    _missile.target=_enemy
    with(_missile) scrNTTEFullRogueMissileStep()
    assert(instance_exists(_missile) && _missile.target_x==_enemy.x && _missile.speed>8*timescale,
        "Guardian Rogue missile failed native homing/CT acceleration")
    var _speed=_missile.speed/timescale
    instance_destroy(_missile)
    var _explosion=noone
    with(PopoExplosion) if(x>41000 && creator==_owner) _explosion=id
    assert(instance_exists(_explosion) && _explosion.team==team_player && _explosion.hitid==72
        && _explosion.sprite_index==sprRogueExplosion && abs(_explosion.speed-_speed*timescale/2)<0.001
        && abs(_explosion.friction-0.4*timescale*timescale)<0.001,
        "Guardian Rogue explosion lost real player ownership, source blast or render-rate conversion")
    var _ball=scrNTTEFullSystemsCreate("SmallLastBall",42416,42016)
    _ball.creator=_owner; _ball.team=team_player
    assert(_ball.damage==12 && _ball.typ==1 && abs(_ball.knockback_speed-8*timescale)<0.001,
        "Guardian Horror orb source damage/type/force changed")
    _enemy.hp=100; _enemy.max_hp=100; _enemy.nexthurt=0
    with(_enemy) with(_ball) event_perform(ev_collision,hitme)
    assert(!instance_exists(_ball) && _enemy.hp==88,"Guardian Horror orb failed actual native damage/contact destruction")
    var _count=0,_speeds=[0,0,0],_impacts=0,_aqua=0
    with(HorrorBullet) if(x>41000) {
        _count+=1
        assert(creator==_owner && team==team_player && sprite_index==scrNTTERefSprite("IDPDHorrorBullet")
            && spr_fade==sprIDPDBulletHit && bskin=="cool frog","Guardian Horror burst ownership/skin mismatch")
        var _slot=round((speed/timescale-4)/0.8)
        assert(_slot>=0 && _slot<3,"Guardian Horror burst projectile speed changed")
        _speeds[_slot]+=1
    }
    with(BulletHit) if(x>41000 && sprite_index==scrNTTERefSprite("CrystalHeartBulletHit")) {
        _impacts+=1
        if(image_blend==c_aqua && image_xscale==1.25 && depth==0) {_aqua+=1}
    }
    assert(_count==24 && _speeds[0]==8 && _speeds[1]==8 && _speeds[2]==8 && _impacts==2 && _aqua==1,
        "Guardian Horror orb failed source eight-way triple burst/double impact")
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    scrNTTESmokeLog("FULL GUARDIAN PROJECTILES: Rogue homing/explosion ownership and Horror orb 24-shot burst/skin/impact OK @"+string(30/timescale))
}
