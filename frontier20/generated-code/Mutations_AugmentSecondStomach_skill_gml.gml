// Original Mutations/AugmentSecondStomach.skill.gml:1
function fr_Mutations_AugmentSecondStomach_skill_gml___load() {

}

// Original Mutations/AugmentSecondStomach.skill.gml:1
function fr_Mutations_AugmentSecondStomach_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentSecondStomach"].sprSkillIcon = sprFR_sprAugmentSecondStomach_d330b6157b4f;
;
global.fr_module_vars[$ "skill:AugmentSecondStomach"].sprSkillHud = sprFR_sprAugmentSecondStomachI_f7ff969352c3;
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:7
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentSecondStomach:0", "SHELLULAR DIVISION"));
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:8
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentSecondStomach:1", "@wMORE @yAMMO @sFROM PICKUPS"));
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:9
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_tip() {
return scrFRLocalize("TWICE AS NICE");
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:10
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentSecondStomach"].sprSkillIcon);
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:11
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentSecondStomach"].sprSkillHud;
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:12
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:13
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:14
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:15
function fr_Mutations_AugmentSecondStomach_skill_gml_skill_augment() {
return mut_second_stomach;
;
}

// Original Mutations/AugmentSecondStomach.skill.gml:17
function fr_Mutations_AugmentSecondStomach_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(AmmoPickup, "fr_augmentSecondStomach_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_augmentSecondStomach_check = true;
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
}
}
if(__fr_break3) break;
}}
}
