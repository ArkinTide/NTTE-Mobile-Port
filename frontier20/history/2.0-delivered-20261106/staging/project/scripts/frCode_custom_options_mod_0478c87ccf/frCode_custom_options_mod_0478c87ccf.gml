#macro frMacro_custom_options_mod_gml_VERSION "9940, 9944, and v100 (patch 5)"

#macro frMacro_custom_options_mod_gml_scr global.fr_module_vars[$ "mod:custom_options"].scr

#macro frMacro_custom_options_mod_gml_call scrFRScriptCall

#macro frMacro_custom_options_mod_gml_mod_current_type global.fr_module_vars[$ "mod:custom_options"].mod_current_type

#macro frMacro_custom_options_mod_gml_CONTROLLER ((("custom_options" + ".") + frMacro_custom_options_mod_gml_mod_current_type) + " CONTROLLER")

#macro frMacro_custom_options_mod_gml_MENU global.fr_module_vars[$ "mod:custom_options"].menu

// Original custom_options.mod.gml:1
function fr_custom_options_mod_gml___load() {
; // macro hoisted: VERSION
}

// Original custom_options.mod.gml:2
function fr_custom_options_mod_gml_init() { return scrFRCustomOptionsInit(); }

// Original custom_options.mod.gml:170
function fr_custom_options_mod_gml_cleanup() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRVariableSet(scrFRSelf(self), frMacro_custom_options_mod_gml_CONTROLLER, "custom_options");
;
persistent = true;
;
export_to = global.fr_module_vars[$ "mod:custom_options"].export_to;
;
menu = frMacro_custom_options_mod_gml_MENU;
;
menu.region = array_create(INPUT_MAX_PLAYERS, undefined);
;
}
}
if(__fr_break3) break;
}}
if (frMacro_custom_options_mod_gml_MENU.open) {
{
fr_custom_options_mod_gml_save_options();
;
}
}
var _frl_i = (- 1);
;
repeat (ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions)) {
_frl_i += 1;
;
if ((_frl_i >= ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions))) {
{
break;
;
}
}
var _frl__region = global.fr_module_vars[$ "mod:custom_options"].regions[|_frl_i];
;
fr_custom_options_mod_gml_region_destroy(_frl__region);
;
}
if (scrFRListValid(global.fr_module_vars[$ "mod:custom_options"].regions)) {
{
ds_list_destroy(global.fr_module_vars[$ "mod:custom_options"].regions);
;
}
}
if (scrFRInstanceExists(global.fr_module_vars[$ "mod:custom_options"].drawing_controller)) {
{
scrFRDelete(global.fr_module_vars[$ "mod:custom_options"].drawing_controller);
;
}
}
if (scrFRMapValid(global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache)) {
{
ds_map_destroy(global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache);
;
}
}
if (scrFRMapValid(global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache)) {
{
ds_map_destroy(global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache);
;
}
}
if (sprite_exists(global.fr_module_vars[$ "mod:custom_options"].options_icon)) {
{
scrFRSpriteDelete(global.fr_module_vars[$ "mod:custom_options"].options_icon);
;
}
}
if (sprite_exists(global.fr_module_vars[$ "mod:custom_options"].options_slider)) {
{
scrFRSpriteDelete(global.fr_module_vars[$ "mod:custom_options"].options_slider);
;
}
}
if (scrFRListValid(global.fr_module_vars[$ "mod:custom_options"].surface_targets)) {
{
ds_list_destroy(global.fr_module_vars[$ "mod:custom_options"].surface_targets);
;
}
}
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: mod_current_type
; // macro hoisted: CONTROLLER
; // macro hoisted: MENU
}

// Original custom_options.mod.gml:235
function fr_custom_options_mod_gml_scr_import() {
var _frl__modReference = (argument_count>0 ? argument[0] : undefined);
;
var _frl__modVariable = ((argument_count > 1) ? (argument_count>1 ? argument[1] : undefined) : "scr");
;
if ((! scrFRModLoaded(scrFRIndexGet(_frl__modReference, 0), scrFRIndexGet(_frl__modReference, 1)))) {
{
exit;
;
}
}
var _frl__exportedScripts = {};
;
var _frl__scriptCount = scrFRLQSize(frMacro_custom_options_mod_gml_scr);
;
var _frl_i = (- 1);
;
if ((_frl__scriptCount > 0)) {
{
repeat (_frl__scriptCount) {
_frl_i += 1;
;
var _frl__scriptReference = scrFRLQValue(frMacro_custom_options_mod_gml_scr, _frl_i);
;
if (((scrFRIndexGet(_frl__scriptReference, 0) == frMacro_custom_options_mod_gml_mod_current_type) && (scrFRIndexGet(_frl__scriptReference, 1) == "custom_options"))) {
{
scrFRLQSet(_frl__exportedScripts, scrFRLQKey(frMacro_custom_options_mod_gml_scr, _frl_i), scrFRArrayClone(_frl__scriptReference));
;
}
}
}
}
}
if ((! is_struct(scrFRModGet(scrFRIndexGet(_frl__modReference, 0), scrFRIndexGet(_frl__modReference, 1), _frl__modVariable)))) {
{
scrFRModSet(scrFRIndexGet(_frl__modReference, 0), scrFRIndexGet(_frl__modReference, 1), _frl__modVariable, _frl__exportedScripts);
;
}
} else {
{
var _frl__modScripts = scrFRModGet(scrFRIndexGet(_frl__modReference, 0), scrFRIndexGet(_frl__modReference, 1), _frl__modVariable);
;
var _frl__exportedScriptCount = scrFRLQSize(_frl__exportedScripts);
;
_frl_i = (- 1);
;
if ((_frl__exportedScriptCount > 0)) {
{
repeat (_frl__exportedScriptCount) {
_frl_i += 1;
;
scrFRLQSet(_frl__modScripts, scrFRLQKey(_frl__exportedScripts, _frl_i), scrFRArrayClone(scrFRLQValue(_frl__exportedScripts, _frl_i)));
;
}
}
}
}
}
scrFRLQSet(global.fr_module_vars[$ "mod:custom_options"].export_to, ((scrFRIndexGet(_frl__modReference, 1) + ".") + scrFRIndexGet(_frl__modReference, 0)), _frl__modVariable);
;
}

// Original custom_options.mod.gml:279
function fr_custom_options_mod_gml_chat_command() { return scrFROfflineLoader("mod:custom_options"); }

// Original custom_options.mod.gml:371
function fr_custom_options_mod_gml_option_set(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__value=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
return undefined;
;
}
}
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if ((_frl__pageIndex < 0)) {
{
return undefined;
;
}
}
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
if ((_frl__optionIndex < 0)) {
{
return undefined;
;
}
}
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, _frl__pageIndex);
;
if ((_frl__page.page_data.kind != "options")) {
{
return undefined;
;
}
}
var _frl__option = scrFRIndexGet(_frl__page.options, _frl__optionIndex);
;
if (is_struct(_frl__option)) {
{
var _frl__point = scrFRLQGet(_frl__option, "point", undefined);
;
var _frl__pointInOption = true;
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__page, "point", undefined);
;
_frl__pointInOption = false;
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__mod, "point", undefined);
;
}
}
}
}
var _frl__modOptions = scrFRModGet(scrFRIndexGet(_frl__point, 0), scrFRIndexGet(_frl__point, 1), scrFRIndexGet(_frl__point, 2));
;
if (((! _frl__pointInOption) || is_struct(_frl__modOptions))) {
{
if ((_frl__modOptions == undefined)) {
{
_frl__modOptions = {};
;
scrFRModSet(scrFRIndexGet(_frl__point, 0), scrFRIndexGet(_frl__point, 1), scrFRIndexGet(_frl__point, 2), _frl__modOptions);
;
}
}
if (is_struct(_frl__modOptions)) {
{
scrFRLQSet(_frl__modOptions, _frl__optionName, _frl__value);
;
return _frl__value;
;
}
}
}
} else {
{
scrFRModSet(scrFRIndexGet(_frl__point, 0), scrFRIndexGet(_frl__point, 1), scrFRIndexGet(_frl__point, 2), _frl__value);
;
return _frl__value;
;
}
}
}
}
return undefined;
;
}

// Original custom_options.mod.gml:432
function fr_custom_options_mod_gml_option_get(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
return undefined;
;
}
}
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if ((_frl__pageIndex < 0)) {
{
return undefined;
;
}
}
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
if ((_frl__optionIndex < 0)) {
{
return undefined;
;
}
}
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, _frl__pageIndex);
;
if ((_frl__page.page_data.kind != "options")) {
{
return undefined;
;
}
}
var _frl__option = scrFRIndexGet(_frl__page.options, _frl__optionIndex);
;
if (is_struct(_frl__option)) {
{
var _frl__point = scrFRLQGet(_frl__option, "point", undefined);
;
var _frl__pointInOption = true;
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__page, "point", undefined);
;
_frl__pointInOption = false;
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__mod, "point", undefined);
;
}
}
}
}
var _frl__modOptions = scrFRModGet(scrFRIndexGet(_frl__point, 0), scrFRIndexGet(_frl__point, 1), scrFRIndexGet(_frl__point, 2));
;
if (((! _frl__pointInOption) || is_struct(_frl__modOptions))) {
{
return scrFRLQGet(_frl__modOptions, _frl__optionName, undefined);
;
}
} else {
{
return _frl__modOptions;
;
}
}
}
}
return undefined;
;
}

// Original custom_options.mod.gml:484
function fr_custom_options_mod_gml_option_defget(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__defValue=undefined) {
var _frl__value = fr_custom_options_mod_gml_option_get(_frl__modType, _frl__modName, _frl__pageName, _frl__optionName);
;
return ((_frl__value == undefined) ? _frl__defValue : _frl__value);
;
}

// Original custom_options.mod.gml:488
function fr_custom_options_mod_gml_option_set_fake_nonsync(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__player=undefined, _frl__value=undefined) {
var _frl__fakeNonsync = fr_custom_options_mod_gml_option_get(_frl__modType, _frl__modName, _frl__pageName, _frl__optionName);
;
if (((! is_array(_frl__fakeNonsync)) || (array_length(_frl__fakeNonsync) <= _frl__player))) {
{
fr_custom_options_mod_gml_option_set(_frl__modType, _frl__modName, _frl__pageName, _frl__optionName, array_create(INPUT_MAX_PLAYERS, _frl__value));
;
}
} else {
{
scrFRIndexPathWrite(_frl__fakeNonsync, [_frl__player], _frl__value, "=");
;
}
}
return _frl__value;
;
}

// Original custom_options.mod.gml:499
function fr_custom_options_mod_gml_option_get_fake_nonsync(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__player=undefined) {
var _frl__fakeNonsync = fr_custom_options_mod_gml_option_get(_frl__modType, _frl__modName, _frl__pageName, _frl__optionName);
;
if (((! is_array(_frl__fakeNonsync)) || (array_length(_frl__fakeNonsync) <= _frl__player))) {
{
return undefined;
;
}
}
return scrFRIndexGet(_frl__fakeNonsync, _frl__player);
;
}

// Original custom_options.mod.gml:508
function fr_custom_options_mod_gml_option_defget_fake_nonsync(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__player=undefined, _frl__defValue=undefined) {
var _frl__fakeNonsync = fr_custom_options_mod_gml_option_get_fake_nonsync(_frl__modType, _frl__modName, _frl__pageName, _frl__player, _frl__optionName);
;
return ((_frl__fakeNonsync == undefined) ? _frl__defValue : _frl__fakeNonsync);
;
}

// Original custom_options.mod.gml:512
function fr_custom_options_mod_gml_option_set_field(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__field=undefined, _frl__value=undefined) {
if ((_frl__field == "option_data")) {
{
return undefined;
;
}
}
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
return undefined;
;
}
}
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if ((_frl__pageIndex < 0)) {
{
return undefined;
;
}
}
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
if ((_frl__optionIndex < 0)) {
{
return undefined;
;
}
}
scrFRLQSet(scrFRIndexGet(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex).pages, _frl__pageIndex).options, _frl__optionIndex), _frl__field, _frl__value);
;
return _frl__value;
;
}

// Original custom_options.mod.gml:538
function fr_custom_options_mod_gml_option_get_field(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__field=undefined) {
if ((_frl__field == "option_data")) {
{
return undefined;
;
}
}
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
return undefined;
;
}
}
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if ((_frl__pageIndex < 0)) {
{
return undefined;
;
}
}
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
if ((_frl__optionIndex < 0)) {
{
return undefined;
;
}
}
return scrFRLQGet(scrFRIndexGet(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex).pages, _frl__pageIndex).options, _frl__optionIndex), _frl__field);
;
}

// Original custom_options.mod.gml:563
function fr_custom_options_mod_gml_option_defget_field(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__field=undefined, _frl__defValue=undefined) {
if ((_frl__field == "option_data")) {
{
return undefined;
;
}
}
var _frl__value = fr_custom_options_mod_gml_option_get_field(_frl__modType, _frl__modName, _frl__pageName, _frl__optionName, _frl__field);
;
if ((_frl__value != undefined)) {
{
return _frl__value;
;
}
}
return _frl__defValue;
;
}

// Original custom_options.mod.gml:576
function fr_custom_options_mod_gml_option_add(_frl__modType=undefined, _frl__modName=undefined, _frl__modVariable=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__option=undefined) {
if (is_string(_frl__option)) {
{
_frl__option = scrFRJsonDecode(_frl__option);
;
if ((_frl__option == scrFRJsonError())) {
{
scrFRTraceColor(("Failed to add option \"" + string(_frl__optionName) + "\" to " + string(_frl__modName) + "." + string(_frl__modType) + "'s page \"" + string(_frl__pageName) + "\":"), c_red);
;
scrFRTraceColor(scrFRJsonErrorText(), c_red);
;
exit;
;
}
}
}
} else {
if ((! is_struct(_frl__option))) {
{
scrFRTraceColor(("Failed to add option \"" + string(_frl__optionName) + "\" to " + string(_frl__modName) + "." + string(_frl__modType) + "'s page \"" + string(_frl__pageName) + "\":"), c_red);
;
scrFRTraceColor(("\"" + string(_frl__option) + "\" must be a lightweight object or JSON string"), c_red);
;
exit;
;
}
}
}
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
array_push(frMacro_custom_options_mod_gml_MENU.mods, {"mod_data": {"name": _frl__modName, "kind": _frl__modType}, "name": _frl__modName, "point": [_frl__modType, _frl__modName, _frl__modVariable], "pages": [], "page_index": array_create(INPUT_MAX_PLAYERS, 0)});
;
_frl__modIndex = (frMacro_custom_options_mod_gml_MENU.mod_count++);
;
}
}
var _frl__modLq = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if ((_frl__pageIndex < 0)) {
{
array_push(_frl__modLq.pages, {"page_data": {"name": _frl__pageName, "kind": "options"}, "options": []});
;
_frl__pageIndex = (array_length(_frl__modLq.pages) - 1);
;
}
}
return fr_custom_options_mod_gml_option_add_direct(scrFRIndexGet(_frl__modLq.pages, _frl__pageIndex), _frl__option);
;
}

// Original custom_options.mod.gml:628
function fr_custom_options_mod_gml_option_add_direct(_frl__pageLq=undefined, _frl__option=undefined) {
var _frl__realOption = {"option_data": {"name": scrFRLQGet(_frl__option, "option"), "kind": scrFRLQGet(_frl__option, "kind", scrFRLQGet(_frl__option, "type"))}};
;
var _frl__optionSize = scrFRLQSize(_frl__option);
;
var _frl_i = (- 1);
;
if ((_frl__optionSize > 0)) {
{
repeat (_frl__optionSize) {
_frl_i += 1;
;
var _frl__optionKey = scrFRLQKey(_frl__option, _frl_i);
;
if ((((_frl__optionKey != "option_data") && (_frl__optionKey != "option")) && (_frl__optionKey != "kind"))) {
{
scrFRLQSet(_frl__realOption, _frl__optionKey, scrFRLQValue(_frl__option, _frl_i));
;
}
}
}
}
}
array_push(_frl__pageLq.options, _frl__realOption);
;
return _frl__realOption;
;
}

// Original custom_options.mod.gml:654
function fr_custom_options_mod_gml_option_add_page(_frl__modType=undefined, _frl__modName=undefined, _frl__modVariable=undefined, _frl__pageName=undefined, _frl__page=undefined) {
if (is_string(_frl__page)) {
{
_frl__page = scrFRJsonDecode(_frl__page);
;
if ((_frl__page == scrFRJsonError())) {
{
scrFRTraceColor(("Failed to add page \"" + string(_frl__pageName) + "\" to " + string(_frl__modName) + "." + string(_frl__modType) + ":"), c_red);
;
scrFRTraceColor(scrFRJsonErrorText(), c_red);
;
exit;
;
}
}
}
} else {
if ((((! is_struct(_frl__page)) || (scrFRLQSize(_frl__page) <= 0)) && ((! is_array(_frl__page)) || (array_length(_frl__page) <= 2)))) {
{
scrFRTraceColor(("Failed to add page \"" + string(_frl__pageName) + "\" to " + string(_frl__modName) + "." + string(_frl__modType) + ":"), c_red);
;
scrFRTraceColor(("\"" + string(_frl__page) + "\" must be a lightweight object, a JSON string, or a script reference"), c_red);
;
exit;
;
}
}
}
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex < 0)) {
{
array_push(frMacro_custom_options_mod_gml_MENU.mods, {"mod_data": {"name": _frl__modName, "kind": _frl__modType}, "name": _frl__modName, "point": [_frl__modType, _frl__modName, _frl__modVariable], "pages": [], "page_index": array_create(INPUT_MAX_PLAYERS, 0)});
;
_frl__modIndex = (frMacro_custom_options_mod_gml_MENU.mod_count++);
;
}
}
return fr_custom_options_mod_gml_option_add_page_direct(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex), _frl__pageName, _frl__page);
;
}

// Original custom_options.mod.gml:690
function fr_custom_options_mod_gml_option_add_page_direct(_frl__modLq=undefined, _frl__pageName=undefined, _frl__page=undefined) {
if (scrFRLQHas(_frl__page, "options")) {
{
var _frl__realPage = {"page_data": {"name": _frl__pageName, "kind": "options"}, "options": []};
;
var _frl__optionCount = array_length(_frl__page.options);
;
var _frl_i = (- 1);
;
if ((_frl__optionCount > 0)) {
{
repeat (_frl__optionCount) {
_frl_i += 1;
;
fr_custom_options_mod_gml_option_add_direct(_frl__realPage, scrFRIndexGet(_frl__page.options, _frl_i));
;
}
}
}
_frl__page = _frl__realPage;
;
}
} else {
if (scrFRLQHas(_frl__page, "reference")) {
{
_frl__page = {"page_data": {"name": _frl__pageName, "kind": "script"}, "reference": _frl__page.reference};
;
}
}
}
array_push(_frl__modLq.pages, _frl__page);
;
return _frl__page;
;
}

