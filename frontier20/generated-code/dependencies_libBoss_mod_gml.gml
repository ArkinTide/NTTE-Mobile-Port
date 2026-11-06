// Original dependencies/libBoss.mod.gml:1
function fr_dependencies_libBoss_mod_gml___load() {

}

// Original dependencies/libBoss.mod.gml:16
function fr_dependencies_libBoss_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libBoss", _frl_name]);
;
}

// Original dependencies/libBoss.mod.gml:19
function fr_dependencies_libBoss_mod_gml_init() {
fr_dependencies_libBoss_mod_gml_addScript("draw_text_bn");
;
fr_dependencies_libBoss_mod_gml_addScript("boss_hp");
;
fr_dependencies_libBoss_mod_gml_addScript("boss_intro_setup");
;
fr_dependencies_libBoss_mod_gml_addScript("boss_intro");
;
fr_dependencies_libBoss_mod_gml_addScript("boss_dead");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libBoss"].isLoaded = true;
;
}

// Original dependencies/libBoss.mod.gml:29
function fr_dependencies_libBoss_mod_gml_draw_text_bn(_frl__x=undefined, _frl__y=undefined, _frl__string=undefined, _frl__angle=undefined) {
_frl__string = string_upper(_frl__string);
;
var _frl__col = draw_get_color();
;
draw_set_color(c_black);
;
scrFRDrawTextTransformed((_frl__x + 1), _frl__y, _frl__string, 1, 1, _frl__angle);
;
scrFRDrawTextTransformed(_frl__x, (_frl__y + 2), _frl__string, 1, 1, _frl__angle);
;
scrFRDrawTextTransformed((_frl__x + 1), (_frl__y + 2), _frl__string, 1, 1, _frl__angle);
;
draw_set_color(_frl__col);
;
scrFRDrawTextTransformed(_frl__x, _frl__y, _frl__string, 1, 1, _frl__angle);
;
}

// Original dependencies/libBoss.mod.gml:49
function fr_dependencies_libBoss_mod_gml_boss_hp(_frl__hp=undefined) {
var _frl__players = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__players += scrFRPlayerIsActive(_frl_i);
;
}
}
return round(((_frl__hp * (1 + ((1 / 3) * GameCont.loops))) * (1 + (0.5 * (_frl__players - 1)))));
;
}

// Original dependencies/libBoss.mod.gml:56
function fr_dependencies_libBoss_mod_gml_boss_intro_setup(_frl__name=undefined, _frl__mainspr=undefined, _frl__backspr=undefined, _frl__namespr=undefined) {
var _frl_main = surface_create(492, 240);
;
surface_set_target(_frl_main);
;
draw_clear_alpha(c_white, 0);
;
scrFRDrawSprite(_frl__mainspr, 0, 0, 0);
;
surface_reset_target();
;
surface_save(_frl_main, (_frl__name + "_main.png"));
;
surface_free(_frl_main);
;
var _frl_back = surface_create(492, 240);
;
surface_set_target(_frl_back);
;
draw_clear_alpha(c_white, 0);
;
scrFRDrawSprite(_frl__backspr, 0, 0, 0);
;
surface_reset_target();
;
surface_save(_frl_back, (_frl__name + "_main.png"));
;
surface_free(_frl_back);
;
var _frl_name = surface_create(181, 75);
;
surface_set_target(_frl_name);
;
draw_clear_alpha(c_white, 0);
;
if (is_string(_frl__namespr)) {
{
fr_dependencies_libBoss_mod_gml_draw_text_bn(0, 20, string_upper(_frl__namespr), 1.5);
;
}
} else {
{
scrFRDrawSprite(_frl__namespr, 0, 0, 0);
;
}
}
surface_reset_target();
;
surface_save(_frl_name, (_frl__name + "_main.png"));
;
surface_free(_frl_name);
;
}

