// Native event adapters for the Custom* types actually used by Frontier.
// Source AI runs on the 30 Hz source clock; native velocity and animation
// remain host-scaled by the compiler, so the host can render at 60 Hz.
#macro FR_OBJECT_GAME -10100
#macro FR_OBJECT_EFFECT -10101
#macro FR_OBJECT_PICKUP -10102
#macro FR_OBJECT_GUITAR_SLASH -10103
#macro FR_OBJECT_INV_CRYSTAL -10104
#macro FR_OBJECT_OASIS_BOSS -10105
#macro FR_OBJECT_MENU_BUTTON -10106
#macro FR_OBJECT_BACK_MAIN_MENU -10107
#macro FR_OBJECT_GAMEOVER_BUTTON -10108
#macro FR_OBJECT_UI_BUTTON -10109
#macro FR_OBJECT_THROWN_WEP -10110

function scrFRObjectSelector(_selector) {
    return (is_numeric(_selector) && _selector>=FR_OBJECT_THROWN_WEP && _selector<=FR_OBJECT_GAME)
        || _selector==projectile || _selector==FRCustomProjectile;
}

function scrFRIsThrownWeapon(_instance) {
    // scrPowers' native Chicken throw keeps WepPickup physics and collisions.
    // Its Step restores mskWepPickup on landing; only its airborne phase is
    // the original NTT ThrownWep projectile family.
    return instance_exists(_instance) && _instance.object_index==WepPickup
        && _instance.mask_index==mskPlasma && instance_exists(_instance.creator);
}

function scrFRObjectCollect(_types,_output) {
    var _seen=scrFRInstanceUnionIndex(_output);
    for(var _i=0;_i<array_length(_types);++_i) {
        var _type=_types[_i];
        if(!object_exists(_type)) continue;
        with(_type) if(scrFRInstanceUnionAdd(_seen,id)) array_push(_output,id);
    }
    return _output;
}

function scrFRObjectInstances(_selector) {
    var _items=[];
    switch(_selector) {
        case FR_OBJECT_GAME:
            _items=scrNTTEFullNativeGameObjects();
            return scrFRObjectCollect([FRCustomObject,FRCustomHitme,FRCustomEnemy,FRCustomProp,
                FRCustomProjectile,FRCustomSlash,FRBinding],_items);
        case FR_OBJECT_EFFECT:
            return scrFRObjectCollect(scrFRNativeEffectTypes(),_items);
        case FR_OBJECT_PICKUP:
            _items=scrFRObjectCollect([Rad,BigRad,HPPickup,AmmoPickup,RogueAmmo,
                NTTEFullCustomPickup,FRSourcePickup],_items);
            with(WepPickup) if(!scrFRIsThrownWeapon(id)) array_push(_items,id);
            return _items;
        case projectile:
            _items=scrFRObjectCollect([projectile],_items);
            with(WepPickup) if(scrFRIsThrownWeapon(id)) array_push(_items,id);
            return _items;
        case FRCustomProjectile:
            // Original NTT CustomSlash inherits CustomProjectile. Keep the
            // native Slash parent for its collisions and restore that source
            // family only at the query boundary.
            return scrFRObjectCollect([FRCustomProjectile,FRCustomSlash],_items);
        case FR_OBJECT_THROWN_WEP:
            with(WepPickup) if(scrFRIsThrownWeapon(id)) array_push(_items,id);
            return _items;
        case FR_OBJECT_GUITAR_SLASH:
            // The mobile runner combines ordinary and guitar slashes in Slash.
            with(Slash) if(guitar || electricguitar) array_push(_items,id);
            return _items;
        case FR_OBJECT_INV_CRYSTAL:
            return scrFRObjectCollect([FRInvCrystal],_items);
        case FR_OBJECT_OASIS_BOSS:
            // The original OasisBoss has no native counterpart in NTTE. The
            // source only queries this optional type in a boss-family list.
            return _items;
        case FR_OBJECT_MENU_BUTTON:
            // The native menu renders option rows inside MenuOptions rather
            // than individual OptionMenuButton descendants. Keep this legacy
            // family query tied to the real interactive native menu objects.
            return scrFRObjectCollect([MainMenuButton,PauseButton,CharSelect,GoButton,
                PlayButton,SkillIcon,MenuOptions],_items);
        case FR_OBJECT_BACK_MAIN_MENU:
            // BackButton is the native unified return button. It is separate
            // from the MainMenu marker and the on-screen mobile game controls.
            return scrFRObjectCollect([BackButton],_items);
        case FR_OBJECT_GAMEOVER_BUTTON:
            // The native runner shares PauseButton between pause and death.
            // A source GameOverButton query must never select a pause button
            // while the player is alive.
            if(!instance_exists(GameOver)) return _items;
            return scrFRObjectCollect([PauseButton],_items);
        case FR_OBJECT_UI_BUTTON:
            _items=scrFRObjectInstances(FR_OBJECT_MENU_BUTTON);
            return scrFRObjectCollect([BackButton],_items);
    }
    if(is_array(_selector)) {
        var _seen=scrFRInstanceUnionIndex(_items);
        for(var _i=0;_i<array_length(_selector);++_i) {
            var _part=scrFRObjectInstances(_selector[_i]);
            for(var _j=0;_j<array_length(_part);++_j)
                if(scrFRInstanceUnionAdd(_seen,_part[_j])) array_push(_items,_part[_j]);
        }
    } else if(instance_exists(_selector)) {
        with(_selector) array_push(_items,id);
    }
    return _items;
}

