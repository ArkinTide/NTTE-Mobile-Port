// Original unlock predicates, genuine native object/input/death events.
// These cases never open readiness or assign a threshold counter.
function scrNTTEFullSkinUnlockNaturalRead(_path) {
    if(!file_exists(_path)) return undefined
    var _file=file_text_open_read(_path),_text=""
    while(!file_text_eof(_file)) {_text+=file_text_read_string(_file);file_text_readln(_file)}
    file_text_close(_file);return _text
}
function scrNTTEFullSkinUnlockNaturalBegin(_fixtureName) {
    assert(scrNTTESmokeEnabled(),"Natural skin unlocks require the explicit desktop harness")
    var _scope={before:scrNTTEFullInstances(all),
        controllers:scrNTTEFullAreaGeneratorSnapshot([GameCont,Player,UberCont,KeyCont,BackCont,TopCont]),
        hidden:scrNTTEFullInstances([GenCont,LevCont,Menu,enemy,NTTEFullPet,NTTEFullPetRevive,
            NTTEFullPrompt,NTTEFullChestShop,Portal,PortalShock,WepPickup,chestprop]),
        globals:[],graph:undefined,directory:game_directory,seed:random_get_seed(),tick:current_frame,
        stop:lockstep_stop,view:[view_xview,view_yview],savedata:ds_map_write(UberCont.saveData),
        scratch:working_directory+"skin-unlock-natural-"+_fixtureName+"-"+string(get_timer())+"/",
        skills:ds_list_create()}
    var _names=variable_struct_get_names(global),_graph={nodes:[]}
    for(var _i=0;_i<array_length(_names);++_i) {
        var _name=_names[_i],_value=variable_global_get(_name)
        array_push(_scope.globals,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
    }
    _scope.graph={instances:[],containers:_graph.nodes}
    for(var _i=0;_i<array_length(_scope.hidden);++_i) instance_deactivate_object(_scope.hidden[_i])
    directory_create(_scope.scratch);game_directory=_scope.scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_feature_ready={}
    lockstep_stop=false
    GameCont.skills=_scope.skills;GameCont.ntte_full_skills={};GameCont.ntte_full_native_skill_counts={}
    GameCont.ntte_full_skill_order=[];GameCont.crown=Crown.None;GameCont.loops=0;GameCont.hard=3
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.ntte_pet_max=1
    GameCont.ntte_reroll=undefined;GameCont.ntte_reroll_hud=undefined
    with(Player) {
        x=154000+index*256;y=154000;xprevious=x;yprevious=y;visible=true;can_pick=true;speed=0
        race=Race.Fish;bskin=0;wep=wep_revolver;bwep=wep_none
        ntte_state=scrNTTENewState(wep_revolver);bntte_state=undefined;ntte_pet=[];ntte_pet_max=1
        hp=1000;max_hp=1000;nexthurt=current_frame+10000
    }
    return _scope
}
function scrNTTEFullSkinUnlockNaturalEnd(_scope) {
    scrNTTEFullMergedRuntimeTestCleanup(_scope.before)
    for(var _i=0;_i<array_length(_scope.hidden);++_i) instance_activate_object(_scope.hidden[_i])
    scrNTTEFullAreaGeneratorRestore(_scope.controllers)
    scrNTTEFullAreaGeneratorRestore(_scope.graph)
    for(var _i=0;_i<array_length(_scope.globals);++_i)
        variable_global_set(_scope.globals[_i][0],_scope.globals[_i][1])
    ds_map_read(UberCont.saveData,_scope.savedata)
    ds_list_destroy(_scope.skills)
    game_directory=_scope.directory;random_set_seed(_scope.seed);current_frame=_scope.tick
    lockstep_stop=_scope.stop;view_xview=_scope.view[0];view_yview=_scope.view[1]
    var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
    for(var _i=0;_i<array_length(_files);++_i)
        if(file_exists(_scope.scratch+_files[_i])) file_delete(_scope.scratch+_files[_i])
}
function scrNTTEFullSkinUnlockNaturalPersisted(_key) {
    var _saved=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")
    assert(!is_undefined(_saved) && scrNTTEFullValue(json_parse(_saved).unlocks,_key,false),
        "Natural source unlock missing from the actual progress file: "+_key)
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    assert(scrNTTEFullProgressLoad() && scrNTTEFullUnlockGet(_key),"Real progress reload lost "+_key)
    assert(array_length(variable_struct_get_names(global.ntte_full_feature_ready))==0,
        "Natural source reward opened a production readiness key")
    return _saved
}
function scrNTTEFullAnglerSkinNaturalKill(_gold,_fish) {
    with(Player) race=_fish?Race.Fish:Race.Crystal
    var _before=GameCont.kills,_object=_gold?NTTEFullAnglerGold:NTTEFullAngler,
        _angler=instance_create(156000,156000,_object)
    assert(_angler.ntte_full_gold==_gold && _angler.hp==(_gold?72:45),
        "Natural Angler source constructor lost actual ordinary/golden identity")
    _angler.hp=0
    with(_angler) event_perform(ev_step,ev_step_normal)
    assert(!instance_exists(_angler) && GameCont.kills==_before+1,
        "Genuine Angler native Step/Destroy chain did not die or count exactly one enemy kill")
}
function scrNTTEFullAnglerSkinNaturalTests() {
    var _scope=scrNTTEFullSkinUnlockNaturalBegin("angler")
    try {
        scrNTTEFullAnglerSkinNaturalKill(false,true)
        assert(!scrNTTEFullUnlockGet("skin:angler fish"),"Ordinary Angler death with Fish incorrectly unlocked golden skin")
        scrNTTEFullAnglerSkinNaturalKill(true,false)
        assert(!scrNTTEFullUnlockGet("skin:angler fish"),"Genuine golden Angler death without Fish incorrectly unlocked skin")
        scrNTTEFullAnglerSkinNaturalKill(true,true)
        assert(scrNTTEFullUnlockGet("skin:angler fish"),"Genuine golden Angler death with Fish failed original skin award")
        var _saved=scrNTTEFullSkinUnlockNaturalPersisted("skin:angler fish"),
            _backup=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")
        scrNTTEFullAnglerSkinNaturalKill(true,true)
        assert(scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")==_saved
            && scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")==_backup,
            "Already-owned real golden Angler death rewrote source unlock save/backup")
    }
    finally {scrNTTEFullSkinUnlockNaturalEnd(_scope)}
    scrNTTESmokeLog("PASS ANGLER SKIN NATURAL: actual ordinary/golden constructors + native Step/Destroy kills, ordinary/Fish and golden/no-Fish exclusions, golden/Fish award, real JSON/reload and once-only save; closed readiness @"+string(30/timescale))
}
function scrNTTEFullBatSkinNaturalPurchase(_player,_expected,_test_refusals=true) {
    var _before=scrNTTEFullInstances(all),_chest=instance_create(_player.x,_player.y,NTTEFullCatChest),
        _chest_id=_chest,_shops=[],_chosen=noone,_bounty=GameCont.ntte_crime_bounty
    with(_chest) event_perform(ev_step,ev_step_normal)
    assert(!instance_exists(_chest),"Natural Crime CatChest contact did not open genuine stock")
    with(NTTEFullChestShop) if(creator==_chest_id) {
        event_perform(ev_step,ev_step_normal);array_push(_shops,id)
        if(drop=="ammo") _chosen=id
    }
    assert(array_length(_shops)==3 && instance_exists(_chosen),"Natural Crime CatChest lost its actual three-option basic pool")
    _player.x=_chosen.x;_player.y=_chosen.y
    with(_chosen.prompt) event_perform(ev_step,ev_step_normal)
    assert(scrNTTEFullPromptWinner(_player)==_chosen.prompt,"Actual Crime stock prompt failed native overlap/priority")
    var _saved=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json"),
        _backup=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")
    if(_test_refusals) {
        KeyCont.press_pick[_player.index]=false
        with(_player) scrNTTEFullPromptPlayerStep()
        with(_chosen) event_perform(ev_step,ev_step_normal)
        assert(_chosen.open==1 && GameCont.ntte_crime_bounty==_bounty,
            "Crime shop without a pickup press performed a transaction or advanced bounty")
        _player.x=_chosen.x+256;_player.y=_chosen.y+256
        KeyCont.press_pick[_player.index]=true
        with(_player) scrNTTEFullPromptPlayerStep()
        with(_chosen) event_perform(ev_step,ev_step_normal)
        assert(_chosen.open==1 && GameCont.ntte_crime_bounty==_bounty && _chosen.prompt.pick<0,
            "Crime shop accepted out-of-range input or advanced bounty")
        assert(scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")==_saved
            && scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")==_backup,
            "Rejected/no-input/out-of-range Crime transaction rewrote progress/backup")
    }
    _player.x=_chosen.x;_player.y=_chosen.y
    KeyCont.press_pick[_player.index]=true
    with(_player) scrNTTEFullPromptPlayerStep()
    KeyCont.press_pick[_player.index]=false
    assert(_chosen.prompt.pick==_player.index,"Actual native pickup key did not select Crime stock")
    var _ammo=instance_number(AmmoPickup)
    with(_chosen) event_perform(ev_step,ev_step_normal)
    assert(instance_number(AmmoPickup)==_ammo+2 && GameCont.ntte_crime_bounty==_expected,
        "Actual Crime successful trade failed real reward or source exact bounty step")
    for(var _i=0;_i<array_length(_shops);++_i)
        assert(_shops[_i].open==0,"Actual Crime trade did not consume its sibling stock")
    _saved=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")
    _backup=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")
    KeyCont.press_pick[_player.index]=true
    with(_player) scrNTTEFullPromptPlayerStep()
    with(_chosen) event_perform(ev_step,ev_step_normal)
    KeyCont.press_pick[_player.index]=false
    assert(GameCont.ntte_crime_bounty==_expected && instance_number(AmmoPickup)==_ammo+2
        && scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")==_saved
        && scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")==_backup,
        "Already-consumed Crime stock accepted another trade/bounty/save")
    scrNTTEFullMergedRuntimeTestCleanup(_before)
}
function scrNTTEFullBatSkinNaturalTests() {
    var _scope=scrNTTEFullSkinUnlockNaturalBegin("bat"),_p=instance_find(Player,0)
    try {
        GameCont.crown=NTTEFullCrown.Crime;GameCont.ntte_crime_bounty=0
        with(Player) race=Race.Fish
        for(var _i=1;_i<=3;++_i) {
            scrNTTEFullBatSkinNaturalPurchase(_p,_i)
            assert(!scrNTTEFullUnlockGet("skin:bat eyes"),"Three real Crime transactions without Eyes incorrectly awarded skin")
        }
        // Original only awards during the below3->3 transaction. Arriving as
        // Eyes after the cap cannot retroactively award on a fourth purchase.
        with(Player) race=Race.Eyes
        scrNTTEFullBatSkinNaturalPurchase(_p,3)
        assert(!scrNTTEFullUnlockGet("skin:bat eyes"),"Already-capped Crime bounty retroactively awarded a newly present Eyes")
        // Fresh independent source run starts at zero; threshold is reached
        // solely by three genuine successful input transactions below.
        GameCont.ntte_crime_bounty=0
        for(var _i=1;_i<=3;++_i) {
            scrNTTEFullBatSkinNaturalPurchase(_p,_i)
            assert(scrNTTEFullUnlockGet("skin:bat eyes")==(_i==3),"Actual Eyes Crime purchases awarded before/after original third transaction")
        }
        var _saved=scrNTTEFullSkinUnlockNaturalPersisted("skin:bat eyes")
        scrNTTEFullBatSkinNaturalPurchase(_p,3)
        assert(scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")==_saved,
            "Actual Crime bounty cap/owned skin purchase repeated progress save")
    }
    finally {scrNTTEFullSkinUnlockNaturalEnd(_scope)}
    scrNTTESmokeLog("PASS BAT SKIN NATURAL: actual CatChest contact/three distinct stock/native pickup prompt/success reward+bounty1/2/3, no-input/range/consumed-stock exact refusal, no-Eyes three purchases and capped late-Eyes exclusions, Eyes third-purchase award/real JSON reload; no invented price; closed readiness @"+string(30/timescale))
}
function scrNTTEFullCoolFrogNaturalAcquire(_player) {
    var _old=scrNTTEFullInstances(NTTEFullPet),_rubble=instance_create(_player.x+96,_player.y,NTTEFullPizzaRubble)
    _rubble.hp=0
    with(_rubble) event_perform(ev_step,ev_step_normal)
    assert(!instance_exists(_rubble),"Actual PizzaRubble native death did not release its CoolGuy")
    var _pet=noone
    with(NTTEFullPet) if(array_get_index(_old,id)<0 && pet=="CoolGuy") _pet=id
    assert(instance_exists(_pet) && _pet.combo==0 && _pet.combo_delay==0 && _pet.leader==noone,
        "Natural PizzaRubble reward did not construct a genuinely fresh zero-combo CoolGuy")
    with(_pet) event_perform(ev_step,ev_step_normal)
    _player.x=_pet.x;_player.y=_pet.y
    with(_pet.prompt) event_perform(ev_step,ev_step_normal)
    assert(scrNTTEFullPromptWinner(_player)==_pet.prompt,"Natural CoolGuy reward lost native acquisition prompt")
    KeyCont.press_pick[_player.index]=true
    with(_player) scrNTTEFullPromptPlayerStep()
    KeyCont.press_pick[_player.index]=false
    with(_pet) event_perform(ev_step,ev_step_normal)
    assert(_pet.leader==_player && !_pet.can_take && _pet.persistent
        && array_get_index(_player.ntte_pet,_pet)>=0 && _pet.combo==0,
        "Actual CoolGuy prompt/native pickup input did not acquire the fresh pet")
    return _pet
}
function scrNTTEFullCoolFrogNaturalKills(_pet,_count) {
    var _start=GameCont.kills,_combo=_pet.combo
    for(var _i=0;_i<_count;++_i) {
        var _enemy=instance_create(158000,158000,Bandit),_before=GameCont.kills
        _enemy.hp=0
        with(_enemy) event_perform(ev_step,ev_step_normal)
        assert(!instance_exists(_enemy) && GameCont.kills==_before+1,
            "Actual native Bandit Step/Destroy did not add exactly one real kill")
        with(_pet) event_perform(ev_step,ev_step_normal)
        assert(_pet.combo==_combo+_i+1 && abs(_pet.combo_delay-(40-timescale))<0.001,
            "CoolGuy native species Step lost actual consecutive enemy kill delta or source40-tick combo delay")
        assert(!scrNTTEFullUnlockGet("skin:cool frog"),"Cool Frog awarded before the source combo ended")
    }
    assert(GameCont.kills==_start+_count,"Natural CoolGuy test changed kills beyond actual enemy deaths")
}
function scrNTTEFullCoolFrogNaturalExpire(_pet) {
    var _ticks=0
    while(_pet.combo>0 && _ticks<45) {
        with(_pet) event_perform(ev_step,ev_step_normal)
        _ticks+=timescale
    }
    assert(_pet.combo==0 && _ticks>=39 && _ticks<=41,
        "CoolGuy genuine no-kill native Steps failed original40-tick combo expiry")
}
function scrNTTEFullCoolFrogSkinNaturalTests() {
    var _scope=scrNTTEFullSkinUnlockNaturalBegin("cool-frog"),_p=instance_find(Player,0)
    try {
        with(Player) race=Race.Frog
        var _round=scrNTTEFullInstances(all),_pet=scrNTTEFullCoolFrogNaturalAcquire(_p)
        scrNTTEFullCoolFrogNaturalKills(_pet,99);scrNTTEFullCoolFrogNaturalExpire(_pet)
        assert(!scrNTTEFullUnlockGet("skin:cool frog") && _pet.stat.combo==99,
            "Actual broken99 combo incorrectly unlocked Cool Frog or lost source record")
        scrNTTEFullCoolFrogNaturalKills(_pet,1);scrNTTEFullCoolFrogNaturalExpire(_pet)
        assert(!scrNTTEFullUnlockGet("skin:cool frog") && _pet.stat.combo==99,
            "Separate actual99+1 kills incorrectly combined across a genuine expired combo")
        scrNTTEFullMergedRuntimeTestCleanup(_round);_p.ntte_pet=[]
        with(Player) race=Race.Fish
        _round=scrNTTEFullInstances(all);_pet=scrNTTEFullCoolFrogNaturalAcquire(_p)
        scrNTTEFullCoolFrogNaturalKills(_pet,100);scrNTTEFullCoolFrogNaturalExpire(_pet)
        assert(!scrNTTEFullUnlockGet("skin:cool frog") && _pet.stat.combo==100,
            "Actual100-combo completion without Frog incorrectly awarded skin")
        scrNTTEFullMergedRuntimeTestCleanup(_round);_p.ntte_pet=[]
        with(Player) race=Race.Frog
        _pet=scrNTTEFullCoolFrogNaturalAcquire(_p)
        scrNTTEFullCoolFrogNaturalKills(_pet,100)
        assert(!scrNTTEFullUnlockGet("skin:cool frog"),"Actual100th kill awarded before original combo completion")
        scrNTTEFullCoolFrogNaturalExpire(_pet)
        assert(scrNTTEFullUnlockGet("skin:cool frog"),"Actual Frog100-kill combo completion failed source skin unlock")
        var _saved=scrNTTEFullSkinUnlockNaturalPersisted("skin:cool frog"),
            _backup=scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")
        repeat(ceil(5/timescale)) with(_pet) event_perform(ev_step,ev_step_normal)
        assert(scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json")==_saved
            && scrNTTEFullSkinUnlockNaturalRead(game_directory+"ntte-full-progress.json.bak")==_backup,
            "Idle completed CoolGuy repeated owned unlock save/backup")
    }
    finally {scrNTTEFullSkinUnlockNaturalEnd(_scope)}
    scrNTTESmokeLog("PASS COOL FROG SKIN NATURAL: actual PizzaRubble death/CoolGuy native prompt acquisition/combo0, actual enemy Step+Destroy kills only, broken99+1 exclusion/non-Frog100 exclusion/Frog100 original delayed completion award, real JSON/reload/once-only save; closed readiness @"+string(30/timescale))
}
