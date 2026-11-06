#macro frMacro_dependencies_libWeps_mod_gml_scr global.fr_module_vars[$ "mod:libWeps"].scr

#macro frMacro_dependencies_libWeps_mod_gml_call scrFRScriptCall

// Original dependencies/libWeps.mod.gml:1
function fr_dependencies_libWeps_mod_gml___load() {

}

// Original dependencies/libWeps.mod.gml:24
function fr_dependencies_libWeps_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libWeps", _frl_name]);
;
}

// Original dependencies/libWeps.mod.gml:27
function fr_dependencies_libWeps_mod_gml_init() {
fr_dependencies_libWeps_mod_gml_addScript("add_junk");
;
fr_dependencies_libWeps_mod_gml_addScript("superforce_push");
;
fr_dependencies_libWeps_mod_gml_addScript("bullet_recycle");
;
fr_dependencies_libWeps_mod_gml_addScript("weapon_get");
;
fr_dependencies_libWeps_mod_gml_addScript("weapon_fire_init");
;
fr_dependencies_libWeps_mod_gml_addScript("weapon_ammo_fire");
;
fr_dependencies_libWeps_mod_gml_addScript("weapon_ammo_hud");
;
fr_dependencies_libWeps_mod_gml_addScript("draw_ammo");
;
fr_dependencies_libWeps_mod_gml_addScript("spawn_shell");
;
fr_dependencies_libWeps_mod_gml_addScript("draw_weapon_huge");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libWeps"].isLoaded = true;
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libWeps", "scr");
;
global.fr_module_vars[$ "mod:libWeps"].sprRecycleShine = sprFR_505b0095c9c3eb56f75c48a7_19d1567a6937;
;
global.fr_module_vars[$ "mod:libWeps"].junk = {"laser": {"obj": Laser, "typ": 5, "cost": 1, "pwr": 4}, "bullet": {"obj": Bullet1, "typ": 1, "cost": 1, "pwr": 1}, "shell": {"obj": Bullet2, "typ": 2, "cost": 1, "pwr": 0.2}};
;
; // macro hoisted: scr
; // macro hoisted: call
}

// Original dependencies/libWeps.mod.gml:54
function fr_dependencies_libWeps_mod_gml_add_junk(_frl__name=undefined, _frl__obj=undefined, _frl__type=undefined, _frl__cost=undefined, _frl__pwr=undefined) {
scrFRLQSet(global.fr_module_vars[$ "mod:libWeps"].junk, string_lower(_frl__name), {"obj": _frl__obj, "typ": _typ, "cost": _frl__cost, "pwr": _frl__pwr});
;
}

