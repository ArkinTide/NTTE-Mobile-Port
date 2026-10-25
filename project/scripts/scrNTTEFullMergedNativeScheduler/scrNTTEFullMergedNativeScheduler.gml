// Standard GML exposes native collision events, but no guaranteed global
// post-normal-Step/pre-motion callback. This adapter deliberately uses actual
// collision entry and synchronous copy registration; it never calls the
// predictive post_step collision scanner from End Step.
function scrNTTEFullMergedNativeCopy(_perform_events=false) {
    var _source=id,_copy=instance_copy(_perform_events)
    if(!instance_exists(_copy)) return _copy
    if(!_perform_events && instance_exists(_source)) {
        // NTT's LQ effect containers are shared by copies. Native modern
        // instance_copy may clone their replacement structs instead. Restore
        // these references before any registration snapshot or caller code.
        // The destroy snapshot is deliberately rebuilt per-copy below.
        var _fields=variable_instance_get_names(_source)
        for(var _i=0;_i<array_length(_fields);++_i) {
            var _field=_fields[_i]
            if(string_pos("temerge_",_field)!=1 || _field=="temerge_destroy_event_vars") continue
            var _value=variable_instance_get(_source,_field)
            if(is_struct(_value) || is_array(_value)) variable_instance_set(_copy,_field,_value)
        }
    }
    if(!instance_exists(GameCont)) return _copy
    scrNTTEFullParrotCharmRegisterCopy(_copy)
    var _map=scrNTTEFullValue(GameCont,"temerge_effect_vars_map",undefined)
    if(!is_struct(_map)) return _copy
    var _names=variable_struct_get_names(_map)
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i],_vars=_map[$ _name],_tag="temerge_"+_name+"_instance"
        if(array_get_index(_vars.instance_list,_source)>=0)
            scrNTTEFullMergedEffectObjectSetup(_name,_copy.object_index,[_copy])
        // A callback runs with its membership array temporarily empty. Its
        // tagged copies must wait until the next non-setup event, preserving
        // the original discovery timing and shared effect references.
        if(variable_instance_exists(_copy,_tag) && array_get_index(_vars.instance_list,_copy)<0)
            scrNTTEFullMergedEffectsQueueCopy(_name,_copy)
    }
    return _copy
}
function scrNTTEFullMergedNativeCollisionBegin(_target,_other) {
    if(lockstep_stop || !variable_global_exists("ntte_merge_native_collision_mode") || !global.ntte_merge_native_collision_mode
        || !instance_exists(_target) || !instance_exists(_other)) return undefined
    // Ordinary bullets do not allocate a struct, temporary array or stack.
    if(!variable_instance_exists(_target,"temerge_hit_event_ref_list")
        && !variable_instance_exists(_target,"temerge_wall_event_ref_list")) return undefined
    var _event=instance_is(_other,Wall) ? "wall":(instance_is(_other,hitme) ? "hit":"")
    if(_event=="") return undefined
    var _key="temerge_"+_event+"_event_ref_list"
    if(!variable_instance_exists(_target,_key)) return undefined
    var _refs=variable_instance_get(_target,_key)
    if(!is_array(_refs) || !array_length(_refs)) return undefined
    if(!variable_global_exists("ntte_merge_native_collision_stack")) global.ntte_merge_native_collision_stack=[]
    // event_inherited enters another wrapped native event for the same pair.
    // Keep its normal handler, and invoke the merged callbacks only once.
    for(var _i=0;_i<array_length(global.ntte_merge_native_collision_stack);++_i) {
        var _parent=global.ntte_merge_native_collision_stack[_i]
        if(_parent.target==_target && _parent.other==_other && _parent.event==_event) return undefined
    }
    var _entry={target:_target,other:_other,event:_event,allow:true,stacked:false}
    array_push(global.ntte_merge_native_collision_stack,_entry); _entry.stacked=true
    try { _entry.allow=scrNTTEFullMergedProjectileEvent(_target,_other,_entry.event) }
    catch(_error) { scrNTTEFullMergedNativeCollisionEnd(_entry); throw _error }
    return _entry
}
function scrNTTEFullMergedNativeCollisionEnd(_entry) {
    if(is_undefined(_entry) || !_entry.stacked || !variable_global_exists("ntte_merge_native_collision_stack")) return;
    var _index=array_get_index(global.ntte_merge_native_collision_stack,_entry)
    if(_index>=0) array_delete(global.ntte_merge_native_collision_stack,_index,1)
    _entry.stacked=false
}
function scrNTTEFullMergedNativeDeathCapture(_target) {
    if(!instance_exists(_target) || !variable_global_exists("ntte_merge_native_collision_mode")
        || !global.ntte_merge_native_collision_mode) return;
    var _state=scrNTTEFullValue(_target,"temerge_destroy_event_vars",undefined)
    // Destroy replay dummies retain the dead original's identity. Capturing
    // them again would replace the stored source state with replay-side FX.
    if(is_struct(_state) && _state.original==_target) {
        scrNTTEFullMergedDestroyPost([_target])
        _state.ntte_native_terminal=true
    }
}
function scrNTTEFullMergedNativeEndStep() {
    // Only destroy bookkeeping is adapted to native End Step. hit/wall are
    // handled at real collision entry, never predicted twice from this phase.
    var _controllers=scrNTTEFullInstances(NTTEFullMergedEffectScheduler)
    for(var _i=0;_i<array_length(_controllers);++_i) if(instance_exists(_controllers[_i])) with(_controllers[_i]) {
        if(ntte_effect_name=="destroy_event" && ntte_effect_event=="post_step")
            scrNTTEFullMergedEffectCallEvent(ntte_effect_name,ntte_effect_event)
    }
}
function scrNTTEFullMergedNativeSchedulerCapabilities() {
    return {copy:"synchronous-after-native-copy",hit:"before-native-collision-handler",wall:"before-native-collision-handler",
        destroy_capture:"native-Destroy-and-Cleanup-entry",destroy_replay:"native-End-Step",post_step:"no-standard-GML-global-hook"}
}
function scrNTTEFullMergedNativeSkipPredictedCollision(_name,_phase) {
    return _phase=="post_step" && (_name=="hit_event" || _name=="wall_event")
        && variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode
}
function scrNTTEFullMergedNativeCollisionTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _old_test=variable_global_exists("ntte_merge_native_test") ? global.ntte_merge_native_test:undefined
    var _old_mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode
    global.ntte_merge_native_collision_mode=true
    global.ntte_merge_native_test={trace:[],destroyed:0,deaths:[]}
    try {
        var _p=instance_create(8500,8500,Bullet1),_enemy=instance_create(8500,8500,Bandit)
        _p.team=team_player; _p.speed=0; _enemy.team=team_enemy
        var _hp=_enemy.hp
        assert(is_undefined(scrNTTEFullMergedNativeCollisionBegin(_p,_enemy)),
            "Untagged native collision allocated an effect-dispatch entry")
        scrNTTEFullMergedProjectileAddEvent(_p,"hit",function() {
            array_push(global.ntte_merge_native_test.trace,[id,other.id,"hit"])
            x+=100
        })
        with(_enemy) with(_p) event_perform(ev_collision,hitme)
        assert(instance_exists(_p) && _enemy.hp==_hp && array_length(global.ntte_merge_native_test.trace)==1,
            "Native hit wrapper did not skip normal damage after callback separated the real bullet")
        var _trace=global.ntte_merge_native_test.trace
        assert(_trace[0][0]==_p && _trace[0][1]==_enemy,"Native hit callback lost actual projectile/target context")
        assert(!array_length(global.ntte_merge_native_collision_stack),"Native collision early exit leaked inherited-dispatch guard")
        var _wall=instance_create(8800,8500,Wall),_wall_shot=instance_create(8800,8500,Bullet1)
        _wall_shot.team=team_player; _wall_shot.speed=0
        scrNTTEFullMergedProjectileAddEvent(_wall_shot,"wall",function() {
            array_push(global.ntte_merge_native_test.trace,[id,other.id,"wall"])
            return true
        })
        with(_wall) with(_wall_shot) event_perform(ev_collision,Wall)
        assert(!instance_exists(_wall_shot) && array_length(global.ntte_merge_native_test.trace)==2,
            "Native wall wrapper did not run its callback before the real Bullet1 normal destruction")
        var _inherited=instance_create(_enemy.x,_enemy.y,NTTEFullMergedNativeInheritedBullet)
        _inherited.team=team_player; _inherited.speed=0
        scrNTTEFullMergedProjectileAddEvent(_inherited,"hit",function() {
            array_push(global.ntte_merge_native_test.trace,[id,other.id,"inherited"])
        })
        with(_enemy) with(_inherited) event_perform(ev_collision,hitme)
        assert(!instance_exists(_inherited) && array_length(global.ntte_merge_native_test.trace)==3,
            "Native event_inherited collision repeated callbacks or skipped its original bullet handler")
        assert(!array_length(global.ntte_merge_native_collision_stack),
            "Native collision destruction/inherited normal exit leaked its dispatch guard")
        var _source=instance_create(8900,8500,Bullet1),_copy=noone
        _source.team=team_player; _source.direction=0; _source.speed=2*timescale
        _source.temerge_native_shared={amount:2}
        scrNTTEFullMergedProjectileAddEvent(_source,"destroy",function() {
            global.ntte_merge_native_test.destroyed+=1
            array_push(global.ntte_merge_native_test.deaths,x)
        })
        with(_source) _copy=scrNTTEFullMergedNativeCopy(false)
        var _vars=scrNTTEFullMergedEffectVars("destroy_event")
        assert(array_get_index(_vars.instance_list,_copy)>=0 && _copy.temerge_destroy_event_vars.original==_copy,
            "Synchronous native copy was not registered before the caller could destroy it")
        _source.temerge_native_shared.amount=7
        assert(_copy.temerge_native_shared.amount==7,"Copy(false) lost source-to-copy shared LQ effect state")
        _copy.temerge_native_shared.amount=2
        assert(_source.temerge_native_shared.amount==2 && _source.temerge_destroy_event_vars.original==_source,
            "Copy(false) lost copy-to-source shared LQ state or overwrote source destroy identity")
        instance_destroy(_source,false); instance_destroy(_copy,false)
        scrNTTEFullMergedEffectsReplayDestroy(_vars)
        assert(global.ntte_merge_native_test.destroyed==2,
            "Created-and-destroyed copy(false) lost its independent destroy callback before any scan")
        var _deaths=global.ntte_merge_native_test.deaths
        assert(_deaths[0]==8900 && _deaths[1]==8900,
            "Native Cleanup missed destroy(false), or replay applied predicted motion twice after actual death capture")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game); global.ntte_merge_native_test=_old_test
        global.ntte_merge_native_collision_mode=_old_mode
        global.ntte_merge_native_collision_stack=[]
    }
    scrNTTESmokeLog("FULL MERGED NATIVE ADAPTER: real Bullet1 hit/wall dispatch before normal handlers, callback separation/context/guard cleanup, and synchronously registered immediately destroyed copy(false) replay OK")
}

