// Original Weapons/FR_StarRifle.wep.gml:1
function fr_Weapons_FR_StarRifle_wep_gml___load() {

}

// Original Weapons/FR_StarRifle.wep.gml:1
function fr_Weapons_FR_StarRifle_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_StarRifle"].sprWeapon = sprFR_sprStarlightRifle_bb7be085950e;
;
}

// Original Weapons/FR_StarRifle.wep.gml:6
function fr_Weapons_FR_StarRifle_wep_gml_weapon_name() {
return "URSA MINOR";
;
}

// Original Weapons/FR_StarRifle.wep.gml:7
function fr_Weapons_FR_StarRifle_wep_gml_weapon_text() {
return "STARLIGHT FIGHTS";
;
}

// Original Weapons/FR_StarRifle.wep.gml:8
function fr_Weapons_FR_StarRifle_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_StarRifle"].sprWeapon;
;
}

// Original Weapons/FR_StarRifle.wep.gml:9
function fr_Weapons_FR_StarRifle_wep_gml_weapon_type() {
return 5;
;
}

// Original Weapons/FR_StarRifle.wep.gml:10
function fr_Weapons_FR_StarRifle_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_StarRifle.wep.gml:11
function fr_Weapons_FR_StarRifle_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_StarRifle", 11);
;
}

// Original Weapons/FR_StarRifle.wep.gml:12
function fr_Weapons_FR_StarRifle_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_StarRifle.wep.gml:13
function fr_Weapons_FR_StarRifle_wep_gml_weapon_load() {
return 15;
;
}

// Original Weapons/FR_StarRifle.wep.gml:14
function fr_Weapons_FR_StarRifle_wep_gml_weapon_cost() {
return 5;
;
}

// Original Weapons/FR_StarRifle.wep.gml:15
function fr_Weapons_FR_StarRifle_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_StarRifle.wep.gml:16
function fr_Weapons_FR_StarRifle_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_StarRifle.wep.gml:17
function fr_Weapons_FR_StarRifle_wep_gml_weapon_handy_data() {
return {"x": 4, "y": 5, "bhand": true, "bx": 10, "by": 6};
}

// Original Weapons/FR_StarRifle.wep.gml:19
function fr_Weapons_FR_StarRifle_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
if ((scrFRGetSkill(mut_laser_brain) > 0)) {
{
scrFRSoundPitch(sndSwapGold, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosion, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndEnergyHammer, (1.2 + scrFRSourceRandom(0.2)));
;
}
} else {
{
scrFRSoundPitch(sndSwapGold, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosionS, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndEnergyHammer, (1.2 + scrFRSourceRandom(0.2)));
;
}
}
var _frl__spd = 0;
;
repeat (8) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "StarBullet_create", (x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((10 + _frl__spd)) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 3), 3) * __fr_other4.accuracy));
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6;
;
}
}
if(__fr_break3) break;
}}
_frl__spd += 1;
;
}
repeat (12) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "StarBulletTrail_create", (x + lengthdir_x(8, gunangle)), (y + lengthdir_y(8, gunangle)))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 24), 24) * __fr_other10.accuracy));
;
image_angle = direction;
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
depth = (- 3);
;
}
}
if(__fr_break9) break;
}}
}
scrFRWeaponPost(3, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
}
