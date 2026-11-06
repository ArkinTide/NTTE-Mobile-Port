// Original Weapons/FR_DevWep.wep.gml:1
function fr_Weapons_FR_DevWep_wep_gml___load() {

}

// Original Weapons/FR_DevWep.wep.gml:1
function fr_Weapons_FR_DevWep_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_DevWep"].sprWeapon = sprFR_sprTempGun_d9cb7e0bfd1e;
;
}

// Original Weapons/FR_DevWep.wep.gml:6
function fr_Weapons_FR_DevWep_wep_gml_weapon_name() {
return "YOU SHOULDNT HAVE THIS";
;
}

// Original Weapons/FR_DevWep.wep.gml:7
function fr_Weapons_FR_DevWep_wep_gml_weapon_text() {
return "IDK";
;
}

// Original Weapons/FR_DevWep.wep.gml:8
function fr_Weapons_FR_DevWep_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_DevWep"].sprWeapon;
;
}

// Original Weapons/FR_DevWep.wep.gml:9
function fr_Weapons_FR_DevWep_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_DevWep.wep.gml:10
function fr_Weapons_FR_DevWep_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_DevWep.wep.gml:11
function fr_Weapons_FR_DevWep_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_DevWep.wep.gml:12
function fr_Weapons_FR_DevWep_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_DevWep.wep.gml:13
function fr_Weapons_FR_DevWep_wep_gml_weapon_load() {
return 20;
;
}

// Original Weapons/FR_DevWep.wep.gml:14
function fr_Weapons_FR_DevWep_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_DevWep.wep.gml:15
function fr_Weapons_FR_DevWep_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_DevWep.wep.gml:17
function fr_Weapons_FR_DevWep_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndPistol, 1, (1 + scrFRSourceRandom(0.2)));
;
repeat (1) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Pufferbomb_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 1), 1) * __fr_other4.accuracy));
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
}
scrFRWeaponPost(8, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
}
