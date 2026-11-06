// Two separate process cases share only explicit fixture files. The read case
// uses the genuine preview/full native loader and a newly constructed Player;
// in-memory codec success alone is not accepted as continuation evidence.
function scrFRContinueTestEqual(_left,_right) {
    if(is_struct(_left) || is_struct(_right)) {
        if(!is_struct(_left) || !is_struct(_right)) return false;
        var _keys=variable_struct_get_names(_left);
        if(array_length(_keys)!=array_length(variable_struct_get_names(_right))) return false;
        for(var _i=0;_i<array_length(_keys);++_i)
            if(!variable_struct_exists(_right,_keys[_i]) || !scrFRContinueTestEqual(_left[$ _keys[_i]],_right[$ _keys[_i]])) return false;
        return true;
    }
    if(is_array(_left) || is_array(_right)) {
        if(!is_array(_left) || !is_array(_right) || array_length(_left)!=array_length(_right)) return false;
        for(var _i=0;_i<array_length(_left);++_i) if(!scrFRContinueTestEqual(_left[_i],_right[_i])) return false;
        return true;
    }
    if(is_undefined(_left) || is_undefined(_right)) return is_undefined(_left) && is_undefined(_right);
    return _left==_right;
}

function scrFRContinueTestPrepareRoom(_driver,_loading) {
    GameCont.ntte_full_pending_destination=undefined;
    GameCont.can_advance_stage=false;GameCont.is_level_ended=true;
    global.ntte_full_sync_generation=false;
    if(!_loading)
        global.fr_continue_events={game:GameCont.id,events:[["mod","Frontier_Events","DebugEvent1"]]};
    _driver.fr_cold_loading=_loading;_driver.fr_cold_phase=1;
    _driver.fr_cold_ticks=0;_driver.fr_cold_observed=0;
    _driver.fr_cold_generation_started=false;
    _driver.fr_cold_room_marker=instance_create(0,0,FRMarker);
    room_restart();
}

function scrFRContinueTestGenerate(_driver) {
    // A persistent Vlambeer does not run Create again at room_restart. Start
    // exactly one genuine async generator only after the old room is gone;
    // it must build the native terrain and TopCont itself.
    assert(!_driver.fr_cold_generation_started && !instance_exists(_driver.fr_cold_room_marker),
        "Cold fixture started generation twice or before actual room disposal");
    assert(!instance_exists(TopCont) && !instance_exists(GenCont) && instance_number(Floor)==0,
        "Cold fixture room disposal retained old terrain or generation controllers");
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
    if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
    var _gen=instance_create(0,0,GenCont);
    assert(instance_number(GenCont)==1 && instance_exists(_gen) && !_gen.ntte_full_sync_generation,
        "Cold checkpoint fixture replaced ordinary async generation with sync callbacks");
    _driver.fr_cold_generation_started=true;
    scrNTTESmokeLog("FRONTIER COLD real room disposal observed; async GenCont started");
}

function scrFRContinueTestAmmo(_record) {
    var _p=instance_find(Player,0),_ammo=_record.ammo_delta;
    assert(instance_exists(_p)
        && scrFRContinueTestEqual(_p.fr_ammo_max_delta,_ammo.maximum)
        && scrFRContinueTestEqual(_p.fr_ammo_gain_delta,_ammo.gain),
        "Native transition lost or duplicated source per-player ammo deltas");
    assert(array_length(_p.fr_ammo_max_delta)==Ammo.NUM_AMMO_TYPES
        && array_length(_p.fr_ammo_gain_delta)==Ammo.NUM_AMMO_TYPES,
        "Native ammo delta checkpoint has the wrong type count");
    for(var _type=1;_type<Ammo.NUM_AMMO_TYPES;++_type) {
        assert(scrFRAmmoRead(_p,"typ_amax",_type)==typ_amax[_type]+_ammo.maximum[_type]
            && scrFRAmmoRead(_p,"typ_ammo",_type)==typ_ammo[_type]+_ammo.gain[_type],
            "Loaded ammo bonuses did not use the live native baseline");
    }
    assert(_p.ammo[Ammo.Bullets]==_ammo.bullets,"Native transition changed checkpoint ammunition");
}

