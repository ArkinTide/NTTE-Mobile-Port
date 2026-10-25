// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// Original tetrench QuasarBeam base, including PitSquid's three eye beams.
// QuasarRing / Ultra variants retain the original shared beam implementation.
function scrNTTEFullQuasarBeamCreate() {
    sprite_index=scrNTTERefSprite("QuasarBeam"); image_speed=0.5*timescale; depth=-2
    ntte_full_start=scrNTTERefSprite("QuasarBeamStart"); ntte_full_stop=scrNTTERefSprite("QuasarBeamEnd")
    ntte_full_hit=scrNTTERefSprite("QuasarBeamHit"); ntte_full_trail=scrNTTERefSprite("QuasarBeamTrail"); ntte_full_flame=-1
    mask_index=scrNTTERefSprite("msk.QuasarBeam"); friction=0.02*timescale*timescale
    image_xscale=1;image_yscale=1;creator=noone
    damage=12; knockback_speed=4*timescale; typ=0; ntte_full_loop=-1
    ntte_full_hit_time=0; ntte_full_hit_list=-1; ntte_full_blast=true
    ntte_full_flash=current_frame+2; ntte_full_line=[]; ntte_full_distance=0; ntte_full_max_distance=300
    ntte_full_turn=0; ntte_full_turn_friction=0.25; ntte_full_direction_goal=undefined
    ntte_full_turn_max=8; ntte_full_turn_factor=0.125; ntte_full_bend=0; ntte_full_bend_friction=0.3
    ntte_full_shrink_delay=0; ntte_full_shrink=0.05; ntte_full_scale_goal=1
    ntte_full_hold_x=undefined; ntte_full_hold_y=undefined; ntte_full_offset=0
    ntte_full_follow=true; ntte_full_primary=true; ntte_full_offset_angle=0
    ntte_full_wave=random(100); ntte_full_primed=false
    ntte_full_ring=false; ntte_full_ring_size=1; ntte_full_ring_lasers=[]
    ntte_full_ring_timer=-1; ntte_full_ultra=false
}

function scrNTTEFullQuasarBeamHit(_victim) {
    // The source has no team, health, native iframe or logical-phase gate.
    // Its beam trace prefilters teams; CustomProjectile Collision independently
    // filters equal teams before invoking this callback.
    if (!instance_exists(_victim)) return false
    if(!ds_exists(ntte_full_hit_list,ds_type_map)) ntte_full_hit_list=ds_map_create()
    var _key=string(real(_victim))
    if (ds_map_exists(ntte_full_hit_list,_key) && ntte_full_hit_list[? _key]>ntte_full_hit_time) return false
    ntte_full_hit_list[? _key]=ntte_full_hit_time+(ntte_full_ring ? 3:6)
    speed*=1-0.05*_victim.size
    repeat(3) instance_create(_victim.x,_victim.y,Smoke)
    if (ntte_full_blast) {
        sleep(30)
        scrNTTEFullCoastSoundAt(_victim.x,_victim.y,sndExplosionS,0.7+random(0.1),1.2)
        scrNTTEFullCoastSoundAt(_victim.x,_victim.y,sndMeatExplo,1.2+random(0.1),1.4)
    }
    var _direction=direction
    if (place_meeting(x,y,_victim) || ntte_full_ring) direction=point_direction(x,y,_victim.x,_victim.y)
    var _amount=ceil((damage+ntte_full_blast*damage*(1+scr_skill_get(mut_laser_brain)))*image_yscale),
        _force=(instance_is(_victim,prop) || _victim.team==team_none) ? 0:knockback_speed/timescale
    var _hit=scrNTTEFullNativeProjectileHitNP(_victim,_amount,_force,40)
    direction=_direction
    if (ntte_full_ultra && instance_exists(_victim) && _victim.hp<=0) {
        if (_victim.size>=2) {
            var _fx=instance_create(_victim.x,_victim.y,GreenExplosion); _fx.hitid=99
            repeat(3) { _fx=instance_create(_victim.x,_victim.y,SmallExplosion); _fx.hitid=56 }
        }
        else { var _fx=instance_create(_victim.x,_victim.y,SmallExplosion); _fx.hitid=56 }
        with(_victim) snd_play_hit_big(sndExplosionS,0.3)
    }
    return _hit
}

