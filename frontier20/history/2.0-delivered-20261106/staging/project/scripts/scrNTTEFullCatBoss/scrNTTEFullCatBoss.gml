// NTTE 2.062 CatBoss: delayed rail fans, interruptible super charge, gas dash,
// underground Cat reinforcements, and the paired boss death-healing mechanic.
function scrNTTEFullCatBossConfigure() {
    ntte_full_boss_hp=scrNTTEFullSewerBossHP(200)
    max_hp=ntte_full_boss_hp/(1+GameCont.loops/20); raddrop=24; meleedamage=3; size=3
    spr_idle=scrNTTERefSprite("CatBossIdle"); spr_walk=scrNTTERefSprite("CatBossWalk")
    spr_hurt=scrNTTERefSprite("CatBossHurt"); spr_dead=scrNTTERefSprite("CatBossDead")
    spr_chrg=scrNTTERefSprite("CatBossChrg"); spr_fire=scrNTTERefSprite("CatBossFire")
    spr_weap=scrNTTERefSprite("CatBossWeap"); ntte_full_charge_weapon=scrNTTERefSprite("CatBossWeapChrg")
    sprite_index=spr_idle; mask_index=mskBanditBoss; depth=-2
    hitid=[spr_idle,"BIG CAT"]; boss=true; walk=0
    ntte_full_intro=false; ntte_full_taunt=40; ntte_full_dash=0
    ntte_full_super=false; ntte_full_super_time=0; ntte_full_super_max=30; ntte_full_super_break=6
    ntte_full_timers=[6,30+random(20),-1,300+random(150)]
    ntte_full_last_hp=ntte_full_boss_hp; ntte_full_loop=-1
}

function scrNTTEFullCatBossAfterCreate() {
    max_hp=ntte_full_boss_hp; hp=max_hp; canmelee=false
    spr_shadow=shd48; spr_shadow_x=0; spr_shadow_y=3
    snd_hurt=scrNTTERefSound("BigCatHurt"); snd_dead=scrNTTERefSound("BigCatDead")
    gunangle=random(360); direction=gunangle
    alarm[0]=-1; alarm[1]=-1; alarm[2]=-1; alarm[3]=-1
}

function scrNTTEFullCatBossDecision() {
    ntte_full_timers[1]=20+random(20)
    if (ntte_full_super_time>0) {
        ntte_full_timers[1]=1; --ntte_full_super_time
        wkick=6; gunangle=270+50*right+orandom(5)
        scrNTTEFullTrenchShake(x,y,4,true)
        if (random(2)<1) {
            var _w=(1-ntte_full_super_time/ntte_full_super_max)*12,_h=irandom(8)*right,
                _fx=instance_create(x+lengthdir_x(_w,gunangle)+lengthdir_x(_h,gunangle+90),y+lengthdir_y(_w,gunangle)+lengthdir_y(_h,gunangle+90),RadEat)
            _fx.sprite_index=choose(sprEatRadPlut,sprEatRadPlut,sprEatBigRadPlut); _fx.depth=-3
        }
        if (ntte_full_super_time<=0) {
            ntte_full_super=true; ntte_full_timers[1]=12; wkick=-3
            gunangle=right ? 340:200
            snd_play(sndLaserCannon,0.8); snd_play(sndGunGun,1.2); snd_play(sndStrongSpiritLost,0.8)
            var _fx=instance_create(x+lengthdir_x(20,gunangle),y+lengthdir_y(20,gunangle),ThrowHit)
            _fx.depth=-3
        }
        return;
    }
    with (NTTEFullBatBoss) {
        ntte_full_timers[1]=20+random(20)
        other.ntte_full_timers[1]+=ntte_full_timers[1]
    }
    if (scrNTTEFullTrenchTarget()) {
        if (!ntte_full_super && random(5)<1) {
            ntte_full_timers[1]=1; ntte_full_super_time=ntte_full_super_max; ntte_full_super_break=6
            snd_play(sndLaserCannonCharge,0.6); snd_play(sndTechnomancerActivate,1.4)
        }
        else {
            scrNTTEFullTrenchLook(ntte_full_direction)
            if (random(5)<4) {
                if (random(4)<3 && ntte_full_visible && (ntte_full_distance<80 || random(2)<1)) {
                    ntte_full_timers[1]=10
                    var _p=instance_create(x,y,NTTEFullCatBossAttack)
                    _p.target=target; _p.ntte_full_type=ntte_full_super
                    _p.creator=id; _p.team=team; _p.direction=gunangle
                    ntte_full_timers[1]+=_p.ntte_full_timer
                    snd_play(sndShotReload); snd_play(sndSnowTankAim,2.5+random(0.5))
                    snd_play(sndLilHunterSniper,(ntte_full_super ? 0.25:1.5)+random(0.5),0.5)
                    if (ntte_full_super) snd_play(sndLaserCannonCharge,0.4+orandom(0.1),0.5)
                    ntte_full_super=false
                }
                else if (ntte_full_distance>40) {
                    ntte_full_timers[2]=15; ntte_full_timers[1]+=15
                    sprite_index=spr_chrg; image_index=0
                    repeat(16) scrNTTEFullTrenchFX(x,y,0,random(5),Dust)
                    snd_play(sndBigBanditMeleeStart,0.6+random(0.2),0.4)
                    snd_play(scrNTTERefSound("BigCatCharge"))
                }
            }
            else {
                var _d=ntte_full_direction+180
                _d+=30*sign(angle_difference(direction,_d))
                scrNTTEFullTrenchWalk(point_direction(x,y,target.x+lengthdir_x(64,_d),target.y+lengthdir_y(64,_d)),random_range(15,40))
            }
        }
    }
    else { scrNTTEFullTrenchWalk(direction+orandom(30),random_range(15,40)); scrNTTEFullTrenchLook(direction) }
}

