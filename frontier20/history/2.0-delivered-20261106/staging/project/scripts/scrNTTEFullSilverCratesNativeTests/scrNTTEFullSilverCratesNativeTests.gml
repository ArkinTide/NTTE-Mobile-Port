function scrNTTEFullSilverCratesNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),
        _parked=scrNTTEFullInstances([Floor,Wall,TopSmall,enemy,prop,chestprop,RadChest,NTTEFullWallCrate])
    scrNTTEFullSystemsInit()
    var _old_skills=GameCont.ntte_full_skills
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=area_desert;GameCont.hard=2;GameCont.subarea=1;GameCont.loops=0;GameCont.crown=Crown.None
        GameCont.ntte_full_skills={};variable_struct_set(GameCont.ntte_full_skills,"silver tongue",2)
        instance_create(260016,260016,Bandit)
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
        scrNTTEFullFloorFill(260016,260016,7,5)
        random_set_seed(6123)
        var _rooms=scrNTTEFullSilverCratesLevelStart(260016,260016)
        scrNTTESmokeLog("SILVER CRATES DIAGNOSTIC skill="+string(scrNTTEFullSkillGet("silver tongue"))+" rooms="+string(array_length(_rooms))+" crates="+string(instance_number(NTTEFullWallCrate))+" floors="+string(instance_number(Floor))+" enemies="+string(instance_number(enemy)))
        assert(array_length(_rooms)==2 && instance_number(NTTEFullWallCrate)==2,
            "Source SilverTongue2 did not create two genuine1..2square rooms and crates")
        with(NTTEFullWallCrate) {
            assert(instance_exists(crate_loot) && crate_loot.x==x && crate_loot.y==y-4
                && (instance_is(crate_loot,NTTEFullCatChest) || instance_is(crate_loot,NTTEFullBatChest) || instance_is(crate_loot,NTTEFullRatChest)),
                "Source SilverTongue crate omitted actual level_start animal chest or source y-4 position")
            assert(array_length(crate_wall)>0,"Source SilverTongue bypassed actual WallCrate construction")
        }
        var _count=instance_number(NTTEFullWallCrate)
        GameCont.subarea=2
        assert(array_length(scrNTTEFullSilverCratesLevelStart(260016,260016))==0 && instance_number(NTTEFullWallCrate)==_count,
            "Source SilverTongue crates spawned outside subarea1")
        GameCont.subarea=1;GameCont.hard=1
        assert(array_length(scrNTTEFullSilverCratesLevelStart())==0,"Source SilverTongue bypassed normalArea hard>1")
        GameCont.hard=2;instance_destroy(enemy,false)
        assert(array_length(scrNTTEFullSilverCratesLevelStart())==0,"Source SilverTongue bypassed ordinary enemy count gate")
        variable_struct_set(GameCont.ntte_full_skills,"silver tongue",0)
        instance_create(260016,260016,Bandit)
        assert(array_length(scrNTTEFullSilverCratesLevelStart())==0,"Source SilverTongue spawned crates with zero skill")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        GameCont.ntte_full_skills=_old_skills
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);random_set_seed(_seed)
        scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    }
    scrNTTESmokeLog("FULL SILVER TONGUE CRATES actual two1..2square source rooms/genuine WallCrate walls/real Cat-Bat-Rat chest/level_start placement/normalArea+subarea+skill gates OK @"+string(30/timescale))
}
