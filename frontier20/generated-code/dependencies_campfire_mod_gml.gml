#macro frMacro_dependencies_campfire_mod_gml_anim_end (((image_index + (image_speed / timescale)) >= image_number) || ((image_index + (image_speed / timescale)) < 0))

// Original dependencies/campfire.mod.gml:1
function fr_dependencies_campfire_mod_gml___load() {

}

// Original dependencies/campfire.mod.gml:1
function fr_dependencies_campfire_mod_gml_init() {
global.fr_module_vars[$ "mod:campfire"].created = false;
;
global.fr_module_vars[$ "mod:campfire"].loaded = false;
;
global.fr_module_vars[$ "mod:campfire"].level_loading = false;
;
global.fr_module_vars[$ "mod:campfire"].chars = scrFRModNames("race");
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(CampChar, "campfire_char", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
scrFRDelete(scrFRSelf(self));
}
if(__fr_break3) break;
}}
;
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "campfire_prop")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
scrFRDelete(scrFRSelf(self));
}
if(__fr_break6) break;
}}
;
; // macro hoisted: anim_end
}

// Original dependencies/campfire.mod.gml:12
function fr_dependencies_campfire_mod_gml_level_start() {
if (((GameCont.area == scrFRAreaTryResolve(0)) && array_length(global.fr_module_vars[$ "mod:campfire"].chars))) {
{
{
var _frl_aa = 0;
for (; (_frl_aa < array_length(global.fr_module_vars[$ "mod:campfire"].chars)); _frl_aa++) {
var _frl__self = scrFRIndexGet(global.fr_module_vars[$ "mod:campfire"].chars, _frl_aa);
;
var _frl__can = (((! scrFRScriptExists("race", _frl__self, "race_avail")) || scrFRModCall("race", _frl__self, "race_avail")) && (scrFRScriptExists("race", _frl__self, "race_cf") && (scrFRModCall("race", _frl__self, "race_cf") != false)));
;
if (((_frl__can && (! array_length(scrFRMatching(Player, "race", _frl__self)))) && (scrFRScriptExists("race", _frl__self, "race_cf_corpse") && (scrFRModCall("race", _frl__self, "race_cf_corpse") != false)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve(0);
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", 1);
;
scrFRMaxHealthWrite(id, 10, "=");
;
reload = 1;
;
breload = 1;
;
scrFRAmmoArrayWrite(scrFRSelf(self), "typ_ammo", [0, 0, 0, 0, 0, 0]);
;
scrFRAmmoArrayWrite(scrFRSelf(self), "typ_amax", [0, 0, 0, 0, 0, 0]);
;
scrFRModCall("race", _frl__self, "create");
;
var _frl__positioner = scrFRInstanceCreate(x, y, FRCustomObject);
var _frl__xpos = 0;
var _frl__ypos = 0;
;
{ var __fr_with4 = scrFRWithValues(_frl__positioner), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mask_index = mskPlayerMenu;
;
var _frl__continue = true;
var _frl__loops = 999;
;
while ((_frl__continue && (_frl__loops > 0))) {
x = xstart;
;
y = ystart;
;
move_contact_solid(scrFRSourceRandom(360), (scrFRSourceRandomRange(8, 64) + scrFRSourceRandom(scrFRSourceRandom(64))));
;
x = round(x);
;
y = round(y);
;
if (((((((distance_to_object(instance_nearest(x, y, Corpse)) >= 16) && (distance_to_object(instance_nearest(x, y, CampfireOff)) >= 16)) && (distance_to_object(instance_nearest(x, y, CampfireOff)) <= 160)) && (distance_to_object(instance_nearest(x, y, Wall)) >= 16)) && (! scrFRPlaceMeeting(x, y, NightCactus))) && scrFRPlaceMeeting(x, y, Floor))) {
{
_frl__continue = false;
;
_frl__xpos = x;
;
_frl__ypos = y;
;
break;
;
}
} else {
_frl__loops--;
}
;
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(_frl__xpos, _frl__ypos, Corpse)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_xscale = scrFRSourceChoose((- 1), 1);
;
var __fr_other10=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other10.spr_dead);
campfire_corpse = true;
;
image_speed = (0) * timescale;
;
image_index = image_number;
;
}
}
if(__fr_break9) break;
}}
scrFRDelete(_frl__positioner);
;
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
} else {
{ var __fr_with11 = scrFRWithValues(scrFRMatching(Corpse, "campfire_corpse", true)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break13) break;
}}
}
}

// Original dependencies/campfire.mod.gml:85
function fr_dependencies_campfire_mod_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "mod:campfire"].level_loading = true;
;
}
} else {
if (global.fr_module_vars[$ "mod:campfire"].level_loading) {
{
global.fr_module_vars[$ "mod:campfire"].level_loading = false;
;
fr_dependencies_campfire_mod_gml_level_start();
;
}
}
}
if (scrFRInstanceExists(Menu)) {
{
if ((! global.fr_module_vars[$ "mod:campfire"].created)) {
{
global.fr_module_vars[$ "mod:campfire"].created = true;
;
{
var _frl_aa = 0;
for (; (_frl_aa < array_length(global.fr_module_vars[$ "mod:campfire"].chars)); _frl_aa++) {
var _frl__self = scrFRIndexGet(global.fr_module_vars[$ "mod:campfire"].chars, _frl_aa);
;
if (((((! scrFRScriptExists("race", _frl__self, "race_avail")) || scrFRModCall("race", _frl__self, "race_avail")) && (scrFRScriptExists("race", _frl__self, "race_cf") && scrFRModCall("race", _frl__self, "race_cf"))) && (! array_length(scrFRMatching(CampChar, "race", _frl__self))))) {
{
var _frl__xpos = 0;
var _frl__ypos = 0;
;
if (scrFRScriptExists("race", _frl__self, "race_cf_positioner")) {
{
var _frl__pos = scrFRModCall("race", _frl__self, "race_cf_positioner");
;
_frl__xpos = _frl__pos.x;
;
_frl__ypos = _frl__pos.y;
;
}
} else {
{
var _frl__positioner = scrFRInstanceCreate(Campfire.x, Campfire.y, FRCustomObject);
var _frl__loops = 999;
;
{ var __fr_with1 = scrFRWithValues(_frl__positioner), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mask_index = mskPlayerMenu;
;
while ((_frl__loops > 0)) {
x = xstart;
;
y = ystart;
;
move_contact_solid(scrFRSourceRandom(360), (scrFRSourceRandomRange(32, 64) + scrFRSourceRandom(scrFRSourceRandom(64))));
;
x = round(x);
;
y = round(y);
;
if ((((((distance_to_object(instance_nearest(x, y, CampChar)) >= 16) && (distance_to_object(instance_nearest(x, y, Campfire)) >= 24)) && (distance_to_object(instance_nearest(x, y, Campfire)) <= 240)) && (distance_to_object(instance_nearest(x, y, TV)) >= 32)) && (distance_to_object(instance_nearest(x, y, Campfire)) >= 12))) {
{
_frl__xpos = x;
;
_frl__ypos = y;
;
break;
;
}
} else {
_frl__loops--;
}
;
}
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(fr_dependencies_campfire_mod_gml_campchar_create(_frl__self, _frl__xpos, _frl__ypos)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((scrFRScriptExists("race", _frl__self, "race_cf_couple") && scrFRModLoaded("race", scrFRModCall("race", _frl__self, "race_cf_couple"))) && (! array_length(scrFRMatching(CampChar, "race", scrFRModCall("race", _frl__self, "race_cf_couple")))))) {
{
couple = scrFRModCall("race", _frl__self, "race_cf_couple");
;
var _frl__c = couple;
;
{ var __fr_with7 = scrFRWithValues(fr_dependencies_campfire_mod_gml_campchar_create(_frl__c, xpos, ypos)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
couple = scrFRModCall("race", _frl__c, "race_cf_couple");
;
var __fr_other10=scrFROther(other);
couple_char = __fr_other10;
;
var __fr_other11=scrFROther(other);
__fr_other11.couple_char = scrFRSelf(self);
;
fr_dependencies_campfire_mod_gml_campchar_sprites(_frl__c);
;
}
}
if(__fr_break9) break;
}}
}
}
fr_dependencies_campfire_mod_gml_campchar_sprites(_frl__self);
;
var _frl__depth = depth;
;
if (scrFRScriptExists("race", _frl__self, "race_cf_prop")) {
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
name = "cfire_prop";
sprite_index = scrFRAreaSourceSprite(scrFRModCall("race", _frl__self, "race_cf_prop"));
;
depth = (_frl__depth - (sign(scrFRModCall("race", _frl__self, "race_cf_proptyp")) * 2));
;
mask_index = mskNone;
;
}
}
if(__fr_break14) break;
}}
}
}
}
if(__fr_break6) break;
}}
scrFRDelete(_frl__positioner);
;
}
}
}
}
}
}
}
} else {
global.fr_module_vars[$ "mod:campfire"].created = false;
}
;
global.fr_module_vars[$ "mod:campfire"].loaded = true;
;
scrFRBindStep(fr_dependencies_campfire_mod_gml_campchar_select, 0);
;
}