// Original dependencies/libWeps.mod.gml:58
function fr_dependencies_libWeps_mod_gml_superforce_push() {
{ var __fr_with1 = scrFRWithValues((argument_count>0 ? argument[0] : undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
name = "SuperForce";
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
var __fr_other9=scrFROther(other);
or_maxspeed = (scrFRVariableExists(__fr_other9, "maxspeed") ? (__fr_other9.maxspeed / timescale) : (- 1));
var __fr_other10=scrFROther(other);
mask_index = __fr_other10.mask_index;
;
sprite_index = scrFRAreaSourceSprite(mskNothing);
;
if ((argument_count > 1)) {
{
superforce = (argument_count>1 ? argument[1] : undefined);
;
}
} else {
{
superforce = 18;
}
}
if ((argument_count > 2)) {
{
superdirection = (argument_count>2 ? argument[2] : undefined);
;
}
} else {
{
var __fr_other11=scrFROther(other);
superdirection = __fr_other11.direction;
}
}
if ((argument_count > 3)) {
{
superfriction = (argument_count>3 ? argument[3] : undefined);
;
}
} else {
{
superfriction = 1;
}
}
if ((argument_count > 4)) {
{
canwallhit = (argument_count>4 ? argument[4] : undefined);
;
}
} else {
{
canwallhit = true;
}
}
if ((argument_count > 5)) {
{
timer = (argument_count>5 ? argument[5] : undefined);
;
}
} else {
{
timer = 4;
}
}
if ((argument_count > 6)) {
{
disableeffects = (argument_count>6 ? argument[6] : undefined);
;
}
} else {
{
disableeffects = false;
}
}
scrFRMotionSet(superdirection, superforce);
;
on_step = ["mod", "libWeps", fr_dependencies_libWeps_mod_gml_superforce_step];
;
{ var __fr_with12 = scrFRWithValues(scrFRMatchingNE(scrFRMatching(FRCustomObject, "name", "SuperForce"), "id", scrFRSelf(self))), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
if ((creator == (argument_count>0 ? argument[0] : undefined))) {
{
var __fr_other15=scrFROther(other);
__fr_other15.or_maxspeed = or_maxspeed;
;
if ((argument_count > 7)) {
{
var __fr_other16=scrFROther(other);
scrFRScriptCall((argument_count>7 ? argument[7] : undefined), __fr_other16, scrFRSelf(self));
;
}
}
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break14) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libWeps.mod.gml:124
function fr_dependencies_libWeps_mod_gml_superforce_step() {
if ((timer > 0)) {
{
timer -= scrFRSourceScale();
;
exit;
}
}
if (((((((((! scrFRInstanceExists(creator)) || scrFRInstanceIs(creator, Nothing)) || scrFRInstanceIs(creator, TechnoMancer)) || scrFRInstanceIs(creator, Turret)) || scrFRInstanceIs(creator, MaggotSpawn)) || scrFRInstanceIs(creator, Nothing)) || scrFRInstanceIs(creator, LilHunterFly)) || scrFRInstanceIs(creator, RavenFly))) {
{
scrFRDelete(scrFRSelf(self));
;
exit;
}
}
var _frl_pass_step = false;
if (scrFRVariableExists(scrFRSelf(self), "hook_step")) {
{
_frl_pass_step = scrFRScriptCall(hook_step);
;
}
}
if ((! _frl_pass_step)) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! (scrFROther(other)).disableeffects)) {
repeat (2) { var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
scrFRMotionAdd((__fr_other7.direction + scrFRSourceRandomRange((- 8), 8)), scrFRSourceChoose(1, 2, 2, 3));
;
sprite_index = scrFRAreaSourceSprite(sprFRBase_ExtraFeet);
}
}
if(__fr_break6) break;
}}
}
var __fr_other8=scrFROther(other);
__fr_other8.x = x;
;
var __fr_other9=scrFROther(other);
__fr_other9.y = y;
;
if (scrFRVariableExists(scrFRSelf(self), "maxspeed")) {
var __fr_other10=scrFROther(other);
maxspeed = (__fr_other10.superforce) * timescale;
}
var __fr_other11=scrFROther(other);
scrFRMotionSet(__fr_other11.direction, __fr_other11.superforce);
;
var _frl__s = (scrFRVariableExists(scrFRSelf(self), "size") ? size : 0);
;
var __fr_other12=scrFROther(other);
__fr_other12.superforce -= (__fr_other12.superfriction * max(1, _frl__s));
;
if (((scrFROther(other)).superforce <= 0)) {
{
{ var __fr_with13 = scrFRWithValues((scrFROther(other))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((or_maxspeed > (- 1))) {
{
var __fr_other16=scrFROther(other);
__fr_other16.maxspeed = (or_maxspeed) * timescale;
}
}
scrFRDelete(scrFRSelf(self));
exit;
}
}
if(__fr_break15) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
if ((! disableeffects)) {
if ((superforce >= 3)) {
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate((creator.x + scrFRSourceRandomRange((- 3), 3)), (creator.y + scrFRSourceRandomRange((- 3), 3)), ImpactWrists)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
var _frl__fac = .6;
image_xscale = _frl__fac;
image_yscale = _frl__fac;
image_speed = (.75) * timescale;
var __fr_other20=scrFROther(other);
scrFRMotionAdd(__fr_other20.creator.direction, (scrFRSourceRandomRange(1, 3) + 1));
image_angle = direction;
}
}
if(__fr_break19) break;
}}
}
}
if ((scrFRPlaceMeeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall) && (canwallhit == true))) {
{
var _frl_pass_bounce = false;
if (scrFRVariableExists(scrFRSelf(self), "hook_bounce")) {
{
_frl_pass_bounce = scrFRScriptCall(hook_bounce);
;
}
}
if ((! _frl_pass_bounce)) {
{
if ((! disableeffects)) {
{ var __fr_with21 = scrFRWithValues(scrFRInstanceCreate(x, y, MeleeHitWall)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
var __fr_other24=scrFROther(other);
image_angle = __fr_other24.direction;
}
}
if(__fr_break23) break;
}}
}
move_bounce_solid(false);
;
if ((! disableeffects)) {
{
scrFRSoundPitchVolume(sndImpWristKill, 1.2, .8);
scrFRSoundPitchVolume(sndWallBreak, .7, .8);
scrFRSoundPitchVolume(sndHitRock, .8, .8);
sleep(32);
if (scrFRVariableExists(creator, "size")) {
{
scrFRViewShakeAt(x, y, (8 * clamp(creator.size, 1, 3)));
repeat (creator.size) scrFRInstanceCreate(x, y, Debris);
}
}
}
}
}
}
if ((superforce > 4)) {
{ var __fr_with25 = scrFRWithValues(creator), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
var _frl_pass_wallhit = false;
if (scrFRVariableExists((scrFROther(other)), "hook_wallhit")) {
{
var __fr_other28=scrFROther(other);
_frl_pass_wallhit = scrFRScriptCall(__fr_other28.hook_wallhit);
;
}
}
if ((! _frl_pass_wallhit)) {
{
var __fr_other29=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), round(ceil((__fr_other29.superforce * 1.5))), 1, direction);
if ((hp <= 0)) {
{
var _frl_pass_wallkill = false;
if (scrFRVariableExists((scrFROther(other)), "hook_wallkill")) {
{
var __fr_other30=scrFROther(other);
_frl_pass_wallkill = scrFRScriptCall(__fr_other30.hook_wallkill);
;
}
}
if ((! _frl_pass_wallkill)) {
{
if ((! (scrFROther(other)).disableeffects)) {
{
sleep(30);
scrFRViewShakeAt(x, y, 16);
repeat (3) scrFRInstanceCreate(x, y, Dust);
{
sprite_index = scrFRAreaSourceSprite(sprFRBase_ExtraFeet);
}
}
}
}
}
}
}
}
}
}
}
if(__fr_break27) break;
}}
}
if ((! _frl_pass_bounce)) {
{
superforce *= .7;
if ((! disableeffects)) {
{
{ var __fr_with31 = scrFRWithValues(scrFRInstanceCreate(x, y, FRChickenB)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
image_speed = (.65) * timescale;
}
if(__fr_break33) break;
}}
repeat (max(1, creator.size)) { var __fr_with34 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
var _frl__fac = scrFRSourceRandomRange(.2, .5);
image_xscale = _frl__fac;
image_yscale = (_frl__fac * 1.5);
image_speed = ((1 - _frl__fac)) * timescale;
scrFRMotionAdd(scrFRSourceRandom(360), (scrFRSourceRandomRange(1, 3) + 1));
image_angle = direction;
}
}
if(__fr_break36) break;
}}
}
}
}
}
}
}
if (scrFRPlaceMeeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), hitme)) {
{
var _frl__h = instance_nearest((x + (hspeed / timescale)), (y + (vspeed / timescale)), hitme);
;
if ((((! scrFRInstanceIs(_frl__h, Player)) && (_frl__h != creator)) && scrFRProjectileCanHitMelee(_frl__h))) {
{
var _frl_pass_hit = false;
if (scrFRVariableExists(scrFRSelf(self), "hook_hit")) {
{
_frl_pass_hit = scrFRScriptCall(hook_hit, _frl__h, scrFRSelf(self));
;
}
}
if ((! _frl_pass_hit)) {
{
var _frl__d = (scrFRVariableExists(creator, "meleedamage") ? (creator.meleedamage * 2) : 5);
;
var _frl__s = ((ceil(superforce) + _frl__h.size) + _frl__d);
;
if ((! disableeffects)) {
{
sleep(((_frl__s / 3) * max(1, _frl__h.size)));
scrFRViewShakeAt(x, y, ((_frl__s / 3) * max(1, _frl__h.size)));
}
}
scrFRProjectileHit(_frl__h, _frl__s, superforce, direction);
;
scrFRProjectileHit(creator, round((superforce / 2)), 0, direction);
;
superforce *= (.85 + (.15 * min(scrFRGetSkill(mut_impact_wrists), 1)));
;
}
}
}
}
}
}
}
}
}

