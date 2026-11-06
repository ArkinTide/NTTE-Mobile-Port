// Original five Oasis weapon entries, not the generic NTTEAttack facsimiles.
// Source weapon_post(kick,shift,shake) maps to the modern directional helper.
function scrNTTEFullBubbleWeaponIs(_weapon) {
    return _weapon==wep_ntte_bubble_rifle || _weapon==wep_ntte_bubble_minigun
        || _weapon==wep_ntte_bubble_shotgun || _weapon==wep_ntte_bubble_cannon
        || _weapon==wep_ntte_hyper_bubbler
}
function scrNTTEFullBubbleWeaponPop(_length,_scale,_animation=0.4,_index=1) {
    var _pop=instance_create(x+lengthdir_x(_length,gunangle),y+lengthdir_y(_length,gunangle),NTTEFullBubblePop)
    _pop.image_index=_index;_pop.image_speed=_animation*timescale
    _pop.image_xscale=_scale;_pop.image_yscale=_scale;_pop.image_angle=random(360);_pop.depth=-1
    return _pop
}
function scrNTTEFullBubbleWeaponOne(_weapon,_primary=true) {
    var _direction=gunangle,_shot=noone,_pitch=1
    switch(_weapon) {
        case wep_ntte_bubble_rifle:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleBomb,_direction+orandom(12*accuracy),9)
            with(_shot) move_contact_solid(_direction,6)
            _pitch=random_range(0.8,1.2)
            snd_play(sndOasisCrabAttack,1.6*_pitch);snd_play(sndOasisExplosionSmall,0.7*_pitch)
            snd_play(sndToxicBoltGas,0.8*_pitch);snd_play(sndBouncerBounce,1.2*_pitch)
            scr_weapon_post(_direction,-5,10,5);scrNTTEFullBubbleWeaponPop(14,0.8)
            break
        case wep_ntte_bubble_minigun:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleBomb,_direction+orandom(6*accuracy),10+random(2))
            with(_shot) move_contact_solid(_direction,6)
            _pitch=random_range(0.8,1.2)
            snd_play(sndOasisCrabAttack,0.7*_pitch);snd_play(sndSuperSplinterGun,1.4*_pitch)
            snd_play(sndOasisExplosionSmall,0.7*_pitch)
            scr_weapon_post(_direction,-5,10,5);scrNTTEFullNativeMotionAddFT(id,_direction+180,0.5)
            break
        case wep_ntte_bubble_shotgun:
            for(var _i=0;_i<5;++_i) {
                _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleBomb,_direction+orandom(12*accuracy),random_range(9,10))
                with(_shot) {
                    move_contact_solid(_direction,6+_i*8)
                    image_speed+=irandom_range(-2,2)/50*timescale
                }
                _shot.primary=_primary
            }
            _pitch=random_range(0.8,1.2)
            snd_play(sndOasisCrabAttack,0.7*_pitch);snd_play(sndOasisExplosionSmall,0.8*_pitch)
            snd_play(sndToxicBoltGas,0.8*_pitch);snd_play(sndHyperRifle,1.5*_pitch)
            scr_weapon_post(_direction,-5,10,6);scrNTTEFullBubbleWeaponPop(14,0.8)
            break
        case wep_ntte_bubble_cannon:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleBomb,_direction+orandom(6*accuracy),9)
            with(_shot) {move_contact_solid(_direction,7);big=true}
            _pitch=random_range(0.8,1.2)
            snd_play(sndOasisCrabAttack,1.4*_pitch);snd_play(sndOasisExplosionSmall,0.5*_pitch)
            snd_play(sndToxicBoltGas,0.7*_pitch);snd_play(sndToxicBarrelGas,0.8*_pitch)
            snd_play(sndOasisPortal,0.6*_pitch);snd_play(sndPlasmaMinigunUpg,0.4*_pitch)
            scr_weapon_post(_direction,-12,32,10);scrNTTEFullNativeMotionAddFT(id,_direction+180,4)
            scrNTTEFullBubbleWeaponPop(12,1.2,0.25)
            for(var _i=-1;_i<=1;++_i) {
                var _streak=instance_create(x,y,NTTEFullWaterStreak)
                with(_streak) {
                    motion_set(_direction+(_i*24+orandom(8))*other.accuracy,(2+random(4))*timescale)
                    y+=vspeed/timescale;image_angle=_direction;image_speed+=orandom(0.2)*timescale
                }
            }
            break
        case wep_ntte_hyper_bubbler:
            _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullHyperBubble,_direction+orandom(3*accuracy))
            with(_shot) {x+=lengthdir_x(20,direction);y+=lengthdir_y(20,direction)}
            scrNTTEFullDiscWeaponSound(sndPlasmaRifle,0.9+random(0.3),1)
            scrNTTEFullDiscWeaponSound(sndHyperSlugger,0.9+random(0.3),0.6)
            scr_weapon_post(_direction,20,5,10);scrNTTEFullNativeMotionAddFT(id,_direction+180,4);sleep(35)
            break
    }
    if(instance_exists(_shot)) _shot.primary=_primary
    return _shot
}
function scrNTTEFullNativeFireBurstCreate() {
    // Real projectileburst descendant, hence captured/remounted by the shared
    // native runtime, but source FireBurst is a Step accumulator, not Alarm0.
    alarm[0]=-1;visible=false;time=0;time_max=0;ammo=0;burst=0;primary=true
    wep=wep_none;accuracy=1;callback=undefined;context=undefined;explicit_interval=0
}
function scrNTTEFullNativeFireBurstInvoke(_owner,_x,_y,_angle,_weapon,_primary,_team,_accuracy,_callback,_context,_burst) {
    if(instance_is(_owner,Player)) with(_owner) {
        var _old_team=team,_old_accuracy=accuracy,_old_angle=gunangle,_old_x=x,_old_y=y,
            _old_spec=scrNTTEFullValue(id,"specfiring",false),_swap=!_primary
        if(_swap) {scrSwapWeps(false);specfiring=true}
        team=_team;accuracy=_accuracy;gunangle=_angle;x=_x;y=_y
        try {_callback(_weapon,_primary,_burst,_context)}
        finally {
            x=_old_x;y=_old_y;gunangle=_old_angle
            if(team==_team) team=_old_team
            if(accuracy==_accuracy) accuracy=_old_accuracy
            else if(_accuracy!=0) accuracy=_old_accuracy*(accuracy/_accuracy)
            if(_swap) {specfiring=_old_spec;scrSwapWeps(false)}
        }
    }
    else {
        // Source non-Player FireBurst uses player_fire_ext(...wep_none...),
        // whose temporary FireCont/Fish context must not read NPC-only fields.
        // As ActorFire, Player.Create alone does not register a game player.
        // This token is consumed in finally before this same event returns;
        // the delayed controller never retains it between Step events.
        var _before=scrNTTEFullMergedCaptureBegin(),_proxy=noone,_source=id
        try {
            _proxy=instance_create(_x,_y,Player)
            with(_proxy) {
                visible=false;persistent=false;can_walk=false;can_spec=false;can_aim=false
                is_me=false;race=Race.Fish;bskin=-1;index=scrNTTEFullValue(_owner,"index",0)
                team=_team;hitid=scrNTTEFullValue(_owner,"hitid",[sprMutant1Idle,""])
                ntte_actor_fire_creator=_owner
                gunangle=_angle;accuracy=_accuracy;infammo=1;wep=_weapon;bwep=wep_none
                ntte_state=scrNTTENewState(_weapon);ntte_actor_accuracy=_accuracy;ntte_actor_angle=_angle
                scrNTTEFullActorDamageMetadata(id,_source)
                _callback(_weapon,_primary,_burst,_context)
            }
        } finally {
            var _new=scrNTTEFullMergedRuntimeNew(_before)
            // A failed constructor never assigned a real proxy identity. The
            // token still closes, without adopting unrelated noone-owned births.
            for(var _i=0;_proxy!=noone && _i<array_length(_new);++_i) {
                var _inst=_new[_i]
                if(instance_exists(_inst) && variable_instance_exists(_inst,"creator") && _inst.creator==_proxy) {
                    _inst.creator=_owner;_inst.team=_team;scrNTTEFullActorDamageMetadata(_inst,_source)
                }
            }
            if(instance_exists(_proxy)) instance_destroy(_proxy,false)
        }
    }
}
function scrNTTEFullNativeFireBurstStep() {
    if(lockstep_stop) return;
    if(!(time>0 && ammo!=0)) {instance_destroy();return;}
    var _event=scrNTTEFullMergedRuntimeEventBegin()
    try {
        var _mount=scrNTTEFullMergedRuntimeMountedEventBegin()
        try {
            time-=timescale
            while(time<=0 && time_max>=0 && ammo--!=0) {
                ++burst
                // Source nonzero burst_time getter overrides the interval.
                // Default getter0 preserves initial weapon_load/max(1,burst).
                if(explicit_interval!=0) time_max=explicit_interval
                time+=time_max
                var _anchor=scrNTTEFullMergedRuntimeFiringAnchor(id)
                if(!instance_exists(creator) || !scrNTTEFullActorFiringAnchorExists(_anchor)) continue
                x=_anchor.x;y=_anchor.y
                // Ordinary ActorFire tags its initial angle for native shots.
                // Source FireBurst explicitly follows creator.gunangle on
                // each later step; only actual mounts/direction-owner scopes
                // may supply a separately rotated firing angle.
                if(is_struct(scrNTTEFullValue(id,"ntte_merged_runtime_at",undefined))
                    || is_struct(scrNTTEFullValue(id,"ntte_actor_mount",undefined))
                    || instance_exists(scrNTTEFullValue(id,"ntte_actor_direction_owner",noone)))
                    direction=scrNTTEFullMergedRuntimeFiringAngle(id)
                else if(variable_instance_exists(creator,"gunangle")) direction=creator.gunangle
                scrNTTEFullNativeFireBurstInvoke(creator,x,y,direction,wep,primary,team,accuracy,callback,context,burst)
            }
        } finally {scrNTTEFullMergedRuntimeMountEnd(_mount)}
    } finally {scrNTTEFullMergedRuntimeEventEnd(_event)}
}
function scrNTTEFullNativeFireBurstStart(_weapon,_burst,_interval,_primary,_callback,_context=undefined,_explicit_interval=0) {
    // telib4306..4338: controller before initial fire, no later ammo debit.
    _burst=ceil(_burst)
    var _controller=noone
    if(_burst>1 || _burst<0) {
        _controller=scr_damage_create(x,y,NTTEFullNativeFireBurst)
        _controller.wep=_weapon;_controller.primary=_primary;_controller.accuracy=accuracy
        _controller.direction=gunangle;_controller.ammo=_burst-1
        _controller.callback=_callback;_controller.context=_context;_controller.explicit_interval=_explicit_interval
        _controller.time_max=_interval
        _controller.time=_controller.time_max-random(timescale)
        if(_controller.time<=0) with(_controller) {time+=timescale;event_perform(ev_step,ev_step_normal)}
        if(instance_exists(_controller)) {_controller.burst+=1}
    }
    return _controller
}
function scrNTTEFullBubbleWeaponBurstOne(_weapon,_primary,_burst,_context) {
    return scrNTTEFullBubbleWeaponOne(_weapon,_primary)
}
function scrNTTEFullBubbleWeaponFire(_weapon,_primary=true) {
    var _burst=_weapon==wep_ntte_bubble_rifle?2:(_weapon==wep_ntte_bubble_minigun?3:1),
        _interval=_weapon==wep_ntte_bubble_rifle?2:3/max(1,_burst)
    if(_burst>1) scrNTTEFullNativeFireBurstStart(_weapon,_burst,_interval,_primary,
        scrNTTEFullBubbleWeaponBurstOne,undefined,_weapon==wep_ntte_bubble_rifle?2:0)
    return scrNTTEFullBubbleWeaponOne(_weapon,_primary)
}
function scrNTTEFullBubbleWeaponReloaded(_weapon) {
    if(_weapon==wep_ntte_bubble_minigun) {
        scrNTTEFullBubbleWeaponPop(19,1,0.4,wkick>0)
        scrNTTEFullDiscWeaponSound(sndOasisExplosionSmall,1.1,0.4)
        return true
    }
    var _count=0,_length=0
    switch(_weapon) {
        case wep_ntte_bubble_rifle:_count=1;_length=14;break
        case wep_ntte_bubble_shotgun:_count=3;_length=16;break
        case wep_ntte_bubble_cannon:_count=5;_length=22;break
        default:return false
    }
    repeat(_count) with(instance_create(x+lengthdir_x(_length,gunangle),y+lengthdir_y(_length,gunangle),Bubble)) {
        image_xscale=0.75;image_yscale=0.75;image_angle=random(360)
    }
    scrNTTEFullDiscWeaponSound(sndOasisExplosionSmall,1.3,0.4)
    return true
}
function scrNTTEFullHyperBubbleNativeEndStep() {
    if(lockstep_stop) return;
    // teoasis1087..1170: source custom projectile creation, additive FX
    // motion, original direct hit and real physical explosion identities.
    mask_index=mskBullet1
    var _distance=100,_direction=direction,_mx=lengthdir_x(16,_direction),_my=lengthdir_y(16,_direction),_targets=[]
    with(hitme) if(team!=other.team) array_push(_targets,id)
    scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleExplosionSmall)
    while(_distance-->0 && hits>0 && !place_meeting(x,y,Wall)) {
        x+=_mx;y+=_my
        if(random(3)<1) with(instance_create(x+orandom(4),y+orandom(4),Bubble)) {
            scrNTTEFullNativeMotionAddFT(id,_direction+orandom(4),6+random(4));friction=0.2*timescale*timescale
        }
        if(random(3)<2) with(instance_create(x+orandom(2),y+orandom(2),Smoke))
            scrNTTEFullNativeMotionAddFT(id,_direction+orandom(4),2+random(2))
        if(place_meeting(x,y,hitme)) {
            var _hit=false
            for(var _i=0;_i<array_length(_targets);++_i) {
                var _target=_targets[_i]
                if(!instance_exists(_target) || _target.hp<=0 || !place_meeting(x,y,_target)) continue
                var _reverse=false,_self=id
                with(_target) _reverse=place_meeting(x,y,_self)
                if(!_reverse) continue
                if(!_hit) {_hit=true;--hits;scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleExplosionSmall)}
                scrNTTEFullNativeProjectileDirectHit(_target,damage,knockback_speed/timescale,_direction,0)
            }
        }
    }
    scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleExplosion)
    repeat(max(0,hits)) scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullBubbleExplosionSmall)
    instance_destroy()
}
