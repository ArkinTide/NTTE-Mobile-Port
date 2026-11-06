// Dedicated regression, controlled Coast2/loop1 bootstrap. A naturally created
// ProtoStatue is given a declared charged/dying precondition. Native death,
// Portal animation/attraction/contact, real room_restart, Vault generation,
// CrownPickup contact, returned Portal, and next Coast generation then run on
// actual scheduled engine frames. This does not claim full preceding combat.
function scrNTTEFullCoastVaultClear() {
    var _keep=id
    with(all) if(id!=_keep && object_index!=UberCont && object_index!=Console) instance_destroy(id,false)
}
function scrNTTEFullCoastVaultRestore() {
    if(restored) return;
    restored=true
    var _unchanged=ds_map_write(old_save_map)==old_savedata
    scrNTTEFullCoastVaultClear()
    scrNTTEFullAreaGeneratorRestore(old_global_graph)
    for(var _i=0;_i<array_length(old_global_vars);++_i)
        variable_global_set(old_global_vars[_i][0],old_global_vars[_i][1])
    scrNTTEFullAreaGeneratorRestore(old_uber)
    UberCont.saveData=old_save_map
    if(ds_exists(fixture_save_map,ds_type_map)) ds_map_destroy(fixture_save_map)
    game_set_speed(old_game_speed,gamespeed_fps)
    game_directory=old_directory;global.ntte_full_progress=old_progress
    global.ntte_full_feature_ready=old_ready;global.ntte_smoke_active=old_smoke
    if(old_continue>=0) {buffer_save(old_continue,savegame_file);buffer_delete(old_continue)}
    else if(file_exists(savegame_file)) file_delete(savegame_file)
    for(var _i=0;_i<array_length(scratch_files);++_i)
        if(file_exists(scratch_files[_i])) file_delete(scratch_files[_i])
    random_set_seed(old_seed)
    assert(_unchanged && ds_map_write(old_save_map)==old_savedata,
        "Coast/Vault fixture changed original save/options")
    // Dedicated process ends after original bytes/pointers have been restored.
    // Native Uber.RoomEnd otherwise writes options even when dont_save is set.
    instance_deactivate_object(UberCont)
}
function scrNTTEFullCoastVaultReturnNaturalTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Coast/Vault acceptance requires explicit Windows smoke")
    assert(!instance_exists(NTTEFullCoastVaultReturnNaturalTest),"Duplicate Coast/Vault observer")
    var _observer=instance_create(0,0,NTTEFullCoastVaultReturnNaturalTest)
    with(_observer) {
        restored=false;scratch_files=[];old_global_vars=[]
        old_directory=game_directory;old_progress=global.ntte_full_progress
        old_ready=variable_global_exists("ntte_full_feature_ready")?global.ntte_full_feature_ready:undefined
        old_smoke=global.ntte_smoke_active;old_continue=file_exists(savegame_file)?buffer_load(savegame_file):-1
        old_seed=random_get_seed();old_save_map=UberCont.saveData;old_savedata=ds_map_write(old_save_map)
        old_game_speed=game_get_speed(gamespeed_fps);old_uber=scrNTTEFullAreaGeneratorSnapshot(UberCont)
        fixture_save_map=ds_map_create();ds_map_copy(fixture_save_map,old_save_map);UberCont.saveData=fixture_save_map
        var _names=variable_struct_get_names(global),_graph={nodes:[]}
        for(var _i=0;_i<array_length(_names);++_i) {
            var _name=_names[_i],_value=variable_global_get(_name)
            array_push(old_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        old_global_graph={instances:[],containers:_graph.nodes}
        scratch_root=working_directory+"coast-vault-return-"+string(get_timer())+"/";directory_create(scratch_root)
        rates=[30,60];completed_rates=[];pass_index=0;phase=0;elapsed=0;draw_frames=0;world_ready_draw=-1
        room_ends=0;room_starts=0;player=noone;statue=noone;portal=noone;pickup=noone
        ingress_contact=false;return_contact=false;pickup_x=0;pickup_y=0
        global.ntte_smoke_active=false
        smoke_drivers=scrNTTEFullInstances(NTTESmokeTest)
        with(NTTESmokeTest) instance_deactivate_object(id)
        scrNTTEFullCoastVaultClear()
    }
}
function scrNTTEFullCoastVaultAwait(_phase) {
    phase=_phase;elapsed=0;world_ready_draw=-1
    scrNTTESmokeLog("COAST VAULT phase="+string(phase)+" @"+string(rates[pass_index]))
}
function scrNTTEFullCoastVaultReady() {
    if(instance_exists(GenCont) || instance_exists(FloorMaker)) {world_ready_draw=-1;return false;}
    if(world_ready_draw<0) {world_ready_draw=draw_frames;return false;}
    return draw_frames-world_ready_draw>=8
}
function scrNTTEFullCoastVaultRate() {
    assert(UberCont.saveData==fixture_save_map && ds_map_write(old_save_map)==old_savedata,
        "Coast/Vault isolated original save changed; fixture map="+string(UberCont.saveData==fixture_save_map))
    assert(game_get_speed(gamespeed_fps)==rates[pass_index] && timescale==30/rates[pass_index]
        && UberCont.opt_framerate==rates[pass_index] && !UberCont.opt_autopause,
        "Coast/Vault real frame rate changed; expected="+string(rates[pass_index])
        +" speed="+string(game_get_speed(gamespeed_fps))+" timescale="+string(timescale)
        +" option="+string(UberCont.opt_framerate)+" autopause="+string(UberCont.opt_autopause))
}
function scrNTTEFullCoastVaultNearPortal(_portal) {
    // Declared placement begins 48px away. The real Portal's native attraction
    // must traverse this distance and deliver the actual collision itself.
    var _floor=instance_nearest(_portal.x,_portal.y,Floor)
    assert(instance_exists(_floor),"Coast/Vault portal has no reachable terrain")
    var _dir=point_direction(_portal.x,_portal.y,(_floor.bbox_left+_floor.bbox_right)/2,(_floor.bbox_top+_floor.bbox_bottom)/2)
    player.x=_portal.x+lengthdir_x(48,_dir);player.y=_portal.y+lengthdir_y(48,_dir)
    player.xprevious=player.x;player.yprevious=player.y;player.mask_index=mskPlayer
    assert(!collision_line(player.x,player.y,_portal.x,_portal.y,Wall,false,false),
        "Coast/Vault natural portal path is blocked by a wall")
}
function scrNTTEFullCoastVaultStepBody() {
    elapsed+=timescale
    assert(elapsed<3600,"Coast/Vault natural state timed out phase="+string(phase)
        +" area="+string(instance_exists(GameCont)?GameCont.area:-1)
        +" portals="+string(instance_number(Portal))+" rooms="+string(room_ends)+"/"+string(room_starts))
    if(phase>0) scrNTTEFullCoastVaultRate()
    if(instance_exists(player)) {
        // Survival-only prerequisite. No enemy health or Portal lifecycle edits.
        player.hp=100000;player.max_hp=100000;player.lsthealth=100000;player.nexthurt=current_frame+100000
        player.can_walk=false;player.can_aim=false;player.speed=0
    }
    if(phase==0) {
        // Native Portal.Alarm1 activates all instances during room_restart.
        // Remove the suspended outer driver before it can resume its old tick.
        for(var _i=0;_i<array_length(smoke_drivers);++_i) {
            instance_activate_object(smoke_drivers[_i])
            if(instance_exists(smoke_drivers[_i])) instance_destroy(smoke_drivers[_i],false)
        }
        smoke_drivers=[]
        scrNTTEFullCoastVaultClear()
        save_set_value("options","framerate",rates[pass_index]);save_set_value("options","autopause",false)
        save_set_value("options","gamepad",false);save_set_value("options","keyboard",true)
        save_set_value("visual","bossintro",false);save_set_value("visual","freezeframes",false)
        save_set_value("game","tutorial",false)
        game_set_speed(rates[pass_index],gamespeed_fps);scrOptionsUpdate()
        scrNTTEFullCoastVaultAwait(10);return;
    }
    if(phase==10) {
        UberCont.paused=false;UberCont.want_pause=false;UberCont.want_quit_to_menu=false
        UberCont.daily_run=false;UberCont.weekly_run=false;UberCont.coop=false;UberCont.hardmode=false
        UberCont.continued_run=false;UberCont.show_leaderboards_menu=false
        global.is_server=true;global.index=0;global.custom_seed=6123;global.recontinued_times=0
        global.crownpick=crwn_none;scrGameCustomModeReset();scr_playerinstances_reset_all()
        my_player.race=Race.Fish;my_player.skin=0
        game_directory=scratch_root+string(rates[pass_index])+"/";directory_create(game_directory)
        for(var _i=0;_i<4;++_i) array_push(scratch_files,game_directory
            +["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"][_i])
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        global.ntte_full_feature_ready={}
        if(file_exists(savegame_file)) file_delete(savegame_file)
        instance_create(0,0,GameCont);instance_create(0,0,BackCont);instance_create(0,0,MusCont);scrCreatePlayers(0)
        player=instance_find(Player,0)
        assert(instance_exists(player),"Coast/Vault native controlled bootstrap omitted Player")
        GameCont.area=scrNTTEFullAreaId("coast");GameCont.subarea=2;GameCont.loops=1;GameCont.hard=9
        GameCont.proto=false;GameCont.crown=crwn_none;GameCont.crownvisits=0;GameCont.crownrad=0
        GameCont.crownpoints=0;GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.rad=-100000
        GameCont.sunkenchests=0;GameCont.maxsubarea=3;GameCont.finalsubarea=false;GameCont.can_advance_stage=true
        GameCont.levseed=6123;GameCont.ntte_full_pending_destination=undefined
        GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(6123)
        GameCont.ntte_full_source_pending_generation=undefined
        global.rng_state[@RNGStates.Generation]=6123;global.ntte_full_sync_generation=false
        room_ends=0;room_starts=0;ingress_contact=false;return_contact=false
        var _gen=instance_create(0,0,GenCont)
        assert(!_gen.ntte_full_sync_generation,"Coast/Vault replaced actual asynchronous generation")
        scrNTTEFullCoastVaultAwait(1);return;
    }
    if(phase==1) {
        if(!scrNTTEFullCoastVaultReady()) return;
        assert(GameCont.area==scrNTTEFullAreaId("coast") && GameCont.subarea==2
            && instance_exists(NTTEFullCoastSea) && GameCont.ntte_full_active_coast,
            "Coast/Vault real Coast2 generation lost sea scene")
        statue=instance_find(ProtoStatue,0)
        assert(instance_exists(statue),"Natural loop Coast2 did not create source ProtoStatue")
        // A charged/dying statue is the declared regression prerequisite. Its
        // scheduled enemy death and real native Destroy callback create entry.
        statue.rad=25;statue.charged=true;statue.hp=0
        scrNTTEFullCoastVaultAwait(2);return;
    }
    if(phase==2) {
        if(instance_exists(statue)) return;
        assert(GameCont.area==area_vault && GameCont.lastarea==scrNTTEFullAreaId("coast")
            && GameCont.lastsubarea==2 && instance_exists(NTTEFullCoastSea),
            "Coast/Vault actual ProtoStatue.Destroy lost route or departing Coast scene")
        portal=noone;with(Portal) if(type==3) other.portal=id
        assert(instance_exists(portal),"Coast statue native death did not create actual type3 entry")
        scrNTTEFullCoastVaultNearPortal(portal)
        scrNTTEFullCoastVaultAwait(3);return;
    }
    if(phase==3) {
        if(instance_exists(portal)) {
            if(portal.close && portal.endgame<100) ingress_contact=true
            return;
        }
        if(room_ends<1 || room_starts<1 || !scrNTTEFullCoastVaultReady()) return;
        assert(ingress_contact && GameCont.area==area_vault && GameCont.lastarea==scrNTTEFullAreaId("coast")
            && !instance_exists(NTTEFullCoastSea),"Native Coast portal did not enter an actual reconstructed Vault")
        pickup=instance_find(CrownPickup,0)
        assert(instance_exists(pickup) && !instance_exists(VaultStatue),"First native Vault did not expose CrownPickup")
        pickup_x=pickup.x;pickup_y=pickup.y
        player=instance_find(Player,0)
        player.x=pickup_x;player.y=pickup_y;player.xprevious=player.x;player.yprevious=player.y
        scrNTTEFullCoastVaultAwait(4);return;
    }
    if(phase==4) {
        if(instance_exists(pickup)) return;
        portal=noone;with(Portal) if(type==3) other.portal=id
        assert(instance_exists(portal) && portal.visible && point_distance(portal.x,portal.y,pickup_x,pickup_y)<1
            && point_distance(portal.xstart,portal.ystart,pickup_x,pickup_y)<1,
            "CrownPickup actual contact displaced/hidden return Portal via stale Coast constructor")
        assert(!scrNTTEFullCoastConstructActive() && GameCont.crownpoints==1
            && GameCont.area==scrNTTEFullAreaId("coast") && GameCont.subarea==2,
            "Actual CrownPickup.Destroy did not restore route while preserving Vault scene")
        with(portal) assert(place_meeting(x,y,Floor),"Vault return Portal is not on reachable native Floor")
        scrNTTEFullCoastVaultNearPortal(portal)
        scrNTTEFullCoastVaultAwait(5);return;
    }
    if(phase==5) {
        if(instance_exists(portal)) {
            if(portal.close && portal.endgame<100) return_contact=true
            return;
        }
        if(room_ends<2 || room_starts<2) return;
        assert(return_contact,"Reachable Vault return Portal never received native Player collision")
        if(instance_exists(LevCont)) {
            // Declared no-crown choice uses the actual native selection event;
            // its regular callback creates the following real GenCont.
            var _none=noone;with(CrownIcon) if(crown==crwn_none) _none=id
            assert(instance_exists(_none),"Returned Vault crown menu lacks native no-crown option")
            with(_none) event_user(0)
        }
        scrNTTEFullCoastVaultAwait(6);return;
    }
    if(phase==6) {
        if(!scrNTTEFullCoastVaultReady()) return;
        assert(GameCont.area==scrNTTEFullAreaId("coast") && GameCont.subarea==3
            && instance_exists(NTTEFullCoastSea) && GameCont.ntte_full_active_coast,
            "Real Vault exit did not rebuild source next Coast3/sea scene")
        scrNTTESmokeLog("COAST VAULT RETURN: controlled Coast2/loop1, naturally spawned charged-dying statue, native death/entry attraction/contact/restart, actual Vault/CrownPickup contact, visible pedestal return Portal, native exit/restart and next Coast3 OK @"+string(rates[pass_index]))
        array_push(completed_rates,rates[pass_index])
        if(++pass_index<array_length(rates)) {scrNTTEFullCoastVaultAwait(0);return;}
        assert(array_length(completed_rates)==2 && completed_rates[0]==30 && completed_rates[1]==60,
            "Coast/Vault must complete both actual30/60 rates before reporting PASS")
        scrNTTEFullCoastVaultRestore()
        scrNTTESmokeLog("PASS CoastVaultReturnNaturalTests actual scheduled30/60; controlled prerequisites, not full campaign combat")
        scrNTTESmokeLog("PASS full internal selected implemented branches x 30/60; not complete MOD coverage")
        game_end()
    }
}
function scrNTTEFullCoastVaultReturnStep() {
    try {scrNTTEFullCoastVaultStepBody()}
    catch(_error) {
        scrNTTESmokeLog("COAST VAULT failure phase="+string(phase)+" elapsed="+string(elapsed)
            +" rate="+string(rates[pass_index])+" rooms="+string(room_ends)+"/"+string(room_starts))
        scrNTTEFullCoastVaultRestore();throw _error
    }
}
