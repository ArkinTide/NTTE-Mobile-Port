#macro frMacro_dependencies_libAreas_mod_gml_scr global.fr_module_vars[$ "mod:libAreas"].scr

#macro frMacro_dependencies_libAreas_mod_gml_call scrFRScriptCall

#macro frMacro_dependencies_libAreas_mod_gml_area_campfire 0

#macro frMacro_dependencies_libAreas_mod_gml_area_desert 1

#macro frMacro_dependencies_libAreas_mod_gml_area_sewers 2

#macro frMacro_dependencies_libAreas_mod_gml_area_scrapyards 3

#macro frMacro_dependencies_libAreas_mod_gml_area_caves 4

#macro frMacro_dependencies_libAreas_mod_gml_area_city 5

#macro frMacro_dependencies_libAreas_mod_gml_area_labs 6

#macro frMacro_dependencies_libAreas_mod_gml_area_palace 7

#macro frMacro_dependencies_libAreas_mod_gml_area_vault 100

#macro frMacro_dependencies_libAreas_mod_gml_area_oasis 101

#macro frMacro_dependencies_libAreas_mod_gml_area_pizza_sewers 102

#macro frMacro_dependencies_libAreas_mod_gml_area_mansion 103

#macro frMacro_dependencies_libAreas_mod_gml_area_cursed_caves 104

#macro frMacro_dependencies_libAreas_mod_gml_area_jungle 105

#macro frMacro_dependencies_libAreas_mod_gml_area_hq 106

#macro frMacro_dependencies_libAreas_mod_gml_area_crib 107

#macro frMacro_dependencies_libAreas_mod_gml_infinity (1 / 0)

#macro frMacro_dependencies_libAreas_mod_gml_mod_current_type scrFRIndexGet(["mod", "libAreas", 0], 0)

#macro frMacro_dependencies_libAreas_mod_gml_instance_max scrFRInstanceCreate(0, 0, FRMarker)

#macro frMacro_dependencies_libAreas_mod_gml_current_frame_active ((scrFRSourceFrame() % 1) < scrFRSourceScale())

#macro frMacro_dependencies_libAreas_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_dependencies_libAreas_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_dependencies_libAreas_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

#macro frMacro_dependencies_libAreas_mod_gml_bbox_width ((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1) - bbox_left)

#macro frMacro_dependencies_libAreas_mod_gml_bbox_height ((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1) - bbox_top)

#macro frMacro_dependencies_libAreas_mod_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

// Original dependencies/libAreas.mod.gml:1
function fr_dependencies_libAreas_mod_gml___load() {

}

// Original dependencies/libAreas.mod.gml:39
function fr_dependencies_libAreas_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libAreas", _frl_name]);
;
}

// Original dependencies/libAreas.mod.gml:42
function fr_dependencies_libAreas_mod_gml_init() {
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: area_campfire
; // macro hoisted: area_desert
; // macro hoisted: area_sewers
; // macro hoisted: area_scrapyards
; // macro hoisted: area_caves
; // macro hoisted: area_city
; // macro hoisted: area_labs
; // macro hoisted: area_palace
; // macro hoisted: area_vault
; // macro hoisted: area_oasis
; // macro hoisted: area_pizza_sewers
; // macro hoisted: area_mansion
; // macro hoisted: area_cursed_caves
; // macro hoisted: area_jungle
; // macro hoisted: area_hq
; // macro hoisted: area_crib
; // macro hoisted: infinity
; // macro hoisted: mod_current_type
; // macro hoisted: instance_max
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
; // macro hoisted: bbox_center_x
; // macro hoisted: bbox_center_y
; // macro hoisted: bbox_width
; // macro hoisted: bbox_height
; // macro hoisted: FloorNormal
fr_dependencies_libAreas_mod_gml_addScript("floor_fill");
;
fr_dependencies_libAreas_mod_gml_addScript("area_generate");
;
fr_dependencies_libAreas_mod_gml_addScript("area_set");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_name");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_subarea");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_secret");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_underwater");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_back_color");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_shad_color");
;
fr_dependencies_libAreas_mod_gml_addScript("area_get_sprite");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_walls");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_bones");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_set_style");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_reset_style");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_set_align");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_reset_align");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_align");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_align_round");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_set");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_delete");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_tunnel");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_room_start");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_room_create");
;
fr_dependencies_libAreas_mod_gml_addScript("floor_room");
;
fr_dependencies_libAreas_mod_gml_addScript("wall_clear");
;
fr_dependencies_libAreas_mod_gml_addScript("wall_delete");
;
fr_dependencies_libAreas_mod_gml_addScript("wall_tops");
;
fr_dependencies_libAreas_mod_gml_addScript("wall_update");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libAreas"].isLoaded = true;
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libAreas", "scr");
;
fr_dependencies_libAreas_mod_gml_floor_reset_style();
;
fr_dependencies_libAreas_mod_gml_floor_reset_align();
;
}

