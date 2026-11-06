#macro frMacro_Objects_Frontier_Palace_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Palace"].scr

#macro frMacro_Objects_Frontier_Palace_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Palace_mod_gml_anim_end (((image_index + image_speed) >= image_number) || ((image_index + image_speed) < 0))

#macro frMacro_Objects_Frontier_Palace_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Palace_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Palace_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Palace_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Palace_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Palace_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Palace_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Palace.mod.gml:1
function fr_Objects_Frontier_Palace_mod_gml___load() {

}

// Original Objects/Frontier_Palace.mod.gml:1
function fr_Objects_Frontier_Palace_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Palace_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Palace_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Palace_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Palace.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Palace", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Palace"].settingLowQualitySerpent = false;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpent = sndFR_sndPalaceSerpent_39c40a52d4aa;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpentRumble = sndFR_sndPalaceSerpentRumble_e5b49313a9a1;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpentWarning = [sndFR_sndPalaceSerpentWarning1_4dc8e3e91d1c, sndFR_sndPalaceSerpentWarning2_7ab5a59c1751, sndFR_sndPalaceSerpentWarning3_9412a2dc3aea];
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockBot = sprFR_sprCrushBlockBot_15508026ed5e;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTop = sprFR_sprCrushBlockTop_218ff560ff1a;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTopOff = sprFR_sprCrushBlockTopOff_e318cbdfdc65;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTopInactive = sprFR_sprCrushBlockTopInactive_b3b372f9222b;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockGameover = sprFR_sprCrushBlock_1c98b8edfb67;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskCrushBlock = sprFR_mskCrushBlock_fba13947193c;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskCrushBlockInner = sprFR_mskCrushBlockInner_cbde01bcd891;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockScorch = sprFR_sprCrushBlockScorch_a7c6ebe80ee9;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockDebris = sprFR_sprCrushBlockDebris_de16d0835d37;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockDestroy = sprFR_sprCrushBlockDestroy_90ef093bd6dd;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].shdProtoCache = sprFR_shdProtoCache_5ecc7c077d40;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheBase = sprFR_sprProtoCacheBase_ae64221eec1b;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh = sprFR_sprProtoCacheLayerHigh_3aba2a35c848;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow = sprFR_sprProtoCacheLayerTopLow_57dc5b5bc542;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid = sprFR_sprProtoCacheLayerTopMid_e15d9b71b35b;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh = sprFR_sprProtoCacheLayerTopHig_053025cd167f;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskBloodFountain = sprFR_mskBloodFountain_5e936fcca1e8;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskBloodFountainPrompt = sprFR_mskBloodFountainPrompt_b6d089653a85;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountain = sprFR_sprBloodFountain_9c8682ce3b6c;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainHurt = sprFR_sprBloodFountainHurt_2dfae1632ca0;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainDead = sprFR_sprBloodFountainDead_36bdd70072c2;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUse = sprFR_sprBloodFountainUse_38119c386383;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUsed = sprFR_sprBloodFountainUsed_ff5bcb7ecc16;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUsedHurt = sprFR_sprBloodFountainUsedHurt_7b137324324e;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodBlossomHarvest = sprFR_sprBloodBlossomHarvest_076d3d7de528;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBurdenSparkle = sprFR_sprBurdenSparkle_37375f9adc8e;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprDarkBloodStreak = sprFR_sprDarkBloodStreak_84f0b4970d2a;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodBlossomPetal = sprFR_sprBloodBlossomPetal_2c2e88d17069;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].shdGupGuardian = sprFR_shdGupGuardian_48ef0da23df8;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskGupGuardian = sprFR_mskGupGuardian_7c564ba8b3a4;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianIdle = sprFR_sprGupGuardianIdle_5e5bcced1320;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianWalk = sprFR_sprGupGuardianWalk_f3459ffe7de8;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianHurt = sprFR_sprGupGuardianHurt_df7167cdae7f;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianDead = sprFR_sprGupGuardianDead_11200924b35b;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianIdle = sprFR_sprGeepGuardianIdle_fe231cc2db1d;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianWalk = sprFR_sprGeepGuardianWalk_bd5d1c8510f6;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianHurt = sprFR_sprGeepGuardianHurt_499177533202;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianDead = sprFR_sprGeepGuardianDead_a460418cd1c2;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianIdle = sprFR_sprGipGuardianIdle_d86195ce10ec;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianWalk = sprFR_sprGipGuardianWalk_39cdc6b7d869;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianHurt = sprFR_sprGipGuardianHurt_46d3b37175df;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianDead = sprFR_sprGipGuardianDead_5a6659b74f46;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskPalaceSerpent = sprFR_mskPalaceSerpent_a0c0c1f7ba23;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentHead = sprFR_sprPalaceSerpentHead_10e2ed60df9d;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentBody = sprFR_sprPalaceSerpentBody_a5e8988be0fd;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentBodyBack = sprFR_sprPalaceSerpentBodyBack_95d27bcfee8f;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentRing = sprFR_sprPalaceSerpentRings_845812de3bdf;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTail = sprFR_sprPalaceSerpentTail_38ada73b2bc6;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprSerpentPath = sprFR_sprPalaceSerpentPath_1c6637bffb36;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTrail = sprFR_sprPalaceSerpentTrail_fa0fdb52b254;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTrail2 = sprFR_sprPalaceSerpentTrail2_309384d4df5e;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentGameover = sprFR_sprPalaceSerpentGameover_1b6b2030c79a;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprLQPalaceSerpent = sprFR_sprLQPalaceSerpent_552f2490cda9;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprTrapPalace = sprFR_sprFlameTrapPalace_5cc2f77e24b2;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprTrapPalaceGameover = sprFR_sprFlameTrapPalaceGameov_c2db67f206f3;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprRadTrapFire = sprFR_sprRadTrapFire_36fefcf161e3;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].mskThroneTeleporter = sprFR_mskThroneTeleporter_05788297eb21;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprThroneTeleporter = sprFR_sprThroneTeleporter_965bd44be8ef;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].sprThroneTeleporterInactive = sprFR_sprThroneTeleporterInact_5fcd9bdcf687;
;
global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache = (- 4);
;
global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound = (- 4);
;
global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble = (- 4);
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Palace.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Palace.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Palace.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Palace.mod.gml:102
function fr_Objects_Frontier_Palace_mod_gml_cleanup() {
if (surface_exists(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache)) {
{
surface_free(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache);
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:110
function fr_Objects_Frontier_Palace_mod_gml_CrushBlock_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CrushBlock";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockBot);
;
spr_top_on = global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTop;
;
spr_top_off = global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTopOff;
;
spr_top_inactive = global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockTopInactive;
;
spr_top = spr_top_off;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockGameover;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskCrushBlockInner;
;
depth = 0;
;
hitid = [spr_gameover, "CRUSH TRAP"];
detect_radius = 240;
;
active = false;
;
moveCooldown = 90;
;
moveCooldownMax = 40;
;
smushCooldown = 0;
;
crushspeed = 6;
;
damage = 8;
;
damage_enemy = 30;
;
typ = 0;
;
solid = true;
;
jailTime = 0;
;
myWallGetReal = 12;
;
myWallisReal = false;
;
mywall = noone;
;
on_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_crushBlock_step];
;
on_end_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_crushBlock_endstep];
;
on_hit = fr_Objects_Frontier_Palace_mod_gml_nothing;
on_wall = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_CrushBlock_wall];
;
on_destroy = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_CrushBlock_destroy];
;
scrFRBindDraw(fr_Objects_Frontier_Palace_mod_gml_CrushBlock_draw, (- 7), scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:157
function fr_Objects_Frontier_Palace_mod_gml_CrushBlock_draw(_frl__block=undefined) {
if ((! scrFRInstanceExists(_frl__block))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
scrFRDrawSpriteExt(_frl__block.spr_top, _frl__block.image_index, _frl__block.x, _frl__block.y, _frl__block.image_xscale, _frl__block.image_yscale, _frl__block.image_angle, _frl__block.image_blend, _frl__block.image_alpha);
}

// Original Objects/Frontier_Palace.mod.gml:166
function fr_Objects_Frontier_Palace_mod_gml_crushBlock_step() {
if ((myWallGetReal > 0)) {
{
myWallGetReal -= scrFRSourceScale();
;
}
}
if ((((myWallGetReal <= 0) && (! scrFRInstanceExists(mywall))) && (myWallisReal == false))) {
{
myWallisReal = true;
;
mywall = fr_Objects_Frontier_Palace_mod_gml_crushBlock_wall_create(scrFRSelf(self));
;
fr_Objects_Frontier_Palace_mod_gml_CrushBlockController_create(x, y, scrFRSelf(self), mywall);
}
}
if (((! scrFRInstanceExists(mywall)) && (myWallisReal == true))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((distance_to_object(Player) < 24)) {
{
jailTime += scrFRSourceScale();
;
}
} else {
{
if ((jailTime > 0)) {
{
jailTime -= (4 * scrFRSourceScale());
;
}
}
}
}
if ((jailTime == 1000)) {
{
{ var __fr_with1 = scrFRWithValues(mywall), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if(__fr_break3) break;
}}
}
}
if (((! active) && (moveCooldown <= 0))) {
{
var _frl_detected = noone;
;
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl_dx = (x - (scrFROther(other)).x);
;
var _frl_dy = (y - (scrFROther(other)).y);
;
var _frl_absx = abs(_frl_dx);
;
var _frl_absy = abs(_frl_dy);
;
var __fr_other7=scrFROther(other);
__fr_other7.mywall.x += 100000;
;
if (((((_frl_absy <= 16) && (_frl_absx <= (scrFROther(other)).detect_radius)) && (! collision_line((scrFROther(other)).x, ((scrFROther(other)).y + 8), x, ((scrFROther(other)).y + 8), Wall, false, false))) && (! collision_line((scrFROther(other)).x, ((scrFROther(other)).y - 8), x, ((scrFROther(other)).y - 8), Wall, false, false)))) {
{
var __fr_other8=scrFROther(other);
__fr_other8.direction = (sign(_frl_dx) ? 0 : 180);
;
_frl_detected = scrFRSelf(self);
;
}
}
if (((((_frl_absx <= 16) && (_frl_absy <= (scrFROther(other)).detect_radius)) && (! collision_line(((scrFROther(other)).x + 8), (scrFROther(other)).y, ((scrFROther(other)).x + 8), y, Wall, false, false))) && (! collision_line(((scrFROther(other)).x - 8), (scrFROther(other)).y, ((scrFROther(other)).x - 8), y, Wall, false, false)))) {
{
var __fr_other9=scrFROther(other);
__fr_other9.direction = (sign(_frl_dy) ? 270 : 90);
;
_frl_detected = scrFRSelf(self);
;
}
}
var __fr_other10=scrFROther(other);
__fr_other10.mywall.x -= 100000;
;
}
}
if(__fr_break6) break;
}}
if ((_frl_detected != noone)) {
{
var __fr_other11=scrFROther(other);
__fr_other11.speed = (crushspeed) * timescale;
;
var __fr_other12=scrFROther(other);
__fr_other12.active = true;
;
scrFRSoundPitchVolume(sndMenuOptions, (1.1 + scrFRSourceRandom(0.1)), 1.2);
;
scrFRSoundPitchVolume(sndNukeFire, (1.6 + scrFRSourceRandom(0.1)), 0.7);
;
}
}
}
}
if ((active == true)) {
{
spr_top = spr_top_on;
;
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), NTTEFullSweat)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
image_blend = make_colour_rgb(190, 253, 8);
;
var __fr_other16=scrFROther(other);
direction = (__fr_other16.direction + 180);
;
}
}
if(__fr_break15) break;
}}
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), Dust)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
var __fr_other20=scrFROther(other);
direction = (__fr_other20.direction + 180);
;
speed = ((1 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break19) break;
}}
}
}
if ((scrFRSourceRandom(8) < 1)) {
{
{ var __fr_with21 = scrFRWithValues(scrFRInstanceCreate(x, y, FRScorchTop)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockScorch);
;
var __fr_other24=scrFROther(other);
image_angle = ((__fr_other24.direction + 90) + scrFRSourceRandomRange((- 4), 4));
;
}
}
if(__fr_break23) break;
}}
}
}
}
} else {
{
spr_top = spr_top_off;
}
}
if ((moveCooldown > 0)) {
{
moveCooldown -= scrFRSourceScale();
;
}
}
if ((smushCooldown > 0)) {
{
smushCooldown -= scrFRSourceScale();
;
}
}
x += hspeed;
;
y += vspeed;
;
var _frl_inst = frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.instances_in_rectangle, ((x - 16) - (speed / timescale)), ((y - 16) - (speed / timescale)), ((x + 16) + (speed / timescale)), ((y + 16) + (speed / timescale)), [hitme, chestprop]);
;
{ var __fr_with25 = scrFRWithValues(_frl_inst), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
if (scrFRInstanceIs(scrFRSelf(self), prop)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
if (((hammerhead > 0) || scrFRGetSkill(mut_hammerhead))) {
{
{ var __fr_with28 = scrFRWithValues((scrFROther(other)).mywall), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
scrFRSoundPitchVolume(sndHammerHeadProc, 0.6, 3);
scrFRSoundPitch(sndHammerHeadEnd, 0.8);
scrFRInstanceDestroy();
;
exit;
;
}
}
if(__fr_break30) break;
}}
}
}
}
}
var _frl_xcollide = false;
;
var _frl_ycollide = false;
;
if (((((scrFROther(other)).hspeed / timescale) != 0) && scrFRPlaceMeeting((x + hspeed), y, (scrFROther(other))))) {
{
_frl_xcollide = true;
;
hspeed = (0) * timescale;
;
}
}
if (((((scrFROther(other)).vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + vspeed), (scrFROther(other))))) {
{
_frl_ycollide = true;
;
vspeed = (0) * timescale;
;
}
}
if (_frl_xcollide) {
{
var _frl_oldX = x;
;
var __fr_other31=scrFROther(other);
x += __fr_other31.hspeed;
;
var __fr_other32=scrFROther(other);
move_outside_solid(__fr_other32.direction, (__fr_other32.speed / timescale));
;
var _frl_newX = (x - (scrFROther(other)).hspeed);
;
if ((_frl_newX != _frl_oldX)) {
{
var __fr_other33=scrFROther(other);
direction = __fr_other33.direction;
;
}
}
}
}
if (_frl_ycollide) {
{
var _frl_oldY = y;
;
var __fr_other34=scrFROther(other);
y += __fr_other34.vspeed;
;
var __fr_other35=scrFROther(other);
move_outside_solid(__fr_other35.direction, (__fr_other35.speed / timescale));
;
var _frl_newY = (y - (scrFROther(other)).vspeed);
;
if ((_frl_newY != _frl_oldY)) {
{
var __fr_other36=scrFROther(other);
direction = __fr_other36.direction;
;
}
}
}
}
}
}
if(__fr_break27) break;
}}
x -= hspeed;
;
y -= vspeed;
;
}

