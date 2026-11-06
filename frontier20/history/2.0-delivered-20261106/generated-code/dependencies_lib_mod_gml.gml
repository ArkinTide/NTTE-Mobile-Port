// Original dependencies/lib.mod.gml:1
function fr_dependencies_lib_mod_gml___load() {

}

// Original dependencies/lib.mod.gml:7
function fr_dependencies_lib_mod_gml_init() { return scrFRLibBootstrap(); }

// Original dependencies/lib.mod.gml:64
function fr_dependencies_lib_mod_gml_import() { return scrFRLibImport((argument_count>0 ? argument[0] : undefined)); }

// Original dependencies/lib.mod.gml:108
function fr_dependencies_lib_mod_gml_cleanup() {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("bind_late_step")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("bind_end_step")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
}

// Original dependencies/lib.mod.gml:117
function fr_dependencies_lib_mod_gml_getRef(_frl__type=undefined, _frl__mod=undefined, _frl__name=undefined) {
fr_dependencies_lib_mod_gml_getScr(_frl__type, _frl__mod, _frl__name);
;
fr_dependencies_lib_mod_gml_getHooks(_frl__type, _frl__mod);
;
}

// Original dependencies/lib.mod.gml:127
function fr_dependencies_lib_mod_gml_getScr(_frl__type=undefined, _frl__mod=undefined, _frl__name=undefined) {
scrFRModSet(_frl__type, _frl__mod, _frl__name, fr_dependencies_lib_mod_gml_GlobalGet("scriptReferences"));
;
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeReferences")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((scrFRIndexGet(scrFRSelf(self), 0) == _frl__type) && (scrFRIndexGet(scrFRSelf(self), 1) == _frl__mod)) && (scrFRIndexGet(scrFRSelf(self), 2) == _frl__name))) {
{
return;
;
}
}
}
}
if(__fr_break3) break;
}}
array_push(fr_dependencies_lib_mod_gml_GlobalGet("activeReferences"), [_frl__type, _frl__mod, _frl__name]);
;
}

// Original dependencies/lib.mod.gml:152
function fr_dependencies_lib_mod_gml_getHooks(_frl__type=undefined, _frl__mod=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((scrFRIndexGet(scrFRSelf(self), 0) == _frl__type) && (scrFRIndexGet(scrFRSelf(self), 1) == _frl__mod))) {
{
return;
;
}
}
}
}
if(__fr_break3) break;
}}
array_push(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks"), [_frl__type, _frl__mod]);
;
}

// Original dependencies/lib.mod.gml:180
function fr_dependencies_lib_mod_gml_functionList() {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("scriptReferences")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRTrace(((scrFRIndexGet(scrFRSelf(self), 1) + ": ") + scrFRIndexGet(scrFRSelf(self), 2)));
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/lib.mod.gml:188
function fr_dependencies_lib_mod_gml_ping() { return scrFRLibPing(); }

// Original dependencies/lib.mod.gml:213
function fr_dependencies_lib_mod_gml_updateRef() {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeReferences")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRModSet(scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), scrFRIndexGet(scrFRSelf(self), 2), fr_dependencies_lib_mod_gml_GlobalGet("scriptReferences"));
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/lib.mod.gml:219
function fr_dependencies_lib_mod_gml_loadText(_frl_path=undefined) {
scrFRModLoadText(_frl_path);
;
}

// Original dependencies/lib.mod.gml:224
function fr_dependencies_lib_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "lib", _frl_name]);
;
; // macro hoisted: URL
}

