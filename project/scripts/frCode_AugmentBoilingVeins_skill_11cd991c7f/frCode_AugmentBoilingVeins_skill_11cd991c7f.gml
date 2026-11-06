// Original Mutations/AugmentBoilingVeins.skill.gml:1
function fr_Mutations_AugmentBoilingVeins_skill_gml___load() {

}

// Original Mutations/AugmentBoilingVeins.skill.gml:1
function fr_Mutations_AugmentBoilingVeins_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprSkillIcon = sprFR_sprAugmentBoilingVeins_dc590ea7c998;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprSkillHud = sprFR_sprAugmentBoilingVeinsIc_ee8681cf3ba7;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].levelStart = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced = false;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles = true;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingGreenAugments = false;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprNull = sprFR_sprAugmentSharpTeethNull_9ec2254a74bb;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenNull = sprFR_sprGreenAugmentSharpTeet_f96ed70f2e57;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderCreep = sprFR_sprPopoGunpowderCreep_781b2a4be788;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireSlash = sprFR_sprPopoFireSlash_3437c1a16432;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameTrail = sprFR_sprPopoFlameTrail_f2bc9e0ba04c;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameBullet = sprFR_sprPopoFlameBullet_0781cc3713fc;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameBulletHit = sprFR_sprPopoFlameBulletHit_78db3e2c824d;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireFly = sprFR_sprPopoFireFly_48298ea811e0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameRocket = sprFR_sprPopoFlameRocket_c6ce0be2baf5;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameCreepBubble = sprFR_sprPopoFlameCreepBubble_d5a5df49f9f0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderShell = sprFR_sprPopoGunpowderShell_1ffdfcff3c12;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderShellDisappear = sprFR_sprPopoGunpowderShellDis_c3ae8761caec;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBullet = sprFR_sprPopoFireBullet_07bb11add264;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBulletHit = sprFR_sprPopoFireBulletHit_d1f219c1ca46;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBullet = sprFR_sprPopoHeavyFireBullet_33681f3b40ca;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBulletHit = sprFR_sprPopoHeavyFireBulletHi_caf4edb627c5;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBulletBounce = sprFR_sprPopoFireBulletBounce_712dadc6b6e8;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBulletBounce = sprFR_sprPopoHeavyFireBulletBo_83863ca5b70c;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireGunhammerSlash = sprFR_sprPopoFireGunhammerSlas_63b03f8a1810;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireShot = sprFR_sprPopoFireShot_d5de3e9e0169;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireFlak = sprFR_sprPopoFireFlak_370f291749bb;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireMuzzle = sprFR_sprPopoFireMuzzle_1fcc9f7399ad;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGasFire = sprFR_sprPopoGasFire_3eec78be3f3e;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoMegaFireBullet = sprFR_sprPopoMegaFireBullet_1264d35de6ec;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoEmber = sprFR_sprPopoEmber_fd0ba6d754c0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoDirectionalExplosion = sprFR_sprPopoDirectionalExplos_dca97e6c4697;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSheet = sprFR_sprPopoLavaSheet_d704488f1a73;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaStreak = sprFR_sprPopoLavaStreak_f080ef8a8a4e;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSplash = sprFR_sprPopoLavaSplash_402c0d9185db;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoMushroomExplosion = sprFR_sprPopoMushroomExplosion_79898167dde2;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlamePuff = sprFR_sprPopoFlamePuff_b5700c87ff3b;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameSparkle = sprFR_sprPopoFlameSparkle_94e34d833e38;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameSparkleBig = sprFR_sprPopoFlameSparkleBig_812dda8870ca;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaBomb = sprFR_sprPopoLavaBomb_9e2904f2a768;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaBombBig = sprFR_sprPopoLavaBombBig_6b254436bc3f;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSlash = sprFR_sprPopoLavaSlash_7f2aea7a5eb7;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyIdle = sprFR_sprPopoFireflyIdle_68faf2f47071;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyWalk = sprFR_sprPopoFireflyWalk_0198d5d29cb9;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyHurt = sprFR_sprPopoFireflyHurt_09fafd8d99ad;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyDead = sprFR_sprPopoFireflyDead_758156d83c60;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyExplode = sprFR_sprPopoFireflyExplode_8c6afc6dffcc;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapIdle = sprFR_sprPopoFlytrapIdle_4d3069aa8b01;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapWalk = sprFR_sprPopoFlytrapWalk_71a103d330d8;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapHurt = sprFR_sprPopoFlytrapHurt_0e18e9593ed4;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapDead = sprFR_sprPopoFlytrapDead_d6e8a5b4e5d5;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapChrg = sprFR_sprPopoFlytrapChrg_6e36fd45c6cf;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapFire = sprFR_sprPopoFlytrapFire_fa1457bab004;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantIdle = sprFR_sprPopoPitcherPlantIdle_2d7680b8a5c6;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantWalk = sprFR_sprPopoPitcherPlantWalk_bf1b588da029;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantHurt = sprFR_sprPopoPitcherPlantHurt_18d0ba81a78a;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantDead = sprFR_sprPopoPitcherPlantDead_ef8f708adb97;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantCharge = sprFR_sprPopoPitcherPlantCharg_c16e4a55e7ae;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantFire = sprFR_sprPopoPitcherPlantFire_a94f43e1c25f;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHealFire = sprFR_sprPopoHealFire_6462bb77790f;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderCreep = sprFR_sprGreenPopoGunpowderCre_9eed76e3edf2;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireSlash = sprFR_sprGreenPopoFireSlash_f62dd5a2d436;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameTrail = sprFR_sprGreenPopoFlameTrail_a347d30f63a5;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameBullet = sprFR_sprGreenPopoFlameBullet_86cc9c2d8cbf;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameBulletHit = sprFR_sprGreenPopoFlameBulletH_837dc2fb98fd;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireFly = sprFR_sprGreenPopoFireFly_82abc8469a85;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameRocket = sprFR_sprGreenPopoFlameRocket_bc1b3b60cbf8;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameCreepBubble = sprFR_sprGreenPopoFlameCreepBu_2819d811e4eb;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderShell = sprFR_sprGreenPopoGunpowderShe_d44054783780;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderShellDisappear = sprFR_sprGreenPopoGunpowderShe_2a6e26ceeacb;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBullet = sprFR_sprGreenPopoFireBullet_b815b3851986;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBulletHit = sprFR_sprGreenPopoFireBulletHi_f52da4c567a3;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBullet = sprFR_sprGreenPopoHeavyFireBul_9d80f9c426fc;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBulletHit = sprFR_sprGreenPopoHeavyFireBul_9d521f75660d;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBulletBounce = sprFR_sprGreenPopoFireBulletBo_b8e7019229f1;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBulletBounce = sprFR_sprGreenPopoHeavyFireBul_5faa3463ebb0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireGunhammerSlash = sprFR_sprGreenPopoFireGunhamme_d6698c3c21fd;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireShot = sprFR_sprGreenPopoFireShot_a7ffcd8f8541;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireFlak = sprFR_sprGreenPopoFireFlak_00179948d8b0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireMuzzle = sprFR_sprGreenPopoFireMuzzle_8488605025c6;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGasFire = sprFR_sprGreenPopoGasFire_d9c8e1d96a6a;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoMegaFireBullet = sprFR_sprGreenPopoMegaFireBull_ef6546802094;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoEmber = sprFR_sprGreenPopoEmber_444e3db867f9;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoDirectionalExplosion = sprFR_sprGreenPopoDirectionalE_135fd2870f03;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSheet = sprFR_sprGreenPopoLavaSheet_5e4819a1445f;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaStreak = sprFR_sprGreenPopoLavaStreak_656a7a5954d1;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSplash = sprFR_sprGreenPopoLavaSplash_9d2d777f0fb0;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoMushroomExplosion = sprFR_sprGreenPopoMushroomExpl_cf782cb69789;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlamePuff = sprFR_sprGreenPopoFlamePuff_7ed38fc185ca;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameSparkle = sprFR_sprGreenPopoFlameSparkle_25fde914fbb3;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameSparkleBig = sprFR_sprGreenPopoFlameSparkle_bd56d1af34f4;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaBomb = sprFR_sprGreenPopoLavaBombBig_a574b282ae77;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaBombBig = sprFR_sprGreenPopoLavaBombBig_08765dd6af8c;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSlash = sprFR_sprGreenPopoLavaSlash_94f4ba764701;
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_spriteinit();
;
fr_Mutations_AugmentBoilingVeins_skill_gml_game_start();
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:111
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_spriteinit() {
var _frl__path = "../sprites/projectiles/popoexplo/";
var _frl__freakPath = "../sprites/enemies/explofreakcharged/";
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentBaseSprites = [[sprExplosion, ("" + string(_frl__path) + "sprPopoRegExplosion.png"), ("" + string(_frl__path) + "sprGreenPopoRegExplosion.png"), 9, 24, 24], [sprSmallExplosion, ("" + string(_frl__path) + "sprPopoSmallRegExplosion.png"), ("" + string(_frl__path) + "sprGreenPopoSmallRegExplosion.png"), 7, 12, 12], [sprFRBase_WeaponFire, ("" + string(_frl__path) + "sprPopoFire.png"), ("" + string(_frl__path) + "sprGreenPopoFire.png"), 7, 8, 8], [sprFRBase_DragonFire, ("" + string(_frl__path) + "sprPopoFire.png"), ("" + string(_frl__path) + "sprGreenPopoFire.png"), 7, 8, 8], [sprFRBase_CannonFire, ("" + string(_frl__path) + "sprPopoFire.png"), ("" + string(_frl__path) + "sprGreenPopoFire.png"), 7, 8, 8], [sprFlameBall, ("" + string(_frl__path) + "sprPopoFlameBall.png"), ("" + string(_frl__path) + "sprGreenPopoFlameBall.png"), 6, 16, 16], [sprFireShell, ("" + string(_frl__path) + "sprPopoFireShell.png"), ("" + string(_frl__path) + "sprGreenPopoFireShell.png"), 2, 8, 8], [sprRocketFlame, ("" + string(_frl__path) + "sprPopoRocketFlame.png"), ("" + string(_frl__path) + "sprGreenPopoRocketFlame.png"), 3, 26, 6], [sprNukeFlame, ("" + string(_frl__path) + "sprPopoNukeFlame.png"), ("" + string(_frl__path) + "sprGreenPopoNukeFlame.png"), 3, 32, 12], [sprNuke, ("" + string(_frl__path) + "sprPopoNuke.png"), ("" + string(_frl__path) + "sprGreenPopoNuke.png"), 1, 6, 8], [sprFlare, ("" + string(_frl__path) + "sprPopoFlare.png"), ("" + string(_frl__path) + "sprGreenPopoFlare.png"), 2, 3, 3], [sprExploFreakIdle, ("" + string(_frl__freakPath) + "sprExploFreakChargedIdle.png"), undefined, 6, 16, 16], [sprExploFreakWalk, ("" + string(_frl__freakPath) + "sprExploFreakChargedWalk.png"), undefined, 4, 16, 16], [sprExploFreakHurt, ("" + string(_frl__freakPath) + "sprExploFreakChargedHurt.png"), undefined, 3, 16, 16], [sprExploFreakDead, ("" + string(_frl__freakPath) + "sprExploFreakChargedDead.png"), undefined, 6, 16, 16]];
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentBaseSpritesRestore = [sprExplosion, sprSmallExplosion, sprFRBase_WeaponFire, sprFRBase_DragonFire, sprFRBase_CannonFire, sprFlameBall, sprFireShell, sprRocketFlame, sprNukeFlame, sprNuke, sprFlare, sprExploFreakIdle, sprExploFreakWalk, sprExploFreakHurt, sprExploFreakDead];
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods = [];
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpriteStorage = ds_list_create();
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSprites = ds_list_create();
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderCreep", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderCreep, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderCreep);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFireSlash", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireSlash, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireSlash);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameTrail", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameTrail, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameTrail);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameBulletHit", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameBulletHit, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameBulletHit);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderFireFly", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireFly, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireFly);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameRocket", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameRocket, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameRocket);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "oilColors", [make_color_rgb(15, 189, 255), make_color_rgb(0, 114, 250)], [make_color_rgb(0, 255, 0), make_color_rgb(63, 156, 0)]);
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprFlameCreepBubble", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameCreepBubble, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameCreepBubble);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderShell", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderShell, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderShell);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "Frontier_Projectiles", "sprGunpowderShellDisappear", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGunpowderShellDisappear, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoGunpowderShellDisappear);
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:167
function fr_Mutations_AugmentBoilingVeins_skill_gml_game_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentBoilingVeins_skill_gml_game_start_resume, id, scrFROther(other), _args, 6, []);
}
function fr_Mutations_AugmentBoilingVeins_skill_gml_game_start_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentBoilingVeins_skill_gml_game_start");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentBoilingVeins.skill.gml:259
{
;
}
_fr.pc=0;
break;
case 2: // Mutations/AugmentBoilingVeins.skill.gml:259
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Mutations/AugmentBoilingVeins.skill.gml:257
{
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite();
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentBoilingVeins.skill.gml:257
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 5: // Mutations/AugmentBoilingVeins.skill.gml:256
_fr.pc = (((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced == true) && (! scrFRGetSkill("AugmentBoilingVeins")))) ? 4 : 0;
break;
case 6: // Mutations/AugmentBoilingVeins.skill.gml:170
{
if (scrFRModLoaded("mod", "defpack tools")) {
{
_fr.vars._knownIndex = 0;
;
_fr.vars._seeMe = 0;
;
_fr.vars._sprPath = scrFRModGet("mod", "defpack tools", "spr");
repeat (array_length(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods)) {
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods, _fr.vars._knownIndex) == "defpack tools")) {
{
_fr.vars._seeMe += 1;
;
}
}
_fr.vars._knownIndex += 1;
;
}
if ((_fr.vars._seeMe <= 0)) {
{
array_push(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods, "defpack tools");
;
{ var __fr_with1 = scrFRWithValues(_fr.vars._sprPath), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBullet, "FireBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBulletHit, "FireBulletHit", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBulletHit, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBulletHit);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBullet, "HeavyFireBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBulletHit, "HeavyFireBulletHit", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBulletHit, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBulletHit);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", FireBulletBounce, "FireBulletBounce", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBulletBounce, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBulletBounce);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", HeavyFireBulletBounce, "HeavyFireBulletBounce", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHeavyFireBulletBounce, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoHeavyFireBulletBounce);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext("mod", "defpack tools", "spr", GasFire, "GasFire", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoGasFire, undefined);
;
}
}
if(__fr_break3) break;
}}
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "flame shot cannon", "sprShotBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireShot, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireShot);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fire moby", "FireBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "big fire iron", "FireBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fire subata", "sprBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fire gunhammer", "sprFireGunhammerSlash", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireGunhammerSlash, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireGunhammerSlash);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "heavy fire gunhammer", "sprHeavyFireGunhammerSlash", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireGunhammerSlash, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireGunhammerSlash);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "mega fire revolver", "sprMegaFireBullet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoMegaFireBullet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoMegaFireBullet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "sniper fire rifle", "sprFireMuzzle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireMuzzle, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireMuzzle);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "sniper fire shotgun", "sprFireMuzzle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireMuzzle, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireMuzzle);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("mod", "defpack tools 2", "sprFireFlak", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireFlak, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFireFlak);
;
}
}
}
}
if (scrFRModLoaded("mod", "undergrowth")) {
{
_fr.vars._knownIndex = 0;
;
_fr.vars._seeMe = 0;
;
repeat (array_length(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods)) {
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods, _fr.vars._knownIndex) == "undergrowth")) {
{
_fr.vars._seeMe += 1;
;
}
}
_fr.vars._knownIndex += 1;
;
}
if ((_fr.vars._seeMe <= 0)) {
{
array_push(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpritesMods, "undergrowth");
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprEmber", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoEmber, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoEmber);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprDirectionalExplosion", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoDirectionalExplosion, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoDirectionalExplosion);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprLavaSheet", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSheet, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSheet);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprLavaStreak", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaStreak, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaStreak);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprLavaSplash", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSplash, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSplash);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprMushroomExplosion", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoMushroomExplosion, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoMushroomExplosion);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlamePuff", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlamePuff, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlamePuff);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlameSparkle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameSparkle, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameSparkle);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlameSparkleBig", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlameSparkleBig, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoFlameSparkleBig);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fossil gun", "sprLavaBomb", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaBomb, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaBomb);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fossil cannon", "sprLavaBombBig", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaBombBig, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaBombBig);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("weapon", "fossil hammer", "sprLavaSlash", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoLavaSlash, global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenPopoLavaSlash);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFireflyIdle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyIdle, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFireflyWalk", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyWalk, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFireflyHurt", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyHurt, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFireflyDead", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyDead, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFireflyExplode", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFireflyExplode, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapIdle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapIdle, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapWalk", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapWalk, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapHurt", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapHurt, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapDead", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapDead, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapChrg", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapChrg, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprFlytrapFire", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoFlytrapFire, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantIdle", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantIdle, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantWalk", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantWalk, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantHurt", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantHurt, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantDead", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantDead, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantCharge", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantCharge, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprPitcherPlantFire", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoPitcherPlantFire, undefined);
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite("area", "undergrowth", "sprHealFire", global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprPopoHealFire, undefined);
;
}
}
}
}
}
_fr.pc=5;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentBoilingVeins.skill.gml:263
function fr_Mutations_AugmentBoilingVeins_skill_gml_load_options(_frl__options=undefined) {
var _frl__prevSettingProjectiles = global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles;
var _frl__prevSettingGreen = global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingGreenAugments;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles = _frl__options.settingAugmentProjectiles;
;
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingGreenAugments = _frl__options.settingGreenAugments;
;
if (scrFRGetSkill("AugmentBoilingVeins")) {
{
if (((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced == true) && (global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles == false))) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite();
;
}
}
if (((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced == false) && (global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles != _frl__prevSettingProjectiles))) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_resprite();
;
}
}
if (((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced == true) && (global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles != _frl__prevSettingGreen))) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite();
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_resprite();
;
}
}
}
}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:285
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentBoilingVeins:0", "OVERCHARGED FUEL"));
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:286
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentBoilingVeins:1", "@wFIRE/EXPLOSIVES @sDEAL MORE DAMAGE#@wEXPLOSIONS @(color:16776960)DESTROY @wENEMY BULLETS"));
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:287
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_tip() {
return scrFRLocalize("BURNS SO BRIGHT");
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:288
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprSkillIcon);
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:289
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprSkillHud;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:290
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:291
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_wepspec() {
return 1;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:292
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:293
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_augment() {
return mut_boiling_veins;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:295
function fr_Mutations_AugmentBoilingVeins_skill_gml_cleanup() {
if ((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced == true)) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite();
;
}
}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:300
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_take() {
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeinsController_create(10016, 10016);
;
if ((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingAugmentProjectiles == true)) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_resprite();
;
}
}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:306
function fr_Mutations_AugmentBoilingVeins_skill_gml_skill_lose() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_AugmentBoilingVeinsController")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite();
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:312
function fr_Mutations_AugmentBoilingVeins_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].levelStart = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:AugmentBoilingVeins"].levelStart) {
{
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].levelStart = false;
;
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeinsController_create(10016, 10016);
;
}
}
}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:321
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeinsController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AugmentBoilingVeinsController";
on_end_step = fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_endstep;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:327
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_endstep() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([Flame, FlameBall, FlameShell, Explosion, MeatExplosion], "fr_augmentBoilingVeins", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_projectileEffect();
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(scrFRMatching(projectile, "is_flame", true), "fr_augmentBoilingVeins", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_projectileEffect();
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(scrFRMatching(projectile, "is_explosion", true), "fr_augmentBoilingVeins", undefined)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_projectileEffect();
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(scrFRMatching(projectile, "fr_augBoilDmg", true), "fr_augmentBoilingVeins", undefined)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_projectileEffect();
;
}
}
if(__fr_break12) break;
}}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:341
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_projectileEffect() {
if ((scrFRVariableExists(scrFRSelf(self), "is_explosion") || scrFRInstanceIs(scrFRSelf(self), Explosion))) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), PopoExplosion))) {
{
fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_create(x, y, scrFRSelf(self));
;
}
}
}
}
fr_augmentBoilingVeins = true;
;
damage = round((damage * (1.5 * scrFRGetSkill("AugmentBoilingVeins"))));
}

