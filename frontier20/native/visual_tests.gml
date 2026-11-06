// GPU-backed, offscreen acceptance. Every draw target is checked against a
// colour/alpha positive control; an empty or black image can never pass.
function scrFRVisualCheck(_name,_condition) {
    assert(_condition,"Frontier visual: "+_name);
    scrNTTESmokeLog("PASS FRONTIER VISUAL "+_name);
}

function scrFRVisualCapture(_kind,_width,_height,_viewx,_viewy,_args) {
    var _surface=-1,_buffer=-1,_camera=-1,_target=false,_success=false;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection);
    var _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign();
    var _colour=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current();
    gpu_push_state();
    try {
        _surface=surface_create(_width,_height);
        _buffer=buffer_create(_width*_height*4,buffer_fixed,1);
        _camera=camera_create_view(_viewx,_viewy,_width,_height,0,noone,-1,-1,-1,-1);
        assert(surface_exists(_surface) && buffer_exists(_buffer),"Frontier visual capture allocation failed");
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());
        shader_reset();gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);
        draw_set_alpha(1);draw_set_color(c_white);draw_set_font(fntM1);
        draw_set_halign(fa_left);draw_set_valign(fa_top);draw_clear_alpha(c_black,0);
        switch(_kind) {
            case "empty":break;
            case "control":
                draw_set_color(c_red);draw_rectangle(_viewx,_viewy,_viewx+15,_viewy+15,false);
                draw_set_color(c_lime);draw_rectangle(_viewx+16,_viewy,_viewx+31,_viewy+15,false);
                draw_set_color(c_blue);draw_rectangle(_viewx,_viewy+16,_viewx+15,_viewy+31,false);
                draw_set_color(c_white);draw_rectangle(_viewx+16,_viewy+16,_viewx+31,_viewy+31,false);
                break;
            case "native-weapon":
                draw_sprite_ext(_args[0],_args[1],_args[2],_args[3],1,_args[4],_args[5],c_white,1);
                break;
            case "source-weapon":
                scrFRInvokeDraw(id,["mod","libGeneral","draw_weapon"],_args);
                break;
            case "source-inline":
                scrFRDrawText(_viewx+24,_viewy+24,_args[0],1.5,.75,17,c_aqua,.7);
                break;
            case "native-inline":
                draw_text_nt(_viewx+24,_viewy+24,_args[0],1.5,.75,17,c_aqua,.7);
                break;
            case "native-actor":
                draw_sprite_ext(_args[0],_args[1],_args[2],_args[3],_args[4],_args[5],_args[6],c_white,1);
                break;
            case "actor-event":
                with(_args[0]) event_perform(ev_draw,0);
                break;
            case "source-unlock":
                scrFRInvokeDraw(_args[0],["mod","libSaves","UnlockCont_draw"],[]);
                break;
            default:throw "Unknown Frontier visual capture kind: "+_kind;
        }
        assert(real(surface_get_target())==real(_surface),"Frontier source draw lost its isolated GPU target");
        surface_reset_target();_target=false;
        buffer_get_surface(_buffer,_surface,0);
        var _coverage=0,_ink=0,_palette={},_left=_width,_right=-1,_top=_height,_bottom=-1;
        for(var _y=0;_y<_height;++_y) for(var _x=0;_x<_width;++_x) {
            var _offset=4*(_y*_width+_x),_a=buffer_peek(_buffer,_offset+3,buffer_u8);
            if(_a==0) continue;
            _coverage++;
            _left=min(_left,_x);_right=max(_right,_x);_top=min(_top,_y);_bottom=max(_bottom,_y);
            var _red=buffer_peek(_buffer,_offset,buffer_u8),_green=buffer_peek(_buffer,_offset+1,buffer_u8),
                _blue=buffer_peek(_buffer,_offset+2,buffer_u8);
            if(_red+_green+_blue>48) _ink++;
            _palette[$ string(_red)+","+string(_green)+","+string(_blue)]=true;
        }
        _success=true;
        return {surface:_surface,pixels:_buffer,width:_width,height:_height,coverage:_coverage,ink:_ink,
            colours:array_length(variable_struct_get_names(_palette)),left:_left,right:_right,top:_top,bottom:_bottom};
    } finally {
        if(_target) surface_reset_target();
        if(_camera>=0) camera_destroy(_camera);
        gpu_pop_state();
        if(_shader<0) shader_reset();else shader_set(_shader);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);
        draw_set_color(_colour);draw_set_alpha(_alpha);
        if(!_success) {
            if(surface_exists(_surface)) surface_free(_surface);
            if(buffer_exists(_buffer)) buffer_delete(_buffer);
        }
    }
}

