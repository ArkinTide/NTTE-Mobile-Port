function scrNTTEFullTopEcologyNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,Bones,enemy,prop,chestprop,RadChest,GenCont,NTTEDesertDecor,NTTEFullTopObject]),
        _kinds=["Bandit","Cactus","Chest","Wep"]
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=area_desert;GameCont.hard=3;GameCont.loops=1;GameCont.crown=Crown.None;GameCont.underwater=false
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        for(var _i=0;_i<4;++_i) {
            instance_create(270000,270000,Floor)
            var _decal=instance_create(270016,270016,TopDecalDesert)
            random_set_seed(419+_i)
            var _island=scrNTTEFullTopDesertIsland(_decal,_kinds[_i])
            assert(!instance_exists(_decal) && _island[2]==_kinds[_i] && instance_number(Cactus)>=1
                && instance_number(JungleFly)>=1 && instance_exists(TopSmall),
                "Source Desert special island omitted source decal consumption/cacti/loop flies/real rock top tiles: "+_kinds[_i])
            assert(!collision_circle(_island[0],_island[1],64,Floor,false,false),"Source Desert island did not clear64radius from floor terrain")
            switch(_i) {
                case 0:assert(instance_number(NTTEFullWallEnemy)>=2,"Source Bandit island omitted central/clustered native WallEnemies");break
                case 1:assert(instance_exists(BigWeaponChest) && instance_exists(BonePile),"Source Cactus island omitted real large chest/BonePile");break
                case 2:assert(instance_exists(AmmoChest) || instance_exists(HealthChest),"Source Chest island omitted actual source chest");break
                case 3:
                    var _ground=instance_find(NTTEFullWepPickupGrounded,0)
                    assert(instance_exists(_ground) && instance_exists(_ground.target) && _ground.target.ammo && _ground.target.roll
                        && instance_exists(_ground.top_object) && _ground.top_object.target==_ground,
                        "Source Wep island omitted actual native weapon decision/held pickup/TopCreate ownership")
                    break
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
        // Genuine random selector branches, including the original two Raven
        // placement variants and actual Palace heading toward the nearby floor.
        var _types=[TopDecalNightDesert,TopDecalScrapyard,TopDecalScrapyard,TopDecalPalace],
            _areas=[area_campfire,area_scrapyards,area_scrapyards,area_palace],
            _targets=[NightCactus,NTTEFullTopRaven,NTTEFullTopRaven,Pillar]
        for(var _i=0;_i<4;++_i) {
            GameCont.area=_areas[_i];GameCont.loops=0
            instance_create(274000,274000,Floor)
            var _decal=instance_create(274080,274016,_types[_i])
            _decal.image_index=_i==1?1:0
            var _chosen=-1
            // Replay the real native shuffle too, rather than assuming its
            // internal random draw count for a single-element array.
            for(var _s=0;_s<100;++_s) {
                random_set_seed(_s);random(5);array_shuffle([_decal])
                if(random(2)<1) {_chosen=_s;break}
            }
            assert(_chosen>=0,"Top ecology fixture could not select genuine native source chance")
            random_set_seed(_chosen);scrNTTEFullTopEcologyLevelStart()
            assert(instance_number(_targets[_i])==1 && instance_exists(_decal),
                "Source TopDecal selector omitted real target or incorrectly consumed its ordinary decal: "+string(_i))
            var _target=instance_find(_targets[_i],0),_wrap=_target.ntte_full_top_object
            assert(instance_exists(_wrap) && _wrap.target==_target,"Source ordinary TopDecal actor bypassed actual TopCreate ownership")
            if(_i==1) assert(_wrap.spawn_dis==0 && _wrap.spawn_dir==0,"Source upright Scrapyard decal did not retain stationary Raven branch")
            if(_i==2) assert(_wrap.spawn_dis>0,"Source flat Scrapyard decal did not retain outward Raven branch")
            if(_i==3) assert(_wrap.spawn_dis>=16 && _wrap.spawn_dis<=64,"Source Palace pillar distance lost16..64range")
            scrNTTEFullMergedRuntimeTestCleanup(_before)
        }
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        random_set_seed(_seed);scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    }
    scrNTTESmokeLog("FULL TOP ECOLOGY all4actual Desert island reward branches/64radius terrain clearance/real wall enemies+cacti+loop flies+rock tops/actual grounded selected weapon/real NightCactus/two Raven selectors/Palace pillar/TopCreate ownership OK @"+string(30/timescale))
}
