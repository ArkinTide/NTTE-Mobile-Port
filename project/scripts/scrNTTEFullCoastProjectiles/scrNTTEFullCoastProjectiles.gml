// tecoast214..460,4371..4390; teoasis1087..1170.
function scrNTTEFullSealDiscCreate() { sprite_index=scrNTTERefSprite("SealDisc"); mask_index=mskNTTEFullSealDisc; trail_color=make_color_rgb(252,56,0) }
function scrNTTEFullSealDiscEndStep() {
    if (lockstep_stop || team!=-1) return;
    with (DiscTrail) if (image_blend==c_white && xstart==other.xprevious && ystart==other.yprevious) image_blend=other.team==2 ? c_yellow:other.trail_color
}
function scrNTTEFullHyperBubbleCreate() {
    mask_index=mskNone; hits=3; damage=12; knockback_speed=12*timescale; sprite_index=mskNone
    temerge_on_setup=scrNTTEFullHyperBubbleMerge
}
function scrNTTEFullHyperBubbleMerge(_instances) {
    if (!variable_global_exists("ntte_full_projectile_merge_effect") || !is_callable(global.ntte_full_projectile_merge_effect)) throw "HyperBubble requires original merged projectile effect provider"
    var _provider=global.ntte_full_projectile_merge_effect
    _provider(_instances,"hyper",[])
    _provider(_instances,"explosion",[{is_bubble:true}])
}
function scrNTTEFullHyperBubbleEndStep() {
    if (lockstep_stop) return;
    mask_index=mskBullet1
    var _dist=100,_dir=direction,_mx=lengthdir_x(16,_dir),_my=lengthdir_y(16,_dir),_targets=[]
    with (hitme) if (team!=other.team) array_push(_targets,id)
    scr_projectile_create(x,y,NTTEFullBubbleExplosionSmall)
    while (_dist-->0 && hits>0 && !place_meeting(x,y,Wall)) {
        x+=_mx; y+=_my
        if (random(3)<1) with (instance_create(x+orandom(4),y+orandom(4),Bubble)) { motion_set(_dir+orandom(4),(6+random(4))*timescale); friction=0.2*timescale*timescale }
        if (random(3)<2) with (instance_create(x+orandom(2),y+orandom(2),Smoke)) motion_set(_dir+orandom(4),(2+random(2))*timescale)
        if (place_meeting(x,y,hitme)) {
            var _hit=false
            for(var _i=0;_i<array_length(_targets);++_i) {
                var _target=_targets[_i]
                if (instance_exists(_target) && _target.hp>0 && place_meeting(x,y,_target)) {
                    if (!_hit) { _hit=true; hits--; scr_projectile_create(x,y,NTTEFullBubbleExplosionSmall) }
                    scr_projectile_hit(_target,damage,knockback_speed,_dir)
                }
            }
        }
    }
    scr_projectile_create(x,y,NTTEFullBubbleExplosion)
    repeat(max(0,hits)) scr_projectile_create(x,y,NTTEFullBubbleExplosionSmall)
    instance_destroy()
}
function scrNTTEFullClamShieldCreate() {
    sprite_index=scrNTTERefSprite("ClamShield"); mask_index=mskOldGuardianDeflect; image_speed=0
    damage=0; knockback_speed=3*timescale; typ=0; wep=wep_ntte_clam_shield; candeflect=true
    spr_shadow=shd16; spr_shadow_x=0; spr_shadow_y=7; ntte_clam_surface=-1; ntte_clam_camera=-1
    ntte_clam_last_angle=undefined;ntte_clam_last_shine=undefined
}
function scrNTTEFullClamShieldBackSlot() {
    if (variable_instance_exists(id,"ntte_clam_state") && instance_is(creator,Player)) {
        return scrNTTEFullMergedRuntimeStateHas(creator,false,ntte_clam_state) && !scrNTTEFullMergedRuntimeStateHas(creator,true,ntte_clam_state)
    }
    return wep==scrNTTEFullValue(creator,"bwep",wep_none)
}
function scrNTTEFullClamShieldStep() {
    if (lockstep_stop) return;
    var _front=scrNTTEFullValue(creator,"wep",wep),_back=scrNTTEFullValue(creator,"bwep",wep_none)
    if (!instance_exists(creator) || !creator.visible) { instance_destroy(); return }
    var _physical_state=variable_instance_exists(id,"ntte_clam_state") && instance_is(creator,Player),_back_slot=scrNTTEFullClamShieldBackSlot()
    if (_physical_state) {
        var _front_state=scrNTTEFullValue(creator,"ntte_state",undefined),_back_state=scrNTTEFullValue(creator,"bntte_state",undefined)
        if (!is_struct(ntte_clam_state) || (!scrNTTEFullMergedRuntimeStateHas(creator,true,ntte_clam_state) && !scrNTTEFullMergedRuntimeStateHas(creator,false,ntte_clam_state)) || (_back_slot && creator.race!=Race.Steroids)) { instance_destroy(); return }
        wep=_back_slot ? _back:_front
    }
    else if (wep!=_front && wep!=_back) { instance_destroy(); return }
    var _shields=[],_bolts=[],_prefix=_back_slot ? "b":""
    with (NTTEFullClamShield) if (creator==other.creator) {
        if (_physical_state) {
            if (variable_instance_exists(id,"ntte_clam_state") && ntte_clam_state==other.ntte_clam_state) array_push(_shields,id)
        }
        else if (wep==other.wep) array_push(_shields,id)
    }
    with (BoltStick) if (target==other.id) array_push(_bolts,id)
    if (variable_instance_exists(creator,"gunangle")) {
        var _num=array_length(_shields),_at=array_get_index(_shields,id),_goal=creator.gunangle+180*((_at-(_num-1)/2)/_num),_last=image_angle
        if (_back_slot && scrNTTEFullWeaponRaw(_front)==scrNTTEFullWeaponRaw(_back)) _goal+=180
        image_angle+=angle_difference(_goal,image_angle)*(1-power(instance_is(creator,Player) ? 0.5:15/16,timescale))
        direction=image_angle
        for(var _i=0;_i<array_length(_bolts);++_i) _bolts[_i].image_angle+=image_angle-_last
    }
    var _length=16-scrNTTEFullValue(creator,_prefix+"wkick",0)
    if (_length>=0) _length=max(_length,12)
    x=creator.x+lengthdir_x(_length,image_angle); y=creator.y+lengthdir_y(_length,image_angle); xprevious=x; yprevious=y; depth=creator.depth-(y>creator.y)
    for(var _i=0;_i<array_length(_bolts);++_i) with (_bolts[_i]) {
        var _dis=2+sprite_get_xoffset(sprite_index)-sprite_get_bbox_right(sprite_index)
        x=other.x+lengthdir_x(_dis,image_angle); y=other.y+lengthdir_y(_dis,image_angle)
    }
}
function scrNTTEFullClamShieldHit(_target) {
    if (lockstep_stop || !instance_exists(_target) || instance_is(_target,prop)) return;
    with (_target) motion_add(other.image_angle,other.knockback_speed/max(size,1))
}
function scrNTTEFullClamShieldProjectile(_projectile) {
    if(scrNTTEFullFriendlyMonsterShot(id,_projectile)) return;
    if (lockstep_stop || !instance_exists(_projectile)) return;
    var _shield=id,_ts=max(timescale,0.000001)
    with (_projectile) {
        if ((typ!=1 && typ!=2) || speed<=0 || instance_is(id,ToxicGas)) return;
        var _deflect_dir=_shield.image_angle,_type=_shield.candeflect ? typ:2
        if (!(instance_is(_shield.creator,Player) && team!=_shield.team) && abs(angle_difference(direction+180,_deflect_dir))>=90) return;
        var _prefix="",_force=knockback_speed/_ts
        with (_shield) if (scrNTTEFullClamShieldBackSlot()) _prefix="b"
        var _key=_prefix+"wkick"
        if (variable_instance_exists(_shield.creator,_key)) {
            var _kick=variable_instance_get(_shield.creator,_key)
            if (abs(_kick)<4) _kick+=max(-8,(4+_force/2)*(_type==1 ? -1:1))
            variable_instance_set(_shield.creator,_key,_kick)
        }
        if (_force>3) with (_shield.creator) {
            speed=max(speed,friction/_ts)
            motion_add(other.direction,other.knockback_speed/(_type==2 ? 3:6))
        }
        if (_type==1) {
            speed+=friction*3; direction=_deflect_dir-clamp(angle_difference(direction+180,_deflect_dir),-40,40); image_angle=direction
            if (instance_is(_shield.creator,Player)) { deflected=true; team=_shield.team }
        }
        snd_play(sndCrystalRicochet,1+random(0.2),3)
        with (instance_create(x,y,Deflect)) image_angle=_deflect_dir
        if (random(2)<1 && random(12)<_force) with (instance_create(x,y,Bubble)) motion_set(other.image_angle+orandom(10),random_range(1,3)*timescale)
        else instance_create(x,y,Dust)
        sleep(min(100,damage))
        if (_type==2) {
            if (array_get_index([sprBolt,sprBoltGold,sprHeavyBolt,sprUltraBolt,sprSplinter,sprSeeker],sprite_index)>=0) {
                with (instance_create(x,y,BoltStick)) { sprite_index=other.sprite_index; image_index=image_number-1; image_angle=other.image_angle; target=_shield }
            }
            instance_destroy()
        }
    }
}
function scrNTTEFullClamShieldGrenade(_projectile) {
    var _team=team
    scrNTTEFullClamShieldProjectile(_projectile)
    team=_team
}
function scrNTTEFullClamShieldDraw() {
    var _num=image_number,_off=_num/7*image_xscale,_w=2*(_off+max(abs(sprite_height),abs(sprite_width)+ceil((_num-1)*2/3*image_xscale))),
        _px=x+lengthdir_x(-6,image_angle),_py=y+lengthdir_y(-6,image_angle)+5,
        _scale=scrNTTEFullVisualQuality("main"),_size=scrNTTEFullQualitySurfaceSize(_w,_scale),_shine=scrNTTEFullValue(creator,"gunshine",0),
        _reset=!surface_exists(ntte_clam_surface)
    if(!_reset) _reset=surface_get_width(ntte_clam_surface)!=_size || surface_get_height(ntte_clam_surface)!=_size
    if (_reset) {
        if (surface_exists(ntte_clam_surface)) surface_free(ntte_clam_surface)
        ntte_clam_surface=surface_create(_size,_size)
        if (ntte_clam_camera!=-1) camera_destroy(ntte_clam_camera)
        ntte_clam_camera=camera_create_view(0,0,_w,_w,0,noone,-1,-1,-1,-1)
    }
    if (!surface_exists(ntte_clam_surface)) return;
    var _world=matrix_get(matrix_world),_view=matrix_get(matrix_view),_projection=matrix_get(matrix_projection),
        _color=draw_get_color(),_alpha=draw_get_alpha(),_active=false
    gpu_push_state()
    try {
        gpu_set_blendmode(bm_normal);gpu_set_fog(false,0,0,0);draw_set_alpha(1);draw_set_color(c_white)
        if(_reset || is_undefined(ntte_clam_last_angle) || abs(ntte_clam_last_angle-image_angle)>1 || ntte_clam_last_shine!=_shine) {
            ntte_clam_last_angle=image_angle;ntte_clam_last_shine=_shine
            surface_set_target(ntte_clam_surface);_active=true
            scrNTTEFullQualityCamera(ntte_clam_camera,_px-_w/2,_py-_w/2,_w,_w);draw_clear_alpha(c_black,0)
            for(var _i=0;_i<_num;++_i) {
                var _distance=_off*(1-sqr((_i-(_num-1)/3)/((_num-1)/2)))
                draw_sprite_ext(sprite_index,_i,_px+lengthdir_x(_distance,image_angle),_py+lengthdir_y(_distance,image_angle)-_i*image_xscale*2/3,image_xscale*1.5,image_yscale,image_angle,image_blend,1)
            }
            gpu_set_colorwriteenable(true,true,true,false)
            draw_sprite_ext(scrNTTERefSprite("Shine24"),_shine,_px,_py,image_xscale,image_yscale,0,image_blend,1)
            gpu_set_colorwriteenable(true,true,true,true)
            surface_reset_target();_active=false
        }
        matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        gpu_set_fog(true,c_black,0,0)
        for(var _d=0;_d<360;_d+=90) draw_surface_ext(ntte_clam_surface,_px-_w/2+lengthdir_x(1,_d),_py-_w/2+lengthdir_y(1,_d),1/_scale,1/_scale,0,c_white,image_alpha)
        gpu_set_fog(false,0,0,0)
        draw_surface_ext(ntte_clam_surface,_px-_w/2,_py-_w/2,1/_scale,1/_scale,0,c_white,image_alpha)
    }
    finally {
        if(_active) surface_reset_target()
        gpu_pop_state();matrix_set(matrix_world,_world);matrix_set(matrix_view,_view);matrix_set(matrix_projection,_projection)
        draw_set_color(_color);draw_set_alpha(_alpha)
    }
}
function scrNTTEFullClamShieldCleanup() {
    if (surface_exists(ntte_clam_surface)) surface_free(ntte_clam_surface)
    if (ntte_clam_camera!=-1) camera_destroy(ntte_clam_camera)
    ntte_clam_surface=-1; ntte_clam_camera=-1
}
function scrNTTEFullCoastProjectilesSmoke() {
    var _before=scrNTTEFullInstances(all),_owner=instance_create(47000,47000,Gator)
    _owner.gunangle=0; _owner.wkick=0
    var _shield=instance_create(47000,47000,NTTEFullClamShield)
    _shield.creator=_owner; _shield.team=_owner.team
    with (_shield) scrNTTEFullClamShieldStep()
    assert(_shield.mask_index==mskOldGuardianDeflect && _shield.damage==0 && _shield.typ==0 && _shield.x==_owner.x+16 && _shield.y==_owner.y,
        "ClamShield source mask/zero damage/type/follow distance changed")
    var _bullet=instance_create(_shield.x,_shield.y,EnemyBullet1)
    _bullet.typ=1; _bullet.direction=180; _bullet.speed=6*timescale; _bullet.team=team_player
    with (_shield) scrNTTEFullClamShieldProjectile(_bullet)
    assert(instance_exists(_bullet) && abs(angle_difference(_bullet.direction,0))<=0.00001 && _bullet.team==team_player,
        "Nonplayer ClamShield reflection changed direction or source no-team-change rule")
    var _disc=instance_create(47000,47000,NTTEFullSealDisc)
    assert(_disc.sprite_index==scrNTTERefSprite("SealDisc") && _disc.damage==6 && _disc.typ==1 && _disc.trail_color==make_color_rgb(252,56,0),
        "SealDisc lost actual native Disc behavior/original art/trail")
    var _hyper=instance_create(47200,47000,NTTEFullHyperBubble)
    _hyper.team=team_player; _hyper.direction=0
    assert(_hyper.hits==3 && _hyper.damage==12 && _hyper.knockback_speed==12*timescale && _hyper.mask_index==mskNone,"HyperBubble source three impacts/12damage/12force changed")
    var _small=instance_number(NTTEFullBubbleExplosionSmall),_big=instance_number(NTTEFullBubbleExplosion)
    with (_hyper) scrNTTEFullHyperBubbleEndStep()
    assert(!instance_exists(_hyper) && instance_number(NTTEFullBubbleExplosionSmall)==_small+4 && instance_number(NTTEFullBubbleExplosion)==_big+1,
        "HyperBubble clear hitscan omitted muzzle+three remaining small bubbles or final explosion")
    var _all=scrNTTEFullInstances(all)
    for(var _i=0;_i<array_length(_all);++_i) if (array_get_index(_before,_all[_i])<0) instance_destroy(_all[_i],false)
    scrNTTESmokeLog("FULL WORLD CLAM SHIELD ORIGINAL MASK/ZERO DAMAGE/FOLLOW/NONPLAYER REFLECT FACTION + REAL SEAL DISC + HYPER BUBBLE THREE IMPACTS/12 DAMAGE/CLEAR HITSCAN EXPLOSIONS OK; SHIELD GPU DRAW/MERGE COVERED SEPARATELY")
}
