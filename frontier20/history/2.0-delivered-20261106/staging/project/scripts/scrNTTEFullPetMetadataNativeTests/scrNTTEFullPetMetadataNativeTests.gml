function scrNTTEFullPetMetadataNativeTests() {
    assert(scrNTTESmokeEnabled(),"Pet metadata fixture requires explicit desktop smoke harness")
    var _before=scrNTTEFullInstances(all),_progress=global.ntte_full_progress,
        _old_language=global.language_current,_hidden=scrNTTEFullInstances(NTTEFullPet),_surface=-1,_baseline=-1,_seed=random_get_seed()
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.language_current=global.language_store[$ "English"];
    try {
        assert(scrNTTEFullPetThroneButtDescription("native description")=="native description",
            "Ordinary Throne Butt text changed without a Salamander pet")
        var _p=instance_find(Player,0),
            _race=scr_playerinstance_find(0).get_race(),_title=loc("Races",_race,"Name",scrRaceGetName(_race)),
            _suffix="@s#SALAMANDER - @wPUNTED @sENEMIES @rEXPLODE@s"
        var _icon=instance_create(64,64,SkillIcon)
        _icon.skill=mut_throne_butt;_icon.selected=1;_icon.appeary=0
        _surface=surface_create(view_width,view_height);_baseline=surface_create(view_width,view_height)
        assert(surface_exists(_surface) && surface_exists(_baseline),"Native mutation UI drawing surface allocation failed")
        surface_set_target(_baseline);draw_clear_alpha(c_black,0);with(_icon) event_perform(ev_draw,0);surface_reset_target()
        var _pet=scrNTTEFullPetCreate(_p.x,_p.y,"Salamander")
        assert(scrNTTEFullPetThroneButtDescription("native description")==_title+" - native description"+_suffix
            && scrNTTEFullPetThroneButtDescription(_title+" - native description")==_title+" - native description"+_suffix,
            "Source Salamander Throne Butt lost active title/colored exact text or duplicated existing title")
        _icon.selected=1;surface_set_target(_surface);draw_clear_alpha(c_black,0)
        with(_icon) event_perform(ev_draw,0)
        surface_reset_target()
        // Native Draw declares local txt2, so the instance txt2 field does
        // not expose the rendered string. Compare actual footer pixels.
        var _different=0
        for(var _x=0;_x<view_width;_x+=2) for(var _y=max(0,view_height-112);_y<view_height;_y+=2)
            if(surface_getpixel_ext(_surface,_x,_y)!=surface_getpixel_ext(_baseline,_x,_y)) _different++
        scrNTTESmokeLog("PET METADATA DRAW DIAG "+json_stringify({changedPixels:_different,stopped:lockstep_stop,
            title:_title,suffix:_suffix,helper:scrNTTEFullPetThroneButtDescription("native description"),
            viewport:[view_width,view_height]}))
        assert(_different>0,
            "Actual native SkillIcon Draw omitted source pet Throne Butt information")
        // The companion bonus belongs to Throne Butt only; an ordinary
        // mutation rendered through the same native object stays unchanged.
        _icon.skill=mut_long_arms;_icon.selected=1
        surface_set_target(_surface);draw_clear_alpha(c_black,0);with(_icon) event_perform(ev_draw,0);surface_reset_target()
        instance_deactivate_object(_pet);_icon.selected=1
        surface_set_target(_baseline);draw_clear_alpha(c_black,0);with(_icon) event_perform(ev_draw,0);surface_reset_target()
        instance_activate_object(_pet)
        _different=0
        for(var _x=0;_x<view_width;_x+=2) for(var _y=max(0,view_height-112);_y<view_height;_y+=2)
            if(surface_getpixel_ext(_surface,_x,_y)!=surface_getpixel_ext(_baseline,_x,_y)) _different++
        assert(_different==0,
            "Native pet tooltip leaked into a different mutation")
    }
    finally {
        if(surface_exists(_surface)) surface_free(_surface)
        if(surface_exists(_baseline)) surface_free(_baseline)
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        global.ntte_full_progress=_progress;global.language_current=_old_language;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL PET METADATA NATIVE: source Salamander Throne Butt active title/exact colored description/no repeated title/actual native SkillIcon Draw/ordinary mutation unchanged OK @"+string(30/timescale))
}
