// Original temerge2934 onward; only implemented effect families are registered.
function scrNTTEFullMergedPayloadInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_payload_events_ready",false)) return;
    _registry.ntte_payload_events_ready=true
    scrNTTEFullMergedEffectAddEvent("slug","setup",scrNTTEFullMergedSlugEffectSetup)
    scrNTTEFullMergedEffectAddEvent("piercing","setup",scrNTTEFullMergedPiercingSetup)
    scrNTTEFullMergedEffectAddEvent("wall_piercing","setup",scrNTTEFullMergedWallPiercingSetup)
}
function scrNTTEFullMergedPayloadDefer(_callback,_args=undefined) {
    var _deferred=instance_create(0,0,NTTEFullMergedDeferred)
    _deferred.ntte_callback=_callback;_deferred.ntte_args=is_array(_args)?_args:[]
    return _deferred
}
function scrNTTEFullMergedPayloadDeferredEndStep() {
    if(lockstep_stop) return;
    // Remove first so an invoked callback cannot accidentally run this again.
    var _callback=ntte_callback,_args=ntte_args,_controller=id
    ntte_callback=undefined
    if(is_callable(_callback) || is_struct(_callback)) scrNTTEFullMergedEffectsCall(id,id,_callback,_args)
    if(instance_exists(_controller)) instance_destroy(_controller,false)
}
function scrNTTEFullMergedSlugEffectSetup(_instances,_size) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_slug_size")) {
            temerge_slug_size=0
            scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedSlugHit)
        }
        temerge_slug_size+=_size
    }
    scrNTTEFullMergedProjectileAddBloom(_instances,_size/3)
}
function scrNTTEFullMergedSlugImpact(_projectile,_target,_hit_x,_hit_y,_damage) {
    if(!instance_exists(_target)) return;
    with(_target) {
        // Epsilon bbox maximum edges are exclusive; original NTT inclusive.
        var _x=(bbox_left+bbox_right-1)/2,_y=(bbox_top+bbox_bottom-1)/2,
            _direction=(_x==_hit_x && _y==_hit_y)?random(360):point_direction(_x,_y,_hit_x,_hit_y),
            _width=bbox_right-bbox_left,_height=bbox_bottom-bbox_top,
            _fx=instance_create(_x+lengthdir_x(min(abs(_hit_x-_x),_width/2+1),_direction),
                _y+lengthdir_y(min(abs(_hit_y-_y),_height/2+1),_direction),BulletHit),
            _scale=0.75+max(0,_damage)/80
        _fx.sprite_index=_scale<1.5?sprSlugHit:sprHeavySlugHit
        _fx.image_xscale=_scale<1.5?_scale:_scale/1.5;_fx.image_yscale=_fx.image_xscale
        _fx.depth=-6;_fx.friction=0.6*timescale*timescale
        with(_fx) motion_add(_direction+180+orandom(30),4*timescale)
        if(instance_exists(_projectile)) {
            with(_projectile) scr_projectile_hit(_target,_damage)
        }
        else scrNTTEFullRawHit(id,_damage,1)
    }
}
function scrNTTEFullMergedSlugHealthEnd(_target,_health) {
    if(instance_exists(_target) && _target.hp<=1) _target.hp=_health+(_target.hp-1)
}
function scrNTTEFullMergedSlugPostCollision(_projectile,_target,_x,_y,_damage) {
    if(!instance_exists(_projectile) && instance_exists(_target)) scrNTTEFullMergedSlugImpact(_projectile,_target,_x,_y,_damage)
}
function scrNTTEFullMergedSlugHit() {
    if(temerge_slug_size==0) return true
    if(!scrNTTEFullMergedProjectileCanHit(other.id)) return;
    var _damage=ceil((damage==0?1:damage)*(power(1.5,temerge_slug_size)-1)),_target=other.id
    if(!variable_instance_exists(_target,"temerge_slug_nexthurt") || _target.temerge_slug_nexthurt<=current_frame) {
        var _old_next=_target.nexthurt,_projectile=id
        scrNTTEFullMergedSlugImpact(id,_target,x,y,_damage)
        if(instance_exists(_target)) {
            _target.temerge_slug_nexthurt=_target.nexthurt;_target.nexthurt=_old_next
            if(_target.hp<=0) {
                scrNTTEFullMergedPayloadDefer(scrNTTEFullMergedSlugHealthEnd,[_target,_target.hp])
                _target.hp=1
            }
        }
        if(instance_exists(_projectile)) {
            scrNTTEFullMergedProjectileAddBloom(_projectile,-_projectile.temerge_slug_size/3)
            _projectile.temerge_slug_size=0
        }
        return true
    }
    scrNTTEFullMergedPayloadDefer(scrNTTEFullMergedSlugPostCollision,[id,_target,x,y,_damage])
}
function scrNTTEFullMergedPiercingSetup(_instances,_amount) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_piercing_amount")) {
            temerge_piercing_amount=0
            scrNTTEFullMergedProjectileAddEvent(id,"hit",scrNTTEFullMergedPiercingHit)
        }
        temerge_piercing_amount=max(temerge_piercing_amount,_amount)
    }
}
function scrNTTEFullMergedPiercingMaskEnd(_target,_mask) {
    if(instance_exists(_target) && _target.mask_index==mskNone) _target.mask_index=_mask
}
function scrNTTEFullMergedPiercingHit() {
    if(!scrNTTEFullMergedProjectileCanHit(other.id)) return;
    var _health=ceil(damage*temerge_piercing_amount),_target=other.id
    if(_target.hp<=_health) {
        scr_projectile_hit(_target,max(damage,_health),knockback_speed)
        if(instance_exists(_target) && _target.mask_index!=mskNone) {
            scrNTTEFullMergedPayloadDefer(scrNTTEFullMergedPiercingMaskEnd,[_target,_target.mask_index])
            _target.mask_index=mskNone
        }
    }
}
function scrNTTEFullMergedWallPiercingSetup(_instances,_amount) {
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(!variable_instance_exists(id,"temerge_wall_piercing_count")) {
            temerge_wall_piercing_count=0
            scrNTTEFullMergedProjectileAddEvent(id,"wall",scrNTTEFullMergedWallPiercingWall)
        }
        temerge_wall_piercing_count+=_amount
    }
}
function scrNTTEFullMergedWallPiercingWall() {
    if(temerge_wall_piercing_count<=0) return true
    var _wall=other.id
    with(_wall) { instance_create(x,y,FloorExplo);instance_destroy() }
    if(speed>16*timescale) speed=16*timescale
    temerge_wall_piercing_count-=1
    if(temerge_wall_piercing_count<=0) return true
}

function scrNTTEFullMergedPayloadUnitTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _frame=current_frame,_seed=random_get_seed(),_walls=ds_list_create()
    ds_list_copy(_walls,global.lis_walls_visible)
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    current_frame=2
    try {
        scrNTTEFullMergedPayloadInit()
        var _owner=instance_find(Player,0),_bullet=instance_create(80000,80000,Bullet1),
            _target=instance_create(80000,80000,NTTEBabyGator)
        _bullet.team=team_player;_bullet.creator=_owner;_bullet.damage=4;_bullet.speed=0
        _target.team=team_enemy;_target.hp=3;_target.nexthurt=0;_target.speed=0;_target.solid=false
        var _mask=_target.mask_index
        scrNTTEFullMergedProjectileAddEffect(_bullet,"piercing",[0.25])
        scrNTTEFullMergedProjectileAddEffect(_bullet,"piercing",[1])
        scrNTTEFullMergedProjectileAddEffect(_bullet,"piercing",[0.5])
        assert(_bullet.temerge_piercing_amount==1 && array_length(_bullet.temerge_hit_event_ref_list)==1,
            "Piercing setup must preserve maximum strength and one callback")
        var _allow=scrNTTEFullMergedProjectileEvent(_bullet,_target,"hit")
        assert(!_allow && instance_exists(_bullet) && _target.hp==-1 && _target.mask_index==mskNone,
            "Piercing did not apply real manual damage then suppress native collision through temporary mask")
        var _deferred=scrNTTEFullInstances(NTTEFullMergedDeferred)
        for(var _i=0;_i<array_length(_deferred);++_i) if(array_get_index(_before,_deferred[_i])<0)
            with(_deferred[_i]) event_perform(ev_step,ev_step_end)
        assert(_target.mask_index==_mask,"Native deferred EndStep failed to restore pierced enemy mask")

        var _slug=instance_create(80300,80000,Bullet1),_slug_target=instance_create(80300,80000,NTTEBabyGator)
        _slug.team=team_player;_slug.creator=_owner;_slug.damage=4;_slug.speed=0;_slug.image_alpha=1
        _slug_target.team=team_enemy;_slug_target.hp=1;_slug_target.nexthurt=0;_slug_target.speed=0;_slug_target.solid=false
        scrNTTEFullMergedProjectileAddEffect(_slug,"slug",[1])
        scrNTTEFullMergedProjectileAddEffect(_slug,"slug",[1])
        assert(_slug.temerge_slug_size==2 && array_length(_slug.temerge_hit_event_ref_list)==1
            && abs(_slug.image_alpha-5/3)<0.0001,"Slug setup lost size/bloom stacking or callback uniqueness")
        var _hit_fx=instance_number(BulletHit)
        scrNTTEFullMergedProjectileEvent(_slug,_slug_target,"hit")
        assert(_slug_target.hp==1 && _slug_target.nexthurt==0 && _slug_target.temerge_slug_nexthurt==current_frame+6
            && _slug.temerge_slug_size==0 && abs(_slug.image_alpha-1)<0.0001 && !array_length(_slug.temerge_hit_event_ref_list)
            && instance_number(BulletHit)==_hit_fx+1,"Slug impact lost extra damage/FX, manual iFrames, bloom reset or health guard")
        with(_slug_target) with(_slug) event_perform(ev_collision,hitme)
        assert(_slug_target.hp==-3,"Slug health guard did not let actual native bullet apply its normal damage")
        _deferred=scrNTTEFullInstances(NTTEFullMergedDeferred)
        for(var _i=0;_i<array_length(_deferred);++_i) if(array_get_index(_before,_deferred[_i])<0)
            with(_deferred[_i]) event_perform(ev_step,ev_step_end)
        assert(_slug_target.hp==-8,"Slug deferred health restoration lost original overkill plus ordinary collision damage")

        var _post=instance_create(80600,80000,Bullet1),_post_target=instance_create(80600,80000,NTTEBabyGator)
        _post.team=team_player;_post.creator=_owner;_post.damage=4;_post.speed=0
        _post_target.team=team_enemy;_post_target.hp=50;_post_target.nexthurt=0;_post_target.temerge_slug_nexthurt=current_frame+6
        scrNTTEFullMergedProjectileAddEffect(_post,"slug",[1])
        scrNTTEFullMergedProjectileEvent(_post,_post_target,"hit")
        assert(_post_target.hp==50,"Blocked slug manual iFrame path applied immediate damage")
        instance_destroy(_post,false)
        _deferred=scrNTTEFullInstances(NTTEFullMergedDeferred)
        for(var _i=0;_i<array_length(_deferred);++_i) if(array_get_index(_before,_deferred[_i])<0)
            with(_deferred[_i]) event_perform(ev_step,ev_step_end)
        assert(_post_target.hp==48,"Destroyed blocked slug did not apply original deferred raw impact")

        var _wall=instance_create(80900,80000,Wall),_piercer=instance_create(80900,80000,Bullet1)
        _piercer.creator=_owner;_piercer.team=team_player;_piercer.speed=32*timescale
        scrNTTEFullMergedProjectileAddEffect(_piercer,"wall_piercing",[0.5])
        scrNTTEFullMergedProjectileAddEffect(_piercer,"wall_piercing",[0.5])
        assert(_piercer.temerge_wall_piercing_count==1 && array_length(_piercer.temerge_wall_event_ref_list)==1,
            "Wall-piercing setup lost additive budget or callback uniqueness")
        var _floors=instance_number(FloorExplo)
        scrNTTEFullMergedProjectileEvent(_piercer,_wall,"wall")
        assert(!instance_exists(_wall) && instance_exists(_piercer) && _piercer.temerge_wall_piercing_count==0
            && abs(_piercer.speed-16*timescale)<0.0001 && !array_length(_piercer.temerge_wall_event_ref_list)
            && instance_number(FloorExplo)==_floors+1,"Actual wall piercing lost wall deletion, floor, speed cap or exhausted-ref removal")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        current_frame=_frame;random_set_seed(_seed)
        ds_list_copy(global.lis_walls_visible,_walls);ds_list_destroy(_walls)
    }
    scrNTTESmokeLog("FULL MERGED PAYLOAD: real piercing damage/mask/EndStep, slug extra+native collision/overkill/raw deferred and wall deletion/floor/speed budget OK @"+string(30/timescale))
}
