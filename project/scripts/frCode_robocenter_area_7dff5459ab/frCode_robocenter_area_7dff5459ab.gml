#macro frMacro_Areas_robocenter_area_gml_scr global.fr_module_vars[$ "area:robocenter"].scr

#macro frMacro_Areas_robocenter_area_gml_call scrFRScriptCall

#macro frMacro_Areas_robocenter_area_gml_minSearchDiff 1

#macro frMacro_Areas_robocenter_area_gml_lasertrap_spawnchance 60

#macro frMacro_Areas_robocenter_area_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Areas_robocenter_area_gml_current_frame_active (scrFRSourceFrame() < (floor(scrFRSourceFrame()) + scrFRSourceScale()))

// Original Areas/robocenter.area.gml:1
function fr_Areas_robocenter_area_gml___load() {

}

// Original Areas/robocenter.area.gml:1
function fr_Areas_robocenter_area_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_robocenter_area_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Areas_robocenter_area_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_robocenter_area_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/robocenter.area.gml:9
{
scrFRScriptCall(["mod", "lib", "getRef"], "area", "robocenter", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "area:robocenter"].musRobocenter = sndFR_musRobocenter_5505c0f16c1d;
;
global.fr_module_vars[$ "area:robocenter"].ambRobocenter = sndFR_ambRobocenter_5d99ad0ee98f;
;
global.fr_module_vars[$ "area:robocenter"].sprAreaIcon = sprFR_sprLabsRouteIcon_654cbb1bced6;
;
global.fr_module_vars[$ "area:robocenter"].sprFloor = sprFR_sprFloorRobocenterBig_bdcca9ec02c4;
;
global.fr_module_vars[$ "area:robocenter"].sprFloorB = sprFR_sprFloorRobocenterB_bee5baccf0b1;
;
global.fr_module_vars[$ "area:robocenter"].sprFloorExplo = sprFR_sprFloorRobocenterExplo_218d3ecef6e3;
;
global.fr_module_vars[$ "area:robocenter"].sprWallBot = sprFR_sprWallRobocenterBot_2eb16a349ae9;
;
global.fr_module_vars[$ "area:robocenter"].sprWallTop = sprFR_sprWallRobocenterTop_d444b56f758f;
;
global.fr_module_vars[$ "area:robocenter"].sprWallOut = sprFR_sprWallRobocenterOut_b84958b93c58;
;
global.fr_module_vars[$ "area:robocenter"].sprWallTrans = sprFR_sprWallRobocenterTrans_2458aa7e3617;
;
global.fr_module_vars[$ "area:robocenter"].sprDebris = sprFR_sprDebrisRobocenter_425660147973;
;
global.fr_module_vars[$ "area:robocenter"].sprDetail = sprFR_sprDetailRobocenter_ce6dcf36bb9a;
;
global.fr_module_vars[$ "area:robocenter"].sprTopDecal = sprFR_sprTopDecalRobocenter_af15858d2a9f;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrap = sprFR_sprLaserTrap_cec77aaec56e;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapGameover = sprFR_sprLaserTrap_040058884af7;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeam = sprFR_sprLaserTrapBeam_7e0265d2a83e;
;
global.fr_module_vars[$ "area:robocenter"].mskLaserTrapBeam = sprFR_mskLaserTrapBeam_f1734486c953;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeamEnd = sprFR_sprLaserTrapBeamEnd_fe4f63251cab;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeamStart = sprFR_sprLaserTrapBeamStart_61f54fe29304;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapHead = sprFR_sprLaserTrapHead_33067a73fd0d;
global.fr_module_vars[$ "area:robocenter"].sprWarningLaser = sprFR_sprWarningLaser_ff894a34491e;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapTop = sprFR_sprLaserTrapTop_8786b8970fce;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapOff = sprFR_sprLaserTrapOff_cb73f0bea908;
;
global.fr_module_vars[$ "area:robocenter"].sprLaserTrapTopOff = sprFR_sprLaserTrapTopOff_2c784f4731b7;
;
global.fr_module_vars[$ "area:robocenter"].mskBattery = sprFR_mskBattery_ab0cb8616f47;
;
global.fr_module_vars[$ "area:robocenter"].sprBattery = sprFR_sprBattery_7c15ce6d5294;
;
global.fr_module_vars[$ "area:robocenter"].sprBatteryHurt = sprFR_sprBatteryHurt_f6ad3ea5cae0;
;
global.fr_module_vars[$ "area:robocenter"].sprBatteryDead = sprFR_sprBatteryDead_2c811fa746aa;
;
global.fr_module_vars[$ "area:robocenter"].mskAssembler = sprFR_mskAssembler_69f7b6cc564d;
;
global.fr_module_vars[$ "area:robocenter"].sprAssembler = sprFR_sprAssembler_7bda02d24785;
;
global.fr_module_vars[$ "area:robocenter"].sprAssemblerHurt = sprFR_sprAssemblerHurt_2ac1170e27af;
;
global.fr_module_vars[$ "area:robocenter"].sprAssemblerDead = sprFR_sprAssemblerDead_5b9d6f933a7f;
;
global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceClosed = sprFR_sprDeeplabsEntrance_4d3ec9c05559;
;
global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceOpening = sprFR_sprDeeplabsEntranceOpeni_f74aa8214b3b;
;
global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceOpen = sprFR_sprDeeplabsEntranceOpen_abc1f87998e5;
;
; // macro hoisted: minSearchDiff
; // macro hoisted: lasertrap_spawnchance
; // macro hoisted: anim_end
; // macro hoisted: current_frame_active
global.fr_module_vars[$ "area:robocenter"].arenaGened = false;
;
global.fr_module_vars[$ "area:robocenter"].settingLabsRouteAltMode = false;
;
}
_fr.pc=0;
break;
case 3: // Areas/robocenter.area.gml:8
{
;
}
_fr.pc=2;
break;
case 4: // Areas/robocenter.area.gml:8
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Areas/robocenter.area.gml:8
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/robocenter.area.gml:64
function fr_Areas_robocenter_area_gml_area_subarea() {
return 1;
;
}

