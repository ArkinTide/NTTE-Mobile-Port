// Original Weapons/FR_GildedCoralCrossbow.wep.gml:1
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml___load() {

}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:1
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeapon = sprFR_sprGildedCoralCrossbow_b06e9691983f;
;
global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeaponLoaded = sprFR_sprGildedCoralCrossbowLo_a12df3f5b411;
;
global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprCoralReload = sprFR_sprCoralReload_25bb96f63616;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:8
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_name() {
return "BLEACHED CORAL CROSSBOW";
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:9
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_text() {
return "I THOUGHT IT'D BE GOLD TOO";
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:10
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_sprt(_frl__wep=undefined) {
return ((! is_struct(_frl__wep)) ? global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeapon : _frl__wep.sprt);
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:11
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:12
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:13
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_area() {
return (- 1);
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:14
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:15
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_load() {
return 28;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:16
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_cost() {
return 3;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:17
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:18
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:19
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 3, "bhand": true, "bx": 9, "by": 4};
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:21
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndCrossbow, 1, (0.7 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitchVolume(sndPlantFire, (1.2 + scrFRSourceRandom(0.2)), 0.7);
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "CoralBolt_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
coralColor = make_color_rgb(208, 207, 191);
;
image_blend = coralColor;
;
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
_frl__wep.sprt = global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeapon;
;
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:49
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_weapon_reloaded(_frl__active=undefined) {
var _frl__wep = (_frl__active ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_GildedCoralCrossbow_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
_frl__wep.sprt = global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeaponLoaded;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, gunangle)), (y + lengthdir_y(10, gunangle)), ThrowHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.5;
;
image_yscale = 0.5;
;
depth = (- 3);
;
}
}
if(__fr_break3) break;
}}
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprCoralReload);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
image_blend = make_color_rgb(208, 207, 191);
;
var __fr_other7=scrFROther(other);
direction = ((__fr_other7.gunangle + 180) + scrFRSourceRandomRange((- 55), 55));
;
image_angle = scrFRSourceRandom(360);
;
var __fr_other8=scrFROther(other);
depth = (__fr_other8.depth - 1);
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitchVolume(sndPillarBreak, (1.4 + scrFRSourceRandom(0.4)), 0.4);
;
scrFRSoundPitch(sndCrossReload, (0.8 + scrFRSourceRandom(0.1)));
scrFRWeaponPost((- 2), 0, 0);
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:78
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_GildedCoralCrossbow_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
}

// Original Weapons/FR_GildedCoralCrossbow.wep.gml:85
function fr_Weapons_FR_GildedCoralCrossbow_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "sprt": global.fr_module_vars[$ "weapon:FR_GildedCoralCrossbow"].sprWeaponLoaded};
;
if ((scrFRVariableExists(_frl__creator, "wep") && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(_frl__creator, "wep"), scrFRWeaponSlotRead(_frl__wep, "wep")))) {
{
scrFRWeaponSlotWrite(_frl__creator, "wep", _frl__wep);
;
}
}
if ((scrFRVariableExists(_frl__creator, "bwep") && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(_frl__creator, "bwep"), scrFRWeaponSlotRead(_frl__wep, "wep")))) {
{
scrFRWeaponSlotWrite(_frl__creator, "bwep", scrFRLQClone(_frl__wep));
;
}
}
}
