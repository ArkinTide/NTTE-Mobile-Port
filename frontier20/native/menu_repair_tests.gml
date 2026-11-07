function scrFRMenuRepairRender(_menu,_rows,_filename) {
    var _state=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),
        _va=draw_get_valign(),_shader=shader_current(),_surface=-1,_camera=-1,_target=false;
    gpu_push_state();
    try {
        _surface=surface_create(360,240);assert(surface_exists(_surface),"Menu repair target missing");
        _camera=camera_create_view(0,0,360,240,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
        gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(make_color_rgb(28,20,42),1);
        var _count=min(9,array_length(_rows));
        with(_menu) {
            drawx=180;drawy=16;
            for(var _i=1;_i<_count;++_i) {
                var _row=_rows[_i];
                assert(_row.fr_info && _row.height>=22 && _row.skip && !_row.available,
                    "Statistics/credits row has no measured native vertical allocation");
                method_execute(_row.draw,_row);drawy+=_row.height;
            }
        }
        surface_reset_target();_target=false;
        var _path=working_directory+_filename;
        if(file_exists(_path)) file_delete(_path);
        surface_save(_surface,_path);
        assert(file_exists(_path),"Menu repair screenshot was not saved: "+_path);
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_state.color);draw_set_alpha(_state.alpha);
    }
}
function scrFRMenuRepairTests() {
    var _language=global.language_current[$ "Init:Id"],_font=draw_get_font(),
        _menu=noone,_selector=noone,_game=instance_exists(GameCont)?GameCont.id:noone;
    try {
        scrFRBubblesLoadoutRepairTests();
        global.language_current[$ "Init:Id"]="Simplified Chinese";
        _menu=instance_create(0,0,MenuOptions);
        with(_menu) {
            scrFRMenuOptionsPage(scrFROptionPageKey("mod","Frontier_Options","stats"));
            var _stats=options[OptionCategory.Frontier_Page];
            assert(array_length(_stats)==22,"Statistics omitted authored sections or counters");
            assert(_stats[2].fr_info_value==string(scrFRMenuStat("meals_eaten")),"Statistics displays a different saved counter");
            scrFRMenuRepairRender(id,_stats,"frontier-menu-statistics.png");
            scrFRMenuOptionsPage(scrFROptionPageKey("mod","Frontier_Options","credits"));
            var _credits=options[OptionCategory.Frontier_Page];
            assert(array_length(_credits)==16,"Credits omitted original contributors");
            scrFRMenuRepairRender(id,_credits,"frontier-menu-credits.png");
            for(var _i=1;_i<array_length(_credits);++_i)
                assert(!variable_struct_exists(_credits[_i],"fr_reference"),"Credits still overlays the fixed source page");
        }
        if(instance_exists(_game)) instance_deactivate_object(_game);
        _selector=instance_create(0,0,CustomModeWeaponSelector);
        with(_selector) {
            event_user(1);
            assert(group_names[group_count-2]=="NTTE" && group_names[group_count-1]=="NTUF",
                "Custom selector did not separate NTTE and NTUF");
            var _frontier=groups[group_count-1];
            assert(array_length(_frontier)==77,"Custom selector omitted NTUF cache-only or area -1 weapons");
            var _seen={};
            for(var _i=0;_i<array_length(_frontier);++_i) {
                var _weapon=_frontier[_i],_key=string(_weapon);
                assert(!(_seen[$ _key]??false),"NTUF custom selector duplicated a weapon");_seen[$ _key]=true;
                assert(sprite_exists(scr_weapon_get_sprite(_weapon)) && scr_weapon_get_name(_weapon)!="",
                    "NTUF custom weapon menu metadata requires an active run");
                assert(!array_contains(groups[group_count-2],_weapon),"NTUF weapon also appears in NTTE");
            }
            var _order=[];
            for(var _i=0;_i<group_count;++_i) array_push(_order,scrFRCustomWeaponGroupOrder(_i,group_count));
            assert(_order[0]==0 && _order[1]==group_count-2 && _order[2]==group_count-1,
                "Custom visual groups and click group indices differ");
            for(var _i=0;_i<group_count;++_i)
                assert(array_get_index(_order,_i)>=0,"Custom group order omitted native ammo category");
        }
        if(_game!=noone) instance_activate_object(_game);
        var _locked=scrNTTEFullCrownLoadoutSprite(17,false),_unlocked=scrNTTEFullCrownLoadoutSprite(17,true);
        assert(_locked[0]==sprFRStormsLoadout && _unlocked[0]==sprFRStormsLoadout
            && _locked[1]==1 && _unlocked[1]==0 && sprite_get_number(_locked[0])==2,
            "Storms loadout ignored locked ownership or lacks silhouette");
        for(var _i=0;_i<13;++_i) {
            var _area=_i<7?201+_i:301+_i-7,_label=scrFRDebugAreaLabel(_area,1);
            assert(string_pos("@",_label)==0 && string_pos("spr",_label)==0
                && scrFRLocalizationNeedsCJK(_label),"Goto displays sprite markup or lacks Unicode area name");
        }
        global.language_current[$ "Init:Id"]="English";
        assert(scrFRDebugAreaLabel(201,2)=="Coast 2" && scrFRDebugAreaLabel(303)=="Deep Labs",
            "English Goto labels changed the area identity");
        scrFRDebugFonts();
        assert(global.fr_debug_glyphs,"Goto debug renderer did not add packaged CJK glyphs");
        scrNTTESmokeLog("PASS FRONTIER menu repairs: locked Storms, statistics22/credits16 rows,77 NTUF weapon menu metadata without GameCont,13 Unicode Goto labels and debug glyphs");
    } finally {
        if(_game!=noone) instance_activate_object(_game);
        if(instance_exists(_menu)) instance_destroy(_menu,false);
        if(instance_exists(_selector)) instance_destroy(_selector,false);
        global.language_current[$ "Init:Id"]=_language;draw_set_font(_font);
    }
}

