// telib.area_generate:2811..3172. Synchronous real GenCont generation, original
// floor-overlap reconciliation, and restoration of the old in-room world.
// Custom areas are registered only with their complete actual floor/population
// callbacks. Missing areas fail before deactivating or mutating the old world.
function scrNTTEFullAreaGeneratorRegister(_area,_make_floor,_populate,_start=undefined,_setup=undefined) {
    if (!is_callable(_make_floor) || !is_callable(_populate)) throw "Area generator requires real floor and population callbacks"
    if (is_string(_area)) _area=scrNTTEFullAreaId(_area)
    if (!variable_global_exists("ntte_full_area_generators")) global.ntte_full_area_generators={}
    variable_struct_set(global.ntte_full_area_generators,string(_area),{
        make_floor:_make_floor,populate:_populate,start:_start,setup:_setup})
}

// Register the complete owned area callbacks. Native GenCont remains the
// authority for finalization/player spawn, including same-room drain builds.
function scrNTTEFullAreaNativeInit() {
    scrNTTEFullAreaGeneratorRegister("red",scrNTTEFullRedBuildNative,scrNTTEFullRedPopulateNative,
        scrNTTEFullRedStart,scrNTTEFullRedSetupNative)
    scrNTTEFullAreaGeneratorRegister("coast",scrNTTEFullCoastBuildNative,scrNTTEFullCoastPopulateNative,
        scrNTTEFullCoastStart,scrNTTEFullCoastSetupNative)

    scrNTTEFullAreaGeneratorRegister("pizza",scrNTTEFullPizzaBuildNative,scrNTTEFullPizzaPopulateNative,
        scrNTTEFullPizzaStart,scrNTTEFullPizzaSetupNative)

    scrNTTEFullAreaGeneratorRegister("oasis",scrNTTEFullOasisBuildNative,scrNTTEFullOasisPopulateNative,
        scrNTTEFullOasisStart,scrNTTEFullOasisSetupNative)

    global.ntte_full_area_generate=scrNTTEFullAreaGenerateNative
    scrNTTEFullAreaGeneratorRegister("lair",scrNTTEFullLairBuildNative,scrNTTEFullLairPopulateNative,
        scrNTTEFullLairStartNative,scrNTTEFullLairSetupNative)
    scrNTTEFullAreaGeneratorRegister("trench",scrNTTEFullTrenchBuildNative,scrNTTEFullTrenchPopulateNative,
        scrNTTEFullTrenchStart,scrNTTEFullTrenchSetupNative)
}

function scrNTTEFullAreaNativeBuilder(_area) {
    if (!variable_global_exists("ntte_full_area_generators")) scrNTTEFullAreaNativeInit()
    return scrNTTEFullValue(global.ntte_full_area_generators,string(_area),undefined)
}

function scrNTTEFullAreaDarknessNative() {
    with (BackCont) shadow_color=scrAreaGetShadowColor(GameCont.area)
    with (TopCont) {
        darkness=true
        if (!surface_exists(dark)) {
            dark=surface_create(view_width,view_height)
            surface_set_target(dark); draw_clear(c_white); surface_reset_target()
        }
    }
}

function scrNTTEFullLairSetupNative() {
    goal=100; safespawn=0
    background_set_colour(scrAreaGetBackroundColor(GameCont.area))
    scrNTTEFullAreaDarknessNative()
}

function scrNTTEFullTrenchSetupNative() {
    goal=150; safespawn+=2
    background_set_colour(scrAreaGetBackroundColor(GameCont.area))
    scrNTTEFullAreaDarknessNative()
    GameCont.underwater=true
}

function scrNTTEFullLairBuildNative() {
    instance_destroy(FloorMaker,false)
    // The native FloorMaker create event creates a starter tile. The source
    // lair removes it and owns its entire room topology.
    instance_destroy(Floor,false)
    var _rooms=scrNTTEFullLairPlan(goal)
    scrNTTEFullLairBuildRooms(_rooms)
}

function scrNTTEFullTrenchBuildNative() {
    instance_destroy(FloorMaker,false)
    with (instance_create(10000,10000,FloorMaker)) goal=other.goal
    var _tries=400,_last=instance_number(Floor)
    while(instance_exists(FloorMaker) && _tries-->0) {
        with (FloorMaker) {
            xprevious=x; yprevious=y
            if (instance_number(Floor)>goal) {
                if (point_distance(x,y,10016,10016)>48) {
                    instance_create(x,y,Floor); instance_create(x+16,y+16,RadChest)
                }
                instance_destroy()
            }
            else {
                x+=lengthdir_x(32,direction); y+=lengthdir_y(32,direction)
                scrNTTEFullTrenchMakeFloor()
            }
        }
        if (instance_number(Floor)>_last) { _last=instance_number(Floor); _tries=400 }
    }
    if (instance_exists(FloorMaker)) throw "Trench source generator did not converge"
}

function scrNTTEFullLairPopulateNative() {
    scrPopulate()
    scrNTTEFullLairPopExtras()
}

function scrNTTEFullTrenchPopulateNative() {
    scrPopulate()
    scrNTTEFullTrenchPopExtras()
}

function scrNTTEFullLairStartNative() {
    GameCont.ntte_full_active_lair=true
    // Match the source's one spawn-wall clean-up; do not clear the whole map.
    var _wall=instance_find(Wall,0)
    if (instance_exists(_wall)) with (_wall) {
        if (place_meeting(x,y,Floor) && abs(point_distance(10016,10016,x,y)-48)<12) instance_destroy()
    }
}

// Save collection contents separately from their original references. A plain
// clone would break aliases/weapon-state identities, and shallow snapshots leak
// mutations with this project's disabled array copy-on-write setting. DS handles
// and methods are opaque values; callers must not destroy those during a scope.
function scrNTTEFullAreaSnapshotContainer(_value,_graph) {
    var _array=is_array(_value)
    if(!_array && (!is_struct(_value) || is_method(_value))) return
    for(var _i=0;_i<array_length(_graph.nodes);++_i) {
        var _node=_graph.nodes[_i]
        if(_node.array==_array && _node.ref==_value) return
    }
    var _node={ref:_value,array:_array,entries:[]}
    // Register first so cycles and aliases are visited exactly once.
    array_push(_graph.nodes,_node)
    if(_array) {
        for(var _i=0;_i<array_length(_value);++_i) {
            var _entry=_value[_i]
            array_push(_node.entries,_entry)
            scrNTTEFullAreaSnapshotContainer(_entry,_graph)
        }
    }
    else {
        var _keys=variable_struct_get_names(_value)
        for(var _i=0;_i<array_length(_keys);++_i) {
            var _key=_keys[_i],_entry=variable_struct_get(_value,_key)
            array_push(_node.entries,[_key,_entry])
            scrNTTEFullAreaSnapshotContainer(_entry,_graph)
        }
    }
}