// Original Areas/robocenter.area.gml:65
function fr_Areas_robocenter_area_gml_area_goal() {
return 145;
;
}

// Original Areas/robocenter.area.gml:66
function fr_Areas_robocenter_area_gml_area_next() {
return (((global.fr_module_vars[$ "area:robocenter"].settingLabsRouteAltMode == true) && (! scrFRModLoaded("area", "scorpionboss"))) ? [7, 1] : (scrFRModLoaded("area", "scorpionboss") ? ["labs", 1] : [6, 1]));
;
}

// Original Areas/robocenter.area.gml:67
function fr_Areas_robocenter_area_gml_area_background_color() {
return make_color_rgb(21, 21, 39);
;
}

// Original Areas/robocenter.area.gml:68
function fr_Areas_robocenter_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/robocenter.area.gml:69
function fr_Areas_robocenter_area_gml_area_darkness() {
return true;
;
}

// Original Areas/robocenter.area.gml:70
function fr_Areas_robocenter_area_gml_area_secret() {
return false;
;
}

// Original Areas/robocenter.area.gml:71
function fr_Areas_robocenter_area_gml_area_outside() {
return false;
;
}

// Original Areas/robocenter.area.gml:73
function fr_Areas_robocenter_area_gml_area_name() {
return scrFRLocalize(((global.fr_module_vars[$ "area:robocenter"].settingLabsRouteAltMode == true) ? (("@1(" + string(real(global.fr_module_vars[$ "area:robocenter"].sprAreaIcon)) + ":0)6-") + string(GameCont.subarea)) : (("@1(" + string(real(global.fr_module_vars[$ "area:robocenter"].sprAreaIcon)) + ":0)2-") + string(GameCont.subarea))));
;
}

// Original Areas/robocenter.area.gml:76
function fr_Areas_robocenter_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("DOING WORK", "WATCH OUT FOR THE BEAMS", "ASSEMBLERS", "THE ANSWER IS BENEATH US", "ONE MILLION SPRINGS"));
;
}

// Original Areas/robocenter.area.gml:85
function fr_Areas_robocenter_area_gml_area_mapdata(_frl__x=undefined, _frl__y=undefined) {
return [99, (- 9)];
;
}

// Original Areas/robocenter.area.gml:88
function fr_Areas_robocenter_area_gml_area_areaicon() {
return [global.fr_module_vars[$ "area:robocenter"].sprAreaIcon, ((global.fr_module_vars[$ "area:robocenter"].settingLabsRouteAltMode == true) ? ("6-" + string(GameCont.subarea)) : ("2-" + string(GameCont.subarea)))];
}