// Original dependencies/lib.mod.gml:230
function fr_dependencies_lib_mod_gml_step() {
var _frl__global = scrFRMatching(FRCustomObject, "name", "libGlobal");
;
if ((((array_length(_frl__global) != 1) || (!scrFRVariableExists(scrFRIndexGet(_frl__global, 0), "lastUpdatedFrame"))) || ((scrFRSourceFrame() - scrFRIndexGet(_frl__global, 0).lastUpdatedFrame) > 1))) {
{
{ var __fr_with1 = scrFRWithValues(_frl__global), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
name = "libGlobal";
;
loadedPackages = global.fr_module_vars[$ "mod:lib"].loadedPackages;
;
scriptReferences = global.fr_module_vars[$ "mod:lib"].scriptReferences;
;
activeReferences = global.fr_module_vars[$ "mod:lib"].activeReferences;
;
activeHooks = global.fr_module_vars[$ "mod:lib"].activeHooks;
;
updateid = global.fr_module_vars[$ "mod:lib"].updateid;
;
endupdateid = global.fr_module_vars[$ "mod:lib"].endupdateid;
;
level_loading = global.fr_module_vars[$ "mod:lib"].level_loading;
;
canLoad = global.fr_module_vars[$ "mod:lib"].canLoad;
;
bind_late_step = global.fr_module_vars[$ "mod:lib"].bind_late_step;
;
bind_end_step = global.fr_module_vars[$ "mod:lib"].bind_end_step;
;
previousmutations = global.fr_module_vars[$ "mod:lib"].previousmutations;
;
persistent = true;
;
lastUpdatedFrame = scrFRSourceFrame();
;
}
}
if(__fr_break6) break;
}}
}
} else {
{
global.fr_module_vars[$ "mod:lib"].loadedPackages = fr_dependencies_lib_mod_gml_GlobalGet("loadedPackages");
;
global.fr_module_vars[$ "mod:lib"].scriptReferences = fr_dependencies_lib_mod_gml_GlobalGet("scriptReferences");
;
global.fr_module_vars[$ "mod:lib"].activeReferences = fr_dependencies_lib_mod_gml_GlobalGet("activeReferences");
;
global.fr_module_vars[$ "mod:lib"].activeHooks = fr_dependencies_lib_mod_gml_GlobalGet("activeHooks");
;
global.fr_module_vars[$ "mod:lib"].updateid = fr_dependencies_lib_mod_gml_GlobalGet("updateid");
;
global.fr_module_vars[$ "mod:lib"].endupdateid = fr_dependencies_lib_mod_gml_GlobalGet("endupdateid");
;
global.fr_module_vars[$ "mod:lib"].level_loading = fr_dependencies_lib_mod_gml_GlobalGet("level_loading");
;
global.fr_module_vars[$ "mod:lib"].canLoad = fr_dependencies_lib_mod_gml_GlobalGet("canLoad");
;
global.fr_module_vars[$ "mod:lib"].bind_late_step = fr_dependencies_lib_mod_gml_GlobalGet("bind_late_step");
;
global.fr_module_vars[$ "mod:lib"].bind_end_step = fr_dependencies_lib_mod_gml_GlobalGet("bind_end_step");
;
global.fr_module_vars[$ "mod:lib"].previousmutations = fr_dependencies_lib_mod_gml_GlobalGet("previousmutations");
;
scrFRIndexGet(_frl__global, 0).lastUpdatedFrame = scrFRSourceFrame();
;
}
}
if ((! scrFRInstanceExists(fr_dependencies_lib_mod_gml_GlobalGet("bind_late_step")))) {
{
fr_dependencies_lib_mod_gml_GlobalSet("bind_late_step", scrFRBindStep(fr_dependencies_lib_mod_gml_late_step, 0));
;
}
}
if ((! scrFRInstanceExists(fr_dependencies_lib_mod_gml_GlobalGet("bind_end_step")))) {
{
fr_dependencies_lib_mod_gml_GlobalSet("bind_end_step", scrFRBindEndStep(fr_dependencies_lib_mod_gml_end_step, 0));
;
}
}
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
fr_dependencies_lib_mod_gml_GlobalSet("level_loading", true);
;
}
} else {
if (fr_dependencies_lib_mod_gml_GlobalGet("level_loading")) {
{
fr_dependencies_lib_mod_gml_GlobalSet("level_loading", false);
;
{ var __fr_with7 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_switch_value10=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case11=-1;
if(__fr_switch_case11==-1 && __fr_switch_value10==("skill")) __fr_switch_case11=0;
if(__fr_switch_case11==-1 && __fr_switch_value10==("race")) __fr_switch_case11=1;
if(__fr_switch_case11==-1 && __fr_switch_value10==("wep")) __fr_switch_case11=2;
if(__fr_switch_case11==-1 && __fr_switch_value10==("weapon")) __fr_switch_case11=3;
if(__fr_switch_case11==-1) __fr_switch_case11=4;
switch(__fr_switch_case11) {
case 0:
{ var __fr_with12 = scrFRWithValues(GameCont), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other15=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other15, 0), scrFRIndexGet(__fr_other15, 1), "level_start"]);
;
}
}
}
}
if(__fr_break14) break;
}}
break;
;
case 1:
{ var __fr_with16 = scrFRWithValues(Player), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other19=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other19, 0), scrFRIndexGet(__fr_other19, 1), "level_start"]);
;
}
}
}
}
if(__fr_break18) break;
}}
break;
;
case 2:

case 3:
{ var __fr_with20 = scrFRWithValues(Player), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other23=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other23, 0), scrFRIndexGet(__fr_other23, 1), "level_start"], 1);
;
}
}
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "bwep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other24=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other24, 0), scrFRIndexGet(__fr_other24, 1), "level_start"], 0);
;
}
}
}
}
if(__fr_break22) break;
}}
break;
;
case 4:
{ var __fr_with25 = scrFRWithValues(GameCont), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
var __fr_other28=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other28, 0), scrFRIndexGet(__fr_other28, 1), "level_start"]);
;
}
}
if(__fr_break27) break;
}}
}
}
}
}
if(__fr_break9) break;
}}
}
}
}
var _frl_mutations = [];
;
while ((scrFRSkillAt(array_length(_frl_mutations)) != undefined)) {
array_push(_frl_mutations, scrFRSkillAt(array_length(_frl_mutations)));
;
}
{
var _frl_i = 0;
for (; ((_frl_i < array_length(fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"))) || (_frl_i < array_length(_frl_mutations))); _frl_i++) {
if ((((_frl_i >= array_length(_frl_mutations)) || (_frl_i >= array_length(fr_dependencies_lib_mod_gml_GlobalGet("previousmutations")))) || (scrFRIndexGet(fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"), _frl_i) != scrFRIndexGet(_frl_mutations, _frl_i)))) {
{
{ var __fr_with29 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break31=false;
for (var __fr_index30=0; __fr_index30<array_length(__fr_with29); ++__fr_index30) {
if(scrFRScopeExists(__fr_with29[__fr_index30])) with (__fr_with29[__fr_index30]) {
{
{ var __fr_switch_value32=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case33=-1;
if(__fr_switch_case33==-1 && __fr_switch_value32==("skill")) __fr_switch_case33=0;
if(__fr_switch_case33==-1 && __fr_switch_value32==("race")) __fr_switch_case33=1;
if(__fr_switch_case33==-1 && __fr_switch_value32==("wep")) __fr_switch_case33=2;
if(__fr_switch_case33==-1 && __fr_switch_value32==("weapon")) __fr_switch_case33=3;
if(__fr_switch_case33==-1) __fr_switch_case33=4;
switch(__fr_switch_case33) {
case 0:
{ var __fr_with34 = scrFRWithValues(GameCont), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other37=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other37, 0), scrFRIndexGet(__fr_other37, 1), "mutation_update"], _frl_mutations, fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"));
;
}
}
}
}
if(__fr_break36) break;
}}
break;
;
case 1:
{ var __fr_with38 = scrFRWithValues(Player), __fr_break40=false;
for (var __fr_index39=0; __fr_index39<array_length(__fr_with38); ++__fr_index39) {
if(scrFRScopeExists(__fr_with38[__fr_index39])) with (__fr_with38[__fr_index39]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other41=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other41, 0), scrFRIndexGet(__fr_other41, 1), "mutation_update"], _frl_mutations, fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"));
;
}
}
}
}
if(__fr_break40) break;
}}
break;
;
case 2:

case 3:
{ var __fr_with42 = scrFRWithValues(Player), __fr_break44=false;
for (var __fr_index43=0; __fr_index43<array_length(__fr_with42); ++__fr_index43) {
if(scrFRScopeExists(__fr_with42[__fr_index43])) with (__fr_with42[__fr_index43]) {
{
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other45=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other45, 0), scrFRIndexGet(__fr_other45, 1), "mutation_update"], 1, _frl_mutations, fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"));
;
}
}
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "bwep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other46=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other46, 0), scrFRIndexGet(__fr_other46, 1), "mutation_update"], 0, _frl_mutations, fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"));
;
}
}
}
}
if(__fr_break44) break;
}}
break;
;
case 4:
{ var __fr_with47 = scrFRWithValues(GameCont), __fr_break49=false;
for (var __fr_index48=0; __fr_index48<array_length(__fr_with47); ++__fr_index48) {
if(scrFRScopeExists(__fr_with47[__fr_index48])) with (__fr_with47[__fr_index48]) {
{
var __fr_other50=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other50, 0), scrFRIndexGet(__fr_other50, 1), "mutation_update"], _frl_mutations, fr_dependencies_lib_mod_gml_GlobalGet("previousmutations"));
;
}
}
if(__fr_break49) break;
}}
}
}
}
}
if(__fr_break31) break;
}}
fr_dependencies_lib_mod_gml_GlobalSet("previousmutations", _frl_mutations);
;
break;
;
}
}
}
}
{ var __fr_with51 = scrFRWithValues(Player), __fr_break53=false;
for (var __fr_index52=0; __fr_index52<array_length(__fr_with51); ++__fr_index52) {
if(scrFRScopeExists(__fr_with51[__fr_index52])) with (__fr_with51[__fr_index52]) {
{
var _frl__auto = scrFRWeaponAuto(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
;
var _frl_secondary = 0;
;
var _frl_specfire = 0;
;
var _frl_fired = 0;
;
if (((race == scrFRRaceResolve("steroids")) && (_frl__auto >= 0))) {
{
_frl__auto = true;
;
}
}
if ((((((race == scrFRRaceResolve("steroids")) && bcan_shoot) && can_spec) && (((_frl__auto && (!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), 0))) ? scrFRButtonCheck(index, "spec") : scrFRButtonPressed(index, "spec")) || usespec)) && ((scrFRIndexGet(ammo, scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"))) >= scrFRWeaponCost(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"))) || (infammo != 0)))) {
{
_frl_secondary = 1;
;
_frl_specfire = 1;
;
_frl_fired = 1;
;
}
}
if (can_shoot) {
{
if (((((race == scrFRRaceResolve("skeleton")) && can_spec) && (scrFRButtonPressed(index, "spec") || usespec)) && (scrFRWeaponCost(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) > 0))) {
{
_frl_specfire = 1;
;
_frl_fired = 1;
;
}
} else {
if ((((((race == scrFRRaceResolve("venuz")) && can_spec) && (scrFRButtonPressed(index, "spec") || usespec)) && (scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) != 0)) && ((scrFRIndexGet(ammo, scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "wep"))) >= (scrFRWeaponCost(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) * floor((2 + (2 * scrFRGetSkill(mut_throne_butt)))))) || (infammo != 0)))) {
{
_frl_specfire = 1;
;
_frl_fired = 1;
;
}
} else {
if (((can_shoot && ((_frl__auto && (!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), 0))) ? scrFRButtonCheck(index, "fire") : (clicked || scrFRButtonPressed(index, "fire")))) && ((scrFRIndexGet(ammo, scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "wep"))) >= scrFRWeaponCost(scrFRWeaponSlotRead(scrFRSelf(self), "wep"))) || (infammo != 0)))) {
{
_frl_fired = 1;
;
}
}
}
}
}
}
if (_frl_fired) {
{
{ var __fr_with54 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break56=false;
for (var __fr_index55=0; __fr_index55<array_length(__fr_with54); ++__fr_index55) {
if(scrFRScopeExists(__fr_with54[__fr_index55])) with (__fr_with54[__fr_index55]) {
{
{ var __fr_switch_value57=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case58=-1;
if(__fr_switch_case58==-1 && __fr_switch_value57==("skill")) __fr_switch_case58=0;
if(__fr_switch_case58==-1 && __fr_switch_value57==("race")) __fr_switch_case58=1;
if(__fr_switch_case58==-1 && __fr_switch_value57==("wep")) __fr_switch_case58=2;
if(__fr_switch_case58==-1 && __fr_switch_value57==("weapon")) __fr_switch_case58=3;
if(__fr_switch_case58==-1) __fr_switch_case58=4;
switch(__fr_switch_case58) {
case 0:
{ var __fr_with59 = scrFRWithValues((scrFROther(other))), __fr_break61=false;
for (var __fr_index60=0; __fr_index60<array_length(__fr_with59); ++__fr_index60) {
if(scrFRScopeExists(__fr_with59[__fr_index60])) with (__fr_with59[__fr_index60]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other62=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other62, 0), scrFRIndexGet(__fr_other62, 1), "weapon_prefire"], _frl_specfire, (_frl_secondary ? scrFRWeaponSlotRead(scrFRSelf(self), "bwep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep")));
;
}
}
}
}
if(__fr_break61) break;
}}
break;
;
case 1:
{ var __fr_with63 = scrFRWithValues((scrFROther(other))), __fr_break65=false;
for (var __fr_index64=0; __fr_index64<array_length(__fr_with63); ++__fr_index64) {
if(scrFRScopeExists(__fr_with63[__fr_index64])) with (__fr_with63[__fr_index64]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other66=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other66, 0), scrFRIndexGet(__fr_other66, 1), "weapon_prefire"], _frl_specfire, (_frl_secondary ? scrFRWeaponSlotRead(scrFRSelf(self), "bwep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep")));
;
}
}
}
}
if(__fr_break65) break;
}}
break;
;
case 2:

case 3:
{ var __fr_with67 = scrFRWithValues((scrFROther(other))), __fr_break69=false;
for (var __fr_index68=0; __fr_index68<array_length(__fr_with67); ++__fr_index68) {
if(scrFRScopeExists(__fr_with67[__fr_index68])) with (__fr_with67[__fr_index68]) {
{
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other70=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other70, 0), scrFRIndexGet(__fr_other70, 1), "weapon_prefire"], 1, _frl_specfire, (_frl_secondary ? scrFRWeaponSlotRead(scrFRSelf(self), "bwep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep")));
;
}
}
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), scrFRIndexGet((scrFROther(other)), 1)) || (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "bwep")) && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"), "wep"), scrFRIndexGet((scrFROther(other)), 1))))) {
{
var __fr_other71=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other71, 0), scrFRIndexGet(__fr_other71, 1), "weapon_prefire"], 0, _frl_specfire, (_frl_secondary ? scrFRWeaponSlotRead(scrFRSelf(self), "bwep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep")));
;
}
}
}
}
if(__fr_break69) break;
}}
break;
;
case 4:
{ var __fr_with72 = scrFRWithValues((scrFROther(other))), __fr_break74=false;
for (var __fr_index73=0; __fr_index73<array_length(__fr_with72); ++__fr_index73) {
if(scrFRScopeExists(__fr_with72[__fr_index73])) with (__fr_with72[__fr_index73]) {
{
var __fr_other75=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other75, 0), scrFRIndexGet(__fr_other75, 1), "weapon_prefire"], _frl_specfire, (_frl_secondary ? scrFRWeaponSlotRead(scrFRSelf(self), "bwep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep")));
;
}
}
if(__fr_break74) break;
}}
}
}
}
}
if(__fr_break56) break;
}}
}
}
}
}
if(__fr_break53) break;
}}
}

