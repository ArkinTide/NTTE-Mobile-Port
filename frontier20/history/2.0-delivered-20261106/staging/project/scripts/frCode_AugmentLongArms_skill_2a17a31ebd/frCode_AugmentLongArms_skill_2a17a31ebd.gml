// Original Mutations/AugmentLongArms.skill.gml:1
function fr_Mutations_AugmentLongArms_skill_gml___load() {

}

// Original Mutations/AugmentLongArms.skill.gml:1
function fr_Mutations_AugmentLongArms_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentLongArms"].sprSkillIcon = sprFR_sprAugmentLongArms_6ef9d6a002ef;
global.fr_module_vars[$ "skill:AugmentLongArms"].sprSkillHud = sprFR_sprAugmentLongArmsIcon_107ce3799861;
}

// Original Mutations/AugmentLongArms.skill.gml:5
function fr_Mutations_AugmentLongArms_skill_gml_skill_name() {
return loc("Frontier:AugmentLongArms:0", "PHOTON BLADES");
;
}

// Original Mutations/AugmentLongArms.skill.gml:6
function fr_Mutations_AugmentLongArms_skill_gml_skill_text() {
return loc("Frontier:AugmentLongArms:1", "@wMELEE ATTACKS @sCREATE#@(color:16776960)AFTERSHOCKS");
;
}

// Original Mutations/AugmentLongArms.skill.gml:7
function fr_Mutations_AugmentLongArms_skill_gml_skill_tip() {
return "HIGH SPEED DISSECTION";
;
}

// Original Mutations/AugmentLongArms.skill.gml:8
function fr_Mutations_AugmentLongArms_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentLongArms"].sprSkillIcon);
;
}

// Original Mutations/AugmentLongArms.skill.gml:9
function fr_Mutations_AugmentLongArms_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentLongArms"].sprSkillHud;
;
}

// Original Mutations/AugmentLongArms.skill.gml:10
function fr_Mutations_AugmentLongArms_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentLongArms.skill.gml:11
function fr_Mutations_AugmentLongArms_skill_gml_skill_wepspec() {
return 1;
;
}

// Original Mutations/AugmentLongArms.skill.gml:12
function fr_Mutations_AugmentLongArms_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentLongArms.skill.gml:13
function fr_Mutations_AugmentLongArms_skill_gml_skill_augment() {
return mut_long_arms;
;
}

// Original Mutations/AugmentLongArms.skill.gml:15
function fr_Mutations_AugmentLongArms_skill_gml_step() {
var _frl_inst = [Slash, LightningSlash, EnergySlash, EnergyHammerSlash, BloodSlash, Shank, EnergyShank, FR_OBJECT_GUITAR_SLASH];
;
var _frl_inst2 = scrFRMatching(FRCustomSlash, "is_melee", true);
;
if (array_length(_frl_inst2)) {
{
{ var __fr_with1 = scrFRWithValues(_frl_inst2), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(_frl_inst, scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRMatching(scrFRMatching(_frl_inst, "zelda", undefined), "team", team)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
zelda = true;
;
fr_Mutations_AugmentLongArms_skill_gml_aftershock();
;
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break6) break;
}}
}

// Original Mutations/AugmentLongArms.skill.gml:31
function fr_Mutations_AugmentLongArms_skill_gml_aftershock() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.sprite_index);
;
image_index = 0;
;
image_speed = (0) * timescale;
;
var __fr_other5=scrFROther(other);
image_xscale = (__fr_other5.image_xscale * 0.9);
;
var __fr_other6=scrFROther(other);
image_yscale = (__fr_other6.image_yscale * 0.95);
;
image_alpha = 0;
;
speed = (0) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
var __fr_other7=scrFROther(other);
direction = __fr_other7.direction;
;
var __fr_other8=scrFROther(other);
image_angle = __fr_other8.image_angle;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10.creator;
;
var __fr_other11=scrFROther(other);
damage = max(1, round(((__fr_other11.damage * 0.15) * scrFRGetSkill("AugmentLongArms"))));
;
timer = 2;
;
var __fr_other12=scrFROther(other);
stored_mask = __fr_other12.mask_index;
;
mask_index = mskNone;
;
speedcap = 8;
;
hitlist = [];
;
on_step = fr_Mutations_AugmentLongArms_skill_gml_aftershock_step;
on_wall = fr_Mutations_AugmentLongArms_skill_gml_aftershock_wall;
on_hit = fr_Mutations_AugmentLongArms_skill_gml_aftershock_hit;
on_draw = fr_Mutations_AugmentLongArms_skill_gml_aftershock_draw;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentLongArms.skill.gml:62
function fr_Mutations_AugmentLongArms_skill_gml_aftershock_step() {
xprevious = (x + ((hspeed / timescale) * 0.4));
;
yprevious = (y + ((vspeed / timescale) * 0.4));
;
if ((timer != (- 1))) {
timer = max(0, (timer - scrFRSourceScale()));
}
if ((timer == 0)) {
{
timer = (- 1);
;
image_alpha = 0.6;
;
mask_index = stored_mask;
;
speed = (22) * timescale;
;
friction = (1.5) * (timescale * timescale);
;
}
} else {
if ((timer == (- 1))) {
{
if (((speed / timescale) <= speedcap)) {
{
image_speed = (0.4) * timescale;
;
if (((image_index + (image_speed / timescale)) >= image_number)) {
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
}
}
}

// Original Mutations/AugmentLongArms.skill.gml:87
function fr_Mutations_AugmentLongArms_skill_gml_aftershock_wall() {
speed *= 0.8;
;
}

// Original Mutations/AugmentLongArms.skill.gml:90
function fr_Mutations_AugmentLongArms_skill_gml_aftershock_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var _frl_n_h = (scrFROther(other)).nexthurt;
;
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, 5, direction);
;
var __fr_other2=scrFROther(other);
array_push(hitlist, __fr_other2);
;
var __fr_other3=scrFROther(other);
__fr_other3.nexthurt = _frl_n_h;
;
}
}
}

// Original Mutations/AugmentLongArms.skill.gml:98
function fr_Mutations_AugmentLongArms_skill_gml_aftershock_draw() {
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, (image_alpha * 0.75));
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * 1.2), (image_yscale * 1.2), image_angle, c_white, (image_alpha * 0.6));
gpu_set_blendmode(bm_normal);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * 0.9), (image_yscale * 0.9), image_angle, c_white, (image_alpha * 0.3));
}
