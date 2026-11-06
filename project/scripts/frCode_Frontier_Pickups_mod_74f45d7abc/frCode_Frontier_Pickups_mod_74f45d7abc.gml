#macro frMacro_Objects_Frontier_Pickups_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Pickups"].scr

#macro frMacro_Objects_Frontier_Pickups_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Pickups_mod_gml_WepMimicID 553

#macro frMacro_Objects_Frontier_Pickups_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Pickups_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Pickups_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Pickups_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Pickups_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Pickups_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Pickups_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Pickups_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Pickups_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Pickups.mod.gml:1
function fr_Objects_Frontier_Pickups_mod_gml___load() {

}

// Original Objects/Frontier_Pickups.mod.gml:1
function fr_Objects_Frontier_Pickups_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Pickups_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Pickups_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Pickups_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Pickups.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Pickups", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Pickups"].settingVisualDecryptors = true;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].libChests = [];
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealPickup = sprFR_sprMealPickup_bb1a72fe87a4;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprFishPickup = sprFR_sprFishPickup_6a3c98dcecc9;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprBloodLustPickup = sprFR_sprBloodLustPickup_a4f87671d8c4;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxHealthPickup = sprFR_sprMaxHealthPickup_4ee5ffc360a5;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxAmmoPickup = sprFR_sprMaxAmmoPickup_f446ccb6ca6d;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxRadPickup = sprFR_sprMaxRadPickup_0595abb7686d;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWeaponCapsule = sprFR_sprWeaponCapsule_46d100ae252b;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWeaponCapsuleDebris = sprFR_sprWeaponCapsuleDebris_d7d7781bec93;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChest = sprFR_sprMealChest_4e7ebc4ad8ff;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestOpen = sprFR_sprMealChestOpen_3c014fccb9ed;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestCursed = sprFR_sprMealChestCursed_b362c55ed5ab;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestCursedOpen = sprFR_sprMealChestCursedOpen_9508d11fa145;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBig = sprFR_sprMealChestBig_ef95877a9203;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigOpen = sprFR_sprMealChestBigOpen_4abc6d90dab5;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigCursed = sprFR_sprMealChestBigCursed_fc664f65d5f7;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigCursedOpen = sprFR_sprMealChestBigCursedOpe_e953e875e2cb;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprToolbox = sprFR_sprToolbox_52bfd719a2ae;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprToolboxOpen = sprFR_sprToolboxOpen_47690c53f2ca;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDecryptor = sprFR_sprDecryptor_895bda8e134c;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestBig = sprFR_sprRogueChestBig_8938dae1d1c1;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestBigOpen = sprFR_sprRogueChestBigOpen_dfbf00a34185;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggot = sprFR_sprRogueChestMaggot_2b007d2a2892;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggotHurt = sprFR_sprRogueChestMaggotHurt_7dd62ac59c6b;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggotDead = sprFR_sprRogueChestMaggotDead_fa989c7cc887;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].shdDeeplabsCache = sprFR_shdDeeplabsCache_e5d9d73bb718;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCache = sprFR_sprDeeplabsCache_8f0b0d9d90dc;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheOpening = sprFR_sprDeeplabsCacheOpening_83c2e7753d2a;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheOpen = sprFR_sprDeeplabsCacheOpen_23a877dc26a2;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheDone = sprFR_sprDeeplabsCacheDone_4c1d49b046b3;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].mskDeeplabsCache = sprFR_mskDeeplabsCache_ce30fd33e07d;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprHoarderBag = sprFR_sprHoarderBag_c159cf28e605;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprHoarderBagOpen = sprFR_sprHoarderBagOpen_09064921273e;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickup = sprFR_sprAugmentAmmoPickup_147a7bab6aa5;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickupBig = sprFR_sprAugmentAmmoPickupBig_286f58158b2a;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickupHuge = sprFR_sprAugmentAmmoPickupHuge_213a3eda87b1;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickup = sprFR_sprAugmentHPPickup_a98b512b5071;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickupBig = sprFR_sprAugmentHPPickupBig_6899dbb8ace0;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickupHuge = sprFR_sprAugmentHPPickupHuge_4582895b5d1a;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWhiteSmoke = sprFR_sprWhiteSmoke_af86c6156b99;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealSparkle = sprFR_sprMealSparkle_c1e2c1971c9b;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicIdle = sprFR_sprMealMimicIdle_b8d4d6af8e71;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicFire = sprFR_sprMealMimicFire_fbf29933dd50;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicHurt = sprFR_sprMealMimicHurt_56090fe2f2fb;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicDead = sprFR_sprMealMimicDead_8d63ee73a9ba;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicTell = sprFR_sprMealMimicTell_bf9c401e7ceb;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicIdle = sprFR_sprCursedMealMimicIdle_16475871bcee;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicFire = sprFR_sprCursedMealMimicFire_2bef70fa2a8e;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicHurt = sprFR_sprCursedMealMimicHurt_1865e61e199b;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicDead = sprFR_sprCursedMealMimicDead_faaa6ac5c4bd;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicTell = sprFR_sprCursedMealMimicTell_1c5906a3b1bc;
;
fr_Objects_Frontier_Pickups_mod_gml_meal_init();
fr_Objects_Frontier_Pickups_mod_gml_list_finalize(global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory, global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultMeal);
fr_Objects_Frontier_Pickups_mod_gml_meal_rank();
fr_Objects_Frontier_Pickups_mod_gml_mealCurses_init();
fr_Objects_Frontier_Pickups_mod_gml_list_finalize(global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory, global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultMealCurse);
fr_Objects_Frontier_Pickups_mod_gml_mealCurses_rank();
fr_Objects_Frontier_Pickups_mod_gml_fish_init();
fr_Objects_Frontier_Pickups_mod_gml_list_finalize(global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory, global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultFish);
fr_Objects_Frontier_Pickups_mod_gml_fish_rank();
fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_init();
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Pickups.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Pickups.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Pickups.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Pickups.mod.gml:86
function fr_Objects_Frontier_Pickups_mod_gml_game_start() {
fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_init();
;
}

// Original Objects/Frontier_Pickups.mod.gml:95
function fr_Objects_Frontier_Pickups_mod_gml_Decryptor_spawn(_frl__x=undefined, _frl__y=undefined) {
if ((global.fr_module_vars[$ "mod:Frontier_Pickups"].settingVisualDecryptors == true)) {
{
fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_create(_frl__x, _frl__y, frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.instance_random, Player));
;
}
}
GameCont.fr_decryptors += 1;
;
}

