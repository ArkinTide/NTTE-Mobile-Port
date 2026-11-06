function scrNTTEFullPizzaWeaponNativeTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.area=1;GameCont.underwater=false
    current_frame=2;UberCont.opt_prtcls=true
    try {
        var _p=instance_find(Player,0)
        // Keep native float32 instance coordinates below the precision limit
        // of the .001 geometry assertions while remaining clear of the room.
        _p.x=4000;_p.y=4000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.wep=wep_ntte_pizza_cutter;_p.bwep=wep_none;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.gunangle=0;_p.wepangle=120;_p.wepflip=-1;_p.wkick=0;_p.accuracy=0
        _p.can_shoot=true;_p.reload=0;_p.reloadspeed=1;_p.specfiring=false;_p.visible=true
        _p.race=Race.Fish;_p.infammo=0;_p.hspeed=2*timescale;_p.vspeed=-timescale
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        var _slashes=instance_number(Slash),_discs=instance_number(NTTEFullBatDisc),_trails=instance_number(DiscTrail)
        repeat(ceil(9/timescale)) with(_p) scrNTTEHandleInput(wep,true)
        var _state=_p.ntte_state,_flash=noone
        with(DiscTrail) if(sprite_index==scrNTTERefSprite("BigDiscTrail") && array_get_index(_before,id)<0) _flash=id
        var _d=_p.gunangle+_p.wepangle*(1-_p.wkick/20),_lx=18-_p.wkick,_ly=2*_p.wepflip
        assert(_state.chrg_num==9 && _state.chrg_max==9 && _state.ammo==1 && _state.outstanding==0
            && _p.wepangle==120 && _p.wkick==-3 && instance_number(Slash)==_slashes
            && instance_number(NTTEFullBatDisc)==_discs && instance_number(DiscTrail)==_trails+1,
            "Pizza held input lost exact charge9/negative pullback/unchanged angle or fired prematurely")
        scrNTTESmokeLog("PIZZA FULL FLASH DIAG "+json_stringify({exists:instance_exists(_flash),
            imageSpeed:_flash.image_speed,expectedSpeed:0.4*timescale,depth:_flash.depth,expectedDepth:_p.depth-1,
            x:_flash.x,y:_flash.y,expectedX:_p.x+_p.hspeed+lengthdir_x(_lx,_d)+lengthdir_x(_ly,_d-90),
            expectedY:_p.y+_p.vspeed+lengthdir_y(_lx,_d)+lengthdir_y(_ly,_d-90),
            dx:_flash.x-(_p.x+_p.hspeed+lengthdir_x(_lx,_d)+lengthdir_x(_ly,_d-90)),
            dy:_flash.y-(_p.y+_p.vspeed+lengthdir_y(_lx,_d)+lengthdir_y(_ly,_d-90)),
            ownerFlip:_p.wepflip,gunangle:_p.gunangle,wepangle:_p.wepangle,angle:_d,lx:_lx,ly:_ly,
            rawHspeed:_p.hspeed,rawVspeed:_p.vspeed,ts:timescale}))
        assert(instance_exists(_flash) && _flash.image_speed==0.4*timescale && _flash.depth==_p.depth-1
            && abs(_flash.x-(_p.x+_p.hspeed+lengthdir_x(_lx,_d)+lengthdir_x(_ly,_d-90)))<0.001
            && abs(_flash.y-(_p.y+_p.vspeed+lengthdir_y(_lx,_d)+lengthdir_y(_ly,_d-90)))<0.001,
            "Pizza full transition lost real BigDiscTrail, actual creator flip/raw velocity offsets or native animation scale")
        with(_p) scrNTTEHandleInput(wep,true)
        assert(_state.chrg==2 && instance_number(DiscTrail)==_trails+1,"Pizza full held state repeated the one-time charge transition")
        KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false;_p.speed=0
        with(_p) scrNTTEHandleInput(wep,true)
        var _shots=scrNTTEFullMergedRuntimeNew(_before),_slashlist=scrNTTEFullMergedRuntimeTestShots(_shots,Slash),
            _disclist=scrNTTEFullMergedRuntimeTestShots(_shots,NTTEFullBatDisc),_slash=_slashlist[array_length(_slashlist)-1],
            _disc=_disclist[array_length(_disclist)-1],_lunge=3.5*timescale+(1-timescale)*_p.friction/2
        scrNTTESmokeLog("PIZZA FULL RELEASE DIAG "+json_stringify({slashes:array_length(_slashlist),discs:array_length(_disclist),
            damage:_slash.damage,nativeForce:_slash.knockback_speed,speed:_slash.speed,sprite:sprite_get_name(_slash.sprite_index),
            ammo:_state.ammo,outstanding:_state.outstanding,charge:_state.charge,kick:_p.wkick,
            hspeed:_p.hspeed,expected:_lunge,discstate:_disc.state==_state}))
        assert(array_length(_slashlist)==1 && array_length(_disclist)==1 && _slash.object_index==Slash
            && _slash.sprite_index==sprHeavySlash && _slash.damage==20 && _slash.speed==3*timescale
            && _slash.creator==_p && _slash.team==_p.team && _disc.creator==_p && _disc.state==_state
            && _disc.wep==_state && _disc.ammo==1 && _disc.refund==1 && _disc.primary
            && _state.ammo==0 && _state.outstanding==1 && _state.charge==0 && _state.chrg==0 && _p.wkick==8
            && abs(_p.hspeed-lengthdir_x(_lunge,_slash.direction))<0.001
            && abs(_p.vspeed-lengthdir_y(_lunge,_slash.direction))<0.001,
            "Pizza full release lost actual Slash20/BatDisc, ownership, source lunge/post or exact physical magazine1")
        // Empty physical magazine is marked during the real Player custom Step;
        // that branch emits original cooling smoke and enables the 8-damage jab.
        var _smoke=instance_number(Smoke)
        with(_p) scrNTTEPlayerStep()
        assert(!_state.loaded && instance_number(Smoke)==_smoke+1,
            "Pizza actual Player Step omitted empty-magazine canload transition or source smoke")
        var _handled=true
        with(_p) _handled=scrNTTEHandleInput(wep,true)
        assert(!_handled,"Pizza empty blade suppressed normal native fire input")
        _p.can_shoot=true;_p.reload=0
        with(_p) scrFire(wep,false)
        _slashlist=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Slash)
        _slash=_slashlist[array_length(_slashlist)-1]
        assert(_slash.damage==8 && _slash.force==6 && _slash.knockback_speed==6*timescale && _slash.sprite_index==sprSlash && _p.wkick==-4
            && instance_number(NTTEFullBatDisc)==_discs+1 && _state.ammo==0 && _state.outstanding==1,
            "Pizza discless release lost original Slash8/force6/post or duplicated its outstanding blade")
        instance_destroy(_disc)
        with(_p) scrNTTEPlayerStep()
        assert(_state.ammo==1 && _state.outstanding==0 && _state.loaded,
            "Pizza actual BatDisc cleanup and next native Step did not restore same physical magazine")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // A partial hold is already a heavy slash. It does not spend the disc.
        GameCont.ntte_full_native_skill_counts[$ string(mut_long_arms)]=2;ds_list_add(_skills,mut_long_arms)
        _p.can_shoot=true;_p.reload=0;_p.speed=0;_p.wepangle=120
        KeyCont.hold_fire[_p.index]=true
        with(_p) scrNTTEHandleInput(wep,true)
        KeyCont.hold_fire[_p.index]=false
        with(_p) scrNTTEHandleInput(wep,true)
        _slashlist=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Slash);_slash=_slashlist[0]
        assert(array_length(_slashlist)==1 && _slash.damage==20 && _slash.sprite_index==sprHeavySlash
            && _slash.speed==7*timescale && abs(_slash.x-(_p.x+40+7*(1-timescale)))<0.001
            && instance_number(NTTEFullBatDisc)==_discs && _state.ammo==1 && _state.outstanding==0 && _p.wkick==-4,
            "Pizza partial release lost Long Arms source position/speed/heavy20 or incorrectly launched/spent disc")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // Direct native firing enters the genuine two-phase FireCharge path;
        // the release uses captured direction after the owner moves/rotates.
        _p.can_shoot=true;_p.reload=0;_p.gunangle=35;_p.wepangle=120
        with(_p) scrFire(wep,false)
        var _controllers=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullRedFireCharge),
            _controller=_controllers[0]
        assert(array_length(_controllers)==1 && _controller.wep==_state && _state.chrg_num==timescale
            && _p.wepangle==120 && instance_number(Slash)==_slashes,
            "Pizza direct native scrFire failed actual source charge controller or flipped melee while charging")
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_controller) && _controller.fire && instance_number(Slash)==_slashes,
            "Pizza first actual FireCharge Step fired instead of arming")
        _p.x+=12;_p.y+=9;_p.gunangle=90
        with(_controller) event_perform(ev_step,ev_step_normal)
        _slashlist=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Slash);_slash=_slashlist[0]
        assert(!instance_exists(_controller) && array_length(_slashlist)==1 && _slash.damage==20
            && abs(angle_difference(_slash.direction,35))<0.001 && _state.chrg==0 && _state.charge==0,
            "Pizza two-phase actual controller release lost captured direction, partial heavy or reset")
        // Source Back Muscle grows by exactly one and becomes chargeable as
        // soon as any blade returns; no launcher-style full-capacity wait.
        GameCont.ntte_full_native_skill_counts[$ string(mut_back_muscle)]=1;ds_list_add(_skills,mut_back_muscle)
        _state.ammo=0;_state.loaded=false
        with(_p) scrNTTEPlayerStep()
        assert(_state.capacity==2 && _state.ammo==1 && _state.loaded,
            "Pizza inherited Back Muscle did not add the original one disc or incorrectly waited for full capacity")
        GameCont.ntte_full_native_skill_counts[$ string(mut_back_muscle)]=0;ds_list_delete(_skills,ds_list_find_index(_skills,mut_back_muscle))
        with(_p) scrNTTEPlayerStep()
        assert(_state.capacity==1 && _state.ammo==1,"Pizza buff removal did not preserve original source ammo arithmetic")
        _state.chrg=1;_state.charge=timescale;_state.chrg_num=timescale;_p.wepflip=1
        with(_p) scrNTTEFullRedWeaponReloaded(true)
        assert(_p.wepflip==-1,"Pizza ordinary native reload callback failed charging flip")
        _state.chrg=0;_state.charge=0;_state.chrg_num=0
        with(_p) scrNTTEFullRedWeaponReloaded(true)
        assert(_p.wepflip==-1,"Pizza released native reload incorrectly flipped weapon instead of source sound")
        // Steroids' real swap exposes the secondary physical state to the same
        // input path and binds a non-primary disc to that exact state.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.race=Race.Steroids;_p.wep=wep_revolver;_p.ntte_state=scrNTTENewState(_p.wep)
        _p.bwep=wep_ntte_pizza_cutter;_p.bntte_state=scrNTTENewState(_p.bwep);_p.bcan_shoot=true;_p.breload=0
        var _secondary=_p.bntte_state
        with(_p) scrSwapWeps(false)
        KeyCont.hold_spec[_p.index]=true
        repeat(ceil(9/timescale)) with(_p) scrNTTEHandleInput(wep,false)
        KeyCont.hold_spec[_p.index]=false
        with(_p) {scrNTTEHandleInput(wep,false);scrSwapWeps(false)}
        _disclist=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullBatDisc)
        assert(array_length(_disclist)==1 && !_disclist[0].primary && _disclist[0].state==_secondary
            && _secondary.ammo==0 && _p.bntte_state==_secondary && _p.wep==wep_revolver && _p.bwep==wep_ntte_pizza_cutter,
            "Pizza Steroids secondary actual slot swap lost primary flag or physical magazine identity")
        scrNTTESmokeLog("PASS Pizza actual native input9/full flash/partial20/discless8force6/Long Arms, real FireCharge two-phase and Slash/BatDisc, exact magazine refund/BackMuscle/secondary/reload")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
}
function scrNTTEFullPizzaWeaponMergedTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont),
        _seed=random_get_seed(),_frame=current_frame,_skills=ds_list_create()
    scrNTTEFullWeaponNativeInit()
    var _models=scrNTTEFullArrayCopy(global.ntte_full_native_weapon_models)
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=95000;_p.y=95000;_p.xprevious=_p.x;_p.yprevious=_p.y;_p.speed=0
        _p.gunangle=0;_p.wepangle=120;_p.wepflip=1;_p.wkick=0;_p.accuracy=0;_p.race=Race.Fish
        _p.can_shoot=true;_p.reload=0;_p.reloadspeed=1;_p.specfiring=false;_p.visible=true;_p.infammo=0
        _p.bwep=wep_none;_p.bntte_state=scrNTTENewState(wep_none);_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        GameCont.rad=100;GameCont.temerge_effect_vars_map={}
        // Stock input must release the entire merge through the real public
        // entry, and retain the stock disc's exact canonical physical state.
        var _weapon=scrNTTEFullWeaponMerge(wep_ntte_pizza_cutter,wep_revolver),_handle=scrNTTEFullWeaponNative(_weapon),
            _state=scrNTTEFullWeaponNativeState(_weapon)
        _p.wep=_handle;_p.ntte_state=_state
        KeyCont.hold_fire[_p.index]=true;KeyCont.press_fire[_p.index]=true
        repeat(ceil(9/timescale)) with(_p) scrNTTEHandleInput(wep,true)
        assert(_p.wep==_handle && _p.ntte_state==_state && _state.chrg_num==9 && _state.ammo==1
            && array_length(scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bullet1))==0,
            "Merged Pizza stock input lost canonical state or fired front before release")
        KeyCont.hold_fire[_p.index]=false;KeyCont.press_fire[_p.index]=false
        with(_p) scrNTTEHandleInput(wep,true)
        var _bullets=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Bullet1),
            _discs=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullBatDisc)
        assert(array_length(_bullets)>0 && array_length(_discs)==1 && _discs[0].state==_state
            && _discs[0].creator==_p && _state.ammo==0 && _state.outstanding==1 && _state.charge==0
            && _p.wep==_handle && _p.ntte_state==_state && _state.weapon==_handle,
            "Actual merged Pizza stock release lost genuine retained BatDisc/front shot or physical magazine")
        instance_destroy(_discs[0])
        assert(_state.ammo==1 && _state.outstanding==0,"Merged Pizza stock disc refund reached a replacement state")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        // A charged front uses the same true source charging branch and
        // delayed controller. Full charge is accumulated by actual native fire.
        var _front={wep:wep_ntte_pizza_cutter}
        _weapon=scrNTTEFullWeaponMerge(wep_revolver,_front);_handle=scrNTTEFullWeaponNative(_weapon)
        var _root=scrNTTEFullWeaponNativeState(_weapon)
        _state=scrNTTEFullWeaponNativeState(_front);_p.wep=_handle;_p.ntte_state=_root;_p.wepangle=120
        repeat(ceil(9/timescale)) with(_p) scrFire(wep,true)
        var _controllers=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullRedFireCharge),
            _controller=_controllers[0]
        assert(array_length(_controllers)==1 && _controller.wep==_state && _controller.ntte_merged_state_part==_front
            && _state.chrg_num==9 && _state.ammo==1 && _root.ammo==-1 && _p.ntte_state==_root
            && array_length(scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullBatDisc))==0,
            "Actual Pizza merged front bypassed genuine source charge9 or spent wrong canonical part")
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_controller) && _controller.fire,"Merged Pizza first controller Step failed source arming")
        _p.x+=18;_p.y+=11
        with(_controller) event_perform(ev_step,ev_step_normal)
        _discs=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),NTTEFullBatDisc)
        var _slashes=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedRuntimeNew(_before),Slash)
        assert(!instance_exists(_controller) && array_length(_discs)==1 && array_length(_slashes)==1
            && _discs[0].state==_state && _discs[0].creator==_p && _discs[0].team==_p.team
            && _state.ammo==0 && _state.outstanding==1 && _state.charge==0 && _state.chrg==0
            && array_length(_discs[0].temerge_vars_list)==1 && _p.wep==_handle && _p.ntte_state==_root,
            "Actual Pizza charged front lost native Slash/BatDisc, merge ancestry, creator or independent magazine")
        instance_destroy(_discs[0])
        assert(_state.ammo==1 && _state.outstanding==0 && _root.ammo==-1,
            "Pizza front disc refund contaminated stock physical magazine")
        scrNTTESmokeLog("PASS Pizza actual merged stock input/native front replacement and retained disc, full front charge9/two-phase real release/canonical refund/source effect ancestry")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_keys)
        global.ntte_full_native_weapon_models=_models;random_set_seed(_seed);current_frame=_frame;ds_list_destroy(_skills)
    }
}
