// Original NTT 9940 scrDrop (YYC 0x005D8730), especially 0x005DB4FF..C13E.
// The third parameter offsets ONLY a seeded enemy's WEAPON stream. A global
// reseed around Epsilon scrDrop changes the pickup roll and is not equivalent.
// Evidence: pickup-drop-annotated.txt and pickup-drop-native-helpers.txt.
function scrNTTEFullPickupDropInit() {
    scrNTTEFullWeaponDropInit()
    global.ntte_full_pickup_drop=scrNTTEFullPickupDropProvider
}

// random_set_seed_w calls cycle(round(seed),1,2147483647); random_w uses
// minstd 48271, not Epsilon's 1103515245/12345 generator or GMS random().
function scrNTTEFullDropSeed(_seed) {
    return (((round(_seed)-1) mod 2147483646)+2147483646) mod 2147483646+1
}
function scrNTTEFullDropRandom(_amount) {
    if(is_undefined(scrNTTEFullValue(GameCont,"ntte_full_pickup_seed",undefined)))
        GameCont.ntte_full_pickup_seed=scrNTTEFullDropSeed(rng_next_int(RNGStates.Pickups))
    GameCont.ntte_full_pickup_seed=(48271*GameCont.ntte_full_pickup_seed) mod 2147483647
    return GameCont.ntte_full_pickup_seed/(2147483647/_amount)
}

function scrNTTEFullPickupDropProvider(_source,_pickup,_weapon,_index=undefined) {
    if(!instance_exists(_source)) return false
    var _result=false
    with(_source) _result=scrNTTEFullPickupDropBody(_pickup,_weapon,_index)
    return _result
}

function scrNTTEFullPickupDropBody(_pickup,_weapon,_index=undefined) {
    var _players=instance_number(Player)
    if(_players<=0) return false
    if(is_undefined(scrNTTEFullValue(GameCont,"ntte_full_pickup_seed",undefined)))
        GameCont.ntte_full_pickup_seed=scrNTTEFullDropSeed(rng_next_int(RNGStates.Pickups))
    var _dropped=false,_heavy=scr_skill_get(mut_heavy_heart),_health=0
    if(scrCrownCheck(crwn_guns)) _weapon+=8
    if(_heavy!=0) _weapon*=power(2.1,_heavy)
    if(scr_ultra_get(Race.Robot,UltraSkill.RefinedTaste)) _weapon+=7*max(0,scrPlayerCountRace(Race.Robot)-1)
    with(Player) if(max_hp>0) _health+=hp/max_hp
    _health/=_players
    // NTT scrFindPlayer(-3) updates the emitting object's actual target.
    target=instance_nearest(x,y,Player)
    var _confiscate=scr_ultra_get(Race.Fish,UltraSkill.Confiscate)
        && scrNTTEFullDropRandom(5)<scrPlayerCountRace(Race.Fish)
    var _x=x+scrNTTEFullDropRandom(4)-2,_y=y+scrNTTEFullDropRandom(4)-2
    if(scrNTTEFullDropRandom(100)<_pickup*scrNTTEFullPickupChanceMultiplier()) {
        // The source compares the mean hp/max_hp, then random(3-hardmode)<2.
        if(scrNTTEFullDropRandom(1)>_health
            && scrNTTEFullDropRandom(3-UberCont.hardmode)<2 && !scrCrownCheck(crwn_life)) {
            if(_confiscate) {instance_create(x,y,FishA);instance_create(x,y,HealthChest)}
            else instance_create(_x,_y,HPPickup)
            _dropped=true
        }
        else if(!scrCrownCheck(crwn_guns)) {
            if(_confiscate) {instance_create(x,y,FishA);instance_create(x,y,AmmoChest)}
            else instance_create(_x,_y,AmmoPickup)
            _dropped=true
        }
    }
    // Source uses wepseed. Epsilon's enemy.dropseed is its corresponding
    // per-enemy WeaponDrops state; props do not gain a made-up enemy seed.
    var _seed=scrNTTEFullValue(id,"wepseed",scrNTTEFullValue(id,"dropseed",0))
    var _seeded=instance_is(id,enemy) && _seed>0,_saved=GameCont.ntte_full_pickup_seed
    if(_seeded) GameCont.ntte_full_pickup_seed=scrNTTEFullDropSeed(_seed+(is_undefined(_index) ? 0:724065*_index))
    if(scrNTTEFullDropRandom(100)<_weapon) {
        if(_confiscate) {instance_create(x,y,WeaponChest);instance_create(x,y,FishA)}
        else {
            // NTT clears caller curse before the native pickup selection.
            // Difficulty filtering consumes the same isolated minstd stream
            // as the weapon roll; telib.weapon_decide is a different path.
            curse=0
            var _context={x:_x,y:_y,curse:0}
            var _item=global.ntte_full_weapon_drop_decide(_context,0,scrNTTEFullDropRandom)
            var _drop=scrWeaponPickupCreate(_x,_y,_item)
            _drop.ammo=true;_drop.curse=0
        }
        _dropped=true
    }
    if(_seeded) GameCont.ntte_full_pickup_seed=_saved
    return _dropped
}