function scrNTTEFullAreaGeneratorSnapshot(_object) {
    var _out=[],_instances=scrNTTEFullInstances(_object),_graph={nodes:[]}
    for(var _i=0;_i<array_length(_instances);++_i) {
        var _v=_instances[_i],_names=variable_instance_get_names(_v),_vars=[]
        for(var _j=0;_j<array_length(_names);++_j) {
            var _name=_names[_j]
            var _value=variable_instance_get(_v,_name)
            array_push(_vars,[_name,_value])
            scrNTTEFullAreaSnapshotContainer(_value,_graph)
        }
        array_push(_out,{instance:_v,vars:_vars,x:_v.x,y:_v.y,xprevious:_v.xprevious,yprevious:_v.yprevious,
            xstart:_v.xstart,ystart:_v.ystart,visible:_v.visible,mask_index:_v.mask_index,
            speed:_v.speed,direction:_v.direction,image_angle:_v.image_angle,image_index:_v.image_index})
    }
    return {instances:_out,containers:_graph.nodes}
}

function scrNTTEFullAreaGeneratorRestore(_snapshot) {
    var _snapshots=_snapshot.instances,_nodes=_snapshot.containers
    for(var _i=0;_i<array_length(_nodes);++_i) {
        var _node=_nodes[_i],_ref=_node.ref,_entries=_node.entries
        if(_node.array) {
            array_resize(_ref,array_length(_entries))
            for(var _j=0;_j<array_length(_entries);++_j) _ref[_j]=_entries[_j]
        }
        else {
            var _keys=variable_struct_get_names(_ref),_saved=[]
            for(var _j=0;_j<array_length(_entries);++_j) array_push(_saved,_entries[_j][0])
            for(var _j=0;_j<array_length(_keys);++_j)
                if(array_get_index(_saved,_keys[_j])<0) variable_struct_remove(_ref,_keys[_j])
            for(var _j=0;_j<array_length(_entries);++_j)
                variable_struct_set(_ref,_entries[_j][0],_entries[_j][1])
        }
    }
    for(var _i=0;_i<array_length(_snapshots);++_i) {
        var _s=_snapshots[_i],_v=_s.instance
        if (!instance_exists(_v)) continue
        for(var _j=0;_j<array_length(_s.vars);++_j) variable_instance_set(_v,_s.vars[_j][0],_s.vars[_j][1])
        with (_v) {
            x=_s.x; y=_s.y; xprevious=_s.xprevious; yprevious=_s.yprevious; xstart=_s.xstart; ystart=_s.ystart
            visible=_s.visible; mask_index=_s.mask_index; speed=_s.speed; direction=_s.direction
            image_angle=_s.image_angle; image_index=_s.image_index
        }
    }
}

function scrNTTEFullAreaSnapshotUnitTests() {
    var _fixture=instance_create(43216,43216,NTTEDesertDecor)
    var _nested=[20,30],_ammo=[10,_nested],_pet={hp:12},_state={ammo:_ammo,pet:_pet}
    _state.cycle=_state
    _fixture.ntte_state=_state;_fixture.ntte_alias=_state;_fixture.ntte_ammo=_ammo
    var _snapshot=scrNTTEFullAreaGeneratorSnapshot(_fixture)
    _ammo[0]=99;array_push(_ammo,40);array_resize(_nested,1);_nested[0]=88
    _pet.hp=1;_pet.added=true;_state.pet={hp:0};_state.cycle=undefined
    _fixture.ntte_state={replacement:true};_fixture.ntte_alias=undefined
    scrNTTEFullAreaGeneratorRestore(_snapshot)
    assert(_fixture.ntte_state==_state && _fixture.ntte_alias==_state && _state.cycle==_state
        && _state.pet==_pet && _pet.hp==12 && !variable_struct_exists(_pet,"added"),
        "Area snapshot lost struct identity, alias/cycle or nested original contents")
    assert(_fixture.ntte_ammo==_ammo && _state.ammo==_ammo && array_length(_ammo)==2 && _ammo[0]==10
        && _ammo[1]==_nested && array_length(_nested)==2 && _nested[0]==20 && _nested[1]==30,
        "Area snapshot failed in-place nested array values, lengths or reference identities")
    instance_destroy(_fixture,false)
    scrNTTESmokeLog("FULL AREA SNAPSHOT: nested arrays/structs restored in place with aliases, cycles, lengths and original identities OK @"+string(30/timescale))
}

