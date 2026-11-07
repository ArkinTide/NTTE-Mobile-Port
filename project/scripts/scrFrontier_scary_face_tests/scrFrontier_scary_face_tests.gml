// Private native construction acceptance. Every row invokes the production
// constructor/factory; expected values come from its no-mutation control.
function scrFRScaryFaceTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled(),
        "Scary Face acceptance requires the isolated native harness");
    _driver.fr_scary_face={round:0};
}

function scrFRScaryFaceTestSkill(_count) {
    scr_skill_set(mut_scarier_face,_count);
    assert(scr_skill_get(mut_scarier_face)==_count,
        "Scary Face fixture did not acquire the real native mutation");
}

function scrFRScaryFaceTestNative(_types,_before,_loops,_custom) {
    GameCont.loops=_loops;UberCont.custom=_custom;
    for(var _i=0;_i<array_length(_types);++_i) {
        var _type=_types[_i],_control=undefined;
        for(var _stack=0;_stack<=2;++_stack) {
            scrFRScaryFaceTestSkill(_stack);random_set_seed(77331+_i);
            var _actor=instance_create(62000,62000,_type);
            assert(instance_exists(_actor),"Native HP constructor disappeared: "+object_get_name(_type));
            if(_stack==0) {
                _control=[_actor.hp,_actor.max_hp,_actor.raddrop];
                assert(!variable_instance_exists(_actor,"ntte_full_scarier_creation_pending"),
                    "SF-free constructor unexpectedly initialized a deferred HP effect");
                // Real generators also call every leaf with no Scary Face.
                // An absent pending field must remain an inert valid path.
                with(_actor) {scrNTTEFullEnemyCreationHPFinish();scrNTTEFullEnemyCreationHPFinish();}
                assert(_actor.hp==_control[0] && _actor.max_hp==_control[1]
                    && _actor.raddrop==_control[2]
                    && !variable_instance_exists(_actor,"ntte_full_scarier_creation_pending"),
                    "Absent deferred HP field was read/created or changed SF-free native stats");
            } else {
                var _expected=floor(_control[0]*power(.8,_stack)),
                    _checks=[_actor.hp==_expected,_actor.max_hp==min(_control[1],_expected),
                        _actor.raddrop==_control[2],!_actor.ntte_full_scarier_creation_pending],
                    _pass=_checks[0] && _checks[1] && _checks[2] && _checks[3];
                if(!_pass) scrNTTESmokeLog("SCARY FACE NATIVE FAILURE "+json_stringify({
                    type:object_get_name(_type),loops:_loops,custom:_custom,stack:_stack,
                    hp:_actor.hp,max_hp:_actor.max_hp,raddrop:_actor.raddrop,
                    pending:_actor.ntte_full_scarier_creation_pending,expected_hp:_expected,
                    expected_max:min(_control[1],_expected),baseline:_control,checks:_checks,
                    crown:GameCont.crown,hardmode:UberCont.hardmode}));
                assert(_pass,
                    "Final native HP boundary failed "+object_get_name(_type)
                    +" L"+string(_loops)+" custom"+string(_custom)+" stack"+string(_stack)
                    +" actual="+string(_actor.hp)+"/"+string(_actor.max_hp)
                    +" control="+json_stringify(_control));
                var _hp=_actor.hp,_max=_actor.max_hp,_rad=_actor.raddrop;
                random_set_seed(99117);var _next=random(1);random_set_seed(99117);
                with(_actor) {scrNTTEFullEnemyCreationHPFinish();scrNTTEFullEnemyCreationHPFinish();}
                assert(_actor.hp==_hp && _actor.max_hp==_max && _actor.raddrop==_rad
                    && random(1)==_next,
                    "Native finalizer repeated HP/drop/RNG effects: "+object_get_name(_type));
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before);
        }
    }
}

