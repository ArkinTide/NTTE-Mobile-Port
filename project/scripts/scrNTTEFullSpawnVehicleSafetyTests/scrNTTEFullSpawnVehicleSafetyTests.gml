// Real native constructors and final generation provider, controlled room.
function scrNTTEFullSpawnVehicleSafetyTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _rng=scrNTTEFullArrayCopy(global.rng_state),_p=instance_find(Player,0),_hp=_p.hp
    try {
        _p.x=150000;_p.y=150000
        var _areas=[area_scrapyards,area_city]
        for(var _i=0;_i<array_length(_areas);++_i) {
            GameCont.area=_areas[_i]
            var _near=instance_create(_p.x,_p.y,Car),_adjacent=instance_create(_p.x+64,_p.y,Car),
                _edge=instance_create(_p.x+128,_p.y,Car),_far=instance_create(_p.x+224,_p.y,Car),
                _special=instance_create(_p.x,_p.y+16,CarVenus),_tires=instance_create(_p.x,_p.y,Tires),
                _explosions=instance_number(Explosion),_fire=instance_number(GroundFlame),
                _corpse=instance_number(Corpse),_pickups=instance_number(WepPickup),_farhp=_far.hp
            assert(_near.hp==20 && _farhp==20 && (_i!=1 || (_near.spr_idle==sprFrozenCar && _near.spr_hurt==sprFrozenCarHurt)),
                "Safety fixture must use genuine ordinary/frozen native cars")
            random_set_seed(9011+_i);var _expected=random(100000);random_set_seed(9011+_i)
            scrNTTEFullWorldFinalizeLevelStart()
            scrNTTESmokeLog("SPAWN CAR SAFETY area="+string(_areas[_i])+" near="+string(instance_exists(_near))
                +" adjacent="+string(instance_exists(_adjacent))+" edge="+string(instance_exists(_edge)))
            assert(!instance_exists(_near) && !instance_exists(_adjacent) && !instance_exists(_edge),
                "Final generation left an explosive ordinary car inside the player's 128px spawn clearance")
            assert(instance_exists(_far) && _far.hp==_farhp && instance_exists(_special) && instance_exists(_tires),
                "Spawn clearance removed distant cars, the mansion access car or unrelated props")
            assert(instance_number(Explosion)==_explosions && instance_number(GroundFlame)==_fire
                && instance_number(Corpse)==_corpse && instance_number(WepPickup)==_pickups
                && _p.hp==_hp && random(100000)==_expected,
                "Spawn clearance detonated cars, emitted loot/corpses, injured player or consumed RNG")
            scrNTTEFullWorldFinalizeLevelStart()
            assert(instance_exists(_far) && instance_number(Explosion)==_explosions && _p.hp==_hp,
                "Repeated finalization generated an explosion or deleted a distant car")
            // Ordinary gameplay destruction must still retain the native car's
            // actual three explosions and six flames outside the spawn bubble.
            with(_p) scr_hit(_far,_farhp)
            with(_far) event_perform(ev_step,ev_step_begin)
            assert(!instance_exists(_far) && instance_number(Explosion)==_explosions+3
                && instance_number(GroundFlame)==_fire+6,
                "Safety repair suppressed normal native car combat explosions")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        GameCont.area=area_desert
        var _other=instance_create(_p.x,_p.y,Car)
        scrNTTEFullWorldFinalizeLevelStart()
        assert(instance_exists(_other),"Scrapyard/city repair changed an unrelated area's props")
    }
    finally {
        scrNTTEFullAreaGeneratorRestore(_players);global.rng_state=_rng
        scrNTTEFullVanillaFixtureEnd(_state)
    }
    scrNTTESmokeLog("SPAWN VEHICLE SAFETY real ordinary/frozen native cars removed within128px actual Player bounds without Destroy/explosion/fire/loot/corpse/HP/RNG side effects; distant/special/unrelated retained and actual normal combat3explosions6flames preserved @"+string(30/timescale)+"; controlled finalizer, natural generation/iPhone pending")
}