function scrFRContinueTestsStart(_driver,_mode) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Frontier cold continuation fixture requires the isolated desktop harness";
    assert(_mode=="write" || _mode=="read","Unknown cold continuation fixture mode");
    _driver.fr_cold_mode=_mode;_driver.persistent=true;
    _driver.fr_cold_binary=working_directory+"frontier-cold-checkpoint.dat";
    _driver.fr_cold_expected=working_directory+"frontier-cold-expected.json";
    save_set_value("game","tutorial",false);
    UberCont.opt_autopause=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0;
    UberCont.paused=false;UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    if(_mode=="write") {
        var _player=instance_find(Player,0);
        assert(instance_exists(_player),"Cold fixture writer requires an ordinary native Player");
        scrFRPlayerSetRace(_player.index,"bubbles");
        GameCont.area=scrFRAreaResolve("cove");GameCont.subarea=1;GameCont.loops=1;
        GameCont.lastarea=area_labs;GameCont.lastsubarea=3;
        GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=true;
        GameCont.hard=12;GameCont.crown=Crown.None;GameCont.proto=false;GameCont.gocrib=false;
        GameCont.baseseed=583091;GameCont.levseed=583091;
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(583091);
        GameCont.ntte_full_source_pending_generation=undefined;
        global.rng_state[@ RNGStates.Generation]=583091;
        scrFRContinueTestPrepareRoom(_driver,false);
        return;
    }
    assert(file_exists(_driver.fr_cold_binary) && file_exists(_driver.fr_cold_expected),
        "Run FrontierContinueWriteTests in a separate process before FrontierContinueReadTests");
    var _file=file_text_open_read(_driver.fr_cold_expected);
    try {_driver.fr_cold_record=json_parse(file_text_read_string(_file));}
    finally {file_text_close(_file);}
    if(file_exists(savegame_file)) file_delete(savegame_file);
    file_copy(_driver.fr_cold_binary,savegame_file);
    var _before=scrFRContinueModuleExport(scrFRContinueFields()),
        _adopted=variable_global_exists("fr_continue_adopted_game")?global.fr_continue_adopted_game:noone;
    scrSavegameLoad(true);
    assert(GameCont.area==_driver.fr_cold_record.area && GameCont.subarea==_driver.fr_cold_record.subarea
        && is_struct(scrNTTEFullValue(GameCont,"fr_continue_save",undefined)),
        "Real native checkpoint preview failed in the cold process");
    assert(scrFRContinueTestEqual(_before,scrFRContinueModuleExport(scrFRContinueFields()))
        && (!variable_global_exists("fr_continue_adopted_game") || global.fr_continue_adopted_game==_adopted),
        "Native preview adopted or mutated Frontier gameplay state");
    instance_destroy(Player,false);
    assert(scrSavegameLoad(false),"Real native full checkpoint load failed in the cold process");
    assert(instance_number(Player)==1 && Player.race==19,"Cold native full load did not construct the saved Bubbles Player");
    assert(scrFRContinueAdoptGame() && FRWorld.fr_previous_game==GameCont.id,
        "Cold full load failed to adopt the native run before source game_start");
    var _expected=_driver.fr_cold_record,_actual=scrFRContinueExport();
    assert(scrFRContinueTestEqual(_expected.frontier.modules,_actual.modules),"Cold checkpoint lost source module counters/Surgery values");
    assert(scrFRContinueTestEqual(_expected.frontier.assets,_actual.assets),"Cold checkpoint lost symbolic Surgery or Robot artwork");
    assert(scrFRContinueTestEqual(_expected.frontier.cache,_actual.cache),"Cold checkpoint lost ordered Deeplabs weapon cache");
    assert(scrFRContinueTestEqual(_expected.frontier.pool,_actual.pool),"Cold checkpoint lost custom mutation availability");
    assert(scrFRGetSkill("AugmentBloodlust")==1 && scrFRGetSkill("AugmentLuckyShot")==1,
        "Native session failed to restore acquired Frontier mutations");
    assert(Player.bubbles_bubbleCharge==37 && Player.bubbles_bubbleCooldown==19
        && Player.fr_buffSpeedUp_time==300,"Cold Player load reset Bubbles ability or source status timers");
    scrFRContinueTestAmmo(_expected);
    var _loaded_weapon;
    with(Player) _loaded_weapon=scrFRContinuePlayerWeaponsExport();
    assert(scrFRContinueTestEqual(_expected.weapon,_loaded_weapon),
        "Cold Player load lost source lightweight weapon state");
    assert(Player.fr_source_wep==Player.ntte_state.fr_source_weapon
        && Player.fr_source_bwep==Player.bntte_state.fr_source_weapon,
        "Cold Player load created duplicate source state instead of adopting the native physical slots");
    var _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects"),_bound=false;
    for(var _i=0;_i<array_length(_effects);++_i)
        if(_effects[_i].key=="fr_buffSpeedUp_time") _bound=array_get_index(_effects[_i].targets,Player.id)>=0;
    assert(_bound,"Cold source status target registry retained old Player IDs");
    scrNTTESmokeLog("FRONTIER COLD READ native preview/full loader + new Bubbles Player + Surgery/assets/cache/pool/LWO/status/ammo adoption OK");
    scrFRContinueTestPrepareRoom(_driver,true);
}