// Original dependencies/libWeps.mod.gml:250
function fr_dependencies_libWeps_mod_gml_bullet_recycle(_frl__baseChance=undefined, _frl__return=undefined, _frl__patron=undefined) {
var _frl__odds = (_frl__baseChance * scrFRGetSkill(mut_recycle_gland));
if ((scrFRSourceRandom(100) < _frl__odds)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__patron), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [1], min((scrFRIndexGet(ammo, 1) + _frl__return), scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 1)), "=");
}
}
}
if(__fr_break3) break;
}}
scrFRSoundPlay(sndRecGlandProc);
if ((_frl__return == 1)) {
{
scrFRInstanceCreate(x, y, RecycleGland);
}
} else {
{
repeat (_frl__return) {
name = "RecycleGlandCasing";
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = (90 - scrFRSourceRandomRange(135, (- 135)));
speed = ((scrFRSourceRandom(0.8) + 0.8)) * timescale;
sprite_index = scrFRAreaSourceSprite(sprBulletShell);
spin = scrFRSourceChoose(5, (- 5), 8, (- 8), 3, (- 3));
lifetime = (15 + scrFRSourceIRandomRange(2, (- 2)));
;
image_alpha = (- 1);
z = (10 / 4);
;
z_velocity = (12 / 4);
;
z_gravity = (1.1 / 3);
;
on_step = fr_dependencies_libWeps_mod_gml_RecycleFXStep;
on_draw = fr_dependencies_libWeps_mod_gml_RecycleFXDraw;
}
}
if(__fr_break6) break;
}}
}
}
}
}
}
}

