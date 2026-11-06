#macro frMacro_Objects_Frontier_Labs_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Labs"].scr

#macro frMacro_Objects_Frontier_Labs_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Labs_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Labs_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Labs_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Labs_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Labs_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Labs_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Labs_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Labs.mod.gml:1
function fr_Objects_Frontier_Labs_mod_gml___load() {

}

// Original Objects/Frontier_Labs.mod.gml:1
function fr_Objects_Frontier_Labs_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Labs_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Labs_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Labs_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Labs.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Labs", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Labs"].settingBlaacTank = false;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndCrematorHurt = sndFR_sndCrematorHurt_68f1f2ef5868;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndCrematorDead = sndFR_sndCrematorDead_1b304d3a981c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndCoreapheeHurt = sndFR_sndCoreapheeHurt_0afeb1f2896b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndCoreapheeDead = sndFR_sndCoreapheeDead_4768e3ab4300;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverHurt = sndFR_sndDatadriverHurt_c795a767c98a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverDead = sndFR_sndDatadriverDead_0126afa9b077;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverDig = sndFR_sndDatadriverDig_852c012ccb27;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverReplace = sndFR_sndDatadriverReplace_decb527468f1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrHurt = sndFR_sndRammrHurt_55a2723cab8b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrDead = sndFR_sndRammrDead_294103b3cfe8;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrRam = sndFR_sndRammrRam_3f2705062599;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistHurt = sndFR_sndVoltergeistHurt_d4463ed092d9;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistDead = sndFR_sndVoltergeistDead_c64d9af208e3;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistFly = sndFR_sndVoltergeistFly_077f8eb321eb;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistPossess = sndFR_sndVoltergeistPossess_d15042109ddc;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerHurt = sndFR_sndSwarmerHurt_8c4e71e5ce9a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerDead = sndFR_sndSwarmerDead_5e3f871d43ea;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge = sndFR_sndSwarmerCharge_570eb3b9818a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge2 = sndFR_sndSwarmerCharge2_130b3995ff9c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge3 = sndFR_sndSwarmerCharge3_44669915338a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierHurt = sndFR_sndBombardierHurt_129569067b0d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierDead = sndFR_sndBombardierDead_56188f8f54d4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierFire = sndFR_sndBombardierFire_8693661fab3c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartIdle = [sndFR_sndSmartIdle_cd0f10064c91, sndFR_sndSmartIdle2_737823c0da91, sndFR_sndSmartIdle3_d500151adc3f, sndFR_sndSmartIdle4_c27a32babc4e, sndFR_sndSmartIdle5_c828cbedb520, sndFR_sndSmartIdle6_1240b3a46980];
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartHurt = [sndFR_sndSmartHurt_519eff53fbfb, sndFR_sndSmartHurt2_3a89eb2f7614, sndFR_sndSmartHurt3_dde8459f2b9b, sndFR_sndSmartHurt4_b9548c318786, sndFR_sndSmartHurt5_1073aa65701d, sndFR_sndSmartHurt6_dd1e784cc7c6, sndFR_sndSmartHurt7_0d1532fbc253, sndFR_sndSmartHurt8_5a5904609242];
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartLeave = sndFR_sndSmartLeave_51d3c4da8a93;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartDead = sndFR_sndSmartDead_1126c3fd9855;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntrance = sprFR_sprLabsEntrance_45186775edd1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceUnlocked = sprFR_sprLabsEntranceUnlocked_f85f09756e08;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceOpening = sprFR_sprLabsEntranceOpening_43c423ebecc0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceOpen = sprFR_sprLabsEntranceOpen_aaf35674585c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrap = sprFR_sprBallTrap_7ca94d5d457a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapHurt = sprFR_sprBallTrapHurt_309d0a31a2db;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapDead = sprFR_sprBallTrapDead_db3739615dd0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapOff = sprFR_sprBallTrapOff_e6db312c5c60;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].shdBallTrap = sprFR_shdBalLTrap_64b52d9418af;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskBallTrapBall = sprFR_mskBallTrapBall_44dc4e0cf6d3;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBall = sprFR_sprBallTrapBall_f69ce98679df;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBallDisappear = sprFR_sprBallTrapBallDisappear_b0b4174613df;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBallTrail = sprFR_sprBallTrapBalLTrail_161a0caed742;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartIdle = sprFR_sprNecromancerSmartIdle_00a1303fd4d3;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartWalk = sprFR_sprNecromancerSmartWalk_d9de67288f18;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartHurt = sprFR_sprNecromancerSmartHurt_464c25f9e7d4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistIdle = sprFR_sprVoltergeistIdle_506f21be89a6;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistFly = sprFR_sprVoltergeistFly_5c7424e6a582;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistHurt = sprFR_sprVoltergeistHurt_b0ecacc8b0ce;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDead = sprFR_sprVoltergeistDead_ddd12c2c52cb;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].shdCremator = sprFR_shdCremator_155059a036a0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskCremator = sprFR_mskCremator_d7bd7cb2337c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorIdle = sprFR_sprCrematorIdle_ef910b5db0de;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorWalk = sprFR_sprCrematorWalk_925120679e09;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorHurt = sprFR_sprCrematorHurt_3db803c3f2ff;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorDead = sprFR_sprCrematorDead_d67fa7786902;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorFire = sprFR_sprCrematorFire_24f0e2d7355e;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedIdle = sprFR_sprCrematorPossessedIdle_8ba2346d034f;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedWalk = sprFR_sprCrematorPossessedWalk_7d27a5216cec;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedFire = sprFR_sprCrematorPossessedFire_46315a1b166f;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselMortar = sprFR_mskVesselMortar_93c13374d1ce;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselMortarLoaded = sprFR_mskVesselMortarLoaded_3a3bdfc879ab;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarIdle = sprFR_sprVesselMortarIdle_e96defa2d28c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarWalk = sprFR_sprVesselMortarWalk_d5e8226e5a58;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarHurt = sprFR_sprVesselMortarHurt_88890f79fe9a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarDead = sprFR_sprVesselMortarDead_1273353da972;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarReload = sprFR_sprVesselMortarReload_c0d1775a8fec;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedIdle = sprFR_sprVesselMortarLoadedIdl_be6ff31e49e9;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedWalk = sprFR_sprVesselMortarLoadedWal_e6e5ad3a7055;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedHurt = sprFR_sprVesselMortarLoadedHur_e1b23c718100;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedDead = sprFR_sprVesselMortarLoadedDea_1f2ffd7de3e5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselOrbiter = sprFR_mskVesselOrbiter_49608f33addb;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterIdle = sprFR_sprVesselOrbiterIdle_0b2c1cff6ec7;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterHurt = sprFR_sprVesselOrbiterHurt_c28ea337a3b5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterDead = sprFR_sprVesselOrbiterDead_2cd3233d69f6;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerIdle = sprFR_sprVesselChargerIdle_e675d84add0b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerWalk = sprFR_sprVesselChargerWalk_ead3b58f8646;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerHurt = sprFR_sprVesselChargerHurt_e53454452d77;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerDead = sprFR_sprVesselChargerDead_286395f227ff;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerTell = sprFR_sprVesselChargerTell_fb55a4b47e7e;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerChrg = sprFR_sprVesselChargerChrg_de34a557142c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedIdle = sprFR_sprSnowTankPossessedIdle_7638192952ed;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedWalk = sprFR_sprSnowTankPossessedWalk_ca9ab2204e5c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedIdle = sprFR_sprGoldTankPossessedIdle_66538f95c3f5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedWalk = sprFR_sprGoldTankPossessedWalk_daccf5652ce2;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedIdle = sprFR_sprBlaacGoldTankPossesse_600ae73df885;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedWalk = sprFR_sprBlaacGoldTankPossesse_0f270f5e323d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedIdle = sprFR_sprTurretPossessedIdle_b894d3fbecff;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedHurt = sprFR_sprTurretPossessedHurt_560561a9e88d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedFire = sprFR_sprTurretPossessedFire_fcfd1d9a01c2;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedIdle = sprFR_sprSniperPossessedIdle_ed691d2f58fb;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedWalk = sprFR_sprSniperPossessedWalk_aac47c4a3cc7;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedIdle = sprFR_sprWolfPossessedIdle_986404ba8c5b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedWalk = sprFR_sprWolfPossessedWalk_1f9189d871a4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedFire = sprFR_sprWolfPossessedFire_ee3391f96e01;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedIdle = sprFR_sprSnowBotPossessedIdle_06a8fa2fdde1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedWalk = sprFR_sprSnowBotPossessedWalk_d915a50a393c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedFire = sprFR_sprSnowBotPossessedFire_c3edc49b8679;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinIdle = sprFR_sprSnowAssassinIdle_24aaa3f59db4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinWalk = sprFR_sprSnowAssassinWalk_812dca8b5b7b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinHurt = sprFR_sprSnowAssassinHurt_0ee6b73745ba;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinDead = sprFR_sprSnowAssassinDead_5a933b196e60;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotIdle = sprFR_sprSwarmbotIdle_b36abfba42ef;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotWalk = sprFR_sprSwarmbotWalk_ceb5be800e56;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotHurt = sprFR_sprSwarmbotHurt_01eabc5770b8;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotDead = sprFR_sprSwarmbotDead_40a38d7bfc72;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotChrg = sprFR_sprSwarmbotChrg_369393b7260c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotFired = sprFR_sprSwarmbotFired_a2513e88fd28;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedIdle = sprFR_sprSwarmbotPossessedIdle_3b92ed567658;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedWalk = sprFR_sprSwarmbotPossessedWalk_c79af073634d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedChrg = sprFR_sprSwarmbotPossessedChrg_551461aebbb1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerIdle = sprFR_sprEngineerIdle_70546a6348d9;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerWalk = sprFR_sprEngineerWalk_972d5487e3ff;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerHurt = sprFR_sprEngineerHurt_d311810421bc;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerDead = sprFR_sprEngineerDead_f0860b05c27e;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerCannon = sprFR_sprEngineerCannon_25c50bdf5ab2;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerWrench = sprFR_sprEngineerWrench_0e45ad303045;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskMissileDrone = sprFR_mskMissileDrone_05628c6d0df0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].shdMissileDrone = sprFR_shdMissileDrone_5014df9d73a1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneIdle = sprFR_sprMissileDroneIdle_2e52d729cb20;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneWalk = sprFR_sprMissileDroneWalk_66c489b69687;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneHurt = sprFR_sprMissileDroneHurt_811cddbdd3bd;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneDead = sprFR_sprMissileDroneDead_3276fa89c918;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDronePossessedIdle = sprFR_sprMissileDronePossessed_6410cae6052e;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDronePossessedWalk = sprFR_sprMissileDronePossessed_dcd1cc80ae58;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellWarning = sprFR_sprFreakShellWarning_b51c2345b6e1;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellFall = sprFR_sprFreakShellFall_69cf8bacea0a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellIdle = sprFR_sprFreakShellIdle_0b15c85b2c70;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellHurt = sprFR_sprFreakShellHurt_630247cc3de0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpening = sprFR_sprFreakShellOpening_818d5f2bf557;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpen = sprFR_sprFreakShellOpen_695a3f2d9918;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpenHurt = sprFR_sprFreakShellOpenHurt_d94542fe6390;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskRhinoFreakShell = sprFR_mskRhinoFreakShell_aecfa73988cb;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellWarning = sprFR_sprRhinoFreakShellWarnin_6c95fe41f12d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellFall = sprFR_sprRhinoFreakShellFall_a1811e85d442;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellIdle = sprFR_sprRhinoFreakShellIdle_b83ae005be20;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellHurt = sprFR_sprRhinoFreakShellHurt_153c20610eb5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellOpen = sprFR_sprRhinoFreakShellOpen_a38f16e0ddcf;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellOpenHurt = sprFR_sprRhinoFreakShellOpenHu_c0e424453357;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellDoor = sprFR_sprRhinoFreakShellDoor_0730dcea4147;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke = sprFR_sprWhiteSmoke_af86c6156b99;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprEnemyStreak = sprFR_sprEnemyStreak_e17a2ab96948;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShell = sprFR_sprCrematorShell_093a06de5b63;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappear = sprFR_sprCrematorShellDisappea_62aece6fe6ce;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellChrg = sprFR_sprCrematorShellCharged_30a1bac8058a;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappearChrg = sprFR_sprCrematorShellChargedD_0f5e27504887;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprCreep = sprFR_sprCreep_d9e998606286;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameStreak = sprFR_sprFlameStreak_5cb00905de79;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameCreepBubble = sprFR_sprFlameCreepBubble_ce757b580381;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameStreakCharged = sprFR_sprFlameStreakCharged_c24885c88a46;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameCreepBubbleCharged = sprFR_sprFlameCreepBubbleCharg_2571bf8daa06;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprGatorCreep = sprFR_sprGatorCreep_3c0169838e33;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].mskLabsRocket = sprFR_mskLabsRocket_fea03aafd991;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocket = sprFR_sprLabsRocket_f1d0fdaa90b9;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketFlame = sprFR_sprLabsRocketFlame_51e870eb9782;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketTrail = sprFR_sprLabsRocketTrail_20973c7b389d;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketExplosion = sprFR_sprLabsRocketExplosion_28e36de08e6f;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprServerBundle = sprFR_sprServerBundle_1eb36c7de810;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprServerBundleDebris = sprFR_sprJunkDebris3_156fc445c6ea;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning = [sprFR_sprVoltergeistLightning_c3762615fa62, sprFR_sprVoltergeistLightning2_8892eec6098f, sprFR_sprVoltergeistLightning3_abd1f0f77904, sprFR_sprVoltergeistLightning4_189ab66503d6, sprFR_sprVoltergeistLightning5_1ef81ba8c1a6];
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDust = sprFR_sprVoltergeistDust_a791d7b5d36b;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistRevive = sprFR_sprVoltergeistRevive_a7dfddd026a4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLobbedJunkWarning = sprFR_sprLobbedJunkWarning_862f209e3bad;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprOrbiterBullet = sprFR_sprOrbiterBullet_be72765fbcb5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprOrbiterBulletTrail = sprFR_sprOrbiterBulletTrail_eae8e4c89e97;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlasterShell = sprFR_sprBlasterShell_f4eb0a7dfa3c;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlasterShellDisappear = sprFR_sprBlasterShellDisappear_4aaf8eae4bf4;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprLaserTrapBeamEnd = sprFR_sprLaserTrapBeamEnd_fe4f63251cab;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprGibs = sprFR_sprGibs_8fc95d3790e5;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprHoneypotHeal = sprFR_sprHoneypotHeal_ede8650cdec0;
;
global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmerEggDebris = sprFR_sprSwarmerEggDebris_71b366367aad;
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Labs.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Labs.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Labs.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Labs.mod.gml:278
function fr_Objects_Frontier_Labs_mod_gml_LabsEntrance_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LabsEntrance";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntrance;
;
spr_unlocked = global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceUnlocked;
;
spr_opening = global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceOpening;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsEntranceOpen;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = 5;
;
prompt = noone;
;
mytext = scrFRLocalize("ENTER");
;
pick = (- 1);
;
locked = true;
;
portalPusher = noone;
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_LabsEntrance_step];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:304
function fr_Objects_Frontier_Labs_mod_gml_LabsEntrancePrompt_step() {
if (((pick != (- 1)) and (open == false))) {
{
{ var __fr_with1 = scrFRWithValues(GameCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
area = scrFRAreaResolve("graveyard");
;
subarea = 0;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_alpha = 0;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(creator.portalPusher), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
creator.sprite_index = scrFRAreaSourceSprite(creator.spr_opening);
;
open = true;
;
fr_glow = [48, 64];
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:328
function fr_Objects_Frontier_Labs_mod_gml_LabsEntrance_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((locked == true) && scrFRInstanceExists(Portal))) {
{
locked = false;
;
sprite_index = scrFRAreaSourceSprite(spr_unlocked);
;
repeat (10) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y + scrFRSourceRandomRange((- 8), 8)), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
direction = scrFRSourceChoose(90, 270);
speed = (3) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitch(sndToxicBoltGas, (0.75 + scrFRSourceRandom(0.1)));
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Labs_mod_gml_LabsEntrancePrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
open = false;
;
}
}
if(__fr_break6) break;
}}
}
}
if (((sprite_index == spr_opening) && frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_open);
;
}
}
var _frl__yuck = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instances_meeting, x, y, Corpse);
;
{ var __fr_with8 = scrFRWithValues(_frl__yuck), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
var __fr_other11=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other11.x, __fr_other11.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 0.7);
}
}
}
}
if(__fr_break10) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:365
function fr_Objects_Frontier_Labs_mod_gml_BallTrap_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ElectricityTrap";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrap;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapDead;
;
spr_off = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapOff;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
hitid = [spr_idle, "ELECTRIC TRAP"];
;
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Labs"].shdBallTrap;
;
spr_shadow_y = 4;
;
snd_hurt = sndTurretHurt;
;
snd_dead = sndTurretDead;
;
team = 1;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 200, "=");
;
hp = max_hp;
;
activated = true;
;
myBall = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_create(x, y, scrFRSelf(self), scrFRSourceRandom(360));
on_step = fr_Objects_Frontier_Labs_mod_gml_BallTrap_step;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Prop_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:401
function fr_Objects_Frontier_Labs_mod_gml_BallTrap_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Objects_Frontier_Labs_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if (((! scrFRInstanceExists(myBall)) && (activated == true))) {
{
myBall = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_create(x, y, scrFRSelf(self), scrFRSourceRandom(360));
}
}
if ((scrFRInstanceExists(Portal) && (activated == true))) {
{
activated = false;
;
spr_idle = spr_off;
;
{ var __fr_with1 = scrFRWithValues(myBall), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
if ((hp <= 0)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_dead);
;
var __fr_other8=scrFROther(other);
image_xscale = __fr_other8.image_xscale;
;
var __fr_other9=scrFROther(other);
size = __fr_other9.size;
;
}
}
if(__fr_break6) break;
}}
scrFRSoundPlay(snd_dead);
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:439
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__angle=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BallTrapBall";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBall);
;
image_speed = (0.4) * timescale;
;
depth = (- 7);
;
hitid = _frl__creator.hitid;
;
fr_bloom = [1.5, 0.2];
;
fr_glow = [24, 32];
;
damage = 3;
;
creator = _frl__creator;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskBallTrapBall;
;
typ = 0;
;
ammo_type = (- 1);
;
team = _frl__creator.team;
;
angle = _frl__angle;
;
dist = 0;
;
maxDist = 60;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_step;
;
on_end_step = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_endstep;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_wall;
;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_destroy;
;
xprevious = (creator.x + lengthdir_x(dist, angle));
;
yprevious = (creator.y + lengthdir_y(dist, angle));
;
x = (creator.x + lengthdir_x(dist, angle));
;
y = (creator.y + lengthdir_y(dist, angle));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:477
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((dist < maxDist)) {
{
dist += (0.5 * scrFRSourceScale());
;
}
}
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Labs_mod_gml_orandom(8)), (y + fr_Objects_Frontier_Labs_mod_gml_orandom(8)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBallTrail);
;
image_angle = scrFRSourceRandom(360);
;
var __fr_other4=scrFROther(other);
depth = __fr_other4.depth;
}
}
if(__fr_break3) break;
}}
}
}
angle += (3.5 * scrFRSourceScale());
;
image_angle += (12 * scrFRSourceScale());
;
}

