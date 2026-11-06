#macro frMacro_Weapons_FR_GhostCutlass_wep_gml_scr global.fr_module_vars[$ "weapon:FR_GhostCutlass"].scr

#macro frMacro_Weapons_FR_GhostCutlass_wep_gml_call scrFRScriptCall

#macro frMacro_Weapons_FR_GhostCutlass_wep_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

// Original Weapons/FR_GhostCutlass.wep.gml:1
function fr_Weapons_FR_GhostCutlass_wep_gml___load() {

}

// Original Weapons/FR_GhostCutlass.wep.gml:1
function fr_Weapons_FR_GhostCutlass_wep_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Weapons_FR_GhostCutlass_wep_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Weapons_FR_GhostCutlass_wep_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Weapons_FR_GhostCutlass_wep_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Weapons/FR_GhostCutlass.wep.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "weapon", "FR_GhostCutlass", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeapon = sprFR_sprGhostCutlassInactive_918cfd56c3cb;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponOn = sprFR_sprGhostCutlassActive_50b37f392b76;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponGlow = sprFR_sprGhostCutlassActiveGlo_d74af852ce90;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponHud = sprFR_sprGhostCutlassHud_c1f23a446390;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprGhostSlash = sprFR_sprGhostSlash_b25e247659a7;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprGhostNull = sprFR_sprGhostNull_6b646bf7168c;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprFollower = sprFR_sprGhostCutlassFollower_8f1cd1ab608d;
;
global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprFollowerGlow = sprFR_sprGhostCutlassFollowerG_7faa825e0149;
;
}
_fr.pc=0;
break;
case 3: // Weapons/FR_GhostCutlass.wep.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Weapons/FR_GhostCutlass.wep.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Weapons/FR_GhostCutlass.wep.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Weapons/FR_GhostCutlass.wep.gml:20
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_name() {
return scrFRLocalize("GHASTLY CUTLASS");
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:21
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_text() {
return scrFRLocalize("@qITS WHISPERING");
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:22
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_sprt(_frl__wep=undefined) {
if ((scrFRInstanceIs(scrFRSelf(self), Player) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), _frl__wep))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Weapons_FR_GhostCutlass_wep_gml_PlayerGhostCutlass_draw, (depth + 1))), __fr_break3=false;
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
right = __fr_other7.right;
;
var __fr_other8=scrFROther(other);
wepflip = __fr_other8.wepflip;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponOn);
;
var __fr_other9=scrFROther(other);
creator = __fr_other9;
;
var __fr_other10=scrFROther(other);
image_blend = scrFRPlayerColor(__fr_other10.index);
var __fr_other11=scrFROther(other);
x = (__fr_other11.x + __fr_other11.hspeed);
;
var __fr_other12=scrFROther(other);
y = (__fr_other12.y + __fr_other12.vspeed);
;
if (((scrFROther(other)).gunangle > 180)) {
{
var __fr_other13=scrFROther(other);
depth = (__fr_other13.depth - 2);
;
}
} else {
{
var __fr_other14=scrFROther(other);
depth = (__fr_other14.depth + 1);
;
}
}
}
}
if(__fr_break3) break;
}}
return mskNone;
;
}
} else {
{
if ((scrFRInstanceIs(scrFRSelf(self), Player) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), _frl__wep))) {
{
return mskNone;
;
}
} else {
{
return global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeapon;
;
}
}
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:53
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_sprt_hud() {
return global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponHud;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:54
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_type() {
return 0;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:55
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_melee() {
return true;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:56
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_GhostCutlass", 14);
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:57
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:58
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_load() {
return 15;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:59
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_cost() {
return 0;
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:60
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_swap() {
scrFRSoundPitchVolume(sndSwapCursed, 0.7, 1.2);
;
return sndSwapSword;
}

// Original Weapons/FR_GhostCutlass.wep.gml:64
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndPlasma, (1.3 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndBloodLauncher, (1.1 + scrFRSourceRandom(0.3)), 0.4);
;
var _frl__disjoint = (0 + (15 * scrFRGetSkill(mut_long_arms)));
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(_frl__disjoint, gunangle)), (y + lengthdir_y(_frl__disjoint, gunangle)), Slash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprGhostSlash);
;
image_alpha = 0.7;
;
speed = ((1.5 + (scrFRGetSkill(13) * 4))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.gunangle;
;
image_angle = direction;
;
damage = 24;
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
wepangle = (- wepangle);
;
scrFRWeaponPost((- 4), 16, 5);
;
scrFRMotionAdd(gunangle, 3.5);
;
scrFRInstanceCreate(x, y, Dust);
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:92
function fr_Weapons_FR_GhostCutlass_wep_gml_weapon_reloaded() {
scrFRSoundPlay(sndMeleeFlip);
wepflip = sign(wepangle);
}

// Original Weapons/FR_GhostCutlass.wep.gml:96
function fr_Weapons_FR_GhostCutlass_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_GhostCutlass_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
if ((!scrFRSourceWeaponEqual(scrFRWeaponSlotRead((scrFROther(other)), "wep"), _frl__wep))) {
{
if (((scrFROther(other)).race != scrFRRaceTryResolve("steroids"))) {
{
if ((array_length(scrFRMatching(FRCustomObject, "fr_ghostsword", (scrFROther(other)))) == 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_create(x, y, scrFRSelf(self));
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
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:114
function fr_Weapons_FR_GhostCutlass_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "fr_ghostsword": true};
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

// Original Weapons/FR_GhostCutlass.wep.gml:128
function fr_Weapons_FR_GhostCutlass_wep_gml_PlayerGhostCutlass_draw() {
if ((! scrFRInstanceExists((scrFROther(other))))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
fr_Weapons_FR_GhostCutlass_wep_gml_draw_weapon_evilsword(sprite_index, (scrFRSourceFrame() * 0.4), x, y, gunangle, wepangle, wkick, 1, wepflip, c_white, 1);
fr_Weapons_FR_GhostCutlass_wep_gml_draw_weapon_evilsword(global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprWeaponGlow, (scrFRSourceFrame() * 0.4), x, y, gunangle, wepangle, wkick, 1.5, (1.5 * wepflip), c_white, 0.4);
scrFRInstanceDestroy();
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:138
function fr_Weapons_FR_GhostCutlass_wep_gml_draw_weapon_evilsword(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__xscale=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
if ((_frl__angleMelee != 0)) {
{
_frl__angle += (_frl__angleMelee * (1 - (_frl__kick / 20)));
;
}
}
if ((_frl__kick != 0)) {
{
_frl__x -= lengthdir_x(_frl__kick, _frl__angle);
;
_frl__y -= lengthdir_y(_frl__kick, _frl__angle);
;
}
}
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, _frl__xscale, _frl__flip, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:161
function fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_create(_frl__x=undefined, _frl__y=undefined, _frl__leader=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GhostCutlass";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprFollower);
;
spr_glow = global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprFollowerGlow;
;
spr_dead = global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprGhostNull;
;
depth = (- 8);
;
image_alpha = 0;
;
right = 0;
;
tilt = 0;
;
bobHeight = 0.3;
;
bobSpeed = 0.06;
;
fr_glow = [32, 48];
;
leader = _frl__leader;
;
xGoal = _frl__leader.x;
;
yGoal = _frl__leader.y;
;
team = _frl__leader.team;
;
fr_ghostsword = _frl__leader;
;
flightspeed = 5;
;
offset = 0;
;
distance = 30;
;
attacking = false;
;
attackCooldown = 0;
;
attackRange = (96 + (scrFRGetSkill(mut_long_arms) * 32));
;
hitbox = noone;
;
target = noone;
;
graceTime = 0;
;
on_step = fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_step;
;
on_draw = fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_draw;
;
on_destroy = fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Weapons/FR_GhostCutlass.wep.gml:198
function fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_step() {
if ((! scrFRInstanceExists(leader))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (((! is_struct(scrFRWeaponSlotRead(leader, "bwep"))) || (!scrFRVariableExists(scrFRWeaponSlotRead(leader, "bwep"), "fr_ghostsword")))) {
{
{ var __fr_with1 = scrFRWithValues(hitbox), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((hitbox == noone)) {
{
hitbox = fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_create(x, y, scrFRSelf(self));
;
}
}
if ((attacking == false)) {
{
x += (fr_Weapons_FR_GhostCutlass_wep_gml_approach(x, xGoal, 2, (0.4 * scrFRSourceScale())) - lengthdir_x(0, leader.gunangle));
y += (fr_Weapons_FR_GhostCutlass_wep_gml_approach(y, yGoal, 2, (0.4 * scrFRSourceScale())) - lengthdir_y(0, leader.gunangle));
y = (y + (sin((scrFRSourceFrame() * bobSpeed)) * bobHeight));
;
xGoal = (leader.x - lengthdir_x(distance, (leader.gunangle + offset)));
yGoal = (leader.y - lengthdir_y(distance, (leader.gunangle + offset)));
tilt = (0 + (sin((scrFRSourceFrame() * 0.12)) * 16));
right = ((((leader.gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((scrFRSourceRandom(50) < 1)) {
{
offset = scrFRSourceIRandomRange((- 40), 40);
;
distance = (20 + scrFRSourceIRandom(16));
}
}
var _frl__enemy = instance_nearest(leader.x, leader.y, enemy);
;
{ var __fr_with4 = scrFRWithValues(leader), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((distance_to_object(_frl__enemy) < (scrFROther(other)).attackRange) && (! collision_line(x, y, _frl__enemy.x, _frl__enemy.y, Wall, false, false)))) {
{
var __fr_other7=scrFROther(other);
__fr_other7.target = _frl__enemy;
;
var __fr_other8=scrFROther(other);
__fr_other8.attacking = true;
;
var __fr_other9=scrFROther(other);
__fr_other9.attackCooldown = 0;
;
}
}
}
}
if(__fr_break6) break;
}}
}
} else {
{
if (frMacro_Weapons_FR_GhostCutlass_wep_gml_current_frame_active) {
{
if (scrFRInstanceExists(target)) {
{
tilt -= (angle_difference(tilt, (point_direction(x, y, target.x, target.y) + 90)) * power(0.2, 1));
;
if (((speed / timescale) > 2)) {
{
direction -= (angle_difference(direction, point_direction(x, y, target.x, target.y)) * power(0.1, 1));
;
}
}
}
}
attackCooldown -= 1;
;
graceTime -= 1;
;
speed = (clamp(((speed / timescale) - ((speed / timescale) / 12)), 2, 18)) * timescale;
;
if ((attackCooldown <= 0)) {
{
if (scrFRInstanceExists(target)) {
{
direction = point_direction(x, y, target.x, target.y);
;
}
}
speed = (clamp((distance_to_object(target) / 4), 12, 30)) * timescale;
;
attackCooldown = 20;
;
graceTime = 15;
;
}
} else {
{
var _frl__enemy = instance_nearest(leader.x, leader.y, enemy);
;
{ var __fr_with10 = scrFRWithValues(leader), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (((distance_to_object(_frl__enemy) > (scrFROther(other)).attackRange) || collision_line(x, y, _frl__enemy.x, _frl__enemy.y, Wall, false, false))) {
{
if (((scrFROther(other)).graceTime <= 0)) {
{
var __fr_other13=scrFROther(other);
__fr_other13.attacking = false;
;
var __fr_other14=scrFROther(other);
__fr_other14.speed = (0) * timescale;
;
}
}
}
} else {
{
var __fr_other15=scrFROther(other);
__fr_other15.target = _frl__enemy;
;
}
}
}
}
if(__fr_break12) break;
}}
}
}
}
}
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:283
function fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Weapons/FR_GhostCutlass.wep.gml:288
function fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
mask_index = mskFlakBullet;
;
damage = 8;
;
typ = 0;
;
ammo_type = (- 1);
;
on_anim = fr_Weapons_FR_GhostCutlass_wep_gml_nothing;
;
on_projectile = fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_nullify;
;
on_grenade = fr_Weapons_FR_GhostCutlass_wep_gml_nothing;
;
on_hit = fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_hit;
;
on_wall = fr_Weapons_FR_GhostCutlass_wep_gml_nothing;
;
on_end_step = fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_endstep;
;
on_destroy = fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Weapons/FR_GhostCutlass.wep.gml:309
function fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other4.damage);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:316
function fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_nullify() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPitchVolume(sndCursedPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_GhostCutlass"].sprGhostNull);
;
}
}
if(__fr_break6) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:327
function fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_endstep() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = creator.x;
y = creator.y;
if ((creator.attacking == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GenericTrail_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (- 7);
;
var __fr_other4=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other4.xprevious, __fr_other4.yprevious);
image_yscale *= 2;
;
image_speed *= 4;
;
var __fr_other5=scrFROther(other);
image_angle = point_direction(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_blend = make_color_rgb(63, 247, 151);
;
image_alpha = 0.7;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:344
function fr_Weapons_FR_GhostCutlass_wep_gml_SwordHitbox_destroy() {
if (scrFRInstanceExists(creator)) {
{
creator.hitbox = noone;
;
}
}
}

// Original Weapons/FR_GhostCutlass.wep.gml:349
function fr_Weapons_FR_GhostCutlass_wep_gml_nothing() {

}

// Original Weapons/FR_GhostCutlass.wep.gml:351
function fr_Weapons_FR_GhostCutlass_wep_gml_GhostCutlassFollower_draw() {
scrFRDrawSpriteExt(sprite_index, (scrFRSourceFrame() * 0.4), x, y, (image_xscale * right), image_yscale, tilt, c_white, 1);
;
scrFRDrawSpriteExt(spr_glow, (scrFRSourceFrame() * 0.4), x, y, ((image_xscale * 1.5) * right), (image_yscale * 1.5), tilt, c_white, 0.4);
;
}

// Original Weapons/FR_GhostCutlass.wep.gml:355
function fr_Weapons_FR_GhostCutlass_wep_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
; // macro hoisted: current_frame_active
}