function scrFRScaryFaceTestSource(_before,_loops,_custom) {
    // Authored ordinary/elite, native derivative, bosses, minion and both
    // vessel forms. The loaded source factory also creates its possessor.
    var _factories=[
        [fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_create,[62000,62000],18],
        [fr_Objects_Frontier_Caves_mod_gml_Whale_create,[62000,62000],56],
        [fr_Objects_Frontier_Caves_mod_gml_EliteWhale_create,[62000,62000],70],
        [fr_Objects_Frontier_Caves_mod_gml_Parrot_create,[62000,62000],10],
        [fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create,[62000,62000],16],
        [fr_Objects_Frontier_Labs_mod_gml_VesselMortar_create,[62000,62000,true],42],
        [fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_create,[62000,62000,0,noone],4],
        [fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_create,[62000,62000],250],
        [fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_create,[62000,62000],800],
        [fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_MicroSnowbot_create,[62000,62000],2]
    ];
    GameCont.loops=_loops;UberCont.custom=_custom;
    for(var _i=0;_i<array_length(_factories);++_i) {
        var _factory=_factories[_i],_control=undefined;
        for(var _stack=0;_stack<=2;++_stack) {
            scrFRScaryFaceTestSkill(_stack);random_set_seed(88117+_i);
            var _old=scrNTTEFullInstances(enemy),_value=scrFRInvoke(GameCont.id,_factory[0],_factory[1]),
                _created=[],_enemies=scrNTTEFullInstances(enemy);
            for(var _j=0;_j<array_length(_enemies);++_j)
                if(array_get_index(_old,_enemies[_j])<0) array_push(_created,_enemies[_j]);
            assert(array_length(_created)>0,"Real NTUF factory made no enemy at row "+string(_i));
            // MicroSnowbot's authored factory intentionally has no return.
            var _actor=_created[0];
            if(is_numeric(_value)) if(instance_exists(_value)) _actor=_value;
            if(_stack==0) _control=[_actor.hp,_actor.max_hp,_actor.raddrop];
            else {
                var _raw=_factory[2];
                if(_i==7 || _i==8) _raw=round(_raw*(1+_loops/3));
                if(_i!=9) {
                    _raw*=1+_loops/20;
                    if(_custom) _raw=max(1,floor(_raw*scrCustomParam(scrEnemyIsBoss(_actor)?"boss_health":"enemy_health")/100));
                }
                var _expected=max(1,round(floor(_raw*power(.8,_stack))));
                assert(_actor.hp==_expected && _actor.max_hp==_expected
                    && _actor.raddrop==_control[2],
                    "Authored NTUF health boundary failed row="+string(_i)+" L"+string(_loops)
                    +" custom="+string(_custom)+" stack="+string(_stack)
                    +" actual="+string(_actor.hp)+"/"+string(_actor.max_hp)
                    +" expected="+string(_expected)+" baseline="+json_stringify(_control));
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before);
        }
    }
}