function scrFRVisualFree(_capture) {
    if(!is_struct(_capture)) return;
    if(surface_exists(_capture.surface)) surface_free(_capture.surface);
    if(buffer_exists(_capture.pixels)) buffer_delete(_capture.pixels);
}

function scrFRVisualSamePixels(_actual,_expected) {
    if(_actual.width!=_expected.width || _actual.height!=_expected.height) return false;
    for(var _offset=0;_offset<_actual.width*_actual.height*4;_offset+=4)
        if(buffer_peek(_actual.pixels,_offset,buffer_u32)!=buffer_peek(_expected.pixels,_offset,buffer_u32)) return false;
    return true;
}

function scrFRVisualSave(_capture,_name) {surface_save(_capture.surface,working_directory+_name);}

function scrFRVisualTestsStart(_driver) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled())
        throw "Frontier GPU visual tests require the isolated desktop harness";
    assert(scrFREnabled() && instance_exists(Player),"Frontier visual fixture requires initialized source modules and a live room");
    assert(!instance_exists(scrFRUnlockTestsController()),"Frontier visual fixture requires an empty source unlock queue");
    _driver.fr_visual_tests_done=false;
    var _captures=[],_controller=noone,_actor=noone;
    var _old_x=view_xview,_old_y=view_yview;
    try {
        var _control=scrFRVisualCapture("control",32,32,0,0,[]);array_push(_captures,_control);
        var _points=[[8,8,c_red],[24,8,c_lime],[8,24,c_blue],[24,24,c_white]];
        for(var _i=0;_i<array_length(_points);++_i) {
            var _point=_points[_i],_pixel=surface_getpixel_ext(_control.surface,_point[0],_point[1]);
            scrFRVisualCheck("real GPU RGBA positive control quadrant "+string(_i),
                ((int64(_pixel)>>24)&255)==255 && color_get_red(_pixel)==color_get_red(_point[2])
                && color_get_green(_pixel)==color_get_green(_point[2])
                && color_get_blue(_pixel)==color_get_blue(_point[2]));
        }
        scrFRVisualCheck("readback buffer has the same visible positive control",_control.coverage==1024
            && _control.ink==1024 && _control.colours==4);
        var _empty=scrFRVisualCapture("empty",32,32,0,0,[]);array_push(_captures,_empty);
        scrFRVisualCheck("transparent negative control remains empty",_empty.coverage==0 && _empty.ink==0);
        scrFRVisualSave(_control,"frontier-visual-positive-control.png");

        // Use the numeric icon token emitted by the actual Bubbles source,
        // with no surrounding letters that could hide a missing sprite.
        var _lock=scrFRRaceCall("race_lock"),_token_at=string_pos("@1(",_lock),_icon=scrFRRaceVar("sprCoveIcon");
        scrFRVisualCheck("authored race lock supplies its packaged numeric inline sprite",
            _token_at>0 && sprite_exists(_icon));
        var _token=string_copy(_lock,_token_at,string_length(_lock)-_token_at+1);
        var _inline=scrFRVisualCapture("source-inline",96,96,0,0,[_token]);array_push(_captures,_inline);
        var _inline_reference=scrFRVisualCapture("native-inline",96,96,0,0,
            ["@1("+sprite_get_name(_icon)+":0)"]);array_push(_captures,_inline_reference);
        var _inline_empty=scrFRVisualCapture("source-inline",96,96,0,0,[""]);array_push(_captures,_inline_empty);
        scrFRVisualCheck("authored numeric inline sprite emits actual coloured GPU pixels",
            _inline.coverage>4 && _inline.ink>4 && _inline.colours>1);
        scrFRVisualCheck("inline sprite conversion retains frame, scale, angle, blend and alpha",
            _inline_reference.ink>4 && scrFRVisualSamePixels(_inline,_inline_reference));
        scrFRVisualCheck("inline sprite negative control remains empty",
            _inline_empty.coverage==0 && !scrFRVisualSamePixels(_inline,_inline_empty));
        scrFRVisualSave(_inline,"frontier-visual-source-inline-sprite.png");

        var _sprite=scr_weapon_get_sprite(FR_BUBBLES_CUTLASS),_x=30064,_y=31064;
        scrFRVisualCheck("Frontier source weapon resolves imported sprite",sprite_exists(_sprite) && _sprite!=sprDefault);
        var _angle=33+15*(1-4/20),_sx=_x-lengthdir_x(4,_angle),_sy=_y-lengthdir_y(4,_angle);
        var _expected=scrFRVisualCapture("native-weapon",128,128,30000,31000,[_sprite,0,_sx,_sy,-1,_angle]);
        array_push(_captures,_expected);
        var _actual=scrFRVisualCapture("source-weapon",128,128,30000,31000,[_sprite,0,_x,_y,33,15,4,-1,c_white,1]);
        array_push(_captures,_actual);
        scrFRVisualCheck("authored draw_weapon emits visible multicolour source artwork",
            _actual.coverage>8 && _actual.ink>5 && _actual.colours>1
            && _actual.left>0 && _actual.top>0 && _actual.right<127 && _actual.bottom<127);
        scrFRVisualCheck("authored melee rotation, recoil and flipping match independent native reference",
            scrFRVisualSamePixels(_actual,_expected));
        scrFRVisualSave(_actual,"frontier-visual-source-weapon.png");

        var _body=scrFRRaceNativeSprite("Idle",0,-1);
        scrFRVisualCheck("Bubbles body resolves actual imported artwork",sprite_exists(_body) && _body!=sprMutant1Idle);
        _actor=instance_create(30064,31064,FRCustomObject);
        _actor.sprite_index=_body;_actor.image_index=0;_actor.image_xscale=-1;_actor.image_yscale=1;
        _actor.image_angle=0;_actor.image_alpha=1;_actor.image_blend=c_white;
        var _actor_expected=scrFRVisualCapture("native-actor",128,128,30000,31000,[_body,0,_actor.x,_actor.y,-1,1,0]);
        array_push(_captures,_actor_expected);
        var _actor_actual=scrFRVisualCapture("actor-event",128,128,30000,31000,[_actor]);array_push(_captures,_actor_actual);
        scrFRVisualCheck("real custom actor Draw emits Bubbles artwork",_actor_actual.coverage>20 && _actor_actual.ink>10
            && _actor_actual.colours>2 && scrFRVisualSamePixels(_actor_actual,_actor_expected));
        scrFRVisualSave(_actor_actual,"frontier-visual-custom-actor.png");

        scrFRModCallArray("mod","libSaves","unlock_popup",["FRONTIER VISUAL","SOURCE UI AND CAMERA"]);
        _controller=scrFRUnlockTestsController();
        assert(instance_exists(_controller),"Frontier visual popup constructor failed");
        _controller.splash_index=0;_controller.splash_image=sprite_get_number(_controller.splash_sprit)-1;
        _controller.splash_texty=0;_controller.splash_timer=150;
        var _ui=scrFRVisualCapture("source-unlock",view_width,view_height,view_xview,view_yview,[_controller]);
        array_push(_captures,_ui);
        scrFRVisualCheck("real authored source popup contains visible text and artwork",
            _ui.coverage>30 && _ui.ink>20 && _ui.colours>1
            && _ui.right>=view_width-8 && _ui.bottom>=view_height-8);
        view_xview+=192;view_yview-=96;
        var _panned=scrFRVisualCapture("source-unlock",view_width,view_height,view_xview,view_yview,[_controller]);
        array_push(_captures,_panned);
        scrFRVisualCheck("source nonsync camera UI remains pixel-identical after native camera pan",
            _panned.ink>20 && scrFRVisualSamePixels(_ui,_panned));
        scrFRVisualSave(_ui,"frontier-visual-source-ui.png");
        scrFRVisualSave(_panned,"frontier-visual-panned-ui.png");
    } finally {
        view_xview=_old_x;view_yview=_old_y;
        if(instance_exists(_controller)) instance_destroy(_controller);
        if(instance_exists(_actor)) instance_destroy(_actor);
        for(var _i=0;_i<array_length(_captures);++_i) scrFRVisualFree(_captures[_i]);
    }
    _driver.fr_visual_tests_done=true;
}

function scrFRVisualTestsStep(_driver) {return _driver.fr_visual_tests_done;}
