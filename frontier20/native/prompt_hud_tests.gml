// Real libGeneral selection + callback and actual native mobile HUD rendering.
// Supply the same KeyCont edge that ButtonAct.Other10 writes, never prompt.pick.
function scrFRPromptHUDTestsPick(_index,_owner,_prompt) {
    assert(real(id)==real(_owner) && creator==noone,"LibPrompt on_pick lost its owner's scope");
    fr_prompt_test_calls++;
    fr_prompt_test_index=_index;fr_prompt_test_prompt=_prompt;
}

// Exercise the actual InputHandling struct and shared arrays, including source
// weapon, ability, teleporter, unlock-notice and touch-confirmation consumers.
function scrFRButtonInputTests() {
    assert(is_struct(KeyCont),"Frontier input fixture requires the actual native KeyCont struct");
    var _keys={nodes:[]},_index=global.index,_cases=0,
        _actions=["fire","spec","pick","swap","paus","horn","west","east","nort","sout"],
        _prefixes=["press","hold","release"],
        _checks=[scrFRButtonPressed,scrFRButtonCheck,scrFRButtonReleased];
    scrNTTEFullAreaSnapshotContainer(KeyCont,_keys);
    try {
        for(var _a=0;_a<array_length(_actions);++_a) for(var _p=0;_p<array_length(_prefixes);++_p) {
            var _field=_prefixes[_p]+"_"+_actions[_a],_values=variable_struct_get(KeyCont,_field);
            for(var _slot=0;_slot<array_length(_values);++_slot) _values[_slot]=false;
        }
        for(var _a=0;_a<array_length(_actions);++_a) for(var _p=0;_p<array_length(_prefixes);++_p) {
            var _field=_prefixes[_p]+"_"+_actions[_a],_values=variable_struct_get(KeyCont,_field),_check=_checks[_p];
            for(var _slot=0;_slot<array_length(_values);++_slot) {
                assert(!_check(_slot,_actions[_a]),"Frontier native input read an unset "+_field);
                _values[_slot]=true;
                assert(_check(_slot,_actions[_a]),"Frontier native input lost actual sampled "+_field);
                for(var _other=0;_other<array_length(_values);++_other)
                    if(_other!=_slot) assert(!_check(_other,_actions[_a]),"Frontier input leaked across player slots");
                for(var _other=0;_other<array_length(_prefixes);++_other)
                    if(_other!=_p) assert(!_checks[_other](_slot,_actions[_a]),"Frontier input mixed press, hold or release samples");
                _values[_slot]=false;
                assert(!_check(_slot,_actions[_a]),"Frontier input retained a consumed or released sample");
                _cases++;
            }
        }
        for(var _slot=0;_slot<array_length(KeyCont.touch);++_slot) {
            global.index=_slot;KeyCont.touch[_slot]=true;
            for(var _p=0;_p<array_length(_prefixes);++_p) {
                var _values=variable_struct_get(KeyCont,_prefixes[_p]+"_pick"),_check=_checks[_p];
                assert(!_check(_slot,"okay"),"Frontier touch confirmation ignored its native sampled edge");
                _values[_slot]=true;
                assert(_check(_slot,"okay"),"Frontier touch confirmation lost its native pickup sample");
                global.index=(_slot+1) mod array_length(KeyCont.touch);
                assert(!_check(_slot,"okay"),"Frontier touch confirmation accepted another local player's input");
                global.index=_slot;_values[_slot]=false;_cases++;
            }
        }
        for(var _p=0;_p<array_length(_prefixes);++_p) {
            var _check=_checks[_p];
            assert(!_check(-1,"pick") && !_check(4,"pick") && !_check(0.5,"pick")
                && !_check(-1,"okay") && !_check(4,"okay") && !_check(0,"missing_action"),
                "Frontier input accepted invalid slots or undefined native actions");
        }
        scrNTTESmokeLog("PASS FRONTIER native KeyCont struct input: "+string(_cases)
            +" real press/hold/release slot samples, touch confirmation, edge clearing and isolation");
    } finally {
        global.index=_index;
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_keys.nodes});
    }
}

