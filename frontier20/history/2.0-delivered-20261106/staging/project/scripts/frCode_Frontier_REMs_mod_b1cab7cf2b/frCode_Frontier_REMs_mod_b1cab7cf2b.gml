#macro frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE "revivable_enemy_mutants"

#macro frMacro_Characters_Frontier_REMs_mod_gml_REM_CONTROLLER (frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE + ".mod controller")

#macro frMacro_Characters_Frontier_REMs_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_REMs"].scr

#macro frMacro_Characters_Frontier_REMs_mod_gml_call scrFRScriptCall

#macro frMacro_Characters_Frontier_REMs_mod_gml_mod_current_type global.fr_module_vars[$ "mod:Frontier_REMs"].mod_current_type

#macro frMacro_Characters_Frontier_REMs_mod_gml_CONTROLLER ((("Frontier_REMs" + ".") + frMacro_Characters_Frontier_REMs_mod_gml_mod_current_type) + " controller")

#macro frMacro_Characters_Frontier_REMs_mod_gml_obj global.fr_module_vars[$ "mod:Frontier_REMs"].obj

#macro frMacro_Characters_Frontier_REMs_mod_gml_animation_end (((image_index + image_speed) >= image_number) || ((image_index + image_speed) < 0))

#macro frMacro_Characters_Frontier_REMs_mod_gml_bbox_center_x (((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + bbox_left) + 1) >> 1)

#macro frMacro_Characters_Frontier_REMs_mod_gml_bbox_center_y (((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + bbox_top) + 1) >> 1)

#macro frMacro_Characters_Frontier_REMs_mod_gml_no_wep ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), wep_none) || scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "")) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && (! scrFRLQSize(scrFRWeaponSlotRead(scrFRSelf(self), "wep")))))

#macro frMacro_Characters_Frontier_REMs_mod_gml_no_bwep ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), wep_none) || scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), "")) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "bwep")) && (! scrFRLQSize(scrFRWeaponSlotRead(scrFRSelf(self), "bwep")))))

#macro frMacro_Characters_Frontier_REMs_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

enum frEnum_Characters_Frontier_REMs_mod_gml_Independence {FOLLOW_CREATOR = (1 << 0), STAY_CLOSE = (1 << 1), HOLD_YOUR_FIRE = (1 << 2), REMAIN_HERE = (1 << 3)}

enum frEnum_Characters_Frontier_REMs_mod_gml_Walk {MIN = 0, MAX = 64}

// Original Characters/Frontier_REMs.mod.gml:1
function fr_Characters_Frontier_REMs_mod_gml___load() {

}