// Original Objects/Frontier_Labs.mod.gml:500
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_endstep() {
if (scrFRInstanceExists(creator)) {
{
xprevious = (creator.x + lengthdir_x(dist, angle));
;
yprevious = (creator.y + lengthdir_y(dist, angle));
;
x = (creator.x + lengthdir_x(dist, angle));
;
y = (creator.y + lengthdir_y(dist, angle));
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:508
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((!scrFRVariableExists(scrFRSelf(self), "fr_trapImmune")) && (! scrFRInstanceIs(scrFRSelf(self), prop)))) {
{
lasthit = [global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrap, "ELECTRIC TRAP"];
;
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
}
}

// Original Objects/Frontier_Labs.mod.gml:518
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_wall() {
xprevious = (x + (hspeed / timescale));
;
yprevious = (y + (vspeed / timescale));
;
}

// Original Objects/Frontier_Labs.mod.gml:522
function fr_Objects_Frontier_Labs_mod_gml_BallTrapBall_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprBallTrapBallDisappear);
;
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.image_angle;
;
depth = (- 3);
;
image_xscale = 0.8;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:713
function fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Smartest Guy Ever";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprNecromancerSmartHurt;
;
spr_dead = mskNone;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "NECROMANCER"];
spr_shadow = shd24;
;
spr_shadow_y = 2;
;
snd_hurt = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartHurt, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartHurt) - 1)));
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartDead;
;
snd_idle = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartIdle, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartIdle) - 1)));
;
mask_nrml = mskMaggot;
;
mask_index = mask_nrml;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
raddrop = 2;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
prevHealth = max_hp;
;
voiceCooldown = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:765
function fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
if ((hp != prevHealth)) {
{
scrFRSoundStop(snd_idle);
;
snd_hurt = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartHurt, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartHurt) - 1)));
}
}
prevHealth = hp;
;
if ((voiceCooldown > 0)) {
{
voiceCooldown -= scrFRSourceScale();
;
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:795
function fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(20)), "=");
;
if (((distance_to_object(Player) < 128) && (voiceCooldown <= 0))) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 5)) {
{
snd_idle = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartIdle, scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Labs"].sndSmartIdle) - 1)));
;
scrFRSoundPlay(snd_idle);
voiceCooldown += 90;
;
}
}
}
}
if (fr_Objects_Frontier_Labs_mod_gml_chance(1, 4)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:811
function fr_Objects_Frontier_Labs_mod_gml_SmartestNecromancer_death() {
scrFRSoundStop(snd_hurt);
;
if ((hp <= 0)) {
{
repeat (6) {
fr_Objects_Frontier_Labs_mod_gml_Gib_create(x, y);
}
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = (2) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:826
function fr_Objects_Frontier_Labs_mod_gml_Gib_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprGibs);
;
image_index = scrFRSourceIRandom(2);
;
image_speed = (0) * timescale;
;
speed = ((2.5 + scrFRSourceRandom(1))) * timescale;
;
friction = (0.1) * (timescale * timescale);
;
direction = scrFRSourceRandom(360);
;
despawnTime = 120;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_Gib_step;
;
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
direction = __fr_other7.direction;
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
zspeed = (3 + scrFRSourceRandom(1));
;
zfriction = 0.6;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
var __fr_other9=scrFROther(other);
depth = __fr_other9.depth;
;
var __fr_other10=scrFROther(other);
mask_index = __fr_other10.mask_index;
;
impactEffect = false;
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

// Original Objects/Frontier_Labs.mod.gml:851
function fr_Objects_Frontier_Labs_mod_gml_Gib_step() {
despawnTime -= scrFRSourceScale();
;
if ((despawnTime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:858
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create(_frl__x=undefined, _frl__y=undefined) {
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_VoltergeistController")) == 0)) {
{
fr_Objects_Frontier_Labs_mod_gml_VoltergeistController_create(10016, 10016);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Voltergeist";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistIdle;
;
spr_fly = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistFly;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 3);
;
hitid = [spr_idle, "VOLTERGEIST"];
;
trailColor = make_color_rgb(255, 217, 70);
;
nts_color_blood = [c_aqua, c_yellow];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistDead;
;
snd_fly = global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistFly;
;
snd_possess = global.fr_module_vars[$ "mod:Frontier_Labs"].sndVoltergeistPossess;
;
mask_nrml = mskMaggot;
;
mask_index = mask_nrml;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 16, "=");
;
hp = max_hp;
;
raddrop = 1;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
canfly = true;
;
possess_target = noone;
;
omw2possess = false;
;
possessing = false;
;
possessionCreds = 2;
;
armorLock = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Voltergeist_step];
;
on_end_step = fr_Objects_Frontier_Labs_mod_gml_Voltergeist_endstep;
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Voltergeist_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Voltergeist_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:923
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if (((array_length(scrFRMatching(hitme, "fr_possessable", true)) <= 0) && (possessing == false))) {
{
hp = 0;
;
exit;
;
}
}
if ((armorLock > 0)) {
{
armorLock -= scrFRSourceScale();
;
}
} else {
{
if (((possessing == false) && (hp > max_hp))) {
{
hp = max_hp;
;
}
}
}
}
if ((omw2possess == true)) {
{
possess_target = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(hitme, "fr_possessable", true));
;
if ((distance_to_object(possess_target) > 480)) {
{
hp = 0;
;
}
}
direction -= (angle_difference(direction, point_direction(x, y, possess_target.x, possess_target.y)) * power((0.1 * 2), scrFRSourceScale()));
;
image_angle = (direction - 90);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((direction + fr_Objects_Frontier_Labs_mod_gml_orandom(20)), 1);
if ((distance_to_object(possess_target) < 6)) {
{
scrFRSoundPitch(snd_possess, (0.95 + scrFRSourceRandom(0.1)));
;
possessionCreds -= 1;
;
hp = (max_hp * 5);
possessing = true;
;
omw2possess = false;
;
maxspeed /= 3;
;
depth = (- 2);
;
image_alpha = 0;
;
image_angle = 0;
;
{ var __fr_with1 = scrFRWithValues(possess_target), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_possessable = false;
;
fr_possessed = true;
;
var __fr_other4=scrFROther(other);
fr_possessor = __fr_other4;
;
if (scrFRVariableExists(scrFRSelf(self), "on_possessed")) {
{
scrFRScriptCall(on_possessed);
;
}
} else {
{
{ var __fr_switch_value5=scrFRObjectIndex(scrFRSelf(self)), __fr_switch_case6=-1;
if(__fr_switch_case6==-1 && __fr_switch_value5==(SnowTank)) __fr_switch_case6=0;
if(__fr_switch_case6==-1 && __fr_switch_value5==(GoldSnowTank)) __fr_switch_case6=1;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Wolf)) __fr_switch_case6=2;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Turret)) __fr_switch_case6=3;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Sniper)) __fr_switch_case6=4;
if(__fr_switch_case6==-1 && __fr_switch_value5==(SnowBot)) __fr_switch_case6=5;
if(__fr_switch_case6==-1) __fr_switch_case6=-1;
switch(__fr_switch_case6) {
case 0:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedWalk;
;
hitid = [spr_idle, "POSSESSED#SNOWTANK"];
;
break;
;
case 1:
spr_idle = ((global.fr_module_vars[$ "mod:Frontier_Labs"].settingBlaacTank == true) ? global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedIdle : global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedIdle);
;
spr_walk = ((global.fr_module_vars[$ "mod:Frontier_Labs"].settingBlaacTank == true) ? global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedWalk : global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedWalk);
;
hitid = [spr_idle, "POSSESSED GOLDEN#SNOWTANK"];
;
break;
;
case 2:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedWalk;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedFire;
;
hitid = [spr_idle, "POSSESSED#WOLF"];
;
break;
;
case 3:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedIdle;
;
spr_walk = spr_idle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedHurt;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedFire;
;
hitid = [spr_idle, "POSSESSED#TURRET"];
;
break;
;
case 4:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedWalk;
;
hitid = [spr_idle, "POSSESSED#SNIPER"];
;
break;
;
case 5:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedWalk;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedFire;
;
hitid = [spr_idle, "POSSESSED#SNOWBOT"];
;
break;
;
}
}
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), (1 / 0));
;
repeat (6) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
repeat (12) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDust);
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break12) break;
}}
}
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
if ((possessing == true)) {
{
if (scrFRInstanceExists(possess_target)) {
{
x = possess_target.x;
;
y = possess_target.y;
;
}
} else {
{
fr_Objects_Frontier_Labs_mod_gml_Voltergeist_end_possession();
;
}
}
}
}
if ((scrFRSourceRandom(30) < 1)) {
{
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning, _frl__variant));
;
}
}
if(__fr_break15) break;
}}
}
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
if (((sprite_index != spr_fly) && frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((omw2possess == true)) {
{
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_fly);
;
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:1107
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_endstep() {
if ((omw2possess == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_GenericTrail_create(x, y)), __fr_break3=false;
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
var __fr_other7=scrFROther(other);
image_blend = __fr_other7.trailColor;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1120
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_end_possession() {
armorLock = 30;
;
mask_index = mask_nrml;
;
possessing = false;
;
image_alpha = 1;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 10, "=");
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
if ((possessionCreds <= 0)) {
{
hp = 0;
;
exit;
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1132
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_alrm1() {
if ((possessing == false)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
var _frl__nearestPossessable = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(hitme, "fr_possessable", true));
;
if ((distance_to_object(_frl__nearestPossessable) > 512)) {
{
hp = 0;
;
exit;
;
}
}
if ((omw2possess == false)) {
{
if (((distance_to_object(target) < 96) || (hp < (max_hp / 2)))) {
{
omw2possess = true;
;
maxspeed *= 3;
;
mask_index = mskNone;
;
depth = (- 8);
;
scrFRSoundPitch(snd_fly, (0.95 + scrFRSourceRandom(0.1)));
;
exit;
;
}
}
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), 30);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1159
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
scrFRMotionAdd(_frl__dir, _frl__spd);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
if ((hp > 0)) {
{
scrFRSoundHit(snd_hurt, 0.3);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1174
function fr_Objects_Frontier_Labs_mod_gml_VoltergeistController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_VoltergeistController";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
on_step = fr_Objects_Frontier_Labs_mod_gml_VoltergeistController_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1182
function fr_Objects_Frontier_Labs_mod_gml_VoltergeistController_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([SnowTank, GoldSnowTank, SnowBot, Wolf, Sniper, Turret], "fr_possessable", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_possessable = true;
;
fr_possessed = false;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(SnowBot, "fr_possessed", true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((sprite_index == spr_fire)) {
{
speed += (0.5) * timescale;
;
}
}
if (scrFRInstanceIs(scrFRSelf(self), SnowBotCar)) {
{
{ var __fr_with7 = scrFRWithValues(fr_possessor), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
possessionCreds += 1;
;
fr_Objects_Frontier_Labs_mod_gml_Voltergeist_end_possession();
;
}
}
if(__fr_break9) break;
}}
fr_possessed = false;
;
fr_possessable = false;
;
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), 0);
;
}
}
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1233
function fr_Objects_Frontier_Labs_mod_gml_Voltergeist_possess_manual() {
{ var __fr_with1 = scrFRWithValues(possess_target), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_possessable = false;
;
fr_possessed = true;
;
var __fr_other4=scrFROther(other);
fr_possessor = __fr_other4;
;
if (scrFRVariableExists(scrFRSelf(self), "on_possessed")) {
{
scrFRScriptCall(on_possessed);
;
}
} else {
{
{ var __fr_switch_value5=scrFRObjectIndex(scrFRSelf(self)), __fr_switch_case6=-1;
if(__fr_switch_case6==-1 && __fr_switch_value5==(SnowTank)) __fr_switch_case6=0;
if(__fr_switch_case6==-1 && __fr_switch_value5==(GoldSnowTank)) __fr_switch_case6=1;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Wolf)) __fr_switch_case6=2;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Turret)) __fr_switch_case6=3;
if(__fr_switch_case6==-1 && __fr_switch_value5==(Sniper)) __fr_switch_case6=4;
if(__fr_switch_case6==-1 && __fr_switch_value5==(SnowBot)) __fr_switch_case6=5;
if(__fr_switch_case6==-1) __fr_switch_case6=-1;
switch(__fr_switch_case6) {
case 0:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowTankPossessedWalk;
;
hitid = [spr_idle, "POSSESSED#SNOWTANK"];
;
break;
;
case 1:
spr_idle = ((global.fr_module_vars[$ "mod:Frontier_Labs"].settingBlaacTank == true) ? global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedIdle : global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedIdle);
;
spr_walk = ((global.fr_module_vars[$ "mod:Frontier_Labs"].settingBlaacTank == true) ? global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlaacGoldTankPossessedWalk : global.fr_module_vars[$ "mod:Frontier_Labs"].sprGoldTankPossessedWalk);
;
hitid = [spr_idle, "POSSESSED GOLDEN#SNOWTANK"];
;
break;
;
case 2:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedWalk;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprWolfPossessedFire;
;
hitid = [spr_idle, "POSSESSED#WOLF"];
;
break;
;
case 3:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedIdle;
;
spr_walk = spr_idle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedHurt;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprTurretPossessedFire;
;
hitid = [spr_idle, "POSSESSED#TURRET"];
;
break;
;
case 4:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSniperPossessedWalk;
;
hitid = [spr_idle, "POSSESSED#SNIPER"];
;
break;
;
case 5:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedWalk;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowBotPossessedFire;
;
hitid = [spr_idle, "POSSESSED#SNOWBOT"];
;
break;
;
}
}
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), (1 / 0));
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1289
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_create(_frl__x=undefined, _frl__y=undefined, _frl__breakIt=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Datadriver";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarDead;
;
spr_loading = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarReload;
;
spr_idle_loaded = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedIdle;
;
spr_walk_loaded = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedWalk;
;
spr_hurt_loaded = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedHurt;
;
spr_dead_loaded = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselMortarLoadedDead;
;
spr_idle_nrml = spr_idle;
;
spr_hurt_nrml = spr_hurt;
;
spr_walk_nrml = spr_walk;
;
spr_dead_nrml = spr_dead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle_loaded, "DATADRIVER"];
spr_shadow = shd48;
;
spr_shadow_y = 8;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverDead;
;
snd_load = global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverReplace;
;
snd_dig = global.fr_module_vars[$ "mod:Frontier_Labs"].sndDatadriverDig;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselMortar;
;
msk_nrml = global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselMortar;
;
msk_loaded = global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselMortarLoaded;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 42, "=");
;
hp = max_hp;
;
raddrop = 10;
;
maxspeed = (2.6) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
;
canmelee = 0;
;
meleedamage = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
target_x = 10016;
;
target_y = 10016;
;
loading = false;
;
loaded = false;
;
doReloadSound = false;
;
if ((_frl__breakIt == true)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 0.6;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
}
}
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselMortar_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_VesselMortar_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselMortar_alrm1];
;
on_alrm2 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselMortar_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1366
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Labs_mod_gml_alarm2_run)) {
exit;
}
if (scrFRPlaceMeeting(x, y, Wall)) {
{
scrFRInstanceCreate(x, y, PortalClear);
;
}
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((loading == false)) {
{
if (((sprite_index != spr_loading) && frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite((((speed / timescale) > 0) ? spr_walk : spr_idle));
;
}
} else {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
}
}
}
} else {
{
if (((sprite_index == spr_hurt) && frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
loading = false;
;
}
}
}
}
if ((sprite_index == spr_loading)) {
{
if ((doReloadSound == true)) {
{
if ((image_index >= 7)) {
{
scrFRSoundPitch(snd_load, (0.95 + scrFRSourceRandom(0.1)));
;
doReloadSound = false;
;
}
}
}
}
if (frMacro_Objects_Frontier_Labs_mod_gml_anim_end) {
{
loading = false;
;
loaded = true;
;
spr_idle = spr_idle_loaded;
;
spr_walk = spr_walk_loaded;
;
spr_hurt = spr_hurt_loaded;
;
spr_dead = spr_dead_loaded;
;
mask_index = msk_loaded;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:1427
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if ((loaded == false)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(3, 4)) {
{
if ((loading == false)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
loading = true;
;
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_loading);
;
doReloadSound = true;
;
scrFRSoundPitch(snd_dig, (0.9 + scrFRSourceRandom(0.2)));
}
}
}
} else {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
} else {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance < 160)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(4, 5)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(20)), "=");
;
loaded = false;
;
if (scrFRInstanceExists(target)) {
{
target_x = ((target.x + (target.hspeed / timescale)) + scrFRSourceRandomRange((- 24), 24));
;
target_y = ((target.y + (target.vspeed / timescale)) + scrFRSourceRandomRange((- 24), 24));
;
}
}
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_MortarJunk_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mask_index = mskNone;
;
z = 13;
;
zspeed = (11 + scrFRSourceRandom(2));
;
zfriction = 0.6;
;
var __fr_other4=scrFROther(other);
direction = point_direction(x, y, __fr_other4.target_x, __fr_other4.target_y);
;
var __fr_other5=scrFROther(other);
speed = (((point_distance(x, y, __fr_other5.target_x, __fr_other5.target_y) * zfriction) / (zspeed * 2))) * timescale;
;
image_angle = direction;
;
var __fr_other6=scrFROther(other);
target_x = __fr_other6.target_x;
;
var __fr_other7=scrFROther(other);
target_y = __fr_other7.target_y;
;
var __fr_other8=scrFROther(other);
team = __fr_other8.team;
;
var __fr_other9=scrFROther(other);
creator = __fr_other9;
;
var __fr_other10=scrFROther(other);
hitid = __fr_other10.hitid;
;
{ var __fr_with11 = scrFRWithValues(scrFRBindDraw(fr_Objects_Frontier_Labs_mod_gml_MortarJunk_warningDraw, (- 1), target_x, target_y)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
speen = scrFRSourceRandom(360);
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
}
}
if(__fr_break13) break;
}}
}
}
if(__fr_break3) break;
}}
repeat (8) {
{ var __fr_with15 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
direction = scrFRSourceRandom(360);
;
var __fr_other18=scrFROther(other);
depth = (__fr_other18.depth - 1);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break17) break;
}}
}
scrFRSoundPitch(sndExplosionS, (0.8 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosion, (1.5 + scrFRSourceRandom(0.2)));
;
spr_idle = spr_idle_nrml;
;
spr_walk = spr_walk_nrml;
;
spr_hurt = spr_hurt_nrml;
;
spr_dead = spr_dead_nrml;
;
mask_index = msk_nrml;
;
}
} else {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(85)), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
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
if ((fr_Objects_Frontier_Labs_mod_gml_chance(2, 3) && (loading == false))) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1526
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_alrm2() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
}

