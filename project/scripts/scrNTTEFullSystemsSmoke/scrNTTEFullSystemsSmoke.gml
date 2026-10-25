// Called by the desktop regression harness after creating GameCont/Player.
// These tests cover real state/effects; unresolved factories are not hidden.
function scrNTTEFullSystemsCrimeTests() {
    var _seed=random_get_seed(),_hard=GameCont.hard,_loops=GameCont.loops,_crown=GameCont.crown
    GameCont.crown=NTTEFullCrown.Crime
    var _count=scrNTTEFullValue(GameCont,"ntte_crime_enemy_count",0)
    var _delay=scrNTTEFullValue(GameCont,"ntte_crime_enemy_delay",0)
    var _initial=[]
    for(var _i=0;_i<instance_number(all);++_i) array_push(_initial,instance_find(all,_i))
    var _names=["Gator","BabyGator","BuffGator","BoneGator","AlbinoGator"],_gates=[0,0,4,6,8],_tiers=[0,4,6,8]
    random_set_seed(170720)
    // Pool membership/progression is tested independently of actual object construction.
    for(var _hard_index=0;_hard_index<4;++_hard_index) {
        GameCont.hard=_tiers[_hard_index]
        var _seen=[false,false,false,false,false]
        repeat(1024) {
            var _name=scrNTTEFullCrimePool(),_which=array_get_index(_names,_name)
            assert(_which>=0 && GameCont.hard>=_gates[_which],"Crime pool selected an unknown/premature enemy")
            _seen[_which]=true
        }
        for(var _j=0;_j<5;++_j) assert(_seen[_j]==(GameCont.hard>=_gates[_j]),"Crime pool omitted a source progression tier")
    }
    var _p=instance_find(Player,0)
    // Gator's native Create intentionally promotes itself to BuffGator using
    // GameCont.hard. Exercise that replacement path at an isolated point and
    // verify the wrapper owns the replacement rather than a stale Gator.
    GameCont.hard=30; GameCont.loops=1
    var _promote_x=_p.x+64,_promote_y=_p.y+64
    var _existing_buff=instance_create(_promote_x,_promote_y,BuffGator)
    var _promoted=scrNTTEFullTopCreate(_promote_x,_promote_y,"Gator",0,0)
    assert(instance_exists(_promoted) && instance_exists(_promoted.target)
        && instance_is(_promoted.target,BuffGator) && _promoted.target!=_existing_buff,
        "Hard Gator promotion lost its new BuffGator Top owner or captured a same-position old BuffGator")
    var _gator_same=0
    with(Gator) if(point_distance(x,y,_promote_x,_promote_y)<2) { _gator_same+=1 }
    assert(_gator_same==0,"Hard Gator promotion left an unwrapped Gator at replacement position")
    // Keep wave construction deterministic after the explicit hard branch.
    GameCont.hard=0
    // Every eligible concrete enemy must resolve and enter the real Top wrapper.
    for(var _i=0;_i<5;++_i) {
        var _top=scrNTTEFullTopCreate(_p.x,_p.y,_names[_i],90,16)
        assert(instance_exists(_top) && instance_exists(_top.target) && instance_is(_top.target,enemy),
            "Crime actual enemy factory/Top chain failed: "+_names[_i])
        assert(_top.target.ntte_full_top_object==_top,"Crime enemy lost its landing wrapper owner")
    }
    // Exercise the exact delayed wave path, including alert/smoke/notice FX.
    repeat(4) {
        GameCont.ntte_crime_enemy_count=1; GameCont.ntte_crime_enemy_delay=0
        var _before=instance_number(NTTEFullTopObject)
        scrNTTEFullCrimeStep()
        assert(GameCont.ntte_crime_enemy_count==0 && GameCont.ntte_crime_enemy_delay>=120
            && GameCont.ntte_crime_enemy_delay<=180,"Crime wave counter/delay changed")
        assert(instance_number(NTTEFullTopObject)>=_before+2,"Crime wave failed its two real enemy spawns")
    }
    GameCont.ntte_crime_enemy_delay=20
    scrNTTEFullCrimeStep()
    assert(abs(GameCont.ntte_crime_enemy_delay-(20-timescale))<0.0001,"Crime delay did not use logical time")
    // New-only cleanup avoids enemy Destroy effects and preserves the harness fixture.
    for(var _i=instance_number(all)-1;_i>=0;--_i) {
        var _inst=instance_find(all,_i)
        if(array_get_index(_initial,_inst)<0 && instance_exists(_inst)) instance_destroy(_inst,false)
    }
    GameCont.hard=_hard; GameCont.loops=_loops; GameCont.crown=_crown
    GameCont.ntte_crime_enemy_count=_count; GameCont.ntte_crime_enemy_delay=_delay
    random_set_seed(_seed)
    scrNTTESmokeLog("SYSTEMS CRIME SPAWNS: source pool gates, all five actual enemy factories/Top owners, wave count/delay/FX OK; shop/NPC/smuggled-goods outside this test")
}

