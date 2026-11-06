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

function scrFRPromptLateStep() {
    var _inputs=[];
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
        if(!can_pick) {
            array_push(_inputs,[index,KeyCont.press_pick[index]]);
            KeyCont.press_pick[index]=false;
        }
    }
    try {
        scrFRInvokeHere(fr_dependencies_libGeneral_mod_gml_late_step,[]);
    } finally {
        for(var _i=0;_i<array_length(_inputs);++_i)
            KeyCont.press_pick[_inputs[_i][0]]=_inputs[_i][1];
    }
}

function scrFRPromptHUDSelected(_player) {
    if(!scrFREnabled() || !instance_exists(_player) || !_player.visible || !_player.can_pick)
        return noone;
    var _near=_player[$ "nearwep"]??noone;
    if(!instance_exists(_near)) return noone;
    var _selected=noone;
    with(FRCustomObject) if(name=="LibPrompt" && visible && instance_exists(nearwep)
        && real(nearwep)==real(_near)
        && (!instance_exists(creator) || creator.visible)) {
        if(place_meeting(x,y,_player)) {_selected=id;break;}
    }
    var _winner=scrNTTEFullPromptWinner(_player);
    if(instance_exists(_selected) && (!instance_exists(_winner) || real(_winner)!=real(_selected)))
        return noone;
    return _selected;
}

function scrFRPromptHUD(_player) {
    var _prompt=scrFRPromptHUDSelected(_player);
    if(!instance_exists(_prompt)) return false;
    var _near=_prompt.nearwep,_text=_prompt.mytext;
    var _x=floor(_near.x-view_xview),_y=floor(_near.y-view_yview);
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
    return true;
}