// Original Areas/robocenter.area.gml:94
function fr_Areas_robocenter_area_gml_area_sprite(_frl__sprite=undefined) {
{ var __fr_switch_value1=_frl__sprite, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1B)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1Explo)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Trans)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Bot)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Out)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Top)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprDebris1)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprDetail1)) __fr_switch_case2=8;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_robocenter_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:robocenter"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_robocenter_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:robocenter"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:robocenter"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:robocenter"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:robocenter"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:robocenter"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:robocenter"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:robocenter"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:robocenter"].sprDetail;
;
}
}
}

// Original Areas/robocenter.area.gml:108
function fr_Areas_robocenter_area_gml_area_setup() {
scrFRSoundMusic(global.fr_module_vars[$ "area:robocenter"].musRobocenter);
scrFRSoundAmbient(global.fr_module_vars[$ "area:robocenter"].ambRobocenter);
;
goal = fr_Areas_robocenter_area_gml_area_goal();
;
background_set_colour(fr_Areas_robocenter_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_robocenter_area_gml_area_shadow_color();
;
TopCont.darkness = fr_Areas_robocenter_area_gml_area_darkness();
;
safespawn = 1;
;
scrFRSoundAssign(sndWallBreakRock, sndWallBreakLabs);
;
}

// Original Areas/robocenter.area.gml:122
function fr_Areas_robocenter_area_gml_area_setup_floor() {
if (styleb) {
{
depth += 1;
;
}
}
material = 3;
;
}

// Original Areas/robocenter.area.gml:131
function fr_Areas_robocenter_area_gml_area_start() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRSourceRandom(20) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, TopDecalCity)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
name = "fr_RobocenterDecal";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprTopDecal);
;
image_speed = (0.4) * timescale;
;
image_xscale = scrFRSourceChoose((- 1), 1);
;
dir = scrFRSourceChoose((- 1), 1);
;
fr_glow = [48, 64];
;
}
}
if(__fr_break9) break;
}}
}
}
}
}
if(__fr_break6) break;
}}
if ((! scrFRModLoaded("mod", "betterPVP"))) {
{
{ var __fr_with10 = scrFRWithValues(fr_Areas_robocenter_area_gml_DeeplabsEntrance_create(10016, 10016)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
portalPusher = scrFRModCall("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
;
}
}
if(__fr_break12) break;
}}
}
}
var _frl_lasertrap_amount = 0;
;
{ var __fr_with13 = scrFRWithValues(Floor), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((! scrFRPlaceMeeting(x, y, ((((AmmoChest || WeaponChest) || RadChest) || prop) || enemy)))) {
{
if (((scrFRSourceRandom(frMacro_Areas_robocenter_area_gml_lasertrap_spawnchance) < 1) || (_frl_lasertrap_amount < 3))) {
{
var _frl_myx = (x + scrFRSourceChoose(0, 16));
;
var _frl_myy = (y + scrFRSourceChoose(0, 16));
;
if (((point_distance(_frl_myx, _frl_myy, Player.x, Player.y) > 90) && (distance_to_object(BigWeaponChest) > 64))) {
{
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate(_frl_myx, _frl_myy, Wall)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRInstanceCreate(x, y, NOWALLSHEREPLEASE);
fr_Areas_robocenter_area_gml_LaserTrap_create((_frl_myx + 8), (_frl_myy + 8));
;
_frl_lasertrap_amount += 1;
;
topspr = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapTop;
;
}
}
if(__fr_break18) break;
}}
}
}
}
}
}
}
}
}
if(__fr_break15) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(Floor, "fr_robobossSpawn", true)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRModCall("mod", "Frontier_Bosses", "RoboBoss_create", (x + 16), (y + 16));
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(enemy), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
if (scrFRPlaceMeeting(x, y, Wall)) {
{
var _frl__furthestFloor = instance_furthest(10016, 10016, Floor);
;
x = _frl__furthestFloor.x;
;
y = _frl__furthestFloor.y;
;
scrFRInstanceCreate(_frl__furthestFloor.x, _frl__furthestFloor.y, PortalClear);
;
}
}
}
}
if(__fr_break24) break;
}}
}

