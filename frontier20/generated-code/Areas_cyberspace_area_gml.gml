#macro frMacro_Areas_cyberspace_area_gml_scr global.fr_module_vars[$ "area:cyberspace"].scr

#macro frMacro_Areas_cyberspace_area_gml_call scrFRScriptCall

#macro frMacro_Areas_cyberspace_area_gml__tespr scrFRModGet("mod", "teassets", "spr")

#macro frMacro_Areas_cyberspace_area_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Areas_cyberspace_area_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

// Original Areas/cyberspace.area.gml:1
function fr_Areas_cyberspace_area_gml___load() {

}

// Original Areas/cyberspace.area.gml:1
function fr_Areas_cyberspace_area_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_cyberspace_area_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Areas_cyberspace_area_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_cyberspace_area_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/cyberspace.area.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "area", "cyberspace", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "area:cyberspace"].settingCyberspaceEnabled = true;
;
global.fr_module_vars[$ "area:cyberspace"].ambCyberspace = sndFR_ambCyberspace_d10d45e043f3;
;
global.fr_module_vars[$ "area:cyberspace"].sndSmileHurt = sndFR_sndSmileHurt_bea6da52ce27;
;
global.fr_module_vars[$ "area:cyberspace"].sndCyberspaceEnemyDead = sndFR_sndCyberspaceEnemyDead_76fe776685ce;
;
global.fr_module_vars[$ "area:cyberspace"].sndCyberspaceEnemySpawn = sndFR_sndCyberspaceEnemySpawn_9d7c55bb9c8a;
;
global.fr_module_vars[$ "area:cyberspace"].sndProcessorStart = sndFR_sndProcessorStart_58870567c0d9;
;
global.fr_module_vars[$ "area:cyberspace"].sndProcessorComplete = sndFR_sndProcessorComplete_b07662641294;
;
global.fr_module_vars[$ "area:cyberspace"].sndBlank = sndFR_sndBlank_7a95d727acba;
;
global.fr_module_vars[$ "area:cyberspace"].sprFloor = sprFR_sprFloorCyberspace_cc91529f6569;
;
global.fr_module_vars[$ "area:cyberspace"].sprFloorB = sprFR_sprFloorCyberspaceB_386193951ba1;
;
global.fr_module_vars[$ "area:cyberspace"].sprFloorExplo = sprFR_sprFloorCyberspaceExplo_b0306652f80d;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallBot = sprFR_sprWallCyberspaceBot_707d0851298c;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallTop = sprFR_sprWallCyberspaceTop_104af4931a87;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallOut = sprFR_sprWallCyberspaceOut_966dd91ea983;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallTrans = sprFR_sprWallCyberspaceTrans_6e539cba812a;
;
global.fr_module_vars[$ "area:cyberspace"].sprDebris = sprFR_sprDebrisCyberspace_9695309b95c3;
;
global.fr_module_vars[$ "area:cyberspace"].sprDetail = sprFR_sprDetailCyberspace_cb608444f1b5;
;
global.fr_module_vars[$ "area:cyberspace"].sprSpiralCyberspace = sprFR_sprSpiralCyberspace_70ed46188465;
;
global.fr_module_vars[$ "area:cyberspace"].sprSpiralDebrisCyberspace = sprFR_sprSpiralDebrisCyberspac_d5253c88a023;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallBlob = sprFR_sprCyberspaceWallBlob_01f8a51174da;
;
global.fr_module_vars[$ "area:cyberspace"].sprWallBlob2 = sprFR_sprCyberspaceWallBlob2_845b57e99c2a;
;
global.fr_module_vars[$ "area:cyberspace"].sprBlueZone = sprFR_sprBlueZone_b47538fcd917;
;
global.fr_module_vars[$ "area:cyberspace"].areaBackgroundPos = 0;
;
global.fr_module_vars[$ "area:cyberspace"].sprSmile = sprFR_sprSmile_db8ac3ffbb2e;
;
global.fr_module_vars[$ "area:cyberspace"].smileIndex = 0;
;
global.fr_module_vars[$ "area:cyberspace"].sprSmileDead = sprFR_sprSmileDead_a0e038519295;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyTrail = sprFR_sprCyberspaceEnemyTrail_a85693d5c37d;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyDie = sprFR_sprCyberspaceEnemyDie_83b989fcb80c;
;
global.fr_module_vars[$ "area:cyberspace"].sprProcessorIdle = sprFR_sprProcessorIdle_e66191a6c129;
;
global.fr_module_vars[$ "area:cyberspace"].sprProcessorGood = sprFR_sprProcessorGood_a241995d60ea;
;
global.fr_module_vars[$ "area:cyberspace"].sprProcessorSpark = sprFR_sprProcessorSpark_fda835448990;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotIdle = sprFR_sprCyberspaceRobotIdle_4b53369b0be6;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotWalk = sprFR_sprCyberspaceRobotWalk_f16bf1206635;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotHurt = sprFR_sprCyberspaceRobotHurt_196c4bb8f218;
;
global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotDead = sprFR_sprCyberspaceRobotDead_e5ee86ded49b;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackground = sprFR_sprBluescreenBackground_1be5e71fbab9;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundDeny = sprFR_sprBluescreenBackgroundD_c85b77c5acd6;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundExt = sprFR_sprBluescreenBackgroundE_a2abace1097e;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundBar = sprFR_sprBluescreenBackgroundB_5ac1b8f796b2;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundSearch = sprFR_sprBluescreenBackgroundS_454c497651c6;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundReboot = sprFR_sprBluescreenBackgroundR_c8ce3f84411e;
;
global.fr_module_vars[$ "area:cyberspace"].mskBluescreenButton = sprFR_mskBluescreenButton_09df0919d91e;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenButtonYes = sprFR_sprBluescreenButtonYes_2c422d4d9370;
;
global.fr_module_vars[$ "area:cyberspace"].sprBluescreenButtonNo = sprFR_sprBluescreenButtonNo_929c90574849;
;
global.fr_module_vars[$ "area:cyberspace"].prevIdle = [];
;
global.fr_module_vars[$ "area:cyberspace"].prevWalk = [];
;
global.fr_module_vars[$ "area:cyberspace"].prevHurt = [];
;
global.fr_module_vars[$ "area:cyberspace"].prevDead = [];
;
global.fr_module_vars[$ "area:cyberspace"].reskinMe = false;
;
fr_Areas_cyberspace_area_gml_Processor_buildpools();
;
scrFRLocSet("races:8:passive", scrFRLoc("Frontier:RobotPassive", "FINDS BETTER TECH#@bSYSTEM REBOOT@w"));
}
_fr.pc=0;
break;
case 3: // Areas/cyberspace.area.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Areas/cyberspace.area.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Areas/cyberspace.area.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/cyberspace.area.gml:81
function fr_Areas_cyberspace_area_gml_area_subarea() {
return 1;
;
}

// Original Areas/cyberspace.area.gml:82
function fr_Areas_cyberspace_area_gml_area_goal() {
return 220;
;
}

