// NTTE 2.062 tesewers Cat/CatHole: sewer variant, native enemy integration.
function scrNTTECatCreate() {
    max_hp=10; raddrop=6; size=1; meleedamage=0
    spr_idle=sprNTTECatIdle; spr_walk=sprNTTECatWalk
    spr_hurt=sprNTTECatHurt; spr_dead=sprNTTECatDead
    spr_weap=sprNTTECatToxer; mask_index=mskRat; sprite_index=spr_idle
    hitid=[spr_idle,"CAT"]; walk=0; depth=-2
    ntte_cat_ammo=0; ntte_cat_active=true; ntte_cat_cantravel=false
    ntte_cat_sit=noone; ntte_cat_groundsit=false; ntte_cat_sitting_sprite=-1
    ntte_cat_timer=40+irandom(20); ntte_cat_loop=-1
    ntte_cat_shots=0; ntte_cat_hidden_age=0; ntte_cat_last_x=x; ntte_cat_last_y=y
}

function scrNTTECatAfterCreate() {
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=0
    snd_hurt=sndGatorHit; snd_dead=sndSalamanderDead
    alarm[1]=-1; alarm[2]=-1
    gunangle=random(360); direction=gunangle
    var _seats=[]
    with (chestprop) if (place_meeting(x,y,Floor) && !collision_line(x,y,other.x,other.y,Wall,false,false)) array_push(_seats,id)
    if (array_length(_seats)) {
        var _seat=_seats[irandom(array_length(_seats)-1)],_occupied=false
        with (NTTECat) if (id!=other.id && ntte_cat_sit==_seat) _occupied=true
        if (!_occupied) ntte_cat_sit=_seat
    }
}

function scrNTTECatStopLoop() {
    if (ntte_cat_loop>=0) audio_stop_sound(ntte_cat_loop)
    ntte_cat_loop=-1
}

function scrNTTECatStand() {
    ntte_cat_sit=noone; ntte_cat_groundsit=false; ntte_cat_sitting_sprite=-1
}

function scrNTTECatReserveHole(_hidden) {
    var _best=noone,_distance=infinity
    with (NTTECatHole) if (image_index==0 && !instance_exists(target)) {
        if(!scrNTTECatHoleEnsure()) continue;
        var _d=point_distance(x,y,other.x,other.y)
        if (_hidden) {
            if (instance_exists(other.target)) _d=point_distance(x,y,other.target.x,other.target.y)
            if (_d>140) continue
        }
        if (_d<_distance) { _distance=_d; _best=id }
    }
    if (!instance_exists(_best)) return false
    if (!_hidden && _distance>=48) {
        scrNTTESewerWalk(point_direction(x,y,_best.x,_best.y),random_range(20,40))
        scrNTTESewerLook(direction)
        return true
    }
    _best.target=id; _best.image_index=1; _best.image_speed=0.4*timescale
    ntte_cat_timer+=45
    return true
}

function scrNTTECatSpray() {
    var _x=x,_y=y
    if (instance_exists(ntte_cat_sit) && instance_is(ntte_cat_sit,enemy)) {
        _x=ntte_cat_sit.x; _y=ntte_cat_sit.bbox_top
    }
    else scrNTTECatStand()
    repeat(2) {
        var _p=scr_projectile_create(_x,_y,NTTECatGas,gunangle+orandom(6),4)
        _p.friction=0.12*timescale*timescale
        // Original ground spray is neutral. Charmed cats retain their friendly
        // faction to avoid poisoning the player who created the ally.
        if (!instance_exists(ntte_cat_sit) && team!=team_player) _p.team=team_none
    }
    gunangle+=12; ++ntte_cat_shots
    ntte_cat_timer=2
    if (--ntte_cat_ammo<=0) {
        ntte_cat_timer=40; scrNTTECatStopLoop(); wkick+=6
        repeat(3) {
            var _fx=instance_create(_x,_y,AcidStreak)
            with (_fx) motion_set(other.gunangle+orandom(16),3*timescale)
        }
        snd_play(sndEmpty,random_range(0.75,0.9))
    }
    else ++wkick
}