function scrNTTEFullSystemsStateTests() {
    assert(instance_exists(GameCont) && instance_exists(Player),"Systems tests require a live game/player")
    scrNTTEFullSystemsInit()
    var _snapshot=json_stringify(scrNTTEFullSystemsExport())
    var _native_size=ds_list_size(GameCont.skills),_pets=GameCont.ntte_pet_max
    GameCont.ntte_full_skills={}; GameCont.ntte_full_skill_order=[]
    GameCont.ntte_full_native_skill_counts={}; GameCont.ntte_pet_max=1
    var _player=instance_find(Player,0),_had_player_max=variable_instance_exists(_player,"ntte_pet_max")
    var _player_max=scrNTTEFullValue(_player,"ntte_pet_max",undefined)
    _player.ntte_pet_max=1
    scrNTTEFullSkillSet("compassion",2)
    assert(scrNTTEFullSkillGet(NTTEFullSkill.Compassion)==2 && GameCont.ntte_pet_max==3 && _player.ntte_pet_max==3,
        "Compassion must apply the numeric delta to existing global and player slots")
    scrNTTEFullSkillSet(NTTEFullSkill.Compassion,3)
    assert(GameCont.ntte_pet_max==4 && _player.ntte_pet_max==4,"Compassion reapplication duplicated a prior grant")
    scrNTTEFullSkillSet("compassion",0)
    assert(GameCont.ntte_pet_max==1 && _player.ntte_pet_max==1,"Compassion removal failed to reverse its delta")
    assert(ds_list_size(GameCont.skills)==_native_size,"Extension skill state modified legacy native skill IDs/list")
    assert(!scrNTTEFullSkillAvailable("annihilation") && !scrNTTEFullSkillAvailable("reroll"),"Hidden mutations leaked into regular rolls")
    var _rats=["bat ears","lead ribs","magnetic pulse","toad breath"]
    for(var _i=0;_i<4;++_i) {
        assert(!scrNTTEFullSkillAvailable(_rats[_i]) && scrNTTEFullSkillAvailable(_rats[_i],true),"Rat-only mutation availability changed")
        assert(scrNTTEFullSkillId(_rats[_i])>=30,"String mutation key lost its native extension ID")
    }
    scrNTTEFullSkillSet("silver tongue",1)
    assert(scrNTTEFullSkillAvailable("silver tongue"),"Held Silver Tongue should be available")
    var _serialized=json_stringify(scrNTTEFullSystemsExport())
    GameCont.ntte_full_skills={}; GameCont.ntte_full_skill_order=[]
    assert(scrNTTEFullSystemsImport(json_parse(_serialized)) && scrNTTEFullSkillGet("silver tongue")==1,
        "JSON run export/import lost string keys or stack values")
    assert(ds_list_size(GameCont.skills)==_native_size+1 && ds_list_find_index(GameCont.skills,NTTEFullSkill.SilverTongue)>=0,
        "Run import failed to synchronize the extended mutation ID without replaying its take effect")
    assert(!scrNTTEFullSystemsImport({schema:9}),"Unknown run schema must not mutate current run")
    scrNTTEFullSystemsImport(json_parse(_snapshot))
    GameCont.ntte_pet_max=_pets
    if(_had_player_max) _player.ntte_pet_max=_player_max
    else _player.ntte_pet_max=undefined
    scrNTTESmokeLog("SYSTEMS STATE: numeric pet delta, hidden/rat-only availability, legacy IDs, JSON continuation, schema guard OK")
}

function scrNTTEFullSystemsNativeStackTests() {
    var _p=instance_find(Player,0),_old=scr_skill_get(mut_rhino_skin)
    var _hp=_p.hp,_max=_p.max_hp,_size=ds_list_size(GameCont.skills)
    scr_skill_set(mut_rhino_skin,_old+2)
    assert(scr_skill_get(mut_rhino_skin)==_old+2 && _p.hp==_hp+8 && _p.max_hp==_max+8,
        "Native Rhino Skin stack lost numeric state or applied a boolean effect")
    var _count=0
    for(var _i=0;_i<ds_list_size(GameCont.skills);++_i) if(GameCont.skills[|_i]==mut_rhino_skin) { _count+=1 }
    assert(_count==1,"Native mutation stacking duplicated/corrupted DS-list IDs")
    scr_skill_set(mut_rhino_skin,_old)
    assert(_p.hp==_hp && _p.max_hp==_max && ds_list_size(GameCont.skills)==_size,
        "Native mutation removal failed to reverse the effect delta")
    _old=scr_skill_get(mut_eagle_eyes)
    var _accuracy=_p.accuracy
    scr_skill_set(mut_eagle_eyes,_old+2)
    assert(abs(_p.accuracy-_accuracy*0.16)<0.0001,"Eagle Eyes stack did not apply multiplicative count")
    scr_skill_set(mut_eagle_eyes,_old)
    assert(abs(_p.accuracy-_accuracy)<0.0001,"Eagle Eyes removal did not reverse its exact count")
    scrNTTESmokeLog("SYSTEMS NATIVE STACKS: numeric getter/setter, DS IDs, Rhino HP delta and Eagle accuracy reversal OK")
}

function scrNTTEFullSystemsOrchidTests() {
    var _p=instance_find(Player,0),_base=scr_skill_get(mut_rhino_skin),_hp=_p.hp,_max=_p.max_hp
    var _timer=instance_create(0,0,NTTEFullOrchidSkill)
    _timer.skill=mut_rhino_skin; _timer.num=2; _timer.time=60
    with(_timer) scrNTTEFullOrchidSetup()
    assert(scr_skill_get(mut_rhino_skin)==_base+2 && _p.max_hp==_max+8 && _timer.time_max==60,
        "Orchid failed numeric native mutation grant / time initialization")
    instance_destroy(_timer)
    assert(scr_skill_get(mut_rhino_skin)==_base && _p.max_hp==_max && _p.hp==_hp,
        "Orchid expiration failed owned-count reversal or HP preservation")
    var _enemy=instance_create(_p.x+100,_p.y,Bandit)
    _enemy.hp=100; _enemy.max_hp=100
    _timer=instance_create(0,0,NTTEFullOrchidSkill)
    _timer.skill=mut_scarier_face; _timer.num=2; _timer.type="portal"
    with(_timer) scrNTTEFullOrchidSetup()
    assert(_enemy.hp==64 && _enemy.max_hp==64 && _timer.time==2,"Orchid Scarier Face stacking / portal default changed")
    scrNTTEFullOrchidPortalTick()
    assert(_timer.time==1,"Portal mutation timer did not lose exactly one area")
    instance_destroy(_timer)
    assert(_enemy.hp==100 && _enemy.max_hp==100,"Orchid failed to restore existing enemy HP")
    instance_destroy(_enemy,false)
    _timer=instance_create(0,0,NTTEFullOrchidSkill)
    _timer.skill=mut_hammerhead; _timer.num=2
    var _hammer=_p.hammerhead
    with(_timer) scrNTTEFullOrchidSetup()
    assert(_p.hammerhead==_hammer+40 && _timer.time==600,"Orchid Hammerhead grant / 20-second default changed")
    instance_destroy(_timer)
    assert(_p.hammerhead==_hammer,"Orchid Hammerhead expiration removed unrelated points")
    _timer=instance_create(0,0,NTTEFullOrchidSkill)
    _timer.skill=mut_rhino_skin; _timer.num=2; _timer.time=57.25
    with(_timer) scrNTTEFullOrchidSetup()
    var _save=json_parse(json_stringify(scrNTTEFullOrchidExport())),_boosted_hp=_p.hp,_boosted_max=_p.max_hp
    assert(scrNTTEFullOrchidImport(_save),"Orchid continuation schema failed")
    _timer=instance_find(NTTEFullOrchidSkill,0)
    assert(instance_exists(_timer) && _timer.time==57.25 && !_timer.setup && _timer.ntte_applied
        && scr_skill_get(mut_rhino_skin)==_base+2 && _p.hp==_boosted_hp && _p.max_hp==_boosted_max,
        "Orchid continuation replayed a grant, lost time, or failed owner rebinding")
    instance_destroy(_timer)
    assert(scr_skill_get(mut_rhino_skin)==_base && _p.max_hp==_max,"Restored Orchid timer did not revoke exactly once")
    var _old_tokens=scrNTTEFullValue(_p,"bonus_spirit",[]),_token={active:true}
    _p.bonus_spirit=[_token]
    _timer=instance_create(0,0,NTTEFullOrchidSkill)
    _timer.skill=mut_strong_spirit; _timer.num=0; _timer.setup=false; _timer.spirit=[_token]
    GameCont.annihilation_skill=_timer
    _save=json_parse(json_stringify(scrNTTEFullOrchidExport()))
    _p.bonus_spirit=json_parse(json_stringify(_p.bonus_spirit))
    scrNTTEFullOrchidImport(_save)
    _timer=instance_find(NTTEFullOrchidSkill,0)
    assert(GameCont.annihilation_skill==_timer && array_length(_timer.spirit)==1,
        "Orchid continuation lost annihilation/timer or shared spirit ownership")
    instance_destroy(_timer)
    assert(!_p.bonus_spirit[0].active,"Restored Orchid expiration failed to revoke the player's shared token")
    _p.bonus_spirit=_old_tokens; GameCont.annihilation_skill=noone
    assert(!scrNTTEFullOrchidImport({schema:99}),"Unknown Orchid schema modified live timers")
    scrNTTESmokeLog("SYSTEMS ORCHID: numeric stacks/HP, Scarier Face, portal/Hammerhead, JSON timer continuation without regrant, shared spirit owner/expiration OK")
}

