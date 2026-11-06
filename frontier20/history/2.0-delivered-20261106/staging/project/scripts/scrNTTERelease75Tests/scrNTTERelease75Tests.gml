function scrNTTECrystalWaterLightningTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _cx=view_xview+view_width*0.5,_cy=view_yview+view_height*0.5,
        _crystal_scope=variable_global_exists("ntte_crystal_lightning_construct")?global.ntte_crystal_lightning_construct:false
    try {
        var _p=instance_find(Player,0),_areas=[scrNTTEFullAreaId("oasis"),scrNTTEFullAreaId("trench")]
        GameCont.underwater=true
        for(var _a=0;_a<2;++_a) {
            GameCont.area=_areas[_a]
            var _crystal=instance_create(_cx,_cy,LightningCrystal),_dummy=instance_create(_cx+100,_cy,Bandit)
            _dummy.hp=100;_dummy.nexthurt=0;_dummy.sprite_index=_dummy.spr_idle
            _p.hp=100;_p.nexthurt=0;_p.sprite_index=_p.spr_idle
            var _old=scrNTTEFullInstances(Lightning),_hp=_p.hp
            _crystal.ammo=1;_crystal.gunangle=0
            with(_crystal) event_perform(ev_alarm,2)
            var _nodes=scrNTTEFullBubbleWeaponTestNew(_old,EnemyLightning)
            assert(array_length(_nodes)>1 && _dummy.hp==100 && _p.hp==_hp,
                "Crystal attack still discharged the full water area or lost its local arcs")
            for(var _n=0;_n<array_length(_nodes);++_n)
                assert(_nodes[_n].ntte_crystal_lightning && _nodes[_n].damage==2 && _nodes[_n].team==_crystal.team,
                    "Crystal suppression/normal damage/team did not reach every child lightning segment")
            var _count=instance_number(EnemyLightning)
            _crystal.alarm[2]=-1
            repeat(200) with(_crystal) event_perform(ev_other,10)
            assert(instance_number(EnemyLightning)>_count && _dummy.hp==100 && _p.hp==_hp,
                "Ambient crystal arcs still discharged the water area or failed to spawn")
            assert(!global.ntte_crystal_lightning_construct,"Crystal constructor flag leaked into unrelated weapons")
            with(_dummy) {nexthurt=0;sprite_index=spr_idle}
            instance_create(_cx,_cy,Lightning)
            assert(_dummy.hp<100,"Crystal repair accidentally removed ordinary underwater weapon conduction")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        scrNTTESmokeLog("PASS CRYSTAL WATER actual Oasis/Trench ambient+attack Create/Alarm0 descendants retain local arcs, damage/team; no screen hits; ordinary weapon conduction and scoped restoration preserved @"+string(30/timescale))
    }
    finally {
        global.ntte_crystal_lightning_construct=_crystal_scope
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullVanillaFixtureEnd(_state)
    }
}
function scrNTTERavenLiftTargetTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _parked=scrNTTEFullInstances(Player),_raven=noone
    try {
        _raven=instance_create(88000,88000,Raven);_raven.nofly=0
        assert(_raven.targetx==_raven.x && _raven.targety==_raven.y,"Raven constructor omitted flight endpoints")
        for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
        with(_raven) scrRavenLift()
        assert(_raven.object_index==Raven && _raven.nofly==0,"Targetless flock member attempted an uninitialized flight")
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        with(_raven) scrRavenLift()
        assert(_raven.object_index==Raven,"Floorless takeoff used a nonexistent landing floor")
        var _floor=instance_create(88128,88000,Floor),_wall=instance_create(88128,88000,Wall)
        with(_raven) scrRavenLift()
        assert(_raven.object_index==Raven && _raven.targetx==88000 && _raven.targety==88000,
            "Blocked landing search failed bounded cancellation or changed current endpoints")
        instance_destroy(_wall,false)
        with(_raven) scrRavenLift()
        assert(_raven.object_index==RavenFly && _raven.targetx==88144 && _raven.targety==88016 && _raven.lifespan==300,
            "Normal Raven flight lost real landing coordinates or transition")
        scrNTTESmokeLog("PASS RAVEN LIFT actual targetless/floorless/blocked and successful native flight transitions @"+string(30/timescale))
    }
    finally {
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullVanillaFixtureEnd(_state)
    }
}
function scrNTTEBubbleMergeColdStartTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _registry=variable_global_exists("ntte_full_merge_effect_registry")?global.ntte_full_merge_effect_registry:undefined,
        _ready=variable_global_exists("ntte_full_merge_effect_initialized")?global.ntte_full_merge_effect_initialized:false,
        _provider=variable_global_exists("ntte_full_projectile_merge_effect")?global.ntte_full_projectile_merge_effect:undefined
    try {
        var _bomb=instance_create(89000,89000,NTTEFullBubbleBomb),_shot=instance_create(89000,89000,Bullet1),
            _setup=_bomb.temerge_on_setup
        GameCont.temerge_effect_vars_map={};GameCont.temerge_effect_call_step_instance_list=[]
        global.ntte_full_merge_effect_initialized=false;global.ntte_full_merge_effect_registry={}
        global.ntte_full_projectile_merge_effect=undefined
        with(_bomb) _setup([_shot],{is_big:false})
        assert(is_callable(global.ntte_full_projectile_merge_effect) && array_length(_shot.temerge_explosion_list)==1
            && _shot.temerge_explosion_list[0].is_bubble,
            "First BubbleBomb fusion setup did not initialize the real explosion provider")
        with(_bomb) _setup([_shot],{is_big:true})
        assert(array_length(_shot.temerge_explosion_list)==4,"Big bubble fusion lost its three original bubble explosions")
        scrNTTESmokeLog("PASS BUBBLE MERGE cold actual projectile setup initializes real provider and small1/big3 explosion effects @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game)
        global.ntte_full_merge_effect_registry=_registry;global.ntte_full_merge_effect_initialized=_ready
        global.ntte_full_projectile_merge_effect=_provider
    }
}
function scrNTTELastEnemyHiddenTimeoutTests() {
    var _state=scrNTTEFullVanillaFixtureBegin(),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _parked=scrNTTEFullInstances([Portal,becomenemy,Corpse,LastDie,NTTEFullPet]),
        _stop=lockstep_stop,_steps=round(1800/timescale),_frame=current_frame
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.is_level_ended=false
        with(Player) hp=max(hp,1)
        for(var _case=0;_case<6;++_case) {
            GameCont.area=_case<3?area_desert:area_jungle
            var _kind=_case mod 3,
                _e=instance_create(91000,91000,_kind==1?(_case<3?MeleeFake:JungleAssassinHide):(_kind==0?Raven:Bandit))
            if(_kind==0) with(_e) instance_change(RavenFly,false)
            if(_kind==2) _e.hp=0 // A stale actor whose own Step skips death.
            var _kills=GameCont.kills,_corpses=instance_number(CorpseActive)
            with(GameCont) scrNTTELastEnemyTimeoutReset()
            repeat(_steps) with(GameCont) scrNTTELastEnemyTimeoutStep()
            assert(instance_exists(_e) && GameCont.ntte_last_enemy_target==_e && GameCont.ntte_last_enemy_time==1800,
                "Sole hidden/flying/zero-HP actor was ignored, or expired before exceeding one full minute: case="+string(_case)
                +" time="+string(GameCont.ntte_last_enemy_time)+" target="+string(GameCont.ntte_last_enemy_target)
                +" actor="+string(_e)+" object="+object_get_name(_e.object_index)
                +" enemy="+string(instance_number(enemy))+" become="+string(instance_number(becomenemy))
                +" dormant="+string(instance_number(MeleeFake))+" boss="+string(scrEnemyIsBoss(_e))
                +" death="+string(scrNTTELastEnemyTimeoutDeathObject(_e)))
            lockstep_stop=true
            repeat(3) with(GameCont) scrNTTELastEnemyTimeoutStep()
            lockstep_stop=false
            assert(GameCont.ntte_last_enemy_time==1800,"Pause advanced hidden-hostile expiry")
            with(GameCont) scrNTTELastEnemyTimeoutStep()
            assert(!instance_exists(_e) && GameCont.kills==_kills+1 && instance_number(CorpseActive)==_corpses+1,
                "Hidden/flying/stale actor failed one real death/corpse/drop flow without its own Step")
            var _corpse=instance_find(CorpseActive,0)
            with(_corpse) event_perform(ev_alarm,0)
            assert(instance_exists(Portal),"Expired hidden hostile still blocked the native corpse portal")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        var _transition=instance_create(91200,91000,becomenemy)
        repeat(_steps+2) with(GameCont) scrNTTELastEnemyTimeoutStep()
        assert(instance_exists(_transition) && GameCont.ntte_last_enemy_time==0,"Generic/Boss transition was treated as a normal monster")
        instance_destroy(_transition,false)
        for(var _biome=0;_biome<2;++_biome) {
            GameCont.area=_biome==0?area_desert:area_jungle
            var _no_corpse=instance_create(91000,91000,Bandit)
            _no_corpse.corpse=false;_no_corpse.hp=0
            instance_destroy(_no_corpse)
            assert(!instance_exists(Corpse) && !scr_check_enemies(),"Empty-room retry fixture still had a native completion blocker")
            GameCont.ntte_ally_portal_timer=0
            with(GameCont) scrNTTEAllyPortalStep()
            assert(!instance_exists(Portal) && instance_exists(Corpse),"Empty room bypassed the guarded corpse-alarm flow or failed to rearm it")
            var _retry=instance_find(Corpse,0)
            with(_retry) event_perform(ev_alarm,0)
            assert(instance_exists(Portal),"Empty Desert/Jungle without allies or a death corpse remained stuck")
            scrNTTEFullCavesFixtureCleanup(_state.baseline)
        }
        scrNTTESmokeLog("PASS LAST HIDDEN actual Desert/Jungle RavenFly/hidden assassin/zero-HP full-minute expiry, pause, real single death+corpse portal, empty-room native retry and generic transition protection @"+string(30/timescale))
    }
    finally {
        lockstep_stop=_stop;current_frame=_frame;scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullVanillaFixtureEnd(_state)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
    }
}
