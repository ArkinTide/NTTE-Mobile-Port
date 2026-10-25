// Native port of telabs.mod.gml PortalBullet/Guardian and portal_poof.
// Original object names are retained in comments; all runtime assets use the
// exact ref importer. The weapon slot associates a transient state reference.
function scrNTTEFullPortalFx(_x,_y,_spr,_depth=-3,_xs=1,_ys=1,_angle=0) {
    var _fx=instance_create(_x,_y,BulletHit)
    _fx.sprite_index=_spr; _fx.depth=_depth; _fx.image_xscale=_xs; _fx.image_yscale=_ys; _fx.image_angle=_angle
    return _fx
}

function scrNTTEFullWorldWallClear(_who) {
    if (!instance_exists(_who)) return noone
    var _clear=instance_create(_who.x,_who.y,PortalClear)
    _clear.sprite_index=_who.mask_index<0 ? _who.sprite_index:_who.mask_index
    _clear.image_xscale=_who.image_xscale; _clear.image_yscale=_who.image_yscale; _clear.image_angle=_who.image_angle
    return _clear
}

// telib.instance_budge; omitted distance uses the source bbox aspect ratio.
// Scalar object/instance avoid is sufficient for the original current callers.
function scrNTTEFullWorldBudge(_who,_avoid,_max=undefined) {
    if (!instance_exists(_who)) return false
    var _free=false
    with (_who) {
        var _outside=!place_meeting(xprevious,yprevious,Floor),_mx=1,_my=1
        if (is_undefined(_max)) {
            var _ow=0,_oh=0
            if (object_exists(_avoid)) {
                var _mask=object_get_mask(_avoid)
                if (_mask<0) _mask=object_get_sprite(_avoid)
                _ow=sprite_get_bbox_right(_mask)+1-sprite_get_bbox_left(_mask)
                _oh=sprite_get_bbox_bottom(_mask)+1-sprite_get_bbox_top(_mask)
            }
            else if (instance_exists(_avoid)) { _ow=_avoid.bbox_right+1-_avoid.bbox_left; _oh=_avoid.bbox_bottom+1-_avoid.bbox_top }
            var _w=_ow+bbox_right+1-bbox_left,_h=_oh+bbox_bottom+1-bbox_top
            _mx=max(1,_w/_h); _my=max(1,_h/_w); _max=sqrt(sqr(min(_w,_h)-1)*2)
        }
        var _dir=direction+180,_d=0,_dadd=max(1,_max/16)
        if (x!=xprevious || y!=yprevious) _dir=point_direction(x,y,xprevious,yprevious)
        while (true) {
            var _angle=_dir,_astep=360/max(1,4*_d)
            repeat(ceil(360/abs(_astep))) {
                var _ox=x,_oy=y
                x+=lengthdir_x(_d*_mx,_angle); y+=lengthdir_y(_d*_my,_angle)
                if (!place_meeting(x,y,_avoid)
                    && (_outside || (place_free(x,y) && (position_meeting(x,y,Floor) || place_meeting(x,y,Floor))))) {
                    xprevious=x; yprevious=y; _free=true; _d=_max; break
                }
                x=_ox; y=_oy; _angle+=_astep
            }
            if (_d>=_max) break
            _d=min(_d+clamp(_d,1,_dadd),_max)
        }
    }
    return _free
}

function scrNTTEFullPortalBulletCreate() {
    spr_spwn=scrNTTERefSprite("PortalBulletSpawn"); spr_idle=scrNTTERefSprite("PortalBullet")
    sprite_index=spr_spwn; image_speed=0.4*timescale; depth=-5
    mask_index=mskNone; mask=object_get_mask(SuperFlakBullet); damage=2; knockback_speed=0; typ=1
    offset=12; creator=noone; portal=false; hold=true; spec=false; primary=true
    ntte_portal_state=undefined; ntte_portal_last_owner_angle=undefined
    ntte_portal_destroyed=false
}

function scrNTTEFullPortalBulletAnimate() {
    if (sprite_index!=spr_spwn) return;
    sprite_index=spr_idle; mask_index=mask
    snd_play(sndGuardianHurt,0.4+random(0.1),0.3)
    repeat(3) { var _f=instance_create(x,y,Smoke); with (_f) motion_set(random(360),3*timescale) }
}

