#macro frMacro_dependencies_libGeneral_mod_gml_infinity (1 / 0)

#macro frMacro_dependencies_libGeneral_mod_gml_anim_end (((image_index + (image_speed / timescale)) >= image_number) || ((image_index + (image_speed / timescale)) < 0))

#macro frMacro_dependencies_libGeneral_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_dependencies_libGeneral_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_dependencies_libGeneral_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_dependencies_libGeneral_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_dependencies_libGeneral_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_dependencies_libGeneral_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_dependencies_libGeneral_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original dependencies/libGeneral.mod.gml:1
function fr_dependencies_libGeneral_mod_gml___load() {

}

// Original dependencies/libGeneral.mod.gml:77
function fr_dependencies_libGeneral_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libGeneral", _frl_name]);
;
}

// Original dependencies/libGeneral.mod.gml:80
function fr_dependencies_libGeneral_mod_gml_init() {
fr_dependencies_libGeneral_mod_gml_addScript("obj_setup");
;
fr_dependencies_libGeneral_mod_gml_addScript("obj_setup_ext");
;
fr_dependencies_libGeneral_mod_gml_addScript("obj_create");
;
fr_dependencies_libGeneral_mod_gml_addScript("instances_in_rectangle");
;
fr_dependencies_libGeneral_mod_gml_addScript("player_swap");
;
fr_dependencies_libGeneral_mod_gml_addScript("projectile_create");
;
fr_dependencies_libGeneral_mod_gml_addScript("projectile_euphoria");
;
fr_dependencies_libGeneral_mod_gml_addScript("sound_play_at");
;
fr_dependencies_libGeneral_mod_gml_addScript("pool");
;
fr_dependencies_libGeneral_mod_gml_addScript("fx");
;
fr_dependencies_libGeneral_mod_gml_addScript("game_activate");
;
fr_dependencies_libGeneral_mod_gml_addScript("game_deactivate");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_delete");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_delete_value");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_get_name");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_nearest_array");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_nearest_bbox");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_nearest_rectangle");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_nearest_rectangle_bbox");
;
fr_dependencies_libGeneral_mod_gml_addScript("instances_at");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_rectangle");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_rectangle_bbox");
;
fr_dependencies_libGeneral_mod_gml_addScript("instances_meeting");
;
fr_dependencies_libGeneral_mod_gml_addScript("instances_seen");
;
fr_dependencies_libGeneral_mod_gml_addScript("instances_seen_nonsync");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_random");
;
fr_dependencies_libGeneral_mod_gml_addScript("instance_clone");
;
fr_dependencies_libGeneral_mod_gml_addScript("data_clone");
;
fr_dependencies_libGeneral_mod_gml_addScript("ds_list_clone");
;
fr_dependencies_libGeneral_mod_gml_addScript("surface_clone");
;
fr_dependencies_libGeneral_mod_gml_addScript("variable_instance_get_list");
;
fr_dependencies_libGeneral_mod_gml_addScript("variable_instance_set_list");
;
fr_dependencies_libGeneral_mod_gml_addScript("variable_is_readonly");
;
fr_dependencies_libGeneral_mod_gml_addScript("draw_lasersight");
;
fr_dependencies_libGeneral_mod_gml_addScript("draw_surface_scale");
;
fr_dependencies_libGeneral_mod_gml_addScript("string_delete_nt");
;
fr_dependencies_libGeneral_mod_gml_addScript("string_space");
;
fr_dependencies_libGeneral_mod_gml_addScript("orandom");
;
fr_dependencies_libGeneral_mod_gml_addScript("pround");
;
fr_dependencies_libGeneral_mod_gml_addScript("pfloor");
;
fr_dependencies_libGeneral_mod_gml_addScript("pceil");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_count");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_flip");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_combine");
;
fr_dependencies_libGeneral_mod_gml_addScript("array_shuffle");
;
fr_dependencies_libGeneral_mod_gml_addScript("enemy_target");
;
fr_dependencies_libGeneral_mod_gml_addScript("chest_create");
;
fr_dependencies_libGeneral_mod_gml_addScript("object_is");
;
fr_dependencies_libGeneral_mod_gml_addScript("chance");
;
fr_dependencies_libGeneral_mod_gml_addScript("chance_ct");
;
fr_dependencies_libGeneral_mod_gml_addScript("lerp_ct");
;
fr_dependencies_libGeneral_mod_gml_addScript("angle_lerp");
;
fr_dependencies_libGeneral_mod_gml_addScript("angle_lerp_ct");
;
fr_dependencies_libGeneral_mod_gml_addScript("path_create");
;
fr_dependencies_libGeneral_mod_gml_addScript("path_shrink");
;
fr_dependencies_libGeneral_mod_gml_addScript("path_reaches");
;
fr_dependencies_libGeneral_mod_gml_addScript("path_direction");
;
fr_dependencies_libGeneral_mod_gml_addScript("path_draw");
;
fr_dependencies_libGeneral_mod_gml_addScript("prompt_create");
;
fr_dependencies_libGeneral_mod_gml_addScript("is_9940");
;
fr_dependencies_libGeneral_mod_gml_addScript("obj_fire");
;
fr_dependencies_libGeneral_mod_gml_addScript("seeded_random");
;
fr_dependencies_libGeneral_mod_gml_addScript("object_get_mouse");
;
fr_dependencies_libGeneral_mod_gml_addScript("run_movescan");
;
fr_dependencies_libGeneral_mod_gml_addScript("loc_format");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libGeneral"].isLoaded = true;
;
global.fr_module_vars[$ "mod:libGeneral"].objects = ds_map_create();
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libGeneral", "scr");
;
fr_dependencies_libGeneral_mod_gml_obj_setup("libGeneral", "LibPrompt");
;
}

// Original dependencies/libGeneral.mod.gml:156
function fr_dependencies_libGeneral_mod_gml_step() {
if (scrFRInstanceExists(GenCont)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRFireCont, "isLibFireCont", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original dependencies/libGeneral.mod.gml:163
function fr_dependencies_libGeneral_mod_gml_late_step() {
var _frl__inst = scrFRMatching(FRCustomObject, "name", "LibPrompt");
;
if (array_length(_frl__inst)) {
{
var _frl__instReset = scrFRMatchingNE(_frl__inst, "pick", (- 1));
;
if (array_length(_frl__instReset)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__instReset), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = (- 1);
;
}
}
if(__fr_break3) break;
}}
}
}
if (scrFRInstanceExists(Player)) {
{
_frl__inst = scrFRMatching(_frl__inst, "visible", true);
;
if (array_length(_frl__inst)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRMatching(Player, "visible", true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__id = real(id);
;
if (((scrFRPlaceMeeting(x, y, FRCustomObject) && (! scrFRPlaceMeeting(x, y, IceFlower))) && (! scrFRPlaceMeeting(x, y, CarVenusFixed)))) {
{
var _frl__noVan = true;
;
if ((scrFRInstanceExists(Van) && scrFRPlaceMeeting(x, y, Van))) {
{
{ var __fr_with7 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_instances_meeting(x, y, scrFRMatching(Van, "drawspr", sprFRBase_VanOpenIdle))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
_frl__noVan = false;
;
__fr_break9=true; break;
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
if (_frl__noVan) {
{
var _frl__nearest = noone;
var _frl__maxDis = undefined;
var _frl__maxDepth = undefined;
;
if (scrFRInstanceExists(nearwep)) {
{
_frl__maxDis = point_distance(x, y, nearwep.x, nearwep.y);
;
_frl__maxDepth = nearwep.depth;
;
}
}
{ var __fr_with10 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_instances_meeting(x, y, _frl__inst)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
if (((! scrFRInstanceExists(creator)) || creator.visible)) {
{
if (((! is_array(on_meet)) || scrFRModCall(scrFRIndexGet(on_meet, 0), scrFRIndexGet(on_meet, 1), scrFRIndexGet(on_meet, 2)))) {
{
if (((_frl__maxDepth == undefined) || (depth < _frl__maxDepth))) {
{
_frl__maxDepth = depth;
;
_frl__maxDis = undefined;
;
}
}
if ((depth == _frl__maxDepth)) {
{
var _frl__dis = point_distance(x, y, (scrFROther(other)).x, (scrFROther(other)).y);
;
if (((_frl__maxDis == undefined) || (_frl__dis < _frl__maxDis))) {
{
_frl__maxDis = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
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
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(_frl__nearest), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
nearwep = scrFRInstanceCreate((x + xoff), (y + yoff), IceFlower);
;
{ var __fr_with16 = scrFRWithValues(nearwep), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
name = _frl__nearest.mytext;
;
x = xstart;
;
y = ystart;
;
xprevious = x;
;
yprevious = y;
;
visible = false;
;
mask_index = mskNone;
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
spr_idle = mskNone;
;
spr_walk = mskNone;
;
spr_hurt = mskNone;
;
spr_dead = mskNone;
;
spr_shadow = (- 1);
;
snd_hurt = (- 1);
;
snd_dead = (- 1);
;
size = 0;
;
team = 0;
;
hp = 99999;
;
nexthurt = (scrFRSourceFrame() + 99999);
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(_frl__id), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
nearwep = _frl__nearest.nearwep;
;
if (scrFRButtonPressed(index, "pick")) {
{
_frl__nearest.pick = index;
;
if ((scrFRInstanceExists(_frl__nearest.creator) && scrFRVariableExists(_frl__nearest.creator, "on_pick"))) {
{
{ var __fr_with22 = scrFRWithValues(_frl__nearest.creator), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
if ((! is_array(on_pick))) {
{
scrFRTrace("on_pick needs to use script_ref_create");
;
}
}
scrFRScriptCall(on_pick, _frl__id.index, _frl__nearest.creator, _frl__nearest);
;
}
}
if(__fr_break24) break;
}}
}
}
}
}
}
}
if(__fr_break21) break;
}}
}
}
if(__fr_break15) break;
}}
}
}
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
}

// Original dependencies/libGeneral.mod.gml:275
function fr_dependencies_libGeneral_mod_gml_obj_setup(_frl__mod=undefined, _frl__name=undefined) {
if (is_array(_frl__name)) {
{
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__name)); _frl_i++) {
fr_dependencies_libGeneral_mod_gml_obj_setup(_frl__mod, scrFRIndexGet(_frl__name, _frl_i));
;
}
}
return;
;
}
}
global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name] = {"setup": false, "type": "mod", "modName": _frl__mod, "name": _frl__name};
;
}

// Original dependencies/libGeneral.mod.gml:297
function fr_dependencies_libGeneral_mod_gml_obj_setup_ext(_frl__mod=undefined, _frl__name=undefined, _frl__type=undefined) {
if (is_array(_frl__name)) {
{
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__name)); _frl_i++) {
fr_dependencies_libGeneral_mod_gml_obj_setup_ext(_frl__mod, scrFRIndexGet(_frl__name, _frl_i), _frl__type);
;
}
}
return;
;
}
}
global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name] = {"setup": false, "type": _frl__type, "modName": _frl__mod, "name": _frl__name};
;
}

