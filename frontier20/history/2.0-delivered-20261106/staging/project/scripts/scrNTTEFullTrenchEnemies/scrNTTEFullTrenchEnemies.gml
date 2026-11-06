// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// Native adaptations of NTTE 2.062 tetrench.mod.gml.
// Speeds are native pixels per rendered frame; timers remain original 30 Hz ticks.
function scrNTTEFullTrenchLook(_angle) {
    gunangle=(_angle+720) mod 360
    if (lengthdir_x(1,gunangle)!=0) right=sign(lengthdir_x(1,gunangle))
}

function scrNTTEFullTrenchWalk(_angle,_time) {
    direction=_angle; walk=_time
    if (speed<friction) speed=friction
}

function scrNTTEFullTrenchTarget() {
    scrTarget()
    ntte_full_distance=instance_exists(target) ? point_distance(x,y,target.x,target.y):infinity
    ntte_full_direction=instance_exists(target) ? point_direction(x,y,target.x,target.y):gunangle
    ntte_full_visible=instance_exists(target) && scrTargetIsVisible(target)
    return instance_exists(target)
}

function scrNTTEFullTrenchTimer(_slot,_amount) {
    ntte_full_timers[_slot]=_amount
}

function scrNTTEFullTrenchClock() {
    var _due=array_create(4,false)
    for(var _i=0;_i<4;++_i) {
        if (ntte_full_timers[_i]<0) continue
        ntte_full_timers[_i]-=timescale
        if (ntte_full_timers[_i]<=0) {
            ntte_full_timers[_i]=-1; _due[_i]=true
        }
    }
    return _due
}

function scrNTTEFullTrenchFX(_x,_y,_radius,_velocity,_object) {
    var _p=instance_create(_x+orandom(_radius),_y+orandom(_radius),_object)
    with (_p) motion_set(random(360),_velocity*timescale)
    return _p
}

function scrNTTEFullTrenchShake(_x,_y,_amount,_maximum=false) {
    if (!point_in_rectangle(_x,_y,view_xview-32,view_yview-32,view_xview+view_width+32,view_yview+view_height+32)) return;
    if (_maximum) { with (BackCont) shake=max(shake,_amount*UberCont.opt_shake) }
    else scr_screenshake(_amount)
}

function scrNTTEFullAnglerConfigure(_gold=false) {
    ntte_full_gold=_gold
    var _prefix=_gold ? "AnglerGold":"Angler"
    spr_idle=scrNTTERefSprite(_prefix+"Idle")
    spr_walk=scrNTTERefSprite(_prefix+"Walk")
    spr_hurt=scrNTTERefSprite(_prefix+"Hurt")
    spr_dead=scrNTTERefSprite(_prefix+"Dead")
    ntte_full_appear=scrNTTERefSprite(_prefix+"Appear")
    sprite_index=ntte_full_appear
    hitid=[spr_idle,_gold ? "GOLDEN ANGLER":"ANGLER"]
    max_hp=45; raddrop=_gold ? 45:25; meleedamage=4; size=3
    walk=0; ntte_full_walkspeed=0.6; ntte_full_maxspeed=_gold ? 5:3
    ntte_full_hiding=true; ntte_full_ammo=0; ntte_full_timers=[-1,30+irandom(30),-1,-1]
    depth=-2; mask_index=-1
}

function scrNTTEFullAnglerAfterCreate() {
    if (ntte_full_gold) { max_hp=round(max_hp*1.6); hp=round(hp*1.6) }
    x-=right*6; y-=8
    xprevious=x; yprevious=y; xstart=x; ystart=y
    snd_hurt=ntte_full_gold ? sndFreakPopoHurt:sndFireballerHurt
    snd_dead=sndOasisDeath
    alarm[1]=-1; alarm[2]=-1
    ntte_full_last_hp=hp
    scrNTTEFullAnglerHide()
}

function scrNTTEFullAnglerHide() {
    ntte_full_hiding=true; sprite_index=ntte_full_appear
    image_index=image_number-1+image_speed
    mask_index=scrNTTERefSprite("msk.AnglerHidden",right<0)
    spr_shadow=shd24; spr_shadow_x=6*right; spr_shadow_y=9; walk=0
    snd_play(sndJockFire,1.6+random(0.5),0.2)
    repeat(5) scrNTTEFullTrenchFX(x,y,24,2,Dust)
}