function scrNTTEFullSystemsSkinTests() {
    var _progress=global.ntte_full_progress,_ready=variable_global_exists("ntte_full_feature_ready") ? global.ntte_full_feature_ready:{}
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    var _native=json_stringify(UberCont.cskingot),_buffer=buffer_create(16,buffer_fixed,1)
    var _prefixes=["FishAngler","EyesBat","RobotBonus","YVCoat","FrogCool","PlantOrchid","CrystalRed"]
    for(var _skin=200;_skin<=206;++_skin) {
        var _key=scrNTTEFullSkinKey(_skin),_race=scrRaceGetNumericID(scrNTTEFullSkinRace(_key))
        var _native_slots=scrRaceGetMaxSkinCount(_race),_prefix=_prefixes[_skin-200]
        assert(scrNTTEFullSkinNativeId(_key)==_skin && !scr_race_is_skin_unlocked(_race,_skin),"Extension skin key/ID/unlock gate changed")
        assert(array_length(scrNTTEFullSkinSlots(_race))==_native_slots,"Unready skin appeared in native menu")
        variable_struct_set(global.ntte_full_feature_ready,"skin:"+_key,true)
        var _slots=scrNTTEFullSkinSlots(_race)
        assert(array_length(_slots)==_native_slots+1 && _slots[_native_slots]==_skin,"Extension skin failed to append without native renumbering")
        variable_struct_set(global.ntte_full_progress.unlocks,"skin:"+_key,true)
        variable_struct_set(global.ntte_full_progress.loadouts,"skin:"+string(_race),_key)
        assert(scr_race_is_skin_unlocked(_race,_skin) && scr_loadout_race_get_skin(_race)==_skin,"Unlocked skin loadout did not round-trip stable key")
        assert(scr_race_get_sprite(_race,"Idle",-1,_skin)==scrNTTERefSprite(_prefix+"Idle"),"Native player idle differs from source skin mapping")
        assert(scrNTTEFullSkinMenuSprite(_race,_skin,sprMapIcon)==scrNTTERefSprite(_prefix+"MapIcon"),"Skin map icon differs from source mapping")
        assert(scrNTTEFullSkinMenuSprite(_race,_skin,sprBigPortrait)==scrNTTERefSprite(_prefix+"Portrait"),"Skin portrait differs from source mapping")
        assert(string_length(scrNTTEFullSkinLock(_key))>0 && string_length(scrNTTEFullSkinUnlockText(_key))>0,"Skin lock/unlock description missing")
        buffer_write(_buffer,buffer_u8,_skin)
    }
    buffer_seek(_buffer,buffer_seek_start,0)
    for(var _skin=200;_skin<=206;++_skin) assert(buffer_read(_buffer,buffer_u8)==_skin,"Extension skin does not fit native session byte format")
    buffer_delete(_buffer)
    assert(json_stringify(UberCont.cskingot)==_native,"Extension skin state touched original cskingot storage")
    var _p=instance_find(Player,0),_old_race=_p.race,_old_skin=_p.bskin,_old_ammo=_p.ammo
    var _old_inf=_p.infammo,_old_weapon=_p.wep,_old_reload=_p.reload,_old_ntte=_p.ntte_state
    var _projectiles=[]
    with(projectile) array_push(_projectiles,id)
    // Real firing passes through native scrFire and changes only newborn
    // projectiles owned by the custom-skinned player.
    for(var _skin=200;_skin<=206;++_skin) {
        _p.race=scrRaceGetNumericID(scrNTTEFullSkinRace(scrNTTEFullSkinKey(_skin)))
        _p.bskin=_skin; _p.wep=wep_golden_crossbow; _p.infammo=true
        with(_p) scrFire(wep_golden_crossbow,false)
        var _expected=scrNTTEFullSkinTargetSprite(_p,sprBoltGold,"weapon"),_found=false
        with(projectile) if(array_get_index(_projectiles,id)<0 && creator==_p) {
            if(sprite_index==_expected) _found=true
            instance_destroy(id,false)
        }
        assert(_found,"Actual native golden crossbow shot did not receive custom skin mapping")
    }
    _p.race=_old_race; _p.bskin=_old_skin; _p.ammo=_old_ammo; _p.infammo=_old_inf
    _p.wep=_old_weapon; _p.reload=_old_reload; _p.ntte_state=_old_ntte
    global.ntte_full_progress=_progress; global.ntte_full_feature_ready=_ready
    scrNTTESmokeLog("SYSTEMS SKINS: 7 source idle/map/portrait mappings and real crossbow shots, stable byte IDs, unlock/loadout keys, native array preservation and ready gates OK")
}