// Original Objects/Frontier_Labs.mod.gml:1529
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_death() {
scrFRPickupDrop(55, 15);
;
}

// Original Objects/Frontier_Labs.mod.gml:1532
function fr_Objects_Frontier_Labs_mod_gml_VesselMortar_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_VesselMortar_create(_frl__x, _frl__y, false)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
loading = false;
;
loaded = true;
;
spr_idle = spr_idle_loaded;
;
spr_walk = spr_walk_loaded;
;
spr_hurt = spr_hurt_loaded;
;
spr_dead = spr_dead_loaded;
;
mask_index = msk_loaded;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(10)), "=");
;
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
possess_target = __fr_other7;
;
possessing = true;
;
depth = (- 2);
;
image_alpha = 0;
;
image_angle = 0;
;
mask_index = mskNone;
;
possessionCreds -= 1;
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1553
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Coreaphee";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselOrbiterDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "COREAPHEE"];
spr_shadow = shd24;
;
spr_shadow_y = 10;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
;
right = 1;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndCoreapheeHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndCoreapheeDead;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskVesselOrbiter;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 14, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (2.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 2;
;
canmelee = 1;
;
meleedamage = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
currentOrbitals = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1606
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
}

// Original Objects/Frontier_Labs.mod.gml:1623
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (70 + scrFRSourceIRandom(20)), "=");
;
if ((currentOrbitals < 3)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(3, 4)) {
{
currentOrbitals += 1;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_create(x, y, (scrFROther(other)), scrFRSourceRandom(360))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
maxDist = (20 + scrFRSourceIRandom(25));
;
orbitSpeed = (2 + scrFRSourceRandom(3));
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(sprEnemyBulletHit);
;
depth = (- 2);
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 42)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
} else {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:1659
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_death() {
scrFRPickupDrop(20, 0);
;
}

// Original Objects/Frontier_Labs.mod.gml:1662
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_VesselOrbiter_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
possess_target = __fr_other7;
;
possessing = true;
;
depth = (- 2);
;
image_alpha = 0;
;
image_angle = 0;
;
mask_index = mskNone;
;
possessionCreds -= 1;
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1676
function fr_Objects_Frontier_Labs_mod_gml_VesselCharger_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Charger Vessel";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerDead;
;
;
spr_tell = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerTell;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Labs"].sprVesselChargerChrg;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "RAMMR"];
spr_shadow = shd32;
;
spr_shadow_y = 5;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrDead;
;
snd_charge = global.fr_module_vars[$ "mod:Frontier_Labs"].sndRammrRam;
;
mask_index = mskSnowBot;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
;
canmelee = 1;
;
normal_damage = 2;
;
charge_damage = 4;
;
meleedamage = normal_damage;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
charge = 0;
;
charge_wait = 0;
;
charge_dir = 0;
;
charge_speed = 0;
;
charge_tokens = 3;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselCharger_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_VesselCharger_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_VesselCharger_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1737
function fr_Objects_Frontier_Labs_mod_gml_VesselCharger_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((((sprite_index != spr_chrg) && (sprite_index != spr_tell)) || frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
}
}
if (((charge > 0) || (charge_wait > 0))) {
{
direction = charge_dir;
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
if ((charge_wait > 0)) {
{
charge_wait -= scrFRSourceScale();
;
x += ((fr_Objects_Frontier_Labs_mod_gml_orandom(1) - lengthdir_x((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
y += ((fr_Objects_Frontier_Labs_mod_gml_orandom(1) - lengthdir_y((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
}
}
if ((charge_wait <= 0)) {
{
scrFRSoundPitch(snd_charge, (0.9 + scrFRSourceRandom(0.2)));
;
}
}
}
} else {
if ((charge > 0)) {
{
charge_speed -= (0.25 * scrFRSourceScale());
;
if ((charge_speed <= 0)) {
{
meleedamage = normal_damage;
;
charge = 0;
;
}
}
scrFRMotionAdd(direction, charge_speed);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall)) {
{
meleedamage = normal_damage;
;
charge_speed = 0;
;
charge = 0;
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 0.8;
;
image_yscale = 0.8;
;
}
}
if(__fr_break6) break;
}}
scrFRSoundPitch(sndBouncerBounce, (0.7 + scrFRSourceRandom(0.1)));
scrFRInstanceCreate(x, y, Dust);
;
}
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:1821
function fr_Objects_Frontier_Labs_mod_gml_VesselCharger_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 144)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(3, 4)) {
{
if ((charge_tokens > 0)) {
{
charge_tokens -= 1;
;
meleedamage = charge_damage;
;
charge = 20;
;
charge_wait = 7;
;
charge_dir = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
charge_speed = 6;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + 5), "=");
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (45 + scrFRSourceIRandom(10)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + 180) + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
charge_tokens += 3;
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
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:1855
function fr_Objects_Frontier_Labs_mod_gml_VesselCharger_death() {
scrFRPickupDrop(45, 8);
}

// Original Objects/Frontier_Labs.mod.gml:1858
function fr_Objects_Frontier_Labs_mod_gml_VesselCharger_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_VesselCharger_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(10)), "=");
;
{ var __fr_with4 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_Voltergeist_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
possess_target = __fr_other7;
;
possessing = true;
;
depth = (- 2);
;
image_alpha = 0;
;
image_angle = 0;
;
mask_index = mskNone;
;
possessionCreds -= 1;
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:1872
function fr_Objects_Frontier_Labs_mod_gml_Cremator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Cremator";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorDead;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorFire;
;
spr_idle_pos = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedIdle;
;
spr_walk_pos = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedWalk;
;
spr_fire_pos = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorPossessedFire;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "CREMATOR"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Labs"].shdCremator;
;
spr_shadow_y = 5;
;
fr_glow = [32, 48];
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndCrematorHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndCrematorDead;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskCremator;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 1;
;
meleedamage = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
ammo = 0;
;
possessed = false;
;
firing = 0;
;
spd = 0;
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (45 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Cremator_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_Cremator_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Cremator_alrm1];
;
on_possessed = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Cremator_possessed];
if (possessed) {
{
spr_idle = spr_idle_pos;
;
spr_walk = spr_walk_pos;
;
spr_fire = spr_fire_pos;
;
hitid = [spr_idle, "CREMATOR"];
maxspeed += (1) * timescale;
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

// Original Objects/Frontier_Labs.mod.gml:1944
function fr_Objects_Frontier_Labs_mod_gml_Cremator_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((sprite_index != spr_fire) || frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
}
}
if ((firing > 0)) {
{
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_fire);
;
}
}
}
}
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:1970
function fr_Objects_Frontier_Labs_mod_gml_Cremator_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, ((40 + scrFRSourceIRandom(20)) - (possessed * 12)), "=");
;
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 2, "=");
;
spd += 0.8;
;
scrFRSoundPitch(sndFireShotgun, (0.6 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndFireballerFire, (1.4 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_create(x, y, possessed)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + fr_Objects_Frontier_Labs_mod_gml_orandom(15));
;
var __fr_other5=scrFROther(other);
speed = ((3 + __fr_other5.spd)) * timescale;
image_angle = direction;
;
var __fr_other6=scrFROther(other);
team = __fr_other6.team;
;
var __fr_other7=scrFROther(other);
OGteam = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
var __fr_other9=scrFROther(other);
hitid = __fr_other9.hitid;
;
}
}
if(__fr_break3) break;
}}
repeat (scrFRSourceIRandom(2)) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapFire)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (((scrFROther(other)).possessed == true)) {
{
sprite_index = scrFRAreaSourceSprite(sprFireLilHunter);
;
}
}
var __fr_other13=scrFROther(other);
direction = (__fr_other13.gunangle + fr_Objects_Frontier_Labs_mod_gml_orandom(25));
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
image_angle = direction;
;
var __fr_other14=scrFROther(other);
team = __fr_other14.team;
;
var __fr_other15=scrFROther(other);
OGteam = __fr_other15.team;
;
var __fr_other16=scrFROther(other);
creator = __fr_other16;
;
var __fr_other17=scrFROther(other);
hitid = __fr_other17.hitid;
;
}
}
if(__fr_break12) break;
}}
}
repeat (2) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(16, (scrFROther(other)).gunangle)), (y + lengthdir_y(16, (scrFROther(other)).gunangle)), Smoke)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
var __fr_other21=scrFROther(other);
scrFRMotionAdd((__fr_other21.gunangle + fr_Objects_Frontier_Labs_mod_gml_orandom(5)), (2 + scrFRSourceRandom(3)));
;
image_xscale = (0.5 + scrFRSourceRandom(0.5));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break20) break;
}}
}
if (((-- ammo) <= 0)) {
{
image_index = 8;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((20 + scrFRSourceIRandom(20)) - (possessed * 10)), "=");
;
firing = 0;
;
spd = 0;
;
}
}
}
} else {
{
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if (((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 112) && fr_Objects_Frontier_Labs_mod_gml_chance(3, 4))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance < 160)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(4, 5)) {
{
scrFRSoundPitch(sndSalamanderCharge, 1.6);
scrFRInstanceCreate(x, (y + 4), HitWarning);
walk = 0;
;
gunangle = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
direction = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 14, "=");
;
ammo = 6;
;
firing = 1;
;
spd = 0;
;
}
} else {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), 20);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2070
function fr_Objects_Frontier_Labs_mod_gml_Cremator_death() {
scrFRPickupDrop(22, 15);
;
}

