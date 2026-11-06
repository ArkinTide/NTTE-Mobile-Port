// Original Mutations/AugmentEagleEyes.skill.gml:1
function fr_Mutations_AugmentEagleEyes_skill_gml___load() {

}

// Original Mutations/AugmentEagleEyes.skill.gml:1
function fr_Mutations_AugmentEagleEyes_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentEagleEyes"].sprSkillIcon = sprFR_sprAugmentEagleEyes_212c6812b4db;
;
global.fr_module_vars[$ "skill:AugmentEagleEyes"].sprSkillHud = sprFR_sprAugmentEagleEyesIcon_ae3e0e9047d2;
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:7
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_name() {
return loc("Frontier:AugmentEagleEyes:0", "HURRICANE ROCKET SYSTEM");
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:8
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_text() {
return loc("Frontier:AugmentEagleEyes:1", "@wCHANCE TO FIRE @(color:16776960)MICROMISSILES#@wWHEN SPENDING OR GAINING @yAMMO");
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:9
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_tip() {
return "SOPHISTICATED TRACKING SOFTWARE";
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:10
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentEagleEyes"].sprSkillIcon);
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:11
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentEagleEyes"].sprSkillHud;
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:12
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:13
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_wepspec() {
return 1;
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:14
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:15
function fr_Mutations_AugmentEagleEyes_skill_gml_skill_augment() {
return mut_eagle_eyes;
;
}

// Original Mutations/AugmentEagleEyes.skill.gml:17
function fr_Mutations_AugmentEagleEyes_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentEagleEyes_chanceBoost"))) {
{
fr_augmentEagleEyes_prevBullet = scrFRIndexGet(ammo, 1);
;
fr_augmentEagleEyes_prevShell = scrFRIndexGet(ammo, 2);
;
fr_augmentEagleEyes_prevExplo = scrFRIndexGet(ammo, 3);
;
fr_augmentEagleEyes_prevBolt = scrFRIndexGet(ammo, 4);
;
fr_augmentEagleEyes_prevEnergy = scrFRIndexGet(ammo, 5);
;
fr_augmentEagleEyes_chanceBoost = 0;
;
}
}
if ((((((scrFRIndexGet(ammo, 1) != fr_augmentEagleEyes_prevBullet) || (scrFRIndexGet(ammo, 2) != fr_augmentEagleEyes_prevShell)) || (scrFRIndexGet(ammo, 3) != fr_augmentEagleEyes_prevExplo)) || (scrFRIndexGet(ammo, 4) != fr_augmentEagleEyes_prevBolt)) || (scrFRIndexGet(ammo, 5) != fr_augmentEagleEyes_prevEnergy))) {
{
fr_augmentEagleEyes_prevBullet = scrFRIndexGet(ammo, 1);
;
fr_augmentEagleEyes_prevShell = scrFRIndexGet(ammo, 2);
;
fr_augmentEagleEyes_prevExplo = scrFRIndexGet(ammo, 3);
;
fr_augmentEagleEyes_prevBolt = scrFRIndexGet(ammo, 4);
;
fr_augmentEagleEyes_prevEnergy = scrFRIndexGet(ammo, 5);
;
if ((scrFRSourceRandom((8 - fr_augmentEagleEyes_chanceBoost)) < scrFRGetSkill("AugmentEagleEyes"))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "PopoRocketSmall_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
direction = (__fr_other8.gunangle + (scrFRSourceRandomRange((- 8), 8) * __fr_other8.accuracy));
;
image_angle = direction;
;
}
}
if(__fr_break6) break;
}}
fr_augmentEagleEyes_chanceBoost = 0;
;
}
} else {
{
fr_augmentEagleEyes_chanceBoost += 1;
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
