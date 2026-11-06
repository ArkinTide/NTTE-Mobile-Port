function scrNTTEFullBubbleWeaponTestNew(_before,_object) {
    var _all=scrNTTEFullInstances(_object),_out=[]
    for(var _i=0;_i<array_length(_all);++_i)
        if(array_get_index(_before,_all[_i])<0) array_push(_out,_all[_i])
    return _out
}
function scrNTTEFullBubbleWeaponTests() {
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_tick=current_frame,_skills=ds_list_create()
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
    try {
        var _p=instance_find(Player,0)
        _p.x=93000;_p.y=93000;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.gunangle=0;_p.accuracy=0;_p.infammo=0;_p.race=Race.Fish
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.hspeed=0;_p.vspeed=0
        var _weapons=[wep_ntte_bubble_rifle,wep_ntte_bubble_minigun]
        for(var _i=0;_i<2;++_i) {
            scrNTTEFullMergedRuntimeTestCleanup(_before)
            _p.wep=_weapons[_i];_p.ntte_state=scrNTTENewState(_p.wep)
            _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.x=93000;_p.y=93000;_p.gunangle=0
            var _old=scrNTTEFullInstances(all)
            with(_p) scrFire(wep,true)
            var _bombs=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubbleBomb),
                _controllers=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullNativeFireBurst),
                _interval=_i==0?2:1,_total=_i==0?2:3,_cost=_i==0?2:3
            assert(array_length(_bombs)==1 && array_length(_controllers)==1
                && !instance_is(_controllers[0],projectile) && instance_is(_controllers[0],projectileburst)
                && array_length(scrNTTEFullBubbleWeaponTestNew(_old,NTTEAttack))==0,
                "Actual Bubble Rifle/Minigun still uses generic projectile or replaceable burst controller")
            var _controller=_controllers[0],_bomb=_bombs[0]
            assert(_controller.time_max==_interval && _controller.time<=_interval
                && _controller.time>_interval-timescale && _controller.ammo==_total-1 && _controller.burst==1
                && _controller.alarm[0]==-1 && _p.ammo[Ammo.Explosives]==100-_cost,
                "Source FireBurst lost explicit/default interval, first jitter, burst index or single ammo debit")
            assert(_bomb.creator==_p && _bomb.team==_p.team && !_bomb.big
                && (_i==0?abs(_bomb.speed-9*timescale)<0.0001:(_bomb.speed>=10*timescale && _bomb.speed<=12*timescale)),
                "Actual Bubble Rifle/Minigun lost physical bomb class/ownership/source velocity")
            _p.x=93100;_p.y=93200;_p.gunangle=90
            repeat(ceil(5/timescale)) if(instance_exists(_controller)) with(_controller) event_perform(ev_step,ev_step_normal)
            _bombs=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubbleBomb)
            assert(array_length(_bombs)==_total && _p.ammo[Ammo.Explosives]==100-_cost
                && !instance_exists(_controller),"Source FireBurst lost round count, repeated ammo debit or cleanup")
            for(var _b=1;_b<array_length(_bombs);++_b) {
                var _later=_bombs[_b]
                assert(_later.creator==_p && abs(angle_difference(_later.direction,90))<0.0001
                    && abs(_later.x-93100)<0.02 && _later.y<93200,
                    "Deferred Bubble burst used stale owner position/aim or lost actual creator")
            }
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.x=93000;_p.y=93000;_p.gunangle=0;_p.wep=wep_ntte_bubble_shotgun
        _p.ntte_state=scrNTTENewState(_p.wep);_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100)
        var _old=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        var _bombs=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubbleBomb)
        assert(array_length(_bombs)==5 && _p.ammo[Ammo.Explosives]==97 && _p.wkick==6,
            "Actual Bubble Shotgun lost five physical bombs, source cost3 or kick6")
        for(var _i=0;_i<5;++_i) {
            var _bomb=_bombs[_i],_lead=_bomb.speed*(1/timescale-1)
            assert(abs(_bomb.x-_p.x-_lead-(6+_i*8))<0.02 && abs(_bomb.y-_p.y)<0.02
                && _bomb.speed>=9*timescale && _bomb.speed<=10*timescale
                && _bomb.image_speed>=0.46*timescale-0.0001 && _bomb.image_speed<=0.54*timescale+0.0001,
                "Bubble Shotgun lost source ordered contact offsets, logical speed or animation variance")
        }
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.wep=wep_ntte_bubble_cannon;_p.ntte_state=scrNTTENewState(_p.wep);_p.hspeed=0;_p.vspeed=0
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_old=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        _bombs=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubbleBomb)
        var _streaks=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullWaterStreak),
            _pops=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullBubblePop)
        assert(array_length(_bombs)==1 && _bombs[0].big && abs(_bombs[0].speed-9*timescale)<0.0001
            && array_length(_streaks)==3 && _p.ammo[Ammo.Explosives]==96 && _p.wkick==10
            && abs(_p.hspeed+(4*timescale+(1-timescale)*_p.friction/2))<0.0001 && array_length(_pops)==1
            && _pops[0].image_speed==0.25*timescale && _pops[0].image_xscale==1.2,
            "Actual Bubble Cannon lost big physical bomb, three streaks, source recoil/post or muzzle animation")
        for(var _i=0;_i<3;++_i) assert(abs(_streaks[_i].y-_p.y-_streaks[_i].vspeed/timescale)<0.02,
            "Bubble Cannon source WaterStreak logical vertical spawn offset changed with frame rate")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.wep=wep_ntte_hyper_bubbler;_p.ntte_state=scrNTTENewState(_p.wep);_p.hspeed=0;_p.vspeed=0
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_old=scrNTTEFullInstances(all)
        with(_p) scrFire(wep,true)
        var _hypers=scrNTTEFullBubbleWeaponTestNew(_old,NTTEFullHyperBubble),_hyper=_hypers[0]
        assert(array_length(_hypers)==1 && _hyper.speed==0 && _hyper.x==_p.x+20 && _hyper.y==_p.y
            && _hyper.creator==_p && _hyper.hits==3 && _p.ammo[Ammo.Explosives]==97
            && _p.wkick==10 && abs(_p.hspeed+(4*timescale+(1-timescale)*_p.friction/2))<0.0001,
            "Actual Hyper Bubbler retained generic moving beam or lost static20px origin/cost/recoil")
        var _small=instance_number(NTTEFullBubbleExplosionSmall),_large=instance_number(NTTEFullBubbleExplosion),_origin=_hyper.x
        with(_hyper) event_perform(ev_step,ev_step_end)
        assert(!instance_exists(_hyper) && instance_number(NTTEFullBubbleExplosionSmall)==_small+4
            && instance_number(NTTEFullBubbleExplosion)==_large+1,
            "Actual HyperBubble did not complete source hitscan with muzzle/end/unused-hit physical explosions")
        var _last=instance_find(NTTEFullBubbleExplosion,_large)
        scrNTTESmokeLog("HYPER WEAPON END DIAG xy="+string(_last.x)+","+string(_last.y)
            +" source="+string(_origin)+","+string(_p.y)+" creator="+string(_last.creator)+" expected="+string(_p))
        // Genuine PopoExplosion inherits native Explosion's constructor jitter
        // x/y +=orandom(2); hitscan itself still terminates exactly1600 away.
        assert(abs(_last.xstart-(_origin+1600))<0.02 && abs(_last.ystart-_p.y)<0.02
            && abs(_last.x-_last.xstart)<=2.02 && abs(_last.y-_last.ystart)<=2.02 && _last.creator==_p,
            "HyperBubble source hitscan length or terminal explosion ownership changed")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _victim=instance_create(95016,95000,Bandit),_friend=instance_create(95016,95000,Bandit)
        _victim.hp=100;_victim.team=team_enemy;_victim.nexthurt=current_frame+1000;_victim.mask_index=mskBullet1
        _friend.hp=100;_friend.team=_p.team;_friend.mask_index=mskBullet1
        with(_p) _hyper=scrNTTEFullMergedBasicProjectileCreate(95000,95000,NTTEFullHyperBubble,0)
        with(_hyper) event_perform(ev_step,ev_step_end)
        assert(_victim.hp==88 && _friend.hp==100,
            "HyperBubble original direct collision lost source12 damage, ignored friendly team or added enemy iframe gate")
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        var _npc=instance_create(94000,94000,Bandit),_players_count=instance_number(Player)
        _npc.team=team_enemy;_npc.gunangle=0
        var _actor=scrNTTEFullActorFire(_npc,wep_ntte_bubble_minigun,0,0,false),
            _npc_bursts=scrNTTEFullMergedRuntimeTestShots(_actor.shots,NTTEFullNativeFireBurst)
        assert(array_length(_npc_bursts)==1 && _npc_bursts[0].creator==_npc
            && instance_number(Player)==_players_count,
            "Actual NPC Bubble initial fire left a registered proxy or lost source burst creator")
        _npc.gunangle=90;_npc.x=94100;_npc.y=94200
        repeat(ceil(4/timescale)) if(instance_exists(_npc_bursts[0])) with(_npc_bursts[0]) event_perform(ev_step,ev_step_normal)
        var _npc_bombs=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullBubbleBomb)
        assert(array_length(_npc_bombs)==3 && instance_number(Player)==_players_count,
            "NPC source FireBurst failed temporary Fish callback context or leaked actual Player")
        for(var _i=1;_i<3;++_i) {
            scrNTTESmokeLog("NPC BUBBLE BURST DIAG angle="+string(_npc_bombs[_i].direction)
                +" creator="+string(_npc_bombs[_i].creator)+" expected="+string(_npc)
                +" team="+string(_npc_bombs[_i].team)+" expected="+string(team_enemy))
            assert(_npc_bombs[_i].creator==_npc && _npc_bombs[_i].team==team_enemy
                && abs(angle_difference(_npc_bombs[_i].direction,90))<0.0001,
                "NPC source FireBurst lost live NPC aim, true creator or team after proxy removal")
        }
        // Actual custom front inherits shared ancestor on every source Step.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        _p.ammo=array_create(Ammo.NUM_AMMO_TYPES,100);_p.x=93000;_p.y=93000;_p.gunangle=0
        var _weapon=scrNTTEFullWeaponMerge(wep_heavy_revolver,wep_ntte_bubble_rifle),
            _handle=scrNTTEFullWeaponNative(_weapon)
        _p.wep=_handle
        var _merged=scrNTTEFullMergedRuntimePlayerFire(_p,_handle,{creator:_p}),
            _controllers=scrNTTEFullMergedRuntimeTestShots(_merged.shots,NTTEFullNativeFireBurst),
            _bombs=scrNTTEFullMergedRuntimeTestShots(_merged.shots,NTTEFullBubbleBomb)
        assert(array_length(_controllers)==1 && array_length(_bombs)==1
            && variable_instance_exists(_controllers[0],"ntte_merged_runtime_inherit"),
            "Merged Bubble source controller was replaced as attack or lost actual delayed inheritance")
        var _damage=_bombs[0].damage,_force=_bombs[0].knockback_speed,_merge=_bombs[0].temerge_vars_list[0],
            _paid=_p.ammo[Ammo.Explosives],_controller=_controllers[0]
        _p.x=93100;_p.y=93200;_p.gunangle=90
        repeat(ceil(3/timescale)) if(instance_exists(_controller)) with(_controller) event_perform(ev_step,ev_step_normal)
        _bombs=scrNTTEFullBubbleWeaponTestNew(_before,NTTEFullBubbleBomb)
        assert(array_length(_bombs)==2 && _bombs[1].damage==_damage && _bombs[1].knockback_speed==_force
            && array_length(_bombs[1].temerge_vars_list)==1 && _bombs[1].temerge_vars_list[0]==_merge
            && _p.ammo[Ammo.Explosives]==_paid && _p.x==93100 && _p.y==93200 && _p.gunangle==90,
            "Actual deferred Bubble front lost shared ancestor, charged twice or failed real creator restoration")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_back)
        ds_list_destroy(_skills);random_set_seed(_seed);current_frame=_tick
    }
    scrNTTESmokeLog("FULL BUBBLE WEAPONS: actual scrFire physical bombs/hyper, source rifle/minigun Step burst/default interval/cost/live aim, ordered shotgun offsets, cannon particles, static hitscan and merged delayed ancestor OK @"+string(30/timescale))
}


