// Native constructors / actual graphics / ordinary transitions. These fixtures
// do not enable natural access before the entire renderer batch passes review.
function scrNTTEFullCoastUnblendSmoke() {
    assert(shader_is_compiled(shNTTEFullCoastUnblend),"Coast original Unblend2 shader failed compilation")
    var _a=surface_create(4,4),_b=surface_create(4,4),_camera=camera_create_view(0,0,4,4,0,noone,-1,-1,-1,-1),
        _state=scrNTTEFullCoastDrawState()
    gpu_push_state(); draw_set_alpha(1); draw_set_color(c_white)
    surface_set_target(_a); camera_apply(_camera); draw_clear_alpha(make_color_rgb(200,100,50),0.5); surface_reset_target()
    surface_set_target(_b); camera_apply(_camera); draw_clear_alpha(c_black,0)
    gpu_set_blendmode_ext(bm_one,bm_zero); shader_set(shNTTEFullCoastUnblend); draw_surface(_a,0,0)
    shader_reset(); surface_reset_target(); gpu_pop_state()
    matrix_set(matrix_world,_state.world); matrix_set(matrix_view,_state.view); matrix_set(matrix_projection,_state.projection)
    draw_set_color(_state.color); draw_set_alpha(_state.alpha)
    var _pixel=surface_getpixel_ext(_b,1,1),_alpha=(_pixel>>24)&255
    var _a8=128/255,_power=0.25,_div=power(_a8,1-_power)
    assert(abs(color_get_red(_pixel)-min(255,200/_div))<=3 && abs(color_get_green(_pixel)-min(255,100/_div))<=3
        && abs(color_get_blue(_pixel)-min(255,50/_div))<=3 && abs(_alpha-255*power(_a8,_power))<=3,
        "Coast Unblend[2] lost source reciprocal-power1/4 channel transform; pixel="+string(_pixel))
    surface_free(_a); surface_free(_b); camera_destroy(_camera)
    scrNTTESmokeLog("FULL COAST UNBLEND: real native source Unblend[2] reciprocal-power1/4 pixels OK @"+string(30/timescale))
}
function scrNTTEFullCoastConstructSmoke() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    GameCont.area=scrNTTEFullAreaId("coast"); GameCont.subarea=1; GameCont.ntte_full_active_coast=true
    scrNTTEFullCoastSeaEnsure()
    var _floor=instance_create(40000,40000,Floor),_floor_b=instance_create(40032,40000,Floor),
        _enemy=instance_create(40016,40016,NTTEFullTrafficCrab)
    assert(_floor.area==GameCont.area && _floor.material==1 && _enemy.wading==0 && _enemy.canwade,
        "Coast real native floor/TrafficCrab constructor lost origin/material/wading fields")
    var _wall_count=instance_number(Wall),_top_count=instance_number(TopSmall),_floor_count=instance_number(FloorExplo)
    instance_create(40100,40100,Wall); instance_create(40132,40100,TopSmall); instance_create(40164,40100,FloorExplo)
    assert(instance_number(Wall)==_wall_count && instance_number(TopSmall)==_top_count && instance_number(FloorExplo)==_floor_count,
        "Coast constructors left source-visible walls/tops/destroyed-floor patches")
    var _corpse=instance_create(40200,40016,NTTEFullCoastDecalCorpse)
    assert(instance_exists(_corpse.my_floor) && !_corpse.my_floor.visible && _corpse.my_floor.mask_index==mskAlly,
        "Coast source corpse invisible support was removed by ordinary unwalls constructor hook")
    var _dust=instance_create(40300,40016,Dust)
    assert(!instance_exists(_dust),"Coast ocean Dust failed immediate water replacement")
    var _splat=instance_create(40300,40016,MeltSplat)
    assert(!instance_exists(_splat),"Coast ocean MeltSplat failed immediate splash replacement")
    var _portal=instance_create(40016,40016,Portal)
    with(_portal) assert(!visible && type==1 && endgame==100 && alarm[0]==-1 && distance_to_object(Floor)>=120
        && xstart==x && ystart==y && xprevious==x && yprevious==y,
        "Coast actual ordinary Portal failed hidden sea placement/disabled original Alarm0/source positional bookkeeping")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game)
    // Instance snapshots restore existing variables. This first Coast
    // fixture may introduce the active flag, so explicitly restore its
    // pre-test false default instead of leaking it into the next rate.
    GameCont.ntte_full_active_coast=_active
    scrNTTESmokeLog("FULL COAST CONSTRUCTORS: actual terrain origin/unwalls, wading fields, invisible corpse floor, water Dust/MeltSplat, original portal snap/sea exit OK @"+string(30/timescale))
}
function scrNTTEFullCoastSeaSmoke() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _state=scrNTTEFullCoastDrawState(),_vx=view_xview,_vy=view_yview,_quality=UberCont.opt_scaling,
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_coast",false)
    GameCont.area=scrNTTEFullAreaId("coast"); GameCont.subarea=1; GameCont.ntte_full_active_coast=true
    view_xview=41000; view_yview=41000; UberCont.opt_scaling=2
    var _sea=scrNTTEFullCoastSeaEnsure()
    scrNTTEFullCoastPresentSmoke(_sea)
    _sea.ntte_coast_opaque_output=true // Save the actual iOS compositor fixture.
    for(var _dx=0;_dx<3;++_dx) for(var _dy=0;_dy<3;++_dy) instance_create(41000+32*_dx,41000+32*_dy,Floor)
    var _crab=instance_create(41120,41048,NTTEFullTrafficCrab)
    _crab.active=true; _crab.speed=0; _crab.ntte_crab_decide=100
    with(_sea) event_perform(ev_step,ev_step_end)
    assert(_crab.wading>4 && !_crab.visible && array_get_index(GameCont.ntte_sea_inst,_crab)>=0,
        "Coast actual EndStep failed sea-instance registration/ordinary drawing suppression")
    var _output=surface_create(view_width*2,view_height*2),_camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1)
    surface_set_target(_output); camera_apply(_camera); draw_clear_alpha(scrAreaGetBackroundColor(GameCont.area),1)
    with(_sea) event_perform(ev_draw,0)
    assert(surface_get_target()==_output && !_sea.ntte_coast_target_active,
        "Coast real sea Draw leaked or replaced the caller's native render target")
    with(instance_find(NTTEFullCoastSeaTop,0)) event_perform(ev_draw,0)
    with(instance_find(NTTEFullCoastSeaVisible,0)) event_perform(ev_draw,0)
    surface_reset_target()
    matrix_set(matrix_world,_state.world); matrix_set(matrix_view,_state.view); matrix_set(matrix_projection,_state.projection)
    assert(_sea.ntte_coast_draw_ready && _crab.visible,"Coast actual Draw failed top-half readiness/final visibility restore")
    for(var _i=0;_i<8;++_i) assert(surface_exists(_sea.ntte_coast_surfaces[_i].surf),"Coast actual Draw lost one of eight native source render surfaces")
    assert(_crab.mask_index==mskScorpion,"Coast swimmer visual bbox capture failed to restore actual collision mask")
    var _image_path=working_directory+"ntte-coast-sea-smoke-"+string(30/timescale)+".png"
    var _image_saved=surface_save(_output,_image_path)
    scrNTTESmokeLog("COAST SEA IMAGE: saved="+string(_image_saved)+" exists="+string(file_exists(_image_path))
        +" path="+_image_path+" working_directory="+working_directory+" program_directory="+program_directory)
    assert(file_exists(_image_path),"Coast visual fixture failed to save its actual rendered native surface: "+_image_path)
    scrNTTEFullCoastSeaBackgroundSmoke(_sea,_output,_camera)
    surface_free(_output); camera_destroy(_camera)
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game)
    GameCont.ntte_full_active_coast=_active
    view_xview=_vx; view_yview=_vy; UberCont.opt_scaling=_quality
    scrNTTESmokeLog("FULL COAST SEA: real EndStep swimming, eight native surfaces, source cache/gradient/actual Draw capture/foam/top/visible passes, target/mask restoration OK @"+string(30/timescale)+"; visual scene saved")
}
function scrNTTEFullCoastSeaBackgroundSmoke(_sea,_output,_camera) {
    // A blue fixture clear used to conceal dependence on the room background.
    // Compare open water against an independent opaque sea+caustics reference.
    var _state=scrNTTEFullCoastDrawState(),_reference=surface_create(view_width*2,view_height*2),
        _background=scrAreaGetBackroundColor(GameCont.area),_clears=[c_black,c_white,_background],
        _shader_option=scrNTTEFullOptionGet("shaders"),_quality=UberCont.opt_scaling
    var _compat=_sea.ntte_coast_opaque_output
    gpu_push_state();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
    for(var _mode=0;_mode<2;++_mode) {
    _sea.ntte_coast_opaque_output=(_mode==1)
    for(var _quality_test=0;_quality_test<2;++_quality_test) {
        UberCont.opt_scaling=_quality_test==0 ? 2:4
        for(var _shader_test=0;_shader_test<2;++_shader_test) {
            scrNTTEFullOptionSet("shaders",_shader_test==1)
            for(var _test=0;_test<array_length(_clears);++_test) {
                // Lost caches emulate a renderer rebuild after backgrounding.
                if(_test==1) with(_sea) for(var _i=0;_i<8;++_i) {
                    var _s=ntte_coast_surfaces[_i]
                    if(surface_exists(_s.surf)) surface_free(_s.surf)
                }
                surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(_clears[_test],1)
                with(_sea) event_perform(ev_draw,0)
                assert(surface_get_target()==_output,"Coast background regression lost enclosing target")
                with(instance_find(NTTEFullCoastSeaTop,0)) event_perform(ev_draw,0)
                with(instance_find(NTTEFullCoastSeaVisible,0)) event_perform(ev_draw,0)
                surface_reset_target()
                surface_set_target(_reference);camera_apply(_camera);draw_clear_alpha(_background,1)
                draw_set_color(c_white);draw_set_alpha(0.4)
                draw_sprite_tiled(scrNTTERefSprite("CoastTrans"),0,sin(_sea.wave*0.02)*4,sin(_sea.wave*0.05)*2)
                draw_set_alpha(1);surface_reset_target()
                // Independently draw the source's 32px expanded native
                // floor sprites; do not use the production cached transition
                // surface as its own oracle. These points are outside the dry
                // 3x3 island and its <=6px foam, away from the genuine crab.
                var _shore=[[110,16],[16,110],[110,80]],_deep=[]
                for(var _point=0;_point<array_length(_shore);++_point)
                    array_push(_deep,surface_getpixel_ext(_reference,_shore[_point][0]*2,_shore[_point][1]*2))
                surface_set_target(_reference);camera_apply(_camera);draw_clear_alpha(_background,1)
                draw_set_color(c_white);draw_set_alpha(1)
                var _coast_floor=scrNTTERefSprite("FloorCoast")
                for(var _copy=-1;_copy<8;++_copy) {
                    var _dx=_copy<0?0:lengthdir_x(32,_copy*45),_dy=_copy<0?0:lengthdir_y(32,_copy*45)
                    with(Floor) if(visible) {
                        var _spr=(sprite_index!=_coast_floor && mask_index==mskFloor)?_coast_floor:sprite_index
                        draw_sprite_ext(_spr,image_index,x+_dx,y+_dy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
                    }
                }
                draw_set_color(_background);draw_set_alpha(0.6)
                draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+view_height,false)
                draw_set_color(c_white);draw_set_alpha(0.4)
                draw_sprite_tiled(scrNTTERefSprite("CoastTrans"),0,sin(_sea.wave*0.02)*4,sin(_sea.wave*0.05)*2)
                draw_set_alpha(1);surface_reset_target()
                for(var _point=0;_point<array_length(_shore);++_point) {
                    var _px=_shore[_point][0]*2,_py=_shore[_point][1]*2,
                        _actual=surface_getpixel_ext(_output,_px,_py),_expected=surface_getpixel_ext(_reference,_px,_py),
                        _water=_deep[_point]
                    assert(abs(color_get_red(_expected)-color_get_red(_water))
                        +abs(color_get_green(_expected)-color_get_green(_water))
                        +abs(color_get_blue(_expected)-color_get_blue(_water))>24,
                        "Coast shore oracle did not include genuine expanded sand at "+string(_shore[_point]))
                    assert(abs(color_get_red(_actual)-color_get_red(_expected))<=3
                        && abs(color_get_green(_actual)-color_get_green(_expected))<=3
                        && abs(color_get_blue(_actual)-color_get_blue(_expected))<=3
                        && ((_actual>>24)&255)>=253,
                        "Coast lost source shallow shore; quality="+string(UberCont.opt_scaling)
                        +" shaders="+string(_shader_test)+" clear="+string(_test)+" point="+string(_shore[_point])
                        +" actual="+string(_actual)+" expected="+string(_expected))
                }
                for(var _point=0;_point<3;++_point) {
                    var _px=(view_width-16-_point*16)*2,_py=(view_height-16)*2,
                        _actual=surface_getpixel_ext(_output,_px,_py),_expected=surface_getpixel_ext(_reference,_px,_py)
                    assert(abs(color_get_red(_actual)-color_get_red(_expected))<=2
                        && abs(color_get_green(_actual)-color_get_green(_expected))<=2
                        && abs(color_get_blue(_actual)-color_get_blue(_expected))<=2
                        && ((_actual>>24)&255)>=253,
                        "Coast sea depends on room clear; quality="+string(UberCont.opt_scaling)
                        +" shaders="+string(_shader_test)+" clear="+string(_test)
                        +" actual="+string(_actual)+" expected="+string(_expected))
                }
            }
        }
    }
    }
    _sea.ntte_coast_opaque_output=_compat
    scrNTTEFullOptionSet("shaders",_shader_option);UberCont.opt_scaling=_quality
    surface_free(_reference);gpu_pop_state()
    matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
    draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    scrNTTESmokeLog("COAST SEA BACKGROUND: black/white/blue input, quality2/4, shaders on/off, lost surfaces and independent open-water/shallow-shore pixels; legacy AND iOS opaque compositors OK @"+string(30/timescale))
}
// Actual presentation pixels under poisoned fog/caller-shader state.
// Unlike a colour-only assertion, this detects a transparent frame erasing
// the previously drawn shore or the enclosing framebuffer alpha.
function scrNTTEFullCoastPresentSmoke(_sea) {
    assert(shader_is_compiled(shNTTEFullCoastPresent),"Coast iOS alpha compositor failed compilation")
    var _state=scrNTTEFullCoastDrawState(),_compat=_sea.ntte_coast_opaque_output,
        _raw=surface_create(8,8),_output=surface_create(8,8),
        _camera=camera_create_view(0,0,8,8,0,noone,-1,-1,-1,-1),
        _entry={surf:_raw,x:0,y:0,scale:1,w:8,h:8},_background=make_color_rgb(42,145,205)
    _sea.ntte_coast_opaque_output=true
    gpu_push_state();shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
    draw_set_alpha(1);draw_set_color(c_white)
    surface_set_target(_raw);camera_apply(_camera);draw_clear_alpha(c_black,0)
    draw_set_color(make_color_rgb(200,100,50));draw_rectangle(2,2,5,5,false)
    draw_set_color(c_white);surface_reset_target()
    for(var _mode=0;_mode<2;++_mode) {
        surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(_background,0.25)
        gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_inv_src_alpha)
        gpu_set_fog(true,c_black,0,0)
        shader_set(shNTTEFullCoastUnblend)
        with(_sea) scrNTTEFullCoastSurfacePresent(_entry,_mode ? make_color_rgb(44,37,122):-1)
        assert(shader_current()==shNTTEFullCoastUnblend,"Coast present failed to restore caller shader")
        shader_reset();gpu_set_fog(false,0,0,0);surface_reset_target()
        var _empty=surface_getpixel_ext(_output,0,0),_body=surface_getpixel_ext(_output,3,3),
            _expected=_mode ? make_color_rgb(44,37,122):make_color_rgb(200,100,50)
        assert(color_get_red(_empty)==42 && color_get_green(_empty)==145 && color_get_blue(_empty)==205
            && abs(((_empty>>24)&255)-64)<=1,"Coast transparent frame overwrote sea RGB/alpha")
        assert(abs(color_get_red(_body)-color_get_red(_expected))<=1
            && abs(color_get_green(_body)-color_get_green(_expected))<=1
            && abs(color_get_blue(_body)-color_get_blue(_expected))<=1 && ((_body>>24)&255)==255,
            "Coast explicit underwater tint changed colour or alpha")
    }
    _sea.ntte_coast_opaque_output=_compat
    surface_free(_raw);surface_free(_output);camera_destroy(_camera);gpu_pop_state()
    matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
    if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
    draw_set_color(_state.color);draw_set_alpha(_state.alpha)
    scrNTTESmokeLog("COAST IOS PRESENT: empty alpha, opaque actor, fog-independent tint and caller shader OK @"+string(30/timescale))
}
function scrNTTEFullCoastNormalLifecycleSmoke() {
    var _harness=id
    instance_deactivate_object(_harness)
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _tutorial=save_get_value("game","tutorial",true),_sync=variable_global_exists("ntte_full_sync_generation") ? global.ntte_full_sync_generation:false
    save_set_value("game","tutorial",false)
    for(var _stage=1;_stage<=3;++_stage) {
        scrCleanupAreaInstances(); instance_destroy(chestprop,false); instance_destroy(NTTEFullPet,false)
        instance_destroy(Portal,false); instance_destroy(PortalClear,false); instance_destroy(PortalShock,false); instance_destroy(PortalL,false)
        with(TopCont) { if(surface_exists(dark)) surface_free(dark); instance_destroy(id,false) }
        instance_destroy(SubTopCont,false)
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont)
        scrNTTEFullAreaNativeInit()
        GameCont.area=scrNTTEFullAreaId("coast"); GameCont.subarea=_stage; GameCont.loops=0; GameCont.hard=3
        GameCont.crown=Crown.None; GameCont.noradch=0; GameCont.sunkenchests=0; GameCont.ntte_full_pending_destination=undefined
        GameCont.maxsubarea=3; GameCont.finalsubarea=(_stage==3); GameCont.ntte_visits_coast=0
        global.ntte_full_sync_generation=false
        var _gen=instance_create(0,0,GenCont)
        assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation && _gen.goal==100 && !instance_exists(FloorMaker)
            && instance_number(Floor)>20,"Natural Coast Create failed100goal/native island generator")
        with(_gen) event_perform(ev_alarm,2)
        with(_gen) event_perform(ev_alarm,0)
        assert(instance_number(enemy)>0,"Natural Coast lost actual enemy population")
        with(_gen) event_perform(ev_alarm,1)
        assert(!instance_exists(_gen) && GameCont.ntte_full_active_coast && !TopCont.darkness && !instance_exists(Wall)
            && !instance_exists(TopSmall) && instance_exists(NTTEFullCoastSea),"Natural Coast Destroy lost daylight/unwalls/real sea renderer")
        if(_stage==1) assert(instance_exists(NTTEFullCoastBigDecal) && instance_exists(NTTEFullPet),"Coast1 lost actual Parrot shell/perch")
        if(_stage==2) assert(instance_number(NTTEFullSunkenChest)==1,"Coast2 lost actual open-water SunkenChest")
        if(_stage==3) assert(instance_number(NTTEFullPalanking)==1,"Coast3 lost actual open-water Palanking")
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.ntte_visits_coast==1 && !GameCont.ntte_full_active_coast,"Actual Coast RoomEnd lost visit count/transit reset")
        if(_stage<3) assert(GameCont.area==scrNTTEFullAreaId("coast") && GameCont.subarea==_stage+1,"Actual Coast RoomEnd skipped/doubled subarea increment")
        else assert(GameCont.area==scrNTTEFullAreaId("oasis") && GameCont.subarea==1,"Actual Coast3 RoomEnd failed finalOasis1 transition")
    }
    scrCleanupAreaInstances(); instance_destroy(chestprop,false); instance_destroy(NTTEFullPet,false)
    instance_destroy(Portal,false); instance_destroy(PortalClear,false); instance_destroy(PortalShock,false); instance_destroy(PortalL,false)
    scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players)
    global.ntte_full_sync_generation=_sync; save_set_value("game","tutorial",_tutorial)
    instance_activate_object(_harness)
    scrNTTESmokeLog("FULL NATURAL COAST: actual native100goal islands/population/start/unwalls/sea controller/Parrot/Treasure/Palanking and actual RoomEnd1->2->3->Oasis1 OK @"+string(30/timescale))
}
