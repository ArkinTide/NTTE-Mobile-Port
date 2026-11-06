// Native clear checks must retain Frontier's arriving police reservation.
// The source replaces IDPDSpawn with a non-enemy CustomObject while charging.
function scrFRPendingPoliceCount() {
    if(!scrFREnabled()) return 0;
    var _count=0;
    with(FRCustomObject) {
        if((self[$ "fr_pending_police_spawn"]??false)
            && (self[$ "name"]??"")=="IDPDPortal") _count+=1;
    }
    return _count;
}

function scrFRProgressionTestsStart(_driver) {
    // An empty native room, then the real IDPDSpawn replacement and source
    // portal lifecycle. No fabricated delayed timer or direct unit factory.
    with(enemy) instance_destroy(id,false);
    with(becomenemy) instance_destroy(id,false);
    with(Portal) instance_destroy(id,false);
    with(Corpse) instance_destroy(id,false);
    GameCont.area=area_campfire;GameCont.subarea=1;GameCont.maxsubarea=1;
    GameCont.loops=0;GameCont.popolevel=0;
    GameCont.is_level_ended=false;
    with(Player) {hp=max_hp;nexthurt=current_frame+10000;}
    var _spawn=instance_create(Player.x+96,Player.y,IDPDSpawn);
    _spawn.elite=0;
    scrFRModCall("mod","CustomIDPDHandler","step");
    var _portals=scrFRMatching(FRCustomObject,"name","IDPDPortal");
    assert(!instance_exists(_spawn) && array_length(_portals)==1,
        "Progression fixture did not use native IDPD replacement");
    assert(scrFRPendingPoliceCount()==1 && scr_check_enemies(),
        "Charging Frontier police portal vanished from the clear check");
    _driver.fr_police_portal=_portals[0];
    _driver.fr_police_corpse=instance_create(Player.x,Player.y,Corpse);
    _driver.fr_police_corpse.alarm[0]=-1;
    _driver.fr_police_phase=0;_driver.fr_police_start=current_frame;
}

function scrFRProgressionTestsStep(_driver) {
    GameCont.is_level_ended=false;
    var _portal=_driver.fr_police_portal,_corpse=_driver.fr_police_corpse;
    if(_driver.fr_police_phase==0) {
        with(_corpse) event_perform(ev_alarm,0);
        assert(!instance_exists(Nothing2Appear) && !instance_exists(Nothing2),
            "Campfire summoned Throne2 before pending police finished spawning");
        if(instance_exists(_portal) && (_portal[$ "fr_pending_police_spawn"]??false)) return false;
        assert(instance_exists(Grunt) && scrFRPendingPoliceCount()==0 && scr_check_enemies(),
            "Police reservation did not hand off to its actual hostile units");
        _driver.fr_police_phase=1;
        scrNTTESmokeLog("FRONTIER POLICE actual spawn after "+string(current_frame-_driver.fr_police_start));
        return false;
    }
    with(_corpse) event_perform(ev_alarm,0);
    assert(!instance_exists(Nothing2Appear),"Throne2 appeared before the spawned police were defeated");
    with(Grunt) {hp=0;event_perform(ev_step,ev_step_normal);}
    // Ignore the expired visual portal, but count actual combatants.
    assert(!scr_check_enemies() && scrFRPendingPoliceCount()==0,
        "Closing police animation permanently blocked room completion");
    with(_corpse) event_perform(ev_alarm,0);
    assert(instance_number(Nothing2Appear)==1,
        "Campfire failed to summon exactly one Throne2 after the final police death");
    scrNTTESmokeLog("PASS FRONTIER pending police, natural spawn, defeat and campfire boss ordering");
    return true;
}