function scrFRContinueTestWrite(_driver) {
    scrFRModSet("mod","Frontier_Events","nightCredits",17);
    scrFRModSet("mod","Frontier_Events","nightLoop",true);
    scrFRModSet("area","deeplabs","deeplabsSpecial",true);
    scrFRModSet("mod","Frontier_IDPD","fr_deactivemuts_array",[2,5,8]);
    scrFRModSet("mod","Frontier_IDPD","fr_spawnedaugments_array",["AugmentBloodlust","AugmentLuckyShot"]);
    scrFRModSet("mod","Frontier_Pickups","deeplabsWepIndex",2);
    scrFRModSet("skill","AugmentBloodlust","augmentBloodlustCount",13);
    scrFRModSet("skill","AugmentLuckyShot","augmentLuckyShotCount",29);
    var _surgery=global.fr_module_vars[$ "skill:SurgerySlot"];
    _surgery.skillNameAdjective="COLD";_surgery.skillNameNoun="CHECKPOINT";
    _surgery.statLoseType=["maxhealth",1,4,1,infinity];
    _surgery.sprChosenIcon=scrFRSkillIcon(scrFRSkillResolve("AugmentBloodlust"),false)[0];
    var _cache=scrFRModGet("mod","Frontier_Pickups","deeplabsCacheWeps");
    ds_list_clear(_cache);ds_list_add(_cache,wep_revolver,scrFRWeaponResolve("FR_Ballista"),wep_shotgun);
    scrFRSkillSetActive("AugmentLastWish",false);
    scrFRSetSkill("AugmentBloodlust",1);scrFRSetSkill("AugmentLuckyShot",1);
    with(Player) {
        wep=scrFRWeaponResolve("FR_Ballista");bwep=scrFRWeaponResolve("FR_TeminiteCannon");
        var _a=scrFRWeaponPrepare(wep,true),_b=scrFRWeaponPrepare(bwep,false);
        _a.fr_cold_combo=7;_b.teminite=7;
        bubbles_bubbleCharge=37;bubbles_bubbleCooldown=19;fr_buffSpeedUp_time=300;
    }
    // Exercise the authored Wibbly stat API used by Surgery rather than
    // writing a second typ_amax/typ_ammo table into the checkpoint.
    scrFRModCallArray("mod","wibbly","ammoMaxBonus_add",[Player.index,Ammo.Bullets,25]);
    scrFRModCallArray("mod","wibbly","ammoMaxBonus_add",[Player.index,Ammo.Energy,-12]);
    scrFRModCallArray("mod","wibbly","ammoGainBonus_add",[Player.index,Ammo.Bullets,7]);
    scrFRModCallArray("mod","wibbly","ammoGainBonus_add",[Player.index,Ammo.Energy,3]);
    Player.ammo[Ammo.Bullets]=scrFRAmmoRead(Player.id,"typ_amax",Ammo.Bullets)-3;
    var _weapon;
    with(Player) _weapon=scrFRContinuePlayerWeaponsExport();
    var _record={frontier:scrFRContinueExport(),weapon:_weapon,area:GameCont.area,subarea:GameCont.subarea,
        loops:GameCont.loops,seed:GameCont.levseed,
        ammo_delta:{maximum:scrFRArrayClone(Player.fr_ammo_max_delta),
            gain:scrFRArrayClone(Player.fr_ammo_gain_delta),bullets:Player.ammo[Ammo.Bullets]}};
    _driver.fr_cold_record=_record;scrFRContinueTestAmmo(_record);
    directory_create(working_directory+"smoke-save");
    if(file_exists(savegame_file)) file_delete(savegame_file);
    scrSavegameSave();
    assert(file_exists(savegame_file),"Real native writer did not emit a checkpoint");
    var _binary=buffer_load(savegame_file);
    try {assert(buffer_get_size(_binary)>1024,"Native cold checkpoint is incomplete");}
    finally {buffer_delete(_binary);}
    if(file_exists(_driver.fr_cold_binary)) file_delete(_driver.fr_cold_binary);
    file_copy(savegame_file,_driver.fr_cold_binary);
    var _file=file_text_open_write(_driver.fr_cold_expected);
    try {file_text_write_string(_file,json_stringify(_record));}
    finally {file_text_close(_file);}
    assert(file_exists(_driver.fr_cold_binary),"Cold fixture copy did not preserve the native binary checkpoint");
    scrNTTESmokeLog("FRONTIER COLD WRITE native session/globals/Player binary + independent symbolic expected fixture OK");
}

