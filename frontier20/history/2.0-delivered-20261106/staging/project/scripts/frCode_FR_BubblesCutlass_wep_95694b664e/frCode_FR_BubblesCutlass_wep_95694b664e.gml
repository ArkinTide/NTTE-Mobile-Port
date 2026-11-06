// Original Weapons/FR_BubblesCutlass.wep.gml:1
function fr_Weapons_FR_BubblesCutlass_wep_gml___load() {

}

// Original Weapons/FR_BubblesCutlass.wep.gml:1
function fr_Weapons_FR_BubblesCutlass_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeapon = sprFR_sprBubblesCutlass_6da3559d6ebb;
;
global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeaponHud = sprFR_sprBubblesCutlassHud_eff955e85d9f;
;
global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeaponArt = sprFR_sprBubblesCutlassLoadout_a3f9cae1b4d8;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:8
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_name() {
return "PLASTIC CUTLASS";
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:9
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_text() {
return "NON-BIODEGRADABLE";
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:10
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeapon;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:11
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_sprt_hud() {
return global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeaponHud;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:12
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_loadout() {
return global.fr_module_vars[$ "weapon:FR_BubblesCutlass"].sprWeaponArt;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:13
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_type() {
return 0;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:14
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:15
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:16
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:17
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_load() {
return 14;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:18
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_cost() {
return 0;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:19
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_swap() {
return sndSwapSword;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:21
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_BubblesCutlass.wep.gml:22
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 2, "bhand": false};
}

// Original Weapons/FR_BubblesCutlass.wep.gml:24
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndChickenSword, scrFRSourceRandomRange(0.9, 1.2), 1);
;
scrFRSoundPitchVolume(sndWrench, scrFRSourceRandomRange(1.1, 1.3), 0.75);
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
damage = 6;
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

// Original Weapons/FR_BubblesCutlass.wep.gml:51
function fr_Weapons_FR_BubblesCutlass_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}
