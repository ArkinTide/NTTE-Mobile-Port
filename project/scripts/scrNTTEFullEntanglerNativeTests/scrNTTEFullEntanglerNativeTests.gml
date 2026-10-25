// Real EndStep reproducer for the undefined optional native walk field and
// the copied-charm record referenced by the real lifecycle registry.
function scrNTTEFullCrystalCloneOptionalStateNativeTests() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_owner=instance_find(Player,0),_checks=0,
        _outlines=scrNTTEFullInstances([NTTEFullOutlineCache,NTTEFullCharmOutlineDraw])
    for(var _i=0;_i<array_length(_outlines);++_i) instance_deactivate_object(_outlines[_i])
    try {
        GameCont.ntte_charm_instance_list=[];GameCont.ntte_charm_instance_vars=[]
        var _enemy=instance_create(_owner.x+64,_owner.y,Bandit),
            _controller=instance_create(_enemy.x,_enemy.y,NTTEFullCrystalClone),
            _values=[undefined,5,0.4,-2,true,false]
        _enemy.intro=true;_enemy.hp=11
        _controller.target=_enemy;_controller.time=100;_controller.appear_health=8
        for(var _i=0;_i<array_length(_values);++_i) {
            _enemy.walk=_values[_i];_enemy.speed=5*timescale
            _enemy.xprevious=_enemy.x-2;_enemy.yprevious=_enemy.y-1
            _enemy.hp=1;_controller.appear=1
            var _time=_controller.time
            with(_controller) event_perform(ev_step,ev_step_end)
            assert(_enemy.speed==0 && _enemy.x==_enemy.xprevious && _enemy.y==_enemy.yprevious
                && !_enemy.visible && _enemy.hp==8 && _controller.time==_time-timescale,
                "CrystalClone optional walk guard changed real appearance freeze/HP/lifetime")
            if(is_undefined(_values[_i])) assert(is_undefined(_enemy.walk),
                "CrystalClone synthesized a walk field value unsupported by the native subclass")
            else assert(_enemy.walk==min(1,_values[_i]),
                "CrystalClone lost original numeric/bool walk limiting")
            ++_checks
        }
        // Clone an already charmed native actor through the production path.
        // Both instance records must be the same objects held in the registry,
        // while being distinct from one another. A detached shallow copy would
        // pass a value-only check but never receive the timer decrements.
        _enemy.visible=true
        var _original=scrNTTEFullParrotCharm(_enemy,true)
        _original.index=_owner.index;_original.kill=false;_original.time=3
        var _copy=scrNTTEFullCrystalInstanceClone(_enemy),_copyIndex=array_get_index(GameCont.ntte_charm_instance_list,_copy)
        assert(instance_exists(_copy) && _copyIndex>=0 && _copy.ntte_charm!=_original
            && _copy.ntte_charm==GameCont.ntte_charm_instance_vars[_copyIndex]
            && _copy.ntte_charm.time==3 && _copy.ntte_charm.charmed,
            "CrystalClone replaced the independently registered native charm with detached state")
        scrNTTEFullParrotCharmTimers()
        assert(_copy.ntte_charm.time==3-timescale && _original.time==3-timescale,
            "Actual charm lifecycle did not decrement both source and cloned instance records exactly once")
        scrNTTEFullParrotCharm(_copy,false)
        assert(!_copy.ntte_charm.charmed && _original.charmed && _enemy.team==team_player,
            "Ending cloned charm leaked into the original native actor")
        ++_checks
        // Inactive records must also be explicitly independent; only an active
        // registered copy may bypass CrystalCloneValue's normal shallow clone.
        var _inactive=_copy.ntte_charm,_inactiveTeam=_copy.team,_inactiveTime=_inactive.time,
            _reclone=scrNTTEFullCrystalInstanceClone(_copy)
        assert(_reclone.ntte_charm!=_inactive && !_reclone.ntte_charm.charmed,
            "Cloning an uncharmed native actor shared its inactive charm record")
        var _reactivated=scrNTTEFullParrotCharm(_reclone,true)
        _reactivated.time=5
        var _reindex=array_get_index(GameCont.ntte_charm_instance_list,_reclone)
        assert(_reindex>=0 && GameCont.ntte_charm_instance_vars[_reindex]==_reactivated
            && !_inactive.charmed && _copy.team==_inactiveTeam && _inactive.time==_inactiveTime,
            "Recharming only the copy altered the previously uncharmed source")
        scrNTTEFullParrotCharmTimers()
        assert(_reactivated.time==5-timescale && !_inactive.charmed && _inactive.time==_inactiveTime,
            "Registered reactivated-copy timer changed its inactive source")
        ++_checks
    }
    finally {
        scrNTTEFullVanillaFixtureEnd(_fixture)
        for(var _i=0;_i<array_length(_outlines);++_i) instance_activate_object(_outlines[_i])
    }
    scrNTTESmokeLog("PASS CRYSTAL CLONE OPTIONAL STATE actual EndStep undefined/numeric/bool appearance and registered independent charm timer checks="+string(_checks)+" @"+string(30/timescale))
}
function scrNTTEFullEntanglerNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),_frame=current_frame,_seed=random_get_seed(),_skills=ds_list_create(),
        _zero=0,_epsilonCheck=0.00001
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _owner=instance_find(Player,0)
        _owner.x=47200;_owner.y=47200;_owner.xprevious=_owner.x;_owner.yprevious=_owner.y
        _owner.wep=wep_ntte_entangler;_owner.bwep=wep_none;_owner.ntte_state=scrNTTENewState(_owner.wep)
        _owner.ntte_red_ammo=3;_owner.can_shoot=true;_owner.reload=0;_owner.reloadspeed=1
        _owner.wepangle=120;_owner.wepflip=-1;_owner.gunangle=0;_owner.wkick=0;_owner.speed=0
        _owner.specfiring=false;_owner.race=Race.Fish;_owner.infammo=0;_owner.visible=true
        KeyCont.hold_fire[_owner.index]=true;KeyCont.press_fire[_owner.index]=true
        var _count=instance_number(NTTEFullEntanglerSlash)
        repeat(ceil(15/timescale)) with(_owner) scrNTTEHandleInput(wep,true)
        assert(instance_number(NTTEFullEntanglerSlash)==_count && _owner.ntte_state.chrg_num==15
            && _owner.ntte_red_ammo==3 && _owner.wepangle==120 && _owner.wkick==-4 && _owner.wepflip==1,
            "Entangler held charge lost source fifteen ticks, unchanged angle, negative pullback, full creator flip or exact no-early-ammo behavior")
        var _flash=instance_number(PlasmaTrail)
        with(_owner) scrNTTEHandleInput(wep,true)
        assert(_owner.ntte_state.chrg==2 && instance_number(PlasmaTrail)==_flash,
            "Entangler full charge repeated its transition flash")
        KeyCont.hold_fire[_owner.index]=false;KeyCont.press_fire[_owner.index]=false
        _owner.speed=0
        with(_owner) scrNTTEHandleInput(wep,true)
        var _slashes=scrNTTEFullInstances(NTTEFullEntanglerSlash),_slash=_slashes[array_length(_slashes)-1],
            _lunge=6*timescale+(1-timescale)*_owner.friction/2,
            _lungeX=lengthdir_x(_lunge,_slash.direction),_lungeY=lengthdir_y(_lunge,_slash.direction)
        scrNTTESmokeLog("ENTANGLER RELEASE DIAG "+json_stringify({count:instance_number(NTTEFullEntanglerSlash),expected:_count+1,
            clone:_slash.clone,damage:_slash.damage,sprite:object_get_name(_slash.object_index)+":"+sprite_get_name(_slash.sprite_index),
            mask:sprite_get_name(_slash.mask_index),red:_owner.ntte_red_ammo,kick:_owner.wkick,chrg:_owner.ntte_state.chrg,
            creator:string(_slash.creator),owner:string(_owner),team:_slash.team,ownerteam:_owner.team,
            speed:_slash.speed,ts:timescale,hspeed:_owner.hspeed,vspeed:_owner.vspeed}))
        scrNTTESmokeLog("ENTANGLER RELEASE CONDITIONS "+json_stringify({count:instance_number(NTTEFullEntanglerSlash)==_count+1,
            clone:_slash.clone,damage:_slash.damage==200,sprite:_slash.sprite_index==scrNTTERefSprite("RedMegaSlash"),
            mask:_slash.mask_index==mskMegaSlash,red:_owner.ntte_red_ammo==2,kick:_owner.wkick==-5,chrg:_owner.ntte_state.chrg==0,
            creator:_slash.creator==_owner,team:_slash.team==_owner.team,speed:_slash.speed==2*timescale,
            motion:abs(_owner.hspeed-_lungeX)<=0.00001 && abs(_owner.vspeed-_lungeY)<=0.00001,speedDelta:_slash.speed-2*timescale,
            motionDelta:string_format(_owner.hspeed-_lungeX,0,15),motionAbs:string_format(abs(_owner.hspeed-_lungeX),0,15),
            motionActual:string_format(_owner.hspeed,0,15),motionExpected:string_format(_lungeX,0,15),
            lungeDirection:_slash.direction,lungeGunangle:_owner.gunangle,lungeFriction:_owner.friction,
            motionYDelta:string_format(_owner.vspeed-_lungeY,0,15),
            epsilon:string_format(math_get_epsilon(),0,15),zeroStrict:_zero<_epsilonCheck,zeroInclusive:_zero<=_epsilonCheck,
            spriteValue:string(_slash.sprite_index),spriteExpected:string(scrNTTERefSprite("RedMegaSlash")),
            maskValue:string(_slash.mask_index),maskExpected:string(mskMegaSlash)}))
        assert(instance_number(NTTEFullEntanglerSlash)==_count+1 && _slash.clone && _slash.damage==200
            && _slash.sprite_index==scrNTTERefSprite("RedMegaSlash") && _slash.mask_index==mskMegaSlash
            && _owner.ntte_red_ammo==2 && _owner.wkick==-5 && _owner.ntte_state.chrg==0
            && _slash.creator==_owner && _slash.team==_owner.team && _slash.speed==2*timescale
            && abs(_owner.hspeed-_lungeX)<=0.00001 && abs(_owner.vspeed-_lungeY)<=0.00001,
            "Entangler real full release lost original mega slash/cost1/ownership/forward lunge/kick/reset")
        _owner.can_shoot=true;_owner.reload=0;_owner.wepangle=120;_owner.speed=0
        GameCont.ntte_full_native_skill_counts[$ string(mut_long_arms)]=2;ds_list_add(_skills,mut_long_arms)
        KeyCont.hold_fire[_owner.index]=true
        with(_owner) scrNTTEHandleInput(wep,true)
        KeyCont.hold_fire[_owner.index]=false
        with(_owner) scrNTTEHandleInput(wep,true)
        _slashes=scrNTTEFullInstances(NTTEFullEntanglerSlash);_slash=_slashes[array_length(_slashes)-1]
        assert(!_slash.clone && _slash.damage==20 && _slash.sprite_index==scrNTTERefSprite("RedHeavySlash")
            && _slash.mask_index==mskSlash && _slash.x==_owner.x+40 && _slash.speed==8*timescale
            && _owner.ntte_red_ammo==2 && _owner.wkick==-4,
            "Entangler partial release lost source heavy slash20, Long Arms offset/speed or spent red ammo")
        _owner.infammo=1;_owner.ntte_state.charge=15
        scrNTTEFullRedWeaponState(_owner.ntte_state);_owner.ntte_state.chrg=-1
        with(_owner) scrFire(wep,false,true)
        assert(_owner.ntte_red_ammo==1,"Ordinary infinite-ammo mode incorrectly waived Entangler's separate red charge")
        _owner.ntte_state.charge=15
        scrNTTEFullRedWeaponState(_owner.ntte_state);_owner.ntte_state.chrg=2;_owner.wepflip=1
        with(_owner) scrNTTEFullRedWeaponReloaded(true)
        assert(_owner.wepflip==-1,"Entangler actual native reload dispatcher failed charging flip")
        _owner.ntte_state.charge=0
        with(_owner) scrNTTEFullRedWeaponReloaded(true)
        assert(_owner.wepflip==-1,"Entangler ordinary reload incorrectly applied native sprite flip")
        assert(scrNTTEFullWeaponSwapSound(wep_ntte_entangler)==sndSwapSword,"Entangler swap did not return source sword sound")
        var _clone=noone
        with(_owner) _clone=scrNTTEFullEntanglerEat()
        assert(instance_exists(_clone) && _clone.clone==_owner && _clone.creator==_owner && _clone.team==_owner.team,
            "Entangler eat effect failed real self-clone controller")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_keys)
        current_frame=_frame;random_set_seed(_seed);ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL ENTANGLER NATIVE: actual input/charge15/negative pullback/unchanged angle/full flip, source real mega200+clone/cost1, partial20/Long Arms, separate red resource/reload/swap/eat OK @"+string(30/timescale))
}
function scrNTTEFullCrystalCloneNativeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _owner=instance_find(Player,0),_source=instance_create(48000,48000,Bandit)
        _source.hp=11;_source.team=team_enemy;_source.intro=true;_source.speed=0;_source.canmelee=true
        _source.alarm[0]=44;_source.ntte_clone_payload={nested:{value:7},outer:3};_source.ntte_clone_array=[_source.ntte_clone_payload.nested,9]
        with(_source) ntte_clone_method=function() {return id;}
        var _c=instance_create(_source.x,_source.y,NTTEFullCrystalClone)
        _c.clone=_source;_c.creator=_owner;_c.team=3;_c.budge=false
        with(_c) event_perform(ev_step,ev_step_normal)
        var _copy=_c.target
        scrNTTESmokeLog("CRYSTAL COPY DIAG "+json_stringify({exists:instance_exists(_copy),same:_copy==_source,
            object:instance_exists(_copy)?object_get_name(_copy.object_index):"missing",hp:scrNTTEFullValue(_copy,"hp",undefined),
            team:scrNTTEFullValue(_copy,"team",undefined),raddrop:scrNTTEFullValue(_copy,"raddrop",undefined),
            kill:scrNTTEFullValue(_copy,"givekill",undefined),seed:scrNTTEFullValue(_copy,"dropseed",undefined),
            melee:scrNTTEFullValue(_copy,"canmelee",undefined),alarm11:instance_exists(_copy)?_copy.alarm[11]:-99,
            alarm0:instance_exists(_copy)?_copy.alarm[0]:-99,distance:instance_exists(_copy)?point_distance(_source.x,_source.y,_copy.x,_copy.y):-99,
            copyx:scrNTTEFullValue(_copy,"x",undefined),copyy:scrNTTEFullValue(_copy,"y",undefined),sourcex:_source.x,sourcey:_source.y}))
        assert(instance_exists(_copy) && _copy!=_source && _copy.object_index==Bandit
            && _copy.hp==6 && _copy.team==3 && _copy.raddrop==0 && !_copy.givekill && _copy.dropseed==-1
            && !_copy.canmelee && _copy.alarm[11]==30 && _copy.alarm[0]==44
            && abs(point_distance(_source.x,_source.y,_copy.x,_copy.y)-1)<0.01,
            "CrystalClone did not copy actual native class/state/alarms, weaken hostile HP, disable contact, suppress kill/drop or nudge one pixel")
        scrNTTESmokeLog("CRYSTAL CONTAINER DIAG "+json_stringify({sourceMethod:is_method(_source.ntte_clone_method),
            copyMethod:is_method(_copy.ntte_clone_method),sourceMethodStruct:is_struct(_source.ntte_clone_method),
            copyMethodStruct:is_struct(_copy.ntte_clone_method),sourceBound:string(method_get_self(_source.ntte_clone_method)),
            copyBound:is_method(_copy.ntte_clone_method)?string(method_get_self(_copy.ntte_clone_method)):"not method",
            source:string(_source),copy:string(_copy),payloadDistinct:_copy.ntte_clone_payload!=_source.ntte_clone_payload,
            nestedShared:_copy.ntte_clone_payload.nested==_source.ntte_clone_payload.nested,
            arrayNestedShared:_copy.ntte_clone_array[0]==_source.ntte_clone_array[0]}))
        var _cloneMethod=_copy.ntte_clone_method
        assert(is_method(_cloneMethod),"CrystalClone copied a source-bound method as a non-callable container")
        assert(_copy.ntte_clone_payload!=_source.ntte_clone_payload
            && _copy.ntte_clone_payload.nested==_source.ntte_clone_payload.nested
            && _copy.ntte_clone_array[0]==_source.ntte_clone_array[0]
            && _cloneMethod()==_copy,
            "CrystalClone lost original top-level-only container duplication or native instance-method rebinding")
        _copy.ntte_clone_payload.outer=99
        assert(_source.ntte_clone_payload.outer==3,"CrystalClone top-level struct leaked back into original")
        var _allyc=instance_create(_source.x,_source.y,NTTEFullCrystalClone)
        _allyc.clone=_source;_allyc.creator=_owner;_allyc.team=2;_allyc.budge=false
        with(_allyc) event_perform(ev_step,ev_step_normal)
        var _friendly=_allyc.target
        assert(_friendly.object_index==Bandit && _friendly.hp==11 && _friendly.team==2 && _friendly.ntte_charmed
            && _friendly.ntte_charm.kill && _friendly.ntte_charm.time==451 && _friendly.ntte_charm.index==_owner.index,
            "CrystalClone allied native enemy lost source full health/actual charm/lifetime+1/kill/index")
        _friendly.xprevious=_friendly.x-3;_friendly.yprevious=_friendly.y-2;_friendly.speed=4*timescale
        _friendly.hp=1;_allyc.appear=0.5;_allyc.appear_health=8
        with(_allyc) event_perform(ev_step,ev_step_end)
        scrNTTESmokeLog("CRYSTAL APPEAR CONDITIONS "+json_stringify({hidden:!_friendly.visible,hp:_friendly.hp==8,
            stopped:_friendly.speed==0,x:_friendly.x==_friendly.xprevious,y:_friendly.y==_friendly.yprevious,
            appear:abs(_allyc.appear-(0.5-timescale/24))<=0.00001,actualHP:_friendly.hp,actualSpeed:_friendly.speed,
            appearDelta:string_format(_allyc.appear-(0.5-timescale/24),0,15),
            actualAppear:string_format(_allyc.appear,0,15),expectedAppear:string_format(0.5-timescale/24,0,15)}))
        assert(!_friendly.visible && _friendly.hp==8 && _friendly.speed==0 && _friendly.x==_friendly.xprevious
            && _friendly.y==_friendly.yprevious && abs(_allyc.appear-(0.5-timescale/24))<=0.00001,
            "CrystalClone appearing EndStep lost native enemy freeze/invisibility/HP lock or timescale")
        _allyc.appear=timescale/48
        with(_allyc) event_perform(ev_step,ev_step_end)
        assert(_friendly.visible,"CrystalClone target did not become visible when appearing completed")
        _allyc.time=timescale/2
        with(_allyc) event_perform(ev_step,ev_step_end)
        assert(_friendly.hp==0 && _allyc.time==0,"CrystalClone real enemy timer did not kill actual native HP")
        _copy.hp=6
        instance_destroy(_c)
        assert(instance_exists(_copy) && _copy.hp==6,"Destroying a CrystalClone controller incorrectly killed its target immediately")
        // Source selection uses strict <256, existing same-team target wrappers
        // and the original intro/team/size/mask exclusions.
        var _near=instance_create(49008,49000,Bandit),_far=instance_create(49020,49000,Bandit),
            _ignored=instance_create(49002,49000,Bandit),_select=instance_create(49000,49000,NTTEFullCrystalClone)
        _near.intro=true;_far.intro=true;_ignored.intro=false
        _select.clone=[_near,_far,_ignored];_select.team=2;_select.budge=false
        var _wrap=instance_create(_near.x,_near.y,NTTEFullCrystalClone)
        _wrap.target=_near;_wrap.team=2
        // Explicit source lists intentionally bypass default candidate filters.
        _select.clone=[_near,_far]
        with(_select) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_select.target) && point_distance(_select.target.x,_select.target.y,_far.x,_far.y)<=1.01,
            "CrystalClone same-team original-source wrapper did not exclude a selected source")
        var _defaults=instance_create(49000,49000,NTTEFullCrystalClone)
        assert(array_get_index(_defaults.clone,_near)>=0 && array_get_index(_defaults.clone,_ignored)<0,
            "CrystalClone default enemy candidate list changed intro exclusion")
        _defaults.clone=[]
        with(_defaults) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_defaults),"Empty CrystalClone did not destroy itself on failed search")
        var _bound=instance_create(50000,50000,NTTEFullCrystalClone),_distant=instance_create(50256,50000,Bandit)
        _bound.clone=_distant
        with(_bound) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_bound),"CrystalClone included the source's excluded exact distance256 boundary")
        // Mega slash duplicates a defeated enemy with its pre-hit HP, while
        // maintaining a real independently controlled ally.
        var _slash=instance_create(51000,51000,NTTEFullEntanglerSlash),_victim=instance_create(51000,51000,Bandit)
        _slash.clone=true;_slash.damage=200;_slash.team=2;_slash.creator=_owner
        _victim.hp=17;_victim.team=team_enemy;_victim.nexthurt=0
        var _controllers=instance_number(NTTEFullCrystalClone)
        with(_victim) with(_slash) event_perform(ev_collision,hitme)
        assert(_victim.hp<=0 && instance_number(NTTEFullCrystalClone)==_controllers+1,
            "Real Entangler mega collision failed native lethal damage plus CrystalClone creation")
        var _revived=noone
        with(NTTEFullCrystalClone) if(target!=_victim && instance_exists(target) && target.object_index==Bandit
            && target.hp==17 && appear_health==17 && appear==2/3) {_revived=id;break}
        assert(instance_exists(_revived) && _revived.target.team==2 && _revived.target.ntte_charmed,
            "Entangler killed-enemy clone lost pre-hit HP/appearance lock or actual friendly AI")
        var _bullet=instance_create(_slash.x,_slash.y,Bullet1)
        _bullet.creator=_owner;_bullet.team=team_enemy;_bullet.typ=1;_bullet.speed=5*timescale;_bullet.direction=180
        _slash.direction=0;_controllers=instance_number(NTTEFullCrystalClone)
        with(_bullet) with(_slash) event_perform(ev_collision,projectile)
        assert(instance_number(NTTEFullCrystalClone)==_controllers+2 && _bullet.team==2 && _bullet.deflected,
            "Entangler genuine deflection did not create source+copy paired CrystalClone controllers")
        var _pair=noone
        with(NTTEFullCrystalClone) if(target==_bullet) {_pair=id;break}
        assert(instance_exists(_pair) && _pair.appear==2/3,"Entangler original deflected bullet lacks paired appearance")
        // Native pickups have no shared Pickup parent in Epsilon. The scoped
        // adapter still clones only actual mskPickup items, once per original.
        var _pickup=instance_create(_slash.x,_slash.y,HPPickup)
        _pickup.speed=0;_pickup.mask_index=mskPickup
        _slash.mask_index=mskMegaSlash;_slash.sprite_index=scrNTTERefSprite("RedMegaSlash")
        _controllers=instance_number(NTTEFullCrystalClone)
        with(_slash) event_perform(ev_step,ev_step_end)
        assert(instance_number(NTTEFullCrystalClone)>=_controllers+2 && scrNTTEFullCrystalCloneHasTarget(_pickup),
            "Entangler actual pickup overlap failed paired source/copy split")
        _controllers=instance_number(NTTEFullCrystalClone)
        with(_slash) event_perform(ev_step,ev_step_end)
        assert(instance_number(NTTEFullCrystalClone)==_controllers,"Entangler cloned a pickup again despite existing target wrapper")
        // Player Easter egg must be a real native Ally carrying a physically
        // independent weapon. Its owned AllyBullet is replaced by actual fire.
        _owner.wep=wep_revolver;_owner.ntte_state=scrNTTENewState(_owner.wep);_owner.x=52000;_owner.y=52000
        var _playerc=instance_create(_owner.x,_owner.y,NTTEFullCrystalClone)
        _playerc.clone=_owner;_playerc.team=2;_playerc.creator=_owner;_playerc.budge=false
        with(_playerc) event_perform(ev_step,ev_step_normal)
        var _ally=_playerc.target,_fire=noone
        with(NTTEFullCrystalFireWeapon) if(creator==_ally) {_fire=id;break}
        assert(instance_is(_ally,Ally) && _ally.object_index==NTTEFullCrystalAlly && _ally.creator==_owner
            && _ally.max_hp==_owner.max_hp && _ally.hp==_owner.max_hp && _ally.spr_idle==_owner.spr_idle
            && _ally.alarm[2]==-1 && !_ally.setup && instance_exists(_fire)
            && _ally.ntte_state!=_owner.ntte_state,
            "Player CrystalClone failed actual Ally/copied body/HP/no-bleed/independent physical weapon controller")
        with(_fire) event_perform(ev_step,ev_step_normal)
        var _alarmtarget=instance_create(_ally.x+64,_ally.y,Bandit),_nativebullet=noone
        _alarmtarget.team=team_enemy
        repeat(16) {
            with(_ally) event_perform(ev_alarm,1)
            with(AllyBullet) if(scrNTTEFullValue(id,"creator",noone)==_ally) {_nativebullet=id;break}
            if(instance_exists(_nativebullet)) break
        }
        assert(instance_exists(_nativebullet),"Real cloned Ally Alarm1 never tagged its genuine native AllyBullet with the scoped creator")
        with(_fire) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_nativebullet),"Cloned Ally native Alarm1 shot was not replaced by its physical weapon")
        _ally.alarm[1]=8;_ally.gunangle=0;_ally.speed=0
        var _allybullet=instance_create(_ally.x,_ally.y,AllyBullet)
        _allybullet.creator=_ally;_allybullet.team=_ally.team;_allybullet.direction=0
        var _bullets=instance_number(Bullet1)
        with(_fire) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_allybullet) && instance_number(Bullet1)==_bullets+1 && _ally.alarm[1]==scr_weapon_get_load(wep_revolver),
            "Player clone FireWeapon did not replace an actual owned AllyBullet with native Revolver fire/reload")
        var _owned=false
        with(Bullet1) if(creator==_ally && team==2) _owned=true
        assert(_owned,"Player clone actual weapon shot lost Ally ownership/team")
        var _posx=_ally.x,_posy=_ally.y
        instance_destroy(_ally,false)
        with(_fire) event_perform(ev_step,ev_step_normal)
        var _dropped=false
        with(WepPickup) if(wep==wep_revolver && x==_posx && y==_posy && ammo) _dropped=true
        assert(!instance_exists(_fire) && _dropped,"Dead Player clone failed original weapon drop/controller termination")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
    scrNTTESmokeLog("FULL CRYSTAL CLONE NATIVE: real class/shallow container/method/alarms, source hostile weaken/friendly charm, appear freeze/HP lock/timer, selection/wrapper/256 bounds, real lethal revival/projectile+pickup pairs, Player Ally/native weapon replacement/death drop OK @"+string(30/timescale))
}
function scrNTTEFullCrystalCloneDrawTests() {
    var _before=scrNTTEFullInstances(all),_state=scrNTTEFullCoastDrawState(),_vx=view_xview,_vy=view_yview,
        _frame=current_frame,_ts=timescale,_output=-1,_camera=-1
    view_xview=53000;view_yview=53000;current_frame=2
    try {
        _output=surface_create(view_width*2,view_height*2)
        _camera=camera_create_view(view_xview,view_yview,view_width,view_height,0,noone,-1,-1,-1,-1)
        var _probe=instance_create(view_xview+32,view_yview+32,NTTEFullCrystalCloneDrawProbe),
            _clone=instance_create(_probe.x,_probe.y,NTTEFullCrystalClone)
        _probe.visible=false;_probe.image_xscale=-1;_probe.mask_index=mskPickup
        _clone.target=_probe;_clone.team=2;_clone.appear=0.5;_clone.time=450
        with(_clone) {scrNTTEFullCrystalCloneSprites();event_perform(ev_step,ev_step_end)}
        gpu_push_state();surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(c_black,0)
        var _prior=surface_get_target(),_mask=_probe.mask_index,_xs=_probe.image_xscale
        with(_clone) event_perform(ev_draw,0)
        scrNTTESmokeLog("CRYSTAL DRAW DIAG "+json_stringify({target:surface_get_target(),expected:_prior,ts:timescale,expectedts:_ts,
            visible:_probe.visible,mask:string(_probe.mask_index),expectedmask:string(_mask),xscale:_probe.image_xscale,expectedxscale:_xs,
            calls:_probe.ntte_draw_calls,registered:scrNTTEFullCoastObjectHasDraw(_probe.object_index),clonevisible:_clone.visible,
            bbox:[_clone.bbox_left,_clone.bbox_top,_clone.bbox_right,_clone.bbox_bottom],pos:[_clone.x,_clone.y],
            view:[view_xview,view_yview,view_width,view_height],surface:surface_exists(_clone.ntte_clone_surface),appear:_clone.appear}))
        assert(surface_get_target()==_prior && timescale==_ts && !_probe.visible && _probe.mask_index==_mask
            && _probe.image_xscale==_xs && _probe.ntte_draw_calls==1,
            "CrystalClone real Draw failed target/matrix/time/visibility/mask restoration or actual object Draw dispatch")
        surface_reset_target();gpu_pop_state()
        var _pixels=0,_center=0
        for(var _x=48;_x<80;++_x) for(var _y=48;_y<80;++_y) {
            var _pixel=surface_getpixel_ext(_output,_x,_y)
            if(((_pixel >> 24) & 255)>0) {_pixels+=1}
        }
        assert(_pixels>0 && _pixels<1024,"CrystalClone appearance capture failed real nonempty partially cut alpha pixels")
        // Finished overlay must render once for a matching group, and use
        // actual Draws for both actors while preserving normally visible ones.
        var _probe2=instance_create(_probe.x+20,_probe.y,NTTEFullCrystalCloneDrawProbe),
            _clone2=instance_create(_probe2.x,_probe2.y,NTTEFullCrystalClone)
        _clone.appear=0;_clone.time=450;_probe.visible=true
        _clone2.target=_probe2;_clone2.team=2;_clone2.appear=0;_clone2.time=450
        with(_clone2) {scrNTTEFullCrystalCloneSprites();event_perform(ev_step,ev_step_end)}
        _clone2.depth=_clone.depth
        var _calls=_probe.ntte_draw_calls
        surface_set_target(_output);camera_apply(_camera);draw_clear_alpha(c_black,0)
        with(_clone) event_perform(ev_draw,0)
        with(_clone2) event_perform(ev_draw,0)
        surface_reset_target()
        assert(_probe.ntte_draw_calls==_calls+1 && _probe2.ntte_draw_calls==1 && _probe.visible && _probe2.visible,
            "CrystalClone finished overlay group repeated actual Draw or hid a visible native target")
    }
    finally {
        if(surface_get_target()==_output) surface_reset_target()
        if(surface_exists(_output)) surface_free(_output)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_state.world);matrix_set(matrix_view,_state.view);matrix_set(matrix_projection,_state.projection)
        draw_set_color(_state.color);draw_set_alpha(_state.alpha);timescale=_ts
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        view_xview=_vx;view_yview=_vy;current_frame=_frame
    }
    scrNTTESmokeLog("FULL CRYSTAL CLONE DRAW: real actual Draw dispatch, two-times-resolution capture/wavy alpha/tiled RGB, finished grouped overlay and target/time/mask/visibility restoration OK @"+string(30/timescale))
}
