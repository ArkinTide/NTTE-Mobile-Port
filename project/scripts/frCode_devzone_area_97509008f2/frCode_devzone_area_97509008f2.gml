// Original Areas/devzone.area.gml:1
function fr_Areas_devzone_area_gml___load() {

}

// Original Areas/devzone.area.gml:1
function fr_Areas_devzone_area_gml_init() {
global.fr_module_vars[$ "area:devzone"].noPopo = true;
;
global.fr_module_vars[$ "area:devzone"].sprAreaIcon = sprFR_sprAreaIconDevzone_f8e6d6d22cba;
;
global.fr_module_vars[$ "area:devzone"].sprFloor = sprFR_sprFloorDevzone_8bde6c87ef25;
;
global.fr_module_vars[$ "area:devzone"].sprFloorB = sprFR_sprFloorDevzoneB_4c307b208cbd;
;
global.fr_module_vars[$ "area:devzone"].sprFloorExplo = sprFR_sprFloorDevzoneExplo_f3e674eeac3d;
;
global.fr_module_vars[$ "area:devzone"].sprWallBot = sprFR_sprWallDevzoneBot_32e943495c58;
;
global.fr_module_vars[$ "area:devzone"].sprWallTop = sprFR_sprWallDevzoneTop_ed5d9a4f2af1;
;
global.fr_module_vars[$ "area:devzone"].sprWallOut = sprFR_sprWallDevzoneOut_fa04c2847fb8;
;
global.fr_module_vars[$ "area:devzone"].sprWallTrans = sprFR_sprWallDevzoneTrans_de2f81a4d2d4;
;
global.fr_module_vars[$ "area:devzone"].sprDebris = sprFR_sprDebrisDevzone_3126484517d9;
;
global.fr_module_vars[$ "area:devzone"].sprDetail = sprFR_sprDetailDevzone_291539c0da58;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox1 = sprFR_sprDevbox1_75f6d1630572;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox1Hurt = sprFR_sprDevbox1Hurt_e02a8346c047;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox2 = sprFR_sprDevbox2_be36e39f0bc5;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox2Hurt = sprFR_sprDevbox2Hurt_84439ed02d31;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox3 = sprFR_sprDevbox3_3acf98ff984c;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox3Hurt = sprFR_sprDevbox3Hurt_11823c3ecb0e;
;
global.fr_module_vars[$ "area:devzone"].sprDevbox1Dead = sprFR_sprDevboxDead_cb6d9b3c46ea;
;
global.fr_module_vars[$ "area:devzone"].sprDevcone = sprFR_sprDevcone_ed3275922997;
;
global.fr_module_vars[$ "area:devzone"].sprDevconeHurt = sprFR_sprDevconeHurt_d8acac026b0c;
;
global.fr_module_vars[$ "area:devzone"].sprDevconeDead = sprFR_sprDevconeDead_9d6837a0a0f6;
;
}

// Original Areas/devzone.area.gml:38
function fr_Areas_devzone_area_gml_area_subarea() {
return 99;
;
}

// Original Areas/devzone.area.gml:39
function fr_Areas_devzone_area_gml_area_goal() {
return 130;
;
}

// Original Areas/devzone.area.gml:40
function fr_Areas_devzone_area_gml_area_next() {
return [1, 1];
;
}

// Original Areas/devzone.area.gml:41
function fr_Areas_devzone_area_gml_area_background_color() {
return make_color_rgb(65, 83, 124);
;
}

// Original Areas/devzone.area.gml:42
function fr_Areas_devzone_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/devzone.area.gml:43
function fr_Areas_devzone_area_gml_area_darkness() {
return false;
;
}

// Original Areas/devzone.area.gml:44
function fr_Areas_devzone_area_gml_area_secret() {
return false;
;
}

// Original Areas/devzone.area.gml:45
function fr_Areas_devzone_area_gml_area_outside() {
return true;
;
}

// Original Areas/devzone.area.gml:47
function fr_Areas_devzone_area_gml_area_name() {
return scrFRLocalize((("@1(" + string(real(global.fr_module_vars[$ "area:devzone"].sprAreaIcon)) + ":0)D-") + string(GameCont.subarea)));
;
}

// Original Areas/devzone.area.gml:50
function fr_Areas_devzone_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("WHAT", "TESTING TESTING", "WAIT HOLD ON", "IS IT WORKING", "CTRL+S!!!"));
;
}

// Original Areas/devzone.area.gml:59
function fr_Areas_devzone_area_gml_area_mapdata(_frl__x=undefined, _frl__y=undefined) {
return [99, (- 9)];
;
}

// Original Areas/devzone.area.gml:62
function fr_Areas_devzone_area_gml_area_sprite(_frl__sprite=undefined) {
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
fr_Areas_devzone_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:devzone"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_devzone_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:devzone"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:devzone"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:devzone"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:devzone"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:devzone"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:devzone"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:devzone"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:devzone"].sprDetail;
;
}
}
}

