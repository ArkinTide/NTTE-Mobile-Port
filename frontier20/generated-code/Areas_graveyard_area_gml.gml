#macro frMacro_Areas_graveyard_area_gml_scr global.fr_module_vars[$ "area:graveyard"].scr

#macro frMacro_Areas_graveyard_area_gml_call scrFRScriptCall

#macro frMacro_Areas_graveyard_area_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Areas_graveyard_area_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

// Original Areas/graveyard.area.gml:1
function fr_Areas_graveyard_area_gml___load() {

}

// Original Areas/graveyard.area.gml:1
function fr_Areas_graveyard_area_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_graveyard_area_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Areas_graveyard_area_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_graveyard_area_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/graveyard.area.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "area", "graveyard", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "area:graveyard"].musGraveyard = sndFR_musGraveyard_4565bfae75d3;
;
global.fr_module_vars[$ "area:graveyard"].musGraveyardB = sndFR_musGraveyardB_868762f1d567;
;
global.fr_module_vars[$ "area:graveyard"].sprAreaIcon = sprFR_sprLabsRouteIcon_654cbb1bced6;
;
global.fr_module_vars[$ "area:graveyard"].sprFloor = sprFR_sprFloorGraveyard_6e65924ec57a;
;
global.fr_module_vars[$ "area:graveyard"].sprFloorB = sprFR_sprFloorGraveyardB_ddce8074b723;
;
global.fr_module_vars[$ "area:graveyard"].sprSnowFloorGraveyard = sprFR_sprSnowFloorGraveyard_290b702a6677;
;
global.fr_module_vars[$ "area:graveyard"].sprFloorExplo = sprFR_sprFloorGraveyardExplo_e9c9f05d12d1;
;
global.fr_module_vars[$ "area:graveyard"].sprWallBot = sprFR_sprWallGraveyardBot_aa8ad65acabf;
;
global.fr_module_vars[$ "area:graveyard"].sprWallTop = sprFR_sprWallGraveyardTop_4d8f1482b9ad;
;
global.fr_module_vars[$ "area:graveyard"].sprWallOut = sprFR_sprWallGraveyardOut_453e46ad8dda;
;
global.fr_module_vars[$ "area:graveyard"].sprWallTrans = sprFR_sprWallGraveyardTrans_71ce02584120;
;
global.fr_module_vars[$ "area:graveyard"].sprDebris = sprFR_sprDebrisGraveyard_326b796e543b;
;
global.fr_module_vars[$ "area:graveyard"].sprDetail = sprFR_sprDetailGraveyard_4f841bbf2c01;
;
global.fr_module_vars[$ "area:graveyard"].sprDecal = sprFR_sprGraveyardDecal_b0f3962ebb40;
;
global.fr_module_vars[$ "area:graveyard"].sprTopDecal = sprFR_sprTopDecalGraveyard_b388d24b6a7e;
;
global.fr_module_vars[$ "area:graveyard"].sprTopDecal2 = sprFR_sprTopDecalGraveyard2_eebd220bfe02;
;
global.fr_module_vars[$ "area:graveyard"].sprSnowFlakeGraveyard = sprFR_sprSnowFlakeGraveyard_928f6c9de730;
;
global.fr_module_vars[$ "area:graveyard"].sprVoltergeistLightning = [sprFR_sprVoltergeistLightning_c3762615fa62, sprFR_sprVoltergeistLightning2_8892eec6098f, sprFR_sprVoltergeistLightning3_abd1f0f77904, sprFR_sprVoltergeistLightning4_189ab66503d6, sprFR_sprVoltergeistLightning5_1ef81ba8c1a6];
;
global.fr_module_vars[$ "area:graveyard"].sprVoltergeistDust = sprFR_sprVoltergeistDust_a791d7b5d36b;
;
global.fr_module_vars[$ "area:graveyard"].sprVoltergeistRevive = sprFR_sprVoltergeistRevive_a7dfddd026a4;
;
global.fr_module_vars[$ "area:graveyard"].mskMortarSpawn = [sprFR_mskMortarSpawn_448a13bc153e, sprFR_mskMortarSpawn2_73b751305aa7];
global.fr_module_vars[$ "area:graveyard"].sprMortarSpawn = [sprFR_sprMortarSpawn_2e811c843a71, sprFR_sprMortarSpawn2_08a84906c10f];
global.fr_module_vars[$ "area:graveyard"].sprMortarSpawnHurt = [sprFR_sprMortarSpawnHurt_d9d5779dd9cf, sprFR_sprMortarSpawn2Hurt_be62cab1083d];
global.fr_module_vars[$ "area:graveyard"].sprMortarSpawnDead = [sprFR_sprMortarSpawnDead_bb531a243704, sprFR_sprMortarSpawn2Dead_a394043a998b];
global.fr_module_vars[$ "area:graveyard"].mskChargerSpawn = [sprFR_mskChargerSpawn_f90e05da10f6, sprFR_mskChargerSpawn2_d25aa667c36d];
;
global.fr_module_vars[$ "area:graveyard"].sprChargerSpawn = [sprFR_sprChargerSpawn_881f96055f85, sprFR_sprChargerSpawn2_b2c162473dad];
;
global.fr_module_vars[$ "area:graveyard"].sprChargerSpawnHurt = [sprFR_sprChargerSpawnHurt_6eee4b47591e, sprFR_sprChargerSpawn2Hurt_2661b47fa16a];
;
global.fr_module_vars[$ "area:graveyard"].sprChargerSpawnDead = [sprFR_sprChargerSpawnDead_065ea86d75fb, sprFR_sprChargerSpawn2Dead_3edcfd20304e];
;
global.fr_module_vars[$ "area:graveyard"].mskOrbiterSpawn = [sprFR_mskOrbiterSpawn_802004bbb720, sprFR_mskOrbiterSpawn2_c3e1b51976b3];
global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawn = [sprFR_sprOrbiterSpawn_4240775a39ca, sprFR_sprOrbiterSpawn2_b8ab63aabb89];
global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawnHurt = [sprFR_sprOrbiterSpawnHurt_8adcfdb95770, sprFR_sprOrbiterSpawn2Hurt_5e4d1626da2b];
global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawnDead = [sprFR_sprOrbiterSpawnDead_d0fd9f78ebe1, sprFR_sprOrbiterSpawn2Dead_ed6307b83c07];
global.fr_module_vars[$ "area:graveyard"].mskBigPile = [sprFR_mskBigPileFreaks_9a474f0f9d45, sprFR_mskBigPileFrocity_42fd405144fe];
;
global.fr_module_vars[$ "area:graveyard"].sprBigPile = [sprFR_sprBigPileFreaks_2b22ca88f063, sprFR_sprBigPileFrocity_3b2fc57248c8];
;
global.fr_module_vars[$ "area:graveyard"].sprBigPileHurt = [sprFR_sprBigPileFreaksHurt_13b8dfe1494c, sprFR_sprBigPileFrocityHurt_2625088b9da8];
;
global.fr_module_vars[$ "area:graveyard"].sprBigPileDead = [sprFR_sprBigPileFreaksDead_09d0c2b1d281, sprFR_sprBigPileFrocityDead_3c18905d8403];
;
global.fr_module_vars[$ "area:graveyard"].mskBigPileBossScrap = sprFR_mskBigPileBossScrap_36a883a4bb82;
;
global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrap = sprFR_sprBigPileBossScrap_b3f0f71b281d;
;
global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrapHurt = sprFR_sprBigPileBossScrapHurt_ffeee8c53a51;
;
global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrapDead = sprFR_sprBigPileBossScrapDead_e1e4c4548d8c;
;
global.fr_module_vars[$ "area:graveyard"].sprSnowPoff = sprFR_sprSnowPoff_f94533f58b5e;
;
global.fr_module_vars[$ "area:graveyard"].sprSnowPoffHurt = sprFR_sprSnowPoffHurt_e7c9f205de1f;
;
global.fr_module_vars[$ "area:graveyard"].sprSnowPoffDead = sprFR_sprSnowPoffDead_a2b402da531b;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnace = sprFR_sprFurnace_8b73fc5346be;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnaceHurt = sprFR_sprFurnaceHurt_3bf3fdf0ea0f;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnaceDead = sprFR_sprFurnaceDead_1abcb9119906;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnace2 = sprFR_sprFurnace2_e1ecdbd75149;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnace2Hurt = sprFR_sprFurnace2Hurt_9f801e42bfeb;
;
global.fr_module_vars[$ "area:graveyard"].sprFurnace2Dead = sprFR_sprFurnace2Dead_23be153b71f4;
;
global.fr_module_vars[$ "area:graveyard"].sprVolterPump = sprFR_sprVolterPump_59120a19b9ad;
;
global.fr_module_vars[$ "area:graveyard"].sprVolterPumpHurt = sprFR_sprVolterPumpHurt_11bc21a504b3;
;
global.fr_module_vars[$ "area:graveyard"].sprVolterPumpDead = sprFR_sprVolterPumpDead_050c86040a75;
;
global.fr_module_vars[$ "area:graveyard"].sprJunkDebris = [sprFR_sprJunkDebris_2d1779a212b0, sprFR_sprJunkDebris2_2e5a695c0792, sprFR_sprJunkDebris3_156fc445c6ea, sprFR_sprJunkDebris4_89f9379a2552];
global.fr_module_vars[$ "area:graveyard"].mskVariaThundershockPile = sprFR_mskVariaThundershockPile_b26f41a591c0;
;
global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPile = sprFR_sprVariaThundershockPile_8ccf9c954f31;
;
global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPileHurt = sprFR_sprVariaThundershockPile_2649543b51bd;
;
global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPileDead = sprFR_sprVariaThundershockPile_6c12b791a983;
;
global.fr_module_vars[$ "area:graveyard"].fr_smoke_array = [];
global.fr_module_vars[$ "area:graveyard"].fr_smokestack_array = [];
global.fr_module_vars[$ "area:graveyard"].variaThundershockBroken = false;
;
global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode = false;
;
; // macro hoisted: current_frame_active
; // macro hoisted: FloorNormal
}
_fr.pc=0;
break;
case 3: // Areas/graveyard.area.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Areas/graveyard.area.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Areas/graveyard.area.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/graveyard.area.gml:180
function fr_Areas_graveyard_area_gml_area_subarea() {
return 3;
;
}