function scrFRInstanceExists(_target) {
    if(scrFRObjectSelector(_target) || is_array(_target)) return array_length(scrFRObjectInstances(_target))>0;
    return instance_exists(_target);
}

function scrFRInstanceNumber(_target) {
    if(scrFRObjectSelector(_target) || is_array(_target)) return array_length(scrFRObjectInstances(_target));
    return instance_number(_target);
}

function scrFRInstanceFind(_target,_index) {
    if(scrFRObjectSelector(_target) || is_array(_target)) {
        var _items=scrFRObjectInstances(_target);
        return _index>=0 && _index<array_length(_items)?real(_items[_index]):noone;
    }
    return real(instance_find(_target,_index));
}

function scrFRInstanceIs(_target,_type) {
    if(scrFRObjectSelector(_type) || is_array(_type)) {
        if(!instance_exists(_target)) return false;
        var _items=scrFRObjectInstances(_type),_id=real(_target.id);
        for(var _i=0;_i<array_length(_items);++_i) if(real(_items[_i])==_id) return true;
        return false;
    }
    return instance_is(_target,_type);
}

function scrFRInstanceCreate(_x,_y,_type) {
    // libGeneral uses a hidden IceFlower as its interaction collision proxy.
    // The mobile IceFlower has real prop physics and hurt sounds; those must
    // not leak into the invisible prompt receiver. Keep real flowers intact.
    if(_type==IceFlower && scrFRPromptIs(id)) {
        var _proxy=instance_create(_x,_y,FRCustomObject);
        _proxy.name="LibPromptProxy";_proxy.fr_prompt_proxy=true;
        _proxy.visible=false;_proxy.mask_index=mskNone;_proxy.sprite_index=mskNone;
        _proxy.image_speed=0;
        return real(_proxy);
    }
    if(_type==FR_OBJECT_GUITAR_SLASH) {
        var _slash=instance_create(_x,_y,Slash);
        _slash.guitar=true;_slash.damage=26;_slash.sprite_index=sprHeavySlash;
        return scrFRCreatedDamageAttribution(_slash);
    }
    switch(_type) {
        case FR_OBJECT_GAME:_type=FRCustomObject;break;
        case FR_OBJECT_EFFECT:_type=FRSourceEffect;break;
        case FR_OBJECT_PICKUP:_type=FRSourcePickup;break;
        case FR_OBJECT_INV_CRYSTAL:_type=FRInvCrystal;break;
        case FR_OBJECT_OASIS_BOSS:throw "Frontier cannot create unavailable native OasisBoss";
        case FR_OBJECT_MENU_BUTTON:
        case FR_OBJECT_BACK_MAIN_MENU:
        case FR_OBJECT_GAMEOVER_BUTTON:
        case FR_OBJECT_UI_BUTTON:throw "Frontier cannot construct a native menu family";
        case FR_OBJECT_THROWN_WEP:throw "Frontier must throw a weapon through the native player power";
    }
    return scrFRCreatedDamageAttribution(instance_create(_x,_y,_type));
}

