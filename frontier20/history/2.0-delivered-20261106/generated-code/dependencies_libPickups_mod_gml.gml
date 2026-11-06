#macro frMacro_dependencies_libPickups_mod_gml_scr global.fr_module_vars[$ "mod:libPickups"].scr

#macro frMacro_dependencies_libPickups_mod_gml_call scrFRScriptCall

#macro frMacro_dependencies_libPickups_mod_gml_infinity (1 / 0)

#macro frMacro_dependencies_libPickups_mod_gml_player_active ((((visible && (! scrFRInstanceExists(GenCont))) && (! scrFRInstanceExists(LevCont))) && (! scrFRInstanceExists(SitDown))) && (! scrFRInstanceExists(SitDown)))

// Original dependencies/libPickups.mod.gml:1
function fr_dependencies_libPickups_mod_gml___load() {

}

// Original dependencies/libPickups.mod.gml:16
function fr_dependencies_libPickups_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libPickups", _frl_name]);
;
}

// Original dependencies/libPickups.mod.gml:19
function fr_dependencies_libPickups_mod_gml_init() {
fr_dependencies_libPickups_mod_gml_addScript("pickup_text");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libPickups"].isLoaded = true;
;
global.fr_module_vars[$ "mod:libPickups"].pickup_custom = [];
;
global.fr_module_vars[$ "mod:libPickups"].libChests = [];
;
global.fr_module_vars[$ "mod:libPickups"].libPickups = [];
;
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "libPickups", "scr");
;
frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.obj_setup, "libPickups", "LibChest");
;
frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.obj_setup, "libPickups", "LibPickup");
;
; // macro hoisted: scr
; // macro hoisted: call
}

// Original dependencies/libPickups.mod.gml:40
function fr_dependencies_libPickups_mod_gml_step() {
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:libPickups"].libChests), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
fr_dependencies_libPickups_mod_gml_LibChest_basestep();
;
}
} else {
{
frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.array_delete_value, global.fr_module_vars[$ "mod:libPickups"].libChests, scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(global.fr_module_vars[$ "mod:libPickups"].libPickups), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
fr_dependencies_libPickups_mod_gml_LibPickup_basestep();
;
}
} else {
{
frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.array_delete_value, global.fr_module_vars[$ "mod:libPickups"].libPickups, scrFRSelf(self));
;
}
}
}
}
if(__fr_break6) break;
}}
}

