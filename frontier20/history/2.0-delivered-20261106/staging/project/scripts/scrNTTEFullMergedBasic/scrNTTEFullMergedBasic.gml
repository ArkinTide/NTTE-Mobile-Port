// temerge.mod.gml2667..2933,3417..3485. No native projectile_create
// replacement: telib981 adds motion and preserves constructor direction.
function scrNTTEFullMergedBasicInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_basic_events_ready",false)) return;
    _registry.ntte_basic_events_ready=true
    scrNTTEFullMergedEffectAddEvent("trail","setup",scrNTTEFullMergedTrailSetup)
    scrNTTEFullMergedEffectAddEvent("trail","end_step",scrNTTEFullMergedTrailEndStep)
    scrNTTEFullMergedEffectAddEvent("flame","setup",scrNTTEFullMergedFlameSetup)
    scrNTTEFullMergedEffectAddEvent("flame","step",scrNTTEFullMergedFlameStep)
    scrNTTEFullMergedEffectAddEvent("flame_trail","setup",scrNTTEFullMergedFlameTrailSetup)
    scrNTTEFullMergedEffectAddEvent("flame_trail","step",scrNTTEFullMergedFlameTrailStep)
    scrNTTEFullMergedEffectAddEvent("toxic","setup",scrNTTEFullMergedToxicSetup)
    scrNTTEFullMergedEffectAddEvent("seeking","setup",scrNTTEFullMergedSeekingSetup)
    scrNTTEFullMergedEffectAddEvent("seeking","step",scrNTTEFullMergedSeekingStep)
}
function scrNTTEFullMergedBasicProjectileInit(_instance,_team,_creator) {
    if(!instance_exists(_instance)) return;
    // Recovered NTT ref_projectile_init005e9910: source ownership plus a
    // sub-30Hz-step launch correction. This telib entry intentionally keeps
    // that original formula; the port's separately approved native firing
    // entry scr_projectile_create has its own 0.75 lead policy.
    _instance.team=_team;_instance.creator=_creator
    if(timescale<1-0.0000000001) with(_instance) {
        var _lead=speed*(1/timescale-1)
        x+=lengthdir_x(_lead,direction);y+=lengthdir_y(_lead,direction)
    }
    if(instance_exists(_creator)) scrNTTEFullActorDamageMetadata(_instance,_creator)
}
function scrNTTEFullMergedBasicProjectileCreate(_x,_y,_object,_direction=0,_speed=0) {
    var _source=id,_instance=(_object==Lightning || _object==EnemyLightning)
        ?scrNTTEFullMergedLightningCreateNode(_x,_y,_object):instance_create(_x,_y,_object)
    if(!instance_exists(_instance)) return noone
    var _team=scrNTTEFullValue(_source,"team",scrNTTEFullValue(_instance,"team",team_none)),
        _creator=variable_instance_exists(_source,"creator") && !instance_is(_source,hitme)?_source.creator:_source,
        _hitid=scrNTTEFullValue(_source,"hitid",HitId.None)
    with(_instance) {
        direction+=_direction
        if(_speed!=0) motion_add(_direction,_speed*timescale)
        image_angle+=direction
    }
    scrNTTEFullMergedBasicProjectileInit(_instance,_team,_creator)
    scrNTTEFullActorDamageMetadata(_instance,_source)
    if(variable_instance_exists(_instance,"hitid") && _hitid!=HitId.None) _instance.hitid=_hitid
    return _instance
}
function scrNTTEFullMergedTrailSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(variable_instance_exists(id,"temerge_trail_color")) continue
        temerge_trail_color=c_white;temerge_trail_delay=2
        temerge_trail_is_sprite=!(instance_is(id,Grenade) || instance_is(id,HyperGrenade) || instance_is(id,Rocket)
            || instance_is(id,Nuke) || instance_is(id,Bolt) || instance_is(id,HeavyBolt) || instance_is(id,UltraBolt)
            || instance_is(id,Seeker) || instance_is(id,Disc))
        switch(object_index) {
            case BloodGrenade:temerge_trail_color=make_color_rgb(174,58,45);break;
            case ToxicGrenade:case UltraGrenade:temerge_trail_color=make_color_rgb(190,253,8);break;
            case ConfettiBall:temerge_trail_color=scrNTTEFullValue(id,"mycol",image_blend);break;
        }
    }
}
function scrNTTEFullMergedTrailEndStep(_instances) {
    var _underwater=GameCont.underwater
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].speed>0) with(_instances[_i]) {
        if(temerge_trail_delay>0) temerge_trail_delay-=timescale
        else {
            var _trail=instance_create(xprevious,yprevious,BoltTrail)
            _trail.image_xscale=point_distance(_trail.x,_trail.y,x,y)
            _trail.image_angle=point_direction(_trail.x,_trail.y,x,y);_trail.creator=creator
            if(temerge_trail_is_sprite) {
                _trail.sprite_index=sprite_index;_trail.image_index=image_index;_trail.image_speed=0
                _trail.image_xscale/=1+sprite_width/2
                _trail.image_yscale=image_yscale/2;_trail.image_blend=image_blend
            }
            else _trail.image_blend=temerge_trail_color
            // chance_ct1/4 is the source linear logical-time probability.
            if(_underwater && random(4)<timescale) instance_create(x,y,Bubble)
        }
    }
}
function scrNTTEFullMergedFlameSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_flame")) {
            temerge_flame={amount:0}
            scrNTTEFullMergedProjectileAddEvent(id,"destroy",scrNTTEFullMergedFlameDestroy)
        }
        temerge_flame.amount+=1
    }
}
function scrNTTEFullMergedFlameStep(_instances) {
    var _remaining=_instances
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(speed<5*timescale && friction>0) {
            _remaining=scrNTTEFullMergedEffectsRemove(_remaining,id)
            scrNTTEFullMergedFlameDestroy();temerge_flame.amount=0
        }
    }
    return _remaining
}
function scrNTTEFullMergedFlameDestroy() {
    if(temerge_flame.amount>0) repeat(temerge_flame.amount)
        scrNTTEFullMergedBasicProjectileCreate(x,y,Flame,speed==0?random(360):direction,max(1.5,speed/timescale/2))
}
function scrNTTEFullMergedFlameTrailSetup(_instances,_amount=1) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_flame_trail_amount")) {
            temerge_flame_trail_amount=0;temerge_flame_trail_angle=random(360)
            // Literal source2803 registers on the WHOLE input list for each
            // newly initialized projectile. This intentionally stacks refs.
            scrNTTEFullMergedProjectileAddEvent(_instances,"hit",scrNTTEFullMergedFlameTrailHit)
        }
        temerge_flame_trail_amount+=_amount
    }
}
function scrNTTEFullMergedFlameTrailStep(_instances) {
    var _last_sprite=-1,_last_yscale=1,_flame_scale=1
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!((current_frame%damage)>=1)) continue
        if(sprite_index!=_last_sprite || image_yscale!=_last_yscale) {
            _last_sprite=sprite_index
            // Source NTT bbox maximum is inclusive; Epsilon native is exclusive.
            _flame_scale=(sprite_get_bbox_bottom(sprite_index)-sprite_get_bbox_top(sprite_index))*image_yscale/16
            if(_flame_scale>=0.375 && _flame_scale<1) _flame_scale=1
        }
        // Nonpositive source scales cannot advance the original length loop.
        // Fail explicitly instead of hanging the game or inventing a scale.
        if(_flame_scale<=0) throw "Merged flame trail has a nonpositive source sprite scale"
        for(var _length=0;_length<=speed;_length+=8*_flame_scale) {
            var _source=id,_flame=instance_create(x+lengthdir_x(_length,direction),y+lengthdir_y(_length,direction),Flame)
            if(!instance_exists(_flame)) continue
            with(_flame) {
                motion_add(_source.temerge_flame_trail_angle,(_source.temerge_flame_trail_amount+random(1))*timescale)
                image_index=max(0,(image_number-1)-(1+_source.damage))
                image_xscale*=_flame_scale;image_yscale*=_flame_scale
            }
            // Deliberately creator=source projectile, as projectile_init(team,other).
            scrNTTEFullMergedBasicProjectileInit(_flame,team,id)
            if(temerge_flame_trail_amount>1) {
                var _direction_offset=0
                repeat(temerge_flame_trail_amount-1) {
                    _direction_offset+=360/temerge_flame_trail_amount
                    with(_flame) with(scrNTTEFullMergedNativeCopy(false)) direction+=_direction_offset
                }
            }
        }
        // Original2830 runs each Step without current_frame_active or a
        // timescale multiplier. Preserve that literal rotation/gating rule.
        temerge_flame_trail_angle+=36/temerge_flame_trail_amount
    }
}
function scrNTTEFullMergedFlameTrailHit() {
    if(scrNTTEFullMergedProjectileCanHit(other.id) && current_frame_active)
        repeat(5*temerge_flame_trail_amount)
            scrNTTEFullMergedBasicProjectileCreate(x,y,Flame,random(360),random_range(2,3)*temerge_flame_trail_amount)
}
function scrNTTEFullMergedToxicSetup(_instances) {
    scrNTTEFullMergedProjectileAddEvent(_instances,"destroy",scrNTTEFullMergedToxicDestroy)
}
function scrNTTEFullMergedBasicSoundAt(_x,_y,_sound,_pitch,_gain,_fade) {
    if(variable_global_exists("ntte_full_merged_basic_sound_observer") && is_array(global.ntte_full_merged_basic_sound_observer))
        array_push(global.ntte_full_merged_basic_sound_observer,{x:_x,y:_y,sound:_sound,pitch:_pitch,gain:_gain,fade:_fade})
    if(scr_test_is_fps_uncapped() || !audio_exists(_sound)) return -1
    var _listen_x=view_xview+view_width/2,_listen_y=view_yview+view_height/2,_best=infinity
    with(Player) {
        var _distance=point_distance(x,y,_x,_y)
        if(_distance<_best) { _best=_distance;_listen_x=x;_listen_y=y }
    }
    _sound=custom_sound_check(_sound);audio_stop_sound(_sound)
    var _snd=audio_play_sound_at(_sound,_listen_x-_x,_listen_y-_y,0,_fade,320,1,false,0)
    if(_snd>=0) {
        audio_sound_pitch(_snd,_pitch);audio_sound_gain(_snd,_gain*UberCont.opt_sndvol*audio_sound_get_gain(_snd),0)
    }
    return _snd
}
function scrNTTEFullMergedToxicDestroy() {
    var _number=min(damage*2/3,640)
    _number=floor(_number)+(random(1)<frac(_number))
    if(_number>0) {
        // Direct native creation deliberately retains ToxicGas's neutral team.
        repeat(_number) instance_create(x,y,ToxicGas)
        scrNTTEFullMergedBasicSoundAt(x,y,sndToxicBoltGas,max(0.6,1.2-0.0125*_number)+orandom(0.1),0.2+0.05*_number,320)
        repeat(ceil(_number/3)) scrNTTEFullMergedStockFX(x,y,random(sqrt(_number)/2),Smoke)
    }
}
function scrNTTEFullMergedSeekingSetup(_instances) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_seeking_strength")) temerge_seeking_strength=0
        temerge_seeking_strength+=1
    }
}
function scrNTTEFullMergedSeekingCandidates() {
    var _families=[enemy,Player,Ally,Sapling,SentryGun],_out=[]
    if(!variable_global_exists("ntte_full_merged_basic_custom_hitme")) scrNTTEFullMergedBasicClasses()
    for(var _i=0;_i<array_length(global.ntte_full_merged_basic_custom_hitme);++_i)
        array_push(_families,global.ntte_full_merged_basic_custom_hitme[_i])
    for(var _f=0;_f<array_length(_families);++_f) {
        var _instances=scrNTTEFullInstances(_families[_f])
        for(var _i=0;_i<array_length(_instances);++_i) {
            var _candidate=_instances[_i]
            if(_candidate.team!=team_none && _candidate.mask_index!=mskNone && array_get_index(_out,_candidate)<0)
                array_push(_out,_candidate)
        }
    }
    return _out
}
function scrNTTEFullMergedSeekingTarget(_x,_y,_candidates,_team) {
    var _target=noone,_best=infinity
    for(var _i=0;_i<array_length(_candidates);++_i) {
        var _candidate=_candidates[_i]
        if(!scrNTTEAimTargetAllowed(_candidate,_team)) continue
        var _distance=point_distance(_x,_y,_candidate.x,_candidate.y)
        if(_distance<_best) { _best=_distance;_target=_candidate }
    }
    return _target
}
function scrNTTEFullMergedSeekingStep(_instances) {
    var _candidates=scrNTTEFullMergedSeekingCandidates()
    if(!array_length(_candidates)) return;
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i]) && _instances[_i].speed!=0) with(_instances[_i]) {
        var _turn=orandom(speed/4),_target=scrNTTEFullMergedSeekingTarget(x+6*hspeed/timescale,y+6*vspeed/timescale,_candidates,team)
        if(instance_exists(_target) && !collision_line(x,y,_target.x,_target.y,Wall,false,false)) {
            var _add=angle_difference(point_direction(x,y,_target.x,_target.y),direction),
                _maximum=3*(abs(_add)/(abs(_add)+30))*temerge_seeking_strength*timescale,_distance=infinity
            _distance=distance_to_object(_target)
            if(_distance<6*speed/timescale) {
                _maximum*=2
                if(instance_is(id,Nuke)) index=-1
            }
            _turn+=clamp(_add,-_maximum,_maximum)
        }
        direction+=_turn;image_angle+=_turn
    }
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if((object_index!=Laser && object_index!=EnemyLaser) || speed!=0) continue
        var _target=scrNTTEFullMergedSeekingTarget(x,y,_candidates,team)
        if(instance_exists(_target) && !collision_line(xstart,ystart,_target.x,_target.y,Wall,false,false)) {
            var _length=min(4*temerge_seeking_strength*timescale,point_distance(x,y,_target.x,_target.y)),
                _direction=point_direction(x,y,_target.x,_target.y)
            x+=lengthdir_x(_length,_direction);y+=lengthdir_y(_length,_direction)
            image_angle=point_direction(xstart,ystart,x,y);image_xscale=point_distance(xstart,ystart,x,y)/2
        }
    }
}

function scrNTTEFullMergedBasicUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _sounds=variable_global_exists("ntte_full_merged_basic_sound_observer")?global.ntte_full_merged_basic_sound_observer:undefined,
        _frame=current_frame,_particles=UberCont.opt_prtcls,_seed=random_get_seed()
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_full_merged_basic_sound_observer=[]
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    GameCont.underwater=false;UberCont.opt_prtcls=true;current_frame=2
    try {
        scrNTTEFullMergedBasicInit()
        var _owner=instance_find(Player,0),_source=instance_create(76000,76000,Bullet1)
        _source.creator=_owner;_source.team=team_player;_source.hitid=HitId.Toxin
        _source.direction=0;_source.speed=4*timescale;_source.friction=0.25*timescale*timescale
        var _flames=instance_number(Flame)
        scrNTTEFullMergedProjectileAddEffect(_source,"flame")
        scrNTTEFullMergedProjectileAddEffect(_source,"flame")
        assert(_source.temerge_flame.amount==2 && array_length(_source.temerge_destroy_event_ref_list)==1,
            "Flame setup must stack amount but register its destroy callback once")
        var _copy=noone
        with(_source) _copy=scrNTTEFullMergedNativeCopy(false)
        scrNTTEFullMergedEffectsDiscoverCopies("flame");scrNTTEFullMergedEffectsDiscoverCopies("destroy_event")
        // GML struct equality is not a portable reference-identity test.
        // Observe mutation through both fields, which is the source contract:
        // releasing either copied projectile must consume one shared amount.
        _source.temerge_flame.amount=7
        assert(_copy.temerge_flame.amount==7,"Copy(false) source-to-copy flame struct mutation is not shared")
        _copy.temerge_flame.amount=2
        assert(_source.temerge_flame.amount==2,"Copy(false) copy-to-source flame struct mutation is not shared")
        var _flame_step=scrNTTEFullMergedEffectVars("flame").event_instance_map.step
        with(_flame_step) event_perform(ev_step,ev_step_normal)
        assert(instance_number(Flame)==_flames+2 && _source.temerge_flame.amount==0 && _copy.temerge_flame.amount==0
            && !scrNTTEFullMergedProjectileHasEffect(_source,"flame") && !scrNTTEFullMergedProjectileHasEffect(_copy,"flame"),
            "Early flame release lost speed threshold, source/copy shared amount or effect-list removal")
        var _checked_flames=0
        with(Flame) if(array_get_index(_before,id)<0 && x>=76000 && x<76003 && y==76000) {
            ++_checked_flames
            assert(team==team_player && creator==_owner && hitid==HitId.Toxin && abs(speed-2*timescale)<0.0001
                && abs(x-(76000+2*max(0,1-timescale)))<0.0001,
                "Released flame lost source ownership, motion or recovered original launch correction")
        }
        assert(_checked_flames==2,"Native launch-corrected flame ownership/position assertions did not observe both flames")
        instance_destroy(_source,false);instance_destroy(_copy,false)
        var _destroy_vars=scrNTTEFullMergedEffectVars("destroy_event")
        scrNTTEFullMergedEffectsReplayDestroy(_destroy_vars)
        assert(instance_number(Flame)==_flames+2,"Already released source/copy emitted flame again on destruction")

        var _bolt=instance_create(76300,76000,HeavyBolt),_trail_count=instance_number(BoltTrail)
        _bolt.creator=_owner;_bolt.speed=4*timescale;_bolt.xprevious=_bolt.x-10;_bolt.yprevious=_bolt.y
        scrNTTEFullMergedProjectileAddEffect(_bolt,"trail")
        assert(!_bolt.temerge_trail_is_sprite && _bolt.temerge_trail_delay==2,"Trail setup lost HeavyBolt ancestor exclusion")
        var _trail_scheduler=scrNTTEFullMergedEffectVars("trail").event_instance_map.end_step
        repeat(round(2/timescale)) with(_trail_scheduler) event_perform(ev_step,ev_step_end)
        assert(instance_number(BoltTrail)==_trail_count && _bolt.temerge_trail_delay<=0,"Trail initial delay lost logical timing")
        _bolt.temerge_trail_color=c_lime
        scrNTTEFullMergedProjectileAddEffect(_bolt,"trail")
        with(_trail_scheduler) event_perform(ev_step,ev_step_end)
        assert(instance_number(BoltTrail)==_trail_count+1 && _bolt.temerge_trail_color==c_lime,
            "Repeated trail setup reset delay/color or failed to emit actual BoltTrail")
        var _trail=noone
        with(BoltTrail) if(array_get_index(_before,id)<0 && x==_bolt.xprevious && y==_bolt.yprevious) _trail=id
        assert(instance_exists(_trail) && _trail.image_xscale==10 && _trail.image_angle==0 && _trail.creator==_owner
            && _trail.image_blend==c_lime,"Trail lost previous position, streak geometry, creator or explicit color")
        var _sprite=instance_create(76500,76000,Bullet1)
        _sprite.creator=_owner;_sprite.speed=timescale;_sprite.image_yscale=2;_sprite.image_blend=c_red
        _sprite.xprevious=_sprite.x-8;_sprite.yprevious=_sprite.y
        scrNTTEFullMergedProjectileAddEffect(_sprite,"trail");_sprite.temerge_trail_delay=0
        scrNTTEFullMergedTrailEndStep([_sprite])
        _trail=noone
        with(BoltTrail) if(array_get_index(_before,id)<0 && x==_sprite.xprevious && y==_sprite.yprevious) _trail=id
        assert(instance_exists(_trail) && _trail.sprite_index==_sprite.sprite_index && _trail.image_yscale==1
            && _trail.image_index==_sprite.image_index && _trail.image_speed==0 && _trail.image_blend==c_red
            && abs(_trail.image_xscale-8/(1+_sprite.sprite_width/2))<0.0001,"Sprite trail lost native sprite/scale/frame/color")
        var _confetti=instance_create(76600,76000,ConfettiBall)
        scrNTTEFullMergedProjectileAddEffect(_confetti,"trail")
        assert(_confetti.temerge_trail_color==_confetti.image_blend,"Native confetti color alias did not match source mycol")

        var _trail_a=instance_create(77000,76000,Bullet1),_trail_b=instance_create(77200,76000,Bullet1)
        _trail_a.creator=_owner;_trail_b.creator=_owner;_trail_a.team=team_player;_trail_b.team=team_player
        _trail_a.speed=0;_trail_b.speed=0;_trail_a.damage=3;_trail_b.damage=3
        scrNTTEFullMergedProjectileAddEffect([_trail_a,_trail_b],"flame_trail",[2])
        var _angle=_trail_a.temerge_flame_trail_angle
        scrNTTEFullMergedProjectileAddEffect(_trail_a,"flame_trail",[1])
        assert(_trail_a.temerge_flame_trail_amount==3 && _trail_b.temerge_flame_trail_amount==2
            && array_length(_trail_a.temerge_hit_event_ref_list)==2 && array_length(_trail_b.temerge_hit_event_ref_list)==2
            && _trail_a.temerge_flame_trail_angle==_angle,
            "Flame trail setup lost whole-list duplicate refs, stacking or persistent initial angle")
        _flames=instance_number(Flame)
        scrNTTEFullMergedFlameTrailStep([_trail_a])
        assert(instance_number(Flame)==_flames+3 && abs(_trail_a.temerge_flame_trail_angle-(_angle+12))<0.0001,
            "Flame trail copy count, zero-speed initial emitter or literal Step rotation changed")
        _checked_flames=0
        with(Flame) if(array_get_index(_before,id)<0 && point_distance(x,y,_trail_a.x,_trail_a.y)<4) {
            ++_checked_flames
            assert(creator==_trail_a && team==team_player,"Flame trail changed explicit source-projectile creator to player owner")
        }
        assert(_checked_flames==3,"Native launch-corrected trail creator assertions did not observe every copied flame")
        var _victim=instance_create(_trail_b.x,_trail_b.y,NTTEBabyGator)
        _victim.team=team_enemy;_victim.hp=100;_victim.nexthurt=0
        _flames=instance_number(Flame)
        scrNTTEFullMergedProjectileEvent(_trail_b,_victim,"hit")
        assert(instance_number(Flame)==_flames+20,
            "Actual flame trail hit lost 5*amount flames for each original whole-list callback")

        var _gas_source=instance_create(77500,76000,Bullet1),_gas=instance_number(ToxicGas),_smoke=instance_number(Smoke)
        _gas_source.damage=6;_gas_source.speed=0;_gas_source.team=team_player;_gas_source.creator=_owner
        scrNTTEFullMergedProjectileAddEffect(_gas_source,"toxic")
        scrNTTEFullMergedProjectileAddEffect(_gas_source,"toxic")
        assert(array_length(_gas_source.temerge_destroy_event_ref_list)==2,"Toxic setup incorrectly deduplicated destruction callbacks")
        instance_destroy(_gas_source,false)
        scrNTTEFullMergedEffectsReplayDestroy(_destroy_vars)
        assert(instance_number(ToxicGas)==_gas+8 && instance_number(Smoke)==_smoke+4
            && array_length(global.ntte_full_merged_basic_sound_observer)==2,"Toxic destruction lost stacked gas/smoke/sound counts")
        with(ToxicGas) if(array_get_index(_before,id)<0 && x==77500 && y==76000)
            assert(team==team_none && creator==noone,"Direct ToxicGas creation acquired incorrect projectile ownership")
        var _sound=global.ntte_full_merged_basic_sound_observer[0]
        assert(_sound.sound==sndToxicBoltGas && _sound.fade==320 && abs(_sound.gain-0.4)<0.0001
            && _sound.pitch>=1.05 && _sound.pitch<=1.25,"Toxic release source spatial sound pitch/gain/falloff changed")

        var _seeker=instance_create(79000,79000,Bullet1),_friendly=instance_create(79010,79000,NTTEBabyGator),
            _hostile=instance_create(79030,78970,NTTEBabyGator)
        _friendly.team=team_player;_friendly.ntte_charmed=true;_hostile.team=team_enemy
        _seeker.team=team_player;_seeker.creator=_owner;_seeker.direction=0;_seeker.image_angle=0;_seeker.speed=4*timescale
        repeat(3) scrNTTEFullMergedProjectileAddEffect(_seeker,"seeking")
        assert(_seeker.temerge_seeking_strength==3,"Seeking strength did not stack source setup")
        assert(scrNTTEFullMergedSeekingTarget(_seeker.x,_seeker.y,[_friendly,_hostile],team_player)==_hostile,
            "Seeking selected a closer friendly/charmed unit")
        scrNTTEFullMergedSeekingStep([_seeker])
        assert(_seeker.direction>0 && _seeker.direction<10 && abs(angle_difference(_seeker.image_angle,_seeker.direction))<0.0001,
            "Moving projectile seeking lost logical lookahead, friendly filter, signed turn or visual turn")
        var _laser=instance_create(79400,79000,Laser),_laser_foe=instance_create(79400,78980,NTTEBabyGator)
        _laser.team=team_player;_laser.speed=0;_laser.xstart=_laser.x-10;_laser.ystart=_laser.y;_laser_foe.team=team_enemy
        scrNTTEFullMergedProjectileAddEffect(_laser,"seeking")
        scrNTTEFullMergedSeekingStep([_laser])
        assert(abs(_laser.x-79400)<0.0001 && abs(_laser.y-(79000-4*timescale))<0.0001
            && abs(_laser.image_xscale-point_distance(_laser.xstart,_laser.ystart,_laser.x,_laser.y)/2)<0.0001,
            "Zero-speed laser seeking lost source endpoint motion or start-to-end drawing geometry")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_full_merged_basic_sound_observer=_sounds
        current_frame=_frame;UberCont.opt_prtcls=_particles;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL MERGED BASIC EFFECTS: real flames/copy/early release, source trail geometry, whole-list hit stacking, actual toxic destroy replay and friendly-aware seeking/laser endpoint OK @"+string(30/timescale))
}

function scrNTTEFullMergedBasicClasses() {
    global.ntte_full_merged_basic_custom_hitme=[NTTEFullBigPipe, NTTEFullCatDoor, NTTEFullCoastBossBecome, NTTEFullCreature, NTTEFullPet, NTTEFullPizzaRubble, NTTEFullSawTrap, NTTEFullSealMine, NTTEFullSewerDrain, NTTEFullTurtleCool];
}
