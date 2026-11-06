function scrNTTEFullOutlineProbeDraw() {
    ntte_probe_draws++;ntte_probe_state.counter++
    image_index+=0.25;random(100)
    instance_create(x,y,NTTEFullOutlineDrawDebrisProbe)
    draw_set_color(c_white);draw_rectangle(x,y,x+4,y+4,false)
    draw_set_color(make_color_rgb(252,56,0));draw_point(x+1,y+1)
    draw_set_color(make_color_rgb(200,0,1));draw_point(x+2,y+1)
    draw_set_color(make_color_rgb(201,0,1));draw_point(x+4,y+3)
}
function scrNTTEFullOutlineOptionsNativeTests() {
    assert(scrNTTESmokeEnabled(),"Outline rendering requires explicit actual desktop fixture")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_progress=global.ntte_full_progress,
        _view=[view_xview,view_yview,view_width,view_height],_seed=random_get_seed(),
        _world=matrix_get(matrix_world),_matrixview=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),_target=false,
        _hidden=scrNTTEFullInstances([Menu,NTTEFullOutlineCache,NTTEFullCharmOutlineDraw]),
        _oldCharmList=scrNTTEFullValue(GameCont,"ntte_charm_instance_list",[]),
        _oldCharmVars=scrNTTEFullValue(GameCont,"ntte_charm_instance_vars",[]),
        _p=instance_find(Player,0),_pinst=scr_playerinstance_find(_p.index),_ownercolor=_pinst.color,
        _screen=-1,_camera=-1
    global.ntte_full_progress=json_parse(json_stringify(_progress))
    GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    gpu_push_state()
    try {
        view_xview=0;view_yview=0;view_width=64;view_height=64
        _pinst.color=c_lime
        var _opts=global.ntte_full_progress.loadouts,_display=scrNTTEFullSourceDisplayScale()
        // Select exact one-to-one cache scale through the real source option
        // interpolation; raw capture still follows the actual target scale.
        _opts[$ "option:quality:main"]=(1-1/3)/(_display-1/3)
        _opts[$ "option:outline:pets"]=1;_opts[$ "option:outline:charm"]=1;_opts[$ "option:shaders"]=1
        _screen=surface_create(64,64);assert(surface_exists(_screen),"Outline actual target allocation failed")
        _camera=camera_create_view(0,0,64,64,0,noone,-1,-1,-1,-1)
        surface_set_target(_screen);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_set_alpha(1);draw_set_color(c_white)
        var _background=make_color_rgb(12,30,70),_pet=instance_create(24,24,NTTEFullPet)
        _pet.leader=_p;_pet.spr_shadow=-1;_pet.ntte_probe_draws=0
        _pet.hooks.draw=method(_pet,function(_spr,_img,_x,_y,_xs,_ys,_ang,_col,_a) {
            ntte_probe_draws++;draw_set_color(c_white);draw_set_alpha(_a)
            draw_rectangle(_x,_y,_x+2,_y+2,false)
        })
        draw_clear_alpha(_background,1)
        with(_pet) event_perform(ev_draw,0)
        assert(_pet.ntte_probe_draws==1 && surface_getpixel(_screen,25,25)==c_white
            && surface_getpixel(_screen,23,25)==c_lime && surface_getpixel(_screen,25,23)==c_lime
            && surface_getpixel(_screen,27,25)==c_lime && surface_getpixel(_screen,25,27)==c_lime
            && surface_getpixel(_screen,23,23)==_background && surface_getpixel(_screen,3,3)==_background,
            "Actual Pet Draw lost single body-hook call, owner-color cardinal outline, body or untouched background")
        var _manager=scrNTTEFullOutlineManager(),_petcache=_manager.entries[$ "Pet"]
        assert(surface_get_width(_petcache.surf)==64 && surface_get_height(_petcache.surf)==64,
            "Pet cache ignored exact source main quality interpolation")
        _opts[$ "option:outline:pets"]=0;draw_clear_alpha(_background,1)
        with(_pet) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,23,25)==_background && _pet.ntte_probe_draws==2,
            "Disabled Pet outline still drew or duplicated body hook")
        _opts[$ "option:outline:pets"]=1;_pet.leader=noone;draw_clear_alpha(_background,1)
        with(_pet) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,23,25)==_background,"Unowned Pet acquired a source outline")
        _pet.leader=_p;_pet.revive=_pet;draw_clear_alpha(_background,1)
        with(_pet) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,23,25)==_background,"Reviving Pet acquired a source outline")
        _pet.revive=noone
        // Exercise actual visible-enemy grouping and dynamic source depth.
        var _probe=instance_create(40,24,NTTEFullCharmOutlineDrawProbe),
            _other=instance_create(120,120,NTTEFullCharmOutlineDrawProbe),
            _native=instance_create(120,120,Bandit)
        _probe.depth=5;_other.depth=-9;_native.depth=2
        var _vars=scrNTTEFullParrotCharm(_probe,true);_vars.index=_p.index
        _vars=scrNTTEFullParrotCharm(_other,true);_vars.index=_p.index
        _vars=scrNTTEFullParrotCharm(_native,true);_vars.index=-1
        scrNTTEFullCharmOutlineSync()
        var _groups=_manager.groups,_group=noone,_fallback=noone
        for(var _i=0;_i<array_length(_groups);++_i) {
            if(_groups[_i].owner_index==_p.index) _group=_groups[_i]
            else if(_groups[_i].owner_index==-1) _fallback=_groups[_i]
        }
        assert(instance_exists(_group) && _group.visible && array_length(_group.members)==2 && _group.depth==-10
            && instance_exists(_fallback) && _fallback.depth==1,
            "Real charmed-enemy renderers lost owner grouping or minimum member.depth-1 ordering")
        _other.visible=false;scrNTTEFullCharmOutlineSync()
        assert(array_length(_group.members)==1 && _group.depth==4,"Hidden charm members still influenced source list/depth")
        draw_clear_alpha(_background,1)
        var _replay_seed=random_get_seed(),_image=_probe.image_index,_debris=instance_number(NTTEFullOutlineDrawDebrisProbe)
        with(_group) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,39,26)==c_lime && surface_getpixel(_screen,40,24)==_background
            && surface_getpixel(_screen,41,25)==make_color_rgb(56,252,0)
            && surface_getpixel(_screen,42,25)==make_color_rgb(0,200,1)
            && surface_getpixel(_screen,44,27)==_background,
            "Actual Charm overlay lost hollow cardinal outline, exact eye-color/neighbor swap, or recolored unrelated body pixels")
        assert(_probe.ntte_probe_draws==0 && _probe.ntte_probe_state.counter==7 && _probe.image_index==_image
            && random_get_seed()==_replay_seed && instance_number(NTTEFullOutlineDrawDebrisProbe)==_debris,
            "Charm Draw replay leaked native animation, nested actor state, RNG or newly spawned instances")
        _opts[$ "option:shaders"]=0;draw_clear_alpha(_background,1)
        with(_group) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,39,26)==c_lime && surface_getpixel(_screen,41,25)==_background,
            "Shader-disabled Charm failed original no-shader outline or still changed eye pixels")
        _opts[$ "option:outline:charm"]=0;_opts[$ "option:shaders"]=1;draw_clear_alpha(_background,1)
        with(_group) event_perform(ev_draw,0)
        assert(surface_getpixel(_screen,39,26)==_background && surface_getpixel(_screen,41,25)==make_color_rgb(56,252,0),
            "Charm eye shader depended on outline being enabled")
        // A real native Bandit Draw must be replayed without altering its
        // original movement/health/animation/alarm data or the main target.
        _native.x=10;_native.y=45;_native.xprevious=9;_native.depth=-3
        var _native_hp=_native.hp,_native_alarm=_native.alarm[0],_native_image=_native.image_index
        scrNTTEFullCharmOutlineSync();with(_fallback) event_perform(ev_draw,0)
        assert(_native.x==10 && _native.xprevious==9 && _native.hp==_native_hp
            && _native.alarm[0]==_native_alarm && _native.image_index==_native_image && surface_get_target()==_screen,
            "Actual Bandit charm replay changed original native state or target stack")
        // The same original eye shader now identifies ordinary friendly
        // enemies, without granting a charm lifetime or adding heart art.
        var _friends=[],_registered=array_length(GameCont.ntte_charm_instance_list),_rate=game_get_speed(gamespeed_fps)
        for(var _i=0;_i<20;++_i) {
            var _friend=instance_create(2+(_i mod 8)*7,2+(_i div 8)*7,NTTEFullCharmOutlineDrawProbe)
            _friend.team=team_player;array_push(_friends,_friend)
        }
        scrNTTEFullCharmOutlineSync()
        assert(array_length(_group.members)==21 && array_length(GameCont.ntte_charm_instance_list)==_registered,
            "Friendly eye grouping omitted native allies or registered a gameplay charm")
        _opts[$ "option:outline:charm"]=0;_opts[$ "option:shaders"]=1
        var _draw_start=get_timer(),_stress_seed=random_get_seed(),_stress_count=instance_number(all)
        for(var _frame=0;_frame<6;++_frame) {
            draw_clear_alpha(_background,1);with(_group) event_perform(ev_draw,0)
            assert(surface_getpixel(_screen,3,3)==make_color_rgb(56,252,0),
                "Ordinary friendly enemy did not receive original Parrot green-eye pixels")
            assert(instance_number(all)==_stress_count && random_get_seed()==_stress_seed
                && _friends[0].ntte_probe_draws==0 && _friends[0].ntte_probe_state.counter==7
                && game_get_speed(gamespeed_fps)==_rate,
                "Twenty-ally eye replay leaked effects/state/RNG or changed configured frame rate")
        }
        scrNTTESmokeLog("PARROT EYE DRAW stress "+json_stringify({allies:20,frames:6,
            mean_cpu_us:(get_timer()-_draw_start)/6,configured_fps:_rate,mobile_device_tested:false}))
        for(var _i=0;_i<array_length(_friends);++_i) {
            assert(is_undefined(scrNTTEFullValue(_friends[_i],"ntte_charm",undefined)),
                "Friendly green-eye overlay created gameplay charm state")
            instance_destroy(_friends[_i],false)
        }
        scrNTTEFullCharmOutlineSync()
        scrNTTEFullCharmReadonlyReplayTests(_screen,_background)
        scrNTTEFullArmedCharmReadonlyTests(_screen,_background)
        // Surface recreation and the source30-logical-frame expiry path.
        var _oldcache=_manager.entries[$ "Charm"],_oldsurf=_oldcache.surf
        surface_free(_oldsurf)
        var _rebuilt=scrNTTEFullOutlineCacheSetup("Charm",64,64,0.5)
        assert(surface_exists(_rebuilt.surf) && surface_get_width(_rebuilt.surf)==32,
            "Source outline cache failed context-loss/quality resize recreation")
        _rebuilt.time=timescale;with(_manager) event_perform(ev_step,ev_step_normal)
        assert(!surface_exists(_rebuilt.surf),"Unused source outline cache did not expire after logical timeout")
        scrNTTESmokeLog("PASS actual Pet body Draw and one-call hooks/cardinal owner outlines/disabled+unowned+revive gates, Charm visible owner groups/dynamicdepth/hollow overlays/exact15-eye shader+red-neighbor/no-shader and eye-only options, native Bandit replay/state+RNG+spawn rollback, main quality/contextloss/expiry/target preservation")
    }
    finally {
        if(_target) surface_reset_target()
        _pinst.color=_ownercolor
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        if(surface_exists(_screen)) surface_free(_screen)
        if(_camera>=0) camera_destroy(_camera)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        GameCont.ntte_charm_instance_list=_oldCharmList;GameCont.ntte_charm_instance_vars=_oldCharmVars
        global.ntte_full_progress=_progress
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3]
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_matrixview);matrix_set(matrix_projection,_projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state();random_set_seed(_seed)
    }
}