// Original Objects/Frontier_Pickups.mod.gml:101
function fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_create(_frl__x=undefined, _frl__y=undefined, _frl__leader=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DecryptorFollower";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDecryptor);
;
depth = (- 8);
;
image_alpha = 0;
;
image_speed = (0.4) * timescale;
;
right = 0;
;
offset = scrFRSourceRandomRange((- 35), 35);
;
distance = (40 + scrFRSourceRandom(40));
;
tilt = 0;
;
leader = _frl__leader;
;
friction = (0.5) * (timescale * timescale);
;
xgoal = _frl__leader.x;
;
ygoal = _frl__leader.y;
;
flightspeed = 4;
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_step;
;
on_end_step = fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_end_step;
;
on_draw = fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:127
function fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_step() {
if ((! scrFRInstanceExists(leader))) {
{
if ((! scrFRInstanceExists(Player))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRChickenB)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = make_color_rgb(0, 255, 0);
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
leader = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.instance_random, Player);
}
}
}
}
if ((scrFRSourceRandom(250) < 1)) {
{
offset = scrFRSourceRandomRange((- 35), 35);
;
distance = (40 + scrFRSourceRandom(40));
;
}
}
if ((scrFRInstanceNumber(Player) > 1)) {
{
if ((scrFRSourceRandom(1000) < 1)) {
{
leader = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.instance_random, Player);
}
}
}
}
x += (fr_Objects_Frontier_Pickups_mod_gml_approach(x, xgoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_x(0, leader.direction));
y += (fr_Objects_Frontier_Pickups_mod_gml_approach(y, ygoal, flightspeed, (0.3 * scrFRSourceScale())) - lengthdir_y(0, leader.direction));
y = (y + (sin((scrFRSourceFrame() * 0.06)) * 0.2));
;
xgoal = (leader.x - lengthdir_x(distance, (leader.direction + offset)));
ygoal = (leader.y - lengthdir_y(distance, (leader.direction + offset)));
tilt = (((leader.speed / timescale) * 4) * (- right));
;
right = ((((leader.direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Pickups.mod.gml:167
function fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_end_step() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Pickups_mod_gml_generic_trail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_yscale *= 2;
;
image_speed *= 4;
;
var __fr_other6=scrFROther(other);
image_angle = point_direction(x, y, __fr_other6.xprevious, __fr_other6.yprevious);
image_blend = make_color_rgb(0, 255, 0);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:177
function fr_Objects_Frontier_Pickups_mod_gml_DecryptorFollower_draw() {
gpu_set_blendmode(bm_normal);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, tilt, image_blend, 1);
;
}

// Original Objects/Frontier_Pickups.mod.gml:181
function fr_Objects_Frontier_Pickups_mod_gml_WeaponCapsule_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWeaponCapsule);
;
timer = 25;
;
friction = (0.15) * (timescale * timescale);
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_WeaponCapsule_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:192
function fr_Objects_Frontier_Pickups_mod_gml_WeaponCapsule_step() {
timer -= scrFRSourceScale();
if ((timer <= 0)) {
{
scrFRPickupDrop(0, 100, 1);
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWeaponCapsuleDebris);
;
friction = (1) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
scrFRInstanceCreate(x, y, SmallChestFade);
;
scrFRSoundPitch(sndBouncerBounce, 1.4);
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:207
function fr_Objects_Frontier_Pickups_mod_gml_BloodLustPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibPickup")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BloodLustPickup";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprBloodLustPickup);
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_BloodLustPickup_open];
scrFRAlarmWrite(scrFRSelf(self), 0, 600, "=");
;
pull_dis = (30 + (15 * scrFRGetSkill(mut_plutonium_hunger)));
;
pull_spd = 4;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:219
function fr_Objects_Frontier_Pickups_mod_gml_BloodLustPickup_open() {
scrFRSoundPitchVolume(sndStrongSpiritLost, 0.5, 1);
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues((scrFRInstanceIs((scrFROther(other)), Player) ? (scrFROther(other)) : Player)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, PopupText)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
mytext = scrFRLocalize("@w+60 SECONDS OF#@(color:2964142)BONUS BLOODLUST");
}
}
if(__fr_break9) break;
}}
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffBloodLust_time"))) {
{
fr_buffBloodLust_time = 0;
;
}
}
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffBloodLust"), 1800);
}
}
if(__fr_break6) break;
}}
return false;
;
}

// Original Objects/Frontier_Pickups.mod.gml:237
function fr_Objects_Frontier_Pickups_mod_gml_MaxHealthPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibPickup")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "MaxHealthPickup";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxHealthPickup);
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_MaxHealthPickup_open];
scrFRAlarmWrite(scrFRSelf(self), 0, (- 1), "=");
;
pull_dis = (20 + (5 * scrFRGetSkill(mut_plutonium_hunger)));
;
pull_spd = 3;
;
snd_open = sndHPPickup;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:250
function fr_Objects_Frontier_Pickups_mod_gml_MaxHealthPickup_open() {
scrFRSoundPitchVolume(sndGuardianAppear, 0.5, 1);
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, RadEat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprEatBigRadPlut);
;
speed = (2) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues((scrFRInstanceIs((scrFROther(other)), Player) ? (scrFROther(other)) : Player)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRMaxHealthWrite(id, 1, "+=");
;
hp += 1;
;
hp = min(hp, max_hp);
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, PopupText)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
mytext = scrFRLocalize(("@(color:589246)+1 " + scrFRLoc("Frontier:MaxHealthPickup", "MAX HP")));
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break6) break;
}}
return false;
;
}

// Original Objects/Frontier_Pickups.mod.gml:273
function fr_Objects_Frontier_Pickups_mod_gml_MaxAmmoPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibPickup")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "MaxAmmoPickup";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxAmmoPickup);
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_MaxAmmoPickup_open];
scrFRAlarmWrite(scrFRSelf(self), 0, (- 1), "=");
;
pull_dis = (20 + (5 * scrFRGetSkill(mut_plutonium_hunger)));
;
pull_spd = 3;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:285
function fr_Objects_Frontier_Pickups_mod_gml_MaxAmmoPickup_open() {
scrFRSoundPitchVolume(sndGuardianAppear, 0.5, 1);
;
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, RadEat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprEatBigRadPlut);
;
speed = (2) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues((scrFRInstanceIs((scrFROther(other)), Player) ? (scrFROther(other)) : Player)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{
var _frl_i = 1;
for (; (_frl_i < array_length(ammo)); _frl_i++) {
scrFRModCall("mod", "wibbly", "ammoMaxBonus_add", index, _frl_i, 5);
;
scrFRModCall("mod", "wibbly", "ammoMaxBonus_add", index, 1, 4);
;
}
}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
mytext = scrFRLocalize(("@(color:589246)+5 " + scrFRLoc("Frontier:MaxAmmoPickup", "MAX AMMO")));
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break6) break;
}}
return false;
;
}

// Original Objects/Frontier_Pickups.mod.gml:313
function fr_Objects_Frontier_Pickups_mod_gml_MaxRadPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibPickup")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "MaxRadPickup";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMaxRadPickup);
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_MaxRadPickup_open];
scrFRAlarmWrite(scrFRSelf(self), 0, (- 1), "=");
;
pull_dis = (20 + (5 * scrFRGetSkill(mut_plutonium_hunger)));
;
pull_spd = 3;
;
snd_open = sndEXPChest;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:326
function fr_Objects_Frontier_Pickups_mod_gml_MaxRadPickup_open() {
scrFRSoundPitchVolume(sndGuardianAppear, 0.5, 1);
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, RadEat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprEatBigRadPlut);
;
speed = (2) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
scrFRModCall("mod", "wibbly", "radMaxBonus_add", 60);
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, PopupText)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mytext = scrFRLocalize(("@(color:589246)+60 " + scrFRLoc("Frontier:MaxRadPickup", "MAX RADS")));
}
}
if(__fr_break6) break;
}}
return false;
;
}

