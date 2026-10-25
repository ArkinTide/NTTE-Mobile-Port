// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// NTTE 2.062 tesewers BatBoss and its morph clouds.
function scrNTTEFullSewerBossHP(_base) {
    return round(_base*(1+GameCont.loops/3)*(1+0.5*(max(1,instance_number(Player))-1)))
}

function scrNTTEFullBatBossConfigure() {
    ntte_bat_boss=true; ntte_full_boss_hp=scrNTTEFullSewerBossHP(200)
    max_hp=ntte_full_boss_hp/(1+GameCont.loops/20); raddrop=24; size=3; meleedamage=0
    spr_idle=scrNTTERefSprite("BatBossIdle"); spr_walk=scrNTTERefSprite("BatBossWalk")
    spr_hurt=scrNTTERefSprite("BatBossHurt"); spr_dead=scrNTTERefSprite("BatBossDead")
    spr_fire=scrNTTERefSprite("BatBossYell"); spr_weap=scrNTTERefSpriteBase("BatBossWeap")
    sprite_index=spr_idle; mask_index=mskBanditBoss; depth=-2
    hitid=[spr_idle,"BIG BAT"]; boss=true; walk=0
    // BEGIN NTTE SOURCE BAT BOSS RECOIL OWNER FIELD
    maxspeed=3
    // END NTTE SOURCE BAT BOSS RECOIL OWNER FIELD
    ntte_full_stress=20; ntte_full_active=true; ntte_full_intro=false
    ntte_full_taunt=60; ntte_full_cloud=[]; ntte_full_cloud_blend=0
    ntte_full_timers=[6,60,-1,-1]; ntte_full_last_hp=ntte_full_boss_hp
}

