#macro frMacro_Objects_Frontier_Projectiles_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Projectiles"].scr

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_instance_max scrFRInstanceCreate(0, 0, FRMarker)

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_Objects_Frontier_Projectiles_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

// Original Objects/Frontier_Projectiles.mod.gml:1
function fr_Objects_Frontier_Projectiles_mod_gml___load() {

}

// Original Objects/Frontier_Projectiles.mod.gml:6
function fr_Objects_Frontier_Projectiles_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:10
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Projectiles", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Projectiles"].settingNaturalPirateWeps = false;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].settingNaturalLabsWeps = false;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].foundPirateWeps = scrFRArrayClone(frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.save_get, "Frontier", "pirate_conversions"));
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprWhiteSmoke = sprFR_sprWhiteSmoke_af86c6156b99;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskGunpowderCreep = sprFR_mskGunpowderCreep_11816c903a50;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderCreep = sprFR_sprGunpowderCreep_fa0fd83f6ba2;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderFireFly = sprFR_sprGunpowderFireFly_ad0e023462f6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGrapeshot = sprFR_sprGrapeshot_2a3f90d03614;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGrapeshotDisappear = sprFR_sprGrapeshotDisappear_5050b568da3c;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldGrapeshotDisappear = sprFR_sprGoldGrapeshotDisappea_be0640010269;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPopoGrapeshot = sprFR_sprPopoGrapeshot_bea07d20f239;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPopoGrapeshotDisappear = sprFR_sprPopoGrapeshotDisappea_68b337f6e0d7;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicCannonball = sprFR_sprEpicCannonball_80e9c72a4886;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicStreak = sprFR_sprEpicStreak_7af2c95e8a16;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicTrail = sprFR_sprEpicTrail_66f27932a542;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicShrapnel = sprFR_sprEpicShrapnel_8d6078124672;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicPlasmaImpact = sprFR_sprEpicPlasmaImpact_6e2b212990a9;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskPlasmaImpactSmall = sprFR_mskPlasmaImpactSmall_b15df2b8d4a6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicPlasmaImpactSmall = sprFR_sprEpicPlasmaImpactSmall_3a5dba96e175;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeam = sprFR_sprEpicBeam_84e42d16c177;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskEpicBeam = sprFR_mskEpicBeam_75da4f11a1db;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeamStart = sprFR_sprEpicBeamStart_645fdbab5d7a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeamHead = sprFR_sprEpicBeamHead_231e31018558;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSpikerSplinter = sprFR_sprSpike_3477299d5174;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldSpikerSplinter = sprFR_sprGoldSpike_07751f365c0d;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShank = sprFR_sprGunpowderShank_ae98a59a7453;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSharpSlash = sprFR_mskSharpSlash_aa79fe1a8f41;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSharpSlash = sprFR_sprSharpSlash_fa65c10c6559;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderProjectile = sprFR_sprGunpowderProjectile_144043e1ea8a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireSlash = sprFR_sprFireSlash_e22099331524;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBlunderball = sprFR_sprBlunderball_91a4f01fdfe2;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBlunderballDebris = sprFR_sprBlunderballDebris_8e1817d45f4b;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprHeavyBlunderball = sprFR_sprHeavyBlunderball_7e94c5261451;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldBlunderball = sprFR_sprGoldBlunderball_02a0afa8f0d8;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldBlunderballDebris = sprFR_sprGoldBlunderballDebris_e28e9e2fd940;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameBullet = sprFR_sprFlameBullet_b97ede60fb8c;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameBulletHit = sprFR_sprFlameBulletHit_bd162b2ebcb2;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSawblade = sprFR_mskSawblade_8cb5da3d8c67;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSawblade = sprFR_sprSawblade_36f9807c5bf6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldSawblade = sprFR_sprGoldSawblade_b3a685c22e77;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnet = sprFR_sprMagnet_949d6f679c6d;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetHook = sprFR_sprMagnetHook_ebe6034f219b;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetBlink = sprFR_sprMagnetBlink_897d28095ceb;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetSuck = sprFR_sprMagnetSuck_a592d525e4c0;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldMagnet = sprFR_sprGoldMagnet_9b625c9d0652;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldMagnetHook = sprFR_sprGoldMagnetHook_de0fb9029c64;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBallistaBolt = sprFR_sprBallistaBolt_94af5badca4b;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBallistaSubBolt = sprFR_sprBallistaSubBolt_8992a1deadba;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameTrail = sprFR_sprFlameTrail_a7a2bfae2b9f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPetrolStreak = sprFR_sprPetrolStreak_d2e1ad425a48;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBullet = sprFR_sprStarBullet_a76b0ae34950;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletHit = sprFR_sprStarBulletHit_e0bd0a9eb7a5;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletTrail = sprFR_sprStarBulletTrail_8394c4926176;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBig = sprFR_sprStarBig_21b036aa8aa9;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkBigFlak = sprFR_sprInkBigFlak_12f6bf25a2d9;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkFlak = sprFR_sprInkFlak_d05ca6def927;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkShrapnel = sprFR_sprInkShrapnel_0ed21b2a6abc;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke = sprFR_sprInkSmoke_a605ebe9b353;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprOilGrenade = sprFR_sprOilGrenade_d53eaa271bd1;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameRocket = sprFR_sprFlameRocket_67ca7c7f04b7;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].oilColors = [make_color_rgb(252, 56, 0), make_color_rgb(160, 30, 0)];
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCreep = sprFR_sprCreep_d9e998606286;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameCreepBubble = sprFR_sprFlameCreepBubble_ce757b580381;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldFlameRocket = sprFR_sprGoldFlameRocket_4d7963825e38;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGhostSkull = sprFR_sprGhostSkull_702e1898f7f8;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubble = sprFR_sprTideBubble_ff118ef35aa3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleActive = sprFR_sprTideBubbleActive_303de924037c;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleExplosion = sprFR_sprTideBubbleExplosion_93e0a3df7fc3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleSpray = sprFR_sprTideBubbleSpray_aeb7c490e835;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleTrail = sprFR_sprTideBubbleTrail_59e23a40f7d3;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleNullify = sprFR_sprTideBubbleNullify_abce3cfec61c;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideSlash = sprFR_sprTideSlash_d866c40ed37f;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShell = sprFR_sprGunpowderShell_785f277fd3b6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSpark = sprFR_sprFireworkSpark_ece8081c4999;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSparkMiddle = sprFR_sprFireworkSparkMiddle_08811f03f4c0;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame = sprFR_sprFireworkFlame_dd27d18bd07a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkTrail = sprFR_sprFireworkTrail_db7404456a9d;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkExplosion = sprFR_sprFireworkExplosion_334bc6677ccc;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSmallExplosion = sprFR_sprFireworkSmallExplosio_0dc75ab09d17;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandle = sprFR_sprFireworkCandle_e5240b8e0256;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleBase = sprFR_sprFireworkCandleBase_3ea6aa83b013;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleTrail = sprFR_sprFireworkCandleTrail_03f91796352c;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleTrail2 = sprFR_sprFireworkCandleTrail2_f5f58c0574a7;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSparkle = sprFR_sprFireworkSparkle_cbdeccb17103;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkRocket = sprFR_sprFireworkRocket_9fb32bf47635;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldFireworkRocket = sprFR_sprGoldFireworkRocket_5b5d5c204164;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShell = sprFR_sprGunpowderShell_785f277fd3b6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShellDisappear = sprFR_sprGunpowderShellDisappe_f16a4a53b826;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralBolt = sprFR_sprCoralBolt_6e338e4058d1;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralCluster = sprFR_sprCoralCluster_04c0a3afd524;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralClusterBig = sprFR_sprCoralClusterBig_55f90c8e9bfc;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralShard = sprFR_sprCoralShard_c2f45d0a90c1;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralPowerShard = sprFR_sprCoralPowerShard_833d0aad9d7d;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralShardHit = sprFR_sprCoralShardHit_415b99fc022d;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralPowerShardHit = sprFR_sprCoralPowerShardHit_63e4933d023a;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit = sprFR_sprCoralGrowthHit_fa28e7495207;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralCluster = sprFR_sprToxicCoralCluster_fa60be7c7740;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralBolt = sprFR_sprToxicCoralBolt_f08d19cd0ae6;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralPowerShard = sprFR_sprToxicCoralPowerShard_7e6f83549c26;
;
global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralPowerShardHit = sprFR_sprToxicCoralPowerShardH_491e6293988f;
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:9
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:9
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:9
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:133
function fr_Objects_Frontier_Projectiles_mod_gml_check_piratedrops(_frl__wep=undefined, _frl__area=undefined) {
{ var __fr_switch_value1=global.fr_module_vars[$ "mod:Frontier_Projectiles"].settingNaturalPirateWeps, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(0)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("FOUND")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return (- 1);
;
break;
;
case 1:
return _frl__area;
;
break;
;
case 2:
var _frl__yeah = (- 1);
;
if ((scrFRArrayFindIndex(global.fr_module_vars[$ "mod:Frontier_Projectiles"].foundPirateWeps, _frl__wep) > (- 1))) {
{
_frl__yeah = _frl__area;
;
}
}
return _frl__yeah;
;
break;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:155
function fr_Objects_Frontier_Projectiles_mod_gml_weapon_tutorial_text(_frl__x=undefined, _frl__y=undefined, _frl__type=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, (_frl__y + 12), PopupText)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mytext = scrFRLocalize("OOPS!");
{ var __fr_switch_value4=_frl__type, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("chargeWep")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("blunderball")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("blunderboulder")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
mytext = scrFRLocalize("@sHOLD FIRE TO @wCHARGE!");
;
break;
;
case 1:
mytext = scrFRLocalize("@sSMACK BLUNDERBALL FOR#@wMORE POWER!!");
;
break;
;
case 2:
mytext = scrFRLocalize("@sSMACK BLUNDERBOULDER FOR#@wMORE POWER!!");
;
break;
;
}
}
scrFRAlarmWrite(scrFRSelf(self), 1, 1.4, "*=");
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:168
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderCreep);
;
spr_firefly = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderFireFly;
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
mask_index = mskExplosion;
;
speed = (0) * timescale;
;
typ = (- 1);
;
damage = 0;
;
team = 1724;
;
hitid = [sprite_index, "GUNPOWDER"];
;
lifetime = 200;
;
allGrownUp = false;
;
maxSize = 1;
;
fr_glow = [0, 0];
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_step;
;
on_projectile = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_projectile;
;
on_grenade = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:201
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
lifetime -= scrFRSourceScale();
;
fr_glow = [(32 * image_xscale), (48 * image_xscale)];
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.1;
;
image_yscale = image_xscale;
;
if ((image_xscale >= maxSize)) {
{
allGrownUp = true;
;
}
}
}
}
if ((scrFRSourceRandom(35) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * image_xscale))), (y + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * image_xscale))), FireFly)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_firefly);
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(20) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * image_xscale))), (y + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * image_xscale))), Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(sprBreath);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(1)) * timescale;
;
image_blend = make_colour_rgb(74, 60, 78);
;
}
}
if(__fr_break7) break;
}}
}
}
if ((distance_to_object(Explosion) < 2)) {
{
fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_ignite();
;
exit;
;
}
}
if ((lifetime <= 0)) {
{
image_xscale -= 0.05;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:248
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_projectile() {
if ((((((scrFRInstanceIs((scrFROther(other)), Flame) || scrFRInstanceIs((scrFROther(other)), TrapFire)) || scrFRInstanceIs((scrFROther(other)), FlameShell)) || (scrFRVariableExists((scrFROther(other)), "is_flame") && ((scrFROther(other)).is_fire == true))) || (scrFRVariableExists(scrFRSelf(self), "is_explosion") && ((scrFROther(other)).is_explosion == true))) || (scrFRVariableExists((scrFROther(other)), "fr_ignitePowder") && ((scrFROther(other)).fr_ignitePowder == true)))) {
{
fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_ignite();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:258
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_ignite() {
if ((image_xscale >= (maxSize / 2))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitch(sndExplosion, (0.9 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndScorpionFire, (0.7 + scrFRSourceRandom(0.2)));
;
repeat (scrFRSourceIRandom(2)) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles_mod_gml_orandom(8)), (y + fr_Objects_Frontier_Projectiles_mod_gml_orandom(8)), SmallExplosion)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
hitid = __fr_other8.hitid;
;
}
}
if(__fr_break7) break;
}}
}
}
}
if ((image_xscale <= (maxSize / 2))) {
{
scrFRSoundPitch(sndExplosionS, (0.9 + scrFRSourceRandom(0.2)));
;
scrFRInstanceCreate(x, y, SmallExplosion);
;
}
}
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:277
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderProjectile);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
hitid = [sprite_index, "GUNPOWDER SPREAD"];
;
mask_index = mskNone;
;
speed = (12) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 0;
;
damage = 0;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
z = 12;
;
zspeed = 10;
;
zfriction = 1;
;
wib_projspeed = true;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_step;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:308
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_step() {
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), ((y - z) + scrFRSourceRandomRange((- 8), 8)), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprBreath);
;
var __fr_other4=scrFROther(other);
direction = (((__fr_other4.direction + 180) + (__fr_other4.z / 70)) + scrFRSourceRandomRange((- 20), 20));
;
speed = (scrFRSourceRandom(1)) * timescale;
;
image_blend = make_colour_rgb(74, 60, 78);
;
}
}
if(__fr_break3) break;
}}
}
}
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
image_angle -= (sign((hspeed / timescale)) * (abs(((vspeed / timescale) / 2)) + abs((hspeed / timescale))));
;
if ((z <= 12)) {
{
mask_index = mskFlakBullet;
;
}
} else {
{
mask_index = mskNone;
;
}
}
if ((z <= 0)) {
{
friction = (0.4) * (timescale * timescale);
;
depth = (- 3);
;
if (((speed / timescale) > 0)) {
{
var _frl_m = 4;
;
if (((speed / timescale) > _frl_m)) {
speed = (_frl_m) * timescale;
}
}
}
if ((zspeed < (- 10))) {
{
if ((z < 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}
} else {
{
friction = (0) * (timescale * timescale);
;
depth = (- 9);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:356
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_destroy() {
scrFRSoundPitch(sndBurn, (1.2 + scrFRSourceRandom(0.5)));
;
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = (3) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GunpowderCreep_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:369
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderProjectile_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 140)), (image_yscale + (z / 140)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:372
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShank_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShank);
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
hitid = [sprite_index, "GUNPOWDER SHANK"];
;
speed = (2) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 0;
;
damage = 12;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
canfix = false;
;
canreflect = false;
;
is_melee = true;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShank_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:397
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShank_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(45, direction)), (y + lengthdir_y(45, direction)), Explosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitch(sndExplosion, (0.9 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndScorpionFire, (0.7 + scrFRSourceRandom(0.2)));
;
repeat (scrFRSourceIRandom(4)) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(((x + lengthdir_x(45, direction)) + fr_Objects_Frontier_Projectiles_mod_gml_orandom(8)), ((y + lengthdir_y(45, direction)) + fr_Objects_Frontier_Projectiles_mod_gml_orandom(8)), SmallExplosion)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
hitid = __fr_other8.hitid;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:409
function fr_Objects_Frontier_Projectiles_mod_gml_SharpSlash_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSharpSlash);
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
hitid = [sprite_index, "SHARP SLASH"];
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSharpSlash;
;
speed = (2) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 0;
;
damage = 12;
;
knockback_speed = (12) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
canfix = false;
;
canreflect = false;
;
walled = false;
;
is_melee = true;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_SharpSlash_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_SharpSlash_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:438
function fr_Objects_Frontier_Projectiles_mod_gml_SharpSlash_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:443
function fr_Objects_Frontier_Projectiles_mod_gml_SharpSlash_wall() {
if ((! walled)) {
{
walled = true;
;
friction = (0.4) * (timescale * timescale);
;
x += hspeed;
;
y += vspeed;
;
x -= hspeed;
;
y -= vspeed;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:455
function fr_Objects_Frontier_Projectiles_mod_gml_FireSlash_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireSlash);
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
hitid = [sprite_index, "FIRE SLASH"];
;
fr_bloom = [1.1, 0.1];
;
mask_index = mskSlash;
;
speed = (2) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 0;
;
damage = 32;
;
knockback_speed = (12) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
canfix = false;
;
canreflect = true;
;
walled = false;
;
fr_ignitePowder = true;
;
fr_augBoilDmg = true;
;
is_melee = true;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_FireSlash_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_FireSlash_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:487
function fr_Objects_Frontier_Projectiles_mod_gml_FireSlash_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:492
function fr_Objects_Frontier_Projectiles_mod_gml_FireSlash_wall() {
if ((! walled)) {
{
walled = true;
;
friction = (0.4) * (timescale * timescale);
;
x += hspeed;
;
y += vspeed;
;
x -= hspeed;
;
y -= vspeed;
;
}
}
x -= hspeed;
;
y -= vspeed;
;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, FloorExplo);
;
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:512
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGrapeshot);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGrapeshotDisappear;
;
spr_dead = sprBulletHit;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
speed = (16) * timescale;
;
friction = (0.55) * (timescale * timescale);
;
typ = 1;
;
damage = 4;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "GRAPESHOT"];
;
bonus = true;
;
bonus_damage = 2;
;
minspeed = 6;
;
maxspeed = (16) * timescale;
;
wallbounce = (4 * scrFRGetSkill(mut_shotgun_shoulders));
;
ammo_type = 2;
;
is_shell = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_wall;
;
on_alrm2 = ["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:553
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_anim() {
if ((sprite_index != spr_fade)) {
{
image_speed = (0) * timescale;
;
image_index = (image_number - 1);
;
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Objects/Frontier_Projectiles.mod.gml:564
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_alarm2_run) {
exit;
}
if ((((speed / timescale) < minspeed) && (sprite_index != spr_fade))) {
{
damage /= 2;
;
sprite_index = scrFRAreaSourceSprite(spr_fade);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:577
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_alrm2() {
bonus = false;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:580
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_dead);
;
}
}
if(__fr_break4) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:591
function fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_wall() {
scrFRInstanceCreate(x, y, Dust);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
if (((wallbounce > 0) && (! bonus))) {
{
bonus = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.55) + wallbounce), (maxspeed / timescale))) * timescale;
;
wallbounce *= 0.95;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:609
function fr_Objects_Frontier_Projectiles_mod_gml_GoldGrapeshot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldGrapeshotDisappear;
;
friction = (0.5) * (timescale * timescale);
;
wallbounce = (5 * scrFRGetSkill(mut_shotgun_shoulders));
;
minspeed = 5;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:619
function fr_Objects_Frontier_Projectiles_mod_gml_PopoGrapeshot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_Grapeshot_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPopoGrapeshot);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPopoGrapeshotDisappear;
;
spr_dead = sprIDPDBulletHit;
;
wallbounce = (4 * scrFRGetSkill(mut_shotgun_shoulders));
;
minspeed = 5.5;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:630
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBlunderball);
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBlunderballDebris;
;
image_angle = scrFRSourceRandom(360);
;
trailColor = c_white;
;
depth = (- 3);
;
sparkly = false;
;
mask_index = mskEnemyBullet1;
;
speed = (16) * timescale;
;
friction = (0) * (timescale * timescale);
;
typ = 1;
;
maxDamage = 30;
;
damage = maxDamage;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "BLUNDERBALL"];
;
ammo_type = 4;
;
is_explosive = true;
;
z = 0;
;
zfriction = 0;
;
endBounce = false;
;
TURBOMODE = false;
;
rotspeed = (12 * scrFRSourceScale());
;
wallBreaks = 8;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:674
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_step() {
if (((speed / timescale) > 1)) {
{
image_angle += rotspeed;
;
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(1.5) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (5) * timescale;
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((sparkly == true)) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
speed = (5) * timescale;
;
var __fr_other8=scrFROther(other);
direction = ((__fr_other8.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
}
}
if(__fr_break7) break;
}}
}
}
}
}
}
}
}
}
if (((speed / timescale) <= 12)) {
{
if ((endBounce == false)) {
{
image_angle += (rotspeed * 2);
;
z += ((1 + (3 - zfriction)) * scrFRSourceScale());
;
zfriction += 0.1;
;
if ((z >= 30)) {
{
endBounce = true;
;
zfriction = 0;
;
}
}
}
} else {
{
image_angle += (rotspeed * 2);
;
z -= (zfriction * scrFRSourceScale());
;
zfriction += 0.7;
;
if ((z < 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
}
}
if (scrFRPlaceMeeting(x, y, Explosion)) {
{
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
hitid = [sprite_index, "BLUNDERBALL EXPLOSION"];
}
}
if(__fr_break11) break;
}}
repeat (3) {
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
hitid = [sprite_index, "BLUNDERBALL EXPLOSION"];
}
}
if(__fr_break14) break;
}}
}
scrFRSoundPitch(sndExplosionCar, 1.1);
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:731
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_endstep() {
if ((TURBOMODE == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_yscale *= 4;
;
image_speed *= 4;
;
var __fr_other6=scrFROther(other);
image_angle = point_direction(x, y, __fr_other6.xprevious, __fr_other6.yprevious);
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.trailColor;
;
image_alpha = 0.7;
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
if (scrFRPlaceMeeting(x, y, projectile)) {
{
var _frl__inst = frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.instances_meeting, x, y, [Slash, FR_OBJECT_GUITAR_SLASH, BloodSlash, EnergySlash, EnergyHammerSlash, LightningSlash, FRCustomSlash]);
;
if (array_length(_frl__inst)) {
{ var __fr_with8 = scrFRWithValues(_frl__inst), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "ammo_type")) || (ammo_type != (- 1)))) {
{
if ((scrFRPlaceMeeting(x, y, (scrFROther(other))) && ((scrFROther(other)).z <= 24))) {
{
event_perform(ev_collision, Grenade);
;
{ var __fr_with11 = scrFRWithValues((scrFROther(other))), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_smackdown();
;
}
}
if(__fr_break13) break;
}}
if ((! scrFRInstanceExists((scrFROther(other))))) {
exit;
}
}
}
}
}
}
}
if(__fr_break10) break;
}}
}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:759
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_smackdown() {
TURBOMODE = true;
;
z = 0;
;
zfriction = 0;
;
endBounce = false;
;
speed = (18) * timescale;
;
damage = maxDamage;
depth = (- 3);
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + scrFRSourceRandomRange((- 45), 45));
;
speed = ((5 + scrFRSourceRandom(3))) * timescale;
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth - 1);
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitch(sndExplosionS, (1.5 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndScrewdriver, (1.3 + scrFRSourceRandom(0.1)));
;
}

