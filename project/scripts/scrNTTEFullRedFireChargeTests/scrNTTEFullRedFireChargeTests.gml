function scrNTTEFullRedFireChargeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame
    current_frame=2
    try {
        // Repeated native player_fire_ext calls discard their temporary Player
        // proxy. Only the genuine controller/state may retain the held charge.
        var _actor=instance_create(27000,27000,Bandit)
        _actor.wep=wep_ntte_annihilator;_actor.bwep=wep_none
        _actor.ntte_state=scrNTTENewState(_actor.wep);_actor.ntte_red_ammo=5
        _actor.visible=true;_actor.team=team_player;_actor.gunangle=20;_actor.speed=0
        var _player_count=instance_number(Player),_controller_count=instance_number(NTTEFullRedFireCharge),
            _bullet_count=instance_number(NTTEFullRedBullet),_controller=noone
        repeat(ceil(15/timescale)) {
            var _result=scrNTTEFullActorFire(_actor,_actor.wep,20,0.6,false,_actor)
            _actor.ntte_state=_result.state
            assert(!array_length(_result.shots) && instance_number(Player)==_player_count,
                "Held ActorFire must clean its proxy without emitting a premature Annihilator shot")
            var _controllers=scrNTTEFullInstances(NTTEFullRedFireCharge)
            for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_actor.ntte_state) _controller=_controllers[_i]
            assert(instance_exists(_controller) && !_controller.fire && _controller.creator==_actor
                && _controller.accuracy==0.6 && _controller.team==team_player,
                "FireCharge did not retain actual creator/team/accuracy after the fire proxy was destroyed")
            with(_controller) event_perform(ev_step,ev_step_normal)
            assert(_controller.fire && instance_number(NTTEFullRedBullet)==_bullet_count,
                "First FireCharge Step must arm the release without firing")
        }
        assert(instance_number(NTTEFullRedFireCharge)==_controller_count+1
            && _actor.ntte_state.charge==15 && _actor.ntte_red_ammo==5,
            "ActorFire charge refresh duplicated controller, lost physical state or spent red while held")
        _actor.x+=80;_actor.y+=40;_actor.gunangle=90
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_controller) && instance_number(NTTEFullRedBullet)==_bullet_count+1
            && _actor.ntte_red_ammo==3 && _actor.ntte_state.charge==0 && _actor.ntte_state.chrg==0,
            "Missed source refresh failed delayed real release, exact owner cost or shared-state reset")
        var _bullets=scrNTTEFullInstances(NTTEFullRedBullet),_bullet=_bullets[array_length(_bullets)-1]
        assert(_bullet.creator==_actor && _bullet.team==team_player && _bullet.direction==20
            && _bullet.xstart==_actor.x && _bullet.ystart==_actor.y
            && _bullet.ntte_actor_accuracy==0.6,
            "Non-player FireCharge release lost current creator position, captured angle/accuracy or real ownership")

        // A different physical weapon with the same raw ID cannot inherit a
        // controller charge. The original source compares LWO identity.
        _actor.ntte_state=scrNTTENewState(_actor.wep)
        var _result=scrNTTEFullActorFire(_actor,_actor.wep,10,1,false,_actor)
        _actor.ntte_state=_result.state
        var _oldstate=_actor.ntte_state,_controllers=scrNTTEFullInstances(NTTEFullRedFireCharge),_cancel=noone
        for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_oldstate) _cancel=_controllers[_i]
        _actor.ntte_state=scrNTTENewState(_actor.wep)
        var _slashes=instance_number(NTTEFullRedSlash)
        with(_cancel) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        assert(!instance_exists(_cancel) && _oldstate.charge==0 && instance_number(NTTEFullRedSlash)==_slashes
            && _actor.ntte_red_ammo==3,"Replacing an identical raw weapon incorrectly released another physical weapon's stored charge")

        // Direct Player fire also gets the source missed-refresh controller;
        // it restores captured team/accuracy around actual native scrFire.
        var _player=instance_find(Player,0)
        _player.wep=wep_ntte_annihilator;_player.bwep=wep_none;_player.ntte_state=scrNTTENewState(_player.wep)
        _player.ntte_red_ammo=5;_player.x=27500;_player.y=27500;_player.gunangle=35
        _player.team=team_player;_player.visible=true;_player.accuracy=0.7;_player.infammo=0;_player.specfiring=false
        _player.wepangle=120;_player.reloadspeed=1
        with(_player) scrFire(wep,false,true)
        var _controllers=scrNTTEFullInstances(NTTEFullRedFireCharge),_pc=noone
        for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_player.ntte_state) _pc=_controllers[_i]
        assert(instance_exists(_pc),"Direct Player native fire failed to create real source FireCharge controller")
        _pc.wep.charge=15;_pc.wep.chrg_num=15;_pc.wep.chrg=2
        _pc.team=team_enemy;_pc.accuracy=0.25
        _player.gunangle=90
        _bullet_count=instance_number(NTTEFullRedBullet)
        with(_pc) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        assert(!instance_exists(_pc) && instance_number(NTTEFullRedBullet)==_bullet_count+1
            && _player.team==team_player && _player.accuracy==0.7 && _player.gunangle==90
            && _player.ntte_red_ammo==3 && _player.reload==18,
            "Player FireCharge lost actual release/cost/native reload or leaked temporary team/accuracy/direction")
        _bullets=scrNTTEFullInstances(NTTEFullRedBullet);_bullet=_bullets[array_length(_bullets)-1]
        assert(_bullet.creator==_player && _bullet.team==team_enemy && _bullet.direction==35,
            "Player FireCharge ignored captured release team/direction")
        // Hidden creator cancels rather than firing through a portal transition.
        _player.ntte_state=scrNTTENewState(_player.wep);_player.visible=true
        with(_player) scrFire(wep,false,true)
        _controllers=scrNTTEFullInstances(NTTEFullRedFireCharge);_pc=noone
        for(var _i=0;_i<array_length(_controllers);++_i) if(_controllers[_i].wep==_player.ntte_state) _pc=_controllers[_i]
        _player.visible=false;_slashes=instance_number(NTTEFullRedSlash)
        with(_pc) {event_perform(ev_step,ev_step_normal);event_perform(ev_step,ev_step_normal)}
        assert(!instance_exists(_pc) && instance_number(NTTEFullRedSlash)==_slashes && _player.ntte_state.charge==0,
            "Invisible creator should cancel source FireCharge without a phantom release")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_frame
    }
    scrNTTESmokeLog("FULL RED FIRECHARGE: real per-state retained controller across discarded proxies, refreshed hold/two-Step release, current creator position/captured direction/team/accuracy, actual player/non-player fire, physical replacement/hidden cancellation OK @"+string(30/timescale))
}