function scrNTTEFullPortalBulletHeldByPlayer() {
    if (!instance_is(creator,Player) || !creator.visible || !is_struct(ntte_portal_state)) return false
    var _shield=false
    with (CrystalShield) if (creator==other.creator) { _shield=true; break }
    if (_shield) return false
    var _key=spec ? KeyCont.hold_spec[creator.index]:KeyCont.hold_fire[creator.index]
    var _slot=primary ? creator.ntte_state:creator.bntte_state
    return _key && _slot==ntte_portal_state
}

function scrNTTEFullPortalBulletStep() {
    if (lockstep_stop) return;
    image_speed=0.4*timescale
    if (hold) {
        if (sprite_index==spr_spwn || scrNTTEFullPortalBulletHeldByPlayer()) {
            if (instance_exists(creator)) {
                if (instance_is(creator,Player)) {
                    if (!is_undefined(ntte_portal_last_owner_angle)) {
                        var _turn=angle_difference(creator.gunangle,ntte_portal_last_owner_angle)
                        direction+=_turn; image_angle+=_turn
                    }
                    ntte_portal_last_owner_angle=creator.gunangle
                }
                var _last=mask_index,_kick=0
                var _kn=primary ? "wkick":"bwkick"
                if (variable_instance_exists(creator,_kn)) _kick=variable_instance_get(creator,_kn)
                mask_index=object_get_mask(Ally); x=creator.x; y=creator.y
                move_contact_solid(direction,offset-_kick); mask_index=_last
            }
            x-=hspeed; y-=vspeed
        }
        else {
            hold=false
            if (instance_exists(creator)) {
                var _kn=primary ? "wkick":"bwkick"
                if (variable_instance_exists(creator,_kn)) variable_instance_set(creator,_kn,10)
            }
            snd_play(sndGuardianHurt,1.5+orandom(0.2))
            repeat(5) { var _f=instance_create(x,y,Dust); with (_f) motion_set(other.direction+orandom(60),3*timescale) }
        }
    }
    else {
        var _slowleft=0.5
        with (hitme) {
            if (_slowleft<=0) break
            if (team==other.team && size>0 && distance_to_object(other.id)<32) {
                var _slow=min(_slowleft,size/20)
                _slowleft-=_slow
                other.x-=other.hspeed*_slow; other.y-=other.vspeed*_slow
            }
        }
    }
    if (random(15)<timescale) {
        var _fx=instance_create(x+hspeed,y+vspeed,PortalL)
        _fx.depth=depth+choose(0,-1)
    }
}

function scrNTTEFullPortalBulletEndStep() {
    if (lockstep_stop || !instance_is(creator,NTTEFullPortalGuardian)) return;
    var _self=id,_other=noone
    with (NTTEFullPortalBullet) {
        if (id!=_self && team!=other.team && place_meeting(x,y,_self)) { _other=id; break }
    }
    if (!instance_exists(_other)) return;
    creator.implode=true; creator.hp=0
    if (instance_is(_other.creator,NTTEFullPortalGuardian)) {
        _other.creator.implode=true; _other.creator.hp=0
    }
    else _other.creator=noone
    instance_destroy(_other)
    instance_destroy()
}

function scrNTTEFullPortalCanSwap(_who) {
    return _who.size<6 && ((!instance_is(_who,prop) && _who.team!=team_none)
        || instance_is(_who,RadChest) || instance_is(_who,Car) || instance_is(_who,CarVenus)
        || instance_is(_who,CarVenusFixed) || instance_is(_who,CarThrow) || instance_is(_who,MeleeFake)
        || instance_is(_who,JungleAssassinHide))
}

function scrNTTEFullPortalBulletHit(_who) {
    if (lockstep_stop || !instance_exists(_who) || _who.hp<=0) return;
    var _selfhit=_who==creator && instance_is(creator,NTTEFullPortalGuardian)
    if (!_selfhit && !scr_can_hit(_who)) return;
    if (!instance_is(creator,Player) && (instance_is(_who,prop) || _who.team==team_none)) return;
    if (!scr_projectile_hit(_who,damage,0)) return;
    with (_who) nexthurt=max(nexthurt,current_frame+80)
    if (creator==_who && instance_is(creator,NTTEFullPortalGuardian)) {
        _who.implode=true; _who.hp=0; creator=noone; instance_destroy(); return;
    }
    var _makeportal=portal && instance_is(_who,Player)
    if (_makeportal && instance_exists(creator)) { creator.speed=0; creator.hp=0 }
    if (scrNTTEFullPortalCanSwap(_who)) {
        with (_who) {
            x=instance_exists(other.creator) ? other.creator.x:other.xstart
            y=instance_exists(other.creator) ? other.creator.y:other.ystart
            xprevious=x; yprevious=y
            if (instance_is(id,Player) && other.creator==id) angle+=180+orandom(10)
            scrNTTEFullPortalFx(x,y,sprPortalDisappear,depth-1)
            repeat(3) { var _f=instance_create(x,y,Smoke); with (_f) motion_set(random(360),2*timescale) }
            snd_play(sndPortalAppear,2.5,2)
            scrNTTEFullWorldWallClear(id)
        }
    }
    if (_makeportal) {
        var _px=_who.x,_py=_who.y
        instance_destroy()
        if (instance_exists(_who)) instance_create(_px,_py,Portal)
    }
    else instance_destroy()
}