// Original dependencies/libPickups.mod.gml:56
function fr_dependencies_libPickups_mod_gml_late_step() {
if (scrFRInstanceExists(Player)) {
{
if (array_length(global.fr_module_vars[$ "mod:libPickups"].pickup_custom)) {
{
var _frl__inst = scrFRMatching(Player, "race", "eyes");
;
if (array_length(_frl__inst)) {
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((frMacro_dependencies_libPickups_mod_gml_player_active && can_spec) && scrFRButtonCheck(index, "spec"))) {
{
var _frl__vx = scrFRViewCoordinate(0, index);
var _frl__vy = scrFRViewCoordinate(1, index);
;
{ var __fr_with4 = scrFRWithValues(frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.instance_rectangle, _frl__vx, _frl__vy, (_frl__vx + view_width), (_frl__vy + view_height), global.fr_module_vars[$ "mod:libPickups"].pickup_custom)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((! is_array(on_pull)) || scrFRModCall(scrFRIndexGet(on_pull, 0), scrFRIndexGet(on_pull, 1), scrFRIndexGet(on_pull, 2)))) {
{
var _frl__l = ((1 + scrFRGetSkill(mut_throne_butt)) * scrFRSourceScale());
var _frl__d = point_direction(x, y, (scrFROther(other)).x, (scrFROther(other)).y);
var _frl__x = (x + lengthdir_x(_frl__l, _frl__d));
var _frl__y = (y + lengthdir_y(_frl__l, _frl__d));
;
if (place_free(_frl__x, y)) {
x = _frl__x;
}
if (place_free(x, _frl__y)) {
y = _frl__y;
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
}
}
}
}
}
if (array_length(global.fr_module_vars[$ "mod:libPickups"].pickup_custom)) {
{
if ((scrFRInstanceExists(Player) || scrFRInstanceExists(Portal))) {
{
var _frl__inst = scrFRMatchingNE([Player, Portal], "id", undefined);
;
if (array_length(_frl__inst)) {
{ var __fr_with7 = scrFRWithValues(_frl__inst), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRPlaceMeeting(x, y, FR_OBJECT_PICKUP)) {
{
{ var __fr_with10 = scrFRWithValues(frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.instances_meeting, x, y, global.fr_module_vars[$ "mod:libPickups"].pickup_custom)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((scrFRInstanceExists(scrFRSelf(self)) && scrFRPlaceMeeting(x, y, (scrFROther(other))))) {
{
var _frl_open = true;
;
if (is_array(on_open)) {
{
if ((openType == 0)) {
{
_frl_open = (! scrFRModCall(scrFRIndexGet(on_open, 0), scrFRIndexGet(on_open, 1), scrFRIndexGet(on_open, 2)));
;
}
} else {
if ((openType == 1)) {
{
{ var __fr_with13 = scrFRWithValues(Player), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
{ var __fr_with16 = scrFRWithValues((scrFROther(other))), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
_frl_open = (! scrFRModCall(scrFRIndexGet(on_open, 0), scrFRIndexGet(on_open, 1), scrFRIndexGet(on_open, 2)));
;
}
}
if(__fr_break18) break;
}}
}
}
if(__fr_break15) break;
}}
}
} else {
if ((openType == 2)) {
{
{ var __fr_with19 = scrFRWithValues(frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.instance_random, Player)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
{ var __fr_with22 = scrFRWithValues((scrFROther(other))), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
_frl_open = (! scrFRModCall(scrFRIndexGet(on_open, 0), scrFRIndexGet(on_open, 1), scrFRIndexGet(on_open, 2)));
;
}
}
if(__fr_break24) break;
}}
}
}
if(__fr_break21) break;
}}
}
}
}
}
}
}
if (_frl_open) {
{
if (sprite_exists(spr_open)) {
{
{ var __fr_with25 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallChestPickup)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
var __fr_other28=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other28.spr_open);
;
var __fr_other29=scrFROther(other);
image_xscale = __fr_other29.image_xscale;
;
var __fr_other30=scrFROther(other);
image_yscale = __fr_other30.image_yscale;
;
var __fr_other31=scrFROther(other);
image_angle = __fr_other31.image_angle;
;
}
}
if(__fr_break27) break;
}}
}
}
scrFRSoundPlay(snd_open);
;
scrFRInstanceDestroy();
;
}
}
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
if(__fr_break9) break;
}}
}
}
}
global.fr_module_vars[$ "mod:libPickups"].pickup_custom = [];
;
}
}
}

