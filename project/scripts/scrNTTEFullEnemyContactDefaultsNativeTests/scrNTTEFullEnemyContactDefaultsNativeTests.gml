// Original CustomEnemy.Create sets meleedamage=0 before native enemy inheritance.
// Native collision dispatch must still push, and real positive damage must stay.
function scrNTTEFullEnemyContactDefaultsNativeTests() {
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_stop=lockstep_stop,
        _snapshot=scrNTTEFullAreaGeneratorSnapshot([GameCont,Player,UberCont]),
        _player=instance_find(Player,0)
    try {
        lockstep_stop=false
        var _nest=instance_create(156000,156000,NTTEFullBigMaggotSpawn),
            _prop=instance_create(156000,156000,Cactus)
        assert(variable_instance_exists(_nest,"meleedamage") && _nest.meleedamage==0,
            "Genuine custom nest lost source default zero contact damage")
        _prop.hp=100;_prop.max_hp=100;_prop.nexthurt=-1
        var _hp=_prop.hp
        with(_prop) with(_nest) event_perform(ev_collision,prop)
        assert(instance_exists(_prop) && _prop.hp==_hp && _nest.speed>0,
            "Actual inherited prop collision failed safe zero damage plus native pushing")
        _player.hp=100;_player.max_hp=100;_player.nexthurt=-1
        var _alarm=_nest.alarm[11]
        with(_player) with(_nest) event_perform(ev_collision,Player)
        assert(_player.hp==100 && _nest.canmelee && _nest.alarm[11]==_alarm,
            "Zero-damage source nest invented melee damage/cooldown in native Player collision")
        var _guard=instance_create(156064,156000,DogGuardian)
        assert(_guard.meleedamage==6,"Native positive child contact damage overwritten by default")
        _prop.nexthurt=-1
        with(_prop) with(_guard) event_perform(ev_collision,prop)
        assert(_prop.hp==_hp-6,"Genuine native prop collision lost declared six contact damage")
        var _van=instance_create(156128,156000,Van),
            _horror=instance_create(156192,156000,HostileHorror)
        assert(_van.meleedamage==20 && _horror.meleedamage==4,
            "Default contact initialization changed explicit native child damage")
        _guard.canmelee=true;_guard.alarm[11]=-1
        var _player_hp=_player.hp
        with(_player) with(_guard) event_perform(ev_collision,Player)
        assert(_player.hp==_player_hp-6 && !_guard.canmelee && _guard.alarm[11]==30,
            "Actual positive Player contact lost damage or native melee cooldown")
        scrNTTESmokeLog("FULL ENEMY CONTACT DEFAULTS: source CustomEnemy zero default/genuine nest+prop+Player inherited collisions/push/no phantom cooldown/native DogGuardian6 Van20 HostileHorror4 and real positive damage/cooldown preserved OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_snapshot)
        lockstep_stop=_stop;random_set_seed(_seed)
    }
}
