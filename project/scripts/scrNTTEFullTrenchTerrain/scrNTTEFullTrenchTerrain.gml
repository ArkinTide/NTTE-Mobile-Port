// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// trench.area End Step floor conversion and tetrench's launched floor chunks.
function scrNTTEFullTrenchOpenPits() {
    if (lockstep_stop || GameCont.area!=scrNTTEFullAreaId("trench") || instance_exists(GenCont)) return;
    var _pits=scrNTTERefSprite("FloorTrenchB"),_normal=scrNTTERefSprite("FloorTrench"),_changed=false
    with (PortalClear) {
        if (!variable_instance_exists(id,"pit_clear") || pit_clear<=0) continue
        var _xs=image_xscale,_ys=image_yscale,_clear=id,
            _smash=variable_instance_exists(id,"pit_smash") && pit_smash
        image_xscale*=pit_clear; image_yscale*=pit_clear
        // Snapshot first: FloorSet replaces these instances while iterating.
        var _floors=[],_cl=bbox_left,_cr=bbox_right,_ct=bbox_top,_cb=bbox_bottom
        // This is a read-only snapshot pass. Keep the exact mask test and
        // native Floor order, but do not ask it about distant floor tiles.
        with (Floor) if (sprite_index!=_pits && bbox_right>=_cl-1 && bbox_left<=_cr+1
            && bbox_bottom>=_ct-1 && bbox_top<=_cb+1 && place_meeting(x,y,_clear)) array_push(_floors,id)
        for(var _i=0;_i<array_length(_floors);++_i) {
            if (!instance_exists(_floors[_i])) continue
            with (_floors[_i]) {
                snd_play(sndWallBreak,0.6+random(0.4),1.5)
                if (_smash) {
                    for(var _px=bbox_left;_px<(bbox_right-1)+1;_px+=16) for(var _py=bbox_top;_py<(bbox_bottom-1)+1;_py+=16) {
                        var _dir=point_direction(_clear.x,_clear.y,_px+8,_py+8),
                            _speed=8-point_distance(_clear.x,_clear.y-16,_px+8,_py+8)/16
                        if (random(3)<2) {
                            var _chunk=instance_create(_px+random_range(4,12),_py+random_range(4,12),NTTEFullTrenchFloorChunk)
                            _chunk.ntte_full_zspeed=_speed; _chunk.direction=_dir
                            if (sprite_index!=_normal || random(2)<1) {
                                _chunk.sprite_index=scrNTTERefSprite("DebrisTrench"); _chunk.ntte_full_zspeed/=2
                                _chunk.ntte_full_zfriction/=2; _chunk.ntte_full_debris=true
                            }
                        }
                    }
                }
                else repeat(ceil(((bbox_right-1)-bbox_left+(bbox_bottom-1)-bbox_top+2)/32))
                    instance_create(random_range(bbox_left,(bbox_right-1)+1),random_range(bbox_top,(bbox_bottom-1)+1),Debris)
                var _fx=x,_fy=y,_state=instance_is(id,FloorExplo) ? 2:1
                // Native floor style helper restores global area itself. It
                // doesn't know custom area's sprites, set the original below.
                scrNTTEFullFloorSetAlign(undefined,undefined,_fx,_fy)
                scrNTTEFullFloorSetStyle(true)
                var _new=scrNTTEFullFloorSet(_fx,_fy,_state)
                if (instance_exists(_new)) { _new.styleb=true; _new.sprite_index=_pits; if(_state==1) _new.depth=9; _changed=true }
                scrNTTEFullFloorResetAlign(); scrNTTEFullFloorResetStyle()
            }
        }
        image_xscale=_xs; image_yscale=_ys
    }
    // A replaced floor can keep the same instance count; update even when the
    // renderer has not initialized its cached count yet.
    if (_changed) scrNTTEFullTrenchPitRebuild()
}

function scrNTTEFullTrenchFloorChunkCreate() {
    sprite_index=scrNTTERefSprite("FloorTrenchBreak"); image_index=irandom(image_number-1)
    image_speed=0; image_alpha=0; depth=-9; visible=true
    ntte_full_z=0; ntte_full_zspeed=6+random(4); ntte_full_zfriction=0.3
    friction=0.05*timescale*timescale; image_angle+=orandom(20); ntte_full_debris=false
    ntte_full_rotation=random_range(1,2)*choose(-1,1); ntte_full_rot_friction=0
    if (random(3)<1) { ntte_full_rotation*=8; ntte_full_rot_friction=1 }
    motion_add(random(360),(2+random(3))*timescale)
}