// Original dependencies/libGeneral.mod.gml:319
function fr_dependencies_libGeneral_mod_gml_obj_create(_frl__x=undefined, _frl__y=undefined, _frl__name=undefined) {
if (is_array(_frl__name)) {
{
var _frl__insts = [];
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__name)); _frl_i++) {
array_push(_frl__insts, fr_dependencies_libGeneral_mod_gml_obj_create(_frl__x, _frl__y, scrFRIndexGet(_frl__name, _frl_i)));
;
}
}
return _frl__insts;
;
}
}
if ((is_real(_frl__name) && object_exists(_frl__name))) {
{
return scrFRInstanceCreate(_frl__x, _frl__y, _frl__name);
;
}
}
if (ds_map_exists(global.fr_module_vars[$ "mod:libGeneral"].objects, _frl__name)) {
{
var _frl_obj = global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name];
;
if ((! _frl_obj.setup)) {
{
global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name].setup = true;
;
{ var __fr_with1 = scrFRWithValues(["_begin_step", "_step", "_end_step", "_draw", "_destroy", "_cleanup", "_hurt", "_death", "_anim", "_wall", "_hit", "_grenade", "_projectile", "_pick"]), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__var = ("on" + scrFRSelf(self));
var _frl__scr = (_frl__name + scrFRSelf(self));
;
if (scrFRScriptExists(_frl_obj.type, _frl_obj.modName, _frl__scr)) {
{
var _frl__ref = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, _frl__scr);
;
scrFRVariableSet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], _frl__var, _frl__ref);
;
}
} else {
{
scrFRVariableSet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], _frl__var, undefined);
;
}
}
}
}
if(__fr_break3) break;
}}
{
var _frl_i = 0;
for (; (_frl_i <= 11); _frl_i++) {
var _frl__alrm = ("_alrm" + string(_frl_i));
;
if (scrFRScriptExists(_frl_obj.type, _frl_obj.modName, (string(_frl__name) + _frl__alrm))) {
{
var _frl__ref = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, (string(_frl__name) + _frl__alrm));
;
scrFRVariableSet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], ("on" + _frl__alrm), _frl__ref);
;
}
} else {
{
scrFRVariableSet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], ("on" + _frl__alrm), undefined);
;
}
}
}
}
_frl_obj = global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name];
;
}
}
var _frl__inst = scrFRScriptCall([_frl_obj.type, _frl_obj.modName, (_frl_obj.name + "_create")], _frl__x, _frl__y);
;
if ((is_undefined(_frl__inst) || (_frl__inst == 0))) {
{
_frl__inst = noone;
;
}
}
if (scrFRInstanceExists(_frl__inst)) {
{
{ var __fr_with4 = scrFRWithValues(["_begin_step", "_step", "_end_step", "_draw", "_destroy", "_cleanup", "_hurt", "_death", "_anim", "_wall", "_hit", "_grenade", "_projectile", "_pick"]), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__var = ("on" + scrFRSelf(self));
;
if ((scrFRVariableGet(_frl__inst, _frl__var) != undefined)) {
{

}
} else {
if ((scrFRVariableGet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], _frl__var) != undefined)) {
{
scrFRVariableSet(_frl__inst, _frl__var, scrFRVariableGet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], _frl__var));
;
}
} else {
{
{ var __fr_switch_value7=scrFRSelf(self), __fr_switch_case8=-1;
if(__fr_switch_case8==-1 && __fr_switch_value7==("_step")) __fr_switch_case8=0;
if(__fr_switch_case8==-1 && __fr_switch_value7==("_hurt")) __fr_switch_case8=1;
if(__fr_switch_case8==-1 && __fr_switch_value7==("_death")) __fr_switch_case8=2;
if(__fr_switch_case8==-1 && __fr_switch_value7==("_draw")) __fr_switch_case8=3;
if(__fr_switch_case8==-1) __fr_switch_case8=-1;
switch(__fr_switch_case8) {
case 0:
if (scrFRInstanceIs(_frl__inst, FRCustomEnemy)) {
_frl__inst.on_step = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, "enemy_step");
} else {
if (scrFRInstanceIs(_frl__inst, FRCustomHitme)) {
_frl__inst.on_step = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, "hitme_step");
}
}
break;
;
case 1:
if (scrFRInstanceIs(_frl__inst, hitme)) {
_frl__inst.on_hurt = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, "enemy_hurt");
}
break;
;
case 2:
if (scrFRInstanceIs(_frl__inst, FRCustomEnemy)) {
_frl__inst.on_death = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, "enemy_death");
}
break;
;
case 3:
if (scrFRInstanceIs(_frl__inst, FRCustomEnemy)) {
_frl__inst.on_draw = scrFRScriptRefExt(_frl_obj.type, _frl_obj.modName, "draw_self_enemy");
}
break;
;
}
}
}
}
}
}
}
if(__fr_break6) break;
}}
{
var _frl_i = 0;
for (; (_frl_i <= 11); _frl_i++) {
var _frl__alrm = ("_alrm" + string(_frl_i));
;
if ((scrFRVariableGet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], ("on" + _frl__alrm)) != undefined)) {
{
scrFRVariableSet(_frl__inst, ("on" + _frl__alrm), scrFRVariableGet(global.fr_module_vars[$ "mod:libGeneral"].objects[?_frl__name], ("on" + _frl__alrm)));
;
}
}
}
}
if (scrFRInstanceIs(_frl__inst, hitme)) {
{
if (scrFRVariableExists(_frl__inst, "spr_idle")) {
_frl__inst.sprite_index = scrFRAreaSourceSprite(_frl__inst.spr_idle);
}
if (scrFRInstanceIs(_frl__inst, FRCustomEnemy)) {
_frl__inst.target = noone;
}
}
}
_frl__inst.name = _frl__name;
;
}
}
return _frl__inst;
;
}
}
if (is_undefined(_frl__name)) {
{
return ds_map_keys_to_array(global.fr_module_vars[$ "mod:libGeneral"].objects);
;
}
}
return noone;
;
}

// Original dependencies/libGeneral.mod.gml:485
function fr_dependencies_libGeneral_mod_gml_obj_create_ext(_frl__x=undefined, _frl__y=undefined, _frl__name=undefined, _frl__mod=undefined) {
fr_dependencies_libGeneral_mod_gml_obj_setup(_frl__mod, _frl__name);
;
return fr_dependencies_libGeneral_mod_gml_obj_create(_frl__x, _frl__y, _frl__name);
;
; // macro hoisted: infinity
; // macro hoisted: anim_end
; // macro hoisted: enemy_sprite
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
; // macro hoisted: alarm0_run
; // macro hoisted: alarm1_run
; // macro hoisted: alarm2_run
; // macro hoisted: alarm3_run
; // macro hoisted: alarm4_run
; // macro hoisted: alarm5_run
; // macro hoisted: alarm6_run
; // macro hoisted: alarm7_run
; // macro hoisted: alarm8_run
; // macro hoisted: alarm9_run
}

// Original dependencies/libGeneral.mod.gml:519
function fr_dependencies_libGeneral_mod_gml_enemy_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm0") and frMacro_dependencies_libGeneral_mod_gml_alarm0_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_dependencies_libGeneral_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_dependencies_libGeneral_mod_gml_alarm2_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm3") and frMacro_dependencies_libGeneral_mod_gml_alarm3_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm4") and frMacro_dependencies_libGeneral_mod_gml_alarm4_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm5") and frMacro_dependencies_libGeneral_mod_gml_alarm5_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm6") and frMacro_dependencies_libGeneral_mod_gml_alarm6_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm7") and frMacro_dependencies_libGeneral_mod_gml_alarm7_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm8") and frMacro_dependencies_libGeneral_mod_gml_alarm8_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm9") and frMacro_dependencies_libGeneral_mod_gml_alarm9_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_dependencies_libGeneral_mod_gml_enemy_sprite);
;
}

