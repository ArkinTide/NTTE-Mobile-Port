// Explicit desktop-only internal tests; no mobile gameplay activation.
function scrNTTEFullSmokeEnabled() {
    if(os_type!=os_windows) return false
    for(var _i=1;_i<=parameter_count();++_i) if(parameter_string(_i)=="--ntte-full-smoke") return true
    return false
}
function scrNTTEFullSmokeDomain(_name) {
    for(var _i=1;_i<=parameter_count();++_i) {
        var _arg=parameter_string(_i);
        if(string_pos("--ntte-full-domain=",_arg)==1)
            return _arg=="--ntte-full-domain="+_name;
    }
    return true;
}
function scrNTTEFullSmokeCase(_name) {
    var _selected=true;
    for(var _i=1;_i<=parameter_count();++_i) {
        var _arg=parameter_string(_i);
        if(string_pos("--ntte-full-case=",_arg)==1) _selected=_arg=="--ntte-full-case="+_name;
    }
    if(_selected) { global.ntte_full_test_count+=1; scrNTTESmokeLog("CASE "+_name); }
    return _selected;
}
function scrNTTEFullSmokeAsyncCase(_name) {
    // Live-world fixtures temporarily park the driver and must run alone.
    for(var _i=1;_i<=parameter_count();++_i)
        if(parameter_string(_i)=="--ntte-full-case="+_name) return scrNTTEFullSmokeCase(_name);
    return false;
}
function scrNTTEFullSmokeFixture() {
    instance_destroy(PortalClear,false);
    instance_destroy(PortalShock,false);
    instance_destroy(FloorExplo,false);
    instance_destroy(Wall,false);
    instance_destroy(Top,false);
    instance_destroy(TopSmall,false);
    instance_destroy(Floor,false);
    for(var _dx=-5;_dx<=5;++_dx) for(var _dy=-4;_dy<=4;++_dy)
        instance_create(10000+_dx*32,10000+_dy*32,Floor);
    with(Floor) mcr_floor_make_walls;
}
function scrNTTEFullSmokeStep() {
    if(tick==0) {
        UberCont.opt_framerate=rates[pass_index]
        game_set_speed(rates[pass_index],gamespeed_fps)
        GameCont.loops=0
        GameCont.area=area_desert
        GameCont.underwater=false
        GameCont.crown=Crown.None
        scrNTTEFullSmokeFixture()
        scrNTTEFullSystemsInit()
        with(Player) {
            x=10016; y=10016; hp=10000; max_hp=10000; lsthealth=10000
            nexthurt=current_frame+10000; speed=0; can_walk=false; can_aim=false
        }
        tick=1
        return;
    }
    if(tick==1) {
        if(scrNTTEFullParrotPauseWaitForNativeDraw()) return;
        global.ntte_full_test_count=0;
        scrNTTESmokeLog("FULL INTERNAL BEGIN @"+string(30/timescale))
        if(scrNTTEFullSmokeAsyncCase("UndergrowthNaturalTests")) {scrUGNaturalTests();return;}
        if(scrNTTEFullSmokeCase("UndergrowthEntityTests")) scrUndergrowthEntityTests();
        if(scrNTTEFullSmokeCase("UndergrowthWeaponTests")) scrUndergrowthWeaponTests();
        if(scrNTTEFullSmokeCase("UndergrowthAreaTests")) scrUndergrowthAreaTests();
        if(scrNTTEFullSmokeCase("UndergrowthIntegrationTests")) scrUndergrowthIntegrationTests();
        if(scrNTTEFullSmokeCase("AreaMetadataTests")) scrNTTEFullAreaMetadataTests();
        if(scrNTTEFullSmokeDomain("world")) {
            if(scrNTTEFullSmokeCase("WorldSmoke")) scrNTTEFullWorldSmoke();
            if(scrNTTEFullSmokeCase("AreaTerrainSmoke")) scrNTTEFullAreaTerrainSmoke();
            if(scrNTTEFullSmokeCase("WorldLifecycleSmoke")) scrNTTEFullWorldLifecycleSmoke();
            if(scrNTTEFullSmokeCase("WorldMortarSmoke")) scrNTTEFullWorldMortarSmoke();
            if(scrNTTEFullSmokeCase("WorldCoastBasicSmoke")) scrNTTEFullWorldCoastBasicSmoke();
            if(scrNTTEFullSmokeCase("IOSShadowPresentTests")) scrNTTEFullIOSShadowPresentTests();
            if(scrNTTEFullSmokeCase("CoastUnblendSmoke")) scrNTTEFullCoastUnblendSmoke();
            if(scrNTTEFullSmokeCase("CoastConstructSmoke")) scrNTTEFullCoastConstructSmoke();
            if(scrNTTEFullSmokeCase("CoastSeaSmoke")) scrNTTEFullCoastSeaSmoke();
            if(scrNTTEFullSmokeCase("CoastNormalLifecycleSmoke")) scrNTTEFullCoastNormalLifecycleSmoke();
            if(scrNTTEFullSmokeCase("PalankingTossSmoke")) scrNTTEFullPalankingTossSmoke();
            if(scrNTTEFullSmokeCase("SpiderlingSmoke")) scrNTTEFullSpiderlingSmoke();
            if(scrNTTEFullSmokeCase("PortalWeaponSmoke")) scrNTTEFullPortalWeaponSmoke();
            if(scrNTTEFullSmokeCase("TopSmoke")) scrNTTEFullTopSmoke();
            if(scrNTTEFullSmokeCase("WorldKillEnemiesTests")) scrNTTEFullWorldKillEnemiesTests();
            if(scrNTTEFullSmokeCase("TopDecalFactoryTests")) scrNTTEFullTopDecalFactoryTests();
            if(scrNTTEFullSmokeCase("PickupFoundationSmoke")) scrNTTEFullPickupFoundationSmoke();
            if(scrNTTEFullSmokeCase("CustomPickupSmoke")) scrNTTEFullCustomPickupSmoke();
            if(scrNTTEFullSmokeCase("BonePickupTests")) scrNTTEFullBonePickupTests();
            if(scrNTTEFullSmokeCase("BonusPickupSmoke")) scrNTTEFullBonusPickupSmoke();
            if(scrNTTEFullSmokeCase("BonusMimicSmoke")) scrNTTEFullBonusMimicSmoke();
            if(scrNTTEFullSmokeCase("BonusHUDSaveTests")) scrNTTEFullBonusHUDSaveTests();
            if(scrNTTEFullSmokeCase("BonusVisualTests")) scrNTTEFullBonusVisualTests();
            if(scrNTTEFullSmokeCase("BonusCrownTests")) scrNTTEFullBonusCrownTests();
            if(scrNTTEFullSmokeCase("TextMarkupTests")) scrNTTEFullTextMarkupTests();
            if(scrNTTEFullSmokeCase("WeaponShineTests")) scrNTTEFullWeaponShineTests();
            if(scrNTTEFullSmokeCase("MergedWeaponModelTests")) scrNTTEFullMergedWeaponModelTests();
            if(scrNTTEFullSmokeCase("MergedSpriteTests")) scrNTTEFullMergedSpriteTests();
            if(scrNTTEFullSmokeCase("MergedTextTests")) scrNTTEFullMergedTextTests();
            if(scrNTTEFullSmokeCase("MergedLoadoutTests")) scrNTTEFullMergedLoadoutTests();
            if(scrNTTEFullSmokeCase("ScytheStateTests")) scrNTTEFullScytheStateTests();
            if(scrNTTEFullSmokeCase("ScytheAttackTests")) scrNTTEFullScytheAttackTests();
            if(scrNTTEFullSmokeCase("ClamWeaponTests")) scrNTTEFullClamWeaponTests();
            if(scrNTTEFullSmokeCase("TunnelTerrainSmoke")) scrNTTEFullTunnelTerrainSmoke();
            if(scrNTTEFullSmokeCase("CrystalHeartSmoke")) scrNTTEFullCrystalHeartSmoke();
            if(scrNTTEFullSmokeCase("CrystalHeartContactSmoke")) scrNTTEFullCrystalHeartContactSmoke();
            if(scrNTTEFullSmokeCase("CrystalHeartUnfoldSmoke")) scrNTTEFullCrystalHeartUnfoldSmoke();
            if(scrNTTEFullSmokeCase("FloorSmoke")) scrNTTEFullFloorSmoke();
            if(scrNTTEFullSmokeCase("WorldExplosionSmoke")) scrNTTEFullWorldExplosionSmoke();
            if(scrNTTEFullSmokeCase("DiverSmoke")) scrNTTEFullDiverSmoke();
            if(scrNTTEFullSmokeCase("BanditCampSmoke")) scrNTTEFullBanditCampSmoke();
            if(scrNTTEFullSmokeCase("CoastSecondarySmoke")) scrNTTEFullCoastSecondarySmoke();
            if(scrNTTEFullSmokeCase("WorldEventBuildersSmoke")) scrNTTEFullWorldEventBuildersSmoke();
            if(scrNTTEFullSmokeCase("EelGraveSmoke")) scrNTTEFullEelGraveSmoke();
            if(scrNTTEFullSmokeCase("BackpackPickupSmoke")) scrNTTEFullBackpackPickupSmoke();
            if(scrNTTEFullSmokeCase("WorldMiscSmoke")) scrNTTEFullWorldMiscSmoke();
            if(scrNTTEFullSmokeCase("PelicanSmoke")) scrNTTEFullPelicanSmoke();
            if(scrNTTEFullSmokeCase("GhostSmoke")) scrNTTEFullGhostSmoke();
            if(scrNTTEFullSmokeCase("ScorpionRockSmoke")) scrNTTEFullScorpionRockSmoke();
            if(scrNTTEFullSmokeCase("MaggotParkEntitiesSmoke")) scrNTTEFullMaggotParkEntitiesSmoke();
            if(scrNTTEFullSmokeCase("MaggotParkEventSmoke")) scrNTTEFullMaggotParkEventSmoke();
            if(scrNTTEFullSmokeCase("WorldEventsSmoke")) scrNTTEFullWorldEventsSmoke();
            if(scrNTTEFullSmokeCase("BoneRavenSmoke")) scrNTTEFullBoneRavenSmoke();
            if(scrNTTEFullSmokeCase("SludgePoolSmoke")) scrNTTEFullSludgePoolSmoke();
            if(scrNTTEFullSmokeCase("SludgeShaderSmoke")) scrNTTEFullSludgeShaderSmoke();
            if(scrNTTEFullSmokeCase("TopRavenSmoke")) scrNTTEFullTopRavenSmoke();
            if(scrNTTEFullSmokeCase("SewerPoolSmoke")) scrNTTEFullSewerPoolSmoke();
            if(scrNTTEFullSmokeCase("ScorpionCitySmoke")) scrNTTEFullScorpionCitySmoke();
            if(scrNTTEFullSmokeCase("SilverScorpionTests")) scrNTTEFullSilverScorpionTests();
            if(scrNTTEFullSmokeCase("RavenArenaControlSmoke")) scrNTTEFullRavenArenaControlSmoke();
            if(scrNTTEFullSmokeCase("TrapSpinSmoke")) scrNTTEFullTrapSpinSmoke();
            if(scrNTTEFullSmokeCase("PalaceAltarSmoke")) scrNTTEFullPalaceAltarSmoke();
            if(scrNTTEFullSmokeCase("RavenArenaBuilderSmoke")) scrNTTEFullRavenArenaBuilderSmoke();
            if(scrNTTEFullSmokeCase("WallCrateSmoke")) scrNTTEFullWallCrateSmoke();
            if(scrNTTEFullSmokeCase("BigPipeSmoke")) scrNTTEFullBigPipeSmoke();
            if(scrNTTEFullSmokeCase("GatorAmbushSmoke")) scrNTTEFullGatorAmbushSmoke();
            if(scrNTTEFullSmokeCase("GatorDenSmoke")) scrNTTEFullGatorDenSmoke();
            if(scrNTTEFullSmokeCase("CoastProjectilesSmoke")) scrNTTEFullCoastProjectilesSmoke();
            if(scrNTTEFullSmokeCase("SealSmoke")) scrNTTEFullSealSmoke();
            if(scrNTTEFullSmokeAsyncCase("DeadeyeNaturalTests")) scrNTTEFullDeadeyeNaturalTests();
            if(scrNTTEFullSmokeCase("CoastAppendPerformanceTests")) scrNTTEFullCoastAppendPerformanceTests();
            if(scrNTTEFullSmokeCase("CoastWadingPerformanceTests")) scrNTTEFullCoastWadingPerformanceTests();
            if(scrNTTEFullSmokeCase("RedWallScanPerformanceTests")) scrNTTEFullRedWallScanPerformanceTests();
            if(scrNTTEFullSmokeCase("SealHeavySmoke")) scrNTTEFullSealHeavySmoke();
            if(scrNTTEFullSmokeCase("SealWaveSmoke")) scrNTTEFullSealWaveSmoke();
            if(scrNTTEFullSmokeCase("PalankingSmoke")) scrNTTEFullPalankingSmoke();
            if(scrNTTEFullSmokeCase("CoastBossBecomeSmoke")) scrNTTEFullCoastBossBecomeSmoke();
            if(scrNTTEFullSmokeCase("CoastBossSmoke")) scrNTTEFullCoastBossSmoke();
            if(scrNTTEFullSmokeCase("CoastBossDeathSmoke")) scrNTTEFullCoastBossDeathSmoke();
            if(scrNTTEFullSmokeCase("BubbleBombSmoke")) scrNTTEFullBubbleBombSmoke();
            if(scrNTTEFullSmokeCase("OasisEntitiesSmoke")) scrNTTEFullOasisEntitiesSmoke();
            if(scrNTTEFullSmokeCase("SunkenChestSmoke")) scrNTTEFullSunkenChestSmoke();
            if(scrNTTEFullSmokeCase("OasisNormalLifecycleSmoke")) scrNTTEFullOasisNormalLifecycleSmoke();
            if(scrNTTEFullSmokeCase("PizzaPropsSmoke")) scrNTTEFullPizzaPropsSmoke();
            if(scrNTTEFullSmokeCase("PizzaSpiralSmoke")) scrNTTEFullPizzaSpiralSmoke();
            if(scrNTTEFullSmokeCase("PizzaNormalLifecycleSmoke")) scrNTTEFullPizzaNormalLifecycleSmoke();
            if(scrNTTEFullSmokeCase("TrafficCrabSmoke")) scrNTTEFullTrafficCrabSmoke();
            if(scrNTTEFullSmokeCase("CoastDecorSmoke")) scrNTTEFullCoastDecorSmoke();
            if(scrNTTEFullSmokeCase("PortalPickupsSmoke")) scrNTTEFullPortalPickupsSmoke();
            if(scrNTTEFullSmokeCase("SealSettlementSmoke")) scrNTTEFullSealSettlementSmoke();
            if(scrNTTEFullSmokeCase("SealSettlementDeathSmoke")) scrNTTEFullSealSettlementDeathSmoke();
            if(scrNTTEFullSmokeCase("SealPlazaSmoke")) scrNTTEFullSealPlazaSmoke();
            if(scrNTTEFullSmokeCase("MutantVatSmoke")) scrNTTEFullMutantVatSmoke();
            if(scrNTTEFullSmokeCase("MutantVatsEventSmoke")) scrNTTEFullMutantVatsEventSmoke();
            if(scrNTTEFullSmokeCase("PopoAmbushSmoke")) scrNTTEFullPopoAmbushSmoke();
            if(scrNTTEFullSmokeCase("BackpackerSmoke")) scrNTTEFullBackpackerSmoke();
            if(scrNTTEFullSmokeCase("BlockedRoomSmoke")) scrNTTEFullBlockedRoomSmoke();
            if(scrNTTEFullSmokeCase("WallEnemySmoke")) scrNTTEFullWallEnemySmoke();
            if(scrNTTEFullSmokeCase("WeaponDecideTests")) scrNTTEFullWeaponDecideTests();
            if(scrNTTEFullSmokeCase("PalaceShrineSkillsSmoke")) scrNTTEFullPalaceShrineSkillsSmoke();
        }
        if(scrNTTEFullSmokeDomain("sewer")) {
            if(scrNTTEFullSmokeCase("TrenchUnitTests")) scrNTTEFullTrenchUnitTests();
            if(scrNTTEFullSmokeCase("SewerBossUnitTests")) scrNTTEFullSewerBossUnitTests();
            if(scrNTTEFullSmokeCase("LairWorldUnitTests")) scrNTTEFullLairWorldUnitTests();
            if(scrNTTEFullSmokeCase("TrenchPitUnitTests")) scrNTTEFullTrenchPitUnitTests();
            if(scrNTTEFullSmokeCase("TrenchBossWeaponUnitTests")) scrNTTEFullTrenchBossWeaponUnitTests();
            if(scrNTTEFullSmokeCase("TrenchPropsUnitTests")) scrNTTEFullTrenchPropsUnitTests();
            if(scrNTTEFullSmokeCase("TrenchTerrainUnitTests")) scrNTTEFullTrenchTerrainUnitTests();
            if(scrNTTEFullSmokeCase("LairPopulationUnitTests")) scrNTTEFullLairPopulationUnitTests();
            if(scrNTTEFullSmokeCase("TrenchNativeEffectsUnitTests")) scrNTTEFullTrenchNativeEffectsUnitTests();
            if(scrNTTEFullSmokeCase("PitSquidEyeChargeFXTests")) scrNTTEFullPitSquidEyeChargeFXTests();
            if(scrNTTEFullSmokeCase("UnlockPresentationTests")) scrNTTEFullUnlockPresentationTests();
            if(scrNTTEFullSmokeCase("UnlockPresentationLifecycleTests")) scrNTTEFullUnlockPresentationLifecycleTests();
            if(scrNTTEFullSmokeCase("TrenchPickupMultiplierUnitTests")) scrNTTEFullTrenchPickupMultiplierUnitTests();
            if(scrNTTEFullSmokeCase("TrenchQuasarVariantsUnitTests")) scrNTTEFullTrenchQuasarVariantsUnitTests();
            if(scrNTTEFullSmokeCase("SewerTransitionsUnitTests")) scrNTTEFullSewerTransitionsUnitTests();
            if(scrNTTEFullSmokeCase("InRoomGenerationUnitTests")) scrNTTEFullInRoomGenerationUnitTests();
            if(scrNTTEFullSmokeCase("AreaSetContextNativeTests")) scrNTTEFullAreaSetContextNativeTests();
            if(scrNTTEFullSmokeCase("PathGridBoundsNativeTests")) scrNTTEFullPathGridBoundsNativeTests();
            if(scrNTTEFullSmokeCase("PitSquidClearNativeTests")) scrNTTEFullPitSquidClearNativeTests();
            if(scrNTTEFullSmokeCase("AreaSnapshotUnitTests")) scrNTTEFullAreaSnapshotUnitTests();
            if(scrNTTEFullSmokeCase("MergedNativeInventoryUnitTests")) scrNTTEFullMergedNativeInventoryUnitTests();
            if(scrNTTEFullSmokeCase("LairNormalLifecycleUnitTests")) scrNTTEFullLairNormalLifecycleUnitTests();
            if(scrNTTEFullSmokeCase("TrenchNormalLifecycleUnitTests")) scrNTTEFullTrenchNormalLifecycleUnitTests();
            if(scrNTTEFullSmokeCase("LairShopFoundationUnitTests")) scrNTTEFullLairShopFoundationUnitTests();
            if(scrNTTEFullSmokeCase("LairShopMergedUnitTests")) scrNTTEFullLairShopMergedUnitTests();
            if(scrNTTEFullSmokeCase("LairTurretUnitTests")) scrNTTEFullLairTurretUnitTests();
            if(scrNTTEFullSmokeCase("LairMutationRewardUnitTests")) scrNTTEFullLairMutationRewardUnitTests();
            if(scrNTTEFullSmokeCase("GuardianProjectileUnitTests")) scrNTTEFullGuardianProjectileUnitTests();
            if(scrNTTEFullSmokeCase("PickupDropUnitTests")) scrNTTEFullPickupDropUnitTests();
            if(scrNTTEFullSmokeCase("WeaponDropUnitTests")) scrNTTEFullWeaponDropUnitTests();
            if(scrNTTEFullSmokeCase("WeaponDropLifecycleUnitTests")) scrNTTEFullWeaponDropLifecycleUnitTests();
        }
        if(scrNTTEFullSmokeDomain("systems")) {
        if(scrNTTEFullSmokeCase("SystemsStateTests")) scrNTTEFullSystemsStateTests();
        if(scrNTTEFullSmokeCase("RaceMetadataTests")) scrNTTEFullRaceMetadataTests();
        if(scrNTTEFullSmokeCase("RaceNativeMetadataTests")) scrNTTEFullRaceNativeMetadataTests();
        if(scrNTTEFullSmokeCase("RaceNativeLifecycleTests")) scrNTTEFullRaceNativeLifecycleTests();
        if(scrNTTEFullSmokeCase("RaceNativeUltraTests")) scrNTTEFullRaceNativeUltraTests();
        if(scrNTTEFullSmokeCase("BeetleModelTests")) scrNTTEFullBeetleModelTests();
        if(scrNTTEFullSmokeCase("BeetleInventoryTests")) scrNTTEFullBeetleInventoryTests();
        if(scrNTTEFullSmokeCase("BeetleMenuTests")) scrNTTEFullBeetleMenuTests();
        if(scrNTTEFullSmokeCase("BeetleChestTests")) scrNTTEFullBeetleChestTests();
        if(scrNTTEFullSmokeCase("MergedFireAccountingTests")) scrNTTEFullMergedFireAccountingTests();
        if(scrNTTEFullSmokeCase("MergedEffectsUnitTests")) scrNTTEFullMergedEffectsUnitTests();
        if(scrNTTEFullSmokeCase("MergedBasicUnitTests")) scrNTTEFullMergedBasicUnitTests();
        if(scrNTTEFullSmokeCase("MergedStockNativeTests")) scrNTTEFullMergedStockNativeTests();
        if(scrNTTEFullSmokeCase("MergedStockExtraTests")) scrNTTEFullMergedStockExtraTests();
        if(scrNTTEFullSmokeCase("MergedCustomStockTests")) scrNTTEFullMergedCustomStockTests();
        if(scrNTTEFullSmokeCase("HarpoonControllerTypeTests")) scrNTTEFullHarpoonControllerTypeTests();
        if(scrNTTEFullSmokeCase("CustomProjectileWeaponTests")) scrNTTEFullCustomProjectileWeaponTests();
        if(scrNTTEFullSmokeCase("MergedCustomRedTests")) scrNTTEFullMergedCustomRedTests();
        if(scrNTTEFullSmokeCase("MergedPayloadUnitTests")) scrNTTEFullMergedPayloadUnitTests();
        if(scrNTTEFullSmokeCase("MergedTransactionTests")) scrNTTEFullMergedTransactionTests();
        if(scrNTTEFullSmokeCase("MergedNativeCollisionTests")) scrNTTEFullMergedNativeCollisionTests();
        if(scrNTTEFullSmokeCase("MergedNativePayloadTests")) scrNTTEFullMergedNativePayloadTests();
        if(scrNTTEFullSmokeCase("MergedExplosiveUnitTests")) scrNTTEFullMergedExplosiveUnitTests();
        if(scrNTTEFullSmokeCase("MergedMotionUnitTests")) scrNTTEFullMergedMotionUnitTests();
        if(scrNTTEFullSmokeCase("MergedEnergyUnitTests")) scrNTTEFullMergedEnergyUnitTests();
        if(scrNTTEFullSmokeCase("MergedHyperUnitTests")) scrNTTEFullMergedHyperUnitTests();
        if(scrNTTEFullSmokeCase("MergedLightningUnitTests")) scrNTTEFullMergedLightningUnitTests();
        if(scrNTTEFullSmokeCase("MergedRuntimeMountTests")) scrNTTEFullMergedRuntimeMountTests();
        if(scrNTTEFullSmokeCase("MergedRuntimeDispatchTests")) scrNTTEFullMergedRuntimeDispatchTests();
        if(scrNTTEFullSmokeCase("MergedRuntimeStateTests")) scrNTTEFullMergedRuntimeStateTests();
        if(scrNTTEFullSmokeCase("ChargeInputNativeTests")) scrNTTEFullChargeInputNativeTests();
        if(scrNTTEFullSmokeCase("ChargeInputPlayerStepNativeTests")) scrNTTEFullChargeInputPlayerStepNativeTests();
        if(scrNTTEFullSmokeCase("MergedRuntimeActorTests")) scrNTTEFullMergedRuntimeActorTests();
        if(scrNTTEFullSmokeCase("RedWeaponNativeTests")) scrNTTEFullRedWeaponNativeTests();
        if(scrNTTEFullSmokeCase("RedFireChargeTests")) scrNTTEFullRedFireChargeTests();
        if(scrNTTEFullSmokeCase("NativeProjectileHitTests")) scrNTTEFullNativeProjectileHitTests();
        if(scrNTTEFullSmokeCase("BatDiscTests")) scrNTTEFullBatDiscTests()
        if(scrNTTEFullSmokeCase("EnergyBatTests")) scrNTTEFullEnergyBatTests()
        if(scrNTTEFullSmokeCase("DiscWeaponFireTests")) scrNTTEFullDiscWeaponFireTests()
        if(scrNTTEFullSmokeCase("BubbleSlashTests")) scrNTTEFullBubbleSlashTests()
        if(scrNTTEFullSmokeCase("BubbleWeaponTests")) scrNTTEFullBubbleWeaponTests();
        if(scrNTTEFullSmokeCase("BubbleBombTests")) scrNTTEFullBubbleBombTests();
        if(scrNTTEFullSmokeCase("WorldExplosionTests")) scrNTTEFullWorldExplosionTests();
        if(scrNTTEFullSmokeCase("EntanglerNativeTests")) scrNTTEFullEntanglerNativeTests();
        if(scrNTTEFullSmokeCase("EntanglerFriendlyEmissionNativeTests")) scrNTTEFullEntanglerFriendlyEmissionNativeTests();
        if(scrNTTEFullSmokeCase("CrystalCloneNativeTests")) scrNTTEFullCrystalCloneNativeTests();
        if(scrNTTEFullSmokeCase("CrystalCloneOptionalStateNativeTests")) scrNTTEFullCrystalCloneOptionalStateNativeTests();
        if(scrNTTEFullSmokeCase("CrystalCloneDrawTests")) scrNTTEFullCrystalCloneDrawTests();
        if(scrNTTEFullSmokeCase("TunnellerNativeTests")) scrNTTEFullTunnellerNativeTests();
        if(scrNTTEFullSmokeCase("CrystalHeartNativeHitTests")) scrNTTEFullCrystalHeartNativeHitTests();
        if(scrNTTEFullSmokeCase("PizzaWeaponNativeTests")) scrNTTEFullPizzaWeaponNativeTests();
        if(scrNTTEFullSmokeCase("PizzaWeaponMergedTests")) scrNTTEFullPizzaWeaponMergedTests();
        if(scrNTTEFullSmokeCase("DynamicWeaponAutoTests")) scrNTTEFullDynamicWeaponAutoTests();
        if(scrNTTEFullSmokeCase("RedRewardNativeTests")) scrNTTEFullRedRewardNativeTests();
        if(scrNTTEFullSmokeCase("TridentNativeTests")) scrNTTEFullTridentNativeTests();
        if(scrNTTEFullSmokeCase("MusicBossRoutingTests")) scrNTTEFullMusicBossRoutingTests();
        if(scrNTTEFullSmokeCase("TridentMergedStateTests")) scrNTTEFullTridentMergedStateTests();
        if(scrNTTEFullSmokeCase("MergedStockSpriteNativeTests")) scrNTTEFullMergedStockSpriteNativeTests();
        if(scrNTTEFullSmokeCase("BackpackNativeTests")) scrNTTEFullBackpackNativeTests();
        if(scrNTTEFullSmokeCase("ElectroWeaponTests")) scrNTTEFullElectroWeaponTests();
        if(scrNTTEFullSmokeCase("QuasarWeaponTests")) scrNTTEFullQuasarWeaponTests();
        if(scrNTTEFullSmokeCase("QuasarTests")) scrNTTEFullQuasarTests();
        if(scrNTTEFullSmokeCase("QuasarDynamicSeamNativeTests")) scrNTTEFullQuasarDynamicSeamNativeTests();
        if(scrNTTEFullSmokeCase("QuasarSwapIconNativeTests")) scrNTTEFullQuasarSwapIconNativeTests();
        if(scrNTTEFullSmokeAsyncCase("QuasarAudioPressureTests")) scrNTTEFullQuasarAudioPressureTests();
        if(scrNTTEFullSmokeCase("ElectroPlasmaTests")) scrNTTEFullElectroPlasmaTests();
        if(scrNTTEFullSmokeCase("TeslaTests")) scrNTTEFullTeslaTests();
        if(scrNTTEFullSmokeCase("DematerializerTests")) scrNTTEFullDematerializerTests();
        if(scrNTTEFullSmokeCase("VampireTests")) scrNTTEFullVampireTests();
        if(scrNTTEFullSmokeCase("VaultLootNativeTests")) scrNTTEFullVaultLootNativeTests();
        if(scrNTTEFullSmokeCase("CrabboneStackNativeTests")) scrNTTEFullCrabboneStackNativeTests();
        if(scrNTTEFullSmokeCase("LightringWeaponTests")) scrNTTEFullLightringWeaponTests();
        if(scrNTTEFullSmokeCase("LightringLifecycleTests")) scrNTTEFullLightringLifecycleTests();
        if(scrNTTEFullSmokeCase("CustomProjectileGateTests")) scrNTTEFullCustomProjectileGateTests();
        if(scrNTTEFullSmokeCase("RogueCarbineTests")) scrNTTEFullRogueCarbineTests();
        if(scrNTTEFullSmokeCase("VenomTests")) scrNTTEFullVenomTests();
        if(scrNTTEFullSmokeCase("BuriedVaultNativeTests")) scrNTTEFullBuriedVaultNativeTests();
        if(scrNTTEFullSmokeCase("QuestFloorNativeTests")) scrNTTEFullQuestFloorNativeTests();
        if(scrNTTEFullSmokeCase("QuestTeleporterNativeTests")) scrNTTEFullQuestTeleporterNativeTests();
        if(scrNTTEFullSmokeCase("QuestRewardNativeTests")) scrNTTEFullQuestRewardNativeTests();
        if(scrNTTEFullSmokeCase("QuestLockedNativeTests")) scrNTTEFullQuestLockedNativeTests();
        if(scrNTTEFullSmokeCase("ParrotPauseLifecycleTests")) scrNTTEFullParrotPauseLifecycleTests();
        if(scrNTTEFullSmokeCase("ParrotCopyLifecycleTests")) scrNTTEFullParrotCopyLifecycleTests();
        if(scrNTTEFullSmokeCase("QuestHubNativeTests")) scrNTTEFullQuestHubNativeTests();
        if(scrNTTEFullSmokeCase("QuestPalaceNativeTests")) scrNTTEFullQuestPalaceNativeTests();
        if(scrNTTEFullSmokeCase("FreakChamberNativeTests")) scrNTTEFullFreakChamberNativeTests();
        if(scrNTTEFullSmokeCase("RedSpiderNativeTests")) scrNTTEFullRedSpiderNativeTests();
        if(scrNTTEFullSmokeCase("WallFakeNativeTests")) scrNTTEFullWallFakeNativeTests();
        if(scrNTTEFullSmokeCase("WarpDestinationNativeTests")) scrNTTEFullWarpDestinationNativeTests();
        if(scrNTTEFullSmokeCase("CrownLoadoutNativeTests")) scrNTTEFullCrownLoadoutNativeTests();
        if(scrNTTEFullSmokeCase("SourceSeedNativeTests")) scrNTTEFullSourceSeedNativeTests();
        if(scrNTTEFullSmokeCase("RaceProgressionNativeTests")) scrNTTEFullRaceProgressionNativeTests();
        if(scrNTTEFullSmokeCase("WarpNativeTests")) scrNTTEFullWarpNativeTests();
        if(scrNTTEFullSmokeCase("CrystalHeartLevelNativeTests")) scrNTTEFullCrystalHeartLevelNativeTests();
        if(scrNTTEFullSmokeCase("WeaponLoadoutNativeTests")) scrNTTEFullWeaponLoadoutNativeTests();
        if(scrNTTEFullSmokeCase("CrystalBrainNativeTests")) scrNTTEFullCrystalBrainNativeTests();
        if(scrNTTEFullSmokeCase("SourceRuntimeNativeTests")) scrNTTEFullSourceRuntimeNativeTests();
        if(scrNTTEFullSmokeCase("TesseractStrikeNativeTests")) scrNTTEFullTesseractStrikeNativeTests();
        if(scrNTTEFullSmokeCase("GatorStatueNativeTests")) scrNTTEFullGatorStatueNativeTests();
        if(scrNTTEFullSmokeCase("TesseractArmNativeTests")) scrNTTEFullTesseractArmNativeTests();
        if(scrNTTEFullSmokeCase("CoastHitNormalizationTests")) scrNTTEFullCoastHitNormalizationTests();
        if(scrNTTEFullSmokeCase("PetPlayerNativeTests")) scrNTTEFullPetPlayerNativeTests();
        if(scrNTTEFullSmokeCase("PetNativeEntryTests")) scrNTTEFullPetNativeEntryTests();
        if(scrNTTEFullSmokeCase("PetMetadataNativeTests")) scrNTTEFullPetMetadataNativeTests();
        if(scrNTTEFullSmokeCase("TesseractNativeTests")) scrNTTEFullTesseractNativeTests();
        if(scrNTTEFullSmokeCase("CampfireWorldNativeTests")) scrNTTEFullCampfireWorldNativeTests();
        if(scrNTTEFullSmokeCase("WeaponMimicBossNativeTests")) scrNTTEFullWeaponMimicBossNativeTests();
        if(scrNTTEFullSmokeCase("WeaponMimicArenaNativeTests")) scrNTTEFullWeaponMimicArenaNativeTests();
        if(scrNTTEFullSmokeCase("RaceMenuDecorationNativeTests")) scrNTTEFullRaceMenuDecorationNativeTests();
        if(scrNTTEFullSmokeCase("RedSpiralNativeTests")) scrNTTEFullRedSpiralNativeTests();
        if(scrNTTEFullSmokeCase("PetWorldLevelNativeTests")) scrNTTEFullPetWorldLevelNativeTests();
        if(scrNTTEFullSmokeCase("LoadingTipsNativeTests")) scrNTTEFullLoadingTipsNativeTests();
        if(scrNTTEFullSmokeCase("LastWishNativeTests")) scrNTTEFullLastWishNativeTests();
        if(scrNTTEFullSmokeCase("RoadmapNativeTests")) scrNTTEFullRoadmapNativeTests();
        if(scrNTTEFullSmokeCase("SpiralMeshNativeTests")) scrNTTEFullSpiralMeshNativeTests();
        if(scrNTTEFullSmokeCase("RedAreaNativeTests")) scrNTTEFullRedAreaNativeTests();
        if(scrNTTEFullSmokeCase("CavesLevelNativeTests")) scrNTTEFullCavesLevelNativeTests();
        if(scrNTTEFullSmokeCase("CavesHyperPitNativeTests")) scrNTTEFullCavesHyperPitNativeTests();
        if(scrNTTEFullSmokeCase("RedWorldRenderNativeTests")) scrNTTEFullRedWorldRenderNativeTests();
        if(scrNTTEFullSmokeCase("CityLevelNativeTests")) scrNTTEFullCityLevelNativeTests();
        if(scrNTTEFullSmokeCase("SawTrapNativeTests")) scrNTTEFullSawTrapNativeTests();
        if(scrNTTEFullSmokeCase("RunStatsTotalDrawNativeTests")) scrNTTEFullRunStatsTotalDrawNativeTests();
        if(scrNTTEFullSmokeCase("PlayerRunStatsNativeTests")) scrNTTEFullPlayerRunStatsNativeTests();
        if(scrNTTEFullSmokeCase("MenuReminderPersistenceNativeTests")) scrNTTEFullMenuReminderPersistenceNativeTests();
        if(scrNTTEFullSmokeCase("ChargeLegacyReleaseNativeTests")) scrNTTEFullChargeLegacyReleaseNativeTests();
        if(scrNTTEFullSmokeCase("BoneArtifactExplosionNativeTests")) scrNTTEFullBoneArtifactExplosionNativeTests();
        if(scrNTTEFullSmokeCase("PlayerPracticeOptionNativeTests")) scrNTTEFullPlayerPracticeOptionNativeTests();
        if(scrNTTEFullSmokeCase("PlayerPracticeFaintNativeTests")) scrNTTEFullPlayerPracticeFaintNativeTests();
        if(scrNTTEFullSmokeCase("PlayerDeathGraceNativeTests")) scrNTTEFullPlayerDeathGraceNativeTests();
        if(scrNTTEFullSmokeCase("ChestHatredCauseNativeTests")) scrNTTEFullChestHatredCauseNativeTests();
        if(scrNTTEFullSmokeCase("SawTrapAttachmentNativeTests")) scrNTTEFullSawTrapAttachmentNativeTests();
        if(scrNTTEFullSmokeCase("TrenchChunkDestroyNativeTests")) scrNTTEFullTrenchChunkDestroyNativeTests();
        if(scrNTTEFullSmokeCase("RedWallShineNativeTests")) scrNTTEFullRedWallShineNativeTests();
        if(scrNTTEFullSmokeCase("WorldHurtDrawNativeTests")) scrNTTEFullWorldHurtDrawNativeTests();
        if(scrNTTEFullSmokeCase("SealPowderNativeTests")) scrNTTEFullSealPowderNativeTests();
        if(scrNTTEFullSmokeCase("RobotEatNativeTests")) scrNTTEFullRobotEatNativeTests();
        if(scrNTTEFullSmokeCase("RedGeneratorNativeTests")) scrNTTEFullRedGeneratorNativeTests();
        if(scrNTTEFullSmokeCase("SewersLevelNativeTests")) scrNTTEFullSewersLevelNativeTests();
        if(scrNTTEFullSmokeCase("SewerDrainLifetimeTests")) scrNTTEFullSewerDrainLifetimeTests();
        if(scrNTTEFullSmokeCase("DesertLevelNativeTests")) scrNTTEFullDesertLevelNativeTests();
        if(scrNTTEFullSmokeCase("ScrapyardLevelNativeTests")) scrNTTEFullScrapyardLevelNativeTests();
        if(scrNTTEFullSmokeCase("LabsLevelNativeTests")) scrNTTEFullLabsLevelNativeTests();
        if(scrNTTEFullSmokeCase("ThroneIntroNativeTests")) scrNTTEFullThroneIntroNativeTests();
        if(scrNTTEFullSmokeCase("PalaceLevelNativeTests")) scrNTTEFullPalaceLevelNativeTests();
        if(scrNTTEFullSmokeCase("JungleLevelNativeTests")) scrNTTEFullJungleLevelNativeTests();
        if(scrNTTEFullSmokeCase("BaseFrameNativeTests")) scrNTTEFullBaseFrameNativeTests();
        if(scrNTTEFullSmokeCase("InstanceEnumerationNativeTests")) scrNTTEFullInstanceEnumerationNativeTests();
        if(scrNTTEFullSmokeCase("RectInstancesNativeTests")) scrNTTEFullRectInstancesNativeTests();
        if(scrNTTEFullSmokeCase("WallDeleteOrderNativeTests")) scrNTTEFullWallDeleteOrderNativeTests();
        if(scrNTTEFullSmokeCase("FloorRoomCacheNativeTests")) scrNTTEFullFloorRoomCacheNativeTests();
        if(scrNTTEFullSmokeCase("BackpackerEffectLifetimeTests")) scrNTTEFullBackpackerEffectLifetimeTests();
        if(scrNTTEFullSmokeCase("DustEffectLifetimeTests")) scrNTTEFullDustEffectLifetimeTests();
        if(scrNTTEFullSmokeCase("BoltStickSpriteNativeTests")) scrNTTEFullBoltStickSpriteNativeTests();
        if(scrNTTEFullSmokeCase("NativeEffectLifetimeTests")) scrNTTEFullNativeEffectLifetimeTests();
        if(scrNTTEFullSmokeCase("LairEffectLifetimeTests")) scrNTTEFullLairEffectLifetimeTests();
        if(scrNTTEFullSmokeCase("SkeletonBoneDropNativeTests")) scrNTTEFullSkeletonBoneDropNativeTests();
        if(scrNTTEFullSmokeCase("SpawnVehicleSafetyTests")) scrNTTEFullSpawnVehicleSafetyTests();
        if(scrNTTEFullSmokeCase("WantEelFirstMatchNativeTests")) scrNTTEFullWantEelFirstMatchNativeTests();
        if(scrNTTEFullSmokeCase("BackpackProviderCountTests")) scrNTTEFullBackpackProviderCountTests();
        if(scrNTTEFullSmokeCase("CrystalHeartCrownGuardianTests")) scrNTTEFullCrystalHeartCrownGuardianTests();
        if(scrNTTEFullSmokeCase("CrystalHeartChestOrderTests")) scrNTTEFullCrystalHeartChestOrderTests();
        if(scrNTTEFullSmokeCase("BossClassificationNativeTests")) scrNTTEFullBossClassificationNativeTests();
        if(scrNTTEFullSmokeCase("PetCallbackLifetimeTests")) scrNTTEFullPetCallbackLifetimeTests();
        if(scrNTTEFullSmokeCase("CuzTakeoverParityTests")) scrNTTEFullCuzTakeoverParityTests();
        if(scrNTTEFullSmokeCase("WorldEventsNativeTests")) scrNTTEFullWorldEventsNativeTests();
        if(scrNTTEFullSmokeCase("WorldEventsNaturalSelectionNativeTests")) scrNTTEFullWorldEventsNaturalSelectionNativeTests();
        if(scrNTTEFullSmokeCase("WorldEventsGenerationOrderNativeTests")) scrNTTEFullWorldEventsGenerationOrderNativeTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsNaturalWorldTests")) scrNTTEFullWorldEventsNaturalWorldTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsCombinedWorldTests")) scrNTTEFullWorldEventsCombinedWorldTests();
        if(scrNTTEFullSmokeCase("WorldEventsNaturalNegativeTests")) scrNTTEFullWorldEventsNaturalNegativeTests();
        if(scrNTTEFullSmokeCase("WeaponGoldFieldsNativeTests")) scrNTTEFullWeaponGoldFieldsNativeTests();
        if(scrNTTEFullSmokeCase("BonusRobotNaturalTests")) scrNTTEFullBonusRobotNaturalTests();
        if(scrNTTEFullSmokeCase("CompassionNaturalTests")) scrNTTEFullCompassionNaturalTests();
        if(scrNTTEFullSmokeCase("RatRewardNaturalTests")) scrNTTEFullRatRewardNaturalTests();
        if(scrNTTEFullSmokeCase("FlowerRewardNaturalTests")) scrNTTEFullFlowerRewardNaturalTests();
        if(scrNTTEFullSmokeCase("WeaponSourcePresentationNativeTests")) scrNTTEFullWeaponSourcePresentationNativeTests();
        if(scrNTTEFullSmokeCase("BoneWeaponMetadataNativeTests")) scrNTTEFullBoneWeaponMetadataNativeTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsScheduledWorldTests")) scrNTTEFullWorldEventsScheduledWorldTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsDummyWorldTests")) scrNTTEFullWorldEventsDummyWorldTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsNextRoomTests")) scrNTTEFullWorldEventsNextRoomTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsRewardWorldTests")) scrNTTEFullWorldEventsRewardWorldTests();
        if(scrNTTEFullSmokeAsyncCase("ParrotNaturalMenuTests")) scrNTTEFullParrotNaturalMenuTests();
        if(scrNTTEFullSmokeAsyncCase("BeetleRewardNaturalMenuTests")) scrNTTEFullBeetleRewardNaturalMenuTests();
        if(scrNTTEFullSmokeAsyncCase("QuestHubNaturalTests")) scrNTTEFullQuestHubNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("RedKillSourceNaturalTests")) scrNTTEFullRedKillSourceNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("QuestAreaPopulationNaturalTests")) scrNTTEFullQuestAreaPopulationNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("QuestStoredHubNaturalTests")) scrNTTEFullQuestStoredHubNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("QuestStoredHubAltSeedNaturalTests")) scrNTTEFullQuestStoredHubNaturalTests(702643);
        if(scrNTTEFullSmokeAsyncCase("RedSkinNaturalMenuTests")) scrNTTEFullRedSkinNaturalMenuTests();
        if(scrNTTEFullSmokeAsyncCase("SkinNativeMenuTests")) scrNTTEFullSkinNativeMenuTests();
        if(scrNTTEFullSmokeAsyncCase("CrownNaturalMenuTests")) scrNTTEFullCrownNaturalMenuTests();
        if(scrNTTEFullSmokeCase("AnglerSkinNaturalTests")) scrNTTEFullAnglerSkinNaturalTests();
        if(scrNTTEFullSmokeCase("BatSkinNaturalTests")) scrNTTEFullBatSkinNaturalTests();
        if(scrNTTEFullSmokeCase("CoolFrogSkinNaturalTests")) scrNTTEFullCoolFrogSkinNaturalTests();
        if(scrNTTEFullSmokeCase("EnemyContactDefaultsNativeTests")) scrNTTEFullEnemyContactDefaultsNativeTests();
        if(scrNTTEFullSmokeAsyncCase("FeatureReadinessProductionTests")) scrNTTEFullFeatureReadinessProductionTests();
        if(scrNTTEFullSmokeAsyncCase("BonusScheduledColdTests")) scrNTTEFullBonusScheduledColdTests();
        if(scrNTTEFullSmokeAsyncCase("LairNaturalWorldTests")) scrNTTEFullLairNaturalWorldTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsRoomRestartTests")) scrNTTEFullWorldEventsRoomRestartTests();
        if(scrNTTEFullSmokeAsyncCase("WorldEventsColdProductionTests")) scrNTTEFullWorldEventsColdProductionTests();
        // BEGIN NTTE OWNED WORLD EVENTS RELEASE TEST
        if(scrNTTEFullSmokeAsyncCase("WorldEventsReleaseTests")) scrNTTEFullWorldEventsReleaseTests();
        // END NTTE OWNED WORLD EVENTS RELEASE TEST
        if(scrNTTEFullSmokeAsyncCase("PetTransientLifecycleTests")) scrNTTEFullPetTransientLifecycleTests();
        if(scrNTTEFullSmokeAsyncCase("PetSpiderRoomRestartTests")) scrNTTEFullPetSpiderRoomRestartTests();
        // NTTE SPIDER HIDDEN PORTAL TEST REGISTRATION
        if(scrNTTEFullSmokeAsyncCase("PetSpiderPortalHiddenTests")) scrNTTEFullPetSpiderPortalHiddenTests();
        if(scrNTTEFullSmokeAsyncCase("SlaughterFetchNaturalTests")) scrNTTEFullSlaughterFetchNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("SewerPizzaNaturalEntryTests")) scrNTTEFullSewerPizzaNaturalEntryTests();
        if(scrNTTEFullSmokeAsyncCase("ParrotBConnectedTests")) scrNTTEFullParrotBConnectedTests();
        if(scrNTTEFullSmokeAsyncCase("ProtoStatueNaturalEntryTests")) scrNTTEFullProtoStatueNaturalEntryTests();
        if(scrNTTEFullSmokeAsyncCase("OasisTrenchNaturalEntryTests")) scrNTTEFullOasisTrenchNaturalEntryTests();
        if(scrNTTEFullSmokeAsyncCase("PalaceArtifactContinueTests")) scrNTTEFullPalaceArtifactContinueTests();
        if(scrNTTEFullSmokeAsyncCase("QuestArtifactCarryLifecycleTests")) scrNTTEFullQuestCarryTests();
        if(scrNTTEFullSmokeAsyncCase("HQStolenContinueTests")) scrNTTEFullHQStolenContinueTests();
        if(scrNTTEFullSmokeAsyncCase("PalaceArtifactPortalCarryTests")) scrNTTEFullPalaceArtifactPortalCarryTests();
        if(scrNTTEFullSmokeAsyncCase("CuzConnectedTests")) scrNTTEFullCuzConnectedTests();
        if(scrNTTEFullSmokeAsyncCase("CuzMusicConnectedTests")) scrNTTEFullCuzMusicConnectedTests();
        if(scrNTTEFullSmokeAsyncCase("PizzaLairDrainNaturalTests")) scrNTTEFullPizzaLairDrainNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("LairBattleExitNaturalTests")) scrNTTEFullLairBattleExitNaturalTests();
        if(scrNTTEFullSmokeAsyncCase("TrenchConnectedCampaignTests")) scrNTTEFullTrenchConnectedCampaignTests();
        if(scrNTTEFullSmokeAsyncCase("TrenchSecondHopConnectedTests")) scrNTTEFullTrenchSecondHopConnectedTests();
        if(scrNTTEFullSmokeCase("WallPropsLevelNativeTests")) scrNTTEFullWallPropsLevelNativeTests();
        if(scrNTTEFullSmokeCase("WorldLateLevelNativeTests")) scrNTTEFullWorldLateLevelNativeTests();
        if(scrNTTEFullSmokeCase("WorldFinalizeNativeTests")) scrNTTEFullWorldFinalizeNativeTests();
        if(scrNTTEFullSmokeCase("WeaponDiscoveryNativeTests")) scrNTTEFullWeaponDiscoveryNativeTests();
        if(scrNTTEFullSmokeCase("InitialChestsNativeTests")) scrNTTEFullInitialChestsNativeTests();
        if(scrNTTEFullSmokeCase("SilverCratesNativeTests")) scrNTTEFullSilverCratesNativeTests();
        if(scrNTTEFullSmokeCase("TopEcologyNativeTests")) scrNTTEFullTopEcologyNativeTests();
        if(scrNTTEFullSmokeCase("BigDecalNativeTests")) scrNTTEFullBigDecalNativeTests();
        if(scrNTTEFullSmokeCase("ChestDropNativeTests")) scrNTTEFullChestDropNativeTests();
        if(scrNTTEFullSmokeCase("VaultHQLevelNativeTests")) scrNTTEFullVaultHQLevelNativeTests();
        if(scrNTTEFullSmokeCase("RerollNativeTests")) scrNTTEFullRerollNativeTests();
        if(scrNTTEFullSmokeCase("MenuNativeTests")) scrNTTEFullMenuNativeTests();
        if(scrNTTEFullSmokeCase("MergedTerminalSoundNativeTests")) scrNTTEFullMergedTerminalSoundNativeTests();
        if(scrNTTEFullSmokeCase("ActorBirthCaptureNativeTests")) scrNTTEFullActorBirthCaptureNativeTests();
        if(scrNTTEFullSmokeCase("MergedSetupSpikeTests")) scrNTTEFullMergedSetupSpikeTests();
        if(scrNTTEFullSmokeCase("MergedCopyIndexNativeTests")) scrNTTEFullMergedCopyIndexNativeTests();
        if(scrNTTEFullSmokeCase("MergedQuasarCaptureNativeTests")) scrNTTEFullMergedQuasarCaptureNativeTests();
        if(scrNTTEFullSmokeCase("MergedPrismCopyIndexNativeTests")) scrNTTEFullMergedPrismCopyIndexNativeTests();
        if(scrNTTEFullSmokeCase("TrenchBubblePerformanceTests")) scrNTTEFullTrenchBubblePerformanceTests();
        if(scrNTTEFullSmokeCase("AchievementRepeatNativeTests")) scrNTTEFullAchievementRepeatNativeTests();
        if(scrNTTEFullSmokeCase("AchievementOwnershipNativeTests")) scrNTTEFullAchievementOwnershipNativeTests();
        if(scrNTTEFullSmokeCase("ProjectileContractTests")) scrNTTEFullProjectileContractTests();
        if(scrNTTEFullSmokeCase("BranchAreaLabelTests")) scrNTTEFullBranchAreaLabelTests();
        if(scrNTTEFullSmokeCase("TextWrapNativeTests")) scrNTTEFullTextWrapNativeTests();
        if(scrNTTEFullSmokeCase("SingleplayerUIEntryTests")) scrNTTEFullSingleplayerUIEntryTests();
        if(scrNTTEFullSmokeCase("WorldEarlyLevelNativeTests")) scrNTTEFullWorldEarlyLevelNativeTests();
        if(scrNTTEFullSmokeCase("LairTransitNativeTests")) scrNTTEFullLairTransitNativeTests();
        if(scrNTTEFullSmokeCase("EarlySystemsLevelNativeTests")) scrNTTEFullEarlySystemsLevelNativeTests();
        if(scrNTTEFullSmokeCase("TrenchTransitNativeTests")) scrNTTEFullTrenchTransitNativeTests();
        if(scrNTTEFullSmokeCase("WorldCompletionNativeTests")) scrNTTEFullWorldCompletionNativeTests();
        if(scrNTTEFullSmokeCase("TrenchCompletionPreventNativeTests")) scrNTTEFullTrenchCompletionPreventNativeTests();
        if(scrNTTEFullSmokeCase("IOSRenderSurfaceTests")) scrNTTEFullIOSRenderSurfaceTests();
        if(scrNTTEFullSmokeCase("TrenchIOSTargetSafetyTests")) scrNTTEFullTrenchIOSTargetSafetyTests();
        if(scrNTTEFullSmokeCase("VisualOptionsDrawTests")) scrNTTEFullVisualOptionsDrawTests();
        if(scrNTTEFullSmokeCase("OutlineOptionsNativeTests")) scrNTTEFullOutlineOptionsNativeTests();
        if(scrNTTEFullSmokeCase("LevelPipelineNativeTests")) scrNTTEFullLevelPipelineNativeTests();
        if(scrNTTEFullSmokeCase("QualityConsumersNativeDrawTests")) scrNTTEFullQualityConsumersNativeDrawTests();
        if(scrNTTEFullSmokeCase("TopShadowNativeDrawTests")) scrNTTEFullTopShadowNativeDrawTests();
        if(scrNTTEFullSmokeCase("MenuStatsPresentationNativeTests")) scrNTTEFullMenuStatsPresentationNativeTests();
        if(scrNTTEFullSmokeCase("ManholeDestinationNativeTests")) scrNTTEFullManholeDestinationNativeTests();
        if(scrNTTEFullSmokeCase("GuardianEscapeDestinationNativeTests")) scrNTTEFullGuardianEscapeDestinationNativeTests();
        if(scrNTTEFullSmokeCase("OptionalShadowNativeTests")) scrNTTEFullOptionalShadowNativeTests();
        if(scrNTTEFullSmokeCase("WeaponSkinNativeTests")) scrNTTEFullWeaponSkinNativeTests();
        if(scrNTTEFullSmokeCase("TunnellerGoldMetadataNativeTests")) scrNTTEFullTunnellerGoldMetadataNativeTests();
        if(scrNTTEFullSmokeCase("SystemProductionHooksTests")) scrNTTEFullSystemProductionHooksTests();
        if(scrNTTEFullSmokeCase("CrabboneProjectileNativeTests")) scrNTTEFullCrabboneProjectileNativeTests();
        if(scrNTTEFullSmokeCase("CrabbonePhysicalNativeTests")) scrNTTEFullCrabbonePhysicalNativeTests();
        if(scrNTTEFullSmokeCase("CrabboneSupportNativeTests")) scrNTTEFullCrabboneSupportNativeTests();
        if(scrNTTEFullSmokeCase("PopoSecurityNativeTests")) scrNTTEFullPopoSecurityNativeTests();
        if(scrNTTEFullSmokeCase("RedSlashEligibilityTests")) scrNTTEFullRedSlashEligibilityTests();
        if(scrNTTEFullSmokeCase("ParrotFeatherTests")) scrNTTEFullParrotFeatherTests();
        if(scrNTTEFullSmokeCase("ParrotCharmAITests")) scrNTTEFullParrotCharmAITests();
        if(scrNTTEFullSmokeCase("ParrotChestTests")) scrNTTEFullParrotChestTests();
        if(scrNTTEFullSmokeCase("RawHitTests")) scrNTTEFullRawHitTests();
        if(scrNTTEFullSmokeCase("Followup69PresentationNativeTests")) scrNTTEFullFollowup69PresentationNativeTests();
        if(scrNTTEFullSmokeCase("HurtParityUnitTests")) scrNTTEFullHurtParityUnitTests()
        if(scrNTTEFullSmokeCase("ParrotFlockTests")) scrNTTEFullParrotFlockTests();
        if(scrNTTEFullSmokeCase("SystemsNativeStackTests")) scrNTTEFullSystemsNativeStackTests();
        if(scrNTTEFullSmokeCase("SystemsEffectTests")) scrNTTEFullSystemsEffectTests();
        if(scrNTTEFullSmokeCase("SystemsOrchidTests")) scrNTTEFullSystemsOrchidTests();
        if(scrNTTEFullSmokeCase("SkinSpriteCacheTests")) scrNTTEFullSkinSpriteCacheTests();
        if(scrNTTEFullSmokeCase("SkinShotBirthCaptureNativeTests")) scrNTTEFullSkinShotBirthCaptureNativeTests();
        if(scrNTTEFullSmokeCase("GamepadDeviceTests")) scrNTTEGamepadDeviceTests();
        if(scrNTTEFullSmokeCase("GroundEnemyNoKillNativeTests")) scrNTTEFullGroundEnemyNoKillNativeTests();
        if(scrNTTEFullSmokeCase("FireBurstBirthCaptureNativeTests")) scrNTTEFullFireBurstBirthCaptureNativeTests();
        if(scrNTTEFullSmokeCase("MergedSpriteHistoryIndexNativeTests")) scrNTTEFullMergedSpriteHistoryIndexNativeTests();
        if(scrNTTEFullSmokeCase("ConsoleOptionNativeTests")) scrNTTEFullConsoleOptionNativeTests();
        if(scrNTTEFullSmokeCase("MountedAbilityInputNativeTests")) scrNTTEFullMountedAbilityInputNativeTests();
        if(scrNTTEFullSmokeCase("GamepadAutoAimNativeTests")) scrNTTEFullGamepadAutoAimNativeTests();
        if(scrNTTEFullSmokeCase("CharmAlarmBirthCaptureNativeTests")) scrNTTEFullCharmAlarmBirthCaptureNativeTests();
        if(scrNTTEFullSmokeCase("FriendlyMonsterShotTests")) scrNTTEFullFriendlyMonsterShotTests();
        if(scrNTTEFullSmokeCase("WeaponSoundNativeTests")) scrNTTEFullWeaponSoundNativeTests();
        if(scrNTTEFullSmokeCase("ReferenceSpriteCacheTests")) scrNTTERefSpriteCacheTests();
        if(scrNTTEFullSmokeCase("MergedRuntimeDifferenceTests")) scrNTTEFullMergedRuntimeDifferenceTests();
        if(scrNTTEFullSmokeCase("SystemsSkinTests")) scrNTTEFullSystemsSkinTests();
        if(scrNTTEFullSmokeCase("SystemsCrimeTests")) scrNTTEFullSystemsCrimeTests();
        if(scrNTTEFullSmokeCase("CrimeCrownTransitionTests")) scrNTTEFullCrimeCrownTransitionTests();
        if(scrNTTEFullSmokeCase("CrimeEffectLifetimeTests")) scrNTTEFullCrimeEffectLifetimeTests();
        if(scrNTTEFullSmokeCase("CrimeCoastLifetimeTests")) scrNTTEFullCrimeEffectLifetimeTests("coast");
        if(scrNTTEFullSmokeCase("CrimeParticleOffLifetimeTests")) scrNTTEFullCrimeEffectLifetimeTests("particles_off");
        if(scrNTTEFullSmokeCase("SystemsProgressTests")) scrNTTEFullSystemsProgressTests();
        if(scrNTTEFullSmokeCase("PromptTests")) scrNTTEFullPromptTests();
        if(scrNTTEFullSmokeCase("PetFrameworkTests")) scrNTTEFullPetFrameworkTests();
        if(scrNTTEFullSmokeCase("PetScorpionTests")) scrNTTEFullPetScorpionTests();
        if(scrNTTEFullSmokeCase("PetParrotTests")) scrNTTEFullPetParrotTests();
        if(scrNTTEFullSmokeCase("PetCoolGuyTests")) scrNTTEFullPetCoolGuyTests();
        if(scrNTTEFullSmokeCase("PetOrchidTests")) scrNTTEFullPetOrchidTests();
        if(scrNTTEFullSmokeCase("PetOctoTests")) scrNTTEFullPetOctoTests();
        if(scrNTTEFullSmokeCase("PetMimicTests")) scrNTTEFullPetMimicTests();
        if(scrNTTEFullSmokeCase("PetSalamanderTests")) scrNTTEFullPetSalamanderTests();
        if(scrNTTEFullSmokeCase("PetSlaughterTests")) scrNTTEFullPetSlaughterTests();
        if(scrNTTEFullSmokeCase("PetSpiderTests")) scrNTTEFullPetSpiderTests();
        if(scrNTTEFullSmokeCase("PetPrismTests")) scrNTTEFullPetPrismTests();
        if(scrNTTEFullSmokeCase("PetTwinsTests")) scrNTTEFullPetTwinsTests();
        if(scrNTTEFullSmokeCase("PetTwinsHistoryBaselineTests")) scrNTTEFullPetTwinsHistoryBaselineTests();
        if(scrNTTEFullSmokeCase("PetTwinsHistoryNativeTests")) scrNTTEFullPetTwinsHistoryNativeTests();
        if(scrNTTEFullSmokeCase("PetCuzTests")) scrNTTEFullPetCuzTests();
        if(scrNTTEFullSmokeCase("GuardianMiddleNativeTests")) scrNTTEFullGuardianMiddleNativeTests();
        if(scrNTTEFullSmokeCase("PetGuardianCoreTests")) scrNTTEFullPetGuardianCoreTests();
        if(scrNTTEFullSmokeCase("PetGuardianActiveTests")) scrNTTEFullPetGuardianActiveTests();
        if(scrNTTEFullSmokeCase("PetGuardianOtherActiveTests")) scrNTTEFullPetGuardianOtherActiveTests();
        if(scrNTTEFullSmokeCase("PetGuardianSpecificTests")) scrNTTEFullPetGuardianSpecificTests();
        if(scrNTTEFullSmokeCase("UpdateCheckTests")) scrNTTEUpdateTests();
        if(scrNTTEFullSmokeCase("PizzaPropHurt78Tests")) scrNTTEFullPizzaPropHurt78Tests();
        if(scrNTTEFullSmokeCase("QuestDrop78Tests")) scrNTTEFullQuestDrop78Tests();
        if(scrNTTEFullSmokeCase("RoadmapLoop78Tests")) scrNTTEFullRoadmapLoop78Tests();
        if(scrNTTEFullSmokeCase("MergedChinese78Tests")) scrNTTEFullMergedChinese78Tests();
        if(scrNTTEFullSmokeCase("SecretWeapon78Tests")) scrNTTEFullSecretWeapon78Tests();
        if(scrNTTEFullSmokeCase("PizzaSpawn78Tests")) scrNTTEFullPizzaSpawn78Tests();
        if(scrNTTEFullSmokeCase("PizzaShadow78Tests")) scrNTTEFullPizzaShadow78Tests();
        if(scrNTTEFullSmokeCase("PizzaShadow104Tests")) scrNTTEFullPizzaShadow104Tests();
        if(scrNTTEFullSmokeCase("PizzaShadow104NaturalTests")) scrNTTEFullPizzaShadow104NaturalTests();
        if(scrNTTEFullSmokeCase("CatWarning78Tests")) scrNTTEFullCatWarning78Tests();
        if(scrNTTEFullSmokeCase("UpdateStartupMenuTests")) scrNTTEUpdateStartupMenuTests();
        if(scrNTTEFullSmokeCase("SealKingMusicTests")) scrNTTESealKingMusicTests();
        if(scrNTTEFullSmokeCase("PitSquidMusicPhaseTests")) scrNTTEPitSquidMusicPhaseTests();
        if(scrNTTEFullSmokeCase("GoldenLoadoutDisplayTests")) scrNTTEGoldenLoadoutDisplayTests();
        if(scrNTTEFullSmokeCase("RoadmapPlayerIconsTests")) scrNTTERoadmapPlayerIconsTests();
        if(scrNTTEFullSmokeCase("ParrotPerchShadowTests")) scrNTTEParrotPerchShadowTests();
        if(scrNTTEFullSmokeCase("DummyAmbushMusicTests")) scrNTTEDummyAmbushMusicTests();
        if(scrNTTEFullSmokeCase("CrystalWaterLightningTests")) scrNTTECrystalWaterLightningTests();
        if(scrNTTEFullSmokeCase("RavenLiftTargetTests")) scrNTTERavenLiftTargetTests();
        if(scrNTTEFullSmokeCase("BubbleMergeColdStartTests")) scrNTTEBubbleMergeColdStartTests();
        if(scrNTTEFullSmokeCase("LastEnemyHiddenTimeoutTests")) scrNTTELastEnemyHiddenTimeoutTests();
        if(scrNTTEFullSmokeCase("PortalSelectionTransitionTests")) scrNTTEPortalSelectionTransitionTests();
        if(scrNTTEFullSmokeCase("LanguagePreferencePersistenceTests")) scrNTTELanguagePreferencePersistenceTests();
        if(scrNTTEFullSmokeCase("ActorFireTests")) scrNTTEFullActorFireTests();
        if(scrNTTEFullSmokeCase("CrystalWaveAccuracyNativeTests")) scrNTTEFullCrystalWaveAccuracyNativeTests();
        if(scrNTTEFullSmokeCase("LastEnemyTimeoutNativeTests")) scrNTTELastEnemyTimeoutNativeTests();
        if(scrNTTEFullSmokeCase("ActorMountTests")) scrNTTEFullActorMountTests();
        if(scrNTTEFullSmokeCase("PetWeaponTests")) scrNTTEFullPetWeaponTests();
        if(scrNTTEFullSmokeCase("FootprintTests")) scrNTTEFullFootprintTests();
        if(scrNTTEFullSmokeCase("OrchidBallTests")) scrNTTEFullOrchidBallTests();
        if(scrNTTEFullSmokeCase("OrchidBallRedTests")) scrNTTEFullOrchidBallRedTests();
        }
        if(scrNTTEFullSmokeCase("PlayerRateBootstrapTests")) scrNTTEFullPlayerRateBootstrapTests();
        if(scrNTTEFullSmokeAsyncCase("PlayerRateMotionTests")) scrNTTEFullPlayerRateMotionTests();
        if(scrNTTEFullSmokeAsyncCase("PitSquidKnockbackNativeTests")) scrNTTEFullPitSquidKnockbackNativeTests();
        if(scrNTTEFullSmokeAsyncCase("TrenchBubbleLifecycleTests")) scrNTTEFullTrenchBubbleLifecycleTests();
        if(scrNTTEFullSmokeAsyncCase("CoastVaultReturnNaturalTests")) scrNTTEFullCoastVaultReturnNaturalTests();
        assert(global.ntte_full_test_count>0,"No internal tests selected; check domain/case spelling");
        scrNTTESmokeLog("FULL INTERNAL END @"+string(30/timescale)+" tests="+string(global.ntte_full_test_count))
        tick=2
        return;
    }
    instance_destroy(projectile,false)
    instance_destroy(Explosion,false)
    instance_destroy(MeatExplosion,false)
    instance_destroy(enemy,false)
    if(++pass_index>=array_length(rates)) {
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
        return
    }
    tick=0
}