// Original Objects/Frontier_Palace.mod.gml:357
function fr_Objects_Frontier_Palace_mod_gml_crushBlock_endstep() {
if ((! scrFRInstanceExists(mywall))) {
{
exit;
;
}
}
x = (xprevious + hspeed);
;
y = (yprevious + vspeed);
;
xprevious = x;
;
yprevious = y;
;
mywall.x = x;
mywall.y = y;
mywall.xprevious = mywall.x;
;
mywall.yprevious = mywall.y;
;
if (((active == false) && ((speed / timescale) >= 0))) {
{
y = yprevious;
;
y = (round((y / 16)) * 16);
;
x = xprevious;
;
x = (round((x / 16)) * 16);
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:380
function fr_Objects_Frontier_Palace_mod_gml_CrushBlock_wall() {
if (((scrFROther(other)) == mywall)) {
{
xprevious = x;
;
yprevious = y;
;
}
} else {
{
if ((smushCooldown <= 0)) {
{
fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_create(x, y, scrFRSelf(self));
smushCooldown += 1;
;
}
}
speed = (0) * timescale;
;
active = false;
;
moveCooldown = moveCooldownMax;
scrFRViewShakeAt(x, y, 100);
;
scrFRSoundPitchVolume(sndWallBreak, (0.8 + scrFRSourceRandom(0.2)), 1);
;
scrFRSoundPitchVolume(sndMeleeWall, (0.3 + scrFRSourceRandom(0.2)), 1);
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 12), 12)), (y + scrFRSourceRandomRange((- 12), 12)), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 40), 40));
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:414
function fr_Objects_Frontier_Palace_mod_gml_CrushBlock_destroy() {
scrFRSoundPitchVolume(sndGeneratorBreak, 1, 3);
scrFRSoundPitchVolume(sndBigGeneratorBreak, 1.3, 0.3);
scrFRInstanceCreate(x, y, Scorch);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockDestroy);
;
}
}
if(__fr_break3) break;
}}
repeat ((5 + scrFRSourceRandom(3))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprCrushBlockDebris);
;
image_index = scrFRSourceIRandom(image_number);
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
if (scrFRInstanceExists(mywall)) {
{
{ var __fr_with7 = scrFRWithValues(mywall), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:437
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
creator = _frl__creator;
;
damage = creator.damage;
;
damage_enemy = creator.damage_enemy;
;
hitid = creator.hitid;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskCrushBlock;
;
typ = 0;
;
swipswap = false;
;
on_wall = fr_Objects_Frontier_Palace_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_hit;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:452
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_hit() {
if (scrFRInstanceIs((scrFROther(other)), Player)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
}
} else {
{
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage_enemy);
}
}
if ((swipswap == false)) {
{
swipswap = true;
;
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
creator.active = true;
;
creator.speed = (creator.crushspeed) * timescale;
;
creator.direction += 180;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:469
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_step_resume, id, scrFROther(other), _args, 8, []);
}
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Palace_mod_gml_CrushBlockSmush_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Palace.mod.gml:473
{
;
}
_fr.pc=0;
break;
case 2: // Objects/Frontier_Palace.mod.gml:473
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Objects/Frontier_Palace.mod.gml:472
{
scrFRInstanceDestroy();
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Palace.mod.gml:471
{
;
}
_fr.pc=3;
break;
case 5: // Objects/Frontier_Palace.mod.gml:471
_fr.result=undefined; _fr.done=true; return;
break;
case 6: // Objects/Frontier_Palace.mod.gml:471
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 5 : 3;
break;
case 7: // Objects/Frontier_Palace.mod.gml:470
{
;
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Palace.mod.gml:470
_fr.wait_ticks=max(0,1); _fr.pc=7; return;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Palace.mod.gml:475
function fr_Objects_Frontier_Palace_mod_gml_crushBlock_wall_create(_frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__creator.x, _frl__creator.y, Wall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
spr_shadow = mskNone;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskCrushBlock;
;
creator = _frl__creator;
;
image_blend = c_aqua;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:491
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockController_create(_frl__x=undefined, _frl__y=undefined, _frl__block=undefined, _frl__wall=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CrushBlockController";
block = _frl__block;
;
mywall = _frl__wall;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_CrushBlockController_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:500
function fr_Objects_Frontier_Palace_mod_gml_CrushBlockController_step() {
if (((! scrFRInstanceExists(mywall)) && (! scrFRInstanceExists(block)))) {
{
fr_Objects_Frontier_Palace_mod_gml_CrushBlock_destroy();
;
scrFRDelete(scrFRSelf(self));
;
exit;
;
}
}
if ((scrFRInstanceExists(mywall) && (! scrFRInstanceExists(block)))) {
{
fr_Objects_Frontier_Palace_mod_gml_CrushBlock_destroy();
;
{ var __fr_with1 = scrFRWithValues(mywall), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
scrFRDelete(scrFRSelf(self));
;
exit;
;
}
}
x = block.x;
;
y = block.y;
;
}

// Original Objects/Frontier_Palace.mod.gml:522
function fr_Objects_Frontier_Palace_mod_gml_ProtoCache_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ProtoCache";
;
frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_set, "Frontier", "cache_level", (frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_get, "Frontier", "cache_level") + 1));
;
if ((frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_get, "Frontier", "cache_level") > 15)) {
{
frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_set, "Frontier", "cache_level", 15);
;
}
}
cacheValue = frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_get, "Frontier", "cache_level");
if ((cacheValue <= 0)) {
{
cacheValue = 1;
;
}
}
sprite_index = scrFRAreaSourceSprite(mskNone);
;
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Palace"].shdProtoCache;
;
spr_shadow_y = (- 12);
layerAngle = 0;
;
mytext = "OPEN?";
extraSpeen = 0;
;
layerCount = ceil((cacheValue / 3));
layerSprites = [global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh, global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh, global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh, global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh, global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerHigh];
if ((cacheValue <= 3)) {
{
if ((cacheValue == 1)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [0], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow, "=");
;
}
}
if ((cacheValue == 2)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [0], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid, "=");
;
}
}
if ((cacheValue == 3)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [0], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh, "=");
;
}
}
}
}
if ((cacheValue <= 6)) {
{
if ((cacheValue == 4)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [1], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow, "=");
;
}
}
if ((cacheValue == 5)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [1], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid, "=");
;
}
}
if ((cacheValue == 6)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [1], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh, "=");
;
}
}
}
}
if ((cacheValue <= 9)) {
{
if ((cacheValue == 7)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [2], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow, "=");
;
}
}
if ((cacheValue == 8)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [2], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid, "=");
;
}
}
if ((cacheValue == 9)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [2], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh, "=");
;
}
}
}
}
if ((cacheValue <= 12)) {
{
if ((cacheValue == 10)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [3], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow, "=");
;
}
}
if ((cacheValue == 11)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [3], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid, "=");
;
}
}
if ((cacheValue == 12)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [3], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh, "=");
;
}
}
}
}
if ((cacheValue <= 15)) {
{
if ((cacheValue == 13)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [4], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopLow, "=");
;
}
}
if ((cacheValue == 14)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [4], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopMid, "=");
;
}
}
if ((cacheValue == 15)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "layerSprites", [4], global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheLayerTopHigh, "=");
;
}
}
}
}
layerTop = layerCount;
;
layerTop_y = [0, 12, 20, 28, 36, 44];
;
mask_index = mskNone;
;
prompt = noone;
;
openCheck = false;
opened = false;
;
lootDelay = 60;
;
loot = 0;
;
lootRewards = [];
;
on_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_ProtoCache_step];
;
on_draw = fr_Objects_Frontier_Palace_mod_gml_ProtoCache_draw;
;
on_cleanup = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_ProtoCache_cleanup];
;
on_alrm2 = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_ProtoCache_alrm2];
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Palace_mod_gml_ProtoCachePrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprProtoCacheBase);
;
mask_index = mskNone;
;
image_speed = (0) * timescale;
;
depth = 6;
;
speed = (0) * timescale;
;
}
}
if(__fr_break10) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:617
function fr_Objects_Frontier_Palace_mod_gml_ProtoCachePrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
opened = true;
;
frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_set, "Frontier", "caches_opened", (frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_get, "Frontier", "caches_opened") + 1));
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
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:631
function fr_Objects_Frontier_Palace_mod_gml_ProtoCache_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Palace_mod_gml_alarm2_run)) {
exit;
}
if ((distance_to_object(Torch) < 20)) {
{
{ var __fr_with1 = scrFRWithValues(instance_nearest(x, y, Torch)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((opened == false)) {
{
layerAngle += (1.5 * scrFRSourceScale());
;
}
}
if ((opened == true)) {
{
if ((extraSpeen < 20)) {
{
extraSpeen += 0.4;
;
}
}
layerAngle += (extraSpeen * scrFRSourceScale());
;
if (frMacro_Objects_Frontier_Palace_mod_gml_current_frame_active) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y - scrFRIndexGet(layerTop_y, layerTop)), PlasmaTrail)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(sprEatBigRad, sprEatRad));
direction = (90 + scrFRSourceRandomRange((- 40), 40));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
depth = (- 10);
;
}
}
if(__fr_break6) break;
}}
}
}
if ((lootDelay > 0)) {
{
lootDelay -= scrFRSourceScale();
;
}
} else {
{
if ((openCheck == false)) {
{
openCheck = true;
;
frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.save_set, "Frontier", "cache_level", 0);
;
scrFRAlarmWrite(scrFRSelf(self), 2, 10, "=");
;
var _frl__cacheLoot_rads = (20 + (20 * cacheValue));
var _frl__cacheLoot_ammo = (cacheValue * 2);
var _frl__cacheLoot_health = cacheValue;
var _frl__cacheLoot_weapon = (cacheValue / 1.5);
var _frl__cacheLoot_maxRads = (cacheValue / 5);
var _frl__cacheLoot_maxAmmo = (cacheValue / 5);
var _frl__cacheLoot_maxHealth = (cacheValue / 5);
if ((cacheValue >= 11)) {
{
repeat (_frl__cacheLoot_maxHealth) {
array_push(lootRewards, "MaxHealthPickup_create");
;
}
}
}
if ((cacheValue >= 9)) {
{
repeat ((_frl__cacheLoot_maxAmmo + scrFRSourceIRandom((_frl__cacheLoot_maxAmmo / 5)))) {
array_push(lootRewards, "MaxAmmoPickup_create");
;
}
}
}
if ((cacheValue >= 6)) {
{
repeat ((_frl__cacheLoot_maxRads + scrFRSourceIRandom((_frl__cacheLoot_maxRads / 3)))) {
array_push(lootRewards, "MaxRadPickup_create");
;
}
}
}
if ((cacheValue >= 3)) {
{
repeat ((_frl__cacheLoot_weapon + scrFRSourceIRandom((_frl__cacheLoot_weapon / 3)))) {
array_push(lootRewards, WeaponChest);
;
if (((cacheValue > 7) && (scrFRSourceRandom(3) < 1))) {
{
array_push(lootRewards, BigWeaponChest);
;
}
}
}
repeat ((_frl__cacheLoot_ammo + scrFRSourceIRandom((_frl__cacheLoot_ammo / 3)))) {
array_push(lootRewards, AmmoPickup);
;
}
}
}
repeat ((_frl__cacheLoot_health + scrFRSourceIRandom((_frl__cacheLoot_health / 2)))) {
array_push(lootRewards, HPPickup);
;
if (((cacheValue > 6) && (scrFRSourceRandom(3) < 1))) {
{
array_push(lootRewards, HealthChest);
;
}
}
}
repeat ((_frl__cacheLoot_ammo + scrFRSourceIRandom((_frl__cacheLoot_ammo / 3)))) {
array_push(lootRewards, AmmoPickup);
;
}
loot = array_length(lootRewards);
;
scrFRSoundPitchVolume(sndBigGeneratorBreak, 1.6, 1);
;
scrFRSoundPitchVolume(sndPillarBreak, 1.2, 1);
;
scrFRSoundPitchVolume(sndBigWeaponChest, 1.2, 1);
;
scrFRSoundPitchVolume(sndMutLastWish, 0.8, 3);
;
if ((_frl__cacheLoot_rads < 100)) {
{
repeat (_frl__cacheLoot_rads) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Rad)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
} else {
{
repeat ((_frl__cacheLoot_rads / 8)) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, BigRad)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
;
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
}
}
}

// Original Objects/Frontier_Palace.mod.gml:764
function fr_Objects_Frontier_Palace_mod_gml_ProtoCache_alrm2() {
if ((loot > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
var _frl__lootObject = scrFRIndexGet(lootRewards, (loot - 1));
if (is_string(_frl__lootObject)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Pickups", _frl__lootObject, x, (y - scrFRIndexGet(layerTop_y, layerTop)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
zspeed = 7;
;
zfriction = 0.7;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
var __fr_other8=scrFROther(other);
depth = __fr_other8.depth;
;
var __fr_other9=scrFROther(other);
mask_index = __fr_other9.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other10=scrFROther(other);
spr_shadow_y = __fr_other10.spr_shadow_y;
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}
} else {
{
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, (y - scrFRIndexGet(layerTop_y, (layerTop - 1))), _frl__lootObject)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
{ var __fr_with14 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
zspeed = 7;
;
zfriction = 0.7;
;
var __fr_other17=scrFROther(other);
creator = __fr_other17;
;
var __fr_other18=scrFROther(other);
depth = __fr_other18.depth;
;
var __fr_other19=scrFROther(other);
mask_index = __fr_other19.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other20=scrFROther(other);
spr_shadow_y = __fr_other20.spr_shadow_y;
;
}
}
}
}
if(__fr_break16) break;
}}
}
}
if(__fr_break13) break;
}}
}
}
if (((-- loot) <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 40, "=");
;
}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 8, "=");
;
layerTop -= 1;
;
{ var __fr_with21 = scrFRWithValues(scrFRInstanceCreate(x, ((y - scrFRIndexGet(layerTop_y, layerTop)) - 8), PlasmaTrail)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
sprite_index = scrFRAreaSourceSprite(sprGreenExplosion);
;
}
}
if(__fr_break23) break;
}}
scrFRSoundPitchVolume(sndExplosionS, (0.7 + scrFRSourceRandom(0.2)), 1);
;
if (((-- layerCount) <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:821
function fr_Objects_Frontier_Palace_mod_gml_ProtoCache_draw() {
scrFRDrawSpriteExt(spr_shadow, 0, x, (y + spr_shadow_y), 1, 1, 0, c_white, 0.3);
if ((! surface_exists(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache))) {
{
global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache = surface_create(view_width, view_height);
}
}
surface_set_target(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache);
var _frl_ns_x = scrFRViewCoordinate(0);
;
var _frl_ns_y = scrFRViewCoordinate(1);
;
var _frl_stack = 1;
;
var _frl_height = 8;
;
draw_clear_alpha(c_white, 0);
{
var _frl_i = 0;
for (; (_frl_i <= _frl_height); _frl_i++) {
{
var _frl_s = 1;
for (; (_frl_s <= _frl_stack); _frl_s++) {
var _frl_o = ((_frl_s - 1) / _frl_stack);
;
if ((layerCount >= 1)) {
{
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(scrFRIndexGet(layerSprites, 0))); _frl_i++) {
scrFRDrawSpriteExt(scrFRIndexGet(layerSprites, 0), _frl_i, (x - _frl_ns_x), (((y - (_frl_i - _frl_o)) - scrFRIndexGet(layerTop_y, 1)) - _frl_ns_y), image_xscale, image_yscale, (layerAngle + direction), image_blend, image_alpha);
;
}
}
}
}
if ((layerCount >= 2)) {
{
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(scrFRIndexGet(layerSprites, 0))); _frl_i++) {
scrFRDrawSpriteExt(scrFRIndexGet(layerSprites, 1), _frl_i, (x - _frl_ns_x), (((y - (_frl_i - _frl_o)) - scrFRIndexGet(layerTop_y, 2)) - _frl_ns_y), image_xscale, image_yscale, (((- layerAngle) + direction) + 180), image_blend, image_alpha);
;
}
}
}
}
if ((layerCount >= 3)) {
{
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(scrFRIndexGet(layerSprites, 0))); _frl_i++) {
scrFRDrawSpriteExt(scrFRIndexGet(layerSprites, 2), _frl_i, (x - _frl_ns_x), (((y - (_frl_i - _frl_o)) - scrFRIndexGet(layerTop_y, 3)) - _frl_ns_y), image_xscale, image_yscale, (layerAngle + direction), image_blend, image_alpha);
;
}
}
}
}
if ((layerCount >= 4)) {
{
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(scrFRIndexGet(layerSprites, 0))); _frl_i++) {
scrFRDrawSpriteExt(scrFRIndexGet(layerSprites, 3), _frl_i, (x - _frl_ns_x), (((y - (_frl_i - _frl_o)) - scrFRIndexGet(layerTop_y, 4)) - _frl_ns_y), image_xscale, image_yscale, (((- layerAngle) + direction) + 180), image_blend, image_alpha);
;
}
}
}
}
if ((layerCount >= 5)) {
{
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(scrFRIndexGet(layerSprites, 0))); _frl_i++) {
scrFRDrawSpriteExt(scrFRIndexGet(layerSprites, 4), _frl_i, (x - _frl_ns_x), (((y - (_frl_i - _frl_o)) - scrFRIndexGet(layerTop_y, 5)) - _frl_ns_y), image_xscale, image_yscale, (layerAngle + direction), image_blend, image_alpha);
;
}
}
}
}
}
}
}
}
surface_reset_target();
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache, (_frl_ns_x + 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache, (_frl_ns_x - 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache, _frl_ns_x, (_frl_ns_y + 1), 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache, _frl_ns_x, (_frl_ns_y - 1), 1, 1, 0, c_black, 1);
draw_surface(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache, _frl_ns_x, _frl_ns_y);
}