function scrNTTEFullQuasarBeamStep() {
    if (lockstep_stop) return;
    if (ntte_full_ring_timer>=0) {
        ntte_full_ring_timer-=timescale
        if (ntte_full_ring_timer<=0) scrNTTEFullQuasarRingEmit()
    }
    ntte_full_wave+=timescale; ntte_full_hit_time+=timescale
    var _brain=instance_is(creator,enemy) ? 0:scr_skill_get(mut_laser_brain),_ct=timescale*power(2/3,_brain)
    if (ntte_full_shrink_delay<=0) {
        image_xscale-=ntte_full_shrink*_ct; image_yscale-=ntte_full_shrink*_ct
    }
    else {
        ntte_full_shrink_delay-=_ct
        if (ntte_full_shrink_delay<=0 || (ntte_full_follow && !instance_exists(creator))) ntte_full_shrink_delay=-1
        var _goal=ntte_full_scale_goal*power(1.2,_brain)
        if (abs(_goal-image_xscale)>0.05 || abs(_goal-image_yscale)>0.05) {
            image_xscale+=(_goal-image_xscale)*0.4*timescale; image_yscale+=(_goal-image_yscale)*0.4*timescale
            if(ntte_full_follow) {
                var _pitch=image_yscale*0.5
                if(image_yscale<1) {snd_play(sndLightningCrystalHit,_pitch-random(0.1),0.8);snd_play(sndPlasmaHit,_pitch,0.6)}
                snd_play(sndEnergySword,_pitch*0.8,0.6)
            }
        }
        else { image_xscale=_goal; image_yscale=_goal }
    }
    if (ntte_full_follow && instance_exists(creator)) {
        var _angle=image_angle+ntte_full_offset_angle,
            _angle_difference=angle_difference(_angle,scrNTTEFullValue(creator,"gunangle",_angle))
        if(instance_is(creator,Player)) scrNTTEFullQuasarBeamBindAngle(_angle_difference)
        with (creator) {
            if (other.ntte_full_shrink_delay>0) {
                var _kick=other.ntte_full_primary ? "wkick":"bwkick"
                if (variable_instance_exists(id,_kick)) variable_instance_set(id,_kick,
                    max(8*(1+max(other.image_xscale-1,0))/max(1,abs(_angle_difference/30)),variable_instance_get(id,_kick)))
            }
            if (friction>0) scrNTTEFullNativeMotionAddFT(id,_angle+180,other.image_yscale/2.5)
            other.ntte_full_hold_x=x; other.ntte_full_hold_y=y+(other.ntte_full_primary ? 0:-4)
            if (!place_meeting(x+hspeed,y,Wall)) other.ntte_full_hold_x+=hspeed
            if (!place_meeting(x,y+vspeed,Wall)) other.ntte_full_hold_y+=vspeed
            if (variable_instance_exists(id,"gunangle")) other.ntte_full_direction_goal=gunangle
        }
    }
    var _offset=ntte_full_offset+sprite_get_width(ntte_full_start)*image_xscale*0.5
    if (!is_undefined(ntte_full_hold_x)) { x=ntte_full_hold_x+lengthdir_x(_offset,image_angle); xprevious=x }
    if (!is_undefined(ntte_full_hold_y)) { y=ntte_full_hold_y+lengthdir_y(_offset,image_angle); yprevious=y }
    ntte_full_turn-=ntte_full_turn*ntte_full_turn_friction*timescale
    if (!is_undefined(ntte_full_direction_goal)) {
        var _turn=angle_difference(ntte_full_direction_goal,image_angle+ntte_full_offset_angle)
        if (abs(_turn)>90 && abs(ntte_full_turn)>1) _turn=abs(_turn)*sign(ntte_full_turn)
        ntte_full_turn+=_turn*ntte_full_turn_factor*timescale
    }
    ntte_full_turn=clamp(ntte_full_turn,-ntte_full_turn_max,ntte_full_turn_max)
    image_angle=(image_angle+ntte_full_turn*timescale+360) mod 360
    ntte_full_bend-=ntte_full_bend*ntte_full_bend_friction*timescale+ntte_full_turn*timescale
    scrNTTEFullQuasarBeamLine()
    if (ntte_full_loop<0 || !audio_is_playing(ntte_full_loop)) ntte_full_loop=audio_play_sound(sndNothingBeamLoop,0,true)
    // The current runner returns -1 when no audio voice can be allocated.
    // Preserve the source retry next Step; configure only a valid voice.
    if(ntte_full_loop>=0) {
        audio_sound_pitch(ntte_full_loop,0.3+0.1*sin(current_frame/10)); audio_sound_gain(ntte_full_loop,image_xscale,0)
    }
    if (image_xscale<=0 || image_yscale<=0) instance_destroy()
}

