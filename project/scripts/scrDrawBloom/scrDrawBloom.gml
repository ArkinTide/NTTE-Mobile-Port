// Some native effects deliberately have no sprite while waiting to appear.
// NTTE-tagged projectiles use their authored bloom in the separate pass below.
function scrDrawBloomSprite(_sprite,_frame,_x,_y,_xs,_ys,_angle,_color,_alpha) {
    if(!sprite_exists(_sprite)) return;
    if(variable_instance_exists(id,"ntte_bloom") && ntte_bloom>0) return;
    draw_sprite_ext(_sprite,_frame,_x,_y,_xs,_ys,_angle,_color,_alpha)
}
function scrNTTEFullProjectileBloomDraw() {
    scrUGBloom();
    // tegeneral6033: CustomProjectile glow, including bonus shell damage.
    with(projectile) if(variable_instance_exists(id,"ntte_bloom") && ntte_bloom>0
        && sprite_exists(sprite_index)) {
        var _alpha=image_alpha*ntte_bloom
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,_alpha)
        if(variable_instance_exists(id,"bonus") && bonus>0)
            draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,_alpha*3*bonus)
    }
    // tedesert3050: these composite effects have dedicated source glow.
    with(NTTEFullVenomBlast) if(sprite_exists(sprite_index))
        draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*2,image_yscale*2,image_angle,image_blend,
            image_alpha*(charge?image_xscale/charge_goal:1)*0.2)
    with(NTTEFullVenomFlak) if(sprite_exists(sprite_index)) {
        var _xs=image_xscale,_ys=image_yscale,_alpha=image_alpha
        try {image_xscale*=2;image_yscale*=2;image_alpha*=0.2;event_perform(ev_draw,0)}
        finally {image_xscale=_xs;image_yscale=_ys;image_alpha=_alpha}
    }
}
function scrDrawBloom() {
    gpu_set_blendmode(bm_add)

    with NothingBeam {
        if !charge {
            if !disappear {
                draw_sprite_ext(sprNothingBeam, anim, x, (creator.y + 48), 2, 2, image_angle, c_white, 0.1)
                draw_sprite_ext(sprNothingBeamStretch, -1, x, y, 2, image_yscale, 0, c_white, 0.1)
            } else {
                draw_sprite_ext(sprNothingBeamStop, anim, x, (creator.y + 48), 2, 2, image_angle, c_white, 0.1)
            }
        }
    }

    with (Rocket) {
        if (active) {
		    draw_sprite_ext(sprRocketFlame, current_frame * 0.4,
				x, y, image_xscale * 2, image_yscale * 2, image_angle, image_blend, 0.1)
        }
    }
	
	with (Nuke) {
		if (active) {
		    draw_sprite_ext(sprNukeFlame, current_frame * 0.4,
				x, y, image_xscale * 2, image_yscale * 2, image_angle, image_blend, 0.1)
		}
	}

    with(Bullet1)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamParticle)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamChargeParticle)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(NothingBeamHit)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(UltraShell)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(FlameBall)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(UltraBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LHBouncer)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HeavyBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HeavySlug)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ToxicGas)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_yscale * 2), image_angle, c_white, 0.1)
    with(MomProjectile)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Deflect)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Bullet2) {
        if (bonus == 1) scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.3)
        scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    }

    with(GroundFlame)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(FlameShell)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HorrorBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ExploguardianBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LightningBall)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LaserCannon)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_yscale * 2), image_angle, c_white, 0.1)
    with(Lightning)
    scrDrawBloomSprite(sprite_index, -1, x, y, image_xscale, (image_yscale * 2), image_angle, c_white, 0.1)
    with(FlakBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyFlak)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(SuperFlakBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(PlasmaBig)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaHuge)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaBall)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PopoPlasma)
    scrDrawBloomSprite(sprite_index, -1, x, y, (image_xscale * 2), (image_xscale * 2), image_angle, c_white, 0.1)
    with(PlasmaImpact)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet3)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BouncerBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Slug)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(HyperSlug)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Disc)
    scrDrawBloomSprite(sprite_index, -1, xprevious, yprevious, 1, 1, image_angle, c_white, 0.1)
    with(Laser) {
        scrDrawBloomSprite(sprite_index, -1, x, y, image_xscale, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprLaserStart, img, xstart, ystart, 3, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprLaserEnd, img, x, y, 3, 3, image_angle, c_white, 0.1)
    }

    with(EnemyLaser) {
        scrDrawBloomSprite(sprite_index, -1, x, y, image_xscale, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprEnemyLaserStart, img, xstart, ystart, 3, 3, image_angle, c_white, 0.1)
        draw_sprite_ext(sprEnemyLaserEnd, img, x, y, 3, 3, image_angle, c_white, 0.1)
    }

    for (var i = 0; i < ds_list_size(global.lis_floors_visible); i++) {
        with(global.lis_floors_visible[| i]) {
            if (sprite_index == sprFloor2B) draw_sprite_ext(sprFloor2BBloom, image_index, x, y, 1, 1, image_angle, c_white, 0.1)
            if (sprite_index == sprFloor102B) draw_sprite_ext(sprFloor102BBloom, image_index, x, y, 1, 1, image_angle, c_white, 0.1)
        }
    }

    with(LaserCharge)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet1)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(AllyBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(RadChest)
    draw_sprite_ext(sprRadChestGlow, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet2)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet3)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EnemyBullet4)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(IDPDBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LastBall)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Throne2Ball)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Explosion)
    scrDrawBloomSprite(sprite_index, -1, x, y, image_xscale * 2, image_yscale * 2, image_angle, c_white, 0.1)
    with(GreenExplosion)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(SmallExplosion)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    //with(Bolt)
    //scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(MeatExplosion)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BulletHit)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(LaserBrain)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BigGuardianBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(EBulletHit)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ScorpionBulletHit)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(TrapFire)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Flame)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Fireball)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(Portal)
    scrDrawBloomSprite(sprite_index, -1, x, y, (2 * image_xscale), (2 * image_yscale), image_angle, c_white, 0.1)
    with(IDPDSpawn)
    scrDrawBloomSprite(sprite_index, -1, x, y, (2 * image_xscale), (2 * image_yscale), image_angle, c_white, 0.1)
    with(Rad)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(BigRad)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(GuardianBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(ExploguardianBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(PlasmaTrail)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)
    with(YVBullet)
    scrDrawBloomSprite(sprite_index, -1, x, y, 2, 2, image_angle, c_white, 0.1)

    scrNTTEFullProjectileBloomDraw();
    scrNTTEFullRedWorldBloomDraw();

    gpu_set_blendmode(bm_normal)
}
