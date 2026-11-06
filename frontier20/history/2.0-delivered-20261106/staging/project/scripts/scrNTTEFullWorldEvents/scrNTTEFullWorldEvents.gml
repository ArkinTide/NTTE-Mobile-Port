// teevents3270..3381, ntte.mod2705..2727 and1855..1905.
// Readiness is explicit. Missing original event implementations never become
// empty successful events or alter the original16-event probability table.
function scrNTTEFullWorldEventsInit() {
    if (variable_global_exists("ntte_full_world_event_hooks")) return;
    global.ntte_full_world_event_hooks={}
}
function scrNTTEFullWorldEventRegister(_name,_create,_setup=undefined,_step=undefined,_cleanup=undefined,_complete=false) {
    scrNTTEFullWorldEventsInit()
    if (array_get_index(scrNTTEFullWorldEventOrder(),_name)<0) throw "NTTE disabled/unknown event cannot be registered: "+_name
    if (!is_callable(_create)) throw "NTTE event requires its original create callback: "+_name
    variable_struct_set(global.ntte_full_world_event_hooks,_name,{create:_create,setup:_setup,step:_step,cleanup:_cleanup,complete:_complete})
}
function scrNTTEFullWorldEventsMissing() {
    scrNTTEFullWorldEventsInit()
    var _names=scrNTTEFullWorldEventOrder(),_missing=[]
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i]
        if (!variable_struct_exists(global.ntte_full_world_event_hooks,_name)) array_push(_missing,_name)
        else {
            var _hooks=variable_struct_get(global.ntte_full_world_event_hooks,_name)
            if (!_hooks.complete) array_push(_missing,_name)
        }
    }
    if (!variable_global_exists("ntte_full_palace_shrine_skills") || !is_callable(global.ntte_full_palace_shrine_skills)) array_push(_missing,"PalaceShrine_skills")
    if (!variable_global_exists("ntte_full_player_alias") || !is_callable(global.ntte_full_player_alias)) array_push(_missing,"player_get_alias")
    // Native heavyheart is the original count of the same six weapon
    // mutations. scrSetSkill increments/decrements it on actual transitions.
    if (instance_exists(GameCont) && !variable_instance_exists(GameCont,"heavyheart")) array_push(_missing,"GameCont.heavyheart (source wepmuts)")
    return _missing
}
function scrNTTEFullWorldEventsReady() { return array_length(scrNTTEFullWorldEventsMissing())==0 }
function scrNTTEFullWorldEventGet(_name=all) {
    if (_name==all) {
        var _list=scrNTTEFullInstances(NTTEFullWorldEvent)
        array_sort(_list,true)
        return _list
    }
    var _found=noone
    with (NTTEFullWorldEvent) if (event_name==_name) { _found=id; break }
    return _found
}
function scrNTTEFullWorldEventCreate() {
    event_name=""; tip=""; floors=[]; spawn_x=10016; spawn_y=10016
    ntte_event_generated=false; ntte_event_cleanup_done=false; ntte_event_hooks=undefined
    visible=false; persistent=false
}
function scrNTTEFullWorldEventText(_name) {
    var _tag="@(color:"+string(make_color_rgb(175,143,106))+")"
    switch(_name) {
        case "BuriedVault": return GameCont.area==area_vault || scrNTTEFullValue(GameCont,"buried_vaults",0)>0 ? "":choose("SECRETS IN THE "+_tag+"WALLS",_tag+"ARCHAEOLOGY","ANCIENT "+_tag+"STRUCTURES")
        case "BanditCamp": return GameCont.loops>0 ? "":_tag+"BANDITS"
        case "BlockedRoom": return ""
        case "MaggotPark": return "THE SOUND OF "+_tag+"FLIES"
        case "ScorpionCity": return choose("THE AIR "+_tag+"STINGS",_tag+"WHERE ARE WE GOING")
        // Both nested choose calls are evaluated in the original; preserving
        // their RNG consumption matters to later events' probability rolls.
        case "SewerPool": return choose("",choose(_tag+"RADIOACTIVE SEWAGE @sSMELLS#WORSE THAN YOU THINK",_tag+"ACID RAIN @sRUNOFF"))
        case "GatorAmbush": return choose(_tag+"THE WASTELAND WEAPON TRADE","THESE PIPES RUN "+_tag+"EVERYWHERE")
        case "GatorDen": return _tag+"DISTANT CHATTER"
        case "RavenArena": return "ENTER "+_tag+"THE RING"
        case "FirePit": return _tag+"RAIN DROPS @sTURN TO "+_tag+"STEAM"
        case "SealPlaza": return _tag+"DISTANT RELATIVES"
        case "MutantVats": return _tag+"SPECIMENS"
        case "PalaceShrine": return choose(_tag+"RAD MANIPULATION @sIS @wKINDA TRICKY",_tag+"FINAL PROVISIONS")
        case "PopoAmbush":
            var _venuz=false
            with(Player) if (race==Race.Venuz) _venuz=true
            return choose(_tag+"THE "+(_venuz ? "POPO":"I.D.P.D.")+" @sIS @wWAITING FOR YOU",_tag+"AMBUSHED")
        case "SeaCreature": return "SOMETHING IN THE DISTANCE"
        case "EelGrave": return "EELS "+_tag+"NEVER @sFORGET"
    }
    throw "NTTE disabled/unknown event text: "+_name
}
function scrNTTEFullWorldEventSet(_name,_active,_gen=noone) {
    if (_name==all) {
        if (!_active) {
            var _controllers=scrNTTEFullWorldEventGet(all)
            for(var _i=0;_i<array_length(_controllers);++_i) instance_destroy(_controllers[_i])
            return []
        }
        var _names=scrNTTEFullWorldEventOrder()
        for(var _i=0;_i<array_length(_names);++_i) scrNTTEFullWorldEventSet(_names[_i],_active,_gen)
        return scrNTTEFullWorldEventGet(all)
    }
    var _old=scrNTTEFullWorldEventGet(_name)
    if (!_active) { if (instance_exists(_old)) instance_destroy(_old); return noone }
    if (instance_exists(_old)) return _old
    scrNTTEFullWorldEventsInit()
    if (!variable_struct_exists(global.ntte_full_world_event_hooks,_name)) throw "NTTE event is not implemented: "+_name
    var _hooks=variable_struct_get(global.ntte_full_world_event_hooks,_name),_inst=instance_create(0,0,NTTEFullWorldEvent)
    _inst.event_name=_name; _inst.ntte_event_hooks=_hooks; _inst.tip=scrNTTEFullWorldEventText(_name)
    if (instance_exists(_gen)) {
        _inst.spawn_x=scrNTTEFullValue(_gen,"spawn_x",10016); _inst.spawn_y=scrNTTEFullValue(_gen,"spawn_y",10016)
        if (_inst.tip!="" && !variable_instance_exists(_gen,"tip_ntte_event")) {
            _gen.tip_ntte_event=_inst.tip; _gen.tip=_inst.tip
        }
    }
    if (is_callable(_hooks.setup)) { var _setup=method(_inst,_hooks.setup); _setup() }
    return _inst
}
function scrNTTEFullWorldEventContext(_gen,_name) {
    var _pet_count=0,_history=scrNTTEFullValue(GameCont,"ntte_pet_history",[])
    with (NTTEFullPet) if (pet=="Scorpion" && scorpion_city>0) _pet_count++
    var _ctx={area:GameCont.area,subarea:GameCont.subarea,loops:GameCont.loops,hard:GameCont.hard,
        safespawn:scrNTTEFullValue(_gen,"safespawn",1),buried_vaults:scrNTTEFullValue(GameCont,"buried_vaults",0),
        scorpion_city_pet_count:_pet_count,crime_bounty:scrNTTEFullValue(GameCont,"ntte_crime_bounty",0),
        crime_unlocked:scrNTTEFullUnlockGet("crown:crime"),coast_unlocked:scrNTTEFullUnlockGet("pack:coast"),
        trench_unlocked:scrNTTEFullUnlockGet("pack:trench"),general_loaded:true,pet_history_count:array_length(_history),
        popolevel:GameCont.popolevel,wepmuts:0,player_alias:"",palace_shrine_skill_count:0}
    // These source callbacks can consume RNG. Evaluate only after area/hard
    // eligibility, and only for the event whose chance actually uses them.
    if (_name=="PalaceShrine" && GameCont.subarea==2) {
        if (!variable_instance_exists(GameCont,"heavyheart")) throw "Original weapon mutation count is not integrated"
        _ctx.wepmuts=GameCont.heavyheart
        if (!variable_global_exists("ntte_full_palace_shrine_skills") || !is_callable(global.ntte_full_palace_shrine_skills))
            throw "Original PalaceShrine_skills callback is not integrated"
        _ctx.palace_shrine_skill_count=array_length(global.ntte_full_palace_shrine_skills())
    }
    if (_name=="SeaCreature") {
        if (!variable_global_exists("ntte_full_player_alias") || !is_callable(global.ntte_full_player_alias))
            throw "Original player alias callback is not integrated"
        _ctx.player_alias=global.ntte_full_player_alias(0)
    }
    return _ctx
}
function scrNTTEFullWorldEventsSetup(_gen) {
    if (!instance_exists(_gen)) throw "NTTE events require the real generation controller"
    if (variable_instance_exists(_gen,"ntte_full_events_setup")) return;
    var _missing=scrNTTEFullWorldEventsMissing()
    if (array_length(_missing)>0) throw "Complete NTTE events are not ready: "+string(_missing)
    _gen.ntte_full_events_setup=true
    var _list=scrNTTEFullWorldEventOrder()
    for(var _i=0;_i<array_length(_list);++_i) {
        var _name=_list[_i],_area=scrNTTEFullWorldEventArea(_name)
        if ((!is_undefined(_area) && _area!=GameCont.area) || GameCont.hard<scrNTTEFullWorldEventHard(_name)) continue
        var _ctx=scrNTTEFullWorldEventContext(_gen,_name)
        if (random(1)<scrNTTEFullWorldEventChance(_name,_ctx)) scrNTTEFullWorldEventSet(_name,true,_gen)
    }
}
function scrNTTEFullWorldEventsGenerate() {
    var _controllers=scrNTTEFullWorldEventGet(all)
    for(var _i=0;_i<array_length(_controllers);++_i) with (_controllers[_i]) {
        if (ntte_event_generated) continue
        var _before=scrNTTEFullInstances(Floor),_hooks=ntte_event_hooks
        x=0; y=0; ntte_event_generated=true
        var _create=method(id,_hooks.create)
        _create()
        floors=[]
        var _after=scrNTTEFullInstances(Floor)
        for(var _j=0;_j<array_length(_after);++_j) if (array_get_index(_before,_after[_j])<0) array_push(floors,_after[_j])
        if (x==0 && y==0 && array_length(floors)>0) {
            var _x1=infinity,_y1=infinity,_x2=-infinity,_y2=-infinity
            for(var _j=0;_j<array_length(floors);++_j) with (floors[_j]) {
                _x1=min(_x1,bbox_left); _y1=min(_y1,bbox_top); _x2=max(_x2,bbox_right); _y2=max(_y2,bbox_bottom)
            }
            x=(_x1+_x2)/2; y=(_y1+_y2)/2
        }
    }
}
function scrNTTEFullWorldEventStep() {
    if (lockstep_stop || !ntte_event_generated || instance_exists(GenCont)) return;
    if (is_callable(ntte_event_hooks.step)) { var _step=method(id,ntte_event_hooks.step); _step() }
}
function scrNTTEFullWorldEventCleanup() {
    if (ntte_event_cleanup_done) return;
    ntte_event_cleanup_done=true
    // Original installs cleanup at level_start, not during pre-generation setup.
    if (ntte_event_generated && is_struct(ntte_event_hooks) && is_callable(ntte_event_hooks.cleanup)) {
        var _cleanup=method(id,ntte_event_hooks.cleanup); _cleanup()
    }
}
function scrNTTEFullWorldEventsCleanup() { scrNTTEFullWorldEventSet(all,false) }