function scrNTTEFullBatBossAfterCreate() {
    max_hp=ntte_full_boss_hp; hp=max_hp
    friction=0.01*timescale*timescale; spr_shadow=shd64; spr_shadow_x=0; spr_shadow_y=12
    snd_hurt=scrNTTERefSound("BigBatHurt"); snd_dead=scrNTTERefSound("BigBatDead")
    gunangle=random(360); direction=gunangle
    alarm[0]=-1; alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullBatBossScreech(_extra=3,_scale=0.5) {
    snd_play(sndNothing2Hurt,1.4+random(0.2),0.7)
    snd_play(sndSnowTankShoot,0.8+random(0.4),0.5)
    scrNTTEFullTrenchShake(x,y,16); sleep(40)
    var _cat=instance_nearest(x,y,NTTECat)
    if (instance_exists(_cat) && _cat.team==team) _cat.ntte_cat_cantravel=true
    scr_projectile_create(x,y,NTTEBatScreech,0,0)
    for(var _i=0;_i<_extra;++_i) {
        var _d=gunangle+_i*360/_extra,_p=scr_projectile_create(x+lengthdir_x(56,_d),y+lengthdir_y(56,_d),NTTEBatScreech,0,0)
        _p.image_xscale=_scale; _p.image_yscale=_scale
    }
    sprite_index=spr_fire; image_index=0
}

function scrNTTEFullBatBossMorphStart() {
    ntte_full_timers[2]=24
    for(var _i=0;_i<3;++_i) array_push(ntte_full_cloud,{y:0,y_add:1.5,delay:8*_i,right:choose(-1,1)})
}

function scrNTTEFullBatBossMorph() {
    scrNTTEFullTrenchTarget(); ntte_full_cloud=[]
    if (ntte_full_active) {
        ntte_full_active=false; mask_index=mskNone; visible=false
        var _start=random(360),_count=3+2*GameCont.loops
        for(var _i=0;_i<_count;++_i) {
            var _d=_start+360*_i/_count,_p=instance_create(x+lengthdir_x(8,_d),y+lengthdir_y(8,_d),NTTEFullBatCloud)
            _p.target=target; _p.creator=id; _p.ntte_full_offset_direction=_d; _p.direction=_d; _p.team=team
        }
        snd_play(sndBloodHurt,0.7+random(0.2),0.8)
    }
    else {
        ntte_full_active=true; ntte_full_timers[1]+=30
        mask_index=mskBanditBoss; visible=true; instance_create(x,y,PortalClear)
        with (NTTEBat) if (creator==other.id) {
            repeat(8) {
                var _fx=scrNTTEFullTrenchFX(x,y,0,3,Dust); _fx.image_blend=c_black
            }
            instance_destroy(id,false)
        }
        with (NTTEFullBatCloud) if (creator==other.id) instance_destroy(id,false)
        snd_play(sndBloodHammer,0.5+random(0.2),0.8)
    }
}

function scrNTTEFullBatBossDecision() {
    ntte_full_timers[1]=20+random(20)
    with (NTTEFullCatBoss) if (ntte_full_super_time<=0) {
        ntte_full_timers[1]=20+random(20)
        other.ntte_full_timers[1]+=ntte_full_timers[1]
    }
    if (!ntte_full_active) {
        with (NTTEBat) if (creator==other.id) {
            ntte_bat_timer=ceil(ntte_bat_timer/2); scrTarget()
            if (instance_exists(target)) {
                if (scrTargetIsVisible(target) && point_distance(x,y,target.x,target.y)<128) {
                    scrNTTESewerWalk(point_direction(x,y,target.x,target.y),ntte_bat_timer)
                    scrNTTESewerLook(direction)
                }
                else if (random(3)<1) {
                    var _p=instance_create(x,y+16,NTTEFullBatCloud)
                    _p.target=target; _p.creator=creator; _p.ntte_full_saved_hp=hp
                    _p.direction=90+orandom(20); _p.team=team
                    snd_play(sndBloodHammer,1.4+random(0.2),0.5)
                    repeat(10) { var _fx=scrNTTEFullTrenchFX(x,y,8,random(3),Smoke); _fx.image_blend=c_black }
                    instance_destroy(id,false)
                }
            }
        }
        return;
    }
    if (scrNTTEFullTrenchTarget()) {
        if (ntte_full_distance<240 && ntte_full_visible) {
            scrNTTEFullTrenchLook(ntte_full_direction)
            if (random(5)<1) {
                scrNTTEFullTrenchWalk(gunangle+180+irandom_range(25,45)*right,random_range(20,35))
                // Original chance(maxhealth,my_health) is always true below
                // maximum HP. Preserve its original unreachable branch.
                if (random(8)<1 && random(hp)>=max_hp) scrNTTEFullBatBossMorphStart()
            }
            if (random(3)<1) {
                if (irandom(max(0,ntte_full_stress))>=15) {
                    ntte_full_stress-=8; scrNTTEFullBatBossScreech()
                }
                else ntte_full_stress+=4
            }
            else {
                wkick-=4
                scr_projectile_create(x,y,NTTEFullVenomFlak,gunangle+orandom(10),12)
            }
        }
        else {
            var _cat=instance_nearest(x,y,NTTEFullCatBoss)
            if (instance_exists(_cat) && point_distance(x,y,_cat.x,_cat.y)>64
                && !collision_line(x,y,_cat.x,_cat.y,Wall,false,false))
                scrNTTEFullTrenchWalk(point_direction(x,y,_cat.x,_cat.y)+orandom(8),random_range(15,35))
            else if (random(3)<2) scrNTTEFullTrenchWalk(direction+orandom(24),random_range(10,30))
            else scrNTTEFullBatBossMorphStart()
            scrNTTEFullTrenchLook(direction)
        }
    }
    else {
        ntte_full_timers[1]=45+random(60)
        scrNTTEFullTrenchWalk(random(360),5); scrNTTEFullTrenchLook(direction)
    }
}

function scrNTTEFullBatBossCloudVisual() {
    if (array_length(ntte_full_cloud)==0) { ntte_full_cloud_blend=0; return }
    walk=0; speed=0
    var _w=ntte_full_active ? 24:16,_h=ntte_full_active ? 32:20,
        _y1=y-_h/2,_keep=[]
    for(var _i=0;_i<array_length(ntte_full_cloud);++_i) {
        var _c=ntte_full_cloud[_i]
        if (_c.delay>0) _c.delay-=timescale
        else {
            var _cy=_y1+_c.y,_offset=_cy/2,_cx=x+cos(_offset)*_w/2*_c.right
            repeat(3) {
                var _fx=scrNTTEFullTrenchFX(_cx,_cy,4,0,Dust)
                _fx.image_blend=c_black; _fx.depth=depth+(sin(_offset)<0 ? -1:1)
            }
            _c.y+=_c.y_add*timescale
        }
        if (_c.y<_h) array_push(_keep,_c)
    }
    ntte_full_cloud=_keep
    if (ntte_full_active) ntte_full_cloud_blend=clamp(ntte_full_cloud_blend+0.05*timescale,0,1)
    else {
        with (NTTEBat) if (creator==other.id) {
            walk=0; speed=0; ntte_bat_timer=20+random(20)
            image_blend=merge_color(image_blend,c_black,0.1*timescale)
        }
        with (NTTEFullBatCloud) if (creator==other.id) instance_destroy(id,true)
    }
}

function scrNTTEFullBatBossHurt(_damage,_attacker) {
    ntte_full_stress+=_damage
    if (hp<=max_hp/2 && hp+_damage>max_hp/2) {
        snd_play(scrNTTERefSound("BigBatScreech")); scrNTTEFullBatBossScreech(5)
    }
    else if (instance_exists(_attacker) && instance_is(_attacker,ToxicGas)) {
        ntte_full_stress-=4; nexthurt=current_frame+6; scrNTTEFullBatBossScreech(1)
    }
    ntte_full_last_hp=hp
}

function scrNTTEFullBatBossStep() {
    if (hp<ntte_full_last_hp) scrNTTEFullBatBossHurt(ntte_full_last_hp-hp,noone)
    var _due=scrNTTEFullTrenchClock()
    if (_due[0]) {
        ntte_full_intro=true; scrNTTEFullBossIntro("CatBat")
        snd_play(scrNTTERefSound("BigBatIntro"))
        with (NTTEFullCatBoss) if (ntte_full_timers[0]>0) { ntte_full_intro=true; ntte_full_timers[0]=-1 }
        with (NTTEFullBatBoss) if (ntte_full_timers[0]>0) { ntte_full_intro=true; ntte_full_timers[0]=-1 }
    }
    if (_due[1]) scrNTTEFullBatBossDecision()
    if (_due[2]) scrNTTEFullBatBossMorph()
    if (!ntte_full_active) {
        mask_index=mskNone; visible=false
        var _nearest=noone,_dist=infinity,_bats=0,_clouds=0
        with (NTTEBat) if (creator==other.id) {
            ++_bats
            var _d=point_distance(x,y,other.x,other.y)
            if (_d<_dist) { _dist=_d; _nearest=id }
        }
        if (instance_exists(_nearest)) { x=_nearest.x; y=_nearest.y; right=_nearest.right; gunangle=_nearest.gunangle }
        _clouds=instance_number(NTTEFullBatCloud)
        if (ntte_full_timers[2]<0 && _bats<=1 && array_length(ntte_full_cloud)==0 && _clouds==0) {
            ntte_full_timers[2]=20
            for(var _i=0;_i<3;++_i) array_push(ntte_full_cloud,{y:0,y_add:1.2,delay:5*_i,right:choose(-1,1)})
            with (NTTEBat) if (creator==other.id) hp=9999
        }
    }
    if (ntte_full_taunt>0 && !instance_exists(Player)) {
        ntte_full_taunt-=timescale
        if (ntte_full_taunt<=0) snd_play(scrNTTERefSound(instance_exists(NTTEFullCatBoss) ? "BigShotsTaunt":"BigBatTaunt"))
    }
    scrNTTEFullBatBossCloudVisual()
    if (walk>0) { walk-=timescale; speed+=0.8*timescale*timescale; speed=min(speed,3*timescale) }
    else speed=min(speed,1.5*timescale)
    if (speed>0 && place_meeting(x+hspeed,y+vspeed,Wall)) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed=-hspeed
        if (place_meeting(x,y+vspeed,Wall)) vspeed=-vspeed
    }
    if (sprite_index==spr_fire && image_index+image_speed>=image_number) { sprite_index=spr_idle; image_index=0 }
}

