function scrNTTEFullTridentNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create(),
        _view=[view_xview,view_yview]
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _owner=instance_find(Player,0)
        _owner.x=57000;_owner.y=57000;_owner.gunangle=0;_owner.wepangle=0;_owner.wkick=0
        _owner.speed=0;_owner.accuracy=0;_owner.wep=wep_ntte_trident;_owner.bwep=wep_none
        _owner.ntte_state=scrNTTENewState(_owner.wep);_owner.bntte_state=undefined
        _owner.reloadspeed=1;_owner.can_shoot=true;_owner.infammo=0;_owner.curse=0
        _owner.race=Race.Fish;_owner.specfiring=false
        assert(!scr_weapon_is_melee(_owner.wep),"Trident source non-melee classification still flips charging angle")
        KeyCont.hold_fire[_owner.index]=true;KeyCont.press_fire[_owner.index]=true
        var _old=instance_number(NTTEFullTrident),_state=_owner.ntte_state
        repeat(ceil(7/timescale)) with(_owner) scrNTTEHandleInput(wep,true)
        assert(_state.chrg_num==7 && _owner.wkick==9 && _owner.wepangle==0
            && _state.ammo==1 && instance_number(NTTEFullTrident)==_old,"Trident source seven-tick charge/pullback emitted or consumed early")
        KeyCont.hold_fire[_owner.index]=false;KeyCont.press_fire[_owner.index]=false
        with(_owner) scrNTTEHandleInput(wep,true)
        var _shot=noone
        with(NTTEFullTrident) if(state==_state) _shot=id
        assert(instance_exists(_shot) && _shot.creator==_owner && _shot.team==_owner.team
            && abs(_shot.speed-18*timescale)<0.0001 && _shot.damage==40 && _shot.force==5
            && _state.ammo==0 && !_state.visible && _owner.wkick==-4,
            "Actual full Trident release lost source projectile/ownership/physical transfer/post")
        with(_owner) scrNTTEConsumeBoneSlots()
        assert(_owner.wep==wep_none && _owner.bwep==wep_none,"Thrown Trident stayed available in inventory")
        var _enemy=instance_create(_shot.x,_shot.y,Bandit)
        _enemy.hp=100;_enemy.team=team_enemy;_enemy.nexthurt=current_frame+1000
        with(_enemy) with(_shot) event_perform(ev_collision,hitme)
        assert(_enemy.hp==60 && _shot.speed==0 && _shot.target==_enemy,
            "Native Trident collision respected ordinary iframe or failed source40 damage/stick")
        var _other=scrWeaponPickupCreate(_shot.x+60,_shot.y,wep_ntte_trident)
        _other.ntte_state=scrNTTENewState(wep_ntte_trident)
        instance_destroy(_shot)
        var _pickup=noone
        with(NTTEFullWepPickupStick) if(ntte_state==_state) _pickup=id
        assert(instance_exists(_pickup) && _pickup.stick_target==_enemy && _pickup.stick_damage==40
            && _pickup.ntte_state==_state && instance_exists(_other),
            "Trident cleanup lost exact physical pickup/stick damage or deleted independent same-type weapon")
        _enemy.hspeed=2*timescale;_enemy.vspeed=3*timescale
        with(_pickup) scrNTTEFullTridentStickStep()
        assert(abs(_pickup.x-(_enemy.x+_enemy.hspeed+_pickup.stick_x))<0.01
            && abs(_pickup.y-(_enemy.y+_enemy.vspeed+_pickup.stick_y))<0.01,
            "Stuck Trident pickup failed source actual upcoming-motion tracking")
        // Exact state is transferred on pickup; removal triggers source raw
        // extraction damage on the retained enemy even through its hurt interval.
        _owner.wep=wep_ntte_trident;_owner.ntte_state=_state
        instance_destroy(_pickup,false)
        var _extract=noone
        with(NTTEFullTridentExtract) if(state==_state) _extract=id
        assert(instance_exists(_extract),"Stuck Trident removal failed to retain extraction transaction")
        assert(!object_is_ancestor(NTTEFullTridentExtract,NTTEFullMergedEffectScheduler),
            "Extraction must not inherit merged scheduler phases or be enumerated as its controller")
        // A pickup can disappear during normal Step, so its deferred job sees
        // post/end phases before its first normal Step on the following frame.
        scrNTTEFullMergedEffectsPostStep()
        with(_extract) {event_perform(ev_step,ev_step_begin);event_perform(ev_step,ev_step_end)}
        assert(instance_exists(_extract) && _enemy.hp==60,"Extraction ran before the next normal Step")
        with(_extract) event_perform(ev_step,ev_step_normal)
        assert(_enemy.hp==20 && _owner.wkick==10,"Trident extraction lost extra raw40 damage or holder kick")
        // The 1-3 native skull and Coast eel skull exercise the reported
        // interaction with real props, including their deferred death events.
        var _skulls=[BigSkull,NTTEFullEelSkull]
        for(var _si=0;_si<array_length(_skulls);++_si) {
            var _skull=instance_create(57600+_si*100,57200,_skulls[_si]),
                _skullshot=instance_create(_skull.x,_skull.y,NTTEFullTrident),
                _skullstate=scrNTTENewState(wep_ntte_trident)
            _skull.team=team_none;_skull.hp=50
            _skullshot.creator=_owner;_skullshot.team=team_player;_skullshot.speed=18*timescale
            _skullshot.state=_skullstate;_skullshot.wep=wep_ntte_trident
            with(_skull) with(_skullshot) event_perform(ev_collision,hitme)
            assert(_skull.hp==10 && _skullshot.target==_skull,"Trident failed actual skull insertion")
            instance_destroy(_skullshot);_pickup=noone
            with(NTTEFullWepPickupStick) if(ntte_state==_skullstate) _pickup=id
            assert(instance_exists(_pickup),"Skull insertion failed physical stuck pickup")
            _owner.wep=wep_ntte_trident;_owner.ntte_state=_skullstate
            instance_destroy(_pickup,false);_extract=noone
            with(NTTEFullTridentExtract) if(state==_skullstate) _extract=id
            assert(instance_exists(_extract),"Skull pickup failed deferred extraction")
            scrNTTEFullMergedEffectsPostStep()
            with(_extract) event_perform(ev_step,ev_step_end)
            assert(instance_exists(_extract) && _skull.hp==10,"Skull extraction ran in its creation frame")
            with(_extract) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_extract) && _skull.hp==-30,"Skull extraction lost source raw40 damage")
            with(_skull) event_perform(ev_step,ev_step_normal)
        }
        // Missed Coast throw leaves the camera over water, returns at a
        // bounded speed, then produces exactly one pickup with the same state.
        var _return=instance_create(59000,59000,NTTEFullTrident),_returnstate=scrNTTENewState(wep_ntte_trident),
            _area=GameCont.area,_landing=instance_create(58880,59000,Floor)
        GameCont.area=201;view_xview=57000;view_yview=57000
        _return.creator=_owner;_return.team=team_player;_return.wep=wep_ntte_trident;_return.state=_returnstate
        _return.ntte_trident_safe_x=58880;_return.ntte_trident_safe_y=59000;_return.speed=18*timescale
        with(_return) event_perform(ev_step,ev_step_normal)
        assert(_return.ntte_trident_returning && abs(_return.x-(59000-3*timescale))<0.001 && _return.speed==0,
            "Missed Coast throw did not start a gradual harmless return")
        repeat(ceil(120/(3*timescale))+1) if(instance_exists(_return)) with(_return) event_perform(ev_step,ev_step_normal)
        var _returned=0
        with(WepPickup) if(scrNTTEFullValue(id,"ntte_state",undefined)==_returnstate) {
            ++_returned;assert(abs(x-58880)<0.01 && abs(y-59000)<0.01,"Coast return pickup missed retained safe position")
        }
        assert(!instance_exists(_return) && _returned==1 && _returnstate.visible,"Coast return duplicated or lost physical weapon")
        view_xview=_view[0];view_yview=_view[1];GameCont.area=_area
        // A second ordinary release at partial charge creates all six source
        // Shanks (three rays, with the inner ray instance hidden).
        _owner.ntte_state=scrNTTENewState(wep_ntte_trident);_state=_owner.ntte_state
        _owner.can_shoot=true;KeyCont.hold_fire[_owner.index]=true
        with(_owner) scrNTTEHandleInput(wep,true)
        var _stabs=scrNTTEFullInstances(Shank),_n=0,_visible=0
        KeyCont.hold_fire[_owner.index]=false
        with(_owner) scrNTTEHandleInput(wep,true)
        with(Shank) if(array_get_index(_stabs,id)<0) {
            ++_n;if(visible) {_visible+=1}
            assert(damage==20 && !canfix && image_yscale==0.9,"Partial Trident retained generic swing values")
        }
        assert(_n==6 && _visible==3 && _state.ammo==1 && _owner.wkick==-14,
            "Partial Trident release lost source layered six-Shank geometry or consumed weapon")
        // Native per-target three-tick map does not use the target's six-tick
        // presentation immunity. Chicken TB permits continued piercing flight.
        _owner.race=Race.Chicken;GameCont.ntte_full_native_skill_counts={}
        ds_list_add(_skills,mut_throne_butt)
        var _pierce=instance_create(57500,57000,NTTEFullTrident)
        _pierce.creator=_owner;_pierce.team=team_player;_pierce.direction=0;_pierce.speed=23.4*timescale
        _pierce.wep=wep_none;_enemy.hp=160;_enemy.speed=0
        with(_enemy) with(_pierce) event_perform(ev_collision,hitme)
        assert(_enemy.hp==120 && abs(_pierce.speed-18*timescale)<0.0001,"Trident first hit speed clamp/Chicken TB changed")
        with(_enemy) with(_pierce) event_perform(ev_collision,hitme)
        assert(_enemy.hp==120,"Trident repeated damage within source three-tick per-target map")
        _pierce.hit_time=3
        with(_enemy) with(_pierce) event_perform(ev_collision,hitme)
        assert(_enemy.hp==80,"Trident own hit map incorrectly used target nexthurt")
        ds_list_clear(_skills);_owner.race=Race.Fish
        // Cursed cleanup restores this physical slot instead of manufacturing
        // another weapon pickup. Independent weapons remain untouched.
        _owner.wep=wep_ntte_golden_trident;_owner.ntte_state=scrNTTENewState(_owner.wep)
        _owner.curse=1;_owner.can_shoot=true;_state=_owner.ntte_state
        KeyCont.hold_fire[_owner.index]=true
        repeat(ceil(7/timescale)) with(_owner) scrNTTEHandleInput(wep,true)
        KeyCont.hold_fire[_owner.index]=false
        with(_owner) scrNTTEHandleInput(wep,true)
        _shot=noone
        with(NTTEFullTrident) if(state==_state) _shot=id
        assert(instance_exists(_shot) && _shot.curse==1 && abs(_shot.speed-23.4*timescale)<0.0001
            && !_state.visible && _state.ammo==1 && _owner.wep==wep_ntte_golden_trident,
            "Cursed/golden Trident lost original23.4 speed or failed hidden retained slot")
        assert(scrNTTEFullWeaponStateSprite(_owner.wep,_state)==mskNone,"Cursed thrown Trident remained visible in held sprite")
        var _drops=instance_number(WepPickup)
        _shot.speed=0;_shot.x=_owner.x;_shot.y=_owner.y
        with(_shot) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_shot) && _state.visible && instance_number(WepPickup)==_drops,
            "Cursed Trident failed automatic physical return or duplicated a pickup")
        // Distinct projectile classes retain source filtering; PopoNade is
        // excluded while foreign typ1/2 bullets are destroyed within8 pixels.
        var _guard=instance_create(57800,57000,NTTEFullTrident),_bullet=instance_create(57800,57000,Bullet1),
            _nade=instance_create(57800,57000,PopoNade)
        _guard.wep=wep_none;_guard.speed=10*timescale;_guard.team=team_player
        _bullet.team=team_enemy;_nade.team=team_enemy
        with(_guard) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_bullet) && instance_exists(_nade),"Trident source bullet break filter changed")
        with(_guard) event_perform(ev_alarm,0)
        assert(abs(_guard.friction-0.5*timescale*timescale)<0.0001,"Trident source15 tick friction onset changed")
        _guard.ntte_trident_alarm_frame=-1
        with(_guard) event_perform(ev_collision,Wall)
        assert(_guard.speed==0,"Trident wall collision failed native stop")
    } finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) {
                if(instance_is(_all[_i],NTTEFullTrident)) _all[_i].wep=wep_none
                if(instance_is(_all[_i],NTTEFullWepPickupStick)) _all[_i].stick_damage=0
                instance_destroy(_all[_i],false)
            }
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys)
        ds_list_destroy(_skills);random_set_seed(_seed);current_frame=_frame
        view_xview=_view[0];view_yview=_view[1]
    }
    scrNTTESmokeLog("FULL TRIDENT: actual7tick charge/partial sixShanks/full40damage, physical consumption/stuck pickup/extraction, own3tick map/Chicken TB, cursed golden return, projectile break and alarm/wall lifecycle OK @"+string(30/timescale))
}