function scrNTTEFullAnglerAppear() {
    ntte_full_hiding=false; mask_index=mskFrogQueen
    sprite_index=ntte_full_appear
    spr_shadow=shd64B; spr_shadow_x=0; spr_shadow_y=3
    scrNTTEClearWalls(x,y,24)
    ntte_full_timers[1]=15+orandom(2); ntte_full_ammo=3+2*ntte_full_gold
    snd_play(sndBigBanditMeleeStart,0.8+random(0.2))
    scrNTTEFullTrenchShake(x,y,10)
    repeat(5) scrNTTEFullTrenchFX(x,y,24,0,Dust)
    with (NTTEFullAngler) {
        if (ntte_full_gold<other.ntte_full_gold && ntte_full_hiding && random(2)<1+other.ntte_full_gold
            && point_distance(x,y,other.x,other.y)<64*(1+other.ntte_full_gold))
            scrNTTEFullAnglerAppear()
    }
    if (ntte_full_gold) {
        var _p=scr_projectile_create(x,y,NTTEBatScreech,0,0)
        _p.sprite_index=scrNTTERefSprite("AnglerGoldScreech")
        snd_play(sndEnergyHammerUpg,0.9,0.9)
        var _s=audio_play_sound(sndLilHunterLaunch,0,false)
        if(_s>=0) { audio_sound_pitch(_s,0.5); audio_sound_gain(_s,1.1,0); audio_sound_gain(_s,0,2500) }
        _s=audio_play_sound(sndNothing2DeadStart,0,false)
        if(_s>=0) { audio_sound_pitch(_s,1); audio_sound_gain(_s,0.75,0); audio_sound_set_track_position(_s,1) }
    }
}

function scrNTTEFullAnglerDecision() {
    ntte_full_timers[1]=6+irandom(6)
    scrNTTEFullTrenchTarget()
    if (ntte_full_hiding) {
        if (ntte_full_visible && ntte_full_distance<((ntte_full_gold && hp<max_hp) ? 96:48))
            scrNTTEFullAnglerAppear()
        return;
    }
    if (ntte_full_ammo>0) {
        --ntte_full_ammo; ntte_full_timers[1]=ntte_full_gold ? 6:8
        scrNTTEFullTrenchWalk((ntte_full_visible ? ntte_full_direction:direction)+orandom(40),5)
        scrNTTEFullTrenchLook(direction)
        speed=(ntte_full_maxspeed+10)*timescale
        snd_play(sndRoll,1.4+random(0.4),1.2)
        snd_play(sndBigBanditMeleeStart,1.2+random(0.2),0.5)
        repeat(4) {
            var _fx=scrNTTEFullTrenchFX(x,y,16,0,Dust)
            with (_fx) motion_set(other.direction+180,random(4)*timescale)
        }
        sprite_index=spr_hurt; image_index=1
        if (ntte_full_gold) scrNTTEClearWalls(x+hspeed,y+vspeed,24)
    }
    else if (ntte_full_ammo==0) {
        ntte_full_ammo=-1; ntte_full_timers[1]=15
        scrNTTEFullTrenchWalk(direction+180,8); scrNTTEFullTrenchLook(direction)
    }
    else {
        ntte_full_timers[1]=20+irandom(20)
        if (instance_exists(target) && ntte_full_distance<96*(1+ntte_full_gold)
            && (ntte_full_gold || ntte_full_visible)) {
            scrNTTEFullTrenchWalk(ntte_full_direction+orandom(20),random_range(25,50))
            scrNTTEFullTrenchLook(direction)
            if (random(2)<1) {
                ntte_full_ammo=irandom_range(1,3)+2*ntte_full_gold
                if (ntte_full_gold) {
                    ntte_full_timers[1]=ceil(ntte_full_timers[1]*0.4); direction+=180
                    var _p=scr_projectile_create(x,y,NTTEBatScreech,0,0)
                    _p.sprite_index=scrNTTERefSprite("AnglerGoldScreech")
                    with (NTTEFullAngler) if (!ntte_full_gold && ntte_full_hiding
                        && point_distance(x,y,other.x,other.y)<128) scrNTTEFullAnglerAppear()
                }
            }
        }
        else {
            scrNTTEFullTrenchWalk(direction+orandom(30),random_range(20,50))
            scrNTTEFullTrenchLook(direction)
            var _floor=noone,_best=infinity
            with (Floor) if (sprite_index!=scrNTTERefSprite("FloorTrenchB")) {
                var _d=point_distance(bbox_center_x,bbox_center_y,other.x+other.hspeed*4,other.y+other.vspeed*4)
                if (_d<_best) { _best=_d; _floor=id }
            }
            if (instance_exists(_floor)) direction=point_direction(x,y,(_floor.bbox_left+(_floor.bbox_right-1))/2,(_floor.bbox_top+(_floor.bbox_bottom-1))/2)
            if (instance_exists(target) && ntte_full_distance>160 && !scrNTTEFullTrenchPitGet(x,y)) scrNTTEFullAnglerHide()
        }
    }
}