// Original dependencies/libGeneral.mod.gml:544
function fr_dependencies_libGeneral_mod_gml_hitme_step() {
if (scrFRPlaceMeeting((x + (hspeed / timescale)), (y + (vspeed / timescale)), Wall)) {
move_bounce_solid(true);
}
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_instances_meeting(x, y, enemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((scrFRProjectileCanHitMelee((scrFROther(other))) && scrFRVariableExists(scrFRSelf(self), "canmelee")) && canmelee) && (meleedamage > 0))) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHit(__fr_other4, meleedamage);
;
}
}
{ var __fr_with5 = scrFRWithValues((scrFROther(other))), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other8=scrFROther(other);
scrFRProjectileHit(__fr_other8, 3);
;
scrFRSoundPitch(sndFreakMelee, (1.2 + scrFRSourceRandom(0.4)));
;
}
}
}
}
if(__fr_break7) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:561
function fr_dependencies_libGeneral_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
if (((! is_real(scrFRSelf(self))) || (! scrFRInstanceExists(scrFRSelf(self))))) {
{
{ var __fr_with1 = scrFRWithValues(UberCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
return fr_dependencies_libGeneral_mod_gml_draw_weapon(_frl__sprite, _frl__image, _frl__x, _frl__y, _frl__angle, _frl__angleMelee, _frl__kick, _frl__flip, _frl__blend, _frl__alpha);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((_frl__angleMelee != 0)) {
{
_frl__angle += (_frl__angleMelee * (1 - (_frl__kick / 20)));
;
}
}
if ((_frl__kick != 0)) {
{
_frl__x -= lengthdir_x(_frl__kick, _frl__angle);
;
_frl__y -= lengthdir_y(_frl__kick, _frl__angle);
;
}
}
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, 1, _frl__flip, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original dependencies/libGeneral.mod.gml:591
function fr_dependencies_libGeneral_mod_gml_enemy_hurt(_frl__damage=undefined, _frl__force=undefined, _frl__direction=undefined) {
hp -= _frl__damage;
;
nexthurt = (scrFRSourceFrame() + 6);
;
scrFRMotionAdd(_frl__direction, _frl__force);
;
scrFRSoundHit(snd_hurt, 0.2);
;
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
}

// Original dependencies/libGeneral.mod.gml:601
function fr_dependencies_libGeneral_mod_gml_enemy_death() {
scrFRPickupDrop(20, 0);
;
}

// Original dependencies/libGeneral.mod.gml:606
function fr_dependencies_libGeneral_mod_gml_instances_in_rectangle(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
return scrFRMatchingLE(scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingGE(_frl__obj, "x", _frl__x1), "y", _frl__y1), "x", _frl__x2), "y", _frl__y2);
;
}

// Original dependencies/libGeneral.mod.gml:628
function fr_dependencies_libGeneral_mod_gml_player_swap(_frl__player=undefined) {
{ var __fr_with1 = scrFRWithValues(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__name = [string_replace(scrFRSelf(self), "%", ""), string_replace(scrFRSelf(self), "%", "b")];
var _frl__temp = scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 0), 0);
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 0), scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 1), 0));
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 1), _frl__temp);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:641
function fr_dependencies_libGeneral_mod_gml_projectile_create() {
var _frl__inst = (argument_count>0 ? argument[0] : undefined);
var _frl__x = (argument_count>1 ? argument[1] : undefined);
var _frl__y = (argument_count>2 ? argument[2] : undefined);
var _frl__obj = (argument_count>3 ? argument[3] : undefined);
var _frl__dir = ((argument_count > 4) ? (argument_count>4 ? argument[4] : undefined) : 0);
var _frl__spd = ((argument_count > 5) ? (argument_count>5 ? argument[5] : undefined) : 0);
var _frl__proj = fr_dependencies_libGeneral_mod_gml_obj_create(_frl__x, _frl__y, _frl__obj);
;
{ var __fr_with1 = scrFRWithValues(_frl__proj), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction += _frl__dir;
;
if ((_frl__spd != 0)) {
{
scrFRMotionAdd(_frl__dir, _frl__spd);
;
}
}
image_angle += direction;
;
var _frl__team = (scrFRVariableExists(_frl__inst, "team") ? _frl__inst.team : (scrFRVariableExists(scrFRSelf(self), "team") ? team : (- 1)));
var _frl__creator = ((scrFRVariableExists(_frl__inst, "creator") && (! scrFRInstanceIs(_frl__inst, hitme))) ? _frl__inst.creator : _frl__inst);
;
scrFRProjectileInit(_frl__team, _frl__creator);
;
if (scrFRVariableExists(scrFRSelf(self), "team")) {
team = _frl__team;
}
if (scrFRVariableExists(scrFRSelf(self), "creator")) {
creator = _frl__creator;
}
if (scrFRVariableExists(scrFRSelf(self), "hitid")) {
hitid = (scrFRVariableExists(_frl__inst, "hitid") ? _frl__inst.hitid : hitid);
}
if (((((((((((((((((((((((is_string(_frl__obj) && (scrFRGetSkill(mut_euphoria) != 0)) && (scrFRInstanceExists(_frl__creator) ? scrFRInstanceIs(_frl__creator, enemy) : (_frl__team != 2))) && (! scrFRInstanceIs(scrFRSelf(self), EnemyBullet1))) && (! scrFRInstanceIs(scrFRSelf(self), EnemyBullet3))) && (! scrFRInstanceIs(scrFRSelf(self), EnemyBullet4))) && (! scrFRInstanceIs(scrFRSelf(self), HorrorBullet))) && (! scrFRInstanceIs(scrFRSelf(self), IDPDBullet))) && (! scrFRInstanceIs(scrFRSelf(self), PopoPlasma))) && (! scrFRInstanceIs(scrFRSelf(self), LHBouncer))) && (! scrFRInstanceIs(scrFRSelf(self), Fireball))) && (! scrFRInstanceIs(scrFRSelf(self), ToxicGas))) && (! scrFRInstanceIs(scrFRSelf(self), Shank))) && (! scrFRInstanceIs(scrFRSelf(self), Slash))) && (! scrFRInstanceIs(scrFRSelf(self), EnemySlash))) && (! scrFRInstanceIs(scrFRSelf(self), FR_OBJECT_GUITAR_SLASH))) && (! scrFRInstanceIs(scrFRSelf(self), FRCustomSlash))) && (! scrFRInstanceIs(scrFRSelf(self), BloodSlash))) && (! scrFRInstanceIs(scrFRSelf(self), LightningSlash))) && (! scrFRInstanceIs(scrFRSelf(self), EnergyShank))) && (! scrFRInstanceIs(scrFRSelf(self), EnergySlash))) && (! scrFRInstanceIs(scrFRSelf(self), EnergyHammerSlash))) && (! scrFRInstanceIs((scrFROther(other)), FRFireCont)))) {
{
scrFRBindBeginStep(fr_dependencies_libGeneral_mod_gml_projectile_euphoria, 0, scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__proj;
;
}

// Original dependencies/libGeneral.mod.gml:711
function fr_dependencies_libGeneral_mod_gml_projectile_euphoria(_frl__inst=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed *= power(0.8, scrFRGetSkill(mut_euphoria));
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original dependencies/libGeneral.mod.gml:717
function fr_dependencies_libGeneral_mod_gml_sound_play_at() {
var _frl__x = (argument_count>0 ? argument[0] : undefined);
var _frl__y = (argument_count>1 ? argument[1] : undefined);
var _frl__sound = (argument_count>2 ? argument[2] : undefined);
var _frl__pitch = ((argument_count > 3) ? (argument_count>3 ? argument[3] : undefined) : 1);
var _frl__volume = ((argument_count > 4) ? (argument_count>4 ? argument[4] : undefined) : 1);
var _frl__fadeDis = ((argument_count > 5) ? (argument_count>5 ? argument[5] : undefined) : 64);
var _frl__fadeFactor = ((argument_count > 6) ? (argument_count>6 ? argument[6] : undefined) : 1);
var _frl__listenX = (scrFRViewCoordinate(0) + (view_width / 2));
var _frl__listenY = (scrFRViewCoordinate(1) + (view_height / 2));
;
if (scrFRInstanceExists(Player)) {
{
var _frl__disMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
;
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__dis = point_distance(x, y, _frl__x, _frl__y);
;
if ((_frl__dis < _frl__disMax)) {
{
if (scrFRPlayerIsLocal(index)) {
{
_frl__disMax = _frl__dis;
;
_frl__listenX = x;
;
_frl__listenY = y;
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
}
audio_stop_sound(_frl__sound);
;
var _frl__snd = audio_play_sound_at(_frl__sound, (_frl__listenX - _frl__x), (_frl__listenY - _frl__y), 0, _frl__fadeDis, 320, _frl__fadeFactor, false, 0);
;
audio_sound_pitch(_frl__snd, _frl__pitch);
;
audio_sound_gain(_frl__snd, (_frl__volume * audio_sound_get_gain(_frl__snd)), 0);
;
return _frl__snd;
;
}

// Original dependencies/libGeneral.mod.gml:769
function fr_dependencies_libGeneral_mod_gml_pool(_frl__pool=undefined) {
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
_frl__roll -= scrFRSourceRandom(_frl__roll);
;
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

// Original dependencies/libGeneral.mod.gml:815
function fr_dependencies_libGeneral_mod_gml_fx(_frl__x=undefined, _frl__y=undefined, _frl__motion=undefined, _frl__object=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_obj_create((is_array(_frl__x) ? (scrFRIndexGet(_frl__x, 0) + fr_dependencies_libGeneral_mod_gml_orandom(scrFRIndexGet(_frl__x, 1))) : _frl__x), (is_array(_frl__y) ? (scrFRIndexGet(_frl__y, 0) + fr_dependencies_libGeneral_mod_gml_orandom(scrFRIndexGet(_frl__y, 1))) : _frl__y), _frl__object)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__face = ((image_angle == direction) || (((speed / timescale) == 0) && ((scrFRObjectIndex(scrFRSelf(self)) == AcidStreak) || (scrFRObjectIndex(scrFRSelf(self)) == BloodStreak))));
;
if (is_array(_frl__motion)) {
{
scrFRMotionAdd(scrFRIndexGet(_frl__motion, 0), scrFRIndexGet(_frl__motion, 1));
;
}
} else {
{
scrFRMotionAdd(scrFRSourceRandom(360), _frl__motion);
;
}
}
if (_frl__face) {
{
image_angle = direction;
;
}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original dependencies/libGeneral.mod.gml:855
function fr_dependencies_libGeneral_mod_gml_game_activate() {
{ var __fr_with1 = scrFRWithValues(UberCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
event_perform(ev_alarm, 2);
;
}
}
if(__fr_break6) break;
}}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:864
function fr_dependencies_libGeneral_mod_gml_game_deactivate() {
{ var __fr_with1 = scrFRWithValues(UberCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__lastIntro = opt_bossintro;
var _frl__lastLoops = GameCont.loops;
var _frl__player = noone;
;
opt_bossintro = true;
;
GameCont.loops = 0;
;
if ((! scrFRInstanceExists(Player))) {
{
_frl__player = scrFRInstanceCreate(0, 0, FR_OBJECT_GAME);
;
{ var __fr_with7 = scrFRWithValues(_frl__player), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
instance_change(Player, false);
;
}
}
if(__fr_break9) break;
}}
}
}
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(0, 0, FR_OBJECT_GAME)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
instance_change(BanditBoss, false);
;
{ var __fr_with13 = scrFRWithValues(scrFRSelf(self)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
event_perform(ev_alarm, 6);
;
}
}
if(__fr_break15) break;
}}
scrFRSoundStop(sndBigBanditIntro);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
scrFRAlarmWrite(scrFRSelf(self), 2, (- 1), "=");
;
opt_bossintro = _frl__lastIntro;
;
GameCont.loops = _frl__lastLoops;
;
{ var __fr_with16 = scrFRWithValues(_frl__player), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
event_perform(ev_alarm, 2);
;
event_perform(ev_draw, ev_draw_post);
;
}
}
if(__fr_break6) break;
}}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:907
function fr_dependencies_libGeneral_mod_gml_array_delete(_frl__array=undefined, _frl__index=undefined) {
var _frl__new = scrFRArraySlice(_frl__array, 0, _frl__index);
;
array_copy(_frl__new, array_length(_frl__new), _frl__array, (_frl__index + 1), (array_length(_frl__array) - (_frl__index + 1)));
;
return _frl__new;
;
}

// Original dependencies/libGeneral.mod.gml:921
function fr_dependencies_libGeneral_mod_gml_array_delete_value(_frl__array=undefined, _frl__value=undefined) {
var _frl__new = _frl__array;
;
while ((scrFRArrayFindIndex(_frl__new, _frl__value) >= 0)) {
_frl__new = fr_dependencies_libGeneral_mod_gml_array_delete(_frl__new, scrFRArrayFindIndex(_frl__new, _frl__value));
;
}
return _frl__new;
;
}

// Original dependencies/libGeneral.mod.gml:937
function fr_dependencies_libGeneral_mod_gml_instance_get_name(_frl__inst=undefined) {
var _frl__name = "";
;
if ((scrFRInstanceExists(_frl__inst) && (! object_exists(_frl__inst)))) {
{
if (scrFRVariableExists(_frl__inst, "hitid")) {
{
var _frl__hitid = _frl__inst.hitid;
;
if (is_real(_frl__hitid)) {
{
_frl__hitid = floor(_frl__hitid);
;
var _frl__list = ["bandit", "maggot", "rad maggot", "big maggot", "scorpion", "golden scorpion", "big bandit", "rat", "big rat", "green rat", "gator", "frog", "super frog", "mom", "assassin", "raven", "salamander", "sniper", "big dog", "spider", "new cave thing", "laser crystal", "hyper crystal", "snow bandit", "snowbot", "wolf", "snowtank", "lil hunter", "freak", "explo freak", "rhino freak", "necromancer", "turret", "technomancer", "guardian", "explo guardian", "dog guardian", "throne", "throne II", "bonefish", "crab", "turtle", "molefish", "molesarge", "fireballer", "super fireballer", "jock", "@p@qc@qu@qr@qs@qe@qd @qs@qp@qi@qd@qe@qr", "@p@qc@qu@qr@qs@qe@qd @qc@qr@qy@qs@qt@qa@ql", "mimic", "health mimic", "grunt", "inspector", "shielder", "crown guardian", "explosion", "small explosion", "fire trap", "shield", "toxic", "horror", "barrel", "toxic barrel", "golden barrel", "car", "venus car", "venus car fixed", "venus car 2", "icy car", "thrown car", "mine", "crown of death", "rogue strike", "blood launcher", "blood cannon", "blood hammer", "disc", "@p@qc@qu@qr@qs@qe", "big dog missile", "halloween bandit", "lil hunter fly", "throne death", "jungle bandit", "jungle assassin", "jungle fly", "crown of hatred", "ice flower", "@p@qc@qu@qr@qs@qe@qd @qa@qm@qm@qo @qp@qi@qc@qk@qu@qp", "electrocution", "elite grunt", "blood gamble", "elite shielder", "elite inspector", "captain", "van", "buff gator", "generator", "lightning crystal", "golden snowtank", "green explosion", "small generator", "golden disc", "big dog explosion", "popo freak", "throne II death", "big fish"];
;
if (((_frl__hitid >= 0) && (_frl__hitid < array_length(_frl__list)))) {
{
_frl__name = loc(("CauseOfDeath:" + string(_frl__hitid) + ""), scrFRIndexGet(_frl__list, _frl__hitid));
;
}
} else {
if (sprite_exists(_frl__hitid)) {
{
_frl__name = sprite_get_name(_frl__hitid);
;
}
}
}
}
} else {
if ((is_array(_frl__hitid) && array_length(_frl__hitid))) {
{
_frl__name = string(scrFRIndexGet(_frl__hitid, 1));
;
}
}
}
}
}
if ((_frl__name == "")) {
{
if ((scrFRVariableExists(_frl__inst, "name") && (string_pos("Custom", object_get_name(scrFRVariableGet(_frl__inst, "object_index", (- 1)))) == 1))) {
{
_frl__name = string(_frl__inst.name);
;
if ((string_pos(" ", _frl__name) <= 0)) {
{
_frl__name = fr_dependencies_libGeneral_mod_gml_string_space(_frl__name);
;
}
}
}
}
}
}
}
}
if ((_frl__name == "")) {
{
var _frl__obj = (object_exists(_frl__inst) ? _frl__inst : scrFRVariableGet(_frl__inst, "object_index", (- 1)));
;
if (object_exists(_frl__obj)) {
{
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Bullet1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Bullet2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(EnemyBullet1)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(EnemyBullet2)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(EnemyBullet3)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(EnemyBullet4)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(EnemyFlak)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(PlasmaBig)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(PlasmaHuge)) __fr_switch_case2=8;
if(__fr_switch_case2==-1) __fr_switch_case2=9;
switch(__fr_switch_case2) {
case 0:
_frl__name = "Bullet";
;
break;
;
case 1:
_frl__name = "Shell";
;
break;
;
case 2:
_frl__name = "Enemy Bullet";
;
break;
;
case 3:
_frl__name = "Venom";
;
break;
;
case 4:
_frl__name = "Enemy Shell";
;
break;
;
case 5:
_frl__name = "Sniper Bullet";
;
break;
;
case 6:
_frl__name = "Enemy Flak Bullet";
;
break;
;
case 7:
_frl__name = "Big Plasma";
;
break;
;
case 8:
_frl__name = "Huge Plasma";
;
break;
;
case 9:
_frl__name = fr_dependencies_libGeneral_mod_gml_string_space(object_get_name(_frl__obj));
;
}
}
}
}
}
}
return _frl__name;
;
}

// Original dependencies/libGeneral.mod.gml:1007
function fr_dependencies_libGeneral_mod_gml_instance_nearest_array(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined) {
var _frl__disMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(_frl__obj, "id", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__dis = point_distance(_frl__x, _frl__y, x, y);
;
if ((_frl__dis < _frl__disMax)) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__nearest;
;
}

// Original dependencies/libGeneral.mod.gml:1028
function fr_dependencies_libGeneral_mod_gml_instance_nearest_bbox(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined) {
var _frl__disMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(_frl__obj, "id", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__dis = distance_to_point(_frl__x, _frl__y);
;
if ((_frl__dis < _frl__disMax)) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__nearest;
;
}

// Original dependencies/libGeneral.mod.gml:1050
function fr_dependencies_libGeneral_mod_gml_instance_nearest_rectangle(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
var _frl__cx = ((_frl__x1 + _frl__x2) / 2);
var _frl__cy = ((_frl__y1 + _frl__y2) / 2);
var _frl__disAMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__disBMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(_frl__obj, "id", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__disA = point_distance(x, y, clamp(x, _frl__x1, _frl__x2), clamp(y, _frl__y1, _frl__y2));
var _frl__disB = point_distance(x, y, _frl__cx, _frl__cy);
;
if (((_frl__disA < _frl__disAMax) || ((_frl__disA == _frl__disAMax) && (_frl__disB < _frl__disBMax)))) {
{
_frl__disAMax = _frl__disA;
;
_frl__disBMax = _frl__disB;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__nearest;
;
}

// Original dependencies/libGeneral.mod.gml:1079
function fr_dependencies_libGeneral_mod_gml_instance_nearest_rectangle_bbox(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
var _frl__cx = ((_frl__x1 + _frl__x2) / 2);
var _frl__cy = ((_frl__y1 + _frl__y2) / 2);
var _frl__disAMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__disBMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(_frl__obj, "id", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__x = clamp(_frl__cx, bbox_left, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1));
var _frl__y = clamp(_frl__cy, bbox_top, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1));
var _frl__disA = point_distance(_frl__x, _frl__y, clamp(_frl__x, _frl__x1, _frl__x2), clamp(_frl__y, _frl__y1, _frl__y2));
var _frl__disB = point_distance(_frl__x, _frl__y, _frl__cx, _frl__cy);
;
if (((_frl__disA < _frl__disAMax) || ((_frl__disA == _frl__disAMax) && (_frl__disB < _frl__disBMax)))) {
{
_frl__disAMax = _frl__disA;
;
_frl__disBMax = _frl__disB;
;
_frl__nearest = scrFRSelf(self);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__nearest;
;
}

// Original dependencies/libGeneral.mod.gml:1110
function fr_dependencies_libGeneral_mod_gml_instances_at(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined) {
return scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "bbox_right", _frl__x), "bbox_left", _frl__x), "bbox_bottom", _frl__y), "bbox_top", _frl__y);
;
}

// Original dependencies/libGeneral.mod.gml:1118
function fr_dependencies_libGeneral_mod_gml_instance_rectangle(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
return scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "x", _frl__x1), "x", _frl__x2), "y", _frl__y1), "y", _frl__y2);
;
}

// Original dependencies/libGeneral.mod.gml:1126
function fr_dependencies_libGeneral_mod_gml_instance_rectangle_bbox(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
return scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "bbox_right", _frl__x1), "bbox_left", _frl__x2), "bbox_bottom", _frl__y1), "bbox_top", _frl__y2);
;
}

