#macro frMacro_Frontier_Main_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Main"].scr

#macro frMacro_Frontier_Main_mod_gml_call scrFRScriptCall

#macro frMacro_Frontier_Main_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Frontier_Main_mod_gml_anim_end (((image_index + (image_speed / timescale)) >= image_number) || ((image_index + (image_speed / timescale)) < 0))

#macro frMacro_Frontier_Main_mod_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

#macro frMacro_Frontier_Main_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_Frontier_Main_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

#macro frMacro_Frontier_Main_mod_gml_currently_outside ((scrFRArrayFindIndex([1, 3, 5, 0, 105, "coast"], GameCont.area) >= 0) || (scrFRSourceAreaIsString(GameCont.area) && (scrFRModCall("area", GameCont.area, "area_outside") = true)))

// Original Frontier_Main.mod.gml:1
function fr_Frontier_Main_mod_gml___load() {

}

// Original Frontier_Main.mod.gml:1
function fr_Frontier_Main_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Main_mod_gml_init_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Frontier_Main_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Main_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Main.mod.gml:54
{
global.fr_module_vars[$ "mod:Frontier_Main"].levelStart = false;
;
global.fr_module_vars[$ "mod:Frontier_Main"].desertSubarea = 0;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingNewIDPD = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingVanillaGlow = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingConfettiClean = 1000;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingVisualDecryptors = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingBigStrikeChests = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingThroneTeleporters = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingLabsRouteAltMode = false;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingSurgeriesBeta = false;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingAltCoveEntrance = false;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingCyberspaceEnabled = true;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingTradeFishMode = "OFF";
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingNightEventSpawnChance = 0.2;
;
global.fr_module_vars[$ "mod:Frontier_Main"].settingCrushTrapSpawnrate = 1;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorCrushBlock = sprFR_sprFloorCrushBlock_728a2f4400b6;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorProtoCache = sprFR_sprFloorProtoCache_4c2c346aea0f;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorBloodFountain = sprFR_sprFloorBloodFountain_8b722beb6e80;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprNewRobot = sprFR_sprNewRobot_1e4e0dc4bdcf;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardProtoStatueDecal = sprFR_sprGraveyardProtoStatueD_4ede02b21b2c;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardProtoStatueDecalDead = sprFR_sprGraveyardProtoStatueD_43d20c25584c;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorch = [sprFR_sprGraveyardScorch_64e8a96b03d6, sprFR_sprGraveyardScorch2_7e9c02955617];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorchTop = [sprFR_sprGraveyardScorchTop_8a6bacea2b53, sprFR_sprGraveyardScorchTop2_115cc31aa82d];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorch = [sprFR_sprDesertBNightScorch_972ff6af45ff];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorchTop = [sprFR_sprDesertBNightScorchTop_85432640e800];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorch = [sprFR_sprCityNightScorch_10ead41b9085, sprFR_sprCityNightScorch2_aff2a960098f];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorchTop = [sprFR_sprCityNightScorchTop_01ef6ac4b65f, sprFR_sprCityNightScorchTop2_1720277dbd1d];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCityExploNightScorch = [sprFR_sprCityExploNightScorch_5b8fef069400, sprFR_sprCityExploNightScorch2_5e01ded07f70];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorch = [sprFR_sprCityBNightScorch_542afb5fc876, sprFR_sprCityBNightScorch2_952566928c12];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorchTop = [sprFR_sprCityBNightScorchTop_b2fe2bcabc92, sprFR_sprCityBNightScorchTop2_8f399f94211c];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorch = [sprFR_sprCoastNightScorch_56cc9bd56c03];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorchTop = [sprFR_sprCoastNightScorchTop_0abbde1cbe5c];
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorEntranceFrocity = sprFR_sprSnowFloorOutpost_dc4990865b41;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprWallEntranceFrocityBot = sprFR_sprCityWallEntranceBot_74742c4d22bb;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprWallEntranceFrocityBotNight = sprFR_sprCityWallEntranceBotNi_b21972daf50a;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprWall5TopNight = sprFR_sprWall5TopNight_36f5c6c9b825;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprWall5OutNight = sprFR_sprWall5OutNight_4d3ccfd0c1d5;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprSnowFloorEntrance = sprFR_sprSnowFloorOutpostSnow_ae62566cced3;
;
global.fr_module_vars[$ "mod:Frontier_Main"].sprSnowFloorEntranceNight = sprFR_sprSnowFloorOutpostSnowN_0216c9ce3a49;
;
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
; // macro hoisted: FloorNormal
; // macro hoisted: bbox_center_x
;
; // macro hoisted: bbox_center_y
;
; // macro hoisted: currently_outside
}
_fr.pc=0;
break;
case 2: // Frontier_Main.mod.gml:50
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Main.mod.gml:50
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Main.mod.gml:13
{
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_load, "Frontier", {"cache_level": 0, "unlock_bubbles": 0, "unlock_bubbles_bskin": 0, "unlock_bubbles_cskin": 0, "meals_eaten": 0, "surgeries_received": 0, "augments_taken": 0, "pirate_conversions": [], "pirate_trades": 0, "caches_opened": 0, "deeplabs_finales": 0, "decryptors_collected": 0, "cyberspace_visits": 0, "hoarder_kills": 0, "hoarder_escapes": 0, "test_subjects_rescued": 0, "test_subjects_killed": 0, "test_subjects_abandoned": 0, "bubbles_kills": 0, "bubbles_loops": 0, "bubbles_runs": 0, "bubbles_deaths": 0, "bubbles_wins": 0, "bubbles_time": 0, "bubbles_bubbles": 0, "bubbles_best_kills": 0, "bubbles_best_area": 0});
;
}
_fr.pc=3;
break;
case 6: // Frontier_Main.mod.gml:10
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Main.mod.gml:10
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Frontier_Main.mod.gml:10
_fr.pc=((! scrFRModLoaded("mod", "libSaves")))?7:4;
break;
case 8: // Frontier_Main.mod.gml:9
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Main.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Main", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=8;
break;
case 11: // Frontier_Main.mod.gml:4
{
;
}
_fr.pc=10;
break;
case 12: // Frontier_Main.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=11; return;
break;
case 10: // Frontier_Main.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?12:9;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Main.mod.gml:116
function fr_Frontier_Main_mod_gml_game_start() {
if (scrFRModLoaded("mod", "Frontier_Options")) {
{
scrFRModCall("mod", "Frontier_Options", "ExternalOptions_load");
}
}
{ var __fr_with1 = scrFRWithValues(GameCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_decryptors = 0;
;
fr_captainCutlass = 0;
;
fr_bigStrikeChest = 0;
;
fr_mealChestChance = 1;
;
fr_casinoAlert = false;
;
fr_deeplabsDecal = false;
;
fr_visitedCyberspace = false;
;
fr_hoarderLoop = (GameCont.loops - 1);
;
fr_prevLoop = (GameCont.loops - 1);
;
fr_jungleToGraveyard = false;
;
}
}
if(__fr_break3) break;
}}
scrFRModSet("mod", "Frontier_Events", "nightLoop", false);
;
if ((scrFRSourceRandom(1) < global.fr_module_vars[$ "mod:Frontier_Main"].settingNightEventSpawnChance)) {
{
scrFRModSet("mod", "Frontier_Events", "nightLoop", true);
;
}
}
scrFRModCall("area", "deeplabs", "BigTubeObjects_init");
;
scrFRModSet("area", "cyberspace", "reskinMe", false);
;
scrFRModCall("area", "cyberspace", "Processor_compat_additions");
scrFRModSet("area", "graveyard", "variaThundershockBroken", false);
;
scrFRModCall("weapon", "FR_Wormhole", "WormholeList_init");
fr_Frontier_Main_mod_gml_altareas_import_frontier();
;
fr_Frontier_Main_mod_gml_detailsPlus_import_frontier();
;
}

