// Original Weapons/FR_Blunderball.wep.gml:1
function fr_Weapons_FR_Blunderball_wep_gml___load() {

}

// Original Weapons/FR_Blunderball.wep.gml:1
function fr_Weapons_FR_Blunderball_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_Blunderball"].sprWeapon = sprFR_sprBlunderballCannon_bc3379ffa405;
;
}

// Original Weapons/FR_Blunderball.wep.gml:6
function fr_Weapons_FR_Blunderball_wep_gml_weapon_name() {
return "BLUNDERBALL CANNON";
;
}

// Original Weapons/FR_Blunderball.wep.gml:7
function fr_Weapons_FR_Blunderball_wep_gml_weapon_text() {
return "BALLIN";
;
}

// Original Weapons/FR_Blunderball.wep.gml:8
function fr_Weapons_FR_Blunderball_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_Blunderball"].sprWeapon;
;
}

// Original Weapons/FR_Blunderball.wep.gml:9
function fr_Weapons_FR_Blunderball_wep_gml_weapon_type() {
return 4;
;
}

// Original Weapons/FR_Blunderball.wep.gml:10
function fr_Weapons_FR_Blunderball_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_Blunderball.wep.gml:11
function fr_Weapons_FR_Blunderball_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_Blunderball", 8);
;
}

// Original Weapons/FR_Blunderball.wep.gml:12
function fr_Weapons_FR_Blunderball_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_Blunderball.wep.gml:13
function fr_Weapons_FR_Blunderball_wep_gml_weapon_load() {
return 26;
;
}

// Original Weapons/FR_Blunderball.wep.gml:14
function fr_Weapons_FR_Blunderball_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_Blunderball.wep.gml:15
function fr_Weapons_FR_Blunderball_wep_gml_weapon_swap() {
return sndSwapExplosive;
;
}

// Original Weapons/FR_Blunderball.wep.gml:16
function fr_Weapons_FR_Blunderball_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_Blunderball.wep.gml:17
function fr_Weapons_FR_Blunderball_wep_gml_weapon_handy_data() {
return {"x": (- 1), "y": 3, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/FR_Blunderball.wep.gml:18
function fr_Weapons_FR_Blunderball_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndHeavyNader, (0.9 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndGrenadeRifle, (1.2 + scrFRSourceRandom(0.3)), 1);
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Blunderball_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 3), 3) * __fr_other4.accuracy));
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
scrFRWeaponPost(10, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (6) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
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
}

// Original Weapons/FR_Blunderball.wep.gml:47
function fr_Weapons_FR_Blunderball_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_Blunderball_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
}

// Original Weapons/FR_Blunderball.wep.gml:55
function fr_Weapons_FR_Blunderball_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep};
;
scrFRModCall("mod", "Frontier_Projectiles", "weapon_tutorial_text", x, y, "blunderball");
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