// Original Objects/Frontier_Palace.mod.gml:882
function fr_Objects_Frontier_Palace_mod_gml_ProtoCache_cleanup() {
if (surface_exists(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache)) {
{
surface_free(global.fr_module_vars[$ "mod:Frontier_Palace"].surfaceProtoCache);
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:887
function fr_Objects_Frontier_Palace_mod_gml_BloodFountain_create(_frl__x=undefined, _frl__y=undefined, _frl__level=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BloodFountain";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountain;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainDead;
;
spr_use = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUse;
;
spr_used = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUsed;
;
spr_hurt_used = global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodFountainUsedHurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskBloodFountain;
;
snd_hurt = sndHitRock;
;
snd_dead = sndPillarBreak;
;
activated = false;
;
mytext = loc("Frontier:BloodFountainPrompt", "@wHARVEST?#@sMORE @wENEMIES#@sLESS @gRADS");
;
burden_text = loc("Frontier:BloodFountainText:0", "BURDENED WITH");
;
burden_subtext = loc("Frontier:BloodFountainText:1", "BLOSSOMING#BLOODSHED");
;
pick = (- 1);
;
scrFRMaxHealthWrite(id, 60, "=");
;
hp = max_hp;
;
VAGGYBONDESPLSNOSHOOT = true;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_BloodFountain_step;
;
on_hurt = fr_Objects_Frontier_Palace_mod_gml_Prop_hurt;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskBloodFountainPrompt;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_BloodFountainPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:928
function fr_Objects_Frontier_Palace_mod_gml_BloodFountainPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = 1;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
if ((creator.activated == true)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:941
function fr_Objects_Frontier_Palace_mod_gml_BloodFountain_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Objects_Frontier_Palace_mod_gml_anim_end) {
{
if ((spr_idle == spr_use)) {
{
spr_idle = spr_used;
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if (((pick != (- 1)) && (activated == false))) {
{
activated = true;
;
image_index = 0;
;
spr_idle = spr_use;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_hurt = spr_hurt_used;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - 6), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodBlossomHarvest);
;
depth = (- 5);
;
}
}
if(__fr_break3) break;
}}
repeat (5) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprDarkBloodStreak);
;
image_index = scrFRSourceIRandom(1);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break6) break;
}}
}
repeat (12) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Feather)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprBloodBlossomPetal);
;
image_index = scrFRSourceIRandom(2);
;
image_speed = (0) * timescale;
;
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth - 1);
;
fall = (30 + scrFRSourceIRandom(20));
;
speed = ((4 + scrFRSourceRandom(3))) * timescale;
;
friction = (0.05) * (timescale * timescale);
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break9) break;
}}
}
scrFRSetSkill("BurdenBlood", 1);
scrFRSoundPitchVolume(sndStrongSpiritLost, 0.7, 1);
scrFRSoundPitchVolume(sndBloodCannon, 1.2, 1);
{ var __fr_with11 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "SpecialPopupText_create", x, (y - 40), burden_text, burden_subtext)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
sub_color = make_colour_rgb(156, 17, 17);
;
sub_sound = sndCursedReminder;
;
}
}
if(__fr_break13) break;
}}
scrFRModCall("mod", "Frontier_Objects", "SpecialPopupTextJinkies_create", (x + 35), (y - 25));
;
{ var __fr_with14 = scrFRWithValues(Player), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
image_blend = make_colour_rgb(136, 86, 180);
;
depth = (- 3);
;
}
}
if(__fr_break19) break;
}}
repeat (8) { var __fr_with20 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), BulletHit)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprBurdenSparkle);
;
image_index = scrFRSourceChoose(0, 1);
;
image_xscale = scrFRSourceRandomRange(0.5, 1);
;
image_yscale = image_xscale;
;
direction = (90 + scrFRSourceRandomRange((- 32), 32));
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break22) break;
}}
}
}
if(__fr_break16) break;
}}
}
}
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with23 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
var __fr_other26=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other26.spr_dead);
;
var __fr_other27=scrFROther(other);
image_xscale = __fr_other27.image_xscale;
;
var __fr_other28=scrFROther(other);
size = __fr_other28.size;
;
}
}
if(__fr_break25) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1033
function fr_Objects_Frontier_Palace_mod_gml_GupGuardian_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Splitter Guardian";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGupGuardianDead;
;
sprite_index = scrFRAreaSourceSprite(spr_walk);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
image_index = scrFRSourceRandom(7);
;
hitid = [spr_idle, "SPLITTER GUARDIAN"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Palace"].shdGupGuardian;
;
spr_shadow_y = 19;
;
fr_glow = [48, 64];
;
nts_color_blood = [make_color_rgb(190, 253, 8), c_lime];
snd_hurt = sndDogGuardianHurt;
;
snd_mele = sndDogGuardianMelee;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskGupGuardian;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 100, "=");
;
hp = max_hp;
;
raddrop = 12;
;
maxspeed = (1.3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
canmelee = 1;
;
meleedamage = 6;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gupwalk = 0;
;
jumpframego = 2;
;
jumpframestop = 7;
;
size = 3;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GupGuardian_step];
;
on_draw = fr_Objects_Frontier_Palace_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Palace_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Palace_mod_gml_GupGuardian_death;
;
on_alrm1 = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GupGuardian_alrm1];
;
scrFRInstanceCreate(x, y, PortalClear);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1092
function fr_Objects_Frontier_Palace_mod_gml_GupGuardian_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm0") and frMacro_Objects_Frontier_Palace_mod_gml_alarm0_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Palace_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((scrFRInstanceExists(target) and frMacro_Objects_Frontier_Palace_mod_gml_target_visible)) {
{
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_walk);
}
}
if (((image_index > jumpframego) and (image_index < jumpframestop))) {
{
scrFRMotionAdd((direction - (angle_difference(direction, point_direction(x, y, target.x, target.y)) * 0.3)), walkspeed);
;
fr_Objects_Frontier_Palace_mod_gml_enemy_face(direction);
;
}
}
}
}
if ((gupwalk > 0)) {
{
gupwalk -= scrFRSourceScale();
;
if (((image_index > jumpframego) and (image_index < jumpframestop))) {
{
scrFRMotionAdd(direction, (walkspeed / 2));
;
fr_Objects_Frontier_Palace_mod_gml_enemy_face(direction);
;
if ((gupwalk == 1)) {
{
gupwalk = 2;
}
}
}
}
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Palace_mod_gml_enemy_sprite);
;
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Palace.mod.gml:1130
function fr_Objects_Frontier_Palace_mod_gml_GupGuardian_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(5)), "=");
;
if ((fr_Objects_Frontier_Palace_mod_gml_chance(1, 4) && ((! scrFRInstanceExists(target)) || (! frMacro_Objects_Frontier_Palace_mod_gml_target_visible)))) {
{
direction = scrFRSourceRandom(360);
;
gupwalk += scrFRAlarmRead(scrFRSelf(self), 1);
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1139
function fr_Objects_Frontier_Palace_mod_gml_GupGuardian_death() {
scrFRInstanceCreate(x, y, PortalClear);
scrFRPickupDrop(40, 5);
;
scrFRSoundPitch(sndExploGuardianDeadCharge, scrFRSourceRandomRange(0.7, 0.8));
repeat (4) {
fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_create(x, y);
}
}

// Original Objects/Frontier_Palace.mod.gml:1147
function fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Splitter Guardian";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGeepGuardianDead;
;
sprite_index = scrFRAreaSourceSprite(spr_walk);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
image_index = scrFRSourceRandom(7);
;
depth = (- 2);
;
hitid = [spr_idle, "SPLITTER GUARDIAN"];
spr_shadow = shd48;
;
spr_shadow_y = 8;
;
fr_glow = [28, 44];
;
nts_color_blood = [make_color_rgb(190, 253, 8), c_lime];
snd_hurt = sndExploGuardianHurt;
;
snd_mele = sndDogGuardianMelee;
;
mask_index = mskExploGuardian;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 25, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (1.7) * timescale;
;
walkspeed = (maxspeed / timescale);
;
canmelee = 1;
;
meleedamage = 4;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gupwalk = 0;
;
jumpframego = 2;
;
jumpframestop = 7;
;
size = 2;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GupGuardian_step];
;
on_draw = fr_Objects_Frontier_Palace_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Palace_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_death;
;
on_alrm1 = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1205
function fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(5)), "=");
;
if ((fr_Objects_Frontier_Palace_mod_gml_chance(1, 3) && ((! scrFRInstanceExists(target)) || (! frMacro_Objects_Frontier_Palace_mod_gml_target_visible)))) {
{
direction = scrFRSourceRandom(360);
;
gupwalk += scrFRAlarmRead(scrFRSelf(self), 1);
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1213
function fr_Objects_Frontier_Palace_mod_gml_GeepGuardian_death() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.8;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
repeat (4) {
fr_Objects_Frontier_Palace_mod_gml_GipGuardian_create(x, y);
}
scrFRPickupDrop(10, 0);
;
scrFRSoundPitch(sndExploGuardianDeadCharge, scrFRSourceRandomRange(1, 1.1));
}

// Original Objects/Frontier_Palace.mod.gml:1226
function fr_Objects_Frontier_Palace_mod_gml_GipGuardian_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Splitter Guardian";
whocouldibe = "GipGuardian";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Palace"].sprGipGuardianDead;
;
sprite_index = scrFRAreaSourceSprite(spr_walk);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
image_index = scrFRSourceRandom(7);
;
depth = (- 2);
;
hitid = [spr_idle, "SPLITTER GUARDIAN"];
spr_shadow = shd24;
;
spr_shadow_y = 0.5;
;
fr_glow = [16, 32];
;
nts_color_blood = [make_color_rgb(190, 253, 8), c_lime];
snd_hurt = sndGuardianHurt;
;
snd_dead = sndGuardianDead;
;
snd_mele = sndDogGuardianMelee;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 6, "=");
;
hp = max_hp;
;
raddrop = 2;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
canmelee = 1;
;
meleedamage = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gupwalk = 0;
;
jumpframego = 2;
;
jumpframestop = 7;
;
size = 1;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GupGuardian_step];
;
on_draw = fr_Objects_Frontier_Palace_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Palace_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Palace_mod_gml_GipGuardian_death;
;
on_alrm1 = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_GipGuardian_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1285
function fr_Objects_Frontier_Palace_mod_gml_GipGuardian_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(5)), "=");
;
if ((fr_Objects_Frontier_Palace_mod_gml_chance(1, 3) && ((! scrFRInstanceExists(target)) || (! frMacro_Objects_Frontier_Palace_mod_gml_target_visible)))) {
{
direction = scrFRSourceRandom(360);
;
gupwalk += scrFRAlarmRead(scrFRSelf(self), 1);
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1293
function fr_Objects_Frontier_Palace_mod_gml_GipGuardian_death() {
speed = (max(3)) * timescale;
;
scrFRPickupDrop(3, 0);
;
}

// Original Objects/Frontier_Palace.mod.gml:1297
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PalaceSerpentSpawn";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
on_step = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentSpawner_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1308
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentSpawner_step() {
if ((! scrFRInstanceExists(Player))) {
{
scrFRDelete(scrFRSelf(self));
;
exit;
;
}
}
var _frl_who2kill = frMacro_Objects_Frontier_Palace_mod_gml_call(frMacro_Objects_Frontier_Palace_mod_gml_scr.instance_random, Player);
fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_create(_frl_who2kill.x, _frl_who2kill.y);
scrFRDelete(scrFRSelf(self));
;
}

// Original Objects/Frontier_Palace.mod.gml:1317
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PalaceSerpent";
spr_head = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentHead;
;
spr_body = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentBody;
;
spr_body_back = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentBodyBack;
;
spr_tail = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTail;
;
spr_ring = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentRing;
;
spr_telegraph = global.fr_module_vars[$ "mod:Frontier_Palace"].sprSerpentPath;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentGameover;
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
image_alpha = 1;
;
image_xscale = 1;
;
image_yscale = 1;
;
direction = scrFRSourceChoose(0, 180);
;
if ((direction == 180)) {
{
image_yscale = (- 1);
;
}
}
image_angle = direction;
;
depth = (- 11);
;
telegraph_alpha = 0;
;
hitid = [spr_gameover, "SERPENT"];
segments = 50;
tail_segments = 1;
;
segment_dis = ((direction == 180) ? 46 : (- 46));
;
doTrail = true;
;
team = 1;
;
lifetime = 300;
;
striked = false;
;
wentBy = false;
;
didit = false;
;
telegraph_real = false;
;
serpent_dis = (- 1800);
;
serpent_speed = 24;
;
serpent_x = (x + lengthdir_x(serpent_dis, direction));
;
serpent_y = y;
;
myHitbox = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_create((x + lengthdir_x(serpent_dis, direction)), y, hitid, serpent_speed, ((direction == 180) ? "left" : "right"));
;
nearestX = x;
;
nearestY = y;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_step;
;
on_end_step = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_endstep;
on_draw = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_draw;
;
on_destroy = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_destroy;
;
if ((global.fr_module_vars[$ "mod:Frontier_Palace"].settingLowQualitySerpent == false)) {
{
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth - 1), ((32 * image_yscale) * (- 1)), 14);
;
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth - 1), ((19 * image_yscale) * (- 1)), 14);
;
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth - 1), ((6 * image_yscale) * (- 1)), 14);
;
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth + 1), ((32 * image_yscale) * (- 1)), (- 28));
;
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth + 1), ((19 * image_yscale) * (- 1)), (- 28));
;
fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(serpent_x, serpent_y, scrFRSelf(self), (depth + 1), ((6 * image_yscale) * (- 1)), (- 28));
;
}
} else {
{
on_draw = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentLQ_draw;
;
spr_body = global.fr_module_vars[$ "mod:Frontier_Palace"].sprLQPalaceSerpent;
;
doTrail = false;
;
}
}
scrFRSoundPitchVolume(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpentWarning, scrFRSourceIRandom(2)), (0.9 + scrFRSourceRandom(0.1)), 2);
;
global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble = scrFRSoundLoop(global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpentRumble);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble, 0);
;
scrFRSoundPosition(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble, scrFRSourceRandom(14));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1391
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_step() {
serpent_dis += (scrFRSourceScale() * serpent_speed);
;
serpent_x = (x + lengthdir_x(serpent_dis, direction));
;
if ((! scrFRInstanceExists(myHitbox))) {
{
myHitbox = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_create((x + lengthdir_x(serpent_dis, direction)), y, hitid, serpent_speed, ((direction == 180) ? "left" : "right"));
;
}
}
if (((telegraph_alpha <= 1) && (telegraph_real == false))) {
{
telegraph_alpha += (0.1 * scrFRSourceScale());
;
if ((telegraph_alpha >= 1)) {
{
telegraph_real = true;
;
}
}
}
}
if ((serpent_dis > (- 420))) {
{
wentBy = true;
if ((telegraph_alpha > 0)) {
{
telegraph_alpha -= 0.1;
;
}
}
}
}
if ((scrFRInstanceExists(Player) && (serpent_dis < 100))) {
{
var _frl__dis = distance_to_object(myHitbox);
var _frl__rumbleVol = ((2000 - _frl__dis) / 2000);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble, clamp((1 * _frl__rumbleVol), 0, 10));
;
}
} else {
{
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble, 0);
;
}
}
if (doTrail) {
{
if (frMacro_Objects_Frontier_Palace_mod_gml_current_frame_active) {
{
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((serpent_x + scrFRSourceRandom(((- 2300) * image_yscale))), (serpent_y + scrFRSourceRandomRange((- 20), 20)), CaveSparkle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTrail, global.fr_module_vars[$ "mod:Frontier_Palace"].sprPalaceSerpentTrail2));
;
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + 180) + scrFRSourceRandomRange((- 45), 45));
;
image_angle = scrFRSourceRandom(360);
;
speed = (5) * timescale;
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
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1451
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_endstep() {
scrFRBindDraw(fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentTelegraph_draw, 0, spr_telegraph, x, y, image_angle, telegraph_alpha);
}

// Original Objects/Frontier_Palace.mod.gml:1454
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_draw() {
var _frl__segmentX = 0;
var _frl__segmentBackX = 0;
var _frl__segOff = 20;
var _frl__segSpeed = 15;
var _frl__segCap = 24;
var _frl__ringX = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < segments); _frl_i++) {
var _frl__sprite = spr_body_back;
var _frl__segmentY = ((dsin(((scrFRSourceFrame() * _frl__segSpeed) + (_frl_i * _frl__segOff))) * _frl__segCap) - (_frl__segCap / 2));
scrFRDrawSpriteExt(_frl__sprite, 0, (serpent_x + _frl__segmentBackX), (serpent_y + _frl__segmentY), (1 * (image_yscale * (- 1))), 1, 0, c_white, 1);
;
_frl__segmentBackX += segment_dis;
;
}
}
{
var _frl_i = 0;
for (; (_frl_i < (segments + tail_segments)); _frl_i++) {
var _frl__sprite = ((_frl_i >= segments) ? spr_tail : spr_body);
var _frl__segmentY = ((dsin(((scrFRSourceFrame() * _frl__segSpeed) + (_frl_i * _frl__segOff))) * _frl__segCap) - (_frl__segCap / 2));
scrFRDrawSpriteExt(_frl__sprite, ((_frl_i * 4.4) + (scrFRSourceFrame() * 0.4)), (serpent_x + _frl__segmentX), (serpent_y + _frl__segmentY), (1 * (image_yscale * (- 1))), 1, 0, c_white, 1);
;
_frl__segmentX += segment_dis;
;
}
}
{
var _frl_i = 0;
for (; (_frl_i < segments); _frl_i++) {
var _frl__segmentY = ((dsin(((scrFRSourceFrame() * _frl__segSpeed) + (_frl_i * _frl__segOff))) * _frl__segCap) - (_frl__segCap / 2));
if ((((_frl_i mod 5) == 0) && (_frl_i != 0))) {
{
scrFRDrawSpriteExt(spr_ring, ((scrFRSourceFrame() * 0.8) + _frl_i), (serpent_x + _frl__ringX), (serpent_y + _frl__segmentY), (((_frl_i % 3) == 1) ? (- 1) : 1), 1, 0, c_white, 1);
;
}
}
_frl__ringX += segment_dis;
;
}
}
var _frl__headY = ((dsin((scrFRSourceFrame() * _frl__segSpeed)) * _frl__segCap) - (_frl__segCap / 2));
scrFRDrawSpriteExt(spr_head, (scrFRSourceFrame() * 0.4), serpent_x, ((serpent_y + _frl__headY) - 16), image_xscale, image_yscale, image_angle, c_white, image_alpha);
;
}

