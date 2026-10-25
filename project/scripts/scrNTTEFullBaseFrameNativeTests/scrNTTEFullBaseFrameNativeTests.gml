function scrNTTEFullBaseFrameNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _seed=random_get_seed()
    try {
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0
        var _crown=instance_create(98000,98000,CrownObject)
        _crown.image_xscale=0.75;_crown.hspeed=-timescale
        scrNTTEFullBaseFrameStep()
        assert(_crown.image_xscale==-0.75,"Moving native Crown failed source facing or lost authored scale")
        _crown.hspeed=0;scrNTTEFullBaseFrameStep()
        assert(_crown.image_xscale==-0.75,"Stationary native Crown lost its previous facing")
        _crown.hspeed=timescale;scrNTTEFullBaseFrameStep()
        assert(_crown.image_xscale==0.75,"Native Crown did not turn back with positive horizontal motion")

        var _raven=instance_create(98000,98000,Raven),_hunter=instance_create(98100,98000,LilHunter)
        with(_raven) instance_change(RavenFly,false)
        with(_hunter) instance_change(LilHunterFly,false)
        _raven.depth=-2;_raven.visible=false;_raven.sprite_index=sprRavenFly
        _hunter.depth=-2;_hunter.visible=false;_hunter.sprite_index=sprLilHunterLift
        scrNTTEFullBaseFrameEndStep()
        assert(_raven.depth==-9 && _raven.visible && _hunter.depth==-9 && _hunter.visible,
            "Native converted flying enemies failed source above-wall layer/visibility")
        _raven.sprite_index=sprRavenLand;_raven.image_index=0;_raven.image_speed=0.2*timescale
        _hunter.sprite_index=sprLilHunterLand;_hunter.z=-11*timescale
        scrNTTEFullBaseFrameEndStep()
        assert(_raven.depth==-9 && _hunter.depth==-9,"Flying enemies returned below walls before source landing threshold")
        _raven.image_index=_raven.image_number-_raven.image_speed
        _hunter.z=-10*timescale;scrNTTEFullBaseFrameEndStep()
        assert(_raven.depth==-2 && _hunter.depth==-2,"Landing frame did not restore native enemy layer")
        _raven.depth=-9;_raven.image_index=0;_raven.image_speed=-0.2*timescale
        scrNTTEFullBaseFrameEndStep()
        assert(_raven.depth==-2,"Source reverse-playback anim_end landing branch was omitted")
        _raven.depth=-10;_raven.visible=false;_raven.sprite_index=sprRavenFly
        _hunter.depth=-6;_hunter.visible=false;_hunter.sprite_index=sprLilHunterLift
        scrNTTEFullBaseFrameEndStep()
        assert(_raven.depth==-10 && !_raven.visible && _hunter.depth==-6 && !_hunter.visible,
            "Source flight visibility changed a body already outside its depth>-6 gate")

        var _pickup=scrWeaponPickupCreate(98000,98000,wep_revolver,false)
        _pickup.sprite_index=sprRevolver
        scrNTTEFullBaseFrameStep()
        assert(!instance_exists(scrNTTEFullValue(_pickup,"portal_inst",noone)),
            "Weapon loading debris appeared without a real loading controller")
        var _spiral=instance_create(view_width/2,view_height/2,SpiralCont)
        scrNTTEFullBaseFrameStep()
        assert(!instance_exists(scrNTTEFullValue(_pickup,"portal_inst",noone)),
            "Weapon loading debris appeared outside generation/level-up")
        var _gen=instance_create(0,0,GenCont),_rng=random_get_seed(),_debris_count=instance_number(SpiralDebris)
        scrNTTEFullBaseFrameStep()
        var _debris=_pickup.portal_inst
        assert(instance_exists(_debris) && instance_is(_debris,SpiralDebris)
            && instance_number(SpiralDebris)==_debris_count+instance_number(WepPickup)
            && random_get_seed()==_rng,"Actual loading weapon debris lost physical ownership or changed gameplay RNG")
        assert(_debris.sprite_index==sprRevolver && _debris.image_index==0
            && _debris.turnspeed>=-1 && _debris.turnspeed<=1
            && _debris.rotspeed>=-15 && _debris.rotspeed<=15 && _debris.dist>=80 && _debris.dist<=120,
            "Actual native debris lost source art/frame/turn/spin/radius")
        _debris.image_angle=80;_debris.grow=1;_pickup.sprite_index=sprCrossbow
        scrNTTEFullBaseFrameStep()
        assert(_pickup.portal_inst==_debris && _debris.sprite_index==sprCrossbow
            && abs(_debris.image_xscale-(0.7+0.1*sin(-0.2)))<=0.00001
            && _debris.image_yscale==_debris.image_xscale && _debris.grow==0
            && random_get_seed()==_rng,"Existing loading debris failed live sprite/radian pulse/hold or consumed extra RNG")
        instance_destroy(_debris,false);scrNTTEFullBaseFrameStep()
        assert(instance_exists(_pickup.portal_inst) && _pickup.portal_inst!=_debris && random_get_seed()==_rng,
            "Destroyed native weapon debris did not recreate once without gameplay RNG mutation")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_uber);random_set_seed(_seed)
    }
    scrNTTESmokeLog("BASE FRAME: actual Crown facing/zero speed/scale, converted native Raven+LilHunter above-wall visibility/landing/reverse frames/depth boundary, physical loading weapon debris/reuse/live sprite/radian pulse/recreation and exact RNG preservation OK @"+string(30/timescale))
}

