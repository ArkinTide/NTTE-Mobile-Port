#macro frMacro_dependencies_libSettings_mod_gml_scr global.fr_module_vars[$ "mod:libSettings"].scr

#macro frMacro_dependencies_libSettings_mod_gml_call scrFRScriptCall

// Original dependencies/libSettings.mod.gml:1
function fr_dependencies_libSettings_mod_gml___load() {

}

// Original dependencies/libSettings.mod.gml:15
function fr_dependencies_libSettings_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libSettings", _frl_name]);
;
}

// Original dependencies/libSettings.mod.gml:18
function fr_dependencies_libSettings_mod_gml_init() {
global.fr_module_vars[$ "mod:libSettings"].settings = [];
;
global.fr_module_vars[$ "mod:libSettings"].open = 0;
;
global.fr_module_vars[$ "mod:libSettings"].offset = 0;
;
global.fr_module_vars[$ "mod:libSettings"].textInput = (- 1);
;
frMacro_dependencies_libSettings_mod_gml_scr = false;
;
fr_dependencies_libSettings_mod_gml_addScript("add_setting");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libSettings"].isLoaded = true;
;
scrFRScriptCall(["mod", "lib", "import"], "libMenu");
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libSettings", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}

// Original dependencies/libSettings.mod.gml:48
function fr_dependencies_libSettings_mod_gml_draw_gui() {
if ((((! scrFRInstanceExists(Menu)) || (frMacro_dependencies_libSettings_mod_gml_scr == false)) || (array_length(global.fr_module_vars[$ "mod:libSettings"].settings) == 0))) {
{
return;
;
}
}
draw_set_font(fntSmall);
;
draw_set_color(c_white);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, (view_width - 40), (view_height - 6), 38, 4, 2, 1) != (- 1))) {
{
draw_set_color(c_lime);
;
}
}
scrFRDrawTextPlain((view_width - 40), (view_height - 6), "[SETTINGS]");
;
draw_set_font(fntM0);
;
draw_set_color(c_black);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, (view_width - 40), (view_height - 6), 38, 4, 0, 1) != (- 1))) {
{
global.fr_module_vars[$ "mod:libSettings"].open = (! global.fr_module_vars[$ "mod:libSettings"].open);
;
}
}
if (global.fr_module_vars[$ "mod:libSettings"].open) {
{
draw_set_color(c_white);
;
var _frl_offset = global.fr_module_vars[$ "mod:libSettings"].offset;
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "mod:libSettings"].settings)); _frl_i++) {
var _frl_v = scrFRModGet("mod", scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1), scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2));
;
scrFRDrawSprite(sprScoreSplat, 2, ((view_width / 2) - 95), (42 + (_frl_offset * 10)));
;
scrFRDrawSprite(sprScoreSplat, 2, ((view_width / 2) - 65), (42 + (_frl_offset * 10)));
;
scrFRDrawSprite(sprScoreSplat, 2, ((view_width / 2) - 35), (42 + (_frl_offset * 10)));
;
scrFRDrawSprite(sprScoreSplat, 2, ((view_width / 2) + 25), (42 + (_frl_offset * 10)));
;
_frl_offset++;
;
}
}
_frl_offset = global.fr_module_vars[$ "mod:libSettings"].offset;
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "mod:libSettings"].settings)); _frl_i++) {
draw_set_halign(2);
;
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 3) + " "));
;
draw_set_halign(1);
;
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), ":");
;
draw_set_halign(0);
;
if (is_array(scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2))) {
{
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 2, 1) != (- 1))) {
{
draw_set_color(c_lime);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 0, 1) != (- 1))) {
{
scrFRScriptCall(scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2));
;
}
}
}
}
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), " Activate");
;
}
} else {
{
var _frl_v = scrFRModGet("mod", scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1), scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2));
;
if (((_frl_v == true) || (_frl_v == false))) {
{
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 2, 1) != (- 1))) {
{
draw_set_color(c_lime);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 0, 1) != (- 1))) {
{
scrFRModSet("mod", scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1), scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2), (! _frl_v));
;
}
}
}
}
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), (" " + (_frl_v ? "On" : "Off")));
;
}
} else {
if (is_string(_frl_v)) {
{
if ((_frl_i == global.fr_module_vars[$ "mod:libSettings"].textInput)) {
{
draw_set_color(c_aqua);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 2, 1) != (- 1))) {
{
draw_set_color(c_orange);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 0, 1) != (- 1))) {
{
global.fr_module_vars[$ "mod:libSettings"].textInput = (- 1);
;
}
}
}
}
}
} else {
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 2, 1) != (- 1))) {
{
draw_set_color(c_lime);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 0, 1) != (- 1))) {
{
global.fr_module_vars[$ "mod:libSettings"].textInput = _frl_i;
;
}
}
}
}
}
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), (" " + string(_frl_v)));
;
}
} else {
if (is_array(_frl_v)) {
{
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 2, 1) != (- 1))) {
{
draw_set_color(c_lime);
;
if ((frMacro_dependencies_libSettings_mod_gml_call(frMacro_dependencies_libSettings_mod_gml_scr.menubutton_check, ((view_width / 2) + 30), (40 + (_frl_offset * 10)), 60, 9, 0, 1) != (- 1))) {
{
var _frl_arr = [];
;
{
i2 = 1;
for (; (i2 < array_length(_frl_v)); i2++) {
array_push(_frl_arr, scrFRIndexGet(_frl_v, i2));
;
}
}
array_push(_frl_arr, scrFRIndexGet(_frl_v, 0));
;
scrFRModSet("mod", scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1), scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2), _frl_arr);
;
}
}
}
}
scrFRDrawTextPlain(((view_width / 2) + 30), (40 + (_frl_offset * 10)), (" " + string(scrFRIndexGet(_frl_v, 0))));
;
}
}
}
}
}
}
draw_set_color(c_white);
;
_frl_offset++;
;
}
}
draw_set_color(c_black);
;
}
}
}

