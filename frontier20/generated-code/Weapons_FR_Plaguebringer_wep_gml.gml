// Original Weapons/FR_Plaguebringer.wep.gml:1
function fr_Weapons_FR_Plaguebringer_wep_gml___load() {

}

// Original Weapons/FR_Plaguebringer.wep.gml:1
function fr_Weapons_FR_Plaguebringer_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_Plaguebringer"].sprWeapon = sprFR_sprPlaguebringer_1c22417859b1;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:6
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_name() {
return scrFRLocalize("PLAGUEBRINGER");
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:7
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_text() {
return scrFRLocalize("DON'T STAND TOO CLOSE");
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:8
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_Plaguebringer"].sprWeapon;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:9
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:10
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:11
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") == true) ? 21 : (- 1));
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:12
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:13
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_load() {
return 55;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:14
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_cost() {
return 5;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:15
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:17
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_Plaguebringer.wep.gml:18
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_handy_data() {
return {"x": 0, "y": 2, "bhand": true, "bx": 8, "by": 7};
}

// Original Weapons/FR_Plaguebringer.wep.gml:20
function fr_Weapons_FR_Plaguebringer_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndSuperCrossbow, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndToxicLauncher, 1, (1 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "PlagueBolt_create", x, y)), __fr_break3=false;
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
scrFRWeaponPost(8, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
}
