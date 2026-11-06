// Dedicated explicit desktop cases. Real native room_restart/auto-continue
// cannot run under the synchronous smoke bootstrap (which hides Vlambeer).
function scrNTTEFullRaceNaturalMenuClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullRaceNaturalMenuRestore() {
    if(restored) return;
    restored=true
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
function scrNTTEFullRaceNaturalMenuStart(_race) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Race menu acceptance requires explicit Windows full smoke"
    var _object=asset_get_index("NTTEFullRaceNaturalMenuTest")
    assert(object_exists(_object) && !instance_exists(_object),"Race natural menu observer missing/duplicated")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        target_race=_race;race_key=scrNTTEFullRaceKey(_race)
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined
        old_smoke=global.ntte_smoke_active;old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        old_autopause=UberCont.opt_autopause;old_framerate=UberCont.opt_framerate
        old_game_speed=game_get_speed(gamespeed_fps)
        restored=false;scratch_files=[];rates=[30,60];pass_index=0;phase=0;elapsed=0;draw_frames=0
        scratch_root=working_directory+"race-natural-menu-"+race_key+"-"+string(get_timer())+"/"
        directory_create(scratch_root)
        // Native Vlambeer.Create must run after the real room restart. The
        // public CLI smoke predicate still isolates savegame_file to smoke-save.
        global.ntte_smoke_active=false
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullRaceNaturalMenuClear()
    }
}
function scrNTTEFullParrotNaturalMenuTests() {scrNTTEFullRaceNaturalMenuStart(NTTEFullRace.Parrot)}
function scrNTTEFullBeetleRewardNaturalMenuTests() {scrNTTEFullRaceNaturalMenuStart(NTTEFullRace.Beetle)}
function scrNTTEFullRaceNaturalMenuFeathers(_player) {
    var _sum=_player.feather_ammo+_player.feather_ammo_get,_owner=_player.id,_rows=[]
    // Starting/retrieving source feathers intentionally have index=-1 until
    // actually thrown; ownership is their creator, not the attack input slot.
    with(NTTEFullParrotFeather) {
        array_push(_rows,{id:id,creator:creator,target:target,index:index,stick:stick,x:x,y:y})
        if(creator==_owner) _sum++
    }
    scrNTTESmokeLog("RACE MENU FEATHER DIAGNOSTIC phase="+string(phase)+" "+json_stringify({
        owner:_owner,ammo:_player.feather_ammo,pending:_player.feather_ammo_get,total:_sum,rows:_rows}))
    return _sum
}
function scrNTTEFullRaceNaturalMenuPetInfo(_player) {
    var _slots=scrNTTEFullValue(_player,"ntte_pet",[]),_live=[],_rows=[]
    for(var _i=0;_i<array_length(_slots);++_i) {
        var _pet=_slots[_i]
        if(!instance_exists(_pet)) {array_push(_rows,{slot:_i,pet:"empty"});continue}
        array_push(_live,_pet)
        array_push(_rows,{slot:_i,id:_pet,pet:_pet.pet,leader:_pet.leader,visible:_pet.visible,
            persistent:_pet.persistent,stat_found:_pet.stat_found,mask:_pet.mask_index})
    }
    var _info={player:_player.id,race:_player.race,capacity:scrNTTEFullValue(_player,"ntte_pet_max",undefined),
        base:scrNTTEFullValue(GameCont,"ntte_pet_max",1),slots:array_length(_slots),live:_live,rows:_rows,
        started:scrNTTEFullValue(_player,"ntte_native_race_started",false),seed:global.seed,
        levseed:GameCont.levseed,frame:current_frame}
    scrNTTESmokeLog("RACE MENU PET DIAGNOSTIC phase="+string(phase)+" "+json_stringify(_info))
    return _info
}
function scrNTTEFullRaceNaturalMenuAwait(_next) {phase=_next;elapsed=0;draw_start=draw_frames}
function scrNTTEFullRaceNaturalMenuActualRate(_boundary) {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Race fixture lost copied options map or changed original save data: "+_boundary)
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause
        && fixture_save_map[? "options_framerate"]==rates[pass_index]
        && fixture_save_map[? "options_autopause"]==false,
        "Race native boundary replaced requested actual FPS/timescale/options: "+_boundary)
    scrNTTESmokeLog("RACE MENU ACTUAL RATE "+race_key+" "+_boundary+" "+json_stringify({
        requested_fps:rates[pass_index],runtime_fps:game_get_speed(gamespeed_fps),logic_scale:timescale,
        autopause:UberCont.opt_autopause,original_savedata_unchanged:true}))
}
function scrNTTEFullRaceNaturalMenuStepBody() {
    elapsed+=timescale
    assert(elapsed<=2700,"Natural race menu state timeout: "+race_key+" phase="+string(phase))
    if(instance_exists(Player)) with(Player) {
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        speed=0;can_walk=false;can_aim=false
    }
    if(phase==0) {
        scrNTTEFullRaceNaturalMenuClear()
        // RoomStart reloads saved options during the real native restart.
        // Only this isolated copy may supply the requested FPS/background mode.
        save_set_value("options","autopause",false)
        save_set_value("options","framerate",rates[pass_index])
        UberCont.opt_framerate=rates[pass_index];game_set_speed(rates[pass_index],gamespeed_fps)
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.opt_freeze=0;UberCont.opt_bossintro=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.want_quit_to_menu=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=0;global.seed=701932
        global.crownpick=crwn_none;global.recontinued_times=0
        scrGameCustomModeReset();scr_playerinstances_reset_all();my_player.race=Race.Fish;my_player.skin=0
        if(file_exists(savegame_file)) file_delete(savegame_file)
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        array_push(scratch_files,game_directory+"ntte-full-progress.json")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.bak")
        array_push(scratch_files,game_directory+"ntte-full-progress.json.tmp")
        array_push(scratch_files,game_directory+"NuclearThrone.sav")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_feature_ready={}
        variable_struct_set(global.ntte_full_feature_ready,"race:"+race_key,true)
        assert(!scrNTTEFullUnlockGet("race:"+race_key) && !scr_race_is_unlocked(target_race),
            "Unowned custom race exposed before source acquisition")
        save_set_value("game","tutorial",false)
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont)
        scrCreatePlayers(0)
        if(target_race==NTTEFullRace.Parrot) {
            GameCont.area=scrNTTEFullAreaId("coast");GameCont.subarea=1;GameCont.loops=0;GameCont.hard=2
            GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
            global.ntte_full_sync_generation=false
            global.rng_state[@RNGStates.Generation]=701932
            var _gen=instance_create(0,0,GenCont)
            assert(!_gen.ntte_full_sync_generation,"Parrot unlock fixture bypassed actual Coast floor/alarms")
        }
        else {
            GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=1
            for(var _x=-3;_x<=3;++_x) for(var _y=-3;_y<=3;++_y) instance_create(10000+32*_x,10000+32*_y,Floor)
            with(Floor) mcr_floor_make_walls;
            // Only final reward half is claimed: actual inherited normal Step
            // contact, never direct helper-open or fabricated quest completion.
            reward_chest=instance_create(Player.x,Player.y,NTTEFullHugeQuestChest)
        }
        scrNTTEFullRaceNaturalMenuAwait(1);return;
    }
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        if(!scrNTTEFullUnlockGet("race:"+race_key)) return;
        if(target_race==NTTEFullRace.Parrot)
            assert(GameCont.ntte_full_active_coast && instance_number(Floor)>20,
                "Parrot unlock lacks actual completed native Coast map")
        else {
            assert(!instance_exists(reward_chest),"Beetle unlocked without actual ultimate chest consumption")
            var _found=false
            with(WepPickup) if(wep==wep_ntte_ultra_quasar_rifle) _found=true
            assert(_found,"Ultimate actual chest contact omitted Ultra Quasar reward")
        }
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet("race:"+race_key) && scr_race_is_unlocked(target_race),
            "Natural race acquisition lost actual persisted ownership before menu")
        scrNTTEFullRaceNaturalMenuActualRate("source completed")
        scrNTTESmokeLog("RACE MENU SOURCE "+race_key+": "+(target_race==18?"actual Coast GenCont/FloorMaker completion":"actual ultimate quest reward chest Step contact")+" + JSON reload OK")
        scrNTTEFullRaceNaturalMenuClear()
        if(file_exists(savegame_file)) file_delete(savegame_file)
        // Real native quit-to-menu entry state; no shared cleanup hook edited.
        UberCont.want_quit_to_menu=true
        instance_create(0,0,Vlambeer)
        scrNTTEFullRaceNaturalMenuAwait(2);return;
    }
    if(phase==2) {
        // Logo's native input completion creates MainMenuButton via Alarm1.
        // Trigger that actual completion event; no button properties fabricated.
        if(instance_exists(Logo)) with(Logo) event_perform(ev_alarm,1)
        var _button=noone
        with(MainMenuButton) if(image_index==0) _button=id
        if(!instance_exists(_button)) return;
        with(_button) event_user(0)
        var _play=noone
        with(PlayButton) if(floor(num)==0) _play=id
        if(instance_exists(_play)) with(_play) event_user(0)
        assert(instance_exists(Menu) && instance_exists(MenuGen),"Real main Play path did not construct native character menu")
        selector=noone
        with(CharSelect) if(race==other.target_race) other.selector=id
        assert(instance_exists(selector),"Naturally unlocked race missing from real native menu")
        scrNTTEFullRaceNaturalMenuActualRate("native menu constructed")
        scrNTTEFullRaceNaturalMenuAwait(3);return;
    }
    if(phase==3) {
        if(draw_frames-draw_start<3 || instance_exists(FloorMaker)) return;
        scrNTTEFullRaceNaturalMenuActualRate("native menu Draw before Go")
        assert(selector.can,"Real CharSelect Draw rejected naturally persisted unlocked role")
        with(selector) event_perform(ev_mouse,ev_left_press)
        assert(my_player.race==target_race && selector.selected && instance_exists(GoButton) && GoButton.visible,
            "Native CharSelect click failed actual slot/Go selection")
        var _runs=scrNTTEFullValue(global.ntte_full_progress.stats,"race:"+race_key+":runs",0)
        assert(_runs==0,"Role run counted before actual native Go")
        with(GoButton) event_perform(ev_mouse,ev_left_press)
        assert(instance_number(Player)==1 && Player.race==target_race,
            "Native Go/scrRunStart did not create actual selected role")
        initial_player=instance_find(Player,0)
        assert(initial_player.wep==(target_race==17?wep_ntte_beetle_blaster:wep_revolver),
            "Actual custom menu run selected wrong starter weapon")
        scrNTTEFullRaceNaturalMenuAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(Menu) || instance_exists(MenuGen) || instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullRaceNaturalMenuActualRate("actual room_restart world")
        assert(instance_exists(initial_player) && instance_number(Player)==1 && Player.race==target_race,
            "Actual native room restart lost/duplicated the custom Player")
        assert(instance_number(Floor)>20 && instance_exists(TopCont) && instance_exists(BackCont),
            "Actual custom-character new run lacks generated world and render chain")
        assert(Player.ntte_native_race_started && Player.ntte_native_race==target_race,
            "New-run real GenCont omitted custom character lifecycle start")
        if(target_race==NTTEFullRace.Parrot) {
            var _pet_info=scrNTTEFullRaceNaturalMenuPetInfo(Player)
            assert(_pet_info.capacity==_pet_info.base+1 && _pet_info.slots==_pet_info.capacity && array_length(_pet_info.live)==1,
                "Real menu Parrot run failed extra slot/exactly one starter pet")
            var _pet=_pet_info.live[0]
            assert(instance_exists(_pet) && _pet.leader==Player.id && _pet.persistent && !_pet.stat_found,
                "Actual Parrot game-start companion lost original leader/persistence/stat semantics")
            assert(_pet.pet=="Parrot" && _pet.visible && _pet.mask_index!=mskNone,
                "Actual Parrot game-start companion missed first native PetLevelStart reveal/mask restoration")
            assert(scrNTTEFullRaceNaturalMenuFeathers(Player)==12,"Actual menu Parrot start failed exact12 starting feather accounting")
            // Model a valid partially spent inventory, then prove native
            // continuation does not grant the12 starting feathers again.
            instance_destroy(NTTEFullParrotFeather,false)
            Player.feather_ammo=3;Player.feather_ammo_get=0
        }
        else {
            assert(is_struct(Player.beetle_menu_info) && Player.footkind==4,
                "Real menu Beetle run omitted merge menu/metal feet")
            Player.beetle_menu_info.selection_angle=123
        }
        assert(scrNTTEFullValue(global.ntte_full_progress.stats,"race:"+race_key+":runs",0)==1,
            "Native new run failed exactly one role run statistic")
        saved_player=Player.id
        scrSavegameSave()
        assert(file_exists(savegame_file),"Native new custom race run failed real continuation file write")
        scrNTTESmokeLog("RACE MENU START "+race_key+": actual MainMenu/Play/CharSelect Draw+Mouse/Go/scrRunStart/room_restart/normal GenCont + starter OK @"+string(rates[pass_index]))
        scrNTTEFullRaceNaturalMenuClear()
        UberCont.want_quit_to_menu=false
        instance_create(0,0,Vlambeer)
        scrNTTEFullRaceNaturalMenuAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        scrNTTEFullRaceNaturalMenuActualRate("actual binary continuation world")
        assert(instance_number(Player)==1 && Player.id!=saved_player && Player.race==target_race,
            "Actual Vlambeer native file continuation did not reconstruct selected custom role")
        assert(UberCont.continued_run && Player.ntte_native_race_started && instance_number(Floor)>20,
            "Native custom role continuation lost continued marker/source new-level world")
        if(target_race==NTTEFullRace.Parrot) {
            var _pet_info=scrNTTEFullRaceNaturalMenuPetInfo(Player)
            assert(scrNTTEFullRaceNaturalMenuFeathers(Player)==3 && array_length(_pet_info.live)==1
                && _pet_info.capacity==_pet_info.base+1 && _pet_info.slots==_pet_info.capacity,
                "Native real file continuation replayed Parrot start feathers/pet/extra slot")
            assert(instance_exists(_pet_info.live[0]) && _pet_info.live[0].leader==Player.id
                && _pet_info.live[0].pet=="Parrot" && _pet_info.live[0].visible,
                "Native real file continuation retained dead companion leader")
        }
        else assert(is_struct(Player.beetle_menu_info) && Player.beetle_menu_info.selection_angle==123,
            "Actual file continuation reset Beetle native radial menu")
        assert(scrNTTEFullValue(global.ntte_full_progress.stats,"race:"+race_key+":runs",0)==1,
            "Actual native continuation repaid role run count")
        scrNTTESmokeLog("PASS RACE NATURAL MENU "+race_key+": source acquisition/persisted unlock/native menu/new run/actual room restart/native binary continuation/recreated Player/once-only starters @"+string(rates[pass_index]))
        if(++pass_index<array_length(rates)) {scrNTTEFullRaceNaturalMenuAwait(0);return;}
        scrNTTEFullRaceNaturalMenuRestore()
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullRaceNaturalMenuStep() {
    try {scrNTTEFullRaceNaturalMenuStepBody()}
    catch(_error) {scrNTTEFullRaceNaturalMenuRestore();throw _error}
}
