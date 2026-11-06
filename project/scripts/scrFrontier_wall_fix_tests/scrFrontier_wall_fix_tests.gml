// Explicit isolated Windows regressions. These invoke the real source event,
// Heart Destroy/native generator and complete Red secret-room generator.
function scrFRWallFixCapture(_kind,_x,_y,_w,_h,_subject=noone) {
    var _surface=-1,_camera=-1,_buffer=-1,_success=false,_target=surface_get_target(),
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_shader=shader_current();
    gpu_push_state();
    try {
        _surface=surface_create(_w,_h);_buffer=buffer_create(_w*_h*4,buffer_fixed,1);
        _camera=camera_create_view(_x,_y,_w,_h,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);
        draw_set_color(c_white);draw_set_alpha(1);draw_clear_alpha(c_black,0);
        switch(_kind) {
            case "fill":scrNTTESolidWallDraw();break;
            case "fill-biome-reference":
                with(_subject) {
                    var _base=scrAreaGetBackroundColor(area,false);
                    draw_set_color(make_color_rgb(color_get_red(_base)*color_get_red(image_blend)/255,
                        color_get_green(_base)*color_get_green(image_blend)/255,
                        color_get_blue(_base)*color_get_blue(image_blend)/255));
                    draw_set_alpha(image_alpha);draw_rectangle(x,y-8,x+ntte_fill_width,y+ntte_fill_height-8,false);
                }
                break;
            case "top":with(_subject) event_perform(ev_draw,0);break;
            case "top-reference":
                with(_subject) draw_sprite_ext(topspr,topindex,x,y-8,1,1,0,image_blend,1);
                break;
            case "top-body-index-control":
                with(_subject) draw_sprite_ext(topspr,image_index,x,y-8,1,1,0,image_blend,1);
                break;
            default:throw "Unknown wall GPU capture: "+_kind;
        }
        assert(real(surface_get_target())==real(_surface),"Wall draw lost its GPU target");
        surface_reset_target();
        buffer_get_surface(_buffer,_surface,0);
        _success=true;
        return {surface:_surface,pixels:_buffer,width:_w,height:_h};
    } finally {
        if(surface_get_target()==_surface) surface_reset_target();
        if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target);
        if(_camera>=0) camera_destroy(_camera);
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        gpu_pop_state();if(_shader<0) shader_reset();else shader_set(_shader);
        draw_set_color(_color);draw_set_alpha(_alpha);
        if(!_success) {
            if(surface_exists(_surface)) surface_free(_surface);
            if(buffer_exists(_buffer)) buffer_delete(_buffer);
        }
    }
}
function scrFRWallFixTestsReset(_state) {
    scrNTTEFullMergedRuntimeTestCleanup(_state.before);
    scrNTTEFullAreaGeneratorRestore(_state.game);scrNTTEFullAreaGeneratorRestore(_state.players);
    ds_list_clear(global.lis_walls_visible);ds_list_clear(global.lis_floors_visible);
    UberCont.ntte_fill_visible=[];
    GameCont.skillpoints=0;GameCont.ultrapoints=0;GameCont.crownpoints=0;
    GameCont.crown=Crown.None;GameCont.gocrib=false;GameCont.proto=false;GameCont.loops=0;
    GameCont.killenemies=false;GameCont.is_level_ended=false;
    UberCont.opt_bossintro=false;UberCont.opt_bloom=false;UberCont.opt_freeze=0;UberCont.paused=false;
    scrNTTEFullFloorResetStyle();scrNTTEFullFloorResetAlign();
    if(!instance_exists(BackCont)) instance_create(0,0,BackCont);
    if(!instance_exists(TopCont)) instance_create(0,0,TopCont);
}

