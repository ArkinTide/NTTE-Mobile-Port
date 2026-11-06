// Original Weapons/FR_DoubleBlunderbuss.wep.gml:1
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml___load() {

}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:1
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_DoubleBlunderbuss"].sprWeapon = sprFR_sprDoubleBlunderbuss_b5560af19324;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:6
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_name() {
return scrFRLocalize("BLUNDERBARREL");
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:7
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_text() {
return scrFRLocalize("YOU CAN'T MAKE WINE WITH THIS");
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:8
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_DoubleBlunderbuss"].sprWeapon;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:9
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:10
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:11
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_DoubleBlunderbuss", 8);
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:12
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:13
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_load() {
return 48;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:14
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_cost() {
return 4;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:15
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:16
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:17
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_handy_data() {
return {"x": 4, "y": 4, "bhand": true, "bx": 10, "by": 6};
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:19
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndFireShotgun, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndFlakCannon, 1, (1 + scrFRSourceRandom(0.2)));
;
repeat (36) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((9 + scrFRSourceRandom(6))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 24), 24) * __fr_other4.accuracy));
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
repeat (12) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((3 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 28), 28) * __fr_other10.accuracy));
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
scrFRWeaponPost(8, 10, 20);
;
scrFRMotionAdd((gunangle + 180), 2);
}

// Original Weapons/FR_DoubleBlunderbuss.wep.gml:54
function fr_Weapons_FR_DoubleBlunderbuss_wep_gml_weapon_reloaded() {
scrFRSoundPitchVolume(sndClick, (1.2 + scrFRSourceRandom(0.3)), 0.45);
;
wkick -= 3;
;
}