// Original custom_options.mod.gml:725
function fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex=undefined, _frl__pageIndex=undefined, _frl__optionName=undefined) {
if (((_frl__modIndex < 0) || (_frl__pageIndex < 0))) {
{
return (- 1);
;
}
}
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, _frl__pageIndex);
;
if ((_frl__page.page_data.kind != "options")) {
{
return (- 1);
;
}
}
var _frl__optionCount = array_length(_frl__page.options);
;
var _frl_i = (- 1);
;
if ((_frl__optionCount > 0)) {
{
repeat (_frl__optionCount) {
_frl_i += 1;
;
var _frl__option = scrFRIndexGet(_frl__page.options, _frl_i);
;
if ((_frl__option.option_data.name == _frl__optionName)) {
{
return _frl_i;
;
}
}
}
}
}
return (- 1);
;
}

// Original custom_options.mod.gml:754
function fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex=undefined, _frl__pageName=undefined) {
if ((_frl__modIndex < 0)) {
{
return (- 1);
;
}
}
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__pageCount = array_length(_frl__mod.pages);
;
var _frl_i = (- 1);
;
if ((_frl__pageCount > 0)) {
{
repeat (_frl__pageCount) {
_frl_i += 1;
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, _frl_i);
;
if ((_frl__page.page_data.name == _frl__pageName)) {
{
return _frl_i;
;
}
}
}
}
}
return (- 1);
;
}

// Original custom_options.mod.gml:778
function fr_custom_options_mod_gml_mod_get_index(_frl__modType=undefined, _frl__modName=undefined) {
var _frl__modCount = frMacro_custom_options_mod_gml_MENU.mod_count;
;
var _frl_i = (- 1);
;
if ((_frl__modCount > 0)) {
{
repeat (_frl__modCount) {
_frl_i += 1;
;
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl_i);
;
if (((_frl__mod.mod_data.name == _frl__modName) && (_frl__mod.mod_data.kind == _frl__modType))) {
{
return _frl_i;
;
}
}
}
}
}
return (- 1);
;
}

// Original custom_options.mod.gml:796
function fr_custom_options_mod_gml_option_remove(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
while ((((_frl__modIndex >= 0) && (_frl__pageIndex >= 0)) && (_frl__optionIndex >= 0))) {
fr_custom_options_mod_gml_remove_mod_page_option_by_index(_frl__modIndex, _frl__pageIndex, _frl__optionIndex);
;
_frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
_frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
_frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
}
}

// Original custom_options.mod.gml:809
function fr_custom_options_mod_gml_remove_mod_page_option_by_index(_frl__modIndex=undefined, _frl__pageIndex=undefined, _frl__optionIndex=undefined) {
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, _frl__pageIndex);
;
var _frl__newOptions = scrFRArraySlice(_frl__page.options, 0, _frl__optionIndex);
;
array_copy(_frl__newOptions, _frl__optionIndex, _frl__page.options, (_frl__optionIndex + 1), (array_length(_frl__page.options) - (_frl__optionIndex + 1)));
;
_frl__page.options = _frl__newOptions;
;
if ((array_length(_frl__page.options) <= 0)) {
{
fr_custom_options_mod_gml_remove_mod_page_by_index(_frl__mod, _frl__pageIndex);
;
}
}
}

// Original custom_options.mod.gml:821
function fr_custom_options_mod_gml_option_remove_page(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
while (((_frl__modIndex >= 0) && (_frl__pageIndex >= 0))) {
fr_custom_options_mod_gml_remove_mod_page_by_index(_frl__modIndex, _frl__pageName);
;
_frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
_frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
}
}

// Original custom_options.mod.gml:832
function fr_custom_options_mod_gml_remove_mod_page_by_index(_frl__modIndex=undefined, _frl__pageIndex=undefined) {
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex);
;
var _frl__newPages = scrFRArraySlice(_frl__mod.pages, 0, _frl__pageIndex);
;
array_copy(_frl__newPages, _frl__pageIndex, _frl__mod.pages, (_frl__pageIndex + 1), (array_length(_frl__mod.pages) - (_frl__pageIndex + 1)));
;
_frl__mod.pages = _frl__newPages;
;
if ((array_length(_frl__mod.pages) <= 0)) {
{
fr_custom_options_mod_gml_remove_mod_by_index(_frl__modIndex);
;
}
}
}

// Original custom_options.mod.gml:843
function fr_custom_options_mod_gml_option_remove_mod(_frl__modType=undefined, _frl__modName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
while ((_frl__modIndex >= 0)) {
fr_custom_options_mod_gml_remove_mod_by_index(_frl__modIndex);
;
_frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
}
}

// Original custom_options.mod.gml:852
function fr_custom_options_mod_gml_remove_mod_by_index(_frl__modIndex=undefined) {
var _frl__newMods = scrFRArraySlice(frMacro_custom_options_mod_gml_MENU.mods, 0, _frl__modIndex);
;
array_copy(_frl__newMods, _frl__modIndex, frMacro_custom_options_mod_gml_MENU.mods, (_frl__modIndex + 1), ((frMacro_custom_options_mod_gml_MENU.mod_count--) - (_frl__modIndex + 1)));
;
frMacro_custom_options_mod_gml_MENU.mods = _frl__newMods;
;
}

// Original custom_options.mod.gml:857
function fr_custom_options_mod_gml_option_set_mod_display_name(_frl__modType=undefined, _frl__modName=undefined, _frl__modDisplayName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
if ((_frl__modIndex >= 0)) {
{
scrFRLQSet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex), "name", _frl__modDisplayName);
;
}
}
}

// Original custom_options.mod.gml:864
function fr_custom_options_mod_gml_option_set_page_display_name(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__pageDisplayName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
if (((_frl__modIndex >= 0) && (_frl__pageIndex >= 0))) {
{
scrFRLQSet(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex).pages, _frl__pageIndex), "name", _frl__pageDisplayName);
;
}
}
}

// Original custom_options.mod.gml:872
function fr_custom_options_mod_gml_option_set_display_name(_frl__modType=undefined, _frl__modName=undefined, _frl__pageName=undefined, _frl__optionName=undefined, _frl__optionDisplayName=undefined) {
var _frl__modIndex = fr_custom_options_mod_gml_mod_get_index(_frl__modType, _frl__modName);
;
var _frl__pageIndex = fr_custom_options_mod_gml_mod_page_get_index(_frl__modIndex, _frl__pageName);
;
var _frl__optionIndex = fr_custom_options_mod_gml_mod_page_option_get_index(_frl__modIndex, _frl__pageIndex, _frl__optionName);
;
if ((((_frl__modIndex >= 0) && (_frl__pageIndex >= 0)) && (_frl__optionIndex >= 0))) {
{
scrFRLQSet(scrFRIndexGet(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, _frl__modIndex).pages, _frl__pageIndex).options, _frl__optionIndex), "name", (is_string(_frl__optionDisplayName) ? {"text": _frl__optionDisplayName} : _frl__optionDisplayName));
;
}
}
}

// Original custom_options.mod.gml:885
function fr_custom_options_mod_gml_options_refresh() {
if ((! frMacro_custom_options_mod_gml_MENU.open)) {
{
exit;
;
}
}
var _frl__uids = [];
;
var _frl_p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl_p += 1;
;
if (scrFRPlayerIsActive(_frl_p)) {
{
var _frl__uid = scrFRPlayerUID(_frl_p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p) != undefined)) {
{
var _frl__selectedIndex = scrFRArrayFindIndex(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).children, (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).child_count - 1)).children, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p));
;
fr_custom_options_mod_gml_region_destroy(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).children, (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).child_count - 1)));
;
fr_custom_options_mod_gml_region_add_child(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p), fr_custom_options_mod_gml_Page_create(_frl_p, false));
;
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).children, (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p).child_count - 1))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_custom_options_mod_gml_option_set_selected(_frl__selectedIndex, true);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
}
}
}

// Original custom_options.mod.gml:918
function fr_custom_options_mod_gml_step() {
if ((! scrFRInstanceExists(global.fr_module_vars[$ "mod:custom_options"].drawing_controller))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_custom_options_mod_gml_draw_regions, (- 10000))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRVariableSet(real(id), frMacro_custom_options_mod_gml_CONTROLLER, true);
;
persistent = true;
;
name = "RegionDraw";
;
global.fr_module_vars[$ "mod:custom_options"].drawing_controller = real(id);
;
}
}
if(__fr_break3) break;
}}
}
}
frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu = undefined;
;
frMacro_custom_options_mod_gml_MENU.v100_why_does_draw_pause_run_in_boss_intros = false;
;
var _frl__uids = [];
;
var _frl_p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl_p += 1;
;
if (scrFRPlayerIsActive(_frl_p)) {
{
var _frl__uid = scrFRPlayerUID(_frl_p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if (((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p) == undefined) && scrFRInstanceExists(Menu))) {
{
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p) == undefined)) {
{
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "opener", [_frl_p], fr_custom_options_mod_gml_Opener_create(_frl_p), "=");
;
}
}
}
} else {
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p) != undefined)) {
{
fr_custom_options_mod_gml_region_destroy(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "opener", [_frl_p], undefined, "=");
;
}
}
}
}
}
}
}
}
fr_custom_options_mod_gml_populate_page();
;
fr_custom_options_mod_gml_step_regions();
;
}

// Original custom_options.mod.gml:959
function fr_custom_options_mod_gml_option_opener_relocate(_frl__x=undefined, _frl__y=undefined) {
if ((is_real(_frl__x) && is_real(_frl__y))) {
{
frMacro_custom_options_mod_gml_MENU.opener_pos.x = _frl__x;
;
frMacro_custom_options_mod_gml_MENU.opener_pos.y = _frl__y;
;
var _frl__uids = [];
;
var _frl_p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl_p += 1;
;
if (scrFRPlayerIsActive(_frl_p)) {
{
var _frl__uid = scrFRPlayerUID(_frl_p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if (((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p) != undefined) && scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p)))) {
{
fr_custom_options_mod_gml_region_relocate(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl_p), (((frMacro_custom_options_mod_gml_MENU.opener_pos.x % view_width) + view_width) % view_width), (((frMacro_custom_options_mod_gml_MENU.opener_pos.y % view_height) + view_height) % view_height));
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

// Original custom_options.mod.gml:989
function fr_custom_options_mod_gml_Opener_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, (((frMacro_custom_options_mod_gml_MENU.opener_pos.x % view_width) + view_width) % view_width), (((frMacro_custom_options_mod_gml_MENU.opener_pos.y % view_height) + view_height) % view_height), 16, 16, c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_custom_options_mod_gml_region_register(scrFRSelf(self));
;
on_input = fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_Opener_open]);
;
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_Opener_draw];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:1009
function fr_custom_options_mod_gml_Opener_open() {
if (fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self))) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
var _frl__uids = [];
;
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
if (scrFRPlayerIsActive(_frl__p)) {
{
var _frl__uid = scrFRPlayerUID(_frl__p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
var _frl__region = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl__p);
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "opener", [_frl__p], undefined, "=");
;
fr_custom_options_mod_gml_OptionsMenu_create(_frl__p, false);
;
fr_custom_options_mod_gml_region_destroy(_frl__region);
;
}
}
}
}
}
}
}
}

// Original custom_options.mod.gml:1039
function fr_custom_options_mod_gml_Opener_draw() {
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:custom_options"].options_icon, 0, 8, 8, 1, 1, 0, (fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self)) ? c_white : c_silver), 1);
;
}

// Original custom_options.mod.gml:1052
function fr_custom_options_mod_gml_populate_page() {
var _frl__uids = [];
;
var _frl_p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl_p += 1;
;
if (scrFRPlayerIsActive(_frl_p)) {
{
var _frl__uid = scrFRPlayerUID(_frl_p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if (((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p) == undefined) || (array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, _frl_p)) <= 0))) {
{
continue;
;
}
}
var _frl__optionCount = min(floor(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_anim, _frl_p)), array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, _frl_p)));
;
var _frl_i = (- 1);
;
if ((_frl__optionCount > 0)) {
{
repeat (_frl__optionCount) {
_frl_i += 1;
;
var _frl__option = scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, _frl_p), _frl_i);
;
if ((_frl__option == undefined)) {
{
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_population", [_frl_p], [], "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_unpositioned", [_frl_p], [], "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_anim", [_frl_p], 0, "=");
;
break;
;
}
} else {
{
if ((! scrFRInstanceExists(_frl__option.region))) {
{
var _frl__new = scrFRArraySlice(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, _frl_p), 0, _frl_i);
;
array_copy(_frl__new, _frl_i, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, _frl_p), (_frl_i + 1), (_frl__optionCount - (_frl_i + 1)));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_population", [_frl_p], _frl__new, "=");
;
var _frl__unpositionedIndex = scrFRArrayFindIndex(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl_p), _frl__option.region);
;
_frl__new = scrFRArraySlice(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl_p), 0, _frl__unpositionedIndex);
;
array_copy(_frl__new, _frl__unpositionedIndex, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl_p), (_frl__unpositionedIndex + 1), (array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl_p)) - (_frl__unpositionedIndex + 1)));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_unpositioned", [_frl_p], _frl__new, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_anim", [_frl_p], 0, "=");
;
break;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__option.region.parent), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_custom_options_mod_gml_option_set_selected((child_count - 1), true);
;
}
}
if(__fr_break3) break;
}}
if ((_frl_i >= scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_anim, _frl_p))) {
{
_frl__option.region.name_alpha = 0;
;
_frl__option.region.alpha = 0;
;
_frl__option.region.bg_alpha = 0;
;
}
} else {
{
_frl__option.region.name_alpha = _frl__option.name_alpha;
;
_frl__option.region.alpha = _frl__option.alpha;
;
_frl__option.region.bg_alpha = _frl__option.bg_alpha;
;
if ((scrFRPlayerFindLocal() == _frl_p)) {
{
scrFRSoundPlay(sndAppear);
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
fr_custom_options_mod_gml_position_unpositioned_options(_frl_p);
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_anim", [_frl_p], (30 / room_speed), "+=");
;
}
}
}
}
}
}

// Original custom_options.mod.gml:1140
function fr_custom_options_mod_gml_position_unpositioned_options(_frl__p=undefined) {
var _frl__lineHeight = fr_custom_options_mod_gml_string_height_fixed("A");
;
var _frl__optionYOffset = 0;
;
var _frl__unpositionedCount = min(floor(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_anim, _frl__p)), array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl__p)));
;
var _frl_i = (- 1);
;
if ((_frl__unpositionedCount > 0)) {
{
repeat (_frl__unpositionedCount) {
_frl_i += 1;
;
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl__p), _frl_i)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__corners = fr_custom_options_mod_gml_region_corners_rotated(scrFRSelf(self));
;
if (((option_kind == "title") || (option_kind == "button"))) {
{
anchored_x = round((view_width / 2));
;
}
} else {
{
anchored_x = round((view_width * 0.8));
;
}
}
anchored_y = _frl__optionYOffset;
;
draw_set_font(name_font);
;
_frl__optionYOffset += max(fr_custom_options_mod_gml_string_height_fixed(name));
;
_frl__optionYOffset += (((pixels + (lines * fr_custom_options_mod_gml_string_height_fixed("A"))) - (fr_custom_options_mod_gml_string_height_fixed(name) / 2)) + 10);
;
}
}
if(__fr_break3) break;
}}
}
}
}
_frl__unpositionedCount = array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl__p));
;
_frl_i = (- 1);
;
if ((_frl__unpositionedCount > 0)) {
{
repeat (_frl__unpositionedCount) {
_frl_i += 1;
;
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, _frl__p), _frl_i)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
draw_set_font(name_font);
;
anchored_y = round(((anchored_y - (_frl__optionYOffset / 2)) + (view_height / 2)));
;
name_y = anchored_y;
;
name_x = (((option_kind == "title") || (option_kind == "button")) ? (anchored_x - (fr_custom_options_mod_gml_string_width_fixed(name) / 2)) : round((anchored_x - (view_width * 0.7))));
;
name_x += (fr_custom_options_mod_gml_string_width_fixed(name) / 2);
;
desc_x = (view_width / 2);
;
desc_y = (name_y - fr_custom_options_mod_gml_string_height_fixed(name));
;
}
}
if(__fr_break6) break;
}}
}
}
}
draw_set_font(fntM1);
;
}

// Original custom_options.mod.gml:1208
function fr_custom_options_mod_gml_step_regions() {
var _frl_i = (- 1);
;
repeat (ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions)) {
_frl_i += 1;
;
if ((_frl_i >= ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions))) {
{
break;
;
}
}
var _frl__region = global.fr_module_vars[$ "mod:custom_options"].regions[|_frl_i];
;
fr_custom_options_mod_gml_script_ref_call_wc(_frl__region.on_input_internal, _frl__region, _frl__region);
;
if ((! scrFRInstanceExists(_frl__region))) {
{
_frl_i -= 1;
;
continue;
;
}
}
fr_custom_options_mod_gml_script_ref_call_wc(_frl__region.on_step_internal, _frl__region, _frl__region);
;
}
}

