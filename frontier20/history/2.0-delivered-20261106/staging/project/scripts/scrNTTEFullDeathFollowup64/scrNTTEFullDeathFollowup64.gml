// Real Player events. Keep an untouched original body so a disposable body's
// Destroy event can be inspected without committing a test GameOver/progress.
function scrNTTEFullDeath64FixtureBegin() {
    var _fixture=scrNTTEFullVanillaFixtureBegin(),_graph={nodes:[]},
        _state={fixture:_fixture,players:scrNTTEFullAreaGeneratorSnapshot(Player),
            uber:scrNTTEFullAreaGeneratorSnapshot(UberCont),graph:_graph,
            frame:current_frame,stop:lockstep_stop,immortal:global.__debug_immortality,
            count:player_count,skills:ds_list_create(),parked:scrNTTEFullInstances([SitDown,Cinematic,MenuGen])}
    scrNTTEFullAreaSnapshotContainer(KeyCont,_graph)
    for(var _i=0;_i<array_length(_state.parked);++_i) instance_deactivate_object(_state.parked[_i])
    GameCont.skills=_state.skills;GameCont.ntte_full_native_skill_counts={}
    GameCont.area=area_desert;GameCont.underwater=false
    UberCont.opt_practice=false;global.__debug_immortality=false;lockstep_stop=false;player_count=1
    assert(!scrGameIsLockState(),"Death native event fixture is locked")
    current_frame=600
    return _state
}
function scrNTTEFullDeath64FixtureEnd(_state) {
    scrNTTEFullMergedRuntimeTestCleanup(_state.fixture.before)
    scrNTTEFullAreaGeneratorRestore(_state.players)
    scrNTTEFullAreaGeneratorRestore(_state.uber)
    scrNTTEFullAreaGeneratorRestore({instances:[],containers:_state.graph.nodes})
    scrNTTEFullVanillaFixtureEnd(_state.fixture)
    for(var _i=0;_i<array_length(_state.parked);++_i) instance_activate_object(_state.parked[_i])
    current_frame=_state.frame;lockstep_stop=_state.stop;global.__debug_immortality=_state.immortal
    player_count=_state.count;ds_list_destroy(_state.skills)
}
function scrNTTEFullDeath64Player() {
    var _p=instance_create(210000,210000,Player)
    with(_p) {
        hp=8;max_hp=8;lsthealth=8;spirit=false;spirit_index=0;can_spirit=false
        fainted=0;can_die=true;visible=true;race=Race.Fish;is_me=false;speed=0
        wep=wep_none;bwep=wep_none;ntte_state=undefined;bntte_state=undefined
        can_walk=false;can_aim=false;can_spec=false;can_pick=false;roll=0
        bonus_spirit=[];bonus_health=0;bonus_ammo=0;ntte_pet=[];ntte_native_race=-1
        KeyCont.hold_fire[index]=false;KeyCont.press_fire[index]=false;KeyCont.release_fire[index]=false
        KeyCont.hold_spec[index]=false;KeyCont.press_spec[index]=false;KeyCont.release_spec[index]=false
        KeyCont.press_swap[index]=false;KeyCont.press_pick[index]=false;KeyCont.moving[index]=0
    }
    return _p
}
function scrNTTEFullDeath64Step(_p) {
    current_frame+=timescale
    with(_p) event_perform(ev_step,ev_step_normal)
}
function scrNTTEFullPlayerDeathGraceNativeTests() {
    var _fixture=scrNTTEFullDeath64FixtureBegin(),_cases=0
    try {
        // Source tepickups5526..5545 grants a finite5-tick grace on one token;
        // absence of the Strong Spirit mutation must never freeze that grace.
        var _p=scrNTTEFullDeath64Player(),_token={active:true}
        _p.bonus_spirit=[_token];_p.hp=0
        scrNTTEFullDeath64Step(_p)
        assert(instance_exists(_p) && _p.hp==1 && !_token.active && _p.spirit_index>0,
            "Actual bonus halo failed its one ordinary life-saving trigger")
        var _used=_p.spirit_index
        repeat(ceil(12/timescale)) scrNTTEFullDeath64Step(_p)
        assert(_p.spirit_index>=2 && _p.spirit_index>_used && scr_skill_get(mut_strong_spirit)==0,
            "Consumed bonus halo froze permanent immunity in the absence of Strong Spirit")
        _p.hp=0;scrNTTEFullDeath64Step(_p)
        assert(!instance_exists(_p),"Consumed bonus halo made a later ordinary lethal hit immortal")
        _cases++

        // Existing affected saves carry only an old nonzero animation index.
        _p=scrNTTEFullDeath64Player();_p.spirit_index=0.4
        repeat(ceil(12/timescale)) scrNTTEFullDeath64Step(_p)
        _p.hp=0;scrNTTEFullDeath64Step(_p)
        assert(!instance_exists(_p),"Legacy0.4 grace state stayed immortal without the mutation")
        _cases++

        // Actual Orchid acquisition/Destroy adapter, not a hand-written
        // post-removal Player flag, supplies the temporary native mutation.
        _p=scrNTTEFullDeath64Player()
        var _timer=instance_create(0,0,NTTEFullOrchidSkill)
        _timer.skill=mut_strong_spirit;_timer.num=1;_timer.time=600
        with(_timer) scrNTTEFullOrchidSetup()
        assert(scr_skill_get(mut_strong_spirit)>0 && _p.spirit,
            "Real Orchid did not grant its native temporary Strong Spirit")
        _p.hp=0
        scrNTTEFullDeath64Step(_p)
        assert(instance_exists(_p) && _p.hp==1 && !_p.spirit,
            "Genuine Strong Spirit lost its ordinary once-only lethal protection")
        instance_destroy(_timer)
        assert(scr_skill_get(mut_strong_spirit)==0 && !_p.spirit,
            "Real Orchid destruction did not remove the consumed temporary mutation")
        repeat(ceil(12/timescale)) scrNTTEFullDeath64Step(_p)
        _p.hp=0;scrNTTEFullDeath64Step(_p)
        assert(!instance_exists(_p),"Removing temporary Strong Spirit froze its protection window")
        _cases++

        _p=scrNTTEFullDeath64Player();_p.hp=0
        scrNTTEFullDeath64Step(_p)
        assert(!instance_exists(_p),"Normal solo lethal Player did not reach genuine native Destroy")
        _cases++
    } finally {scrNTTEFullDeath64FixtureEnd(_fixture)}
    scrNTTESmokeLog("PASS death grace native: bonus token/no mutation, legacy0.4 save, temporary StrongSpirit removal and normal solo Destroy cases="+string(_cases)+" @"+string(30/timescale))
}
function scrNTTEFullPlayerPracticeFaintNativeTests() {
    var _fixture=scrNTTEFullDeath64FixtureBegin(),_cases=0
    try {
        var _p=scrNTTEFullDeath64Player()
        UberCont.opt_practice=true;_p.hp=0;scrNTTEFullDeath64Step(_p)
        assert(instance_exists(_p) && _p.fainted==CHEAT_PRACTICE_FAINTED_TIME && _p.mask_index==mskNone,
            "Enabled practice no longer enters its original45-second timeout")
        // Original `if !fainted` can treat a fractional remainder as false;
        // native boolean conversion may recover one physical frame early.
        // Test that unchanged lifecycle rather than imposing a numeric clamp.
        var _frames=ceil(CHEAT_PRACTICE_FAINTED_TIME/timescale),_elapsed=0
        while(_p.hp==0 && _elapsed<=_frames) {
            scrNTTEFullDeath64Step(_p);_elapsed++
        }
        assert(_elapsed>=_frames-1 && _elapsed<=_frames
            && _p.fainted>=0 && _p.fainted<=timescale && _p.hp==1
            && _p.mask_index==mskPlayer && _p.image_alpha==1,
            "Actual practice timeout changed its original45-second lifecycle: frames="
            +string(_elapsed)+" expected="+string(_frames)+" remaining="+string(_p.fainted))
        _cases++

    } finally {scrNTTEFullDeath64FixtureEnd(_fixture)}
    scrNTTESmokeLog("PASS practice faint native: original45-second lifecycle within one native frame, behavior unchanged cases="+string(_cases)+" @"+string(30/timescale))
}
function scrNTTEFullPlayerPracticeOptionNativeTests() {
    var _before=scrNTTEFullInstances(all),_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),
        _save=UberCont.saveData,_save_bytes=ds_map_write(_save),_map=ds_map_create(),
        _parked=scrNTTEFullInstances([MenuOptions,BackButton,ResourcepackManager,CustomModeMenu]),
        _old_directory=game_directory,_seed=random_get_seed(),_cheats=global.cheats,
        _language=global.language_current,_font=global.language_font_default,
        _bigfont=global.language_font_bigname_default,_drawfont=draw_get_font(),
        _custom_seed=scrCustomParam("seed"),_custom_seed_enable=scrCustomParam("seed_enable"),
        _reminders=variable_global_exists("ntte_full_reminders")?global.ntte_full_reminders:undefined
    ds_map_copy(_map,_save);UberCont.saveData=_map
    game_directory=working_directory+"practice-option-native-"+string(get_timer())+"/"
    directory_create(game_directory)
    for(var _i=0;_i<array_length(_parked);++_i) instance_deactivate_object(_parked[_i])
    try {
        var _find=function(_rows,_key) {
            var _found=undefined
            for(var _i=0;_i<array_length(_rows);++_i) if(_rows[_i][$ "key"]==_key) {
                assert(is_undefined(_found),"Native menu duplicated option "+_key)
                _found=_rows[_i]
            }
            return _found
        },_languages=["Simplified Chinese","English"],_labels=["练习模式","PRACTICE"],
            _seedlabels=["使用种子","Seeded run"],_numberlabels=["种子","Seed"],
            _grillerlabels=["启用变异自选","GRILLER MODE"]
        for(var _lang=0;_lang<array_length(_languages);++_lang) {
            scrLanguageSet(_languages[_lang])
            var _menu=instance_create(0,0,MenuOptions),
                _row=_find(_menu.options[OptionCategory.Cheats],"cheats_practice"),
                _griller=_find(_menu.options[OptionCategory.Cheats],"cheats_griller"),
                _seedrow=_find(_menu.options[OptionCategory.CustomMode_Generation],"seed_enable"),
                _numberrow=_find(_menu.options[OptionCategory.CustomMode_Generation],"seed")
            assert(is_struct(_row) && _row.type=="switch" && _row.name==_labels[_lang]
                && loc("CheatOptions:Practice","PRACTICE")==_labels[_lang],
                "Actual Cheats practice row has the wrong translated label")
            assert(_griller.name==_grillerlabels[_lang] && _seedrow.name==_seedlabels[_lang]
                && _numberrow.name==_numberlabels[_lang],
                "Practice label repair incorrectly changed Griller or actual custom-seed labels: language="
                +_languages[_lang]+" actual="+string([_griller.name,_seedrow.name,_numberrow.name])
                +" expected="+string([_grillerlabels[_lang],_seedlabels[_lang],_numberlabels[_lang]]))
            assert(is_undefined(_find(_menu.options[OptionCategory.Game],"cheats_practice")),
                "Practice repair unexpectedly added a duplicate Game menu feature")
            // Existing Cheats row and native switch, using the same map write
            // as Other10; the production practice/death semantics are unchanged.
            _row.value=false
            with(_menu) method_execute(element_functions[$ "switch"],_row)
            _map[? _row.key]=_row.value
            assert(save_get_option("cheats","practice",false),
                "Existing Cheats practice switch did not write its native key")
            with(_menu) method_execute(element_functions[$ "switch"],_row)
            _map[? _row.key]=_row.value
            assert(!save_get_option("cheats","practice",true),
                "Existing Cheats practice switch did not turn its native key off")
            instance_destroy(_menu,false)
        }
        assert(scrCustomParam("seed")==_custom_seed && scrCustomParam("seed_enable")==_custom_seed_enable,
            "Translated practice option changed the independent custom seed preferences")
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_parked);++_i) instance_activate_object(_parked[_i])
        scrNTTEFullAreaGeneratorRestore(_uber);UberCont.saveData=_save;ds_map_destroy(_map)
        game_directory=_old_directory;random_set_seed(_seed);global.cheats=_cheats
        global.ntte_full_reminders=_reminders
        global.language_current=_language;global.language_font_default=_font
        global.language_font_bigname_default=_bigfont;draw_set_font(_drawfont)
        assert(ds_map_write(_save)==_save_bytes,"Practice option fixture touched the actual save map")
    }
    scrNTTESmokeLog("PASS practice option native: existing Cheats row, real simplified-Chinese/English labels, native switch and independent custom-seed labels/preferences unchanged @"+string(30/timescale))
}