function scrNTTEFullQuasarBeamLine() {
    var _add=20,_radius=sprite_get_height(sprite_index)/2,_start_dir=image_angle,
        _change=(instance_is(creator,Player) ? 120:40)*timescale,_distance=0,_dir=_start_dir,
        _cx=x,_cy=y,_last_x=x-lengthdir_x(sprite_get_width(ntte_full_start)/2*image_xscale,_dir),
        _last_y=y-lengthdir_y(sprite_get_width(ntte_full_start)/2*image_xscale,_dir),_walled=false,_wob=0,
        _enemies=[],_hitme=scrNTTEFullInstances(hitme),_beam=id,_source_line=false
    for(var _i=0;_i<array_length(_hitme);++_i) if(_hitme[_i].team!=team) array_push(_enemies,_hitme[_i])
    if (ntte_full_ring) {
        _add=24*ntte_full_ring_size
        var _xoff=-_add/2,_yoff=57*ntte_full_ring_size
        _cx=x+lengthdir_x(_xoff,_dir)+lengthdir_x(_yoff,_dir-90)
        _cy=y+lengthdir_y(_xoff,_dir)+lengthdir_y(_yoff,_dir-90)
        _last_x=_cx; _last_y=_cy
        motion_add(random(360),0.2/(speed/max(0.001,timescale)+1)*timescale*timescale)
        var _rings=scrNTTEFullInstances(NTTEFullQuasarBeam)
        if(place_meeting(x,y,object_index)) for(var _i=0;_i<array_length(_rings);++_i) {
            var _r=_rings[_i]
            var _meeting=false
            if(_r!=id && _r.ntte_full_ring && scrNTTEFullQuasarBBoxOverlap(id,_r)) with(_r) _meeting=place_meeting(x,y,other.id)
            if (_meeting) {
                var _away=point_direction(x,y,_r.x,_r.y)
                _r.x+=lengthdir_x(0.5*timescale,_away); _r.y+=lengthdir_y(0.5*timescale,_away)
                with (_r) motion_add(_away,0.03*timescale*timescale)
            }
        }
        var _live=[]
        for(var _i=0;_i<array_length(ntte_full_ring_lasers);++_i)
            if (instance_exists(ntte_full_ring_lasers[_i])) array_push(_live,ntte_full_ring_lasers[_i])
        ntte_full_ring_lasers=_live
        for(var _i=0;_i<array_length(_live);++_i) {
            var _p=_live[_i],_length=_yoff+(ntte_full_ultra ? 10:6)*image_yscale
            _p.ntte_full_hold_x=x+hspeed/timescale+lengthdir_x(_length,_p.image_angle)
            _p.ntte_full_hold_y=y+vspeed/timescale+lengthdir_y(_length,_p.image_angle)
            _p.ntte_full_direction_goal+=4*timescale*sin(_p.ntte_full_wave/30+array_length(_live)+_i)
        }
    }
    ntte_full_line=[]; ntte_full_distance=clamp(ntte_full_distance+_change,0,ntte_full_max_distance)
    if (collision_line(_last_x,_last_y,_cx,_cy,TopSmall,false,false)) ntte_full_distance=0
    if(_add>0 && ntte_full_distance>0) while(true) {
        var _seen=scrNTTEFullQuasarPointSeen(_last_x,_last_y,_add*2,_add*2),
            // Rendering covers the current cross-section too. A charged cap
            // can be visible while its previous/back probe is offscreen.
            // Keep the source probe for effects/RNG and wall-distance state.
            _draw_seen=_seen || (!ntte_full_ring && scrNTTEFullQuasarPointSeen(_cx,_cy,
                _add*2+_radius*abs(image_yscale),_add*2+_radius*abs(image_yscale)))
        if (!_walled) {
            if (!ntte_full_ring && collision_line(_last_x,_last_y,_cx,_cy,Wall,false,false)) _walled=true
            else if (_draw_seen) {
                if(_seen) _source_line=true
                var _r=_radius,_vertex_x=_cx+hspeed,_vertex_y=_cy+vspeed,_normal=_dir-90
                if (ntte_full_ring) {
                    var _o=(2+2*ntte_full_ring_size*image_yscale)/max(ntte_full_shrink_delay/20,1)
                    _vertex_x+=lengthdir_x(_o,_normal)*dcos(_dir*2+ntte_full_wave*4)
                    _vertex_y+=lengthdir_y(_o,_normal)*dsin(_dir*10+ntte_full_wave*4)
                    _normal-=(_add/ntte_full_ring_size)*0.5
                }
                else _r*=1+0.1*sin(ntte_full_wave/6+_wob/10)*min(1,_wob/3)
                for(var _side=-1;_side<=1;_side+=2) {
                    array_push(ntte_full_line,{x:_vertex_x,y:_vertex_y,dir:_dir,
                        xoff:lengthdir_x(_r*_side,_normal),yoff:lengthdir_y(_r*_side,_normal),
                        // Map the authored -1/+1 sides to opposite texture edges.
                        u:_distance/ntte_full_distance,v:(_side+1)/2})
                }
            }
        }
        else {
            ntte_full_blast=false; ntte_full_distance-=_change
            if (!_source_line) ntte_full_distance=0
        }
        var _ox=x,_oy=y
        x=_cx; y=_cy
        if (ntte_full_ring && place_meeting(x,y,Wall)) {
            speed*=0.96
            var _walls=ds_list_create()
            collision_rectangle_list(bbox_left,bbox_top,bbox_right-1,bbox_bottom-1,Wall,false,true,_walls,false)
            for(var _i=0;_i<ds_list_size(_walls);++_i) {
                var _wall=_walls[| _i]
                var _meeting=false
                if(instance_exists(_wall) && scrNTTEFullQuasarBBoxOverlap(id,_wall)) with(_wall) _meeting=place_meeting(x,y,other.id)
                if (_meeting) {
                    instance_create(_wall.x,_wall.y,FloorExplo); instance_destroy(_wall)
                }
            }
            ds_list_destroy(_walls)
        }
        if(place_meeting(x,y,hitme)) for(var _i=0;_i<array_length(_enemies);++_i) {
            var _victim=_enemies[_i],_meeting=false
            if(instance_exists(_victim) && scrNTTEFullQuasarBBoxOverlap(id,_victim)) with(_victim) _meeting=place_meeting(x,y,other.id)
            if (!_meeting) continue
            if (instance_is(_victim,Player) && (_walled || collision_line(_victim.x,_victim.y,_last_x,_last_y,Wall,false,false))) continue
            var _key=string(real(_victim))
            if(!ds_exists(ntte_full_hit_list,ds_type_map)) ntte_full_hit_list=ds_map_create()
            if (!ds_map_exists(ntte_full_hit_list,_key) || ntte_full_hit_list[? _key]<=ntte_full_hit_time) {
                var _fx=instance_create(x+orandom(8),y+orandom(8),BulletHit)
                _fx.sprite_index=ntte_full_hit; _fx.image_xscale=image_yscale; _fx.image_yscale=image_yscale; _fx.depth=depth-1
                scrNTTEFullNativeMotionAddFT(_fx,point_direction(x,y,_fx.x,_fx.y),1)
                _fx.image_angle=_fx.direction
                if (!ntte_full_ring) direction=_dir
                x=_ox; y=_oy
                // Real Collision dispatch preserves temerge's mounted callback.
                with(_victim) with(_beam) event_perform(ev_collision,hitme)
                if(!instance_exists(_beam)) return;
                x=_cx; y=_cy
            }
            if (instance_is(creator,Player) && (!instance_exists(_victim) || _victim.hp<=0 || _victim.size>=(image_yscale<=1 ? 3:4) || ntte_full_blast)) ntte_full_distance=_distance
            ntte_full_blast=false
        }
        x=_ox; y=_oy
        if (_seen && random(160/_add)<timescale && position_meeting(_cx,_cy,Floor)) {
            var _off=(ntte_full_ultra ? 24:32)*image_yscale,_fx=instance_create(_cx+orandom(_off),_cy+orandom(_off),PlasmaTrail)
            _fx.sprite_index=ntte_full_trail
            if (ntte_full_ultra) { _fx.image_angle=_dir; _fx.image_xscale=random_range(2/3,1); _fx.image_yscale=_fx.image_xscale }
            scrNTTEFullNativeMotionAddFT(_fx,_dir,1+random(max(image_yscale-1,0)))
            if (image_yscale>1) _fx.depth=depth-1
        }
        _last_x=_cx; _last_y=_cy; _cx+=lengthdir_x(_add,_dir); _cy+=lengthdir_y(_add,_dir); _distance+=_add
        if (ntte_full_ring) _dir+=_add/ntte_full_ring_size
        else _dir=clamp(_dir+ntte_full_bend/(48/_add),_start_dir-90,_start_dir+90)
        if ((!ntte_full_ring && _distance>=ntte_full_distance) || (ntte_full_ring && abs(_dir-_start_dir)>360)) {
            if (_distance>=ntte_full_max_distance) ntte_full_blast=false
            if (ntte_full_ring && array_length(ntte_full_line)>0) {
                array_push(ntte_full_line,ntte_full_line[0]); array_push(ntte_full_line,ntte_full_line[1])
            }
            break
        }
        _wob+=1
    }
    if(!ntte_full_ring) {
        if(random(4)<timescale) {
            var _xoff=orandom(12)-(12*image_xscale+_add),_yoff=orandom(random(28*image_yscale)),
                _fx_x=(_walled?_last_x:_cx)+lengthdir_x(_xoff,_dir)+lengthdir_x(_yoff,_dir-90),
                _fx_y=(_walled?_last_y:_cy)+lengthdir_y(_xoff,_dir)+lengthdir_y(_yoff,_dir-90)
            if(!position_meeting(_fx_x,_fx_y,TopSmall)) {
                var _fx=instance_create(_fx_x,_fx_y,BulletHit)
                _fx.sprite_index=ntte_full_hit;_fx.image_xscale=image_yscale;_fx.image_yscale=image_yscale;_fx.depth=depth-1
                instance_create(_fx.x,_fx.y,Smoke)
            }
        }
        scrNTTEFullTrenchShake(_cx,_cy,4,true)
    }
    scrNTTEFullTrenchShake(x,y,4,true)
}