// Original custom_options.mod.gml:1230
function fr_custom_options_mod_gml_draw_regions() {
var _frl_p = scrFRPlayerFindLocal();
;
if (scrFRPlayerIsActive(_frl_p)) {
{
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p) != undefined)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "name_x"))) {
{
continue;
;
}
}
scrFRDrawSpriteExt(sprMainMenuSplat, name_splat_anim, (scrFRViewCoordinate(0) + name_x), (scrFRViewCoordinate(1) + name_y), name_xscale, name_yscale, name_angle, name_blend, name_alpha);
;
name_splat_anim += (30 / room_speed);
;
name_splat_anim = clamp(name_splat_anim, 0, (sprite_get_number(sprMainMenuSplat) - 1));
;
}
}
if(__fr_break3) break;
}}
}
}
var _frl__optionsMenu = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p);
;
if (((_frl__optionsMenu != undefined) && frMacro_custom_options_mod_gml_MENU.open)) {
{
var _frl__pageCount = _frl__optionsMenu.child_count;
;
var _frl_i = (- 1);
;
if ((_frl__pageCount > 0)) {
{
repeat (_frl__pageCount) {
_frl_i += 1;
;
var _frl__page = scrFRIndexGet(_frl__optionsMenu.children, _frl_i);
;
var _frl__optionCount = _frl__page.child_count;
;
var _frl_j = (- 1);
;
if ((_frl__optionCount > 0)) {
{
repeat (_frl__optionCount) {
_frl_j += 1;
;
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(_frl__page.children, _frl_j)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "splat_spr"))) {
{
continue;
;
}
}
fr_custom_options_mod_gml_draw_sprite_part_centered_ext(splat_spr, splat_img, 0, 0, sprite_get_width(splat_spr), sprite_get_height(splat_spr), (scrFRViewCoordinate(0) + anchored_x), (scrFRViewCoordinate(1) + anchored_y), xscale, yscale, angle, c_black, alpha);
;
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
}
}
}
var _frl_i = (- 1);
;
repeat (ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions)) {
_frl_i += 1;
;
if ((_frl_i >= ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions))) {
{
break;
;
}
}
var _frl__region = global.fr_module_vars[$ "mod:custom_options"].regions[|_frl_i];
;
fr_custom_options_mod_gml_script_ref_call_wc(_frl__region.on_draw_internal, _frl__region, _frl__region);
;
if ((! scrFRInstanceExists(_frl__region))) {
{
_frl_i -= 1;
;
continue;
;
}
}
}
if (((scrFRPlayerIsActive(_frl_p) && (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p) != undefined)) && scrFRVariableExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p), "desc"))) {
{
{ var __fr_with7 = scrFRWithValues(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.selected, _frl_p)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((desc != undefined)) {
{
scrFRDrawTooltip((scrFRViewCoordinate(0) + desc_x), (scrFRViewCoordinate(1) + desc_y), desc);
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
}

// Original custom_options.mod.gml:1335
function fr_custom_options_mod_gml_draw_pause() {
if (scrFRInstanceExists(PauseButton)) {
{
if ((! frMacro_custom_options_mod_gml_MENU.v100_why_does_draw_pause_run_in_boss_intros)) {
{
frMacro_custom_options_mod_gml_MENU.v100_why_does_draw_pause_run_in_boss_intros = true;
;
}
}
}
}
if ((((! scrFRInstanceExists(PauseButton)) && frMacro_custom_options_mod_gml_MENU.v100_why_does_draw_pause_run_in_boss_intros) && (((1 != 0) && ((frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu == undefined) || (frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu == UberCont.menu))) || scrFRInstanceExists(OptionMenuButton)))) {
{
var _frl__uids = [];
;
var _frl_p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl_p += 1;
;
if (scrFRPlayerIsActive(_frl_p)) {
{
var _frl__uid = scrFRPlayerUID(_frl_p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if (((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p) == undefined) || (! scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl_p))))) {
{
fr_custom_options_mod_gml_OptionsMenu_create(_frl_p, true);
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
fr_custom_options_mod_gml_step_regions();
;
fr_custom_options_mod_gml_populate_page();
;
fr_custom_options_mod_gml_draw_regions();
;
}

// Original custom_options.mod.gml:1373
function fr_custom_options_mod_gml_OptionsMenu_create(_frl__p=undefined, _frl__paused=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, (view_width / 2), (view_height / 2), view_width, view_height, c_black, (_frl__paused ? 0 : 0.75), true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(fr_custom_options_mod_gml_ModSelector_create(_frl__p, _frl__paused)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other7, scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
paused = _frl__paused;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "region", [_frl__p], scrFRSelf(self), "=");
;
fr_custom_options_mod_gml_region_register(scrFRSelf(self));
;
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl__p) != undefined)) {
{
fr_custom_options_mod_gml_region_destroy(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.opener, _frl__p));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "opener", [_frl__p], undefined, "=");
;
}
}
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_OptionsMenu_step];
;
if ((1 != 0)) {
{
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_OptionsMenu_draw];
;
}
}
on_destroy = ["mod", "custom_options", fr_custom_options_mod_gml_OptionsMenu_destroy];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:1400
function fr_custom_options_mod_gml_OptionsMenu_step() {
if ((scrFRInstanceExists(Menu) && scrFRInstanceExists(Loadout))) {
{
{ var __fr_with1 = scrFRWithValues(Menu), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mode = 0;
;
charsplat = 1;
;
var _frl__charxCount = array_length(charx);
;
var _frl_i = (- 1);
;
if ((_frl__charxCount > 0)) {
{
repeat (_frl__charxCount) {
_frl_i += 1;
;
scrFRMemberIndexWrite(scrFRSelf(self), "charx", [_frl_i], 0, "=");
;
}
}
}
scrFRSoundVolume(sndMenuCharSelect, 0);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Loadout), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(loadbutton), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(FR_OBJECT_MENU_BUTTON), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(BackFromCharSelect), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
noinput = 10;
;
}
}
if(__fr_break15) break;
}}
}
}
var _frl__mousePos = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
if ((((((! scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.keys_region, p))) && (scrFRButtonPressed(p, "spec") || ((scrFRButtonPressed(p, "fire") && (_frl__mousePos.x <= 28)) && (_frl__mousePos.y <= 28)))) || ((! paused) && (! scrFRInstanceExists(Menu)))) || (paused && scrFRInstanceExists(PauseButton))) || ((paused && (! frMacro_custom_options_mod_gml_MENU.open)) && (((1 == 0) && (! scrFRInstanceExists(OptionMenuButton))) || (((1 != 0) && (frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu != undefined)) && (UberCont.menu != frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu)))))) {
{
if (scrFRInstanceExists(Menu)) {
{
{ var __fr_with16 = scrFRWithValues(Menu), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
mode = 0;
;
event_perform(ev_step, ev_step_end);
;
scrFRSoundVolume(sndMenuCharSelect, 1);
;
scrFRSoundStop(sndMenuCharSelect);
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(CharSelect), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRAlarmWrite(scrFRSelf(self), 0, 2);
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(Loadout), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
selected = 0;
;
}
}
if(__fr_break24) break;
}}
}
}
fr_custom_options_mod_gml_region_destroy(scrFRSelf(self));
;
}
}
}

// Original custom_options.mod.gml:1470
function fr_custom_options_mod_gml_OptionsMenu_draw() {
if (((((scrFRMouseLocal(0) >= scrFRViewCoordinate(0)) && (scrFRMouseLocal(0) < (scrFRViewCoordinate(0) + 28))) && (scrFRMouseLocal(1) >= scrFRViewCoordinate(1))) && (scrFRMouseLocal(1) < (scrFRViewCoordinate(1) + 28)))) {
{
scrFRDrawSpriteExt(sprBackButton, (scrFRSourceFrame() * 0.4), (scrFRViewCoordinate(0) + 16), (scrFRViewCoordinate(1) + 16), 1, 1, 0, c_white, 1);
;
}
} else {
{
scrFRDrawSpriteExt(sprBackButton, 0, (scrFRViewCoordinate(0) + 16), (scrFRViewCoordinate(1) + 16), 1, 1, 0, c_white, 1);
;
}
}
}

// Original custom_options.mod.gml:1501
function fr_custom_options_mod_gml_OptionsMenu_destroy() {
if (frMacro_custom_options_mod_gml_MENU.open) {
{
fr_custom_options_mod_gml_save_options();
;
}
}
frMacro_custom_options_mod_gml_MENU.open = false;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "region", [p], undefined, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "opener", [p], undefined, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "selected", [p], undefined, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "text_region", [p], noone, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "keys_region", [p], noone, "=");
;
var _frl__uids = [];
;
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
if (scrFRPlayerIsActive(_frl__p)) {
{
var _frl__uid = scrFRPlayerUID(_frl__p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p) != undefined)) {
{
fr_custom_options_mod_gml_region_destroy(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p));
;
}
}
}
}
}
}
}
}

// Original custom_options.mod.gml:1535
function fr_custom_options_mod_gml_save_options() {
if (scrFRScriptExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "CustomOptions_save")) {
{
scrFRModCall(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "CustomOptions_save");
;
}
} else {
if (scrFRScriptExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "save_options")) {
{
scrFRModCall(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "save_options");
;
}
}
}
}

// Original custom_options.mod.gml:1542
function fr_custom_options_mod_gml_ModSelector_create(_frl__p=undefined, _frl__paused=undefined) {
draw_set_font(fntBig);
;
if (((1 != 0) && _frl__paused)) {
{
frMacro_custom_options_mod_gml_MENU.v100_UberCont_menu = UberCont.menu;
;
}
}
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, (view_width / 2), ((view_height / 2) - (_frl__paused ? (48 + (ceil((fr_custom_options_mod_gml_string_height_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) * 0.65)) / 2)) : 0)), (fr_custom_options_mod_gml_string_width_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) + 80), (fr_custom_options_mod_gml_string_height_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) + 4), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
xscale = 0.65;
;
yscale = 0.65;
;
angle = 0;
;
side = fa_center;
;
selected = false;
;
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_ModSelector_step];
;
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_ModSelector_draw];
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(_frl__p, "pick", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_select_mod]), fr_custom_options_mod_gml_input_event_create(_frl__p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_select_mod_from_click]));
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(on_input, fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(_frl__p, "east", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_change_mod, 1]), fr_custom_options_mod_gml_input_event_create(_frl__p, "west", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_change_mod, (- 1)])));
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(_frl__p, "swap", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_ModSelector_select]), on_input);
;
draw_set_font(fntM1);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:1592
function fr_custom_options_mod_gml_ModSelector_step() {
if (((! selected) && fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self)))) {
{
selected = true;
;
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndHover);
;
}
}
}
} else {
if (((selected && ((scrFRMouseDelta(0, p) != 0) || (scrFRMouseDelta(1, p) != 0))) && (! fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self))))) {
{
selected = false;
;
}
}
}
}

// Original custom_options.mod.gml:1606
function fr_custom_options_mod_gml_ModSelector_select() {
selected = (! selected);
;
}

// Original custom_options.mod.gml:1609
function fr_custom_options_mod_gml_ModSelector_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_top);
;
draw_set_font(fntBig);
;
if ((frMacro_custom_options_mod_gml_MENU.mod_index > 0)) {
{
scrFRDrawSpriteExt(sprDailyArrow, 0, 20, ((fr_custom_options_mod_gml_string_height_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) / 2) - (selected && (side == fa_right))), 1, 1, 0, ((selected && (side == fa_left)) ? c_white : c_silver), 1);
;
}
}
if ((frMacro_custom_options_mod_gml_MENU.mod_index < (frMacro_custom_options_mod_gml_MENU.mod_count - 1))) {
{
scrFRDrawSpriteExt(sprDailyArrow, 1, (60 + fr_custom_options_mod_gml_string_width_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name)), ((fr_custom_options_mod_gml_string_height_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) / 2) - (selected && (side == fa_right))), 1, 1, 0, ((selected && (side == fa_right)) ? c_white : c_silver), 1);
;
}
}
scrFRDrawText(((fr_custom_options_mod_gml_string_width_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) / 2) + 40), (- selected), ("@(color:" + string(((selected && (side == fa_center)) ? c_white : c_silver)) + ")" + string(fr_custom_options_mod_gml_string_hash_to_newline(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name)) + ""));
;
draw_set_font(fntM1);
;
draw_set_valign(_frl__valign);
;
draw_set_halign(_frl__halign);
;
}

// Original custom_options.mod.gml:1657
function fr_custom_options_mod_gml_select_mod() {
if ((! selected)) {
{
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(OptionMenuButton), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPlay(sndMenuOptions);
;
var _frl__uids = [];
;
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
if (scrFRPlayerIsActive(_frl__p)) {
{
var _frl__uid = scrFRPlayerUID(_frl__p);
;
if ((scrFRArrayFindIndex(_frl__uids, _frl__uid) < 0)) {
{
array_push(_frl__uids, _frl__uid);
;
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p) != undefined)) {
{
fr_custom_options_mod_gml_region_add_child(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p), fr_custom_options_mod_gml_Page_create(_frl__p));
;
fr_custom_options_mod_gml_region_destroy(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p).children, 0));
;
}
}
}
}
}
}
}
frMacro_custom_options_mod_gml_MENU.open = true;
;
if (scrFRScriptExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "CustomOptions_open")) {
{
scrFRModCall(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.kind, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).mod_data.name, "CustomOptions_open");
;
}
}
}

// Original custom_options.mod.gml:1695
function fr_custom_options_mod_gml_select_mod_from_click() {
if (fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self))) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
if ((_frl__inRegion.x <= 40)) {
{
fr_custom_options_mod_gml_change_mod((- 1));
;
}
} else {
if ((_frl__inRegion.x >= (abs((x2 - x1)) - 40))) {
{
fr_custom_options_mod_gml_change_mod(1);
;
}
} else {
{
fr_custom_options_mod_gml_select_mod();
;
}
}
}
}
}
}

// Original custom_options.mod.gml:1708
function fr_custom_options_mod_gml_change_mod(_frl__delta=undefined) {
_frl__delta = clamp(_frl__delta, ((frMacro_custom_options_mod_gml_MENU.mod_index > 0) * (- 1)), (frMacro_custom_options_mod_gml_MENU.mod_index < (array_length(frMacro_custom_options_mod_gml_MENU.mods) - 1)));
;
if (((_frl__delta != 0) && (sign((side - 1)) == sign(_frl__delta)))) {
{
frMacro_custom_options_mod_gml_MENU.mod_index = fr_custom_options_mod_gml_wrap_range((frMacro_custom_options_mod_gml_MENU.mod_index + _frl__delta), 0, frMacro_custom_options_mod_gml_MENU.mod_count);
;
scrFRSoundPitchVolume(sndMenuLoadout, ((frMacro_custom_options_mod_gml_MENU.mod_index + 1) / array_length(frMacro_custom_options_mod_gml_MENU.mods)), 1);
;
draw_set_font(fntBig);
;
fr_custom_options_mod_gml_region_resize(scrFRSelf(self), (fr_custom_options_mod_gml_string_width_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name) + 80), fr_custom_options_mod_gml_string_height_fixed(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).name));
;
draw_set_font(fntM1);
;
}
}
side = clamp((side + _frl__delta), 0, 2);
;
}

// Original custom_options.mod.gml:1729
function fr_custom_options_mod_gml_Page_create() {
var _frl__p = (argument_count>0 ? argument[0] : undefined);
;
var _frl__animate = ((argument_count > 1) ? (argument_count>1 ? argument[1] : undefined) : true);
;
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index);
;
var _frl__page = scrFRIndexGet(_frl__mod.pages, scrFRIndexGet(_frl__mod.page_index, _frl__p));
;
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, (view_width / 2), (view_height / 2), view_width, view_height, c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
selected_index = (- 1);
;
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_Page_step];
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "nort", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_change_option, (- 1)]), fr_custom_options_mod_gml_input_event_create(p, "sout", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_change_option, 1]));
;
if ((_frl__page.page_data.kind == "script")) {
{
{ var __fr_with4 = scrFRWithValues(fr_custom_options_mod_gml_region_create(p, (view_width / 2), (view_height / 2), view_width, view_height, c_black, 0, true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other7, scrFRSelf(self));
;
draw_synced = true;
;
on_draw = scrFRArrayClone(_frl__page.reference);
;
array_push(on_draw, p);
;
}
}
if(__fr_break6) break;
}}
}
} else {
if ((_frl__page.page_data.kind == "options")) {
{
var _frl__unpositionedOptions = [];
;
var _frl__optionCount = array_length(_frl__page.options);
;
var _frl_i = (- 1);
;
if ((_frl__optionCount > 0)) {
{
repeat (_frl__optionCount) {
_frl_i += 1;
;
var _frl__option = scrFRIndexGet(_frl__page.options, _frl_i);
;
var _frl__optionKind = scrFRLQGet(scrFRLQGet(_frl__option, "option_data", undefined), "kind", scrFRLQGet(_frl__option, "type"));
;
{ var __fr_switch_value8=_frl__optionKind, __fr_switch_case9=-1;
if(__fr_switch_case9==-1 && __fr_switch_value8==("slider")) __fr_switch_case9=0;
if(__fr_switch_case9==-1 && __fr_switch_value8==("choices")) __fr_switch_case9=1;
if(__fr_switch_case9==-1 && __fr_switch_value8==("choice")) __fr_switch_case9=2;
if(__fr_switch_case9==-1 && __fr_switch_value8==("cycle")) __fr_switch_case9=3;
if(__fr_switch_case9==-1 && __fr_switch_value8==("bool")) __fr_switch_case9=4;
if(__fr_switch_case9==-1 && __fr_switch_value8==("int")) __fr_switch_case9=5;
if(__fr_switch_case9==-1 && __fr_switch_value8==("float")) __fr_switch_case9=6;
if(__fr_switch_case9==-1 && __fr_switch_value8==("number")) __fr_switch_case9=7;
if(__fr_switch_case9==-1 && __fr_switch_value8==("range")) __fr_switch_case9=8;
if(__fr_switch_case9==-1 && __fr_switch_value8==("text")) __fr_switch_case9=9;
if(__fr_switch_case9==-1 && __fr_switch_value8==("keys")) __fr_switch_case9=10;
if(__fr_switch_case9==-1 && __fr_switch_value8==("button")) __fr_switch_case9=11;
if(__fr_switch_case9==-1 && __fr_switch_value8==("title")) __fr_switch_case9=12;
if(__fr_switch_case9==-1 && __fr_switch_value8==("region")) __fr_switch_case9=13;
if(__fr_switch_case9==-1) __fr_switch_case9=14;
switch(__fr_switch_case9) {
case 0:
{
{ var __fr_with10 = scrFRWithValues(fr_custom_options_mod_gml_Slider_create(p)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other13, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
range = {"minimum": scrFRLQGet(scrFRLQGet(_frl__option, "range", undefined), "minimum", 0), "maximum": scrFRLQGet(scrFRLQGet(_frl__option, "range", undefined), "maximum", 1)};
;
steps = scrFRLQGet(_frl__option, "steps", 0.001);
;
button_steps = scrFRLQGet(_frl__option, "button_steps", 0.1);
;
format = {"total": scrFRLQGet(scrFRLQGet(_frl__option, "format", undefined), "total", 3), "dec": scrFRLQGet(scrFRLQGet(_frl__option, "format", undefined), "dec", 1), "display_multiplier": scrFRLQGet(scrFRLQGet(_frl__option, "format", undefined), "display_multiplier", 100)};
;
color = {"minimum": scrFRLQGet(scrFRLQGet(_frl__option, "color", undefined), "minimum", c_lime), "maximum": scrFRLQGet(scrFRLQGet(_frl__option, "color", undefined), "maximum", c_lime)};
;
}
}
if(__fr_break12) break;
}}
break;
;
}
case 1:

case 2:

case 3:
{
{ var __fr_with14 = scrFRWithValues(fr_custom_options_mod_gml_Cycle_create(p)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var __fr_other17=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other17, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
values = scrFRLQGet(_frl__option, "values", ["this", "is", "a", "cycle"]);
;
display = scrFRLQGet(_frl__option, "display", scrFRArrayClone(values));
;
index = max(0, scrFRArrayFindIndex(values, value));
;
}
}
if(__fr_break16) break;
}}
break;
;
}
case 4:
{
{ var __fr_with18 = scrFRWithValues(fr_custom_options_mod_gml_Bool_create(p)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
var __fr_other21=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other21, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
index = max(0, scrFRArrayFindIndex(values, value));
;
}
}
if(__fr_break20) break;
}}
break;
;
}
case 5:

case 6:

case 7:

case 8:
{
{ var __fr_with22 = scrFRWithValues(fr_custom_options_mod_gml_Int_create(p)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
var __fr_other25=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other25, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
steps = scrFRLQGet(_frl__option, "steps", 1);
;
range = {"minimum": scrFRLQGet(scrFRLQGet(_frl__option, "range", undefined), "minimum", (- 5)), "maximum": scrFRLQGet(scrFRLQGet(_frl__option, "range", undefined), "maximum", 5)};
;
wrap = scrFRLQGet(_frl__option, "wrap", true);
;
}
}
if(__fr_break24) break;
}}
break;
;
}
case 9:
{
{ var __fr_with26 = scrFRWithValues(fr_custom_options_mod_gml_Text_create(p)), __fr_break28=false;
for (var __fr_index27=0; __fr_index27<array_length(__fr_with26); ++__fr_index27) {
if(scrFRScopeExists(__fr_with26[__fr_index27])) with (__fr_with26[__fr_index27]) {
{
var __fr_other29=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other29, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
}
}
if(__fr_break28) break;
}}
break;
;
}
case 10:
{
{ var __fr_with30 = scrFRWithValues(fr_custom_options_mod_gml_Keys_create(p)), __fr_break32=false;
for (var __fr_index31=0; __fr_index31<array_length(__fr_with30); ++__fr_index31) {
if(scrFRScopeExists(__fr_with30[__fr_index31])) with (__fr_with30[__fr_index31]) {
{
var __fr_other33=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other33, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
style = scrFRLQGet(_frl__option, "style", "text");
;
if (((style != "text") && (style != "buttons"))) {
{
style = "text";
;
}
}
var _frl__keys = string_split(value, "+");
;
var _frl__keyCount = array_length(_frl__keys);
;
if ((_frl__keyCount > 0)) {
{
var _frl_k = (- 1);
;
repeat (_frl__keyCount) {
_frl_k += 1;
;
if ((scrFRIndexGet(_frl__keys, _frl_k) != "")) {
{
ds_map_set(keys, scrFRIndexGet(_frl__keys, _frl_k), true);
;
}
}
}
}
}
}
}
if(__fr_break32) break;
}}
break;
;
}
case 11:

case 12:
{
{ var __fr_with34 = scrFRWithValues(fr_custom_options_mod_gml_Title_create(p)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
var __fr_other37=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other37, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
}
}
if(__fr_break36) break;
}}
break;
;
}
case 13:
{
{ var __fr_with38 = scrFRWithValues(fr_custom_options_mod_gml_Custom_create(p)), __fr_break40=false;
for (var __fr_index39=0; __fr_index39<array_length(__fr_with38); ++__fr_index39) {
if(scrFRScopeExists(__fr_with38[__fr_index39])) with (__fr_with38[__fr_index39]) {
{
var __fr_other41=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other41, scrFRSelf(self));
;
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, _frl__option, _frl__animate);
;
if (scrFRLQHas(_frl__option, "on_input")) {
{
var _frl__field = scrFRLQGet(_frl__option, "on_input");
;
if (((((is_array(_frl__field) && (array_length(_frl__field) >= 3)) && is_string(scrFRIndexGet(_frl__field, 0))) && is_string(scrFRIndexGet(_frl__field, 1))) && is_string(scrFRIndexGet(_frl__field, 2)))) {
{
on_input = _frl__field;
;
}
}
}
}
if (scrFRLQHas(_frl__option, "on_step")) {
{
var _frl__field = scrFRLQGet(_frl__option, "on_step");
;
if (((((is_array(_frl__field) && (array_length(_frl__field) >= 3)) && is_string(scrFRIndexGet(_frl__field, 0))) && is_string(scrFRIndexGet(_frl__field, 1))) && is_string(scrFRIndexGet(_frl__field, 2)))) {
{
on_step = _frl__field;
;
}
}
}
}
if (scrFRLQHas(_frl__option, "on_draw")) {
{
var _frl__field = scrFRLQGet(_frl__option, "on_draw");
;
if (((((is_array(_frl__field) && (array_length(_frl__field) >= 3)) && is_string(scrFRIndexGet(_frl__field, 0))) && is_string(scrFRIndexGet(_frl__field, 1))) && is_string(scrFRIndexGet(_frl__field, 2)))) {
{
on_draw = _frl__field;
;
}
}
}
}
}
}
if(__fr_break40) break;
}}
break;
;
}
case 14:
scrFRTraceColor(("Found unknown option kind \"" + string(_frl__optionKind) + "\" on " + string(_frl__mod.mod_data.name) + "." + string(_frl__mod.mod_data.kind) + "'s page \"" + string(_frl__page.name) + "\""), c_orange);
;
break;
;
}
}
}
}
}
}
}
}
fr_custom_options_mod_gml_page_add_option(_frl__mod, _frl__page, undefined, _frl__animate);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:1965
function fr_custom_options_mod_gml_page_add_option() {
var _frl__mod = (argument_count>0 ? argument[0] : undefined);
;
var _frl__page = (argument_count>1 ? argument[1] : undefined);
;
var _frl__option = (argument_count>2 ? argument[2] : undefined);
;
var _frl__animate = ((argument_count > 3) ? (argument_count>3 ? argument[3] : undefined) : true);
;
if ((_frl__option == undefined)) {
{
draw_set_font(fntBig);
;
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_PageNavigator_create(p, round((view_width / 2)), round((view_height - (fr_custom_options_mod_gml_string_height_fixed(_frl__page.name) / 2))), _frl__page.name, ("Page " + string((scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) + 1)) + " of " + string(array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).pages)) + ""))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
fr_custom_options_mod_gml_region_add_child(__fr_other4, scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
draw_set_font(fntM1);
;
array_push(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, p), undefined);
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_anim", [p], (_frl__animate ? 0 : array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, p))), "=");
;
}
} else {
{
fr_custom_options_mod_gml_option_set_shared(_frl__mod, _frl__page, _frl__option, scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_unpositioned, p), _frl__animate);
;
array_push(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.page_population, p), {"region": scrFRSelf(self), "name_alpha": name_alpha, "alpha": alpha, "bg_alpha": bg_alpha});
;
name_alpha = 0;
;
alpha = 0;
;
bg_alpha = 0;
;
}
}
}

// Original custom_options.mod.gml:1996
function fr_custom_options_mod_gml_Page_step() {
if ((scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.text_region, p)) || scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.keys_region, p)))) {
{
exit;
;
}
}
var _frl__vx = scrFRViewCoordinate(0, p);
;
var _frl__vy = scrFRViewCoordinate(1, p);
;
var _frl_i = (- 1);
;
if (((child_count > 0) && ((scrFRMouseDelta(0, p) != 0) || (scrFRMouseDelta(1, p) != 0)))) {
{
var _frl__selectedIndex = selected_index;
;
var _frl__selected = false;
;
repeat (child_count) {
_frl_i += 1;
;
if ((!scrFRVariableExists(scrFRIndexGet(children, _frl_i), "on_select"))) {
{
continue;
;
}
}
var _frl__triangles = [];
;
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(children, _frl_i)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__corners = fr_custom_options_mod_gml_region_corners_rotated(scrFRSelf(self));
;
if (fr_custom_options_mod_gml_point_in_rotated_rectangle_bbox(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), _frl__corners.x1, _frl__corners.y1, _frl__corners.x2, _frl__corners.y2, _frl__corners.x3, _frl__corners.y3, _frl__corners.x4, _frl__corners.y4)) {
{
_frl__triangles = [{"x1": _frl__corners.x1, "y1": _frl__corners.y1, "x2": _frl__corners.x2, "y2": _frl__corners.y2, "x3": _frl__corners.x3, "y3": _frl__corners.y3}, {"x1": _frl__corners.x2, "y1": _frl__corners.y2, "x2": _frl__corners.x4, "y2": _frl__corners.y4, "x3": _frl__corners.x3, "y3": _frl__corners.y3}];
;
}
}
if (scrFRVariableExists(scrFRSelf(self), "option_positioned")) {
{
var _frl__x1 = (((_frl__vx + name_x) - length_xx) - length_yx);
;
var _frl__y1 = (((_frl__vy + name_y) - length_xy) - length_yy);
;
var _frl__x2 = (((_frl__vx + name_x) + length_xx) - length_yx);
;
var _frl__y2 = (((_frl__vy + name_y) + length_xy) - length_yy);
;
var _frl__x3 = (((_frl__vx + name_x) - length_xx) + length_yx);
;
var _frl__y3 = (((_frl__vy + name_y) - length_xy) + length_yy);
;
var _frl__x4 = (((_frl__vx + name_x) + length_xx) + length_yx);
;
var _frl__y4 = (((_frl__vy + name_y) + length_xy) + length_yy);
;
if (fr_custom_options_mod_gml_point_in_rotated_rectangle_bbox(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), _frl__x1, _frl__y1, _frl__x2, _frl__y2, _frl__x3, _frl__y3, _frl__x4, _frl__y4)) {
{
array_push(_frl__triangles, {"x1": _frl__x1, "y1": _frl__y1, "x2": _frl__x2, "y2": _frl__y2, "x3": _frl__x3, "y3": _frl__y3});
;
array_push(_frl__triangles, {"x1": _frl__x2, "y1": _frl__y2, "x2": _frl__x4, "y2": _frl__y4, "x3": _frl__x3, "y3": _frl__y3});
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
var _frl__triangleCount = array_length(_frl__triangles);
;
if ((_frl__triangleCount > 0)) {
{
var _frl_j = (- 1);
;
repeat (_frl__triangleCount) {
_frl_j += 1;
;
var _frl__triangle = scrFRIndexGet(_frl__triangles, _frl_j);
;
if (((_frl__triangle != undefined) && point_in_triangle(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), _frl__triangle.x1, _frl__triangle.y1, _frl__triangle.x2, _frl__triangle.y2, _frl__triangle.x3, _frl__triangle.y3))) {
{
if ((selected_index != _frl_i)) {
{
fr_custom_options_mod_gml_option_set_selected(_frl_i, true);
;
}
}
_frl__selected = true;
;
_frl_i = child_count;
;
break;
;
}
}
}
}
}
if ((_frl_i >= child_count)) {
{
break;
;
}
}
}
if (((selected_index == _frl__selectedIndex) && (! _frl__selected))) {
{
fr_custom_options_mod_gml_option_set_selected((- 1), true);
;
}
}
}
}
}

// Original custom_options.mod.gml:2122
function fr_custom_options_mod_gml_PageNavigator_create(_frl__p=undefined, _frl__x=undefined, _frl__y=undefined, _frl__pageDisplayName=undefined, _frl__pageTip=undefined) {
draw_set_font(fntBig);
;
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, _frl__x, _frl__y, (fr_custom_options_mod_gml_string_width_fixed(_frl__pageDisplayName) + 80), fr_custom_options_mod_gml_string_height_fixed(_frl__pageDisplayName), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = _frl__pageDisplayName;
;
desc = _frl__pageTip;
;
desc_x = (view_width / 2);
;
desc_y = (view_height - 32);
;
side = fa_center;
;
selected = false;
;
xscale = 0.65;
;
yscale = 0.65;
;
on_select = undefined;
;
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_PageNavigator_step];
;
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_PageNavigator_draw];
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_select_page_from_click]), fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "west", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_select_page, (- 1)]), fr_custom_options_mod_gml_input_event_create(p, "east", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_select_page, 1])));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2163
function fr_custom_options_mod_gml_select_page(_frl__delta=undefined) {
if (selected) {
{
var _frl__lastSide = side;
;
side = clamp((side + _frl__delta), fa_left, fa_right);
;
if ((_frl__lastSide == side)) {
{
fr_custom_options_mod_gml_change_page(_frl__delta);
;
}
}
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2177
function fr_custom_options_mod_gml_select_page_from_click() {
if (selected) {
{
fr_custom_options_mod_gml_change_page(((side == fa_center) ? 0 : ((side == fa_left) ? (- 1) : ((side == fa_right) ? 1 : 0))));
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2186
function fr_custom_options_mod_gml_change_page(_frl__delta=undefined) {
if ((((_frl__delta == 0) || ((_frl__delta < 0) && (scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) == 0))) || ((_frl__delta > 0) && (scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) >= (array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).pages) - 1))))) {
{
exit;
;
}
}
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPitchVolume(sndMenuLoadout, ((scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) + 1) / array_length(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p))), 1);
;
}
}
scrFRMemberIndexWrite(scrFRIndexGet(global.fr_module_vars[$ "mod:custom_options"].menu.mods, frMacro_custom_options_mod_gml_MENU.mod_index), "page_index", [p], fr_custom_options_mod_gml_wrap_range((scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) + _frl__delta), 0, array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).pages)), "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_population", [p], [], "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "page_unpositioned", [p], [], "=");
;
fr_custom_options_mod_gml_region_add_child(parent.parent, fr_custom_options_mod_gml_Page_create(p));
;
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(parent.parent.children, (parent.parent.child_count - 1))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_custom_options_mod_gml_option_set_selected((child_count - 1), true);
;
}
}
if(__fr_break3) break;
}}
fr_custom_options_mod_gml_region_destroy(parent);
;
exit;
;
}

// Original custom_options.mod.gml:2215
function fr_custom_options_mod_gml_PageNavigator_step() {
if (fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self))) {
{
{ var __fr_with1 = scrFRWithValues(parent), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_custom_options_mod_gml_option_set_selected((child_count - 1), true);
;
}
}
if(__fr_break3) break;
}}
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
if ((_frl__inRegion.x <= 40)) {
{
side = fa_left;
;
}
} else {
if ((_frl__inRegion.x >= (abs((x2 - x1)) - 40))) {
{
side = fa_right;
;
}
} else {
{
side = fa_center;
;
}
}
}
}
}
side = clamp(side, (scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) <= 0), (2 - (scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p) >= (array_length(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).pages) - 1))));
;
}

// Original custom_options.mod.gml:2238
function fr_custom_options_mod_gml_PageNavigator_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_top);
;
draw_set_font(fntBig);
;
var _frl__mod = scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index);
;
var _frl__pageIndex = scrFRIndexGet(_frl__mod.page_index, p);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
if ((_frl__pageIndex > 0)) {
{
scrFRDrawSpriteExt(sprDailyArrow, 0, (((scrFRViewCoordinate(0, p) + (view_width / 2)) - (((abs((x2 - x1)) - 80) * xscale) / 2)) - 20), ((scrFRViewCoordinate(1, p) + view_height) - 16), 1, 1, 0, ((selected && (side == fa_left)) ? c_white : c_silver), 1);
;
}
}
if (((array_length(_frl__mod.pages) - 1) > _frl__pageIndex)) {
{
scrFRDrawSpriteExt(sprDailyArrow, 1, (((scrFRViewCoordinate(0, p) + (view_width / 2)) + (((abs((x2 - x1)) - 80) * xscale) / 2)) + 20), ((scrFRViewCoordinate(1, p) + view_height) - 16), 1, 1, 0, ((selected && (side == fa_right)) ? c_white : c_silver), 1);
;
}
}
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
scrFRDrawText(((fr_custom_options_mod_gml_string_width_fixed(name) / 2) + 40), 0, ("@(color:" + string(((selected && (side == fa_center)) ? c_white : c_silver)) + ")" + string(fr_custom_options_mod_gml_string_hash_to_newline(name)) + ""));
;
draw_set_font(fntM1);
;
draw_set_valign(_frl__valign);
;
draw_set_halign(_frl__halign);
;
}

