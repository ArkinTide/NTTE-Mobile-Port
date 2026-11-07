// Development-only isolated native regression. The chest's own collision,
// Room End, permanent file, menu confirmation, room restart, pickup and firing
// consumers execute; only fixture placement and deliberate cold-registry reset
// are supplied by this observer.
function scrFRProtoChestTestsStart(_driver) {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled(),
        "Proto Chest regression requires the private desktop harness");
    scrNTTEFullWeaponNativeInit();
    var _original=UberCont.saveData,_copy=ds_map_create();
    ds_map_copy(_copy,_original);UberCont.saveData=_copy;
    _driver.persistent=true;
    _driver.fr_proto_chest={phase:0,round:0,ticks:0,wait:0,rows:[],
        original_map:_original,original_bytes:ds_map_write(_original),fixture_map:_copy,
        original_models:global.ntte_full_native_weapon_models,
        original_base:global.ntte_full_native_weapon_base,
        marker:noone,player:noone,icon:noone,game:noone,retiring:undefined};
    global.fr_proto_chest_test_state=_driver.fr_proto_chest;
    save_set_value("game","tutorial",false);
    save_set_value("options","autopause",false);
    save_set_value("visual","freezeframes",0);
    save_set_value("visual","bossintro",false);
    UberCont.custom=false;UberCont.daily_run=false;UberCont.weekly_run=false;
    UberCont.opt_autopause=false;UberCont.opt_freeze=0;UberCont.paused=false;
}

function scrFRProtoChestTestsStore(_state) {
    var _p=instance_find(Player,0),_x=800000,_y=800000;
    with(_p) {
        x=_x;y=_y;xprevious=x;yprevious=y;hspeed=0;vspeed=0;
        hp=10000;max_hp=10000;nexthurt=current_frame+100000;
        can_pick=true;curse=false;bcurse=false;
    }
    with(ProtoChest) instance_destroy(id,false);
    with(WepPickup) instance_destroy(id,false);
    UberCont.protowep=wep_rusty_revolver;UberCont.protocurse=false;
    var _chest=instance_create(_x+128,_y,ProtoChest);
    with(_p) with(_chest) event_perform(ev_collision,Player);
    assert(_chest.sprite_index==sprProtoChestOpen,"Actual Proto Chest did not open before storage");
    with(WepPickup) instance_destroy(id,false);
    var _shared={token:74321},_front={wep:wep_shotgun,proto_shared:_shared},
        _model=scrNTTEFullWeaponMerge({wep:wep_revolver,proto_shared:_shared},_front);
    // A harmless metadata back-reference is a real graph cycle, but it is
    // outside the weapon/raw and merge walks and must keep its aliases.
    _shared.owner=_model;
    if(_state.round==1) {
        // Exercise a real NTUF physical source leaf as a component too.
        _front.wep=global.fr_weapon_ids[$ "FR_TeminiteCannon"];
        _front.ntte_native_state=scrNTTENewState(_front.wep);
        // Obtain the complete authored lightweight record through the actual
        // mounted-component prepare/step route. A hand-made partial record
        // would skip lwo_initialize's teminite_max and fail even before save.
        assert(scrFRWeaponMergedCallback(_p,_front,true,"step"),
            "NTUF Proto fixture did not execute its real component initializer");
        var _source=_front.ntte_native_state.fr_source_weapon;
        assert(is_struct(_source) && _source.teminite_max==9 && _source.teminite==1,
            "NTUF Proto fixture did not receive its complete authored source record");
        _source.teminite=7;_source.proto_marker=74321;
    }
    var _handle=scrNTTEFullWeaponNative(_model),_physical=scrNTTEFullWeaponNativeState(_handle);
    _physical.ammo=7;_physical.charge=3;_physical.proto_marker=74321;
    _state.expected_name=scr_weapon_get_name(_handle);
    _state.expected_front=_front.wep;_state.model=_model;_state.old_handle=_handle;
    var _drop=scrWeaponPickupCreate(_chest.x,_chest.y,_handle);
    _drop.speed=0;
    with(_drop) with(_chest) event_perform(ev_collision,WepPickup);
    assert(!instance_exists(_drop) && _chest.wep==_handle && _chest.sprite_index==sprProtoChest,
        "Actual Proto Chest collision did not store the physical fusion");
    with(_chest) event_perform(ev_other,ev_room_end);
    assert(UberCont.protowep==_handle,"Chest Room End lost the original live weapon handle");
    scrSave();
    var _json=scrPersistentJsonLoad(game_directory+"NuclearThrone.sav");
    assert(is_string(_json),"Production permanent save did not commit the Proto Chest fixture");
    var _disk=json_decode(_json);
    assert(ds_exists(_disk,ds_type_map),"Production Proto Chest save is not a native save map");
    // Do not stop the legacy control at its bad disk representation: carry
    // those actual bytes through the genuine new run and observe its failure.
    _state.saved_raw=_disk[? "etc_protowep"];
    var _saved_model=_disk[? "etc_protowep_model"];
    _state.saved_graph=is_string(_saved_model) && string_length(_saved_model)>0;
    _state.disk=_disk;
    scrNTTESmokeLog("NTUF PROTO CHEST real collision/Room End/disk stored "+json_stringify({
        round:_state.round,handle:_handle,stored:_disk[? "etc_protowep"],name:_state.expected_name}));
}

