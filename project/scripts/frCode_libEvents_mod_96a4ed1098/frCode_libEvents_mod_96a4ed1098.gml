#macro frMacro_dependencies_libEvents_mod_gml_infinity (1 / 0)

#macro frMacro_dependencies_libEvents_mod_gml_spr global.fr_module_vars[$ "mod:libEvents"].spr

#macro frMacro_dependencies_libEvents_mod_gml_msk frMacro_dependencies_libEvents_mod_gml_spr.msk

#macro frMacro_dependencies_libEvents_mod_gml_snd global.fr_module_vars[$ "mod:libEvents"].snd

#macro frMacro_dependencies_libEvents_mod_gml_mus frMacro_dependencies_libEvents_mod_gml_snd.mus

#macro frMacro_dependencies_libEvents_mod_gml_lag global.fr_module_vars[$ "mod:libEvents"].debug_lag

#macro frMacro_dependencies_libEvents_mod_gml_event_tip global.fr_module_vars[$ "mod:libEvents"].event_tip

#macro frMacro_dependencies_libEvents_mod_gml_event_list global.fr_module_vars[$ "mod:libEvents"].event_list

// Original dependencies/libEvents.mod.gml:1
function fr_dependencies_libEvents_mod_gml___load() {

}

// Original dependencies/libEvents.mod.gml:28
function fr_dependencies_libEvents_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libEvents", _frl_name]);
;
}

// Original dependencies/libEvents.mod.gml:31
function fr_dependencies_libEvents_mod_gml_init() {
; // macro hoisted: infinity
fr_dependencies_libEvents_mod_gml_addScript("event_add");
;
fr_dependencies_libEvents_mod_gml_addScript("event_add_ext");
;
fr_dependencies_libEvents_mod_gml_addScript("event_set_active");
;
fr_dependencies_libEvents_mod_gml_addScript("event_get_active");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libEvents"].isLoaded = true;
;
frMacro_dependencies_libEvents_mod_gml_event_tip = ("@(color:" + string(make_color_rgb(175, 143, 106)) + ")");
;
frMacro_dependencies_libEvents_mod_gml_event_list = [];
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libEvents", "scr");
;
}

// Original dependencies/libEvents.mod.gml:50
function fr_dependencies_libEvents_mod_gml_update(_frl__newID=undefined) {
if(scrFRGenerationEventsSkip()) return;
if(scrFRContinueEventsRestore()) return;

if ((scrFRInstanceExists(GenCont) && (GenCont.id > _frl__newID))) {
{
var _frl__list = frMacro_dependencies_libEvents_mod_gml_event_list;
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__list)); _frl_i++) {
var _frl__scrt = scrFRIndexGet(_frl__list, _frl_i);
var _frl__modType = scrFRIndexGet(_frl__scrt, 0);
var _frl__modName = scrFRIndexGet(_frl__scrt, 1);
var _frl__name = scrFRIndexGet(_frl__scrt, 2);
var _frl__area = scrFRModCall(_frl__modType, _frl__modName, (_frl__name + "_area"));
;
var _frl__check = false;
;
if (((is_undefined(_frl__area) && (((scrFRSourceAreaIsReal(GameCont.area) && (GameCont.area != scrFRAreaTryResolve(0))) && ((GameCont.area != scrFRAreaTryResolve(7)) || (GameCont.subarea != 3))) || (scrFRSourceAreaIsString(GameCont.area) && ((! scrFRScriptExists("area", GameCont.area, "area_special")) || (! scrFRModCall("area", GameCont.area, "area_special")))))) || (GameCont.area == scrFRAreaTryResolve(_frl__area)))) {
{
_frl__check = true;
;
}
} else {
if (is_array(_frl__area)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__area), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((GameCont.area == scrFRAreaTryResolve(scrFRSelf(self)))) {
{
_frl__check = true;
;
__fr_break3=true; break;
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
}
if (_frl__check) {
{
var _frl__hard = scrFRModCall(_frl__modType, _frl__modName, (_frl__name + "_hard"));
;
if ((GameCont.hard >= (is_undefined(_frl__hard) ? 2 : _frl__hard))) {
{
var _frl__chance = 1;
;
if (scrFRScriptExists(_frl__modType, _frl__modName, (_frl__name + "_chance"))) {
{
_frl__chance = scrFRModCall(_frl__modType, _frl__modName, (_frl__name + "_chance"));
;
}
}
if (fr_dependencies_libEvents_mod_gml_chance(_frl__chance, 1)) {
{
fr_dependencies_libEvents_mod_gml_event_set_active(_frl__modType, _frl__modName, _frl__name, true);
;
}
}
}
}
}
}
}
}
}
}
}

// Original dependencies/libEvents.mod.gml:97
function fr_dependencies_libEvents_mod_gml_level_start() {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libEvents_mod_gml_event_get_active(all)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
x = 0;
;
y = 0;
;
on_step = scrFRScriptRefExt(mod_type, mod_name, (event + "_step"));
;
on_cleanup = scrFRScriptRefExt(mod_type, mod_name, (event + "_cleanup"));
;
var _frl__minID = scrFRInstanceCreate(0, 0, FRMarker);
;
scrFRModCall(mod_type, mod_name, (event + "_create"));
;
floors = scrFRMatchingGT(Floor, "id", _frl__minID);
;
if (((x == 0) && (y == 0))) {
{
if ((array_length(floors) > 0)) {
{
var _frl__x1 = (+ frMacro_dependencies_libEvents_mod_gml_infinity);
var _frl__y1 = (+ frMacro_dependencies_libEvents_mod_gml_infinity);
var _frl__x2 = (- frMacro_dependencies_libEvents_mod_gml_infinity);
var _frl__y2 = (- frMacro_dependencies_libEvents_mod_gml_infinity);
;
{ var __fr_with4 = scrFRWithValues(floors), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((_frl__x1 > bbox_left)) {
_frl__x1 = bbox_left;
}
if ((_frl__y1 > bbox_top)) {
_frl__y1 = bbox_top;
}
if ((_frl__x2 < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1))) {
_frl__x2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1);
}
if ((_frl__y2 < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1))) {
_frl__y2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1);
}
}
}
if(__fr_break6) break;
}}
x = ((_frl__x1 + _frl__x2) / 2);
;
y = ((_frl__y1 + _frl__y2) / 2);
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
; // macro hoisted: spr
; // macro hoisted: msk
; // macro hoisted: snd
; // macro hoisted: mus
; // macro hoisted: lag
; // macro hoisted: event_tip
; // macro hoisted: event_list
}

