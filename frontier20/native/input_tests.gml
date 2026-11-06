// Raw hardware fixtures enter through the real host JoystickMove event and
// original source libButton callback. They never assign a source press edge,
// teleport the player for the positive dash check, or invoke clickScr directly.
function scrFRInputTestsRaw(_x,_y,_held,_pressed,_released,_ready,_delta,_touch=0) {
    current_frame+=_delta;
    FRWorld.logic_tick=_ready;
    if(_ready) FRWorld.logic_serial++;
    var _samples=[];
    for(var _i=0;_i<5;++_i) array_push(_samples,{x:0,y:0,held:false,pressed:false,released:false});
    _samples[_touch]={x:_x,y:_y,held:_held,pressed:_pressed,released:_released};
    global.fr_touch_input_fixture={active:true,samples:_samples};
}

function scrFRInputTestsSourceDash(_player) {
    with(_player) scrFRModCallArray("skill","AugmentExtraFeet","step",[]);
}

function scrFRInputTouchTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Raw touch fixture requires explicit desktop smoke mode");
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0),_slot=global.index,
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _pickups=scrNTTEFullAreaGeneratorSnapshot(WepPickup),_pets=scrNTTEFullAreaGeneratorSnapshot(NTTEFullPet),
        _keys={nodes:[]},_keyboard=UberCont.opt_keyboard,_gamepad=UberCont.opt_gamepad,
        _frame=current_frame,_scale=timescale,_serial=FRWorld.logic_serial,_tick=FRWorld.logic_tick,
        _render=global.fr_render_context,_console=global.console_active,
        _saved_input=variable_global_exists("fr_touch_input")?global.fr_touch_input:undefined,
        _saved_fixture=variable_global_exists("fr_touch_input_fixture")?global.fr_touch_input_fixture:undefined,
        _skill=scrFRSkillResolve("AugmentExtraFeet"),_amount=scrFRGetSkill(_skill),
        _parked=scrNTTEFullInstances(MobileUI),_stick=noone,_checks=0;
    scrNTTEFullAreaSnapshotContainer(KeyCont,_keys);
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i]);
    try {
        assert(instance_exists(_p),"Touch input fixture requires the real native player");
        global.index=_p.index;KeyCont.touch[_p.index]=true;
        UberCont.opt_keyboard=false;UberCont.opt_gamepad=false;global.console_active=false;
        global.fr_render_context=false;
        _stick=instance_create(160,164,JoystickMove);
        _stick.x=160;_stick.y=164;_stick.rad=36;_stick.index=-1;
        scrFRSetSkill(_skill,1);
        for(var _hz=30;_hz<=60;_hz+=30) {
            var _delta=30/_hz;
            global.time_scale=_delta;current_frame=9000;global.fr_touch_input=undefined;
            _p.x=191000;_p.y=191000;_p.speed=0;_p.can_walk=true;
            _p.angle=23;scrFRVariableSet(_p,"sprite_angle",17);
            assert(_p.image_angle==17 && scrFRVariableGet(_p,"sprite_angle")==17
                && scrFRVariableExists(_p,"sprite_angle"),
                "Source sprite_angle did not resolve the native player draw rotation");
            with(_p) scrFRModCallArray("skill","AugmentExtraFeet","skill_take",[]);
            _stick.index=-1;_stick.current_move_direction_time=0;
            KeyCont.hold_east[_p.index]=false;KeyCont.hold_west[_p.index]=false;
            KeyCont.hold_nort[_p.index]=false;KeyCont.hold_sout[_p.index]=false;
            var _start=_p.x;
            scrFRInputTestsRaw(_stick.x+24,_stick.y,true,true,false,_hz==30,_delta);
            with(_stick) event_user(0);
            if(_hz==30) {
                assert(scrFRButtonPressed(_p.index,"east") && scrFRButtonCheck(_p.index,"east")
                    && !scrFRButtonReleased(_p.index,"east"),"Actual 30 Hz move stick lost its fresh direction edge");
                scrFRInputTestsSourceDash(_p);
            }
            // On 60 Hz a complete first tap can finish between source steps.
            // Its queued press and release must both survive to record it.
            scrFRInputTestsRaw(_stick.x+24,_stick.y,false,false,true,true,_delta);
            with(_stick) event_user(0);
            assert(scrFRButtonReleased(_p.index,"east") && !scrFRButtonCheck(_p.index,"east"),
                "Actual move-stick release retained a stale held direction");
            if(_hz==60) assert(scrFRButtonPressed(_p.index,"east"),
                "Intervening 60 Hz touch edge vanished before its source tick");
            scrFRInputTestsSourceDash(_p);
            assert(_p.x==_start,"A single touch movement press triggered a double-tap dash");
            scrFRInputTestsRaw(_stick.x+24,_stick.y,true,true,false,true,_delta);
            with(_stick) event_user(0);
            assert(scrFRButtonPressed(_p.index,"east") && scrFRButtonCheck(_p.index,"east"),
                "Actual held second press is unreachable to source dash");
            var _dash_before=scrNTTEFullInstances(all);
            scrFRInputTestsSourceDash(_p);
            assert(_p.x>_start+20 && _p.fr_dashaugment_cooldown>0 && _p.fr_dashaugment_angle==0,
                "Real Pocket Teleporter source double tap failed after actual "+string(_hz)+" Hz JoystickMove input");
            var _new_dash=scrNTTEFullMergedRuntimeNew(_dash_before),_blur=noone,
                _blur_step=global.fr_module_scripts[$ "skill:AugmentExtraFeet"][$ "blur_step"];
            for(var _i=0;_i<array_length(_new_dash);++_i) {
                var _actor=_new_dash[_i];
                if(instance_exists(_actor) && instance_is(_actor,FRCustomObject)
                    && scrNTTEFullValue(_actor,"on_step",undefined)==_blur_step) {_blur=_actor;break;}
            }
            assert(instance_exists(_blur) && _blur.image_angle==_p.angle+_p.image_angle
                && _blur.sprite_index==_p.sprite_index && _blur.image_index==_p.image_index,
                "Actual Pocket Teleporter afterimage did not copy native player sprite rotation and frame");
            var _landed=_p.x;
            scrFRInputTestsRaw(_stick.x+24,_stick.y,true,false,false,true,_delta);
            with(_stick) event_user(0);
            assert(!scrFRButtonPressed(_p.index,"east") && scrFRButtonCheck(_p.index,"east"),
                "A held stick direction repeated its touch press edge");
            scrFRInputTestsSourceDash(_p);
            assert(_p.x==_landed,"Holding the movement stick repeated a source teleport dash");
            // A direct right-to-left reversal must produce both boundaries.
            scrFRInputTestsRaw(_stick.x-24,_stick.y,true,false,false,true,_delta);
            with(_stick) event_user(0);
            assert(scrFRButtonPressed(_p.index,"west") && scrFRButtonReleased(_p.index,"east")
                && !scrFRButtonCheck(_p.index,"east") && scrFRButtonCheck(_p.index,"west"),
                "Real stick reversal lost a press or release boundary");
            _checks+=5;
        }
        // Make source pointer UI visible at one camera location while the real
        // player's ordinary weapon aim deliberately points somewhere else.
        global.fr_touch_input=undefined;global.time_scale=0.5;
        var _controller=scrFRModCallArray("area","cyberspace","BluescreenController_create",
            [view_xview+view_width/2,view_yview+view_height/2]);
        scrFRModCallArray("area","cyberspace","BluescreenButton_create",
            [view_xview+view_width/2-48,view_yview+view_height/2+28,_controller,
             scrFRModGet("area","cyberspace","sprBluescreenButtonYes"),true]);
        var _yes=noone;
        with(FRCustomObject) if(scrNTTEFullValue(id,"fr_bluescreenbutton",false)
            && scrNTTEFullValue(id,"yesButton",false) && creator==_controller) {_yes=id;break;}
        assert(instance_exists(_yes) && !is_undefined(_yes.on_step),"Actual source Yes button did not bind its libButton step");
        _p.race=Race.Robot;_p.bskin=0;
        KeyCont.dir_fire[_p.index]=180;KeyCont.dis_fire[_p.index]=200;
        var _aim=scrFRMousePoint(_p.index),
            _gui_x=(_yes.x-view_xview)*gui_w/view_width,
            _gui_y=(_yes.y-view_yview)*gui_h/view_height;
        scrFRInputTestsRaw(_gui_x,_gui_y,true,true,false,false,0.5,2);
        scrFRTouchPoll();
        scrFRInputTestsRaw(_gui_x,_gui_y,false,false,true,true,0.5,2);
        scrFRTouchPoll();
        assert(_aim[0]==scrFRMousePoint(_p.index)[0] && _aim[1]==scrFRMousePoint(_p.index)[1],
            "Menu touch adapter replaced ordinary weapon stick aiming");
        assert(scrFRModCallArray("mod","libMenu","menubutton_check",
            [_yes.x-32,_yes.y-32,64,64,0,0,(_p.index+1) mod INPUT_MAX_PLAYERS])==-1,
            "Authored mobile menu input leaked into another player slot");
        assert(scrFRModCallArray("mod","libMenu","menubutton_check",
            [_yes.x+200,_yes.y+200,32,32,0])==-1,"Screen tap activated a source menu outside its hit box");
        with(_yes) event_perform(ev_step,ev_step_normal);
        assert(_controller.drawConnect && GameCont.area==302 && GameCont.subarea==0 && _yes.done,
            "Actual finger tap did not reach source libButton step and original Cyberspace Yes callback");
        _checks+=4;
        scrNTTESmokeLog("PASS FRONTIER actual JoystickMove and source Pocket Teleporter 30/60Hz, release/reversal/hold edges, "
            +"queued multitouch libButton Yes to Cyberspace, local slot and untouched weapon aim: "+string(_checks));
    } finally {
        scrFRSetSkill(_skill,_amount);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i]);
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);
        scrNTTEFullAreaGeneratorRestore(_pickups);scrNTTEFullAreaGeneratorRestore(_pets);
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_keys.nodes});
        UberCont.opt_keyboard=_keyboard;UberCont.opt_gamepad=_gamepad;
        global.index=_slot;current_frame=_frame;global.time_scale=_scale;
        FRWorld.logic_serial=_serial;FRWorld.logic_tick=_tick;
        global.fr_render_context=_render;global.console_active=_console;
        global.fr_touch_input=_saved_input;global.fr_touch_input_fixture=_saved_fixture;
    }
}
