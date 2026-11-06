// Original dependencies/libCharm.mod.gml:1
function fr_dependencies_libCharm_mod_gml___load() {

}

// Original dependencies/libCharm.mod.gml:13
function fr_dependencies_libCharm_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libCharm", _frl_name]);
;
}

// Original dependencies/libCharm.mod.gml:16
function fr_dependencies_libCharm_mod_gml_init() {
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libCharm"].isLoaded = true;
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libCharm", "scr");
;
charm_object = [hitme, becomenemy, ReviveCircle, NecroReviveArea, RevivePopoFreak];
;
charm_instance_list = [];
;
charm_instance_vars = [];
;
charm_bind_draw = [];
;
{
var _frl_i = (- 1);
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
array_push(charm_bind_draw, scrFRBind(FRBinding, ["mod", "libCharm", fr_dependencies_libCharm_mod_gml_charm_draw, [], _frl_i], 0, false));
;
}
}
}

// Original dependencies/libCharm.mod.gml:30
function fr_dependencies_libCharm_mod_gml_update(_frl__newID=undefined) {
if (array_length(charm_instance_list)) {
{
{ var __fr_with1 = scrFRWithValues(charm_object), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRInstanceExists(scrFRSelf(self)) && (scrFRSelf(self).id > _frl__newID))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRMatchingGT(scrFRSelf(self), "id", _frl__newID)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((scrFRVariableExists(scrFRSelf(self), "ntte_charm") && ntte_charm.charmed) && (scrFRArrayFindIndex(charm_instance_list, scrFRSelf(self)) < 0))) {
{
ntte_charm = scrFRLQClone(ntte_charm);
;
array_push(charm_instance_list, scrFRSelf(self));
;
array_push(charm_instance_vars, ntte_charm);
;
}
} else {
if (scrFRVariableExists(scrFRSelf(self), "creator")) {
{
var _frl__hitme = (scrFRInstanceIs(scrFRSelf(self), hitme) || scrFRInstanceIs(scrFRSelf(self), becomenemy));
;
{ var __fr_with7 = scrFRWithValues(charm_instance_list), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((((scrFROther(other)).creator == scrFRSelf(self)) || ((scrFRVariableExists(scrFRSelf(self), "creator") && (! scrFRInstanceIs(scrFRSelf(self), hitme))) && ((scrFROther(other)).creator == creator)))) {
{
if ((((! _frl__hitme) || (! scrFRInstanceExists(scrFRSelf(self)))) || scrFRPlaceMeeting(x, y, (scrFROther(other))))) {
{
var _frl__vars = scrFRIndexGet(charm_instance_vars, scrFRArrayFindIndex(charm_instance_list, scrFRSelf(self)));
var _frl__charm = scrFRCharmInstance((scrFROther(other)), true);
;
_frl__charm.time = _frl__vars.time;
;
_frl__charm.index = _frl__vars.index;
;
_frl__charm.kill = _frl__vars.kill;
;
_frl__charm.feather = _frl__vars.feather;
;
if (_frl__hitme) {
{
{ var __fr_with10 = scrFRWithValues((scrFROther(other))), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (((scrFRInstanceIs(scrFRSelf(self), enemy) && (! enemy_boss)) && (givekill <= 0))) {
{
_frl__charm.kill = true;
;
raddrop = 0;
;
}
}
if ((_frl__charm.feather && (_frl__charm.time >= 0))) {
{
do {
{ var __fr_with13 = scrFRWithValues(scrFRObjectCreate((x + orandom(24)), (y + orandom(24)), "ParrotFeather")), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var __fr_other16=scrFROther(other);
target = __fr_other16;
;
index = _frl__charm.index;
;
{ var __fr_with17 = scrFRWithValues(scrFRPlayerFind(index)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
var __fr_other20=scrFROther(other);
__fr_other20.bskin = scrFRSkinResolve(bskin);
;
}
}
if(__fr_break19) break;
}}
sprite_index = scrFRAreaSourceSprite(scrFRRaceSprite("libCharm", sprite_index));
;
_frl__charm.time -= (stick_time * 1.5);
;
}
}
if(__fr_break15) break;
}}
} until ((_frl__charm.time <= 0));
;
_frl__charm.time = 15;
;
}
}
}
}
if(__fr_break12) break;
}}
}
}
}
}
}
}
}
}
if(__fr_break9) break;
}}
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
if(__fr_break3) break;
}}
if (scrFRInstanceExists(crystaltype)) {
{
if ((scrFRInstanceExists(LaserCrystal) || scrFRInstanceExists(InvLaserCrystal))) {
{
if ((scrFRInstanceExists(LaserCharge) && (LaserCharge.id > _frl__newID))) {
{
var _frl__instCharm = scrFRMatchingNE([LaserCrystal, InvLaserCrystal], "ntte_charm", undefined);
;
if (array_length(_frl__instCharm)) {
{
{ var __fr_with21 = scrFRWithValues(scrFRMatchingGT(LaserCharge, "id", _frl__newID)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
{ var __fr_with24 = scrFRWithValues(_frl__instCharm), __fr_break26=false;
for (var __fr_index25=0; __fr_index25<array_length(__fr_with24); ++__fr_index25) {
if(scrFRScopeExists(__fr_with24[__fr_index25])) with (__fr_with24[__fr_index25]) {
{
if (ntte_charm.charmed) {
{
var _frl__x1 = (scrFROther(other)).xstart;
var _frl__y1 = (scrFROther(other)).ystart;
var _frl__x2 = x;
var _frl__y2 = y;
var _frl__dis = point_distance(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
var _frl__dir = point_direction(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
if (((_frl__dis < 5) || ((scrFRAlarmRead((scrFROther(other)), 0) == floor((1 + (_frl__dis / ((scrFROther(other)).speed / timescale))))) && (abs(angle_difference((scrFROther(other)).direction, _frl__dir)) < 0.1)))) {
{
var __fr_other27=scrFROther(other);
scrFRTeamInstanceSprite(team, __fr_other27);
;
__fr_break26=true; break;
;
}
}
}
}
}
}
if(__fr_break26) break;
}}
}
}
if(__fr_break23) break;
}}
}
}
}
}
}
}
if (scrFRInstanceExists(LightningCrystal)) {
{
if ((scrFRInstanceExists(EnemyLightning) && (EnemyLightning.id > _frl__newID))) {
{
var _frl__instCharm = scrFRMatchingNE(LightningCrystal, "ntte_charm", undefined);
;
if (array_length(_frl__instCharm)) {
{
{ var __fr_with28 = scrFRWithValues(scrFRMatching(scrFRMatchingGT(EnemyLightning, "id", _frl__newID), "sprite_index", sprEnemyLightning)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
if ((! scrFRInstanceExists(creator))) {
{
{ var __fr_with31 = scrFRWithValues(scrFRMatching(_frl__instCharm, "team", team)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
if ((ntte_charm.charmed && (distance_to_object((scrFROther(other))) < 56))) {
{
var __fr_other34=scrFROther(other);
__fr_other34.sprite_index = scrFRAreaSourceSprite(sprLightning);
;
__fr_break33=true; break;
;
}
}
}
}
if(__fr_break33) break;
}}
}
}
}
}
if(__fr_break30) break;
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
}

// Original dependencies/libCharm.mod.gml:141
function fr_dependencies_libCharm_mod_gml_ntte_begin_step() {
{ var __fr_with1 = scrFRWithValues(charm_bind_draw), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(real(id))) {
{
real(id).visible = false;
;
}
}
scrFRMemberIndexWrite(scrFRSelf(self), "script", [3], [], "=");
;
}
}
if(__fr_break3) break;
}}
if (array_length(charm_instance_list)) {
{
var _frl__instNum = 0;
var _frl__instList = scrFRArrayClone(charm_instance_list);
var _frl__varsList = scrFRArrayClone(charm_instance_vars);
;
{ var __fr_with4 = scrFRWithValues(_frl__instList), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__vars = scrFRIndexGet(_frl__varsList, (_frl__instNum++));
;
if (_frl__vars.charmed) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "ntte_charm_override")) || (! ntte_charm_override))) {
{
var _frl__lastDir = direction;
var _frl__isCustom = (string_pos("Custom", object_get_name(scrFRObjectIndex(scrFRSelf(self)))) == 1);
;
if ((! scrFRInstanceExists(_frl__vars.target))) {
{
{ var __fr_with7 = scrFRWithValues(fr_dependencies_libCharm_mod_gml_charm_target(_frl__vars)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(scrFRIndexGet(scrFRSelf(self), 0)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
x = scrFRIndexGet(__fr_other13, 1);
;
var __fr_other14=scrFROther(other);
y = scrFRIndexGet(__fr_other14, 2);
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
}
if ((((scrFRAlarmRead(scrFRSelf(self), 1) > 0) && current_frame_active) && scrFRInstanceIs(scrFRSelf(self), enemy))) {
{
var _frl__aggroSpeed = ceil((((10 / max(1, size)) - 1) * max(1, scrFRSourceScale())));
;
if (((!scrFRVariableExists(scrFRSelf(self), "intro")) || intro)) {
{
if (((((((scrFRAlarmRead(scrFRSelf(self), 2) < 0) && ((!scrFRVariableExists(scrFRSelf(self), "ammo")) || (ammo <= 0))) && (((sprite_index == spr_idle) || (sprite_index == spr_walk)) || (sprite_index == spr_hurt))) && ((! scrFRInstanceExists(projectile)) || (! array_length(scrFRMatching(projectile, "creator", scrFRSelf(self)))))) && ((! scrFRInstanceExists(ReviveCircle)) || (! array_length(scrFRMatching(ReviveCircle, "creator", scrFRSelf(self)))))) && ((! scrFRInstanceExists(NecroReviveArea)) || (! array_length(scrFRMatching(NecroReviveArea, "creator", scrFRSelf(self))))))) {
{
if (((! scrFRInstanceExists(PopoShield)) || (! array_length(scrFRMatching(PopoShield, "creator", scrFRSelf(self)))))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, max((scrFRAlarmRead(scrFRSelf(self), 1) - _frl__aggroSpeed), 1), "=");
;
}
}
}
}
}
}
}
}
if (_frl__isCustom) {
{
if (((! array_length(_frl__vars.on_step)) && is_array(on_step))) {
{
_frl__vars.on_step = on_step;
;
on_step = ["mod", "libCharm", fr_dependencies_libCharm_mod_gml_charm_obj_step];
;
}
}
}
} else {
{
var _frl__minID = undefined;
;
{
var _frl__alarmNum = 0;
for (; (_frl__alarmNum <= 10); _frl__alarmNum++) {
var _frl__alarm = scrFRAlarmRead(scrFRSelf(self), _frl__alarmNum);
;
if (((_frl__alarm > 0) && (_frl__alarm <= ceil(scrFRSourceScale())))) {
{
var _frl__playerPos = fr_dependencies_libCharm_mod_gml_charm_target(_frl__vars);
;
if (is_undefined(_frl__minID)) {
{
_frl__minID = instance_max;
;
}
}
{ var __fr_with15 = scrFRWithValues(scrFRSelf(self)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
if ((((_frl__alarmNum != 2) || scrFRInstanceExists(target)) || (! scrFRInstanceIs(scrFRSelf(self), Gator)))) {
{
try {
scrFRAlarmWrite(scrFRSelf(self), _frl__alarmNum, 0);
;
event_perform(ev_alarm, _frl__alarmNum);
;
} catch(__fr_caught18) { var _frl__error=__fr_caught18;
{
scrFRTraceError(_frl__error);
;
}
}
}
}
}
}
if(__fr_break17) break;
}}
{ var __fr_with19 = scrFRWithValues(_frl__playerPos), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
{ var __fr_with22 = scrFRWithValues(scrFRIndexGet(scrFRSelf(self), 0)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
var __fr_other25=scrFROther(other);
x = scrFRIndexGet(__fr_other25, 1);
;
var __fr_other26=scrFROther(other);
y = scrFRIndexGet(__fr_other26, 2);
;
}
}
if(__fr_break24) break;
}}
}
}
if(__fr_break21) break;
}}
if (scrFRInstanceExists(scrFRSelf(self))) {
{
_frl__alarm = scrFRAlarmRead(scrFRSelf(self), _frl__alarmNum);
;
if ((_frl__alarm > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), _frl__alarmNum, (_frl__alarm + 1));
;
}
}
}
} else {
break;
}
;
}
}
}
}
if ((! is_undefined(_frl__minID))) {
{
fr_dependencies_libCharm_mod_gml_charm_grab(_frl__vars, _frl__minID);
;
}
}
}
}
if (scrFRInstanceIs(scrFRSelf(self), enemy)) {
{
if (visible) {
{
{ var __fr_with27 = scrFRWithValues(scrFRIndexGet(charm_bind_draw, (_frl__vars.index + 1)).id), __fr_break29=false;
for (var __fr_index28=0; __fr_index28<array_length(__fr_with27); ++__fr_index28) {
if(scrFRScopeExists(__fr_with27[__fr_index28])) with (__fr_with27[__fr_index28]) {
{
var __fr_other30=scrFROther(other);
array_push(scrFRIndexGet(script, 3), __fr_other30);
;
if (((! visible) || (((scrFROther(other)).depth - 1) < depth))) {
{
visible = true;
;
var __fr_other31=scrFROther(other);
depth = (__fr_other31.depth - 1);
;
}
}
}
}
if(__fr_break29) break;
}}
}
}
if (scrFRInstanceExists(Player)) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "ammo")) || (ammo <= 0))) {
{
if ((((meleedamage <= 0) || scrFRVariableExists(scrFRSelf(self), "gunangle")) || ((scrFRVariableExists(scrFRSelf(self), "walk") && (walk > 0)) && (! scrFRInstanceIs(scrFRSelf(self), ExploFreak))))) {
{
if (((((! scrFRInstanceExists(_frl__vars.target)) || collision_line(x, y, _frl__vars.target.x, _frl__vars.target.y, Wall, false, false)) || (distance_to_object(_frl__vars.target) > 80)) || (distance_to_object(Player) > 256))) {
{
var _frl__follow = scrFRPlayerFind(_frl__vars.index);
;
if ((! scrFRInstanceExists(_frl__follow))) {
{
_frl__follow = instance_nearest(x, y, Player);
;
}
}
if ((scrFRInstanceExists(_frl__follow) && (distance_to_object(_frl__follow) > 32))) {
{
scrFRMotionAddCT(point_direction(x, y, _frl__follow.x, _frl__follow.y), 1);
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
if (scrFRPlaceMeeting(x, y, enemy)) {
{
var _frl__inst = scrFRInstancesMeeting(x, y, scrFRMatchingNE(enemy, "team", team));
;
if (array_length(_frl__inst)) {
{ var __fr_with32 = scrFRWithValues(_frl__inst), __fr_break34=false;
for (var __fr_index33=0; __fr_index33<array_length(__fr_with32); ++__fr_index33) {
if(scrFRScopeExists(__fr_with32[__fr_index33])) with (__fr_with32[__fr_index33]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{ var __fr_with35 = scrFRWithValues((scrFROther(other))), __fr_break37=false;
for (var __fr_index36=0; __fr_index36<array_length(__fr_with35); ++__fr_index36) {
if(scrFRScopeExists(__fr_with35[__fr_index36])) with (__fr_with35[__fr_index36]) {
{
var _frl__lastFreeze = UberCont.opt_freeze;
var _frl__lastGamma = scrFRGetSkill(mut_gamma_guts);
var _frl__lastNextHurt = (scrFRVariableExists((scrFROther(other)), "nexthurt") ? (scrFROther(other)).nexthurt : 0);
;
UberCont.opt_freeze = 0;
;
scrFRSetSkill(mut_gamma_guts, false);
;
if (((scrFRAlarmRead(scrFRSelf(self), 11) > 0) && (scrFRAlarmRead(scrFRSelf(self), 11) < 26))) {
{
{ var __fr_with38 = scrFRWithValues(scrFRSelf(self)), __fr_break40=false;
for (var __fr_index39=0; __fr_index39<array_length(__fr_with38); ++__fr_index39) {
if(scrFRScopeExists(__fr_with38[__fr_index39])) with (__fr_with38[__fr_index39]) {
{
event_perform(ev_alarm, 11);
;
}
}
if(__fr_break40) break;
}}
}
}
event_perform(ev_collision, Player);
;
if (scrFRVariableExists((scrFROther(other)), "nexthurt")) {
{
var __fr_other41=scrFROther(other);
__fr_other41.nexthurt = _frl__lastNextHurt;
;
}
}
UberCont.opt_freeze = _frl__lastFreeze;
;
scrFRSetSkill(mut_gamma_guts, _frl__lastGamma);
;
}
}
if(__fr_break37) break;
}}
}
}
}
if(__fr_break34) break;
}}
}
}
}
}
}
if ((scrFRInstanceExists(scrFRSelf(self)) && (! _frl__isCustom))) {
{
{ var __fr_switch_value42=scrFRObjectIndex(scrFRSelf(self)), __fr_switch_case43=-1;
if(__fr_switch_case43==-1 && __fr_switch_value42==(BigMaggot)) __fr_switch_case43=0;
if(__fr_switch_case43==-1 && __fr_switch_value42==(MeleeBandit)) __fr_switch_case43=1;
if(__fr_switch_case43==-1 && __fr_switch_value42==(JungleAssassin)) __fr_switch_case43=2;
if(__fr_switch_case43==-1 && __fr_switch_value42==(Sniper)) __fr_switch_case43=3;
if(__fr_switch_case43==-1 && __fr_switch_value42==(ScrapBoss)) __fr_switch_case43=4;
if(__fr_switch_case43==-1 && __fr_switch_value42==(ScrapBossMissile)) __fr_switch_case43=5;
if(__fr_switch_case43==-1 && __fr_switch_value42==(LilHunterFly)) __fr_switch_case43=6;
if(__fr_switch_case43==-1 && __fr_switch_value42==(ExploFreak)) __fr_switch_case43=7;
if(__fr_switch_case43==-1 && __fr_switch_value42==(RhinoFreak)) __fr_switch_case43=8;
if(__fr_switch_case43==-1 && __fr_switch_value42==(Shielder)) __fr_switch_case43=9;
if(__fr_switch_case43==-1 && __fr_switch_value42==(EliteShielder)) __fr_switch_case43=10;
if(__fr_switch_case43==-1 && __fr_switch_value42==(Inspector)) __fr_switch_case43=11;
if(__fr_switch_case43==-1 && __fr_switch_value42==(EliteInspector)) __fr_switch_case43=12;
if(__fr_switch_case43==-1 && __fr_switch_value42==(HostileHorror)) __fr_switch_case43=13;
if(__fr_switch_case43==-1) __fr_switch_case43=-1;
switch(__fr_switch_case43) {
case 0:
if ((((scrFRAlarmRead(scrFRSelf(self), 1) < 0) && scrFRInstanceExists(_frl__vars.target)) && (! collision_line(x, y, _frl__vars.target.x, _frl__vars.target.y, Wall, false, false)))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 900, "=");
;
}
}
break;
;
case 1:

case 2:
if ((walk > 0)) {
{
var _frl__spd = (((scrFRObjectIndex(scrFRSelf(self)) == JungleAssassin) ? 1 : 2) * scrFRSourceScale());
;
direction = _frl__lastDir;
;
if (scrFRInstanceExists(Player)) {
{
var _frl__ox = lengthdir_x(_frl__spd, _frl__lastDir);
var _frl__oy = lengthdir_y(_frl__spd, _frl__lastDir);
;
if (place_free((x - _frl__ox), y)) {
x -= _frl__ox;
}
if (place_free(x, (y - _frl__oy))) {
y -= _frl__oy;
}
}
}
if (scrFRInstanceExists(_frl__vars.target)) {
{
mp_potential_step(_frl__vars.target.x, _frl__vars.target.y, _frl__spd, false);
;
}
}
}
}
break;
;
case 3:
if (((scrFRAlarmRead(scrFRSelf(self), 2) > 5) && scrFRInstanceExists(_frl__vars.target))) {
{
gunangle = point_direction(x, y, _frl__vars.target.x, _frl__vars.target.y);
;
scrFRBindStep(fr_dependencies_libCharm_mod_gml_charm_sniper_gunangle, 0, scrFRSelf(self), gunangle);
;
}
}
break;
;
case 4:
if (((walk > 0) && scrFRInstanceExists(_frl__vars.target))) {
{
scrFRMotionAdd(point_direction(x, y, _frl__vars.target.x, _frl__vars.target.y), 0.5);
;
}
}
break;
;
case 5:
if (((sprite_index != spr_hurt) && scrFRInstanceExists(_frl__vars.target))) {
{
scrFRMotionAddCT(point_direction(x, y, _frl__vars.target.x, _frl__vars.target.y), 0.2);
;
}
}
break;
;
case 6:
if (((sprite_index == sprLilHunterLand) && (z < (- 160)))) {
{
if (scrFRInstanceExists(_frl__vars.target)) {
{
x = _frl__vars.target.x;
;
y = _frl__vars.target.y;
;
}
}
}
}
break;
;
case 7:

case 8:
var _frl__spd = scrFRSourceScale();
;
if (scrFRInstanceExists(Player)) {
{
var _frl__ox = lengthdir_x(_frl__spd, _frl__lastDir);
var _frl__oy = lengthdir_y(_frl__spd, _frl__lastDir);
;
if (place_free((x - _frl__ox), y)) {
x -= _frl__ox;
}
if (place_free(x, (y - _frl__oy))) {
y -= _frl__oy;
}
}
}
if (scrFRInstanceExists(_frl__vars.target)) {
{
mp_potential_step(_frl__vars.target.x, _frl__vars.target.y, _frl__spd, false);
;
}
}
break;
;
case 9:

case 10:
var _frl__inst = scrFRMatching(PopoShield, "creator", scrFRSelf(self));
;
if (array_length(_frl__inst)) {
{ var __fr_with44 = scrFRWithValues(_frl__inst), __fr_break46=false;
for (var __fr_index45=0; __fr_index45<array_length(__fr_with44); ++__fr_index45) {
if(scrFRScopeExists(__fr_with44[__fr_index45])) with (__fr_with44[__fr_index45]) {
{
var __fr_other47=scrFROther(other);
team = __fr_other47.team;
;
}
}
if(__fr_break46) break;
}}
}
break;
;
case 11:

case 12:
if ((control == true)) {
{
var _frl__inst = scrFRMatching([Player, Ally], "team", team);
;
if (array_length(_frl__inst)) {
{
var _frl__dis = ((1 + (scrFRObjectIndex(scrFRSelf(self)) == EliteInspector)) * scrFRSourceScale());
;
{ var __fr_with48 = scrFRWithValues(_frl__inst), __fr_break50=false;
for (var __fr_index49=0; __fr_index49<array_length(__fr_with48); ++__fr_index49) {
if(scrFRScopeExists(__fr_with48[__fr_index49])) with (__fr_with48[__fr_index49]) {
{
if ((point_distance(x, y, (scrFROther(other)).x, (scrFROther(other)).y) < 160)) {
{
var _frl__dir = point_direction(x, y, (scrFROther(other)).x, (scrFROther(other)).y);
var _frl__ox = lengthdir_x(_frl__dis, _frl__dir);
var _frl__oy = lengthdir_y(_frl__dis, _frl__dir);
;
if (place_free((x + _frl__ox), y)) {
x -= _frl__ox;
}
if (place_free(x, (y + _frl__oy))) {
y -= _frl__oy;
}
}
}
}
}
if(__fr_break50) break;
}}
}
}
}
}
break;
;
case 13:
if (((ammo > 0) && scrFRInstanceExists(_frl__vars.target))) {
{
var _frl__player = instance_nearest(x, y, Player);
;
if (scrFRInstanceExists(_frl__player)) {
{
gunangle = point_direction(x, y, _frl__player.x, _frl__player.y);
;
if ((abs(angle_difference(point_direction(x, y, _frl__vars.target.x, _frl__vars.target.y), (gunangle + gunoffset))) > 10)) {
{
gunoffset = (angle_difference(point_direction(x, y, _frl__vars.target.x, _frl__vars.target.y), gunangle) + orandom(10));
;
}
}
}
}
}
}
break;
;
}
}
}
}
}
} else {
if (array_length(_frl__vars.on_step)) {
{
on_step = _frl__vars.on_step;
;
_frl__vars.on_step = [];
;
}
}
}
if ((scrFRInstanceIs(scrFRSelf(self), hitme) || scrFRInstanceIs(scrFRSelf(self), becomenemy))) {
{
if ((scrFRSourceRandom(200) < scrFRSourceScale())) {
{
{ var __fr_with51 = scrFRWithValues(scrFRInstanceCreate((x + orandom(8)), (y - scrFRSourceRandom(8)), AllyDamage)), __fr_break53=false;
for (var __fr_index52=0; __fr_index52<array_length(__fr_with51); ++__fr_index52) {
if(scrFRScopeExists(__fr_with51[__fr_index52])) with (__fr_with51[__fr_index52]) {
{
sprite_index = scrFRAreaSourceSprite(sprHealFX);
;
image_xscale *= scrFRSourceRandomRange((2 / 3), 1);
;
image_yscale = image_xscale;
;
var __fr_other54=scrFROther(other);
scrFRMotionAdd(__fr_other54.direction, 1);
;
speed /= 2;
;
}
}
if(__fr_break53) break;
}}
}
}
if (((_frl__vars.kill && scrFRInstanceIs(scrFRSelf(self), enemy)) && (! array_length(scrFRMatchingNE(scrFRMatchingNE(enemy, "team", team), "object_index", Van))))) {
{
scrFRCharmInstance(scrFRSelf(self), false);
;
}
} else {
if ((_frl__vars.time >= 0)) {
{
_frl__vars.time -= min(_frl__vars.time, scrFRSourceScale());
;
if (((_frl__vars.time <= 0) && scrFRInstanceIs(scrFRSelf(self), hitme))) {
{
scrFRCharmInstance(scrFRSelf(self), false);
;
}
}
}
}
}
{ var __fr_switch_value55=scrFRObjectIndex(scrFRSelf(self)), __fr_switch_case56=-1;
if(__fr_switch_case56==-1 && __fr_switch_value55==(BigMaggot)) __fr_switch_case56=0;
if(__fr_switch_case56==-1 && __fr_switch_value55==(MaggotSpawn)) __fr_switch_case56=1;
if(__fr_switch_case56==-1 && __fr_switch_value55==(JungleFly)) __fr_switch_case56=2;
if(__fr_switch_case56==-1 && __fr_switch_value55==(FiredMaggot)) __fr_switch_case56=3;
if(__fr_switch_case56==-1 && __fr_switch_value55==(RatkingRage)) __fr_switch_case56=4;
if(__fr_switch_case56==-1 && __fr_switch_value55==(InvSpider)) __fr_switch_case56=5;
if(__fr_switch_case56==-1) __fr_switch_case56=-1;
switch(__fr_switch_case56) {
case 0:

case 1:

case 2:

case 3:

case 4:

case 5:
if ((((hp <= 0) || ((scrFRObjectIndex(scrFRSelf(self)) == FiredMaggot) && scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall))) || (((scrFRObjectIndex(scrFRSelf(self)) == RatkingRage) && (walk > 0)) && (walk <= scrFRSourceScale())))) {
{
var _frl__minID = instance_max;
;
scrFRInstanceDestroy();
;
{ var __fr_with57 = scrFRWithValues(scrFRMatchingGT(charm_object, "id", _frl__minID)), __fr_break59=false;
for (var __fr_index58=0; __fr_index58<array_length(__fr_with57); ++__fr_index58) {
if(scrFRScopeExists(__fr_with57[__fr_index58])) with (__fr_with57[__fr_index58]) {
{
var __fr_other60=scrFROther(other);
creator = __fr_other60;
;
}
}
if(__fr_break59) break;
}}
}
}
break;
;
}
}
}
} else {
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
_frl__vars.charmed = false;
;
}
}
}
}
} else {
_frl__vars.charmed = false;
}
;
}
} else {
{
var _frl__pos = scrFRArrayFindIndex(charm_instance_list, scrFRSelf(self));
;
charm_instance_list = scrFRArrayDelete(charm_instance_list, _frl__pos);
;
charm_instance_vars = scrFRArrayDelete(charm_instance_vars, _frl__pos);
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
}

// Original dependencies/libCharm.mod.gml:564
function fr_dependencies_libCharm_mod_gml_charm_instance_raw() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libCharm_mod_gml_charm_instance_raw_resume, id, scrFROther(other), _args, 23, ["_inst", "_charm"]);
}
function fr_dependencies_libCharm_mod_gml_charm_instance_raw_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libCharm_mod_gml_charm_instance_raw");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libCharm.mod.gml:791
{
;
}
_fr.pc=0;
break;
case 2: // dependencies/libCharm.mod.gml:791
_fr.result=noone; _fr.done=true; return;
break;
case 3: // dependencies/libCharm.mod.gml:788
{
;
}
_fr.pc=2;
break;
case 4: // dependencies/libCharm.mod.gml:784
_fr.result=((is_array(_fr.vars._inst) || (array_length(_fr.vars._instVars) > 1)) ? _fr.vars._instVars : scrFRIndexGet(_fr.vars._instVars, 0)); _fr.done=true; return;
break;
case 5: // dependencies/libCharm.mod.gml:783
_fr.pc = (array_length(_fr.vars._instVars)) ? 4 : 2;
break;
case 6: // dependencies/libCharm.mod.gml:576
scrFRTaskWithNext(_fr);
break;
case 7: // dependencies/libCharm.mod.gml:576
scrFRTaskWithAbort(_fr);
break;
case 8: // dependencies/libCharm.mod.gml:777
{
_fr.vars._vars.charmed = _fr.vars._charm;
;
array_push(_fr.vars._instVars, _fr.vars._vars);
;
}
_fr.pc=6;
break;
case 9: // dependencies/libCharm.mod.gml:640
{
if (_fr.vars._charm) {
{
if ((string_pos("Custom", object_get_name(scrFRObjectIndex(scrFRSelf(self)))) == 1)) {
{
if (((! array_length(_fr.vars._vars.on_step)) && is_array(on_step))) {
{
_fr.vars._vars.on_step = on_step;
;
on_step = ["mod", "libCharm", fr_dependencies_libCharm_mod_gml_charm_obj_step];
;
}
}
}
} else {
{
_fr.vars.i = 0;
for (; (_fr.vars.i <= 10); _fr.vars.i++) {
if ((scrFRAlarmRead(scrFRSelf(self), _fr.vars.i) > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), _fr.vars.i, (scrFRAlarmRead(scrFRSelf(self), _fr.vars.i) + 1));
;
}
}
}
}
}
{ var __fr_switch_value1=sprite_index, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprReviveArea)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprNecroReviveArea)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
sprite_index = scrFRAreaSourceSprite(spr.AllyReviveArea);
;
break;
;
case 1:
sprite_index = scrFRAreaSourceSprite(spr.AllyNecroReviveArea);
;
break;
;
}
}
if ((scrFRArrayFindIndex(charm_instance_list, scrFRSelf(self)) < 0)) {
{
array_push(charm_instance_list, scrFRSelf(self));
;
array_push(charm_instance_vars, _fr.vars._vars);
;
}
}
}
} else {
{
if ((scrFRInstanceIs(scrFRSelf(self), hitme) || scrFRInstanceIs(scrFRSelf(self), becomenemy))) {
{
if (scrFRInstanceIs(scrFRSelf(self), enemy)) {
{
target = noone;
;
if ((canmelee == true)) {
{
scrFRAlarmWrite(scrFRSelf(self), 11, 30, "=");
;
canmelee = false;
;
}
}
}
}
if (_fr.vars._vars.kill) {
{
if (scrFRVariableExists(scrFRSelf(self), "my_health")) {
{
hp = 0;
;
scrFRSoundPitchVolume(sndEnemyDie, (2 + orandom(0.3)), 3);
;
}
}
}
} else {
{
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, (bbox_top - _fr.vars._lastZ), HitWarning)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
var __fr_other6=scrFROther(other);
depth = min((- 7), (__fr_other6.depth - 1));
;
}
}
if(__fr_break5) break;
}}
scrFRSoundHitExt(sndAssassinGetUp, scrFRSourceRandomRange(1.2, 1.5), 1.2);
;
}
}
_fr.vars._num = ((scrFRVariableExists(scrFRSelf(self), "size") && (size == 0)) ? 5 : 10);
;
{
_fr.vars._ang = direction;
for (; (_fr.vars._ang < (direction + 360)); _fr.vars._ang += (360 / _fr.vars._num)) {
{ var __fr_with7 = scrFRWithValues(scrFX(x, (y - _fr.vars._lastZ), [_fr.vars._ang, 4], Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth + 1);
;
}
}
if(__fr_break9) break;
}}
}
}
}
}
if ((sprite_index == spr.AllyReviveArea)) {
{
sprite_index = scrFRAreaSourceSprite(sprReviveArea);
;
}
} else {
if ((sprite_index == spr.AllyNecroReviveArea)) {
{
sprite_index = scrFRAreaSourceSprite(sprNecroReviveArea);
;
}
}
}
if (array_length(_fr.vars._vars.on_step)) {
{
on_step = _fr.vars._vars.on_step;
;
_fr.vars._vars.on_step = [];
;
}
}
}
}
if ((scrFRObjectIndex(scrFRSelf(self)) != _fr.vars._lastObject)) {
{
_fr.vars._lastMask = mask_index;
_fr.vars._lastSprite = sprite_index;
_fr.vars._lastImage = image_index;
_fr.vars._lastDepth = depth;
_fr.vars._lastVisible = visible;
_fr.vars._lastPersistent = persistent;
_fr.vars._lastSolid = solid;
;
instance_change(_fr.vars._lastObject, false);
;
mask_index = _fr.vars._lastMask;
;
sprite_index = scrFRAreaSourceSprite(_fr.vars._lastSprite);
;
image_index = _fr.vars._lastImage;
;
depth = _fr.vars._lastDepth;
;
visible = _fr.vars._lastVisible;
;
persistent = _fr.vars._lastPersistent;
;
solid = _fr.vars._lastSolid;
;
}
}
if (scrFRInstanceIs(scrFRSelf(self), hitme)) {
{
_fr.vars._searchDis = 32;
;
scrFRMotionStep(1);
;
if ((distance_to_object(projectile) <= _fr.vars._searchDis)) {
{
{ var __fr_with11 = scrFRWithValues(scrFRInstanceRectangleBBox((bbox_left - _fr.vars._searchDis), (bbox_top - _fr.vars._searchDis), (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right") + _fr.vars._searchDis), (scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom") + _fr.vars._searchDis), scrFRMatching(scrFRMatching(projectile, "team", _fr.vars._vars.team), "creator", scrFRSelf(self)))), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
scrFRMotionStep(1);
;
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
var __fr_other14=scrFROther(other);
team = __fr_other14.team;
;
if ((scrFRSpriteTeam(sprite_index) != 3)) {
{
scrFRTeamInstanceSprite(team, scrFRSelf(self));
;
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
continue;
;
}
}
}
}
}
}
scrFRMotionStep((- 1));
;
}
}
if(__fr_break13) break;
}}
}
}
scrFRMotionStep((- 1));
;
}
}
}
_fr.pc=8;
break;
case 10: // dependencies/libCharm.mod.gml:636
{
;
}
_fr.pc=9;
break;
case 11: // dependencies/libCharm.mod.gml:636
_fr.result=undefined; _fr.done=true; return;
break;
case 12: // dependencies/libCharm.mod.gml:630
{
if (scrFRVariableExists(scrFRSelf(self), "team")) {
{
_fr.vars._lastTeam = team;
;
team = _fr.vars._vars.team;
;
_fr.vars._vars.team = _fr.vars._lastTeam;
;
}
}
}
_fr.pc=11;
break;
case 14: // dependencies/libCharm.mod.gml:624
{
;
}
_fr.pc=13;
break;
case 15: // dependencies/libCharm.mod.gml:624
_fr.wait_ticks=max(0,0); _fr.pc=14; return;
break;
case 13: // dependencies/libCharm.mod.gml:623
_fr.pc=((scrFRInstanceIs(scrFRSelf(_fr.scope), becomenemy) && (!scrFRVariableExists(scrFRSelf(_fr.scope), "team"))))?15:12;
break;
case 16: // dependencies/libCharm.mod.gml:599
try { {
if ((! undefined)) {
{
_fr.vars._lastMask = mask_index;
_fr.vars._lastSprite = sprite_index;
_fr.vars._lastImage = image_index;
_fr.vars._lastDepth = depth;
_fr.vars._lastVisible = visible;
_fr.vars._lastPersistent = persistent;
_fr.vars._lastSolid = solid;
;
instance_change(FRCustomEnemy, false);
;
mask_index = _fr.vars._lastMask;
;
sprite_index = scrFRAreaSourceSprite(_fr.vars._lastSprite);
;
image_index = _fr.vars._lastImage;
;
depth = _fr.vars._lastDepth;
;
visible = _fr.vars._lastVisible;
;
persistent = _fr.vars._lastPersistent;
;
solid = _fr.vars._lastSolid;
;
}
}
}
_fr.pc=12; } catch(__fr_caught15) { _fr.vars._error=__fr_caught15; _fr.pc=13; }
break;
case 17: // dependencies/libCharm.mod.gml:597
_fr.pc = (scrFRInstanceIs(scrFRSelf(_fr.scope), becomenemy)) ? 16 : 12;
break;
case 18: // dependencies/libCharm.mod.gml:596
_fr.pc = (scrFRTaskFork(_fr, 17)) ? 17 : 9;
break;
case 19: // dependencies/libCharm.mod.gml:585
{
if (_fr.vars._charm) {
{
_fr.vars._varsDefault = charm_vars;
;
{
_fr.vars.i = (scrFRLQSize(_fr.vars._varsDefault) - 1);
for (; (_fr.vars.i >= 0); _fr.vars.i--) {
scrFRLQSet(_fr.vars._vars, scrFRLQKey(_fr.vars._varsDefault, _fr.vars.i), scrFRLQValue(_fr.vars._varsDefault, _fr.vars.i));
;
}
}
}
}
_fr.vars._lastObject = scrFRObjectIndex(scrFRSelf(self));
_fr.vars._lastZ = (scrFRVariableExists(scrFRSelf(self), "z") ? abs(z) : 0);
;
}
_fr.pc=18;
break;
case 20: // dependencies/libCharm.mod.gml:583
_fr.pc = ((_fr.vars._charm ^^ _fr.vars._vars.charmed)) ? 19 : 8;
break;
case 21: // dependencies/libCharm.mod.gml:577
{
if ((!scrFRVariableExists(scrFRSelf(self), "ntte_charm"))) {
{
ntte_charm = charm_vars;
;
}
}
_fr.vars._vars = ntte_charm;
;
}
_fr.pc=20;
break;
case 22: // dependencies/libCharm.mod.gml:576
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRMatchingNE(_fr.vars._inst, "id", undefined)),21,5);
break;
case 23: // dependencies/libCharm.mod.gml:574
{
_fr.vars._instVars = [];
;
}
_fr.pc=22;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libCharm.mod.gml:793
function fr_dependencies_libCharm_mod_gml_charm_target(_frl__vars=undefined) {
var _frl__playerPos = [];
var _frl__targetCrash = ((! scrFRInstanceExists(Player)) && scrFRInstanceIs(scrFRSelf(self), Grunt));
;
if (((((((! scrFRInstanceExists(_frl__vars.target)) || collision_line(x, y, _frl__vars.target.x, _frl__vars.target.y, Wall, false, false)) || (! scrFRInstanceIs(_frl__vars.target, hitme))) || (_frl__vars.target.team == scrFRVariableGet(scrFRSelf(self), "team"))) || (_frl__vars.target.team == scrFRVariableGet(scrFRPlayerFind(_frl__vars.index), "team"))) || (_frl__vars.target.mask_index == mskNone))) {
{
_frl__vars.target = noone;
;
var _frl__inst = scrFRMatchingNE(scrFRMatchingNE([enemy, Player, Sapling, Ally, SentryGun, FRCustomHitme], "team", 0), "mask_index", mskNone);
;
if (array_length(_frl__inst)) {
{
if (scrFRVariableExists(scrFRSelf(self), "team")) {
{
_frl__inst = scrFRMatchingNE(_frl__inst, "team", team);
;
}
}
if (scrFRPlayerIsActive(_frl__vars.index)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRPlayerFind(_frl__vars.index)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
_frl__inst = scrFRMatchingNE(_frl__inst, "team", team);
;
}
}
if(__fr_break3) break;
}}
}
}
var _frl__disMax = infinity;
;
if (array_length(_frl__inst)) {
{ var __fr_with4 = scrFRWithValues(_frl__inst), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__dis = point_distance(x, y, (scrFROther(other)).x, (scrFROther(other)).y);
;
if ((_frl__dis < _frl__disMax)) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{
_frl__disMax = _frl__dis;
;
_frl__vars.target = scrFRSelf(self);
;
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
if (scrFRVariableExists(scrFRSelf(self), "target")) {
{
if ((! _frl__targetCrash)) {
{
target = _frl__vars.target;
;
}
}
{ var __fr_with7 = scrFRWithValues(Player), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
array_push(_frl__playerPos, [scrFRSelf(self), x, y]);
;
if (scrFRInstanceExists(_frl__vars.target)) {
{
x = _frl__vars.target.x;
;
y = _frl__vars.target.y;
;
}
} else {
{
var _frl__l = 10000;
var _frl__d = scrFRSourceRandom(360);
;
x += lengthdir_x(_frl__l, _frl__d);
;
y += lengthdir_y(_frl__l, _frl__d);
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
return _frl__playerPos;
;
}

// Original dependencies/libCharm.mod.gml:865
function fr_dependencies_libCharm_mod_gml_charm_grab(_frl__vars=undefined, _frl__minID=undefined) {
if ((scrFRInstanceExists(FR_OBJECT_GAME) && (scrFRVariableGet(scrFRInstanceFind(FR_OBJECT_GAME, 0), "id") > _frl__minID))) {
{
var _frl__inst = scrFRMatching(scrFRMatchingGT(charm_object, "id", _frl__minID), "creator", undefined, noone);
;
if (array_length(_frl__inst)) {
{
var _frl__creator = ((scrFRVariableExists(scrFRSelf(self), "creator") && (! scrFRInstanceIs(scrFRSelf(self), hitme))) ? creator : scrFRSelf(self));
;
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
creator = _frl__creator;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRInstanceExists(projectile) || scrFRInstanceExists(LaserCannon))) {
{
var _frl__inst = scrFRMatchingGT([projectile, LaserCannon], "id", _frl__minID);
;
if (array_length(_frl__inst)) {
{
if ((scrFRVariableExists(scrFRSelf(self), "creator") && (! scrFRInstanceIs(scrFRSelf(self), hitme)))) {
{
_frl__inst = scrFRMatching(_frl__inst, "creator", scrFRSelf(self), noone, creator);
;
}
} else {
{
_frl__inst = scrFRMatching(_frl__inst, "creator", scrFRSelf(self), noone);
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

// Original dependencies/libCharm.mod.gml:898
function fr_dependencies_libCharm_mod_gml_charm_obj_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libCharm_mod_gml_charm_obj_step_resume, id, scrFROther(other), _args, 8, []);
}
function fr_dependencies_libCharm_mod_gml_charm_obj_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libCharm_mod_gml_charm_obj_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libCharm.mod.gml:913
{
{ var __fr_with1 = scrFRWithValues(_fr.vars._playerPos), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(scrFRSelf(self), 0)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
x = scrFRIndexGet(__fr_other7, 1);
;
var __fr_other8=scrFROther(other);
y = scrFRIndexGet(__fr_other8, 2);
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
if (scrFRInstanceExists(scrFRSelf(self))) {
{
_fr.vars._vars.on_step = on_step;
;
on_step = ["mod", "libCharm", fr_dependencies_libCharm_mod_gml_charm_obj_step];
;
}
}
fr_dependencies_libCharm_mod_gml_charm_grab(_fr.vars._vars, _fr.vars._minID);
;
}
_fr.pc=0;
break;
case 2: // dependencies/libCharm.mod.gml:909
{
;
}
_fr.pc=1;
break;
case 3: // dependencies/libCharm.mod.gml:909
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // dependencies/libCharm.mod.gml:906
{
on_step = _fr.vars._vars.on_step;
;
_fr.vars._vars.on_step = [];
;
scrFRScriptCall(on_step);
;
}
_fr.pc=3;
break;
case 5: // dependencies/libCharm.mod.gml:905
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 6: // dependencies/libCharm.mod.gml:901
{
_fr.vars._minID = instance_max;
_fr.vars._playerPos = fr_dependencies_libCharm_mod_gml_charm_target(_fr.vars._vars);
;
}
_fr.pc=5;
break;
case 7: // dependencies/libCharm.mod.gml:900
_fr.pc = ((array_length(_fr.vars._vars.on_step) >= 3)) ? 6 : 0;
break;
case 8: // dependencies/libCharm.mod.gml:899
{
_fr.vars._vars = ntte_charm;
;
}
_fr.pc=7;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libCharm.mod.gml:930
function fr_dependencies_libCharm_mod_gml_charm_draw(_frl__inst=undefined, _frl__index=undefined) {
if (array_length(_frl__inst)) {
{
if (lag) {
scrFRTraceTime();
}
var _frl__outline = scrNTTEFullOptionGet("outline:charm");
;
if ((_frl__outline || scrNTTEFullOptionGet("shaders"))) {
{
if ((_frl__index < 0)) {
{
_frl__index = scrFRPlayerFindLocal();
;
}
}
var _frl__vx = scrFRViewCoordinate(0);
var _frl__vy = scrFRViewCoordinate(1);
var _frl__gw = view_width;
var _frl__gh = view_height;
;
{ var __fr_with1 = scrFRWithValues(scrFRSurfaceSetup("CharmScreen", _frl__gw, _frl__gh, game_scale_nonsync)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
x = _frl__vx;
;
y = _frl__vy;
;
gpu_set_blendmode_ext(bm_one, bm_zero);
;
scrFRSurfaceScreenshot(surf);
;
gpu_set_blendmode(bm_normal);
;
draw_clear_alpha(c_black, 0);
;
var _frl__lastTimeScale = scrFRSourceScale();
;
scrFRSourceScaleSet((1 / 1000000000000000));
;
try {
{ var __fr_with4 = scrFRWithValues(scrFRInstancesSeen(_frl__inst, 24, 24, (- 1))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRSelf(self)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
event_perform(ev_draw, 0);
;
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break6) break;
}}
} catch(__fr_caught10) { var _frl__error=__fr_caught10;
{
scrFRTrace(_frl__error);
;
}
}
scrFRSourceScaleSet(_frl__lastTimeScale);
;
{ var __fr_with11 = scrFRWithValues(scrFRSurfaceSetup("Charm", w, h, (_frl__outline ? scrNTTEFullOptionGet("quality:main") : scale))), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
x = __fr_other14.x;
;
var __fr_other15=scrFROther(other);
y = __fr_other15.y;
;
gpu_set_blendmode_ext(bm_one, bm_zero);
;
scrFRSurfaceScreenshot(surf);
;
if (scrFRShaderSetup("Unblend", surface_get_texture(surf), [1])) {
{
scrFRDrawSurfaceScale(surf, x, y, (1 / scale));
;
shader_reset();
;
scrFRSurfaceScreenshot(surf);
;
}
} else {
{
gpu_set_blendmode_ext(bm_inv_src_alpha, bm_one);
;
scrFRSurfaceScreenshot(surf);
;
gpu_set_blendmode_ext(bm_one, bm_zero);
;
}
}
{ var __fr_with16 = scrFRWithValues((scrFROther(other))), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDrawSurfaceScale(surf, x, y, (1 / scale));
;
}
}
if(__fr_break18) break;
}}
gpu_set_blendmode(bm_normal);
;
if (_frl__outline) {
{
var __fr_other19=scrFROther(other);
surface_set_target(__fr_other19.surf);
;
gpu_set_fog(true, scrFRPlayerColor(_frl__index), 0, 0);
;
{
var _frl__ang = 0;
for (; (_frl__ang < 360); _frl__ang += 90) {
var __fr_other20=scrFROther(other);
scrFRDrawSurfaceScale(surf, (((x - __fr_other20.x) + dcos(_frl__ang)) * __fr_other20.scale), (((y - __fr_other20.y) - dsin(_frl__ang)) * __fr_other20.scale), (__fr_other20.scale / scale));
;
}
}
gpu_set_fog(false, 0, 0, 0);
;
gpu_set_blendmode_ext(bm_zero, bm_inv_src_alpha);
;
var __fr_other21=scrFROther(other);
scrFRDrawSurfaceScale(surf, ((x - __fr_other21.x) * __fr_other21.scale), ((y - __fr_other21.y) * __fr_other21.scale), (__fr_other21.scale / scale));
;
gpu_set_blendmode(bm_normal);
;
surface_reset_target();
;
{ var __fr_with22 = scrFRWithValues((scrFROther(other))), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
scrFRDrawSurfaceScale(surf, x, y, (1 / scale));
;
}
}
if(__fr_break24) break;
}}
}
}
if (scrFRShaderSetup("Charm", surface_get_texture(surf), [w, h])) {
{
scrFRDrawSurfaceScale(surf, x, y, (1 / scale));
;
shader_reset();
;
}
}
}
}
if(__fr_break13) break;
}}
}
}
if(__fr_break3) break;
}}
}
}
if (lag) {
scrFRTraceTime(((scrFRIndexGet(script, 2) + " ") + string(_frl__index)));
}
}
}
}

// Original dependencies/libCharm.mod.gml:1043
function fr_dependencies_libCharm_mod_gml_charm_sniper_gunangle(_frl__inst=undefined, _frl__direction=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
gunangle = _frl__direction;
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
