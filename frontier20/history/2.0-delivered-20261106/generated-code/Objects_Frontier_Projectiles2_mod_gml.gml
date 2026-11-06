#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_anim_end (((image_index + image_speed) >= image_number) || ((image_index + image_speed) < 0))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_instance_max scrFRInstanceCreate(0, 0, FRMarker)

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_Objects_Frontier_Projectiles2_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

// Original Objects/Frontier_Projectiles2.mod.gml:1
function fr_Objects_Frontier_Projectiles2_mod_gml___load() {

}

// Original Objects/Frontier_Projectiles2.mod.gml:6
function fr_Objects_Frontier_Projectiles2_mod_gml_init() {
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].settingGreenAugments = false;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreepShell = sprFR_sprCrematorShell_093a06de5b63;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreepShellDisappear = sprFR_sprCrematorShellDisappea_62aece6fe6ce;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreep = sprFR_sprCreep_d9e998606286;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprFlameCreepBubble = sprFR_sprFlameCreepBubble_ce757b580381;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprFlameStreak = sprFR_sprFlameStreak_5cb00905de79;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocket = sprFR_sprSwarmRocket_043d4f9437ee;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketBig = sprFR_sprSwarmRocketBig_f443c3d7735f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketExplosion = sprFR_sprSwarmRocketExplosion_757c440f9394;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketTrail = sprFR_sprSwarmRocketTrail_dbb49facf949;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketFlame = sprFR_sprSwarmRocketFlame_23b7ea9648e3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprFriendLabsRocketExplosion = sprFR_sprFriendLabsRocketExplo_0b4965d204da;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPelletFizzle = sprFR_sprPelletFizzle_de20904e2351;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].mskEnergyPellet = sprFR_mskEnergyPellet_e4f0cfe24219;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPellet = sprFR_sprEnergyPellet_2e5585dca53f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletDisappear = sprFR_sprEnergyPelletDisappear_cca09704e6a4;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletTrail = sprFR_sprEnergyPelletTrail_5d7fcf8b7bec;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPlagueGas = sprFR_sprPlagueGas_7baf0f05fad3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPlagueBolt = sprFR_sprPlagueBolt_aa6cd1a27813;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlug = sprFR_sprGluonSlug_1846f3a32fb4;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlugDisappear = sprFR_sprGluonSlugDisappear_29393288e94e;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlugHit = sprFR_sprGluonSlugHit_adfb50f30e31;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprQuarkShell = sprFR_sprQuarkShell_21d2ce221e69;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprQuarkShellDisappear = sprFR_sprQuarkShellDisappear_67f36d51c480;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter = sprFR_sprTeleBulletEnter_67667091e679;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit = sprFR_sprTeleBulletExit_2bee5ccdf09f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBullet = sprFR_sprTeleBullet_58a54f294cb8;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletHit = sprFR_sprTeleBulletHit_20e00c8b653a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail = sprFR_sprTeleBulletTrail_1ee871a3f1fb;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBouncerBullet = sprFR_sprTeleBouncerBullet_7a905d5d7e01;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBullet = sprFR_sprTeleFireBullet_b5667b7121ba;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBulletHit = sprFR_sprTeleFireBulletHit_ba96de135d13;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBulletFlame = sprFR_sprTeleFireBulletFlame_e629d48a95af;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleGammaBullet = sprFR_sprTeleGammaBullet_9a4cdf99723f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleGammaBulletHit = sprFR_sprTeleGammaBulletHit_a49f4dc1fd88;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBullet = sprFR_sprTelePestBullet_e00edcbe7b13;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBulletHit = sprFR_sprTelePestBulletHit_0baaeac44795;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBulletGas = sprFR_sprTelePestBulletGas_e845f2f18df4;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePsyBullet = sprFR_sprTelePsyBullet_34501293e011;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePsyBulletHit = sprFR_sprTelePsyBulletHit_dd88c59b62dc;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleThunderBullet = sprFR_sprTeleThunderBullet_ad83cdd03a17;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleThunderBulletHit = sprFR_sprTeleThunderBulletHit_e239ead860ab;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].mskPopoRocketSmall = sprFR_mskPopoRocketSmall_4944d7c8641b;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoRocketSmall = sprFR_sprPopoRocketSmall_9ec296be679a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoRocketFlameSmall = sprFR_sprPopoRocketFlameSmall_ff35fa071458;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoExplosionSmall = sprFR_sprPopoExplosionSmall_9e8ad8a5e3c3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenRogueExplosion = sprFR_sprGreenRogueExplosion_7f1ff4b13d08;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoRocketSmall = sprFR_sprGreenPopoRocketSmall_56d9acdd12cf;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoRocketFlameSmall = sprFR_sprGreenPopoRocketFlameS_c6d347dcffde;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoExplosionSmall = sprFR_sprGreenPopoExplosionSma_07d3b17a6c82;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:72
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_create(_frl__x=undefined, _frl__y=undefined, _frl__charged=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreepShell);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreepShellDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreepShellDisappear;
;
fr_bloom = [2, 0.2];
;
fr_glow = [32, 48];
;
speed = (16) * timescale;
;
friction = (0.6) * (timescale * timescale);
;
typ = 1;
;
damage = 2;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "CREEP SHELL"];
;
bonus = true;
;
bonus_damage = 1;
;
minspeed = 6;
;
maxspeed = (16) * timescale;
;
wallbounce = (4 * scrFRGetSkill(mut_shotgun_shoulders));
;
ammo_type = 2;
;
is_shell = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_wall;
;
on_alrm2 = ["mod", "Frontier_Projectiles2", fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:112
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_anim() {
if ((sprite_index != spr_fade)) {
{
image_speed = (0) * timescale;
;
image_index = (image_number - 1);
;
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:123
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm2_run) {
exit;
}
if ((scrFRSourceRandom(16) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.direction + 180) + fr_Objects_Frontier_Projectiles2_mod_gml_orandom(10)), ((__fr_other4.speed / timescale) / 2));
}
}
if(__fr_break3) break;
}}
}
}
if ((((speed / timescale) < minspeed) && (sprite_index != spr_fade))) {
{
fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_spreadcreep();
;
sprite_index = scrFRAreaSourceSprite(spr_fade);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:142
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_alrm2() {
bonus = false;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:145
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_dead);
;
}
}
if(__fr_break4) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_spreadcreep();
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:157
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_wall() {
scrFRInstanceCreate(x, y, Smoke);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
if (((wallbounce > 0) && (! bonus))) {
{
bonus = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.8) + wallbounce), (maxspeed / timescale))) * timescale;
;
wallbounce *= 0.95;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:175
function fr_Objects_Frontier_Projectiles2_mod_gml_CreepShell_spreadcreep() {
scrFRSoundPitchVolume(sndExplosionS, (1.4 + scrFRSourceRandom(0.1)), 0.6);
;
scrFRSoundPitchVolume(sndFrogEggHurt, (1.3 + scrFRSourceRandom(0.1)), 0.4);
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
}
}
if(__fr_break3) break;
}}
repeat (2) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprFlameStreak);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:194
function fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprCreep);
;
spr_bubble = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprFlameCreepBubble;
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
creep_color = make_color_rgb(252, 56, 0);
creep_color_2 = make_color_rgb(160, 30, 0);
image_blend = creep_color;
;
fr_bloom = [2, 0.1];
;
fr_glow = [0, 0];
;
underwater_fx = ((scrFRArrayFindIndex([101, "oasis"], GameCont.area) >= 0) || (scrFRSourceAreaIsString(GameCont.area) && (scrFRModCall("area", GameCont.area, "area_underwater") == true)));
;
particle_chance = 20;
;
speed = (0) * timescale;
;
typ = 0;
;
damage = 2;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "MOLTEN CREEP"];
;
lifetime = 120;
;
allGrownUp = false;
;
maxSize = 1;
;
fr_ignitePowder = true;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_nothing;
;
scrFRBindDraw(fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreepLow_draw, (depth + 1), scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:233
function fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
lifetime -= scrFRSourceScale();
;
fr_glow = [(32 * image_xscale), (48 * image_xscale)];
if (underwater_fx) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles2_mod_gml_orandom(16)), (y + fr_Objects_Frontier_Projectiles2_mod_gml_orandom(16)), Bubble);
}
}
}
}
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.1;
;
image_yscale = image_xscale;
;
if ((image_xscale >= maxSize)) {
{
allGrownUp = true;
;
}
}
}
}
if (((allGrownUp == true) && (lifetime > 0))) {
{
image_xscale = (maxSize + fr_Objects_Frontier_Projectiles2_mod_gml_orandom(0.02));
;
image_yscale = image_xscale;
;
if ((scrFRSourceRandom(particle_chance) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles2_mod_gml_orandom((16 * maxSize))), (y + fr_Objects_Frontier_Projectiles2_mod_gml_orandom((16 * maxSize))), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_bubble);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((lifetime <= 0)) {
{
image_xscale -= 0.05;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:276
function fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreep_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var _frl_dmg = damage;
if (scrFRVariableExists((scrFROther(other)), "boilcap")) {
{
var __fr_other1=scrFROther(other);
_frl_dmg = min(damage, max(0, (__fr_other1.hp - (__fr_other1.boilcap * scrFRGetSkill(mut_boiling_veins)))));
}
}
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, _frl_dmg);
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:285
function fr_Objects_Frontier_Projectiles2_mod_gml_PlayerCreepLow_draw(_frl__creep=undefined) {
if ((! scrFRInstanceExists(_frl__creep))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__creep), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, (y + 1), image_xscale, image_yscale, image_angle, creep_color_2, image_alpha);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:294
function fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketBig);
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketFlame;
;
image_angle = direction;
;
speed = (2) * timescale;
;
maxspeed = (12) * timescale;
;
friction = ((- 0.5)) * (timescale * timescale);
;
typ = 1;
;
damage = 3;
;
ammo_type = 4;
;
is_rocket = true;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "HIVE ROCKET"];
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_step;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:323
function fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_step() {
if (((speed / timescale) >= (maxspeed / timescale))) {
{
friction = (0) * (timescale * timescale);
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:328
function fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_destroy() {
scrFRSoundStop(sndRocketFly);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketExplosion);
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
var _frl__offset = scrFRSourceRandom(360);
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += 90) {
{ var __fr_with7 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_create(x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = (_frl_i + _frl__offset);
;
var __fr_other10=scrFROther(other);
team = __fr_other10.team;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11.creator;
;
var __fr_other12=scrFROther(other);
hitid = __fr_other12.hitid;
;
}
}
if(__fr_break9) break;
}}
}
}
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_big_ext(sndExplosion, (0.9 + scrFRSourceRandom(0.3)), 0.8);
;
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndRocket, (0.9 + scrFRSourceRandom(0.3)), 0.8);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:350
function fr_Objects_Frontier_Projectiles2_mod_gml_HiveRocket_draw() {
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, 1, 1.2, image_angle, c_white, image_alpha);
;
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, (1.8 * image_xscale), (1.8 * image_yscale), image_angle, c_white, 0.2);
;
gpu_set_blendmode(bm_normal);
;
draw_self();
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:357
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocket);
;
spr_trail = sprRocketFlame;
;
image_angle = direction;
;
trailColor = make_color_rgb(234, 255, 66);
;
speed = (3) * timescale;
;
friction = ((- 0.1)) * (timescale * timescale);
;
maxspeed = (12) * timescale;
;
typ = 1;
;
damage = 3;
;
ammo_type = 4;
;
is_rocket = true;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "SWARM ROCKET"];
;
active = false;
;
activeTimer = 10;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_step;
;
on_end_step = fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:391
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_step() {
if ((activeTimer > 0)) {
{
activeTimer -= scrFRSourceScale();
;
if ((activeTimer <= 0)) {
{
active = true;
;
speed = (8) * timescale;
;
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketTrail);
;
image_angle = scrFRSourceRandom(360);
;
image_index = scrFRSourceIRandom(1);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
if ((active == true)) {
{
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if (scrFRInstanceExists(enemy)) {
{
var _frl_myTarget = instance_nearest(x, y, enemy);
;
direction -= (angle_difference(direction, point_direction(x, y, _frl_myTarget.x, _frl_myTarget.y)) * power(0.12, 1));
;
}
}
}
}
}
}
image_angle = direction;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:419
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_endstep() {
if ((active == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_yscale *= 1.5;
;
image_speed *= 8;
;
var __fr_other6=scrFROther(other);
image_angle = point_direction(x, y, __fr_other6.xprevious, __fr_other6.yprevious);
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.trailColor;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:431
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_wall() {
if ((active == true)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
direction += 180;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:438
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_hit() {
if ((active == true)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:444
function fr_Objects_Frontier_Projectiles2_mod_gml_SwarmRocket_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprSwarmRocketExplosion);
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndExplosion, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 0.8);
;
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndFlareExplode, (0.7 + scrFRSourceRandomRange(0.8, 1.3)), 1.2);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:455
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPellet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletDisappear;
;
image_speed = (0.4) * timescale;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletTrail;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
fr_glow = [32, 48];
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].mskEnergyPellet;
;
speed = (7) * timescale;
;
friction = ((- 0.1)) * (timescale * timescale);
;
maxspeed = (12) * timescale;
;
typ = 1;
;
damage = 22;
;
ammo_type = 5;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "ENERGY PELLET"];
;
lifeTime = (60 + (30 * scrFRGetSkill(mut_laser_brain)));
;
knockback_speed = (6) * timescale;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:489
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_step() {
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
image_angle += 6;
;
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletTrail);
;
var __fr_other4=scrFROther(other);
speed = (((__fr_other4.speed / timescale) / 6)) * timescale;
;
var __fr_other5=scrFROther(other);
direction = (__fr_other5.direction + 180);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:507
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHitPush(__fr_other1, damage, (knockback_speed / timescale));
;
var __fr_other2=scrFROther(other);
lasthit = __fr_other2;
;
if (((scrFROther(other)).hp > 0)) {
{
var __fr_other3=scrFROther(other);
direction = point_direction(__fr_other3.x, __fr_other3.y, x, y);
;
}
}
var __fr_other4=scrFROther(other);
direction = point_direction(__fr_other4.x, __fr_other4.y, x, y);
;
if ((scrFRInstanceNumber(enemy) > 1)) {
{
{ var __fr_with5 = scrFRWithValues((scrFROther(other))), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var _frl__enemy = instance_furthest(x, y, enemy);
;
{ var __fr_with8 = scrFRWithValues((scrFROther(other))), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if ((lasthit != _frl__enemy)) {
{
var __fr_other11=scrFROther(other);
direction -= (angle_difference(direction, point_direction(x, y, _frl__enemy.x, _frl__enemy.y)) / (scrFRSourceRandom((__fr_other11.size + 0.5)) + 1));
;
}
}
}
}
if(__fr_break10) break;
}}
}
}
if(__fr_break7) break;
}}
}
}
{ var __fr_with12 = scrFRWithValues((scrFROther(other))), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
var _frl__me = scrFRSelf(self);
;
if ((((((((! scrFRInstanceIs(scrFRSelf(self), prop)) && (! scrFRInstanceIs(scrFRSelf(self), SnowTank))) && (! scrFRInstanceIs(scrFRSelf(self), GoldSnowTank))) && (! scrFRInstanceIs(scrFRSelf(self), LilHunter))) && (! scrFRInstanceIs(scrFRSelf(self), TechnoMancer))) && (hp <= 0)) && (size < 4))) {
{
if (scrFRVariableExists(scrFRSelf(self), "corpse")) {
{
if ((corpse == true)) {
{
{ var __fr_with15 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_create(x, y, _frl__me.spr_hurt)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
scrFRMotionAdd(_frl__me.direction, ((_frl__me.speed / timescale) / 3));
;
}
}
if(__fr_break17) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndPlasmaBig, (1.5 + scrFRSourceRandom(0.4)), 0.8);
;
spr_dead = mskNone;
;
}
}
}
}
}
}
}
}
if(__fr_break14) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:552
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_wall() {
move_bounce_solid(true);
;
direction += scrFRSourceRandomRange((- 5), 5);
;
if ((scrFRSourceRandom(2) < 1)) {
{
if (scrFRInstanceExists(enemy)) {
{
var _frl__enemy = instance_nearest(x, y, enemy);
;
direction = point_direction(x, y, _frl__enemy.x, _frl__enemy.y);
}
}
}
}
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletTrail);
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + scrFRSourceRandomRange((- 45), 45));
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
image_xscale = 2;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndDogGuardianBounce, (0.8 + scrFRSourceRandom(0.3)), 0.8);
;
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndBouncerBounce, (0.3 + scrFRSourceRandom(0.3)), 0.8);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:575
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPellet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.image_angle;
;
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_dead);
;
}
}
if(__fr_break3) break;
}}
repeat (10) {
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprEnergyPelletTrail);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
image_xscale = 2;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break8) break;
}}
}
repeat (5) {
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break11) break;
}}
}
scrFRSoundPitchVolume(sndDogGuardianHurt, (1.1 + scrFRSourceRandom(0.2)), 0.6);
;
scrFRSoundPitchVolume(sndLightningCannonEnd, (1.1 + scrFRSourceRandom(0.2)), 0.6);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:602
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_create(_frl__x=undefined, _frl__y=undefined, _frl__spr=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_energypelletcorpse";
;
sprite_index = scrFRAreaSourceSprite(_frl__spr);
;
image_speed = (0) * timescale;
;
depth = (- 15);
;
var __fr_other4=scrFROther(other);
image_xscale = (__fr_other4.image_xscale * (scrFRVariableExists(__fr_other4, "right") ? __fr_other4.right : 1));
;
image_blend = make_color_rgb(255, 207, 163);
;
lifeTime = 30;
;
turnSpeed = (scrFRSourceRandomRange(0.5, 1.5) * scrFRSourceScale());
;
fr_bloom = [2, 0.1];
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_step;
;
on_draw = fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:621
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
y -= 1;
;
image_angle += (image_xscale * turnSpeed);
;
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange(((- sprite_width) / 2), (sprite_width / 2))), (y + scrFRSourceRandomRange(((- sprite_height) / 2), (sprite_height / 2))), NTTEFullSweat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPelletFizzle);
;
direction = (90 + scrFRSourceRandomRange((- 20), 20));
;
speed = ((1 + scrFRSourceRandom(1))) * timescale;
;
var __fr_other4=scrFROther(other);
depth = __fr_other4.depth;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
}
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
repeat (8) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullSweat)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPelletFizzle);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other8=scrFROther(other);
depth = __fr_other8.depth;
;
}
}
if(__fr_break7) break;
}}
}
scrFRInstanceDestroy();
;
exit;
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:652
function fr_Objects_Frontier_Projectiles2_mod_gml_EnergyPelletCorpse_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, ((lifeTime > 1) ? c_black : make_color_rgb(255, 207, 163)), (image_alpha * (lifeTime / 30)));
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:655
function fr_Objects_Frontier_Projectiles2_mod_gml_InflictPlague(_frl__target=undefined, _frl__length=undefined, _frl__gasLevel=undefined) {
if (scrFRInstanceIs(_frl__target, Player)) {
{
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", _frl__target, scrFRModGet("mod", "Frontier_StatusEffects", "debuffPlague"), (_frl__length / 3));
;
{ var __fr_with1 = scrFRWithValues(_frl__target), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_plagueLevel"))) {
{
fr_plagueLevel = (- 1);
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
{
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", _frl__target, scrFRModGet("mod", "Frontier_StatusEffects", "debuffPlague"), _frl__length);
;
{ var __fr_with4 = scrFRWithValues(_frl__target), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "fr_plagueLevel")) || (fr_plagueLevel == (- 1)))) {
{
fr_plagueLevel = _frl__gasLevel;
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:673
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPlagueBolt);
;
hitid = [sprite_index, "PLAGUE BOLT"];
;
trailColor = make_color_rgb(176, 60, 129);
;
depth = (- 1);
;
mask_index = mskHeavyBolt;
;
speed = (16) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
damage = 50;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
ammo_type = 3;
;
is_bolt = true;
;
home_inst = noone;
;
home_dir = 0;
;
stuckOn = noone;
;
lifeTime = 90;
;
wallOffset = (- 24);
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_step;
;
on_end_step = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:709
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:713
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_step() {
if ((stuckOn == noone)) {
{
if ((home_inst != noone)) {
{
if ((scrFRInstanceExists(home_inst) && scrFRProjectileCanHitMelee(home_inst))) {
{
if (((abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90) && (! scrFRPlaceMeeting((x + lengthdir_x((speed / timescale), home_dir)), (y + lengthdir_y((speed / timescale), home_dir)), home_inst)))) {
{
var _frl__tx = (home_inst.x - lengthdir_x((speed / timescale), home_dir));
var _frl__ty = (home_inst.y - lengthdir_y((speed / timescale), home_dir));
var _frl__diff = ((angle_difference(point_direction(x, y, _frl__tx, _frl__ty), direction) * 0.5) * scrFRSourceScale());
;
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
{
home_inst = noone;
;
direction = home_dir;
;
image_angle = direction;
;
}
}
}
} else {
if ((direction != home_dir)) {
{
var _frl__diff = angle_difference(home_dir, direction);
;
if ((abs(_frl__diff) > 10)) {
_frl__diff = ((_frl__diff * 0.5) * scrFRSourceScale());
}
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
home_inst = noone;
}
}
;
}
} else {
{
home_dir = direction;
;
var _frl__disMax = (24 * scrFRGetSkill(mut_bolt_marrow));
;
if ((_frl__disMax > 0)) {
{
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(hitme, "team", team, 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{
var _frl__dis = distance_to_point(((scrFROther(other)).x + ((scrFROther(other)).hspeed / timescale)), ((scrFROther(other)).y + ((scrFROther(other)).vspeed / timescale)));
;
if ((_frl__dis < _frl__disMax)) {
{
if (scrFRPlaceMeeting((scrFROther(other)).x, (scrFROther(other)).y, (scrFROther(other)))) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
}
}
}
}
if(__fr_break3) break;
}}
home_inst = _frl__nearest;
;
}
}
}
}
if (((speed / timescale) > 0)) {
{
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((lifeTime <= 82)) {
{
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create(x, y, 2)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
direction = (((__fr_other7.direction + 180) + 45) + (sin((scrFRSourceFrame() * 0.2)) * 20));
;
lifeTime /= 2;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with8 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create(x, y, 2)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
direction = (((__fr_other11.direction + 180) - 45) + (sin((scrFRSourceFrame() * 0.2)) * 20));
;
lifeTime /= 2;
;
}
}
if(__fr_break10) break;
}}
}
}
}
}
}
}
}
} else {
{
if ((! scrFRInstanceExists(stuckOn))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
x = (stuckOn.x + lengthdir_x(wallOffset, direction));
;
y = (stuckOn.y + lengthdir_y(wallOffset, direction));
;
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with12 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create(stuckOn.x, stuckOn.y, 2)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break14) break;
}}
}
}
}
}
}
}
}
}
if ((stuckOn == noone)) {
{
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
if ((((speed / timescale) <= 0) && (stuckOn == noone))) {
{
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((lifeTime <= 82)) {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with15 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create((x + lengthdir_x((- 5), direction)), (y + lengthdir_y((- 5), direction)), 3)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
var __fr_other18=scrFROther(other);
direction = (((__fr_other18.direction + 180) + 45) + (sin((scrFRSourceFrame() * 0.2)) * 20));
}
}
if(__fr_break17) break;
}}
{ var __fr_with19 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create((x + lengthdir_x((- 5), direction)), (y + lengthdir_y((- 5), direction)), 3)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
var __fr_other22=scrFROther(other);
direction = (((__fr_other22.direction + 180) - 45) + (sin((scrFRSourceFrame() * 0.2)) * 20));
}
}
if(__fr_break21) break;
}}
}
}
}
}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:841
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
fr_Objects_Frontier_Projectiles2_mod_gml_InflictPlague(__fr_other1, 600, 3);
;
if (((scrFROther(other)).hp > damage)) {
{
var __fr_other2=scrFROther(other);
stuckOn = __fr_other2;
;
speed = (0) * timescale;
;
mask_index = mskNone;
;
}
}
var __fr_other3=scrFROther(other);
scrFRProjectileHit(__fr_other3, damage, (knockback_speed / timescale));
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:857
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_endstep() {
if ((stuckOn == noone)) {
{
var _frl__x1 = x;
var _frl__y1 = y;
var _frl__x2 = xprevious;
var _frl__y2 = yprevious;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BoltTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.trailColor;
;
image_xscale = point_distance(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
image_yscale = 1.2;
;
image_angle = point_direction(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:872
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_wall() {
if (((speed / timescale) > 0)) {
{
speed = (0) * timescale;
;
mask_index = mskNone;
;
scrFRInstanceCreate(x, y, Dust);
;
move_contact_solid(direction, 8);
;
xprevious = x;
;
yprevious = y;
;
scrFRSoundHit(sndBoltHitWall, 0.2);
;
scrFRSoundHit(sndToxicBarrelGas, 0.2);
;
scrFRInstanceCreate(x, y, Dust);
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:890
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueBolt_destroy() {
scrFRInstanceCreate(x, y, Smoke);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:893
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_create(_frl__x=undefined, _frl__y=undefined, _frl__level=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPlagueGas);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
image_xscale = 0.5;
;
image_yscale = 0.5;
;
hitid = [sprite_index, "PLAGUE"];
;
depth = (- 1);
;
rotateSpeed = ((scrFRSourceRandomRange(2, 5) * scrFRSourceChoose((- 1), 1)) * scrFRSourceScale());
;
fr_bloom = [1.5, 0.1];
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
knockback_speed = (1) * timescale;
;
typ = 2;
;
damage = 2;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 22;
;
ammo_type = (- 1);
;
is_gas = true;
;
lifeTime = 12;
;
allGrownUp = false;
;
maxSize = 1;
;
plagueLevel = _frl__level;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:931
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_step() {
lifeTime -= scrFRSourceScale();
;
image_angle += rotateSpeed;
;
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.1;
;
image_yscale = image_xscale;
;
if ((image_xscale >= maxSize)) {
{
allGrownUp = true;
;
}
}
}
}
if ((lifeTime <= 0)) {
{
image_xscale -= 0.05;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:952
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_hit() {
var __fr_other1=scrFROther(other);
fr_Objects_Frontier_Projectiles2_mod_gml_InflictPlague(__fr_other1, 600, plagueLevel);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:955
function fr_Objects_Frontier_Projectiles2_mod_gml_PlagueGas_wall() {
move_bounce_solid(true);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:958
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlug);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlugDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGluonSlugHit;
;
fr_bloom = [2, 0.2];
;
fr_glow = [32, 48];
;
mask_index = sprFRBase_mskHeavyBullet;
;
speed = ((8 + scrFRSourceRandom(2))) * timescale;
;
friction = (0.01) * (timescale * timescale);
;
typ = 1;
;
damage = 65;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "GLUON SLUG"];
;
bonus = true;
;
bonus_damage = 15;
;
minspeed = 5;
;
maxspeed = (16) * timescale;
;
wallbounce = (2 * scrFRGetSkill(mut_shotgun_shoulders));
;
ammo_type = 2;
;
is_shell = true;
;
is_slug = true;
;
startX = _frl__x;
;
startY = _frl__y;
;
lifeTime = 60;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_wall;
;
on_alrm2 = ["mod", "Frontier_Projectiles2", fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_alrm2];
;
repeat (16) {
{ var __fr_with6 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_create(x, y, scrFRSelf(self))), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
direction = scrFRSourceRandom(360);
;
var __fr_other9=scrFROther(other);
speed = (((__fr_other9.speed / timescale) / 2)) * timescale;
;
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth - 1);
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
}
}
if(__fr_break8) break;
}}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1012
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_anim() {
if ((sprite_index != spr_fade)) {
{
image_speed = (0) * timescale;
;
image_index = (image_number - 1);
;
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1023
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_alarm2_run) {
exit;
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_fade);
;
var __fr_other5=scrFROther(other);
direction = __fr_other5.direction;
;
var __fr_other6=scrFROther(other);
image_angle = __fr_other6.image_angle;
;
var __fr_other7=scrFROther(other);
speed = (((__fr_other7.speed / timescale) / 2)) * timescale;
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1043
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_alrm2() {
bonus = false;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1046
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_hit() {
if (((scrFROther(other)).hp > 0)) {
{
var _frl__health = (scrFROther(other)).hp;
;
if ((((scrFROther(other)).hp - damage) < 0)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
damage -= (_frl__health / 2);
;
repeat (3) {
{ var __fr_with2 = scrFRWithValues(fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_create(x, y, scrFRSelf(self))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
direction = scrFRSourceRandom(360);
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 2)) * timescale;
;
var __fr_other6=scrFROther(other);
depth = (__fr_other6.depth - 1);
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
}
}
if(__fr_break4) break;
}}
}
}
} else {
{
var __fr_other8=scrFROther(other);
scrFRProjectileHit(__fr_other8, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
var __fr_other12=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other12.spr_dead);
;
}
}
if(__fr_break11) break;
}}
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1073
function fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_wall() {
scrFRInstanceCreate(x, y, Smoke);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
if (((wallbounce > 0) && (! bonus))) {
{
bonus = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
move_bounce_solid(true);
;
direction += scrFRSourceRandomRange((- 20), 20);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.9) + wallbounce), (maxspeed / timescale))) * timescale;
;
wallbounce *= 0.95;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1097
function fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_create(_frl__x=undefined, _frl__y=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprQuarkShell);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprQuarkShellDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprQuarkShellDisappear;
;
fr_bloom = [2, 0.1];
;
fr_glow = [16, 24];
;
trailColor = c_yellow;
;
mask_index = mskBullet2;
;
speed = ((5 + scrFRSourceRandom(7))) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 1;
;
damage = 6;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "QUARK SHELL"];
;
bonus = true;
;
bonus_damage = 1;
;
minspeed = 5;
;
maxspeed = (16) * timescale;
;
wallbounce = (4 * scrFRGetSkill(mut_shotgun_shoulders));
;
ammo_type = 2;
;
is_shell = true;
;
weDidIt = false;
;
lifeTime = 240;
;
homingPower = (0.50 + scrFRSourceRandom(0.30));
;
owner = _frl__owner;
;
imOnIt = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_GluonSlug_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1143
function fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_step() {
if ((imOnIt == true)) {
{
if (scrFRInstanceExists(owner)) {
{
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
scrFRMotionAdd(point_direction(x, y, owner.x, owner.y), (homingPower + ((owner.speed / timescale) / 16)));
;
}
}
}
} else {
{
fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_detach();
;
}
}
}
}
image_angle = direction;
;
if (((((speed / timescale) < minspeed) && (sprite_index != spr_fade)) && (imOnIt == false))) {
{
sprite_index = scrFRAreaSourceSprite(spr_fade);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1163
function fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_wall() {
if ((imOnIt == false)) {
{
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
if (((wallbounce > 0) && (! bonus))) {
{
bonus = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
}
}
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.8) + wallbounce), (maxspeed / timescale))) * timescale;
;
wallbounce *= 0.95;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1181
function fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_dead);
;
}
}
if(__fr_break4) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1193
function fr_Objects_Frontier_Projectiles2_mod_gml_QuarkShell_detach() {
imOnIt = false;
;
if (scrFRInstanceExists(enemy)) {
{
var _frl__enemy = instance_nearest(x, y, enemy);
;
direction = (point_direction(x, y, _frl__enemy.x, _frl__enemy.y) + scrFRSourceRandomRange((- 60), 60));
;
}
}
if ((scrFRSourceRandom(3) < 1)) {
{
direction = scrFRSourceRandom(360);
;
}
}
speed = (((maxspeed / timescale) - scrFRSourceRandom(4))) * timescale;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1204
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(107, 214, 185);
;
mask_index = mskBullet1;
;
speed = (12) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1241
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1245
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
image_xscale = (0.7 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_speed = (0.7) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1258
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, damage, (knockback_speed / timescale));
;
if ((teleporms < 1)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1290
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall() {
if ((teleporms > 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + hspeed), (y + vspeed), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_enter);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
var __fr_other6=scrFROther(other);
image_angle = __fr_other6.image_angle;
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
} else {
{
scrFRSoundPitch(sndHitWall, scrFRSourceRandomRange(0.9, 1.1));
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1307
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm() {
teleporms -= 1;
;
direction += scrFRSourceRandomRange((- 10), 10);
;
image_angle = direction;
;
move_outside_solid((direction + 180), (speed / timescale));
;
move_contact_solid((direction + 180), 800);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_exit);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
var __fr_other6=scrFROther(other);
image_angle = (__fr_other6.image_angle + 180);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1324
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1329
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBouncerBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBouncerBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(107, 214, 185);
;
turnspeed = (9 * scrFRSourceChoose((- 1), 1));
;
mask_index = sprFRBase_mskBouncerBullet;
;
speed = (5) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 5;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL BOUNCER BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBouncerBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBouncerBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1367
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBouncerBullet_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
image_angle += turnspeed;
;
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
image_xscale = (0.7 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_speed = (0.7) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1381
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleBouncerBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, damage, (knockback_speed / timescale));
;
if ((teleporms < 1)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
direction += 180;
;
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1439
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleFireBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(107, 144, 214);
;
mask_index = mskBullet1;
;
speed = (12) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL FIRE BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleFireBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleFireBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1476
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleFireBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, damage, (knockback_speed / timescale));
;
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBulletFlame);
;
var __fr_other10=scrFROther(other);
scrFRMotionAdd(__fr_other10.direction, scrFRSourceRandomRange(4, 6));
friction = (2) * (timescale * timescale);
;
damage = 1;
;
}
}
if(__fr_break8) break;
}}
if ((teleporms < 1)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1514
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleFireBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
image_index = 1;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
team = __fr_other8.team;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleFireBulletFlame);
;
var __fr_other9=scrFROther(other);
scrFRMotionAdd(__fr_other9.direction, scrFRSourceRandomRange(4, 6));
friction = (2) * (timescale * timescale);
;
damage = 1;
;
}
}
if(__fr_break7) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1527
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleGammaBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleGammaBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleGammaBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.15];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(149, 255, 98);
;
mask_index = mskBullet1;
;
speed = (12) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL GAMMA BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
pierce = 1;
;
lasthit = noone;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleGammaBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleGammaBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1566
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleGammaBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
if ((lasthit != (scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
lasthit = __fr_other1;
;
{ var __fr_with2 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_dead);
;
}
}
if(__fr_break4) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other6=scrFROther(other);
scrFRProjectileHit(__fr_other6, damage, (knockback_speed / timescale));
;
if ((teleporms < 1)) {
{
if (((-- pierce) < 0)) {
{
scrFRInstanceDestroy();
;
}
}
exit;
;
}
} else {
{
if (((-- pierce) < 0)) {
{
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
lasthit = noone;
;
pierce = 1;
;
}
}
}
}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1606
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleGammaBullet_wall() {
if ((teleporms > 0)) {
{
lasthit = noone;
;
pierce = 1;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + hspeed), (y + vspeed), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_enter);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
var __fr_other6=scrFROther(other);
image_angle = __fr_other6.image_angle;
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
} else {
{
scrFRSoundPitch(sndHitWall, scrFRSourceRandomRange(0.9, 1.1));
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1625
function fr_Objects_Frontier_Projectiles2_mod_gml_TelePestBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(133, 255, 11);
;
mask_index = mskBullet1;
;
speed = (12) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL PEST BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TelePestBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TelePestBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1662
function fr_Objects_Frontier_Projectiles2_mod_gml_TelePestBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, damage, (knockback_speed / timescale));
;
repeat (scrFRSourceChoose(1, 1, 2)) {
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, ToxicGas)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBulletGas);
;
friction *= 10;
;
growspeed /= 8;
;
var __fr_other9=scrFROther(other);
move_contact_solid(__fr_other9.direction, (__fr_other9.speed / timescale));
;
}
}
if(__fr_break8) break;
}}
}
if ((teleporms < 1)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1701
function fr_Objects_Frontier_Projectiles2_mod_gml_TelePestBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
image_index = 1;
;
}
}
if(__fr_break3) break;
}}
repeat (scrFRSourceChoose(1, 1, 2)) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, ToxicGas)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePestBulletGas);
;
friction *= 10;
;
growspeed /= 8;
;
var __fr_other8=scrFROther(other);
move_contact_solid(__fr_other8.direction, (__fr_other8.speed / timescale));
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1715
function fr_Objects_Frontier_Projectiles2_mod_gml_TelePsyBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePsyBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTelePsyBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(185, 107, 214);
;
mask_index = mskBullet1;
;
speed = (7) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL PSY BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
timer = (6 + scrFRSourceIRandom(4));
;
turnspeed = 0.3;
;
range = 70;
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TelePsyBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1755
function fr_Objects_Frontier_Projectiles2_mod_gml_TelePsyBullet_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
timer -= 1;
;
if ((timer <= 0)) {
{
var _frl_closeboy = fr_Objects_Frontier_Projectiles2_mod_gml_instance_nearest_matching_ne(x, y, hitme, "team", team);
if (((scrFRInstanceExists(_frl_closeboy) && (distance_to_object(_frl_closeboy) < range)) && (collision_line(x, y, _frl_closeboy.x, _frl_closeboy.y, Wall, 0, 0) < 0))) {
{
var _frl_dir = undefined;
var _frl_spd = undefined;
var _frl_dif = undefined;
;
_frl_dir = point_direction(x, y, _frl_closeboy.x, _frl_closeboy.y);
;
_frl_spd = (((speed / timescale) * 5) * scrFRSourceScale());
_frl_dif = clamp(fr_Objects_Frontier_Projectiles2_mod_gml_angle_approach(direction, _frl_dir, (1 / turnspeed), scrFRSourceScale()), (- _frl_spd), _frl_spd);
direction -= _frl_dif;
;
image_angle -= _frl_dif;
}
}
}
}
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.fx_color;
;
image_xscale = (0.7 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_speed = (0.7) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1785
function fr_Objects_Frontier_Projectiles2_mod_gml_angle_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return (angle_difference(_frl_a, _frl_b) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Objects/Frontier_Projectiles2.mod.gml:1788
function fr_Objects_Frontier_Projectiles2_mod_gml_instance_nearest_matching_ne(_frl__x=undefined, _frl__y=undefined, _frl_obj=undefined, _frl_varname=undefined, _frl_value=undefined) {
var _frl_num = scrFRInstanceNumber(_frl_obj);
var _frl_man = instance_nearest(_frl__x, _frl__y, _frl_obj);
var _frl_mans = [];
var _frl_n = 0;
var _frl_found = (- 4);
;
if (scrFRInstanceExists(_frl_obj)) {
{
while (((((++ _frl_n) <= _frl_num) && (scrFRVariableGet(_frl_man, _frl_varname) == _frl_value)) || (scrFRInstanceIs(_frl_man, prop) && (! scrFRInstanceIs(_frl_man, BigGenerator))))) {
_frl_man.x += 10000;
array_push(_frl_mans, _frl_man);
_frl_man = instance_nearest(_frl__x, _frl__y, _frl_obj);
}
if (((scrFRVariableGet(_frl_man, _frl_varname) != _frl_value) && ((! scrFRInstanceIs(_frl_man, prop)) || scrFRInstanceIs(_frl_man, BigGenerator)))) {
_frl_found = _frl_man;
}
{ var __fr_with1 = scrFRWithValues(_frl_mans), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
x -= 10000;
}
if(__fr_break3) break;
}}
}
}
return _frl_found;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1805
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleThunderBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleThunderBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleThunderBulletHit;
;
spr_enter = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletEnter;
;
spr_exit = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletExit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprTeleBulletTrail;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
fx_color = make_color_rgb(168, 242, 251);
;
mask_index = mskBullet1;
;
speed = (12) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TEMPORAL THUNDER BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
teleporms = 2;
;
charge = scrFRSourceChoose(1, 1, 2);
;
on_anim = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_step;
;
on_hit = fr_Objects_Frontier_Projectiles2_mod_gml_TeleThunderBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_TeleThunderBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1843
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleThunderBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles2_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
}
}
}
}
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, damage, (knockback_speed / timescale));
;
if ((!scrFRVariableExists((scrFROther(other)), "thunder_charge"))) {
{
var __fr_other6=scrFROther(other);
__fr_other6.thunder_charge = 0;
}
}
var __fr_other7=scrFROther(other);
__fr_other7.thunder_charge += charge;
var _frl__team = team;
var _frl__c = creator;
;
var _frl_laserbrain = ceil(scrFRGetSkill(mut_laser_brain));
;
if (((scrFROther(other)).hp <= 0)) {
{
var _frl__charge = max((scrFROther(other)).thunder_charge, 5);
;
while ((_frl__charge > 0)) {
var _frl_r = min(((scrFRSourceIRandom(_frl__charge) + 1) + _frl_laserbrain), (12 + _frl_laserbrain));
;
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, Lightning)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
image_angle = scrFRSourceRandom(360);
direction = image_angle;
ammo = (_frl_r + 1);
creator = _frl__c;
team = _frl__team;
scrFRAlarmWrite(scrFRSelf(self), 0, (scrFRSourceIRandom(1) + 1), "=");
}
}
if(__fr_break10) break;
}}
_frl__charge -= max((_frl_r - _frl_laserbrain), 1);
}
var __fr_other11=scrFROther(other);
scrFRViewShakeAt(__fr_other11.x, __fr_other11.y, (__fr_other11.thunder_charge / 5));
var __fr_other12=scrFROther(other);
scrFRSoundPitchVolume(sndLightningCannonEnd, (1 + max((1 - (__fr_other12.thunder_charge / 30)), (- .8))), .4);
if (_frl_laserbrain) {
{
scrFRSoundPitchVolume(sndLightningPistolUpg, .8, .4);
}
}
}
}
if ((teleporms < 1)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
fr_Objects_Frontier_Projectiles2_mod_gml_TeleBullet_teleporm();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1904
function fr_Objects_Frontier_Projectiles2_mod_gml_TeleThunderBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), LightningHit);
}

