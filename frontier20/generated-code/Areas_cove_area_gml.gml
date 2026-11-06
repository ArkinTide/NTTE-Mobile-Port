#macro frMacro_Areas_cove_area_gml_scr global.fr_module_vars[$ "area:cove"].scr

#macro frMacro_Areas_cove_area_gml_call scrFRScriptCall

#macro frMacro_Areas_cove_area_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Areas_cove_area_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

// Original Areas/cove.area.gml:1
function fr_Areas_cove_area_gml___load() {

}

// Original Areas/cove.area.gml:1
function fr_Areas_cove_area_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_cove_area_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Areas_cove_area_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_cove_area_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/cove.area.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "area", "cove", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "area:cove"].settingAltCoveEntrance = false;
;
global.fr_module_vars[$ "area:cove"].musCove = sndFR_musCove_96f2af93e847;
;
global.fr_module_vars[$ "area:cove"].sndAhoy = sndFR_sndAhoy_813d4e684f0f;
;
global.fr_module_vars[$ "area:cove"].sndWoodBreak = sndFR_sndWoodBreak_f483cf606c9f;
;
global.fr_module_vars[$ "area:cove"].sndGunpowderBarrelBreak = sndFR_sndGunpowderBarrelBreak_2f4315aec484;
;
global.fr_module_vars[$ "area:cove"].sndTreasureBarrelBreak = sndFR_sndTreasureBarrelBreak_0994e2b71635;
;
global.fr_module_vars[$ "area:cove"].sprAreaIcon = sprFR_sprCoveIcon_ad23cc3b4f8e;
;
global.fr_module_vars[$ "area:cove"].sprFloor = sprFR_sprFloorCove_5de89e192d58;
;
global.fr_module_vars[$ "area:cove"].sprFloorB = sprFR_sprFloorCoveBBig_88455e541897;
;
global.fr_module_vars[$ "area:cove"].sprFloorC = sprFR_sprFloorCoveC_565001436af9;
;
global.fr_module_vars[$ "area:cove"].sprSnowFloorC = sprFR_sprSnowFloorCoveC_6be8e0fb1620;
;
global.fr_module_vars[$ "area:cove"].sprFloorExplo = sprFR_sprFloorCoveExplo_84f178e95ca7;
;
global.fr_module_vars[$ "area:cove"].sprWallBot = sprFR_sprWallCoveBot_e6e023b6f835;
;
global.fr_module_vars[$ "area:cove"].sprWallTop = sprFR_sprWallCoveTop_a1478f22b73c;
;
global.fr_module_vars[$ "area:cove"].sprWallOut = sprFR_sprWallCoveOut_7531a835b2d5;
;
global.fr_module_vars[$ "area:cove"].sprWallBotB = sprFR_sprWallCoveBBot_3625a8e8c791;
;
global.fr_module_vars[$ "area:cove"].sprWallTopB = sprFR_sprWallCoveBTop_ff69e4a37402;
;
global.fr_module_vars[$ "area:cove"].sprWallOutB = sprFR_sprWallCoveBOut_5e56055f7ecb;
;
global.fr_module_vars[$ "area:cove"].sprWallTrans = sprFR_sprWallCoveTrans_3ee1134f6b2d;
;
global.fr_module_vars[$ "area:cove"].sprDebris = sprFR_sprDebrisCove_9d30398d10b5;
;
global.fr_module_vars[$ "area:cove"].sprDetail = sprFR_sprDetailCove_0c0884437d99;
;
global.fr_module_vars[$ "area:cove"].sprTopDecal = sprFR_sprTopDecalCove_6baf39015b9f;
;
global.fr_module_vars[$ "area:cove"].sprAHOY = sprFR_sprAHOY_79c831cff7ee;
;
global.fr_module_vars[$ "area:cove"].sprCoveDrip = sprFR_sprCoveDrip_002dc1e9e7d4;
;
global.fr_module_vars[$ "area:cove"].sprGemSparkle = sprFR_sprGemSparkle_f508b6dc0276;
;
global.fr_module_vars[$ "area:cove"].sprWallCoveBTransSpread = sprFR_sprWallCoveBTransSpread_278e841194d5;
;
global.fr_module_vars[$ "area:cove"].sprDabloons = sprFR_sprDabloons_0593a1206097;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicIdle = sprFR_sprTreasureMimicIdle_5b0df4413f5f;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicPeek = sprFR_sprTreasureMimicPeek_e2c48c82facc;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicStartPeek = sprFR_sprTreasureMimicStartPee_dea515e6f7cd;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicEndPeek = sprFR_sprTreasureMimicEndPeek_e845d3b2b237;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicStartHungry = sprFR_sprTreasureMimicStartHun_6145c1320f77;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicHungry = sprFR_sprTreasureMimicHungry_fbc485a689bc;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicEndHungry = sprFR_sprTreasureMimicEndHungr_d4a74c3112eb;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicEat = sprFR_sprTreasureMimicEat_9284e2a915df;
;
global.fr_module_vars[$ "area:cove"].sprTreasureMimicDeny = sprFR_sprTreasureMimicDeny_982fd795f939;
;
global.fr_module_vars[$ "area:cove"].sprGunpowderBarrel = sprFR_sprGunpowderBarrel_a71207be20bc;
;
global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelHurt = sprFR_sprGunpowderBarrelHurt_905562f5c059;
;
global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelDead = sprFR_sprGunpowderBarrelDead_cb31862542fe;
;
global.fr_module_vars[$ "area:cove"].shdGunpowderBarrel = sprFR_shdGunpowderBarrel_95971f694f46;
;
global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelDebris = sprFR_sprGunpowderBarrelDebris_bc48a0efb571;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrel = sprFR_sprTreasureBarrel_ac206a084d20;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrelHurt = sprFR_sprTreasureBarrelHurt_402ce42342c8;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrelDead = sprFR_sprTreasureBarrelDead_8b8e6c8accd5;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2 = sprFR_sprTreasureBarrel2_345cc0cb2700;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2Hurt = sprFR_sprTreasureBarrel2Hurt_7b3d43c2af69;
;
global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2Dead = sprFR_sprTreasureBarrel2Dead_64a6c3ec0491;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottleDebris = sprFR_sprGrogBottleDebris_08db36352857;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle1 = sprFR_sprGrogBottle1_0fb8e7130f4a;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle1Hurt = sprFR_sprGrogBottle1Hurt_87703404b11d;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle1Dead = sprFR_sprGrogBottle1Dead_2a861d24fcef;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle2 = sprFR_sprGrogBottle2_80a302f62fdb;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle2Hurt = sprFR_sprGrogBottle2Hurt_a3ad0c0c688a;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle2Dead = sprFR_sprGrogBottle2Dead_ab53ffc14010;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle3 = sprFR_sprGrogBottle3_7c4876ca8929;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle3Hurt = sprFR_sprGrogBottle3Hurt_56af1f89a0d9;
;
global.fr_module_vars[$ "area:cove"].sprGrogBottle3Dead = sprFR_sprGrogBottle3Dead_c981dce624c8;
;
global.fr_module_vars[$ "area:cove"].sprCoveTorch = sprFR_sprCoveTorch_efb90f693f59;
;
global.fr_module_vars[$ "area:cove"].sprCoveTorchHurt = sprFR_sprCoveTorchHurt_2dff2e06a5bb;
;
global.fr_module_vars[$ "area:cove"].sprCoveTorchDead = sprFR_sprCoveTorchDead_a80a100089e2;
;
; // macro hoisted: anim_end
; // macro hoisted: FloorNormal
fr_Areas_cove_area_gml_pirateweps_init();
;
}
_fr.pc=0;
break;
case 3: // Areas/cove.area.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Areas/cove.area.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Areas/cove.area.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/cove.area.gml:94
function fr_Areas_cove_area_gml_pirateweps_init() {
global.fr_module_vars[$ "area:cove"].pirateInput = ds_list_create();
;
global.fr_module_vars[$ "area:cove"].pirateOutput = ds_list_create();
;
global.fr_module_vars[$ "area:cove"].pirateOverwriteInput = ds_list_create();
;
global.fr_module_vars[$ "area:cove"].pirateOverwriteOutput = ds_list_create();
;
fr_Areas_cove_area_gml_piratewep_add(wep_rogue_rifle, "FR_RogueBlunderbuss");
;
fr_Areas_cove_area_gml_piratewep_add(wep_shotgun, "FR_Blunderbuss");
;
fr_Areas_cove_area_gml_piratewep_add(wep_wrench, "FR_TideTurner");
;
fr_Areas_cove_area_gml_piratewep_add(wep_crossbow, "FR_CoralCrossbow");
;
fr_Areas_cove_area_gml_piratewep_add(wep_grenade_launcher, "FR_Blunderball");
;
fr_Areas_cove_area_gml_piratewep_add(wep_screwdriver, "FR_Hookpole");
;
fr_Areas_cove_area_gml_piratewep_add(wep_disc_gun, "FR_HullShredder");
;
fr_Areas_cove_area_gml_piratewep_add(wep_triple_machinegun, "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add(wep_double_shotgun, "FR_DoubleBlunderbuss");
;
fr_Areas_cove_area_gml_piratewep_add(wep_bazooka, "FR_Deckblazer");
;
fr_Areas_cove_area_gml_piratewep_add(wep_splinter_gun, "FR_SpikerRifle");
;
fr_Areas_cove_area_gml_piratewep_add(wep_toxic_bow, "FR_ToxicCoralCrossbow");
;
fr_Areas_cove_area_gml_piratewep_add(wep_lightning_pistol, "FR_StarPistol");
;
fr_Areas_cove_area_gml_piratewep_add(wep_heavy_crossbow, "FR_Ballista");
;
fr_Areas_cove_area_gml_piratewep_add(wep_flame_shotgun, "FR_PowderShotgun");
;
fr_Areas_cove_area_gml_piratewep_add(wep_auto_shotgun, "FR_AutoBlunderbuss");
;
fr_Areas_cove_area_gml_piratewep_add(wep_flak_cannon, "FR_Flaken");
;
fr_Areas_cove_area_gml_piratewep_add(wep_flare_gun, "FR_CandleLauncher");
;
fr_Areas_cove_area_gml_piratewep_add(wep_sawed_off_shotgun, "FR_Blunderbug");
;
fr_Areas_cove_area_gml_piratewep_add(wep_lightning_rifle, "FR_StarRifle");
;
fr_Areas_cove_area_gml_piratewep_add(wep_splinter_pistol, "FR_SpikerPistol");
;
fr_Areas_cove_area_gml_piratewep_add(wep_super_splinter_gun, "FR_SuperSpiker");
;
fr_Areas_cove_area_gml_piratewep_add(wep_double_flame_shotgun, "FR_DoublePowderShotgun");
;
fr_Areas_cove_area_gml_piratewep_add(wep_auto_crossbow, "FR_CoralAutoCrossbow");
;
fr_Areas_cove_area_gml_piratewep_add(wep_super_crossbow, "FR_CoralSuperCrossbow");
;
fr_Areas_cove_area_gml_piratewep_add(wep_heavy_grenade_launcher, "FR_Blunderboulder");
;
fr_Areas_cove_area_gml_piratewep_add(wep_energy_screwdriver, "FR_PowderSpear");
;
fr_Areas_cove_area_gml_piratewep_add(wep_lightning_shotgun, "FR_StarShotgun");
;
fr_Areas_cove_area_gml_piratewep_add(wep_auto_flame_shotgun, "FR_PowderPopper");
;
fr_Areas_cove_area_gml_piratewep_add(wep_nuke_launcher, "FR_FireworkCannon");
;
fr_Areas_cove_area_gml_piratewep_add(wep_lightning_smg, "FR_StarSMG");
;
fr_Areas_cove_area_gml_piratewep_add(wep_flame_cannon, "FR_CandleBarrage");
;
fr_Areas_cove_area_gml_piratewep_add(wep_energy_hammer, "FR_PowderHammer");
;
fr_Areas_cove_area_gml_piratewep_add(wep_blood_hammer, "FR_GhostCutlass");
;
fr_Areas_cove_area_gml_piratewep_add(wep_super_disc_gun, "FR_HullMangler");
;
fr_Areas_cove_area_gml_piratewep_add(wep_quadruple_machinegun, "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add(wep_super_flak_cannon, "FR_QuadBarrel");
;
fr_Areas_cove_area_gml_piratewep_add(wep_incinerator, "FR_Enfileter");
;
fr_Areas_cove_area_gml_piratewep_add(wep_heavy_auto_crossbow, "FR_AutoBallista");
;
fr_Areas_cove_area_gml_piratewep_add(wep_guitar, "FR_HurdyGurdy");
;
fr_Areas_cove_area_gml_piratewep_add(wep_ultra_laser_pistol, "FR_TeminiteCannon");
;
fr_Areas_cove_area_gml_piratewep_add("WO_UltraLaserPistol", "FR_TeminiteCannon");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_wrench, "FR_GildedTideTurner");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_shotgun, "FR_GildedBlunderbuss");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_crossbow, "FR_GildedCoralCrossbow");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_grenade_launcher, "FR_GildedBlunderball");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_splinter_gun, "FR_GildedSpikerRifle");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_screwdriver, "FR_GildedHookpole");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_bazooka, "FR_GildedDeckblazer");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_disc_gun, "FR_GildedHullShredder");
;
fr_Areas_cove_area_gml_piratewep_add(wep_golden_nuke_launcher, "FR_GildedFireworkCannon");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple bouncer machinegun", "bouncer volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple fire machinegun", "fire volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple gamma machinegun", "gamma volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple pest machinegun", "pest volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple psy machinegun", "psy volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("triple thunder machinegun", "thunder volley gun", "FR_VolleyGun");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad bouncer machinegun", "bouncer enfilader", "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad fire machinegun", "fire enfilader", "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad gamma machinegun", "gamma enfilader", "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad pest machinegun", "pest enfilader", "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad psy machinegun", "psy enfilader", "FR_Enfilader");
;
fr_Areas_cove_area_gml_piratewep_add_overwrite("quad thunder machinegun", "thunder enfilader", "FR_Enfilader");
;
}