// Original Objects/Frontier_Labs.mod.gml:2073
function fr_Objects_Frontier_Labs_mod_gml_Cremator_possessed() {
possessed = true;
;
spr_idle = spr_idle_pos;
;
spr_walk = spr_walk_pos;
;
spr_fire = spr_fire_pos;
;
hitid = [spr_idle, "CREMATOR"];
maxspeed += (1) * timescale;
;
scrFRSoundPitchVolume(sndSwapCursed, (0.6 + scrFRSourceRandom(0.1)), 1);
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDust);
;
depth = (- 3);
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
}

// Original Objects/Frontier_Labs.mod.gml:2102
function fr_Objects_Frontier_Labs_mod_gml_GraveyardAssassin_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, MeleeBandit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSnowAssassinDead;
;
hitid = [spr_idle, "ASSASSIN"];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:2115
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Swarmer";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotDead;
;
spr_launched = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotFired;
;
spr_tell = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotChrg;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotChrg;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "SWARMER"];
spr_shadow = shd24;
;
spr_shadow_y = (- 3);
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerDead;
;
snd_chrg = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge;
;
snd_chrg2 = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge2;
;
snd_chrg3 = global.fr_module_vars[$ "mod:Frontier_Labs"].sndSwarmerCharge3;
;
mask_index = mskFreak;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 9, "=");
;
hp = max_hp;
;
raddrop = 2;
;
maxspeed = (3.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 1;
;
meleedamage = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
launched = false;
;
launchAngle = 0;
;
launchspeed = 10;
;
commander = false;
;
myCommander = noone;
;
commanderMaxDis = 48;
;
commAvailable = false;
;
charge_tokens = 0;
;
charge = 0;
;
charge_wait = 0;
;
charge_dir = 0;
;
attackZone = [10016, 10016];
;
charge_speed = 0;
;
fr_possessable = true;
;
fr_possessed = false;
;
dropPercent = 14;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Swarmbot_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_Swarmbot_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Swarmbot_alrm1];
;
on_possessed = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Swarmbot_possessed];
;
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_SwarmbotController")) == 0)) {
{
fr_Objects_Frontier_Labs_mod_gml_SwarmbotController_create(10016, 10016);
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

// Original Objects/Frontier_Labs.mod.gml:2194
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((((sprite_index != spr_chrg) && (sprite_index != spr_launched)) || frMacro_Objects_Frontier_Labs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
}
}
if (((charge > 0) || (charge_wait > 0))) {
{
direction = charge_dir;
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
if ((charge_wait > 0)) {
{
charge_wait -= scrFRSourceScale();
;
x += ((fr_Objects_Frontier_Labs_mod_gml_orandom(1) - lengthdir_x((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
y += ((fr_Objects_Frontier_Labs_mod_gml_orandom(1) - lengthdir_y((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
if ((charge_wait <= 0)) {
{
fr_Objects_Frontier_Labs_mod_gml_sound_play_hit_ext(scrFRSourceChoose(snd_chrg, snd_chrg2, snd_chrg3), (0.8 + scrFRSourceRandom(0.2)), 1);
;
}
}
}
} else {
if ((charge > 0)) {
{
charge -= scrFRSourceScale();
;
charge_speed -= (0.2 * scrFRSourceScale());
;
if ((charge_speed <= 0)) {
{
charge = 0;
;
}
}
scrFRMotionAdd(direction, charge_speed);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + scrFRSourceChoose((- 1), 1));
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
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
if (launched) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 20, "=");
;
maxspeed = (launchspeed) * timescale;
;
sprite_index = scrFRAreaSourceSprite(spr_launched);
;
direction = launchAngle;
;
speed = (launchspeed) * timescale;
;
if (frMacro_Objects_Frontier_Labs_mod_gml_current_frame_active) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
growspeed = (- 0.08);
;
image_alpha = 0.80;
;
}
}
if(__fr_break7) break;
}}
}
}
if (((scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall) || scrFRPlaceMeeting(x, y, Player)) || (hp < max_hp))) {
{
scrFRSoundPitch(sndMeleeWall, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndBouncerBounce, (1.3 + scrFRSourceRandom(0.1)));
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
depth = (- 3);
;
}
}
if(__fr_break10) break;
}}
repeat (5) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
direction = scrFRSourceRandom(360);
;
speed = (4) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
repeat (2) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmerEggDebris);
;
mask_index = mskNone;
;
speed = (2) * timescale;
;
}
}
if(__fr_break16) break;
}}
}
image_angle = 0;
;
launched = 0;
;
spr_shadow = shd24;
;
maxspeed = (walkspeed) * timescale;
;
}
}
}
}
if ((commander == true)) {
{
if ((array_length(scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", scrFRSelf(self))) >= 4)) {
{
commAvailable = false;
;
}
} else {
{
commAvailable = true;
;
var _frl__nearestRecruit = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", noone));
if (scrFRInstanceExists(_frl__nearestRecruit)) {
{
{ var __fr_with17 = scrFRWithValues(_frl__nearestRecruit), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
var __fr_other20=scrFROther(other);
myCommander = __fr_other20;
;
}
}
if(__fr_break19) break;
}}
}
}
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:2342
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(5)), "=");
;
if ((commander == false)) {
{
if ((charge_tokens <= 0)) {
{
if (scrFRInstanceExists(myCommander)) {
{
if ((distance_to_object(myCommander) > commanderMaxDis)) {
{
direction = point_direction(x, y, myCommander.x, myCommander.y);
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(1, 2)) {
{
direction = scrFRSourceRandom(360);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
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
charge_tokens -= 1;
;
charge = 8;
;
charge_dir = point_direction(x, y, scrFRIndexGet(attackZone, 0), scrFRIndexGet(attackZone, 1));
;
charge_wait = 2;
;
charge_speed = 4;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + 5), "=");
;
if ((charge_tokens <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 30, "=");
;
}
}
}
}
}
} else {
{
if ((charge_tokens <= 0)) {
{
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 72)) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(3, 4)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(4, 5)) {
{
attackZone = [target.x, target.y];
;
charge_tokens = (3 + scrFRSourceIRandom(2));
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", scrFRSelf(self))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
charge_tokens = __fr_other4.charge_tokens;
var __fr_other5=scrFROther(other);
attackZone = __fr_other5.attackZone;
;
}
}
if(__fr_break3) break;
}}
charge = 8;
;
charge_dir = point_direction(x, y, scrFRIndexGet(attackZone, 0), scrFRIndexGet(attackZone, 1));
;
charge_wait = 2;
;
charge_speed = 5;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + 5), "=");
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(1, 2)) {
{
direction = scrFRSourceRandom(360);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}
} else {
{
charge_tokens -= 1;
;
charge = 8;
;
charge_dir = point_direction(x, y, scrFRIndexGet(attackZone, 0), scrFRIndexGet(attackZone, 1));
;
charge_wait = 2;
;
charge_speed = 5;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + 5), "=");
;
if ((charge_tokens <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 30, "=");
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2425
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_death() {
scrFRPickupDrop(dropPercent, 0);
;
if ((commander == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", scrFRSelf(self))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
myCommander = noone;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2433
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_possessed() {
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), (1 / 0));
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedWalk;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Labs"].sprSwarmBotPossessedChrg;
;
hitid = [spr_idle, "POSSESSED#SWARMER"];
;
maxspeed += (1.5) * timescale;
;
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDust);
;
depth = (- 3);
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
}

// Original Objects/Frontier_Labs.mod.gml:2465
function fr_Objects_Frontier_Labs_mod_gml_SwarmbotController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SwarmbotController";
;
on_step = fr_Objects_Frontier_Labs_mod_gml_SwarmbotController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:2474
function fr_Objects_Frontier_Labs_mod_gml_SwarmbotController_step() {
if ((array_length(scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "commAvailable", true)) <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instance_random, scrFRMatching(scrFRMatching(enemy, "name", "Swarmer"), "myCommander", noone))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
commander = true;
;
myCommander = scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2482
function fr_Objects_Frontier_Labs_mod_gml_Swarmbot_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_Swarmbot_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
repeat (3) {
fr_Objects_Frontier_Labs_mod_gml_Swarmbot_create(x, y);
;
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:2489
function fr_Objects_Frontier_Labs_mod_gml_Engineer_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Engineer";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerDead;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerCannon;
;
spr_weap_melee = global.fr_module_vars[$ "mod:Frontier_Labs"].sprEngineerWrench;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "ENGINEER"];
spr_shadow = shd24;
;
spr_shadow_y = 1;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
snd_hurt = sndNecromancerHurt;
;
snd_dead = sndNecromancerDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
raddrop = 6;
;
maxspeed = (2.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = 0;
;
meleedamage = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
wepangle = 110;
;
meleeMode = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Engineer_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_Engineer_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_Engineer_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Engineer_alrm1];
;
on_alrm2 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Engineer_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:2547
function fr_Objects_Frontier_Labs_mod_gml_Engineer_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Labs_mod_gml_alarm2_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((distance_to_object(target) < 60) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
if ((meleeMode == false)) {
{
meleeMode = true;
scrFRInstanceCreate((x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)), WepSwap);
;
scrFRSoundPitchVolume(sndSwapHammer, 1, 0.6);
;
}
}
if ((scrFRSourceRandom(5) < 1)) {
{
scrFRInstanceCreate(x, y, NTTEFullSweat);
;
}
}
}
} else {
{
if ((meleeMode == true)) {
{
meleeMode = false;
;
scrFRInstanceCreate((x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)), WepSwap);
;
scrFRSoundPitchVolume(sndSwapExplosive, 1, 0.6);
;
}
}
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Labs.mod.gml:2585
function fr_Objects_Frontier_Labs_mod_gml_Engineer_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(20)), "=");
;
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if ((meleeMode == false)) {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 192)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
} else {
{
if ((fr_Objects_Frontier_Labs_mod_gml_chance(2, 3) && (frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 60))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (100 + scrFRSourceIRandom(20)), "=");
;
gunangle = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
scrFRSoundPitch(sndGrenadeRifle, (1.3 + scrFRSourceRandom(0.2)));
;
wkick = 12;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_Swarmbot_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
launchAngle = __fr_other4.gunangle;
;
image_angle = launchAngle;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6;
;
launched = true;
;
givekill = 0;
;
raddrop = 0;
;
spr_shadow = mskNone;
;
}
}
if(__fr_break3) break;
}}
repeat (12) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, (scrFROther(other)).gunangle)), (y + lengthdir_y(10, (scrFROther(other)).gunangle)), Smoke)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
var __fr_other10=scrFROther(other);
scrFRMotionAdd((__fr_other10.gunangle + scrFRSourceRandomRange((- 10), 10)), (2 + scrFRSourceRandom(2)));
}
}
if(__fr_break9) break;
}}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
}
}
}
} else {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance < 60)) {
{
if ((fr_Objects_Frontier_Labs_mod_gml_chance(2, 3) && (frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 4))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(15)), "=");
;
scrFRInstanceCreate(x, y, HitWarning);
scrFRAlarmWrite(scrFRSelf(self), 2, 10, "=");
;
gunangle = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
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
if (fr_Objects_Frontier_Labs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2671
function fr_Objects_Frontier_Labs_mod_gml_Engineer_alrm2() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemySlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
damage = 3;
;
speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 3), 3));
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5;
;
var __fr_other6=scrFROther(other);
team = __fr_other6.team;
var __fr_other7=scrFROther(other);
hitid = __fr_other7.hitid;
;
}
}
if(__fr_break3) break;
}}
scrFRMotionAdd(gunangle, 3.5);
;
wkick = (- 4);
;
wepangle *= (- 1);
;
scrFRSoundPlay(sndAssassinAttack);
;
scrFRSoundPitch(sndWrench, (0.7 + scrFRSourceRandom(0.3)));
;
}