function scrNTTEFullSystemsEffectTests() {
    var _snapshot=json_stringify(scrNTTEFullSystemsExport()),_player=instance_find(Player,0)
    var _old_x=_player.x,_old_y=_player.y,_old_team=_player.team,_old_speed=_player.speed
    GameCont.ntte_full_skills={}; GameCont.ntte_full_skill_order=[]
    // Actual native enemy data exercises EMP's <4 size and team gates.
    var _enemy=instance_create(_player.x+80,_player.y,Bandit),_dead=0
    scrNTTEFullSkillSet("magnetic pulse",1)
    var _seed=random_get_seed(); random_set_seed(170719)
    repeat(512) {
        _enemy.team=team_popo; _enemy.size=1; _enemy.hp=100; _enemy.max_hp=100
        scrNTTEFullMagneticPulseSetup(_enemy)
        _dead+=_enemy.hp<=0
    }
    assert(_dead>185 && _dead<330,"EMP probability diverged from original 1-1/(2^n)")
    _enemy.size=4; _enemy.hp=100; scrNTTEFullMagneticPulseSetup(_enemy)
    assert(_enemy.hp==100,"EMP affected protected size4+ enemy")
    _enemy.size=1; _enemy.team=team_enemy; scrNTTEFullMagneticPulseSetup(_enemy)
    assert(_enemy.hp==100,"EMP affected a non-IDPD enemy")
    scrNTTEFullSkillSet("magnetic pulse",-1)
    var _double=0
    repeat(128) {
        _enemy.team=team_popo; _enemy.hp=100; _enemy.max_hp=100
        scrNTTEFullMagneticPulseSetup(_enemy)
        if(_enemy.hp==200 && _enemy.max_hp==200) { _double+=1 }
    }
    assert(_double>35 && _double<95,"Negative EMP failed original health/max-health doubling")
    random_set_seed(_seed)
    instance_destroy(_enemy,false)
    // Only neutral/-1 gas changes faction; hostile/friendly faction ownership stays intact.
    variable_struct_set(GameCont.ntte_full_skills,"toad breath",1)
    _player.speed=timescale; _player.team=team_player
    var _gas=[],_teams=[0,-1,team_enemy]
    for(var _i=0;_i<3;++_i) {
        var _g=instance_create(_player.x,_player.y,ToxicGas)
        _g.team=_teams[_i]; array_push(_gas,_g)
    }
    scrNTTEFullToadBreathStep()
    assert(_gas[0].team==team_player && _gas[1].team==team_player && _gas[2].team==team_enemy,
        "Toad Breath took ownership of non-neutral gas or failed to make neutral gas breathable")
    for(var _i=0;_i<3;++_i) instance_destroy(_gas[_i],false)
    GameCont.annihilation_list=[{object_name:"Bandit",name:undefined,text:"bandits",ammo:2},
        {object_name:"Gator",name:undefined,text:"gators",ammo:1},
        {object_name:"Fish",name:undefined,text:"fish",ammo:0}]
    scrNTTEFullAnnihilationPortalTick()
    assert(array_length(GameCont.annihilation_list)==2 && GameCont.annihilation_list[0].ammo==1,
        "Annihilation portal tick expired/refreshed wrong type duration")
    assert(scrNTTEFullPlural("fish")=="fish" && scrNTTEFullPlural("cat")=="cats"
        && scrNTTEFullPlural("fly")=="flies" && scrNTTEFullPlural("knife")=="knives","Annihilation original pluralization drifted")
    var _rad_before=instance_number(Rad)+instance_number(BigRad)
    variable_struct_set(GameCont.ntte_full_skills,"lead ribs",1)
    _enemy=instance_create(_player.x+80,_player.y,Bandit)
    _enemy.hp=0; _enemy.raddrop=10
    scrNTTEFullLeadRibsDeath(_enemy)
    assert(instance_number(Rad)+instance_number(BigRad)==_rad_before+2,"Lead Ribs did not emit ceil(20%*raddrop*count) extra radiation")
    scrNTTEFullLeadRibsDeath(_enemy)
    assert(instance_number(Rad)+instance_number(BigRad)==_rad_before+2,"Lead Ribs emitted duplicate radiation for the same death")
    instance_destroy(_enemy,false)
    _enemy=instance_create(_player.x+80,_player.y,Bandit)
    _enemy.raddrop=10
    variable_struct_set(GameCont.ntte_full_skills,"lead ribs",-1)
    scrNTTEFullLeadRibsDeath(_enemy)
    assert(_enemy.raddrop==8,"Negative Lead Ribs changed drop arithmetic")
    instance_destroy(_enemy,false)
    _player.x=_old_x; _player.y=_old_y; _player.speed=_old_speed; _player.team=_old_team
    scrNTTEFullSystemsImport(json_parse(_snapshot))
    scrNTTESmokeLog("SYSTEMS EFFECTS: EMP factions/size/probability/negative stack, breathable gas faction, annihilation duration/name OK")
}

