// Original temerge3775..4325: attachment, attraction, thrust, guidance/hitscan.
function scrNTTEFullMergedMotionInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_motion_events_ready",false)) return;
    _registry.ntte_motion_events_ready=true
    scrNTTEFullMergedEffectAddEvent("sticky","setup",scrNTTEFullMergedStickySetup)
    scrNTTEFullMergedEffectAddEvent("sticky","post_step",scrNTTEFullMergedStickyPostStep)
    scrNTTEFullMergedEffectAddEvent("pulling","setup",scrNTTEFullMergedPullingSetup)
    scrNTTEFullMergedEffectAddEvent("pulling","step",scrNTTEFullMergedPullingStep)
    scrNTTEFullMergedEffectAddEvent("rocket","setup",scrNTTEFullMergedMotionRocketSetup)
    scrNTTEFullMergedEffectAddEvent("rocket","step",scrNTTEFullMergedRocketStep)
    scrNTTEFullMergedEffectAddEvent("rocket","draw",scrNTTEFullMergedRocketDraw)
    scrNTTEFullMergedEffectAddEvent("guiding","setup",scrNTTEFullMergedGuidingSetup)
    scrNTTEFullMergedEffectAddEvent("guiding","step",scrNTTEFullMergedGuidingStep)
    scrNTTEFullMergedEffectAddEvent("laser","setup",scrNTTEFullMergedMotionLaserSetup)
}
function scrNTTEFullMergedStickySetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(variable_instance_exists(id,"temerge_sticky_target")) continue
        temerge_sticky_target=noone;temerge_sticky_xoffset=0;temerge_sticky_yoffset=0;temerge_sticky_mask_index=mskNone
        scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedStickyStick)
        scrNTTEFullMergedProjectileAddEvent(id,"wall",scrNTTEFullMergedStickyStick)
    }
}
function scrNTTEFullMergedStickyPostStep(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(temerge_sticky_target==noone) continue
        if(instance_exists(temerge_sticky_target)) {
            var _fraction=1-power(0.5,timescale)
            x=lerp(x,temerge_sticky_target.x+temerge_sticky_xoffset,_fraction)
            y=lerp(y,temerge_sticky_target.y+temerge_sticky_yoffset,_fraction)
            scrNTTEFullMergedEffectsMotion(id,false)
            if(speed!=0 && (object_index==Rocket || object_index==Nuke) && active && instance_is(temerge_sticky_target,hitme)) {
                var _angle=direction,_force=speed*timescale/(3*(max(0,temerge_sticky_target.size)+1))
                with(temerge_sticky_target) motion_add(_angle,_force)
            }
            if(mask_index!=mskNone && object_index!=UltraBolt) { temerge_sticky_mask_index=mask_index;mask_index=mskNone }
        }
        else {
            temerge_sticky_target=noone
            if(temerge_sticky_mask_index!=mskNone) { mask_index=temerge_sticky_mask_index;temerge_sticky_mask_index=mskNone }
        }
    }
}
function scrNTTEFullMergedStickyStick() {
    if(instance_exists(temerge_sticky_target) || !visible) return;
    temerge_sticky_target=other.id;temerge_sticky_xoffset=x-other.x;temerge_sticky_yoffset=y-other.y
    if(speed!=0) {
        repeat(3) {
            temerge_sticky_xoffset+=hspeed/3;temerge_sticky_yoffset+=vspeed/3
            if(place_meeting(other.x+temerge_sticky_xoffset,other.y+temerge_sticky_yoffset,other.id)) break
        }
        x=other.x+temerge_sticky_xoffset+hspeed;y=other.y+temerge_sticky_yoffset+vspeed
    }
    if(instance_is(other,hitme)) {
        var _scale=1-1/(1+max(0,other.size))
        temerge_sticky_xoffset*=_scale;temerge_sticky_yoffset*=_scale
    }
    var _minimum=friction/timescale*10
    if(speed>_minimum) speed=max(_minimum,speed*0.6)
    depth=other.depth+choose(-1,1)
    snd_play_hit(sndGrenadeStickWall,0.1)
    switch(object_index) {
        case Rocket:case Nuke:
            if(instance_is(other,Wall) || instance_is(other,prop)) { active=false;alarm[1]=-1 }
            break;
        case UltraBolt:canhurt=false;break;
        case Laser:case EnemyLaser:alarm[0]=-1;break;
    }
    scrNTTEFullMergedStickyPostStep([id])
}
function scrNTTEFullMergedPullingSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])
        && !variable_instance_exists(_instances[_i],"temerge_pulling_can_play_sound")) _instances[_i].temerge_pulling_can_play_sound=true
}
function scrNTTEFullMergedPullingCandidates() {
    if(!variable_global_exists("ntte_full_merged_basic_custom_hitme")) scrNTTEFullMergedBasicClasses()
    var _families=[enemy,Player,Ally,Sapling,SentryGun],_targets=[]
    for(var _i=0;_i<array_length(global.ntte_full_merged_basic_custom_hitme);++_i)
        array_push(_families,global.ntte_full_merged_basic_custom_hitme[_i])
    for(var _f=0;_f<array_length(_families);++_f) {
        var _list=scrNTTEFullInstances(_families[_f])
        for(var _i=0;_i<array_length(_list);++_i) if(_list[_i].team!=team_none && array_get_index(_targets,_list[_i])<0)
            array_push(_targets,_list[_i])
    }
    return _targets
}
function scrNTTEFullMergedPullingStep(_instances) {
    // Family order/shared custom-Hitme mapping is the original source order.
    var _targets=scrNTTEFullMergedPullingCandidates()
    if(!array_length(_targets)) return;
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        var _radius=96,_strength=power(2,1-(speed/timescale/16))*lerp(damage/20,1,1/15),_sx=x,_sy=y
        for(var _t=0;_t<array_length(_targets);++_t) if(instance_exists(_targets[_t])) with(_targets[_t]) {
            if(point_distance(x,y,_sx,_sy)>=_radius) continue
            // Source3946 moves position directly without a ct multiplier.
            var _distance=_strength*(instance_is(id,Player)?0.5:1),_direction=point_direction(x,y,_sx,_sy),
                _px=x+lengthdir_x(_distance,_direction),_py=y+lengthdir_y(_distance,_direction)
            if(place_free(_px,y)) x=_px
            if(place_free(x,_py)) y=_py
        }
        if(temerge_pulling_can_play_sound && speed<4*timescale) {
            temerge_pulling_can_play_sound=false;snd_play_hit(sndUltraGrenadeSuck,0.2)
        }
        if(random(4)<_strength*timescale) {
            var _length=random(_radius/2),_angle=random(360),_source=id,
                _fx=instance_create(x+lengthdir_x(_length,_angle),y+lengthdir_y(_length,_angle),RadEat)
            with(_fx) {
                motion_add(_angle+180,random(4)*timescale);hspeed+=_source.hspeed/2;vspeed+=_source.vspeed/2
                image_speed*=random_range(0.5,1);depth=-8
                if(random(4)<1) sprite_index=sprEatBigRad
            }
        }
    }
}
function scrNTTEFullMergedRocketMaxSpeed() {
    image_angle-=direction
    var _maximum=(16+bbox_width)*timescale
    image_angle+=direction
    if(temerge_rocket_max_speed<_maximum)
        temerge_rocket_max_speed=min(temerge_rocket_max_speed*temerge_rocket_max_speed_factor,_maximum)
}
function scrNTTEFullMergedMotionRocketSetup(_instances,_max_factor=2,_add_speed=1,_hit_count=1) {
    if(!variable_instance_exists(GameCont,"temerge_rocket_frame")) GameCont.temerge_rocket_frame=0
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_rocket_frame")) {
            temerge_rocket_frame=GameCont.temerge_rocket_frame+5*(1-(friction/timescale*10)/speed)
            temerge_rocket_is_active=false;temerge_rocket_sound=-1;temerge_rocket_max_speed=speed
            temerge_rocket_max_speed_factor=1;temerge_rocket_add_speed=0;temerge_rocket_hit_explosion_count=0
            temerge_rocket_flame_sprite=damage>20?sprNukeFlame:sprRocketFlame
            temerge_rocket_flame_xscale=0;temerge_rocket_flame_yscale=0;temerge_rocket_flame_offset_length=0
            scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedRocketHit)
            scrNTTEFullMergedProjectileAddEvent(id,"wall",scrNTTEFullMergedRocketWall)
        }
        temerge_rocket_max_speed_factor*=_max_factor;temerge_rocket_add_speed+=_add_speed;temerge_rocket_hit_explosion_count+=_hit_count
        scrNTTEFullMergedRocketMaxSpeed()
    }
}
function scrNTTEFullMergedRocketStep(_instances) {
    GameCont.temerge_rocket_frame+=timescale
    var _sprite=-1,_sprite_offset=0,_flame=-1,_flame_offset=0
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(temerge_rocket_is_active==false && temerge_rocket_frame<=GameCont.temerge_rocket_frame) {
            temerge_rocket_is_active=true;scrNTTEFullTrenchShake(x,y,2)
            temerge_rocket_sound=snd_play_hit(sndRocketFly,0.2)
            scrNTTEFullMergedProjectileAddEvent(id,"destroy",scrNTTEFullMergedRocketSoundDestroy)
        }
        if(temerge_rocket_is_active!=true) continue
        if(_sprite!=sprite_index) { _sprite=sprite_index;_sprite_offset=sprite_get_bbox_left(_sprite)-sprite_get_xoffset(_sprite) }
        if(_flame!=temerge_rocket_flame_sprite) {
            _flame=temerge_rocket_flame_sprite
            _flame_offset=sprite_get_xoffset(_flame)-(sprite_get_bbox_right(_flame)-1)
        }
        temerge_rocket_flame_xscale=min(speed/timescale/12,2)*image_xscale
        temerge_rocket_flame_yscale=min(speed/timescale/6,1)*image_yscale
        temerge_rocket_flame_offset_length=(_sprite_offset*image_xscale+_flame_offset*temerge_rocket_flame_xscale)/2
        if(speed!=0 && random(100)<(10+damage)*timescale) {
            var _smoke=instance_create(x+lengthdir_x(temerge_rocket_flame_offset_length,direction)-hspeed,
                y+lengthdir_y(temerge_rocket_flame_offset_length,direction)-vspeed,Smoke)
            // Smoke.Create rejects particles when disabled or during generation.
            // Source uses with(instance_create(...)); a rejected visual is skipped.
            if(instance_exists(_smoke)) _smoke.depth=depth+choose(-1,-2)
        }
        if(speed<temerge_rocket_max_speed) speed=min(speed+temerge_rocket_add_speed*timescale*timescale,temerge_rocket_max_speed)
        else if(speed>temerge_rocket_max_speed) scrNTTEFullMergedRocketMaxSpeed()
    }
}
function scrNTTEFullMergedRocketDraw(_instances) {
    var _index=0.4*GameCont.temerge_rocket_frame,_bloom=instance_exists(SubTopCont)
    for(var _pass=0;_pass<=_bloom;++_pass) {
        var _scale=_pass==1?2:1,_alpha=_pass==1?0.1:1
        if(_pass==1) gpu_set_blendmode(bm_add)
        for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].visible
            && _instances[_i].temerge_rocket_is_active==true) with(_instances[_i])
            draw_sprite_ext(temerge_rocket_flame_sprite,_index+real(id),x+lengthdir_x(temerge_rocket_flame_offset_length,direction),
                y+lengthdir_y(temerge_rocket_flame_offset_length,direction),temerge_rocket_flame_xscale*_scale,
                temerge_rocket_flame_yscale*_scale,direction,image_blend,image_alpha*_alpha)
        if(_pass==1) gpu_set_blendmode(bm_normal)
    }
}
function scrNTTEFullMergedRocketHit() {
    if(!scrNTTEFullMergedProjectileCanHit(other.id)) return;
    if(temerge_rocket_hit_explosion_count>0) {
        --temerge_rocket_hit_explosion_count
        scrNTTEFullMergedProjectileAddEffect(id,"explosion")
        scrNTTEFullMergedExplosionDestroy()
        for(var _i=0;_i<array_length(temerge_explosion_list);++_i) temerge_explosion_list[_i].is_active=false
    }
    if(temerge_rocket_hit_explosion_count<=0) scrNTTEFullMergedRocketWall()
}
function scrNTTEFullMergedRocketWall() {
    if(temerge_rocket_is_active==true) {
        audio_stop_sound(temerge_rocket_sound)
        if(visible) {
            var _length=temerge_rocket_flame_offset_length-10*temerge_rocket_flame_xscale,
                _fx=instance_create(x+lengthdir_x(_length,direction),y+lengthdir_y(_length,direction),BulletHit)
            _fx.sprite_index=temerge_rocket_flame_sprite==sprNukeFlame?sprHeavyBulletHit:sprBulletHit
            _fx.image_xscale=temerge_rocket_flame_yscale;_fx.image_yscale=temerge_rocket_flame_yscale
        }
    }
    temerge_rocket_is_active=-1
}
function scrNTTEFullMergedRocketSoundDestroy() { audio_stop_sound(temerge_rocket_sound) }
function scrNTTEFullMergedGuidingSetup(_instances,_index) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) _instances[_i].temerge_guiding_index=_index
}
function scrNTTEFullMergedGuidingStep(_instances) {
    var _players=scrNTTEFullInstances(Player)
    for(var _p=0;_p<array_length(_players);++_p) {
        var _player=_players[_p],_index=_player.index,
            _mx=_player.x+lengthdir_x(KeyCont.dis_fire[_index],KeyCont.dir_fire[_index]),
            _my=_player.y+lengthdir_y(KeyCont.dis_fire[_index],KeyCont.dir_fire[_index])
        for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
            if(temerge_guiding_index!=_index || speed==0 || scrNTTEFullValue(id,"temerge_rocket_is_active",true)!=true) continue
            var _turn=angle_difference(point_direction(x,y,_mx,_my),direction),_factor=abs(dsin(_turn))/12,
                _move=-power(_factor*4,24/(speed/timescale))
            _turn*=_factor*timescale;direction+=_turn;image_angle+=_turn;x+=hspeed*_move;y+=vspeed*_move
        }
    }
}
function scrNTTEFullMergedMotionLaserSetup(_instances,_max_distance) {
    var _team=undefined,_enemies=[],_count=array_length(_instances)
    for(var _i=0;_i<_count;++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        var _distance=0,_maximum=_max_distance*(1-_i/_count),_step=max(4,speed/timescale),
            _dx=dcos(direction),_dy=-dsin(direction),_sx=x,_sy=y,_meeting=false
        if(is_undefined(_team) || _team!=team) {
            _team=team;_enemies=[]
            with(hitme) if(team!=_team) array_push(_enemies,id)
        }
        while(_distance<_maximum) {
            _distance=min(_distance+_step,_maximum);x=_sx+_dx*_distance;y=_sy+_dy*_distance
            if(array_length(_enemies) && place_meeting(x,y,hitme)) {
                var _self=id
                for(var _e=0;_e<array_length(_enemies);++_e) if(instance_exists(_enemies[_e])) with(_enemies[_e]) {
                    if(id!=_self && place_meeting(x,y,_self)) { _meeting=true;break }
                }
                if(_meeting) { _distance-=_step;break }
            }
            if(place_meeting(x,y,Wall)) { _distance-=_step;break }
            if(random(12*_count)<1) {
                var _dust=scrNTTEFullMergedStockFX(x,y,[direction,_step*lerp(0.5,0.2,_distance/_maximum)],Dust)
                /* NTTE DUST LIFETIME merged-laser */ if(instance_exists(_dust)) {_dust.sprite_index=sprNTTERefAllyLaserCharge;_dust.image_index=random(_dust.image_number)
                _dust.image_xscale=1;_dust.image_yscale=1 }
            }
        }
        if(!_meeting) _distance-=random(_max_distance/max(2,_count))
        x=_sx;y=_sy
        if(_distance>0) { x+=_dx*_distance;y+=_dy*_distance;xprevious=x;yprevious=y }
        if(random(_count)<3) {
            var _fx=scrNTTEFullMergedStockFX(x+orandom(12),y+orandom(12),1,PlasmaTrail)
            with(_fx) motion_add(other.direction,timescale)
        }
    }
}

function scrNTTEFullMergedMotionUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _frame=current_frame,_seed=random_get_seed(),_player=instance_find(Player,0),_index=_player.index,
        _aim_direction=KeyCont.dir_fire[_index],_aim_distance=KeyCont.dis_fire[_index],_particles=UberCont.opt_prtcls
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.crown=Crown.None;GameCont.underwater=false;current_frame=2
    UberCont.opt_prtcls=true
    try {
        scrNTTEFullMergedBasicInit();scrNTTEFullMergedExplosiveInit();scrNTTEFullMergedMotionInit()
        var _sticky=instance_create(85000,85000,Bullet1),_target=instance_create(85020,85000,NTTEBabyGator)
        _sticky.direction=0;_sticky.speed=4*timescale;_sticky.friction=0.2*timescale*timescale
        scrNTTEFullMergedProjectileAddEffect(_sticky,"sticky")
        scrNTTEFullMergedProjectileAddEffect(_sticky,"sticky")
        assert(array_length(_sticky.temerge_hit_event_ref_list)==1 && array_length(_sticky.temerge_wall_event_ref_list)==1,
            "Repeated sticky setup duplicated callbacks")
        var _mask=_sticky.mask_index,_sticky_start_x=_sticky.x
        _sticky.temerge_sticky_target=_target;_sticky.temerge_sticky_xoffset=3
        scrNTTEFullMergedStickyPostStep([_sticky])
        assert(abs(_sticky.x-(lerp(_sticky_start_x,_target.x+3,1-power(0.5,timescale))-4*timescale))<0.02
            && abs(_sticky.speed-(4*timescale+0.2*timescale*timescale))<0.0001 && _sticky.mask_index==mskNone,
            "Sticky follow lost interpolation/motion/mask: start="+string(_sticky_start_x)+" x="+string(_sticky.x)+" target="+string(_target.x)+" speed="+string(_sticky.speed)+" friction="+string(_sticky.friction)+" mask="+string(_sticky.mask_index))
        instance_destroy(_target,false);scrNTTEFullMergedStickyPostStep([_sticky])
        assert(_sticky.temerge_sticky_target==noone && _sticky.mask_index==_mask,"Sticky target death did not restore original collision mask")
        var _victim=instance_create(85300,85000,NTTEBabyGator),_ultra=instance_create(85300,85000,UltraBolt)
        _ultra.speed=0;scrNTTEFullMergedProjectileAddEffect(_ultra,"sticky")
        _mask=_ultra.mask_index
        scrNTTEFullMergedEffectsCall(_ultra,_victim,scrNTTEFullMergedStickyStick)
        assert(_ultra.temerge_sticky_target==_victim && !_ultra.canhurt && _ultra.mask_index==_mask
            && abs(_ultra.depth-_victim.depth)==1,"UltraBolt sticky contact lost target/depth or unique intact-mask/no-damage behavior")
        var _laser=instance_create(85600,85000,Laser),_wall=instance_create(85600,85000,Wall)
        _laser.speed=0;scrNTTEFullMergedProjectileAddEffect(_laser,"sticky")
        scrNTTEFullMergedEffectsCall(_laser,_wall,scrNTTEFullMergedStickyStick)
        assert(_laser.alarm[0]==-1 && _laser.mask_index==mskNone,"Sticky laser wall contact did not stop native growth and disable collision")

        var _pull=instance_create(86000,85000,Bullet1),_pulled=instance_create(86040,85000,NTTEBabyGator),
            _neutral=instance_create(86050,85000,NTTEBabyGator),_outside=instance_create(86100,85000,NTTEBabyGator)
        _pull.speed=0;_pull.damage=20;_pulled.team=team_enemy;_pulled.solid=false;_pulled.mask_index=mskNone
        _neutral.team=team_none;_outside.team=team_enemy
        scrNTTEFullMergedProjectileAddEffect(_pull,"pulling")
        scrNTTEFullMergedPullingStep([_pull])
        assert(_pulled.x==86038 && _neutral.x==86050 && _outside.x==86100 && !_pull.temerge_pulling_can_play_sound,
            "Pulling lost direct source displacement, masked target eligibility, neutral/radius exclusions or one-shot sound")
        scrNTTEFullMergedProjectileAddEffect(_pull,"pulling")
        assert(!_pull.temerge_pulling_can_play_sound,"Repeated pulling setup reset its one-shot sound")

        GameCont.temerge_rocket_frame=0
        var _rocket=instance_create(86500,85000,Bullet1)
        _rocket.creator=_player;_rocket.team=team_player;_rocket.speed=4*timescale;_rocket.friction=0.1*timescale*timescale
        _rocket.direction=0;_rocket.damage=30
        scrNTTEFullMergedProjectileAddEffect(_rocket,"rocket")
        scrNTTEFullMergedProjectileAddEffect(_rocket,"rocket",[2,2,2])
        assert(abs(_rocket.temerge_rocket_frame-3.75)<0.0001 && _rocket.temerge_rocket_max_speed_factor==4
            && _rocket.temerge_rocket_add_speed==3 && _rocket.temerge_rocket_hit_explosion_count==3
            && array_length(_rocket.temerge_hit_event_ref_list)==1,"Rocket setup lost initial logical delay, stacked factors/budget or unique callbacks")
        _rocket.temerge_rocket_frame=timescale
        scrNTTEFullMergedRocketStep([_rocket])
        assert(_rocket.temerge_rocket_is_active==true && abs(_rocket.speed-(4*timescale+3*timescale*timescale))<0.0001
            && array_length(_rocket.temerge_destroy_event_ref_list)==1 && _rocket.temerge_rocket_flame_sprite==sprNukeFlame
            && abs(_rocket.temerge_rocket_flame_xscale-1/3)<0.0001,"Rocket activation lost native acceleration, destroy sound ref or pre-thrust flame geometry")
        var _hit=instance_create(_rocket.x,_rocket.y,NTTEBabyGator),_explosions=instance_number(Explosion)
        _hit.team=team_enemy;_hit.hp=100;_hit.nexthurt=0;_hit.solid=false
        scrNTTEFullMergedEffectsCall(_rocket,_hit,scrNTTEFullMergedRocketHit)
        assert(_rocket.temerge_rocket_hit_explosion_count==2 && _rocket.temerge_rocket_is_active==true
            && instance_number(Explosion)==_explosions+1 && !_rocket.temerge_explosion_list[0].is_active,
            "Rocket impact lost actual explosion, shared-payload deactivation or remaining thruster budget")
        scrNTTEFullMergedEffectsCall(_rocket,_hit,scrNTTEFullMergedRocketHit)
        var _impact=instance_number(BulletHit)
        scrNTTEFullMergedEffectsCall(_rocket,_hit,scrNTTEFullMergedRocketHit)
        assert(_rocket.temerge_rocket_hit_explosion_count==0 && _rocket.temerge_rocket_is_active==-1
            && instance_number(Explosion)==_explosions+3 && instance_number(BulletHit)==_impact+1,
            "Rocket repeated impacts reactivated spent payloads or failed to stop thrust with native impact FX")

        // Reproduce the mobile RocketStep crash through its actual scheduler:
        // Smoke.Create destroys its own ID with particles off. The projectile
        // must still accelerate, and an already dead list member is discarded.
        assert(!instance_exists(GenCont),"Rocket optional-smoke regression requires the completed gameplay fixture")
        UberCont.opt_prtcls=false
        var _optional=instance_create(86600,85000,Bullet1),_stale=instance_create(86620,85000,Bullet1)
        _optional.creator=_player;_optional.team=team_player;_optional.speed=4*timescale
        _optional.friction=0.1*timescale*timescale;_optional.direction=0;_optional.damage=200/timescale
        scrNTTEFullMergedProjectileAddEffect(_optional,"rocket")
        _optional.temerge_rocket_frame=GameCont.temerge_rocket_frame+timescale
        instance_destroy(_stale,false)
        var _rocket_vars=scrNTTEFullMergedEffectVars("rocket"),_smoke_count=instance_number(Smoke),
            _clock=GameCont.temerge_rocket_frame,_optional_speed=_optional.speed,
            _rocket_scheduler=variable_struct_get(_rocket_vars.event_instance_map,"step")
        array_push(_rocket_vars.instance_list,_stale)
        with(_rocket_scheduler) scrNTTEFullMergedEffectSchedulerPhase("step")
        assert(instance_exists(_optional) && _optional.temerge_rocket_is_active==true
            && abs(_optional.speed-(_optional_speed+timescale*timescale))<0.0001
            && GameCont.temerge_rocket_frame==_clock+timescale && instance_number(Smoke)==_smoke_count
            && array_get_index(_rocket_vars.instance_list,_stale)<0,
            "Rejected Smoke instance or stale projectile stopped the real rocket scheduler/acceleration")

        // With particles enabled, the same guaranteed smoke branch retains the
        // source count and depth offset. No broad effect/physics fallback.
        UberCont.opt_prtcls=true
        var _smoke_before=scrNTTEFullInstances(Smoke)
        _optional_speed=_optional.speed
        scrNTTEFullMergedRocketStep([_stale,_optional])
        var _smoke_after=scrNTTEFullInstances(Smoke),_new_smoke=noone
        for(var _s=0;_s<array_length(_smoke_after);++_s)
            if(array_get_index(_smoke_before,_smoke_after[_s])<0) _new_smoke=_smoke_after[_s]
        assert(array_length(_smoke_after)==array_length(_smoke_before)+1 && instance_exists(_new_smoke)
            && (_new_smoke.depth==_optional.depth-1 || _new_smoke.depth==_optional.depth-2)
            && abs(_optional.speed-(_optional_speed+timescale*timescale))<0.0001,
            "Enabled rocket smoke lost source single spawn/depth or changed projectile thrust")
        UberCont.opt_prtcls=_particles

        _player.x=87000;_player.y=85000;KeyCont.dir_fire[_index]=90;KeyCont.dis_fire[_index]=100
        var _guided=instance_create(_player.x,_player.y,Bullet1)
        _guided.direction=0;_guided.speed=12*timescale;_guided.image_angle=0
        scrNTTEFullMergedProjectileAddEffect(_guided,"guiding",[_index])
        scrNTTEFullMergedGuidingStep([_guided])
        assert(abs(_guided.direction-7.5*timescale)<0.0001 && abs(_guided.image_angle-_guided.direction)<0.0001
            && _guided.x<_player.x,"Guiding lost original turn/position curvature or native per-player aim coordinates")
        _guided.temerge_rocket_is_active=-1
        var _direction=_guided.direction
        scrNTTEFullMergedGuidingStep([_guided])
        assert(_guided.direction==_direction,"Stopped rocket was still guided")

        var _hitscan=instance_create(87500,85000,Bullet1),_near=instance_create(87540,85000,NTTEBabyGator),
            _far=instance_create(87590,85000,Wall)
        _hitscan.team=team_player;_hitscan.direction=0;_hitscan.speed=8*timescale;_near.team=team_enemy;_near.solid=false
        scrNTTEFullMergedProjectileAddEffect(_hitscan,"laser",[128])
        assert(_hitscan.x>87500 && _hitscan.x<87540 && _hitscan.xprevious==_hitscan.x && _hitscan.yprevious==_hitscan.y,
            "Laser hitscan did not stop just before the first native enemy ahead of a farther wall")
        var _blocked=false
        with(_hitscan) _blocked=place_meeting(x,y,_near)
        assert(!_blocked,"Laser hitscan returned an overlapping enemy position rather than its previous sample")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        KeyCont.dir_fire[_index]=_aim_direction;KeyCont.dis_fire[_index]=_aim_distance
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        UberCont.opt_prtcls=_particles
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED MOTION: native attachment/mask restore/UltraBolt/laser, literal pulling, stacked thrust/impact payloads, mobile-aware guidance and real hitscan contact OK @"+string(30/timescale))
}
