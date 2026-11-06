// Original Characters/Frontier_CharHuds.mod.gml:1
function fr_Characters_Frontier_CharHuds_mod_gml___load() {

}

// Original Characters/Frontier_CharHuds.mod.gml:1
function fr_Characters_Frontier_CharHuds_mod_gml_init() {
global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHud = sprFR_sprBubblesHud_775af471ac4b;
;
global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudBack = sprFR_sprBubblesHudBack_49e846621318;
;
global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSlice = sprFR_sprBubblesHudSlice_035b030755a5;
;
global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSliceEnd = sprFR_sprBubblesHudSliceEnd_71d3cbe12522;
;
global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSliceEnd2 = sprFR_sprBubblesHudSliceEnd2_0c9d9f5db404;
;
}

// Original Characters/Frontier_CharHuds.mod.gml:16
function fr_Characters_Frontier_CharHuds_mod_gml_player_hud(_frl__player=undefined, _frl__hudIndex=undefined, _frl__hudSide=undefined) {
{ var __fr_switch_value1=_frl__player.race, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(scrFRRaceTryResolve("bubbles"))) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
var _frl__bubbleCharge = _frl__player.bubbles_bubbleCharge;
var _frl__maxBubbleCharge = _frl__player.bubbles_maxBubbleCharge;
var _frl__hudX = (scrFRPlayerIsActive(1) ? (_frl__hudSide ? (- 7) : 102) : 102);
var _frl__hudY = ((_frl__hudIndex >= 2) ? 11 : 11);
;
var _frl__barX = (_frl__hudX - 7);
;
var _frl__barY = (_frl__hudY - 7);
;
var _frl__barMaxHeight = 13;
;
var _frl__barHeight = 13;
;
var _frl__barSize = (13 - (_frl__barMaxHeight * (_frl__bubbleCharge / _frl__maxBubbleCharge)));
;
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudBack, 0, _frl__hudX, _frl__hudY);
;
draw_sprite_stretched(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSlice, 0, _frl__barX, (_frl__barY + _frl__barSize), 13, (13 - _frl__barSize));
;
if ((_frl__barSize > 3)) {
{
draw_sprite_part(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSliceEnd, (scrFRSourceFrame() * 0.4), 0, 0, 13, 3, _frl__barX, ((_frl__barY + _frl__barSize) - 3));
;
}
} else {
{
draw_sprite_part(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHudSliceEnd2, (scrFRSourceFrame() * 0.4), 0, 0, 13, 3, _frl__barX, ((_frl__barY + _frl__barSize) - 3));
;
}
}
var _frl__barEndWidth = clamp((_frl__barMaxHeight - _frl__barSize), 0, _frl__barHeight);
;
var _frl__barEndX = (_frl__barX + _frl__barSize);
;
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_CharHuds"].sprBubblesHud, 0, _frl__hudX, _frl__hudY);
;
break;
;
}
}
}
}