// Original dependencies/libWeps.mod.gml:283
function fr_dependencies_libWeps_mod_gml_RecycleFXStep() {
z = max(0, (z + (z_velocity * scrFRSourceScale())));
z_velocity -= (z_gravity * scrFRSourceScale());
image_angle += spin;
lifetime -= scrFRSourceScale();
if ((lifetime == 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - z), CaveSparkle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:libWeps"].sprRecycleShine);
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
}
}
}

// Original dependencies/libWeps.mod.gml:298
function fr_dependencies_libWeps_mod_gml_RecycleFXDraw() {
depth = lerp((- 3), (- 7), (min(4, z) / 2));
image_angle = point_direction(x, y, (x + (hspeed / timescale)), (y - z_velocity));
y -= z;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
;
y += z;
}

// Original dependencies/libWeps.mod.gml:309
function fr_dependencies_libWeps_mod_gml_wep_raw(_frl__wep=undefined) {
var _frl__raw = _frl__wep;
;
while (is_struct(_frl__raw)) {
_frl__raw = (scrFRVariableExists(_frl__raw, "wep") ? scrFRWeaponSlotRead(_frl__raw, "wep") : wep_none);
;
}
if ((is_string(_frl__raw) && scrFRScriptExists("weapon", _frl__raw, "weapon_raw"))) {
{
_frl__raw = scrFRModCall("weapon", _frl__raw, "weapon_raw", _frl__wep);
;
}
}
return _frl__raw;
;
}