// Original Areas/graveyard.area.gml:181
function fr_Areas_graveyard_area_gml_area_goal() {
return 95;
;
}

// Original Areas/graveyard.area.gml:182
function fr_Areas_graveyard_area_gml_area_next() {
return (((global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode == true) && (! scrFRModLoaded("area", "scorpionboss"))) ? [6, 1] : ["robocenter", 1]);
;
}

// Original Areas/graveyard.area.gml:183
function fr_Areas_graveyard_area_gml_area_background_color() {
return make_color_rgb(130, 130, 147);
;
}

// Original Areas/graveyard.area.gml:184
function fr_Areas_graveyard_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/graveyard.area.gml:185
function fr_Areas_graveyard_area_gml_area_darkness() {
return false;
;
}

// Original Areas/graveyard.area.gml:186
function fr_Areas_graveyard_area_gml_area_secret() {
return false;
;
}

// Original Areas/graveyard.area.gml:187
function fr_Areas_graveyard_area_gml_area_outside() {
return true;
;
}

// Original Areas/graveyard.area.gml:189
function fr_Areas_graveyard_area_gml_area_name() {
return scrFRLocalize(((global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode == true) ? (("@1(" + string(real(global.fr_module_vars[$ "area:graveyard"].sprAreaIcon)) + ":0)5-") + string(GameCont.subarea)) : (("@1(" + string(real(global.fr_module_vars[$ "area:graveyard"].sprAreaIcon)) + ":0)1-") + string(GameCont.subarea))));
;
}