function scrNTTEFullPortalBulletDestroy() {
    if (ntte_portal_destroyed) return;
    ntte_portal_destroyed=true
    repeat(5) { var _fx=instance_create(x,y,Smoke); with (_fx) motion_set(other.direction,2*timescale) }
    snd_play(sndGuardianDisappear,2,2)
    var _teleport=false
    if (instance_exists(creator) && (creator.visible || (variable_instance_exists(creator,"wading") && creator.wading>0))) {
        _teleport=position_meeting(x,y,Floor) || place_meeting(x,y,Floor)
            || (point_distance(x,y,creator.x,creator.y)<512
                && !collision_line(x,y,creator.x,creator.y,Wall,false,false)
                && !collision_line(x,y,creator.x,creator.y,InvisiWall,false,false))
    }
    if (_teleport) {
        var _tx=x,_ty=y
        with (creator) {
            var _guardian=instance_is(id,NTTEFullPortalGuardian)
            scrNTTEFullPortalFx(x,y,_guardian ? spr_disappear:sprPortalDisappear,_guardian ? depth-1:-3,
                _guardian ? image_xscale*right:1,_guardian ? image_yscale:1,_guardian ? image_angle:0)
            x=_tx; y=_ty
            if (!scrNTTEFullWorldBudge(id,Wall,40)) scrNTTEFullWorldWallClear(id)
            xprevious=x; yprevious=y; image_index=0
            if (_guardian) sprite_index=spr_appear
            else scrNTTEFullPortalFx(x,y,scrNTTERefSprite("PortalBulletHit"))
            snd_play(sndPortalAppear,3,instance_is(id,Player) ? 0.5:1.5)
            var _owner=id
            with (CrystalShield) if (creator==_owner) {
                scrNTTEFullPortalFx(x,y,spr_disappear,depth,image_xscale,image_yscale,image_angle)
                x=other.x; y=other.y
            }
            if (instance_is(id,Player)) {
                var _blast=scr_projectile_create(x,y,NTTEBatScreech,0,0)
                _blast.image_alpha=0; _blast.damage=4; _blast.ntte_bat_force=1.5
                sleep(80); scr_screenshake(40); motion_add(direction+180,4*timescale)
                var _start=random(360)
                for(var _a=_start;_a<_start+360;_a+=72) {
                    var _fx=instance_create(x,y,PortalL)
                    with (_fx) { mask_index=object_get_mask(Ally); move_contact_solid(_a+orandom(30),random_range(32,40)) }
                }
            }
        }
    }
    else scrNTTEFullPortalFx(x,y,sprPortalDisappear,-3,0.7,0.7)
}

function scrNTTEFullPortalGuardianCreate() {
    spr_idle=scrNTTERefSprite("PortalGuardianIdle"); spr_walk=spr_idle
    spr_hurt=scrNTTERefSprite("PortalGuardianHurt"); spr_dead=scrNTTERefSprite("PortalGuardianDead")
    spr_appear=scrNTTERefSprite("PortalGuardianAppear"); spr_disappear=scrNTTERefSprite("PortalGuardianDisappear")
    mask_index=mskBandit; max_hp=55; raddrop=16; meleedamage=2; size=2
    hitid=[spr_idle,"PORTAL GUARDIAN"]; depth=-2; sprite_index=spr_idle
    walk=0; walkspeed=0.8; maxspeed=4; portal=false; implode=false
    ntte_guardian_left=40+irandom(20); ntte_guardian_shots=0
}

function scrNTTEFullPortalGuardianAfterCreate() {
    spr_shadow=shd24; gunangle=random(360)
    snd_hurt=sndExploGuardianHurt; snd_dead=sndDogGuardianDead; snd_mele=sndGuardianFire
    alarm[1]=-1; alarm[2]=-1
}