function scrNTTEFullPermanentUnlockSaveTests() {
    assert(scrNTTESmokeEnabled(),"Permanent unlock disk regression needs explicit smoke save isolation")
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _directory=game_directory,_progress=global.ntte_full_progress,_save=UberCont.saveData,
        _fixture=ds_map_create(),_player_graph={nodes:[]},_pinst_list=global.playerinstance_list,
        _scratch=working_directory+"permanent-unlock-save-"+string(get_timer())+"/",
        _debug_names=["__debug_menu_options","__debug_hitboxes","__debug_health","__debug_immortality",
            "__debug_teleportation","__debug_noreload","__debug_infammo","cheats"],_debug_values=[]
    scrNTTEFullAreaSnapshotContainer(_pinst_list,_player_graph)
    ds_map_copy(_fixture,_save);UberCont.saveData=_fixture
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{},achievement_legacy:{}}
    for(var _i=0;_i<array_length(_debug_names);++_i) {
        array_push(_debug_values,variable_global_get(_debug_names[_i]));variable_global_set(_debug_names[_i],false)
    }
    UberCont.public=true;UberCont.custom=false;UberCont.opt_achievs=false
    try {
        UberCont.cgot[Race.Eyes]=false;UberCont.cskingot[Race.Fish,SkinLetter.B]=false
        UberCont.cwep[Race.Eyes]=scrRaceGetStarterWeapon(Race.Eyes)
        var _native=_scratch+"NuclearThrone.sav",_race_achievement=scrRaceGetUnlockAchievement(Race.Eyes),
            _skin_achievement=scrRaceGetSkinUnlockAchievement(Race.Fish,SkinLetter.B)
        save_set_value("achievement",string(_race_achievement),0)
        save_set_value("achievement",string(_skin_achievement),0)
        save_set_value("achievement","0",0);save_set_value("achievement","59",0)
        scrRaceUnlock(Race.Eyes)
        var _disk=json_parse(scrPersistentJsonLoad(_native))
        assert(_disk[$ "cgot_"+string(Race.Eyes)]
            && _disk[$ "achievement_"+string(_race_achievement)],
            "Actual native character unlock did not reach disk before any Room End/Game End")
        scrRaceUnlockSkin(Race.Fish,SkinLetter.B)
        _disk=json_parse(scrPersistentJsonLoad(_native))
        assert(_disk[$ "cskingot"+string(Race.Fish)+"_"+string(SkinLetter.B)]
            && _disk[$ "achievement_"+string(_skin_achievement)],
            "Actual native skin unlock did not immediately persist character and achievement")
        scr_loadout_race_set_stored_weapon(Race.Eyes,wep_golden_crossbow)
        _disk=json_parse(scrPersistentJsonLoad(_native))
        assert(_disk[$ "cwep_"+string(Race.Eyes)]==wep_golden_crossbow,
            "Actual stored golden-weapon transaction only changed memory")
        scrAchievementUnlock(0)
        _disk=json_parse(scrPersistentJsonLoad(_native))
        assert(_disk[$ "achievement_0"]==1,
            "Standalone actual native achievement was lost before shutdown")
        scrNTTEFullUnlockSet("pack:coast",true)
        _disk=json_parse(scrPersistentJsonLoad(_native))
        var _ntte=json_parse(scrPersistentJsonLoad(_scratch+"ntte-full-progress.json",scrNTTEFullProgressStateValid))
        assert(_disk[$ "achievement_59"]==1 && _ntte.unlocks[$ "pack:coast"],
            "Actual NTTE permanent unlock failed to persist both MOD content and native achievement")
        var _reload=json_decode(scrPersistentJsonLoad(_native))
        try {
            assert(_reload[? "cgot_"+string(Race.Eyes)]
                && _reload[? "cwep_"+string(Race.Eyes)]==wep_golden_crossbow
                && _reload[? "achievement_59"]==1,"Native disk JSON reload lost real unlocks")
        } finally { ds_map_destroy(_reload) }
        var _primary=file_read(_native),_backup=file_read(_native+".bak")
        scrRaceUnlock(Race.Eyes);scrAchievementUnlock(0)
        assert(file_read(_native)==_primary && file_read(_native+".bak")==_backup,
            "Already-owned character or achievement rewrote permanent save")
        scrNTTESmokeLog("PERMANENT UNLOCK DISK: actual character/skin/golden weapon/achievement/NTTE unlock entrypoints persist immediately; native JSON reloaded without Room End or Game End")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_save;ds_map_destroy(_fixture)
        global.playerinstance_list=_pinst_list
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_player_graph.nodes})
        global.ntte_full_progress=_progress;game_directory=_directory
        for(var _i=0;_i<array_length(_debug_names);++_i) variable_global_set(_debug_names[_i],_debug_values[_i])
        var _files=["NuclearThrone.sav","NuclearThrone.sav.bak","NuclearThrone.sav.tmp","ntte-full-progress.json",
            "ntte-full-progress.json.bak","ntte-full-progress.json.tmp","custom-mode.json","temp"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_scratch+_files[_i])) file_delete(_scratch+_files[_i])
    }
}
function scrNTTEFullPersistentProgressFileTests() {
    var _path=game_directory+"ntte-smoke-json-transaction-"+string(get_timer())+".json",
        _old=json_stringify({cgot_0:1,etc_nickname:"old"}),
        _new=json_stringify({cgot_0:1,cgot_1:1,etc_nickname:"new"}),
        _latest=json_stringify({cgot_0:1,cgot_1:1,cgot_2:1,etc_nickname:"latest"}),
        _files=[_path,_path+".tmp",_path+".bak",_path+".corrupt"]
    for(var _i=0;_i<array_length(_files);++_i)
        assert(!file_exists(_files[_i]),"Persistent JSON test must only use new scratch paths")
    try {
        assert(scrPersistentJsonSave(_path,_old) && scrPersistentJsonSave(_path,_new),
            "Native permanent progress transaction failed initial writes")
        assert(scrPersistentJsonLoad(_path)==_new && scrPersistentJsonRead(_path+".bak")==_old,
            "Native permanent progress did not retain last committed backup")
        file_write(_path,"{torn-primary")
        assert(scrPersistentJsonLoad(_path)==_old,"Torn native primary did not recover healthy backup")
        assert(scrPersistentJsonSave(_path,_latest) && scrPersistentJsonRead(_path+".bak")==_old
            && file_read(_path+".corrupt")=="{torn-primary",
            "Saving after recovery replaced healthy backup with damaged primary or erased recovery evidence")
        assert(!scrPersistentJsonSave(_path,"{torn-temporary")
            && scrPersistentJsonRead(_path)==_latest && scrPersistentJsonRead(_path+".bak")==_old,
            "Invalid temporary write changed committed native primary or backup")
        file_delete(_path)
        file_write(_path+".tmp",_new)
        assert(scrPersistentJsonLoad(_path)==_new,"Interrupted rename did not recover complete temporary save")
        file_write(_path+".tmp","{torn-temporary")
        assert(scrPersistentJsonLoad(_path)==_old,"Invalid temporary save prevented native backup recovery")
        file_write(_path,_latest);file_write(_path+".tmp",_new)
        assert(scrPersistentJsonLoad(_path)==_latest,"Uncommitted temporary save overrode valid committed primary")
        file_write(_path,"{}");file_write(_path+".tmp","[]")
        assert(is_undefined(scrPersistentJsonLoad(_path,scrNTTEFullProgressStateValid)),
            "NTTE schema accepted native-map or array save data")
    } finally {
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_files[_i])) file_delete(_files[_i])
    }
    scrNTTESmokeLog("PERSISTENT JSON FILES: committed primary/last healthy backup; torn-primary recovery; complete/incomplete temporary recovery; bad-primary evidence retained; validation before rotation")
}
function scrNTTEFullSystemsProgressTests() {
    var _original=json_stringify(global.ntte_full_progress),_path=game_directory+"ntte-smoke-progress-only.json"
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    variable_struct_set(global.ntte_full_progress.unlocks,"skin:angler fish",true)
    variable_struct_set(global.ntte_full_progress.loadouts,"beetle",{wep:1,parts:[129,173]})
    assert(scrNTTEFullProgressSave(_path),"Progress save did not create primary file")
    variable_struct_set(global.ntte_full_progress.unlocks,"skin:angler fish",false)
    scrNTTEFullProgressLoad(_path)
    assert(scrNTTEFullUnlockGet("skin:angler fish") && scrNTTEFullLoadoutGet("beetle").parts[1]==173,
        "Unlock/loadout progress round-trip changed key or legacy weapon ID")
    scrNTTEFullProgressSave(_path)
    var _file=file_text_open_write(_path)
    file_text_write_string(_file,"{bad-json"); file_text_close(_file)
    assert(scrNTTEFullProgressLoad(_path) && scrNTTEFullUnlockGet("skin:angler fish"),
        "Corrupt primary progress did not recover last valid backup")
    var _backup=file_read(_path+".bak")
    assert(scrNTTEFullProgressSave(_path) && file_read(_path+".bak")==_backup,
        "Saving recovered NTTE progress replaced healthy backup with corrupt primary")
    file_delete(_path)
    var _file=file_text_open_write(_path+".tmp")
    file_text_write_string(_file,json_stringify(global.ntte_full_progress));file_text_close(_file)
    assert(scrNTTEFullProgressLoad(_path) && scrNTTEFullUnlockGet("skin:angler fish"),
        "NTTE progress did not recover a completed temporary file after interrupted rename")
    file_delete(_path)
    if(file_exists(_path+".bak")) file_delete(_path+".bak")
    if(file_exists(_path+".tmp")) file_delete(_path+".tmp")
    if(file_exists(_path+".corrupt")) file_delete(_path+".corrupt")
    global.ntte_full_progress=json_parse(_original)
    scrNTTEFullPersistentProgressFileTests()
    scrNTTEFullPermanentUnlockSaveTests()
    scrNTTESmokeLog("SYSTEMS PROGRESS: persistent unlock/loadout round-trip, stable weapon IDs, corrupt primary backup recovery OK")
}

