enum NTTEKind { Bubble, HyperBubble, Plasma, Disc, Bone, BoneArrow, Harpoon, Net, Portal, Red, Tunnel, Trident, Vlasma, Shank }
enum NTTESwingKind { Normal, Bubble, Energy, Bone, Clone }

function scrNTTEAttackCreate() {
    kind = NTTEKind.Bone
    big = false
    age = 0
    life = 120
    damage = 3
    typ = 1
    spr_fade = -1
    friction = 0
    state = undefined
    state_epoch = 0
    refund = 0
    refunded = false
    returning = false
    primary = true
    weapon = 0
    cursed = false
    throw_curse = 0
    target = noone
    tether = noone
    link = noone
    rope_length = 64
    rope_dynamic = false
    rope_timer = 60
    stick_x = 0
    stick_y = 0
    stuck = false
    hyper = false
    held = []
    hold_time = 12
    offset_angle = 0
    portal_group = undefined
    recent_targets = []
    recent_times = []
    burst_left = 0
    burst_delay = 0
    burst_creator = noone
    burst_primary = true
    z = 0
    safe_x = x
    safe_y = y
    direction_old = 0
    image_speed = 0.4 * timescale
    mask_index = mskEnemyBullet1
}

function scrNTTEConfigureAttack() {
    switch (kind) {
        case NTTEKind.Bubble:
            sprite_index = big ? sprNTTEBubbleBombBig:sprNTTEBubbleBomb
            mask_index = mskFlakBullet
            friction = 0.4 * timescale * timescale
            life = big ? 92:60
            damage = 3
            typ = 0 // bubble batting is handled explicitly below
            break
        case NTTEKind.HyperBubble:
            sprite_index = sprNTTEBubbleCharge
            life = 1
            damage = 12
            break
        case NTTEKind.Plasma:
            sprite_index = big ? sprNTTEElectroPlasmaBig:sprNTTEElectroPlasma
            mask_index = mskPlasma
            life = big ? 85:60
            damage = big ? 6:3
            typ = 2
            break
        case NTTEKind.Disc:
            sprite_index = big ? sprNTTEBatDiscBig:sprNTTEBatDisc
            mask_index = big ? mskPlasma:mskFlakBullet
            damage = big ? 8:2
            typ = 2
            life = 150
            image_speed = 0
            break
        case NTTEKind.Bone:
            sprite_index = sprNTTEBone
            damage = 34
            friction = timescale * timescale
            life = 600
            break
        case NTTEKind.BoneArrow:
            sprite_index = big ? sprNTTEBoneArrowHeavy:sprNTTEBoneArrow
            mask_index = mskBolt
            damage = big ? 32:14
            life = 60
            break
        case NTTEKind.Harpoon:
            sprite_index = sprNTTEHarpoon
            mask_index = mskBolt
            damage = 8
            life = 300
            break
        case NTTEKind.Net:
            sprite_index = sprNTTENetNade
            mask_index = mskFlakBullet
            damage = 0
            friction = 0.2*timescale*timescale
            life = 24
            break
        case NTTEKind.Portal:
            sprite_index = sprNTTEPortalBulletSpawn
            mask_index = mskPlasma
            damage = 25
            life = 90
            typ = 0
            break
        case NTTEKind.Red:
            sprite_index = sprNTTERedBullet
            mask_index = mskPlasma
            damage = 10000
            life = 40
            typ = 2
            break
        case NTTEKind.Tunnel:
            sprite_index = big ? sprNTTECrystalHeartBulletBig:sprNTTECrystalHeartBullet
            mask_index = mskPlasma
            damage = 24
            life = 36
            typ = 2
            break
        case NTTEKind.Trident:
            sprite_index = sprNTTETrident
            mask_index = mskBolt
            damage = 40
            life = 600
            break
        case NTTEKind.Vlasma:
            sprite_index = big ? sprNTTEVlasmaCannon:sprNTTEVlasmaBullet
            mask_index = mskPlasma
            damage = big ? 24:8
            life = 90
            typ = 2
            break
        case NTTEKind.Shank:
            sprite_index = sprNTTERedShank
            mask_index = sprNTTERedShank
            damage = 8
            life = 8
            typ = 0
            break
    }
    image_index = 0
    image_angle = direction
}

