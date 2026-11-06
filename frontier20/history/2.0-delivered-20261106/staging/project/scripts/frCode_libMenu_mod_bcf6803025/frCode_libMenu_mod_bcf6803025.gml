// Original dependencies/libMenu.mod.gml:1
function fr_dependencies_libMenu_mod_gml___load() {

}

// Original dependencies/libMenu.mod.gml:13
function fr_dependencies_libMenu_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libMenu", _frl_name]);
;
}

// Original dependencies/libMenu.mod.gml:16
function fr_dependencies_libMenu_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libMenu_mod_gml_init_resume, id, scrFROther(other), _args, 3, []);
}
function fr_dependencies_libMenu_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libMenu_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libMenu.mod.gml:22
{
;
scrFRScriptCall(["mod", "libGeneral", "obj_setup"], "libMenu", "libButton");
;
}
_fr.pc=0;
break;
case 2: // dependencies/libMenu.mod.gml:22
_fr.wait_ticks=max(0,scrFRScriptCall(["mod", "lib", "import"], "libGeneral")); _fr.pc=1; return;
break;
case 3: // dependencies/libMenu.mod.gml:17
{
fr_dependencies_libMenu_mod_gml_addScript("create_button");
;
fr_dependencies_libMenu_mod_gml_addScript("menubutton_check");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libMenu"].isLoaded = true;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libMenu.mod.gml:26
function fr_dependencies_libMenu_mod_gml_create_button() {
var _frl_x = (argument_count>0 ? argument[0] : undefined);
;
var _frl_y = (argument_count>1 ? argument[1] : undefined);
;
var _frl_sprite = (argument_count>2 ? argument[2] : undefined);
;
var _frl_clickScr = (argument_count>3 ? argument[3] : undefined);
;
var _frl_hoverScr = noone;
;
if ((argument_count >= 5)) {
{
_frl_hoverScr = (argument_count>4 ? argument[4] : undefined);
;
}
}
if ((argument_count >= 6)) {
{
holdScr = (argument_count>5 ? argument[5] : undefined);
;
}
}
var _frl_btn = scrFRScriptCall(["mod", "libGeneral", "obj_create"], _frl_x, _frl_y, "libButton");
;
{ var __fr_with1 = scrFRWithValues(_frl_btn), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_sprite);
;
_frl_clickScr = _frl_clickScr;
;
_frl_hoverScr = _frl_hoverScr;
;
holdScr = holdScr;
;
pop = (! ((argument_count >= 7) && (! (argument_count>6 ? argument[6] : undefined))));
;
}
}
if(__fr_break3) break;
}}
return _frl_btn;
;
}

// Original dependencies/libMenu.mod.gml:49
function fr_dependencies_libMenu_mod_gml_libButton_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (UberCont.depth - 1);
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
image_speed = (0) * timescale;
;
clickScr = ["mod", "libMenu", fr_dependencies_libMenu_mod_gml_nilScr];
;
hoverScr = ["mod", "libMenu", fr_dependencies_libMenu_mod_gml_nilScr];
;
holdScr = ["mod", "libMenu", fr_dependencies_libMenu_mod_gml_nilScr];
;
hoverIndex = 0;
;
clickIndex = 0;
;
holdIndex = 0;
;
pop = 1;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libMenu.mod.gml:65
function fr_dependencies_libMenu_mod_gml_libButton_step() {
clickIndex = fr_dependencies_libMenu_mod_gml_menubutton_check((x - sprite_xoffset), (y - sprite_yoffset), sprite_width, sprite_height, 0);
;
hoverIndex = fr_dependencies_libMenu_mod_gml_menubutton_check((x - sprite_xoffset), (y - sprite_yoffset), sprite_width, sprite_height, 2);
;
holdIndex = fr_dependencies_libMenu_mod_gml_menubutton_check((x - sprite_xoffset), (y - sprite_yoffset), sprite_width, sprite_height, 1);
;
if ((clickIndex != (- 1))) {
{
scrFRScriptCall(clickScr, clickIndex, scrFRSelf(self));
;
}
}
if ((hoverIndex != (- 1))) {
{
scrFRScriptCall(hoverScr, hoverIndex, scrFRSelf(self));
;
}
}
if ((holdIndex != (- 1))) {
{
scrFRScriptCall(holdScr, holdIndex, scrFRSelf(self));
;
}
}
}

// Original dependencies/libMenu.mod.gml:79
function fr_dependencies_libMenu_mod_gml_libButton_draw() {
if (pop) {
{
if ((hoverIndex != (- 1))) {
{
y -= 1;
;
}
}
if ((holdIndex != (- 1))) {
{
y += 1;
;
}
}
}
}
draw_self();
;
if (pop) {
{
if ((hoverIndex != (- 1))) {
{
y += 1;
;
}
}
if ((holdIndex != (- 1))) {
{
y -= 1;
;
}
}
}
}
}

// Original dependencies/libMenu.mod.gml:90
function fr_dependencies_libMenu_mod_gml_nilScr() {

}