// Original custom_options.mod.gml:2293
function fr_custom_options_mod_gml_option_set_shared() {
var _frl__mod = (argument_count>0 ? argument[0] : undefined);
;
var _frl__page = (argument_count>1 ? argument[1] : undefined);
;
var _frl__option = (argument_count>2 ? argument[2] : undefined);
;
var _frl__unpositionedOptions = ((argument_count > 3) ? (argument_count>3 ? argument[3] : undefined) : []);
;
var _frl__animate = ((argument_count > 4) ? (argument_count>4 ? argument[4] : undefined) : true);
;
scrFRVariableSet(scrFRSelf(self), frMacro_custom_options_mod_gml_CONTROLLER, true);
;
mod_kind = _frl__mod.mod_data.kind;
;
mod_name = _frl__mod.mod_data.name;
;
page_name = _frl__page.page_data.name;
;
option_kind = _frl__option.option_data.kind;
;
option_name = _frl__option.option_data.name;
;
selected = false;
;
angle = scrFRLQGet(_frl__option, "angle", 0);
;
xscale = scrFRLQGet(scrFRLQGet(_frl__option, "scale", undefined), "x", 1);
;
yscale = scrFRLQGet(scrFRLQGet(_frl__option, "scale", undefined), "y", 1);
;
pixels = scrFRLQGet(_frl__option, "pixels", 0);
;
lines = scrFRLQGet(_frl__option, "lines", 0);
;
if (((scrFRLQGet(scrFRLQGet(_frl__option, "position", undefined), "x", undefined) == undefined) || (scrFRLQGet(scrFRLQGet(_frl__option, "position", undefined), "y", undefined) == undefined))) {
{
array_push(_frl__unpositionedOptions, scrFRSelf(self));
;
option_positioned = false;
;
}
} else {
{
option_positioned = true;
;
}
}
anchored_x = scrFRLQGet(scrFRLQGet(_frl__option, "position", undefined), "x", (abs((parent.x2 - parent.x1)) / 2));
;
anchored_y = scrFRLQGet(scrFRLQGet(_frl__option, "position", undefined), "y", (abs((parent.y2 - parent.y1)) / 2));
;
prefix = scrFRLQGet(_frl__option, "prefix", "");
;
suffix = scrFRLQGet(_frl__option, "suffix", "");
;
display_override = scrFRLQGet(_frl__option, "display_override", undefined);
;
var _frl__onChange = scrFRLQGet(_frl__option, "on_change", undefined);
;
if ((_frl__onChange == undefined)) {
{
_frl__onChange = scrFRLQGet(_frl__option, "reference", undefined);
;
}
}
if (((((is_array(_frl__onChange) && (array_length(_frl__onChange) >= 3)) && is_string(scrFRIndexGet(_frl__onChange, 0))) && is_string(scrFRIndexGet(_frl__onChange, 1))) && is_string(scrFRIndexGet(_frl__onChange, 2)))) {
{
on_change = _frl__onChange;
;
}
} else {
{
on_change = undefined;
;
}
}
var _frl__onSelect = scrFRLQGet(_frl__option, "on_select", undefined);
;
if (((((is_array(_frl__onSelect) && (array_length(_frl__onSelect) >= 3)) && is_string(scrFRIndexGet(_frl__onSelect, 0))) && is_string(scrFRIndexGet(_frl__onSelect, 1))) && is_string(scrFRIndexGet(_frl__onSelect, 2)))) {
{
on_select = _frl__onSelect;
;
}
} else {
{
on_select = undefined;
;
}
}
var _frl__point = scrFRLQGet(_frl__option, "point", undefined);
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__page, "point", undefined);
;
if ((_frl__point == undefined)) {
{
_frl__point = scrFRLQGet(_frl__mod, "point", undefined);
;
}
}
}
}
if (((((is_array(_frl__point) && (array_length(_frl__point) >= 3)) && is_string(scrFRIndexGet(_frl__point, 0))) && is_string(scrFRIndexGet(_frl__point, 1))) && is_string(scrFRIndexGet(_frl__point, 2)))) {
{
point = _frl__point;
;
}
} else {
{
point = undefined;
;
}
}
fake_nonsync = scrFRLQGet(_frl__option, "fake_nonsync", false);
;
if ((! fake_nonsync)) {
{
nonsync = scrFRLQGet(_frl__option, "nonsync", false);
;
if (((! nonsync) || (scrFRPlayerFindLocal() == p))) {
{
var _frl__value = fr_custom_options_mod_gml_option_get(mod_kind, mod_name, page_name, option_name);
;
if ((_frl__value != undefined)) {
{
value = _frl__value;
;
}
}
}
}
}
} else {
{
var _frl__value = fr_custom_options_mod_gml_option_get_fake_nonsync(mod_kind, mod_name, page_name, option_name, p);
;
if ((_frl__value != undefined)) {
{
value = _frl__value;
;
}
}
}
}
var _frl__nameData = scrFRLQGet(_frl__option, "name", undefined);
;
name = scrFRLQGet(_frl__nameData, "text", option_name);
;
name_x = scrFRLQGet(scrFRLQGet(_frl__nameData, "position", undefined), "x", (anchored_x - (view_width * 0.25)));
;
name_y = scrFRLQGet(scrFRLQGet(_frl__nameData, "position", undefined), "y", anchored_y);
;
name_angle = scrFRLQGet(_frl__nameData, "angle", 0);
;
name_xscale = scrFRLQGet(scrFRLQGet(_frl__nameData, "scale", undefined), "x", 1);
;
name_yscale = scrFRLQGet(scrFRLQGet(_frl__nameData, "scale", undefined), "y", 1);
;
name_blend = scrFRLQGet(_frl__nameData, "blend", c_white);
;
name_alpha = scrFRLQGet(_frl__nameData, "alpha", 1);
;
name_font = scrFRLQGet(_frl__nameData, "font", fntM1);
;
name_splat_anim = 0;
;
var _frl__descData = scrFRLQGet(_frl__option, "desc", undefined);
;
desc = scrFRLQGet(_frl__descData, "text", undefined);
;
desc_x = scrFRLQGet(scrFRLQGet(_frl__descData, "position", undefined), "x", name_x);
;
desc_y = scrFRLQGet(scrFRLQGet(_frl__descData, "position", undefined), "y", (name_y - (fr_custom_options_mod_gml_string_height_fixed(name) / 2)));
;
var _frl__splatData = scrFRLQGet(_frl__option, "splat", undefined);
;
if (is_struct(_frl__splatData)) {
{
if (scrFRLQHas(_frl__splatData, "spr")) {
{
splat_spr = scrFRLQGet(_frl__splatData, "spr");
;
}
}
if (scrFRLQHas(_frl__splatData, "img")) {
{
splat_img = scrFRLQGet(_frl__splatData, "img");
;
}
}
}
}
draw_set_font(name_font);
;
length_xx = lengthdir_x(((fr_custom_options_mod_gml_string_width_fixed(name) / 2) * name_xscale), name_angle);
;
length_yx = lengthdir_x(((fr_custom_options_mod_gml_string_height_fixed(name) / 2) * name_yscale), (name_angle - 90));
;
length_xy = lengthdir_y(((fr_custom_options_mod_gml_string_width_fixed(name) / 2) * name_xscale), name_angle);
;
length_yy = lengthdir_y(((fr_custom_options_mod_gml_string_height_fixed(name) / 2) * name_yscale), (name_angle - 90));
;
draw_set_font(fntM1);
;
}

// Original custom_options.mod.gml:2437
function fr_custom_options_mod_gml_option_set_selected(_frl__index=undefined, _frl__value=undefined) {
if ((_frl__value && (selected_index != _frl__index))) {
{
fr_custom_options_mod_gml_option_set_selected(selected_index, false);
;
}
}
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "selected", [p], undefined, "=");
;
if (((_frl__index >= 0) && (_frl__index < child_count))) {
{
var _frl__child = scrFRIndexGet(children, _frl__index);
;
_frl__child.name_splat_anim = 0;
;
if ((_frl__value && ((!scrFRVariableExists(_frl__child, "selected")) || (! _frl__child.selected)))) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndHover);
;
}
}
if ((scrFRVariableExists(_frl__child, "on_select") && (_frl__child.on_select != undefined))) {
{
var _frl__clonedScriptReference = scrFRArrayClone(_frl__child.on_select);
;
array_push(_frl__clonedScriptReference, p);
;
fr_custom_options_mod_gml_script_ref_call_wc(_frl__clonedScriptReference, _frl__child, _frl__child);
;
}
}
}
}
_frl__child.selected = _frl__value;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "selected", [p], _frl__child, "=");
;
selected_index = _frl__index;
;
}
} else {
{
selected_index = (- 1);
;
}
}
}

// Original custom_options.mod.gml:2470
function fr_custom_options_mod_gml_change_option(_frl__delta=undefined) {
if ((scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.text_region, p)) || scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.keys_region, p)))) {
{
exit;
;
}
}
fr_custom_options_mod_gml_option_set_selected(fr_custom_options_mod_gml_wrap_range((selected_index + _frl__delta), (- 1), child_count), true);
;
}

// Original custom_options.mod.gml:2477
function fr_custom_options_mod_gml_Name_draw() {
draw_set_font(scrFRVariableGet(scrFRSelf(self), "name_font", fntM1));
;
if (((((name != undefined) && is_string(name)) && (fr_custom_options_mod_gml_string_width_fixed(name) > 0)) && (fr_custom_options_mod_gml_string_height_fixed(name) > 0))) {
{
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_left);
;
draw_set_valign(fa_top);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
var _frl__surface = surface_create(fr_custom_options_mod_gml_string_width_fixed(name), fr_custom_options_mod_gml_string_height_fixed(name));
;
fr_custom_options_mod_gml_surface_target_push(_frl__surface);
;
draw_clear_alpha(c_black, 0);
;
scrFRDrawText(0, 0, ("@(color:" + string((selected ? c_white : c_silver)) + ")" + string(fr_custom_options_mod_gml_string_hash_to_newline(name)) + ""));
;
fr_custom_options_mod_gml_surface_target_pop();
;
fr_custom_options_mod_gml_draw_surface_centered_ext(_frl__surface, ((scrFRViewCoordinate(0, p) + name_x) + (selected * 2)), ((scrFRViewCoordinate(1, p) + name_y) - (selected * 2)), name_xscale, name_yscale, name_angle, name_blend, name_alpha);
;
surface_free(_frl__surface);
;
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
draw_set_font(fntM1);
;
}
}
}

// Original custom_options.mod.gml:2518
function fr_custom_options_mod_gml_Custom_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, 24, 24, c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
draw_synced = true;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2534
function fr_custom_options_mod_gml_region_relocate(_frl__region=undefined, _frl__x=undefined, _frl__y=undefined) {
_frl__region.anchored_x = _frl__x;
;
_frl__region.anchored_y = _frl__y;
;
}

// Original custom_options.mod.gml:2538
function fr_custom_options_mod_gml_Title_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, 1, 1, c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "";
;
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_Title_step];
;
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw];
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "okay", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_title_press]), fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_title_mouse_press]));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2563
function fr_custom_options_mod_gml_Title_step() {
if (((abs((x2 - x1)) != fr_custom_options_mod_gml_string_width_fixed(name)) || (abs((y2 - y1)) != fr_custom_options_mod_gml_string_height_fixed(name)))) {
{
draw_set_font(fntM1);
;
fr_custom_options_mod_gml_region_resize(scrFRSelf(self), fr_custom_options_mod_gml_string_width_fixed(name), fr_custom_options_mod_gml_string_height_fixed(name));
;
}
}
}

// Original custom_options.mod.gml:2575
function fr_custom_options_mod_gml_title_press() {
if (selected) {
{
if ((on_change != undefined)) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
scrFRScriptCall(on_change, p, name);
;
}
}
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2590
function fr_custom_options_mod_gml_title_mouse_press() {
if ((selected && fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self)))) {
{
return fr_custom_options_mod_gml_title_press();
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2597
function fr_custom_options_mod_gml_Cycle_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, ((sprite_get_bbox_right(sprScoreSplat) - sprite_get_bbox_left(sprScoreSplat)) + 1), ((sprite_get_bbox_bottom(sprScoreSplat) - sprite_get_bbox_top(sprScoreSplat)) + 1), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
splat_spr = sprScoreSplat;
;
splat_img = (sprite_get_number(sprScoreSplat) - 1);
;
values = ["this", "is", "a", "cycle"];
;
display = scrFRArrayClone(values);
;
index = 0;
;
value = scrFRIndexGet(values, index);
;
on_draw = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Cycle_draw], ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw]);
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "west", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_cycle_adjust, (- 1)]), fr_custom_options_mod_gml_input_event_create(p, "east", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_cycle_adjust, 1]));
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_cycle_mouse_adjust]), on_input);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2641
function fr_custom_options_mod_gml_Cycle_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_middle);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
var _frl__text = fr_custom_options_mod_gml_string_hash_to_newline(((display_override != undefined) ? display_override : ((prefix + string(scrFRIndexGet(display, index))) + suffix)));
;
var _frl__visualSurface = surface_create((fr_custom_options_mod_gml_string_width_fixed(_frl__text) + 4), (fr_custom_options_mod_gml_string_height_fixed(_frl__text) + 4));
;
fr_custom_options_mod_gml_surface_target_push(_frl__visualSurface);
;
draw_clear_alpha(c_black, 0);
;
var _frl__textPos = fr_custom_options_mod_gml_region_to_world((abs((x2 - x1)) / 2), ((abs((y2 - y1)) / 2) + 3), scrFRSelf(self));
;
scrFRDrawText((surface_get_width(_frl__visualSurface) / 2), (surface_get_height(_frl__visualSurface) / 2), ("@(color:" + string((selected ? c_white : c_silver)) + ")" + string(_frl__text) + ""));
;
fr_custom_options_mod_gml_surface_target_pop();
;
fr_custom_options_mod_gml_draw_surface_centered_ext(_frl__visualSurface, _frl__textPos.x, _frl__textPos.y, xscale, yscale, angle, blend, alpha);
;
surface_free(_frl__visualSurface);
;
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
if (selected) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
if (((_frl__inRegion.x <= abs((x2 - x1))) && (_frl__inRegion.x >= (abs((x2 - x1)) / 2)))) {
{
draw_set_font(fntConsole);
;
scrFRDrawText(4, (round((abs((y2 - y1)) / 2)) + 3), ">");
;
draw_set_font(fntM1);
;
}
} else {
if (((_frl__inRegion.x >= 0) && (_frl__inRegion.x < (abs((x2 - x1)) / 2)))) {
{
draw_set_font(fntConsole);
;
scrFRDrawText(4, (round((abs((y2 - y1)) / 2)) + 3), "<");
;
draw_set_font(fntM1);
;
}
}
}
}
}
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
}

// Original custom_options.mod.gml:2704
function fr_custom_options_mod_gml_cycle_adjust(_frl__delta=undefined) {
if (selected) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
index = fr_custom_options_mod_gml_wrap_range((index + _frl__delta), 0, array_length(values));
;
value = scrFRIndexGet(values, index);
;
fr_custom_options_mod_gml_option_change();
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2720
function fr_custom_options_mod_gml_cycle_mouse_adjust() {
if (selected) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
return fr_custom_options_mod_gml_cycle_adjust((((_frl__inRegion.x >= 0) && (_frl__inRegion.x >= (abs((x2 - x1)) / 2))) - ((_frl__inRegion.x <= x2) && (_frl__inRegion.x < (abs((x2 - x1)) / 2)))));
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2732
function fr_custom_options_mod_gml_Bool_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_Cycle_create(_frl__p)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
display = ["OFF", "ON"];
;
values = [false, true];
;
index = 0;
;
value = scrFRIndexGet(values, index);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2750
function fr_custom_options_mod_gml_Int_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, ((sprite_get_bbox_right(sprScoreSplat) - sprite_get_bbox_left(sprScoreSplat)) + 1), ((sprite_get_bbox_bottom(sprScoreSplat) - sprite_get_bbox_top(sprScoreSplat)) + 1), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
splat_spr = sprScoreSplat;
;
splat_img = (sprite_get_number(sprScoreSplat) - 1);
;
value = 0;
;
range = {"minimum": (- 5), "maximum": 5};
;
steps = 1;
;
wrap = true;
;
on_draw = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Int_draw], ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw]);
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "west", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_int_adjust, (- 1)]), fr_custom_options_mod_gml_input_event_create(p, "east", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_int_adjust, 1]));
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_int_mouse_adjust]), on_input);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2793
function fr_custom_options_mod_gml_Int_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_middle);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
var _frl__text = fr_custom_options_mod_gml_string_hash_to_newline(((display_override != undefined) ? display_override : ((prefix + string(value)) + suffix)));
;
var _frl__visualSurface = surface_create((fr_custom_options_mod_gml_string_width_fixed(_frl__text) + 4), (fr_custom_options_mod_gml_string_height_fixed(_frl__text) + 4));
;
fr_custom_options_mod_gml_surface_target_push(_frl__visualSurface);
;
draw_clear_alpha(c_black, 0);
;
var _frl__textPos = fr_custom_options_mod_gml_region_to_world((abs((x2 - x1)) / 2), ((abs((y2 - y1)) / 2) + 3), scrFRSelf(self));
;
scrFRDrawText((surface_get_width(_frl__visualSurface) / 2), (surface_get_height(_frl__visualSurface) / 2), ("@(color:" + string((selected ? c_white : c_silver)) + ")" + string(_frl__text) + ""));
;
fr_custom_options_mod_gml_surface_target_pop();
;
fr_custom_options_mod_gml_draw_surface_centered_ext(_frl__visualSurface, _frl__textPos.x, _frl__textPos.y, xscale, yscale, angle, blend, alpha);
;
surface_free(_frl__visualSurface);
;
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
if (selected) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
if (((_frl__inRegion.x <= x2) && (_frl__inRegion.x >= (abs((x2 - x1)) / 2)))) {
{
draw_set_font(fntConsole);
;
scrFRDrawText(4, ((abs((y2 - y1)) / 2) + 3), ">");
;
draw_set_font(fntM1);
;
}
} else {
if (((_frl__inRegion.x >= 0) && (_frl__inRegion.x < (abs((x2 - x1)) / 2)))) {
{
draw_set_font(fntConsole);
;
scrFRDrawText(4, ((abs((y2 - y1)) / 2) + 3), "<");
;
draw_set_font(fntM1);
;
}
}
}
}
}
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
}

// Original custom_options.mod.gml:2856
function fr_custom_options_mod_gml_int_adjust(_frl__delta=undefined) {
if (selected) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
_frl__delta *= steps;
;
if (((range.minimum != undefined) && (range.maximum != undefined))) {
{
value = (wrap ? fr_custom_options_mod_gml_wrap_range((value + _frl__delta), range.minimum, (range.maximum + 1)) : clamp((value + _frl__delta), range.minimum, range.maximum));
;
}
} else {
if (((range.minimum != undefined) && (range.maximum == undefined))) {
{
value = max(range.minimum, (value + _frl__delta));
;
}
} else {
if (((range.minimum == undefined) && (range.maximum != undefined))) {
{
value = min(range.maximum, (value + _frl__delta));
;
}
}
}
}
fr_custom_options_mod_gml_option_change();
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2881
function fr_custom_options_mod_gml_int_mouse_adjust() {
if (selected) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
return fr_custom_options_mod_gml_int_adjust((((_frl__inRegion.x >= 0) && (_frl__inRegion.x >= (abs((x2 - x1)) / 2))) - ((_frl__inRegion.x <= x2) && (_frl__inRegion.x < (abs((x2 - x1)) / 2)))));
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2893
function fr_custom_options_mod_gml_Text_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, ((sprite_get_bbox_right(sprOptionSlider) - sprite_get_bbox_left(sprOptionSlider)) + 1), ((sprite_get_bbox_bottom(sprOptionSlider) - sprite_get_bbox_top(sprOptionSlider)) + 1), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
splat_spr = sprOptionSlider;
;
splat_img = 0;
;
value = "";
;
inputting = false;
;
on_draw = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Text_draw], ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw]);
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "okay", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_text_select]), fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_text_select]));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:2924
function fr_custom_options_mod_gml_Text_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_middle);
;
draw_set_font(fntConsole);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
var _frl__text = (inputting ? "(Type a chat message)" : fr_custom_options_mod_gml_string_hash_to_newline(((display_override != undefined) ? display_override : ((prefix + string(value)) + suffix))));
;
var _frl__visualSurface = surface_create((fr_custom_options_mod_gml_string_width_fixed(_frl__text) + 4), (fr_custom_options_mod_gml_string_height_fixed(_frl__text) + 4));
;
fr_custom_options_mod_gml_surface_target_push(_frl__visualSurface);
;
draw_clear_alpha(c_black, 0);
;
var _frl__textPos = fr_custom_options_mod_gml_region_to_world(2, 2, scrFRSelf(self));
;
scrFRDrawText((surface_get_width(_frl__visualSurface) / 2), (surface_get_height(_frl__visualSurface) / 2), ("@(color:" + string((selected ? (inputting ? c_dkgray : c_white) : c_silver)) + ")" + string(_frl__text) + ""));
;
fr_custom_options_mod_gml_surface_target_pop();
;
draw_surface_ext(_frl__visualSurface, _frl__textPos.x, _frl__textPos.y, xscale, yscale, angle, blend, alpha);
;
surface_free(_frl__visualSurface);
;
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
draw_set_font(fntM1);
;
}