// Original Objects/Frontier_Palace.mod.gml:1491
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentTelegraph_draw(_frl__spr_telegraph=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__alpha=undefined) {
scrFRDrawSpriteExt(_frl__spr_telegraph, scrFRSourceFrame(), _frl__x, _frl__y, 1, 1, _frl__angle, c_white, _frl__alpha);
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Palace.mod.gml:1495
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentLQ_draw() {
scrFRDrawSpriteExt(spr_body, 0, serpent_x, serpent_y, image_yscale, 1, 0, c_white, 1);
;
}

// Original Objects/Frontier_Palace.mod.gml:1498
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpent_destroy() {
{ var __fr_with1 = scrFRWithValues(myHitbox), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
if (array_length((scrFRMatching(FRCustomObject, "name", "fr_PalaceSerpent") == 1))) {
{
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound);
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble);
;
}
}
if ((! scrFRInstanceExists(Player))) {
{
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound);
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSoundRumble);
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1511
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__hitid=undefined, _frl__serp_speed=undefined, _frl__serp_dir=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SerpentHitbox";
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskPalaceSerpent;
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
depth = (- 100);
team = 1;
;
hitid = _frl__hitid;
serp_dir = _frl__serp_dir;
;
x = (_frl__x + ((serp_dir == "left") ? 1130 : (- 1130)));
;
serp_speed = _frl__serp_speed;
;
typ = (- 1);
;
global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound = scrFRSoundLoop(global.fr_module_vars[$ "mod:Frontier_Palace"].sndPalaceSerpent);
;
scrFRSoundPosition(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound, scrFRSourceRandom(13));
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound, 0);
;
on_anim = fr_Objects_Frontier_Palace_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Palace_mod_gml_SerpentHitbox_hit;
;
on_end_step = fr_Objects_Frontier_Palace_mod_gml_SerpentHitbox_endstep;
;
on_wall = fr_Objects_Frontier_Palace_mod_gml_nothing;
;
on_anim = fr_Objects_Frontier_Palace_mod_gml_nothing;
;
on_projectile = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_nullify;
;
on_grenade = fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1539
function fr_Objects_Frontier_Palace_mod_gml_SerpentHitbox_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitchVolume(sndBurn, 0.8, 2);
var __fr_other7=scrFROther(other);
lasthit = __fr_other7.hitid;
;
scrFRProjectileHit(scrFRSelf(self), 80);
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1555
function fr_Objects_Frontier_Palace_mod_gml_SerpentHitbox_endstep() {
if ((serp_dir == "right")) {
{
x += (scrFRSourceScale() * serp_speed);
;
}
}
if ((serp_dir == "left")) {
{
x -= (scrFRSourceScale() * serp_speed);
;
}
}
if (scrFRInstanceExists(Player)) {
{
var _frl__nearest = instance_nearest(x, y, Player);
;
if (scrFRInstanceExists(_frl__nearest)) {
{
nearestX = _frl__nearest.x;
;
nearestY = _frl__nearest.y;
;
var _frl__dis = distance_to_point(nearestX, nearestY);
var _frl__serpVol = ((640 - _frl__dis) / 640);
var _frl__shake = clamp((300 / distance_to_point(nearestX, nearestY)), 0, 20);
;
scrFRViewShakeAt(nearestX, nearestY, _frl__shake);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Palace"].serpentSound, clamp((1 * _frl__serpVol), 0, 10));
;
}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1576
function fr_Objects_Frontier_Palace_mod_gml_PalaceSerpentHitbox_nullify() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPitchVolume(sndPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(sprGuardianBulletHit);
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

// Original Objects/Frontier_Palace.mod.gml:1587
function fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__depth=undefined, _frl__xOff=undefined, _frl__yOff=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_serpentEye";
;
creator = _frl__creator;
;
depth = _frl__depth;
;
xOff = _frl__xOff;
;
yOff = _frl__yOff;
;
on_end_step = fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_endstep;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1599
function fr_Objects_Frontier_Palace_mod_gml_SerpentEyeglow_endstep() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
var _frl__headY = ((dsin(((scrFRSourceFrame() * 15) * 1)) * 24) - 12);
x = (creator.serpent_x + xOff);
;
y = ((creator.serpent_y + _frl__headY) + yOff);
var _frl__x1 = x;
var _frl__y1 = y;
var _frl__x2 = xprevious;
var _frl__y2 = yprevious;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Palace_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = __fr_other4.depth;
;
image_xscale = point_distance(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
image_yscale *= 2;
;
image_speed *= 4;
;
image_angle = point_direction(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
image_blend = make_color_rgb(222, 255, 126);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1624
function fr_Objects_Frontier_Palace_mod_gml_RadFlameTrap_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapScorchMark)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
depth = 10;
;
}
}
if(__fr_break6) break;
}}
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprTrapPalace);
;
hitid = [global.fr_module_vars[$ "mod:Frontier_Palace"].sprTrapPalaceGameover, "FIRE TRAP"];
depth = (- 1);
;
creator = instance_position(x, y, Wall);
;
scrFRAlarmWrite(scrFRSelf(self), 1, (80 + scrFRSourceRandomRange(0, 30)), "=");
;
fire_mode = scrFRSourceChoose(1, 2);
;
fullAmmo = 48;
;
ammo = fullAmmo;
;
active = true;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_RadFlameTrap_step;
;
on_alrm1 = ["mod", "Frontier_Palace", fr_Objects_Frontier_Palace_mod_gml_RadFlameTrap_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1651
function fr_Objects_Frontier_Palace_mod_gml_RadFlameTrap_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Palace_mod_gml_alarm1_run)) {
exit;
}
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
var _frl__prevActive = active;
;
active = (scrFRInstanceExists(Portal) ? false : true);
;
if ((active != _frl__prevActive)) {
{
if ((active == true)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 90, "=");
;
ammo = 48;
;
}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1667
function fr_Objects_Frontier_Palace_mod_gml_RadFlameTrap_alrm1() {
if ((active == true)) {
{
{ var __fr_switch_value1=fire_mode, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
if ((ammo == fullAmmo)) {
{
scrFRSoundPitch(sndFiretrap, (0.8 + scrFRSourceRandom(0.2)));
;
}
}
if ((ammo > 0)) {
{
if ((! instance_position(x, (y + 16), Wall))) {
{
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate((x + 8), (y + 16), TrapFire)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
direction = 270;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprRadTrapFire);
;
speed = (5) * timescale;
;
team = 1;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break5) break;
}}
}
}
if ((! instance_position(x, (y - 16), Wall))) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + 8), (y - 8), TrapFire)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = 90;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprRadTrapFire);
;
speed = (5) * timescale;
;
team = 1;
;
var __fr_other10=scrFROther(other);
hitid = __fr_other10.hitid;
;
}
}
if(__fr_break9) break;
}}
}
}
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
}
}
if (((-- ammo) <= 0)) {
{
fire_mode = 2;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 90, "=");
;
ammo = 48;
;
}
}
break;
;
case 1:
if ((ammo == fullAmmo)) {
{
scrFRSoundPitch(sndFiretrap, (0.8 + scrFRSourceRandom(0.2)));
;
}
}
if ((ammo > 0)) {
{
if ((! instance_position(x, (y + 16), Wall))) {
{
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate((x - 2), (y + 8), TrapFire)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
direction = 180;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprRadTrapFire);
;
speed = (5) * timescale;
;
team = 1;
;
var __fr_other14=scrFROther(other);
hitid = __fr_other14.hitid;
;
}
}
if(__fr_break13) break;
}}
}
}
if ((! instance_position(x, (y - 16), Wall))) {
{
{ var __fr_with15 = scrFRWithValues(scrFRInstanceCreate((x + 16), (y + 8), TrapFire)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
direction = 0;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprRadTrapFire);
;
speed = (5) * timescale;
;
team = 1;
;
var __fr_other18=scrFROther(other);
hitid = __fr_other18.hitid;
;
}
}
if(__fr_break17) break;
}}
}
}
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
}
}
if (((-- ammo) <= 0)) {
{
fire_mode = 1;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 90, "=");
;
ammo = 48;
;
}
}
break;
;
}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1747
function fr_Objects_Frontier_Palace_mod_gml_ThroneRoomTeleporter_create(_frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ThroneRoomTeleporter";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprThroneTeleporter);
;
spr_inactive = global.fr_module_vars[$ "mod:Frontier_Palace"].sprThroneTeleporterInactive;
;
image_speed = (0.4) * timescale;
;
depth = 0;
;
image_xscale = _frl__xscale;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Palace"].mskThroneTeleporter;
;
active = true;
;
telepormed = false;
;
doQuickThrone = true;
;
quickThrone = false;
;
on_step = fr_Objects_Frontier_Palace_mod_gml_ThroneRoomTeleporter_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Palace.mod.gml:1769
function fr_Objects_Frontier_Palace_mod_gml_ThroneRoomTeleporter_step() {
if ((active == true)) {
{
if (scrFRPlaceMeeting(x, y, Player)) {
{
var _frl__teleX = 10016;
var _frl__teleY = 8768;
;
var _frl__x = x;
;
var _frl__y = y;
telepormed = true;
;
{ var __fr_with1 = scrFRWithValues(instance_nearest(x, y, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
x = _frl__teleX;
;
y = _frl__teleY;
;
var __fr_other4=scrFROther(other);
fr_Objects_Frontier_Palace_mod_gml_view_shift(index, point_direction(__fr_other4.x, __fr_other4.y, _frl__teleX, _frl__teleY), point_distance(__fr_other4.x, __fr_other4.y, _frl__teleX, _frl__teleY));
;
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Wind)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(sprOldGuardianDeflect);
;
var __fr_other8=scrFROther(other);
depth = (__fr_other8.depth - 1);
;
}
}
if(__fr_break7) break;
}}
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(_frl__teleX, _frl__teleY, Wind)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
sprite_index = scrFRAreaSourceSprite(sprOldGuardianDeflect);
;
var __fr_other12=scrFROther(other);
depth = (__fr_other12.depth - 1);
;
}
}
if(__fr_break11) break;
}}
scrFRSoundPitchVolume(sndPortalAppear, (4 + fr_Objects_Frontier_Palace_mod_gml_orandom(0.4)), 0.4);
;
scrFRSoundPitch(sndCrownGuardianHurt, (0.5 + fr_Objects_Frontier_Palace_mod_gml_orandom(0.2)));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((((telepormed == true) && (doQuickThrone == true)) && (quickThrone == false))) {
{
{ var __fr_with13 = scrFRWithValues(BecomeNothing), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRSoundStop(sndBecomeNothingRumble);
;
scrFRAlarmWrite(scrFRSelf(self), 0, 10, "=");
;
var __fr_other16=scrFROther(other);
__fr_other16.quickThrone = true;
;
}
}
if(__fr_break15) break;
}}
}
}
if (scrFRInstanceExists(enemy)) {
{
active = false;
;
sprite_index = scrFRAreaSourceSprite(spr_inactive);
;
}
}
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1819
function fr_Objects_Frontier_Palace_mod_gml_view_shift(_frl__index=undefined, _frl__dir=undefined, _frl__pan=undefined) {
if ((_frl__index < 0)) {
{
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
fr_Objects_Frontier_Palace_mod_gml_view_shift(_frl_i, _frl__dir, _frl__pan);
;
}
}
}
} else {
{
var _frl__shake = UberCont.opt_shake;
;
UberCont.opt_shake = 1;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, Revive)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
try {
p = _frl__index;
;
instance_change(Player, false);
;
gunangle = _frl__dir;
;
scrFRWeaponPost(0, (_frl__pan * scrFRSourceScale()), 0);
;
} catch(__fr_caught4) { var _frl__error=__fr_caught4;
{
scrFRTrace(_frl__error);
;
}
}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
UberCont.opt_shake = _frl__shake;
;
}
}
; // macro hoisted: anim_end
; // macro hoisted: current_frame_active
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
; // macro hoisted: enemy_sprite
; // macro hoisted: alarm0_run
; // macro hoisted: alarm1_run
; // macro hoisted: alarm2_run
; // macro hoisted: alarm3_run
; // macro hoisted: alarm4_run
; // macro hoisted: alarm5_run
; // macro hoisted: alarm6_run
; // macro hoisted: alarm7_run
; // macro hoisted: alarm8_run
; // macro hoisted: alarm9_run
}

