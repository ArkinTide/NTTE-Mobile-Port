// Native lifecycle regression for telib.area_generate(setArea). This exercises
// real production effects, never replacement callbacks or callback counters.
function scrNTTEFullAreaSetContextConfigure(_state,_area,_subarea,_seed) {
    scrNTTEFullAreaGeneratorRestore(_state.game)
    scrNTTEFullAreaGeneratorRestore(_state.players)
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
    global.ntte_full_world_events_native_bound=true;global.ntte_full_sync_generation=false
    GameCont.area=_area;GameCont.subarea=_subarea;GameCont.loops=0;GameCont.hard=5
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=_subarea==GameCont.maxsubarea
    GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.proto=false
    GameCont.nochest=0;GameCont.noradch=0;GameCont.crownvisits=0
    GameCont.ntte_heart_spawn=undefined;GameCont.ntte_quest_spawned_part_index_list=[]
    GameCont.ntte_crime_active=false;GameCont.ntte_crime_bounty=0;GameCont.ntte_pet_history=[]
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed)
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.levseed=_seed
    global.rng_state[@RNGStates.Generation]=_seed
    save_set_value("game","tutorial",false)
    UberCont.opt_bossintro=false;UberCont.opt_freeze=0
    with(Player) {race=Race.Fish;wep=wep_revolver;bwep=wep_none;ntte_state=undefined;bntte_state=undefined}
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
}
function scrNTTEFullAreaSetContextTrenchTerrainCheck(_case) {
    // Inspect genuine normal GenCont products, after its final Alarm1. A
    // standalone constructor test would miss later sprite/area overwrites.
    var _area=scrNTTEFullAreaId("trench"),_land=0,_pits=0,_walls=0,_tops=0,
        _floor=scrNTTERefSprite("FloorTrench"),_pit=scrNTTERefSprite("FloorTrenchB")
    with(Floor) {
        assert(area==_area && sprite_index==scrNTTEFullAreaFloorSprite(_area,styleb,object_index==FloorExplo),
            "Real Trench generation retained foreign/native-caves floor artwork or area metadata")
        if(object_index==Floor) {
            if(styleb) {
                _pits++
                assert(sprite_index==_pit && depth==9 && traction==0.1 && material==0,
                    "Real Trench pit lost original art/depth/traction/material after finalization")
            }
            else {
                _land++
                // Native Floor depth is 10. Source trench.area only changes
                // pits to 9; its depth<=8 test belongs to the pit mask pass.
                assert(sprite_index==_floor && depth==object_get_depth(Floor) && traction==1 && material==4,
                    "Real Trench land lost original art/depth/traction/material after finalization: "
                    +json_stringify({id:real(id),styleb:styleb,sprite:sprite_get_name(sprite_index),
                        depth:depth,traction:traction,material:material,area:area}))
            }
        }
    }
    with(Wall) {
        _walls++
        assert(area==_area && sprite_index==scrNTTERefSprite("WallTrenchBot")
            && topspr==scrNTTERefSprite("WallTrenchTop") && outspr==scrNTTERefSprite("WallTrenchOut"),
            "Real Trench wall fields reverted to foreign/native-caves art after finalization")
    }
    with(TopSmall) {
        _tops++
        assert(area==_area && sprite_index==scrNTTERefSprite("WallTrenchTrans"),
            "Real Trench wall transition reverted to foreign/native-caves artwork")
    }
    assert(_land>0 && _pits>0 && _walls>0 && instance_number(NTTEFullPitRenderer)==1,
        "Real Trench fixture omitted actual land/pit/wall terrain or its single mask renderer")
    scrNTTEFullTrenchPitRebuild()
    with(Floor) if(object_index==Floor && !styleb)
        assert(!scrNTTEFullTrenchPitGet((bbox_left+bbox_right-1)/2,(bbox_top+bbox_bottom-1)/2),
            "Real Trench land is incorrectly classified inside the pit mask/grid")
    scrNTTESmokeLog("TRENCH ACTUAL TERRAIN "+json_stringify({source_case:_case,land:_land,pits:_pits,walls:_walls,
        transitions:_tops,sourceLand:sprite_get_name(_floor),sourcePit:sprite_get_name(_pit),
        sourceWall:sprite_get_name(scrNTTERefSprite("WallTrenchTop")),renderer:instance_number(NTTEFullPitRenderer),
        mobile_device_tested:false}))
}
function scrNTTEFullFloorMakerCompletionNativeTests(_state) {
    // Real native events, before any Alarm is forced by the synchronous driver.
    // The first case failed without the completion branch's idle-alarm repair.
    for(var _case=0;_case<4;++_case) {
        scrNTTEFullAreaSetContextConfigure(_state,area_vault,1,672451+_case)
        var _gen=instance_create(0,0,GenCont),_maker=instance_find(FloorMaker,0)
        assert(instance_exists(_maker) && !_gen.safespawn && _gen.goal==40
            && _gen.alarm[0]<0 && _gen.alarm[1]<0 && _gen.alarm[2]<0,
            "Vault completion fixture did not begin before native maker/alarm activity")
        scrNTTEFullWorldEventsCleanup()
        var _floor_count=instance_number(Floor),_seed=random_get_seed(),
            _rng=global.rng_state[RNGStates.Generation]
        if(_case<3) {
            // Keep the real starter floor; shrink the actual maker's goal so
            // its very first normal Step takes the over-goal completion path.
            _maker.goal=0
            if(_case==1) {_gen.alarm[0]=5;_gen.alarm[2]=4}
            if(_case==2) _gen.alarm[1]=1
            with(_maker) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_maker) && instance_exists(_gen)
                && instance_number(Floor)==_floor_count && !instance_exists(CrownPickup)
                && random_get_seed()==_seed && global.rng_state[RNGStates.Generation]==_rng,
                "First-step maker completion changed RNG/terrain or prematurely finalized Vault")
            with(_gen) event_perform(ev_step,ev_step_normal)
            if(_case==0) assert(_gen.alarm[0]==3 && _gen.alarm[2]==2 && _gen.alarm[1]<0,
                "Over-goal first maker Step stranded a non-safespawn Vault without native Alarm2/0")
            if(_case==1) assert(_gen.alarm[0]==5 && _gen.alarm[2]==4 && _gen.alarm[1]<0,
                "Maker completion refreshed an already scheduled preparation/population phase")
            if(_case==2) assert(_gen.alarm[0]<0 && _gen.alarm[2]<0 && _gen.alarm[1]==1,
                "Maker completion restarted generation after final Alarm1 was already scheduled")
        }
        else {
            // Ordinary random-walk generation retains its existing schedule.
            var _steps=0
            while(instance_exists(_maker) && _steps++<600) with(_maker)
                event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_maker) && instance_number(Floor)>40
                && _gen.alarm[0]==3 && _gen.alarm[2]==2 && _gen.alarm[1]<0,
                "Ordinary native Vault maker lost terrain convergence or its existing Alarm2/0 sequence")
        }
        scrNTTESmokeLog("VAULT MAKER actual Step completion case="+string(_case)
            +" floors="+string(instance_number(Floor))+" alarms="+string([_gen.alarm[2],_gen.alarm[0],_gen.alarm[1]])
            +" conditional idle-alarm recovery/no forced Alarm dispatch")
        scrNTTEFullMergedRuntimeTestCleanup(_state.before)
    }
}
function scrNTTEFullAreaSetContextNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Area-set context regression requires explicit Windows full smoke")
    var _rate=game_get_speed(gamespeed_fps)
    assert((_rate==30 || _rate==60) && timescale==30/_rate,
        "Area-set context regression requires actual engine30/60 and matching native timescale")
    var _old_map=UberCont.saveData,_old_bytes=ds_map_write(_old_map),_fixture_map=ds_map_create(),
        _state=undefined,_directory=game_directory,
        _scratch=working_directory+"area-set-context-native-"+string(get_timer())+"/"
    ds_map_copy(_fixture_map,_old_map);UberCont.saveData=_fixture_map
    // The capture's Uber snapshot must refer to the copy: its restore helper
    // restores tutorial through the native setter and may insert a default.
    _state=scrNTTEFullWorldEventsNaturalWorldCapture()
    directory_create(_scratch);game_directory=_scratch
    try {
        scrNTTEFullFloorMakerCompletionNativeTests(_state)
        // Real custom area_start remains outside the MOD-only guard: even an
        // explicitly false context must still start this ordinary GenCont.
        // False / absent(default true) / explicit true exercise native effects.
        for(var _case=0;_case<3;++_case) {
            scrNTTEFullAreaSetContextConfigure(_state,scrNTTEFullAreaId("trench"),3,672421+_case)
            GameCont.ntte_full_active_trench=false;GameCont.ntte_active_trench=false
            var _stage_begin=get_timer()
            scrNTTESmokeLog("AREA SET STAGE BEGIN "+json_stringify({area:"trench",source_case:_case,rate:_rate,all:instance_number(all)}))
            var _gen=instance_create(0,0,GenCont)
            assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation,
                "Area-set context fixture replaced actual normal custom GenCont")
            if(_case!=1) _gen.ntte_full_set_area=(_case==2)
            assert(scrNTTEFullValue(_gen,"ntte_full_set_area",true)==(_case!=0),
                "Area-set context predicate lost explicit false or default-true ordinary path")
            scrNTTEFullWorldEventsCleanup()
            with(_gen) event_perform(ev_alarm,2)
            with(_gen) event_perform(ev_alarm,0)
            assert(instance_number(Floor)>20 && instance_number(enemy)>0,
                "Area-set context fixture lacked genuine custom floor/population")
            var _trap=instance_create(28000,28000,Trap),_wall=instance_create(28200,28200,Wall)
            _trap.solid=true;_wall.depth=0
            with(_gen) event_perform(ev_alarm,1)
            var _octos=0
            with(NTTEFullPet) if(pet=="Octo" && hiding) _octos++
            assert(!instance_exists(_gen) && GameCont.ntte_full_active_trench
                && instance_number(NTTEFullPitSquid)==1 && _octos==1,
                "MOD-only level_start guard skipped/duplicated genuine Trench area_start")
            if(_case==0) {
                assert(_trap.solid && _wall.depth==0 && !instance_exists(NTTEFullWorldFinalize),
                    "Explicit setArea=false still ran actual MOD Trap/Wall/finalizer callbacks")
            }
            else {
                assert(!_trap.solid && _wall.depth==1 && instance_exists(NTTEFullWorldFinalize),
                    "Ordinary/default or explicit true context lost actual MOD finalization")
                with(NTTEFullWorldFinalize) event_perform(ev_step,ev_step_begin)
                assert(_wall.depth==0,"True MOD context lost real deferred Wall restoration")
            }
            scrNTTEFullAreaSetContextTrenchTerrainCheck(_case)
            scrNTTESmokeLog("AREA SET STAGE END "+json_stringify({area:"trench",source_case:_case,rate:_rate,
                elapsedMs:(get_timer()-_stage_begin)/1000,all:instance_number(all),floors:instance_number(Floor),tops:instance_number(TopSmall)}))
            scrNTTESmokeLog("AREA SET CONTEXT real Trench Create/Alarm2/Alarm0/Alarm1/Destroy case="+string(_case)
                +" single native PitSquid+Octo area_start; actual MOD Trap/Wall/finalizer="+string(_case!=0))
            scrNTTEFullMergedRuntimeTestCleanup(_state.before)
        }

        // Actual native Vault FloorMaker/Alarm2 creates CrownPickup and its
        // CrownPed. A false in-room addition must not build a new MOD quest hub.
        // A true addition must retain all callbacks and build exactly one hub.
        for(var _case=0;_case<2;++_case) {
            scrNTTEFullAreaSetContextConfigure(_state,area_desert,1,672431)
            if(!instance_exists(BackCont)) instance_create(0,0,BackCont)
            if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
            var _back=instance_find(BackCont,0),_top=instance_find(TopCont,0),
                _player=instance_find(Player,0),_px=_player.x,_py=_player.y,
                _area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops,
                _maxsubarea=GameCont.maxsubarea,_finalsubarea=GameCont.finalsubarea,
                _old_sync=global.ntte_full_sync_generation
            assert(!instance_exists(NTTEFullQuestFloorCont) && !instance_exists(NTTEFullLockedHugeQuestChest),
                "In-room context fixture began with a stale active quest hub")
            var _stage_begin=get_timer()
            scrNTTESmokeLog("AREA SET STAGE BEGIN "+json_stringify({area:"vault",setArea:_case==1,rate:_rate,all:instance_number(all)}))
            // BEGIN NTTE WALLDELETE VAULT FINGERPRINT PRE 20261023
            var _wd_fp_before=scrNTTEFullInstanceEnumerationOld(all),
                _wd_fp_input=scrNTTEFullWallDeleteVaultSnapshot(_wd_fp_before)
            // END NTTE WALLDELETE VAULT FINGERPRINT PRE 20261023
            scrNTTEFullAreaGenerateNative(area_vault,1,0,32016,32016,_case==1,0)
            // BEGIN NTTE WALLDELETE VAULT FINGERPRINT POST 20261023
            var _wd_fp_seed=random_get_seed(),_wd_fp_rng=json_stringify(global.rng_state),
                _wd_fp_result=scrNTTEFullWallDeleteVaultSnapshot(_wd_fp_before)
            scrNTTESmokeLog("VAULT WALLDELETE FINGERPRINT "+json_stringify({rate:_rate,setArea:_case==1,input:_wd_fp_input,result:_wd_fp_result}))
            assert(random_get_seed()==_wd_fp_seed && json_stringify(global.rng_state)==_wd_fp_rng,"Vault fingerprint logging consumed RNG")
            // END NTTE WALLDELETE VAULT FINGERPRINT POST 20261023
            scrNTTESmokeLog("AREA SET STAGE END "+json_stringify({area:"vault",setArea:_case==1,rate:_rate,
                elapsedMs:(get_timer()-_stage_begin)/1000,all:instance_number(all),floors:instance_number(Floor),tops:instance_number(TopSmall)}))
            assert(!instance_exists(GenCont) && !instance_exists(FloorMaker)
                && instance_number(CrownPickup)==1 && instance_number(CrownPed)==1,
                "Context regression did not execute complete actual native Vault generation")
            assert(array_length(scrNTTEFullRectInstances(30000,30000,34000,34000,Floor))>10,
                "Context regression omitted actual native generated/translated terrain")
            assert(_player.x==_px && _player.y==_py && global.ntte_full_sync_generation==_old_sync,
                "Native in-room context leaked player origin or synchronous global state")
            if(_case==0) {
                assert(GameCont.area==_area && GameCont.subarea==_subarea && GameCont.loops==_loops
                    && GameCont.maxsubarea==_maxsubarea && GameCont.finalsubarea==_finalsubarea,
                    "False in-room generation leaked temporary active area state")
                assert(instance_exists(_back) && instance_exists(_top)
                    && instance_number(BackCont)==1 && instance_number(TopCont)==1,
                    "False in-room generation replaced/duplicated native view controllers")
                assert(!instance_exists(NTTEFullQuestFloorCont) && !instance_exists(NTTEFullLockedHugeQuestChest)
                    && !instance_exists(NTTEFullVaultFlower),
                    "False in-room Vault spuriously ran MOD flower/quest hub level_start")
            }
            else {
                assert(GameCont.area==area_vault && GameCont.subarea==1 && GameCont.loops==0,
                    "True in-room generation failed to publish actual destination")
                assert(instance_number(NTTEFullQuestFloorCont)==4
                    && instance_number(NTTEFullLockedHugeQuestChest)==1 && instance_number(NTTEFullVaultFlower)==1,
                    "True in-room Vault lost/duplicated actual MOD source hub/flower callbacks")
            }
            scrNTTESmokeLog("AREA SET CONTEXT actual native Vault synchronous setArea="+string(_case==1)
                +" terrain/CrownPickup/CrownPed/translated products/context/source hub invariant OK")
            scrNTTEFullMergedRuntimeTestCleanup(_state.before)
        }
        assert(UberCont.saveData==_fixture_map && ds_map_write(_old_map)==_old_bytes
            && game_get_speed(gamespeed_fps)==_rate && timescale==30/_rate,
            "Area-set context fixture changed original save map or actual frame rate")
    }
    finally {
        scrNTTEFullWorldEventsNaturalWorldRestore(_state)
        UberCont.saveData=_old_map
        if(ds_exists(_fixture_map,ds_type_map)) ds_map_destroy(_fixture_map)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_scratch+_files[_i])) file_delete(_scratch+_files[_i])
        game_directory=_directory
    }
    assert(ds_map_write(_old_map)==_old_bytes,"Area-set context restoration mutated original save/options map")
    scrNTTESmokeLog("PASS actual native setArea false/default/true custom Destroy preserves area_start; false/true synchronous Vault source hub gating/context/terrain/player/view invariants @"+string(_rate))
}

