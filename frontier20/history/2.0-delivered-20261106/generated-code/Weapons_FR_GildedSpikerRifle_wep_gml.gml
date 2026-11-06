// Original Weapons/FR_GildedSpikerRifle.wep.gml:1
function fr_Weapons_FR_GildedSpikerRifle_wep_gml___load() {

}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:1
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_GildedSpikerRifle"].sprWeapon = sprFR_sprGildedSpikerRifle_70466cbdfc69;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:6
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_name() {
return "GILDED SPIKER";
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:7
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_text() {
return "PUT A SHINY!! PIN IN IT";
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:8
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_GildedSpikerRifle"].sprWeapon;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:9
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:10
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:11
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:12
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:13
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_load() {
return 17;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:14
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_burst() {
return 7;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:15
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_burst_time() {
return 2;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:16
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:17
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:18
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:19
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_handy_data() {
return {"x": 4, "y": 4, "bhand": false};
}

// Original Weapons/FR_GildedSpikerRifle.wep.gml:21
function fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndGoldCrossbow, (1.2 + scrFRSourceRandom(0.2)), 1);
;
scrFRSoundPitchVolume(sndDiscgun, (1.2 + scrFRSourceRandom(0.2)), 1);
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GoldSpikerSplinter_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 8), 8) * __fr_other4.accuracy));
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
scrFRWeaponPost(3, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
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
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
ammo = (fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_FR_GildedSpikerRifle_wep_gml_weapon_burst_time();
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
