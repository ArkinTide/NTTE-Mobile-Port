#macro frMacro_Weapons_FR_HullShredder_wep_gml_scr global.fr_module_vars[$ "weapon:FR_HullShredder"].scr

#macro frMacro_Weapons_FR_HullShredder_wep_gml_call scrFRScriptCall

#macro frMacro_Weapons_FR_HullShredder_wep_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

// Original Weapons/FR_HullShredder.wep.gml:1
function fr_Weapons_FR_HullShredder_wep_gml___load() {

}

// Original Weapons/FR_HullShredder.wep.gml:1
function fr_Weapons_FR_HullShredder_wep_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Weapons_FR_HullShredder_wep_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Weapons_FR_HullShredder_wep_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Weapons_FR_HullShredder_wep_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Weapons/FR_HullShredder.wep.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "weapon", "FR_HullShredder", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "weapon:FR_HullShredder"].sprWeapon = sprFR_sprHullShredder_a6c16cc7c2e2;
;
}
_fr.pc=0;
break;
case 3: // Weapons/FR_HullShredder.wep.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Weapons/FR_HullShredder.wep.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Weapons/FR_HullShredder.wep.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Weapons/FR_HullShredder.wep.gml:12
function fr_Weapons_FR_HullShredder_wep_gml_weapon_name() {
return scrFRLocalize("HULLSHREDDER");
;
}

// Original Weapons/FR_HullShredder.wep.gml:13
function fr_Weapons_FR_HullShredder_wep_gml_weapon_text() {
return scrFRLocalize("LET IT RIP");
;
}

// Original Weapons/FR_HullShredder.wep.gml:14
function fr_Weapons_FR_HullShredder_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_HullShredder"].sprWeapon;
;
}

// Original Weapons/FR_HullShredder.wep.gml:15
function fr_Weapons_FR_HullShredder_wep_gml_weapon_type() {
return 3;
;
}

// Original Weapons/FR_HullShredder.wep.gml:16
function fr_Weapons_FR_HullShredder_wep_gml_weapon_type_string() {
return scrFRLocalize("BOLTS");
;
}

// Original Weapons/FR_HullShredder.wep.gml:17
function fr_Weapons_FR_HullShredder_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_HullShredder.wep.gml:18
function fr_Weapons_FR_HullShredder_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_HullShredder", 9);
;
}

// Original Weapons/FR_HullShredder.wep.gml:19
function fr_Weapons_FR_HullShredder_wep_gml_weapon_load() {
return 2;
;
}

// Original Weapons/FR_HullShredder.wep.gml:20
function fr_Weapons_FR_HullShredder_wep_gml_weapon_cost() {
return 0;
;
}

// Original Weapons/FR_HullShredder.wep.gml:21
function fr_Weapons_FR_HullShredder_wep_gml_weapon_true_cost() {
return 3;
;
}

// Original Weapons/FR_HullShredder.wep.gml:22
function fr_Weapons_FR_HullShredder_wep_gml_weapon_chrg_cost() {
return 1;
;
}

// Original Weapons/FR_HullShredder.wep.gml:23
function fr_Weapons_FR_HullShredder_wep_gml_weapon_swap() {
return sndSwapBow;
;
}

// Original Weapons/FR_HullShredder.wep.gml:24
function fr_Weapons_FR_HullShredder_wep_gml_weapon_chrg() {
return true;
;
}

// Original Weapons/FR_HullShredder.wep.gml:25
function fr_Weapons_FR_HullShredder_wep_gml_weapon_charge_max() {
return 10;
;
}

// Original Weapons/FR_HullShredder.wep.gml:26
function fr_Weapons_FR_HullShredder_wep_gml_weapon_laser_sight() {
return 0;
;
}

// Original Weapons/FR_HullShredder.wep.gml:27
function fr_Weapons_FR_HullShredder_wep_gml_weapon_auto() {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
return ((scrFRIndexGet(ammo, fr_Weapons_FR_HullShredder_wep_gml_weapon_type()) < fr_Weapons_FR_HullShredder_wep_gml_weapon_chrg_cost()) ? false : true);
;
}
} else {
{
return true;
;
}
}
}