function scrNTTEFullCatBossDash() {
    ntte_full_timers[2]=1
    var _dir=scrNTTEFullTrenchTarget() ? ntte_full_direction:gunangle
    if (ntte_full_dash<=0) {
        ntte_full_dash=16+random(8); canmelee=true
        direction=gunangle+random_range(40,60)*choose(-1,1); sprite_index=spr_fire
        sleep(26); scrNTTEFullTrenchShake(x,y,18)
        snd_play(sndToxicBoltGas); snd_play(sndFlamerStart)
        ntte_full_loop=audio_play_sound(sndFlamerLoop,0,true)
    }
    motion_add(direction,1.4*timescale); motion_add(_dir,0.7*timescale)
    scrNTTEClearWalls(x+hspeed,y+vspeed,24)
    repeat(2+irandom(3)) {
        var _p=scr_projectile_create(x,y,NTTECatGas,direction+180+orandom(15),2+random(1))
        _p.friction=0.16*timescale*timescale; _p.team=team==team_player ? team_player:team_none
    }
    wkick=6
    repeat(1+irandom(2)) { var _fx=instance_create(x,y,AcidStreak); _fx.image_angle=direction+180+orandom(64) }
    if (--ntte_full_dash<=0) {
        ntte_full_timers[2]=-1; alarm[11]=-1; canmelee=false
        scrNTTEFullTrenchWalk(direction+orandom(20),random_range(15,30)); sprite_index=spr_walk
        scrNTTEFullTrenchShake(x,y,12); snd_play(sndFlamerStop)
        if (ntte_full_loop>=0) audio_stop_sound(ntte_full_loop)
        ntte_full_loop=-1
    }
    var _mid=_dir+angle_difference(direction,_dir)*0.5
    scrNTTEFullTrenchLook(gunangle+angle_difference(_mid,gunangle)*0.5)
}

function scrNTTEFullCatBossSummon() {
    ntte_full_timers[3]=150
    if (random(1+instance_number(NTTECat))<1) {
        var _cat=instance_create(0,0,NTTECat)
        with (_cat) scrNTTECatHide()
        _cat.ntte_cat_cantravel=true; _cat.ntte_cat_timer=random_range(60,150)
    }
}

function scrNTTEFullCatBossHurt(_damage,_attacker,_direction=undefined,_force=0) {
    if (hp<=max_hp/2 && hp+_damage>max_hp/2) snd_play(scrNTTERefSound("BigCatTaunt"))
    if (ntte_full_super_time>0 && ntte_full_super_break>0) {
        ntte_full_super_time+=_damage*4; --ntte_full_super_break
        if (ntte_full_super_time>=ntte_full_super_max) {
            ntte_full_timers[1]=40+irandom(20); ntte_full_super_time=0; gunangle=right ? 300:240
            sleep(100); scrNTTEFullTrenchShake(x,y,20)
            var _dir=is_undefined(_direction) ? (instance_exists(_attacker) ? point_direction(_attacker.x,_attacker.y,x,y):direction):_direction
            motion_add(_dir,4*timescale)
            snd_play(sndGunGun,0.8); snd_play(sndStrongSpiritLost,1.2)
            var _fx=instance_create(x,y,ImpactWrists); _fx.depth=-3
            repeat(2+irandom(2)) {
                _fx=instance_create(x,y,Rad)
                with (_fx) { motion_set(_dir+orandom(30),(4+random(4))*timescale); friction=0.4*timescale*timescale }
            }
            repeat(3+irandom(6)) {
                _fx=instance_create(x,y,Smoke)
                with (_fx) motion_set(_dir+orandom(30),(4+random(4))*timescale)
            }
            _fx=instance_create(x+lengthdir_x(16,gunangle),y+lengthdir_y(16,gunangle),FishA)
            _fx.image_angle=gunangle; _fx.depth=-3
        }
    }
    ntte_full_last_hp=hp
}