// Original Frontier_Main.mod.gml:160
function fr_Frontier_Main_mod_gml_draw_bloom() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE([FRCustomProjectile, FRCustomObject, FRCustomSlash], "fr_bloom", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (scrFRIndexGet(fr_bloom, 0) * image_xscale), (scrFRIndexGet(fr_bloom, 0) * image_yscale), image_angle, image_blend, scrFRIndexGet(fr_bloom, 1));
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Main.mod.gml:165
function fr_Frontier_Main_mod_gml_draw_dark() {
draw_set_color($808080);
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE([FRCustomObject, FRCustomProjectile, FRCustomEnemy, FRCustomProp], "fr_glow", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
draw_circle(x, y, (scrFRIndexGet(fr_glow, 1) + scrFRSourceRandom(3)), false);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_ProtoCache")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
draw_circle(x, (y - 10), ((96 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break6) break;
}}
;
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_TreasureMimic")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
draw_circle(x, y, ((32 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break9) break;
}}
;
{ var __fr_with10 = scrFRWithValues(scrFRMatching(FRCustomProp, "name", "fr_BloodFountain")), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
draw_circle(x, (y + 10), ((48 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break12) break;
}}
;
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingVanillaGlow == true)) {
{
{ var __fr_with13 = scrFRWithValues(TrapFire), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break15) break;
}}
;
{ var __fr_with16 = scrFRWithValues(Fireball), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break18) break;
}}
;
{ var __fr_with19 = scrFRWithValues(FlameShell), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
draw_circle(x, y, (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break21) break;
}}
;
{ var __fr_with22 = scrFRWithValues(Salamander), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
draw_circle(x, y, (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break24) break;
}}
;
{ var __fr_with25 = scrFRWithValues(DogGuardian), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
draw_circle(x, y, (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break27) break;
}}
;
{ var __fr_with28 = scrFRWithValues(Guardian), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
draw_circle(x, (y - 6), (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break30) break;
}}
;
{ var __fr_with31 = scrFRWithValues(ExploGuardian), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
draw_circle(x, y, (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break33) break;
}}
;
{ var __fr_with34 = scrFRWithValues(CrownGuardian), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
draw_circle(x, (y - 6), (48 + scrFRSourceRandom(3)), false);
}
if(__fr_break36) break;
}}
;
{ var __fr_with37 = scrFRWithValues(HostileHorror), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break39) break;
}}
;
{ var __fr_with40 = scrFRWithValues(GuardianStatue), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
draw_circle(x, y, (48 + scrFRSourceRandom(1)), false);
}
if(__fr_break42) break;
}}
;
{ var __fr_with43 = scrFRWithValues(GroundFlame), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
draw_circle(x, y, (20 + scrFRSourceRandom(3)), false);
}
if(__fr_break45) break;
}}
;
{ var __fr_with46 = scrFRWithValues(BlueFlame), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
draw_circle(x, y, (20 + scrFRSourceRandom(1)), false);
}
if(__fr_break48) break;
}}
;
}
}
{ var __fr_with49 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_area_halfdark")), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
draw_rectangle(scrFRViewCoordinate(0), scrFRViewCoordinate(1), (scrFRViewCoordinate(0) + view_width), (scrFRViewCoordinate(1) + view_width), 0);
;
}
}
if(__fr_break51) break;
}}
}

// Original Frontier_Main.mod.gml:199
function fr_Frontier_Main_mod_gml_draw_dark_end() {
draw_set_color($000000);
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE([FRCustomObject, FRCustomProjectile, FRCustomEnemy, FRCustomProp], "fr_glow", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
draw_circle(x, y, (scrFRIndexGet(fr_glow, 0) + scrFRSourceRandom(3)), false);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_ProtoCache")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
draw_circle(x, (y - 10), ((64 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break6) break;
}}
;
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_TreasureMimic")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
draw_circle(x, y, ((24 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break9) break;
}}
;
{ var __fr_with10 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomObject, "name", "fr_CarHonkController"), "lightsOn", true)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (scrFRInstanceExists(owner)) {
{
scrFRDrawSpriteExt(spr_light, 0, (x - (45 * image_xscale)), y, owner.image_xscale, (owner.image_yscale + scrFRSourceRandom(0.1)), owner.image_angle, c_white, 1);
;
}
}
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(TopDecalCity, "name", "fr_RobocenterDecal")), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
draw_circle(x, (y - 8), (scrFRIndexGet(fr_glow, 1) + scrFRSourceRandom(2)), false);
}
if(__fr_break15) break;
}}
;
{ var __fr_with16 = scrFRWithValues(scrFRMatching(FRCustomProp, "name", "fr_BloodFountain")), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
draw_circle(x, (y + 10), ((32 + (sin((scrFRSourceFrame() * 0.03)) * 2)) + scrFRSourceRandom(1)), false);
}
if(__fr_break18) break;
}}
;
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingVanillaGlow == true)) {
{
{ var __fr_with19 = scrFRWithValues(TrapFire), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
draw_circle(x, y, (24 + scrFRSourceRandom(3)), false);
}
if(__fr_break21) break;
}}
;
{ var __fr_with22 = scrFRWithValues(Fireball), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
draw_circle(x, y, (24 + scrFRSourceRandom(3)), false);
}
if(__fr_break24) break;
}}
;
{ var __fr_with25 = scrFRWithValues(FlameShell), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break27) break;
}}
;
{ var __fr_with28 = scrFRWithValues(Salamander), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break30) break;
}}
;
{ var __fr_with31 = scrFRWithValues(DogGuardian), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break33) break;
}}
;
{ var __fr_with34 = scrFRWithValues(Guardian), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
draw_circle(x, (y - 6), (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break36) break;
}}
;
{ var __fr_with37 = scrFRWithValues(ExploGuardian), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
draw_circle(x, y, (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break39) break;
}}
;
{ var __fr_with40 = scrFRWithValues(CrownGuardian), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
draw_circle(x, (y - 6), (32 + scrFRSourceRandom(3)), false);
}
if(__fr_break42) break;
}}
;
{ var __fr_with43 = scrFRWithValues(HostileHorror), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
draw_circle(x, y, (16 + scrFRSourceRandom(3)), false);
}
if(__fr_break45) break;
}}
;
{ var __fr_with46 = scrFRWithValues(GuardianStatue), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
draw_circle(x, y, (32 + scrFRSourceRandom(1)), false);
}
if(__fr_break48) break;
}}
;
{ var __fr_with49 = scrFRWithValues(GroundFlame), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
draw_circle(x, y, (12 + scrFRSourceRandom(3)), false);
}
if(__fr_break51) break;
}}
;
{ var __fr_with52 = scrFRWithValues(BlueFlame), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
draw_circle(x, y, (14 + scrFRSourceRandom(1)), false);
}
if(__fr_break54) break;
}}
;
}
}
}