function scrFRPromptHUDTests() {
    scrFRButtonInputTests();
    scrFRMeteorScorpCompatTests();
    scrFRToolKitChestTests();
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_keys={nodes:[]},
        _parked=scrFRMatching(FRCustomObject,"name","LibPrompt"),
        _buttons=scrNTTEFullInstances(ButtonAct),_draw=scrNTTEFullCoastDrawState(),
        _font=draw_get_font(),_ha=draw_get_halign(),_va=draw_get_valign(),_shader=shader_current(),
        _viewx=view_xview,_viewy=view_yview,_surface=-1,_reference=-1,_camera=-1,_target=false;
    scrNTTEFullAreaSnapshotContainer(KeyCont,_keys);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    for(var _i=0;_i<array_length(_buttons);++_i) instance_deactivate_object(_buttons[_i]);
    gpu_push_state();
    try {
        _p.x=190000;_p.y=190000;_p.visible=true;_p.can_pick=true;_p.nearwep=noone;
        KeyCont.touch[_p.index]=true;KeyCont.press_pick[_p.index]=false;
        var _owner=instance_create(_p.x,_p.y,FRCustomObject);
        _owner.fr_prompt_test_calls=0;_owner.creator=noone;
        _owner.on_pick=["mod","libGeneral",scrFRPromptHUDTestsPick];
        var _prompt=scrFRModCallArray("mod","libGeneral","obj_create",[_p.x,_p.y,"LibPrompt"]);
        assert(instance_exists(_prompt) && _prompt.name=="LibPrompt","Source LibPrompt failed to construct");
        _prompt.creator=_owner;_prompt.mytext="FRONTIER ACTION";_prompt.xoff=5;_prompt.yoff=-3;_prompt.depth=-100;
        scrFRModCallArray("mod","libGeneral","late_step",[]);
        assert(instance_exists(_p.nearwep) && _prompt.nearwep==_p.nearwep,
            "Authored source selector did not supply its real nearwep proxy");
        assert(_p.nearwep.mask_index==mskNone && _p.nearwep.sprite_index==mskNone,
            "Source prompt proxy gained gameplay collisions or visible mask artwork");
        assert(_p.nearwep.object_index==FRCustomObject && _p.nearwep.fr_prompt_proxy
            && !instance_is(_p.nearwep,hitme) && !instance_is(_p.nearwep,IceFlower),
            "LibPrompt still invoked the native IceFlower physics/sound constructor");
        assert(scrFRPromptHUDSelected(_p)==_prompt,"Native mobile HUD did not expose the source-selected prompt");
        assert(_prompt.pick==-1 && _owner.fr_prompt_test_calls==0,
            "Merely displaying the source prompt dispatched an action");

        var _button=instance_create(160,96,ButtonAct);
        _button.x=160;_button.y=96;_button.rad=25;_button.alpha=0;_button.active=false;
        view_xview=_p.x-32;view_yview=_p.y-140;
        _surface=surface_create(320,192);_reference=surface_create(320,192);
        _camera=camera_create_view(0,0,320,192,0,noone,-1,-1,-1,-1);
        assert(surface_exists(_surface) && surface_exists(_reference),"Frontier touch prompt render targets unavailable");
        surface_set_target(_surface);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());shader_reset();gpu_set_blendmode(bm_normal);
        gpu_set_texfilter(false);gpu_set_fog(false,0,0,0);draw_clear_alpha(c_black,1);
        draw_set_color(c_white);draw_set_alpha(1);
        scrDrawInteractionHUD(_p);
        surface_reset_target();_target=false;
        assert(_button.active && _button.alpha>0,"Real native ButtonAct did not become usable for LibPrompt");
        surface_save(_surface,working_directory+"frontier-touch-source-prompt.png");
        surface_set_target(_reference);_target=true;camera_apply(_camera);
        matrix_set(matrix_world,matrix_build_identity());draw_clear_alpha(c_black,1);
        draw_sprite_ext(sprMobilePickup,0,
            160+(sprite_get_xoffset(sprMobilePickup)-sprite_get_width(sprMobilePickup)/2)*2,
            96+(sprite_get_yoffset(sprMobilePickup)-sprite_get_height(sprMobilePickup)/2)*2,
            2,2,0,c_white,1);
        surface_reset_target();_target=false;
        var _ink=0;
        for(var _y=72;_y<120;++_y) for(var _x=136;_x<184;++_x) {
            var _expected=surface_getpixel(_reference,_x,_y),_actual=surface_getpixel(_surface,_x,_y);
            assert(_expected==_actual,"Frontier actual touch icon differs from native pickup artwork");
            if(_expected!=c_black) _ink++;
        }
        assert(_ink>8 && surface_getpixel(_surface,202,96)==c_black,
            "Frontier touch HUD is empty or shows the source collision-mask disk");

        var _weapon=scrWeaponPickupCreate(_p.x,_p.y,wep_revolver);
        _weapon.speed=0;_weapon.visible=true;_weapon.autopick=false;_weapon.depth=0;
        assert(real(scrNTTEFullPromptWinner(_p))==real(_prompt),
            "High-priority source prompt did not block the real native weapon pickup path");
        with(_prompt) event_perform(ev_step,ev_step_begin);
        _prompt.depth=100;
        scrFRModCallArray("mod","libGeneral","late_step",[]);
        assert(real(_p.nearwep)==real(_weapon) && !instance_exists(scrFRPromptHUDSelected(_p)),
            "Authored source prompt ignored a higher-priority native weapon");
        var _native=scrNTTEFullPromptCreate(_owner,"NATIVE ACTION",mskWepPickup);
        _native.depth=-200;_prompt.depth=-100;
        scrFRModCallArray("mod","libGeneral","late_step",[]);
        assert(real(_p.nearwep)==real(_native) && !instance_exists(scrFRPromptHUDSelected(_p)),
            "Authored source prompt ignored a higher-priority native NTTE prompt");
        _native.visible=false;_weapon.visible=false;

        KeyCont.press_pick[_p.index]=true;
        with(_prompt) event_perform(ev_step,ev_step_begin);
        scrFRModCallArray("mod","libGeneral","late_step",[]);
        assert(_prompt.pick==_p.index && _owner.fr_prompt_test_calls==1
            && _owner.fr_prompt_test_index==_p.index && _owner.fr_prompt_test_prompt==_prompt,
            "Native pickup input did not dispatch the real authored source callback exactly once");
        KeyCont.press_pick[_p.index]=false;
        with(_prompt) event_perform(ev_step,ev_step_begin);
        scrFRModCallArray("mod","libGeneral","late_step",[]);
        assert(_prompt.pick==-1 && _owner.fr_prompt_test_calls==1,
            "Source prompt callback repeated without a new native pickup edge");
        _owner.visible=false;
        assert(!instance_exists(scrFRPromptHUDSelected(_p)),"Hidden source owner retained a touch prompt");
        _owner.visible=true;_prompt.visible=false;
        assert(!instance_exists(scrFRPromptHUDSelected(_p)),"Hidden source prompt retained a touch action");
        _prompt.visible=true;
        scrFRPromptLifecycleTests(_owner,_prompt,_p);
        scrNTTESmokeLog("PASS FRONTIER mobile prompt: source selection, shared native weapon/prompt priority, mask-free real ButtonAct, exact pickup pixels="
            +string(_ink)+", native input edge dispatch once, visibility and no repeat");
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);
        if(surface_exists(_reference)) surface_free(_reference);
        if(_camera!=-1) camera_destroy(_camera);
        gpu_pop_state();
        matrix_set(matrix_world,_draw.world);matrix_set(matrix_view,_draw.view);matrix_set(matrix_projection,_draw.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();
        draw_set_font(_font);draw_set_halign(_ha);draw_set_valign(_va);draw_set_color(_draw.color);draw_set_alpha(_draw.alpha);
        view_xview=_viewx;view_yview=_viewy;
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        for(var _i=0;_i<array_length(_buttons);++_i) instance_activate_object(_buttons[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_keys.nodes});
    }
}

