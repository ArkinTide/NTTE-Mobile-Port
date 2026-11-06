#macro frMacro_dependencies_wibbly_mod_gml_minProjSpeedBonus 3

#macro frMacro_dependencies_wibbly_mod_gml_maxProjSpeedBonus 26

#macro frMacro_dependencies_wibbly_mod_gml_ammoMaxBonus GameCont.wib_ammoMaxBonus

#macro frMacro_dependencies_wibbly_mod_gml_ammoGainBonus GameCont.wib_ammoGainBonus

#macro frMacro_dependencies_wibbly_mod_gml_speedBonus GameCont.wib_speedBonus

#macro frMacro_dependencies_wibbly_mod_gml_reloadBonus GameCont.wib_reloadBonus

#macro frMacro_dependencies_wibbly_mod_gml_accuracyBonus GameCont.wib_accuracyBonus

#macro frMacro_dependencies_wibbly_mod_gml_projectileSpeedBonus GameCont.wib_projectileSpeedBonus

#macro frMacro_dependencies_wibbly_mod_gml_radMaxBonus GameCont.wib_radMaxBonus

// Original dependencies/wibbly.mod.gml:1
function fr_dependencies_wibbly_mod_gml___load() {

}

// Original dependencies/wibbly.mod.gml:1
function fr_dependencies_wibbly_mod_gml_init() {
scrFRTrace("WIBBLY 0.3.2 LOADED!!");
;
; // macro hoisted: minProjSpeedBonus
; // macro hoisted: maxProjSpeedBonus
; // macro hoisted: ammoMaxBonus
;
; // macro hoisted: ammoGainBonus
;
; // macro hoisted: speedBonus
;
; // macro hoisted: reloadBonus
;
; // macro hoisted: accuracyBonus
;
; // macro hoisted: projectileSpeedBonus
;
; // macro hoisted: radMaxBonus
;
global.fr_module_vars[$ "mod:wibbly"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
fr_dependencies_wibbly_mod_gml_setup_gamecont();
;
}

// Original dependencies/wibbly.mod.gml:55
function fr_dependencies_wibbly_mod_gml_setup_gamecont() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(GameCont, "wibbly", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
wibbly = true;
;
wib_ammoMaxBonus = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
;
wib_ammoGainBonus = [[0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0]];
;
wib_speedBonus = [0, 0, 0, 0];
;
wib_reloadBonus = [0, 0, 0, 0];
;
wib_accuracyBonus = [0, 0, 0, 0];
;
wib_projectileSpeedBonus = [0, 0, 0, 0];
;
wib_wantStatsController = false;
;
wib_wantProjectileController = false;
;
wib_radMaxBonus = 0;
;
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "mod:wibbly"].wantRadMaxBuffer = false;
;
}

// Original dependencies/wibbly.mod.gml:70
function fr_dependencies_wibbly_mod_gml_game_start() {
fr_dependencies_wibbly_mod_gml_setup_gamecont();
;
}

