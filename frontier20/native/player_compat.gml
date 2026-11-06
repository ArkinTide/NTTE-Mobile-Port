// Explicit boundaries for legacy controller state absent from Epsilon.
// Firing, health and strong-spirit flags remain the native fields themselves.
function scrFRPlayerCompatInit() {
    if(!variable_instance_exists(id,"nearwep")) nearwep=noone;
    // NTT also exposed a programmatic special-input request. The supplied
    // modules read it or copy it into a fire proxy; physical input is still
    // sampled through button_pressed/check and the native power controller.
    if(!variable_instance_exists(id,"usespec")) usespec=false;
    // Read by the native Player reload step and native fusion/charge paths.
    if(!variable_instance_exists(id,"reloadspeed")) reloadspeed=1;
}

function scrFRPlayerCompatGameInit() {
    if(!variable_instance_exists(id,"radmaxextra")) radmaxextra=0;
    // libMuts temporarily preserves this legacy icon-callback counter. It is
    // not Epsilon's mutation RNG stream and must not replace that stream.
    if(!variable_instance_exists(id,"mutindex")) mutindex=0;
}

function scrFRPlayerCompatRadMax(_base) {
    if(!scrFREnabled() || !instance_exists(GameCont)) return _base;
    return max(1,_base+scrNTTEFullValue(GameCont,"radmaxextra",0));
}

function scrFRPlayerCompatSeedName(_field) {
    return _field=="baseseed" || _field=="gameseed" || _field=="atseed";
}

function scrFRPlayerCompatSeedTarget(_target,_field) {
    return scrFRPlayerCompatSeedName(_field) && !is_struct(_target) && !is_array(_target)
        && !is_string(_target) && !is_undefined(_target) && instance_exists(_target) && instance_is(_target,GameCont);
}

function scrFRPlayerCompatSeedField(_field) {
    assert(scrFRPlayerCompatSeedName(_field),"Unexpected legacy controller seed field: "+_field);
    // These are exactly the source ladder fields used by AlternateAreaHandler
    // and Cyberspace's Warp selection. The maintained native Warp adapter
    // builds/advances/replaces this same state at the real room boundary.
    var _seed=scrNTTEFullSourceSeedState();
    return _seed[$ _field];
}

function scrFRPlayerCompatTests() {
    var _player=instance_find(Player,0),_can=_player.can_shoot,_bcan=_player.bcan_shoot,
        _spirit=_player.can_spirit,_heads=_player.headloses,_near=_player.nearwep,_uses=_player.usespec,
        _extra=GameCont.radmaxextra,_seed=GameCont.ntte_full_source_seed,_speed=_player.maxspeed,
        _bonus=GameCont.wib_speedBonus[_player.index],_race=_player.race,_manager=noone;
    try {
        scrFRVariableSet(_player,"canfire",false);scrFRVariableSet(_player,"bcanfire",true);
        scrFRVariableSet(_player,"canspirit",false);scrFRVariableSet(_player,"chickendeaths",4);
        assert(!_player.can_shoot && _player.bcan_shoot && !_player.can_spirit && _player.headloses==4,
            "Legacy player field writes did not reach authoritative native state");
        _player.can_shoot=true;_player.headloses=6;
        assert(scrFRVariableGet(_player,"canfire")==true && scrFRVariableGet(_player,"chickendeaths")==6,
            "Native firing/life changes were hidden from legacy source reads");
        var _prompt=instance_create(_player.x,_player.y,IceFlower);
        _player.nearwep=_prompt;with(_player) scrFRPlayerCompatInit();
        assert(_player.nearwep==_prompt,"Legacy player initialization replaced an active prompt");
        instance_destroy(_prompt,false);_player.nearwep=noone;
        _player.usespec=true;with(_player) scrFRPlayerCompatInit();
        assert(_player.usespec,"A source programmatic special request was cleared by compatibility initialization");
        GameCont.radmaxextra=80;
        assert(scrFRPlayerCompatRadMax(600)==680,"Source radiation-capacity bonus did not affect the native threshold");
        GameCont.radmaxextra=-580;
        assert(scrFRPlayerCompatRadMax(600)==20,"Source minimum ultra radiation capacity changed");
        _player.maxspeed=4*timescale;
        scrFRModCallArray("mod","wibbly","speedBonus_add",[_player.index,1]);
        assert(abs(_player.maxspeed-5*timescale)<0.0001
            && abs(scrFRVariableGet(_player,"maxspeed")-5)<0.0001
            && GameCont.wib_speedBonus[_player.index]==_bonus+1
            && !variable_instance_exists(_player,"speedBonus"),
            "Authored player speed bonus mixed legacy tick and native frame units");
        _player.race=Race.Robot;
        _manager=scrFRModCallArray("mod","wibbly","PlayerManager_create",[55000,55000]);
        assert(instance_exists(_manager),"Source race snapshot fixture did not create its real player manager");
        with(_manager) scrFRModCallArray("mod","wibbly","PlayerManager_step",[]);
        assert(_manager.playerRace[_player.index]=="robot" && _player.race==Race.Robot,
            "Source Robot death-detection snapshot lost its string key or changed native race identity");
        _player.race=19;
        with(_manager) scrFRModCallArray("mod","wibbly","PlayerManager_step",[]);
        assert(_manager.playerRace[_player.index]=="bubbles",
            "Source custom-race death-stat dispatch did not retain its authored module key");
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(57323);
        var _native=scrNTTEFullSourceSeedState();_native.atseed=665;
        assert(scrFRPlayerCompatSeedField("baseseed")==_native.baseseed
            && scrFRPlayerCompatSeedField("gameseed")==_native.gameseed
            && scrFRPlayerCompatSeedField("atseed")==665,
            "Legacy seed reads used stale parallel controller fields");
        scrNTTEFullSourceSeedStage(302,1,2);
        _native=scrNTTEFullSourceSeedState();
        var _ladder=scrFRPlayerCompatSeedField("gameseed");
        assert(scrFRPlayerCompatSeedField("atseed")==_native.atseed
            && _ladder[_native.atseed]==scrNTTEFullSourceWarpSeed(0),
            "Legacy Cyberspace warp reads diverged after native seed-ladder advancement");
        scrNTTESmokeLog("PASS FRONTIER authoritative player fields, prompt/request lifetime, radiation cap and live source seed ladder");
    } finally {
        _player.can_shoot=_can;_player.bcan_shoot=_bcan;_player.can_spirit=_spirit;_player.headloses=_heads;
        _player.nearwep=_near;_player.usespec=_uses;GameCont.radmaxextra=_extra;
        _player.maxspeed=_speed;_player.race=_race;GameCont.wib_speedBonus[_player.index]=_bonus;
        if(instance_exists(_manager)) instance_destroy(_manager,false);
        GameCont.ntte_full_source_seed=_seed;
    }
}
