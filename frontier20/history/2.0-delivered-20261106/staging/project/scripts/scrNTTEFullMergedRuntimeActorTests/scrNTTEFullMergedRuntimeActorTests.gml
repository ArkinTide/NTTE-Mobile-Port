function scrNTTEFullMergedRuntimeActorTestFrames(_frames,_actor) {
    assert(array_length(_frames)>0,"Actual merged ActorFire retained no source frames")
    for(var _i=0;_i<array_length(_frames);++_i) {
        var _frame=_frames[_i]
        assert(_frame.actor==_actor && _frame.owner==_actor
            && _frame.main_vars.actor==_actor && _frame.main_vars.owner==_actor,
            "Merged actor frame retained a deleted temporary Player actor/owner")
    }
}
function scrNTTEFullMergedRuntimeActorTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_tick=current_frame,
        _player_count=instance_number(Player),_request=variable_global_exists("ntte_full_merged_request")?global.ntte_full_merged_request:undefined
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models),_player=instance_find(Player,0),
        _player_ammo=json_stringify(_player.ammo)
    try {
        UberCont.opt_shake=1;UberCont.opt_freeze=1;GameCont.temerge_effect_vars_map={};GameCont.rad=100
        var _types=[Bandit,Ally]
        for(var _kind=0;_kind<array_length(_types);++_kind) {
            var _actor=instance_create(53000+_kind*1000,53000,_types[_kind])
            _actor.team=_kind==0?team_enemy:team_player;_actor.visible=true;_actor.gunangle=35
            _actor.speed=0;_actor.xprevious=_actor.x;_actor.yprevious=_actor.y
            _actor.ntte_red_ammo=5;_actor.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_actor.infammo=0
            _actor.hitid=[sprMutant1Idle,"MERGED REAL ACTOR"]
            var _local_before=scrNTTEFullInstances(all),_weapon=scrNTTEFullWeaponMerge(wep_shotgun,wep_revolver),
                _handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.bwep=wep_none;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
            var _result=scrNTTEFullActorFire(_actor,_handle,35,0,false,_actor),
                _bullets=scrNTTEFullMergedRuntimeTestShots(_result.shots,Bullet1)
            assert(instance_number(Player)==_player_count && array_length(_bullets)==5
                && _actor.wep==_handle && _actor.ntte_state==scrNTTEFullWeaponNativeState(_weapon)
                && _actor.ammo[Ammo.Bullets]==100 && GameCont.rad==100,
                "Actual enemy/Ally merged ActorFire lost five replacements, physical state, source ammo isolation or synchronous Player cleanup")
            scrNTTEFullMergedRuntimeActorTestFrames(_result.merged_frames,_actor)
            for(var _i=0;_i<array_length(_bullets);++_i)
                assert(_bullets[_i].creator==_actor && _bullets[_i].team==_actor.team
                    && _bullets[_i].hitid[1]=="MERGED REAL ACTOR" && array_length(_bullets[_i].temerge_vars_list)==1,
                    "Actual enemy/Ally merged bullet lost real creator/team/hitid or source effect ancestry")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            // Non-Player source player_fire_ext never spends player radiation
            // on fronts whose native stock-table cost includes rads.
            _weapon=scrNTTEFullWeaponMerge(wep_revolver,wep_ultra_shovel);_handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
            var _rad=GameCont.rad
            _result=scrNTTEFullActorFire(_actor,_handle,35,0,false,_actor)
            assert(GameCont.rad==_rad && instance_number(Player)==_player_count,
                "Actual non-Player merged native radiation-cost front charged a temporary Player owner's global rads")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            // Genuine delayed stock Burst retains a stable actual creator and
            // shares accounting while each later leaf uses a new native proxy.
            _weapon=scrNTTEFullWeaponMerge(wep_assault_rifle,wep_revolver);_handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
            _result=scrNTTEFullActorFire(_actor,_handle,35,0,false,_actor)
            var _bursts=scrNTTEFullMergedRuntimeTestShots(_result.shots,Burst)
            assert(array_length(_bursts)==1 && _bursts[0].creator==_actor
                && _bursts[0].ntte_merged_runtime_at.creator==_actor
                && _bursts[0].ntte_merged_runtime_at.mount.owner==_actor,
                "Non-Player deferred stock retained its discarded native proxy in real mount/creator")
            var _burst=_bursts[0]
            _actor.x+=23;_actor.y+=31;_actor.gunangle=90;current_frame+=2
            with(_burst) event_perform(ev_alarm,0)
            current_frame+=2
            with(_burst) event_perform(ev_alarm,0)
            _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local_before),Bullet1)
            assert(array_length(_bullets)==3 && _actor.ammo[Ammo.Bullets]==100
                && instance_number(Player)==_player_count && _burst.ntte_merged_runtime_stock.frame.shot_replace_count==3,
                "Actual non-Player delayed stock failed replacements or charged actor/player ammo")
            scrNTTEFullMergedRuntimeActorTestFrames(_result.merged_frames,_actor)
            for(var _i=0;_i<array_length(_bullets);++_i)
                assert(_bullets[_i].creator==_actor && _bullets[_i].team==_actor.team,
                    "Actual deferred non-Player leaf changed its source creator/team")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            // Actual mounted front Burst must retain the complete parent
            // barrel transform, including different position/aim rotations.
            _actor.gunangle=35
            _weapon=scrNTTEFullWeaponMerge(wep_heavy_revolver,wep_assault_rifle);_handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon)
            _result=scrNTTEFullActorFireMount(_actor,{creator:_actor,wep:_handle,position_distance:11,
                position_rotation:20,direction_rotation:35,accuracy:0},_actor,false)
            _bursts=scrNTTEFullMergedRuntimeTestShots(_result.shots,Burst)
            assert(array_length(_bursts)==1,"Actual mounted non-Player front failed to create native Burst")
            _burst=_bursts[0];_actor.x+=17;_actor.y+=29;_actor.gunangle=90
            var _position=scrNTTEFullActorMountPosition(_burst.ntte_merged_runtime_at.mount),
                _angle=scrNTTEFullActorMountDirection(_burst.ntte_merged_runtime_at.mount)+_burst.ntte_merged_runtime_at.mount.direction_rotation
            assert(abs(_position.x-(_actor.x+lengthdir_x(11,110)))<0.001
                && abs(_position.y-(_actor.y+lengthdir_y(11,110)))<0.001 && abs(angle_difference(_angle,125))<0.001,
                "Retained front mount lost source parent barrel transform or stacked position/aim rotation")
            current_frame+=2
            with(_burst) event_perform(ev_alarm,0)
            assert(abs(_burst.x-_position.x)<0.001 && abs(_burst.y-_position.y)<0.001
                && abs(angle_difference(_burst.direction,125))<0.001 && instance_number(Player)==_player_count,
                "Actual deferred front native Burst ignored complete stable actor mount")
            _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local_before),Bullet1)
            assert(array_length(_bullets)==2 && _bullets[1].creator==_actor
                && array_length(_bullets[1].temerge_vars_list)==1,
                "Actual mounted non-Player deferred front lost original HeavyRevolver inheritance")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            // Charged front: its source physical state and controller are
            // owned by the real actor after every temporary Player is freed.
            var _front={wep:wep_ntte_annihilator}
            _weapon=scrNTTEFullWeaponMerge(wep_revolver,_front);_handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon);_actor.ntte_red_ammo=5
            _actor.gunangle=20
            _result=scrNTTEFullActorFire(_actor,_handle,20,0.6,false,_actor)
            var _charged=scrNTTEFullWeaponNativeState(_front),_controller=noone,_controllers=scrNTTEFullInstances(NTTEFullRedFireCharge)
            for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_charged) _controller=_controllers[_i]
            assert(instance_exists(_controller) && _controller.creator==_actor
                && _controller.ntte_merged_state_part==_front && _controller.ntte_merged_runtime_at.creator==_actor
                && _controller.ntte_merged_runtime_inherit[0].last_fire_vars.actor==_actor
                && instance_number(Player)==_player_count,
                "Non-Player charged front lost actual state/controller/frame owner when native firing proxy was freed")
            var _captured_direction=_controller.direction
            _charged.chrg=2;_charged.chrg_num=15;_charged.charge=15
            _actor.x+=45;_actor.y+=37;_actor.gunangle=90
            with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
            var _red=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local_before),NTTEFullRedBullet)
            scrNTTESmokeLog("MERGED ACTOR CHARGE DIAG kind="+string(_kind)+" controller="+string(instance_exists(_controller))
                +" redCount="+string(array_length(_red))+" redAmmo="+string(_actor.ntte_red_ammo)
                +" charge="+string(_charged.charge)+" chrg="+string(_charged.chrg)+" playerCount="+string(instance_number(Player))
                +" capturedDirection="+string(_captured_direction)
                +" red="+(array_length(_red)>0?string(_red[0].creator)+","+string(_red[0].team)+","+string(_red[0].direction)
                    +",ancestry="+string(array_length(_red[0].temerge_vars_list)):"none"))
            assert(!instance_exists(_controller) && array_length(_red)==1 && _red[0].creator==_actor
                && _red[0].team==_actor.team && abs(angle_difference(_red[0].direction,_captured_direction))<0.001
                && _actor.ntte_red_ammo==3 && _charged.charge==0 && _charged.chrg==0
                && array_length(_red[0].temerge_vars_list)==1 && instance_number(Player)==_player_count,
                "Actual enemy/Ally merged charge release lost RedBullet, captured direction, real red resource or inherited stock graph")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            // Charged merged stock releases then feeds its true RedBullet
            // through the same original replacement graph on the actual actor.
            _weapon=scrNTTEFullWeaponMerge(wep_ntte_annihilator,wep_revolver);_handle=scrNTTEFullWeaponNative(_weapon)
            _actor.wep=_handle;_actor.ntte_state=scrNTTEFullWeaponNativeState(_weapon);_actor.ntte_red_ammo=5
            _result=scrNTTEFullActorFire(_actor,_handle,20,0,false,_actor)
            _charged=_actor.ntte_state;_controller=noone;_controllers=scrNTTEFullInstances(NTTEFullRedFireCharge)
            for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_charged) _controller=_controllers[_i]
            assert(instance_exists(_controller) && _controller.ntte_merged_runtime_stock.frame.shot_is_delayed,
                "Actual non-Player merged stock failed its source delayed-charge frame")
            _charged.chrg=2;_charged.chrg_num=15;_charged.charge=15
            with(_controller) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
            _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_local_before),Bullet1)
            assert(array_length(_bullets)==1 && _bullets[0].creator==_actor && _actor.ntte_red_ammo==3
                && array_length(_bullets[0].temerge_vars_list)==1 && instance_number(Player)==_player_count,
                "Actual non-Player charged stock did not release into native front replacement")
            scrNTTEFullMergedRuntimeTestCleanup(_local_before)
            instance_destroy(_actor,false)
        }
        assert(json_stringify(_player.ammo)==_player_ammo && global.ntte_full_merged_request==_request,
            "Actual enemy/Ally merged firing polluted real player's ammunition or leaked scoped native request")
        scrNTTESmokeLog("PASS actual enemy/Ally merged native ActorFire, stable frame/mount owners, delayed stock/front, charged stock/front and synchronous proxy cleanup")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_native_weapon_models=_models;global.ntte_full_merged_request=_request
        current_frame=_tick;random_set_seed(_seed)
    }
}