// Original dependencies/libGeneral.mod.gml:1134
function fr_dependencies_libGeneral_mod_gml_instances_meeting(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined) {
var _frl__tx = x;
var _frl__ty = y;
;
x = _frl__x;
;
y = _frl__y;
;
var _frl__inst = scrFRMatchingNE(scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "bbox_right", bbox_left), "bbox_left", scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")), "bbox_bottom", bbox_top), "bbox_top", scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")), "id", real(id));
;
x = _frl__tx;
;
y = _frl__ty;
;
return _frl__inst;
;
}

// Original dependencies/libGeneral.mod.gml:1153
function fr_dependencies_libGeneral_mod_gml_instances_seen(_frl__obj=undefined, _frl__bx=undefined, _frl__by=undefined, _frl__index=undefined) {
var _frl__x1 = 0;
var _frl__y1 = 0;
var _frl__x2 = 0;
var _frl__y2 = 0;
;
if ((_frl__index < 0)) {
{
_frl__x1 = (+ frMacro_dependencies_libGeneral_mod_gml_infinity);
;
_frl__y1 = (+ frMacro_dependencies_libGeneral_mod_gml_infinity);
;
_frl__x2 = (- frMacro_dependencies_libGeneral_mod_gml_infinity);
;
_frl__y2 = (- frMacro_dependencies_libGeneral_mod_gml_infinity);
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
if (scrFRPlayerIsActive(_frl_i)) {
{
var _frl__x = scrFRViewCoordinate(0, _frl_i);
var _frl__y = scrFRViewCoordinate(1, _frl_i);
;
if ((_frl__x < _frl__x1)) {
_frl__x1 = _frl__x;
}
if ((_frl__y < _frl__y1)) {
_frl__y1 = _frl__y;
}
if ((_frl__x > _frl__x2)) {
_frl__x2 = _frl__x;
}
if ((_frl__y > _frl__y2)) {
_frl__y2 = _frl__y;
}
}
}
}
}
_frl__x2 += view_width;
;
_frl__y2 += view_width;
;
}
} else {
{
_frl__x1 = scrFRViewCoordinate(0, _frl__index);
;
_frl__y1 = scrFRViewCoordinate(1, _frl__index);
;
_frl__x2 = (_frl__x1 + view_width);
;
_frl__y2 = (_frl__y1 + view_height);
;
}
}
return scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "bbox_right", (_frl__x1 - _frl__bx)), "bbox_left", (_frl__x2 + _frl__bx)), "bbox_bottom", (_frl__y1 - _frl__by)), "bbox_top", (_frl__y2 + _frl__by));
;
}

// Original dependencies/libGeneral.mod.gml:1200
function fr_dependencies_libGeneral_mod_gml_instances_seen_nonsync(_frl__obj=undefined, _frl__bx=undefined, _frl__by=undefined) {
var _frl__x1 = scrFRViewCoordinate(0);
var _frl__y1 = scrFRViewCoordinate(1);
var _frl__x2 = (_frl__x1 + view_width);
var _frl__y2 = (_frl__y1 + view_height);
;
return scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(_frl__obj, "bbox_right", (_frl__x1 - _frl__bx)), "bbox_left", (_frl__x2 + _frl__bx)), "bbox_bottom", (_frl__y1 - _frl__by)), "bbox_top", (_frl__y2 + _frl__by));
;
}

// Original dependencies/libGeneral.mod.gml:1218
function fr_dependencies_libGeneral_mod_gml_instance_random(_frl__obj=undefined) {
var _frl__inst = scrFRMatchingNE(_frl__obj, "id", undefined);
var _frl__size = array_length(_frl__inst);
;
return ((_frl__size > 0) ? scrFRIndexGet(_frl__inst, scrFRSourceIRandom((_frl__size - 1))) : noone);
;
}

// Original dependencies/libGeneral.mod.gml:1233
function fr_dependencies_libGeneral_mod_gml_instance_clone() {
var _frl__inst = instance_copy(false);
;
{ var __fr_with1 = scrFRWithValues(variable_instance_get_names(_frl__inst)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__value = scrFRVariableGet(_frl__inst, scrFRSelf(self));
var _frl__clone = fr_dependencies_libGeneral_mod_gml_data_clone(_frl__value, 0);
;
if ((_frl__value != _frl__clone)) {
{
scrFRVariableSet(_frl__inst, scrFRSelf(self), _frl__clone);
;
}
}
}
}
if(__fr_break3) break;
}}
return _frl__inst;
;
}

// Original dependencies/libGeneral.mod.gml:1251
function fr_dependencies_libGeneral_mod_gml_data_clone(_frl__value=undefined, _frl__depth=undefined) {
if ((_frl__depth >= 0)) {
{
_frl__depth--;
;
if (is_array(_frl__value)) {
{
var _frl__clone = scrFRArrayClone(_frl__value);
;
if ((_frl__depth >= 0)) {
{
{
var _frl_i = (array_length(_frl__value) - 1);
for (; (_frl_i >= 0); _frl_i--) {
scrFRIndexPathWrite(_frl__clone, [_frl_i], fr_dependencies_libGeneral_mod_gml_data_clone(scrFRIndexGet(_frl__value, _frl_i), _frl__depth), "=");
;
}
}
}
}
return _frl__clone;
;
}
}
if (is_struct(_frl__value)) {
{
var _frl__clone = scrFRLQClone(_frl__value);
;
if ((_frl__depth >= 0)) {
{
{
var _frl_i = (scrFRLQSize(_frl__value) - 1);
for (; (_frl_i >= 0); _frl_i--) {
scrFRLQSet(_frl__clone, scrFRLQKey(_frl__value, _frl_i), fr_dependencies_libGeneral_mod_gml_data_clone(scrFRLQValue(_frl__value, _frl_i), _frl__depth));
;
}
}
}
}
return _frl__clone;
;
}
}
if (surface_exists(_frl__value)) {
{
return fr_dependencies_libGeneral_mod_gml_surface_clone(_frl__value);
;
}
}
}
}
return _frl__value;
;
}

// Original dependencies/libGeneral.mod.gml:1340
function fr_dependencies_libGeneral_mod_gml_ds_list_clone(_frl__list=undefined) {
var _frl__clone = ds_list_create();
;
scrFRListAddArray(_frl__clone, scrFRListToArray(_frl__list));
;
return _frl__clone;
;
}

// Original dependencies/libGeneral.mod.gml:1351
function fr_dependencies_libGeneral_mod_gml_surface_clone(_frl__surf=undefined) {
var _frl__clone = surface_create(surface_get_width(_frl__surf), surface_get_height(_frl__surf));
;
surface_set_target(_frl__clone);
;
draw_clear_alpha(0, 0);
;
draw_surface(_frl__surf, 0, 0);
;
surface_reset_target();
;
return _frl__clone;
;
}

// Original dependencies/libGeneral.mod.gml:1365
function fr_dependencies_libGeneral_mod_gml_variable_instance_get_list(_frl__inst=undefined) {
var _frl__list = {};
;
{ var __fr_with1 = scrFRWithValues(variable_instance_get_names(_frl__inst)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRLQSet(_frl__list, scrFRSelf(self), scrFRVariableGet(_frl__inst, scrFRSelf(self)));
;
}
}
if(__fr_break3) break;
}}
return _frl__list;
;
}

// Original dependencies/libGeneral.mod.gml:1378
function fr_dependencies_libGeneral_mod_gml_variable_instance_set_list(_frl__inst=undefined, _frl__list=undefined) {
if (scrFRInstanceExists(_frl__inst)) {
{
var _frl__listMax = scrFRLQSize(_frl__list);
var _frl__isCustom = (string_pos("Custom", object_get_name(scrFRObjectIndex(_frl__inst))) == 1);
;
{
var _frl_i = 0;
for (; (_frl_i < _frl__listMax); _frl_i++) {
var _frl__name = scrFRLQKey(_frl__list, _frl_i);
;
if ((! fr_dependencies_libGeneral_mod_gml_variable_is_readonly(_frl__inst, _frl__name))) {
{
if ((_frl__isCustom && (string_pos("on_", _frl__name) == 1))) {
{
if ((scrFRVariableGet(_frl__inst, _frl__name) != scrFRLQValue(_frl__list, _frl_i))) {
{
try scrFRVariableSet(_frl__inst, _frl__name, scrFRLQValue(_frl__list, _frl_i)); catch(__fr_caught1) { var _frl__error=__fr_caught1;
{

}
}
}
}
}
} else {
scrFRVariableSet(_frl__inst, _frl__name, scrFRLQValue(_frl__list, _frl_i));
}
;
}
}
}
}
}
}
}

// Original dependencies/libGeneral.mod.gml:1401
function fr_dependencies_libGeneral_mod_gml_variable_is_readonly(_frl__inst=undefined, _frl__varName=undefined) {
if ((scrFRArrayFindIndex(["id", "object_index", "bbox_bottom", "bbox_top", "bbox_right", "bbox_left", "image_number", "sprite_yoffset", "sprite_xoffset", "sprite_height", "sprite_width"], _frl__varName) >= 0)) {
{
return true;
;
}
}
if (scrFRInstanceIs(_frl__inst, Player)) {
{
if ((scrFRArrayFindIndex(["p", "index", "alias"], _frl__varName) >= 0)) {
{
return true;
;
}
}
}
}
return false;
;
}

// Original dependencies/libGeneral.mod.gml:1418
function fr_dependencies_libGeneral_mod_gml_draw_lasersight(_frl__x=undefined, _frl__y=undefined, _frl__dir=undefined, _frl__disMax=undefined, _frl__width=undefined) {
var _frl__dis = _frl__disMax;
var _frl__disX = lengthdir_x(_frl__dis, _frl__dir);
var _frl__disY = lengthdir_y(_frl__dis, _frl__dir);
;
while (((_frl__dis >= 1) && collision_line(_frl__x, _frl__y, (_frl__x + _frl__disX), (_frl__y + _frl__disY), Wall, false, false))) {
_frl__dis /= 2;
;
_frl__disX /= 2;
;
_frl__disY /= 2;
;
}
if ((_frl__dis < _frl__disMax)) {
{
var _frl__disAdd = max(2, (_frl__dis / 32));
var _frl__disAddX = lengthdir_x(_frl__disAdd, _frl__dir);
var _frl__disAddY = lengthdir_y(_frl__disAdd, _frl__dir);
;
while (((_frl__dis > 0) && (! position_meeting((_frl__x + _frl__disX), (_frl__y + _frl__disY), Wall)))) {
_frl__dis -= _frl__disAdd;
;
_frl__disX += _frl__disAddX;
;
_frl__disY += _frl__disAddY;
;
}
}
}
draw_line_width((_frl__x - 1), (_frl__y - 1), ((_frl__x - 1) + _frl__disX), ((_frl__y - 1) + _frl__disY), _frl__width);
;
return [(_frl__x + _frl__disX), (_frl__y + _frl__disY)];
;
}