function scrNTTEFullAreaGenerateNative(_area,_subarea,_loops,_x,_y,_set_area=true,_overlap_floor=0,_setup=undefined) {
    if (instance_exists(GenCont)) throw "Cannot nest synchronous area generation inside active GenCont"
    if (is_string(_area)) _area=scrNTTEFullAreaId(_area)
    var _builder=undefined
    if (variable_global_exists("ntte_full_area_generators")) _builder=scrNTTEFullValue(global.ntte_full_area_generators,string(_area),undefined)
    if (_area>=201 && _area<=206 && !is_struct(_builder)) throw "NTTE custom area generator is not integrated: "+string(_area)
    // `background_color` is an NTTE global; map it to the native area colour
    // while preserving the value across the temporary generator transition.
    var _last_area=GameCont.area,_last_subarea=GameCont.subarea,_last_loops=GameCont.loops,_background=scrAreaGetBackroundColor(GameCont.area)
    var _last_maxsubarea=GameCont.maxsubarea,_last_finalsubarea=GameCont.finalsubarea
    var _viewx=view_xview,_viewy=view_yview,_underwater=GameCont.underwater
    var _render_camera=view_camera[0],_render_camera_x=camera_get_view_x(view_camera[0]),
        _render_camera_y=camera_get_view_y(view_camera[0]),_letterbox=UberCont.letterbox,_letterbox_frame=UberCont.letterbox_frame
    var _all_before=scrNTTEFullInstances(all),_old_controllers=scrNTTEFullInstances([BackCont,TopCont,SubTopCont])
    var _old_mobile=scrNTTEFullInstances([ButtonAct,ButtonActive,ButtonSwap,ButtonAttack,JoystickMove,JoystickAttack])
    var _old_game=scrNTTEFullNativeGameObjects(),_deactivated=[],_solid=[],_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _overlap_boxes=[],_overlap_fill=[],_old_floors=scrNTTEFullInstances(Floor,true),_count=array_length(_old_floors)*(1-_overlap_floor)
    _old_floors=array_shuffle(_old_floors)
    for(var _i=0;_i<array_length(_old_floors) && _count-->0;++_i) {
        var _f=_old_floors[_i]
        array_push(_overlap_boxes,[_f.bbox_left,_f.bbox_top,_f.bbox_right-1,_f.bbox_bottom-1])
    }
    var _near=scrNTTEFullWorldNearestRectBBox(_x,_y,_x,_y,Floor)
    if (instance_exists(_near)) { _x=_near.x+floor((_x-_near.x)/16)*16; _y=_near.y+floor((_y-_near.y)/16)*16 }
    var _ox=_x-10016,_oy=_y-10016,_generation=noone,_completed=false
    var _old_sync=variable_global_exists("ntte_full_sync_generation") ? global.ntte_full_sync_generation:false
    // Mobile GenCont uses live players for race/chest setup. Snapshot and
    // restore them around the synchronous operation; old terrain/enemies are
    // deactivated exactly as in NTT and cannot participate in generation.
    for(var _i=0;_i<array_length(_old_game);++_i) {
        var _v=_old_game[_i]
        if (_v.solid) { _v.solid=false; array_push(_solid,_v) }
        if (_v!=id && !instance_is(_v,Player) && array_get_index(_deactivated,_v)<0) {
            instance_deactivate_object(_v); array_push(_deactivated,_v)
        }
    }
    for(var _i=0;_i<array_length(_old_controllers);++_i) {
        var _v=_old_controllers[_i]
        if (array_get_index(_deactivated,_v)<0) { instance_deactivate_object(_v); array_push(_deactivated,_v) }
    }
    try {
        GameCont.area=_area; GameCont.subarea=_subarea; GameCont.loops=_loops
        GameCont.maxsubarea=scrAreaGetMaxSubarea(_area); GameCont.finalsubarea=(_subarea==GameCont.maxsubarea)
        GameCont.underwater=(_area==area_oasis || _area==scrNTTEFullAreaId("trench") || _area==scrNTTEFullAreaId("oasis"))
        // Normal GenCont runs these same real builders from its native event
        // chain. The synchronous driver owns its callback sequence explicitly.
        global.ntte_full_sync_generation=true
        _generation=instance_create(0,0,GenCont)
        // Source setArea is independent of sync: false appends a submap only.
        // Store before setup/alarms; global sync is restored before Destroy.
        _generation.ntte_full_set_area=_set_area
        global.ntte_full_sync_generation=_old_sync
        if (!instance_exists(BackCont)) instance_create(0,0,BackCont)
        if (_set_area) with (MusCont) alarm[3]=-1
        var _spirals=scrNTTEFullInstances([SpiralCont,Spiral,SpiralStar,SpiralDebris])
        for(var _i=0;_i<array_length(_spirals);++_i) instance_destroy(_spirals[_i])
        // Real GenCont.Create already prepared the custom area before event setup.
        if (is_callable(_setup)) { var _callback=method(_generation,_setup); _callback() }
        if (is_struct(_builder)) {
            // Red retains the original maker edited by CrystalHeart setup.
            if(_area!=scrNTTEFullAreaId("red")) instance_destroy(FloorMaker,false)
            // Custom make_floor owns the complete source topology, including
            // the Lair's20templates rather than a vanilla FloorMaker fallback.
            var _callback=method(_generation,_builder.make_floor); _callback()
        }
        else {
            var _tries=100,_floor_number=0
            while (instance_exists(FloorMaker) && _tries-->0) {
                with (FloorMaker) { xprevious=x; yprevious=y; event_perform(ev_step,ev_step_normal) }
                if (instance_number(Floor)>_floor_number) { _floor_number=instance_number(Floor); _tries=300 }
            }
            instance_destroy(FloorMaker,false)
        }
        // Real vanilla safe-spawn/vault/crib preparation is independent of
        // destination population and executes before overlap exclusion.
        with (_generation) event_perform(ev_alarm,2)
        for(var _i=0;_i<array_length(_overlap_boxes);++_i) {
            var _b=_overlap_boxes[_i],_floors=scrNTTEFullRectInstances(_b[0]-_ox,_b[1]-_oy,_b[2]-_ox,_b[3]-_oy,Floor)
            for(var _j=0;_j<array_length(_floors);++_j) if (instance_exists(_floors[_j])) with (_floors[_j]) {
                array_push(_overlap_fill,[bbox_left+_ox,bbox_top+_oy,bbox_right-1+_ox,bbox_bottom-1+_oy])
                var _snow=scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,SnowFloor)
                for(var _k=0;_k<array_length(_snow);++_k) instance_destroy(_snow[_k])
                instance_destroy()
            }
            var _chests=scrNTTEFullRectInstances(_b[0]-_ox,_b[1]-_oy,_b[2]-_ox,_b[3]-_oy,[chestprop,RadChest])
            for(var _j=0;_j<array_length(_chests);++_j) instance_destroy(_chests[_j],false)
        }
        if (is_struct(_builder)) {
            with (Floor) scrNTTEFullFloorWalls(id)
            var _callback=method(_generation,_builder.populate); _callback()
            with (Floor) { instance_create(x-16,y-16,Top); instance_create(x-16,y,Top); instance_create(x,y-16,Top); instance_create(x,y,Top) }
        }
        else with (_generation) event_perform(ev_alarm,0)
        if (!_set_area) { instance_destroy(WantPopo,false); instance_destroy(WantVan,false) }
        var _before_finalize=scrNTTEFullInstances(all)
        with (_generation) event_perform(ev_alarm,1)
        var _after_finalize=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_after_finalize);++_i) if (array_get_index(_before_finalize,_after_finalize[_i])<0
            && instance_is(_after_finalize[_i],PortalClear)) { instance_destroy(_after_finalize[_i],false); break }
        // area_start spawns origin-relative actors such as the third Trench
        // PitSquid. Run it before translation so those actors move with the
        // generated level, exactly like native GenCont's finalization.
        if (_set_area && is_struct(_builder) && is_callable(_builder.start)) {
            var _callback=method(id,_builder.start); _callback()
        }
        var _generated=scrNTTEFullInstances(all)
        for(var _i=0;_i<array_length(_generated);++_i) {
            var _v=_generated[_i]
            if (array_get_index(_all_before,_v)>=0 || (_v.x==0 && _v.y==0)) continue
            _v.x+=_ox; _v.y+=_oy; _v.xprevious+=_ox; _v.yprevious+=_oy; _v.xstart+=_ox; _v.ystart+=_oy
            // Own delayed hitbox anchors and initial positions are explicit
            // fields; creators referenced by id need no relinking.
        }
        // GenCont.Destroy creates fresh mobile controls. Existing controls are
        // retained for this in-room operation; duplicate UI is never published.
        var _mobile=scrNTTEFullInstances([ButtonAct,ButtonActive,ButtonSwap,ButtonAttack,JoystickMove,JoystickAttack])
        for(var _i=0;_i<array_length(_mobile);++_i) if (array_get_index(_old_mobile,_mobile[_i])<0) instance_destroy(_mobile[_i],false)
        _completed=true
    }
    finally {
        global.ntte_full_sync_generation=_old_sync
        for(var _i=0;_i<array_length(_deactivated);++_i) instance_activate_object(_deactivated[_i])
        for(var _i=0;_i<array_length(_solid);++_i) if (instance_exists(_solid[_i])) _solid[_i].solid=true
        scrNTTEFullAreaGeneratorRestore(_players)
        if (!_completed || !_set_area) {
            GameCont.area=_last_area; GameCont.subarea=_last_subarea; GameCont.loops=_last_loops
            GameCont.maxsubarea=_last_maxsubarea; GameCont.finalsubarea=_last_finalsubarea
            GameCont.underwater=_underwater
            background_set_colour(_background)
        }
        if (!_completed) {
            var _failed=scrNTTEFullInstances(all)
            for(var _i=0;_i<array_length(_failed);++_i) if (array_get_index(_all_before,_failed[_i])<0) instance_destroy(_failed[_i],false)
        }
        // The synchronous scope owns no normal loading-screen lifetime.
        UberCont.letterbox=_letterbox;UberCont.letterbox_frame=_letterbox_frame
        view_xview=_viewx;view_yview=_viewy
        camera_set_view_pos(_render_camera,_render_camera_x,_render_camera_y)
        with(BackCont) {viewxf=_viewx;viewyf=_viewy}
    }
    // Keep the appropriate native camera/top controllers. Old controllers and
    // surfaces remain intact for setArea=false, then new controllers are freed.
    var _controllers=scrNTTEFullInstances([BackCont,TopCont,SubTopCont])
    for(var _i=0;_i<array_length(_controllers);++_i) {
        var _v=_controllers[_i],_old=array_get_index(_old_controllers,_v)>=0
        if (_old==_set_area) instance_destroy(_v,false)
    }
    // BEGIN NTTE INROOM OVERLAP SOURCE REPAIR V1
    // GenCont's failure-safe scope already restored the old area. Source telib
    // restores it only AFTER overlap/gap-fill; temporarily reinstate the target
    // context here, preserving both setArea=false and true return values.
    var _merge_context=[GameCont.area,GameCont.subarea,GameCont.loops,
        GameCont.maxsubarea,GameCont.finalsubarea,GameCont.underwater],
        _merge_background=__background_get_colour_element(),
        _merge_background_color=layer_background_get_blend(_merge_background[0])
    try {
        GameCont.area=_area;GameCont.subarea=_subarea;GameCont.loops=_loops
        GameCont.maxsubarea=scrAreaGetMaxSubarea(_area);GameCont.finalsubarea=_subarea==GameCont.maxsubarea
        GameCont.underwater=(_area==area_oasis || _area==scrNTTEFullAreaId("trench") || _area==scrNTTEFullAreaId("oasis"))
        background_set_colour(scrAreaGetBackroundColor(_area))
        var _overlap_objects=[Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]
        for(var _a=0;_a<array_length(_overlap_objects);++_a) {
            var _object=_overlap_objects[_a],_new=scrNTTEFullInstances(_object),_new_list=[],_old_list=[]
            for(var _i=0;_i<array_length(_new);++_i) {
                if (array_get_index(_all_before,_new[_i])>=0) array_push(_old_list,_new[_i])
                else array_push(_new_list,_new[_i])
            }
            var _lower=[]
            for(var _b=_a;_b<array_length(_overlap_objects);++_b) {
                var _part=scrNTTEFullInstances(_overlap_objects[_b])
                for(var _i=0;_i<array_length(_part);++_i) if (array_get_index(_all_before,_part[_i])>=0) array_push(_lower,_part[_i])
            }
            for(var _i=0;_i<array_length(_lower);++_i) if (instance_exists(_lower[_i])) with (_lower[_i]) {
                for(var _j=0;_j<array_length(_new_list);++_j) if (instance_exists(_new_list[_j]) && place_meeting(x,y,_new_list[_j])) {
                    if (object_index==Floor) array_push(_overlap_fill,[bbox_left,bbox_top,bbox_right-1,bbox_bottom-1])
                    instance_destroy(id,false); break
                }
            }
            for(var _b=_a+1;_b<array_length(_overlap_objects);++_b) {
                var _part=scrNTTEFullInstances(_overlap_objects[_b])
                for(var _i=0;_i<array_length(_part);++_i) if (array_get_index(_all_before,_part[_i])<0) with (_part[_i]) {
                    for(var _j=0;_j<array_length(_old_list);++_j) if (instance_exists(_old_list[_j]) && place_meeting(x,y,_old_list[_j])) { instance_destroy(id,false); break }
                }
            }
        }
        // telib3107..3112: old hitme may now meet a newly appended wall.
        // The source first excludes any surviving OLD wall by bounding boxes.
        // Keep its mask-copy PortalClear and deferred native collision semantics.
        var _old_walls=[],_merge_walls=scrNTTEFullInstances(Wall)
        for(var _i=0;_i<array_length(_merge_walls);++_i)
            if(array_get_index(_all_before,_merge_walls[_i])>=0) array_push(_old_walls,_merge_walls[_i])
        var _old_actors=scrNTTEFullInstances(hitme)
        for(var _i=0;_i<array_length(_old_actors);++_i)
            if(array_get_index(_all_before,_old_actors[_i])>=0 && instance_exists(_old_actors[_i]))
                with(_old_actors[_i]) {
                    if(place_meeting(x,y,Wall)
                        && !array_length(scrNTTEFullRectInstances(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,_old_walls)))
                        scrNTTEFullWorldWallClear(id)
                }
        // telib3114..3134: fill each removed 32px floor's missing 16px cells.
        for(var _i=0;_i<array_length(_overlap_fill);++_i) {
            var _b=_overlap_fill[_i]
            for(var _xx=_b[0];_xx<_b[2]+1;_xx+=16) for(var _yy=_b[1];_yy<_b[3]+1;_yy+=16)
                if(!position_meeting(_xx,_yy,Floor)) {
                    var _fill=instance_create(_xx,_yy,FloorExplo)
                    // instances_meeting_instance is a bbox query, not a precise
                    // collision query, and excludes its source instance.
                    var _covered=scrNTTEFullRectInstances(_fill.bbox_left,_fill.bbox_top,
                        _fill.bbox_right-1,_fill.bbox_bottom-1,_overlap_objects)
                    for(var _j=0;_j<array_length(_covered);++_j)
                        if(_covered[_j]!=_fill && instance_exists(_covered[_j])) instance_destroy(_covered[_j],false)
                }
        }
    }
    finally {
        GameCont.area=_merge_context[0];GameCont.subarea=_merge_context[1];GameCont.loops=_merge_context[2]
        GameCont.maxsubarea=_merge_context[3];GameCont.finalsubarea=_merge_context[4]
        GameCont.underwater=_merge_context[5]
        layer_background_blend(_merge_background[0],_merge_background_color)
    }
    // END NTTE INROOM OVERLAP SOURCE REPAIR V1
    return _generation
}