// Original Areas/devzone.area.gml:75
function fr_Areas_devzone_area_gml_area_setup() {
scrFRSoundMusic(mus3b);
scrFRSoundAmbient(amb6);
;
goal = fr_Areas_devzone_area_gml_area_goal();
;
background_set_colour(fr_Areas_devzone_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_devzone_area_gml_area_shadow_color();
;
TopCont.darkness = fr_Areas_devzone_area_gml_area_darkness();
;
GameCont.noradch = 1;
;
safespawn = 1;
;
scrFRBindStep(fr_Areas_devzone_area_gml_area_step, 0);
;
scrFRSoundAssign(sndWallBreakRock, sndWallBreakLabs);
;
}

// Original Areas/devzone.area.gml:93
function fr_Areas_devzone_area_gml_area_setup_floor() {
material = 3;
;
}

// Original Areas/devzone.area.gml:97
function fr_Areas_devzone_area_gml_area_start() {
scrFRInstanceCreate(10016, 10016, becomenemy);
}

// Original Areas/devzone.area.gml:101
function fr_Areas_devzone_area_gml_area_make_floor() {
var _frl__x = x;
var _frl__y = y;
var _frl__outOfSpawn = (point_distance(_frl__x, _frl__y, 10000, 10000) > 48);
;
scrFRInstanceCreate(_frl__x, _frl__y, Floor);
;
if ((scrFRSourceRandom(10) < 1)) {
{
fr_Areas_devzone_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
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

// Original Areas/devzone.area.gml:140
function fr_Areas_devzone_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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

// Original Areas/devzone.area.gml:154
function fr_Areas_devzone_area_gml_area_pop_props() {
if ((scrFRSourceRandom(25) < 1)) {
fr_Areas_devzone_area_gml_DevBox_create((x + 16), (y + 16));
}
if ((scrFRSourceRandom(40) < 1)) {
fr_Areas_devzone_area_gml_DevCone_create((x + 16), (y + 16));
}
}

// Original Areas/devzone.area.gml:161
function fr_Areas_devzone_area_gml_area_finish() {
if ((subarea < fr_Areas_devzone_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_devzone_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
}

// Original Areas/devzone.area.gml:175
function fr_Areas_devzone_area_gml_area_transit() {
scrFRSoundRestore(sndWallBreakRock);
;
}

// Original Areas/devzone.area.gml:179
function fr_Areas_devzone_area_gml_area_step() {
if ((global.fr_module_vars[$ "area:devzone"].noPopo == true)) {
{
if ((scrFRInstanceExists(WantPopo) || scrFRInstanceExists(WantVan))) {
{
{ var __fr_with1 = scrFRWithValues(WantPopo), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(WantVan), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
}
}
if (((scrFRInstanceExists(VanSpawn) || scrFRInstanceExists(IDPDSpawn)) || (array_length(scrFRMatching(FRCustomObject, "name", "IDPDPortal")) > 0))) {
{
{ var __fr_with7 = scrFRWithValues(IDPDSpawn), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(VanSpawn), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break15) break;
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
}
}

// Original Areas/devzone.area.gml:207
function fr_Areas_devzone_area_gml_ExampleProp_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevbox1;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevbox1Hurt;
;
spr_dead = global.fr_module_vars[$ "area:devzone"].sprDevbox1Dead;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndStreetLightBreak;
;
scrFRMaxHealthWrite(id, 4, "=");
;
hp = max_hp;
;
mask_index = mskSpider;
team = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/devzone.area.gml:227
function fr_Areas_devzone_area_gml_DevBox_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
altsprite = scrFRSourceChoose(1, 2, 3);
if ((altsprite == 1)) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevbox1;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevbox1Hurt;
;
}
}
if ((altsprite == 2)) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevbox2;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevbox2Hurt;
;
}
}
if ((altsprite == 3)) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevbox3;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevbox3Hurt;
;
}
}
spr_dead = global.fr_module_vars[$ "area:devzone"].sprDevbox1Dead;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndStreetLightBreak;
;
scrFRMaxHealthWrite(id, 4, "=");
;
hp = max_hp;
;
team = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/devzone.area.gml:256
function fr_Areas_devzone_area_gml_DevCone_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevcone;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevconeHurt;
;
spr_dead = global.fr_module_vars[$ "area:devzone"].sprDevconeDead;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndStreetLightBreak;
;
scrFRMaxHealthWrite(id, 4, "=");
;
hp = max_hp;
;
team = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/devzone.area.gml:274
function fr_Areas_devzone_area_gml_DevLight_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "area:devzone"].sprDevLight;
;
spr_hurt = global.fr_module_vars[$ "area:devzone"].sprDevLightHurt;
;
spr_dead = global.fr_module_vars[$ "area:devzone"].sprDevLightDead;
;
mask_index = mskStreetLight;
;
spr_shadow = shd32;
;
spr_shadow_y = 1;
;
depth = (- 7);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndStreetLightBreak;
;
scrFRMaxHealthWrite(id, 4, "=");
;
hp = max_hp;
;
team = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}