// Original dependencies/libAreas.mod.gml:117
function fr_dependencies_libAreas_mod_gml_floor_fill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined, _frl__type=undefined) {
var _frl__ow = 32;
var _frl__oh = 32;
;
_frl__w *= _frl__ow;
;
_frl__h *= _frl__oh;
;
_frl__x -= (_frl__w / 2);
;
_frl__y -= (_frl__h / 2);
;
var _frl__gridPos = fr_dependencies_libAreas_mod_gml_floor_align(_frl__x, _frl__y, _frl__w, _frl__h, _frl__type);
;
_frl__x = scrFRIndexGet(_frl__gridPos, 0);
;
_frl__y = scrFRIndexGet(_frl__gridPos, 1);
;
var _frl__ax = global.fr_module_vars[$ "mod:libAreas"].floor_align_x;
var _frl__ay = global.fr_module_vars[$ "mod:libAreas"].floor_align_y;
var _frl__aw = global.fr_module_vars[$ "mod:libAreas"].floor_align_w;
var _frl__ah = global.fr_module_vars[$ "mod:libAreas"].floor_align_h;
var _frl__inst = [];
;
fr_dependencies_libAreas_mod_gml_floor_set_align(_frl__x, _frl__y, _frl__ow, _frl__oh);
;
{
var _frl__oy = 0;
for (; (_frl__oy < _frl__h); _frl__oy += _frl__oh) {
{
var _frl__ox = 0;
for (; (_frl__ox < _frl__w); _frl__ox += _frl__ow) {
var _frl__make = true;
;
{ var __fr_switch_value1=_frl__type, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("round")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("ring")) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
_frl__make = (((_frl__ox != 0) && (_frl__ox != (_frl__w - _frl__ow))) || ((_frl__oy != 0) && (_frl__oy != (_frl__h - _frl__oh))));
;
break;
;
case 1:
_frl__make = ((((_frl__ox == 0) || (_frl__oy == 0)) || (_frl__ox == (_frl__w - _frl__ow))) || (_frl__oy == (_frl__h - _frl__oh)));
;
break;
;
}
}
if (_frl__make) {
{
array_push(_frl__inst, fr_dependencies_libAreas_mod_gml_floor_set((_frl__x + _frl__ox), (_frl__y + _frl__oy), true));
;
}
}
}
}
}
}
fr_dependencies_libAreas_mod_gml_floor_set_align(_frl__ax, _frl__ay, _frl__aw, _frl__ah);
;
return _frl__inst;
;
}

// Original dependencies/libAreas.mod.gml:188
function fr_dependencies_libAreas_mod_gml_area_generate() { return scrFRAreaGenerate((argument_count>0 ? argument[0] : undefined),(argument_count>1 ? argument[1] : undefined),(argument_count>2 ? argument[2] : undefined),(argument_count>3 ? argument[3] : undefined),(argument_count>4 ? argument[4] : undefined),(argument_count>5 ? argument[5] : undefined),(argument_count>6 ? argument[6] : undefined),(argument_count>7 ? argument[7] : undefined)); }

// Original dependencies/libAreas.mod.gml:534
function fr_dependencies_libAreas_mod_gml_area_set() { return scrFRAreaSet((argument_count>0 ? argument[0] : undefined),(argument_count>1 ? argument[1] : undefined),(argument_count>2 ? argument[2] : undefined)); }

// Original dependencies/libAreas.mod.gml:561
function fr_dependencies_libAreas_mod_gml_area_get_name(_frl__area=undefined, _frl__subarea=undefined, _frl__loops=undefined) {
var _frl__name = [_frl__area, "-", _frl__subarea];
;
if (scrFRSourceAreaIsString(_frl__area)) {
{
_frl__name = ["MOD"];
;
if (scrFRScriptExists("area", _frl__area, "area_name")) {
{
var _frl__custom = scrFRModCall("area", _frl__area, "area_name", _frl__subarea, _frl__loops);
;
if (is_string(_frl__custom)) {
{
_frl__name = [_frl__custom];
;
}
}
}
} else {
{
_frl__name = [_frl__area, "-", _frl__subarea];
;
}
}
}
} else {
if (fr_dependencies_libAreas_mod_gml_area_get_secret(_frl__area)) {
{
{ var __fr_switch_value1=_frl__area, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(frMacro_dependencies_libAreas_mod_gml_area_vault)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(frMacro_dependencies_libAreas_mod_gml_area_hq)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(frMacro_dependencies_libAreas_mod_gml_area_crib)) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=3;
switch(__fr_switch_case2) {
case 0:
_frl__name = ["???"];
;
break;
;
case 1:
_frl__name = ["HQ", _frl__subarea];
;
break;
;
case 2:
_frl__name = ["$$$"];
;
break;
;
case 3:
_frl__name = [(_frl__area - 100), "-?"];
;
}
}
}
}
}
if ((GameCont.win == true)) {
{
if (((_frl__area == frMacro_dependencies_libAreas_mod_gml_area_palace) || (_frl__area == frMacro_dependencies_libAreas_mod_gml_area_hq))) {
{
_frl__name = ["END", (fr_dependencies_libAreas_mod_gml_area_get_secret(_frl__area) ? 2 : 1)];
;
}
}
}
}
if ((real(_frl__loops) > 0)) {
{
array_push(_frl__name, (" " + ((UberCont.hardmode == true) ? "H" : "L")));
;
array_push(_frl__name, _frl__loops);
;
}
}
var _frl__text = "";
;
{ var __fr_with3 = scrFRWithValues(_frl__name), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
_frl__text += ((is_real(scrFRSelf(self)) && (frac(scrFRSelf(self)) != 0)) ? string_format(scrFRSelf(self), 0, 2) : string(scrFRSelf(self)));
;
}
}
if(__fr_break5) break;
}}
return _frl__text;
;
}

// Original dependencies/libAreas.mod.gml:616
function fr_dependencies_libAreas_mod_gml_area_get_subarea(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_subarea";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
} else {
{
scrFRTrace(((_frl__area + " does not have ") + _frl__scrt));
;
return 3;
;
}
}
}
} else {
if (scrFRSourceAreaIsReal(_frl__area)) {
{
if ((_frl__area == frMacro_dependencies_libAreas_mod_gml_area_hq)) {
return 3;
}
if ((_frl__area >= 100)) {
return 1;
}
if (((_frl__area % 2) == 0)) {
return 1;
}
return 3;
;
}
}
}
return 1;
;
}

// Original dependencies/libAreas.mod.gml:646
function fr_dependencies_libAreas_mod_gml_area_get_secret(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_secret";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
} else {
{
scrFRTrace(((_frl__area + " does not have ") + _frl__scrt));
;
return 0;
;
}
}
}
} else {
if (scrFRSourceAreaIsReal(_frl__area)) {
{
return (_frl__area >= 100);
;
}
}
}
return false;
;
}

