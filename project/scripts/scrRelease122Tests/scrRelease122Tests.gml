// Desktop fixtures exercise the same native events as mobile gameplay.
function scrRelease122FixtureBegin() {
    var _s=scrNTTEFullVanillaFixtureBegin();
    _s.extra=scrNTTEFullInstances([Portal,becomenemy,Corpse,LastDie,NTTEFullPet,NTTEFullPrompt,WepPickup]);
    for(var _i=0;_i<array_length(_s.extra);++_i) instance_deactivate_object(_s.extra[_i]);
    _s.players=scrNTTEFullAreaGeneratorSnapshot(Player);_s.keys=scrNTTEFullAreaGeneratorSnapshot(KeyCont);
    GameCont.is_level_ended=false;GameCont.killenemies=false;GameCont.skillpoints=0;GameCont.ultrapoints=0;
    return _s;
}
function scrRelease122FixtureEnd(_s) {
    scrNTTEFullAreaGeneratorRestore(_s.players);scrNTTEFullAreaGeneratorRestore(_s.keys);
    scrNTTEFullVanillaFixtureEnd(_s);
    for(var _i=0;_i<array_length(_s.extra);++_i) instance_activate_object(_s.extra[_i]);
}
function scrRelease122ChestTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
    try {
        GameCont.area=207;GameCont.hard=7;_p.x=220000;_p.y=220000;
        _p.wep=wep_revolver;_p.bwep=wep_shotgun;
        var _chest=instance_create(_p.x,_p.y,UGChest),_before=instance_number(WepPickup);
        with(_chest) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_chest) && instance_number(WepPickup)==_before+5,"Vine chest must open once and drop five weapons");
        var _distinct_art=false;
        with(WepPickup) {
            assert(wep!=_p.wep && wep!=_p.bwep && ammo && roll,"Vine chest held exclusions/ammo/roll changed");
            assert(sprite_index==scr_weapon_get_sprite(wep) && name==scr_weapon_get_name(wep) && type==scr_weapon_get_type(wep),
                "Vine chest retained default screwdriver metadata for weapon "+string(wep));
            if(sprite_index!=sprScrewDriver) _distinct_art=true;
        }
        assert(_distinct_art,"Chest fixture only tested default screwdriver");
        scrNTTESmokeLog("PASS Release122 actual UGChest.Step five registry-correct sprites/names/ammo-types and held exclusions @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease122VineTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0);
    try {
        GameCont.area=area_scrapyards;GameCont.subarea=3;_p.x=221000;_p.y=221000;_p.can_pick=true;_p.visible=true;
        var _vine=scrUGCreate(_p.x,_p.y,"FireFlower"),_prompt=_vine.prompt;
        var _enemy=instance_create(_p.x+200,_p.y,Bandit);
        assert(scrNTTEFullPromptWinner(_p)!=_prompt,"Vine interaction remained available before Scrap3-3 clear");
        _prompt.pick=_p.index;
        with(_vine) event_perform(ev_step,ev_step_normal);
        assert(instance_exists(_vine) && !instance_exists(Portal) && _prompt.pick==-1,
            "Stale Vine pick bypassed actual Step clear guard");
        instance_destroy(_enemy,false);
        var _hidden=instance_create(_p.x+300,_p.y,JungleAssassinHide);
        assert(scrNTTEFullPromptWinner(_p)!=_prompt,"Dormant hostile did not lock Vine");
        instance_destroy(_hidden,false);
        var _spawn=instance_create(_p.x+300,_p.y,becomenemy);
        assert(scrNTTEFullPromptWinner(_p)!=_prompt,"Pending enemy did not lock Vine");instance_destroy(_spawn,false);
        var _gen_before=scrNTTEFullInstances(all),_gen=instance_create(0,0,GenCont);
        assert(scrNTTEFullPromptWinner(_p)!=_prompt,"Generation did not lock Vine");instance_destroy(_gen,false);
        scrNTTEFullMergedRuntimeTestCleanup(_gen_before);
        // GenCont.Create legitimately moves players to the generation origin.
        _p.x=_vine.x;_p.y=_vine.y;
        var _ally=instance_create(_p.x+200,_p.y,Bandit);_ally.team=team_player;
        // A prompt restored without its new callback must be repaired by Step.
        _prompt.on_meet=undefined;with(_vine) event_perform(ev_step,ev_step_normal);
        assert(is_callable(_prompt.on_meet) && scrNTTEFullPromptWinner(_p)==_prompt,"Clear Vine unavailable with only allies or old prompt callback "+string([scrUGFlowerUsable(),scrNTTEPortalRecoveryAllowed(),scrUGCombatRemains(),_p.can_pick,_p.visible,_vine.visible,_prompt.visible,_p.x,_p.y,_vine.x,_vine.y,instance_number(GenCont),instance_number(LevCont),instance_number(Menu),GameCont.area,GameCont.subarea]));
        KeyCont.press_pick[_p.index]=true;with(_p) scrNTTEFullPromptPlayerStep();KeyCont.press_pick[_p.index]=false;
        assert(_prompt.pick==_p.index,"Vine lost native interaction input");
        with(_vine) event_perform(ev_step,ev_step_normal);
        var _dest=scrNTTEFullAreaTakeDestination();
        assert(!instance_exists(_vine) && instance_exists(Portal) && _dest.area==207 && _dest.subarea==1,
            "Cleared Vine did not enter original Undergrowth portal route");
        scrNTTESmokeLog("PASS Release122 real Vine prompt/input/Step: enemy, hidden, transforming and generation locks; stale input rejected; allies/clear accepted @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease122MillipedeTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        GameCont.area=207;GameCont.loops=0;
        instance_create(222000,222000,Floor);
        var _chain=scrUGCreate(222000,222000,"Millipede"),_head=_chain[0],_ally=instance_create(222200,222000,Bandit);
        _ally.team=team_player;
        assert(array_length(_chain)==13,"Millipede fixture must retain all authored segments");
        var _e=instance_create(222300,222000,Bandit);
        _head.alarm1=timescale;with(_head) event_perform(ev_step,ev_step_normal);
        assert(_head.active,"Millipede retreated before hostile combat ended");instance_destroy(_e,false);
        var _hidden=instance_create(222300,222000,JungleAssassinHide);
        _head.alarm1=timescale;with(_head) event_perform(ev_step,ev_step_normal);
        assert(_head.active,"Millipede ignored dormant hostile");instance_destroy(_hidden,false);
        var _spawn=instance_create(222300,222000,becomenemy);
        _head.alarm1=timescale;with(_head) event_perform(ev_step,ev_step_normal);
        assert(_head.active,"Millipede ignored transforming hostile");instance_destroy(_spawn,false);
        _head.alarm1=timescale;with(_head) event_perform(ev_step,ev_step_normal);
        for(var _i=0;_i<array_length(_chain);++_i)
            assert(!_chain[_i].active && !_chain[_i].canmelee && _chain[_i].maxspeed==7 && _chain[_i].hp>0,
                "Friendly bandit blocked original living Millipede retreat");
        // The authored offscreen EndStep, not a wall-kill fallback, removes it.
        with(_head) event_perform(ev_step,ev_step_end);
        for(var _i=0;_i<array_length(_chain);++_i) assert(!instance_exists(_chain[_i]),"Retreated offscreen segment remained in enemy count");
        assert(instance_exists(Corpse) && _ally.hp>0,"Millipede retreat omitted corpse or harmed friendly");
        with(instance_find(Corpse,0)) event_perform(ev_alarm,0);
        assert(instance_exists(Portal),"Natural corpse alarm did not open Undergrowth exit with living ally");
        scrNTTESmokeLog("PASS Release122 real13-segment Step/alarm living retreat -> offscreen EndStep cleanup -> Corpse.Alarm0 portal; hidden/spawn/hostile guards @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease122JungleTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        GameCont.area=area_jungle;
        var _ally=instance_create(223000,223000,Bandit);_ally.team=team_player;
        var _a=instance_create(223100,223000,JungleAssassinHide),_b=instance_create(223200,223000,JungleAssassinHide);
        var _hostile=instance_create(223300,223000,Bandit);
        with(_a) event_perform(ev_step,ev_step_normal);
        assert(instance_exists(_a),"Far hidden assassin woke before normal combat ended");instance_destroy(_hostile,false);
        with(_a) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_a) && instance_number(JungleAssassin)==1,"Living friendly blocked far Jungle assassin wakeup");
        with(_b) event_perform(ev_step,ev_step_normal);
        assert(instance_exists(_b),"Second hidden assassin ignored newly awakened hostile");
        with(JungleAssassin) {hp=0;instance_destroy();}
        with(_b) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_b) && instance_number(JungleAssassin)==1,"Second remote assassin remained permanently hidden");
        with(JungleAssassin) {hp=0;instance_destroy();}
        assert(!scr_check_enemies() && instance_number(MeleeFake)==0 && _ally.hp>0,"Jungle defeat did not leave only friendly");
        GameCont.ntte_ally_portal_timer=0;with(GameCont) scrNTTEAllyPortalStep();
        assert(instance_exists(Corpse),"Empty Jungle did not schedule guarded corpse recovery");
        with(instance_find(Corpse,0)) event_perform(ev_alarm,0);
        assert(instance_exists(Portal),"Empty Jungle did not open portal through normal corpse alarm");
        instance_destroy(Portal,false);
        var _friendly_hidden=instance_create(223400,223000,JungleAssassinHide);_friendly_hidden.team=team_player;
        with(_friendly_hidden) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_friendly_hidden),"Friendly dormant actor did not wake");
        with(JungleAssassin) assert(team==team_player,"Dormant friendly became hostile when waking");
        scrNTTESmokeLog("PASS Release122 remote Jungle hidden assassins sequential real Step wake/death -> guarded recovery/Corpse.Alarm0 portal with living ally; friendly team retained @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease122CorpseTests() {
    var _s=scrRelease122FixtureBegin();
    try {
        GameCont.area=207;
        instance_create(224000,224000,Floor);
        var _a=instance_create(224016,224016,Corpse),_b=instance_create(224016,224016,Corpse);
        _a.sprite_index=sprBanditDead;_b.sprite_index=sprUGMillipedeDead;
        with(_a) event_perform(ev_other,ev_animation_end);
        assert(_a.alarm[0]==30,"Initial corpse did not schedule native portal delay");
        _a.alarm[0]=15;
        repeat(60) with(_b) event_perform(ev_other,ev_animation_end);
        assert(_a.alarm[0]==15 && _b.alarm[0]<0,"Later/repeated corpse animations canceled an existing portal countdown");
        with(_a) event_perform(ev_alarm,0);
        assert(instance_exists(Portal),"Preserved corpse countdown did not reach native portal creation");
        scrNTTESmokeLog("PASS Release122 actual Corpse animation events preserve an existing countdown and original guarded portal alarm @"+string(30/timescale));
    } finally {scrRelease122FixtureEnd(_s);}
}
function scrRelease122SpiderAppearanceTests() {
    var _s=scrRelease122FixtureBegin(),_p=instance_find(Player,0),_progress=global.ntte_full_progress;
    var _extra=scrNTTEFullInstances([TopSmall,TopPot,Bones,NTTEFullWallEnemy]);
    for(var _i=0;_i<array_length(_extra);++_i) instance_deactivate_object(_extra[_i]);
    global.ntte_full_progress=json_parse(json_stringify(_progress));
    try {
        GameCont.area=area_caves;GameCont.loops=0;
        var _wall=instance_create(225000,225000,Wall),_spawn=scrNTTEFullWallPropsLevelStart(),_nest=noone;
        for(var _i=0;_i<array_length(_spawn.enemies);++_i) if(_spawn.enemies[_i].special) _nest=_spawn.enemies[_i];
        assert(instance_exists(_nest) && instance_exists(_nest.target) && !position_meeting(_nest.x,_nest.y,Floor),
            "Natural cave wall did not contain its guaranteed main Spider nest before blasting");
        var _target=_nest.target;
        scrWallDestroy(_wall); // The production wall-destruction entry used by explosives.
        var _floor=instance_nearest(_nest.x,_nest.y,FloorExplo);
        assert(instance_exists(_floor),"Native wall blast did not create walkable FloorExplo");
        // Real TopPot/FloorExplo collision releases the wrapper on its Step.
        with(_floor) with(_target) event_perform(ev_collision,FloorExplo);
        with(_nest) event_perform(ev_step,ev_step_normal);
        assert(!instance_exists(_nest) && !instance_exists(_target),"Blasted Spider nest did not finish normal controller teardown");
        var _spiders=[];with(NTTEFullPet) if(pet=="Spider") array_push(_spiders,id);
        assert(array_length(_spiders)==1,"Natural cave wall blast must release exactly one Spider pet");
        var _pet=_spiders[0];
        assert(_pet.visible && _pet.can_take && instance_exists(_pet.prompt) && _pet.sprite_index==_pet.spr_hurt
            && sprite_exists(_pet.spr_idle) && sprite_exists(_pet.spr_icon),"Released Spider missing visible art or pickup prompt");
        _p.ntte_pet=[];_p.ntte_pet_max=1;
        assert(scrNTTEFullPetTake(_pet,_p) && _pet.persistent && _pet.leader==_p,"Released Spider cannot be adopted");
        _pet.curse=1;scrNTTEFullPetSetSkin(_pet,1);_pet.stat.webbed=7;
        var _save=json_parse(json_stringify(scrNTTEFullPetExport()));
        assert(array_length(_save.pets)==1 && scrNTTEFullPetImport(_save),"Spider continuation JSON import failed");
        _spiders=[];with(NTTEFullPet) if(pet=="Spider") array_push(_spiders,id);
        assert(array_length(_spiders)==1,"Spider continuation duplicated or lost companion");_pet=_spiders[0];
        assert(_pet.leader==_p && _pet.persistent && _p.ntte_pet[0]==_pet && _pet.curse==1 && _pet.bskin==1
            && _pet.stat.webbed==7 && _pet.spr_idle==scrNTTERefSprite("PetSpiderCursedIdle")
            && ds_exists(_pet.web_hit_list,ds_type_map) && instance_exists(_pet.prompt),"Spider continuation lost species/owner/skin/history/render resources");
        scrNTTESmokeLog("PASS Release122 actual cave wall generation -> native wall blast/FloorExplo collision -> one visible Spider/pickup -> adoption -> JSON continuation owner/curse/art/resources @"+string(30/timescale));
    } finally {
        scrRelease122FixtureEnd(_s);global.ntte_full_progress=_progress;
        for(var _i=0;_i<array_length(_extra);++_i) instance_activate_object(_extra[_i]);
    }
}
