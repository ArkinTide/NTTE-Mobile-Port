function scrNTTEFullNaturalFixtureRead(_path) {
    if(!file_exists(_path)) return undefined
    var _file=file_text_open_read(_path),_text=""
    while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
    file_text_close(_file);return _text
}
function scrNTTEFullBonusRobotNaturalTests() {
    assert(scrNTTESmokeEnabled(),"Natural Bonus Robot requires desktop harness")
    var _before=scrNTTEFullInstances(all),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_progress=global.ntte_full_progress,
        _directory=game_directory,_scratch=working_directory+"bonus-robot-natural-fixture/",
        _seed=random_get_seed(),_halign=draw_get_halign(),_valign=draw_get_valign(),
        _hidden=scrNTTEFullInstances([SpiralCont,NTTEFullUnlockCont]),_dt=timescale/30
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{time:28800-1.5*_dt}}
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    try {
        var _top=instance_find(TopCont,0)
        if(!instance_exists(_top)) _top=instance_create(0,0,TopCont)
        with(Player) race=Race.Fish
        with(_top) event_perform(ev_draw,75)
        assert(global.ntte_full_progress.stats.time<28800 && !scrNTTEFullUnlockGet("skin:bonus robot"),
            "Actual GUI End prematurely unlocked eight-hour Bonus Robot")
        with(_top) event_perform(ev_draw,75)
        assert(global.ntte_full_progress.stats.time>=28800 && !scrNTTEFullUnlockGet("skin:bonus robot"),
            "Actual GUI End awarded Bonus Robot without a Robot player")
        assert(instance_number(NTTEFullUnlockCont)==0,
            "Ineligible Fish GUI End queued a Bonus Robot notification")
        with(Player) race=Race.Robot
        with(_top) event_perform(ev_draw,75)
        var _q=instance_find(NTTEFullUnlockCont,0)
        scrNTTESmokeLog("BONUS ROBOT actual GUIEnd ownership="+string(scrNTTEFullUnlockGet("skin:bonus robot"))
            +" queue_count="+string(instance_number(NTTEFullUnlockCont))
            +" entries="+string(instance_exists(_q)?array_length(_q.unlock):0))
        assert(scrNTTEFullUnlockGet("skin:bonus robot") && instance_number(NTTEFullUnlockCont)==1
            && array_length(_q.unlock)==1 && _q.splash_delay==40 && _q.unlock_delay==50,
            "Actual GUI End failed eligible Robot after eight cumulative hours or original unlock queue")
        var _u=_q.unlock[0],_portrait=scrNTTERefSprite("RobotBonusPortrait"),
            _sound=scr_race_get_sound(Race.Robot,"Cnfm")
        assert(_u.nam[0]=="BONUS ROBOT UNLOCKED" && _u.nam[1]=="BONUS ROBOT"
            && _u.txt=="FOR PLAYING 8 HOURS OF NT:TE" && _u.spr==_portrait && sprite_exists(_portrait)
            && _u.snd==_sound && audio_exists(_sound) && _u.img==0,
            "Natural Bonus Robot queue lost original text, portrait, sound or initial image")
        var _saved=scrNTTEFullNaturalFixtureRead(_scratch+"ntte-full-progress.json"),
            _backup=scrNTTEFullNaturalFixtureRead(_scratch+"ntte-full-progress.json.bak"),
            _queued=json_stringify(_q.unlock)
        assert(!is_undefined(_saved) && json_parse(_saved).unlocks[$ "skin:bonus robot"],
            "Natural Bonus Robot did not persist its real unlock transition")
        with(_top) event_perform(ev_draw,75)
        assert(instance_number(NTTEFullUnlockCont)==1 && instance_find(NTTEFullUnlockCont,0)==_q
            && array_length(_q.unlock)==1 && json_stringify(_q.unlock)==_queued
            && scrNTTEFullNaturalFixtureRead(_scratch+"ntte-full-progress.json")==_saved
            && scrNTTEFullNaturalFixtureRead(_scratch+"ntte-full-progress.json.bak")==_backup,
            "Already-owned Bonus Robot repeated/changed queued notification/save or rewrote backup on GUI End")
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet("skin:bonus robot")
            && global.ntte_full_progress.stats.time>=28800,
            "Actual progress reload lost naturally awarded Bonus Robot/time")
        // A Robot present on the exact crossing frame must award immediately.
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{time:28800-_dt/2}}
        with(_top) event_perform(ev_draw,75)
        assert(scrNTTEFullUnlockGet("skin:bonus robot") && global.ntte_full_progress.stats.time>=28800,
            "Actual Robot GUI End crossing eight hours missed source threshold")
        assert(instance_number(NTTEFullUnlockCont)==1 && array_length(_q.unlock)==2
            && json_stringify(_q.unlock[0])==json_stringify(_u)
            && json_stringify(_q.unlock[1])==json_stringify(_u),
            "Fresh exact-crossing progress failed one matching notification or changed prior queue entry")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_uber)
        global.ntte_full_progress=_progress;game_directory=_directory;random_set_seed(_seed)
        draw_set_halign(_halign);draw_set_valign(_valign)
    }
    scrNTTESmokeLog("PASS actual TopCont.GUIEnd eight-hour time/Fish exclusion/late Robot/exact Robot crossing/original queue+text+portrait+sound/once-only real progress save+backup/reload @"+string(30/timescale))
}
function scrNTTEFullCompassionNaturalTests() {
    assert(scrNTTESmokeEnabled(),"Natural Compassion requires desktop harness")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _progress=global.ntte_full_progress,_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined,
        _directory=game_directory,_scratch=working_directory+"compassion-natural-fixture/",
        _seed=random_get_seed(),_rng=[],_view=[view_xview,view_yview],_skills=ds_list_create(),
        _max=variable_global_exists("pet_max")?global.pet_max:undefined,
        _last=variable_global_exists("pet_max_last")?global.pet_max_last:undefined,
        _hidden=scrNTTEFullInstances([GenCont,LevCont,SkillIcon,UltraIcon,CrownIcon,SkillText,NTTEFullPet,NTTEFullPrompt]),
        _p=instance_find(Player,0),_parked_player=false,_continue=-1,_loaded=noone,
        _hadSave=file_exists(savegame_file),_saveBuffer=-1,_slots_graph={nodes:[]}
    assert(instance_number(Player)==1,"Compassion native continuation fixture expects one desktop Player")
    if(_hadSave) _saveBuffer=buffer_load(savegame_file)
    scrNTTEFullAreaSnapshotContainer(global.playerinstance_list,_slots_graph)
    var _slots={instances:[],containers:_slots_graph.nodes}
    array_copy(_rng,0,global.rng_state,0,array_length(global.rng_state))
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    GameCont.skills=_skills;GameCont.ntte_full_skills={};GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skill_order=[]
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined;GameCont.ntte_pet_max=1
    GameCont.skillpoints=2;GameCont.ultrapoints=0;GameCont.crownpoints=0
    GameCont.crown=Crown.None;GameCont.heavyheart=0;GameCont.wantheavy=false
    global.pet_max=1;global.pet_max_last=1
    _p.ntte_pet=[];_p.ntte_pet_max=1;_p.visible=true;_p.race=Race.Fish
    _p.wep=wep_revolver;_p.bwep=wep_none
    try {
        scrSkills()
        var _a=scrNTTEFullPetCreate(_p.x,_p.y,"Scorpion"),_b=scrNTTEFullPetCreate(_p.x,_p.y,"Parrot")
        assert(scrNTTEFullPetTake(_a,_p),"Natural Compassion fixture failed first actual pet take")
        assert(scrNTTEFullSkillAvailable("compassion") && !scr_skill_can_appear(NTTEFullSkill.Compassion),
            "Closed readiness must gate ordinary Compassion despite full pet capacity")
        global.ntte_full_feature_ready[$ "skill:compassion"]=true
        _p.ntte_pet_max=0;_p.ntte_pet=[]
        assert(!scr_skill_can_appear(NTTEFullSkill.Compassion),"Zero capacity incorrectly entered ordinary Compassion pool")
        _p.ntte_pet_max=2;_p.ntte_pet=[_a,noone]
        assert(!scr_skill_can_appear(NTTEFullSkill.Compassion),"Unfilled nonzero capacity incorrectly entered Compassion pool")
        _p.ntte_pet_max=1;_p.ntte_pet=[_a]
        assert(scr_skill_can_appear(NTTEFullSkill.Compassion),"Full nonzero capacity failed ordinary Compassion eligibility")
        // Find a normal scrDecideSkill RNG state selecting32, without
        // forcing the pool or suppressing any source condition.
        var _roll_seed=1,_found=false
        repeat(2000) {
            random_set_seed(_roll_seed)
            if(scrDecideSkill(false)==NTTEFullSkill.Compassion) {_found=true;break}
            _roll_seed++
        }
        assert(_found,"Actual ordinary scrDecideSkill never offered eligible Compassion")
        var _choice=instance_create(0,0,SkillIcon)
        random_set_seed(_roll_seed)
        _choice.skill=scrDecideSkill(false)
        assert(_choice.skill==NTTEFullSkill.Compassion,"Normal Compassion roll was not repeatable")
        with(_choice) event_user(0)
        assert(scr_skill_get(NTTEFullSkill.Compassion)==1 && GameCont.ntte_pet_max==2 && _p.ntte_pet_max==2
            && GameCont.skillpoints==1 && instance_exists(LevCont) && file_exists(savegame_file),
            "Actual normal SkillIcon/submit/save failed Compassion grant or applied capacity delta twice")
        assert(scrNTTEFullSkillAvailable("compassion") && !scr_skill_can_appear(NTTEFullSkill.Compassion),
            "Held Compassion lost source availability or duplicated in ordinary unheld pool")
        assert(!scr_skill_set(NTTEFullSkill.Compassion,1) && GameCont.ntte_pet_max==2 && _p.ntte_pet_max==2,
            "Unchanged Compassion setter repeated its capacity delta")
        assert(scrNTTEFullPetTake(_b,_p),"Expanded natural capacity did not allow second actual pet take")
        // Serialize the genuine native session/player records, then load
        // into a newly constructed native Player. No skill_take is replayed.
        GameCont.ntte_full_pet_save=scrNTTEFullPetExport()
        _continue=buffer_create(0xffff,buffer_grow,1)
        scrSavegameSession(_continue,false);scrSavegamePlayers(_continue,false)
        var _petSave=json_parse(json_stringify(GameCont.ntte_full_pet_save))
        GameCont.ntte_pet_max=99;GameCont.ntte_full_skills={}
        buffer_seek(_continue,buffer_seek_start,0);scrSavegameSession(_continue,true)
        instance_deactivate_object(_p);_parked_player=true
        scrSavegamePlayers(_continue,true);_loaded=instance_find(Player,0)
        assert(instance_exists(_loaded) && _loaded!=_p && _loaded.ntte_pet_max==2
            && GameCont.ntte_pet_max==2 && scr_skill_get(NTTEFullSkill.Compassion)==1,
            "Actual native session/player continue lost Compassion or replayed capacity delta")
        assert(scrNTTEFullPetImport(_petSave),"Compassion native continuation failed saved pet reconstruction")
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(_loaded.ntte_pet_max==2 && GameCont.ntte_pet_max==2 && array_length(_loaded.ntte_pet)==2,
            "Actual normal Step after continuation replayed capacity delta or lost saved pets")
        var _released=_loaded.ntte_pet[1],_retained=_loaded.ntte_pet[0],_fx=instance_number(HealFX)
        scr_skill_set(NTTEFullSkill.Compassion,0)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(scr_skill_get(NTTEFullSkill.Compassion)==0 && GameCont.ntte_pet_max==1 && _loaded.ntte_pet_max==1
            && array_length(_loaded.ntte_pet)==1 && _loaded.ntte_pet[0]==_retained && _retained.leader==_loaded
            && _released.leader==noone && _released.can_take && !_released.persistent && instance_number(HealFX)==_fx+1,
            "Continued Compassion removal failed one exact delta/source last-pet release/PetLost effect")
        scr_skill_set(NTTEFullSkill.Compassion,0)
        with(GameCont) event_perform(ev_step,ev_step_normal)
        assert(GameCont.ntte_pet_max==1 && _loaded.ntte_pet_max==1 && instance_number(HealFX)==_fx+1,
            "Repeated Compassion removal applied delta or released another pet twice")
    }
    finally {
        var _all=scrNTTEFullInstances(all)
        for(var _i=array_length(_all)-1;_i>=0;--_i)
            if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
        if(_parked_player) instance_activate_object(_p)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players)
        scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_slots)
        ds_list_destroy(_skills);if(buffer_exists(_continue)) buffer_delete(_continue)
        if(buffer_exists(_saveBuffer)) {buffer_save(_saveBuffer,savegame_file);buffer_delete(_saveBuffer)}
        else if(!_hadSave && file_exists(savegame_file)) file_delete(savegame_file)
        global.ntte_full_progress=_progress;global.ntte_full_feature_ready=_ready;game_directory=_directory
        global.pet_max=_max;global.pet_max_last=_last;global.rng_state=_rng;random_set_seed(_seed)
        view_xview=_view[0];view_yview=_view[1]
    }
    scrNTTESmokeLog("PASS source nonzero full-capacity Compassion ordinary pool/closed-ready/normal RNG offer/actual SkillIcon-submit-save/native session+new Player continue/pets/no repeated delta/exact remove+last-pet release @"+string(30/timescale))
}