// Original Mutations/AugmentBoilingVeins.skill.gml:350
function fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AugmentBoilRadius";
;
creator = _frl__creator;
;
lifeTime = 3;
;
team = 2;
;
if ((creator.mask_index != undefined)) {
{
mask_index = creator.mask_index;
;
}
} else {
{
mask_index = creator.sprite_index;
;
}
}
on_anim = fr_Mutations_AugmentBoilingVeins_skill_gml_nothing;
;
on_step = fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_step;
;
on_wall = fr_Mutations_AugmentBoilingVeins_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentBoilingVeins_skill_gml_nothing;
;
on_projectile = fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:372
function fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_step() {
lifeTime -= scrFRSourceScale();
;
if (((! scrFRInstanceExists(creator)) || (lifeTime <= 0))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = creator.x;
;
y = creator.y;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:381
function fr_Mutations_AugmentBoilingVeins_skill_gml_BoilRadius_nullify() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRVariableExists(scrFRSelf(self), "name")) {
{
if ((name == "DirectionalExplosion")) {
{
exit;
;
}
}
}
}
scrFRSoundPitchVolume(sndPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprGreenNull : global.fr_module_vars[$ "skill:AugmentBoilingVeins"].sprNull));
;
}
}
if(__fr_break6) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:397
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite(_frl__baseModType=undefined, _frl__baseMod=undefined, _frl__baseVar=undefined, _frl__popospr=undefined, _frl__greenspr=undefined) {
ds_list_add(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpriteStorage, [[_frl__baseModType, _frl__baseMod, _frl__baseVar, undefined, undefined], scrFRModGet(_frl__baseModType, _frl__baseMod, _frl__baseVar)]);
;
ds_list_add(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSprites, [[_frl__baseModType, _frl__baseMod, _frl__baseVar, undefined, undefined], _frl__popospr, _frl__greenspr]);
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:401
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_addsprite_ext(_frl__baseModType=undefined, _frl__baseMod=undefined, _frl__spriteVar=undefined, _frl__sprite=undefined, _frl__spriteName=undefined, _frl__popospr=undefined, _frl__greenspr=undefined) {
var _frl__sprSource = scrFRModGet(_frl__baseModType, _frl__baseMod, _frl__spriteVar);
;
{ var __fr_with1 = scrFRWithValues(_frl__sprSource), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
ds_list_add(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpriteStorage, [[_frl__baseModType, _frl__baseMod, _frl__spriteVar, _frl__sprite, _frl__spriteName], _frl__sprite]);
;
ds_list_add(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSprites, [[_frl__baseModType, _frl__baseMod, _frl__spriteVar, _frl__sprite, _frl__spriteName], _frl__popospr, _frl__greenspr]);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentBoilingVeins.skill.gml:409
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_resprite() {
var _frl__color = (global.fr_module_vars[$ "skill:AugmentBoilingVeins"].settingGreenAugments ? 2 : 1);
var _frl__spr = global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentBaseSprites;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__spr)); _frl_i++) {
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), _frl__color) != undefined)) {
{
scrFRSpriteReplacePath(scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), _frl__color), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 3), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 4), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 5));
;
}
}
}
}
var _frl__sprites = global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSprites;
;
{
var _frl_i = 0;
for (; (_frl_i < ds_list_size(_frl__sprites)); _frl_i++) {
var _frl__spr = ds_list_find_value(_frl__sprites, _frl_i);
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 3) != undefined)) {
{
if ((scrFRIndexGet(_frl__spr, _frl__color) != undefined)) {
{
var _frl__sprSource = scrFRModGet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2));
;
scrFRLQSet(_frl__sprSource, scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 4), scrFRIndexGet(_frl__spr, 1));
}
}
}
} else {
{
if ((scrFRIndexGet(_frl__spr, _frl__color) != undefined)) {
{
scrFRModSet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2), scrFRIndexGet(_frl__spr, _frl__color));
;
}
}
}
}
}
}
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced = true;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:438
function fr_Mutations_AugmentBoilingVeins_skill_gml_AugmentBoilingVeins_restoresprite() {
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentBaseSpritesRestore)); _frl_i++) {
scrFRSpriteRestore(scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentBaseSpritesRestore, _frl_i));
;
}
}
var _frl__storage = global.fr_module_vars[$ "skill:AugmentBoilingVeins"].augmentSpriteStorage;
;
{
var _frl_i = 0;
for (; (_frl_i < ds_list_size(_frl__storage)); _frl_i++) {
var _frl__spr = ds_list_find_value(_frl__storage, _frl_i);
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 3) != undefined)) {
{
var _frl__sprSource = scrFRModGet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2));
;
scrFRLQSet(_frl__sprSource, scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 4), scrFRIndexGet(_frl__spr, 1));
}
} else {
{
scrFRModSet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2), scrFRIndexGet(_frl__spr, 1));
;
}
}
}
}
global.fr_module_vars[$ "skill:AugmentBoilingVeins"].spritesReplaced = false;
;
}

// Original Mutations/AugmentBoilingVeins.skill.gml:458
function fr_Mutations_AugmentBoilingVeins_skill_gml_nothing() {

}
