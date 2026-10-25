// Shared original team sprite conversion needed by PetWeaponBoss's real
// native guns. The source changes class while retaining all mutable fields.
function scrNTTEFullWeaponMimicProjectileSetup(_shot,_source) {
    if(!instance_exists(_shot)) return _shot
    // Immediate ActorFire shots finish their source-specific initialization
    // before SharedFire performs spriterize, just like the source's ID sweep.
    if(instance_exists(_source) && variable_instance_exists(_source,"ntte_actor_fire_creator")) return _shot
    var _owner=scrNTTEFullValue(_shot,"creator",noone)
    if(!instance_is(_owner,NTTEFullPetWeaponBoss))
        _owner=scrNTTEFullValue(_source,"ntte_actor_fire_creator",scrNTTEFullValue(_source,"creator",_source))
    if(!instance_is(_owner,NTTEFullPetWeaponBoss) || !instance_is(_shot,projectile)) return _shot
    if(scrNTTEFullValue(_shot,"ntte_mimic_sprite_setup",false)) return _shot
    _shot.ntte_mimic_sprite_setup=true
    if(_shot.hitid==HitId.None) _shot.hitid=_owner.hitid
    var _object=_shot.object_index,_sprite=_shot.sprite_index,_convert=-1
    switch(_object) {
        case HeavyBullet:_convert=NTTEFullCustomBullet;break
        case Slug:case HeavySlug:_convert=NTTEFullCustomShell;break
        case FlakBullet:case SuperFlakBullet:_convert=NTTEFullCustomFlak;break
        case PlasmaBall:case PlasmaBig:case PlasmaHuge:_convert=NTTEFullCustomPlasma;break
    }
    if(_convert>=0) {
        // Source team_instance_sprite adds only missing constructor fields
        // before changing class/replaying Create/restoring the original list.
        var _prototype=instance_create(_shot.x,_shot.y,_convert),_names=variable_instance_get_names(_prototype),_saved={},
            _builtin={x:_shot.x,y:_shot.y,xstart:_shot.xstart,ystart:_shot.ystart,xprevious:_shot.xprevious,yprevious:_shot.yprevious,
                speed:_shot.speed,direction:_shot.direction,friction:_shot.friction,gravity:_shot.gravity,gravity_direction:_shot.gravity_direction,
                image_index:_shot.image_index,image_speed:_shot.image_speed,image_xscale:_shot.image_xscale,image_yscale:_shot.image_yscale,
                image_angle:_shot.image_angle,image_blend:_shot.image_blend,image_alpha:_shot.image_alpha,
                mask_index:_shot.mask_index,depth:_shot.depth,visible:_shot.visible},_alarms=[]
        for(var _i=0;_i<12;++_i) array_push(_alarms,_shot.alarm[_i])
        for(var _i=0;_i<array_length(_names);++_i)
            variable_struct_set(_saved,_names[_i],scrNTTEFullValue(_shot,_names[_i],variable_instance_get(_prototype,_names[_i])))
        var _original=variable_instance_get_names(_shot)
        for(var _i=0;_i<array_length(_original);++_i)
            variable_struct_set(_saved,_original[_i],variable_instance_get(_shot,_original[_i]))
        with(_shot) instance_change(_convert,false)
        _names=variable_struct_get_names(_saved)
        for(var _i=0;_i<array_length(_names);++_i) variable_instance_set(_shot,_names[_i],variable_struct_get(_saved,_names[_i]))
        _names=variable_struct_get_names(_builtin)
        for(var _i=0;_i<array_length(_names);++_i) variable_instance_set(_shot,_names[_i],variable_struct_get(_builtin,_names[_i]))
        for(var _i=0;_i<12;++_i) _shot.alarm[_i]=_alarms[_i]
        instance_destroy(_prototype,false)
        // Every source projectile's original builtin graphics/motion/mask
        // and timers survive, even if the modern runner resets object defaults.
        switch(_object) {
            case HeavyBullet:
                _shot.sprite_index=scrNTTERefSprite("EnemyHeavyBullet");_shot.spr_dead=scrNTTERefSprite("EnemyHeavyBulletHit")
                if(abs(_shot.knockback_speed-8*timescale)<=0.000001) _shot.knockback_speed=12*timescale
                break
            case Slug:
                _shot.sprite_index=scrNTTERefSprite("EnemySlug");_shot.spr_fade=scrNTTERefSprite("EnemySlugDisappear")
                _shot.spr_dead=scrNTTERefSprite("EnemySlugHit");_shot.bonus_damage=2
                if(abs(_shot.knockback_speed-10*timescale)<=0.000001) _shot.knockback_speed=9*timescale
                break
            case HeavySlug:
                _shot.sprite_index=scrNTTERefSprite("EnemyHeavySlug");_shot.spr_fade=scrNTTERefSprite("EnemyHeavySlugDisappear")
                _shot.spr_dead=scrNTTERefSprite("EnemyHeavySlugHit");_shot.bonus_damage=10
                // Original NTT HeavySlug.Create writes bonus1 and force32.
                // Mobile Epsilon stores bonus10 as damage units instead.
                _shot.bonus=(_shot.bonus!=0)
                if(abs(_shot.knockback_speed-14*timescale)<=0.000001) _shot.knockback_speed=32*timescale
                break
            case FlakBullet:
                _shot.sprite_index=sprEFlak;_shot.spr_dead=sprEFlakHit;break
            case SuperFlakBullet:
                _shot.sprite_index=scrNTTERefSprite("EnemySuperFlak");_shot.spr_dead=scrNTTERefSprite("EnemySuperFlakHit")
                _shot.snd_dead=sndSuperFlakExplode;_shot.bonus_damage=5;_shot.flak=array_create(5,FlakBullet);_shot.super=true
                if(abs(_shot.knockback_speed-4*timescale)<=0.000001) _shot.knockback_speed=8*timescale
                break
            case PlasmaBall:case PlasmaBig:case PlasmaHuge:
                _shot.sprite_index=scrNTTERefSprite(_object==PlasmaBall?"EnemyPlasmaBall":(_object==PlasmaBig?"EnemyPlasmaBig":"EnemyPlasmaHuge"))
                _shot.spr_dead=scrNTTERefSprite("EnemyPlasmaImpact");_shot.spr_trail=scrNTTERefSprite("EnemyPlasmaTrail")
                if(_object!=PlasmaBall) {
                    _shot.snd_dead=sndPlasmaBigExplode;_shot.minspeed=6
                    _shot.flak=_object==PlasmaHuge?array_create(4,PlasmaBig):array_create(10,PlasmaBall)
                    if(abs(_shot.knockback_speed-4*timescale)<=0.000001) _shot.knockback_speed=8*timescale
                }
                break
        }
        return _shot
    }
    if(_object==Bullet1) {
        with(_shot) instance_change(EnemyBullet4,false)
        _shot.sprite_index=scrNTTERefSprite("EnemyBullet");_shot.spr_fade=sprEnemyBulletHit
        if(abs(_shot.knockback_speed-7*timescale)<=0.000001) _shot.knockback_speed=8*timescale
    }
    else scrNTTEFullPetTwinsTeam(_shot,team_enemy)
    if(_shot.object_index==EnemyBullet3) {
        _shot.spr_fade=sprEBullet3Disappear
        if(_object==Bullet2 && abs(_shot.knockback_speed-2*timescale)<=0.000001) _shot.knockback_speed=3*timescale
    }
    // Remaining source sprite rows keep their original object classes.
    // Weapons in future loadouts must still inherit these actual authored
    // fire/slash/charge variants when emitted by the same native helper.
    if(_sprite==sprSlash) _shot.sprite_index=sprNTTEFullNativeEnemySlash
    // Epsilon already uses source hostile TrapFire/SalamanderBullet artwork
    // for its native Flame/FlameShell classes; retain those genuine sprites.
    // Source spriterize updates class-specific cap/start/end after restoring
    // native values. It preserves native Laser damage, direction and lifetime.
    if(_shot.object_index==EnemyLaser && scr_skill_get(mut_laser_brain)!=0) {
        var _native=instance_create(_shot.x,_shot.y,Laser)
        if(_native.image_yscale==_shot.image_yscale) _shot.image_yscale=1.4
        instance_destroy(_native,false)
    }
    return _shot
}
function scrNTTEFullCustomBulletCreate() {
    sprite_index=sprBullet1;spr_dead=sprBulletHit;ntte_bloom=0.1;mask_index=mskBullet1
    damage=3;knockback_speed=8*timescale;typ=1;gland=0
}
function scrNTTEFullCustomBulletHit(_target) {
    if(team==_target.team || !scr_can_hit(_target)) return;
    if(gland!=0 && instance_is(creator,Player) && chance(3*scr_skill_get(mut_recycle_gland),5)) {
        var _max=typ_amax[Ammo.Bullets]
        if(creator.ammo[Ammo.Bullets]<_max) {
            creator.ammo[Ammo.Bullets]=min(creator.ammo[Ammo.Bullets]+gland,_max)
            instance_create(x,y,RecycleGland);snd_play_hit(sndRecGlandProc,0.1)
        }
    }
    scr_projectile_hit(_target,damage,knockback_speed);instance_destroy()
}
function scrNTTEFullCustomBulletWall() {
    instance_create(x,y,Dust);snd_play_hit(sndHitWall,0.2);instance_destroy()
}
function scrNTTEFullCustomBulletDestroy() {
    var _hit=instance_create(x,y,BulletHit);_hit.sprite_index=spr_dead
}
function scrNTTEFullCustomShellCreate() {
    sprite_index=sprBullet2;spr_fade=sprBullet2Disappear;spr_dead=sprBullet2Disappear;ntte_bloom=0.1
    mask_index=mskBullet2;friction=0.6*timescale*timescale;damage=2;knockback_speed=3*timescale
    typ=1;bonus=true;bonus_damage=1;minspeed=6;maxspeed=16;wallbounce=0
    ntte_shell_bonus_wait=2;alarm[2]=-1
}
function scrNTTEFullCustomShellStep() {
    if(lockstep_stop) return;
    if(ntte_shell_bonus_wait>0) {
        ntte_shell_bonus_wait-=timescale
        if(ntte_shell_bonus_wait<=0) bonus=false
        return;
    }
    image_angle=direction
    if(speed<minspeed*timescale && sprite_index!=spr_fade) {
        sprite_index=spr_fade;image_index=0;image_speed=0.4*timescale
    }
}
function scrNTTEFullCustomShellAnimate() {
    if(sprite_index!=spr_fade) { image_speed=0;image_index=image_number-1 }
    else instance_destroy()
}
function scrNTTEFullCustomShellHit(_target) {
    if(team==_target.team || !scr_can_hit(_target)) return;
    scr_projectile_hit(_target,damage+bonus_damage*bonus,knockback_speed)
    var _hit=instance_create(x,y,BulletHit);_hit.sprite_index=spr_dead;instance_destroy()
}
function scrNTTEFullCustomShellWall() {
    instance_create(x,y,Dust)
    if(speed>minspeed*timescale) snd_play_hit(sndShotgunHitWall,0.2)
    if(wallbounce>0 && !bonus) { bonus=true;ntte_shell_bonus_wait=2 }
    move_bounce_solid(true);image_angle=direction;speed=min(speed*0.8+wallbounce*timescale,maxspeed*timescale);wallbounce*=0.95
}
function scrNTTEFullCustomPlasmaCreate() {
    sprite_index=sprPlasmaBall;spr_dead=sprPlasmaImpact;spr_trail=sprPlasmaTrail;image_speed=0.5*timescale;ntte_bloom=0.1
    snd_dead=sndPlasmaHit;mask_index=mskPlasma;damage=4;knockback_speed=4*timescale;typ=2
    minspeed=7;minscale=0.5;flak=[]
}
function scrNTTEFullCustomPlasmaStep() {
    if(lockstep_stop) return;
    var _width=sprite_get_width(sprite_index),_minWidth=minscale*_width
    if(random(1)<1-power(1-clamp((_width-16)/16,0,1),timescale)) {
        var _off=_minWidth*(_width>=32?3/4:1/2),_trail=instance_create(x+orandom(_off),y+orandom(_off),PlasmaTrail)
        _trail.sprite_index=spr_trail
    }
    scrNTTEFullTrenchShake(x,y,floor(_width/24),true)
    if(abs(image_xscale)*_width<_minWidth || (friction>0 && speed==0)) instance_destroy()
}
function scrNTTEFullCustomPlasmaAnimate() { image_speed=0;image_index=image_number-1;speed=minspeed*timescale }
function scrNTTEFullCustomPlasmaHit(_target) {
    if(team==_target.team || !current_frame_active || !scr_can_hit(_target,false)) return;
    scr_projectile_hit(_target,round(damage*image_xscale),knockback_speed)
    image_xscale-=0.1;image_yscale-=0.1;x-=hspeed/timescale;y-=vspeed/timescale
    var _sleep=10/3*floor(abs(image_xscale)*sprite_get_width(sprite_index)/16),
        _shake=2+4*floor(sprite_get_width(sprite_index)/32)
    if(array_length(flak)) _sleep*=3
    if(!instance_is(creator,Player)) { _sleep*=3;_shake*=0.5 }
    sleep(_sleep);scrNTTEFullTrenchShake(x,y,_shake)
}
function scrNTTEFullCustomPlasmaWall() {
    if(!current_frame_active) return;
    image_xscale-=0.1;image_yscale-=0.1;x-=hspeed/timescale;y-=vspeed/timescale
    instance_create(x,y,Dust);snd_play_hit(sndHitWall,0.2)
}
function scrNTTEFullCustomPlasmaDestroy() {
    snd_play_hit_big(snd_dead,0.3)
    var _dir=random(360),_flak=flak,_count=array_length(_flak)
    if(_count>0) {
        for(var _i=0;_i<_count;++_i) {
            var _entry=_flak[_i]
            if(!is_struct(_entry)) _entry=is_array(_entry)?{flak:_entry}:{object_index:_entry}
            if(array_length(scrNTTEFullValue(_entry,"flak",[]))) {
                var _defaults={sprite_index:sprPlasmaBallBig,snd_dead:sndPlasmaBigExplode,damage:15,
                    knockback_speed:8*timescale,typ:1,minspeed:6},_keys=variable_struct_get_names(_defaults)
                for(var _j=0;_j<array_length(_keys);++_j) if(!variable_struct_exists(_entry,_keys[_j]))
                    variable_struct_set(_entry,_keys[_j],variable_struct_get(_defaults,_keys[_j]))
            }
            var _shot=scr_projectile_create(x+scrNTTEFullValue(_entry,"x",0),y+scrNTTEFullValue(_entry,"y",0),
                scrNTTEFullValue(_entry,"object_index",NTTEFullCustomPlasma),
                scrNTTEFullValue(_entry,"direction",_dir+360*(_i/_count)),scrNTTEFullValue(_entry,"speed",2)),
                _keys=variable_struct_get_names(_entry)
            for(var _j=0;_j<array_length(_keys);++_j) if(_keys[_j]!="object_index")
                variable_instance_set(_shot,_keys[_j],variable_struct_get(_entry,_keys[_j]))
            scrNTTEFullWeaponMimicProjectileSetup(_shot,id)
        }
        instance_create(x,y,PortalClear);sleep(10)
    }
    else {
        var _impact=scr_projectile_create(x,y,PlasmaImpact);_impact.sprite_index=spr_dead
        if(!instance_is(_impact.creator,Player)) _impact.mask_index=mskPopoPlasmaImpact
        sleep(3)
    }
}