// Original Objects/Frontier_Labs.mod.gml:2687
function fr_Objects_Frontier_Labs_mod_gml_Engineer_draw() {
if ((meleeMode == false)) {
{
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
} else {
{
if ((gunangle <= 180)) {
{
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap_melee, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle > 180)) {
{
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap_melee, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2707
function fr_Objects_Frontier_Labs_mod_gml_Engineer_death() {
scrFRPickupDrop(55, 0);
}

// Original Objects/Frontier_Labs.mod.gml:2710
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Bombardier";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDroneDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "BOMBARDIER"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Labs"].shdMissileDrone;
;
spr_shadow_y = 0;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierDead;
;
snd_fire = global.fr_module_vars[$ "mod:Frontier_Labs"].sndBombardierFire;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskMissileDrone;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 2;
;
canmelee = 0;
;
meleedamage = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
ammo = 0;
;
laserAngle = 0;
;
fr_possessable = true;
;
fr_possessed = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_MissileDrone_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_MissileDrone_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_MissileDrone_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_MissileDrone_alrm1];
;
on_alrm2 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_MissileDrone_alrm2];
;
on_possessed = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_MissileDrone_possessed];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:2770
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Labs_mod_gml_alarm2_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((laserAngle < 6)) {
{
laserAngle += scrFRSourceScale();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2795
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if ((fr_Objects_Frontier_Labs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Labs_mod_gml_target_visible)) {
{
if ((scrFRAlarmRead(scrFRSelf(self), 2) <= 0)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance < 48)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(10)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(((frMacro_Objects_Frontier_Labs_mod_gml_target_direction - 180) + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
;
}
}
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 272)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
;
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(4, 5)) {
{
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_distance > 48)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (90 + scrFRSourceIRandom(20)), "=");
;
gunangle = frMacro_Objects_Frontier_Labs_mod_gml_target_direction;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 25, "=");
;
laserAngle = 0;
;
ammo = 6;
;
fr_Objects_Frontier_Labs_mod_gml_enemy_face(gunangle);
;
walk = 0;
;
scrFRSoundPitch(sndSniperTarget, (0.5 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndIDPDNadeAlmost, (0.5 + scrFRSourceRandom(0.3)));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(25)), "=");
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
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
} else {
{
if ((fr_Objects_Frontier_Labs_mod_gml_chance(3, 5) && (scrFRAlarmRead(scrFRSelf(self), 2) <= 0))) {
{
direction = scrFRSourceRandom(360);
;
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2849
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_alrm2() {
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
scrFRSoundPitchVolume(sndRocket, (1.1 + scrFRSourceRandom(0.2)), 0.75);
;
var _frl__sound = audio_play_sound(snd_fire, 0, 0);
;
audio_sound_pitch(_frl__sound, (0.75 + scrFRRandomNonsync(0.25)));
;
audio_sound_gain(_frl__sound, (0.3 + scrFRRandomNonsync(0.15)), 0);
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_LabsRocket_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
var __fr_other5=scrFROther(other);
direction = (__fr_other5.gunangle + scrFRSourceRandomRange((- 10), 10));
image_angle = direction;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, (y + 5), Smoke)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
depth = (__fr_other10.depth - 1);
;
var __fr_other11=scrFROther(other);
direction = __fr_other11.gunangle;
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break9) break;
}}
if (((-- ammo) <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (100 + scrFRSourceIRandom(20)), "=");
;
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2881
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((scrFRAlarmRead(scrFRSelf(self), 2) > 0)) {
{
draw_set_color(make_color_rgb(250, 54, 0));
;
frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.draw_lasersight, x, y, gunangle, 1000, 2);
;
draw_set_alpha(0.5);
;
frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.draw_lasersight, x, y, (gunangle + (laserAngle / 1.5)), 1000, 1);
;
frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.draw_lasersight, x, y, (gunangle - (laserAngle / 1.5)), 1000, 1);
;
draw_set_color(c_white);
;
draw_set_alpha(1);
}
}
}