// Original Objects/Frontier_Pickups.mod.gml:349
function fr_Objects_Frontier_Pickups_mod_gml_ToolKitChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibChest")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ToolKitChest";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprToolbox);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprToolboxOpen;
;
spr_open = sprFXChestOpen;
snd_open = sndAmmoChest;
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_ToolKitChest_open];
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:362
function fr_Objects_Frontier_Pickups_mod_gml_ToolKitChest_open() {
var _frl__difficulty = (GameCont.hard + 1);
;
var _frl__toolPool = [[wep_wrench, 0.55], [wep_jackhammer, (_frl__difficulty >= scrFRWeaponArea(wep_jackhammer))], [wep_energy_screwdriver, (_frl__difficulty >= scrFRWeaponArea(wep_energy_screwdriver))], [wep_energy_screwdriver, ((_frl__difficulty >= 6) * 0.2)], [wep_golden_screwdriver, ((_frl__difficulty >= 6) * 0.05)], [wep_golden_wrench, ((_frl__difficulty >= 6) * 0.05)], ["hand_spade", ((_frl__difficulty >= 4) && scrFRModLoaded("wep", "hand_spade"))], ["hand_saw", ((_frl__difficulty >= 4) && scrFRModLoaded("wep", "hand_saw"))], ["mcleod", ((_frl__difficulty >= 4) && scrFRModLoaded("wep", "mcleod"))], ["tree_pruner", ((_frl__difficulty >= 4) && scrFRModLoaded("wep", "tree_pruner"))], ["chainsaw", ((_frl__difficulty >= scrFRWeaponArea("chainsaw")) && scrFRModLoaded("wep", "chainsaw"))], ["energy chainsaw", ((_frl__difficulty >= scrFRWeaponArea("energy chainsaw")) && scrFRModLoaded("wep", "energy chainsaw"))], ["nail gun", ((_frl__difficulty >= scrFRWeaponArea("nail gun")) && scrFRModLoaded("wep", "nail gun"))], ["rivet gun", ((_frl__difficulty >= scrFRWeaponArea("rivet gun")) && scrFRModLoaded("wep", "rivet gun"))]];
;
var _frl_coolTool = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.pool, _frl__toolPool);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", wep_screwdriver);
;
ammo = 1;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", _frl_coolTool);
;
ammo = 1;
;
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:396
function fr_Objects_Frontier_Pickups_mod_gml_MealChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibChest")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_MealChest";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChest);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestOpen;
;
spr_open = sprFXChestOpen;
snd_open = sndAmmoChest;
;
{ var __fr_switch_value4=scrFRCrownCurrent(), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(crwn_none)) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==(crwn_curses)) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
curse = false;
;
break;
;
case 1:
curse = (scrFRSourceRandom(3) < 2);
break;
;
case 2:
curse = (scrFRSourceRandom(7) < 1);
;
}
}
if ((curse > 0)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestCursed);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestCursedOpen;
;
snd_open = sndCursedChest;
;
}
}
meal = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealList, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealList) - 1))));
;
mealHot = meal.mealHot;
;
mealCursed = curse;
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_MealChest_open];
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:428
function fr_Objects_Frontier_Pickups_mod_gml_MealChest_open() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Pickups_mod_gml_MealPickup_create(x, y, meal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
mealCursed = __fr_other4.mealCursed;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndCursedReminder, 1.4, 2);
scrFRSoundPitchVolume(sndHitMetal, (2.8 + scrFRSourceRandom(0.3)), 1.6);
if ((mealHot == true)) {
{
repeat ((7 + scrFRSourceRandom(5))) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWhiteSmoke);
;
direction = (90 + scrFRSourceRandomRange((- 30), 30));
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
image_xscale = (0.4 + scrFRSourceRandom(0.4));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break7) break;
}}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:452
function fr_Objects_Frontier_Pickups_mod_gml_BigMealChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Pickups_mod_gml_MealChest_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BigMealChest";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBig);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigOpen;
;
spr_shadow = shd32;
spr_shadow_y = 1;
;
meal = global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"big_burger"];
if ((curse > 0)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigCursed);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealChestBigCursedOpen;
;
}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:472
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibChest")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RogueChestBig";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestBig);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestBigOpen;
;
spr_open = sprFXChestOpen;
snd_open = sndRogueCanister;
;
spr_shadow_y = 1;
;
on_step = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_step];
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_open];
;
fr_bigStrikeChest = 1;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:489
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RogueChestBigController";
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:498
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_step_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Pickups_mod_gml_RogueChestBigController_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Pickups.mod.gml:499
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Pickups.mod.gml:499
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Pickups.mod.gml:500
scrFRTaskWithNext(_fr);
break;
case 4: // Objects/Frontier_Pickups.mod.gml:500
scrFRTaskWithAbort(_fr);
break;
case 5: // Objects/Frontier_Pickups.mod.gml:508
{
;
}
_fr.pc=3;
break;
case 6: // Objects/Frontier_Pickups.mod.gml:508
_fr.result=undefined; _fr.done=true; return;
break;
case 7: // Objects/Frontier_Pickups.mod.gml:502
{
;
if (((! scrFRInstanceExists((scrFROther(other)))) && scrFRInstanceExists(scrFRSelf(self)))) {
{
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(LevCont))) {
{
fr_bigStrikeChest += 1;
;
}
}
}
}
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Pickups.mod.gml:502
_fr.wait_ticks=max(0,0); _fr.pc=7; return;
break;
case 9: // Objects/Frontier_Pickups.mod.gml:501
_fr.pc = (scrFRTaskFork(_fr, 8)) ? 8 : 3;
break;
case 10: // Objects/Frontier_Pickups.mod.gml:500
scrFRTaskWithEnter(_fr,scrFRWithValues(GameCont),9,1);
break;
case 11: // Objects/Frontier_Pickups.mod.gml:499
scrFRTaskWithEnter(_fr,scrFRWithValues(RogueChest),10,0);
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Pickups.mod.gml:513
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_step_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Pickups.mod.gml:515
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Pickups.mod.gml:515
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Pickups.mod.gml:524
{
;
}
_fr.pc=1;
break;
case 4: // Objects/Frontier_Pickups.mod.gml:524
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Pickups.mod.gml:518
{
;
if (((! scrFRInstanceExists((scrFROther(other)))) && scrFRInstanceExists(scrFRSelf(self)))) {
{
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(LevCont))) {
{
fr_bigStrikeChest += _fr.vars._add;
;
}
}
}
}
}
_fr.pc=4;
break;
case 6: // Objects/Frontier_Pickups.mod.gml:518
_fr.wait_ticks=max(0,0); _fr.pc=5; return;
break;
case 7: // Objects/Frontier_Pickups.mod.gml:517
{
_fr.vars._add = (scrFROther(other)).fr_bigStrikeChest;
;
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Pickups.mod.gml:516
_fr.pc = (scrFRTaskFork(_fr, 7)) ? 7 : 1;
break;
case 9: // Objects/Frontier_Pickups.mod.gml:515
scrFRTaskWithEnter(_fr,scrFRWithValues(GameCont),8,0);
break;
case 10: // Objects/Frontier_Pickups.mod.gml:514
_fr.pc = ((fr_bigStrikeChest != 0)) ? 9 : 0;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Pickups.mod.gml:529
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestBig_open() {
GameCont.fr_bigStrikeChest = 0;
;
if (scrFRInstanceIs((scrFROther(other)), Player)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((race == scrFRRaceTryResolve("rogue")) || (race == scrFRRaceTryResolve("vanthro")))) {
{
repeat (2) {
scrFRInstanceCreate(x, y, RogueAmmo);
;
}
}
} else {
{
repeat (15) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Rad)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(4))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
repeat (2) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, BigRad)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
{
repeat (2) {
scrFRInstanceCreate(x, y, RogueAmmo);
;
}
}
}
return false;
;
}

// Original Objects/Frontier_Pickups.mod.gml:562
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RogueChestMaggot";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggot;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggotHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprRogueChestMaggotDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_shadow_y = (- 1);
;
image_speed = (0.4) * timescale;
;
shine = (1 / 16);
;
snd_hurt = sndHitFlesh;
;
snd_dead = sndEXPChest;
;
right = 1;
;
image_xscale = 1;
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_step;
;
on_death = fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_open;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:585
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_step() {
if ((((image_index < 1) && (shine != 1)) && (sprite_index == spr_idle))) {
{
image_index -= (image_speed * (1 - scrFRSourceRandom((shine * scrFRSourceScale()))));
;
}
}
if (scrFRPlaceMeeting(x, y, Player)) {
{
fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_open();
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:594
function fr_Objects_Frontier_Pickups_mod_gml_RogueChestMaggot_open() {
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, RogueAmmo)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (3) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_popoMaggotController")) <= 0)) {
{
scrFRModCall("mod", "Frontier_IDPD", "PopoMaggotController_create", x, y);
;
}
}
scrFRModCall("mod", "Frontier_IDPD", "PopoMaggots_spawn", x, y);
;
}

// Original Objects/Frontier_Pickups.mod.gml:606
function fr_Objects_Frontier_Pickups_mod_gml_HoarderBag_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.obj_create, _frl__x, _frl__y, "LibChest")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_HoarderBag";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprHoarderBag);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprHoarderBagOpen;
;
spr_open = sprFXChestOpen;
snd_open = sndRogueCanister;
;
spr_shadow_y = 1;
;
on_open = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_HoarderBag_open];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:622
function fr_Objects_Frontier_Pickups_mod_gml_HoarderBag_open() {
scrFRInstanceCreate(x, y, PortalClear);
;
fr_Objects_Frontier_Pickups_mod_gml_HoarderBagSpit_create(x, y);
;
}

