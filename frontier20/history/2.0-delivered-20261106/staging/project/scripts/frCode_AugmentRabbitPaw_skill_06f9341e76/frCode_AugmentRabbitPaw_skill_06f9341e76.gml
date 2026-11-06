// Original Mutations/AugmentRabbitPaw.skill.gml:1
function fr_Mutations_AugmentRabbitPaw_skill_gml___load() {

}

// Original Mutations/AugmentRabbitPaw.skill.gml:1
function fr_Mutations_AugmentRabbitPaw_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentRabbitPaw"].sprSkillIcon = sprFR_sprAugmentRabbitPaw_274c2b16280f;
;
global.fr_module_vars[$ "skill:AugmentRabbitPaw"].sprSkillHud = sprFR_sprAugmentRabbitPawIcon_89c7e857d2fb;
;
global.fr_module_vars[$ "skill:AugmentRabbitPaw"].settingGreenAugments = false;
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:9
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_name() {
return loc("Frontier:AugmentRabbitPaw:0", "MICRO REFINERY");
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:10
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_text() {
return loc("Frontier:AugmentRabbitPaw:1", "@wSOME PICKUPS @sARE @(color:16776960)UPGRADED");
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:11
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_tip() {
return "FROM TRASH TO TREASURE";
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:12
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentRabbitPaw"].sprSkillIcon);
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:13
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentRabbitPaw"].sprSkillHud;
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:14
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:15
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:16
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:17
function fr_Mutations_AugmentRabbitPaw_skill_gml_skill_augment() {
return mut_rabbit_paw;
;
}

// Original Mutations/AugmentRabbitPaw.skill.gml:19
function fr_Mutations_AugmentRabbitPaw_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(AmmoPickup, "fr_augmentRabbitPaw_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_augmentRabbitPaw_check = true;
;
if ((scrFRSourceRandom(4) < 1)) {
{
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
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentRabbitPaw"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(HPPickup, "fr_augmentRabbitPaw_check", undefined)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_augmentRabbitPaw_check = true;
;
if ((scrFRSourceRandom(5) < 2)) {
{
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
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
image_blend = (global.fr_module_vars[$ "skill:AugmentRabbitPaw"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break12) break;
}}
}
}
}
}
if(__fr_break9) break;
}}
}
