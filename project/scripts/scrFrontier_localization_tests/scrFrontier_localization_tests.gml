function scrFRLocalizationTests() {
    var _language=global.language_current[$ "Init:Id"],_font=draw_get_font();
    var _ntte=scrNTTEFullDisplay("CROWN OF BONUS");
    try {
        global.language_current[$ "Init:Id"]="English";
        assert(scrFRLocalize("@wOPEN?")=="@wOPEN?","Frontier English display changed");
        assert(fr_Weapons_FR_Blunderbuss_wep_gml_weapon_name()=="BLUNDERBUSS","Frontier English metadata changed");
        var _weather=global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdowns;
        assert(scrFRLocalizationWeatherCaption(_weather,1)=="","Frontier English graphic card gained a caption");
        global.language_current[$ "Init:Id"]="Simplified Chinese";
        // These are real optional native menu fields, not dictionary entries.
        // Repeated empty displays must never become an invalid cache member;
        // format-only strings retain their exact authored text as well.
        for(var _empty=0;_empty<2;++_empty) {
            assert(scrFRLocalize("")=="" && scrFROptionText("", "", false)=="",
                "Frontier empty option display attempted an invalid localization cache key");
            assert(scrFRLocalize(" \t\n")==" \t\n" && scrFRLocalize("@w")=="@w",
                "Frontier whitespace/format-only display was altered");
        }
        assert(scrFRLocalize("BUBBLES")=="泡泡","Frontier character not localized");
        assert(scrFRLocalize("@wOPEN?")=="@w打开？","Frontier interaction not localized");
        assert(scrFRLocalize("STORM A-BREWIN'")=="风暴将至","Frontier weather not localized");
        assert(scrFRLocalizationWeatherCaption(_weather,1)=="流星雨"
            && scrFRLocalizationWeatherCaption(_weather,0)==""
            && scrFRLocalizationWeatherCaption(sprFloor1,1)=="",
            "Frontier weather subtitle changed unrelated artwork or the placeholder frame");
        assert(fr_Weapons_FR_Blunderbuss_wep_gml_weapon_name()=="喇叭枪","Frontier weapon metadata not localized");
        assert(fr_Skins_RobotBluescreened_skin_gml_skin_name()=="蓝屏","Frontier skin metadata not localized");
        assert(fr_Crowns_storms_crown_gml_crown_name()=="风暴王冠","Frontier crown metadata not localized");
        assert(scrFRLoc("Frontier:MissingTestKey","BUBBLES")=="泡泡","Frontier loc fallback not localized");
        assert(scrFRLocalizationPlain("@sGAIN @w2 MAX HEALTH#@sLOSE @w10% ACCURACY")==
            "GAIN 2 MAX HEALTH / LOSE 10% ACCURACY","Frontier rich-text normalization mismatch");
        var _dynamic=scrFRLocalize("@sGAIN @w2 MAX HEALTH#@sLOSE @w10% ACCURACY");
        assert(string_pos("MAX HEALTH",_dynamic)==0 && string_pos("ACCURACY",_dynamic)==0,
            "Frontier composed surgery stats not localized");
        assert(string_pos("2",_dynamic)>0 && string_pos("10%",_dynamic)>0 && string_pos("@w",_dynamic)>0,
            "Frontier composed stats lost numbers or formatting");
        assert(scrFRLocalize("WARBORN NEURONS")=="战争孕育的 神经元","Frontier random surgery name not localized");
        var _settingsSprite=global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons;
        var _icon="@1("+sprite_get_name(_settingsSprite)+":25)";
        assert(scrFROptionText(_icon+" TRADEFISH MODE")==_icon+"交易鱼提示","Frontier localized setting lost source icon");
        assert(scrFRLocalize("Frontier:OceanStatuePrompt")=="Frontier:OceanStatuePrompt",
            "Frontier localization key was translated");
        var _sourceName="fr_OasisStatue",_hitid=[-4,"TEST SUBJECT"];
        scrFRLocalize(_hitid[1]);
        assert(_sourceName=="fr_OasisStatue" && _hitid[1]=="TEST SUBJECT","Frontier identity was mutated");
        draw_set_font(fntM1);scrFRStringWidth("BUBBLES");
        assert(draw_get_font()==fntM1,"Frontier text measurement leaked font state");
        var _ascii="TEST-ASCII-4821",_ascii_width=string_width(_ascii);
        assert(scrFRStringWidth(_ascii)==_ascii_width && draw_get_font()==fntM1,
            "Frontier untranslated ASCII measurement changed its authored font metrics");
        assert(!scrFRLocalizationNeedsCJK("@2(不可见资源:25) ASCII")
            && !scrFRLocalizationNeedsCJK("@(不可见格式)@w")
            && scrFRLocalizationNeedsCJK("@2(不可见资源:25) 中文"),
            "Frontier font choice inspected hidden tag payload instead of visible glyphs");
        var _font_before=scrFRLocalizationFont("@2(不可见资源:25) ASCII");
        assert(_font_before==fntM1 && draw_get_font()==fntM1,
            "Frontier tag-only Unicode changed the caller's Latin font");
        draw_set_font(fntCJK);_font_before=scrFRLocalizationFont("@2(不可见资源:25) ASCII");
        assert(_font_before==fntCJK && draw_get_font()==fntCJK,
            "Frontier pure-icon/ASCII font preservation reset an already-CJK caller");
        draw_set_font(fntCJK);var _cjk_width=string_width("泡泡");draw_set_font(fntM1);
        assert(scrFRStringWidth("BUBBLES")==_cjk_width && draw_get_font()==fntM1,
            "Frontier localized measurement differs from its actual CJK drawing font");
        scrFRLocalizationRenderTests();
        var _data=scrFRLocalizationData(),_keys=variable_struct_get_names(_data);
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _translated=scrFRLocalize(_keys[_i]);
            assert(_translated!=_keys[_i],"Frontier dictionary key not translated: "+_keys[_i]);
        }
    } finally {
        global.language_current[$ "Init:Id"]=_language;
        draw_set_font(_font);
    }
    assert(scrNTTEFullDisplay("CROWN OF BONUS")==_ntte,"Frontier changed existing NTTE translation");
    return "PASS Frontier Simplified Chinese metadata, prompts, options, weather, surgery, GPU font output and identity isolation";
}