// Original Objects/Frontier_Pickups.mod.gml:626
function fr_Objects_Frontier_Pickups_mod_gml_HoarderBagSpit_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_HoarderBagSpit";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
treasureSpits = ((clamp(((8 + scrFRSourceIRandom(2)) + (GameCont.hard / 2)), 1, (100 * (1 + (0.45 * scrFRGetSkill(mut_open_mind))))) * 1) + (0.3 * scrFRGetSkill(mut_open_mind)));
;
spitDelay = 0;
;
spitAngle = scrFRSourceRandom(360);
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_HoarderBagSpit_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:639
function fr_Objects_Frontier_Pickups_mod_gml_HoarderBagSpit_step() {
if ((spitDelay > 0)) {
{
spitDelay -= scrFRSourceScale();
;
}
} else {
{
if ((treasureSpits > 0)) {
{
repeat ((1 + scrFRSourceIRandom(1))) {
fr_Objects_Frontier_Pickups_mod_gml_HoarderBagTreasure_create(x, y, (spitAngle + scrFRSourceRandomRange((- 20), 20)));
;
treasureSpits -= 1;
;
spitDelay += 1;
;
spitAngle += 20;
;
}
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:655
function fr_Objects_Frontier_Pickups_mod_gml_HoarderBagTreasure_create(_frl__x=undefined, _frl__y=undefined, _frl__dir=undefined) {
; // macro hoisted: WepMimicID
var _frl__lootPool = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.pool, [[[AmmoPickup, "Basegame", ""], clamp((40 - GameCont.hard), 0, 40)], [[HPPickup, "Basegame", ""], clamp((40 - GameCont.hard), 0, 40)], [[BigRad, "Basegame", ""], clamp((20 - GameCont.hard), 0, 40)], [[AmmoChest, "Basegame", ""], 12], [[WeaponChest, "Basegame", ""], 5], [[BigWeaponChest, "Basegame", ""], 0.4], [[HealthChest, "Basegame", ""], 4], [[RogueChest, "Basegame", ""], 1], [[RadChest, "Basegame", ""], 5], [["MealChest_create", "Mod", "Frontier_Pickups"], 1.5], [[Mimic, "Basegame", ""], 0.5], [[SuperMimic, "Basegame", ""], 0.3], [[frMacro_Objects_Frontier_Pickups_mod_gml_WepMimicID, "Basegame", ""], (0.3 * (1 > 0))], [["MealChestMimic_create", "Mod", "Frontier_Pickups"], 0.1], [["TrinketChest_create", "Mod", "Trinkets"], (4 * scrFRModLoaded("mod", "TreasureTrove"))], [["BonusAmmoChest", "OBJ", "telib"], (0.8 * scrFRModLoaded("mod", "telib"))], [["BonusHealthChest", "OBJ", "telib"], (0.8 * scrFRModLoaded("mod", "telib"))], [["CatChest", "OBJ", "telib"], (0.5 * scrFRModLoaded("mod", "telib"))], [["BatChest", "OBJ", "telib"], (0.5 * scrFRModLoaded("mod", "telib"))], [["RatChest", "OBJ", "telib"], (0.5 * scrFRModLoaded("mod", "telib"))], [["OrchidChest", "OBJ", "telib"], (0.8 * scrFRModLoaded("mod", "telib"))], [["RedChest", "OBJ", "telib"], (0.4 * scrFRModLoaded("mod", "telib"))], [["RedAmmoChest", "OBJ", "telib"], (0.3 * scrFRModLoaded("mod", "telib"))], [["HammerHeadChest", "OBJ", "telib"], (0.5 * scrFRModLoaded("mod", "telib"))], [["SpiritChest", "OBJ", "telib"], (0.4 * scrFRModLoaded("mod", "telib"))]]);
{ var __fr_switch_value1=scrFRIndexGet(_frl__lootPool, 1), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Basegame")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Mod")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("OBJ")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, scrFRIndexGet(_frl__lootPool, 0))), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
{ var __fr_with6 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
z = 8;
;
direction = _frl__dir;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
zspeed = (4 + scrFRSourceRandom(4));
;
zfriction = 0.7;
;
var __fr_other9=scrFROther(other);
creator = __fr_other9;
;
var __fr_other10=scrFROther(other);
depth = __fr_other10.depth;
;
var __fr_other11=scrFROther(other);
mask_index = __fr_other11.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other12=scrFROther(other);
spr_shadow_y = __fr_other12.spr_shadow_y;
;
}
}
}
}
if(__fr_break8) break;
}}
mask_index = mskNone;
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
{ var __fr_with13 = scrFRWithValues(scrFRModCall("mod", scrFRIndexGet(_frl__lootPool, 2), scrFRIndexGet(_frl__lootPool, 0), _frl__x, _frl__y)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
{ var __fr_with16 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
z = 8;
;
direction = _frl__dir;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
zspeed = (4 + scrFRSourceRandom(4));
;
zfriction = 0.7;
;
var __fr_other19=scrFROther(other);
creator = __fr_other19;
;
var __fr_other20=scrFROther(other);
depth = __fr_other20.depth;
;
var __fr_other21=scrFROther(other);
mask_index = __fr_other21.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other22=scrFROther(other);
spr_shadow_y = __fr_other22.spr_shadow_y;
;
}
}
}
}
if(__fr_break18) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break15) break;
}}
}
break;
;
case 2:
{
{ var __fr_with23 = scrFRWithValues(scrFRModCall("mod", scrFRIndexGet(_frl__lootPool, 2), "obj_create", _frl__x, _frl__y, scrFRIndexGet(_frl__lootPool, 0))), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
{ var __fr_with26 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break28=false;
for (var __fr_index27=0; __fr_index27<array_length(__fr_with26); ++__fr_index27) {
if(scrFRScopeExists(__fr_with26[__fr_index27])) with (__fr_with26[__fr_index27]) {
{
z = 8;
;
direction = _frl__dir;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
zspeed = (4 + scrFRSourceRandom(4));
;
zfriction = 0.7;
;
var __fr_other29=scrFROther(other);
creator = __fr_other29;
;
var __fr_other30=scrFROther(other);
depth = __fr_other30.depth;
;
var __fr_other31=scrFROther(other);
mask_index = __fr_other31.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other32=scrFROther(other);
spr_shadow_y = __fr_other32.spr_shadow_y;
;
}
}
}
}
if(__fr_break28) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break25) break;
}}
}
break;
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:748
function fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsCache";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCache);
;
spr_opening = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheOpening;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheOpen;
;
spr_done = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprDeeplabsCacheDone;
;
image_speed = (0.4) * timescale;
;
depth = 1;
;
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Pickups"].shdDeeplabsCache;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Pickups"].mskDeeplabsCache;
;
opened = false;
;
popTime = 30;
;
wepSpit = 3;
;
done = false;
;
hydraulics = false;
;
active = false;
;
openTime = 150;
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_step;
;
on_draw = fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:777
function fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_step() {
var _frl__getOFF = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.instances_meeting, x, y, [Player, WepPickup]);
;
{ var __fr_with1 = scrFRWithValues(_frl__getOFF), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other4.x, __fr_other4.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 3);
}
}
}
}
if(__fr_break3) break;
}}
if ((active == true)) {
{
if ((openTime > 0)) {
{
openTime -= scrFRSourceScale();
;
}
} else {
{
if (((distance_to_object(Player) < 32) && (opened == false))) {
{
opened = true;
;
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_opening);
;
scrFRSoundPitch(sndIDPDNadeAlmost, 0.5);
}
}
if ((sprite_index == spr_opening)) {
{
if ((image_index >= 6)) {
{
if ((hydraulics == false)) {
{
repeat (10) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, (y + scrFRSourceRandomRange((- 12), 3)), Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWhiteSmoke);
;
direction = scrFRSourceChoose(90, 270);
speed = (scrFRSourceRandom(3)) * timescale;
;
image_xscale = 0.5;
;
image_yscale = 0.5;
;
}
}
if(__fr_break7) break;
}}
}
scrFRSoundPitch(sndToxicBoltGas, (0.5 + scrFRSourceRandom(0.1)));
;
hydraulics = true;
;
}
}
}
}
if (frMacro_Objects_Frontier_Pickups_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_open);
;
opened = true;
;
}
}
}
}
if (((opened == true) && (done == false))) {
{
if ((popTime >= 0)) {
{
popTime -= scrFRSourceScale();
;
}
} else {
{
if ((wepSpit > 0)) {
{
wepSpit -= 1;
;
popTime += 20;
;
if ((global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsWepIndex == ds_list_size(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps))) {
{
fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_init();
;
}
}
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", ds_list_find_value(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsWepIndex));
;
ammo = 1;
;
{ var __fr_with11 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisWeaponToss_create", x, y)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
z = 8;
;
direction = (90 + scrFRSourceRandomRange((- 60), 60));
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
zspeed = (4 + scrFRSourceRandom(4));
;
zfriction = 0.7;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
var __fr_other15=scrFROther(other);
depth = __fr_other15.depth;
;
var __fr_other16=scrFROther(other);
mask_index = __fr_other16.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other17=scrFROther(other);
spr_shadow_y = __fr_other17.spr_shadow_y;
;
}
}
}
}
if(__fr_break13) break;
}}
if (scrFRGetSkill("prismaticiris")) {
{
if (scrFRSourceWeaponEqual(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "FR_TemporalRifle")) {
{
roll = true;
;
prismatic = undefined;
;
}
}
}
}
}
}
if(__fr_break10) break;
}}
repeat (5) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprWhiteSmoke);
;
direction = (90 + scrFRSourceRandomRange((- 35), 35));
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
image_xscale = 0.5;
;
image_yscale = 0.5;
;
depth = (- 11);
;
}
}
if(__fr_break20) break;
}}
}
scrFRSoundPitch(sndBouncerShotgun, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndGrenadeRifle, (1.8 + scrFRSourceRandom(0.2)));
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsWepIndex += 1;
;
}
} else {
{
sprite_index = scrFRAreaSourceSprite(spr_done);
;
doned = true;
;
}
}
}
}
}
}
}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:884
function fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_draw() {
scrFRDrawSpriteExt(spr_shadow, 0, x, (y + 10), 1, 1, 0, c_white, 0.4);
;
scrFRDrawSprite(sprite_index, image_index, x, y);
;
}