// Original Objects/Frontier_Projectiles.mod.gml:779
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_hit() {
if ((damage > 0)) {
{
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
if ((TURBOMODE == false)) {
{
if ((damage > (scrFROther(other)).max_hp)) {
{
var _frl__myHealth = (scrFROther(other)).max_hp;
;
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
damage -= _frl__myHealth;
;
}
} else {
{
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage, (knockback_speed / timescale));
;
damage = 0;
;
speed = (1) * timescale;
;
depth = (- 9);
;
scrFRSoundPitch(sndHitRock, (0.6 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndCrownGuardianDead, (1.7 + scrFRSourceRandom(0.1)));
;
repeat (5) {
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break5) break;
}}
}
}
}
}
} else {
{
var __fr_other6=scrFROther(other);
scrFRProjectileHit(__fr_other6, damage, (knockback_speed / timescale));
}
}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:807
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_wall() {
if ((TURBOMODE == false)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
if ((wallBreaks > 0)) {
{
wallBreaks -= 1;
;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, FloorExplo);
;
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
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

// Original Objects/Frontier_Projectiles.mod.gml:823
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_destroy() {
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (5) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_debris);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitch(sndExplosionS, (1.2 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndWallBreak, (1.2 + scrFRSourceRandom(0.1)));
;
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
hitid = [sprite_index, "BLUNDERBALL EXPLOSION"];
}
}
if(__fr_break10) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:844
function fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 70)), (image_yscale + (z / 70)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:847
function fr_Objects_Frontier_Projectiles_mod_gml_HeavyBlunderball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprHeavyBlunderball);
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBlunderballDebris;
;
image_angle = scrFRSourceRandom(360);
;
trailColor = c_lime;
;
depth = (- 3);
;
sparkly = false;
;
mask_index = mskSuperFlakBullet;
;
speed = (13) * timescale;
;
friction = (0) * (timescale * timescale);
;
typ = 1;
;
maxDamage = 60;
;
damage = maxDamage;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "BLUNDERBOULDER"];
;
ammo_type = 4;
;
is_explosive = true;
;
z = 0;
;
zfriction = 0;
;
endBounce = false;
;
TURBOMODE = false;
;
rotspeed = (8 * scrFRSourceScale());
;
wallBreaks = 18;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_HeavyBlunderball_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:889
function fr_Objects_Frontier_Projectiles_mod_gml_HeavyBlunderball_destroy() {
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (9) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_debris);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitch(sndExplosionL, (1.2 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndWallBreak, (1.2 + scrFRSourceRandom(0.1)));
;
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, GreenExplosion)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
hitid = [sprite_index, "BLUNDERBALL EXPLOSION"];
}
}
if(__fr_break10) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:910
function fr_Objects_Frontier_Projectiles_mod_gml_GoldenBlunderball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_Blunderball_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldBlunderball);
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldBlunderballDebris;
;
trailColor = make_color_rgb(203, 167, 58);
;
sparkly = true;
;
maxDamage = 34;
;
damage = maxDamage;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_GoldBlunderball_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:925
function fr_Objects_Frontier_Projectiles_mod_gml_GoldBlunderball_destroy() {
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (5) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_debris);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitch(sndExplosion, (1.2 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndWallBreak, (1.2 + scrFRSourceRandom(0.1)));
;
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
hitid = [sprite_index, "BLUNDERBALL EXPLOSION"];
}
}
if(__fr_break10) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:947
function fr_Objects_Frontier_Projectiles_mod_gml_EpicCannonball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicCannonball);
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
speed = (16) * timescale;
;
typ = 1;
;
damage = 16;
;
knockback_speed = (20) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "EPIC AS HELL CANNONBALL"];
;
ammo_type = 5;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_EpicCannonball_step;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_EpicCannonball_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:972
function fr_Objects_Frontier_Projectiles_mod_gml_EpicCannonball_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicTrail);
;
var __fr_other4=scrFROther(other);
speed = (((__fr_other4.speed / timescale) / 4)) * timescale;
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + scrFRSourceRandomRange((- 3), 3)) + 180);
;
image_angle = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), Smoke)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
var __fr_other9=scrFROther(other);
speed = (((__fr_other9.speed / timescale) / 4)) * timescale;
;
var __fr_other10=scrFROther(other);
direction = ((__fr_other10.direction + scrFRSourceRandomRange((- 3), 3)) + 180);
;
}
}
if(__fr_break8) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:990
function fr_Objects_Frontier_Projectiles_mod_gml_EpicCannonball_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.8;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaImpact)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicPlasmaImpact);
;
}
}
if(__fr_break6) break;
}}
repeat (8) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicStreak);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = (4) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
{
i = 0;
for (; (i < 360); i += 30) {
{ var __fr_with10 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_create(x, y)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
speed += (scrFRSourceRandom(2)) * timescale;
;
var __fr_other13=scrFROther(other);
direction = ((__fr_other13.direction + __fr_other13.i) + scrFRSourceRandomRange((- 16), 16));
;
image_angle = direction;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14.creator;
;
}
}
if(__fr_break12) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1015
function fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicShrapnel);
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
speed = (8) * timescale;
;
friction = (0.7) * (timescale * timescale);
;
typ = 1;
;
damage = 5;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "EPIC AS HELL SHRAPNEL FROM EPIC AS HELL CANNONBALL"];
;
ammo_type = 5;
;
minspeed = 2;
;
maxspeed = (8) * timescale;
;
wallbounce = (1 * scrFRGetSkill(mut_laser_brain));
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_step;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1045
function fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_step() {
if (((speed / timescale) < minspeed)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1050
function fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_wall() {
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.55) + wallbounce), (maxspeed / timescale))) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1055
function fr_Objects_Frontier_Projectiles_mod_gml_EpicShrapnel_destroy() {
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
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicPlasmaImpactSmall);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskPlasmaImpactSmall;
;
var __fr_other5=scrFROther(other);
hitid = __fr_other5.hitid;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1065
function fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_EpicBeam";
;
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeam);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskEpicBeam;
;
spr_tail = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeamStart;
;
spr_head = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicBeamHead;
;
image_speed = (0) * timescale;
;
direction = _frl__direction;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
lifetime = (3 * scrFRGetSkill(mut_laser_brain));
;
damage = 15;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_draw;
;
var _frl__scanLength = fr_Objects_Frontier_Projectiles_mod_gml_binary_search(["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_check_laser_style], 500);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
;
yprevious = y;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1098
function fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_step() {
if (scrFRInstanceExists(creator)) {
{
xstart = (creator.x + creator.hspeed);
;
ystart = (creator.y + creator.vspeed);
var _frl__scanLength = fr_Objects_Frontier_Projectiles_mod_gml_binary_search(["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_check_laser_style], 500);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
;
yprevious = y;
;
direction = creator.gunangle;
image_angle = direction;
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
}
}
if ((scrFRSourceRandom(2) < 1)) {
{
var _frl__r = scrFRSourceRandomRange(0, ((image_xscale * 2) + 12));
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x - lengthdir_x(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), ((y - lengthdir_y(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprEpicTrail);
;
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.direction;
image_speed = (0.4) * timescale;
;
var __fr_other5=scrFROther(other);
scrFRMotionSet(__fr_other5.direction, scrFRSourceChoose(1, 2));
;
}
}
if(__fr_break3) break;
}}
}
}
image_yscale = (1 * scrFRSourceRandomRange(0.8, 1.1));
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1137
function fr_Objects_Frontier_Projectiles_mod_gml_binary_search(_frl_checkScript=undefined, _frl_searchLength=undefined) {
var _frl_length = _frl_searchLength;
var _frl_lenDiff = _frl_searchLength;
;
if (scrFRScriptCall(_frl_checkScript, _frl_length)) {
{
_frl_lenDiff /= 2;
;
_frl_length -= _frl_lenDiff;
;
}
} else {
{
return _frl_searchLength;
;
}
}
while ((_frl_lenDiff > 1)) {
_frl_lenDiff /= 2;
;
if (scrFRScriptCall(_frl_checkScript, _frl_length)) {
{
_frl_length -= _frl_lenDiff;
;
}
} else {
{
_frl_length += _frl_lenDiff;
;
}
}
}
return _frl_length;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1162
function fr_Objects_Frontier_Projectiles_mod_gml_check_laser_style(_frl_length=undefined) {
x = (xstart + lengthdir_x(_frl_length, image_angle));
;
y = (ystart + lengthdir_y(_frl_length, image_angle));
;
image_xscale = (_frl_length / 2);
;
return scrFRPlaceMeeting(x, y, Wall);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1168
function fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_hit() {
var _frl__team = team;
var _frl__ang = direction;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((nexthurt <= scrFRSourceFrame())) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other4.damage);
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1177
function fr_Objects_Frontier_Projectiles_mod_gml_EpicBeam_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_tail, 1, xstart, ystart, 1, image_yscale, image_angle, image_blend, 1.0);
}
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2), (image_yscale * 2), (image_angle - 45), image_blend, 1.0);
}
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, (image_yscale * 1.7), image_angle, image_blend, 0.2);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_tail, 1, xstart, ystart, 1, (image_yscale * 1.5), image_angle, image_blend, 0.2);
}
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2.7), (image_yscale * 2.7), (image_angle - 45), image_blend, 0.2);
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1187
function fr_Objects_Frontier_Projectiles_mod_gml_SpikerSplinter_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Splinter)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((18 + scrFRSourceRandom(4))) * timescale;
;
damage = 5;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSpikerSplinter);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1197
function fr_Objects_Frontier_Projectiles_mod_gml_GoldSpikerSplinter_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Splinter)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((18 + scrFRSourceRandom(4))) * timescale;
;
damage = 5;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldSpikerSplinter);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1207
function fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameBulletHit;
;
fr_bloom = [2, 0.2];
fr_glow = [32, 48];
;
mask_index = mskBullet1;
;
speed = (16) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
gland = 1;
;
damage = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "FLAME BULLET"];
;
ammo_type = 1;
;
is_bullet = true;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_anim;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1238
function fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1242
function fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
if (((gland != 0) && scrFRInstanceIs(creator, Player))) {
{
if (fr_Objects_Frontier_Projectiles_mod_gml_chance((3 * scrFRGetSkill(mut_recycle_gland)), 5)) {
{
var _frl__ammo = scrFRIndexGet(creator.ammo, 1);
var _frl__amax = scrFRIndexGet(scrFRAmmoArray(creator, "typ_amax"), 1);
;
if ((_frl__ammo < _frl__amax)) {
{
scrFRMemberIndexWrite(creator, "ammo", [1], min((_frl__ammo + gland), _frl__amax), "=");
;
scrFRInstanceCreate(x, y, RecycleGland);
;
scrFRSoundHit(sndRecGlandProc, 0.1);
;
}
}
}
}
}
}
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1263
function fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_wall() {
move_bounce_solid(true);
;
scrFRInstanceCreate(x, y, Smoke);
;
scrFRSoundHit(sndHitWall, 0.2);
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1270
function fr_Objects_Frontier_Projectiles_mod_gml_FlameBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
var __fr_other7=scrFROther(other);
direction = __fr_other7.direction;
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other11.spr_dead);
;
}
}
if(__fr_break10) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1282
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_create(_frl__x=undefined, _frl__y=undefined, _frl__targetX=undefined, _frl__targetY=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnet);
;
spr_hook = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetHook;
;
spr_blink = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetBlink;
;
hitid = [sprite_index, "MAGNET"];
;
blinkStart = false;
;
mask_index = mskBolt;
;
speed = (18) * timescale;
;
targetX = _frl__targetX;
;
targetY = _frl__targetY;
;
knockback_speed = (4) * timescale;
;
typ = 1;
;
damage = 0;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
grounded = false;
;
seekGround = true;
;
fr_magnetic = true;
;
lifeTime = 400;
;
stuckOn = noone;
;
ammo_type = 3;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_Magnet_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Magnet_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Magnet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Magnet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_Magnet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1319
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_anim() {
if ((blinkStart == false)) {
{
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1325
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_step() {
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((scrFRSourceRandom(25) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles_mod_gml_orandom(24)), (y + fr_Objects_Frontier_Projectiles_mod_gml_orandom(24)), CaveSparkle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprMagnetSuck);
;
image_angle = scrFRSourceRandom(360);
;
var __fr_other4=scrFROther(other);
direction = point_direction(x, y, __fr_other4.x, __fr_other4.y);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
if (((stuckOn != noone) && (grounded == false))) {
{
if ((! scrFRInstanceExists(stuckOn))) {
{
grounded = true;
;
sprite_index = scrFRAreaSourceSprite(spr_hook);
;
image_speed = (0.4) * timescale;
;
image_angle = 270;
;
speed = (0) * timescale;
;
exit;
;
}
} else {
{
x = (stuckOn.x + lengthdir_x((- 16), direction));
;
y = (stuckOn.y + lengthdir_y((- 16), direction));
;
}
}
}
}
if ((seekGround == true)) {
{
if ((distance_to_point(targetX, targetY) <= 0)) {
{
friction = (6) * (timescale * timescale);
;
}
}
if (((speed / timescale) <= 1)) {
{
speed = (0) * timescale;
;
seekGround = false;
;
grounded = true;
;
sprite_index = scrFRAreaSourceSprite(spr_hook);
;
image_speed = (0.4) * timescale;
;
image_angle = 270;
;
speed = (0) * timescale;
;
mask_index = mskNone;
;
repeat (3) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
scrFRSoundHit(sndBoltHitWall, 0.2);
;
}
}
}
}
if (((lifeTime <= 50) && (blinkStart == false))) {
{
blinkStart = true;
;
sprite_index = scrFRAreaSourceSprite(spr_blink);
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1386
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
if (((scrFROther(other)).hp > damage)) {
{
var __fr_other1=scrFROther(other);
stuckOn = __fr_other1;
;
seekGround = false;
;
speed = (0) * timescale;
;
mask_index = mskNone;
;
}
}
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage, (knockback_speed / timescale));
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1401
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_wall() {
if ((((speed / timescale) > 0) && (seekGround == true))) {
{
speed = (0) * timescale;
;
seekGround = false;
;
mask_index = mskNone;
;
scrFRInstanceCreate(x, y, Dust);
;
move_contact_solid(direction, 16);
;
xprevious = x;
;
yprevious = y;
;
scrFRSoundHit(sndBoltHitWall, 0.2);
;
scrFRInstanceCreate(x, y, Dust);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1419
function fr_Objects_Frontier_Projectiles_mod_gml_Magnet_destroy() {
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitchVolume(sndHitMetal, (1.4 + scrFRSourceRandom(0.1)), 0.5);
}

// Original Objects/Frontier_Projectiles.mod.gml:1428
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprSawblade);
;
spr_trail = sprDiscTrail;
;
image_angle = scrFRSourceRandom(360);
;
hitid = [sprite_index, "SAWBLADE"];
;
trailColor = c_white;
;
depth = (- 1);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSawblade;
;
speed = (9) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
damage = 5;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
ammo_type = 3;
;
lifeTime = 200;
;
wallCooldown = 0;
;
nearestMagnet = noone;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1463
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1467
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_step() {
image_angle += (20 * scrFRSourceScale());
;
lifeTime -= scrFRSourceScale();
;
if ((wallCooldown > 0)) {
{
wallCooldown -= scrFRSourceScale();
;
}
}
nearestMagnet = frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(projectile, "fr_magnetic", true));
;
if ((distance_to_object(nearestMagnet) < 64)) {
{
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
direction -= (angle_difference(direction, point_direction(x, y, nearestMagnet.x, nearestMagnet.y)) * power((0.15 + (0.10 * scrFRGetSkill(mut_bolt_marrow))), 1));
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1482
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_endstep() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = 0;
;
var __fr_other4=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other4.xprevious, __fr_other4.yprevious);
image_yscale *= 4;
;
image_speed *= (1 + (3 - (scrFRGetSkill(mut_bolt_marrow) * 1.5)));
;
var __fr_other5=scrFROther(other);
image_angle = point_direction(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
var __fr_other6=scrFROther(other);
image_blend = __fr_other6.trailColor;
;
image_alpha = 0.7;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1493
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
if ((distance_to_object(nearestMagnet) > 64)) {
{
lifeTime -= 50;
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1503
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_wall() {
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
wallCooldown += 2;
;
if ((wallCooldown >= 12)) {
{
lifeTime -= 20;
;
}
}
move_bounce_solid(true);
;
scrFRSoundPitchVolume(sndDiscBounce, (0.7 + scrFRSourceRandom(0.2)), 0.4);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, DiscBounce)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_angle = (__fr_other4.direction - 180);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1521
function fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_destroy() {
scrFRSoundHit(sndDiscDie, 0.2);
;
scrFRInstanceCreate(x, y, DiscDisappear);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1525
function fr_Objects_Frontier_Projectiles_mod_gml_GoldSawblade_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_Sawblade_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldSawblade);
;
trailColor = make_color_rgb(203, 167, 58);
;
speed = (10) * timescale;
damage = 6;
;
lifeTime = 220;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1540
function fr_Objects_Frontier_Projectiles_mod_gml_GoldMagnet_create(_frl__x=undefined, _frl__y=undefined, _frl__targetX=undefined, _frl__targetY=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_Magnet_create(_frl__x, _frl__y, _frl__targetX, _frl__targetY)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldMagnet);
;
spr_hook = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldMagnetHook;
;
lifeTime = 450;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1553
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBallistaBolt);
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameTrail;
;
hitid = [sprite_index, "BALLISTA BOLT"];
;
trailColor = c_white;
;
depth = (- 1);
;
mask_index = mskHeavyBolt;
;
speed = (16) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
damage = 20;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
ammo_type = 3;
;
is_bolt = true;
;
home_inst = noone;
;
home_dir = 0;
;
stuckOn = noone;
;
lifeTime = 200;
;
wallOffset = (- 16);
;
subSpread = (- 24);
;
subCount = 4;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1592
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1596
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_step() {
if ((stuckOn == noone)) {
{
if ((home_inst != noone)) {
{
if ((scrFRInstanceExists(home_inst) && scrFRProjectileCanHitMelee(home_inst))) {
{
if (((abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90) && (! scrFRPlaceMeeting((x + lengthdir_x((speed / timescale), home_dir)), (y + lengthdir_y((speed / timescale), home_dir)), home_inst)))) {
{
var _frl__tx = (home_inst.x - lengthdir_x((speed / timescale), home_dir));
var _frl__ty = (home_inst.y - lengthdir_y((speed / timescale), home_dir));
var _frl__diff = ((angle_difference(point_direction(x, y, _frl__tx, _frl__ty), direction) * 0.5) * scrFRSourceScale());
;
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
{
home_inst = noone;
;
direction = home_dir;
;
image_angle = direction;
;
}
}
}
} else {
if ((direction != home_dir)) {
{
var _frl__diff = angle_difference(home_dir, direction);
;
if ((abs(_frl__diff) > 10)) {
_frl__diff = ((_frl__diff * 0.5) * scrFRSourceScale());
}
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
home_inst = noone;
}
}
;
}
} else {
{
home_dir = direction;
;
var _frl__disMax = (24 * scrFRGetSkill(mut_bolt_marrow));
;
if ((_frl__disMax > 0)) {
{
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(hitme, "team", team, 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{
var _frl__dis = distance_to_point(((scrFROther(other)).x + ((scrFROther(other)).hspeed / timescale)), ((scrFROther(other)).y + ((scrFROther(other)).vspeed / timescale)));
;
if ((_frl__dis < _frl__disMax)) {
{
if (scrFRPlaceMeeting((scrFROther(other)).x, (scrFROther(other)).y, (scrFROther(other)))) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
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
home_inst = _frl__nearest;
;
}
}
}
}
if (((speed / timescale) > 0)) {
{
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
direction = ((__fr_other7.direction + 180) + scrFRSourceRandomRange((- 45), 45));
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break6) break;
}}
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other11.spr_trail);
;
var __fr_other12=scrFROther(other);
direction = ((__fr_other12.direction + 180) + scrFRSourceRandomRange((- 30), 30));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
friction = (0.02) * (timescale * timescale);
;
depth = (- 2);
;
}
}
if(__fr_break10) break;
}}
}
}
}
}
}
}
}
} else {
{
if ((! scrFRInstanceExists(stuckOn))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
x = (stuckOn.x + lengthdir_x(wallOffset, direction));
;
y = (stuckOn.y + lengthdir_y(wallOffset, direction));
;
}
}
}
}
if ((((speed / timescale) <= 0) && (stuckOn == noone))) {
{
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1704
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_hit() {
var _frl__ang = direction;
var _frl__spread = subSpread;
;
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
repeat (subCount) {
{ var __fr_with2 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_BallistaSubBolt_create(x, y)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
direction = (_frl__ang + _frl__spread);
;
image_angle = direction;
;
}
}
if(__fr_break4) break;
}}
_frl__spread += 16;
;
}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
creator = __fr_other8.creator;
;
hitid = [sprite_index, "EXPLOSION"];
}
}
if(__fr_break7) break;
}}
scrFRSoundPitch(sndExplosion, (1.1 + scrFRSourceRandom(0.1)));
scrFRSoundPitch(sndBoltHitWall, (0.7 + scrFRSourceRandom(0.1)));
;
scrFRSoundPitch(sndCrossbow, (0.7 + scrFRSourceRandom(0.1)));
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1725
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_endstep() {
if ((stuckOn == noone)) {
{
var _frl__x1 = x;
var _frl__y1 = y;
var _frl__x2 = xprevious;
var _frl__y2 = yprevious;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BoltTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = point_distance(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
image_yscale = 1.2;
;
image_angle = point_direction(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1739
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_wall() {
if (((speed / timescale) > 0)) {
{
speed = (0) * timescale;
;
mask_index = mskNone;
;
scrFRInstanceCreate(x, y, Dust);
;
move_contact_solid(direction, 8);
;
xprevious = x;
;
yprevious = y;
;
scrFRSoundHit(sndBoltHitWall, 0.2);
;
scrFRInstanceCreate(x, y, Dust);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1756
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_destroy() {
scrFRInstanceCreate(x, y, Smoke);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:1759
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaSubBolt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprBallistaSubBolt);
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameTrail;
;
hitid = [sprite_index, "BALLISTA SPLINTER"];
;
trailColor = c_white;
;
depth = (- 1);
;
speed = (18) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 1;
;
damage = 15;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
ammo_type = 3;
;
is_bolt = true;
;
home_inst = noone;
;
home_dir = 0;
;
stuckOn = noone;
;
lifeTime = 200;
;
wallOffset = 16;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_BallistaSubBolt_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_BallistaBolt_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1794
function fr_Objects_Frontier_Projectiles_mod_gml_BallistaSubBolt_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
if (((scrFROther(other)).hp > 0)) {
{
var __fr_other2=scrFROther(other);
stuckOn = __fr_other2;
;
speed = (0) * timescale;
;
mask_index = mskNone;
;
}
}
scrFRInstanceCreate(x, y, SmallExplosion);
;
scrFRSoundPitch(sndExplosionS, (1.1 + scrFRSourceRandom(0.1)));
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1809
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_OilCreep";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCreep);
;
spr_bubble = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameCreepBubble;
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
creep_color = make_color_rgb(26, 23, 38);
creep_color_2 = make_color_rgb(0, 0, 0);
image_blend = creep_color;
;
underwater_fx = ((scrFRArrayFindIndex([101, "oasis"], GameCont.area) >= 0) || (scrFRSourceAreaIsString(GameCont.area) && (scrFRModCall("area", GameCont.area, "area_underwater") == true)));
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskGunpowderCreep;
;
speed = (0) * timescale;
;
typ = (- 1);
;
damage = 0;
;
team = 1724;
;
hitid = [sprite_index, "OIL"];
;
lifetime = 350;
;
allGrownUp = false;
;
maxSize = 1;
;
ignited = false;
;
fr_ignitePowder = false;
;
var __fr_other4=scrFROther(other);
ogTeam = __fr_other4.team;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_step;
;
on_projectile = fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_projectile;
;
on_grenade = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
hitbox = fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_create(x, y, scrFRSelf(self));
;
scrFRBindDraw(fr_Objects_Frontier_Projectiles_mod_gml_PlayerCreepLow_draw, (depth + 1), scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1852
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
lifetime -= scrFRSourceScale();
;
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.1;
;
image_yscale = image_xscale;
;
if ((image_xscale >= maxSize)) {
{
allGrownUp = true;
;
}
}
}
}
if ((ignited == false)) {
{
if ((distance_to_object(Explosion) < 2)) {
{
fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_ignite();
;
}
}
}
} else {
{
fr_glow = [(32 * image_xscale), (48 * image_xscale)];
;
if (((allGrownUp == true) && (lifetime > 0))) {
{
image_xscale = (maxSize + fr_Objects_Frontier_Projectiles_mod_gml_orandom(0.02));
;
image_yscale = image_xscale;
;
if ((scrFRSourceRandom(20) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * maxSize))), (y + fr_Objects_Frontier_Projectiles_mod_gml_orandom((16 * maxSize))), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_bubble);
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
}
if ((! scrFRPlaceMeeting(x, y, Floor))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((lifetime <= 0)) {
{
image_xscale -= 0.05;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1903
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_projectile() {
if ((((((scrFRInstanceIs((scrFROther(other)), Flame) || scrFRInstanceIs((scrFROther(other)), TrapFire)) || scrFRInstanceIs((scrFROther(other)), FlameShell)) || (scrFRVariableExists((scrFROther(other)), "is_flame") && ((scrFROther(other)).is_fire == true))) || (scrFRVariableExists(scrFRSelf(self), "is_explosion") && ((scrFROther(other)).is_explosion == true))) || (scrFRVariableExists((scrFROther(other)), "fr_ignitePowder") && ((scrFROther(other)).fr_ignitePowder == true)))) {
{
if ((ignited == false)) {
{
fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_ignite();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:1915
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_ignite() {
ignited = true;
;
fr_ignitePowder = true;
;
fr_bloom = [2, 0.1];
;
fr_glow = [0, 0];
;
creep_color = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Projectiles"].oilColors, 0);
;
creep_color_2 = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Projectiles"].oilColors, 1);
;
image_blend = creep_color;
;
scrFRSoundPitch(sndExplosionS, (0.9 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndScorpionFire, (0.7 + scrFRSourceRandom(0.2)));
;
lifetime = 100;
;
on_projectile = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
{ var __fr_with1 = scrFRWithValues(hitbox), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
igniteTimer = 2;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1933
function fr_Objects_Frontier_Projectiles_mod_gml_PlayerCreepLow_draw(_frl__creep=undefined) {
if ((! scrFRInstanceExists(_frl__creep))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__creep), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, (y + 1), image_xscale, image_yscale, image_angle, creep_color_2, image_alpha);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1942
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_create(_frl__x=undefined, _frl__y=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_OilCreepBox";
;
sprite_index = scrFRAreaSourceSprite(_frl__owner.sprite_index);
;
image_angle = _frl__owner.image_angle;
;
image_index = _frl__owner.image_index;
;
image_xscale = _frl__owner.image_xscale;
;
image_yscale = image_xscale;
;
image_speed = (0) * timescale;
;
image_alpha = 0;
;
spr_gameover = _frl__owner.spr_bubble;
;
speed = (0) * timescale;
;
typ = (- 1);
;
damage = 0;
;
team = 1724;
;
hitid = [spr_gameover, "BURNING OIL"];
;
creator = _frl__owner;
;
fr_ignitePowder = false;
;
igniteTimer = 0;
;
ogTeam = _frl__owner.ogTeam;
;
playerDamage = 0;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:1975
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((igniteTimer > 0)) {
{
igniteTimer -= scrFRSourceScale();
;
if ((igniteTimer <= 0)) {
{
fr_ignitePowder = true;
;
team = 1723;
;
creator.team = 1723;
;
damage = 6;
;
fr_augBoilDmg = true;
;
playerDamage = (2 + scrFRGetSkill("AugmentBoilingVeins"));
;
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.ogTeam;
;
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
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
image_xscale = creator.image_xscale;
;
image_yscale = image_xscale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2001
function fr_Objects_Frontier_Projectiles_mod_gml_OilCreepBuffBox_hit() {
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
if ((creator.ignited == false)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffOiledUp"), 30);
;
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
{
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var _frl__dmg = damage;
if (scrFRVariableExists((scrFROther(other)), "boilcap")) {
{
var __fr_other4=scrFROther(other);
_frl__dmg = min(playerDamage, max(0, (__fr_other4.hp - (__fr_other4.boilcap * scrFRGetSkill(mut_boiling_veins)))));
}
}
var __fr_other5=scrFROther(other);
scrFRProjectileHit(__fr_other5, _frl__dmg);
scrFRSoundPitchVolume(sndBurn, (0.8 + scrFRSourceRandom(0.3)), 0.7);
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2022
function fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprOilGrenade);
;
speed = (10) * timescale;
;
friction = (0.45) * (timescale * timescale);
;
typ = 1;
;
damage = 1;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "OIL BUBBLE"];
;
bonus = true;
;
minspeed = 4;
;
maxspeed = (16) * timescale;
;
ammo_type = 4;
;
is_grenade = true;
;
oilTime = 3;
;
oilDis = 36;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_step;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2053
function fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_step() {
if (((speed / timescale) < minspeed)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
oilTime -= scrFRSourceScale();
;
if ((oilTime <= 0)) {
{
oilTime = (35 / (speed / timescale));
;
fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_spreadcreep(x, y);
;
scrFRSoundPitchVolume(sndFrogEggHurt, (1.3 + scrFRSourceRandom(0.1)), 0.4);
;
}
}
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, AcidStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPetrolStreak);
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2077
function fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_wall() {
scrFRSoundPitch(sndGrenadeHitWall, (1.2 + scrFRSourceRandom(0.2)));
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min(((speed / timescale) * 0.8), (maxspeed / timescale))) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2085
function fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_destroy() {
var _frl__offset = scrFRSourceRandom(360);
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += 72) {
fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_spreadcreep((x + lengthdir_x(oilDis, (_frl_i + _frl__offset))), (y + lengthdir_y(oilDis, (_frl_i + _frl__offset))));
;
}
}
fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_spreadcreep(x, y);
;
scrFRSoundPitchVolume(sndExplosionS, (1.4 + scrFRSourceRandom(0.1)), 0.6);
;
scrFRSoundPitchVolume(sndFrogEggHurt, (1.3 + scrFRSourceRandom(0.1)), 0.4);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2095
function fr_Objects_Frontier_Projectiles_mod_gml_OilGrenade_spreadcreep(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_OilCreep_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
ogTeam = __fr_other4.team;
;
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
repeat (2) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, AcidStreak)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprPetrolStreak);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2111
function fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFlameRocket);
;
spr_trail = sprRocketFlame;
;
image_angle = direction;
;
speed = (2) * timescale;
;
maxspeed = (12) * timescale;
;
friction = ((- 0.5)) * (timescale * timescale);
;
typ = 1;
;
damage = 3;
;
ammo_type = 4;
;
is_rocket = true;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "FLAME ROCKET"];
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_step;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2140
function fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_step() {
if (((speed / timescale) >= (maxspeed / timescale))) {
{
friction = (0) * (timescale * timescale);
;
}
}
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2153
function fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_destroy() {
scrFRSoundStop(sndRocketFly);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
var _frl__offset = scrFRSourceRandom(360);
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += 30) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = (_frl_i + _frl__offset);
;
speed = (3) * timescale;
;
var __fr_other10=scrFROther(other);
team = __fr_other10.team;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11.creator;
;
var __fr_other12=scrFROther(other);
hitid = __fr_other12.hitid;
;
}
}
if(__fr_break9) break;
}}
}
}
fr_Objects_Frontier_Projectiles_mod_gml_sound_play_hit_big_ext(sndExplosion, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 0.8);
fr_Objects_Frontier_Projectiles_mod_gml_sound_play_hit_big_ext(sndFlareExplode, (0.7 + scrFRSourceRandomRange(0.8, 1.3)), 1.2);
}

// Original Objects/Frontier_Projectiles.mod.gml:2174
function fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_draw() {
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, 1, 1.2, image_angle, c_white, image_alpha);
;
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(spr_trail, (scrFRSourceFrame() * 0.4), x, y, (1.8 * image_xscale), (1.8 * image_yscale), image_angle, c_white, 0.2);
;
gpu_set_blendmode(bm_normal);
;
draw_self();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2181
function fr_Objects_Frontier_Projectiles_mod_gml_GoldFlameRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_FlameRocket_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldFlameRocket);
;
speed = (3) * timescale;
;
maxspeed = (14) * timescale;
;
friction = ((- 0.7)) * (timescale * timescale);
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2191
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBullet);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletHit;
;
fr_bloom = [2, 0.2];
fr_glow = [16, 32];
;
trailColor = c_white;
;
trailColor2 = make_color_rgb(122, 134, 236);
;
turnSpeed = ((10 + scrFRSourceRandom(5)) * scrFRSourceChoose((- 1), 1));
;
depth = (- 1);
;
image_xscale = ((1 + (scrFRGetSkill(mut_laser_brain) * 0.1)) + (scrFRModGet("mod", "Frontier_Events", "isNight") * 0.15));
;
image_yscale = image_xscale;
;
speed = ((11 + scrFRSourceRandom(3))) * timescale;
;
typ = 1;
;
damage = 3;
;
homerRange = (16 + (scrFRModGet("mod", "Frontier_Events", "isNight") * 4));
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "STAR BULLET"];
;
ammo_type = 5;
;
friction = (0.5) * (timescale * timescale);
;
starDir = scrFRSourceChoose((- 1), 1);
;
minscale = 0.5;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2231
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2235
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
image_angle += turnSpeed;
;
if ((scrFRSourceRandom(10) < 1)) {
{
direction += ((30 + scrFRSourceRandom(20)) * starDir);
;
starDir *= (- 1);
}
}
if ((scrFRSourceRandom(24) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletTrail);
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + fr_Objects_Frontier_Projectiles_mod_gml_orandom(10));
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 8)) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((distance_to_object(enemy) < homerRange)) {
{
var _frl__enemy = instance_nearest(x, y, enemy);
;
direction = point_direction(x, y, _frl__enemy.x, _frl__enemy.y);
}
}
if ((((speed / timescale) <= 2) || (image_xscale <= minscale))) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2258
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep_resume, id, scrFROther(other), _args, 9, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:2259
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:2259
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:2273
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Projectiles.mod.gml:2271
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Projectiles.mod.gml:2270
{
image_blend = merge_color(image_blend, trailColor2, (0.18 * scrFRSourceScale()));
;
}
_fr.pc=5;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:2269
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Objects/Frontier_Projectiles.mod.gml:2268
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Objects/Frontier_Projectiles.mod.gml:2260
{
var __fr_other1=scrFROther(other);
depth = (__fr_other1.depth + 1);
;
var __fr_other2=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other2.xprevious, __fr_other2.yprevious);
image_yscale *= 2;
;
image_speed *= 2;
;
var __fr_other3=scrFROther(other);
image_angle = point_direction(x, y, __fr_other3.xprevious, __fr_other3.yprevious);
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.trailColor;
;
image_alpha = 0.8;
;
var __fr_other5=scrFROther(other);
trailColor2 = __fr_other5.trailColor2;
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Projectiles.mod.gml:2259
scrFRTaskWithEnter(_fr,scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)),8,0);
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:2277
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_hit() {
if ((scrFRProjectileCanHitNP((scrFROther(other))) && frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHitPush(__fr_other1, round((damage * image_xscale)), (knockback_speed / timescale));
;
image_xscale -= 0.2;
;
image_yscale -= 0.2;
;
x -= hspeed;
;
y -= vspeed;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2286
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_wall() {
move_bounce_solid(true);
;
speed *= 0.7;
;
scrFRSoundHit(sndHitWall, 0.2);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2292
function fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2297
function fr_Objects_Frontier_Projectiles_mod_gml_StarBulletTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletTrail);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2304
function fr_Objects_Frontier_Projectiles_mod_gml_StarBig_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBig);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletHit;
;
fr_bloom = [1.3, 0.2];
fr_glow = [16, 32];
;
trailColor = c_white;
;
trailColor2 = make_color_rgb(122, 134, 236);
;
turnSpeed = ((4 + scrFRSourceRandom(2)) * scrFRSourceChoose((- 1), 1));
;
depth = (- 1);
;
image_xscale = 0.3;
;
image_yscale = image_xscale;
;
speed = (12) * timescale;
;
typ = 1;
;
damage = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "STAR BULLET"];
;
ammo_type = 5;
;
friction = (0.5) * (timescale * timescale);
;
minscale = 0.2;
;
maxScale = ((1 + (scrFRGetSkill(mut_laser_brain) * 0.2)) + (scrFRModGet("mod", "Frontier_Events", "isNight") * 0.2));
;
time2Grow = false;
;
grown = false;
;
lifeTime = 40;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_StarBig_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_StarBig_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2345
function fr_Objects_Frontier_Projectiles_mod_gml_StarBig_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(24) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprStarBulletTrail);
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + fr_Objects_Frontier_Projectiles_mod_gml_orandom(10));
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 8)) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
image_angle += turnSpeed;
;
if ((grown == false)) {
{
if ((time2Grow == false)) {
{
if (((speed / timescale) <= 2)) {
{
time2Grow = true;
;
}
}
}
} else {
{
if ((image_xscale < maxScale)) {
{
image_xscale += 0.05;
;
image_yscale = image_xscale;
;
}
} else {
{
grown = true;
;
}
}
}
}
}
} else {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with6 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_StarBullet_create(x, y)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((8 + scrFRSourceRandom(3))) * timescale;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
}
}
if(__fr_break8) break;
}}
}
}
lifeTime -= 1;
;
if ((lifeTime <= 0)) {
{
if ((image_xscale > 0)) {
{
image_xscale -= 0.12;
;
image_yscale = image_xscale;
;
}
} else {
{
scrFRInstanceDestroy();
;
exit;
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

// Original Objects/Frontier_Projectiles.mod.gml:2394
function fr_Objects_Frontier_Projectiles_mod_gml_StarBig_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
speed *= 0.85;
lifeTime -= 0.3;
;
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2402
function fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkBigFlak);
;
depth = (- 1);
;
speed = (12) * timescale;
;
typ = 1;
;
damage = 6;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "BIG INK FLAK"];
;
ammo_type = 2;
;
flakTime = 3;
;
flakCount = 6;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2430
function fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_step() {
flakTime -= scrFRSourceScale();
;
if ((flakTime <= 0)) {
{
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + scrFRSourceRandomRange((- 40), 40));
;
}
}
if(__fr_break3) break;
}}
}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2443
function fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_wall() {
move_bounce_solid(true);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke);
;
}
}
if(__fr_break3) break;
}}
scrFRSoundHit(sndHitWall, 0.2);
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2451
function fr_Objects_Frontier_Projectiles_mod_gml_InkBigFlak_destroy() {
repeat (flakCount) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + scrFRSourceRandomRange((- 25), 25));
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6.creator;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2461
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkFlak);
;
trailColor = make_color_rgb(20, 18, 22);
;
depth = (- 1);
;
speed = ((11 + scrFRSourceRandom(5))) * timescale;
;
typ = 1;
;
damage = 6;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "INK FLAK"];
;
ammo_type = 2;
;
flakCount = 4;
;
friction = (0.25) * (timescale * timescale);
;
minspeed = 4;
;
inkSway = (3 * scrFRSourceRandomRange((- 1), 1));
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2493
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
direction += inkSway;
;
image_angle = direction;
;
}
}
if (((speed / timescale) <= minspeed)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2502
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep_resume, id, scrFROther(other), _args, 9, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:2503
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:2503
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:2516
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Projectiles.mod.gml:2514
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Projectiles.mod.gml:2513
{
image_alpha -= (0.08 * scrFRSourceScale());
;
}
_fr.pc=5;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:2512
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Objects/Frontier_Projectiles.mod.gml:2511
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Objects/Frontier_Projectiles.mod.gml:2504
{
var __fr_other1=scrFROther(other);
depth = (__fr_other1.depth + 1);
;
var __fr_other2=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other2.xprevious, __fr_other2.yprevious);
image_yscale *= 3;
;
image_speed *= 4.5;
;
var __fr_other3=scrFROther(other);
image_angle = point_direction(x, y, __fr_other3.xprevious, __fr_other3.yprevious);
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.trailColor;
;
image_alpha = 1;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Projectiles.mod.gml:2503
scrFRTaskWithEnter(_fr,scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)),8,0);
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:2520
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke);
;
}
}
if(__fr_break4) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2531
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_wall() {
move_bounce_solid(true);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke);
;
}
}
if(__fr_break3) break;
}}
scrFRSoundHit(sndOasisShoot, 0.2);
;
scrFRSoundPitchVolume(sndToxicBoltGas, (0.7 + scrFRSourceRandom(0.1)), 0.2);
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2540
function fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_destroy() {
repeat (flakCount) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_InkShrapnel_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2550
function fr_Objects_Frontier_Projectiles_mod_gml_InkShrapnel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkShrapnel);
;
trailColor = make_color_rgb(20, 18, 22);
;
depth = (- 1);
;
speed = ((4 + scrFRSourceRandom(3))) * timescale;
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
hitid = [sprite_index, "INK SHRAPNEL"];
;
ammo_type = 2;
;
friction = (clamp((0.25 - (0.1 * scrFRGetSkill(mut_shotgun_shoulders))), 0.02, 0.25)) * (timescale * timescale);
;
minspeed = clamp((2 - scrFRGetSkill(mut_shotgun_shoulders)), 0.5, 2);
;
inkSway = (2 * scrFRSourceChoose((- 1), 1));
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_InkFlak_hit;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_InkShrapnel_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2580
function fr_Objects_Frontier_Projectiles_mod_gml_InkShrapnel_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprInkSmoke);
;
image_xscale = 0.6;
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.direction;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2588
function fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_dabloonerbullet";
;
sprite_index = scrFRAreaSourceSprite(sprBullet1);
;
spr_trail = sprDiscTrail;
;
image_angle = scrFRSourceRandom(360);
;
hitid = [sprite_index, "DABLOONER BULLET"];
;
trailColor = c_white;
;
depth = (- 1);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSawblade;
;
speed = (20) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
fr_coinable = true;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_anim;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_destroy;
;
on_coined = ["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_coined];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2615
function fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2619
function fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_destroy() {
scrFRInstanceCreate(x, y, BulletHit);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2622
function fr_Objects_Frontier_Projectiles_mod_gml_DabloonBullet_coined() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_coin", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pauseTime = 10;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2628
function fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_dabloon";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldSawblade);
;
spr_trail = sprDiscTrail;
;
image_angle = scrFRSourceRandom(360);
;
hitid = [sprite_index, "DABLOON"];
;
trailColor = c_white;
;
depth = (- 10);
;
image_alpha = 0;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Projectiles"].mskSawblade;
;
speed = (4) * timescale;
;
coinspeed = (speed / timescale);
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
z = 4;
;
zspeed = 5;
;
zfriction = 0.35;
;
fr_coin = true;
;
pauseTime = 0;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_step;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_draw;
;
fr_Objects_Frontier_Projectiles_mod_gml_CoinTrail_create(x, y, scrFRSelf(self), c_yellow);
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2663
function fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_step() {
var _frl__nearestCoinable = frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(projectile, "fr_coinable", true));
;
if (scrFRPlaceMeeting(x, (y - z), _frl__nearestCoinable)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__nearestCoinable), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRScriptCall(on_coined);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((pauseTime > 0)) {
{
pauseTime -= scrFRSourceScale();
;
speed = (0) * timescale;
;
if ((pauseTime <= 1)) {
{
speed = (coinspeed) * timescale;
;
}
}
}
} else {
{
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
coinspeed = (speed / timescale);
;
if ((z <= 0)) {
{
friction = (0.4) * (timescale * timescale);
;
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2695
function fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), image_xscale, image_yscale, image_angle, image_blend, 1);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2698
function fr_Objects_Frontier_Projectiles_mod_gml_Dabloon_destroy() {
scrFRSoundHit(sndDiscDie, 0.2);
;
scrFRInstanceCreate(x, y, DiscDisappear);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2702
function fr_Objects_Frontier_Projectiles_mod_gml_CoinTrail_create(_frl__x=undefined, _frl__y=undefined, _frl__coin=undefined, _frl__color=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
creator = _frl__coin;
;
trailColor = _frl__color;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoinTrail_endstep;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2710
function fr_Objects_Frontier_Projectiles_mod_gml_CoinTrail_endstep() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = creator.x;
;
y = (creator.y - creator.z);
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (- 10);
;
var __fr_other4=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other4.xprevious, __fr_other4.yprevious);
image_yscale *= 4;
;
image_speed *= 4;
;
var __fr_other5=scrFROther(other);
image_angle = point_direction(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
var __fr_other6=scrFROther(other);
image_blend = __fr_other6.trailColor;
;
image_alpha = 0.7;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2780
function fr_Objects_Frontier_Projectiles_mod_gml_GhostSkull_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ghostskull";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGhostSkull);
;
image_speed = (0.4) * timescale;
;
depth = (- 7);
;
fr_bloom = [1.5, 0.1];
;
speed = (5) * timescale;
;
typ = 1;
;
damage = 6;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "SCARY SKULL!!"];
;
lifeTime = 120;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_GhostSkull_step;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_GhostSkull_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2810
function fr_Objects_Frontier_Projectiles_mod_gml_GhostSkull_step() {
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
image_yscale = ((((image_angle + 270) mod 360) > 180) ? 1 : (- 1));
;
if (scrFRInstanceExists(enemy)) {
{
var _frl_myTarget = instance_nearest(x, y, enemy);
;
direction -= (angle_difference(direction, point_direction(x, y, _frl_myTarget.x, _frl_myTarget.y)) * power(0.1, scrFRSourceScale()));
;
image_angle = direction;
;
}
}
if ((frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active && (scrFRSourceRandom(4) < 1))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 4), 4)), (y + scrFRSourceRandomRange((- 4), 4)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = __fr_other4.direction;
;
speed = (2) * timescale;
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2835
function fr_Objects_Frontier_Projectiles_mod_gml_GhostSkull_wall() {
xprevious = (x + hspeed);
;
yprevious = (y + vspeed);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:2840
function fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_tideslash";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideSlash);
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
hitid = [sprite_index, "TIDE SLASH"];
;
mask_index = mskSlash;
;
speed = (5) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 0;
;
damage = 16;
;
knockback_speed = (12) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
canfix = false;
;
canreflect = true;
;
walled = false;
;
is_melee = true;
;
bubbles = 0;
;
maxBubbles = 13;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_wall;
;
on_projectile = fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_projectile;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2873
function fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2878
function fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_wall() {
if ((! walled)) {
{
walled = true;
;
friction = (0.4) * (timescale * timescale);
;
x -= hspeed;
;
y -= vspeed;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2887
function fr_Objects_Frontier_Projectiles_mod_gml_TideSlash_projectile() {
var _frl__team = team;
var _frl__dir = direction;
;
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((scrFROther(other)).bubbles < (scrFROther(other)).maxBubbles)) {
{
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = (_frl__dir + scrFRSourceRandomRange((- 35), 35));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
team = _frl__team;
;
}
}
if(__fr_break6) break;
}}
var __fr_other7=scrFROther(other);
__fr_other7.bubbles += 1;
;
}
}
scrFRSoundPitchVolume(sndPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleNullify);
;
}
}
if(__fr_break10) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:2908
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubble);
;
spr_active = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleActive;
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
image_index = scrFRSourceIRandom(3);
;
trailColor = make_color_rgb(42, 111, 92);
;
bubble_tiltspeed = scrFRSourceRandomRange(0.18, 0.26);
;
bubble_tiltrange = scrFRSourceRandomRange(35, 55);
;
fr_bloom = [1.4, 0.1];
;
mask_index = mskBullet1;
;
speed = (3) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
maxspeed = (12) * timescale;
;
typ = 2;
;
damage = 4;
;
ammo_type = (- 1);
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TIDE BUBBLE"];
;
active = false;
;
activeTimer = (25 + scrFRSourceIRandom(20));
;
deactiveTimer = 10;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:2947
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_step() {
if ((activeTimer > 0)) {
{
activeTimer -= scrFRSourceScale();
;
if ((activeTimer <= 0)) {
{
active = true;
;
speed = ((8 + scrFRSourceRandom(2))) * timescale;
;
friction = ((- 0.1)) * (timescale * timescale);
;
sprite_index = scrFRAreaSourceSprite(spr_active);
;
if (scrFRInstanceExists(enemy)) {
{
var _frl__target = instance_nearest(x, y, enemy);
;
direction = point_direction(x, y, (_frl__target.x + scrFRSourceRandomRange((- 65), 65)), (_frl__target.y + scrFRSourceRandomRange((- 65), 65)));
;
}
}
repeat ((1 + scrFRSourceIRandom(1))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleSpray);
;
image_index = scrFRSourceIRandom(1);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 40), 40));
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
if ((active == true)) {
{
deactiveTimer -= scrFRSourceScale();
;
if ((deactiveTimer > 0)) {
{
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if (scrFRInstanceExists(enemy)) {
{
var _frl__target = instance_nearest(x, y, enemy);
;
direction -= (angle_difference(direction, point_direction(x, y, (_frl__target.x + scrFRSourceRandomRange((- 35), 35)), (_frl__target.y + scrFRSourceRandomRange((- 35), 35)))) * power(0.2, 1));
;
}
}
}
}
}
} else {
{
direction += scrFRSourceRandomRange((- 5), 5);
;
}
}
image_angle = direction;
;
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(6) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleTrail);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other8=scrFROther(other);
direction = ((__fr_other8.direction + 180) + scrFRSourceRandomRange((- 25), 25));
;
}
}
if(__fr_break7) break;
}}
}
}
}
}
}
} else {
{
image_angle = (0 + (sin((scrFRSourceFrame() * bubble_tiltspeed)) * bubble_tiltrange));
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3003
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_endstep_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:3005
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:3005
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:3017
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Projectiles.mod.gml:3015
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Projectiles.mod.gml:3014
{
image_alpha -= 0.1;
;
}
_fr.pc=5;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:3013
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Objects/Frontier_Projectiles.mod.gml:3012
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Objects/Frontier_Projectiles.mod.gml:3006
{
var __fr_other1=scrFROther(other);
depth = (__fr_other1.depth + 1);
;
var __fr_other2=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other2.xprevious, __fr_other2.yprevious);
image_yscale *= 3;
;
image_speed *= 3;
;
var __fr_other3=scrFROther(other);
image_angle = point_direction(x, y, __fr_other3.xprevious, __fr_other3.yprevious);
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.trailColor;
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Projectiles.mod.gml:3005
scrFRTaskWithEnter(_fr,scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)),8,0);
break;
case 10: // Objects/Frontier_Projectiles.mod.gml:3004
_fr.pc = ((active == true)) ? 9 : 0;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:3022
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_wall() {
if ((active == true)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
move_bounce_solid(true);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3030
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_hit() {
if ((active == true)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3036
function fr_Objects_Frontier_Projectiles_mod_gml_TideBubble_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
damage = 3;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprTideBubbleExplosion);
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
fr_augmentBoilingVeins = false;
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Projectiles_mod_gml_sound_play_hit_ext(sndOasisExplosionSmall, (0.9 + scrFRSourceRandom(0.3)), 0.8);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3049
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkRocket);
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
var _frl__color = scrFRSourceRandom(255);
;
sparkColor = make_color_hsv(_frl__color, 200, 255);
;
fireworkColor = make_color_hsv(_frl__color, scrFRSourceRandomRange(210, 255), 255);
;
var _frl__color2 = scrFRSourceRandom(255);
;
sparkColor2 = make_color_hsv(_frl__color2, 200, 255);
;
fireworkColor2 = make_color_hsv(_frl__color2, scrFRSourceRandomRange(210, 255), 255);
;
fr_bloom = [1.4, 0.1];
;
fr_glow = [24, 32];
;
mask_index = mskBullet1;
;
speed = (15) * timescale;
;
friction = (0.3) * (timescale * timescale);
;
damage = 7;
;
ammo_type = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "FIREWORK ROCKET"];
;
lifeTime = 20;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_step;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3084
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_step() {
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
lifeTime -= scrFRSourceScale();
;
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSparkle);
;
var __fr_other4=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other4.fireworkColor, __fr_other4.fireworkColor, __fr_other4.fireworkColor2);
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
var __fr_other6=scrFROther(other);
speed = (((__fr_other6.speed / timescale) / 3)) * timescale;
;
image_xscale = (0.6 + scrFRSourceRandom(0.4));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprWhiteSmoke);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
speed = (4) * timescale;
;
var __fr_other10=scrFROther(other);
direction = ((__fr_other10.direction + 180) + scrFRSourceRandomRange((- 30), 30));
;
}
}
if(__fr_break9) break;
}}
}
}
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleTrail2);
;
image_xscale = scrFRSourceRandomRange(0.3, 0.6);
image_yscale = image_xscale;
;
image_speed = (scrFRSourceRandomRange(0.4, 0.8)) * timescale;
speed = (0.3) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break13) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3121
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_wall() {
move_bounce_solid(true);
;
image_angle = direction;
;
speed *= 0.7;
}