// Original Objects/Frontier_Projectiles2.mod.gml:1912
function fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "mod:Frontier_Projectiles2"].settingGreenAugments ? global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoRocketSmall : global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoRocketSmall));
;
spr_trail = (global.fr_module_vars[$ "mod:Frontier_Projectiles2"].settingGreenAugments ? global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoRocketFlameSmall : global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoRocketFlameSmall);
;
image_angle = direction;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles2"].mskPopoRocketSmall;
;
speed = (10) * timescale;
;
typ = 1;
;
damage = 5;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "IDPD MICROMISSILE"];
;
on_step = fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_step;
;
on_destroy = fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1936
function fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "mod:Frontier_Projectiles2"].settingGreenAugments ? global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGreenPopoExplosionSmall : global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprPopoExplosionSmall));
;
mask_index = mskSmallExplosion;
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndExplosionS, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 0.8);
;
fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(sndIDPDNadeExplo, (0.7 + scrFRSourceRandomRange(0.8, 1.3)), 1.2);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1948
function fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_step() {
if (frMacro_Objects_Frontier_Projectiles2_mod_gml_current_frame_active) {
{
if (scrFRInstanceExists(enemy)) {
{
var _frl_myTarget = instance_nearest(x, y, enemy);
;
direction -= (angle_difference(direction, point_direction(x, y, _frl_myTarget.x, _frl_myTarget.y)) * power((0.1 * 2), 1));
;
image_angle = direction;
;
}
}
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 4), 4)), (y + scrFRSourceRandomRange((- 4), 4)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = __fr_other4.direction;
;
speed = (2) * timescale;
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1970
function fr_Objects_Frontier_Projectiles2_mod_gml_PopoRocketSmall_draw() {
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, 1, 1.2, image_angle, c_white, image_alpha);
;
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, (1.8 * image_xscale), (1.8 * image_yscale), image_angle, c_white, 0.2);
;
gpu_set_blendmode(bm_normal);
;
draw_self();
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1977
function fr_Objects_Frontier_Projectiles2_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles2"].sprGenericTrail);
;
mask_index = mskNone;
;
image_speed = (2) * timescale;
;
image_yscale = (1 / 50);
;
image_xscale = 1;
;
depth = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles2.mod.gml:1989
function fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
_frl__sound = scrFRSoundHit(_frl__sound, 1);
;
audio_sound_pitch(_frl__sound, _frl__pitch);
;
audio_sound_gain(_frl__sound, _frl__volume, 0);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:1994
function fr_Objects_Frontier_Projectiles2_mod_gml_sound_play_hit_big_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
_frl__sound = scrFRSoundHitBig(_frl__sound, 1);
;
audio_sound_pitch(_frl__sound, _frl__pitch);
;
audio_sound_gain(_frl__sound, _frl__volume, 0);
;
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
; // macro hoisted: alarm0_run
;
; // macro hoisted: alarm1_run
;
; // macro hoisted: alarm2_run
;
; // macro hoisted: alarm3_run
;
; // macro hoisted: alarm4_run
;
; // macro hoisted: alarm5_run
;
; // macro hoisted: alarm6_run
;
; // macro hoisted: alarm7_run
;
; // macro hoisted: alarm8_run
;
; // macro hoisted: alarm9_run
;
; // macro hoisted: instance_max
;
; // macro hoisted: bbox_center_x
;
; // macro hoisted: bbox_center_y
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:2014
function fr_Objects_Frontier_Projectiles2_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Projectiles2.mod.gml:2015
function fr_Objects_Frontier_Projectiles2_mod_gml_nothing() {

}

// Original Objects/Frontier_Projectiles2.mod.gml:2016
function fr_Objects_Frontier_Projectiles2_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}