// Original Objects/Frontier_Pickups.mod.gml:889
function fr_Objects_Frontier_Pickups_mod_gml_DeeplabsCache_init() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsWepIndex = 0;
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps = ds_list_create();
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_TemporalRifle");
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_GluonSlugger");
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_Plaguebringer");
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_HiveLauncher");
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_AR3");
;
ds_list_add(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps, "FR_Wormhole");
;
ds_list_shuffle(global.fr_module_vars[$ "mod:Frontier_Pickups"].deeplabsCacheWeps);
;
}

// Original Objects/Frontier_Pickups.mod.gml:904
function fr_Objects_Frontier_Pickups_mod_gml_AugmentAmmoPickup_resprite() {
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentAmmoOGSprite"))) {
{
fr_augmentAmmoOGSprite = sprite_index;
;
}
}
if ((fr_augmentAmmoOGSprite == sprAmmo)) {
{
if (scrFRVariableExists(scrFRSelf(self), "fr_augmentAmmoTier")) {
{
if ((fr_augmentAmmoTier >= 1)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickup);
;
}
}
if ((fr_augmentAmmoTier >= 2)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickupBig);
;
}
}
if ((fr_augmentAmmoTier >= 3)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentAmmoPickupHuge);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:923
function fr_Objects_Frontier_Pickups_mod_gml_AugmentHealthPickup_resprite() {
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentHealthOGSprite"))) {
{
fr_augmentHealthOGSprite = sprite_index;
;
}
}
if (scrFRGetSkill(mut_second_stomach)) {
{
if (scrFRVariableExists(scrFRSelf(self), "fr_augmentHealthTier")) {
{
fr_augmentHealthTier += 1;
;
}
}
}
}
if ((fr_augmentHealthOGSprite == sprHP)) {
{
if (scrFRVariableExists(scrFRSelf(self), "fr_augmentHealthTier")) {
{
if ((fr_augmentHealthTier >= 1)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickup);
;
}
}
if ((fr_augmentHealthTier >= 2)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickupBig);
;
}
}
if ((fr_augmentHealthTier >= 3)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprAugmentHealthPickupHuge);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:951
function fr_Objects_Frontier_Pickups_mod_gml_MealMimic_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicFire;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicDead;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealMimicTell;
;
spr_shadow = shd24;
;
hitid = [spr_chrg, "MEAL MIMIC"];
;
snd_hurt = sndMimicHurt;
;
snd_dead = sndMimicDead;
;
snd_mele = sndMimicMelee;
;
snd_tell = sndMimicSlurp;
;
{ var __fr_switch_value4=scrFRCrownCurrent(), __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(crwn_none)) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==(crwn_curses)) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=2;
switch(__fr_switch_case5) {
case 0:
curse = false;
;
break;
;
case 1:
curse = (scrFRSourceRandom(3) < 2);
break;
;
case 2:
curse = (scrFRSourceRandom(7) < 1);
;
}
}
if ((curse > 0)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicFire;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicDead;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprCursedMealMimicTell;
;
hitid = [spr_chrg, "CURSED MEAL MIMIC"];
;
}
}
mask_index = (- 1);
;
scrFRMaxHealthWrite(id, 12, "=");
;
hp = max_hp;
;
raddrop = 6;
;
size = 1;
;
maxspeed = (2) * timescale;
;
meleedamage = 3;
;
tell_wait_min = 90;
;
tell_wait_max = 240;
;
meal = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealList, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealList) - 1))));
;
mealCursed = curse;
;
tk_canBag = true;
;
scrFRAlarmWrite(scrFRSelf(self), 1, scrFRSourceRandomRange(tell_wait_min, tell_wait_max), "=");
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_MealMimic_step;
;
on_death = fr_Objects_Frontier_Pickups_mod_gml_MealMimic_death;
;
on_alrm1 = ["mod", "Frontier_Pickups", fr_Objects_Frontier_Pickups_mod_gml_MealMimic_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:1009
function fr_Objects_Frontier_Pickups_mod_gml_MealMimic_step() {
if (frMacro_Objects_Frontier_Pickups_mod_gml_alarm1_run) {
exit;
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((sprite_index != spr_chrg) || frMacro_Objects_Frontier_Pickups_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Pickups_mod_gml_enemy_sprite);
;
}
}
if ((((sprite_index != spr_hurt) && fr_Objects_Frontier_Pickups_mod_gml_enemy_target(x, y)) && scrFRPlaceMeeting(x, y, target))) {
{
sprite_index = scrFRAreaSourceSprite(spr_walk);
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1027
function fr_Objects_Frontier_Pickups_mod_gml_MealMimic_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, scrFRSourceRandomRange(tell_wait_min, tell_wait_max), "=");
;
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
image_index = 0;
;
scrFRSoundHit(snd_tell, 0.1);
;
}

// Original Objects/Frontier_Pickups.mod.gml:1035
function fr_Objects_Frontier_Pickups_mod_gml_MealMimic_death() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Pickups_mod_gml_MealPickup_create(x, y, meal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
mealCursed = __fr_other4.mealCursed;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:1042
function fr_Objects_Frontier_Pickups_mod_gml_MealPickup_create(_frl__x=undefined, _frl__y=undefined, _frl__meal=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_MealPickup";
;
meal_index = _frl__meal;
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
meal_sprite = meal_index.meal_sprite;
;
image_index = meal_index.spr_index;
;
ybob = y;
;
mask_index = mskWepPickup;
;
spr_shadow = shd16;
;
image_speed = (0) * timescale;
;
depth = (- 1);
;
mod2Call = meal_index.mod2Call;
;
script2Call = meal_index.script2Call;
;
meal_name = meal_index.meal_name;
;
meal_text = meal_index.meal_text;
;
mealCursed = meal_index.mealCursed;
;
mealCursedCheck = false;
;
status1Effect = meal_index.status1Effect;
;
status1Time = meal_index.status1Time;
;
status2Effect = meal_index.status2Effect;
;
status2Time = meal_index.status2Time;
;
status3Effect = meal_index.status3Effect;
;
status3Time = meal_index.status3Time;
;
status4Effect = meal_index.status4Effect;
;
status4Time = meal_index.status4Time;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.prompt_create, "")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Pickups_mod_gml_MealPickupPrompt_step;
on_end_step = fr_Objects_Frontier_Pickups_mod_gml_MealPickupPrompt_end_step;
;
var __fr_other7=scrFROther(other);
meal_name = __fr_other7.meal_name;
;
var __fr_other8=scrFROther(other);
meal_text = __fr_other8.meal_text;
;
var __fr_other9=scrFROther(other);
creator = __fr_other9;
;
}
}
if(__fr_break6) break;
}}
on_draw = fr_Objects_Frontier_Pickups_mod_gml_MealPickup_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:1097
function fr_Objects_Frontier_Pickups_mod_gml_meal_init() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory = ds_map_create();
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultMeal = {"mod2Call": "Frontier_StatusEffects", "script2Call": "status_apply_add", "meal_name": "DEFAULT", "meal_text": "DESCRIPTION", "meal_sprite": global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealPickup, "spr_index": 0, "mealHot": false, "mealCursed": false, "status1Effect": "buffBloodLust", "status1Time": 60, "status2Effect": undefined, "status2Time": undefined, "status3Effect": undefined, "status3Time": undefined, "status4Effect": undefined, "status4Time": undefined};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"none"] = {"meal_name": "EXAMPLE MEAL", "meal_text": "@g+@w2 SECONDS@s OF @(color:2964142)BONUS BLOODLUST", "spr_index": 0, "status1Effect": "buffBloodLust", "status1Time": 60};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonusammogain"] = {"meal_name": scrFRLoc("Frontier:Meal1:Name", "MUNITIONS MUNCHY"), "meal_text": scrFRLoc("Frontier:Meal1:Text", "@g+@w60 SECONDS @sOF @yBONUS AMMO GAIN"), "spr_index": 1, "status1Effect": "buffAmmoGain", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonusmaxhealth"] = {"meal_name": scrFRLoc("Frontier:Meal2:Name", "SALUBRIOUS SASHIMI"), "meal_text": scrFRLoc("Frontier:Meal2:Text", "@g+@w60 SECONDS @sOF @rBONUS MAX HEALTH"), "spr_index": 2, "mealHot": true, "status1Effect": "buffHealthUp", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonushealing"] = {"meal_name": scrFRLoc("Frontier:Meal3:Name", "HEARTY SALAD"), "meal_text": scrFRLoc("Frontier:Meal3:Text", "@g+@w60 SECONDS @sOF @rBONUS HEALING"), "spr_index": 3, "status1Effect": "buffBonusHeal", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"reloadspeed"] = {"meal_name": scrFRLoc("Frontier:Meal4:Name", "SPEEDLOAD SMOOTHIE"), "meal_text": scrFRLoc("Frontier:Meal4:Text", "@g+@w60 SECONDS @sOF @wBONUS RELOAD SPEED"), "spr_index": 5, "status1Effect": "buffFirerateUp", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"speedup"] = {"meal_name": scrFRLoc("Frontier:Meal5:Name", "SAILFISH SLIDERS"), "meal_text": scrFRLoc("Frontier:Meal5:Text", "@g+@w60 SECONDS @sOF @wBONUS MOVEMENT SPEED"), "spr_index": 6, "mealHot": true, "status1Effect": "buffSpeedUp", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"poppop"] = {"meal_name": "JALAPEÑO POPPERS", "meal_text": "@g+@w60 SECONDS @sOF @wSHOT DUPLICATION CHANCE", "spr_index": 7, "mealHot": true, "status1Effect": "buffPoppop", "status1Time": 1800};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"big_burger"] = {"meal_name": scrFRLoc("Frontier:Meal100:Name", "THE BIG BURGER"), "meal_text": scrFRLoc("Frontier:Meal100:Text", "@g+@w60 SECONDS @sOF @yBONUS AMMO GAIN#\r\n\t\t\t\t\t\t   @g+@w60 SECONDS @sOF @rBONUS MAX HEALTH#\r\n\t\t\t\t\t\t   @g+@w60 SECONDS @sOF @rBONUS HEALING#\r\n\t\t\t\t\t\t   @g+@w60 SECONDS @sOF @wBONUS RELOAD SPEED#\r\n\t\t\t\t\t\t   @g+@w60 SECONDS @sOF @wBONUS MOVEMENT SPEED"), "spr_index": 4, "status1Effect": undefined, "status1Time": undefined, "mod2Call": "Frontier_Pickups", "script2Call": "meal_status_bigburger"};
;
}