// Original Areas/graveyard.area.gml:192
function fr_Areas_graveyard_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("RUBBISH", "WHAT A WASTE", "ROT", "RECYCLING"));
;
}

// Original Areas/graveyard.area.gml:200
function fr_Areas_graveyard_area_gml_area_mapdata(_frl__lastX=undefined, _frl__lastY=undefined, _frl__lastArea=undefined, _frl__lastSubarea=undefined, _frl__subarea=undefined, _frl__loops=undefined) {
return [(72 + (9.5 * (_frl__subarea - 1))), (- 9), (_frl__subarea == 1)];
}

// Original Areas/graveyard.area.gml:205
function fr_Areas_graveyard_area_gml_area_areaicon() {
return [global.fr_module_vars[$ "area:graveyard"].sprAreaIcon, ((global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode == true) ? ("5-" + string(GameCont.subarea)) : ("1-" + string(GameCont.subarea)))];
}

// Original Areas/graveyard.area.gml:211
function fr_Areas_graveyard_area_gml_area_sprite(_frl_q=undefined) {
{ var __fr_switch_value1=_frl_q, __fr_switch_case2=-1;
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
fr_Areas_graveyard_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:graveyard"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_graveyard_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:graveyard"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:graveyard"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:graveyard"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:graveyard"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:graveyard"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:graveyard"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:graveyard"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:graveyard"].sprDetail;
;
}
}
}