// Frozen candidate56 non-Player invoke and Step, with visit counter only.
function scrNTTEFullFireBurstLegacyInvokeTest(_owner,_x,_y,_angle,_weapon,_primary,_team,_accuracy,_callback,_context,_burst) {
    if(instance_is(_owner,Player)) with(_owner) {
        var _old_team=team,_old_accuracy=accuracy,_old_angle=gunangle,_old_x=x,_old_y=y,
            _old_spec=scrNTTEFullValue(id,"specfiring",false),_swap=!_primary
        if(_swap) {scrSwapWeps(false);specfiring=true}
        team=_team;accuracy=_accuracy;gunangle=_angle;x=_x;y=_y
        try {_callback(_weapon,_primary,_burst,_context)}
        finally {
            x=_old_x;y=_old_y;gunangle=_old_angle
            if(team==_team) team=_old_team
            if(accuracy==_accuracy) accuracy=_old_accuracy
            else if(_accuracy!=0) accuracy=_old_accuracy*(accuracy/_accuracy)
            if(_swap) {specfiring=_old_spec;scrSwapWeps(false)}
        }
    }
    else {
        // Source non-Player FireBurst uses player_fire_ext(...wep_none...),
        // whose temporary FireCont/Fish context must not read NPC-only fields.
        // As ActorFire, Player.Create alone does not register a game player.
        var _before=scrNTTEFullInstances(all),_proxy=instance_create(_x,_y,Player),_source=id
        try {
            with(_proxy) {
                visible=false;persistent=false;can_walk=false;can_spec=false;can_aim=false
                is_me=false;race=Race.Fish;bskin=-1;index=scrNTTEFullValue(_owner,"index",0)
                team=_team;hitid=scrNTTEFullValue(_owner,"hitid",[sprMutant1Idle,""])
                ntte_actor_fire_creator=_owner
                gunangle=_angle;accuracy=_accuracy;infammo=1;wep=_weapon;bwep=wep_none
                ntte_state=scrNTTENewState(_weapon);ntte_actor_accuracy=_accuracy;ntte_actor_angle=_angle
                scrNTTEFullActorDamageMetadata(id,_source)
                _callback(_weapon,_primary,_burst,_context)
            }
        } finally {
            var _after=scrNTTEFullInstances(all),_new=scrNTTEFullMergedRuntimeDifference(_before,_after)
            global.ntte_full_fireburst_birth_test.legacy_visits+=array_length(_before)+array_length(_after)
            for(var _i=0;_i<array_length(_new);++_i) {
                var _inst=_new[_i]
                if(instance_exists(_inst) && variable_instance_exists(_inst,"creator") && _inst.creator==_proxy) {
                    _inst.creator=_owner;_inst.team=_team;scrNTTEFullActorDamageMetadata(_inst,_source)
                }
            }
            if(instance_exists(_proxy)) instance_destroy(_proxy,false)
        }
    }
}
function scrNTTEFullFireBurstLegacyStepTest() {
    if(lockstep_stop) return;
    if(!(time>0 && ammo!=0)) {instance_destroy();return;}
    var _event=scrNTTEFullMergedRuntimeEventBegin()
    try {
        var _mount=scrNTTEFullMergedRuntimeMountedEventBegin()
        try {
            time-=timescale
            while(time<=0 && time_max>=0 && ammo--!=0) {
                ++burst
                // Source nonzero burst_time getter overrides the interval.
                // Default getter0 preserves initial weapon_load/max(1,burst).
                if(explicit_interval!=0) time_max=explicit_interval
                time+=time_max
                var _anchor=scrNTTEFullMergedRuntimeFiringAnchor(id)
                if(!instance_exists(creator) || !scrNTTEFullActorFiringAnchorExists(_anchor)) continue
                x=_anchor.x;y=_anchor.y
                // Ordinary ActorFire tags its initial angle for native shots.
                // Source FireBurst explicitly follows creator.gunangle on
                // each later step; only actual mounts/direction-owner scopes
                // may supply a separately rotated firing angle.
                if(is_struct(scrNTTEFullValue(id,"ntte_merged_runtime_at",undefined))
                    || is_struct(scrNTTEFullValue(id,"ntte_actor_mount",undefined))
                    || instance_exists(scrNTTEFullValue(id,"ntte_actor_direction_owner",noone)))
                    direction=scrNTTEFullMergedRuntimeFiringAngle(id)
                else if(variable_instance_exists(creator,"gunangle")) direction=creator.gunangle
                scrNTTEFullFireBurstLegacyInvokeTest(creator,x,y,direction,wep,primary,team,accuracy,callback,context,burst)
            }
        } finally {scrNTTEFullMergedRuntimeMountEnd(_mount)}
    } finally {scrNTTEFullMergedRuntimeEventEnd(_event)}
}