// Exercise the actual normal native Create -> Alarm2 -> Alarm0 -> Alarm1 ->
// Destroy chain. No sync generator bridge or test floor callbacks participate.
function scrNTTEFullNormalAreaLifecycleUnitTest(_key) {
    // The smoke driver's damage-source parent deliberately participates in
    // production area cleanup. Preserve the caller across that real cleanup
    // exactly as an in-room generator preserves its old world instances.
    var _harness=id
    instance_deactivate_object(_harness)
    var _game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _tutorial=save_get_value("game","tutorial",true),_sync=variable_global_exists("ntte_full_sync_generation") ? global.ntte_full_sync_generation:false
    save_set_value("game","tutorial",false)
    scrCleanupAreaInstances()
    with (TopCont) { if (surface_exists(dark)) surface_free(dark); instance_destroy(id,false) }
    instance_destroy(SubTopCont,false)
    if (!instance_exists(BackCont)) instance_create(0,0,BackCont)
    scrNTTEFullAreaNativeInit()
    GameCont.area=scrNTTEFullAreaId(_key); GameCont.subarea=(_key=="trench" ? 3:1); GameCont.loops=0
    GameCont.hard=9; GameCont.crown=Crown.None; GameCont.noradch=0
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area); GameCont.finalsubarea=true
    global.ntte_full_sync_generation=false
    var _generation=instance_create(0,0,GenCont)
    assert(instance_exists(_generation) && !_generation.ntte_full_sync_generation,
        "Normal custom area silently used synchronous/test generation")
    assert(_generation.goal==(_key=="trench" ? 150:100) && !instance_exists(FloorMaker),
        "Actual GenCont Create did not install source area setup/floor builder")
    assert(instance_number(Floor)>20,"Actual GenCont produced no complete custom topology")
    with (_generation) event_perform(ev_alarm,2)
    with (_generation) event_perform(ev_alarm,0)
    assert(instance_number(enemy)>0,"Actual GenCont Alarm0 did not populate custom enemies")
    // Native Top is a creation-only factory that emits four TopSmall tiles
    // and destroys itself in Create. Verify its persistent render products.
    assert(instance_number(TopSmall)>0,"Actual GenCont Alarm0 did not finalize custom terrain tops")
    if (_key=="lair") {
        assert(array_length(GameCont.ntte_full_lair_rooms)>=6 && instance_number(NTTEFullCatHoleBig)==1
            && instance_number(NTTECatHole)>0 && instance_number(enemy)>=24,
            "Normal Lair missed original room set, manhole, hole spawners or enemy reserves")
        with(enemy) if(visible && mask_index!=mskNone && !scrNTTEFullValue(id,"canfly",false))
            assert(!place_meeting(x,y,Wall),"Natural Lair population retained a visible ground enemy inside a wall: "+object_get_name(object_index))
    }
    with (_generation) event_perform(ev_alarm,1)
    assert(!instance_exists(_generation) && !instance_exists(FloorMaker),"Native finalization retained a custom generator")
    assert(TopCont.darkness && surface_exists(TopCont.dark),"Source custom darkness has no live native render surface")
    if (_key=="trench") {
        assert(GameCont.ntte_full_active_trench && instance_number(NTTEFullPitSquid)==1 && instance_exists(NTTEFullPitRenderer),
            "Normal Trench Destroy missed source subarea3 boss/pit state")
        var _octo=noone
        with (NTTEFullPet) if (pet=="Octo") { _octo=id; break }
        assert(instance_exists(_octo) && _octo.hiding,"Normal Trench omitted original hiding Octo pet")
        var _pits=0,_land=0
        with (Floor) { if (styleb) _pits+=1; else _land+=1 }
        assert(_pits>0 && _land>0,"Normal Trench source generator lost land/pit split")
    }
    else assert(GameCont.ntte_full_active_lair,"Normal Lair Destroy never invoked source area_start")
    assert(instance_number(TopCont)==1 && instance_number(SubTopCont)==1,"Normal custom lifecycle duplicated native HUD controllers")
    scrCleanupAreaInstances()
    instance_destroy(NTTEFullPet,false)
    scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players)
    global.ntte_full_sync_generation=_sync
    save_set_value("game","tutorial",_tutorial)
    instance_activate_object(_harness)
    scrNTTESmokeLog("FULL NORMAL "+string_upper(_key)+" GENCONT CREATE/ALARM2/ALARM0/ALARM1/DESTROY SOURCE FLOOR POPULATE START CAMERA OK @"+string(30/timescale))
}