// Exercise effect bodies THROUGH their real generated Bullet1 collision event.
// The source-only payload suite deliberately calls ProjectileEvent directly;
// this suite proves that the native entry wrapper reaches the same bodies once.
function scrNTTEFullMergedNativePayloadTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _old_mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        _old_stack=variable_global_exists("ntte_merge_native_collision_stack")?global.ntte_merge_native_collision_stack:[],
        _frame=current_frame,_seed=random_get_seed(),_walls=ds_list_create()
    ds_list_copy(_walls,global.lis_walls_visible)
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_merge_native_collision_mode=true;global.ntte_merge_native_collision_stack=[]
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
    current_frame=2
    try {
        scrNTTEFullMergedPayloadInit()
        var _owner=instance_find(Player,0),_bullet=instance_create(11000,11000,Bullet1),
            _target=instance_create(11000,11000,NTTEBabyGator)
        _bullet.team=team_player;_bullet.creator=_owner;_bullet.damage=4;_bullet.speed=0
        _target.team=team_enemy;_target.hp=3;_target.nexthurt=0;_target.speed=0;_target.solid=false
        var _mask=_target.mask_index
        scrNTTEFullMergedProjectileAddEffect(_bullet,"piercing",[1])
        with(_target) with(_bullet) event_perform(ev_collision,hitme)
        assert(instance_exists(_bullet) && _target.hp==-1 && _target.mask_index==mskNone,
            "Native piercing collision did not apply manual damage/mask separation before normal Bullet1 destruction")
        var _deferred=scrNTTEFullInstances(NTTEFullMergedDeferred)
        for(var _i=0;_i<array_length(_deferred);++_i) if(array_get_index(_before,_deferred[_i])<0)
            with(_deferred[_i]) event_perform(ev_step,ev_step_end)
        assert(_target.mask_index==_mask,"Native piercing collision failed deferred mask restoration")

        var _slug=instance_create(11300,11000,Bullet1),_slug_target=instance_create(11300,11000,NTTEBabyGator)
        _slug.team=team_player;_slug.creator=_owner;_slug.damage=4;_slug.speed=0;_slug.image_alpha=1
        _slug_target.team=team_enemy;_slug_target.hp=1;_slug_target.nexthurt=0;_slug_target.speed=0;_slug_target.solid=false
        scrNTTEFullMergedProjectileAddEffect(_slug,"slug",[1])
        scrNTTEFullMergedProjectileAddEffect(_slug,"slug",[1])
        var _hit_fx=instance_number(BulletHit),_fx_before=scrNTTEFullInstances(BulletHit)
        with(_slug_target) with(_slug) event_perform(ev_collision,hitme)
        // SlugImpact emits sprSlugHit; the actual Bullet1 destruction then
        // inherits projectile.Destroy, which emits its spr_fade=sprBulletHit.
        var _fx_after=scrNTTEFullInstances(BulletHit),_slug_fx=0,_ordinary_fx=0
        for(var _i=0;_i<array_length(_fx_after);++_i) if(array_get_index(_fx_before,_fx_after[_i])<0) {
            if(_fx_after[_i].sprite_index==sprSlugHit) _slug_fx+=1
            if(_fx_after[_i].sprite_index==sprBulletHit) _ordinary_fx+=1
        }
        assert(!instance_exists(_slug) && _slug_target.hp==-3
            && _slug_target.temerge_slug_nexthurt==current_frame+6 && instance_number(BulletHit)==_hit_fx+2
            && _slug_fx==1 && _ordinary_fx==1,
            "Native slug entry lost one extra-damage callback, lethal health guard, or ordinary Bullet1 collision; bullet_alive="
            +string(instance_exists(_slug))+", hp="+string(_slug_target.hp)+", slug_next="
            +string(scrNTTEFullValue(_slug_target,"temerge_slug_nexthurt",-999))+", expected_next="+string(current_frame+6)
            +", BulletHit_delta="+string(instance_number(BulletHit)-_hit_fx))
        _deferred=scrNTTEFullInstances(NTTEFullMergedDeferred)
        for(var _i=0;_i<array_length(_deferred);++_i) if(array_get_index(_before,_deferred[_i])<0)
            with(_deferred[_i]) event_perform(ev_step,ev_step_end)
        assert(_slug_target.hp==-8,"Native slug collision deferred restoration lost original overkill plus native damage")

        // speed=0 guarantees both actual and predicted contact overlap the wall
        // at every tested timescale. The separate case below checks its cap.
        var _wall=instance_create(11600,11000,Wall),_piercer=instance_create(11600,11000,Bullet1)
        _piercer.team=team_player;_piercer.creator=_owner;_piercer.speed=0
        scrNTTEFullMergedProjectileAddEffect(_piercer,"wall_piercing",[1])
        var _floors=instance_number(FloorExplo)
        with(_wall) with(_piercer) event_perform(ev_collision,Wall)
        assert(!instance_exists(_wall) && instance_exists(_piercer) && _piercer.temerge_wall_piercing_count==0
            && !array_length(_piercer.temerge_wall_event_ref_list) && instance_number(FloorExplo)==_floors+1,
            "Native wall-piercing entry did not remove wall/floor budget and suppress normal Bullet1 destruction")
        var _fast_wall=instance_create(11900,11000,Wall),_fast=instance_create(11900-32*timescale,11000,Bullet1)
        _fast.team=team_player;_fast.creator=_owner;_fast.direction=0;_fast.speed=32*timescale
        scrNTTEFullMergedProjectileAddEffect(_fast,"wall_piercing",[2])
        with(_fast_wall) with(_fast) event_perform(ev_collision,Wall)
        assert(!instance_exists(_fast_wall) && instance_exists(_fast)
            && abs(_fast.speed-16*timescale)<0.0001 && _fast.temerge_wall_piercing_count==1,
            "Native wall-piercing entry lost speed cap or retained-use budget at projected solid contact")
        assert(!array_length(global.ntte_merge_native_collision_stack),"Native payload collisions leaked the dispatch guard")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_old_mode;global.ntte_merge_native_collision_stack=_old_stack
        current_frame=_frame;random_set_seed(_seed)
        ds_list_copy(global.lis_walls_visible,_walls);ds_list_destroy(_walls)
    }
    scrNTTESmokeLog("FULL MERGED NATIVE PAYLOAD: compiled Bullet1 events reach piercing mask/deferred restoration, slug extra+native lethal/overkill, wall destruction/budget/speed cap and guard cleanup OK @"+string(30/timescale))
}