function scrFRWallFixColorTests(_state) {
    scrFRWallFixTestsReset(_state);
    GameCont.area=area_scrapyards;GameCont.subarea=2;GameCont.hard=3;
    background_set_colour(scrAreaGetBackroundColor(GameCont.area));
    var _x=610000,_y=610000,_floor=instance_create(_x,_y,Floor),
        _wall=instance_create(_x+32,_y,Wall),_event=instance_create(0,0,FRCustomObject),
        _night=make_color_rgb(83,85,119);
    // Actual NTUF event _create changes background and the detailed edge art.
    scrFRInvoke(_event,["mod","Frontier_Events","ScrapyardsNight_create"],[]);
    assert(scrFRWallBackgroundColor()==_night,"Source ScrapyardsNight did not set the real background");
    scrNTTESolidWallGenerate();
    var _fill=scrNTTEFullInstances(NTTESolidWall);
    assert(array_length(_fill)>0,"Night terrain fixture did not generate compact exterior");
    for(var _i=0;_i<array_length(_fill);++_i)
        assert(_fill[_i].ntte_fill_color==_night && _fill[_i].solid,
            "Night exterior kept the static daytime area colour or lost collision");
    var _near=_fill[0],_capture=undefined;
    try {
        UberCont.ntte_fill_visible=[_near];
        _capture=scrFRWallFixCapture("fill",_near.x,_near.y-8,16,16);
        var _pixel=surface_getpixel_ext(_capture.surface,8,8);
        assert(((int64(_pixel)>>24)&255)==255 && (_pixel & $ffffff)==_night,
            "Night packed fill failed actual opaque GPU colour readback");
        scrFRVisualSave(_capture,"ntuf-wall-night-fill.png");
    } finally {scrFRVisualFree(_capture);}
    // A subsequent background/area switch may not recolour an existing piece.
    background_set_colour(c_red);GameCont.area=area_desert;
    var _sx=_near.x,_sy=_near.y,_farx=_near.x+_near.ntte_fill_width-8,
        _fary=_near.y+_near.ntte_fill_height-8;
    scrNTTESolidWallMaterialize(_sx,_sy,_sx+15,_sy+15);
    var _pieces=scrNTTEFullInstances(NTTESolidWall);
    for(var _i=0;_i<array_length(_pieces);++_i)
        assert(_pieces[_i].ntte_fill_color==_night,"Splitting a weather-tinted pack inherited another area's colour");
    assert(position_meeting(_farx,_fary,Wall),"Local pack split removed the untouched collision remainder");
    scrNTTESmokeLog("PASS NTUF WALL night source event, opaque GPU exterior colour, per-piece tint inheritance and solid remainder");
}

function scrFRWallFixLiveBiomeTests(_state) {
    scrFRWallFixTestsReset(_state);
    GameCont.area=area_scrapyards;GameCont.subarea=2;
    var _night=make_color_rgb(83,85,119),_x=615000,_y=615000;
    background_set_colour(_night);
    // Production border callers historically supplied only these fields.
    // That shape must retain its original target-biome/tint/alpha contract.
    var _legacy=scrNTTESolidWallPiece(_x,_y,64,64,
        {area:area_labs,blend:c_white,alpha:1});
    assert(instance_exists(_legacy) && scrFRWallFillColor(_legacy)==scrAreaGetBackroundColor(area_labs,false),
        "Native three-field packed-wall state gained a required colour member or inherited the current weather");
    var _wall=scrNTTESolidWallBlock(_x+128,_y,64,64),_areas=[1,2,4,5,7,206,207,3],
        _actual=undefined,_reference=undefined;
    assert(scrFRWallFillColor(_wall)==_night,"Live-biome fixture lost its initial authored night snapshot");
    try {
        for(var _a=0;_a<array_length(_areas);++_a) for(var _t=0;_t<2;++_t) {
            _wall.area=_areas[_a];_wall.image_blend=_t?make_color_rgb(99,171,213):c_white;
            _wall.image_alpha=_t?0.625:1;
            UberCont.ntte_fill_visible=[_wall];
            _actual=scrFRWallFixCapture("fill",_wall.x-8,_wall.y-16,80,80);
            _reference=scrFRWallFixCapture("fill-biome-reference",_wall.x-8,_wall.y-16,80,80,_wall);
            assert(scrFRVisualSamePixels(_actual,_reference)
                && _wall.ntte_fill_color_area==_wall.area,
                "Packed wall failed exact native GPU colour/tint/alpha after its own biome changed");
            scrFRVisualFree(_actual);_actual=undefined;scrFRVisualFree(_reference);_reference=undefined;
        }
    } finally {scrFRVisualFree(_actual);scrFRVisualFree(_reference);}
    // A real border can cut a weather-coloured packed block in two. The top
    // keeps that snapshot, while the lower half adopts only the target biome.
    _wall=scrNTTESolidWallBlock(_x+512,_y,256,192);
    var _border=instance_create(_wall.x,_wall.y+64,NTTEFullLairBorder);
    _border.area=area_sewers;
    scrNTTEFullLairBorderSetupInstance(_wall);
    var _top=collision_point(_x+520,_y+8,NTTESolidWall,false,false),
        _bottom=collision_point(_x+520,_y+184,NTTESolidWall,false,false);
    assert(instance_exists(_top) && instance_exists(_bottom) && _top!=_bottom
        && _top.area==area_scrapyards && _bottom.area==area_sewers
        && scrFRWallFillColor(_top)==_night
        && scrFRWallFillColor(_bottom)==scrAreaGetBackroundColor(area_sewers,false)
        && _top.solid && _bottom.solid && _top.topspr==-1 && _bottom.topspr==-1,
        "Actual mixed-biome border lost old weather, target colour, packed collision or undecorated fill");
    scrNTTESmokeLog("PASS NTUF WALL legacy three-field state,16 exact live-biome/tint/alpha GPU comparisons and actual weather-preserving mixed-biome border");
}

