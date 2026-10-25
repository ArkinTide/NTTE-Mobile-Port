// Source-proven CustomProjectile descendants only. Verify the
// actual event boundary; direct authored Hit helpers remain source-literal.
function scrNTTEFullCustomProjectileGateTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _oldmode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        _oldtest=variable_global_exists("ntte_full_gate_callback_count")?global.ntte_full_gate_callback_count:0,
        _seed=random_get_seed();
    global.ntte_merge_native_collision_mode=true;
    global.ntte_full_gate_callback_count=0;
    try {
        var _victim=instance_create(5500,5500,Bandit),_classes=[NTTEAlbinoBolt,NTTEAlbinoGrenade,NTTEBatScreech,NTTEFullBatDisc,NTTEFullBoneArrow,NTTEFullBoneArtifactLaserCannon,NTTEFullBoneSlash,NTTEFullBubbleBomb,NTTEFullBubbleSlash,NTTEFullClamShield,NTTEFullCrabboneBone,NTTEFullCrystalHeartBullet,NTTEFullCustomBullet,NTTEFullCustomFlak,NTTEFullCustomPlasma,NTTEFullCustomShell,NTTEFullDiverHarpoon,NTTEFullElectroPlasma,NTTEFullEnergyBatSlash,NTTEFullGatorStatueFlak,NTTEFullHarpoon,NTTEFullLightningDisc,NTTEFullMortarPlasma,NTTEFullNetNade,NTTEFullPalankingSlash,NTTEFullPortalBullet,NTTEFullQuasarBeam,NTTEFullRedBullet,NTTEFullRedSlash,NTTEFullSealAnchor,NTTEFullSmallLastBall,NTTEFullTeslaCoil,NTTEFullTesseractArmDeath,NTTEFullTrident,NTTEFullVenomBlast,NTTEFullVenomFlak,NTTEFullVlasmaBullet,NTTELightningDisc,NTTERogueCarbineBullet,NTTEVenomPellet,NTTEFullElectroPlasmaBig,NTTEFullPalankingSlashGround,NTTEFullQuasarRing,NTTEFullUltraQuasarBeam,NTTEFullVlasmaCannon];
        _victim.team=team_player;_victim.hp=1000;
        for(var _i=0;_i<array_length(_classes);++_i) {
            var _shot=instance_create(_victim.x,_victim.y,_classes[_i]);
            _shot.team=_victim.team;
            scrNTTEFullMergedProjectileAddEvent(_shot,"hit",function() {
                global.ntte_full_gate_callback_count+=1;
            });
            with(_victim) with(_shot) event_perform(ev_collision,hitme);
            assert(instance_exists(_shot) && _victim.hp==1000
                && global.ntte_full_gate_callback_count==0,
                "Original CustomProjectile same-team collision reached source/merged callback: "+object_get_name(_classes[_i]));
            instance_destroy(_shot,false);
        }
        assert(!variable_global_exists("ntte_merge_native_collision_stack")
            || !array_length(global.ntte_merge_native_collision_stack),
            "Source team gate leaked a merged collision stack entry");
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_game);
        global.ntte_merge_native_collision_mode=_oldmode;
        global.ntte_full_gate_callback_count=_oldtest;
        random_set_seed(_seed);
    }
    scrNTTESmokeLog("FULL CUSTOM PROJECTILE OUTER GATES: 45 source-proven actual native/inherited collisions reject same-team before authored and merged callbacks OK @"+string(30/timescale));
}
