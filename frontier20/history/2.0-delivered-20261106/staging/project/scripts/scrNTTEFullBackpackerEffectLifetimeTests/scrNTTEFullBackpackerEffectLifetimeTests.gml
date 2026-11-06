// Source: tepickups Backpacker_death + telib fx's with(obj_create(...)).
// Exercise actual native Dust constructors and inherited prop BeginStep/Destroy.
// This focused lifecycle regression does not substitute for the natural Parrot chain.
function scrNTTEFullBackpackerEffectLifetimeTests() {
    assert(!instance_exists(GenCont) && instance_exists(GameCont) && instance_exists(UberCont),
        "Backpacker effect lifetime regression requires a settled native room")
    var _snapshot=scrNTTEFullInstances(all),_seed=random_get_seed(),_stop=lockstep_stop,
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _particles=UberCont.opt_prtcls
    try {
        lockstep_stop=false
        // Use the native desert room only for the isolated constructor probe;
        // natural Trench3 combat remains covered by the connected acceptance.
        GameCont.area=area_desert;GameCont.lastarea=area_desert
        var _modes=["ground particles","underwater replacement","particles disabled"]
        for(var _i=0;_i<array_length(_modes);++_i) {
            GameCont.underwater=(_i==1); UberCont.opt_prtcls=(_i!=2)
            var _before=scrNTTEFullInstances(all),_bubbles=instance_number(Bubble),
                _dust=instance_create(42000+64*_i,42000,Dust)
            assert(instance_exists(_dust)==(_i==0),
                "Actual native Dust constructor lifetime differs from the fixture precondition: "+_modes[_i])
            assert(instance_number(Bubble)==_bubbles+(_i==1?1:0),
                "Actual native underwater Dust constructor did not produce exactly one Bubble")
            scrNTTESmokeLog("BACKPACKER ACTUAL DUST CONSTRUCTOR "+_modes[_i]+" returned="+string(_dust)+" live="+string(instance_exists(_dust)))
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            var _weapons=instance_number(WepPickup),_bones=instance_number(NTTEFullBonePickup),
                _live_dust=instance_number(Dust),_bubbles=instance_number(Bubble),
                _b=instance_create(42000+64*_i,42000,NTTEFullBackpacker)
            assert(_b.hp==5 && _b.wep=="crabbone","Backpacker source initial HP/weapon changed")
            _b.hp=0
            // Original prop BeginStep invokes instance_destroy; no direct death callback.
            with(_b) event_perform(ev_step,ev_step_begin)
            var _drop=noone
            with(WepPickup) if(array_get_index(_before,id)<0) _drop=id
            assert(!instance_exists(_b) && instance_number(WepPickup)==_weapons+1
                && instance_number(NTTEFullBonePickup)==_bones+6,
                "Actual Backpacker death failed one source weapon/six bone ammo pickups: "+_modes[_i])
            assert(instance_exists(_drop) && _drop.wep==wep_ntte_bone && _drop.ammo
                && _drop.name==loc("NTTE:Bone","BONE") && _drop.sprite_index==scrNTTERefSprite("Bone"),
                "Effect constructor lifetime corrupted actual Backpacker weapon metadata")
            assert(instance_number(Dust)==_live_dust+(_i==0?8:0)
                && instance_number(Bubble)==_bubbles+(_i==1?8:0),
                "Backpacker native ground/underwater/disabled constructor effects changed")
            scrNTTEFullMergedRuntimeTestCleanup(_before)

            var _b=instance_create(42256+64*_i,42000,NTTEFullBackpacker)
            instance_destroy(_b)
            assert(instance_number(WepPickup)==_weapons && instance_number(NTTEFullBonePickup)==_bones
                && instance_number(Dust)==_live_dust && instance_number(Bubble)==_bubbles,
                "Nonlethal Backpacker removal generated source death loot/effects")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        UberCont.opt_prtcls=_particles;lockstep_stop=_stop;random_set_seed(_seed)
    }
    scrNTTESmokeLog("BACKPACKER EFFECT LIFETIME actual native constructor/inherited BeginStep/Destroy ground8Dust/underwater8Bubble/disabled0Effects exact1weapon+6bones and nonlethal exclusion OK")
}