function scrNTTECatDecision() {
    ntte_cat_timer=20+irandom(20)
    if (ntte_cat_ammo>0) { scrNTTECatSpray(); return; }
    scrTarget()
    if (!ntte_cat_active) {
        ntte_cat_timer=40+random(40)
        if (!scrNTTECatReserveHole(true) && instance_number(NTTECatHole)==0) scrNTTECatEmerge(ntte_cat_last_x,ntte_cat_last_y)
        return;
    }
    var _exists=instance_exists(target),_seen=_exists && scrTargetIsVisible(target),
        _distance=_exists ? point_distance(x,y,target.x,target.y):infinity,
        _sitting=ntte_cat_groundsit || instance_exists(ntte_cat_sit)
    if ((!ntte_cat_cantravel || _sitting) && (hp<max_hp || (_distance<128 && (_seen || (variable_instance_exists(target,"reload") && target.reload>0 && _distance<96))))) {
        ntte_cat_cantravel=true
        if (!instance_exists(ntte_cat_sit) || !instance_is(ntte_cat_sit,enemy)) {
            if (_sitting) scrNTTEFX(sprAssassinNotice,x,y)
            scrNTTECatStand(); _sitting=false
        }
    }
    if (!_sitting || (instance_exists(ntte_cat_sit) && instance_is(ntte_cat_sit,enemy)) || random(12)<1) {
        if (!instance_exists(ntte_cat_sit) || !instance_is(ntte_cat_sit,enemy)) scrNTTECatStand()
        if (_seen) {
            scrNTTESewerLook(point_direction(x,y,target.x,target.y))
            if (_distance<140 && random(3)<1) {
                ntte_cat_timer=4; ntte_cat_ammo=10; gunangle-=45; wkick+=4
                var _fx=instance_create(x+lengthdir_x(8,gunangle),y+lengthdir_y(8,gunangle),AcidStreak)
                _fx.sprite_index=sprNTTEAcidPuff; _fx.image_angle=gunangle
                snd_play(sndToxicBoltGas); snd_play(sndEmpty)
                scrNTTECatStopLoop(); ntte_cat_loop=audio_play_sound(sndFlamerLoop,0,true)
            }
            else scrNTTESewerWalk(gunangle+orandom(20),random_range(20,25))
        }
        else if (ntte_cat_cantravel && random(4)<3) scrNTTECatReserveHole(false)
        else if ((_exists && ntte_cat_cantravel) || random(4)<3) {
            ntte_cat_timer=30+irandom(20)
            scrNTTESewerWalk(choose(random(360),direction+orandom(30)),random_range(20,30))
            scrNTTESewerLook(direction)
        }
        else ntte_cat_groundsit=true
    }
}

function scrNTTECatHide() {
    ntte_cat_last_x=x; ntte_cat_last_y=y
    ntte_cat_active=false; visible=false; mask_index=mskNone
    speed=0; walk=0; ntte_cat_hidden_age=0; ntte_cat_timer=40+random(40)
    scrNTTECatStopLoop(); scrNTTECatStand()
}

function scrNTTECatEmerge(_x,_y) {
    var _oldmask=mask_index;
    mask_index=mskRat;
    if(!scrNTTECatGroundPlace(_x,_y)) {mask_index=_oldmask;return false;}
    xprevious=x;yprevious=y;
    ntte_cat_active=true; visible=true
    ntte_cat_timer=15+random(30); ntte_cat_hidden_age=0
    scrTarget()
    scrNTTESewerLook(instance_exists(target) ? point_direction(x,y,target.x,target.y)+orandom(50):random(360))
    scrNTTESewerWalk(gunangle,random_range(4,8))
    scrNTTEDesertBudge(id)
    snd_play(sndFireballerHurt,1.4)
    repeat(4) instance_create(x+orandom(4),y+orandom(4),Dust)
    return true;
}

