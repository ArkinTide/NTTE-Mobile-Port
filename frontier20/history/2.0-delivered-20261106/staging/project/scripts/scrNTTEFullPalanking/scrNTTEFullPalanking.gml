// tecoast1839..2600. Original palanquin carrier/ground-smash/army state machine.
function scrNTTEFullPalankingCreate() {
    boss=true
    spr_bott=scrNTTERefSprite("PalankingBott"); spr_taun=scrNTTERefSprite("PalankingTaunt"); spr_call=scrNTTERefSprite("PalankingCall")
    spr_idle=scrNTTERefSprite("PalankingIdle"); spr_walk=scrNTTERefSprite("PalankingWalk"); spr_hurt=scrNTTERefSprite("PalankingHurt")
    spr_dead=scrNTTERefSprite("PalankingDead"); spr_burp=scrNTTERefSprite("PalankingBurp"); spr_fire=scrNTTERefSprite("PalankingFire"); spr_foam=scrNTTERefSprite("PalankingFoam")
    hitid=[spr_idle,"SEAL KING"]; sprite_index=spr_idle; depth=-3; mask_index=mskNone; mask_hold=scrNTTERefSprite("msk.Palanking")
    ntte_full_pal_hp=scrNTTEFullSewerBossHP(300); max_hp=ntte_full_pal_hp/(1+GameCont.loops/20)
    raddrop=120; size=4; walk=0; walkspeed=0.8; maxspeed=2; ammo=0; meleedamage=4; ground_smash=0
    ntte_pal_start_angle=random(360); gunangle=ntte_pal_start_angle; direction=gunangle
    canwade=false; active=false; intro=false; intro_pan=0; seal=[]; seal_x=[]; seal_y=[]; seal_max=4+GameCont.loops
    tauntdelay=40; phase=-1; z=0; zspeed=0; zfriction=1; zgoal=0; ntte_pal_timers=[-1,-1,-1,-1]
    bossname="PALANKING"; col=c_red
}
function scrNTTEFullPalankingAfterCreate() {
    max_hp=ntte_full_pal_hp; hp=max_hp; gunangle=ntte_pal_start_angle; canmelee=false; corpse=false; team=0
    spr_shadow_hold=shd64B; spr_shadow=mskNone; spr_shadow_y=24
    snd_hurt=scrNTTERefSound("PalankingHurt"); snd_dead=scrNTTERefSound("PalankingDead"); snd_lowh=sndRocket
    for(var _i=0;_i<4;++_i) alarm[_i]=-1
}
function scrNTTEFullPalankingSeals() {
    var _out=scrNTTEFullInstances(NTTEFullSeal),_heavy=scrNTTEFullInstances(NTTEFullSealHeavy)
    for(var _i=0;_i<array_length(_heavy);++_i) array_push(_out,_heavy[_i])
    return _out
}
function scrNTTEFullPalankingAddSeal(_boss,_seal) {
    with (_boss) {
        if (array_length(seal)!=seal_max) {
            seal=array_create(seal_max,noone)
            if (seal_max<=4) { seal_x=[33.5,-33.5,30.5,-30.5]; seal_y=[16,16,28,28] }
            else {
                seal_x=[]; seal_y=[]
                var _offset=33.5
                for(var _i=0;_i<seal_max;++_i) {
                    var _angle=((floor(_i/2)+1)*(180/(ceil(seal_max/2)+1)))-90
                    seal_x[_i]=lengthdir_x(_offset,_angle); seal_y[_i]=16+lengthdir_y(_offset,_angle)/2; _offset*=-1
                }
            }
        }
        seal[max(array_get_index(seal,noone),0)]=_seal
    }
}
function scrNTTEFullPalankingWave(_x,_y,_direction,_delay) {
    var _wave=instance_create(_x,_y,NTTEFullSealWave)
    _wave.direction=_direction; _wave.creator=id; _wave.seal_num=seal_max; _wave.seal_delay=_delay
    if (intro_pan<=0) _wave.seal_alert=true
    return _wave
}
function scrNTTEFullPalankingPreintroClear(_none_only=false) {
    var _enemies=scrNTTEFullInstances(enemy),_ignored=0
    for(var _i=0;_i<array_length(_enemies);++_i) if (!scrNTTEFullValue(_enemies[_i],"intro",true)) _ignored++
    var _seals=scrNTTEFullPalankingSeals(),_seal_num=0
    for(var _i=0;_i<array_length(_seals);++_i) if (!_none_only || scrNTTEFullValue(_seals[_i],"type",undefined)==NTTEFullSealType.None) _seal_num++
    return instance_number(enemy)<=_ignored+_seal_num+instance_number(Van)
}
function scrNTTEFullPalankingAlarm0() {
    if (intro_pan<=0) {
        ntte_pal_timers[0]=60; ntte_pal_timers[1]=20; intro_pan=10+ntte_pal_timers[0]
        with (Player) instance_create(x,y,PortalShock)
    }
    else {
        switch(phase) {
            case 0:
                var _delay=20,_groups=5
                for(var _dir=0;_dir<360;_dir+=360/_groups) {
                    var _x=10016,_y=10016,_wave=scrNTTEFullPalankingWave(_x,_y,point_direction(_x,_y,x,y)+_dir,_delay)
                    if (_dir==0) { intro_pan+=_wave.seal_delay+6*_wave.seal_num; scrNTTEFullWorldViewSet(_wave) }
                    _delay+=15+random(15)
                }
                break
            case 1: case 2: case 3: case 4:
                if (phase==1) {
                    var _angle=random(360),_distance=32,_direction=point_direction(10016,10016,x,y),_delay=30
                    for(var _dir=_angle;_dir<_angle+360;_dir+=360/3) {
                        var _r=64+random(16)
                        scrNTTEFullPalankingWave(x+lengthdir_x(_distance,_direction)+lengthdir_x(_r,_dir),y+lengthdir_y(_distance,_direction)+lengthdir_y(_r,_dir),_dir+180,_delay)
                        _delay+=10+random(10)
                    }
                }
                snd_play(choose(sndOasisHurt,sndOasisMelee,sndOasisShoot,sndOasisChest,sndOasisCrabAttack),0.8+random(0.4))
                var _seal=instance_create(x,y,NTTEFullSeal)
                scrNTTEFullPalankingAddSeal(id,_seal)
                _seal.hold=true; _seal.creator=id; _seal.scared=true
                phase++; ntte_pal_timers[0]=phase<4 ? 8:16
                break
            case 5:
                if (!active) { active=true; team=1; zgoal=12; ntte_pal_timers[0]=30 }
                else {
                    ntte_pal_timers[1]=60+irandom(40)
                    if (!intro) { intro=true; scrNTTEFullBossIntro("Palanking"); snd_play(sndBigDogIntro) }
                    scrTarget()
                    if (instance_exists(target)) { scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y)); scrNTTEFullWorldWalk(gunangle,90) }
                }
                break
        }
        if (phase>0) { if (intro_pan<=0) intro_pan=10; intro_pan+=ntte_pal_timers[0] }
    }
}
function scrNTTEFullPalankingAlarm1() {
    if (intro) {
        ntte_pal_timers[1]=40+random(20); scrTarget()
        if (instance_exists(target) && scrNTTEFullWorldTargetVisible()) {
            scrNTTEFullWorldLook(point_direction(x,y,target.x,target.y)); scrNTTEFullWorldWalk(gunangle+orandom(30),60)
            var _seals=scrNTTEFullPalankingSeals(),_num=array_length(_seals)
            if ((point_distance(x,y,target.x,target.y)<80 && _num>2) || (scrNTTEFullValue(target,"reload",0)>0 && random(3)<1)) {
                ntte_pal_timers[1]=60+random(20); ntte_pal_timers[3]=6; image_index=0; sprite_index=spr_fire
                snd_play(scrNTTERefSound("PalankingSwipe")); instance_create(x,y-z,NTTEFullAssassinNotice)
            }
            else if (_num<=seal_max*4 && random(2)<1+(z<=0) && random(_num/2)<1) {
                ntte_pal_timers[1]=30+random(10); image_index=0; sprite_index=spr_call; snd_play(scrNTTERefSound("PalankingCall"))
                scrNTTEFullPalankingWave(x,y,gunangle+orandom(30),20+random(20)); scrNTTEFullPalankingWave(x,y,gunangle+orandom(60)+180,20+random(20))
            }
        }
    }
    else {
        ntte_pal_timers[1]=-1
        if (sprite_index!=spr_taun) { image_index=0; sprite_index=spr_call; snd_play(scrNTTERefSound("PalankingCall")) }
    }
}
function scrNTTEFullPalankingAlarm2() {
    if (ground_smash++<2) {
        ntte_pal_timers[2]=5; scrNTTEFullTrenchShake(x,y,40/ground_smash)
        snd_play(sndOasisExplosion,1.6+random(0.4)); snd_play(sndWallBreakBrick,0.6+random(0.2))
        scrNTTEFullPalankingSmashRing(x,y+32,ground_smash*24)
        for(var _i=0;_i<array_length(seal);++_i) seal[_i]=noone
    }
    else ground_smash=0
}
function scrNTTEFullPalankingAlarm3() {
    scr_projectile_create(x,y+16-z,NTTEFullPalankingSlash,gunangle,8)
    motion_add(gunangle,4*timescale); snd_play(sndHammer)
}
function scrNTTEFullPalankingStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    if (wkick!=0) wkick=approach(wkick,0,timescale)
    for(var _timer=0;_timer<4;++_timer) if (ntte_pal_timers[_timer]>=0) {
        ntte_pal_timers[_timer]-=timescale
        if (ntte_pal_timers[_timer]<=0) {
            ntte_pal_timers[_timer]=-1
            switch(_timer) { case 0:scrNTTEFullPalankingAlarm0();break; case 1:scrNTTEFullPalankingAlarm1();break; case 2:scrNTTEFullPalankingAlarm2();break; case 3:scrNTTEFullPalankingAlarm3();break }
            return;
        }
    }
    if (z<=0) walk=0
    else if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    var _num=0,_holdx=seal_x,_holdy=seal_y,_holding=[0,0]
    for(var _i=0;_i<array_length(seal);++_i) if (instance_exists(seal[_i])) _num++
    for(var _i=0;_i<array_length(seal);++_i) {
        var _seal=seal[_i]
        if (instance_exists(_seal)) {
            var _x=_holdx[_i]+1.5*right,_y=_holdy[_i]
            with (_seal) {
                if (scrNTTEFullValue(id,"hold",false)) {
                    walk=0
                    if (sprite_index==scrNTTEFullValue(id,"spr_spwn",-1) || !variable_instance_exists(id,"hold_x")) { hold_x=_x; hold_y=_y }
                    else {
                        _holding[_holdx[_i]>0]++
                        if (_num>1) {
                            if (hold_x!=_x) { hspeed=random(clamp(_x-hold_x,-maxspeed,maxspeed))*timescale; hold_x+=hspeed }
                            if (hold_y!=_y) { vspeed=random(clamp(_y-hold_y,-maxspeed,maxspeed))*timescale; hold_y+=vspeed }
                        }
                    }
                }
                else {
                    hold_x=x-other.x; hold_y=y-other.y
                    motion_add(point_direction(x,y,other.x+_x,other.y+_y)+orandom(10),walkspeed*timescale*timescale)
                    if (distance_to_point(other.x+_x,other.y+_y)<8 || distance_to_object(other)<8) hold=true
                }
            }
        }
        else if (seal[_i]!=noone) { seal[_i]=noone; _num-- }
    }
    if (active) {
        if (_num<seal_max) {
            var _all=scrNTTEFullPalankingSeals()
            for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(seal,_all[_i])<0) { scrNTTEFullPalankingAddSeal(id,_all[_i]); break }
        }
        if (_holding[0]+_holding[1]<=1) { if (zgoal!=0) { zgoal=0; zspeed=6 } }
        else {
            for(var _i=0;_i<2;++_i) if (_holding[_i]<=0) {
                for(var _j=0;_j<array_length(seal);++_j) if (seal[_j]!=noone && ((_j+!_i)%2) && random(3)<1) {
                    var _s=seal[_j]; seal[_j]=noone; var _offset=2*!_i-1
                    if (_j+_offset<0) _offset=1
                    if (_j+_offset>=array_length(seal)) _offset=-1
                    seal[_j+_offset]=_s
                }
            }
            if (zgoal==0) zgoal=12
        }
        if (instance_exists(Floor) && distance_to_object(Floor)>0 && zspeed==0) {
            var _floor=instance_nearest(x-16,y-16,Floor),_direction=point_direction(x,y,_floor.x,_floor.y)
            x+=lengthdir_x(timescale,_direction); y+=lengthdir_y(timescale,_direction)
        }
    }
    else {
        hp=max_hp; x=xstart; y=ystart
        if (ntte_pal_timers[0]<0 && instance_exists(Player) && scrNTTEFullPalankingPreintroClear(true) && !instance_exists(becomenemy)) { ntte_pal_timers[0]=30; phase++ }
    }
    var _pan=false
    if (intro_pan>0) {
        intro_pan-=timescale
        if (ntte_pal_timers[0]>0 && intro_pan<ntte_pal_timers[0]) intro_pan=ntte_pal_timers[0]
        if (scrNTTEFullPalankingPreintroClear()) {
            _pan=true
            if (instance_exists(Player)) {
                var _police=[IDPDSpawn,VanSpawn,WantRevivePopoFreak]
                for(var _i=0;_i<array_length(_police);++_i) with (_police[_i]) if (alarm[0]>0) alarm[0]+=timescale
            }
        }
        scrNTTEFullPortalPickups()
        var _all=scrNTTEFullPalankingSeals()
        for(var _i=0;_i<array_length(_all);++_i) _all[_i].attack_delay=15+random(30)
    }
    if (_pan) {
        with (BackCont) {
            var _current=scrNTTEFullValue(id,"ntte_full_view_object",noone)
            if (scrNTTEFullValue(_current,"creator",noone)!=other.id) ntte_full_view_object=other.id
            ntte_full_view_pan_factor=10000
        }
    }
    else {
        with (BackCont) {
            var _current=scrNTTEFullValue(id,"ntte_full_view_object",noone)
            if (_current==other.id || scrNTTEFullValue(_current,"creator",noone)==other.id) { ntte_full_view_object=noone; ntte_full_view_pan_factor=undefined }
        }
    }
    z+=zspeed*timescale
    if (z<=zgoal) {
        if (z<zgoal && zspeed==0) { if (zgoal<=0) z=zgoal; else zspeed=(zgoal-z)/2 }
        if (zspeed<=0) {
            if (zgoal>0) { z=zgoal+zspeed; zspeed*=power(0.8,timescale) }
            else if (zspeed<0) {
                var _last=mask_index; mask_index=mask_hold
                if (zspeed< -5 && place_meeting(x,y,Floor)) {
                    ntte_pal_timers[2]=1; snd_play_hit_big(sndBigBanditMeleeHit,0.3)
                    // Original raw self-hit bypasses team/can-hit filtering.
                    scrNTTEFullPalankingHurt(id,40,direction,2*timescale,id)
                }
                mask_index=_last; zspeed*=-0.2
            }
            if (abs(zspeed)<zfriction) { zspeed=0; z=zgoal }
        }
    }
    else zspeed-=zfriction*timescale
    if (tauntdelay>0 && !instance_exists(Player)) {
        tauntdelay-=timescale
        if (tauntdelay<=0) { image_index=0; sprite_index=spr_taun; snd_play(scrNTTERefSound("PalankingTaunt")) }
    }
    var _end=image_index+image_speed>=image_number
    if (sprite_index!=spr_burp) {
        if (sprite_index!=spr_call && sprite_index!=spr_taun && sprite_index!=spr_fire) sprite_index=scrNTTEFullWorldEnemySprite()
        else if (_end) sprite_index=spr_idle
    }
    else if (_end) image_index=1
    if (sprite_index==spr_call) {
        var _frame=floor(image_index)
        if (image_index<_frame+image_speed && (_frame==4 || _frame==7)) snd_play(sndHitRock,0.8+orandom(0.2),0.6)
    }
    if (z<=4) {
        mask_index=mask_hold
        if (spr_shadow!=mskNone) { spr_shadow_hold=spr_shadow; spr_shadow=mskNone }
    }
    else {
        spr_shadow=spr_shadow_hold
        if (mask_index!=mskNone) { mask_hold=mask_index; mask_index=mskNone }
        mask_index=mask_hold
        if (place_meeting(x,y,Tangle)) { x-=hspeed*0.5; y-=vspeed*0.5 }
        mask_index=mskNone
    }
}
function scrNTTEFullPalankingEndStep() {
    if (lockstep_stop) return;
    for(var _i=0;_i<array_length(seal);++_i) {
        var _seal=seal[_i]
        if (instance_exists(_seal) && scrNTTEFullValue(_seal,"hold",false) && variable_instance_exists(_seal,"hold_x") && variable_instance_exists(_seal,"hold_y")) {
            with (_seal) {
                if (mask_index!=mskNone) {
                    x=other.x+hold_x; y=other.y+hold_y; xprevious=x; yprevious=y
                    hspeed=other.hspeed; vspeed=other.vspeed; depth=other.depth-(hold_y>24 && hold)
                }
                else hold=false
            }
        }
    }
}
function scrNTTEFullPalankingDraw() {
    var _hurt=(nexthurt>=current_frame+4 && active) || (sprite_index==spr_hurt && image_index<1)
    if (z>4 || place_meeting(x,y,Floor)) {
        if (_hurt) gpu_set_fog(true,image_blend,0,0)
        draw_sprite_ext(spr_bott,image_index,x,y-z,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
        if (_hurt) gpu_set_fog(false,0,0,0)
    }
    _hurt= _hurt && sprite_index!=spr_hurt
    if (_hurt) gpu_set_fog(true,image_blend,0,0)
    draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    if (_hurt) gpu_set_fog(false,0,0,0)
}
function scrNTTEFullPalankingHurt(_target,_damage,_direction,_force,_attacker) {
    with (_target) {
        nexthurt=current_frame+6
        if (active) {
            hp-=_damage; motion_add(_direction,_force); snd_play_hit(snd_hurt,0.3)
            if (sprite_index!=spr_call && sprite_index!=spr_burp && sprite_index!=spr_fire) { sprite_index=spr_hurt; image_index=0 }
        }
        else if (sprite_index==spr_idle && scrNTTEFullPortalPointSeen(x,y,-16)) {
            snd_play(scrNTTERefSound("PalankingTaunt")); sprite_index=spr_taun; image_index=0; snd_play_hit(sndHitWall,0.3)
        }
        var _half=max_hp/2
        if (hp<=_half && hp+_damage>_half) {
            if (snd_lowh==sndRocket) snd_play(snd_lowh,0.5); else snd_play(snd_lowh)
            scrNTTEFullTrenchShake(x,y,30)
            repeat(5) instance_create(x,y-z+16,Debris)
        }
        if (instance_exists(_attacker) && instance_is(_attacker,projectile)) {
            var _dust=instance_create(_attacker.x,_attacker.y,Dust)
            /* NTTE DUST LIFETIME palanking-deflect */ if(instance_exists(_dust)) {_dust.coast_water=1
            if (_dust.y>y+12) _dust.depth=depth-1 }
            if (random(8)<scrNTTEFullValue(_attacker,"damage",0)) {
                with (_attacker) snd_play_hit(sndHitRock,0.3)
                var _fx=instance_create(_attacker.x,_attacker.y,Debris),_force_raw=_force/max(timescale,0.000001)
                with (_fx) motion_set(_direction+180+orandom(_force_raw*4),(2+random(_force_raw/2))*timescale)
            }
        }
    }
}
function scrNTTEFullPalankingDeath() {
    if (raddrop<=0) raddrop=40
    var _die=instance_create(x,y,NTTEFullPalankingDie)
    _die.spr_dead=spr_dead; _die.sprite_index=spr_hurt; _die.image_xscale=image_xscale*right; _die.mask_index=mask_index
    _die.snd_dead=snd_dead; _die.raddrop=raddrop; _die.size=size; _die.z=z; _die.speed=min(speed,maxspeed*timescale); _die.direction=direction
    snd_play(scrNTTERefSound("PalankingSwipe"),1,4); snd_dead=-1; raddrop=0
    with (MusCont) alarm[1]=1
}
function scrNTTEFullPalankingSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops
    GameCont.loops=0
    var _floor=instance_create(66000,66000,Floor),_boss=instance_create(66016,66016,NTTEFullPalanking)
    assert(_boss.max_hp==scrNTTEFullSewerBossHP(300) && _boss.hp==_boss.max_hp && _boss.seal_max==4 && !_boss.active && !_boss.canmelee && !_boss.corpse && _boss.team==0,"Palanking source HP/inactive safety/carrier count changed")
    var _health=_boss.hp
    scrNTTEFullPalankingHurt(_boss,10,90,2*timescale,noone)
    assert(_boss.hp==_health && _boss.nexthurt==current_frame+6,"Inactive Palanking accepted damage or lost source6tick immunity")
    with (_boss) scrNTTEFullPalankingAlarm0()
    assert(_boss.intro_pan==70 && _boss.ntte_pal_timers[0]==60 && _boss.ntte_pal_timers[1]==20,"Palanking opening cinematic/safety delays changed")
    _boss.phase=0
    var _waves=instance_number(NTTEFullSealWave)
    with (_boss) scrNTTEFullPalankingAlarm0()
    assert(instance_number(NTTEFullSealWave)==_waves+5,"Palanking first intro omitted five ocean waves")
    _boss.phase=1
    repeat(4) with (_boss) scrNTTEFullPalankingAlarm0()
    assert(_boss.phase==5 && array_length(_boss.seal)==4,"Palanking original four sequential palanquin carriers missing")
    for(var _i=0;_i<4;++_i) {
        var _seal=_boss.seal[_i]
        assert(instance_exists(_seal) && _seal.hold && _seal.scared && _seal.creator==_boss,"Palanking carrier source hold/creator/scared setup missing")
        with (_seal) { scrNTTEFullSealSetup(); sprite_index=spr_idle; hold_x=_boss.seal_x[_i]; hold_y=_boss.seal_y[_i] }
    }
    with (_boss) scrNTTEFullPalankingAlarm0()
    assert(_boss.active && _boss.team==1 && _boss.zgoal==12 && _boss.ntte_pal_timers[0]==30,"Palanking source activation/lift transition changed")
    _boss.ntte_pal_timers=[-1,-1,-1,-1]; _boss.intro_pan=0
    with (_boss) scrNTTEFullPalankingStep()
    assert(_boss.zgoal==12 && _boss.zspeed>0,"Two-sided carriers failed to lift Palanking")
    with (_boss) scrNTTEFullPalankingEndStep()
    for(var _i=0;_i<4;++_i) {
        var _seal=_boss.seal[_i]
        // Native x/y are float32: coordinates around 66016 round by up to
        // half a 1/128px ULP. Keep production pinning unchanged.
        assert(abs(_seal.x-(_boss.x+_seal.hold_x))*1000<=4 && abs(_seal.y-(_boss.y+_seal.hold_y))*1000<=4,"Palanking end-step carrier pinning changed")
    }
    for(var _i=1;_i<4;++_i) instance_destroy(_boss.seal[_i],false)
    with (_boss) scrNTTEFullPalankingStep()
    assert(_boss.zgoal==0 && _boss.zspeed>0,"Insufficient carriers did not release Palanking")
    _boss.z=1; _boss.zspeed=-8; _boss.zgoal=0; _health=_boss.hp
    with (_boss) scrNTTEFullPalankingStep()
    assert(_boss.hp==_health-40 && _boss.ntte_pal_timers[2]==1,"Palanking hard landing omitted original40 self damage/smash trigger")
    var _slashes=instance_number(NTTEFullPalankingSlashGround)
    repeat(2) with (_boss) scrNTTEFullPalankingAlarm2()
    assert(instance_number(NTTEFullPalankingSlashGround)==_slashes+32 && _boss.ground_smash==2,"Palanking two16-slash expanding smash rings changed")
    with (_boss) scrNTTEFullPalankingAlarm2()
    assert(_boss.ground_smash==0,"Palanking third smash alarm failed to end ring sequence")
    var _slash=instance_number(NTTEFullPalankingSlash)
    with (_boss) scrNTTEFullPalankingAlarm3()
    assert(instance_number(NTTEFullPalankingSlash)==_slash+1,"Palanking attack omitted actual source pickup/enemy tossing slash")
    _boss.raddrop=0; _boss.hp=0
    var _dies=instance_number(NTTEFullPalankingDie)
    with (_boss) scrNTTEFullPalankingStep()
    assert(!instance_exists(_boss) && instance_number(NTTEFullPalankingDie)==_dies+1,"Palanking real death omitted airborne PalankingDie")
    var _die=instance_find(NTTEFullPalankingDie,_dies)
    assert(_die.raddrop==40 && _die.image_alpha==0,"Palanking empty rad budget death fallback40/original own-draw setup changed")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops
    scrNTTESmokeLog("FULL WORLD PALANKING INACTIVE IMMUNITY/SAFETY+FIVE OCEAN WAVES/FOUR REAL CARRIERS/TWO-SIDED LIFT+ENDSTEP PINNING/CARRIER LOSS/HARD LANDING40DAMAGE/TWO16-SLASH RINGS/REAL SLAP/AIRBORNE DEATH+FALLBACK RAD BUDGET OK")
}