// Original Areas/graveyard.area.gml:224
function fr_Areas_graveyard_area_gml_area_setup() {
if ((GameCont.subarea == 1)) {
{
if (array_length(scrFRMatchingLE(Player, "my_health", 1))) {
{
if ((GameCont.crownvisits < 3)) {
{
GameCont.proto = true;
;
}
}
}
}
}
}
var _frl__music = ((GameCont.proto == true) ? global.fr_module_vars[$ "area:graveyard"].musGraveyardB : global.fr_module_vars[$ "area:graveyard"].musGraveyard);
;
if (((! audio_is_playing(global.fr_module_vars[$ "area:graveyard"].musGraveyard)) && (! audio_is_playing(global.fr_module_vars[$ "area:graveyard"].musGraveyardB)))) {
{
scrFRSoundMusic(_frl__music);
}
}
scrFRSoundAmbient(amb5);
;
goal = fr_Areas_graveyard_area_gml_area_goal();
;
background_set_colour(fr_Areas_graveyard_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_graveyard_area_gml_area_shadow_color();
;
TopCont.darkness = fr_Areas_graveyard_area_gml_area_darkness();
;
safespawn = 1;
;
scrFRBindStep(fr_Areas_graveyard_area_gml_area_step, 0);
scrFRSoundAssign(sndWallBreakRock, sndWallBreakLabs);
;
}

// Original Areas/graveyard.area.gml:251
function fr_Areas_graveyard_area_gml_area_setup_floor() {
if (styleb) {
{
depth -= 2;
;
}
}
material = (styleb ? 3 : 1);
;
}

// Original Areas/graveyard.area.gml:262
function fr_Areas_graveyard_area_gml_area_start() {
{ var __fr_with1 = scrFRWithValues(Wall), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((scrFRPlaceMeeting((x + 16), y, Floor) && scrFRPlaceMeeting((x + 48), y, Wall)) && (scrFRSourceRandom(5) < 1))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + 16), (y + 2), Bones)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprDecal);
;
image_xscale = 1;
;
image_index = scrFRSourceRandom(image_number);
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + 48), (y + 2), Bones)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprDecal);
;
image_xscale = (- 1);
;
image_index = scrFRSourceRandom(image_number);
}
}
if(__fr_break9) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with10 = scrFRWithValues(Floor), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((scrFRSourceRandom(7) < 1)) {
{
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, TopDecalCity)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprTopDecal);
;
dir = scrFRSourceChoose((- 1), 1);
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
{ var __fr_with16 = scrFRWithValues(Floor), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((scrFRSourceRandom(13) < 1)) {
{
{ var __fr_with19 = scrFRWithValues(scrFRInstanceCreate(x, y, TopPot)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprTopDecal2);
;
image_xscale = scrFRSourceChoose((- 1), 1);
dir = scrFRSourceChoose((- 1), 1);
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smokestack_array, scrFRSelf(self));
}
}
if(__fr_break21) break;
}}
}
}
}
}
if(__fr_break18) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(Floor, "styleb", 1)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
{ var __fr_with25 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceIRandomRange((- 1), 1)), (y - scrFRSourceIRandomRange(2, 3)), SnowFloor)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprSnowFloorGraveyard);
;
var __fr_other28=scrFROther(other);
image_speed = ((__fr_other28.image_speed / timescale)) * timescale;
;
var __fr_other29=scrFROther(other);
image_index = __fr_other29.image_index;
;
image_angle += scrFRSourceRandomRange((- 1), 1);
var __fr_other30=scrFROther(other);
depth = (__fr_other30.depth + 1);
;
}
}
if(__fr_break27) break;
}}
}
}
if(__fr_break24) break;
}}
{ var __fr_with31 = scrFRWithValues(scrFRMatching(Floor, "fr_graveyardBigPileFloor", true)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
if ((! styleb)) {
{
var _frl__bigPile = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.pool, [["BigPile_create", 1], ["BigPileBossScrap_create", 0.1]]);
scrFRModCall("area", "graveyard", _frl__bigPile, (x + 16), (y + 16));
;
}
}
}
}
if(__fr_break33) break;
}}
{ var __fr_with34 = scrFRWithValues(scrFRMatching(prop, "fr_allowDespawn", true)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
var _frl__nearestBigPile = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.instance_nearest_array, x, y, scrFRMatching(Floor, "fr_graveyardBigPileFloor", true));
;
if (scrFRInstanceExists(_frl__nearestBigPile)) {
{
if ((distance_to_object(_frl__nearestBigPile) < 48)) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
}
}
if(__fr_break36) break;
}}
{ var __fr_with37 = scrFRWithValues(Bandit), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break39) break;
}}
{ var __fr_with40 = scrFRWithValues(GoldSnowTank), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
scrFRInstanceCreate(x, y, SnowTank);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break42) break;
}}
{ var __fr_with43 = scrFRWithValues(scrFRMatching(Floor, "fr_floorThundershock", true)), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
fr_Areas_graveyard_area_gml_VariaThundershockPile_create((x + 16), (y + 16));
}
}
if(__fr_break45) break;
}}
if ((GameCont.subarea == 3)) {
{
scrFRInstanceCreate(10016, 10016, WantLH);
;
fr_Areas_graveyard_area_gml_HunterMusicPlayer_create(10016, 10016);
;
}
}
if ((global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode == true)) {
{
if ((scrFRGetSkill(mut_last_wish) > 0)) {
{
{ var __fr_with46 = scrFRWithValues(frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.instance_random, Floor)), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
{ var __fr_with49 = scrFRWithValues(frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.floor_room, x, y, 0, frMacro_Areas_graveyard_area_gml_FloorNormal, 1, 1, "", 0, 0)), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
scrFRInstanceCreate(x, y, IceFlower);
;
}
}
if(__fr_break51) break;
}}
}
}
if(__fr_break48) break;
}}
}
}
}
}
}