function scrFRProtoChestTestsMenu(_driver) {
    var _state=_driver.fr_proto_chest;
    // scrGameRestart(true) already removed the complete old runtime/session.
    // The only retained fixture data lives on global, not on a spared actor.
    assert(!instance_exists(_state.previous_driver) && !instance_exists(GameCont)
        && !instance_exists(Player),"Proto Chest restart retained its old driver or native game");
    if(!scrFREnabled() || !instance_exists(FRWorld)) return false;
    var _previous=UberCont.saveData;
    UberCont.saveData=_state.disk;_state.fixture_map=_state.disk;_state.disk=undefined;
    ds_map_destroy(_previous);
    global.ntte_full_native_weapon_base=maxwep+1;
    global.ntte_full_native_weapon_models=[];
    global.ntte_full_loadout_weapon_cache={};
    // The original startup/PlayButton scalar read deliberately remains intact.
    // No model or temporary inventory number crosses this disk boundary.
    UberCont.protowep=save_get_value("etc","protowep",wep_rusty_revolver);
    UberCont.protocurse=false;
    var _snapshot=save_get_value("etc","protowep_model","");
    // A real new-run/menu autosave can happen long before another Proto Chest
    // is visited. It must not flatten its unopened physical weapon snapshot.
    scrSave();
    var _autosaved=json_decode(scrPersistentJsonLoad(game_directory+"NuclearThrone.sav"));
    if(_state.saved_graph) assert(_autosaved[? "etc_protowep"]==_state.saved_raw
        && _autosaved[? "etc_protowep_model"]==_snapshot,
        "Cold unopened Proto Chest snapshot was erased by unrelated permanent autosave");
    ds_map_destroy(_autosaved);
    var _rate=_state.round==0?30:60;
    save_set_value("options","framerate",_rate);
    scrOptionsUpdate();
    UberCont.paused=false;UberCont.opt_autopause=false;UberCont.opt_freeze=0;
    UberCont.want_quit_to_menu=false;UberCont.want_menu=false;UberCont.want_restart=false;
    global.seed=743210+_state.round;global.crownpick=crwn_none;
    scr_playerinstances_reset_all();
    scr_loadout_race_set_start_weapon(Race.Fish,wep_revolver);
    var _menu=instance_create(0,0,Menu);
    _state.icon=noone;
    with(CharSelect) if(race==Race.Fish) {_state.icon=id;break;}
    assert(instance_exists(_menu) && instance_exists(_state.icon) && !instance_exists(GameCont),
        "Proto Chest test did not reach the ordinary native character menu");
    _state.phase=2;_state.wait=0;
    return true;
}

