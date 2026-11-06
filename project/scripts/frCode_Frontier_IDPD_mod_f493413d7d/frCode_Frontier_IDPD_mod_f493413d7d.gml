#macro frMacro_Objects_Frontier_IDPD_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_IDPD"].scr

#macro frMacro_Objects_Frontier_IDPD_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_IDPD_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_IDPD_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_IDPD_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_IDPD_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_IDPD_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_IDPD_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_IDPD_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_IDPD.mod.gml:1
function fr_Objects_Frontier_IDPD_mod_gml___load() {

}

// Original Objects/Frontier_IDPD.mod.gml:1
function fr_Objects_Frontier_IDPD_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_IDPD_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_IDPD_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_IDPD_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_IDPD.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_IDPD", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_IDPD"].settingMainPoolAugments = false;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].settingNewIDPD = true;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sndStrikerWarning = sndFR_sndStrikerWarning_583680f63ed0;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sndStrikerFly = sndFR_sndStrikerFly_08d33590d901;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStation = sprFR_sprAugmentStation_10f611fa8f1a;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationOpen = sprFR_sprAugmentStationOpen_5243b3913a7d;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationDeny = sprFR_sprAugmentStationDeny_6f2405db3ab1;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationHolo = sprFR_sprAugmentStationHolo_4619fee31ca8;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationFloor = sprFR_sprAugmentStationFloor_c2bd776164bd;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolith = sprFR_sprAugmentMonolith_1558e648b754;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolithHurt = sprFR_sprAugmentMonolithHurt_5a60e008864d;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolithDead = sprFR_sprAugmentMonolithDead_d18fe6c79d1f;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSparkles = sprFR_sprPopoSparkles_8da9757fb6ed;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentTextBackground = sprFR_sprAugmentTextBackground_835998b84cec;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPortalBig = sprFR_sprPopoPortalBig_ec2fbb4ab805;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPortalBigClose = sprFR_sprPopoPortalBigClose_963e3d02918f;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPortalBigDisappear = sprFR_sprPopoPortalBigDisappea_92c09eee9000;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprHQExit = sprFR_sprHQExit_82d263c40a32;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielPortal = sprFR_sprPopoBaraquielPortal_90cdab56fc3b;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielSpotlight = sprFR_sprPopoBaraquielSpotligh_7b93114d4a4e;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielRingFront = sprFR_sprPopoBaraquielRingFron_f0ef5501a007;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielRingBack = sprFR_sprPopoBaraquielRingBack_2b39c844027d;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielGameover = sprFR_sprPopoBaraquielGameover_389720a8cabb;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].mskPopoBaraquiel = sprFR_mskPopoBaraquiel_0654899805ab;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielIdle = sprFR_sprPopoBaraquielIdle_9f629c0bf05c;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielHurt = sprFR_sprPopoBaraquielHurt_0d514dcccd59;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielFly = sprFR_sprPopoBaraquielFly_fefa19a8ec6a;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryIdle = sprFR_sprPopoBatteryIdle_11181b110861;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryHurt = sprFR_sprPopoBatteryHurt_d79de64ad540;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryDead = sprFR_sprPopoBatteryDead_496d80440f00;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStriker = sprFR_sprPopoStriker_426e8a2d4f4b;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerPath = sprFR_sprPopoStrikerPath_645cd31f8d65;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerGameover = sprFR_sprPopoStrikerGameover_3f1936921b5c;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerFlame = sprFR_sprPopoStrikerFlame_6362a3051bc7;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotIdle = sprFR_sprPopoMaggotIdle_bdd8ae47df4c;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotHurt = sprFR_sprPopoMaggotHurt_e0b02e13356b;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotDead = sprFR_sprPopoMaggotDead_63692dcdee49;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeam = sprFR_sprPopoSkybeam_1fa6ff225042;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamEnd = sprFR_sprPopoSkybeamEnd_ac9498c55df8;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamTrail = sprFR_sprPopoSkybeamTrail_466922ff1598;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamEndTrail = sprFR_sprPopoSkybeamEndTrail_34800b5dad70;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamWarning = sprFR_sprPopoSkybeamWarning_1b0f4a62a8da;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamWarningBlink = sprFR_sprPopoSkybeamWarningBli_1090caf2886b;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].mskPlasmaImpactSmall = sprFR_mskPlasmaImpactSmall_b15df2b8d4a6;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPlasmaSmall = sprFR_sprPopoPlasmaSmall_3dda7a66f385;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPlasmaImpactSmall = sprFR_sprPopoPlasmaImpactSmall_72e76736877e;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoExplosionSmall = sprFR_sprPopoExplosionSmall_9e8ad8a5e3c3;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStreak = sprFR_sprPopoStreak_123be509616c;
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_deactivemuts_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_spawnedaugments_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_deactivemuts_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_og_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike = (- 4);
;
_fr.vars._allMuts = scrFRModNames("skill");
;
{ var __fr_with1 = scrFRWithValues(_fr.vars._allMuts), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRModLoaded("skill", scrFRSelf(self)) && scrFRScriptExists("skill", scrFRSelf(self), "skill_augment"))) {
{
_fr.vars._push = true;
;
_fr.vars._ogSkill = scrFRModCall("skill", scrFRSelf(self), "skill_augment");
;
if (is_string(_fr.vars._ogSkill)) {
{
if ((! scrFRModLoaded("skill", _fr.vars._ogSkill))) {
{
_fr.vars._push = false;
;
}
}
}
}
if ((_fr.vars._push == true)) {
{
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array, scrFRSelf(self));
;
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_og_array, scrFRModCall("skill", scrFRSelf(self), "skill_augment"));
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_IDPD.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_IDPD.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_IDPD.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_IDPD.mod.gml:115
function fr_Objects_Frontier_IDPD_mod_gml_cleanup() {
if (surface_exists(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike)) {
{
surface_free(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike);
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:120
function fr_Objects_Frontier_IDPD_mod_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_deactivemuts_array), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSkillSetActive(scrFRSelf(self), 1);
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_deactivemuts_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_spawnedaugments_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array = [];
;
global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_og_array = [];
;
var _frl__allMuts = scrFRModNames("skill");
;
{ var __fr_with4 = scrFRWithValues(_frl__allMuts), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRModLoaded("skill", scrFRSelf(self)) && scrFRScriptExists("skill", scrFRSelf(self), "skill_augment"))) {
{
var _frl__push = true;
;
var _frl__ogSkill = scrFRModCall("skill", scrFRSelf(self), "skill_augment");
;
if (is_string(_frl__ogSkill)) {
{
if ((! scrFRModLoaded("skill", _frl__ogSkill))) {
{
_frl__push = false;
;
}
}
}
}
if ((_frl__push == true)) {
{
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array, scrFRSelf(self));
;
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_og_array, scrFRModCall("skill", scrFRSelf(self), "skill_augment"));
;
}
}
}
}
}
}
if(__fr_break6) break;
}}
fr_Objects_Frontier_IDPD_mod_gml_customIDPD_import();
;
}