// Original custom_options.mod.gml:2976
function fr_custom_options_mod_gml_text_select() {
if (selected) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
inputting = true;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "text_region", [p], scrFRSelf(self), "=");
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2990
function fr_custom_options_mod_gml_text_mouse_select() {
if ((selected && fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self)))) {
{
return fr_custom_options_mod_gml_text_select();
;
}
}
return false;
;
}

// Original custom_options.mod.gml:2997
function fr_custom_options_mod_gml_chat_message(_frl__msg=undefined, _frl__p=undefined) {
if (scrFRInstanceExists(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.text_region, _frl__p))) {
{
if ((scrFRPlayerFindLocal() == _frl__p)) {
{
scrFRSoundPlay(sndMenuStats);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.text_region, _frl__p)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
value = _frl__msg;
;
inputting = false;
;
fr_custom_options_mod_gml_option_change();
;
}
}
if(__fr_break3) break;
}}
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "text_region", [_frl__p], noone, "=");
;
return true;
;
}
}
}

// Original custom_options.mod.gml:3015
function fr_custom_options_mod_gml_Keys_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, ((sprite_get_bbox_right(sprOptionSlider) - sprite_get_bbox_left(sprOptionSlider)) + 1), ((sprite_get_bbox_bottom(sprOptionSlider) - sprite_get_bbox_top(sprOptionSlider)) + 1), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
splat_spr = sprOptionSlider;
;
splat_img = 0;
;
value = "";
;
keys = ds_map_create();
;
inputting = false;
;
style = "text";
;
on_destroy = ["mod", "custom_options", fr_custom_options_mod_gml_Keys_destroy];
;
on_draw = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Keys_draw], ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw]);
;
var _frl__validKeys = ["fire", "spec", "pick", "swap", "nort", "sout", "east", "west", "key1", "key2", "key3", "key4", "key5", "key6", "key7", "key8", "key9"];
;
on_input = fr_custom_options_mod_gml_input_event_create(p, "fire", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_keys_mouse_select]);
;
var _frl__validKeyCount = array_length(_frl__validKeys);
;
var _frl_i = _frl__validKeyCount;
;
if ((_frl__validKeyCount > 0)) {
{
repeat (_frl__validKeyCount) {
_frl_i -= 1;
;
var _frl__key = scrFRIndexGet(_frl__validKeys, _frl_i);
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, _frl__key, "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_keys_set_key, _frl__key, true]), fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, _frl__key, "released", ["mod", "custom_options", fr_custom_options_mod_gml_keys_set_key, _frl__key, false]), on_input));
;
}
}
}
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "okay", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_keys_select]), on_input);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:3093
function fr_custom_options_mod_gml_Keys_destroy() {
if (scrFRMapValid(keys)) {
{
ds_map_destroy(keys);
;
}
}
}

// Original custom_options.mod.gml:3098
function fr_custom_options_mod_gml_Keys_draw() {
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_middle);
;
draw_set_font(fntConsole);
;
var _frl__keys = ds_map_keys_to_array(keys);
;
array_sort(_frl__keys, true);
;
var _frl__text = "";
;
if ((style == "text")) {
{
_frl__text = fr_custom_options_mod_gml_string_hash_to_newline(((display_override != undefined) ? display_override : ((prefix + scrFRArrayJoin(_frl__keys, "+")) + suffix)));
;
}
} else {
{
var _frl__sprite = (((scrFRSourceFrame() % 40) < 20) ? "sprKeySmall" : "sprButSmall");
;
var _frl__keyCount = array_length(_frl__keys);
;
var _frl_i = (- 1);
;
if ((_frl__keyCount > 0)) {
{
repeat (_frl__keyCount) {
_frl_i += 1;
;
var _frl__key = scrFRIndexGet(_frl__keys, _frl_i);
;
{ var __fr_switch_value1=_frl__key, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("nort")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("sout")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("east")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("west")) __fr_switch_case2=3;
if(__fr_switch_case2==-1) __fr_switch_case2=4;
switch(__fr_switch_case2) {
case 0:

case 1:

case 2:

case 3:
{
if (((scrFRSourceFrame() % 40) < 20)) {
{
_frl__text += ("@3(" + string(_frl__sprite) + ":" + string(_frl__key) + ")+");
;
}
} else {
{
_frl__text += ("@3(" + string(_frl__sprite) + ":move)+");
;
}
}
break;
;
}
case 4:
{
if ((string_pos("key", _frl__key) == 1)) {
{
_frl__text += ("@3(sprKeySmall:" + string((48 + real(string_char_at(_frl__key, 4)))) + ")+");
;
}
} else {
{
_frl__text += ("@3(" + string(_frl__sprite) + ":" + string(_frl__key) + ")+");
;
}
}
break;
;
}
}
}
}
}
}
_frl__text = ((display_override != undefined) ? display_override : ((prefix + string_delete(_frl__text, string_length(_frl__text), 1)) + suffix));
;
}
}
_frl__text = fr_custom_options_mod_gml_string_hash_to_newline(_frl__text);
;
var _frl__lastSurface = fr_custom_options_mod_gml_surface_target_pop();
;
var _frl__visualSurface = surface_create((fr_custom_options_mod_gml_string_width_fixed(_frl__text) + 4), (fr_custom_options_mod_gml_string_height_fixed(_frl__text) + 4));
;
fr_custom_options_mod_gml_surface_target_push(_frl__visualSurface);
;
draw_clear_alpha(c_black, 0);
;
var _frl__textPos = fr_custom_options_mod_gml_region_to_world(2, 2, scrFRSelf(self));
;
scrFRDrawText((surface_get_width(_frl__visualSurface) / 2), (surface_get_height(_frl__visualSurface) / 2), ("@(color:" + string(((selected || inputting) ? c_white : c_silver)) + ")" + string(_frl__text) + ""));
;
fr_custom_options_mod_gml_surface_target_pop();
;
draw_surface_ext(_frl__visualSurface, _frl__textPos.x, _frl__textPos.y, xscale, yscale, angle, blend, alpha);
;
surface_free(_frl__visualSurface);
;
fr_custom_options_mod_gml_surface_target_push(_frl__lastSurface);
;
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
draw_set_font(fntM1);
;
}

// Original custom_options.mod.gml:3197
function fr_custom_options_mod_gml_keys_set_key(_frl__key=undefined, _frl__active=undefined) {
if ((selected && inputting)) {
{
if (_frl__active) {
{
ds_map_set(keys, _frl__key, _frl__active);
;
}
} else {
{
ds_map_delete(keys, _frl__key);
;
}
}
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3210
function fr_custom_options_mod_gml_keys_input() {
if (inputting) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndClick);
;
}
}
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "keys_region", [p], scrFRSelf(self), "=");
;
}
} else {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPlay(sndMenuStats);
;
}
}
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:custom_options"].menu, "keys_region", [p], noone, "=");
;
var _frl__value = ds_map_keys_to_array(keys);
;
array_sort(_frl__value, true);
;
var _frl__valueCount = array_length(_frl__value);
;
var _frl_i = (- 1);
;
value = "";
;
if ((_frl__valueCount > 0)) {
{
repeat (_frl__valueCount) {
_frl_i += 1;
;
if ((scrFRIndexGet(_frl__value, _frl_i) != "")) {
{
value += (scrFRIndexGet(_frl__value, _frl_i) + "+");
;
}
}
}
value = string_delete(value, string_length(value), 1);
;
}
}
fr_custom_options_mod_gml_option_change();
;
}
}
}

// Original custom_options.mod.gml:3246
function fr_custom_options_mod_gml_option_change() {
var _frl__beforeChange = fr_custom_options_mod_gml_option_get(mod_kind, mod_name, page_name, option_name);
;
if (fake_nonsync) {
{
fr_custom_options_mod_gml_option_set_fake_nonsync(mod_kind, mod_name, page_name, option_name, p, value);
;
}
} else {
if ((nonsync && (scrFRPlayerFindLocal() == p))) {
{
fr_custom_options_mod_gml_option_set(mod_kind, mod_name, page_name, option_name, value);
;
}
} else {
{
fr_custom_options_mod_gml_option_set(mod_kind, mod_name, page_name, option_name, value);
;
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
if (scrFRPlayerIsActive(_frl__p)) {
{
if (((frMacro_custom_options_mod_gml_MENU.open && (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p) != undefined)) && (scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, _frl__p) == scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.mods, frMacro_custom_options_mod_gml_MENU.mod_index).page_index, p)))) {
{
if ((scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p).child_count > 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p).children, (scrFRIndexGet(frMacro_custom_options_mod_gml_MENU.region, _frl__p).child_count - 1))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((child_count > 0)) {
{
var _frl_i = (- 1);
;
repeat (child_count) {
_frl_i += 1;
;
if ((!scrFRVariableExists(scrFRIndexGet(children, _frl_i), "option_name"))) {
{
continue;
;
}
}
if ((((scrFRIndexGet(children, _frl_i).mod_kind == (scrFROther(other)).mod_kind) && (scrFRIndexGet(children, _frl_i).mod_name == (scrFROther(other)).mod_name)) && (scrFRIndexGet(children, _frl_i).option_name == (scrFROther(other)).option_name))) {
{
var __fr_other4=scrFROther(other);
scrFRIndexGet(children, _frl_i).value = __fr_other4.value;
;
}
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
}
}
}
}
}
}
}
}
if ((on_change != undefined)) {
{
scrFRScriptCall(on_change, p, _frl__beforeChange);
;
}
}
}

