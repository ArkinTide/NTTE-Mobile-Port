// Controlled exact extracted Heart chest branch; not natural unfolding.
// Setup makes genuine native terrain/blockers; observations only read actors.
function scrNTTEFullCrystalChestShuffled(_floor,_generation,_index,_chest,_pos) {
    var _o=global.ntte_crystal_chest_probe,_eligible=[],_order=[]
    assert(_o.measuring && is_undefined(_o.active),"Heart chest shuffle lacks a sealed predecessor")
    assert(id==_o.host && _index==array_length(_o.rows),"Heart chest shuffle receiver/index changed")
    assert(array_get_index(_floor,_o.old_floor)<0 && array_get_index(_floor,_o.child_floor)<0,
        "Heart chest shuffle included old-generation or non-normal floor")
    for(var _j=0;_j<array_length(_floor);++_j) with(_floor[_j]) {
        assert(object_index==Floor && real(id)>real(_generation),"Heart chest shuffle floor violates actual generation/normal gate")
        var _wall=place_meeting(x,y,Wall),_prop=place_meeting(x,y,prop),_chestblock=place_meeting(x,y,chestprop),
            _large=false,_enemies=scrNTTEFullInstances(enemy)
        for(var _k=0;_k<array_length(_enemies);++_k)
            if(_enemies[_k].size>1 && place_meeting(x,y,_enemies[_k])) {_large=true;break}
        var _entry={tile:id,x:(bbox_left+bbox_right)/2,y:(bbox_top+bbox_bottom)/2,
            wall:_wall,prop:_prop,chest:_chestblock,large:_large}
        array_push(_order,_entry)
        if(!_wall && !_prop && !_chestblock && !_large) array_push(_eligible,_entry)
    }
    var _count=_o.eligible_count-(_o.two_chests?_index:0)
    assert(array_length(_eligible)==_count,"Heart chest controlled actual candidate count changed")
    for(var _j=0;_j<array_length(_o.excluded);++_j) {
        var _excluded=_o.excluded[_j],_seen=false
        for(var _k=0;_k<array_length(_order);++_k) if(_order[_k].tile==_excluded) {
            _seen=true
            assert(_order[_k].wall || _order[_k].prop || _order[_k].chest || _order[_k].large,
                "Heart chest declared negative floor became eligible")
        }
        assert(_seen,"Heart chest shuffle lost an actual negative candidate")
    }
    // Two chest iterations must see the first native chest occupying its tile.
    if(_index>0) {
        var _previous=_o.rows[_index-1],_occupied=false
        for(var _j=0;_j<array_length(_order);++_j)
            if(_order[_j].tile==_previous.expected.tile) _occupied=_order[_j].chest
        assert(_occupied,"Heart chest second shuffle ignored first native chest occupancy")
    }
    _o.active={host:id,index:_index,chest:_chest,pos:_pos,order:_order,eligible:_eligible,
        before:scrNTTEFullInstances([chestprop,RadChest,Mimic,SuperMimic]),
        shuffle_rng:scrNTTEFullArrayCopy(global.rng_state),expected:undefined,actor:noone}
}
function scrNTTEFullCrystalChestBefore(_index,_cx,_cy,_chest) {
    var _o=global.ntte_crystal_chest_probe,_a=_o.active
    assert(_o.measuring && is_struct(_a) && _a.host==id && _a.index==_index && _a.chest==_chest,
        "Heart chest before-create receiver/order changed")
    var _eligible=_a.eligible,_count=array_length(_eligible),_expected={tile:noone,x:x,y:y},_maximum=-1
    if(_count>0) {
        if(_a.pos=="random") _expected=_eligible[0]
        else for(var _j=0;_j<_count;++_j) {
            var _distance=point_distance(x,y,_eligible[_j].x,_eligible[_j].y)
            if(_distance>_maximum) {_maximum=_distance;_expected=_eligible[_j]}
        }
    }
    if(_o.require_distinct) {
        assert(_count>1 && _eligible[0].tile!=_eligible[_count-1].tile
            && point_distance(_eligible[0].x,_eligible[0].y,_eligible[_count-1].x,_eligible[_count-1].y)>32,
            "Heart chest baseline did not prove distinct first and last actual eligible positions")
    }
    scrNTTESmokeLog("CRYSTAL HEART CHEST before "+json_stringify({scenario:_o.scenario,rate:30/timescale,
        index:_index,pos:_a.pos,actual:[_cx,_cy],expected:[_expected.x,_expected.y],
        shuffled:_a.order,eligible:_eligible,first_last_distinct:_o.require_distinct,
        ordinary_seed_metadata:random_get_seed(),named_rng:global.rng_state}))
    assert(json_stringify(global.rng_state)==json_stringify(_a.shuffle_rng),"Heart chest selection changed named RNG between shuffle and constructor")
    assert(_cx==_expected.x && _cy==_expected.y,
        "SOURCE CRYSTAL HEART CHEST: random must use FIRST actual shuffled collision-eligible floor; furthest/fallback must match source")
    _a.expected=_expected
}
function scrNTTEFullCrystalChestAfter(_index,_new) {
    var _o=global.ntte_crystal_chest_probe,_a=_o.active,_created=[],
        _all=scrNTTEFullInstances([chestprop,RadChest,Mimic,SuperMimic])
    assert(_o.measuring && is_struct(_a) && _a.host==id && _a.index==_index && is_struct(_a.expected),
        "Heart chest after-create lacks original before probe")
    for(var _j=0;_j<array_length(_all);++_j) if(array_get_index(_a.before,_all[_j])<0) array_push(_created,_all[_j])
    assert(array_length(_created)==1 && instance_exists(_new) && _created[0]==_new,
        "Heart chest source branch did not create exactly one actual chest")
    assert(_new.object_index==WeaponChest && _new.x==_a.expected.x && _new.y==_a.expected.y
        && _new.xstart==_a.expected.x && _new.ystart==_a.expected.y,
        "Heart chest actual native constructor location/type changed")
    _a.actor=_new
    array_push(_o.rows,_a);_o.active=undefined
}
function scrNTTEFullCrystalChestDeleteSince(_before) {
    var _all=scrNTTEFullInstances(all)
    for(var _i=array_length(_all)-1;_i>=0;--_i)
        if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
}
function scrNTTEFullCrystalHeartChestOrderTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(GameCont)
        && !instance_exists(GenCont),"Heart chest controlled branch needs settled dedicated desktop smoke")
    assert(timescale==1 || timescale==0.5,"Heart chest controlled branch requires actual30/60")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player),
        _seed=random_get_seed(),_global_vars=[],_graph={nodes:[]},
        _hidden=scrNTTEFullInstances([Floor,Wall,enemy,prop,chestprop,RadChest,FloorMaker,Menu,MenuGen]),
        _old_map=UberCont.saveData,_old_savedata=ds_map_write(UberCont.saveData),_fixture_map=ds_map_create(),
        _original_names=variable_struct_get_names(global),_directory=game_directory,
        _scratch=working_directory+"crystal-chest-order-"+string(get_timer())+"/"
    for(var _i=0;_i<array_length(_original_names);++_i) {
        var _name=_original_names[_i],_value=variable_global_get(_name)
        array_push(_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
    }
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    ds_map_copy(_fixture_map,_old_map);UberCont.saveData=_fixture_map
    directory_create(_scratch);game_directory=_scratch
    var _walls_list=ds_list_create()
    try {
        global.lis_walls_visible=_walls_list
        global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
        GameCont.area=area_desert;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=2
        GameCont.crown=crwn_none;GameCont.nochest=0;GameCont.underwater=false;UberCont.hardmode=false
        global.ntte_crystal_chest_probe={measuring:false,active:undefined,rows:[]}
        var _cases=[{name:"multiple-distinct-random",count:3,pos:"random",chests:1,distinct:true},
            {name:"single-small-enemy-allowed",count:1,pos:"random",chests:1,distinct:false},
            {name:"all-blocked-fallback",count:0,pos:"random",chests:1,distinct:false},
            {name:"furthest",count:3,pos:"furthest",chests:1,distinct:false},
            {name:"two-chests-occupancy",count:2,pos:"random",chests:2,distinct:false}]
        for(var _case=0;_case<array_length(_cases);++_case) {
            var _config=_cases[_case],_start=scrNTTEFullInstances(all),_cx=190000,_cy=190000,
                _old_floor=instance_create(_cx-2048,_cy-16,Floor),
                _generation=instance_create(_cx+4096,_cy,NTTEDesertDecor),
                _host=instance_create(_cx,_cy,NTTEDesertDecor),
                _child=instance_create(_cx-1536,_cy,FloorExplo),_eligible=[],_excluded=[]
            assert(instance_exists(_old_floor) && instance_exists(_generation) && instance_exists(_child),
                "Heart chest real generation/old-normal/child-floor setup failed")
            _host.area_chest=_config.chests==2?[WeaponChest,WeaponChest]:[WeaponChest]
            _host.area_chest_pos=_config.pos
            for(var _i=0;_i<_config.count;++_i) {
                var _f=instance_create(_cx+256+_i*192-16,_cy-16,Floor)
                assert(instance_exists(_f) && _f.object_index==Floor && real(_f)>real(_generation),
                    "Heart chest setup did not make genuine new normal candidate floor")
                array_push(_eligible,_f)
            }
            // Each exclusion is native collision geometry, never an oracle flag.
            var _wall_floor=instance_create(_cx+1024-16,_cy-16,Floor),
                _prop_floor=instance_create(_cx+1280-16,_cy-16,Floor),
                _chest_floor=instance_create(_cx+1536-16,_cy-16,Floor),
                _large_floor=instance_create(_cx+1792-16,_cy-16,Floor)
            array_push(_excluded,_wall_floor);array_push(_excluded,_prop_floor)
            array_push(_excluded,_chest_floor);array_push(_excluded,_large_floor)
            instance_create(_wall_floor.x,_wall_floor.y,Wall)
            instance_create((_prop_floor.bbox_left+_prop_floor.bbox_right)/2,(_prop_floor.bbox_top+_prop_floor.bbox_bottom)/2,Barrel)
            instance_create((_chest_floor.bbox_left+_chest_floor.bbox_right)/2,(_chest_floor.bbox_top+_chest_floor.bbox_bottom)/2,WeaponChest)
            var _large=instance_create((_large_floor.bbox_left+_large_floor.bbox_right)/2,(_large_floor.bbox_top+_large_floor.bbox_bottom)/2,Scorpion)
            assert(_large.size>1,"Heart chest large blocker is not a real native large enemy")
            if(_case==1) {
                var _f=_eligible[0],_small=instance_create((_f.bbox_left+_f.bbox_right)/2,(_f.bbox_top+_f.bbox_bottom)/2,Bandit)
                assert(_small.size<=1,"Heart chest small native enemy unexpectedly blocks source eligibility")
            }
            var _o=global.ntte_crystal_chest_probe
            _o.scenario=_config.name;_o.host=_host;_o.eligible_count=_config.count;_o.two_chests=_config.chests==2
            _o.require_distinct=_config.distinct;_o.old_floor=_old_floor;_o.child_floor=_child
            _o.excluded=_excluded;_o.rows=[];_o.active=undefined
            // This is deterministic setup metadata, not proof of complete
            // ordinary RNG stream position or restoration.
            random_set_seed(713207+_case);_o.measuring=true
            with(_host) scrNTTEFullCrystalHeartChestExtracted(_generation)
            _o.measuring=false
            assert(array_length(_o.rows)==_config.chests && is_undefined(_o.active),"Heart chest source outer count changed")
            for(var _i=0;_i<array_length(_o.rows);++_i)
                assert(instance_exists(_o.rows[_i].actor),"Heart chest constructor result vanished before branch completion")
            assert(instance_exists(_old_floor) && instance_exists(_child),"Heart chest touched excluded old/child terrain")
            scrNTTESmokeLog("CRYSTAL HEART CHEST controlled branch PASS "+_config.name+" @"+string(30/timescale)
                +" eligible="+string(_config.count)+" native_chests="+string(array_length(_o.rows)))
            scrNTTEFullCrystalChestDeleteSince(_start);ds_list_clear(_walls_list)
        }
    }
    finally {
        if(variable_global_exists("ntte_crystal_chest_probe") && is_struct(global.ntte_crystal_chest_probe))
            global.ntte_crystal_chest_probe.measuring=false
        scrNTTEFullCrystalChestDeleteSince(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        var _current_names=variable_struct_get_names(global)
        for(var _i=0;_i<array_length(_current_names);++_i)
            if(array_get_index(_original_names,_current_names[_i])<0) variable_struct_remove(global,_current_names[_i])
        for(var _i=0;_i<array_length(_global_vars);++_i) variable_global_set(_global_vars[_i][0],_global_vars[_i][1])
        scrNTTEFullAreaGeneratorRestore(_players);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        if(ds_exists(_fixture_map,ds_type_map)) ds_map_destroy(_fixture_map)
        if(ds_exists(_walls_list,ds_type_list)) ds_list_destroy(_walls_list)
        game_directory=_directory;random_set_seed(_seed)
        var _files=["ntte-full-progress.json","ntte-full-progress.json.bak","ntte-full-progress.json.tmp","NuclearThrone.sav"]
        for(var _i=0;_i<array_length(_files);++_i) if(file_exists(_scratch+_files[_i])) file_delete(_scratch+_files[_i])
        if(directory_exists(_scratch)) directory_destroy(_scratch)
        assert(UberCont.saveData==_old_map && ds_map_write(_old_map)==_old_savedata,"Heart chest fixture altered original save/options")
    }
    scrNTTESmokeLog("CRYSTAL HEART CHEST exact extracted branch PASS: first actual shuffled eligible, one native chest, single/fallback/furthest/two occupied tiles, wall/prop/chest/large enemy and old-generation/non-normal exclusions @"+string(30/timescale))
}