function scrNTTEFullAnglerHurt() {
    if (ntte_full_gold) {
        snd_play(sndEnergyHammerUpg,0.8+random(0.2),0.7)
        snd_play(sndSwapGold,0.9+random(0.2),0.4)
    }
    if (hp>0 && ntte_full_hiding) scrNTTEFullAnglerAppear()
    else if (sprite_index!=ntte_full_appear) { sprite_index=spr_hurt; image_index=0 }
    if (hp<max_hp*2/3 && random(3)<2 && ntte_full_ammo<0) {
        walk=0; ntte_full_ammo=1+ntte_full_gold; ntte_full_timers[1]=4
        if (ntte_full_gold) {
            var _p=scr_projectile_create(x,y,NTTEBatScreech,0,0)
            _p.sprite_index=scrNTTERefSprite("AnglerGoldScreech")
            var _s=audio_play_sound(sndLilHunterLaunch,0,false)
            var _pitch=0.5+orandom(0.1); if(_s>=0) { audio_sound_pitch(_s,_pitch); audio_sound_gain(_s,1.6,0); audio_sound_gain(_s,0,750) }
            _s=audio_play_sound(sndNothing2DeadStart,0,false)
            if(_s>=0) { audio_sound_set_track_position(_s,1); audio_sound_gain(_s,1.3,0) }
        }
    }
    ntte_full_last_hp=hp
}

function scrNTTEFullAnglerStep() {
    if (hp<ntte_full_last_hp) scrNTTEFullAnglerHurt()
    ntte_full_last_hp=hp
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) scrNTTEFullAnglerDecision()
    var _max=ntte_full_maxspeed
    if (walk>0) {
        walk-=timescale; speed+=ntte_full_walkspeed*timescale*timescale
        if (ntte_full_ammo>=0) _max+=8
    }
    if (speed>_max*timescale) speed=_max*timescale
    if (ntte_full_hiding) {
        sprite_index=ntte_full_appear
        if (image_index>0) image_index-=min(image_index,image_speed*2)
    }
    else {
        if (sprite_index==ntte_full_appear && image_index+image_speed>=image_number) { sprite_index=spr_idle; image_index=0 }
        else if (sprite_index!=ntte_full_appear && sprite_index!=spr_hurt)
            sprite_index=speed>0 ? spr_walk:spr_idle
        if (ntte_full_ammo>=0) speed*=power(0.85,timescale)
    }
}

function scrNTTEFullAnglerDraw() {
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}

function scrNTTEFullAnglerDeath() {
    if (hp>0) return;
    scrNTTEFullPickupDropBody(80,0); scrNTTEFullPickupDropBody(60,5,0)
    var _x=ntte_full_hiding ? x:x+20*right,_y=ntte_full_hiding ? y:y-10
    var _lure=instance_create(_x,_y,CorpseActive)
    _lure.sprite_index=ntte_full_gold ? sprRadChestBigDead:sprRadChestCorpse
    _lure.mask_index=-1; _lure.size=2
    with (_lure) motion_set(other.direction+orandom(10),other.speed+random(2)*timescale)
    var _p=instance_create(_x,_y,PortalClear)
    _p.image_xscale=0.4; _p.image_yscale=0.4
    while(raddrop>25) {
        raddrop-=10; _p=instance_create(_x,_y,BigRad)
        with (_p) { motion_add(random(360),random(4)*timescale); motion_add(other.direction,min(other.speed/3,3*timescale)) }
    }
    repeat(raddrop) {
        _p=instance_create(_x,_y,Rad)
        with (_p) { motion_add(random(360),random(5)*timescale); motion_add(other.direction,min(other.speed/3,3*timescale)) }
    }
    raddrop=0
    snd_play(sndEXPChest)
    repeat(4) scrNTTEFullTrenchFX(_x,_y,0,random(3),Smoke)
    _p=instance_create(_x,_y,ExploderExplo)
    with (_p) motion_add(other.direction,timescale)
    if (ntte_full_gold) {
        snd_play(sndEnergyHammerUpg,0.9,0.9)
        if (scrPlayerCountRace(Race.Fish)>0) scrNTTEFullUnlockSet("skin:angler fish",true)
    }
}

