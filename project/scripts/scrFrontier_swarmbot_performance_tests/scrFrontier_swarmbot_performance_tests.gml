function scrFRSwarmbotQueryOracle(_field,_value) {
    return scrFRMatching(scrFRMatching(enemy,"name","Swarmer"),_field,_value);
}

function scrFRSwarmbotQueryCompare(_field,_value) {
    var _source=scrFRSwarmbotQueryOracle(_field,_value),_actual=scrFRSwarmbotMatching(_field,_value);
    assert(array_length(_source)==array_length(_actual),"Swarmer single-pass query changed source membership");
    for(var _i=0;_i<array_length(_source);++_i)
        assert(_source[_i]==_actual[_i] && typeof(_source[_i])==typeof(_actual[_i]),
            "Swarmer single-pass query changed source traversal order or reference representation");
    return array_length(_source);
}

function scrFRSwarmbotPerformanceTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),
        "Swarmer regression requires the settled isolated NTUF desktop harness");
    var _before=scrNTTEFullInstances(all),_seed=random_get_seed(),_source_seed=scrFRSourceRandomGetSeed(),
        _actors=[],_checked=0,_source_us=0,_native_us=0;
    try {
        for(var _i=0;_i<20;++_i) {
            // Interleave source Swarmers and unrelated native enemies so the
            // oracle checks actual parent traversal, not a hand-sorted fixture.
            var _actor=(_i%3==0)?instance_create(730000+_i*24,730000,Bandit)
                :scrFRModCall("mod","Frontier_Labs","Swarmbot_create",730000+_i*24,730000);
            array_push(_actors,_actor);
        }
        var _commander=_actors[1],_other_commander=_actors[2];
        for(var _i=0;_i<array_length(_actors);++_i) {
            var _actor=_actors[_i];
            _actor.myCommander=(_i%4==0)?noone:((_i%4==1)?real(_commander):_other_commander);
            _actor.commAvailable=(_i%2==0);
        }
        var _missing=instance_create(730640,730000,FRCustomEnemy);
        _missing.name="Swarmer";
        // The generic native base need not define the source commander field.
        // Explicit undefined also exercises the original missing-value match.
        _missing.myCommander=undefined;
        var _query_seed=random_get_seed(),_query_source_seed=scrFRSourceRandomGetSeed();
        repeat(2) {
            scrFRSwarmbotQueryCompare("myCommander",noone);++_checked;
            scrFRSwarmbotQueryCompare("myCommander",_commander);++_checked;
            scrFRSwarmbotQueryCompare("myCommander",real(_other_commander));++_checked;
            scrFRSwarmbotQueryCompare("myCommander",undefined);++_checked;
            scrFRSwarmbotQueryCompare("commAvailable",true);++_checked;
            scrFRSwarmbotQueryCompare("commAvailable",false);++_checked;
            scrFRSwarmbotQueryCompare("commAvailable",undefined);++_checked;
            // Live changes must be visible immediately, without invalidation.
            _actors[4].myCommander=real(_commander);
            _actors[5].name="not a Swarmer";
            _actors[7].commAvailable=!_actors[7].commAvailable;
        }
        instance_destroy(_actors[8],false);
        scrFRSwarmbotQueryCompare("myCommander",real(_other_commander));++_checked;
        _missing.myCommander=real(_commander);_missing.commAvailable=true;
        scrFRSwarmbotQueryCompare("myCommander",real(_commander));++_checked;
        scrFRSwarmbotQueryCompare("commAvailable",true);++_checked;
        var _start=get_timer();
        repeat(128) scrFRSwarmbotQueryOracle("myCommander",noone);
        _source_us=get_timer()-_start;_start=get_timer();
        repeat(128) scrFRSwarmbotMatching("myCommander",noone);
        _native_us=get_timer()-_start;
        assert(_query_seed==random_get_seed() && _query_source_seed==scrFRSourceRandomGetSeed(),
            "Swarmer filtering consumed native or source gameplay RNG");
        assert(_checked==17,"Swarmer query fixture missed a live equality/order case");
        scrNTTESmokeLog("PASS FRONTIER Swarmer single-pass filtering retains source membership, traversal order, typed reference equality, undefined fields and immediate recruit/rename/death state; 128 queries source_us="
            +string(_source_us)+" native_us="+string(_native_us));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);random_set_seed(_seed);scrFRSourceRandomSetSeed(_source_seed);
    }
}
