// Run only in the isolated generated-room harness. These checks call the real
// Cove award callback, libSaves queue/animation callbacks, and TopCont death gate.
function scrFRUnlockTestsCheck(_name,_condition) {
    assert(_condition,"Frontier unlock: "+_name);
    scrNTTESmokeLog("PASS FRONTIER UNLOCK "+_name);
}

function scrFRUnlockTestsController() {
    var _items=scrFRMatching(FRCustomObject,"name","UnlockCont");
    return array_length(_items)>0?_items[0]:noone;
}

function scrFRUnlockTestsRunStep(_controller) {
    if(instance_exists(_controller)) with(_controller)
        scrFRModCallArray("mod","libSaves","UnlockCont_step",[]);
}

function scrFRUnlockTestsRender(_controller,_filename) {
    var _surface=surface_create(view_width,view_height);
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1);
    var _buffer=buffer_create(view_width*view_height*4,buffer_fixed,1);
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    var _color=draw_get_color(),_alpha=draw_get_alpha();
    assert(surface_exists(_surface),"Frontier unlock fixture surface allocation failed");
    surface_set_target(_surface);
    try {
        camera_apply(_camera);
        draw_clear_alpha(c_black,0);
        matrix_set(matrix_world,matrix_build_identity());
        scrFRInvokeDraw(_controller,["mod","libSaves","UnlockCont_draw"],[]);
        scrFRUnlockTestsCheck("authored draw restores native graphics state",
            draw_get_font()==_font && draw_get_halign()==_ha && draw_get_valign()==_va
            && draw_get_color()==_color && draw_get_alpha()==_alpha);
    } finally {
        surface_reset_target();
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
    }
    try {
        buffer_get_surface(_buffer,_surface,0);
        var _ink=0;
        for(var _pixel=0;_pixel<view_width*view_height;++_pixel) {
            var _offset=_pixel*4;
            if(buffer_peek(_buffer,_offset+3,buffer_u8)>0
                && buffer_peek(_buffer,_offset,buffer_u8)+buffer_peek(_buffer,_offset+1,buffer_u8)
                    +buffer_peek(_buffer,_offset+2,buffer_u8)>48) _ink++;
        }
        scrFRUnlockTestsCheck("authored presentation GPU readback contains visible artwork",_ink>16);
        surface_save(_surface,working_directory+_filename);
    } finally {surface_free(_surface);camera_destroy(_camera);buffer_delete(_buffer);}
}

function scrFRUnlockTestsStart(_driver) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled())
        throw "Frontier unlock fixture requires the isolated desktop harness";
    _driver.fr_unlock_tests_done=false;_driver.fr_unlock_bootstrap=true;
    _driver.fr_unlock_boot_ticks=0;_driver.fr_unlock_generation_started=false;_driver.persistent=true;
    save_set_value("game","tutorial",false);
    UberCont.opt_autopause=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0;
    UberCont.paused=false;UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;
    GameCont.maxsubarea=scrAreaGetMaxSubarea(area_desert);GameCont.finalsubarea=false;
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.ntte_full_pending_destination=undefined;
    GameCont.can_advance_stage=false;GameCont.is_level_ended=true;
    global.ntte_full_sync_generation=false;
    // The host smoke bootstrap has a Player and hand-built floor patch, but
    // no TopCont or natural transition controller. A plain room_restart only
    // disposes that room; LevCont normally starts GenCont separately. Track a
    // nonpersistent marker to prove disposal before starting the real async
    // generator on the next step. GenCont itself must create TopCont/terrain.
    _driver.fr_unlock_room_marker=instance_create(0,0,FRMarker);
    room_restart();
}

