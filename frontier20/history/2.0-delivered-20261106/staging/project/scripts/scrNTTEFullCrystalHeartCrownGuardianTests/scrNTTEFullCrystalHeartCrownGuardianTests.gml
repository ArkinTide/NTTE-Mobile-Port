// Controlled exact-code-branch regression. This is not a natural unfolding.
// Only setup/teardown creates terrain/props. Both production and constructor
// probes below read live state and write records; they never repair actors.
function scrNTTEFullCrystalCrownShuffled(_floor,_generation) {
    var _o=global.ntte_crystal_crown_probe,_eligible=[]
    assert(_o.measuring && is_undefined(_o.active),"Crown QA began with an unsealed predecessor")
    var _crown=id
    for(var _i=0;_i<array_length(_floor);++_i) with(_floor[_i]) {
        assert(object_index==Floor && real(id)>real(_generation),"Crown shuffle included old-generation/non-normal floor")
        var _cx=(bbox_left+bbox_right)/2,_cy=(bbox_top+bbox_bottom)/2
        if(point_distance(_cx,_cy,_crown.x,_crown.y)<96 && place_free(x,y))
            array_push(_eligible,{tile:id,x:_cx,y:_cy})
    }
    assert(array_length(_eligible)==_o.expected_eligible,"Controlled Crown QA eligibility changed: "+string(_eligible))
    _o.active={crown:id,eligible:_eligible,shuffled:_floor,created:[],
        after_seed:random_get_seed(),after_rng:scrNTTEFullArrayCopy(global.rng_state)}
}
function scrNTTEFullCrystalCrownCreateProbe(_side) {
    var _o=global.ntte_crystal_crown_probe,_a=_o.active
    assert(is_struct(_a),"Guardian constructor outside an observed crown branch")
    if(_side=="before") {
        var _n=array_length(_a.created)
        scrNTTESmokeLog("CRYSTAL CROWN CREATE before "+json_stringify({scenario:_o.scenario,rate:30/timescale,
            crown:_a.crown,index:_n,eligible:array_length(_a.eligible),x:x,y:y,seed:random_get_seed(),rng:global.rng_state}))
        assert(_n<min(2,array_length(_a.eligible)),"SOURCE CROWN LIMIT: more than two CrownGuardians for one CrownPickup")
        assert(x==_a.eligible[_n].x && y==_a.eligible[_n].y,"Crown creation lost shuffled eligible prefix/center/strict96/place_free")
        assert(random_get_seed()==_a.after_seed && json_stringify(global.rng_state)==json_stringify(_a.after_rng),
            "Crown QA added RNG between shuffle/constructors")
        array_push(_a.created,{actor:id,x:x,y:y,before_rng:scrNTTEFullArrayCopy(global.rng_state),done:false})
    }
    else {
        var _n=array_length(_a.created),_record=_a.created[_n-1]
        assert(_n>0 && _record.actor==id && !_record.done,"Guardian constructor pair mismatch")
        assert(object_index==CrownGuardian && hp>0 && max_hp<=70 && max_hp>0
            && size==3 && alarm[1]>=40 && alarm[1]<50,"Fixture did not use intact native CrownGuardian constructor")
        for(var _i=0;_i<array_length(global.rng_state);++_i) {
            var _expected=_record.before_rng[_i]
            if(_i==RNGStates.WeaponDrops) _expected=(rng_a*_expected+rng_c)%rng_m
            assert(global.rng_state[_i]==_expected,"Native CrownGuardian consumed unexpected named RNG stream")
        }
        _record.done=true;_a.after_seed=random_get_seed();_a.after_rng=scrNTTEFullArrayCopy(global.rng_state)
    }
}
function scrNTTEFullCrystalCrownSealed() {
    var _o=global.ntte_crystal_crown_probe,_a=_o.active
    assert(is_struct(_a) && _a.crown==id,"Crown QA seal lost receiver")
    assert(array_length(_a.created)==min(2,array_length(_a.eligible)),"Crown QA under/over-generated its eligible cap")
    for(var _i=0;_i<array_length(_a.created);++_i)
        assert(_a.created[_i].done && instance_exists(_a.created[_i].actor),"Native guardian disappeared during synchronous QA")
    assert(random_get_seed()==_a.after_seed && json_stringify(global.rng_state)==json_stringify(_a.after_rng),
        "Crown QA consumed RNG after its last permitted constructor")
    array_push(_o.rows,_a);_o.active=undefined
}
function scrNTTEFullCrystalCrownDeleteSince(_before) {
    var _all=scrNTTEFullInstances(all)
    for(var _i=array_length(_all)-1;_i>=0;--_i)
        if(array_get_index(_before,_all[_i])<0 && instance_exists(_all[_i])) instance_destroy(_all[_i],false)
}
function scrNTTEFullCrystalHeartCrownGuardianTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled(),"Crown QA controlled branch requires desktop full smoke")
    assert(timescale==1 || timescale==0.5,"Crown QA fixture requires actual30/60 smoke rate")
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_seed=random_get_seed(),_global_vars=[],_graph={nodes:[]},
        _hidden=scrNTTEFullInstances([Floor,Wall,enemy,prop,CrownPickup,CrownPed,PizzaEntrance,FloorMaker,Menu,MenuGen]),
        _old_map=UberCont.saveData,_old_savedata=ds_map_write(UberCont.saveData),_original_names=variable_struct_get_names(global)
    for(var _i=0;_i<array_length(_original_names);++_i) {
        var _name=_original_names[_i],_value=variable_global_get(_name)
        array_push(_global_vars,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
    }
    for(var _i=0;_i<array_length(_hidden);++_i) instance_deactivate_object(_hidden[_i])
    var _walls_list=ds_list_create()
    try {
        global.lis_walls_visible=_walls_list
        GameCont.area=area_sewers;GameCont.subarea=2;GameCont.loops=0;GameCont.hard=2
        GameCont.crown=crwn_none;GameCont.crownvisits=0;UberCont.hardmode=false
        global.ntte_crystal_crown_probe={measuring:false,active:undefined,rows:[],scenario:"",expected_eligible:0}
        // Baseline first reaches the >2 assertion rather than a degenerate row.
        var _cases=[{name:"eight",count:8,crowns:1,subarea:0},{name:"two-crowns",count:8,crowns:2,subarea:0},
            {name:"none-eligible",count:0,crowns:1,subarea:0},{name:"one",count:1,crowns:1,subarea:0},
            {name:"two",count:2,crowns:1,subarea:0},{name:"no-crown",count:0,crowns:0,subarea:0},
            {name:"nonzero-subarea",count:8,crowns:1,subarea:1}]
        for(var _case=0;_case<array_length(_cases);++_case) {
            var _config=_cases[_case],_start=scrNTTEFullInstances(all),_cx=96000,_cy=96000,
                _old_crown=instance_create(_cx+2048,_cy,CrownPickup),
                _old_ped=scrNTTEFullInstances(CrownPed),_old_pizza=instance_create(_cx+2304,_cy,PizzaEntrance),
                _old_floor=instance_create(_cx-16,_cy-16,Floor),_generation=instance_create(_cx+3072,_cy,NTTEDesertDecor),
                _host=instance_create(_cx+3072,_cy+32,NTTEDesertDecor),_crowns=[],_peds=[],_children=[],_outside=[],_blocked=[],
                _new_pizza=instance_create(_cx+2560,_cy,PizzaEntrance)
            _host.subarea=_config.subarea
            for(var _c=0;_c<_config.crowns;++_c) array_push(_crowns,instance_create(_cx+_c*512,_cy,CrownPickup))
            var _emitted=scrNTTEFullCrystalHeartNewInstances(Floor,_generation,true)
            for(var _i=0;_i<array_length(_emitted);++_i) instance_destroy(_emitted[_i],false)
            _peds=scrNTTEFullCrystalHeartNewInstances(CrownPed,_generation)
            for(var _c=0;_c<array_length(_crowns);++_c) {
                var _x=_crowns[_c].x,_y=_crowns[_c].y,_walls_before=scrNTTEFullInstances(Wall),
                    _child=instance_create(_x,_y,FloorExplo)
                array_push(_children,_child)
                // Controlled terrain setup removes child-created Walls before
                // installing the explicit blocked tile. The oracle does not.
                var _walls=scrNTTEFullCrystalHeartNewInstances(Wall,_generation)
                for(var _i=0;_i<array_length(_walls);++_i)
                    if(array_get_index(_walls_before,_walls[_i])<0) instance_destroy(_walls[_i],false)
                var _sites=[[-64,-32],[-32,-64],[32,-64],[64,-32],[64,32],[32,64],[-32,64],[-64,32]]
                for(var _i=0;_i<_config.count;++_i) {
                    var _f=instance_create(_x+_sites[_i][0]-16,_y+_sites[_i][1]-16,Floor)
                    assert(instance_exists(_f),"Controlled normal eligible floor was lost during native Create")
                }
                array_push(_outside,instance_create(_x+80,_y-16,Floor)) // center exactly96: rejected
                array_push(_outside,instance_create(_x+112,_y-16,Floor)) // center128: rejected
                var _block=instance_create(_x-16,_y-64,Floor)
                array_push(_blocked,_block);instance_create(_block.x,_block.y,Wall)
                assert(instance_exists(_child) && instance_exists(_block),"Controlled excluded child/blocked terrain missing")
            }
            var _o=global.ntte_crystal_crown_probe
            _o.scenario=_config.name;_o.expected_eligible=_config.count;_o.rows=[];_o.active=undefined
            random_set_seed(701932+_case);var _entry_seed=random_get_seed(),_entry_rng=json_stringify(global.rng_state)
            _o.measuring=true
            with(_host) scrNTTEFullCrystalHeartCrownGuardianExtracted(_generation)
            _o.measuring=false
            var _expected_crowns=_config.subarea==0?_config.crowns:0
            assert(array_length(_o.rows)==_expected_crowns && is_undefined(_o.active),"Crown QA skipped/duplicated a source crown")
            assert(instance_number(CrownGuardian)==_expected_crowns*min(2,_config.count),"Global guardian count exceeded per-crown cap")
            assert(instance_exists(_old_crown) && instance_exists(_old_pizza) && instance_exists(_old_floor),
                "Crown QA touched an old-generation crown/pizza/floor")
            for(var _i=0;_i<array_length(_old_ped);++_i) assert(instance_exists(_old_ped[_i]),"Crown QA removed old pedestal")
            for(var _i=0;_i<array_length(_crowns);++_i)
                assert(instance_exists(_crowns[_i])==(_config.subarea!=0),"Crown QA changed subarea guard/pickup removal")
            for(var _i=0;_i<array_length(_peds);++_i)
                assert(instance_exists(_peds[_i])==(_config.subarea!=0),"Crown QA changed pedestal cleanup guard")
            assert(instance_exists(_new_pizza)==(_config.subarea!=0),"Crown QA changed PizzaEntrance cleanup guard")
            for(var _i=0;_i<array_length(_children);++_i) assert(instance_exists(_children[_i]),"Crown QA removed child floor")
            for(var _i=0;_i<array_length(_outside);++_i) assert(instance_exists(_outside[_i]),"Crown QA removed outside floor")
            for(var _i=0;_i<array_length(_blocked);++_i) assert(instance_exists(_blocked[_i]),"Crown QA removed blocked floor")
            if(_expected_crowns==0) assert(random_get_seed()==_entry_seed && json_stringify(global.rng_state)==_entry_rng,
                "No-crown/nonzero-subarea QA consumed RNG")
            else {
                var _last=_o.rows[array_length(_o.rows)-1]
                assert(random_get_seed()==_last.after_seed && json_stringify(global.rng_state)==json_stringify(_last.after_rng),
                    "QA cleanup added RNG after the last permitted constructor/shuffle")
            }
            scrNTTESmokeLog("CRYSTAL CROWN controlled branch PASS "+_config.name+" @"+string(30/timescale)+
                " crowns="+string(_expected_crowns)+" eligible="+string(_config.count)+" guardians="+string(instance_number(CrownGuardian)))
            scrNTTEFullCrystalCrownDeleteSince(_start)
            ds_list_clear(_walls_list)
        }
    }
    finally {
        if(variable_global_exists("ntte_crystal_crown_probe") && is_struct(global.ntte_crystal_crown_probe))
            global.ntte_crystal_crown_probe.measuring=false
        scrNTTEFullCrystalCrownDeleteSince(_before)
        for(var _i=0;_i<array_length(_hidden);++_i) instance_activate_object(_hidden[_i])
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        var _current_names=variable_struct_get_names(global)
        for(var _i=0;_i<array_length(_current_names);++_i)
            if(array_get_index(_original_names,_current_names[_i])<0) variable_struct_remove(global,_current_names[_i])
        for(var _i=0;_i<array_length(_global_vars);++_i) variable_global_set(_global_vars[_i][0],_global_vars[_i][1])
        scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_uber)
        if(ds_exists(_walls_list,ds_type_list)) ds_list_destroy(_walls_list)
        random_set_seed(_seed)
        assert(UberCont.saveData==_old_map && ds_map_write(_old_map)==_old_savedata,"Crown QA changed original save/options")
    }
    scrNTTESmokeLog("CRYSTAL CROWN exact controlled branch: 0/1/2/8 eligible, two crowns, strict96/solid/normal/generation/subarea, native constructors and RNG continuity/restoration OK @"+string(30/timescale))
}