// Original Objects/Frontier_IDPD.mod.gml:160
function fr_Objects_Frontier_IDPD_mod_gml_customIDPD_import() {
if ((global.fr_module_vars[$ "mod:Frontier_IDPD"].settingNewIDPD == true)) {
{
var _frl__knownMods = scrFRModGet("mod", "CustomIDPDHandler", "knownMods");
var _frl__knownIndex = 0;
var _frl__seeMe = 0;
;
repeat (array_length(_frl__knownMods)) {
if ((scrFRIndexGet(_frl__knownMods, _frl__knownIndex) == "Frontier_IDPD")) {
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
array_push(_frl__knownMods, "Frontier_IDPD");
;
scrFRModSet("mod", "CustomIDPDHandler", "knownMods", _frl__knownMods);
scrFRModCall("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", "elite", 92, ["Frontier_IDPD", "Baraquiel_elitecheck"], ["Frontier_IDPD", "Baraquiel_spawn"], ["Frontier_IDPD", "Baraquiel_create"], undefined);
;
scrFRModCall("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", "freak", 92, ["Frontier_IDPD", "Baraquiel_freakcheck"], ["Frontier_IDPD", "Baraquiel_spawn"], ["Frontier_IDPD", "Baraquiel_create"], undefined);
;
scrFRModCall("mod", "CustomIDPDHandler", "CustomIDPDSpawn_add", "elitefreak", 92, ["Frontier_IDPD", "Baraquiel_elitefreakcheck"], ["Frontier_IDPD", "Baraquiel_spawn"], ["Frontier_IDPD", "Baraquiel_create"], undefined);
;
}
}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:205
function fr_Objects_Frontier_IDPD_mod_gml_Baraquiel_create() {
spr_open = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPortalBigClose;
;
}

// Original Objects/Frontier_IDPD.mod.gml:208
function fr_Objects_Frontier_IDPD_mod_gml_Baraquiel_spawn() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_create((x + scrFRSourceRandomRange((- 2), 2)), (y + scrFRSourceRandomRange((- 2), 2)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (4) * timescale;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:213
function fr_Objects_Frontier_IDPD_mod_gml_Baraquiel_elitecheck() {
var _frl__weight = (((global.fr_module_vars[$ "mod:Frontier_IDPD"].settingNewIDPD == true) && (GameCont.loops >= 2)) ? 15 : 0);
;
return _frl__weight;
;
}

// Original Objects/Frontier_IDPD.mod.gml:217
function fr_Objects_Frontier_IDPD_mod_gml_Baraquiel_freakcheck() {
var _frl__weight = (((global.fr_module_vars[$ "mod:Frontier_IDPD"].settingNewIDPD == true) && (GameCont.loops >= 2)) ? 8 : 0);
;
return _frl__weight;
;
}

// Original Objects/Frontier_IDPD.mod.gml:221
function fr_Objects_Frontier_IDPD_mod_gml_Baraquiel_elitefreakcheck() {
var _frl__weight = (((global.fr_module_vars[$ "mod:Frontier_IDPD"].settingNewIDPD == true) && (GameCont.loops >= 2)) ? 10 : 0);
;
return _frl__weight;
;
}

// Original Objects/Frontier_IDPD.mod.gml:228
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AugmentStation";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStation;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationOpen;
;
spr_deny = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationDeny;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationOpen;
;
holocolor = make_colour_rgb(0, 255, 255);
;
spr_shadow = shd32;
;
spr_shadow_y = 20;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
hitid = [sprite_index, "Augment Station"];
;
depth = (- 1);
;
snd_hurt = sndHitPlant;
;
snd_dead = (- 1);
;
mask_index = mskWepPickup;
;
mytext = scrFRLocalize("");
;
opened = false;
;
pick = (- 1);
;
oldskill = mut_rhino_skin;
;
newskill = "AugmentExample";
;
augmentname = "AUGMENT NAME";
;
description = "@sAUGMENT DESCRIPTION";
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_IDPD_mod_gml_AugmentStationPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
on_step = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_step];
;
on_end_step = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_end_step];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:275
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_spawn(_frl__x=undefined, _frl__y=undefined) {
var _frl__augmentList = {};
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array)); _frl_i++) {
scrFRLQSet(_frl__augmentList, scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array, _frl_i), ((scrFRGetSkill(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_og_array, _frl_i)) > 0) & (! (scrFRArrayFindIndex(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_spawnedaugments_array, scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array, _frl_i)) > (- 1)))));
;
}
}
var _frl__myAugment = ((scrFRLQSize(_frl__augmentList) > 0) ? frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.pool, _frl__augmentList) : undefined);
;
var _frl_sexy_big_balls = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_augments_array) - 1)));
;
if ((_frl__myAugment == undefined)) {
{
_frl__myAugment = scrFRSourceChoose(_frl_sexy_big_balls);
}
}
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_spawnedaugments_array, _frl__myAugment);
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
augment = _frl__myAugment;
;
newskill = augment;
;
augmentname = scrFRModCall("skill", augment, "skill_name");
description = scrFRModCall("skill", augment, "skill_text");
oldskill = scrFRModCall("skill", augment, "skill_augment");
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:306
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStationPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = 1;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
if ((creator.opened == true)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:319
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_step_resume, id, scrFROther(other), _args, 34, []);
}
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_IDPD.mod.gml:365
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_IDPD.mod.gml:365
scrFRTaskWithAbort(_fr);
break;
case 4: // Objects/Frontier_IDPD.mod.gml:370
_fr.vars.__fr_repeat1--; _fr.pc=3;
break;
case 6: // Objects/Frontier_IDPD.mod.gml:372
_fr.vars.__fr_repeat2--; _fr.pc=5;
break;
case 7: // Objects/Frontier_IDPD.mod.gml:373
scrFRTaskWithNext(_fr);
break;
case 8: // Objects/Frontier_IDPD.mod.gml:373
scrFRTaskWithAbort(_fr);
break;
case 9: // Objects/Frontier_IDPD.mod.gml:376
{
;
}
_fr.pc=7;
break;
case 10: // Objects/Frontier_IDPD.mod.gml:376
_fr.wait_ticks=max(0,1); _fr.pc=9; return;
break;
case 11: // Objects/Frontier_IDPD.mod.gml:374
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSparkles, sprPopoPlasmaTrail, sprIDPDPortalCharge));
var __fr_other3=scrFROther(other);
scrFRMotionAdd(point_direction(x, y, __fr_other3.x, __fr_other3.y), (3 + scrFRSourceRandom(1)));
;
}
_fr.pc=10;
break;
case 12: // Objects/Frontier_IDPD.mod.gml:373
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 32), 32)), (y + scrFRSourceRandomRange((- 32), 32)), PlasmaTrail)),11,6);
break;
case 5: // Objects/Frontier_IDPD.mod.gml:372
_fr.pc=(_fr.vars.__fr_repeat2>0)?12:4;
break;
case 13: // Objects/Frontier_IDPD.mod.gml:372
_fr.vars.__fr_repeat2=round(2); _fr.pc=5;
break;
case 14: // Objects/Frontier_IDPD.mod.gml:371
{
;
}
_fr.pc=13;
break;
case 15: // Objects/Frontier_IDPD.mod.gml:371
_fr.result=undefined; _fr.done=true; return;
break;
case 16: // Objects/Frontier_IDPD.mod.gml:371
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 15 : 13;
break;
case 3: // Objects/Frontier_IDPD.mod.gml:370
_fr.pc=(_fr.vars.__fr_repeat1>0)?16:1;
break;
case 17: // Objects/Frontier_IDPD.mod.gml:370
_fr.vars.__fr_repeat1=round(5); _fr.pc=3;
break;
case 18: // Objects/Frontier_IDPD.mod.gml:366
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = make_colour_rgb(0, 255, 255);
;
depth = (- 3);
;
}
}
if(__fr_break6) break;
}}
}
_fr.pc=17;
break;
case 19: // Objects/Frontier_IDPD.mod.gml:365
scrFRTaskWithEnter(_fr,scrFRWithValues(Player),18,0);
break;
case 20: // Objects/Frontier_IDPD.mod.gml:338
{
opened = true;
;
sprite_index = scrFRAreaSourceSprite(spr_open);
;
name = "fr_AugmentStationOpened";
;
_fr.vars._stack = scrFRGetSkill(oldskill);
;
scrFRSetSkill(oldskill, 0);
;
scrFRSkillSetActive(oldskill, 0);
;
array_push(global.fr_module_vars[$ "mod:Frontier_IDPD"].fr_deactivemuts_array, oldskill);
;
scrFRSetSkill(newskill, _fr.vars._stack);
;
frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.save_set, "Frontier", "augments_taken", (frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.save_get, "Frontier", "augments_taken") + 1));
;
scrFRSoundPitchVolume(sndIDPDNadeLoad, 1.6, 1);
scrFRSoundPitchVolume(sndRogueCanister, 1.1, 1);
}
_fr.pc=19;
break;
case 21: // Objects/Frontier_IDPD.mod.gml:393
{
holocolor = make_colour_rgb(0, 255, 255);
}
_fr.pc=0;
break;
case 22: // Objects/Frontier_IDPD.mod.gml:392
{
;
}
_fr.pc=21;
break;
case 23: // Objects/Frontier_IDPD.mod.gml:392
_fr.result=undefined; _fr.done=true; return;
break;
case 24: // Objects/Frontier_IDPD.mod.gml:392
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 23 : 21;
break;
case 25: // Objects/Frontier_IDPD.mod.gml:391
_fr.wait_ticks=max(0,3); _fr.pc=24; return;
break;
case 26: // Objects/Frontier_IDPD.mod.gml:390
{
scrFRSoundPitchVolume(sndSwapGuitar, 1.6, 1);
}
_fr.pc=25;
break;
case 27: // Objects/Frontier_IDPD.mod.gml:389
{
;
}
_fr.pc=26;
break;
case 28: // Objects/Frontier_IDPD.mod.gml:389
_fr.result=undefined; _fr.done=true; return;
break;
case 29: // Objects/Frontier_IDPD.mod.gml:389
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 28 : 26;
break;
case 30: // Objects/Frontier_IDPD.mod.gml:388
_fr.wait_ticks=max(0,3); _fr.pc=29; return;
break;
case 31: // Objects/Frontier_IDPD.mod.gml:384
{
pick = (- 1);
;
holocolor = c_red;
;
sprite_index = scrFRAreaSourceSprite(spr_deny);
;
scrFRSoundPitchVolume(sndComputerBreak, 1.6, 1);
}
_fr.pc=30;
break;
case 32: // Objects/Frontier_IDPD.mod.gml:335
_fr.pc = ((scrFRGetSkill(oldskill) && (array_length(scrFRMatching(scrFRMatchingNE(FRCustomObject, "star_scale", undefined), "skill", oldskill)) <= 0))) ? 20 : 31;
break;
case 33: // Objects/Frontier_IDPD.mod.gml:334
_fr.pc = (((pick != (- 1)) && (opened == false))) ? 32 : 0;
break;
case 34: // Objects/Frontier_IDPD.mod.gml:320
{
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((frMacro_Objects_Frontier_IDPD_mod_gml_anim_end && (opened == false))) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((frMacro_Objects_Frontier_IDPD_mod_gml_anim_end && (opened == true))) {
{
sprite_index = scrFRAreaSourceSprite(spr_open);
;
}
}
}
_fr.pc=33;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_IDPD.mod.gml:399
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_end_step() {
var _frl__fade = 0;
;
if ((opened == false)) {
{
if (instance_place(x, y, Player)) {
{
scrFRBindDraw(fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_text, (- 1000), x, y, augmentname, description, oldskill);
;
_frl__fade = 1;
;
}
}
scrFRBindDraw(fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_effects, (- 10), x, y, newskill, _frl__fade, holocolor);
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:412
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_effects(_frl__x=undefined, _frl__y=undefined, _frl__newskill=undefined, _frl__fadeIn=undefined, _frl__holoColor=undefined) {
var _frl__bob = (sin((scrFRSourceFrame() * 0.1)) * 2);
var _frl__rotBob = (sin((scrFRSourceFrame() * 0.2)) * 8);
var _frl__holoBob = (sin((scrFRSourceFrame() * 0.05)) * 0.15);
var _frl__icon = frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.skill_get_icon, _frl__newskill);
var _frl__spr = scrFRIndexGet(_frl__icon, 0);
var _frl__img = scrFRIndexGet(_frl__icon, 1);
;
scrFRInstanceDestroy();
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationHolo, 1, _frl__x, _frl__y, (1 + _frl__holoBob), 1, 0, _frl__holoColor, 0.4);
scrFRDrawSpriteExt(_frl__spr, _frl__img, _frl__x, ((_frl__y - 32) + _frl__bob), 1, 1, (0 + _frl__rotBob), c_white, (0.6 + _frl__fadeIn));
}

// Original Objects/Frontier_IDPD.mod.gml:424
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStation_text(_frl__x=undefined, _frl__y=undefined, _frl__augmentname=undefined, _frl__description=undefined, _frl__oldSkill=undefined, _frl__player=undefined) {
scrFRInstanceDestroy();
;
var _frl__bob = (sin((scrFRSourceFrame() * 0.1)) * 1);
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
var _frl__descriptionLength = scrFRStringWidth(_frl__description);
var _frl__nameLength = string_length(_frl__augmentname);
var _frl__textLength = max((4 * _frl__nameLength), (0.09 * _frl__descriptionLength));
;
var _frl__yoff = ((67 + (6 * round((string_count("#", _frl__description) + 1)))) + _frl__bob);
var _frl__replacey = ((_frl__yoff - (6 * round((string_count("#", _frl__description) + 1)))) - 13);
var _frl__xtextoff = 0;
var _frl__bg_xscale = (3 + _frl__textLength);
var _frl__bg_yscale = (20 + (3 * round(string_count("#", _frl__description))));
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentTextBackground, 2, (_frl__x + _frl__xtextoff), ((_frl__y - _frl__yoff) + 8), _frl__bg_xscale, _frl__bg_yscale, 0, c_white, 0.3);
draw_set_font(fntSmall);
;
draw_set_halign(1);
draw_set_valign(0);
scrFRDrawText((_frl__x + _frl__xtextoff), (_frl__y - _frl__yoff), _frl__description);
draw_set_font(fntM1);
;
draw_set_valign(2);
scrFRDrawText((_frl__x + _frl__xtextoff), ((_frl__y - _frl__yoff) - 1), _frl__augmentname);
scrFRDrawText(((_frl__x + _frl__xtextoff) - 8), (_frl__y - _frl__replacey), "REPLACES");
var _frl__icon = frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.skill_get_icon, _frl__oldSkill);
var _frl__spr = scrFRIndexGet(_frl__icon, 0);
var _frl__img = scrFRIndexGet(_frl__icon, 1);
;
scrFRDrawSprite(_frl__spr, _frl__img, ((_frl__x + _frl__xtextoff) + 33), ((_frl__y - _frl__replacey) - 4));
draw_set_halign(_frl__halign);
draw_set_valign(_frl__valign);
}