function scrFRWallFixSourceFootprints(_before) {
    // Independent control: this Heart ran without OLD compact walls. Record
    // the actual newly authored source geometry, excluding the collar that
    // the final generator may now create. Never infer an expected hole from
    // the collision result of the subsequent packed-wall run.
    var _geometry=scrNTTEFullInstances([Floor,Wall,InvisiWall,TopSmall,TopPot,Bones]),_boxes=[];
    for(var _i=0;_i<array_length(_geometry);++_i) {
        var _v=_geometry[_i];
        if(_v.object_index==NTTESolidWall || array_get_index(_before,_v)>=0) continue;
        array_push(_boxes,[_v.bbox_left,_v.bbox_top,_v.bbox_right-1,_v.bbox_bottom-1,_v.object_index]);
    }
    return _boxes;
}
function scrFRWallFixSourceTouches(_boxes,_x1,_y1,_x2,_y2) {
    // Source reconciliation can remove any contacted terrain cell. Its
    // authored bbox is a conservative mask; untouched cells outside ALL of
    // these independent source footprints must keep their old collision.
    for(var _i=0;_i<array_length(_boxes);++_i) {
        var _b=_boxes[_i];
        if(_b[0]<=_x2 && _b[2]>=_x1 && _b[1]<=_y2 && _b[3]>=_y1) return true;
    }
    return false;
}
function scrFRWallFixSourceEdgeWitness(_boxes,_seed) {
    assert(array_length(_boxes)>0,"Independent Heart control authored no source footprints");
    var _right=_boxes[0],_left=_boxes[0],_bottom=_boxes[0],_top=_boxes[0];
    for(var _i=1;_i<array_length(_boxes);++_i) {
        var _b=_boxes[_i];
        if(_b[2]>_right[2]) _right=_b;
        if(_b[0]<_left[0]) _left=_b;
        if(_b[3]>_bottom[3]) _bottom=_b;
        if(_b[1]<_top[1]) _top=_b;
    }
    // Put one corner/edge of a single 256px OLD pack in the real new source
    // footprint. Its far side extends beyond every source bbox on that axis.
    // Reject overlap with any genuine old floor/wall: the old fixture itself
    // must not begin with collision laid over its walkable room.
    var _candidates=[
        [floor(_right[2]/16)*16,floor((_right[1]+_right[3])/32)*16],
        [floor(_left[0]/16)*16-240,floor((_left[1]+_left[3])/32)*16],
        [floor((_bottom[0]+_bottom[2])/32)*16,floor(_bottom[3]/16)*16],
        [floor((_top[0]+_top[2])/32)*16,floor(_top[1]/16)*16-240]];
    for(var _i=0;_i<array_length(_candidates);++_i) {
        var _x=_candidates[_i][0],_y=_candidates[_i][1];
        if(array_length(scrNTTEFullRectInstances(_x,_y,_x+255,_y+255,[Floor,Wall,InvisiWall]))) continue;
        var _pack=scrNTTESolidWallBlock(_x,_y,256,256),_cells=[],_touched=0,_untouched=0;
        for(var _dy=0;_dy<256;_dy+=16) for(var _dx=0;_dx<256;_dx+=16) {
            var _cx=_x+_dx,_cy=_y+_dy,
                _touch=scrFRWallFixSourceTouches(_boxes,_cx,_cy,_cx+15,_cy+15),
                _hit=collision_point(_cx+8,_cy+8,_pack,false,false);
            assert(_hit==_pack && position_meeting(_cx+8,_cy+8,Wall),
                "Old witness geometry did not actually cover its snapshotted cell");
            array_push(_cells,[_cx,_cy,_touch]);
            if(_touch) {_touched+=1;} else {_untouched+=1;}
        }
        assert(_touched>0 && _untouched>0,"Source-edge witness missed either contacted or retained old cells");
        return {wall:_pack,x:_x,y:_y,cells:_cells,touched:_touched,untouched:_untouched};
    }
    throw "No source-edge old-pack witness clear of the original room; seed="+string(_seed);
}
function scrFRWallFixLocalOrbTests(_state) {
    var _seeds=[7,41,99],_old_color=make_color_rgb(34,61,73),_total_retained=0;
    for(var _case=0;_case<array_length(_seeds);++_case) {
        var _seed=_seeds[_case];
        scrFRWallFixTestsReset(_state);
        var _origin=scrNTTEFullInRoomOverlapConfigure(_state,_seed);
        background_set_colour(_old_color);
        var _source_before=scrNTTEFullInstances(all);
        // Same real Destroy/native generator, first without any OLD pack.
        scrNTTEFullInRoomOverlapUnfold(_origin,_seed);
        var _source_boxes=scrFRWallFixSourceFootprints(_source_before);
        scrFRWallFixTestsReset(_state);
        _origin=scrNTTEFullInRoomOverlapConfigure(_state,_seed);
        background_set_colour(_old_color);
        var _witness=scrFRWallFixSourceEdgeWitness(_source_boxes,_seed);
        scrNTTESolidWallGenerate();
        var _far=scrNTTESolidWallBlock(_origin[0]+2400,_origin[1]-128,256,256),
            _farid=real(_far),_x=_far.x,_y=_far.y;
        // Genuine CrystalHeartBullet.Destroy -> GenCont -> source reconciliation.
        scrNTTEFullInRoomOverlapUnfold(_origin,_seed);
        assert(instance_exists(_far) && real(_far)==_farid && _far.x==_x && _far.y==_y
            && _far.ntte_fill_width==256 && _far.ntte_fill_height==256 && _far.ntte_fill_color==_old_color,
            "A local area orb replaced a distant old packed wall");
        assert(GameCont.area==area_sewers && scrFRWallBackgroundColor()==_old_color,
            "A local orb leaked the target area/default background to the old room");
        var _fill=scrNTTEFullInstances(NTTESolidWall),_newwalls=0,_floor_count=0;
        for(var _i=0;_i<array_length(_fill);++_i)
            assert(_fill[_i].area==area_sewers && _fill[_i].ntte_fill_color==_old_color,
                "A local orb built a target-coloured map-wide collision collar");
        with(Wall) if(object_index!=NTTESolidWall && area==206) _newwalls++;
        with(Floor) if(area==206) {
            _floor_count++;
            assert(!collision_rectangle(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,NTTESolidWall,false,false),
                "Old compact collision was not carved from the orb's actual new floor");
        }
        assert(_newwalls>0 && _floor_count>0,"Orb regression never constructed local target wall/floor art");
        with(NTTEFullFloorReveal) for(var _i=0;_i<array_length(list);++_i) {
            var _r=list[_i];
            assert(!(_r.x1<_x+256 && _r.x2>=_x && _r.y1<_y+256 && _r.y2>=_y),
                "Representational packed walls leaked into source orb flash/reveal geometry");
        }
        assert(position_meeting(_x+128,_y+128,Wall),"Far old collision vanished after orb merge");
        assert(!instance_exists(_witness.wall),
            "Real source geometry never materialized the same old witness pack; seed="+string(_seed));
        var _retained=0;
        for(var _i=0;_i<array_length(_witness.cells);++_i) {
            var _cell=_witness.cells[_i];
            if(_cell[2]) continue;
            var _px=_cell[0]+8,_py=_cell[1]+8,
                _remainder=collision_point(_px,_py,NTTESolidWall,false,false);
            assert(instance_exists(_remainder) && _remainder.solid
                && _remainder.area==area_sewers && scrFRWallFillColor(_remainder)==_old_color
                && position_meeting(_px,_py,Wall),
                "A source-untouched cell of the SAME contacted old pack lost collision/colour: "
                +json_stringify({seed:_seed,x:_cell[0],y:_cell[1],old_x:_witness.x,old_y:_witness.y}));
            ++_retained;
        }
        assert(_retained==_witness.untouched && _retained>0,"Source-mask remainder oracle checked no retained old cells");
        _total_retained+=_retained;
        scrNTTESmokeLog("PASS NTUF WALL source-control mask seed="+string(_seed)
            +" source_boxes="+string(array_length(_source_boxes))+" contacted_old_cells="+string(_witness.touched)
            +" retained_same_pack_cells="+string(_retained));
    }
    scrNTTESmokeLog("PASS NTUF WALL actual Heart Destroy/native local merge: far identity/collision/colour and global background unchanged; new target art and floor carving retained;3 independent source masks retained "+string(_total_retained)+" same-pack cells");
}