function scrFRCreatedDamageAttribution(_created) {
    // Authored NTT factories use instance_create then assign team/creator in
    // their with scope. Modern damagesource.Create initializes hitid=None,
    // unlike native scr_damage_create's attribution handoff. Fill only that
    // missing damage identity from the actual source callback caller; retain
    // a constructor's explicit identity (e.g. Explosion, Disc) and every
    // authored creator/team assignment that follows this return. Delayed
    // source CustomObject emitters (FireworkExtraBursts) need to carry this
    // context without acquiring a public hitid field of their own.
    if(!instance_exists(_created)) return real(_created);
    var _identity=self[$ "hitid"]??self[$ "fr_damage_context_hitid"]??HitId.None;
    if(_identity==HitId.None) _identity=self[$ "fr_damage_context_hitid"]??HitId.None;
    if(_identity!=HitId.None) _created.fr_damage_context_hitid=_identity;
    if(instance_is(_created,damagesource)) {
        if(_created.hitid==HitId.None && _identity!=HitId.None) _created.hitid=_identity;
    }
    // Preserve NPC provenance through non-projectile source emitters too.
    if(!is_struct(self)) scrNTTEFullActorDamageMetadata(_created,id);
    return real(_created);
}

function scrFRPlaceMeeting(_x,_y,_type) {
    if(scrFRObjectSelector(_type) || is_array(_type)) {
        var _items=scrFRObjectInstances(_type);
        for(var _i=0;_i<array_length(_items);++_i)
            if(place_meeting(_x,_y,_items[_i])) return true;
        return false;
    }
    return place_meeting(_x,_y,_type);
}

function scrFRObjectIndex(_instance) {
    var _type=_instance.object_index;
    if(scrFRIsThrownWeapon(_instance)) return FR_OBJECT_THROWN_WEP;
    if(_type==FRSourceEffect) return FR_OBJECT_EFFECT;
    if(_type==FRSourcePickup) return FR_OBJECT_PICKUP;
    if(_type==FRInvCrystal) return FR_OBJECT_INV_CRYSTAL;
    if(_type==Slash && ((_instance[$ "guitar"]??false) || (_instance[$ "electricguitar"]??false))) return FR_OBJECT_GUITAR_SLASH;
    return _type;
}

function scrFRObjectParent(_type) {
    if(_type==FR_OBJECT_EFFECT || _type==FR_OBJECT_PICKUP) return FR_OBJECT_GAME;
    if(_type==FR_OBJECT_GAME) return -100;
    if(_type==FR_OBJECT_GUITAR_SLASH) return Slash;
    if(_type==FR_OBJECT_INV_CRYSTAL) return prop;
    if(_type==FR_OBJECT_OASIS_BOSS) return enemy;
    if(_type==FR_OBJECT_MENU_BUTTON || _type==FR_OBJECT_BACK_MAIN_MENU) return FR_OBJECT_UI_BUTTON;
    if(_type==FR_OBJECT_GAMEOVER_BUTTON) return FR_OBJECT_MENU_BUTTON;
    if(_type==FR_OBJECT_UI_BUTTON) return -100;
    if(_type==FR_OBJECT_THROWN_WEP) return projectile;
    if(_type==FRCustomSlash) return FRCustomProjectile;
    if(_type==FRCustomObject || _type==FRBinding) return FR_OBJECT_GAME;
    if(array_contains(scrFRNativeEffectTypes(),_type)) return FR_OBJECT_EFFECT;
    return object_get_parent(_type);
}

function scrFRInvCrystalCreate() {
    // Preserve Crystal's native collision, damage and corpse handling while
    // keeping the cursed variants distinct from ordinary Crystal queries.
    var _variant=choose("Blue","Green"),_prefix="sprFRBase_CrystalProp"+_variant;
    spr_idle=asset_get_index(_prefix);
    spr_hurt=asset_get_index(_prefix+"Hurt");
    spr_dead=asset_get_index(_prefix+"Dead");
    assert(sprite_exists(spr_idle) && sprite_exists(spr_hurt) && sprite_exists(spr_dead),
        "Missing frozen native cursed crystal artwork");
    sprite_index=spr_idle;
}