// Original Objects/Frontier_IDPD.mod.gml:462
function fr_Objects_Frontier_IDPD_mod_gml_AugmentStationFloor_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AugmentStationFloor";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentStationFloor);
;
mask_index = mskNone;
;
image_speed = (0) * timescale;
;
depth = 8;
;
speed = (0) * timescale;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:473
function fr_Objects_Frontier_IDPD_mod_gml_AugmentMonolith_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_augmentmonolith";
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolith;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolithHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprAugmentMonolithDead;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
scrFRMaxHealthWrite(id, 35, "=");
;
hp = max_hp;
;
team = 3;
;
on_step = fr_Objects_Frontier_IDPD_mod_gml_AugmentMonolith_step;
;
on_death = fr_Objects_Frontier_IDPD_mod_gml_AugmentMonolith_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:500
function fr_Objects_Frontier_IDPD_mod_gml_AugmentMonolith_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSparkles, sprPopoPlasmaTrail));
direction = (scrFRSourceChoose(45, 135, 225, 315) + scrFRSourceRandomRange((- 10), 10));
speed = (4) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:513
function fr_Objects_Frontier_IDPD_mod_gml_AugmentMonolith_destroy() {
fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_create(x, y);
}

// Original Objects/Frontier_IDPD.mod.gml:517
function fr_Objects_Frontier_IDPD_mod_gml_HQExit_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_HQExit";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprHQExit;
;
spr_shadow = shd16;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
hitid = [sprite_index, "HQ EXIT"];
;
depth = 8;
;
snd_hurt = sndHitPlant;
;
snd_dead = (- 1);
;
hp = 500;
;
size = 1;
;
mytext = scrFRLocalize("EXIT");
;
team = 3;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_IDPD_mod_gml_HQExit_step;
;
opened = false;
;
}
}
if(__fr_break6) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:548
function fr_Objects_Frontier_IDPD_mod_gml_HQExit_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((pick != (- 1)) && (opened == false))) {
{
opened = true;
;
name = "fr_HQExitOpened";
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
type = 3;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(GameCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
area = scrFRAreaResolve(lastarea);
}
}
if(__fr_break6) break;
}}
scrFRSoundPitchVolume(sndIDPDPortalSpawn, 1.2, 1);
;
scrFRSoundPlay(sndPortalAppear);
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:574
function fr_Objects_Frontier_IDPD_mod_gml_PopoMaggots_spawn(_frl__x=undefined, _frl__y=undefined) {
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, AcidStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStreak);
;
depth = (- 3);
;
}
}
if(__fr_break3) break;
}}
}
repeat (20) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, RadMaggot)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotDead;
;
hitid = [spr_idle, "STRIKE MAGGOT"];
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
raddrop -= 1;
;
fr_maggotPopo = true;
;
team = 3;
;
}
}
if(__fr_break6) break;
}}
}
}

