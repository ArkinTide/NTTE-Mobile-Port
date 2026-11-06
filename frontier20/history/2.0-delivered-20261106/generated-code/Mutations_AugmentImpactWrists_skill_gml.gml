#macro frMacro_Mutations_AugmentImpactWrists_skill_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Mutations_AugmentImpactWrists_skill_gml_scr global.fr_module_vars[$ "skill:AugmentImpactWrists"].scr

#macro frMacro_Mutations_AugmentImpactWrists_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentImpactWrists.skill.gml:1
function fr_Mutations_AugmentImpactWrists_skill_gml___load() {

}

// Original Mutations/AugmentImpactWrists.skill.gml:1
function fr_Mutations_AugmentImpactWrists_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentImpactWrists_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentImpactWrists_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentImpactWrists_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentImpactWrists.skill.gml:24
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentImpactWrists", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentImpactWrists.skill.gml:23
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentImpactWrists.skill.gml:23
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentImpactWrists.skill.gml:23
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentImpactWrists.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprSkillIcon = sprFR_sprAugmentImpactWrists_f84fe0192398;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprSkillHud = sprFR_sprAugmentImpactWristsIc_e9342d238120;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].mskAugmentImpactDroneHitbox = sprFR_mskAugmentImpactDroneHit_1b0533864b9b;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprAugmentDroneImpactWrists = sprFR_sprAugmentDroneImpactWri_92973ae4d0a8;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprAugmentDroneImpactWristsGlow = sprFR_sprAugmentDroneImpactWri_0e7c559d2eb7;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenAugmentDroneImpactWrists = sprFR_sprGreenAugmentDroneImpa_88e2c1c29ec2;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenAugmentDroneImpactWristsGlow = sprFR_sprGreenAugmentDroneImpa_5c80161a92a7;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenIDPDPortalCharge = sprFR_sprGreenIDPDPortalCharge_d931f0291691;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenRogueExplosion = sprFR_sprGreenRogueExplosion_7f1ff4b13d08;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].levelStart = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge = 0;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments = false;
;
; // macro hoisted: current_frame_active
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentImpactWrists.skill.gml:28
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_name() {
return loc("Frontier:AugmentImpactWrists:0", "ACOLYTE DRONE 'IAPETUS'");
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:29
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_text() {
return loc("Frontier:AugmentImpactWrists:1", "@wKILLS @sCHARGE UP A#@(color:16776960)POWERFUL PIERCING DRONE");
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:30
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_tip() {
return "HIGH IMPACT";
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:31
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprSkillIcon);
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:32
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprSkillHud;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:33
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:34
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:35
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:36
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_augment() {
return mut_impact_wrists;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:38
function fr_Mutations_AugmentImpactWrists_skill_gml_game_start() {
global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge = 0;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:41
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_take() {
{ var __fr_with1 = scrFRWithValues(frMacro_Mutations_AugmentImpactWrists_skill_gml_call(frMacro_Mutations_AugmentImpactWrists_skill_gml_scr.instance_random, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_create(x, y, scrFRSelf(self));
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentImpactWrists.skill.gml:46
function fr_Mutations_AugmentImpactWrists_skill_gml_skill_lose() {
global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge = 0;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_ImpactDrone")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
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

// Original Mutations/AugmentImpactWrists.skill.gml:55
function fr_Mutations_AugmentImpactWrists_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:AugmentImpactWrists"].levelStart = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:AugmentImpactWrists"].levelStart) {
{
global.fr_module_vars[$ "skill:AugmentImpactWrists"].levelStart = false;
;
{ var __fr_with1 = scrFRWithValues(frMacro_Mutations_AugmentImpactWrists_skill_gml_call(frMacro_Mutations_AugmentImpactWrists_skill_gml_scr.instance_random, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_create(x, y, scrFRSelf(self));
}
}
if(__fr_break3) break;
}}
}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(scrFRMatchingLE(enemy, "my_health", 0), "fr_ImpactDroneCharged", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_ImpactDroneCharged = true;
;
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_ImpactDrone")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge += scrFRGetSkill("AugmentImpactWrists");
;
fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneChargeParticle_create((x + scrFRSourceRandomRange((- 40), 40)), (y + scrFRSourceRandomRange((- 40), 40)), scrFRSelf(self));
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break6) break;
}}
}

// Original Mutations/AugmentImpactWrists.skill.gml:77
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_create(_frl__x=undefined, _frl__y=undefined, _frl__leader=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ImpactDrone";
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenAugmentDroneImpactWrists : global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprAugmentDroneImpactWrists));
;
spr_glow = (global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenAugmentDroneImpactWristsGlow : global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprAugmentDroneImpactWristsGlow);
;
depth = (- 8);
;
image_alpha = 0;
;
image_speed = (0.4) * timescale;
;
trailColor = (global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
droneBobHeight = 0.3;
;
droneBobSpeed = 0.06;
;
right = 0;
;
offset = 30;
;
distance = 50;
;
tilt = 0;
;
fr_glow = [16, 24];
;
leader = _frl__leader;
;
xGoal = _frl__leader.x;
;
yGoal = _frl__leader.y;
;
team = _frl__leader.team;
;
friction = (0.4) * (timescale * timescale);
;
flightspeed = 3.5;
;
chargeMax = 150;
;
wantHitbox = false;
;
droneAttacking = false;
;
droneHitbox = noone;
;
on_step = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_step;
;
on_end_step = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_endstep;
;
on_draw = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentImpactWrists.skill.gml:114
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_step() {
if ((! scrFRInstanceExists(leader))) {
{
if ((! scrFRInstanceExists(Player))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
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
} else {
{
leader = frMacro_Mutations_AugmentImpactWrists_skill_gml_call(frMacro_Mutations_AugmentImpactWrists_skill_gml_scr.instance_random, Player);
}
}
}
}
if ((droneAttacking == false)) {
{
x += (fr_Mutations_AugmentImpactWrists_skill_gml_approach(x, xGoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_x(0, leader.gunangle));
y += (fr_Mutations_AugmentImpactWrists_skill_gml_approach(y, yGoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_y(0, leader.gunangle));
y = (y + (sin((scrFRSourceFrame() * droneBobSpeed)) * droneBobHeight));
;
xGoal = (leader.x - lengthdir_x(distance, (leader.gunangle + offset)));
yGoal = (leader.y - lengthdir_y(distance, (leader.gunangle + offset)));
tilt = (((leader.speed / timescale) * 4) * (- right));
;
right = ((((leader.gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge >= chargeMax)) {
{
droneAttacking = true;
;
fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_attack();
;
}
}
}
} else {
{
tilt = (((speed / timescale) * 4) * (- right));
;
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((frMacro_Mutations_AugmentImpactWrists_skill_gml_current_frame_active && ((speed / timescale) > 5))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 25), 25)), (y + scrFRSourceRandomRange((- 25), 25)), BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? scrFRSourceChoose(global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenIDPDPortalCharge, sprPlasmaTrail) : scrFRSourceChoose(sprIDPDPortalCharge, sprPopoPlasmaTrail)));
;
image_index = scrFRSourceIRandom(image_number);
speed = (5) * timescale;
;
var __fr_other7=scrFROther(other);
direction = (__fr_other7.direction + 180);
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
if ((wantHitbox == true)) {
{
if (scrFRInstanceExists(leader)) {
{
if ((! scrFRInstanceExists(droneHitbox))) {
{
droneHitbox = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_create(x, y, scrFRSelf(self));
;
}
}
}
}
}
}
}

// Original Mutations/AugmentImpactWrists.skill.gml:174
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_endstep() {
if ((droneAttacking == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Mutations_AugmentImpactWrists_skill_gml_generic_trail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_yscale *= 3;
;
image_speed *= 4;
;
var __fr_other6=scrFROther(other);
image_angle = point_direction(x, y, __fr_other6.xprevious, __fr_other6.yprevious);
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.trailColor;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Mutations/AugmentImpactWrists.skill.gml:186
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_attack() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_attack_resume, id, scrFROther(other), _args, 23, []);
}
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_attack_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_attack");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentImpactWrists.skill.gml:239
{
wantHitbox = false;
;
speed = (0) * timescale;
;
global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge = 0;
;
droneAttacking = false;
;
}
_fr.pc=0;
break;
case 2: // Mutations/AugmentImpactWrists.skill.gml:238
{
;
}
_fr.pc=1;
break;
case 3: // Mutations/AugmentImpactWrists.skill.gml:238
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Mutations/AugmentImpactWrists.skill.gml:238
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 3 : 1;
break;
case 5: // Mutations/AugmentImpactWrists.skill.gml:237
{
;
}
_fr.pc=4;
break;
case 6: // Mutations/AugmentImpactWrists.skill.gml:237
_fr.wait_ticks=max(0,20); _fr.pc=5; return;
break;
case 7: // Mutations/AugmentImpactWrists.skill.gml:221
{
scrFRSoundPitchVolume(sndLaserCannon, 0.8, 2);
scrFRSoundPitchVolume(sndEnergyHammer, 0.6, 2);
if (scrFRInstanceExists(enemy)) {
{
{ var __fr_with1 = scrFRWithValues(leader), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
_fr.vars.nearestGuy = instance_nearest(x, y, enemy);
}
}
if(__fr_break3) break;
}}
_fr.vars.attackDirection = point_direction(x, y, _fr.vars.nearestGuy.x, _fr.vars.nearestGuy.y);
}
} else {
{
_fr.vars.attackDirection = scrFRSourceRandom(360);
;
}
}
wantHitbox = true;
;
direction = _fr.vars.attackDirection;
;
speed = (30) * timescale;
;
}
_fr.pc=6;
break;
case 8: // Mutations/AugmentImpactWrists.skill.gml:218
{
;
}
_fr.pc=7;
break;
case 9: // Mutations/AugmentImpactWrists.skill.gml:218
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Mutations/AugmentImpactWrists.skill.gml:218
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 9 : 7;
break;
case 11: // Mutations/AugmentImpactWrists.skill.gml:217
{
;
}
_fr.pc=10;
break;
case 12: // Mutations/AugmentImpactWrists.skill.gml:217
_fr.wait_ticks=max(0,10); _fr.pc=11; return;
break;
case 13: // Mutations/AugmentImpactWrists.skill.gml:205
{
if (scrFRInstanceExists(enemy)) {
{
{ var __fr_with4 = scrFRWithValues(leader), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
_fr.vars.nearestGuy = instance_nearest(x, y, enemy);
}
}
if(__fr_break6) break;
}}
_fr.vars.attackDirection = point_direction(x, y, _fr.vars.nearestGuy.x, _fr.vars.nearestGuy.y);
}
} else {
{
_fr.vars.attackDirection = scrFRSourceRandom(360);
;
}
}
direction = (_fr.vars.attackDirection + 180);
;
speed = (4) * timescale;
;
}
_fr.pc=12;
break;
case 15: // Mutations/AugmentImpactWrists.skill.gml:192
_fr.vars.__fr_repeat7--; _fr.pc=14;
break;
case 16: // Mutations/AugmentImpactWrists.skill.gml:201
{
;
}
_fr.pc=15;
break;
case 17: // Mutations/AugmentImpactWrists.skill.gml:201
_fr.wait_ticks=max(0,1); _fr.pc=16; return;
break;
case 18: // Mutations/AugmentImpactWrists.skill.gml:194
{
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 48), 48)), (y + scrFRSourceRandomRange((- 48), 48)), IDPDPortalCharge)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
scrFRMotionAdd(point_direction(x, y, __fr_other11.x, __fr_other11.y), (3 + scrFRSourceRandom(1)));
;
var __fr_other12=scrFROther(other);
scrFRAlarmWrite(scrFRSelf(self), 0, ((point_distance(x, y, __fr_other12.x, __fr_other12.y) / (speed / timescale)) + 1), "=");
;
if ((global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments == true)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenIDPDPortalCharge);
;
}
}
}
}
if(__fr_break10) break;
}}
}
_fr.pc=17;
break;
case 19: // Mutations/AugmentImpactWrists.skill.gml:193
{
;
}
_fr.pc=18;
break;
case 20: // Mutations/AugmentImpactWrists.skill.gml:193
_fr.result=undefined; _fr.done=true; return;
break;
case 21: // Mutations/AugmentImpactWrists.skill.gml:193
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 20 : 18;
break;
case 14: // Mutations/AugmentImpactWrists.skill.gml:192
_fr.pc=(_fr.vars.__fr_repeat7>0)?21:13;
break;
case 22: // Mutations/AugmentImpactWrists.skill.gml:192
_fr.vars.__fr_repeat7=round(25); _fr.pc=14;
break;
case 23: // Mutations/AugmentImpactWrists.skill.gml:188
{
scrFRSoundPitchVolume(sndVanWarning, 2, 0.4);
;
scrFRSoundPitchVolume(sndLaserCannonCharge, 1.6, 0.5);
}
_fr.pc=22;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentImpactWrists.skill.gml:247
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
mask_index = global.fr_module_vars[$ "skill:AugmentImpactWrists"].mskAugmentImpactDroneHitbox;
;
damage = 30;
;
hitlist = [];
;
typ = 0;
;
ammo_type = (- 1);
;
on_hit = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_hit;
;
on_wall = fr_Mutations_AugmentImpactWrists_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_endstep;
;
on_destroy = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_destroy;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentImpactWrists.skill.gml:265
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
var _frl_drone = scrFRSelf(self);
;
{ var __fr_with2 = scrFRWithValues((scrFROther(other))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
scrFRProjectileHit(scrFRSelf(self), _frl_drone.damage);
scrFRSoundPitchVolume(sndExplosion, (1 + scrFRSourceRandomRange(0.1, 0.3)), 1.2);
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, PopoExplosion)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenRogueExplosion : sprRogueExplosion));
;
mask_index = mskExplosion;
;
team = _frl_drone.team;
;
creator = _frl_drone;
;
}
}
if(__fr_break7) break;
}}
}
}
if(__fr_break4) break;
}}
}
}
}