// Exact candidate56 oracle/candidate comparison for naturally delayed NPC shots.
function scrNTTEFullFireBurstBirthRowsTest(_capture,_owner,_other=noone) {
    var _born=scrNTTEFullMergedCaptureEnd(_capture),_rows=[]
    for(var _i=0;_i<array_length(_born);++_i) {
        var _p=_born[_i],_creator=scrNTTEFullValue(_p,"creator",noone)
        array_push(_rows,[_p.object_index,_p.x,_p.y,_p.xstart,_p.ystart,_p.speed,_p.direction,
            _p.image_index,_p.image_speed,_p.image_xscale,_p.image_yscale,_p.image_angle,_p.sprite_index,
            scrNTTEFullValue(_p,"damage",undefined),scrNTTEFullValue(_p,"knockback_speed",undefined),
            scrNTTEFullValue(_p,"team",undefined),_creator==_owner,_creator==_other,
            scrNTTEFullValue(_p,"primary",undefined),scrNTTEFullValue(_p,"hitid",undefined),
            variable_instance_exists(_p,"ntte_monster_projectile"),scrNTTEFullValue(_p,"ntte_monster_projectile",false),
            scrNTTEFullValue(_p,"ntte_actor_accuracy",undefined),scrNTTEFullValue(_p,"ntte_actor_angle",undefined),
            scrNTTEFullValue(_p,"ntte_actor_anchor",noone)==_owner])
    }
    return json_stringify(_rows)
}
function scrNTTEFullFireBurstLegacyEventTest() {
    var _event=scrNTTEFullMergedRuntimeEventBegin()
    try {
        var _mount=scrNTTEFullMergedRuntimeMountedEventBegin()
        try {scrNTTEFullFireBurstLegacyStepTest()}
        finally {scrNTTEFullMergedRuntimeMountEnd(_mount)}
    } finally {scrNTTEFullMergedRuntimeEventEnd(_event)}
}
function scrNTTEFullFireBurstMeasuredInvokeTest(_owner,_context) {
    var _slots=instance_count
    try {
        if(_context.legacy) scrNTTEFullFireBurstLegacyInvokeTest(_owner,112000,112000,37,wep_ntte_bubble_rifle,
            true,team_player,0.73,scrNTTEFullFireBurstEdgeCallbackTest,_context,4)
        else scrNTTEFullNativeFireBurstInvoke(_owner,112000,112000,37,wep_ntte_bubble_rifle,
            true,team_player,0.73,scrNTTEFullFireBurstEdgeCallbackTest,_context,4)
    } finally {
        if(!_context.legacy) global.ntte_full_fireburst_birth_test.birth_visits+=instance_count-_slots
    }
}
function scrNTTEFullFireBurstEdgeCallbackTest(_weapon,_primary,_burst,_context) {
    array_push(_context.proxies,id)
    array_push(_context.log,[_weapon,_primary,_burst,team,accuracy,gunangle,race,is_me,instance_number(Player)])
    var _a=instance_create(112100,112100,Bolt),_nonprojectile=instance_create(112100,112100,NTTEFullMergedSetupProbe),
        _other=instance_create(112100,112100,Bolt),_gone=instance_create(112100,112100,Bolt)
    _a.creator=id;_a.team=team_enemy;_a.direction=random(360)
    _nonprojectile.creator=id;_nonprojectile.team=team_enemy
    _other.creator=_context.other;_other.team=team_enemy
    _gone.creator=id;instance_destroy(_gone,false)
    // A preexisting instance newly retagged to this proxy is outside the old
    // snapshot difference and must remain outside the birth capture as well.
    _context.preexisting.creator=id
    if(_context.nested) {
        var _child={legacy:_context.legacy,other:_context.other,preexisting:_context.preexisting,
            nested:false,fail:false,proxies:_context.proxies,log:_context.log}
        scrNTTEFullFireBurstMeasuredInvokeTest(_context.other,_child)
        // Explicitly retain COW-safe alias results for comparison.
        _context.proxies=_child.proxies;_context.log=_child.log
    }
    if(_context.fail) throw "FireBurst exact finally test"
}
function scrNTTEFullFireBurstBirthCaptureNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"FireBurst birth regression needs explicit desktop smoke")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_frame=current_frame,
        _streams=scrNTTEFullArrayCopy(global.rng_state),
        _old_test=variable_global_exists("ntte_full_fireburst_birth_test")?global.ntte_full_fireburst_birth_test:undefined,
        _scope=variable_global_exists("ntte_full_merged_state_fire")?global.ntte_full_merged_state_fire:undefined,
        _old_skills=GameCont.skills,_skills=ds_list_create(),_cases=0,_old_visits=0,_new_visits=0
    try {
        global.ntte_full_merged_state_fire=undefined
        GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};current_frame=2
        // These probes have no events or RNG; density varies only unrelated work.
        for(var _density=0;_density<2;++_density) {
            var _dense=scrNTTEFullInstances(all)
            if(_density==1) repeat(2048) instance_create(110000,110000,NTTEFullMergedSetupProbe)
            var _weapons=[wep_ntte_bubble_rifle,wep_ntte_bubble_minigun]
            for(var _weapon_i=0;_weapon_i<2;++_weapon_i) for(var _friendly=0;_friendly<2;++_friendly) {
                var _results=[]
                for(var _legacy=1;_legacy>=0;--_legacy) {
                    var _local=scrNTTEFullInstances(all)
                    random_set_seed(571400+_weapon_i*10+_friendly);global.rng_state=scrNTTEFullArrayCopy(_streams)
                    current_frame=2;GameCont.underwater=false
                    global.ntte_full_fireburst_birth_test={legacy_visits:0,birth_visits:0}
                    var _npc=instance_create(110500,110500,Bandit),_player_count=instance_number(Player)
                    _npc.team=_friendly==1?team_player:team_enemy;_npc.gunangle=13
                    var _capture=scrNTTEFullMergedCaptureBegin(),_start=get_timer(),
                        _actor=scrNTTEFullActorFire(_npc,_weapons[_weapon_i],13,0.45,false),
                        _controllers=scrNTTEFullMergedRuntimeTestShots(_actor.shots,NTTEFullNativeFireBurst)
                    assert(array_length(_controllers)==1 && _controllers[0].creator==_npc,
                        "Natural NPC firing failed to create its real delayed FireBurst")
                    var _controller=_controllers[0]
                    repeat(ceil(7/timescale)) if(instance_exists(_controller)) {
                        _npc.x+=13;_npc.y+=7;_npc.gunangle+=31
                        var _event_slots=instance_count
                        if(_legacy) with(_controller) scrNTTEFullFireBurstLegacyEventTest()
                        else with(_controller) event_perform(ev_step,ev_step_normal)
                        if(!_legacy) global.ntte_full_fireburst_birth_test.birth_visits+=instance_count-_event_slots
                        current_frame++
                    }
                    var _elapsed=get_timer()-_start,_rows=scrNTTEFullFireBurstBirthRowsTest(_capture,_npc),
                        _bombs=scrNTTEFullMergedRuntimeTestShots(scrNTTEFullMergedCaptureEnd(_capture),NTTEFullBubbleBomb)
                    assert(!instance_exists(_controller) && instance_number(Player)==_player_count
                        && array_length(_bombs)==(_weapon_i==0?2:3),
                        "Natural delayed NPC fire changed count, lifetime or leaked a Player proxy")
                    // The initial ActorFire proxy does not promise the optional
                    // ntte_monster_projectile flag. Real enemy ownership remains
                    // authoritative; row parity checks both flag presence/value.
                    for(var _i=0;_i<array_length(_bombs);++_i)
                        assert(_bombs[_i].creator==_npc && _bombs[_i].team==_npc.team
                            && instance_is(_bombs[_i].creator,enemy),
                            "Natural delayed NPC fire lost true enemy creator/team")
                    array_push(_results,{rows:_rows,rng:random_get_seed(),streams:json_stringify(global.rng_state),
                        visits:_legacy?global.ntte_full_fireburst_birth_test.legacy_visits:global.ntte_full_fireburst_birth_test.birth_visits,
                        elapsed:_elapsed})
                    scrNTTEFullMergedRuntimeTestCleanup(_local)
                }
                assert(_results[0].rows==_results[1].rows && _results[0].rng==_results[1].rng
                    && _results[0].streams==_results[1].streams,
                    "FireBurst birth capture changed ordered real emissions/motion/metadata or either RNG stream")
                if(_density==1) assert(_results[0].visits>=4096 && _results[1].visits<32,
                    "NPC FireBurst still performs room-sized discovery instead of callback-only births")
                _old_visits+=_results[0].visits;_new_visits+=_results[1].visits;_cases++
                scrNTTESmokeLog("FIREBURST BIRTH ROW density="+string(_density)+" weapon="+string(_weapons[_weapon_i])
                    +" friendly="+string(_friendly)+" visits="+string(_results[0].visits)+"->"+string(_results[1].visits)
                    +" host_us="+string(_results[0].elapsed)+"->"+string(_results[1].elapsed))
            }
            scrNTTEFullMergedRuntimeTestCleanup(_dense)
        }
        // Independent exception/nested/other-owner/nonprojectile/dead cases.
        for(var _fail=0;_fail<2;++_fail) {
            var _results=[]
            for(var _legacy=1;_legacy>=0;--_legacy) {
                var _local=scrNTTEFullInstances(all)
                random_set_seed(571900+_fail);global.rng_state=scrNTTEFullArrayCopy(_streams)
                global.ntte_full_fireburst_birth_test={legacy_visits:0,birth_visits:0}
                var _owner=instance_create(112000,112000,Bandit),_other=instance_create(112000,112000,Bandit),
                    _source=instance_create(112000,112000,NTTEFullNativeFireBurst),
                    _old=instance_create(112000,112000,Bolt),_player_count=instance_number(Player)
                _source.ntte_monster_projectile=true;_source.ntte_actor_accuracy=0.73
                _source.ntte_actor_angle=37;_source.ntte_actor_anchor=_owner
                var _context={legacy:_legacy,other:_other,preexisting:_old,nested:true,fail:_fail,proxies:[],log:[]},
                    _capture=scrNTTEFullMergedCaptureBegin(),_error=""
                try {with(_source) scrNTTEFullFireBurstMeasuredInvokeTest(_owner,_context)}
                catch(_caught) {_error=string(_caught)}
                assert(_error==(_fail?"FireBurst exact finally test":"") && instance_number(Player)==_player_count,
                    "FireBurst finally swallowed callback exception or leaked a nested proxy")
                assert(array_length(_context.proxies)==2 && !instance_exists(_context.proxies[0])
                    && !instance_exists(_context.proxies[1]) && !instance_exists(_old.creator)
                    && _old.creator!=_owner && _old.creator!=_other,
                    "FireBurst changed nested proxy cleanup or remapped a preexisting retagged instance")
                var _born=scrNTTEFullMergedCaptureEnd(_capture),_probes=scrNTTEFullMergedRuntimeTestShots(_born,NTTEFullMergedSetupProbe)
                assert(array_length(_probes)==2 && _probes[0].creator==_owner && _probes[1].creator==_other
                    && _probes[0].team==team_player && _probes[1].team==team_player
                    && _probes[0].ntte_monster_projectile && _probes[0].ntte_actor_anchor==_owner,
                    "Birth capture narrowed remapping to projectiles or lost ordered metadata propagation")
                array_push(_results,{rows:scrNTTEFullFireBurstBirthRowsTest(_capture,_owner,_other),
                    log:json_stringify(_context.log),rng:random_get_seed(),streams:json_stringify(global.rng_state)})
                scrNTTEFullMergedRuntimeTestCleanup(_local)
            }
            assert(_results[0].rows==_results[1].rows && _results[0].log==_results[1].log
                && _results[0].rng==_results[1].rng && _results[0].streams==_results[1].streams,
                "Nested/exception FireBurst birth capture differs from frozen callback/ownership/order/RNG oracle")
            _cases++
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber)
        GameCont.skills=_old_skills;ds_list_destroy(_skills)
        random_set_seed(_seed);global.rng_state=_streams;current_frame=_frame
        global.ntte_full_fireburst_birth_test=_old_test;global.ntte_full_merged_state_fire=_scope
    }
    scrNTTESmokeLog("FIREBURST BIRTH CAPTURE PASS cases="+string(_cases)+" visits="+string(_old_visits)+"->"+string(_new_visits)
        +" exact natural NPC/ally Rifle+Minigun, nested/finally/creator/team/damage/order/both-RNG @"+string(30/timescale))
}
