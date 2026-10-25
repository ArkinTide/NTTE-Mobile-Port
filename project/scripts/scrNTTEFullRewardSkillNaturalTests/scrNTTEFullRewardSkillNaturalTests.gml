function scrNTTEFullRatRewardNaturalTests() {
    assert(scrNTTESmokeEnabled(),"Natural Rat rewards require desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_progress=global.ntte_full_progress,
        _ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined,
        _seed=random_get_seed(),_rng=[],_skills=ds_list_create(),_p=instance_find(Player,0),
        _pick=KeyCont.press_pick[_p.index],_hidden=scrNTTEFullInstances([GenCont,LevCont,NTTEFullPrompt,
            NTTEFullChestShop,NTTEFullOrchidBall,NTTEFullOrchidSkill,Portal,PortalShock,WepPickup,enemy]),
        _directory=game_directory,_scratch=working_directory+"rat-reward-natural-fixture/",_buffer=-1
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={}
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined;GameCont.crown=Crown.None
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0
    _p.x=90000;_p.y=90000;_p.race=Race.Fish;_p.can_pick=true;_p.visible=true;_p.speed=0
    try {
        var _targets=[NTTEFullSkill.BatEars,NTTEFullSkill.LeadRibs,NTTEFullSkill.MagneticPulse,NTTEFullSkill.ToadBreath]
        for(var _r=0;_r<array_length(_targets);++_r) {
            var _wanted=_targets[_r],_chosen=noone,_chest=noone,_rat_id=noone,_attempt=0,_siblings=[]
            assert(!scr_skill_can_appear(_wanted) && scrNTTEFullSkillAvailable(_wanted,true),
                "Rat reward changed source hidden ordinary/rat-only skill eligibility")
            // Real source shuffled chest pools. Search actual RNG outcomes;
            // never substitute stock or force a locked ordinary mutation.
            while(_attempt<250 && !instance_exists(_chosen)) {
                var _round_before=scrNTTEFullInstances(all)
                random_set_seed(70000+1000*_r+_attempt++)
                _chest=instance_create(_p.x,_p.y,NTTEFullRatChest);_rat_id=_chest
                with(_chest) event_perform(ev_step,ev_step_normal)
                assert(!instance_exists(_chest),"Natural Rat chest contact did not run inherited real chest Step")
                _siblings=[]
                with(NTTEFullChestShop) if(creator==_rat_id) {
                    event_perform(ev_step,ev_step_normal);array_push(_siblings,id)
                    if(drop==_wanted) _chosen=id
                }
                assert(array_length(_siblings)==2 && _siblings[0].drop!=_siblings[1].drop,
                    "Natural Rat chest lost two distinct source shuffled options")
                if(!instance_exists(_chosen)) {
                    var _new=scrNTTEFullInstances(all)
                    for(var _i=array_length(_new)-1;_i>=0;--_i)
                        if(array_get_index(_round_before,_new[_i])<0 && instance_exists(_new[_i])) instance_destroy(_new[_i],false)
                }
            }
            assert(instance_exists(_chosen),"Natural Rat shuffled pools never offered target rat-only mutation")
            _p.x=_chosen.x;_p.y=_chosen.y
            with(_chosen.prompt) event_perform(ev_step,ev_step_normal)
            assert(scrNTTEFullPromptWinner(_p)==_chosen.prompt,"Natural Rat stock prompt did not win actual overlap/priority")
            KeyCont.press_pick[_p.index]=true;with(_p) scrNTTEFullPromptPlayerStep()
            KeyCont.press_pick[_p.index]=false
            assert(_chosen.prompt.pick==_p.index,"Natural Rat prompt ignored native pickup key")
            var _orbs_before=scrNTTEFullInstances(NTTEFullOrchidBall)
            with(_chosen) event_perform(ev_step,ev_step_normal)
            assert(_siblings[0].open==0 && _siblings[1].open==0,"Rat purchase did not close sibling stock once")
            var _orb=noone
            with(NTTEFullOrchidBall) if(array_get_index(_orbs_before,id)<0) _orb=id
            assert(instance_exists(_orb) && _orb.skill==_wanted && _orb.type=="portal" && _orb.creator==_rat_id,
                "Natural Rat input purchase did not emit source-owned real portal mutation ball")
            _orb.x=_p.x;_orb.y=_p.y;_orb.target=_p;_orb.target_seek=true
            with(_orb) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_orb) && scr_skill_get(_wanted)==1,"Real Rat ball contact failed native Destroy grant")
            var _timer=noone
            with(NTTEFullOrchidSkill) if(skill==_wanted) _timer=id
            assert(instance_exists(_timer) && !_timer.setup && _timer.ntte_applied && _timer.time==2,
                "Natural Rat grant lost source two-portal timer or applied marker")
            // Real native session restores counts, Orchid import restores
            // already-applied timers without replaying their grants.
            var _timers=json_parse(json_stringify(scrNTTEFullOrchidExport()))
            _buffer=buffer_create(0xffff,buffer_grow,1);scrSavegameSession(_buffer,false)
            GameCont.ntte_full_skills={}
            buffer_seek(_buffer,buffer_seek_start,0);scrSavegameSession(_buffer,true)
            assert(scrNTTEFullOrchidImport(_timers) && scr_skill_get(_wanted)==1,
                "Rat native session+timer continue duplicated or lost natural grant")
            buffer_delete(_buffer);_buffer=-1
            with(NTTEFullOrchidSkill) if(skill==_wanted) _timer=id
            GameCont.ntte_portal_closed=false
            repeat(2) {
                var _portal=instance_create(92000,92000,Portal);_portal.endgame=0
                with(GameCont) event_perform(ev_step,ev_step_end)
                var _left=_timer.time
                with(GameCont) event_perform(ev_step,ev_step_end)
                assert(_timer.time==_left,"Natural Rat timer consumed same portal twice")
                instance_destroy(_portal,false)
                with(GameCont) event_perform(ev_step,ev_step_end)
            }
            assert(_timer.time==0 && scr_skill_get(_wanted)==1,"Rat two-portal reward revoked before source flash completed")
            repeat(ceil(3/timescale)) if(instance_exists(_timer)) with(_timer) event_perform(ev_step,ev_step_normal)
            assert(!instance_exists(_timer) && scr_skill_get(_wanted)==0,
                "Natural Rat two-portal expiry failed one exact revoke after native continue")
            assert(array_length(variable_struct_get_names(global.ntte_full_feature_ready))==0,
                "Natural Rat grant opened ordinary feature readiness")
        }
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        ds_list_destroy(_skills);if(buffer_exists(_buffer)) buffer_delete(_buffer)
        global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready;game_directory=_directory
        KeyCont.press_pick[_p.index]=_pick;global.rng_state=_rng;random_set_seed(_seed)
    }
    scrNTTESmokeLog("PASS all4 rat-only mutations: actual contact chest/shuffled distinct stock/native pickup prompt/shop Step/sibling closure/orb contact+Destroy grant/native session+timer continue/two real portal intervals/flash expiry/exact revoke/closed readiness @"+string(30/timescale))
}