// Original Weapons/FR_HullShredder.wep.gml:34
function fr_Weapons_FR_HullShredder_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_HullShredder.wep.gml:35
function fr_Weapons_FR_HullShredder_wep_gml_weapon_handy_data() {
return {"x": 3, "y": 4, "bhand": true, "bx": 9, "by": 6};
}

// Original Weapons/FR_HullShredder.wep.gml:37
function fr_Weapons_FR_HullShredder_wep_gml_weapon_reloaded() {

}

// Original Weapons/FR_HullShredder.wep.gml:39
function fr_Weapons_FR_HullShredder_wep_gml_weapon_fire(_frl__wep=undefined) {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
if ((scrFRIndexGet(ammo, fr_Weapons_FR_HullShredder_wep_gml_weapon_type()) < fr_Weapons_FR_HullShredder_wep_gml_weapon_chrg_cost())) {
{
frMacro_Weapons_FR_HullShredder_wep_gml_call(frMacro_Weapons_FR_HullShredder_wep_gml_scr.pickup_text, fr_Weapons_FR_HullShredder_wep_gml_weapon_type_string(), "ins");
scrFRSoundPlay(sndEmpty);
;
wkick = 6;
;
reload = 10;
;
exit;
;
}
}
}
}
var _frl__fire = scrFRModCall("mod", "Frontier_Projectiles", "charge_weapon_fire_init", _frl__wep);
_frl__wep = scrFRWeaponSlotRead(_frl__fire, "wep");
;
var _frl__charge = (_frl__wep.chrg_num / _frl__wep.chrg_max);
;
if (_frl__wep.chrg) {
{
scrFRWeaponPost((5 * _frl__charge), ((8 * _frl__charge) * scrFRSourceScale()), 0);
;
if ((_frl__wep.chrg == 1)) {
{
if ((_frl__charge >= 0.25)) {
{
if (frMacro_Weapons_FR_HullShredder_wep_gml_current_frame_active) {
{
scrFRSoundPitch(sndMeleeFlip, (1 / (1 - (0.25 * _frl__charge))));
;
scrFRSoundPitchVolume(sndSwapBow, (0.3 + (2 * _frl__charge)), 0.3);
;
}
}
}
}
if ((_frl__charge >= 1)) {
{
scrFRSoundPitch(sndCrystalRicochet, 3);
;
scrFRSoundPitch(sndSewerDrip, 3);
;
var _frl__lx = (22 - wkick);
var _frl__ly = (2 * scrFRVariableGet(_frl__fire.creator, "wepflip", 1));
var _frl__d = (gunangle + (wepangle * (1 - (wkick / 20))));
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((((x + hspeed) + lengthdir_x(_frl__lx, _frl__d)) + lengthdir_x(_frl__ly, (_frl__d - 90))), (((y + vspeed) + lengthdir_y(_frl__lx, _frl__d)) + lengthdir_y(_frl__ly, (_frl__d - 90))), ThrowHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
scrFRInstanceCreate(x, y, ImpactWrists);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
} else {
if ((_frl__charge > 0)) {
{
if ((_frl__charge < 1)) {
{
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
if ((scrFRIndexGet(ammo, fr_Weapons_FR_HullShredder_wep_gml_weapon_type()) < fr_Weapons_FR_HullShredder_wep_gml_weapon_true_cost())) {
{
frMacro_Weapons_FR_HullShredder_wep_gml_call(frMacro_Weapons_FR_HullShredder_wep_gml_scr.pickup_text, fr_Weapons_FR_HullShredder_wep_gml_weapon_type_string(), "ins");
scrFRSoundPlay(sndEmpty);
;
wkick = 6;
;
reload = 10;
;
exit;
;
}
}
}
}
scrFRSoundPitchVolume(sndDiscgun, (0.7 + scrFRSourceRandom(0.2)), 1);
;
scrFRSoundPitchVolume(sndSeekerPistol, (0.8 + scrFRSourceRandom(0.2)), 1);
;
{ var __fr_with5 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Sawblade_create", x, y)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
direction = (__fr_other8.gunangle + (scrFRSourceRandomRange((- 15), 15) * __fr_other8.accuracy));
;
image_angle = direction;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
}
}
if(__fr_break7) break;
}}
fr_Weapons_FR_HullShredder_wep_gml_consume_true_ammo();
;
scrFRWeaponPost(6, 5, 10);
;
repeat (3) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
direction = (__fr_other14.gunangle + scrFRSourceRandomRange((- 25), 25));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
}
} else {
{
scrFRSoundPitchVolume(sndCrossbow, (1.3 + scrFRSourceRandom(0.2)), 1);
;
{ var __fr_with15 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Magnet_create", x, y, scrFRMouseCoordinate(0, (scrFROther(other)).index), scrFRMouseCoordinate(1, (scrFROther(other)).index))), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
var __fr_other18=scrFROther(other);
direction = point_direction(x, y, scrFRMouseCoordinate(0, __fr_other18.index), scrFRMouseCoordinate(1, __fr_other18.index));
;
image_angle = direction;
;
var __fr_other19=scrFROther(other);
team = __fr_other19.team;
;
var __fr_other20=scrFROther(other);
creator = __fr_other20;
;
}
}
if(__fr_break17) break;
}}
fr_Weapons_FR_HullShredder_wep_gml_consume_ammo();
;
scrFRWeaponPost(5, 2, 2);
;
}
}
}
}
}
}

