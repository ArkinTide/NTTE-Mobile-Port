#macro frMacro_Mutations_AugmentEuphoria_skill_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Mutations_AugmentEuphoria_skill_gml_scr global.fr_module_vars[$ "skill:AugmentEuphoria"].scr

#macro frMacro_Mutations_AugmentEuphoria_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentEuphoria.skill.gml:1
function fr_Mutations_AugmentEuphoria_skill_gml___load() {

}

// Original Mutations/AugmentEuphoria.skill.gml:1
function fr_Mutations_AugmentEuphoria_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentEuphoria_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentEuphoria_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentEuphoria_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentEuphoria.skill.gml:21
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentEuphoria", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentEuphoria.skill.gml:20
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentEuphoria.skill.gml:20
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentEuphoria.skill.gml:20
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentEuphoria.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprSkillIcon = sprFR_sprAugmentEuphoria_32a2269cd599;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprSkillHud = sprFR_sprAugmentEuphoriaIcon_dbe16d332093;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].mskAugmentEuphoriaDroneHitbox = sprFR_mskAugmentEuphoriaDroneH_bcb3bcdcbe23;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprAugmentDroneEuphoria = sprFR_sprAugmentDroneEuphoria_ed1f289712fc;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprNull = sprFR_sprAugmentSharpTeethNull_9ec2254a74bb;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGreenAugmentDroneEuphoria = sprFR_sprGreenAugmentDroneEuph_19d239a6e849;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGreenNull = sprFR_sprGreenAugmentSharpTeet_f96ed70f2e57;
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].levelStart = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments = false;
;
; // macro hoisted: current_frame_active
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentEuphoria.skill.gml:25
function fr_Mutations_AugmentEuphoria_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentEuphoria:0", "ACOLYTE DRONE 'ENCELADUS'"));
;
}

// Original Mutations/AugmentEuphoria.skill.gml:26
function fr_Mutations_AugmentEuphoria_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentEuphoria:1", "@sGAIN A @(color:16776960)PROJECTILE#DESTROYING DRONE"));
;
}

// Original Mutations/AugmentEuphoria.skill.gml:27
function fr_Mutations_AugmentEuphoria_skill_gml_skill_tip() {
return scrFRLocalize("@(color:16745694)COOL TIP");
;
}

// Original Mutations/AugmentEuphoria.skill.gml:28
function fr_Mutations_AugmentEuphoria_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentEuphoria"].sprSkillIcon);
;
}

// Original Mutations/AugmentEuphoria.skill.gml:29
function fr_Mutations_AugmentEuphoria_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentEuphoria"].sprSkillHud;
;
}

// Original Mutations/AugmentEuphoria.skill.gml:30
function fr_Mutations_AugmentEuphoria_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentEuphoria.skill.gml:31
function fr_Mutations_AugmentEuphoria_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentEuphoria.skill.gml:32
function fr_Mutations_AugmentEuphoria_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentEuphoria.skill.gml:33
function fr_Mutations_AugmentEuphoria_skill_gml_skill_augment() {
return mut_euphoria;
;
}

// Original Mutations/AugmentEuphoria.skill.gml:35
function fr_Mutations_AugmentEuphoria_skill_gml_skill_lose() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(Player, "fr_myEuphoriaDrone", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_myEuphoriaDrone = undefined;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_EuphoriaDrone")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
}
}
if(__fr_break9) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
}

