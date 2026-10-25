// Exercise the actual shared wrap helper and native AchievementsMenu GUI.
function scrNTTEFullTextWrapNativeTests() {
    var _before=scrNTTEFullInstances(all),_language=global.language_current,
        _small=global.language_font_default,_big=global.language_font_bigname_default,
        _draw=scrNTTEFullCoastDrawState(),_font=draw_get_font(),_ha=draw_get_halign(),
        _va=draw_get_valign(),_shader=shader_current(),_seed=random_get_seed(),
        _surface=-1,_camera=-1,_target=false,_menu=noone,
        _vw=view_width,_vh=view_height,_stop=lockstep_stop
    gpu_push_state()
    try {
        scrNTTEFullLocalizeInstall();scrLanguageSet("Simplified Chinese");draw_reset_font()
        var _samples=["带上你的朋友","肥皂与水","深海恐惧","折磨装置","友",
            "GRAB YOUR FRIENDS","SOAP AND WATER","Z","alpha beta gamma",
            "第一行\n最后一个字","@g深海恐惧@s"],_widths=[240,48,20]
        for(var _w=0;_w<array_length(_widths);++_w) {
            for(var _i=0;_i<array_length(_samples);++_i) {
                var _input=_samples[_i],_wrapped=string_insert_wordwraps(_input,_widths[_w]),
                    _expected=string_replace_all(string_replace_all(_input," ",""),"\n",""),
                    _actual=string_replace_all(string_replace_all(_wrapped," ",""),"\n","")
                assert(_actual==_expected,"Word wrapping lost/repeated input characters: "+_input+" => "+_wrapped)
            }
        }
        assert(string_insert_wordwraps("",240)=="","Empty wrap produced content")
        assert(string_pos("\n",string_insert_wordwraps("一二三四五六七八九十",32))>0,
            "Long Chinese input stopped wrapping")
        view_width=424;view_height=240;lockstep_stop=false
        _surface=surface_create(view_width,view_height)
        _camera=camera_create_view(0,0,view_width,view_height,0,noone,-1,-1,-1,-1)
        _menu=instance_create(0,0,AchievementsMenu)
        with(_menu) {
            ypos=59*40
            for(var _i=0;_i<=achievementmax;++_i) anim[_i]=view_width-32
        }
        surface_set_target(_surface);_target=true;camera_apply(_camera)
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal)
        gpu_set_texfilter(false);draw_clear_alpha(c_black,1);draw_set_color(c_white);draw_set_alpha(1)
        draw_set_halign(fa_left);draw_set_valign(fa_top);draw_reset_font()
        with(_menu) event_perform(ev_draw,ev_gui)
        surface_reset_target();_target=false
        var _texts=["带上你的朋友","肥皂与水","深海恐惧","折磨装置"]
        for(var _i=0;_i<array_length(_texts);++_i) {
            var _text=_texts[_i]
            assert(variable_struct_exists(_menu.wrapped_strings,_text),
                "Actual AchievementsMenu did not wrap localized description "+_text)
            assert(string_trim(_menu.wrapped_strings[$ _text])==_text,
                "Actual achievement description dropped its final character")
        }
        surface_save(_surface,working_directory+"ntte-achievement-descriptions-"+string(30/timescale)+".png")
    } finally {
        if(_target) surface_reset_target()
        if(_surface>=0 && surface_exists(_surface)) surface_free(_surface)
        if(_camera>=0) camera_destroy(_camera)
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        global.language_current=_language;global.language_font_default=_small;global.language_font_bigname_default=_big
        view_width=_vw;view_height=_vh;lockstep_stop=_stop
        gpu_pop_state();matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha)
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("TEXT WRAP: Chinese/English terminal characters, narrow wrapping, native achievements GUI and all four reported descriptions retained @"+string(30/timescale))
}
