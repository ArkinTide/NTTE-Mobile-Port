// Normal engine frames, actual Heart exits and delayed portal alarms.
function scrNTTEFullQuestAreaPopulationNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Area population requires explicit desktop smoke")
    var _observer=instance_create(0,0,NTTEFullQuestAreaPopulationNaturalTest)
    with(_observer) {
        state=scrNTTEFullWorldEventsNaturalWorldCapture()
        old_heart_context=variable_global_exists("ntte_full_heart_generation_context")?global.ntte_full_heart_generation_context:undefined
        player=instance_find(Player,0);test_skills=ds_list_create()
        destinations=[area_vault,area_palace,area_hq,scrNTTEFullAreaId("red")]
        goals=[2,12,8,10];rewards=[RadChest,AmmoChest,IDPDChest,HealthChest]
        case_index=0;phase=0;elapsed=0;totals=[0,0,0,0];rows=[];heart=noone;visible=false
    }
}
function scrNTTEFullQuestAreaPopulationNaturalConfigure() {
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    scrNTTEFullAreaGeneratorRestore(state.game);scrNTTEFullAreaGeneratorRestore(state.players)
    GameCont.skills=test_skills;GameCont.ntte_full_native_skill_counts={}
    global.ntte_full_progress=json_parse(json_stringify(state.progress))
    global.ntte_full_sync_generation=false;global.ntte_full_heart_generation_context=undefined
    GameCont.area=area_vault;GameCont.subarea=0;GameCont.loops=0
    GameCont.maxsubarea=scrAreaGetMaxSubarea(area_vault);GameCont.finalsubarea=false
    GameCont.crown=Crown.None;GameCont.crownvisits=0;GameCont.gocrib=false;GameCont.proto=false
    GameCont.hard=5;GameCont.nochest=0;GameCont.noradch=0;GameCont.popolevel=0
    GameCont.rad=0;GameCont.level=1;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0
    GameCont.underwater=false;GameCont.killenemies=false;save_set_value("game","tutorial",false)
    UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_bossintro=false;UberCont.opt_freeze=0
    with(player) {
        x=10016;y=10016;xprevious=x;yprevious=y;speed=0;race=Race.Fish
        wep=wep_revolver;bwep=wep_none;ntte_state=undefined;bntte_state=undefined
        hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000
        can_walk=false;can_aim=false;can_pick=false;visible=true
    }
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
    instance_create(10000,10000,Floor)
    area_index=case_index div 3;case_seed=63301+case_index*101
    for(var _i=0;_i<array_length(global.rng_state);++_i) global.rng_state[@_i]=case_seed+_i*997
    random_set_seed(case_seed)
    heart=instance_create(10016,10016,NTTEFullCrystalHeartBullet)
    heart.area=destinations[area_index];heart.subarea=0;heart.loops=0
    heart.area_goal=goals[area_index];heart.area_chest=[rewards[area_index]]
    heart.direction=0;heart.depth=-3;heart.area_seed=case_seed
    heart_start=[heart.x,heart.y];travel_seen=false;live_steps=0
    seen=[];initial_police=[];portals=[];portal_alarm_seen=false;delayed_police_seen=false
    phase=1;elapsed=0
}
function scrNTTEFullQuestAreaPopulationNaturalIsPolice(_enemy) {
    return instance_is(_enemy,Grunt) || instance_is(_enemy,EliteGrunt)
        || instance_is(_enemy,Shielder) || instance_is(_enemy,EliteShielder)
        || instance_is(_enemy,Inspector) || instance_is(_enemy,EliteInspector) || instance_is(_enemy,PopoFreak)
}
function scrNTTEFullQuestAreaPopulationNaturalRecord() {
    var _enemies=scrNTTEFullInstances(enemy)
    for(var _i=0;_i<array_length(_enemies);++_i) {
        var _enemy=_enemies[_i],_eligible=false
        switch(area_index) {
            case 0:_eligible=instance_is(_enemy,CrownGuardian);break
            case 1:_eligible=instance_is(_enemy,Guardian) || instance_is(_enemy,DogGuardian)
                || instance_is(_enemy,ExploGuardian) || scrNTTEFullQuestAreaPopulationNaturalIsPolice(_enemy);break
            case 2:_eligible=scrNTTEFullQuestAreaPopulationNaturalIsPolice(_enemy);break
            case 3:_eligible=instance_is(_enemy,NTTEFullRedSpider)
                || instance_is(_enemy,NTTEFullCrystalBrain) || instance_is(_enemy,Bandit);break
        }
        if(_eligible && array_get_index(seen,_enemy)<0) array_push(seen,_enemy)
        if(area_index==2 && scrNTTEFullQuestAreaPopulationNaturalIsPolice(_enemy)
            && array_get_index(initial_police,_enemy)<0) delayed_police_seen=true
    }
    for(var _i=0;_i<array_length(portals);++_i) if(instance_exists(portals[_i])) {
        var _portal=portals[_i]
        if(_portal.alarm[1]>0 && _portal.sprite_index==sprIDPDPortalClose) portal_alarm_seen=true
    }
}
function scrNTTEFullQuestAreaPopulationNaturalFinish() {
    var _state=state,_skills=test_skills,_context=old_heart_context
    scrNTTEFullWorldEventsNaturalWorldRestore(_state);global.ntte_full_heart_generation_context=_context
    if(ds_exists(_skills,ds_type_list)) ds_list_destroy(_skills)
    assert(random_get_seed()==_state.seed,"Area population fixture leaked engine RNG")
    for(var _i=0;_i<array_length(_state.rng);++_i)
        assert(global.rng_state[_i]==_state.rng[_i],"Area population fixture leaked independent RNG")
}
function scrNTTEFullQuestAreaPopulationNaturalBegin() {
    try {
        if(phase==0) scrNTTEFullQuestAreaPopulationNaturalConfigure()
        elapsed+=timescale
        assert(elapsed<600,"Natural area Heart/IDPD chain timed out case="+string(case_index))
        with(player) {hp=100000;max_hp=100000;lsthealth=100000;nexthurt=current_frame+100000;can_walk=false;can_aim=false;can_pick=false;speed=0}
    } catch(_error) {scrNTTEFullQuestAreaPopulationNaturalFinish();throw _error}
}
function scrNTTEFullQuestAreaPopulationNaturalEndBody() {
    if(phase==1) {
        if(instance_exists(heart)) {
            live_steps++
            if(point_distance(heart.x,heart.y,heart_start[0],heart_start[1])>1) travel_seen=true
            return;
        }
        assert(live_steps>1 && travel_seen && elapsed>=12,"Area Heart ended without actual timer/motion/normal Steps")
        assert(instance_number(Floor)>1,"Natural area Heart exit produced no appended terrain")
        assert(GameCont.area==area_vault && GameCont.subarea==0 && GameCont.loops==0
            && !instance_exists(GenCont) && !scrNTTEFullCrystalHeartPopulation(),"Natural generation leaked destination or spawn-safety scope")
        portals=scrNTTEFullInstances(IDPDSpawn)
        var _enemies=scrNTTEFullInstances(enemy)
        for(var _i=0;_i<array_length(_enemies);++_i)
            if(scrNTTEFullQuestAreaPopulationNaturalIsPolice(_enemies[_i])) array_push(initial_police,_enemies[_i])
        if(area_index==2) assert(array_length(portals)>=2,"HQ Heart omitted authored two real IDPD portals")
        scrNTTEFullQuestAreaPopulationNaturalRecord();phase=2;elapsed=0;return;
    }
    if(phase!=2) return;
    scrNTTEFullQuestAreaPopulationNaturalRecord()
    if(elapsed<120) return;
    if(area_index==2) assert(portal_alarm_seen && delayed_police_seen,"HQ Heart omitted actual portal Alarm/new police witness")
    totals[area_index]+=array_length(seen)
    var _types=[]
    for(var _i=0;_i<array_length(seen);++_i) if(instance_exists(seen[_i])) array_push(_types,object_get_name(seen[_i].object_index))
    var _row={case_index:case_index,area:destinations[area_index],seed:case_seed,goal:goals[area_index],
        natural_live_steps:live_steps,travel:travel_seen,population:array_length(seen),enemy_ids:seen,enemy_types:_types,
        portal_count:array_length(portals),actual_portal_alarm:portal_alarm_seen,delayed_police:delayed_police_seen}
    array_push(rows,_row);scrNTTESmokeLog("QUEST AREA POPULATION LIVE "+json_stringify(_row))
    case_index++
    if(case_index<12) {phase=0;elapsed=0;return;}
    for(var _i=0;_i<4;++_i) assert(totals[_i]>0,"Three natural unfoldings produced no source enemy for area="+string(destinations[_i]))
    scrNTTEFullQuestAreaPopulationNormalSafety()
    var _totals=totals
    scrNTTEFullQuestAreaPopulationNaturalFinish()
    scrNTTESmokeLog("FULL QUEST AREA POPULATION NATURAL: twelve actual Heart timer/motion/exits, native Vault/Palace/HQ/Red populations, real HQ alarms and restored RNG OK @"+string(30/timescale)+" totals="+json_stringify(_totals))
    instance_destroy(id,false)
}
function scrNTTEFullQuestAreaPopulationNaturalEnd() {
    try {scrNTTEFullQuestAreaPopulationNaturalEndBody()}
    catch(_error) {scrNTTEFullQuestAreaPopulationNaturalFinish();throw _error}
}
function scrNTTEFullQuestAreaPopulationNormalSafety() {
    scrNTTEFullMergedRuntimeTestCleanup(state.before)
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0
    GameCont.maxsubarea=scrAreaGetMaxSubarea(area_desert);GameCont.finalsubarea=false
    global.ntte_full_heart_generation_context=undefined
    var _sync=global.ntte_full_sync_generation,_generator=noone
    try {global.ntte_full_sync_generation=true;_generator=instance_create(0,0,GenCont)}
    finally {global.ntte_full_sync_generation=_sync}
    var _owned=scrNTTEFullInstances(all)
    for(var _i=array_length(_owned)-1;_i>=0;--_i)
        if(_owned[_i]!=_generator && array_get_index(state.before,_owned[_i])<0) instance_destroy(_owned[_i],false)
    with(_generator) for(var _i=0;_i<12;++_i) alarm[_i]=-1
    var _near=instance_create(10144,10000,Floor),_far=instance_create(10224,10000,Floor)
    _near.spawnarea=area_desert;_far.spawnarea=area_desert
    var _variants=[{context:undefined,set_area:false,safedist:0},
        {context:{goal:2,angle:0,seed:1},set_area:true,safedist:0},
        {context:{goal:2,angle:0,seed:1},set_area:false,safedist:120}]
    for(var _v=0;_v<array_length(_variants);++_v) {
        var _variant=_variants[_v]
        global.ntte_full_heart_generation_context=_variant.context
        _generator.ntte_full_set_area=_variant.set_area;_generator.safedist=_variant.safedist
        var _seed=random_get_seed(),_rng=json_stringify(global.rng_state)
        repeat(8) assert(!scrNTTEFullCrystalHeartPopulation(),"Heart bypass leaked into ordinary/stale/unsafe scope")
        assert(random_get_seed()==_seed && json_stringify(global.rng_state)==_rng,"Heart scope predicate consumed RNG")
        var _count=instance_number(enemy)
        with(_near) scrPopEnemies()
        assert(instance_number(enemy)==_count,"Ordinary160px safe-spawn exclusion was bypassed")
    }
    global.ntte_full_heart_generation_context={goal:2,angle:0,seed:1}
    _generator.ntte_full_set_area=false;_generator.safedist=0
    assert(scrNTTEFullCrystalHeartPopulation(),"Genuine Heart scope failed to opt into population")
    var _count=instance_number(enemy)
    with(_near) scrPopEnemies()
    assert(instance_number(enemy)>_count,"Scoped near-origin Floor population remained excluded")
    instance_destroy(enemy,false)
    instance_create(_near.x,_near.y,Wall)
    with(_near) scrPopEnemies()
    assert(instance_number(enemy)==0,"Heart bypass disabled Wall collision safety")
    global.ntte_full_heart_generation_context=undefined;_generator.ntte_full_set_area=true
    assert(!scrNTTEFullCrystalHeartPopulation(),"Heart scope failed to end")
    with(_far) scrPopEnemies()
    assert(instance_number(enemy)>0,"Ordinary far-origin population was disabled")
    scrNTTESmokeLog("QUEST AREA POPULATION ordinary/stale scope negatives, unchanged RNG, actual near160 rejection/far population and Wall guard OK")
}
