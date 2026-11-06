function scrNTTEFullSystemProductionHooksTests() {
    assert(scrNTTESmokeEnabled(),"System production lifecycle tests require desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_tops=scrNTTEFullAreaGeneratorSnapshot(TopCont),
        _progress=global.ntte_full_progress,_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined,
        _seed=random_get_seed(),_rng=[],_p=instance_find(Player,0),_skills=ds_list_create(),
        _view=[view_xview,view_yview,view_width,view_height],_camera=-1,_dark=-1,_parked_new=[],_target=surface_get_target(),
        _top_count_start=instance_number(TopCont),
        _world=matrix_get(matrix_world),_matrixview=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current(),
        _hidden=scrNTTEFullInstances([GenCont,LevCont,Menu,Portal,FloorMaker,enemy,Revive,SitDown,GameOver,
            Floor,Wall,InvisiWall,NTTEFullOrchidSkill,ToxicGas,ToxicDelay,NTTEFullWorldEvent,NTTEFullTopObject])
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    global.ntte_full_progress=json_parse(json_stringify(_progress));global.ntte_full_feature_ready={}
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    GameCont.ntte_full_native_skill_counts={};GameCont.ntte_lastwish=0;GameCont.ntte_full_sleep_max=0
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=0;GameCont.crown=Crown.None
    GameCont.annihilation_list=[];GameCont.ntte_crime_enemy_count=0;GameCont.ntte_crime_enemy_delay=0
    _p.race=Race.Fish;_p.wep=wep_revolver;_p.bwep=wep_none;_p.visible=true;_p.hp=_p.max_hp;_p.speed=0
    _p.x=90000;_p.y=90000
    gpu_push_state()
    try {
        // Actual native Grunt child sets team after enemy.Create. Deferred
        // source setup sees that final faction and runs only once per ID.
        scrNTTEFullSkillSet("magnetic pulse",-1)
        var _grunt=instance_create(90100,90000,Grunt),_hp=_grunt.hp,_max=_grunt.max_hp,_hitseed=1
        while(true) {random_set_seed(_hitseed);if(random(2)>=1) break;_hitseed++;}
        random_set_seed(_hitseed)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_grunt.team==team_popo && _grunt.hp==2*_hp && _grunt.max_hp==2*_max && _grunt.ntte_system_setup_seen,
            "Actual BeginStep missed post-child Grunt faction/HP or source negative Magnetic Pulse")
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_grunt.hp==2*_hp && _grunt.max_hp==2*_max,"Newborn setup applied Magnetic Pulse twice")
        scrNTTEFullSkillSet("magnetic pulse",0)
        var _old=instance_create(90200,90000,Grunt),_oldhp=_old.hp
        with(GameCont) event_perform(ev_step,ev_step_begin)
        scrNTTEFullSkillSet("magnetic pulse",-1)
        random_set_seed(_hitseed)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_old.hp==_oldhp,"Acquiring Magnetic Pulse retroactively processed an old enemy")
        var _protected=instance_create(90300,90000,Grunt),_protectedhp=_protected.hp
        _protected.size=4
        random_set_seed(_hitseed)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_protected.hp==_protectedhp,"Magnetic Pulse ignored actual child size4 exclusion")
        scrNTTEFullSkillSet("magnetic pulse",1)
        var _victim=instance_create(90400,90000,Grunt)
        random_set_seed(_hitseed)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_victim.hp<=0,"Natural positive Magnetic Pulse never reached native child enemy")
        scrNTTEFullSkillSet("magnetic pulse",0)
        instance_destroy(_grunt,false);instance_destroy(_old,false);instance_destroy(_protected,false);instance_destroy(_victim,false)

        // Native and custom-child genuine Destroy events reach the source
        // pre-rad hook before child code can consume/clear raddrop.
        scrNTTEFullSkillSet("lead ribs",2)
        var _types=[Bandit,NTTEBat]
        for(var _t=0;_t<2;++_t) {
            var _rads=instance_number(Rad),_extra_before=0,_extra=0,_enemy=instance_create(90500+64*_t,90000,_types[_t])
            with(Rad) if(sprite_index==scrNTTERefSprite("RadUpg")) _extra_before++
            _enemy.hp=0;_enemy.raddrop=10;_enemy.corpse=false
            instance_destroy(_enemy)
            with(Rad) if(sprite_index==scrNTTERefSprite("RadUpg")) _extra++
            assert(instance_number(Rad)==_rads+14 && _extra-_extra_before==4,
                "Actual native/custom enemy death lost four upgraded bonus rads, base10 or once-only inherited dispatch")
        }
        scrNTTEFullSkillSet("lead ribs",-1)
        var _rads=instance_number(Rad),_enemy=instance_create(90700,90000,Bandit)
        _enemy.hp=0;_enemy.raddrop=10;_enemy.corpse=false
        instance_destroy(_enemy)
        assert(instance_number(Rad)==_rads+8,"Actual negative Lead Ribs death did not reduce native radiation before drop")
        scrNTTEFullSkillSet("lead ribs",0)

        // A newly arriving matching type is processed by the actual normal
        // GameCont event, rather than only at the initial Red hit.
        GameCont.annihilation_list=[{object_name:"Bandit",name:undefined,text:"bandits",ammo:3}]
        var _future=instance_create(91000,90000,Bandit),_other=instance_create(91100,90000,Bandit)
        _future.hp=1000;_future.max_hp=1000;_other.hp=1000;_other.max_hp=1000;_other.name="other"
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(_future.hp==800 && _future.annihilation_check && _other.hp==1000,
            "Actual normal Step lost future type-wide Annihilation or hit a distinct custom name")
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(_future.hp==800,"Repeating normal Step applied Annihilation twice to the same victim")
        GameCont.annihilation_list=[]
        instance_destroy(_future,false);instance_destroy(_other,false)

        var _tops_before=instance_number(NTTEFullTopObject)
        GameCont.ntte_crime_enemy_count=1;GameCont.ntte_crime_enemy_delay=timescale
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(GameCont.ntte_crime_enemy_count==1 && GameCont.ntte_crime_enemy_delay<=0,
            "Actual normal Step failed source Crime delay countdown")
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(GameCont.ntte_crime_enemy_count==0 && instance_number(NTTEFullTopObject)>=_tops_before+2,
            "Actual normal Step failed queued Crime two-enemy Top wave")
        // Park generated hunters before the isolated gas/darkness scenarios.
        var _hunters=scrNTTEFullInstances([enemy,NTTEFullTopObject])
        for(var _i=0;_i<array_length(_hunters);++_i) if(array_get_index(_before,_hunters[_i])<0) {
            array_push(_parked_new,_hunters[_i]);instance_deactivate_object(_hunters[_i])
        }

        // A genuine numeric take must schedule native Alarm0=1; its native
        // Alarm0 produces14clouds, then normal/end Step adapt gas ownership
        // and movement without touching hostile faction gas.
        scrNTTEFullSkillSet("toad breath",1)
        var _delay=instance_find(ToxicDelay,0),_gas_count=instance_number(ToxicGas)
        assert(instance_exists(_delay) && _delay.creator==_p && _delay.alarm[0]==1,
            "Actual Toad Breath grant did not force native ToxicDelay Alarm0 to one")
        with(_delay) event_perform(ev_alarm,0)
        assert(instance_number(ToxicGas)==_gas_count+14,"Actual Toad Breath delay failed recovered14-cloud Alarm0")
        var _hostile=instance_create(_p.x,_p.y,ToxicGas)
        _hostile.team=team_enemy
        with(GameCont) event_perform(ev_step,ev_step_normal)
        var _owned=0
        with(ToxicGas) if(creator==_p && team==_p.team) _owned++
        assert(_owned==14 && _hostile.team==team_enemy,"Actual Toad Breath normal Step lost neutral ownership or changed hostile gas")
        var _gas=instance_create(_p.x+4,_p.y,ToxicGas),_oldx=_gas.x
        _gas.speed=0;_p.direction=0;_p.speed=4*timescale
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_gas.x<_oldx && _gas.hspeed>0 && _gas.speed<=_p.speed,
            "Actual End Step failed source moving-player gas pull, blow or speed cap")
        scrNTTEFullSkillSet("toad breath",-1)
        _gas.x=_p.x+4;_gas.y=_p.y;_gas.speed=0;_oldx=_gas.x
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_gas.x<_oldx && _gas.speed==0,"Negative Toad Breath lost pull or original nonpositive speed cap")
        scrNTTEFullSkillSet("toad breath",0);_p.speed=0

        // Source portal latch is per existence interval, not per frame or ID.
        var _timer=instance_create(0,0,NTTEFullOrchidSkill)
        _timer.setup=false;_timer.skill=mut_lucky_shot;_timer.num=0;_timer.type="portal";_timer.time=2.25
        GameCont.annihilation_list=[{object_name:"Bandit",name:undefined,text:"bandits",ammo:2}]
        GameCont.ntte_portal_closed=false
        var _portal=instance_create(92000,92000,Portal)
        _portal.endgame=100
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_timer.time==2.25 && !GameCont.ntte_portal_closed,"Endgame portal incorrectly ticked source mutations")
        _portal.endgame=0
        var _portal_seed=random_get_seed()
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_timer.time==1.25 && _timer.flash==2 && _timer.star_scale==4/5
            && GameCont.annihilation_list[0].ammo==1 && random_get_seed()==_portal_seed,
            "Actual non-endgame portal appearance lost exact timer/Fx/registry tick or sound RNG restoration")
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_timer.time==1.25 && GameCont.annihilation_list[0].ammo==1,"Existing portal ticked source mutation twice")
        instance_destroy(_portal,false)
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(!GameCont.ntte_portal_closed,"Portal disappearance did not reset source latch")
        _portal=instance_create(92000,92000,Portal);_portal.endgame=0
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_timer.time==0.25 && array_length(GameCont.annihilation_list)==0,"Reopened portal did not tick/exhaust registry once")
        instance_destroy(_portal,false)
        with(GameCont) event_perform(ev_step,ev_step_end)
        _portal=instance_create(92000,92000,Portal);_portal.endgame=0
        with(GameCont) event_perform(ev_step,ev_step_end)
        assert(_timer.time==0,"Fractional portal duration became negative instead of subtracting min(time,1)")
        instance_destroy(_portal,false);instance_destroy(_timer,false)

        // Real child FloorMaker overrides the generator's200goal to10.
        // Setup observes10, reduces it once to4, and repairs only idle alarms.
        var _gen=instance_create(93000,93000,NTTEFullSystemGeneratorProbe)
        for(var _tile=0;_tile<5;++_tile) instance_create(93000+32*_tile,93000,Floor)
        GameCont.crown=NTTEFullCrown.Red
        var _maker=instance_create(93000,93000,NTTEFullSystemFloorMakerProbe)
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_maker.goal==4 && _gen.alarm[0]==3 && _gen.alarm[2]==2,
            "Actual deferred Red Crown setup lost post-child goal, source round40percent or generation alarm repair")
        with(GameCont) event_perform(ev_step,ev_step_begin)
        assert(_maker.goal==4,"Source Red Crown multiplied the same FloorMaker goal twice")
        instance_destroy(_maker,false);instance_destroy(_gen,false);GameCont.crown=Crown.None

        // Real scrDarkness draws into native view-relative surface with a
        // nonzero camera origin; source grayscale-clear and cardinal radius
        // must not be applied at raw world coordinates.
        // Actual GenCont.Create normally constructs TopCont. The smoke
        // bootstrap creates GameCont/BackCont/Player directly and our
        // isolated GenCont child intentionally skips generation Create.
        // Construct the real native controller here when that normal path
        // was never entered; cleanup already tracks all new instances.
        var _top=instance_find(TopCont,0),_top_count_dark=instance_number(TopCont)
        if(!instance_exists(_top)) _top=instance_create(0,0,TopCont)
        scrNTTESmokeLog("SYSTEM DARKNESS TopCont: fixture-start="+string(_top_count_start)
            +" before-draw="+string(_top_count_dark)+" actual-native="+string(_top)
            +" GenCont.Create normally owns construction")
        assert(instance_exists(_top),"Native TopCont missing for actual darkness draw")
        view_xview=10000;view_yview=10000;view_width=640;view_height=640
        _p.x=10320;_p.y=10320;_p.race=Race.Fish
        _dark=surface_create(640,640);_top.dark=_dark
        _camera=camera_create_view(0,0,640,640,0,noone,-1,-1,-1,-1)
        camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());shader_reset()
        gpu_set_blendmode(bm_normal);gpu_set_fog(false,0,0,0);draw_set_alpha(1)
        with(_top) scrDarkness()
        assert(surface_getpixel(_dark,420,320)!=c_black,"Disabled Bat Ears unexpectedly cleared extended black vision")
        scrNTTEFullSkillSet("bat ears",1)
        with(_top) scrDarkness()
        assert(surface_getpixel(_dark,420,320)==c_black && surface_getpixel(_dark,620,320)==c_gray,
            "Actual Bat Ears Draw lost view-relative130px vision or normal-phase gray clear")
        _p.race=Race.Eyes
        with(_top) scrDarkness()
        assert(surface_getpixel(_dark,520,320)==c_black && surface_getpixel(_dark,620,320)==c_gray,
            "Actual Eyes Bat Ears did not double source radius")
        _p.race=Race.Fish;scrNTTEFullSkillSet("bat ears",2)
        with(_top) scrDarkness()
        assert(surface_getpixel(_dark,520,320)==c_black,"Actual stacked Bat Ears ignored numeric radius multiplier")
        assert(array_length(variable_struct_get_names(global.ntte_full_feature_ready))==0,
            "Production lifecycle integration opened readiness flags")
        scrNTTESmokeLog("PASS actual native Begin/normal/End events: child-complete once-only EMP, native+custom pre-rad LeadRibs, future Annihilation, Crime wave, real ToxicDelay/gas, exact portal latch+fractional timers+RNG, child FloorMaker Red goal+alarms and native darkness pixels; no ready gates enabled")
    }
    finally {
        // Reactivate only fixture-created hunters. Preexisting inactive
        // instances were absent from _before and must remain untouched.
        for(var _i=0;_i<array_length(_parked_new);++_i) instance_activate_object(_parked_new[_i])
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_tops)
        ds_list_destroy(_skills);global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready
        global.rng_state=_rng;random_set_seed(_seed)
        view_xview=_view[0];view_yview=_view[1];view_width=_view[2];view_height=_view[3]
        for(var _i=0;_i<16 && real(surface_get_target())!=real(_target);++_i) surface_reset_target()
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_matrixview);matrix_set(matrix_projection,_projection)
        if(_shader>=0) shader_set(_shader);else shader_reset()
        draw_set_color(_color);draw_set_alpha(_alpha);gpu_pop_state()
        if(_camera>=0) camera_destroy(_camera)
        if(surface_exists(_dark)) surface_free(_dark)
    }
}