// Original Areas/cove.area.gml:171
function fr_Areas_cove_area_gml_area_subarea() {
return 1;
;
}

// Original Areas/cove.area.gml:172
function fr_Areas_cove_area_gml_area_goal() {
return 150;
;
}

// Original Areas/cove.area.gml:173
function fr_Areas_cove_area_gml_area_next() {
return (scrFRModLoaded("area", "city") ? ["city", 1] : [5, 1]);
;
}

// Original Areas/cove.area.gml:174
function fr_Areas_cove_area_gml_area_background_color() {
return make_color_rgb(75, 96, 93);
;
}

// Original Areas/cove.area.gml:175
function fr_Areas_cove_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/cove.area.gml:176
function fr_Areas_cove_area_gml_area_darkness() {
return true;
;
}

// Original Areas/cove.area.gml:177
function fr_Areas_cove_area_gml_area_secret() {
return false;
;
}

// Original Areas/cove.area.gml:178
function fr_Areas_cove_area_gml_area_outside() {
return false;
;
}

// Original Areas/cove.area.gml:180
function fr_Areas_cove_area_gml_area_name() {
return scrFRLocalize(("4-" + ("@1(" + string(real(global.fr_module_vars[$ "area:cove"].sprAreaIcon)) + ":0)")));
;
}