// Original Objects/Frontier_Pickups.mod.gml:1190
function fr_Objects_Frontier_Pickups_mod_gml_meal_status_bigburger() {
{ var __fr_with1 = scrFRWithValues(instance_nearest(x, y, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), scrFRModGet("mod", "Frontier_StatusEffects", "buffAmmoGain"), 1800);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), scrFRModGet("mod", "Frontier_StatusEffects", "buffHealthUp"), 1800);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), scrFRModGet("mod", "Frontier_StatusEffects", "buffBonusHeal"), 1800);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), scrFRModGet("mod", "Frontier_StatusEffects", "buffFirerateUp"), 1800);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", instance_nearest(x, y, Player), scrFRModGet("mod", "Frontier_StatusEffects", "buffSpeedUp"), 1800);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:1199
function fr_Objects_Frontier_Pickups_mod_gml_meal_rank() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].mealList = [global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonusammogain"], global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonusmaxhealth"], global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"bonushealing"], global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"reloadspeed"], global.fr_module_vars[$ "mod:Frontier_Pickups"].MealDirectory[?"speedup"]];
;
}

// Original Objects/Frontier_Pickups.mod.gml:1210
function fr_Objects_Frontier_Pickups_mod_gml_mealCurses_init() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory = ds_map_create();
global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultMealCurse = {"Mod2Call": "Frontier_StatusEffects", "Script2Call": "status_apply_add", "curseStatusEffect": "buffBloodLust", "curseName": "DEFAULT EFFECT", "curseTime": [0, 0, 0]};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory[?"none"] = {"curseStatusEffect": "buffBloodLust", "curseName": "BLANK CURSE EFFECT", "curseTime": [0, 0, 0]};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory[?"maxhealthloss"] = {"curseStatusEffect": "debuffHealthDown", "curseName": scrFRLoc("Frontier:MealCurseText:0", "LOST MAX HEALTH"), "curseTime": [900, 1350, 1800, 2250, 2700]};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory[?"blight"] = {"curseStatusEffect": "debuffBlight", "curseName": scrFRLoc("Frontier:MealCurseText:1", "BLIGHT"), "curseTime": [900, 1050, 1200, 1350, 1500, 1650, 1800]};
;
}

// Original Objects/Frontier_Pickups.mod.gml:1238
function fr_Objects_Frontier_Pickups_mod_gml_mealCurses_rank() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].mealCursesList = [global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory[?"maxhealthloss"], global.fr_module_vars[$ "mod:Frontier_Pickups"].MealCursesDirectory[?"blight"]];
;
}

// Original Objects/Frontier_Pickups.mod.gml:1246
function fr_Objects_Frontier_Pickups_mod_gml_INCITE_MEAL_HEX() {
meal_curse = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealCursesList, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].mealCursesList) - 1))));
;
statusCurseName = meal_curse.curseName;
;
statusCurseTime = scrFRIndexGet(meal_curse.curseTime, scrFRSourceIRandom((array_length(meal_curse.curseTime) - 1)));
statusCurseEffect = meal_curse.curseStatusEffect;
;
meal_name = ("@q" + string(meal_name));
;
meal_text = ((((string(meal_text) + "#@(color:4529874)+@w") + string((statusCurseTime / 30))) + " SECONDS @sOF @(color:4529874)") + string(statusCurseName));
image_blend = make_colour_rgb(143, 99, 182);
;
}

