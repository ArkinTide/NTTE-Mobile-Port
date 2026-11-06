// Original Mutations/AugmentHeavyHeart.skill.gml:1
function fr_Mutations_AugmentHeavyHeart_skill_gml___load() {

}

// Original Mutations/AugmentHeavyHeart.skill.gml:1
function fr_Mutations_AugmentHeavyHeart_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentHeavyHeart"].sprSkillIcon = sprFR_sprAugmentHeavyHeart_4bacc9ede229;
;
global.fr_module_vars[$ "skill:AugmentHeavyHeart"].sprSkillHud = sprFR_sprAugmentHeavyHeartIcon_c7f4191de0ac;
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:7
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_name() {
return loc("Frontier:AugmentHeavyHeart:0", "ARMAMENT EJECTOR");
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:8
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_text() {
return loc("Frontier:AugmentHeavyHeart:1", "@sFRESH @wWEAPON DROPS#@sFIRE @(color:16776960)MICROMISSILES");
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:9
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_tip() {
return "I LOVE RECYCLING!!";
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:10
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentHeavyHeart"].sprSkillIcon);
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:11
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentHeavyHeart"].sprSkillHud;
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:12
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:13
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:14
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:15
function fr_Mutations_AugmentHeavyHeart_skill_gml_skill_augment() {
return mut_heavy_heart;
;
}

// Original Mutations/AugmentHeavyHeart.skill.gml:17
function fr_Mutations_AugmentHeavyHeart_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(WepPickup, "fr_augmentHeavyHeart", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_augmentHeavyHeart = true;
;
if ((ammo > 0)) {
{
fr_Mutations_AugmentHeavyHeart_skill_gml_AugmentMissileController_create(x, y);
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentHeavyHeart.skill.gml:26
function fr_Mutations_AugmentHeavyHeart_skill_gml_AugmentMissileController_create(_frl__x=undefined, _frl__y=undefined) {
scrFRSoundPitchVolume(sndRocketFly, 1.4, 2);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
var _frl_myPlayer = instance_nearest(x, y, Player);
team = _frl_myPlayer.team;
;
missiles = (8 * scrFRGetSkill("AugmentHeavyHeart"));
on_step = fr_Mutations_AugmentHeavyHeart_skill_gml_AugmentMissileController_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentHeavyHeart.skill.gml:37
function fr_Mutations_AugmentHeavyHeart_skill_gml_AugmentMissileController_step() {
if ((missiles > 0)) {
{
missiles -= (4 * scrFRSourceScale());
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "PopoRocketSmall_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
}
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}