// Original dependencies/lib.mod.gml:426
function fr_dependencies_lib_mod_gml_late_step() {
fr_dependencies_lib_mod_gml_create_update();
;
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("skill")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("race")) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
{ var __fr_with6 = scrFRWithValues(GameCont), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other9=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other9, 0), scrFRIndexGet(__fr_other9, 1), "late_step"]);
;
}
}
}
}
if(__fr_break8) break;
}}
break;
;
case 1:
{ var __fr_with10 = scrFRWithValues(Player), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other13=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other13, 0), scrFRIndexGet(__fr_other13, 1), "late_step"]);
;
}
}
}
}
if(__fr_break12) break;
}}
break;
;
case 2:
{ var __fr_with14 = scrFRWithValues(GameCont), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var __fr_other17=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other17, 0), scrFRIndexGet(__fr_other17, 1), "late_step"]);
;
}
}
if(__fr_break16) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/lib.mod.gml:453
function fr_dependencies_lib_mod_gml_end_step() {
fr_dependencies_lib_mod_gml_create_end_update();
;
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("skill")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("race")) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
{ var __fr_with6 = scrFRWithValues(GameCont), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other9=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other9, 0), scrFRIndexGet(__fr_other9, 1), "end_step"]);
;
}
}
}
}
if(__fr_break8) break;
}}
break;
;
case 1:
{ var __fr_with10 = scrFRWithValues(Player), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other13=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other13, 0), scrFRIndexGet(__fr_other13, 1), "end_step"]);
;
}
}
}
}
if(__fr_break12) break;
}}
break;
;
case 2:
{ var __fr_with14 = scrFRWithValues(GameCont), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var __fr_other17=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other17, 0), scrFRIndexGet(__fr_other17, 1), "end_step"]);
;
}
}
if(__fr_break16) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/lib.mod.gml:480
function fr_dependencies_lib_mod_gml_create_update() {
var _frl_newID = real(scrFRInstanceCreate(0, 0, FRMarker));
;
var _frl_updateid = fr_dependencies_lib_mod_gml_GlobalGet("updateid");
;
var _frl_lastid = fr_dependencies_lib_mod_gml_GlobalGet("updateid");
;
while (((_frl_updateid++) < _frl_newID)) {
if (scrFRInstanceExists(_frl_updateid)) {
{
if (scrFRVariableExists(_frl_updateid, "object_index")) {
{
var _frl_obj = scrFRObjectIndex(_frl_updateid);
;
if ((((((scrFRObjectParent(_frl_obj) == FR_OBJECT_EFFECT) || (_frl_obj == FR_OBJECT_EFFECT)) || (scrFRObjectParent(_frl_obj) == FRBinding)) || (_frl_obj == FRBinding)) || (_frl_obj == FRCustomObject))) {
{
_frl_lastid++;
;
}
}
}
} else {
{
_frl_lastid++;
;
}
}
}
} else {
{
_frl_lastid++;
;
}
}
}
if ((_frl_newID > _frl_lastid)) {
{
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("skill")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("race")) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
{ var __fr_with6 = scrFRWithValues(GameCont), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other9=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other9, 0), scrFRIndexGet(__fr_other9, 1), "update"], fr_dependencies_lib_mod_gml_GlobalGet("updateid"), _frl_newID);
;
}
}
}
}
if(__fr_break8) break;
}}
break;
;
case 1:
{ var __fr_with10 = scrFRWithValues(Player), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other13=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other13, 0), scrFRIndexGet(__fr_other13, 1), "update"], fr_dependencies_lib_mod_gml_GlobalGet("updateid"), _frl_newID);
;
}
}
}
}
if(__fr_break12) break;
}}
break;
;
case 2:
{ var __fr_with14 = scrFRWithValues(GameCont), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var __fr_other17=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other17, 0), scrFRIndexGet(__fr_other17, 1), "update"], fr_dependencies_lib_mod_gml_GlobalGet("updateid"), _frl_newID);
;
}
}
if(__fr_break16) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}
}
fr_dependencies_lib_mod_gml_GlobalSet("updateid", _frl_newID);
;
}