// Original dependencies/libAreas.mod.gml:676
function fr_dependencies_libAreas_mod_gml_area_get_underwater(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_underwater";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
} else {
{
scrFRTrace(((_frl__area + " does not have ") + _frl__scrt));
;
return 0;
;
}
}
}
}
return (_frl__area == frMacro_dependencies_libAreas_mod_gml_area_oasis);
;
}

// Original dependencies/libAreas.mod.gml:695
function fr_dependencies_libAreas_mod_gml_area_get_back_color(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_background_color";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
} else {
{
scrFRTrace(((_frl__area + " does not have ") + _frl__scrt));
;
return c_black;
;
}
}
}
}
return scrAreaGetBackroundColor(_frl__area);
;
}

// Original dependencies/libAreas.mod.gml:714
function fr_dependencies_libAreas_mod_gml_area_get_shad_color(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_shadow_color";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
} else {
{
scrFRTrace(((_frl__area + " does not have ") + _frl__scrt));
;
return c_black;
;
}
}
}
}
return scrAreaGetShadowColor(_frl__area);
;
}

// Original dependencies/libAreas.mod.gml:733
function fr_dependencies_libAreas_mod_gml_area_get_sprite(_frl__area=undefined, _frl__spr=undefined) {
if ((! scrFRModExists("mod", "libAreas", "area_sprite_map"))) {
{
var _frl__map = ds_map_create();
;
_frl__map[?0] = [sprFloor0, sprFloor0, sprFloor0Explo, sprWall0Trans, sprWall0Bot, sprWall0Out, sprWall0Top, sprDebris0, sprDetail0, sprNightBones, sprNightDesertTopDecal];
;
_frl__map[?1] = [sprFloor1, sprFloor1B, sprFloor1Explo, sprWall1Trans, sprWall1Bot, sprWall1Out, sprWall1Top, sprDebris1, sprDetail1, sprBones, sprDesertTopDecal];
;
_frl__map[?2] = [sprFloor2, sprFloor2B, sprFloor2Explo, sprWall2Trans, sprWall2Bot, sprWall2Out, sprWall2Top, sprDebris2, sprDetail2, sprSewerDecal, sprTopDecalSewers];
;
_frl__map[?3] = [sprFloor3, sprFloor3B, sprFloor3Explo, sprWall3Trans, sprWall3Bot, sprWall3Out, sprWall3Top, sprDebris3, sprDetail3, sprScrapDecal, sprTopDecalScrapyard];
;
_frl__map[?4] = [sprFloor4, sprFloor4B, sprFloor4Explo, sprWall4Trans, sprWall4Bot, sprWall4Out, sprWall4Top, sprDebris4, sprDetail4, sprCaveDecal, sprTopDecalCave];
;
_frl__map[?5] = [sprFloor5, sprFloor5B, sprFloor5Explo, sprWall5Trans, sprWall5Bot, sprWall5Out, sprWall5Top, sprDebris5, sprDetail5, sprIceDecal, sprTopDecalCity];
;
_frl__map[?6] = [sprFloor6, sprFloor6B, sprFloor6Explo, sprWall6Trans, sprWall6Bot, sprWall6Out, sprWall6Top, sprDebris6, sprDetail6, (- 1), (- 1)];
;
_frl__map[?7] = [sprFloor7, sprFloor7B, sprFloor7Explo, sprWall7Trans, sprWall7Bot, sprWall7Out, sprWall7Top, sprDebris7, (- 1), (- 1), sprPalaceTopDecal];
;
_frl__map[?100] = [sprFloor100, sprFloor100B, sprFloor100Explo, sprWall100Trans, sprWall100Bot, sprWall100Out, sprWall100Top, sprDebris100, (- 1), (- 1), (- 1)];
;
_frl__map[?101] = [sprFloor101, sprFloor101B, sprFloor101Explo, sprWall101Trans, sprWall101Bot, sprWall101Out, sprWall101Top, sprDebris101, sprDetail101, sprCoral, (- 1)];
;
_frl__map[?102] = [sprFloor102, sprFloor102B, sprFloor102Explo, sprWall102Trans, sprWall102Bot, sprWall102Out, sprWall102Top, sprDebris102, sprDetail102, sprPizzaSewerDecal, sprTopDecalPizzaSewers];
;
_frl__map[?103] = [sprFloor103, sprFloor103B, sprFloor103Explo, sprWall103Trans, sprWall103Bot, sprWall103Out, sprWall103Top, sprDebris103, (- 1), (- 1), (- 1)];
;
_frl__map[?104] = [sprFloor104, sprFloor104B, sprFloor104Explo, sprWall104Trans, sprWall104Bot, sprWall104Out, sprWall104Top, sprDebris104, sprDetail104, sprInvCaveDecal, sprTopDecalInvCave];
;
_frl__map[?105] = [sprFloor105, sprFloor105B, sprFloor105Explo, sprWall105Trans, sprWall105Bot, sprWall105Out, sprWall105Top, sprDebris105, (- 1), sprJungleDecal, sprTopDecalJungle];
;
_frl__map[?106] = [sprFloor106, sprFloor106B, sprFloor106Explo, sprWall106Trans, sprWall106Bot, sprWall106Out, sprWall106Top, sprDebris106, (- 1), (- 1), sprTopPot];
;
_frl__map[?107] = [sprFloor107, sprFloor107B, sprFloor107Explo, sprWall107Trans, sprWall107Bot, sprWall107Out, sprWall107Top, sprDebris107, (- 1), (- 1), (- 1)];
;
global.fr_module_vars[$ "mod:libAreas"].area_sprite_map = _frl__map;
;
}
}
if (sprite_exists(_frl__spr)) {
{
{ var __fr_with1 = scrFRWithValues(ds_map_values_to_array(global.fr_module_vars[$ "mod:libAreas"].area_sprite_map)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl_i = scrFRArrayFindIndex(scrFRSelf(self), _frl__spr);
;
if ((_frl_i >= 0)) {
{
_frl__spr = scrFRIndexGet(global.fr_module_vars[$ "mod:libAreas"].area_sprite_map[?1], _frl_i);
;
if ((_frl__spr == sprDesertTopDecal)) {
_frl__spr = sprTopPot;
}
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
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl_s = scrFRModCall("area", _frl__area, "area_sprite", _frl__spr);
;
if (((_frl_s != 0) && is_real(_frl_s))) {
{
return _frl_s;
;
}
}
}
}
if (ds_map_exists(global.fr_module_vars[$ "mod:libAreas"].area_sprite_map, _frl__area)) {
{
var _frl__list = global.fr_module_vars[$ "mod:libAreas"].area_sprite_map[?_frl__area];
var _frl_i = scrFRArrayFindIndex(global.fr_module_vars[$ "mod:libAreas"].area_sprite_map[?1], _frl__spr);
;
if (((_frl_i >= 0) && (_frl_i < array_length(_frl__list)))) {
{
return scrFRIndexGet(_frl__list, _frl_i);
;
}
}
}
}
return (- 1);
;
}

// Original dependencies/libAreas.mod.gml:797
function fr_dependencies_libAreas_mod_gml_floor_walls() {
var _frl__x1 = (bbox_left - 16);
var _frl__y1 = (bbox_top - 16);
var _frl__x2 = ((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 16) + 1);
var _frl__y2 = ((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 16) + 1);
var _frl__minID = frMacro_dependencies_libAreas_mod_gml_instance_max;
;
{
var _frl__x = _frl__x1;
for (; (_frl__x < _frl__x2); _frl__x += 16) {
{
var _frl__y = _frl__y1;
for (; (_frl__y < _frl__y2); _frl__y += 16) {
if (((((_frl__x == _frl__x1) || (_frl__y == _frl__y1)) || (_frl__x == (_frl__x2 - 16))) || (_frl__y == (_frl__y2 - 16)))) {
{
if ((! position_meeting(_frl__x, _frl__y, Floor))) {
{
scrFRInstanceCreate(_frl__x, _frl__y, Wall);
;
}
}
}
}
}
}
}
}
return _frl__minID;
;
}

// Original dependencies/libAreas.mod.gml:816
function fr_dependencies_libAreas_mod_gml_floor_bones(_frl__num=undefined, _frl__chance=undefined, _frl__linked=undefined) {
var _frl__inst = [];
;
if ((! collision_rectangle((bbox_left - 16), bbox_top, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 16), scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom"), Floor, false, true))) {
{
{
var _frl__y = bbox_top;
for (; (_frl__y < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1)); _frl__y += (32 / _frl__num)) {
var _frl__create = true;
;
{
var _frl__side = 0;
for (; (_frl__side <= 1); _frl__side++) {
if (((_frl__side == 0) || (! _frl__linked))) {
{
_frl__create = (scrFRSourceRandom(1) < _frl__chance);
;
}
}
if (_frl__create) {
{
var _frl__x = lerp(bbox_left, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1), _frl__side);
;
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.obj_create, _frl__x, _frl__y, "WallDecal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = ((_frl__side > 0.5) ? (- 1) : 1);
;
array_push(_frl__inst, scrFRSelf(self));
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
return _frl__inst;
;
}

// Original dependencies/libAreas.mod.gml:854
function fr_dependencies_libAreas_mod_gml_floor_set_style(_frl__style=undefined, _frl__area=undefined) {
global.fr_module_vars[$ "mod:libAreas"].floor_style = _frl__style;
;
global.fr_module_vars[$ "mod:libAreas"].floor_area = _frl__area;
;
}

// Original dependencies/libAreas.mod.gml:858
function fr_dependencies_libAreas_mod_gml_floor_reset_style() {
fr_dependencies_libAreas_mod_gml_floor_set_style(undefined, undefined);
;
}

// Original dependencies/libAreas.mod.gml:861
function fr_dependencies_libAreas_mod_gml_floor_set_align(_frl__alignX=undefined, _frl__alignY=undefined, _frl__alignW=undefined, _frl__alignH=undefined) {
global.fr_module_vars[$ "mod:libAreas"].floor_align_x = _frl__alignX;
;
global.fr_module_vars[$ "mod:libAreas"].floor_align_y = _frl__alignY;
;
global.fr_module_vars[$ "mod:libAreas"].floor_align_w = _frl__alignW;
;
global.fr_module_vars[$ "mod:libAreas"].floor_align_h = _frl__alignH;
;
}

// Original dependencies/libAreas.mod.gml:867
function fr_dependencies_libAreas_mod_gml_floor_reset_align() {
fr_dependencies_libAreas_mod_gml_floor_set_align(undefined, undefined, undefined, undefined);
;
}

// Original dependencies/libAreas.mod.gml:870
function fr_dependencies_libAreas_mod_gml_floor_align(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined, _frl__type=undefined) {
var _frl__gridXAuto = is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_align_x);
var _frl__gridYAuto = is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_align_y);
var _frl__gridWAuto = is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_align_w);
var _frl__gridHAuto = is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_align_h);
var _frl__gridX = (_frl__gridXAuto ? 10000 : global.fr_module_vars[$ "mod:libAreas"].floor_align_x);
var _frl__gridY = (_frl__gridYAuto ? 10000 : global.fr_module_vars[$ "mod:libAreas"].floor_align_y);
var _frl__gridW = (_frl__gridWAuto ? 16 : global.fr_module_vars[$ "mod:libAreas"].floor_align_w);
var _frl__gridH = (_frl__gridHAuto ? 16 : global.fr_module_vars[$ "mod:libAreas"].floor_align_h);
var _frl__gridXBias = 0;
var _frl__gridYBias = 0;
;
if ((((_frl__gridXAuto || _frl__gridYAuto) || _frl__gridWAuto) || _frl__gridHAuto)) {
{
if ((! scrFRInstanceExists(FloorMaker))) {
{
if ((_frl__gridXAuto || _frl__gridYAuto)) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_nearest_rectangle_bbox, _frl__x, _frl__y, (_frl__x + _frl__w), (_frl__y + _frl__h), Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (_frl__gridXAuto) {
{
_frl__gridX = x;
;
_frl__gridXBias = (frMacro_dependencies_libAreas_mod_gml_bbox_center_x - (_frl__x + (_frl__w / 2)));
;
}
}
if (_frl__gridYAuto) {
{
_frl__gridY = y;
;
_frl__gridYBias = (frMacro_dependencies_libAreas_mod_gml_bbox_center_y - (_frl__y + (_frl__h / 2)));
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
var _frl__fx = (_frl__gridX + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__x - _frl__gridX), _frl__gridW, _frl__gridXBias));
var _frl__fy = (_frl__gridY + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__y - _frl__gridY), _frl__gridH, _frl__gridYBias));
var _frl__fwMax = _frl__gridW;
var _frl__fhMax = _frl__gridH;
;
{ var __fr_with4 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, _frl__fx, _frl__fy, ((_frl__fx + _frl__w) - 1), ((_frl__fy + _frl__h) - 1), Floor)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__fw = frMacro_dependencies_libAreas_mod_gml_bbox_width;
var _frl__fh = frMacro_dependencies_libAreas_mod_gml_bbox_height;
;
if ((_frl__fw >= _frl__fwMax)) {
{
_frl__fwMax = _frl__fw;
;
if (_frl__gridWAuto) {
{
_frl__gridW = _frl__fwMax;
;
}
}
if (_frl__gridXAuto) {
{
_frl__gridX = x;
;
_frl__gridXBias = (frMacro_dependencies_libAreas_mod_gml_bbox_center_x - (_frl__x + (_frl__w / 2)));
;
}
}
}
}
if ((_frl__fh >= _frl__fhMax)) {
{
_frl__fhMax = _frl__fh;
;
if (_frl__gridHAuto) {
{
_frl__gridH = _frl__fhMax;
;
}
}
if (_frl__gridYAuto) {
{
_frl__gridY = y;
;
_frl__gridYBias = (frMacro_dependencies_libAreas_mod_gml_bbox_center_y - (_frl__y + (_frl__h / 2)));
;
}
}
}
}
}
}
if(__fr_break6) break;
}}
if (((_frl__gridXBias != 0) || (_frl__gridYBias != 0))) {
{
_frl__fx = (_frl__gridX + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__x - _frl__gridX), _frl__gridW, 0));
;
_frl__fy = (_frl__gridY + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__y - _frl__gridY), _frl__gridH, 0));
;
if (((_frl__type == "round") ? (collision_rectangle((_frl__fx + 32), _frl__fy, (((_frl__fx + _frl__w) - 32) - 1), ((_frl__fy + _frl__h) - 1), Floor, false, false) || collision_rectangle(_frl__fx, (_frl__fy + 32), ((_frl__fx + _frl__w) - 1), (((_frl__fy + _frl__h) - 32) - 1), Floor, false, false)) : collision_rectangle(_frl__fx, _frl__fy, ((_frl__fx + _frl__w) - 1), ((_frl__fy + _frl__h) - 1), Floor, false, false))) {
{
_frl__gridXBias = 0;
;
_frl__gridYBias = 0;
;
}
}
}
}
}
} else {
{ var __fr_with7 = scrFRWithValues(instance_nearest((_frl__x + max(0, ((_frl__w / 2) - 16))), (_frl__y + max(0, ((_frl__h / 2) - 16))), FloorMaker)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (_frl__gridXAuto) {
_frl__gridX = x;
}
if (_frl__gridYAuto) {
_frl__gridY = y;
}
if (_frl__gridWAuto) {
_frl__gridW = min(_frl__w, 32);
}
if (_frl__gridHAuto) {
_frl__gridH = min(_frl__h, 32);
}
}
}
if(__fr_break9) break;
}}
}
}
}
return [(_frl__gridX + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__x - _frl__gridX), _frl__gridW, _frl__gridXBias)), (_frl__gridY + fr_dependencies_libAreas_mod_gml_floor_align_round((_frl__y - _frl__gridY), _frl__gridH, _frl__gridYBias))];
;
}

