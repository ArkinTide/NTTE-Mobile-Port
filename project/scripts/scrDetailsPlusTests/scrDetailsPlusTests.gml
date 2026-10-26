function scrDPTestRender(_path) {
    var _state=scrNTTEFullCoastDrawState(),_shader=shader_current(),_surface=-1,_camera=-1,_target=false;
    gpu_push_state();
    try {
        _surface=surface_create(160,128);_camera=camera_create_view(39952,39936,160,128,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
        draw_set_alpha(1);draw_clear(make_color_rgb(80,40,24));
        with(Floor) draw_self();with(DPStaticDecor) draw_self();with(DPDecorBatch) event_perform(ev_draw,0);with(Detail) draw_self();
        with(Wall) draw_self();with(Scorch) draw_self();
        with(DPStatueDecor) event_perform(ev_draw,0);
        surface_save(_surface,working_directory+_path);
        assert(file_exists(working_directory+_path),"Details+ visual evidence was not saved");
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(_camera>=0) camera_destroy(_camera);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_color(_state.color);draw_set_alpha(_state.alpha);
    }
}
function scrDPTestPreferenceDisk() {
    assert(scrNTTESmokeEnabled(),"Details+ disk test requires isolated smoke saves");
    var _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_map=UberCont.saveData,
        _fixture=ds_map_create(),_loaded=-1,_directory=game_directory,
        _progress=global.ntte_full_progress,_scratch=working_directory+"detailsplus-save-"+string(get_timer())+"/",
        _flags=["__debug_menu_options","__debug_hitboxes","__debug_health","__debug_immortality",
            "__debug_teleportation","__debug_noreload","__debug_infammo","cheats"],_values=[];
    ds_map_copy(_fixture,_map);directory_create(_scratch);game_directory=_scratch;
    for(var _i=0;_i<array_length(_flags);++_i) {
        array_push(_values,variable_global_get(_flags[_i]));variable_global_set(_flags[_i],false);
    }
    global.ntte_full_progress=json_parse(json_stringify(_progress));
    try {
        UberCont.public=true;UberCont.custom=false;UberCont.saveData=_fixture;
        for(var _debug=0;_debug<2;++_debug) for(var _value=0;_value<2;++_value) {
            global.cheats=_debug;_fixture[? "visual_detailsplus"]=_value;
            scrSave();
            _loaded=json_decode(scrPersistentJsonLoad(_scratch+"NuclearThrone.sav"));
            assert(ds_map_exists(_loaded,"visual_detailsplus") && _loaded[? "visual_detailsplus"]==_value,
                "Details+ preference lost in native normal/debug options-only disk save");
            UberCont.saveData=_loaded;scrOptionsUpdate();
            assert(UberCont.opt_detailsplus==_value,"Details+ native disk reload did not restore enabled state");
            UberCont.saveData=_fixture;ds_map_destroy(_loaded);_loaded=-1;
        }
    } finally {
        if(_loaded!=-1) ds_map_destroy(_loaded);
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_map;ds_map_destroy(_fixture);
        game_directory=_directory;global.ntte_full_progress=_progress;
        for(var _i=0;_i<array_length(_flags);++_i) variable_global_set(_flags[_i],_values[_i]);
    }
}
function scrDetailsPlusTests() {
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_original_map=UberCont.saveData,
        _map=ds_map_create(),_seed=random_get_seed(),_last=scrNTTEFullValue(global,"dp_option_last",undefined),
        _language=global.language_current,_rate=game_get_speed(gamespeed_fps);
    ds_map_copy(_map,_original_map);UberCont.saveData=_map;
    _map[? "options_framerate"]=_rate;
    try {
        UberCont.opt_detailsplus=true;GameCont.area=area_desert;
        var _floor=instance_create(40000,40000,Floor),_wall=instance_create(40000,39984,Wall),
            _detail=instance_create(40016,40016,Detail);
        _floor.styleb=true;_floor.sprite_index=sprFloor1B;_wall.sprite_index=sprWall1Bot;
        var _floor_sprite=_floor.sprite_index,_wall_sprite=_wall.sprite_index,
            _floor_depth=_floor.depth,_floor_index=_floor.image_index,
            _enemies=instance_number(enemy),_walls=instance_number(Wall),_floors=instance_number(Floor),_original_details=instance_number(Detail),
            _rng=random_get_seed();
        assert(scrDPApply(),"Details+ generation/toggle pass did not run");
        assert(random_get_seed()==_rng,"Decorations consumed gameplay RNG");
        assert(_floor.sprite_index==sprDPFloorDesertBOut && _wall.sprite_index==sprDPWallDesertBotB,
            "Desert mud transition/wall artwork missing");
        assert(instance_number(enemy)==_enemies && instance_number(Wall)==_walls && instance_number(Floor)==_floors,
            "Visual MOD changed combat or level geometry");
        var _decor=scrDPBatchRowCount(),_details=instance_number(Detail);
        assert(_decor>=1 && _details<=14*_original_details,"Unbounded detail clusters");
        repeat(20) scrDPApply();
        assert(scrDPBatchRowCount()==_decor && instance_number(Detail)==_details,
            "Repeated generation/resume application multiplied details");
        var _scorch=instance_create(40016,40016,Scorch);
        assert(_scorch.sprite_index==sprDPDesertBScorch && _scorch.dp_scorch_top==sprDPDesertBScorchTop,
            "Desert mud scorch lower/top pair missing");
        scrDPTestRender("ntte-detailsplus-on-"+string(30/timescale)+".png");
        UberCont.opt_detailsplus=false;scrDPOptionsChanged();
        assert(_floor.sprite_index==_floor_sprite && _floor.image_index==_floor_index && _floor.depth==_floor_depth
            && _wall.sprite_index==_wall_sprite && _scorch.sprite_index==sprScorch
            && instance_number(DPStaticDecor)==0 && instance_number(DPDecorBatch)==0 && instance_number(DPStatueDecor)==0,
            "Disabling Details+ failed to restore the original world");
        scrDPTestRender("ntte-detailsplus-off-"+string(30/timescale)+".png");
        var _cases=[sprFloor1,sprFloor5,sprFloor5Explo,sprFloor5B,sprFloor0,sprFloor101,
            scrNTTERefSprite("FloorCoast"),scrNTTERefSprite("FloorTrench")],
            _bottoms=[sprDPDesertScorch,sprDPCityScorch,sprDPCityExploScorch,sprDPCityBScorch,
                sprDPCampfireScorch,sprDPOasisScorch,sprDPDesertScorch,sprDPTrenchScorch];
        UberCont.opt_detailsplus=true;
        for(var _i=0;_i<array_length(_cases);++_i) {
            _floor.sprite_index=_cases[_i];
            var _s=instance_create(40016,40016,Scorch),_choices=scrDPScorchSprites(_cases[_i]);
            assert(_choices[1][0]==_bottoms[_i] && _s.sprite_index==_choices[1][_s.dp_variant]
                && _s.dp_scorch_top==_choices[0][_s.dp_variant],"Source floor-specific scorch pairing "+string(_i));
            with(_s) scrDPScorchTopDraw();
            instance_destroy(_s,false);
        }
        _floor.styleb=true;_floor.sprite_index=sprFloor101B;GameCont.area=202;
        scrDPApply();assert(_floor.sprite_index==sprDPFloorOasisBOut,"NTTE oasis ID mapping not adapted");
        UberCont.opt_detailsplus=false;scrDPApply();
        var _areas=[area_desert,area_scrapyards,area_city,area_palace,201,205];
        for(var _i=0;_i<array_length(_areas);++_i) {
            GameCont.area=_areas[_i];UberCont.opt_detailsplus=true;
            var _statue=instance_create(44016+_i*160,44016,ProtoStatue),_shadow=_statue.spr_shadow;
            scrDPApply();var _decal=noone;
            with(DPStatueDecor) if(dp_owner==_statue) {_decal=id;break;}
            var _sprites=scrDPStatueSprites(_areas[_i]);
            assert(instance_exists(_decal) && _decal.sprite_index==_sprites[0]
                && _statue.spr_shadow==mskNone && _statue.depth==1,"Source statue decals by area");
            _statue.x+=8;with(_decal) {event_perform(ev_step,ev_step_normal);event_perform(ev_draw,0);}
            assert(_decal.x==_statue.x,"Statue decoration lost its exact owner");
            // Dispatch actual inherited prop death/corpse creation. The
            // exact corpse is supplied by the native lifecycle, no nearest scan.
            instance_destroy(_statue);
            assert(instance_exists(_decal) && _decal.dp_dead && instance_exists(_decal.dp_owner)
                && _decal.sprite_index==_sprites[1],"Actual statue destruction did not bind dead artwork");
            with(_decal) {image_index=image_number-0.1;event_perform(ev_step,ev_step_normal);}
            assert(_decal.image_index==sprite_get_number(_sprites[1])-1 && _decal.image_speed==0,
                "Destroyed statue decal did not stop at its final frame");
            var _corpse=_decal.dp_owner;instance_destroy(_corpse,false);with(_decal) event_perform(ev_step,ev_step_normal);
            assert(!instance_exists(_decal),"Statue leftovers survived their native corpse");
        }
        // Real native menu construction and switch method. Clone the save
        // map and suppress menu Destroy so user options/files stay isolated.
        var _menu=instance_create(0,0,MenuOptions),_found=undefined;
        var _rows=_menu.options[OptionCategory.Video];
        for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i].key=="visual_detailsplus") _found=_rows[_i];
        assert(is_struct(_found) && _found.type=="switch" && _found.value,
            "Details+ switch absent from native video settings or default off");
        with(_menu) method_execute(element_functions[$ "switch"],_found);
        _map[? _found.key]=_found.value;scrOptionsUpdate();
        assert(!UberCont.opt_detailsplus && !save_get_option("visual","detailsplus",true),"Native switch failed to save disabled preference");
        var _serialized=ds_map_write(_map),_loaded=ds_map_create();
        ds_map_read(_loaded,_serialized);assert(!_loaded[? "visual_detailsplus"],"Saved Details+ preference did not survive serialization");ds_map_destroy(_loaded);
        _map[? "visual_detailsplus"]=true;scrOptionsUpdate();
        assert(UberCont.opt_detailsplus,"Restoring Details+ option failed");
        instance_destroy(_menu,false);
        assert(GAME_VERSION==NTTE_RELEASE_VERSION,"Menu/updater release versions differ");
        scrDPTestPreferenceDisk();
        scrNTTESmokeLog("PASS Details+ source floor/scorch pairs, six statue/death lifecycles, bounded/idempotent decoration, native video toggle/normal+debug disk save+reload, geometry and RNG preservation @"+string(30/timescale));
    } finally {
        global.dp_option_last=_last;global.language_current=_language;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber);
        UberCont.saveData=_original_map;ds_map_destroy(_map);random_set_seed(_seed);
        game_set_speed(_rate,gamespeed_fps);scrNTTEFullRateApply();
    }
}