// Original dependencies/libWeps.mod.gml:332
function fr_dependencies_libWeps_mod_gml_weapon_get(_frl__name=undefined, _frl__wep=undefined) {
var _frl__raw = _frl__wep;
;
while ((is_struct(_frl__raw) && scrFRVariableExists(_frl__raw, "wep"))) {
_frl__raw = scrFRWeaponSlotRead(_frl__raw, "wep");
;
}
if (is_string(_frl__raw)) {
{
var _frl__scrt = ("weapon_" + _frl__name);
;
if (scrFRScriptExists("weapon", _frl__raw, _frl__scrt)) {
{
return scrFRModCall("weapon", _frl__raw, _frl__scrt, _frl__wep);
;
}
}
}
}
{ var __fr_switch_value1=_frl__name, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("avail")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("burst")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("loadout")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("raw")) __fr_switch_case2=3;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:

case 1:
return 1;
;
case 2:
{ var __fr_switch_value3=_frl__raw, __fr_switch_case4=-1;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_revolver)) __fr_switch_case4=0;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_revolver)) __fr_switch_case4=1;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_chicken_sword)) __fr_switch_case4=2;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_rogue_rifle)) __fr_switch_case4=3;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_rusty_revolver)) __fr_switch_case4=4;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_wrench)) __fr_switch_case4=5;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_machinegun)) __fr_switch_case4=6;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_shotgun)) __fr_switch_case4=7;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_crossbow)) __fr_switch_case4=8;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_grenade_launcher)) __fr_switch_case4=9;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_laser_pistol)) __fr_switch_case4=10;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_screwdriver)) __fr_switch_case4=11;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_assault_rifle)) __fr_switch_case4=12;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_slugger)) __fr_switch_case4=13;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_splinter_gun)) __fr_switch_case4=14;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_bazooka)) __fr_switch_case4=15;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_plasma_gun)) __fr_switch_case4=16;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_nuke_launcher)) __fr_switch_case4=17;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_disc_gun)) __fr_switch_case4=18;
if(__fr_switch_case4==-1 && __fr_switch_value3==(wep_golden_frog_pistol)) __fr_switch_case4=19;
if(__fr_switch_case4==-1) __fr_switch_case4=-1;
switch(__fr_switch_case4) {
case 0:
return sprRevolverLoadout;
;
case 1:
return sprGoldRevolverLoadout;
;
case 2:
return sprChickenSwordLoadout;
;
case 3:
return sprRogueRifleLoadout;
;
case 4:
return sprRustyRevolverLoadout;
;
case 5:
return sprGoldWrenchLoadout;
;
case 6:
return sprGoldMachinegunLoadout;
;
case 7:
return sprGoldShotgunLoadout;
;
case 8:
return sprGoldCrossbowLoadout;
;
case 9:
return sprGoldGrenadeLauncherLoadout;
;
case 10:
return sprGoldLaserPistolLoadout;
;
case 11:
return sprGoldScrewdriverLoadout;
;
case 12:
return sprGoldAssaultRifleLoadout;
;
case 13:
return sprGoldSluggerLoadout;
;
case 14:
return sprGoldSplintergunLoadout;
;
case 15:
return sprGoldBazookaLoadout;
;
case 16:
return sprGoldPlasmaGunLoadout;
;
case 17:
return sprGoldNukeLauncherLoadout;
;
case 18:
return sprGoldDiscgunLoadout;
;
case 19:
return sprGoldToxicGunLoadout;
;
}
}
break;
;
case 3:
return (is_struct(_frl__wep) ? wep_none : _frl__wep);
;
}
}
return 0;
;
}

// Original dependencies/libWeps.mod.gml:395
function fr_dependencies_libWeps_mod_gml_weapon_fire_init(_frl__wep=undefined) {
var _frl__fire = {"wep": _frl__wep, "creator": noone, "primary": true, "wepheld": false, "spec": false, "burst": 1};
;
_frl__fire.creator = scrFRSelf(self);
;
if ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator"))) {
{
_frl__fire.creator = creator;
;
}
}
_frl__fire.wepheld = scrFRSourceWeaponEqual(scrFRVariableGet(_frl__fire.creator, "wep"), scrFRWeaponSlotRead(_frl__fire, "wep"));
;
_frl__fire.spec = scrFRVariableGet(scrFRSelf(self), "specfiring", false);
;
if (((race == scrFRRaceTryResolve("steroids")) && _frl__fire.spec)) {
{
_frl__fire.primary = false;
;
}
}
var _frl__lwo = scrFRModGet("weapon", fr_dependencies_libWeps_mod_gml_wep_raw(scrFRWeaponSlotRead(_frl__fire, "wep")), "lwoWep");
;
if (is_struct(_frl__lwo)) {
{
if ((! is_struct(scrFRWeaponSlotRead(_frl__fire, "wep")))) {
{
scrFRWeaponSlotWrite(_frl__fire, "wep", {"wep": scrFRWeaponSlotRead(_frl__fire, "wep")});
;
if (_frl__fire.wepheld) {
{
scrFRWeaponSlotWrite(_frl__fire.creator, "wep", scrFRWeaponSlotRead(_frl__fire, "wep"));
;
}
}
}
}
{
var _frl_i = (scrFRLQSize(_frl__lwo) - 1);
for (; (_frl_i >= 0); _frl_i--) {
var _frl__key = scrFRLQKey(_frl__lwo, _frl_i);
;
if ((!scrFRVariableExists(scrFRWeaponSlotRead(_frl__fire, "wep"), _frl__key))) {
{
scrFRLQSet(scrFRWeaponSlotRead(_frl__fire, "wep"), _frl__key, scrFRLQValue(_frl__lwo, _frl_i));
;
}
}
}
}
}
}
var _frl__other = (scrFROther(other));
;
{ var __fr_with1 = scrFRWithValues((scrFRInstanceExists(_frl__fire.creator) ? _frl__fire.creator : scrFRSelf(self))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{
if (scrFRWeaponIsMelee(scrFRWeaponSlotRead(_frl__fire, "wep"))) {
{
var __fr_other4=scrFROther(other);
__fr_other4.wepangle *= (- 1);
;
}
}
}
}
}
if(__fr_break3) break;
}}
return _frl__fire;
;
}