// Original dependencies/libAreas.mod.gml:968
function fr_dependencies_libAreas_mod_gml_floor_align_round(_frl__num=undefined, _frl__precision=undefined, _frl__bias=undefined) {
var _frl__value = _frl__num;
;
if ((_frl__precision != 0)) {
{
_frl__value /= _frl__precision;
;
if ((_frl__bias < 0)) {
{
_frl__value = floor(_frl__value);
;
}
} else {
if (((_frl__bias > 0) || (frac(_frl__value) == 0.5))) {
{
_frl__value = ceil(_frl__value);
;
}
} else {
{
_frl__value = round(_frl__value);
;
}
}
}
_frl__value *= _frl__precision;
;
}
}
return _frl__value;
;
}

// Original dependencies/libAreas.mod.gml:987
function fr_dependencies_libAreas_mod_gml_floor_set(_frl__x=undefined, _frl__y=undefined, _frl__state=undefined) {
var _frl__inst = noone;
;
if (_frl__state) {
{
var _frl__obj = ((_frl__state >= 2) ? FloorExplo : Floor);
var _frl__msk = object_get_mask(_frl__obj);
var _frl__w = ((sprite_get_bbox_right(_frl__msk) + 1) - sprite_get_bbox_left(_frl__msk));
var _frl__h = ((sprite_get_bbox_bottom(_frl__msk) + 1) - sprite_get_bbox_top(_frl__msk));
;
var _frl__gridPos = fr_dependencies_libAreas_mod_gml_floor_align(_frl__x, _frl__y, _frl__w, _frl__h, "");
;
_frl__x = scrFRIndexGet(_frl__gridPos, 0);
;
_frl__y = scrFRIndexGet(_frl__gridPos, 1);
;
if ((! scrFRInstanceExists(FloorMaker))) {
{
if ((_frl__obj == FloorExplo)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(_frl__obj, "x", _frl__x), "y", _frl__y)), __fr_break3=false;
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
} else {
{
fr_dependencies_libAreas_mod_gml_floor_delete(_frl__x, _frl__y, ((_frl__x + _frl__w) - 1), ((_frl__y + _frl__h) - 1));
;
}
}
}
}
var _frl__floormaker = noone;
var _frl__lastArea = GameCont.area;
;
if ((! is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_style))) {
{
GameCont.area = scrFRAreaResolve(frMacro_dependencies_libAreas_mod_gml_area_campfire);
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FloorMaker)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRMatchingGT(Floor, "id", real(id))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break9) break;
}}
styleb = global.fr_module_vars[$ "mod:libAreas"].floor_style;
;
_frl__floormaker = scrFRSelf(self);
;
}
}
if(__fr_break6) break;
}}
GameCont.area = scrFRAreaResolve(_frl__lastArea);
;
}
}
if ((! is_undefined(global.fr_module_vars[$ "mod:libAreas"].floor_area))) {
{
GameCont.area = scrFRAreaResolve(global.fr_module_vars[$ "mod:libAreas"].floor_area);
;
}
}
_frl__inst = scrFRInstanceCreate(_frl__x, _frl__y, _frl__obj);
;
{ var __fr_with10 = scrFRWithValues(_frl__floormaker), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
scrFRInstanceDestroy();
}
if(__fr_break12) break;
}}
;
GameCont.area = scrFRAreaResolve(_frl__lastArea);
;
{ var __fr_with13 = scrFRWithValues(_frl__inst), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((! scrFRInstanceExists(FloorMaker))) {
{
fr_dependencies_libAreas_mod_gml_wall_delete(bbox_left, bbox_top, scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right"), scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom"));
;
if (frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.chance, 1, 6)) {
{
scrFRInstanceCreate(scrFRSourceRandomRange(bbox_left, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1)), scrFRSourceRandomRange(bbox_top, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1)), Detail);
;
}
}
}
}
if (scrFRInstanceExists(Wall)) {
{
fr_dependencies_libAreas_mod_gml_floor_walls();
;
fr_dependencies_libAreas_mod_gml_wall_update((bbox_left - 16), (bbox_top - 16), (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 16), (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 16));
;
}
}
}
}
if(__fr_break15) break;
}}
}
} else {
{ var __fr_with16 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instances_at, _frl__x, _frl__y, Floor)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
var _frl__x1 = (bbox_left - 16);
var _frl__y1 = (bbox_top - 16);
var _frl__x2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 16);
var _frl__y2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 16);
;
{ var __fr_with19 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instances_meeting, x, y, SnowFloor)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
if (point_in_rectangle(frMacro_dependencies_libAreas_mod_gml_bbox_center_x, frMacro_dependencies_libAreas_mod_gml_bbox_center_y, (scrFROther(other)).bbox_left, (scrFROther(other)).bbox_top, (scrFRSourceBBoxRead((scrFROther(other)), "bbox_right") + 1), (scrFRSourceBBoxRead((scrFROther(other)), "bbox_bottom") + 1))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break21) break;
}}
scrFRInstanceDestroy();
;
if (scrFRInstanceExists(Wall)) {
{
{ var __fr_with22 = scrFRWithValues((scrFROther(other))), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
fr_dependencies_libAreas_mod_gml_wall_delete(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
{
var _frl__fx = _frl__x1;
for (; (_frl__fx < (_frl__x2 + 1)); _frl__fx += 16) {
{
var _frl__fy = _frl__y1;
for (; (_frl__fy < (_frl__y2 + 1)); _frl__fy += 16) {
if ((! position_meeting(_frl__fx, _frl__fy, Floor))) {
{
if (collision_rectangle((_frl__fx - 16), (_frl__fy - 16), (_frl__fx + 31), (_frl__fy + 31), Floor, false, false)) {
{
scrFRInstanceCreate(_frl__fx, _frl__fy, Wall);
;
}
}
}
}
}
}
}
}
fr_dependencies_libAreas_mod_gml_wall_update((_frl__x1 - 16), (_frl__y1 - 16), (_frl__x2 + 16), (_frl__y2 + 16));
;
}
}
if(__fr_break24) break;
}}
}
}
}
}
if(__fr_break18) break;
}}
}
return _frl__inst;
;
}