// Original dependencies/libBoss.mod.gml:91
function fr_dependencies_libBoss_mod_gml_boss_intro(_frl__name=undefined, _frl__introSound=undefined, _frl__music=undefined) {
{ var __fr_with1 = scrFRWithValues(MusCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1);
;
scrFRAlarmWrite(scrFRSelf(self), 3, (- 1));
;
}
}
if(__fr_break3) break;
}}
if ((_frl__name != "")) {
{
{ var __fr_with4 = scrFRWithValues(scrFRBindBeginStep(fr_dependencies_libBoss_mod_gml_boss_intro_step, 0)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
boss = _frl__name;
;
loops = 0;
;
intro = true;
;
sprites = [[(_frl__name + "_main.png"), sprBossIntro, 0], [(_frl__name + "_back.png"), sprBossIntroBackLayer, 0], [(_frl__name + "_name.png"), sprBossName, 0]];
;
music = _frl__music;
;
{ var __fr_with7 = scrFRWithValues(sprites), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((! scrFRFileLoaded(scrFRIndexGet(scrFRSelf(self), 0)))) {
{
scrFRFileLoad(scrFRIndexGet(scrFRSelf(self), 0));
;
}
}
}
}
if(__fr_break9) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break6) break;
}}
}
}
if ((_frl__introSound != undefined)) {
{
scrFRSoundPlay(_frl__introSound);
;
}
}
return noone;
;
}

// Original dependencies/libBoss.mod.gml:134
function fr_dependencies_libBoss_mod_gml_boss_intro_step() {
if (intro) {
{
intro = false;
;
{ var __fr_with1 = scrFRWithValues(sprites), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRFileLoaded(scrFRIndexGet(scrFRSelf(self), 0)))) {
{
var __fr_other4=scrFROther(other);
__fr_other4.intro = true;
;
__fr_break3=true; break;
;
}
}
}
}
if(__fr_break3) break;
}}
if ((((! intro) && (UberCont.opt_bossintro == true)) && (GameCont.loops <= loops))) {
{
{ var __fr_with5 = scrFRWithValues(sprites), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
if (scrFRFileExists(scrFRIndexGet(scrFRSelf(self), 0))) {
{
scrFRSpriteReplaceImage(scrFRIndexGet(scrFRSelf(self), 1), scrFRIndexGet(scrFRSelf(self), 0), scrFRIndexGet(scrFRSelf(self), 2));
;
}
}
}
}
if(__fr_break7) break;
}}
var _frl__lastSub = GameCont.subarea;
var _frl__lastLoop = GameCont.loops;
var _frl__lastIntro = UberCont.opt_bossintro;
;
GameCont.loops = 0;
;
UberCont.opt_bossintro = true;
;
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(0, 0, BanditBoss)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
{ var __fr_with11 = scrFRWithValues(scrFRSelf(self)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
event_perform(ev_alarm, 6);
;
}
}
if(__fr_break13) break;
}}
scrFRSoundStop(sndBigBanditIntro);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break10) break;
}}
{ var __fr_with14 = scrFRWithValues(MusCont), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
scrFRAlarmWrite(scrFRSelf(self), 3, (- 1));
;
}
}
if(__fr_break16) break;
}}
GameCont.subarea = _frl__lastSub;
;
GameCont.loops = _frl__lastLoop;
;
UberCont.opt_bossintro = _frl__lastIntro;
;
}
}
if ((music != undefined)) {
{
scrFRSoundMusic(music);
;
}
}
}
} else {
{
{ var __fr_with17 = scrFRWithValues(sprites), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
scrFRSpriteRestore(scrFRIndexGet(scrFRSelf(self), 1));
;
}
}
if(__fr_break19) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original dependencies/libBoss.mod.gml:192
function fr_dependencies_libBoss_mod_gml_boss_dead() {
{ var __fr_with1 = scrFRWithValues(MusCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
scrFRAlarmWrite(scrFRSelf(self), 1, 1);
}
if(__fr_break3) break;
}}
;
}
