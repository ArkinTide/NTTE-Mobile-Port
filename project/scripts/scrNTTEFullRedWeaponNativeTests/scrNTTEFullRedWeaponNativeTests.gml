function scrNTTEFullRedWeaponNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_seed=random_get_seed(),_frame=current_frame,
        _skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _owner=instance_find(Player,0)
        _owner.x=24000;_owner.y=24000;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
        _owner.wep=wep_ntte_annihilator;_owner.bwep=wep_none;_owner.race=Race.Fish
        _owner.ntte_state=scrNTTENewState(_owner.wep);_owner.ntte_red_ammo=5
        _owner.infammo=0;_owner.can_shoot=true;_owner.reload=0;_owner.reloadspeed=1
        _owner.wepangle=120;_owner.gunangle=0;_owner.wkick=0;_owner.speed=0
        _owner.specfiring=false;_owner.visible=true
        KeyCont.hold_fire[_owner.index]=true;KeyCont.press_fire[_owner.index]=true
        var _shot_count=instance_number(NTTEFullRedBullet),_slash_count=instance_number(NTTEFullRedSlash)
        repeat(ceil(15/timescale)-1) with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.chrg_num<15 && _owner.ntte_state.charge==_owner.ntte_state.chrg_num
            && _owner.ntte_red_ammo==5 && instance_number(NTTEFullRedBullet)==_shot_count
            && instance_number(NTTEFullRedSlash)==_slash_count,
            "Held Annihilator emitted early, consumed red ammo, or lost source fifteen-logical-tick charge state")
        with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.chrg_num==15 && _owner.ntte_state.chrg==1 && abs(_owner.wkick-2)<0.0001
            && abs(_owner.wepangle)==0.1 && _owner.reload<=timescale,
            "Annihilator full charge lost source transition tick, pullback, orientation floor or held reload")
        var _flash_count=instance_number(PlasmaTrail)
        with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.chrg==2 && instance_number(PlasmaTrail)==_flash_count,
            "Annihilator full-charge flash repeated instead of entering charged state2")
        KeyCont.hold_fire[_owner.index]=false;KeyCont.press_fire[_owner.index]=false
        _owner.speed=0
        with(_owner) scrNTTEHandleInput(wep,true)
        var _shots=scrNTTEFullInstances(NTTEFullRedBullet),_shot=_shots[array_length(_shots)-1],
            _recoil=3*timescale+(1-timescale)*_owner.friction/2,
            _recoilX=lengthdir_x(_recoil,_shot.direction+180),_recoilY=lengthdir_y(_recoil,_shot.direction+180)
        assert(instance_number(NTTEFullRedBullet)==_shot_count+1 && _owner.ntte_red_ammo==3
            && _owner.ntte_state.charge==0 && _owner.ntte_state.chrg_num==0 && _owner.ntte_state.chrg==0
            && _owner.reload==18 && !_owner.can_shoot && _owner.wkick==10
            && abs(_owner.hspeed-_recoilX)<0.0001 && abs(_owner.vspeed-_recoilY)<0.0001,
            "Actual held/release input lost charged RedBullet, exact owner cost2, reset, native reload18 or original friction-compensated FT recoil")
        assert(_shot.creator==_owner && _shot.team==_owner.team && _shot.damage==400
            && abs(_shot.speed-16*timescale)<0.0001,"Annihilator release bypassed actual physical RedBullet ownership/motion/stats")

        // A partial release keeps red ammo and performs the original damaging
        // physical slash, with Long Arms controlling both offset and velocity.
        _owner.can_shoot=true;_owner.reload=0;_owner.reloadspeed=2;_owner.speed=0
        _owner.wepangle=120;_owner.wkick=0
        ds_list_add(_skills,mut_long_arms)
        GameCont.ntte_full_native_skill_counts[$ string(mut_long_arms)]=2
        KeyCont.hold_fire[_owner.index]=true
        with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.charge==2*timescale,"Annihilator charge ignored source reloadspeed multiplier")
        KeyCont.hold_fire[_owner.index]=false
        _owner.speed=0
        with(_owner) scrNTTEHandleInput(wep,true)
        var _slashes=scrNTTEFullInstances(NTTEFullRedSlash),_slash=_slashes[array_length(_slashes)-1],
            _lunge=6*timescale+(1-timescale)*_owner.friction/2,
            _lungeX=lengthdir_x(_lunge,_slash.direction),_lungeY=lengthdir_y(_lunge,_slash.direction)
        assert(instance_number(NTTEFullRedSlash)==_slash_count+1 && _owner.ntte_red_ammo==3
            && abs(_owner.hspeed-_lungeX)<0.0001 && abs(_owner.vspeed-_lungeY)<0.0001 && _owner.wkick==-4,
            "Partial Annihilator release spent red ammo or lost original friction-compensated FT forward lunge and negative kick")
        assert(_slash.x==_owner.x+40 && _slash.y==_owner.y && _slash.speed==8*timescale
            && _slash.damage==10 && _slash.knockback_speed==12*timescale && _slash.mask_index==mskSlash
            && _slash.friction==0.1*timescale*timescale && !_slash.clone && !_slash.walled,
            "Actual Annihilator fallback lost Long Arms offset/lerp speed or original RedSlash constructor")
        var _victim=instance_create(_slash.x,_slash.y,Bandit)
        _victim.team=team_enemy;_victim.hp=100;_victim.nexthurt=0;_victim.solid=false
        with(_victim) with(_slash) event_perform(ev_collision,hitme)
        assert(_victim.hp==90 && instance_exists(_slash),"Real RedSlash did not perform persistent native damage10")
        var _bullet=instance_create(_slash.x,_slash.y,Bullet1)
        _bullet.team=_slash.team;_bullet.typ=1;_bullet.speed=5*timescale;_bullet.direction=90
        with(_bullet) with(_slash) event_perform(ev_collision,projectile)
        assert(instance_exists(_bullet) && _bullet.deflected && _bullet.team==_slash.team
            && _bullet.direction==_slash.direction && _bullet.speed==5*timescale,
            "RedSlash source deflection must also handle same-team typ1 without changing speed")
        _bullet.typ=2
        with(_bullet) with(_slash) event_perform(ev_collision,projectile)
        assert(!instance_exists(_bullet),"RedSlash typ2 interception did not destroy the projectile")
        var _wall=instance_create(_slash.x,_slash.y,Wall),_fx_count=instance_number(MeleeHitWall),_sx=_slash.x,_sy=_slash.y
        with(_wall) with(_slash) event_perform(ev_collision,Wall)
        with(_wall) with(_slash) event_perform(ev_collision,Wall)
        assert(_slash.walled && instance_number(MeleeHitWall)==_fx_count+1 && _slash.x==_sx && _slash.y==_sy,
            "RedSlash wall feedback repeated or leaked its temporary source forward-position probe")
        var _walls=scrNTTEFullInstances(MeleeHitWall),_wallfx=_walls[array_length(_walls)-1]
        assert(_wallfx.image_blend==scrAreaGetBackroundColor(scrNTTEFullAreaId("red")),"RedSlash lost red-tinted wall impact")

        _owner.wepflip=1;_owner.bwepflip=1
        _owner.ntte_state.charge=15
        var _state=scrNTTEFullRedWeaponState(_owner.ntte_state)
        _state.chrg=2
        with(_owner) scrNTTEFullRedWeaponReloaded(true)
        assert(_owner.wepflip==-1,"Annihilator source charging reload did not flip held sprite")
        _state.charge=0
        with(_owner) scrNTTEFullRedWeaponReloaded(true)
        assert(_owner.wepflip==-1 && _state.chrg==0 && _state.chrg_num==0,
            "Save/swap legacy zero-charge cancellation did not clear source fields or normal reload flipped source sprite")
        // Source costs red even under ordinary weapon infinite-ammo mode.
        _owner.infammo=1;_owner.ntte_state.charge=15
        scrNTTEFullRedWeaponState(_owner.ntte_state);_owner.ntte_state.chrg=-1
        _shot_count=instance_number(NTTEFullRedBullet)
        with(_owner) scrFire(wep,false,true)
        assert(_owner.ntte_red_ammo==1 && instance_number(NTTEFullRedBullet)==_shot_count+1,
            "Annihilator incorrectly let ordinary infinite ammo waive original separate red resource cost")
        // Source Pop Pop primary instantly completes the first held tick.
        _owner.infammo=0;_owner.ntte_red_ammo=3;_owner.specfiring=true
        _owner.ntte_state=scrNTTENewState(_owner.wep);_owner.can_shoot=true
        KeyCont.hold_fire[_owner.index]=true
        with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.charge==15,"Annihilator primary active lost source instant charge")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys)
        random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL RED WEAPON NATIVE: source15 tick/reloadspeed/state2 charge, full release/cost2/real bullet, partial real slash/Long Arms/lunge, native damage/deflection/wall, legacy cancellation/reload flip/independent red ammo/Pop Pop OK @"+string(30/timescale))
    scrNTTEFullRedWeaponPlayerStepNativeTests();
}

