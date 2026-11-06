// libGeneral owns pick dispatch and its temporary IceFlower. Share native
// overlap priority with its authored selector and expose the selected prompt
// through the native mobile HUD, without dispatching an action a second time.
function scrFRPromptIs(_instance) {
    return instance_exists(_instance) && _instance.object_index==FRCustomObject
        && (_instance[$ "name"]??"")=="LibPrompt";
}

function scrFRPromptWinner(_player,_winner,_depth,_distance) {
    if(!scrFREnabled()) return _winner;
    with(FRCustomObject) if(name=="LibPrompt" && visible
        && (!instance_exists(creator) || creator.visible) && place_meeting(x,y,_player)) {
        if(is_array(on_meet) && !scrFRCallArray(on_meet,[])) continue;
        var _d=point_distance(x,y,_player.x,_player.y);
        if(depth<_depth || (depth==_depth && _d<_distance)) {
            _winner=real(id);_depth=depth;_distance=_d;
        }
    }
    return _winner;
}

function scrFRPromptCapturePick(_index) {
    // ButtonAct samples a physical press every render frame. Source callbacks
    // run at30Hz, so a tap on the other60Hz frame must survive until the next
    // source selector instead of being overwritten by the next native sample.
    if(!scrFREnabled() || _index<0 || _index>=array_length(KeyCont.press_pick)
        || !KeyCont.press_pick[_index]) return;
    var _pending=scrNTTEFullValue(FRWorld,"fr_prompt_pending_picks",array_create(array_length(KeyCont.press_pick),false));
    _pending[_index]=true;
    FRWorld.fr_prompt_pending_picks=_pending;
}

function scrFRPromptLateStep() {
    var _inputs=[],_pending=scrNTTEFullValue(FRWorld,"fr_prompt_pending_picks",[]);
    with(Player) {
        // NTT populated Player.nearwep before libGeneral.late_step. The native
        // runner selects pickups directly and otherwise leaves that field
        // empty. Seed its actual native winner for the authored priority test.
        var _native=scrNTTEFullPromptWinner(id);
        if(scrFRPromptIs(_native)) _native=noone;
        if(!instance_exists(_native)) {
            var _weapon=instance_nearest(x,y,WepPickup);
            if(instance_exists(_weapon) && _weapon.visible && !_weapon.autopick
                && place_meeting(x,y,_weapon)) _native=_weapon;
        }
        nearwep=_native;
        array_push(_inputs,[index,KeyCont.press_pick[index]]);
        var _queued=index<array_length(_pending) && _pending[index];
        KeyCont.press_pick[index]=can_pick && (KeyCont.press_pick[index] || _queued);
    }
    try {
        scrFRInvokeHere(fr_dependencies_libGeneral_mod_gml_late_step,[]);
    } finally {
        for(var _i=0;_i<array_length(_inputs);++_i)
            KeyCont.press_pick[_inputs[_i][0]]=_inputs[_i][1];
        FRWorld.fr_prompt_pending_picks=array_create(array_length(KeyCont.press_pick),false);
    }
}

function scrFRPromptHUDSelected(_player) {
    if(!scrFREnabled() || !instance_exists(_player) || !_player.visible || !_player.can_pick)
        return noone;
    // The source's disposable IceFlower proxy is created/deleted on its30Hz
    // clock. Render from the actual winning prompt, which is continuously
    // present, rather than coupling touch availability to that proxy's life.
    var _winner=scrNTTEFullPromptWinner(_player);
    return scrFRPromptIs(_winner)?_winner:noone;
}

function scrFRPromptHUD(_player) {
    var _prompt=scrFRPromptHUDSelected(_player);
    if(!instance_exists(_prompt)) return false;
    var _text=scrFRLocalize(_prompt.mytext);
    var _font=scrFRLocalizationFont(_text);
    var _x=floor(_prompt.x+_prompt.xoff-view_xview),_y=floor(_prompt.y+_prompt.yoff-view_yview);
    draw_pickup_button(_x,_y);
    scrNTTEFullDrawText(_x,_y-31,_text);
    if(is_touch(_player.index)) with(ButtonAct) {
        // Source prompts have collision masks, not UI artwork. Use the same
        // native generic action icon and actual ButtonAct input as NTTE.
        scrNTTEFullPromptTouchIcon(_prompt,x,y,rad);
        if(is_string(_text)) {
            var _height=font_get_string_height(_text);
            scrNTTEFullDrawText(x,max(_height,y-rad*.5-_height-12),_text);
        }
        alpha=approach(alpha,1.1,.4);active=true;
    }
    draw_set_font(_font);return true;
}