// Original Areas/cove.area.gml:183
function fr_Areas_cove_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("YOHO!! YARR!!", "AHOY", "DON'T GET SCURVY", "HOLD ON TO YE PLUNDER", "DRINK GROG", "GOOD MORNING MUTANT CREW", "STOP KILLING ALL ME CUSTOMERS"));
;
}

// Original Areas/cove.area.gml:194
function fr_Areas_cove_area_gml_area_mapdata(_frl__lastX=undefined, _frl__lastY=undefined, _frl__lastArea=undefined, _frl__lastSubarea=undefined, _frl__subarea=undefined, _frl__loops=undefined) {
return [(63 + (9.5 * (_frl__subarea - 1))), (- 9), (_frl__subarea == 1)];
}

// Original Areas/cove.area.gml:199
function fr_Areas_cove_area_gml_area_areaicon() {
return [global.fr_module_vars[$ "area:cove"].sprAreaIcon, "4-?"];
}

// Original Areas/cove.area.gml:205
function fr_Areas_cove_area_gml_area_sprite(_frl__sprite=undefined) {
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
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprTopPot)) __fr_switch_case2=9;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_cove_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:cove"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_cove_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:cove"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:cove"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:cove"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:cove"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:cove"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:cove"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:cove"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:cove"].sprDetail;
;
case 9:
return global.fr_module_vars[$ "area:cove"].sprTopDecal;
;
}
}
}

