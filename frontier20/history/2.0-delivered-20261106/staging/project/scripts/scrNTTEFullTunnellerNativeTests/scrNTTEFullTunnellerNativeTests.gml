function scrNTTEFullTunnellerNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _owner=instance_find(Player,0)
        _owner.x=55000;_owner.y=55000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
        _owner.wep=wep_ntte_tunneller;_owner.bwep=wep_none;_owner.ntte_state=scrNTTENewState(_owner.wep)
        _owner.ntte_red_ammo=3;_owner.can_shoot=true;_owner.reload=0;_owner.reloadspeed=1
        _owner.wepangle=120;_owner.gunangle=0;_owner.accuracy=0;_owner.wkick=0;_owner.speed=0
        _owner.specfiring=false;_owner.race=Race.Fish;_owner.infammo=0;_owner.visible=true
        assert(!scr_weapon_is_melee(_owner.wep) && !scr_weapon_is_melee(wep_ntte_golden_tunneller),
            "Tunneller source weapon_melee=false was lost to type0 melee classification")
        KeyCont.hold_fire[_owner.index]=true;KeyCont.press_fire[_owner.index]=true
        var _balls=instance_number(NTTEFullCrystalHeartBullet),_stabs=instance_number(NTTEFullRedShank),
            _bursts=instance_number(NTTEFullNativeFireBurst)
        repeat(ceil(15/timescale)) with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.chrg_num==15 && _owner.ntte_red_ammo==3 && _owner.wkick==-8
            && _owner.wepangle==120 && instance_number(NTTEFullCrystalHeartBullet)==_balls
            && instance_number(NTTEFullRedShank)==_stabs,
            "Tunneller held native input lost source15ticks, negative pullback8, unchanged orientation or emitted/spent early")
        KeyCont.hold_fire[_owner.index]=false;KeyCont.press_fire[_owner.index]=false
        _owner.speed=0
        with(_owner) scrNTTEHandleInput(wep,true)
        var _list=scrNTTEFullInstances(NTTEFullCrystalHeartBullet),_ball=_list[array_length(_list)-1],
            _force=4*timescale+(1-timescale)*_owner.friction/2
        assert(instance_number(NTTEFullCrystalHeartBullet)==_balls+1 && _owner.ntte_red_ammo==2
            && instance_number(NTTEFullNativeFireBurst)==_bursts && _ball.creator==_owner && _ball.team==_owner.team
            && _ball.speed==4*timescale && _ball.area_goal>=8 && _ball.area_goal<=12
            && _owner.ntte_state.chrg==0 && _owner.wkick==12 && _owner.reload==24
            && abs(_owner.hspeed+_force)<=0.00001,
            "Tunneller full native release lost cost1/actual chaos ball, source8..12goal, one-shot burst, FT recoil or native load24")
        assert(array_length(_ball.area_chest)>0 && _ball.area==scrNTTEFullAreaId("red"),
            "Tunneller source random rewards or actual red destination missing")
        // A real charged ball must drive the existing synchronous area lifecycle.
        // Fix the test destination to a supported room; reward dependencies are
        // exercised by the independent reward-entity suite.
        _ball.area=area_desert;_ball.subarea=1;_ball.loops=0;_ball.area_chaos=false
        _ball.area_chest=[AmmoChest];_ball.area_goal=8
        var _floorCount=instance_number(Floor),_chestCount=instance_number(AmmoChest),_activeArea=GameCont.area
        instance_destroy(_ball)
        assert(instance_number(Floor)>_floorCount+3 && instance_number(AmmoChest)>=_chestCount+1
            && GameCont.area==_activeArea,"Actual fired Tunneller ball did not unfold real terrain/reward while preserving active area")
        // Partial release: source three genuine Shanks separated4logical ticks.
        _owner.can_shoot=true;_owner.reload=0;_owner.speed=0;_owner.wepangle=120
        GameCont.ntte_full_native_skill_counts[$ string(mut_long_arms)]=2;ds_list_add(_skills,mut_long_arms)
        KeyCont.hold_fire[_owner.index]=true
        with(_owner) scrNTTEHandleInput(wep,true)
        KeyCont.hold_fire[_owner.index]=false
        with(_owner) scrNTTEHandleInput(wep,true)
        var _shots=scrNTTEFullInstances(NTTEFullRedShank),_stab=_shots[array_length(_shots)-1],_burst=noone
        with(NTTEFullNativeFireBurst) if(creator==_owner && scrNTTEIsTunnel(scrNTTEFullWeaponRaw(wep))) {_burst=id;break}
        assert(instance_exists(_burst) && _burst.ammo==2 && _burst.explicit_interval==4 && _burst.time_max==4
            && instance_number(NTTEFullRedShank)==_stabs+1 && _stab.damage==10 && _stab.force==6
            && _stab.knockback_speed==6*timescale && _stab.speed==9*timescale
            && abs(_stab.x-(_owner.x+20+9*(1-timescale)))<0.01
            && _owner.ntte_red_ammo==2 && _owner.wkick==-9,
            "Tunneller partial release lost native three-burst/timing, RedShank10+force6, Long Arms or spent red")
        // Replacing held charge must not transform queued stabs into chaos balls.
        _owner.ntte_state.charge=15;_owner.ntte_state.chrg_num=15
        repeat(ceil(9/timescale)) if(instance_exists(_burst)) with(_burst) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_burst) && instance_number(NTTEFullRedShank)==_stabs+3
            && instance_number(NTTEFullCrystalHeartBullet)==_balls && _owner.ntte_red_ammo==2,
            "Tunneller delayed stabs lost exact three-burst, charged a second time or debited extra red")
        // Gold is an LWO field as well as the compatibility separate native ID.
        var _model={wep:wep_ntte_tunneller,gold:true},_handle=scrNTTEFullWeaponNative(_model)
        _owner.wep=_handle;_owner.ntte_state=scrNTTENewState(_handle);_owner.can_shoot=true;_owner.reload=0
        _owner.infammo=1;_owner.ntte_state.charge=15
        scrNTTEFullRedWeaponState(_owner.ntte_state);_owner.ntte_state.chrg=-1
        with(_owner) scrFire(wep,false,true)
        _list=scrNTTEFullInstances(NTTEFullCrystalHeartBullet);_ball=_list[array_length(_list)-1]
        scrNTTESmokeLog("TUNNELLER GOLD CONDITIONS "+json_stringify({goal:_ball.area_goal,red:_owner.ntte_red_ammo,
            canonicalGold:scrNTTEFullTunnellerGold(_handle),separateIDGold:scrNTTEFullTunnellerGold(wep_ntte_golden_tunneller),
            sourceModelGold:_model.gold,handle:string(_handle),stateWeapon:string(_owner.ntte_state.weapon),
            owner:string(_owner),creator:string(_ball.creator)}))
        assert(_ball.area_goal>=12 && _ball.area_goal<=16 && _owner.ntte_red_ammo==1
            && scrNTTEFullTunnellerGold(_handle) && scrNTTEFullTunnellerGold(wep_ntte_golden_tunneller),
            "Golden Tunneller lost physical gold LWO+4goal or ordinary infinite ammo waived separate red cost")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL TUNNELLER NATIVE: source15tick charge/pullback8, actual cost1+single chaos ball/unfold terrain/reward, partial real3xShank10+force6/interval4/Long Arms, delayed captured physical state, gold LWO+4goal/infinite ammo separate red OK @"+string(30/timescale))
}
function scrNTTEFullCrystalHeartNativeHitTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _frame=current_frame,_seed=random_get_seed()
    current_frame=2
    try {
        var _owner=instance_find(Player,0),_target=instance_create(56500,56500,Bandit),
            _ball=instance_create(56500,56500,NTTEFullCrystalHeartBullet)
        _ball.creator=_owner;_ball.team=team_player;_ball.speed=10*timescale;_ball.direction=0
        _target.hp=100;_target.team=team_enemy;_target.nexthurt=900;_target.speed=0
        var _x=_ball.x,_y=_ball.y
        with(_target) with(_ball) event_perform(ev_collision,hitme)
        assert(_target.hp==97 && _target.nexthurt==current_frame+6 && _ball.x==_x && _ball.y==_y,
            "CrystalHeart NP enemy hit incorrectly respected immunity, rewound immune target or replaced original raw hurt6 with enemy freeze10")
        with(_target) with(_ball) event_perform(ev_collision,hitme)
        assert(_target.hp==94,"CrystalHeart NP lost original repeat logical-frame enemy damage")
        _target.nexthurt=0;_ball.speed=6*timescale;_x=_ball.x
        with(_target) with(_ball) event_perform(ev_collision,hitme)
        assert(_target.hp==91 && abs(_ball.x-(_x-6*timescale))<0.01,
            "CrystalHeart melee-eligible contact did not rewind actual projectile velocity")
        if(timescale<1) {
            current_frame=2+timescale
            with(_target) with(_ball) event_perform(ev_collision,hitme)
            assert(_target.hp==91,"CrystalHeart enemy hit lost source logical30Hz active-frame gate")
        }
        current_frame=2
        _owner.hp=max(_owner.hp,10);_owner.nexthurt=900;_ball.team=team_enemy
        var _hp=_owner.hp
        with(_owner) with(_ball) event_perform(ev_collision,hitme)
        assert(_owner.hp==_hp,"CrystalHeart NP ignored Player immunity while correctly ignoring enemy immunity")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_game)
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL CRYSTAL HEART NATIVE NP: real collision ignores enemy immunity/repeats at30logicalHz, source raw hurt6 rather than enemy freeze10, rewinds only melee-eligible contact, respects Player immunity OK @"+string(30/timescale))
}
