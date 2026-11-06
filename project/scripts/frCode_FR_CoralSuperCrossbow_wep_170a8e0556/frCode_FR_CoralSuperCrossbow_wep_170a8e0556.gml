// Original Weapons/FR_CoralSuperCrossbow.wep.gml:1
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml___load() {

}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:1
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_CoralSuperCrossbow"].sprWeapon = sprFR_sprCoralSuperCrossbow_e9a3f0934fc0;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:6
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_name() {
return scrFRLocalize("REEFSEEDER");
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:7
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_text() {
return scrFRLocalize("A LITTLE LATE FOR THAT");
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:8
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_CoralSuperCrossbow"].sprWeapon;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:9
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:10
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:11
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_CoralSuperCrossbow", 14);
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:12
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:13
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_load() {
return 38;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:14
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_cost() {
return 7;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:15
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:16
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_laser_sight() {
return 0;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:17
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:18
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 5, "bhand": true, "bx": 9, "by": 4};
}

// Original Weapons/FR_CoralSuperCrossbow.wep.gml:20
function fr_Weapons_FR_CoralSuperCrossbow_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndCrossbow, 1, (0.5 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndGrenadeRifle, (1.3 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitchVolume(sndPlantSnare, (1.2 + scrFRSourceRandom(0.2)), 0.7);
;
var _frl__spread = ((- 8) * accuracy);
var _frl__angle = gunangle;
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "CoralBolt_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = coralColor;
;
direction = (_frl__angle + _frl__spread);
;
image_angle = direction;
;
var __fr_other4=scrFROther(other);
_frl__spread += (8 * __fr_other4.accuracy);
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