// Original Objects/Frontier_Projectiles.mod.gml:3126
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_destroy() {
fr_Objects_Frontier_Projectiles_mod_gml_FireworkExplosion_spawn(x, y, fireworkColor, sparkColor, 2, team, creator, true);
;
fr_Objects_Frontier_Projectiles_mod_gml_FireworkExtraBursts_create(x, y, fireworkColor2, sparkColor2, 5, 2, [0.1, 0.2], [7, 12], 0.8, team, creator);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3130
function fr_Objects_Frontier_Projectiles_mod_gml_GoldFireworkRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGoldFireworkRocket);
;
var _frl__type = scrFRSourceChoose("gold", "color");
;
if ((_frl__type == "gold")) {
{
sparkColor = make_color_rgb(203, 180, 105);
;
fireworkColor = make_color_rgb(203, 167, 58);
;
}
} else {
{
var _frl__color = scrFRSourceRandomRange(100, 140);
;
sparkColor = make_color_hsv(_frl__color, 200, 255);
;
fireworkColor = make_color_hsv(_frl__color, scrFRSourceRandomRange(210, 255), 255);
;
}
}
var _frl__type = scrFRSourceChoose("gold", "color", "color");
;
if ((_frl__type == "gold")) {
{
sparkColor2 = make_color_rgb(203, 180, 105);
;
fireworkColor2 = make_color_rgb(203, 167, 58);
;
}
} else {
{
var _frl__color = scrFRSourceRandomRange(100, 140);
;
sparkColor2 = make_color_hsv(_frl__color, 200, 255);
;
fireworkColor2 = make_color_hsv(_frl__color, scrFRSourceRandomRange(210, 255), 255);
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

// Original Objects/Frontier_Projectiles.mod.gml:3159
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandle);
;
spr_base = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleBase;
;
image_speed = (0.4) * timescale;
;
image_angle = direction;
;
var _frl__color = scrFRSourceRandom(255);
;
sparkColor = make_color_hsv(_frl__color, 200, 255);
;
fireworkColor = make_color_hsv(_frl__color, scrFRSourceRandomRange(215, 255), 255);
;
image_blend = fireworkColor;
;
fr_bloom = [2, 0.2];
;
fr_glow = [32, 48];
;
mask_index = mskBullet1;
;
speed = (14) * timescale;
;
damage = 12;
;
ammo_type = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "FIREWORK CANDLE"];
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_endstep;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_destroy;
;
on_draw = fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3198
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprWhiteSmoke);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
speed = (4) * timescale;
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 30), 30));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(7) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleTrail);
;
speed = (3) * timescale;
;
var __fr_other8=scrFROther(other);
direction = ((__fr_other8.direction + 180) + scrFRSourceRandomRange((- 30), 30));
;
}
}
if(__fr_break7) break;
}}
}
}
if ((scrFRSourceRandom(6) < 1)) {
{
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkCandleTrail2);
;
image_xscale = scrFRSourceRandomRange(0.3, 0.6);
image_yscale = image_xscale;
;
image_speed = (scrFRSourceRandomRange(0.4, 0.8)) * timescale;
speed = (0.3) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break11) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3228
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_endstep() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
var __fr_other5=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other5.xprevious, __fr_other5.yprevious);
image_yscale *= 3;
;
image_speed *= 6;
;
var __fr_other6=scrFROther(other);
image_angle = point_direction(x, y, __fr_other6.xprevious, __fr_other6.yprevious);
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.fireworkColor;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3239
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_destroy() {
fr_Objects_Frontier_Projectiles_mod_gml_FireworkExplosion_spawn(x, y, fireworkColor, sparkColor, scrFRSourceRandomRange(0.4, 0.6), team, creator, false);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3242
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkCandle_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, 1);
;
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(spr_base, (scrFRSourceFrame() * .4), x, y, 1, 1, image_angle, c_white, image_alpha);
;
gpu_set_blendmode(bm_normal);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3248
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSparkMiddle);
;
image_speed = (0.4) * timescale;
;
fireworkColor = c_red;
;
fr_bloom = [1.4, 0.1];
;
depth = (- 2);
;
fr_glow = [48, 64];
;
mask_index = mskBullet1;
;
speed = ((6 + scrFRSourceRandom(7))) * timescale;
;
friction = ((0.4 + scrFRSourceRandom(0.2))) * (timescale * timescale);
;
damage = 4;
;
ammo_type = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TIDE BUBBLE"];
;
dirAngle = (scrFRSourceRandom(4) * scrFRSourceChoose(1, (- 1)));
;
hitlist = [];
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_step;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_FireworkRocket_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3282
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_step() {
if (((speed / timescale) <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
direction += dirAngle;
;
if ((scrFRSourceRandom(7) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkTrail);
;
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.fireworkColor;
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth - 1);
;
var __fr_other6=scrFROther(other);
direction = ((__fr_other6.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
var __fr_other7=scrFROther(other);
speed = (((__fr_other7.speed / timescale) / 4)) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
var __fr_other11=scrFROther(other);
image_blend = __fr_other11.fireworkColor;
;
var __fr_other12=scrFROther(other);
team = __fr_other12.team;
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break10) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3310
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_endstep_resume, id, scrFROther(other), _args, 9, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:3311
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:3311
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:3323
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Projectiles.mod.gml:3321
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Projectiles.mod.gml:3320
{
image_alpha -= (0.06 * scrFRSourceScale());
;
}
_fr.pc=5;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:3319
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Objects/Frontier_Projectiles.mod.gml:3318
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Objects/Frontier_Projectiles.mod.gml:3312
{
var __fr_other1=scrFROther(other);
depth = (__fr_other1.depth + 1);
;
var __fr_other2=scrFROther(other);
image_xscale = point_distance(x, y, __fr_other2.xprevious, __fr_other2.yprevious);
image_yscale *= 3;
;
image_speed *= 2;
;
var __fr_other3=scrFROther(other);
image_angle = point_direction(x, y, __fr_other3.xprevious, __fr_other3.yprevious);
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.fireworkColor;
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Projectiles.mod.gml:3311
scrFRTaskWithEnter(_fr,scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(x, y)),8,0);
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:3327
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
;
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage);
;
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
var __fr_other6=scrFROther(other);
image_blend = __fr_other6.fireworkColor;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break5) break;
}}
speed *= 0.5;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3340
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.fireworkColor;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3348
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkExplosion_spawn(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__sparkColor=undefined, _frl__size=undefined, _frl__team=undefined, _frl__creator=undefined, _frl__sparkI=undefined) {
if ((_frl__size >= 1)) {
{
scrFRSoundPitchVolume(sndExplosion, (0.5 + scrFRSourceRandom(0.2)), 1.5);
;
scrFRSoundPitchVolume(sndExplosionS, (0.5 + scrFRSourceRandom(0.2)), 1.5);
;
scrFRViewShakeAt(_frl__x, _frl__y, 40);
;
repeat (_frl__size) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Explosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkExplosion);
;
image_blend = _frl__color;
;
hitid = [sprExplosion, "FIREWORK EXPLOSION"];
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, SmallExplosion)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSmallExplosion);
;
image_blend = _frl__color;
;
hitid = [sprExplosion, "FIREWORK EXPLOSION"];
;
}
}
if(__fr_break6) break;
}}
}
var _frl__offset = scrFRSourceRandom(360);
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += 30) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Flame)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
image_blend = _frl__color;
;
direction = (_frl_i + _frl__offset);
;
speed = (3) * timescale;
;
var __fr_other10=scrFROther(other);
team = __fr_other10.team;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11.creator;
;
hitid = [sprFlameBall, "FIREWORK EXPLOSION"];
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
}
} else {
{
scrFRSoundPitchVolume(sndExplosionS, (0.5 + scrFRSourceRandom(0.3)), 1.4);
;
scrFRViewShakeAt(_frl__x, _frl__y, 12);
;
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, SmallExplosion)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkSmallExplosion);
;
image_blend = _frl__color;
;
hitid = [sprExplosion, "FIREWORK EXPLOSION"];
;
}
}
if(__fr_break14) break;
}}
var _frl__offset = scrFRSourceRandom(360);
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += 60) {
{ var __fr_with15 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Flame)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
image_blend = _frl__color;
;
direction = (_frl_i + _frl__offset);
;
speed = (2.5) * timescale;
;
var __fr_other18=scrFROther(other);
team = __fr_other18.team;
;
var __fr_other19=scrFROther(other);
creator = __fr_other19.creator;
;
hitid = [sprFlameBall, "FIREWORK EXPLOSION"];
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break17) break;
}}
}
}
}
}
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += (30 / _frl__size)) {
{ var __fr_with20 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_FireworkSpark_create(_frl__x, _frl__y)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
fireworkColor = _frl__color;
;
image_blend = _frl__sparkColor;
;
direction = ((_frl__sparkI == true) ? (_frl_i + scrFRSourceRandomRange((- 20), 20)) : scrFRSourceRandom(360));
;
image_angle = direction;
;
var __fr_other23=scrFROther(other);
team = __fr_other23.team;
;
var __fr_other24=scrFROther(other);
creator = __fr_other24.creator;
;
hitid = [sprFlameBall, "FIREWORK EXPLOSION"];
;
}
}
if(__fr_break22) break;
}}
}
}
repeat ((3 * _frl__size)) {
{ var __fr_with25 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Flame)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprFireworkFlame);
;
image_blend = _frl__color;
;
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom((_frl__size / 3)))) * timescale;
var __fr_other28=scrFROther(other);
team = __fr_other28.team;
;
var __fr_other29=scrFROther(other);
creator = __fr_other29.creator;
;
hitid = [sprFlameBall, "FIREWORK EXPLOSION"];
;
image_speed = (0.4) * timescale;
;
}
}
if(__fr_break27) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3438
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkExtraBursts_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__sparkcolor=undefined, _frl__bursts=undefined, _frl__burstTime=undefined, _frl__sizeRange=undefined, _frl__speedRange=undefined, _frl__friction=undefined, _frl__team=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
bursts = _frl__bursts;
;
burstTime = _frl__burstTime;
;
maxBurstTime = _frl__burstTime;
;
minSpeed = scrFRIndexGet(_frl__speedRange, 0);
;
maxSpeed = scrFRIndexGet(_frl__speedRange, 1);
;
bulFric = _frl__friction;
;
minSize = scrFRIndexGet(_frl__sizeRange, 0);
;
maxSize = scrFRIndexGet(_frl__sizeRange, 1);
;
team = _frl__team;
;
creator = _frl__creator;
;
color = _frl__color;
;
sparkcolor = _frl__sparkcolor;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkExtraBursts_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3460
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkExtraBursts_step() {
if ((bursts > 0)) {
{
burstTime -= scrFRSourceScale();
;
if ((burstTime <= 0)) {
{
burstTime = maxBurstTime;
;
bursts -= 1;
;
fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_create(x, y, color, sparkcolor, [minSize, maxSize], [minSpeed, maxSpeed], bulFric, team, creator);
}
}
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3474
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__sparkcolor=undefined, _frl__sizeRange=undefined, _frl__speedRange=undefined, _frl__friction=undefined, _frl__team=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = mskBullet1;
;
color = _frl__color;
;
sparkcolor = _frl__sparkcolor;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandomRange(scrFRIndexGet(_frl__speedRange, 0), scrFRIndexGet(_frl__speedRange, 1))) * timescale;
;
friction = (_frl__friction) * (timescale * timescale);
lifeTime = 20;
;
minSize = scrFRIndexGet(_frl__sizeRange, 0);
;
maxSize = scrFRIndexGet(_frl__sizeRange, 1);
;
team = _frl__team;
;
creator = _frl__creator;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_step;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3496
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_step() {
if ((((speed / timescale) <= 0) || (lifeTime <= 0))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
lifeTime -= scrFRSourceScale();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3504
function fr_Objects_Frontier_Projectiles_mod_gml_FireworkBurstBullet_destroy() {
fr_Objects_Frontier_Projectiles_mod_gml_FireworkExplosion_spawn(x, y, color, sparkcolor, scrFRSourceRandomRange(minSize, maxSize), team, creator, false);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3507
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_create(_frl__x=undefined, _frl__y=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShell);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShellDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderShellDisappear;
;
fr_bloom = [2, 0.1];
;
fr_glow = [16, 24];
;
trailColor = c_yellow;
;
speed = (16) * timescale;
;
friction = (0.6) * (timescale * timescale);
;
typ = 1;
;
damage = 1;
;
knockback_speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "GUNPOWDER SHELL"];
;
bonus = true;
;
bonus_damage = 2;
;
minspeed = 8;
;
maxspeed = (16) * timescale;
;
wallbounce = (2 * scrFRGetSkill(mut_shotgun_shoulders));
;
ammo_type = 2;
;
is_shell = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_anim;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_step;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_destroy;
;
on_alrm2 = ["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3549
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_anim() {
if ((sprite_index != spr_fade)) {
{
image_speed = (0) * timescale;
;
image_index = (image_number - 1);
;
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3560
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_step() {
if (frMacro_Objects_Frontier_Projectiles_mod_gml_alarm2_run) {
exit;
}
if (frMacro_Objects_Frontier_Projectiles_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(16) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 2), 2)), (y + scrFRSourceRandomRange((- 2), 2)), FireFly)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGunpowderFireFly);
;
var __fr_other4=scrFROther(other);
image_angle = ((__fr_other4.direction + 90) + scrFRSourceRandomRange((- 20), 20));
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((((speed / timescale) < minspeed) && (sprite_index != spr_fade))) {
{
sprite_index = scrFRAreaSourceSprite(spr_fade);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3581
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_wall() {
scrFRInstanceCreate(x, y, Smoke);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
if (((wallbounce > 0) && (! bonus))) {
{
bonus = true;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 2, "=");
;
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (min((((speed / timescale) * 0.9) + wallbounce), (maxspeed / timescale))) * timescale;
;
wallbounce *= 0.95;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3599
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_alrm2() {
bonus = false;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3602
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, (damage + (bonus_damage * bonus)), (knockback_speed / timescale));
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3608
function fr_Objects_Frontier_Projectiles_mod_gml_GunpowderShell_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
hitid = [sprite_index, "GUNPOWDER SHELL#EXPLOSION"];
damage *= 0.8;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndExplosionS, (1.1 + scrFRSourceRandom(0.4)), 0.7);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3615
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_coralBolt";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralBolt);
;
image_angle = direction;
;
coralColor = scrFRSourceChoose(make_color_rgb(101, 84, 182), make_color_rgb(101, 84, 182), make_color_rgb(101, 84, 182), make_color_rgb(101, 84, 182), make_color_rgb(253, 129, 148), make_color_rgb(251, 45, 76), make_color_rgb(255, 127, 80), make_color_rgb(255, 148, 110), make_color_rgb(213, 135, 255));
image_blend = coralColor;
;
mask_index = mskBolt;
;
speed = (22) * timescale;
;
damage = 12;
;
ammo_type = 3;
;
is_bolt = true;
;
home_inst = noone;
;
home_dir = 0;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "CORAL BOLT"];
;
typ = 2;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_anim;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3658
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_anim() {
image_index = (image_number - 1);
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3662
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Projectiles.mod.gml:3729
scrFRTaskWithNext(_fr);
break;
case 2: // Objects/Frontier_Projectiles.mod.gml:3729
scrFRTaskWithAbort(_fr);
break;
case 3: // Objects/Frontier_Projectiles.mod.gml:3739
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Projectiles.mod.gml:3737
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Projectiles.mod.gml:3736
{
image_blend = merge_color(image_blend, coralColor, (0.18 * scrFRSourceScale()));
;
}
_fr.pc=5;
break;
case 4: // Objects/Frontier_Projectiles.mod.gml:3735
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Objects/Frontier_Projectiles.mod.gml:3734
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Objects/Frontier_Projectiles.mod.gml:3730
{
image_xscale = point_distance(_fr.vars._x1, _fr.vars._y1, _fr.vars._x2, _fr.vars._y2);
;
image_yscale = 1.2;
;
image_angle = point_direction(_fr.vars._x1, _fr.vars._y1, _fr.vars._x2, _fr.vars._y2);
;
var __fr_other1=scrFROther(other);
coralColor = __fr_other1.coralColor;
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Projectiles.mod.gml:3729
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRInstanceCreate(x, y, BoltTrail)),8,0);
break;
case 10: // Objects/Frontier_Projectiles.mod.gml:3665
{
if ((home_inst != noone)) {
{
if ((scrFRInstanceExists(home_inst) && scrFRProjectileCanHitMelee(home_inst))) {
{
if (((abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90) && (! scrFRPlaceMeeting((x + lengthdir_x((speed / timescale), home_dir)), (y + lengthdir_y((speed / timescale), home_dir)), home_inst)))) {
{
_fr.vars._tx = (home_inst.x - lengthdir_x((speed / timescale), home_dir));
_fr.vars._ty = (home_inst.y - lengthdir_y((speed / timescale), home_dir));
_fr.vars._diff = ((angle_difference(point_direction(x, y, _fr.vars._tx, _fr.vars._ty), direction) * 0.5) * scrFRSourceScale());
;
direction += _fr.vars._diff;
;
image_angle += _fr.vars._diff;
;
}
} else {
{
home_inst = noone;
;
direction = home_dir;
;
image_angle = direction;
;
}
}
}
} else {
if ((direction != home_dir)) {
{
_fr.vars._diff = angle_difference(home_dir, direction);
;
if ((abs(_fr.vars._diff) > 10)) {
_fr.vars._diff = ((_fr.vars._diff * 0.5) * scrFRSourceScale());
}
direction += _fr.vars._diff;
;
image_angle += _fr.vars._diff;
;
}
} else {
home_inst = noone;
}
}
;
}
} else {
{
home_dir = direction;
;
_fr.vars._disMax = (24 * scrFRGetSkill(mut_bolt_marrow));
;
if ((_fr.vars._disMax > 0)) {
{
_fr.vars._nearest = noone;
;
{ var __fr_with2 = scrFRWithValues(scrFRMatchingNE(hitme, "team", team, 0)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{
_fr.vars._dis = distance_to_point(((scrFROther(other)).x + ((scrFROther(other)).hspeed / timescale)), ((scrFROther(other)).y + ((scrFROther(other)).vspeed / timescale)));
;
if ((_fr.vars._dis < _fr.vars._disMax)) {
{
if (scrFRPlaceMeeting((scrFROther(other)).x, (scrFROther(other)).y, (scrFROther(other)))) {
{
_fr.vars._disMax = _fr.vars._dis;
;
_fr.vars._nearest = scrFRSelf(self);
;
}
}
}
}
}
}
}
}
if(__fr_break4) break;
}}
home_inst = _fr.vars._nearest;
;
}
}
}
}
_fr.vars._x1 = x;
_fr.vars._y1 = y;
_fr.vars._x2 = xprevious;
_fr.vars._y2 = yprevious;
;
}
_fr.pc=9;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Projectiles.mod.gml:3743
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_hit() {
if (((scrFROther(other)).hp > damage)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_create(x, y, (scrFROther(other)), direction, team)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
coralColor = __fr_other5.coralColor;
;
image_blend = coralColor;
;
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other9=scrFROther(other);
image_blend = __fr_other9.image_blend;
;
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth + 1);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break8) break;
}}
}
}
if(__fr_break4) break;
}}
scrFRSoundPitchVolume(sndPillarBreak, (1 + scrFRSourceRandom(0.4)), 0.7);
;
scrFRInstanceDestroy();
;
exit;
;
}
}
var __fr_other11=scrFROther(other);
scrFRProjectileHit(__fr_other11, damage, (knockback_speed / timescale));
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3773
function fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_wall() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_create(x, y, (scrFROther(other)), direction, team)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
coralColor = __fr_other4.coralColor;
;
image_blend = coralColor;
;
walled = true;
;
move_contact_solid(direction, 16);
;
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.image_blend;
;
var __fr_other9=scrFROther(other);
depth = (__fr_other9.depth + 1);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break7) break;
}}
scrFRSoundPitchVolume(sndPillarBreak, (1 + scrFRSourceRandom(0.4)), 0.7);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3793
function fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_create(_frl__x=undefined, _frl__y=undefined, _frl__host=undefined, _frl__dir=undefined, _frl__team=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_coralGrowth";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralClusterBig);
;
image_angle = scrFRSourceRandom(360);
;
image_xscale = 0.2;
;
image_yscale = image_xscale;
;
depth = (- 1);
;
speed = (0) * timescale;
;
direction = _frl__dir;
;
damage = 0;
;
ammo_type = (- 1);
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 2335;
;
trueTeam = _frl__team;
;
hitid = [sprite_index, "CORAL GROWTH"];
;
wallOffset = (- 8);
;
host = _frl__host;
;
walled = false;
;
if (scrFRVariableExists(_frl__host, "my_health")) {
{
hostHealth = _frl__host.hp;
;
}
}
grown = false;
;
canreflect = false;
;
deathTime = (- 1);
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_endstep;
;
on_projectile = fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_projectile;
;
on_grenade = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_nothing;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3833
function fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_endstep() {
if ((! scrFRInstanceExists(host))) {
{
if ((walled == true)) {
{
grown = true;
;
}
}
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((grown == false)) {
{
if ((image_xscale >= 1)) {
{
grown = true;
;
}
} else {
{
image_xscale += (0.1 * scrFRSourceScale());
;
image_yscale = image_xscale;
;
}
}
}
}
if ((walled == false)) {
{
x = (host.x + lengthdir_x(wallOffset, direction));
;
y = (host.y + lengthdir_y(wallOffset, direction));
;
if ((grown == true)) {
{
if (((!scrFRVariableExists(host, "my_health")) || (host.hp < hostHealth))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
hostHealth = host.hp;
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3868
function fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_projectile() {
if ((grown == true)) {
{
if ((scrFRVariableExists((scrFROther(other)), "typ") && ((scrFROther(other)).typ != (- 1)))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3875
function fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_destroy() {
if ((grown == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
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
repeat (5) {
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.trueTeam;
;
}
}
if(__fr_break6) break;
}}
}
repeat (12) {
{ var __fr_with8 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(x, y)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
var __fr_other11=scrFROther(other);
team = __fr_other11.trueTeam;
;
var __fr_other12=scrFROther(other);
coralColor = __fr_other12.coralColor;
;
image_blend = coralColor;
;
}
}
if(__fr_break10) break;
}}
}
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other16=scrFROther(other);
image_blend = __fr_other16.image_blend;
;
var __fr_other17=scrFROther(other);
depth = (__fr_other17.depth + 1);
;
}
}
if(__fr_break15) break;
}}
scrFRSoundPitchVolume(sndWallBreakJungle, (2 + scrFRSourceRandom(0.4)), 0.55);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3908
function fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_coralShard";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralShard);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralShardHit;
;
image_angle = direction;
;
image_speed = (0) * timescale;
;
image_index = scrFRSourceIRandom(image_number);
;
mask_index = mskBolt;
;
speed = ((8 + scrFRSourceRandom(6))) * timescale;
;
mySpeed = (speed / timescale);
;
friction = ((0.8 + scrFRSourceRandom(0.2))) * (timescale * timescale);
;
damage = 2;
;
ammo_type = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "CORAL SHARD"];
;
hitlist = [];
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_wall;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3940
function fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_endstep() {
image_xscale = ((speed / timescale) / (mySpeed / 3));
;
if (((speed / timescale) <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3947
function fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
;
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:3953
function fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_wall() {
move_bounce_solid(true);
;
image_angle = direction;
;
}

// Original Objects/Frontier_Projectiles.mod.gml:3957
function fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.image_blend;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3963
function fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralPowerShard);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralPowerShardHit;
;
image_blend = c_white;
;
trailColor = make_color_rgb(220, 156, 82);
;
fr_bloom = [2, 0.1];
;
damage = 4;
;
speed = ((7 + scrFRSourceRandom(5))) * timescale;
;
friction = (1.4) * (timescale * timescale);
;
home_inst = noone;
;
home_dir = 0;
;
turnspeed = (4 * scrFRSourceChoose(1, (- 1)));
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_endstep;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:3985
function fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_endstep() {
direction += turnspeed;
;
image_angle = direction;
;
if ((home_inst != noone)) {
{
if ((scrFRInstanceExists(home_inst) && scrFRProjectileCanHitMelee(home_inst))) {
{
if (((abs(angle_difference(point_direction(x, y, home_inst.x, home_inst.y), home_dir)) < 90) && (! scrFRPlaceMeeting((x + lengthdir_x((speed / timescale), home_dir)), (y + lengthdir_y((speed / timescale), home_dir)), home_inst)))) {
{
var _frl__tx = (home_inst.x - lengthdir_x((speed / timescale), home_dir));
var _frl__ty = (home_inst.y - lengthdir_y((speed / timescale), home_dir));
var _frl__diff = ((angle_difference(point_direction(x, y, _frl__tx, _frl__ty), direction) * 0.5) * scrFRSourceScale());
;
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
{
home_inst = noone;
;
direction = home_dir;
;
image_angle = direction;
;
}
}
}
} else {
if ((direction != home_dir)) {
{
var _frl__diff = angle_difference(home_dir, direction);
;
if ((abs(_frl__diff) > 10)) {
_frl__diff = ((_frl__diff * 0.5) * scrFRSourceScale());
}
direction += _frl__diff;
;
image_angle += _frl__diff;
;
}
} else {
home_inst = noone;
}
}
;
}
} else {
{
home_dir = direction;
;
var _frl__disMax = (24 * scrFRGetSkill(mut_bolt_marrow));
;
if ((_frl__disMax > 0)) {
{
var _frl__nearest = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(hitme, "team", team, 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), prop))) {
{
var _frl__dis = distance_to_point(((scrFROther(other)).x + ((scrFROther(other)).hspeed / timescale)), ((scrFROther(other)).y + ((scrFROther(other)).vspeed / timescale)));
;
if ((_frl__dis < _frl__disMax)) {
{
if (scrFRPlaceMeeting((scrFROther(other)).x, (scrFROther(other)).y, (scrFROther(other)))) {
{
_frl__disMax = _frl__dis;
;
_frl__nearest = scrFRSelf(self);
;
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
home_inst = _frl__nearest;
;
}
}
}
}
image_xscale = ((speed / timescale) / (mySpeed / 3));
;
var _frl__x1 = x;
var _frl__y1 = y;
var _frl__x2 = xprevious;
var _frl__y2 = yprevious;
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BoltTrail)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.trailColor;
;
image_xscale = point_distance(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
image_yscale = 2;
;
image_angle = point_direction(_frl__x1, _frl__y1, _frl__x2, _frl__y2);
;
}
}
if(__fr_break6) break;
}}
if (((speed / timescale) <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4068
function fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4073
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralBolt_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_toxicCoralBolt";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralBolt);
;
image_angle = direction;
;
coralColor = scrFRSourceChoose(make_color_rgb(165, 180, 105), make_color_rgb(116, 150, 88), make_color_rgb(90, 130, 70));
image_blend = coralColor;
;
mask_index = mskBolt;
;
speed = (22) * timescale;
;
damage = 12;
;
ammo_type = 3;
;
is_bolt = true;
;
home_inst = noone;
;
home_dir = 0;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TOXICORAL BOLT"];
;
typ = 2;
;
on_anim = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_anim;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralBolt_endstep;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralBolt_hit;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralBolt_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4108
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralBolt_hit() {
if (((scrFROther(other)).hp > damage)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale));
;
{ var __fr_with2 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralGrowth_create(x, y, (scrFROther(other)), direction, team)), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
coralColor = __fr_other5.coralColor;
;
image_blend = coralColor;
;
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other9=scrFROther(other);
image_blend = __fr_other9.image_blend;
;
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth + 1);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break8) break;
}}
}
}
if(__fr_break4) break;
}}
scrFRSoundPitchVolume(sndPillarBreak, (1 + scrFRSourceRandom(0.4)), 0.7);
;
scrFRInstanceDestroy();
;
exit;
;
}
}
var __fr_other11=scrFROther(other);
scrFRProjectileHit(__fr_other11, damage, (knockback_speed / timescale));
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4138
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralBolt_wall() {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralGrowth_create(x, y, (scrFROther(other)), direction, team)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
coralColor = __fr_other4.coralColor;
;
image_blend = coralColor;
;
walled = true;
;
move_contact_solid(direction, 16);
;
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.image_blend;
;
var __fr_other9=scrFROther(other);
depth = (__fr_other9.depth + 1);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break7) break;
}}
scrFRSoundPitchVolume(sndPillarBreak, (1 + scrFRSourceRandom(0.4)), 0.7);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4158
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralGrowth_create(_frl__x=undefined, _frl__y=undefined, _frl__host=undefined, _frl__dir=undefined, _frl__team=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralGrowth_create(_frl__x, _frl__y, _frl__host, _frl__dir, _frl__team)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_coralGrowth";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralCluster);
;
direction = _frl__dir;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
trueTeam = _frl__team;
;
hitid = [sprite_index, "TOXICORAL GROWTH"];
;
host = _frl__host;
;
if (scrFRVariableExists(_frl__host, "my_health")) {
{
hostHealth = _frl__host.hp;
;
}
}
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralGrowth_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4180
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralGrowth_destroy() {
if ((grown == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
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
repeat (8) {
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralPowerShard_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.trueTeam;
;
}
}
if(__fr_break6) break;
}}
}
repeat (7) {
{ var __fr_with8 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(x, y)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
var __fr_other11=scrFROther(other);
team = __fr_other11.trueTeam;
;
var __fr_other12=scrFROther(other);
coralColor = __fr_other12.coralColor;
;
image_blend = coralColor;
;
}
}
if(__fr_break10) break;
}}
}
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprCoralGrowthHit);
;
var __fr_other16=scrFROther(other);
image_blend = __fr_other16.image_blend;
;
var __fr_other17=scrFROther(other);
depth = (__fr_other17.depth + 1);
;
}
}
if(__fr_break15) break;
}}
repeat (5) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate(x, y, ToxicGas)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
speed = ((0.5 + scrFRSourceRandom(0.5))) * timescale;
;
direction = scrFRSourceRandom(360);
;
friction = (0.05) * (timescale * timescale);
;
}
}
if(__fr_break20) break;
}}
}
scrFRSoundPitchVolume(sndWallBreakJungle, (2 + scrFRSourceRandom(0.4)), 0.4);
;
scrFRSoundPitchVolume(sndToxicBoltGas, (0.6 + scrFRSourceRandom(0.3)), 0.8);
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4222
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralPowerShard_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralPowerShard);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprToxicCoralPowerShardHit;
;
image_blend = c_white;
;
trailColor = make_color_rgb(207, 204, 84);
;
fr_bloom = [2, 0.1];
;
damage = 3;
;
speed = ((7 + scrFRSourceRandom(5))) * timescale;
;
friction = (1.4) * (timescale * timescale);
;
home_inst = noone;
;
home_dir = 0;
;
turnspeed = (4 * scrFRSourceChoose(1, (- 1)));
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_CoralPowerShard_endstep;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralPowerShard_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4244
function fr_Objects_Frontier_Projectiles_mod_gml_ToxicCoralPowerShard_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
repeat (3) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, ToxicGas)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
direction = scrFRSourceRandom(360);
;
friction = (0.05) * (timescale * timescale);
;
growspeed /= 8;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4257
function fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_Pufferbomb";
;
sprite_index = scrFRAreaSourceSprite(sprStickyGrenade);
;
spr_blink = sprFRBase_GrenadeBlink;
;
image_angle = scrFRSourceRandom(360);
;
depth = (- 3);
;
image_speed = (0.4) * timescale;
;
speed = (12) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
damage = 0;
;
ammo_type = 4;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
hitid = [sprite_index, "PUFFERBOMB"];
;
host = noone;
;
grown = false;
;
canreflect = false;
;
lifeTime = 40;
;
wallOffset = ((- 8) + scrFRSourceRandom(3));
;
wallHit = false;
;
on_end_step = fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_endstep;
;
on_wall = fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_wall;
;
on_hit = fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_hit;
;
on_destroy = fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4290
function fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_endstep() {
if ((host != noone)) {
{
if (scrFRInstanceExists(host)) {
{
x = (host.x + lengthdir_x(wallOffset, direction));
;
y = (host.y + lengthdir_y(wallOffset, direction));
;
}
} else {
{
host = noone;
;
}
}
}
}
if (scrFRPlaceMeeting(x, y, Explosion)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
lifeTime -= scrFRSourceScale();
;
if (((lifeTime < 10) && (sprite_index != spr_blink))) {
{
sprite_index = scrFRAreaSourceSprite(spr_blink);
;
}
}
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4321
function fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_hit() {
if ((host == noone)) {
{
var __fr_other1=scrFROther(other);
host = __fr_other1;
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4326
function fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_wall() {
if ((wallHit == false)) {
{
speed = (0) * timescale;
;
scrFRSoundPitch(sndGrenadeStickWall, (0.7 + scrFRSourceRandom(0.2)));
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4332
function fr_Objects_Frontier_Projectiles_mod_gml_Pufferbomb_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
}
}
if(__fr_break3) break;
}}
repeat (3) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, SmallExplosion)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
hitid = __fr_other8.hitid;
;
}
}
if(__fr_break7) break;
}}
}
repeat (12) {
{ var __fr_with9 = scrFRWithValues(fr_Objects_Frontier_Projectiles_mod_gml_CoralShard_create(x, y)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((12 + scrFRSourceRandom(4))) * timescale;
;
friction = ((1.2 + scrFRSourceRandom(0.3))) * (timescale * timescale);
;
image_yscale = 0.5;
;
var __fr_other12=scrFROther(other);
team = __fr_other12.team;
;
var __fr_other13=scrFROther(other);
creator = __fr_other13;
;
var __fr_other14=scrFROther(other);
hitid = __fr_other14.hitid;
;
}
}
if(__fr_break11) break;
}}
}
scrFRSoundPitch(sndExplosion, (0.7 + scrFRSourceRandom(0.2)));
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4361
function fr_Objects_Frontier_Projectiles_mod_gml_WeaponBurst_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "WeaponBurst";
;
accuracy = 1;
;
team = (- 1);
;
creator = noone;
;
ammo = 0;
;
time = 0;
;
time_max = 0;
;
burst = 0;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", wep_none);
;
spec = false;
;
on_step = ["mod", "Frontier_Projectiles", fr_Objects_Frontier_Projectiles_mod_gml_WeaponBurst_step];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4382
function fr_Objects_Frontier_Projectiles_mod_gml_WeaponBurst_step() {
if (((time > 0) && (ammo > 0))) {
{
time -= scrFRSourceScale();
;
if ((time <= 0)) {
{
time += time_max;
;
ammo -= 1;
;
burst++;
;
if (scrFRInstanceExists(creator)) {
{
x = creator.x;
;
y = creator.y;
;
if (scrFRVariableExists(creator, "gunangle")) {
{
direction = creator.gunangle;
;
}
}
if (scrFRInstanceIs(creator, Player)) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFROther(other)).spec) {
{
fr_Objects_Frontier_Projectiles_mod_gml_player_swap(scrFRSelf(self));
;
specfiring = true;
;
}
}
var _frl__accuracy = accuracy;
var _frl__team = team;
;
var __fr_other4=scrFROther(other);
accuracy = __fr_other4.accuracy;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
scrFRModCall("weapon", scrFRWeaponSlotRead(__fr_other6, "wep"), "weapon_fire");
;
accuracy = _frl__accuracy;
;
team = _frl__team;
;
if ((scrFROther(other)).spec) {
{
fr_Objects_Frontier_Projectiles_mod_gml_player_swap(scrFRSelf(self));
;
specfiring = false;
;
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
{
{ var __fr_with7 = scrFRWithValues(scrFRPlayerFireExt(direction, wep_none, x, y, team, creator, accuracy)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", scrFRWeaponSlotRead(__fr_other10, "wep"));
;
scrFRModCall("weapon", scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "weapon_fire");
;
{ var __fr_with11 = scrFRWithValues((scrFROther(other)).creator), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
if (((friction / (timescale * timescale)) != 0)) {
{
var __fr_other14=scrFROther(other);
hspeed += ((__fr_other14.hspeed / timescale)) * timescale;
;
var __fr_other15=scrFROther(other);
vspeed += ((__fr_other15.vspeed / timescale)) * timescale;
;
if (scrFRVariableExists(scrFRSelf(self), "wkick")) {
var __fr_other16=scrFROther(other);
wkick = __fr_other16.wkick;
}
if (scrFRVariableExists(scrFRSelf(self), "wepangle")) {
var __fr_other17=scrFROther(other);
wepangle = (__fr_other17.wepangle * ((abs(__fr_other17.wepangle) > 1) ? sign(wepangle) : wepangle));
}
if (scrFRVariableExists(scrFRSelf(self), "reload")) {
var __fr_other18=scrFROther(other);
reload += __fr_other18.reload;
}
}
}
}
}
if(__fr_break13) break;
}}
}
}
if(__fr_break9) break;
}}
}
}
}
}
}
}
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Projectiles.mod.gml:4454
function fr_Objects_Frontier_Projectiles_mod_gml_charge_weapon_fire_init() { return scrFRWeaponChargeInit((argument_count>0 ? argument[0] : undefined)); }