function scrFRScaryFaceTestTransfers(_before) {
    GameCont.loops=3;UberCont.custom=false;scrFRScaryFaceTestSkill(1);
    // Real NTTE hidden-to-active replacement copies the existing health;
    // its newly constructed destination must not shrink it a second time.
    var _hidden=instance_create(62000,62000,NTTEFullBloomingAssassinHide),
        _hp=_hidden.hp,_max=_hidden.max_hp,_rad=_hidden.raddrop,_active=noone;
    _hidden.hp-=2;_hp=_hidden.hp;
    with(_hidden) _active=scrNTTEFullBloomingAssassinHideBecome();
    assert(!instance_exists(_hidden) && instance_exists(_active)
        && _active.hp==_hp && _active.max_hp==_max && _active.raddrop==_rad,
        "Real NTTE hidden/active phase copied health through Scary Face twice");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // An actual authored death callback creates four smaller guardians.
    var _guardian=scrFRInvoke(GameCont.id,fr_Objects_Frontier_Palace_mod_gml_GupGuardian_create,[62000,62000]),
        _old=scrNTTEFullInstances(enemy);
    scrFRInvoke(_guardian,fr_Objects_Frontier_Palace_mod_gml_GupGuardian_death,[]);
    var _all=scrNTTEFullInstances(enemy),_count=0;
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_old,_all[_i])<0) {
        ++_count;
        assert(_all[_i].hp==floor(25*1.15*.8) && _all[_i].max_hp==_all[_i].hp,
            "Authored NTUF split-child factory lost Scary Face");
    }
    assert(_count==4,"Real guardian death did not create its four source children");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // This real loaded-vessel spawn creates a Datadriver plus a hidden
    // Voltergeist; both construct independently with the mutation present.
    scrFRInvoke(GameCont.id,fr_Objects_Frontier_Labs_mod_gml_VesselMortar_spawn,[62000,62000]);
    var _all=scrNTTEFullInstances(FRCustomEnemy),_vessels=0,_spirits=0;
    for(var _i=0;_i<array_length(_all);++_i) if(array_get_index(_before,_all[_i])<0) {
        var _a=_all[_i];
        if(_a.name=="Datadriver") {
            ++_vessels;assert(_a.loaded && _a.hp==floor(42*1.15*.8),"Loaded NTUF vessel reset its adjusted HP");
        } else if(_a.name=="Voltergeist") {
            ++_spirits;assert(_a.possessing && _a.hp==floor(16*1.15*.8),"Attached NTUF possessor reset its adjusted HP");
        }
    }
    assert(_vessels==1 && _spirits==1,"Loaded-vessel source spawn did not create both real forms");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // The graveyard's real possessed-carcass callback rebuilds a loaded
    // vessel and redirects its existing spirit to that newly revived enemy.
    var _spirit=scrFRInvoke(GameCont.id,fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create,[62000,62000]),
        _carcass=scrFRInvoke(GameCont.id,fr_Areas_graveyard_area_gml_MortarSpawn_create,[62000,62000]);
    _carcass.fr_possessor=_spirit;
    scrFRInvoke(_carcass,fr_Areas_graveyard_area_gml_MortarSpawn_possessed,[]);
    var _revived=_spirit.possess_target;
    assert(!instance_exists(_carcass) && instance_exists(_revived) && _revived.loaded
        && _revived.hp==floor(42*1.15*.8) && _revived.max_hp==_revived.hp,
        "Authored NTUF corpse-to-vessel revival lost or repeated Scary Face");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // Real carrier constructor with a delayed finite authored maximum.
    // Infinity must not consume the pending construction transformation.
    var _carrier=instance_create(62000,62000,FRCustomEnemy);
    scrFRMaxHealthWrite(_carrier,1/0);assert(_carrier.fr_maxhealth_init,
        "Infinite custom sentinel prematurely completed its HP construction");
    scrFRMaxHealthWrite(_carrier,20);
    assert(!_carrier.fr_maxhealth_init && _carrier.hp==18 && _carrier.max_hp==18,
        "Infinity-to-finite CustomEnemy HP failed loop/Scary Face order");
    scrFRMaxHealthWrite(_carrier,5,"+=");
    assert(_carrier.max_hp==23,"Later source maximum modification repeated Scary Face");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // Late acquisition uses the real public mutation setter. Existing living
    // enemies retain their HP; their subsequently authored replacements do not.
    scrFRScaryFaceTestSkill(0);
    var _native=instance_create(62000,62000,NTTEFullCatBoss),
        _source=scrFRInvoke(GameCont.id,fr_Objects_Frontier_Caves_mod_gml_Whale_create,[62128,62000]),
        _hp1=_native.hp,_max1=_native.max_hp,_hp2=_source.hp,_max2=_source.max_hp;
    scrFRScaryFaceTestSkill(1);
    assert(_native.hp==_hp1 && _native.max_hp==_max1 && _source.hp==_hp2 && _source.max_hp==_max2,
        "Late Scary Face retroactively changed living native/NTUF enemies");
    var _next=instance_create(62000,62256,NTTEFullCatBoss),
        _whale=scrFRInvoke(GameCont.id,fr_Objects_Frontier_Caves_mod_gml_Whale_create,[62128,62256]);
    assert(_next.hp==floor(_hp1*.8) && _whale.hp==floor(56*1.15*.8),
        "Next native/NTUF creation ignored late mutation acquisition");
    scrNTTEFullMergedRuntimeTestCleanup(_before);
}

