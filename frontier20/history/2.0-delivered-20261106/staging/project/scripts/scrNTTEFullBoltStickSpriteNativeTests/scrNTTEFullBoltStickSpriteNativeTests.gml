// Controlled genuine native collision -> attached art -> native Draw/Step.
// The separate ParrotBConnected fixture supplies natural moving combat.
function scrNTTEFullBoltStickSpriteRender(_stick,_expectedSprite) {
    var _actual=-1,_expected=-1,_camera=-1,_target=false,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection)
    try {
        _actual=surface_create(64,64);_expected=surface_create(64,64)
        assert(surface_exists(_actual) && surface_exists(_expected),"BoltStick render surface allocation failed")
        _camera=camera_create_view(_stick.x-32,_stick.y-32,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_actual);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,0)
        with(_stick) event_perform(ev_draw,0)
        surface_reset_target();_target=false
        surface_set_target(_expected);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,0)
        draw_sprite_ext(_expectedSprite,_stick.image_index,_stick.x,_stick.y-_stick.z,
            _stick.image_xscale,_stick.image_yscale,_stick.image_angle,_stick.image_blend,_stick.image_alpha)
        surface_reset_target();_target=false
        var _opaque=0
        for(var _x=0;_x<64;++_x) for(var _y=0;_y<64;++_y) {
            var _a=surface_getpixel_ext(_actual,_x,_y),_b=surface_getpixel_ext(_expected,_x,_y)
            assert(_a==_b,"Actual BoltStick Draw diverged from attached projectile art")
            if(((int64(_a)>>24)&255)>0) _opaque++
        }
        assert(_opaque>0,"Actual BoltStick Draw emitted no visible projectile pixels")
    }
    finally {
        if(_target) surface_reset_target()
        if(surface_exists(_actual)) surface_free(_actual)
        if(surface_exists(_expected)) surface_free(_expected)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
    }
}

function scrNTTEFullBoltStickSpriteNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_source=scrNTTEFullSourceSeedState(),
        _nativeRng=array_create(array_length(global.rng_state)),
        _progress=global.ntte_full_progress,_progressBytes=json_stringify(global.ntte_full_progress),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),_coordinateBuffer=-1
    array_copy(_nativeRng,0,global.rng_state,0,array_length(global.rng_state))
    global.ntte_full_progress=json_parse(_progressBytes)
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_source)
    gpu_push_state()
    try {
        _coordinateBuffer=buffer_create(8,buffer_fixed,1)
        assert(buffer_exists(_coordinateBuffer),"BoltStick native coordinate oracle buffer allocation failed")
        GameCont.area=area_desert;GameCont.underwater=false
        shader_reset();gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);gpu_set_fog(false,0,0,0)
        draw_set_alpha(1);draw_set_color(c_white)
        for(var _nativeBolt=0;_nativeBolt<2;++_nativeBolt) {
            var _victim=instance_create(280032+_nativeBolt*256,280032,Bandit)
            _victim.hp=100;_victim.max_hp=100;_victim.nexthurt=current_frame-1;_victim.z=3
            _victim.team=_nativeBolt ? team_enemy:team_player
            var _shot=instance_create(_victim.x-16,_victim.y,_nativeBolt ? Bolt:NTTEFullDiverHarpoon)
            _shot.creator=instance_find(Player,0);_shot.team=_nativeBolt ? team_player:team_enemy
            _shot.direction=37;_shot.image_angle=37;_shot.speed=14*timescale
            var _sprite=_shot.sprite_index,_angle=_shot.image_angle,_damage=_shot.damage,
                _frame=_nativeBolt ? sprite_get_number(_sprite)-1:1,_old=scrNTTEFullInstances(BoltStick)
            assert(_sprite==sprBolt && sprite_exists(_sprite) && _damage==(_nativeBolt?20:4),
                "Real projectile constructor changed source Bolt art/damage")
            // Execute the actual native collision event, preserving other and
            // merged entry/exit dispatch; never invoke its Hit helper directly.
            with(_victim) with(_shot) event_perform(ev_collision,hitme)
            assert(!instance_exists(_shot) && _victim.hp==100-_damage,
                "Actual projectile collision changed damage or failed to consume projectile")
            var _sticks=scrNTTEFullInstances(BoltStick),_stick=noone,_new=0
            for(var _i=0;_i<array_length(_sticks);++_i) if(array_get_index(_old,_sticks[_i])<0) {
                _stick=_sticks[_i];_new++
            }
            assert(_new==1 && instance_exists(_stick) && _stick.object_index==BoltStick
                && _stick.sprite_index==_sprite && _stick.image_index==_frame && _stick.image_speed==0
                && _stick.image_angle==_angle && _stick.target==_victim,
                "Native collision attachment lost exact source projectile art/frame/angle/target")
            if(!_nativeBolt) assert(_victim.nexthurt>=current_frame+40,"Diver Harpoon lost source40tick hit window")
            scrNTTEFullBoltStickSpriteRender(_stick,_sprite)
            var _rng=random_get_seed(),_hp=_victim.hp
            _victim.x+=19;_victim.y+=7;_victim.visible=false
            // Native instance x/y store binary32; GML expression locals retain
            // more precision. Convert the independent source formula through
            // the buffer API instead of widening the positional tolerance.
            var _expectedZ=-_victim.z,_rawX=_victim.x-ldrx(16,_angle),
                _rawY=_victim.y-ldry(16,_angle)-_expectedZ
            buffer_poke(_coordinateBuffer,0,buffer_f32,_rawX)
            buffer_poke(_coordinateBuffer,4,buffer_f32,_rawY)
            var _expectedX=buffer_peek(_coordinateBuffer,0,buffer_f32),
                _expectedY=buffer_peek(_coordinateBuffer,4,buffer_f32)
            with(_stick) event_perform(ev_step,ev_step_normal)
            // Read-only raw-expression and native-storage evidence. All other
            // lifecycle predicates and the original1e-4 tolerance stay exact.
            var _follow={path:_nativeBolt?"Bolt":"DiverHarpoon",rate:30/timescale,
                stick_exists:instance_exists(_stick),victim:_victim,
                target_x:_victim.x,target_y:_victim.y,target_z:_victim.z,
                target_visible:_victim.visible,expected_angle:_angle,
                rng_before:_rng,rng_after:random_get_seed(),hp_before:_hp,hp_after:_victim.hp}
            if(instance_exists(_stick)) {
                _follow.stick=_stick;_follow.sprite=_stick.sprite_index;_follow.expected_sprite=_sprite
                _follow.target=_stick.target;_follow.z=_stick.z;_follow.angle=_stick.image_angle
                _follow.x=_stick.x;_follow.y=_stick.y;_follow.visible=_stick.visible
                _follow.raw_expected_x=_rawX;_follow.raw_expected_y=_rawY
                _follow.expected_x=_expectedX;_follow.expected_y=_expectedY
                _follow.raw_delta_x=_stick.x-_rawX;_follow.raw_delta_y=_stick.y-_rawY
                _follow.delta_x=_stick.x-_follow.expected_x;_follow.delta_y=_stick.y-_follow.expected_y
                _follow.sprite_ok=_stick.sprite_index==_sprite;_follow.target_ok=_stick.target==_victim
                _follow.z_ok=_stick.z==-_victim.z;_follow.x_ok=abs(_follow.delta_x)<0.0001
                _follow.y_ok=abs(_follow.delta_y)<0.0001;_follow.visible_ok=!_stick.visible
            }
            _follow.rng_ok=_follow.rng_after==_rng;_follow.hp_ok=_victim.hp==_hp
            scrNTTESmokeLog("BOLTSTICK FOLLOW DIAGNOSTIC "+json_stringify(_follow))
            assert(instance_exists(_stick) && _stick.sprite_index==_sprite && _stick.target==_victim
                && _stick.z==-_victim.z && abs(_stick.x-_expectedX)<0.0001
                && abs(_stick.y-_expectedY)<0.0001
                && !_stick.visible && random_get_seed()==_rng && _victim.hp==_hp,
                "Native BoltStick Step lost movement/z/visibility following or changed health/RNG")
            _victim.visible=true
            with(_stick) event_perform(ev_step,ev_step_normal)
            assert(_stick.visible,"Native BoltStick failed to follow target visibility restoration")
            scrNTTEFullBoltStickSpriteRender(_stick,_sprite)
            // Actual inherited enemy Step performs the genuine target death.
            // No projectile/attachment lifecycle is hidden or bypassed.
            _victim.hp=0
            with(_victim) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_victim),"Native target death failed in attachment lifecycle fixture")
            with(_stick) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_stick),"Native BoltStick survived missing/dead target")
        }
        scrNTTESmokeLog("FULL BOLTSTICK SPRITE: real DiverHarpoon/native Bolt collision events,source4/20damage+40tick,exact art/frame/angle/target,actual Draw pixel parity/native movement-z-visibility/dead-target cleanup OK @"+string(30/timescale))
    }
    finally {
        if(buffer_exists(_coordinateBuffer)) buffer_delete(_coordinateBuffer)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_progress=_progress
        array_copy(global.rng_state,0,_nativeRng,0,array_length(_nativeRng))
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state();random_set_seed(_seed)
        assert(global.ntte_full_progress==_progress && json_stringify(_progress)==_progressBytes,
            "BoltStick fixture changed original progress reference or contents")
    }
}
