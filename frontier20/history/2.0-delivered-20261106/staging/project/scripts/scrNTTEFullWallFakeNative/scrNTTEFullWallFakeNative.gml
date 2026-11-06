// tecaves4690..4738 and ntte_end_step5207..5339. Drawing is a separate pass.
function scrNTTEFullWallFakeCreate() {
    name="WallFake"
    mask_index=object_get_mask(Wall)
    var _sprites=scrNTTERefSprite("WallRedFake")
    sprite_index=_sprites[irandom(array_length(_sprites)-1)]
    image_index=0;image_speed=(0.4+0.1*sin(x/16+y/16))*timescale;depth=3;visible=true
    if(solid) {
        solid=false
        var _helper=instance_create(x,y,NTTEFullWallFakeHelper)
        _helper.creator=id;_helper.sprite_index=sprite_index;_helper.image_index=image_index
        _helper.image_speed=image_speed;_helper.image_xscale=image_xscale;_helper.image_yscale=image_yscale
        _helper.image_angle=image_angle;_helper.mask_index=mask_index
    }
    if(!instance_exists(NTTEFullWallFakeController)) instance_create(0,0,NTTEFullWallFakeController)
}
function scrNTTEFullWallFakeHelperCreate() {
    name="WallFakeHelper";sprite_index=object_get_sprite(Wall);mask_index=object_get_mask(Wall)
    visible=false;solid=true;creator=noone
}
function scrNTTEFullWallFakeControllerCreate() {
    ntte_wall_fake_reveal_visible=false;visible=false
    instance_create(0,0,NTTEFullWallFakeDrawBot);instance_create(0,0,NTTEFullWallFakeRevealBot)
    instance_create(0,0,NTTEFullWallFakeDrawTop);instance_create(0,0,NTTEFullWallFakeRevealTop)
}
function scrNTTEFullWallFakeMotionStep(_who,_forward) {
    // Literal telib6348 boolean argument; retain native GML condition semantics.
    with(_who) {
        if(_forward) {
            if(friction!=0 && speed!=0) speed-=min(abs(speed),friction)*sign(speed)
            if(gravity!=0) {hspeed+=lengthdir_x(gravity,gravity_direction);vspeed+=lengthdir_y(gravity,gravity_direction)}
            if(speed!=0) {x+=hspeed;y+=vspeed}
        }
        else {
            if(speed!=0) {y-=vspeed;x-=hspeed}
            if(gravity!=0) {vspeed-=lengthdir_y(gravity,gravity_direction);hspeed-=lengthdir_x(gravity,gravity_direction)}
            if(friction!=0 && speed!=0) speed-=min(abs(speed),-friction)*sign(speed)
        }
    }
}
function scrNTTEFullWallFakeMeetsHelper(_actor,_helpers) {
    var _meeting=false
    with(_actor) {
        for(var _i=0;_i<array_length(_helpers);++_i) if(instance_exists(_helpers[_i])
            && place_meeting(x,y,_helpers[_i])) {_meeting=true;break;}
    }
    return _meeting
}
function scrNTTEFullWallFakeEndStep() {
    if(lockstep_stop) return;
    var _helpers=scrNTTEFullInstances(NTTEFullWallFakeHelper),_walls=scrNTTEFullInstances(NTTEFullWallFake),_inside=[],_visible=false
    for(var _i=array_length(_helpers)-1;_i>=0;--_i) if(!instance_exists(_helpers[_i].creator)) {
        instance_destroy(_helpers[_i]);array_delete(_helpers,_i,1)
    }
    if(array_length(_walls)) {
        for(var _i=0;_i<array_length(_walls);++_i) _walls[_i].visible=true
        var _actors=scrNTTEFullInstances(hitme)
        for(var _i=0;_i<array_length(_actors);++_i)
            if(scrNTTEFullWallFakeMeetsHelper(_actors[_i],_helpers)) array_push(_inside,_actors[_i])
        var _players=scrNTTEFullInstances(Player)
        for(var _i=0;_i<array_length(_players);++_i) {
            var _player=_players[_i]
            if(_player.race==Race.Frog && array_get_index(_inside,_player)<0) {
                scrNTTEFullWallFakeMotionStep(_player,1)
                if(scrNTTEFullWallFakeMeetsHelper(_player,_helpers)) array_push(_inside,_player)
                scrNTTEFullWallFakeMotionStep(_player,-1)
            }
        }
        for(var _i=0;_i<array_length(_helpers);++_i) {
            var _helper=_helpers[_i],_solid=true
            if(array_length(_inside)) with(_helper) {
                if(distance_to_object(hitme)<=32) for(var _j=0;_j<array_length(_inside);++_j) {
                    var _distance=infinity
                    with(_inside[_j]) _distance=distance_to_object(_helper)
                    if(_distance<=32) {_solid=false;break;}
                }
            }
            if(_helper.solid!=_solid) {
                _helper.solid=_solid
                if(instance_exists(_helper.creator)) _helper.creator.mask_index=_solid?_helper.mask_index:mskNone
                else instance_destroy(_helper)
            }
        }
        for(var _i=0;_i<array_length(_players);++_i) {
            var _player=_players[_i],_grow=array_get_index(_inside,_player)>=0,
                _circle=scrNTTEFullValue(_player,"red_wall_fake",0)
            if(_circle>0 || _grow) {
                _player.red_wall_fake=clamp(_circle+(_grow?0.1:-0.1)*timescale,0,1);_visible=true
            }
            else _player.red_wall_fake=0
        }
    }
    else with(Player) red_wall_fake=0
    ntte_wall_fake_reveal_visible=_visible
}

