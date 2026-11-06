// Original Weapons/FR_CandleBarrage.wep.gml:1
function fr_Weapons_FR_CandleBarrage_wep_gml___load() {

}

// Original Weapons/FR_CandleBarrage.wep.gml:1
function fr_Weapons_FR_CandleBarrage_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_CandleBarrage"].sprWeapon = sprFR_sprCandleBarrage_7ad32d1f742c;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:6
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_name() {
return "CANDLE BARRAGE";
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:7
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_text() {
return "CATASTROPHIC COLORS";
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:8
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_CandleBarrage"].sprWeapon;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:9
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_type() {
return 4;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:10
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:11
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_CandleBarrage", 13);
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:12
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:13
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_load() {
return 12;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:14
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_burst() {
return 3;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:15
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_burst_time() {
return 4;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:16
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:17
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_swap() {
return sndSwapExplosive;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:18
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_CandleBarrage.wep.gml:19
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 3, "bhand": true, "bx": 8, "by": 5};
}

// Original Weapons/FR_CandleBarrage.wep.gml:21
function fr_Weapons_FR_CandleBarrage_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitch(sndFireShotgun, (1.3 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "FireworkCandle_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((15 + scrFRSourceRandom(3))) * timescale;
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
repeat (3) {
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((3 + scrFRSourceRandom(6))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 50), 50) * __fr_other10.accuracy));
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
scrFRWeaponPost(6, 12, 0.8);
;
scrFRMotionAdd((gunangle + 180), 2);
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "WeaponBurst"), (scrFROther(other))) < 0)) {
{
{ var __fr_with13 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WeaponBurst_create", x, y)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var __fr_other16=scrFROther(other);
accuracy = __fr_other16.accuracy;
;
var __fr_other17=scrFROther(other);
creator = __fr_other17;
;
var __fr_other18=scrFROther(other);
team = __fr_other18.team;
;
var __fr_other19=scrFROther(other);
spec = __fr_other19.specfiring;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
ammo = (fr_Weapons_FR_CandleBarrage_wep_gml_weapon_burst() - 1);
;
time_max = fr_Weapons_FR_CandleBarrage_wep_gml_weapon_burst_time();
;
time = time_max;
;
}
}
if(__fr_break15) break;
}}
}
}
}