// Original Areas/cove.area.gml:219
function fr_Areas_cove_area_gml_area_setup() {
scrFRSoundMusic(global.fr_module_vars[$ "area:cove"].musCove);
;
scrFRSoundAmbient(amb7);
;
goal = fr_Areas_cove_area_gml_area_goal();
;
background_set_colour(fr_Areas_cove_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_cove_area_gml_area_shadow_color();
;
TopCont.darkness = fr_Areas_cove_area_gml_area_darkness();
;
safespawn = 1;
;
scrFRBindStep(fr_Areas_cove_area_gml_area_step, 0);
;
scrFRBindDraw(fr_Areas_cove_area_gml_CoveWallTransOut_draw, (- 10));
;
scrFRSoundAssign(sndWallBreakRock, sndWallBreakRock);
;
}

// Original Areas/cove.area.gml:239
function fr_Areas_cove_area_gml_area_setup_floor() {
if (styleb) {
{
depth -= 3;
;
}
}
material = (styleb ? 4 : 2);
;
}

// Original Areas/cove.area.gml:251
function fr_Areas_cove_area_gml_area_start() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRSourceRandom(8) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, TopPot)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprTopDecal);
;
image_index = scrFRSourceIRandom(image_number);
image_xscale = scrFRSourceChoose((- 1), 1);
image_speed = (0) * timescale;
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
{ var __fr_with10 = scrFRWithValues(scrFRMatching(Floor, "fr_coveChestFloor", true)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRInstanceCreate((x + 16), (y + 16), PortalClear);
if (scrFRPlaceMeeting((x + 16), (y + 16), prop)) {
{
{ var __fr_with13 = scrFRWithValues(instance_nearest((x + 16), (y + 16), prop)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), RadChest))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break15) break;
}}
}
}
if ((! scrFRModLoaded("mod", "betterPVP"))) {
{
fr_Areas_cove_area_gml_TreasureMimic_create((x + 16), (y + 16));
}
}
{ var __fr_with16 = scrFRWithValues(fr_Areas_cove_area_gml_WoodSpreader_create((x + 16), (y + 16))), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
woodRange = 96;
;
}
}
if(__fr_break18) break;
}}
}
}
if(__fr_break12) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_CoveWoodSpreader")), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
itsGoTime = true;
;
}
}
if(__fr_break21) break;
}}
if ((frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_get, "Frontier", "unlock_bubbles") == 0)) {
{
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_set, "Frontier", "unlock_bubbles", 1);
;
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.unlock_splat_ext, "BUBBLES UNLOCKED", "BUBBLES", scrFRModCall("race", "bubbles", "race_unlock"), scrFRModGet("race", "bubbles", "sprPortrait"), 0, sndCharUnlock);
;
}
}
if (((scrFRSourceRandom(112) < 1) && (frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_get, "Frontier", "unlock_bubbles") == 1))) {
{
scrFRSoundPitchVolume(global.fr_module_vars[$ "area:cove"].sndAhoy, 1, 1);
{ var __fr_with22 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, FRCustomObject)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
{ var __fr_with25 = scrFRWithValues(scrFRBindDraw(fr_Areas_cove_area_gml_AHOY_draw, (- 16), scrFRSelf(self))), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
alphaPercent = 1;
;
timeToGo = 45;
;
}
}
if(__fr_break27) break;
}}
}
}
if(__fr_break24) break;
}}
}
}
if ((global.fr_module_vars[$ "area:cove"].settingAltCoveEntrance == true)) {
{
if ((GameCont.loops > 0)) {
{
{ var __fr_with28 = scrFRWithValues(instance_furthest(10016, 10016, Floor)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
scrFRModCall("mod", "Frontier_Caves", "CoveHyperCrystal_create", (x + 16), (y + 16));
;
}
}
if(__fr_break30) break;
}}
}
}
}
}
}