// Original dependencies/libAreas.mod.gml:1093
function fr_dependencies_libAreas_mod_gml_floor_delete(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, _frl__x1, _frl__y1, _frl__x2, _frl__y2, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{
var _frl__x = bbox_left;
for (; (_frl__x < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1)); _frl__x += 16) {
{
var _frl__y = bbox_top;
for (; (_frl__y < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1)); _frl__y += 16) {
if (((! rectangle_in_rectangle(_frl__x, _frl__y, (_frl__x + 15), (_frl__y + 15), _frl__x1, _frl__y1, _frl__x2, _frl__y2)) && (! collision_rectangle(_frl__x, _frl__y, (_frl__x + 15), (_frl__y + 15), Floor, false, true)))) {
{
var _frl__shake = UberCont.opt_shake;
var _frl__sleep = UberCont.opt_freeze;
var _frl__sound = scrFRSoundPitchVolume(0, 0, 0);
;
UberCont.opt_shake = 0;
;
UberCont.opt_freeze = 0;
;
{ var __fr_with4 = scrFRWithValues(scrFRMatchingGT(FR_OBJECT_GAME, "id", scrFRInstanceCreate(_frl__x, _frl__y, FloorExplo))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
UberCont.opt_shake = _frl__shake;
;
UberCont.opt_freeze = _frl__sleep;
;
{
var _frl_i = _frl__sound;
for (; audio_is_playing(_frl_i); _frl_i++) {
scrFRSoundStop(_frl_i);
;
}
}
}
}
}
}
}
}
{ var __fr_with7 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle, bbox_left, bbox_top, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1), (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1), Detail)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instances_meeting, x, y, SnowFloor)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (point_in_rectangle(frMacro_dependencies_libAreas_mod_gml_bbox_center_x, frMacro_dependencies_libAreas_mod_gml_bbox_center_y, (scrFROther(other)).bbox_left, (scrFROther(other)).bbox_top, (scrFRSourceBBoxRead((scrFROther(other)), "bbox_right") + 1), (scrFRSourceBBoxRead((scrFROther(other)), "bbox_bottom") + 1))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break12) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libAreas.mod.gml:1136
function fr_dependencies_libAreas_mod_gml_floor_tunnel(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x1, _frl__y1, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__dis = point_distance(x, y, _frl__x2, _frl__y2);
var _frl__dir = point_direction(x, y, _frl__x2, _frl__y2);
;
sprite_index = scrFRAreaSourceSprite(sprBoltTrail);
;
image_speed = ((16 / _frl__dis)) * timescale;
;
image_xscale = _frl__dis;
;
image_yscale = 16;
;
image_angle = _frl__dir;
;
if (((scrFRInstanceExists(Wall) && (! scrFRPlaceMeeting(x, y, Wall))) && (! scrFRPlaceMeeting(x, y, Floor)))) {
{
{ var __fr_with4 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_nearest_bbox, x, y, Wall)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
scrFRInstanceCreate((x + frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.pfloor, (__fr_other7.x - x), 16)), (y + frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.pfloor, (__fr_other7.y - y), 16)), Wall);
;
}
}
if(__fr_break6) break;
}}
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