// Original dependencies/libWeps.mod.gml:465
function fr_dependencies_libWeps_mod_gml_weapon_ammo_fire(_frl__wep=undefined) {
if ((infammo != 0)) {
{
return true;
;
}
}
var _frl__cost = scrFRLQGet(_frl__wep, "cost", 1);
;
{ var __fr_with1 = scrFRWithValues(_frl__wep), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if ((ammo >= _frl__cost)) {
{
ammo -= _frl__cost;
;
return true;
;
}
}
}
if(__fr_break3) break;
}}
reload = (scrFRVariableGet(scrFRSelf(self), "reloadspeed", 1) * scrFRSourceScale());
;
if (scrFRVariableExists(_frl__wep, "anam")) {
{
if (scrFRButtonPressed(index, (specfiring ? "spec" : "fire"))) {
{
wkick = (- 2);
;
scrFRSoundPlay(sndEmpty);
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
target = __fr_other7.index;
;
mytext = ((_frl__wep.ammo > 0) ? ("NOT ENOUGH " + _frl__wep.anam) : "EMPTY");
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
return false;
;
}

// Original dependencies/libWeps.mod.gml:500
function fr_dependencies_libWeps_mod_gml_weapon_ammo_hud(_frl__wep=undefined) {
if (((scrFRInstanceIs(scrFRSelf(self), Player) && (scrFRInstanceIs((scrFROther(other)), TopCont) || scrFRInstanceIs((scrFROther(other)), UberCont))) && is_struct(_frl__wep))) {
{
var _frl__ammo = scrFRLQGet(_frl__wep, "ammo", 0);
var _frl__ammoMax = scrFRLQGet(_frl__wep, "amax", _frl__ammo);
var _frl__ammoMin = scrFRLQGet(_frl__wep, "amin", round((_frl__ammoMax * 0.2)));
;
fr_dependencies_libWeps_mod_gml_draw_ammo(index, (!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), _frl__wep)), (race == scrFRRaceTryResolve("steroids")), _frl__ammo, _frl__ammoMin);
;
}
}
return scrFRWeaponSprite(_frl__wep);
;
}

// Original dependencies/libWeps.mod.gml:526
function fr_dependencies_libWeps_mod_gml_draw_ammo(_frl__index=undefined, _frl__primary=undefined, _frl__steroids=undefined, _frl__ammo=undefined, _frl__ammoMin=undefined) {
var _frl__local = scrFRPlayerFindLocal();
;
if ((scrFRPlayerIsActive(_frl__local) && scrFRPlayerShowHUD(_frl__index, _frl__local))) {
{
if (((! scrFRInstanceExists(FR_OBJECT_MENU_BUTTON)) || (_frl__index == _frl__local))) {
{
var _frl__x = (scrFRViewCoordinate(0) + (_frl__primary ? 42 : 86));
var _frl__y = (scrFRViewCoordinate(1) + 21);
;
var _frl__active = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__active += scrFRPlayerIsActive(_frl_i);
;
}
}
if ((_frl__active > 1)) {
{
_frl__x -= 19;
;
}
}
var _frl__text = "";
;
if (is_real(_frl__ammo)) {
{
_frl__text += "@";
;
if ((_frl__ammo > 0)) {
{
if ((_frl__primary || _frl__steroids)) {
{
if ((_frl__ammo > _frl__ammoMin)) {
{
_frl__text += "w";
;
}
} else {
_frl__text += "r";
}
;
}
} else {
_frl__text += "s";
}
;
}
} else {
_frl__text += "d";
}
;
}
}
_frl__text += string(_frl__ammo);
;
draw_set_halign(fa_left);
;
draw_set_valign(fa_top);
;
scrFRDrawSetProjection(2, _frl__index);
;
scrFRDrawText(_frl__x, _frl__y, _frl__text);
;
scrFRDrawResetProjection();
;
}
}
}
}
}