// Original Areas/robocenter.area.gml:196
function fr_Areas_robocenter_area_gml_area_make_floor() {
var _frl__x = x;
var _frl__y = y;
var _frl__outOfSpawn = (point_distance(_frl__x, _frl__y, 10000, 10000) > 48);
;
scrFRInstanceCreate(_frl__x, _frl__y, Floor);
;
if ((scrFRSourceRandom(14) < 1)) {
{
fr_Areas_robocenter_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
;
}
}
var _frl__turn = 0;
;
if ((scrFRSourceRandom(3) < 1)) {
{
_frl__turn = scrFRSourceChoose(90, 270, 270, 180);
;
}
}
direction += _frl__turn;
;
if ((_frl__outOfSpawn && (_frl__turn == 180))) {
{
scrFRInstanceCreate((_frl__x + 16), (_frl__y + 16), WeaponChest);
;
}
}
if ((scrFRSourceRandom((19 + scrFRInstanceNumber(FloorMaker))) > 20)) {
{
if (_frl__outOfSpawn) {
{
scrFRInstanceCreate((_frl__x + 16), (_frl__y + 16), AmmoChest);
;
}
}
scrFRInstanceDestroy();
;
}
}
if ((scrFRSourceRandom(7) < 1)) {
{
scrFRInstanceCreate(_frl__x, _frl__y, FloorMaker);
;
}
}
{ var __fr_with1 = scrFRWithValues(GenCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if ((((scrFRInstanceNumber(Floor) > (goal / 1.5)) && (global.fr_module_vars[$ "area:robocenter"].arenaGened == false)) && (GameCont.loops >= 1))) {
{
var _frl__furthestFloor = instance_furthest(10016, 10016, Floor);
;
{ var __fr_with4 = scrFRWithValues(_frl__furthestFloor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_robobossSpawn = true;
;
}
}
if(__fr_break6) break;
}}
fr_Areas_robocenter_area_gml_scrFloorFill(_frl__furthestFloor.x, _frl__furthestFloor.y, 7, 9);
;
fr_Areas_robocenter_area_gml_scrFloorFill(_frl__furthestFloor.x, _frl__furthestFloor.y, 9, 7);
;
global.fr_module_vars[$ "area:robocenter"].arenaGened = true;
;
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:246
function fr_Areas_robocenter_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
var _frl_o = 32;
;
_frl__x -= (floor(((_frl__w - 1) / 2)) * _frl_o);
;
_frl__y -= (floor(((_frl__h - 1) / 2)) * _frl_o);
;
{
var _frl__ox = 0;
for (; (_frl__ox < _frl__w); _frl__ox++) {
{
var _frl__oy = 0;
for (; (_frl__oy < _frl__h); _frl__oy++) {
scrFRInstanceCreate((_frl__x + (_frl__ox * _frl_o)), (_frl__y + (_frl__oy * _frl_o)), Floor);
;
}
}
}
}
}

// Original Areas/robocenter.area.gml:260
function fr_Areas_robocenter_area_gml_area_pop_enemies() {
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
;
var _frl__enemy = frMacro_Areas_robocenter_area_gml_call(frMacro_Areas_robocenter_area_gml_scr.pool, [[["Swarmbot_spawn", "MOD", "Frontier_Labs"], 2], [["Engineer_create", "MOD", "Frontier_Labs"], 2], [["MissileDrone_create", "MOD", "Frontier_Labs"], 2], [[BecomeTurret, "Basegame", ""], 1], [[Wolf, "Basegame", ""], (1 * (GameCont.loops > 0))]]);
if ((scrFRSourceRandom(2.5) < 1)) {
{
{ var __fr_switch_value1=scrFRIndexGet(_frl__enemy, 1), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Basegame")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("MOD")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("OBJ")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
scrFRInstanceCreate(_frl__x, _frl__y, scrFRIndexGet(_frl__enemy, 0));
;
}
break;
;
case 1:
{
scrFRModCall("mod", scrFRIndexGet(_frl__enemy, 2), scrFRIndexGet(_frl__enemy, 0), _frl__x, _frl__y);
}
break;
;
case 2:
{
scrFRModCall("mod", scrFRIndexGet(_frl__enemy, 2), "obj_create", _frl__x, _frl__y, scrFRIndexGet(_frl__enemy, 0));
}
break;
;
}
}
}
}
}

// Original Areas/robocenter.area.gml:290
function fr_Areas_robocenter_area_gml_area_pop_props() {
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
var _frl__outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
;
if (_frl__outOfSpawn) {
{
if (((scrFRSourceRandom(18) < 1) && (! scrFRPlaceMeeting(_frl__x, _frl__y, prop)))) {
{
var _frl__prop = frMacro_Areas_robocenter_area_gml_call(frMacro_Areas_robocenter_area_gml_scr.pool, [["Battery_create", 1], ["Assembler_create", 1]]);
;
scrFRModCall("area", "robocenter", _frl__prop, _frl__x, _frl__y);
;
}
}
}
}
}

