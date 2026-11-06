// Original Weapons/FR_BubblesShovel.wep.gml:1
function fr_Weapons_FR_BubblesShovel_wep_gml___load() {

}

// Original Weapons/FR_BubblesShovel.wep.gml:1
function fr_Weapons_FR_BubblesShovel_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeapon = sprFR_sprBubblesShovel_fa9ee181292e;
;
global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeaponHud = sprFR_sprBubblesShovelHud_f2f44f15a890;
;
global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeaponArt = sprFR_sprBubblesShovelLoadout_b0d98bdf1533;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:8
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_name() {
return scrFRLocalize("HOARDER SHOVEL");
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:9
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_text() {
return scrFRLocalize("24 KARAT");
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:10
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeapon;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:11
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_sprt_hud() {
return global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeaponHud;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:12
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_loadout() {
return global.fr_module_vars[$ "weapon:FR_BubblesShovel"].sprWeaponArt;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:13
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_type() {
return 0;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:14
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:15
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:16
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:17
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_load() {
return 22;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:18
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_cost() {
return 0;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:19
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_swap() {
return sndSwapSword;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:21
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_BubblesShovel.wep.gml:22
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 1, "bhand": true, "bx": 11, "by": 1};
}

// Original Weapons/FR_BubblesShovel.wep.gml:24
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndShovel, (0.9 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndGoldScrewdriver, (0.8 + scrFRSourceRandom(0.2)), 1);
;
var _frl__disjoint = (0 + (15 * scrFRGetSkill(mut_long_arms)));
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(_frl__disjoint, gunangle)), (y + lengthdir_y(_frl__disjoint, gunangle)), Slash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((1.5 + (scrFRGetSkill(13) * 4))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.gunangle;
;
image_angle = direction;
;
damage = 9;
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

// Original Weapons/FR_BubblesShovel.wep.gml:51
function fr_Weapons_FR_BubblesShovel_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}