// Original Areas/cyberspace.area.gml:83
function fr_Areas_cyberspace_area_gml_area_next() {
return [GameCont.lastarea, 1];
;
}

// Original Areas/cyberspace.area.gml:84
function fr_Areas_cyberspace_area_gml_area_background_color() {
return make_color_rgb(65, 83, 124);
;
}

// Original Areas/cyberspace.area.gml:85
function fr_Areas_cyberspace_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/cyberspace.area.gml:86
function fr_Areas_cyberspace_area_gml_area_shadow_alpha() {
return 0;
;
}

// Original Areas/cyberspace.area.gml:87
function fr_Areas_cyberspace_area_gml_area_darkness() {
return false;
;
}

// Original Areas/cyberspace.area.gml:88
function fr_Areas_cyberspace_area_gml_area_secret() {
return true;
;
}

// Original Areas/cyberspace.area.gml:89
function fr_Areas_cyberspace_area_gml_area_outside() {
return true;
;
}

// Original Areas/cyberspace.area.gml:91
function fr_Areas_cyberspace_area_gml_area_name() {
return scrFRLocalize("!!!");
;
}

// Original Areas/cyberspace.area.gml:94
function fr_Areas_cyberspace_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("CONGRATULATIONS! YOU'VE WON!", "CONNECTION TERMINATED", "BLUER THAN THE SEA"));
;
}

// Original Areas/cyberspace.area.gml:103
function fr_Areas_cyberspace_area_gml_area_sprite(_frl__sprite=undefined) {
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
fr_Areas_cyberspace_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:cyberspace"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_cyberspace_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:cyberspace"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:cyberspace"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:cyberspace"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:cyberspace"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:cyberspace"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:cyberspace"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:cyberspace"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:cyberspace"].sprDetail;
;
}
}
}

// Original Areas/cyberspace.area.gml:116
function fr_Areas_cyberspace_area_gml_area_setup() {
{ var __fr_with1 = scrFRWithValues(SpiralCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
type = 1;
;
scrFRBindStep(fr_Areas_cyberspace_area_gml_area_spiral_step, 0, scrFRSelf(self));
repeat (16) {
{ var __fr_with4 = scrFRWithValues(fr_Areas_cyberspace_area_gml_CyberspaceSpiralDebris_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = scrFRSourceRandomRange(0.6, 1);
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(Player), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((race == scrFRRaceTryResolve("robot"))) {
{
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:cyberspace"], "prevIdle", [index], spr_idle, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:cyberspace"], "prevWalk", [index], spr_walk, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:cyberspace"], "prevHurt", [index], spr_hurt, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:cyberspace"], "prevDead", [index], spr_dead, "=");
;
spr_idle = global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotIdle;
;
spr_walk = global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotWalk;
;
spr_hurt = global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotHurt;
;
spr_dead = global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceRobotDead;
;
}
}
can_walk = true;
;
can_spec = true;
;
}
}
if(__fr_break9) break;
}}
global.fr_module_vars[$ "area:cyberspace"].reskinMe = true;
;
scrFRSoundMusic(global.fr_module_vars[$ "area:cyberspace"].sndBlank);
;
scrFRSoundAmbient(global.fr_module_vars[$ "area:cyberspace"].ambCyberspace);
;
goal = fr_Areas_cyberspace_area_gml_area_goal();
;
background_set_colour(fr_Areas_cyberspace_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_cyberspace_area_gml_area_shadow_color();
;
BackCont.shadalpha = fr_Areas_cyberspace_area_gml_area_shadow_alpha();
;
TopCont.darkness = fr_Areas_cyberspace_area_gml_area_darkness();
;
GameCont.noradch = 1;
;
safespawn = 1;
;
scrFRBindStep(fr_Areas_cyberspace_area_gml_area_step, 0);
;
scrFRBindDraw(fr_Areas_cyberspace_area_gml_area_background_draw, 30);
;
scrFRBindDraw(fr_Areas_cyberspace_area_gml_cyberspace_enemy_draw, (- 3));
;
scrFRSoundAssign(sndWallBreakRock, sndWallBreakLabs);
;
}

// Original Areas/cyberspace.area.gml:166
function fr_Areas_cyberspace_area_gml_area_spiral_step(_frl__spiral=undefined) {
if ((! scrFRInstanceExists(_frl__spiral))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(Spiral, "fr_spiralCont", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_spiralCont = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprSpiralCyberspace);
;
colors = [make_color_rgb(0, 33, 255), make_color_rgb(0, 33, 255)];
;
if ((scrFRSourceRandom(5) < 1)) {
{
fr_Areas_cyberspace_area_gml_CyberspaceSpiralDebris_create(x, y);
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:182
function fr_Areas_cyberspace_area_gml_CyberspaceSpiralDebris_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SpiralStar)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprSpiralDebrisCyberspace);
;
image_index = scrFRSourceIRandom(1);
;
image_angle = 0;
;
rotspeed = 0;
;
grow /= 2;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:193
function fr_Areas_cyberspace_area_gml_area_setup_floor() {
material = 3;
;
}

// Original Areas/cyberspace.area.gml:197
function fr_Areas_cyberspace_area_gml_area_start() {
scrFRInstanceCreate(10016, 10016, becomenemy);
scrFRInstanceCreate(10016, 10016, BigWeaponChest);
;
{ var __fr_with1 = scrFRWithValues(RadChest), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.save_set, "Frontier", "cyberspace_visits", (frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.save_get, "Frontier", "cyberspace_visits") + 1));
{ var __fr_with4 = scrFRWithValues(Detail), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
repeat (3) {
{ var __fr_with7 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.instance_random, scrFRMatching(frMacro_Areas_cyberspace_area_gml_FloorNormal, "fr_processor", undefined))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_Areas_cyberspace_area_gml_Processor_create((x + 16), (y + 16));
;
fr_processor = true;
;
scrFRInstanceCreate(x, y, PortalClear);
;
}
}
if(__fr_break9) break;
}}
}
{ var __fr_with10 = scrFRWithValues(Floor), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((distance_to_point(10016, 10016) > 96)) {
{
fr_cyberfar = true;
;
}
}
}
}
if(__fr_break12) break;
}}
repeat ((14 + (5 * GameCont.loops))) {
{ var __fr_with13 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.instance_random, scrFRMatching(Floor, "fr_cyberfar", true))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
fr_Areas_cyberspace_area_gml_Smile_create((x + 16), (y + 16));
;
fr_cyberfar = false;
;
scrFRInstanceCreate(x, y, PortalClear);
;
}
}
if(__fr_break15) break;
}}
}
if ((scrFRInstanceExists(WantPopo) || scrFRInstanceExists(WantVan))) {
{
{ var __fr_with16 = scrFRWithValues(WantPopo), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(WantVan), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break21) break;
}}
}
}
if (((scrFRInstanceExists(VanSpawn) || scrFRInstanceExists(IDPDSpawn)) || (array_length(scrFRMatching(FRCustomObject, "name", "IDPDPortal")) > 0))) {
{
{ var __fr_with22 = scrFRWithValues(IDPDSpawn), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(VanSpawn), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break30) break;
}}
scrFRSoundStop(sndIDPDPortalSpawn);
;
scrFRSoundStop(sndEliteIDPDPortalSpawn);
;
scrFRSoundStop(sndVanWarning);
;
}
}
}

