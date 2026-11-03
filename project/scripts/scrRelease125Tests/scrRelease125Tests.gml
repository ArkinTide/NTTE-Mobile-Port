function scrRelease125ClearTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        GameCont.area=area_desert;GameCont.subarea=1;
        var _van=instance_create(260000,260000,WantVan);
        assert(instance_exists(_van) && !_van.canspawn && !scr_check_enemies(),"Dormant van reservation still blocks clear");
        _van.canspawn=true;
        assert(scr_check_enemies(),"Armed reinforcement lost its completion guard");
        _van.canspawn=false;
        var _enemy=instance_create(260010,260010,Bandit),_steps=round(1800/timescale),_kills=GameCont.kills;
        with(GameCont) scrNTTELastEnemyTimeoutReset();
        repeat(_steps) with(GameCont) scrNTTELastEnemyTimeoutStep();
        assert(instance_exists(_enemy) && GameCont.ntte_last_enemy_time==1800,"Dormant van interrupted exact one-minute timer");
        with(GameCont) scrNTTELastEnemyTimeoutStep();
        assert(!instance_exists(_enemy) && GameCont.kills==_kills+1,"Sole real enemy did not use one native death");
        var _corpse=instance_find(Corpse,0);
        with(_corpse) event_perform(ev_alarm,0);
        assert(instance_exists(Portal) && instance_exists(_van),"Dormant reservation prevented native corpse exit or was destroyed");
        instance_destroy(Portal,false);
        var _boss=instance_create(260000,260000,NTTEFullCatBoss),_hp=_boss.hp;
        repeat(_steps+1) with(GameCont) scrNTTELastEnemyTimeoutStep();
        assert(instance_exists(_boss) && _boss.hp==_hp && !instance_exists(Portal),"Boss incorrectly expired");
        scrNTTESmokeLog("PASS R125 CLEAR dormant van, armed reinforcements, exact-minute single enemy native death/portal and Boss protection @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease125BatTests() {
    var _s=scrRelease122FixtureBegin(),_opt=UberCont.opt_prtcls;
    try {
        GameCont.area=area_sewers;
        for(var _mode=0;_mode<3;++_mode) {
            UberCont.opt_prtcls=(_mode!=1);GameCont.underwater=(_mode==2);
            var _bat=instance_create(261000,261000,NTTEFullBatBoss);
            _bat.ntte_full_timers=[-1,1000,-1,-1];_bat.ntte_full_cloud=[{y:0,y_add:1,delay:0,right:1}];
            var _dust=instance_number(Dust),_bubbles=instance_number(Bubble);
            with(_bat) event_perform(ev_step,ev_step_normal);
            assert(instance_exists(_bat) && array_length(_bat.ntte_full_cloud)==1,"Cloud visual interrupted Boss Step");
            assert(instance_number(Dust)==_dust+(_mode==0?3:0),"Live or suppressed Dust count changed");
            assert(instance_number(Bubble)==_bubbles+(_mode==2?3:0),"Water Dust replacement lost native bubbles");
            if(_mode==0) with(Dust) assert(image_blend==c_black && abs(depth-_bat.depth)==1,"Live cloud tint/depth lost owner scope");
            var _cloud=instance_create(261010,261010,NTTEFullBatCloud);_cloud.target=_bat;_cloud.creator=_bat;
            with(_cloud) event_perform(ev_step,ev_step_normal);
            // Both the restored-bat morph burst and cloud trail use optional Dust.
            _bat.ntte_full_active=false;
            with(_bat) scrNTTEFullBatBossMorph();
            assert(_bat.ntte_full_active && _bat.visible,"Boss morph did not complete with optional effects");
            scrNTTEFullCavesFixtureCleanup(_s.baseline);
        }
        scrNTTESmokeLog("PASS R125 BAT actual Boss Step/cloud trail/morph with live, disabled and underwater Dust constructors @"+string(30/timescale));
    } finally {UberCont.opt_prtcls=_opt;scrRelease122FixtureEnd(_s);}
}
function scrRelease125SoundTests() {
    var _s=scrRelease122FixtureBegin(),_frame=current_frame,_volume=UberCont.opt_sndvol;
    try {
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.subarea=1;GameCont.ntte_full_active_coast=true;
        scrNTTEFullCoastSeaEnsure();GameCont.ntte_coast_splash_frames={};
        var _a=instance_create(262000,262000,Bandit),_key=string(sndOasisChest),_rng=random_get_seed();
        with(_a) scrNTTEFullCoastSplashSound(sndOasisChest,0.2);
        assert(GameCont.ntte_coast_splash_frames[$ _key]==current_frame,"First splash was not registered");
        var _seed=random_get_seed();
        repeat(30) with(_a) scrNTTEFullCoastSplashSound(sndOasisChest,0.2);
        var _after=random_get_seed();random_set_seed(_seed);
        repeat(30) with(_a) snd_play_hit(sndOasisChest,0.2);
        assert(random_get_seed()==_after,"Splash coalescing changed pitch RNG sequence");
        current_frame+=3;
        with(_a) scrNTTEFullCoastSplashSound(sndOasisChest,0.2);
        assert(GameCont.ntte_coast_splash_frames[$ _key]==current_frame,"Next independent splash was suppressed");
        with(_a) scrNTTEFullCoastConstructExplosion();
        var _splat=instance_create(262000,262000,MeltSplat);
        assert(!instance_exists(_splat) && UberCont.opt_sndvol==_volume,"Water splash changed global volume or survived replacement");
        scrNTTESmokeLog("PASS R125 SOUND native splash burst coalescing, exact RNG, later playback and silent-handle explosion/splat safety @"+string(30/timescale));
    } finally {current_frame=_frame;scrRelease122FixtureEnd(_s);}
}
function scrRelease125SwimTests() {
    var _s=scrRelease122FixtureBegin(),_vx=view_xview,_vy=view_yview,_state=scrNTTEFullCoastDrawState(),
        _scaling=UberCont.opt_scaling,_target=false,_outputs=[],_camera=-1;
    gpu_push_state();
    try {
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.subarea=1;GameCont.ntte_full_active_coast=true;
        view_xview=263000;view_yview=263000;UberCont.opt_scaling=2;
        var _sea=scrNTTEFullCoastSeaEnsure();
        assert(shader_is_compiled(shNTTECoastSwimSplit),"Accelerated swimmer shader did not compile");
        var _actor=instance_create(view_xview+120,view_yview+100,NTTEFullTrafficCrab),_crab=_actor,_player=instance_find(Player,0);
        _actor.sprite_index=_actor.spr_idle;_actor.image_index=0;_actor.active=true;_actor.speed=0;
        GameCont.ntte_sea_inst=[_actor];
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1);
        var _minor=scrNTTEFullVisualQuality("minor"),_main=scrNTTEFullVisualQuality("main");
        with(_sea) for(var _i=4;_i<8;++_i) scrNTTEFullCoastSurfaceEnsure(ntte_coast_surfaces[_i],view_width,view_height,(_i==5 || _i==6)?_main:_minor);
        var _worst=0,_different=0;
        for(var _sink=0;_sink<6;++_sink) {
            _actor=_sink<3?_crab:_player;GameCont.ntte_sea_inst=[_actor];
            _actor.x=view_xview+120;_actor.y=view_yview+100;
            with(_actor) scrNTTEFullCoastWadingSetup();
            _actor.wading=20;_actor.wading_wave=0;_actor.wading_sink=(_sink mod 3)==0?0:((_sink mod 3)==1?4:18);
            for(var _fast=0;_fast<2;++_fast) {
                _sea.ntte_coast_fast_swim=(_fast==1);
                with(_sea) {
                    for(var _i=4;_i<8;++_i) {var _v=ntte_coast_surfaces[_i];_v.x=view_xview;_v.y=view_yview;scrNTTEFullCoastSurfaceTarget(_v);draw_clear_alpha(c_black,0);}
                    gpu_set_blendmode(bm_normal);draw_set_color(c_white);draw_set_alpha(1);shader_reset();
                    scrNTTEFullCoastSwimCapture(ntte_coast_surfaces[4],ntte_coast_surfaces[5],ntte_coast_surfaces[6],ntte_coast_surfaces[7]);
                    if(ntte_coast_target_active) {surface_reset_target();ntte_coast_target_active=false;}
                }
                var _out=surface_create(view_width*_main,view_height*_main);array_push(_outputs,_out);
                surface_set_target(_out);_target=true;camera_apply(_camera);draw_clear_alpha(make_color_rgb(42,145,205),1);
                with(_sea) {scrNTTEFullCoastSurfaceDraw(ntte_coast_surfaces[4]);scrNTTEFullCoastSurfaceDraw(ntte_coast_surfaces[5]);}
                surface_reset_target();_target=false;
                surface_save(_out,working_directory+"ntte-r125-swim-"+string(_sink)+"-"+string(_fast)+"-"+string(30/timescale)+".png");
            }
            var _a=_outputs[array_length(_outputs)-2],_b=_outputs[array_length(_outputs)-1];
            for(var _y=70*_main;_y<135*_main;++_y) for(var _x=90*_main;_x<150*_main;++_x) {
                var _pa=surface_getpixel(_a,_x,_y),_pb=surface_getpixel(_b,_x,_y),
                    _d=max(abs(color_get_red(_pa)-color_get_red(_pb)),abs(color_get_green(_pa)-color_get_green(_pb)),abs(color_get_blue(_pa)-color_get_blue(_pb)));
                if(_d>0) _different++;_worst=max(_worst,_d);
            }
        }
        scrNTTESmokeLog("R125 SWIM pixel delta max="+string(_worst)+" changed="+string(_different));
        assert(_worst<=4,"Accelerated swimmer compositor differs from retained original");
        // Submit identical crowded native Draws and fence the render result.
        // Timings describe this desktop backend, never an Android FPS claim.
        var _actors=[];
        for(var _i=0;_i<24;++_i) {
            var _a=instance_create(view_xview+40+(_i mod 8)*40,view_yview+40+(_i div 8)*40,NTTEFullTrafficCrab);
            _a.wading=20;_a.wading_wave=0;_a.wading_sink=0;array_push(_actors,_a);
        }
        GameCont.ntte_sea_inst=_actors;
        for(var _fast=0;_fast<2;++_fast) {
            _sea.ntte_coast_fast_swim=(_fast==1);var _start=get_timer();
            repeat(6) with(_sea) {
                for(var _i=4;_i<8;++_i) {var _v=ntte_coast_surfaces[_i];scrNTTEFullCoastSurfaceTarget(_v);draw_clear_alpha(c_black,0);}
                scrNTTEFullCoastSwimCapture(ntte_coast_surfaces[4],ntte_coast_surfaces[5],ntte_coast_surfaces[6],ntte_coast_surfaces[7]);
                surface_reset_target();ntte_coast_target_active=false;
                surface_getpixel(ntte_coast_surfaces[5].surf,120,100);
            }
            scrNTTESmokeLog("R125 SWIM LOAD "+json_stringify({rate:30/timescale,fast:_fast,swimmers:24,microseconds_per_draw:(get_timer()-_start)/6}));
        }
        scrNTTESmokeLog("PASS R125 SWIM original/accelerated actual crab+Player Draw, six sink states, pixel oracle and 24-swimmer fenced timing @"+string(30/timescale));
    } finally {
        if(_target) surface_reset_target();
        for(var _i=0;_i<array_length(_outputs);++_i) if(surface_exists(_outputs[_i])) surface_free(_outputs[_i]);
        if(_camera>=0) camera_destroy(_camera);gpu_pop_state();
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection);
        draw_set_color(_state.color);draw_set_alpha(_state.alpha);UberCont.opt_scaling=_scaling;view_xview=_vx;view_yview=_vy;
        scrRelease122FixtureEnd(_s);
    }
}
