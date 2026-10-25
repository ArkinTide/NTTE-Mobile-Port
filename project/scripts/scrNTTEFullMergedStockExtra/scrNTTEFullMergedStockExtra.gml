// NTTE2.062 extra stock callbacks, preserving the original per-shot closures.
// Sources: objects/tetrench.mod.gml1796..1846,4408..4447;
// objects/telabs.mod.gml2027..2033,2335..2453.
// Native mapping: original QuasarBeam => NTTEFullQuasarBeam descendants,
// LightningDisc => NTTEFullLightningDisc, PortalBullet => NTTEFullPortalBullet.
function scrNTTEFullMergedQuasarBeamFire(_at,_info) {
    _info.spr_hit=ntte_full_hit;_info.spr_trail=ntte_full_trail
    _info.line_dis_max=ntte_full_max_distance;_info.scale_goal=ntte_full_scale_goal
    _info.is_ring=ntte_full_ring
}
function scrNTTEFullMergedQuasarBeamSetup(_list,_info) {
    scrNTTEFullMergedProjectileAddScale(_list,0.25*_info.scale_goal)
    scrNTTEFullMergedProjectileAddDamage(_list,3*_info.scale_goal)
    scrNTTEFullMergedProjectileAddForce(_list,2*_info.scale_goal)
    scrNTTEFullMergedProjectileAddEffect(_list,"piercing",[1])
    if(_info.is_ring) {
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i])
            scrNTTEFullMergedProjectileAddEffect(id,"wall_piercing",[sqrt(damage)])
    }
    else {
        // NTT's Effect pseudo-family has no native root in Epsilon. Only the
        // two exact newly-created FX sprites below are eligible for retinting.
        // Original _minID/instance_max bounds the births of this synchronous
        // callback. Keep that boundary without enumerating the whole room.
        var _before=scrNTTEFullMergedCaptureBegin(),_moving=[]
        for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i]) && _list[_i].speed!=0) array_push(_moving,_list[_i])
        // telib.array_shuffle1945: forward Fisher-Yates, final draw included.
        for(var _i=0;_i<array_length(_moving);++_i) {
            var _j=irandom_range(_i,array_length(_moving)-1),_swap=_moving[_i]
            _moving[_i]=_moving[_j];_moving[_j]=_swap
        }
        scrNTTEFullMergedProjectileAddEffect(_moving,"laser",[_info.line_dis_max])
        var _effects=scrNTTEFullMergedRuntimeNew(_before)
        for(var _i=0;_i<array_length(_effects);++_i) {
            var _fx=_effects[_i]
            if(_fx.sprite_index==sprPlasmaTrail) _fx.sprite_index=_info.spr_hit
            else if(_fx.sprite_index==scrNTTERefSprite("AllyLaserCharge")) _fx.sprite_index=_info.spr_trail
        }
    }
}
function scrNTTEFullMergedLightningDiscFire(_at,_info) {
    _info.super=ntte_full_super
}
function scrNTTEFullMergedLightningDiscSetup(_list,_info) {
    if(_info.super<0) return;
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        if(!variable_instance_exists(id,"temerge_lightning_disc")) {
            temerge_lightning_disc={super_count:0}
            scrNTTEFullMergedProjectileAddEvent(id,"destroy",scrNTTEFullMergedLightningDiscDestroy)
        }
        temerge_lightning_disc.super_count+=1
    }
}
function scrNTTEFullMergedLightningDiscHit() {
    if(!scrNTTEFullMergedProjectileCanHit(other.id)) return;
    var _dir=random(360),_xoff=dcos(_dir),_yoff=-dsin(_dir)
    // NTT inclusive bbox_right+1/bottom+1 are modern exclusive maximums.
    _xoff=clamp((_xoff<0?bbox_left:bbox_right)-x,-32,32)*abs(_xoff)
    _yoff=clamp((_yoff<0?bbox_top:bbox_bottom)-y,-32,32)*abs(_yoff)
    var _angle=point_direction(x+_xoff,y+_yoff,other.x,other.y)+orandom(12)
    // The separate original-Lightning constructor/Alarm0 bridge preserves the
    // source synchronous recursive chain of real native lightning nodes.
    var _node=scrNTTEFullMergedBasicProjectileCreate(x+_xoff,y+_yoff,Lightning,_angle,0)
    // Underwater source Create resolves the screen-wide strike immediately.
    if(instance_exists(_node)) {
        _node.ammo=min(28,irandom_range(floor(damage*0.5),ceil(damage)))
        with(_node) event_perform(ev_alarm,0)
    }
}
function scrNTTEFullMergedLightningDiscDestroy() {
    repeat(max(0,temerge_lightning_disc.super_count)) {
        var _disc=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullLightningDisc,direction,10)
        _disc.ntte_full_charge=lerp(damage/10,1,0.5)
        _disc.ntte_full_follow=false
        _disc.image_xscale=_disc.ntte_full_charge*0.9;_disc.image_yscale=_disc.image_xscale
    }
}

