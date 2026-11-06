function scrNTTEFullManholeDestinationNativeTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_player=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _parked=scrNTTEFullInstances([PizzaEntrance,NTTEFullManhole,NTTEFullManholeOpen,Portal,Explosion]),
        _pending=scrNTTEFullValue(GameCont,"ntte_full_pending_destination",undefined),_oldStop=lockstep_stop
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        for(var _loop=0;_loop<=1;++_loop) {
            // The first case follows the actual native PizzaEntrance replacement.
            // The remaining cases verify explicit destination metadata survives.
            var _targets=[[203,0,1],[203,2,2],[205,1,1]]
            for(var _case=0;_case<array_length(_targets);++_case) {
                var _before=scrNTTEFullInstances(all),_target=_targets[_case]
                GameCont.area=area_sewers;GameCont.subarea=1;GameCont.loops=_loop
                GameCont.gocrib=false;GameCont.can_advance_stage=true;GameCont.win=false
                GameCont.ntte_full_pending_destination=undefined
                lockstep_stop=false
                instance_create(142000+_case*128,142000+_loop*128,Floor)
                var _entrance=instance_create(142000+_case*128,142000+_loop*128,PizzaEntrance),
                    _x=(_entrance.bbox_left+_entrance.bbox_right)/2,
                    _y=(_entrance.bbox_top+_entrance.bbox_bottom)/2
                assert(scrNTTEFullManholeLevelStart()==1 && !instance_exists(_entrance),
                    "Actual native PizzaEntrance was not replaced by the source Manhole")
                var _hole=instance_nearest(_x,_y,NTTEFullManhole)
                assert(instance_exists(_hole) && _hole.area==203 && _hole.subarea==0 && !_hole.contact,
                    "Source regular Manhole creation changed its authored Pizza0/contact metadata")
                _hole.area=_target[0];_hole.subarea=_target[1]
                var _explosion=instance_create(_hole.x,_hole.y,Explosion),_initial=_hole.image_index
                // Native mskExplosion has separate precise masks: frame0 is
                // transparent and frame1 is the actual collision window. The
                // fixture dispatches Step directly, so enter that real frame.
                _explosion.image_index=1
                with(_hole) assert(place_meeting(x,y,_explosion),
                    "Real native Explosion active animation mask did not overlap its Manhole")
                if(_case==0) {
                    var _boss=instance_create(_x+320,_y+320,BanditBoss)
                    assert(scrEnemyIsBoss(_boss) && !variable_instance_exists(_boss,"boss"),
                        "Actual native BigBandit no longer exercises source-flag-free native boss ancestry")
                    with(_hole) event_perform(ev_step,ev_step_normal)
                    assert(instance_exists(_hole) && _hole.image_index==_initial
                        && is_undefined(GameCont.ntte_full_pending_destination),
                        "Actual exploding Manhole opened while a genuine boss was alive")
                    instance_destroy(_boss,false)
                }
                var _steps=ceil((_hole.image_number+2)/timescale)
                repeat(_steps) if(instance_exists(_hole)) with(_hole) event_perform(ev_step,ev_step_normal)
                if(instance_exists(_hole) || !instance_exists(NTTEFullManholeOpen) || !instance_exists(Portal)) {
                    var _diag="MANHOLE DIAG loop="+string(_loop)+" case="+string(_case)
                        +" hole="+string(instance_exists(_hole))+" explosion="+string(instance_exists(_explosion))
                        +" open="+string(instance_number(NTTEFullManholeOpen))+" portals="+string(instance_number(Portal))
                        +" lockstep_stop="+string(lockstep_stop)+" steps="+string(_steps)
                    if(instance_exists(_hole)) with(_hole) _diag+=" image="+string(image_index)+"/"+string(image_number)
                        +" visible="+string(visible)+" overlap="+string(place_meeting(x,y,Explosion))
                        +" mask="+string(mask_index)+" xy="+string(x)+","+string(y)
                    with(enemy) if(variable_instance_exists(id,"boss") ? boss:scrEnemyIsBoss(id))
                        _diag+=" blocker="+object_get_name(object_index)+"#"+string(id)
                    scrNTTESmokeLog(_diag)
                }
                assert(!instance_exists(_hole) && instance_exists(NTTEFullManholeOpen) && instance_exists(Portal),
                    "Actual Explosion/Manhole Step and Destroy did not produce the native entrance portal")
                var _destination=GameCont.ntte_full_pending_destination
                assert(is_struct(_destination) && _destination.area==_target[0]
                    && _destination.subarea==_target[2] && _destination.loops==_loop
                    && GameCont.area==area_sewers && GameCont.subarea==1 && GameCont.killenemies,
                    "Manhole did not queue final Pizza1 or altered explicit target/loop/active old world")
                var _hard=GameCont.hard,_waypoints=GameCont.waypoints
                with(GameCont) event_perform(ev_other,ev_room_end)
                assert(GameCont.area==_target[0] && GameCont.subarea==_target[2] && GameCont.loops==_loop
                    && is_undefined(GameCont.ntte_full_pending_destination),
                    "Actual native RoomEnd committed Pizza0, advanced explicit target twice, or failed to consume pending")
                assert(GameCont.waypoints==_waypoints+1 && GameCont.waypnt[_waypoints]==_target[0]
                    && GameCont.waysub[_waypoints]==_target[2] && GameCont.waylps[_waypoints]==_loop
                    && GameCont.hard==_hard+(scrGameIsHardmode()?2:1),
                    "Manhole destination bypassed native stage difficulty/waypoint bookkeeping")
                scrNTTEFullMergedRuntimeTestCleanup(_before)
            }
        }
    }
    finally {
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_player);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus)
        scrNTTEFullVanillaFixtureEnd(_state)
        GameCont.ntte_full_pending_destination=_pending
        lockstep_stop=_oldStop
    }
    scrNTTESmokeLog("SOURCE MANHOLE DESTINATION: actual PizzaEntrance conversion/Explosion opening/boss gate/Destroy pending/native RoomEnd, Pizza0-to-final1 only, explicit Pizza2 and Trench1 preserved atloops0/1 OK @"+string(30/timescale))
}