function scrNTTEFullQuasarBeamDrawLaser(_xscale,_yscale,_alpha) {
    var _col=image_blend,_angle=image_angle,_end_x=x,_end_y=y,_last_color=draw_get_color()
    if (ntte_full_start>=0) draw_sprite_ext(ntte_full_start,image_index,x,y,_xscale,_yscale,image_angle,_col,_alpha)
    if (ntte_full_ring) {
        var _o=0
        draw_set_color(_col); draw_set_alpha(_alpha<1 ? _alpha/2:_alpha)
        repeat(2) {
            draw_circle(x-1+_o*cos(ntte_full_wave/8),y-1+_o*sin(ntte_full_wave/8),
                (18*ntte_full_ring_size+floor(image_index))*_xscale,false)
            _o=2*_xscale*cos(ntte_full_wave/13)/max(ntte_full_shrink_delay/20,1)
        }
        draw_set_alpha(1)
    }
    if (array_length(ntte_full_line)>0) {
        // vertex_submit has an explicit atlas-UV contract on every backend.
        // Reuse the buffer instead of relying on the immediate primitive
        // wrapper's backend-specific sprite-entry remapping.
        static _buffer=-1,_format=-1
        if(_format<0) {
            vertex_format_begin();vertex_format_add_position_3d();
            vertex_format_add_colour();vertex_format_add_texcoord();
            _format=vertex_format_end();_buffer=vertex_create_buffer();
        }
        var _texture=sprite_get_texture(sprite_index,image_index),
            _uv=sprite_get_uvs(sprite_index,image_index),_height=sprite_get_height(sprite_index),
            _half_texel=texture_get_texel_width(_texture)*0.5
        vertex_begin(_buffer,_format)
        for(var _i=0;_i<array_length(ntte_full_line);++_i) {
            var _v=ntte_full_line[_i]
            // Modern texture entries omit transparent sprite margins. Native
            // cap drawing retains those margins; the strip must do so too.
            var _crop=_v.v==0 ? 1-2*_uv[5]/_height : 2*(_uv[5]/_height+_uv[7])-1
            vertex_position_3d(_buffer,_v.x+_v.xoff*_yscale*_crop,_v.y+_v.yoff*_yscale*_crop,0)
            vertex_colour(_buffer,_col,_alpha)
            // Ring u may exceed one while its trace length grows. Both
            // authored horizontal texels agree; keep sampling this entry,
            // never the adjacent packed sprite outside its atlas bounds.
            vertex_texcoord(_buffer,clamp(lerp(_uv[0],_uv[2],_v.u),_uv[0]+_half_texel,_uv[2]-_half_texel),
                lerp(_uv[1],_uv[3],_v.v))
        }
        vertex_end(_buffer);vertex_submit(_buffer,pr_trianglestrip,_texture);draw_set_alpha(1)
        var _end=ntte_full_line[array_length(ntte_full_line)-1]
        _angle=_end.dir; _end_x=_end.x; _end_y=_end.y
    }
    if (ntte_full_stop>=0 && !collision_line(x-lengthdir_x(1,_angle),y-lengthdir_y(1,_angle),
        x+lengthdir_x(16/image_xscale,_angle),y+lengthdir_y(16/image_yscale,_angle),TopSmall,false,false)) {
        draw_sprite_ext(ntte_full_stop,image_index,_end_x,_end_y,min(_xscale,1.25),_yscale,_angle,_col,_alpha)
    }
    draw_set_color(_last_color)
}

