// Real additional race identities. Neither race is a native character skin.
// Natural availability remains closed until each complete runtime passes its
// source inventory/active/ultra/save and touch/controller integration tests.
enum NTTEFullRace { Beetle=17, Parrot=18 }
function scrNTTEFullRaceKey(_race) {
    switch(_race) { case NTTEFullRace.Beetle:return "beetle"; case NTTEFullRace.Parrot:return "parrot" }
    return ""
}
function scrNTTEFullRaceStatAdd(_key,_amount) {
    if(!variable_global_exists("ntte_full_progress")) scrNTTEFullProgressLoad()
    variable_struct_set(global.ntte_full_progress.stats,_key,scrNTTEFullValue(global.ntte_full_progress.stats,_key,0)+_amount)
}
function scrNTTEFullRaceReady(_race) {
    var _key=scrNTTEFullRaceKey(_race)
    return _key!="" && scrNTTEFullFeatureReady("race:"+_key);
}
function scrNTTEFullRaceAvailable(_race) {
    var _key=scrNTTEFullRaceKey(_race)
    return _key!="" && scrNTTEFullRaceReady(_race) && scrNTTEFullUnlockGet("race:"+_key)
}
function scrNTTEFullRaceSprite(_race,_part,_skin=0,_fallback=-1) {
    var _key=scrNTTEFullRaceKey(_race)
    if(_key=="") return _fallback
    var _spr=asset_get_index("sprNTTERefRace"+_key+string(_skin)+_part)
    // The original race_sprite_raw never substitutes the other skin's art.
    return sprite_exists(_spr) ? _spr:_fallback
}
function scrNTTEFullRaceSound(_race,_kind,_fallback=-1) {
    var _key=scrNTTEFullRaceKey(_race)
    if(_key=="") return _fallback
    if(_kind=="Valt") _kind="Chst"
    if(_kind=="Cptn") _kind="Spch"
    if(_kind=="Thrn") _kind=_race==NTTEFullRace.Parrot ? "IDPD":"LowH"
    var _snd=asset_get_index("sndNTTERef"+(_race==NTTEFullRace.Beetle ? "Beetle":"Parrot")+_kind)
    return audio_exists(_snd) ? _snd:_fallback
}
function scrNTTEFullRaceText(_race,_part,_ultra=0) {
    switch(_race) {
        case NTTEFullRace.Beetle:
            switch(_part) {
                case "name":return "BEETLE"
                case "passive":return "BEETLE CHEST"
                case "active":return "MERGE WEAPONS"
                case "lock":return "OPEN THE CHEST"
                case "unlock":return "FOR OPENING THE CHEST"
                case "butt":return "PARTS OF @wMERGED WEAPONS @sCAN BE REPLACED#BY WEAPONS OF THE SAME @yAMMO TYPE"
                case "ultra_name":return _ultra==1 ? "CRITICAL THORAX":"AUXILIARY MANDIBLES"
                case "ultra_text":return _ultra==1 ? "THE @yBEETLE CHEST @sOPENS WITH A @wBLAST#@sAND @wAPPEARS @sWHEN NEEDED":"@wMERGED WEAPON @sSTOCKS#ARE @rTRIGGER-HAPPY"
            }
            break
        case NTTEFullRace.Parrot:
            switch(_part) {
                case "name":return "PARROT"
                case "passive":return "MANY FRIENDS"
                case "active":return "@rCHARM ENEMIES"
                case "lock":return "REACH COAST"
                case "unlock":return "FOR REACHING COAST"
                case "butt":return "@wPICKUPS @sGIVE @rFEATHERS@s"
                case "ultra_name":return _ultra==1 ? "BIRDS OF A FEATHER":"FLOCK TOGETHER"
                case "ultra_text":return _ultra==1 ? "CAN CHARM MULTIPLE ENEMIES#@rFEATHERS @sLAST @wLONGER":"@wINCOMING DAMAGE @sIS SPLIT#WITH @rFEATHERED @sENEMIES"
            }
            break
    }
    return ""
}
function scrNTTEFullRaceCreate() {
    switch(race) {
        case NTTEFullRace.Beetle:
            footkind=4
            if(!is_struct(scrNTTEFullValue(id,"beetle_menu_info",undefined))) beetle_menu_info=scrNTTEFullBeetleMenuNew()
            break
        case NTTEFullRace.Parrot:
            footkind=1
            feather_num=12; feather_num_mult=1; feather_ammo=0; feather_ammo_max=36; feather_ammo_get=0; feather_ammo_hud=[]
            ntte_charm_flock_hp=hp; ntte_charm_flock_hud=0; ntte_charm_flock_hud_hp=0; ntte_charm_flock_hud_hp_max=0; ntte_charm_flock_hud_hp_lst=0
            ntte_pet_max=scrNTTEFullValue(GameCont,"ntte_pet_max",1)+1
            break
    }
}
function scrNTTEFullRaceUltraValue(_player,_which) {
    if(!instance_exists(_player) || _which<1 || _which>2 || scrNTTEFullRaceKey(_player.race)=="") return 0
    // Source ultra_get is a numeric, race-wide value. A/B can coexist and all
    // same-race co-op bodies, including their downed/reviving body, share it.
    // Independent ActorFire proxies keep a snapshot of the real firing context.
    var _captured=scrNTTEFullValue(_player,"ntte_actor_race_ultras",undefined)
    if(is_array(_captured) && array_length(_captured)>_which) return _captured[_which]
    if(scrNTTEFullValue(_player,"ntte_native_race",-1)==_player.race && instance_exists(GameCont))
        return scr_ultra_get(_player.race,_which)
    // Bare synthetic actors and old direct test fixtures have no native role.
    return scrNTTEFullValue(_player,"ntte_race_ultra",0)==_which ? 1:0
}
function scrNTTEFullRaceUltraGet(_player,_which) {
    return scrNTTEFullRaceUltraValue(_player,_which)>0
}
function scrNTTEFullRaceUltraTake(_which,_state=true) {
    if(scrNTTEFullRaceKey(race)=="") return false
    ntte_race_ultra=instance_exists(GameCont) && scrNTTEFullValue(id,"ntte_native_race",-1)==race
        ? max(0,scr_ultra_get_from_race(race)):(_state ? _which:0)
    if(race==NTTEFullRace.Parrot && _which==1 && _state>0) feather_ammo_get+=feather_ammo_max*_state
    return true
}
function scrNTTEFullRaceMetadataTests() {
    for(var _race=NTTEFullRace.Beetle;_race<=NTTEFullRace.Parrot;++_race) {
        assert(_race!=Race.Fish && _race!=Race.Rebel && scrNTTEFullRaceKey(_race)!="","Additional race identity aliases a native race")
        for(var _skin=0;_skin<=1;++_skin) {
            var _parts=["Idle","Walk","Hurt","Dead","GoSit","Sit","Portrait","Map","Loadout"]
            for(var _i=0;_i<array_length(_parts);++_i) assert(sprite_exists(scrNTTEFullRaceSprite(_race,_parts[_i],_skin)),"Additional race missing exact source art: "+scrNTTEFullRaceKey(_race)+"/"+string(_skin)+"/"+_parts[_i])
        }
        var _menu_parts=["Menu","MenuSelected","MenuSelect","MenuDeselect","Select"]
        for(var _i=0;_i<array_length(_menu_parts);++_i) assert(sprite_exists(scrNTTEFullRaceSprite(_race,_menu_parts[_i],0)),"Additional race missing its source A-skin character menu art")
        var _key="race:"+scrNTTEFullRaceKey(_race)
        assert(scrNTTEFullRaceAvailable(_race)==(scrNTTEFullRaceReady(_race) && scrNTTEFullUnlockGet(_key)),"Race availability bypassed readiness or earned ownership")
        var _saved_progress=global.ntte_full_progress
        try {
            global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
            assert(!scrNTTEFullRaceAvailable(_race),"Certified unowned race became available")
            variable_struct_set(global.ntte_full_progress.unlocks,_key,true)
            assert(scrNTTEFullRaceAvailable(_race)==scrNTTEFullRaceReady(_race),"Ownership bypassed closed readiness or missed release readiness")
        } finally {global.ntte_full_progress=_saved_progress}
    }
    scrNTTESmokeLog("SYSTEMS RACE METADATA: distinct Beetle/Parrot identities, A/B body/portrait/map/loadout art, authored A-skin character menu art and natural availability gates OK")
}