// Original dependencies/libMenu.mod.gml:92
function fr_dependencies_libMenu_mod_gml_menubutton_check() {
    if(scrFRMenuTouchOwns()) return scrFRMenuTouchCheck(argument[0],argument[1],argument[2],argument[3],
        argument_count>4?argument[4]:0,argument_count>5?argument[5]:0,argument_count>6?argument[6]:undefined); // FRONTIER REAL TOUCH MENU
var _frl_x = (argument_count>0 ? argument[0] : undefined);
;
var _frl_y = (argument_count>1 ? argument[1] : undefined);
;
var _frl_w = (argument_count>2 ? argument[2] : undefined);
;
var _frl_h = (argument_count>3 ? argument[3] : undefined);
;
if ((((argument_count == 6) && ((argument_count>4 ? argument[4] : undefined) == 0)) && ((argument_count>5 ? argument[5] : undefined) == 1))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = (scrFRMouseCoordinate(0, _frl_i) - scrFRViewCoordinate(0, _frl_i));
;
var _frl_mouseY = (scrFRMouseCoordinate(1, _frl_i) - scrFRViewCoordinate(1, _frl_i));
;
if ((scrFRButtonPressed(_frl_i, "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if ((((argument_count == 6) && ((argument_count>4 ? argument[4] : undefined) == 1)) && ((argument_count>5 ? argument[5] : undefined) == 1))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = (scrFRMouseCoordinate(0, _frl_i) - scrFRViewCoordinate(0, _frl_i));
;
var _frl_mouseY = (scrFRMouseCoordinate(1, _frl_i) - scrFRViewCoordinate(1, _frl_i));
;
if ((scrFRButtonCheck(_frl_i, "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if ((((argument_count == 6) && ((argument_count>4 ? argument[4] : undefined) == 2)) && ((argument_count>5 ? argument[5] : undefined) == 1))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = (scrFRMouseCoordinate(0, _frl_i) - scrFRViewCoordinate(0, _frl_i));
;
var _frl_mouseY = (scrFRMouseCoordinate(1, _frl_i) - scrFRViewCoordinate(1, _frl_i));
;
if (point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if (((argument_count == 4) || (((argument_count == 5) || (argument_count == 6)) && ((argument_count>4 ? argument[4] : undefined) == 0)))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = scrFRMouseCoordinate(0, _frl_i);
;
var _frl_mouseY = scrFRMouseCoordinate(1, _frl_i);
;
if ((scrFRButtonPressed(_frl_i, "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if ((((argument_count == 5) || (argument_count == 6)) && ((argument_count>4 ? argument[4] : undefined) == 1))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = scrFRMouseCoordinate(0, _frl_i);
;
var _frl_mouseY = scrFRMouseCoordinate(1, _frl_i);
;
if ((scrFRButtonCheck(_frl_i, "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if ((((argument_count == 5) || (argument_count == 6)) && ((argument_count>4 ? argument[4] : undefined) == 2))) {
{
{
var _frl_i = 0;
for (; (_frl_i < 4); _frl_i++) {
var _frl_mouseX = scrFRMouseCoordinate(0, _frl_i);
;
var _frl_mouseY = scrFRMouseCoordinate(1, _frl_i);
;
if (point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h))) {
{
return _frl_i;
;
}
}
}
}
}
} else {
if (((argument_count == 7) && ((argument_count>4 ? argument[4] : undefined) == 0))) {
{
var _frl_mouseX = scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined));
;
var _frl_mouseY = scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined));
;
if (((argument_count>5 ? argument[5] : undefined) == 1)) {
{
_frl_mouseX = (scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(0, (argument_count>6 ? argument[6] : undefined)));
;
_frl_mouseY = (scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(1, (argument_count>6 ? argument[6] : undefined)));
;
}
}
if ((scrFRButtonPressed((argument_count>6 ? argument[6] : undefined), "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return (argument_count>6 ? argument[6] : undefined);
;
}
}
}
} else {
if (((argument_count == 7) && ((argument_count>4 ? argument[4] : undefined) == 1))) {
{
var _frl_mouseX = scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined));
;
var _frl_mouseY = scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined));
;
if (((argument_count>5 ? argument[5] : undefined) == 1)) {
{
_frl_mouseX = (scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(0, (argument_count>6 ? argument[6] : undefined)));
;
_frl_mouseY = (scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(1, (argument_count>6 ? argument[6] : undefined)));
;
}
}
if ((scrFRButtonCheck((argument_count>6 ? argument[6] : undefined), "fire") && point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h)))) {
{
return (argument_count>6 ? argument[6] : undefined);
;
}
}
}
} else {
if (((argument_count == 7) && ((argument_count>4 ? argument[4] : undefined) == 2))) {
{
var _frl_mouseX = scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined));
;
var _frl_mouseY = scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined));
;
if (((argument_count>5 ? argument[5] : undefined) == 1)) {
{
_frl_mouseX = (scrFRMouseCoordinate(0, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(0, (argument_count>6 ? argument[6] : undefined)));
;
_frl_mouseY = (scrFRMouseCoordinate(1, (argument_count>6 ? argument[6] : undefined)) - scrFRViewCoordinate(1, (argument_count>6 ? argument[6] : undefined)));
;
}
}
if (point_in_rectangle(_frl_mouseX, _frl_mouseY, _frl_x, _frl_y, (_frl_x + _frl_w), (_frl_y + _frl_h))) {
{
return (argument_count>6 ? argument[6] : undefined);
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
return (- 1);
;
}