// Original dependencies/libPickups.mod.gml:129
function fr_dependencies_libPickups_mod_gml_LibChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, chestprop)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprAmmoChest);
;
spr_dead = sprAmmoChestOpen;
;
spr_open = sprFXChestOpen;
;
snd_open = sndAmmoChest;
;
nochest = 0;
;
on_step = undefined;
;
on_open = undefined;
;
array_push(global.fr_module_vars[$ "mod:libPickups"].libChests, scrFRSelf(self));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libPickups.mod.gml:151
function fr_dependencies_libPickups_mod_gml_LibChest_basestep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libPickups_mod_gml_LibChest_basestep_resume, id, scrFROther(other), _args, 24, []);
}
function fr_dependencies_libPickups_mod_gml_LibChest_basestep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libPickups_mod_gml_LibChest_basestep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libPickups.mod.gml:198
scrFRTaskWithNext(_fr);
break;
case 2: // dependencies/libPickups.mod.gml:198
scrFRTaskWithAbort(_fr);
break;
case 3: // dependencies/libPickups.mod.gml:207
{
;
}
_fr.pc=1;
break;
case 4: // dependencies/libPickups.mod.gml:207
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // dependencies/libPickups.mod.gml:201
{
;
if (((! scrFRInstanceExists((scrFROther(other)))) && scrFRInstanceExists(scrFRSelf(self)))) {
{
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(LevCont))) {
{
nochest += _fr.vars._add;
;
}
}
}
}
}
_fr.pc=4;
break;
case 6: // dependencies/libPickups.mod.gml:201
_fr.wait_ticks=max(0,0); _fr.pc=5; return;
break;
case 7: // dependencies/libPickups.mod.gml:200
{
_fr.vars._add = (scrFROther(other)).nochest;
;
}
_fr.pc=6;
break;
case 8: // dependencies/libPickups.mod.gml:199
_fr.pc = (scrFRTaskFork(_fr, 7)) ? 7 : 1;
break;
case 9: // dependencies/libPickups.mod.gml:198
scrFRTaskWithEnter(_fr,scrFRWithValues(GameCont),8,0);
break;
case 10: // dependencies/libPickups.mod.gml:197
_fr.pc = ((nochest != 0)) ? 9 : 0;
break;
case 12: // dependencies/libPickups.mod.gml:159
_fr.vars.i++; _fr.pc=11;
break;
case 13: // dependencies/libPickups.mod.gml:161
scrFRTaskWithNext(_fr);
break;
case 14: // dependencies/libPickups.mod.gml:161
scrFRTaskWithAbort(_fr);
break;
case 15: // dependencies/libPickups.mod.gml:161
scrFRTaskWithNext(_fr);
break;
case 16: // dependencies/libPickups.mod.gml:161
scrFRTaskWithAbort(_fr);
break;
case 17: // dependencies/libPickups.mod.gml:191
{
;
}
_fr.pc=15;
break;
case 18: // dependencies/libPickups.mod.gml:191
_fr.result=undefined; _fr.done=true; return;
break;
case 19: // dependencies/libPickups.mod.gml:163
{
if ((scrFRCrownCurrent() == crwn_hatred)) {
{
repeat (16) { var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Rad)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRMotionAdd(scrFRSourceRandom(360), scrFRSourceRandomRange(2, 6));
;
}
}
if(__fr_break3) break;
}}
if (scrFRInstanceIs((scrFROther(other)), Player)) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHitRaw(__fr_other4, 1, true);
;
}
}
}
}
if (is_array(on_open)) {
{
scrFRModCall(scrFRIndexGet(on_open, 0), scrFRIndexGet(on_open, 1), scrFRIndexGet(on_open, 2));
;
}
}
if (sprite_exists(spr_dead)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, ChestOpen)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other8.spr_dead);
;
}
}
if(__fr_break7) break;
}}
}
}
if (sprite_exists(spr_open)) {
{
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, FXChestOpen)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
var __fr_other12=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other12.spr_open);
;
}
}
if(__fr_break11) break;
}}
}
}
scrFRSoundPlay(snd_open);
;
scrFRInstanceDestroy();
;
}
_fr.pc=18;
break;
case 20: // dependencies/libPickups.mod.gml:161
scrFRTaskWithEnter(_fr,scrFRWithValues(_fr.other_scope),19,13);
break;
case 21: // dependencies/libPickups.mod.gml:161
scrFRTaskWithEnter(_fr,scrFRWithValues(instance_nearest(x, y, scrFRIndexGet(_fr.vars._meet, _fr.vars.i))),20,12);
break;
case 22: // dependencies/libPickups.mod.gml:160
_fr.pc = (scrFRPlaceMeeting(x, y, scrFRIndexGet(_fr.vars._meet, _fr.vars.i))) ? 21 : 12;
break;
case 11: // dependencies/libPickups.mod.gml:159
_fr.pc=((_fr.vars.i < array_length(_fr.vars._meet)))?22:10;
break;
case 23: // dependencies/libPickups.mod.gml:159
_fr.vars.i = 0;
_fr.pc=11;
break;
case 24: // dependencies/libPickups.mod.gml:153
{
if (is_array(on_step)) {
{
scrFRModCall(scrFRIndexGet(on_step, 0), scrFRIndexGet(on_step, 1), scrFRIndexGet(on_step, 2));
;
}
}
_fr.vars._meet = [Player, PortalShock];
;
}
_fr.pc=23;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libPickups.mod.gml:213
function fr_dependencies_libPickups_mod_gml_LibPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_PICKUP)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprAmmo);
;
spr_open = sprSmallChestPickup;
;
spr_fade = sprSmallChestFade;
;
image_speed = (0.4) * timescale;
;
shine = 0.1;
;
snd_open = sndAmmoPickup;
;
snd_fade = sndPickupDisappear;
;
mask_index = mskPickup;
;
friction = (0.2) * (timescale * timescale);
;
num = 1;
;
blink = 30;
;
scrFRAlarmWrite(scrFRSelf(self), 0, fr_dependencies_libPickups_mod_gml_pickup_alarm((200 + scrFRSourceRandom(30)), (1 / 5)), "=");
;
pull_dis = (40 + (30 * scrFRGetSkill(mut_plutonium_hunger)));
;
pull_spd = 6;
;
on_step = undefined;
;
on_pull = ["mod", "libPickups", fr_dependencies_libPickups_mod_gml_LibPickup_pull];
;
on_open = undefined;
;
on_fade = undefined;
;
openType = 1;
;
array_push(global.fr_module_vars[$ "mod:libPickups"].libPickups, scrFRSelf(self));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libPickups.mod.gml:270
function fr_dependencies_libPickups_mod_gml_LibPickup_pull() {
return true;
;
}