function scrFRProtoChestTestsLegacyCollision(_x,_y) {
    var _saved=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model",""),_live=UberCont.protowep;
    // Actually retire a registered last-slot model, then register a different
    // model into that same number as a cold registry can do. A distant unused
    // number alone would not expose the legacy-handle collision.
    var _retired_model={wep:wep_revolver,proto_retired:74321},
        _old_handle=scrNTTEFullWeaponNative(_retired_model);
    assert(_old_handle>maxwep && scrNTTEFullWeaponIsNative(_old_handle),
        "Legacy collision fixture did not allocate a real physical handle");
    assert(array_pop(global.ntte_full_native_weapon_models)==_retired_model,
        "Legacy collision fixture did not retire its own last registered model");
    var _unrelated=scrNTTEFullWeaponMerge({wep:wep_shotgun,proto_current:88214},{wep:wep_revolver}),
        _reused=scrNTTEFullWeaponNative(_unrelated),_physical=scrNTTEFullWeaponNativeState(_reused);
    _physical.proto_current=88214;
    assert(_reused==_old_handle && scrNTTEFullWeaponModel(_old_handle)==_unrelated
        && _unrelated!=_retired_model && scr_weapon_is_valid(_old_handle),
        "Legacy collision fixture failed to occupy the old number with a different valid model");
    try {
        var _companions=["","{broken","{}"];
        for(var _i=0;_i<array_length(_companions);++_i) {
            save_set_value("etc","protowep",_old_handle);
            save_set_value("etc","protowep_model",_companions[_i]);
            UberCont.protowep=_old_handle;
            scrSave();
            var _disk=json_decode(scrPersistentJsonLoad(game_directory+"NuclearThrone.sav"));
            assert(_disk[? "etc_protowep"]==_old_handle
                && _disk[? "etc_protowep_model"]==_companions[_i],
                "Unrelated autosave adopted the unrelated model behind a reused legacy Proto handle");
            ds_map_destroy(_disk);
            var _chest=instance_create(_x+64,_y,ProtoChest);
            assert(_chest.wep==wep_rusty_revolver && UberCont.protowep==wep_rusty_revolver
                && scrNTTEFullWeaponModel(_reused)==_unrelated,
                "Actual Proto Chest constructor exposed an unrelated reused model from a missing/damaged legacy graph");
            instance_destroy(_chest,false);
        }
        // A current-run transfer differs from the permanent static slot and
        // must keep its actual model/state. Explicit Room End storage is a
        // genuine new snapshot, even if this live number had an old collision.
        save_set_value("etc","protowep",wep_revolver);
        save_set_value("etc","protowep_model","");
        UberCont.protowep=_reused;
        var _transfer=instance_create(_x+64,_y,ProtoChest);
        assert(_transfer.wep==_reused && UberCont.protowep==_reused
            && scrNTTEFullWeaponNativeState(_transfer.wep)==_physical && _physical.proto_current==88214,
            "Proto legacy safety check replaced a valid current-run live transfer");
        with(_transfer) event_perform(ev_other,ev_room_end);
        var _new_snapshot=save_get_value("etc","protowep_model",""),
            _restored=scrNTTEFullLoadoutWeaponUnpack(json_parse(_new_snapshot));
        assert(save_get_value("etc","protowep",-1)==wep_shotgun
            && is_struct(_restored) && scrNTTEFullWeaponRaw(_restored)==wep_shotgun
            && scrNTTEFullWeaponRaw(scrNTTEFullWeaponMergedPart(_restored))==wep_revolver
            && _restored.ntte_native_state.proto_current==88214,
            "Explicit Proto Room End storage did not replace the legacy slot with its actual new graph");
        instance_destroy(_transfer,false);
        scrNTTESmokeLog("NTUF PROTO CHEST legacy real-handle collision missing/damaged graph autosave+constructor PASS; live transfer and explicit new snapshot PASS; historical scalar/static-ID ambiguity cannot reconstruct lost composition");
    } finally {
        save_set_value("etc","protowep",_saved);
        save_set_value("etc","protowep_model",_snapshot);UberCont.protowep=_live;
    }
}

