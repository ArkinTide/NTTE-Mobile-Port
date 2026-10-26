// Real native constructors/destruction and render work. Timings are host CPU
// observations, not mobile frame-rate claims. Same scene/seed before/after.
function scrRelease121TimeSummary(_samples) {
    array_sort(_samples,true);
    return {median_us:_samples[array_length(_samples) div 2],max_us:_samples[array_length(_samples)-1]};
}
function scrRelease121DecorDraw() {
    with(Detail) draw_self();
    with(DPStaticDecor) draw_self();
    with(DPDecorBatch) event_perform(ev_draw,0);
}
function scrRelease121PerformanceTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),
        _surface=-1,_camera=-1,_target=false,_state=scrNTTEFullCoastDrawState(),_shader=shader_current();
    gpu_push_state();
    try {
        GameCont.area=area_desert;GameCont.underwater=false;GameCont.crown=1;
        UberCont.opt_prtcls=true;
        for(var _xx=0;_xx<40;++_xx) for(var _yy=0;_yy<30;++_yy) {
            var _floor=instance_create(40000+32*_xx,40000+32*_yy,Floor);
            _floor.styleb=false;_floor.sprite_index=sprFloor1;
        }
        for(var _xx=0;_xx<16;++_xx) for(var _yy=0;_yy<12;++_yy)
            instance_create(40016+64*_xx,40016+64*_yy,Detail);
        _surface=surface_create(320,240);_camera=camera_create_view(40000,40000,320,240,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);_target=true;camera_apply(_camera);shader_reset();
        matrix_set(matrix_world,matrix_build_identity());gpu_set_blendmode(bm_normal);
        var _results=[];
        for(var _enabled=0;_enabled<2;++_enabled) {
            UberCont.opt_detailsplus=_enabled;random_set_seed(1210186);
            var _start=get_timer();scrDPApply();var _apply=get_timer()-_start;
            repeat(4) scrRelease121DecorDraw();
            var _draw=[];
            repeat(15) {
                _start=get_timer();repeat(12) scrRelease121DecorDraw();
                array_push(_draw,(get_timer()-_start)/12);
            }
            var _nuke=[],_scorch=[],_particles=[];
            repeat(15) {
                var _snapshot=scrNTTEFullInstances(all);
                _start=get_timer();
                var _rocket=instance_create(40160,40128,Nuke);instance_destroy(_rocket);
                array_push(_nuke,get_timer()-_start);
                assert(instance_number(Explosion)>=8,"Nuke lost its native eight explosions");
                array_push(_particles,[instance_number(Smoke),instance_number(Dust)]);
                scrNTTEFullMergedRuntimeTestCleanup(_snapshot);
            }
            repeat(15) {
                _start=get_timer();var _s=instance_create(40160,40128,Scorch);
                array_push(_scorch,get_timer()-_start);instance_destroy(_s,false);
            }
            array_push(_results,{detailsplus:_enabled,apply_us:_apply,details:instance_number(Detail),
                static_decor:instance_number(DPStaticDecor),batched_rows:scrDPBatchRowCount(),batches:instance_number(DPDecorBatch),draw:scrRelease121TimeSummary(_draw),
                nuke:scrRelease121TimeSummary(_nuke),scorch:scrRelease121TimeSummary(_scorch),particles:_particles[0]});
        }
        var _walls=[];
        for(var _xx=0;_xx<40;++_xx) for(var _yy=0;_yy<25;++_yy)
            array_push(_walls,instance_create(46000+16*_xx,40000+16*_yy,Wall));
        var _break=[];
        for(var _i=0;_i<12;++_i) {
            var _snapshot=scrNTTEFullInstances(all),_w=_walls[2+_i*25];
            _start=get_timer();scrWallDestroy(_w);array_push(_break,get_timer()-_start);
            scrNTTEFullMergedRuntimeTestCleanup(_snapshot);
        }
        scrNTTESmokeLog("WALLPERF121 "+json_stringify(scrRelease121TimeSummary(_break)));
        scrNTTESmokeLog("PERF121 "+json_stringify({rate:30/timescale,results:_results}));
        scrNTTESmokeLog("PASS Release121 actual native Nuke eight-explosion/decor render benchmark @"+string(30/timescale));
    } finally {
        if(_target) surface_reset_target();
        if(surface_exists(_surface)) surface_free(_surface);if(_camera>=0) camera_destroy(_camera);
        gpu_pop_state();matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        if(_shader>=0) shader_set(_shader);else shader_reset();draw_set_color(_state.color);draw_set_alpha(_state.alpha);
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber);random_set_seed(_seed);
    }
}