function scrNTTEFullLairNormalLifecycleUnitTests() { scrNTTEFullNormalAreaLifecycleUnitTest("lair") }
function scrNTTEFullTrenchNormalLifecycleUnitTests() { scrNTTEFullNormalAreaLifecycleUnitTest("trench") }

function scrNTTEFullInRoomGenerationUnitTests() {
    scrNTTEFullInRoomOverlapNativeTests();
    scrNTTEFullInRoomRenderStateTests();
    // The generic desktop harness intentionally builds only BackCont. A live
    // generated gameplay room also has TopCont/SubTopCont; create that real
    // native pair before checking that an in-room build preserves them.
    if (!instance_exists(TopCont)) instance_create(0,0,TopCont)
    var _snapshot=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),_players=scrNTTEFullAreaGeneratorSnapshot(Player)
    var _area=GameCont.area,_subarea=GameCont.subarea,_loops=GameCont.loops,_back=instance_find(BackCont,0),_top=instance_find(TopCont,0)
    var _world=instance_create(31800,31800,NTTEFullCatLight),_player=instance_find(Player,0),_px=_player.x,_py=_player.y
    // Exercise the real GenCont/FloorMaker/population, rather than a test-only
    // area callback that could conceal broken native integration.
    scrNTTEFullAreaGenerateNative(area_desert,1,_loops,32016,32016,false,0)
    assert(instance_exists(_world) && _world.object_index==NTTEFullCatLight,
        "Same-room generation deleted or failed to reactivate the existing world")
    assert(GameCont.area==_area && GameCont.subarea==_subarea && GameCont.loops==_loops,
        "setArea=false leaked the temporary native generation destination")
    assert(_player.x==_px && _player.y==_py,"Same-room GenCont moved the active player to its private generation origin")
    assert(instance_exists(_back) && instance_exists(_top) && instance_number(BackCont)==1 && instance_number(TopCont)==1,
        "Same-room generation lost existing native view controllers or retained duplicates")
    var _floors=scrNTTEFullRectInstances(31000,31000,33000,33000,Floor)
    assert(array_length(_floors)>10,"Actual native FloorMaker did not build and translate a destination level")
    assert(!instance_exists(FloorMaker) && !instance_exists(GenCont),"Synchronous destination generation left live generators")
    var _after=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_after);++_i) if (array_get_index(_snapshot,_after[_i])<0) instance_destroy(_after[_i],false)
    scrNTTEFullAreaGeneratorRestore(_game); scrNTTEFullAreaGeneratorRestore(_players)
    scrNTTESmokeLog("FULL REAL GENCONT FLOORMAKER POPULATE IN ROOM TRANSLATION OLD WORLD RESTORE ACTIVE PLAYER CAMERA NO DUPLICATES OK @"+string(30/timescale))
}