function scrFRScaryFaceTestLuck(_before) {
    GameCont.loops=0;UberCont.custom=false;scrFRScaryFaceTestSkill(1);
    // Native Luck must roll once, even for bosses, at its unchanged original
    // creation-effects point. Finalizing the deferred HP never rolls again.
    var _seed=1,_roll=1,_next=0;
    repeat(1000) {
        random_set_seed(_seed);_roll=random(1);_next=random(1);
        if(_roll<=.1) break;_seed++;
    }
    assert(_roll<=.1,"Scary Face Luck fixture found no deterministic hit");
    GameCont.crown=crwn_luck;
    var _actor=instance_create(62000,62000,NTTEFullCatBoss);
    _actor.hp=100;_actor.max_hp=100;_actor.raddrop=20;
    random_set_seed(_seed);with(_actor) scrEnemyApplyCreationEffects();
    with(_actor) scrNTTEFullEnemyCreationHPFinish();
    assert(_actor.hp==80 && _actor.max_hp==80 && random(1)==_next,
        "Deferred native boss health changed the original single Luck roll");
    _actor.boss=false;_actor.hp=100;_actor.max_hp=100;
    random_set_seed(_seed);with(_actor) scrEnemyApplyCreationEffects();
    with(_actor) scrNTTEFullEnemyCreationHPFinish();
    assert(_actor.hp==1 && _actor.max_hp==80 && random(1)==_next,
        "Deferred native ordinary health lost Luck's result or rerolled it");
    scrNTTEFullMergedRuntimeTestCleanup(_before);

    // Hit Luck through actual constructors whose leaf both preserves and
    // replaces/scales its inherited HP. The HP cap must reflect Scary Face
    // on authored health, never Scary Face on Luck's temporary 1 HP.
    var _types=[NTTECat,NTTEHikerBandit,NTTEFullBanditHiker];
    for(var _i=0;_i<array_length(_types);++_i) {
        GameCont.crown=crwn_none;scrFRScaryFaceTestSkill(0);
        random_set_seed(57117);var _baseline=instance_create(62000,62000,_types[_i]),
            _max=floor(_baseline.hp*.8);
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        GameCont.crown=crwn_luck;scrFRScaryFaceTestSkill(1);
        var _hit=false;
        for(var _try=1;_try<=100;++_try) {
            random_set_seed(_try);var _candidate=instance_create(62000,62000,_types[_i]);
            if(_candidate.ntte_full_scarier_creation_luck) {
                assert(_candidate.hp==1 && _candidate.max_hp==_max,
                    "Actual Luck-hit constructor shrank 1 HP or lost authored max: "+object_get_name(_types[_i]));
                _hit=true;
            }
            scrNTTEFullMergedRuntimeTestCleanup(_before);
            if(_hit) break;
        }
        assert(_hit,"No deterministic real native constructor Luck-hit control found");
    }

    // The 1-HP FR carrier has no real health yet and must not roll Luck.
    GameCont.crown=crwn_none;random_set_seed(74119);
    var _plain=instance_create(62000,62000,FRCustomEnemy),_next_plain=random(1);
    scrNTTEFullMergedRuntimeTestCleanup(_before);
    GameCont.crown=crwn_luck;random_set_seed(74119);
    var _lucky=instance_create(62000,62000,FRCustomEnemy),_next_lucky=random(1);
    assert(_next_plain==_next_lucky,"FR dummy constructor consumed a duplicate Luck roll");
    random_set_seed(_seed);scrFRMaxHealthWrite(_lucky,100);
    assert(_lucky.hp==1 && _lucky.max_hp==80 && random(1)==_next,
        "Finite authored FR maximum failed its single actual Luck roll");
    scrNTTEFullMergedRuntimeTestCleanup(_before);
    GameCont.crown=crwn_none;
}