function scrNTTEFullCharmReadonlyReplayTests(_screen,_background) {
    var _before=scrNTTEFullInstances(all),_opts=global.ntte_full_progress.loadouts,
        _oldoutline=_opts[$ "option:outline:charm"],_oldshader=_opts[$ "option:shaders"],
        _group=instance_create(0,0,NTTEFullCharmOutlineDraw),_fly=instance_create(32,32,JungleFly),
        _reference=-1,_a=-1,_b=-1,_target=false,_p=instance_find(Player,0),_rate=game_get_speed(gamespeed_fps)
    try {
        _reference=surface_create(64,64);assert(surface_exists(_reference),"Readonly charm reference target failed")
        _a=buffer_create(64*64*4,buffer_fixed,1);_b=buffer_create(64*64*4,buffer_fixed,1)
        _fly.team=team_player;_fly.ntte_charm=scrNTTEFullParrotCharmNew();_fly.ntte_charm.charmed=true
        _group.members=[_fly];_group.owner_index=_p.index
        assert(scrNTTEFullCharmReplayReadOnly([_fly]),"Real JungleFly missed verified readonly Draw path")
        var _unsafe=instance_create(120,120,NTTEFullCharmOutlineDrawProbe)
        assert(!scrNTTEFullCharmReplayReadOnly([_fly,_unsafe]),"Mixed readonly/side-effect Draw group skipped transaction")
        var _pixel_cases=0
        for(var _pose=0;_pose<2;++_pose) for(var _case=0;_case<4;++_case) {
            _fly.sprite_index=_pose==0?sprJungleFlyIdle:sprJungleFlyWalk;_fly.image_index=_pose;_fly.right=_pose==0?1:-1
            _opts[$ "option:outline:charm"]=_case<2?1:0
            _opts[$ "option:shaders"]=_case==1 || _case==3?0:1
            var _seed=random_get_seed(),_rng=json_stringify(global.rng_state),
                _state=scrNTTEFullSourceSeedState(),_source=_state.random,
                _actor=[_fly.x,_fly.y,_fly.xprevious,_fly.yprevious,_fly.hp,_fly.speed,_fly.direction,
                    _fly.image_index,_fly.image_angle,_fly.alarm[1],_fly.team,json_stringify(_fly.ntte_charm)],
                _count=instance_number(all)
            surface_set_target(_reference);_target=true;draw_clear_alpha(_background,1)
            with(_group) scrNTTEFullCharmOutlineDraw(true)
            surface_reset_target();_target=false
            draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw()
            assert(surface_get_target()==_screen,"Readonly charm changed outer framebuffer target")
            buffer_get_surface(_a,_screen,0);buffer_get_surface(_b,_reference,0)
            for(var _offset=0;_offset<64*64*4;_offset+=4)
                assert(buffer_peek(_a,_offset,buffer_u32)==buffer_peek(_b,_offset,buffer_u32),
                    "JungleFly readonly charm changed native baseline RGBA pose="+string(_pose)+" option="+string(_case)+" pixel="+string(_offset div 4))
            _pixel_cases++
            assert(json_stringify(_actor)==json_stringify([_fly.x,_fly.y,_fly.xprevious,_fly.yprevious,_fly.hp,_fly.speed,_fly.direction,
                _fly.image_index,_fly.image_angle,_fly.alarm[1],_fly.team,json_stringify(_fly.ntte_charm)])
                && instance_number(all)==_count && random_get_seed()==_seed && json_stringify(global.rng_state)==_rng
                && _state.random==_source && game_get_speed(gamespeed_fps)==_rate,
                "Readonly JungleFly replay changed actual actor/charm/alarm state,scene membership,RNG or engine rate")
        }
        _opts[$ "option:outline:charm"]=1;_opts[$ "option:shaders"]=1
        for(var _i=0;_i<1200;++_i) instance_create(30000+_i,30000,NTTEFullOutlineDrawDebrisProbe)
        with(_group) {scrNTTEFullCharmOutlineDraw(true);scrNTTEFullCharmOutlineDraw();}
        var _frames=12,_oldstart=get_timer()
        for(var _i=0;_i<_frames;++_i) {draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw(true);}
        var _oldcpu=get_timer()-_oldstart,_newstart=get_timer()
        for(var _i=0;_i<_frames;++_i) {draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw();}
        var _newcpu=get_timer()-_newstart
        scrNTTESmokeLog("JUNGLEFLY CHARM READONLY "+json_stringify({rgba_cases:_pixel_cases,pixels:64*64*_pixel_cases,
            synthetic_scene_instances:instance_number(all),frames:_frames,old_mean_cpu_us:_oldcpu/_frames,new_mean_cpu_us:_newcpu/_frames,
            configured_fps:_rate,mobile_device_tested:false}))
    }
    finally {
        if(_target) surface_reset_target()
        _opts[$ "option:outline:charm"]=_oldoutline;_opts[$ "option:shaders"]=_oldshader
        if(buffer_exists(_a)) buffer_delete(_a);if(buffer_exists(_b)) buffer_delete(_b)
        if(surface_exists(_reference)) surface_free(_reference)
        var _after=scrNTTEFullInstances(all)
        for(var _i=array_length(_after)-1;_i>=0;--_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
    }
}

function scrNTTEFullArmedCharmReadonlyTests(_screen,_background) {
    var _before=scrNTTEFullParrotCharmInstanceSet(),_opts=global.ntte_full_progress.loadouts,
        _oldoutline=_opts[$ "option:outline:charm"],_oldshader=_opts[$ "option:shaders"],
        _underwater=GameCont.underwater,_group=instance_create(0,0,NTTEFullCharmOutlineDraw),
        _reference=-1,_a=-1,_b=-1,_target=false,_p=instance_find(Player,0),_rate=game_get_speed(gamespeed_fps),
        _types=[Bandit,NTTEFullBanditCamper,NTTEFullMinerBandit,NTTEFullBanditHiker,NTTEBat],_actors=[],_cases=0
    try {
        _reference=surface_create(64,64);assert(surface_exists(_reference),"Armed charm reference target failed")
        _a=buffer_create(64*64*4,buffer_fixed,1);_b=buffer_create(64*64*4,buffer_fixed,1)
        _group.owner_index=_p.index
        for(var _type=0;_type<array_length(_types);++_type) {
            var _actor=instance_create(32,32,_types[_type]);array_push(_actors,_actor)
            _actor.team=team_player;_actor.ntte_charm=scrNTTEFullParrotCharmNew();_actor.ntte_charm.charmed=true
            _group.members=[_actor]
            assert(scrNTTEFullCharmReplayReadOnly([_actor]),"Verified armed friend missed readonly Draw: "+object_get_name(_actor.object_index))
            for(var _pose=0;_pose<4;++_pose) for(var _water=0;_water<2;++_water)
            for(var _frame=0;_frame<2;++_frame) for(var _option=0;_option<4;++_option) {
                _actor.gunangle=_pose<2?95:275;_actor.right=(_pose mod 2)==0?1:-1;_actor.wkick=3
                _actor.sprite_index=_frame==0?_actor.spr_idle:_actor.spr_walk
                _actor.image_index=min(_frame,sprite_get_number(_actor.sprite_index)-1)
                GameCont.underwater=_water==1
                _opts[$ "option:outline:charm"]=_option<2?1:0
                _opts[$ "option:shaders"]=_option==1 || _option==3?0:1
                var _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_state=scrNTTEFullSourceSeedState(),_source=_state.random,
                    _actorstate=json_stringify([_actor.x,_actor.y,_actor.xprevious,_actor.yprevious,_actor.hp,_actor.speed,
                        _actor.direction,_actor.sprite_index,_actor.image_index,_actor.image_angle,_actor.gunangle,_actor.wkick,
                        _actor.right,_actor.team,_actor.alarm[1],_actor.ntte_charm]),_count=instance_number(all)
                surface_set_target(_reference);_target=true;draw_clear_alpha(_background,1)
                with(_group) scrNTTEFullCharmOutlineDraw(true)
                surface_reset_target();_target=false
                draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw()
                assert(surface_get_target()==_screen,"Armed charm changed outer framebuffer target")
                buffer_get_surface(_a,_screen,0);buffer_get_surface(_b,_reference,0)
                for(var _offset=0;_offset<64*64*4;_offset+=4)
                    assert(buffer_peek(_a,_offset,buffer_u32)==buffer_peek(_b,_offset,buffer_u32),
                        "Armed readonly native RGBA mismatch type="+object_get_name(_actor.object_index)+" pose="+string(_pose)
                            +" water="+string(_water)+" frame="+string(_frame)+" option="+string(_option)+" pixel="+string(_offset div 4))
                _cases++
                assert(_actorstate==json_stringify([_actor.x,_actor.y,_actor.xprevious,_actor.yprevious,_actor.hp,_actor.speed,
                    _actor.direction,_actor.sprite_index,_actor.image_index,_actor.image_angle,_actor.gunangle,_actor.wkick,
                    _actor.right,_actor.team,_actor.alarm[1],_actor.ntte_charm]) && instance_number(all)==_count
                    && random_get_seed()==_seed && json_stringify(global.rng_state)==_rng && _state.random==_source
                    && game_get_speed(gamespeed_fps)==_rate,"Armed readonly replay changed real state/scene/RNG/frame rate")
            }
        }
        _opts[$ "option:outline:charm"]=1;_opts[$ "option:shaders"]=1;GameCont.underwater=false
        var _unsafe=instance_create(40,24,NTTEFullCharmOutlineDrawProbe),_safe=_actors[0]
        _safe.ntte_probe_state=_unsafe.ntte_probe_state
        _group.members=[_safe,_unsafe]
        assert(!scrNTTEFullCharmReplayReadOnly(_group.members),"Mixed armed/side-effect group lost gameplay transaction")
        var _seed=random_get_seed(),_rng=json_stringify(global.rng_state),_debris=instance_number(NTTEFullOutlineDrawDebrisProbe),_image=_unsafe.image_index
        draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw()
        assert(_unsafe.ntte_probe_draws==0 && _unsafe.ntte_probe_state.counter==7 && _safe.ntte_probe_state.counter==7
            && _safe.ntte_probe_state==_unsafe.ntte_probe_state && _unsafe.image_index==_image
            && instance_number(NTTEFullOutlineDrawDebrisProbe)==_debris && random_get_seed()==_seed
            && json_stringify(global.rng_state)==_rng,"Mixed armed group leaked shared graph/state/spawn/RNG")
        _group.members=scrNTTEFullArrayCopy(_actors)
        for(var _i=0;_i<15;++_i) {
            var _friend=instance_create(4+(_i mod 6)*9,8+(_i div 6)*15,(_i mod 2)==0?Bandit:NTTEBat)
            _friend.team=team_player;array_push(_group.members,_friend)
        }
        for(var _i=0;_i<1200;++_i) instance_create(30000+_i,30000,NTTEFullOutlineDrawDebrisProbe)
        assert(array_length(_group.members)==20 && scrNTTEFullCharmReplayReadOnly(_group.members),"Twenty real armed friends failed verified group")
        with(_group) {scrNTTEFullCharmOutlineDraw(true);scrNTTEFullCharmOutlineDraw();}
        var _frames=12,_oldstart=get_timer()
        for(var _i=0;_i<_frames;++_i) {draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw(true);}
        var _oldcpu=get_timer()-_oldstart,_newstart=get_timer()
        for(var _i=0;_i<_frames;++_i) {draw_clear_alpha(_background,1);with(_group) scrNTTEFullCharmOutlineDraw();}
        var _newcpu=get_timer()-_newstart
        scrNTTESmokeLog("ARMED FRIEND CHARM READONLY "+json_stringify({native_types:array_length(_types),rgba_cases:_cases,
            pixels:64*64*_cases,armed_friends:array_length(_group.members),synthetic_scene_instances:instance_number(all),frames:_frames,
            old_mean_cpu_us:_oldcpu/_frames,new_mean_cpu_us:_newcpu/_frames,configured_fps:_rate,mobile_device_tested:false}))
    }
    finally {
        if(_target) surface_reset_target()
        GameCont.underwater=_underwater;_opts[$ "option:outline:charm"]=_oldoutline;_opts[$ "option:shaders"]=_oldshader
        if(buffer_exists(_a)) buffer_delete(_a);if(buffer_exists(_b)) buffer_delete(_b)
        if(surface_exists(_reference)) surface_free(_reference)
        with(all) if(!variable_struct_exists(_before,string(id))) instance_destroy(id,false)
    }
}