// Original Areas/graveyard.area.gml:369
function fr_Areas_graveyard_area_gml_area_make_floor() {
var _frl__x = x;
var _frl__y = y;
var _frl__outOfSpawn = (point_distance(_frl__x, _frl__y, 10000, 10000) > 48);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSourceRandom(25) < 1)) {
{
fr_graveyardBigPileFloor = true;
;
fr_Areas_graveyard_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
;
}
}
}
}
if(__fr_break3) break;
}}
if ((scrFRSourceRandom(14) < 1)) {
{
fr_Areas_graveyard_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
;
}
}
var _frl__turn = 0;
;
if ((scrFRSourceRandom(5) < 1)) {
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
if ((scrFRSourceRandom(5) < 1)) {
{
scrFRInstanceCreate(_frl__x, _frl__y, FloorMaker);
;
}
}
{ var __fr_with4 = scrFRWithValues(GenCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
if (((scrFRInstanceNumber(Floor) > goal) && ((GameCont.subarea == 2) && (GameCont.crownvisits < 3)))) {
{
{ var __fr_with7 = scrFRWithValues(instance_furthest(10000, 10000, Floor)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(instance_nearest(((((x * 2) + 10000) / 3) + scrFRSourceRandomRange((- 64), 64)), ((((y * 2) + 10000) / 3) + scrFRSourceRandomRange((- 64), 64)), Floor)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRInstanceCreate((x + 16), (y + 16), ProtoStatue);
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
}
if(__fr_break6) break;
}}
{ var __fr_with13 = scrFRWithValues(GenCont), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
if (((((scrFRInstanceNumber(Floor) > goal) && (GameCont.subarea == 1)) && (global.fr_module_vars[$ "area:graveyard"].variaThundershockBroken == false)) && scrFRModLoaded("weapon", "va_thundershock"))) {
{
{ var __fr_with16 = scrFRWithValues(instance_furthest(10000, 10000, Floor)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
{ var __fr_with19 = scrFRWithValues(instance_nearest((((x + 10000) / 2) + scrFRSourceRandomRange((- 64), 64)), (((y + 10000) / 2) + scrFRSourceRandomRange((- 64), 64)), Floor)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
fr_Areas_graveyard_area_gml_scrFloorFill(x, y, 3, 3);
fr_floorThundershock = true;
;
}
}
if(__fr_break21) break;
}}
}
}
if(__fr_break18) break;
}}
}
}
}
if(__fr_break15) break;
}}
}

// Original Areas/graveyard.area.gml:441
function fr_Areas_graveyard_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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

// Original Areas/graveyard.area.gml:455
function fr_Areas_graveyard_area_gml_area_pop_enemies() {
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
;
var _frl__enemy = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.pool, [[["Cremator_create", "MOD", "Frontier_Labs"], 1.5], [["VesselMortar_spawn", "MOD", "Frontier_Labs"], 1], [["VesselOrbiter_spawn", "MOD", "Frontier_Labs"], 1.2], [["VesselCharger_spawn", "MOD", "Frontier_Labs"], 1], [["Voltergeist_create", "MOD", "Frontier_Labs"], 0.5], [[SnowTank, "Basegame", ""], (0.8 * (GameCont.loops > 0))], [[Guardian, "Basegame", ""], (0.8 * (GameCont.loops > 0))], [["GraveyardAssassin_create", "MOD", "Frontier_Labs"], (0.7 * (GameCont.loops > 0))]]);
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

// Original Areas/graveyard.area.gml:487
function fr_Areas_graveyard_area_gml_area_pop_props() {
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
var _frl__outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
;
if (_frl__outOfSpawn) {
{
var _frl__nearestBigPile = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.instance_nearest_array, x, y, scrFRMatching(Floor, "fr_graveyardBigPileFloor", true));
;
if (scrFRInstanceExists(_frl__nearestBigPile)) {
{
if ((distance_to_object(_frl__nearestBigPile) < 32)) {
{
exit;
;
}
}
}
}
if (((scrFRSourceRandom(2) < 1) && (! scrFRPlaceMeeting(_frl__x, _frl__y, prop)))) {
{
if (styleb) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
var _frl__bFloorProp = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.pool, [["Furnace_create", 1], ["Furnace2_create", 1], ["VolterPump_create", 0.3]]);
;
scrFRModCall("area", "graveyard", _frl__bFloorProp, _frl__x, _frl__y);
;
}
}
}
} else {
{
var _frl__prop = frMacro_Areas_graveyard_area_gml_call(frMacro_Areas_graveyard_area_gml_scr.pool, [["MortarSpawn_create", 0.5], ["OrbiterSpawn_create", 0.5], ["ChargerSpawn_create", 0.5], ["SnowPoff_create", 0.2]]);
;
scrFRModCall("area", "graveyard", _frl__prop, _frl__x, _frl__y);
;
}
}
}
}
}
}
}