// Original custom_options.mod.gml:3293
function fr_custom_options_mod_gml_keys_mouse_select() {
if (selected) {
{
inputting = fr_custom_options_mod_gml_point_in_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
fr_custom_options_mod_gml_keys_input();
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3304
function fr_custom_options_mod_gml_keys_select() {
if (selected) {
{
inputting = (! inputting);
;
fr_custom_options_mod_gml_keys_input();
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3315
function fr_custom_options_mod_gml_Slider_create(_frl__p=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_custom_options_mod_gml_region_create(_frl__p, 0, 0, ((sprite_get_bbox_right(sprOptionSlider) - sprite_get_bbox_left(sprOptionSlider)) + 1), ((sprite_get_bbox_bottom(sprOptionSlider) - sprite_get_bbox_top(sprOptionSlider)) + 1), c_black, 0, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
splat_spr = global.fr_module_vars[$ "mod:custom_options"].options_slider;
;
splat_img = 0;
;
range = {"minimum": 0, "maximum": 1};
;
format = {"total": 3, "dec": 1, "display_multiplier": 100};
;
color = {"minimum": c_lime, "maximum": c_lime};
;
value = 0.8;
;
steps = 0.001;
;
button_steps = 0.1;
;
on_draw = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Slider_draw], ["mod", "custom_options", fr_custom_options_mod_gml_Name_draw]);
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "west", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_slider_adjust, (- 0.1)]), fr_custom_options_mod_gml_input_event_create(p, "east", "pressed", ["mod", "custom_options", fr_custom_options_mod_gml_slider_adjust, 0.1]));
;
on_input = fr_custom_options_mod_gml_script_ref_wrap(fr_custom_options_mod_gml_input_event_create(p, "fire", "check", ["mod", "custom_options", fr_custom_options_mod_gml_slider_mouse_adjust]), on_input);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:3368
function fr_custom_options_mod_gml_Slider_draw() {
var _frl__sliderUVs = sprite_get_uvs(global.fr_module_vars[$ "mod:custom_options"].options_slider, 1);
;
var _frl__bboxLeft = scrFRIndexGet(_frl__sliderUVs, 4);
;
var _frl__bboxTop = scrFRIndexGet(_frl__sliderUVs, 5);
;
var _frl__sliderWidth = (scrFRIndexGet(_frl__sliderUVs, 6) * sprite_get_width(global.fr_module_vars[$ "mod:custom_options"].options_slider));
;
var _frl__sliderHeight = (scrFRIndexGet(_frl__sliderUVs, 7) * sprite_get_height(global.fr_module_vars[$ "mod:custom_options"].options_slider));
;
var _frl__percent = ((value - range.minimum) / (range.maximum - range.minimum));
;
fr_custom_options_mod_gml_draw_sprite_part_centered_ext(global.fr_module_vars[$ "mod:custom_options"].options_slider, 1, _frl__bboxLeft, _frl__bboxTop, (_frl__sliderWidth * _frl__percent), _frl__sliderHeight, (abs((x2 - x1)) / 2), (abs((y2 - y1)) / 2), 1, 1, 0, merge_color(color.minimum, color.maximum, _frl__percent), 1);
;
fr_custom_options_mod_gml_draw_sprite_part_centered_ext(sprSliderEnd, 0, sprite_get_bbox_left(sprSliderEnd), sprite_get_bbox_top(sprSliderEnd), sprite_get_bbox_right(sprSliderEnd), sprite_get_bbox_bottom(sprSliderEnd), ((((_frl__sliderWidth - sprite_get_width(sprSliderEnd)) * _frl__percent) + _frl__bboxLeft) + (sprite_get_width(sprSliderEnd) / 2)), (abs((y2 - y1)) / 2), 1, 1, 0, c_white, 1);
;
var _frl__halign = draw_get_halign();
;
var _frl__valign = draw_get_valign();
;
draw_set_halign(fa_left);
;
draw_set_valign(fa_top);
;
var _frl__displayValue = (value * format.display_multiplier);
;
scrFRDrawText(8, 5, ("@(color:" + string((selected ? c_white : c_silver)) + ")" + string(fr_custom_options_mod_gml_string_hash_to_newline(((display_override != undefined) ? display_override : ((prefix + string_format(_frl__displayValue, format.total, format.dec)) + suffix)))) + ""));
;
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
}

// Original custom_options.mod.gml:3428
function fr_custom_options_mod_gml_slider_adjust(_frl__percentDelta=undefined) {
if (selected) {
{
value = clamp((value + ((range.maximum - range.minimum) * _frl__percentDelta)), range.minimum, range.maximum);
;
value = (round((value / button_steps)) * button_steps);
;
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPitchVolume(sndSlider, (value / (range.maximum - range.minimum)), 1);
;
}
}
fr_custom_options_mod_gml_option_change();
;
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3444
function fr_custom_options_mod_gml_slider_mouse_adjust() {
if (selected) {
{
var _frl__inRegion = fr_custom_options_mod_gml_world_to_region(scrFRMouseCoordinate(0, p), scrFRMouseCoordinate(1, p), scrFRSelf(self));
;
var _frl__sliderUVs = sprite_get_uvs(global.fr_module_vars[$ "mod:custom_options"].options_slider, 1);
;
var _frl__bboxLeft = scrFRIndexGet(_frl__sliderUVs, 4);
;
var _frl__bboxTop = scrFRIndexGet(_frl__sliderUVs, 5);
;
var _frl__sliderWidth = (scrFRIndexGet(_frl__sliderUVs, 6) * sprite_get_width(global.fr_module_vars[$ "mod:custom_options"].options_slider));
;
var _frl__sliderHeight = (scrFRIndexGet(_frl__sliderUVs, 7) * sprite_get_height(global.fr_module_vars[$ "mod:custom_options"].options_slider));
;
var _frl__value = value;
;
value = clamp((((range.maximum - range.minimum) * (((clamp(_frl__inRegion.x, (_frl__bboxLeft + (sprite_get_width(sprSliderEnd) / 2)), ((_frl__bboxLeft + _frl__sliderWidth) - (sprite_get_width(sprSliderEnd) / 2))) - _frl__bboxLeft) - (sprite_get_width(sprSliderEnd) / 2)) / (_frl__sliderWidth - sprite_get_width(sprSliderEnd)))) + range.minimum), range.minimum, range.maximum);
;
value = (round((value / steps)) * steps);
;
if ((value != _frl__value)) {
{
if ((scrFRPlayerFindLocal() == p)) {
{
scrFRSoundPitchVolume(sndSlider, (value / (range.maximum - range.minimum)), 1);
;
}
}
fr_custom_options_mod_gml_option_change();
;
}
}
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3483
function fr_custom_options_mod_gml_wrap_range(_frl__value=undefined, _frl__minimum=undefined, _frl__maximum=undefined) {
var _frl__range = (_frl__maximum - _frl__minimum);
;
return (((((_frl__value - _frl__minimum) % _frl__range) + _frl__range) % _frl__range) + _frl__minimum);
;
}

// Original custom_options.mod.gml:3487
function fr_custom_options_mod_gml_string_width_fixed(_frl__string=undefined) {
return string_width(fr_custom_options_mod_gml_string_delete_nt(fr_custom_options_mod_gml_string_hash_to_newline(_frl__string)));
;
}

// Original custom_options.mod.gml:3490
function fr_custom_options_mod_gml_string_height_fixed(_frl__string=undefined) {
return string_height(fr_custom_options_mod_gml_string_delete_nt(fr_custom_options_mod_gml_string_hash_to_newline(_frl__string)));
;
}

// Original custom_options.mod.gml:3493
function fr_custom_options_mod_gml_string_hash_to_newline(_frl__string=undefined) {
var _frl__backPos = string_pos("\\", _frl__string);
;
var _frl__hashPos = string_pos("#", _frl__string);
;
if (((_frl__backPos == 0) && (_frl__hashPos == 0))) {
{
return _frl__string;
;
}
}
if (ds_map_exists(global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache, _frl__string)) {
{
return global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache[?_frl__string];
;
}
}
var _frl__search = "112935";
;
while ((string_pos(_frl__search, _frl__string) > 0)) {
_frl__search += "112935";
;
}
var _frl__buffer = string_replace_all(string_replace_all(string_replace_all(_frl__string, "\\#", _frl__search), "#", chr(10)), _frl__search, "#");
;
global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache[?_frl__string] = _frl__buffer;
;
return global.fr_module_vars[$ "mod:custom_options"].string_hash_to_newline_cache[?_frl__string];
;
}

// Original custom_options.mod.gml:3517
function fr_custom_options_mod_gml_string_delete_nt(_frl__string=undefined) {
var _frl__atPos = string_pos("@", _frl__string);
;
if ((_frl__atPos == 0)) {
{
return _frl__string;
;
}
}
if (ds_map_exists(global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache, _frl__string)) {
{
return global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache[?_frl__string];
;
}
}
var _frl__stringLength = string_length(_frl__string);
;
var _frl__buffer = string_copy(_frl__string, 1, (_frl__atPos - 1));
;
while (((_frl__atPos > 0) && (_frl__atPos <= _frl__stringLength))) {
var _frl__pos = _frl__atPos;
;
var _frl_c = string_char_at(_frl__string, (++ _frl__atPos));
;
var _frl__padding = "";
;
{ var __fr_switch_value1=_frl_c, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("@")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("0")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("w")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("s")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("d")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("r")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("g")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("b")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("p")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("y")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("q")) __fr_switch_case2=10;
if(__fr_switch_case2==-1 && __fr_switch_value1==("1")) __fr_switch_case2=11;
if(__fr_switch_case2==-1 && __fr_switch_value1==("2")) __fr_switch_case2=12;
if(__fr_switch_case2==-1 && __fr_switch_value1==("3")) __fr_switch_case2=13;
if(__fr_switch_case2==-1 && __fr_switch_value1==("4")) __fr_switch_case2=14;
if(__fr_switch_case2==-1 && __fr_switch_value1==("5")) __fr_switch_case2=15;
if(__fr_switch_case2==-1 && __fr_switch_value1==("6")) __fr_switch_case2=16;
if(__fr_switch_case2==-1 && __fr_switch_value1==("7")) __fr_switch_case2=17;
if(__fr_switch_case2==-1 && __fr_switch_value1==("8")) __fr_switch_case2=18;
if(__fr_switch_case2==-1 && __fr_switch_value1==("9")) __fr_switch_case2=19;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
_frl__buffer += "@";
;
break;
;
case 1:
_frl__buffer += " ";
;
break;
;
case 2:

case 3:

case 4:

case 5:

case 6:

case 7:

case 8:

case 9:

case 10:
break;
;
case 11:

case 12:

case 13:

case 14:

case 15:

case 16:

case 17:

case 18:

case 19:
{
_frl__padding = string_repeat(" ", real(_frl_c));
;
break;
;
}
}
}
if (((_frl__padding != "") && (string_char_at(_frl__string, (_frl__atPos + 1)) == "("))) {
{
while (((_frl_c != ")") && (_frl__atPos <= _frl__stringLength))) {
_frl_c = string_char_at(_frl__string, (++ _frl__atPos));
;
}
if ((_frl_c != ")")) {
{
_frl__buffer += string_copy(_frl__string, _frl__pos, (_frl__atPos - _frl__pos));
;
}
} else {
{
_frl__buffer += _frl__padding;
;
}
}
}
}
var _frl__nextPos = string_pos("@", string_copy(_frl__string, (_frl__atPos + 1), ((_frl__stringLength - _frl__atPos) - 1)));
;
if ((_frl__nextPos > 0)) {
{
_frl__buffer += string_copy(_frl__string, (_frl__atPos + 1), (_frl__nextPos - 1));
;
}
} else {
{
_frl__buffer += string_copy(_frl__string, (_frl__atPos + 1), (_frl__stringLength - _frl__atPos));
;
}
}
_frl__atPos = ((_frl__atPos + _frl__nextPos) * sign(_frl__nextPos));
;
}
global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache[?_frl__string] = _frl__buffer;
;
return global.fr_module_vars[$ "mod:custom_options"].string_delete_nt_cache[?_frl__string];
;
}

// Original custom_options.mod.gml:3592
function fr_custom_options_mod_gml_draw_sprite_ext_nc(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined, _frl__yscale=undefined, _frl__angle=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
scrFRModCall(frMacro_custom_options_mod_gml_mod_current_type, "custom_options", "draw_sprite_ext_mod_script_call_nc", _frl__sprite, _frl__image, _frl__x, _frl__y, _frl__xscale, _frl__yscale, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original custom_options.mod.gml:3608
function fr_custom_options_mod_gml_draw_sprite_ext_mod_script_call_nc(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined, _frl__yscale=undefined, _frl__angle=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, _frl__xscale, _frl__yscale, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original custom_options.mod.gml:3621
function fr_custom_options_mod_gml_draw_sprite_part_centered_ext(_frl__sprite=undefined, _frl__image=undefined, _frl__left=undefined, _frl__top=undefined, _frl__width=undefined, _frl__height=undefined, _frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined, _frl__yscale=undefined, _frl__angle=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
var _frl__l = sprite_get_bbox_left(_frl__sprite);
;
var _frl__t = sprite_get_bbox_top(_frl__sprite);
;
var _frl__w = ((sprite_get_bbox_right(_frl__sprite) - _frl__l) + 1);
;
var _frl__h = ((sprite_get_bbox_bottom(_frl__sprite) - _frl__t) + 1);
;
var _frl__lengthX = floor(((_frl__w / 2) * _frl__xscale));
;
var _frl__lengthY = floor(((_frl__h / 2) * _frl__yscale));
;
draw_sprite_general(_frl__sprite, _frl__image, _frl__left, _frl__top, _frl__width, _frl__height, (((_frl__x - lengthdir_x(_frl__lengthX, _frl__angle)) - lengthdir_x(_frl__lengthY, (_frl__angle - 90))) + lengthdir_x(_frl__l, _frl__angle)), (((_frl__y - lengthdir_y(_frl__lengthX, _frl__angle)) - lengthdir_y(_frl__lengthY, (_frl__angle - 90))) + lengthdir_y(_frl__t, _frl__angle)), _frl__xscale, _frl__yscale, _frl__angle, _frl__blend, _frl__blend, _frl__blend, _frl__blend, _frl__alpha);
;
}

// Original custom_options.mod.gml:3649
function fr_custom_options_mod_gml_draw_surface_centered_ext(_frl__surface=undefined, _frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined, _frl__yscale=undefined, _frl__angle=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
var _frl__w = surface_get_width(_frl__surface);
;
var _frl__h = surface_get_height(_frl__surface);
;
var _frl__lengthX = floor(((_frl__w / 2) * _frl__xscale));
;
var _frl__lengthY = floor(((_frl__h / 2) * _frl__yscale));
;
draw_surface_ext(_frl__surface, ((_frl__x - lengthdir_x(_frl__lengthX, _frl__angle)) - lengthdir_x(_frl__lengthY, (_frl__angle - 90))), ((_frl__y - lengthdir_y(_frl__lengthX, _frl__angle)) - lengthdir_y(_frl__lengthY, (_frl__angle - 90))), _frl__xscale, _frl__yscale, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original custom_options.mod.gml:3667
function fr_custom_options_mod_gml_world_to_region(_frl__x=undefined, _frl__y=undefined, _frl__region=undefined) {
var _frl__regionCorners = fr_custom_options_mod_gml_region_corners_rotated(_frl__region);
;
var _frl__distance = point_distance(0, 0, (_frl__x - _frl__regionCorners.x1), (_frl__y - _frl__regionCorners.y1));
;
var _frl__direction = point_direction(0, 0, (_frl__x - _frl__regionCorners.x1), (_frl__y - _frl__regionCorners.y1));
;
return {"x": ceil(lengthdir_x((_frl__distance / _frl__region.xscale), (_frl__direction - _frl__region.angle))), "y": ceil(lengthdir_y((_frl__distance / _frl__region.yscale), (_frl__direction - _frl__region.angle)))};
;
}

// Original custom_options.mod.gml:3678
function fr_custom_options_mod_gml_region_to_world(_frl__x=undefined, _frl__y=undefined, _frl__region=undefined) {
var _frl__regionCorners = fr_custom_options_mod_gml_region_corners_rotated(_frl__region);
;
var _frl__distance = point_distance(0, 0, _frl__x, _frl__y);
;
var _frl__direction = point_direction(0, 0, _frl__x, _frl__y);
;
return {"x": ceil((_frl__regionCorners.x1 + lengthdir_x((_frl__distance * _frl__region.xscale), (_frl__direction + _frl__region.angle)))), "y": ceil((_frl__regionCorners.y1 + lengthdir_y((_frl__distance * _frl__region.yscale), (_frl__direction + _frl__region.angle))))};
;
}

// Original custom_options.mod.gml:3689
function fr_custom_options_mod_gml_region_corners_rotated(_frl__region=undefined) {
var _frl__width = ceil(((_frl__region.x2 - _frl__region.x1) * _frl__region.xscale));
;
var _frl__height = ceil(((_frl__region.y2 - _frl__region.y1) * _frl__region.yscale));
;
var _frl__offsetX = ceil((_frl__width / 2));
;
var _frl__offsetY = ceil((_frl__height / 2));
;
var _frl__cornerX1 = lengthdir_x(_frl__offsetX, _frl__region.angle);
;
var _frl__cornerX2 = lengthdir_x(_frl__offsetY, (_frl__region.angle - 90));
;
var _frl__cornerY1 = lengthdir_y(_frl__offsetX, _frl__region.angle);
;
var _frl__cornerY2 = lengthdir_y(_frl__offsetY, (_frl__region.angle - 90));
;
return {"x1": ceil(((_frl__region.x1 - _frl__cornerX1) - _frl__cornerX2)), "y1": ceil(((_frl__region.y1 - _frl__cornerY1) - _frl__cornerY2)), "x2": ceil(((_frl__region.x1 + _frl__cornerX1) - _frl__cornerX2)), "y2": ceil(((_frl__region.y1 + _frl__cornerY1) - _frl__cornerY2)), "x3": ceil(((_frl__region.x1 - _frl__cornerX1) + _frl__cornerX2)), "y3": ceil(((_frl__region.y1 - _frl__cornerY1) + _frl__cornerY2)), "x4": ceil(((_frl__region.x1 + _frl__cornerX1) + _frl__cornerX2)), "y4": ceil(((_frl__region.y1 + _frl__cornerY1) + _frl__cornerY2))};
;
}

// Original custom_options.mod.gml:3712
function fr_custom_options_mod_gml_point_in_region(_frl__x=undefined, _frl__y=undefined, _frl__region=undefined) {
var _frl__rotatedRegion = fr_custom_options_mod_gml_region_corners_rotated(_frl__region);
;
return (fr_custom_options_mod_gml_point_in_rotated_rectangle_bbox(_frl__x, _frl__y, _frl__rotatedRegion.x1, _frl__rotatedRegion.y1, _frl__rotatedRegion.x2, _frl__rotatedRegion.y2, _frl__rotatedRegion.x3, _frl__rotatedRegion.y3, _frl__rotatedRegion.x4, _frl__rotatedRegion.y4) && (point_in_triangle(_frl__x, _frl__y, _frl__rotatedRegion.x1, _frl__rotatedRegion.y1, _frl__rotatedRegion.x2, _frl__rotatedRegion.y2, _frl__rotatedRegion.x3, _frl__rotatedRegion.y3) || point_in_triangle(_frl__x, _frl__y, _frl__rotatedRegion.x2, _frl__rotatedRegion.y2, _frl__rotatedRegion.x4, _frl__rotatedRegion.y4, _frl__rotatedRegion.x3, _frl__rotatedRegion.y3)));
;
}

// Original custom_options.mod.gml:3746
function fr_custom_options_mod_gml_script_ref_wrap(_frl__superScriptReference=undefined, _frl__scriptReference=undefined) {
var _frl__superWrapped = fr_custom_options_mod_gml_script_is_wrapped(_frl__superScriptReference);
;
var _frl__wrapped = fr_custom_options_mod_gml_script_is_wrapped(_frl__scriptReference);
;
var _frl__clonedReferences = [];
;
if (_frl__superWrapped) {
{
{
var _frl_i = 0;
var _frl__scriptReferenceCount = array_length(scrFRIndexGet(_frl__superScriptReference, 3));
for (; (_frl__scriptReferenceCount > _frl_i); _frl_i++) {
array_push(_frl__clonedReferences, scrFRArrayClone(scrFRIndexGet(scrFRIndexGet(_frl__superScriptReference, 3), _frl_i)));
;
}
}
}
} else {
{
array_push(_frl__clonedReferences, _frl__superScriptReference);
;
}
}
if (_frl__wrapped) {
{
{
var _frl_i = 0;
var _frl__scriptReferenceCount = array_length(scrFRIndexGet(_frl__scriptReference, 3));
for (; (_frl__scriptReferenceCount > _frl_i); _frl_i++) {
array_push(_frl__clonedReferences, scrFRArrayClone(scrFRIndexGet(scrFRIndexGet(_frl__scriptReference, 3), _frl_i)));
;
}
}
}
} else {
{
array_push(_frl__clonedReferences, _frl__scriptReference);
;
}
}
return ["mod", "custom_options", fr_custom_options_mod_gml_script_ref_wrapped, _frl__clonedReferences];
;
}

// Original custom_options.mod.gml:3770
function fr_custom_options_mod_gml_script_is_wrapped(_frl__scriptReference=undefined) {
return ((((is_array(_frl__scriptReference) && (array_length(_frl__scriptReference) >= 4)) && (scrFRIndexGet(_frl__scriptReference, 1) == "custom_options")) && (scrFRIndexGet(_frl__scriptReference, 0) == frMacro_custom_options_mod_gml_mod_current_type)) && (scrFRIndexGet(_frl__scriptReference, 2) == "script_ref_wrapped"));
;
}

// Original custom_options.mod.gml:3776
function fr_custom_options_mod_gml_script_ref_wrapped() {
{
var _frl_i = 0;
var _frl__scriptReferenceCount = array_length((argument_count>0 ? argument[0] : undefined));
for (; (_frl__scriptReferenceCount > _frl_i); _frl_i++) {
var _frl__script = scrFRIndexGet((argument_count>0 ? argument[0] : undefined), _frl_i);
;
if ((argument_count > 1)) {
{
_frl__script = scrFRArrayClone(_frl__script);
;
{
var _frl_j = 1;
for (; (argument_count > _frl_j); _frl_j++) {
array_push(_frl__script, (argument_count>_frl_j && _frl_j>=0 ? argument[_frl_j] : undefined));
;
}
}
}
}
var _frl__result = fr_custom_options_mod_gml_script_ref_call_wc(_frl__script, scrFRSelf(self), (scrFROther(other)));
;
try {
if ((_frl__result || (! scrFRInstanceExists(scrFRSelf(self))))) {
{
return _frl__result;
;
}
}
} catch(__fr_caught1) { var _frl__error=__fr_caught1;
{
_frl__result = false;
;
}
}
;
}
}
}

// Original custom_options.mod.gml:3801
function fr_custom_options_mod_gml_script_ref_call_wc() {
var _frl__scriptReference = (argument_count>0 ? argument[0] : undefined);
;
var _frl__self = (argument_count>1 ? argument[1] : undefined);
;
var _frl__other = (argument_count>2 ? argument[2] : undefined);
;
if ((argument_count > 3)) {
{
_frl__scriptReference = scrFRArrayClone(_frl__scriptReference);
;
{
var _frl_i = 3;
for (; (argument_count > _frl_i); _frl_i++) {
array_push(_frl__scriptReference, (argument_count>_frl_i && _frl_i>=0 ? argument[_frl_i] : undefined));
;
}
}
}
}
if ((((((_frl__other != undefined) && (_frl__other != noone)) && (_frl__self != undefined)) && (_frl__self != noone)) && ((scrFRSelf(self) != _frl__self) || ((scrFROther(other)) != _frl__other)))) {
{
{ var __fr_with1 = scrFRWithValues(_frl__other), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(_frl__self), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
return scrFRModCall(frMacro_custom_options_mod_gml_mod_current_type, "custom_options", "script_ref_call_wc", _frl__scriptReference, scrFRSelf(self), (scrFROther(other)));
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}
} else {
if ((((_frl__other != undefined) && (_frl__other != noone)) && ((scrFROther(other)) != _frl__other))) {
{
{ var __fr_with7 = scrFRWithValues(_frl__other), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(scrFRSelf(self)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
return scrFRModCall(frMacro_custom_options_mod_gml_mod_current_type, "custom_options", "script_ref_call_wc", _frl__scriptReference, undefined, (scrFROther(other)));
;
}
}
if(__fr_break12) break;
}}
}
}
if(__fr_break9) break;
}}
}
} else {
if ((((_frl__self != undefined) && (_frl__self != noone)) && (scrFRSelf(self) != _frl__self))) {
{
{ var __fr_with13 = scrFRWithValues(_frl__self), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
return scrFRModCall(frMacro_custom_options_mod_gml_mod_current_type, "custom_options", "script_ref_call_wc", _frl__scriptReference, scrFRSelf(self), undefined);
;
}
}
if(__fr_break15) break;
}}
}
}
}
}
return scrFRScriptCall(_frl__scriptReference);
;
}

// Original custom_options.mod.gml:3834
function fr_custom_options_mod_gml_early_exit(_frl__scriptReference=undefined) {
var _frl__statusCode = scrFRScriptCall(_frl__scriptReference);
;
if (((_frl__statusCode != undefined) && _frl__statusCode)) {
{
return true;
;
}
}
return false;
;
}

// Original custom_options.mod.gml:3843
function fr_custom_options_mod_gml_input_event_create(_frl__p=undefined, _frl__button=undefined, _frl__event=undefined, _frl__scriptReference=undefined) {
{ var __fr_switch_value1=_frl__button, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("nort")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("sout")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("east")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("west")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("fire")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("spec")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("pick")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("swap")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("okay")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("paus")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("horn")) __fr_switch_case2=10;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key1")) __fr_switch_case2=11;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key2")) __fr_switch_case2=12;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key3")) __fr_switch_case2=13;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key4")) __fr_switch_case2=14;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key5")) __fr_switch_case2=15;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key6")) __fr_switch_case2=16;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key7")) __fr_switch_case2=17;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key8")) __fr_switch_case2=18;
if(__fr_switch_case2==-1 && __fr_switch_value1==("key9")) __fr_switch_case2=19;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:

case 1:

case 2:

case 3:

case 4:

case 5:

case 6:

case 7:

case 8:

case 9:

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
return ["mod", "custom_options", ((_frl__event == "released") ? fr_custom_options_mod_gml_input_event_handle_released : ((_frl__event == "check") ? fr_custom_options_mod_gml_input_event_handle_check : ((_frl__event == "pressed") ? fr_custom_options_mod_gml_input_event_handle_pressed : fr_custom_options_mod_gml_input_event_unknown_event))), _frl__p, _frl__button, _frl__scriptReference];
;
}
}
return ["mod", "custom_options", fr_custom_options_mod_gml_input_event_unknown_button, _frl__p, _frl__button, _frl__event, _frl__scriptReference];
;
}

