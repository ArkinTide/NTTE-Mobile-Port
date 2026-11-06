#macro frMacro_Mutations_AugmentLuckyShot_skill_gml_scr global.fr_module_vars[$ "skill:AugmentLuckyShot"].scr

#macro frMacro_Mutations_AugmentLuckyShot_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentLuckyShot.skill.gml:1
function fr_Mutations_AugmentLuckyShot_skill_gml___load() {

}

// Original Mutations/AugmentLuckyShot.skill.gml:1
function fr_Mutations_AugmentLuckyShot_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentLuckyShot_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentLuckyShot_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentLuckyShot_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentLuckyShot.skill.gml:15
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentLuckyShot", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentLuckyShot.skill.gml:14
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentLuckyShot.skill.gml:14
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentLuckyShot.skill.gml:14
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentLuckyShot.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprSkillIcon = sprFR_sprAugmentLuckyShot_47bb962e4c51;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprSkillHud = sprFR_sprAugmentLuckyShotIcon_df2e18e322cc;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprAugmentLuckyShotProc = sprFR_sprAugmentLuckyShotProc_eb913490ab01;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprGreenAugmentLuckyShotProc = sprFR_sprGreenAugmentLuckyShot_b1d08afa3567;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].augmentLuckyShotCount = 0;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].settingGreenAugments = false;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentLuckyShot.skill.gml:19
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLuckyShot:0", "DETRITUS ROUNDS"));
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:20
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLuckyShot:1", "@wREGENERATE @yAMMO#@(color:16776960)EVERY @w13 @(color:16776960)KILLS"));
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:21
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_tip() {
return scrFRLocalize("BONES TO BULLETS");
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:22
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprSkillIcon);
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:23
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprSkillHud;
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:24
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:25
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:26
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:27
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_augment() {
return mut_lucky_shot;
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:29
function fr_Mutations_AugmentLuckyShot_skill_gml_skill_lose() {
global.fr_module_vars[$ "skill:AugmentLuckyShot"].augmentLuckyShotCount = 0;
;
}

// Original Mutations/AugmentLuckyShot.skill.gml:32
function fr_Mutations_AugmentLuckyShot_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatchingLE(enemy, "my_health", 0), "fr_AugmentLuckyShot", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_AugmentLuckyShot = true;
;
global.fr_module_vars[$ "skill:AugmentLuckyShot"].augmentLuckyShotCount += 1;
;
}
}
if(__fr_break3) break;
}}
if ((global.fr_module_vars[$ "skill:AugmentLuckyShot"].augmentLuckyShotCount >= (13 / scrFRGetSkill("AugmentLuckyShot")))) {
{
global.fr_module_vars[$ "skill:AugmentLuckyShot"].augmentLuckyShotCount = 0;
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
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentLuckyShot"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprGreenAugmentLuckyShotProc : global.fr_module_vars[$ "skill:AugmentLuckyShot"].sprAugmentLuckyShotProc));
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitch(sndLuckyShotProc, 1.2);
scrFRSoundPitchVolume(sndGruntFire, 0.7, 0.5);
var _frl__type = scrFRSourceIRandomRange(1, 5);
;
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [_frl__type], min((scrFRIndexGet(ammo, _frl__type) + scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_ammo"), _frl__type)), scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), _frl__type)), "=");
;
if ((scrFRIndexGet(ammo, _frl__type) >= scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), _frl__type))) {
{
frMacro_Mutations_AugmentLuckyShot_skill_gml_call(frMacro_Mutations_AugmentLuckyShot_skill_gml_scr.pickup_text, scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_name"), _frl__type), "max");
}
} else {
{
frMacro_Mutations_AugmentLuckyShot_skill_gml_call(frMacro_Mutations_AugmentLuckyShot_skill_gml_scr.pickup_text, scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_name"), _frl__type), "add", scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_ammo"), _frl__type));
}
}
}
}
if(__fr_break6) break;
}}
}
}
}
