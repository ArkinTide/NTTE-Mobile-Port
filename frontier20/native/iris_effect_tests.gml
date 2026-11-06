function scrFRIrisBloomTestActualDraw() {gpu_set_blendmode(bm_add);scrFRIrisBloomDraw();}
function scrFRIrisBloomTestReferenceDraw() {
    gpu_set_blendmode(bm_add);
    var _a=fr_iris_expected;
    draw_sprite_ext(_a[0],_a[1],_a[2],_a[3],_a[4],_a[5],_a[6],_a[7],_a[8]);
}

function scrFRIrisBloomTests() {
    var _before=scrNTTEFullInstances(all),_captures=[],_controller=instance_create(48000,48000,FRCustomObject),
        _sprites=scrFRModGet("mod","Frontier_IrisProjectiles","spr");
    try {
        var _types=[FRCustomProjectile,FRCustomObject,FRCustomSlash];
        for(var _i=0;_i<array_length(_types);++_i) {
            var _actor=instance_create(48064,48064,_types[_i]);
            _actor.sprite_index=_sprites.FireBullet;_actor.image_index=1;
            _actor.image_xscale=.75;_actor.image_yscale=1.25;_actor.image_angle=17;
            _actor.image_alpha=.8;_actor.image_blend=c_aqua;
            _actor.defbloom={xscale:2,yscale:2,alpha:.2};
            if(_i==1) {_actor.defbloom.sprite=_sprites.ToxicBullet;_actor.defbloom.angle=41;}
            _controller.on_draw=scrFRIrisBloomTestActualDraw;
            var _actual=scrFRVisualCapture("actor-event",128,128,48000,48000,[_controller]);
            array_push(_captures,_actual);
            _controller.fr_iris_expected=[_i==1?_sprites.ToxicBullet:_sprites.FireBullet,
                1,48064,48064,1.5,2.5,_i==1?41:17,c_aqua,.16];
            _controller.on_draw=scrFRIrisBloomTestReferenceDraw;
            var _expected=scrFRVisualCapture("actor-event",128,128,48000,48000,[_controller]);
            array_push(_captures,_expected);
            assert(_actual.coverage>8 && _actual.ink>0 && _expected.coverage>8
                && scrFRVisualSamePixels(_actual,_expected),
                "Real Iris bloom consumer lost authored sprite/angle fallback, transform, colour or alpha");
            if(_i==0) scrFRVisualSave(_actual,"frontier-iris-projectile-bloom.png");
            else if(_i==1) scrFRVisualSave(_actual,"frontier-iris-object-bloom.png");
            else scrFRVisualSave(_actual,"frontier-iris-slash-bloom.png");
            instance_destroy(_actor,false);
        }
        var _empty=scrFRVisualCapture("empty",128,128,48000,48000,[]);
        array_push(_captures,_empty);
        assert(_empty.coverage==0,"Iris GPU negative control contains unexpected pixels");
        scrNTTESmokeLog("PASS FRONTIER real GPU Iris bloom projectile/object/slash source/default and override pixels with positive and empty controls");
    } finally {
        for(var _i=0;_i<array_length(_captures);++_i) scrFRVisualFree(_captures[_i]);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
    }
}
