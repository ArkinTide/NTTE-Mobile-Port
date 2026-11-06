#macro frMacro_CustomIDPDHandler_mod_gml_current_frame_active (scrFRSourceFrame() < (floor(scrFRSourceFrame()) + scrFRSourceScale()))

// Original CustomIDPDHandler.mod.gml:1
function fr_CustomIDPDHandler_mod_gml___load() {

}

// Original CustomIDPDHandler.mod.gml:1
function fr_CustomIDPDHandler_mod_gml_init() {
global.fr_module_vars[$ "mod:CustomIDPDHandler"].knownMods = [];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].standard = [[[["CustomIDPDHandler", "DefaultIDPD_spawn"], ["CustomIDPDHandler", "DefaultIDPD_create"], undefined], 100, (- 1000)]];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].elite = [[[["CustomIDPDHandler", "DefaultIDPD_spawn"], ["CustomIDPDHandler", "DefaultIDPD_create"], undefined], 100, (- 1000)]];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].freak = [[[["CustomIDPDHandler", "DefaultIDPD_spawn"], ["CustomIDPDHandler", "DefaultIDPD_create"], undefined], 100, (- 1000)]];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].elitefreak = [[[["CustomIDPDHandler", "DefaultIDPD_spawn"], ["CustomIDPDHandler", "DefaultIDPD_create"], undefined], 100, (- 1000)]];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].vans = [[[["CustomIDPDHandler", "DefaultVan_spawn"], undefined, undefined], 100, (- 1000)]];
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].spawnedPortals = 0;
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].sprVanPortal = sprFR_d9431b532fdc6593a723e3ef_25cab34bfb70;
;
global.fr_module_vars[$ "mod:CustomIDPDHandler"].sprVanPortalDisappear = sprFR_1235bfd65530c4f9c821804a_a2605246c9f5;
;
if (instance_exists(GameCont) && (!scrFRVariableExists(GameCont, "vanlevel"))) {
GameCont.vanlevel = 0;
}
}

// Original CustomIDPDHandler.mod.gml:25
function fr_CustomIDPDHandler_mod_gml_game_start() {
if ((!scrFRVariableExists(GameCont, "vanlevel"))) {
GameCont.vanlevel = 0;
}
}

// Original CustomIDPDHandler.mod.gml:28
function fr_CustomIDPDHandler_mod_gml_step() {
{ var __fr_with1 = scrFRWithValues(IDPDSpawn), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if (scrFRInstanceIs(scrFRSelf(self), IDPDSpawn)) {
{
GameCont.popolevel--;
;
fr_CustomIDPDHandler_mod_gml_IDPDPortal_create(x, y, elite, freak, 0);
;
scrFRInstanceDestroy();
;
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(VanSpawn), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_CustomIDPDHandler_mod_gml_IDPDPortal_create(x, y, 0, 0, 1);
;
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
}

// Original CustomIDPDHandler.mod.gml:40
function fr_CustomIDPDHandler_mod_gml_draw_dark() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
draw_circle(x, y, (glowRadius + scrFRSourceRandom(6)), false);
}
if(__fr_break3) break;
}}
;
}

// Original CustomIDPDHandler.mod.gml:43
function fr_CustomIDPDHandler_mod_gml_draw_dark_end() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
draw_circle(x, y, ((glowRadius / 3) + scrFRSourceRandom(6)), false);
}
if(__fr_break3) break;
}}
;
}

// Original CustomIDPDHandler.mod.gml:46
function fr_CustomIDPDHandler_mod_gml_draw_bloom() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (scrFRIndexGet(bloomCount, 0) * image_xscale), (scrFRIndexGet(bloomCount, 0) * image_yscale), image_angle, image_blend, scrFRIndexGet(bloomCount, 1));
;
}
}
if(__fr_break3) break;
}}
}