function scrFRPromptLifecycleTests(_owner,_prompt,_p) {
    var _frame=current_frame,_scale=timescale,_tick=FRWorld.logic_tick,
        _serial=FRWorld.logic_serial,_pending=scrNTTEFullValue(FRWorld,"fr_prompt_pending_picks",[]),
        _calls=_owner.fr_prompt_test_calls,_oldpick=KeyCont.press_pick[_p.index];
    try {
        for(var _mode=0;_mode<2;++_mode) {
            var _rate=_mode==0?30:60,_count=0;
            global.time_scale=30/_rate;
            FRWorld.fr_prompt_pending_picks=array_create(array_length(KeyCont.press_pick),false);
            _owner.fr_prompt_test_calls=0;_prompt.pick=-1;
            for(var _render=0;_render<12;++_render) {
                current_frame=_frame+_render*timescale;
                var _ready=_rate==30 || (_render mod 2)==0;
                FRWorld.logic_tick=_ready;
                if(_ready) {
                    FRWorld.logic_serial++;
                    with(_prompt) event_perform(ev_step,ev_step_begin);
                }
                // The display must survive both the source proxy's explicit
                // deletion and the intervening nonlogic render frame.
                assert(scrFRPromptHUDSelected(_p)==_prompt,
                    "Frontier prompt flickered during normal30/60Hz lifetime");
                KeyCont.press_pick[_p.index]=(_render==1);
                scrFRPromptCapturePick(_p.index);
                if(_ready) scrFRModCallArray("mod","libGeneral","late_step",[]);
                // Simulate the next native frame releasing/overwriting a tap
                // that landed on a60Hz nonlogic frame before its source tick.
                KeyCont.press_pick[_p.index]=false;
                if(_ready) with(_prompt) event_perform(ev_step,ev_step_end);
                assert(scrFRPromptHUDSelected(_p)==_prompt,
                    "Frontier prompt unavailable after source/render phase");
                if(_ready) _count++;
            }
            assert(_count==(_rate==30?12:6) && _owner.fr_prompt_test_calls==1,
                "Frontier30/60Hz touch edge was lost or dispatched repeatedly");
            assert(!FRWorld.fr_prompt_pending_picks[_p.index],
                "Frontier consumed touch edge remained queued");
        }
        scrNTTESmokeLog("PASS FRONTIER continuous30/60Hz prompt lifetime, proxy-free HUD and nonlogic touch edge exactly once");
    } finally {
        current_frame=_frame;global.time_scale=_scale;FRWorld.logic_tick=_tick;FRWorld.logic_serial=_serial;
        FRWorld.fr_prompt_pending_picks=_pending;KeyCont.press_pick[_p.index]=_oldpick;
        _owner.fr_prompt_test_calls=_calls;
    }
}