function scrNTTEFullWorldEventBanditCampCreate() {
    scrNTTEFullBanditCampEvent(spawn_x,spawn_y,instance_exists(scrNTTEFullWorldEventGet("MaggotPark")),instance_exists(scrNTTEFullWorldEventGet("ScorpionCity")))
}
function scrNTTEFullWorldEventMaggotParkCreate() { scrNTTEFullMaggotParkEvent(spawn_x,spawn_y) }
function scrNTTEFullWorldEventSeaCreatureCreate() { scrNTTEFullSeaCreatureEvent(spawn_x,spawn_y) }
function scrNTTEFullWorldEventEelGraveCreate() { scrNTTEFullEelGraveEvent(spawn_x,spawn_y) }
function scrNTTEFullWorldEventSewerPoolCreate() { scrNTTEFullSewerPoolEvent(spawn_x,spawn_y) }
function scrNTTEFullWorldEventScorpionCityCreate() { scrNTTEFullScorpionCityEvent(spawn_x,spawn_y) }
function scrNTTEFullWorldEventBindings() {
    // Source-backed create bindings exist. Dependencies listed in world-hooks
    // still prevent declaring their entire feature paths complete.
    scrNTTEFullWorldEventRegister("BanditCamp",scrNTTEFullWorldEventBanditCampCreate)
    scrNTTEFullWorldEventRegister("MaggotPark",scrNTTEFullWorldEventMaggotParkCreate)
    scrNTTEFullWorldEventRegister("SeaCreature",scrNTTEFullWorldEventSeaCreatureCreate)
    scrNTTEFullWorldEventRegister("EelGrave",scrNTTEFullWorldEventEelGraveCreate)
    scrNTTEFullWorldEventRegister("SewerPool",scrNTTEFullWorldEventSewerPoolCreate)
    scrNTTEFullWorldEventRegister("ScorpionCity",scrNTTEFullWorldEventScorpionCityCreate,scrNTTEFullScorpionCitySetup)
    scrNTTEFullWorldEventRegister("RavenArena",scrNTTEFullRavenArenaCreate,scrNTTEFullRavenArenaSetup,scrNTTEFullRavenArenaStep)
    scrNTTEFullWorldEventRegister("FirePit",scrNTTEFullFirePitCreate,scrNTTEFullFirePitSetup,undefined,scrNTTEFullFirePitCleanup)
    scrNTTEFullWorldEventRegister("PalaceShrine",scrNTTEFullPalaceShrineCreate)
    scrNTTEFullWorldEventRegister("GatorAmbush",scrNTTEFullGatorAmbushCreate,scrNTTEFullGatorAmbushSetup)
}