// Source draw_wall_fake5721..5857, mapped to native application-surface copy
// for its RGB-only screenshot. Bottom and top passes own separate masks.
function scrNTTEFullWallFakeDrawCreate(_top,_reveal=false) {
    ntte_wall_fake_top=_top;ntte_wall_fake_reveal=_reveal
    ntte_wall_fake_mask=-1;ntte_wall_fake_capture=-1;ntte_wall_fake_surface=-1
    ntte_wall_fake_surface_x=0;ntte_wall_fake_surface_y=0;ntte_wall_fake_scale=1
    ntte_wall_fake_mask_x=undefined;ntte_wall_fake_mask_y=undefined
    ntte_wall_fake_mask_count=-1;ntte_wall_fake_mask_max=-1
    depth=_top?(_reveal?-6:-5):(_reveal?2:4)
}
function scrNTTEFullWallFakeDrawCleanup() {
    if(surface_exists(ntte_wall_fake_mask)) surface_free(ntte_wall_fake_mask)
    if(surface_exists(ntte_wall_fake_capture)) surface_free(ntte_wall_fake_capture)
    if(surface_exists(ntte_wall_fake_surface)) surface_free(ntte_wall_fake_surface)
    ntte_wall_fake_mask=-1;ntte_wall_fake_capture=-1;ntte_wall_fake_surface=-1
}
function scrNTTEFullWallFakeDrawMask() {
    if(!instance_exists(NTTEFullWallFakeController) || !NTTEFullWallFakeController.ntte_wall_fake_reveal_visible) return;
    var _vx=view_xview,_vy=view_yview,_gw=view_width,_gh=view_height,_scale=scrNTTEFullVisualQuality("minor"),
        _mw=scrNTTEFullQualitySurfaceSize(_gw*2,_scale),_mh=scrNTTEFullQualitySurfaceSize(_gh*2,_scale),
        _cw=scrNTTEFullQualitySurfaceSize(_gw,_scale),_ch=scrNTTEFullQualitySurfaceSize(_gh,_scale),
        _sx=floor(_vx/_gw)*_gw,_sy=floor(_vy/_gh)*_gh,
        _target=surface_get_target(),_screen=surface_get_target(),_camera=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_fog=gpu_get_fog()
    if(_screen<0) _screen=application_surface
    if(!surface_exists(_screen)) return;
    var _rebuild=false
    if(!surface_exists(ntte_wall_fake_mask) || !surface_exists(ntte_wall_fake_surface)
        || surface_get_width(ntte_wall_fake_mask)!=_mw || surface_get_height(ntte_wall_fake_mask)!=_mh
        || surface_get_width(ntte_wall_fake_surface)!=_cw || surface_get_height(ntte_wall_fake_surface)!=_ch) {
        scrNTTEFullWallFakeDrawCleanup()
        ntte_wall_fake_mask=surface_create(_mw,_mh)
        ntte_wall_fake_surface=surface_create(_cw,_ch)
        _rebuild=true
    }
    // Original wall_num / oldest-wall-after-marker invalidation, with a
    // maxWall ID replacing its transient instance_max marker. A partial
    // same-count replacement retains the original cache semantics.
    var _wall_count=instance_number(Wall),_wall_min=infinity,_wall_max=-1
    with(Wall) {_wall_min=min(_wall_min,real(id));_wall_max=max(_wall_max,real(id));}
    if(_sx!=ntte_wall_fake_mask_x || _sy!=ntte_wall_fake_mask_y
        || _wall_count!=ntte_wall_fake_mask_count || (_wall_count>0 && _wall_min>ntte_wall_fake_mask_max)) _rebuild=true
    var _sw=surface_get_width(_screen),_sh=surface_get_height(_screen)
    if(!surface_exists(ntte_wall_fake_capture) || surface_get_width(ntte_wall_fake_capture)!=_sw
        || surface_get_height(ntte_wall_fake_capture)!=_sh) {
        if(surface_exists(ntte_wall_fake_capture)) surface_free(ntte_wall_fake_capture)
        ntte_wall_fake_capture=surface_create(_sw,_sh)
    }
    surface_copy(ntte_wall_fake_capture,0,0,_screen)
    gpu_push_state()
    try {
      draw_set_alpha(1);draw_set_color(c_white);gpu_set_blendmode(bm_normal);gpu_set_fog(false,0,0,0)
      if(_rebuild) {
        surface_set_target(ntte_wall_fake_mask)
        _camera=camera_create_view(_sx,_sy,_gw*2,_gh*2,0,noone,-1,-1,-1,-1);camera_apply(_camera)
        draw_clear_alpha(c_black,0);draw_set_alpha(1);draw_set_color(c_white);gpu_set_fog(false,0,0,0)
        with(NTTEFullWallFake) {
            if(other.ntte_wall_fake_top) { if(sprite_exists(topspr)) draw_sprite(topspr,topindex,x,y-8); }
            else if(image_speed==0) draw_self()
            else {
                var _last=image_index
                for(image_index=0;image_index<image_number;++image_index) draw_self()
                image_index=_last
            }
        }
        if(ntte_wall_fake_top) {
            gpu_set_blendmode_ext(bm_zero,bm_inv_src_alpha)
            with(Wall) if(solid) {
                { if(sprite_exists(topspr)) draw_sprite(topspr,topindex,x,y-8); }
                { if(sprite_exists(outspr)) draw_sprite_part(outspr,outindex,l,r,w,h,x+l-4,y+r-12); }
            }
            gpu_set_blendmode(bm_normal)
        }
        surface_reset_target();camera_destroy(_camera);_camera=-1
        ntte_wall_fake_mask_x=_sx;ntte_wall_fake_mask_y=_sy
        ntte_wall_fake_mask_count=_wall_count;ntte_wall_fake_mask_max=_wall_max
      }
        surface_set_target(ntte_wall_fake_surface)
        _camera=camera_create_view(_vx,_vy,_gw,_gh,0,noone,-1,-1,-1,-1);camera_apply(_camera)
        draw_clear_alpha(c_black,0)
        with(Player) {
            var _circle=scrNTTEFullValue(id,"red_wall_fake",0)
            if(_circle>0) draw_circle(x,y+(other.ntte_wall_fake_top?-4:4),
                (32+sin(current_frame/10))*lerp(0.2,_circle,_circle),false)
        }
        gpu_set_blendmode_ext(bm_zero,bm_src_alpha)
        draw_surface_ext(ntte_wall_fake_mask,_sx,_sy,1/_scale,1/_scale,0,c_white,1)
        gpu_set_blendmode_ext(bm_one,bm_zero)
        gpu_set_colorwriteenable(true,true,true,false)
        draw_surface_stretched(ntte_wall_fake_capture,_vx,_vy,_gw,_gh)
        gpu_set_colorwriteenable(true,true,true,true);gpu_set_blendmode(bm_normal)
        ntte_wall_fake_surface_x=_vx;ntte_wall_fake_surface_y=_vy;ntte_wall_fake_scale=_scale
    }
    finally {
        if(surface_get_target()>=0) surface_reset_target()
        if(_target>=0 && surface_get_target()!=_target) surface_set_target(_target)
        if(_camera>=0) camera_destroy(_camera)
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_pop_state();draw_set_color(_color);draw_set_alpha(_alpha)
    }
}
function scrNTTEFullWallFakeDrawReveal() {
    var _object=ntte_wall_fake_top?NTTEFullWallFakeDrawTop:NTTEFullWallFakeDrawBot,
        _pass=instance_find(_object,0)
    if(!instance_exists(_pass) || !surface_exists(_pass.ntte_wall_fake_surface)
        || !instance_exists(NTTEFullWallFakeController) || !NTTEFullWallFakeController.ntte_wall_fake_reveal_visible) return;
    var _surface=_pass.ntte_wall_fake_surface,_x=_pass.ntte_wall_fake_surface_x,_y=_pass.ntte_wall_fake_surface_y,
        _scale=_pass.ntte_wall_fake_scale,
        _fog=gpu_get_fog()
    gpu_set_fog(true,make_color_rgb(192,0,55),0,0)
    draw_surface_ext(_surface,_x-1,_y,1/_scale,1/_scale,0,c_white,1);draw_surface_ext(_surface,_x+1,_y,1/_scale,1/_scale,0,c_white,1)
    gpu_set_fog(true,make_color_rgb(145,0,43),0,0)
    draw_surface_ext(_surface,_x,_y-1,1/_scale,1/_scale,0,c_white,1);draw_surface_ext(_surface,_x,_y+1,1/_scale,1/_scale,0,c_white,1)
    gpu_set_fog(false,0,0,0);draw_surface_ext(_surface,_x,_y,1/_scale,1/_scale,0,c_white,1)
    gpu_set_fog(_fog)
}
