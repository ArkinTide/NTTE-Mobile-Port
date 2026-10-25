// NTT BBOX NORMALIZED: source inclusive right/bottom = modern runner edge-1.
// tetrench ElectroPlasma, used by PitSquid volleys and the plasma weapon family.
// Source836..1241: logical force/speed vs native physical motion is explicit.
function scrNTTEFullElectroPlasmaCreate() {
    sprite_index=scrNTTERefSprite("ElectroPlasma"); image_speed=0.4*timescale
    image_index=1-image_speed; depth=-3; ntte_bloom=0.1; mask_index=mskEnemyBullet1
    damage=3; knockback_speed=3*timescale; typ=2
    ntte_full_wave=current_frame+choose(0,150)+random(30)
    ntte_full_tether=0; ntte_full_tether_x=x; ntte_full_tether_y=y
    ntte_full_tether_inst=noone; ntte_full_tether_range=80
    ntte_full_setup=true; ntte_full_big=0
    ntte_full_big_zap=-1; ntte_full_big_friction=-1
}

function scrNTTEFullElectroPlasmaSetup() {
    ntte_full_setup=false
    if (ntte_full_tether==0 && ntte_full_tether_inst==noone) ntte_full_tether=-1
    if (instance_is(creator,Player)) {
        var _brain=scr_skill_get(mut_laser_brain)
        image_xscale+=0.15*_brain; image_yscale+=0.15*_brain
        ntte_full_tether_range+=40*_brain
    }
}

function scrNTTEFullElectroPlasmaUntether() {
    if (ntte_full_tether<=0) return;
    ntte_full_tether=0; snd_play(sndLightningReload,0.7+random(0.2),0.5)
    var _x1=x+hspeed,_y1=y+vspeed,_x2=ntte_full_tether_x,_y2=ntte_full_tether_y,
        _arc=point_distance(_x1,_y1,_x2,_y2)/4*sin(ntte_full_wave/300*2*pi),
        _parts=scrNTTEFullTrenchLightningDisappear(scrNTTEFullTrenchArc(_x1,_y1,_x2,_y2,_arc,id,team!=team_player && !instance_is(creator,Player)))
    for(var _i=0;_i<array_length(_parts);++_i) {
        var _p=_parts[_i]
        _p.sprite_index=scrNTTERefSprite("ElectroPlasmaTether"); _p.depth=-3
    }
}

