// The authored libSaves animations remain the presentation. These adapters
// connect its NTT TopCont death gate to this runner's separate GameOver object.
function scrFRUnlockContHasPortrait(_controller) {
    if(!instance_exists(_controller)) return false;
    var _unlocks=_controller[$ "unlock"]??undefined;
    if(!is_array(_unlocks)) return false;
    var _first=max(0,_controller[$ "unlock_index"]??0);
    for(var _i=_first;_i<array_length(_unlocks);++_i)
        if((_unlocks[_i][$ "spr"]??-1)!=-1) return true;
    return false;
}

function scrFRUnlockPresentationContext() {
    if(!scrFREnabled() || instance_exists(Player) || scrGameIsPaused()
       || instance_exists(Menu) || instance_exists(MenuGen)
       || scrFRInstanceExists(FR_OBJECT_BACK_MAIN_MENU)) return false;
    // PauseButton belongs to both pause and game over in the host runner.
    return !instance_exists(PauseButton) || instance_exists(GameOver);
}

function scrFRUnlockPendingPortrait() {
    if(!scrFRUnlockPresentationContext()) return false;
    var _pending=false;
    with(FRCustomObject) if(name=="UnlockCont" && scrFRUnlockContHasPortrait(id)) {
        _pending=true;break;
    }
    return _pending;
}

function scrFRUnlockHostCapture() {
    var _tops=[];
    with(TopCont) array_push(_tops,{instance:id,visible:visible,darkness:darkness});
    return {tops:_tops,letterbox:scrFRLetterbox()};
}

function scrFRUnlockHostRestore(_state) {
    if(!is_struct(_state)) return;
    for(var _i=0;_i<array_length(_state.tops);++_i) {
        var _top=_state.tops[_i],_instance=_top.instance;
        if(instance_exists(_instance)) {
            _instance.visible=_top.visible;
            _instance.darkness=_top.darkness;
        }
    }
    scrFRLetterbox(_state.letterbox);
}

function scrFRUnlockContinuePressed() {
    return (is_mobile && mouse_ui_clicked())
        || keyboard_check_pressed(vk_enter)
        || input_gamepad_check_pressed(global.index,gp_face1);
}

function scrFRUnlockStep() {
    var _controller=id,_saved=self[$ "fr_unlock_host_state"]??undefined;
    var _portrait=scrFRUnlockPresentationContext() && scrFRUnlockContHasPortrait(id)
        && !instance_exists(UnlockScreen);
    if(_portrait) {
        if(is_undefined(_saved)) {
            _saved=scrFRUnlockHostCapture();fr_unlock_host_state=_saved;
        }
        // A late unlock can be queued after TopCont's End Step. Remove only
        // native death controls, so source's PauseButton guard can progress.
        if(instance_exists(GameOver)) {
            with(PauseButton) instance_destroy();
            with(GameOver) instance_destroy();
        }
    }
    var _slot=global.index,_fire=KeyCont.press_fire[_slot];
    try {
        // The source still owns advancement and its 20-tick debounce. Native
        // touch confirmation has no MobileUI button after the player's death.
        if(_portrait && unlock_delay<=0 && unlock_delay_continue<=0
           && scrFRUnlockContinuePressed()) KeyCont.press_fire[_slot]=true;
        scrFRInvokeHere(fr_dependencies_libSaves_mod_gml_UnlockCont_step,[]);
    } finally {
        KeyCont.press_fire[_slot]=_fire;
        if(!instance_exists(_controller)) scrFRUnlockHostRestore(_saved);
    }
}

function scrFRUnlockDraw() {
    var _font=draw_get_font(),_halign=draw_get_halign(),_valign=draw_get_valign();
    var _colour=draw_get_color(),_alpha=draw_get_alpha();
    try {
        if(scrFRUnlockPresentationContext() && unlock_delay<=0
           && unlock_index>=0 && unlock_index<array_length(unlock)) {
            draw_set_color(c_black);draw_set_alpha(.6);
            draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+view_height,false);
            draw_set_color(c_white);draw_set_alpha(1);
        }
        scrFRInvokeHere(fr_dependencies_libSaves_mod_gml_UnlockCont_draw,[]);
    } finally {
        draw_set_font(_font);draw_set_halign(_halign);draw_set_valign(_valign);
        draw_set_color(_colour);draw_set_alpha(_alpha);
    }
}