// Original dependencies/libGeneral.mod.gml:1459
function fr_dependencies_libGeneral_mod_gml_draw_surface_scale(_frl__surf=undefined, _frl__x=undefined, _frl__y=undefined, _frl__scale=undefined) {
draw_surface_ext(_frl__surf, _frl__x, _frl__y, _frl__scale, _frl__scale, 0, c_white, draw_get_alpha());
;
}

// Original dependencies/libGeneral.mod.gml:1467
function fr_dependencies_libGeneral_mod_gml_string_delete_nt(_frl__string=undefined) {
var _frl__split = "@";
var _frl__stringSplit = string_split(_frl__string, _frl__split);
var _frl__stringSplitMax = array_length(_frl__stringSplit);
;
{
var _frl_i = 1;
for (; (_frl_i < _frl__stringSplitMax); _frl_i++) {
if ((scrFRIndexGet(_frl__stringSplit, (_frl_i - 1)) != _frl__split)) {
{
var _frl__current = scrFRIndexGet(_frl__stringSplit, _frl_i);
var _frl__char = string_upper(string_char_at(_frl__current, 1));
;
{ var __fr_switch_value1=_frl__char, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("W")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("S")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("D")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("R")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("G")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("B")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("P")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Y")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Q")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("0")) __fr_switch_case2=10;
if(__fr_switch_case2==-1 && __fr_switch_value1==("1")) __fr_switch_case2=11;
if(__fr_switch_case2==-1 && __fr_switch_value1==("2")) __fr_switch_case2=12;
if(__fr_switch_case2==-1 && __fr_switch_value1==("3")) __fr_switch_case2=13;
if(__fr_switch_case2==-1 && __fr_switch_value1==("4")) __fr_switch_case2=14;
if(__fr_switch_case2==-1 && __fr_switch_value1==("5")) __fr_switch_case2=15;
if(__fr_switch_case2==-1 && __fr_switch_value1==("6")) __fr_switch_case2=16;
if(__fr_switch_case2==-1 && __fr_switch_value1==("7")) __fr_switch_case2=17;
if(__fr_switch_case2==-1 && __fr_switch_value1==("8")) __fr_switch_case2=18;
if(__fr_switch_case2==-1 && __fr_switch_value1==("9")) __fr_switch_case2=19;
if(__fr_switch_case2==-1 && __fr_switch_value1==("(")) __fr_switch_case2=20;
if(__fr_switch_case2==-1) __fr_switch_case2=21;
switch(__fr_switch_case2) {
case 0:
if ((_frl_i < (_frl__stringSplitMax - 1))) {
{
_frl__current = _frl__split;
;
}
}
break;
;
case 1:

case 2:

case 3:

case 4:

case 5:

case 6:

case 7:

case 8:

case 9:
_frl__current = string_delete(_frl__current, 1, 1);
;
break;
;
case 10:

case 11:

case 12:

case 13:

case 14:

case 15:

case 16:

case 17:

case 18:

case 19:
if ((string_char_at(_frl__current, 2) == "(")) {
{
_frl__current = string_delete(_frl__current, 1, 1);
;
var _frl__spr = scrFRIndexGet(string_split(string_copy(_frl__current, 2, (string_pos(")", _frl__current) - 2)), ":"), 0);
;
if ((((((real(_frl__spr) > 0) || sprite_exists(asset_get_index(_frl__spr))) || (_frl__spr == "sprKeySmall")) || (_frl__spr == "sprButSmall")) || (_frl__spr == "sprButBig"))) {
{
if ((string_width(" ") > 0)) {
{
_frl__current = (string_repeat(" ", (real(_frl__char) * (string_width("A") / string_width(" ")))) + _frl__current);
;
}
}
}
}
}
} else {
{
_frl__current = (_frl__split + _frl__current);
;
break;
;
}
}
case 20:
var _frl__bgn = string_pos("(", _frl__current);
var _frl__end = string_pos(")", _frl__current);
;
if ((_frl__bgn < _frl__end)) {
{
_frl__current = string_delete(_frl__current, _frl__bgn, ((1 + _frl__end) - _frl__bgn));
;
break;
;
}
}
case 21:
_frl__current = (_frl__split + _frl__current);
;
}
}
scrFRIndexPathWrite(_frl__stringSplit, [_frl_i], _frl__current, "=");
;
}
}
}
}
return scrFRArrayJoin(_frl__stringSplit, "");
;
}

// Original dependencies/libGeneral.mod.gml:1567
function fr_dependencies_libGeneral_mod_gml_string_space(_frl__string=undefined) {
var _frl__char = "";
var _frl__charLast = "";
var _frl__charNext = "";
;
{
var _frl_i = 0;
for (; (_frl_i <= string_length(_frl__string)); _frl_i++) {
_frl__charNext = string_char_at(_frl__string, (_frl_i + 1));
;
if (((((_frl__char != string_lower(_frl__char)) && ((_frl__charLast != string_upper(_frl__charLast)) || ((_frl__charLast != string_lower(_frl__charLast)) && (_frl__charNext != string_upper(_frl__charNext))))) || ((string_digits(_frl__char) != "") && (string_letters(_frl__charLast) != ""))) || ((string_letters(_frl__char) != "") && (string_digits(_frl__charLast) != "")))) {
{
_frl__string = string_insert(" ", _frl__string, _frl_i);
;
_frl_i++;
;
}
}
_frl__charLast = _frl__char;
;
_frl__char = _frl__charNext;
;
}
}
return _frl__string;
;
}

// Original dependencies/libGeneral.mod.gml:1597
function fr_dependencies_libGeneral_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original dependencies/libGeneral.mod.gml:1604
function fr_dependencies_libGeneral_mod_gml_pround(_frl__num=undefined, _frl__precision=undefined) {
if ((_frl__precision != 0)) {
{
return (round((_frl__num / _frl__precision)) * _frl__precision);
;
}
}
return _frl__num;
;
}

// Original dependencies/libGeneral.mod.gml:1618
function fr_dependencies_libGeneral_mod_gml_pfloor(_frl__num=undefined, _frl__precision=undefined) {
if ((_frl__precision != 0)) {
{
return (floor((_frl__num / _frl__precision)) * _frl__precision);
;
}
}
return _frl__num;
;
}

// Original dependencies/libGeneral.mod.gml:1632
function fr_dependencies_libGeneral_mod_gml_pceil(_frl__num=undefined, _frl__precision=undefined) {
if ((_frl__precision != 0)) {
{
return (ceil((_frl__num / _frl__precision)) * _frl__precision);
;
}
}
return _frl__num;
;
}

// Original dependencies/libGeneral.mod.gml:1646
function fr_dependencies_libGeneral_mod_gml_array_count(_frl__array=undefined, _frl__value=undefined) {
var _frl__count = 0;
;
if ((scrFRArrayFindIndex(_frl__array, _frl__value) >= 0)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__array), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSelf(self) == _frl__value)) {
{
_frl__count++;
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
return _frl__count;
;
}

// Original dependencies/libGeneral.mod.gml:1663
function fr_dependencies_libGeneral_mod_gml_array_flip(_frl__array=undefined) {
var _frl_a = scrFRArrayClone(_frl__array);
var _frl_m = array_length(_frl__array);
;
{
var _frl_i = 0;
for (; (_frl_i < _frl_m); _frl_i++) {
scrFRIndexPathWrite(_frl__array, [_frl_i], scrFRIndexGet(_frl_a, ((_frl_m - 1) - _frl_i)), "=");
;
}
}
return _frl__array;
;
}

// Original dependencies/libGeneral.mod.gml:1680
function fr_dependencies_libGeneral_mod_gml_array_combine(_frl__array1=undefined, _frl__array2=undefined) {
var _frl__new = scrFRArrayClone(_frl__array1);
;
array_copy(_frl__new, array_length(_frl__new), _frl__array2, 0, array_length(_frl__array2));
;
return _frl__new;
;
}

// Original dependencies/libGeneral.mod.gml:1691
function fr_dependencies_libGeneral_mod_gml_array_shuffle(_frl__array=undefined) {
var _frl__size = array_length(_frl__array);
var _frl_j = undefined;
var _frl_t = undefined;
;
{
var _frl_i = 0;
for (; (_frl_i < _frl__size); _frl_i++) {
_frl_j = scrFRSourceIRandomRange(_frl_i, (_frl__size - 1));
;
if ((_frl_i != _frl_j)) {
{
_frl_t = scrFRIndexGet(_frl__array, _frl_i);
;
scrFRIndexPathWrite(_frl__array, [_frl_i], scrFRIndexGet(_frl__array, _frl_j), "=");
;
scrFRIndexPathWrite(_frl__array, [_frl_j], _frl_t, "=");
;
}
}
}
}
return _frl__array;
;
}

// Original dependencies/libGeneral.mod.gml:1706
function fr_dependencies_libGeneral_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
if (scrFRInstanceExists(Player)) {
{
target = instance_nearest(_frl__x, _frl__y, Player);
;
}
} else {
if ((target < 0)) {
{
target = noone;
;
}
}
}
return scrFRInstanceExists(target);
;
}

// Original dependencies/libGeneral.mod.gml:1720
function fr_dependencies_libGeneral_mod_gml_chest_create(_frl__x=undefined, _frl__y=undefined, _frl__obj=undefined, _frl__levelStart=undefined) {
if (((((is_string(_frl__obj) || fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, chestprop)) || fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, RadChest)) || fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, Mimic)) || fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, SuperMimic))) {
{
if ((is_real(_frl__obj) && fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, RadChest))) {
{
if (_frl__levelStart) {
{
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
if ((scrFRPlayerRace(_frl_i) == "rogue")) {
{
_frl__obj = RogueChest;
;
break;
;
}
}
}
}
if (fr_dependencies_libGeneral_mod_gml_chance(1, 2)) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((hp < ((max_hp + headloses) / 2))) {
{
_frl__obj = HealthChest;
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
var _frl__players = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__players += scrFRPlayerIsActive(_frl_i);
;
}
}
if ((scrFRInstanceNumber(Player) < _frl__players)) {
{
_frl__obj = HealthChest;
;
}
}
}
}
if ((fr_dependencies_libGeneral_mod_gml_chance(2, 3) && (scrFRCrownCurrent() == crwn_life))) {
{
_frl__obj = HealthChest;
;
}
}
}
}
if ((scrFRCrownCurrent() == crwn_love)) {
{
if (((! is_real(_frl__obj)) || (! fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, AmmoChest)))) {
{
if ((scrFRArrayFindIndex([ProtoChest, RogueChest, "Backpack", "BonusAmmoChest", "BonusAmmoMimic", "BuriedVaultChest", "CatChest", "CursedAmmoChest", "CursedMimic", "SunkenChest"], _frl__obj) < 0)) {
{
var _frl__name = (is_real(_frl__obj) ? object_get_name(_frl__obj) : _frl__obj);
;
if ((string_pos("Mimic", _frl__name) > 0)) {
{
_frl__obj = Mimic;
;
}
} else {
if ((string_pos("Giant", _frl__name) > 0)) {
{
_frl__obj = GiantAmmoChest;
;
}
} else {
{
_frl__obj = AmmoChest;
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
if (_frl__levelStart) {
{
if ((fr_dependencies_libGeneral_mod_gml_chance(GameCont.nochest, 4) && (_frl__obj == WeaponChest))) {
{
_frl__obj = BigWeaponChest;
;
}
}
if ((((! scrFRSourceAreaIsReal(GameCont.area)) || (GameCont.area >= scrFRAreaResolve(2))) || (GameCont.loops >= 1))) {
{
if (((fr_dependencies_libGeneral_mod_gml_chance(1, 11) && is_real(_frl__obj)) && fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, AmmoChest))) {
{
_frl__obj = Mimic;
;
}
}
if (((fr_dependencies_libGeneral_mod_gml_chance(1, 51) && is_real(_frl__obj)) && fr_dependencies_libGeneral_mod_gml_object_is(_frl__obj, HealthChest))) {
{
_frl__obj = SuperMimic;
;
}
}
}
}
}
}
}
}
var _frl__inst = noone;
var _frl__rads = GameCont.noradch;
var _frl__health = [];
;
if ((! _frl__levelStart)) {
{
GameCont.noradch = 0;
;
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
array_push(_frl__health, [scrFRSelf(self), hp]);
;
hp = max_hp;
;
}
}
if(__fr_break6) break;
}}
}
}
_frl__inst = fr_dependencies_libGeneral_mod_gml_obj_create(_frl__x, _frl__y, _frl__obj);
;
if ((! _frl__levelStart)) {
{
GameCont.noradch = _frl__rads;
;
{ var __fr_with7 = scrFRWithValues(_frl__health), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{ var __fr_with10 = scrFRWithValues(scrFRIndexGet(scrFRSelf(self), 0)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
hp = scrFRIndexGet(__fr_other13, 1);
;
}
}
if(__fr_break12) break;
}}
}
if(__fr_break9) break;
}}
}
}
if ((! scrFRInstanceExists(_frl__inst))) {
{
{ var __fr_with14 = scrFRWithValues(scrFRMatchingGT([chestprop, RadChest, Mimic, SuperMimic], "id", _frl__inst)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
if (((! scrFRInstanceExists(_frl__inst)) || (real(id) < _frl__inst))) {
{
_frl__inst = real(id);
;
}
}
}
}
if(__fr_break16) break;
}}
}
}
return _frl__inst;
;
}

