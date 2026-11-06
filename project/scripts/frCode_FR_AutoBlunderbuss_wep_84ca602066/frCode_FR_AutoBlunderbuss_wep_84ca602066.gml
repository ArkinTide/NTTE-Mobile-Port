// Original Weapons/FR_AutoBlunderbuss.wep.gml:1
function fr_Weapons_FR_AutoBlunderbuss_wep_gml___load() {

}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:1
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_AutoBlunderbuss"].sprWeapon = sprFR_sprAutoBlunderbuss_e95311b9b71a;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:6
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_name() {
return scrFRLocalize("BLUNDUNDERBUSS");
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:7
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_text() {
return scrFRLocalize("G-G-G-G-GRAPES!");
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:8
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_AutoBlunderbuss"].sprWeapon;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:9
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:10
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:11
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalPirateWeps") == true) ? 10 : (- 1));
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:12
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:13
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_load() {
return 5;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:14
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_cost() {
return 1;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:15
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:16
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:17
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_handy_data() {
return {"x": 6, "y": 4, "bhand": true, "bx": 14, "by": 5};
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:19
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndFireShotgun, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndShotgun, 1, (1 + scrFRSourceRandom(0.2)));
;
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((10 + scrFRSourceRandom(6))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 19), 19) * __fr_other4.accuracy));
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
repeat (3) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((3 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 27), 27) * __fr_other10.accuracy));
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
depth = (- 3);
;
}
}
if(__fr_break9) break;
}}
}
scrFRWeaponPost(5, 6, 10);
;
}

// Original Weapons/FR_AutoBlunderbuss.wep.gml:52
function fr_Weapons_FR_AutoBlunderbuss_wep_gml_weapon_reloaded() {
wkick -= 3;
;
}
