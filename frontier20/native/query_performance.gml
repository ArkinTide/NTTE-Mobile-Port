// Preserve ordered instance union and the Runner's reference equality while
// avoiding an ever-growing full-array scan for every entity in each family.
function scrFRInstanceUnionIndex(_items) {
    var _seen={};
    for(var _i=0;_i<array_length(_items);++_i) {
        var _value=_items[_i],_key=string(real(_value)),_bucket=_seen[$ _key]??[];
        array_push(_bucket,_value);_seen[$ _key]=_bucket;
    }
    return _seen;
}
function scrFRInstanceUnionAdd(_seen,_value) {
    var _key=string(real(_value)),_bucket=_seen[$ _key]??[];
    if(array_contains(_bucket,_value)) return false;
    array_push(_bucket,_value);_seen[$ _key]=_bucket;return true;
}
function scrFRQueryUnionTests() {
    var _before=scrNTTEFullInstances(all),_actors=[],_old=[],_actual=[];
    try {
        repeat(240) array_push(_actors,instance_create(18016,18016,FRCustomObject));
        // Seed duplicates and mixed reference forms deliberately. Existing
        // output entries must remain; later union entries follow old equality.
        _old=[_actors[0],real(_actors[0]),_actors[0]];_actual=_old;
        var _input=[];
        for(var _i=0;_i<array_length(_actors);++_i) {
            array_push(_input,_actors[_i]);array_push(_input,real(_actors[_i]));
        }
        for(var _i=0;_i<array_length(_input);++_i)
            if(!array_contains(_old,_input[_i])) array_push(_old,_input[_i]);
        var _seen=scrFRInstanceUnionIndex(_actual);
        for(var _i=0;_i<array_length(_input);++_i)
            if(scrFRInstanceUnionAdd(_seen,_input[_i])) array_push(_actual,_input[_i]);
        assert(array_length(_actual)==array_length(_old),"Instance union changed duplicate/reference equality");
        for(var _i=0;_i<array_length(_old);++_i)
            assert(_actual[_i]==_old[_i] && typeof(_actual[_i])==typeof(_old[_i]),
                "Instance union changed source order or first reference representation");
        var _types=[FRCustomObject,FRSourceEffect,FRCustomObject],_oracle=[];
        for(var _i=0;_i<array_length(_types);++_i)
            with(_types[_i]) if(!array_contains(_oracle,id)) array_push(_oracle,id);
        _actual=scrFRObjectCollect(_types,[]);
        assert(array_length(_actual)==array_length(_oracle),"Family union changed native overlap membership");
        for(var _i=0;_i<array_length(_oracle);++_i)
            assert(_actual[_i]==_oracle[_i] && typeof(_actual[_i])==typeof(_oracle[_i]),
                "Family union changed the authored first-family traversal order");
        scrNTTESmokeLog("PASS FRONTIER indexed family union retains exact source order, typed-reference equality and duplicate handling");
    } finally {scrNTTEFullMergedRuntimeTestCleanup(_before);}
}