function scrNTTEFullTrenchColor(_family,_type) {
    ntte_full_type=_type
    spr_idle=scrNTTERefSprite(_family+"Idle",_type)
    spr_walk=spr_idle; spr_hurt=scrNTTERefSprite(_family+"Hurt",_type)
    spr_dead=scrNTTERefSprite(_family+"Dead",_type)
    if (_family=="Eel") ntte_full_tell=scrNTTERefSprite("EelTell",_type)
}

function scrNTTEFullEelConfigure() {
    var _type=irandom(2)
    if (scrCrownCheck(crwn_guns) && _type==0) _type=1
    if (scrCrownCheck(crwn_life) && _type==1) _type=0
    scrNTTEFullTrenchColor("Eel",_type)
    sprite_index=spr_idle; hitid=[spr_idle,"EEL"]
    max_hp=10; raddrop=2; meleedamage=2; size=1; mask_index=mskRat
    walk=0; ntte_full_walkspeed=1.2; ntte_full_maxspeed=3.4; direction=random(360)
    ntte_full_arc=noone; ntte_full_arcing=0; ntte_full_elite=0; ntte_full_wave=random(180)
    ntte_full_timers=[-1,15+random(45),-1,-1]; depth=-2
}

function scrNTTEFullEelAfterCreate() {
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=0
    snd_hurt=sndOasisHurt; snd_dead=sndOasisDeath; snd_mele=sndOasisMelee
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullEelDetach() {
    if (instance_exists(ntte_full_arc)) ntte_full_arc.ntte_full_arc_num=max(0,ntte_full_arc.ntte_full_arc_num-1)
    ntte_full_arc=noone; ntte_full_arcing=0
}

function scrNTTEFullEelDecision() {
    ntte_full_timers[1]=30+random(10); scrNTTEFullTrenchTarget()
    if (instance_exists(target) && ntte_full_distance<160) {
        if (!instance_exists(ntte_full_arc)) {
            var _best=noone,_dist=infinity
            with (NTTEFullJelly) {
                var _d=point_distance(x,y,other.x,other.y)
                if (team==other.team && ntte_full_arc_num<ntte_full_arc_max && _d<ntte_full_arc_dis
                    && _d<_dist && !collision_line(x,y,other.x,other.y,Wall,false,false)) {
                    _dist=_d; _best=id
                }
            }
            if (instance_exists(_best)) { ntte_full_arc=_best; ++_best.ntte_full_arc_num }
        }
    }
    else ntte_full_arcing=-1
    if (ntte_full_visible) scrNTTEFullTrenchWalk(ntte_full_direction+orandom(20),random_range(23,30))
    else scrNTTEFullTrenchWalk(direction+orandom(30),random_range(17,30))
    scrNTTEFullTrenchLook(direction)
    if (instance_exists(ntte_full_arc) && (ntte_full_arcing<1
        || point_distance(x,y,ntte_full_arc.x,ntte_full_arc.y)>ntte_full_arc.ntte_full_arc_dis-16))
        direction=point_direction(x,y,ntte_full_arc.x,ntte_full_arc.y)+orandom(10)
}

function scrNTTEFullEelStep() {
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) scrNTTEFullEelDecision()
    if (instance_exists(ntte_full_arc)) {
        var _a=ntte_full_arc,_d=point_distance(x,y,_a.x,_a.y)
        if (ntte_full_arcing>=0 && _d<_a.ntte_full_arc_dis
            && !collision_line(x,y,_a.x,_a.y,Wall,false,false)) {
            if (ntte_full_arcing<1) {
                ntte_full_arcing+=0.15*timescale
                if (random(1)<timescale) {
                    var _s=random(1)
                    scrNTTEFullTrenchFX(lerp(x,_a.x,_s),lerp(y,_a.y,_s),0,1,PortalL)
                }
                if (ntte_full_arcing>=1) {
                    snd_play(sndLightningHit,2)
                    if (_a.ntte_full_type<=2) scrNTTEFullTrenchColor("Eel",max(0,_a.ntte_full_type))
                }
            }
            else {
                ntte_full_wave+=timescale
                if (_a.ntte_full_type>2) ntte_full_elite=30
                with (_a) scrNTTEFullTrenchArc(other.x,other.y,x,y,16*sin(other.ntte_full_wave/180*2*pi),id)
            }
        }
        else scrNTTEFullEelDetach()
    }
    else { ntte_full_arc=noone; ntte_full_arcing=0 }
    if (ntte_full_elite>0) {
        ntte_full_elite-=timescale
        // The original uses the shared hurt/recoil timer (alarm11) for retaliation.
        if (alarm[11]>0 && ((alarm[11]+1) mod 15)<1 && current_frame_active) {
            var _dir=instance_exists(target) ? point_direction(x,y,target.x,target.y)+orandom(40):random(360)
            scrNTTEFullTrenchDischarge(x,y,_dir,2+random(2),true)
            walk=0
        }
        if (random(30)<timescale) instance_create(x,y,PortalL)
        if (ntte_full_elite<=0) { instance_create(x,y,PortalL); sprite_index=spr_hurt; image_index=0 }
    }
    if (walk>0) { walk-=timescale; speed+=ntte_full_walkspeed*timescale*timescale }
    speed=min(speed,ntte_full_maxspeed*timescale)
}