// Original CustomIDPDHandler.mod.gml:51
function fr_CustomIDPDHandler_mod_gml_CustomIDPDSpawn_add(_frl__pool=undefined, _frl__popolevel=undefined, _frl__weight=undefined, _frl__spawnfunction=undefined, _frl__createfunction=undefined, _frl__stepfunction=undefined) {
if (is_array(_frl__pool)) {
{
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__pool)); _frl_i++) {
var _frl__selectedPool = scrFRModGet("mod", "CustomIDPDHandler", scrFRIndexGet(_frl__pool, _frl_i));
array_push(_frl__selectedPool, [[_frl__spawnfunction, _frl__createfunction, _frl__stepfunction], _frl__weight, _frl__popolevel]);
}
}
}
} else {
{
var _frl__selectedPool = scrFRModGet("mod", "CustomIDPDHandler", _frl__pool);
array_push(_frl__selectedPool, [[_frl__spawnfunction, _frl__createfunction, _frl__stepfunction], _frl__weight, _frl__popolevel]);
}
}
}

// Original CustomIDPDHandler.mod.gml:62
function fr_CustomIDPDHandler_mod_gml_IDPDPortal_create(_frl__x=undefined, _frl__y=undefined, _frl__elite=undefined, _frl__freak=undefined, _frl__van=undefined) {
var _frl__IDPDLevel = 0;
;
if (_frl__van) {
{
_frl__IDPDLevel = (++ GameCont.vanlevel);
;
}
} else {
if (((! scrFRInstanceExists(LilHunter)) || (GameCont.loops > 0))) {
{
_frl__IDPDLevel = (++ GameCont.popolevel);
;
}
}
}
global.fr_module_vars[$ "mod:CustomIDPDHandler"].spawnedPortals += 1;
;
var _frl__selectPool = (_frl__van ? global.fr_module_vars[$ "mod:CustomIDPDHandler"].vans : ((GameCont.loops >= 3) ? (_frl__elite ? global.fr_module_vars[$ "mod:CustomIDPDHandler"].elitefreak : global.fr_module_vars[$ "mod:CustomIDPDHandler"].freak) : (_frl__elite ? global.fr_module_vars[$ "mod:CustomIDPDHandler"].elite : global.fr_module_vars[$ "mod:CustomIDPDHandler"].standard)));
var _frl__pool = [];
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__selectPool)); _frl_i++) {
var _frl__poolOption = [];
var _frl__body = scrFRIndexGet(scrFRIndexGet(_frl__selectPool, _frl_i), 0);
var _frl__weightCheck = scrFRIndexGet(scrFRIndexGet(_frl__selectPool, _frl_i), 1);
var _frl__neededLevel = scrFRIndexGet(scrFRIndexGet(_frl__selectPool, _frl_i), 2);
;
var _frl__weight = (is_array(_frl__weightCheck) ? fr_CustomIDPDHandler_mod_gml_IDPD_checkweight(_frl__neededLevel, 0, scrFRIndexGet(_frl__weightCheck, 0), scrFRIndexGet(_frl__weightCheck, 1)) : fr_CustomIDPDHandler_mod_gml_IDPD_checkweight(_frl__neededLevel, _frl__weightCheck, undefined, undefined));
;
if ((_frl__weight > 0)) {
{
array_push(_frl__poolOption, _frl__body);
;
array_push(_frl__poolOption, _frl__weight);
;
array_push(_frl__pool, _frl__poolOption);
}
}
}
}
var _frl__popo = fr_CustomIDPDHandler_mod_gml_pool(_frl__pool);
if (scrFRInstanceExists(LilHunter)) {
{
if ((! _frl__van)) {
{
_frl__popo = [["CustomIDPDHandler", "DefaultIDPD_spawn"], ["CustomIDPDHandler", "LilHunterIDPD_create"], undefined];
;
}
}
}
}
var _frl__spawnEvent = scrFRIndexGet(_frl__popo, 0);
var _frl__createEvent = scrFRIndexGet(_frl__popo, 1);
var _frl__stepEvent = scrFRIndexGet(_frl__popo, 2);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "IDPDPortal";
;
elite = _frl__elite;
;
freak = _frl__freak;
;
van = (! (! _frl__van));
;
clear = true;
;
level = _frl__IDPDLevel;
;
friction = (0.1) * (timescale * timescale);
;
spr_strt = (van ? sprVanPortalStart : sprIDPDPortalStart);
;
spr_chrg = (van ? sprVanPortalCharge : sprIDPDPortalCharge);
;
spr_open = (van ? sprVanPortalClose : sprIDPDPortalClose);
;
spr_loop = (van ? global.fr_module_vars[$ "mod:CustomIDPDHandler"].sprVanPortal : sprPopoPortal);
;
spr_clos = (van ? global.fr_module_vars[$ "mod:CustomIDPDHandler"].sprVanPortalDisappear : sprPopoPortalDisappear);
;
spr_effx = sprIDPDPortalCharge;
;
image_speed = (0.4) * timescale;
;
depth = ((! van) ? (- 1) : (- 3));
;
glowRadius = (van ? 130 : 60);
;
bloomCount = [2, 0.1];
;
snd_warn = (van ? sndVanWarning : (elite ? sndEliteIDPDPortalSpawn : sndIDPDPortalSpawn));
;
snd_spwn = (van ? sndVanPortal : (- 1));
;
if ((GameCont.area == scrFRAreaTryResolve(101))) {
snd_warn = sndOasisPopo;
}
var _frl__portalNum = array_length(scrFRMatching(fr_CustomIDPDHandler_mod_gml_instances_named(scrFRObjectIndex(scrFRSelf(self)), name), "van", van));
;
scrFRAlarmWrite(scrFRSelf(self), 0, (40 + ((van ? 10 : 3) * _frl__portalNum)), "=");
;
var _frl_t = 0;
;
if (((GameCont.loops > 0) && (scrFRSourceRandom(3) < 2))) {
{
{ var __fr_with4 = scrFRWithValues(WantVan), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
canspawn = 1;
}
if(__fr_break6) break;
}}
;
}
}
can_step = (_frl__stepEvent != undefined);
;
if ((_frl__createEvent != undefined)) {
{
scrFRModCall("mod", scrFRIndexGet(_frl__createEvent, 0), scrFRIndexGet(_frl__createEvent, 1));
;
}
}
scrFRSoundPlay(snd_warn);
;
sprite_index = scrFRAreaSourceSprite(spr_strt);
;
if ((van && clear)) {
scrFRInstanceCreate(x, y, PortalClear);
}
on_step = fr_CustomIDPDHandler_mod_gml_IDPDPortal_step;
;
extraStep = _frl__stepEvent;
;
on_spawn = _frl__spawnEvent;
;
return real(id);
;
}
}
if(__fr_break3) break;
}}
}

