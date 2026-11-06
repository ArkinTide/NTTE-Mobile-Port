// Original Areas/AlternateAreaHandler.area.gml:1
function fr_Areas_AlternateAreaHandler_area_gml___load() {

}

// Original Areas/AlternateAreaHandler.area.gml:1
function fr_Areas_AlternateAreaHandler_area_gml_init() {
global.fr_module_vars[$ "area:AlternateAreaHandler"].prevArea = "";
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].knownMods = [];
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].areaVars = [];
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].openListSlot = 0;
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].areaList = ds_list_create();
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].rollingEnabled = true;
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].tempRolls = 0;
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].defaultAreas = true;
;
}

// Original Areas/AlternateAreaHandler.area.gml:19
function fr_Areas_AlternateAreaHandler_area_gml_area_transit() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(GameCont, "alternateAreaHandler", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
alternateAreaHandler = true;
;
global.fr_module_vars[$ "area:AlternateAreaHandler"].prevArea = "";
}
}
if(__fr_break3) break;
}}
if ((GameCont.area == scrFRAreaTryResolve("red"))) {
{
global.fr_module_vars[$ "area:AlternateAreaHandler"].tempRolls += 2;
;
}
}
if (((global.fr_module_vars[$ "area:AlternateAreaHandler"].rollingEnabled == true) && (global.fr_module_vars[$ "area:AlternateAreaHandler"].tempRolls <= 0))) {
{
if ((GameCont.area != scrFRAreaTryResolve(global.fr_module_vars[$ "area:AlternateAreaHandler"].prevArea))) {
{
var _frl__newArea = fr_Areas_AlternateAreaHandler_area_gml_area_roll(GameCont.area);
;
if ((_frl__newArea != undefined)) {
{
GameCont.area = scrFRAreaResolve(_frl__newArea);
;
}
}
}
}
global.fr_module_vars[$ "area:AlternateAreaHandler"].prevArea = GameCont.area;
;
}
}
if ((global.fr_module_vars[$ "area:AlternateAreaHandler"].tempRolls > 0)) {
{
global.fr_module_vars[$ "area:AlternateAreaHandler"].tempRolls -= 1;
;
}
}
}

// Original Areas/AlternateAreaHandler.area.gml:46
function fr_Areas_AlternateAreaHandler_area_gml_altareas_import_example() {
var _frl__knownMods = scrFRModGet("area", "AlternateAreaHandler", "knownMods");
var _frl__knownIndex = 0;
var _frl__seeMe = 0;
;
repeat (array_length(_frl__knownMods)) {
if ((scrFRIndexGet(_frl__knownMods, _frl__knownIndex) == "AlternateAreaHandler")) {
{
_frl__seeMe += 1;
;
}
}
_frl__knownIndex += 1;
;
}
if ((_frl__seeMe <= 0)) {
{
array_push(_frl__knownMods, "AlternateAreaHandler");
;
scrFRModSet("area", "AlternateAreaHandler", "knownMods", _frl__knownMods);
scrFRModCall("area", "AlternateAreaHandler", "area_add", 1, ["greendesert", 1, true, false, "AlternateAreaHandler"]);
;
scrFRModCall("area", "AlternateAreaHandler", "area_add", 3, ["junkyard", 1, true, false, "AlternateAreaHandler"]);
;
scrFRModCall("area", "AlternateAreaHandler", "area_add", 3, ["garbagedump", 1, true, false, "AlternateAreaHandler"]);
;
}
}
}

// Original Areas/AlternateAreaHandler.area.gml:71
function fr_Areas_AlternateAreaHandler_area_gml_area_add(_frl__baseArea=undefined, _frl__newArea=undefined) {
if ((ds_list_find_index(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaList, _frl__baseArea) != (- 1))) {
{
var _frl__areaIndex = ds_list_find_index(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaList, _frl__baseArea);
var _frl__areaSlot = scrFRIndexGet(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaVars, _frl__areaIndex);
;
array_push(_frl__areaSlot, _frl__newArea);
;
}
} else {
{
fr_Areas_AlternateAreaHandler_area_gml_area_add_base(_frl__baseArea, _frl__newArea);
;
}
}
}

// Original Areas/AlternateAreaHandler.area.gml:100
function fr_Areas_AlternateAreaHandler_area_gml_area_add_base(_frl__baseArea=undefined, _frl__newArea=undefined) {
ds_list_add(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaList, _frl__baseArea);
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:AlternateAreaHandler"], "areaVars", [global.fr_module_vars[$ "area:AlternateAreaHandler"].openListSlot], [], "=");
array_push(scrFRIndexGet(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaVars, global.fr_module_vars[$ "area:AlternateAreaHandler"].openListSlot), _frl__newArea);
global.fr_module_vars[$ "area:AlternateAreaHandler"].openListSlot += 1;
;
}

