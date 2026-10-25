// Source ntte_setup_GenCont2705..2727 / level_start1855..1888.
// The source event lifecycle/dependencies are implemented and reviewed.
// Ordinary production binds the real providers; no fixture callbacks are used.
function scrNTTEFullWorldEventsNativeCertified() {
    // BEGIN NTTE OWNED WORLD EVENTS RELEASE
    // Ordinary production uses the implemented original sixteen-event manager.
    // The dedicated legacy observer alone can exercise a closed certificate.
    if(os_type==os_windows && scrNTTEFullSmokeEnabled()
        && instance_number(NTTEFullWorldEventsColdProductionTest)==1) {
        var _cold=instance_find(NTTEFullWorldEventsColdProductionTest,0);
        if(variable_instance_exists(_cold,"candidate_certificate")
            && !is_undefined(_cold.candidate_certificate))
            return _cold.candidate_certificate==true;
    }
    return true;
    // END NTTE OWNED WORLD EVENTS RELEASE
}
function scrNTTEFullWorldEventsNativeAlias(_index) {
    var _player=scr_playerinstance_find(_index)
    return is_undefined(_player)?"":_player.name;
}
function scrNTTEFullWorldEventBuriedVaultCreate() {
    // Source teevents74..80; the Shrine branch is explicitly && false.
    if(instance_number(enemy)>instance_number(HostileHorror) || GameCont.area==area_vault) {
        var _walls=scrNTTEFullInstances(Wall)
        if(array_length(_walls)>0) {
            var _wall=_walls[irandom(array_length(_walls)-1)]
            // The disabled source Shrine expression still evaluates chance
            // for level10+ before reaching its literal && false operand.
            var _disabled_shrine=GameCont.level>=10 && random(3)<1 && false
            instance_create(_wall.x,_wall.y,NTTEFullBuriedVault)
        }
    }
}
function scrNTTEFullWorldEventsNativeBindings(_complete=false) {
    scrNTTEFullWorldEventsInit()
    scrNTTEFullWorldEventRegister("BlockedRoom",scrNTTEFullBlockedRoomCreate,scrNTTEFullBlockedRoomSetup,scrNTTEFullBlockedRoomStep,undefined,_complete)
    scrNTTEFullWorldEventRegister("GatorAmbush",scrNTTEFullGatorAmbushCreate,scrNTTEFullGatorAmbushSetup,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("MaggotPark",scrNTTEFullWorldEventMaggotParkCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("ScorpionCity",scrNTTEFullWorldEventScorpionCityCreate,scrNTTEFullScorpionCitySetup,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("BanditCamp",scrNTTEFullWorldEventBanditCampCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("GatorDen",scrNTTEFullGatorDenCreate,scrNTTEFullGatorDenSetup,scrNTTEFullGatorDenStep,undefined,_complete)
    scrNTTEFullWorldEventRegister("SewerPool",scrNTTEFullWorldEventSewerPoolCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("RavenArena",scrNTTEFullRavenArenaCreate,scrNTTEFullRavenArenaSetup,scrNTTEFullRavenArenaStep,undefined,_complete)
    scrNTTEFullWorldEventRegister("FirePit",scrNTTEFullFirePitCreate,scrNTTEFullFirePitSetup,undefined,scrNTTEFullFirePitCleanup,_complete)
    scrNTTEFullWorldEventRegister("SealPlaza",scrNTTEFullSealPlazaCreate,scrNTTEFullSealPlazaSetup,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("MutantVats",scrNTTEFullMutantVatsEvent,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("PopoAmbush",scrNTTEFullPopoAmbushCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("PalaceShrine",scrNTTEFullPalaceShrineCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("SeaCreature",scrNTTEFullWorldEventSeaCreatureCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("EelGrave",scrNTTEFullWorldEventEelGraveCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullWorldEventRegister("BuriedVault",scrNTTEFullWorldEventBuriedVaultCreate,undefined,undefined,undefined,_complete)
    scrNTTEFullPalaceShrineSkillsInit()
    global.ntte_full_player_alias=scrNTTEFullWorldEventsNativeAlias
}
function scrNTTEFullWorldEventsNativeSetup(_gen) {
    if(!variable_global_exists("ntte_full_world_events_native_bound") || !global.ntte_full_world_events_native_bound) {
        scrNTTEFullWorldEventsNativeBindings(scrNTTEFullWorldEventsNativeCertified())
        global.ntte_full_world_events_native_bound=true
    }
    if(scrNTTEFullWorldEventsReady()) scrNTTEFullWorldEventsSetup(_gen)
}
function scrNTTEFullWorldEventsNativeGenerate() {
    if(!scrNTTEFullWorldEventsReady()) return;
    // Only the real pre-generation setup enables generation. This prevents
    // stale manual/debug event controllers from leaking into another room.
    if(!instance_exists(GenCont) || !variable_instance_exists(GenCont,"ntte_full_events_setup")) return;
    scrNTTEFullWorldEventsGenerate()
}
