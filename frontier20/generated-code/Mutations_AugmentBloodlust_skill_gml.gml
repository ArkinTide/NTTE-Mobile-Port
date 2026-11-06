#macro frMacro_Mutations_AugmentBloodlust_skill_gml_scr global.fr_module_vars[$ "skill:AugmentBloodlust"].scr

#macro frMacro_Mutations_AugmentBloodlust_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentBloodlust.skill.gml:1
function fr_Mutations_AugmentBloodlust_skill_gml___load() {

}

// Original Mutations/AugmentBloodlust.skill.gml:1
function fr_Mutations_AugmentBloodlust_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentBloodlust_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentBloodlust_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentBloodlust_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentBloodlust.skill.gml:15
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentBloodlust", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentBloodlust.skill.gml:14
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentBloodlust.skill.gml:14
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentBloodlust.skill.gml:14
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentBloodlust.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentBloodlust"].sprSkillIcon = sprFR_sprAugmentBloodlust_7fbbaa47ead0;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].sprSkillHud = sprFR_sprAugmentBloodlustIcon_69e025622481;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].sprAugmentBloodlustProc = sprFR_sprAugmentBloodlustProc_7b142d48487b;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].sprGreenAugmentBloodlustProc = sprFR_sprGreenAugmentBloodlust_3f5b5733d84c;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].augmentBloodlustCount = 0;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].settingGreenAugments = false;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentBloodlust.skill.gml:19
function fr_Mutations_AugmentBloodlust_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentBloodlust:0", "CARNIVOROUS ENZYMES"));
;
}

// Original Mutations/AugmentBloodlust.skill.gml:20
function fr_Mutations_AugmentBloodlust_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentBloodlust:1", "@wREGENERATE @rHP#@(color:16776960)EVERY @w13 @(color:16776960)KILLS"));
;
}

// Original Mutations/AugmentBloodlust.skill.gml:21
function fr_Mutations_AugmentBloodlust_skill_gml_skill_tip() {
return scrFRLocalize("ITS OK TO EAT NOW");
;
}

// Original Mutations/AugmentBloodlust.skill.gml:22
function fr_Mutations_AugmentBloodlust_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentBloodlust"].sprSkillIcon);
;
}

// Original Mutations/AugmentBloodlust.skill.gml:23
function fr_Mutations_AugmentBloodlust_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentBloodlust"].sprSkillHud;
;
}

// Original Mutations/AugmentBloodlust.skill.gml:24
function fr_Mutations_AugmentBloodlust_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentBloodlust.skill.gml:25
function fr_Mutations_AugmentBloodlust_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentBloodlust.skill.gml:26
function fr_Mutations_AugmentBloodlust_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentBloodlust.skill.gml:27
function fr_Mutations_AugmentBloodlust_skill_gml_skill_augment() {
return mut_bloodlust;
;
}

// Original Mutations/AugmentBloodlust.skill.gml:29
function fr_Mutations_AugmentBloodlust_skill_gml_skill_lose() {
global.fr_module_vars[$ "skill:AugmentBloodlust"].augmentBloodlustCount = 0;
;
}

// Original Mutations/AugmentBloodlust.skill.gml:32
function fr_Mutations_AugmentBloodlust_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatchingLE(enemy, "my_health", 0), "fr_AugmentBloodlust", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_AugmentBloodlust = true;
;
global.fr_module_vars[$ "skill:AugmentBloodlust"].augmentBloodlustCount += 1;
;
}
}
if(__fr_break3) break;
}}
if ((global.fr_module_vars[$ "skill:AugmentBloodlust"].augmentBloodlustCount >= 13)) {
{
global.fr_module_vars[$ "skill:AugmentBloodlust"].augmentBloodlustCount = 0;
;
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentBloodlust"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentBloodlust"].sprGreenAugmentBloodlustProc : global.fr_module_vars[$ "skill:AugmentBloodlust"].sprAugmentBloodlustProc));
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitch(sndBloodlustProc, 1.2);
;
scrFRSoundPitchVolume(sndGruntFire, 0.7, 0.5);
;
if ((hp < max_hp)) {
{
hp += scrFRGetSkill("AugmentBloodlust");
;
}
}
if ((hp >= max_hp)) {
{
frMacro_Mutations_AugmentBloodlust_skill_gml_call(frMacro_Mutations_AugmentBloodlust_skill_gml_scr.pickup_text, "HP", "max");
}
} else {
{
frMacro_Mutations_AugmentBloodlust_skill_gml_call(frMacro_Mutations_AugmentBloodlust_skill_gml_scr.pickup_text, "HP", "add", 1);
}
}
}
}
if(__fr_break6) break;
}}
}
}
}