// Original Areas/AlternateAreaHandler.area.gml:109
function fr_Areas_AlternateAreaHandler_area_gml_area_roll(_frl__baseArea=undefined) {
var _frl__chosenArea = undefined;
var _frl__areaIndex = ds_list_find_index(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaList, _frl__baseArea);
;
if ((_frl__areaIndex != (- 1))) {
{
var _frl__areaPool = ((global.fr_module_vars[$ "area:AlternateAreaHandler"].defaultAreas == true) ? [[undefined, 1]] : []);
var _frl__areaArray = scrFRIndexGet(global.fr_module_vars[$ "area:AlternateAreaHandler"].areaVars, _frl__areaIndex);
var _frl__overridePool = [];
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__areaArray)); _frl_i++) {
var _frl__altOption = [];
;
array_push(_frl__altOption, scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 0));
var _frl__weightNum = scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 1);
if (is_string(_frl__weightNum)) {
{
_frl__weightNum = scrFRModCall("mod", scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 4), scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 1));
;
}
}
var _frl__spawnWeight = ((scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 2) == true) ? (_frl__weightNum * (GameCont.subarea == 1)) : _frl__weightNum);
var _frl__choosePool = (((scrFRIndexGet(scrFRIndexGet(_frl__areaArray, _frl_i), 3) == true) && (_frl__spawnWeight > 0)) ? _frl__overridePool : _frl__areaPool);
;
array_push(_frl__altOption, _frl__spawnWeight);
array_push(_frl__choosePool, _frl__altOption);
;
}
}
var _frl__poolPool = ((array_length(_frl__overridePool) > 0) ? _frl__overridePool : _frl__areaPool);
;
_frl__chosenArea = fr_Areas_AlternateAreaHandler_area_gml_pool(_frl__poolPool);
}
}
return _frl__chosenArea;
;
}

// Original Areas/AlternateAreaHandler.area.gml:140
function fr_Areas_AlternateAreaHandler_area_gml_pool(_frl__pool=undefined) {
if (is_struct(_frl__pool)) {
{
var _frl__poolNew = [];
;
{
var _frl_i = 0;
for (; (_frl_i < scrFRLQSize(_frl__pool)); _frl_i++) {
array_push(_frl__poolNew, [scrFRLQKey(_frl__pool, _frl_i), scrFRLQValue(_frl__pool, _frl_i)]);
;
}
}
_frl__pool = _frl__poolNew;
;
}
}
var _frl__roll = 0;
;
{ var __fr_with1 = scrFRWithValues(_frl__pool), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
_frl__roll += scrFRIndexGet(scrFRSelf(self), 1);
;
}
}
if(__fr_break3) break;
}}
_frl__roll -= fr_Areas_AlternateAreaHandler_area_gml_seeded_random(((GameCont.hard + scrFRPlayerCompatSeedField("baseseed")) + 500), 0, _frl__roll, false);
if ((_frl__roll > 0)) {
{
{ var __fr_with4 = scrFRWithValues(_frl__pool), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
_frl__roll -= scrFRIndexGet(scrFRSelf(self), 1);
;
if ((_frl__roll <= 0)) {
{
return scrFRIndexGet(scrFRSelf(self), 0);
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
return undefined;
;
}

// Original Areas/AlternateAreaHandler.area.gml:186
function fr_Areas_AlternateAreaHandler_area_gml_seeded_random(_frl__seed=undefined, _frl__min=undefined, _frl__max=undefined, _frl__irandom=undefined) {
var _frl__lastSeed = scrFRSourceRandomGetSeed();
;
scrFRSourceRandomSetSeed((scrFRPlayerCompatSeedField("baseseed") + _frl__seed));
;
scrFRSourceRandomSetSeed(ceil((scrFRSourceRandom(100000) * scrFRSourceRandom(100000))));
;
var _frl_rand = undefined;
;
if (_frl__irandom) {
{
_frl_rand = (_frl__min + scrFRSourceIRandom((_frl__max - _frl__min)));
;
}
} else {
{
_frl_rand = (_frl__min + scrFRSourceRandom((_frl__max - _frl__min)));
;
}
}
scrFRSourceRandomSetSeed(_frl__lastSeed);
;
return _frl_rand;
;
}