// Original CustomIDPDHandler.mod.gml:167
function fr_CustomIDPDHandler_mod_gml_IDPDPortal_step() {
if (can_step) {
{
scrFRModCall("mod", scrFRIndexGet(extraStep, 0), scrFRIndexGet(extraStep, 1));
;
}
}
if ((((sprite_index == spr_chrg) && sprite_exists(spr_effx)) && frMacro_CustomIDPDHandler_mod_gml_current_frame_active)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 48), 48)), (y + scrFRSourceRandomRange((- 48), 48)), IDPDPortalCharge)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd(point_direction(x, y, __fr_other4.x, __fr_other4.y), (2 + scrFRSourceRandom(1)));
;
var __fr_other5=scrFROther(other);
scrFRAlarmWrite(scrFRSelf(self), 0, ((point_distance(x, y, __fr_other5.x, __fr_other5.y) / (speed / timescale)) + 1), "=");
;
var __fr_other6=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other6.spr_effx);
;
}
}
if(__fr_break3) break;
}}
}
}
if (fr_CustomIDPDHandler_mod_gml_scrAlarm(0)) {
{
if ((sprite_index == spr_chrg)) {
{
scrFRAlarmWrite(scrFRSelf(self), 0, 12, "=");
;
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_open);
;
}
} else {
{
scrFRModCall("mod", scrFRIndexGet(on_spawn, 0), scrFRIndexGet(on_spawn, 1));
if (clear) {
{
clear = 0;
;
if (van) {
{
var _frl_o = 32;
;
{
var _frl_a = 0;
for (; (_frl_a < 360); _frl_a += 90) {
scrFRInstanceCreate((x + lengthdir_x(_frl_o, _frl_a)), (y + lengthdir_y(_frl_o, _frl_a)), PortalClear);
;
}
}
}
} else {
scrFRInstanceCreate(x, y, PortalClear);
}
;
scrFRViewShakeAt(x, y, 8);
;
scrFRSoundPlay(snd_spwn);
;
}
}
}
}
}
}
if ((sprite_index != spr_loop)) {
{
if (((image_index + (image_speed / timescale)) > (image_number - 1))) {
{
if (((sprite_index == spr_clos) || (sprite_index == spr_open))) {
{
scrFRInstanceDestroy();
;
}
} else {
sprite_index = scrFRAreaSourceSprite(spr_chrg);
}
;
}
}
}
}
}

