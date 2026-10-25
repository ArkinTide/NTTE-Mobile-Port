// Original NTTE temerge3060..3310,5806..6033. Physical native motion is
// already scaled by timescale; source speed/friction getters are logical.
function scrNTTEFullMergedHyperInit() {
    scrNTTEFullMergedEffectsInit()
    var _registry=global.ntte_full_merge_effect_registry
    if(scrNTTEFullValue(_registry,"ntte_hyper_events_ready",false)) return;
    _registry.ntte_hyper_events_ready=true
    scrNTTEFullMergedEffectAddEvent("hyper","setup",scrNTTEFullMergedHyperSetup)
    scrNTTEFullMergedEffectAddEvent("hyper","begin_step",scrNTTEFullMergedHyperBegin)
}
function scrNTTEFullMergedHyperMelee(_object) {
    // Exact original class identity, including explicit source CustomSlash
    // ports. Descendants are not automatically treated as original Slash.
    switch(_object) {
        case Slash: case EnemySlash: case BloodSlash: case EnergySlash:
        case EnergyHammerSlash: case LightningSlash: case Shank: case EnergyShank:
        case NTTEFullBoneSlash: case NTTEFullClamShieldSlash:
        case NTTEFullEnergyBatSlash: case NTTEFullBubbleSlash: case NTTEFullRedSlash:
        case NTTEFullEntanglerSlash:
        case NTTEFullPalankingSlash: case NTTEFullPalankingSlashGround:
        case NTTEFullClamShield: case NTTEFullSealAnchor: case NTTEBatScreech:
        case NTTEFullHyperSlashTrail: return true;
    }
    return false;
}
function scrNTTEFullMergedHyperDeflector(_object) {
    return scrNTTEFullMergedHyperMelee(_object) || _object==HorrorBullet || _object==GuardianDeflect
}
function scrNTTEFullMergedHyperViewShift(_index,_direction,_pan) {
    // Epsilon has one local BackCont view. Its actual Step explicitly follows
    // Player.index==global.index; a remote/second player's shot cannot pan it.
    // Original view_shift indexes that player's view and ignores opt_shake.
    if(_index!=global.index || !scr_player_is_local(_index)) return;
    with(BackCont) {
        viewx2+=lengthdir_x(_pan*timescale,_direction)
        viewy2+=lengthdir_y(_pan*timescale,_direction)
    }
}
function scrNTTEFullMergedHyperSetup(_instances,_factor=1) {
    var _out=[]
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(speed<8*timescale && scrNTTEFullMergedHyperMelee(object_index)) {
            if(object_index==NTTEFullHyperSlashTrail || !instance_exists(creator)) continue
            var _slash=id,_mask=mask_index<0 ? sprite_index:mask_index,
                _cx=(bbox_left+bbox_right-1)/2,_cy=(bbox_top+bbox_bottom-1)/2
            with(creator) if(mask_index!=mskNone && !place_meeting(_cx,_cy,Wall)
                && !collision_line(x,y,_cx,_cy,Wall,false,false)) {
                var _old_x=x,_old_y=y,
                    _distance=max(64,2*(sprite_get_bbox_right(_mask)+1-sprite_get_bbox_left(_mask)))*_factor,
                    _dir=(_slash.direction==0 && _slash.speed==0) ?
                        ((_slash.image_angle==0 && variable_instance_exists(id,"gunangle")) ? gunangle:_slash.image_angle):_slash.direction,
                    _dx=lengthdir_x(8,_dir),_dy=lengthdir_y(8,_dir)
                x=_cx; y=_cy
                while(_distance>0 && place_free(x+3*_dx,y+3*_dy)) { _distance-=8; x+=_dx; y+=_dy }
                var _trail_x=_slash.x,_trail_y=_slash.y
                _slash.x+=x-_cx; _slash.y+=y-_cy
                _slash.xprevious=_slash.x; _slash.yprevious=_slash.y
                var _trail=instance_create(_trail_x,_trail_y,NTTEFullHyperSlashTrail)
                _trail.target=_slash
                if(variable_instance_exists(id,"wepangle")) _trail.sprite_side=-sign(wepangle*_slash.image_yscale)
                // Explicit original CustomSlash ports may update their position
                // in EndStep. Match their actual phase without moving other types.
                _trail.ntte_hyper_end_follow=_slash.object_index==NTTEFullBoneSlash
                    || _slash.object_index==NTTEFullSealAnchor || scrNTTEFullValue(_slash,"ntte_hyper_end_follow",false)
                with(_trail) scrNTTEFullHyperSlashStep()
                var _moved=point_distance(x,y,_cx,_cy)
                if(!variable_instance_exists(id,"temerge_hyper_frame") || temerge_hyper_frame<current_frame
                    || (variable_instance_exists(id,"temerge_hyper_distance") && _moved>temerge_hyper_distance)) {
                    temerge_hyper_frame=current_frame; temerge_hyper_distance=_moved; xprevious=x; yprevious=y
                    // Source view_shift temporarily ignores opt_shake and pans
                    // by distance/2 * current_time_scale for the local player.
                    if(variable_instance_exists(id,"index")) scrNTTEFullMergedHyperViewShift(index,_dir,_moved/2)
                }
                else { x=_old_x; y=_old_y }
            }
        }
        else {
            if(!variable_instance_exists(id,"temerge_hyper_speed")) {
                temerge_hyper_speed=0
                temerge_hyper_minspeed=max(timescale,min(friction/timescale*10,speed-4*friction/timescale))
            }
            temerge_hyper_speed+=_factor
            array_push(_out,id)
        }
    }
    return _out
}
function scrNTTEFullMergedHyperForeignContact(_families,_health=false,_typed=false,_deflectors=false) {
    var _candidates=scrNTTEFullInstances(_families)
    for(var _i=0;_i<array_length(_candidates);++_i) {
        var _candidate=_candidates[_i]
        if(_candidate==id || scrNTTEFullValue(_candidate,"team",team)==team) continue
        if(_health && scrNTTEFullValue(_candidate,"hp",0)<=0) continue
        if(_typed && scrNTTEFullValue(_candidate,"typ",0)==0) continue
        if(_deflectors && !scrNTTEFullMergedHyperDeflector(_candidate.object_index)) continue
        if(place_meeting(x,y,_candidate)) return true
    }
    return false
}
function scrNTTEFullMergedHyperBegin(_instances) {
    var _out=_instances
    for(var _i=0;_i<array_length(_instances);++_i) if(instance_exists(_instances[_i])) with(_instances[_i]) {
        if(speed<timescale || speed<temerge_hyper_minspeed) continue
        var _projectile=id,_steps=0,_maximum=15*temerge_hyper_speed,
            _melee=scrNTTEFullMergedHyperDeflector(object_index),_team=team,
            _source_team=scrNTTEFullValue(id,"temerge_event_last_team",team)
        team=_source_team
        while(_steps<_maximum && speed>=temerge_hyper_minspeed) {
            if(((current_frame+_steps+0.000001) mod 1)<timescale) {
                for(var _alarm=0;_alarm<12;++_alarm) if(alarm[_alarm]>=0) {
                    alarm[_alarm]-=1
                    if(alarm[_alarm]==0) event_perform(ev_alarm,_alarm)
                    if(!instance_exists(_projectile)) break
                }
                if(!instance_exists(_projectile)) break
            }
            event_perform(ev_step,ev_step_normal)
            if(!instance_exists(_projectile)) break
            scrNTTEFullMergedEffectsMotion(id,true)
            if(random(10)<timescale) instance_create(x,y,Smoke)
            var _stop=place_meeting(x,y,Wall) || place_meeting(x,y,PortalShock)
            if(!_stop && place_meeting(x,y,hitme)) _stop=scrNTTEFullMergedHyperForeignContact(hitme,true)
            if(!_stop && typ!=0) {
                if(place_meeting(x,y,projectile)) _stop=scrNTTEFullMergedHyperForeignContact(projectile,false,false,true)
                if(!_stop) _stop=scrNTTEFullMergedHyperForeignContact([CrystalShield,PopoShield,MeatExplosion,PopoExplosion])
            }
            if(!_stop && _melee && place_meeting(x,y,projectile)) _stop=scrNTTEFullMergedHyperForeignContact(projectile,false,true)
            if(_stop) { x=xprevious; y=yprevious; break }
            event_perform(ev_step,ev_step_end)
            if(!instance_exists(_projectile)) break
            xprevious=x; yprevious=y
            image_index+=image_speed
            if(image_index<0 || image_index>=image_number) {
                image_index-=image_number*sign(image_index)
                event_perform(ev_other,ev_animation_end)
                if(!instance_exists(_projectile)) break
            }
            event_perform(ev_step,ev_step_begin)
            if(!instance_exists(_projectile)) break
            _steps+=timescale
        }
        if(instance_exists(_projectile)) {
            if(team==_source_team) team=_team
            if(speed-friction<temerge_hyper_minspeed) _out=scrNTTEFullMergedEffectsRemove(_out,id)
        }
    }
    return _out
}
function scrNTTEFullHyperSlashCreate() {
    target=noone; sprite_side=0; ntte_hyper_end_follow=false; deflected=false
}
function scrNTTEFullHyperSlashBegin() {
    if(lockstep_stop) return;
    if((image_index>image_speed/timescale || image_speed<=0) && instance_exists(target)) {
        var _tx=target.x,_ty=target.y,_angle=target.image_angle
        if(_angle!=0) {
            var _dir=_angle+180,_len=0.5*(lengthdir_x(xstart-_tx,_dir)+lengthdir_y(ystart-_ty,_dir))
            _tx+=lengthdir_x(_len,_dir); _ty+=lengthdir_y(_len,_dir)
        }
        if(random(2)<timescale) with(instance_create(_tx+orandom(4),_ty+orandom(4),Dust)) motion_set(_angle+orandom(15),4*timescale)
        var _fraction=1-power(1/3,timescale)
        xstart=lerp(xstart,_tx,_fraction); ystart=lerp(ystart,_ty,_fraction)
        if(point_distance(xstart,ystart,target.x,target.y)<1) instance_destroy()
    }
}
function scrNTTEFullHyperSlashCrop(_sprite,_left,_top,_width,_height,_frames,_ox,_oy,_mask=false) {
    // Generate real native sprites with all source frames; neither stretched
    // full sprites nor rectangular collision masks reproduce the cropped trail.
    var _surface=surface_create(max(1,_width),max(1,_height)),_result=-1,
        _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_camera=camera_create_view(0,0,max(1,_width),max(1,_height),0,noone,-1,-1,-1,-1)
    if(!surface_exists(_surface)) throw "HyperSlashTrail native crop surface allocation failed"
    gpu_push_state(); gpu_set_blendmode_ext(bm_one,bm_zero); draw_set_color(c_white); draw_set_alpha(1)
    surface_set_target(_surface); camera_apply(_camera); matrix_set(matrix_world,matrix_build_identity())
    for(var _frame=0;_frame<_frames;++_frame) {
        draw_clear_alpha(c_black,0)
        draw_sprite_part(_sprite,_frame,max(0,_left),_top,max(0,_width+min(0,_left)),_height,0,0)
        if(_frame==0) _result=sprite_create_from_surface(_surface,0,0,max(1,_width),max(1,_height),false,false,_ox,_oy)
        else sprite_add_from_surface(_result,_surface,0,0,max(1,_width),max(1,_height),false,false)
    }
    surface_reset_target(); gpu_pop_state()
    matrix_set(matrix_world,_world); matrix_set(matrix_view,_view); matrix_set(matrix_projection,_projection)
    draw_set_color(_color); draw_set_alpha(_alpha); camera_destroy(_camera); surface_free(_surface)
    if(!sprite_exists(_result)) throw "HyperSlashTrail native crop sprite allocation failed"
    // Separate precise masks preserve per-frame native slash silhouettes.
    sprite_collision_mask(_result,true,0,0,0,0,0,0,0)
    return _result
}
function scrNTTEFullHyperSlashStep() {
    if(lockstep_stop) return;
    if(!instance_exists(target)) { instance_destroy(); return }
    var _target=target,_sprite=_target.sprite_index,_mask=_target.mask_index<0 ? _sprite:_target.mask_index,
        _cut_width=sprite_exists(_sprite) ? ceil((sprite_get_bbox_left(_sprite)+sprite_get_bbox_right(_sprite)+1)/2):0
    x=_target.x; y=_target.y; hspeed=_target.hspeed; vspeed=_target.vspeed
    friction=_target.friction; gravity=_target.gravity; gravity_direction=_target.gravity_direction
    image_index=_target.image_index; image_speed=_target.image_speed
    image_xscale=_target.image_xscale; image_yscale=_target.image_yscale
    image_angle=point_direction(xstart,ystart,x,y); image_blend=_target.image_blend; image_alpha=_target.image_alpha
    visible=_target.visible; depth=_target.depth-1
    deflected=scrNTTEFullValue(_target,"deflected",false); damage=_target.damage
    knockback_speed=_target.knockback_speed; hitid=_target.hitid; typ=_target.typ; team=_target.team; creator=_target.creator
    if(!variable_global_exists("ntte_hyper_trail_sprites")) global.ntte_hyper_trail_sprites={}
    if(!variable_global_exists("ntte_hyper_trail_masks")) global.ntte_hyper_trail_masks={}
    if(sprite_exists(_sprite)) {
        var _key=string(_sprite)+":"+string(sprite_side),_cached=scrNTTEFullValue(global.ntte_hyper_trail_sprites,_key,-1)
        if(!sprite_exists(_cached)) {
            var _center_y=(sprite_get_bbox_top(_sprite)+sprite_get_bbox_bottom(_sprite)+1)/2,
                _cut_y=sprite_side<0 ? floor(_center_y):0,
                _cut_height=(sprite_side>0 ? ceil(_center_y):sprite_get_height(_sprite))-_cut_y
            _cached=scrNTTEFullHyperSlashCrop(_sprite,0,_cut_y,_cut_width,_cut_height,sprite_get_number(_sprite),
                _cut_width,sprite_get_yoffset(_sprite)-_cut_y)
            variable_struct_set(global.ntte_hyper_trail_sprites,_key,_cached)
        }
        sprite_index=_cached
    }
    if(sprite_exists(_mask)) {
        var _key=string(_mask),_cached=scrNTTEFullValue(global.ntte_hyper_trail_masks,_key,-1)
        if(!sprite_exists(_cached)) {
            var _offset=sprite_get_xoffset(_mask)-sprite_get_xoffset(_sprite),
                _mask_x=sprite_get_bbox_left(_sprite)+_offset,_mask_width=_cut_width+_offset-_mask_x
            _cached=scrNTTEFullHyperSlashCrop(_mask,_mask_x,0,_mask_width,sprite_get_height(_mask),sprite_get_number(_mask),
                _mask_width,sprite_get_yoffset(_mask),true)
            variable_struct_set(global.ntte_hyper_trail_masks,_key,_cached)
        }
        mask_index=_cached
    }
    var _offset_length=(sprite_get_xoffset(sprite_index)-sprite_get_xoffset(_sprite))*image_xscale,
        _width=sprite_get_width(sprite_index)
    image_xscale+=point_distance(x,y,xstart,ystart)*(1+sprite_get_bbox_left(sprite_index)/_width)/_width
    x+=lengthdir_x(_offset_length,_target.image_angle); y+=lengthdir_y(_offset_length,_target.image_angle)
    xprevious=x; yprevious=y
}
function scrNTTEFullHyperSlashCollision(_family) {
    if(!instance_exists(target)) return;
    var _trail=id,_target=target,_other=other.id,_angle=image_angle,
        _length=clamp(lengthdir_x(_other.x-xstart,_angle)+lengthdir_y(_other.y-ystart,_angle),0,point_distance(xstart,ystart,_target.x,_target.y)),
        _x=xstart+lengthdir_x(_length,_angle),_y=ystart+lengthdir_y(_length,_angle)
    with(_other) with(_target) {
        var _last_x=x,_last_y=y
        // Original explicitly restores previous positions to the saved current
        // positions, rather than restoring preexisting xprevious/yprevious.
        xprevious+=_x-x; yprevious+=_y-y; x=_x; y=_y
        event_perform(ev_collision,_family)
        if(instance_exists(_target)) { x=_last_x; y=_last_y; xprevious=_last_x; yprevious=_last_y }
    }
    if(instance_exists(_trail)) with(_trail) scrNTTEFullHyperSlashStep()
}
