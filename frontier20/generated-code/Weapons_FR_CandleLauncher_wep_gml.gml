// Original Weapons/FR_CandleLauncher.wep.gml:1
function fr_Weapons_FR_CandleLauncher_wep_gml___load() {

}

// Original Weapons/FR_CandleLauncher.wep.gml:1
function fr_Weapons_FR_CandleLauncher_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_CandleLauncher"].sprWeapon = sprFR_sprCandleLauncher_0286fa27e931;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:6
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_name() {
return scrFRLocalize("CANDLE LAUNCHER");
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:7
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_text() {
return scrFRLocalize("ROMAN WARFARE");
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:8
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_CandleLauncher"].sprWeapon;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:9
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_type() {
return 4;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:10
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:11
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_CandleLauncher", 7);
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:12
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:13
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_load() {
return 12;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:14
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:15
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_swap() {
return sndSwapExplosive;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:16
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_CandleLauncher.wep.gml:17
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 3, "bhand": true, "bx": 7, "by": 5};
}

// Original Weapons/FR_CandleLauncher.wep.gml:19
function fr_Weapons_FR_CandleLauncher_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitch(sndFireShotgun, (1.2 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "FireworkCandle_create", x, y)), __fr_break3=false;
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
}
}
if(__fr_break3) break;
}}
repeat (4) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((3 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 25), 25) * __fr_other10.accuracy));
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
}
}
if(__fr_break9) break;
}}
}
scrFRWeaponPost(6, 30, 1.5);
;
scrFRMotionAdd((gunangle + 180), 2);
}
