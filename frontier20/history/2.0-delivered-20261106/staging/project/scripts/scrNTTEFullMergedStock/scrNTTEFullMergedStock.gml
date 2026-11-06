// Original stock projectile effects, temerge.mod.gml5098..5789. The dispatch
// table is generated against the original callback inventory and native object
// ancestry. Missing callbacks are errors while the natural merge gate is off.
function scrNTTEFullMergedHeavyBulletSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.1)
    scrNTTEFullMergedProjectileAddDamage(_list,2/3)
    scrNTTEFullMergedProjectileAddForce(_list,2)
}
function scrNTTEFullMergedUltraBulletSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.2)
    scrNTTEFullMergedProjectileAddBloom(_list,0.2)
    scrNTTEFullMergedProjectileAddDamage(_list,1.5)
    scrNTTEFullMergedProjectileAddForce(_list,4)
}
function scrNTTEFullMergedFlameShellSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"flame")
}
function scrNTTEFullMergedUltraShellSetup(_list,_info=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) {
        // Modern sprite bbox maxima are exclusive; source maxima are inclusive.
        if(sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index)<=sprite_get_bbox_right(sprite_index)-sprite_get_bbox_left(sprite_index))
            scrNTTEFullMergedProjectileAddScale(id,0.1,0)
        else scrNTTEFullMergedProjectileAddScale(id,0,0.1)
        if(friction>0) friction*=2/3
    }
    scrNTTEFullMergedProjectileAddBloom(_list,0.2)
    scrNTTEFullMergedProjectileAddDamage(_list,1)
    scrNTTEFullMergedProjectileAddForce(_list,2)
}
function scrNTTEFullMergedSlugSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.25)
    scrNTTEFullMergedProjectileAddEffect(_list,"slug",[1])
    scrNTTEFullMergedProjectileAddForce(_list,4)
}
function scrNTTEFullMergedHeavySlugSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.4)
    scrNTTEFullMergedProjectileAddEffect(_list,"slug",[2])
    scrNTTEFullMergedProjectileAddForce(_list,8)
}
function scrNTTEFullMergedHyperSlugSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"hyper")
    scrNTTEFullMergedSlugSetup(_list,_info)
}
function scrNTTEFullMergedSuperFlakSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.2)
}
function scrNTTEFullMergedBoltFire(_at,_info=undefined) { _at.accuracy*=0.5; }
function scrNTTEFullMergedBoltSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"piercing",[0.5])
    scrNTTEFullMergedProjectileAddEffect(_list,"trail")
}
function scrNTTEFullMergedHeavyBoltSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.25)
    scrNTTEFullMergedProjectileAddDamage(_list,1)
    scrNTTEFullMergedProjectileAddForce(_list,2)
    scrNTTEFullMergedBoltSetup(_list,_info)
}
function scrNTTEFullMergedToxicBoltSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"toxic")
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) image_blend=merge_color(image_blend,make_color_rgb(131,253,8),0.5)
    scrNTTEFullMergedBoltSetup(_list,_info)
}
function scrNTTEFullMergedUltraBoltSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddBloom(_list,0.2)
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) scrNTTEFullMergedProjectileAddEffect(id,"wall_piercing",[damage/6])
    scrNTTEFullMergedBoltSetup(_list,_info)
}
function scrNTTEFullMergedSplinterSetup(_list,_info=undefined) { scrNTTEFullMergedProjectileAddScale(_list,-0.05); }
function scrNTTEFullMergedSeekerSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,-0.05)
    scrNTTEFullMergedProjectileAddEffect(_list,"trail")
    scrNTTEFullMergedProjectileAddEffect(_list,"seeking")
}
function scrNTTEFullMergedFlareSetup(_list,_info=undefined) { scrNTTEFullMergedProjectileAddEffect(_list,"flame_trail"); }
function scrNTTEFullMergedFlameBallSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.1)
    scrNTTEFullMergedProjectileAddDamage(_list,0.5)
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) friction/=3
    scrNTTEFullMergedProjectileAddEffect(_list,"flame_trail",[2])
}
function scrNTTEFullMergedRocketSetup(_list,_info=undefined) { scrNTTEFullMergedProjectileAddEffect(_list,"rocket"); }
function scrNTTEFullMergedNukeFire(_at,_info) { _info.player_index=scrNTTEFullValue(_at.creator,"index",-1); }
function scrNTTEFullMergedNukeSetup(_list,_info) {
    scrNTTEFullMergedProjectileAddEffect(_list,"rocket",[1.5,0.5])
    scrNTTEFullMergedProjectileAddEffect(_list,"explosion")
    scrNTTEFullMergedProjectileAddEffect(_list,"guiding",[_info.player_index])
}
function scrNTTEFullMergedLaserFire(_at,_info) {
    _at.accuracy*=0.2
    var _dis=320,_dx=dcos(image_angle),_dy=-dsin(image_angle),
        _sx=xstart,_sy=ystart,_ex=_sx+_dis*_dx,_ey=_sy+_dis*_dy,
        _walled=collision_line(_sx,_sy,_ex,_ey,Wall,false,false)
    if(_walled) while(_dis>=1) {
        _dis/=2
        if(_walled) { _ex-=_dis*_dx;_ey-=_dis*_dy; }
        else { _ex+=_dis*_dx;_ey+=_dis*_dy; }
        _walled=collision_line(_sx,_sy,_ex,_ey,Wall,false,false)
    }
    _info.max_distance=point_distance(_sx,_sy,_ex,_ey)
}
function scrNTTEFullMergedLaserSetup(_list,_info) {
    var _moving=[]
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i]) && _list[_i].speed!=0) array_push(_moving,_list[_i])
    // telib.array_shuffle1945 uses forward Fisher-Yates, including its final
    // one-element RNG draw. Preserve that sequence for all downstream effects.
    for(var _i=0;_i<array_length(_moving);++_i) {
        var _j=irandom_range(_i,array_length(_moving)-1),_swap=_moving[_i];_moving[_i]=_moving[_j];_moving[_j]=_swap
    }
    scrNTTEFullMergedProjectileAddEffect(_moving,"laser",[_info.max_distance])
}
function scrNTTEFullMergedLightningSetup(_list,_info=undefined) {
    var _count=array_length(_list)
    for(var _i=0;_i<_count;++_i) with(_list[_i]) if(random(_count)<2) {
        var _fx=scrNTTEFullMergedStockFX(x,y,0.5,PlasmaTrail)
        _fx.sprite_index=sprLightning;_fx.image_xscale=random(3);_fx.image_yscale=random(1)
        _fx.image_angle=direction+orandom(30)
        with(_fx) motion_add(other.direction,0.5*timescale)
    }
}
function scrNTTEFullMergedStockFX(_x,_y,_motion,_object) {
    var _fx=instance_create(is_array(_x) ? _x[0]+orandom(_x[1]):_x,is_array(_y) ? _y[0]+orandom(_y[1]):_y,_object)
    with(_fx) {
        var _face=image_angle==direction || (speed==0 && (object_index==AcidStreak || object_index==BloodStreak))
        if(is_array(_motion)) motion_add(_motion[0],_motion[1]*timescale)
        else motion_add(random(360),_motion*timescale)
        if(_face) image_angle=direction
    }
    return _fx
}
function scrNTTEFullMergedLightningBallSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.1)
    scrNTTEFullMergedProjectileAddDamage(_list,0.5)
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) friction/=3
    scrNTTEFullMergedProjectileAddEffect(_list,"lightning_trail")
}
function scrNTTEFullMergedPlasmaBallSetup(_list,_info=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) friction/=3
    scrNTTEFullMergedProjectileAddEffect(_list,"plasma")
}
function scrNTTEFullMergedPlasmaBigSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.2)
    scrNTTEFullMergedProjectileAddBloom(_list,1/3)
    scrNTTEFullMergedProjectileAddDamage(_list,2.5)
    scrNTTEFullMergedProjectileAddForce(_list,4)
    scrNTTEFullMergedPlasmaBallSetup(_list,_info)
}
function scrNTTEFullMergedPlasmaHugeSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddScale(_list,0.4)
    scrNTTEFullMergedProjectileAddBloom(_list,2/3)
    scrNTTEFullMergedProjectileAddDamage(_list,5.5)
    scrNTTEFullMergedProjectileAddForce(_list,4)
    scrNTTEFullMergedPlasmaBallSetup(_list,_info)
}
function scrNTTEFullMergedPlasmaHugeDestroy() {
    instance_create(x,y,PortalClear)
    var _count=ceil(damage/13)
    if(_count>0) {
        var _angle=random(360)
        for(var _a=_angle;_a<_angle+360;_a+=360/_count) scrNTTEFullMergedBasicProjectileCreate(x,y,PlasmaBall,_a,2)
    }
}
function scrNTTEFullMergedDevastatorFire(_at,_info=undefined) {
    if(alarm[0]>0 && _at.speed_factor>0.5) _at.speed_factor=lerp(0.5,_at.speed_factor,0.4)
}
function scrNTTEFullMergedDevastatorSetup(_list,_info=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) with(_list[_i]) {
        if(scrNTTEFullMergedProjectileHasEffect(id,"plasma_trail")) scrNTTEFullMergedProjectileAddEffect(id,"piercing",[2])
        friction/=3
    }
    scrNTTEFullMergedProjectileAddEffect(_list,"plasma_trail")
    scrNTTEFullMergedProjectileAddEffect(_list,"plasma",[1])
}
function scrNTTEFullMergedSlashFire(_at,_info=undefined) {
    temerge_can_delete=false
    scrNTTEFullMergedProjectileAddScale(id,-0.25)
}
function scrNTTEFullMergedShankFire(_at,_info=undefined) {
    temerge_can_delete=false
    scrNTTEFullMergedProjectileAddScale(id,-0.1)
}

