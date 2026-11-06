// Source cursor coordinates are per player. Native KeyCont already combines
// keyboard, controller and touch aiming; do not replace touch aim with a PC mouse.
function scrFRInputIndex(_index=undefined) {
    if(is_undefined(_index)) _index=global.index;
    return clamp(floor(_index),0,INPUT_MAX_PLAYERS-1);
}

function scrFRMouseGuiToWorld(_axis,_point) {
    return _axis==0?view_xview+_point*view_width/max(1,gui_w):view_yview+_point*view_height/max(1,gui_h);
}

function scrFRMouseLocal(_axis) {
    if(is_desktop) return _axis==0?mouse_x:mouse_y;
    return scrFRMouseGuiToWorld(_axis,_axis==0?device_mouse_x_to_gui(0):device_mouse_y_to_gui(0));
}

function scrFRMousePoint(_index=undefined) {
    _index=scrFRInputIndex(_index);
    var _player=scrFRPlayerFind(_index);
    if(instance_exists(_player)) {
        var _direction=KeyCont.dir_fire[_index],_distance=KeyCont.dis_fire[_index];
        return [_player.x+lengthdir_x(_distance,_direction),_player.y+lengthdir_y(_distance,_direction)];
    }
    // Menus have no player. Only a locally controlled slot owns this pointer.
    if(_index==global.index) return [scrFRMouseLocal(0),scrFRMouseLocal(1)];
    return [view_xview+view_width/2,view_yview+view_height/2];
}

function scrFRMouseCoordinate(_axis,_index=undefined) {
    var _point=scrFRMousePoint(_index);
    return _point[_axis];
}

function scrFRMouseDelta(_axis,_index=undefined) {
    _index=scrFRInputIndex(_index);
    if(!variable_global_exists("fr_input_samples") || !is_array(global.fr_input_samples)) global.fr_input_samples=array_create(INPUT_MAX_PLAYERS,undefined);
    var _sample=global.fr_input_samples[_index],_point=scrFRMousePoint(_index);
    if(is_undefined(_sample)) {
        _sample={stamp:current_frame,point:_point,delta:[0,0]};
        global.fr_input_samples[_index]=_sample;
    } else if(_sample.stamp!=current_frame) {
        _sample.delta=[_point[0]-_sample.point[0],_point[1]-_sample.point[1]];
        _sample.point=_point;_sample.stamp=current_frame;
    }
    return _sample.delta[_axis];
}

function scrFRViewCoordinate(_axis,_index=undefined) {
    // The mobile runner uses one shared native camera, including local co-op.
    return _axis==0?view_xview:view_yview;
}

function scrFRViewValue(_kind,_index=undefined) {
    _index=scrFRInputIndex(_index);
    if(_index==global.index && instance_exists(BackCont)) {
        switch(_kind) {
            case "object":return scrNTTEFullValue(BackCont,"ntte_full_view_object",noone);
            case "pan":return scrNTTEFullValue(BackCont,"ntte_full_view_pan_factor",undefined);
            case "shake":return BackCont.shake;
        }
    }
    var _defaults={object:noone,pan:undefined,shake:0};
    if(!variable_global_exists("fr_view_values") || !is_struct(global.fr_view_values)) return _defaults[$ _kind];
    var _values=global.fr_view_values[$ _kind];
    return is_array(_values)?_values[_index]:_defaults[$ _kind];
}

function scrFRViewSet(_kind,_index,_value,_operation="=") {
    _index=scrFRInputIndex(_index);
    if(_operation!="=") {
        var _old=scrFRViewValue(_kind,_index);
        switch(_operation) {
            case "+=":_value=_old+_value;break;
            case "-=":_value=_old-_value;break;
            case "*=":_value=_old*_value;break;
            case "/=":_value=_old/_value;break;
        }
    }
    if(!variable_global_exists("fr_view_values") || !is_struct(global.fr_view_values)) global.fr_view_values={object:array_create(INPUT_MAX_PLAYERS,noone),
        pan:array_create(INPUT_MAX_PLAYERS,undefined),shake:array_create(INPUT_MAX_PLAYERS,0)};
    var _values=global.fr_view_values[$ _kind];
    _values[_index]=_value;global.fr_view_values[$ _kind]=_values;
    if(_index==global.index && instance_exists(BackCont)) {
        switch(_kind) {
            case "object":BackCont.ntte_full_view_object=_value;break;
            case "pan":BackCont.ntte_full_view_pan_factor=_value;break;
            case "shake":BackCont.shake=_value;break;
        }
    }
    return _value;
}