function scrFRProtoChestTestsMalformedCycles(_x,_y) {
    var _saved=save_get_value("etc","protowep",wep_rusty_revolver),
        _snapshot=save_get_value("etc","protowep_model",""),_live=UberCont.protowep;
    var _raw_self={};_raw_self.wep=_raw_self;
    var _raw_a={},_raw_b={};_raw_a.wep=_raw_b;_raw_b.wep=_raw_a;
    var _merge_self={wep:wep_revolver};
    _merge_self.temerge={is_active:true,wep:[_merge_self]};
    var _merge_a={wep:wep_revolver},_merge_b={wep:wep_shotgun};
    _merge_a.temerge={is_active:true,wep:[_merge_b]};
    _merge_b.temerge={is_active:true,wep:[_merge_a]};
    var _inactive={wep:wep_revolver};
    _inactive.temerge={is_active:false,wep:[_inactive]};
    var _bad_front={wep:wep_revolver,temerge:{is_active:true,wep:[]}},
        _malformed=[_raw_self,_raw_a,_merge_self,_merge_a,_inactive,_bad_front];
    try {
        for(var _i=0;_i<array_length(_malformed);++_i) {
            var _model=_malformed[_i];
            assert(!scrNTTEFullProtoWeaponTopologyValid(_model),
                "Proto topology accepted a cyclic or malformed weapon chain");
            // The shared graph encoder intentionally supports aliases/cycles.
            // Carry its syntactically valid JSON through the actual permanent
            // save bytes and chest constructor, rather than a helper-only mock.
            var _damaged=json_stringify(scrNTTEFullLoadoutWeaponPack(_model));
            save_set_value("etc","protowep",wep_shotgun);
            save_set_value("etc","protowep_model",_damaged);UberCont.protowep=wep_shotgun;
            scrSave();
            var _disk=json_decode(scrPersistentJsonLoad(game_directory+"NuclearThrone.sav"));
            assert(_disk[? "etc_protowep"]==wep_shotgun
                && _disk[? "etc_protowep_model"]==_damaged,
                "Unrelated autosave changed an unopened malformed Proto graph");
            var _previous_map=UberCont.saveData,_chest=noone;
            UberCont.saveData=_disk;
            try {
                UberCont.protowep=save_get_value("etc","protowep",wep_rusty_revolver);
                _chest=instance_create(_x+96,_y,ProtoChest);
                assert(_chest.wep==wep_shotgun && UberCont.protowep==wep_shotgun,
                    "Malformed Proto graph did not safely retain its ordinary fallback");
            } finally {
                if(instance_exists(_chest)) instance_destroy(_chest,false);
                UberCont.saveData=_previous_map;ds_map_destroy(_disk);
            }
            // Both current-run restore and explicit Room End writes also see
            // the topology guard before any potentially endless native getter.
            UberCont.protowep=_model;
            _chest=instance_create(_x+96,_y,ProtoChest);
            assert(_chest.wep==wep_rusty_revolver,
                "Malformed live Proto transfer reached a native getter");
            _chest.wep=_model;_chest.sprite_index=sprProtoChest;
            with(_chest) event_perform(ev_other,ev_room_end);
            assert(save_get_value("etc","protowep",-1)==wep_rusty_revolver
                && save_get_value("etc","protowep_model","invalid")=="",
                "Explicit malformed Proto storage did not use its safe stock fallback");
            instance_destroy(_chest,false);
        }
        scrNTTESmokeLog("NTUF PROTO CHEST actual save/disk/constructor raw+merge self/indirect/inactive cycles and malformed front PASS; guarded live restore and explicit storage PASS");
    } finally {
        save_set_value("etc","protowep",_saved);
        save_set_value("etc","protowep_model",_snapshot);UberCont.protowep=_live;
    }
}

