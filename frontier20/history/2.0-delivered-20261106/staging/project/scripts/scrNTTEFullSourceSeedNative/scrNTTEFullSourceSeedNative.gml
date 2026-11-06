// Read-only NTT 9940 evidence: native-game-seed.txt, native-set-seed.txt,
// native-seed-counter-fields.txt, pickup-drop-native-helpers.txt.
// This ladder is independent of Epsilon's RNGStates and GMS random stream.
function scrNTTEFullSourceSeedBuild(_seed) {
    var _base=scrNTTEFullDropSeed(int64(_seed)&$7fffffff)
    var _state={schema:1,areanum:0,baseseed:_base,random:_base,gameseed:array_create(666),
        mutseed:array_create(50),atseed:52,levseed:0,wepseed:0,
        patseed:0,patpick:0,codseed:0,codpick:0,
        junseed:array_create(20),junpick:0,mutindex:0}
    for(var _i=0;_i<666;++_i) {
        _state.random=(48271*_state.random) mod 2147483647
        _state.gameseed[@_i]=floor(_state.random/(2147483647/1000000))
    }
    array_copy(_state.mutseed,0,_state.gameseed,0,50)
    _state.levseed=_state.gameseed[50]
    _state.wepseed=_state.gameseed[51]
    _state.patseed=_state.gameseed[52]
    _state.codseed=_state.gameseed[53]
    array_copy(_state.junseed,0,_state.gameseed,54,20)
    return _state
}
function scrNTTEFullSourceSeedState() {
    var _state=scrNTTEFullValue(GameCont,"ntte_full_source_seed",undefined)
    if(!is_struct(_state)) {
        _state=scrNTTEFullSourceSeedBuild(global.seed)
        GameCont.ntte_full_source_seed=_state
    }
    return _state
}
function scrNTTEFullSourceRandom(_max,_state=undefined) {
    if(is_undefined(_state)) _state=scrNTTEFullSourceSeedState()
    _state.random=(48271*_state.random) mod 2147483647
    if(_max==0) return 0
    return _state.random/(2147483647/_max)
}
function scrNTTEFullSourceIRandom(_max,_state=undefined) {
    return floor(scrNTTEFullSourceRandom(_max+1,_state))
}
function scrNTTEFullSourceRandomSeed(_seed,_state=undefined) {
    if(is_undefined(_state)) _state=scrNTTEFullSourceSeedState()
    _state.random=scrNTTEFullDropSeed(_seed)
}
function scrNTTEFullSourceRandomRange(_a,_b,_state=undefined) {
    return min(_a,_b)+scrNTTEFullSourceRandom(abs(_b-_a),_state)
}
function scrNTTEFullSourceIRandomRange(_a,_b,_state=undefined) {
    return min(_a,_b)+scrNTTEFullSourceIRandom(abs(_b-_a),_state)
}
function scrNTTEFullSourceChoose(_array,_state=undefined) {
    return _array[scrNTTEFullSourceIRandom(array_length(_array)-1,_state)]
}
function scrNTTEFullSourceShuffle(_array,_state=undefined) {
    var _copy=array_create(array_length(_array))
    array_copy(_copy,0,_array,0,array_length(_array))
    // telib.mod.gml:1945 forward Fisher-Yates; consume final irandom(0).
    for(var _i=0;_i<array_length(_copy);++_i) {
        var _j=scrNTTEFullSourceIRandomRange(_i,array_length(_copy)-1,_state),_v=_copy[_i]
        _copy[@_i]=_copy[_j]; _copy[@_j]=_v
    }
    return _copy
}
function scrNTTEFullSourceWarpSeed(_olderWarpCount) {
    var _state=scrNTTEFullSourceSeedState()
    return _state.gameseed[(max(0,_state.atseed)+_olderWarpCount) mod array_length(_state.gameseed)]
}
function scrNTTEFullSourceWarpSetSeed(_seed) {
    var _old=scrNTTEFullSourceSeedState(),_state=scrNTTEFullSourceSeedBuild(_seed)
    // Source Warp.Destroy clones exactly these four fields across game_set_seed.
    // Counters (patpick/codpick/junpick/mutindex) are reset by scrSetSeed.
    array_copy(_state.mutseed,0,_old.mutseed,0,array_length(_old.mutseed))
    array_copy(_state.junseed,0,_old.junseed,0,array_length(_old.junseed))
    _state.patseed=_old.patseed; _state.codseed=_old.codseed
    // scrSetSeed never resets GameCont.areanum; it is separate run progress.
    _state.areanum=_old.areanum
    GameCont.ntte_full_source_seed=_state
    global.seed=_state.baseseed
    GameCont.ntte_full_source_pending_generation=_state.levseed
    GameCont.levseed=_state.levseed
    return 1
}
function scrNTTEFullSourceSeedCopy(_state) {
    var _copy={},_keys=variable_struct_get_names(_state)
    for(var _i=0;_i<array_length(_keys);++_i)
        variable_struct_set(_copy,_keys[_i],variable_struct_get(_state,_keys[_i]))
    return _copy
}
function scrNTTEFullSourceSeedAdvanceStage() {
    // Original GameCont.RoomEnd increments areanum once after advancement gate.
    var _state=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState())
    _state.areanum+=1
    GameCont.ntte_full_source_seed=_state
}
function scrNTTEFullSourceSeedCustomStage() {
    return scrNTTEFullSourceSeedStage(GameCont.area,GameCont.subarea,GameCont.loops).levseed
}
function scrNTTEFullSourceSeedStage(_area,_subarea,_loops) {
    // Original scrGameContSetLevSeed string-area branch (0x5D6F91):
    // atseed=areanum; universal *=2, mod666, clamp0; levseed=seed[atseed++];
    // wepseed=seed[atseed]. The arithmetic helper 0x426E30 is multiplication.
    var _state=scrNTTEFullSourceSeedCopy(scrNTTEFullSourceSeedState())
    var _index=_state.areanum
    if(scrNTTEFullAreaKey(_area)=="") {
        var _number=_area,_sub=_subarea
        if(_number>=100) {_number-=100; _sub+=1}
        // Native YYC comparison returns zero for equality. Its odd/even
        // branches are (area+1)*2-3 and area*2, respectively.
        _index=(round(_number/2)!=_number/2)?(_number+1)*2-3:_number*2
        _index+=_sub+16*_loops
    }
    _state.atseed=max(0,(_index*2) mod 666)
    _state.levseed=_state.gameseed[_state.atseed++]
    _state.wepseed=_state.gameseed[_state.atseed]
    _state.random=scrNTTEFullDropSeed(_area==106?_subarea:_state.levseed)
    GameCont.ntte_full_source_seed=_state
    return _state
}
function scrNTTEFullSourceSeedGenerationApply() {
    // Compatibility boundary: retain Epsilon's other native streams; only the
    // next native generation receives the source level seed after a Warp.
    // Source-authored Red draws call SourceRandom explicitly. Native terrain
    // constructors still consume GMS RNG, so identical PC maps are not claimed.
    var _pending=scrNTTEFullValue(GameCont,"ntte_full_source_pending_generation",undefined)
    var _state=scrNTTEFullSourceSeedStage(GameCont.area,GameCont.subarea,GameCont.loops),_seed=_state.levseed
    if(is_undefined(_pending) && scrNTTEFullAreaKey(GameCont.area)=="") return false
    global.rng_state[@RNGStates.Generation]=_seed
    GameCont.levseed=_seed
    random_set_seed(_seed)
    GameCont.ntte_full_source_pending_generation=undefined
    return true
}