function scrNTTEFullEelDraw() {
    var _s=sprite_index
    if (ntte_full_elite>0) {
        if (_s==spr_idle) _s=scrNTTERefSprite("EeliteIdle")
        else if (_s==spr_walk) _s=scrNTTERefSprite("EeliteWalk")
        else if (_s==spr_hurt) _s=scrNTTERefSprite("EeliteHurt")
    }
    draw_sprite_ext(_s,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
}

function scrNTTEFullEelDeath() {
    scrNTTEFullEelDetach()
    if (hp>0) return;
    if (ntte_full_elite>0) {
        spr_dead=scrNTTERefSprite("EeliteDead")
        var _p=scr_projectile_create(x,y,NTTEFullLightningDisc,direction+180+orandom(15),6)
        _p.ntte_full_enemy=true; _p.ntte_full_maxspeed*=0.5
        _p.ntte_full_radius*=4/3; _p.ntte_full_charge*=0.5
        repeat(2) {
            _p=scr_projectile_create(x,y,NTTEFullTrenchLightning,random(360),0.5)
            _p.ntte_full_emit_delay=2+random(4); _p.ntte_full_emit_ammo=1+random(2)
            _p.image_speed*=random_range(0.75,1)
            instance_create(x,y,LightningHit)
        }
        snd_play(sndLightningCrystalDeath,1.5+random(0.5))
    }
    else if (ntte_full_type<2) {
        if (random(3)<2*scrNTTEFullPickupChanceMultiplier()) {
            var _confiscate=random(5)<scr_ultra_get(Race.Fish,UltraSkill.Confiscate)
            var _kind=ntte_full_type==0 ? (_confiscate ? AmmoChest:AmmoPickup):(_confiscate ? HealthChest:HPPickup)
            instance_create(x+orandom(2),y+orandom(2),_kind)
            if (_confiscate) instance_create(x,y,FishA)
            if (ntte_full_type==0) instance_create(x,y,FXChestOpen)
            else repeat(2) scrNTTEFullTrenchFX(x,y,4,random(1),AllyDamage)
        }
    }
    else {
        var _rad=instance_create(x,y,BigRad)
        with (_rad) { motion_add(other.direction,other.speed); motion_add(random(360),3*timescale); speed*=power(0.9,speed/max(0.001,timescale)) }
        repeat(2) {
            var _fx=scrNTTEFullTrenchFX(x,y,4,1,RadEat)
            _fx.sprite_index=sprEatBigRadPlut
        }
    }
}

// Original NTT ref_pickup_chance_multiplier (YYC 0x5DC620), recovered using
// the original variable-ID table and arithmetic helpers. NTT weighs each slot
// against missing health before averaging over players; Rabbit Paw is additive
// and Crown of Risk multiplies the completed result.
function scrNTTEFullPickupChanceMultiplier() {
    var _count=instance_number(Player),_paw=0.4*scr_skill_get(mut_rabbit_paw)
    if (_count<=0) return 1+_paw
    var _need=0,_healthy=0
    with (Player) {
        if (hp>=max_hp) _healthy+=1
        var _health=max_hp>0 ? hp/max_hp:0,_slots=[wep,bwep]
        for(var _i=0;_i<2;++_i) {
            var _weapon=_slots[_i],_ammo_need=0.5
            if (scr_weapon_is_valid(_weapon)) {
                var _type=scr_weapon_get_type(_weapon),_cap=scrAmmoGetTypeCapacity(_type)
                if (ammo[_type]<_cap*0.2) _ammo_need=0.8
                else if (ammo[_type]>_cap*0.6) _ammo_need=0.15
            }
            _need+=max(_ammo_need,_health>0 ? 0.4*(1-_health):0.6)
        }
    }
    var _risk=scrCrownCheck(Crown.Risk) ? lerp(0.5,1.5,_healthy/_count):1
    return _risk*(_need/_count+_paw)
}

function scrNTTEFullJellyConfigure(_elite=false) {
    var _type=_elite ? 3:irandom(2)
    if (scrCrownCheck(crwn_guns) && _type==0) _type=1
    if (scrCrownCheck(crwn_life) && _type==1) _type=0
    scrNTTEFullTrenchColor("Jelly",_type)
    spr_fire=scrNTTERefSprite(_elite ? "JellyEliteFire":"JellyFire")
    sprite_index=spr_idle; hitid=[spr_idle,"JELLY"]
    max_hp=42; raddrop=_elite ? 32:16; size=2; meleedamage=4; mask_index=mskLaserCrystal
    walk=0; ntte_full_walkspeed=1; ntte_full_maxspeed=3.4; direction=random(360)
    ntte_full_arc_num=0; ntte_full_arc_max=_elite ? 5:3; ntte_full_arc_dis=_elite ? 144:112
    ntte_full_timers=[-1,40+irandom(20),-1,-1]; depth=-2
}

function scrNTTEFullJellyAfterCreate() {
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=6
    snd_hurt=ntte_full_type>2 ? sndLightningCrystalHit:sndOasisHurt
    snd_dead=sndOasisDeath; snd_mele=sndOasisMelee
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullJellyDecision() {
    ntte_full_timers[1]=40+random(20)
    scrNTTEFullTrenchWalk(direction,ntte_full_timers[1])
    if (scrNTTEFullTrenchTarget() && ntte_full_visible) {
        motion_add(ntte_full_direction,0.4*timescale)
        if (random(3)<1 && ntte_full_distance>32 && ntte_full_distance<256) {
            ntte_full_timers[1]+=30
            var _count=ntte_full_type>2 ? 3:1
            for(var _i=0;_i<_count;++_i) {
                var _p=scr_projectile_create(x,y,NTTEFullLightningDisc,ntte_full_direction+_i*120,8)
                _p.ntte_full_enemy=true; _p.ntte_full_maxspeed*=4/5
                _p.ntte_full_radius*=4/3; _p.ntte_full_charge_speed*=0.7
                if (_count==3) _p.ntte_full_shrink/=2
            }
            snd_play_hit(sndLightningHit,0.25); snd_play(sndLightningCrystalCharge,0.8)
            sprite_index=spr_fire; image_index=0; ntte_full_timers[2]=30
        }
    }
    scrNTTEFullTrenchLook(direction)
}

function scrNTTEFullJellyStep() {
    var _due=scrNTTEFullTrenchClock()
    if (_due[1]) scrNTTEFullJellyDecision()
    if (_due[2]) sprite_index=spr_walk
    var _max=min(ntte_full_maxspeed,max(1,0.07*walk))*timescale
    if (walk>0) { walk-=timescale; speed+=ntte_full_walkspeed*timescale*timescale }
    speed=min(speed,_max)
    if (speed>0 && place_meeting(x+hspeed,y+vspeed,Wall)) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed=-hspeed
        if (place_meeting(x,y+vspeed,Wall)) vspeed=-vspeed
        scrNTTEFullTrenchLook(direction)
    }
}

function scrNTTEFullKelpConfigure() {
    spr_idle=scrNTTERefSprite("KelpIdle"); spr_hurt=scrNTTERefSprite("KelpHurt"); spr_dead=scrNTTERefSprite("KelpDead")
    sprite_index=spr_idle; max_hp=2; size=1; depth=-2
}

function scrNTTEFullKelpAfterCreate() {
    image_speed=random_range(0.2,0.3)*timescale; snd_hurt=sndOasisHurt; snd_dead=sndOasisDeath
}