function scrNTTEFullMergedProjectileDestroy(_input) {
    var _list=is_array(_input)?_input:[_input]
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        var _old=scrNTTEFullValue(id,"temerge_event_last_team",undefined)
        if(team==_old) team=_old
        temerge_event_last_team=undefined
        instance_destroy()
    }
}
function scrNTTEFullMergedKeepFire(_at=undefined,_info=undefined) { temerge_can_delete=false; }
function scrNTTEFullMergedBubbleFire(_at,_info) { _info.is_big=big; }
function scrNTTEFullMergedBubbleSetup(_list,_info) {
    scrNTTEFullMergedProjectileAddEffect(_list,"explosion",[{is_bubble:true},_info.is_big?3:1])
}
function scrNTTEFullMergedHyperBubbleSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"hyper")
    scrNTTEFullMergedProjectileAddEffect(_list,"explosion",[{is_bubble:true}])
}
function scrNTTEFullMergedElectroPlasmaFire(_at,_info) { _info.is_big=ntte_full_big; }
function scrNTTEFullMergedElectroPlasmaSetup(_list,_info) {
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        var _last=scrNTTEFullValue(creator,"temerge_electroplasma_last",noone),
            _close=instance_exists(_last) && point_distance(x,y,_last.x,_last.y)<64
        if(_close || _info.is_big) {
            with(scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTeslaCoil,random(360))) {
                damage=other.damage;ntte_full_purple=true;creator=other.id
                ntte_full_offx=0;ntte_full_offy=0;ntte_full_range=64;ntte_full_time*=2
                if(instance_exists(_last) && point_distance(x,y,_last.x,_last.y)<64) {
                    ntte_full_target_delay=-1;target=_last
                }
            }
        }
        if(instance_exists(creator)) creator.temerge_electroplasma_last=id
    }
}
function scrNTTEFullMergedTeslaCoilSetup(_list,_info=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        if(variable_instance_exists(id,"creator_offx")) { creator_offx=0;creator_offy=0; }
        // Native TeslaCoil's actual corresponding fields are prefixed.
        if(variable_instance_exists(id,"ntte_full_offx")) { ntte_full_offx=0;ntte_full_offy=0; }
    }
}
function scrNTTEFullMergedWallBounce() {
    if(object_index==Laser || object_index==EnemyLaser) {
        with(scrNTTEFullMergedNativeCopy(false)) {
            xstart=x;ystart=y;image_xscale=1
            var _dx=lengthdir_x(2,image_angle),_dy=lengthdir_y(2,image_angle)
            if(place_meeting(x+_dx,y,Wall)) _dx*=-1
            else if(place_meeting(x,y+_dy,Wall)) _dy*=-1
            else { _dx*=-1;_dy*=-1; }
            image_angle=point_direction(0,0,_dx,_dy);direction=image_angle
            event_perform(ev_alarm,0)
        }
    }
    else if(speed!=0) {
        var _old=direction
        move_bounce_solid(true)
        if(image_angle==_old) image_angle=direction
        if(instance_is(id,HyperGrenade)) { alarm[0]=1;alarm[1]=-1; }
    }
}
function scrNTTEFullMergedBouncerBulletWall() {
    scrNTTEFullMergedWallBounce()
    instance_create(x,y,Dust);snd_play_hit(sndBouncerBounce,0.2)
    return true
}
function scrNTTEFullMergedDiscSetup(_list,_info=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        if(!variable_instance_exists(id,"temerge_disc_wall_bounce_frame")) {
            temerge_disc_wall_bounce_frame=current_frame;temerge_disc_friction=0;temerge_disc_is_ally=true
        }
        temerge_disc_wall_bounce_frame=max(current_frame,temerge_disc_wall_bounce_frame)+30
        if(friction!=0) {
            temerge_disc_friction=friction
            var _logical_friction_step=friction/timescale
            if(speed>_logical_friction_step*10) speed=max(_logical_friction_step*10,speed-3*_logical_friction_step)
            friction=0
        }
    }
}
function scrNTTEFullMergedDiscWall() {
    if(temerge_disc_is_ally && (!instance_exists(creator) || distance_to_object(creator)>16
        || point_distance(xstart,ystart,creator.x,creator.y)>16)) {
        temerge_disc_is_ally=false;team=team_none
        // Existing recovered original sprite mapping also updates native laser
        // start/end sprites and the native representation of hostile families.
        var _old_name=scrNTTEFullValue(id,"ntte_original_name",object_get_name(object_index))
        scrNTTEFullPetTwinsTeam(id,team_enemy)
        if(hitid==HitId.None) hitid=[sprite_index==sprEnemyLaser?sprEnemyLaserStart:sprite_index,_old_name]
    }
    if(temerge_disc_wall_bounce_frame>current_frame) {
        var _laser=object_index==Laser || object_index==EnemyLaser
        if(_laser || instance_is(id,HyperGrenade)) temerge_disc_wall_bounce_frame-=30
        scrNTTEFullMergedWallBounce()
        if(_laser) temerge_disc_wall_bounce_frame=current_frame
        snd_play_hit(sndDiscBounce,0.2)
        with(instance_create(x,y,DiscBounce)) image_angle=other.image_angle
    }
    else {
        if(temerge_disc_friction!=0) {
            if(friction==0) friction=temerge_disc_friction
            temerge_disc_friction=0
        }
        snd_play_hit(sndDiscDie,0.2);instance_create(x,y,DiscDisappear)
        return false
    }
}
function scrNTTEFullMergedGrenadeFire(_at,_info) {
    // Source variables are logical velocities/timers; the Epsilon VM stores
    // physical speed/friction, and native alarms retain logical-frame units.
    var _speed=speed/timescale,_friction=friction/(timescale*timescale),
        _steps=floor(_speed/_friction),_distance=0,_explode=alarm[0],_air=alarm[1]
    if(_explode>0 && _explode<_steps) _steps=_explode
    if(_air>0 && _air<_steps && !instance_is(id,BloodBall)) {
        _distance+=_air*(_speed-_friction*((_air+1)/2))
        _speed-=_friction*_air
        _friction=instance_is(id,BloodGrenade)?0.5:0.4
        _steps=floor(_speed/_friction)
        if(_explode>0 && _explode<_steps) _steps=_explode
    }
    _distance+=_steps*(_speed-_friction*((floor(_speed/_friction)+1)/2))
    _info.max_range=_distance;_info.is_sticky=sticky
    _info.is_ultra=instance_is(id,UltraGrenade);_info.is_cannon=instance_is(id,BloodBall)
    _info.is_confetti=instance_is(id,ConfettiBall)
    _info.explosion={is_small:instance_is(id,SmallGrenade),is_heavy:(_info.is_ultra || instance_is(id,HeavyGrenade)),
        is_blood:(instance_is(id,BloodGrenade) || instance_is(id,BloodBall)),
        is_toxic:instance_is(id,ToxicGrenade),is_cluster:instance_is(id,ClusterNade)}
}
function scrNTTEFullMergedGrenadeSetup(_list,_info) {
    if(_info.is_confetti) return;
    var _explosion=_info.explosion
    scrNTTEFullMergedProjectileAddEffect(_list,"grenade",[_info.max_range,_explosion])
    if(_explosion.is_small) scrNTTEFullMergedProjectileAddScale(_list,-0.05)
    if(_explosion.is_heavy) scrNTTEFullMergedProjectileAddScale(_list,0.1)
    if(_explosion.is_blood) for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        if(!place_meeting(x,y,BloodStreak) || random(3)<1) {
            var _offset=15*ceil(((sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index))*image_yscale)/16-1)
            for(var _side=-1;_side<=1;++_side) {
                var _angle=direction==0 && speed==0 ? (image_angle==0?random(360):image_angle):direction
                with(instance_create(xstart+hspeed,ystart+vspeed,BloodStreak)) image_angle=_angle+_offset*_side
                if(_offset==0) break
            }
        }
    }
    if(_info.is_cannon) {
        scrNTTEFullMergedProjectileAddScale(_list,0.1);scrNTTEFullMergedProjectileAddDamage(_list,0.5)
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) _list[_i].friction/=2
        if(_explosion.is_blood) scrNTTEFullMergedProjectileAddEffect(_list,"blood_trail")
    }
    if(_info.is_sticky) {
        scrNTTEFullMergedProjectileAddEffect(_list,"sticky")
        if(!_explosion.is_toxic) scrNTTEFullMergedProjectileAddEffect(_list,"explosion",[_explosion,2])
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
            scrNTTEFullMergedProjectileAddEffect(id,"grenade",[_info.max_range+20*speed/timescale])
            image_blend=merge_color(image_blend,make_color_rgb(131,253,8),0.5)
        }
    }
    if(_info.is_ultra) {
        scrNTTEFullMergedProjectileAddEffect(_list,"pulling");scrNTTEFullMergedProjectileAddBloom(_list,0.2)
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i])
            scrNTTEFullMergedProjectileAddEffect(id,"grenade",[_info.max_range+10*speed/timescale])
    }
}
function scrNTTEFullMergedHyperGrenadeFire(_at,_info=undefined) {
    if(alarm[0]>0) _at.speed_factor=1
}
function scrNTTEFullMergedHyperGrenadeSetup(_list,_info=undefined) {
    scrNTTEFullMergedProjectileAddEffect(_list,"hyper")
    scrNTTEFullMergedProjectileAddEffect(_list,"grenade",[160,{}])
}
function scrNTTEFullMergedFlakDestroy() {
    var _count=min(abs(damage/2)+(knockback_speed/timescale>=3),640)
    if(object_index==Lightning || object_index==EnemyLightning) _count-=ammo
    _count=floor(_count)+(random(1)<frac(_count))
    if(_count<=0) return;
    repeat(_count) scrNTTEFullMergedBasicProjectileCreate(x,y,Bullet2,random(360),random_range(8,16))
    scrNTTEFullMergedBasicSoundAt(x,y,sndFlakExplode,max(0.6,1.2-0.0125*_count)+orandom(0.1),0.2+0.05*_count,320)
    repeat(ceil(_count/3)) scrNTTEFullMergedStockFX(x,y,random(3),Smoke)
    with(instance_create(x,y,BulletHit)) sprite_index=sprFlakHit
    scrNTTEFullTrenchShake(x,y,_count/2);sleep(_count/1.5)
}
function scrNTTEFullMergedSuperFlakDestroy() {
    var _count=min(power(max(0,abs(damage)-1.95),0.45)+0.25*(knockback_speed/timescale>=3),40)
    if(object_index==Lightning || object_index==EnemyLightning) _count-=ammo*1.5
    _count=floor(_count)+(random(1)<frac(_count))
    if(_count>0) {
        var _angle=random(360)
        if(position_meeting(x+lengthdir_x(16,_angle),y+lengthdir_y(16,_angle),Wall)) _angle+=180
        for(var _d=_angle;_d<_angle+360;_d+=360/_count) scrNTTEFullMergedBasicProjectileCreate(x,y,FlakBullet,_d,12)
        scrNTTEFullMergedBasicSoundAt(x,y,sndSuperFlakExplode,max(0.6,1.2-0.04*_count)+orandom(0.1),0.2+0.16*_count,320)
        repeat(floor(_count*2.5)) scrNTTEFullMergedStockFX(x,y,random(3),Smoke)
        with(instance_create(x,y,BulletHit)) sprite_index=sprSuperFlakHit
        scrNTTEFullTrenchShake(x,y,_count*2.5);sleep(_count*4)
    }
    else {
        var _add=2*(knockback_speed/timescale>=3)
        damage+=_add;scrNTTEFullMergedFlakDestroy();damage-=_add
    }
}
function scrNTTEFullMergedConfettiHit() {
    if(scrNTTEFullMergedProjectileCanHit(other.id) && other.hp<=damage
        && scrNTTEFullValue(other.id,"temerge_confetti_can_hit",true)) {
        other.temerge_confetti_can_hit=false
        repeat(30) scrNTTEFullMergedStockFX(x,y,random(14),Confetti)
        snd_play_hit_big(asset_get_index("sndConfetti"+string(irandom_range(1,7))),0.2)
    }
}