function scrFRContinueTestsStep(_driver) {
    _driver.fr_cold_ticks++;
    assert(_driver.fr_cold_ticks<2400,"Frontier cold continuation native room generation timed out");
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false;speed=0;}
    GameCont.is_level_ended=true;
    if((_driver.fr_cold_phase==1 || _driver.fr_cold_phase==4) && !_driver.fr_cold_generation_started) {
        scrFRContinueTestGenerate(_driver);
        if(_driver.fr_cold_phase==1) _driver.fr_cold_phase=2;
        return false;
    }
    if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen() || !instance_exists(Player)) return false;
    if(_driver.fr_cold_phase==2) {
        if(_driver.fr_cold_loading) {
            assert(GameCont.area==_driver.fr_cold_record.area && GameCont.subarea==_driver.fr_cold_record.subarea
                && GameCont.loops==_driver.fr_cold_record.loops,"Cold native regeneration changed the saved room identity");
            assert(Player.bubbles_bubbleCharge>=37 && Player.bubbles_bubbleCharge<=39
                && Player.bubbles_bubbleCooldown>=17 && Player.bubbles_bubbleCooldown<=19,
                "Same-room native level_start overwrote the loaded Bubbles ability state: "
                +json_stringify({charge:Player.bubbles_bubbleCharge,cooldown:Player.bubbles_bubbleCooldown}));
            assert(scrFRModGet("area","deeplabs","deeplabsSpecial"),"Cold native generation lost checkpoint exit flags after entry rebuild");
            var _p=instance_find(Player,0),_primary=scrFRWeaponSlotRead(_p,"wep"),
                _secondary=scrFRWeaponSlotRead(_p,"bwep");
            assert(_p.fr_source_wep==_p.ntte_state.fr_source_weapon
                && _p.fr_source_bwep==_p.bntte_state.fr_source_weapon
                && _primary==_p.fr_source_wep && _secondary==_p.fr_source_bwep,
                "Cold native generation detached source weapon aliases from their physical slots");
            scrFRWeaponSlotsSync(_p);
            assert(_p.fr_source_wep==_primary && _p.fr_source_bwep==_secondary
                && _primary.fr_cold_combo==7 && _secondary.teminite==7,
                "First authoritative source slot sync discarded restored checkpoint combo/charge");
        }
        _driver.fr_cold_phase=3;_driver.fr_cold_observed=0;
    }
    if(_driver.fr_cold_phase==3) {
        _driver.fr_cold_observed++;
        if(_driver.fr_cold_observed<24) return false;
        assert(instance_number(Floor)>20 && instance_number(Wall)>0,"Cold checkpoint did not regenerate actual native terrain");
        var _events=scrFRContinueEventsExport();
        assert(array_length(_events)==1 && _events[0][2]=="DebugEvent1","Cold regeneration rerolled or duplicated the saved source event");
        if(_driver.fr_cold_mode=="write") {
            scrFRContinueTestWrite(_driver);
            // Continue's saved-room generation and an ordinary new-room
            // transition exercise different source level_start paths.
            // Queue the destination through the production transition API.
            // Directly writing Sewers/1 here makes native Room End advance
            // that already-final Sewers room into Scrapyard before generation.
            scrNTTEFullAreaSet(area_sewers,1,GameCont.loops);
            GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0;GameCont.patiencepick=false;
            global.fr_continue_events={game:GameCont.id,events:[]};
            _driver.fr_cold_phase=4;_driver.fr_cold_ticks=0;
            _driver.fr_cold_generation_started=false;
            _driver.fr_cold_room_marker=instance_create(0,0,FRMarker);
            room_restart();return false;
        }
        else {
            assert(scrFRModGet("mod","Frontier_Events","nightCredits")==17,
                "Cold source event restoration incremented saved night credits again");
            assert(Player.fr_source_wep.fr_cold_combo==7 && Player.fr_source_bwep.teminite==7,
                "Cold native finalization reset source weapon charge/combo");
            assert(Player.bubbles_bubbleCharge< Player.bubbles_maxBubbleCharge
                && array_length(Player.bubbles_reducedEnemies)==0,"Cold source tick reset Bubbles ability or retained discarded room enemy IDs");
            scrFRContinueTestAmmo(_driver.fr_cold_record);
            scrNTTESmokeLog("FRONTIER COLD READ real room_restart + async terrain + saved events + finalized Bubbles/LWO +24source ticks OK");
        }
        return true;
    }
    if(_driver.fr_cold_phase==4) {
        if(scrGameIsGenerationScreen() || !instance_exists(Player)) return false;
        assert(GameCont.area==area_sewers && instance_exists(TopCont)
            && instance_number(Floor)>20 && instance_number(Wall)>0,
            "Native ammo transition fixture did not generate an ordinary next room: "
            +json_stringify({area:GameCont.area,subarea:GameCont.subarea,tops:instance_number(TopCont),
                floors:instance_number(Floor),walls:instance_number(Wall)}));
        _driver.fr_cold_phase=5;_driver.fr_cold_observed=0;
    }
    if(_driver.fr_cold_phase==5) {
        if(++_driver.fr_cold_observed<24) return false;
        scrFRContinueTestAmmo(_driver.fr_cold_record);
        scrNTTESmokeLog("FRONTIER COLD WRITE ordinary next-room lifecycle preserved source ammo deltas and native live caps/grants");
        return true;
    }
    return false;
}