// Original CustomIDPDHandler.mod.gml:223
function fr_CustomIDPDHandler_mod_gml_DefaultIDPD_create() {
spawn_idpd = Grunt;
;
spawn_num = 1;
;
if (freak) {
spawn_idpd = PopoFreak;
} else {
if ((((! scrFRInstanceExists(LilHunter)) || (GameCont.loops > 0)) || elite)) {
{
var _frl_c = ["Grunt"];
var _frl_i = 0;
;
if ((level >= 3)) {
{
scrFRIndexPathWrite(_frl_c, [(++ _frl_i)], "Grunt", "=");
;
scrFRIndexPathWrite(_frl_c, [(++ _frl_i)], "Inspector", "=");
;
}
}
if ((level >= 5)) {
{
scrFRIndexPathWrite(_frl_c, [(++ _frl_i)], "Shielder", "=");
;
}
}
spawn_idpd = asset_get_index(((elite ? "Elite" : "") + scrFRIndexGet(_frl_c, scrFRSourceIRandom(_frl_i))));
;
}
}
}
if ((spawn_idpd == Grunt)) {
spawn_num = (2 + GameCont.loops);
}
}

// Original CustomIDPDHandler.mod.gml:245
function fr_CustomIDPDHandler_mod_gml_DefaultIDPD_spawn() {
repeat (spawn_num) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 2), 2)), (y + scrFRSourceRandomRange((- 2), 2)), spawn_idpd)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (4) * timescale;
;
var _frl_n = instance_nearest(x, y, Player);
;
if (scrFRInstanceExists(_frl_n)) {
direction = (point_direction(x, y, _frl_n.x, _frl_n.y) + scrFRSourceRandomRange((- 45), 45));
} else {
direction = scrFRSourceRandom(360);
}
;
}
}
if(__fr_break3) break;
}}
}
}

// Original CustomIDPDHandler.mod.gml:255
function fr_CustomIDPDHandler_mod_gml_LilHunterIDPD_create() {
spawn_idpd = Grunt;
;
spawn_num = 1;
;
if (freak) {
spawn_idpd = PopoFreak;
}
if ((spawn_idpd == Grunt)) {
spawn_num = (2 + GameCont.loops);
}
}

// Original CustomIDPDHandler.mod.gml:263
function fr_CustomIDPDHandler_mod_gml_DefaultVan_spawn() {
scrFRInstanceCreate(x, y, Van);
;
}