// Original Areas/cyberspace.area.gml:260
function fr_Areas_cyberspace_area_gml_area_make_floor() {
var _frl__x = x;
var _frl__y = y;
var _frl__outOfSpawn = (point_distance(_frl__x, _frl__y, 10000, 10000) > 48);
;
scrFRInstanceCreate(_frl__x, _frl__y, Floor);
;
if ((scrFRSourceRandom(10) < 1)) {
{
fr_Areas_cyberspace_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
;
}
}
var _frl__turn = 0;
;
if ((scrFRSourceRandom(2) < 1)) {
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
}

// Original Areas/cyberspace.area.gml:299
function fr_Areas_cyberspace_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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

// Original Areas/cyberspace.area.gml:313
function fr_Areas_cyberspace_area_gml_area_pop_props() {

}

// Original Areas/cyberspace.area.gml:316
function fr_Areas_cyberspace_area_gml_area_finish() {
if ((subarea < fr_Areas_cyberspace_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_cyberspace_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
}

// Original Areas/cyberspace.area.gml:330
function fr_Areas_cyberspace_area_gml_area_transit() {
if ((global.fr_module_vars[$ "area:cyberspace"].reskinMe == true)) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((race == scrFRRaceTryResolve("robot"))) {
{
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].prevIdle, index);
;
spr_walk = scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].prevWalk, index);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].prevHurt, index);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].prevDead, index);
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
scrFRSoundRestore(sndWallBreakRock);
;
}

// Original Areas/cyberspace.area.gml:345
function fr_Areas_cyberspace_area_gml_area_step() {
global.fr_module_vars[$ "area:cyberspace"].areaBackgroundPos += scrFRSourceScale();
;
global.fr_module_vars[$ "area:cyberspace"].smileIndex = (scrFRSourceFrame() * 0.2);
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(TopSmall, "fr_cyberspace_blobIndex", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_cyberspace_blobIndex = scrFRSourceIRandom(14);
;
fr_cyberspace_blobRotation = scrFRSourceChoose(0, 90, 180, 270);
;
fr_cyberspace_blobScale = (1 + scrFRSourceRandom(0.2));
;
fr_cyberspace_blobRight = scrFRSourceChoose((- 1), 1);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatchingNE(enemy, "fr_processor", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- (sprite_width / 3)), (sprite_width / 3))), (y + scrFRSourceRandomRange((- (sprite_height / 3)), (sprite_height / 3))), CaveSparkle)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyTrail);
;
image_angle = scrFRSourceRandom(360);
;
direction = scrFRSourceRandom(360);
;
speed = ((0 + scrFRSourceRandom(2))) * timescale;
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
if ((scrFRInstanceExists(WantPopo) || scrFRInstanceExists(WantVan))) {
{
{ var __fr_with10 = scrFRWithValues(WantPopo), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(WantVan), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break15) break;
}}
}
}
if (((scrFRInstanceExists(VanSpawn) || scrFRInstanceExists(IDPDSpawn)) || (array_length(scrFRMatching(FRCustomObject, "name", "IDPDPortal")) > 0))) {
{
{ var __fr_with16 = scrFRWithValues(IDPDSpawn), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(VanSpawn), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break24) break;
}}
scrFRSoundStop(sndIDPDPortalSpawn);
;
scrFRSoundStop(sndEliteIDPDPortalSpawn);
;
scrFRSoundStop(sndVanWarning);
;
}
}
}

// Original Areas/cyberspace.area.gml:391
function fr_Areas_cyberspace_area_gml_area_background_draw() {
var _frl__backgroundPos = global.fr_module_vars[$ "area:cyberspace"].areaBackgroundPos;
;
draw_sprite_tiled(global.fr_module_vars[$ "area:cyberspace"].sprBlueZone, 0, x, (y + (_frl__backgroundPos * 6)));
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(TopSmall, "fr_cyberspace_blobIndex", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(global.fr_module_vars[$ "area:cyberspace"].sprWallBlob, ((scrFRSourceFrame() * 0.4) + fr_cyberspace_blobIndex), (x + 8), (y + 8), (fr_cyberspace_blobScale * fr_cyberspace_blobRight), (fr_cyberspace_blobScale * fr_cyberspace_blobRight), fr_cyberspace_blobRotation, c_white, 1);
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:400
function fr_Areas_cyberspace_area_gml_cyberspace_enemy_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(enemy, "fr_processor", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
gpu_set_fog(true, c_red, 0, 0);
;
draw_set_alpha(0.05);
;
draw_line_width(x, y, fr_processor.x, (fr_processor.y - 16), 2);
;
draw_set_alpha(1);
;
if ((nexthurt >= (scrFRSourceFrame() + 3))) {
{
gpu_set_fog(true, c_white, 0, 0);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, c_red, 1);
;
scrFRDrawSpriteExt(sprite_index, image_index, (x + scrFRSourceRandomRange((- 2), 2)), (y + scrFRSourceRandomRange((- 2), 2)), (image_xscale * right), image_yscale, image_angle, c_red, 1);
;
gpu_set_fog(false, 0, 0, 0);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRInstanceExists(Portal)) {
{
var _frl__portal = instance_nearest(x, y, Portal);
;
draw_set_alpha(0.2);
;
draw_line_width_color(x, y, _frl__portal.x, _frl__portal.y, 2, make_color_rgb(0, 33, 255), make_color_rgb(0, 33, 255));
;
draw_set_alpha(1);
;
}
} else {
{
if ((race != scrFRRaceTryResolve("robot"))) {
{
gpu_set_fog(true, make_color_rgb(0, 33, 255), 0, 0);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, angle, make_color_rgb(0, 33, 255), 1);
;
gpu_set_fog(false, c_white, 0, 0);
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

// Original Areas/cyberspace.area.gml:432
function fr_Areas_cyberspace_area_gml_Processor_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_robotprocessor";
;
spr_idle = global.fr_module_vars[$ "area:cyberspace"].sprProcessorIdle;
;
spr_good = global.fr_module_vars[$ "area:cyberspace"].sprProcessorGood;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
mytext = scrFRLocalize("REBOOT?");
depth = (- 1);
;
active = false;
;
enemyTime = 50;
;
enemiesSpawned = 0;
;
spawning = true;
;
availFloors = noone;
;
spawnPool = [[[Bandit, "BASEGAME", ""], 1]];
;
spawnCount = 1;
;
complete = false;
;
x = round(x);
;
y = round(y);
;
on_step = fr_Areas_cyberspace_area_gml_Processor_step;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Areas_cyberspace_area_gml_ProcessorPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
mask_index = mskBigMaggot;
;
}
}
if(__fr_break6) break;
}}
fr_Areas_cyberspace_area_gml_Processor_choosePool();
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:471
function fr_Areas_cyberspace_area_gml_Processor_step() {
if ((active == true)) {
{
if ((spawning == true)) {
{
if ((enemyTime <= 0)) {
{
if ((enemiesSpawned < spawnCount)) {
{
enemiesSpawned += 1;
;
enemyTime += (50 / spawnCount);
;
{ var __fr_with1 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.instance_random, availFloors)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
fr_Areas_cyberspace_area_gml_ProcessorEnemy_create((x + 16), (y + 16), __fr_other4, frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.pool, __fr_other4.spawnPool));
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
spawning = false;
;
}
}
}
} else {
{
enemyTime -= scrFRSourceScale();
;
}
}
}
} else {
{
if ((array_length(scrFRMatching(enemy, "fr_processor", scrFRSelf(self))) <= 0)) {
{
active = false;
;
sprite_index = scrFRAreaSourceSprite(spr_good);
;
image_speed = (0.4) * timescale;
;
complete = true;
;
repeat (12) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprProcessorSpark);
;
direction = scrFRSourceRandom(360);
;
image_angle = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(3))) * timescale;
;
friction = (0.3) * (timescale * timescale);
;
}
}
if(__fr_break7) break;
}}
}
repeat (3) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, AmmoPickup)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
;
}
}
if(__fr_break10) break;
}}
}
repeat (2) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, HPPickup)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
scrFRSoundPitch(global.fr_module_vars[$ "area:cyberspace"].sndProcessorComplete, (0.9 + scrFRSourceRandom(0.2)));
;
if ((array_length(scrFRMatching(scrFRMatching(FRCustomObject, "name", "fr_robotprocessor"), "complete", false)) <= 0)) {
{
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, Portal)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
type = 3;
;
}
}
if(__fr_break16) break;
}}
{ var __fr_with17 = scrFRWithValues(scrFRMatching(enemy, "name", "Smile")), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
{ var __fr_with20 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprSmileDead);
;
}
}
if(__fr_break22) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break19) break;
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

