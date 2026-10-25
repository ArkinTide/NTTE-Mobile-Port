// NTTE 2.062 tedesert.mod.gml:2472..2802.
function scrNTTEFullVenomFlakCreate() {
    sprite_index=scrNTTERefSprite("VenomFlak"); image_speed=0.4*timescale
    mask_index=-1; friction=0.4*timescale*timescale
    damage=6; knockback_speed=6*timescale; typ=2; creator=noone
    charging=true; charge_time=max(1,15/(1+0.5*GameCont.loops))
    explo_time=40; ntte_venom_left=charge_time; ntte_venom_pellets=0
}

function scrNTTEFullVenomFlakRelease() {
    charging=false; ntte_venom_left=explo_time; typ=1
    if (!instance_exists(creator)) return;
    with (creator) {
        motion_add(gunangle+180,maxspeed*timescale)
        wkick=min(wkick+9,16)
        snd_play(sndFlakCannon,0.8,0.4)
        snd_play(sndCrystalRicochet,1.4+random(0.4),0.8)
        snd_play(sndLightningRifleUpg,0.8,0.4)
        repeat(3+irandom(2)) {
            var _fx=instance_create(x+orandom(6),y+orandom(6),Smoke)
            with (_fx) motion_set(other.gunangle+orandom(2),(4+random(4))*timescale)
        }
    }
}

function scrNTTEFullVenomFlakStep() {
    if (lockstep_stop) return;
    image_speed=0.4*timescale
    ntte_venom_left-=timescale
    if (ntte_venom_left<=0) {
        if (charging) { scrNTTEFullVenomFlakRelease(); return }
        else { instance_destroy(); return }
    }
    if (charging) {
        var _angry=1+0.5*GameCont.loops
        if (instance_exists(creator) && variable_instance_exists(creator,"ntte_bat_boss") && creator.ntte_bat_boss
            && instance_exists(NTTEFullCatBoss)) _angry--
        // Native friction already includes timescale squared. SilverScorpion
        // intentionally overrides it to.2; preserve that original customization.
        speed+=friction+0.3*_angry*timescale*timescale
        if (instance_exists(creator)) {
            var _dis=min(20,(speed/timescale)*1.5)
            xstart=creator.x+lengthdir_x(_dis,direction)
            ystart=creator.y+lengthdir_y(_dis,direction)
            if (variable_instance_exists(creator,"wkick") && creator.wkick<8) creator.wkick+=random_range(1,2)*timescale
        }
        x=xstart-hspeed; y=ystart-vspeed; xprevious=x; yprevious=y
        if (random(4)<timescale) {
            var _fx=instance_create(x+hspeed*0.6+orandom(4),y+vspeed*0.6+orandom(4),AcidStreak)
            _fx.sprite_index=scrNTTERefSprite("AcidPuff")
            _fx.image_angle=direction+orandom(60); _fx.depth=-2
            if (instance_exists(creator)) { _fx.x+=creator.hspeed; _fx.y+=creator.vspeed }
        }
    }
    else if (random(3)<timescale) {
        var _fx=instance_create(x+orandom(2),y+orandom(2),Smoke)
        /* NTTE NATIVE EFFECT LIFETIME venom-trail-smoke */ if(instance_exists(_fx)) {_fx.depth=depth+1 }
    }
    if (random(3)<timescale) {
        var _drip=instance_create(x+orandom(6),y+16+orandom(6),RecycleGland)
        _drip.sprite_index=sprDrip; _drip.depth=0
    }
}

function scrNTTEFullVenomFlakHit(_who) {
    if (lockstep_stop || !scr_can_hit(_who)) return false
    if (!scr_projectile_hit(_who,damage,knockback_speed)) return false
    with (_who) nexthurt=max(nexthurt,current_frame+40)
    if (!charging) instance_destroy()
    return true
}

function scrNTTEFullVenomFlakWall(_wall) {
    if (lockstep_stop) return;
    if (charging) {
        with (_wall) { instance_create(x,y,FloorExplo); instance_destroy() }
    }
    else if (speed>timescale) {
        move_bounce_solid(true); speed=min(speed,8*timescale)
        snd_play(sndShotgunHitWall,1.2,1.5); snd_play(sndFrogEggHurt,0.7,0.3)
        var _fx=instance_create(x,y,AcidStreak)
        _fx.image_yscale*=2
        with (_fx) motion_set(other.direction,3*timescale)
    }
}

function scrNTTEFullVenomFlakDraw() {
    var _scale=charging ? 0.25+(1-ntte_venom_left/charge_time)+random(0.2):1
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*_scale,image_yscale*_scale,image_angle,image_blend,image_alpha)
}

