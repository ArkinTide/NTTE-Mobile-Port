// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:1
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml___load() {

}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:1
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_init() {
global.fr_module_vars[$ "weapon:thunder enfilader"].sprWeapon = sprFR_sprThunderEnfilader_4cdd0bb4a200;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:6
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_name() {
return scrFRLocalize("THUNDER ENFILADER");
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:7
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_text() {
return scrFRLocalize("SHOCK VALUE");
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:8
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:thunder enfilader"].sprWeapon;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:9
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_type() {
return 1;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:10
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:11
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:12
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:13
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_load() {
return 26;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:14
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_burst() {
return 3;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:15
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_burst_time() {
return 2;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:16
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_cost() {
return 15;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:17
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:18
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:19
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 5, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/Iris Weapons/thunder enfilader.wep.gml:20
function fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndSawedOffShotgun, (1.1 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndHeavyMachinegun, (1.2 + scrFRSourceRandom(0.3)), 1);
;
scrFRSoundPitchVolume((scrFRGetSkill(mut_laser_brain) ? sndLightningCannonUpg : sndLightningCannon), (1.2 + scrFRSourceRandom(0.3)), 1);
;
scrFRSoundPitchVolume(sndQuadMachinegun, (1.2 + scrFRSourceRandom(0.3)), 0.6);
;
repeat (10) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "defpack tools", "create_lightning_bullet", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((9 + scrFRSourceRandomRange((- 3), 5))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 13), 13) * __fr_other4.accuracy));
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
}
scrFRWeaponPost(10, 10, 12);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (2) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
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
ammo = (fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_Iris_Weapons_thunder_enfilader_wep_gml_weapon_burst_time();
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