function scrNTTEFullRedWeaponPlayerStepNativeTests() {
    // The full native Player/EndStep and both delayed-controller orders still
    // assert canonical inventory, original15-tick charge, one red2 release and
    // no duplicate projectile. Also assert the requested ordinary tap/delay.
    scrNTTEFullChargeInputPlayerStepNativeTests()
}

function scrNTTEFullRedSlashEligibilityTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _classes=[NTTEFullRedSlash,NTTEFullEntanglerSlash],_teams=[team_none,team_player,team_enemy,3],
            _owner=instance_find(Player,0)
        for(var _i=0;_i<array_length(_classes);++_i) {
            var _slash=instance_create(62700+100*_i,62700,_classes[_i]),
                _victim=instance_create(_slash.x,_slash.y,Bandit),_clones=instance_number(NTTEFullCrystalClone)
            _slash.creator=_owner;_slash.clone=true
            for(var _j=0;_j<array_length(_teams);++_j) {
                _slash.team=_teams[_j];_victim.team=_teams[_j];_victim.hp=100;_victim.nexthurt=0
                with(_victim) with(_slash) event_perform(ev_collision,hitme)
                assert(_victim.hp==100 && _victim.nexthurt==0,
                    "RedSlash/Entangler original melee must reject every equal team, including team_none")
            }
            _slash.team=team_player;_victim.team=team_enemy;_victim.nexthurt=current_frame+1
            with(_victim) with(_slash) event_perform(ev_collision,hitme)
            assert(_victim.hp==100,"RedSlash/Entangler original melee ignored target immunity")
            _victim.nexthurt=current_frame
            with(_victim) with(_slash) event_perform(ev_collision,hitme)
            assert(_victim.hp==100-_slash.damage && _victim.nexthurt==current_frame+6,
                "RedSlash/Entangler original melee rejected inclusive immunity expiry or lost actual native hurt")
            var _health=[0,-3]
            for(var _j=0;_j<array_length(_health);++_j) {
                _victim.hp=_health[_j];_victim.nexthurt=0
                with(_victim) with(_slash) event_perform(ev_collision,hitme)
                assert(_victim.hp==_health[_j]-_slash.damage && _victim.nexthurt==current_frame+6,
                    "RedSlash/Entangler source melee acquired a positive-health eligibility condition")
                assert(instance_number(NTTEFullCrystalClone)==_clones,
                    "Entangler created a fresh clone from an already defeated target")
            }
            var _allowed=false
            with(_slash) _allowed=scrNTTEFullRedSlashCanHit(noone)
            assert(!_allowed,"Scoped source melee predicate accepted a nonexistent target")
        }
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL RED SLASH ELIGIBILITY: actual Annihilator/Entangler collisions reject all equal teams including0, respect inclusive immunity, accept nonpositive health without cloning defeated targets OK @"+string(30/timescale))
}
