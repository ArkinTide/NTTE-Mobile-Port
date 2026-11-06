// Original tesewers.mod.gml1613..1982. Physical thrown weapons use the
// already accepted inventory/pickup path; these sawblades return magazine
// rounds to their exact firing state and never duplicate a weapon pickup.
function scrNTTEFullBatDiscCreate() {
    sprite_index=scrNTTERefSprite("BatDisc");image_speed=0;depth=-2
    mask_index=mskFlakBullet;friction=0.4*timescale*timescale;maxspeed=12
    damage=2;typ=2;setup=true;wep=noone;ammo=1;has_hit=false
    returning=false;target=noone;big=false;key="";seek=48*scr_skill_get(mut_bolt_marrow)
    walled=false;speed=maxspeed*timescale;state=undefined;state_epoch=0
    refund=0;refunded=false;ntte_bat_alarm_frame=-1
    temerge_on_fire=scrNTTEFullBatDiscMergedFire
}
function scrNTTEFullBatDiscMergedFire(_at=undefined,_info=undefined) { temerge_can_delete=false }
function scrNTTEFullBatDiscBind(_disc,_state,_rounds,_refund=undefined) {
    if(!instance_exists(_disc)) return _disc
    _disc.state=_state;_disc.wep=_state
    _disc.state_epoch=is_struct(_state)?scrNTTEFullValue(_state,"epoch",0):0
    // Physical split count is independent of whether a magazine was charged.
    // Infinite ammo still fires/splits the original number of blades.
    _disc.ammo=_rounds;_disc.refund=is_undefined(_refund)?_rounds:_refund
    return _disc
}
function scrNTTEFullBatDiscSetup() {
    setup=false
    if(big) {
        if(sprite_index==scrNTTERefSprite("BatDisc")) sprite_index=scrNTTERefSprite("BatDiscBig")
        if(alarm[0]<0) alarm[0]=30
        seek*=4/3
    }
}
function scrNTTEFullBatDiscOwns(_holder) {
    var _fields=["wep","bwep","ntte_state","bntte_state"]
    for(var _i=0;_i<array_length(_fields);++_i)
        if(variable_instance_exists(_holder,_fields[_i]) && variable_instance_get(_holder,_fields[_i])==wep) return true
    return false
}
function scrNTTEFullBatDiscStep() {
    if(lockstep_stop || ntte_bat_alarm_frame==current_frame) return;
    speed=min(speed,maxspeed*timescale);image_angle+=40*timescale
    var _nearest=infinity,_families=[Player,WepPickup,ProtoChest],_thrown=asset_get_index("ThrownWep")
    if(!object_exists(_thrown)) _thrown=asset_get_index("NTTEFullThrownWep")
    if(object_exists(_thrown)) array_push(_families,_thrown)
    for(var _f=0;_f<array_length(_families);++_f) {
        var _holders=scrNTTEFullInstances(_families[_f])
        for(var _i=0;_i<array_length(_holders);++_i) {
            var _holder=_holders[_i]
            if(!scrNTTEFullBatDiscOwns(_holder)) continue
            var _distance=point_distance(x,y,_holder.x,_holder.y)
            if(_distance<_nearest) {_nearest=_distance;target=_holder}
        }
    }
    if(!instance_exists(target)) target=creator
    if(walled) {
        if(current_frame_active) scrNTTEFullTrenchShake(x,y,4,true)
        if(random(3)<timescale) {var _dust=instance_create(x,y,Dust);/* NTTE DUST LIFETIME bat-disc */ if(instance_exists(_dust)) {_dust.depth=-7 }}
        visible=place_meeting(x,y,Floor)
        if(visible && !place_meeting(x,y,Wall)) {
            walled=false;scrNTTEFullMergedStockFX(x,y,[direction+orandom(40),4+random(4)],Debris)
            instance_create(x,y,Smoke)
        }
    }
    else {
        // Genuine overlapping Slash instances can bat the same blade again.
        // Custom slash equivalents inherit Slash or expose their discriminator.
        var _slashes=scrNTTEFullInstances(projectile)
        for(var _i=0;_i<array_length(_slashes);++_i) {
            var _slash=_slashes[_i]
            if(_slash==id || !(instance_is(_slash,Slash) || instance_is(_slash,EnergySlash)
                || instance_is(_slash,BloodSlash) || instance_is(_slash,EnergyHammerSlash)
                || instance_is(_slash,LightningSlash) || scrNTTEFullValue(_slash,"ntte_custom_slash",false))) continue
            if(!place_meeting(x,y,_slash)) continue
            deflected=true;returning=false;has_hit=false
            seek=max(seek,48*scr_skill_get(mut_bolt_marrow));direction=_slash.direction;speed=(maxspeed+8)*timescale
            sleep(12);scrNTTEFullTrenchShake(x,y,3)
            scrNTTEFullMergedBasicSoundAt(x,y,sndDiscBounce,1.3+random(0.3),0.5,320)
            var _fx=instance_create(x,y,Deflect);_fx.image_angle=direction
        }
        if(current_frame_active) {
            var _trail=instance_create(x,y,DiscTrail)
            _trail.sprite_index=big?scrNTTERefSprite("BigDiscTrail"):sprDiscTrail
        }
    }
    var _seek_distance=seek,_seek_target=noone
    if(_seek_distance>0 && instance_exists(creator) && point_distance(x,y,creator.x,creator.y)<160) {
        var _targets=scrNTTEFullInstances(hitme)
        for(var _i=0;_i<array_length(_targets);++_i) {
            var _enemy=_targets[_i]
            if(_enemy.team==team || _enemy.team==team_none || _enemy.mask_index==mskNone || instance_is(_enemy,prop)) continue
            var _distance=point_distance(x,y,_enemy.x,_enemy.y)
            if(_distance<_seek_distance) {_seek_distance=_distance;_seek_target=_enemy}
        }
    }
    if(instance_exists(_seek_target)) {
        // ref_speed returns native speed/ts; ref_friction_raw returns the
        // unscaled native friction. The source subtracts that raw value from
        // logical speed and then ref_speed's setter multiplies by ts again.
        image_index=1;speed=max(speed-friction*timescale,0)
        motion_add(point_direction(x,y,_seek_target.x,_seek_target.y),timescale*timescale)
    }
    else {
        image_index=0
        if(returning) {
            var _tx=xstart,_ty=ystart
            if(instance_exists(target)) {_tx=target.x;_ty=target.y}
            var _moving=(instance_exists(target) && place_meeting(_tx,_ty,target))
                ?distance_to_object(target)>0:point_distance(x,y,_tx,_ty)>speed
            if(_moving) {
                var _thrust=friction/timescale/timescale*2
                if(point_distance(x,y,_tx,_ty)<32) {_thrust=2;speed=max(0,speed-0.8*timescale*timescale)}
                motion_add(point_direction(x,y,_tx,_ty),_thrust*timescale*timescale)
            }
            else {
                var _disc=id,_at=instance_exists(target)?target:id
                with(_at) {
                    if(variable_instance_exists(id,"gunangle")) {
                        var _weapon=is_struct(_disc.wep)?scrNTTEFullValue(_disc.wep,"weapon",0):0,
                            _kick=6*sign(angle_difference(_disc.direction,gunangle+90))*(scr_weapon_is_melee(_weapon)?-1:1)
                        if(variable_instance_exists(id,"wkick") && ((variable_instance_exists(id,"ntte_state") && ntte_state==_disc.wep) || wep==_disc.wep)) wkick=_kick
                        if(variable_instance_exists(id,"bwkick") && ((variable_instance_exists(id,"bntte_state") && bntte_state==_disc.wep) || bwep==_disc.wep)) bwkick=_kick
                    }
                    scrNTTEFullTrenchShake(x,y,12,true)
                    if(friction>0) motion_add(_disc.direction,2*timescale)
                    scrNTTEFullMergedBasicSoundAt(x,y,sndDiscgun,0.8+random(0.4),0.6,320)
                    scrNTTEFullMergedBasicSoundAt(x,y,sndCrossReload,0.6+random(0.4),0.8,320)
                }
                instance_destroy();return;
            }
        }
        else if(speed<=5*timescale && !big) returning=true
    }
}
function scrNTTEFullBatDiscEndStep() {
    if(lockstep_stop) return;
    if(setup) scrNTTEFullBatDiscSetup()
    if(x==xprevious && y==yprevious && place_meeting(x+hspeed,y+vspeed,Wall)) {x+=hspeed;y+=vspeed}
}
function scrNTTEFullBatDiscAlarm() {
    ntte_bat_alarm_frame=current_frame
    if(ammo>0) {
        var _rounds=ammo
        for(var _i=0;_i<_rounds;++_i) {
            var _child=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBatDisc,direction+360*_i/_rounds)
            _child.wep=wep;_child.state=state;_child.state_epoch=state_epoch
            _child.refund=refund/_rounds;_child.walled=walled;_child.visible=visible
            repeat(irandom_range(1,2)) {
                var _smoke=scrNTTEFullMergedStockFX(x,y,random(6),Smoke)
                /* NTTE NATIVE EFFECT LIFETIME bat-disc-split-smoke */ if(instance_exists(_smoke)) {if(walled) {_smoke.depth=-7;_smoke.speed/=2} }
            }
        }
        ammo=0;refund=0
    }
    scrNTTEFullTrenchShake(x,y,20);snd_play(sndClusterLauncher,0.8+random(0.4));instance_destroy()
}
function scrNTTEFullBatDiscHit(_victim) {
    // Original projectile_canhit is scrBulletCanHit: team inequality only,
    // including dead targets and regardless of their current hurt interval.
    if(lockstep_stop || !current_frame_active || !instance_exists(_victim) || _victim.team==team) return;
    scrNTTEFullNativeProjectileHitPush(_victim,damage,knockback_speed/timescale);has_hit=true;speed*=0.9
    var _big=instance_exists(_victim) && _victim.size>=3 && big
    scrNTTEFullTrenchShake(x,y,_big?12:6,true)
    if(!instance_exists(_victim) || _victim.hp<=0) {sleep(_big?48:24);scrNTTEFullTrenchShake(x,y,_big?32:16,true)}
    instance_create(x,y,Smoke);seek*=0.8
}
function scrNTTEFullBatDiscWall() {
    if(lockstep_stop) return;
    if(!returning && !has_hit && instance_exists(target)) {
        move_bounce_solid(true)
        if(!big) returning=true
        snd_play_hit(sndDiscBounce,0.4)
        var _fx=instance_create(x-hspeed,y-vspeed,MeleeHitWall);_fx.image_angle=direction+180
    }
    else if(!walled) {
        walled=true;instance_create(x,y,Smoke);scrNTTEFullTrenchShake(x,y,8,true);sleep(8)
        snd_play_hit(sndPillarBreak,0.4);snd_play_hit(sndDiscHit,0.4)
    }
}
function scrNTTEFullBatDiscDestroy() {
    var _fx=instance_create(x,y,DiscDisappear)
    _fx.sprite_index=big?scrNTTERefSprite("BigDiscTrail"):sprDiscTrail
    _fx=scrNTTEFullMergedStockFX(x,y,[direction,3],Smoke);/* NTTE NATIVE EFFECT LIFETIME bat-disc-destroy-smoke */ if(instance_exists(_fx)) {_fx.growspeed/=2 }
}
function scrNTTEFullBatDiscCleanup() {
    if(refunded) return;
    refunded=true
    // Magazine credits remain attached to the exact state/epoch. Do not touch
    // the accepted physical weapon-slot removal/landing/auto-pickup helpers.
    if(is_struct(state) && variable_struct_exists(state,"outstanding")) scrNTTEReturn(state,refund,state_epoch)
    else if(is_struct(wep) && variable_struct_exists(wep,"ammo")) {
        wep.ammo+=ammo
        if(variable_struct_exists(wep,"amax")) wep.ammo=min(wep.ammo,wep.amax)
        if(!scrNTTEFullValue(wep,"canload",true)) {
            if(wep.ammo>=scrNTTEFullValue(wep,"amax",0)) wep.canload=true
            else {
                var _identity=wep
                with(Player) {
                    if(wep==_identity) can_shoot=false
                    if(bwep==_identity) bcan_shoot=false
                }
            }
        }
    }
    if(instance_is(target,WepPickup)) target.sprite_index=scr_weapon_get_sprite(target.wep)
}