// Original Objects/Frontier_Labs.mod.gml:2894
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_death() {
scrFRPickupDrop(40, 15);
;
}

// Original Objects/Frontier_Labs.mod.gml:2897
function fr_Objects_Frontier_Labs_mod_gml_MissileDrone_possessed() {
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), (1 / 0));
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDronePossessedIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Labs"].sprMissileDronePossessedWalk;
;
hitid = [spr_idle, "POSSESSED#BOMBARDIER"];
;
maxspeed += (1) * timescale;
;
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistLightning, _frl__variant));
;
depth = (- 3);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprVoltergeistDust);
;
depth = (- 3);
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
}

// Original Objects/Frontier_Labs.mod.gml:2928
function fr_Objects_Frontier_Labs_mod_gml_Honeypot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Honeypot";
image_blend = c_red;
;
spr_idle = sprBigMaggotIdle;
;
spr_walk = sprBigMaggotIdle;
;
spr_hurt = sprBigMaggotHurt;
;
spr_dead = sprBigMaggotDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "HONEYPOT"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Labs"].shdCremator;
;
spr_shadow_y = 5;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = sndTurretHurt;
;
snd_dead = sndTurretDead;
;
mask_index = mskBigMaggot;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 20, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (3.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 2;
;
canmelee = 1;
;
meleedamage = 1;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
healingRange = 64;
;
healCooldown = 75;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Honeypot_step];
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Labs_mod_gml_Honeypot_death;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_Honeypot_alrm1];
;
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_HoneypotController")) == 0)) {
{
fr_Objects_Frontier_Labs_mod_gml_HoneypotController_create(10016, 10016);
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

// Original Objects/Frontier_Labs.mod.gml:2988
function fr_Objects_Frontier_Labs_mod_gml_Honeypot_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Labs_mod_gml_enemy_sprite);
;
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
var _frl__woundedNearMe = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instances_in_rectangle, (x - healingRange), (y - healingRange), (x + healingRange), (y + healingRange), scrFRMatching(enemy, "fr_Wounded", true));
;
if ((array_length(_frl__woundedNearMe) > 0)) {
{
if ((healCooldown > 0)) {
{
healCooldown -= scrFRSourceScale();
;
}
}
if ((healCooldown <= 0)) {
{
healCooldown += 75;
;
{ var __fr_with1 = scrFRWithValues(_frl__woundedNearMe), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
hp += round((max_hp / 5));
;
if ((hp > max_hp)) {
{
hp = max_hp;
;
}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, UGPlantHeal)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprHoneypotHeal);
var __fr_other7=scrFROther(other);
depth = (__fr_other7.depth - 1);
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with9 = scrFRWithValues(_frl__woundedNearMe), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
var __fr_other12=scrFROther(other);
fr_Objects_Frontier_Labs_mod_gml_HoneypotHealParticle_create((__fr_other12.x + fr_Objects_Frontier_Labs_mod_gml_orandom(16)), (__fr_other12.y + fr_Objects_Frontier_Labs_mod_gml_orandom(16)), scrFRSelf(self));
;
}
}
}
}
if(__fr_break11) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3040
function fr_Objects_Frontier_Labs_mod_gml_Honeypot_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (15 + scrFRSourceIRandom(10)), "=");
;
var _frl__nearestWounded = frMacro_Objects_Frontier_Labs_mod_gml_call(frMacro_Objects_Frontier_Labs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(scrFRMatching(enemy, "team", team), "fr_Wounded", true));
if ((! scrFRInstanceExists(_frl__nearestWounded))) {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
} else {
{
target = _frl__nearestWounded;
;
if ((frMacro_Objects_Frontier_Labs_mod_gml_target_visible && (frMacro_Objects_Frontier_Labs_mod_gml_target_distance > (healingRange - (healingRange / 3))))) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_look(frMacro_Objects_Frontier_Labs_mod_gml_target_direction);
;
if (fr_Objects_Frontier_Labs_mod_gml_chance(4, 5)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Labs_mod_gml_target_direction + fr_Objects_Frontier_Labs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Labs_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Labs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Labs_mod_gml_enemy_look(direction);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3065
function fr_Objects_Frontier_Labs_mod_gml_Honeypot_death() {
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprBloodStreak);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
}
fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_create(x, y);
}

// Original Objects/Frontier_Labs.mod.gml:3079
function fr_Objects_Frontier_Labs_mod_gml_HoneypotController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_HoneypotController";
;
on_step = fr_Objects_Frontier_Labs_mod_gml_HoneypotController_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3085
function fr_Objects_Frontier_Labs_mod_gml_HoneypotController_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(enemy, "name", "Honeypot")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((hp < max_hp)) {
{
fr_Wounded = true;
;
}
} else {
{
fr_Wounded = false;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3096
function fr_Objects_Frontier_Labs_mod_gml_FreakShell_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Freak Shell";
dir = scrFRSourceChoose((- 1), 1);
spr_warn = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellWarning;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellFall;
;
spr_land = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellHurt;
;
spr_dead = sprMutantTubeDead;
;
spr_opening = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpening;
spr_open = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpen;
;
spr_openhurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFreakShellOpenHurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
image_angle = (scrFRSourceRandomRange(30, 45) * (- dir));
;
image_xscale = dir;
;
depth = (- 10);
;
spr_shadow = mskNone;
;
hitid = [spr_idle, "FREAK SHELL"];
height = 700;
;
x_height = (700 * dir);
;
spr_warn_y = 12;
;
flightAngle = image_angle;
;
warnspin = 0;
;
snd_hurt = sndTurretHurt;
;
snd_dead = sndTurretDead;
;
mask_index = mskNone;
;
scrFRMaxHealthWrite(id, 40, "=");
;
hp = max_hp;
;
size = 3;
;
freaks = (12 + scrFRSourceIRandom(6));
;
landed = false;
;
open = false;
;
FREAKED_OUT = false;
;
openTimer = 40;
;
freakTimer = 25;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 0, "=");
;
on_step = fr_Objects_Frontier_Labs_mod_gml_FreakShell_step;
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_FreakShell_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Prop_hurt;
;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_FreakShell_destroy;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_FreakShell_alrm1];
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3150
function fr_Objects_Frontier_Labs_mod_gml_FreakShell_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if (frMacro_Objects_Frontier_Labs_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((height > 0)) {
{
warnspin += (4 * scrFRSourceScale());
;
height -= (20 * scrFRSourceScale());
;
x_height -= ((20 * dir) * scrFRSourceScale());
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + x_height), (y - height), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
depth = (- 10);
;
image_xscale = (1 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_alpha = 0.6;
;
}
}
if(__fr_break3) break;
}}
}
}
if (((height <= 0) && (landed == false))) {
{
spr_idle = spr_land;
;
landed = true;
;
mask_index = sprMutantTube;
;
spr_shadow = shd48;
;
depth = 0;
;
repeat ((5 + scrFRSourceRandom(4))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(4))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
repeat ((2 + scrFRSourceRandom(2))) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 18), 18)), (y + scrFRSourceRandomRange((- 10), 18)), Scorch);
;
}
repeat ((3 + scrFRSourceRandom(2))) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 18), 18)), (y + scrFRSourceRandomRange((- 10), 18)), MeltSplat);
;
}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, (y + 12), Explosion)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
hitid = __fr_other10.hitid;
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitch(sndExplosionCar, (1.3 + scrFRSourceRandom(0.2)));
}
}
if (((landed == true) && (openTimer > 0))) {
{
openTimer -= scrFRSourceScale();
;
}
}
if (((openTimer <= 0) && (open == false))) {
{
open = true;
;
sprite_index = scrFRAreaSourceSprite(spr_opening);
;
spr_idle = spr_open;
;
spr_hurt = spr_openhurt;
;
scrFRSoundPitchVolume(sndToxicBoltGas, (0.6 + scrFRSourceRandom(0.1)), 0.5);
repeat (8) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
var __fr_other14=scrFROther(other);
direction = (90 + scrFRSourceRandom((50 * (- __fr_other14.dir))));
;
speed = ((1 + scrFRSourceRandom(3))) * timescale;
;
image_alpha = 0.8;
;
}
}
if(__fr_break13) break;
}}
}
}
}
if (((freakTimer > 0) && (open == true))) {
{
freakTimer -= scrFRSourceScale();
;
}
}
if ((((open == true) && (FREAKED_OUT == false)) && (freakTimer <= 0))) {
{
FREAKED_OUT = true;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 2, "=");
;
}
}
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with15 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
var __fr_other18=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other18.spr_dead);
;
var __fr_other19=scrFROther(other);
image_xscale = __fr_other19.image_xscale;
;
var __fr_other20=scrFROther(other);
size = __fr_other20.size;
;
}
}
if(__fr_break17) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3248
function fr_Objects_Frontier_Labs_mod_gml_FreakShell_draw() {
if ((height > 0)) {
{
scrFRDrawSpriteExt(spr_warn, image_index, x, (y + spr_warn_y), 1, 1, warnspin, image_blend, image_alpha);
scrFRDrawSpriteExt(spr_warn, image_index, x, (y + spr_warn_y), 1.1, 1.1, warnspin, image_blend, 0.3);
}
}
scrFRDrawSpriteExt(sprite_index, image_index, (x + x_height), (y - height), image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

// Original Objects/Frontier_Labs.mod.gml:3255
function fr_Objects_Frontier_Labs_mod_gml_FreakShell_destroy() {
scrFRSoundPitch(sndExplosionL, (1.3 + scrFRSourceRandom(0.2)));
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
}

// Original Objects/Frontier_Labs.mod.gml:3261
function fr_Objects_Frontier_Labs_mod_gml_FreakShell_alrm1() {
if ((freaks > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (1 + scrFRSourceIRandom(3)), "=");
;
freaks -= 1;
;
var _frl__dir = dir;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - 6), Freak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_switch_value7=_frl__dir, __fr_switch_case8=-1;
if(__fr_switch_case8==-1 && __fr_switch_value7==(1)) __fr_switch_case8=0;
if(__fr_switch_case8==-1 && __fr_switch_value7==((- 1))) __fr_switch_case8=1;
if(__fr_switch_case8==-1) __fr_switch_case8=-1;
switch(__fr_switch_case8) {
case 0:
direction = (0 + scrFRSourceRandomRange((- 40), 40));
break;
;
case 1:
direction = (180 + scrFRSourceRandomRange((- 40), 40));
break;
;
}
}
speed = (3) * timescale;
;
zspeed = (4 + scrFRSourceRandom(2));
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
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3291
function fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Rhino Freak Shell";
dir = scrFRSourceChoose((- 1), 1);
spr_warn = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellWarning;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellFall;
;
spr_land = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellHurt;
;
spr_dead = sprMutantTubeDead;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellOpen;
;
spr_openhurt = global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellOpenHurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
image_angle = (scrFRSourceRandomRange(25, 45) * (- dir));
;
image_xscale = dir;
;
depth = (- 10);
;
spr_shadow = mskNone;
;
hitid = [spr_idle, "FREAK SHELL"];
height = 1050;
;
x_height = (1050 * dir);
;
spr_warn_y = 20;
;
flightAngle = image_angle;
;
warnspin = 0;
;
snd_hurt = sndTurretHurt;
;
snd_dead = sndTurretDead;
;
mask_index = mskNone;
;
scrFRMaxHealthWrite(id, 90, "=");
;
hp = max_hp;
;
size = 5;
;
freaks = (5 + scrFRSourceIRandom(3));
;
landed = false;
;
open = false;
;
FREAKED_OUT = false;
;
openTimer = 40;
;
freakTimer = 25;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 0, "=");
;
on_step = fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_step;
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_FreakShell_draw;
;
on_hurt = fr_Objects_Frontier_Labs_mod_gml_Prop_hurt;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_destroy;
;
on_alrm1 = ["mod", "Frontier_Labs", fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_alrm1];
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3344
function fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Labs_mod_gml_alarm1_run)) {
exit;
}
if (frMacro_Objects_Frontier_Labs_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((height > 0)) {
{
warnspin += (4 * scrFRSourceScale());
;
height -= (30 * scrFRSourceScale());
;
x_height -= ((30 * dir) * scrFRSourceScale());
;
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x + x_height) + scrFRSourceRandomRange((- 25), 25)), ((y - height) + scrFRSourceRandomRange((- 25), 25)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
depth = (- 10);
;
image_xscale = (1 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_alpha = 0.6;
;
}
}
if(__fr_break3) break;
}}
}
}
}
if (((height <= 0) && (landed == false))) {
{
spr_idle = spr_land;
;
landed = true;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Labs"].mskRhinoFreakShell;
;
spr_shadow = shd48;
;
depth = 0;
;
repeat ((8 + scrFRSourceRandom(4))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(4))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
repeat ((4 + scrFRSourceRandom(2))) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 45), 45)), ((y + 20) + scrFRSourceRandomRange((- 20), 20)), Scorch);
;
}
repeat ((5 + scrFRSourceRandom(2))) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 45), 45)), ((y + 20) + scrFRSourceRandomRange((- 20), 20)), MeltSplat);
;
}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, (y + 20), PortalClear)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_xscale = 1.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitch(sndExplosionL, (0.8 + scrFRSourceRandom(0.2)));
{
i = 0;
for (; (i < 360); i += 72) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, (y + 20), Explosion)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
hitid = __fr_other13.hitid;
;
}
}
if(__fr_break12) break;
}}
}
}
}
}
if (((landed == true) && (openTimer > 0))) {
{
openTimer -= scrFRSourceScale();
;
}
}
if (((openTimer <= 0) && (open == false))) {
{
open = true;
;
sprite_index = scrFRAreaSourceSprite(spr_open);
;
spr_idle = spr_open;
;
spr_hurt = spr_openhurt;
;
scrFRSoundPitch(sndToxicBoltGas, (0.6 + scrFRSourceRandom(0.1)));
scrFRSoundPitch(sndExplosionS, (0.8 + scrFRSourceRandom(0.1)));
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprRhinoFreakShellDoor);
;
var __fr_other17=scrFROther(other);
image_angle = __fr_other17.image_angle;
;
direction = (270 + scrFRSourceRandomRange((- 20), 20));
;
speed = ((5 + scrFRSourceRandom(3))) * timescale;
;
var __fr_other18=scrFROther(other);
depth = (__fr_other18.depth - 1);
;
}
}
if(__fr_break16) break;
}}
repeat (12) {
{ var __fr_with19 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprWhiteSmoke);
;
direction = scrFRSourceRandom(360);
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
image_alpha = 0.8;
;
}
}
if(__fr_break21) break;
}}
}
}
}
if (((freakTimer > 0) && (open == true))) {
{
freakTimer -= scrFRSourceScale();
;
}
}
if ((((open == true) && (FREAKED_OUT == false)) && (freakTimer <= 0))) {
{
FREAKED_OUT = true;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 2, "=");
;
}
}
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with22 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
var __fr_other25=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other25.spr_dead);
;
var __fr_other26=scrFROther(other);
image_xscale = __fr_other26.image_xscale;
;
var __fr_other27=scrFROther(other);
size = __fr_other27.size;
;
}
}
if(__fr_break24) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3460
function fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_destroy() {
scrFRSoundPitch(sndExplosionL, (0.8 + scrFRSourceRandom(0.2)));
{
i = 0;
for (; (i < 360); i += 72) {
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
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3468
function fr_Objects_Frontier_Labs_mod_gml_RhinoFreakShell_alrm1() {
if ((freaks > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (5 + scrFRSourceIRandom(5)), "=");
;
freaks -= 1;
;
var _frl__dir = dir;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y + lengthdir_y(10, image_angle)), RhinoFreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_alpha = 0;
;
var __fr_other4=scrFROther(other);
scrFRBindDraw(fr_Objects_Frontier_Labs_mod_gml_ShellFreak_draw, (__fr_other4.depth - 1), scrFRSelf(self));
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3482
function fr_Objects_Frontier_Labs_mod_gml_ShellFreak_draw(_frl__target=undefined) {
if ((! scrFRInstanceExists(_frl__target))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__target), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_alpha += (0.1 * scrFRSourceScale());
}
}
if(__fr_break3) break;
}}
if ((_frl__target.image_alpha >= 1)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3500
function fr_Objects_Frontier_Labs_mod_gml_BlasterShell_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BlasterShell";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlasterShell);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlasterShellDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprBlasterShellDisappear;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.2];
;
speed = (((10 + scrFRSourceRandom(2)) * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
friction = (0.35) * (timescale * timescale);
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
hitid = [sprite_index, "BLASTER SHELL"];
;
minspeed = 2;
;
hitList = [];
;
on_anim = fr_Objects_Frontier_Labs_mod_gml_BlasterShell_anim;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_BlasterShell_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_BlasterShell_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_BlasterShell_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3530
function fr_Objects_Frontier_Labs_mod_gml_BlasterShell_anim() {
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

// Original Objects/Frontier_Labs.mod.gml:3539
function fr_Objects_Frontier_Labs_mod_gml_BlasterShell_step() {
if ((scrFRSourceRandom(32) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLaserTrapBeamEnd);
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.direction;
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
scrFRMotionAdd(((__fr_other5.direction + 180) + fr_Objects_Frontier_Labs_mod_gml_orandom(10)), ((__fr_other5.speed / timescale) / 2));
}
}
if(__fr_break3) break;
}}
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

// Original Objects/Frontier_Labs.mod.gml:3556
function fr_Objects_Frontier_Labs_mod_gml_BlasterShell_hit() {
if ((scrFRArrayFindIndex(hitList, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, damage, direction);
;
var __fr_other2=scrFROther(other);
array_push(hitList, __fr_other2);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3562
function fr_Objects_Frontier_Labs_mod_gml_BlasterShell_wall() {
scrFRInstanceCreate(x, y, Smoke);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (((speed / timescale) * 0.6)) * timescale;
;
}

// Original Objects/Frontier_Labs.mod.gml:3573
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_create(_frl__x=undefined, _frl__y=undefined, _frl__charged=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CrematorShell";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShell);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappear;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappear;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.2];
;
fr_glow = [32, 48];
;
speed = (((10 + scrFRSourceRandom(2)) * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
friction = (0.25) * (timescale * timescale);
;
typ = 1;
;
damage = 1;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
OGteam = __fr_other6.team;
;
hitid = [sprite_index, "CREMATOR SHELL"];
;
minspeed = 2;
;
charged = _frl__charged;
;
if (charged) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellChrg);
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappearChrg;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Labs"].sprCrematorShellDisappearChrg;
;
}
}
on_anim = fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_anim;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_wall;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3611
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_anim() {
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
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

// Original Objects/Frontier_Labs.mod.gml:3621
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_step() {
if ((scrFRSourceRandom(16) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.direction + 180) + fr_Objects_Frontier_Labs_mod_gml_orandom(10)), ((__fr_other4.speed / timescale) / 2));
}
}
if(__fr_break3) break;
}}
}
}
if ((((speed / timescale) < minspeed) && (sprite_index != spr_fade))) {
{
fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_spreadcreep();
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

// Original Objects/Frontier_Labs.mod.gml:3636
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
var _frl_dmg = damage;
if (scrFRVariableExists((scrFROther(other)), "boilcap")) {
{
var __fr_other1=scrFROther(other);
_frl_dmg = min(damage, max(0, (__fr_other1.hp - (__fr_other1.boilcap * scrFRGetSkill(mut_boiling_veins)))));
}
}
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, _frl_dmg);
}
}
if ((! scrFRInstanceIs((scrFROther(other)), prop))) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3648
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_wall() {
scrFRInstanceCreate(x, y, Smoke);
;
if (((speed / timescale) > minspeed)) {
{
scrFRSoundHit(sndShotgunHitWall, 0.2);
;
}
}
move_bounce_solid(true);
;
image_angle = direction;
;
speed = (((speed / timescale) * 0.8)) * timescale;
;
}