// Original Areas/robocenter.area.gml:306
function fr_Areas_robocenter_area_gml_area_finish() {
if ((subarea < fr_Areas_robocenter_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_robocenter_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
global.fr_module_vars[$ "area:robocenter"].arenaGened = false;
;
}

// Original Areas/robocenter.area.gml:322
function fr_Areas_robocenter_area_gml_area_transit() {
scrFRSoundRestore(sndWallBreakRock);
;
scrFRSoundStop(scrFRModGet("mod", "Frontier_Bosses", "bulwarkLaserLoop"));
;
scrFRSoundStop(scrFRModGet("mod", "Frontier_Bosses", "bulwarkShockLoop"));
;
}

// Original Areas/robocenter.area.gml:331
function fr_Areas_robocenter_area_gml_LaserTrap_create(_frl__myx=undefined, _frl__myy=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__myx, _frl__myy, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (- 6);
;
spr_active = global.fr_module_vars[$ "area:robocenter"].sprLaserTrap;
;
spr_off = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapOff;
;
spr_top_active = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapTop;
;
spr_top_off = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapTopOff;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprLaserTrap);
;
creator = instance_position(x, y, Wall);
;
fire_timer = (80 + scrFRSourceIRandom(30));
;
fire_mode = scrFRSourceChoose(1, 2);
active = true;
;
on_step = fr_Areas_robocenter_area_gml_LaserTrap_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:356
function fr_Areas_robocenter_area_gml_LaserTrap_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((fire_timer > 0)) {
{
fire_timer -= scrFRSourceScale();
;
}
}
if (((active == true) && scrFRInstanceExists(Portal))) {
{
active = false;
;
sprite_index = scrFRAreaSourceSprite(spr_off);
;
creator.topspr = spr_top_off;
;
}
}
if (((active == false) && (! scrFRInstanceExists(Portal)))) {
{
active = true;
;
sprite_index = scrFRAreaSourceSprite(spr_active);
;
creator.topspr = spr_top_active;
;
fire_timer += (50 + scrFRSourceIRandom(30));
;
}
}
if (((active == true) && (fire_timer <= 0))) {
{
fire_timer += 60;
;
fr_Areas_robocenter_area_gml_LaserTrap_fire();
}
}
}

// Original Areas/robocenter.area.gml:389
function fr_Areas_robocenter_area_gml_LaserTrap_fire() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_robocenter_area_gml_LaserTrap_fire_resume, id, scrFROther(other), _args, 37, []);
}
function fr_Areas_robocenter_area_gml_LaserTrap_fire_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_robocenter_area_gml_LaserTrap_fire");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/robocenter.area.gml:452
{
;
}
_fr.pc=0;
break;
case 2: // Areas/robocenter.area.gml:452
_fr.pc=0;
break;
case 3: // Areas/robocenter.area.gml:442
{
if ((! instance_position((x - 16), y, Wall))) {
{
fr_Areas_robocenter_area_gml_Beam_create((x - 16), y, 180);
}
}
if ((! instance_position((x + 16), y, Wall))) {
{
fr_Areas_robocenter_area_gml_Beam_create((x + 16), y, 0);
}
}
fire_mode = 1;
;
}
_fr.pc=2;
break;
case 4: // Areas/robocenter.area.gml:439
{
;
}
_fr.pc=3;
break;
case 5: // Areas/robocenter.area.gml:439
_fr.result=undefined; _fr.done=true; return;
break;
case 6: // Areas/robocenter.area.gml:439
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 5 : 3;
break;
case 8: // Areas/robocenter.area.gml:426
_fr.vars.__fr_repeat2--; _fr.pc=7;
break;
case 9: // Areas/robocenter.area.gml:438
{
;
}
_fr.pc=8;
break;
case 10: // Areas/robocenter.area.gml:438
_fr.wait_ticks=max(0,5); _fr.pc=9; return;
break;
case 11: // Areas/robocenter.area.gml:437
{
;
}
_fr.pc=10;
break;
case 12: // Areas/robocenter.area.gml:437
_fr.result=undefined; _fr.done=true; return;
break;
case 13: // Areas/robocenter.area.gml:437
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 12 : 10;
break;
case 14: // Areas/robocenter.area.gml:429
{
if ((! instance_position((x - 16), y, Wall))) {
{
fr_Areas_robocenter_area_gml_WarningBeam_create((x - 8), y, 180);
}
}
if ((! instance_position((x + 16), y, Wall))) {
{
fr_Areas_robocenter_area_gml_WarningBeam_create((x + 8), y, 0);
}
}
}
_fr.pc=13;
break;
case 15: // Areas/robocenter.area.gml:427
{
;
}
_fr.pc=14;
break;
case 16: // Areas/robocenter.area.gml:427
_fr.result=undefined; _fr.done=true; return;
break;
case 17: // Areas/robocenter.area.gml:427
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 16 : 14;
break;
case 7: // Areas/robocenter.area.gml:426
_fr.pc=(_fr.vars.__fr_repeat2>0)?17:6;
break;
case 18: // Areas/robocenter.area.gml:426
_fr.vars.__fr_repeat2=round(3); _fr.pc=7;
break;
case 19: // Areas/robocenter.area.gml:422
{
;
}
_fr.pc=18;
break;
case 20: // Areas/robocenter.area.gml:422
_fr.pc=0;
break;
case 21: // Areas/robocenter.area.gml:412
{
if ((! instance_position(x, (y + 16), Wall))) {
{
fr_Areas_robocenter_area_gml_Beam_create(x, (y + 16), 270.014);
}
}
if ((! instance_position(x, (y - 16), Wall))) {
{
fr_Areas_robocenter_area_gml_Beam_create(x, (y - 16), 90.014);
}
}
fire_mode = 2;
;
}
_fr.pc=20;
break;
case 22: // Areas/robocenter.area.gml:409
{
;
}
_fr.pc=21;
break;
case 23: // Areas/robocenter.area.gml:409
_fr.result=undefined; _fr.done=true; return;
break;
case 24: // Areas/robocenter.area.gml:409
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 23 : 21;
break;
case 26: // Areas/robocenter.area.gml:396
_fr.vars.__fr_repeat3--; _fr.pc=25;
break;
case 27: // Areas/robocenter.area.gml:408
{
;
}
_fr.pc=26;
break;
case 28: // Areas/robocenter.area.gml:408
_fr.wait_ticks=max(0,5); _fr.pc=27; return;
break;
case 29: // Areas/robocenter.area.gml:407
{
;
}
_fr.pc=28;
break;
case 30: // Areas/robocenter.area.gml:407
_fr.result=undefined; _fr.done=true; return;
break;
case 31: // Areas/robocenter.area.gml:407
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 30 : 28;
break;
case 32: // Areas/robocenter.area.gml:399
{
if ((! instance_position(x, (y + 16), Wall))) {
{
fr_Areas_robocenter_area_gml_WarningBeam_create(x, (y + 8), 270.014);
}
}
if ((! instance_position(x, (y - 16), Wall))) {
{
fr_Areas_robocenter_area_gml_WarningBeam_create(x, (y - 8), 90.014);
}
}
}
_fr.pc=31;
break;
case 33: // Areas/robocenter.area.gml:397
{
;
}
_fr.pc=32;
break;
case 34: // Areas/robocenter.area.gml:397
_fr.result=undefined; _fr.done=true; return;
break;
case 35: // Areas/robocenter.area.gml:397
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 34 : 32;
break;
case 25: // Areas/robocenter.area.gml:396
_fr.pc=(_fr.vars.__fr_repeat3>0)?35:24;
break;
case 36: // Areas/robocenter.area.gml:396
_fr.vars.__fr_repeat3=round(3); _fr.pc=25;
break;
case 37: // Areas/robocenter.area.gml:391
_fr.vars.__fr_switch1=fire_mode;
if (_fr.vars.__fr_switch1==1) {_fr.pc=36;} else if (_fr.vars.__fr_switch1==2) {_fr.pc=18;} else {_fr.pc=0;}
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/robocenter.area.gml:456
function fr_Areas_robocenter_area_gml_WarningBeam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprWarningLaser);
;
mask_index = mskLaser;
;
image_speed = (0) * timescale;
;
direction = _frl__direction;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 1;
;
lifetime = 3;
;
typ = 0;
;
on_step = fr_Areas_robocenter_area_gml_WarningBeam_step;
;
on_hit = fr_Areas_robocenter_area_gml_nothing;
;
on_wall = fr_Areas_robocenter_area_gml_nothing;
;
on_draw = fr_Areas_robocenter_area_gml_warning_draw;
;
var _frl_scanLength = scrFRRobocenterBeamLength(500);
;
x = (xstart + lengthdir_x(_frl_scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl_scanLength, image_angle));
;
image_xscale = (_frl_scanLength / 2);
;
xprevious = x;
yprevious = y;
scrFRRobocenterWarningVisual();
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:489
function fr_Areas_robocenter_area_gml_Beam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LaserTrapBeam";
;
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeam);
;
mask_index = global.fr_module_vars[$ "area:robocenter"].mskLaserTrapBeam;
;
spr_tail = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeamStart;
;
spr_head = global.fr_module_vars[$ "area:robocenter"].sprLaserTrapHead;
;
image_speed = (0) * timescale;
;
direction = _frl__direction;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 1;
;
lifetime = 25;
;
typ = 0;
;
on_step = fr_Areas_robocenter_area_gml_Beam_step;
;
on_hit = fr_Areas_robocenter_area_gml_Beam_hit;
;
on_wall = fr_Areas_robocenter_area_gml_nothing;
;
on_draw = fr_Areas_robocenter_area_gml_Beam_draw;
;
var _frl_scanLength = scrFRRobocenterBeamLength(500);
;
x = (xstart + lengthdir_x(_frl_scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl_scanLength, image_angle));
;
image_xscale = (_frl_scanLength / 2);
;
xprevious = x;
yprevious = y;
scrFRSoundPosition(sndEnergyHammerUpg, 0.3);
scrFRSoundSetPitch(sndEnergyHammerUpg, 0);
scrFRSoundPitchVolume(sndEnergyHammerUpg, (0.4 * scrFRSourceRandomRange(0.9, 1.1)), 0.25);
scrFRSoundPitchVolume(sndLaserCannon, (1.5 + scrFRSourceRandom(0.3)), 0.2);
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:530
function fr_Areas_robocenter_area_gml_Beam_step() {
if (scrFRInstanceExists(creator)) {
{
lifetime -= scrFRSourceScale();
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
}
}
if ((scrFRSourceRandom(5) < 1)) {
{
var _frl__r = scrFRSourceRandomRange(0, ((image_xscale * 2) + 12));
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x - lengthdir_x(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), ((y - lengthdir_y(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeamEnd);
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.direction;
image_speed = (0.4) * timescale;
;
var __fr_other5=scrFROther(other);
scrFRMotionSet(__fr_other5.direction, scrFRSourceChoose(1, 2));
}
}
if(__fr_break3) break;
}}
}
}
image_yscale = (1 * scrFRSourceRandomRange(0.8, 1.1));
}
} else {
scrFRInstanceDestroy();
}
}