// BEGIN NTTE WALLDELETE VAULT FINGERPRINT HELPERS 20261023
function scrNTTEFullWallDeleteVaultKey(_v,_old,_base) {
    var _key=string(real(_v))
    return variable_struct_exists(_old,_key) ? ["old",_old[$ _key],typeof(_v)]:["new",real(_v)-_base,typeof(_v)]
}
function scrNTTEFullWallDeleteVaultSnapshot(_reference) {
    var _seed=random_get_seed(),_native=json_stringify(global.rng_state),_old={},_base=infinity,
        _all=scrNTTEFullInstanceEnumerationOld(all),_rows=[],_streams=[]
    for(var _i=0;_i<array_length(_reference);++_i) _old[$ string(real(_reference[_i]))]=_i
    for(var _i=0;_i<array_length(_all);++_i)
        if(!variable_struct_exists(_old,string(real(_all[_i])))) _base=min(_base,real(_all[_i]))
    var _fields=["styleb","material","traction","l","r","w","h","topspr","outspr","topindex","outindex","area","subarea","loops","maxsubarea","finalsubarea","hp","max_hp"]
    for(var _i=0;_i<array_length(_all);++_i) {
        var _v=_all[_i],_row=scrNTTEFullWallDeleteOracleRow(_v),_extra=[]
        _row[@ 0]=scrNTTEFullWallDeleteVaultKey(_v,_old,_base)
        for(var _j=0;_j<array_length(_fields);++_j) if(variable_instance_exists(_v,_fields[_j]))
            array_push(_extra,[_fields[_j],variable_instance_get(_v,_fields[_j])])
        array_push(_rows,[_row,_extra])
    }
    var _queries=[all,Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]
    for(var _q=0;_q<array_length(_queries);++_q) {
        var _items=scrNTTEFullInstanceEnumerationOld(_queries[_q]),_keys=[]
        for(var _i=0;_i<array_length(_items);++_i) array_push(_keys,scrNTTEFullWallDeleteVaultKey(_items[_i],_old,_base))
        array_push(_streams,_keys)
    }
    var _globals=[GameCont.area,GameCont.subarea,GameCont.loops,GameCont.maxsubarea,GameCont.finalsubarea,
        global.ntte_full_floor_style,global.ntte_full_floor_area,global.ntte_full_floor_aw,
        global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay]
    assert(random_get_seed()==_seed && json_stringify(global.rng_state)==_native,"Vault fingerprint consumed RNG")
    return {instances:_rows,orderedQueryStreams:_streams,rng:_seed,nativeRng:_native,globals:_globals}
}
// END NTTE WALLDELETE VAULT FINGERPRINT HELPERS 20261023