function scrNTTEFullElectroPlasmaStep() {
    if (lockstep_stop) return;
    if (ntte_full_big_zap>=0) {
        ntte_full_big_zap-=timescale
        if (ntte_full_big_zap<=0) {
            ntte_full_big_zap=random_range(5,10)
            // No supplied speed: preserve the actual TeslaCoil constructor.
            var _coil=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTeslaCoil)
            _coil.direction=random(360)
            _coil.damage=damage; _coil.ntte_full_purple=true; _coil.creator=id
            _coil.ntte_full_offx=0; _coil.ntte_full_offy=0; _coil.ntte_full_range=64
        }
    }
    if (ntte_full_big_friction>0) {
        ntte_full_big_friction-=timescale
        if (ntte_full_big_friction<=0) {
            ntte_full_big_friction=-1
            friction=0.3*timescale*timescale
            scrNTTEFullCoastSoundAt(x,y,sndLightningHit,0.3+random(0.2),1.5)
        }
    }
    if (ntte_full_setup) scrNTTEFullElectroPlasmaSetup()
    if (ntte_full_tether>=0) {
        if (instance_exists(ntte_full_tether_inst)) {
            ntte_full_tether_x=ntte_full_tether_inst.x+ntte_full_tether_inst.hspeed
            ntte_full_tether_y=ntte_full_tether_inst.y+ntte_full_tether_inst.vspeed
        }
        var _x1=x+hspeed,_y1=y+vspeed,_x2=ntte_full_tether_x,_y2=ntte_full_tether_y,
            _distance=point_distance(_x1,_y1,_x2,_y2),_dir=point_direction(_x1,_y1,_x2,_y2)
        if ((ntte_full_tether_inst==noone || instance_exists(ntte_full_tether_inst)) && _distance<ntte_full_tether_range
            && !collision_line(_x1,_y1,_x2,_y2,Wall,false,false)) {
            if (ntte_full_tether<1) {
                ntte_full_tether+=0.2*timescale
                if (current_frame_active) {
                    var _d=random(_distance),_p=instance_create(_x1+lengthdir_x(_d,_dir),_y1+lengthdir_y(_d,_dir),choose(PortalL,LaserCharge))
                    if (instance_is(_p,LaserCharge)) {
                        _p.sprite_index=scrNTTERefSprite("ElectroPlasmaTether"); _p.image_angle=random(360)
                        _p.alarm[0]=(4+random(4))
                    }
                    scrNTTEFullNativeMotionAddFT(_p,random(360),1)
                }
                if (ntte_full_tether>=1) {
                    snd_play(sndLightningHit,2)
                    if (scr_skill_get(mut_laser_brain)>0) {
                        var _a=instance_create(_x1,_y1,LaserBrain),_b=instance_create(_x2,_y2,LaserBrain)
                        _a.image_angle=_dir+orandom(10); _a.creator=creator
                        _b.image_angle=_dir+orandom(10)+180; _b.creator=creator
                    }
                }
            }
            else {
                var _d1=direction,_d2=instance_exists(ntte_full_tether_inst) ? ntte_full_tether_inst.direction:direction,
                    _parts=scrNTTEFullTrenchArc(_x1,_y1,_x2,_y2,_distance/4*sin(ntte_full_wave/300*2*pi),id,false)
                for(var _i=0;_i<array_length(_parts);++_i) {
                    var _p=_parts[_i]
                    _p.damage=floor(_p.damage*(damage/3)); _p.sprite_index=scrNTTERefSprite("ElectroPlasmaTether"); _p.depth=-3
                    if (random(16)<timescale) {
                        var _fx=instance_create(_p.x,_p.y,PlasmaTrail)
                        _fx.sprite_index=scrNTTERefSprite("ElectroPlasmaTrail")
                        with (_fx) motion_set(_d1+angle_difference(_d2,_d1)*random(1),timescale)
                    }
                }
            }
        }
        else scrNTTEFullElectroPlasmaUntether()
    }
    if (random(8)<timescale) {
        var _fx=instance_create(random_range(bbox_left,(bbox_right-1)),random_range(bbox_top,(bbox_bottom-1)),PlasmaTrail)
        _fx.sprite_index=scrNTTERefSprite("ElectroPlasmaTrail")
    }
    ntte_full_wave+=timescale
    // Original speed/friction accessors expose logical units. Native Runner
    // stores physical speed*FT and friction*FT²; compare after conversion.
    if (image_xscale<=0.8 || image_yscale<=0.8 || speed/timescale<=friction/(timescale*timescale)) instance_destroy()
}

function scrNTTEFullElectroPlasmaBigCreate() {
    sprite_index=scrNTTERefSprite("ElectroPlasmaBig"); image_speed=0.475*timescale
    image_index=1-image_speed; mask_index=mskPlasma; damage=6; knockback_speed=2*timescale
    typ=1; ntte_full_big=1; ntte_full_big_zap=5; ntte_full_big_friction=20
}

function scrNTTEFullElectroPlasmaHit(_victim) {
    if (ntte_full_setup) scrNTTEFullElectroPlasmaSetup()
    // The source explicitly uses NP only; unlike Vlasma it has no phase gate.
    if (!scrNTTEFullNativeProjectileCanHitNP(_victim)) return false
    scrNTTEFullNativeProjectileHitPush(_victim,damage,knockback_speed/timescale)
    sleep(10); scrNTTEFullTrenchShake(x,y,2,true)
    x-=hspeed/timescale*0.8; y-=vspeed/timescale*0.8; image_xscale-=0.05; image_yscale-=0.05
    return true
}