function scrFRActorInit() {
    fr_custom_actor=true;
    fr_actor_cleaned=false;
    fr_actor_death_called=false;
    fr_actor_alarms=array_create(12,-1);
    on_begin_step=undefined;on_step=undefined;on_end_step=undefined;
    on_draw=undefined;on_destroy=undefined;on_cleanup=undefined;
    on_hurt=undefined;on_death=undefined;on_anim=undefined;
    on_wall=undefined;on_hit=undefined;on_projectile=undefined;
    on_grenade=undefined;
    // libGeneral gates optional pickup dispatch on field existence. Leave
    // on_pick absent until the authored object actually declares a handler.
    // on_alrmN fields are deliberately absent until a source callback is
    // assigned: libGeneral uses field existence to decide what to dispatch.
    can_die=true;name="";z=0;
}

function scrFRActorCallback(_field,_args=[]) {
    if(!variable_instance_exists(id,_field)) return undefined;
    var _callback=variable_instance_get(id,_field);
    if(is_undefined(_callback)) return undefined;
    return scrFRInvoke(id,_callback,_args);
}

function scrFRActorHasHurt(_target) {
    return instance_exists(_target)
        && (_target[$ "fr_custom_actor"]??false)
        && !is_undefined(_target[$ "on_hurt"]);
}

function scrFRActorHurt(_target,_amount,_hitid,_knockback=0,_direction=0) {
    // Source on_hurt owns HP, invulnerability, sounds, and recoil. Do not
    // apply the native damage a second time after invoking it.
    with(_target) {
        fr_last_hitid=_hitid;
        scrFRActorCallback("on_hurt",[_amount,_knockback/max(timescale,0.000001),_direction]);
    }
    return true;
}

function scrFRActorFinalCallback(_field) {
    // Authored final callbacks can wait before restoring room music/light.
    // Preserve their data for those continuations; ordinary AI tasks still
    // stop when their owning instance is destroyed.
    if(!variable_instance_exists(id,_field) || is_undefined(variable_instance_get(id,_field))) return;
    var _previous=global.fr_final_callback_scope,
        _final={source:real(id),snapshot:undefined,used:false};
    global.fr_final_callback_scope=_final;
    try {scrFRActorCallback(_field);}
    finally {
        if(_final.used) {
            var _snapshot={id:real(id),fr_with_value:real(id),x:x,y:y,object_index:object_index},
                _names=variable_instance_get_names(id);
            for(var _i=0;_i<array_length(_names);++_i)
                _snapshot[$ _names[_i]]=variable_instance_get(id,_names[_i]);
            _final.snapshot=_snapshot;
        }
        global.fr_final_callback_scope=_previous;
    }
}

function scrFRActorCleanup() {
    // A native object change with create-events disabled can acquire this
    // cleanup event without running the custom Create event. Still dispatch
    // any authored cleanup once; never reset its callbacks during teardown.
    if(variable_instance_exists(id,"fr_actor_cleaned") && fr_actor_cleaned) return;
    if(!variable_instance_exists(id,"fr_actor_cleaned") && scrNTTESmokeEnabled())
        scrNTTESmokeLog("FRONTIER CLEANUP UNINITIALIZED "+json_stringify({instance:real(id),object:object_get_name(object_index),name:self[$ "name"]??"",custom:self[$ "fr_custom_actor"]??false}));
    fr_actor_cleaned=true;
    scrFRActorFinalCallback("on_cleanup");
}

function scrFRActorDeath() {
    if(!can_die || hp>0) return false;
    if(!fr_actor_death_called) {
        fr_actor_death_called=true;
        scrFRActorCallback("on_death");
    }
    if(instance_exists(id)) instance_destroy();
    return true;
}

function scrFREnemyStep() {
    if(lockstep_stop || !scrFRReadyTick()) return;
    if(scrFRActorDeath()) return;
    if(wkick!=0) wkick=approach(wkick,0,1);
    scrTarget();
    scrFRActorCallback("on_step");
}