// Original dependencies/libEvents.mod.gml:142
function fr_dependencies_libEvents_mod_gml_event_add() {
if (is_array((argument_count>0 ? argument[0] : undefined))) {
{
var _frl__scrt_list = [];
;
{ var __fr_with1 = scrFRWithValues((argument_count>0 ? argument[0] : undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(_frl__scrt_list, fr_dependencies_libEvents_mod_gml_event_add(scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1)));
;
}
}
if(__fr_break3) break;
}}
return _frl__scrt_list;
;
}
}
var _frl__scrt = scrFRScriptRefExt("mod", (argument_count>1 ? argument[1] : undefined), (argument_count>0 ? argument[0] : undefined));
;
{ var __fr_with4 = scrFRWithValues(frMacro_dependencies_libEvents_mod_gml_event_list), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((((scrFRIndexGet(scrFRSelf(self), 0) == scrFRIndexGet(_frl__scrt, 0)) && (scrFRIndexGet(scrFRSelf(self), 1) == scrFRIndexGet(_frl__scrt, 1))) && (scrFRIndexGet(scrFRSelf(self), 2) == scrFRIndexGet(_frl__scrt, 2)))) {
{
return undefined;
;
}
}
}
}
if(__fr_break6) break;
}}
array_push(frMacro_dependencies_libEvents_mod_gml_event_list, _frl__scrt);
;
return _frl__scrt;
;
}

// Original dependencies/libEvents.mod.gml:172
function fr_dependencies_libEvents_mod_gml_event_add_ext() {
var _frl__scrt = (argument_count>0 ? argument[0] : undefined);
;
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libEvents_mod_gml_event_list), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((scrFRIndexGet(scrFRSelf(self), 0) == scrFRIndexGet(_frl__scrt, 0)) && (scrFRIndexGet(scrFRSelf(self), 1) == scrFRIndexGet(_frl__scrt, 1))) && (scrFRIndexGet(scrFRSelf(self), 2) == scrFRIndexGet(_frl__scrt, 2)))) {
{
return undefined;
;
}
}
}
}
if(__fr_break3) break;
}}
array_push(frMacro_dependencies_libEvents_mod_gml_event_list, _frl__scrt);
;
return _frl__scrt;
;
}

// Original dependencies/libEvents.mod.gml:191
function fr_dependencies_libEvents_mod_gml_event_set_active(_frl__modType=undefined, _frl__modName=undefined, _frl__name=undefined, _frl__active=undefined) {
if (_frl__active) {
{
if ((_frl__name == all)) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libEvents_mod_gml_event_list), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_dependencies_libEvents_mod_gml_event_set_active(_frl__modType, _frl__modName, scrFRIndexGet(scrFRSelf(self), 2), _frl__active);
;
}
}
if(__fr_break3) break;
}}
}
} else {
if ((! fr_dependencies_libEvents_mod_gml_event_get_active(_frl__name))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
name = "Event";
;
mod_type = _frl__modType;
;
mod_name = _frl__modName;
;
event = _frl__name;
;
tip = scrFRModCall(mod_type, mod_name, (event + "_text"));
;
floors = [];
;
spawn_x = 10016;
;
spawn_y = 10016;
;
{ var __fr_with7 = scrFRWithValues(GenCont), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
__fr_other10.spawn_x = spawn_x;
;
var __fr_other11=scrFROther(other);
__fr_other11.spawn_y = spawn_y;
;
if ((is_string((scrFROther(other)).tip) && ((scrFROther(other)).tip != ""))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "tip_event"))) {
{
var __fr_other12=scrFROther(other);
tip_event = __fr_other12.tip;
;
tip = (frMacro_dependencies_libEvents_mod_gml_event_tip + string_replace(tip_event, "@e", frMacro_dependencies_libEvents_mod_gml_event_tip));
;
}
}
}
}
}
}
if(__fr_break9) break;
}}
scrFRModCall(mod_type, mod_name, (event + "_setup"));
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
} else {
{ var __fr_with13 = scrFRWithValues(fr_dependencies_libEvents_mod_gml_event_get_active(_frl__name)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break15) break;
}}
}
return fr_dependencies_libEvents_mod_gml_event_get_active(_frl__name);
;
}

// Original dependencies/libEvents.mod.gml:245
function fr_dependencies_libEvents_mod_gml_event_get_active(_frl__name=undefined) {
var _frl__inst = scrFRMatching(FRCustomObject, "name", "Event");
;
if ((_frl__name == all)) {
{
array_sort(_frl__inst, true);
;
return _frl__inst;
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatching(_frl__inst, "event", _frl__name)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original dependencies/libEvents.mod.gml:266
function fr_dependencies_libEvents_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}