// Original Areas/cove.area.gml:321
function fr_Areas_cove_area_gml_area_make_floor() {
var _frl__x = x;
var _frl__y = y;
var _frl__outOfSpawn = (point_distance(_frl__x, _frl__y, 10000, 10000) > 48);
;
scrFRInstanceCreate(_frl__x, _frl__y, Floor);
;
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
if ((scrFRSourceRandom(10) < 1)) {
{
fr_Areas_cove_area_gml_scrFloorFill(_frl__x, _frl__y, 3, 3);
;
}
}
if ((scrFRSourceRandom(26) < 1)) {
{
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
fr_Areas_cove_area_gml_WoodSpreader_create((x + 16), (y + 16));
}
}
{ var __fr_with1 = scrFRWithValues(Wall), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((scrFRSourceRandom(10) < 1) && _frl__outOfSpawn) && (distance_to_object(Wall) < 48))) {
{
fr_Areas_cove_area_gml_scrWoodFloorFill(_frl__x, _frl__y, 5, 5);
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(GenCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
if ((scrFRInstanceNumber(Floor) > goal)) {
{
{ var __fr_with7 = scrFRWithValues(instance_furthest(10016, 10016, Floor)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(instance_nearest(((((x * 2) + 10000) / 3) + scrFRSourceRandomRange((- 64), 64)), ((((y * 2) + 10000) / 3) + scrFRSourceRandomRange((- 64), 64)), Floor)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_coveChestFloor = true;
;
fr_Areas_cove_area_gml_scrFloorFill(x, y, 3, 5);
;
fr_Areas_cove_area_gml_scrFloorFill(x, y, 5, 3);
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
}

// Original Areas/cove.area.gml:386
function fr_Areas_cove_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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

// Original Areas/cove.area.gml:400
function fr_Areas_cove_area_gml_scrWoodFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((_frl__x + (_frl__ox * _frl_o)), (_frl__y + (_frl__oy * _frl_o)), Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprFloor1B);
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

// Original Areas/cove.area.gml:418
function fr_Areas_cove_area_gml_area_pop_enemies() {
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
;
if ((scrFRSourceRandom(3) < 1)) {
{
if ((scrFRSourceRandom(6) < (1 + GameCont.loops))) {
{
if ((scrFRSourceRandom(13) < (1 * (1 + GameCont.loops)))) {
{
scrFRModCall("mod", "Frontier_Caves", "EliteWhale_create", _frl__x, _frl__y);
;
}
} else {
{
scrFRModCall("mod", "Frontier_Caves", "Whale_create", _frl__x, _frl__y);
;
}
}
}
} else {
{
if ((scrFRSourceRandom(3) < 1)) {
{
repeat ((2 + scrFRSourceIRandom(2))) {
if ((scrFRSourceRandom(6) < (1 * (1 + GameCont.loops)))) {
{
scrFRModCall("mod", "Frontier_Caves", "EliteStarfish_create", _frl__x, _frl__y);
;
}
} else {
{
scrFRModCall("mod", "Frontier_Caves", "Starfish_create", _frl__x, _frl__y);
;
}
}
}
}
} else {
{
repeat (scrFRSourceIRandomRange(2, 3)) {
scrFRModCall("mod", "Frontier_Caves", "Parrot_create", _frl__x, _frl__y);
;
}
}
}
}
}
}
}
}

// Original Areas/cove.area.gml:450
function fr_Areas_cove_area_gml_area_pop_props() {
if (((((scrFRSourceRandom(7) < 1) && (point_distance(x, y, 10000, 10000) > 96)) && (! scrFRPlaceMeeting(x, y, NOWALLSHEREPLEASE))) && (! scrFRPlaceMeeting(x, y, hitme)))) {
{
scrFRInstanceCreate((x + scrFRSourceChoose(0, 16)), (y + scrFRSourceChoose(0, 16)), Wall);
;
scrFRInstanceCreate(x, y, NOWALLSHEREPLEASE);
;
}
} else {
{
var _frl__x = ((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) / 2);
var _frl__y = ((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) / 2);
var _frl__outOfSpawn = (point_distance(x, y, 10000, 10000) > 48);
;
if (_frl__outOfSpawn) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
if (styleb) {
{
if ((scrFRSourceRandom(3) < 2)) {
{

}
}
}
} else {
{
if ((scrFRSourceRandom(3) < 1)) {
{
fr_Areas_cove_area_gml_GunpowderBarrel_create(_frl__x, _frl__y);
}
} else {
{
if ((scrFRSourceRandom(3) < 1)) {
{
fr_Areas_cove_area_gml_TreasureBarrel_create(_frl__x, _frl__y);
;
}
} else {
{
fr_Areas_cove_area_gml_CoveTorch_create(_frl__x, _frl__y);
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
}
if (((distance_to_object(instance_nearest(x, y, LightBeam)) > 64) && (scrFRSourceRandom(7) < 1))) {
{
scrFRInstanceCreate(x, y, LightBeam);
}
}
}

// Original Areas/cove.area.gml:495
function fr_Areas_cove_area_gml_area_finish() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(WepPickup, "wep", "fr_CorsairCutlass")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
GameCont.fr_captainCutlass += 1;
;
}
}
if(__fr_break3) break;
}}
if ((subarea < fr_Areas_cove_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_cove_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
}

// Original Areas/cove.area.gml:514
function fr_Areas_cove_area_gml_area_transit() {
scrFRSoundRestore(sndWallBreakRock);
;
}

// Original Areas/cove.area.gml:518
function fr_Areas_cove_area_gml_area_step() {
{ var __fr_with1 = scrFRWithValues(BackCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((scrFRAlarmRead(scrFRSelf(self), 0) > 0) && (scrFRAlarmRead(scrFRSelf(self), 0) <= ceil(scrFRSourceScale())))) {
{
scrFRAlarmWrite(scrFRSelf(self), 0, (50 + scrFRSourceRandom(90)), "+=");
;
if (scrFRInstanceExists(Floor)) {
{
var _frl__index = undefined;
;
do _frl__index = scrFRSourceIRandom((INPUT_MAX_PLAYERS - 1)); until (scrFRPlayerIsActive(_frl__index));
;
var _frl__sl = scrFRViewCoordinate(0, _frl__index);
var _frl__st = scrFRViewCoordinate(1, _frl__index);
var _frl__sr = (_frl__sl + view_width);
var _frl__sb = (_frl__st + view_height);
var _frl__fl = scrFRMatchingLE(scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingGE(Floor, "bbox_right", _frl__sl), "bbox_bottom", _frl__st), "bbox_left", _frl__sr), "bbox_top", _frl__sb);
;
if (array_length(_frl__fl)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(_frl__fl, scrFRSourceIRandom((array_length(_frl__fl) - 1)))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Drip)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprCoveDrip);
;
}
}
if(__fr_break9) break;
}}
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
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:551
function fr_Areas_cove_area_gml_CoveWallTransOut_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(TopSmall, "fr_topSmallCove", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(global.fr_module_vars[$ "area:cove"].sprWallCoveBTransSpread, fr_topSmallCove, (x + 8), y, 1, 1, fr_topSmallCoveRot, c_white, 1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:556
function fr_Areas_cove_area_gml_WoodSpreader_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CoveWoodSpreader";
itsGoTime = false;
;
woodRange = (32 + scrFRSourceIRandom(48));
on_step = fr_Areas_cove_area_gml_WoodSpreader_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:569
function fr_Areas_cove_area_gml_WoodSpreader_step() {
if ((itsGoTime == true)) {
{
{ var __fr_with1 = scrFRWithValues(Floor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((distance_to_object((scrFROther(other))) < (scrFROther(other)).woodRange) && (! styleb))) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprFloorC);
;
image_index = scrFRSourceIRandom(3);
;
if ((scrFRSourceRandom(5) < 1)) {
{
image_index = scrFRSourceChoose(4, 5);
;
}
}
depth = 8;
material = 2;
;
styleb = false;
;
fr_woodFloor = true;
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + 16), (y + 16), SnowFloor)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprSnowFloorC);
;
var __fr_other7=scrFROther(other);
image_speed = ((__fr_other7.image_speed / timescale)) * timescale;
;
var __fr_other8=scrFROther(other);
image_index = __fr_other8.image_index;
;
var __fr_other9=scrFROther(other);
depth = (__fr_other9.depth + 1);
;
}
}
if(__fr_break6) break;
}}
if (((! scrFRPlaceMeeting(x, y, prop)) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
if ((distance_to_object(Wall) <= 16)) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
fr_Areas_cove_area_gml_GrogBottle_create((x + 16), (y + 16));
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
if(__fr_break3) break;
}}
{ var __fr_with10 = scrFRWithValues(Wall), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).woodRange + 16))) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprWallBotB);
;
topspr = global.fr_module_vars[$ "area:cove"].sprWallTopB;
;
outspr = global.fr_module_vars[$ "area:cove"].sprWallOutB;
;
}
}
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(TopSmall), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).woodRange + 16))) {
{
fr_topSmallCove = scrFRSourceIRandom(3);
;
fr_topSmallCoveRot = scrFRSourceChoose(0, 90, 180, 270);
;
}
}
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(TopPot), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).woodRange + 16))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break18) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/cove.area.gml:637
function fr_Areas_cove_area_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Areas/cove.area.gml:647
function fr_Areas_cove_area_gml_weapon_can_exchange(_frl__wep=undefined) {
return (ds_list_find_index(global.fr_module_vars[$ "area:cove"].pirateInput, _frl__wep) != (- 1));
;
}

// Original Areas/cove.area.gml:650
function fr_Areas_cove_area_gml_piratewep_add(_frl__input=undefined, _frl__output=undefined) {
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateInput, _frl__input);
;
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateOutput, _frl__output);
}

// Original Areas/cove.area.gml:654
function fr_Areas_cove_area_gml_piratewep_add_overwrite(_frl__input=undefined, _frl__output=undefined, _frl__overwrite=undefined) {
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateInput, _frl__input);
;
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateOutput, _frl__output);
;
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateOverwriteInput, _frl__input);
;
ds_list_add(global.fr_module_vars[$ "area:cove"].pirateOverwriteOutput, _frl__overwrite);
;
}

