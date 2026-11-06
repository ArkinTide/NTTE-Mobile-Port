function scrNTTEFullCampfireWorldNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _hidden=scrNTTEFullInstances([Corpse,NightBonePile,Wall,CampChar,Campfire,LogMenu,Menu,TV,PortalClear]),_seed=random_get_seed(),
        _saved_ready=global.ntte_full_feature_ready,_saved_progress=global.ntte_full_progress
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        // This negative case must explicitly close certificates; the ordinary
        // production map now opens earned characters after source validation.
        global.ntte_full_feature_ready={}
        var _races=scrNTTEFullCampfireDecorCandidates([NTTEFullRace.Beetle,NTTEFullRace.Parrot],[NTTEFullRace.Parrot])
        assert(array_length(_races)==1 && _races[0]==NTTEFullRace.Beetle,
            "Campfire inactive corpse selection ignored actual selected race")
        assert(!array_length(scrNTTEFullCampfireDecorCandidates([],[]))
            && !array_length(scrNTTEFullCampfireDecorCandidates([NTTEFullRace.Parrot],[NTTEFullRace.Parrot])),
            "Campfire spawned unavailable or active race corpse")
        var _wall=instance_create(104064,104000,Wall),
            _beetle=scrNTTEFullCampfireCorpse(NTTEFullRace.Beetle,104016,104016),
            _parrot=scrNTTEFullCampfireCorpse(NTTEFullRace.Parrot,104016,104016)
        assert(instance_is(_beetle,Corpse) && instance_is(_parrot,Corpse)
            && _beetle.sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Beetle,"Dead",0)
            && _parrot.sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Dead",0)
            && _beetle.image_index==_beetle.image_number-1 && _parrot.image_index==_parrot.image_number-1
            && _beetle.xstart==104016 && _beetle.ystart==104000
            && _parrot.xstart==104016 && _parrot.ystart==104000
            && _beetle.x==round(_beetle.x) && _beetle.y==round(_beetle.y)
            && !collision_circle(_parrot.x,_parrot.y,12,_beetle,true,false),
            "Campfire actual corpses lost exact race artwork/final frame/source anchor/spacing")
        var _bones=[]
        repeat(24) array_push(_bones,instance_create(104500+array_length(_bones)*32,104000,NightBonePile))
        // Native with-order follows the active instance pool, not creation ID.
        _bones=[]
        with(NightBonePile) array_push(_bones,id)
        random_set_seed(1221)
        var _survivors=[]
        repeat(24) array_push(_survivors,!chance(1,3))
        GameCont.area=area_desert;random_set_seed(1221)
        assert(!array_length(scrNTTEFullCampfireDecorLevelStart()) && instance_number(NightBonePile)==24,
            "Campfire decoration modified an ordinary level")
        GameCont.area=area_campfire;random_set_seed(1221)
        var _new=scrNTTEFullCampfireDecorLevelStart()
        assert(!array_length(_new),"Explicit closed readiness escaped through campfire corpses")
        for(var _i=0;_i<24;++_i)
            assert(instance_exists(_bones[_i])==_survivors[_i],"Source one-third night bone deletion order changed")
        global.ntte_full_feature_ready={}
        global.ntte_full_feature_ready[$ "race:beetle"]=true
        global.ntte_full_feature_ready[$ "race:parrot"]=true
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_progress.unlocks[$ "race:beetle"]=true
        global.ntte_full_progress.unlocks[$ "race:parrot"]=true
        var _beetle_count=0,_parrot_count=0
        with(Corpse) {
            if(sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Beetle,"Dead",0)) _beetle_count++
            if(sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Dead",0)) _parrot_count++
        }
        // Exercise the real native prelude followed by the actual NTTE callback.
        scrCampfireMenuCreate(true)
        var _beetle_native=0,_parrot_native=0
        with(Corpse) {
            if(sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Beetle,"Dead",0)) _beetle_native++
            if(sprite_index==scrNTTEFullRaceSprite(NTTEFullRace.Parrot,"Dead",0)) _parrot_native++
        }
        assert(_beetle_native==_beetle_count && _parrot_native==_parrot_count,
            "Native post-loop campfire duplicated NTTE-owned corpses before the MOD callback")
        var _eligible=scrNTTEFullCampfireDecorCandidates([NTTEFullRace.Beetle,NTTEFullRace.Parrot],scrNTTEFullRaceProgressSelected()),
            _created=scrNTTEFullCampfireDecorLevelStart()
        assert(array_length(_created)==array_length(_eligible),
            "Actual campfire native+MOD chain lost exactly one corpse per inactive custom race")
        for(var _i=0;_i<array_length(_eligible);++_i) {
            var _count=0,_race=_eligible[_i]
            with(Corpse) if(sprite_index==scrNTTEFullRaceSprite(_race,"Dead",0)) _count++
            assert(_count==1+(_race==NTTEFullRace.Parrot ? _parrot_count:_beetle_count),
                "Actual post-loop campfire retained duplicate custom corpses: "+scrNTTEFullRaceKey(_race))
        }
    }
    finally {
        global.ntte_full_feature_ready=_saved_ready
        global.ntte_full_progress=_saved_progress
        var _after=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after);++_i)
            if(array_get_index(_before,_after[_i])<0 && instance_exists(_after[_i])) instance_destroy(_after[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL CAMPFIRE DECOR: actual native dead-menu+MOD callback one corpse per inactive custom race/source final-frame art+anchor+spacing/night bone one-third ordered removal/natural gates retained OK @"+string(30/timescale))
}