// Original Areas/graveyard.area.gml:523
function fr_Areas_graveyard_area_gml_area_finish() {
if ((subarea < fr_Areas_graveyard_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_graveyard_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
}

// Original Areas/graveyard.area.gml:537
function fr_Areas_graveyard_area_gml_area_transit() {
scrFRSoundRestore(sndWallBreakRock);
;
if ((GameCont.fr_jungleToGraveyard == true)) {
{
if ((GameCont.area != scrFRAreaTryResolve(5))) {
{
GameCont.fr_jungleToGraveyard = false;
;
}
}
}
}
if ((global.fr_module_vars[$ "area:graveyard"].settingLabsRouteAltMode == true)) {
{
if ((GameCont.area == scrFRAreaTryResolve(105))) {
{
if ((GameCont.lastarea == scrFRAreaTryResolve("graveyard"))) {
{
GameCont.fr_jungleToGraveyard = true;
;
}
}
}
}
}
}
}

// Original Areas/graveyard.area.gml:555
function fr_Areas_graveyard_area_gml_area_step() {
var _frl__smokeDirection = (120 + (sin((scrFRSourceFrame() * 0.06)) * 20));
;
if (array_length(global.fr_module_vars[$ "area:graveyard"].fr_smokestack_array)) {
{
global.fr_module_vars[$ "area:graveyard"].smokestack_array = scrFRMatchingNE(global.fr_module_vars[$ "area:graveyard"].fr_smokestack_array, "id");
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "area:graveyard"].fr_smokestack_array), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((scrFRInstanceExists(scrFRSelf(self)) && (scrFRSourceRandom(2) < 1)) && frMacro_Areas_graveyard_area_gml_current_frame_active)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y - 30), Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, scrFRSelf(self));
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = (_frl__smokeDirection + scrFRSourceRandomRange((- 20), 20));
;
speed = (1.5) * timescale;
;
depth = (- 7);
;
growspeed = 0.14;
;
friction = ((- 0.2)) * (timescale * timescale);
;
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
}
}
if (array_length(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array)) {
{
global.fr_module_vars[$ "area:graveyard"].fr_smoke_array = scrFRMatchingNE(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, "id");
{ var __fr_with7 = scrFRWithValues(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((scrFRInstanceExists(scrFRSelf(self)) && frMacro_Areas_graveyard_area_gml_current_frame_active)) {
{
image_alpha -= 0.03;
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
if (frMacro_Areas_graveyard_area_gml_current_frame_active) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(((scrFRViewCoordinate(0) + scrFRSourceRandom((view_width * 2))) - (view_width / 2)), ((scrFRViewCoordinate(1) + scrFRSourceRandom((view_height * 2))) - (view_height / 2)), SnowFlake)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprSnowFlakeGraveyard);
;
}
}
if(__fr_break12) break;
}}
}
}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(Player, "race_gets_chilly", true)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if (((race != scrFRRaceTryResolve("robot")) && (race != scrFRRaceTryResolve("plant")))) {
{
if ((scrFRSourceRandom(50) < 1)) {
{
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate(x, y, Breath)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
var __fr_other19=scrFROther(other);
image_xscale = __fr_other19.right;
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
if(__fr_break15) break;
}}
}
}
}

// Original Areas/graveyard.area.gml:610
function fr_Areas_graveyard_area_gml_PossessablePropExample_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PossessablePropExample";
;
spr_idle = sprHydrant;
;
spr_hurt = sprHydrantHurt;
;
spr_dead = sprHydrantDead;
;
spr_debris = sprDebris6;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRMaxHealthWrite(id, 10, "=");
;
hp = max_hp;
;
size = 3;
;
debrisRange = 3;
;
fr_possessor = noone;
;
on_possessed = ["area", "graveyard", fr_Areas_graveyard_area_gml_PossessablePropExample_possessed];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:640
function fr_Areas_graveyard_area_gml_PossessablePropExample_possessed() {
{ var __fr_with1 = scrFRWithValues(fr_possessor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
possess_target = scrFRInstanceCreate(__fr_other4.x, __fr_other4.y, Bandit);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Areas/graveyard.area.gml:646
function fr_Areas_graveyard_area_gml_MortarSpawn_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_MortarSpawn";
;
var _frl__variant = scrFRSourceIRandom(1);
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprMortarSpawn, _frl__variant);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprMortarSpawnHurt, _frl__variant);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprMortarSpawnDead, _frl__variant);
;
spr_debris = sprDebris6;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_shadow = mskNone;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].mskMortarSpawn, _frl__variant);
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRMaxHealthWrite(id, 35, "=");
;
hp = max_hp;
;
size = 3;
;
debrisRange = 3;
;
fr_possessor = noone;
;
fr_allowDespawn = true;
;
on_possessed = ["area", "graveyard", fr_Areas_graveyard_area_gml_MortarSpawn_possessed];
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

// Original Areas/graveyard.area.gml:684
function fr_Areas_graveyard_area_gml_MortarSpawn_possessed() {
{ var __fr_with1 = scrFRWithValues(fr_possessor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
possess_target = fr_Areas_graveyard_area_gml_MortarSpawnVessel_create(__fr_other4.x, __fr_other4.y);
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndSwapCursed, (0.6 + scrFRSourceRandom(0.1)), 1);
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, ReviveFX)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistRevive);
;
depth = (- 3);
;
}
}
if(__fr_break7) break;
}}
repeat (6) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break10) break;
}}
}
repeat (12) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), Dust)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistDust);
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
scrFRInstanceCreate(x, y, PortalClear);
;
scrFRInstanceDestroy();
;
}

// Original Areas/graveyard.area.gml:716
function fr_Areas_graveyard_area_gml_MortarSpawnVessel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "VesselMortar_create", _frl__x, _frl__y, true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
loading = false;
;
loaded = true;
;
spr_idle = spr_idle_loaded;
;
spr_walk = spr_walk_loaded;
;
spr_hurt = spr_hurt_loaded;
;
spr_dead = spr_dead_loaded;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:729
function fr_Areas_graveyard_area_gml_OrbiterSpawn_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_OrbiterSpawn";
;
var _frl__variant = scrFRSourceIRandom(1);
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawn, _frl__variant);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawnHurt, _frl__variant);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprOrbiterSpawnDead, _frl__variant);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].mskOrbiterSpawn, _frl__variant);
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 3;
;
debrisRange = 3;
;
fr_possessor = noone;
;
fr_allowDespawn = true;
;
on_possessed = ["area", "graveyard", fr_Areas_graveyard_area_gml_OrbiterSpawn_possessed];
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

