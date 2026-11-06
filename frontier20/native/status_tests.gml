// Execute the real status registry/application/step with a target that dies
// before its timer expires. No replacement status callback or timer is used.
function scrFRStatusTimerTests() {
    var _before=scrNTTEFullInstances(all),_seed=scrFRSourceRandomGetSeed(),
        _effects=scrFRModGet("mod","Frontier_StatusEffects","statusEffects"),_saved=[];
    assert(!instance_exists(SpiralCont),"Status timer acceptance requires normal source tick dispatch");
    for(var _i=0;_i<array_length(_effects);++_i) {
        var _effect=_effects[_i];array_push(_saved,_effect.targets);_effect.targets=[];
    }
    try {
        var _effect=scrFRModGet("mod","Frontier_StatusEffects","buffSpeedUp"),
            _a=instance_create(59000,59000,FRMarker),_expired=instance_create(59032,59000,FRMarker),
            _b=instance_create(59064,59000,FRMarker),_dead=instance_create(59096,59000,FRMarker),
            _scale=scrFRSourceScale();
        assert(_scale>0,"Status timer test lost its live source timescale");
        var _targets=[_a,_expired,_b,_dead];
        for(var _i=0;_i<array_length(_targets);++_i) with(_targets[_i]) {maxspeed=0;fr_buffSpeedUp_check=true;}
        scrFRModCallArray("mod","Frontier_StatusEffects","status_apply_set",[_a,_effect,10]);
        scrFRModCallArray("mod","Frontier_StatusEffects","status_apply_set",[_expired,_effect,_scale/2]);
        scrFRModCallArray("mod","Frontier_StatusEffects","status_apply_set",[_b,_effect,20]);
        scrFRModCallArray("mod","Frontier_StatusEffects","status_apply_set",[_dead,_effect,30]);
        assert(array_length(_effect.targets)==4 && _effect.targets[3]==_dead,
            "Authored status_apply_set did not register the actual targets in source order");
        instance_destroy(_dead,false);
        // The backward loop encounters the dead target first. The original
        // unguarded code reads an uninitialized value at exactly this point.
        scrFRModCall("mod","Frontier_StatusEffects","step");
        assert(array_length(_effect.targets)==2 && _effect.targets[0]==_a && _effect.targets[1]==_b,
            "Authored status tick retained a dead/expired target or removed a live target");
        assert(_a.fr_buffSpeedUp_time==10-_scale && _b.fr_buffSpeedUp_time==20-_scale
            && _expired.fr_buffSpeedUp_time==-_scale/2,
            "Status cleanup changed the live source decrement or expired target timer");
        instance_destroy(_a,false);
        scrFRModCall("mod","Frontier_StatusEffects","step");
        assert(array_length(_effect.targets)==1 && _effect.targets[0]==_b
            && _b.fr_buffSpeedUp_time==20-2*_scale,
            "Dead status target inherited the preceding live target's positive timer");
        instance_destroy(_b,false);
        scrFRModCall("mod","Frontier_StatusEffects","step");
        assert(array_length(_effect.targets)==0,"Authored status tick failed to empty the final dead target");
        scrNTTESmokeLog("PASS FRONTIER real status application/step dead-first, live decrement, expiry and final-death cleanup");
    } finally {
        for(var _i=0;_i<array_length(_effects);++_i) {var _effect=_effects[_i];_effect.targets=_saved[_i];}
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrFRSourceRandomSetSeed(_seed);
    }
}