function scrFRProtoChestTestsRetrieve(_state) {
    var _p=_state.player,_x=800000,_y=800000;
    with(_p) {
        x=_x;y=_y;xprevious=x;yprevious=y;hspeed=0;vspeed=0;
        hp=10000;max_hp=10000;nexthurt=current_frame+100000;
        can_pick=true;curse=false;bcurse=false;max_extra_weps=0;extra_weps=[];
        wep=wep_revolver;bwep=wep_none;ntte_state=scrNTTENewState(wep_revolver);
        fr_source_wep=undefined;fr_source_bwep=undefined;
    }
    with(ProtoChest) instance_destroy(id,false);
    with(WepPickup) instance_destroy(id,false);
    // A custom loadout may explicitly choose the exact same ordinary ID as
    // the permanent chest's numeric fallback. Its actual constructor and
    // Room End/save consumers must not adopt or overwrite that normal-run
    // physical snapshot simply because both raw values are the same.
    var _old_custom=UberCont.custom,_old_proto=UberCont.protowep,
        _saved_snapshot=save_get_value("etc","protowep_model","");
    UberCont.custom=true;UberCont.protowep=_state.saved_raw;
    var _custom=instance_create(_x+64,_y,ProtoChest);
    assert(_custom.wep==_state.saved_raw && !scrNTTEFullWeaponIsNative(_custom.wep),
        "Actual same-raw custom Proto Chest adopted the permanent normal-run fusion");
    with(_custom) event_perform(ev_other,ev_room_end);
    scrSave();
    assert(save_get_value("etc","protowep",-1)==_state.saved_raw
        && save_get_value("etc","protowep_model","")==_saved_snapshot,
        "Actual custom Proto Chest Room End/permanent save overwrote the normal-run physical snapshot");
    instance_destroy(_custom,false);UberCont.custom=_old_custom;UberCont.protowep=_old_proto;
    var _chest=instance_create(_x,_y,ProtoChest),_handle=_chest.wep,
        _model=scrNTTEFullWeaponModel(_handle),_front=scrNTTEFullWeaponMergedPart(_model),
        _physical=scrNTTEFullWeaponNativeState(_handle);
    assert(_state.saved_raw==wep_revolver && _state.saved_graph
        && scrNTTEFullWeaponIsNative(_handle) && _model!=_state.model
        && scrNTTEFullWeaponHasMerge(_handle)==true
        && scrNTTEFullWeaponRaw(_model)==wep_revolver && _front.wep==_state.expected_front
        && _model.proto_shared==_front.proto_shared && _model.proto_shared.token==74321
        && _model.proto_shared.owner==_model
        && _physical.proto_marker==74321 && _physical.ammo==7 && _physical.charge==0
        && _physical.weapon==_handle,
        "Cold new-run Proto Chest lost its fusion, aliases or canonical physical state");
    assert(scr_weapon_get_name(_handle)==_state.expected_name
        && string_pos("WEAPON",scr_weapon_get_name(_handle))!=1
        && sprite_exists(scr_weapon_get_sprite(_handle)),
        "Cold Proto Chest restored an invalid name or fallback sprite");
    if(_state.round==1) {
        var _source=_front.ntte_native_state.fr_source_weapon;
        assert(is_struct(_source) && _source.wep==_state.expected_front
            && _source.teminite==7 && _source.teminite_max==9 && _source.proto_marker==74321
            && !variable_struct_exists(_source,"fr_type"),
            "Proto Chest graph did not decode its real NTUF source weapon leaf");
    }
    with(_p) with(_chest) event_perform(ev_collision,Player);
    var _drop=noone;
    with(WepPickup) if(wep==_handle) {_drop=id;break;}
    assert(instance_exists(_drop),"Actual new-run Proto Chest opening did not emit its restored fusion");
    _drop.speed=0;_drop.autopick=true;
    with(_drop) with(_p) event_perform(ev_collision,WepPickup);
    assert(!instance_exists(_drop) && _p.wep==_handle && _p.ntte_state==_physical,
        "Actual new-run pickup crashed or lost its restored physical fusion");
    _p.reload=-1;_p.can_shoot=true;_p.clicked=false;_p.wepangle=1;
    _p.infammo=30;_p.ammo=array_create(Ammo.NUM_AMMO_TYPES,1000);_p.gunangle=0;_p.accuracy=0;
    KeyCont.press_fire[_p.index]=true;KeyCont.hold_fire[_p.index]=true;
    var _capture=scrNTTEFullMergedCaptureBegin();
    with(_p) scrPlayerFiring();
    var _shots=scrNTTEFullMergedCaptureEnd(_capture);
    KeyCont.press_fire[_p.index]=false;KeyCont.hold_fire[_p.index]=false;
    assert(array_length(_shots)>0 && _p.wep==_handle,
        "Restored Proto Chest fusion did not fire through actual PlayerFiring");
    with(_chest) event_perform(ev_other,ev_room_end);
    assert(UberCont.protowep==wep_rusty_revolver
        && save_get_value("etc","protowep_model","")=="",
        "An emptied Proto Chest retained its previous fusion reset snapshot");
    // Ordinary old saves and malformed companion data retain numeric slots;
    // unrecoverable old dangling handles never become invalid pickups.
    save_set_value("etc","protowep",wep_shotgun);
    save_set_value("etc","protowep_model","");
    assert(scrNTTEFullProtoWeaponRestore(wep_shotgun)==wep_shotgun,"Legacy ordinary Proto Chest save changed");
    save_set_value("etc","protowep_model","{broken");
    assert(scrNTTEFullProtoWeaponRestore(wep_shotgun)==wep_shotgun,"Damaged Proto companion invalidated a legacy weapon");
    assert(scrNTTEFullProtoWeaponRestore(1000000)==wep_rusty_revolver,"Old dangling Proto handle reached a pickup");
    scrFRProtoChestTestsLegacyCollision(_x,_y);
    scrFRProtoChestTestsMalformedCycles(_x,_y);
    array_push(_state.rows,{round:_state.round,rate:30/timescale,name:scr_weapon_get_name(_handle),
        raw:scrNTTEFullWeaponRaw(_handle),front:_front.wep,shots:array_length(_shots),
        native_menu_new_run:true,actual_disk_round_trip:true,registry_reset:true});
    scrNTTESmokeLog("NTUF PROTO CHEST actual new-run retrieval/pickup/fire PASS "+json_stringify(_state.rows[_state.round]));
}