// Original Areas/graveyard.area.gml:765
function fr_Areas_graveyard_area_gml_OrbiterSpawn_possessed() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(fr_possessor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
possess_target = scrFRModCall("mod", "Frontier_Labs", "VesselOrbiter_create", __fr_other7.x, __fr_other7.y);
}
}
if(__fr_break6) break;
}}
scrFRSoundPitchVolume(sndSwapCursed, (0.6 + scrFRSourceRandom(0.1)), 1);
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, ReviveFX)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistRevive);
;
depth = (- 3);
;
}
}
if(__fr_break10) break;
}}
repeat (6) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
repeat (12) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistDust);
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break16) break;
}}
}
scrFRInstanceDestroy();
;
}

// Original Areas/graveyard.area.gml:800
function fr_Areas_graveyard_area_gml_ChargerSpawn_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ChargerSpawn";
;
var _frl__variant = scrFRSourceIRandom(1);
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprChargerSpawn, _frl__variant);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprChargerSpawnHurt, _frl__variant);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprChargerSpawnDead, _frl__variant);
;
spr_debris = sprDebris6;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].mskChargerSpawn, _frl__variant);
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 3;
;
debrisRange = 3;
;
fr_possessor = noone;
;
fr_allowDespawn = true;
;
on_possessed = ["area", "graveyard", fr_Areas_graveyard_area_gml_ChargerSpawn_possessed];
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

// Original Areas/graveyard.area.gml:837
function fr_Areas_graveyard_area_gml_ChargerSpawn_possessed() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(fr_possessor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
possess_target = scrFRModCall("mod", "Frontier_Labs", "VesselCharger_create", __fr_other7.x, __fr_other7.y);
}
}
if(__fr_break6) break;
}}
scrFRSoundPitchVolume(sndSwapCursed, (0.6 + scrFRSourceRandom(0.1)), 1);
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, ReviveFX)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistRevive);
;
depth = (- 3);
;
}
}
if(__fr_break10) break;
}}
repeat (6) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
repeat (12) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistDust);
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break16) break;
}}
}
scrFRInstanceDestroy();
;
}

// Original Areas/graveyard.area.gml:873
function fr_Areas_graveyard_area_gml_SnowPoff_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SnowPoff";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprSnowPoff;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprSnowPoffHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprSnowPoffDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitPlant;
;
snd_dead = sndMoneyPileBreak;
;
scrFRMaxHealthWrite(id, 2, "=");
;
hp = max_hp;
;
size = 3;
;
fr_allowDespawn = true;
;
on_death = fr_Areas_graveyard_area_gml_SnowPoff_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:900
function fr_Areas_graveyard_area_gml_SnowPoff_destroy() {
if ((scrFRSourceRandom(8) < 1)) {
{
repeat (4) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 12), 12)), (y + scrFRSourceRandomRange((- 12), 12)), Rad);
}
}
}
}

// Original Areas/graveyard.area.gml:908
function fr_Areas_graveyard_area_gml_BigPile_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BigPile";
;
var _frl__variant = scrFRSourceIRandom(1);
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprBigPile, _frl__variant);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprBigPileHurt, _frl__variant);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprBigPileDead, _frl__variant);
;
spr_debris = sprDebris6;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].mskBigPile, _frl__variant);
;
variant = _frl__variant;
;
scrFRMaxHealthWrite(id, 80, "=");
;
hp = max_hp;
;
size = 3;
;
on_hit = fr_Areas_graveyard_area_gml_PileProp_hurt;
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