function scrNTTEFullPortalGuardianDecision() {
    ntte_guardian_left=20+random(30)
    scrTarget()
    if (!instance_exists(target)) {
        direction=random(360); walk=30; gunangle=direction
    }
    else {
        gunangle=point_direction(x,y,target.x,target.y)
        if (target.x!=x) right=sign(target.x-x)
        if (!collision_line(x,y,target.x,target.y,Wall,false,false)) {
            var _has=false,_owner=id
            with (projectile) if (creator==_owner) { _has=true; break }
            if (random(3)<2 && !_has) {
                var _p=scr_projectile_create(x,y,NTTEFullPortalBullet,gunangle,10)
                _p.portal=portal; ++ntte_guardian_shots
                snd_play(sndPortalOld,2+random(2),1.5)
            }
            else {
                direction=gunangle+random_range(60,100)*choose(-1,1); walk=random_range(20,40)
                if (point_distance(x,y,target.x,target.y)<128) direction=gunangle+180+orandom(30)
            }
        }
        else { direction=gunangle+orandom(40); walk=random_range(10,20) }
    }
    if (walk>0) speed=max(speed,friction/timescale)
}

function scrNTTEFullPortalGuardianStep() {
    if (lockstep_stop) return;
    if (hp<=0) { instance_destroy(); return }
    ntte_guardian_left-=timescale
    if (ntte_guardian_left<=0) scrNTTEFullPortalGuardianDecision()
    if (walk>0) { walk-=timescale; speed+=walkspeed*timescale*timescale }
    speed=min(speed,maxspeed*timescale)
    var _has=false,_owner=id
    with (projectile) if (creator==_owner && place_meeting(x,y,_owner)) { _has=true; break }
    if (!_has) speed=max(timescale,speed)
    if (sprite_index==spr_appear) {
        speed=0
        if (image_index+image_speed>=image_number) {
            image_index=0; sprite_index=spr_idle
            repeat(8) { var _f=instance_create(x,y,Dust); with (_f) motion_set(random(360),3*timescale) }
            repeat(3) { var _f=instance_create(x+orandom(16),y+orandom(16),PortalL); _f.depth=depth-1 }
            snd_play(sndGuardianFire,1.5+orandom(0.2),2)
        }
    }
    else if (sprite_index!=spr_disappear || image_index+image_speed>=image_number) {
        if (sprite_index!=spr_hurt || image_index+image_speed>=image_number) sprite_index=speed>0 ? spr_walk:spr_idle
    }
    if (random(30)<timescale) { var _f=instance_create(x+hspeed,y+vspeed,PortalL); _f.depth=depth+choose(0,-1) }
}

function scrNTTEFullPortalGuardianDeath() {
    if (hp>0) return;
    var _clear=instance_create(x,y,PortalClear)
    _clear.image_xscale=2/3; _clear.image_yscale=2/3
    if (!implode) { scrNTTEFullWorldPickupDrop(40,10,0); return }
    snd_play(sndHorrorPortal,1.5+orandom(0.1),3); scr_screenshake(30); sleep(30)
    var _death=instance_create(x,y,NTTEFullPortalGuardianDeath)
    _death.spr_shadow=spr_shadow; _death.spr_shadow_x=spr_shadow_x; _death.spr_shadow_y=spr_shadow_y
    _death.image_xscale=image_xscale*right; _death.image_yscale=image_yscale; _death.image_angle=image_angle
    _death.image_blend=image_blend; _death.image_alpha=image_alpha; _death.depth=depth
    _death.mask_index=mask_index; _death.raddrop=raddrop; _death.direction=direction
    _death.speed=min(speed,maxspeed*timescale)
    with (_death) move_contact_solid(direction,speed)
    spr_dead=choose(sprPortalL1,sprPortalL2,sprPortalL3,sprPortalL4,sprPortalL5)
    snd_dead=-1; raddrop=0
}

function scrNTTEFullPortalDeathCreate() {
    sprite_index=scrNTTERefSprite("PortalGuardianImplode")
    spr_shadow=shd24; spr_shadow_x=0; spr_shadow_y=0
    hitid=[sprite_index,"IMPLOSION"]; image_speed=0.4*timescale; depth=-2
    mask_index=mskBandit; friction=0.2*timescale*timescale
    wave=random(90); team=-1; raddrop=16
}