// Original dependencies/libGeneral.mod.gml:1844
function fr_dependencies_libGeneral_mod_gml_object_is(_frl__object=undefined, _frl__parent=undefined) {
return ((_frl__object == _frl__parent) || object_is_ancestor(_frl__object, _frl__parent));
;
}

// Original dependencies/libGeneral.mod.gml:1851
function fr_dependencies_libGeneral_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original dependencies/libGeneral.mod.gml:1861
function fr_dependencies_libGeneral_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original dependencies/libGeneral.mod.gml:1868
function fr_dependencies_libGeneral_mod_gml_lerp_ct(_frl__val1=undefined, _frl__val2=undefined, _frl__amount=undefined) {
return lerp(_frl__val2, _frl__val1, power((1 - _frl__amount), scrFRSourceScale()));
;
}

// Original dependencies/libGeneral.mod.gml:1875
function fr_dependencies_libGeneral_mod_gml_angle_lerp(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang1 + (angle_difference(_frl__ang2, _frl__ang1) * _frl__num));
;
}

// Original dependencies/libGeneral.mod.gml:1886
function fr_dependencies_libGeneral_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original dependencies/libGeneral.mod.gml:1893
function fr_dependencies_libGeneral_mod_gml_path_create(_frl__xstart=undefined, _frl__ystart=undefined, _frl__xtarget=undefined, _frl__ytarget=undefined, _frl__wall=undefined) {
var _frl__tileSize = 16;
var _frl__areaWidth = (fr_dependencies_libGeneral_mod_gml_pceil(abs((_frl__xtarget - _frl__xstart)), _frl__tileSize) + 320);
var _frl__areaHeight = (fr_dependencies_libGeneral_mod_gml_pceil(abs((_frl__ytarget - _frl__ystart)), _frl__tileSize) + 320);
;
_frl__areaWidth = max(_frl__areaWidth, _frl__areaHeight);
;
_frl__areaHeight = max(_frl__areaWidth, _frl__areaHeight);
;
var _frl__triesMax = (4 * ceil(((_frl__areaWidth + _frl__areaHeight) / _frl__tileSize)));
;
_frl__xstart = fr_dependencies_libGeneral_mod_gml_pfloor(_frl__xstart, _frl__tileSize);
;
_frl__ystart = fr_dependencies_libGeneral_mod_gml_pfloor(_frl__ystart, _frl__tileSize);
;
_frl__xtarget = fr_dependencies_libGeneral_mod_gml_pfloor(_frl__xtarget, _frl__tileSize);
;
_frl__ytarget = fr_dependencies_libGeneral_mod_gml_pfloor(_frl__ytarget, _frl__tileSize);
;
var _frl__gridw = ceil((_frl__areaWidth / _frl__tileSize));
var _frl__gridh = ceil((_frl__areaHeight / _frl__tileSize));
var _frl__gridx = fr_dependencies_libGeneral_mod_gml_pround((((_frl__xstart + _frl__xtarget) / 2) - (_frl__areaWidth / 2)), _frl__tileSize);
var _frl__gridy = fr_dependencies_libGeneral_mod_gml_pround((((_frl__ystart + _frl__ytarget) / 2) - (_frl__areaHeight / 2)), _frl__tileSize);
var _frl__grid = ds_grid_create(_frl__gridw, _frl__gridh);
var _frl__gridCost = ds_grid_create(_frl__gridw, _frl__gridh);
;
ds_grid_clear(_frl__grid, (- 1));
;
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_instance_rectangle(_frl__gridx, _frl__gridy, (_frl__gridx + _frl__areaWidth), (_frl__gridy + _frl__areaHeight), _frl__wall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (position_meeting(x, y, scrFRSelf(self))) {
{
_frl__grid[#((x - _frl__gridx) / _frl__tileSize), ((y - _frl__gridy) / _frl__tileSize)] = (- 2);
;
}
}
}
}
if(__fr_break3) break;
}}
var _frl__x1 = ((_frl__xtarget - _frl__gridx) / _frl__tileSize);
var _frl__y1 = ((_frl__ytarget - _frl__gridy) / _frl__tileSize);
var _frl__x2 = ((_frl__xstart - _frl__gridx) / _frl__tileSize);
var _frl__y2 = ((_frl__ystart - _frl__gridy) / _frl__tileSize);
var _frl__searchList = [[_frl__x1, _frl__y1, 0]];
var _frl__tries = _frl__triesMax;
;
while (((_frl__tries--) > 0)) {
var _frl__search = scrFRIndexGet(_frl__searchList, 0);
var _frl__sx = scrFRIndexGet(_frl__search, 0);
var _frl__sy = scrFRIndexGet(_frl__search, 1);
var _frl__sp = scrFRIndexGet(_frl__search, 2);
;
if ((_frl__sp >= frMacro_dependencies_libGeneral_mod_gml_infinity)) {
break;
}
scrFRIndexPathWrite(_frl__search, [2], frMacro_dependencies_libGeneral_mod_gml_infinity, "=");
;
var _frl__costSoFar = _frl__gridCost[#_frl__sx, _frl__sy];
;
{
var _frl_i = 0;
for (; (_frl_i < (2 * pi)); _frl_i += (pi / 2)) {
var _frl__nx = (_frl__sx + cos(_frl_i));
var _frl__ny = (_frl__sy - sin(_frl_i));
var _frl__nc = (_frl__costSoFar + 1);
;
if ((((((_frl__nx >= 0) && (_frl__ny >= 0)) && (_frl__nx < _frl__gridw)) && (_frl__ny < _frl__gridh)) && (_frl__grid[#_frl__nx, _frl__ny] == (- 1)))) {
{
_frl__gridCost[#_frl__nx, _frl__ny] = _frl__nc;
;
_frl__grid[#_frl__nx, _frl__ny] = point_direction(_frl__nx, _frl__ny, _frl__sx, _frl__sy);
;
array_push(_frl__searchList, [_frl__nx, _frl__ny, ((point_distance(_frl__x2, _frl__y2, _frl__nx, _frl__ny) + (abs((_frl__x2 - _frl__nx)) + abs((_frl__y2 - _frl__ny)))) + _frl__nc)]);
;
}
}
if (((_frl__nx == _frl__x2) && (_frl__ny == _frl__y2))) {
{
_frl__tries = 0;
;
break;
;
}
}
}
}
scrFRArraySortSub(_frl__searchList, 2, true);
;
}
var _frl__x = _frl__xstart;
var _frl__y = _frl__ystart;
var _frl__path = [[(_frl__x + (_frl__tileSize / 2)), (_frl__y + (_frl__tileSize / 2))]];
var _frl__tries = _frl__triesMax;
;
while (((_frl__tries--) > 0)) {
var _frl__dir = _frl__grid[#((_frl__x - _frl__gridx) / _frl__tileSize), ((_frl__y - _frl__gridy) / _frl__tileSize)];
;
if ((_frl__dir >= 0)) {
{
_frl__x += lengthdir_x(_frl__tileSize, _frl__dir);
;
_frl__y += lengthdir_y(_frl__tileSize, _frl__dir);
;
array_push(_frl__path, [(_frl__x + (_frl__tileSize / 2)), (_frl__y + (_frl__tileSize / 2))]);
;
}
} else {
{
_frl__path = [];
;
break;
;
}
}
if (((_frl__x == _frl__xtarget) && (_frl__y == _frl__ytarget))) {
{
break;
;
}
}
}
if ((_frl__tries <= 0)) {
_frl__path = [];
}
ds_grid_destroy(_frl__grid);
;
ds_grid_destroy(_frl__gridCost);
;
return _frl__path;
;
}

// Original dependencies/libGeneral.mod.gml:2010
function fr_dependencies_libGeneral_mod_gml_path_shrink(_frl__path=undefined, _frl__wall=undefined, _frl__skipMax=undefined) {
var _frl__pathNew = [];
var _frl__link = 0;
;
if ((! is_array(_frl__wall))) {
{
_frl__wall = [_frl__wall];
;
}
}
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__path)); _frl_i++) {
var _frl__save = (((_frl_i <= 0) || (_frl_i >= (array_length(_frl__path) - 1))) || ((_frl_i - _frl__link) >= _frl__skipMax));
;
if ((! _frl__save)) {
{
var _frl__x1 = scrFRIndexGet(_frl__path, (_frl_i + 1), 0);
var _frl__y1 = scrFRIndexGet(_frl__path, (_frl_i + 1), 1);
var _frl__x2 = scrFRIndexGet(_frl__path, _frl__link, 0);
var _frl__y2 = scrFRIndexGet(_frl__path, _frl__link, 1);
;
{
var _frl_j = 0;
for (; (_frl_j < array_length(_frl__wall)); _frl_j++) {
if (collision_line(_frl__x1, _frl__y1, _frl__x2, _frl__y2, scrFRIndexGet(_frl__wall, _frl_j), false, false)) {
{
_frl__save = true;
;
break;
;
}
}
}
}
}
}
if (_frl__save) {
{
array_push(_frl__pathNew, scrFRIndexGet(_frl__path, _frl_i));
;
_frl__link = _frl_i;
;
}
}
}
}
return _frl__pathNew;
;
}

// Original dependencies/libGeneral.mod.gml:2050
function fr_dependencies_libGeneral_mod_gml_path_reaches(_frl__path=undefined, _frl__xtarget=undefined, _frl__ytarget=undefined, _frl__wall=undefined) {
if ((! is_array(_frl__wall))) {
_frl__wall = [_frl__wall];
}
var _frl_m = array_length(_frl__path);
;
if ((_frl_m > 0)) {
{
var _frl__x = scrFRIndexGet(_frl__path, (_frl_m - 1), 0);
var _frl__y = scrFRIndexGet(_frl__path, (_frl_m - 1), 1);
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__wall)); _frl_i++) {
if (collision_line(_frl__x, _frl__y, _frl__xtarget, _frl__ytarget, scrFRIndexGet(_frl__wall, _frl_i), false, false)) {
{
return false;
;
}
}
}
}
return true;
;
}
}
return false;
;
}

// Original dependencies/libGeneral.mod.gml:2069
function fr_dependencies_libGeneral_mod_gml_path_direction(_frl__path=undefined, _frl__x=undefined, _frl__y=undefined, _frl__wall=undefined) {
if ((! is_array(_frl__wall))) {
_frl__wall = [_frl__wall];
}
var _frl__disMax = frMacro_dependencies_libGeneral_mod_gml_infinity;
var _frl__nearest = (- 1);
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__path)); _frl_i++) {
var _frl__px = scrFRIndexGet(_frl__path, _frl_i, 0);
var _frl__py = scrFRIndexGet(_frl__path, _frl_i, 1);
var _frl__dis = point_distance(_frl__x, _frl__y, _frl__px, _frl__py);
;
if ((_frl__dis < _frl__disMax)) {
{
var _frl__walled = false;
;
{
var _frl_j = 0;
for (; (_frl_j < array_length(_frl__wall)); _frl_j++) {
if (collision_line(_frl__x, _frl__y, _frl__px, _frl__py, scrFRIndexGet(_frl__wall, _frl_j), false, false)) {
{
_frl__walled = true;
;
break;
;
}
}
}
}
if ((! _frl__walled)) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = _frl_i;
;
}
}
}
}
}
}
if ((_frl__nearest >= 0)) {
{
var _frl__follow = min((_frl__nearest + 1), (array_length(_frl__path) - 1));
var _frl__nx = scrFRIndexGet(_frl__path, _frl__follow, 0);
var _frl__ny = scrFRIndexGet(_frl__path, _frl__follow, 1);
;
{
var _frl_j = 0;
for (; (_frl_j < array_length(_frl__wall)); _frl_j++) {
if (collision_line(x, y, _frl__nx, _frl__ny, scrFRIndexGet(_frl__wall, _frl_j), false, false)) {
{
_frl__nx = scrFRIndexGet(_frl__path, _frl__nearest, 0);
;
_frl__ny = scrFRIndexGet(_frl__path, _frl__nearest, 1);
;
break;
;
}
}
}
}
return point_direction(x, y, _frl__nx, _frl__ny);
;
}
}
return undefined;
;
}

