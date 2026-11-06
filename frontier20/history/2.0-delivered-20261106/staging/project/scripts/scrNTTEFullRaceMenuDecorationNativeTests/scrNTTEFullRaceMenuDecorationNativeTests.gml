function scrNTTEFullRaceMenuDecorationNativeTests() {
    assert(scrNTTESmokeEnabled(),"Race menu decoration requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_progress=global.ntte_full_progress,_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([Menu,MenuGen,FloorMaker,Wall,Floor,CampChar,NTTEFullTopObject,GameCont]),_surface=-1,
        _menu=instance_create(99000,99000,Floor)
    with(_menu) instance_change(Menu,false)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    try {
        // Native main menu has no GameCont; exercise the real Top factory in
        // that state, rather than concealing its GameCont dependencies.
        var _wall=instance_create(99000,99000,Wall),
            _char=instance_create(99128,99128,CampChar)
        _char.race=NTTEFullRace.Parrot
        _char.sprite_index=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Menu",0)
        _char.spr_to=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"MenuSelect",0)
        _char.spr_from=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"MenuDeselect",0)
        _char.spr_slct=_char.sprite_index
        _char.spr_menu=scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"MenuSelected",0)
        _char.randomize_position=false
        var _retry_seed=random_get_seed()
        scrNTTEFullRaceCampDecorationStep()
        assert(!scrNTTEFullValue(_char,"ntte_parrot_camp_setup",false)
            && !instance_exists(scrNTTEFullValue(_char,"ntte_full_top_object",noone))
            && random_get_seed()==_retry_seed,
            "Parrot permanently completed a failed wall search or consumed RNG without a valid perch")
        var _floor=instance_create(99000,99016,Floor),_pending=instance_create(99500,99500,Floor)
        with(_pending) instance_change(FloorMaker,false)
        scrNTTEFullRaceCampDecorationStep()
        assert(!scrNTTEFullValue(_char,"ntte_parrot_camp_setup",false),
            "Parrot perched while native menu random floor generation was pending")
        instance_destroy(_pending,false)
        _pending=instance_create(99500,99500,Floor)
        with(_pending) {instance_change(MenuGen,false);alarm[1]=2}
        scrNTTEFullRaceCampDecorationStep()
        assert(!scrNTTEFullValue(_char,"ntte_parrot_camp_setup",false),
            "Parrot perched before native MenuGen final wall/top rebuild")
        instance_destroy(_pending,false)
        scrNTTEFullRaceCampDecorationStep()
        var _top=scrNTTEFullValue(_char,"ntte_full_top_object",noone)
        scrNTTESmokeLog("RACE CAMP DECORATION DIAG "+json_stringify({top:_top,char:[_char.x,_char.y],
            wall:[_wall.bbox_left,_wall.bbox_right,_wall.bbox_bottom],hasGame:instance_exists(GameCont),
            floorBelow:place_meeting(_wall.x,_wall.y+16,Floor)}))
        assert(!instance_exists(GameCont) && instance_exists(_top) && _top.target==_char
            && _top.spawn_dis==0 && _top.spawn_dir==0 && _char.mask_index==mskNone
            && _char.spr_shadow==-1 && _char.ntte_parrot_camp_setup,
            "Actual native main-menu Parrot failed source wall-top provider/zero-distance attachment/suspended ground state")
        var _expectedX=_char.image_xscale>0 ? _wall.bbox_right-4:_wall.bbox_left+4
        assert(abs(_top.x-_expectedX)<=0.001 && abs(_top.y-(_wall.bbox_bottom-1-19+8))<=0.001,
            "Source CampChar wall-edge exclusive bbox adaptation/original Top z offset diverged")
        var _count=instance_number(NTTEFullTopObject)
        scrNTTEFullRaceCampDecorationStep()
        assert(instance_number(NTTEFullTopObject)==_count,"Source camp Parrot repeated its perch setup every Step")
        scrNTTEFullRaceMenuOcclusionPixels(_wall,_char,_top)
        // Let a real native Top be destroyed while the main menu still has
        // no GameCont, verifying its normal restoration/sound branch too.
        instance_destroy(_top)
        assert(_char.mask_index!=mskNone && _char.spr_shadow==shd24,
            "Main-menu Top release lost native CampChar mask/shadow restoration")
        var _icon=instance_create(64,64,CharSelect)
        _icon.race=NTTEFullRace.Parrot;_icon.can=true;_icon.visible=true;_icon.image_index=0
        var _marker=scrNTTEFullRaceNewMarker(_icon,true)
        assert(is_struct(_marker) && _marker.sprite==sprNew && _marker.x==64 && _marker.y==63,
            "Source first-run marker lost native NEW artwork/stable GUI location/hover offset")
        _surface=surface_create(128,128);assert(surface_exists(_surface),"NEW marker native surface allocation failed")
        surface_set_target(_surface);draw_clear_alpha(c_black,0)
        assert(scrNTTEFullRaceNewMarkerDraw(_icon,true),"Source first-run marker refused actual drawing")
        surface_reset_target()
        var _pixels=0
        for(var _x=32;_x<96;++_x) for(var _y=32;_y<96;++_y)
            if(((surface_getpixel_ext(_surface,_x,_y)>>24)&255)>0) _pixels++
        assert(_pixels>0,"Actual source first-run marker drew no visible pixels")
        global.ntte_full_progress.stats[$ "race:parrot:runs"]=1
        assert(is_undefined(scrNTTEFullRaceNewMarker(_icon)),"Source NEW marker remained after a completed run start")
        _icon.race=NTTEFullRace.Beetle;_icon.can=false
        assert(is_undefined(scrNTTEFullRaceNewMarker(_icon)),"Locked custom character showed first-run marker")
        _icon.can=true;_icon.visible=false
        assert(is_undefined(scrNTTEFullRaceNewMarker(_icon)),"Hidden custom character showed first-run marker")
        _icon.visible=true;_icon.race=Race.Fish
        assert(is_undefined(scrNTTEFullRaceNewMarker(_icon)),"Source custom NEW marker leaked to native character")
    }
    finally {
        if(surface_exists(_surface)) surface_free(_surface)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        global.ntte_full_progress=_progress;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL RACE MENU DECORATION NATIVE: failed-search retry without RNG/native FloorMaker+MenuGen finalization gates/real Parrot CampChar wall Top attachment without GameCont/source edge+z/suspended+restored mask-shadow/single setup/actual NEW sprite drawing/first-run+locked+hidden+native gates OK @"+string(30/timescale))
}

