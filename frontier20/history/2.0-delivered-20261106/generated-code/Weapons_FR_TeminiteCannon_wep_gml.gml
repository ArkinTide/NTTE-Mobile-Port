// Original Weapons/FR_TeminiteCannon.wep.gml:1
function fr_Weapons_FR_TeminiteCannon_wep_gml___load() {

}

// Original Weapons/FR_TeminiteCannon.wep.gml:1
function fr_Weapons_FR_TeminiteCannon_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sprWeapon = sprFR_sprTeminiteCannon_eafb1dc61520;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sprEpicStreak = sprFR_sprEpicStreak_7af2c95e8a16;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireA = sndFR_sndTeminiteFireA_c524a1d63570;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireB1 = sndFR_sndTeminiteFireB1_7792d805228a;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireB2 = sndFR_sndTeminiteFireB2_e14588a7d767;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireC = sndFR_sndTeminiteFireC_149e1cf92ad6;
;
global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteSwap = sndFR_sndTeminiteSwap_c1ac79782cd7;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:13
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_name() {
return "TEMINITE CANNON";
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:14
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_text() {
return scrFRSourceChoose("SEND THEM TO THE DEPTHS", "RAISE THE BLACK FLAG");
}

// Original Weapons/FR_TeminiteCannon.wep.gml:15
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sprWeapon;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:16
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_type() {
return 5;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:17
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:18
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_TeminiteCannon", 22);
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:19
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:20
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_load(_frl__wep=undefined) {
if ((! is_struct(_frl__wep))) {
{
return 9;
;
}
} else {
{
return ((_frl__wep.teminite < 4) ? 9 : 3);
;
}
}
}

// Original Weapons/FR_TeminiteCannon.wep.gml:26
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_cost() {
if ((! is_struct((argument_count>0 ? argument[0] : undefined)))) {
{
return 3;
;
}
} else {
{
return (((argument_count>0 ? argument[0] : undefined).teminite < 4) ? 3 : 1);
;
}
}
}

// Original Weapons/FR_TeminiteCannon.wep.gml:33
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_swap() {
return global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteSwap;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:35
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:36
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 6, "bhand": true, "bx": 10, "by": 7};
}

// Original Weapons/FR_TeminiteCannon.wep.gml:39
function fr_Weapons_FR_TeminiteCannon_wep_gml_weapon_fire(_frl__wep=undefined) {
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_TeminiteCannon_wep_gml_lwo_initialize(_frl__wep);
;
}
}
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
{ var __fr_switch_value1=_frl__wep.teminite, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(3)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(4)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(6)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(5)) __fr_switch_case2=5;
if(__fr_switch_case2==-1) __fr_switch_case2=6;
switch(__fr_switch_case2) {
case 0:

case 1:

case 2:
scrFRSoundPitchVolume(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireA, 1, 1);
;
break;
;
case 3:

case 4:
scrFRSoundPitchVolume(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireB1, 1, 1);
;
break;
;
case 5:
scrFRSoundPitchVolume(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireB2, 1, 1);
;
break;
;
case 6:
scrFRSoundPitchVolume(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sndTeminiteFireC, (1 + ((9 - _frl__wep.teminite) * 0.2)), 1);
;
break;
;
}
}
if ((_frl__wep.teminite <= 3)) {
{
{ var __fr_with3 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "EpicCannonball_create", x, y)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
var __fr_other6=scrFROther(other);
direction = (__fr_other6.gunangle + (scrFRSourceRandomRange((- 10), 10) * __fr_other6.accuracy));
;
image_angle = direction;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
}
}
if(__fr_break5) break;
}}
repeat (5) {
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sprEpicStreak);
;
speed = ((4 + scrFRSourceRandom(4))) * timescale;
;
var __fr_other12=scrFROther(other);
direction = (__fr_other12.gunangle + scrFRSourceRandomRange((- 60), 60));
;
image_angle = direction;
;
image_index = scrFRSourceChoose(0, 1);
;
}
}
if(__fr_break11) break;
}}
}
}
} else {
{
{ var __fr_with13 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "EpicBeam_create", x, y, ((scrFROther(other)).gunangle + (scrFRSourceRandomRange((- 6), 6) * accuracy)))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
image_angle = direction;
;
var __fr_other16=scrFROther(other);
team = __fr_other16.team;
;
var __fr_other17=scrFROther(other);
creator = __fr_other17;
;
}
}
if(__fr_break15) break;
}}
repeat (3) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_TeminiteCannon"].sprEpicStreak);
;
speed = ((4 + scrFRSourceRandom(4))) * timescale;
;
var __fr_other21=scrFROther(other);
direction = (__fr_other21.gunangle + scrFRSourceRandomRange((- 25), 25));
;
image_angle = direction;
;
image_index = scrFRSourceChoose(0, 1);
;
}
}
if(__fr_break20) break;
}}
}
}
}
scrFRWeaponPost(8, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 3);
_frl__wep.teminite = ((_frl__wep.teminite >= _frl__wep.teminite_max) ? 1 : (_frl__wep.teminite + 1));
;
}

// Original Weapons/FR_TeminiteCannon.wep.gml:107
function fr_Weapons_FR_TeminiteCannon_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_TeminiteCannon_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
}

// Original Weapons/FR_TeminiteCannon.wep.gml:114
function fr_Weapons_FR_TeminiteCannon_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "teminite": 1, "teminite_max": 9};
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
