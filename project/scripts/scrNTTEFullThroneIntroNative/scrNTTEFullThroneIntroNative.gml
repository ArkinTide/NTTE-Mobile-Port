// ntte.mod.gml3693..3816. NTT has a separate NothingIntroMask; Epsilon
// combined its push collision with the damageable body. Preserve the source
// separation with an invisible physical mask shared across the two intro bodies.
function scrNTTEFullThroneIntroAttach(_body) {
    if(!instance_exists(_body)) return noone
    var _mask=noone
    with(NTTEFullThroneIntroMask) if(xstart==_body.xstart && ystart==_body.ystart) {_mask=id;break;}
    if(!instance_exists(_mask)) _mask=instance_create(_body.xstart,_body.ystart,NTTEFullThroneIntroMask)
    _mask.creator=_body
    _body.ntte_throne_intro_mask=_mask
    return _mask
}
function scrNTTEFullThroneIntroMaskCreate() {
    sprite_index=mskNothingInactive;mask_index=mskNothingInactive;image_speed=0
    creator=noone;solid=false;visible=false
}
function scrNTTEFullThroneIntroStep() {
    if(lockstep_stop) return;
    with(NothingInactive) scrNTTEFullThroneIntroAttach(id)
    with(BecomeNothing) scrNTTEFullThroneIntroAttach(id)
    with(NTTEFullThroneIntroMask) {
        if(!instance_exists(creator)) {instance_destroy();continue;}
        var _body=creator,_frame=scrNTTEFullValue(_body,"drawimg",_body.image_index),
            _activating=instance_is(_body,BecomeNothing) && _body.spr_idle==sprNothingActivate && _frame>=1,
            _cool=scrNTTERefSprite("msk.NothingInactiveCool")
        if(_activating) {
            if(_body.depth>=object_get_depth(BackCont)) _body.depth=object_get_depth(Nothing)
            if(_frame>=2) scrNTTEFullThroneIntroBreakWalls(_body,_frame)
        }
        else {_body.depth=max(_body.depth,object_get_depth(BackCont));_body.spr_shadow=-1;}
        if(instance_is(_body,NothingInactive)) {
            if(mask_index==mskNothingInactive) mask_index=_cool
        }
        else if(mask_index==_cool) {
            mask_index=mskNothingInactive
            scrNTTEFullThroneIntroReset(_body)
        }
        // The solid bit is temporary, exactly as source. Reuse the already
        // verified literal telib motion_step implementation, including -1.
        var _was_solid=solid
        solid=true
        with(Player) {
            scrNTTEFullWallFakeMotionStep(id,1)
            if(place_meeting(x,y,other.id)) {
                x=xprevious;y=yprevious
                if(place_meeting(x,y+max(0,vspeed),other.id)) direction=270+30*clamp(hspeed/timescale/4,-1,1)
                else scrNTTEFullThroneIntroWallCollision()
                x+=hspeed;y+=vspeed
            }
            scrNTTEFullWallFakeMotionStep(id,-1)
            if(collision_rectangle(other.x-20,other.y+40,other.x+20,other.y+80,id,false,false)) ntte_stairslow=8
        }
        solid=_was_solid
    }
}
function scrNTTEFullThroneIntroWallCollision() {
    // NTT Player.Collision91 0091c140..0091cf6c tests place_free, not
    // the InvisiWall object type. The modern Epsilon event also integrates
    // x/y again; source's surrounding smooth-collision block already does it.
    if(!roll && race!=Race.Frog) {
        move_contact_solid(direction,max(1,min(maxspeed,speed)))
        if(!place_free(x+hspeed,y)) {
            hspeed/=2
            if(!place_free(x+hspeed,y)) hspeed=0
        }
        if(!place_free(x,y+vspeed)) {
            vspeed/=2
            if(!place_free(x,y+vspeed)) vspeed=0
        }
    }
    else {
        // Original scrPlayerWallBounce 006282b0..00629a60. Frog's second
        // reflection and radius8 obstacle-vector recovery are source logic.
        var _last_direction=direction
        move_bounce_solid(true)
        if(race!=Race.Frog) {angle+=(720-abs(angle))*right*0.7;return;}
        var _bounced_direction=direction
        if(place_free(x+hspeed,y+vspeed)) return;
        move_bounce_solid(true)
        if(direction!=_last_direction) {direction=_bounced_direction;return;}
        var _sx=0,_sy=0
        for(var _oy=2;_oy<=8;_oy+=2) for(var _ox=0;_ox<8;_ox+=2) {
            if(point_distance(0,0,_ox,_oy)>8) continue
            if(!place_free(x+_ox,y+_oy)) {_sx+=_ox;_sy+=_oy}
            if(!place_free(x+_oy,y-_ox)) {_sx+=_oy;_sy-=_ox}
            if(!place_free(x-_ox,y-_oy)) {_sx-=_ox;_sy-=_oy}
            if(!place_free(x-_oy,y+_ox)) {_sx-=_oy;_sy+=_ox}
        }
        direction=point_direction(0,0,_sx,_sy)
    }
}
function scrNTTEFullThroneIntroBreakWalls(_body,_frame) {
    with(_body) {
        var _last_mask=mask_index
        mask_index=object_get_mask(Nothing)
        if(place_meeting(x,y,Wall)) {
            var _walls=ds_list_create(),_bottom=bbox_bottom-1,_right=bbox_right-1,
                _top=lerp(_bottom,bbox_top,clamp(floor(_frame)/6,0,1))
            collision_rectangle_list(bbox_left,_top,_right,_bottom,Wall,false,false,_walls,false)
            for(var _i=0;_i<ds_list_size(_walls);++_i) {
                var _wall=_walls[|_i],_meeting=false
                with(_wall) _meeting=place_meeting(x,y,other.id)
                if(_meeting) {instance_create(_wall.x,_wall.y,FloorExplo);instance_destroy(_wall);}
            }
            ds_list_destroy(_walls)
        }
        mask_index=_last_mask
    }
}
function scrNTTEFullThroneIntroReset(_body) {
    with(_body) {
        if(object_get_depth(NothingPipes)<=depth) {
            var _pipe=instance_nearest(x,y,NothingPipes)
            if(instance_exists(_pipe)) {
                var _picture=instance_create(x,y,NTTEFullThroneIntroDecoration)
                _picture.sprite_index=object_get_sprite(NothingPipes);_picture.depth=depth
                instance_destroy(_pipe)
            }
        }
        for(var _side=-1;_side<=1;_side+=2) {
            var _flame=instance_create(x+81*_side,y-38,Wind);_flame.sprite_index=sprThroneFlameEnd
            _flame=instance_create(x+81*_side,y+18,Wind);_flame.sprite_index=sprThroneFlameEnd
        }
    }
}
function scrNTTEFullThroneIntroShadowDraw(_vx,_vy) {
    with(BecomeNothing) if(visible && spr_idle==sprNothingActivate && drawimg>=1)
        draw_sprite(scrNTTERefSprite("shd.Nothing"),0,x-_vx,y-_vy)
}
