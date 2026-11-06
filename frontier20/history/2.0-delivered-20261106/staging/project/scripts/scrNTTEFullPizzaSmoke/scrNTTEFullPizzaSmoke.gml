// Real native constructors/events; these fixtures need integrate_pizza hooks.
function scrNTTEFullPizzaPropsSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area,_lastarea=GameCont.lastarea,
        _active=scrNTTEFullValue(GameCont,"ntte_full_active_pizza",false)
    GameCont.area=scrNTTEFullAreaId("pizza"); GameCont.lastarea=GameCont.area; GameCont.ntte_full_active_pizza=false
    var _native=instance_create(36016,36016,HPPickup),_heal=_native.num,
        _native_chest=instance_create(36116,36016,HealthChest),_chest_heal=_native_chest.num
    GameCont.ntte_full_active_pizza=true
    var _slice=instance_create(36216,36016,HPPickup),_chest=instance_create(36316,36016,HealthChest),
        _concrete=instance_create(36416,36016,NTTEFullPizza),_concrete_chest=instance_create(36516,36016,NTTEFullPizzaChest)
    assert(_slice.sprite_index==sprSlice && _slice.num==ceil(_heal/2)
        && _chest.spr_dead==sprPizzaChestOpen && _chest.num==ceil(_chest_heal/2),
        "Pizza native HPPickup/HealthChest constructors failed active-area half-heal conversion")
    assert(_concrete.num==_slice.num && _concrete_chest.num==_chest.num,
        "Concrete Pizza/PizzaChest were converted twice by the native-family hook")
    var _tv=instance_create(36616,36016,NTTEFullPizzaTV)
    assert(instance_is(_tv,TV) && _tv.hp==15 && _tv.max_hp==15 && _tv.spr_hurt==scrNTTERefSprite("TVHurt"),
        "PizzaTV must retain native TV identity and original15HP/hurt artwork")
    assert(_tv.visible && _tv.sprite_index==sprTV && _tv.spr_idle==sprTV && sprite_exists(_tv.myscreen),
        "Real PizzaTV child lost the source TV cabinet or native valid channel before its inherited Draw")
    // Execute the genuine unchanged inherited TV Draw as a constructor-level
    // regression. The independent Lair observer also keeps the natural TV
    // alive through eight real scheduled Draw frames before destroying a drain.
    with(_tv) event_perform(ev_draw,0)
    _tv.tv=1; with(_tv) event_perform(ev_alarm,0)
    assert(array_get_index([sprTV1A,sprTV1B,sprTV1C],_tv.myscreen)>=0 && _tv.alarm[0]>=30 && _tv.alarm[0]<120,
        "PizzaTV real alarm lost channel1 selection or30..120tick schedule")
    var _corpse_count=instance_number(Corpse),_zap_count=instance_number(PortalL)
    _tv.hp=0; with(_tv) event_perform(ev_step,ev_step_begin)
    assert(instance_exists(_tv),"Native prop BeginStep deleted PizzaTV before its original EndStep death")
    with(_tv) event_perform(ev_step,ev_step_end)
    var _corpse=instance_nearest(36616,36016,Corpse)
    assert(!instance_exists(_tv) && instance_number(Corpse)==_corpse_count+1 && instance_number(PortalL)==_zap_count+2
        && _corpse.sprite_index==scrNTTERefSprite("TVHurt"),
        "PizzaTV actual EndStep lost one real corpse/two native electric zaps")
    var _flames=instance_number(GroundFlame),_cover=instance_create(36716,36016,NTTEFullPizzaManholeCover)
    assert(_cover.sprite_index==scrNTTERefSprite("Manhole") && _cover.image_speed==0 && _cover.depth==6
        && instance_number(GroundFlame)>=_flames+2 && instance_number(GroundFlame)<=_flames+4,
        "Pizza cover lost original stationary Manhole/depth/two-to-four ground smoke effects")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; GameCont.lastarea=_lastarea; GameCont.ntte_full_active_pizza=_active
    scrNTTESmokeLog("FULL PIZZA PROPS: actual native half-heal hooks/no double conversion,15HP TV source cabinet/valid channel/unchanged inherited Draw/alarm/EndStep corpse/two zaps, original cover smoke OK @"+string(30/timescale))
}
function scrNTTEFullPizzaSpiralSmoke() {
    var _before=scrNTTEFullInstances(all),_area=GameCont.area
    GameCont.area=scrNTTEFullAreaId("pizza")
    var _cont=instance_create(0,0,SpiralCont)
    assert(_cont.type==SpiralType.Venuz && !instance_exists(Spiral) && instance_exists(SpiralStar),
        "Pizza original NTTtype4 failed equivalent native Venuz star branch/reset/warmup")
    var _cover=noone
    with(SpiralDebris) if(sprite_index==scrNTTERefSprite("Manhole")) _cover=id
    assert(instance_exists(_cover) && _cover.image_index==5 && _cover.image_xscale>0,
        "Pizza spiral failed original airborne frame5 Manhole cover and actual native warmup")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area
    scrNTTESmokeLog("FULL PIZZA SPIRAL: original1-based NTTtype4 mapped to actual Venuz stars,30logicaltick warmup, original frame5 cover OK @"+string(30/timescale))
}
function scrNTTEFullPizzaNormalLifecycleSmoke(_inspect=false,_shadow104=false,_observer=undefined) {
    var _harness=id
    instance_deactivate_object(_harness)
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _tutorial=save_get_value("game","tutorial",true),_sync=variable_global_exists("ntte_full_sync_generation") ? global.ntte_full_sync_generation:false
    save_set_value("game","tutorial",false)
    scrCleanupAreaInstances()
    instance_destroy(NTTEFullPizzaManholeCover,false)
    instance_destroy(NTTEFullPortalPrevent,false)
    instance_destroy(NTTEFullCatLight,false)
    with(TopCont) { if(surface_exists(dark)) surface_free(dark); instance_destroy(id,false) }
    instance_destroy(SubTopCont,false)
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont)
    scrNTTEFullAreaNativeInit()
    GameCont.area=scrNTTEFullAreaId("pizza"); GameCont.subarea=1; GameCont.loops=0; GameCont.hard=9
    GameCont.crown=Crown.None; GameCont.noradch=0; GameCont.ntte_full_pending_destination=undefined
    GameCont.maxsubarea=1; GameCont.finalsubarea=true; GameCont.ntte_visits_pizza=0
    global.ntte_full_sync_generation=false
    if(_inspect) {
        global.seed=global.ntte_pizza78_seed;
        with(GameCont) scrRngStatesReset();
    }
    var _gen=instance_create(0,0,GenCont)
    assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation && _gen.goal==50 && !instance_exists(FloorMaker)
        && instance_number(Floor)==50 && _gen.turtle_den.cols==8 && _gen.turtle_den.rows==0,
        "Natural Pizza Create failed original8x6 den/50uniqueFloors/native FloorMaker completion")
    with(_gen) event_perform(ev_alarm,2)
    with(_gen) event_perform(ev_alarm,0)
    assert(instance_number(NTTEFullPizzaTV)==1 && instance_number(NTTEFullSewerDrain)==1 && instance_exists(TopSmall),
        "Natural Pizza population lost original one TV/one PizzaDrain/native tops")
    with(_gen) event_perform(ev_alarm,1)
    assert(!instance_exists(_gen) && GameCont.ntte_full_active_pizza && TopCont.darkness,
        "Natural Pizza Destroy failed active-area/darkness source lifecycle")
    assert(instance_number(NTTEFullTurtleCool)==5 && instance_number(NTTEFullPortalPrevent)==5,
        "Natural Pizza must contain four watching turtles/the rat and five actual neutral portal blockers")
    assert(instance_number(PizzaBox)==0 && instance_exists(NTTEFullPizzaManholeCover)
        && instance_number(NTTEFullCatDoor)==2 && instance_exists(NTTEFullCatLight),
        "Natural Pizza start lost box replacement/cover/two source doors/chest darkness lights")
    var _rat=0
    with(NTTEFullTurtleCool) if(ntte_full_become==Rat && spr_idle==sprRatIdle) _rat++
    assert(_rat==1,"Pizza squad lost the one actual Rat conversion and original Rat visuals")
    var _drain=instance_find(NTTEFullSewerDrain,0)
    assert(_drain.type=="area" && _drain.area==scrNTTEFullAreaId("lair") && _drain.ntte_full_hallway_size==320
        && _drain.spr_idle==scrNTTERefSprite("PizzaDrainIdle"),"Pizza drain lost real Lair destination/artwork/source320px hallway")
    if(_inspect) scrNTTEFullPizzaSpawn78Inspect();
    if(_shadow104) scrNTTEFullPizzaShadow104NaturalInspect();
    if(is_callable(_observer)) _observer();
    with(GameCont) event_perform(ev_other,ev_room_end)
    assert(GameCont.area==area_scrapyards && GameCont.subarea==1 && GameCont.ntte_visits_pizza==1 && !GameCont.ntte_full_active_pizza,
        "Actual Pizza RoomEnd failed sourceScrapyards1/visit/transit or native stage increment ran twice")
    scrCleanupAreaInstances()
    instance_destroy(NTTEFullPizzaManholeCover,false)
    instance_destroy(NTTEFullPortalPrevent,false)
    instance_destroy(NTTEFullCatLight,false)
    scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players)
    global.ntte_full_sync_generation=_sync; save_set_value("game","tutorial",_tutorial)
    instance_activate_object(_harness)
    scrNTTESmokeLog("FULL NATURAL PIZZA: real native50tile8x6den/population/start/darkness, five actual watchers/gates, real Lair drain/doors/cover/lights and RoomEndScrapyards1 OK @"+string(30/timescale))
}