// Original dependencies/libSettings.mod.gml:136
function fr_dependencies_libSettings_mod_gml_chat_message(_frl__message=undefined, _frl__player=undefined) {
if ((global.fr_module_vars[$ "mod:libSettings"].textInput != (- 1))) {
{
scrFRModSet("mod", scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, global.fr_module_vars[$ "mod:libSettings"].textInput), 1), scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, global.fr_module_vars[$ "mod:libSettings"].textInput), 2), _frl__message);
;
global.fr_module_vars[$ "mod:libSettings"].textInput = (- 1);
;
}
}
}

// Original dependencies/libSettings.mod.gml:142
function fr_dependencies_libSettings_mod_gml_add_setting(_frl__modName=undefined, _frl__variableName=undefined, _frl__visualName=undefined) {
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "mod:libSettings"].settings)); _frl_i++) {
if (((((scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 0) == "mod") && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1) == _frl__modName)) && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2) == _frl__variableName)) && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 3) == _frl__visualName))) {
{
return;
;
}
}
}
}
array_push(global.fr_module_vars[$ "mod:libSettings"].settings, ["mod", _frl__modName, _frl__variableName, _frl__visualName]);
;
}

// Original dependencies/libSettings.mod.gml:150
function fr_dependencies_libSettings_mod_gml_add_setting_ext(_frl__modName=undefined, _frl__modType=undefined, _frl__variableName=undefined, _frl__visualName=undefined) {
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "mod:libSettings"].settings)); _frl_i++) {
if (((((scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 0) == _frl__modType) && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 1) == _frl__modName)) && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 2) == _frl__variableName)) && (scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "mod:libSettings"].settings, _frl_i), 3) == _frl__visualName))) {
{
return;
;
}
}
}
}
array_push(global.fr_module_vars[$ "mod:libSettings"].settings, [_frl__modType, _frl__modName, _frl__variableName, _frl__visualName]);
;
}
