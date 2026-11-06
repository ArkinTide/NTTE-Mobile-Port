// Original dependencies/libImprovements.mod.gml:1
function fr_dependencies_libImprovements_mod_gml___load() {

}

// Original dependencies/libImprovements.mod.gml:1
function fr_dependencies_libImprovements_mod_gml_init() {
global.fr_module_vars[$ "mod:libImprovements"].isLoaded = true;
;
}

// Original dependencies/libImprovements.mod.gml:4
function fr_dependencies_libImprovements_mod_gml_step() {
if (scrFRInstanceExists(LevCont)) {
{
var _frl_button_count = (scrFRInstanceNumber(SkillIcon) - array_length(scrFRMatching(SkillIcon, "skill", 0)));
;
if (_frl_button_count) {
{
if (((((_frl_button_count + 1) * sprite_get_width(sprSkillIcon)) * 1.2) > view_width)) {
{
var _frl__animating = scrFRMatchingGE(SkillIcon, "alarm0", 0);
;
var _frl_animating_count = array_length(_frl__animating);
;
{ var __fr_with1 = scrFRWithValues(LevCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! _frl_animating_count)) {
{
var _frl__canMoveRight = array_length(scrFRMatchingLE(scrFRMatchingGT(SkillIcon, "num", (floor((maxselect / 2)) - 1.5)), "num", (floor((maxselect / 2)) - 0.5)));
;
var _frl__canMoveLeft = array_length(scrFRMatchingGT(scrFRMatchingLE(SkillIcon, "num", (floor((maxselect / 2)) + 1.5)), "num", (floor((maxselect / 2)) + 0.5)));
;
var _frl__canMove = array_length(scrFRMatching(SkillIcon, "num", select));
;
{ var __fr_with4 = scrFRWithValues(SkillIcon), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((scrFRMouseCoordinate(0) < ((view_width / 2) - (sprite_get_width(sprSkillIcon) * 3))) && (_frl__canMoveRight || (! _frl__canMoveLeft)))) {
{
num += (0.2 * scrFRSourceScale());
;
if ((scrFRMouseCoordinate(0) < ((view_width / 2) - (sprite_get_width(sprSkillIcon) * 6)))) {
{
num += (0.2 * scrFRSourceScale());
;
}
}
var __fr_other7=scrFROther(other);
__fr_other7.select = ((floor((__fr_other7.maxselect / 2)) + num) - floor(num));
;
}
} else {
if (((scrFRMouseCoordinate(0) > ((view_width / 2) + (sprite_get_width(sprSkillIcon) * 3))) && (_frl__canMoveLeft || (! _frl__canMoveRight)))) {
{
if ((scrFRMouseCoordinate(0) > ((view_width / 2) + (sprite_get_width(sprSkillIcon) * 6)))) {
{
num -= (0.2 * scrFRSourceScale());
;
}
}
num -= (0.2 * scrFRSourceScale());
;
var __fr_other8=scrFROther(other);
__fr_other8.select = ((floor((__fr_other8.maxselect / 2)) + num) - floor(num));
;
}
} else {
if ((((scrFROther(other)).select > (floor(((scrFROther(other)).maxselect / 2)) + 2)) && _frl__canMove)) {
{
num--;
;
}
} else {
if ((((scrFROther(other)).select < (floor(((scrFROther(other)).maxselect / 2)) - 2)) && _frl__canMove)) {
{
num++;
;
}
} else {
{
if ((abs((round(num) - num)) < 0.1)) {
{
num = round(num);
;
}
} else {
if ((round(num) < num)) {
{
num -= (0.1 * scrFRSourceScale());
;
}
} else {
if ((round(num) > num)) {
{
num += (0.1 * scrFRSourceScale());
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
if(__fr_break6) break;
}}
if ((! ((scrFRMouseCoordinate(0) < ((view_width / 2) - (sprite_get_width(sprSkillIcon) * 3))) || (scrFRMouseCoordinate(0) > ((view_width / 2) + (sprite_get_width(sprSkillIcon) * 3)))))) {
{
if ((select > (floor((maxselect / 2)) + 2))) {
{
select = (floor((maxselect / 2)) + 2);
;
}
} else {
if ((select < (floor((maxselect / 2)) - 2))) {
{
select = (floor((maxselect / 2)) - 2);
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
if(__fr_break3) break;
}}
}
} else {
{
LevCont.maxselect = (_frl_button_count - 1);
;
var _frl__max = _frl_button_count;
;
{ var __fr_with9 = scrFRWithValues(SkillIcon), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
if (((scrFRVariableExists(scrFRSelf(self), "skill") && (skill == 0)) || (scrFRVariableExists(scrFRSelf(self), "crown") && (crown == 0)))) {
{
_frl__max++;
;
}
}
num = (-- _frl__max);
;
}
}
if(__fr_break11) break;
}}
}
}
}
}
}
}
}