// Original Mutations/AugmentEuphoria.skill.gml:46
function fr_Mutations_AugmentEuphoria_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:AugmentEuphoria"].levelStart = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:AugmentEuphoria"].levelStart) {
{
global.fr_module_vars[$ "skill:AugmentEuphoria"].levelStart = false;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(Player, "fr_myEuphoriaDrone", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_myEuphoriaDrone = undefined;
;
}
}
if(__fr_break3) break;
}}
}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(Player, "fr_myEuphoriaDrone", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_myEuphoriaDrone = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_create(x, y, scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
}

// Original Mutations/AugmentEuphoria.skill.gml:62
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_create(_frl__x=undefined, _frl__y=undefined, _frl__leader=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_EuphoriaDrone";
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGreenAugmentDroneEuphoria : global.fr_module_vars[$ "skill:AugmentEuphoria"].sprAugmentDroneEuphoria));
;
depth = (- 8);
;
image_alpha = 0;
;
image_speed = (0.4) * timescale;
;
trailColor = (global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
droneBobHeight = 0.3;
;
droneBobSpeed = 0.06;
;
right = 0;
;
offset = 0;
;
distance = 40;
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
flightspeed = 5;
;
chargeMax = 150;
;
wantHitbox = false;
;
imDoingIt = false;
;
returnCooldown = 0;
;
droneHitbox = noone;
;
on_step = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_step;
;
on_end_step = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_endstep;
;
on_draw = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentEuphoria.skill.gml:99
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_step() {
if ((! scrFRInstanceExists(leader))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
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
var _frl__nearestBullet = frMacro_Mutations_AugmentEuphoria_skill_gml_call(frMacro_Mutations_AugmentEuphoria_skill_gml_scr.instance_nearest_array, leader.x, leader.y, scrFRMatchingNE(scrFRMatchingNE(projectile, "typ", 0), "team", leader.team));
{
{ var __fr_with4 = scrFRWithValues(leader), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((distance_to_object(_frl__nearestBullet) < 56)) {
{
var __fr_other7=scrFROther(other);
__fr_other7.imDoingIt = true;
;
var __fr_other8=scrFROther(other);
__fr_other8.wantHitbox = true;
;
var __fr_other9=scrFROther(other);
__fr_other9.returnCooldown = 5;
;
}
} else {
{
_frl__nearestBullet = noone;
;
if (((scrFROther(other)).returnCooldown <= 0)) {
{
var __fr_other10=scrFROther(other);
__fr_other10.imDoingIt = false;
;
var __fr_other11=scrFROther(other);
__fr_other11.wantHitbox = false;
;
}
}
}
}
}
}
if(__fr_break6) break;
}}
}
if ((imDoingIt == false)) {
{
x += (fr_Mutations_AugmentEuphoria_skill_gml_approach(x, xGoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_x(0, leader.gunangle));
y += (fr_Mutations_AugmentEuphoria_skill_gml_approach(y, yGoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_y(0, leader.gunangle));
y = (y + (sin((scrFRSourceFrame() * droneBobSpeed)) * droneBobHeight));
;
xGoal = (leader.x - lengthdir_x(distance, (leader.gunangle + offset)));
yGoal = (leader.y - lengthdir_y(distance, (leader.gunangle + offset)));
}
} else {
{
if (scrFRInstanceExists(_frl__nearestBullet)) {
{
x += fr_Mutations_AugmentEuphoria_skill_gml_approach(x, xGoal, flightspeed, scrFRSourceScale());
;
y += fr_Mutations_AugmentEuphoria_skill_gml_approach(y, yGoal, flightspeed, scrFRSourceScale());
;
xGoal = _frl__nearestBullet.x;
;
yGoal = _frl__nearestBullet.y;
;
}
}
}
}
if ((returnCooldown > 0)) {
{
returnCooldown -= scrFRSourceScale();
;
}
}
tilt = (((leader.speed / timescale) * 4) * (- right));
;
right = ((((leader.gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((wantHitbox == true)) {
{
if ((! scrFRInstanceExists(droneHitbox))) {
{
droneHitbox = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_create(x, y, scrFRSelf(self));
;
}
}
}
}
}

// Original Mutations/AugmentEuphoria.skill.gml:160
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_endstep() {
if ((imDoingIt == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Mutations_AugmentEuphoria_skill_gml_generic_trail_create(x, y)), __fr_break3=false;
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

// Original Mutations/AugmentEuphoria.skill.gml:172
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
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
mask_index = global.fr_module_vars[$ "skill:AugmentEuphoria"].mskAugmentEuphoriaDroneHitbox;
;
damage = 0;
;
typ = 0;
;
ammo_type = (- 1);
;
prism_duplicate = false;
;
on_anim = fr_Mutations_AugmentEuphoria_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentEuphoria_skill_gml_nothing;
;
on_wall = fr_Mutations_AugmentEuphoria_skill_gml_nothing;
;
on_projectile = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_projectile;
;
on_grenade = fr_Mutations_AugmentEuphoria_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_endstep;
;
on_destroy = fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_destroy;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentEuphoria.skill.gml:193
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_projectile() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPitchVolume(sndPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentEuphoria"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGreenNull : global.fr_module_vars[$ "skill:AugmentEuphoria"].sprNull));
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

// Original Mutations/AugmentEuphoria.skill.gml:204
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_endstep() {
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

// Original Mutations/AugmentEuphoria.skill.gml:209
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDroneHitbox_destroy() {
if (scrFRInstanceExists(creator)) {
{
creator.droneHitbox = noone;
;
}
}
}

// Original Mutations/AugmentEuphoria.skill.gml:214
function fr_Mutations_AugmentEuphoria_skill_gml_EuphoriaDrone_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, tilt, image_blend, 1);
;
}

// Original Mutations/AugmentEuphoria.skill.gml:217
function fr_Mutations_AugmentEuphoria_skill_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Mutations/AugmentEuphoria.skill.gml:220
function fr_Mutations_AugmentEuphoria_skill_gml_generic_trail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentEuphoria"].sprGenericTrail);
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

// Original Mutations/AugmentEuphoria.skill.gml:232
function fr_Mutations_AugmentEuphoria_skill_gml_nothing() {

}
