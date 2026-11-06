// Original Weapons/FR_PowderPopper.wep.gml:1
function fr_Weapons_FR_PowderPopper_wep_gml___load() {

}

// Original Weapons/FR_PowderPopper.wep.gml:1
function fr_Weapons_FR_PowderPopper_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprWeapon = sprFR_sprPowderPopper_46838811aa69;
;
global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprGunpowderShellSmall = sprFR_sprGunpowderShellSmall_a60a8db54305;
;
global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprGunpowderShell = sprFR_sprGunpowderShell_082772075542;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:8
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_name() {
return "POWDER POPPER";
;
}

// Original Weapons/FR_PowderPopper.wep.gml:9
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_text() {
return "POP AND SIZZLE";
;
}

// Original Weapons/FR_PowderPopper.wep.gml:10
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprWeapon;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:11
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:12
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:13
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_PowderPopper", 9);
;
}

// Original Weapons/FR_PowderPopper.wep.gml:14
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:15
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_load() {
return 7;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:16
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_burst() {
return 4;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:17
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_burst_time() {
return 2;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:18
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:19
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:20
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_PowderPopper.wep.gml:21
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 4, "bhand": true, "bx": 10, "by": 3};
}

// Original Weapons/FR_PowderPopper.wep.gml:23
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndFireShotgun, (1.5 + scrFRSourceRandom(0.2)), 0.6);
;
scrFRSoundGun(sndPopgun, 1, (0.8 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GunpowderShell_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((11 + scrFRSourceRandom(5))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 15), 15) * __fr_other4.accuracy));
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
scrFRWeaponPost(5, 5, 8);
;
scrFRMotionAdd((gunangle + 180), 1);
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "WeaponBurst"), (scrFROther(other))) < 0)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
accuracy = __fr_other10.accuracy;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11;
;
var __fr_other12=scrFROther(other);
team = __fr_other12.team;
;
var __fr_other13=scrFROther(other);
spec = __fr_other13.specfiring;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
ammo = (fr_Weapons_FR_PowderPopper_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_FR_PowderPopper_wep_gml_weapon_burst_time();
;
time = time_max;
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Weapons/FR_PowderPopper.wep.gml:61
function fr_Weapons_FR_PowderPopper_wep_gml_weapon_reloaded() {
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((scrFRGetSkill(mut_shotgun_shoulders) ? global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprGunpowderShell : global.fr_module_vars[$ "weapon:FR_PowderPopper"].sprGunpowderShellSmall));
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.gunangle + (__fr_other4.right * 90)) + scrFRSourceRandomRange((- 40), 40)), (2 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
}