function scrNTTEFullQuasarBeamDraw() {
    if(ntte_full_flash>current_frame) gpu_set_fog(true,c_white,0,0)
    scrNTTEFullQuasarBeamDrawLaser(image_xscale,image_yscale,image_alpha)
    if (ntte_full_ring) {
        // Source draws every connector before drawing any child laser.
        for(var _i=0;_i<array_length(ntte_full_ring_lasers);++_i) {
            var _p=ntte_full_ring_lasers[_i]
            if (!instance_exists(_p)) continue
            draw_set_color(_p.image_blend); draw_set_alpha(_p.image_alpha)
            draw_circle(_p.x-1,_p.y-1,6*_p.image_yscale,false)
        }
        for(var _i=0;_i<array_length(ntte_full_ring_lasers);++_i)
            if(instance_exists(ntte_full_ring_lasers[_i])) with(ntte_full_ring_lasers[_i]) scrNTTEFullQuasarBeamDraw()
        draw_set_alpha(1)
    }
    if(ntte_full_flash>current_frame) gpu_set_fog(false,0,0,0)
    // Source Ultra flame function exists, but its Draw invocation is commented out.
}

function scrNTTEFullQuasarBeamCleanup() {
    if (ntte_full_loop>=0) audio_stop_sound(ntte_full_loop)
    if (ds_exists(ntte_full_hit_list,ds_type_map)) ds_map_destroy(ntte_full_hit_list)
    for(var _i=0;_i<array_length(ntte_full_ring_lasers);++_i)
        if (instance_exists(ntte_full_ring_lasers[_i])) instance_destroy(ntte_full_ring_lasers[_i])
}