// Original dependencies/wibbly.mod.gml:73
function fr_dependencies_wibbly_mod_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "mod:wibbly"].level_start = true;
;
}
} else {
if (global.fr_module_vars[$ "mod:wibbly"].level_start) {
{
global.fr_module_vars[$ "mod:wibbly"].level_start = false;
;
fr_dependencies_wibbly_mod_gml_level_start();
;
}
}
}
if ((global.fr_module_vars[$ "mod:wibbly"].wantRadMaxBuffer == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(GameCont, "level", 10), "wib_radMaxBuffered", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_dependencies_wibbly_mod_gml_radMaxBonus_add(frMacro_dependencies_wibbly_mod_gml_radMaxBonus);
wib_radMaxBuffered = true;
;
global.fr_module_vars[$ "mod:wibbly"].wantRadMaxBuffer = false;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original dependencies/wibbly.mod.gml:91
function fr_dependencies_wibbly_mod_gml_level_start() {
fr_dependencies_wibbly_mod_gml_PlayerManager_create(10016, 10016);
;
if ((GameCont.wib_wantProjectileController == true)) {
{
fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_spawn();
;
var _frl__needController = false;
;
{
var _frl__index = 0;
for (; (_frl__index < INPUT_MAX_PLAYERS); _frl__index++) {
_frl__needController += abs(scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_projectileSpeedBonus, _frl__index));
;
}
}
if ((! _frl__needController)) {
{
GameCont.wib_wantProjectileController = false;
;
}
}
}
}
}

// Original dependencies/wibbly.mod.gml:110
function fr_dependencies_wibbly_mod_gml_ammoMaxBonus_add(_frl__index=undefined, _frl__ammoType=undefined, _frl__count=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_amax", [_frl__ammoType], _frl__count, "+=");
;
scrFRMemberIndexWrite(GameCont, "wib_ammoMaxBonus", [index, (_frl__ammoType - 1)], _frl__count, "+=");
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:117
function fr_dependencies_wibbly_mod_gml_ammoGainBonus_add(_frl__index=undefined, _frl__ammoType=undefined, _frl__count=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [_frl__ammoType], _frl__count, "+=");
;
if ((scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_ammo"), _frl__ammoType) < 1)) {
{
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [_frl__ammoType], 1, "=");
;
}
}
scrFRMemberIndexWrite(GameCont, "wib_ammoGainBonus", [index, (_frl__ammoType - 1)], _frl__count, "+=");
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:127
function fr_dependencies_wibbly_mod_gml_speedBonus_add(_frl__index=undefined, _frl__speed=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
maxspeed += (_frl__speed) * timescale;
;
if ((((maxspeed / timescale) != 0) && ((maxspeed / timescale) < 2.1))) {
{
maxspeed = (2.1) * timescale;
;
}
}
scrFRMemberIndexWrite(GameCont, "wib_speedBonus", [index], _frl__speed, "+=");
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:137
function fr_dependencies_wibbly_mod_gml_reloadBonus_add(_frl__index=undefined, _frl__bonus=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
reloadspeed += _frl__bonus;
;
if ((reloadspeed < 0.05)) {
{
reloadspeed = 0.05;
;
}
}
scrFRMemberIndexWrite(GameCont, "wib_reloadBonus", [index], _frl__bonus, "+=");
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:147
function fr_dependencies_wibbly_mod_gml_accuracyBonus_add(_frl__index=undefined, _frl__bonus=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
accuracy -= _frl__bonus;
;
if ((accuracy < 0)) {
{
accuracy = 0;
;
}
}
scrFRMemberIndexWrite(GameCont, "wib_accuracyBonus", [index], _frl__bonus, "+=");
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:157
function fr_dependencies_wibbly_mod_gml_projectileSpeedBonus_add(_frl__index=undefined, _frl__bonus=undefined) {
var _frl__player = ((_frl__index == (- 1)) ? Player : scrFRMatching(Player, "index", _frl__index));
;
{ var __fr_with1 = scrFRWithValues(_frl__player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRMemberIndexWrite(GameCont, "wib_projectileSpeedBonus", [index], _frl__bonus, "+=");
;
}
}
if(__fr_break3) break;
}}
fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_spawn();
;
}

// Original dependencies/wibbly.mod.gml:164
function fr_dependencies_wibbly_mod_gml_radMaxBonus_add(_frl__bonus=undefined) {
frMacro_dependencies_wibbly_mod_gml_radMaxBonus += _frl__bonus;
;
if ((GameCont.level != 10)) {
{
global.fr_module_vars[$ "mod:wibbly"].wantRadMaxBuffer = true;
;
}
} else {
{
GameCont.radmaxextra += _frl__bonus;
if ((frMacro_dependencies_wibbly_mod_gml_radMaxBonus < (- 580))) {
{
GameCont.radmaxextra = (- 580);
;
}
}
}
}
}

// Original dependencies/wibbly.mod.gml:176
function fr_dependencies_wibbly_mod_gml_ammoMaxBonus_add_raw(_frl__index=undefined, _frl__ammoType=undefined, _frl__count=undefined) {
scrFRMemberIndexWrite(GameCont, "wib_ammoMaxBonus", [_frl__index, (_frl__ammoType - 1)], _frl__count, "+=");
;
}

// Original dependencies/wibbly.mod.gml:179
function fr_dependencies_wibbly_mod_gml_ammoGainBonus_add_raw(_frl__index=undefined, _frl__ammoType=undefined, _frl__count=undefined) {
scrFRMemberIndexWrite(GameCont, "wib_ammoGainBonus", [_frl__index, (_frl__ammoType - 1)], _frl__count, "+=");
;
}

// Original dependencies/wibbly.mod.gml:182
function fr_dependencies_wibbly_mod_gml_speedBonus_add_raw(_frl__index=undefined, _frl__speed=undefined) {
scrFRMemberIndexWrite(GameCont, "wib_speedBonus", [_frl__index], _frl__speed, "+=");
;
}

// Original dependencies/wibbly.mod.gml:185
function fr_dependencies_wibbly_mod_gml_reloadBonus_add_raw(_frl__index=undefined, _frl__bonus=undefined) {
scrFRMemberIndexWrite(GameCont, "wib_reloadBonus", [_frl__index], _frl__bonus, "+=");
;
}

// Original dependencies/wibbly.mod.gml:188
function fr_dependencies_wibbly_mod_gml_accuracyBonus_add_raw(_frl__index=undefined, _frl__bonus=undefined) {
scrFRMemberIndexWrite(GameCont, "wib_accuracyBonus", [_frl__index], _frl__bonus, "+=");
;
}

// Original dependencies/wibbly.mod.gml:200
function fr_dependencies_wibbly_mod_gml_PlayerManager_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "wib_PlayerManager";
;
prev_muscle = scrFRGetSkill(mut_back_muscle);
;
livingPlayers = [array_length(scrFRMatching(Player, "index", 0)), array_length(scrFRMatching(Player, "index", 1)), array_length(scrFRMatching(Player, "index", 2)), array_length(scrFRMatching(Player, "index", 3))];
;
playerX = [_frl__x, _frl__x, _frl__x, _frl__x];
;
playerY = [_frl__y, _frl__y, _frl__y, _frl__y];
;
playerRace = ["", "", "", ""];
;
on_step = fr_dependencies_wibbly_mod_gml_PlayerManager_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:220
function fr_dependencies_wibbly_mod_gml_PlayerManager_step() {
if ((prev_muscle != scrFRGetSkill(mut_back_muscle))) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__ammoType = 1;
;
repeat (5) {
scrFRAmmoBonusSet(scrFRSelf(self), "typ_amax", [_frl__ammoType], scrFRIndexGet(scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_ammoMaxBonus, index), (_frl__ammoType - 1)));
;
if ((scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), _frl__ammoType) < 1)) {
{
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_amax", [_frl__ammoType], 1, "=");
;
}
}
_frl__ammoType += 1;
;
}
}
}
if(__fr_break3) break;
}}
prev_muscle = scrFRGetSkill(mut_back_muscle);
;
}
}
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
scrFRMemberIndexWrite(__fr_other7, "playerX", [index], x, "=");
;
var __fr_other8=scrFROther(other);
scrFRMemberIndexWrite(__fr_other8, "playerY", [index], y, "=");
;
var __fr_other9=scrFROther(other);
scrFRMemberIndexWrite(__fr_other9, "playerRace", [index], scrFRRaceKey(race), "=");
;
}
}
if(__fr_break6) break;
}}
{
var _frl__index = 0;
for (; (_frl__index < INPUT_MAX_PLAYERS); _frl__index++) {
if ((array_length(scrFRMatching(Player, "index", _frl__index)) == 0)) {
{
if ((scrFRIndexGet(livingPlayers, _frl__index) != 0)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "livingPlayers", [_frl__index], 0, "=");
;
if (scrFRModLoaded("mod", "Frontier_Main")) {
{
if ((! GameCont.win)) {
{
if ((is_string(scrFRIndexGet(playerRace, _frl__index)) && scrFRScriptExists("race", scrFRIndexGet(playerRace, _frl__index), "race_frontier"))) {
{
scrFRModCall("mod", "Frontier_Main", "frontier_race_deathstat", scrFRIndexGet(playerRace, _frl__index));
;
}
}
if ((scrFRArrayFindIndex(playerRace, "robot") != (- 1))) {
{
if ((! scrFRInstanceExists(Player))) {
{
scrFRModCall("area", "cyberspace", "cyberspace_revive", scrFRArrayFindIndex(playerRace, "robot"));
;
}
}
}
}
}
} else {
{
if ((is_string(scrFRIndexGet(playerRace, _frl__index)) && scrFRScriptExists("race", scrFRIndexGet(playerRace, _frl__index), "race_frontier"))) {
{
scrFRModCall("mod", "Frontier_Main", "frontier_race_winstat", scrFRIndexGet(playerRace, _frl__index));
;
}
}
}
}
}
}
if (scrFRModLoaded("mod", "Trinkets")) {
{
if ((! GameCont.win)) {
{
scrFRModCall("mod", "Trinkets", "drop_my_items_please", _frl__index, scrFRIndexGet(playerX, _frl__index), scrFRIndexGet(playerY, _frl__index));
;
}
}
}
}
}
}
}
} else {
{
if ((scrFRIndexGet(livingPlayers, _frl__index) == 0)) {
{
{ var __fr_with10 = scrFRWithValues(scrFRMatching(Player, "index", _frl__index)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
// BEGIN FRONTIER CYBERSPACE RESPAWN ENTRY
scrFRCyberspaceRespawnBegin(id);
// END FRONTIER CYBERSPACE RESPAWN ENTRY
var _frl__ammoType = 1;
;
repeat (5) {
scrFRAmmoBonusSet(scrFRSelf(self), "typ_amax", [_frl__ammoType], scrFRIndexGet(scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_ammoMaxBonus, index), (_frl__ammoType - 1)));
;
scrFRAmmoBonusSet(scrFRSelf(self), "typ_ammo", [_frl__ammoType], scrFRIndexGet(scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_ammoGainBonus, index), (_frl__ammoType - 1)));
;
_frl__ammoType += 1;
;
}
maxspeed += (scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_speedBonus, index)) * timescale;
;
reloadspeed += scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_reloadBonus, index);
;
accuracy -= scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_accuracyBonus, index);
;
if ((accuracy < 0)) {
{
accuracy = 0;
;
}
}
// BEGIN FRONTIER CYBERSPACE RESPAWN TOTALS
scrFRCyberspaceRespawnReady(id);
// END FRONTIER CYBERSPACE RESPAWN TOTALS
}
}
if(__fr_break12) break;
}}
}
}
scrFRMemberIndexWrite(scrFRSelf(self), "livingPlayers", [_frl__index], 1, "=");
;
}
}
}
}
}

