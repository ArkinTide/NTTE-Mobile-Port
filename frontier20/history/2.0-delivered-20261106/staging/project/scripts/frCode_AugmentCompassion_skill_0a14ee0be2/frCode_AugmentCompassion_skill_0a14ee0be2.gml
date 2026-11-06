#macro frMacro_Mutations_AugmentCompassion_skill_gml_scr global.fr_module_vars[$ "skill:AugmentCompassion"].scr

#macro frMacro_Mutations_AugmentCompassion_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentCompassion.skill.gml:1
function fr_Mutations_AugmentCompassion_skill_gml___load() {

}

// Original Mutations/AugmentCompassion.skill.gml:1
function fr_Mutations_AugmentCompassion_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentCompassion_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentCompassion_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentCompassion_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentCompassion.skill.gml:19
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentCompassion", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentCompassion.skill.gml:18
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentCompassion.skill.gml:18
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentCompassion.skill.gml:18
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentCompassion.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentCompassion"].sprSkillIcon = sprFR_sprAugmentCompassion_9202f900d9db;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprSkillHud = sprFR_sprAugmentCompassionIcon_3923796ad61e;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprShockRadius = sprFR_sprAugmentCompassionShoc_4cb4ceb13160;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprNull = sprFR_sprAugmentSharpTeethNull_9ec2254a74bb;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprAugmentDroneCompassion = sprFR_sprAugmentDroneCompassio_7d60aa2012be;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenShockRadius = sprFR_sprGreenAugmentCompassio_62f987c5e931;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenNull = sprFR_sprGreenAugmentSharpTeet_f96ed70f2e57;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenAugmentDroneCompassion = sprFR_sprGreenAugmentDroneComp_a56c984016a9;
;
global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments = false;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentCompassion.skill.gml:23
function fr_Mutations_AugmentCompassion_skill_gml_skill_name() {
return loc("Frontier:AugmentCompassion:0", "ATTENDANT DRONE 'HYPERION'");
;
}

// Original Mutations/AugmentCompassion.skill.gml:24
function fr_Mutations_AugmentCompassion_skill_gml_skill_text() {
return loc("Frontier:AugmentCompassion:1", "@wPETS @sGAIN A @(color:16776960)SHOCKWAVE DRONE");
;
}

// Original Mutations/AugmentCompassion.skill.gml:25
function fr_Mutations_AugmentCompassion_skill_gml_skill_tip() {
return "A PET FOR YOUR PET";
;
}

// Original Mutations/AugmentCompassion.skill.gml:26
function fr_Mutations_AugmentCompassion_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentCompassion"].sprSkillIcon);
;
}

// Original Mutations/AugmentCompassion.skill.gml:27
function fr_Mutations_AugmentCompassion_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentCompassion"].sprSkillHud;
;
}

// Original Mutations/AugmentCompassion.skill.gml:28
function fr_Mutations_AugmentCompassion_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? (scrFRModLoaded("skill", fr_Mutations_AugmentCompassion_skill_gml_skill_augment()) * 1) : 0);
;
}

// Original Mutations/AugmentCompassion.skill.gml:29
function fr_Mutations_AugmentCompassion_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentCompassion.skill.gml:30
function fr_Mutations_AugmentCompassion_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentCompassion.skill.gml:31
function fr_Mutations_AugmentCompassion_skill_gml_skill_augment() {
return "compassion";
;
}

// Original Mutations/AugmentCompassion.skill.gml:33
function fr_Mutations_AugmentCompassion_skill_gml_skill_lose() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomSlash, "name", "fr_compassiondrone")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
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

// Original Mutations/AugmentCompassion.skill.gml:41
function fr_Mutations_AugmentCompassion_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomHitme, "name", "NTTEPet")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentCompassion"))) {
{
fr_augmentCompassion = noone;
;
}
}
if ((! scrFRInstanceExists(fr_augmentCompassion))) {
{
if ((leader != noone)) {
{
fr_augmentCompassion = fr_Mutations_AugmentCompassion_skill_gml_CompassionDrone_create(x, y, scrFRSelf(self));
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentCompassion.skill.gml:53
function fr_Mutations_AugmentCompassion_skill_gml_CompassionDrone_create(_frl__x=undefined, _frl__y=undefined, _frl__pet=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_compassiondrone";
;
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenAugmentDroneCompassion : global.fr_module_vars[$ "skill:AugmentCompassion"].sprAugmentDroneCompassion));
;
image_index = 0;
;
image_speed = (0) * timescale;
;
rotSpeed = 9;
;
image_angle = 0;
;
owner = _frl__pet;
;
angle = scrFRSourceRandom(360);
;
dist = 20;
;
orbitSpeed = 6;
;
prevOwnerHealth = owner.hp;
;
shockCooldown = 0;
;
team = 2;
on_anim = fr_Mutations_AugmentCompassion_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentCompassion_skill_gml_CompassionDrone_endstep;
;
on_wall = fr_Mutations_AugmentCompassion_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentCompassion_skill_gml_nothing;
;
on_projectile = fr_Mutations_AugmentCompassion_skill_gml_DroneShock_nullify;
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(dist, angle)), (y + lengthdir_y(dist, angle)), BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenNull : global.fr_module_vars[$ "skill:AugmentCompassion"].sprNull));
;
var __fr_other7=scrFROther(other);
depth = (__fr_other7.depth - 1);
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