function scrNTTEFullQuasarRingCreate() {
    ntte_full_start=-1; ntte_full_stop=-1; mask_index=mskExploder; ntte_full_follow=false
    ntte_full_shrink_delay=120; ntte_full_ring=true; knockback_speed=timescale
    ntte_full_ring_timer=10+random(20); instance_create(x,y,PortalClear)
}

function scrNTTEFullUltraQuasarCreate() {
    sprite_index=scrNTTERefSprite("UltraQuasarBeam"); ntte_full_start=scrNTTERefSprite("UltraQuasarBeamStart")
    ntte_full_stop=scrNTTERefSprite("UltraQuasarBeamEnd"); ntte_full_hit=scrNTTERefSprite("UltraQuasarBeamHit")
    ntte_full_flame=scrNTTERefSprite("UltraQuasarBeamFlame")
    ntte_full_trail=scrNTTERefSprite("UltraQuasarBeamTrail"); mask_index=scrNTTERefSprite("msk.UltraQuasarBeam")
    ntte_full_turn_factor=1/50; ntte_full_ultra=true; damage=24
}

function scrNTTEFullQuasarRingEmit() {
    ntte_full_ring_timer=random_range(4+8*array_length(ntte_full_ring_lasers),16)
    var _p=scrNTTEFullMergedBasicProjectileCreate(x,y,ntte_full_ultra ? NTTEFullUltraQuasarBeam:NTTEFullQuasarBeam,random(360))
    _p.ntte_full_start=-1; _p.ntte_full_follow=false
    _p.ntte_full_direction_goal=_p.image_angle+random(orandom(180))
    _p.ntte_full_shrink_delay=min(ntte_full_shrink_delay,random_range(10,120))
    _p.ntte_full_scale_goal=ntte_full_scale_goal-random(0.6); _p.image_xscale=0; _p.image_yscale=0; _p.visible=false
    array_push(ntte_full_ring_lasers,_p)
}