// Original Frontier_Main.mod.gml:242
function fr_Frontier_Main_mod_gml_step() {
if (scrFRInstanceExists(CharSelect)) {
{
if (scrFRModLoaded("mod", "libSaves")) {
{
var _frl__inst = scrFRMatching(CharSelect, "race", "bubbles");
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__name = scrFRRaceKey(race);
;
{ var __fr_with4 = scrFRWithValues(scrFRMatching(CharSelect, "race", _frl__name)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRScriptExists("race", _frl__name, "race_avail") && (! scrFRModCall("race", _frl__name, "race_avail")))) {
{
noinput = 10;
;
}
} else {
{
var _frl__stat = (_frl__name + string("_runs"));
if ((frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_get, "Frontier", _frl__stat) <= 0)) {
{
{} // FRONTIER NATIVE SELECT MARKER NEW
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
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(CharSelect, "race", "robot")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingCyberspaceEnabled == true)) {
{
if (((frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_get, "Frontier", "cyberspace_visits") <= 0) && (frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_get, "Frontier", "deeplabs_finales") > 0))) {
{
{} // FRONTIER NATIVE SELECT MARKER ROBOT
;
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
{ var __fr_with10 = scrFRWithValues(Feather), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_featherlifetime"))) {
{
fr_featherlifetime = 80;
;
}
}
if (((speed / timescale) <= 0)) {
{
fr_featherlifetime -= scrFRSourceScale();
;
}
}
if ((fr_featherlifetime <= 0)) {
{
image_alpha -= (0.07 * scrFRSourceScale());
;
}
}
}
}
if(__fr_break12) break;
}}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingNewIDPD == true)) {
{
{ var __fr_with13 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomObject, "name", "IDPDPortal"), "fr_StrikerCheck", undefined)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
fr_StrikerCheck = true;
;
if ((van == 1)) {
{
if ((((scrFRSourceRandom(3) < 1) && (GameCont.popolevel >= 32)) && frMacro_Frontier_Main_mod_gml_currently_outside)) {
{
scrFRModCall("mod", "Frontier_IDPD", "PopoAirstrikeSpawner_create", x, y);
}
}
}
}
}
}
if(__fr_break15) break;
}}
}
}
if (scrFRInstanceExists(GenCont)) {
{
global.fr_module_vars[$ "mod:Frontier_Main"].levelStart = true;
;
}
} else {
{
if (global.fr_module_vars[$ "mod:Frontier_Main"].levelStart) {
{
var _frl__normalArea = (((((GameCont.hard > 1) && (scrFRInstanceNumber(enemy) > scrFRInstanceNumber(HostileHorror))) && (! (GameCont.area == scrFRAreaTryResolve("deeplabs")))) && (GameCont.area != scrFRAreaTryResolve("village"))) && (GameCont.area != scrFRAreaTryResolve("cyberspace")));
;
{ var __fr_with16 = scrFRWithValues(GameCont), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_prevLoop"))) {
{
GameCont.fr_prevLoop = (GameCont.loops - 1);
;
}
}
}
}
if(__fr_break18) break;
}}
if ((GameCont.loops != GameCont.fr_prevLoop)) {
{
GameCont.fr_prevLoop = GameCont.loops;
;
if ((GameCont.loops != 0)) {
{
scrFRModSet("mod", "Frontier_Events", "nightLoop", false);
;
if (fr_Frontier_Main_mod_gml_chance(global.fr_module_vars[$ "mod:Frontier_Main"].settingNightEventSpawnChance, 1)) {
{
scrFRModSet("mod", "Frontier_Events", "nightLoop", true);
;
}
}
}
}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingTradeFishMode != "OFF")) {
{
scrFRModCall("mod", "Frontier_Caves", "TradeFishController_create", 10016, 10016);
;
}
}
if (((GameCont.hard > 6) && (GameCont.area != scrFRAreaTryResolve(106)))) {
{
if (((scrFRSourceRandom(12) < GameCont.fr_mealChestChance) && _frl__normalArea)) {
{
{ var __fr_with19 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, frMacro_Frontier_Main_mod_gml_FloorNormal)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
if ((((distance_to_object(Player) > 256) && (! scrFRPlaceMeeting(x, y, hitme))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
var _frl__num = (1 + scrFRSourceIRandom(scrFRGetSkill(mut_open_mind)));
;
if ((_frl__num > 0)) {
{
repeat (_frl__num) {
{ var __fr_with22 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, x, y, 0, frMacro_Frontier_Main_mod_gml_FloorNormal, 1, 1, "", 0, 0)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
if (((scrFRSourceRandom(13) < 1) && (GameCont.hard > 8))) {
{
scrFRModCall("mod", "Frontier_Pickups", "MealMimic_create", x, y);
;
}
} else {
{
scrFRModCall("mod", "Frontier_Pickups", "MealChest_create", x, y);
;
}
}
}
}
if(__fr_break24) break;
}}
}
}
}
__fr_break21=true; break;
;
}
}
}
}
if(__fr_break21) break;
}}
}
}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingBigStrikeChests == true)) {
{
scrFRModCall("mod", "Frontier_Pickups", "RogueChestBigController_create", 10016, 10016);
;
{ var __fr_with25 = scrFRWithValues(RogueChest), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
if ((scrFRSourceRandom(1) < GameCont.fr_bigStrikeChest)) {
{
scrFRModCall("mod", "Frontier_Pickups", "RogueChestBig_create", x, y);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break27) break;
}}
}
}
if (((GameCont.fr_decryptors > 0) && (global.fr_module_vars[$ "mod:Frontier_Main"].settingVisualDecryptors == true))) {
{
repeat (GameCont.fr_decryptors) {
scrFRModCall("mod", "Frontier_Pickups", "DecryptorFollower_create", 10016, 10016, frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.instance_random, Player));
;
}
}
}
{ var __fr_switch_value28=GameCont.area, __fr_switch_case29=-1;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(1))) __fr_switch_case29=0;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("desert"))) __fr_switch_case29=1;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(2))) __fr_switch_case29=2;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("sewers"))) __fr_switch_case29=3;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(3))) __fr_switch_case29=4;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(4))) __fr_switch_case29=5;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("caves"))) __fr_switch_case29=6;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(5))) __fr_switch_case29=7;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("city"))) __fr_switch_case29=8;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(6))) __fr_switch_case29=9;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("labs"))) __fr_switch_case29=10;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(7))) __fr_switch_case29=11;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("palace"))) __fr_switch_case29=12;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(101))) __fr_switch_case29=13;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("oasis"))) __fr_switch_case29=14;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(103))) __fr_switch_case29=15;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(104))) __fr_switch_case29=16;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("cavesinv"))) __fr_switch_case29=17;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve(106))) __fr_switch_case29=18;
if(__fr_switch_case29==-1 && __fr_switch_value28==(scrFRAreaTryResolve("hq"))) __fr_switch_case29=19;
if(__fr_switch_case29==-1) __fr_switch_case29=-1;
switch(__fr_switch_case29) {
case 0:

case 1:
global.fr_module_vars[$ "mod:Frontier_Main"].desertSubarea = GameCont.subarea;
;
{ var __fr_with30 = scrFRWithValues(RogueChest), __fr_break32=false;
for (var __fr_index31=0; __fr_index31<array_length(__fr_with30); ++__fr_index31) {
if(scrFRScopeExists(__fr_with30[__fr_index31])) with (__fr_with30[__fr_index31]) {
{
var _frl__floor = instance_nearest(x, y, Floor);
{
if ((_frl__floor.styleb == true)) {
{
scrFRModCall("mod", "Frontier_Pickups", "RogueChestMaggot_create", x, y);
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
}
if(__fr_break32) break;
}}
break;
;
case 2:

case 3:
{ var __fr_with33 = scrFRWithValues(BuffGator), __fr_break35=false;
for (var __fr_index34=0; __fr_index34<array_length(__fr_with33); ++__fr_index34) {
if(scrFRScopeExists(__fr_with33[__fr_index34])) with (__fr_with33[__fr_index34]) {
{
if ((scrFRSourceRandom(12) < 1)) {
{
scrFRModCall("mod", "Frontier_Objects", "Paintor_create", x, y);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break35) break;
}}
break;
;
case 4:
if ((GameCont.subarea == 1)) {
{
var _frl__toolkitFloor = [];
var _frl__toolkitIndex = (- 1);
{ var __fr_with36 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break38=false;
for (var __fr_index37=0; __fr_index37<array_length(__fr_with36); ++__fr_index37) {
if(scrFRScopeExists(__fr_with36[__fr_index37])) with (__fr_with36[__fr_index37]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__toolkitFloor, scrFRSelf(self));
;
_frl__toolkitIndex++;
;
}
}
}
}
}
}
if(__fr_break38) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__toolkitFloor);
;
if ((_frl__toolkitIndex >= 0)) {
{ var __fr_with39 = scrFRWithValues(scrFRIndexGet(_frl__toolkitFloor, (_frl__toolkitIndex--))), __fr_break41=false;
for (var __fr_index40=0; __fr_index40<array_length(__fr_with39); ++__fr_index40) {
if(scrFRScopeExists(__fr_with39[__fr_index40])) with (__fr_with39[__fr_index40]) {
{
scrFRModCall("mod", "Frontier_Pickups", "ToolKitChest_create", (x + 16), (y + 16));
;
}
}
if(__fr_break41) break;
}}
}
}
}
{ var __fr_with42 = scrFRWithValues(Car), __fr_break44=false;
for (var __fr_index43=0; __fr_index43<array_length(__fr_with42); ++__fr_index43) {
if(scrFRScopeExists(__fr_with42[__fr_index43])) with (__fr_with42[__fr_index43]) {
{
if ((scrFRSourceRandom(20) < 1)) {
{
scrFRModCall("mod", "Frontier_Objects", "CarHonkController_create", x, y, scrFRSelf(self));
;
}
}
}
}
if(__fr_break44) break;
}}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingAltCoveEntrance == true)) {
{
if ((GameCont.subarea == 3)) {
{
var _frl__coveEntranceFloor = [];
var _frl__coveEntranceIndex = (- 1);
{ var __fr_with45 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break47=false;
for (var __fr_index46=0; __fr_index46<array_length(__fr_with45); ++__fr_index46) {
if(scrFRScopeExists(__fr_with45[__fr_index46])) with (__fr_with45[__fr_index46]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__coveEntranceFloor, scrFRSelf(self));
;
_frl__coveEntranceIndex++;
;
}
}
}
}
}
}
if(__fr_break47) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__coveEntranceFloor);
;
if ((_frl__coveEntranceIndex >= 0)) {
{ var __fr_with48 = scrFRWithValues(scrFRIndexGet(_frl__coveEntranceFloor, (_frl__coveEntranceIndex--))), __fr_break50=false;
for (var __fr_index49=0; __fr_index49<array_length(__fr_with48); ++__fr_index49) {
if(scrFRScopeExists(__fr_with48[__fr_index49])) with (__fr_with48[__fr_index49]) {
{
var _frl__w = 1;
var _frl__h = 1;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with51 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break53=false;
for (var __fr_index52=0; __fr_index52<array_length(__fr_with51); ++__fr_index52) {
if(scrFRScopeExists(__fr_with51[__fr_index52])) with (__fr_with51[__fr_index52]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
;
scrFRModCall("mod", "Frontier_Caves", "ScrapyardCoveEntrance_create", x, y);
;
}
}
if(__fr_break53) break;
}}
}
}
if(__fr_break50) break;
}}
}
}
}
}
}
break;
;
case 5:

case 6:
{ var __fr_with54 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break56=false;
for (var __fr_index55=0; __fr_index55<array_length(__fr_with54); ++__fr_index55) {
if(scrFRScopeExists(__fr_with54[__fr_index55])) with (__fr_with54[__fr_index55]) {
{
if ((((! styleb) && (scrFRSourceRandom(30) < 1)) && (distance_to_object(Player) > 32))) {
{
scrFRModCall("mod", "Frontier_Caves", "SpikeTrap_create", x, y, false);
}
}
}
}
if(__fr_break56) break;
}}
{ var __fr_with57 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break59=false;
for (var __fr_index58=0; __fr_index58<array_length(__fr_with57); ++__fr_index58) {
if(scrFRScopeExists(__fr_with57[__fr_index58])) with (__fr_with57[__fr_index58]) {
{
if (((scrFRSourceRandom(40) < 1) && (distance_to_object(Player) > 32))) {
{
scrFRModCall("mod", "Frontier_Caves", "SpiderTrap_create", (x + 16), (y + 16), false);
;
}
}
}
}
if(__fr_break59) break;
}}
if ((scrFRSourceRandom(12) < 1)) {
{
{ var __fr_with60 = scrFRWithValues(HyperCrystal), __fr_break62=false;
for (var __fr_index61=0; __fr_index61<array_length(__fr_with60); ++__fr_index61) {
if(scrFRScopeExists(__fr_with60[__fr_index61])) with (__fr_with60[__fr_index61]) {
{
scrFRModCall("mod", "Frontier_Caves", "LightningHyperCrystalController_create", 10016, 10016, scrFRSelf(self));
}
}
if(__fr_break62) break;
}}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingAltCoveEntrance == false)) {
{
if ((GameCont.subarea == 1)) {
{
var _frl__coveEntranceFloor = [];
var _frl__coveEntranceIndex = (- 1);
{ var __fr_with63 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break65=false;
for (var __fr_index64=0; __fr_index64<array_length(__fr_with63); ++__fr_index64) {
if(scrFRScopeExists(__fr_with63[__fr_index64])) with (__fr_with63[__fr_index64]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__coveEntranceFloor, scrFRSelf(self));
;
_frl__coveEntranceIndex++;
;
}
}
}
}
}
}
if(__fr_break65) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__coveEntranceFloor);
;
if ((_frl__coveEntranceIndex >= 0)) {
{ var __fr_with66 = scrFRWithValues(scrFRIndexGet(_frl__coveEntranceFloor, (_frl__coveEntranceIndex--))), __fr_break68=false;
for (var __fr_index67=0; __fr_index67<array_length(__fr_with66); ++__fr_index67) {
if(scrFRScopeExists(__fr_with66[__fr_index67])) with (__fr_with66[__fr_index67]) {
{
var _frl__w = 1;
var _frl__h = 1;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with69 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break71=false;
for (var __fr_index70=0; __fr_index70<array_length(__fr_with69); ++__fr_index70) {
if(scrFRScopeExists(__fr_with69[__fr_index70])) with (__fr_with69[__fr_index70]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
;
scrFRModCall("mod", "Frontier_Caves", "CoveEntrance_create", x, y, false);
;
}
}
if(__fr_break71) break;
}}
}
}
if(__fr_break68) break;
}}
}
}
}
}
}
break;
;
case 7:

case 8:
if ((GameCont.subarea == 1)) {
{
if (((global.fr_module_vars[$ "mod:Frontier_Main"].settingLabsRouteAltMode == false) || scrFRModLoaded("area", "scorpionboss"))) {
{
var _frl__entranceFloor = [];
var _frl__entranceIndex = (- 1);
{ var __fr_with72 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break74=false;
for (var __fr_index73=0; __fr_index73<array_length(__fr_with72); ++__fr_index73) {
if(scrFRScopeExists(__fr_with72[__fr_index73])) with (__fr_with72[__fr_index73]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__entranceFloor, scrFRSelf(self));
;
_frl__entranceIndex++;
;
}
}
}
}
}
}
if(__fr_break74) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__entranceFloor);
;
if ((_frl__entranceIndex >= 0)) {
{ var __fr_with75 = scrFRWithValues(scrFRIndexGet(_frl__entranceFloor, (_frl__entranceIndex--))), __fr_break77=false;
for (var __fr_index76=0; __fr_index76<array_length(__fr_with75); ++__fr_index76) {
if(scrFRScopeExists(__fr_with75[__fr_index76])) with (__fr_with75[__fr_index76]) {
{
var _frl__w = 3;
var _frl__h = 3;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with78 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break80=false;
for (var __fr_index79=0; __fr_index79<array_length(__fr_with78); ++__fr_index79) {
if(scrFRScopeExists(__fr_with78[__fr_index79])) with (__fr_with78[__fr_index79]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
;
{ var __fr_with81 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "LabsEntrance_create", x, y)), __fr_break83=false;
for (var __fr_index82=0; __fr_index82<array_length(__fr_with81); ++__fr_index82) {
if(scrFRScopeExists(__fr_with81[__fr_index82])) with (__fr_with81[__fr_index82]) {
{
portalPusher = scrFRModCall("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
;
}
}
if(__fr_break83) break;
}}
scrFRInstanceCreate((x - 32), (y - 32), Wall);
;
scrFRInstanceCreate((x + 16), (y - 32), Wall);
;
scrFRInstanceCreate((x + 16), (y + 16), Wall);
;
scrFRInstanceCreate((x - 32), (y + 16), Wall);
;
{
var _frl_j = 0;
for (; (_frl_j < array_length(floors)); _frl_j++) {
{ var __fr_with84 = scrFRWithValues(scrFRIndexGet(floors, _frl_j)), __fr_break86=false;
for (var __fr_index85=0; __fr_index85<array_length(__fr_with84); ++__fr_index85) {
if(scrFRScopeExists(__fr_with84[__fr_index85])) with (__fr_with84[__fr_index85]) {
{
fr_labsentrance_check = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorEntranceFrocity);
;
image_index = scrFRSourceIRandom(5);
;
depth -= 2;
;
{ var __fr_with87 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceIRandomRange((- 1), 1)), (y - scrFRSourceIRandomRange(2, 3)), SnowFloor)), __fr_break89=false;
for (var __fr_index88=0; __fr_index88<array_length(__fr_with87); ++__fr_index88) {
if(scrFRScopeExists(__fr_with87[__fr_index88])) with (__fr_with87[__fr_index88]) {
{
sprite_index = scrFRAreaSourceSprite((frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.event_get_active, "Aurora") ? global.fr_module_vars[$ "mod:Frontier_Main"].sprSnowFloorEntranceNight : global.fr_module_vars[$ "mod:Frontier_Main"].sprSnowFloorEntrance));
;
var __fr_other90=scrFROther(other);
image_speed = ((__fr_other90.image_speed / timescale)) * timescale;
;
var __fr_other91=scrFROther(other);
image_index = __fr_other91.image_index;
;
image_angle += scrFRSourceRandomRange((- 1), 1);
var __fr_other92=scrFROther(other);
depth = (__fr_other92.depth + 1);
;
}
}
if(__fr_break89) break;
}}
}
}
if(__fr_break86) break;
}}
}
}
}
}
if(__fr_break80) break;
}}
{ var __fr_with93 = scrFRWithValues(Wall), __fr_break95=false;
for (var __fr_index94=0; __fr_index94<array_length(__fr_with93); ++__fr_index94) {
if(scrFRScopeExists(__fr_with93[__fr_index94])) with (__fr_with93[__fr_index94]) {
{
if ((point_distance(x, y, _frl__myx, _frl__myy) < 72)) {
{
fr_labsentrance_check = true;
;
if (frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.event_get_active, "Aurora")) {
{
topspr = global.fr_module_vars[$ "mod:Frontier_Main"].sprWall5TopNight;
;
outspr = global.fr_module_vars[$ "mod:Frontier_Main"].sprWall5OutNight;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprWallEntranceFrocityBotNight);
;
}
} else {
{
topspr = sprWall5Top;
;
outspr = sprWall5Out;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprWallEntranceFrocityBot);
;
}
}
}
}
}
}
if(__fr_break95) break;
}}
}
}
if(__fr_break77) break;
}}
}
}
}
}
}
break;
;
case 9:
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingLabsRouteAltMode == true)) {
{
if ((! scrFRModLoaded("mod", "betterPVP"))) {
{
scrFRModCall("area", "robocenter", "DeeplabsEntrance_create", 10016, 10016);
;
}
}
}
}
case 10:
{ var __fr_with96 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break98=false;
for (var __fr_index97=0; __fr_index97<array_length(__fr_with96); ++__fr_index97) {
if(scrFRScopeExists(__fr_with96[__fr_index97])) with (__fr_with96[__fr_index97]) {
{
if (((scrFRSourceRandom(50) < 1) && (distance_to_object(Player) > 128))) {
{
if (((sprite_index == sprFloor6) || (sprite_index == sprFloor6B))) {
{
{ var __fr_with99 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, x, y, 0, scrFRSelf(self), 1, 1, "", 0, 0)), __fr_break101=false;
for (var __fr_index100=0; __fr_index100<array_length(__fr_with99); ++__fr_index100) {
if(scrFRScopeExists(__fr_with99[__fr_index100])) with (__fr_with99[__fr_index100]) {
{
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", x, y);
}
}
if(__fr_break101) break;
}}
}
}
}
}
}
}
if(__fr_break98) break;
}}
{ var __fr_with102 = scrFRWithValues(Server), __fr_break104=false;
for (var __fr_index103=0; __fr_index103<array_length(__fr_with102); ++__fr_index103) {
if(scrFRScopeExists(__fr_with102[__fr_index103])) with (__fr_with102[__fr_index103]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 5;
;
}
}
if(__fr_break104) break;
}}
{ var __fr_with105 = scrFRWithValues(Terminal), __fr_break107=false;
for (var __fr_index106=0; __fr_index106<array_length(__fr_with105); ++__fr_index106) {
if(scrFRScopeExists(__fr_with105[__fr_index106])) with (__fr_with105[__fr_index106]) {
{
spr_shadow_y = 1;
;
}
}
if(__fr_break107) break;
}}
{ var __fr_with108 = scrFRWithValues(Tube), __fr_break110=false;
for (var __fr_index109=0; __fr_index109<array_length(__fr_with108); ++__fr_index109) {
if(scrFRScopeExists(__fr_with108[__fr_index109])) with (__fr_with108[__fr_index109]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 7;
;
}
}
if(__fr_break110) break;
}}
{ var __fr_with111 = scrFRWithValues(MutantTube), __fr_break113=false;
for (var __fr_index112=0; __fr_index112<array_length(__fr_with111); ++__fr_index112) {
if(scrFRScopeExists(__fr_with111[__fr_index112])) with (__fr_with111[__fr_index112]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 7;
;
}
}
if(__fr_break113) break;
}}
break;
;
case 11:
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingThroneTeleporters == true)) {
{
if ((GameCont.subarea == 3)) {
{
scrFRModCall("mod", "Frontier_Palace", "ThroneRoomTeleporter_create", 9912, 9992, (- 1));
;
}
}
}
}
case 12:
if ((GameCont.subarea != 3)) {
{
{ var __fr_with114 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break116=false;
for (var __fr_index115=0; __fr_index115<array_length(__fr_with114); ++__fr_index115) {
if(scrFRScopeExists(__fr_with114[__fr_index115])) with (__fr_with114[__fr_index115]) {
{
if (fr_Frontier_Main_mod_gml_chance(global.fr_module_vars[$ "mod:Frontier_Main"].settingCrushTrapSpawnrate, 30)) {
{
if (((sprite_index == sprFloor7) || (sprite_index == sprFloor7B))) {
{
{ var __fr_with117 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, x, y, 0, scrFRSelf(self), 1, 1, "", 0, 0)), __fr_break119=false;
for (var __fr_index118=0; __fr_index118<array_length(__fr_with117); ++__fr_index118) {
if(scrFRScopeExists(__fr_with117[__fr_index118])) with (__fr_with117[__fr_index118]) {
{
{ var __fr_with120 = scrFRWithValues(floors), __fr_break122=false;
for (var __fr_index121=0; __fr_index121<array_length(__fr_with120); ++__fr_index121) {
if(scrFRScopeExists(__fr_with120[__fr_index121])) with (__fr_with120[__fr_index121]) {
{
if ((distance_to_object(Player) > 64)) {
{
scrFRModCall("mod", "Frontier_Palace", "CrushBlock_create", (x + 16), (y + 16));
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorCrushBlock);
;
}
}
}
}
if(__fr_break122) break;
}}
}
}
if(__fr_break119) break;
}}
}
}
}
}
}
}
if(__fr_break116) break;
}}
{ var __fr_with123 = scrFRWithValues(scrFRMatching(FRCustomProjectile, "name", "fr_CrushBlock")), __fr_break125=false;
for (var __fr_index124=0; __fr_index124<array_length(__fr_with123); ++__fr_index124) {
if(scrFRScopeExists(__fr_with123[__fr_index124])) with (__fr_with123[__fr_index124]) {
{
if ((distance_to_point(10016, 10016) < 64)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break125) break;
}}
}
}
if ((GameCont.fr_deeplabsDecal == true)) {
{
{ var __fr_with126 = scrFRWithValues(instance_nearest(10016, 10016, TopSmall)), __fr_break128=false;
for (var __fr_index127=0; __fr_index127<array_length(__fr_with126); ++__fr_index127) {
if(scrFRScopeExists(__fr_with126[__fr_index127])) with (__fr_with126[__fr_index127]) {
{
scrFRModCall("mod", "Frontier_Deeplabs", "DeeplabsPodDecal_create", x, y);
;
}
}
if(__fr_break128) break;
}}
}
}
GameCont.fr_deeplabsDecal = false;
;
{ var __fr_with129 = scrFRWithValues(DogGuardian), __fr_break131=false;
for (var __fr_index130=0; __fr_index130<array_length(__fr_with129); ++__fr_index130) {
if(scrFRScopeExists(__fr_with129[__fr_index130])) with (__fr_with129[__fr_index130]) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
scrFRModCall("mod", "Frontier_Palace", "GupGuardian_create", x, y);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break131) break;
}}
{ var __fr_with132 = scrFRWithValues(Guardian), __fr_break134=false;
for (var __fr_index133=0; __fr_index133<array_length(__fr_with132); ++__fr_index133) {
if(scrFRScopeExists(__fr_with132[__fr_index133])) with (__fr_with132[__fr_index133]) {
{
if ((scrFRSourceRandom(12) < 1)) {
{
scrFRModCall("mod", "Frontier_Palace", "GeepGuardian_create", x, y);
;
scrFRInstanceCreate(x, y, PortalClear);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break134) break;
}}
break;
;
case 13:

case 14:
if ((GameCont.subarea == 1)) {
{
var _frl__statueFloor = [];
var _frl__statueIndex = (- 1);
{ var __fr_with135 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break137=false;
for (var __fr_index136=0; __fr_index136<array_length(__fr_with135); ++__fr_index136) {
if(scrFRScopeExists(__fr_with135[__fr_index136])) with (__fr_with135[__fr_index136]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 80)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__statueFloor, scrFRSelf(self));
;
_frl__statueIndex++;
;
}
}
}
}
}
}
if(__fr_break137) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__statueFloor);
;
if ((_frl__statueIndex >= 0)) {
{ var __fr_with138 = scrFRWithValues(scrFRIndexGet(_frl__statueFloor, (_frl__statueIndex--))), __fr_break140=false;
for (var __fr_index139=0; __fr_index139<array_length(__fr_with138); ++__fr_index139) {
if(scrFRScopeExists(__fr_with138[__fr_index139])) with (__fr_with138[__fr_index139]) {
{
{ var __fr_with141 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "OasisStatue_create", (x + 16), (y + 16), (5 - global.fr_module_vars[$ "mod:Frontier_Main"].desertSubarea))), __fr_break143=false;
for (var __fr_index142=0; __fr_index142<array_length(__fr_with141); ++__fr_index142) {
if(scrFRScopeExists(__fr_with141[__fr_index142])) with (__fr_with141[__fr_index142]) {
{
scrFRInstanceCreate(x, y, LightBeam);
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_fill, x, y, 3, 3, "");
}
}
if(__fr_break143) break;
}}
}
}
if(__fr_break140) break;
}}
}
}
}
if (scrFRModLoaded("mod", "ntte")) {
{
scrFRModCall("mod", "Frontier_Objects", "SlaughterBSkinner_create", 10016, 10016);
;
}
}
break;
;
case 15:
if ((GameCont.loops > 0)) {
{
var _frl__goldStationFloor = [];
var _frl__goldStationIndex = (- 1);
{ var __fr_with144 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break146=false;
for (var __fr_index145=0; __fr_index145<array_length(__fr_with144); ++__fr_index145) {
if(scrFRScopeExists(__fr_with144[__fr_index145])) with (__fr_with144[__fr_index145]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__goldStationFloor, scrFRSelf(self));
;
_frl__goldStationIndex++;
;
}
}
}
}
}
}
if(__fr_break146) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__goldStationFloor);
;
if ((_frl__statueIndex >= 0)) {
{ var __fr_with147 = scrFRWithValues(scrFRIndexGet(_frl__goldStationFloor, (_frl__goldStationIndex--))), __fr_break149=false;
for (var __fr_index148=0; __fr_index148<array_length(__fr_with147); ++__fr_index148) {
if(scrFRScopeExists(__fr_with147[__fr_index148])) with (__fr_with147[__fr_index148]) {
{
{ var __fr_with150 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "WeaponExchangerGold_create", (x + 16), y)), __fr_break152=false;
for (var __fr_index151=0; __fr_index151<array_length(__fr_with150); ++__fr_index151) {
if(scrFRScopeExists(__fr_with150[__fr_index151])) with (__fr_with150[__fr_index151]) {
{
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_fill, x, y, 3, 3, "");
}
}
if(__fr_break152) break;
}}
}
}
if(__fr_break149) break;
}}
}
}
}
break;
;
case 16:

case 17:
scrFRModCall("mod", "Frontier_Caves", "HyperCrystalOurpler_create", 10016, 10016);
;
{ var __fr_with153 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break155=false;
for (var __fr_index154=0; __fr_index154<array_length(__fr_with153); ++__fr_index154) {
if(scrFRScopeExists(__fr_with153[__fr_index154])) with (__fr_with153[__fr_index154]) {
{
if ((((! styleb) && (scrFRSourceRandom(30) < 1)) && (distance_to_object(Player) > 32))) {
{
scrFRModCall("mod", "Frontier_Caves", "SpikeTrap_create", x, y, true);
}
}
}
}
if(__fr_break155) break;
}}
{ var __fr_with156 = scrFRWithValues(scrFRMatching(Floor, "object_index", Floor)), __fr_break158=false;
for (var __fr_index157=0; __fr_index157<array_length(__fr_with156); ++__fr_index157) {
if(scrFRScopeExists(__fr_with156[__fr_index157])) with (__fr_with156[__fr_index157]) {
{
if (((scrFRSourceRandom(30) < 1) && (distance_to_object(Player) > 32))) {
{
scrFRModCall("mod", "Frontier_Caves", "SpiderTrap_create", (x + 16), (y + 16), true);
}
}
}
}
if(__fr_break158) break;
}}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingAltCoveEntrance == false)) {
{
if ((GameCont.subarea == 1)) {
{
var _frl__coveEntranceFloor = [];
var _frl__coveEntranceIndex = (- 1);
{ var __fr_with159 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break161=false;
for (var __fr_index160=0; __fr_index160<array_length(__fr_with159); ++__fr_index160) {
if(scrFRScopeExists(__fr_with159[__fr_index160])) with (__fr_with159[__fr_index160]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__coveEntranceFloor, scrFRSelf(self));
;
_frl__coveEntranceIndex++;
;
}
}
}
}
}
}
if(__fr_break161) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__coveEntranceFloor);
;
if ((_frl__coveEntranceIndex >= 0)) {
{ var __fr_with162 = scrFRWithValues(scrFRIndexGet(_frl__coveEntranceFloor, (_frl__coveEntranceIndex--))), __fr_break164=false;
for (var __fr_index163=0; __fr_index163<array_length(__fr_with162); ++__fr_index163) {
if(scrFRScopeExists(__fr_with162[__fr_index163])) with (__fr_with162[__fr_index163]) {
{
var _frl__w = 1;
var _frl__h = 1;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with165 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break167=false;
for (var __fr_index166=0; __fr_index166<array_length(__fr_with165); ++__fr_index166) {
if(scrFRScopeExists(__fr_with165[__fr_index166])) with (__fr_with165[__fr_index166]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
;
scrFRModCall("mod", "Frontier_Caves", "CoveEntrance_create", x, y, true);
;
}
}
if(__fr_break167) break;
}}
}
}
if(__fr_break164) break;
}}
}
}
}
}
}
break;
;
case 18:

case 19:
var _frl__exitFloor = [];
var _frl__exitIndex = (- 1);
var _frl__stationFloor = [];
var _frl__stationIndex = (- 1);
;
if ((GameCont.subarea == 2)) {
{
{ var __fr_with168 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break170=false;
for (var __fr_index169=0; __fr_index169<array_length(__fr_with168); ++__fr_index169) {
if(scrFRScopeExists(__fr_with168[__fr_index169])) with (__fr_with168[__fr_index169]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__exitFloor, scrFRSelf(self));
;
_frl__exitIndex++;
;
}
}
}
}
}
}
if(__fr_break170) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__exitFloor);
;
if ((_frl__exitIndex >= 0)) {
{ var __fr_with171 = scrFRWithValues(scrFRIndexGet(_frl__exitFloor, (_frl__exitIndex--))), __fr_break173=false;
for (var __fr_index172=0; __fr_index172<array_length(__fr_with171); ++__fr_index172) {
if(scrFRScopeExists(__fr_with171[__fr_index172])) with (__fr_with171[__fr_index172]) {
{
scrFRModCall("mod", "Frontier_IDPD", "HQExit_create", (x + 16), (y + 16));
;
}
}
if(__fr_break173) break;
}}
}
}
}
if (((GameCont.subarea == 1) or (GameCont.subarea == 2))) {
{
{ var __fr_with174 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_FloorNormal), __fr_break176=false;
for (var __fr_index175=0; __fr_index175<array_length(__fr_with174); ++__fr_index175) {
if(scrFRScopeExists(__fr_with174[__fr_index175])) with (__fr_with174[__fr_index175]) {
{
if ((point_distance(frMacro_Frontier_Main_mod_gml_bbox_center_x, frMacro_Frontier_Main_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__stationFloor, scrFRSelf(self));
;
_frl__stationIndex++;
;
}
}
}
}
}
}
if(__fr_break176) break;
}}
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.array_shuffle, _frl__stationFloor);
;
if ((_frl__stationIndex >= 0)) {
{ var __fr_with177 = scrFRWithValues(scrFRIndexGet(_frl__stationFloor, (_frl__stationIndex--))), __fr_break179=false;
for (var __fr_index178=0; __fr_index178<array_length(__fr_with177); ++__fr_index178) {
if(scrFRScopeExists(__fr_with177[__fr_index178])) with (__fr_with177[__fr_index178]) {
{
var _frl__w = 5;
var _frl__h = 5;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 256;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with180 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break182=false;
for (var __fr_index181=0; __fr_index181<array_length(__fr_with180); ++__fr_index181) {
if(scrFRScopeExists(__fr_with180[__fr_index181])) with (__fr_with180[__fr_index181]) {
{
scrFRModCall("mod", "Frontier_IDPD", "AugmentStation_spawn", (x + 32), (y + 32));
;
scrFRModCall("mod", "Frontier_IDPD", "AugmentStation_spawn", (x - 32), (y + 32));
;
scrFRModCall("mod", "Frontier_IDPD", "AugmentStation_spawn", (x + 32), (y - 32));
;
scrFRModCall("mod", "Frontier_IDPD", "AugmentStation_spawn", (x - 32), (y - 32));
;
scrFRInstanceCreate((x + 64), (y + 64), PlantPot);
;
scrFRInstanceCreate((x - 64), (y + 64), PlantPot);
;
scrFRInstanceCreate((x + 64), (y - 64), PlantPot);
;
scrFRInstanceCreate((x - 64), (y - 64), PlantPot);
;
scrFRModCall("mod", "Frontier_IDPD", "AugmentMonolith_create", x, (y - 8));
;
scrFRModCall("mod", "Frontier_Objects", "PortalPusher_create", x, y, 128);
;
scrFRModCall("mod", "Frontier_IDPD", "AugmentStationFloor_create", x, y);
;
}
}
if(__fr_break182) break;
}}
}
}
if(__fr_break179) break;
}}
}
}
}
break;
;
}
}
global.fr_module_vars[$ "mod:Frontier_Main"].levelStart = false;
;
}
}
}
}
if (scrFRInstanceExists(GenCont)) {
{
if (((scrFRAlarmRead(GenCont, 0) > 0) && (scrFRAlarmRead(GenCont, 0) <= room_speed))) {
{
{ var __fr_with183 = scrFRWithValues(scrFRMatching(CrownPed, "fr_protocache", undefined)), __fr_break185=false;
for (var __fr_index184=0; __fr_index184<array_length(__fr_with183); ++__fr_index184) {
if(scrFRScopeExists(__fr_with183[__fr_index184])) with (__fr_with183[__fr_index184]) {
{
fr_protocache = "hihelloimhere";
;
var _frl__w = 5;
var _frl__h = 5;
var _frl__type = "round";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with186 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break188=false;
for (var __fr_index187=0; __fr_index187<array_length(__fr_with186); ++__fr_index187) {
if(scrFRScopeExists(__fr_with186[__fr_index187])) with (__fr_with186[__fr_index187]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
var _frl__img = 0;
;
{ var __fr_with189 = scrFRWithValues(floors), __fr_break191=false;
for (var __fr_index190=0; __fr_index190<array_length(__fr_with189); ++__fr_index190) {
if(scrFRScopeExists(__fr_with189[__fr_index190])) with (__fr_with189[__fr_index190]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorProtoCache);
;
image_index = (_frl__img++);
;
depth = 7;
;
}
}
if(__fr_break191) break;
}}
scrFRModCall("mod", "Frontier_Palace", "ProtoCache_create", x, y);
;
}
}
if(__fr_break188) break;
}}
}
}
if(__fr_break185) break;
}}
if (((! scrFRGetSkill("BurdenBlood")) && (GameCont.loops > 0))) {
{
{ var __fr_with192 = scrFRWithValues(scrFRMatching(CrownPed, "fr_bloodfountain", undefined)), __fr_break194=false;
for (var __fr_index193=0; __fr_index193<array_length(__fr_with192); ++__fr_index193) {
if(scrFRScopeExists(__fr_with192[__fr_index193])) with (__fr_with192[__fr_index193]) {
{
fr_bloodfountain = "ermGross";
;
var _frl__w = 3;
var _frl__h = 3;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 64;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with195 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break197=false;
for (var __fr_index196=0; __fr_index196<array_length(__fr_with195); ++__fr_index196) {
if(scrFRScopeExists(__fr_with195[__fr_index196])) with (__fr_with195[__fr_index196]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
var _frl__img = 0;
;
{ var __fr_with198 = scrFRWithValues(floors), __fr_break200=false;
for (var __fr_index199=0; __fr_index199<array_length(__fr_with198); ++__fr_index199) {
if(scrFRScopeExists(__fr_with198[__fr_index199])) with (__fr_with198[__fr_index199]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorBloodFountain);
;
image_index = (_frl__img++);
;
depth = 7;
;
}
}
if(__fr_break200) break;
}}
scrFRModCall("mod", "Frontier_Palace", "BloodFountain_create", x, (y - 22));
;
}
}
if(__fr_break197) break;
}}
}
}
if(__fr_break194) break;
}}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Main"].settingSurgeriesBeta == true)) {
{
{ var __fr_with201 = scrFRWithValues(scrFRMatching(CrownPed, "fr_surgerybeta", undefined)), __fr_break203=false;
for (var __fr_index202=0; __fr_index202<array_length(__fr_with201); ++__fr_index202) {
if(scrFRScopeExists(__fr_with201[__fr_index202])) with (__fr_with201[__fr_index202]) {
{
fr_surgerybeta = "yupp";
;
var _frl__w = 3;
var _frl__h = 3;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = 0;
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Main_mod_gml_FloorNormal;
;
{ var __fr_with204 = scrFRWithValues(frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break206=false;
for (var __fr_index205=0; __fr_index205<array_length(__fr_with204); ++__fr_index205) {
if(scrFRScopeExists(__fr_with204[__fr_index205])) with (__fr_with204[__fr_index205]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
var _frl__img = 0;
;
{ var __fr_with207 = scrFRWithValues(floors), __fr_break209=false;
for (var __fr_index208=0; __fr_index208<array_length(__fr_with207); ++__fr_index208) {
if(scrFRScopeExists(__fr_with207[__fr_index208])) with (__fr_with207[__fr_index208]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprFloorBloodFountain);
;
image_index = (_frl__img++);
;
depth = 7;
;
}
}
if(__fr_break209) break;
}}
scrFRModCall("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", (x + 28), (y - 32), "SurgerySlot");
;
scrFRModCall("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", (x - 28), (y - 32), "SurgerySlot2");
;
scrFRModCall("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", (x + 28), (y + 24), "SurgerySlot3");
;
scrFRModCall("mod", "Frontier_Objects", "BetaSurgeryStation_spawn", (x - 28), (y + 24), "SurgerySlot4");
;
}
}
if(__fr_break206) break;
}}
}
}
if(__fr_break203) break;
}}
}
}
}
}
}
}
}