// Per-attack damage windows prevent a single overlap from hitting at 60/120 Hz.
function scrNTTEHurt(_t,_amount,_delay = 6,_push = 0) {
    if (!instance_exists(_t) || !scr_can_hit(_t,false)) return false
    var _slot = scrNTTEIndex(recent_targets,_t)
    if (_slot >= 0 && current_frame < recent_times[_slot]) return false
    if (_slot < 0) {
        _slot = array_length(recent_targets)
        array_push(recent_targets,_t)
        array_push(recent_times,0)
    }
    recent_times[_slot] = current_frame + _delay
    return scr_projectile_hit(_t,_amount,_push*timescale,
        point_direction(x,y,_t.x,_t.y))
}

function scrNTTEAttackStep() {
    if (lockstep_stop) return;
    age += timescale
    life -= timescale
    if (burst_left > 0) scrNTTEStartSalvo(id)
    if (kind == NTTEKind.HyperBubble) {
        scrNTTEHyperRay()
        instance_destroy()
        return;
    }
    if (kind == NTTEKind.Portal && age < hold_time && instance_exists(creator)) {
        direction = creator.gunangle + offset_angle
        x = creator.x + lengthdir_x(12,direction) - hspeed
        y = creator.y + lengthdir_y(12,direction) - (primary ? 0:4) - vspeed
        image_angle = direction
        safe_x = creator.x
        safe_y = creator.y
        return;
    }
    if (kind == NTTEKind.Portal) {
        sprite_index = sprNTTEPortalBullet
        typ = 1
        if (!place_meeting(x,y,Wall) && position_meeting(x,y,Floor)) {
            safe_x = x
            safe_y = y
        }
    }
    if (kind == NTTEKind.Bubble) {
        z = min(30, max(0, (age-12)*0.35))
        if (current_frame_active && big && (floor(age) mod 20)==0) {
            var _child = scrNTTEShot(NTTEKind.Bubble,random(360),3)
            _child.life = 30
        }
    }
    if (kind == NTTEKind.Plasma) {
        if (hyper) {
            speed = 0
            if (!instance_exists(creator)) { instance_destroy(); return; }
            x = creator.x
            y = creator.y
            direction = creator.gunangle
            move_contact_solid(direction,480)
        }
        if (current_frame_active && big && (floor(age) mod 15)==0) {
            var _prev = id
            for(var _i=0;_i<3;++_i) {
                var _p = scrNTTEShot(NTTEKind.Plasma,direction+(_i-1)*40,4)
                _p.life = 30
                _p.tether = _prev
                _prev = _p
            }
        }
        if (instance_exists(tether) && point_distance(x,y,tether.x,tether.y) < (hyper ? 1200:120)) {
            if (current_frame_active && (floor(age) mod 5)==0)
                scrNTTELineDamage(x,y,tether.x,tether.y,3,7+3*scr_skill_get(mut_laser_brain),5)
        }
    }
    if (kind == NTTEKind.Disc) {
        image_angle += 24 * timescale
        if (age > 18 || speed < 3*timescale) returning = true
        if (!returning && scr_skill_get(mut_bolt_marrow)) {
            var _t = scrNTTENearestHostile(x,y,96)
            if (instance_exists(_t)) direction = angle_lerp(direction,point_direction(x,y,_t.x,_t.y),0.12*timescale)
        }
        if (returning) {
            image_index = 1
            if (!instance_exists(creator)) { instance_destroy(); return; }
            direction = angle_lerp(direction,point_direction(x,y,creator.x,creator.y),min(1,0.4*timescale))
            speed = min(12*timescale,speed+timescale*timescale)
            if (point_distance(x,y,creator.x,creator.y)<14) {
                scrNTTERefund()
                instance_destroy()
                return;
            }
        }
        else speed = max(3*timescale,speed-0.3*timescale*timescale)
    }
    if (kind == NTTEKind.BoneArrow || kind == NTTEKind.Trident || kind == NTTEKind.Vlasma) {
        if (!stuck && (scr_skill_get(mut_bolt_marrow) || kind == NTTEKind.Vlasma)) {
            if (!instance_exists(target)) target = scrNTTENearestHostile(x,y,192)
            if (instance_exists(target)) direction = angle_lerp(direction,point_direction(x,y,target.x,target.y),0.1*timescale)
        }
    }
    if (kind == NTTEKind.Harpoon || kind == NTTEKind.Trident || kind == NTTEKind.Bone) {
        if (stuck || (kind == NTTEKind.Bone && speed < timescale)) {
            if (scrNTTEBoneBreak()) return;
            speed = 0
            if (instance_exists(target) && target.hp > 0) {
                x = target.x + stick_x
                y = target.y + stick_y
            }
            else { target = noone; stuck = true }
            if (scrNTTEThrowLand()) return;
            if (instance_exists(creator) && age > 10 && point_distance(x,y,creator.x,creator.y)<18) {
                if (kind == NTTEKind.Harpoon) with (creator) scrPlayerGiveAmmo(id,Ammo.Bolts,1,true)
                else scrNTTERefund()
                instance_destroy()
                return;
            }
            if (cursed && !scrNTTEIsGroundWeapon(weapon) && instance_exists(creator) && age > 30) {
                x = lerp(x,creator.x,0.2*timescale)
                y = lerp(y,creator.y,0.2*timescale)
                target = noone
            }
        }
        if (kind == NTTEKind.Trident && age > 15 && !stuck) {
            speed = max(0,speed-0.6*timescale*timescale)
            if (speed < timescale) stuck = true
        }
        if (kind == NTTEKind.Harpoon && instance_exists(link)) scrNTTERopeStep()
    }
    if (kind == NTTEKind.Tunnel) {
        scrNTTEClearWalls(x,y,18)
        if (current_frame_active) instance_create(x,y,PortalL)
    }
    if (kind != NTTEKind.Disc && kind != NTTEKind.Bone) image_angle = direction
    if (kind == NTTEKind.Bone && !stuck) image_angle += speed * timescale * 15
    if (life <= 0) scrNTTEAttackExpire()
}