// Original dependencies/libAreas.mod.gml:1164
function fr_dependencies_libAreas_mod_gml_floor_room_start(_frl__spawnX=undefined, _frl__spawnY=undefined, _frl__spawnDis=undefined, _frl__spawnFloor=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.array_shuffle, scrFRMatchingNE(_frl__spawnFloor, "id", undefined))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__x = frMacro_dependencies_libAreas_mod_gml_bbox_center_x;
var _frl__y = frMacro_dependencies_libAreas_mod_gml_bbox_center_y;
;
if ((point_distance(_frl__spawnX, _frl__spawnY, _frl__x, _frl__y) >= _frl__spawnDis)) {
{
var _frl__spawnReached = false;
;
var _frl__pathWall = [Wall, InvisiWall];
;
{
var _frl__fx = bbox_left;
for (; (_frl__fx < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1)); _frl__fx += 16) {
{
var _frl__fy = bbox_top;
for (; (_frl__fy < (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1)); _frl__fy += 16) {
if (frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.path_reaches, frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.path_create, (_frl__fx + 8), (_frl__fy + 8), _frl__spawnX, _frl__spawnY, _frl__pathWall), _frl__spawnX, _frl__spawnY, _frl__pathWall)) {
{
_frl__spawnReached = true;
;
break;
;
}
}
}
}
if (_frl__spawnReached) {
break;
}
}
}
if (_frl__spawnReached) {
{
return {"x": _frl__x, "y": _frl__y, "direction": point_direction(_frl__spawnX, _frl__spawnY, _frl__x, _frl__y), "id": real(id)};
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original dependencies/libAreas.mod.gml:1213
function fr_dependencies_libAreas_mod_gml_floor_room_create(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined, _frl__type=undefined, _frl__dirStart=undefined, _frl__dirOff=undefined, _frl__floorDis=undefined) {
var _frl__move = true;
var _frl__floorAvoid = frMacro_dependencies_libAreas_mod_gml_FloorNormal;
var _frl__dis = 16;
var _frl__dir = 0;
var _frl__ow = ((_frl__w * 32) / 2);
var _frl__oh = ((_frl__h * 32) / 2);
var _frl__sx = _frl__x;
var _frl__sy = _frl__y;
;
if ((! is_array(_frl__dirOff))) {
{
_frl__dirOff = [_frl__dirOff];
;
}
}
while ((array_length(_frl__dirOff) < 2)) {
array_push(_frl__dirOff, 0);
;
}
while (_frl__move) {
var _frl__x1 = (_frl__x - _frl__ow);
var _frl__y1 = (_frl__y - _frl__oh);
var _frl__x2 = (_frl__x + _frl__ow);
var _frl__y2 = (_frl__y + _frl__oh);
var _frl__inst = frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, (_frl__x1 - _frl__floorDis), (_frl__y1 - _frl__floorDis), ((_frl__x2 + _frl__floorDis) - 1), ((_frl__y2 + _frl__floorDis) - 1), _frl__floorAvoid);
;
if (((_frl__type == "round") && (_frl__floorDis <= 0))) {
{
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") < (_frl__x1 + 32)) || (bbox_left >= (_frl__x2 - 32))) && ((scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") < (_frl__y1 + 32)) || (bbox_top >= (_frl__y2 - 32))))) {
{
_frl__inst = frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.array_delete_value, _frl__inst, scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
_frl__move = false;
;
if (array_length(_frl__inst)) {
{
if ((_frl__floorDis <= 0)) {
{
_frl__move = true;
;
}
} else {
{ var __fr_with4 = scrFRWithValues(_frl__inst), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__fx = clamp(_frl__x, bbox_left, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1));
var _frl__fy = clamp(_frl__y, bbox_top, (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1));
var _frl__fDis = ((_frl__type == "round") ? min(point_distance(_frl__fx, _frl__fy, clamp(_frl__fx, (_frl__x1 + 32), (_frl__x2 - 32)), clamp(_frl__fy, _frl__y1, _frl__y2)), point_distance(_frl__fx, _frl__fy, clamp(_frl__fx, _frl__x1, _frl__x2), clamp(_frl__fy, (_frl__y1 + 32), (_frl__y2 - 32)))) : point_distance(_frl__fx, _frl__fy, clamp(_frl__fx, _frl__x1, _frl__x2), clamp(_frl__fy, _frl__y1, _frl__y2)));
;
if ((_frl__fDis < _frl__floorDis)) {
{
_frl__move = true;
;
__fr_break6=true; break;
;
}
}
}
}
if(__fr_break6) break;
}}
}
if (_frl__move) {
{
_frl__dir = frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.pround, (_frl__dirStart + (scrFRSourceRandomRange(scrFRIndexGet(_frl__dirOff, 0), scrFRIndexGet(_frl__dirOff, 1)) * scrFRSourceChoose((- 1), 1))), 90);
;
_frl__x += lengthdir_x(_frl__dis, _frl__dir);
;
_frl__y += lengthdir_y(_frl__dis, _frl__dir);
;
}
}
}
}
}
var _frl__floorNumLast = array_length(frMacro_dependencies_libAreas_mod_gml_FloorNormal);
var _frl__floors = scrFRModCall(frMacro_dependencies_libAreas_mod_gml_mod_current_type, "libAreas", "floor_fill", _frl__x, _frl__y, _frl__w, _frl__h, _frl__type);
var _frl__floorNum = array_length(frMacro_dependencies_libAreas_mod_gml_FloorNormal);
var _frl__x1 = _frl__x;
var _frl__y1 = _frl__y;
var _frl__x2 = _frl__x;
var _frl__y2 = _frl__y;
;
if (array_length(_frl__floors)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRIndexGet(_frl__floors, 0)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
_frl__x1 = bbox_left;
;
_frl__y1 = bbox_top;
;
_frl__x2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + 1);
;
_frl__y2 = (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + 1);
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(_frl__floors), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var _frl__fx1 = bbox_left;
var _frl__fy1 = bbox_top;
var _frl__fx2 = scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right");
var _frl__fy2 = scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom");
;
_frl__x1 = min(_frl__x1, _frl__fx1);
;
_frl__y1 = min(_frl__y1, _frl__fy1);
;
_frl__x2 = max(_frl__x2, (_frl__fx2 + 1));
;
_frl__y2 = max(_frl__y2, (_frl__fy2 + 1));
;
if (((_frl__floorDis <= 0) && (_frl__floorNum == (_frl__floorNumLast + array_length(_frl__floors))))) {
{
{ var __fr_with13 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.array_combine, frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, (_frl__fx1 - 1), _frl__fy1, (_frl__fx2 + 1), _frl__fy2, Wall), frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, _frl__fx1, (_frl__fy1 - 1), _frl__fx2, (_frl__fy2 + 1), Wall))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((scrFRInstanceExists(scrFRSelf(self)) && scrFRPlaceMeeting(x, y, Floor))) {
{
{ var __fr_with16 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instances_meeting, x, y, [Bones, TopPot])), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break18) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break15) break;
}}
}
}
}
}
if(__fr_break12) break;
}}
}
}
return {"floors": _frl__floors, "x": ((_frl__x1 + _frl__x2) / 2), "y": ((_frl__y1 + _frl__y2) / 2), "x1": _frl__x1, "y1": _frl__y1, "x2": _frl__x2, "y2": _frl__y2, "xstart": _frl__sx, "ystart": _frl__sy};
;
}