// BEGIN NTTE PLAYER RATE BOOTSTRAP TESTS
function scrNTTEFullPlayerRateBootstrapTests() {
    var _rate=game_get_speed(gamespeed_fps),_ts=scrNTTEFullRateScale(_rate),_oldts=timescale,
        _oldmap=UberCont.saveData,_copy=ds_map_create(),_before=scrNTTEFullInstances(Player),_snap=[],_made=[],
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_buf=-1;
    assert(_rate==30 || _rate==60,"Rate bootstrap requires actual30/60");
    for(var _i=0;_i<array_length(_before);++_i) array_push(_snap,scrNTTEFullAreaGeneratorSnapshot(_before[_i]));
    ds_map_copy(_copy,_oldmap);UberCont.saveData=_copy;
    try {
        save_set_value("options","framerate",_rate);global.time_scale=1;scrOptionsUpdate();UberCont.opt_autopause=false;
        assert(game_get_speed(gamespeed_fps)==_rate && timescale==_ts,"Options left stale constructor timescale");
        var _p=scrPlayerCreate(0,Race.Plant,0);array_push(_made,_p);
        assert(abs(_p.maxspeed-4.5*_ts)<0.0001 && abs(_p.friction-0.45*_ts*_ts)<0.0001 && abs(_p.image_speed-0.4*_ts)<0.0001 && _p.ntte_player_physics_scale==_ts,"Player.Create baked stale physics");
        _p.ntte_rate_fixture_probe=true;
        _buf=buffer_create(4096,buffer_grow,1);scrSavegamePlayers(_buf,false);buffer_seek(_buf,buffer_seek_start,0);
        assert(buffer_read(_buf,buffer_u8)==SavegamePart.PlayerData,"Writer player part missing");
        var _rows=json_parse(buffer_read(_buf,buffer_string)),_written=undefined;
        buffer_delete(_buf);_buf=-1;
        for(var _i=0;_i<array_length(_rows);++_i) if(variable_struct_exists(_rows[_i],"ntte_rate_fixture_probe")) _written=_rows[_i];
        assert(is_struct(_written) && variable_struct_exists(_written,"maxspeed") && variable_struct_exists(_written,"ntte_player_physics_scale") && !variable_struct_exists(_written,"speed") && !variable_struct_exists(_written,"friction") && !variable_struct_exists(_written,"image_speed"),"Native writer physics schema differs");
        var _from=_ts==0.5?1:0.5;
        _p.footextra=2;_p.maxspeed=5.5*_from;_p.speed=3*_from;_p.direction=37;
        _p.friction=0.45*_from*_from;_p.image_speed=0.4*_from;_p.ntte_player_physics_scale=_from;scrNTTEFullRateApply();
        assert(abs(_p.maxspeed-5.5*_ts)<0.0001 && abs(_p.speed-3*_ts)<0.0001 && abs(_p.direction-37)<0.0001 && abs(_p.friction-0.45*_ts*_ts)<0.0001 && abs(_p.image_speed-0.4*_ts)<0.0001,"Existing Player physics did not rescale");
        var _speed=_p.speed;scrNTTEFullRateApply();assert(_p.speed==_speed,"Rate applied twice");instance_destroy(_p,false);
        var _cases=[_written];
        for(var _source=0;_source<2;++_source) for(var _modern=0;_modern<2;++_modern) {
            var _source_scale=_source==0?1:0.5,_row={object_index_name:"Player",race:Race.Plant,footextra:2,maxspeed:5.5*_source_scale};
            if(_modern) _row.ntte_player_physics_scale=_source_scale;
            array_push(_cases,_row);
        }
        for(var _case=0;_case<array_length(_cases);++_case) {
            var _expected_cap=(_case==0?4.5:5.5)*_ts;
            _buf=buffer_create(4096,buffer_grow,1);buffer_write(_buf,buffer_u8,SavegamePart.PlayerData);
            buffer_write(_buf,buffer_string,json_stringify([_cases[_case]]));buffer_seek(_buf,buffer_seek_start,0);
            var _prior=scrNTTEFullInstances(Player);scrSavegamePlayers(_buf,true);buffer_delete(_buf);_buf=-1;
            var _new=scrNTTEFullMergedRuntimeDifference(_prior,scrNTTEFullInstances(Player));
            for(var _j=0;_j<array_length(_new);++_j) array_push(_made,_new[_j]);
            assert(array_length(_new)==1,"Native continuation did not create one Player");
            var _loaded=_new[0];
            assert(_loaded.race==Race.Plant && abs(_loaded.maxspeed-_expected_cap)<0.0001 && _loaded.ntte_player_physics_scale==_ts && abs(_loaded.friction-0.45*_ts*_ts)<0.0001 && abs(_loaded.image_speed-0.4*_ts)<0.0001,"Native continuation retained source-rate physics");
            with(_loaded) scrNTTEFullPlayerRateSync();
            assert(abs(_loaded.maxspeed-_expected_cap)<0.0001,"Loaded Player double-converted physics");instance_destroy(_loaded,false);
        }
        assert(game_get_speed(gamespeed_fps)==_rate && timescale==_ts,"Bootstrap changed engine rate");
        scrNTTESmokeLog("PLAYER RATE BOOTSTRAP "+json_stringify({actual_rate:_rate,logic_scale:_ts,native_create:true,native_writer:true,native_continue_cases:array_length(_cases),device_tested:false}));
    } finally {
        if(buffer_exists(_buf)) buffer_delete(_buf);
        for(var _i=0;_i<array_length(_made);++_i) if(instance_exists(_made[_i])) instance_destroy(_made[_i],false);
        for(var _i=0;_i<array_length(_snap);++_i) scrNTTEFullAreaGeneratorRestore(_snap[_i]);
        scrNTTEFullAreaGeneratorRestore(_game);UberCont.saveData=_oldmap;ds_map_destroy(_copy);
        scrOptionsUpdate();scrNTTEFullAreaGeneratorRestore(_uber);game_set_speed(_rate,gamespeed_fps);
        global.time_scale=_oldts;random_set_seed(_seed);global.rng_state=_rng;
    }
}

function scrNTTEFullPlayerRateMotionTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Natural motion requires explicit desktop full smoke");
    var _o=instance_create(0,0,NTTEFullPlayerRateMotionTest);
    with(_o) {
        old_map=UberCont.saveData;fixture_map=ds_map_create();ds_map_copy(fixture_map,old_map);UberCont.saveData=fixture_map;
        old_rate=game_get_speed(gamespeed_fps);old_ts=timescale;restored=false;case_index=0;rows=[];target=noone;
        elapsed=0;sample_x=0;sample_clock=0;sample_us=0;visual_frames=0;wall_start=get_timer();started=false;
        var _keep=id;with(NTTESmokeTest) instance_deactivate_object(id);
        with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false);
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.is_level_ended=true;GameCont.rad=0;GameCont.underwater=false;
        global.is_server=true;global.index=0;
        UberCont.paused=false;UberCont.want_pause=false;UberCont.opt_autopause=false;UberCont.opt_freeze=0;
        UberCont.opt_bossintro=false;UberCont.block_input_frames=100000;save_set_value("options","autopause",false);
    }
}
function scrNTTEFullPlayerRateMotionRestore() {
    if(restored) return;restored=true;
    UberCont.saveData=old_map;if(ds_exists(fixture_map,ds_type_map)) ds_map_destroy(fixture_map);
    game_set_speed(old_rate,gamespeed_fps);global.time_scale=old_ts;
}
function scrNTTEFullPlayerRateMotionStartCase() {
    var _fps=(case_index%2)==0?30:60,_floor=case_index div 2;
    scrNTTESmokeLog("FULL INTERNAL BEGIN @"+string(_fps));
    save_set_value("options","framerate",_fps);scrOptionsUpdate();UberCont.opt_autopause=false;UberCont.block_input_frames=100000;
    with(Floor) instance_destroy(id,false);
    for(var _ix=0;_ix<40;++_ix) for(var _iy=-2;_iy<=2;++_iy) {
        var _f=instance_create(19936+32*_ix,20000+32*_iy,Floor);
        _f.sprite_index=_floor==0?sprFloor1B:(_floor==1?sprFloor4B:sprFloor5B);
    }
    target=scrPlayerCreate(0,Race.Fish,0);target.x=20016;target.y=20016;
    target.hp=10000;target.max_hp=10000;target.lsthealth=10000;target.nexthurt=current_frame+10000;
    target.can_walk=true;target.can_aim=false;target.can_spec=false;target.speed=0;
    elapsed=0;visual_frames=0;sample_x=0;started=true;
}
function scrNTTEFullPlayerRateMotionBegin() {
    if(!started) scrNTTEFullPlayerRateMotionStartCase();
    var _i=target.index;
    KeyCont.precisemovement[_i]=true;KeyCont.moving[_i]=1;KeyCont.dir_move[_i]=0;
    KeyCont.hold_east[_i]=true;KeyCont.hold_west[_i]=false;KeyCont.hold_sout[_i]=false;KeyCont.hold_nort[_i]=false;
    KeyCont.hold_fire[_i]=false;KeyCont.press_fire[_i]=false;KeyCont.release_fire[_i]=false;
    KeyCont.hold_spec[_i]=false;KeyCont.press_spec[_i]=false;KeyCont.press_swap[_i]=false;KeyCont.press_pick[_i]=false;
}
function scrNTTEFullPlayerRateMotionEndBody() {
    assert(get_timer()-wall_start<90000000,"Natural movement wall-clock timeout");if(!started) return;
    var _fps=(case_index%2)==0?30:60;
    assert(game_get_speed(gamespeed_fps)==_fps && timescale==30/_fps,"Natural movement rate drifted");
    elapsed+=timescale;if(elapsed<30) return;
    if(sample_x==0) {sample_x=target.x;sample_clock=current_frame;sample_us=get_timer();visual_frames=0;return;}
    visual_frames++;if(elapsed<90) return;
    var _row={floor:case_index div 2,actual_rate:_fps,logic_ticks:current_frame-sample_clock,distance:target.x-sample_x,
        visual_frames:visual_frames,wall_us:get_timer()-sample_us,maxspeed:target.maxspeed,friction:target.friction,observed_fps:fps_real};
    array_push(rows,_row);scrNTTESmokeLog("PLAYER NATURAL MOTION "+json_stringify(_row));
    scrNTTESmokeLog("FULL INTERNAL END @"+string(_fps)+" tests=1");
    instance_destroy(target,false);target=noone;started=false;if(++case_index<6) return;
    for(var _i=0;_i<array_length(rows);_i+=2) {
        var _a=rows[_i],_b=rows[_i+1];
        assert(abs(_a.logic_ticks-60)<0.001 && abs(_b.logic_ticks-60)<0.001,"Natural motion covered unequal logical time");
        assert(abs(_a.distance-_b.distance)<=0.5,"Natural30/60 distance differs on floor "+string(_a.floor)+": "+string(_a.distance)+" vs "+string(_b.distance));
    }
    scrNTTEFullPlayerRateMotionRestore();scrNTTESmokeLog("PASS PLAYER NATURAL MOTION actual30/60 dry/sticky/ice; mobile device not tested");
    scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage");game_end();
}
function scrNTTEFullPlayerRateMotionEnd() {
    try {scrNTTEFullPlayerRateMotionEndBody();} catch(_e) {scrNTTEFullPlayerRateMotionRestore();throw _e;}
}
// END NTTE PLAYER RATE BOOTSTRAP TESTS