function scrNTTEFullInRoomRenderStateTests() {
    var _before=scrNTTEFullInstances(all),_game=scrNTTEFullAreaGeneratorSnapshot(GameCont),
        _players=scrNTTEFullAreaGeneratorSnapshot(Player),_back=scrNTTEFullAreaGeneratorSnapshot(BackCont),
        _uber=scrNTTEFullAreaGeneratorSnapshot(UberCont),_mus=scrNTTEFullAreaGeneratorSnapshot(MusCont),
        _vx=view_xview,_vy=view_yview,_cam=view_camera[0],_cx=camera_get_view_x(view_camera[0]),_cy=camera_get_view_y(view_camera[0]),
        _seed=random_get_seed(),_named=scrNTTEFullArrayCopy(global.rng_state),_tutorial=save_get_value("game","tutorial",true);
    try {
        save_set_value("game","tutorial",false);
        for(var _case=0;_case<3;++_case) {
            var _before_case=scrNTTEFullInstances(all),_flag=_case!=0,_frame=_case==0?0:2.5,_setup=undefined,_threw=false;
            view_xview=35900+_case*2048;view_yview=36100;camera_set_view_pos(_cam,view_xview-7,view_yview-11);
            var _ex=view_xview,_ey=view_yview;UberCont.letterbox=_flag;UberCont.letterbox_frame=_frame;
            if(_case==2) _setup=function(){throw "NTTE expected in-room setup failure";};
            try {scrNTTEFullAreaGenerateNative(area_desert,1,0,38016+_case*2048,38016,false,0,_setup);}
            catch(_error) {if(_case!=2 || _error!="NTTE expected in-room setup failure") throw _error;_threw=true;}
            assert(_threw==(_case==2),"In-room fixture missed actual thrown setup");
            assert(view_xview==_ex && view_yview==_ey && camera_get_view_x(_cam)==_ex-7 && camera_get_view_y(_cam)==_ey-11,"Native in-room generation leaked macro/real camera position");
            assert(UberCont.letterbox==_flag && UberCont.letterbox_frame==_frame,"Native in-room generation leaked loading letterbox flag/frame");
            assert(!instance_exists(GenCont) && !instance_exists(FloorMaker),"Native generation left generator after success/failure");
            scrNTTEFullMergedRuntimeTestCleanup(_before_case);
        }
    } finally {
        scrNTTEFullMergedRuntimeTestCleanup(_before);scrNTTEFullAreaGeneratorRestore(_game);scrNTTEFullAreaGeneratorRestore(_players);
        scrNTTEFullAreaGeneratorRestore(_back);scrNTTEFullAreaGeneratorRestore(_uber);scrNTTEFullAreaGeneratorRestore(_mus);
        view_xview=_vx;view_yview=_vy;camera_set_view_pos(_cam,_cx,_cy);
        save_set_value("game","tutorial",_tutorial);global.rng_state=_named;random_set_seed(_seed);
    }
    scrNTTESmokeLog("IN ROOM RENDER STATE: real native generation false/0 true/2.5 + thrown setup retained macro/camera/letterbox and generator cleanup @"+string(30/timescale));
}