// Original Areas/cyberspace.area.gml:537
function fr_Areas_cyberspace_area_gml_ProcessorPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_speed = (0.8) * timescale;
;
active = true;
;
var _frl__range = 128;
;
availFloors = frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.instances_in_rectangle, (x - _frl__range), (y - _frl__range), (x + _frl__range), (y + _frl__range), frMacro_Areas_cyberspace_area_gml_FloorNormal);
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPlay(global.fr_module_vars[$ "area:cyberspace"].sndProcessorStart);
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/cyberspace.area.gml:551
function fr_Areas_cyberspace_area_gml_Processor_buildpools() {
global.fr_module_vars[$ "area:cyberspace"].spawnPools = [];
global.fr_module_vars[$ "area:cyberspace"].spawnPoolNames = ds_list_create();
;
global.fr_module_vars[$ "area:cyberspace"].knownPoolAddons = [];
;
global.fr_module_vars[$ "area:cyberspace"].allowPoolPushing = true;
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("DESERT", 0, 9, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("DESERT", [Bandit, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("DESERT", [Scorpion, "BASEGAME", ""], 0.7);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("DESERT", [MeleeBandit, "BASEGAME", ""], 0.4);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("SEWERS", 0, 12, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", [Rat, "BASEGAME", ""], 2.2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", [Gator, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", [BuffGator, "BASEGAME", ""], 0.2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", [Exploder, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("SCRAPYARD", 3, 9, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SCRAPYARD", [Sniper, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SCRAPYARD", [MeleeBandit, "BASEGAME", ""], 0.6);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SCRAPYARD", [Salamander, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SCRAPYARD", [Exploder, "BASEGAME", ""], 0.1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("CRYSTAL CAVES", 6, 12, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("CRYSTAL CAVES", [Spider, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("CRYSTAL CAVES", [LaserCrystal, "BASEGAME", ""], 0.6);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("CRYSTAL CAVES", [Gator, "BASEGAME", ""], 0.1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("FROZEN CITY", 7, 9, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("FROZEN CITY", [SnowBot, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("FROZEN CITY", [Wolf, "BASEGAME", ""], 0.6);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("LABS", 10, 18, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LABS", [Freak, "BASEGAME", ""], 2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LABS", [RhinoFreak, "BASEGAME", ""], 0.4);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LABS", [ExploFreak, "BASEGAME", ""], 0.2);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("PALACE", 11, 7, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("PALACE", [Guardian, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("PALACE", [ExploGuardian, "BASEGAME", ""], 0.1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("OASIS", 5, 15, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("OASIS", [BoneFish, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("OASIS", [Crab, "BASEGAME", ""], 0.1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("MANSION", 7, 12, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("MANSION", [Molesarge, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("MANSION", [FireBaller, "BASEGAME", ""], 0.4);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("MANSION", [Jock, "BASEGAME", ""], 0.3);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("JUNGLE", 10, 10, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("JUNGLE", [JungleBandit, "BASEGAME", ""], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("JUNGLE", [JungleAssassin, "BASEGAME", ""], 0.1);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("ROBOCENTER", 11, 15, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("ROBOCENTER", ["Swarmbot_create", "MOD", "Frontier_Labs"], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("ROBOCENTER", ["MissileDrone", "MOD", "Frontier_Labs"], 0.1);
;
}

// Original Areas/cyberspace.area.gml:612
function fr_Areas_cyberspace_area_gml_Processor_compat_additions() {
if ((global.fr_module_vars[$ "area:cyberspace"].allowPoolPushing == true)) {
{
if (scrFRModLoaded("mod", "undergrowth")) {
{
if ((scrFRArrayFindIndex(global.fr_module_vars[$ "area:cyberspace"].knownPoolAddons, "Undergrowth") == (- 1))) {
{
array_push(global.fr_module_vars[$ "area:cyberspace"].knownPoolAddons, "Undergrowth");
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("UNDERGROWTH", 7, 12, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("UNDERGROWTH", ["Firefly", "OBJ", ["area", "undergrowth"]], 2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("UNDERGROWTH", ["PitcherPlant", "OBJ", ["area", "undergrowth"]], 1);
;
}
}
}
}
if (scrFRModLoaded("mod", "ntte")) {
{
if ((scrFRArrayFindIndex(global.fr_module_vars[$ "area:cyberspace"].knownPoolAddons, "NTTE") == (- 1))) {
{
array_push(global.fr_module_vars[$ "area:cyberspace"].knownPoolAddons, "NTTE");
scrFRTrace("PUSHTE");
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("COAST", 6, 10, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("COAST", ["Gull", "OBJ", ["mod", "telib"]], 2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("COAST", ["TrafficCrab", "OBJ", ["mod", "telib"]], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("COAST", ["Pelican", "OBJ", ["mod", "telib"]], 0.4);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("COAST", ["Diver", "OBJ", ["mod", "telib"]], 0.8);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("LAIR", 6, 13, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LAIR", [Rat, "BASEGAME", ""], 1.4);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LAIR", ["Cat", "OBJ", ["mod", "telib"]], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("LAIR", ["Bat", "OBJ", ["mod", "telib"]], 0.6);
;
fr_Areas_cyberspace_area_gml_Processor_create_spawnpool("TRENCH", 8, 8, 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("TRENCH", ["Jelly", "OBJ", ["mod", "telib"]], 1);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("DESERT", ["BabyScorpion", "OBJ", ["mod", "telib"]], 0.3);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", ["BabyGator", "OBJ", ["mod", "telib"]], 0.4);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("SEWERS", ["AlbinoGator", "OBJ", ["mod", "telib"]], 0.05);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("OASIS", ["Puffer", "OBJ", ["mod", "telib"]], 0.2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("OASIS", ["HammerShark", "OBJ", ["mod", "telib"]], 0.07);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("CRYSTAL CAVES", ["CrystalBat", "OBJ", ["mod", "telib"]], 0.2);
;
fr_Areas_cyberspace_area_gml_Processor_spawnpool_add("CRYSTAL CAVES", ["Mortar", "OBJ", ["mod", "telib"]], 0.2);
;
}
}
}
}
}
}
}

// Original Areas/cyberspace.area.gml:660
function fr_Areas_cyberspace_area_gml_Processor_create_spawnpool(_frl__name=undefined, _frl__difficulty=undefined, _frl__baseSpawnCount=undefined, _frl__weight=undefined) {
ds_list_add(global.fr_module_vars[$ "area:cyberspace"].spawnPoolNames, _frl__name);
;
array_push(global.fr_module_vars[$ "area:cyberspace"].spawnPools, [[], _frl__difficulty, _frl__baseSpawnCount, _frl__weight, _frl__name]);
}

// Original Areas/cyberspace.area.gml:663
function fr_Areas_cyberspace_area_gml_Processor_spawnpool_add(_frl__pool=undefined, _frl__enemyArray=undefined, _frl__weight=undefined) {
var _frl__poolNum = ds_list_find_index(global.fr_module_vars[$ "area:cyberspace"].spawnPoolNames, _frl__pool);
;
array_push(scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].spawnPools, _frl__poolNum), 0), [_frl__enemyArray, _frl__weight]);
;
}

// Original Areas/cyberspace.area.gml:667
function fr_Areas_cyberspace_area_gml_Processor_choosePool() {
var _frl__spawnMultiplier = (1 + GameCont.loops);
;
var _frl__validPools = [];
var _frl__index = 0;
;
repeat (array_length(global.fr_module_vars[$ "area:cyberspace"].spawnPools)) {
var _frl__array = scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].spawnPools, _frl__index);
;
var _frl__difficulty = scrFRIndexGet(scrFRIndexGet(global.fr_module_vars[$ "area:cyberspace"].spawnPools, _frl__index), 1);
if ((GameCont.hard >= _frl__difficulty)) {
{
array_push(_frl__validPools, [[scrFRIndexGet(_frl__array, 0), scrFRIndexGet(_frl__array, 2)], scrFRIndexGet(_frl__array, 3)]);
}
}
_frl__index += 1;
}
var _frl__chosenPool = frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.pool, _frl__validPools);
;
spawnPool = scrFRIndexGet(_frl__chosenPool, 0);
;
spawnCount = (scrFRIndexGet(_frl__chosenPool, 1) * _frl__spawnMultiplier);
;
}

// Original Areas/cyberspace.area.gml:687
function fr_Areas_cyberspace_area_gml_ProcessorEnemy_create(_frl__x=undefined, _frl__y=undefined, _frl__processor=undefined, _frl__object=undefined) {
{ var __fr_switch_value1=scrFRIndexGet(_frl__object, 1), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("BASEGAME")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("MOD")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("OBJ")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, scrFRIndexGet(_frl__object, 0))), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
fr_Areas_cyberspace_area_gml_ProcessorEnemy_spawnEffect(_frl__processor);
;
}
}
if(__fr_break5) break;
}}
}
break;
;
case 1:
{
{ var __fr_with6 = scrFRWithValues(scrFRModCall("mod", scrFRIndexGet(_frl__object, 2), scrFRIndexGet(_frl__object, 0), _frl__x, _frl__y)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
fr_Areas_cyberspace_area_gml_ProcessorEnemy_spawnEffect(_frl__processor);
;
}
}
if(__fr_break8) break;
}}
}
break;
;
case 2:
{
{ var __fr_with9 = scrFRWithValues(scrFRModCall(scrFRIndexGet(scrFRIndexGet(_frl__object, 2), 0), scrFRIndexGet(scrFRIndexGet(_frl__object, 2), 1), "obj_create", _frl__x, _frl__y, scrFRIndexGet(_frl__object, 0))), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
fr_Areas_cyberspace_area_gml_ProcessorEnemy_spawnEffect(_frl__processor);
;
}
}
if(__fr_break11) break;
}}
}
break;
;
}
}
}

// Original Areas/cyberspace.area.gml:709
function fr_Areas_cyberspace_area_gml_ProcessorEnemy_spawnEffect(_frl__processor=undefined) {
scrFRSoundPitch(global.fr_module_vars[$ "area:cyberspace"].sndCyberspaceEnemySpawn, (1.1 + scrFRSourceRandom(0.4)));
fr_processor = _frl__processor;
;
depth = (- 1);
;
spr_dead = global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyDie;
;
snd_dead = global.fr_module_vars[$ "area:cyberspace"].sndCyberspaceEnemyDead;
;
raddrop = 0;
;
givekill = 0;
;
hitid = [global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyDie, "MALWARE"];
;
repeat (9) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- (sprite_width / 3)), (sprite_width / 3))), (y + scrFRSourceRandomRange((- (sprite_height / 3)), (sprite_height / 3))), CaveSparkle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprCyberspaceEnemyTrail);
;
image_angle = scrFRSourceRandom(360);
;
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
return scrFRSelf(self);
;
}

