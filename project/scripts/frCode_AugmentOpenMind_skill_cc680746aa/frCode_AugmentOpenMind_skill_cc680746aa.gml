#macro frMacro_Mutations_AugmentOpenMind_skill_gml_scr global.fr_module_vars[$ "skill:AugmentOpenMind"].scr

#macro frMacro_Mutations_AugmentOpenMind_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentOpenMind.skill.gml:1
function fr_Mutations_AugmentOpenMind_skill_gml___load() {

}

// Original Mutations/AugmentOpenMind.skill.gml:1
function fr_Mutations_AugmentOpenMind_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentOpenMind_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentOpenMind_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentOpenMind_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentOpenMind.skill.gml:19
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentOpenMind", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentOpenMind.skill.gml:18
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentOpenMind.skill.gml:18
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentOpenMind.skill.gml:18
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentOpenMind.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprSkillIcon = sprFR_sprAugmentOpenMind_242c78f82fbb;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprSkillHud = sprFR_sprAugmentOpenMindIcon_76b1aa697807;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprBeacon = sprFR_sprBeacon_f26a0f423f26;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprBeaconRadius = sprFR_sprBeaconRadius_d246d8756d5b;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprPopoFireFly = sprFR_sprPopoFireFly_48298ea811e0;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenBeacon = sprFR_sprGreenBeacon_dddff4030ad5;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenBeaconRadius = sprFR_sprGreenBeaconRadius_5767ea746c2c;
global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenPopoFireFly = sprFR_sprGreenPopoFireFly_698fef9a4e5e;
global.fr_module_vars[$ "skill:AugmentOpenMind"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments = false;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentOpenMind.skill.gml:23
function fr_Mutations_AugmentOpenMind_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentOpenMind:0", "CONVERSENT GUIDANCE"));
;
}

// Original Mutations/AugmentOpenMind.skill.gml:24
function fr_Mutations_AugmentOpenMind_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentOpenMind:1", "@wEMPOWERING @(color:16776960)BEACONS#@wSPAWN @sIN LEVELS"));
;
}

// Original Mutations/AugmentOpenMind.skill.gml:25
function fr_Mutations_AugmentOpenMind_skill_gml_skill_tip() {
return scrFRLocalize("TRULY GOOD PLACEMENT");
;
}

// Original Mutations/AugmentOpenMind.skill.gml:26
function fr_Mutations_AugmentOpenMind_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentOpenMind"].sprSkillIcon);
;
}

// Original Mutations/AugmentOpenMind.skill.gml:27
function fr_Mutations_AugmentOpenMind_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentOpenMind"].sprSkillHud;
;
}

// Original Mutations/AugmentOpenMind.skill.gml:28
function fr_Mutations_AugmentOpenMind_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentOpenMind.skill.gml:29
function fr_Mutations_AugmentOpenMind_skill_gml_skill_wepspec() {
return 1;
;
}

// Original Mutations/AugmentOpenMind.skill.gml:30
function fr_Mutations_AugmentOpenMind_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentOpenMind.skill.gml:31
function fr_Mutations_AugmentOpenMind_skill_gml_skill_augment() {
return mut_open_mind;
;
}

// Original Mutations/AugmentOpenMind.skill.gml:33
function fr_Mutations_AugmentOpenMind_skill_gml_skill_take() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffAugmentBeacon_ammo"))) {
{
fr_buffAugmentBeacon_ammo = false;
;
fr_inbeacon = false;
;
fr_buffAugmentBeacon_prevhealth = hp;
;
}
}
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "skill:AugmentOpenMind"].level_start = false;
;
}