function scrNTTEFullBatBossDraw() {
    var _blend=image_blend
    image_blend=merge_color(image_blend,c_black,ntte_full_cloud_blend)
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    image_blend=_blend
}

function scrNTTEFullBatCloudCreate() {
    image_blend=c_black; depth=-9; visible=false
    friction=0.5*timescale*timescale; direction=random(360); speed=16*timescale
    creator=noone; target=noone; team=team_enemy
    ntte_full_offset_distance=32; ntte_full_offset_direction=random(360)
    ntte_full_saved_hp=-1
}

function scrNTTEFullBatCloudStep() {
    if (lockstep_stop) return;
    if (speed>6*timescale) speed-=2*timescale*timescale
    if (current_frame_active) {
        repeat(4) { var _fx=scrNTTEFullTrenchFX(x,y,4,0,Dust); _fx.image_blend=image_blend; _fx.depth=depth }
        direction+=orandom(16)
    }
    if (!instance_exists(target)) { instance_destroy(); return }
    var _radius=ntte_full_offset_distance,_tx=target.x,_ty=target.y
    do {
        _tx=target.x+lengthdir_x(_radius,ntte_full_offset_direction)
        _ty=target.y+lengthdir_y(_radius,ntte_full_offset_direction)
        _radius-=8
    } until (_radius<=0 || (!position_meeting(_tx,_ty,Wall) && position_meeting(_tx,_ty,Floor)))
    var _d=point_distance(x,y,_tx,_ty),_dir=point_direction(x,y,_tx,_ty)
    if (speed<8*timescale) {
        if (_d>96) _dir=point_direction(x,y,_tx,_ty-96)
        motion_add(_dir,random_range(1,4)*timescale*timescale)
    }
    if (_d<8) instance_destroy()
}