// Original Areas/cyberspace.area.gml:731
function fr_Areas_cyberspace_area_gml_Smile_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Smile";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprSmile);
;
spr_idle = sprite_index;
;
spr_walk = sprite_index;
;
spr_hurt = sprite_index;
;
spr_dead = global.fr_module_vars[$ "area:cyberspace"].sprSmileDead;
;
;
hitid = [sprite_index, "YOU STUPID"];
depth = (- 2);
;
mask_index = mskPlasma;
;
direction = scrFRSourceRandom(360);
;
smileSpeed = 3;
;
givekill = 0;
;
canmelee = true;
;
meleedamage = 1;
;
hp = (1 / 0);
;
smileCooldown = 10;
;
smilesMade = 0;
;
smilesMax = 1;
;
corpse = false;
;
size = 3;
;
snd_hurt = global.fr_module_vars[$ "area:cyberspace"].sndSmileHurt;
;
snd_mele = global.fr_module_vars[$ "area:cyberspace"].sndSmileHurt;
;
on_step = fr_Areas_cyberspace_area_gml_Smile_step;
;
on_hurt = fr_Areas_cyberspace_area_gml_Smile_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:766
function fr_Areas_cyberspace_area_gml_Smile_step() {
speed = (smileSpeed) * timescale;
;
smileCooldown -= scrFRSourceScale();
;
image_index = global.fr_module_vars[$ "area:cyberspace"].smileIndex;
;
if ((scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall) || scrFRPlaceMeeting((x + hspeed), (y + vspeed), InvisiWall))) {
{
direction += (180 + scrFRSourceRandomRange((- 45), 45));
;
}
}
}

