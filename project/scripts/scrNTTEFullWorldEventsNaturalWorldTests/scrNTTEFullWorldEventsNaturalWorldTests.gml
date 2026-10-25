// Explicit desktop acceptance. A parentless observer keeps each actual generated
// map alive while the normal engine dispatches Step/alarms/BackCont/Draw. The
// desktop smoke driver is parked, then resumed only after the observer finishes.
function scrNTTEFullWorldEventsNaturalWorldProfiles(_combined) {
    if(_combined) return [
        [area_scrapyards,2,102029,["RavenArena","FirePit"]],
        [area_sewers,2,101013,["GatorDen","SewerPool"]],
        [area_desert,2,100006,["MaggotPark","ScorpionCity","BanditCamp"]],
        [area_desert,2,100005,["BlockedRoom","BanditCamp"]]]
    return [
        [area_desert,2,100004,["GatorAmbush","ScorpionCity"]],
        [area_desert,2,100005,["BlockedRoom","BanditCamp"]],
        [area_desert,2,100006,["MaggotPark"]],
        [area_desert,2,100013,["BuriedVault"]],
        [area_sewers,2,101013,["GatorDen","SewerPool"]],
        [area_scrapyards,2,102029,["FirePit"]],
        [area_scrapyards,2,102076,["RavenArena"]],
        [area_city,2,103038,["SealPlaza"]],[area_labs,2,104041,["MutantVats"]],
        [area_palace,1,105049,["PopoAmbush"]],[area_palace,2,106058,["PalaceShrine"]],
        [scrNTTEFullAreaId("coast"),2,107067,["SeaCreature"]],
        [scrNTTEFullAreaId("trench"),2,108079,["EelGrave"]]]
}
function scrNTTEFullWorldEventsNaturalWorldCapture() {
    scrNTTEFullFloorInit();scrNTTEFullWorldEventsInit()
    var _bg=__background_get_colour_element(),_camera=view_camera[0],
        _identity=scr_playerinstance_find(0),_state={
        before:scrNTTEFullInstances(all),game:scrNTTEFullAreaGeneratorSnapshot(GameCont),
        players:scrNTTEFullAreaGeneratorSnapshot(Player),back:scrNTTEFullAreaGeneratorSnapshot(BackCont),
        uber:scrNTTEFullAreaGeneratorSnapshot(UberCont),mus:scrNTTEFullAreaGeneratorSnapshot(MusCont),
        seed:random_get_seed(),tick:current_frame,progress:global.ntte_full_progress,
        hooks:global.ntte_full_world_event_hooks,
        bound:variable_global_exists("ntte_full_world_events_native_bound")?global.ntte_full_world_events_native_bound:false,
        alias:variable_global_exists("ntte_full_player_alias")?global.ntte_full_player_alias:undefined,
        skills:variable_global_exists("ntte_full_palace_shrine_skills")?global.ntte_full_palace_shrine_skills:undefined,
        sync:variable_global_exists("ntte_full_sync_generation")?global.ntte_full_sync_generation:false,
        tutorial:save_get_value("game","tutorial",true),rng:array_create(array_length(global.rng_state)),alarms:[],
        floor_state:[global.ntte_full_floor_style,global.ntte_full_floor_area,
            global.ntte_full_floor_aw,global.ntte_full_floor_ah,global.ntte_full_floor_ax,global.ntte_full_floor_ay],
        vx:view_xview,vy:view_yview,camera:_camera,cx:camera_get_view_x(_camera),cy:camera_get_view_y(_camera),
        bg:_bg[0],bgcolor:layer_background_get_blend(_bg[0]),
        identity:_identity,player_name:is_undefined(_identity)?"":_identity.name,
        drivers:scrNTTEFullInstances(NTTESmokeTest),parked:[]}
    array_copy(_state.rng,0,global.rng_state,0,array_length(global.rng_state))
    var _owners=scrNTTEFullInstances([GameCont,Player,BackCont,UberCont,MusCont])
    for(var _i=0;_i<array_length(_owners);++_i) with(_owners[_i]) {
        var _values=[]
        for(var _j=0;_j<12;++_j) array_push(_values,alarm[_j])
        array_push(_state.alarms,[id,_values])
    }
    var _old=scrNTTEFullNativeGameObjects()
    _old=array_concat(_old,scrNTTEFullInstances([SubTopCont,NTTEFullWorldEvent,NTTESmokeTest]))
    for(var _i=0;_i<array_length(_old);++_i) {
        var _inst=_old[_i]
        if(_inst==id || instance_is(_inst,Player) || array_get_index(_state.parked,_inst)>=0) continue
        array_push(_state.parked,_inst);instance_deactivate_object(_inst)
    }
    return _state
}
function scrNTTEFullWorldEventsNaturalWorldRestore(_state) {
    scrNTTEFullWorldEventsCleanup()
    scrNTTEFullMergedRuntimeTestCleanup(_state.before)
    for(var _i=0;_i<array_length(_state.parked);++_i) instance_activate_object(_state.parked[_i])
    scrNTTEFullAreaGeneratorRestore(_state.game);scrNTTEFullAreaGeneratorRestore(_state.players)
    scrNTTEFullAreaGeneratorRestore(_state.back);scrNTTEFullAreaGeneratorRestore(_state.uber);scrNTTEFullAreaGeneratorRestore(_state.mus)
    global.ntte_full_progress=_state.progress;global.ntte_full_world_event_hooks=_state.hooks
    global.ntte_full_world_events_native_bound=_state.bound;global.ntte_full_player_alias=_state.alias
    global.ntte_full_palace_shrine_skills=_state.skills;global.ntte_full_sync_generation=_state.sync
    if(!is_undefined(_state.identity)) _state.identity.name=_state.player_name
    save_set_value("game","tutorial",_state.tutorial)
    array_copy(global.rng_state,0,_state.rng,0,array_length(_state.rng))
    var _fs=_state.floor_state
    scrNTTEFullFloorSetStyle(_fs[0],_fs[1]);scrNTTEFullFloorSetAlign(_fs[2],_fs[3],_fs[4],_fs[5])
    for(var _i=0;_i<array_length(_state.alarms);++_i) {
        var _owner=_state.alarms[_i][0],_values=_state.alarms[_i][1]
        if(instance_exists(_owner)) with(_owner) for(var _j=0;_j<12;++_j) alarm[_j]=_values[_j]
    }
    view_xview=_state.vx;view_yview=_state.vy;camera_set_view_pos(_state.camera,_state.cx,_state.cy)
    layer_background_blend(_state.bg,_state.bgcolor);current_frame=_state.tick;random_set_seed(_state.seed)
    for(var _i=0;_i<array_length(_state.drivers);++_i)
        assert(instance_exists(_state.drivers[_i]),"Natural world acceptance lost its desktop smoke driver")
}
function scrNTTEFullWorldEventsNaturalWorldConfigure(_state,_profile,_seed) {
    scrNTTEFullAreaGeneratorRestore(_state.game);scrNTTEFullAreaGeneratorRestore(_state.players)
    global.ntte_full_progress=json_parse(json_stringify(_state.progress))
    variable_struct_set(global.ntte_full_progress.unlocks,"crown:crime",true)
    variable_struct_set(global.ntte_full_progress.unlocks,"pack:coast",true)
    variable_struct_set(global.ntte_full_progress.unlocks,"pack:trench",true)
    global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
    global.ntte_full_world_events_native_bound=true;global.ntte_full_sync_generation=false
    save_set_value("game","tutorial",false)
    if(!is_undefined(_state.identity)) _state.identity.name="blaac"
    GameCont.area=_profile[0];GameCont.subarea=_profile[1];GameCont.loops=0;GameCont.hard=5
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=GameCont.subarea==GameCont.maxsubarea
    GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.ntte_crime_bounty=3
    // Actual Pet.CleanUp stores four-field provider/value records. A bare pet
    // name passes the eligibility count but is not a valid MutantVat occupant.
    GameCont.ntte_pet_history=[["Scorpion","mod","petlib",{bskin:0,scorpion_city:0}]]
    GameCont.popolevel=15;GameCont.heavyheart=0
    GameCont.rad=0;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.level=1
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed)
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.levseed=_seed
    global.rng_state[@RNGStates.Generation]=_seed
    UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
    UberCont.opt_bossintro=false;UberCont.opt_freeze=0
    with(Player) {wep=wep_revolver;bwep=wep_none;hp=100000;max_hp=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false}
    var _pet=scrNTTEFullPetCreate(10016,10016,"Scorpion")
    _pet.scorpion_city=1
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
}
function scrNTTEFullWorldEventsNaturalWorldStart(_combined) {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Natural world fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullWorldEventsNaturalWorldTest")
    assert(object_exists(_object) && !instance_exists(_object),"Natural world observer unavailable or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        profiles=scrNTTEFullWorldEventsNaturalWorldProfiles(_combined)
        combined=_combined;profile_index=0;phase=0;draw_frames=0;live_draw_start=0;elapsed=0
        selected=[];chosen_seed=0;visible=true;depth=-100000
    }
}
function scrNTTEFullWorldEventsNaturalWorldTests() {scrNTTEFullWorldEventsNaturalWorldStart(false)}
function scrNTTEFullWorldEventsCombinedWorldTests() {scrNTTEFullWorldEventsNaturalWorldStart(true)}
function scrNTTEFullWorldEventsNaturalWorldDrawWitness() {draw_frames++}
function scrNTTEFullWorldEventsNaturalWorldTrapWitness() {
    // tescrapyard TrapSpin_step2554..2557: a spin trap dies when its real
    // support wall is gone. Real collision processing can remove that wall
    // after this actor's Step, so allow one scheduled Step to observe the loss.
    // No test callback, destruction or replacement object repairs this state.
    var _settled=true
    for(var _i=0;_i<array_length(trap_witness);++_i) {
        var _seen=trap_witness[_i],_wall=position_meeting(_seen.x,_seen.y,Wall),_alive=instance_exists(_seen.trap)
        if(_wall) {
            assert(_alive,"Original merged TrapSpin disappeared while its actual support wall still exists")
            assert(!_seen.lost_wall,"Destroyed merged TrapSpin support unexpectedly returned during live witness")
            _seen.missing_steps=0
        }
        else {
            if(!_seen.lost_wall) {
                _seen.lost_wall=true
                scrNTTESmokeLog("WORLD COMBINED SUPPORT LOST seed="+string(chosen_seed)+" trap="+string(_seen.trap)
                    +" original_support_alive="+string(instance_exists(_seen.support))+" draw="+string(draw_frames-live_draw_start)
                    +" floor_explo="+string(collision_point(_seen.x-8,_seen.y-8,FloorExplo,false,false)))
            }
            if(_alive) {
                _seen.missing_steps++
                assert(_seen.missing_steps<=1,"Original merged TrapSpin survived a full scheduled Step without its support wall")
                _settled=false
            }
            else _seen.removed_after_wall=true
        }
        assert(instance_number(NTTEFullTrapSpin)==(_alive?1:0),
            "Combined map created a duplicate or replacement spin trap after its one original merged trap")
    }
    return _settled
}
function scrNTTEFullWorldEventsNaturalWorldStep() {
    with(Player) {hp=100000;max_hp=100000;nexthurt=current_frame+100000;speed=0;can_walk=false;can_aim=false}
    if(phase==0) {
        var _profile=profiles[profile_index],_found=false
        for(var _attempt=0;_attempt<8192 && !_found;++_attempt) {
            chosen_seed=_profile[2]+_attempt
            scrNTTEFullWorldEventsNaturalWorldConfigure(state,_profile,chosen_seed)
            var _gen=instance_create(0,0,GenCont)
            selected=scrNTTEFullWorldEventGet(all);var _names=[]
            for(var _i=0;_i<array_length(selected);++_i) array_push(_names,selected[_i].event_name)
            _found=true
            for(var _i=0;_i<array_length(_profile[3]);++_i) if(array_get_index(_names,_profile[3][_i])<0) _found=false
            if(!_found) {scrNTTEFullWorldEventsCleanup();scrNTTEFullMergedRuntimeTestCleanup(state.before)}
        }
        assert(_found,"Natural whole-world seed sweep did not find source profile: "+string(_profile))
        assert(!_gen.ntte_full_sync_generation,"Whole-world acceptance silently used synchronous generation")
        elapsed=0;phase=1
        scrNTTESmokeLog("WORLD LIVE GENERATION seed="+string(chosen_seed)+" area="+string(_profile[0])+" sub="+string(_profile[1])+" selected="+string(_names))
        return;
    }
    elapsed+=timescale
    assert(elapsed<=1800,"Natural floor/alarm/world frame chain did not complete within60 logical seconds")
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        var _coast=GameCont.area==scrNTTEFullAreaId("coast")
        scrNTTESmokeLog("WORLD LIVE GENERATED seed="+string(chosen_seed)+" area="+string(GameCont.area)
            +" floor="+string(instance_number(Floor))+" wall="+string(instance_number(Wall))
            +" top_small="+string(instance_number(TopSmall))+" top="+string(instance_number(Top))
            +" top_cont="+string(instance_number(TopCont))+" subtop="+string(instance_number(SubTopCont))
            +" sea="+string(instance_number(NTTEFullCoastSea))+" sea_top="+string(instance_number(NTTEFullCoastSeaTop))
            +" sea_visible="+string(instance_number(NTTEFullCoastSeaVisible))+" hard="+string(GameCont.hard)
            +" sync="+string(global.ntte_full_sync_generation)+" gen="+string(instance_number(GenCont))
            +" floor_maker="+string(instance_number(FloorMaker)))
        assert(instance_number(Floor)>20,"Natural real FloorMaker/GenCont alarms did not produce actual floor population")
        // Original coast.area121..133 removes all TopSmall and Coast Walls;
        // its three real ordered sea controllers replace the normal wall tops.
        if(_coast) assert(instance_exists(NTTEFullCoastSea) && instance_exists(NTTEFullCoastSeaTop)
            && instance_exists(NTTEFullCoastSeaVisible),"Natural Coast lacks its actual source sea render controllers")
        else assert(instance_number(TopSmall)>0,"Natural ordinary area lacks its actual native wall tops")
        for(var _i=0;_i<array_length(selected);++_i)
            assert(instance_exists(selected[_i]) && selected[_i].ntte_event_generated,
                "Natural GenCont finalization omitted a selected original event")
        assert(instance_exists(BackCont) && BackCont.visible && instance_exists(TopCont) && instance_exists(SubTopCont),
            "Natural gameplay lacks its real visible BackCont/TopCont/SubTopCont render chain")
        if(combined && array_get_index(profiles[profile_index][3],"RavenArena")>=0) {
            var _arena=scrNTTEFullWorldEventGet("RavenArena"),_traps=scrNTTEFullInstances(NTTEFullTrapSpin)
            trap_witness=[]
            assert(instance_number(NTTEFullTrapSpin)==1 && array_length(_traps)==1,
                "Natural RavenArena+FirePit generation did not create exactly one original merged spin trap")
            scrNTTESmokeLog("WORLD COMBINED GENERATED seed="+string(chosen_seed)+" trap_count="+string(array_length(_traps))
                +" arena_xy="+string([_arena.x,_arena.y])+" arena_floors="+string(array_length(_arena.floors))
                +" arena_tops="+string(array_length(_arena.inst_top))+" arena_idle="+string(array_length(_arena.inst_idle)))
            for(var _i=0;_i<array_length(_traps);++_i) {
                var _trap=_traps[_i]
                var _support=collision_point(_trap.x,_trap.y,Wall,false,false)
                assert(instance_exists(_support),"Generated original merged spin trap lacks its actual source support wall")
                array_push(trap_witness,{trap:_trap,x:_trap.x,y:_trap.y,support:_support,lost_wall:false,missing_steps:0,removed_after_wall:false})
                scrNTTESmokeLog("WORLD COMBINED GENERATED trap="+string(_trap)+" xy="+string([_trap.x,_trap.y])
                    +" support_wall="+string(collision_point(_trap.x,_trap.y,Wall,false,false)))
            }
        }
        live_draw_start=draw_frames;phase=2
        return;
    }
    if(combined && array_get_index(profiles[profile_index][3],"RavenArena")>=0)
        if(!scrNTTEFullWorldEventsNaturalWorldTrapWitness()) return;
    if(draw_frames-live_draw_start<8) return;
    assert(!lockstep_stop && instance_exists(Player),"Live world paused lockstep or lost its real player")
    if(GameCont.area==scrNTTEFullAreaId("coast")) {
        var _sea=instance_find(NTTEFullCoastSea,0)
        assert(instance_exists(_sea) && _sea.ntte_coast_draw_ready,
            "Natural Coast did not complete its actual ordered sea Draw during live gameplay")
        scrNTTESmokeLog("WORLD LIVE COAST actual sea/sea_top/visibility controllers and scheduled ordered sea Draw x8 OK")
    }
    var _profile=profiles[profile_index],_names=[]
    for(var _i=0;_i<array_length(selected);++_i) {
        var _event=selected[_i]
        assert(instance_exists(_event) && _event.ntte_event_generated && !_event.ntte_event_cleanup_done,
            "Naturally selected event disappeared or cleaned itself during live gameplay frames")
        array_push(_names,_event.event_name)
    }
    if(combined && array_get_index(_profile[3],"RavenArena")>=0) {
        scrNTTESmokeLog("WORLD COMBINED LIVE seed="+string(chosen_seed)+" trap_count="+string(instance_number(NTTEFullTrapSpin)))
        for(var _i=0;_i<array_length(trap_witness);++_i) {
            var _seen=trap_witness[_i]
            if(position_meeting(_seen.x,_seen.y,Wall)) {
                assert(instance_exists(_seen.trap) && !_seen.lost_wall,
                    "Natural merged TrapSpin failed real support-preserving live frame acceptance")
                scrNTTESmokeLog("WORLD COMBINED WITH_SUPPORT_ALIVE seed="+string(chosen_seed)+" original_trap="+string(_seen.trap)
                    +" original_support="+string(_seen.support)+" actual8Draw OK")
            }
            else {
                assert(_seen.lost_wall && _seen.removed_after_wall && !instance_exists(_seen.trap) && !instance_exists(_seen.support),
                    "Natural merged TrapSpin vanished without witnessed real wall loss and scheduled source destruction")
                scrNTTESmokeLog("WORLD COMBINED AFTER_REAL_SUPPORT_LOSS_DESTROYED seed="+string(chosen_seed)
                    +" original_trap="+string(_seen.trap)+" original_support="+string(_seen.support)+" actual8Draw OK")
            }
        }
    }
    scrNTTESmokeLog("WORLD LIVE FRAMES seed="+string(chosen_seed)+" actual normal floor/alarm chain + BackCont/Step/Draw x"
        +string(draw_frames-live_draw_start)+" OK events="+string(_names))
    scrNTTEFullWorldEventsCleanup()
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    if(++profile_index<array_length(profiles)) {phase=0;return;}
    var _combined=combined,_state=state
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    scrNTTESmokeLog("FULL WORLD "+(_combined?"COMBINED":"ALL16")+" NATURAL GENERATED MAPS/REAL FRAMES complete @"+string(30/timescale))
    instance_destroy(id,false)
}