function scrFRPropStep() {
    if(lockstep_stop || !scrFRReadyTick()) return;
    if(scrFRActorDeath()) return;
    scrFRActorCallback("on_step");
}

function scrFRPropBeginStep() {
    if(lockstep_stop) return;
    // The custom Begin Step replaces prop.Begin Step, so preserve its
    // physical upkeep on every host frame, including 60 Hz render halves.
    // Explosions impart velocity before calling on_hurt; immobilizing only
    // in the 30 Hz source callback lets scenery drift between those ticks.
    if(self[$ "immmovable"]??false) speed=0;
    // Recover the ordinary hurt pose without overwriting authored special
    // animations, and leave death/removal to scrFRPropStep so source drops
    // and on_death run once before native prop.Destroy.
    if(sprite_index==spr_hurt && sprite_exists(spr_idle)
       && (image_index>2 || (nexthurt>0 && nexthurt<=current_frame))) {
        sprite_index=spr_idle;image_index=0;
    }
    scrFRActorStep("on_begin_step");
}

function scrFRActorStep(_field) {
    if(lockstep_stop || !scrFRReadyTick()) return;
    scrFRActorCallback(_field);
}

function scrFRActorDraw() {
    if(!is_undefined(on_draw)) {
        scrFRInvokeDraw(id,on_draw,[]);
        return;
    }
    var _sprite=sprite_index,_hurt=self[$ "spr_hurt"]??-1;
    if(!sprite_exists(_sprite)) _sprite=self[$ "spr_idle"]??-1;
    if((self[$ "nexthurt"]??0)>current_frame && sprite_exists(_hurt)) _sprite=_hurt;
    if(sprite_exists(_sprite))
        draw_sprite_ext(_sprite,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha);
}

function scrFRActorAnimationEnd(_destroy_default=false) {
    if(!is_undefined(on_anim)) scrFRActorCallback("on_anim");
    else if(_destroy_default) instance_destroy();
}

function scrFRProjectileCollision() {
    if(lockstep_stop || (team==other.team && other.team!=team_none)) return;
    if(!is_undefined(on_hit)) scrFRActorCallback("on_hit");
    else scr_projectile_generic_hit();
}

function scrFRProjectileWall() {
    if(lockstep_stop) return;
    if(!is_undefined(on_wall)) scrFRActorCallback("on_wall");
    else instance_destroy();
}

function scrFRSlashProjectileCallback() {
    if(lockstep_stop) return true;
    var _field=instance_is(other.id,Grenade)?"on_grenade":"on_projectile";
    if(is_undefined(variable_instance_get(id,_field))) return false;
    scrFRActorCallback(_field);
    return true;
}

function scrFRMaxHealthWrite(_target,_value,_op="=") {
    var _result=undefined;
    with(_target) {
        // Ordinary CustomObject corpses also assign maxhealth as data.
        // A plain assignment must not read a field that has never existed.
        if(_op=="=") max_hp=_value;
        else max_hp=scrFRNumericWrite(max_hp,_value,_op);
        var _custom_initial=false,_source_seen=false;
        if(variable_instance_exists(id,"fr_maxhealth_init")) _custom_initial=fr_maxhealth_init;
        if(variable_instance_exists(id,"fr_source_maxhealth_seen")) _source_seen=fr_source_maxhealth_seen;
        var _native_replacement=!_custom_initial && _op=="="
            && !_source_seen && instance_is(id,enemy);
        if((_custom_initial || _native_replacement) && abs(max_hp)<1/0) {
            fr_maxhealth_init=false;
            fr_source_maxhealth_seen=true;
            // NTT applies loop health at the first custom maxhealth write,
            // after the authored value is known, rather than to its dummy1.
            if(_custom_initial) max_hp*=1+GameCont.loops/20;
            if(_custom_initial && scrGameIsCustomMode()) {
                var _parameter=scrEnemyIsBoss(id)?"boss_health":"enemy_health";
                max_hp=max(1,floor(max_hp*scrCustomParam(_parameter)/100));
            }
            var _scarier=scr_skill_get(mut_scarier_face);
            if(_scarier) max_hp=floor(max_hp*power(.8,_scarier));
            // MicroSnowbot replaces native SnowBot health with a raw 2 after
            // its ordinary Create event. Its first authored replacement
            // needs the same HP mutation, without repeating native loop,
            // custom-mode, Crown or drop effects. Later heals/phase edits
            // operate on the already adjusted maximum.
            if(_custom_initial) max_hp=max(1,round(max_hp));
            hp=max_hp;
            if(_custom_initial) {
                if(scrCrownCheck(crwn_luck) && !scrEnemyIsBoss(id) && random(1)<=.1) hp=1;
            }
        }
        _result=max_hp;
    }
    return _result;
}