function scrNTTEFullMergedStockNativeTests() {
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _old_registry=variable_global_exists("ntte_full_merged_stock_events")?global.ntte_full_merged_stock_events:undefined
    try {
        // Logical speed10, air6:57.9distance; then23steps at9.4speed/.4friction:105.8.
        var _grenade=instance_create(8000,8000,Grenade),_info={},_at={speed_factor:3}
        _grenade.speed=10*timescale;_grenade.friction=0.1*timescale*timescale
        _grenade.alarm[0]=60;_grenade.alarm[1]=6;_grenade.sticky=true
        with(_grenade) scrNTTEFullMergedGrenadeFire(_at,_info)
        assert(abs(_info.max_range-163.7)<0.001 && _info.is_sticky && !_info.is_cannon
            && !_info.is_confetti && !_info.explosion.is_blood,"Native grenade ballistic mount range/flags changed")
        var _blood=instance_create(8000,8000,BloodGrenade),_bloodinfo={}
        _blood.speed=10*timescale;_blood.friction=0.1*timescale*timescale
        _blood.alarm[0]=60;_blood.alarm[1]=6
        with(_blood) scrNTTEFullMergedGrenadeFire(_at,_bloodinfo)
        assert(abs(_bloodinfo.max_range-141.6)<0.001 && _bloodinfo.explosion.is_blood,
            "Blood grenade landing friction was not preserved")
        var _hyper=instance_create(8000,8000,HyperGrenade)
        _hyper.alarm[0]=1
        with(_hyper) scrNTTEFullMergedHyperGrenadeFire(_at)
        assert(_at.speed_factor==1,"HyperGrenade charging mount speed changed")
        _hyper.alarm[0]=0;_at.speed_factor=3
        with(_hyper) scrNTTEFullMergedHyperGrenadeFire(_at)
        assert(_at.speed_factor==3,"Uncharged HyperGrenade wrongly forces speed")
        var _disc=instance_create(8000,8000,Bullet1)
        _disc.speed=10*timescale;_disc.friction=0.2*timescale*timescale
        scrNTTEFullMergedDiscSetup([_disc]);scrNTTEFullMergedDiscSetup([_disc])
        assert(abs(_disc.speed-9.4*timescale)<0.001 && _disc.friction==0
            && _disc.temerge_disc_wall_bounce_frame==current_frame+60,"Disc stacking/friction logical conversion changed")
        _disc.temerge_disc_wall_bounce_frame=current_frame;_disc.temerge_disc_is_ally=false
        with(_disc) scrNTTEFullMergedDiscWall()
        assert(abs(_disc.friction-0.2*timescale*timescale)<0.0001 && _disc.temerge_disc_friction==0,
            "Disc expiry did not restore its actual native friction")
        scrNTTEFullMergedStockInit()
        var _events=scrNTTEFullMergedStockEvents(HeavyGrenade)
        assert(is_callable(_events.fire) && is_callable(_events.setup),"HeavyGrenade lost original Grenade callback inheritance")
        var _flak=instance_create(8000,8000,Bullet1),_old_count=instance_number(Bullet2)
        _flak.team=team_player;_flak.creator=_player;_flak.damage=4;_flak.knockback_speed=0
        with(_flak) scrNTTEFullMergedFlakDestroy()
        assert(instance_number(Bullet2)==_old_count+2,"Flak callback emitted the wrong real shrapnel count")
        with(Bullet2) if(array_get_index(_before,id)<0) {
            assert(team==team_player && creator==_player && speed>=8*timescale && speed<=16*timescale,
                "Flak shrapnel lost telib motion/owner/team")
        }
        var _confetti=instance_create(8000,8000,ConfettiBall),_victim=instance_create(8000,8000,NTTEBabyGator)
        _confetti.team=team_player;_confetti.creator=_player;_confetti.damage=4
        _victim.team=team_enemy;_victim.hp=4;_victim.solid=false
        var _old_confetti=instance_number(Confetti)
        with(_victim) with(_confetti) scrNTTEFullMergedConfettiHit()
        with(_victim) with(_confetti) scrNTTEFullMergedConfettiHit()
        assert(instance_number(Confetti)==_old_confetti+30 && !_victim.temerge_confetti_can_hit,
            "Confetti death callback duplicated reward or missed lethal hit")
        var _inherited=instance_create(8000,8000,Bullet1)
        _inherited.team=team_player;_inherited.creator=_player
        _inherited.speed=4*timescale;_inherited.direction=0;_inherited.image_angle=0
        var _inherited_force=_inherited.knockback_speed
        var _merge={speed_factor:2,on_setup:scrNTTEFullMergedHeavyBulletSetup,setup_vars:{},
            on_hit:undefined,on_wall:undefined,on_destroy:undefined}
        scrNTTEFullMergeApplyEffects([_inherited],_merge)
        scrNTTEFullMergeApplyEffects([_inherited],_merge)
        assert(_inherited.damage==5 && abs(_inherited.image_xscale-1.1)<0.0001
            && abs(_inherited.knockback_speed-(_inherited_force+2*timescale))<0.0001 && abs(_inherited.speed-8*timescale)<0.0001,
            "Inherited stock setup/damage/force/speed applied twice or used physical speed as logical")
        var _rocket=instance_create(8000,8000,Rocket),_rocket_merge={speed_factor:2,setup_vars:{},on_setup:undefined}
        _rocket.speed=2*timescale;_rocket.active=false;_rocket.alarm[1]=5
        scrNTTEFullMergeApplyEffects([_rocket],_rocket_merge)
        assert(abs(_rocket.speed-24*timescale)<0.001 && _rocket.alarm[1]==6 && !_rocket.active,
            "Fast inherited rocket lost original ignition delay/speed floor")
        scrNTTESmokeLog("MERGED STOCK: actual Grenade/Blood/Hyper mount range and native ancestry, Disc logical stacking/expiry, Flak physical shrapnel and Confetti lethal-once OK")
    }
    finally {
        with(all) if(array_get_index(_before,id)<0) instance_destroy(id,false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merged_stock_events=_old_registry
    }
}

function scrNTTEFullMergedStockInit() {
    var _table={};
    _table[$ string(NTTEFullCrystalHeartBullet)+"_fire"]=scrNTTEFullMergedKeepFire;
    _table[$ string(NTTEFullRedBullet)+"_setup"]=scrNTTEFullMergedRedBulletSetupUnbound;
    _table[$ string(NTTEFullRedBullet)+"_hit"]=scrNTTEFullMergedRedBulletHitUnbound;
    _table[$ string(NTTEFullHarpoon)+"_hit"]=scrNTTEFullMergedHarpoonHit;
    _table[$ string(NTTEFullNetNade)+"_fire"]=scrNTTEFullMergedNetFire;
    _table[$ string(NTTEFullNetNade)+"_setup"]=scrNTTEFullMergedNetSetup;
    _table[$ string(NTTEFullNetNade)+"_hit"]=scrNTTEFullMergedNetHit;
    _table[$ string(NTTEFullNetNade)+"_destroy"]=scrNTTEFullMergedNetDestroy;
    _table[$ string(NTTEFullBoneArrow)+"_fire"]=scrNTTEFullMergedKeepFire;
    _table[$ string(NTTEFullPortalBullet)+"_setup"]=scrNTTEFullMergedPortalSetupUnbound;
    _table[$ string(NTTEFullPortalBullet)+"_hit"]=scrNTTEFullMergedPortalHitUnbound;
    _table[$ string(NTTEFullBubbleBomb)+"_fire"]=scrNTTEFullMergedBubbleFire;
    _table[$ string(NTTEFullBubbleBomb)+"_setup"]=scrNTTEFullMergedBubbleSetup;
    _table[$ string(NTTEFullHyperBubble)+"_setup"]=scrNTTEFullMergedHyperBubbleSetup;
    _table[$ string(NTTEFullBatDisc)+"_fire"]=scrNTTEFullMergedCustomKeepFire;
    _table[$ string(NTTEFullElectroPlasma)+"_fire"]=scrNTTEFullMergedElectroPlasmaFire;
    _table[$ string(NTTEFullElectroPlasma)+"_setup"]=scrNTTEFullMergedElectroPlasmaSetup;
    _table[$ string(NTTEFullLightningDisc)+"_fire"]=scrNTTEFullMergedLightningDiscFire;
    _table[$ string(NTTEFullLightningDisc)+"_setup"]=scrNTTEFullMergedLightningDiscSetup;
    _table[$ string(NTTEFullLightningDisc)+"_hit"]=scrNTTEFullMergedLightningDiscHit;
    _table[$ string(NTTEFullQuasarBeam)+"_fire"]=scrNTTEFullMergedQuasarBeamFire;
    _table[$ string(NTTEFullQuasarBeam)+"_setup"]=scrNTTEFullMergedQuasarBeamSetup;
    _table[$ string(NTTEFullTeslaCoil)+"_setup"]=scrNTTEFullMergedTeslaCoilSetup;
    _table[$ string(HeavyBullet)+"_setup"]=scrNTTEFullMergedHeavyBulletSetup;
    _table[$ string(UltraBullet)+"_setup"]=scrNTTEFullMergedUltraBulletSetup;
    _table[$ string(BouncerBullet)+"_wall"]=scrNTTEFullMergedBouncerBulletWall;
    _table[$ string(FlameShell)+"_setup"]=scrNTTEFullMergedFlameShellSetup;
    _table[$ string(UltraShell)+"_setup"]=scrNTTEFullMergedUltraShellSetup;
    _table[$ string(Slug)+"_setup"]=scrNTTEFullMergedSlugSetup;
    _table[$ string(HeavySlug)+"_setup"]=scrNTTEFullMergedHeavySlugSetup;
    _table[$ string(HyperSlug)+"_setup"]=scrNTTEFullMergedHyperSlugSetup;
    _table[$ string(FlakBullet)+"_destroy"]=scrNTTEFullMergedFlakDestroy;
    _table[$ string(SuperFlakBullet)+"_setup"]=scrNTTEFullMergedSuperFlakSetup;
    _table[$ string(SuperFlakBullet)+"_destroy"]=scrNTTEFullMergedSuperFlakDestroy;
    _table[$ string(Bolt)+"_fire"]=scrNTTEFullMergedBoltFire;
    _table[$ string(Bolt)+"_setup"]=scrNTTEFullMergedBoltSetup;
    _table[$ string(HeavyBolt)+"_fire"]=scrNTTEFullMergedBoltFire;
    _table[$ string(HeavyBolt)+"_setup"]=scrNTTEFullMergedHeavyBoltSetup;
    _table[$ string(ToxicBolt)+"_fire"]=scrNTTEFullMergedBoltFire;
    _table[$ string(ToxicBolt)+"_setup"]=scrNTTEFullMergedToxicBoltSetup;
    _table[$ string(UltraBolt)+"_fire"]=scrNTTEFullMergedBoltFire;
    _table[$ string(UltraBolt)+"_setup"]=scrNTTEFullMergedUltraBoltSetup;
    _table[$ string(Splinter)+"_setup"]=scrNTTEFullMergedSplinterSetup;
    _table[$ string(Seeker)+"_setup"]=scrNTTEFullMergedSeekerSetup;
    _table[$ string(Disc)+"_setup"]=scrNTTEFullMergedDiscSetup;
    _table[$ string(Disc)+"_wall"]=scrNTTEFullMergedDiscWall;
    _table[$ string(Grenade)+"_fire"]=scrNTTEFullMergedGrenadeFire;
    _table[$ string(Grenade)+"_setup"]=scrNTTEFullMergedGrenadeSetup;
    _table[$ string(HyperGrenade)+"_fire"]=scrNTTEFullMergedHyperGrenadeFire;
    _table[$ string(HyperGrenade)+"_setup"]=scrNTTEFullMergedHyperGrenadeSetup;
    _table[$ string(Flare)+"_setup"]=scrNTTEFullMergedFlareSetup;
    _table[$ string(FlameBall)+"_setup"]=scrNTTEFullMergedFlameBallSetup;
    _table[$ string(Rocket)+"_setup"]=scrNTTEFullMergedRocketSetup;
    _table[$ string(Nuke)+"_fire"]=scrNTTEFullMergedNukeFire;
    _table[$ string(Nuke)+"_setup"]=scrNTTEFullMergedNukeSetup;
    _table[$ string(Laser)+"_fire"]=scrNTTEFullMergedLaserFire;
    _table[$ string(Laser)+"_setup"]=scrNTTEFullMergedLaserSetup;
    _table[$ string(Lightning)+"_setup"]=scrNTTEFullMergedLightningSetup;
    _table[$ string(LightningBall)+"_setup"]=scrNTTEFullMergedLightningBallSetup;
    _table[$ string(PlasmaBall)+"_setup"]=scrNTTEFullMergedPlasmaBallSetup;
    _table[$ string(PlasmaBig)+"_setup"]=scrNTTEFullMergedPlasmaBigSetup;
    _table[$ string(PlasmaHuge)+"_setup"]=scrNTTEFullMergedPlasmaHugeSetup;
    _table[$ string(PlasmaHuge)+"_destroy"]=scrNTTEFullMergedPlasmaHugeDestroy;
    _table[$ string(Devastator)+"_fire"]=scrNTTEFullMergedDevastatorFire;
    _table[$ string(Devastator)+"_setup"]=scrNTTEFullMergedDevastatorSetup;
    _table[$ string(Slash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(EnergySlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(EnergyHammerSlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(LightningSlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(BloodSlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(Shank)+"_fire"]=scrNTTEFullMergedShankFire;
    _table[$ string(EnergyShank)+"_fire"]=scrNTTEFullMergedShankFire;
    _table[$ string(ConfettiBall)+"_hit"]=scrNTTEFullMergedConfettiHit;
    _table[$ string(NTTEFullEnergyBatSlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    _table[$ string(NTTEFullBubbleSlash)+"_fire"]=scrNTTEFullMergedSlashFire;
    global.ntte_full_merged_stock_events=_table;
}
function scrNTTEFullMergedStockEvents(_object) {
    if(!variable_global_exists("ntte_full_merged_stock_events") || !is_struct(global.ntte_full_merged_stock_events)) scrNTTEFullMergedStockInit()
    var _table=global.ntte_full_merged_stock_events,_result={},_names=["fire","setup","hit","wall","destroy"]
    for(var _i=0;_i<array_length(_names);++_i) {
        var _event=_names[_i],_callback=undefined
        for(var _base=_object;object_exists(_base) && (_base==projectile || object_is_ancestor(_base,projectile));_base=object_get_parent(_base)) {
            var _key=string(_base)+"_"+_event
            if(variable_struct_exists(_table,_key)) {
                _callback=_table[$ _key]
                if(!is_callable(_callback)) throw "Original merged projectile callback is not implemented: "+object_get_name(_base)+"/"+_event
                break
            }
        }
        _result[$ _event]=_callback
    }
    return _result
}