// Original Characters/Frontier_REMs.mod.gml:1
function fr_Characters_Frontier_REMs_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Characters_Frontier_REMs_mod_gml_init_resume, id, scrFROther(other), _args, 19, []);
}
function fr_Characters_Frontier_REMs_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Characters_Frontier_REMs_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Characters/Frontier_REMs.mod.gml:90
{
;
}
_fr.pc=0;
break;
case 2: // Characters/Frontier_REMs.mod.gml:90
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Characters/Frontier_REMs.mod.gml:78
{
if (scrFRModGet("mod", frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE, "ready")) {
{
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_REMs"].mutants), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.rem_mutant_register, frMacro_Characters_Frontier_REMs_mod_gml_mod_current_type, "Frontier_REMs", scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_REMs"].events), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.obj_event_register, scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), scrFRIndexGet(scrFRSelf(self), 2));
;
}
}
if(__fr_break6) break;
}}
global.fr_module_vars[$ "mod:Frontier_REMs"].ready = true;
;
}
}
}
_fr.pc=2;
break;
case 5: // Characters/Frontier_REMs.mod.gml:75
{
;
}
_fr.pc=4;
break;
case 6: // Characters/Frontier_REMs.mod.gml:75
_fr.wait_ticks=max(0,0); _fr.pc=5; return;
break;
case 4: // Characters/Frontier_REMs.mod.gml:74
_fr.pc=(((! scrFRModExists("mod", frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE, "ready")) || (! scrFRModGet("mod", frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE, "ready"))))?6:3;
break;
case 7: // Characters/Frontier_REMs.mod.gml:73
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 0;
break;
case 8: // Characters/Frontier_REMs.mod.gml:31
{
; // macro hoisted: REM_BASE
; // macro hoisted: REM_CONTROLLER
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: mod_current_type
; // macro hoisted: CONTROLLER
; // macro hoisted: obj
; // macro hoisted: animation_end
; // macro hoisted: bbox_center_x
; // macro hoisted: bbox_center_y
; // macro hoisted: no_wep
; // macro hoisted: no_bwep
global.fr_module_vars[$ "mod:Frontier_REMs"].mutants = [["REM_Bubbles", false]];
;
global.fr_module_vars[$ "mod:Frontier_REMs"].ready = false;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].events = [];
;
; // enum hoisted: Independence
; // enum hoisted: Walk
}
_fr.pc=7;
break;
case 9: // Characters/Frontier_REMs.mod.gml:17
scrFRTaskWithNext(_fr);
break;
case 10: // Characters/Frontier_REMs.mod.gml:17
scrFRTaskWithAbort(_fr);
break;
case 11: // Characters/Frontier_REMs.mod.gml:27
{
;
}
_fr.pc=9;
break;
case 12: // Characters/Frontier_REMs.mod.gml:27
_fr.result=undefined; _fr.done=true; return;
break;
case 13: // Characters/Frontier_REMs.mod.gml:23
{
if (scrFRScriptExists(scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), "scr_import")) {
{
scrFRModCall(scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), "scr_import", ["mod", "Frontier_REMs", 0], scrFRIndexGet(scrFRSelf(self), 2));
;
}
}
}
_fr.pc=12;
break;
case 15: // Characters/Frontier_REMs.mod.gml:20
{
;
}
_fr.pc=14;
break;
case 16: // Characters/Frontier_REMs.mod.gml:20
_fr.wait_ticks=max(0,0); _fr.pc=15; return;
break;
case 14: // Characters/Frontier_REMs.mod.gml:19
_fr.pc=((! scrFRScriptExists(scrFRIndexGet(scrFRSelf(_fr.scope), 0), scrFRIndexGet(scrFRSelf(_fr.scope), 1), "scr_import")))?16:13;
break;
case 17: // Characters/Frontier_REMs.mod.gml:18
_fr.pc = (scrFRTaskFork(_fr, 14)) ? 14 : 9;
break;
case 18: // Characters/Frontier_REMs.mod.gml:17
scrFRTaskWithEnter(_fr,scrFRWithValues(_fr.vars._import),17,8);
break;
case 19: // Characters/Frontier_REMs.mod.gml:2
{
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubblesProjectile = sprFR_sprBubblesProjectile_13e6f6109b38;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubblesProjectileBig = sprFR_sprBubblesProjectileBig_eb2fa54916b8;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubblesProjectileTrail = sprFR_sprBubblesTrail_bf53af1d8b06;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubblesProjectileExplosion = sprFR_sprBubblesExplosion_faf187f8be82;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubblesProjectileSpray = sprFR_sprBubblesSprayParticle_d18401307220;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].sprBubbleProjectileNullify = sprFR_sprBubblesProjectileNull_c43fa6d59f02;
;
global.fr_module_vars[$ "mod:Frontier_REMs"].mskBubbleProjectile = sprFR_mskBubblesProjectile_1c6942e66e67;
;
frMacro_Characters_Frontier_REMs_mod_gml_mod_current_type = scrFRIndexGet(["mod", "Frontier_REMs", 0], 0);
;
_fr.vars._import = [["mod", frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE, "scr"]];
;
}
_fr.pc=18;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Characters/Frontier_REMs.mod.gml:94
function fr_Characters_Frontier_REMs_mod_gml_cleanup() {
if (global.fr_module_vars[$ "mod:Frontier_REMs"].ready) {
{
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_REMs"].mutants), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.rem_mutant_deregister, frMacro_Characters_Frontier_REMs_mod_gml_mod_current_type, "Frontier_REMs", scrFRIndexGet(scrFRSelf(self), 0));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_REMs"].events), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.obj_event_deregister, scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), scrFRIndexGet(scrFRSelf(self), 2));
;
}
}
if(__fr_break6) break;
}}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:105
function fr_Characters_Frontier_REMs_mod_gml_game_start() {
if (scrFRModLoaded("mod", "revivable_enemy_mutants")) {
{
frMacro_Characters_Frontier_REMs_mod_gml_obj = scrFRModGet("mod", frMacro_Characters_Frontier_REMs_mod_gml_REM_BASE, "obj");
;
}
}
}

