// Independent live source chain. The only room boundary is explicit real
// GameCont.RoomEnd/RoomStart plus native old-room disposal, preserving the
// desktop harness; this is not evidence of room_restart or an iOS device run.
function scrNTTEFullLairNaturalWorldTests() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()) throw "Lair natural world fixture requires explicit desktop full smoke"
    var _object=asset_get_index("NTTEFullLairNaturalWorldTest")
    assert(object_exists(_object) && !instance_exists(_object),"Lair natural observer missing or already active")
    var _observer=instance_create(0,0,_object)
    with(_observer) {
        // Keep save_get_option/scrOptionsUpdate on a separate actual DS map.
        // Capture after replacing the map so the shared restore's tutorial
        // write also stays in the fixture map, even if no old key existed.
        old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map)
        UberCont.saveData=fixture_save_map
        old_options=[UberCont.opt_framerate,UberCont.opt_autopause,UberCont.opt_keyboard,
            UberCont.opt_gamepad,UberCont.opt_bossintro,UberCont.opt_freeze]
        old_engine_rate=game_get_speed(gamespeed_fps);target_rate=round(old_engine_rate)
        assert(target_rate==30 || target_rate==60,"Lair live acceptance supports actual30/60 only")
        state=scrNTTEFullWorldEventsNaturalWorldCapture();fixture_skills=ds_list_create()
        player=instance_find(Player,0);original_player=player;loaded_player=noone
        old_pick=KeyCont.press_pick[player.index];want_pick=false
        phase=0;ticks=0;draw_frames=0;draw_start=0;profile_index=0;pizza_draw_start=-1
        drain=noone;hole=noone;crate=noone;chest=noone;shop=noone;shops=[]
        anchor_x=10016;anchor_y=10016;old_directory=game_directory
        scratch=old_directory+"ntte-lair-natural-world/";directory_create(scratch);game_directory=scratch
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        old_save=file_exists(savegame_file)?buffer_load(savegame_file):-1
        source_points=0;reward_points=0;stock=0;continue_buffer=-1;trade_before=[]
        visible=true;depth=-100000
    }
}
function scrNTTEFullLairNaturalWorldAfterSample(_keycont,_index) {
    // BeginStep runs before the actual key sampler and its values are replaced.
    // This fixture-only hook runs immediately after that genuine sample, so the
    // normal Player/prompt/stock code remains the only consumer of the key.
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled() || !global.ntte_smoke_active) return;
    var _object=asset_get_index("NTTEFullLairNaturalWorldTest")
    if(!object_exists(_object) || !instance_exists(_object)) return;
    with(_object) if(phase==7 && want_pick && instance_exists(player)
        && instance_is(player,Player) && player.index==_index) _keycont.press_pick[_index]=true
}
function scrNTTEFullLairNaturalWorldDrawWitness() {draw_frames++}
function scrNTTEFullLairNaturalWorldRateAssert(_where) {
    assert(game_get_speed(gamespeed_fps)==target_rate && abs(timescale-30/target_rate)<0.0001
        && UberCont.opt_framerate==target_rate && !UberCont.opt_autopause
        && save_get_value("options","framerate",-1)==target_rate
        && !save_get_value("options","autopause",true),
        "Lair actual options/timescale/rate changed at "+_where)
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Lair live acceptance changed the original save/options DS map at "+_where)
}
function scrNTTEFullLairNaturalWorldPlace(_x,_y) {
    anchor_x=_x;anchor_y=_y
    if(instance_exists(player)) {player.x=_x;player.y=_y;player.xprevious=_x;player.yprevious=_y}
}
function scrNTTEFullLairNaturalWorldGeneration(_area,_subarea,_hard,_seed) {
    GameCont.area=_area;GameCont.subarea=_subarea;GameCont.hard=_hard;GameCont.loops=0
    GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=_subarea==GameCont.maxsubarea
    GameCont.levseed=_seed;GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed)
    GameCont.ntte_full_source_pending_generation=undefined;global.rng_state[@RNGStates.Generation]=_seed
    var _gen=instance_create(0,0,GenCont)
    assert(!_gen.ntte_full_sync_generation,"Lair ordinary map silently used synchronous fixture generation")
    ticks=0
}
function scrNTTEFullLairNaturalWorldContinue() {
    // Use the actual native binary sections, with a different genuine Player
    // constructor on load. Clearing the granted skill before load proves that
    // session restoration, rather than a stale in-memory value, supplies it.
    continue_buffer=buffer_create(0xffff,buffer_grow,1)
    scrSavegameSession(continue_buffer,false);scrSavegamePlayers(continue_buffer,false)
    assert(scr_skill_get(NTTEFullSkill.SilverTongue)==1 && !GameCont.ntte_lairmut,
        "Lair chain lost its source-acquired Silver Tongue before actual continuation")
    scr_skill_set(NTTEFullSkill.SilverTongue,0)
    buffer_seek(continue_buffer,buffer_seek_start,0);scrSavegameSession(continue_buffer,true)
    instance_deactivate_object(original_player)
    scrSavegamePlayers(continue_buffer,true);loaded_player=instance_find(Player,0);player=loaded_player
    assert(instance_exists(loaded_player) && loaded_player!=original_player
        && scr_skill_get(NTTEFullSkill.SilverTongue)==1 && !GameCont.ntte_lairmut
        && GameCont.skillpoints==reward_points && GameCont.area==area_scrapyards && GameCont.subarea==1,
        "Actual native session/player continue lost acquired Silver Tongue, consumed flag, points or destination")
    buffer_delete(continue_buffer);continue_buffer=-1
    scrNTTEFullLairNaturalWorldPlace(player.x,player.y)
    scrNTTEFullLairNaturalWorldRateAssert("actual native continuation")
    scrNTTESmokeLog("LAIR NATURAL native binary session+new Player continue restored source-acquired SilverTongue1/consumed reward/source points/Scrapyards1 without skill_take replay")
}
function scrNTTEFullLairNaturalWorldStep() {
    if(phase>0) scrNTTEFullLairNaturalWorldRateAssert("live phase "+string(phase))
    if(instance_exists(player)) {
        player.hp=100000;player.max_hp=100000;player.nexthurt=current_frame+100000
        player.speed=0;player.can_walk=false;player.can_aim=false;player.can_pick=true
        player.x=anchor_x;player.y=anchor_y;player.xprevious=anchor_x;player.yprevious=anchor_y
    }
    if(phase==0) {
        save_set_value("options","framerate",target_rate)
        save_set_value("options","autopause",false)
        save_set_value("options","keyboard",true);save_set_value("options","gamepad",false)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        scrOptionsUpdate();scrNTTEFullLairNaturalWorldRateAssert("source map setup")
        global.ntte_full_world_event_hooks={};scrNTTEFullWorldEventsNativeBindings(true)
        global.ntte_full_world_events_native_bound=true;global.ntte_full_sync_generation=false
        save_set_value("game","tutorial",false)
        GameCont.skills=fixture_skills;GameCont.ntte_full_skills={};GameCont.ntte_full_native_skill_counts={};GameCont.ntte_full_skill_order=[]
        GameCont.skillpoints=0;GameCont.crownpoints=0;GameCont.ultrapoints=0;GameCont.level=1
        // This fixture isolates the secret-area reward from ordinary combat XP.
        GameCont.rad=-100000;GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.killenemies=false
        GameCont.can_advance_stage=false;GameCont.ntte_full_pending_destination=undefined
        if(variable_instance_exists(GameCont,"ntte_lairmut")) variable_struct_remove(GameCont,"ntte_lairmut")
        UberCont.opt_autopause=false;UberCont.paused=false;UberCont.want_pause=false
        UberCont.want_menu=false;UberCont.want_restart=false;UberCont.want_quit_to_menu=false
        UberCont.opt_bossintro=false;UberCont.opt_freeze=0
        with(Player) {wep=wep_revolver;bwep=wep_none}
        assert(!scrNTTEFullUnlockGet("crown:crime") && scr_skill_get(NTTEFullSkill.SilverTongue)==0,
            "Lair live acceptance did not start with locked Crime and unowned Silver Tongue")
        scrNTTEFullLairNaturalWorldGeneration(scrNTTEFullAreaId("pizza"),1,5,6123)
        phase=1;return;
    }
    ticks++
    assert(ticks<7200,"Lair actual generation/drain/manhole/reward/crate/continue timed out phase="+string(phase))
    if(phase==1) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(instance_number(Floor)>20,"Naturally built Pizza must supply substantial real old terrain for in-room Lair overlap")
        assert(instance_number(NTTEFullPizzaTV)==1 && NTTEFullPizzaTV.visible
            && NTTEFullPizzaTV.sprite_index==sprTV && NTTEFullPizzaTV.spr_idle==sprTV
            && sprite_exists(NTTEFullPizzaTV.myscreen),
            "Naturally populated Pizza TV lost its source cabinet or valid channel before inherited live Draw")
        if(pizza_draw_start<0) {pizza_draw_start=draw_frames;return;}
        if(draw_frames-pizza_draw_start<8) return;
        scrNTTESmokeLog("LAIR NATURAL actual completed Pizza native TV cabinet/channel and unchanged scheduled inherited TV.Draw survived8real Draw frames")
        with(NTTEFullSewerDrain) if(type=="area" && area==scrNTTEFullAreaId("lair")) other.drain=id
        assert(instance_exists(drain) && !scrNTTEFullUnlockGet("crown:crime"),
            "Actual Pizza population omitted its natural Lair drain or unlocked Crime before drain destruction")
        // Actual hp-driven registered Step/Destroy; no test area callback call.
        source_points=GameCont.skillpoints;drain.hp=0;ticks=0;phase=2;return;
    }
    if(phase==2) {
        if(instance_exists(drain)) return;
        assert(GameCont.area==scrNTTEFullAreaId("lair") && scrNTTEFullUnlockGet("crown:crime")
            && GameCont.ntte_full_active_lair && instance_number(Floor)>20,
            "Actual drain Destroy failed source in-room Lair generation and Crime unlock")
        hole=instance_find(NTTEFullCatHoleBig,0)
        assert(instance_exists(hole) && hole.ntte_full_phase==0 && !hole.ntte_full_released
            && !variable_instance_exists(GameCont,"ntte_lairmut") && GameCont.skillpoints==source_points,
            "Real Lair population omitted its native manhole or granted its reward before release")
        scrNTTEFullLairNaturalWorldPlace(hole.x,hole.y+64)
        scrNTTESmokeLog("LAIR NATURAL actual Pizza floors/drain registered death/in-room Lair population/Crime unlock/native unreleased manhole OK")
        ticks=0;phase=3;return;
    }
    if(phase==3) {
        // Clear actual generated ordinary enemies by native HP death. The
        // registered manhole must observe the clear and advance its own timers.
        with(enemy) if(!instance_is(id,NTTEFullCatBoss) && !instance_is(id,NTTEFullBatBoss)) hp=0
        if(instance_exists(hole)) return;
        assert(instance_number(NTTEFullCatBoss)==1 && instance_number(NTTEFullBatBoss)==1
            && GameCont.ntte_lairmut && GameCont.skillpoints==source_points+1,
            "Actual manhole four-phase timers/release/Destroy failed real boss pair and immediate once-only source reward")
        reward_points=GameCont.skillpoints
        scrNTTEFullLairNaturalWorldPlace(anchor_x,anchor_y+256)
        with(NTTEFullCatBoss) hp=0
        with(NTTEFullBatBoss) hp=0
        scrNTTESmokeLog("LAIR NATURAL real registered manhole release created Cat+Bat and granted source point/flag BEFORE boss deaths OK")
        ticks=0;phase=4;return;
    }
    if(phase==4) {
        if(instance_exists(NTTEFullCatBoss) || instance_exists(NTTEFullBatBoss) || !instance_exists(Portal)) return;
        assert(GameCont.skillpoints==reward_points && GameCont.ntte_lairmut,
            "Cat/Bat native deaths duplicated or consumed the source release reward")
        GameCont.can_advance_stage=true
        with(GameCont) event_perform(ev_other,ev_room_end)
        assert(GameCont.area==area_scrapyards && GameCont.subarea==1 && !GameCont.ntte_full_active_lair,
            "Actual Lair RoomEnd failed source Scrapyards1 finish/transit")
        scrNTTEFullWorldEventsNextRoomDispose(state)
        with(GameCont) event_perform(ev_other,ev_room_start)
        with(UberCont) event_perform(ev_other,ev_room_start)
        scrNTTEFullLairNaturalWorldRateAssert("genuine GameCont/UberCont RoomStart options reload")
        // Genuine room bootstrap selects LevCont from source-granted points.
        // Its smoke-only early return is disabled for this one native Create.
        var _smoke=global.ntte_smoke_active
        global.ntte_smoke_active=false
        try {instance_create(0,0,Vlambeer)} finally {global.ntte_smoke_active=_smoke}
        scrNTTEFullLairNaturalWorldRateAssert("actual Vlambeer room bootstrap")
        assert(instance_exists(LevCont) && instance_number(SkillIcon)==1 && SkillIcon.skill==NTTEFullSkill.SilverTongue
            && !GameCont.ntte_lairmut && GameCont.skillpoints==reward_points,
            "Real room bootstrap/LevCont failed sole source Silver Tongue choice and one-time flag consumption")
        with(SkillIcon) event_user(0)
        reward_points--
        assert(scr_skill_get(NTTEFullSkill.SilverTongue)==1 && GameCont.skillpoints==reward_points
            && instance_exists(GenCont) && file_exists(savegame_file),
            "Actual native SkillIcon selection/submit/save failed acquired Silver Tongue and next real generation")
        GameCont.can_advance_stage=false
        ticks=0;phase=5;return;
    }
    if(phase==5) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(GameCont.area==area_scrapyards && GameCont.subarea==1 && GameCont.hard>1
            && instance_number(enemy)>instance_number(HostileHorror) && instance_number(Floor)>20,
            "Source Lair reward did not proceed into an actual normal Scrapyards1 map")
        assert(instance_number(NTTEFullWallCrate)==1,"One source-acquired Silver Tongue did not create exactly one natural crate")
        crate=instance_find(NTTEFullWallCrate,0);chest=crate.crate_loot
        assert(instance_exists(chest) && (instance_is(chest,NTTEFullCatChest) || instance_is(chest,NTTEFullBatChest)
            || instance_is(chest,NTTEFullRatChest)) && array_length(crate.crate_wall)>0,
            "Natural Silver crate lacks its real source animal chest or native enclosing walls")
        // Native FloorExplo is the actual excavation result used by weapons.
        // Its constructor destroys the real colliding walls; no stock or loot
        // fields are edited to open the crate or trade.
        var _walls=array_create(array_length(crate.crate_wall));array_copy(_walls,0,crate.crate_wall,0,array_length(_walls))
        for(var _i=0;_i<array_length(_walls);++_i) if(instance_exists(_walls[_i])) instance_create(_walls[_i].x,_walls[_i].y,FloorExplo)
        scrNTTEFullLairNaturalWorldPlace(chest.x,chest.y)
        ticks=0;phase=6;return;
    }
    if(phase==6) {
        if(instance_exists(chest)) return;
        shops=[]
        with(NTTEFullChestShop) if(creator==other.chest) array_push(other.shops,id)
        assert(array_length(shops)>=2,"Actual Silver crate chest contact failed real sibling shop stock")
        shop=shops[0];stock=shop.open
        assert(stock==1 || stock==2,"Source chest stock outside authored one/two picks")
        trade_before=scrNTTEFullInstances(all)
        scrNTTEFullLairNaturalWorldPlace(shop.x,shop.y)
        want_pick=true;ticks=0;phase=7;return;
    }
    if(phase==7) {
        if(instance_exists(shop) && shop.open>0) return;
        want_pick=false;KeyCont.press_pick[player.index]=false
        var _after=scrNTTEFullInstances(all),_products=0
        for(var _i=0;_i<array_length(_after);++_i) if(array_get_index(trade_before,_after[_i])<0
            && (scrNTTEFullIsPickup(_after[_i]) || instance_is(_after[_i],NTTEFullOrchidBall)
                || instance_is(_after[_i],NTTEFullShopCharm))) _products++
        assert(_products>0,"Actual source chest shop stock closed without creating its real pickup/weapon/blessing product")
        for(var _i=1;_i<array_length(shops);++_i)
            assert(!instance_exists(shops[_i]) || shops[_i].open==stock-1,
                "One actual native prompt trade did not decrement every sibling stock once")
        assert(!GameCont.ntte_lairmut && scr_skill_get(NTTEFullSkill.SilverTongue)==1,
            "Source shop transaction duplicated or consumed permanent Silver Tongue")
        scrNTTESmokeLog("LAIR NATURAL acquired SilverTongue/native Scrap1 async generation/one real WallCrate/excavation/contact chest/native pick/sibling stock once OK")
        scrNTTEFullLairNaturalWorldContinue()
        draw_start=draw_frames;ticks=0;phase=8;return;
    }
    if(phase==8) {
        if(draw_frames-draw_start<8) return;
        assert(scr_skill_get(NTTEFullSkill.SilverTongue)==1 && !GameCont.ntte_lairmut && GameCont.skillpoints==reward_points,
            "Native continued live Steps repeated secret-area reward or lost acquired skill")
        scrNTTEFullWorldEventsNextRoomDispose(state)
        // Negative maps keep the actually acquired skill, never install a
        // direct Silver grant or replace the source normal-area snapshot.
        profile_index=0
        scrNTTEFullLairNaturalWorldGeneration(area_desert,2,5,6201)
        phase=9;return;
    }
    if(phase==9) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker)) return;
        assert(scr_skill_get(NTTEFullSkill.SilverTongue)==1 && instance_number(Floor)>20 && !instance_exists(NTTEFullWallCrate),
            "Source subarea1/normal hard>1 gates spawned a crate in an ineligible naturally generated map")
        scrNTTESmokeLog("LAIR NATURAL ACQUIRED SILVER NEGATIVE actual async map area="+string(GameCont.area)
            +" sub="+string(GameCont.subarea)+" hard="+string(GameCont.hard)+" crates0 OK")
        if(profile_index==0) {
            scrNTTEFullWorldEventsNextRoomDispose(state);profile_index++
            scrNTTEFullLairNaturalWorldGeneration(area_desert,1,1,6202);return;
        }
        draw_start=draw_frames;ticks=0;phase=10;return;
    }
    if(draw_frames-draw_start<8) return;
    var _state=state,_skills=fixture_skills,_old_pick=old_pick,_original=original_player,_loaded=loaded_player,
        _directory=old_directory,_save=old_save,_old_map=old_save_map,_copy=fixture_save_map,
        _savedata=old_savedata,_engine_rate=old_engine_rate,_options=old_options
    if(instance_exists(_loaded)) instance_destroy(_loaded,false)
    instance_activate_object(_original)
    scrNTTEFullWorldEventsNaturalWorldRestore(_state)
    assert(UberCont.saveData==_copy && ds_map_write(_old_map)==_savedata,
        "Lair common scope restore mutated the original save/options DS map")
    UberCont.saveData=_old_map;ds_map_destroy(_copy);game_set_speed(_engine_rate,gamespeed_fps)
    UberCont.opt_framerate=_options[0];UberCont.opt_autopause=_options[1]
    UberCont.opt_keyboard=_options[2];UberCont.opt_gamepad=_options[3]
    UberCont.opt_bossintro=_options[4];UberCont.opt_freeze=_options[5]
    ds_list_destroy(_skills);KeyCont.press_pick[_original.index]=_old_pick;game_directory=_directory
    if(buffer_exists(_save)) {buffer_save(_save,savegame_file);buffer_delete(_save)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    scrNTTESmokeLog("FULL LAIR NATURAL drain/unlock/manhole release/source reward/native choice/Scrap1 crate/contact trade/binary continue/subarea+hard negative/live Draw complete @"+string(30/timescale)+"; explicit genuine RoomEnd in same desktop room, not room_restart")
    instance_destroy(id,false)
}