// Original dependencies/libPickups.mod.gml:273
function fr_dependencies_libPickups_mod_gml_LibPickup_basestep() {
array_push(global.fr_module_vars[$ "mod:libPickups"].pickup_custom, scrFRSelf(self));
;
if (((image_index < 1) && (shine != 1))) {
{
image_index -= (image_speed * (1 - scrFRSourceRandom((shine * scrFRSourceScale()))));
;
}
}
if (((scrFRAlarmRead(scrFRSelf(self), 0) >= 0) && (scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false) == 0))) {
{
if ((blink >= 0)) {
{
blink--;
;
scrFRAlarmWrite(scrFRSelf(self), 0, 2, "=");
;
visible = (! visible);
;
}
} else {
{
if (is_array(on_fade)) {
{
scrFRModCall(scrFRIndexGet(on_fade, 0), scrFRIndexGet(on_fade, 1), scrFRIndexGet(on_fade, 2));
;
}
}
if (sprite_exists(spr_fade)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallChestFade)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_fade);
;
var __fr_other5=scrFROther(other);
image_xscale = __fr_other5.image_xscale;
;
var __fr_other6=scrFROther(other);
image_yscale = __fr_other6.image_yscale;
;
var __fr_other7=scrFROther(other);
image_angle = __fr_other7.image_angle;
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRSoundHit(snd_fade, 0.1);
;
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
if (is_array(on_step)) {
{
scrFRModCall(scrFRIndexGet(on_step, 0), scrFRIndexGet(on_step, 1), scrFRIndexGet(on_step, 2));
;
}
}
if (is_array(on_pull)) {
{
var _frl__disMax = (scrFRInstanceExists(Portal) ? frMacro_dependencies_libPickups_mod_gml_infinity : pull_dis);
var _frl__nearest = noone;
;
{ var __fr_with8 = scrFRWithValues(Player), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var _frl__dis = point_distance(x, y, (scrFROther(other)).x, (scrFROther(other)).y);
;
if ((_frl__dis < _frl__disMax)) {
{
{ var __fr_with11 = scrFRWithValues((scrFROther(other))), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
if (scrFRModCall(scrFRIndexGet(on_pull, 0), scrFRIndexGet(on_pull, 1), scrFRIndexGet(on_pull, 2))) {
{
_frl__disMax = _frl__dis;
;
var __fr_other14=scrFROther(other);
_frl__nearest = __fr_other14;
;
}
}
}
}
if(__fr_break13) break;
}}
}
}
}
}
if(__fr_break10) break;
}}
if ((_frl__nearest != noone)) {
{
var _frl__l = (pull_spd * scrFRSourceScale());
var _frl__d = point_direction(x, y, _frl__nearest.x, _frl__nearest.y);
var _frl__x = (x + lengthdir_x(_frl__l, _frl__d));
var _frl__y = (y + lengthdir_y(_frl__l, _frl__d));
;
if (place_free(_frl__x, y)) {
x = _frl__x;
}
if (place_free(x, _frl__y)) {
y = _frl__y;
}
}
}
}
}
if (((mask_index == mskPickup) && scrFRPlaceMeeting(x, y, FR_OBJECT_PICKUP))) {
{
{ var __fr_with15 = scrFRWithValues(frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.instances_meeting, x, y, scrFRMatching(FR_OBJECT_PICKUP, "mask_index", mskPickup))), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
if ((((scrFRObjectIndex(scrFRSelf(self)) == AmmoPickup) || (scrFRObjectIndex(scrFRSelf(self)) == HPPickup)) || (scrFRObjectIndex(scrFRSelf(self)) == RogueAmmo))) {
{
var __fr_other18=scrFROther(other);
scrFRMotionAddCT((point_direction(__fr_other18.x, __fr_other18.y, x, y) + frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.orandom, 10)), 0.8);
;
}
}
{ var __fr_with19 = scrFRWithValues((scrFROther(other))), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
var __fr_other22=scrFROther(other);
scrFRMotionAddCT((point_direction(__fr_other22.x, __fr_other22.y, x, y) + frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.orandom, 10)), 0.8);
;
}
}
if(__fr_break21) break;
}}
}
}
}
}
if(__fr_break17) break;
}}
}
}
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall)) {
{
if (scrFRPlaceMeeting((x + hspeed), y, Wall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + vspeed), Wall)) {
vspeed *= (- 1);
}
}
}
}

