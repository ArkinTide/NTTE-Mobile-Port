// teoasis.mod.gml328..645; native-slash-grenade.txt recovered 9940 events.
// Complete physical BubbleBomb lifecycle. Root installs instead of base library.
function scrNTTEFullBubbleBombCreate() {
    sprite_index=scrNTTERefSprite("BubbleBomb"); image_speed=0.5*timescale; depth=-4
    mask_index=object_get_mask(SuperFlakBullet); friction=0.4*timescale*timescale
    damage=3; knockback_speed=2*timescale; typ=1; z=0; zspeed=-0.5; zfriction=-0.02; big=0; held=[]; ntte_bubble_setup=true
    // NTT CustomProjectile supplies this baseline; Epsilon projectile does not.
    deflected=false
    temerge_on_fire=scrNTTEFullBubbleBombMergeFire; temerge_on_setup=scrNTTEFullBubbleBombMergeSetup
    projectile_direction_changes_angle=false
}
function scrNTTEFullBubbleBombSetup() {
    ntte_bubble_setup=false
    if (big>0) { sprite_index=scrNTTERefSprite("BubbleBombBig"); mask_index=mskExploder }
    else if (team==team_enemy) sprite_index=scrNTTERefSprite("BubbleBombEnemy")
}
function scrNTTEFullBubbleBombMergeFire(_at,_setup_info) { _setup_info.is_big=big }
function scrNTTEFullBubbleBombMergeSetup(_instances,_info) {
    if (!variable_global_exists("ntte_full_projectile_merge_effect") || !is_callable(global.ntte_full_projectile_merge_effect)) throw "BubbleBomb requires original merged projectile effect provider"
    var _provider=global.ntte_full_projectile_merge_effect
    _provider(_instances,"explosion",[{is_bubble:true},_info.is_big ? 3:1])
}
function scrNTTEFullBubbleBombReverseMotion() {
    // telib6348 motion_step(self,-1), reverse raw/native movement: restore
    // gravity and friction too, not merely current frame x/y displacement.
    if(speed!=0) {y-=vspeed;x-=hspeed}
    if(gravity!=0) {vspeed-=lengthdir_y(gravity,gravity_direction);hspeed-=lengthdir_x(gravity,gravity_direction)}
    if(friction!=0 && speed!=0) speed-=min(abs(speed),-friction)*sign(speed)
}
function scrNTTEFullBubbleBombStep() {
    if (lockstep_stop) return;
    z+=zspeed*timescale; zspeed-=zfriction*timescale
    if (z>8 && depth>-6) depth=-8
    image_angle+=sin(current_frame/8)*10*timescale
    if (speed==0 && random(12)<timescale) {
        if (random(2)<1) { var _off=image_index/3; instance_create(x+orandom(_off),y+orandom(_off),PortalL) }
        with (instance_create(x,y-z,BulletHit)) sprite_index=scrNTTERefSprite("BubbleCharge")
    }
    if (big>0 && z<24 && image_index>=6 && random(5+max(z,0))<big*timescale)
        with (scrNTTEFullMergedBasicProjectileCreate(x+orandom(8),y-z-8+orandom(8),NTTEFullBubbleBomb)) image_speed*=random_range(0.8,1)
    var _held=[],_cx=x,_cy=y-z,_num=0
    for(var _i=0;_i<array_length(held);++_i) if (instance_exists(held[_i])) {
        var _v=held[_i]; array_push(_held,_v)
        if (instance_is(_v,hitme)) { x+=_v.hspeed*_v.size/6; y+=_v.vspeed*_v.size/6 }
        with (_v) {
            if (other.big<=0) { x=_cx; y=_cy }
            else {
                var _dis=2+(_num*123)%8,_dir=current_frame/(10+speed/max(timescale,0.000001))+direction,
                    _fac=instance_is(id,hitme) ? max(0.3-_num*0.05,0.1):0.5
                _fac=1-power(1-_fac,timescale)
                x+=(_cx+_dis*cos(_dir)-x)*_fac; y+=(_cy+_dis*sin(_dir)-y)*_fac; _num++
            }
            scrNTTEFullBubbleBombReverseMotion()
        }
    }
    held=_held
}
function scrNTTEFullBubbleBombIsSlash(_v) {
    // Source instances_matching(object_index): exact original identities,
    // including explicit ports of CustomSlash, never arbitrary descendants.
    switch(_v.object_index) {
        case Slash:case BloodSlash:case EnergySlash:case EnergyHammerSlash:case LightningSlash:
        case NTTEFullClamShieldSlash:case NTTEFullBoneSlash:case NTTEFullEnergyBatSlash:
        case NTTEFullBubbleSlash:case NTTEFullRedSlash:case NTTEFullEntanglerSlash:
        case NTTEFullClamShield:case NTTEFullPalankingSlash:case NTTEFullPalankingSlashGround:
        case NTTEFullSealAnchor:case NTTEBatScreech:case NTTEFullHyperSlashTrail:return true
    }
    return false
}
function scrNTTEFullBubbleBombTouch(_target) {
    if(!instance_exists(_target) || !place_meeting(x,y,_target)) return false
    var _self=id,_touch=false
    with(_target) _touch=place_meeting(x,y,_self)
    return _touch
}
function scrNTTEFullBubbleBombGrenadeEvent(_slash,_bomb) {
    if(scrNTTEFullFriendlyMonsterShot(_slash,_bomb)) return;
    if(!instance_exists(_slash) || !instance_exists(_bomb)) return;
    // HyperSlashTrail owns a genuine on_grenade callback forwarding collision
    // from the nearest point to its target; preserve those exact coordinates.
    if(_slash.object_index==NTTEFullHyperSlashTrail) {
        var _target=_slash.target
        if(!instance_exists(_target)) return;
        var _angle=_slash.image_angle,
            _length=clamp(lengthdir_x(_bomb.x-_slash.xstart,_angle)+lengthdir_y(_bomb.y-_slash.ystart,_angle),
                0,point_distance(_slash.xstart,_slash.ystart,_target.x,_target.y)),
            _x=_slash.xstart+lengthdir_x(_length,_angle),_y=_slash.ystart+lengthdir_y(_length,_angle),
            _last_x=_target.x,_last_y=_target.y
        _target.xprevious+=_x-_target.x;_target.yprevious+=_y-_target.y;_target.x=_x;_target.y=_y
        scrNTTEFullBubbleBombGrenadeEvent(_target,_bomb)
        if(instance_exists(_target)) {_target.x=_last_x;_target.y=_last_y;_target.xprevious=_last_x;_target.yprevious=_last_y}
        if(instance_exists(_slash)) with(_slash) scrNTTEFullHyperSlashStep()
        return;
    }
    // CustomSlash.on_grenade overrides its baseline independently of its
    // on_projectile. RedSlash clone only overrides projectile, never grenade.
    var _native=_slash.object_index==Slash || _slash.object_index==BloodSlash || _slash.object_index==EnergySlash
        || _slash.object_index==EnergyHammerSlash || _slash.object_index==LightningSlash,
        _handler=scrNTTEFullValue(_slash,"on_grenade",undefined)
    if(!_native && is_callable(_handler)) {
        with(_bomb) with(_slash) _handler()
        return;
    }
    if(!_native && !scrNTTEFullValue(_slash,"candeflect",true)) {
        with(_bomb) {instance_destroy();sleep(40);scrNTTEFullTrenchShake(x,y,3)}
        return;
    }
    // Recovered original Slash/CustomSlash Collision220. This is not generic
    // projectile collision: no team gate, shank destroy or typ2 branch.
    with(_bomb) {
        // All six exact native Slash/Guitar/Blood/Energy/Hammer/Lightning
        // events set deflected; Guitar sets it later in its event body.
        deflected=true;direction=_slash.direction;speed=12*timescale
        friction=0.1*timescale*timescale;alarm[1]=6;sleep(10);scrNTTEFullTrenchShake(x,y,3)
        var _fx=instance_create(x,y,Deflect);_fx.image_angle=_slash.direction
    }
}
function scrNTTEFullBubbleBombBaseball(_slash) {
    var _old_speed=speed,_old_friction=friction,_old_alarm=alarm[1],_self=id
    scrNTTEFullBubbleBombGrenadeEvent(_slash,id)
    if(!instance_exists(_self)) return false
    alarm[1]=_old_alarm;friction=_old_friction
    if(speed!=_old_speed) {
        speed=_old_speed
        if(speed<8*timescale) {
            speed=max(0,10-4*((array_length(held)>0)-1+big))*timescale
            snd_play(sndBouncerBounce,(big>0?0.5:0.8)+random(0.1),3)
        }
    }
    return true
}
function scrNTTEFullBubbleBombGrab(_target) {
    if (!instance_exists(_target) || !scrNTTEFullBubbleBombTouch(_target) || z>=24 || (array_length(held)>0 && big<=0) || scrNTTEFullValue(_target,"bubble_bombed",false)) return false
    if (big>0 && _target.team==team) return false
    if (variable_instance_exists(_target,"size") && _target.size-(_target.object_index==DogGuardian)>3*big) return false
    if (instance_is(_target,projectile) && (_target.typ==0 || instance_is(_target,NTTEFullBubbleBomb))) return false
    _target.bubble_bombed=true; array_push(held,_target)
    if (big<=0) {
        x=lerp(x,_target.x,0.5); y=lerp(y,_target.y,0.5); friction=max(0.3*timescale*timescale,friction)
        scrNTTEFullNativeMotionAddFT(id,_target.direction,_target.speed/timescale/2)
    }
    if (instance_is(_target,hitme)) speed*=0.8
    instance_create(x,y,Dust); repeat(4) instance_create(x,y,Bubble); snd_play(sndOasisHurt)
    return true
}
function scrNTTEFullBubbleBombEndStep() {
    if (lockstep_stop) return;
    if (ntte_bubble_setup) scrNTTEFullBubbleBombSetup()
    y-=z
    var _self=id
    with (Player) if (place_meeting(x,y,_self)) with (_self) motion_add(point_direction(other.x,other.y,x,y),1.5*timescale*timescale)
    var _meeting=[],_all=scrNTTEFullInstances([enemy,projectile])
    for(var _i=0;_i<array_length(_all);++_i) if (_all[_i]!=id && place_meeting(x,y,_all[_i])) array_push(_meeting,_all[_i])
    for(var _i=0;_i<array_length(_meeting);++_i) {
        var _v=_meeting[_i]
        if (instance_exists(_v) && scrNTTEFullBubbleBombIsSlash(_v) && scrNTTEFullBubbleBombTouch(_v) && !scrNTTEFullBubbleBombBaseball(_v)) return;
    }
    for(var _i=0;_i<array_length(_meeting);++_i) {
        var _v=_meeting[_i]
        if (instance_exists(_v) && _v.team!=team && scrNTTEFullBubbleBombTouch(_v) && (_v.object_index==Flame || _v.object_index==Bolt || _v.object_index==Splinter || _v.object_index==HeavyBolt || _v.object_index==UltraBolt)) {
            instance_destroy(); return;
        }
    }
    if (z<24 && (array_length(held)==0 || big>0)) for(var _i=0;_i<array_length(_meeting);++_i) if (scrNTTEFullBubbleBombGrab(_meeting[_i])) break
    y+=z
    for(var _i=0;_i<array_length(_meeting);++_i) {
        var _v=_meeting[_i]
        if (instance_exists(_v) && instance_is(_v,NTTEFullBubbleBomb) && _v.big>=big && place_meeting(x,y,_v)) motion_add(point_direction(_v.x,_v.y,x,y)+orandom(4),0.5*timescale*timescale)
    }
}
function scrNTTEFullBubbleBombHit(_target) {
    if (lockstep_stop || z>=24 || instance_is(_target,prop) || _target.team==0) return;
    if (instance_is(_target,enemy) && current_frame_active && random(2)<1 && !scrNTTEFullValue(_target,"bubble_bombed",false)) {
        speed*=0.9
        with (_target) scrNTTEFullNativeMotionAddFT(id,other.direction,other.knockback_speed/timescale)
    }
    if (big<=0 && team==team_player) image_index+=image_speed*2
}
function scrNTTEFullBubbleBombWall() {
    if (lockstep_stop || speed<=0) return;
    snd_play(sndBouncerBounce); move_bounce_solid(false); speed*=0.5
}
function scrNTTEFullBubbleBombDraw() {
    var _blink=random(8+image_number-image_index)<timescale
    draw_sprite_ext(sprite_index,image_index,x,y-z,image_xscale,image_yscale,image_angle,_blink ? c_black:image_blend,image_alpha)
}
function scrNTTEFullBubbleBombAnimate() {
    if (lockstep_stop) return;
    if (deflected) team=instance_is(creator,Player) ? creator.team:-1
    var _dist=16*big,_angle=direction,_num=lerp(1,3,big)
    for(var _dir=_angle;_dir<_angle+360;_dir+=360/_num) {
        var _blast=scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(_dist,_dir),y-z+lengthdir_y(_dist,_dir),NTTEFullBubbleExplosion)
        _blast.damage=damage
    }
    sleep(15*big); scrNTTEFullTrenchShake(x,y,60*big)
    if (big>0) snd_play(sndOasisExplosion,0.8+orandom(0.05))
    for(var _i=0;_i<array_length(held);++_i) {
        var _v=held[_i]
        if (instance_exists(_v) && instance_is(_v,projectile) && _v.creator!=creator) instance_destroy(_v)
    }
    instance_destroy()
}
function scrNTTEFullBubbleBombCleanup() {
    for(var _i=0;_i<array_length(held);++_i) if (instance_exists(held[_i])) held[_i].bubble_bombed=false
}
function scrNTTEFullBubbleBombDeath() {
    scrNTTEFullBubbleBombCleanup(); snd_play(sndLilHunterBouncer,2+random(0.5),0.5)
    with (instance_create(x,y-z,BulletHit)) {
        sprite_index=sprPlayerBubblePop; image_angle=other.image_angle; image_xscale=0.5+0.01*other.image_index; image_yscale=image_xscale
    }
}
