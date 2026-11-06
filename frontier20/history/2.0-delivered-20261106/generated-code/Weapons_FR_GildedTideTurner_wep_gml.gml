// Original Weapons/FR_GildedTideTurner.wep.gml:1
function fr_Weapons_FR_GildedTideTurner_wep_gml___load() {

}

// Original Weapons/FR_GildedTideTurner.wep.gml:1
function fr_Weapons_FR_GildedTideTurner_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_GildedTideTurner"].sprWeapon = sprFR_sprGildedTideTurner_a910c4b3ccda;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:6
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_name() {
return "SHORES OF GOLD";
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:7
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_text() {
return "THE GOLDEN COAST";
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:8
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_GildedTideTurner"].sprWeapon;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:9
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:10
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:11
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:12
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:13
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_load() {
return 12;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:14
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_cost() {
return 1;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:15
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_swap() {
return sndSwapSword;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:16
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_laser_sight() {
return false;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:17
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:18
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_handy_data() {
return {"x": 0, "y": 1, "bhand": false};
}

// Original Weapons/FR_GildedTideTurner.wep.gml:20
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndHammer, scrFRSourceRandomRange(0.9, 1.2), 1);
;
scrFRSoundPitchVolume(sndGoldWrench, scrFRSourceRandomRange(1.1, 1.3), 0.75);
;
scrFRSoundPitchVolume(sndOasisExplosionSmall, scrFRSourceRandomRange(1.1, 1.4), 0.6);
;
var _frl__disjoint = (0 + (15 * scrFRGetSkill(mut_long_arms)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "TideSlash_create", (x + lengthdir_x(_frl__disjoint, gunangle)), (y + lengthdir_y(_frl__disjoint, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((2 + (scrFRGetSkill(13) * 3.5))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.gunangle;
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
wepangle = (- wepangle);
;
scrFRWeaponPost((- 4), 8, 3);
;
scrFRMotionAdd(gunangle, 3.5);
;
scrFRInstanceCreate(x, y, Dust);
;
}

// Original Weapons/FR_GildedTideTurner.wep.gml:47
function fr_Weapons_FR_GildedTideTurner_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}