function scrFRLocalizationRenderTests() {
    var _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),
        _ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current(),
        _actual=-1,_expected=-1,_camera=-1,_bufferA=-1,_bufferB=-1,_target=false;
    gpu_push_state();
    try {
        _actual=surface_create(160,64);_expected=surface_create(160,64);
        assert(surface_exists(_actual) && surface_exists(_expected),"Frontier localization render targets unavailable");
        _camera=camera_create_view(0,0,160,64,0,noone,-1,-1,-1,-1);
        _bufferA=buffer_create(160*64*4,buffer_fixed,1);
        _bufferB=buffer_create(160*64*4,buffer_fixed,1);
        var _weather=global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdowns;
        var _icon_sprite=global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons,
            _source_icon="@2("+string(real(_icon_sprite))+":25)",
            _native_icon="@2("+sprite_get_name(_icon_sprite)+":25)";
        shader_reset();gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);
        draw_set_halign(fa_left);draw_set_valign(fa_top);draw_set_color(c_white);draw_set_alpha(1);
        for(var _kind=0;_kind<10;++_kind) {
            for(var _pass=0;_pass<2;++_pass) {
                surface_set_target(_pass==0?_actual:_expected);_target=true;
                camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,1);
                var _caller_font=_kind==9?fntCJK:fntM1,
                    _reference_font=(_kind==7 || _kind==8)?fntM1:fntCJK;
                draw_set_font(_pass==0?_caller_font:_reference_font);
                if(_pass==0) {
                    switch(_kind) {
                        case 0:scrFRDrawTextPlain(4,4,"BUBBLES");break;
                        case 1:scrFRDrawText(4,4,"BUBBLES");break;
                        case 2:scrFRDrawTextTransformed(4,4,"BUBBLES",1,1,0);break;
                        case 3:scrFRDrawTextShadow(4,4,"BUBBLES");break;
                        case 4:scrFRDrawSpriteExt(_weather,1,80,8,1,1,0,c_white,1);break;
                        case 5:
                            fr_Objects_Frontier_Objects_mod_gml_draw_text_tilt_shadow(4,4,"BUBBLES",5,c_white);break;
                        case 6:scrFRDrawText(4,4,_source_icon+" BUBBLES",1.5,.75,17,c_aqua,.7);break;
                        case 7:scrFRDrawText(4,4,_source_icon,1.5,.75,17,c_aqua,.7);break;
                        case 8:scrFRDrawText(4,4,"TEST-ASCII-4821",1.5,.75,17,c_aqua,.7);break;
                        case 9:scrFRDrawText(4,4,_source_icon,1.5,.75,17,c_aqua,.7);break;
                    }
                    assert(draw_get_font()==_caller_font,"Frontier localized drawing changed its caller's font");
                } else {
                    switch(_kind) {
                        case 0:draw_text(4,4,"泡泡");break;
                        case 1:draw_text_nt(4,4,"泡泡");break;
                        case 2:draw_text_transformed(4,4,"泡泡",1,1,0);break;
                        case 3:draw_set_color(c_black);draw_text(5,5,"泡泡");draw_set_color(c_white);draw_text(4,4,"泡泡");break;
                        case 4:
                            draw_sprite_ext(_weather,1,80,8,1,1,0,c_white,1);
                            draw_set_halign(fa_center);draw_set_valign(fa_top);draw_text_nt(80,50,"流星雨");
                            draw_set_halign(fa_left);break;
                        case 5:
                            draw_text_transformed_color(5,5,"泡泡",1,1,5,c_black,c_black,c_black,c_black,1);
                            draw_text_transformed_color(4,4,"泡泡",1,1,5,c_white,c_white,c_white,c_white,1);break;
                        case 6:draw_text_nt(4,4,_native_icon+"泡泡",1.5,.75,17,c_aqua,.7);break;
                        case 7:draw_text_nt(4,4,_native_icon,1.5,.75,17,c_aqua,.7);break;
                        case 8:draw_text_nt(4,4,"TEST-ASCII-4821",1.5,.75,17,c_aqua,.7);break;
                        case 9:draw_text_nt(4,4,_native_icon,1.5,.75,17,c_aqua,.7);break;
                    }
                }
                surface_reset_target();_target=false;
            }
            buffer_get_surface(_bufferA,_actual,0);buffer_get_surface(_bufferB,_expected,0);
            var _ink=0;
            for(var _at=0;_at<160*64*4;_at+=4) {
                var _a=buffer_peek(_bufferA,_at,buffer_u32),_b=buffer_peek(_bufferB,_at,buffer_u32);
                assert(_a==_b,"Frontier translated wrapper differs from actual baked CJK glyph output: "+string(_kind));
                if((_b&$FFFFFF)!=c_black) _ink++;
            }
            assert(_ink>8,"Frontier localized text rendered no visible CJK glyphs");
        }
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_actual)) surface_free(_actual);
        if(surface_exists(_expected)) surface_free(_expected);
        if(_camera!=-1) camera_destroy(_camera);
        if(_bufferA!=-1) buffer_delete(_bufferA);
        if(_bufferB!=-1) buffer_delete(_bufferB);
        gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
    }
}