function scrNTTEFullPortalDeathStep() {
    if (lockstep_stop) return;
    wave+=timescale
    x+=(orandom(1)+random(sin(wave/10)))*timescale
    y+=(orandom(1)+random(cos(wave/10)))*timescale
    scr_screenshake(3)
    if (random(3)<2*timescale) instance_create(x+orandom(12),y+orandom(12),Smoke)
    if (random(5)<2*timescale) { var _f=instance_create(x+orandom(24),y+orandom(24),PortalL); _f.depth=depth-1 }
    if (image_index+image_speed>=image_number) {
        var _clear=instance_create(x,y,PortalClear)
        _clear.visible=true; _clear.sprite_index=mskPlasmaImpact; _clear.image_speed=0.5*timescale
        _clear.image_xscale=1.5; _clear.image_yscale=1.5; _clear.image_angle=45; _clear.depth=-1
        var _blast=scr_projectile_create(x,y,NTTEBatScreech,0,0)
        _blast.image_alpha=0; _blast.ntte_bat_force=1.5
        snd_play(sndGammaGutsKill,1.3); snd_play(sndPlasmaHugeUpg,1.2)
        scr_screenshake(100); sleep(100)
        for(var _d=direction;_d<direction+360;_d+=120) {
            for(var _i=1;_i<16;++_i) {
                var _p=scr_projectile_create(x,y,HorrorBullet,_d+lerp(-45,45,_i/16)*sign(image_xscale)+orandom(10),lerp(2,5,_i/16)+random(1))
                _p.sprite_index=sprHorrorBBullet; _p.bskin=true
                with (_p) {
                    move_contact_solid(direction,24*_i/16)
                    var _fx=instance_create(x,y,Dust)
                    with (_fx) motion_set(direction+orandom(10),(4+random(8))*timescale)
                }
            }
        }
        scrNTTEFullWorldPickupDrop(40,0); scrRadDrop(x,y,raddrop)
        var _reward=false
        with (Player) {
            var _normal_a=wep==wep_ntte_teleport_gun || wep==wep_ntte_super_teleport_gun || wep==wep_ntte_golden_teleport_gun
            var _normal_b=bwep==wep_ntte_teleport_gun || bwep==wep_ntte_super_teleport_gun || bwep==wep_ntte_golden_teleport_gun
            if ((_normal_a ^^ scr_weapon_is_golden(wep)) || (_normal_b ^^ scr_weapon_is_golden(bwep))) { _reward=true; break }
        }
        if (_reward) scrWeaponPickupCreate(x,y,wep_ntte_golden_teleport_gun,true)
        instance_destroy(); return;
    }
    if (place_meeting(x+hspeed,y+vspeed,Wall)) move_bounce_solid(true)
}

function scrNTTEFullPortalPointSeen(_x,_y,_margin=-8) {
    return _x>=view_xview-_margin && _x<=view_xview+view_width+_margin
        && _y>=view_yview-_margin && _y<=view_yview+view_height+_margin
}

function scrNTTEFullPortalPoof() {
    with (Portal) {
        if (object_index!=Portal || type<1 || type>3 || endgame!=100 || image_alpha!=1 || place_meeting(x,y,Player)) continue
        snd_stop(sndPortalLoop)
        if (visible && type==1 && endgame>=100 && !position_meeting(x,y,PortalShock)
            && scrNTTEFullPortalPointSeen(x,y,-8) && random(2)<1) {
            var _g=instance_create(x,y,NTTEFullPortalGuardian)
            _g.x=_g.xstart; _g.y=_g.ystart; _g.sprite_index=_g.spr_appear
            _g.right=image_xscale; _g.portal=true
            snd_play(choose(sndPortalFlyby1,sndPortalFlyby2,sndPortalFlyby3,sndPortalFlyby4),2+orandom(0.1),3)
        }
        else {
            // Epsilon uses type2=IDPD and type3=Proto (NTT reversed those).
            var _spr=type==1 ? sprPortalDisappear:(type==2 ? sprPopoPortalDisappear:sprProtoPortalDisappear)
            var _fx=scrNTTEFullPortalFx(x,y,_spr,depth,image_xscale,image_yscale,image_angle)
            _fx.image_blend=image_blend; _fx.image_alpha=image_alpha
        }
        if (ntte_full_portal_timer>30) {
            with (Player) if (angle!=0 && !roll && point_distance(x,y,other.x,other.y)<48
                && !collision_line(x,y,other.x,other.y,Wall,false,false)) {
                if (scr_skill_get(mut_throne_butt)>0) angle=0
                else roll=true
            }
        }
        instance_destroy()
    }
    with (Corpse) if (alarm[0]>0) alarm[0]=-1
}