function scrNTTEFullCatBossStep() {
    if (hp<ntte_full_last_hp) scrNTTEFullCatBossHurt(ntte_full_last_hp-hp,noone)
    var _due=scrNTTEFullTrenchClock()
    if (_due[0]) {
        if (!ntte_full_intro) {
            ntte_full_intro=true; scrNTTEFullBossIntro("CatBat")
            with (NTTEFullBatBoss) if (ntte_full_timers[0]>0) ntte_full_intro=true
            with (NTTEFullCatBoss) if (ntte_full_timers[0]>0) ntte_full_intro=true
        }
        snd_play(scrNTTERefSound("BigCatIntro"))
    }
    if (_due[1]) scrNTTEFullCatBossDecision()
    if (_due[2]) scrNTTEFullCatBossDash()
    if (_due[3]) scrNTTEFullCatBossSummon()
    if (ntte_full_taunt>0 && !instance_exists(Player)) {
        ntte_full_taunt-=timescale
        if (ntte_full_taunt<=0) {
            if (!instance_exists(NTTEFullBatBoss)) snd_play(scrNTTERefSound("BigCatTaunt"))
            walk=0; snd_play(sndToxicBoltGas,0.4,0.5)
            var _p=instance_create(x,y+8,ToxicDelay); _p.alarm[0]=1
        }
    }
    if (sprite_index==spr_chrg) {
        walk=0; speed=0
        repeat(2) if (random(3)<timescale) {
            var _fx=instance_create(x+orandom(4),y+orandom(4),AcidStreak)
            with (_fx) { motion_add(random(360),timescale); motion_add(other.gunangle+180+orandom(40),random_range(2,4)*timescale); image_angle=direction }
            _fx.image_blend=merge_color(_fx.image_blend,c_lime,random(0.1)); _fx.depth=depth
        }
    }
    else {
        var _max=(3+3.5*(ntte_full_dash>0))*timescale
        if (walk>0) { walk-=timescale; speed+=0.8*timescale*timescale }
        speed=min(speed,_max)
        if (ntte_full_dash<=0 && walk>0 && place_meeting(x+hspeed,y+vspeed,Wall)) {
            var _attacking=false
            with (NTTEFullCatBossAttack) if (creator==other.id) _attacking=true
            if (!_attacking) {
                if (place_meeting(x+hspeed,y,Wall)) hspeed=-hspeed
                if (place_meeting(x,y+vspeed,Wall)) vspeed=-vspeed
                scrNTTEFullTrenchLook(gunangle+angle_difference(direction,gunangle)*0.5)
            }
        }
    }
    if (ntte_full_super && random(10)<timescale) {
        var _p=instance_create(x+lengthdir_x(12,gunangle),y+lengthdir_y(12,gunangle),PortalL); _p.depth=-3
    }
}

function scrNTTEFullCatBossDraw() {
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    var _spr=spr_weap,_frame=ntte_full_super ? current_frame*image_speed:0
    if (ntte_full_super_time>0) {
        _spr=ntte_full_charge_weapon; _frame=sprite_get_number(_spr)*(1-ntte_full_super_time/ntte_full_super_max)
    }
    draw_sprite_ext(_spr,_frame,x-lengthdir_x(wkick,gunangle),y-lengthdir_y(wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
}

function scrNTTEFullCatBossDeath() {
    if (hp>0) return;
    instance_create(x,y,ToxicDelay); scrNTTEFullSewerPartnerDeath(NTTEFullBatBoss)
}

function scrNTTEFullCatBossCleanup() {
    if (ntte_full_loop>=0) audio_stop_sound(ntte_full_loop)
    ntte_full_loop=-1
}

function scrNTTEFullSewerBossBlocksHit(_victim,_attacker) {
    if (!instance_exists(_victim)) return false
    if (instance_is(_victim,NTTEFullBatBoss) && !_victim.ntte_full_active) return true
    if (instance_is(_victim,NTTEFullCatBoss) && instance_exists(_attacker) && instance_is(_attacker,ToxicGas)) return true
    return false
}