// Original Areas/cove.area.gml:669
function fr_Areas_cove_area_gml_TreasureMimic_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_TreasureMimic";
spr_idle = global.fr_module_vars[$ "area:cove"].sprTreasureMimicIdle;
;
spr_strtpeek = global.fr_module_vars[$ "area:cove"].sprTreasureMimicStartPeek;
;
spr_endpeek = global.fr_module_vars[$ "area:cove"].sprTreasureMimicEndPeek;
;
spr_peek = global.fr_module_vars[$ "area:cove"].sprTreasureMimicPeek;
;
spr_swap = global.fr_module_vars[$ "area:cove"].sprTreasureMimicEat;
;
spr_strthungry = global.fr_module_vars[$ "area:cove"].sprTreasureMimicStartHungry;
;
spr_hungry = global.fr_module_vars[$ "area:cove"].sprTreasureMimicHungry;
;
spr_endhungry = global.fr_module_vars[$ "area:cove"].sprTreasureMimicEndHungry;
;
spr_deny = global.fr_module_vars[$ "area:cove"].sprTreasureMimicDeny;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_shadow = shd64B;
;
spr_shadow_y = 0;
;
image_speed = (0.4) * timescale;
;
depth = 0;
;
mytext = scrFRLocalize("@(color:3516363)EXCHANGE#@wWEAPON?");
;
pick = (- 1);
;
targetplayer = noone;
;
playerwep = noone;
;
outputwep = noone;
;
validwep = true;
;
can_swap = true;
;
playerNear = false;
;
hungry = false;
;
inputwep = noone;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Areas_cove_area_gml_WeaponExchangerPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
scrFRModCall("mod", "Frontier_Objects", "PortalPusher_create", x, y, 96);
;
on_step = fr_Areas_cove_area_gml_TreasureMimic_step;
;
on_draw = fr_Areas_cove_area_gml_TreasureMimic_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:717
function fr_Areas_cove_area_gml_WeaponExchangerPrompt_step() {
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
if ((creator.can_swap == false)) {
{
scrFRInstanceDestroy();
}
}
}

