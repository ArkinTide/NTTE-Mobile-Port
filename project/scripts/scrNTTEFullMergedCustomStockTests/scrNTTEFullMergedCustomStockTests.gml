function scrNTTEFullMergedCustomStockTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _initialized=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _mode=variable_global_exists("ntte_merge_native_collision_mode") && global.ntte_merge_native_collision_mode,
        _stack=variable_global_exists("ntte_merge_native_collision_stack")?global.ntte_merge_native_collision_stack:[],
        _frame=current_frame,_seed=random_get_seed(),_walls=ds_list_create()
    ds_list_copy(_walls,global.lis_walls_visible)
    global.ntte_full_merge_effect_registry={};global.ntte_full_merge_effect_initialized=false
    global.ntte_merge_native_collision_mode=true;global.ntte_merge_native_collision_stack=[]
    GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[];GameCont.ntte_harpoon_rope=[]
    current_frame=2
    try {
        scrNTTEFullMergedEffectsInit()
        var _owner=instance_find(Player,0),_a=instance_create(17000,17000,Bandit),_b=instance_create(17050,17000,Bandit),
            _shot=instance_create(17000,17000,Bullet1)
        _shot.team=team_player;_shot.creator=_owner;_shot.damage=4;_shot.speed=0
        _a.team=team_enemy;_a.hp=50;_a.nexthurt=0;_a.speed=0;_a.size=1;_a.solid=false
        _b.team=team_enemy;_b.hp=50;_b.nexthurt=0;_b.speed=0;_b.size=1;_b.solid=false
        scrNTTEFullMergedEffectsCall(_shot,_a,scrNTTEFullMergedHarpoonHit)
        assert(array_length(GameCont.ntte_harpoon_rope)==1,"Harpoon stock hit failed enemy-to-enemy rope creation")
        var _r=GameCont.ntte_harpoon_rope[0]
        assert(_r.link1==_a && _r.link2==_b && _r.length==50 && _r.break_timer>=45 && _r.break_timer<60,
            "Harpoon stock link lost nearest LOS selection, original length or expiry range")
        scrNTTEFullMergedEffectsCall(_shot,_a,scrNTTEFullMergedHarpoonHit)
        assert(array_length(GameCont.ntte_harpoon_rope)==1,"Harpoon stock hit duplicated an existing pair")
        _r.length=20
        with(_r.controller) event_perform(ev_step,ev_step_normal)
        assert(abs(_a.x-17005)<0.0001 && abs(_b.x-17045)<0.0001
            && abs(_a.hspeed-2*timescale)<0.0001 && abs(_b.hspeed+2*timescale)<0.0001,
            "Independent harpoon rope failed source bilateral enemy drag/velocity")
        scrNTTEFullHarpoonUnrope(_r)
        assert(!array_length(GameCont.ntte_harpoon_rope),"Independent rope did not unregister")
        _a.x=17000;_a.y=17000;_b.x=17050;_b.y=17000;_a.hp=4
        scrNTTEFullMergedEffectsCall(_shot,_a,scrNTTEFullMergedHarpoonHit)
        assert(!array_length(GameCont.ntte_harpoon_rope),"Lethal harpoon stock hit incorrectly created a rope")
        _a.hp=50
        var _wall=instance_create(17024,17000,Wall)
        scrNTTEFullMergedEffectsCall(_shot,_a,scrNTTEFullMergedHarpoonHit)
        assert(!array_length(GameCont.ntte_harpoon_rope),"Harpoon stock linked enemies through a wall")
        instance_destroy(_wall,false)

        var _source=instance_create(17500,17000,NTTEFullNetNade),_info={}
        with(_source) scrNTTEFullMergedNetFire({wep:wep_revolver},_info)
        assert(_info.ammo_type==Ammo.Bullets && _source.damage==10 && _source.ntte_net_alarm0==60
            && _source.ntte_net_alarm1==3 && _source.ntte_net_alarm2==45,
            "Real NetNade source lost original constructor or merged front ammo capture")
        _source.ntte_net_alarm1=timescale;_source.ntte_net_alarm2=timescale;_source.speed=8*timescale
        var _trail_count=instance_number(DiscTrail)
        with(_source) event_perform(ev_step,ev_step_normal)
        assert(_source.ntte_net_alarm1<=0 && _source.ntte_net_alarm2<=0
            && _source.friction==0.8*timescale*timescale && _source.sprite_index==scrNTTERefSprite("NetNadeBlink")
            && instance_number(DiscTrail)==_trail_count+1,
            "Net friction/blink alarm callbacks must continue remaining timers and same-frame trail Step")
        var _netshot=instance_create(17500,17000,Bullet1),_victim=instance_create(17500,17000,Bandit)
        _netshot.team=team_player;_netshot.creator=_owner;_netshot.damage=10;_netshot.knockback_speed=4*timescale;_netshot.speed=0
        _victim.team=team_enemy;_victim.hp=60;_victim.nexthurt=0;_victim.speed=0;_victim.solid=false
        scrNTTEFullMergedNetSetup([_netshot],_info)
        scrNTTEFullMergedProjectileAddEvent(_netshot,"hit",scrNTTEFullMergedNetHit)
        scrNTTEFullMergedProjectileAddEvent(_netshot,"destroy",scrNTTEFullMergedNetDestroy)
        var _harpoon_count=instance_number(NTTEFullHarpoon)
        with(_victim) with(_netshot) event_perform(ev_collision,hitme)
        assert(!instance_exists(_netshot) && _victim.hp==50 && instance_number(NTTEFullHarpoon)==_harpoon_count+4,
            "Net stock native hit failed original count or normal bullet damage")
        var _harpoons=scrNTTEFullInstances(NTTEFullHarpoon),_ropes=GameCont.ntte_harpoon_rope
        assert(array_length(_ropes)==4,"Net stock did not attach every emitted harpoon to the actual hit target")
        for(var _i=0;_i<array_length(_harpoons);++_i) if(array_get_index(_before,_harpoons[_i])<0) {
            var _h=_harpoons[_i]
            assert(_h.ammo_type==Ammo.Bullets && !_h.can_temerge && _h.creator==_owner && _h.team==team_player
                && abs(_h.speed-22*timescale)<0.0001 && array_length(_h.rope)==1,
                "Net stock harpoon lost ammo refund type, recursion prevention, owner, motion or rope endpoint")
        }
        var _destroy_vars=scrNTTEFullMergedEffectVars("destroy_event")
        scrNTTEFullMergedEffectsReplayDestroy(_destroy_vars)
        assert(instance_number(NTTEFullHarpoon)==_harpoon_count+4,"Net source hit+destroy released its shared payload twice")
        var _nohit=instance_create(17900,17000,Bullet1)
        _nohit.team=team_player;_nohit.creator=_owner;_nohit.damage=10;_nohit.knockback_speed=4*timescale;_nohit.speed=0
        scrNTTEFullMergedNetSetup([_nohit],_info)
        scrNTTEFullMergedEffectsCall(_nohit,_nohit,scrNTTEFullMergedNetDestroy)
        assert(instance_number(NTTEFullHarpoon)==_harpoon_count+4,"Original Net stock destroy without a hit target should emit FX only")

        // Real harpoon is replaced by an attached stick without losing ropes.
        var _physical=instance_create(18200,17000,NTTEFullHarpoon),_link=instance_create(18250,17000,Bandit)
        _physical.creator=_owner;_physical.team=team_player;_physical.speed=8*timescale
        _link.team=team_enemy;_link.hp=50;_link.nexthurt=0;_link.size=2;_link.solid=false
        var _physical_rope=scrNTTEFullHarpoonRope(_physical,_a)
        var _sticks=scrNTTEFullInstances(NTTEFullHarpoonStick)
        with(_link) with(_physical) event_perform(ev_collision,hitme)
        assert(!instance_exists(_physical) && instance_is(_physical_rope.link1,NTTEFullHarpoonStick)
            && _physical_rope.link1.target==_link && abs(_physical_rope.link1.pull_speed-1)<0.0001,
            "Physical harpoon hit failed source stick transfer or target-size pull scaling")
        var _pickups=instance_number(NTTEFullHarpoonPickup)
        scrNTTEFullHarpoonUnrope(_physical_rope)
        assert(instance_number(NTTEFullHarpoonPickup)==_pickups+1,"Breaking a real attached harpoon rope lost its recoverable ammo pickup")
        var _thrown=instance_create(18500,17000,NTTEAttack)
        _thrown.wep=wep_revolver
        with(_thrown) scrNTTEFullMergedThrownWeaponFire({wep:wep_shotgun})
        assert(!_thrown.temerge_can_delete && scrNTTEFullWeaponRaw(_thrown.wep)==wep_revolver
            && scrNTTEFullWeaponMergedPart(_thrown.wep)==wep_shotgun && _thrown.sprite_index==scr_weapon_get_sprite(_thrown.wep),
            "Thrown physical weapon was deleted or lost its append-front weapon model/sprite")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i) if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_back)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_initialized
        global.ntte_merge_native_collision_mode=_mode;global.ntte_merge_native_collision_stack=_stack
        current_frame=_frame;random_set_seed(_seed)
        ds_list_copy(global.lis_walls_visible,_walls);ds_list_destroy(_walls)
    }
    scrNTTESmokeLog("FULL MERGED CUSTOM STOCK: original bilateral enemy ropes/LOS/dedup, real harpoon stick/refund, net one-shot hit payload/no-target semantics/ammo ownership and preserved thrown merge OK @"+string(30/timescale))
}