// Original Objects/Frontier_IDPD.mod.gml:595
function fr_Objects_Frontier_IDPD_mod_gml_PopoMaggotController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_popoMaggotController")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
name = "fr_popoMaggotController";
;
on_end_step = fr_Objects_Frontier_IDPD_mod_gml_PopoMaggotController_endstep;
;
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:605
function fr_Objects_Frontier_IDPD_mod_gml_PopoMaggotController_endstep() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingLT(scrFRMatchingNE(RadMaggot, "fr_maggotPopo", undefined), "my_health", 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSourceRandom(4) < 1)) {
{
fr_Objects_Frontier_IDPD_mod_gml_sound_play_hit_ext(sndExplosionS, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 0.8);
;
fr_Objects_Frontier_IDPD_mod_gml_sound_play_hit_ext(sndExplosionS, (0.7 + scrFRSourceRandomRange(0.8, 1.3)), 1.2);
;
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_IDPD_mod_gml_PopoExplosionSmall_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
hitid = [global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoMaggotIdle, "STRIKE MAGGOT"];
;
damage = 1;
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

// Original Objects/Frontier_IDPD.mod.gml:619
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Baraquiel Guardian";
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryDead;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielGameover;
;
spr_port = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielPortal;
;
spr_look = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielSpotlight;
;
spr_ring_front = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielRingFront;
;
spr_ring_back = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielRingBack;
;
spr_wing = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBaraquielFly;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 7);
;
hitid = [spr_gameover, "BARAQUIEL GUARDIAN"];
spr_shadow = shd64;
;
spr_shadow_y = 16;
;
nts_color_blood = [c_aqua, make_color_rgb(14, 19, 134)];
snd_hurt = sndCrownGuardianHurt;
;
snd_dead = sndCrownGuardianDead;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_IDPD"].mskPopoBaraquiel;
;
mask_save = mask_index;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 120, "=");
;
hp = max_hp;
;
raddrop = 0;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
flightspeed = 5.5;
;
size = 3;
;
canmelee = 0;
;
canfly = true;
;
flying = false;
;
eyepos = 0;
;
eyeright = 1;
;
lookscale = 0;
;
team = 3;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
freeze = 0;
;
z = 0;
;
flying = false;
;
timeToLand = false;
;
landingZone = noone;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_step];
;
on_draw = fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_draw;
;
on_hurt = fr_Objects_Frontier_IDPD_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_IDPD_mod_gml_PopoBaraquiel_death;
;
on_alrm1 = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:688
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_IDPD_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((sprite_index != spr_wing) && frMacro_Objects_Frontier_IDPD_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((flying == true)) {
{
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_wing);
;
}
}
}
}
if (scrFRInstanceExists(target)) {
{
eyepos = frMacro_Objects_Frontier_IDPD_mod_gml_target_direction;
;
eyeright = ((((eyepos + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((frMacro_Objects_Frontier_IDPD_mod_gml_target_distance < 100)) {
{
if ((lookscale < 1)) {
{
lookscale += (0.2 * scrFRSourceScale());
}
}
}
} else {
{
if ((lookscale > 0)) {
{
lookscale -= (0.2 * scrFRSourceScale());
}
}
}
}
}
} else {
{
eyeright = ((((eyepos + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((lookscale > 0)) {
{
lookscale -= (0.2 * scrFRSourceScale());
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
if (scrFRInstanceExists(Player)) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((speed / timescale) > 1.5) || ((scrFROther(other)).hp < (scrFROther(other)).max_hp))) {
{
var __fr_other4=scrFROther(other);
__fr_other4.freeze += scrFRSourceScale();
;
}
}
if ((can_shoot == false)) {
{
var __fr_other5=scrFROther(other);
__fr_other5.freeze += (3 * scrFRSourceScale());
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:741
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(5)), "=");
;
if ((flying == true)) {
{
if ((timeToLand == false)) {
{
if ((z < 40)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
y -= 2;
;
z += 2;
;
spr_shadow_y += 2;
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, round((distance_to_object(landingZone) / (maxspeed / timescale))), "=");
;
fr_Objects_Frontier_IDPD_mod_gml_enemy_walk(point_direction(x, y, landingZone.x, landingZone.y), scrFRAlarmRead(scrFRSelf(self), 1));
timeToLand = true;
;
}
}
}
} else {
{
if ((z > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
y += 2.5;
;
z -= 2.5;
;
spr_shadow_y -= 2.5;
;
}
} else {
{
flying = false;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
maxspeed = (walkspeed) * timescale;
;
depth = (- 7);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.6;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y + 8), Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(5)) * timescale;
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
if ((z <= 12)) {
{
mask_index = mask_save;
;
}
} else {
{
mask_index = mskNone;
;
}
}
}
} else {
{
if (scrFRInstanceExists(target)) {
{
if (((frMacro_Objects_Frontier_IDPD_mod_gml_target_distance < 96) && fr_Objects_Frontier_IDPD_mod_gml_chance(1, 3))) {
{
fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_fly();
;
}
}
}
}
if ((((fr_Objects_Frontier_IDPD_mod_gml_enemy_target(x, y) && scrFRInstanceExists(target)) && (freeze != 0)) && fr_Objects_Frontier_IDPD_mod_gml_chance(1, 2))) {
{
{ var __fr_with7 = scrFRWithValues(fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_create((target.x + ((target.hspeed / timescale) * scrFRSourceRandomRange(10, 20))), (target.y + ((target.vspeed / timescale) * scrFRSourceRandomRange(10, 20))))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
hitid = __fr_other10.hitid;
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
}
}
if(__fr_break9) break;
}}
}
} else {
{
direction = scrFRSourceRandom(360);
;
fr_Objects_Frontier_IDPD_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:814
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_fly() {
{ var __fr_with1 = scrFRWithValues(instance_furthest(x, y, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__validZones = fr_Objects_Frontier_IDPD_mod_gml_instances_meeting_rectangle((x - 96), (y - 96), (x + 96), (y + 96), Floor);
;
var __fr_other4=scrFROther(other);
__fr_other4.landingZone = frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.instance_random, _frl__validZones);
}
}
if(__fr_break3) break;
}}
flying = true;
;
timeToLand = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
maxspeed = (flightspeed) * timescale;
;
depth = (- 10);
;
scrFRSoundPitch(sndCrownGuardianAppear, 0.8);
;
repeat (15) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, (y + 8), Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(7)) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_IDPD.mod.gml:835
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBaraquiel_draw() {
var _frl__y = (y + (sin((scrFRSourceFrame() * 0.06)) * 4));
var _frl__ring1rot = (image_angle + (sin((scrFRSourceFrame() * 0.06)) * 75));
var _frl__ring2rot = (image_angle + (sin((scrFRSourceFrame() * 0.04)) * (- 75)));
;
if ((nexthurt >= (scrFRSourceFrame() + 4))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
scrFRDrawSpriteExt(spr_ring_back, (scrFRSourceFrame() * 0.4), x, _frl__y, (image_xscale * right), image_yscale, _frl__ring1rot, image_blend, image_alpha);
scrFRDrawSpriteExt(spr_ring_back, (scrFRSourceFrame() * 0.4), x, _frl__y, (image_xscale * right), image_yscale, _frl__ring2rot, image_blend, image_alpha);
scrFRDrawSpriteExt(sprite_index, image_index, x, _frl__y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
scrFRDrawSpriteExt(spr_port, (scrFRSourceFrame() * 0.4), (x + lengthdir_x(11, eyepos)), (_frl__y + lengthdir_y(11, eyepos)), (1 * eyeright), 1, 0, c_white, 1);
;
scrFRDrawSpriteExt(spr_ring_front, (scrFRSourceFrame() * 0.4), x, _frl__y, (image_xscale * right), image_yscale, _frl__ring1rot, image_blend, image_alpha);
scrFRDrawSpriteExt(spr_ring_front, (scrFRSourceFrame() * 0.4), x, _frl__y, (image_xscale * right), image_yscale, _frl__ring2rot, image_blend, image_alpha);
if (((lookscale > 0) && (flying == false))) {
{
var _frl_spotbob = (sin((scrFRSourceFrame() * 0.05)) * 0.15);
scrFRDrawSpriteExt(spr_look, (scrFRSourceFrame() * 0.4), (x + lengthdir_x(44, eyepos)), (_frl__y + lengthdir_y(44, eyepos)), 1, (lookscale + _frl_spotbob), eyepos, c_white, 0.3);
;
}
}
gpu_set_fog(0, 0, 0, 0);
}

// Original Objects/Frontier_IDPD.mod.gml:868
function fr_Objects_Frontier_IDPD_mod_gml_PopoBaraquiel_death() {
scrFRPickupDrop(120, 20);
;
}

// Original Objects/Frontier_IDPD.mod.gml:877
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Battery Guardian";
spr_idle = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoBatteryDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "BATTERY GUARDIAN"];
spr_shadow = shd24;
;
spr_shadow_y = 4;
;
nts_color_blood = [c_aqua, make_color_rgb(14, 19, 134)];
snd_hurt = sndCrownGuardianHurt;
;
snd_dead = sndCrownGuardianDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 16, "=");
;
hp = max_hp;
;
raddrop = 0;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 0;
;
team = 3;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
freeze = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_step];
;
on_draw = fr_Objects_Frontier_IDPD_mod_gml_BatteryGuardian_draw;
;
on_hurt = fr_Objects_Frontier_IDPD_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_death;
;
on_alrm1 = ["mod", "Frontier_IDPD", fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:929
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_IDPD_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (frMacro_Objects_Frontier_IDPD_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
if (scrFRInstanceExists(Player)) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((speed / timescale) > 1.5) || ((scrFROther(other)).hp < (scrFROther(other)).max_hp))) {
{
var __fr_other4=scrFROther(other);
__fr_other4.freeze += scrFRSourceScale();
;
}
}
if ((can_shoot == false)) {
{
var __fr_other5=scrFROther(other);
__fr_other5.freeze += (3 * scrFRSourceScale());
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:958
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(5)), "=");
;
if ((((fr_Objects_Frontier_IDPD_mod_gml_enemy_target(x, y) and frMacro_Objects_Frontier_IDPD_mod_gml_target_visible) and (freeze != 0)) and fr_Objects_Frontier_IDPD_mod_gml_chance(1, 3))) {
{
gunangle = frMacro_Objects_Frontier_IDPD_mod_gml_target_direction;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
direction = (__fr_other5.gunangle + scrFRSourceRandomRange((- 5), 5));
;
image_angle = direction;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
scrFRMotionAdd(gunangle, (- 3));
scrFRSoundPitchVolume(sndEliteShielderFire, (0.6 + scrFRSourceRandom(0.3)), 0.8);
repeat (10) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(sprPopoPlasmaTrail);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(2)) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
} else {
{
direction = scrFRSourceRandom(360);
;
fr_Objects_Frontier_IDPD_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:990
function fr_Objects_Frontier_IDPD_mod_gml_PopoGuardianBattery_death() {
scrFRPickupDrop(40, 0);
}

// Original Objects/Frontier_IDPD.mod.gml:993
function fr_Objects_Frontier_IDPD_mod_gml_BatteryGuardian_draw() {
var _frl__y = (y + (sin((scrFRSourceFrame() * 0.06)) * 4.5));
gpu_set_blendmode(bm_normal);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, _frl__y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_IDPD.mod.gml:998
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrikeSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_AirstrikeSpawn";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
scrFRAlarmWrite(scrFRSelf(self), 0, (100 + scrFRSourceIRandom(200)), "=");
on_step = fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrikeSpawner_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1011
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrikeSpawner_step() {
scrFRAlarmWrite(scrFRSelf(self), 0, scrFRSourceScale(), "-=");
;
if ((scrFRAlarmRead(scrFRSelf(self), 0) <= 0)) {
{
if (scrFRInstanceExists(Player)) {
{
var _frl_who2kill = frMacro_Objects_Frontier_IDPD_mod_gml_call(frMacro_Objects_Frontier_IDPD_mod_gml_scr.instance_random, Player);
fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_create(_frl_who2kill.x, _frl_who2kill.y);
}
}
scrFRDelete(scrFRSelf(self));
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1021
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_IDPD"].sndStrikerWarning);
;
name = "STRIKER";
spr_striker = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStriker;
;
spr_airstrike = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerPath;
;
spr_flames = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerFlame;
;
sprite_index = scrFRAreaSourceSprite(sprRogueStrikeTB);
;
image_alpha = 0;
;
image_xscale = 2;
;
image_yscale = 1.3;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
depth = (- 11);
;
striker_dis = (- 2200);
;
striker_x = (x + lengthdir_x(striker_dis, direction));
;
striker_y = (y + lengthdir_y(striker_dis, direction));
;
team = 3;
;
lifetime = 135;
;
striked = false;
;
flownby = false;
;
didit = false;
;
freaked = false;
;
if ((GameCont.loops >= 3)) {
{
freaked = true;
;
}
}
on_step = fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_step;
;
on_end_step = fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_endstep;
on_draw = fr_Objects_Frontier_IDPD_mod_gml_PopoStriker_draw;
;
on_destroy = fr_Objects_Frontier_IDPD_mod_gml_PopoStriker_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1065
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_step() {
striker_dis += (scrFRSourceScale() * 30);
;
striker_x = (x + lengthdir_x(striker_dis, direction));
;
striker_y = (y + lengthdir_y(striker_dis, direction));
;
if (((striker_dis > 50) && (flownby == false))) {
{
scrFRSoundPitch(sndNothingDeath2, 2.5);
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_IDPD"].sndStrikerFly);
scrFRViewShakeAt(x, y, 300);
flownby = true;
}
}
lifetime -= scrFRSourceScale();
;
if (((lifetime < 50) && (striked == false))) {
{
fr_Objects_Frontier_IDPD_mod_gml_AirstrikeBomb_spawn();
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
striked = true;
;
}
}
if ((freaked == true)) {
{
if (frMacro_Objects_Frontier_IDPD_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((striker_x + scrFRSourceRandomRange((- 30), 30)), (striker_y + scrFRSourceRandomRange((- 30), 30)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = (1.5 + scrFRSourceRandom(0.5));
;
image_yscale = image_xscale;
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + 180);
;
depth = (- 10);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1104
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_endstep() {
if ((flownby == false)) {
{
scrFRBindDraw(fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_draw, 0, spr_airstrike, x, y, image_angle);
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1109
function fr_Objects_Frontier_IDPD_mod_gml_PopoAirstrike_draw(_frl__spr_airstrike=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined) {
scrFRDrawSpriteExt(_frl__spr_airstrike, scrFRSourceFrame(), _frl__x, _frl__y, 1, 1, _frl__angle, c_white, 1);
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_IDPD.mod.gml:1113
function fr_Objects_Frontier_IDPD_mod_gml_PopoStriker_draw() {
if ((! surface_exists(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike))) {
{
global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike = surface_create(view_width, view_height);
;
}
}
surface_set_target(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike);
var _frl_ns_x = scrFRViewCoordinate(0);
;
var _frl_ns_y = scrFRViewCoordinate(1);
;
var _frl_stack = 1;
;
var _frl_height = 11;
;
draw_clear_alpha(c_white, 0);
{
var _frl_i = 0;
for (; (_frl_i <= _frl_height); _frl_i++) {
{
var _frl_s = 1;
for (; (_frl_s <= _frl_stack); _frl_s++) {
var _frl_o = ((_frl_s - 1) / _frl_stack);
;
{
_frl_i = 0;
for (; (_frl_i < sprite_get_number(spr_striker)); _frl_i++) {
scrFRDrawSpriteExt(spr_striker, _frl_i, (striker_x - _frl_ns_x), ((striker_y - (_frl_i - _frl_o)) - _frl_ns_y), 1, 1, direction, image_blend, 1);
;
}
}
}
}
}
}
surface_reset_target();
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike, (_frl_ns_x + 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike, (_frl_ns_x - 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike, _frl_ns_x, (_frl_ns_y + 1), 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike, _frl_ns_x, (_frl_ns_y - 1), 1, 1, 0, c_black, 1);
draw_surface(global.fr_module_vars[$ "mod:Frontier_IDPD"].surfacePopoAirstrike, _frl_ns_x, _frl_ns_y);
if ((freaked == true)) {
{
scrFRDrawSpriteExt(spr_flames, (scrFRSourceFrame() * 0.4), (striker_x + lengthdir_x((- 80), direction)), (striker_y + lengthdir_y((- 40), direction)), image_xscale, image_yscale, direction, image_blend, 1);
;
scrFRDrawSpriteExt(spr_flames, (2 + (scrFRSourceFrame() * 0.4)), (striker_x + lengthdir_x((- 20), direction)), (striker_y + lengthdir_y((- 60), direction)), image_xscale, image_yscale, direction, image_blend, 1);
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1154
function fr_Objects_Frontier_IDPD_mod_gml_PopoStriker_destroy() {
if ((freaked == true)) {
{
scrFRSoundPitchVolume(sndNukeExplosion, (0.8 + scrFRSourceRandom(0.1)), 0.3);
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1159
function fr_Objects_Frontier_IDPD_mod_gml_AirstrikeBomb_spawn() {
{
var _frl_i = (- 4);
for (; (4 >= _frl_i); _frl_i++) {
var _frl__length = ((sprite_width * _frl_i) / 8);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x + lengthdir_x(_frl__length, direction)) + scrFRSourceRandomRange((- 25), 25)), ((y + lengthdir_y(_frl__length, direction)) + scrFRSourceRandomRange((- 25), 25)), FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
lifetime = (((_frl_i + 2) * 2) + 1);
;
on_step = fr_Objects_Frontier_IDPD_mod_gml_AirstrikeBomb_step;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1171
function fr_Objects_Frontier_IDPD_mod_gml_AirstrikeBomb_step() {
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PopoExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprRogueExplosionTB);
;
mask_index = mskPopoExplo;
;
hitid = [global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoStrikerGameover, "STRIKER"];
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
scrFRSoundHitBig(sndExplosion, 0.3);
;
scrFRSoundHitBig(sndIDPDNadeExplo, 0.2);
;
repeat (15) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 50), 50)), (y + scrFRSourceRandomRange((- 50), 50)), BlueFlame)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(sprBlueFlameBig);
;
}
}
if(__fr_break7) break;
}}
}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1194
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPitchVolume(sndIDPDNadeLoad, scrFRSourceRandomRange(1.3, 1.4), 1.4);
name = "fr_skybeamspawn";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamWarning);
;
spr_blink = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamWarningBlink;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = (- 1);
;
image_xscale = 0.1;
;
image_yscale = image_xscale;
;
fr_bloom = [1.1, 0.1];
;
speenspeed = 0;
;
timer = 35;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
on_step = fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_step;
;
on_destroy = fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1224
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_step() {
if (frMacro_Objects_Frontier_IDPD_mod_gml_current_frame_active) {
{
image_angle += (4 + speenspeed);
;
speenspeed += 0.8;
;
}
}
if ((image_xscale < 1)) {
{
image_xscale += (0.25 * scrFRSourceScale());
;
image_yscale = image_xscale;
}
}
if ((timer > 0)) {
{
timer -= scrFRSourceScale();
}
}
if ((timer < 15)) {
{
sprite_index = scrFRAreaSourceSprite(spr_blink);
;
}
}
if ((timer <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1245
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeamSpawn_destroy() {
fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_create(x, y);
}

// Original Objects/Frontier_IDPD.mod.gml:1248
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_create(_frl__x=undefined, _frl__y=undefined) {
scrFRSoundPitchVolume(sndIDPDNadeExplo, scrFRSourceRandomRange(0.5, 0.7), 1);
scrFRSoundPitchVolume(sndExplosionL, scrFRSourceRandomRange(1.2, 1.4), 1);
scrFRSoundPitchVolume(sndStrongSpiritLost, scrFRSourceRandomRange(0.5, 0.6), 1);
scrFRSoundPitchVolume(sndStrongSpiritGain, scrFRSourceRandomRange(0.3, 0.4), 0.7);
scrFRSoundPitchVolume(sndPlasmaHuge, scrFRSourceRandomRange(0.5, 0.7), 0.7);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, PortalClear);
scrFRInstanceCreate(x, y, Scorch);
repeat (11) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), y, Smoke)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRMotionAdd(90, scrFRSourceRandom(2));
image_xscale = scrFRSourceRandomRange(0.5, 1.5);
image_yscale = image_xscale;
gravity = ((- (friction / (timescale * timescale)))) * (timescale * timescale);
depth = (- 9);
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRMotionSet(scrFRSourceRandom(360), (3 + scrFRSourceRandom(5)));
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 20), 20)), BlueFlame)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(sprBlueFlame, sprBlueFlameBig));
;
}
}
if(__fr_break12) break;
}}
}
mask_index = sprPlasmaBall;
;
image_xscale = 2.5;
;
image_yscale = 2.5;
;
depth = (- 8);
;
beamscale = 3;
;
damage = 6;
;
hitlist = [];
;
var __fr_other13=scrFROther(other);
hitid = __fr_other13.hitid;
;
var __fr_other14=scrFROther(other);
team = __fr_other14.team;
;
var __fr_other15=scrFROther(other);
creator = __fr_other15.creator;
;
on_step = fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_step;
;
on_hit = fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_hit;
;
on_wall = fr_Objects_Frontier_IDPD_mod_gml_nothing;
;
on_draw = fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1304
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_step() {
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 120), 10)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamTrail);
;
depth = (- 9);
;
speed = (scrFRSourceRandom(6)) * timescale;
;
direction = 270;
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRMotionSet(scrFRSourceRandom(360), (3 + scrFRSourceRandom(3)));
}
}
if(__fr_break6) break;
}}
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 26), 26)), (y + 20), BulletHit)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamEndTrail);
;
depth = (- 9);
;
speed = (scrFRSourceRandom(6)) * timescale;
;
direction = (90 + scrFRSourceRandomRange((- 25), 25));
image_angle = direction;
;
}
}
if(__fr_break9) break;
}}
}
}
beamscale -= (0.08 * scrFRSourceScale());
;
image_xscale = beamscale;
;
image_yscale = image_xscale;
;
if ((beamscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1334
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
{ var __fr_with2 = scrFRWithValues((scrFROther(other))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other5.damage, (__fr_other5.knockback_speed / timescale));
var __fr_other6=scrFROther(other);
lasthit = __fr_other6.hitid;
}
}
if(__fr_break4) break;
}}
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1344
function fr_Objects_Frontier_IDPD_mod_gml_PopoSkybeam_draw() {
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeam, 1, x, (y - 96), (clamp(beamscale, 0, 1) + scrFRSourceRandom(0.2)), 1, 0, c_white, 1);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeam, 1, x, (y - 96), (clamp(beamscale, 0, 1) * 1.1), 1, 0, c_white, 0.4);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoSkybeamEnd, (scrFRSourceFrame() * 0.4), x, (y + 12), clamp(beamscale, 0, 1), 1, 0, c_white, 1);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1354
function fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPlasmaSmall);
;
spr_trail = sprPopoPlasmaTrail;
;
spr_explo = global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoPlasmaImpactSmall;
;
image_angle = direction;
;
fr_bloom = [2, 0.1];
;
speed = ((7 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
typ = 1;
;
damage = 2;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "MINI PLASMA"];
;
on_anim = fr_Objects_Frontier_IDPD_mod_gml_MuzzleFlash_anim;
;
on_step = fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_step;
;
on_wall = fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_wall;
;
on_destroy = fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1380
function fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_step() {
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 4), 4)), (y + scrFRSourceRandomRange((- 4), 4)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
direction = __fr_other5.direction;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((image_xscale < 0.8)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1392
function fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_wall() {
image_xscale -= 0.1;
;
image_yscale = image_xscale;
;
x = xprevious;
;
y = yprevious;
;
scrFRSoundPitchVolume(sndHitWall, scrFRSourceRandomRange(0.9, 1.2), 1);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
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
}

// Original Objects/Frontier_IDPD.mod.gml:1403
function fr_Objects_Frontier_IDPD_mod_gml_MiniPlasma_destroy() {
scrFRSoundPitchVolume(sndPlasmaHit, scrFRSourceRandomRange(1.1, 1.3), 0.8);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaImpact)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
damage = 2;
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_explo);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_IDPD"].mskPlasmaImpactSmall;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_IDPD.mod.gml:1413
function fr_Objects_Frontier_IDPD_mod_gml_PopoExplosionSmall_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, PopoExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprPopoExplosionSmall);
;
mask_index = mskSmallExplosion;
;
team = 3;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
; // macro hoisted: anim_end
; // macro hoisted: current_frame_active
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
; // macro hoisted: anim_end
; // macro hoisted: enemy_sprite
; // macro hoisted: alarm0_run
; // macro hoisted: alarm1_run
; // macro hoisted: alarm2_run
; // macro hoisted: alarm3_run
; // macro hoisted: alarm4_run
; // macro hoisted: alarm5_run
; // macro hoisted: alarm6_run
; // macro hoisted: alarm7_run
; // macro hoisted: alarm8_run
; // macro hoisted: alarm9_run
}