// Original Areas/cove.area.gml:726
function fr_Areas_cove_area_gml_TreasureMimic_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_cove_area_gml_TreasureMimic_step_resume, id, scrFROther(other), _args, 13, []);
}
function fr_Areas_cove_area_gml_TreasureMimic_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_cove_area_gml_TreasureMimic_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/cove.area.gml:875
{
if ((validwep == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", __fr_other4.outputwep);
;
ammo = 1;
;
direction = 270;
;
speed = (6) * timescale;
;
repeat (15) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + 6), NTTEFullSweat)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
direction = (270 + scrFRSourceRandomRange((- 30), 30));
;
speed = (scrFRSourceRandom(2)) * timescale;
}
}
if(__fr_break7) break;
}}
}
}
}
if(__fr_break3) break;
}}
_fr.vars._outputwep = outputwep;
;
_fr.vars._overwrite = ds_list_find_index(global.fr_module_vars[$ "area:cove"].pirateOverwriteInput, inputwep);
if ((_fr.vars._overwrite != (- 1))) {
{
_fr.vars._outputwep = ds_list_find_value(global.fr_module_vars[$ "area:cove"].pirateOverwriteOutput, _fr.vars._overwrite);
;
}
}
_fr.vars._conversionArray = frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_get, "Frontier", "pirate_conversions");
if ((scrFRArrayFindIndex(_fr.vars._conversionArray, _fr.vars._outputwep) < 0)) {
{
array_push(_fr.vars._conversionArray, _fr.vars._outputwep);
if ((frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_get, "Frontier", "unlock_bubbles_bskin") == 0)) {
{
if ((array_length(_fr.vars._conversionArray) >= 10)) {
{
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_set, "Frontier", "unlock_bubbles_bskin", 1);
;
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.unlock_splat_ext, "BUBBLES B-SKIN UNLOCKED", "BUBBLES B", scrFRModCall("race", "bubbles", "race_skin_unlock", 1), scrFRModGet("race", "bubbles", "sprPortrait"), 1, sndCharUnlock);
;
}
}
}
}
_fr.vars._projArray = scrFRModGet("mod", "Frontier_Projectiles", "foundPirateWeps");
;
array_push(_fr.vars._projArray, _fr.vars._outputwep);
;
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_set, "Frontier", "pirate_conversions", _fr.vars._conversionArray);
}
}
frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_set, "Frontier", "pirate_trades", (frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.save_get, "Frontier", "pirate_trades") + 1));
}
}
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
can_swap = true;
;
pick = (- 1);
;
{ var __fr_with8 = scrFRWithValues(frMacro_Areas_cove_area_gml_call(frMacro_Areas_cove_area_gml_scr.prompt_create, mytext)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
on_step = fr_Areas_cove_area_gml_WeaponExchangerPrompt_step;
;
creator = _fr.vars.me;
;
}
}
if(__fr_break10) break;
}}
}
_fr.pc=0;
break;
case 2: // Areas/cove.area.gml:872
{
;
}
_fr.pc=1;
break;
case 3: // Areas/cove.area.gml:872
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Areas/cove.area.gml:872
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 3 : 1;
break;
case 5: // Areas/cove.area.gml:871
_fr.wait_ticks=max(0,(image_number / (image_speed / timescale))); _fr.pc=4; return;
break;
case 6: // Areas/cove.area.gml:818
{
validwep = false;
;
can_swap = false;
;
if ((((!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(targetplayer, "wep"), wep_none)) && fr_Areas_cove_area_gml_weapon_can_exchange(playerwep)) || (is_string(playerwep) && scrFRScriptExists("weapon", playerwep, "wep_exchange_pirate")))) {
{
sprite_index = scrFRAreaSourceSprite(spr_swap);
;
image_index = 0;
;
scrFRWeaponSlotWrite(targetplayer, "wep", wep_none);
;
validwep = true;
;
{ var __fr_with11 = scrFRWithValues(targetplayer), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
fr_Areas_cove_area_gml_player_swap(scrFRSelf(self));
swapmove = true;
;
drawempty = 30;
;
}
}
if(__fr_break13) break;
}}
if (is_string(playerwep)) {
{
if (scrFRScriptExists("weapon", playerwep, "wep_exchange_pirate")) {
{
outputwep = scrFRModCall("weapon", playerwep, "wep_exchange_pirate");
}
}
}
}
_fr.vars._inputwep = ds_list_find_index(global.fr_module_vars[$ "area:cove"].pirateInput, playerwep);
;
if ((_fr.vars._inputwep != (- 1))) {
{
inputwep = ds_list_find_value(global.fr_module_vars[$ "area:cove"].pirateInput, _fr.vars._inputwep);
;
outputwep = ds_list_find_value(global.fr_module_vars[$ "area:cove"].pirateOutput, _fr.vars._inputwep);
}
}
scrFRSoundPitchVolume(sndGoldUnlock, 1.2, 2);
;
}
} else {
{
scrFRSoundPitchVolume(sndVanHurt, 1.2, 1);
;
scrFRSoundPitchVolume(sndExplosionS, 1.8, 0.6);
repeat (3) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + 6), NTTEFullSweat)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
direction = (270 + scrFRSourceRandomRange((- 10), 10));
;
speed = (scrFRSourceRandom(2)) * timescale;
}
}
if(__fr_break16) break;
}}
}
sprite_index = scrFRAreaSourceSprite(spr_deny);
validwep = false;
;
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, PopupText)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
mytext = scrFRLocalize("DON'T WANT THAT!");
}
}
if(__fr_break19) break;
}}
}
}
}
_fr.pc=5;
break;
case 7: // Areas/cove.area.gml:816
{
;
}
_fr.pc=6;
break;
case 8: // Areas/cove.area.gml:816
_fr.result=undefined; _fr.done=true; return;
break;
case 9: // Areas/cove.area.gml:814
{
scrFRSoundPlay(sndCursedReminder);
;
pick = (- 1);
;
}
_fr.pc=8;
break;
case 10: // Areas/cove.area.gml:813
_fr.pc = ((targetplayer.curse == 1)) ? 9 : 6;
break;
case 11: // Areas/cove.area.gml:811
{
targetplayer = instance_nearest(x, y, Player);
playerwep = scrFRWeaponSlotRead(targetplayer, "wep");
}
_fr.pc=10;
break;
case 12: // Areas/cove.area.gml:808
_fr.pc = (((pick != (- 1)) && (can_swap == true))) ? 11 : 0;
break;
case 13: // Areas/cove.area.gml:728
{
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
_fr.vars.me = scrFRSelf(self);
;
if ((distance_to_object(chestprop) < 8)) {
{
{ var __fr_with20 = scrFRWithValues(instance_nearest(x, y, chestprop)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
var __fr_other23=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other23.x, __fr_other23.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 1);
;
}
}
if(__fr_break22) break;
}}
}
}
if ((distance_to_object(RadChest) < 8)) {
{
{ var __fr_with24 = scrFRWithValues(instance_nearest(x, y, RadChest)), __fr_break26=false;
for (var __fr_index25=0; __fr_index25<array_length(__fr_with24); ++__fr_index25) {
if(scrFRScopeExists(__fr_with24[__fr_index25])) with (__fr_with24[__fr_index25]) {
{
var __fr_other27=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other27.x, __fr_other27.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 1);
;
}
}
if(__fr_break26) break;
}}
}
}
if ((scrFRSourceRandom(40) < 1)) {
{
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 24), 24)), (y + scrFRSourceRandomRange((- 24), 24)), CaveSparkle);
}
}
if (scrFRInstanceExists(Player)) {
{
_fr.vars.myMan = instance_nearest(x, y, Player);
if (((is_string(scrFRWeaponSlotRead(_fr.vars.myMan, "wep")) && scrFRScriptExists("weapon", scrFRWeaponSlotRead(_fr.vars.myMan, "wep"), "wep_exchange_pirate")) || fr_Areas_cove_area_gml_weapon_can_exchange(scrFRWeaponSlotRead(_fr.vars.myMan, "wep")))) {
{
hungry = true;
;
}
} else {
{
hungry = false;
;
}
}
}
}
if ((distance_to_object(Player) < 48)) {
{
if ((sprite_index == spr_idle)) {
{
sprite_index = scrFRAreaSourceSprite(spr_strtpeek);
;
image_index = 0;
;
}
}
playerNear = true;
;
}
} else {
{
playerNear = false;
;
}
}
if (frMacro_Areas_cove_area_gml_anim_end) {
{
if ((sprite_index == spr_strtpeek)) {
{
sprite_index = scrFRAreaSourceSprite(spr_peek);
;
}
}
if ((sprite_index == spr_strthungry)) {
{
sprite_index = scrFRAreaSourceSprite(spr_hungry);
;
}
}
if (((sprite_index == spr_peek) && (hungry == true))) {
{
sprite_index = scrFRAreaSourceSprite(spr_strthungry);
;
}
}
if ((sprite_index == spr_endhungry)) {
{
sprite_index = scrFRAreaSourceSprite(spr_peek);
;
}
}
if ((sprite_index == spr_hungry)) {
{
if (((playerNear == false) || (hungry == false))) {
{
sprite_index = scrFRAreaSourceSprite(spr_endhungry);
;
}
}
}
}
if ((playerNear == false)) {
{
if ((sprite_index == spr_peek)) {
{
sprite_index = scrFRAreaSourceSprite(spr_endpeek);
;
}
}
}
}
if (((sprite_index == spr_endpeek) and frMacro_Areas_cove_area_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
}
_fr.pc=12;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/cove.area.gml:937
function fr_Areas_cove_area_gml_TreasureMimic_draw() {
scrFRDrawSpriteExt(spr_shadow, 0, x, (y + spr_shadow_y), 1, 1, 0, c_white, 0.4);
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

// Original Areas/cove.area.gml:941
function fr_Areas_cove_area_gml_player_swap(_frl__player=undefined) {
{ var __fr_with1 = scrFRWithValues(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__name = [string_replace(scrFRSelf(self), "%", ""), string_replace(scrFRSelf(self), "%", "b")];
var _frl__temp = scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 0), 0);
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 0), scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 1), 0));
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 1), _frl__temp);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:956
function fr_Areas_cove_area_gml_Dabloon_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprDabloons);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
direction = scrFRSourceRandom(360);
;
lifetime = 120;
;
on_step = fr_Areas_cove_area_gml_Dabloon_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:973
function fr_Areas_cove_area_gml_Dabloon_step() {
if ((lifetime > 0)) {
{
lifetime -= scrFRSourceScale();
;
}
} else {
{
image_alpha -= (0.07 * scrFRSourceScale());
;
if ((image_alpha <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Areas/cove.area.gml:983
function fr_Areas_cove_area_gml_CoveTorch_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CoveTorch";
spr_idle = global.fr_module_vars[$ "area:cove"].sprCoveTorch;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprCoveTorchHurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprCoveTorchDead;
;
image_index = scrFRSourceIRandom(3);
;
fr_glow = [48, 64];
;
snd_hurt = sndHitRock;
;
snd_dead = sndHitMetal;
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

// Original Areas/cove.area.gml:1006
function fr_Areas_cove_area_gml_GunpowderBarrel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_TreasureBarrel";
spr_idle = global.fr_module_vars[$ "area:cove"].sprGunpowderBarrel;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelHurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelDead;
;
spr_shadow = global.fr_module_vars[$ "area:cove"].shdGunpowderBarrel;
;
spr_shadow_y = (- 2);
;
snd_hurt = sndHitPlant;
;
snd_dead = global.fr_module_vars[$ "area:cove"].sndGunpowderBarrelBreak;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
team = 0;
;
on_death = fr_Areas_cove_area_gml_GunpowderBarrel_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:1032
function fr_Areas_cove_area_gml_GunpowderBarrel_destroy() {
scrFRSoundPitchVolume(sndScorpionMelee, (1.2 + scrFRSourceRandom(0.3)), 0.6);
;
scrFRSoundPitch(global.fr_module_vars[$ "area:cove"].sndWoodBreak, (0.8 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(snd_dead, (0.8 + scrFRSourceRandom(0.3)));
;
repeat (scrFRSourceRandomRange(3, 5)) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GunpowderCreep_create", (x + scrFRSourceRandomRange((- 24), 24)), (y + scrFRSourceRandomRange((- 24), 24)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
repeat ((10 + scrFRSourceIRandom(10))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(sprBreath);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
image_blend = make_colour_rgb(74, 60, 78);
;
}
}
if(__fr_break6) break;
}}
}
repeat ((4 + scrFRSourceIRandom(3))) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprGunpowderBarrelDebris);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}

// Original Areas/cove.area.gml:1063
function fr_Areas_cove_area_gml_TreasureBarrel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_TreasureBarrel";
spr_idle = global.fr_module_vars[$ "area:cove"].sprTreasureBarrel;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprTreasureBarrelHurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprTreasureBarrelDead;
;
var _frl__variant = scrFRSourceIRandom(1);
;
{ var __fr_switch_value4=_frl__variant, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(0)) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==(1)) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
spr_idle = global.fr_module_vars[$ "area:cove"].sprTreasureBarrel;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprTreasureBarrelHurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprTreasureBarrelDead;
;
spr_shadow = global.fr_module_vars[$ "area:cove"].shdGunpowderBarrel;
;
spr_shadow_y = (- 3);
;
break;
;
case 1:
spr_idle = global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2Hurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprTreasureBarrel2Dead;
;
spr_shadow = shd32;
;
spr_shadow_y = 1;
;
break;
;
}
}
snd_hurt = sndHitPlant;
;
snd_dead = global.fr_module_vars[$ "area:cove"].sndTreasureBarrelBreak;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
team = 0;
;
on_step = fr_Areas_cove_area_gml_TreasureBarrel_step;
;
on_death = fr_Areas_cove_area_gml_TreasureBarrel_destroy;
;
x = round(x);
y = round(y);
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:1111
function fr_Areas_cove_area_gml_TreasureBarrel_step() {
if ((scrFRSourceRandom(40) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 14), 14)), (y + scrFRSourceRandomRange((- 14), 14)), CaveSparkle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
if ((scrFRSourceRandom(6) < 1)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprGemSparkle);
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

