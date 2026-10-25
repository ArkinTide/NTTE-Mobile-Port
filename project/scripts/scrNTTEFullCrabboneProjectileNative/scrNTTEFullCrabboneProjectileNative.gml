// tedesert.mod.gml669..1174. Physical Bone owns its actual LWO. The explicit
// user override breaks ordinary bones only on wall/enemy impacts.
function scrNTTEFullCrabboneBoneCreate() {
    sprite_index=scrNTTERefSprite("Bone");image_speed=0;mask_index=mskFlakBullet
    friction=timescale*timescale;damage=34;force=1;typ=1;wep=wep_ntte_bone
    curse=0;rotspeed=choose(-1,1)/3;broken=false;state=undefined
    ntte_crabbone_cleaned=false;ntte_crabbone_hit_list=[]
}
function scrNTTEFullCrabboneProjectileCreate(_actor,_part,_dir,_speed=16,_curse=0,_broken=false) {
    if(!instance_exists(_actor)) return noone
    var _shot=noone
    with(_actor) _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullCrabboneBone,_dir,_speed)
    _shot.wep=scrNTTEFullWeaponModel(_part);_shot.curse=_curse;_shot.broken=_broken
    _shot.state=scrNTTEFullValue(_shot.wep,"ntte_native_state",undefined)
    _shot.sprite_index=scr_weapon_get_sprite(_part)
    return _shot
}
function scrNTTEFullCrabboneQuestBreak(_actor,_part,_dir) {
    // Quest final unlock also emits non-Crabbone stocks as broken Bone. It
    // deliberately supplies the exact unmerged physical part and its sprite.
    return scrNTTEFullCrabboneProjectileCreate(_actor,_part,_dir,16,scrNTTEFullValue(_actor,"curse",0),true)
}
function scrNTTEFullChickenBFx(_x,_y) {
    // Original ChickenB is .4-frame animation with an animation-end delete;
    // Epsilon's standalone RecycleGland is that same base object lifecycle.
    var _fx=instance_create(_x,_y,RecycleGland)
    _fx.sprite_index=sprChickenB;_fx.image_speed=0.4*timescale;_fx.depth=-2
    return _fx
}
function scrNTTEFullCrabboneBoneStep() {
    if(lockstep_stop) return;
    image_angle+=speed/timescale*rotspeed*timescale
    if(instance_exists(Portal) && place_meeting(x,y,Portal)) {
        if(speed>0) {
            snd_play(scrNTTEFullCrabbonePartIndex(wep,state)<0?sndMutant14Turn:sndPlasmaReload,
                0.6+random(0.2),0.8)
            repeat(3) instance_create(x,y,Smoke)
        }
        instance_destroy();return;
    }
    if(speed<=0 || (instance_exists(PortalShock) && place_meeting(x+hspeed/timescale,y+vspeed/timescale,PortalShock))) {
        mask_index=object_get_mask(WepPickup)
        if(place_meeting(x,y,Wall) && scrNTTEFullWorldBudge(id,Wall)) instance_create(x,y,Dust)
        instance_destroy()
    }
}
function scrNTTEFullCrabboneBoneWall() {
    if(lockstep_stop) return;
    move_bounce_solid(true);speed/=2;rotspeed*=-1
    snd_play_hit(sndHitWall,0.2);instance_create(x,y,Dust)
    if(scrNTTEFullCrabboneIs(wep) && scrNTTEFullCrabbonePartIndex(wep,state)<0) {
        broken=true;instance_destroy()
    }
}
function scrNTTEFullCrabboneBoneHit(_target) {
    if(lockstep_stop || !instance_exists(_target) || _target.team==team) return;
    var _artifact=scrNTTEFullCrabbonePartIndex(wep,state)>=0
    if(instance_is(_target,ScrapBoss) && !_artifact) {
        var _charm=scrNTTEFullParrotCharm(_target,true)
        _charm.time=300;snd_play(sndBigDogTaunt);broken=true;instance_destroy(id,false);return;
    }
    var _pierce=scrNTTEFullValue(creator,"race",-1)==Race.Chicken && scr_skill_get(mut_throne_butt)>0
    if(_pierce && _target.nexthurt>current_frame) return;
    var _size=scrNTTEFullValue(_target,"size",1)
    scr_projectile_hit(_target,damage,speed*force)
    if(!instance_exists(id)) return;
    if(_artifact) {
        var _part=scrNTTEFullWeaponModel(wep)
        while(true) {
            if(scrNTTEFullCrabboneArtifactImpact(_target,_part,_size)) return;
            if(scrNTTEFullWeaponHasMerge(_part)==false) break
            _part=scrNTTEFullWeaponMergedPart(_part)
        }
        if(!_pierce) instance_destroy()
    }
    else if(!_pierce) {
        snd_play(sndBloodGamble,1.2+random(0.2),3)
        var _distance=infinity
        with(NTTEFullCoastBossBecome) _distance=min(_distance,point_distance(x,y,other.x,other.y))
        if(_distance>32) {broken=true;instance_destroy()}
    }
}
function scrNTTEFullCrabboneArtifactImpact(_victim,_part,_size) {
    var _dir=image_angle,_px=x+lengthdir_x(8,_dir),_py=y+lengthdir_y(8,_dir),
        _index=scrNTTEFullCrabbonePartIndex(_part)
    switch(_index) {
        case 0:
            var _proto=wep_rusty_revolver
            if(instance_exists(ProtoChest)) {with(ProtoChest) _proto=wep}
            else {
                var _chest=instance_create(0,0,ProtoChest)
                _proto=_chest.wep;instance_destroy(_chest,false)
            }
            var _fx=instance_create(_px,_py,GunGun)
            _fx.sprite_index=scrNTTERefSprite("ProtoChestFire")
            snd_play(sndGunGun,1.5+orandom(0.1));scrNTTEFullDiscWeaponSound(sndStatueXP,1,0.3)
            // Anchor is this projectile; source creator/team remain unchanged
            // even for a delayed or merged ProtoChest weapon emission.
            scrNTTEFullActorFireMount(id,{x:_px,y:_py,direction:_dir,accuracy:1,
                wep:_proto,team:team,creator:creator},creator,false)
            break;
        case 1:
            var _tether=noone
            for(var _i=-2;_i<=2;++_i) {
                var _plasma=scrNTTEFullMergedBasicProjectileCreate(_px,_py,NTTEFullElectroPlasma,_dir+60*_i,1.5)
                _plasma.ntte_full_tether_inst=_tether;_tether=_plasma
                _plasma.friction=_plasma.speed/90*timescale
            }
            scrNTTEFullMergedBasicProjectileCreate(_px,_py,NTTEFullElectroPlasmaImpact,_dir)
            var _zone=scrNTTEFullMergedBasicProjectileCreate(_px,_py,NTTEBatScreech)
            _zone.image_speed*=2/3;_zone.image_blend=make_color_rgb(186,62,198)
            scrNTTEFullDiscWeaponSound(scr_skill_get(mut_laser_brain)>0?sndLightningShotgunUpg:sndLightningShotgun,1,
                scr_skill_get(mut_laser_brain)>0?0.6:0.3)
            snd_play(sndHammer,0.3,2)
            break;
        case 2:
            if(instance_exists(_victim)) {
                _dir+=180;_px=x+lengthdir_x(8,_dir);_py=y+lengthdir_y(8,_dir)
                var _laser=scrNTTEFullMergedBasicProjectileCreate(_px,_py,NTTEFullBoneArtifactLaserCannon,_dir),
                    _extra=_size*2
                _laser.target=id;_laser.delay+=3*_extra;_laser.ammo+=_extra
                scrNTTEFullDiscWeaponSound(sndLaserCannonCharge,1,0.3)
                if(_victim.hp>0 && !broken) {
                    var _pickup=scrWeaponPickupCreate(x,y,wep,false,NTTEFullWepPickupStick)
                    _pickup.ntte_state=state;_pickup.rotation=image_angle;_pickup.curse=curse;_pickup.creator=creator
                    _pickup.stick_target=_victim;_pickup.stick_damage=0;_pickup.ntte_stick_removed=false
                    _pickup.mask_index=mskShield;_pickup.speed=0;_pickup.slowreturn=false
                    var _toward=point_direction(_pickup.x,_pickup.y,_victim.x,_victim.y)
                    if(max(_victim.bbox_right-_victim.bbox_left,_victim.bbox_bottom-_victim.bbox_top)>28)
                        _pickup.rotation+=angle_difference(_toward,_pickup.rotation)/2
                    else {
                        _pickup.x=_victim.x-lengthdir_x(20,_toward);_pickup.y=_victim.y-lengthdir_y(20,_toward)
                        _pickup.rotation=_toward
                    }
                    _pickup.stick_x=_pickup.x-_victim.x;_pickup.stick_y=_pickup.y-_victim.y
                    if(scrNTTEFullValue(creator,"race",-1)==Race.Chicken && scr_ultra_get(Race.Chicken,UltraSkill.Determination))
                        _pickup.alarm[0]=30
                    _laser.target=_pickup;_laser.direction=_pickup.rotation+180;_laser.image_angle=_laser.direction
                    broken=true;instance_destroy(id,false);return true
                }
            }
            break;
        case 3:
            var _plasma=scrNTTEFullMergedBasicProjectileCreate(_px,_py,PlasmaBig,_dir,1.5)
            for(var _i=0;_i<4;++_i) {
                var _angle=_dir+45+90*_i,
                    _v=scrNTTEFullMergedBasicProjectileCreate(_px,_py,NTTEFullVlasmaBullet,_angle+180)
                _v.x+=lengthdir_x(64,_angle);_v.y+=lengthdir_y(64,_angle);_v.target=id
                scrNTTEFullVlasmaTeam(_v,scrNTTERefSprite("VlasmaBullet"))
            }
            // team_instance_sprite(1) retains friendly green source visuals.
            _plasma.sprite_index=sprPlasmaBallBig
            if(!broken) {
                var _floors=scrNTTEFullInstances(Floor,true)
                for(var _i=array_length(_floors)-1;_i>0;--_i) {
                    var _j=irandom(_i),_swap=_floors[_j];_floors[_j]=_floors[_i];_floors[_i]=_swap
                }
                for(var _i=0;_i<array_length(_floors);++_i) {
                    var _floor=_floors[_i],_free=false,_cx=(_floor.bbox_left+_floor.bbox_right-1)/2,
                        _cy=(_floor.bbox_top+_floor.bbox_bottom-1)/2
                    with(_floor) _free=place_free(x,y) && !place_meeting(x,y,hitme)
                        && !place_meeting(x,y,chestprop) && !place_meeting(x,y,other.id)
                    if(!_free || point_distance(_cx,_cy,x,y)>=192) continue
                    scrNTTEFullChickenBFx(x,y);x=_cx;y=_cy;image_index=1;scrNTTEFullChickenBFx(x,y)
                    snd_play(sndPlasma,0.6+orandom(0.1),1.5);snd_play(sndEliteShielderTeleport,1.6+orandom(0.1))
                    break
                }
            }
            scrNTTEFullDiscWeaponSound(scr_skill_get(mut_laser_brain)>0?sndPlasmaBigUpg:sndPlasmaBig,1,-0.5)
            break;
    }
    return false
}
function scrNTTEFullCrabboneBoneDestroy() {
    instance_create(x,y,Dust)
    var _ordinary=scrNTTEFullCrabbonePartIndex(wep,state)<0
    // A harmless landing returns the intact physical bone in Cleanup.
    if(!broken) return;
    if(_ordinary) {
        snd_play(sndHitRock,1.4+random(0.2),2.5)
        repeat(2) {
            var _shard=instance_create(x,y,NTTEBoneShard)
            scrNTTEFullNativeMotionAddFT(_shard,random(360),2)
        }
    }
    else {
        scrNTTEFullChickenBFx(x,y);snd_play(sndPlasmaReloadUpg)
        if(instance_is(creator,Player)) creator.gunshine=max(scrNTTEFullValue(creator,"gunshine",0),7)
    }
}
function scrNTTEFullCrabboneBoneCleanup() {
    if(ntte_crabbone_cleaned) return;
    ntte_crabbone_cleaned=true
    if(broken) return;
    var _pickup=scrWeaponPickupCreate(x,y,wep)
    _pickup.rotation=image_angle;_pickup.curse=curse;_pickup.creator=creator;_pickup.ntte_state=state
    if(scrNTTEFullValue(creator,"race",-1)==Race.Chicken && scr_ultra_get(Race.Chicken,UltraSkill.Determination))
        _pickup.alarm[0]=30
    var _self=id
    with(projectile) if(scrNTTEFullValue(id,"target",noone)==_self) target=_pickup
}
function scrNTTEFullBoneArtifactLaserCannonCreate() {
    sprite_index=sprPopoPlasma;image_speed=0;image_xscale=0.2;image_yscale=0.2;ntte_bloom=0.1
    // This anchored CustomProjectile emits lasers; it is not a destructible
    // bullet. Native PopoExplosion collisions require an explicit type.
    typ=0;damage=4;force=7;delay=15;time=2;ammo=5+2*scr_skill_get(mut_laser_brain);target=noone
    ntte_crabbone_hit_list=[]
}
function scrNTTEFullBoneArtifactLaserCannonStep() {
    if(lockstep_stop) return;
    if(ammo<=0) {instance_destroy();return;}
    if(image_xscale<0.5 || image_yscale<0.5) {
        if(image_xscale<0.5) image_xscale=min(image_xscale+0.02*timescale,0.5)
        if(image_yscale<0.5) image_yscale=min(image_yscale+0.02*timescale,0.5)
    }
    else {
        image_xscale*=0.8;image_yscale*=0.8
        snd_play(sndIDPDNadeLoad,lerp(2,1.2,delay/30)+orandom(0.1))
    }
    if(random(3)<timescale) {
        var _fx=instance_create(x+orandom(16),y+orandom(16),IDPDPortalCharge)
        with(_fx) {
            scrNTTEFullNativeMotionAddFT(id,point_direction(x,y,other.x,other.y),random_range(1,2))
            alarm[0]=1+point_distance(x,y,other.x,other.y)/(speed/timescale)
        }
    }
    if(target!=noone) {
        if(!instance_exists(target) && distance_to_object(Player)<24) target=instance_nearest(x,y,Player)
        if(instance_exists(target)) {
            var _len=8
            if(variable_instance_exists(target,"gunangle")) {
                direction=target.gunangle
                var _kick=scrNTTEFullValue(target,"wkick",0)
                if(variable_instance_exists(target,"wepangle")) direction+=target.wepangle*(1-_kick/20)
                direction+=180;_len+=_kick
            }
            x=target.x+target.hspeed/timescale+lengthdir_x(_len,direction)
            y=target.y+target.vspeed/timescale+lengthdir_y(_len,direction);xprevious=x;yprevious=y
        }
    }
    if(delay>0) {
        delay-=timescale
        if(delay<=0) {
            ammo-=1;delay=time;image_xscale*=0.5;image_yscale*=0.5
            var _laser=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullPopoLaser,direction+orandom(8))
            _laser.image_yscale+=0.6*scr_skill_get(mut_laser_brain);_laser.depth=depth
            with(_laser) event_perform(ev_alarm,0)
            scrNTTEFullDiscWeaponSound(scr_skill_get(mut_laser_brain)>0?sndLaserCannonUpg:sndLaserCannon,1,0.3)
            if(instance_is(target,Player)) with(target) scr_weapon_post(gunangle,3,2,-10)
            else scrNTTEFullTrenchShake(x,y,2,true)
            var _pushed=scrNTTEFullValue(target,"stick_target",noone)
            if(!instance_exists(_pushed)) _pushed=target
            if(instance_exists(_pushed)) {
                scrNTTEFullNativeMotionAddFT(_pushed,direction+180,1.5)
                var _clear=scrNTTEFullWorldWallClear(_pushed)
                _clear.x+=_pushed.hspeed;_clear.y+=_pushed.vspeed
            }
        }
    }
}
function scrNTTEFullBoneArtifactLaserCannonHit(_target) {
    if(lockstep_stop || !instance_exists(_target) || _target.team==team || _target.nexthurt>current_frame) return;
    scrNTTEFullNativeProjectileHitPush(_target,damage,force)
    scrNTTEFullTrenchShake(x,y,2,true);sleep(5)
}
function scrNTTEFullPopoLaserCreate() {
    sprite_index=scrNTTERefSprite("PopoLaser");image_yscale=1.4
    ntte_popo_laser_img=img;img=7
}
function scrNTTEFullPopoLaserStep() {
    ntte_popo_laser_img+=img-7;img=7
}
function scrNTTEFullPopoLaserDraw() {
    draw_sprite_ext(sprite_index,0,x,y,image_xscale,image_yscale,image_angle,c_white,1)
    draw_sprite_ext(scrNTTERefSprite("PopoLaserStart"),ntte_popo_laser_img,xstart,ystart,1,1,image_angle,image_blend,image_alpha)
    draw_sprite_ext(scrNTTERefSprite("PopoLaserEnd"),ntte_popo_laser_img,x,y,1,1,image_angle,image_blend,image_alpha)
}