function scrFRUnlockTestsRun(_driver) {
    assert(instance_exists(Player) && instance_exists(TopCont) && !instance_exists(Menu)
        && !instance_exists(GameOver) && !instance_exists(PauseButton),
        "Frontier unlock fixture requires a live generated room");
    assert(!instance_exists(UnlockScreen) && !instance_exists(NTTEFullUnlockCont)
        && !instance_exists(scrFRUnlockTestsController()),"Frontier unlock fixture requires an empty unlock queue");
    var _save=scrFRModCallArray("mod","libSaves","save_get",["Frontier","unlock_bubbles"]);
    var _cove_alt=scrFRModGet("area","cove","settingAltCoveEntrance"),_slot=global.index;
    var _fire=KeyCont.press_fire[_slot],_box=scrFRLetterbox(),_paused=UberCont.paused;
    var _tops=scrFRUnlockHostCapture(),_players=[],_floors=[],_first_id=instance_create(0,0,FRMarker);
    var _old_mobile=instance_exists(MobileUI),_controller=noone;
    with(Player) array_push(_players,id);
    with(Floor) array_push(_floors,id);
    try {
        UberCont.paused=false;KeyCont.press_fire[_slot]=false;
        scrFRModCallArray("mod","libSaves","save_set",["Frontier","unlock_bubbles",0]);
        scrFRUnlockTestsCheck("locked save remains unavailable before the authored unlock",
            !scrFRModCallArray("race","bubbles","race_avail",[]));
        scrFRModCallArray("mod","libSaves","unlock_popup",["FRONTIER TEST","POPUP ONLY"]);
        _controller=scrFRUnlockTestsController();
        scrFRUnlockTestsCheck("popup uses real source controller and does not award ownership",
            instance_exists(_controller) && _controller.unlock[0].spr==-1
            && !scrFRModCallArray("race","bubbles","race_avail",[]));
        _controller.splash_delay=0;
        repeat(30) scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("live corner popup advances original splat and text timers",
            _controller.splash_index==0 && _controller.splash_timer>0 && _controller.splash_image>0
            && sprite_exists(_controller.splash_sprit));
        scrFRUnlockTestsRender(_controller,"frontier-unlock-popup.png");
        for(var _i=0;_i<array_length(_players);++_i) instance_deactivate_object(_players[_i]);
        scrFRUnlockTestsCheck("popup-only queue never blocks native GameOver",
            !scrFRUnlockPendingPortrait() && !scrNTTEFullUnlockPendingPortrait());
        scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("popup-only source queue completes without a portrait",!instance_exists(_controller));
        for(var _i=0;_i<array_length(_players);++_i) instance_activate_object(_players[_i]);

        // Run the actual award trigger. Hide Floor only during this callback so
        // its unrelated random Cove decals do not alter this desert fixture.
        for(var _i=0;_i<array_length(_floors);++_i) instance_deactivate_object(_floors[_i]);
        scrFRModSet("area","cove","settingAltCoveEntrance",false);
        scrFRModCallArray("area","cove","area_start",[]);
        for(var _i=0;_i<array_length(_floors);++_i) instance_activate_object(_floors[_i]);
        _controller=scrFRUnlockTestsController();
        scrFRUnlockTestsCheck("real Cove area_start awards Bubbles and queues the original portrait",
            scrFRModCallArray("race","bubbles","race_avail",[]) && instance_exists(_controller)
            && array_length(_controller.unlock)==1 && _controller.unlock[0].nam[0]=="BUBBLES UNLOCKED"
            && _controller.unlock[0].nam[1]=="BUBBLES" && _controller.unlock[0].img==0
            && _controller.unlock[0].spr==scrFRRaceVar("sprPortrait"));
        scrFRModCallArray("area","cove","area_start",[]);
        scrFRUnlockTestsCheck("re-entering Cove does not award or queue a duplicate",array_length(_controller.unlock)==1);
        scrFRModCallArray("mod","libSaves","unlock_popup",["BETWEEN","NO PORTRAIT"]);
        scrFRModCallArray("mod","libSaves","unlock_splat",["SECOND","SECOND PORTRAIT",_controller.unlock[0].spr,-1]);
        for(var _i=0;_i<array_length(_players);++_i) instance_deactivate_object(_players[_i]);
        scrFRUnlockTestsCheck("pending source portrait blocks the real native death gate",
            scrFRUnlockPendingPortrait() && scrNTTEFullUnlockPendingPortrait());
        with(TopCont) event_perform(ev_step,ev_step_end);
        scrFRUnlockTestsCheck("TopCont retains game world before source portrait confirmation",!instance_exists(GameOver));
        repeat(49) scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("authored 50-tick death delay is retained",_controller.unlock_delay==1);
        repeat(22) scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("original portrait animation and confirmation delay complete",
            _controller.unlock_delay<=0 && _controller.unlock_image>0 && _controller.unlock_porty>=3
            && _controller.unlock_delay_continue<=0 && scrFRUnlockPendingPortrait());
        scrFRUnlockTestsRender(_controller,"frontier-unlock-portrait.png");
        KeyCont.press_fire[_slot]=true;scrFRUnlockTestsRunStep(_controller);KeyCont.press_fire[_slot]=false;
        scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("confirmation skips popup-only entry and starts the next portrait",
            _controller.unlock_index==2 && _controller.unlock_delay<=0 && scrFRUnlockPendingPortrait());
        repeat(21) scrFRUnlockTestsRunStep(_controller);
        KeyCont.press_fire[_slot]=true;scrFRUnlockTestsRunStep(_controller);KeyCont.press_fire[_slot]=false;
        scrFRUnlockTestsRunStep(_controller);
        scrFRUnlockTestsCheck("last confirmation releases native GameOver and restores TopCont",
            !instance_exists(_controller) && !scrFRUnlockPendingPortrait() && !scrNTTEFullUnlockPendingPortrait()
            && TopCont.visible==_tops.tops[0].visible && TopCont.darkness==_tops.tops[0].darkness);
        with(TopCont) event_perform(ev_step,ev_step_end);
        scrFRUnlockTestsCheck("real GameOver appears only after all portraits are confirmed",
            instance_exists(GameOver) && instance_exists(PauseButton));
    } finally {
        with(GameOver) instance_destroy();
        with(PauseButton) instance_destroy();
        with(FRCustomObject) if(id>_first_id && name!="libGlobal") instance_destroy();
        if(instance_exists(_controller)) instance_destroy(_controller);
        if(instance_exists(_first_id)) instance_destroy(_first_id);
        for(var _i=0;_i<array_length(_floors);++_i) instance_activate_object(_floors[_i]);
        for(var _i=0;_i<array_length(_players);++_i) instance_activate_object(_players[_i]);
        scrFRUnlockHostRestore(_tops);scrFRLetterbox(_box);
        UberCont.paused=_paused;scrFRModSet("area","cove","settingAltCoveEntrance",_cove_alt);KeyCont.press_fire[_slot]=_fire;
        scrFRModCallArray("mod","libSaves","save_set",["Frontier","unlock_bubbles",_save]);
        if(_old_mobile && !instance_exists(MobileUI)) instance_create(0,0,MobileUI);
    }
    _driver.fr_unlock_tests_done=true;
}

