// Only this explicit pause fixture waits for the engine's first actual Draw.
function scrNTTEFullParrotPauseWaitForNativeDraw() {
    var _selected=false;
    for(var _i=1;_i<=parameter_count();++_i)
        if(parameter_string(_i)=="--ntte-full-case=ParrotPauseLifecycleTests") _selected=true;
    if(!_selected) return false;
    var _wait=scrNTTEFullValue(id,"ntte_parrot_pause_draw_wait",undefined);
    if(!is_struct(_wait) || _wait.pass!=pass_index) {
        _wait={pass:pass_index,frames:0};ntte_parrot_pause_draw_wait=_wait;
        global.__debug_test_framerate_uncapped=false;
        with(UberCont) {
            if(test_framerate_uncapped && game_get_speed(gamespeed_fps)==game_speed_uncaped)
                display_reset(display_aa,opt_vsync);
            test_framerate_uncapped=false;
            opt_framerate=other.rates[other.pass_index];
        }
        game_set_speed(rates[pass_index],gamespeed_fps);
        draw_enable_drawevent(true);
        return true;
    }
    draw_enable_drawevent(true);
    ++_wait.frames;
    if(surface_exists(application_surface)) {
        scrNTTESmokeLog("PARROT NATIVE DRAW READY "+json_stringify({rate:rates[pass_index],wait_frames:_wait.frames,surface:application_surface,w:surface_get_width(application_surface),h:surface_get_height(application_surface)}));
        return false;
    }
    assert(_wait.frames<120,"Parrot native Draw did not create application_surface within 120 real frames");
    return true;
}
// parrot.race.gml: original charm state is separate from the object's native
// AI. Each charmed enemy keeps its real class, health, alarms and weapon.
function scrNTTEFullParrotCharmNew() {
    return {charmed:false,on_step:[],target:noone,team:team_player,time:-1,index:-1,kill:false,feather:false}
}
// parrot.race833..837: native copies keep an independent charm record and
// join the timer registry without swapping their already-inherited team.
function scrNTTEFullParrotCharmRegisterCopy(_inst) {
    if(!instance_exists(_inst) || !instance_exists(GameCont)) return false;
    var _own=scrNTTEFullValue(_inst,"ntte_charm",undefined)
    if(!is_struct(_own) || !_own.charmed) return false;
    if(!variable_instance_exists(GameCont,"ntte_charm_instance_list")) {
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
    }
    if(array_get_index(GameCont.ntte_charm_instance_list,_inst)>=0) return false;
    _own=struct_clone(_own)
    _inst.ntte_charm=_own;_inst.ntte_charmed=true
    array_push(GameCont.ntte_charm_instance_list,_inst);array_push(GameCont.ntte_charm_instance_vars,_own)
    return true
}
function scrNTTEFullParrotCharmInstanceSet() {
    var _set={}
    // Native enemy Draw/alarms may spawn instances. Membership must remain
    // exact even when destruction and creation leave the same total count.
    with(all) _set[$ string(id)]=true
    return _set
}
function scrNTTEFullParrotCharmNextMotion(_inst) {
    // telib.motion_step advances one source30Hz tick. Native motion stores
    // speed scaled by timescale and acceleration scaled by timescale squared.
    var _ts=max(0.000001,timescale),_speed=_inst.speed/_ts,_friction=_inst.friction/(_ts*_ts)
    if(_friction!=0 && _speed!=0) _speed-=min(abs(_speed),_friction)*sign(_speed)
    var _hx=lengthdir_x(_speed,_inst.direction),_hy=lengthdir_y(_speed,_inst.direction),
        _gravity=_inst.gravity/(_ts*_ts)
    if(_gravity!=0) {
        _hx+=lengthdir_x(_gravity,_inst.gravity_direction)
        _hy+=lengthdir_y(_gravity,_inst.gravity_direction)
    }
    return {x:_inst.x+_hx,y:_inst.y+_hy,moving:_hx!=0 || _hy!=0}
}
function scrNTTEFullParrotCharmNearbyProjectiles(_actor,_old_team) {
    // parrot.race1668..1705: a shot still inside its creator must change
    // teams with it. Distant shots and another creator's shots keep theirs.
    var _x=_actor.x,_y=_actor.y,_next=scrNTTEFullParrotCharmNextMotion(_actor)
    try {
        for(var _pass=0;_pass<2;++_pass) {
            if(_pass==1) {
                _actor.x=_next.x;_actor.y=_next.y
                if(!_next.moving) continue
            }
            var _margin=_pass==0?0:32,
                _shots=scrNTTEFullRectInstances(_actor.bbox_left-_margin,_actor.bbox_top-_margin,
                    _actor.bbox_right-1+_margin,_actor.bbox_bottom-1+_margin,projectile)
            for(var _i=0;_i<array_length(_shots);++_i) {
                var _shot=_shots[_i]
                if(_shot.team!=_old_team || _shot.creator!=_actor) continue
                var _sx=_shot.x,_sy=_shot.y
                if(_pass==1) {
                    var _motion=scrNTTEFullParrotCharmNextMotion(_shot)
                    if(!_motion.moving) continue
                    _sx=_motion.x;_sy=_motion.y
                }
                var _meeting=false
                with(_shot) _meeting=place_meeting(_sx,_sy,_actor)
                if(_meeting) {
                    _shot.team=_actor.team
                    scrNTTEFullPetTwinsTeam(_shot,_actor.team)
                }
            }
        }
    }
    finally {if(instance_exists(_actor)) {_actor.x=_x;_actor.y=_y}}
}
function scrNTTEFullParrotCharm(_inst,_charm) {
    if(!instance_exists(_inst)) return undefined
    with(_inst) {
        if(!is_struct(scrNTTEFullValue(id,"ntte_charm",undefined))) ntte_charm=scrNTTEFullParrotCharmNew()
        var _vars=ntte_charm
        if(_vars.charmed!=_charm) {
            if(_charm) {
                var _defaults=scrNTTEFullParrotCharmNew(),_keys=variable_struct_get_names(_defaults)
                for(var _i=0;_i<array_length(_keys);++_i) variable_struct_set(_vars,_keys[_i],variable_struct_get(_defaults,_keys[_i]))
            }
            if(variable_instance_exists(id,"team")) { var _oldteam=team; team=_vars.team; _vars.team=_oldteam }
            if(_charm) {
                if(!variable_instance_exists(GameCont,"ntte_charm_instance_list")) { GameCont.ntte_charm_instance_list=[]; GameCont.ntte_charm_instance_vars=[] }
                if(array_get_index(GameCont.ntte_charm_instance_list,id)<0) {
                    array_push(GameCont.ntte_charm_instance_list,id); array_push(GameCont.ntte_charm_instance_vars,_vars)
                }
                // Original delays ordinary native alarms by one tick when
                // entering charm, then executes them with the redirected AI.
                for(var _i=0;_i<=10;++_i) if(alarm[_i]>0) alarm[_i]+=1
            } else if(instance_is(id,hitme)) {
                if(instance_is(id,enemy)) {
                    target=noone
                    if(canmelee) { alarm[11]=30; canmelee=false }
                }
                if(_vars.kill) { hp=0; snd_play(sndEnemyDie,2+orandom(0.3),3) }
                else {
                    var _fx=instance_create(x,bbox_top-abs(scrNTTEFullValue(id,"z",0)),NTTEFullAssassinNotice)
                    _fx.depth=min(-7,depth-1); snd_play(sndAssassinGetUp,random_range(1.2,1.5),1.2)
                }
                var _num=scrNTTEFullValue(id,"size",1)==0 ? 5:10
                for(var _ang=direction;_ang<direction+360;_ang+=360/_num) {
                    var _fx=instance_create(x,y-abs(scrNTTEFullValue(id,"z",0)),Dust)
                    /* NTTE DUST LIFETIME parrot-uncharm */ if(instance_exists(_fx)) {_fx.direction=_ang; _fx.speed=4*timescale; _fx.depth=depth+1 }
                }
            }
            if(instance_is(id,hitme)) scrNTTEFullParrotCharmNearbyProjectiles(id,_vars.team)
            _vars.charmed=_charm
            // Existing native team-aware targeting, portal count and aim
            // filters use this flag; lifetime is governed by _vars.time.
            ntte_charmed=_charm
            if(instance_is(id,enemy)) target=noone
        }
        return _vars
    }
}
function scrNTTEFullParrotCharmTarget(_inst) {
    if(!instance_exists(_inst)) return noone
    var _vars=scrNTTEFullValue(_inst,"ntte_charm",undefined)
    if(!is_struct(_vars) || !_vars.charmed) return noone
    var _target=_vars.target,_owner=scrNTTEFullParrotCharmPlayer(_vars.index),_ownerteam=scrNTTEFullValue(_owner,"team",team_none),_team=scrNTTEFullValue(_inst,"team",team_player)
    if(!instance_exists(_target) || !instance_is(_target,hitme) || _target.team==team_none || _target.team==_team
        || _target.team==_ownerteam || _target.mask_index==mskNone || collision_line(_inst.x,_inst.y,_target.x,_target.y,Wall,false,false)) {
        _target=noone
        var _best=infinity,_candidates=scrNTTEFullInstances(hitme)
        for(var _i=0;_i<array_length(_candidates);++_i) {
            var _candidate=_candidates[_i]
            // Source chooses [enemy,Player,Sapling,Ally,SentryGun,CustomHitme],
            // never a native destructible prop/chest in the hitme parent.
            if(!instance_is(_candidate,enemy) && !instance_is(_candidate,Player) && !instance_is(_candidate,Sapling)
                && !instance_is(_candidate,Ally) && !instance_is(_candidate,NTTEFullPet) && !instance_is(_candidate,SentryGun)) continue
            if(_candidate==_inst || _candidate.team==team_none || _candidate.team==_team || _candidate.team==_ownerteam || _candidate.mask_index==mskNone) continue
            var _dis=point_distance(_inst.x,_inst.y,_candidate.x,_candidate.y)
            if(_dis<_best) { _best=_dis; _target=_candidate }
        }
        _vars.target=_target
    }
    return _target
}
function scrNTTEFullParrotCharmTimers() {
    if(lockstep_stop || scrGameIsPaused() || instance_exists(PauseImage) || !instance_exists(GameCont)) return;
    if(!variable_instance_exists(GameCont,"ntte_charm_instance_list")) return;
    var _list=GameCont.ntte_charm_instance_list,_vars=GameCont.ntte_charm_instance_vars
    for(var _i=array_length(_list)-1;_i>=0;--_i) {
        var _inst=_list[_i],_charm=_vars[_i]
        if(!instance_exists(_inst) || !_charm.charmed) {
            _charm.charmed=false; array_delete(_list,_i,1); array_delete(_vars,_i,1); continue
        }
        if(instance_is(_inst,hitme)) {
            var _level_over=false
            if(_charm.kill && instance_is(_inst,enemy)) {
                _level_over=true
                with(enemy) if(team!=_inst.team && !instance_is(id,Van)) _level_over=false
            }
            if(_level_over) scrNTTEFullParrotCharm(_inst,false)
            else if(_charm.time>=0) {
                _charm.time=max(0,_charm.time-timescale)
                if(_charm.time<=0) scrNTTEFullParrotCharm(_inst,false)
            }
        }
    }
    GameCont.ntte_charm_instance_list=_list; GameCont.ntte_charm_instance_vars=_vars
    scrNTTEFullCharmOutlineSync()
}
function scrNTTEFullParrotCopyLifecycleTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_p=instance_find(Player,0)
    try {
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
        for(var _kind=0;_kind<3;++_kind) {
            var _types=[Bandit,NTTEFullTopRaven,NTTEFullBloomingAssassinHide],_type=_types[_kind],
                _source=instance_create(_p.x+64,_p.y,_type),_team=_source.team,_next=noone,
                _vars=scrNTTEFullParrotCharm(_source,true)
            _vars.index=_p.index;_vars.time=30
            if(_kind==0) {
                with(_source) _next=scrNTTEFullMergedNativeCopy(false)
            } else if(_kind==1) {
                var _prior=scrNTTEFullInstances(Raven)
                instance_destroy(_source)
                with(Raven) if(array_get_index(_prior,id)<0) _next=id
            } else {
                _source.ntte_bloom_hide_become=0
                var _prior=scrNTTEFullInstances(NTTEFullBloomingAssassin)
                with(_source) event_perform(ev_step,ev_step_normal)
                with(NTTEFullBloomingAssassin) if(array_get_index(_prior,id)<0) _next=id
            }
            assert(instance_exists(_next) && _next.team==team_player && _next.ntte_charmed
                && _next.ntte_charm.charmed && _next.ntte_charm!=_vars && _next.ntte_charm.time==30
                && _next.ntte_charm.team==_team && array_get_index(GameCont.ntte_charm_instance_list,_next)>=0,
                "Actual native copy/transformation lost independent registered charm or inherited team/lifetime: "+string(_kind))
            if(instance_exists(_source)) instance_destroy(_source,false)
            scrNTTEFullParrotCharmTimers()
            assert(_next.ntte_charm.charmed && _next.ntte_charm.time==30-timescale,
                "Original source removal cancelled successor's independent charm")
            repeat(ceil(30/timescale)) scrNTTEFullParrotCharmTimers()
            assert(!_next.ntte_charm.charmed && !_next.ntte_charmed && _next.team==_team,
                "Actual native copy/transformation stayed permanently friendly after original lifetime")
            instance_destroy(_next,false)
        }
        scrNTTESmokeLog("PARROT COPY LIFECYCLE: real native copy/TopRaven destroy replacement/Blooming Step replacement independent registry, source removal and original-team expiry OK @"+string(30/timescale))
    } finally {scrNTTEFullVanillaFixtureEnd(_fixture)}
}
function scrNTTEFullParrotPauseLifecycleTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _p=instance_find(Player,0),_stop=lockstep_stop,_rate=game_get_speed(gamespeed_fps),_mobile=is_mobile,
        _pi=scr_playerinstance_find(_p.index),_prefs=_pi.cprefs,
        _bit=1<<(array_get_index(UberCont.cpref_list,"parrot")+1),_oldfeathers=scrNTTEFullInstances(NTTEFullParrotFeather)
    for(var _i=0;_i<array_length(_oldfeathers);++_i) instance_deactivate_object(_oldfeathers[_i])
    lockstep_stop=false
    try {
        assert(!scrGameIsPaused() && !instance_exists(PauseImage) && !instance_exists(GameOver),"Parrot pause fixture requires active gameplay")
        _p.race=NTTEFullRace.Parrot;_p.feather_num=12;_p.feather_ammo=0;_p.feather_ammo_max=36
        _p.feather_ammo_get=0;_p.ntte_race_ultra=0;_p.can_spec=true;_p.visible=true;_pi.cprefs|=_bit;is_mobile=true
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
        for(var _pass=0;_pass<2;++_pass) {
            var _target=instance_create(_p.x+64,_p.y,Bandit),_team=_target.team,_feathers=[]
            KeyCont.activeforever[_p.index]=true;KeyCont.hold_spec[_p.index]=true;KeyCont.press_spec[_p.index]=false
            repeat(2) {
                var _f=scrNTTEFullParrotFeatherNew(_target.x,_target.y,_p,_target,_p.index)
                with(_f) event_perform(ev_step,ev_step_normal)
                array_push(_feathers,_f)
            }
            var _vars=_target.ntte_charm,_time=_vars.time
            assert(_vars.charmed && _target.team==team_player && _time==59,"Pause fixture did not apply two real feathers")
            scrGamePause()
            with(PauseImage) event_perform(ev_draw,0)
            with(UberCont) event_perform(ev_step,ev_step_begin)
            with(UberCont) event_perform(ev_step,ev_step_begin)
            assert(scrGameIsPaused() && !instance_exists(_target) && instance_exists(GameCont),"Native pause did not deactivate real enemy")
            repeat(8) {
                with(UberCont) event_perform(ev_step,ev_step_begin)
                scrNTTEFullParrotCharmTimers()
                assert(_vars.charmed && _vars.time==_time && array_get_index(GameCont.ntte_charm_instance_list,_target)>=0,
                    "Paused native BeginStep/Timers pruned or consumed deactivated charm")
            }
            scrGameUnpause()
            for(var _i=0;_i<array_length(_fixture.hidden);++_i) instance_deactivate_object(_fixture.hidden[_i])
            for(var _i=0;_i<array_length(_oldfeathers);++_i) instance_deactivate_object(_oldfeathers[_i])
            assert(instance_exists(_target) && _target.team==team_player && _target.ntte_charm==_vars
                && _target.ntte_charmed && _vars.charmed && _vars.time==_time,"Unpause lost exact charm identity/lifetime/team")
            if(_pass==0) {
                var _ticks=0
                while(_vars.charmed && _ticks<ceil(_time/timescale)+2) {scrNTTEFullParrotCharmBeginStep();++_ticks}
                assert(!_vars.charmed && !_target.ntte_charmed && _target.team==_team && _ticks==ceil(_time/timescale),
                    "Post-pause ordinary logical expiry did not restore original team")
            } else {
                var _button=instance_create(180,100,ButtonActive)
                _button.volume_control_command=1;with(_button) event_perform(ev_other,ev_user0)
                assert(!KeyCont.activeforever[_p.index] && !KeyCont.hold_spec[_p.index],"Post-pause actual ability toggle failed")
                with(_p) scrNTTEFullParrotPlayerStep()
                for(var _i=0;_i<2;++_i) assert(!_feathers[_i].stick && _feathers[_i].target==_p,"Post-pause recall failed to detach feather")
                assert(_vars.time==0,"Post-pause final-feather recall retained lifetime")
                scrNTTEFullParrotCharmBeginStep()
                assert(!_vars.charmed && !_target.ntte_charmed && _target.team==_team,"Post-pause recall failed original-team restoration")
                instance_destroy(_button,false)
            }
            assert(!_target.canmelee && _target.alarm[11]==30,"Post-pause uncharm lost native contact grace")
            for(var _i=0;_i<2;++_i) if(instance_exists(_feathers[_i])) instance_destroy(_feathers[_i],false)
            instance_destroy(_target,false)
            scrNTTEFullAreaGeneratorRestore(_uber)
        }
        assert(game_get_speed(gamespeed_fps)==_rate,"Parrot pause lifecycle changed configured frame rate")
        scrNTTESmokeLog("PARROT REAL PAUSE: real feathers/native pause+deactivation/eight paused BeginSteps/native unpause/exact expiry/touch recall/original team+grace OK @"+string(_rate))
    } finally {
        if(scrGameIsPaused()) scrGameUnpause()
        _pi.cprefs=_prefs;is_mobile=_mobile
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
        for(var _i=0;_i<array_length(_oldfeathers);++_i) instance_activate_object(_oldfeathers[_i])
        scrNTTEFullVanillaFixtureEnd(_fixture);lockstep_stop=_stop
    }
}
function scrNTTEFullParrotFeatherTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all)
    var _old={ammo:scrNTTEFullValue(_p,"feather_ammo",0),max:scrNTTEFullValue(_p,"feather_ammo_max",36),ultra:scrNTTEFullValue(_p,"ntte_race_ultra",0),race:_p.race}
    _p.feather_ammo=0; _p.feather_ammo_max=36; _p.ntte_race_ultra=0; _p.race=NTTEFullRace.Parrot
    var _target=instance_create(_p.x+64,_p.y,Bandit); _target.team=team_enemy
    var _one=scrNTTEFullParrotFeatherNew(_target.x,_target.y,_p,_target,_p.index)
    var _two=scrNTTEFullParrotFeatherNew(_target.x,_target.y,_p,_target,_p.index)
    with(_one) scrNTTEFullParrotFeatherStep()
    with(_two) scrNTTEFullParrotFeatherStep()
    // Source charm_vars.time starts at -1. The original max(0,time+30)
    // therefore yields 29 on the first feather, then 59 after the second.
    assert(_one.stick && _two.stick && _target.team==team_player && _target.ntte_charm.time==59 && _target.ntte_charm.index==_p.index,
        "Parrot actual feathers failed source first/stacked charge: sticks="+string(_one.stick)+"/"+string(_two.stick)+", team="+string(_target.team)+", time="+string(_target.ntte_charm.time))
    var _time=_one.stick_time+_two.stick_time
    with(_one) scrNTTEFullParrotFeatherStep()
    with(_two) scrNTTEFullParrotFeatherStep()
    assert(abs(_one.stick_time+_two.stick_time-(_time-timescale))<0.001,"Parrot feather group deteriorated multiple feathers per tick")
    var _enemy=instance_create(_target.x+24,_target.y,Bandit); _enemy.team=team_enemy
    var _friendly=instance_create(_target.x+2,_target.y,Bandit); _friendly.team=team_player
    assert(scrNTTEFullParrotCharmTarget(_target)==_enemy,"Parrot source charm target selected a nearer friendly unit")
    _target.ntte_charm.time=timescale
    scrNTTEFullParrotCharmTimers()
    assert(_target.team==team_enemy && !_target.ntte_charm.charmed && !_target.ntte_charmed && !_target.canmelee && _target.alarm[11]==30,
        "Parrot timed uncharm failed to restore original team and contact-damage grace")
    instance_destroy(_one,false)
    assert(instance_exists(_two) && array_get_index(_two.stick_list,_one)<0 && array_get_index(_two.stick_list,_two)>=0,
        "Parrot deleting one stuck feather invalidated its shared group or retained the removed member")
    var _remaining_time=_two.stick_time
    with(_two) scrNTTEFullParrotFeatherStep()
    assert(abs(_two.stick_time-(_remaining_time-timescale))<0.001,"Parrot shared group did not transfer deterioration to the surviving feather")
    var _returning=scrNTTEFullParrotFeatherNew(_p.x,_p.y,_p,_p,_p.index)
    with(_returning) scrNTTEFullParrotFeatherStep()
    assert(!instance_exists(_returning) && _p.feather_ammo==1,"Parrot returning feather did not become ammunition")
    _p.ntte_race_ultra=1
    var _ultra=scrNTTEFullParrotFeatherNew(_p.x,_p.y,_p,_target,_p.index)
    assert(_ultra.stick_time_max==45,"Parrot Birds of a Feather lost its original 1.5x lifetime")
    _p.feather_ammo=_old.ammo; _p.feather_ammo_max=_old.max; _p.ntte_race_ultra=_old.ultra; _p.race=_old.race
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("SYSTEMS PARROT FEATHERS: actual feather sticking/stacked charges, one-feather group deterioration, friendly exclusion, timed original-team/contact-grace restoration, ammo retrieval and Ultra A lifetime OK")
    scrNTTEFullParrotRecallFollowupTests()
}
function scrNTTEFullParrotRecallFollowupTests() {
    var _p=instance_find(Player,0),_before=scrNTTEFullInstances(all),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_hidden=scrNTTEFullInstances([enemy,NTTEFullParrotFeather]),
        _pi=scr_playerinstance_find(_p.index),_prefs=_pi.cprefs,_mobile=is_mobile,
        _rate=game_get_speed(gamespeed_fps),_bit=1<<(array_get_index(UberCont.cpref_list,"parrot")+1)
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        _p.race=NTTEFullRace.Parrot;_p.feather_num=12;_p.feather_ammo=0;_p.feather_ammo_max=36
        _p.feather_ammo_get=0;_p.ntte_race_ultra=0;_p.can_spec=true;_p.visible=true
        _pi.cprefs|=_bit;is_mobile=true
        assert(scrNTTEFullPlayerActive(_p),"Parrot recall fixture requires the actual active Player")
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
        var _target=instance_create(_p.x+64,_p.y,Bandit),_button=instance_create(180,100,ButtonActive)
        assert(instance_number(enemy)==1,"Parrot recall regression must contain exactly one remaining enemy")
        for(var _pass=0;_pass<2;++_pass) {
            KeyCont.activeforever[_p.index]=true;KeyCont.hold_spec[_p.index]=true;KeyCont.press_spec[_p.index]=false
            var _feathers=[]
            for(var _i=0;_i<12;++_i) {
                var _feather=scrNTTEFullParrotFeatherNew(_target.x,_target.y,_p,_target,_p.index)
                with(_feather) event_perform(ev_step,ev_step_normal)
                array_push(_feathers,_feather)
            }
            assert(_target.ntte_charm.charmed && _target.team==team_player && array_length(_feathers)==12,
                "Single-enemy recall fixture did not attach all twelve original feathers")
            var _total=0
            for(var _i=0;_i<12;++_i) {_total+=_feathers[_i].stick_time;with(_feathers[_i]) event_perform(ev_step,ev_step_normal)}
            var _remaining=0
            for(var _i=0;_i<12;++_i) _remaining+=_feathers[_i].stick_time
            assert(abs(_total-_remaining-timescale)<0.001 && game_get_speed(gamespeed_fps)==_rate,
                "More than six attached feathers consumed multiple lifetimes or changed the configured frame rate")
            // A continued/legacy charm may retain a fractional residual.
            // The last-feather invariant must also resolve that isolated case.
            if(_pass==1) _target.ntte_charm.time+=2*timescale
            _button.volume_control_command=1;with(_button) event_perform(ev_other,ev_user0)
            assert(!KeyCont.activeforever[_p.index] && !KeyCont.hold_spec[_p.index],
                "Actual mobile ability press failed to switch off Parrot charm")
            with(_p) scrNTTEFullParrotPlayerStep()
            for(var _i=0;_i<12;++_i)
                assert(!_feathers[_i].stick && _feathers[_i].target==_p,"Last enemy retained a feather after actual touch recall")
            assert(_target.ntte_charm.time==0,"Last-feather recall left a residual charm lifetime")
            scrNTTEFullParrotCharmBeginStep()
            assert(!_target.ntte_charm.charmed && !_target.ntte_charmed && _target.team==team_enemy,
                "Single remaining enemy did not regain its original team on the ordinary Begin Step")
            for(var _i=0;_i<12;++_i) {
                _feathers[_i].x=_p.x;_feathers[_i].y=_p.y;_feathers[_i].stick_wait=0
                with(_feathers[_i]) event_perform(ev_step,ev_step_normal)
                assert(!instance_exists(_feathers[_i]),"Recalled feather failed its actual owner pickup")
            }
            assert(_p.feather_ammo==12*(_pass+1),"Single-enemy recall lost or duplicated feather ammunition")
        }
        scrNTTESmokeLog("PARROT RECALL: one real remaining enemy,12 attached feathers,one lifetime tick,actual touch toggle off,legacy fractional residual,ordinary BeginStep uncharm and exact physical refunds OK")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_all);++_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        _pi.cprefs=_prefs;is_mobile=_mobile
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_keys)
    }
}
