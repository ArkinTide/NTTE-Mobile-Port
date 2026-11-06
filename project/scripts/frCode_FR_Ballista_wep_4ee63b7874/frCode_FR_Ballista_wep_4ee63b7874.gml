// Original Weapons/FR_Ballista.wep.gml:1
function fr_Weapons_FR_Ballista_wep_gml___load() {

}

// Original Weapons/FR_Ballista.wep.gml:1
function fr_Weapons_FR_Ballista_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeapon = sprFR_sprBallista_413eb5cc93e2;
;
global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeaponLoaded = sprFR_sprBallistaLoaded_ad034c78aa57;
;
}

// Original Weapons/FR_Ballista.wep.gml:7
function fr_Weapons_FR_Ballista_wep_gml_weapon_name() {
return scrFRLocalize("BOOMLLISTA");
;
}

// Original Weapons/FR_Ballista.wep.gml:8
function fr_Weapons_FR_Ballista_wep_gml_weapon_text() {
return scrFRLocalize("THERES NO WAY THIS IS A GOOD IDEA");
;
}

// Original Weapons/FR_Ballista.wep.gml:9
function fr_Weapons_FR_Ballista_wep_gml_weapon_sprt(_frl__wep=undefined) {
return ((! is_struct(_frl__wep)) ? global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeapon : _frl__wep.sprt);
;
}

// Original Weapons/FR_Ballista.wep.gml:10
function fr_Weapons_FR_Ballista_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_Ballista.wep.gml:11
function fr_Weapons_FR_Ballista_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_Ballista.wep.gml:12
function fr_Weapons_FR_Ballista_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_Ballista", 10);
;
}

// Original Weapons/FR_Ballista.wep.gml:13
function fr_Weapons_FR_Ballista_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_Ballista.wep.gml:14
function fr_Weapons_FR_Ballista_wep_gml_weapon_load() {
return 30;
;
}

// Original Weapons/FR_Ballista.wep.gml:15
function fr_Weapons_FR_Ballista_wep_gml_weapon_cost() {
return 4;
;
}

// Original Weapons/FR_Ballista.wep.gml:16
function fr_Weapons_FR_Ballista_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_Ballista.wep.gml:17
function fr_Weapons_FR_Ballista_wep_gml_weapon_laser_sight() {
return false;
;
}

// Original Weapons/FR_Ballista.wep.gml:18
function fr_Weapons_FR_Ballista_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_Ballista.wep.gml:19
function fr_Weapons_FR_Ballista_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 3, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/FR_Ballista.wep.gml:21
function fr_Weapons_FR_Ballista_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndHeavyCrossbow, 1, (0.7 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndCrossbow, 1, (0.7 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "BallistaBolt_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (16) * timescale;
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
scrFRWeaponPost(8, 40, 2);
;
scrFRMotionAdd((gunangle + 180), 2);
_frl__wep.sprt = global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeapon;
;
}

// Original Weapons/FR_Ballista.wep.gml:46
function fr_Weapons_FR_Ballista_wep_gml_weapon_reloaded(_frl__active=undefined) {
var _frl__wep = (_frl__active ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_Ballista_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
_frl__wep.sprt = global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeaponLoaded;
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
scrFRSoundPitch(sndCrossReload, (0.7 + scrFRSourceRandom(0.1)));
scrFRWeaponPost((- 2), 0, 0);
}

// Original Weapons/FR_Ballista.wep.gml:62
function fr_Weapons_FR_Ballista_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_Ballista_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
}

// Original Weapons/FR_Ballista.wep.gml:69
function fr_Weapons_FR_Ballista_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "sprt": global.fr_module_vars[$ "weapon:FR_Ballista"].sprWeaponLoaded};
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