// Original Areas/cyberspace.area.gml:777
function fr_Areas_cyberspace_area_gml_Smile_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
if ((smilesMade < smilesMax)) {
{
if ((smileCooldown <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Areas_cyberspace_area_gml_Smile_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
smilesMax = (__fr_other4.smilesMax - 1);
;
}
}
if(__fr_break3) break;
}}
smileCooldown = 40;
;
smilesMade += 1;
;
}
}
}
}
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionAdd(_frl__dir, _frl__spd);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Areas/cyberspace.area.gml:794
function fr_Areas_cyberspace_area_gml_cyberspace_revive(_frl__index=undefined) {
if (((global.fr_module_vars[$ "area:cyberspace"].settingCyberspaceEnabled == true) && (GameCont.fr_visitedCyberspace == false))) {
{
var _frl__externalRevives = 0;
;
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomHitme, "name", "NTTEPet")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((pet == "Cuz") && (leader_index == _frl__index))) {
{
_frl__externalRevives += 1;
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
if ((_frl__externalRevives == 0)) {
{
GameCont.fr_visitedCyberspace = true;
;
fr_Areas_cyberspace_area_gml_robot_bluescreen(_frl__index);
;
scrFRSoundMusic(global.fr_module_vars[$ "area:cyberspace"].sndBlank);
;
scrFRSoundAmbient(global.fr_module_vars[$ "area:cyberspace"].sndBlank);
;
var _frl__newSeed = scrFRIndexGet(scrFRPlayerCompatSeedField("gameseed"), ((max(0, scrFRPlayerCompatSeedField("atseed")) + scrFRSourceIRandom(4)) % array_length(scrFRPlayerCompatSeedField("gameseed"))));
;
{ var __fr_with4 = scrFRWithValues(GameCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__lastSeed = {};
;
{ var __fr_with7 = scrFRWithValues(["mutseed", "junseed", "patseed", "codseed"]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var _frl__seed = scrFRVariableGet((scrFROther(other)), scrFRSelf(self));
;
scrFRLQSet(_frl__lastSeed, scrFRSelf(self), (is_array(_frl__seed) ? scrFRArrayClone(_frl__seed) : _frl__seed));
;
}
}
if(__fr_break9) break;
}}
scrFRGameSetSeed(_frl__newSeed);
;
{
var _frl_i = 0;
for (; (_frl_i < scrFRLQSize(_frl__lastSeed)); _frl_i++) {
scrFRVariableSet(scrFRSelf(self), scrFRLQKey(_frl__lastSeed, _frl_i), scrFRLQValue(_frl__lastSeed, _frl_i));
;
}
}
}
}
if(__fr_break6) break;
}}
if ((scrFRPlayerIsActive(_frl__index) && (! GameCont.win))) {
{
{ var __fr_with10 = scrFRWithValues(Portal), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(enemy), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(becomenemy), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(projectile), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(Trap), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break24) break;
}}
scrFRSoundStop(sndSalamanderFireLoop);
;
scrFRSoundStop(sndFiretrap);
;
{ var __fr_with25 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsFinaleController")), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break27) break;
}}
scrFRModSet("area", "deeplabs", "esploded", true);
;
{ var __fr_with28 = scrFRWithValues(scrFRMatching([FRCustomObject, FR_OBJECT_EFFECT], "fr_coreDetoKill", true)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break30) break;
}}
scrFRInstanceCreate(10016, 10016, becomenemy);
;
fr_Areas_cyberspace_area_gml_respawnProtector_create(10016, 10016);
;
{ var __fr_with31 = scrFRWithValues(scrFRInstanceCreate(x, y, Revive)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
p = _frl__index;
;
index = _frl__index;
;
canrevive = true;
;
{ var __fr_with34 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomHitme)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
{ var __fr_with37 = scrFRWithValues((scrFROther(other))), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
scrFRCyberspaceReviveEvent(ev_collision, Player);
;
}
}
if(__fr_break39) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break36) break;
}}
{ var __fr_with40 = scrFRWithValues(scrFRSelf(self)), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
scrFRCyberspaceReviveEvent(ev_alarm, 0);
;
}
}
if(__fr_break42) break;
}}
}
}
if(__fr_break33) break;
}}
{ var __fr_with43 = scrFRWithValues(scrFRPlayerFind(_frl__index)), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
scrFRSoundStop(snd_hurt);
;
nexthurt = (scrFRSourceFrame() + 30);
;
spiriteffect = 6;
;
can_walk = false;
;
can_spec = false;
;
if ((scrFRGetSkill(mut_strong_spirit) > 0)) {
{
can_spirit = false;
;
scrFRMemberIndexWrite(GameCont, "canspirit", [index], true, "=");
;
}
}
}
}
if(__fr_break45) break;
}}
{ var __fr_with46 = scrFRWithValues(scrFRMatching(WepPickup, "ammo", 0)), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
ammo = 1;
;
}
}
if(__fr_break48) break;
}}
{ var __fr_with49 = scrFRWithValues(CrownObject), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
persistent = true;
;
}
}
if(__fr_break51) break;
}}
{ var __fr_with52 = scrFRWithValues(scrFRMatchingLT(Portal, "endgame", 0)), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
{
endgame = 100;
;
if (scrFRInstanceIs(scrFRSelf(self), BigPortal)) {
{
sprite_index = scrFRAreaSourceSprite(sprBigPortal);
;
}
} else {
{ var __fr_switch_value55=type, __fr_switch_case56=-1;
if(__fr_switch_case56==-1 && __fr_switch_value55==(1)) __fr_switch_case56=0;
if(__fr_switch_case56==-1 && __fr_switch_value55==(2)) __fr_switch_case56=1;
if(__fr_switch_case56==-1 && __fr_switch_value55==(3)) __fr_switch_case56=2;
if(__fr_switch_case56==-1) __fr_switch_case56=-1;
switch(__fr_switch_case56) {
case 0:
sprite_index = scrFRAreaSourceSprite(sprPortal);
;
break;
;
case 1:
sprite_index = scrFRAreaSourceSprite(sprProtoPortal);
;
break;
;
case 2:
sprite_index = scrFRAreaSourceSprite(sprPopoPortal);
;
break;
;
}
}
}
}
}
if(__fr_break54) break;
}}
{ var __fr_with57 = scrFRWithValues(scrFRMatching(Revive, "p", _frl__index)), __fr_break59=false;
for (var __fr_index58=0; __fr_index58<array_length(__fr_with57); ++__fr_index58) {
if(scrFRScopeExists(__fr_with57[__fr_index58])) with (__fr_with57[__fr_index58]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break59) break;
}}
{ var __fr_with60 = scrFRWithValues(FR_OBJECT_UI_BUTTON), __fr_break62=false;
for (var __fr_index61=0; __fr_index61<array_length(__fr_with60); ++__fr_index61) {
if(scrFRScopeExists(__fr_with60[__fr_index61])) with (__fr_with60[__fr_index61]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break62) break;
}}
{ var __fr_with63 = scrFRWithValues(UnlockScreen), __fr_break65=false;
for (var __fr_index64=0; __fr_index64<array_length(__fr_with63); ++__fr_index64) {
if(scrFRScopeExists(__fr_with63[__fr_index64])) with (__fr_with63[__fr_index64]) {
{
scrFRAlarmWrite(scrFRSelf(self), 0, (- 1));
;
}
}
if(__fr_break65) break;
}}
scrFRLetterbox(false);
;
}
}
}
}
}
}
}