function scrNTTEFullQuasarBBoxOverlap(_a,_b) {
    // telib.instances_meeting_instance: inclusive original bbox edges.
    return _b.bbox_right-1>=_a.bbox_left && _b.bbox_bottom-1>=_a.bbox_top
        && _b.bbox_left<=_a.bbox_right-1 && _b.bbox_top<=_a.bbox_bottom-1
}
function scrNTTEFullQuasarPointSeen(_x,_y,_bx,_by) {
    // point_seen_ext(...,-1), one synchronized local viewport, strict bounds.
    return _x>view_xview-_bx && _x<view_xview+view_width+_bx
        && _y>view_yview-_by && _y<view_yview+view_height+_by
}
function scrNTTEFullQuasarBeamEndStep() {
    if(lockstep_stop || ntte_full_primed) return;
    ntte_full_primed=true
    var _distance=ntte_full_max_distance
    ntte_full_max_distance=0
    scrNTTEFullQuasarBeamStep()
    if(instance_exists(id)) ntte_full_max_distance=_distance
}
function scrNTTEFullQuasarBeamBindAngle(_angle) {
    var _binders=scrNTTEFullInstances(NTTEFullQuasarWeaponAngle),_binder=noone
    for(var _i=0;_i<array_length(_binders);++_i) if(_binders[_i].creator==creator && _binders[_i].ntte_full_primary==ntte_full_primary) {
        _binder=_binders[_i];break
    }
    if(!instance_exists(_binder)) {
        _binder=instance_create(0,0,NTTEFullQuasarWeaponAngle)
        _binder.creator=creator;_binder.ntte_full_primary=ntte_full_primary
    }
    _binder.ntte_full_angle=_angle
}
function scrNTTEFullQuasarWeaponAngleStep() {
    if(lockstep_stop) return;
    if(!instance_exists(creator) || abs(ntte_full_angle)<=1) {instance_destroy();return;}
    with(creator) {
        // telib.weapon_get unwraps .wep to stock, and temerge has no override
        // for ntte_quasar. A Quasar front alone does not confer this property.
        if(scrNTTEFullQuasarWeaponIs(scrNTTEFullWeaponRaw(other.ntte_full_primary?wep:bwep))) {
            if(other.ntte_full_primary) {
                wepangle+=other.ntte_full_angle
                var _face=((gunangle+other.ntte_full_angle)%360+360)%360
                if(_face<90 || _face>270) right=1
                else if(_face>90 && _face<270) right=-1
                back=dsin(gunangle+other.ntte_full_angle)>0?1:-1
            }
            else bwepangle+=other.ntte_full_angle
        }
    }
    ntte_full_angle*=power(0.7,timescale)
}

// Mobile swap-control display only. The held weapon and its projectile art
// retain their source dimensions. Other weapons retain the existing layout.
function scrNTTEFullQuasarSwapWeaponDraw(_weapon,_sprite,_frame,_cx,_cy,_base_scale,_angle,_radius,_color,_alpha) {
    if(scrNTTEFullWeaponRaw(_weapon)!=wep_ntte_ultra_quasar_rifle || !sprite_exists(_sprite)) return false;
    var _w=sprite_get_width(_sprite),_h=sprite_get_height(_sprite),
        _scale=min(_base_scale,2*max(1,_radius-2)/sqrt(_w*_w+_h*_h)),
        _xoff=(sprite_get_xoffset(_sprite)-_w/2)*_scale,
        _yoff=(sprite_get_yoffset(_sprite)-_h/2)*_scale;
    draw_sprite_ext(_sprite,_frame,
        _cx+lengthdir_x(_xoff,_angle)+lengthdir_x(_yoff,_angle-90),
        _cy+lengthdir_y(_xoff,_angle)+lengthdir_y(_yoff,_angle-90),
        _scale,_scale,_angle,_color,_alpha);
    return true;
}