function scrFRScaryFaceTestsRun() {
    assert(!instance_exists(GenCont) && instance_exists(GameCont) && instance_exists(Player),
        "Scary Face native matrix requires a settled real game");
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _back=scrNTTEFullAreaGeneratorSnapshot(BackCont),_graph={nodes:[]},
        _tasks=scrNTTEFullArrayCopy(global.fr_tasks),_seed=random_get_seed(),
        _rng=scrNTTEFullArrayCopy(global.rng_state),_skills=ds_list_create(),_stop=lockstep_stop;
    scrNTTEFullAreaSnapshotContainer(global.fr_module_vars,_graph);
    try {
        lockstep_stop=false;GameCont.area=area_desert;GameCont.lastarea=area_desert;
        GameCont.underwater=false;GameCont.crown=crwn_none;GameCont.skills=_skills;
        GameCont.ntte_full_native_skill_counts={};UberCont.hardmode=false;
        UberCont.custom_options=new CustomModeOptions("scary-face-private");
        UberCont.custom_options.boss_health=150;UberCont.custom_options.enemy_health=50;
        var _types=scrFRScaryFaceNativeTypes();
        assert(array_length(_types)==56,"Native HP acceptance omitted an NTTE enemy constructor");
        scrFRScaryFaceTestNative(_types,_before,0,false);
        scrFRScaryFaceTestNative(_types,_before,3,false);
        scrFRScaryFaceTestNative(_types,_before,3,true);
        scrFRScaryFaceTestSource(_before,0,false);
        scrFRScaryFaceTestSource(_before,3,false);
        scrFRScaryFaceTestSource(_before,3,true);
        scrFRScaryFaceTestTransfers(_before);
        scrFRScaryFaceTestLuck(_before);
        // Unprefixed native enemies preserve original upward-custom behavior,
        // native Scary Face clamping, and preexisting hardmode/Blood drops.
        GameCont.loops=0;UberCont.custom=true;UberCont.hardmode=true;GameCont.crown=crwn_blood;
        UberCont.custom_options.boss_health=200;UberCont.custom_options.enemy_health=50;
        scrFRScaryFaceTestSkill(1);
        var _ordinary=instance_create(62000,62000,Bandit),_boss=instance_create(62128,62000,BanditBoss);
        assert(_ordinary.hp==1 && _ordinary.max_hp==1 && _boss.hp==80 && _boss.max_hp==80,
            "Scary Face finalization altered existing unprefixed native HP behavior");
        var _rad=_boss.raddrop;_boss.hp=100;_boss.max_hp=100;_boss.raddrop=20;
        with(_boss) scrEnemyApplyCreationEffects();
        assert(_boss.hp==80 && _boss.max_hp==80 && _boss.raddrop==9,
            "Native custom/Scary Face/hardmode/Blood arithmetic changed");
        scrNTTESmokeLog("PASS FRONTIER Scary Face 56 actual NTTE native leaf constructors;10 real NTUF factories; ordinary/boss/gold/native derivative/split/loaded possessor/corpse revival/phase/sentinel/late-acquisition/Luck+RNG/drop controls @"+string(30/timescale));
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_back);
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes});
        global.fr_tasks=_tasks;global.rng_state=_rng;lockstep_stop=_stop;random_set_seed(_seed);
        if(ds_exists(_skills,ds_type_list)) ds_list_destroy(_skills);
    }
}

function scrFRScaryFaceTestsStep(_driver) {
    var _state=_driver.fr_scary_face;
    if(_state.round==0) {save_set_value("options","framerate",30);scrOptionsUpdate();_state.round=1;return false;}
    if(_state.round==1) {scrFRScaryFaceTestsRun();save_set_value("options","framerate",60);scrOptionsUpdate();_state.round=2;return false;}
    scrFRScaryFaceTestsRun();return true;
}

function scrFRScaryFaceNativeTypes() {
    return [NTTEAlbinoGator,NTTEBabyGator,NTTEBabyScorpion,NTTEBabyScorpionGold,
        NTTEBat,NTTEBoneGator,NTTECamperBandit,NTTECat,NTTEFullAngler,NTTEFullAnglerGold,
        NTTEFullBabyScorpion,NTTEFullBabyScorpionGold,NTTEFullBanditCamper,NTTEFullBanditHiker,
        NTTEFullBatBoss,NTTEFullBigMaggotSpawn,NTTEFullBloomingAssassin,NTTEFullBloomingAssassinHide,
        NTTEFullBoneRaven,NTTEFullBonusAmmoMimic,NTTEFullBonusHealthMimic,NTTEFullCatBoss,
        NTTEFullCharmOutlineDrawProbe,NTTEFullCoastBoss,NTTEFullCrystalBat,NTTEFullCrystalBrain,
        NTTEFullCrystalHeart,NTTEFullDiver,NTTEFullEel,NTTEFullGull,NTTEFullHammerShark,
        NTTEFullInvCrystalBat,NTTEFullInvMortar,NTTEFullJelly,NTTEFullJellyElite,
        NTTEFullMinerBandit,NTTEFullMortar,NTTEFullPalanking,NTTEFullPelican,
        NTTEFullPetWeaponBoss,NTTEFullPitSquid,NTTEFullPitSquidArm,NTTEFullPopoSecurity,
        NTTEFullPortalGuardian,NTTEFullPuffer,NTTEFullRedSpider,NTTEFullSeal,NTTEFullSealHeavy,
        NTTEFullSpiderling,NTTEFullTesseract,NTTEFullTopRaven,NTTEFullTrafficCrab,NTTEFullYetiCrab,
        NTTEHikerBandit,NTTEMaggotNest,NTTESilverScorpion];
}