// Original Objects/Frontier_Projectiles.mod.gml:4557
function fr_Objects_Frontier_Projectiles_mod_gml_FireCharge_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_FireCharge";
;
accuracy = 1;
;
team = (- 1);
;
creator = noone;
;
primary = true;
;
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", wep_none);
;
fire = false;
;
on_step = fr_Objects_Frontier_Projectiles_mod_gml_FireCharge_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4578
function fr_Objects_Frontier_Projectiles_mod_gml_FireCharge_step() {
if (fire) {
{
if ((is_struct(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRVariableExists(scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "chrg"))) {
{
if (scrFRWeaponSlotRead(scrFRSelf(self), "wep").chrg) {
{
scrFRWeaponSlotRead(scrFRSelf(self), "wep").chrg = (- 1);
;
if ((scrFRInstanceExists(creator) && creator.visible)) {
{
x = creator.x;
;
y = creator.y;
;
if (scrFRSourceWeaponEqual(scrFRVariableGet(creator, (primary ? "wep" : "bwep"), scrFRWeaponSlotRead(scrFRSelf(self), "wep")), scrFRWeaponSlotRead(scrFRSelf(self), "wep"))) {
{
if (scrFRInstanceIs(creator, Player)) {
{
var _frl__team = team;
var _frl__accuracy = accuracy;
var _frl__primary = primary;
;
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! _frl__primary)) {
{
fr_Objects_Frontier_Projectiles_mod_gml_player_swap(scrFRSelf(self));
specfiring = true;
;
}
}
var _frl__type = scrFRWeaponType(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
var _frl__cost = scrFRWeaponCost(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
var _frl__rads = scrFRWeaponRads(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
var _frl__ammo = scrFRIndexGet(ammo, _frl__type);
;
if (((infammo != 0) || ((_frl__ammo >= _frl__cost) && (GameCont.rad >= _frl__rads)))) {
{
var _frl__lastTeam = team;
var _frl__lastAccuracy = accuracy;
;
team = _frl__team;
;
accuracy = _frl__accuracy;
;
var __fr_other4=scrFROther(other);
scrFRPlayerFire(__fr_other4.direction);
;
if ((team == _frl__team)) {
team = _frl__lastTeam;
}
if ((accuracy == _frl__accuracy)) {
accuracy = _frl__lastAccuracy;
} else {
if ((_frl__accuracy != 0)) {
{
accuracy = (_frl__lastAccuracy * (accuracy / _frl__accuracy));
;
}
}
}
}
} else {
{
wkick = (- 2);
;
clicked = false;
;
drawempty = 30;
;
if ((_frl__ammo < _frl__cost)) {
{
scrFRSoundPlay(sndEmpty);
;
frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.pickup_text, scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_name"), _frl__type), ((_frl__ammo > 0) ? "ins" : "out"));
;
}
} else {
{
scrFRSoundPlay(sndUltraEmpty);
;
frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.pickup_text, "RADS", "ins");
;
}
}
}
}
if ((! _frl__primary)) {
{
specfiring = false;
;
frMacro_Objects_Frontier_Projectiles_mod_gml_call(frMacro_Objects_Frontier_Projectiles_mod_gml_scr.player_swap, scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
fr_Objects_Frontier_Projectiles_mod_gml_FireCont_end(scrFRPlayerFireExt(direction, scrFRWeaponSlotRead(scrFRSelf(self), "wep"), x, y, team, creator, accuracy));
}
;
}
}
}
}
scrFRWeaponSlotRead(scrFRSelf(self), "wep").chrg = 0;
;
}
}
scrFRWeaponSlotRead(scrFRSelf(self), "wep").chrg_num = 0;
;
}
}
scrFRInstanceDestroy();
;
}
} else {
fire = true;
}
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4658
function fr_Objects_Frontier_Projectiles_mod_gml_player_swap(_frl__player=undefined) {
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

// Original Objects/Frontier_Projectiles.mod.gml:4672
function fr_Objects_Frontier_Projectiles_mod_gml_weapon_get() { return scrFRSourceWeaponGet((argument_count>0 ? argument[0] : undefined),(argument_count>1 ? argument[1] : undefined)); }

// Original Objects/Frontier_Projectiles.mod.gml:4815
function fr_Objects_Frontier_Projectiles_mod_gml_FireCont_end() {
{ var __fr_with1 = scrFRWithValues(((argument_count > 0) ? (argument_count>0 ? argument[0] : undefined) : scrFRSelf(self))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRVariableExists(scrFRSelf(self), "creator")) {
{
{ var __fr_with4 = scrFRWithValues(creator), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((friction / (timescale * timescale)) != 0)) {
{
var __fr_other7=scrFROther(other);
hspeed += ((__fr_other7.hspeed / timescale)) * timescale;
;
var __fr_other8=scrFROther(other);
vspeed += ((__fr_other8.vspeed / timescale)) * timescale;
;
}
}
if (scrFRVariableExists(scrFRSelf(self), "wkick")) {
var __fr_other9=scrFROther(other);
wkick = __fr_other9.wkick;
}
if (scrFRVariableExists(scrFRSelf(self), "wepangle")) {
var __fr_other10=scrFROther(other);
wepangle = (__fr_other10.wepangle * ((abs(__fr_other10.wepangle) > 1) ? sign(wepangle) : wepangle));
}
if (scrFRVariableExists(scrFRSelf(self), "reload")) {
var __fr_other11=scrFROther(other);
reload += __fr_other11.reload;
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

// Original Objects/Frontier_Projectiles.mod.gml:4834
function fr_Objects_Frontier_Projectiles_mod_gml_WhiteSmoke_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprWhiteSmoke);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4840
function fr_Objects_Frontier_Projectiles_mod_gml_WhiteDust_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprWhiteSmoke);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Projectiles.mod.gml:4846
function fr_Objects_Frontier_Projectiles_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Projectiles"].sprGenericTrail);
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

// Original Objects/Frontier_Projectiles.mod.gml:4858
function fr_Objects_Frontier_Projectiles_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
_frl__sound = scrFRSoundHit(_frl__sound, 1);
;
audio_sound_pitch(_frl__sound, _frl__pitch);
;
audio_sound_gain(_frl__sound, _frl__volume, 0);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4863
function fr_Objects_Frontier_Projectiles_mod_gml_sound_play_hit_big_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
_frl__sound = scrFRSoundHitBig(_frl__sound, 1);
;
audio_sound_pitch(_frl__sound, _frl__pitch);
;
audio_sound_gain(_frl__sound, _frl__volume, 0);
;
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
; // macro hoisted: alarm0_run
;
; // macro hoisted: alarm1_run
;
; // macro hoisted: alarm2_run
;
; // macro hoisted: alarm3_run
;
; // macro hoisted: alarm4_run
;
; // macro hoisted: alarm5_run
;
; // macro hoisted: alarm6_run
;
; // macro hoisted: alarm7_run
;
; // macro hoisted: alarm8_run
;
; // macro hoisted: alarm9_run
;
; // macro hoisted: instance_max
;
; // macro hoisted: bbox_center_x
;
; // macro hoisted: bbox_center_y
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4883
function fr_Objects_Frontier_Projectiles_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Projectiles.mod.gml:4884
function fr_Objects_Frontier_Projectiles_mod_gml_nothing() {

}

// Original Objects/Frontier_Projectiles.mod.gml:4885
function fr_Objects_Frontier_Projectiles_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}