// Original Areas/graveyard.area.gml:942
function fr_Areas_graveyard_area_gml_BigPileBossScrap_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BossScrap";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrap;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrapHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprBigPileBossScrapDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = global.fr_module_vars[$ "area:graveyard"].mskBigPileBossScrap;
scrFRMaxHealthWrite(id, 80, "=");
;
hp = max_hp;
;
size = 3;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:967
function fr_Areas_graveyard_area_gml_FloorVent_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_FloorVent";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprFloorVent;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprSnowPoffHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprSnowPoffDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
scrFRMaxHealthWrite(id, 30, "=");
;
hp = max_hp;
;
size = 3;
;
fr_allowDespawn = true;
;
on_step = fr_Areas_graveyard_area_gml_FloorVent_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:994
function fr_Areas_graveyard_area_gml_FloorVent_step() {
var _frl__smokeDirection = (120 + (sin((scrFRSourceFrame() * 0.06)) * 20));
;
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - 8), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, scrFRSelf(self));
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = (_frl__smokeDirection + scrFRSourceRandomRange((- 20), 20));
;
speed = (1.5) * timescale;
;
depth = (- 7);
;
growspeed = 0.14;
;
friction = ((- 0.2)) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Areas/graveyard.area.gml:1008
function fr_Areas_graveyard_area_gml_Furnace_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_Furnace";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprFurnace;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprFurnaceHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprFurnaceDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 3;
;
fr_allowDespawn = true;
;
on_step = fr_Areas_graveyard_area_gml_Furnace_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1035
function fr_Areas_graveyard_area_gml_Furnace_step() {
var _frl__smokeDirection = (120 + (sin((scrFRSourceFrame() * 0.06)) * 20));
;
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + (7 * image_xscale)), (y - 8), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, scrFRSelf(self));
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = (_frl__smokeDirection + scrFRSourceRandomRange((- 20), 20));
;
speed = (1.5) * timescale;
;
depth = (- 7);
;
growspeed = 0.14;
;
friction = ((- 0.2)) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Areas/graveyard.area.gml:1049
function fr_Areas_graveyard_area_gml_Furnace2_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_Furnace2";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprFurnace2;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprFurnace2Hurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprFurnace2Dead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 3;
;
fr_allowDespawn = true;
;
on_step = fr_Areas_graveyard_area_gml_Furnace2_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1076
function fr_Areas_graveyard_area_gml_Furnace2_step() {
var _frl__smokeDirection = (120 + (sin((scrFRSourceFrame() * 0.06)) * 20));
;
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x - (6 * image_xscale)), (y - 8), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, scrFRSelf(self));
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = (_frl__smokeDirection + scrFRSourceRandomRange((- 20), 20));
;
speed = (1.5) * timescale;
;
depth = (- 7);
;
growspeed = 0.14;
;
friction = ((- 0.2)) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Areas/graveyard.area.gml:1090
function fr_Areas_graveyard_area_gml_VariaThundershockPile_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_VariaThundershockPile";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPile;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPileHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprVariaThundershockPileDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
depth = (- 1);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndServerBreak;
;
mask_index = global.fr_module_vars[$ "area:graveyard"].mskVariaThundershockPile;
;
scrFRMaxHealthWrite(id, 50, "=");
;
hp = max_hp;
;
size = 3;
;
myWeapon = "va_thundershock";
on_death = fr_Areas_graveyard_area_gml_VariaThundershockPile_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1119
function fr_Areas_graveyard_area_gml_VariaThundershockPile_destroy() {
global.fr_module_vars[$ "area:graveyard"].VariaThundershockBroken = true;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", __fr_other4.myWeapon);
;
curse = 1;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1126
function fr_Areas_graveyard_area_gml_VolterPump_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_VolterPump";
;
spr_idle = global.fr_module_vars[$ "area:graveyard"].sprVolterPump;
;
spr_hurt = global.fr_module_vars[$ "area:graveyard"].sprVolterPumpHurt;
;
spr_dead = global.fr_module_vars[$ "area:graveyard"].sprVolterPumpDead;
;
spr_shadow = (- 1);
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
depth = (- 1);
;
fr_glow = [32, 64];
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
size = 2;
;
fr_allowDespawn = true;
;
on_step = fr_Areas_graveyard_area_gml_VolterPump_step;
;
on_death = fr_Areas_graveyard_area_gml_VolterPump_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1157
function fr_Areas_graveyard_area_gml_VolterPump_step() {
var _frl__smokeDirection = (120 + (sin((scrFRSourceFrame() * 0.06)) * 20));
;
if ((scrFRSourceRandom(30) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - 16), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(global.fr_module_vars[$ "area:graveyard"].fr_smoke_array, scrFRSelf(self));
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistDust);
;
image_alpha = 1;
;
direction = (_frl__smokeDirection + scrFRSourceRandomRange((- 20), 20));
;
speed = (1.5) * timescale;
;
depth = (- 7);
;
growspeed = 0.04;
;
friction = ((- 0.2)) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(25) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 12), 6)), BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "area:graveyard"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break6) break;
}}
}
}
}

// Original Areas/graveyard.area.gml:1180
function fr_Areas_graveyard_area_gml_VolterPump_destroy() {
repeat ((1 + scrFRSourceIRandom(1))) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "Voltergeist_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(5)), "=");
;
armorLock = 5;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Areas/graveyard.area.gml:1190
function fr_Areas_graveyard_area_gml_HunterMusicPlayer_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_graveyardHunterMusic";
;
on_step = fr_Areas_graveyard_area_gml_HunterMusicPlayer_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/graveyard.area.gml:1200
function fr_Areas_graveyard_area_gml_HunterMusicPlayer_step() {
if ((array_length(scrFRMatching(LilHunter, "intro", true)) > 0)) {
{
if ((! audio_is_playing(musBoss3))) {
{
scrFRSoundMusic(musBoss3);
}
}
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/graveyard.area.gml:1209
function fr_Areas_graveyard_area_gml_PileProp_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
hp -= _frl__dmg;
;
nexthurt = (scrFRSourceFrame() + 6);
;
scrFRSoundHit(snd_hurt, 0.3);
;
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
repeat (scrFRSourceIRandom(debrisRange)) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(spr_debris);
;
image_index = scrFRSourceIRandom(image_number);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Areas/graveyard.area.gml:1227
function fr_Areas_graveyard_area_gml_PileWeaponDrop_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", __fr_other4.myWeapon);
;
if ((scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) != 0)) {
{
ammo = 1;
;
}
}
}
}
if(__fr_break3) break;
}}
}