// Original Areas/cove.area.gml:1121
function fr_Areas_cove_area_gml_TreasureBarrel_destroy() {
repeat ((5 + scrFRSourceIRandom(10))) {
fr_Areas_cove_area_gml_Dabloon_create(x, y);
}
scrFRSoundPitch(snd_dead, (0.8 + scrFRSourceRandom(0.3)));
;
}

// Original Areas/cove.area.gml:1127
function fr_Areas_cove_area_gml_GrogBottle_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GrogBottle";
spr_idle = global.fr_module_vars[$ "area:cove"].sprGrogBottle1;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprGrogBottle1Hurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprGrogBottle1Dead;
;
var _frl__variant = scrFRSourceIRandom(2);
;
{ var __fr_switch_value4=_frl__variant, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(0)) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==(1)) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(2)) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
spr_idle = global.fr_module_vars[$ "area:cove"].sprGrogBottle1;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprGrogBottle1Hurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprGrogBottle1Dead;
;
break;
;
case 1:
spr_idle = global.fr_module_vars[$ "area:cove"].sprGrogBottle2;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprGrogBottle2Hurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprGrogBottle2Dead;
;
break;
;
case 2:
spr_idle = global.fr_module_vars[$ "area:cove"].sprGrogBottle3;
;
spr_hurt = global.fr_module_vars[$ "area:cove"].sprGrogBottle3Hurt;
;
spr_dead = global.fr_module_vars[$ "area:cove"].sprGrogBottle3Dead;
;
break;
;
}
}
snd_hurt = sndHitMetal;
;
snd_dead = sndIcicleBreak;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 2, "=");
;
hp = max_hp;
;
team = 0;
;
on_death = fr_Areas_cove_area_gml_GrogBottle_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/cove.area.gml:1171
function fr_Areas_cove_area_gml_GrogBottle_destroy() {
repeat ((3 + scrFRSourceIRandom(3))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:cove"].sprGrogBottleDebris);
;
image_index = scrFRSourceIRandom(image_number);
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitch(snd_dead, (0.8 + scrFRSourceRandom(0.1)));
}

// Original Areas/cove.area.gml:1183
function fr_Areas_cove_area_gml_AHOY_draw(_frl__creator=undefined) {
scrFRDrawSpriteExt(global.fr_module_vars[$ "area:cove"].sprAHOY, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)), 1, 1, 0, c_white, alphaPercent);
timeToGo -= scrFRSourceScale();
;
if ((timeToGo <= 0)) {
{
alphaPercent -= (0.05 * scrFRSourceScale());
;
}
}
if ((alphaPercent <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
}
}