// Exact native SubTopCont Wall pass, verified by maintenance before injection.
function scrNTTEFullRaceMenuWallTopPixels(_wall) {
    with(_wall) if(sprite_exists(topspr))
        draw_sprite_ext(topspr,instance_is(id,NTTEFullWallFake)?topindex:image_index,x,y-8,1,1,0,image_blend,1)
}
function scrNTTEFullRaceMenuOcclusionPixels(_wall,_char,_top) {
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _shader=shader_current(),_color=draw_get_color(),_alpha=draw_get_alpha(),_outer=surface_get_target(),
        _saved=[_char.x,_char.y,_char.xprevious,_char.yprevious,_char.image_xscale,_char.image_yscale,
            _char.image_angle,_char.image_blend,_char.image_alpha,_char.visible,_char.image_index,_top.x],
        _expected=-1,_actual=-1,_covered=-1,_camera=-1,_a=-1,_b=-1,_c=-1,_target=false,_cases=0,_overlap=0,
        _background=make_color_rgb(9,17,31)
    gpu_push_state()
    try {
        _expected=surface_create(64,64);_actual=surface_create(64,64);_covered=surface_create(64,64)
        assert(surface_exists(_expected) && surface_exists(_actual) && surface_exists(_covered),"Camp redraw real pixel targets failed")
        _a=buffer_create(64*64*4,buffer_fixed,1);_b=buffer_create(64*64*4,buffer_fixed,1);_c=buffer_create(64*64*4,buffer_fixed,1)
        _camera=camera_create_view(_wall.x-24,_wall.y-32,64,64,0,noone,-1,-1,-1,-1)
        shader_reset();gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal)
        draw_set_color(c_white);draw_set_alpha(1)
        _char.visible=true;_char.image_blend=c_white;_char.image_alpha=1;_char.image_angle=0;_char.image_yscale=1
        for(var _face=0;_face<2;++_face) {
            _char.image_xscale=_face==0?-1:1
            _top.x=_face==0?_wall.bbox_left+4:_wall.bbox_right-4
            _char.x=_top.x;_char.y=_top.y-_top.z
            var _faceOverlap=0
            for(var _frame=0;_frame<2;++_frame) {
                _char.image_index=min(_frame,sprite_get_number(_char.sprite_index)-1)
                surface_set_target(_expected);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
                draw_clear_alpha(_background,1);scrNTTEFullRaceMenuWallTopPixels(_wall);with(_char) draw_self()
                surface_reset_target();_target=false
                surface_set_target(_covered);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
                draw_clear_alpha(_background,1);with(_char) draw_self();scrNTTEFullRaceMenuWallTopPixels(_wall)
                surface_reset_target();_target=false
                surface_set_target(_actual);_target=true;camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
                draw_clear_alpha(_background,1);with(_char) draw_self();scrNTTEFullRaceMenuWallTopPixels(_wall)
                assert(scrNTTEFullRaceCampDecorationDraw()==1,"Actual Menu redraw omitted perched Parrot")
                surface_reset_target();_target=false
                assert(real(surface_get_target())==real(_outer),"Camp Parrot pixel test lost outer target")
                buffer_get_surface(_a,_expected,0);buffer_get_surface(_b,_actual,0);buffer_get_surface(_c,_covered,0)
                for(var _offset=0;_offset<64*64*4;_offset+=4) {
                    var _want=buffer_peek(_a,_offset,buffer_u32),_got=buffer_peek(_b,_offset,buffer_u32),_without=buffer_peek(_c,_offset,buffer_u32)
                    assert(_want==_got,"Camp Parrot native wall-top occluded actual redraw face="+string(_face)+" frame="+string(_frame)+" pixel="+string(_offset div 4))
                    if(_want!=_without) {_faceOverlap++;_overlap++}
                }
                _cases++
            }
            assert(_faceOverlap>0,"Camp Parrot pixel oracle did not exercise real wall-top occlusion for face="+string(_face))
        }
        _char.visible=false
        assert(scrNTTEFullRaceCampDecorationDraw()==0,"Hidden camp Parrot entered post-wall redraw")
        scrNTTESmokeLog("CAMP PARROT POST-WALL PIXELS "+json_stringify({native_wall_top:_wall.topspr,rgba_cases:_cases,
            pixels:64*64*_cases,previously_occluded_pixels:_overlap,configured_fps:game_get_speed(gamespeed_fps),mobile_device_tested:false}))
    }
    finally {
        if(_target) surface_reset_target()
        _char.x=_saved[0];_char.y=_saved[1];_char.xprevious=_saved[2];_char.yprevious=_saved[3]
        _char.image_xscale=_saved[4];_char.image_yscale=_saved[5];_char.image_angle=_saved[6];_char.image_blend=_saved[7]
        _char.image_alpha=_saved[8];_char.visible=_saved[9];_char.image_index=_saved[10];_top.x=_saved[11]
        if(buffer_exists(_a)) buffer_delete(_a);if(buffer_exists(_b)) buffer_delete(_b);if(buffer_exists(_c)) buffer_delete(_c)
        if(surface_exists(_expected)) surface_free(_expected);if(surface_exists(_actual)) surface_free(_actual);if(surface_exists(_covered)) surface_free(_covered)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state()
    }
}