// Original dependencies/lib.mod.gml:525
function fr_dependencies_lib_mod_gml_create_end_update() {
var _frl_newID = real(scrFRInstanceCreate(0, 0, FRMarker));
;
var _frl_updateid = fr_dependencies_lib_mod_gml_GlobalGet("endupdateid");
;
var _frl_lastid = fr_dependencies_lib_mod_gml_GlobalGet("endupdateid");
;
while (((_frl_updateid++) < _frl_newID)) {
if (scrFRInstanceExists(_frl_updateid)) {
{
if (scrFRVariableExists(_frl_updateid, "object_index")) {
{
var _frl_obj = scrFRObjectIndex(_frl_updateid);
;
if ((((((scrFRObjectParent(_frl_obj) == FR_OBJECT_EFFECT) || (_frl_obj == FR_OBJECT_EFFECT)) || (scrFRObjectParent(_frl_obj) == FRBinding)) || (_frl_obj == FRBinding)) || (_frl_obj == FRCustomObject))) {
{
_frl_lastid++;
;
}
}
}
} else {
{
_frl_lastid++;
;
}
}
}
} else {
{
_frl_lastid++;
;
}
}
}
if ((_frl_newID > _frl_lastid)) {
{
{ var __fr_with1 = scrFRWithValues(fr_dependencies_lib_mod_gml_GlobalGet("activeHooks")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=scrFRIndexGet(scrFRSelf(self), 0), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("skill")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("race")) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
{ var __fr_with6 = scrFRWithValues(GameCont), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (scrFRGetSkill(scrFRIndexGet((scrFROther(other)), 1))) {
{
var __fr_other9=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other9, 0), scrFRIndexGet(__fr_other9, 1), "end_update"], fr_dependencies_lib_mod_gml_GlobalGet("endupdateid"), _frl_newID);
;
}
}
}
}
if(__fr_break8) break;
}}
break;
;
case 1:
{ var __fr_with10 = scrFRWithValues(Player), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((race == scrFRRaceResolve(scrFRIndexGet((scrFROther(other)), 1)))) {
{
var __fr_other13=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other13, 0), scrFRIndexGet(__fr_other13, 1), "end_update"], fr_dependencies_lib_mod_gml_GlobalGet("endupdateid"), _frl_newID);
;
}
}
}
}
if(__fr_break12) break;
}}
break;
;
case 2:
{ var __fr_with14 = scrFRWithValues(GameCont), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var __fr_other17=scrFROther(other);
scrFRScriptCall([scrFRIndexGet(__fr_other17, 0), scrFRIndexGet(__fr_other17, 1), "end_update"], fr_dependencies_lib_mod_gml_GlobalGet("endupdateid"), _frl_newID);
;
}
}
if(__fr_break16) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}
}
fr_dependencies_lib_mod_gml_GlobalSet("endupdateid", _frl_newID);
;
}

