// Controlled synchronous provider regression, not campaign acquisition.
// Four genuine eligible Floors must still yield one source setpiece.
function scrNTTEFullBackpackProviderCountTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(GameCont)
        && instance_exists(Player) && !instance_exists(GenCont),"Backpack count needs settled desktop native actors")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_p=instance_find(Player,0),
        _seed=random_get_seed(),_rng=scrNTTEFullArrayCopy(global.rng_state),
        _directory=game_directory,_progress=global.ntte_full_progress,_skills=ds_list_create(),
        _save=UberCont.saveData,_save_bytes=ds_map_write(UberCont.saveData),_fixture_save=ds_map_create(),
        _hidden=scrNTTEFullInstances([hitme,chestprop,Floor,Wall,InvisiWall,PortalClear,GenCont,LevCont,
            WepPickup,CrownObject,Revive]),_scratch=working_directory+"backpack-count-"+string(get_timer())+"/"
    for(var _i=0;_i<array_length(_hidden);++_i) if(_hidden[_i]!=_p) instance_deactivate_object(_hidden[_i])
    ds_map_copy(_fixture_save,_save);UberCont.saveData=_fixture_save
    directory_create(_scratch);game_directory=_scratch
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    GameCont.skills=_skills;GameCont.ntte_full_native_skill_counts={}
    GameCont.ntte_full_skills={};GameCont.ntte_full_skill_order=[]
    try {
        GameCont.crown=crwn_none;GameCont.loops=1;GameCont.hard=5;GameCont.ntte_backpack_opened=false
        _p.x=160016;_p.y=160016;_p.xprevious=_p.x;_p.yprevious=_p.y
        _p.race=Race.Fish;_p.wep=wep_revolver;_p.bwep=wep_none;_p.curse=0;_p.bcurse=0
        var _base=scrNTTEFullInstances(all),_normal_seed=-1
        for(var _s=1;_s<=10000;++_s) {random_set_seed(_s);if(random(12)<1) {_normal_seed=_s;break}}
        assert(_normal_seed>=0,"No deterministic native1/12 Backpack seed")
        // Fish Campfire, two Rogue bodies+OpenMind2 Campfire, ordinary normal
        // area, and no legal candidate. Each call receives multiple real tiles.
        for(var _case=0;_case<4;++_case) {
            GameCont.area=_case==2?area_desert:area_campfire
            GameCont.hard=5;GameCont.loops=1
            _p.race=_case==1?Race.Rogue:Race.Fish
            _p.wep=_case==1?wep_rogue_rifle:wep_revolver;_p.bwep=wep_none
            ds_list_clear(_skills);GameCont.ntte_full_native_skill_counts={}
            if(_case==1) {
                scr_skill_set(mut_open_mind,2)
                var _revive=instance_create(162000,160000,Revive)
                _revive.race=Race.Rogue;_revive.wep=wep_none;_revive.bwep=wep_none
            }
            var _eligible=[]
            if(_case<3) for(var _i=0;_i<4;++_i) array_push(_eligible,instance_create(160256+_i*128,160000,Floor))
            // The source exclusion distance, hitme gate and chest gate each
            // have a real negative candidate, independent of shuffled order.
            instance_create(160000,160000,Floor)
            var _prop_floor=instance_create(161000,160000,Floor),_chest_floor=instance_create(161256,160000,Floor)
            instance_create((_prop_floor.bbox_left+_prop_floor.bbox_right)/2,
                (_prop_floor.bbox_top+_prop_floor.bbox_bottom)/2,Barrel)
            instance_create((_chest_floor.bbox_left+_chest_floor.bbox_right)/2,
                (_chest_floor.bbox_top+_chest_floor.bbox_bottom)/2,WeaponChest)
            var _valid=0,_floors=scrNTTEFullInstances(Floor,true)
            for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) {
                if(distance_to_object(Player)>80 && !place_meeting(x,y,hitme) && !place_meeting(x,y,chestprop)) _valid++
            }
            assert(_valid==(_case<3?4:0),"Backpack count fixture did not supply declared actual candidate geometry")
            var _ordinary=instance_number(NTTEFullBackpack),_ally=instance_number(NTTEFullAllyBackpack),
                _rogue=instance_number(NTTEFullRogueBackpack),_corpses=instance_number(NTTEFullBackpacker),
                _clears=instance_number(PortalClear),_call_before=scrNTTEFullInstances(all),
                _expected=_case==3?0:(_case==1?4:1),_expected_corpse=_case==2?1:0
            random_set_seed(_case==2?_normal_seed:70731+_case)
            var _returned=scrNTTEFullBackpackLevelStart(_case==2),
                _ordinary_delta=instance_number(NTTEFullBackpack)-_ordinary,
                _ally_delta=instance_number(NTTEFullAllyBackpack)-_ally,
                _rogue_delta=instance_number(NTTEFullRogueBackpack)-_rogue,
                _corpse_delta=instance_number(NTTEFullBackpacker)-_corpses,
                _clear_delta=instance_number(PortalClear)-_clears
            // AllyBackpack inherits Backpack; do not count it twice.
            var _chests=_ordinary_delta+_rogue_delta
            scrNTTESmokeLog("BACKPACK COUNT case="+string(_case)+" actual_candidates="+string(_valid)
                +" expected_chests="+string(_expected)+" returned="+string(_returned)
                +" ordinary_including_ally="+string(_ordinary_delta)+" ally="+string(_ally_delta)
                +" rogue="+string(_rogue_delta)+" corpses="+string(_corpse_delta)+" clears="+string(_clear_delta)
                +" @"+string(30/timescale))
            assert(_returned==_expected && _chests==_expected && _corpse_delta==_expected_corpse
                && _clear_delta==(_expected>0?1:0),"Backpack source first-eligible-floor setpiece count mismatch")
            assert(_case==1?(_rogue_delta==4 && _ordinary_delta==0):_rogue_delta==0,
                "Backpack count changed source Rogue/Revive/OpenMind chest kinds")
            var _selected=noone,_new_clears=scrNTTEFullInstances(PortalClear)
            for(var _i=0;_i<array_length(_new_clears);++_i) if(array_get_index(_call_before,_new_clears[_i])<0) {
                var _clear=_new_clears[_i]
                for(var _j=0;_j<array_length(_eligible);++_j) {
                    var _f=_eligible[_j]
                    if(_clear.x==(_f.bbox_left+_f.bbox_right)/2 && _clear.y==(_f.bbox_top+_f.bbox_bottom)/2) _selected=_f
                }
            }
            assert((_expected==0 && _selected==noone) || instance_exists(_selected),
                "Backpack clear did not originate from an actual eligible candidate")
            if(instance_exists(_selected)) {
                var _cx=(_selected.bbox_left+_selected.bbox_right)/2,_cy=(_selected.bbox_top+_selected.bbox_bottom)/2,
                    _new=scrNTTEFullInstances([NTTEFullBackpack,NTTEFullRogueBackpack])
                for(var _i=0;_i<array_length(_new);++_i) if(array_get_index(_call_before,_new[_i])<0) {
                    var _chest=_new[_i]
                    assert(abs(_chest.xstart-_cx)<=4 && abs(_chest.ystart-(_cy-6))<=min(4,_expected-1),
                        "Backpack source coordinate draws spread one setpiece across multiple Floors")
                }
            }
            scrNTTEFullMergedRuntimeTestCleanup(_base)
        }
        // Gate negatives are unchanged and do not consume a candidate shuffle.
        GameCont.area=area_hq;GameCont.hard=5;random_set_seed(7761)
        var _expected_rng=random(100000);random_set_seed(7761)
        assert(scrNTTEFullBackpackLevelStart(true)==0 && random(100000)==_expected_rng,"HQ Backpack gate consumed RNG")
        GameCont.area=area_campfire;GameCont.hard=4;random_set_seed(7762)
        _expected_rng=random(100000);random_set_seed(7762)
        assert(scrNTTEFullBackpackLevelStart(true)==0 && random(100000)==_expected_rng,"Hard<=4 Backpack gate consumed RNG")
        scrNTTESmokeLog("PASS BACKPACK PROVIDER COUNT: four actual candidates/one source setpiece; Fish1, Rogue+Revive+OpenMind2=4, normal1+oneBackpacker, onePortalClear, no-candidate and original HQ/hard gates @"+string(30/timescale))
    }
    finally {
        // New actors are removed while the fixture still owns progress/data.
        scrNTTEFullMergedRuntimeTestCleanup(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) if(_hidden[_i]!=_p) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game)
        ds_list_destroy(_skills);global.rng_state=_rng;random_set_seed(_seed)
        game_directory=_directory;global.ntte_full_progress=_progress
        UberCont.saveData=_save;ds_map_destroy(_fixture_save)
        var _names=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_names);++_i) if(file_exists(_scratch+_names[_i])) file_delete(_scratch+_names[_i])
        if(directory_exists(_scratch)) directory_destroy(_scratch)
        assert(ds_map_write(_save)==_save_bytes,"Backpack provider fixture changed original native save-map bytes")
    }
}
