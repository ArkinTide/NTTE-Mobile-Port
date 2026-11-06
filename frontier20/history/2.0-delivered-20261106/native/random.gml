// NTT's random_get_seed returns the current minstd state, so a source HUD
// can save/restore it without replaying the start of the whole game stream.
// Modern GMS exposes its initial seed instead. Keep every compiled Frontier
// random operation on the recovered NTT ladder; native rendering may reseed
// its own GMS stream without changing the author's probabilities or draws.
function scrFRSourceRandomState(_controller=GameCont) {
    if(instance_exists(_controller)) return scrNTTEFullSourceSeedState();
    // Source modules also initialize in the menu before GameCont exists.
    // This bootstrap stream never becomes the later run's source ladder.
    if(!variable_global_exists("fr_source_bootstrap_random")
        || !is_struct(global.fr_source_bootstrap_random)) {
        var _seed=variable_global_exists("seed")?global.seed:1;
        global.fr_source_bootstrap_random={random:scrNTTEFullDropSeed(_seed)};
    }
    return global.fr_source_bootstrap_random;
}
function scrFRSourceRandom(_maximum) {
    return scrNTTEFullSourceRandom(_maximum,scrFRSourceRandomState());
}
function scrFRSourceIRandom(_maximum) {
    return scrNTTEFullSourceIRandom(_maximum,scrFRSourceRandomState());
}
function scrFRSourceRandomRange(_a,_b) {
    return scrNTTEFullSourceRandomRange(_a,_b,scrFRSourceRandomState());
}
function scrFRSourceIRandomRange(_a,_b) {
    return scrNTTEFullSourceIRandomRange(_a,_b,scrFRSourceRandomState());
}
function scrFRSourceChoose() {
    assert(argument_count>0,"Source choose requires at least one argument");
    return argument[scrFRSourceIRandom(argument_count-1)];
}
function scrFRSourceRandomGetSeed() {return scrFRSourceRandomState().random;}
function scrFRSourceRandomSetSeed(_seed) {
    scrNTTEFullSourceRandomSeed(_seed,scrFRSourceRandomState());
    return 0;
}

// Fixed values below come from independent integer minstd reference vectors,
// also checked by scrNTTEFullSourceSeedNativeTests against recovered NTT YYC.
// The fixture is compiled from legacy source, including actual get/set calls.
function scrFRSourceRandomTests() {
    var _saved=GameCont.ntte_full_source_seed,
        _had_bootstrap=variable_global_exists("fr_source_bootstrap_random"),
        _bootstrap=_had_bootstrap?global.fr_source_bootstrap_random:undefined;
    try {
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(57323);
        var _ladder=GameCont.ntte_full_source_seed,_vector=fr_tests_frontier_gml_source_random_vector(1);
        assert(_vector[0]==1 && _vector[2]==48271 && _vector[3]==0
            && abs(_vector[1]-0.0022477936010098986)*1000000000000<1
            && abs(_vector[4]-7.006763026587089)*1000000000000<1
            && _vector[5]==9 && _vector[6]=="c" && _vector[7]==0
            && _vector[8]==407355683,
            "Compiled source random/ranges/choose changed NTT values or draw consumption");
        assert(GameCont.ntte_full_source_seed==_ladder && _ladder.baseseed==57323,
            "Source random_set_seed rebuilt the game seed ladder instead of its current RNG state");
        var _continued=fr_tests_frontier_gml_source_random_save_restore(1);
        assert(_continued[1]==48271 && _continued[3]==182605794
            && abs(_continued[0]-0.0022477936010098986)*1000000000000<1
            && abs(_continued[2]-8.503244914348818)*1000000000000<1,
            "Compiled HUD get/set failed to restore the current source state and continue after it");
        // These real host draw helpers save/reseed GMS every rendering frame.
        // Even a deliberate native reset cannot restart the source sequence.
        var _native_seed=random_get_seed(),_states=[48271,182605794,1291394886,1914720637,
            2078669041,407355683,1105902161,854716505];
        scrFRSourceRandomSetSeed(1);
        for(var _i=0;_i<array_length(_states);++_i) {
            random_set_seed(_native_seed);
            fr_tests_frontier_gml_source_random_next();
            assert(scrFRSourceRandomGetSeed()==_states[_i],
                "Host rendering reseed restarted the compiled source RNG sequence");
        }
        assert(fr_tests_frontier_gml_source_random_seed_only(0)==2147483646
            && fr_tests_frontier_gml_source_random_seed_only(-1)==2147483645
            && fr_tests_frontier_gml_source_random_seed_only(2147483647)==1,
            "Compiled random_set_seed changed the original rounded cyclic seed endpoints");
        // Exercise the actual no-controller branch without deleting a live
        // run's controller or letting bootstrap state replace its seed ladder.
        global.fr_source_bootstrap_random=undefined;
        var _menu=scrFRSourceRandomState(noone);
        scrNTTEFullSourceRandomSeed(1,_menu);
        assert(scrNTTEFullSourceRandom(100,_menu)>0 && _menu.random==48271
            && scrFRSourceRandomState(noone)==_menu
            && scrFRSourceRandomState()==_ladder && _ladder.random==1,
            "Menu bootstrap RNG failed to persist independently of the live source ladder");
        // Use the real native Continue session writer and reader, including
        // their JSON representation of dynamic GameCont source-ladder fields.
        // This preserves the current cursor rather than seeding a new stream.
        var _buffer=buffer_create(4096,buffer_grow,1);
        try {
            scrFRSourceRandomSetSeed(1);
            fr_tests_frontier_gml_source_random_next();
            assert(scrFRSourceRandomGetSeed()==48271,"Continue RNG precondition changed");
            scrSavegameSession(_buffer,false);
            scrFRSourceRandomSetSeed(999);
            fr_tests_frontier_gml_source_random_next();
            assert(scrFRSourceRandomGetSeed()!=48271,
                "Continue RNG positive control failed to disturb the saved cursor");
            buffer_seek(_buffer,buffer_seek_start,0);
            scrSavegameSession(_buffer,true);
            assert(scrFRSourceRandomGetSeed()==48271,
                "Native Continue session did not restore the compiled source's current RNG state");
            var _after=fr_tests_frontier_gml_source_random_next();
            assert(scrFRSourceRandomGetSeed()==182605794
                && abs(_after-8.503244914348818)*1000000000000<1,
                "Native Continue restored the source seed but restarted or skipped its next random value");
        } finally {buffer_delete(_buffer);}
    } finally {
        GameCont.ntte_full_source_seed=_saved;
        global.fr_source_bootstrap_random=_bootstrap;
    }
    scrNTTESmokeLog("PASS FRONTIER compiled original NTT RNG vectors, HUD continuation, native reseed isolation and menu bootstrap");
}