function scrNTTECatStep() {
    if (lockstep_stop || hp<=0) return;
    if (!ntte_cat_active) {
        visible=false; speed=0; walk=0; ntte_cat_hidden_age+=timescale
        // Never strand the last hostile if all covers were structurally removed.
        if (instance_number(NTTECatHole)==0 || ntte_cat_hidden_age>=240) scrNTTECatEmerge(ntte_cat_last_x,ntte_cat_last_y)
    }
    else {
        var _sit=instance_exists(ntte_cat_sit)
        if (ntte_cat_sit!=noone && !_sit) scrNTTECatStand()
        if (_sit || ntte_cat_groundsit) {
            walk=0; speed=0
            if (_sit) {
                if(!scrNTTEFullCityCatEnemySeatStep()) {
                    if(instance_exists(ntte_cat_sit)) {
                        x=ntte_cat_sit.x; y=ntte_cat_sit.y-5
                        xprevious=x; yprevious=y+1; right=-ntte_cat_sit.image_xscale
                    }
                }
            }
            if (ntte_cat_sitting_sprite<0) { ntte_cat_sitting_sprite=_sit ? sprNTTECatGoSit:sprNTTECatGoSitSide; image_index=0 }
            sprite_index=ntte_cat_sitting_sprite
        }
        else {
            if (walk>0) { walk-=timescale; motion_add(direction,0.8*timescale*timescale) }
            speed=min(speed,3*timescale)
        }
    }
    ntte_cat_timer-=timescale
    if (ntte_cat_timer<=0) scrNTTECatDecision()
}

function scrNTTECatBlocksHit(_victim,_attacker) {
    if (!instance_is(_victim,NTTECat)) return false
    if (!_victim.ntte_cat_active) return true
    if (instance_exists(_attacker) && instance_is(_attacker,ToxicGas)) return true
    with (_victim) if (!instance_exists(ntte_cat_sit) || !instance_is(ntte_cat_sit,enemy)) scrNTTECatStand()
    return false
}

function scrNTTECatDraw() {
    if (lockstep_stop || !ntte_cat_active) return;
    if(scrNTTEFullCityCatEnemySeatDraw()) return;
    if (ntte_cat_groundsit || instance_exists(ntte_cat_sit)) {
        draw_sprite_ext(sprite_index,image_index,x,y+2,right,1,0,image_blend,image_alpha)
        return;
    }
    if (gunangle>180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
    draw_sprite_ext(spr_weap,0,x+lengthdir_x(-wkick,gunangle),y+lengthdir_y(-wkick,gunangle),1,right,gunangle,image_blend,image_alpha)
    if (gunangle<=180) draw_sprite_ext(sprite_index,image_index,x,y,right,1,0,image_blend,image_alpha)
}

function scrNTTECatHoleStep() {
    if(lockstep_stop) return;
    // Initial validation waits for the actual walls. Reservation and opening
    // recheck too, since a same-room secret area can add walls later.
    if(!ntte_cat_ground_checked && !instance_exists(GenCont)) {
        scrNTTECatHoleEnsure();ntte_cat_ground_checked=true;
    }
    if(image_index<=0) return;
    if(!scrNTTECatHoleEnsure()) {
        target=noone;image_index=0;image_speed=0;ntte_cat_closing=false;
        if(instance_exists(hole)) instance_destroy(hole,false);
        hole=noone;return;
    }
    if (image_speed==0) image_speed=0.4*timescale
    if (image_index<2+image_speed && place_meeting(x,y,Player)) {
        image_index=6
        with (Player) if (place_meeting(x,y,other.id)) motion_add(point_direction(other.x,other.y,x,y),2*timescale)
    }
    if (image_index<6) {
        depth=-6
        if (!instance_exists(hole)) {
            hole=instance_create(x,y,NTTEDesertDecor)
            hole.sprite_index=sprNTTEManholeOpen; hole.depth=5
        }
        if (instance_exists(target)) {
            if (!target.ntte_cat_active) {
                var _emerged=false;
                with(target) _emerged=scrNTTECatEmerge(other.x,other.y);
                if(_emerged) target=noone
            }
            else with (target) {
                if (point_distance(x,y,other.x,other.y-4)>5) {
                    motion_add(point_direction(x,y,other.x,other.y-4),timescale*timescale)
                    scrNTTESewerLook(direction)
                }
            }
        }
    }
    else if (!ntte_cat_closing) {
        ntte_cat_closing=true; depth=5
        if (instance_exists(hole)) instance_destroy(hole,false)
        hole=noone
        if (instance_exists(target)) {
            if (place_meeting(x,y,target)) {
                with (target) scrNTTECatHide()
                repeat(5) {
                    var _d=instance_create(x,y,Dust)
                    with (_d) motion_set(random(360),random_range(3,4)*timescale)
                }
            }
            target=noone
        }
        scr_screenshake(10); instance_create(x,y,ImpactWrists); snd_play(sndHitMetal,random_range(0.5,0.7))
    }
}