// Original Objects/Frontier_Labs.mod.gml:3659
function fr_Objects_Frontier_Labs_mod_gml_CrematorProjectile_spreadcreep() {
scrFRSoundPitchVolume(sndExplosionS, (1.4 + scrFRSourceRandom(0.1)), 0.6);
;
scrFRSoundPitchVolume(sndFrogEggHurt, (1.3 + scrFRSourceRandom(0.1)), 0.4);
;
if ((charged == true)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_bubble = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameCreepBubbleCharged;
;
creep_color = make_color_rgb(15, 189, 255);
;
creep_color_2 = make_color_rgb(0, 114, 250);
;
image_blend = creep_color;
;
damage = 2;
;
maxSize = 1;
;
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.OGteam;
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
{ var __fr_with6 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_create(x, y)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
var __fr_other9=scrFROther(other);
hitid = __fr_other9.hitid;
;
var __fr_other10=scrFROther(other);
team = __fr_other10.OGteam;
;
}
}
if(__fr_break8) break;
}}
}
}
repeat (2) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
sprite_index = scrFRAreaSourceSprite((__fr_other14.charged ? global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameStreakCharged : global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameStreak));
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break13) break;
}}
}
}

// Original Objects/Frontier_Labs.mod.gml:3693
function fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CrematorCreep";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprCreep);
;
spr_bubble = global.fr_module_vars[$ "mod:Frontier_Labs"].sprFlameCreepBubble;
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
creep_color = make_color_rgb(252, 56, 0);
creep_color_2 = make_color_rgb(160, 30, 0);
image_blend = creep_color;
;
fr_bloom = [2, 0.1];
;
fr_glow = [0, 0];
;
underwater_fx = ((scrFRArrayFindIndex([101, "oasis"], GameCont.area) >= 0) || (scrFRSourceAreaIsString(GameCont.area) && (scrFRModCall("area", GameCont.area, "area_underwater") == true)));
;
speed = (0) * timescale;
;
typ = 0;
;
damage = 1;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "MOLTEN CREEP"];
;
lifetime = 120;
;
allGrownUp = false;
;
maxSize = 0.7;
;
fr_ignitePowder = true;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
scrFRBindDraw(fr_Objects_Frontier_Labs_mod_gml_CrematorCreepLow_draw, (depth + 1), scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3732
function fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
lifetime -= scrFRSourceScale();
;
fr_glow = [(32 * image_xscale), (48 * image_xscale)];
if (underwater_fx) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
scrFRInstanceCreate((x + fr_Objects_Frontier_Labs_mod_gml_orandom(16)), (y + fr_Objects_Frontier_Labs_mod_gml_orandom(16)), Bubble);
}
}
}
}
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
if (((allGrownUp == true) && (lifetime > 0))) {
{
image_xscale = (maxSize + fr_Objects_Frontier_Labs_mod_gml_orandom(0.02));
;
image_yscale = image_xscale;
;
if (frMacro_Objects_Frontier_Labs_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(20) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Labs_mod_gml_orandom((16 * maxSize))), (y + fr_Objects_Frontier_Labs_mod_gml_orandom((16 * maxSize))), PlasmaTrail)), __fr_break3=false;
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