// Original dependencies/libGeneral.mod.gml:2116
function fr_dependencies_libGeneral_mod_gml_path_draw(_frl__path=undefined, _frl__width=undefined) {
var _frl__x = x;
var _frl__y = y;
;
{ var __fr_with1 = scrFRWithValues(_frl__path), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
draw_line_width(scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 1), _frl__x, _frl__y, _frl__width);
;
_frl__x = scrFRIndexGet(scrFRSelf(self), 0);
;
_frl__y = scrFRIndexGet(scrFRSelf(self), 1);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:2126
function fr_dependencies_libGeneral_mod_gml_prompt_create(_frl__text=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libGeneral_mod_gml_obj_create(x, y, "LibPrompt")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mytext = _frl__text;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
depth = __fr_other5.depth;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original dependencies/libGeneral.mod.gml:2141
function fr_dependencies_libGeneral_mod_gml_LibPrompt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mask_index = mskWepPickup;
;
persistent = true;
;
creator = noone;
;
nearwep = noone;
;
depth = 0;
;
pick = (- 1);
;
xoff = 0;
;
yoff = 0;
;
on_meet = undefined;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:2159
function fr_dependencies_libGeneral_mod_gml_LibPrompt_begin_step() {
{ var __fr_with1 = scrFRWithValues(nearwep), __fr_break3=false;
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

// Original dependencies/libGeneral.mod.gml:2164
function fr_dependencies_libGeneral_mod_gml_LibPrompt_end_step() {
if ((creator != noone)) {
{
if (scrFRInstanceExists(creator)) {
{
if (scrFRInstanceExists(nearwep)) {
{
{ var __fr_with1 = scrFRWithValues(nearwep), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x += (__fr_other4.creator.x - __fr_other4.x);
;
var __fr_other5=scrFROther(other);
y += (__fr_other5.creator.y - __fr_other5.y);
;
visible = true;
;
}
}
if(__fr_break3) break;
}}
}
}
x = creator.x;
;
y = creator.y;
;
}
} else {
scrFRInstanceDestroy();
}
;
}
}
}

// Original dependencies/libGeneral.mod.gml:2181
function fr_dependencies_libGeneral_mod_gml_LibPrompt_cleanup() {
{ var __fr_with1 = scrFRWithValues(nearwep), __fr_break3=false;
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

// Original dependencies/libGeneral.mod.gml:2186
function fr_dependencies_libGeneral_mod_gml_is_9940() {
var _frl_retVal = false;
;
repeat (0) {
_frl_retVal = true;
;
}
return _frl_retVal;
;
}

// Original dependencies/libGeneral.mod.gml:2201
function fr_dependencies_libGeneral_mod_gml_obj_fire(_frl__gunangle=undefined, _frl__wep=undefined, _frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__affectcreator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRFireCont)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
isLibFireCont = true;
;
owner = _frl__creator;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl__wep);
;
maxspeed = (scrFRVariableGet(owner, "maxspeed", 4)) * timescale;
;
team = scrFRVariableGet(owner, "team", 0);
;
accuracy = scrFRVariableGet(owner, "accuracy", 1);
;
curse = scrFRVariableGet(owner, "curse", 0);
;
ammo = scrFRVariableGet(owner, "ammo", [1000, 255, 55, 55, 55, 55]);
;
prevammo = scrFRVariableGet(owner, "ammo", undefined);
;
scrFRMaxHealthWrite(id, scrFRVariableGet(owner, "maxhealth", 8), "=");
;
hp = scrFRVariableGet(owner, "my_health", 8);
;
lsthealth = scrFRVariableGet(owner, "lsthealth", 8);
;
reloadspeed = scrFRVariableGet(owner, "reloadspeed", 1);
;
footstep = scrFRVariableGet(owner, "footstep", 0);
;
chickencorpse = scrFRVariableGet(owner, "chickencorpse", noone);
;
frogcharge = scrFRVariableGet(owner, "frogcharge", 0);
;
rogueammo = scrFRVariableGet(owner, "rogueammo", 1);
;
can_spec = scrFRVariableGet(owner, "canspec", 1);
;
notoxic = scrFRVariableGet(owner, "notoxic", 0);
;
horrornorad = scrFRVariableGet(owner, "horrornorad", 0);
;
swapmove = scrFRVariableGet(owner, "swapmove", 0);
;
bleed = scrFRVariableGet(owner, "bleed", 0);
;
scrFRAmmoArrayWrite(scrFRSelf(self), "typ_amax", scrFRVariableGet(owner, "typ_amax", [1000, 255, 55, 55, 55, 55]));
;
image_angle = scrFRVariableGet(owner, "sprite_angle", 0);
;
wkick = scrFRVariableGet(owner, "wkick", 0);
;
joyx = scrFRVariableGet(owner, "joyx", 0);
;
can_shoot = scrFRVariableGet(owner, "can_shoot", 1);
;
gunshine = scrFRVariableGet(owner, "gunshine", 0);
;
nearwep = scrFRVariableGet(owner, "nearwep", 0);
;
roll = scrFRVariableGet(owner, "roll", 0);
;
joyaimx = scrFRVariableGet(owner, "joyaimx", 0);
;
horrorstopsnd = scrFRVariableGet(owner, "horrorstopsnd", 0);
;
hammering = scrFRVariableGet(owner, "hammering", 0);
;
infammo = scrFRVariableGet(owner, "infammo", 0);
;
wepflip = scrFRVariableGet(owner, "wepflip", 1);
;
p = scrFRVariableGet(owner, "p", 0);
;
race = scrFRRaceResolve(scrFRVariableGet(owner, "race", ""));
;
can_swap = scrFRVariableGet(owner, "canswap", 1);
;
interfacepop = scrFRVariableGet(owner, "interfacepop", 1);
;
scrFRWeaponSlotWrite(scrFRSelf(self), "bwep", scrFRVariableGet(owner, "bwep", 0));
;
hammerhead = scrFRVariableGet(owner, "hammerhead", 0);
;
can_walk = scrFRVariableGet(owner, "canwalk", 1);
;
drawlowhp = scrFRVariableGet(owner, "drawlowhp", 0);
;
lasthit = scrFRVariableGet(owner, "lasthit", (- 4));
;
alias = scrFRVariableGet(owner, "alias", "");
;
clicked = scrFRVariableGet(owner, "clicked", 1);
;
bwepangle = scrFRVariableGet(owner, "bwepangle", 0);
;
can_spirit = scrFRVariableGet(owner, "canspirit", 1);
;
wave = scrFRVariableGet(owner, "wave", 0);
;
spiriteffect = scrFRVariableGet(owner, "spiriteffect", 0);
;
headloses = scrFRVariableGet(owner, "chickendeaths", 0);
;
can_aim = scrFRVariableGet(owner, "canaim", 1);
;
canscope = scrFRVariableGet(owner, "canscope", 1);
;
usespec = scrFRVariableGet(owner, "usespec", 0);
;
smoke = scrFRVariableGet(owner, "smoke", 0);
;
wepangle = scrFRVariableGet(owner, "wepangle", 0);
;
canrogue = scrFRVariableGet(owner, "canrogue", 1);
;
dogammo = scrFRVariableGet(owner, "dogammo", 15);
;
size = scrFRVariableGet(owner, "size", 5);
;
wepright = scrFRVariableGet(owner, "wepright", 1);
;
bwepflip = scrFRVariableGet(owner, "bwepflip", 1);
;
safeheadloss = scrFRVariableGet(owner, "safeheadloss", 0);
;
drawemptyb = scrFRVariableGet(owner, "drawemptyb", 0);
;
can_die = scrFRVariableGet(owner, "candie", 1);
;
binterfacepop = scrFRVariableGet(owner, "binterfacepop", 1);
;
showhp = scrFRVariableGet(owner, "showhp", 0);
;
can_pick = scrFRVariableGet(owner, "canpick", 1);
;
turn = scrFRVariableGet(owner, "turn", (- 1));
;
bcan_shoot = scrFRVariableGet(owner, "bcan_shoot", 1);
;
breload = scrFRVariableGet(owner, "breload", 0);
;
scrFRAmmoArrayWrite(scrFRSelf(self), "typ_name", scrFRVariableGet(owner, "typ_name", ["MELEE", "BULLETS", "SHELLS", "BOLTS", "EXPLOSIVES", "ENERGY"]));
;
back = scrFRVariableGet(owner, "back", 1);
;
bwkick = scrFRVariableGet(owner, "bwkick", 0);
;
footextra = scrFRVariableGet(owner, "footextra", 0);
;
bskin = scrFRSkinResolve(scrFRVariableGet(owner, "bskin", 0));
;
raddrop = scrFRVariableGet(owner, "raddrop", 0);
;
bcurse = scrFRVariableGet(owner, "bcurse", 0);
;
footkind = scrFRVariableGet(owner, "footkind", 0);
;
drawempty = scrFRVariableGet(owner, "drawempty", 0);
;
boilcap = scrFRVariableGet(owner, "boilcap", 0);
;
scrFRAmmoArrayWrite(scrFRSelf(self), "typ_ammo", scrFRVariableGet(owner, "typ_ammo", [264, 40, 10, 9, 8, 13]));
;
right = scrFRVariableGet(owner, "right", 1);
;
horrorcharge = scrFRVariableGet(owner, "horrorcharge", 0);
;
race = scrFRVariableGet(owner, "race_id", 0);
;
angle = scrFRVariableGet(owner, "angle", 0);
;
nexthurt = scrFRVariableGet(owner, "nexthurt", scrFRSourceFrame());
;
can_shoot = scrFRVariableGet(owner, "canfire", 1);
;
canfeet = scrFRVariableGet(owner, "canfeet", 1);
;
index = scrFRVariableGet(owner, "index", 0);
;
gunangle = _frl__gunangle;
;
creator = scrFRVariableGet(owner, "creator", (_frl__affectcreator ? owner : scrFRSelf(self)));
;
specfiring = 0;
;
reload = scrFRVariableGet(owner, "reload", 0);
;
familiar = 1;
;
_frl__wep = (is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) ? scrFRWeaponSlotRead(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
;
if ((is_string(_frl__wep) && scrFRScriptExists("weapon", _frl__wep, "step"))) {
{
scrFRModCall("weapon", _frl__wep, "step", 1);
;
}
}
scrFRPlayerFireExt(_frl__gunangle, scrFRWeaponSlotRead(scrFRSelf(self), "wep"), _frl__x, _frl__y, team, creator);
;
if ((scrFRInstanceExists(owner) && _frl__affectcreator)) {
{
if (scrFRVariableExists(owner, "wepangle")) {
{
owner.wepangle = (owner.wepangle * (scrFRWeaponIsMelee(_frl__wep) ? (- 1) : 1));
;
}
}
if (scrFRVariableExists(owner, "reload")) {
{
owner.reload = reload;
;
}
}
if (scrFRVariableExists(owner, "ammo")) {
{
owner.ammo = ammo;
;
}
}
}
}
time = current_time;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libGeneral.mod.gml:2311
function fr_dependencies_libGeneral_mod_gml_seeded_random(_frl__seed=undefined, _frl__min=undefined, _frl__max=undefined, _frl__irandom=undefined) {
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

// Original dependencies/libGeneral.mod.gml:2332
function fr_dependencies_libGeneral_mod_gml_object_get_mouse(_frl_inst=undefined) {
if ((scrFRVariableExists(_frl_inst, "scr_get_mouse") && is_array(_frl_inst.scr_get_mouse))) {
{
{ var __fr_with1 = scrFRWithValues(_frl_inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
return scrFRScriptCall(scr_get_mouse);
}
if(__fr_break3) break;
}}
}
}
if ((scrFRInstanceIs(_frl_inst, Player) || (scrFRVariableExists(_frl_inst, "index") && scrFRPlayerIsActive(_frl_inst.index)))) {
{
return {"x": scrFRMouseCoordinate(0, _frl_inst.index), "y": scrFRMouseCoordinate(1, _frl_inst.index), "is_input": true};
}
}
if ((scrFRVariableExists(_frl_inst, "target") && scrFRInstanceExists(_frl_inst.target))) {
{
return {"x": target.x, "y": target.y, "is_input": false};
}
}
var _frl__length = 48;
var _frl__dir = _frl_inst.direction;
;
if (scrFRVariableExists(_frl_inst, "gunangle")) {
{
_frl__dir = _frl_inst.gunangle;
;
}
}
return {"x": (_frl_inst.x + lengthdir_x(_frl__length, _frl__dir)), "y": (_frl_inst.y + lengthdir_y(_frl__length, _frl__dir)), "is_input": false};
}

// Original dependencies/libGeneral.mod.gml:2359
function fr_dependencies_libGeneral_mod_gml_run_movescan() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libGeneral_mod_gml_run_movescan_resume, id, scrFROther(other), _args, 59, ["_object", "_mod"]);
}
function fr_dependencies_libGeneral_mod_gml_run_movescan_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libGeneral_mod_gml_run_movescan");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libGeneral.mod.gml:2360
scrFRTaskWithNext(_fr);
break;
case 2: // dependencies/libGeneral.mod.gml:2360
scrFRTaskWithAbort(_fr);
break;
case 3: // dependencies/libGeneral.mod.gml:2433
scrFRTaskWithNext(_fr);
break;
case 4: // dependencies/libGeneral.mod.gml:2433
scrFRTaskWithAbort(_fr);
break;
case 5: // dependencies/libGeneral.mod.gml:2463
{
;
}
_fr.pc=3;
break;
case 6: // dependencies/libGeneral.mod.gml:2463
_fr.result=undefined; _fr.done=true; return;
break;
case 7: // dependencies/libGeneral.mod.gml:2459
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
scrFRInstanceDestroy();
;
}
}
}
_fr.pc=6;
break;
case 8: // dependencies/libGeneral.mod.gml:2459
_fr.wait_ticks=max(0,1); _fr.pc=7; return;
break;
case 9: // dependencies/libGeneral.mod.gml:2453
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=8;
break;
case 10: // dependencies/libGeneral.mod.gml:2453
_fr.wait_ticks=max(0,1); _fr.pc=9; return;
break;
case 11: // dependencies/libGeneral.mod.gml:2447
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=10;
break;
case 12: // dependencies/libGeneral.mod.gml:2447
_fr.wait_ticks=max(0,1); _fr.pc=11; return;
break;
case 13: // dependencies/libGeneral.mod.gml:2442
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=12;
break;
case 14: // dependencies/libGeneral.mod.gml:2441
_fr.pc = (scrFRTaskFork(_fr, 13)) ? 13 : 3;
break;
case 15: // dependencies/libGeneral.mod.gml:2434
{
var __fr_other1=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other1.sprite_index);
;
var __fr_other2=scrFROther(other);
image_index = __fr_other2.image_index;
;
image_speed = (0) * timescale;
;
var __fr_other3=scrFROther(other);
image_xscale = (__fr_other3.image_xscale * (scrFRVariableExists(__fr_other3, "right") ? __fr_other3.right : 1));
var __fr_other4=scrFROther(other);
image_yscale = __fr_other4.image_yscale;
var __fr_other5=scrFROther(other);
image_alpha = (__fr_other5.image_alpha * _fr.vars.size);
;
var __fr_other6=scrFROther(other);
image_angle = __fr_other6.image_angle;
;
}
_fr.pc=14;
break;
case 16: // dependencies/libGeneral.mod.gml:2433
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRInstanceCreate(x, y, FR_OBJECT_EFFECT)),15,1);
break;
case 17: // dependencies/libGeneral.mod.gml:2432
{
;
}
_fr.pc=16;
break;
case 18: // dependencies/libGeneral.mod.gml:2432
_fr.pc=1;
break;
case 19: // dependencies/libGeneral.mod.gml:2432
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 18 : 16;
break;
case 21: // dependencies/libGeneral.mod.gml:2363
_fr.vars.__fr_repeat7--; _fr.pc=20;
break;
case 22: // dependencies/libGeneral.mod.gml:2429
{
event_perform(ev_step, ev_step_end);
;
_fr.vars.size += (0.2 / _fr.vars._mod);
}
_fr.pc=21;
break;
case 23: // dependencies/libGeneral.mod.gml:2428
{
;
}
_fr.pc=22;
break;
case 24: // dependencies/libGeneral.mod.gml:2428
_fr.pc=21;
break;
case 25: // dependencies/libGeneral.mod.gml:2428
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 24 : 22;
break;
case 26: // dependencies/libGeneral.mod.gml:2415
{
xprevious = x;
;
yprevious = y;
;
x += hspeed;
;
y += vspeed;
;
_fr.vars._inst = fr_dependencies_libGeneral_mod_gml_instances_meeting(x, y, [projectile, hitme, Wall]);
;
{ var __fr_with8 = scrFRWithValues(_fr.vars._inst), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if ((! scrFRInstanceExists(_fr.vars._obj))) {
{
continue;
;
}
}
if (scrFRVariableExists(scrFRSelf(self), "nexthurt")) {
{
nexthurt -= scrFRSourceScale();
;
}
}
{ var __fr_with11 = scrFRWithValues(_fr.vars._obj), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
event_perform(ev_collision, scrFRObjectIndex(__fr_other14));
;
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
continue;
;
}
}
}
}
if(__fr_break13) break;
}}
}
}
if(__fr_break10) break;
}}
}
_fr.pc=25;
break;
case 27: // dependencies/libGeneral.mod.gml:2382
scrFRTaskWithNext(_fr);
break;
case 28: // dependencies/libGeneral.mod.gml:2382
scrFRTaskWithAbort(_fr);
break;
case 29: // dependencies/libGeneral.mod.gml:2412
{
;
}
_fr.pc=27;
break;
case 30: // dependencies/libGeneral.mod.gml:2412
_fr.result=undefined; _fr.done=true; return;
break;
case 31: // dependencies/libGeneral.mod.gml:2408
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
scrFRInstanceDestroy();
;
}
}
}
_fr.pc=30;
break;
case 32: // dependencies/libGeneral.mod.gml:2408
_fr.wait_ticks=max(0,1); _fr.pc=31; return;
break;
case 33: // dependencies/libGeneral.mod.gml:2402
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=32;
break;
case 34: // dependencies/libGeneral.mod.gml:2402
_fr.wait_ticks=max(0,1); _fr.pc=33; return;
break;
case 35: // dependencies/libGeneral.mod.gml:2396
{
;
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=34;
break;
case 36: // dependencies/libGeneral.mod.gml:2396
_fr.wait_ticks=max(0,1); _fr.pc=35; return;
break;
case 37: // dependencies/libGeneral.mod.gml:2391
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
image_alpha *= 0.5;
;
}
}
}
_fr.pc=36;
break;
case 38: // dependencies/libGeneral.mod.gml:2390
_fr.pc = (scrFRTaskFork(_fr, 37)) ? 37 : 27;
break;
case 39: // dependencies/libGeneral.mod.gml:2383
{
var __fr_other15=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other15.sprite_index);
;
var __fr_other16=scrFROther(other);
image_index = __fr_other16.image_index;
;
image_speed = (0) * timescale;
;
var __fr_other17=scrFROther(other);
image_xscale = (__fr_other17.image_xscale * (scrFRVariableExists(__fr_other17, "right") ? __fr_other17.right : 1));
var __fr_other18=scrFROther(other);
image_yscale = __fr_other18.image_yscale;
var __fr_other19=scrFROther(other);
image_alpha = (__fr_other19.image_alpha * _fr.vars.size);
;
var __fr_other20=scrFROther(other);
image_angle = __fr_other20.image_angle;
;
}
_fr.pc=38;
break;
case 40: // dependencies/libGeneral.mod.gml:2382
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRInstanceCreate(x, y, FR_OBJECT_EFFECT)),39,26);
break;
case 41: // dependencies/libGeneral.mod.gml:2378
{
if ((image_index >= image_number)) {
{
event_perform(ev_other, ev_animation_end);
}
}
image_index += image_speed;
;
}
_fr.pc=40;
break;
case 42: // dependencies/libGeneral.mod.gml:2377
{
;
}
_fr.pc=41;
break;
case 43: // dependencies/libGeneral.mod.gml:2377
_fr.pc=21;
break;
case 44: // dependencies/libGeneral.mod.gml:2377
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 43 : 41;
break;
case 45: // dependencies/libGeneral.mod.gml:2369
{
{
_fr.vars.i = 0;
for (; (_fr.vars.i < 4); _fr.vars.i++) {
if ((scrFRAlarmRead(scrFRSelf(self), _fr.vars.i) > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), _fr.vars.i, (scrFRAlarmRead(scrFRSelf(self), _fr.vars.i) - scrFRSourceScale()));
;
if ((scrFRAlarmRead(scrFRSelf(self), _fr.vars.i) <= 0)) {
{
event_perform(ev_alarm, _fr.vars.i);
;
}
}
}
}
}
}
}
_fr.pc=44;
break;
case 46: // dependencies/libGeneral.mod.gml:2368
{
;
}
_fr.pc=45;
break;
case 47: // dependencies/libGeneral.mod.gml:2368
_fr.pc=21;
break;
case 48: // dependencies/libGeneral.mod.gml:2368
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 47 : 45;
break;
case 49: // dependencies/libGeneral.mod.gml:2367
{
event_perform(ev_step, ev_step_normal);
;
}
_fr.pc=48;
break;
case 50: // dependencies/libGeneral.mod.gml:2366
{
;
}
_fr.pc=49;
break;
case 51: // dependencies/libGeneral.mod.gml:2366
_fr.pc=21;
break;
case 52: // dependencies/libGeneral.mod.gml:2366
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 51 : 49;
break;
case 53: // dependencies/libGeneral.mod.gml:2365
{
event_perform(ev_step, ev_step_begin);
;
}
_fr.pc=52;
break;
case 54: // dependencies/libGeneral.mod.gml:2364
{
;
}
_fr.pc=53;
break;
case 55: // dependencies/libGeneral.mod.gml:2364
_fr.pc=21;
break;
case 56: // dependencies/libGeneral.mod.gml:2364
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 55 : 53;
break;
case 20: // dependencies/libGeneral.mod.gml:2363
_fr.pc=(_fr.vars.__fr_repeat7>0)?56:19;
break;
case 57: // dependencies/libGeneral.mod.gml:2363
_fr.vars.__fr_repeat7=round(_fr.vars._mod); _fr.pc=20;
break;
case 58: // dependencies/libGeneral.mod.gml:2361
{
_fr.vars._obj = scrFRSelf(self);
;
_fr.vars.size = 0.8;
;
}
_fr.pc=57;
break;
case 59: // dependencies/libGeneral.mod.gml:2360
scrFRTaskWithEnter(_fr,scrFRWithValues(_fr.vars._object),58,0);
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libGeneral.mod.gml:2468
function fr_dependencies_libGeneral_mod_gml_loc_format() {
var _frl__text = loc((argument_count>0 ? argument[0] : undefined), (argument_count>1 ? argument[1] : undefined));
;
var _frl__valuePos = 2;
;
if ((argument_count > _frl__valuePos)) {
{
if ((argument_count <= (_frl__valuePos + 1))) {
{
_frl__text = string_replace_all(_frl__text, "%", string((argument_count>_frl__valuePos && _frl__valuePos>=0 ? argument[_frl__valuePos] : undefined)));
;
}
} else {
{
var _frl__split = string_split(_frl__text, "%");
;
{
var _frl_i = (array_length(_frl__split) - 1);
for (; (_frl_i >= 1); _frl_i--) {
var _frl__num = ((_frl__valuePos + real(string_char_at(scrFRIndexGet(_frl__split, _frl_i), 1))) - 1);
;
scrFRIndexPathWrite(_frl__split, [_frl_i], ((((_frl__num >= _frl__valuePos) && (_frl__num < argument_count)) ? string((argument_count>_frl__num && _frl__num>=0 ? argument[_frl__num] : undefined)) : "") + string_delete(scrFRIndexGet(_frl__split, _frl_i), 1, 1)), "=");
;
}
}
_frl__text = scrFRArrayJoin(_frl__split, "");
;
}
}
}
}
return _frl__text;
;
}