function scrNTTEAttackEndStep() {
    if (lockstep_stop || kind != NTTEKind.Bubble) return;
    for(var _i=array_length(held)-1;_i>=0;--_i) {
        var _h = held[_i]
        if (!instance_exists(_h.inst)) { array_delete(held,_i,1); continue }
        with (_h.inst) {
            x = other.x
            y = other.y - other.z
            speed = 0
        }
    }
}

function scrNTTEAttackHit(_t) {
    if (lockstep_stop || !instance_exists(_t) || !scr_can_hit(_t,false)) return;
    switch (kind) {
        case NTTEKind.Bubble:
            if (z<24 && (array_length(held)==0 || big) && instance_is(_t,enemy)
                && _t.size <= (big ? 3:0)
                && (!variable_instance_exists(_t,"ntte_bubble") || !instance_exists(_t.ntte_bubble))) {
                array_push(held,{inst:_t,hs:_t.hspeed,vs:_t.vspeed})
                _t.ntte_bubble = id
            }
            break
        case NTTEKind.Portal:
            if (age<hold_time) return;
            if (is_struct(portal_group) && portal_group.used) { instance_destroy(); return; }
            if (scrNTTEHurt(_t,damage,10,0)) {
                if (instance_exists(creator) && instance_exists(_t) && _t.hp>0 && !instance_is(_t,prop)) {
                    var _ox = creator.x, _oy = creator.y
                    if (scrNTTETeleport(creator,_t.x,_t.y)) scrNTTETeleport(_t,_ox,_oy)
                    if (is_struct(portal_group)) portal_group.used = true
                }
                scrNTTEPortalFinish()
                instance_destroy()
            }
            break
        case NTTEKind.Harpoon:
        case NTTEKind.Trident:
            if (!stuck && scrNTTEHurt(_t,damage,10,kind==NTTEKind.Harpoon ? 8:5)) {
                stuck = true
                speed = 0
                target = _t
                stick_x = x-_t.x
                stick_y = y-_t.y
            }
            break
        case NTTEKind.Bone:
            if (!stuck && scrNTTEHurt(_t,damage,10,8)) {
                if (weapon>=wep_ntte_ancient_artifact) scrNTTEArtifactImpact(_t)
                if (scrNTTEBoneBreak()) return;
                speed = 0
                stuck = true
            }
            break
        case NTTEKind.Net:
            target = _t
            scrNTTEAttackExpire()
            break
        case NTTEKind.Red:
            if (scrNTTEHurt(_t,damage,10)) {
                if (instance_is(_t,prop)) scrNTTEAreaDamage(x,y,32,24)
                scrNTTEFX(sprNTTERedBulletDisappear,x,y)
                instance_destroy()
            }
            break
        case NTTEKind.Plasma:
            if (current_frame_active && scrNTTEHurt(_t,damage,3,3)) {
                if (!hyper) life -= big ? 2:5
                speed *= 0.9
            }
            break
        case NTTEKind.Disc:
            if (current_frame_active && scrNTTEHurt(_t,damage,1,2)) {
                speed *= 0.9
                if (big) scrNTTEClearWalls(x,y,16)
            }
            break
        case NTTEKind.BoneArrow:
            if (scrNTTEHurt(_t,damage,10,8)) {
                if (big) {
                    for(var _a=-2;_a<=2;++_a) {
                        var _p = scrNTTEShot(NTTEKind.BoneArrow,direction+_a*15,12)
                        _p.damage = 4
                        _p.life = 10
                    }
                }
                instance_destroy()
            }
            break
        case NTTEKind.Vlasma:
            if (scrNTTEHurt(_t,damage,10,4)) {
                scrNTTEAreaDamage(x,y,big ? 28:12,damage)
                scrNTTEFX(sprNTTEElectroPlasmaImpact,x,y)
                instance_destroy()
            }
            break
        default: scrNTTEHurt(_t,damage,6,4)
    }
}

