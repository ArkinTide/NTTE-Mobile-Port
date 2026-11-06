#macro frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_scr global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].scr

#macro frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_call scrFRScriptCall

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:1
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml___load() {

}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:1
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/BurdenAutomotiveApocalypse.skill.gml:10
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "BurdenAutomotiveApocalypse", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/BurdenAutomotiveApocalypse.skill.gml:9
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/BurdenAutomotiveApocalypse.skill.gml:9
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/BurdenAutomotiveApocalypse.skill.gml:9
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/BurdenAutomotiveApocalypse.skill.gml:4
{
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].sprSkillIcon = sprFR_sprBurden_780c79a91ee6;
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].sprSkillHud = sprFR_sprBurdenPelagicPredicam_fc6a5d58fa9f;
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:14
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_name() {
return "AUTOMOTIVE APOCALYPSE";
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:15
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_text() {
return "@q@(color:2832791)ROAD RAGE";
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:16
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_tip() {
return "WRENCH CAN'T FIX IT";
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:17
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].sprSkillIcon);
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:18
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].sprSkillHud;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:19
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_avail() {
return 0;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:20
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:21
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:22
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_burden() {
return true;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:24
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_skill_take() {
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].level_start = false;
;
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:27
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].level_start = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].level_start) {
{
var _frl__normalArea = ((((GameCont.hard > 1) && (scrFRInstanceNumber(enemy) > scrFRInstanceNumber(HostileHorror))) && (! (GameCont.area == scrFRAreaTryResolve("deeplabs")))) && (GameCont.area != scrFRAreaTryResolve("village")));
;
global.fr_module_vars[$ "skill:BurdenAutomotiveApocalypse"].level_start = false;
;
if (_frl__normalArea) {
{
repeat (scrFRSourceIRandomRange(16, (24 * scrFRGetSkill("BurdenAutomotiveApocalypse")))) { var __fr_with1 = scrFRWithValues(frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_call(frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_scr.instance_random, scrFRMatchingNE(scrFRMatching(Floor, "object_index", Floor), "fr_autoparts", true))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((! scrFRPlaceMeeting(x, y, prop)) && (! scrFRPlaceMeeting(x, y, chestprop))) && (point_distance(x, y, 10000, 10000) > 128))) {
{
fr_autoparts = true;
;
scrFRInstanceCreate((x + 16), (y + 16), Car);
}
}
}
}
if(__fr_break3) break;
}}
repeat (scrFRSourceIRandomRange(3, (12 * scrFRGetSkill("BurdenAutomotiveApocalypse")))) { var __fr_with4 = scrFRWithValues(frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_call(frMacro_Mutations_BurdenAutomotiveApocalypse_skill_gml_scr.instance_random, scrFRMatchingNE(scrFRMatching(Floor, "object_index", Floor), "fr_minibot", true))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((((! scrFRPlaceMeeting(x, y, prop)) && (! scrFRPlaceMeeting(x, y, chestprop))) && (point_distance(x, y, 10000, 10000) > 128))) {
{
fr_minibot = true;
;
fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_MicroSnowbot_create((x + 16), (y + 16));
}
}
}
}
if(__fr_break6) break;
}}
}
}
}
}
}
}

// Original Mutations/BurdenAutomotiveApocalypse.skill.gml:51
function fr_Mutations_BurdenAutomotiveApocalypse_skill_gml_MicroSnowbot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, SnowBot)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.5;
;
image_yscale = 0.5;
;
scrFRMaxHealthWrite(id, 2, "=");
;
hp = max_hp;
;
}
}
if(__fr_break3) break;
}}
}