function scrFRLetterbox(_value=undefined) {
    if(!instance_exists(UberCont)) return false;
    if(!is_undefined(_value)) scrLetterbox(!!_value);
    return UberCont.letterbox;
}

// Frontier's movement augments need the same press/release edges as keyboard
// controls. The host movement stick previously supplied only held directions.
function scrFRTouchInputState() {
    var _world=instance_exists(FRWorld)?FRWorld.id:noone;
    if(!variable_global_exists("fr_touch_input") || !is_struct(global.fr_touch_input)
       || global.fr_touch_input.world!=_world) {
        global.fr_touch_input={world:_world,movement:array_create(INPUT_MAX_PLAYERS,undefined),
            pointer:{frame:-1,ready:false,serial:-1,samples:array_create(5,undefined),
                pending:array_create(5,undefined),output:array_create(5,undefined)}};
    }
    return global.fr_touch_input;
}

function scrFRTouchFixtureSample(_touch) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
       || !variable_global_exists("fr_touch_input_fixture")) return undefined;
    var _fixture=global.fr_touch_input_fixture;
    if(!is_struct(_fixture) || !(_fixture[$ "active"]??false)) return undefined;
    return _touch>=0 && _touch<array_length(_fixture.samples)?_fixture.samples[_touch]:undefined;
}
function scrFRTouchX(_touch) {
    var _sample=scrFRTouchFixtureSample(_touch);
    return is_undefined(_sample)?device_mouse_x_to_gui(_touch):_sample.x;
}
function scrFRTouchY(_touch) {
    var _sample=scrFRTouchFixtureSample(_touch);
    return is_undefined(_sample)?device_mouse_y_to_gui(_touch):_sample.y;
}
function scrFRTouchHeld(_touch) {
    var _sample=scrFRTouchFixtureSample(_touch);
    return is_undefined(_sample)?device_mouse_check_button(_touch,mb_left):_sample.held;
}
function scrFRTouchPressed(_touch) {
    var _sample=scrFRTouchFixtureSample(_touch);
    return is_undefined(_sample)?device_mouse_check_button_pressed(_touch,mb_left):_sample.pressed;
}
function scrFRTouchReleased(_touch) {
    var _sample=scrFRTouchFixtureSample(_touch);
    return is_undefined(_sample)?device_mouse_check_button_released(_touch,mb_left):_sample.released;
}
function scrFRTouchNearest(_radius) {
    if(is_undefined(scrFRTouchFixtureSample(0))) return get_nearest_touch(_radius);
    // Deterministic raw hardware samples exercise the real JoystickMove event
    // only inside the explicit Windows smoke fixture. Shipping uses its host
    // ownership, nearest-control and touch-region selector unchanged.
    for(var _i=0;_i<5;++_i)
        if(scrFRTouchHeld(_i) && distance_to_point(scrFRTouchX(_i),scrFRTouchY(_i))<=get_touch_radius(_radius)) return _i;
    return -1;
}