function scrFRNumericWrite(_previous,_value,_op) {
    switch(_op) {
        case "=":return _value;
        case "+=":return _previous+_value;
        case "-=":return _previous-_value;
        case "*=":return _previous*_value;
        case "/=":return _previous/_value;
        case "%=":return _previous mod _value;
        case "&=":return _previous&_value;
        case "|=":return _previous|_value;
        case "^=":return _previous^_value;
        case "<<=":return _previous<<_value;
        case ">>=":return _previous>>_value;
    }
    throw "Unsupported Frontier numeric assignment: "+string(_op);
}

function scrFRAlarmRead(_scope,_index) {
    _index=floor(_index);
    if(_index<0 || _index>=12) throw "Frontier alarm index outside0..11";
    if(is_struct(_scope)) {
        if(variable_struct_exists(_scope,"fr_actor_alarms")) return _scope.fr_actor_alarms[_index];
        return _scope[$ "alarm"+string(_index)]??-1;
    }
    if(!instance_exists(_scope)) return -1;
    if(_scope[$ "fr_custom_actor"]??false) return _scope.fr_actor_alarms[_index];
    return _scope.alarm[_index];
}

function scrFRAlarmWrite(_scope,_index,_value,_op="=") {
    var _written=scrFRNumericWrite(scrFRAlarmRead(_scope,_index),_value,_op);
    _index=floor(_index);
    if(is_struct(_scope)) {
        if(variable_struct_exists(_scope,"fr_actor_alarms")) _scope.fr_actor_alarms[_index]=_written;
        else _scope[$ "alarm"+string(_index)]=_written;
    } else if(instance_exists(_scope)) {
        if(_scope[$ "fr_custom_actor"]??false) _scope.fr_actor_alarms[_index]=_written;
        else _scope.alarm[_index]=_written;
    }
    return _written;
}

function scrFRAlarmIncrement(_scope,_index,_delta,_post=false) {
    var _previous=scrFRAlarmRead(_scope,_index);
    scrFRAlarmWrite(_scope,_index,_previous+_delta);
    return _post?_previous:(_previous+_delta);
}

// Bindings are real event receivers. Callback self is the binding; creator
// identifies its caller. Keeping those separate is required by source draw
// overlays, boss intros, and callbacks that destroy their own script object.
function scrFRBindingInit() {
    fr_binding=true;
    fr_binding_kind="step";
    fr_binding_code=undefined;
    fr_binding_args=[];
    fr_binding_descriptor=undefined;
    fr_binding_expire_serial=-1;
    creator=noone;
    script=undefined;
}

function scrFRBindingCreate(_kind,_code,_depth,_args) {
    var _binding=instance_create(x,y,FRBinding);
    _binding.fr_binding_kind=_kind;
    _binding.fr_binding_code=_code;
    _binding.fr_binding_args=_args;
    _binding.script=_code;
    _binding.creator=id;
    _binding.depth=_depth;
    return _binding;
}

function scrFRBindBeginStep(_code,_depth=0) {
    var _args=[];for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRBindingCreate("begin_step",_code,_depth,_args);
}

function scrFRBindStep(_code,_depth=0) {
    var _args=[];for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRBindingCreate("step",_code,_depth,_args);
}

function scrFRBindEndStep(_code,_depth=0) {
    var _args=[];for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRBindingCreate("end_step",_code,_depth,_args);
}

function scrFRBindDraw(_code,_depth=0) {
    var _args=[];for(var _i=2;_i<argument_count;++_i) array_push(_args,argument[_i]);
    return scrFRBindingCreate("draw",_code,_depth,_args);
}

