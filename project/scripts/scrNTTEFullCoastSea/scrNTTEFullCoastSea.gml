// Original coast.area917..1468. UNREGISTERED until constructor/lifecycle batch
// and native visual fixtures are complete. Native offscreen captures dispatch
// actual Draw events without temporarily clearing the application's screen.
function scrNTTEFullCoastSeaCreate() {
    depth=20; wave=0; wave_dis=6; wave_ang=0; flash=0
    ntte_coast_camera=camera_create_view(0,0,1,1,0,noone,-1,-1,-1,-1)
    ntte_coast_surfaces=[]
    repeat(8) array_push(ntte_coast_surfaces,{surf:-1,w:1,h:1,scale:1,x:0,y:0,reset:true})
    ntte_coast_floor_count=-1; ntte_coast_floor_min=0; ntte_coast_draw_ready=false
    ntte_coast_target_active=false
    // The retained iOS runner needs explicit texture-alpha preservation.
    // Keep Android/desktop on their already-working source compositor.
    ntte_coast_opaque_output=(os_type==os_ios)
    ntte_coast_cached_opaque=undefined;ntte_coast_swimmer_count=0
    ntte_coast_safe_factor=1;ntte_coast_fixture_reject_target=false;ntte_coast_frame_fallback=false
}
function scrNTTEFullCoastSeaEnsure() {
    if(!instance_exists(NTTEFullCoastSea)) instance_create(0,0,NTTEFullCoastSea)
    if(!instance_exists(NTTEFullCoastSeaTop)) instance_create(0,0,NTTEFullCoastSeaTop)
    if(!instance_exists(NTTEFullCoastSeaVisible)) instance_create(0,0,NTTEFullCoastSeaVisible)
    var _sea=instance_find(NTTEFullCoastSea,0)
    _sea.flash=0; _sea.ntte_coast_surfaces[0].reset=true
    return _sea
}
function scrNTTEFullCoastSeaCleanup() {
    for(var _i=0;_i<array_length(ntte_coast_surfaces);++_i) {
        var _s=ntte_coast_surfaces[_i]
        if(surface_exists(_s.surf)) surface_free(_s.surf)
    }
    if(ntte_coast_camera>=0) camera_destroy(ntte_coast_camera)
    if(instance_exists(GameCont)) scrNTTEFullCoastVisible(true)
}
function scrNTTEFullCoastSurfaceEnsure(_s,_w,_h,_scale) {
    _scale=scrNTTEFullIOSSurfaceScale(_w,_h,_scale,ntte_coast_opaque_output)*ntte_coast_safe_factor
    var _sw=max(1,ceil(_w*_scale)),_sh=max(1,ceil(_h*_scale))
    if(!surface_exists(_s.surf) || surface_get_width(_s.surf)!=_sw || surface_get_height(_s.surf)!=_sh) {
        if(surface_exists(_s.surf)) surface_free(_s.surf)
        _s.surf=surface_create(_sw,_sh); _s.reset=true
    }
    _s.w=_w; _s.h=_h; _s.scale=_scale
    return surface_exists(_s.surf)
}
function scrNTTEFullCoastSurfaceTarget(_s) {
    if(ntte_coast_target_active) {surface_reset_target();ntte_coast_target_active=false}
    if(ntte_coast_fixture_reject_target || !scrNTTEFullIOSSurfaceTarget(_s.surf)) {
        ntte_coast_fixture_reject_target=false
        throw {ntte_coast_target_failed:true,surface:_s.surf,width:_s.w,height:_s.h,scale:_s.scale};
    }
    ntte_coast_target_active=true
    camera_set_view_pos(ntte_coast_camera,_s.x,_s.y)
    camera_set_view_size(ntte_coast_camera,_s.w,_s.h)
    camera_apply(ntte_coast_camera)
    matrix_set(matrix_world,matrix_build_identity())
}
function scrNTTEFullCoastSurfaceDraw(_s,_dx=0,_dy=0) {
    draw_surface_ext(_s.surf,_s.x+_dx,_s.y+_dy,1/_s.scale,1/_s.scale,0,c_white,draw_get_alpha())
}
// iOS surface presentation never sends transparent texels through fog.
// The no-custom-shader fallback disables fog too; it uses vertex tint only.
function scrNTTEFullCoastSurfacePresent(_s,_tint=-1,_row=undefined) {
    var _shader=shader_current(),_vertex=c_white
    gpu_push_state()
    if(ntte_coast_opaque_output) {
        gpu_set_fog(false,0,0,0)
        if(shader_is_compiled(shNTTEFullCoastPresent)) {
            shader_set(shNTTEFullCoastPresent)
            shader_set_uniform_f(shader_get_uniform(shNTTEFullCoastPresent,"waterTint"),
                color_get_red(_tint)/255,color_get_green(_tint)/255,color_get_blue(_tint)/255,_tint>=0 ? 1:0)
        } else {
            shader_reset()
            if(_tint>=0) _vertex=_tint
        }
    } else if(_tint>=0) gpu_set_fog(true,_tint,0,0)
    if(is_undefined(_row))
        draw_surface_ext(_s.surf,_s.x,_s.y,1/_s.scale,1/_s.scale,0,_vertex,draw_get_alpha())
    else
        draw_surface_part_ext(_s.surf,0,(_row-_s.y)*_s.scale-1,_s.w*_s.scale,1,
            _s.x,_row,1/_s.scale,max(1,_s.scale)/_s.scale,_vertex,draw_get_alpha())
    gpu_pop_state()
    if(_shader>=0) shader_set(_shader);else shader_reset()
}
function scrNTTEFullCoastDrawTargetRestore(_state) {
    // Each target push has one pop, keeping the caller's actual target intact.
    if(ntte_coast_target_active) { surface_reset_target(); ntte_coast_target_active=false }
    matrix_set(matrix_world,_state.world); matrix_set(matrix_view,_state.view); matrix_set(matrix_projection,_state.projection)
    // Output is composited again by the mobile runner. Normal blending squares
    // source alpha and can make even an opaque sea translucent against black.
    // Keep source-over alpha here; internal swimmer captures retain their
    // original normal blending / partial-unblend math.
    gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_inv_src_alpha)
}
function scrNTTEFullCoastDrawState() {
    return {target:surface_get_target(),world:matrix_get(matrix_world),view:matrix_get(matrix_view),
        projection:matrix_get(matrix_projection),color:draw_get_color(),alpha:draw_get_alpha(),shader:shader_current()}
}
function scrNTTEFullCoastFloorCache(_floor,_trans) {
    var _gw=view_width,_gh=view_height,_fx=floor(view_xview/_gw)*_gw-32,_fy=floor(view_yview/_gh)*_gh-32,
        _first=instance_find(Floor,0),_count=instance_number(Floor),
        _invalid=_floor.reset || _floor.x!=_fx || _floor.y!=_fy || _count!=ntte_coast_floor_count
    if(instance_exists(_first) && ntte_coast_floor_min<_first.id) _invalid=true
    if(!_invalid) return;
    _floor.reset=false; _floor.x=_fx; _floor.y=_fy; _trans.reset=true
    ntte_coast_floor_count=_count
    var _floors=scrNTTEFullInstances(Floor),_max=0
    for(var _i=0;_i<array_length(_floors);++_i) _max=max(_max,_floors[_i].id)
    ntte_coast_floor_min=_max
    scrNTTEFullCoastSurfaceTarget(_floor); draw_clear_alpha(c_black,0)
    var _seen=scrNTTEFullRectInstances(_fx,_fy,_fx+_floor.w,_fy+_floor.h,Floor),_spr=scrNTTERefSprite("FloorCoast")
    // Native source order draws real Coast floors first, then alternate masks.
    for(var _pass=0;_pass<2;++_pass) for(var _i=0;_i<array_length(_seen);++_i) with(_seen[_i]) if(visible) {
        var _same=sprite_index==_spr
        if(_same!=(_pass==0)) continue
        var _previous=sprite_index
        if(!_same && mask_index==mskFloor) sprite_index=_spr
        draw_self(); sprite_index=_previous
    }
}
function scrNTTEFullCoastTransitionCache(_floor,_trans) {
    _trans.x=_floor.x; _trans.y=_floor.y
    if(ntte_coast_cached_opaque!=ntte_coast_opaque_output) _trans.reset=true
    if(!_trans.reset) return;
    _trans.reset=false;ntte_coast_cached_opaque=ntte_coast_opaque_output
    scrNTTEFullCoastSurfaceTarget(_trans)
    if(ntte_coast_opaque_output) {
        // Cache an opaque seabed, not a second transparent floor copy. Draw
        // the identical source sprites at the identical nine offsets. This
        // removes transparent-target alpha from the sand expansion entirely.
        draw_clear_alpha(scrAreaGetBackroundColor(scrNTTEFullAreaId("coast")),1)
        var _seen=scrNTTEFullRectInstances(_floor.x,_floor.y,_floor.x+_floor.w,_floor.y+_floor.h,Floor),
            _coast=scrNTTERefSprite("FloorCoast")
        for(var _copy=-1;_copy<8;++_copy) {
            var _dx=_copy<0 ? 0:lengthdir_x(32,_copy*45),_dy=_copy<0 ? 0:lengthdir_y(32,_copy*45)
            for(var _pass=0;_pass<2;++_pass) for(var _i=0;_i<array_length(_seen);++_i) with(_seen[_i]) if(visible) {
                var _same=sprite_index==_coast
                if(_same!=(_pass==0)) continue
                var _spr=(!_same && mask_index==mskFloor) ? _coast:sprite_index
                draw_sprite_ext(_spr,image_index,x+_dx,y+_dy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
            }
        }
    } else {
        draw_clear_alpha(c_black,0)
        scrNTTEFullCoastSurfaceDraw(_floor)
        for(var _dir=0;_dir<360;_dir+=45)
            scrNTTEFullCoastSurfaceDraw(_floor,lengthdir_x(32,_dir),lengthdir_y(32,_dir))
    }
    var _floors=scrNTTEFullRectInstances(_trans.x-32,_trans.y-32,_trans.x+32+_trans.w,_trans.y+32+_trans.h,Floor),
        _hidden=[],_masks=[],_spr=scrNTTERefSprite("FloorCoast")
    with(Floor) if(!visible) { array_push(_hidden,id); array_push(_masks,mask_index); mask_index=mskNone }
    for(var _dir=0;_dir<360;_dir+=90) {
        var _ox=lengthdir_x(32,_dir),_oy=lengthdir_y(32,_dir)
        for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) if(visible) {
            for(var _off=1;_off<=5;++_off) if(place_meeting(x+_ox*_off,y+_oy*_off,Floor)) {
                while(_off>=2) {
                    var _xx=x+_ox*_off,_yy=y+_oy*_off
                    draw_sprite(_spr,(_xx+_yy)/32,_xx,_yy); --_off
                }
                break;
            }
        }
    }
    for(var _i=0;_i<array_length(_hidden);++_i) if(instance_exists(_hidden[_i])) _hidden[_i].mask_index=_masks[_i]
    with(Detail) if(visible && depth==21) draw_self()
}
function scrNTTEFullCoastBottomsDraw() {
    with(NTTEFullCoastDecal) if(visible) {
        var _hurt=sprite_index==spr_hurt && image_index<1
        if(_hurt) gpu_set_fog(true,image_blend,0,0)
        draw_sprite_ext(spr_bott,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        if(_hurt) gpu_set_fog(false,0,0,0)
    }
    with(NTTEFullCoastDecalCorpse) if(visible)
        draw_sprite_ext(spr_bott,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
    gpu_set_fog(true,make_color_rgb(44,37,122),0,0)
    with(NTTEFullPalanking) if(visible)
        draw_sprite_ext(spr_bott,image_index,x,y-z,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    with(NTTEFullCreature) if(visible)
        draw_sprite_ext(spr_bott,image_index,x,y,image_xscale*right,image_yscale,image_angle,image_blend,image_alpha)
    gpu_set_fog(false,0,0,0)
}
function scrNTTEFullCoastSwimCapture(_bottom,_top,_sub,_capture) {
    var _swimmers=scrNTTEFullValue(GameCont,"ntte_sea_inst",[]),_visible=[],_renderer=id
    for(var _i=0;_i<array_length(_swimmers);++_i) {
        var _v=_swimmers[_i]
        if(instance_exists(_v) && _v.wading>0 && _v.bbox_left<view_xview+view_width+24 && _v.bbox_right>view_xview-24
            && _v.bbox_top<view_yview+view_height+24 && _v.bbox_bottom>view_yview-24) array_push(_visible,_v)
    }
    ntte_coast_swimmer_count=array_length(_visible)
    if(ntte_coast_swimmer_count==0) return;
    for(var _i=0;_i<array_length(_visible);++_i) with(_visible[_i]) {
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_capture)
        draw_clear_alpha(c_black,0)
        if(scrNTTEFullCoastObjectHasDraw(object_index)) event_perform(ev_draw,0)
        else draw_self()
        var _previous_mask=mask_index
        mask_index=sprite_index
        try {
        var _bbox_bottom=bbox_bottom-1,_bbox_width=bbox_right-bbox_left,_bbox_height=bbox_bottom-bbox_top,
            _wh=2+(wading-16)*0.2,_wh_max=min(6,round(_bbox_bottom-y)-2)
        if(_wh>_wh_max && (!instance_is(id,Player) || !instance_exists(Portal))) _wh=_wh_max
        if(wading_wave>0 && (speed==0 || !instance_is(id,hitme))) _wh+=min(wading/sprite_height,2)*sin(wading_wave)
        if(wading_sink) _wh+=wading_sink
        // Source bottom screenshot accumulates each whole actual Draw event.
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_bottom)
        draw_set_alpha(wading_sink ? 1-wading_sink/abs(sprite_height):1)
        scrNTTEFullCoastSurfaceDraw(_capture); draw_set_alpha(1)
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_sub)
        gpu_set_blendmode_ext(bm_one,bm_zero); scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
        var _cut_y=_bbox_bottom-_wh
        draw_sprite_ext(scrNTTERefSprite("WaterGradient"),0,x,_cut_y,(_bbox_width+40)/128,(_bbox_height+40)/128,0,c_white,1)
        if(wading_sink && _wh>_bbox_height/1.5) {
            draw_set_alpha(wading_sink/abs(sprite_height)); draw_rectangle(_sub.x,_sub.y,_sub.x+_sub.w,_sub.y+_sub.h,false); draw_set_alpha(1)
        }
        gpu_set_blendmode(bm_normal)
        with(_renderer) scrNTTEFullCoastSurfaceTarget(_top)
        draw_set_alpha(0.4)
        with(_renderer) scrNTTEFullCoastSurfacePresent(_sub,c_white,_cut_y)
        draw_set_alpha(1);scrNTTEFullCoastSurfaceDraw(_sub)
        } finally {mask_index=_previous_mask}
    }
    var _surfaces=[_bottom,_top]
    for(var _i=0;_i<2;++_i) scrNTTEFullCoastUnblendSurface(_surfaces[_i],_capture)
}
function scrNTTEFullCoastUnblendSurface(_s,_capture) {
    // Source Unblend[2] sets blendPower=1/pow(2,2)=1/4. Copy through scratch
    // to avoid sampling the active render target. The scratch is minor quality
    // as in CoastSwimScreen, including while processing a main-quality top.
    scrNTTEFullCoastSurfaceTarget(_capture);draw_clear_alpha(c_black,0)
    gpu_set_blendmode_ext(bm_one,bm_zero)
    var _shader=scrNTTEFullSourceUnblendBegin(2)
    if(_shader) {
        scrNTTEFullCoastSurfaceDraw(_s);shader_reset()
        scrNTTEFullCoastSurfaceTarget(_s);scrNTTEFullCoastSurfaceDraw(_capture)
    }
    else {
        // Original partial-unblend copies the unchanged screen once with
        // inv-src-alpha/one, then three more times with alpha writes only.
        scrNTTEFullCoastSurfaceDraw(_s)
        scrNTTEFullCoastSurfaceTarget(_s)
        gpu_set_blendmode_ext(bm_inv_src_alpha,bm_one)
        scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_colorwriteenable(false,false,false,true)
        repeat(3) scrNTTEFullCoastSurfaceDraw(_capture)
        gpu_set_colorwriteenable(true,true,true,true)
    }
    gpu_set_blendmode(bm_normal)
    return _shader;
}
function scrNTTEFullCoastFoamRaw(_floor,_raw) {
    scrNTTEFullCoastSurfaceTarget(_raw);draw_clear_alpha(c_black,0)
    scrNTTEFullCoastSurfacePresent(_floor,c_white)
    gpu_set_fog(true,c_white,0,0)
    with(NTTEFullPalanking) if(visible && z<=4 && !place_meeting(x,y,Floor))
        draw_sprite_ext(spr_foam,image_index,x,y,image_xscale*right,image_yscale,0,c_white,1)
    with(NTTEFullCreature) if(visible)
        draw_sprite_ext(spr_foam,image_index,x,y,image_xscale*right,image_yscale,image_angle,c_white,1)
    with(NTTEFullCoastDecal) if(visible)
        draw_sprite_ext(spr_foam,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,1)
    with(NTTEFullCoastDecalCorpse) if(visible)
        draw_sprite_ext(spr_foam,image_index,x,y,image_xscale,image_yscale,image_angle,c_white,1)
    gpu_set_fog(false,0,0,0)
}
function scrNTTEFullCoastFoam(_floor,_waves,_raw) {
    var _inner=(wave_dis+0.1)*cos((wave mod 40)*(pi/40)+pi),_outer=_inner+min(wave_dis-_inner,_inner)
    if(_outer>_inner && _outer>0) {
        gpu_set_blendmode(bm_normal)
        scrNTTEFullCoastFoamRaw(_floor,_raw)
        scrNTTEFullCoastSurfaceTarget(_waves); draw_clear_alpha(c_black,0)
        var _radii=[_outer,_inner]
        for(var _i=0;_i<2;++_i) {
            for(var _ang=wave_ang;_ang<wave_ang+360;_ang+=45)
                scrNTTEFullCoastSurfaceDraw(_raw,lengthdir_x(_radii[_i],_ang),lengthdir_y(_radii[_i],_ang))
            gpu_set_blendmode(bm_subtract)
        }
        gpu_set_blendmode(bm_normal)
        return true;
    }
    wave_dis=round(5.5+0.5*sin(wave/200)+random(1)); wave_ang=round(random(45)/15)*15
    return false;
}
function scrNTTEFullCoastFlash() {
    if(!instance_exists(Portal)) return;
    draw_set_color(c_white); draw_set_alpha((flash<=30 ? 0.3:0.15)*(1-(flash mod 300)/30))
    draw_rectangle(view_xview,view_yview,view_xview+view_width,view_yview+view_height,false); draw_set_alpha(1)
    if(flash mod 300<timescale) {
        snd_play(sndOasisHorn,0.5,2); snd_play(sndOasisExplosion,1+random(1),flash<=0 ? 1:0.4)
        scr_screenshake(8)
        with(Floor) if(random(5)<1) for(var _dir=0;_dir<360;_dir+=45) {
            var _xx=x+lengthdir_x(32,_dir),_yy=y+lengthdir_y(32,_dir)
            if(!position_meeting(_xx,_yy,Floor)) repeat(irandom_range(3,6)) {
                if(random(6+instance_number(AcidStreak))<1) {
                    snd_play_hit(sndOasisCrabAttack,0.2)
                    var _streak=scrNTTEFullSystemsCreate("WaterStreak",_xx+16+orandom(8),_yy+16+orandom(8))
                    with(_streak) motion_set(_dir+orandom(20),4*timescale)
                }
                else instance_create(_xx+random(32),_yy+random(32),NTTEFullSweat)
            }
        }
        with(Portal) repeat(3) scrFX(x,y,Dust,random(360),3)
    }
    flash+=timescale
}
function scrNTTEFullCoastSeaBackdrop(_w,_h) {
    // The drawn scene remains Coast during a preassigned route to a Vault.
    draw_set_color(scrAreaGetBackroundColor(scrNTTEFullAreaId("coast")));draw_set_alpha(1)
    draw_rectangle(view_xview,view_yview,view_xview+_w,view_yview+_h,false)
    draw_set_color(c_white)
}
function scrNTTEFullCoastSeaDraw() {
    ntte_coast_draw_ready=false;ntte_coast_frame_fallback=false
    if(lockstep_stop) return;
    if(!scrNTTEFullCoastActive() || instance_exists(GenCont)) { scrNTTEFullCoastVisible(true); return }
    var _w=view_width,_h=view_height,_main=scrNTTEFullVisualQuality("main"),_minor=scrNTTEFullVisualQuality("minor"),
        _state=scrNTTEFullCoastDrawState()
    gpu_push_state();shader_reset();gpu_set_texfilter(false);gpu_set_fog(false,0,0,0)
    gpu_set_colorwriteenable(true,true,true,true);gpu_set_blendmode(bm_normal)
    draw_set_color(c_white);draw_set_alpha(1)
    try {
    scrNTTEFullIOSSurfaceProbe()
    var _sizes=[[2*(_w+32),2*(_h+32),_minor],[2*(_w+32),2*(_h+32),_minor],
        [_w+16,_h+16,_minor],[_w+16,_h+16,_minor],[_w,_h,_minor],[_w,_h,_main],[_w,_h,_main],[_w,_h,_minor]]
    for(var _i=0;_i<8;++_i) if(!scrNTTEFullCoastSurfaceEnsure(ntte_coast_surfaces[_i],_sizes[_i][0],_sizes[_i][1],_sizes[_i][2])) {
        throw {ntte_coast_target_failed:true,surface:-1,width:_sizes[_i][0],height:_sizes[_i][1],scale:_sizes[_i][2]};
    }
    scrNTTEFullIOSRenderTrace("coast-allocations",{compat:ntte_coast_opaque_output,requested:[_main,_minor],
        floor:[surface_get_width(ntte_coast_surfaces[0].surf),surface_get_height(ntte_coast_surfaces[0].surf)],
        top:[surface_get_width(ntte_coast_surfaces[5].surf),surface_get_height(ntte_coast_surfaces[5].surf)],
        shader:shader_is_compiled(shNTTEFullCoastPresent)})
    var _floor=ntte_coast_surfaces[0],_trans=ntte_coast_surfaces[1],
        _waves=ntte_coast_surfaces[2],_raw=ntte_coast_surfaces[3],_bottom=ntte_coast_surfaces[4],
        _top=ntte_coast_surfaces[5],_sub=ntte_coast_surfaces[6],_capture=ntte_coast_surfaces[7]
    wave+=timescale
    scrNTTEFullCoastVisible(false)
    scrNTTEFullCoastFloorCache(_floor,_trans); scrNTTEFullCoastTransitionCache(_floor,_trans)
    // Prepare every offscreen pass before writing any of the final layers to
    // the enclosing target. In particular, do not leave base/shore pixels on
    // that target across the many per-swimmer target changes on mobile GPUs.
    gpu_set_blendmode(bm_normal)
    for(var _i=4;_i<8;++_i) {
        var _s=ntte_coast_surfaces[_i]; _s.x=view_xview; _s.y=view_yview
        scrNTTEFullCoastSurfaceTarget(_s); draw_clear_alpha(c_black,0)
    }
    scrNTTEFullCoastSwimCapture(_bottom,_top,_sub,_capture)
    _waves.x=view_xview-8; _waves.y=view_yview-8; _raw.x=_waves.x; _raw.y=_waves.y
    var _foam=scrNTTEFullCoastFoam(_floor,_waves,_raw)
    // A single uninterrupted output sequence preserves the original source
    // order, without output-to-capture-to-output interleaving. No render-target
    // changes are permitted between this restore and the final flash.
    scrNTTEFullCoastDrawTargetRestore(_state)
    shader_reset();gpu_set_fog(false,0,0,0)
    scrNTTEFullCoastSeaBackdrop(_w,_h)
    scrNTTEFullCoastSurfacePresent(_trans);scrNTTEFullCoastBottomsDraw()
    if(ntte_coast_swimmer_count>0) scrNTTEFullCoastSurfacePresent(_bottom,make_color_rgb(44,37,122))
    draw_set_color(scrAreaGetBackroundColor(scrNTTEFullAreaId("coast"))); draw_set_alpha(0.6)
    draw_rectangle(view_xview,view_yview,view_xview+_w,view_yview+_h,false)
    draw_set_color(c_white); draw_set_alpha(0.4)
    draw_sprite_tiled(scrNTTERefSprite("CoastTrans"),0,sin(wave*0.02)*4,sin(wave*0.05)*2); draw_set_alpha(1)
    if(_foam) scrNTTEFullCoastSurfacePresent(_waves)
    scrNTTEFullCoastFlash()
    ntte_coast_draw_ready=true
    } catch(_render_error) {
        if(!is_struct(_render_error) || !variable_struct_exists(_render_error,"ntte_coast_target_failed")) throw _render_error;
        scrNTTEFullCoastDrawTargetRestore(_state)
        shader_reset();gpu_set_fog(false,0,0,0);draw_set_color(c_white);draw_set_alpha(1)
        // Allocation/bind failure must not black-clear the caller or conceal
        // all swimmers. Draw the source seabed directly while retrying smaller
        // caches next frame; world and gameplay coordinates never change.
        scrNTTEFullCoastDirectFallback(_w,_h)
        for(var _i=0;_i<8;++_i) ntte_coast_surfaces[_i].reset=true
        scrNTTEFullCoastVisible(true);ntte_coast_frame_fallback=true
        if(ntte_coast_opaque_output) ntte_coast_safe_factor=max(0.125,ntte_coast_safe_factor/2)
        scrNTTEFullIOSRenderTrace("coast-bind-failure",_render_error)
    } finally {
        scrNTTEFullCoastDrawTargetRestore(_state)
        gpu_pop_state();draw_set_color(_state.color);draw_set_alpha(_state.alpha)
        if(_state.shader>=0) shader_set(_state.shader);else shader_reset()
    }
}
// A safe frame after rejected allocation uses original source sprite stamps,
// not a full-screen framebuffer with uncertain target/alpha state.
function scrNTTEFullCoastDirectFallback(_w,_h) {
    scrNTTEFullCoastSeaBackdrop(_w,_h)
    var _floors=scrNTTEFullRectInstances(view_xview-64,view_yview-64,view_xview+_w+64,view_yview+_h+64,Floor),
        _coast=scrNTTERefSprite("FloorCoast")
    for(var _copy=-1;_copy<8;++_copy) {
        var _dx=_copy<0 ? 0:lengthdir_x(32,_copy*45),_dy=_copy<0 ? 0:lengthdir_y(32,_copy*45)
        for(var _pass=0;_pass<2;++_pass) for(var _i=0;_i<array_length(_floors);++_i) with(_floors[_i]) if(visible) {
            var _same=sprite_index==_coast
            if(_same!=(_pass==0)) continue;
            var _spr=(!_same && mask_index==mskFloor) ? _coast:sprite_index
            draw_sprite_ext(_spr,image_index,x+_dx,y+_dy,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
        }
    }
    draw_set_color(scrAreaGetBackroundColor(scrNTTEFullAreaId("coast")));draw_set_alpha(0.6)
    draw_rectangle(view_xview,view_yview,view_xview+_w,view_yview+_h,false)
    draw_set_color(c_white);draw_set_alpha(0.4)
    draw_sprite_tiled(scrNTTERefSprite("CoastTrans"),0,sin(wave*0.02)*4,sin(wave*0.05)*2)
    draw_set_alpha(1)
}
function scrNTTEFullCoastSeaTopDraw() {
    if(!scrNTTEFullCoastActive() || instance_exists(GenCont)) return;
    var _sea=instance_find(NTTEFullCoastSea,0)
    if(instance_exists(_sea) && _sea.ntte_coast_draw_ready && _sea.ntte_coast_swimmer_count>0) {
        gpu_push_state()
        gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_one,bm_inv_src_alpha)
        // Presentation helpers use the owning controller's platform mode.
        with(_sea) scrNTTEFullCoastSurfacePresent(ntte_coast_surfaces[5])
        gpu_pop_state()
    }
}