function scrNTTEFullTrenchFloorChunkStep() {
    if (lockstep_stop) return;
    ntte_full_z+=ntte_full_zspeed*timescale; ntte_full_zspeed-=ntte_full_zfriction*timescale
    image_angle+=ntte_full_rotation*timescale
    ntte_full_rotation-=clamp(ntte_full_rotation,-ntte_full_rot_friction,ntte_full_rot_friction)*timescale
    if (random(10)<timescale) instance_create(x,y-ntte_full_z,Bubble)
    if (ntte_full_z<=0) instance_destroy()
}

function scrNTTEFullTrenchFloorChunkDraw() {
    // Source has separate floor shadow and airborne sprite draw slots.
    if (place_meeting(x,y,Floor)) {
        var _scale=clamp(1/(ntte_full_z/200+1),0.1,0.8)
        draw_sprite_ext(sprite_index,image_index,x,y,_scale*image_xscale,_scale*image_yscale,image_angle,image_blend,1)
    }
    draw_sprite_ext(sprite_index,image_index,x,y-ntte_full_z,image_xscale,image_yscale,image_angle,image_blend,1)
}

function scrNTTEFullTrenchFloorChunkDeath() {
    // Capture the complete dying instance state before creating child FX or
    // changing with scope; retained mobile runners may no longer resolve it.
    var _chunk_direction=direction,_chunk_speed=speed,_chunk_angle=image_angle,
        _chunk_sprite=sprite_index,_chunk_image=image_index,_chunk_debris=ntte_full_debris
    snd_play(sndOasisExplosionSmall,0.5+random(0.3),0.3+random(0.1))
    if (!place_meeting(x,y,Wall) && scrNTTEFullTrenchPitGet(x,y)) {
        var _fx=instance_create(x,y,Debris)
        with (_fx) {
            sprite_index=_chunk_sprite; image_index=_chunk_image; image_angle=_chunk_angle
            direction=_chunk_direction; speed=_chunk_speed
        }
        // Smoke can destroy itself during Create (particles off/generating).
        // Original MOD with(instance_create(...)) simply skips missing FX.
        if (!_chunk_debris) repeat(3) {
            var _smoke=instance_create(x,y,Smoke)
            with (_smoke) { image_xscale=2; image_yscale=2 }
        }
    }
    else {
        y-=2; snd_play(sndWallBreak,0.5+random(0.3),0.4)
        var _num=_chunk_debris ? 1:3
        for(var _i=0;_i<_num;++_i) {
            var _fx=instance_create(x,y,Debris)
            with (_fx) {
                motion_set(_chunk_direction+360*_i/_num+orandom(20),_chunk_speed+random(1)*timescale)
                if (_chunk_debris) image_angle=_chunk_angle
                else speed+=(2+random(1))*timescale
                if (!place_meeting(x,y,Floor)) depth=-7
                var _dust=instance_create(x+orandom(4),y+orandom(4),Smoke)
                with (_dust) {
                    sprite_index=sprDust; depth=other.depth; direction=other.direction; speed=other.speed
                }
            }
        }
    }
}

function scrNTTEFullPitSparkCreate() {
    sprite_index=scrNTTERefSprite("PitSpark",irandom(4)); image_angle=random(360); image_speed=0.4*timescale; depth=5
    mask_index=mskReviveArea; ntte_full_dark=irandom(1); ntte_full_tentacle_visible=true
    var _scale=1+0.1*GameCont.loops
    ntte_full_tentacle={scale:_scale,right:choose(-1,1),rotation:random(360),
        move_dir:random(360),move_spd:random(1.6),distance:irandom_range(28,12)*_scale}
    ntte_full_life=15+random(5)
}

function scrNTTEFullPitSparkStep() {
    if (lockstep_stop) return;
    ntte_full_life-=timescale
    if (ntte_full_life<=0) { instance_destroy(); return; }
    if (ntte_full_tentacle_visible) {
        ntte_full_tentacle.rotation+=ntte_full_tentacle.right*timescale*7
        ntte_full_tentacle.distance+=ntte_full_tentacle.move_spd*timescale
    }
    if (image_index+image_speed>=image_number) visible=false
}

