// Run the real Undergrowth constructor and UGEnemy Step/End Step events.
// No replacement follower implementation or fabricated callback is installed.
function scrFRMillipedeTestsClose(_actual,_expected) {
    // Keep the 1e-6 error bound at unit scale. The native GML comparison
    // epsilon can reject zero when the strict bound itself is smaller.
    return abs(_actual-_expected)*1000000<1;
}

function scrFRMillipedeTestsPrepare(_chain,_x,_y) {
    for(var _i=0;_i<array_length(_chain);++_i) with(_chain[_i]) {
        x=_x-80*_i;y=_y;xprevious=x;yprevious=y;
        speed=0;direction=0;custom_spd=0;custom_dir=0;
        gunangle=0;walk=false;active=true;wave=0;alarm1=-1;
    }
}

function scrFRMillipedeTestsAtRate(_rate) {
    var _actual_rate=game_get_speed(gamespeed_fps),_actual_scale=timescale;
    scrNTTESmokeLog("NTTE MILLIPEDE NATIVE RATE "+json_stringify({requested:_rate,
        actual:_actual_rate,option:UberCont.opt_framerate,saved:save_get_option("options","framerate",60),
        scale:_actual_scale,expected_scale:30/_rate,epsilon:math_get_epsilon(),
        legacy_zero_accepted:abs(0.0)<0.000001,
        scaled_zero_accepted:scrFRMillipedeTestsClose(0.0,0.0),
        scaled_two_micro_units_rejected:!scrFRMillipedeTestsClose(0.000002,0.0)}));
    assert(scrFRMillipedeTestsClose(0.0,0.0) && !scrFRMillipedeTestsClose(0.000002,0.0),
        "Millipede 1e-6 precision positive/negative controls failed");
    assert(_actual_rate==_rate && UberCont.opt_framerate==_rate
        && scrFRMillipedeTestsClose(_actual_scale,30/_rate),
        "Millipede lifecycle fixture did not reach its actual native30/60Hz rate");
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),
        _kills=GameCont.kills,_freeze=UberCont.opt_freeze;
    try {
        UberCont.opt_freeze=0;
        var _x=740000,_y=740000,_chain=scrUGCreate(_x,_y,"Millipede"),_count=array_length(_chain);
        assert(_count>=13 && _chain[0].type=="head" && _chain[_count-1].type=="tail",
            "Millipede fixture did not use the actual authored linked constructor");
        scrFRMillipedeTestsPrepare(_chain,_x,_y);
        var _head=_chain[0];
        with(_head) event_perform(ev_step,ev_step_end);
        for(var _i=0;_i<_count;++_i) {
            var _part=_chain[_i];
            assert(instance_exists(_part) && scrFRMillipedeTestsClose(_part.x,_x-32*_i) && _part.y==_y
                && _part.wave==48*_i && _part.hp==60,
                "Millipede live-chain End Step altered authored32px spacing, wave or health");
            assert(_part.parent==(_i==0?noone:_chain[_i-1])
                && _part.child==(_i==_count-1?noone:_chain[_i+1]),
                "Millipede healthy parent/child identities were changed");
        }
        // A restored/detached follower can already have a noone parent when
        // an older chain's head reaches it. Do not read noone.x or move it.
        var _detached=_chain[1];_detached.parent=noone;_detached.type="head";
        _detached.x=_x-120;_detached.xprevious=_detached.x;
        var _detached_x=_detached.x;
        with(_head) event_perform(ev_step,ev_step_end);
        assert(_detached.x==_detached_x && _detached.y==_y && _detached.hp==60
            && _head.x==_x && _head.parent==noone,
            "Millipede detached noone-parent follower moved, died or read an absent parent");
        var _retired_parent=scrUGCreate(_x+80,_y,"MillipedeSegment");
        _detached.parent=_retired_parent;_detached.type="body";_retired_parent.child=_detached;
        _retired_parent.hp=0;with(_retired_parent) event_perform(ev_step,ev_step_normal);
        with(_head) event_perform(ev_step,ev_step_end);
        assert(_detached.parent==_retired_parent && !instance_exists(_retired_parent)
            && _detached.x==_detached_x && _detached.y==_y && _detached.hp==60,
            "Millipede reachable follower read coordinates from an actually retired parent");
        with(_detached) event_perform(ev_step,ev_step_normal);
        assert(_detached.parent==noone && _detached.type=="head" && _detached.alarm1==20,
            "Millipede guarded retired parent bypassed the source's subsequent head promotion");
        with(_detached) event_perform(ev_step,ev_step_end);
        assert(scrFRMillipedeTestsClose(point_distance(_chain[2].x,_chain[2].y,_detached.x,_detached.y),32),
            "Millipede detached live head stopped updating its remaining valid children");
        scrNTTEFullMergedRuntimeTestCleanup(_before);

        // Actual ordinary Step destroys a middle link; successor and predecessor
        // must use the original promotion rules on their subsequent Step events.
        _chain=scrUGCreate(_x,_y,"Millipede");_count=array_length(_chain);
        scrFRMillipedeTestsPrepare(_chain,_x,_y);
        _head=_chain[0];var _dead=_chain[5],_previous=_chain[4],_next=_chain[6];
        _dead.hp=0;
        with(_dead) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_dead) && _previous.child==_dead && _next.parent==_dead,
            "Millipede real death did not retain the source's transient stale links");
        with(_head) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_head) && instance_exists(_next),
            "Millipede head traversal did not stop at a retired child");
        with(_next) event_perform(ev_step,ev_step_normal);
        assert(_next.parent==noone && _next.type=="head" && _next.alarm1==20 && _next.hp==60,
            "Millipede successor lost the original head-promotion callback");
        with(_next) event_perform(ev_step,ev_step_end);
        with(_previous) event_perform(ev_step,ev_step_normal);
        assert(_previous.child==noone && _previous.type=="tail" && _previous.hp==60,
            "Millipede predecessor lost the original tail-promotion callback");
        with(_head) event_perform(ev_step,ev_step_end);
        // Destroying the original head also promotes its real surviving child.
        _head.hp=0;with(_head) event_perform(ev_step,ev_step_normal);
        var _new_head=_chain[1];
        with(_new_head) event_perform(ev_step,ev_step_normal);
        assert(_new_head.parent==noone && _new_head.type=="head" && _new_head.hp==60,
            "Millipede head death did not preserve surviving-chain promotion");
        with(_new_head) event_perform(ev_step,ev_step_end);
        scrNTTEFullMergedRuntimeTestCleanup(_before);

        // A legal one-node/noone endpoint and a retired child endpoint must
        // not be interpreted as an instance or destroy the still-active head.
        var _single=scrUGCreate(_x,_y,"MillipedeSegment");
        with(_single) {type="head";scrUG_MillipedeSegment_setup();alarm1=-1;custom_spd=0;custom_dir=0;speed=0;}
        with(_single) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_single) && _single.parent==noone && _single.child==noone
            && _single.x==_x && _single.y==_y && _single.hp==60,
            "Millipede standalone head read noone or changed the legal empty endpoint");
        var _retired=scrUGCreate(_x-80,_y,"MillipedeSegment");
        _retired.hp=0;with(_retired) event_perform(ev_step,ev_step_normal);
        _single.child=_retired;
        with(_single) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_single) && _single.x==_x && _single.hp==60,
            "Millipede standalone traversal dereferenced a retired child endpoint");
        scrNTTEFullMergedRuntimeTestCleanup(_before);

        // Preserve the authored visibility decision: an inactive visible chain
        // stays, and the same chain retires only after its entire body is offscreen.
        _chain=scrUGCreate(view_xview+view_width/2,view_yview+view_height/2,"Millipede");
        _count=array_length(_chain);_head=_chain[0];
        for(var _i=0;_i<_count;++_i) _chain[_i].active=false;
        with(_head) event_perform(ev_step,ev_step_end);
        assert(instance_exists(_head) && _head.visible,
            "Millipede live-parent guard retired an inactive chain still visible on screen");
        scrFRMillipedeTestsPrepare(_chain,_x,_y);
        for(var _i=0;_i<_count;++_i) _chain[_i].active=false;
        with(_head) event_perform(ev_step,ev_step_end);
        for(var _i=0;_i<_count;++_i)
            assert(!instance_exists(_chain[_i]),"Millipede original complete-chain offscreen retirement stopped");
        scrNTTESmokeLog("PASS NTTE Undergrowth actual Millipede constructor,32px live follow, noone/stale parent and child, middle/head death, head/tail promotion, visible retention and full offscreen retirement @"+string(_rate));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        GameCont.kills=_kills;UberCont.opt_freeze=_freeze;random_set_seed(_seed);
    }
}

function scrFRMillipedeTestsStart(_driver) {
    _driver.fr_mill_original_option=save_get_option("options","framerate",60);
    _driver.fr_mill_original_rate=game_get_speed(gamespeed_fps);
    _driver.fr_mill_rate=30;
    save_set_value("options","framerate",30);scrOptionsUpdate();
}
function scrFRMillipedeTestsStep(_driver) {
    scrFRMillipedeTestsAtRate(_driver.fr_mill_rate);
    if(_driver.fr_mill_rate==30) {
        _driver.fr_mill_rate=60;
        save_set_value("options","framerate",60);scrOptionsUpdate();
        return false;
    }
    save_set_value("options","framerate",_driver.fr_mill_original_option);
    scrOptionsUpdate();game_set_speed(_driver.fr_mill_original_rate,gamespeed_fps);
    return true;
}
