// Original Weapons/FR_GildedHookpole.wep.gml:1
function fr_Weapons_FR_GildedHookpole_wep_gml___load() {

}

// Original Weapons/FR_GildedHookpole.wep.gml:1
function fr_Weapons_FR_GildedHookpole_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_GildedHookpole"].sprWeapon = sprFR_sprGildedHookpole_3b51929fbfb5;
;
global.fr_module_vars[$ "weapon:FR_GildedHookpole"].sprWeaponHud = sprFR_sprPowderPole_93634d61e6db;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:8
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_name(_frl__wep=undefined) {
if ((scrFRInstanceIs(scrFRSelf(self), WepPickup) && scrFRInstanceIs((scrFROther(other)), Player))) {
{
if ((sprite_index == sprScrewDriver)) {
{
var __fr_other1=scrFROther(other);
fr_Weapons_FR_GildedHookpole_wep_gml_weapon_drop(__fr_other1);
}
}
}
}
return scrFRLocalize("GILDED HOOKPOLE");
}

// Original Weapons/FR_GildedHookpole.wep.gml:15
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_text() {
return scrFRLocalize("THE HOOKS!!!!!!");
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:16
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_GildedHookpole"].sprWeapon;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:17
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_sprt_hud() {
return global.fr_module_vars[$ "weapon:FR_GildedHookpole"].sprWeaponHud;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:18
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_type() {
return 0;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:19
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:20
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_area() {
return (- 1);
}

// Original Weapons/FR_GildedHookpole.wep.gml:21
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:22
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_load() {
return 14;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:23
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_cost() {
return 1;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:24
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_swap() {
return sndSwapSword;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:25
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_GildedHookpole.wep.gml:26
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_handy_data() {
return {"x": 0, "y": 3, "bhand": true, "bx": 14, "by": 3};
}

// Original Weapons/FR_GildedHookpole.wep.gml:28
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
audio_sound_pitch(scrFRSoundGun(sndGoldScrewdriver, 0, 0.8), (0.75 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitchVolume(sndChickenSword, scrFRSourceRandomRange(0.85, 0.95), 0.3);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(25, gunangle)), (y + lengthdir_y(25, gunangle)), Shank)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 1.2;
;
image_yscale = 0.8;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 1), 1) * __fr_other4.accuracy));
;
image_angle = direction;
;
damage = 17;
;
speed = ((2 + (3 * scrFRGetSkill(mut_long_arms)))) * timescale;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6;
;
canfix = false;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Shank)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_yscale = 0.15;
;
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth - 1);
;
var __fr_other11=scrFROther(other);
direction = (__fr_other11.gunangle + (scrFRSourceRandomRange((- 1), 1) * __fr_other11.accuracy));
;
image_angle = direction;
;
mask_index = mskSlash;
;
speed = (2) * timescale;
;
damage = 6;
;
canfix = false;
;
canreflect = false;
;
var __fr_other12=scrFROther(other);
team = __fr_other12.team;
;
var __fr_other13=scrFROther(other);
creator = __fr_other13;
;
}
}
if(__fr_break9) break;
}}
scrFRWeaponPost((- 20), 11, 8);
;
wepangle = (- wkick);
;
var __fr_other14=scrFROther(other);
scrFRMotionAdd(__fr_other14.gunangle, 3);
;
scrFRInstanceCreate(x, y, Dust);
}

// Original Weapons/FR_GildedHookpole.wep.gml:76
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}

// Original Weapons/FR_GildedHookpole.wep.gml:80
function fr_Weapons_FR_GildedHookpole_wep_gml_weapon_drop(_frl__player=undefined) {
_frl__player.wepangle = (120 * sign(_frl__player.wepangle));
}

// Original Weapons/FR_GildedHookpole.wep.gml:83
function fr_Weapons_FR_GildedHookpole_wep_gml_step(_frl__primary=undefined) {
var _frl__wep = (_frl__primary ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if (scrFRVariableExists(scrFRSelf(self), "right")) {
{
var _frl__right = right;
;
}
} else {
{
var _frl__right = 1;
;
}
}
if (_frl__primary) {
{
wepflip = right;
;
wepangle = (max(0.1, ((- 0.1) * wkick)) * right);
;
wkick += (0.8 * scrFRSourceScale());
;
}
} else {
{
bwepflip = ((- 1) * right);
;
bwepangle = (max(0.1, ((- 0.1) * bwkick)) * right);
;
}
}
}