function scrNTTEFullPickupDropUnitTests() {
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _before=scrNTTEFullInstances(all),_player=instance_find(Player,0),_source=instance_create(43016,43016,Bandit)
    // COW is disabled in the project. Preserve modified array cells explicitly;
    // the general instance snapshot intentionally retains collection identity.
    var _skills=GameCont.skills,_empty=ds_list_create(),
        _fish_ultra=GameCont.ultra_got[Race.Fish,UltraSkill.Confiscate],
        _robot_ultra=GameCont.ultra_got[Race.Robot,UltraSkill.RefinedTaste],
        _bullets=_player.ammo[Ammo.Bullets],
        _pickup_seed=scrNTTEFullValue(GameCont,"ntte_full_pickup_seed",undefined)
    GameCont.skills=_empty
    GameCont.ultra_got[Race.Fish,UltraSkill.Confiscate]=0
    GameCont.ultra_got[Race.Robot,UltraSkill.RefinedTaste]=0
    GameCont.crown=Crown.None
    _player.hp=8;_player.max_hp=8;_player.wep=wep_revolver;_player.bwep=wep_revolver
    _player.ammo[Ammo.Bullets]=scrAmmoGetTypeCapacity(Ammo.Bullets)
    scrNTTEFullPickupDropInit()
    GameCont.ntte_full_pickup_seed=1;_source.dropseed=20000
    var _ammo=instance_number(AmmoPickup),_weapons=instance_number(WepPickup)
    global.ntte_full_pickup_drop(_source,1000,100,0)
    assert(instance_number(AmmoPickup)==_ammo+1 && instance_number(WepPickup)==_weapons+1,
        "Original pickup_drop must roll actual ammo and weapon independently")
    _source.dropseed=1;_weapons=instance_number(WepPickup)
    GameCont.ntte_full_pickup_seed=777
    global.ntte_full_pickup_drop(_source,0,20,0)
    var _state0=GameCont.ntte_full_pickup_seed
    assert(instance_number(WepPickup)==_weapons+1,"Original enemy seed=1/index0 weapon roll no longer succeeds at20 percent")
    GameCont.ntte_full_pickup_seed=777
    global.ntte_full_pickup_drop(_source,0,20,1)
    assert(instance_number(WepPickup)==_weapons+1 && GameCont.ntte_full_pickup_seed==_state0,
        "Original724065 index offset failed or weapon substream polluted pickup RNG")
    var _prop=instance_create(43116,43016,NTTEDesertDecor)
    GameCont.ntte_full_pickup_seed=777
    global.ntte_full_pickup_drop(_prop,0,0,0)
    var _unseeded=GameCont.ntte_full_pickup_seed
    GameCont.ntte_full_pickup_seed=777
    global.ntte_full_pickup_drop(_prop,0,0,99)
    assert(GameCont.ntte_full_pickup_seed==_unseeded,"Original non-enemy drops incorrectly consumed the index argument")
    GameCont.skills=_skills
    GameCont.ultra_got[Race.Fish,UltraSkill.Confiscate]=_fish_ultra
    GameCont.ultra_got[Race.Robot,UltraSkill.RefinedTaste]=_robot_ultra
    _player.ammo[Ammo.Bullets]=_bullets
    ds_list_destroy(_empty)
    var _new=scrNTTEFullInstances(all)
    for(var _i=array_length(_new)-1;_i>=0;--_i) if(array_get_index(_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
    // Instance variables cannot be removed through reflection. Undefined is
    // the lazy-initialization sentinel when no state existed before the test.
    GameCont.ntte_full_pickup_seed=_pickup_seed
    scrNTTESmokeLog("FULL ORIGINAL PICKUP DROP: actual independent products, minstd index724065, enemy-only weapon substream and pickup-state isolation OK @"+string(30/timescale))
}