// Call once after native PortalBullet Create, before collecting source hooks.
// Every original PortalBullet owns its own shared info; all descendants of that
// one replacement share it. A global object-index callback cannot hold it.
function scrNTTEFullMergedPortalBind(_projectile) {
    if(!instance_exists(_projectile)) return undefined
    if(variable_instance_exists(_projectile,"temerge_portal_info")) return _projectile.temerge_portal_info
    var _info={teleport_instance_list:[],can_teleport:true}
    _projectile.temerge_portal_info=_info
    _projectile.temerge_on_setup=scrNTTEFullMergedEffectRef(scrNTTEFullMergedPortalSetup,[_info])
    _projectile.temerge_on_hit=scrNTTEFullMergedEffectRef(scrNTTEFullMergedPortalHit,[_info])
    return _info
}
function scrNTTEFullMergedPortalSetup(_info,_list,_unused=undefined) {
    for(var _i=0;_i<array_length(_list);++_i) if(instance_exists(_list[_i])) with(_list[_i]) {
        if(_info.can_teleport) {
            image_blend=make_color_rgb(136,0,255)
            array_push(_info.teleport_instance_list,id)
        }
        var _fx=instance_create(x,y,WepSwap)
        _fx.sprite_index=asset_get_index("sprPortalL"+string(irandom_range(1,5)))
        if(instance_is(creator,Player)) _fx.creator=creator
    }
}
function scrNTTEFullMergedPortalHit(_info) {
    if(!instance_exists(creator) || !(creator.visible || (variable_instance_exists(creator,"wading") && creator.wading>0))
        || !scrNTTEFullMergedProjectileCanHit(other.id) || !_info.can_teleport) return;
    _info.can_teleport=false
    var _hit_x=x,_hit_y=y,_projectile=id,_owner=creator,_target=other.id
    with(_target) {
        if(size<6) {
            _hit_x=x;_hit_y=y
            if((!instance_is(id,prop) && team!=team_none) || instance_is(id,RadChest)
                || instance_is(id,Car) || instance_is(id,CarVenus) || instance_is(id,CarVenusFixed)
                || instance_is(id,CarThrow) || instance_is(id,MeleeFake) || instance_is(id,JungleAssassinHide)) {
                x=instance_exists(_owner)?_owner.x:_projectile.xstart
                y=instance_exists(_owner)?_owner.y:_projectile.ystart
                xprevious=x;yprevious=y
                if(instance_is(id,Player) && _owner==id) angle+=180+orandom(10)
                repeat(3) scrNTTEFullMergedStockFX(x,y,2,Smoke)
                scrNTTEFullMergedBasicSoundAt(x,y,sndPortalAppear,2.5,2,64)
                scrNTTEFullWorldWallClear(id)
            }
        }
        if(!scrNTTEFullWorldBudge(id,Wall,40)) scrNTTEFullWorldWallClear(id)
    }
    with(_owner) {
        var _fx=instance_create(x,y,BulletHit)
        _fx.sprite_index=sprPortalDisappear;_fx.image_angle=0
        x=_hit_x;y=_hit_y;xprevious=x;yprevious=y
        _fx=instance_create(x,y,BulletHit)
        _fx.sprite_index=scrNTTERefSprite("PortalBulletHit");_fx.image_angle=0
        scrNTTEFullMergedBasicSoundAt(x,y,sndPortalAppear,3,instance_is(id,Player)?0.5:1.5,64)
        nexthurt=max(nexthurt,current_frame+10)
    }
    for(var _i=0;_i<array_length(_info.teleport_instance_list);++_i) if(instance_exists(_info.teleport_instance_list[_i])) with(_info.teleport_instance_list[_i]) {
        if(id!=_projectile) {
            // NTT raw speed is the actual physical per-frame movement.
            var _fx=instance_create(x+hspeed,y+vspeed,BulletHit)
            _fx.sprite_index=sprThrowHit;_fx.image_blend=image_blend;_fx.depth=depth+1
        }
        image_blend=c_white
    }
    // The original invokes the native collision once after moving the target.
    // The adapter's scoped pair stack suppresses re-entering this callback.
    if(instance_exists(_projectile) && instance_exists(_target))
        with(_target) with(_projectile) event_perform(ev_collision,hitme)
}
// Object-table validation requires explicit callables for the two known source
// entries. Proper per-source refs installed by PortalBind override these. A
// missing binding is a real integration error, never a silent no-op fallback.
function scrNTTEFullMergedPortalSetupUnbound(_list,_unused=undefined) {
    throw "PortalBullet merged setup requires per-source PortalBind before replacement"
}
function scrNTTEFullMergedPortalHitUnbound() {
    throw "PortalBullet merged hit requires per-source PortalBind before replacement"
}
