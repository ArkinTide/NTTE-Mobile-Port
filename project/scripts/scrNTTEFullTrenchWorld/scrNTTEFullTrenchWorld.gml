// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// Pit state is independent of vanilla areas. The original Trench generator
// defines its 16px pit tiles; this accessor also handles ordinary non-pit rooms.
function scrNTTEFullTrenchPitGet(_x,_y) {
    if (!variable_global_exists("ntte_full_trench_pit_grid")) return false
    var _grid=global.ntte_full_trench_pit_grid
    if (!ds_exists(_grid,ds_type_grid)) return false
    _x=floor(_x/16); _y=floor(_y/16)
    if (_x<0 || _y<0 || _x>=ds_grid_width(_grid) || _y>=ds_grid_height(_grid)) return false
    return _grid[# _x,_y]
}

function scrNTTEFullTrenchPitInit() {
    if (variable_global_exists("ntte_full_trench_pit_grid")
        && ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) ds_grid_destroy(global.ntte_full_trench_pit_grid)
    global.ntte_full_trench_pit_grid=ds_grid_create(1250,1250)
    ds_grid_clear(global.ntte_full_trench_pit_grid,false)
    global.ntte_full_trench_pit_dirty=true
    global.ntte_full_trench_floor_count=-1
}

function scrNTTEFullTrenchPitSet(_x,_y,_value,_batch=false) {
    if (!variable_global_exists("ntte_full_trench_pit_grid")
        || !ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) scrNTTEFullTrenchPitInit()
    var _grid=global.ntte_full_trench_pit_grid
    _x=floor(_x/16); _y=floor(_y/16)
    if (_x<0 || _y<0 || _x>=ds_grid_width(_grid) || _y>=ds_grid_height(_grid)) return false;
    _grid[# _x,_y]=_value
    global.ntte_full_trench_pit_dirty=true
    if(!_batch) scrNTTEFullTrenchPitResetChecks()
    return true
}
function scrNTTEFullTrenchPitResetChecks() {
    // A complete grid rebuild has no event/yield between tile writes. Its
    // settled-object flags therefore need only one reset after both passes.
    with (Corpse) ntte_full_trench_pit_checked=false
    with (ChestOpen) ntte_full_trench_pit_checked=false
    with (Debris) ntte_full_trench_pit_checked=false
    with (Shell) ntte_full_trench_pit_checked=false
    with (Feather) ntte_full_trench_pit_checked=false
}

function scrNTTEFullTrenchPitReset(_value=false) {
    if (!variable_global_exists("ntte_full_trench_pit_grid")
        || !ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) scrNTTEFullTrenchPitInit()
    ds_grid_clear(global.ntte_full_trench_pit_grid,_value)
    global.ntte_full_trench_pit_dirty=true
    global.ntte_full_trench_floor_count=-1
}

function scrNTTEFullTrenchPitlessMeeting(_x,_y) {
    var _ox=x,_oy=y
    x=_x; y=_y
    var _x1=floor(bbox_left/16),_y1=floor(bbox_top/16),
        _x2=ceil(((bbox_right-1)+1)/16),_y2=ceil(((bbox_bottom-1)+1)/16)
    x=_ox; y=_oy
    // Immutable during this read: no event or yield occurs between cells.
    var _grid=variable_global_exists("ntte_full_trench_pit_grid") ? global.ntte_full_trench_pit_grid:-1,
        _valid=ds_exists(_grid,ds_type_grid),_gw=0,_gh=0
    if(_valid) {_gw=ds_grid_width(_grid);_gh=ds_grid_height(_grid)}
    for(var _px=_x1;_px<_x2;++_px) for(var _py=_y1;_py<_y2;++_py) {
        if(!_valid || _px<0 || _py<0 || _px>=_gw || _py>=_gh || !_grid[# _px,_py]) return true
    }
    return false
}

function scrNTTEFullTrenchPitRebuild() {
    scrNTTEFullTrenchPitReset(false)
    var _pits=scrNTTERefSprite("FloorTrenchB"),_written=false
    with (Floor) if (sprite_index==_pits) {
        for(var _px=bbox_left;_px<(bbox_right-1)+1;_px+=16) for(var _py=bbox_top;_py<(bbox_bottom-1)+1;_py+=16) {
            if (!position_meeting(_px+8,_py+8,Wall)) _written=scrNTTEFullTrenchPitSet(_px,_py,true,true) || _written
        }
    }
    // Original non-pit floor pass wins wherever two floor masks overlap.
    with (Floor) if (sprite_index!=_pits) {
        for(var _px=bbox_left;_px<(bbox_right-1)+1;_px+=16) for(var _py=bbox_top;_py<(bbox_bottom-1)+1;_py+=16)
            _written=scrNTTEFullTrenchPitSet(_px,_py,false,true) || _written
    }
    if(_written) scrNTTEFullTrenchPitResetChecks()
    global.ntte_full_trench_floor_count=instance_number(Floor)
}

function scrNTTEFullTrenchPitSink(_x,_y,_spr,_img,_xs,_ys,_angle,_dir,_speed,_rotation) {
    var _p=instance_create(_x,_y,NTTEFullPitSink)
    _p.sprite_index=_spr; _p.image_index=_img; _p.image_xscale=_xs; _p.image_yscale=_ys; _p.image_angle=_angle
    if (_speed!=0) _p.direction=_dir
    _p.speed=max(_speed,_p.speed); _p.ntte_full_rotation=_rotation
    return _p
}

function scrNTTEFullPitSinkCreate() {
    image_speed=0; visible=false; friction=0.01*timescale*timescale
    speed=timescale; direction=random(360); ntte_full_rotation=0
}

function scrNTTEFullPitSinkStep() {
    if (lockstep_stop) return;
    image_blend=merge_color(c_black,image_blend,power(0.95,timescale))
    var _d=random_range(0.001,0.01)*timescale
    image_xscale-=sign(image_xscale)*_d; image_yscale-=sign(image_yscale)*_d
    if (vspeed<0) vspeed*=power(0.9,timescale)
    y+=timescale/3; direction+=ntte_full_rotation*timescale; image_angle+=ntte_full_rotation*timescale
    if (abs(image_xscale)<2/3) instance_destroy()
}

function scrNTTEFullTrenchPitWorldStep() {
    if (lockstep_stop || GameCont.area!=scrNTTEFullAreaId("trench") || instance_exists(GenCont)) return;
    if (!variable_global_exists("ntte_full_trench_pit_grid")
        || !ds_exists(global.ntte_full_trench_pit_grid,ds_type_grid)) scrNTTEFullTrenchPitInit()
    if (global.ntte_full_trench_floor_count!=instance_number(Floor)) scrNTTEFullTrenchPitRebuild()
    with (Player) {
        var _pit=scrNTTEFullTrenchPitGet(x,(bbox_bottom-1))
        if (_pit && speed<maxspeed-friction) {
            var _tx=x+cos(wave/10)*0.25*right*timescale,_ty=y+sin(wave/10)*0.25*right*timescale
            if (!place_meeting(_tx,y,Wall)) x=_tx
            if (!place_meeting(x,_ty,Wall)) y=_ty
        }
        if (speed>0 && _pit!=scrNTTEFullTrenchPitGet(x-hspeed,(bbox_bottom-1)-vspeed)) {
            repeat(3) {
                var _fx=instance_create(x,y,Smoke)
                with (_fx) motion_add(other.direction,other.speed/(_pit ? 2:3))
                /* NTTE NATIVE EFFECT LIFETIME trench-pit-exit-smoke */ if(instance_exists(_fx)) {if (!_pit) _fx.sprite_index=sprDust }
            }
            snd_play(asset_get_index("sndFootPlaRock"+choose("1","3","4","5","6")),0.5+orandom(0.1),_pit ? 0.8:0.5)
        }
    }
    var _floating=[WepPickup,chestprop,RadChest]
    for(var _i=0;_i<array_length(_floating);++_i) with (_floating[_i]) {
        if (speed==0 && scrNTTEFullTrenchPitGet(x,(bbox_bottom-1))) {
            var _tx=x+cos((current_frame+x+y)/10)*0.15*timescale,_ty=y+sin((current_frame+x+y)/10)*0.15*timescale
            if (!place_meeting(_tx,y,Wall)) x=_tx
            if (!place_meeting(x,_ty,Wall)) y=_ty
        }
    }
    with (prop) if (hp>0 && size<=2 && scrNTTEFullTrenchPitGet(x,y)) {
        if (!instance_is(id,RadChest) && !instance_is(id,Car) && !instance_is(id,CarVenus)
            && !instance_is(id,CarVenusFixed) && !instance_is(id,CarThrow)) hp=0
    }
    var _sinking=[Corpse,ChestOpen,Debris,Shell,Feather]
    for(var _i=0;_i<array_length(_sinking);++_i) with (_sinking[_i]) {
        if (variable_instance_exists(id,"ntte_full_trench_pit_checked") && ntte_full_trench_pit_checked) continue
        if (_i==0 && (image_speed!=0 || sprite_index==mskNone || sprite_index==sprPStatDead)) continue
        if (_i>0 && speed>timescale) continue
        if (speed==0) ntte_full_trench_pit_checked=true
        if (scrNTTEFullTrenchPitGet(x,_i==0 ? y:(bbox_bottom-1))) {
            scrNTTEFullTrenchPitSink(x,y,sprite_index,image_index,image_xscale,image_yscale,image_angle,direction,speed,orandom(0.6))
            if (_i==0 && !scr_check_enemies() && !instance_exists(Portal)) {
                var _safe=instance_create(x,y,Corpse); _safe.sprite_index=mskNone
            }
            instance_destroy()
        }
    }
}

function scrNTTEFullPitRendererCreate() {
    ntte_full_surface=-1; ntte_full_wall_top=-1; ntte_full_wall_bot=-1; ntte_full_spark_surface=-1
    ntte_full_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
    ntte_full_draw_x=-1;ntte_full_draw_y=-1;ntte_full_pit_mask=-1
    ntte_full_explicit_mask=(os_type==os_ios);ntte_full_cached_explicit_mask=undefined
    ntte_full_ios_surface_retry=0;ntte_full_ios_target_failures=0
    ntte_full_ios_target_attempts=0;ntte_full_ios_force_target_failure=false
    ntte_full_effective_main=1;ntte_full_effective_minor=1
    depth=instance_exists(BackCont) ? BackCont.depth+1:1000
    if (!variable_global_exists("ntte_full_trench_pit_grid")) scrNTTEFullTrenchPitInit()
}

function scrNTTEFullPitRendererCleanup() {
    if(surface_exists(ntte_full_pit_mask)) surface_free(ntte_full_pit_mask)
    if (surface_exists(ntte_full_spark_surface)) surface_free(ntte_full_spark_surface)
    if (surface_exists(ntte_full_surface)) surface_free(ntte_full_surface)
    if (surface_exists(ntte_full_wall_top)) surface_free(ntte_full_wall_top)
    if (surface_exists(ntte_full_wall_bot)) surface_free(ntte_full_wall_bot)
    if (ntte_full_camera>=0) camera_destroy(ntte_full_camera)
}

function scrNTTEFullPitRendererDraw() {
    // A Vault portal changes the destination area before leaving this room.
    // Keep the actual Trench scene until Transit clears its active flag.
    var _trench=scrNTTEFullAreaId("trench")
    if(instance_exists(GenCont) || !(GameCont.area==_trench
        || (scrNTTEFullValue(GameCont,"ntte_full_active_trench",false) && GameCont.lastarea==_trench))) return;
    scrNTTEFullIOSSurfaceProbe()
    var _vx=floor(view_xview/view_width)*view_width,_vy=floor(view_yview/view_height)*view_height,
        _w=view_width*2,_h=view_height*2,_reset=false,
        _requested_main=scrNTTEFullVisualQuality("main"),_requested_minor=scrNTTEFullVisualQuality("minor"),
        _retry_scale=ntte_full_explicit_mask ? power(0.5,ntte_full_ios_surface_retry):1,
        _main=scrNTTEFullIOSSurfaceScale(_w,_h,_requested_main,ntte_full_explicit_mask)*_retry_scale,
        _minor=scrNTTEFullIOSSurfaceScale(_w,_h,_requested_minor,ntte_full_explicit_mask)*_retry_scale,
        _sw=max(1,ceil(_w*_main)),_sh=max(1,ceil(_h*_main)),_bw=max(1,ceil(_w*_minor)),_bh=max(1,ceil(_h*_minor)),
        _old_view=matrix_get(matrix_view),_old_projection=matrix_get(matrix_projection),
        _old_world=matrix_get(matrix_world),_old_color=draw_get_color(),_old_alpha=draw_get_alpha(),_old_shader=shader_current()
    if (!surface_exists(ntte_full_surface) || surface_get_width(ntte_full_surface)!=_sw || surface_get_height(ntte_full_surface)!=_sh
        || !surface_exists(ntte_full_wall_top) || surface_get_width(ntte_full_wall_top)!=_sw || surface_get_height(ntte_full_wall_top)!=_sh
        || !surface_exists(ntte_full_wall_bot) || surface_get_width(ntte_full_wall_bot)!=_bw || surface_get_height(ntte_full_wall_bot)!=_bh) {
        if (surface_exists(ntte_full_surface)) surface_free(ntte_full_surface)
        if (surface_exists(ntte_full_wall_top)) surface_free(ntte_full_wall_top)
        if (surface_exists(ntte_full_wall_bot)) surface_free(ntte_full_wall_bot)
        ntte_full_surface=surface_create(_sw,_sh);ntte_full_wall_top=surface_create(_sw,_sh);ntte_full_wall_bot=surface_create(_bw,_bh)
        _reset=true
    }
    ntte_full_effective_main=_main;ntte_full_effective_minor=_minor
    if (!surface_exists(ntte_full_surface) || !surface_exists(ntte_full_wall_top) || !surface_exists(ntte_full_wall_bot)) {
        scrNTTEFullPitTargetFailure("allocate",_sw,_sh);return;
    }
    if(ntte_full_explicit_mask && (!surface_exists(ntte_full_pit_mask)
        || surface_get_width(ntte_full_pit_mask)!=_sw || surface_get_height(ntte_full_pit_mask)!=_sh)) {
        if(surface_exists(ntte_full_pit_mask)) surface_free(ntte_full_pit_mask)
        ntte_full_pit_mask=surface_create(_sw,_sh);_reset=true
    }
    if(ntte_full_explicit_mask && !surface_exists(ntte_full_pit_mask)) {
        scrNTTEFullPitTargetFailure("mask-allocate",_sw,_sh);return;
    }
    if(_reset && ntte_full_explicit_mask)
        scrNTTEFullIOSRenderTrace("trench-created",{requestedMain:_requested_main,requestedMinor:_requested_minor,
            main:_main,minor:_minor,width:_sw,height:_sh,bottomWidth:_bw,bottomHeight:_bh,
            retry:ntte_full_ios_surface_retry})
    if(ntte_full_cached_explicit_mask!=ntte_full_explicit_mask) _reset=true
    ntte_full_cached_explicit_mask=ntte_full_explicit_mask
    gpu_push_state();shader_reset();gpu_set_fog(false,0,0,0);gpu_set_texfilter(false)
    draw_set_color(c_white);draw_set_alpha(1);matrix_set(matrix_world,matrix_build_identity())
    gpu_set_colorwriteenable(true,true,true,true);gpu_set_blendmode(bm_normal)
    camera_set_view_pos(ntte_full_camera,_vx,_vy); camera_set_view_size(ntte_full_camera,_w,_h)
    var _pits=scrNTTERefSprite("FloorTrenchB")
    if (_reset || global.ntte_full_trench_pit_dirty || ntte_full_draw_x!=_vx || ntte_full_draw_y!=_vy) {
        ntte_full_draw_x=_vx; ntte_full_draw_y=_vy; global.ntte_full_trench_pit_dirty=false
        // iOS keeps this mask immutable. Nested spark/actor rendering cannot
        // turn its empty land/background pixels into an opaque black overlay.
        if(!scrNTTEFullPitTarget(ntte_full_explicit_mask ? ntte_full_pit_mask:ntte_full_surface)) {
        scrNTTEFullPitDrawAbort(_old_world,_old_view,_old_projection,_old_color,_old_alpha,_old_shader);return;
    }
        camera_apply(ntte_full_camera);draw_clear_alpha(c_black,0)
        with (Floor) if (sprite_index==_pits && visible) draw_self()
        gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
        with (Floor) if (sprite_index!=_pits && visible && depth<=8) draw_self()
        gpu_set_blendmode(bm_normal); surface_reset_target()
        var _surfaces=[ntte_full_wall_top,ntte_full_wall_bot],
            _sprites=[[scrNTTERefSprite("PitTop"),scrNTTERefSprite("PitSmallTop")],
                [scrNTTERefSprite("PitBot"),scrNTTERefSprite("PitSmallBot"),scrNTTERefSprite("Pit"),scrNTTERefSprite("PitSmall")]]
        for(var _i=0;_i<2;++_i) {
            if(!scrNTTEFullPitTarget(_surfaces[_i])) {
        scrNTTEFullPitDrawAbort(_old_world,_old_view,_old_projection,_old_color,_old_alpha,_old_shader);return;
    }
            camera_apply(ntte_full_camera);draw_clear_alpha(c_black,0)
            var _parts=_sprites[_i]
            for(var _j=0;_j<array_length(_parts);_j+=2) {
                var _normal=_parts[_j],_small=_parts[_j+1]
                with (Floor) if (object_index==Floor && sprite_index!=_pits) draw_sprite(_normal,image_index,x,y)
                with (Wall) if (sprite_index!=_pits) draw_sprite(_small,image_index,x,y)
                with (FloorExplo) if (sprite_index!=_pits) draw_sprite(_small,image_index,x,y)
            }
            surface_reset_target()
        }
    }
    if(!scrNTTEFullPitTarget(ntte_full_surface)) {
        scrNTTEFullPitDrawAbort(_old_world,_old_view,_old_projection,_old_color,_old_alpha,_old_shader);return;
    }
    camera_apply(ntte_full_camera)
    if(ntte_full_explicit_mask) draw_clear_alpha(c_black,1)
    // Preserve the cached pit mask through blending. Keeping alpha writes
    // disabled across nested iOS render targets can lose the mask and leave
    // an opaque black rectangle over Floor (depth10), below Wall (depth0).
    gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_zero,bm_one)
    draw_set_color(c_black); draw_rectangle(_vx,_vy,_vx+_w,_vy+_h,false); draw_set_color(c_white)
    scrNTTEFullPitSparkComposite(_vx,_vy,_w,_h)
    scrNTTEFullPitArmOutlines()
    with (NTTEFullPitSquid) scrNTTEFullPitSquidDraw()
    with (NTTEFullPitSquidDeath) scrNTTEFullPitSquidDeathDraw()
    draw_surface_ext(ntte_full_wall_bot,_vx,_vy,1/_minor,1/_minor,0,c_white,1)
    with (NTTEFullWantEel) scrNTTEFullWantEelDraw()
    scrNTTEFullTrenchProtoPitDraw()
    with (NTTEFullPitSink) draw_self()
    draw_surface_ext(ntte_full_wall_top,_vx,_vy,1/_main,1/_main,0,c_white,1)
    shader_reset();gpu_set_fog(false,0,0,0)
    var _present=ntte_full_explicit_mask && shader_is_compiled(shNTTEFullPitPresent)
    if(ntte_full_explicit_mask && !_present) {
        // A failed optional shader must still expose land: restore immutable
        // alpha after ALL nested targets, then use the fog-disabled default.
        gpu_set_blendmode_ext_sepalpha(bm_zero,bm_one,bm_one,bm_zero)
        draw_surface_ext(ntte_full_pit_mask,_vx,_vy,1/_main,1/_main,0,c_white,1)
    }
    surface_reset_target();matrix_set(matrix_world,_old_world)
    matrix_set(matrix_view,_old_view);matrix_set(matrix_projection,_old_projection)
    gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_inv_src_alpha)
    if(_present) {
        shader_set(shNTTEFullPitPresent)
        texture_set_stage(shader_get_sampler_index(shNTTEFullPitPresent,"pitMask"),surface_get_texture(ntte_full_pit_mask))
    }
    draw_surface_ext(ntte_full_surface,_vx,_vy,1/_main,1/_main,0,c_white,1)
    shader_reset();gpu_pop_state()
    if(_old_shader>=0) shader_set(_old_shader);else shader_reset()
    draw_set_color(_old_color);draw_set_alpha(_old_alpha)
}

// Bind failures must not clear the enclosing game framebuffer.
function scrNTTEFullPitTarget(_surface) {
    ntte_full_ios_target_attempts++
    if(ntte_full_ios_force_target_failure) {
        scrNTTEFullPitTargetFailure("fixture",surface_get_width(_surface),surface_get_height(_surface));return false;
    }
    if(!scrNTTEFullIOSSurfaceTarget(_surface)) {
        scrNTTEFullPitTargetFailure("bind",surface_get_width(_surface),surface_get_height(_surface));return false;
    }
    return true;
}
function scrNTTEFullPitTargetFailure(_reason,_w,_h) {
    ntte_full_ios_target_failures++
    if(ntte_full_explicit_mask)
        ntte_full_ios_surface_retry=min(4,ntte_full_ios_surface_retry+1)
    ntte_full_draw_x=-1;ntte_full_draw_y=-1
    global.ntte_full_trench_pit_dirty=true
    if(ntte_full_explicit_mask && (ntte_full_ios_target_failures<=3 || ntte_full_ios_target_failures mod 60==0))
        scrNTTEFullIOSRenderTrace("trench-target",{reason:_reason,width:_w,height:_h,
            failures:ntte_full_ios_target_failures,retry:ntte_full_ios_surface_retry,
            main:ntte_full_effective_main,minor:ntte_full_effective_minor,target:surface_get_target()})
}
function scrNTTEFullPitDrawAbort(_world,_view,_projection,_color,_alpha,_shader) {
    gpu_pop_state()
    matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
    if(_shader>=0) shader_set(_shader);else shader_reset()
    draw_set_color(_color);draw_set_alpha(_alpha)
}

// Original trench.area pit-layer statue rendering. The native foreground draw
// remains visible above the pit mask; these longer original sprites extend down
// into the masked pit behind the wall tops.
function scrNTTEFullTrenchProtoPitDraw() {
    with (ProtoStatue) if (scrNTTEFullTrenchPitGet(x,bbox_bottom-1)) {
        spr_shadow=-1
        draw_sprite(scrNTTERefSprite(sprite_index==spr_hurt ? "PStatTrenchHurt":"PStatTrenchIdle"),image_index,x,y)
        draw_sprite(scrNTTERefSprite("PStatTrenchLights"),anim,x,y)
    }
    with (Corpse) if (sprite_index==sprPStatDead && scrNTTEFullTrenchPitGet(x,bbox_bottom-1)) {
        draw_sprite_ext(scrNTTERefSprite("PStatTrenchIdle"),image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        if (place_meeting(x,y,Portal)) {
            var _portal=instance_nearest(x,y,Portal),_spr=scrNTTERefSprite("PStatTrenchLights"),_img=0
            if (instance_exists(_portal)) switch(_portal.sprite_index) {
                case sprPortalSpawn:
                case sprProtoPortal: _img=(sprite_get_number(_spr)-1)-2+2*sin(current_frame/16); break
                case sprProtoPortalDisappear: _img=(sprite_get_number(_spr)-1)*(1-_portal.image_index/_portal.image_number); break
            }
            if (_img>0) draw_sprite_ext(_spr,_img,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        }
    }
}