// Original Mutations/AugmentCompassion.skill.gml:86
function fr_Mutations_AugmentCompassion_skill_gml_CompassionDrone_endstep() {
if (((! scrFRInstanceExists(owner)) || (owner.leader == noone))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
angle += (orbitSpeed * scrFRSourceScale());
;
image_angle += (rotSpeed * scrFRSourceScale());
;
xprevious = (owner.x + lengthdir_x(dist, angle));
;
yprevious = (owner.y + lengthdir_y(dist, angle));
;
x = (owner.x + lengthdir_x(dist, angle));
;
y = (owner.y + lengthdir_y(dist, angle));
;
if ((owner.hp < prevOwnerHealth)) {
{
fr_Mutations_AugmentCompassion_skill_gml_DroneShock_create(x, y, 1);
;
}
}
if ((shockCooldown <= 5)) {
{
image_index = 0;
;
}
}
if ((shockCooldown <= 0)) {
{
var _frl__nearestProjectile = frMacro_Mutations_AugmentCompassion_skill_gml_call(frMacro_Mutations_AugmentCompassion_skill_gml_scr.instance_nearest_array, x, y, scrFRMatchingNE(scrFRMatchingNE(projectile, "typ", 0), "team", team));
;
if (((distance_to_object(enemy) < 48) || (distance_to_object(_frl__nearestProjectile) < 64))) {
{
fr_Mutations_AugmentCompassion_skill_gml_DroneShock_create(x, y, 0.8);
;
shockCooldown = 45;
;
image_index = 1;
;
}
}
}
}
prevOwnerHealth = owner.hp;
;
shockCooldown -= scrFRSourceScale();
;
}

// Original Mutations/AugmentCompassion.skill.gml:123
function fr_Mutations_AugmentCompassion_skill_gml_DroneShock_create(_frl__x=undefined, _frl__y=undefined, _frl__maxSize=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenShockRadius : global.fr_module_vars[$ "skill:AugmentCompassion"].sprShockRadius));
;
depth = (- 3);
;
image_xscale = 0;
;
image_yscale = 0;
;
image_speed = (0.5) * timescale;
;
image_alpha = 0;
;
image_angle = scrFRSourceRandom(360);
;
image_index = scrFRSourceIRandom(image_number);
;
fr_bloom = [1.1, 0.1];
;
damage = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = creator.team;
;
typ = 0;
;
maxSize = _frl__maxSize;
;
on_anim = fr_Mutations_AugmentCompassion_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentCompassion_skill_gml_DroneShock_endstep;
;
on_wall = fr_Mutations_AugmentCompassion_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentCompassion_skill_gml_DroneShock_hit;
;
on_projectile = fr_Mutations_AugmentCompassion_skill_gml_DroneShock_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentCompassion.skill.gml:153
function fr_Mutations_AugmentCompassion_skill_gml_DroneShock_endstep() {
if (scrFRInstanceExists(creator)) {
{
x = creator.x;
;
y = creator.y;
;
}
}
image_angle += (4 * scrFRSourceScale());
;
if ((image_xscale >= maxSize)) {
{
image_alpha -= (0.05 * scrFRSourceScale());
;
if ((image_alpha <= 0)) {
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
image_alpha += (0.1 / scrFRGetSkill("AugmentCompassion"));
;
image_xscale += (0.1 / scrFRGetSkill("AugmentCompassion"));
;
image_yscale = image_xscale;
;
}
}
}

// Original Mutations/AugmentCompassion.skill.gml:174
function fr_Mutations_AugmentCompassion_skill_gml_DroneShock_nullify() {
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
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentCompassion"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentCompassion"].sprGreenNull : global.fr_module_vars[$ "skill:AugmentCompassion"].sprNull));
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

// Original Mutations/AugmentCompassion.skill.gml:185
function fr_Mutations_AugmentCompassion_skill_gml_DroneShock_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
}
}
}

// Original Mutations/AugmentCompassion.skill.gml:190
function fr_Mutations_AugmentCompassion_skill_gml_nothing() {

}