function scrFRUnlockTestsStep(_driver) {
    if(_driver.fr_unlock_bootstrap) {
        _driver.fr_unlock_boot_ticks++;
        assert(_driver.fr_unlock_boot_ticks<900,"Frontier unlock real room generation timed out");
        if(!_driver.fr_unlock_generation_started) {
            assert(!instance_exists(_driver.fr_unlock_room_marker),
                "Frontier unlock fixture started generation before the real room boundary");
            assert(!instance_exists(TopCont) && !instance_exists(GenCont) && instance_number(Floor)==0,
                "Frontier unlock room disposal retained controllers or terrain from its hand-built bootstrap");
            if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
            if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
            var _generator=instance_create(0,0,GenCont);
            assert(instance_exists(_generator) && !_generator.ntte_full_sync_generation,
                "Frontier unlock fixture replaced real async generation with sync callbacks");
            _driver.fr_unlock_generation_started=true;
            scrNTTESmokeLog("FRONTIER UNLOCK real room boundary disposed bootstrap; async GenCont started");
            return false;
        }
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen() || !instance_exists(Player)) return false;
        assert(instance_exists(TopCont) && instance_number(Floor)>=20 && instance_number(Wall)>0,
            "Frontier unlock native room lifecycle omitted generated terrain or TopCont");
        scrNTTESmokeLog("FRONTIER UNLOCK REAL ROOM floors="+string(instance_number(Floor))
            +" walls="+string(instance_number(Wall))+" top="+string(instance_number(TopCont)));
        _driver.fr_unlock_bootstrap=false;
        scrFRUnlockTestsRun(_driver);
    }
    return _driver.fr_unlock_tests_done;
}