function scrNTTEFullBatCloudDestroy() {
    if (!instance_exists(GameCont)) return;
    instance_create(x,y,PortalClear)
    var _bat=instance_create(x,y,NTTEBat)
    _bat.x=_bat.xstart; _bat.y=_bat.ystart; _bat.creator=creator
    _bat.team=team; _bat.givekill=false; _bat.nexthurt=current_frame+12
    if (ntte_full_saved_hp>=0) _bat.hp=ntte_full_saved_hp
    with (_bat) {
        motion_add(other.direction,4*timescale)
        if (instance_exists(other.target)) scrNTTESewerLook(point_direction(x,y,other.target.x,other.target.y))
        for(var _d=0;_d<360;_d+=30) {
            var _fx=instance_create(x,y+6,Smoke)
            with (_fx) { motion_set(_d,2*timescale); motion_add(other.direction,timescale) }
            _fx.image_blend=other.image_blend; _fx.depth=-3
            if (variable_instance_exists(_fx,"growspeed")) _fx.growspeed*=-10
        }
    }
    snd_play(sndBouncerSmg,0.2+random(0.2),0.6)
    snd_play(sndBloodHammer,1.6+random(0.4),0.4)
}

function scrNTTEFullSewerPartnerDeath(_partner_object) {
    if (hp>0 || !instance_exists(GameCont)) return;
    instance_create(x,y,PortalClear)
    repeat(2) scrNTTEFullPickupDropBody(100,0)
    var _partners=[]
    with (_partner_object) if (hp>0) array_push(_partners,id)
    if (array_length(_partners)==0) { with (MusCont) alarm[1]=1; return; }
    for(var _j=0;_j<array_length(_partners);++_j) {
        var _partner=_partners[_j],_heal=ceil(_partner.max_hp/4),_num=min(raddrop,24),_rads=[]
        _partner.max_hp+=_heal; raddrop-=_num
        if (scr_ultra_get(Race.Horror,UltraSkill.Stalker)>0) {
            var _bullets=_num*0.6*scr_ultra_get(Race.Horror,UltraSkill.Stalker),_sx=x,_sy=y
            with (Player) if (race==Race.Horror) repeat(_bullets) {
                var _bullet=scr_projectile_create(_sx,_sy,HorrorBullet,random(360),6)
                if (bskin==SkinLetter.B) _bullet.sprite_index=sprHorrorBBullet
                else if (bskin==SkinLetter.C) _bullet.sprite_index=sprHorrorCBullet
            }
        }
        // Real native rads retain collection/expiry and are never converted
        // into an unconditional immediate heal.
        while(_num>0) {
            var _big=(_num>15); _num-=_big ? 10:1
            var _r=instance_create(x,y,_big ? BigRad:Rad)
            with (_r) {
                motion_add(other.direction,other.speed)
                motion_add(random(360),(3+random(max(0,_num)/2))*timescale)
                speed*=power(0.9,speed/max(0.001,timescale))
                alarm[0]/=3; direction=random(360); speed=max(2*timescale,speed)
                image_index=1; depth=-3
            }
            array_push(_rads,_r)
        }
        var _controller=instance_create(x,y,NTTEFullBossHealController)
        _controller.ntte_full_target=_partner; _controller.ntte_full_rads=_rads
        _controller.ntte_full_heal=ceil(_heal/max(1,array_length(_rads)))
    }
}

