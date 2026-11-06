// Original Weapons/FR_RogueBlunderbuss.wep.gml:1
function fr_Weapons_FR_RogueBlunderbuss_wep_gml___load() {

}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:1
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_RogueBlunderbuss"].sprWeapon = sprFR_sprRogueBlunderbuss_3e34bf726287;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:6
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_name() {
return "MUTINEER BLUNDERBUSS";
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:7
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_text() {
return "MUTANTNEER!!";
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:8
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_RogueBlunderbuss"].sprWeapon;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:9
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:10
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:11
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:12
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:13
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_load() {
return 24;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:14
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:15
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:16
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:17
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_handy_data() {
return {"x": 6, "y": 4, "bhand": true, "bx": 12, "by": 4};
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:19
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndRogueRifle, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndDoubleShotgun, 1, (1 + scrFRSourceRandom(0.2)));
;
repeat (14) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "PopoGrapeshot_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((12 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 13), 13) * __fr_other4.accuracy));
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
repeat (8) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((3 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 22), 22) * __fr_other10.accuracy));
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
scrFRWeaponPost(8, 6, 10);
;
scrFRMotionAdd((gunangle + 180), 2);
}

// Original Weapons/FR_RogueBlunderbuss.wep.gml:53
function fr_Weapons_FR_RogueBlunderbuss_wep_gml_weapon_reloaded() {
scrFRSoundPitchVolume(sndClick, (1.2 + scrFRSourceRandom(0.3)), 0.45);
;
wkick -= 3;
;
}