// Original Areas/robocenter.area.gml:554
function fr_Areas_robocenter_area_gml_binary_search(_frl_checkScript=undefined, _frl_searchLength=undefined) {
var _frl_length = _frl_searchLength;
var _frl_lenDiff = _frl_searchLength;
;
if (scrFRScriptCall(_frl_checkScript, _frl_length)) {
{
_frl_lenDiff /= 2;
;
_frl_length -= _frl_lenDiff;
;
}
} else {
{
return _frl_searchLength;
;
}
}
while ((_frl_lenDiff > frMacro_Areas_robocenter_area_gml_minSearchDiff)) {
_frl_lenDiff /= 2;
;
if (scrFRScriptCall(_frl_checkScript, _frl_length)) {
{
_frl_length -= _frl_lenDiff;
;
}
} else {
{
_frl_length += _frl_lenDiff;
;
}
}
}
return _frl_length;
;
}

// Original Areas/robocenter.area.gml:581
function fr_Areas_robocenter_area_gml_check_laser_style(_frl_length=undefined) {
x = (xstart + lengthdir_x(_frl_length, image_angle));
;
y = (ystart + lengthdir_y(_frl_length, image_angle));
;
image_xscale = (_frl_length / 2);
;
return scrFRPlaceMeeting(x, y, Wall);
;
}