// Original Areas/cyberspace.area.gml:962
function fr_Areas_cyberspace_area_gml_respawnProtector_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_cyberspaceRespawnProtector";
on_step = fr_Areas_cyberspace_area_gml_respawnProtector_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:971
function fr_Areas_cyberspace_area_gml_respawnProtector_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
hp = max_hp;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:976
function fr_Areas_cyberspace_area_gml_robot_bluescreen(_frl__index=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Areas_cyberspace_area_gml_BluescreenController_create(10016, 10016)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
var __fr_other4=scrFROther(other);
scrFRViewSet("object", global.index, __fr_other4, "=");
;
scrFRViewSet("pan", global.index, 9999, "=");
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:984
function fr_Areas_cyberspace_area_gml_BluescreenController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_bluescreenController";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundExt);
;
image_xscale = 10000;
;
image_yscale = 10000;
;
depth = (- 20);
;
barHeight = 10;
;
blueTime = 0;
;
blueChecks = 0;
;
drawDots = true;
;
drawConnect = false;
;
on_draw = fr_Areas_cyberspace_area_gml_bluescreen_draw;
;
on_step = fr_Areas_cyberspace_area_gml_bluescreen_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:1009
function fr_Areas_cyberspace_area_gml_bluescreen_step() {
blueTime += scrFRSourceScale();
;
if (((blueTime >= 30) && (blueChecks == 0))) {
{
scrFRSoundPitch(sndNoSelect, 1.1);
;
barHeight -= 10;
;
blueChecks += 1;
;
}
}
if (((blueTime >= 80) && (blueChecks == 1))) {
{
scrFRSoundPitch(sndMutant8LowH, 0.8);
;
drawDots = false;
;
barHeight -= 12;
;
blueChecks += 1;
;
}
}
if (((blueTime >= 100) && (blueChecks == 2))) {
{
scrFRSoundPitch(sndNoSelect, 1.1);
;
barHeight -= 24;
;
blueChecks += 1;
;
}
}
if (((blueTime >= 115) && (blueChecks == 3))) {
{
scrFRSoundPitch(sndNoSelect, 1.2);
;
var __fr_other1=scrFROther(other);
fr_Areas_cyberspace_area_gml_BluescreenButton_create((x - 87), (y + 51), __fr_other1, global.fr_module_vars[$ "area:cyberspace"].sprBluescreenButtonYes, true);
;
var __fr_other2=scrFROther(other);
fr_Areas_cyberspace_area_gml_BluescreenButton_create((x - 16), (y + 51), __fr_other2, global.fr_module_vars[$ "area:cyberspace"].sprBluescreenButtonNo, false);
;
barHeight -= 80;
;
blueChecks += 1;
;
}
}
}

// Original Areas/cyberspace.area.gml:1035
function fr_Areas_cyberspace_area_gml_bluescreen_draw() {
if (scrFRInstanceExists(Player)) {
{
draw_sprite_tiled(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundExt, 0, scrFRViewCoordinate(0), scrFRViewCoordinate(1));
;
scrFRDrawSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackground, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)));
;
if ((drawDots == true)) {
{
scrFRDrawSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundSearch, (scrFRSourceFrame() * 0.2), ((scrFRViewCoordinate(0) + (view_width / 2)) + 106), ((scrFRViewCoordinate(1) + (view_height / 2)) - 2));
;
}
}
draw_sprite_stretched(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundBar, 0, ((scrFRViewCoordinate(0) + (view_width / 2)) - 160), ((scrFRViewCoordinate(1) + (view_height / 2)) - barHeight), 320, 200);
;
if ((drawConnect == true)) {
{
scrFRDrawSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundReboot, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)));
;
scrFRDrawSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundSearch, (scrFRSourceFrame() * 0.2), ((scrFRViewCoordinate(0) + (view_width / 2)) + 81), ((scrFRViewCoordinate(1) + (view_height / 2)) + 2));
;
}
}
}
}
}

