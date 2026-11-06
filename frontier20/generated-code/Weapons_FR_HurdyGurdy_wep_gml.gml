// Original Weapons/FR_HurdyGurdy.wep.gml:1
function fr_Weapons_FR_HurdyGurdy_wep_gml___load() {

}

// Original Weapons/FR_HurdyGurdy.wep.gml:1
function fr_Weapons_FR_HurdyGurdy_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_HurdyGurdy"].sprWeapon = sprFR_sprHurdyGurdy_08676162544e;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:6
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_name() {
return scrFRLocalize("HURDY-GURDY");
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:7
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_text() {
return scrFRLocalize("CRANK THAT");
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:8
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_HurdyGurdy"].sprWeapon;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:9
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_type() {
return 0;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:10
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:11
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:12
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:13
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_load() {
return 26;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:14
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_cost() {
return 0;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:15
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_swap() {
return sndSwapSword;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:16
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_HurdyGurdy.wep.gml:17
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 2, "bhand": false};
}

// Original Weapons/FR_HurdyGurdy.wep.gml:19
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndGuitar, (0.9 + scrFRSourceRandom(0.3)), 0.75);
;
;
var _frl__disjoint = (0 + (15 * scrFRGetSkill(mut_long_arms)));
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(_frl__disjoint, gunangle)), (y + lengthdir_y(_frl__disjoint, gunangle)), FR_OBJECT_GUITAR_SLASH)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprHeavySlash);
;
speed = ((1.5 + (scrFRGetSkill(13) * 4))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.gunangle;
;
image_angle = direction;
;
damage = 28;
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
}

// Original Weapons/FR_HurdyGurdy.wep.gml:45
function fr_Weapons_FR_HurdyGurdy_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}