function scrFRTouchMovementSample(_index,_touch) {
    if(!scrFREnabled() || !KeyCont.touch[_index]) return;
    var _input=scrFRTouchInputState(),_state=_input.movement[_index];
    if(is_undefined(_state)) {
        _state={frame:-1,ready:false,serial:-1,down:[false,false,false,false],
            pending_press:[false,false,false,false],pending_release:[false,false,false,false],
            output_press:[false,false,false,false],output_release:[false,false,false,false]};
        _input.movement[_index]=_state;
    }
    // Each authored step has already had the previous ready sample. Edges
    // sampled on the intervening 60 Hz render frame remain queued for the next
    // 30 Hz source step, then expire even when no augment consumes them.
    if(_state.frame!=current_frame && _state.ready) {
        _state.pending_press=[false,false,false,false];
        _state.pending_release=[false,false,false,false];
    }
    var _active=_touch>=0 && scrFRTouchHeld(_touch) && KeyCont.moving[_index]>0,
        _actions=["east","nort","west","sout"];
    for(var _a=0;_a<4;++_a) {
        var _held=variable_struct_get(KeyCont,"hold_"+_actions[_a]),
            _pressed=variable_struct_get(KeyCont,"press_"+_actions[_a]),
            _released=variable_struct_get(KeyCont,"release_"+_actions[_a]),
            _down=_active && _held[_index],_press=_down && !_state.down[_a],
            _release=!_down && _state.down[_a];
        _held[_index]=_down;_pressed[_index]=_press;_released[_index]=_release;
        _state.pending_press[_a]=_state.pending_press[_a] || _press;
        _state.pending_release[_a]=_state.pending_release[_a] || _release;
        _state.down[_a]=_down;
    }
    _state.frame=current_frame;_state.ready=scrFRReadyTick();
}

function scrFRTouchMovementValue(_index,_action,_prefix) {
    if(_prefix=="hold" || !KeyCont.touch[_index] || !scrFRReadyTick()) return undefined;
    var _at=array_get_index(["east","nort","west","sout"],_action);
    if(_at<0) return undefined;
    var _state=scrFRTouchInputState().movement[_index];
    if(is_undefined(_state) || _state.frame!=current_frame) return undefined;
    var _serial=scrFRLogicSerial();
    if(_state.serial!=_serial) {
        _state.output_press=_state.pending_press;_state.output_release=_state.pending_release;
        _state.pending_press=[false,false,false,false];_state.pending_release=[false,false,false,false];
        _state.serial=_serial;
    }
    return _prefix=="press"?_state.output_press[_at]:_state.output_release[_at];
}

function scrFRTouchPoll() {
    if(!scrFREnabled() || !KeyCont.touch[global.index]) return;
    var _state=scrFRTouchInputState().pointer;
    if(_state.frame!=current_frame && _state.ready) _state.pending=array_create(5,undefined);
    for(var _i=0;_i<5;++_i) {
        var _sample={x:scrFRTouchX(_i),y:scrFRTouchY(_i),held:scrFRTouchHeld(_i)};
        _state.samples[_i]=_sample;
        if(scrFRTouchPressed(_i)) _state.pending[_i]=_sample;
    }
    _state.frame=current_frame;_state.ready=scrFRReadyTick();
}

// LibMenu owns authored UI hit boxes. Its pointer is a screen finger even
// when a revived Robot still exists behind the Cyberspace admission screen;
// ordinary source weapon mouse arrays continue using the native aim stick.
function scrFRMenuTouchOwns() {
    return scrFREnabled() && KeyCont.touch[global.index];
}
function scrFRMenuTouchCheck(_x,_y,_width,_height,_mode=0,_view=0,_index=undefined) {
    if(!is_undefined(_index) && _index!=global.index) return -1;
    var _state=scrFRTouchInputState().pointer;
    if(_state.frame!=current_frame) scrFRTouchPoll();
    var _serial=scrFRLogicSerial();
    if(_state.serial!=_serial) {
        _state.output=_state.pending;_state.pending=array_create(5,undefined);_state.serial=_serial;
    }
    for(var _i=0;_i<5;++_i) {
        var _sample=_mode==0?_state.output[_i]:_state.samples[_i];
        if(is_undefined(_sample) || (_mode!=0 && !_sample.held)) continue;
        var _px=scrFRMouseGuiToWorld(0,_sample.x),_py=scrFRMouseGuiToWorld(1,_sample.y);
        if(_view==1) {_px-=view_xview;_py-=view_yview;}
        if(point_in_rectangle(_px,_py,_x,_y,_x+_width,_y+_height)) return global.index;
    }
    return -1;
}