// Original Characters/Frontier_REMs.mod.gml:110
function fr_Characters_Frontier_REMs_mod_gml_REM_Bubbles_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.obj_create, _frl__x, _frl__y, "REM_RevivableMutant")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
frMacro_Characters_Frontier_REMs_mod_gml_call(frMacro_Characters_Frontier_REMs_mod_gml_scr.when_you_fight_the_boss, 8);
;
spr_idle = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprIdle"), 0);
;
spr_walk = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprWalk"), 0);
;
spr_hurt = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprHurt"), 0);
;
spr_dead = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprDead"), 0);
;
spr_fire = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprFire"), 0);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
hitid = [spr_idle, "BUBBLES"];
;
snd_hurt = scrFRModGet("race", "bubbles", "sndBubblesHurt");
;
snd_dead = scrFRModGet("race", "bubbles", "sndBubblesDead");
;
snd_fire = scrFRModGet("race", "bubbles", "sndBubblesLowA");
;
water_breathing = true;
;
bubbles_maxBubbleCharge = 50;
;
bubbles_bubbleCharge = bubbles_maxBubbleCharge;
;
bubbles_bubbleCooldown = 0;
;
bubbles_ultraOrbitalSize = 1;
;
bubbles_ultraOrbitals = [noone, noone, noone];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:139
function fr_Characters_Frontier_REMs_mod_gml_REM_Bubbles_active(_frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_fire);
scrFRMotionAdd(gunangle, (- 3));
speed += (2) * timescale;
bubbles_bubbleCharge -= ((5 * scrFRSourceScale()) + (scrFRGetSkill(mut_throne_butt) * 12));
;
if (scrFRGetSkill(mut_throne_butt)) {
{
bubbles_bubbleCooldown += 5;
;
}
}
{ var __fr_with1 = scrFRWithValues(fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = (_frl__dir + scrFRSourceRandomRange((- 20), 20));
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
scrFRSoundPitchVolume(scrFRSourceChoose(scrFRModGet("race", "bubbles", "sndBubblesSpec"), scrFRModGet("race", "bubbles", "sndBubblesSpec2"), scrFRModGet("race", "bubbles", "sndBubblesSpec3")), scrFRSourceRandomRange(0.8, 1.1), 0.5);
;
scrFRSoundPitchVolume(sndOasisHurt, scrFRSourceRandomRange(0.8, 1.2), 0.4);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:166
function fr_Characters_Frontier_REMs_mod_gml_REM_Bubbles_step() {
var _frl__nearestProjectile = fr_Characters_Frontier_REMs_mod_gml_instance_nearest_array(x, y, scrFRMatchingNE(projectile, "team", team));
;
if (((bubbles_bubbleCooldown <= 0) && (bubbles_bubbleCharge > 0))) {
{
if (((distance_to_object(_frl__nearestProjectile) < 72) && (! collision_line(x, y, _frl__nearestProjectile.x, _frl__nearestProjectile.y, Wall, false, false)))) {
{
fr_Characters_Frontier_REMs_mod_gml_REM_Bubbles_active(point_direction(x, y, _frl__nearestProjectile.x, _frl__nearestProjectile.y));
;
}
}
}
}
if ((bubbles_bubbleCharge < bubbles_maxBubbleCharge)) {
{
bubbles_bubbleCharge += scrFRSourceScale();
;
}
}
if ((bubbles_bubbleCharge > bubbles_maxBubbleCharge)) {
{
bubbles_bubbleCharge = bubbles_maxBubbleCharge;
;
}
}
if ((bubbles_bubbleCharge <= 0)) {
{
bubbles_bubbleCooldown = 75;
;
}
}
if ((bubbles_bubbleCooldown > 0)) {
{
bubbles_bubbleCooldown -= scrFRSourceScale();
;
}
}
if ((scrFRUltraGet("bubbles", 1) > 0)) {
{
if ((((! scrFRInstanceExists(scrFRIndexGet(bubbles_ultraOrbitals, 0))) || (! scrFRInstanceExists(scrFRIndexGet(bubbles_ultraOrbitals, 1)))) || (! scrFRInstanceExists(scrFRIndexGet(bubbles_ultraOrbitals, 2))))) {
{
bubbles_ultraOrbitals = [noone, noone, noone];
scrFRMemberIndexWrite(scrFRSelf(self), "bubbles_ultraOrbitals", [0], fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 0, 19), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "bubbles_ultraOrbitals", [1], fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 120, 19), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "bubbles_ultraOrbitals", [2], fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 240, 19), "=");
;
}
}
if ((bubbles_ultraOrbitalSize < 1)) {
{
bubbles_ultraOrbitalSize += (0.04 * scrFRSourceScale());
;
}
} else {
{
bubbles_ultraOrbitalSize = 1;
;
}
}
if ((bubbles_ultraOrbitalSize < 0)) {
{
bubbles_ultraOrbitalSize = 0;
;
}
}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:215
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_create(_frl__x=undefined, _frl__y=undefined) {
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FishBoost)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 45), 45));
;
image_angle = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
depth = (- 3);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleSprayParticle"), 0));
;
}
}
if(__fr_break3) break;
}}
}
if ((scrFRSourceRandom(3) < 1)) {
{
scrFRInstanceCreate(x, y, Bubble);
}
}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
name = "bubbles_REMbubbleProjectile";
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectile"), 0));
;
mask_index = scrFRModGet("race", "bubbles", "mskBubbleProjectile");
;
spr_bubbletrail = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleTrail"), 0);
;
spr_bubbleexplo = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprSmallBubbleExplosion"), 0);
;
spr_nullify = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileNullify"), 0);
;
spr_burst = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileBurst"), 0);
;
spr_burstbullet = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileBurstBullet"), 0);
;
rotation_speed = (scrFRSourceRandomRange(5, 10) * scrFRSourceScale());
image_speed = (0) * timescale;
image_index = 0;
;
image_xscale = scrFRSourceRandomRange(0.8, 1.3);
;
image_yscale = image_xscale;
;
image_angle = 0;
;
depth = (- 3);
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.05];
;
trailRange = 6;
;
bubble_tiltspeed = scrFRSourceRandomRange(0.17, 0.2);
;
bubble_tiltrange = scrFRSourceRandomRange(35, 50);
;
damage = (1 + (scrFRGetSkill(mut_throne_butt) * 3));
var __fr_other8=scrFROther(other);
team = __fr_other8.team;
;
speed = ((5.5 + scrFRSourceRandomRange(0.8, 2.3))) * timescale;
;
friction = ((0.2 + (scrFRGetSkill(mut_throne_butt) * 0.4))) * (timescale * timescale);
;
ultra_b_charges = 0;
;
ammo_type = (- 1);
;
if (scrFRGetSkill(mut_throne_butt)) {
{
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileBig"), 0));
;
mask_index = mskSuperFlakBullet;
;
friction = (0.1) * (timescale * timescale);
;
speed = ((2.5 + scrFRSourceRandomRange(0.8, 2.3))) * timescale;
;
trailRange = 12;
;
}
}
lifeTime = (scrFRGetSkill(mut_throne_butt) ? 75 : 0);
;
on_projectile = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_nullify;
;
on_anim = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_step = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_step;
;
on_wall = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_wall;
;
on_hit = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_hit;
;
on_destroy = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break7) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:291
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_step() {
image_angle = (0 + (sin((scrFRSourceFrame() * bubble_tiltspeed)) * bubble_tiltrange));
if ((scrFRSourceRandom(25) < scrFRSourceScale())) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- trailRange), trailRange)), (y + scrFRSourceRandomRange((- trailRange), trailRange)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_bubbletrail);
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 4)) * timescale;
;
var __fr_other6=scrFROther(other);
direction = ((__fr_other6.direction + 180) + scrFRSourceRandomRange((- 15), 15));
;
}
}
if(__fr_break3) break;
}}
}
}
if (((speed / timescale) < 2)) {
{
if ((lifeTime > 0)) {
{
lifeTime -= scrFRSourceScale();
;
}
} else {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:314
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_nullify() {
if (scrFRInstanceExists(scrFRSelf(self))) {
{
var _frl_me = scrFRSelf(self);
;
if (((scrFROther(other)).typ > 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
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
if ((scrFRUltraGet("bubbles", 2) > 0)) {
{
ultra_b_charges += 1;
;
}
}
}
}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:330
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileSub_nullify() {
if (scrFRInstanceExists(scrFRSelf(self))) {
{
var _frl_me = scrFRSelf(self);
;
if (((scrFROther(other)).typ > 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
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
}
}

// Original Characters/Frontier_REMs.mod.gml:343
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_wall() {
move_bounce_solid(true);
;
speed *= 0.7;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + (hspeed / timescale)), (y + (vspeed / timescale)), MeleeHitWall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_angle = ((direction + 180) - angle_difference(__fr_other4.direction, (direction + 180)));
image_yscale = scrFRSourceRandomRange(0.5, 0.8);
;
image_speed *= 2;
;
image_index = scrFRSourceIRandom(1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:353
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_hit() {
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
scrFRInstanceDestroy();
;
}

// Original Characters/Frontier_REMs.mod.gml:357
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_destroy() {
if ((ultra_b_charges > 0)) {
{
fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurst_create(x, y, ultra_b_charges);
}
}
scrFRSoundPitchVolume(sndOasisHurt, scrFRSourceRandomRange(0.8, 1.2), 0.1);
;
scrFRSoundPitchVolume(sndOasisExplosionSmall, scrFRSourceRandomRange(0.8, 1.2), 0.2);
;
scrFRSoundPitchVolume(scrFRModGet("race", "bubbles", "sndBubblePop"), scrFRSourceRandomRange(0.5, 1.2), 0.75);
;
repeat (scrFRSourceIRandom(3)) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 1), 1)), (y + scrFRSourceRandomRange((- 1), 1)), Bubble)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprSmallBubbleExplosion"), 0));
;
mask_index = mskSmallExplosion;
;
spr_nullify = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileNullify"), 0);
;
image_speed = (0.4) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.05];
;
ammo_type = (- 1);
;
speed = (0) * timescale;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8.creator;
;
ultra_b_charges = 0;
;
on_projectile = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileSub_nullify;
;
on_wall = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_hit = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
}
}
if(__fr_break6) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:397
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurst_create(_frl__x=undefined, _frl__y=undefined, _frl__charges=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ProjectileBurst";
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_burst);
;
var __fr_other5=scrFROther(other);
spr_burstbullet = __fr_other5.spr_burstbullet;
;
var __fr_other6=scrFROther(other);
spr_bubbleexplo = __fr_other6.spr_bubbleexplo;
;
var __fr_other7=scrFROther(other);
spr_nullify = __fr_other7.spr_nullify;
;
var __fr_other8=scrFROther(other);
spr_bubbletrail = __fr_other8.spr_bubbletrail;
;
image_index = 2;
;
image_speed = (0) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.1];
;
ammo = _frl__charges;
;
burstDelay = 4;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10.creator;
;
on_step = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurst_step;
on_hit = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_wall = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:423
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurst_step() {
image_angle += (10 * scrFRSourceScale());
;
if ((burstDelay > 0)) {
{
burstDelay -= scrFRSourceScale();
;
}
}
if ((ammo > 0)) {
{
if ((burstDelay <= 0)) {
{
scrFRSoundPitchVolume(sndOasisShoot, (1.2 + scrFRSourceRandom(0.2)), 0.7);
var __fr_other1=scrFROther(other);
fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_create(x, y, __fr_other1.spr_burstbullet, __fr_other1.spr_bubbleexplo, __fr_other1.spr_nullify, __fr_other1.spr_bubbletrail);
burstDelay = 2;
;
ammo -= 1;
;
}
}
}
}
if ((ammo <= 0)) {
{
image_xscale -= 0.2;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:447
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined, _frl__spr_explo=undefined, _frl__spr_null=undefined, _frl__spr_trail=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ProjectileBurstBullet";
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
spr_bubbleexplo = _frl__spr_explo;
;
spr_nullify = _frl__spr_null;
;
spr_trail = _frl__spr_trail;
;
image_speed = (0.4) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.1];
;
if (scrFRInstanceExists(enemy)) {
{
var _frl__nearestGuy = instance_nearest(x, y, enemy);
;
if ((! collision_line(x, y, _frl__nearestGuy.x, _frl__nearestGuy.y, Wall, false, false))) {
{
direction = (point_direction(x, y, _frl__nearestGuy.x, _frl__nearestGuy.y) + scrFRSourceRandomRange((- 15), 15));
;
}
} else {
{
direction = scrFRSourceRandom(360);
;
}
}
}
} else {
{
direction = scrFRSourceRandom(360);
;
}
}
mask_index = scrFRModGet("race", "bubbles", "mskBubbleProjectileBurstBullet");
;
damage = 5;
;
speed = ((11 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
image_angle = direction;
;
ultra_b_charges = 0;
;
on_anim = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_step = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_step;
;
on_hit = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_hit;
;
on_wall = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_wall;
;
on_destroy = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectile_destroy;
;
on_projectile = fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileSub_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:487
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_step() {
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + 180) + scrFRSourceRandomRange((- 5), 5));
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:496
function fr_Characters_Frontier_REMs_mod_gml_BubbleProjectileBurstBullet_wall() {
scrFRInstanceDestroy();
;
}

// Original Characters/Frontier_REMs.mod.gml:500
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__angle=undefined, _frl__dist=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ultraOrbital";
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectile"), 0));
;
spr_nullify = scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleProjectileNullify"), 0);
;
image_speed = (0) * timescale;
;
depth = (- 3);
;
var __fr_other4=scrFROther(other);
image_xscale = __fr_other4.bubbles_ultraOrbitalSize;
;
image_yscale = image_xscale;
;
direction = _frl__creator.gunangle;
;
image_angle = _frl__creator.gunangle;
image_alpha = 0.8;
;
speed = (0) * timescale;
;
fr_bloom = [1.2, 0.05];
;
var __fr_other5=scrFROther(other);
ownerid = __fr_other5.id;
;
angle = _frl__angle;
;
dist = _frl__dist;
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
typ = 0;
;
ammo_type = (- 1);
;
prism_duplicate = true;
;
on_wall = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_hit = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_projectile = fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_nullify;
;
on_grenade = fr_Characters_Frontier_REMs_mod_gml_nothing;
;
on_step = fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_step;
;
on_end_step = fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_endstep;
;
on_destroy = fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:540
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_nullify() {
if (((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0)) && (creator.bubbles_ultraOrbitalSize > 0.2))) {
{
var _frl_me = scrFRSelf(self);
;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
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
if (scrFRInstanceExists(creator)) {
{
{ var __fr_with7 = scrFRWithValues(creator), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((bubbles_ultraOrbitalSize > 0)) {
{
bubbles_ultraOrbitalSize -= 0.10;
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Characters/Frontier_REMs.mod.gml:561
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_step() {
if (((! scrFRInstanceExists(creator)) || (! (scrFRUltraGet("bubbles", 1) > 0)))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (frMacro_Characters_Frontier_REMs_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(2) > 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(scrFRModGet("race", "bubbles", "sprBubbleTrail"), 0));
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
image_xscale = creator.bubbles_ultraOrbitalSize;
;
image_yscale = image_xscale;
;
angle += (6 * scrFRSourceScale());
;
direction = angle;
;
image_angle += (12 * scrFRSourceScale());
;
}

// Original Characters/Frontier_REMs.mod.gml:583
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_wall() {
xprevious = (x + (hspeed / timescale));
;
yprevious = (y + (vspeed / timescale));
;
}

// Original Characters/Frontier_REMs.mod.gml:587
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_endstep() {
{ var __fr_with1 = scrFRWithValues(ownerid), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
__fr_other4.xprevious = (x + lengthdir_x(__fr_other4.dist, __fr_other4.angle));
;
var __fr_other5=scrFROther(other);
__fr_other5.yprevious = (y + lengthdir_y(__fr_other5.dist, __fr_other5.angle));
;
var __fr_other6=scrFROther(other);
__fr_other6.x = (x + lengthdir_x(__fr_other6.dist, __fr_other6.angle));
;
var __fr_other7=scrFROther(other);
__fr_other7.y = (y + lengthdir_y(__fr_other7.dist, __fr_other7.angle));
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:595
function fr_Characters_Frontier_REMs_mod_gml_BubbleOrbital_destroy() {
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", ownerid)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Characters/Frontier_REMs.mod.gml:604
function fr_Characters_Frontier_REMs_mod_gml_nothing() {

}

// Original Characters/Frontier_REMs.mod.gml:606
function fr_Characters_Frontier_REMs_mod_gml_instance_nearest_array(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined) {
var _frl__disMax = (1 / 0);
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(_frl__obj, "id", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__dis = point_distance(_frl__x, _frl__y, x, y);
;
if ((_frl__dis < _frl__disMax)) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__nearest;
;
; // macro hoisted: current_frame_active
}