// Original dependencies/wibbly.mod.gml:309
function fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_spawn() {
if ((array_length(scrFRMatching(FRCustomObject, "name", "wib_ProjectileSpeedController")) == 0)) {
{
fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_create(10016, 10016);
;
GameCont.wib_wantProjectileController = true;
;
}
}
}

// Original dependencies/wibbly.mod.gml:315
function fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "wib_ProjectileSpeedController";
;
on_step = fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/wibbly.mod.gml:324
function fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_step_resume, id, scrFROther(other), _args, 21, []);
}
function fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_wibbly_mod_gml_ProjectileSpeedController_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/wibbly.mod.gml:326
scrFRTaskWithNext(_fr);
break;
case 2: // dependencies/wibbly.mod.gml:326
scrFRTaskWithAbort(_fr);
break;
case 3: // dependencies/wibbly.mod.gml:331
scrFRTaskWithNext(_fr);
break;
case 4: // dependencies/wibbly.mod.gml:331
scrFRTaskWithAbort(_fr);
break;
case 5: // dependencies/wibbly.mod.gml:368
{
;
}
_fr.pc=3;
break;
case 6: // dependencies/wibbly.mod.gml:368
_fr.result=undefined; _fr.done=true; return;
break;
case 8: // dependencies/wibbly.mod.gml:366
{
;
}
_fr.pc=7;
break;
case 9: // dependencies/wibbly.mod.gml:366
_fr.wait_ticks=max(0,0); _fr.pc=8; return;
break;
case 10: // dependencies/wibbly.mod.gml:365
{
speed = (_fr.vars._newSpeed) * timescale;
}
_fr.pc=9;
break;
case 7: // dependencies/wibbly.mod.gml:364
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?10:6;
break;
case 11: // dependencies/wibbly.mod.gml:363
_fr.pc = (scrFRTaskFork(_fr, 7)) ? 7 : 3;
break;
case 12: // dependencies/wibbly.mod.gml:347
{
{ var __fr_switch_value1=scrFRObjectIndex(scrFRSelf(self)), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(PlasmaBall)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Seeker)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Nuke)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(PlasmaBig)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(PlasmaHuge)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Rocket)) __fr_switch_case2=5;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:

case 1:

case 2:
_fr.vars._ogSpeed = 7;
;
break;
;
case 3:

case 4:
_fr.vars._ogSpeed = 6;
;
break;
;
case 5:
_fr.vars._ogSpeed = 12;
;
break;
;
}
}
_fr.vars._newSpeed = clamp((_fr.vars._ogSpeed * (1 + _fr.vars._speedBonus)), frMacro_dependencies_wibbly_mod_gml_minProjSpeedBonus, frMacro_dependencies_wibbly_mod_gml_maxProjSpeedBonus);
;
}
_fr.pc=11;
break;
case 13: // dependencies/wibbly.mod.gml:346
_fr.pc = ((scrFRArrayFindIndex([Nuke, Rocket, PlasmaBall, PlasmaBig, PlasmaHuge], scrFRObjectIndex(_fr.scope)) + 1)) ? 12 : 3;
break;
case 14: // dependencies/wibbly.mod.gml:334
{
if ((scrFRArrayFindIndex([TangleSeed, FR_OBJECT_THROWN_WEP, HorrorBullet, ToxicGas, Laser, EnemyLaser, Slash, LightningSlash, EnergySlash, EnergyHammerSlash, BloodSlash, Shank, EnergyShank, FR_OBJECT_GUITAR_SLASH], scrFRObjectIndex(scrFRSelf(self))) == (- 1))) {
{
_fr.vars._ogSpeed = (speed / timescale);
_fr.vars._speedBonus = scrFRIndexGet(frMacro_dependencies_wibbly_mod_gml_projectileSpeedBonus, _fr.vars._index);
_fr.vars._newSpeed = _fr.vars._ogSpeed;
;
if (((_fr.vars._ogSpeed > 0) && (_fr.vars._ogSpeed < frMacro_dependencies_wibbly_mod_gml_maxProjSpeedBonus))) {
{
_fr.vars._newSpeed = clamp((_fr.vars._ogSpeed * (1 + _fr.vars._speedBonus)), frMacro_dependencies_wibbly_mod_gml_minProjSpeedBonus, frMacro_dependencies_wibbly_mod_gml_maxProjSpeedBonus);
;
}
}
speed = (_fr.vars._newSpeed) * timescale;
;
}
}
}
_fr.pc=13;
break;
case 15: // dependencies/wibbly.mod.gml:333
_fr.pc = (((!scrFRVariableExists(scrFRSelf(_fr.scope), "is_melee")) || (is_melee == false))) ? 14 : 3;
break;
case 16: // dependencies/wibbly.mod.gml:332
{
wib_projspeed = true;
;
}
_fr.pc=15;
break;
case 17: // dependencies/wibbly.mod.gml:331
scrFRTaskWithEnter(_fr,scrFRWithValues(_fr.vars._proj),16,1);
break;
case 18: // dependencies/wibbly.mod.gml:330
_fr.pc = (array_length(_fr.vars._proj)) ? 17 : 1;
break;
case 19: // dependencies/wibbly.mod.gml:327
{
_fr.vars._proj = scrFRMatching(scrFRMatching(projectile, "wib_projspeed", undefined), "creator", scrFRSelf(self).id);
_fr.vars._index = index;
;
}
_fr.pc=18;
break;
case 20: // dependencies/wibbly.mod.gml:326
scrFRTaskWithEnter(_fr,scrFRWithValues(Player),19,0);
break;
case 21: // dependencies/wibbly.mod.gml:325
_fr.pc = (scrFRInstanceExists(projectile)) ? 20 : 0;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}