// Regression for the reported CoastBoss dive crash. A rope is a controller
// for the source's independent struct; only its attached harpoon ends are bolts.
function scrNTTEFullHarpoonControllerTypeTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_seed=random_get_seed(),_frame=current_frame
    try {
        current_frame=20;GameCont.loops=0;GameCont.ntte_harpoon_rope=[]
        var _owner=instance_find(Player,0),_a=instance_create(19000,19000,Bandit),
            _b=instance_create(19050,19000,Bandit)
        assert(instance_exists(_owner),"Harpoon controller regression requires a real player")
        _a.speed=0;_b.speed=0;_a.size=1;_b.size=1;_a.team=team_enemy;_b.team=team_enemy
        var _rope=scrNTTEFullHarpoonRope(_a,_b),_controller=_rope.controller
        assert(instance_exists(_controller) && !instance_is(_controller,BoltStick)
            && !variable_instance_exists(_controller,"target"),
            "Independent rope controller incorrectly belongs to target-bearing BoltStick family")
        _rope.length=20
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(abs(_a.x-19005)<0.0001 && abs(_b.x-19045)<0.0001
            && abs(_a.hspeed-2*timescale)<0.0001 && abs(_b.hspeed+2*timescale)<0.0001,
            "Removing bolt ancestry changed independent rope bilateral pull")

        var _boss=instance_create(19400,19000,NTTEFullCoastBoss),
            _stick=instance_create(19400,19000,NTTEFullHarpoonStick)
        _stick.target=_boss;_stick.pull_speed=1
        assert(instance_is(_stick,BoltStick),"Actual attached harpoon lost BoltStick ancestry")
        var _attached=scrNTTEFullHarpoonRope(_stick,_a)
        _boss.ntte_coast_timers=[-1,-1,-1,-1];_boss.swim=100;_boss.swim_target=_a
        _boss.swim_mask=mskBigMaggot;_boss.sprite_index=_boss.spr_idle;_boss.speed=0
        _boss.fish_train=[];_boss.fish_swim=[];_boss.fish_swim_delay=100;_boss.right=1
        // Actual Step enumerates BoltStick.target while diving. It must remove
        // the attached end without inspecting the independent controller.
        with(_boss) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_boss) && !instance_exists(_stick) && instance_exists(_controller),
            "CoastBoss dive did not detach real bolts while preserving independent ropes")
        with(_attached.controller) event_perform(ev_step,ev_step_normal)
        assert(_attached.broken==true && !instance_exists(_attached.controller),
            "Rope with destroyed attached endpoint failed normal unrope lifecycle")

        // A second real consumer used the same family scan and would also
        // read the nonexistent target on the misclassified controller.
        _owner.wep=wep_ntte_clam_shield;_owner.bwep=wep_none;_owner.gunangle=90
        var _shield=instance_create(19800,19000,NTTEFullClamShield),
            _bolt=instance_create(19800,19000,NTTEFullHarpoonStick)
        _shield.creator=_owner;_shield.wep=wep_ntte_clam_shield
        _bolt.target=_shield;_bolt.image_angle=0
        with(_shield) scrNTTEFullClamShieldStep()
        assert(instance_exists(_shield) && instance_exists(_bolt) && _bolt.image_angle>0
            && instance_exists(_controller),
            "ClamShield bolt rotation failed or included a targetless rope controller")

        instance_destroy(_a,false)
        with(_controller) event_perform(ev_step,ev_step_normal)
        assert(_rope.broken==true && !instance_exists(_controller)
            && array_length(GameCont.ntte_harpoon_rope)==0,
            "Independent rope did not unregister after an endpoint disappeared")
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        current_frame=_frame;random_set_seed(_seed)
    }
    scrNTTESmokeLog("FULL HARPOON CONTROLLER TYPE: real CoastBoss dive/ClamShield bolt scans, independent bilateral pull and missing endpoint cleanup OK @"+string(30/timescale))
}