// Original Objects/Frontier_IDPD.mod.gml:1441
function fr_Objects_Frontier_IDPD_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1442
function fr_Objects_Frontier_IDPD_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1443
function fr_Objects_Frontier_IDPD_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_IDPD.mod.gml:1444
function fr_Objects_Frontier_IDPD_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_IDPD.mod.gml:1445
function fr_Objects_Frontier_IDPD_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_IDPD.mod.gml:1446
function fr_Objects_Frontier_IDPD_mod_gml_enemy_face(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1447
function fr_Objects_Frontier_IDPD_mod_gml_enemy_look(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
if (scrFRVariableExists(scrFRSelf(self), "gunangle")) {
gunangle = _frl__dir;
}
}

// Original Objects/Frontier_IDPD.mod.gml:1448
function fr_Objects_Frontier_IDPD_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1449
function fr_Objects_Frontier_IDPD_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1450
function fr_Objects_Frontier_IDPD_mod_gml_GunEnemy_draw() {
if ((gunangle < 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle >= 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
}

// Original Objects/Frontier_IDPD.mod.gml:1451
function fr_Objects_Frontier_IDPD_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_IDPD_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_IDPD_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_IDPD.mod.gml:1452
function fr_Objects_Frontier_IDPD_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_IDPD_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_IDPD_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_IDPD.mod.gml:1453
function fr_Objects_Frontier_IDPD_mod_gml_nothing() {

}

// Original Objects/Frontier_IDPD.mod.gml:1454
function fr_Objects_Frontier_IDPD_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionAdd(_frl__dir, _frl__spd);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_IDPD.mod.gml:1464
function fr_Objects_Frontier_IDPD_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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
}

// Original Objects/Frontier_IDPD.mod.gml:1473
function fr_Objects_Frontier_IDPD_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
if ((_frl__angleMelee != 0)) {
{
_frl__angle += (_frl__angleMelee * (1 - (_frl__kick / 20)));
;
}
}
if ((_frl__kick != 0)) {
{
_frl__x -= lengthdir_x(_frl__kick, _frl__angle);
;
_frl__y -= lengthdir_y(_frl__kick, _frl__angle);
;
}
}
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, 1, _frl__flip, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1496
function fr_Objects_Frontier_IDPD_mod_gml_instances_meeting_rectangle(_frl__x1=undefined, _frl__y1=undefined, _frl__x2=undefined, _frl__y2=undefined, _frl__obj=undefined) {
return scrFRMatchingLE(scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingGE(_frl__obj, "bbox_right", _frl__x1), "bbox_bottom", _frl__y1), "bbox_left", _frl__x2), "bbox_top", _frl__y2);
;
}

// Original Objects/Frontier_IDPD.mod.gml:1518
function fr_Objects_Frontier_IDPD_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_IDPD.mod.gml:1530
function fr_Objects_Frontier_IDPD_mod_gml_MuzzleFlash_anim() {
image_index = 1;
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_IDPD.mod.gml:1534
function fr_Objects_Frontier_IDPD_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_IDPD"].sprGenericTrail);
;
mask_index = mskNone;
;
image_speed = (2) * timescale;
;
image_yscale = (1 / 50);
;
image_xscale = 1;
;
depth = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}