// BEGIN CRIME REAL EFFECT LIFETIME 20261023
function scrNTTEFullCrimeWithSourceReference() {
    if(instance_exists(GenCont) || instance_exists(LevCont)) return;
    if(scrNTTEFullValue(GameCont,"ntte_crime_enemy_delay",0)>0) {
        var _tick=GameCont.ntte_crime_enemy_delay<300
        if(!_tick) with(Player) {
            var _near=instance_nearest(x,y,enemy)
            if(instance_exists(_near) && !collision_line(x,y,_near.x,_near.y,Wall,false,false)) _tick=true
        }
        if(_tick) GameCont.ntte_crime_enemy_delay-=timescale
        if(instance_number(enemy)<8) GameCont.ntte_crime_enemy_delay=min(GameCont.ntte_crime_enemy_delay,30)
        return;
    }
    if(scrNTTEFullValue(GameCont,"ntte_crime_enemy_count",0)<=0) return;
    --GameCont.ntte_crime_enemy_count
    GameCont.ntte_crime_enemy_delay=random_range(120,180)
    var _dark=false
    with(TopCont) if(scrNTTEFullValue(id,"darkness",false)) _dark=true
    var _x=10016,_y=10016,_distance=_dark ? 8:160,_direction=random(360)
    var _anchor=instance_nearest(_x,_y,instance_exists(CrownObject) ? CrownObject:Player)
    if(instance_exists(_anchor)) {
        var _player=instance_nearest(_anchor.x,_anchor.y,Player)
        if(instance_exists(_player)) {
            _x=_player.x; _y=_player.y
            var _query_x=_x+orandom(96),_query_y=_y+orandom(96),_wall=noone,_best=infinity
            // Nearest bbox, matching telib.instance_nearest_bbox (not nearest origin).
            with(Wall) {
                var _dx=max(bbox_left-_query_x,0,_query_x-bbox_right)
                var _dy=max(bbox_top-_query_y,0,_query_y-bbox_bottom)
                var _d=_dx*_dx+_dy*_dy
                if(_d<_best) { _best=_d; _wall=id }
            }
            if(instance_exists(_wall)) _direction=point_direction(_x,_y,(_wall.bbox_left+_wall.bbox_right+1)/2,(_wall.bbox_top+_wall.bbox_bottom+1)/2)
        }
        var _notice=instance_create(_anchor.x+lengthdir_x(4,_direction),_anchor.y+8+lengthdir_y(4,_direction),BulletHit)
        _notice.sprite_index=sprAssassinNotice; _notice.image_angle=0
        _notice.hspeed=_anchor.hspeed; _notice.vspeed=_anchor.vspeed
        with(_notice) motion_add(_direction,2*timescale)
        _notice.friction=0.2*timescale*timescale; _notice.depth=-9
        repeat(3) {
            var _smoke=instance_create(_anchor.x,_anchor.y,Smoke)
            with(_smoke) {
                image_xscale/=2;image_yscale/=2
                hspeed+=_anchor.hspeed/2;vspeed+=_anchor.vspeed/2
            }
        }
        snd_play(sndIDPDNadeAlmost,0.8)
    }
    scrNTTEFullPortalPoof()
    for(var _i=0;_i<2;++_i) {
        var _name=scrNTTEFullCrimePool()
        var _top=scrNTTEFullTopCreate(_x,_y,_name,_i==0 ? _direction:random(360),_i==0 ? _distance:(_dark ? 0:-1))
        assert(instance_exists(_top),"Crime TopCreate returned no live wrapper for "+_name+" wave-index="+string(_i)+" result="+string(_top))
        _top.jump_time=1; _top.idle_time=0; _x=_top.x; _y=_top.y
        var _target=_top.target
        if(instance_exists(_target)) {
            if(_name=="BabyGator") repeat(1+irandom(1+GameCont.loops)) {
                var _baby=scrNTTEFullTopCreate(_target.x,_target.y,"BabyGator",random(360),-1)
                assert(instance_exists(_baby),"Crime sibling TopCreate returned no live BabyGator wrapper result="+string(_baby))
                _baby.jump_time=1
            }
            repeat(3) {
                var _dust=instance_create(_target.x+orandom(8),_target.y+orandom(8),Dust)
                with(_dust) depth=_target.depth-1
            }
        }
        with(_top) if(_dark && place_meeting(x,y,Wall)) {
            z=0
            with(target) {
                motion_add(_direction+180,3*timescale)
                scrNTTESewerLook(_direction+180+orandom(30))
                if(alarm[1]>60) alarm[1]*=0.5
                snd_play(snd_dead,random_range(0.4,0.8),3)
            }
        }
    }
    if(_dark) {
        var _clear=instance_create(_x,_y,PortalClear)
        _clear.image_xscale=1/3; _clear.image_yscale=1/3
        with(_clear) motion_add(_direction+180,2.5*timescale)
    }
}