// Original dependencies/libWeps.mod.gml:580
function fr_dependencies_libWeps_mod_gml_spawn_shell(_frl__angle=undefined, _frl__spread=undefined, _frl__speed=undefined, _frl__sprite=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.gunangle + (__fr_other4.right * _frl__angle)) + scrFRSourceRandomRange((- _frl__spread), _frl__spread)), _frl__speed);
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libWeps.mod.gml:586
function fr_dependencies_libWeps_mod_gml_draw_weapon_huge(_frl_sprt=undefined) {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_dependencies_libWeps_mod_gml_drawLargeWeapon, (depth + 1))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
gunangle = __fr_other4.gunangle;
;
var __fr_other5=scrFROther(other);
wepangle = __fr_other5.wepangle;
;
var __fr_other6=scrFROther(other);
wkick = __fr_other6.wkick;
;
var __fr_other7=scrFROther(other);
wepflip = __fr_other7.wepflip;
;
var __fr_other8=scrFROther(other);
index = __fr_other8.index;
;
var __fr_other9=scrFROther(other);
right = __fr_other9.right;
;
sprite_index = scrFRAreaSourceSprite(_frl_sprt);
;
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
if (((scrFROther(other)).gunangle > 180)) {
{
var __fr_other11=scrFROther(other);
depth = (__fr_other11.depth - 2);
;
}
} else {
var __fr_other12=scrFROther(other);
depth = (__fr_other12.depth + 1);
}
;
}
}
if(__fr_break3) break;
}}
return mskNone;
;
}
}
return _frl_sprt;
;
}

// Original dependencies/libWeps.mod.gml:606
function fr_dependencies_libWeps_mod_gml_drawLargeWeapon() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = (creator.x + creator.hspeed);
;
y = (creator.y + creator.vspeed);
;
scrFRDrawSetVisibleAll(false);
;
scrFRDrawSetVisible(index, true);
;
if (scrFRPlayerOutlines(index)) {
{
gpu_set_fog(true, scrFRPlayerColor(index), 1, 1);
;
scrFRDrawSpriteExt(sprite_index, image_index, ((1 + x) + lengthdir_x(wkick, gunangle)), (y + lengthdir_y(wkick, gunangle)), 1, wepflip, (gunangle + wepangle), image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index, image_index, (((- 1) + x) + lengthdir_x(wkick, gunangle)), (y + lengthdir_y(wkick, gunangle)), 1, wepflip, (gunangle + wepangle), image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index, image_index, (x + lengthdir_x(wkick, gunangle)), ((1 + y) + lengthdir_y(wkick, gunangle)), 1, wepflip, (gunangle + wepangle), image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index, image_index, (x + lengthdir_x(wkick, gunangle)), (((- 1) + y) + lengthdir_y(wkick, gunangle)), 1, wepflip, (gunangle + wepangle), image_blend, image_alpha);
;
gpu_set_fog(false, scrFRPlayerColor(index), 1, 1);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, (x + lengthdir_x(wkick, gunangle)), (y + lengthdir_y(wkick, gunangle)), 1, wepflip, (gunangle + wepangle), image_blend, image_alpha);
;
scrFRDrawSetVisibleAll(true);
;
scrFRInstanceDestroy();
;
}