// Original Frontier_Main.mod.gml:1097
function fr_Frontier_Main_mod_gml_CharSelect_draw_new(_frl__inst=undefined) {
    // BEGIN FRONTIER NATIVE SELECT OVERLAY NEW
    if(scrFRRaceSelectMarkerOwned(_frl__inst)) {scrFRInstanceDestroy();return;}
    // END FRONTIER NATIVE SELECT OVERLAY NEW

{ var __fr_with1 = scrFRWithValues(scrFRMatching(_frl__inst, "visible", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSprite(sprNew, image_index, ((scrFRViewCoordinate(0) + xstart) + (scrFRAlarmRead(scrFRSelf(self), 1) > 0)), ((scrFRViewCoordinate(1) + ystart) - mouseover));
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Frontier_Main.mod.gml:1103
function fr_Frontier_Main_mod_gml_CharSelect_draw_robot(_frl__inst=undefined) {
    // BEGIN FRONTIER NATIVE SELECT OVERLAY ROBOT
    if(scrFRRaceSelectMarkerOwned(_frl__inst)) {scrFRInstanceDestroy();return;}
    // END FRONTIER NATIVE SELECT OVERLAY ROBOT

{ var __fr_with1 = scrFRWithValues(scrFRMatching(_frl__inst, "visible", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Main"].sprNewRobot, image_index, ((scrFRViewCoordinate(0) + xstart) + (scrFRAlarmRead(scrFRSelf(self), 1) > 0)), ((scrFRViewCoordinate(1) + ystart) - mouseover));
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Frontier_Main.mod.gml:1109
function fr_Frontier_Main_mod_gml_frontier_race_deathstat(_frl__race=undefined) {
var _frl__stat = (_frl__race + string("_deaths"));
;
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_set, "Frontier", _frl__stat, (frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_get, "Frontier", _frl__stat) + 1));
scrFRModCall("race", _frl__race, "race_frontier_savestats");
}

// Original Frontier_Main.mod.gml:1115
function fr_Frontier_Main_mod_gml_frontier_race_winstat(_frl__race=undefined) {
var _frl__stat = (_frl__race + string("_wins"));
;
frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_set, "Frontier", _frl__stat, (frMacro_Frontier_Main_mod_gml_call(frMacro_Frontier_Main_mod_gml_scr.save_get, "Frontier", _frl__stat) + 1));
scrFRModCall("race", _frl__race, "race_frontier_savestats");
;
}

// Original Frontier_Main.mod.gml:1121
function fr_Frontier_Main_mod_gml_altareas_import_frontier() {
if (scrFRModLoaded("area", "AlternateAreaHandler")) {
{
var _frl__knownMods = scrFRModGet("area", "AlternateAreaHandler", "knownMods");
var _frl__knownIndex = 0;
var _frl__seeMe = 0;
;
repeat (array_length(_frl__knownMods)) {
if ((scrFRIndexGet(_frl__knownMods, _frl__knownIndex) == "Frontier_Main")) {
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
array_push(_frl__knownMods, "Frontier_Main");
;
scrFRModSet("area", "AlternateAreaHandler", "knownMods", _frl__knownMods);
scrFRModCall("area", "AlternateAreaHandler", "area_add", 5, ["graveyard", "altLabsMode_check", true, false, "Frontier_Main"]);
;
scrFRModCall("area", "AlternateAreaHandler", "area_add", 6, ["robocenter", "altLabsMode_check", true, false, "Frontier_Main"]);
;
scrFRModCall("area", "AlternateAreaHandler", "area_add", 5, ["graveyard", "jungleGraveyard_check", false, true, "Frontier_Main"]);
;
}
}
}
}
}

// Original Frontier_Main.mod.gml:1147
function fr_Frontier_Main_mod_gml_altLabsMode_check() {
var _frl__weight = ((global.fr_module_vars[$ "mod:Frontier_Main"].settingLabsRouteAltMode == true) ? 1 : 0);
;
return _frl__weight;
;
}

// Original Frontier_Main.mod.gml:1151
function fr_Frontier_Main_mod_gml_jungleGraveyard_check() {
return GameCont.fr_jungleToGraveyard;
;
}

// Original Frontier_Main.mod.gml:1154
function fr_Frontier_Main_mod_gml_detailsPlus_import_frontier() {
if (scrFRModLoaded("mod", "Details+")) {
{
var _frl__knownMods = scrFRModGet("mod", "Details+", "knownMods");
var _frl__knownIndex = 0;
var _frl__seeMe = 0;
;
repeat (array_length(_frl__knownMods)) {
if ((scrFRIndexGet(_frl__knownMods, _frl__knownIndex) == "Frontier_Main")) {
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
array_push(_frl__knownMods, "Frontier_Main");
;
scrFRModSet("mod", "Details+", "knownMods", _frl__knownMods);
scrFRModCall("mod", "Details+", "detailsPlus_add_statue", "graveyard", [global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardProtoStatueDecal, global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardProtoStatueDecalDead]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("area", "graveyard", "sprFloor"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorchTop, 1)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprGraveyardScorch, 1)]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprFloor1BNight"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorchTop, 0)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorch, 0)]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprDetailsPlusFloorDesertBOutNight"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorchTop, 0)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprDesertBNightScorch, 0)]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprFloor5Night"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorchTop, 1)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorch, 1)]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprFloor5ExploNight"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityNightScorchTop, 1)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityExploNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityExploNightScorch, 1)]);
;
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprFloor5BNight"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorchTop, 1)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCityBNightScorch, 1)]);
;
}
}
if (scrFRModLoaded("mod", "ntte")) {
{
var _frl__knownMods = scrFRModGet("mod", "Details+", "knownMods");
var _frl__knownIndex = 0;
var _frl__seeMe = 0;
;
repeat (array_length(_frl__knownMods)) {
if ((scrFRIndexGet(_frl__knownMods, _frl__knownIndex) == "frontier_ntte_compat")) {
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
array_push(_frl__knownMods, "frontier_ntte_compat");
;
scrFRModSet("mod", "Details+", "knownMods", _frl__knownMods);
scrFRModCall("mod", "Details+", "detailsPlus_add_scorch", scrFRModGet("mod", "Frontier_Events", "sprFloorCoastNight"), [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorchTop, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorchTop, 0)], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorch, 0), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Main"].sprCoastNightScorch, 0)]);
;
}
}
}
}
}
}
}

// Original Frontier_Main.mod.gml:1224
function fr_Frontier_Main_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}