// Isolated harness callbacks verify lifecycle dispatch against observable
// effects, without claiming to implement the original events they stand in for.
function scrNTTEFullWorldEventFixtureSetup() {
    assert(instance_is(id,NTTEFullWorldEvent),"Event setup callback did not receive its controller context")
    array_push(global.ntte_full_event_fixture_log,"setup:"+event_name)
}
function scrNTTEFullWorldEventFixtureCreate() {
    array_push(global.ntte_full_event_fixture_log,"create:"+event_name)
    instance_create(event_name=="SeaCreature" ? 30720:30848,30720,Floor)
}
function scrNTTEFullWorldEventFixtureStep() { array_push(global.ntte_full_event_fixture_log,"step:"+event_name) }
function scrNTTEFullWorldEventFixtureCleanup() { array_push(global.ntte_full_event_fixture_log,"cleanup:"+event_name) }
function scrNTTEFullWorldEventsSmoke() {
    scrNTTEFullWorldEventsInit()
    var _saved=global.ntte_full_world_event_hooks,_snapshot=scrNTTEFullInstances(all)
    global.ntte_full_world_event_hooks={}; global.ntte_full_event_fixture_log=[]
    scrNTTEFullWorldEventRegister("SeaCreature",scrNTTEFullWorldEventFixtureCreate,scrNTTEFullWorldEventFixtureSetup,scrNTTEFullWorldEventFixtureStep,scrNTTEFullWorldEventFixtureCleanup)
    scrNTTEFullWorldEventRegister("MaggotPark",scrNTTEFullWorldEventFixtureCreate,scrNTTEFullWorldEventFixtureSetup,scrNTTEFullWorldEventFixtureStep,scrNTTEFullWorldEventFixtureCleanup)
    assert(!scrNTTEFullWorldEventsReady(),"Partial callbacks incorrectly enabled the complete natural event path")
    var _disabled=false
    try { scrNTTEFullWorldEventRegister("YetiHideout",scrNTTEFullWorldEventFixtureCreate) }
    catch (_error) { _disabled=true }
    assert(_disabled,"Original commented-out YetiHideout was enabled")
    var _gen=instance_create(0,0,WepSwap)
    _gen.spawn_x=10016; _gen.spawn_y=10016; _gen.tip="NATIVE TIP"
    var _sea=scrNTTEFullWorldEventSet("SeaCreature",true,_gen),_maggot=scrNTTEFullWorldEventSet("MaggotPark",true,_gen)
    assert(_gen.tip=="SOMETHING IN THE DISTANCE" && _gen.tip_ntte_event==_gen.tip,"Event tip did not preserve the first nonempty original tip")
    var _count=instance_number(NTTEFullWorldEvent)
    assert(scrNTTEFullWorldEventSet("SeaCreature",true,_gen)==_sea && instance_number(NTTEFullWorldEvent)==_count,"Activating an existing event duplicated setup/controller")
    assert(array_length(global.ntte_full_event_fixture_log)==2,"Event setup did not run exactly once")
    with (_sea) scrNTTEFullWorldEventStep()
    assert(array_length(global.ntte_full_event_fixture_log)==2,"Event Step ran before original level-start activation")
    scrNTTEFullWorldEventsGenerate()
    assert(global.ntte_full_event_fixture_log[2]=="create:SeaCreature" && global.ntte_full_event_fixture_log[3]=="create:MaggotPark","Event create order no longer follows controller instance IDs")
    assert(array_length(_sea.floors)==1 && _sea.x==30736 && _sea.y==30736 && _maggot.x==30864,"Event floors or modern exclusive-bbox centering changed")
    scrNTTEFullWorldEventsGenerate()
    assert(array_length(global.ntte_full_event_fixture_log)==4,"Event generation ran twice")
    with (_sea) scrNTTEFullWorldEventStep()
    assert(global.ntte_full_event_fixture_log[4]=="step:SeaCreature","Activated event did not receive its Step callback")
    with (_sea) { scrNTTEFullWorldEventCleanup(); scrNTTEFullWorldEventCleanup() }
    scrNTTEFullWorldEventSet("SeaCreature",false)
    assert(array_length(global.ntte_full_event_fixture_log)==6 && global.ntte_full_event_fixture_log[5]=="cleanup:SeaCreature","Event cleanup was omitted or ran more than once")
    scrNTTEFullWorldEventSet("MaggotPark",false)
    assert(array_length(global.ntte_full_event_fixture_log)==7 && global.ntte_full_event_fixture_log[6]=="cleanup:MaggotPark","Deactivation did not invoke original cleanup")
    var _new=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_new);++_i) if (array_get_index(_snapshot,_new[_i])<0) instance_destroy(_new[_i],false)
    global.ntte_full_world_event_hooks=_saved
    scrNTTESmokeLog("FULL WORLD EVENT MANAGER ORIGINAL16/DISABLED EXCLUSION/FIRST TIP/CONTROLLER CONTEXT/ID ORDER/NEW FLOORS/CENTER/ONE GENERATION/STEP/CLEANUP ONCE OK")
}
