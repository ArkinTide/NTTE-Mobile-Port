// Dedicated explicit Windows acceptance. The first assertion witnesses the real
// cold UberCont.Create hook, before this fixture ever writes a readiness map.
function scrNTTEFullBonusColdClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullBonusColdRestore() {
    if(restored) return;
    restored=true
    lockstep_stop=false
    scrNTTEFullBonusColdClear()
    lockstep_stop=old_lock
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    UberCont.opt_autopause=old_autopause;UberCont.opt_framerate=old_framerate
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_full_progress=old_progress
    global.ntte_full_feature_ready=old_ready;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
}
function scrNTTEFullBonusColdTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Production readiness acceptance requires explicit Windows full smoke"
    scrNTTEFullBonusColdOnly()
    scrNTTESmokeLog("BONUS COLD actual cold UberCont.Create initialized the reviewed14 keys before desktop test map writes")
    var _object=asset_get_index("NTTEFullBonusScheduledColdTest")
    assert(object_exists(_object) && !instance_exists(_object),"Readiness observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        old_lock=lockstep_stop;rows=[];initial_rows=[];shells=[];arm=0
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=global.ntte_full_feature_ready;old_smoke=global.ntte_smoke_active
        old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_tutorial=save_get_value("game","tutorial",true)
        old_save_map=UberCont.saveData;fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate;old_game_speed=game_get_speed(gamespeed_fps)
        restored=false;scratch_files=[];rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0;diag_next=0
        scratch_root=working_directory+"bonus-scheduled-cold-"+string(get_timer())+"/";directory_create(scratch_root)
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullBonusColdClear()
    }
}
function scrNTTEFullBonusColdAwait(_next) {
    phase=_next;elapsed=0;draw_start=draw_frames;diag_next=0
    scrNTTESmokeLog("BONUS COLD native phase="+string(phase)+" fps="+string(rates[pass_index])
        +" map="+json_stringify(global.ntte_full_feature_ready)+" runtime="
        +json_stringify({draw_frames:draw_frames,visible:visible,active:instance_exists(id),
            runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,focus:window_has_focus(),
            autopause:UberCont.opt_autopause,paused:UberCont.paused,want_pause:UberCont.want_pause}))
}
function scrNTTEFullBonusColdMenu() {
    scrNTTEFullBonusColdClear()
    if(file_exists(savegame_file)) file_delete(savegame_file)
    UberCont.want_quit_to_menu=true
    instance_create(0,0,Vlambeer)
    scrNTTEFullBonusColdAwait(1)
}
function scrNTTEFullBonusColdStep() {
    try {scrNTTEFullBonusColdStepBody()}
    catch(_error) {scrNTTEFullBonusColdRestore();throw _error}
}