function scrNTTEAttackWall(_wall) {
    if (lockstep_stop) return;
    if (kind == NTTEKind.Portal && age < hold_time) return;
    if (kind == NTTEKind.Tunnel) {
        if (!instance_is(_wall,InvisiWall)) scrWallDestroy(_wall)
        else scrNTTEAttackExpire()
        return;
    }
    if (kind == NTTEKind.Disc) {
        if (big && !instance_is(_wall,InvisiWall)) scrWallDestroy(_wall)
        else {
            if (place_meeting(x+hspeed,y,Wall)) hspeed = -hspeed
            if (place_meeting(x,y+vspeed,Wall)) vspeed = -vspeed
            returning = true
        }
        return;
    }
    if (kind == NTTEKind.Bubble || kind == NTTEKind.Net) {
        if (place_meeting(x+hspeed,y,Wall)) hspeed = -hspeed*0.6
        if (place_meeting(x,y+vspeed,Wall)) vspeed = -vspeed*0.6
        return;
    }
    if (kind == NTTEKind.Harpoon || kind == NTTEKind.Trident || kind == NTTEKind.Bone) {
        x -= hspeed
        y -= vspeed
        if (scrNTTEBoneBreak()) return;
        speed = 0
        stuck = true
        return;
    }
    if (kind == NTTEKind.Plasma && hyper) return;
    scrNTTEAttackExpire()
}

function scrNTTEAttackProjectile(_p) {
    if (lockstep_stop || !instance_exists(_p) || kind!=NTTEKind.Bubble || _p==id) return;
    if (instance_is(_p,Slash)) {
        direction = _p.direction
        speed = 10*timescale
        team = _p.team
        return;
    }
    if (_p.team == team || _p.typ==0 || instance_is(_p,NTTEAttack)) return;
    if (instance_is(_p,Flame) || instance_is(_p,Bolt)) { scrNTTEAttackExpire(); return; }
    if (array_length(held)==0 || big) {
        if (variable_instance_exists(_p,"ntte_bubble") && instance_exists(_p.ntte_bubble)) return;
        array_push(held,{inst:_p,hs:_p.hspeed,vs:_p.vspeed})
        _p.ntte_bubble = id
        _p.speed = 0
    }
}

function scrNTTERefund() {
    if (refunded) return;
    refunded = true
    scrNTTEReturn(state,refund,state_epoch)
}

function scrNTTEAttackCleanup() {
    // Cleanup never fires explosions, teleports or area generation.
    scrNTTERefund()
    for(var _i=0;_i<array_length(held);++_i) {
        var _h = held[_i]
        if (instance_exists(_h.inst)) with (_h.inst) {
            if (ntte_bubble == other.id) {
                ntte_bubble = noone
                hspeed = _h.hs
                vspeed = _h.vs
            }
        }
    }
    held = []
}

function scrNTTEAttackExpire() {
    if (scrNTTEBoneBreak()) return;
    if (scrNTTEThrowLand()) return;
    switch (kind) {
        case NTTEKind.Bubble:
            scrNTTEAreaDamage(x,y-z,big ? 40:24,damage)
            scrNTTEFX(sprNTTEBubbleExplosion,x,y-z,big ? 1.5:1)
            snd_play(sndOasisExplosionSmall)
            break
        case NTTEKind.Net:
            scrNTTENetExplode()
            break
        case NTTEKind.Portal: scrNTTEPortalFinish(); break
        case NTTEKind.Tunnel: scrNTTETunnelGenerate(); break
        case NTTEKind.Plasma:
            scrNTTEFX(sprNTTEElectroPlasmaImpact,x,y)
            scrNTTEAreaDamage(x,y,big ? 24:12,big ? 12:3)
            break
        case NTTEKind.Vlasma: scrNTTEAreaDamage(x,y,big ? 32:16,damage); break
    }
    instance_destroy()
}
