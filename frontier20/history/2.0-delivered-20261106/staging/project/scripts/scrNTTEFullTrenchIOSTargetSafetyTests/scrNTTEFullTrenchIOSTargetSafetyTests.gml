function scrNTTEFullTrenchIOSTargetSafetyTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_state=scrNTTEFullCoastDrawState(),
        _seed=random_get_seed(),_vx=view_xview,_vy=view_yview,_vw=view_width,_vh=view_height,
        _override=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false,
        _count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1,
        _graph={nodes:[]},_output=-1,_camera=-1,
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,GenCont,Menu,
            NTTEDesertDecor,NTTEFullTopObject,NTTEFullWorldEvent])
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_graph)
    var _progress={instances:[],containers:_graph.nodes}
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        view_xview=10000;view_yview=10000;view_width=520;view_height=240
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.lastarea=GameCont.area
        GameCont.loops=0;GameCont.hard=0;GameCont.ntte_full_active_coast=false
        global.ntte_full_minor_quality=5.25
        variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:main",1)
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",true)
        global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
        ds_grid_clear(global.ntte_full_trench_pit_grid,false)
        var _pit=instance_create(10000,10000,Floor),_land=instance_create(10032,10000,Floor)
        assert(instance_exists(_pit) && instance_exists(_land),"Trench target fixture floors failed")
        _pit.sprite_index=scrNTTERefSprite("FloorTrenchB");_pit.depth=9;_pit.image_index=0
        _land.sprite_index=scrNTTERefSprite("FloorTrench");_land.depth=8;_land.image_index=0
        var _renderer=instance_create(0,0,NTTEFullPitRenderer)
        _renderer.ntte_full_explicit_mask=true
        _output=surface_create(view_width,view_height)
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1)
        assert(surface_set_target(_output),"Trench target fixture output bind failed")
        camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        gpu_set_colorwriteenable(true,true,true,true);draw_clear_alpha(c_fuchsia,1)
        draw_set_color(c_white);draw_set_alpha(1);with(_land) draw_self()
        var _land_pixel=surface_getpixel(_output,48,16)
        global.ntte_full_trench_pit_dirty=true
        with(_renderer) event_perform(ev_draw,0)
        var _main=_renderer.ntte_full_effective_main,_minor=_renderer.ntte_full_effective_minor
        assert(_main>0 && _minor>0 && _minor<5.25,
            "Trench iOS large-screen target did not bound requested physical scale")
        var _surfaces=[_renderer.ntte_full_surface,_renderer.ntte_full_wall_top,
            _renderer.ntte_full_wall_bot,_renderer.ntte_full_pit_mask]
        for(var _i=0;_i<array_length(_surfaces);++_i) {
            assert(surface_exists(_surfaces[_i]) && surface_get_width(_surfaces[_i])<=2048
                && surface_get_height(_surfaces[_i])<=2048,
                "Trench iOS allocated oversized framebuffer: "+string(_i))
        }
        assert(surface_get_width(_renderer.ntte_full_surface)==ceil(1040*_main)
            && surface_get_width(_renderer.ntte_full_wall_bot)==ceil(1040*_minor),
            "Trench effective reciprocal scale differs from actual target")
        assert(real(surface_get_target())==real(_output)
            && surface_getpixel(_output,48,16)==_land_pixel
            && surface_getpixel(_output,view_width-8,view_height-8)==c_fuchsia,
            "Trench bounded target composite erased land/background or lost parent")
        // Reproduce rejected framebuffer binding BEFORE a clear occurs. The
        // sentinel includes alpha as well as RGB, and caller state is poisoned.
        _renderer.ntte_full_ios_force_target_failure=true
        global.ntte_full_trench_pit_dirty=true
        camera_apply(_camera);shader_set(shNTTEFullCoastUnblend);gpu_set_fog(true,c_lime,0,0)
        draw_clear_alpha(c_aqua,0.5);draw_set_color(c_yellow);draw_set_alpha(0.73)
        var _sentinel=surface_getpixel_ext(_output,64,64),_alpha=draw_get_alpha(),
            _failures=_renderer.ntte_full_ios_target_failures
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_getpixel_ext(_output,64,64)==_sentinel
            && real(surface_get_target())==real(_output),
            "Failed Trench target cleared/popped enclosing framebuffer")
        assert(_renderer.ntte_full_ios_target_failures==_failures+1
            && _renderer.ntte_full_ios_surface_retry==1
            && global.ntte_full_trench_pit_dirty && _renderer.ntte_full_draw_x==-1,
            "Failed Trench target did not invalidate cache for a clean retry")
        assert(shader_current()==shNTTEFullCoastUnblend && draw_get_color()==c_yellow
            && draw_get_alpha()==_alpha,"Failed Trench target leaked shader/color/alpha state")
        _renderer.ntte_full_ios_force_target_failure=false
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        camera_apply(_camera);draw_clear_alpha(c_fuchsia,1);draw_set_color(c_white);draw_set_alpha(1)
        with(_land) draw_self()
        with(_renderer) event_perform(ev_draw,0)
        assert(_renderer.ntte_full_effective_main<=_main*0.5+0.0000001
            && _renderer.ntte_full_effective_minor<=_minor*0.5+0.0000001,
            "Trench rejected target did not halve actual capped scale immediately")
        assert(_renderer.ntte_full_draw_x!=-1 && !global.ntte_full_trench_pit_dirty
            && surface_getpixel(_output,48,16)==_land_pixel
            && surface_getpixel(_output,view_width-8,view_height-8)==c_fuchsia,
            "Trench target did not recover after a rejected bind")
        surface_free(_renderer.ntte_full_surface);surface_free(_renderer.ntte_full_pit_mask)
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_get_width(_renderer.ntte_full_surface)<=2048
            && real(surface_get_target())==real(_output),"Trench target loss bypassed size/parent safeguards")
        scrNTTESmokeLog("PASS Trench iOS 520px/5.25scale bounded scene+mask+wall targets; rejected bind leaves enclosing RGBA+draw state; retry and surface loss")
    }
    finally {
        for(var _restore=0;_restore<16 && real(surface_get_target())!=real(_state.target);++_restore) surface_reset_target()
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        if(surface_exists(_output)) surface_free(_output)
        if(_camera>=0) camera_destroy(_camera)
        if(variable_global_exists("ntte_full_trench_pit_grid") && global.ntte_full_trench_pit_grid!=_grid
            && ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) ds_grid_destroy(global.ntte_full_trench_pit_grid)
        global.ntte_full_trench_pit_grid=_grid;global.ntte_full_trench_pit_dirty=_dirty;global.ntte_full_trench_floor_count=_count
        global.ntte_full_minor_quality=_override
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_progress)
        view_xview=_vx;view_yview=_vy;view_width=_vw;view_height=_vh;random_set_seed(_seed)
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
}