// Original dependencies/lib.mod.gml:570
function fr_dependencies_lib_mod_gml_draw_pause() {
fr_dependencies_lib_mod_gml_create_update();
;
fr_dependencies_lib_mod_gml_create_end_update();
;
}

// Original dependencies/lib.mod.gml:574
function fr_dependencies_lib_mod_gml_chat_command(_frl_command=undefined, _frl_parameter=undefined, _frl_player=undefined) {

}

// Original dependencies/lib.mod.gml:576
function fr_dependencies_lib_mod_gml_GlobalGet(_frl__var=undefined) {
var _frl__global = scrFRMatching(FRCustomObject, "name", "libGlobal");
;
if ((array_length(_frl__global) != 1)) {
{
return scrFRModGet("mod", "lib", _frl__var);
;
}
} else {
{
return scrFRVariableGet(scrFRIndexGet(_frl__global, 0), _frl__var);
}
}
}

// Original dependencies/lib.mod.gml:584
function fr_dependencies_lib_mod_gml_GlobalSet(_frl__var=undefined, _frl__val=undefined) {
var _frl__global = scrFRMatching(FRCustomObject, "name", "libGlobal");
;
if ((array_length(_frl__global) != 1)) {
{
scrFRModSet("mod", "lib", _frl__var, _frl__val);
;
}
} else {
{
scrFRVariableSet(scrFRIndexGet(_frl__global, 0), _frl__var, _frl__val);
}
}
}
