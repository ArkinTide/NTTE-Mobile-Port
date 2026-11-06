// tedesert.mod.gml2804..2901 and the two original .wep.gml files.
function scrNTTEFullVenomCreate() {
    spr_spwn=sprNTTEVenomPelletAppear;spr_idle=sprNTTEVenomPellet
    spr_fade=sprNTTEVenomPelletDisappear;spr_dead=sprScorpionBulletHit
    sprite_index=spr_idle;image_speed=0.4*timescale;depth=-3;ntte_bloom=0.2
    mask_index=mskEnemyBullet1;friction=0.75*timescale*timescale
    damage=2;force=4;knockback_speed=4*timescale;typ=2;minspeed=4
    hit_list=[];wallbounce=0
}
function scrNTTEFullVenomStep() {
    if(lockstep_stop) return;
    if(speed<minspeed*timescale && sprite_index!=spr_fade) {
        sprite_index=spr_fade;image_index=0
    }
}
function scrNTTEFullVenomAnim() {
    if(sprite_index==spr_spwn) {image_speed=0.4*timescale;sprite_index=spr_idle;}
    else if(sprite_index==spr_fade) instance_destroy()
}
function scrNTTEFullVenomHit(_target) {
    if(lockstep_stop || !instance_exists(_target)) return;
    var _first=array_get_index(hit_list,_target)<0
    // Source intentionally allows first contact with any non-Player hitme,
    // independently of the melee predicate. Do not add hp/phase/team gates.
    if(!scrNTTEFullRedSlashCanHit(_target) && !(_first && !instance_is(_target,Player))) return;
    scrNTTEFullNativeProjectileHitNP(_target,damage,knockback_speed/timescale,10)
    if(_first) {
        array_push(hit_list,_target)
        if(instance_exists(_target) && _target.hp>0) {
            x-=hspeed;y-=vspeed;speed-=0.75*timescale
        }
    }
    var _fx=instance_create(x,y,ScorpionBulletHit);_fx.sprite_index=spr_dead
}
function scrNTTEFullVenomWall() {
    if(lockstep_stop) return;
    instance_create(x,y,Dust)
    if(wallbounce>0 && speed>=minspeed*timescale) {
        snd_play_hit(sndShotgunHitWall,0.2);move_bounce_solid(true);image_angle=direction
        speed=speed*0.8+wallbounce*timescale;wallbounce*=0.95
    }
    else {snd_play_hit(sndHitWall,0.2);instance_destroy();}
}
function scrNTTEFullVenomDestroy() {
    if(sprite_index!=spr_fade) {
        var _fx=instance_create(x,y,ScorpionBulletHit);_fx.sprite_index=spr_dead
    }
}
function scrNTTEFullVenomWeaponFire(_weapon) {
    var _beetle=_weapon==wep_ntte_beetle_blaster,_dir=gunangle+orandom((_beetle?5:4)*accuracy),
        _count=_beetle?2:3,_shots=[]
    for(var _i=0;_i<_count;++_i) {
        var _ang=_dir+(_beetle?-90+180*_i:120*_i),
            _length=(_beetle?6:9)*lerp(accuracy,1,2/3),_d=_ang+orandom((_beetle?10:2)*accuracy),
            _shot=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(_length,_d),y+lengthdir_y(_length,_d),
                NTTEVenomPellet,_dir,_beetle?14+orandom(1):16)
        _shot.sprite_index=_shot.spr_spwn;_shot.image_speed=timescale
        if(_beetle) with(_shot) {
            wallbounce=4*scr_skill_get(mut_shotgun_shoulders)
            while(position_meeting(x,y,Wall) && _length>0) {
                _length--;x-=lengthdir_x(1,_d);y-=lengthdir_y(1,_d);xstart=x;ystart=y
            }
        }
        array_push(_shots,_shot)
        if(_beetle) {
            var _fx=instance_create(x,y,AcidStreak)
            with(_fx) {motion_add(_dir+angle_difference(_ang,_dir)*0.2,5*timescale);depth=0;}
        }
    }
    scrNTTEFullCustomProjectileGunSound(sndMachinegun,0.3,0.3)
    if(_beetle) {
        scrNTTEFullCustomProjectileGunSound(sndFireballerFire,0.3,0.3)
        scrNTTEFullCustomProjectileGunSound(sndScorpionHit,0.3,0.3)
    }
    scr_weapon_post(gunangle,-2,_beetle?8:0,_beetle?5:4)
    return _shots
}