function scrFRWallFixTopSpawnTests(_state) {
    scrFRWallFixTestsReset(_state);
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.hard=1;
    var _x=620000,_y=620000;
    for(var _dx=0;_dx<96;_dx+=32) instance_create(_x+_dx,_y,Floor);
    for(var _dx=0;_dx<96;_dx+=16) instance_create(_x+_dx,_y-16,Wall);
    scrNTTESolidWallGenerate();
    var _ordinary=instance_create(_x+400,_y-240,Bandit),_ordinary_x=_ordinary.x,_ordinary_y=_ordinary.y,
        _top=scrNTTEFullTopCreate(_x+240,_y-240,Bandit,0,16),_contact=false;
    scrNTTESmokeLog("NTUF WALL top placement "+json_stringify({exists:instance_exists(_top),
        x:instance_exists(_top)?_top.x:-1,y:instance_exists(_top)?_top.y:-1,
        type:instance_exists(_top)?_top.type:-1,clamped:instance_exists(_top)?(_top[$ "fr_wall_spawn_clamped"]??false):false,
        mask_x:instance_exists(_top)?_top.mask_x:-1,mask_y:instance_exists(_top)?_top.mask_y:-1}));
    assert(instance_exists(_top) && (_top[$ "fr_wall_spawn_clamped"]??false),
        "Actual TopCreate left an ordinary elevated enemy deep behind the wall lip");
    with(_top) _contact=place_meeting(x+mask_x,y+mask_y,Floor);
    assert(_contact,"Constrained wall-top occupant cannot start the source floor-contact jump");
    assert(_ordinary.x==_ordinary_x && _ordinary.y==_ordinary_y,"Wall-top repair moved an ordinary map enemy");
    _top.jump_time=0;_top.idle_time=0;
    scrNTTEFullTopGlobalStep();
    assert(_top.zspeed>0 && _top.zfriction>0,"Reachable elevated enemy did not enter the real jump/fall lifecycle");
    var _prop=scrNTTEFullTopCreate(_x+400,_y-240,Barrel,0,0);
    assert(!(_prop[$ "fr_wall_spawn_clamped"]??false) && _prop.x==_x+400,
        "Wall-top guard altered a deliberately placed prop/island");
    scrNTTESmokeLog("PASS NTUF WALL actual TopCreate deep ordinary occupant reaches authored floor-facing edge and jumps; ordinary map enemies/explicit props untouched");
}