function scrNTTEFullFlowerRewardNaturalTests() {
    assert(scrNTTESmokeEnabled(),"Natural Flower rewards require desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _progress=global.ntte_full_progress,_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined,
        _seed=random_get_seed(),_rng=[],_skills=ds_list_create(),_p=instance_find(Player,0),
        _pick=KeyCont.press_pick[_p.index],_view=[view_xview,view_yview],
        _hidden=scrNTTEFullInstances([GenCont,LevCont,Menu,NTTEFullPrompt,NTTEFullOrchidSkill,NTTEFullPet,
            SkillIcon,UltraIcon,CrownIcon,SkillText,WepPickup,enemy]),
        _directory=game_directory,_scratch=working_directory+"flower-reward-natural-fixture/",_buffer=-1,
        _hadSave=file_exists(savegame_file),_saveBuffer=-1
    if(_hadSave) _saveBuffer=buffer_load(savegame_file)
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}};global.ntte_full_feature_ready={}
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined;GameCont.crown=Crown.None
    GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0
    _p.x=90000;_p.y=90000;_p.race=Race.Plant;_p.can_pick=true;_p.visible=true;_p.speed=0
    _p.wep=wep_revolver;_p.bwep=wep_none
    try {
        scr_skill_set(mut_heavy_heart,1)
        var _flower=instance_create(_p.x,_p.y,NTTEFullVaultFlower)
        assert(_flower.alive && _flower.skill==mut_heavy_heart && _flower.unlock && instance_exists(_flower.prompt),
            "Natural Plant+HeavyHeart flower constructor lost source priority/unowned-skin gate/prompt")
        with(_flower.prompt) event_perform(ev_step,ev_step_normal)
        assert(scrNTTEFullPromptWinner(_p)==_flower.prompt,"Natural Flower real prompt did not win native overlap")
        KeyCont.press_pick[_p.index]=true;with(_p) scrNTTEFullPromptPlayerStep()
        KeyCont.press_pick[_p.index]=false
        assert(_flower.prompt.pick==_p.index,"Natural Flower ignored native pickup input")
        with(_flower) event_perform(ev_step,ev_step_normal)
        assert(scr_skill_get(mut_heavy_heart)==0 && scr_skill_get(NTTEFullSkill.Reroll)==1
            && GameCont.ntte_reroll==mut_heavy_heart && GameCont.skillpoints==1
            && scrNTTEFullUnlockGet("skin:orchid plant"),
            "Natural Flower Step failed reroll removal/pending point/skin award from real prompt")
        var _skinfile=scrNTTEFullNaturalFixtureRead(_scratch+"ntte-full-progress.json")
        assert(!is_undefined(_skinfile) && json_parse(_skinfile).unlocks[$ "skin:orchid plant"],
            "Natural Plant Flower did not persist actual Orchid skin award")
        with(_flower) event_perform(ev_step,ev_step_normal)
        assert(!_flower.alive && !_flower.prompt.visible,"Used Flower failed natural next-Step wilt/prompt suppression")
        // Native continuation supplies already-applied reroll fields and
        // removed native mutation. It must not take the reward again.
        _buffer=buffer_create(0xffff,buffer_grow,1);scrSavegameSession(_buffer,false)
        ds_list_clear(GameCont.skills);GameCont.ntte_full_skills={};GameCont.ntte_reroll=undefined
        buffer_seek(_buffer,buffer_seek_start,0);scrSavegameSession(_buffer,true)
        assert(scr_skill_get(NTTEFullSkill.Reroll)==1 && scr_skill_get(mut_heavy_heart)==0
            && GameCont.ntte_reroll==mut_heavy_heart && GameCont.skillpoints==1,
            "Actual native pending Flower continuation replayed removal or lost its point/target")
        scr_skill_set(NTTEFullSkill.Reroll,0)
        assert(scr_skill_get(mut_heavy_heart)==1 && GameCont.skillpoints==0,
            "Continued natural Flower cancel failed exact restored stack/point")
        scr_skill_set(NTTEFullSkill.Reroll,0)
        assert(scr_skill_get(mut_heavy_heart)==1 && GameCont.skillpoints==0,
            "Repeated natural Flower cancel restored stack or point twice")
        // Existing pending reroll/HUD wilts another flower before it can
        // create an interactive prompt or award a second reward.
        scr_skill_set(NTTEFullSkill.Reroll,1)
        var _blocked=instance_create(90200,90000,NTTEFullVaultFlower)
        assert(!_blocked.alive && !instance_exists(_blocked.prompt),"Pending Reroll allowed a second living Flower")
        scr_skill_set(NTTEFullSkill.Reroll,0)
        _p.x=90400
        var _again=instance_create(_p.x,_p.y,NTTEFullVaultFlower)
        assert(_again.alive && !_again.unlock && _again.skill==mut_heavy_heart,
            "Owned Orchid skin repeated unlock priority or lost ordinary source available target")
        with(_again.prompt) event_perform(ev_step,ev_step_normal)
        KeyCont.press_pick[_p.index]=true;with(_p) scrNTTEFullPromptPlayerStep()
        KeyCont.press_pick[_p.index]=false
        with(_again) event_perform(ev_step,ev_step_normal)
        GameCont.skillpoints=2
        var _choice=instance_create(0,0,SkillIcon);_choice.skill=mut_extra_feet
        with(_choice) event_user(0)
        assert(scr_skill_get(mut_extra_feet)==1 && scr_skill_get(NTTEFullSkill.Reroll)==0
            && GameCont.ntte_reroll_hud==mut_extra_feet && GameCont.skillpoints==1 && file_exists(savegame_file),
            "Natural Flower to actual SkillIcon/submit/save chain lost completed blessing")
        // Clear only new mutation UI before isolated source constructor
        // branches. No flower can be revived by changing skills later.
        instance_destroy(LevCont,false);instance_destroy(SkillIcon,false)
        GameCont.ntte_reroll_hud=undefined
        scr_skill_set(mut_extra_feet,0);scr_skill_set(mut_heavy_heart,0)
        var _empty=instance_create(90600,90000,NTTEFullVaultFlower)
        assert(!_empty.alive && !instance_exists(_empty.prompt),"No-mutation Flower invented a reroll reward")
        _p.race=Race.Fish;scr_skill_set(mut_heavy_heart,1)
        var _fish=instance_create(90800,90000,NTTEFullVaultFlower),_orchids=0
        with(NTTEFullPet) if(pet=="Orchid") _orchids++
        assert(_fish.alive && !_fish.unlock,"Non-Plant Flower incorrectly selected Orchid skin unlock branch")
        _fish.hp=0;with(_fish) event_perform(ev_step,ev_step_normal)
        var _after=0
        with(NTTEFullPet) if(pet=="Orchid") _after++
        assert(!instance_exists(_fish) && _after==_orchids+1 && !GameCont.ntte_vault_flower,
            "Actual living Flower death failed natural Orchid pet alternative reward/level state")
        assert(array_length(variable_struct_get_names(global.ntte_full_feature_ready))==0,
            "Natural Flower rewards enabled ordinary feature readiness")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        ds_list_destroy(_skills);if(buffer_exists(_buffer)) buffer_delete(_buffer)
        if(buffer_exists(_saveBuffer)) {buffer_save(_saveBuffer,savegame_file);buffer_delete(_saveBuffer)}
        else if(!_hadSave && file_exists(savegame_file)) file_delete(savegame_file)
        global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready;game_directory=_directory
        KeyCont.press_pick[_p.index]=_pick;global.rng_state=_rng;random_set_seed(_seed)
        view_xview=_view[0];view_yview=_view[1]
    }
    scrNTTESmokeLog("PASS source Plant+HeavyHeart Flower constructor/native input+real prompt/Step reroll+persisted skin/natural wilt/native pending continue/once-only cancel/blocked+empty+nonPlant/actual SkillIcon-submit-save/blessed HUD/living death Orchid pet/closed readiness @"+string(30/timescale))
}