// Original dependencies/libAreas.mod.gml:1360
function fr_dependencies_libAreas_mod_gml_floor_room(_frl__spawnX=undefined, _frl__spawnY=undefined, _frl__spawnDis=undefined, _frl__spawnFloor=undefined, _frl__w=undefined, _frl__h=undefined, _frl__type=undefined, _frl__dirOff=undefined, _frl__floorDis=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_libAreas_mod_gml_floor_room_start(_frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
return fr_dependencies_libAreas_mod_gml_floor_room_create(x, y, _frl__w, _frl__h, _frl__type, direction, _frl__dirOff, _frl__floorDis);
;
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original dependencies/libAreas.mod.gml:1386
function fr_dependencies_libAreas_mod_gml_wall_clear(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(((__fr_other4.mask_index < 0) ? __fr_other4.sprite_index : __fr_other4.mask_index));
;
var __fr_other5=scrFROther(other);
image_xscale = __fr_other5.image_xscale;
;
var __fr_other6=scrFROther(other);
image_yscale = __fr_other6.image_yscale;
;
var __fr_other7=scrFROther(other);
image_angle = __fr_other7.image_angle;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libAreas.mod.gml:1400
function fr_dependencies_libAreas_mod_gml_wall_delete(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, _frl__x1, _frl__y1, _frl__x2, _frl__y2, [Wall, InvisiWall])), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRMatching(scrFRMatching(TrapScorchMark, "x", x), "y", y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle_bbox, _frl__x1, _frl__y1, _frl__x2, _frl__y2, [TopSmall, TopPot, Bones])), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break9) break;
}}
}