// Original Areas/robocenter.area.gml:589
function fr_Areas_robocenter_area_gml_Beam_hit() {
var _frl__team = team;
var _frl__ang = direction;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRVariableExists(scrFRSelf(self), "fr_beamVaporize")) {
{
if ((fr_beamVaporize == true)) {
{
hp = 0;
;
snd_hurt = sndFootPlaSand5;
;
snd_dead = sndFootPlaSand5;
;
repeat (10) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:robocenter"].sprLaserTrapBeamEnd);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
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
if ((nexthurt <= scrFRSourceFrame())) {
{
var __fr_other7=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other7.damage);
lasthit = [global.fr_module_vars[$ "area:robocenter"].sprLaserTrapGameover, "LASER TRAP"];
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:613
function fr_Areas_robocenter_area_gml_Beam_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
}
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2), (image_yscale * 2), (image_angle - 45), image_blend, 1.0);
}
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, (image_yscale * 1.7), image_angle, image_blend, 0.2);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_tail, 1, xstart, ystart, 1, (image_yscale * 1.5), image_angle, image_blend, 0.2);
}
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2.7), (image_yscale * 2.7), (image_angle - 45), image_blend, 0.2);
}
}

// Original Areas/robocenter.area.gml:623
function fr_Areas_robocenter_area_gml_WarningBeam_step() {
if (scrFRInstanceExists(creator)) {
{
lifetime -= scrFRSourceScale();
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
}
}
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Areas/robocenter.area.gml:630
function fr_Areas_robocenter_area_gml_warning_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
;
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, (image_yscale * 1.7), image_angle, image_blend, 0.2);
;
}