// The oracle retains source crowns/crime.crown.gml with semantics for effects.
// All constructors, random arguments, wave selection and actual enemy factories
// still run; only writes to a synchronously destroyed FX instance are skipped.
function scrNTTEFullCrimeLifetimeClear(_before) {
    var _all=scrNTTEFullInstances(all)
    for(var _i=array_length(_all)-1;_i>=0;--_i)
        if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i]))
            instance_destroy(_all[_i],false)
}
function scrNTTEFullCrimeLifetimeTrace(_before) {
    var _rows=[],_all=scrNTTEFullInstances(all)
    var _fields=["x","y","xstart","ystart","sprite_index","image_index","image_speed","image_angle",
        "image_xscale","image_yscale","depth","hspeed","vspeed","friction","gravity","gravity_direction",
        "hp","max_hp","team","size","right","z","zspeed","zfriction","jump","jump_time","idle_time",
        "spawn_dir","spawn_dis","canmove","mask_x","mask_y"]
    for(var _i=0;_i<array_length(_all);++_i) {
        var _v=_all[_i]
        if(array_get_index(_before,_v)>=0) continue
        var _row={type:object_get_name(_v.object_index),values:{},alarms:[]}
        for(var _j=0;_j<array_length(_fields);++_j) {
            var _field=_fields[_j]
            if(variable_instance_exists(_v,_field))
                variable_struct_set(_row.values,_field,variable_instance_get(_v,_field))
        }
        for(var _j=0;_j<12;++_j) array_push(_row.alarms,_v.alarm[_j])
        if(instance_is(_v,NTTEFullTopObject))
            _row.target_type=instance_exists(_v.target)?object_get_name(_v.target.object_index):"ABSENT"
        array_push(_rows,_row)
    }
    return {rows:_rows,count:GameCont.ntte_crime_enemy_count,delay:GameCont.ntte_crime_enemy_delay,
        enemies:instance_number(enemy),tops:instance_number(NTTEFullTopObject),
        smoke:instance_number(Smoke),dust:instance_number(Dust),
        water:instance_number(NTTEFullSweat)+instance_number(NTTEFullWaterStreak),
        bubbles:instance_number(Bubble),rng:random_get_seed(),native_rng:json_stringify(global.rng_state)}
}
function scrNTTEFullCrimeEffectLifetimeTests(_only="") {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Crime effect lifecycle requires desktop full smoke")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_p=instance_find(Player,0),_seed=random_get_seed(),
        _native_rng=[],_hidden=[],_skills=ds_list_create(),_opt=UberCont.opt_prtcls,
        _pet_max=variable_global_exists("pet_max")?global.pet_max:scrNTTEFullValue(GameCont,"ntte_pet_max",1),
        _pet_last=variable_global_exists("pet_max_last")?global.pet_max_last:_pet_max,
        _progress=global.ntte_full_progress,_progress_json=json_stringify(global.ntte_full_progress),
        _ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined
    array_copy(_native_rng,0,global.rng_state,0,array_length(global.rng_state))
    // Fully isolated real constructors. Native GameCont Step remains active.
    for(var _i=0;_i<array_length(_before);++_i) {
        var _v=_before[_i]
        if(_v!=_p && !instance_is(_v,GameCont) && !instance_is(_v,UberCont)
            && !instance_is(_v,NTTESmokeTest) && !instance_is(_v,Console)
            && !instance_is(_v,NTTEFullPortalPickups)) {
            array_push(_hidden,_v);instance_deactivate_object(_v)
        }
    }
    try {
        GameCont.skills=_skills;GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
        GameCont.ntte_full_native_skill_counts={};GameCont.annihilation_list=[]
        GameCont.crown=NTTEFullCrown.Crime;GameCont.hard=0;GameCont.loops=0;GameCont.subarea=1
        GameCont.ntte_pet_max=0;GameCont.ntte_pet_icon=[];GameCont.killenemies=0
        GameCont.rad=0;GameCont.level=1;GameCont.skillpoints=0;GameCont.wantdestinyskill=false
        _p.ntte_pet=[];_p.ntte_pet_max=0;_p.race=Race.Fish
        _p.x=10016;_p.y=10016;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.hp=_p.max_hp;_p.visible=true;global.pet_max=0;global.pet_max_last=0
        global.ntte_full_feature_ready={}
        var _base_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
            _base_players=scrNTTEFullAreaGeneratorSnapshot(Player),
            _cases=["land","coast","particles_off","underwater"]
        for(var _case=0;_case<array_length(_cases);++_case) {
            var _name=_cases[_case]
            if(_only!="" && _name!=_only) continue
            var _expected=undefined
            for(var _pass=0;_pass<2;++_pass) {
                scrNTTEFullCrimeLifetimeClear(_before)
                scrNTTEFullAreaGeneratorRestore(_base_game);scrNTTEFullAreaGeneratorRestore(_base_players)
                GameCont.area=_name=="coast"?201:area_desert
                GameCont.lastarea=GameCont.area;GameCont.ntte_full_active_coast=_name=="coast"
                GameCont.underwater=_name=="underwater";UberCont.opt_prtcls=_name!="particles_off"
                global.pet_max=0;global.pet_max_last=0
                if(_name=="coast") {
                    // Constructor callbacks belong to the actual Coast scene;
                    // the historical active flag can also be present in Vaults.
                    scrNTTEFullCoastSeaEnsure()
                    assert(scrNTTEFullCoastConstructActive() && !position_meeting(12000,12000,Floor),
                        "Crime sea probe requires a real Coast scene and an offshore point")
                }
                var _floor=instance_create(10000,10000,Floor)
                assert(instance_exists(_floor),"Crime lifecycle fixture lost its single native Floor")
                var _probe_before=scrNTTEFullInstances(all)
                // Demonstrate the real synchronous constructor branch, without
                // assigning a fake stale handle or disabling enemy constructors.
                var _fx=instance_create(12000,12000,Dust)
                if(_name=="land") assert(instance_exists(_fx),"Native land Dust must survive Create")
                else assert(!instance_exists(_fx),"Native sea/underwater/particle-off Dust must die during Create")
                _fx=instance_create(12000,12000,Smoke)
                assert(instance_exists(_fx)==UberCont.opt_prtcls,"Native Smoke particle option prerequisite failed")
                // Remove only probe births; preserve Floor and the real sea
                // controller for both measured Crime implementations.
                scrNTTEFullCrimeLifetimeClear(_probe_before)
                if(_name=="coast") assert(scrNTTEFullCoastConstructActive(),
                    "Crime probe cleanup removed its real Coast scene")
                var _run_before=scrNTTEFullInstances(all),_run_rng=[]
                array_copy(_run_rng,0,_native_rng,0,array_length(_native_rng));global.rng_state=_run_rng
                GameCont.ntte_crime_enemy_count=1;GameCont.ntte_crime_enemy_delay=0
                random_set_seed(735671+_case*43)
                if(_pass==0) with(GameCont) scrNTTEFullCrimeWithSourceReference()
                else with(GameCont) event_perform(ev_step,ev_step_normal)
                var _actual=scrNTTEFullCrimeLifetimeTrace(_run_before)
                assert(_actual.count==0 && _actual.delay>=120 && _actual.delay<=180
                    && _actual.tops>=2 && _actual.enemies==_actual.tops,
                    "Crime native effect lifecycle changed wave count/delay/real wrapped hunters")
                if(_name=="land") assert(_actual.smoke==3 && _actual.dust>=6,"Crime live effects missing")
                if(_name=="coast") assert(_actual.smoke==3 && _actual.dust==0 && _actual.water>=6,
                    "Crime sea Dust did not become real water FX")
                if(_name=="particles_off") assert(_actual.smoke==0 && _actual.dust==0,
                    "Crime particle-off constructors survived")
                if(_name=="underwater") assert(_actual.dust==0 && _actual.bubbles>=6,
                    "Crime underwater Dust did not become real Bubble")
                if(_pass==0) _expected=json_stringify(_actual)
                else {
                    if(json_stringify(_actual)!=_expected) {
                        scrNTTESmokeLog("CRIME LIFETIME EXPECTED "+_expected)
                        scrNTTESmokeLog("CRIME LIFETIME ACTUAL "+json_stringify(_actual))
                    }
                    assert(json_stringify(_actual)==_expected,
                        "Crime actual GameCont Step differs from source-with oracle: "+_name)
                    scrNTTESmokeLog("PASS CRIME EFFECT LIFETIME native GameCont Step/source-with exact entity+wave+RNG parity "
                        +_name+" @"+string(30/timescale))
                }
            }
        }
        assert(json_stringify(global.ntte_full_progress)==_progress_json,"Crime lifecycle changed permanent progress")
    } finally {
        scrNTTEFullCrimeLifetimeClear(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        ds_list_destroy(_skills);UberCont.opt_prtcls=_opt
        global.pet_max=_pet_max;global.pet_max_last=_pet_last
        global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready
        global.rng_state=_native_rng;random_set_seed(_seed)
    }
}

// END CRIME REAL EFFECT LIFETIME 20261023

// BEGIN CRIME CROWN TRANSITION FOLLOWUP40
// Crown callbacks must stop with the crown removed, including a queued wave.
// Existing CrimeEffectLifetimeTests verifies exact source RNG/entity parity
// on land, sea, underwater and with particles disabled.
function scrNTTEFullCrimeCrownTransitionTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _hidden=scrNTTEFullInstances([enemy,Floor,Wall,GenCont,LevCont,CrownObject,
            NTTEFullWorldEvent,Portal,NTTEFullTopObject]),_skills=ds_list_create(),
        _ready=global.ntte_full_feature_ready;
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i]);
    try {
        GameCont.skills=_skills;GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[];
        GameCont.ntte_full_native_skill_counts={};GameCont.annihilation_list=[];
        GameCont.hard=0;GameCont.loops=0;global.ntte_full_feature_ready={};
        var _p=instance_find(Player,0),_areas=[area_desert,201,202],_others=[Crown.None,NTTEFullCrown.Bonus,NTTEFullCrown.Red];
        for(var _area=0;_area<array_length(_areas);++_area) {
            scrNTTEFullCrimeLifetimeClear(_before);
            GameCont.area=_areas[_area];GameCont.lastarea=GameCont.area;
            GameCont.underwater=GameCont.area==202;
            GameCont.ntte_full_active_coast=GameCont.area==201;
            instance_create(10000,10000,Floor);
            _p.x=10016;_p.y=10016;_p.xprevious=_p.x;_p.yprevious=_p.y;
            GameCont.crown=NTTEFullCrown.Crime;
            GameCont.ntte_crime_bounty=3;GameCont.ntte_crime_active=true;
            scrNTTEFullCrimeAreaStart(true,false,_p.x,_p.y);
            assert(GameCont.ntte_crime_enemy_count==3 && !GameCont.ntte_crime_active
                && GameCont.ntte_crime_enemy_delay>=300 && GameCont.ntte_crime_enemy_delay<=450,
                "Crime cross-area entry lost source bounty state/delay");
            var _saved=json_parse(json_stringify(scrNTTEFullSystemsExport())),_delay=GameCont.ntte_crime_enemy_delay;
            GameCont.ntte_crime_bounty=0;GameCont.ntte_crime_enemy_count=0;GameCont.ntte_crime_enemy_delay=0;
            assert(scrNTTEFullSystemsImport(_saved) && GameCont.ntte_crime_bounty==3
                && GameCont.ntte_crime_enemy_count==3 && GameCont.ntte_crime_enemy_delay==_delay,
                "Crime continuation lost queued bounty hunters");
            for(var _c=0;_c<array_length(_others);++_c) {
                GameCont.crown=_others[_c];
                // Test both waiting and due-now waves through production hook.
                for(var _due=0;_due<2;++_due) {
                    GameCont.ntte_crime_enemy_delay=_due==0?20:0;
                    var _all=instance_number(all),_rng=random_get_seed();
                    with(GameCont) scrNTTEFullSystemProductionStep();
                    assert(GameCont.ntte_crime_enemy_count==3 && GameCont.ntte_crime_enemy_delay==(_due==0?20:0)
                        && instance_number(all)==_all && random_get_seed()==_rng,
                        "Unequipped Crime crown ticked/spawned or consumed RNG");
                }
            }
            GameCont.crown=NTTEFullCrown.Crime;GameCont.ntte_crime_enemy_delay=20;
            with(GameCont) scrNTTEFullSystemProductionStep();
            assert(abs(GameCont.ntte_crime_enemy_delay-(20-timescale))<0.0001,
                "Reequipped Crime crown did not resume its logical timer");
            GameCont.ntte_crime_enemy_delay=0;
            with(GameCont) scrNTTEFullCrimeStep();
            assert(GameCont.ntte_crime_enemy_count==2 && instance_number(NTTEFullTopObject)>=2,
                "Reequipped Crime crown failed actual hunter factories");
            with(NTTEFullTopObject) assert(instance_exists(target) && target.ntte_full_top_object==id,
                "Crime resumed wave lost live target/wrapper ownership");
        }
        scrNTTESmokeLog("FULL CRIME CROWN TRANSITIONS land/coast/trench entry, JSON continuation, removed/replaced dormant queues, reequipped real hunters OK @"+string(30/timescale));
    } finally {
        scrNTTEFullCrimeLifetimeClear(_before);
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);
        ds_list_destroy(_skills);global.ntte_full_feature_ready=_ready;random_set_seed(_seed);
    }
}

// END CRIME CROWN TRANSITION FOLLOWUP40