function scrFRProtoChestTestsStep(_driver) {
    var _state=_driver.fr_proto_chest;
    _state.ticks+=1;
    assert(_state.ticks<4800,"Proto Chest actual new-run regression timed out at phase "+string(_state.phase));
    if(_state.phase==0) {
        scrFRProtoChestTestsStore(_state);_state.phase=1;_state.previous_driver=_driver;
        // Exercise the genuine native restart and its complete actor cleanup.
        // In particular FRWorld is not exempted by this regression fixture.
        scrGameRestart(true);
        return false;
    }
    if(_state.phase==1) {scrFRProtoChestTestsMenu(_driver);return false;}
    if(_state.phase==2) {
        _state.wait+=1;if(_state.wait<4) return false;
        assert(instance_exists(_state.icon) && _state.icon.can,"Native Fish selection was not available");
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        _state.phase=3;_state.wait=0;return false;
    }
    if(_state.phase==3) {
        _state.wait+=1;if(_state.wait<4) return false;
        _state.marker=instance_create(0,0,FRMarker);
        _state.phase=4;
        with(_state.icon) event_perform(ev_mouse,ev_left_press);
        assert(instance_number(GameCont)==1 && instance_number(Player)==1,
            "Native Proto Chest test confirmation did not start a genuine new run");
        _state.player=instance_find(Player,0);_state.game=GameCont.id;
        return false;
    }
    if(_state.phase==4) {
        assert(!instance_exists(_state.marker) && !instance_exists(Menu) && !instance_exists(GenCont),
            "Native new-run room restart retained its former menu/terrain");
        if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
        if(!instance_exists(MusCont)) instance_create(0,0,MusCont);
        var _gen=instance_create(0,0,GenCont);
        assert(!_gen.ntte_full_sync_generation,"Proto Chest fixture substituted synchronous generation");
        _state.phase=5;return false;
    }
    if(_state.phase==5) {
        if(instance_exists(GenCont) || instance_exists(FloorMaker) || scrGameIsGenerationScreen()) return false;
        assert(instance_exists(_state.player) && instance_exists(TopCont) && instance_number(Floor)>20,
            "Actual Proto Chest new run did not finish populated native generation");
        scrFRProtoChestTestsRetrieve(_state);
        _state.round+=1;
        if(_state.round<2) {_state.phase=0;return false;}
        UberCont.saveData=_state.original_map;ds_map_destroy(_state.fixture_map);
        assert(ds_map_write(_state.original_map)==_state.original_bytes,"Proto Chest fixture changed original permanent save bytes");
        global.ntte_full_native_weapon_models=_state.original_models;
        global.ntte_full_native_weapon_base=_state.original_base;
        global.fr_proto_chest_test_state=undefined;
        scrNTTESmokeLog("PASS FRONTIER PROTO CHEST real storage, disk/cold-registry, native menu/new-run, opening, pickup and fire at30/60Hz "+json_stringify(_state.rows));
        _state.phase=6;return true;
    }
    return _state.phase==6;
}

function scrFRProtoChestTestsObserve() {
    if(os_type!=os_windows || !scrNTTEFullSmokeEnabled()
        || !variable_global_exists("fr_proto_chest_test_state")) return;
    var _state=global.fr_proto_chest_test_state;
    if(!is_struct(_state) || _state.phase!=1) return;
    with(FRIntegrationTest) if(fr_test_case=="proto-chest") return;
    var _driver=instance_create(0,0,FRIntegrationTest);
    _driver.fr_test_case="proto-chest";_driver.fr_proto_chest=_state;
}