// Original Objects/Frontier_Palace.mod.gml:1872
function fr_Objects_Frontier_Palace_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Palace.mod.gml:1873
function fr_Objects_Frontier_Palace_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Palace.mod.gml:1874
function fr_Objects_Frontier_Palace_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Palace.mod.gml:1875
function fr_Objects_Frontier_Palace_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Palace.mod.gml:1876
function fr_Objects_Frontier_Palace_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Palace.mod.gml:1877
function fr_Objects_Frontier_Palace_mod_gml_enemy_face(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1878
function fr_Objects_Frontier_Palace_mod_gml_enemy_look(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
if (scrFRVariableExists(scrFRSelf(self), "gunangle")) {
gunangle = _frl__dir;
}
}

// Original Objects/Frontier_Palace.mod.gml:1879
function fr_Objects_Frontier_Palace_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Palace.mod.gml:1880
function fr_Objects_Frontier_Palace_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Palace.mod.gml:1881
function fr_Objects_Frontier_Palace_mod_gml_GunEnemy_draw() {
if ((gunangle < 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle >= 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
}

// Original Objects/Frontier_Palace.mod.gml:1882
function fr_Objects_Frontier_Palace_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Palace_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Palace_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Palace.mod.gml:1883
function fr_Objects_Frontier_Palace_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Palace_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Palace_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Palace.mod.gml:1884
function fr_Objects_Frontier_Palace_mod_gml_nothing() {

}

// Original Objects/Frontier_Palace.mod.gml:1885
function fr_Objects_Frontier_Palace_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionAdd(_frl__dir, _frl__spd);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_Palace.mod.gml:1895
function fr_Objects_Frontier_Palace_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
hp -= _frl__dmg;
;
nexthurt = (scrFRSourceFrame() + 6);
;
scrFRSoundHit(snd_hurt, 0.3);
;
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
}

// Original Objects/Frontier_Palace.mod.gml:1904
function fr_Objects_Frontier_Palace_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, 1, _frl__flip, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original Objects/Frontier_Palace.mod.gml:1927
function fr_Objects_Frontier_Palace_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Palace.mod.gml:1939
function fr_Objects_Frontier_Palace_mod_gml_MuzzleFlash_anim() {
image_index = 1;
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Palace.mod.gml:1943
function fr_Objects_Frontier_Palace_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Palace"].sprGenericTrail);
;
mask_index = mskNone;
;
image_speed = (2) * timescale;
;
image_yscale = (1 / 50);
;
image_xscale = 1;
;
depth = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}