// Original Characters/Frontier_CharHuds.mod.gml:101
function fr_Characters_Frontier_CharHuds_mod_gml_draw_gui() {
if (((scrFRInstanceExists(Player) && (! scrFRInstanceExists(Cinematic))) && (! scrFRInstanceExists(MenuGen)))) {
{
if (((scrFRInstanceExists(TopCont) || scrFRInstanceExists(GenCont)) || scrFRInstanceExists(LevCont))) {
{
var _frl__hudFade = 0;
var _frl__hudIndex = 0;
var _frl__lastSeed = scrFRSourceRandomGetSeed();
;
if (array_length(scrFRMatching(TopCont, "fadeout", true))) {
{
{ var __fr_with1 = scrFRWithValues(TopCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
_frl__hudFade = clamp(fade, 0, 1);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((_frl__hudFade > 0)) {
{
try if ((! undefined)) {
{

}
} catch(__fr_caught4) { var _frl__error=__fr_caught4;
{
_frl__hudFade = min(_frl__hudFade, round(_frl__hudFade));
;
}
}
if ((_frl__hudFade > 0)) {
{
gpu_set_fog(true, c_black, 0, (16000 / _frl__hudFade));
;
}
}
}
}
{
var _frl__isOnline = 0;
for (; (_frl__isOnline <= 1); _frl__isOnline++) {
{
var _frl__index = 0;
for (; (_frl__index < INPUT_MAX_PLAYERS); _frl__index++) {
if (((scrFRPlayerIsActive(_frl__index) && ((_frl__hudIndex < 2) || (! scrFRInstanceExists(LevCont)))) && (scrFRPlayerIsLocal(_frl__index) ^^ _frl__isOnline))) {
{
var _frl__hudVisible = false;
;
{
var _frl_i = 0;
for (; true; _frl_i++) {
var _frl__local = scrFRPlayerFindLocal(_frl_i);
;
if ((! scrFRPlayerIsActive(_frl__local))) {
{
break;
;
}
}
if (scrFRPlayerShowHUD(_frl__index, _frl__local)) {
{
_frl__hudVisible = true;
;
break;
;
}
}
}
}
if ((_frl__hudVisible || (_frl__isOnline == 0))) {
{
if (_frl__hudVisible) {
{
var _frl__player = scrFRPlayerFind(_frl__index);
;
if (scrFRInstanceExists(_frl__player)) {
{
var _frl__playerNum = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__playerNum += scrFRPlayerIsActive(_frl_i);
;
}
}
if ((_frl__playerNum <= 1)) {
{
scrFRProjectionOrtho((scrFRViewCoordinate(0) - 17), scrFRViewCoordinate(1), view_width, view_height, 0);
;
}
} else {
scrFRDrawSetProjection(2, _frl__index);
}
;
fr_Characters_Frontier_CharHuds_mod_gml_player_hud(_frl__player, _frl__hudIndex, (_frl__hudIndex % 2));
;
scrFRDrawResetProjection();
;
}
}
}
}
_frl__hudIndex++;
;
}
}
}
}
}
}
}
}
if ((_frl__hudFade > 0)) {
{
gpu_set_fog(false, 0, 0, 0);
;
}
}
scrFRSourceRandomSetSeed(_frl__lastSeed);
;
}
}
}
}
}

// Original Characters/Frontier_CharHuds.mod.gml:189
function fr_Characters_Frontier_CharHuds_mod_gml_draw_pause() {
var _frl__local = scrFRPlayerFindLocal();
;
if (scrFRPlayerIsActive(_frl__local)) {
{
if (scrFRInstanceExists(Player)) {
{
global.fr_module_vars[$ "mod:Frontier_CharHuds"].hud_pause_vars = undefined;
;
{ var __fr_with1 = scrFRWithValues(scrFRPlayerFind(_frl__local)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
global.fr_module_vars[$ "mod:Frontier_CharHuds"].hud_pause_vars = {};
;
{ var __fr_with4 = scrFRWithValues(variable_instance_get_names(scrFRSelf(self))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
scrFRLQSet(global.fr_module_vars[$ "mod:Frontier_CharHuds"].hud_pause_vars, scrFRSelf(self), scrFRVariableGet(__fr_other7, scrFRSelf(self)));
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
}
if ((! scrFRInstanceExists(FR_OBJECT_BACK_MAIN_MENU))) {
{
var _frl__ref = ["mod", "Frontier_CharHuds", fr_Characters_Frontier_CharHuds_mod_gml_draw_pause];
var _frl__vars = scrFRModGet(scrFRIndexGet(_frl__ref, 0), scrFRIndexGet(_frl__ref, 1), "hud_pause_vars");
;
if ((! is_undefined(_frl__vars))) {
{
{
var _frl_i = 0;
for (; scrFRPlayerIsActive(scrFRPlayerFindLocal(_frl_i)); _frl_i++) {
if (scrFRPlayerShowHUD(_frl__local, scrFRPlayerFindLocal(_frl_i))) {
{
var _frl__playerNum = 0;
var _frl__lastSeed = scrFRSourceRandomGetSeed();
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__playerNum += scrFRPlayerIsActive(_frl_i);
;
}
}
scrFRProjectionOrtho(((_frl__playerNum <= 1) ? (- 17) : 0), 0, view_width, view_height, 0);
;
fr_Characters_Frontier_CharHuds_mod_gml_player_hud(global.fr_module_vars[$ "mod:Frontier_CharHuds"].hud_pause_vars, 0, false);
;
scrFRDrawResetProjection();
;
scrFRSourceRandomSetSeed(_frl__lastSeed);
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
}
}
}
