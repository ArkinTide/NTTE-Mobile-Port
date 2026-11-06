// Original Weapons/FR_HiveLauncher.wep.gml:1
function fr_Weapons_FR_HiveLauncher_wep_gml___load() {

}

// Original Weapons/FR_HiveLauncher.wep.gml:1
function fr_Weapons_FR_HiveLauncher_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_HiveLauncher"].sprWeapon = sprFR_sprHiveLauncher_e610c7db2a1e;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:6
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_name() {
return scrFRLocalize("HIVE LAUNCHER");
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:7
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_text() {
return scrFRLocalize("OUGH! BUGS!");
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:8
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_HiveLauncher"].sprWeapon;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:9
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_type() {
return 4;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:10
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:11
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") == true) ? 21 : (- 1));
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:12
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:13
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_load() {
return 32;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:14
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_cost() {
return 5;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:15
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:16
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_HiveLauncher.wep.gml:17
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 5, "bhand": true, "bx": 10, "by": 6};
}

// Original Weapons/FR_HiveLauncher.wep.gml:19
function fr_Weapons_FR_HiveLauncher_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndSuperBazooka, (0.9 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndHeavyMachinegun, (1.2 + scrFRSourceRandom(0.3)), 1);
;
scrFRSoundPitchVolume(sndRocketFly, (0.7 + scrFRSourceRandom(0.2)), 1);
;
{
var _frl_i = (- 14);
for (; (_frl_i <= 14); _frl_i += 14) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "HiveRocket_create", (x + lengthdir_x(10, gunangle)), (y + lengthdir_y(10, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (_frl_i * __fr_other4.accuracy));
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRWeaponPost(10, 30, 20);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (6) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
direction = (__fr_other8.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}
