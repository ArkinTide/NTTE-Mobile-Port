// Original telib enemy_boss macro: explicit boss field wins, even false.
// Native ancestry is the fallback for the Epsilon runner's native boss objects.
// Focused real callbacks, not a substitute for the connected combat acceptance.
function scrNTTEFullBossClassificationNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && !instance_exists(GenCont)
        && !instance_exists(Menu) && instance_exists(GameCont) && instance_exists(Player)
        && instance_exists(UberCont) && player_count==1,
        "Boss classification regression requires a settled solo desktop room")
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_enemies=scrNTTEFullAreaGeneratorSnapshot(enemy),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _seed=random_get_seed(),_rng_states=scrNTTEFullArrayCopy(global.rng_state),_stop=lockstep_stop,
        _private_skills=ds_list_create(),_progress=global.ntte_full_progress,
        _progress_json=json_stringify(global.ntte_full_progress),_graph={nodes:[]}
    scrNTTEFullAreaSnapshotContainer(_progress,_graph)
    try {
        lockstep_stop=false
        GameCont.area=area_desert;GameCont.lastarea=area_desert;GameCont.underwater=false
        GameCont.loops=0;GameCont.crown=crwn_none;GameCont.skills=_private_skills
        GameCont.ntte_full_native_skill_counts={};UberCont.hardmode=false
        UberCont.custom=true;UberCont.custom_options=new CustomModeOptions("boss-classification-private")
        var _player=instance_find(Player,0)
        _player.race=Race.Fish
        assert(!scr_player_ultra_get(_player,Race.Horror,UltraSkill.Anomaly),
            "Focused Alarm10 isolation unexpectedly enabled the independent Anomaly wipe")

        // Actual native constructors select their own original custom health
        // branches. No flag is introduced on either native actor here.
        UberCont.custom_options.boss_health=200;UberCont.custom_options.enemy_health=50
        var _ordinary=instance_create(62000,62000,Bandit),_native=instance_create(62128,62000,BanditBoss)
        assert(!variable_instance_exists(_ordinary,"boss") && !scrEnemyIsBoss(_ordinary)
            && _ordinary.hp==2 && _ordinary.max_hp==2,
            "Native ordinary constructor stopped using original enemy_health percentage")
        assert(!variable_instance_exists(_native,"boss") && scrEnemyIsBoss(_native)
            && _native.hp==100 && _native.max_hp==200,
            "Flag-free native boss constructor lost ancestry or original boss_health percentage")
        scrNTTESmokeLog("BOSS CLASSIFICATION actual constructors ordinary HP/max2 nativeBoss HP100/max200 (original upward max-only scaling) @"+string(30/timescale))
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)

        UberCont.custom_options.boss_health=100;UberCont.custom_options.enemy_health=100
        var _floor=instance_create(62000,62000,Floor)
        assert(instance_exists(_floor),"Native floor constructor did not leave the isolated on-floor support")
        var _on=instance_create(62008,62008,Bandit),_off=instance_create(62256,62000,Bandit),
            _native=instance_create(62384,62000,BanditBoss),_explicit_false=instance_create(62512,62000,BanditBoss),
            _explicit_true=instance_create(62640,62000,Bandit),_pit=instance_create(62768,62000,NTTEFullPitSquid)
        _explicit_false.boss=false;_explicit_true.boss=true
        assert(_pit.boss && !object_is_ancestor(_pit.object_index,bossenemy)
            && _pit.x==0 && _pit.y==0 && _pit.hp==340 && !_pit.ntte_full_intro
            && _pit.mask_index==mskNone && !position_meeting(_pit.x,_pit.y,Floor),
            "Actual source PitSquid did not exercise the hidden floorless nonnative-boss root")
        assert(position_meeting(_on.x,_on.y,Floor) && !position_meeting(_off.x,_off.y,Floor)
            && !position_meeting(_native.x,_native.y,Floor) && !position_meeting(_explicit_false.x,_explicit_false.y,Floor),
            "Actual Floor geometry did not distinguish isolated on-floor/floorless actors")
        var _on_hp=_on.hp,_off_hp=_off.hp,_false_hp=_explicit_false.hp,
            _native_hp=_native.hp,_true_hp=_explicit_true.hp,
            _deaths=instance_number(NTTEFullPitSquidDeath),_prevents=instance_number(NTTEFullPortalPrevent)

        random_set_seed(71931);var _expected=random(1);random_set_seed(71931)
        assert(!scrEnemyIsBoss(noone) && !scrEnemyIsBoss(_off) && !scrEnemyIsBoss(_explicit_false)
            && scrEnemyIsBoss(_native) && scrEnemyIsBoss(_explicit_true) && scrEnemyIsBoss(_pit),
            "Source true/false flag priority, native ancestry or noone classification changed")
        assert(random(1)==_expected,"Read-only boss classification consumed RNG")

        random_set_seed(81931);var _expected=random(1);random_set_seed(81931)
        with(_player) event_perform(ev_alarm,10)
        assert(random(1)==_expected,"Original Alarm10 gained RNG consumption in the isolated custom/no-Anomaly path")
        assert(_player.alarm[10]==30 && _pit.hp==340 && _pit.x==0 && _pit.y==0
            && !_pit.ntte_full_intro && _pit.mask_index==mskNone
            && _native.hp==_native_hp && _explicit_true.hp==_true_hp
            && _on.hp==_on_hp && _off.hp==_off_hp && _explicit_false.hp==_false_hp,
            "Actual native Player.Alarm10 culled a living off-floor enemy or failed reschedule")
        assert(instance_number(NTTEFullPitSquidDeath)==_deaths && instance_number(NTTEFullPortalPrevent)==_prevents,
            "Player.Alarm10 prematurely produced source staged death/prevention despite an untouched hidden boss")
        with(_off) event_perform(ev_step,ev_step_normal)
        assert(instance_exists(_off) && _off.hp==_off_hp,
            "Living off-floor ordinary enemy failed actual native Step after Alarm10")
        _off.hp=0
        with(_off) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_off) && !scrEnemyIsBoss(_off),
            "Native ordinary enemy Step did not retain legitimate zero-HP death")
        scrNTTESmokeLog("BOSS CLASSIFICATION real Player.Alarm10 hiddenPit340/nativeBoss/explicitTrue/onFloor/floorless ordinary+explicitFalse preserved; real zero-HP Step destroyed; alarm30 and RNG unchanged @"+string(30/timescale))
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)

        // The real native creation-effects callback sees flags before choosing
        // custom health. Fresh ordinary/native actors exercise all four states.
        for(var _case=0;_case<4;++_case) {
            var _actor=instance_create(62000+128*_case,62256,(_case==1 || _case==3)?BanditBoss:Bandit),
                _is_boss=(_case==1 || _case==2)
            if(_case==2) _actor.boss=true
            if(_case==3) _actor.boss=false
            _actor.hp=100;_actor.max_hp=100;_actor.raddrop=20
            UberCont.custom_options.boss_health=200;UberCont.custom_options.enemy_health=50
            with(_actor) scrEnemyApplyCreationEffects()
            assert(_actor.max_hp==(_is_boss?200:50) && _actor.hp==(_is_boss?100:50),
                "Actual native creation-effects custom HP selected the wrong source/native classification")
            UberCont.custom_options.boss_health=100;UberCont.custom_options.enemy_health=100

            // Scarier Face and hardmode/Blood execute after custom HP; the
            // classification change must preserve all original arithmetic.
            ds_list_add(_private_skills,mut_scarier_face)
            GameCont.ntte_full_native_skill_counts[$ string(mut_scarier_face)]=1
            UberCont.hardmode=true;GameCont.crown=crwn_blood
            _actor.hp=100;_actor.max_hp=100;_actor.raddrop=20
            with(_actor) scrEnemyApplyCreationEffects()
            assert(_actor.hp==80 && _actor.max_hp==80 && _actor.raddrop==9,
                "Boss classification changed native Scarier Face/hardmode/Blood creation arithmetic")
            ds_list_clear(_private_skills);GameCont.ntte_full_native_skill_counts={}
            UberCont.hardmode=false;GameCont.crown=crwn_none
            scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        }

        // Luck's random roll precedes !scrEnemyIsBoss in the original condition.
        // It must still consume exactly one roll even when the actor is a boss.
        var _lucky_seed=1,_lucky_roll=1,_expected_next=0
        repeat(1000) {
            random_set_seed(_lucky_seed);_lucky_roll=random(1);_expected_next=random(1)
            if(_lucky_roll<=0.1) break
            _lucky_seed++
        }
        assert(_lucky_roll<=0.1,"Could not find a deterministic original Luck branch")
        GameCont.crown=crwn_luck
        for(var _case=0;_case<4;++_case) {
            var _actor=instance_create(62000+128*_case,62512,(_case==1 || _case==3)?BanditBoss:Bandit),
                _is_boss=(_case==1 || _case==2)
            if(_case==2) _actor.boss=true
            if(_case==3) _actor.boss=false
            _actor.hp=100;_actor.max_hp=100;_actor.raddrop=20
            random_set_seed(_lucky_seed)
            with(_actor) scrEnemyApplyCreationEffects()
            assert(_actor.hp==(_is_boss?100:1) && _actor.max_hp==100 && random(1)==_expected_next,
                "Actual native Luck failed source/native boss exclusion or changed original single-roll RNG order")
            scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        }
        scrNTTESmokeLog("BOSS CLASSIFICATION actual native creation-effects true/false/absent ordinary/native custom HP, Scarier80/hardmodeBlood9, deterministic Luck exclusion+single RNG roll OK @"+string(30/timescale))
    }
    finally {
        scrNTTEFullMergedRuntimeTestCleanup(_snapshot)
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_enemies);scrNTTEFullAreaGeneratorRestore(_uber)
        scrNTTEFullAreaGeneratorRestore(_back)
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        global.ntte_full_progress=_progress;global.rng_state=_rng_states
        if(ds_exists(_private_skills,ds_type_list)) ds_list_destroy(_private_skills)
        lockstep_stop=_stop;random_set_seed(_seed)
    }
    assert(json_stringify(global.ntte_full_progress)==_progress_json,
        "Boss classification fixture leaked progress state")
    scrNTTESmokeLog("BOSS CLASSIFICATION NATIVE actual Player.Alarm10 and native constructor/creation-effect coverage OK @"+string(30/timescale)+"; natural PitSquid combat/whole MOD/iPhone pending")
}
