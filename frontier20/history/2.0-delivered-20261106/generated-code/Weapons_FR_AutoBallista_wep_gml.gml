// Original Weapons/FR_AutoBallista.wep.gml:1
function fr_Weapons_FR_AutoBallista_wep_gml___load() {

}

// Original Weapons/FR_AutoBallista.wep.gml:1
function fr_Weapons_FR_AutoBallista_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_AutoBallista"].sprWeapon = sprFR_sprAutoBallista_83cc3b8580b8;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:6
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_name() {
return "ARBLAST";
;
}

// Original Weapons/FR_AutoBallista.wep.gml:7
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_text() {
return "FIREWALL";
;
}

// Original Weapons/FR_AutoBallista.wep.gml:8
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_AutoBallista"].sprWeapon;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:9
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:10
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:11
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_AutoBallista", 16);
;
}

// Original Weapons/FR_AutoBallista.wep.gml:12
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:13
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_load() {
return 20;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:14
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_burst() {
return 3;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:15
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_burst_time() {
return 3;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:16
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_cost() {
return 4;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:17
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:18
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_laser_sight() {
return false;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:19
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_AutoBallista.wep.gml:20
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 3, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/FR_AutoBallista.wep.gml:22
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndHeavyCrossbow, 1, (0.8 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndCrossbow, 1, (0.8 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "BallistaBolt_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (16) * timescale;
;
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
subCount = 2;
;
subSpread = (- 8);
;
}
}
if(__fr_break3) break;
}}
scrFRWeaponPost(6, 30, 1.5);
;
scrFRMotionAdd((gunangle + 180), 2);
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "WeaponBurst"), (scrFROther(other))) < 0)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
accuracy = __fr_other10.accuracy;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11;
;
var __fr_other12=scrFROther(other);
team = __fr_other12.team;
;
var __fr_other13=scrFROther(other);
spec = __fr_other13.specfiring;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", "FR_AutoBallista");
;
ammo = (fr_Weapons_FR_AutoBallista_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_FR_AutoBallista_wep_gml_weapon_burst_time();
;
time = time_max;
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Weapons/FR_AutoBallista.wep.gml:60
function fr_Weapons_FR_AutoBallista_wep_gml_weapon_reloaded() {
scrFRSoundPitch(sndCrossReload, (0.7 + scrFRSourceRandom(0.1)));
;
}