// Original CustomIDPDHandler.mod.gml:266
function fr_CustomIDPDHandler_mod_gml_IDPD_checkweight(_frl__popolevel=undefined, _frl__weightNum=undefined, _frl__modCheck=undefined, _frl__scriptCheck=undefined) {
var _frl__weight = 0;
;
if ((GameCont.popolevel >= _frl__popolevel)) {
{
_frl__weight = ((_frl__modCheck != undefined) ? scrFRModCall("mod", _frl__modCheck, _frl__scriptCheck) : _frl__weightNum);
;
}
}
return _frl__weight;
;
}

// Original CustomIDPDHandler.mod.gml:273
function fr_CustomIDPDHandler_mod_gml_scrAlarm(_frl__alarm=undefined) {
var _frl_a = scrFRAlarmRead(scrFRSelf(self), _frl__alarm);
;
if ((_frl_a > 0)) {
{
_frl_a -= max(1, scrFRSourceScale());
;
scrFRAlarmWrite(scrFRSelf(self), _frl__alarm, _frl_a);
;
if ((_frl_a <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), _frl__alarm, (- 1));
;
return true;
;
}
}
}
}
return false;
;
}

// Original CustomIDPDHandler.mod.gml:285
function fr_CustomIDPDHandler_mod_gml_pool(_frl__pool=undefined) {
if (is_struct(_frl__pool)) {
{
var _frl__poolNew = [];
;
{
var _frl_i = 0;
for (; (_frl_i < scrFRLQSize(_frl__pool)); _frl_i++) {
array_push(_frl__poolNew, [scrFRLQKey(_frl__pool, _frl_i), scrFRLQValue(_frl__pool, _frl_i)]);
;
}
}
_frl__pool = _frl__poolNew;
;
}
}
var _frl__roll = 0;
;
{ var __fr_with1 = scrFRWithValues(_frl__pool), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
_frl__roll += scrFRIndexGet(scrFRSelf(self), 1);
;
}
}
if(__fr_break3) break;
}}
_frl__roll -= fr_CustomIDPDHandler_mod_gml_seeded_random(((global.fr_module_vars[$ "mod:CustomIDPDHandler"].spawnedPortals + scrFRPlayerCompatSeedField("baseseed")) + 500), 0, _frl__roll, false);
if ((_frl__roll > 0)) {
{
{ var __fr_with4 = scrFRWithValues(_frl__pool), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
_frl__roll -= scrFRIndexGet(scrFRSelf(self), 1);
;
if ((_frl__roll <= 0)) {
{
return scrFRIndexGet(scrFRSelf(self), 0);
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
return undefined;
;
}

// Original CustomIDPDHandler.mod.gml:331
function fr_CustomIDPDHandler_mod_gml_seeded_random(_frl__seed=undefined, _frl__min=undefined, _frl__max=undefined, _frl__irandom=undefined) {
var _frl__lastSeed = scrFRSourceRandomGetSeed();
;
scrFRSourceRandomSetSeed((scrFRPlayerCompatSeedField("baseseed") + _frl__seed));
;
scrFRSourceRandomSetSeed(ceil((scrFRSourceRandom(100000) * scrFRSourceRandom(100000))));
;
var _frl_rand = undefined;
;
if (_frl__irandom) {
{
_frl_rand = (_frl__min + scrFRSourceIRandom((_frl__max - _frl__min)));
;
}
} else {
{
_frl_rand = (_frl__min + scrFRSourceRandom((_frl__max - _frl__min)));
;
}
}
scrFRSourceRandomSetSeed(_frl__lastSeed);
;
return _frl_rand;
;
}

// Original CustomIDPDHandler.mod.gml:344
function fr_CustomIDPDHandler_mod_gml_instances_named(_frl__inst=undefined, _frl__name=undefined) {
return scrFRMatching(_frl__inst, "name", _frl__name);
;
; // macro hoisted: current_frame_active
}