// Original Objects/Frontier_Pickups.mod.gml:1263
function fr_Objects_Frontier_Pickups_mod_gml_MealPickupPrompt_step() {
if (scrFRInstanceExists(creator)) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (mealCursed) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), Curse);
;
}
}
if ((mealCursedCheck == false)) {
{
mealCursedCheck = true;
;
fr_Objects_Frontier_Pickups_mod_gml_INCITE_MEAL_HEX();
}
}
}
} else {
{
if ((scrFRSourceRandom(60) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), CaveSparkle)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprMealSparkle);
;
speed = (0.5) * timescale;
;
direction = 90;
;
depth = (- 2);
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
}
if(__fr_break3) break;
}}
}
}
if ((pick != (- 1))) {
{
scrFRSoundPitchVolume(sndBloodlustProc, 0.8, 1);
if ((creator.status1Effect != undefined)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), scrFRModGet("mod", creator.mod2Call, creator.status1Effect), creator.status1Time);
}
}
if ((creator.status2Effect != undefined)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), scrFRModGet("mod", creator.mod2Call, creator.status2Effect), creator.status2Time);
}
}
if ((creator.status3Effect != undefined)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), scrFRModGet("mod", creator.mod2Call, creator.status3Effect), creator.status3Time);
}
}
if ((creator.status4Effect != undefined)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), scrFRModGet("mod", creator.mod2Call, creator.status4Effect), creator.status4Time);
}
}
if ((creator.status1Effect == undefined)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call);
}
}
if ((creator.mealCursed == true)) {
{
scrFRModCall("mod", creator.mod2Call, creator.script2Call, instance_nearest(x, y, Player), scrFRModGet("mod", creator.mod2Call, creator.statusCurseEffect), creator.statusCurseTime);
}
}
frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_set, "Frontier", "meals_eaten", (frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_get, "Frontier", "meals_eaten") + 1));
{ var __fr_with7 = scrFRWithValues([creator, scrFRSelf(self)]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1333
function fr_Objects_Frontier_Pickups_mod_gml_MealPickupPrompt_end_step() {
if ((creator != noone)) {
{
if (scrFRInstanceExists(creator)) {
{
if (scrFRInstanceExists(nearwep)) {
{
{ var __fr_with1 = scrFRWithValues(nearwep), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x += (__fr_other4.creator.x - __fr_other4.x);
;
var __fr_other5=scrFROther(other);
y += (__fr_other5.creator.y - __fr_other5.y);
;
visible = true;
;
}
}
if(__fr_break3) break;
}}
if (scrFRInstanceExists(creator)) {
{
scrFRBindDraw(fr_Objects_Frontier_Pickups_mod_gml_MealPickup_text, (- 1000), round(creator.x), round(creator.y), creator.meal_name, creator.meal_text);
}
}
}
}
x = creator.x;
;
y = creator.y;
;
}
} else {
scrFRInstanceDestroy();
}
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1353
function fr_Objects_Frontier_Pickups_mod_gml_MealPickup_draw() {
ybob = (y + (sin((scrFRSourceFrame() * 0.10)) * 2));
;
scrFRDrawSpriteExt(meal_sprite, meal_index.spr_index, x, ybob, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

// Original Objects/Frontier_Pickups.mod.gml:1357
function fr_Objects_Frontier_Pickups_mod_gml_MealPickup_text(_frl__x=undefined, _frl__y=undefined, _frl__mealName=undefined, _frl__description=undefined) {
scrFRInstanceDestroy();
var _frl_halign = draw_get_halign();
var _frl_valign = draw_get_valign();
var _frl_yoff = ((6 * round((string_count("#", _frl__description) + 1))) + 22);
draw_set_font(fntSmall);
;
draw_set_halign(1);
draw_set_valign(0);
scrFRDrawText(_frl__x, (_frl__y - _frl_yoff), _frl__description);
draw_set_font(fntM1);
;
draw_set_valign(2);
scrFRDrawText(_frl__x, ((_frl__y - _frl_yoff) - 1), _frl__mealName);
draw_set_halign(_frl_halign);
draw_set_valign(_frl_valign);
}

// Original Objects/Frontier_Pickups.mod.gml:1378
function fr_Objects_Frontier_Pickups_mod_gml_fish_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Pickups_mod_gml_fish_init_resume, id, scrFROther(other), _args, 8, []);
}
function fr_Objects_Frontier_Pickups_mod_gml_fish_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Pickups_mod_gml_fish_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Pickups.mod.gml:1434
{
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory = ds_map_create();
global.fr_module_vars[$ "mod:Frontier_Pickups"].defaultFish = {"fish_name": "DEFAULT", "spr_index": 0, "min_weight": 0, "max_weight": 0, "save_stat": "default"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"none"] = {"fish_name": "NO FISH", "spr_index": 0, "min_weight": 0, "max_weight": 0, "save_stat": "none"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bonefish"] = {"fish_name": "BONEFISH", "spr_index": 1, "min_weight": 12, "max_weight": 40, "save_stat": "bonefish"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bucket_crab"] = {"fish_name": "BUCKET CRAB", "spr_index": 2, "min_weight": 5, "max_weight": 30, "save_stat": "bucket_crab"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"gator_gar"] = {"fish_name": "GATOR GAR", "spr_index": 3, "min_weight": 90, "max_weight": 320, "save_stat": "gator_gar"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"coldsnapper"] = {"fish_name": "COLDSNAPPER", "spr_index": 4, "min_weight": 20, "max_weight": 45, "save_stat": "coldsnapper"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"blue_jelly"] = {"fish_name": "BLUE JELLY", "spr_index": 5, "min_weight": 0.5, "max_weight": 6, "save_stat": "blue_jelly"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"green_jelly"] = {"fish_name": "GREEN JELLY", "spr_index": 6, "min_weight": 0.5, "max_weight": 6, "save_stat": "green_jelly"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"purple_jelly"] = {"fish_name": "PURPLE JELLY", "spr_index": 7, "min_weight": 0.5, "max_weight": 6, "save_stat": "purple_jelly"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"crystal_jelly"] = {"fish_name": "CRYSTAL JELLY", "spr_index": 8, "min_weight": 3, "max_weight": 12, "save_stat": "crystal_jelly"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"dopey_fish"] = {"fish_name": "DOPEY FISH", "spr_index": 9, "min_weight": 100, "max_weight": 400, "save_stat": "dopey_fish"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"toxfin"] = {"fish_name": "TOXFIN", "spr_index": 10, "min_weight": 4, "max_weight": 30, "save_stat": "toxfin"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bulbler"] = {"fish_name": "BULBLER", "spr_index": 11, "min_weight": 30, "max_weight": 80, "save_stat": "bulbler"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"pisces"] = {"fish_name": "PISCES", "spr_index": 12, "min_weight": 20, "max_weight": 50, "save_stat": "pisces"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"grey_kingfish"] = {"fish_name": "GREY KINGFISH", "spr_index": 13, "min_weight": 50, "max_weight": 110, "save_stat": "grey_kingfish"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"clownfish"] = {"fish_name": "CLOWNFISH", "spr_index": 14, "min_weight": 5, "max_weight": 30, "save_stat": "clownfish"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"maggot_fish"] = {"fish_name": "MAGGOT FISH", "spr_index": 15, "min_weight": 2, "max_weight": 16, "save_stat": "maggot_fish"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"holesquid"] = {"fish_name": "HOLESQUID", "spr_index": 16, "min_weight": 20, "max_weight": 32, "save_stat": "holesquid"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"clam"] = {"fish_name": "CLAM", "spr_index": 17, "min_weight": 5, "max_weight": 30, "save_stat": "clam"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"golden_clam"] = {"fish_name": "GOLDEN CLAM", "spr_index": 18, "min_weight": 15, "max_weight": 60, "save_stat": "golden_clam"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"kelpie"] = {"fish_name": "KELPIE", "spr_index": 19, "min_weight": 5, "max_weight": 35, "save_stat": "kelpie"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bombino"] = {"fish_name": "BOMBINO", "spr_index": 20, "min_weight": 50, "max_weight": 140, "save_stat": "bombino"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"rainbow_trout"] = {"fish_name": "RAINBOW TROUT", "spr_index": 0, "min_weight": 20, "max_weight": 50, "save_stat": "rainbow_trout"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"coelacanth"] = {"fish_name": "COELACANTH", "spr_index": 0, "min_weight": 150, "max_weight": 220, "save_stat": "coelacanth"};
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"abyss_coelacanth"] = {"fish_name": "ABYSSAL COELACANTH", "spr_index": 0, "min_weight": 350, "max_weight": 530, "save_stat": "abyss_coelacanth"};
;
}
_fr.pc=0;
break;
case 2: // Objects/Frontier_Pickups.mod.gml:1430
{
;
}
_fr.pc=1;
break;
case 3: // Objects/Frontier_Pickups.mod.gml:1430
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Objects/Frontier_Pickups.mod.gml:1386
{
frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_load, "Frontier_Fishing", {"fish_caught": 0, "bonefish_caught": 0, "bonefish_record": 0, "bucket_crab_caught": 0, "bucket_crab_record": 0, "gator_gar_caught": 0, "gator_gar_record": 0, "coldsnapper_caught": 0, "coldsnapper_record": 0, "blue_jelly_caught": 0, "blue_jelly_record": 0, "green_jelly_caught": 0, "green_jelly_record": 0, "purple_jelly_caught": 0, "purple_jelly_record": 0, "crystal_jelly_caught": 0, "crystal_jelly_record": 0, "dopey_fish_caught": 0, "dopey_fish_record": 0, "toxfin_caught": 0, "toxfin_record": 0, "bulbler_caught": 0, "bulbler_record": 0, "pisces_caught": 0, "pisces_record": 0, "grey_kingfish_caught": 0, "grey_kingfish_record": 0, "clownfish_caught": 0, "clownfish_record": 0, "maggot_fish_caught": 0, "maggot_fish_record": 0, "holesquid_caught": 0, "holesquid_record": 0, "clam_caught": 0, "clam_record": 0, "golden_clam_caught": 0, "golden_clam_record": 0, "kelpie_caught": 0, "kelpie_record": 0, "bombino_caught": 0, "bombino_record": 0});
;
}
_fr.pc=3;
break;
case 6: // Objects/Frontier_Pickups.mod.gml:1382
{
;
}
_fr.pc=5;
break;
case 7: // Objects/Frontier_Pickups.mod.gml:1382
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Objects/Frontier_Pickups.mod.gml:1382
_fr.pc=((! scrFRModLoaded("mod", "libSaves")))?7:4;
break;
case 8: // Objects/Frontier_Pickups.mod.gml:1381
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Pickups.mod.gml:1472
function fr_Objects_Frontier_Pickups_mod_gml_fish_rank() {
global.fr_module_vars[$ "mod:Frontier_Pickups"].CommonFish = [global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bonefish"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bucket_crab"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"gator_gar"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"blue_jelly"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"clam"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"kelpie"]];
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].UncommonFish = [global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"coldsnapper"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"green_jelly"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"purple_jelly"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"toxfin"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"pisces"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bombino"]];
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].RareFish = [global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"crystal_jelly"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"bulbler"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"clownfish"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"maggot_fish"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"golden_clam"]];
;
global.fr_module_vars[$ "mod:Frontier_Pickups"].UltraFish = [global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"dopey_fish"], global.fr_module_vars[$ "mod:Frontier_Pickups"].FishDirectory[?"holesquid"]];
;
}

