function scrNTTEFullSourceSeedNativeTests() {
    var _saved=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined),
        _pending=scrNTTEFullValue(GameCont,"ntte_full_source_pending_generation",undefined),
        _global_seed=global.seed,_level_seed=GameCont.levseed,_area=GameCont.area,
        _subarea=GameCont.subarea,_loops=GameCont.loops,
        _native_seed=random_get_seed(),_rng=[]
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    try {
        GameCont.area=area_desert; GameCont.subarea=1; GameCont.loops=0
        var _s=scrNTTEFullSourceSeedBuild(1),_sum=0,_weighted=0
        // Independent Python integer reference of the recovered original
        // multiplier, modulus and floor expression, not a second call to GML.
        var _indices=[0,1,2,49,50,51,52,53,54,73,665],
            _expected=[22,85032,601352,780366,83967,181343,616696,579141,739311,674112,470517]
        for(var _i=0;_i<666;++_i) {
            _sum+=_s.gameseed[_i]; _weighted+=(_i+1)*_s.gameseed[_i]
        }
        assert(_sum==330971099 && _weighted==110262292265 && _s.random==1010428628,
            "Source seed ladder differs from original minstd48271 integer reference")
        for(var _i=0;_i<array_length(_indices);++_i)
            assert(_s.gameseed[_indices[_i]]==_expected[_i],"Source ladder sample mismatch")
        assert(_s.atseed==52 && _s.levseed==83967 && _s.wepseed==181343
            && _s.patseed==616696 && _s.codseed==579141 && _s.junseed[19]==674112
            && _s.mutseed[49]==780366 && _s.patpick==0 && _s.codpick==0
            && _s.junpick==0 && _s.mutindex==0,
            "Source scrSetSeed cursor/copy/counter order changed")
        assert(random_get_seed()==_native_seed && global.seed==_global_seed,
            "Building source ladder consumed native RNG or changed global seed")
        assert(scrNTTEFullSourceSeedBuild(0).baseseed==2147483646
            && scrNTTEFullSourceSeedBuild(-1).baseseed==1
            && scrNTTEFullSourceSeedBuild(2147483648).baseseed==2147483646,
            "Source game_set_seed signed mask or cycle endpoints differ")
        GameCont.ntte_full_source_seed=_s
        assert(scrNTTEFullSourceWarpSeed(0)==616696 && scrNTTEFullSourceWarpSeed(1)==579141,
            "Warp selection did not use current source atseed+older Warp count")
        _s.atseed=665
        assert(scrNTTEFullSourceWarpSeed(1)==22,"Warp ladder wrap failed")
        _s.atseed=-1
        assert(scrNTTEFullSourceWarpSeed(1)==85032,"Warp negative cursor must clamp before adding count")
        _s.patpick=4; _s.codpick=5; _s.junpick=6; _s.mutindex=7
        assert(scrNTTEFullSourceWarpSetSeed(123)==1,"Warp source game_set_seed return changed")
        var _new=GameCont.ntte_full_source_seed,_fresh=scrNTTEFullSourceSeedBuild(123)
        assert(_new.baseseed==123 && global.seed==123 && _new.gameseed[665]==_fresh.gameseed[665]
            && _new.patseed==_s.patseed && _new.codseed==_s.codseed
            && _new.mutseed[49]==_s.mutseed[49] && _new.junseed[19]==_s.junseed[19]
            && _new.patpick==0 && _new.codpick==0 && _new.junpick==0 && _new.mutindex==0,
            "Warp failed to retain exactly four source fields across full seed reset")
        _new.mutseed[@0]=777; _new.junseed[@0]=888
        assert(_s.mutseed[0]==22 && _s.junseed[0]==739311,"Warp preserved arrays by alias instead of clone")
        scrRngStatesReset()
        assert(GameCont.levseed==_fresh.gameseed[4] && global.rng_state[RNGStates.Generation]==_fresh.gameseed[4]
            && is_undefined(GameCont.ntte_full_source_pending_generation),
            "Native RNG reset overwrote pending source level seed or left it active")
        assert(!scrNTTEFullSourceSeedGenerationApply(),"Source generation override repeated after consumption")
        var _json=json_parse(json_stringify(_new))
        assert(_json.atseed==52 && _json.gameseed[665]==_new.gameseed[665]
            && _json.mutseed[0]==777 && _json.junseed[0]==888 && _json.random==_new.random,
            "Source seed state cannot roundtrip through native session JSON")
        var _vanilla=scrNTTEFullSourceSeedStage(area_sewers,1,0)
        assert(_vanilla.atseed==11 && _vanilla.levseed==_vanilla.gameseed[10],
            "Source even numeric area branch selected a wrong level seed")
        var _secret=scrNTTEFullSourceSeedStage(area_oasis,1,1)
        assert(_secret.atseed==39 && _secret.levseed==_secret.gameseed[38],
            "Source secret area/subarea offset or loop16 seed stride changed")
        var _hq=scrNTTEFullSourceSeedStage(area_hq,2,0)
        assert(_hq.random==2 && _hq.atseed==31,"Source HQ RNG must use subarea while retaining ladder fields")
        var _previous=GameCont.ntte_full_source_seed
        scrNTTEFullSourceSeedAdvanceStage()
        assert(_previous.areanum==0 && GameCont.ntte_full_source_seed.areanum==1,
            "Source areanum advance mutated prior state or skipped a stage")
        GameCont.area=scrNTTEFullAreaId("red")
        scrRngStatesReset()
        var _stage=GameCont.ntte_full_source_seed
        assert(_stage.areanum==1 && _stage.atseed==3 && _stage.levseed==_stage.gameseed[2]
            && _stage.wepseed==_stage.gameseed[3] && _stage.random==scrNTTEFullDropSeed(_stage.levseed)
            && GameCont.levseed==_stage.levseed,
            "Source string-area stage did not use areanum*2/cursor increment/level RNG reset")
        _stage.areanum=333
        scrNTTEFullSourceSeedCustomStage()
        assert(GameCont.ntte_full_source_seed.atseed==1
            && scrNTTEFullSourceWarpSeed(0)==_stage.gameseed[1],
            "Custom stage ladder did not wrap before assigning the Warp cursor")
        var _r={random:1},_array=[1,2,3,4],_shuffled=scrNTTEFullSourceShuffle(_array,_r)
        assert(_array[0]==1 && _array[3]==4 && _r.random==1914720637,
            "Source shuffle changed original array or omitted final random draw")
        scrNTTEFullSourceRandomSeed(1,_r)
        assert(scrNTTEFullSourceIRandomRange(9,4,_r)==4 && _r.random==48271,
            "Source inclusive random range normalization changed")
        assert(scrNTTEFullSourceRandom(0,_r)==0 && _r.random==182605794,
            "Source random(0) must consume the stream and return zero")
    }
    finally {
        GameCont.ntte_full_source_seed=_saved
        GameCont.ntte_full_source_pending_generation=_pending
        GameCont.levseed=_level_seed; GameCont.area=_area; GameCont.subarea=_subarea; GameCont.loops=_loops
        global.seed=_global_seed; global.rng_state=_rng
        random_set_seed(_native_seed)
    }
    scrNTTESmokeLog("FULL SOURCE SEED: 666 original minstd values/checksums/cursor/streams, signed normalization, Warp preserve+clone four fields, native one-shot generation override, JSON and source forward shuffle OK @"+string(30/timescale))
}