// Original dependencies/libPickups.mod.gml:368
function fr_dependencies_libPickups_mod_gml_pickup_alarm(_frl__time=undefined, _frl__loopDecay=undefined) {
_frl__time /= (1 + (GameCont.loops * _frl__loopDecay));
;
if ((scrFRCrownCurrent() == crwn_haste)) {
{
_frl__time /= (scrFRInstanceIs(scrFRSelf(self), BigRad) ? 2 : 3);
;
}
}
return _frl__time;
;
}

// Original dependencies/libPickups.mod.gml:387
function fr_dependencies_libPickups_mod_gml_pickup_text() {
var _frl__text = (argument_count>0 ? argument[0] : undefined);
var _frl__type = ((argument_count > 1) ? (argument_count>1 ? argument[1] : undefined) : undefined);
var _frl__num = ((argument_count > 2) ? (argument_count>2 ? argument[2] : undefined) : undefined);
var _frl__ammo = ["MELEE", "BULLETS", "SHELLS", "BOLTS", "EXPLOSIVES", "ENERGY"];
var _frl__ammoType = (- 1);
;
{
var _frl_i = (array_length(_frl__ammo) - 1);
for (; (_frl_i >= 0); _frl_i--) {
if ((_frl__text == loc(("Ammo:Type:" + string(_frl_i) + ""), scrFRIndexGet(_frl__ammo, _frl_i)))) {
{
_frl__ammoType = _frl_i;
;
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=_frl__type, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("add")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("max")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("low")) __fr_switch_case5=2;
if(__fr_switch_case5==-1 && __fr_switch_value4==("ins")) __fr_switch_case5=3;
if(__fr_switch_case5==-1 && __fr_switch_value4==("out")) __fr_switch_case5=4;
if(__fr_switch_case5==-1 && __fr_switch_value4==("got")) __fr_switch_case5=5;
if(__fr_switch_case5==-1) __fr_switch_case5=6;
switch(__fr_switch_case5) {
case 0:
{ var __fr_switch_value6=_frl__text, __fr_switch_case7=-1;
if(__fr_switch_case7==-1 && __fr_switch_value6==("HP")) __fr_switch_case7=0;
if(__fr_switch_case7==-1 && __fr_switch_value6==("PORTAL STRIKES")) __fr_switch_case7=1;
if(__fr_switch_case7==-1) __fr_switch_case7=2;
switch(__fr_switch_case7) {
case 0:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "Pickups:AddHealth", "+% HP", _frl__num);
;
break;
;
case 1:
mytext = loc(("Pickups:AddStrikes:" + string(_frl__num) + ""), frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "Pickups:AddStrikes", "+% PORTAL STRIKES", _frl__num));
;
break;
;
case 2:
if ((_frl__ammoType >= 0)) {
{
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, ("Pickups:AddAmmo:" + string(_frl__ammoType) + ""), frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "Pickups:AddAmmo", "+%1 %2", "%", _frl__text), _frl__num);
;
}
} else {
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "Pickups:AddAmmo", "+%1 %2", _frl__num, _frl__text);
}
;
}
}
if ((_frl__num < 0)) {
{
mytext = string_replace_all(mytext, "+", "");
;
}
}
break;
;
case 1:
{ var __fr_switch_value8=_frl__text, __fr_switch_case9=-1;
if(__fr_switch_case9==-1 && __fr_switch_value8==("HP")) __fr_switch_case9=0;
if(__fr_switch_case9==-1 && __fr_switch_value8==("PORTAL STRIKES")) __fr_switch_case9=1;
if(__fr_switch_case9==-1) __fr_switch_case9=2;
switch(__fr_switch_case9) {
case 0:
mytext = loc("Pickups:MaxHealth", "MAX HP");
;
break;
;
case 1:
mytext = loc("Pickups:MaxStrikes", "MAX PORTAL STRIKES");
;
break;
;
case 2:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "Pickups:MaxAmmo", "MAX %", _frl__text);
;
if ((_frl__ammoType >= 0)) {
{
mytext = loc(("Pickups:MaxAmmo:" + string(_frl__ammoType) + ""), mytext);
;
}
}
}
}
break;
;
case 2:
{ var __fr_switch_value10=_frl__text, __fr_switch_case11=-1;
if(__fr_switch_case11==-1 && __fr_switch_value10==("HP")) __fr_switch_case11=0;
if(__fr_switch_case11==-1) __fr_switch_case11=1;
switch(__fr_switch_case11) {
case 0:
mytext = loc("HUD:LowHealth", "LOW HP");
;
break;
;
case 1:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "HUD:LowAmmo", "LOW %", _frl__text);
;
if ((_frl__ammoType >= 0)) {
{
mytext = loc(("HUD:LowAmmo:" + string(_frl__ammoType) + ""), mytext);
;
}
}
}
}
break;
;
case 3:
{ var __fr_switch_value12=_frl__text, __fr_switch_case13=-1;
if(__fr_switch_case13==-1 && __fr_switch_value12==("RADS")) __fr_switch_case13=0;
if(__fr_switch_case13==-1) __fr_switch_case13=1;
switch(__fr_switch_case13) {
case 0:
mytext = loc("HUD:InsRads", "NOT ENOUGH RADS");
;
break;
;
case 1:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "HUD:InsAmmo", "NOT ENOUGH %", _frl__text);
;
if ((_frl__ammoType >= 0)) {
{
mytext = loc(("HUD:InsAmmo:" + string(_frl__ammoType) + ""), mytext);
;
}
}
}
}
break;
;
case 4:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "HUD:NoAmmo", "EMPTY", _frl__text);
;
if ((_frl__ammoType >= 0)) {
{
mytext = loc(("HUD:NoAmmo:" + string(_frl__ammoType) + ""), mytext);
;
}
}
break;
;
case 5:
mytext = frMacro_dependencies_libPickups_mod_gml_call(frMacro_dependencies_libPickups_mod_gml_scr.loc_format, "HUD:GotWeapon", "%!", _frl__text);
;
break;
;
case 6:
mytext = _frl__text;
;
}
}
if (scrFRInstanceIs((scrFROther(other)), Player)) {
{
var __fr_other14=scrFROther(other);
target = __fr_other14.index;
;
}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
return noone;
;
; // macro hoisted: infinity
; // macro hoisted: player_active
}