function scrFRWallFixHiddenRoomTests(_state) {
    scrFRWallFixTestsReset(_state);
    GameCont.area=area_desert;GameCont.subarea=1;GameCont.hard=5;
    GameCont.maxsubarea=3;GameCont.finalsubarea=false;GameCont.levseed=91;
    global.ntte_full_sync_generation=false;
    scrNTTEFullAreaNativeInit();random_set_seed(91);
    // Full production Red area callbacks construct the secret room/corridor.
    scrNTTEFullAreaGenerateNative(206,1,0,10016,10016,true,0);
    var _fakes=scrNTTEFullInstances(NTTEFullWallFake);
    assert(array_length(_fakes)>0 && instance_exists(NTTEFullWallFakeDrawTop)
        && instance_exists(NTTEFullWallFakeRevealTop),"Real Red generation omitted secret corridor/render controllers");
    var _fake=_fakes[0],_player=instance_find(Player,0),_drawtop=instance_find(NTTEFullWallFakeDrawTop,0),
        _revealtop=instance_find(NTTEFullWallFakeRevealTop,0),_top=instance_exists(SubTopCont)?instance_find(SubTopCont,0):instance_create(0,0,SubTopCont);
    assert(_drawtop.depth>_top.depth && _revealtop.depth<_top.depth,
        "Secret roof capture/reveal do not strictly surround the real SubTopCont pass");
    _player.x=_fake.x+8;_player.y=_fake.y+4;_player.xprevious=_player.x;_player.yprevious=_player.y;
    repeat(ceil(12/timescale)) with(NTTEFullWallFakeController) scrNTTEFullWallFakeEndStep();
    assert(_player.red_wall_fake==1,"Real hidden corridor did not grow the original player reveal circle");
    var _vx=_fake.x+8-view_width/2,_vy=_fake.y-view_height/2,
        _surface=-1,_camera=-1,_target=surface_get_target(),_world=matrix_get(matrix_world),
        _view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _vx_old=view_xview,_vy_old=view_yview,_color=draw_get_color(),_alpha=draw_get_alpha(),
        _shine=scrNTTEFullInstances(NTTEFullRedWallShine),_shine_visible=[],_sentinel=make_color_rgb(21,137,201);
    for(var _i=0;_i<array_length(_shine);++_i) {_shine_visible[_i]=_shine[_i].visible;_shine[_i].visible=false;}
    gpu_push_state();
    try {
        view_xview=_vx;view_yview=_vy;
        scrNTTEWallVisibilityBuild(_vx,_vy,_vx+view_width,_vy+view_height,true);
        _surface=surface_create(view_width,view_height);
        _camera=camera_create_view(_vx,_vy,view_width,view_height,0,noone,-1,-1,-1,-1);
        surface_set_target(_surface);camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity());
        shader_reset();gpu_set_fog(false,0,0,0);gpu_set_blendmode(bm_normal);gpu_set_texfilter(false);
        draw_set_color(c_white);draw_set_alpha(1);draw_clear(_sentinel);
        // Capture the true under-roof image, then execute the production roof
        // pass and its strictly later reveal composition on the same GPU target.
        with(_drawtop) scrNTTEFullWallFakeDrawMask();
        with(_top) event_perform(ev_draw,0);
        surface_reset_target();
        var _px=round(_player.x-_vx),_py=round(_player.y-4-_vy),
            _covered=surface_getpixel_ext(_surface,_px,_py);
        surface_save(_surface,working_directory+"ntuf-red-hidden-roof-before.png");
        assert((_covered & $ffffff)!=_sentinel && ((int64(_covered)>>24)&255)>0,
            "Hidden-room GPU fixture never drew a covering roof at the player");
        surface_set_target(_surface);camera_apply(_camera);
        with(_revealtop) scrNTTEFullWallFakeDrawReveal();
        surface_reset_target();
        var _revealed=surface_getpixel_ext(_surface,_px,_py);
        surface_save(_surface,working_directory+"ntuf-red-hidden-roof-after.png");
        assert((_revealed & $ffffff)==_sentinel && ((int64(_revealed)>>24)&255)==255,
            "Real secret corridor still paints its roof above the captured under-roof image");
    } finally {
        if(surface_get_target()==_surface) surface_reset_target();
        if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target);
        if(surface_exists(_surface)) surface_free(_surface);if(_camera>=0) camera_destroy(_camera);
        view_xview=_vx_old;view_yview=_vy_old;
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection);
        gpu_pop_state();draw_set_color(_color);draw_set_alpha(_alpha);
        for(var _i=0;_i<array_length(_shine);++_i) if(instance_exists(_shine[_i])) _shine[_i].visible=_shine_visible[_i];
    }
    // Use different authored top/body indices as a positive control. Calling
    // the real top event must match topindex, and must differ from body frame.
    _fake.topindex=0;_fake.image_index=1;
    ds_list_clear(global.lis_walls_visible);ds_list_add(global.lis_walls_visible,_fake);
    UberCont.ntte_fill_visible=[];
    var _actual=undefined,_reference=undefined,_wrong=undefined;
    try {
        _actual=scrFRWallFixCapture("top",_fake.x,_fake.y-8,16,16,_top);
        _reference=scrFRWallFixCapture("top-reference",_fake.x,_fake.y-8,16,16,_fake);
        _wrong=scrFRWallFixCapture("top-body-index-control",_fake.x,_fake.y-8,16,16,_fake);
        assert(scrFRVisualSamePixels(_actual,_reference) && !scrFRVisualSamePixels(_actual,_wrong),
            "Native top GPU output ignores authored topindex=0 or the positive control is ineffective");
    } finally {scrFRVisualFree(_actual);scrFRVisualFree(_reference);scrFRVisualFree(_wrong);}
    scrNTTESmokeLog("PASS NTUF WALL full Red secret generation, real native top GPU topindex oracle and covering-roof -> under-roof reveal with strict depth ordering");
}