// Original Weapons/FR_HullShredder.wep.gml:154
function fr_Weapons_FR_HullShredder_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_HullShredder_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
}

// Original Weapons/FR_HullShredder.wep.gml:161
function fr_Weapons_FR_HullShredder_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "chrg": false, "chrg_num": 0, "chrg_max": fr_Weapons_FR_HullShredder_wep_gml_weapon_charge_max(), "auto": true};
;
scrFRModCall("mod", "Frontier_Projectiles", "weapon_tutorial_text", x, y, "chargeWep");
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

// Original Weapons/FR_HullShredder.wep.gml:181
function fr_Weapons_FR_HullShredder_wep_gml_consume_ammo() {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
if ((infammo == 0)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [fr_Weapons_FR_HullShredder_wep_gml_weapon_type()], min(scrFRIndexGet(ammo, fr_Weapons_FR_HullShredder_wep_gml_weapon_type()), fr_Weapons_FR_HullShredder_wep_gml_weapon_chrg_cost()), "-=");
;
}
}
}
}
}

// Original Weapons/FR_HullShredder.wep.gml:188
function fr_Weapons_FR_HullShredder_wep_gml_consume_true_ammo() {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
if ((infammo == 0)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [fr_Weapons_FR_HullShredder_wep_gml_weapon_type()], min(scrFRIndexGet(ammo, fr_Weapons_FR_HullShredder_wep_gml_weapon_type()), fr_Weapons_FR_HullShredder_wep_gml_weapon_true_cost()), "-=");
;
}
}
}
}
}

// Original Weapons/FR_HullShredder.wep.gml:195
function fr_Weapons_FR_HullShredder_wep_gml_wep_get(_frl__primary=undefined, _frl__name=undefined, _frl__default=undefined) {
return scrFRVariableGet(scrFRSelf(self), ((_frl__primary ? "" : "b") + _frl__name), _frl__default);
;
}

// Original Weapons/FR_HullShredder.wep.gml:196
function fr_Weapons_FR_HullShredder_wep_gml_wep_set(_frl__primary=undefined, _frl__name=undefined, _frl__value=undefined) {
if (scrFRVariableExists(scrFRSelf(self), ((_frl__primary ? "" : "b") + _frl__name))) {
scrFRVariableSet(scrFRSelf(self), ((_frl__primary ? "" : "b") + _frl__name), _frl__value);
}
; // macro hoisted: current_frame_active
}