// Original Objects/Frontier_Pickups.mod.gml:1506
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_FishingPickup";
;
var _frl__FishPool = [[scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].CommonFish, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].CommonFish) - 1)))), 70], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].UncommonFish, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].UncommonFish) - 1)))), 24], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].RareFish, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].RareFish) - 1)))), 5], [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Pickups"].UltraFish, round(scrFRSourceRandomRange(0, (array_length_1d(global.fr_module_vars[$ "mod:Frontier_Pickups"].UltraFish) - 1)))), 1]];
;
fish_index = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.pool, _frl__FishPool);
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
fish_sprite = global.fr_module_vars[$ "mod:Frontier_Pickups"].sprFishPickup;
;
image_index = fish_index.spr_index;
;
mask_index = mskBigRad;
;
ybob = y;
;
tilt = 0;
;
spr_shadow = shd16;
;
image_speed = (0) * timescale;
;
depth = (- 1);
;
vbob_speed = scrFRSourceRandom(0.15);
;
hbob_speed = scrFRSourceRandom(0.08);
;
deposit_real = false;
;
depositme = false;
;
deposit_x = x;
;
deposit_y = y;
;
my_deposit = noone;
;
fish_name = fish_index.fish_name;
;
var _frl_weightnum = scrFRSourceRandomRange(fish_index.min_weight, fish_index.max_weight);
var _frl_weightdiff = (_frl_weightnum - fish_index.min_weight);
var _frl_weightcalc = ((_frl_weightnum - (scrFRSourceRandom(_frl_weightdiff) / 2)) - (scrFRSourceRandom(_frl_weightdiff) / 3));
var _frl_weightfinal = clamp((round((_frl_weightcalc * 100)) / 100), fish_index.min_weight, fish_index.max_weight);
weight = _frl_weightfinal;
weight_text = (string_format(_frl_weightfinal, 0, 2) + "@sLB");
current_record = frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_get, "Frontier_Fishing", (fish_index.save_stat + "_record"));
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.prompt_create, "")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mask_index = mskBigRad;
;
on_step = fr_Objects_Frontier_Pickups_mod_gml_FishingPickupPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
var __fr_other8=scrFROther(other);
fish_index = __fr_other8.fish_index;
;
var __fr_other9=scrFROther(other);
weight = __fr_other9.weight;
;
var __fr_other10=scrFROther(other);
current_record = __fr_other10.current_record;
;
}
}
if(__fr_break6) break;
}}
on_step = fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_step;
on_end_step = fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_end_step;
;
on_draw = fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Pickups.mod.gml:1584
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_step() {
ybob = (y + (sin((scrFRSourceFrame() * vbob_speed)) * 3));
;
tilt = (sin((scrFRSourceFrame() * hbob_speed)) * 10);
;
if ((depositme == true)) {
{
if ((deposit_real == false)) {
{
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (scrFRSourceRandom(5)) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((deposit_real == true)) {
{
scrFRMotionAdd(point_direction(x, y, deposit_x, deposit_y), 0.5);
if (((speed / timescale) > 10)) {
{
speed = (10) * timescale;
}
}
tilt = ((speed / timescale) * 10);
{ var __fr_with4 = scrFRWithValues(my_deposit), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
activetime = 10;
;
}
}
if(__fr_break6) break;
}}
if (scrFRPlaceMeeting(x, y, my_deposit)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1616
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickupPrompt_step() {
if ((pick != (- 1))) {
{
scrFRSoundPitchVolume(sndBloodlustProc, 0.8, 1);
var _frl_saveFish = fish_index.save_stat;
;
frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_set, "Frontier_Fishing", "fish_caught", (frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_get, "Frontier_Fishing", "fish_caught") + 1));
frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_set, "Frontier_Fishing", (_frl_saveFish + "_caught"), (frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_get, "Frontier_Fishing", (_frl_saveFish + "_caught")) + 1));
if ((weight > current_record)) {
{
frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_set, "Frontier_Fishing", (_frl_saveFish + "_record"), string_format(weight, 0, 2));
;
if ((frMacro_Objects_Frontier_Pickups_mod_gml_call(frMacro_Objects_Frontier_Pickups_mod_gml_scr.save_get, "Frontier_Fishing", (_frl_saveFish + "_caught")) == 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mytext = scrFRLocalize(scrFRLoc("Frontier:Fishing:0", "FIRST CATCH!"));
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mytext = scrFRLocalize(scrFRLoc("Frontier:Fishing:1", "NEW RECORD!"));
;
}
}
if(__fr_break6) break;
}}
}
}
scrFRSoundPlay(sndPartyHorn);
repeat (30) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Confetti)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = (scrFRSourceRandom(5)) * timescale;
direction = scrFRSourceRandom(360);
z = scrFRSourceRandom(3);
}
}
if(__fr_break9) break;
}}
}
}
}
{ var __fr_with10 = scrFRWithValues(creator), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
depositme = true;
;
}
}
if(__fr_break12) break;
}}
}
}
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1667
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_end_step() {
if (instance_place(x, y, Player)) {
{
scrFRBindDraw(fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_text, (- 11), x, y, fish_name, weight_text, instance_nearest(x, y, Player));
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1673
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_text(_frl__x=undefined, _frl__y=undefined, _frl__fish_name=undefined, _frl__weight=undefined, _frl__player=undefined) {
scrFRInstanceDestroy();
var _frl_halign = draw_get_halign();
var _frl_valign = draw_get_valign();
;
var _frl_yoff = ((6 * round((string_count("#", _frl__weight) + 1))) + 22);
var _frl_replacey = ((_frl_yoff - (6 * round((string_count("#", _frl__weight) + 1)))) - 12);
var _frl_xtextoff = 0;
;
draw_set_font(fntSmall);
;
draw_set_halign(1);
draw_set_valign(0);
scrFRDrawText((_frl__x + _frl_xtextoff), (_frl__y - _frl_yoff), _frl__weight);
draw_set_font(fntM1);
;
draw_set_valign(2);
scrFRDrawText((_frl__x + _frl_xtextoff), ((_frl__y - _frl_yoff) - 1), _frl__fish_name);
draw_set_halign(_frl_halign);
draw_set_valign(_frl_valign);
}

// Original Objects/Frontier_Pickups.mod.gml:1694
function fr_Objects_Frontier_Pickups_mod_gml_FishingPickup_draw() {
scrFRDrawSpriteExt(fish_sprite, fish_index.spr_index, x, ybob, image_xscale, image_yscale, tilt, image_blend, image_alpha);
}

// Original Objects/Frontier_Pickups.mod.gml:1701
function fr_Objects_Frontier_Pickups_mod_gml_list_finalize(_frl__directory=undefined, _frl__defaultItem=undefined) {
var _frl_keys = ds_map_keys_to_array(_frl__directory);
var _frl_len = array_length(_frl_keys);
var _frl__item = undefined;
var _frl__defkeys = [];
var _frl__defvalues = [];
var _frl__defn = 0;
;
{
var _frl_o = 0;
for (; (_frl_o < scrFRLQSize(_frl__defaultItem)); _frl_o++) {
array_push(_frl__defkeys, scrFRLQKey(_frl__defaultItem, _frl_o));
array_push(_frl__defvalues, scrFRLQValue(_frl__defaultItem, _frl_o));
}
}
{
var _frl_i = 0;
for (; (_frl_i < _frl_len); _frl_i++) {
_frl__item = _frl__directory[?scrFRIndexGet(_frl_keys, _frl_i)];
;
_frl__item.key = scrFRIndexGet(_frl_keys, _frl_i);
_frl__defn = 0;
{ var __fr_with1 = scrFRWithValues(_frl__defkeys), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRLQSet(_frl__item, scrFRSelf(self), scrFRLQGet(_frl__item, scrFRSelf(self), scrFRIndexGet(_frl__defvalues, (_frl__defn++))));
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Pickups.mod.gml:1721
function fr_Objects_Frontier_Pickups_mod_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Objects/Frontier_Pickups.mod.gml:1724
function fr_Objects_Frontier_Pickups_mod_gml_generic_trail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Pickups"].sprGenericTrail);
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

// Original Objects/Frontier_Pickups.mod.gml:1736
function fr_Objects_Frontier_Pickups_mod_gml_TrinketChest_create(_frl__x=undefined, _frl__y=undefined) {
scrFRModCall("mod", "Trinkets", "TrinketChest_create", _frl__x, _frl__y);
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
; // macro hoisted: anim_end
; // macro hoisted: enemy_sprite
; // macro hoisted: alarm0_run
; // macro hoisted: alarm1_run
; // macro hoisted: alarm2_run
}

// Original Objects/Frontier_Pickups.mod.gml:1747
function fr_Objects_Frontier_Pickups_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}