function scrNTTEFullBonusColdOnly() {
    var _keys=["skill:compassion","race:beetle","race:parrot","skin:angler fish","skin:bat eyes","skin:bonus robot","skin:coat venuz","skin:cool frog","skin:orchid plant","skin:red crystal","crown:crime","crown:red","bonus","crown:bonus"]
    assert(is_struct(global.ntte_full_feature_ready) && array_length(variable_struct_get_names(global.ntte_full_feature_ready))==14,"Cold release initializer lacks exact14 keys")
    for(var _i=0;_i<14;++_i) assert(scrNTTEFullFeatureReady(_keys[_i]),"Missing cold release key: "+_keys[_i])
    var _closed=["skill:annihilation","skill:bat ears","skill:lead ribs","skill:magnetic pulse","skill:reroll","skill:silver tongue","skill:toad breath","future:unknown"]
    for(var _i=0;_i<8;++_i) assert(!scrNTTEFullFeatureReady(_closed[_i]),"Hidden-source skill entered ordinary readiness")
}
function scrNTTEFullBonusColdRows(_initial=false) {
    var _types=[AmmoPickup,HPPickup,AmmoChest,HealthChest,Mimic,SuperMimic]
    var _targets=_initial?[AmmoPickup,HPPickup,NTTEFullBonusAmmoChest,NTTEFullBonusHealthChest,NTTEFullBonusAmmoMimic,NTTEFullBonusHealthMimic]:[NTTEFullBonusAmmoPickup,NTTEFullBonusAmmoPickup,NTTEFullBonusAmmoChest,NTTEFullBonusAmmoChest,NTTEFullBonusAmmoMimic,NTTEFullBonusAmmoMimic]
    var _rows=[]
    for(var _i=0;_i<6;++_i) {
        var _xx=16000+128*_i,_yy=_initial?17000:16000,_inst=noone,_attempt=0
        // Native Mimic constructors move upward12; Player.Alarm10 correctly
        // kills enemies off Floor. Give each controlled witness a real patch.
        for(var _fx=-1;_fx<=1;++_fx) for(var _fy=-1;_fy<=1;++_fy)
            instance_create(_xx+32*_fx,_yy+32*_fy,Floor)
        // Native AmmoChest may legitimately replace itself with a mystery box.
        // Select a stable source witness without changing its constructor.
        while(!instance_exists(_inst) && _attempt<64) {
            _inst=instance_create(_xx,_yy,_types[_i]);_attempt++
        }
        assert(instance_exists(_inst) && _inst.object_index==_types[_i],"Native source witness unavailable type="+string(_i))
        with(_inst) assert(place_meeting(x,y,Floor),"Controlled Bonus source lacks real native supporting Floor")
        if(_i>=4) scrNTTESmokeLog("BONUS witness born type="+string(_i)+" id="+string(_inst.id)+" hp="+string(_inst.hp)+" generator="+string(instance_exists(GenCont))+" area="+string(GameCont.area))
        array_push(_rows,{original:_inst.id,object:_types[_i],target:_targets[_i],xx:_inst.x,yy:_inst.y,replacement:noone})
    }
    return _rows
}
function scrNTTEFullBonusColdFind(_row) {
    var _matches=[]
    with(_row.target) if(xstart==_row.xx && ystart==_row.yy) array_push(_matches,id)
    return _matches
}
function scrNTTEFullBonusColdConverted(_rows,_initial=false) {
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _r=_rows[_i]
        if(_initial && _i<2) assert(instance_exists(_r.original) && _r.original.bonus_pickup_check==true,"Initial source pickup identity/mark changed")
        else {
            assert(!instance_exists(_r.original),"Scheduled Bonus did not dispose native original")
            var _found=scrNTTEFullBonusColdFind(_r)
            if(array_length(_found)!=1) {
                var _candidates=[]
                with(_r.target) array_push(_candidates,[id,x,y,xstart,ystart])
                scrNTTESmokeLog("BONUS replacement diagnostic row="+json_stringify(_r)+" candidates="+json_stringify(_candidates))
            }
            assert(array_length(_found)==1,"Scheduled source conversion count/type differs for "+string(_i))
            if(instance_exists(_r.replacement)) assert(_found[0]==_r.replacement,"One-shot source was replaced again")
            else _r.replacement=_found[0]
        }
    }
}
function scrNTTEFullBonusColdUnchanged(_rows,_mark=undefined) {
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _r=_rows[_i]
        assert(instance_exists(_r.original) && _r.original.object_index==_r.object,"Suppressed native source identity changed")
        var _actual=scrNTTEFullValue(_r.original,"bonus_pickup_check",undefined)
        assert(is_undefined(_mark)?is_undefined(_actual):(!is_undefined(_actual) && _actual==_mark),"Suppressed source marker changed")
        assert(array_length(scrNTTEFullBonusColdFind(_r))==0,"Suppressed source spawned Bonus duplicate")
    }
}
function scrNTTEFullBonusColdDisposeRows(_rows) {
    for(var _i=0;_i<array_length(_rows);++_i) {
        var _r=_rows[_i]
        if(instance_exists(_r.original)) instance_destroy(_r.original,false)
        var _ids=scrNTTEFullBonusColdFind(_r)
        for(var _j=0;_j<array_length(_ids);++_j) if(instance_exists(_ids[_j])) instance_destroy(_ids[_j],false)
    }
}
// Native event witnesses only; never call a Bonus conversion or dispatch Step.
function scrNTTEFullBonusColdProbe(_where) {
    if(!instance_exists(NTTEFullBonusScheduledColdTest)) return;
    var _o=instance_find(NTTEFullBonusScheduledColdTest,0)
    if(_where=="Mimic.Destroy") {
        try {throw "Bonus native mimic death diagnostic"} catch(_diag) {scrNTTESmokeLog("BONUS native mimic death hp="+string(hp)+" case="+string(_o.case_index)+" arm="+string(_o.arm)+" stack="+json_stringify(_diag))}
    }
    with(_o) {
        if(phase==3) {
            if(_where=="Gen.after") {
                assert(!initial_started && instance_exists(GenCont),"Cold GenCont witness duplicated or absent")
                initial_started=true;GameCont.crown=NTTEFullCrown.Bonus;gen_steps=0
            }
            else if(_where=="Gen.populated") {
                assert(!instance_exists(MenuGen) && array_length(initial_rows)==0,"Population source witness repeated")
                initial_rows=scrNTTEFullBonusColdRows(true)
            }
            else if(_where=="Step.after" && initial_started && !initial_done && instance_exists(GenCont) && array_length(initial_rows)>0) {
                for(var _i=0;_i<6;++_i) assert(instance_exists(initial_rows[_i].original)
                    && !variable_instance_exists(initial_rows[_i].original,"bonus_pickup_check"),"Generator source changed index="+string(_i)+" exists="+string(instance_exists(initial_rows[_i].original))+" marked="+string(scrNTTEFullValue(initial_rows[_i].original,"bonus_pickup_check",undefined)))
                gen_steps++
            }
            else if(_where=="Initial.before") {
                assert(initial_started && !initial_done && gen_steps>0,"Initial pipeline lacks real generator-suppressed normal Steps")
                for(var _i=0;_i<6;++_i) {
                    var _r=initial_rows[_i]
                    assert(instance_exists(_r.original),"Population witness disappeared before initial conversion")
                    _r.xx=_r.original.x;_r.yy=_r.original.y
                }
            }
            else if(_where=="Initial.after") {
                scrNTTEFullBonusColdConverted(initial_rows,true);initial_done=true
                scrNTTESmokeLog("BONUS COLD actual GenCont.Create->scheduled suppression->Destroy initial6: HP/Ammo identity retained, four source chest/mimic kinds preserved")
            }
        }
        if(phase==4 && arm!=0) {
            if(_where=="Step.entry") {
                native_entries++;native_game_id=GameCont.id
                for(var _i=0;_i<array_length(rows);++_i) if(instance_exists(rows[_i].original)) {
                    rows[_i].xx=rows[_i].original.x;rows[_i].yy=rows[_i].original.y
                }
            }
            else if(_where=="Step.after") {native_after++;assert(scrNTTEFullFeatureReady("bonus"),"Normal Step did not use ordinary bonus readiness")}
        }
    }
}
function scrNTTEFullBonusColdBegin() {
    if(phase!=4) return;
    assert(json_stringify(global.ntte_full_feature_ready)==default_bytes,"Default release map changed")
    if(arm==0) {
        GameCont.crown=case_index==0?Crown.None:NTTEFullCrown.Bonus
        rows=scrNTTEFullBonusColdRows(false);shells=[];native_game_id=noone
        if(case_index==1) for(var _i=0;_i<6;++_i) rows[_i].original.bonus_pickup_check=false
        if(case_index==2) for(var _i=0;_i<6;++_i) {
            var _r=rows[_i],_shell=instance_create(_r.original.xstart,_r.original.ystart,ChestOpen)
            _shell.sprite_index=sprHealthChestOpen;_shell.image_speed=0;array_push(shells,_shell.id)
        }
        if(case_index==3) lockstep_stop=true
        native_entries=0;native_after=0;arm=1
    }
    else if(arm==3) {
        if(case_index==0) GameCont.crown=NTTEFullCrown.Bonus
        if(case_index==2) for(var _i=0;_i<array_length(shells);++_i) if(instance_exists(shells[_i])) instance_destroy(shells[_i],false)
        if(case_index==3) lockstep_stop=false
        native_entries=0;native_after=0;arm=4
    }
    else if(arm==5) {native_entries=0;native_after=0;arm=6}
}
function scrNTTEFullBonusColdEnd() {
    if(phase!=4 || arm==0 || arm==3 || arm==5) return;
    assert(native_entries==1 && native_game_id==GameCont.id,"Real GameCont.Step did not dispatch once")
    assert(native_after==((case_index==3 && arm==1)?0:1),"Actual normal-Step lockstop/call boundary differs")
    if(arm==1) {
        scrNTTEFullBonusColdUnchanged(rows,case_index==1?false:(case_index==2?true:undefined))
        arm=3;return;
    }
    if(case_index==1 || case_index==2) scrNTTEFullBonusColdUnchanged(rows,case_index==1?false:true)
    else scrNTTEFullBonusColdConverted(rows,false)
    if(arm==4) {arm=5;return;}
    assert(arm==6,"Unexpected one-shot observation phase")
    scrNTTESmokeLog("PASS BONUS COLD SCHEDULED late6 case="+string(case_index)+" real normal Step/count/type/identity/one-shot @"+string(rates[pass_index]))
    scrNTTEFullBonusColdDisposeRows(rows);rows=[];arm=0;case_index++
    if(case_index>=4) {phase=5;draw_start=draw_frames}
}
function scrNTTEFullBonusColdStepBody() {
    elapsed+=timescale
    assert(elapsed<=2700,"Bonus cold scheduled acceptance timeout phase="+string(phase))
    if(instance_exists(Player)) with(Player) {hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false}
    if(phase==0) {
        scrNTTEFullBonusColdClear()
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=702643;global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0;save_set_value("game","tutorial",false)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        for(var _i=0;_i<4;++_i) array_push(scratch_files,game_directory+["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"][_i])
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        scrNTTEFullBonusColdOnly();default_bytes=json_stringify(global.ntte_full_feature_ready)
        initial_started=false;initial_done=false;initial_rows=[];rows=[];shells=[];arm=0;case_index=0
        phase=10;return;
    }
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index] && !UberCont.opt_autopause,"Actual Bonus cold rate/options changed")
    assert(json_stringify(global.ntte_full_feature_ready)==default_bytes,"Fixture/runtime replaced ordinary default")
    if(phase==10) {scrNTTEFullBonusColdMenu();return;}
    if(phase==1) {
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone;with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone;with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Bonus cold native Play missed menu")
        selector=noone;with(CharSelect) if(race==Race.Fish) other.selector=id
        assert(instance_exists(selector),"Bonus cold Fish selector absent")
        scrNTTEFullBonusColdAwait(2);return;
    }
    if(phase==2) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        assert(selector.can,"Production defaults broke base Fish")
        with(selector) event_perform(ev_mouse,ev_left_press)
        scrNTTEFullBonusColdAwait(3)
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        return;
    }
    if(phase==3) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker) || draw_frames-draw_start<8) return;
        assert(initial_started && initial_done && gen_steps>0 && instance_number(Floor)>20,"Real generated world missed initial/generator witnesses")
        scrNTTEFullBonusColdDisposeRows(initial_rows);initial_rows=[];phase=4;elapsed=0;return;
    }
    if(phase==5 && draw_frames-draw_start>=8) {
        scrNTTEFullBonusColdOnly()
        scrNTTESmokeLog("PASS BONUS SCHEDULED COLD ordinary initializer14/menu/Go/engine restart/actual asynchronous GenCont suppression+initial6/normal Step late6/no-crown/false-mark/open-shell/lockstop/one-shot; protected Player, no natural battle claim @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullBonusColdAwait(0);return;}
        scrNTTEFullBonusColdRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        instance_deactivate_object(UberCont);game_end()
    }
}
function scrNTTEFullBonusColdAbort(_error) {
    var _o=instance_find(NTTEFullBonusScheduledColdTest,0)
    if(instance_exists(_o)) with(_o) scrNTTEFullBonusColdRestore()
    throw _error
}

function scrNTTEFullBonusScheduledColdTests() {scrNTTEFullBonusColdTests()}