function scrNTTEFullPitSquidSparks() {
    var _floors=[],_count=0,_sparks=instance_number(NTTEFullPitSpark),_pits=scrNTTERefSprite("FloorTrenchB"),
        _spawn=ntte_full_pit_height>=1 && ntte_full_intro
    // Before the reveal (and while submerged), the source still updates the
    // timer from the pit count and consumes exactly one random_range call.
    // No Floor ID pool is needed until a spark can actually be selected.
    with (Floor) if (sprite_index==_pits) { _count++; if(_spawn) array_push(_floors,id) }
    ntte_full_timers[3]=random_range(1,12)+12*_sparks+30/max(1,_count)
    if (!_spawn || _count==0) return;
    for(var _tries=0;_tries<10;++_tries) {
        var _floor=_floors[irandom(array_length(_floors)-1)],_fx=(_floor.bbox_left+(_floor.bbox_right-1)+1)/2,
            _fy=(_floor.bbox_top+(_floor.bbox_bottom-1)+1)/2,_distance=point_distance(_fx,_fy,x,y)
        if (_distance>96 && _distance<256 && !collision_rectangle(_floor.bbox_left,_floor.bbox_top,
            (_floor.bbox_right-1),(_floor.bbox_bottom-1),NTTEFullPitSpark,false,false)) {
            var _spark=instance_create(_fx,_fy,NTTEFullPitSpark)
            _spark.ntte_full_tentacle.move_dir=point_direction(x,y,_fx,_fy)
            break
        }
    }
}

function scrNTTEFullPitSparkComposite(_vx,_vy,_w,_h) {
    if (instance_number(NTTEFullPitSpark)==0) return;
    var _scale=scrNTTEFullVisualQuality("minor"),_size=max(1,ceil(60*_scale))
    if(!surface_exists(ntte_full_spark_surface) || surface_get_width(ntte_full_spark_surface)!=_size
        || surface_get_height(ntte_full_spark_surface)!=_size) {
        if(surface_exists(ntte_full_spark_surface)) surface_free(ntte_full_spark_surface)
        ntte_full_spark_surface=surface_create(_size,_size)
    }
    if (!surface_exists(ntte_full_spark_surface)) return;
    var _renderer=id,_scratch=ntte_full_spark_surface,_camera=ntte_full_camera,_wheel=scrNTTERefSprite("TentacleWheel"),
        _radius=[[25,20],[20,10]]
    with (NTTEFullPitSpark) if (ntte_full_tentacle_visible) {
        var _bright=floor(image_index) mod 2,_count=ntte_full_dark ? 1:2,_sx=x-30,_sy=y-30,
            _t=ntte_full_tentacle,
            _fade=visible ? image_index/image_number:(ntte_full_life>3 ? 1:(((current_frame+x+y)/2) mod 2))
        for(var _i=0;_i<_count;++_i) {
            var _bound=false;with(_renderer) _bound=scrNTTEFullPitTarget(_scratch)
            if(!_bound) continue
            camera_set_view_pos(_camera,_sx,_sy);camera_set_view_size(_camera,60,60);camera_apply(_camera)
            gpu_set_blendmode(bm_normal); draw_clear_alpha(c_black,0)
            draw_set_color(c_white); draw_circle(x,y,_radius[_i+ntte_full_dark][_bright]+irandom(1),false)
            gpu_set_blendmode_ext_sepalpha(bm_src_alpha,bm_inv_src_alpha,bm_zero,bm_one)
            draw_sprite_ext(_wheel,_i,x+lengthdir_x(_t.distance,_t.move_dir),y+lengthdir_y(_t.distance,_t.move_dir),
                image_xscale*_t.scale*_t.right,image_yscale*_t.scale,_t.rotation,merge_color(c_black,image_blend,_fade),image_alpha)
            surface_reset_target(); camera_set_view_pos(_camera,_vx,_vy); camera_set_view_size(_camera,_w,_h); camera_apply(_camera)
            draw_surface_ext(_scratch,_sx,_sy,1/_scale,1/_scale,0,c_white,1)
        }
    }
}

function scrNTTEFullPitArmOutlines() {
    var _alpha=0.3+0.25*sin(current_frame/10)
    gpu_set_fog(true,make_color_rgb(24,21,33),0,0)
    with (NTTEFullPitSquidArm) if (visible && nexthurt<=current_frame
        && x>=view_xview-32 && x<=view_xview+view_width+32 && y>=view_yview-32 && y<=view_yview+view_height+32) {
        for(var _dx=-1;_dx<=1;_dx+=2) draw_sprite_ext(sprite_index,image_index,x+_dx,y-1,
            image_xscale*right,image_yscale,image_angle,image_blend,image_alpha*_alpha*2)
    }
    gpu_set_fog(true,make_color_rgb(235,0,67),0,0)
    with (NTTEFullPitSquidArm) if (visible && nexthurt<=current_frame
        && x>=view_xview-32 && x<=view_xview+view_width+32 && y>=view_yview-32 && y<=view_yview+view_height+32) {
        for(var _dir=0;_dir<=180;_dir+=90) draw_sprite_ext(sprite_index,image_index,x+lengthdir_x(1,_dir),y+lengthdir_y(1,_dir),
            image_xscale*right,image_yscale,image_angle,image_blend,image_alpha*_alpha)
    }
    gpu_set_fog(false,0,0,0)
}