function scrNTTEFullVenomFlakDestroy() {
    instance_create(x,y,PortalClear)
    if (!instance_is(creator,Player)) scrNTTEFullWorldPickupDrop(50,0)
    for(var _a=0;_a<360;_a+=18) {
        var _fx=instance_create(x,y,Smoke)
        with (_fx) motion_set(_a,(4+random(4))*timescale)
    }
    scr_screenshake(20); sleep(10)
    snd_play(sndHeavyMachinegun,1,0.8); snd_play(sndSnowTankShoot,1.4,0.7)
    snd_play(sndFrogEggHurt,0.4+random(0.2),3.5)
    for(var _a=0;_a<360;_a+=30) {
        if ((_a mod 90)==0) {
            for(var _i=0;_i<=4;++_i) {
                var _p=scr_projectile_create(x,y,NTTEVenomPellet,direction+_a+orandom(2+_i),2*_i)
                with (_p) {
                    move_contact_solid(direction,4+4*_i)
                    var _fx=instance_create(x,y,AcidStreak)
                    with (_fx) motion_set(other.direction+orandom(4),other.speed*0.8)
                }
                ++ntte_venom_pellets
            }
        }
        else {
            var _p=scr_projectile_create(x,y,NTTEVenomPellet,direction+_a+orandom(2),5.8+random(0.4))
            with (_p) move_contact_solid(direction,6)
            ++ntte_venom_pellets
        }
    }
}

function scrNTTEFullVenomBlastCreate() {
    sprite_index=scrNTTERefSprite("VenomFlak"); image_speed=0.4*timescale; depth=-3
    mask_index=object_get_mask(SuperFlakBullet); image_xscale=0.2; image_yscale=0.2
    // NTT projectile defaults to typ=-1 (neither deflectable nor destructible),
    // inherited by CustomProjectile. Modern projectile omits this field.
    typ=-1
    damage=2; knockback_speed=2*timescale; charge=true; charge_goal=1; charge_speed=1/30
}

function scrNTTEFullVenomBlastStep() {
    if (lockstep_stop) return;
    if (charge) {
        if (image_xscale<charge_goal && image_yscale<charge_goal && instance_exists(creator) && creator.visible) {
            image_xscale+=charge_speed*timescale; image_yscale+=charge_speed*timescale
            snd_play(sndScorpionFire,0.5+1.5*image_xscale/charge_goal,4)
            if (random(4)<timescale) {
                var _l=random(sprite_width),_d=random(360),_fx=instance_create(x+lengthdir_x(_l,_d),y+lengthdir_y(_l,_d),AcidStreak)
                with (_fx) {
                    image_xscale=0.8; image_yscale=0.8; motion_set(_d+180,2*timescale)
                    if (random(2)<1) { sprite_index=scrNTTERefSprite("AcidPuff"); depth=other.depth-1; image_angle+=180 }
                    else depth=other.depth+1
                    hspeed+=other.creator.hspeed; vspeed+=other.creator.vspeed
                }
            }
        }
        else charge=false
    }
    else {
        image_xscale-=charge_goal/7*timescale; image_yscale-=charge_goal/7*timescale
        if (image_xscale<=0.2) instance_destroy()
    }
}

function scrNTTEFullVenomBlastEndStep() {
    if (lockstep_stop || !instance_exists(creator)) return;
    x=creator.x+lengthdir_x(10,direction); y=creator.y+lengthdir_y(6,direction)
    xprevious=x; yprevious=y
}

function scrNTTEFullVenomBlastHit(_who) {
    if (lockstep_stop || !scr_can_hit(_who)) return;
    if (scr_projectile_hit(_who,damage,knockback_speed)) sleep(20)
}

function scrNTTEFullVenomBlastDestroy() {
    sleep(10); scr_screenshake(10+2*GameCont.level)
    for(var _i=-1;_i<=1;++_i) {
        repeat(irandom_range(4,8)+2*(_i==0)+2*GameCont.level) {
            if (_i==0) {
                var _p=scr_projectile_create(x,y,EnemyBullet2,direction+orandom(12),8+random(6))
                _p.knockback_speed=12*timescale
            }
            else scr_projectile_create(x,y,NTTEVenomPellet,direction+45*_i+orandom(16)+_i*random(6*GameCont.level),4+random(10))
        }
        var _fx=instance_create(x,y,AcidStreak)
        _fx.image_xscale=1.6; _fx.image_yscale=1
        with (_fx) motion_set(other.direction+45*_i,4*timescale)
    }
    snd_play(sndFlyFire,1+random(0.4),2.5)
    snd_play(sndGoldScorpionFire,1.6+random(0.4),2.5)
}