function scrFRWallFixTests() {
    assert(os_type==os_windows && scrNTTEFullSmokeEnabled() && scrFREnabled()
        && instance_exists(Player) && !instance_exists(GenCont),"Wall regressions require settled isolated NTUF desktop runtime");
    var _original_map=UberCont.saveData,_map_bytes=ds_map_write(_original_map),_fixture_map=ds_map_create(),
        _state=scrNTTEFullWorldEventsNaturalWorldCapture(),_old_walls=global.lis_walls_visible,
        _old_floors=global.lis_floors_visible,_old_fill=scrNTTEFullValue(UberCont,"ntte_fill_visible",undefined),
        _walls=ds_list_create(),_floors=ds_list_create(),_lock=lockstep_stop;
    ds_map_copy(_fixture_map,_original_map);UberCont.saveData=_fixture_map;
    global.lis_walls_visible=_walls;global.lis_floors_visible=_floors;lockstep_stop=false;
    try {
        scrFRWallFixColorTests(_state);
        scrFRWallFixLiveBiomeTests(_state);
        scrFRWallFixLocalOrbTests(_state);
        scrFRWallFixTopSpawnTests(_state);
        scrFRWallFixHiddenRoomTests(_state);
    } finally {
        scrNTTEFullWorldEventsNaturalWorldRestore(_state);
        global.lis_walls_visible=_old_walls;global.lis_floors_visible=_old_floors;UberCont.ntte_fill_visible=_old_fill;
        lockstep_stop=_lock;UberCont.saveData=_original_map;
        if(ds_exists(_walls,ds_type_list)) ds_list_destroy(_walls);
        if(ds_exists(_floors,ds_type_list)) ds_list_destroy(_floors);
        if(ds_exists(_fixture_map,ds_type_map)) ds_map_destroy(_fixture_map);
        assert(ds_map_write(_original_map)==_map_bytes,"Wall test changed original permanent save bytes");
    }
    scrNTTESmokeLog("PASS FRONTIER WALL FIXES source night/actual orb/full secret-room GPU/deep elevated enemy regressions @"+string(30/timescale));
}