// Original Objects/Frontier_Labs.mod.gml:3777
function fr_Objects_Frontier_Labs_mod_gml_CrematorCreep_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
var _frl__dmg = damage;
if (scrFRVariableExists((scrFROther(other)), "boilcap")) {
{
var __fr_other1=scrFROther(other);
_frl__dmg = min(damage, max(0, (__fr_other1.hp - (__fr_other1.boilcap * scrFRGetSkill(mut_boiling_veins)))));
}
}
if (scrFRInstanceIs((scrFROther(other)), prop)) {
{
_frl__dmg = (damage * 3);
}
}
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, _frl__dmg);
scrFRSoundPitchVolume(sndBurn, (0.8 + scrFRSourceRandom(0.3)), 0.7);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3790
function fr_Objects_Frontier_Labs_mod_gml_CrematorCreepLow_draw(_frl__creep=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:3799
function fr_Objects_Frontier_Labs_mod_gml_GatorCreep_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GatorCreep";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprGatorCreep);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = 4;
;
creep_color = make_color_rgb(133, 249, 26);
;
creep_color_2 = make_color_rgb(130, 189, 5);
;
image_blend = creep_color;
;
fr_bloom = [2, 0.1];
;
fr_glow = [0, 0];
;
speed = (0) * timescale;
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
hitid = [sprite_index, "GATOR CREEP"];
;
lifetime = 90;
;
allGrownUp = false;
;
glowSize = [16, 32];
;
maxSize = 1;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_GatorCreep_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_GatorCreep_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
scrFRBindDraw(fr_Objects_Frontier_Labs_mod_gml_CrematorCreepLow_draw, (depth + 1), scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3836
function fr_Objects_Frontier_Labs_mod_gml_GatorCreep_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
lifetime -= scrFRSourceScale();
;
fr_glow = [(scrFRIndexGet(glowSize, 0) * image_xscale), (scrFRIndexGet(glowSize, 1) * image_xscale)];
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
if (((allGrownUp == true) && (lifetime > 0))) {
{
image_xscale = (maxSize + fr_Objects_Frontier_Labs_mod_gml_orandom(0.02));
;
image_yscale = image_xscale;
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

// Original Objects/Frontier_Labs.mod.gml:3867
function fr_Objects_Frontier_Labs_mod_gml_GatorCreep_hit() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
x = (xprevious + (0.5 * (hspeed / timescale)));
;
y = (yprevious + (0.5 * (vspeed / timescale)));
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3873
function fr_Objects_Frontier_Labs_mod_gml_GatorCreepBig_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_GatorCreep_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprCreep);
;
maxSize = 1;
;
glowSize = [32, 48];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3883
function fr_Objects_Frontier_Labs_mod_gml_MortarJunk_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "lobbedJunk";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprServerBundle);
;
image_index = scrFRSourceIRandom(3);
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Labs"].sprServerBundleDebris;
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
speed = ((12 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
typ = 1;
;
damage = 1;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "TRASH"];
;
z = 0;
;
zspeed = 0;
;
zfriction = 1;
;
turnspeed = (3 + (scrFRSourceRandom(2) * scrFRSourceChoose((- 1), 1)));
;
target_x = 0;
;
target_y = 0;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_MortarJunk_step;
;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_MortarJunk_destroy;
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_MortarJunk_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:3915
function fr_Objects_Frontier_Labs_mod_gml_MortarJunk_step() {
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
image_angle += turnspeed;
;
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
image_angle -= (sign((hspeed / timescale)) * (abs(((vspeed / timescale) / 2)) + abs((hspeed / timescale))));
;
if ((z <= 12)) {
{
mask_index = mskSuperFlakBullet;
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
if (((speed / timescale) > 4)) {
speed = (4) * timescale;
}
}
}
scrFRInstanceDestroy();
;
}
} else {
{
friction = (0) * (timescale * timescale);
;
depth = (- 10);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:3961
function fr_Objects_Frontier_Labs_mod_gml_MortarJunk_destroy() {
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_debris);
;
direction = scrFRSourceRandom(360);
;
speed = (2) * timescale;
;
var __fr_other5=scrFROther(other);
hitid = __fr_other5.hitid;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((6 + scrFRSourceRandom(1))) * timescale;
;
var __fr_other9=scrFROther(other);
hitid = __fr_other9.hitid;
;
}
}
if(__fr_break8) break;
}}
}
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
hitid = __fr_other13.hitid;
;
}
}
if(__fr_break12) break;
}}
scrFRSoundPitch(sndExplosionL, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitchVolume(sndHitMetal, (0.7 + scrFRSourceRandom(0.2)), 0.4);
;
scrFRSoundPitchVolume(sndWallBreakScrap, (1.5 + scrFRSourceRandom(0.2)), 0.2);
;
}

// Original Objects/Frontier_Labs.mod.gml:3984
function fr_Objects_Frontier_Labs_mod_gml_MortarJunk_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 260)), (image_yscale + (z / 260)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Labs.mod.gml:3987
function fr_Objects_Frontier_Labs_mod_gml_MortarJunk_warningDraw(_frl__target_x=undefined, _frl__target_y=undefined) {
speen += (6 * scrFRSourceScale());
;
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
}
}
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLobbedJunkWarning, 0, _frl__target_x, _frl__target_y, 1, 1, speen, c_white, 1);
;
}

// Original Objects/Frontier_Labs.mod.gml:3995
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__angle=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_VesselOrbital";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprOrbiterBullet);
;
spr_destroy = sprEnemyBulletHit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Labs"].sprOrbiterBulletTrail;
;
image_speed = (0) * timescale;
;
depth = (- 10);
;
image_angle = scrFRSourceRandom(360);
;
speed = (0) * timescale;
;
fr_bloom = [1.4, 0.2];
;
hitid = _frl__creator.hitid;
;
image_xscale = 0;
;
image_yscale = 0;
;
mask_index = mskEnemyBullet1;
;
damage = 3;
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
typ = 0;
;
ammo_type = (- 1);
;
angle = _frl__angle;
;
dist = 0;
;
maxDist = 60;
;
orbitSpeed = (5 + scrFRSourceIRandom(3));
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_hit;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_step;
;
on_end_step = fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_endstep;
;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4035
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((image_xscale < 1)) {
{
image_xscale += (0.1 * scrFRSourceScale());
;
image_yscale = image_xscale;
;
}
}
if ((dist < maxDist)) {
{
dist += (0.5 * scrFRSourceScale());
;
}
}
if (frMacro_Objects_Frontier_Labs_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(2) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth + 1);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
angle += (orbitSpeed * scrFRSourceScale());
;
image_angle = angle;
}

// Original Objects/Frontier_Labs.mod.gml:4066
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_wall() {
xprevious = (x + (hspeed / timescale));
;
yprevious = (y + (vspeed / timescale));
;
}

// Original Objects/Frontier_Labs.mod.gml:4070
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_hit() {
if ((! scrFRInstanceIs((scrFROther(other)), prop))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other4.damage);
var __fr_other5=scrFROther(other);
lasthit = __fr_other5.hitid;
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

// Original Objects/Frontier_Labs.mod.gml:4079
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_endstep() {
if (scrFRInstanceExists(creator)) {
{
xprevious = (creator.x + lengthdir_x(dist, angle));
;
yprevious = (creator.y + lengthdir_y(dist, angle));
;
x = (creator.x + lengthdir_x(dist, angle));
;
y = (creator.y + lengthdir_y(dist, angle));
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:4087
function fr_Objects_Frontier_Labs_mod_gml_VesselOrbital_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_destroy);
;
}
}
if(__fr_break3) break;
}}
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
{ var __fr_with5 = scrFRWithValues(creator), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
currentOrbitals -= 1;
;
}
}
if(__fr_break7) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4096
function fr_Objects_Frontier_Labs_mod_gml_LabsRocket_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LabsRocket";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocket);
;
spr_flame = global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketFlame;
;
image_angle = scrFRSourceRandom(360);
;
speed = ((14 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
typ = 1;
;
damage = 1;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "MICROMISSILE"];
;
on_step = fr_Objects_Frontier_Labs_mod_gml_LabsRocket_step;
;
on_destroy = fr_Objects_Frontier_Labs_mod_gml_LabsRocket_destroy;
;
on_draw = fr_Objects_Frontier_Labs_mod_gml_LabsRocket_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4121
function fr_Objects_Frontier_Labs_mod_gml_LabsRocket_step() {
if (frMacro_Objects_Frontier_Labs_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 4), 4)), (y + scrFRSourceRandomRange((- 4), 4)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketTrail);
;
var __fr_other4=scrFROther(other);
direction = __fr_other4.direction;
;
speed = (2) * timescale;
;
image_xscale = 0.7;
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

// Original Objects/Frontier_Labs.mod.gml:4132
function fr_Objects_Frontier_Labs_mod_gml_LabsRocket_destroy() {
scrFRSoundPitchVolume(sndExplosion, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 0.8);
scrFRSoundPitchVolume(sndPlasma, (0.5 + scrFRSourceRandomRange(0.8, 1.3)), 1.2);
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_create(x, y)), __fr_break3=false;
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
}

// Original Objects/Frontier_Labs.mod.gml:4141
function fr_Objects_Frontier_Labs_mod_gml_LabsRocket_draw() {
scrFRDrawSpriteExt(spr_flame, (scrFRSourceFrame() * 0.4), x, y, 1, 1.2, image_angle, c_white, image_alpha);
;
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(spr_flame, (scrFRSourceFrame() * 0.4), x, y, (1.8 * image_xscale), (1.8 * image_yscale), image_angle, c_white, 0.2);
;
gpu_set_blendmode(bm_normal);
;
draw_self();
;
}

// Original Objects/Frontier_Labs.mod.gml:4148
function fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LabsRocketExplosion";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketExplosion);
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
fr_glow = [48, 96];
;
mask_index = mskSmallExplosion;
;
speed = (0) * timescale;
;
typ = 0;
;
damage = 2;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "MICROMISSILE EXPLOSION"];
;
hitList = [];
;
fr_ignitePowder = true;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4178
function fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_hit() {
if ((scrFRArrayFindIndex(hitList, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, damage, direction);
;
var __fr_other2=scrFROther(other);
array_push(hitList, __fr_other2);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:4184
function fr_Objects_Frontier_Labs_mod_gml_LabsRocketExplosion_step() {
if (((image_index + (image_speed / timescale)) >= image_number)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:4189
function fr_Objects_Frontier_Labs_mod_gml_HoneypotHealParticle_create(_frl__x=undefined, _frl__y=undefined, _frl__target=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_honeypotHealParticle";
sprite_index = scrFRAreaSourceSprite(sprPopoPlasmaTrail);
image_index = scrFRSourceIRandom(image_number);
;
depth = (- 7);
;
image_alpha = 1;
;
image_speed = (0) * timescale;
fr_bloom = [1.5, 0.3];
speed = (5) * timescale;
;
creator = _frl__target;
;
on_step = fr_Objects_Frontier_Labs_mod_gml_HoneypotHealParticle_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4208
function fr_Objects_Frontier_Labs_mod_gml_HoneypotHealParticle_step() {
if ((scrFRInstanceExists(creator) && scrFRInstanceExists(scrFRSelf(self)))) {
{
direction = point_direction(x, y, creator.x, creator.y);
if (scrFRPlaceMeeting(x, y, creator)) {
{
scrFRInstanceDestroy();
;
exit;
;
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

// Original Objects/Frontier_Labs.mod.gml:4219
function fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_HoneypotHealSplash";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprLabsRocketExplosion);
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
fr_glow = [48, 96];
;
mask_index = mskSmallExplosion;
;
speed = (0) * timescale;
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
hitid = [sprite_index, "HOW DID YOU DIE TO THIS"];
;
hitList = [];
;
on_step = fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_step;
;
on_hit = fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_hit;
;
on_wall = fr_Objects_Frontier_Labs_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Labs.mod.gml:4248
function fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_hit() {
if ((scrFRArrayFindIndex(hitList, (scrFROther(other))) == (- 1))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
var _frl__heal = (1 + scrFRGetSkill(mut_second_stomach));
hp = min((hp + _frl__heal), max_hp);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprHoneypotHeal);
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
scrFRSoundPlay(sndHPPickup);
;
}
}
if (scrFRInstanceIs((scrFROther(other)), enemy)) {
{
hp += round((max_hp / 5));
;
if ((hp > max_hp)) {
{
hp = max_hp;
;
}
}
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, UGPlantHeal)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprHoneypotHeal);
;
var __fr_other11=scrFROther(other);
depth = (__fr_other11.depth - 1);
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
}
}
if(__fr_break10) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
var __fr_other13=scrFROther(other);
array_push(hitList, __fr_other13);
;
}
}
}

// Original Objects/Frontier_Labs.mod.gml:4276
function fr_Objects_Frontier_Labs_mod_gml_HoneypotHealSplash_step() {
if (((image_index + (image_speed / timescale)) >= image_number)) {
{
scrFRInstanceDestroy();
;
}
}
; // macro hoisted: anim_end
; // macro hoisted: current_frame_active
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
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

// Original Objects/Frontier_Labs.mod.gml:4300
function fr_Objects_Frontier_Labs_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Labs.mod.gml:4301
function fr_Objects_Frontier_Labs_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Labs.mod.gml:4302
function fr_Objects_Frontier_Labs_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Labs.mod.gml:4303
function fr_Objects_Frontier_Labs_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Labs.mod.gml:4304
function fr_Objects_Frontier_Labs_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Labs.mod.gml:4305
function fr_Objects_Frontier_Labs_mod_gml_enemy_face(_frl__dir=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:4306
function fr_Objects_Frontier_Labs_mod_gml_enemy_look(_frl__dir=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:4307
function fr_Objects_Frontier_Labs_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Labs.mod.gml:4308
function fr_Objects_Frontier_Labs_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Labs.mod.gml:4309
function fr_Objects_Frontier_Labs_mod_gml_GunEnemy_draw() {
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

// Original Objects/Frontier_Labs.mod.gml:4310
function fr_Objects_Frontier_Labs_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Labs.mod.gml:4311
function fr_Objects_Frontier_Labs_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Labs_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Labs.mod.gml:4312
function fr_Objects_Frontier_Labs_mod_gml_nothing() {

}

// Original Objects/Frontier_Labs.mod.gml:4313
function fr_Objects_Frontier_Labs_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:4323
function fr_Objects_Frontier_Labs_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:4332
function fr_Objects_Frontier_Labs_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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

// Original Objects/Frontier_Labs.mod.gml:4355
function fr_Objects_Frontier_Labs_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Labs.mod.gml:4367
function fr_Objects_Frontier_Labs_mod_gml_MuzzleFlash_anim() {
image_index = 1;
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Labs.mod.gml:4371
function fr_Objects_Frontier_Labs_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Labs"].sprGenericTrail);
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