// Original custom_options.mod.gml:3876
function fr_custom_options_mod_gml_input_event_handle_pressed(_frl__p=undefined, _frl__button=undefined, _frl__scriptReference=undefined) {
if (scrFRButtonPressed(_frl__p, _frl__button)) {
{
var _frl__statusCode = scrFRScriptCall(_frl__scriptReference);
;
if (((_frl__statusCode != undefined) && _frl__statusCode)) {
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

// Original custom_options.mod.gml:3887
function fr_custom_options_mod_gml_input_event_handle_check(_frl__p=undefined, _frl__button=undefined, _frl__scriptReference=undefined) {
if (scrFRButtonCheck(_frl__p, _frl__button)) {
{
var _frl__statusCode = scrFRScriptCall(_frl__scriptReference);
;
if (((_frl__statusCode != undefined) && _frl__statusCode)) {
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

// Original custom_options.mod.gml:3898
function fr_custom_options_mod_gml_input_event_handle_released(_frl__p=undefined, _frl__button=undefined, _frl__scriptReference=undefined) {
if (scrFRButtonReleased(_frl__p, _frl__button)) {
{
var _frl__statusCode = scrFRScriptCall(_frl__scriptReference);
;
if (((_frl__statusCode != undefined) && _frl__statusCode)) {
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

// Original custom_options.mod.gml:3909
function fr_custom_options_mod_gml_input_event_unknown_button(_frl__p=undefined, _frl__button=undefined, _frl__event=undefined, _frl__scriptReference=undefined) {
scrFRTraceColor(("Unknown NTT button \"" + string(_frl__button) + "\" waiting to call \"" + string(scrFRIndexGet(_frl__scriptReference, 1)) + "." + string(scrFRIndexGet(_frl__scriptReference, 0)) + "::" + string(scrFRIndexGet(_frl__scriptReference, 2)) + "\" on P" + string((_frl__p + 1)) + " " + string(_frl__event) + ""), c_red);
;
return true;
;
}

// Original custom_options.mod.gml:3913
function fr_custom_options_mod_gml_input_event_unknown_event(_frl__p=undefined, _frl__button=undefined, _frl__event=undefined, _frl__scriptReference=undefined) {
scrFRTraceColor(("Unknown NTT event \"" + string(_frl__event) + "\" waiting to call \"" + string(scrFRIndexGet(_frl__scriptReference, 1)) + "." + string(scrFRIndexGet(_frl__scriptReference, 0)) + "::" + string(scrFRIndexGet(_frl__scriptReference, 2)) + "\" with P" + string((_frl__p + 1)) + "'s " + string(_frl__button) + ""), c_red);
;
return true;
;
}

// Original custom_options.mod.gml:3917
function fr_custom_options_mod_gml_region_add_child(_frl__region=undefined, _frl__child=undefined) {
if ((_frl__child.parent != undefined)) {
{
fr_custom_options_mod_gml_region_remove_child(_frl__child.parent, _frl__child);
;
}
}
array_push(_frl__region.children, _frl__child);
;
_frl__child.parent = _frl__region;
;
_frl__region.child_count += 1;
;
fr_custom_options_mod_gml_region_move_relative(_frl__child, _frl__region.x1, _frl__region.y1);
;
}

// Original custom_options.mod.gml:3928
function fr_custom_options_mod_gml_region_remove_child(_frl__region=undefined, _frl__child=undefined) {
var _frl__childIndex = scrFRArrayFindIndex(_frl__region.children, _frl__child);
;
if (((_frl__childIndex >= 0) && (scrFRIndexGet(_frl__region.children, _frl__childIndex) == _frl__child))) {
{
var _frl__newChildren = scrFRArraySlice(_frl__region.children, 0, _frl__childIndex);
;
array_copy(_frl__newChildren, _frl__childIndex, _frl__region.children, (_frl__childIndex + 1), (_frl__region.child_count - (_frl__childIndex + 1)));
;
_frl__region.children = _frl__newChildren;
;
_frl__child.parent = undefined;
;
_frl__region.child_count -= 1;
;
}
}
}

// Original custom_options.mod.gml:3940
function fr_custom_options_mod_gml_region_register(_frl__region=undefined) {
_frl__region.registered_index = ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions);
;
ds_list_add(global.fr_module_vars[$ "mod:custom_options"].regions, _frl__region);
;
}

// Original custom_options.mod.gml:3944
function fr_custom_options_mod_gml_region_deregister(_frl__region=undefined) {
if (((! scrFRInstanceExists(_frl__region)) || (_frl__region.registered_index < 0))) {
{
exit;
;
}
}
var _frl__shift = 1;
;
var _frl_i = _frl__region.registered_index;
;
if ((((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions) - _frl__region.registered_index) - 1) > 0)) {
{
repeat (((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions) - _frl__region.registered_index) - 1)) {
_frl_i += 1;
;
if ((_frl_i >= ds_list_size(global.fr_module_vars[$ "mod:custom_options"].regions))) {
{
break;
;
}
}
var _frl__regionToShift = global.fr_module_vars[$ "mod:custom_options"].regions[|_frl_i];
;
if ((_frl__regionToShift == undefined)) {
{
break;
;
}
}
if ((! scrFRInstanceExists(_frl__regionToShift))) {
{
_frl__shift += 1;
;
_frl_i -= 1;
;
continue;
;
}
} else {
{
_frl__regionToShift.registered_index -= _frl__shift;
;
}
}
}
}
}
ds_list_delete(global.fr_module_vars[$ "mod:custom_options"].regions, _frl__region.registered_index);
;
_frl__region.registered_index = (- 1);
;
}

// Original custom_options.mod.gml:3980
function fr_custom_options_mod_gml_region_create() {
var _frl__p = (argument_count>0 ? argument[0] : undefined);
;
var _frl__x = (argument_count>1 ? argument[1] : undefined);
;
var _frl__y = (argument_count>2 ? argument[2] : undefined);
;
var _frl__w = (argument_count>3 ? argument[3] : undefined);
;
var _frl__h = (argument_count>4 ? argument[4] : undefined);
;
var _frl__bgColor = ((argument_count > 5) ? (argument_count>5 ? argument[5] : undefined) : c_silver);
;
var _frl__bgAlpha = ((argument_count > 6) ? (argument_count>6 ? argument[6] : undefined) : 1.0);
;
var _frl__anchor = ((argument_count > 7) ? (argument_count>7 ? argument[7] : undefined) : false);
;
return fr_custom_options_mod_gml_Region_create(_frl__p, _frl__x, _frl__y, _frl__w, _frl__h, _frl__bgColor, _frl__bgAlpha, _frl__anchor);
;
}

// Original custom_options.mod.gml:3995
function fr_custom_options_mod_gml_region_destroy(_frl__region=undefined) {
if ((! scrFRInstanceExists(_frl__region))) {
{
exit;
;
}
}
if ((_frl__region.registered_index >= 0)) {
{
fr_custom_options_mod_gml_region_deregister(_frl__region);
;
}
}
if ((_frl__region.parent != undefined)) {
{
fr_custom_options_mod_gml_region_remove_child(_frl__region.parent, _frl__region);
;
}
}
fr_custom_options_mod_gml_script_ref_call_wc(_frl__region.on_destroy_internal, _frl__region, _frl__region);
;
}

// Original custom_options.mod.gml:4010
function fr_custom_options_mod_gml_region_resize(_frl__region=undefined, _frl__width=undefined, _frl__height=undefined) {
if (((_frl__width < 1) || (_frl__height < 1))) {
{
exit;
;
}
}
var _frl__x = _frl__region.x1;
;
var _frl__y = _frl__region.y1;
;
_frl__region.x1 = (_frl__x - floor(((_frl__width - (_frl__region.x2 - _frl__region.x1)) / 2)));
;
_frl__region.y1 = (_frl__y - floor(((_frl__height - (_frl__region.y2 - _frl__region.y1)) / 2)));
;
_frl__region.x2 = (_frl__region.x1 + _frl__width);
;
_frl__region.y2 = (_frl__region.y1 + _frl__height);
;
if (surface_exists(_frl__region.surface)) {
{
surface_resize(_frl__region.surface, _frl__width, _frl__height);
;
}
}
}

// Original custom_options.mod.gml:4027
function fr_custom_options_mod_gml_region_move(_frl__region=undefined, _frl__x=undefined, _frl__y=undefined) {
var _frl__deltaX = (_frl__x - _frl__region.x1);
;
var _frl__deltaY = (_frl__y - _frl__region.y1);
;
var _frl__childCount = _frl__region.child_count;
;
var _frl_i = (- 1);
;
if ((_frl__childCount > 0)) {
{
repeat (_frl__childCount) {
_frl_i += 1;
;
fr_custom_options_mod_gml_region_move_relative(scrFRIndexGet(_frl__region.children, _frl_i), _frl__deltaX, _frl__deltaY);
;
}
}
}
fr_custom_options_mod_gml_region_move_relative(_frl__region, _frl__deltaX, _frl__deltaY);
;
}

// Original custom_options.mod.gml:4044
function fr_custom_options_mod_gml_region_move_relative(_frl__region=undefined, _frl__shiftX=undefined, _frl__shiftY=undefined) {
_frl__region.x1 += _frl__shiftX;
;
_frl__region.y1 += _frl__shiftY;
;
_frl__region.x2 += _frl__shiftX;
;
_frl__region.y2 += _frl__shiftY;
;
}

// Original custom_options.mod.gml:4050
function fr_custom_options_mod_gml_Region_create() {
var _frl__p = (argument_count>0 ? argument[0] : undefined);
;
var _frl__x = (argument_count>1 ? argument[1] : undefined);
;
var _frl__y = (argument_count>2 ? argument[2] : undefined);
;
var _frl__w = (argument_count>3 ? argument[3] : undefined);
;
var _frl__h = (argument_count>4 ? argument[4] : undefined);
;
var _frl__bgColor = ((argument_count > 5) ? (argument_count>5 ? argument[5] : undefined) : c_silver);
;
var _frl__bgAlpha = ((argument_count > 6) ? (argument_count>6 ? argument[6] : undefined) : 1.0);
;
var _frl__anchor = ((argument_count > 7) ? (argument_count>7 ? argument[7] : undefined) : false);
;
_frl__w = ceil(_frl__w);
;
_frl__h = ceil(_frl__h);
;
if (((_frl__w < 1) || (_frl__h < 1))) {
{
_frl__w = 16;
;
_frl__h = 16;
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FR_OBJECT_GAME)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
persistent = true;
;
name = "Region";
;
draw_synced = false;
;
p = _frl__p;
;
registered_index = (- 1);
;
parent = undefined;
;
anchored_x = _frl__x;
;
anchored_y = _frl__y;
;
x1 = _frl__x;
;
y1 = _frl__y;
;
x2 = (x1 + _frl__w);
;
y2 = (y1 + _frl__h);
;
xscale = 1;
;
yscale = 1;
;
angle = 0;
;
blend = c_white;
;
alpha = 1;
;
bg_color = _frl__bgColor;
;
bg_alpha = _frl__bgAlpha;
;
children = [];
;
child_count = 0;
;
surface = surface_create(_frl__w, _frl__h);
;
on_destroy = ["mod", "custom_options", fr_custom_options_mod_gml_Region_destroy];
;
on_step = ["mod", "custom_options", fr_custom_options_mod_gml_Region_step];
;
on_draw = ["mod", "custom_options", fr_custom_options_mod_gml_Region_draw];
;
on_destroy_internal = ["mod", "custom_options", fr_custom_options_mod_gml_Region_destroy_internal];
;
on_step_internal = ["mod", "custom_options", fr_custom_options_mod_gml_Region_step_internal];
;
on_draw_internal = ["mod", "custom_options", fr_custom_options_mod_gml_Region_draw_internal];
;
if (_frl__anchor) {
{
on_draw_internal = fr_custom_options_mod_gml_script_ref_wrap(["mod", "custom_options", fr_custom_options_mod_gml_Region_anchor], on_draw_internal);
;
}
}
on_input = ["mod", "custom_options", fr_custom_options_mod_gml_Region_input];
;
on_input_internal = ["mod", "custom_options", fr_custom_options_mod_gml_Region_input_internal];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original custom_options.mod.gml:4125
function fr_custom_options_mod_gml_Region_anchor() {
if (scrFRPlayerIsActive(p)) {
{
fr_custom_options_mod_gml_region_move(scrFRSelf(self), (scrFRViewCoordinate(0, p) + anchored_x), (scrFRViewCoordinate(1, p) + anchored_y));
;
}
}
}

// Original custom_options.mod.gml:4130
function fr_custom_options_mod_gml_Region_input() {

}

// Original custom_options.mod.gml:4133
function fr_custom_options_mod_gml_Region_input_internal() {
var _frl_i = (- 1);
;
if ((child_count > 0)) {
{
repeat (child_count) {
_frl_i += 1;
;
if ((_frl_i >= child_count)) {
{
break;
;
}
}
var _frl__child = scrFRIndexGet(children, _frl_i);
;
if ((! scrFRInstanceExists(_frl__child))) {
{
_frl_i -= 1;
;
continue;
;
}
}
if (fr_custom_options_mod_gml_script_ref_call_wc(["mod", "custom_options", fr_custom_options_mod_gml_early_exit, _frl__child.on_input_internal], _frl__child, _frl__child)) {
{
return true;
;
}
}
}
}
}
if (scrFRInstanceExists(scrFRSelf(self))) {
{
return fr_custom_options_mod_gml_early_exit(on_input);
;
}
}
return false;
;
}

// Original custom_options.mod.gml:4163
function fr_custom_options_mod_gml_Region_destroy() {

}

// Original custom_options.mod.gml:4166
function fr_custom_options_mod_gml_Region_destroy_internal() {
var _frl_i = (- 1);
;
if ((child_count > 0)) {
{
repeat (child_count) {
_frl_i += 1;
;
if ((_frl_i >= child_count)) {
{
break;
;
}
}
var _frl__child = scrFRIndexGet(children, _frl_i);
;
if ((! scrFRInstanceExists(_frl__child))) {
{
_frl_i -= 1;
;
continue;
;
}
}
fr_custom_options_mod_gml_script_ref_call_wc(_frl__child.on_destroy_internal, _frl__child, _frl__child);
;
}
}
}
scrFRScriptCall(on_destroy);
;
if (surface_exists(surface)) {
{
surface_free(surface);
;
}
}
scrFRInstanceDestroy();
;
}

// Original custom_options.mod.gml:4196
function fr_custom_options_mod_gml_Region_step() {

}

// Original custom_options.mod.gml:4199
function fr_custom_options_mod_gml_Region_step_internal() {
var _frl_i = (- 1);
;
if ((child_count > 0)) {
{
repeat (child_count) {
_frl_i += 1;
;
if ((_frl_i >= child_count)) {
{
break;
;
}
}
var _frl__child = scrFRIndexGet(children, _frl_i);
;
if ((! scrFRInstanceExists(_frl__child))) {
{
_frl_i -= 1;
;
continue;
;
}
}
fr_custom_options_mod_gml_script_ref_call_wc(_frl__child.on_step_internal, _frl__child, _frl__child);
;
}
}
}
scrFRScriptCall(on_step);
;
}

// Original custom_options.mod.gml:4223
function fr_custom_options_mod_gml_Region_draw() {

}

// Original custom_options.mod.gml:4226
function fr_custom_options_mod_gml_Region_draw_internal() {
var _frl__visible = undefined;
;
if (draw_synced) {
{
_frl__visible = [];
;
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
scrFRIndexPathWrite(_frl__visible, [_frl__p], scrFRDrawGetVisible(_frl__p), "=");
;
scrFRDrawSetVisible(_frl__p, (_frl__p == p));
;
}
}
}
if ((draw_synced || (scrFRPlayerFindLocal() == p))) {
{
if ((! surface_exists(surface))) {
{
surface = surface_create(abs((x2 - x1)), abs((y2 - y1)));
;
}
}
fr_custom_options_mod_gml_surface_target_push(surface);
;
draw_clear_alpha(bg_color, bg_alpha);
;
scrFRScriptCall(on_draw);
;
fr_custom_options_mod_gml_surface_target_pop();
;
fr_custom_options_mod_gml_draw_surface_centered_ext(surface, x1, y1, xscale, yscale, angle, blend, alpha);
;
}
}
var _frl_i = (- 1);
;
if ((child_count > 0)) {
{
repeat (child_count) {
_frl_i += 1;
;
if ((_frl_i >= child_count)) {
{
break;
;
}
}
var _frl__child = scrFRIndexGet(children, _frl_i);
;
if ((! scrFRInstanceExists(_frl__child))) {
{
_frl_i -= 1;
;
continue;
;
}
}
fr_custom_options_mod_gml_script_ref_call_wc(_frl__child.on_draw_internal, _frl__child, _frl__child);
;
}
}
}
if (draw_synced) {
{
var _frl__p = (- 1);
;
repeat (INPUT_MAX_PLAYERS) {
_frl__p += 1;
;
scrFRDrawSetVisible(_frl__p, scrFRIndexGet(_frl__visible, _frl__p));
;
}
}
}
}

// Original custom_options.mod.gml:4297
function fr_custom_options_mod_gml_surface_target_push(_frl__surface=undefined) {
if ((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) > 0)) {
{
surface_reset_target();
;
}
}
ds_list_add(global.fr_module_vars[$ "mod:custom_options"].surface_targets, _frl__surface);
;
surface_set_target(_frl__surface);
;
}

// Original custom_options.mod.gml:4305
function fr_custom_options_mod_gml_surface_target_pop() {
if ((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) > 0)) {
{
var _frl__surface = global.fr_module_vars[$ "mod:custom_options"].surface_targets[|(ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) - 1)];
;
ds_list_delete(global.fr_module_vars[$ "mod:custom_options"].surface_targets, (ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) - 1));
;
surface_reset_target();
;
if ((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) > 0)) {
{
surface_set_target(global.fr_module_vars[$ "mod:custom_options"].surface_targets[|(ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) - 1)]);
;
}
}
return _frl__surface;
;
}
}
return undefined;
;
}

// Original custom_options.mod.gml:4321
function fr_custom_options_mod_gml_surface_target_peek() {
if ((ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) > 0)) {
{
return global.fr_module_vars[$ "mod:custom_options"].surface_targets[|(ds_list_size(global.fr_module_vars[$ "mod:custom_options"].surface_targets) - 1)];
;
}
}
return undefined;
;
}

// Original custom_options.mod.gml:4328
function fr_custom_options_mod_gml_point_in_rotated_rectangle_bbox(_frl__px=undefined, _frl__py=undefined, _frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__x3=undefined, _frl__y3=undefined, _frl__x4=undefined, _frl__y4=undefined) {
return point_in_rectangle(_frl__px, _frl__py, min(_frl__x1, _frl__x2, _frl__x3, _frl__x4), min(_frl__y1, _frl__y2, _frl__y3, _frl__y4), max(_frl__x1, _frl__x2, _frl__x3, _frl__x4), max(_frl__y1, _frl__y2, _frl__y3, _frl__y4));
;
}
