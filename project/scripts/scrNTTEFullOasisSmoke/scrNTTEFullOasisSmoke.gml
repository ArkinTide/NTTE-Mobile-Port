// Execute real native constructors and source lifecycle branches. Generation
// fixtures additionally require root's registered area/population hooks.
function scrNTTEFullOasisEntitiesSmoke() {
    var _before=scrNTTEFullInstances(all),_loops=GameCont.loops,_p=instance_find(Player,0),_px=_p.x,_py=_p.y,_rad=GameCont.rad
    GameCont.loops=0; _p.x=32016; _p.y=32016
    var _shark=instance_create(32216,32216,NTTEFullHammerShark)
    assert(_shark.hp==40 && _shark.raddrop==12 && _shark.meleedamage==4 && _shark.maxspeed==4 && _shark.walkspeed==0.8,
        "HammerShark constructor lost original40HP/12rads/4damage/4speed/0.8acceleration")
    _shark.ntte_hammer_alarm=100; _shark.walk=0; _shark.rotate=0; _shark.charge=10; _shark.charge_wait=0; _shark.charge_dir=0
    _shark.direction=sin(2)*20; _shark.speed=0
    with(_shark) scrNTTEFullHammerSharkStep()
    assert(abs(_shark.speed-3*timescale*timescale)*1000000<=1 && _shark.charge==10-timescale && _shark.sprite_index==_shark.spr_chrg,
        "HammerShark charge lost source acceleration, timer or charge sprite")
    var _coin=instance_create(_p.x,_p.y,NTTEFullSunkenCoin)
    _coin.speed=timescale
    with(_coin) assert(!scrNTTEFullSunkenCoinPull(_p) && !scrNTTEFullCustomPickupOpen(_p),"Moving sunken coin was collectible/attracted")
    assert(instance_exists(_coin),"Moving sunken coin disappeared")
    _coin.speed=0
    with(_coin) assert(scrNTTEFullSunkenCoinPull(_p) && scrNTTEFullCustomPickupOpen(_p),"Settled sunken coin could not be collected")
    var _prop=instance_create(32416,32416,NTTEFullOasisPetBecome),_prompt=_prop.prompt
    assert(_prop.hp==30 && _prop.raddrop==0 && _prop.team==0 && _prompt.text=="SHARE","Oasis pet shrine constructor/prompt changed")
    GameCont.rad=10; _prompt.pick=_p.index
    with(_prop) scrNTTEFullOasisPetBecomeStep()
    assert(GameCont.rad==0,"Oasis pet shrine did not charge ten radiation")
    var _traveler=instance_nearest(_p.x,_p.y,BigRad)
    assert(instance_exists(_traveler) && _traveler.ntte_full_rad_path.target==_prop && _prop.raddrop==0,
        "Oasis donation skipped actual BigRad travel before pet creation")
    _prompt.pick=-1; _prop.raddrop=10
    var _pets=instance_number(NTTEFullPet),_face=_prop.image_xscale
    with(_prop) scrNTTEFullOasisPetBecomeStep()
    assert(!instance_exists(_prop) && !instance_exists(_prompt) && instance_number(NTTEFullPet)==_pets+1,
        "Received donation failed actual Slaughterfish creation/prop/prompt cleanup")
    var _pet=instance_nearest(32416,32416,NTTEFullPet)
    assert(_pet.pet=="Slaughter" && _pet.right==_face,"Oasis gift changed pet species/facing")
    _prop=instance_create(32616,32616,NTTEFullOasisPetBecome); _prop.hp=0
    with(_prop) scrNTTEFullOasisPetBecomeStep()
    var _reviver=instance_nearest(32616,32616,NTTEFullOasisPetBecomeCorpse),_corpse=_reviver.inst
    assert(instance_exists(_corpse) && _corpse.sprite_index==scrNTTERefSprite("SlaughterPropDead") && _reviver.time==300,
        "Broken Oasis shrine failed actual corpse/300tick restoration")
    _reviver.time=0
    with(_reviver) scrNTTEFullOasisPetBecomeCorpseStep()
    assert(!instance_exists(_corpse) && instance_exists(NTTEFullOasisPetBecome),"Oasis shrine restoration failed real corpse replacement")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.loops=_loops; GameCont.rad=_rad; _p.x=_px; _p.y=_py
    scrNTTESmokeLog("FULL OASIS ENTITIES: HammerShark source charge, moving/settled treasure, actual BigRad donation/Slaughterfish and corpse restoration OK @"+string(30/timescale))
}
function scrNTTEFullSunkenChestSmoke() {
    var _before=scrNTTEFullInstances(all),_p=instance_find(Player,0),_px=_p.x,_py=_p.y,_area=GameCont.area,
        _count=scrNTTEFullValue(GameCont,"sunkenchests",0),_ultra=scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)
    GameCont.area=scrNTTEFullAreaId("coast"); _p.x=33016; _p.y=33016
    var _chest=instance_create(_p.x,_p.y,NTTEFullSunkenChest)
    assert(_chest.wep==wep_ntte_golden_trident && _chest.num==2 && !_chest.skeal,"Coast SunkenChest lost golden Trident/two ammo bundles")
    _chest.skeal=true; with(_chest) scrNTTEFullSunkenChestStep()
    assert(_chest.skeal==0 && instance_number(NTTEFullSunkenSealSpawn)==3,"Ancient treasure did not summon precisely three delayed guardians once")
    with(_chest) scrNTTEFullSunkenChestStep()
    assert(instance_number(NTTEFullSunkenSealSpawn)==3,"SunkenChest repeated its once-only ancient guards")
    var _seals=instance_number(NTTEFullSeal),_spawn=instance_find(NTTEFullSunkenSealSpawn,0),_type=_spawn.type,_sx=_spawn.x,_sy=_spawn.y
    _spawn.ntte_sunken_spawn_left=timescale
    with(_spawn) scrNTTEFullSunkenSealSpawnStep()
    var _seal=instance_nearest(_sx,_sy,NTTEFullSeal)
    assert(!instance_exists(_spawn) && instance_number(NTTEFullSeal)==_seals+1 && _seal.type==_type && _seal.skeal,
        "Delayed treasure guard failed actual Skeal/type transfer")
    var _coins=instance_number(NTTEFullSunkenCoin),_ammo=instance_number(NTTEFullBackpackPickup),_weps=instance_number(WepPickup)
    with(_chest) scrNTTEFullCustomChestOpen(_p)
    assert(!instance_exists(_chest) && instance_number(NTTEFullSunkenCoin)==_coins+20
        && instance_number(NTTEFullBackpackPickup)==_ammo+2 && instance_number(WepPickup)==_weps+1+_ultra,
        "SunkenChest lost original20coins/two real ammo packages/Steroids weapon count")
    assert(GameCont.sunkenchests>=GameCont.loops+1,"SunkenChest did not remember this loop's treasure")
    GameCont.area=scrNTTEFullAreaId("oasis")
    var _underwater=instance_create(33416,33416,NTTEFullSunkenChest)
    assert(_underwater.wep==wep_none,"Underwater treasure should select actual golden merged weapon on open")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    GameCont.area=_area; GameCont.sunkenchests=_count; _p.x=_px; _p.y=_py
    scrNTTESmokeLog("FULL SUNKEN CHEST: goldenTrident source, once-only three delayed real Skeals,20coins/two actual ammo packs, weapon count and per-loop treasure flag OK @"+string(30/timescale))
}
function scrNTTEFullOasisNormalLifecycleSmoke() {
    var _harness=id
    instance_deactivate_object(_harness)
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _tutorial=save_get_value("game","tutorial",true),_sync=variable_global_exists("ntte_full_sync_generation") ? global.ntte_full_sync_generation:false
    save_set_value("game","tutorial",false)
    scrCleanupAreaInstances()
    // Native cleanup enumerates its terrain/hitme families. The separate native
    // chestprop family and standalone SunkenRoom normally leave on room teardown;
    // this fixture manually
    // advances several logical frame rates within the same native room.
    instance_destroy(NTTEFullSunkenRoom,false)
    instance_destroy(chestprop,false)
    instance_destroy(Portal,false); instance_destroy(PortalClear,false); instance_destroy(PortalShock,false); instance_destroy(PortalL,false)
    with(TopCont) { if(surface_exists(dark)) surface_free(dark); instance_destroy(id,false) }
    instance_destroy(SubTopCont,false)
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont)
    scrNTTEFullAreaNativeInit()
    GameCont.area=scrNTTEFullAreaId("oasis"); GameCont.subarea=1; GameCont.loops=0; GameCont.hard=9
    GameCont.crown=Crown.None; GameCont.noradch=0; GameCont.sunkenchests=0; GameCont.ntte_full_pending_destination=undefined
    GameCont.maxsubarea=1; GameCont.finalsubarea=true; GameCont.ntte_visits_oasis=0
    global.ntte_full_sync_generation=false
    var _gen=instance_create(0,0,GenCont)
    assert(instance_exists(_gen) && !_gen.ntte_full_sync_generation && _gen.goal==130 && !instance_exists(FloorMaker)
        && instance_number(Floor)>20,"Natural Oasis Create failed actual130goal/native FloorMaker topology")
    with(_gen) event_perform(ev_alarm,2)
    with(_gen) event_perform(ev_alarm,0)
    assert(instance_number(enemy)>0 && instance_number(TopSmall)>0,"Natural Oasis population/terrain finalization missing")
    with(_gen) event_perform(ev_alarm,1)
    assert(!instance_exists(_gen) && GameCont.ntte_full_active_oasis && GameCont.underwater && !TopCont.darkness,
        "Natural Oasis Destroy lost source active/underwater/daylight lifecycle")
    assert(instance_number(NTTEFullManhole)==1,"Natural Oasis start failed actual one Trench crack; count="+string(instance_number(NTTEFullManhole)))
    assert(instance_number(NTTEFullSunkenChest)==1,"Natural Oasis start failed actual one secret treasure; count="+string(instance_number(NTTEFullSunkenChest)))
    assert(instance_number(NTTEFullSunkenRoom)==1,"Natural Oasis start failed actual one disconnected-room protection; count="+string(instance_number(NTTEFullSunkenRoom)))
    // Original area_start iterates one shuffled FloorNormal array and breaks
    // after its first eligible tile. Existence alone misses a shrine per tile.
    var _shrines=instance_number(NTTEFullOasisPetBecome)
    scrNTTESmokeLog("OASIS NATURAL SHRINE COUNT actual native GenCont.Destroy/area_start count="+string(_shrines)+" expected1 @"+string(30/timescale))
    assert(_shrines==1,"Natural Oasis must create exactly one source donation shrine; count="+string(_shrines))
    var _shrine=instance_find(NTTEFullOasisPetBecome,0)
    assert(_shrine.spr_idle==scrNTTERefSprite("SlaughterPropIdle") && _shrine.hp==30 && _shrine.raddrop==0
        && instance_exists(_shrine.prompt) && _shrine.prompt.text=="SHARE"
        && point_distance(_shrine.x,_shrine.y,10016,10016)>48,
        "One natural Oasis shrine lost original skull art/30HP/donation prompt or source spawn exclusion")
    var _hole=instance_find(NTTEFullManhole,0)
    assert(!_hole.visible && _hole.contact && _hole.area==scrNTTEFullAreaId("trench") && _hole.subarea==1,
        "Oasis crack must reveal after clearing and select finalTrench1")
    with(GameCont) event_perform(ev_other,ev_room_end)
    assert(GameCont.area==area_scrapyards && GameCont.subarea==3 && GameCont.ntte_visits_oasis==1 && !GameCont.ntte_full_active_oasis,
        "Actual Oasis RoomEnd failed sourceScrapyards3/visit count/transit; native stage increment ran twice")
    GameCont.area=scrNTTEFullAreaId("oasis"); GameCont.subarea=1; GameCont.ntte_full_active_oasis=true
    // The source hidden crack is revealed by the cleared room's actual Portal.
    // Test that prerequisite instead of forcing visibility in a live encounter.
    instance_destroy(enemy,false)
    var _reveal_portal=instance_create(_hole.x+128,_hole.y,Portal)
    with(_hole) scrNTTEFullManholeStep()
    assert(_hole.visible,"Cleared Oasis crack did not reveal from the actual native Portal")
    var _player=instance_find(Player,0)
    _player.x=_hole.x; _player.y=_hole.y; _hole.image_index=_hole.image_number-1
    assert(!lockstep_stop,"Oasis crack fixture reached contact while native lockstep stopped")
    with(_hole) assert(place_meeting(x,y,Player),"Oasis crack contact lacks actual Player collision after placement")
    with(_hole) scrNTTEFullManholeStep()
    assert(!instance_exists(_hole),"Actual Oasis crack contact did not finish its final-frame opening")
    assert(is_struct(GameCont.ntte_full_pending_destination),"Actual Oasis crack death did not select any portal destination")
    assert(GameCont.ntte_full_pending_destination.area==scrNTTEFullAreaId("trench") && GameCont.ntte_full_pending_destination.subarea==1,
        "Actual Oasis crack death did not create finalTrench1 portal destination")
    with(GameCont) event_perform(ev_other,ev_room_end)
    assert(GameCont.area==scrNTTEFullAreaId("trench") && GameCont.subarea==1 && !GameCont.ntte_full_active_oasis,
        "Actual Oasis crack RoomEnd lost Trench1 destination or leaked underwater active flag")
    scrCleanupAreaInstances(); instance_destroy(NTTEFullPet,false); instance_destroy(NTTEFullSunkenRoom,false)
    instance_destroy(chestprop,false)
    instance_destroy(Portal,false); instance_destroy(PortalClear,false); instance_destroy(PortalShock,false); instance_destroy(PortalL,false)
    scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players)
    global.ntte_full_sync_generation=_sync; save_set_value("game","tutorial",_tutorial)
    instance_activate_object(_harness)
    scrNTTESmokeLog("FULL NATURAL OASIS: real native generation/population/start/130goal/underwater/treasure/shrine/crack, actual RoomEndScrapyards3 and crack-toTrench1 OK @"+string(30/timescale))
}
