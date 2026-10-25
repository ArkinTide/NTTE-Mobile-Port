function scrNTTEFullVisualOptionsDrawTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_state=scrNTTEFullCoastDrawState(),
        _seed=random_get_seed(),_vx=view_xview,_vy=view_yview,_progress_graph={nodes:[]},
        _override=variable_global_exists("ntte_full_minor_quality")?global.ntte_full_minor_quality:undefined,
        _grid=variable_global_exists("ntte_full_trench_pit_grid")?global.ntte_full_trench_pit_grid:-1,
        _dirty=variable_global_exists("ntte_full_trench_pit_dirty")?global.ntte_full_trench_pit_dirty:false,
        _count=variable_global_exists("ntte_full_trench_floor_count")?global.ntte_full_trench_floor_count:-1,
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,GenCont,Menu,
            NTTEDesertDecor,NTTEFullTopObject,NTTEFullWorldEvent]),_output=-1,_camera=-1,_pixel_surfaces=[]
    scrNTTEFullAreaSnapshotContainer(global.ntte_full_progress,_progress_graph)
    var _progress={instances:[],containers:_progress_graph.nodes}
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    gpu_push_state()
    try {
        view_xview=10000;view_yview=10000;GameCont.loops=0;GameCont.hard=0
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.ntte_full_active_coast=true
        global.ntte_full_minor_quality=undefined
        variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:main",0)
        variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:minor",1)
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",false)
        var _main=1/3,_minor=scrNTTEFullSourceDisplayScale(),_sea=scrNTTEFullCoastSeaEnsure()
        var _initial_floor=instance_create(10000,10000,Floor)
        _output=surface_create(ceil(view_width),ceil(view_height))
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1)
        surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(c_black,0)
        draw_set_color(c_aqua);draw_set_alpha(0.7)
        var _draw_alpha=draw_get_alpha()
        with(_sea) event_perform(ev_draw,0)
        assert(_sea.ntte_coast_draw_ready && real(surface_get_target())==real(_output) && !_sea.ntte_coast_target_active
            && draw_get_color()==c_aqua && draw_get_alpha()==_draw_alpha,
            "Coast option-driven shader fallback did not preserve caller render target/color/alpha: ready="+string(_sea.ntte_coast_draw_ready)
            +" target="+string(surface_get_target())+" expected="+string(_output)+" active="+string(_sea.ntte_coast_target_active)
            +" color="+string(draw_get_color())+" expectedColor="+string(c_aqua)+" alpha="+string_format(draw_get_alpha(),1,12)
            +" beforeAlpha="+string_format(_draw_alpha,1,12)+" math_epsilon="+string_format(math_get_epsilon(),1,12)
            +" checks="+string([real(surface_get_target())==real(_output),draw_get_color()==c_aqua,draw_get_alpha()==_draw_alpha]))
        for(var _i=0;_i<8;++_i) {
            var _s=_sea.ntte_coast_surfaces[_i],_expected=(_i==5 || _i==6)?_main:_minor
            assert(abs(_s.scale-_expected)<=0.0000001 && surface_get_width(_s.surf)==max(1,ceil(_s.w*_expected))
                && surface_get_height(_s.surf)==max(1,ceil(_s.h*_expected)),
                "Coast actual surface lost main/minor source selector or floating display scale: "+string(_i))
        }
        // Actual renderer resizing: earlier fixture override remains usable,
        // including fractions and a value above the old invented quality cap.
        global.ntte_full_minor_quality=5.25
        with(_sea) event_perform(ev_draw,0)
        assert(_sea.ntte_coast_surfaces[7].scale==5.25
            && surface_get_width(_sea.ntte_coast_surfaces[0].surf)==ceil(2*(view_width+32)*5.25),
            "Coast actual minor surface imposed a custom cap or ignored fixture override")
        global.ntte_full_minor_quality=undefined
        // Pixel oracle from original teassets shader_setup[2], not the former
        // reversed exponent. The disabled-shader branch executes the source
        // inv-src-alpha/one copy plus three alpha-only copies.
        var _a={surf:surface_create(4,4),w:4,h:4,scale:1,x:0,y:0,reset:false},
            _scratch={surf:surface_create(4,4),w:4,h:4,scale:1,x:0,y:0,reset:false}
        _pixel_surfaces=[_a.surf,_scratch.surf];draw_set_color(c_white);draw_set_alpha(1)
        for(var _shader=0;_shader<=1;++_shader) {
            variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",_shader)
            with(_sea) {scrNTTEFullCoastSurfaceTarget(_a);draw_clear_alpha(make_color_rgb(60,40,20),0.125)}
            var _input=surface_getpixel_ext(_a.surf,1,1),_alpha=((_input>>24)&255)/255
            with(_sea) {
                var _used=scrNTTEFullCoastUnblendSurface(_a,_scratch)
                scrNTTEFullCoastDrawTargetRestore(_state)
            }
            var _pixel=surface_getpixel_ext(_a.surf,1,1),_expect_alpha=_shader?power(_alpha,0.25):min(1,5*_alpha-4*_alpha*_alpha)
            assert(_used==_shader && abs(((_pixel>>24)&255)-255*_expect_alpha)<=5,
                "Coast actual Unblend[2]/no-shader source alpha transform differs: "+string(_shader)+" pixel="+string(_pixel))
            var _channels=[color_get_red(_input),color_get_green(_input),color_get_blue(_input)],
                _got=[color_get_red(_pixel),color_get_green(_pixel),color_get_blue(_pixel)]
            for(var _c=0;_c<3;++_c) {
                var _want=_shader?min(255,_channels[_c]/power(_alpha,0.75)):min(255,_channels[_c]*(2-_alpha))
                assert(abs(_got[_c]-_want)<=5,"Coast source Unblend color differs at branch "+string(_shader)+" channel "+string(_c))
            }
            assert(real(surface_get_target())==real(_output),"Coast source Unblend lost active caller output")
        }
        surface_free(_a.surf);surface_free(_scratch.surf)
        draw_set_color(c_aqua);draw_set_alpha(0.7)
        _draw_alpha=draw_get_alpha()
        // Scrapyard reflection must entirely skip below2/3. At the exact
        // threshold it allocates the scaled real target; the shader-off path
        // still draws the source feet-only overlay without screenshot sampling.
        GameCont.ntte_full_active_coast=false;GameCont.area=area_scrapyards
        instance_create(10064,10064,Floor)
        var _pool=instance_create(10064,10064,NTTEFullSludgePool),_sludge=instance_find(NTTEFullSludgeDraw,0)
        _pool.visible=true;_pool.setup=false
        instance_create(10064,10064,Cactus)
        variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:minor",0)
        global.ntte_full_minor_quality=undefined
        with(_sludge) event_perform(ev_draw,0)
        assert(!surface_exists(_sludge.ntte_sludge_surface),"Sludge allocated/rendered below source quality2/3 threshold")
        global.ntte_full_minor_quality=2/3
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",false)
        with(_sludge) event_perform(ev_draw,0)
        assert(surface_get_width(_sludge.ntte_sludge_surface)==ceil(view_width*2/3)
            && surface_get_height(_sludge.ntte_sludge_surface)==ceil(view_height*2/3)
            && real(surface_get_target())==real(_output) && draw_get_color()==c_aqua && draw_get_alpha()==_draw_alpha,
            "Sludge exact threshold fallback lost scaled target or caller state")
        global.ntte_full_minor_quality=1.25
        variable_struct_set(global.ntte_full_progress.loadouts,"option:shaders",true)
        with(_sludge) event_perform(ev_draw,0)
        assert(surface_get_width(_sludge.ntte_sludge_surface)==ceil(view_width*1.25)
            && surface_get_height(_sludge.ntte_sludge_surface)==ceil(view_height*1.25) && real(surface_get_target())==real(_output),
            "Sludge shader-enabled actual surface failed fractional resize or leaked target")
        // Native Pit renderer: main mask/top at1/3, bottom and60px spark at
        // independent minor quality. Changing quality invalidates all caches.
        GameCont.area=scrNTTEFullAreaId("trench");GameCont.lastarea=GameCont.area
        global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
        ds_grid_clear(global.ntte_full_trench_pit_grid,false)
        // Native Floor.Create rejects a duplicate occupying an existing
        // tile. Convert the genuine Coast fixture tile rather than writing
        // sprite_index through a newly-created, already-destroyed handle.
        var _pit=_initial_floor;_pit.sprite_index=scrNTTERefSprite("FloorTrenchB")
        var _renderer=instance_create(0,0,NTTEFullPitRenderer),_spark=instance_create(10016,10016,NTTEFullPitSpark)
        _spark.ntte_full_tentacle_visible=true
        global.ntte_full_trench_pit_dirty=true
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_get_width(_renderer.ntte_full_surface)==ceil(2*view_width/3)
            && surface_get_height(_renderer.ntte_full_wall_top)==ceil(2*view_height/3)
            && surface_get_width(_renderer.ntte_full_wall_bot)==ceil(2*view_width*1.25)
            && surface_get_width(_renderer.ntte_full_spark_surface)==ceil(60*1.25)
            && real(surface_get_target())==real(_output) && draw_get_color()==c_aqua && draw_get_alpha()==_draw_alpha,
            "Trench actual main mask/top or minor bottom/spark quality selectors/state differ")
        global.ntte_full_minor_quality=5.25
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_get_width(_renderer.ntte_full_wall_bot)==ceil(2*view_width*5.25)
            && surface_get_width(_renderer.ntte_full_spark_surface)==ceil(60*5.25),
            "Trench actual bottom/spark cache resize imposed quality cap")
        // Actual pit mask pixels, including nested spark targets, a second
        // cached frame and render-target loss. Ordinary land must stay visible
        // below this layer; a full-alpha black fill reproduces the phone image.
        var _land=instance_create(10032,10000,Floor)
        assert(instance_exists(_land),"Trench alpha fixture lost ordinary land")
        _land.depth=8;_land.image_index=0;_pit.depth=9;_pit.image_index=0
        global.ntte_full_minor_quality=1.25
        assert(shader_is_compiled(shNTTEFullPitPresent),"iOS independent pit-mask shader failed compilation")
        for(var _mask_mode=0;_mask_mode<2;++_mask_mode) {
        _renderer.ntte_full_explicit_mask=(_mask_mode==1)
        for(var _quality=0;_quality<=1;++_quality) {
            variable_struct_set(global.ntte_full_progress.loadouts,"option:quality:main",_quality)
            for(var _lost=0;_lost<=1;++_lost) {
                _land.depth=_lost?10:8
                if(_lost) {
                    surface_free(_renderer.ntte_full_surface)
                    if(_mask_mode && surface_exists(_renderer.ntte_full_pit_mask)) surface_free(_renderer.ntte_full_pit_mask)
                }
                global.ntte_full_trench_pit_dirty=true
                for(var _frame=0;_frame<2;++_frame) {
                    camera_apply(_camera);draw_set_color(c_white);draw_set_alpha(1)
                    gpu_set_colorwriteenable(true,true,true,true);gpu_set_blendmode(bm_normal)
                    draw_clear_alpha(c_fuchsia,1)
                    with(_land) draw_self()
                    var _expected=surface_getpixel(_output,48,16),_edge_expected=surface_getpixel(_output,34,16)
                    gpu_set_fog(true,c_black,0,0);shader_set(shNTTEFullCoastUnblend)
                    with(_renderer) event_perform(ev_draw,0)
                    assert(shader_current()==shNTTEFullCoastUnblend,"Trench renderer leaked its presentation shader")
                    shader_reset();gpu_set_fog(false,0,0,0)
                    var _scale=_mask_mode ? _renderer.ntte_full_effective_main:scrNTTEFullVisualQuality("main"),
                        _mx=floor((10048-_renderer.ntte_full_draw_x)*_scale),
                        _my=floor((10016-_renderer.ntte_full_draw_y)*_scale),
                        _px=floor((10016-_renderer.ntte_full_draw_x)*_scale),
                        _mask_surface=_mask_mode ? _renderer.ntte_full_pit_mask:_renderer.ntte_full_surface,
                        _mask=surface_getpixel_ext(_mask_surface,_mx,_my),
                        _inside=surface_getpixel_ext(_mask_surface,_px,_my)
                    assert(((_mask>>24)&255)==0 && ((_inside>>24)&255)>=250,
                        "Trench nested composite changed mask alpha: "+string([_quality,_lost,_frame,_mask,_inside]))
                    assert(surface_getpixel(_output,48,16)==_expected && _expected!=c_black,
                        "Trench overlay hid the actual land sprite below it")
                    assert(surface_getpixel(_output,view_width-8,view_height-8)==c_fuchsia,
                        "Trench full-screen overlay erased background outside pits")
                    if(_mask_mode) assert(((surface_getpixel_ext(_renderer.ntte_full_surface,_mx,_my)>>24)&255)==255,
                        "Trench explicit-mask fixture did not exercise opaque scene alpha")
                    if(_land.depth==8) {
                        var _edge=surface_getpixel_ext(_mask_surface,
                            floor((10034-_renderer.ntte_full_draw_x)*_scale),_my)
                        assert(((_edge>>24)&255)==0 && surface_getpixel(_output,34,16)==_edge_expected,
                            "Trench spark circle crossed land and overwrote the zero-alpha mask")
                    }
                    assert(real(surface_get_target())==real(_output),"Trench alpha pass leaked a nested surface")
                }
            }
        }
        }
        // ProtoStatue.Destroy preassigns the next area while still in Trench.
        // Compare the WHOLE actual frame, not just alpha-cache metadata.
        GameCont.ntte_full_active_trench=true;GameCont.lastarea=GameCont.area
        var _prior=surface_getpixel(_output,48,16),_pit_prior=surface_getpixel(_output,16,16)
        GameCont.area=area_vault
        gpu_set_blendmode(bm_normal);draw_clear_alpha(c_fuchsia,1)
        with(_land) draw_self()
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_getpixel(_output,48,16)==_prior && surface_getpixel(_output,16,16)==_pit_prior
            && surface_getpixel(_output,view_width-8,view_height-8)==c_fuchsia,
            "Trench Vault portal preassignment changed land/pit/background appearance")
        GameCont.ntte_full_active_trench=false
        draw_clear_alpha(c_lime,1)
        with(_renderer) event_perform(ev_draw,0)
        assert(surface_getpixel(_output,16,16)==c_lime,"Trench overlay survived inactive Vault Transit")
        GameCont.area=GameCont.lastarea
        draw_clear_alpha(c_fuchsia,1);with(_land) draw_self()
        with(_renderer) event_perform(ev_draw,0)
        var _alpha_path=working_directory+"ntte-trench-alpha-"+string(30/timescale)+".png"
        surface_save(_output,_alpha_path)
        scrNTTESmokeLog("TRENCH ALPHA IMAGE "+_alpha_path)
        scrNTTESmokeLog("PASS Trench actual land pixels/pit alpha/nested sparks/cache frame/target loss/two quality settings")
    }
    finally {
        for(var _restore=0;_restore<16 && real(surface_get_target())!=real(_state.target);++_restore) surface_reset_target()
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        if(surface_exists(_output)) surface_free(_output)
        for(var _i=0;_i<array_length(_pixel_surfaces);++_i) if(surface_exists(_pixel_surfaces[_i])) surface_free(_pixel_surfaces[_i])
        if(_camera>=0) camera_destroy(_camera)
        if(variable_global_exists("ntte_full_trench_pit_grid") && global.ntte_full_trench_pit_grid!=_grid
            && ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) ds_grid_destroy(global.ntte_full_trench_pit_grid)
        global.ntte_full_trench_pit_grid=_grid;global.ntte_full_trench_pit_dirty=_dirty;global.ntte_full_trench_floor_count=_count
        global.ntte_full_minor_quality=_override
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_progress)
        view_xview=_vx;view_yview=_vy;random_set_seed(_seed)
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
        draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    }
    scrNTTESmokeLog("FULL VISUAL OPTIONS actual Coast8/Sludge/Pit mask+wall+spark targets/main+minor/default floating display/min1of3/fractional resize/no cap/sourceSludge2of3 threshold/Unblend[2]1of4+partial fallback pixels/caller target+draw state OK @"+string(30/timescale))
}