// Genuine Heart Destroy -> native GenCont overlap regression.
function scrNTTEFullInRoomOverlapConfigure(_state,_seed,_actor_position=undefined) {
    scrNTTEFullAreaGeneratorRestore(_state.game)
    scrNTTEFullAreaGeneratorRestore(_state.players)
    global.ntte_full_progress={schema:1,unlocks:{},loadouts:{},stats:{}}
    global.ntte_full_world_event_hooks={}
    scrNTTEFullWorldEventsNativeBindings(true)
    global.ntte_full_world_events_native_bound=true
    global.ntte_full_sync_generation=false
    GameCont.area=area_sewers;GameCont.subarea=1;GameCont.loops=0;GameCont.hard=2
    GameCont.maxsubarea=scrAreaGetMaxSubarea(GameCont.area);GameCont.finalsubarea=false
    GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.proto=false
    GameCont.nochest=0;GameCont.noradch=0;GameCont.crownvisits=0
    GameCont.ntte_heart_spawn=undefined;GameCont.ntte_quest_spawned_part_index_list=[]
    GameCont.ntte_crime_active=false;GameCont.ntte_crime_bounty=0;GameCont.ntte_pet_history=[]
    GameCont.ntte_full_active_coast=false;GameCont.ntte_full_active_trench=false
    GameCont.ntte_full_active_lair=false
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedBuild(_seed)
    GameCont.ntte_full_source_pending_generation=undefined;GameCont.levseed=_seed
    global.rng_state[@RNGStates.Generation]=_seed
    save_set_value("game","tutorial",false)
    UberCont.opt_bossintro=false;UberCont.opt_freeze=0;UberCont.opt_shake=0
    UberCont.paused=false;UberCont.want_pause=false;UberCont.hardmode=false
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign()
    scrNTTEFullAreaNativeInit()
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont)
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont)
    var _cx=540000,_cy=540000
    for(var _x=0;_x<96;_x+=32) for(var _y=0;_y<96;_y+=32)
        instance_create(_cx+_x,_cy+_y,Floor)
    for(var _x=-16;_x<=96;_x+=16) for(var _y=-16;_y<=96;_y+=16)
        if(_x==-16 || _x==96 || _y==-16 || _y==96) {
            instance_create(_cx+_x,_cy+_y,Wall)
            instance_create(_cx+_x-16,_cy+_y-16,Top)
        }
    with(Player) {
        race=Race.Fish;wep=wep_revolver;bwep=wep_none
        ntte_state=undefined;bntte_state=undefined
        hp=100000;max_hp=100000;nexthurt=current_frame+100000
        hspeed=0;vspeed=0;can_walk=false;can_aim=false
        x=_cx+80;y=_cy+48
        if(is_array(_actor_position)) {x=_actor_position[0]+8;y=_actor_position[1]+8}
        xprevious=x;yprevious=y;xstart=x;ystart=y
    }
    return [_cx,_cy]
}
function scrNTTEFullInRoomOverlapUnfold(_origin,_seed) {
    random_set_seed(_seed)
    var _bullet=instance_create(_origin[0]+96,_origin[1]+48,NTTEFullCrystalHeartBullet)
    _bullet.area=scrNTTEFullAreaId("red");_bullet.subarea=0;_bullet.loops=0
    _bullet.area_goal=16;_bullet.area_seed=_seed;_bullet.direction=0
    _bullet.area_chest=[];_bullet.area_chest_pos="furthest";_bullet.area_chaos=false
    instance_destroy(_bullet)
    assert(!instance_exists(_bullet) && !instance_exists(GenCont) && !instance_exists(FloorMaker),
        "Real Heart Destroy did not finish genuine synchronous generation")
}
function scrNTTEFullInRoomOverlapObserve(_origin,_seed,_pass) {
    var _fills=scrNTTEFullInstances(FloorExplo),_red=scrNTTEFullAreaId("red"),
        _count=0,_types=[Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]
    for(var _i=0;_i<array_length(_fills);++_i) {
        var _fill=_fills[_i]
        if(abs(_fill.x-_origin[0])>4096 || abs(_fill.y-_origin[1])>4096) continue
        _count++
        assert(_fill.area==_red
            && _fill.sprite_index==scrNTTEFullAreaFloorSprite(_red,_fill.styleb,true),
            "Real overlap gap inherited old Sewers artwork instead of target Red: "
            +json_stringify({seed:_seed,pass:_pass,x:_fill.x,y:_fill.y,area:_fill.area,
                sprite:sprite_get_name(_fill.sprite_index)}))
        var _covered=scrNTTEFullRectInstances(_fill.bbox_left,_fill.bbox_top,
            _fill.bbox_right-1,_fill.bbox_bottom-1,_types)
        for(var _j=0;_j<array_length(_covered);++_j)
            assert(_covered[_j]==_fill,
                "Real gap FloorExplo retained overlapping terrain/roof/prop: "
                +json_stringify({seed:_seed,pass:_pass,fill:real(_fill),
                    covered:real(_covered[_j]),object:object_get_name(_covered[_j].object_index)}))
    }
    assert(_count>0,"Heart fixture missed actual gap-fill construction; seed="+string(_seed))
    with(TopSmall) if(abs(x-_origin[0])<4096 && abs(y-_origin[1])<4096)
        assert(!position_meeting(x,y,Floor),"Real unfolding left a roof origin inside walkable Floor")
    assert(GameCont.area==area_sewers && GameCont.subarea==1 && GameCont.loops==0
        && GameCont.maxsubarea==scrAreaGetMaxSubarea(area_sewers) && !GameCont.finalsubarea
        && !GameCont.underwater,"False Heart generation leaked target area context")
    return _count
}
function scrNTTEFullInRoomOverlapNativeTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(Player)
        && !instance_exists(GenCont),"Overlap regression needs settled dedicated desktop smoke")
    var _rate=game_get_speed(gamespeed_fps)
    assert((_rate==30 || _rate==60) && timescale==30/_rate,"Overlap regression requires actual native 30/60")
    scrNTTEFullFloorInit();scrNTTEFullWorldEventsInit()
    var _old_map=UberCont.saveData,_old_bytes=ds_map_write(_old_map),_fixture_map=ds_map_create(),
        _old_directory=game_directory,_scratch=working_directory+"inroom-overlap-"+string(get_timer())+"/",
        _global_names=variable_struct_get_names(global),_global_values=[],_graph={nodes:[]}
    for(var _i=0;_i<array_length(_global_names);++_i) {
        var _name=_global_names[_i],_value=variable_global_get(_name)
        array_push(_global_values,[_name,_value]);scrNTTEFullAreaSnapshotContainer(_value,_graph)
    }
    ds_map_copy(_fixture_map,_old_map);UberCont.saveData=_fixture_map
    var _state=scrNTTEFullWorldEventsNaturalWorldCapture(),
        _walls=ds_list_create(),_floors=ds_list_create(),
        _seeds=[7,41,99],_total_fills=0,_total_clears=0
    directory_create(_scratch);game_directory=_scratch
    try {
        global.lis_walls_visible=_walls;global.lis_floors_visible=_floors
        for(var _case=0;_case<array_length(_seeds);++_case) {
            var _seed=_seeds[_case],_candidate=undefined,_distance=-1
            for(var _pass=0;_pass<2;++_pass) {
                scrNTTEFullMergedRuntimeTestCleanup(_state.before)
                ds_list_clear(_walls);ds_list_clear(_floors)
                var _origin=scrNTTEFullInRoomOverlapConfigure(_state,_seed,
                    _pass==1?_candidate:undefined),_player=instance_find(Player,0),
                    _px=_player.x,_py=_player.y,_mask=_player.mask_index<0?_player.sprite_index:_player.mask_index,
                    _sx=_player.image_xscale,_sy=_player.image_yscale,_angle=_player.image_angle
                if(_pass==1) {
                    var _old_wall_hits=scrNTTEFullRectInstances(_player.bbox_left,_player.bbox_top,
                        _player.bbox_right-1,_player.bbox_bottom-1,Wall)
                    assert(!array_length(_old_wall_hits),"Old hitme witness already overlaps old Wall")
                }
                scrNTTEFullInRoomOverlapUnfold(_origin,_seed)
                _total_fills+=scrNTTEFullInRoomOverlapObserve(_origin,_seed,_pass)
                assert(_player.x==_px && _player.y==_py,"Real generation moved restored old Player during overlap")
                if(_pass==0) {
                    var _walls_now=scrNTTEFullInstances(Wall)
                    for(var _i=0;_i<array_length(_walls_now);++_i) {
                        var _wall=_walls_now[_i]
                        if(_wall.object_index!=Wall || !_wall.solid || _wall.area!=scrNTTEFullAreaId("red")) continue
                        if(!(_wall.x<_origin[0]-32 || _wall.x>_origin[0]+112
                            || _wall.y<_origin[1]-32 || _wall.y>_origin[1]+112)) continue
                        var _d=point_distance(_wall.x,_wall.y,_origin[0]+48,_origin[1]+48)
                        if(_d>_distance) {_distance=_d;_candidate=[_wall.x,_wall.y]}
                    }
                    assert(is_array(_candidate),"Real Red generation lacked a new Wall isolated from old border")
                }
                else {
                    var _touches=false
                    with(_player) _touches=place_meeting(x,y,Wall)
                    assert(_touches,"Same-seed real generation did not reproduce witness Wall; seed="+string(_seed))
                    var _clears=scrNTTEFullInstances(PortalClear),_matches=0
                    for(var _i=0;_i<array_length(_clears);++_i) {
                        var _clear=_clears[_i]
                        if(_clear.x==_px && _clear.y==_py && _clear.sprite_index==_mask
                            && _clear.image_xscale==_sx && _clear.image_yscale==_sy
                            && _clear.image_angle==_angle) _matches++
                    }
                    assert(_matches>0,"New Wall covering old hitme omitted source mask-copy PortalClear")
                    _total_clears+=_matches
                }
                scrNTTESmokeLog("HEART OVERLAP actual Destroy/native generation "+json_stringify({seed:_seed,pass:_pass,rate:_rate,
                    floors:instance_number(Floor),gap_fills:instance_number(FloorExplo),old_hitme:_pass==1,new_wall_witness:_candidate}))
            }
        }
        assert(_total_fills>=array_length(_seeds)*2 && _total_clears>=array_length(_seeds),
            "Real overlap regression silently omitted required gap/old-hitme branches")
    }
    finally {
        scrNTTEFullWorldEventsNaturalWorldRestore(_state)
        var _now=variable_struct_get_names(global)
        for(var _i=0;_i<array_length(_now);++_i)
            if(array_get_index(_global_names,_now[_i])<0) variable_struct_remove(global,_now[_i])
        for(var _i=0;_i<array_length(_global_values);++_i)
            variable_global_set(_global_values[_i][0],_global_values[_i][1])
        scrNTTEFullAreaGeneratorRestore({instances:[],containers:_graph.nodes})
        game_directory=_old_directory;UberCont.saveData=_old_map
        if(ds_exists(_walls,ds_type_list)) ds_list_destroy(_walls)
        if(ds_exists(_floors,ds_type_list)) ds_list_destroy(_floors)
        if(ds_exists(_fixture_map,ds_type_map)) ds_map_destroy(_fixture_map)
        assert(UberCont.saveData==_old_map && ds_map_write(_old_map)==_old_bytes,
            "Overlap fixture changed original permanent save map identity or bytes")
    }
    scrNTTESmokeLog("FULL HEART OVERLAP: genuine Destroy/GenCont, six target-art gap passes,"
        +" bbox cleanup and three same-seed old-hitme/new-wall PortalClear witnesses OK @"+string(_rate))
}
