// Original Mutations/AugmentExtraFeet.skill.gml:1
function fr_Mutations_AugmentExtraFeet_skill_gml___load() {

}

// Original Mutations/AugmentExtraFeet.skill.gml:1
function fr_Mutations_AugmentExtraFeet_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprSkillIcon = sprFR_sprAugmentExtraFeet_a22022bfd83c;
;
global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprSkillHud = sprFR_sprAugmentExtraFeetIcon_4ca763db9629;
;
global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprGreenIDPDPortalCharge = sprFR_sprGreenIDPDPortalCharge_d931f0291691;
;
global.fr_module_vars[$ "skill:AugmentExtraFeet"].settingGreenAugments = false;
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:11
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentExtraFeet:0", "POCKET TELEPORTER"));
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:12
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentExtraFeet:1", "@wDOUBLE-TAP @sMOVEMENT#@sKEYS TO PERFORM A#@(color:16776960)TELEPORTATION DASH"));
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:13
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_tip() {
return scrFRLocalize("VWOOP");
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:14
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprSkillIcon);
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:15
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprSkillHud;
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:16
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:17
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:18
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:19
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_augment() {
return mut_extra_feet;
;
}

// Original Mutations/AugmentExtraFeet.skill.gml:21
function fr_Mutations_AugmentExtraFeet_skill_gml_skill_take() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_dashaugment_lastx = x;
fr_dashaugment_lasty = y;
fr_dashaugment_cooldown = 0;
;
fr_dashaugment_angle = (- 1);
;
fr_dashaugment_swapcooldown = 0;
fr_dashaugment_lstebutton = 0;
;
fr_dashaugment_lstnbutton = 0;
;
fr_dashaugment_lstwbutton = 0;
;
fr_dashaugment_lstsbutton = 0;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentExtraFeet.skill.gml:34
function fr_Mutations_AugmentExtraFeet_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_dashaugment_cooldown"))) {
{
fr_dashaugment_lastx = x;
fr_dashaugment_lasty = y;
fr_dashaugment_cooldown = 0;
;
fr_dashaugment_angle = (- 1);
;
fr_dashaugment_swapcooldown = 0;
fr_dashaugment_lstebutton = 0;
;
fr_dashaugment_lstnbutton = 0;
;
fr_dashaugment_lstwbutton = 0;
;
fr_dashaugment_lstsbutton = 0;
;
}
}
if ((can_walk > 0)) {
{
if ((scrFRButtonPressed(index, "east") && (fr_dashaugment_cooldown <= 0))) {
{
if (((fr_dashaugment_lstebutton >= (scrFRSourceFrame() - (7 / scrFRSourceScale()))) && (fr_dashaugment_swapcooldown <= scrFRSourceFrame()))) {
{
fr_dashaugment_swapcooldown = (scrFRSourceFrame() + (7 / scrFRSourceScale()));
;
fr_Mutations_AugmentExtraFeet_skill_gml_dash();
;
}
}
fr_dashaugment_lstebutton = scrFRSourceFrame();
;
}
}
if ((scrFRButtonPressed(index, "nort") && (fr_dashaugment_cooldown <= 0))) {
{
if (((fr_dashaugment_lstnbutton >= (scrFRSourceFrame() - (7 / scrFRSourceScale()))) && (fr_dashaugment_swapcooldown <= scrFRSourceFrame()))) {
{
fr_dashaugment_swapcooldown = (scrFRSourceFrame() + (7 / scrFRSourceScale()));
;
fr_Mutations_AugmentExtraFeet_skill_gml_dash();
;
}
}
fr_dashaugment_lstnbutton = scrFRSourceFrame();
;
}
}
if ((scrFRButtonPressed(index, "west") && (fr_dashaugment_cooldown <= 0))) {
{
if (((fr_dashaugment_lstwbutton >= (scrFRSourceFrame() - (7 / scrFRSourceScale()))) && (fr_dashaugment_swapcooldown <= scrFRSourceFrame()))) {
{
fr_dashaugment_swapcooldown = (scrFRSourceFrame() + (7 / scrFRSourceScale()));
;
fr_Mutations_AugmentExtraFeet_skill_gml_dash();
;
}
}
fr_dashaugment_lstwbutton = scrFRSourceFrame();
;
}
}
if ((scrFRButtonPressed(index, "sout") && (fr_dashaugment_cooldown <= 0))) {
{
if (((fr_dashaugment_lstsbutton >= (scrFRSourceFrame() - (7 / scrFRSourceScale()))) && (fr_dashaugment_swapcooldown <= scrFRSourceFrame()))) {
{
fr_dashaugment_swapcooldown = (scrFRSourceFrame() + (7 / scrFRSourceScale()));
;
fr_Mutations_AugmentExtraFeet_skill_gml_dash();
;
}
}
fr_dashaugment_lstsbutton = scrFRSourceFrame();
;
}
}
if ((fr_dashaugment_cooldown > 0)) {
{
speed += (1) * timescale;
fr_Mutations_AugmentExtraFeet_skill_gml_after_image();
;
fr_dashaugment_cooldown -= scrFRSourceScale();
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

// Original Mutations/AugmentExtraFeet.skill.gml:95
function fr_Mutations_AugmentExtraFeet_skill_gml_dash() {
if (scrFRButtonCheck(index, "east")) {
fr_dashaugment_angle = 000;
}
if (scrFRButtonCheck(index, "nort")) {
fr_dashaugment_angle = 090;
}
if (scrFRButtonCheck(index, "west")) {
fr_dashaugment_angle = 180;
}
if (scrFRButtonCheck(index, "sout")) {
fr_dashaugment_angle = 270;
}
if ((scrFRButtonCheck(index, "east") && scrFRButtonCheck(index, "nort"))) {
fr_dashaugment_angle = 045;
}
if ((scrFRButtonCheck(index, "nort") && scrFRButtonCheck(index, "west"))) {
fr_dashaugment_angle = 135;
}
if ((scrFRButtonCheck(index, "west") && scrFRButtonCheck(index, "sout"))) {
fr_dashaugment_angle = 225;
}
if ((scrFRButtonCheck(index, "sout") && scrFRButtonCheck(index, "east"))) {
fr_dashaugment_angle = 315;
}
var _frl__gogogo = true;
;
fr_dashaugment_length = 0;
;
while (_frl__gogogo) {
if (((collision_line(x, y, (x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle)), (y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle)), Wall, 0, 1) || collision_line(x, y, (x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle)), (y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle)), InvisiWall, 0, 1)) || (fr_dashaugment_length >= (50 * scrFRGetSkill("AugmentExtraFeet"))))) {
{
var _frl_blinklengthfix = undefined;
;
var _frl_blink50fix = undefined;
;
if ((fr_dashaugment_length >= 40)) {
{
_frl_blink50fix = (((fr_dashaugment_length - 40) / 10) * 8);
;
}
}
while (((scrFRPlaceMeeting((x + lengthdir_x(((fr_dashaugment_length - _frl_blinklengthfix) + _frl_blink50fix), fr_dashaugment_angle)), (y + lengthdir_y(((fr_dashaugment_length - _frl_blinklengthfix) + _frl_blink50fix), fr_dashaugment_angle)), Wall) || scrFRPlaceMeeting((x + lengthdir_x(((fr_dashaugment_length - _frl_blinklengthfix) + _frl_blink50fix), fr_dashaugment_angle)), (y + lengthdir_y(((fr_dashaugment_length - _frl_blinklengthfix) + _frl_blink50fix), fr_dashaugment_angle)), InvisiWall)) && (_frl_blinklengthfix <= 14))) {
_frl_blinklengthfix += 2;
;
}
_frl_blinklengthfix *= 2;
;
fr_dashaugment_length -= _frl_blinklengthfix;
;
_frl__gogogo = false;
;
}
} else {
fr_dashaugment_length += 1;
}
;
}
lastx = x;
;
lasty = y;
;
x = (x + lengthdir_x(fr_dashaugment_length, fr_dashaugment_angle));
;
y = (y + lengthdir_y(fr_dashaugment_length, fr_dashaugment_angle));
;
fr_dashaugment_cooldown = 5;
;
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentExtraFeet"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprGreenIDPDPortalCharge : sprIDPDPortalCharge));
;
image_index = scrFRSourceChoose(0, 1);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(1)) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (scrFRSourceRandomRange(5, 7)) { var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y + 10), Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
speed = (((scrFRSourceRandomRange(5, 7) * __fr_other7.fr_dashaugment_length) / 50)) * timescale;
;
var __fr_other8=scrFROther(other);
direction = (__fr_other8.fr_dashaugment_angle + scrFRSourceRandomRange((- 35), 35));
;
}
}
if(__fr_break6) break;
}}
scrFRSoundPitchVolume(sndFrogPistol, scrFRSourceRandomRange(1.25, 1.65), 0.5);
;
scrFRSoundPitchVolume(sndDogGuardianBounce, scrFRSourceRandomRange(0.50, 0.70), 0.6);
;
repeat (6) {
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentExtraFeet"].settingGreenAugments ? sprPlasmaTrail : sprPopoPlasmaTrail));
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other12=scrFROther(other);
direction = ((__fr_other12.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
speed = (scrFRSourceRandom(5)) * timescale;
;
}
}
if(__fr_break11) break;
}}
}
repeat (6) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentExtraFeet"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentExtraFeet"].sprGreenIDPDPortalCharge : sprIDPDPortalCharge));
;
image_index = scrFRSourceChoose(0, 1);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(1)) * timescale;
;
}
}
if(__fr_break15) break;
}}
}
}