// Original Areas/robocenter.area.gml:634
function fr_Areas_robocenter_area_gml_nothing() {

}

// Original Areas/robocenter.area.gml:638
function fr_Areas_robocenter_area_gml_Battery_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RoboBattery";
;
spr_idle = global.fr_module_vars[$ "area:robocenter"].sprBattery;
;
spr_hurt = global.fr_module_vars[$ "area:robocenter"].sprBatteryHurt;
;
spr_dead = global.fr_module_vars[$ "area:robocenter"].sprBatteryDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_index = scrFRSourceIRandom(image_number);
;
depth = (- 1);
;
spr_shadow = (- 1);
;
fr_glow = [32, 48];
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
mask_index = global.fr_module_vars[$ "area:robocenter"].mskBattery;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 3;
;
fr_beamVaporize = true;
;
x = round(x);
;
y = round(y);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:671
function fr_Areas_robocenter_area_gml_Assembler_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RoboAssembler";
;
spr_idle = global.fr_module_vars[$ "area:robocenter"].sprAssembler;
;
spr_hurt = global.fr_module_vars[$ "area:robocenter"].sprAssemblerHurt;
;
spr_dead = global.fr_module_vars[$ "area:robocenter"].sprAssemblerDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_index = scrFRSourceIRandom(image_number);
;
depth = (- 1);
;
spr_shadow = (- 1);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
mask_index = global.fr_module_vars[$ "area:robocenter"].mskAssembler;
;
scrFRMaxHealthWrite(id, 24, "=");
;
hp = max_hp;
;
size = 3;
;
fr_beamVaporize = true;
;
x = round(x);
;
y = round(y);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:704
function fr_Areas_robocenter_area_gml_DeeplabsEntrance_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsEntrance";
;
spr_closed = global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceClosed;
;
spr_opening = global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceOpening;
;
spr_open = global.fr_module_vars[$ "area:robocenter"].sprDeeplabsEntranceOpen;
;
sprite_index = scrFRAreaSourceSprite(spr_closed);
;
image_speed = (0.4) * timescale;
;
depth = 5;
;
fr_glow = [0, 0];
;
portalPusher = noone;
;
entranceopen = false;
;
on_step = ["area", "robocenter", fr_Areas_robocenter_area_gml_DeeplabsEntrance_step];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/robocenter.area.gml:728
function fr_Areas_robocenter_area_gml_DeeplabsEntrance_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((scrFRInstanceExists(Portal) && scrFRPlaceMeeting(x, y, Player)) && (entranceopen == true))) {
{
{ var __fr_with1 = scrFRWithValues(GameCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
area = scrFRAreaResolve("deeplabs");
;
subarea = 0;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_alpha = 0;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(portalPusher), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
entranceopen = false;
;
}
}
if ((scrFRInstanceExists(Portal) && (sprite_index != spr_open))) {
{
sprite_index = scrFRAreaSourceSprite(spr_opening);
;
image_speed = (0.4) * timescale;
;
fr_glow = [48, 64];
;
if (((frMacro_Areas_robocenter_area_gml_anim_end && (sprite_index != spr_open)) && (sprite_index != spr_closed))) {
{
entranceopen = true;
}
}
if ((entranceopen == true)) {
{
scrFRSoundPlay(sndGeneratorBreak);
sprite_index = scrFRAreaSourceSprite(spr_open);
;
}
}
}
}
}