// Original dependencies/libAreas.mod.gml:1415
function fr_dependencies_libAreas_mod_gml_wall_tops() {
var _frl__minID = frMacro_dependencies_libAreas_mod_gml_instance_max;
;
scrFRInstanceCreate((x - 16), (y - 16), Top);
;
scrFRInstanceCreate((x - 16), y, Top);
;
scrFRInstanceCreate(x, (y - 16), Top);
;
scrFRInstanceCreate(x, y, Top);
;
return scrFRMatchingGT(TopSmall, "id", _frl__minID);
;
}

// Original dependencies/libAreas.mod.gml:1429
function fr_dependencies_libAreas_mod_gml_wall_update(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_dependencies_libAreas_mod_gml_call(frMacro_dependencies_libAreas_mod_gml_scr.instance_rectangle, _frl__x1, _frl__y1, _frl__x2, _frl__y2, Wall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
visible = scrFRPlaceMeeting(x, (y + 16), Floor);
;
l = (place_free((x - 16), y) ? 0 : 4);
;
w = ((place_free((x + 16), y) ? 24 : 20) - l);
;
r = (place_free(x, (y - 16)) ? 0 : 4);
;
h = ((place_free(x, (y + 16)) ? 24 : 20) - r);
;
fr_dependencies_libAreas_mod_gml_wall_tops();
;
}
}
if(__fr_break3) break;
}}
; // macro hoisted: scr
; // macro hoisted: call
}