// Original Areas/cyberspace.area.gml:1049
function fr_Areas_cyberspace_area_gml_bluescreen_accept(_frl__controller=undefined) {
{ var __fr_with1 = scrFRWithValues(GameCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
area = scrFRAreaResolve("cyberspace");
;
subarea = 0;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(_frl__controller), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
barHeight = 120;
;
drawConnect = true;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.instance_random, Player)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
type = 3;
;
{ var __fr_with13 = scrFRWithValues(WepPickup), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var __fr_other16=scrFROther(other);
x = __fr_other16.x;
;
var __fr_other17=scrFROther(other);
y = __fr_other17.y;
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with18 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "tk_TrinketPickup")), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
var __fr_other21=scrFROther(other);
x = __fr_other21.x;
;
var __fr_other22=scrFROther(other);
y = __fr_other22.y;
;
}
}
if(__fr_break20) break;
}}
{ var __fr_with23 = scrFRWithValues(scrFRMatching(FRCustomHitme, "name", "NTTEPet")), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
var __fr_other26=scrFROther(other);
x = __fr_other26.x;
;
var __fr_other27=scrFROther(other);
y = __fr_other27.y;
;
}
}
if(__fr_break25) break;
}}
}
}
if(__fr_break12) break;
}}
}
}
if(__fr_break9) break;
}}
scrFRSoundStop(sndPortalAppear);
;
scrFRSoundStop(sndPortalClose);
;
{ var __fr_with28 = scrFRWithValues(Player), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
if ((race == scrFRRaceTryResolve("robot"))) {
{
var _frl__newSkin = bskin;
;
{ var __fr_switch_value31=bskin, __fr_switch_case32=-1;
if(__fr_switch_case32==-1 && __fr_switch_value31==(scrFRSkinResolve(0))) __fr_switch_case32=0;
if(__fr_switch_case32==-1 && __fr_switch_value31==(scrFRSkinResolve(1))) __fr_switch_case32=1;
if(__fr_switch_case32==-1 && __fr_switch_value31==(scrFRSkinResolve(2))) __fr_switch_case32=2;
if(__fr_switch_case32==-1 && __fr_switch_value31==(scrFRSkinResolve("turret"))) __fr_switch_case32=3;
if(__fr_switch_case32==-1 && __fr_switch_value31==(scrFRSkinResolve("bonus robot"))) __fr_switch_case32=4;
if(__fr_switch_case32==-1) __fr_switch_case32=5;
switch(__fr_switch_case32) {
case 0:
_frl__newSkin = "RobotBluescreened";
;
spr_idle = scrFRModGet("skin", "RobotBluescreened", "sprIdle");
;
spr_walk = scrFRModGet("skin", "RobotBluescreened", "sprWalk");
;
spr_hurt = scrFRModGet("skin", "RobotBluescreened", "sprHurt");
;
spr_dead = scrFRModGet("skin", "RobotBluescreened", "sprDead");
;
spr_gosit = scrFRModGet("skin", "RobotBluescreened", "sprGoSit");
;
spr_sit = scrFRModGet("skin", "RobotBluescreened", "sprSit");
;
break;
;
case 1:
_frl__newSkin = "RobotBluescreenedB";
;
spr_idle = scrFRModGet("skin", "RobotBluescreenedB", "sprIdle");
;
spr_walk = scrFRModGet("skin", "RobotBluescreenedB", "sprWalk");
;
spr_hurt = scrFRModGet("skin", "RobotBluescreenedB", "sprHurt");
;
spr_dead = scrFRModGet("skin", "RobotBluescreenedB", "sprDead");
;
spr_gosit = scrFRModGet("skin", "RobotBluescreenedB", "sprGoSit");
;
spr_sit = scrFRModGet("skin", "RobotBluescreenedB", "sprSit");
;
break;
;
case 2:
_frl__newSkin = "RobotBluescreenedC";
;
spr_idle = scrFRModGet("skin", "RobotBluescreenedC", "sprIdle");
;
spr_walk = scrFRModGet("skin", "RobotBluescreenedC", "sprWalk");
;
spr_hurt = scrFRModGet("skin", "RobotBluescreenedC", "sprHurt");
;
spr_dead = scrFRModGet("skin", "RobotBluescreenedC", "sprDead");
;
spr_gosit = scrFRModGet("skin", "RobotBluescreenedC", "sprGoSit");
;
spr_sit = scrFRModGet("skin", "RobotBluescreenedC", "sprSit");
;
break;
;
case 3:
_frl__newSkin = "RobotBluescreenedTurret";
;
spr_idle = scrFRModGet("skin", "RobotBluescreenedTurret", "sprIdle");
;
spr_walk = scrFRModGet("skin", "RobotBluescreenedTurret", "sprWalk");
;
spr_hurt = scrFRModGet("skin", "RobotBluescreenedTurret", "sprHurt");
;
spr_dead = scrFRModGet("skin", "RobotBluescreenedTurret", "sprDead");
;
spr_gosit = scrFRModGet("skin", "RobotBluescreenedTurret", "sprHurt");
;
spr_sit = scrFRModGet("skin", "RobotBluescreenedTurret", "sprHurt");
;
break;
;
case 4:
_frl__newSkin = "RobotBluescreenedBonus";
;
spr_idle = scrFRModGet("skin", "RobotBluescreenedBonus", "sprIdle");
;
spr_walk = scrFRModGet("skin", "RobotBluescreenedBonus", "sprWalk");
;
spr_hurt = scrFRModGet("skin", "RobotBluescreenedBonus", "sprHurt");
;
spr_dead = scrFRModGet("skin", "RobotBluescreenedBonus", "sprDead");
;
spr_gosit = scrFRModGet("skin", "RobotBluescreenedBonus", "sprGoSit");
;
spr_sit = scrFRModGet("skin", "RobotBluescreenedBonus", "sprSit");
;
break;
;
case 5:
if (is_string(bskin)) {
{
if (scrFRScriptExists("skin", bskin, "skin_robot_bluescreened")) {
{
_frl__newSkin = scrFRModCall("skin", bskin, "skin_robot_bluescreened");
;
}
}
}
}
break;
;
}
}
bskin = scrFRSkinResolve(_frl__newSkin);
;
scrFRPlayerSetSkin(index, _frl__newSkin);
;
}
}
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [1], scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 1), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [2], scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 2), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [3], scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 3), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [4], scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 4), "=");
;
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [5], scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 5), "=");
;
}
}
if(__fr_break30) break;
}}
; // macro hoisted: _tespr
;
}

// Original Areas/cyberspace.area.gml:1170
function fr_Areas_cyberspace_area_gml_bluescreen_deny() {
var _frl__deathCause = GameCont.deathcause;
;
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
GameCont.deathcause = _frl__deathCause;
;
scrFRBindDraw(fr_Areas_cyberspace_area_gml_denybluescreen_draw, (- 14));
;
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_bluescreenController")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
}

// Original Areas/cyberspace.area.gml:1181
function fr_Areas_cyberspace_area_gml_denybluescreen_draw() {
draw_sprite_tiled(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundExt, 0, scrFRViewCoordinate(0), scrFRViewCoordinate(1));
;
scrFRDrawSprite(global.fr_module_vars[$ "area:cyberspace"].sprBluescreenBackgroundDeny, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)));
;
}

// Original Areas/cyberspace.area.gml:1185
function fr_Areas_cyberspace_area_gml_BluescreenButton_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__spr=undefined, _frl__yes=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Areas_cyberspace_area_gml_call(frMacro_Areas_cyberspace_area_gml_scr.create_button, _frl__x, _frl__y, mskNone, fr_Areas_cyberspace_area_gml_BluescreenButton_click, fr_Areas_cyberspace_area_gml_BluescreenButton_hover)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_bluescreenbutton = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__spr);
mask_index = global.fr_module_vars[$ "area:cyberspace"].mskBluescreenButton;
;
image_index = 0;
;
image_speed = (0) * timescale;
;
depth = (- 10010);
yesButton = _frl__yes;
;
creator = _frl__creator;
;
hoverTime = 0;
;
done = false;
;
clickScr = ["area", "cyberspace", fr_Areas_cyberspace_area_gml_BluescreenButton_click];
hoverScr = ["area", "cyberspace", fr_Areas_cyberspace_area_gml_BluescreenButton_hover];
on_end_step = fr_Areas_cyberspace_area_gml_BluescreenButton_endstep;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:1205
function fr_Areas_cyberspace_area_gml_BluescreenButton_click() {
if ((yesButton == true)) {
{
fr_Areas_cyberspace_area_gml_bluescreen_accept(creator);
;
}
} else {
{
fr_Areas_cyberspace_area_gml_bluescreen_deny();
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_bluescreenbutton", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
done = true;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cyberspace.area.gml:1216
function fr_Areas_cyberspace_area_gml_BluescreenButton_hover() {
image_index = 0;
;
hoverTime = 2;
;
}

// Original Areas/cyberspace.area.gml:1220
function fr_Areas_cyberspace_area_gml_BluescreenButton_endstep() {
if ((hoverTime < 1)) {
{
image_index = 1;
;
}
}
if ((hoverTime > 0)) {
{
hoverTime -= scrFRSourceScale();
;
}
}
if ((done == true)) {
{
scrFRInstanceDestroy();
;
}
}
; // macro hoisted: anim_end
; // macro hoisted: FloorNormal
}
