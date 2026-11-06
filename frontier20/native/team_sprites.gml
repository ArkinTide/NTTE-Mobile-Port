// Exact active rows from NTTE teassets.sprite_team_variant_table.
// Quoted sprite references use the native NTTE reference resolver.
// NTT native names absent from the mobile runner retain its matching art:
// HyperSlug uses SlugBullet; weapon/cannon fire uses TrapFire; dragon fire
// uses SalamanderBullet. EnemySlash has its separate imported native art.
function scrFRTeamSpriteTable() {
    if(variable_global_exists("fr_team_sprite_table")) return global.fr_team_sprite_table;
    global.fr_team_sprite_table=[
        [[scrNTTERefSprite("EnemyBullet"),EnemyBullet4],[sprBullet1,Bullet1],[sprIDPDBullet,IDPDBullet]], // Bullet
        [[sprEnemyBulletHit],[sprBulletHit],[sprIDPDBulletHit]], // Bullet Hit
        [[scrNTTERefSprite("EnemyHeavyBullet"),"CustomBullet"],[sprHeavyBullet,HeavyBullet],[scrNTTERefSprite("IDPDHeavyBullet"),"CustomBullet"]], // Heavy Bullet
        [[scrNTTERefSprite("EnemyHeavyBulletHit")],[sprHeavyBulletHit],[scrNTTERefSprite("IDPDHeavyBulletHit")]], // Heavy Bullet Hit
        [[sprLHBouncer,LHBouncer],[sprBouncerBullet,BouncerBullet],[]], // Bouncer Bullet
        [[sprLHBouncer,LHBouncer],[sprBouncerShell,BouncerBullet],[]], // Bouncer Bullet 2
        [[sprEnemyBullet1,EnemyBullet1],[sprAllyBullet,AllyBullet],[]], // Bandit Bullet
        [[sprEnemyBulletHit],[sprAllyBulletHit],[sprIDPDBulletHit]], // Bandit Bullet Hit
        [[sprEnemyBullet4,EnemyBullet4],[scrNTTERefSprite("AllySniperBullet"),AllyBullet],[]], // Sniper Bullet
        [[sprEBullet3,EnemyBullet3],[sprBullet2,Bullet2],[]], // Shell
        [[sprEBullet3Disappear,EnemyBullet3],[sprBullet2Disappear,Bullet2],[]], // Shell Disappear
        [[scrNTTERefSprite("EnemySlug"),"CustomShell"],[sprSlugBullet,Slug],[sprPopoSlug,PopoSlug]], // Slug
        [[scrNTTERefSprite("EnemySlugDisappear"),"CustomShell"],[sprSlugDisappear,Slug],[sprPopoSlugDisappear,PopoSlug]], // Slug Disappear
        [[scrNTTERefSprite("EnemySlugHit")],[sprSlugHit],[sprIDPDBulletHit]], // Slug Hit
        [[scrNTTERefSprite("EnemySlug"),"CustomShell"],[sprSlugBullet,Slug],[sprPopoSlug,PopoSlug]], // Hyper Slug
        [[scrNTTERefSprite("EnemySlugDisappear"),"CustomShell"],[sprHyperSlugDisappear,Slug],[sprPopoSlugDisappear,PopoSlug]], // Hyper Slug Disappear
        [[scrNTTERefSprite("EnemyHeavySlug"),"CustomShell"],[sprHeavySlug,HeavySlug],[]], // Heavy Slug
        [[scrNTTERefSprite("EnemyHeavySlugDisappear"),"CustomShell"],[sprHeavySlugDisappear,HeavySlug],[]], // Heavy Slug Disappear
        [[scrNTTERefSprite("EnemyHeavySlugHit")],[sprHeavySlugHit],[]], // Heavy Slug Hit
        [[sprEFlak,"CustomFlak"],[sprFlakBullet,FlakBullet],[]], // Flak
        [[sprEFlakHit],[sprFlakHit],[]], // Flak Hit
        [[scrNTTERefSprite("EnemySuperFlak"),"CustomFlak"],[sprSuperFlakBullet,SuperFlakBullet],[]], // Super Flak
        [[scrNTTERefSprite("EnemySuperFlakHit")],[sprSuperFlakHit],[]], // Super Flak Hit
        [[sprEFlak,EnemyFlak],[sprFlakBullet,"CustomFlak"],[]], // Gator Flak
        [[sprTrapFire],[sprTrapFire],[sprFireLilHunter]], // Fire
        [[sprSalamanderBullet],[sprSalamanderBullet],[sprFireLilHunter]], // Fire 2
        [[sprTrapFire],[sprTrapFire],[sprFireLilHunter]], // Fire 3
        [[sprEnemyLaser,EnemyLaser],[sprLaser,Laser],[scrNTTERefSprite("PopoLaser"),"PopoLaser"]], // Laser
        [[sprEnemyLaserStart],[sprLaserStart],[scrNTTERefSprite("PopoLaserStart")]], // Laser Start
        [[sprEnemyLaserEnd],[sprLaserEnd],[scrNTTERefSprite("PopoLaserEnd")]], // Laser End
        [[sprLaserCharge],[scrNTTERefSprite("AllyLaserCharge")],[sprIDPDPortalCharge]], // Laser Particle
        [[sprEnemyLightning,EnemyLightning],[sprLightning,Lightning],[]], // Lightning
        [[scrNTTERefSprite("EnemyPlasmaBall"),"CustomPlasma"],[sprPlasmaBall,PlasmaBall],[sprPopoPlasma,PopoPlasma]], // Plasma
        [[scrNTTERefSprite("EnemyPlasmaBig"),"CustomPlasma"],[sprPlasmaBallBig,PlasmaBig],[]], // Plasma Big
        [[scrNTTERefSprite("EnemyPlasmaHuge"),"CustomPlasma"],[sprPlasmaBallHuge,PlasmaHuge],[]], // Plasma Huge
        [[scrNTTERefSprite("EnemyPlasmaImpact")],[sprPlasmaImpact],[sprPopoPlasmaImpact]], // Plasma Impact
        [[scrNTTERefSprite("EnemyPlasmaImpactSmall")],[scrNTTERefSprite("PlasmaImpactSmall")],[scrNTTERefSprite("PopoPlasmaImpactSmall")]], // Plasma Impact Small
        [[scrNTTERefSprite("EnemyPlasmaTrail")],[sprPlasmaTrail],[sprPopoPlasmaTrail]], // Plasma Particle
        [[scrNTTERefSprite("EnemyVlasmaBullet")],[scrNTTERefSprite("VlasmaBullet")],[scrNTTERefSprite("PopoVlasmaBullet")]], // Vector Plasma
        [[scrNTTERefSprite("EnemyVlasmaCannon")],[scrNTTERefSprite("VlasmaCannon")],[scrNTTERefSprite("PopoVlasmaCannon")]], // Vector Plasma Cannon
        [[sprNTTEFullNativeEnemySlash],[sprSlash],[sprNTTEFullNativeEnemySlash]] // Slash
    ];
    return global.fr_team_sprite_table;
}