// Original dependencies/campfire.mod.gml:187
function fr_dependencies_campfire_mod_gml_campchar_select() {
{ var __fr_with1 = scrFRWithValues(CampChar), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if (scrFRVariableExists(scrFRSelf(self), "campfire_char")) {
{
var _frl__selected = false;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) if (scrFRPlayerIsActive(_frl_i)) {
{
if ((scrFRRaceTryResolve(scrFRPlayerRace(_frl_i)) == race)) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(0, 0, Revive)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__selected = true;
;
var _frl__local = false;
;
{
var _frl_j = 0;
for (; (_frl_j < INPUT_MAX_PLAYERS); _frl_j++) {
if (((_frl_j != _frl_i) && (scrFRPlayerUID(_frl_j) == scrFRPlayerUID(_frl_i)))) {
{
_frl__local = true;
;
break;
;
}
}
}
}
var _frl_shake = UberCont.opt_shake;
;
if ((! _frl__local)) {
{
UberCont.opt_shake = 1.15;
;
instance_change(Player, false);
;
p = _frl_i;
;
var __fr_other7=scrFROther(other);
gunangle = point_direction(64, 64, __fr_other7.x, __fr_other7.y);
;
var __fr_other8=scrFROther(other);
scrFRWeaponPost(0, ((point_distance(64, 64, __fr_other8.x, __fr_other8.y) / 10) * scrFRSourceScale()), 0);
;
}
}
scrFRDelete(scrFRSelf(self));
;
UberCont.opt_shake = _frl_shake;
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
couple_selected = _frl__selected;
;
if ((couple == noone)) {
{
if (frMacro_dependencies_campfire_mod_gml_anim_end) {
{
if (_frl__selected) {
{
if ((sprite_index != spr_slcted)) {
{
if ((sprite_index == spr_slcting)) {
{
sprite_index = scrFRAreaSourceSprite(spr_slcted);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_slcting);
}
;
}
}
}
} else {
{
if ((sprite_index != spr_noslct)) {
{
if ((sprite_index == spr_deslcting)) {
{
sprite_index = scrFRAreaSourceSprite(spr_noslct);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_deslcting);
}
;
}
}
}
}
image_index = 0;
;
}
}
}
} else {
{
if (frMacro_dependencies_campfire_mod_gml_anim_end) {
{
if (_frl__selected) {
{
if ((sprite_index == spr_couple_slcted)) {
{
sprite_index = scrFRAreaSourceSprite(spr_couple_unswap);
;
}
} else {
if ((sprite_index != spr_slcted)) {
{
if ((sprite_index == spr_slcting)) {
{
sprite_index = scrFRAreaSourceSprite(spr_slcted);
;
}
} else {
if ((sprite_index == spr_couple_unswap)) {
{
sprite_index = scrFRAreaSourceSprite(spr_slcted);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_slcting);
}
}
;
}
}
}
}
} else {
{
if (couple_char.couple_selected) {
{
if (((sprite_index == spr_noslct) || (sprite_index == spr_couple_slcting))) {
{
if ((sprite_index == spr_couple_slcting)) {
{
sprite_index = scrFRAreaSourceSprite(spr_couple_slcted);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_couple_slcting);
}
;
}
} else {
if ((sprite_index != spr_couple_slcted)) {
{
if ((sprite_index == spr_couple_swap)) {
{
sprite_index = scrFRAreaSourceSprite(spr_couple_slcted);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_couple_swap);
}
;
}
}
}
}
} else {
if ((sprite_index != spr_noslct)) {
{
if ((sprite_index == spr_deslcting)) {
{
sprite_index = scrFRAreaSourceSprite(spr_noslct);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_deslcting);
}
;
}
}
}
}
}
image_index = 0;
;
}
} else {
{
image_index = couple_char.image_index;
;
}
}
}
}
}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original dependencies/campfire.mod.gml:325
function fr_dependencies_campfire_mod_gml_campchar_create(_frl__char=undefined, _frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, CampChar)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_shadow_x = scrFRModCall("race", _frl__char, "race_cf_shadowx");
;
spr_shadow_y = scrFRModCall("race", _frl__char, "race_cf_shadowy");
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
campfire_char = true;
;
num = 0.1;
;
race = scrFRRaceResolve(_frl__char);
;
mask_index = mskPlayerMenu;
;
image_speed = (0.4) * timescale;
;
if (scrFRScriptExists("race", _frl__char, "race_cf_depth")) {
depth = scrFRModCall("race", _frl__char, "race_cf_depth");
}
couple = noone;
;
couple_char = noone;
;
couple_selected = false;
;
if ((scrFRScriptExists("race", _frl__char, "race_cf_spawnparticles") && (! global.fr_module_vars[$ "mod:campfire"].loaded))) {
scrFRModCall("race", _frl__char, "race_cf_spawnparticles");
}
character_set_id = (scrFRScriptExists("race", _frl__char, "race_cf_characterset") ? scrFRModCall("race", _frl__char, "race_cf_characterset") : undefined);
;
return real(id);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/campfire.mod.gml:353
function fr_dependencies_campfire_mod_gml_campchar_sprites(_frl__char=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(CampChar, "race", _frl__char)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRScriptExists("race", _frl__char, "race_cf_couple") && scrFRModLoaded("race", scrFRModCall("race", _frl__char, "race_cf_couple")))) {
{
spr_slcted = scrFRModCall("race", _frl__char, "race_cf_couple_sprselectedn");
;
spr_noslct = scrFRModCall("race", _frl__char, "race_cf_couple_sprnotselectedn");
;
spr_slcting = scrFRModCall("race", _frl__char, "race_cf_couple_sprselectingn");
;
spr_deslcting = scrFRModCall("race", _frl__char, "race_cf_couple_sprdeselectingn");
;
spr_couple_slcted = scrFRModCall("race", _frl__char, "race_cf_couple_sprselected");
;
spr_couple_slcting = scrFRModCall("race", _frl__char, "race_cf_couple_sprselecting");
;
spr_couple_deslcting = scrFRModCall("race", _frl__char, "race_cf_couple_sprdeselecting");
;
spr_couple_swap = scrFRModCall("race", _frl__char, "race_cf_couple_sprswapping");
;
spr_couple_unswap = scrFRModCall("race", _frl__char, "race_cf_couple_sprdeswapping");
;
partner_xoffset = scrFRModCall("race", _frl__char, "race_cf_couple_xoffset");
;
partner_yoffset = scrFRModCall("race", _frl__char, "race_cf_couple_yoffset");
;
}
} else {
{
spr_slcted = scrFRModCall("race", _frl__char, "race_cf_sprselected");
;
spr_noslct = scrFRModCall("race", _frl__char, "race_cf_sprnotselected");
;
spr_slcting = scrFRModCall("race", _frl__char, "race_cf_sprselecting");
;
spr_deslcting = scrFRModCall("race", _frl__char, "race_cf_sprdeselecting");
;
}
}
if (scrFRVariableExists(scrFRSelf(self), "partner_xoffset")) {
x += partner_xoffset;
}
if (scrFRVariableExists(scrFRSelf(self), "partner_yoffset")) {
y += partner_yoffset;
}
sprite_index = scrFRAreaSourceSprite(spr_noslct);
;
}
}
if(__fr_break3) break;
}}
}