function scrFRBubblesLoadoutRepairTests() {
    var _original=UberCont.saveData,_copy=ds_map_create(),_skin=UberCont.cskin[19],
        _custom=UberCont.custom,_options=UberCont.custom_options,
        _player=my_player,_slot=global.playerinstance_list[0],_index=global.index,
        _server=global.is_server,_menu=noone;
    ds_map_copy(_copy,_original);UberCont.saveData=_copy;
    try {
        UberCont.custom=false;
        save_delete_value("cswep",19);
        UberCont.cskin[19]=0;
        assert(scr_loadout_race_get_start_weapon(19)==FR_BUBBLES_CUTLASS,
            "Fresh Bubbles A loadout has no cutlass");
        UberCont.cskin[19]=1;
        // The local player is still another race/skin when Random asks for
        // Bubbles' default; saved B skin must supply its shovel directly.
        assert(scr_loadout_race_get_start_weapon(19)==FR_BUBBLES_SHOVEL,
            "Fresh Bubbles B default used the unrelated local player's skin");
        var _invalid=[false,0,-1,maxwep+10000];
        for(var _i=0;_i<array_length(_invalid);++_i) {
            save_set_value("cswep",19,_invalid[_i]);
            assert(scr_loadout_race_get_start_weapon(19)==FR_BUBBLES_SHOVEL
                && save_get_value("cswep",19)==FR_BUBBLES_SHOVEL,
                "Invalid legacy Bubbles saved starter left the player unarmed");
        }
        save_set_value("cswep",19,FR_BUBBLES_CUTLASS);
        assert(scr_loadout_race_get_start_weapon(19)==FR_BUBBLES_SHOVEL,
            "Bubbles starter did not follow its saved B skin");
        save_set_value("cswep",19,wep_golden_revolver);
        assert(scr_loadout_race_get_start_weapon(19)==wep_golden_revolver
            && save_get_value("cswep",19)==wep_golden_revolver,
            "Bubbles repair overwrote a valid alternate weapon");
        var _fusion=scrNTTEFullWeaponMerge({wep:wep_revolver},{wep:wep_shotgun}),
            _handle=scrNTTEFullWeaponNative(_fusion);
        save_set_value("cswep",19,_handle);
        assert(scr_loadout_race_get_start_weapon(19)==_handle
            && scrNTTEFullWeaponModel(_handle)==_fusion,
            "Bubbles repair replaced a valid physical fusion or its identity");
        save_set_value("cswep",19,_fusion);
        assert(scr_loadout_race_get_start_weapon(19)==_fusion,
            "Bubbles repair replaced a valid saved fusion graph");

        // Execute the real native character-selection consumer, with an
        // explicit empty Custom primary. It must bypass the saved getter.
        assert(!instance_exists(Menu),"Custom NONE loadout test requires the isolated game fixture");
        _menu=instance_create(0,0,FRMarker);
        with(_menu) {
            instance_change(Menu,false);
            portrait_offsets=array_create(INPUT_MAX_PLAYERS,0);
            textappear=array_create(INPUT_MAX_PLAYERS,0);loadout_open=false;
        }
        var _fixture=new PlayerInstance(0);_fixture.reset_loadout();
        _fixture.race=Race.Fish;_fixture.cwep=wep_none;
        my_player=_fixture;global.playerinstance_list[0]=_fixture;
        global.index=0;global.is_server=false;
        UberCont.custom=true;UberCont.custom_options=new CustomModeOptions("Bubbles NONE fixture");
        UberCont.custom_options.wep=wep_none;UberCont.custom_options.unlock_chars=true;
        save_set_value("cswep",19,0);
        scrCampfireMenuSelectionChange(0,19);
        assert(_fixture.race==19 && _fixture.cwep==wep_none && save_get_value("cswep",19)==0,
            "Bubbles loadout repair replaced explicit Custom NONE during native selection");
        scrNTTESmokeLog("PASS FRONTIER Bubbles saved loadout: missing A/B, legacy false/0/negative/out-of-range, saved skin, valid alternate/fusion identity and actual Custom NONE menu selection");
    } finally {
        if(instance_exists(_menu)) instance_destroy(_menu,false);
        UberCont.saveData=_original;ds_map_destroy(_copy);UberCont.cskin[19]=_skin;
        UberCont.custom=_custom;UberCont.custom_options=_options;
        my_player=_player;global.playerinstance_list[0]=_slot;global.index=_index;global.is_server=_server;
    }
}