function scrFRBind(_type,_code,_depth=0,_visible=true) {
    // This generic call is the NTTE teassets binding contract used by
    // libCharm. Its result is a descriptor, whose mutable script arguments
    // and .id visibility are updated by charm's begin-step hook.
    if(_type!=FRBinding) throw "Unsupported Frontier generic binding type";
    var _binding=scrFRBindingCreate("draw",_code,_depth,[]);
    _binding.visible=_visible;
    _binding.persistent=true;
    var _descriptor={object:_type,script:_code,depth:_depth,visible:_visible,id:_binding};
    _binding.fr_binding_descriptor=_descriptor;
    return _descriptor;
}

function scrFRBindingStep(_kind) {
    if(!scrFRReadyTick()) return;
    if(fr_binding_expire_serial>=0 && scrFRLogicSerial()>=fr_binding_expire_serial) {
        instance_destroy();return;
    }
    if(lockstep_stop || fr_binding_kind!=_kind) return;
    scrFRInvoke(id,fr_binding_code,fr_binding_args);
}

function scrFRBindingDraw() {
    if(fr_binding_kind!="draw") return;
    var _code=fr_binding_code;
    if(is_struct(fr_binding_descriptor)) {
        _code=fr_binding_descriptor.script;
        script=_code;
    }
    scrFRInvokeDraw(id,_code,fr_binding_args);
}

function scrFRInstanceDestroy(_target=undefined,_execute_event=true) {
    if(is_undefined(_target)) _target=id;
    // A source-created one-shot draw script must survive both render frames
    // of its source tick. Its creator replaces it on the next source tick.
    if(instance_exists(_target) && (_target[$ "fr_binding"]??false)
       && _target.fr_binding_kind=="draw" && variable_global_exists("fr_render_context") && global.fr_render_context) {
        if(_target.fr_binding_expire_serial<0)
            _target.fr_binding_expire_serial=scrFRLogicSerial()+1;
        return;
    }
    instance_destroy(_target,_execute_event);
}

// Original NTT9940 Effect descendants. Resolve real native counterparts once.
function scrFRNativeEffectTypes() {
    static _types=undefined;
    if(!is_undefined(_types)) return _types;
    _types=[FRSourceEffect,UGPlantHeal,FRChickenB];
    var _names=["PlasmaTrail", "EatRad", "NothingBeamHit", "RobotA", "EliteGruntFlame", "TangleKill", "FrogHeal", "CrystTrail", "PortalL", "BloodGamble", "GunGun", "ChickenB", "FishA", "Debris", "ChestOpen", "RabbitPaw", "Scorchmark", "MeltSplat", "TrapScorchMark", "Dust", "Bubble", "ImpactWrists", "ThrowHit", "Hammerhead", "AssassinNotice", "FishBoost", "Curse", "Wind", "BubblePop", "ReviveFX", "Breath", "CaveSparkle", "RainSplash", "RainDrop", "SnowFlake", "Drip", "WindNight", "FireFly", "Smoke", "LevelUp", "StrongSpirit", "BloodLust", "HorrorTB", "SteroidsTB", "RecycleGland", "AllyDamage", "RobotEat", "LaserBrain", "WepSwap", "DiscBounce", "Deflect", "DiscDisappear", "DiscTrail", "MeleeHitWall", "BulletHit", "GroundFlame", "BlueFlame", "BloodStreak", "AcidStreak", "EBulletHit", "FXChestOpen", "SmallChestPickup", "HealFX", "SmallChestFade", "GunWarrantEmpty", "ScorpionBulletHit", "LightningSpawn", "LightningHit", "PopupText", "Shell", "Feather", "ExploderExplo", "DustOLD", "SmokeOLD", "BoltStick", "LaserCharge", "IDPDPortalCharge", "Confetti", "Sweat", "PhantomBolt", "BoltTrail", "NothingBeamParticle", "NothingBeamChargeParticle"];
    for(var _i=0;_i<array_length(_names);++_i) {
        var _variants=[_names[_i],"NTTEFull"+_names[_i],"NTTE"+_names[_i]];
        for(var _j=0;_j<array_length(_variants);++_j) {
            var _type=asset_get_index(_variants[_j]);
            if(object_exists(_type) && !array_contains(_types,_type)) array_push(_types,_type);
        }
    }
    return _types;
}
