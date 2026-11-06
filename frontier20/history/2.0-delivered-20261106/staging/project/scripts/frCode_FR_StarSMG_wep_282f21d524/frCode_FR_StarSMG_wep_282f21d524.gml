// Original Weapons/FR_StarSMG.wep.gml:1
function fr_Weapons_FR_StarSMG_wep_gml___load() {

}

// Original Weapons/FR_StarSMG.wep.gml:1
function fr_Weapons_FR_StarSMG_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_StarSMG"].sprWeapon = sprFR_sprStarlightSMG_cc7412b39cb4;
;
}

// Original Weapons/FR_StarSMG.wep.gml:6
function fr_Weapons_FR_StarSMG_wep_gml_weapon_name() {
return "URSA MAJOR";
;
}

// Original Weapons/FR_StarSMG.wep.gml:7
function fr_Weapons_FR_StarSMG_wep_gml_weapon_text() {
return "CONSTELLATIONS";
;
}

// Original Weapons/FR_StarSMG.wep.gml:8
function fr_Weapons_FR_StarSMG_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_StarSMG"].sprWeapon;
;
}

// Original Weapons/FR_StarSMG.wep.gml:9
function fr_Weapons_FR_StarSMG_wep_gml_weapon_type() {
return 5;
;
}

// Original Weapons/FR_StarSMG.wep.gml:10
function fr_Weapons_FR_StarSMG_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_StarSMG.wep.gml:11
function fr_Weapons_FR_StarSMG_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_StarSMG", 14);
;
}

// Original Weapons/FR_StarSMG.wep.gml:12
function fr_Weapons_FR_StarSMG_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_StarSMG.wep.gml:13
function fr_Weapons_FR_StarSMG_wep_gml_weapon_load() {
return 10;
;
}

// Original Weapons/FR_StarSMG.wep.gml:14
function fr_Weapons_FR_StarSMG_wep_gml_weapon_burst() {
return 5;
;
}

// Original Weapons/FR_StarSMG.wep.gml:15
function fr_Weapons_FR_StarSMG_wep_gml_weapon_burst_time() {
return 2;
;
}

// Original Weapons/FR_StarSMG.wep.gml:16
function fr_Weapons_FR_StarSMG_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_StarSMG.wep.gml:17
function fr_Weapons_FR_StarSMG_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_StarSMG.wep.gml:18
function fr_Weapons_FR_StarSMG_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_StarSMG.wep.gml:19
function fr_Weapons_FR_StarSMG_wep_gml_weapon_handy_data() {
return {"x": 8, "y": 7, "bhand": true, "bx": 14, "by": 7};
}

// Original Weapons/FR_StarSMG.wep.gml:21
function fr_Weapons_FR_StarSMG_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
if ((scrFRGetSkill(mut_laser_brain) > 0)) {
{
scrFRSoundPitch(sndSwapGold, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndEnergyScrewdriverUpg, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitchVolume(sndEnergySword, (1.3 + scrFRSourceRandom(0.2)), 0.6);
;
}
} else {
{
scrFRSoundPitch(sndSwapGold, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndEnergyScrewdriverUpg, (1.2 + scrFRSourceRandom(0.2)));
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "StarBullet_create", (x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 6), 6) * __fr_other4.accuracy));
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
repeat (2) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "StarBulletTrail_create", (x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)))), __fr_break9=false;
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
scrFRMotionAdd((gunangle + 180), 0.8);
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "WeaponBurst"), (scrFROther(other))) < 0)) {
{
{ var __fr_with13 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var __fr_other16=scrFROther(other);
accuracy = __fr_other16.accuracy;
;
var __fr_other17=scrFROther(other);
creator = __fr_other17;
;
var __fr_other18=scrFROther(other);
team = __fr_other18.team;
;
var __fr_other19=scrFROther(other);
spec = __fr_other19.specfiring;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
ammo = (fr_Weapons_FR_StarSMG_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_FR_StarSMG_wep_gml_weapon_burst_time();
;
time = time_max;
;
}
}
if(__fr_break15) break;
}}
}
}
}