// NTTE Coast inherited real Draw event registry
function scrNTTEFullCoastObjectHasDraw(_object) {
    switch(_object) {
        case Ally: return true;
        case BackButton: return true;
        case BackCont: return true;
        case Bandit: return true;
        case BanditBoss: return true;
        case BecomeNothing: return true;
        case BigDogMissile: return true;
        case BigMaggot: return true;
        case BigTV: return true;
        case BloodBall: return true;
        case BloodGrenade: return true;
        case BoltStick: return true;
        case BoneFish: return true;
        case BuffGator: return true;
        case ButtonAchievements: return true;
        case ButtonDiscord: return true;
        case CarThrow: return true;
        case CharSelect: return true;
        case ClusterNade: return true;
        case Confetti: return true;
        case ConfettiBall: return true;
        case Crab: return true;
        case CrownGuardian: return true;
        case CrownIcon: return true;
        case CrystalShield: return true;
        case DogGuardian: return true;
        case DrawStats: return true;
        case Dummy: return true;
        case EliteGrunt: return true;
        case EliteInspector: return true;
        case EliteShield: return true;
        case EliteShielder: return true;
        case EnemyLaser: return true;
        case EnemyLightning: return true;
        case ExploFreak: return true;
        case ExploGuardian: return true;
        case Exploder: return true;
        case FastRat: return true;
        case FireBaller: return true;
        case Flare: return true;
        case Freak: return true;
        case FrogQueen: return true;
        case GameOver: return true;
        case GammaGuts: return true;
        case Gator: return true;
        case GatorSmoke: return true;
        case GenCont: return true;
        case GoButton: return true;
        case GoldScorpion: return true;
        case GoldSnowTank: return true;
        case Grenade: return true;
        case Grunt: return true;
        case Guardian: return true;
        case HeavyGrenade: return true;
        case HostileHorror: return true;
        case HyperCrystal: return true;
        case Inspector: return true;
        case InvLaserCrystal: return true;
        case InvSpider: return true;
        case IonBurst: return true;
        case Jock: return true;
        case JockRocket: return true;
        case JungleAssassin: return true;
        case JungleBandit: return true;
        case JungleFly: return true;
        case Laser: return true;
        case LaserCrystal: return true;
        case Last: return true;
        case LastCutscene: return true;
        case LastIntro: return true;
        case LevCont: return true;
        case LightBeam: return true;
        case Lightning: return true;
        case LightningCrystal: return true;
        case LilHunter: return true;
        case LilHunterFly: return true;
        case Logo: return true;
        case Maggot: return true;
        case MaggotSpawn: return true;
        case MainMenuButton: return true;
        case MakeGame: return true;
        case MeleeBandit: return true;
        case Menu: return true;
        case MenuOptions: return true;
        case Mimic: return true;
        case Molefish: return true;
        case Molesarge: return true;
        case NTTEAlbinoBolt: return true;
        case NTTEAlbinoGator: return true;
        case NTTEAlbinoGrenade: return true;
        case NTTEAlert: return true;
        case NTTEAttack: return true;
        case NTTEBabyGator: return true;
        case NTTEBat: return true;
        case NTTEBatScreech: return true;
        case NTTEBeam: return true;
        case NTTEBoneGator: return true;
        case NTTEBoneShard: return true;
        case NTTECamperBandit: return true;
        case NTTECat: return true;
        case NTTECoil: return true;
        case NTTEFullAngler: return true;
        case NTTEFullAnglerGold: return true;
        case NTTEFullAnglerTrailDraw: return true;
        case NTTEFullBabyScorpion: return true;
        case NTTEFullBabyScorpionGold: return true;
        case NTTEFullBanditCamper: return true;
        case NTTEFullBanditHiker: return true;
        case NTTEFullBatBoss: return true;
        case NTTEFullBeetleChest: return true;
        case NTTEFullBigMaggotSpawn: return true;
        case NTTEFullBigPipe: return true;
        case NTTEFullBloomingAssassin: return true;
        case NTTEFullBloomingAssassinHide: return true;
        case NTTEFullBoneRaven: return true;
        case NTTEFullBubbleBomb: return true;
        case NTTEFullBuriedVaultChestDebris: return true;
        case NTTEFullCatBoss: return true;
        case NTTEFullCatBossAttack: return true;
        case NTTEFullCatDoor: return true;
        case NTTEFullCatDoorDebris: return true;
        case NTTEFullCatLight: return true;
        case NTTEFullCharmOutlineDraw: return true;
        case NTTEFullCharmOutlineDrawProbe: return true;
        case NTTEFullChestShop: return true;
        case NTTEFullClamShield: return true;
        case NTTEFullCoastBoss: return true;
        case NTTEFullCoastBossBecome: return true;
        case NTTEFullCoastSea: return true;
        case NTTEFullCoastSeaTop: return true;
        case NTTEFullCoastSeaVisible: return true;
        case NTTEFullCreature: return true;
        case NTTEFullCrystalAlly: return true;
        case NTTEFullCrystalBat: return true;
        case NTTEFullCrystalBrain: return true;
        case NTTEFullCrystalBrainDeath: return true;
        case NTTEFullCrystalClone: return true;
        case NTTEFullCrystalCloneDrawProbe: return true;
        case NTTEFullCrystalHeart: return true;
        case NTTEFullCrystalHeartBullet: return true;
        case NTTEFullCustomPlasma: return true;
        case NTTEFullDiver: return true;
        case NTTEFullDiverLaserDraw: return true;
        case NTTEFullDustLifetimeGenSentinel: return true;
        case NTTEFullEel: return true;
        case NTTEFullFloorReveal: return true;
        case NTTEFullFlySpin: return true;
        case NTTEFullGhost: return true;
        case NTTEFullGull: return true;
        case NTTEFullHammerHeadChest: return true;
        case NTTEFullHammerHeadPickup: return true;
        case NTTEFullHammerShark: return true;
        case NTTEFullHarpoonRope: return true;
        case NTTEFullHarpoonStick: return true;
        case NTTEFullHyperSlashTrail: return true;
        case NTTEFullInvCrystalBat: return true;
        case NTTEFullInvMortar: return true;
        case NTTEFullJelly: return true;
        case NTTEFullJellyElite: return true;
        case NTTEFullLairBorder: return true;
        case NTTEFullLightningDisc: return true;
        case NTTEFullMergedEffectScheduler: return true;
        case NTTEFullMinerBandit: return true;
        case NTTEFullMortar: return true;
        case NTTEFullMortarPlasma: return true;
        case NTTEFullMutantVat: return true;
        case NTTEFullOrchidBall: return true;
        case NTTEFullPalanking: return true;
        case NTTEFullPalankingDie: return true;
        case NTTEFullParrotFeather: return true;
        case NTTEFullPelican: return true;
        case NTTEFullPet: return true;
        case NTTEFullPetGuardianShield: return true;
        case NTTEFullPetRevive: return true;
        case NTTEFullPetWeaponBoss: return true;
        case NTTEFullPetWebDraw: return true;
        case NTTEFullPitRenderer: return true;
        case NTTEFullPitSpark: return true;
        case NTTEFullPitSquid: return true;
        case NTTEFullPitSquidArm: return true;
        case NTTEFullPizzaTV: return true;
        case NTTEFullPopoLaser: return true;
        case NTTEFullPopoSecurity: return true;
        case NTTEFullPortalGuardian: return true;
        case NTTEFullPrompt: return true;
        case NTTEFullPuffer: return true;
        case NTTEFullQuasarBeam: return true;
        case NTTEFullQuasarRing: return true;
        case NTTEFullQuestMergingGlow: return true;
        case NTTEFullQuestTeleporterPad: return true;
        case NTTEFullRedSpider: return true;
        case NTTEFullRogueMissile: return true;
        case NTTEFullSeal: return true;
        case NTTEFullSealAnchor: return true;
        case NTTEFullSealHeavy: return true;
        case NTTEFullSealMine: return true;
        case NTTEFullSludgeDraw: return true;
        case NTTEFullSludgePool: return true;
        case NTTEFullSmallLastBall: return true;
        case NTTEFullSpiderling: return true;
        case NTTEFullSpiritChest: return true;
        case NTTEFullSpiritPickup: return true;
        case NTTEFullSystemGeneratorProbe: return true;
        case NTTEFullTesseract: return true;
        case NTTEFullTesseractArmDeath: return true;
        case NTTEFullTesseractDeath: return true;
        case NTTEFullTesseractStrike: return true;
        case NTTEFullTopObject: return true;
        case NTTEFullTopRaven: return true;
        case NTTEFullTrafficCrab: return true;
        case NTTEFullTrapSpin: return true;
        case NTTEFullTrenchFloorChunk: return true;
        case NTTEFullTrenchLightning: return true;
        case NTTEFullTrident: return true;
        case NTTEFullTridentExtract: return true;
        case NTTEFullTurtleCool: return true;
        case NTTEFullUltraQuasarBeam: return true;
        case NTTEFullUnlockCont: return true;
        case NTTEFullVenomFlak: return true;
        case NTTEFullVlasmaBullet: return true;
        case NTTEFullVlasmaCannon: return true;
        case NTTEFullWallFakeDrawBot: return true;
        case NTTEFullWallFakeDrawTop: return true;
        case NTTEFullWallFakeRevealBot: return true;
        case NTTEFullWallFakeRevealTop: return true;
        case NTTEFullWantEel: return true;
        case NTTEFullWarp: return true;
        case NTTEFullWarpPortal: return true;
        case NTTEFullWepPickupGrounded: return true;
        case NTTEFullWepPickupStick: return true;
        case NTTEFullYetiCrab: return true;
        case NTTEHikerBandit: return true;
        case NTTELightningDisc: return true;
        case NTTEPickup: return true;
        case NTTEScorpionOrb: return true;
        case NTTEShield: return true;
        case Necromancer: return true;
        case Nothing: return true;
        case Nothing2: return true;
        case NothingBeam: return true;
        case NothingInactive: return true;
        case NothingSpiral: return true;
        case Nuke: return true;
        case PauseButton: return true;
        case PauseImage: return true;
        case PlayButton: return true;
        case Player: return true;
        case PopoFreak: return true;
        case PopoNade: return true;
        case PopoShield: return true;
        case PopupText: return true;
        case PortalStrike: return true;
        case ProtoStatue: return true;
        case RadMaggot: return true;
        case RainDrop: return true;
        case Rat: return true;
        case Ratking: return true;
        case RatkingRage: return true;
        case Raven: return true;
        case RavenFly: return true;
        case RhinoFreak: return true;
        case Rocket: return true;
        case Salamander: return true;
        case Scorpion: return true;
        case ScrapBoss: return true;
        case ScrapBossMissile: return true;
        case SentryGun: return true;
        case Shielder: return true;
        case SitDown: return true;
        case SkillIcon: return true;
        case SmallGrenade: return true;
        case Sniper: return true;
        case SnowBot: return true;
        case SnowBotCar: return true;
        case SnowFlake: return true;
        case SnowTank: return true;
        case SodaCan: return true;
        case Spider: return true;
        case SpiralCont: return true;
        case StatChar: return true;
        case SubTopCont: return true;
        case SuperFireBaller: return true;
        case SuperFrog: return true;
        case SuperMimic: return true;
        case SwipeBombingTutorial: return true;
        case TV: return true;
        case TechnoMancer: return true;
        case TopCont: return true;
        case ToxicGrenade: return true;
        case Turret: return true;
        case Turtle: return true;
        case TutorialTarget: return true;
        case UberCont: return true;
        case UltraGrenade: return true;
        case UltraIcon: return true;
        case Van: return true;
        case Vlambeer: return true;
        case WepMimic: return true;
        case WepPickup: return true;
        case Wolf: return true;
        case YVBoss: return true;
    }
    return false;
}