// Original Mutations/AugmentExtraFeet.skill.gml:172
function fr_Mutations_AugmentExtraFeet_skill_gml_after_image() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.sprite_index);
;
var __fr_other5=scrFROther(other);
image_index = __fr_other5.image_index;
;
var __fr_other6=scrFROther(other);
image_xscale = (__fr_other6.right * __fr_other6.image_xscale);
;
var __fr_other7=scrFROther(other);
image_yscale = __fr_other7.image_yscale;
;
var __fr_other8=scrFROther(other);
image_angle = (__fr_other8.angle + __fr_other8.image_angle);
;
var __fr_other9=scrFROther(other);
image_blend = __fr_other9.image_blend;
;
var __fr_other10=scrFROther(other);
image_alpha = __fr_other10.image_alpha;
;
image_speed = (0) * timescale;
;
var __fr_other11=scrFROther(other);
depth = __fr_other11.depth;
;
on_step = fr_Mutations_AugmentExtraFeet_skill_gml_blur_step;
;
on_draw = fr_Mutations_AugmentExtraFeet_skill_gml_blur_draw;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentExtraFeet.skill.gml:187
function fr_Mutations_AugmentExtraFeet_skill_gml_blur_step() {
depth += 0.01;
;
image_alpha *= 0.5;
;
if ((image_alpha <= 0.01)) {
scrFRInstanceDestroy();
}
}

// Original Mutations/AugmentExtraFeet.skill.gml:192
function fr_Mutations_AugmentExtraFeet_skill_gml_blur_draw() {
draw_self();
}