// Original Mutations/AugmentImpactWrists.skill.gml:281
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_endstep() {
if (((! scrFRInstanceExists(creator)) || (creator.wantHitbox == false))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = creator.x;
y = creator.y;
}

// Original Mutations/AugmentImpactWrists.skill.gml:286
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneHitbox_destroy() {
creator.droneHitbox = noone;
;
}

// Original Mutations/AugmentImpactWrists.skill.gml:289
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDrone_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, tilt, image_blend, 1);
;
scrFRDrawSpriteExt(spr_glow, image_index, x, y, (1 * right), 1, tilt, image_blend, clamp((global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge / chargeMax), 0, 1));
;
gpu_set_blendmode(bm_add);
scrFRDrawSpriteExt(spr_glow, image_index, x, y, (clamp((1 + (global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge / chargeMax)), 1, 2) * right), clamp((1 + (global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge / chargeMax)), 1, 2), tilt, image_blend, clamp((global.fr_module_vars[$ "skill:AugmentImpactWrists"].droneCharge / chargeMax), 0, 0.2));
;
gpu_set_blendmode(bm_normal);
}

// Original Mutations/AugmentImpactWrists.skill.gml:296
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneChargeParticle_create(_frl__x=undefined, _frl__y=undefined, _frl__drone=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ImpactDroneChargeParticle";
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentImpactWrists"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGreenIDPDPortalCharge : sprIDPDPortalCharge));
;
image_index = scrFRSourceIRandom(image_number);
;
depth = (- 7);
;
image_alpha = 0.6;
;
image_speed = (0) * timescale;
speed = (7) * timescale;
;
creator = _frl__drone;
;
on_step = fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneChargeParticle_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentImpactWrists.skill.gml:314
function fr_Mutations_AugmentImpactWrists_skill_gml_ImpactDroneChargeParticle_step() {
if ((scrFRInstanceExists(creator) && scrFRInstanceExists(scrFRSelf(self)))) {
{
direction = point_direction(x, y, creator.x, creator.y);
if (scrFRPlaceMeeting(x, y, creator)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Mutations/AugmentImpactWrists.skill.gml:325
function fr_Mutations_AugmentImpactWrists_skill_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Mutations/AugmentImpactWrists.skill.gml:328
function fr_Mutations_AugmentImpactWrists_skill_gml_generic_trail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentImpactWrists"].sprGenericTrail);
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

// Original Mutations/AugmentImpactWrists.skill.gml:340
function fr_Mutations_AugmentImpactWrists_skill_gml_nothing() {

}
