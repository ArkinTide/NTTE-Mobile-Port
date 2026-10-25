// Native menu, identity, Ultra and lifecycle bridge. Keep the readiness gates
// closed until both complete character runtimes pass source parity tests.
function scrNTTEFullRaceNumeric(_race) {
    if(is_numeric(_race)) return (_race==17 || _race==18) ? _race:-1
    if(!is_string(_race)) return -1
    switch(string_lower(_race)) { case "beetle":return 17; case "parrot":return 18 }
    return -1
}
function scrNTTEFullRaceSkinAvailable(_race,_skin) {
    if(_skin<0 || _skin>=scrNTTEFullRaceSkinCount(_race)) return false
    // Original co-op only exposes the contiguous unlocked skin prefix.
    return _skin==0 || player_count>1 || scrNTTEFullUnlockGet("skin:"+scrNTTEFullRaceKey(_race)+":"+string(_skin))
}
function scrNTTEFullRaceSkinCount(_race) {
    if(player_count<=1) return 2
    var _count=1
    while(_count<2 && scrNTTEFullUnlockGet("skin:"+scrNTTEFullRaceKey(_race)+":"+string(_count))) _count+=1
    return _count
}
function scrNTTEFullRaceSkinText(_race,_skin,_unlock=false) {
    if(_skin==0) return "EDIT THE SAVE FILE LMAO"
    if(_skin!=1) return ""
    switch(_race) {
        case NTTEFullRace.Beetle:return _unlock ? "FOR HOLDING 6 WEAPONS IN ONE HAND":"HOLD 6 WEAPONS#IN ONE HAND"
        case NTTEFullRace.Parrot:return _unlock ? "FOR BEATING THE AQUATIC ROUTE":"COMPLETE THE#AQUATIC ROUTE"
    }
    return ""
}
function scrNTTEFullRaceMenuSprite(_race,_skin,_sprite) {
    if(scrNTTEFullRaceNumeric(_race)<0) return _sprite
    switch(_sprite) {
        case sprBigPortrait:return scrNTTEFullRaceSprite(_race,"Portrait",_skin)
        case sprMapIcon:return scrNTTEFullRaceSprite(_race,"Map",_skin)
        case sprLoadoutSkin:
        case sprLoadoutSkinLocked:return scrNTTEFullRaceSprite(_race,"Loadout",_skin)
    }
    return _sprite
}
function scrNTTEFullRaceSelectSprite(_race,_unlocked,_default) {
    return scrNTTEFullRaceNumeric(_race)>=0 ? scrNTTEFullRaceSprite(_race,"Select",0):_default
}
function scrNTTEFullRaceSelectFrame(_race,_unlocked) {
    return scrNTTEFullRaceNumeric(_race)>=0 ? !_unlocked:_race
}
function scrNTTEFullRaceUltraNativeSet(_race,_which,_value) {
    if(!instance_exists(GameCont) || _which<1 || _which>2) return;
    var _old=GameCont.ultra_got[_race,_which]
    if(_old==_value) return;
    GameCont.ultra_got[_race,_which]=_value
    var _icon=_race*3+_which-1,_found=array_get_index(GameCont.ultra_hud,_icon)
    if(_value && _found<0) array_push(GameCont.ultra_hud,_icon)
    else if(!_value && _found>=0) array_delete(GameCont.ultra_hud,_found,1)
    with(Player) if(race==_race) {
        scrNTTEFullRaceUltraTake(_which,_value)
    }
}
function scrNTTEFullRaceUltraDraw(_icon,_x,_y) {
    var _race=_icon div 3,_which=(_icon mod 3)+1
    if(scrNTTEFullRaceNumeric(_race)>=0) draw_sprite(scrNTTEFullRaceSprite(_race,"UltraHUD"+chr(64+_which),0),0,_x,_y)
    else draw_sprite(sprEGIconHUD,_icon,_x,_y)
}
function scrNTTEFullRaceNativeChange() {
    if(scrNTTEFullRaceNumeric(race)<0) { ntte_native_race=-1; ntte_race_ultra=0; return }
    if(scrNTTEFullValue(id,"ntte_native_race",-1)!=race) {
        scrNTTEFullRaceCreate()
        ntte_native_race=race
        ntte_native_race_started=false
    }
    ntte_race_ultra=instance_exists(GameCont) ? max(0,scr_ultra_get_from_race(race)):0
}
function scrNTTEFullRaceNativeGameStart() {
    if(scrNTTEFullRaceNumeric(race)<0 || scrNTTEFullValue(id,"ntte_native_race_started",false)) return;
    ntte_native_race_started=true
    if(race==NTTEFullRace.Parrot) scrNTTEFullParrotGameStart()
}
function scrNTTEFullRaceNativeAfterLoad() {
    if(scrNTTEFullRaceNumeric(race)<0) return;
    // Full-instance saves already contain feathers and chest/menu state.
    // Old saves with initialized fields should gain the marker without reset.
    if(scrNTTEFullValue(id,"ntte_native_race",-1)!=race) {
        var _initialized=race==NTTEFullRace.Parrot ? variable_instance_exists(id,"feather_ammo"):variable_instance_exists(id,"beetle_menu_info")
        if(!_initialized) scrNTTEFullRaceCreate()
        ntte_native_race=race
    }
    ntte_native_race_started=true
    ntte_race_ultra=instance_exists(GameCont) ? max(0,scr_ultra_get_from_race(race)):scrNTTEFullValue(id,"ntte_race_ultra",0)
}
function scrNTTEFullRaceTip(_race) {
    var _ultra=GameCont.level>=10 && random(5)<1
    if(_race==NTTEFullRace.Beetle) return _ultra ? choose(
        "REMEMBER THE GUNS LEFT BEHIND","BOUND BY BLOOD","THERE CAN ONLY BE GUN") : choose(
        "STICK TO YOUR GUNS","LEAVE NO GUN BEHIND","NEVER ENOUGH WEAPONS",
        "HEALTH CHESTS RESTORE LOST @rMAX HP","BEETLE IS ALWAYS HOME","BEETLE ALWAYS HAS COMPANY")
    if(_race==NTTEFullRace.Parrot) return _ultra ? choose(
        "MIGRATION FORMATION","CHARMED, I'M SURE","ADVENTURING PARTY","FREE AS A BIRD") : choose(
        "HITCHHIKER","BIRDBRAIN","PARROT IS AN EXPERT TRAVELER","WIND UNDER MY WINGS",
        "PARROT LIKES CAMPING","MACAW WORKS TOO","CHESTS GIVE @rFEATHERS@s")
    return ""
}
function scrNTTEFullRaceNativeMetadataTests() {
    assert(Race.NUM_ALL_RACE_TYPES==19,"Native race count excludes additional identities")
    for(var _race=17;_race<=18;++_race) {
        assert(scrRaceGetNumericID(scrRaceGetStringID(_race))==_race,"Additional native race ID roundtrip")
        assert(scrRaceGetName(_race)==scrNTTEFullRaceText(_race,"name"),"Additional native race name")
        assert(scrRaceGetMaxSkinCount(_race)<=2,"Additional race exposed un-authored skin")
        assert(scrRaceGetStarterWeapon(_race)==(_race==17 ? wep_ntte_beetle_blaster:wep_revolver),"Additional native starter weapon")
        var _key="race:"+scrNTTEFullRaceKey(_race),_saved_progress=global.ntte_full_progress,
            _saved_ready=global.ntte_full_feature_ready
        try {
            // Metadata QA must not assume that the ordinary production
            // certificate is closed, or inherit another fixture's ownership.
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            global.ntte_full_feature_ready={}
            assert(!scr_race_is_unlocked(_race),"Closed unowned native race became unlocked")
            variable_struct_set(global.ntte_full_progress.unlocks,_key,true)
            assert(!scr_race_is_unlocked(_race),"Earned native race bypassed closed readiness")
            variable_struct_set(global.ntte_full_feature_ready,_key,true)
            assert(scr_race_is_unlocked(_race),"Open earned native race remained locked")
            variable_struct_remove(global.ntte_full_progress.unlocks,_key)
            assert(!scr_race_is_unlocked(_race),"Open certificate awarded unearned native race")
        } finally {global.ntte_full_progress=_saved_progress;global.ntte_full_feature_ready=_saved_ready}
        for(var _skin=0;_skin<2;++_skin) {
            assert(scr_race_get_sprite(_race,"Walk",-1,_skin)==scrNTTEFullRaceSprite(_race,"Walk",_skin),"Native body sprite mapping")
            assert(scrNTTEFullSkinMenuSprite(_race,_skin,sprMapIcon)==scrNTTEFullRaceSprite(_race,"Map",_skin),"Native roadmap sprite mapping")
        }
        assert(scr_race_get_sprite(scrRaceGetStringID(_race,true),"Menu")==scrNTTEFullRaceSprite(_race,"Menu",0),"Native campfire string sprite mapping")
        assert(scr_race_get_sound(_race,"Slct")==scrNTTEFullRaceSound(_race,"Slct"),"Native menu source sound")
        assert(array_length(UberCont.cskingot[_race])==2,"Native save skin allocation")
        assert(array_length(GameCont.ultra_got[_race])>=3,"Native Ultra allocation")
    }
    scrNTTESmokeLog("SYSTEMS RACE NATIVE METADATA: count, save/Ultra allocation, identity, A/B source art, starter weapons and gated menus OK")
}
function scrNTTEFullRaceNativeLifecycleTests() {
    var _real=instance_find(Player,0),_before=scrNTTEFullInstances(all),_pinst=scr_playerinstance_find(_real.index)
    var _selected={race:_pinst.race,skin:_pinst.skin}
    var _ultras=json_parse(json_stringify(GameCont.ultra_got)),_hud=scrNTTEFullArrayCopy(GameCont.ultra_hud)
    GameCont.ultra_got[17]=array_create(4,0); GameCont.ultra_got[18]=array_create(4,0)
    var _p=instance_create(79000,79000,Player)
    _p.index=_real.index
    with(_p) scrPlayerRaceChange(NTTEFullRace.Parrot,0)
    assert(_p.race==NTTEFullRace.Parrot && _p.ntte_native_race==NTTEFullRace.Parrot
        && _p.feather_num==12 && _p.feather_ammo==0 && _p.feather_ammo_max==36 && _p.feather_ammo_get==0
        && _p.ntte_pet_max==scrNTTEFullValue(GameCont,"ntte_pet_max",1)+1,
        "Native Parrot RaceChange did not initialize exact source feathers and extra pet slot")
    _p.feather_ammo=5; _p.feather_ammo_get=7
    var _pet_max=_p.ntte_pet_max
    with(_p) scrPlayerRaceChange(NTTEFullRace.Parrot,1)
    assert(_p.bskin==1 && _p.spr_walk==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Walk",1)
        && _p.feather_ammo==5 && _p.feather_ammo_get==7 && _p.ntte_pet_max==_pet_max,
        "Native Parrot skin/body refresh reset real feather state or duplicated extra pet capacity")
    with(_p) scrNTTEFullRaceNativeGameStart()
    assert(_p.feather_ammo_get==19 && array_length(_p.ntte_pet)==1,"Native Parrot first game start missing12starting feathers or one pet")
    var _pet=_p.ntte_pet[0]
    assert(instance_exists(_pet) && _pet.leader==_p && !_pet.visible && _pet.persistent && !_pet.stat_found && _pet.bskin==1,
        "Native Parrot starter pet lost original hidden/persistent/leader/skin properties")
    with(_p) scrNTTEFullRaceNativeGameStart()
    assert(_p.feather_ammo_get==19 && array_length(_p.ntte_pet)==1,"Native room start duplicated Parrot starting feathers/pet")
    scr_ultra_set(NTTEFullRace.Parrot,1,1)
    assert(_p.ntte_race_ultra==1 && _p.feather_ammo_get==55 && scr_ultra_get(NTTEFullRace.Parrot,1)==1,
        "Native Ultra picker did not apply Parrot A and its exact36pending feather reward")
    scr_ultra_set(NTTEFullRace.Parrot,1,1)
    assert(_p.feather_ammo_get==55,"Repeated unchanged native Ultra set paid Parrot bonus twice")
    with(_p) scrNTTEFullRaceNativeAfterLoad()
    assert(_p.feather_ammo==5 && _p.feather_ammo_get==55 && _p.ntte_pet_max==_pet_max && _p.ntte_race_ultra==1,
        "Native initialized save restoration reset Parrot progress")
    _p.ntte_native_race=-1; _p.ntte_native_race_started=false
    with(_p) { scrNTTEFullRaceNativeAfterLoad(); scrNTTEFullRaceNativeGameStart() }
    assert(_p.feather_ammo==5 && _p.feather_ammo_get==55 && _p.ntte_pet_max==_pet_max && array_length(_p.ntte_pet)==1,
        "Native old save migration reset Parrot ammo/pet capacity or replayed game_start")
    scr_ultra_set(NTTEFullRace.Parrot,1,0)
    assert(_p.ntte_race_ultra==0 && scr_ultra_get(NTTEFullRace.Parrot,1)==0,"Native Parrot Ultra removal left stale ability state")
    var _beetle=instance_create(79200,79000,Player)
    _beetle.index=_real.index
    with(_beetle) scrPlayerRaceChange(NTTEFullRace.Beetle,0)
    assert(_beetle.ntte_native_race==NTTEFullRace.Beetle && is_struct(_beetle.beetle_menu_info) && _beetle.footkind==4,
        "Native Beetle RaceChange omitted original menu/metal footsteps")
    var _menu=_beetle.beetle_menu_info
    _menu.selection_angle=123; _menu.is_open=true
    with(_beetle) scrPlayerRaceChange(NTTEFullRace.Beetle,1)
    assert(_beetle.beetle_menu_info==_menu && _menu.selection_angle==123 && _menu.is_open
        && _beetle.spr_walk==scrNTTEFullRaceSprite(NTTEFullRace.Beetle,"Walk",1),
        "Native Beetle body/skin refresh reset the actual merge menu")
    _beetle.ntte_native_race=-1
    with(_beetle) scrNTTEFullRaceNativeAfterLoad()
    assert(_beetle.beetle_menu_info==_menu && _menu.selection_angle==123 && _menu.is_open,
        "Native Beetle old-save migration discarded its real merge menu")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
    GameCont.ultra_got=_ultras; GameCont.ultra_hud=_hud
    _pinst.race=_selected.race; _pinst.skin=_selected.skin
    scrNTTESmokeLog("SYSTEMS RACE NATIVE LIFECYCLE: actual RaceChange/body/skin, source initialization, Parrot game-start pet/feathers once, native Ultra grant/remove, and non-resetting new/old save migration OK")
}
function scrNTTEFullRaceNativeUltraTests() {
    var _real=instance_find(Player,0),_before=scrNTTEFullInstances(all),_pinst=scr_playerinstance_find(_real.index)
    var _selected={race:_pinst.race,skin:_pinst.skin}
    var _ultras=json_parse(json_stringify(GameCont.ultra_got)),_hud=scrNTTEFullArrayCopy(GameCont.ultra_hud)
    GameCont.ultra_got[18]=array_create(4,0)
    var _p=instance_create(7900,7900,Player),_q=instance_create(7940,7900,Player)
    _p.index=_real.index; _q.index=_real.index
    with(_p) scrPlayerRaceChange(NTTEFullRace.Parrot,0)
    with(_q) scrPlayerRaceChange(NTTEFullRace.Parrot,1)
    scr_ultra_set(NTTEFullRace.Parrot,1,2)
    scr_ultra_set(NTTEFullRace.Parrot,2,1)
    assert(scrNTTEFullRaceUltraValue(_p,1)==2 && scrNTTEFullRaceUltraGet(_p,2)
        && scrNTTEFullRaceUltraValue(_q,1)==2 && scrNTTEFullRaceUltraGet(_q,2),
        "Same-race native co-op lost simultaneous numeric Ultra A/B")
    assert(_p.feather_ammo_get==72 && _q.feather_ammo_get==72,
        "Numeric native Parrot Ultra grant lost source feather_ammo_max*state reward")
    var _f=scrNTTEFullParrotFeatherNew(_p.x,_p.y,_p,_q)
    assert(_f.stick_time_max==67.5,"Parrot feather lifetime lost source numeric Ultra exponent")
    var _fire=scrNTTEFullActorFire(_p,wep_revolver,0)
    assert(_fire.context.ultras[1]==2 && _fire.context.ultras[2]==1,
        "ActorFire proxy failed to capture both numeric source Ultras")
    with(_q) instance_change(Revive,true)
    assert(instance_is(_q,Revive) && scrNTTEFullRaceUltraValue(_q,1)==2 && scrNTTEFullRaceUltraGet(_q,2),
        "Native co-op downed body lost race-wide Ultra context")
    with(_q) instance_change(Player,false)
    assert(instance_is(_q,Player) && _q.feather_ammo_get==72 && scrNTTEFullRaceUltraValue(_q,1)==2,
        "Native co-op revival reset feather or Ultra state")
    // Session saving includes the entire GameCont array. Its JSON round trip
    // and initialized-player migration must retain A/B independently of the
    // obsolete one-choice display field, without replaying the grant reward.
    GameCont.ultra_got=json_parse(json_stringify(GameCont.ultra_got))
    _p.ntte_race_ultra=0
    with(_p) scrNTTEFullRaceNativeAfterLoad()
    assert(scrNTTEFullRaceUltraValue(_p,1)==2 && scrNTTEFullRaceUltraGet(_p,2) && _p.feather_ammo_get==72,
        "Native session Ultra restoration lost A/B or replayed Parrot grant")
    scr_ultra_set(NTTEFullRace.Parrot,1,0)
    assert(!scrNTTEFullRaceUltraGet(_p,1) && scrNTTEFullRaceUltraGet(_p,2)
        && !scrNTTEFullRaceUltraGet(_q,1) && scrNTTEFullRaceUltraGet(_q,2),
        "Removing native Ultra A also removed the independent Ultra B")
    assert(_p.feather_ammo_get==72 && _q.feather_ammo_get==72,
        "Removing native Parrot Ultra incorrectly consumed existing pending feathers")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
    GameCont.ultra_got=_ultras; GameCont.ultra_hud=_hud
    _pinst.race=_selected.race; _pinst.skin=_selected.skin
    scrNTTESmokeLog("SYSTEMS RACE NATIVE ULTRA: simultaneous numeric A/B, same-race co-op, feather lifetime/grants, ActorFire capture, native down/revive and session migration OK")
}
