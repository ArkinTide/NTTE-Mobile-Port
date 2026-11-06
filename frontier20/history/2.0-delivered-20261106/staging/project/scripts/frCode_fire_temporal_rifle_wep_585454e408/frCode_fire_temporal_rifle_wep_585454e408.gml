// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:1
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml___load() {

}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:1
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_init() {
global.fr_module_vars[$ "weapon:fire temporal rifle"].sprWeapon = sprFR_sprFireTemporalRifle_7cb32abaf6ab;
;
global.fr_module_vars[$ "weapon:fire temporal rifle"].sprTemporalShell = sprFR_sprTemporalFireShell_78173a8a6968;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:7
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_name() {
return "TEMPORAL FIRE RIFLE";
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:8
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_text() {
return "BLAST FROM THE PAST";
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:9
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:fire temporal rifle"].sprWeapon;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:10
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_type() {
return 1;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:11
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:12
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:13
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:14
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_load() {
return 3;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:15
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_burst() {
return 2;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:16
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_burst_time() {
return 1;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:17
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_cost() {
return 3;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:18
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:19
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:20
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_handy_data() {
return {"x": 4, "y": 4, "bhand": true, "bx": 14, "by": 4};
}

// Original Weapons/Iris Weapons/fire temporal rifle.wep.gml:22
function fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndOasisShoot, (0.5 + scrFRSourceRandom(0.4)), 0.4);
;
scrFRSoundPitchVolume(sndMachinegun, (1.8 + scrFRSourceRandom(0.4)), 0.4);
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "TeleFireBullet_create", (x + lengthdir_x(8, gunangle)), (y + lengthdir_y(8, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 20), 20) * __fr_other4.accuracy));
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
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:fire temporal rifle"].sprTemporalShell);
;
var __fr_other10=scrFROther(other);
scrFRMotionAdd(((__fr_other10.gunangle + (__fr_other10.right * 90)) + scrFRSourceRandomRange((- 40), 40)), (2 + scrFRSourceRandom(3)));
;
}
}
if(__fr_break9) break;
}}
scrFRWeaponPost(6, 4, 3);
;
scrFRMotionAdd((gunangle + 180), 0.5);
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "WeaponBurst"), (scrFROther(other))) < 0)) {
{
{ var __fr_with11 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
accuracy = __fr_other14.accuracy;
;
var __fr_other15=scrFROther(other);
creator = __fr_other15;
;
var __fr_other16=scrFROther(other);
team = __fr_other16.team;
;
var __fr_other17=scrFROther(other);
spec = __fr_other17.specfiring;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
ammo = (fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_Iris_Weapons_fire_temporal_rifle_wep_gml_weapon_burst_time();
;
time = time_max;
;
}
}
if(__fr_break13) break;
}}
}
}
}