function scrNTTEFullElectroPlasmaWall(_wall) {
    image_xscale-=0.03; image_yscale-=0.03
    // Source directly replaces every collided wall, including InvisiWall.
    if (ntte_full_big && instance_exists(_wall)) {
        with(_wall) {instance_create(x,y,FloorExplo);instance_destroy()}
    }
}

function scrNTTEFullElectroPlasmaDeath() {
    if (!instance_exists(GameCont)) return;
    if (ntte_full_big>0) {
        var _count=5*ntte_full_big,_parts=[]
        for(var _i=0;_i<_count;++_i) {
            var _angle=direction+360*_i/_count
            for(var _j=-1;_j<=1;++_j) {
                var _p=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasma,_angle+15*_j+orandom(2),(_j==0 ? 5:4)+random(0.4))
                array_push(_parts,_p)
            }
        }
        for(var _i=0;_i<array_length(_parts);++_i) _parts[_i].ntte_full_tether_inst=_parts[(_i+1) mod array_length(_parts)]
        var _num=3*ntte_full_big
        for(var _i=0;_i<_num;++_i) {
            var _angle=direction+360*_i/_num
            scrNTTEFullMergedBasicProjectileCreate(x+lengthdir_x(16,_angle),y+lengthdir_y(16,_angle),NTTEFullElectroPlasmaImpact,_angle)
        }
        sleep(60); scrNTTEFullTrenchShake(x,y,24)
        var _clear=instance_create(x,y,PortalClear); _clear.image_xscale=5/3; _clear.image_yscale=5/3
        var _brain=scr_skill_get(mut_laser_brain)>0
        var _sound=snd_play_hit_big(_brain ? sndPlasmaBigExplodeUpg:sndPlasmaBigExplode,0)
        if(_sound>=0) {audio_sound_pitch(_sound,0.8);audio_sound_gain(_sound,0.8*audio_sound_get_gain(_sound),0)}
        snd_play_hit(_brain ? sndLightningCannonUpg:sndLightningCannon,0.1)
        scrNTTEFullCoastSoundAt(x,y,sndLightningCannonEnd,1.4+orandom(0.1),1.5)
    }
    else scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullElectroPlasmaImpact,direction)
    scrNTTEFullElectroPlasmaUntether()
}

function scrNTTEFullElectroPlasmaImpactCreate() {
    // Original PlasmaImpact parent (damagesource), recovered b38ed0. The
    // modern parent omits original sleep/team/force/Step and uses new hits.
    team=team_player;creator=noone;hitid=HitId.None;damage=10
    knockback_speed=8*timescale;image_speed=0.4*timescale
    scrNTTEFullTrenchShake(x,y,2);sleep(4)
    repeat(3) instance_create(x,y,Smoke)
    sprite_index=scrNTTERefSprite("ElectroPlasmaImpact"); mask_index=mskBullet1; damage=2
    repeat(1+irandom(1)) {
        var _fx=instance_create(x+orandom(6),y+orandom(6),PortalL); _fx.depth=-6
    }
    snd_play_hit(sndPlasmaHit,0.4); snd_play_hit(sndGammaGutsProc,0.4)
}

function scrNTTEFullElectroPlasmaImpactStep() {
    if(!lockstep_stop) scrNTTEFullTrenchShake(x,y,2,true)
}
function scrNTTEFullElectroPlasmaImpactHit(_target) {
    // Original scrMeleeCanHit only checks faction and six-frame nexthurt.
    // No hp>0 or 30Hz phase gate. Original scrBulletHit uses projectile angle
    // for every target, FT force and speed_min16 on native target only.
    if(lockstep_stop || !instance_exists(_target) || _target.team==team
        || _target.nexthurt>current_frame) return false
    var _native=!scrNTTEFullRawHitCustom(_target)
    scrNTTEFullNativeProjectileDirectHit(_target,damage,knockback_speed/timescale,direction,0)
    if(_native && knockback_speed>0 && instance_exists(_target)) with(_target)
        speed=max(speed,16*timescale-friction*(1/timescale-1))
    sleep(3);scrNTTEFullTrenchShake(_target.x,_target.y,2)
    return true
}
