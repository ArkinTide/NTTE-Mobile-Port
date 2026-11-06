// Original Mutations/AugmentGammaGuts.skill.gml:1
function fr_Mutations_AugmentGammaGuts_skill_gml___load() {

}

// Original Mutations/AugmentGammaGuts.skill.gml:1
function fr_Mutations_AugmentGammaGuts_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprSkillIcon = sprFR_sprAugmentGammaGuts_9bcc57716b6b;
;
global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprSkillHud = sprFR_sprAugmentGammaGutsIcon_f05d620dde91;
;
global.fr_module_vars[$ "skill:AugmentGammaGuts"].mskRadius = sprFR_mskAugmentGammaGutsRadiu_615403de20a1;
;
global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprRadius = sprFR_sprAugmentGammaGutsRadiu_7a1290ce11f1;
;
global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprGreenRadius = sprFR_sprGreenAugmentGammaGuts_aeaf19fb37ec;
;
global.fr_module_vars[$ "skill:AugmentGammaGuts"].settingGreenAugments = false;
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:13
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_name() {
return loc("Frontier:AugmentGammaGuts:0", "NANITE SWARM");
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:14
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_text() {
return loc("Frontier:AugmentGammaGuts:1", "@wDEAL @(color:16776960)BONUS DAMAGE#@wTO @(color:16776960)NEARBY @wENEMIES");
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:15
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_tip() {
return "NONE IS MORE FUN";
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:16
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprSkillIcon);
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:17
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprSkillHud;
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:18
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:19
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:20
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:21
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_augment() {
return mut_gamma_guts;
;
}

// Original Mutations/AugmentGammaGuts.skill.gml:23
function fr_Mutations_AugmentGammaGuts_skill_gml_skill_lose() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomProjectile, "name", "fr_augmentGammaGutsRadius")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentGammaGuts.skill.gml:28
function fr_Mutations_AugmentGammaGuts_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "fr_augmentGammaGutsRadius")) || (! scrFRInstanceExists(fr_augmentGammaGutsRadius)))) {
{
fr_augmentGammaGutsRadius = fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_create(x, y, scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentGammaGuts.skill.gml:35
function fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_create(_frl__x=undefined, _frl__y=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_augmentGammaGutsRadius";
;
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentGammaGuts"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprGreenRadius : global.fr_module_vars[$ "skill:AugmentGammaGuts"].sprRadius));
;
depth = (- 10);
;
image_alpha = 0;
;
mask_index = global.fr_module_vars[$ "skill:AugmentGammaGuts"].mskRadius;
;
creator = _frl__owner;
;
team = creator.team;
;
typ = (- 1);
;
damage = 0;
;
on_anim = fr_Mutations_AugmentGammaGuts_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_endstep;
;
on_wall = fr_Mutations_AugmentGammaGuts_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_hit;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentGammaGuts.skill.gml:57
function fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_endstep() {
if (scrFRInstanceExists(creator)) {
{
x = creator.x;
;
y = creator.y;
;
}
} else {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}

// Original Mutations/AugmentGammaGuts.skill.gml:73
function fr_Mutations_AugmentGammaGuts_skill_gml_DamageRadius_hit() {
if (scrFRVariableExists((scrFROther(other)), "my_health")) {
{
var __fr_other1=scrFROther(other);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", __fr_other1, scrFRModGet("mod", "Frontier_StatusEffects", "debuffAugmentGammaGuts"), 3);
}
}
}

// Original Mutations/AugmentGammaGuts.skill.gml:83
function fr_Mutations_AugmentGammaGuts_skill_gml_nothing() {

}