function scrNTTEFullBossHealControllerCreate() {
    visible=false; ntte_full_target=noone; ntte_full_rads=[]; ntte_full_heal=0
    ntte_full_paths=[]; ntte_full_cursor=[]; ntte_full_failed=[]
    ntte_full_grid=-1; ntte_full_grid_x=0; ntte_full_grid_y=0
}

function scrNTTEFullBossHealGrid() {
    var _l=infinity,_t=infinity,_r=-infinity,_b=-infinity
    with (Floor) { _l=min(_l,bbox_left); _t=min(_t,bbox_top); _r=max(_r,(bbox_right-1)); _b=max(_b,(bbox_bottom-1)) }
    if (_l==infinity) return false
    ntte_full_grid_x=floor((_l-32)/16)*16; ntte_full_grid_y=floor((_t-32)/16)*16
    ntte_full_grid=mp_grid_create(ntte_full_grid_x,ntte_full_grid_y,ceil((_r-_l+80)/16),ceil((_b-_t+80)/16),16,16)
    mp_grid_add_instances(ntte_full_grid,Wall,false)
    return true
}

function scrNTTEFullBossHealControllerStep() {
    if (lockstep_stop) return;
    if (!instance_exists(ntte_full_target)) { instance_destroy(); return; }
    if (ntte_full_grid<0 && !scrNTTEFullBossHealGrid()) return;
    var _remaining=0,_t=ntte_full_target
    while(array_length(ntte_full_paths)<array_length(ntte_full_rads)) {
        array_push(ntte_full_paths,path_add()); array_push(ntte_full_cursor,0); array_push(ntte_full_failed,false)
    }
    for(var _i=0;_i<array_length(ntte_full_rads);++_i) {
        var _rad=ntte_full_rads[_i]
        if (!instance_exists(_rad)) continue
        ++_remaining
        var _path=ntte_full_paths[_i]
        if (path_get_number(_path)>0) {
            var _d=point_distance(_rad.x,_rad.y,_t.x,_t.y),_dir=point_direction(_rad.x,_rad.y,_t.x,_t.y)
            if (collision_line(_rad.x,_rad.y,_t.x,_t.y,Wall,false,false)) {
                var _cursor=ntte_full_cursor[_i]
                while(_cursor<path_get_number(_path)-1 && point_distance(_rad.x,_rad.y,path_get_point_x(_path,_cursor),path_get_point_y(_path,_cursor))<12) {
                    _cursor+=1
                }
                ntte_full_cursor[_i]=_cursor
                _dir=point_direction(_rad.x,_rad.y,path_get_point_x(_path,_cursor),path_get_point_y(_path,_cursor))
            }
            _rad.speed=min(_rad.speed+random(max(_rad.friction,2*timescale*timescale)),12*timescale)
            _rad.direction+=angle_difference(_dir,_rad.direction)*min(1,max(0.2,16/max(0.001,_d))*timescale)
            _rad.image_angle+=_rad.speed
            with (_rad) if (place_meeting(x+hspeed,y+vspeed,Wall)) {
                var _minimum=min(speed,2*timescale)
                if (place_meeting(x+hspeed,y,Wall)) hspeed=0
                if (place_meeting(x,y+vspeed,Wall)) vspeed=0
                speed=max(_minimum,speed)
                if (place_meeting(x+hspeed,y,Wall)) hspeed=0
                if (place_meeting(x,y+vspeed,Wall)) vspeed=0
            }
            if (_d<=_rad.speed || collision_point(_rad.x,_rad.y,_t,false,false)) {
                _t.raddrop+=instance_is(_rad,BigRad) ? 10:1; _t.hp+=ntte_full_heal
                snd_play_hit(sndHPPickup,0.3); snd_play_hit(sndRadPickup,0.5)
                var _fx=instance_create(random_range(_t.bbox_left,(_t.bbox_right-1)),random_range(_t.bbox_top,(_t.bbox_bottom-1)),AnimParticle)
                _fx.sprite_index=sprFrogHeal; _fx.image_speed=0.4*timescale
                if (random(3)<1) _fx.sprite_index=scrNTTERefSprite("BossHealFX")
                _fx.depth=_t.depth-1
                _fx=instance_create(_rad.x,_rad.y,RadEat)
                if (instance_is(_rad,BigRad)) _fx.sprite_index=sprEatBigRad
                instance_destroy(_rad); --_remaining
            }
        }
        else if (_rad.speed<=_rad.friction*2) {
            _rad.speed=max(_rad.speed,_rad.friction)
            if (ntte_full_failed[_i] && !collision_line(_rad.x,_rad.y,_t.x,_t.y,Wall,false,false)) ntte_full_failed[_i]=false
            if (!ntte_full_failed[_i]) {
                mp_grid_clear_all(ntte_full_grid); mp_grid_add_instances(ntte_full_grid,Wall,false)
                if (mp_grid_path(ntte_full_grid,_path,_rad.x,_rad.y,_t.x,_t.y,true)) ntte_full_cursor[_i]=0
                else ntte_full_failed[_i]=true
            }
        }
    }
    if (_remaining==0) {
        var _fx=instance_create(_t.x,_t.y,AnimParticle)
        _fx.sprite_index=scrNTTERefSprite("BossHealFX"); _fx.depth=_t.depth-1
        _fx.image_xscale*=1.5; _fx.image_yscale*=1.5; _fx.vspeed-=timescale
        _fx=instance_create(_t.x,_t.y,LevelUp); _fx.creator=_t
        snd_play(sndLevelUltra,2+orandom(0.1),1.7)
        instance_destroy()
    }
}

function scrNTTEFullBossHealControllerCleanup() {
    if (ntte_full_grid>=0) mp_grid_destroy(ntte_full_grid)
    for(var _i=0;_i<array_length(ntte_full_paths);++_i) if (path_exists(ntte_full_paths[_i])) path_delete(ntte_full_paths[_i])
}

function scrNTTEFullBatBossDeath() {
    if (hp>0) return;
    with (NTTEBat) if (creator==other.id) hp=0
    scrNTTEFullSewerPartnerDeath(NTTEFullCatBoss)
}