// Original Mutations/AugmentOpenMind.skill.gml:43
function fr_Mutations_AugmentOpenMind_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:AugmentOpenMind"].level_start = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:AugmentOpenMind"].level_start) {
{
global.fr_module_vars[$ "skill:AugmentOpenMind"].level_start = false;
;
repeat ((3 * scrFRGetSkill("AugmentOpenMind"))) {
{ var __fr_with1 = scrFRWithValues(frMacro_Mutations_AugmentOpenMind_skill_gml_call(frMacro_Mutations_AugmentOpenMind_skill_gml_scr.instance_random, scrFRMatching(Floor, "object_index", Floor))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentOpenMind_skill_gml_Beacon_create((x + 16), (y + 16));
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Mutations/AugmentOpenMind.skill.gml:56
function fr_Mutations_AugmentOpenMind_skill_gml_Beacon_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AugmentBeacon";
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenBeacon : global.fr_module_vars[$ "skill:AugmentOpenMind"].sprBeacon));
;
spr_radius = (global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenBeaconRadius : global.fr_module_vars[$ "skill:AugmentOpenMind"].sprBeaconRadius);
;
spr_firefly = (global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentOpenMind"].sprGreenPopoFireFly : global.fr_module_vars[$ "skill:AugmentOpenMind"].sprPopoFireFly);
;
mask_index = mskEnemyBullet1;
;
image_speed = (0.4) * timescale;
;
fr_glow = [70, 94];
;
on_step = fr_Mutations_AugmentOpenMind_skill_gml_Beacon_step;
;
on_draw = fr_Mutations_AugmentOpenMind_skill_gml_Beacon_draw;
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = make_colour_rgb(0, 255, 255);
;
depth = (- 3);
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

// Original Mutations/AugmentOpenMind.skill.gml:81
function fr_Mutations_AugmentOpenMind_skill_gml_Beacon_step() {
if ((scrFRSourceRandom(6) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 40), 40)), (y + scrFRSourceRandomRange((- 40), 40)), FireFly)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_firefly);
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with5 = scrFRWithValues(Player), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
if ((distance_to_object((scrFROther(other))) <= 60)) {
{
fr_inbeacon = true;
;
fr_Mutations_AugmentOpenMind_skill_gml_status_apply_beaconed(scrFRSelf(self), 3);
}
} else {
{
fr_inbeacon = false;
;
}
}
}
}
if(__fr_break7) break;
}}
{ var __fr_with8 = scrFRWithValues(scrFRMatching(AmmoPickup, "fr_augmentBeaconed", undefined)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if ((distance_to_object((scrFROther(other))) <= 60)) {
{
fr_augmentBeaconed = true;
;
num += 0.5;
;
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentAmmoTier"))) {
{
fr_augmentAmmoTier = 0;
;
}
}
fr_augmentAmmoTier += 1;
;
scrFRModCall("mod", "Frontier_Pickups", "AugmentAmmoPickup_resprite");
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break13) break;
}}
}
}
}
}
if(__fr_break10) break;
}}
{ var __fr_with14 = scrFRWithValues(scrFRMatching(HPPickup, "fr_augmentBeaconed", undefined)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
if ((distance_to_object((scrFROther(other))) <= 60)) {
{
fr_augmentBeaconed = true;
;
num += 1;
;
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentHealthTier"))) {
{
fr_augmentHealthTier = 0;
;
}
}
fr_augmentHealthTier += 1;
;
scrFRModCall("mod", "Frontier_Pickups", "AugmentHealthPickup_resprite");
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentOpenMind"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break19) break;
}}
}
}
}
}
if(__fr_break16) break;
}}
}

// Original Mutations/AugmentOpenMind.skill.gml:150
function fr_Mutations_AugmentOpenMind_skill_gml_Beacon_draw() {
var _frl_beaconsine = (sin((scrFRSourceFrame() * 0.02)) * 0.9);
;
scrFRDrawSpriteExt(shd24, 1, x, (y - 8), 1, 1.5, 0, c_white, 0.2);
draw_self();
scrFRDrawSpriteExt(spr_radius, 1, x, y, (1 + scrFRSourceRandom(0.02)), (1 + scrFRSourceRandom(0.02)), 0, c_white, 0.5);
scrFRDrawSpriteExt(spr_radius, 1, x, y, (1.06 + scrFRSourceRandom(0.02)), (1.06 + scrFRSourceRandom(0.02)), 0, c_white, 0.3);
scrFRDrawSpriteExt(spr_radius, 1, x, y, _frl_beaconsine, _frl_beaconsine, 0, c_white, 0.2);
}

// Original Mutations/AugmentOpenMind.skill.gml:159
function fr_Mutations_AugmentOpenMind_skill_gml_status_apply_beaconed(_frl__target=undefined, _frl__duration=undefined) {
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", _frl__target, scrFRModGet("mod", "Frontier_StatusEffects", "buffAugmentBeacon"), _frl__duration);
}
