#macro frMacro_Objects_Frontier_Caves_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Caves"].scr

#macro frMacro_Objects_Frontier_Caves_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Caves_mod_gml_p_sprite2 (((sprite_index != spr_hurt2) || frMacro_Objects_Frontier_Caves_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle2 : spr_walk2) : sprite_index)

#macro frMacro_Objects_Frontier_Caves_mod_gml_p_sprite3 (((sprite_index != spr_hurt3) || frMacro_Objects_Frontier_Caves_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle3 : spr_walk3) : sprite_index)

#macro frMacro_Objects_Frontier_Caves_mod_gml__tespr scrFRModGet("mod", "teassets", "spr")

#macro frMacro_Objects_Frontier_Caves_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Caves_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Caves_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Caves_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Caves_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Caves_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Caves_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Caves.mod.gml:1
function fr_Objects_Frontier_Caves_mod_gml___load() {

}

// Original Objects/Frontier_Caves.mod.gml:1
function fr_Objects_Frontier_Caves_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Caves_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Caves_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Caves_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Caves.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Caves", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Caves"].settingLowQualityParrots = false;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].settingTradeFishMode = "OFF";
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndWhaleHurt = sndFR_sndWhaleHurt_c405575c826e;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndWhaleDead = sndFR_sndWhaleDead_933322da3fe3;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndEliteWhaleHurt = sndFR_sndEliteWhaleHurt_9ee5bdb56dc7;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndEliteWhaleDead = sndFR_sndEliteWhaleDead_5a55df2195bd;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishHurt = sndFR_sndStarfishHurt_d6be395ffc0a;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishDead = sndFR_sndStarfishDead_08bfff5adfce;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishSing = sndFR_sndStarfishSing_27fd2e88bcbd;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotHurt = sndFR_sndGunParrotHurt_4e84010db0bc;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotDead = sndFR_sndGunParrotDead_0aad1cae5fb5;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndSwordParrotHurt = sndFR_sndSwordParrotHurt_3ae9b45f6520;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sndSwordParrotDead = sndFR_sndSwordParrotDead_941a29e322ce;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapIdle = sprFR_sprSpikeTrapIdle_62ef36c514c1;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapSpiking = sprFR_sprSpikeTrapSpiking_72165a716979;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapGameover = sprFR_sprSpikeTrapSpiking_264af7a0e7f4;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedIdle = sprFR_sprSpikeTrapCursedIdle_961aab0fec63;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedSpiking = sprFR_sprSpikeTrapCursedSpikin_6caec3c4578a;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedGameover = sprFR_sprSpikeTrapCursedSpikin_4e4745ad7cdb;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].mskSpikeTrap = sprFR_mskSpikeTrap_e8e944f523e0;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescend = sprFR_sprSpiderDescend_9380c5ede60c;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvSpiderDescend = sprFR_sprInvSpiderDescend_31f56df33e0f;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWeb = sprFR_sprSpiderDescendWeb_2a603f0843b7;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWebEnd = sprFR_sprSpiderDescendWebEnd_a1678fb6bc30;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWebStart = sprFR_sprSpiderDescendWebStart_9942bd2b952f;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalIdle = sprFR_sprInvHyperCrystalIdle_df8f7543500d;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalHurt = sprFR_sprInvHyperCrystalHurt_b9edeecc6d99;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalDead = sprFR_sprInvHyperCrystalDead_5ba89bb6bd15;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalIdle = sprFR_sprLightningHyperCrystal_7b9242c8f74e;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalHurt = sprFR_sprLightningHyperCrystal_1da58ae5c5a0;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalDead = sprFR_sprLightningHyperCrystal_911dd767d712;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalIdle = sprFR_sprCoveHyperCrystalIdle_182fcdb5b6f2;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalHurt = sprFR_sprCoveHyperCrystalHurt_7fd0d268b001;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalDead = sprFR_sprCoveHyperCrystalDead_920cf7090195;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWall104TopSpread = sprFR_sprWall104TopSpread_5cfb62711af5;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWall104TransSpread = sprFR_sprWall104TransSpread_660a2e9d0963;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprSnowFloor104 = sprFR_sprSnowFloor104_6e93811f123e;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceDebris = sprFR_sprCoveEntranceDebris_6f593df25447;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceClosed = sprFR_sprCoveEntranceClosed_c212ef332af2;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceOpen = sprFR_sprCoveEntranceOpen_2937b46d2029;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceClosed = sprFR_sprInvCoveEntranceClosed_15423f42b427;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceOpen = sprFR_sprInvCoveEntranceOpen_198eb9d41205;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprScrapyardCoveEntranceClosed = sprFR_sprScrapyardCoveEntrance_291182462adf;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprScrapyardCoveEntranceOpen = sprFR_sprScrapyardCoveEntrance_dc147513cd31;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleIdle = sprFR_sprWhaleIdle_6e8ff38f926e;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleWalk = sprFR_sprWhaleWalk_042b639203c0;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleHurt = sprFR_sprWhaleHurt_327f4927b261;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleDead = sprFR_sprWhaleDead_f801bca7a622;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleWeap = sprFR_sprWhaleWeap_142d297d8370;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleIdle = sprFR_sprEliteWhaleIdle_1edc2e04daee;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleWalk = sprFR_sprEliteWhaleWalk_813e90082e32;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleHurt = sprFR_sprEliteWhaleHurt_896fe07085e9;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleDead = sprFR_sprEliteWhaleDead_6b44d849dbd6;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleWeap = sprFR_sprEliteWhaleWeap_43dead5d0dbc;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerIdle", [1], sprFR_sprParrotTopLayerIdle1_f8e9a8771e3f, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerIdle", [2], sprFR_sprParrotTopLayerIdle2_8ed24dae3908, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerIdle", [3], sprFR_sprParrotTopLayerIdle3_278cd87be41b, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerIdle", [4], sprFR_sprParrotTopLayerIdle4_59b0ba9d2565, "=");
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerIdle = sprFR_sprParrotMiddleLayerIdle_043f7084b3b8;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerIdle = sprFR_sprParrotBaseLayerIdle_15c0e488bbf0;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerWalk", [1], sprFR_sprParrotTopLayerWalk1_de8b670d1e15, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerWalk", [2], sprFR_sprParrotTopLayerWalk2_ee0d64659b03, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerWalk", [3], sprFR_sprParrotTopLayerWalk3_73687fc9f727, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerWalk", [4], sprFR_sprParrotTopLayerWalk4_2cc53d7a7a72, "=");
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerWalk = sprFR_sprParrotMiddleLayerWalk_31cfcd0f900f;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerWalk = sprFR_sprParrotBaseLayerWalk_02884d2a22b5;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerHurt", [1], sprFR_sprParrotTopLayerHurt1_8fe8e3eeffe9, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerHurt", [2], sprFR_sprParrotTopLayerHurt2_21aac3f81d40, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerHurt", [3], sprFR_sprParrotTopLayerHurt3_2fcad26d085c, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Caves"], "sprParrotTopLayerHurt", [4], sprFR_sprParrotTopLayerHurt4_3a79a6e78174, "=");
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerHurt = sprFR_sprParrotMiddleLayerHurt_37170967cebd;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerHurt = sprFR_sprParrotBaseLayerHurt_63e901ce67ac;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotDead = sprFR_sprParrotDead_1b860a77317f;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotGameover = sprFR_sprParrotGameover_60d970b954e6;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotFeather = sprFR_sprParrotFeather_2dead4a84744;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotWeapCutlass = sprFR_sprParrotWeapCutlass_4b7c3ae61350;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotWeapFlintlock = sprFR_sprParrotWeapFlintlock_c172c6fb3cbb;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQIdle = sprFR_sprParrotLQIdle_868053c75cbd;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQWalk = sprFR_sprParrotLQWalk_63286e8d0ffb;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQHurt = sprFR_sprParrotLQHurt_a65bf8f0d713;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].shdStarfish = sprFR_shdStarfish_a561e0babb64;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishIdle = sprFR_sprStarfishIdle_97a9169267a5;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishWalk = sprFR_sprStarfishWalk_4288e45e888a;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishHurt = sprFR_sprStarfishHurt_843147e38919;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishDead = sprFR_sprStarfishDead_b2258d874b01;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishTell = sprFR_sprStarfishTell_b6ee4a1bdc3e;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishChrg = sprFR_sprStarfishChrg_3c0ea6f1e471;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishIdle = sprFR_sprEliteStarfishIdle_811f76795127;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishWalk = sprFR_sprEliteStarfishWalk_210e463f0136;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishHurt = sprFR_sprEliteStarfishHurt_b224846764a6;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishDead = sprFR_sprEliteStarfishDead_4a7921975cd1;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishTell = sprFR_sprEliteStarfishTell_6b07e739ab9c;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishChrg = sprFR_sprEliteStarfishChrg_2a796dea3490;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishChrgLight = sprFR_sprEliteStarfishChrgLigh_145198c353cc;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingIdle = sprFR_sprStarfishSingIdle_70eb5f92a323;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingWalk = sprFR_sprStarfishSingWalk_5207905c2ec1;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingHurt = sprFR_sprStarfishSingHurt_c051b5e9c1ce;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingDead = sprFR_sprStarfishSingDead_1eff6840b289;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprMusicNote = sprFR_sprMusicNote_794d82014de9;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprFallingRockWarning = sprFR_sprFallingRockWarning_6441f153e008;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprTradefish = sprFR_sprTradeFish_ec3c8ae68c68;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprTradefishTrail = sprFR_sprTradeFishTrail_3eda76968b56;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalIdle = sprFR_sprCoveLaserCrystalIdle_87df0cd9fc78;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalHurt = sprFR_sprCoveLaserCrystalHurt_d84b44d7cab0;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalDead = sprFR_sprCoveLaserCrystalDead_2e50fcedc314;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalIdle = sprFR_sprCoveHyperCrystalIdle_182fcdb5b6f2;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalHurt = sprFR_sprCoveHyperCrystalHurt_7fd0d268b001;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalDead = sprFR_sprCoveHyperCrystalDead_920cf7090195;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhiteSmoke = sprFR_sprWhiteSmoke_af86c6156b99;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].mskCannonball = sprFR_mskCannonball_c0e04009a71d;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonball = sprFR_sprCannonball_35a17c46c90b;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonballTrail = sprFR_sprCannonballTrail_bfb20edc1c31;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprMortarBarrel = sprFR_sprGunpowderBarrel_5c8ca13b0240;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprMortarBarrelDebris = sprFR_sprGunpowderBarrelDebris_bc48a0efb571;
;
global.fr_module_vars[$ "mod:Frontier_Caves"].sprEnemyStreak = sprFR_sprEnemyStreak_e17a2ab96948;
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Caves.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Caves.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Caves.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Caves.mod.gml:164
function fr_Objects_Frontier_Caves_mod_gml_TradeFishController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_tradeFishController";
myNumber = scrFRSourceIRandom(100000);
;
tradedWeps = frMacro_Objects_Frontier_Caves_mod_gml_call(frMacro_Objects_Frontier_Caves_mod_gml_scr.save_get, "Frontier", "pirate_conversions");
;
on_step = fr_Objects_Frontier_Caves_mod_gml_TradeFishController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:176
function fr_Objects_Frontier_Caves_mod_gml_TradeFishController_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(WepPickup, "fr_tradefishcheck", myNumber)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
fr_tradefishcheck = __fr_other4.myNumber;
;
if ((global.fr_module_vars[$ "mod:Frontier_Caves"].settingTradeFishMode == "NEW")) {
{
var _frl__inputIndex = ds_list_find_index(scrFRModGet("area", "cove", "pirateInput"), scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
if ((_frl__inputIndex != (- 1))) {
{
var _frl__output = ds_list_find_value(scrFRModGet("area", "cove", "pirateOutput"), _frl__inputIndex);
;
if ((scrFRArrayFindIndex((scrFROther(other)).tradedWeps, _frl__output) == (- 1))) {
{
fr_Objects_Frontier_Caves_mod_gml_TradeFish_create(x, y, scrFRSelf(self));
;
}
}
}
}
if ((is_string(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRScriptExists("weapon", scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep_exchange_pirate"))) {
{
if ((scrFRArrayFindIndex((scrFROther(other)).tradedWeps, scrFRModCall("weapon", scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep_exchange_pirate")) == (- 1))) {
{
fr_Objects_Frontier_Caves_mod_gml_TradeFish_create(x, y, scrFRSelf(self));
;
}
}
}
}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Caves"].settingTradeFishMode == "ALL")) {
{
var _frl__inputIndex = ds_list_find_index(scrFRModGet("area", "cove", "pirateInput"), scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
if ((_frl__inputIndex != (- 1))) {
{
fr_Objects_Frontier_Caves_mod_gml_TradeFish_create(x, y, scrFRSelf(self));
;
}
}
if ((is_string(scrFRWeaponSlotRead(scrFRSelf(self), "wep")) && scrFRScriptExists("weapon", scrFRWeaponSlotRead(scrFRSelf(self), "wep"), "wep_exchange_pirate"))) {
{
fr_Objects_Frontier_Caves_mod_gml_TradeFish_create(x, y, scrFRSelf(self));
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

// Original Objects/Frontier_Caves.mod.gml:212
function fr_Objects_Frontier_Caves_mod_gml_TradeFish_create(_frl__x=undefined, _frl__y=undefined, _frl__weppickup=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_TradeFish";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprTradefish);
;
image_angle = 270;
;
image_speed = (0.3) * timescale;
;
fr_bloom = [1.5, 0.1];
;
image_alpha = 0.5;
;
dist = 8;
;
orbitSpeed = 3;
;
rotSpeed = 3;
;
angle = 0;
;
owner = _frl__weppickup;
;
on_end_step = fr_Objects_Frontier_Caves_mod_gml_TradeFish_endstep;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:233
function fr_Objects_Frontier_Caves_mod_gml_TradeFish_endstep() {
if (((! scrFRInstanceExists(owner)) || (owner.visible == false))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (frMacro_Objects_Frontier_Caves_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprTradefishTrail);
;
image_alpha = 0.3;
;
speed = (1.4) * timescale;
;
direction = scrFRSourceRandom(360);
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
image_angle += (rotSpeed * scrFRSourceScale());
;
xprevious = (owner.x + lengthdir_x(dist, angle));
;
yprevious = (owner.y + lengthdir_y(dist, angle));
;
x = (owner.x + lengthdir_x(dist, angle));
;
y = (owner.y + lengthdir_y(dist, angle));
;
}

// Original Objects/Frontier_Caves.mod.gml:258
function fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_create(_frl__x=undefined, _frl__y=undefined, _frl__cursed=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SpikeTrap";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapIdle;
;
spr_spiking = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapSpiking;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapGameover;
;
if (_frl__cursed) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedIdle;
;
spr_spiking = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedSpiking;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedGameover;
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = 5;
;
canspike = true;
;
spiking = false;
;
cursed = false;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:288
function fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_step_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Caves_mod_gml_SpikeTrap_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Caves.mod.gml:333
{
_fr.vars.bigmessy = frMacro_Objects_Frontier_Caves_mod_gml_call(frMacro_Objects_Frontier_Caves_mod_gml_scr.instances_meeting, x, y, Corpse);
;
{ var __fr_with1 = scrFRWithValues(_fr.vars.bigmessy), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other4.x, __fr_other4.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 0.7);
}
}
}
}
if(__fr_break3) break;
}}
if ((! scrFRPlaceMeeting(x, y, Player))) {
{
canspike = true;
;
}
}
}
_fr.pc=0;
break;
case 2: // Objects/Frontier_Caves.mod.gml:309
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomProjectile)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
scrFRSoundPitchVolume(sndCrystalJuggernaut, (1.6 + scrFRSourceRandom(0.3)), 0.5);
scrFRSoundPitch(sndChickenSword, (1.4 + scrFRSourceRandom(0.3)));
scrFRSoundPitchVolume(sndCrystalShield, (1.3 + scrFRSourceRandom(0.3)), 1.3);
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Caves"].mskSpikeTrap;
;
lifetime = 10;
;
hitlist = [];
;
damage = 2;
;
var __fr_other8=scrFROther(other);
hitid = [__fr_other8.spr_gameover, "SPIKE TRAP"];
speed = (0) * timescale;
;
team = 1;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_SpikeHitbox_step;
;
on_hit = fr_Objects_Frontier_Caves_mod_gml_SpikeHitbox_hit;
;
on_wall = fr_Objects_Frontier_Caves_mod_gml_nothing;
;
}
}
if(__fr_break7) break;
}}
}
_fr.pc=1;
break;
case 3: // Objects/Frontier_Caves.mod.gml:306
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Caves.mod.gml:306
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Objects/Frontier_Caves.mod.gml:306
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 4 : 2;
break;
case 6: // Objects/Frontier_Caves.mod.gml:305
{
;
}
_fr.pc=5;
break;
case 7: // Objects/Frontier_Caves.mod.gml:305
_fr.wait_ticks=max(0,18); _fr.pc=6; return;
break;
case 8: // Objects/Frontier_Caves.mod.gml:299
{
canspike = false;
;
spiking = true;
;
sprite_index = scrFRAreaSourceSprite(spr_spiking);
;
scrFRSoundPitchVolume(sndCrystalShield, (1.6 + scrFRSourceRandom(0.3)), 0.3);
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Caves.mod.gml:297
_fr.pc = (((scrFRPlaceMeeting(x, y, Player) && (spiking == false)) && (canspike == true))) ? 8 : 1;
break;
case 10: // Objects/Frontier_Caves.mod.gml:290
{
_fr.vars.me = scrFRSelf(self);
;
if (((sprite_index == spr_spiking) && frMacro_Objects_Frontier_Caves_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spiking = false;
;
}
}
}
_fr.pc=9;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Caves.mod.gml:345
function fr_Objects_Frontier_Caves_mod_gml_SpikeHitbox_step() {
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:351
function fr_Objects_Frontier_Caves_mod_gml_SpikeHitbox_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
{ var __fr_with2 = scrFRWithValues((scrFROther(other))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other5.damage);
var __fr_other6=scrFROther(other);
lasthit = __fr_other6.hitid;
;
}
}
if(__fr_break4) break;
}}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:360
function fr_Objects_Frontier_Caves_mod_gml_CoveEntrance_create(_frl__x=undefined, _frl__y=undefined, _frl__curse=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CoveEntrance";
;
spr_idle = (_frl__curse ? global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceClosed : global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceClosed);
;
spr_open = (_frl__curse ? global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceOpen : global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceOpen);
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveEntranceDebris;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = 5;
;
open = false;
;
opened = false;
;
bossType = HyperCrystal;
;
portalPusher = scrFRModCall("mod", "Frontier_Objects", "PortalPusher_create", x, y, 72);
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_CoveEntrance_step];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:386
function fr_Objects_Frontier_Caves_mod_gml_CoveEntrance_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((((((! scrFRInstanceExists(chestprop)) && (! scrFRInstanceExists(RadChest))) && (! scrFRInstanceExists(HyperCrystal))) && (! scrFRInstanceExists(bossType))) && (! scrFRInstanceExists(BecomeScrapBoss))) && (open == false))) {
{
open = true;
;
sprite_index = scrFRAreaSourceSprite(spr_open);
;
scrFRSoundPitch(sndWallBreakJungle, 1.3);
scrFRInstanceCreate(x, y, PortalClear);
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_debris);
;
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
}
}
if (((scrFRPlaceMeeting(x, y, Player) && (opened == false)) && (open == true))) {
{
opened = true;
;
{ var __fr_with8 = scrFRWithValues(GameCont), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
area = scrFRAreaResolve("cove");
subarea = 0;
;
killenemies = false;
;
}
}
if(__fr_break10) break;
}}
{ var __fr_with11 = scrFRWithValues(portalPusher), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break13) break;
}}
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
image_alpha = 0;
;
}
}
if(__fr_break16) break;
}}
}
}
var _frl_bigmessy = frMacro_Objects_Frontier_Caves_mod_gml_call(frMacro_Objects_Frontier_Caves_mod_gml_scr.instances_meeting, x, y, Debris);
;
{ var __fr_with17 = scrFRWithValues(_frl_bigmessy), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
var __fr_other20=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other20.x, __fr_other20.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 0.7);
}
}
}
}
if(__fr_break19) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:435
function fr_Objects_Frontier_Caves_mod_gml_ScrapyardCoveEntrance_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Caves_mod_gml_CoveEntrance_create(_frl__x, _frl__y, false)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bossType = ScrapBoss;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprScrapyardCoveEntranceClosed;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Caves"].sprScrapyardCoveEntranceOpen;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:445
function fr_Objects_Frontier_Caves_mod_gml_SpiderTrap_create(_frl__x=undefined, _frl__y=undefined, _frl__curse=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SpiderTrap";
;
spr_spider = (_frl__curse ? global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvSpiderDescend : global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescend);
;
depth = (- 10);
;
curse = _frl__curse;
;
z = 200;
;
z_start = z;
;
z_friction = 0;
;
mySpider = noone;
;
droppingSpider = false;
;
droppedSpider = false;
;
spiderSpawned = false;
;
sinOffset = scrFRSourceIRandom(30);
;
myCoolSine = 0;
;
manualActivate = false;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_CrystalSpiderDescend_step;
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_CrystalSpiderDescend_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:472
function fr_Objects_Frontier_Caves_mod_gml_CoolSpider_create(_frl__x=undefined, _frl__y=undefined, _frl__curse=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, (_frl__curse ? InvSpider : Spider))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mask_index = mskNone;
;
spr_shadow = mskNone;
;
canfly = true;
;
depth = (- 11);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:482
function fr_Objects_Frontier_Caves_mod_gml_CrystalSpiderDescend_step() {
myCoolSine = (0.2 + (sin(((scrFRSourceFrame() + sinOffset) * 0.06)) * 0.15));
;
if ((((distance_to_object(Player) < 6) || (manualActivate == true)) && (spiderSpawned == false))) {
{
scrFRSoundPitchVolume(sndSpiderMelee, (1.1 + scrFRSourceRandom(0.1)), 0.6);
spiderSpawned = true;
;
droppingSpider = true;
;
mySpider = fr_Objects_Frontier_Caves_mod_gml_CoolSpider_create(x, (y - z_start), curse);
;
}
}
if ((spiderSpawned == true)) {
{
if ((droppingSpider == true)) {
{
if ((z > 0)) {
{
z -= (clamp((8 - z_friction), 3, 8) * scrFRSourceScale());
;
}
}
z_friction += ((0.10 + (z_friction / 50)) * scrFRSourceScale());
;
{ var __fr_with1 = scrFRWithValues(mySpider), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x = __fr_other4.x;
;
var __fr_other5=scrFROther(other);
y = (__fr_other5.y - __fr_other5.z);
;
var __fr_other6=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other6.spr_spider);
;
speed = (0) * timescale;
;
right = 1;
;
}
}
if(__fr_break3) break;
}}
if ((z <= 20)) {
{
{ var __fr_with7 = scrFRWithValues(mySpider), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
canfly = false;
;
mask_index = mskSpider;
;
}
}
if(__fr_break9) break;
}}
}
}
if ((z <= 0)) {
{
{ var __fr_with10 = scrFRWithValues(mySpider), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
spr_shadow = shd24;
;
depth = (- 2);
;
repeat (8) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
var __fr_other16=scrFROther(other);
depth = (__fr_other16.depth - 1);
;
direction = (270 + scrFRSourceRandomRange((- 90), 90));
speed = ((2 + scrFRSourceRandom(1))) * timescale;
;
}
}
if(__fr_break15) break;
}}
}
}
}
if(__fr_break12) break;
}}
mySpider = noone;
;
droppingSpider = false;
;
droppedSpider = true;
;
z_friction = 0;
;
scrFRSoundPitchVolume(sndCocoonBreak, (1.4 + scrFRSourceRandom(0.2)), 0.4);
;
}
}
}
} else {
{
if ((z <= z_start)) {
{
z += (16 * scrFRSourceScale());
;
image_alpha -= (0.05 * scrFRSourceScale());
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
}
}

// Original Objects/Frontier_Caves.mod.gml:539
function fr_Objects_Frontier_Caves_mod_gml_CrystalSpiderDescend_draw() {
if ((droppedSpider == false)) {
{
scrFRDrawSpriteExt(shd24, 0, x, y, clamp((((z_start / z) / 4) + myCoolSine), 0.3, 1), 1, 0, c_white, clamp((((z_start / z) / 4) + (myCoolSine / 2)), 0.05, 0.4));
}
}
if ((spiderSpawned == true)) {
{
draw_set_alpha(image_alpha);
;
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWebStart, 0, x, (y - z_start));
draw_sprite_stretched(global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWeb, 0, x, (y - z_start), 3, (z_start - z));
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpiderDescendingWebEnd, 0, x, (y - z));
draw_set_alpha(1);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:551
function fr_Objects_Frontier_Caves_mod_gml_HyperCrystalOurpler_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_hypercrystalOurper";
on_step = fr_Objects_Frontier_Caves_mod_gml_HyperCrystalOurpler_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:560
function fr_Objects_Frontier_Caves_mod_gml_HyperCrystalOurpler_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(HyperCrystal, "spr_idle", sprHyperCrystalIdle)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvHyperCrystalDead;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(HyperCrystal), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRAlarmRead(scrFRSelf(self), 3) == 1)) {
{
intro = true;
;
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Bosses", "boss_intro", "OurpleCursedHyperCrystal")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
loops = GameCont.loops;
;
}
}
if(__fr_break9) break;
}}
scrFRAlarmWrite(scrFRSelf(self), 3, 0, "=");
;
}
}
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:577
function fr_Objects_Frontier_Caves_mod_gml_LightningHyperCrystalController_create(_frl__x=undefined, _frl__y=undefined, _frl__crystal=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_lightningHyperController";
myCrystal = _frl__crystal;
;
{ var __fr_with4 = scrFRWithValues(_frl__crystal), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprLightningHyperCrystalDead;
;
raddrop = round((raddrop * 1.14));
;
}
}
if(__fr_break6) break;
}}
on_step = fr_Objects_Frontier_Caves_mod_gml_LightningHyperCrystalController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:593
function fr_Objects_Frontier_Caves_mod_gml_LightningHyperCrystalController_step() {
{ var __fr_with1 = scrFRWithValues(myCrystal), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRAlarmRead(scrFRSelf(self), 3) == 1)) {
{
intro = true;
;
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Bosses", "boss_intro", "LightningHyperCrystal")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
loops = GameCont.loops;
;
}
}
if(__fr_break6) break;
}}
scrFRAlarmWrite(scrFRSelf(self), 3, 0, "=");
;
}
}
var _frl__crystalArray = crystal;
{ var __fr_with7 = scrFRWithValues(crystal), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRInstanceIs(scrFRSelf(self), LaserCrystal)) {
{
instance_change(LightningCrystal, false);
spr_idle = sprLightningCrystalIdle;
;
spr_walk = sprLightningCrystalIdle;
;
spr_hurt = sprLightningCrystalHurt;
;
spr_dead = sprLightningCrystalDead;
;
spr_fire = sprLightningCrystalFire;
;
raddrop = round((raddrop * 1.14));
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:616
function fr_Objects_Frontier_Caves_mod_gml_CoveHyperCrystal_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, HyperCrystal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveHyperCrystalDead;
;
hitid = [spr_idle, "HYPER CRYSTAL"];
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
fr_Objects_Frontier_Caves_mod_gml_CoveHyperCrystalController_create(_frl__x, _frl__y, scrFRSelf(self));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:632
function fr_Objects_Frontier_Caves_mod_gml_CoveHyperCrystalController_create(_frl__x=undefined, _frl__y=undefined, _frl__crystal=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_coveHyperController";
myCrystal = _frl__crystal;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_CoveHyperCrystalController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:642
function fr_Objects_Frontier_Caves_mod_gml_CoveHyperCrystalController_step() {
{ var __fr_with1 = scrFRWithValues(myCrystal), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRAlarmRead(scrFRSelf(self), 3) == 1)) {
{
intro = true;
;
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Bosses", "boss_intro", "CoveHyperCrystal")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
loops = GameCont.loops;
;
}
}
if(__fr_break6) break;
}}
scrFRAlarmWrite(scrFRSelf(self), 3, 0, "=");
;
}
}
var _frl__crystalArray = crystal;
{ var __fr_with7 = scrFRWithValues(crystal), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((scrFRInstanceExists(scrFRSelf(self)) && (!scrFRVariableExists(scrFRSelf(self), "fr_ahoyed")))) {
{
fr_ahoyed = true;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprCoveLaserCrystalDead;
;
hitid = [spr_idle, "LASER CRYSTAL"];
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:664
function fr_Objects_Frontier_Caves_mod_gml_CurseCaveSpreader_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CurseCaveSpreader";
curseRange = (32 + (8 * scrFRSourceIRandom(5)));
;
on_step = fr_Objects_Frontier_Caves_mod_gml_CurseCaveSpreader_step;
;
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_cursecavedraws")) == 0)) {
{
fr_Objects_Frontier_Caves_mod_gml_CurseCaveDraws_create(10016, 10016);
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

// Original Objects/Frontier_Caves.mod.gml:679
function fr_Objects_Frontier_Caves_mod_gml_CurseCaveSpreader_step() {
{ var __fr_with1 = scrFRWithValues(Spider), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
scrFRInstanceCreate(x, y, InvSpider);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(LaserCrystal), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
scrFRInstanceCreate(x, y, InvLaserCrystal);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(Floor), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
if (((sprite_index == sprFloor4) || (sprite_index == sprFloor4B))) {
{
var _frl__sprite = ((styleb == true) ? sprFloor104B : sprFloor104);
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
depth -= 2;
;
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceIRandomRange((- 1), 1)), (y - scrFRSourceIRandomRange(2, 3)), SnowFloor)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprSnowFloor104);
;
var __fr_other13=scrFROther(other);
image_speed = ((__fr_other13.image_speed / timescale)) * timescale;
;
image_index = scrFRSourceIRandom(7);
;
image_angle += scrFRSourceRandomRange((- 1), 1);
var __fr_other14=scrFROther(other);
depth = (__fr_other14.depth + 1);
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
}
if(__fr_break9) break;
}}
{ var __fr_with15 = scrFRWithValues(FloorExplo), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
if ((sprite_index == sprFloor4Explo)) {
{
sprite_index = scrFRAreaSourceSprite(sprFloor104Explo);
;
}
}
}
}
}
}
if(__fr_break17) break;
}}
{ var __fr_with18 = scrFRWithValues(Wall), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 8))) {
{
if ((sprite_index == sprWall4Bot)) {
{
sprite_index = scrFRAreaSourceSprite(sprWall104Bot);
;
topspr = sprWall104Top;
;
outspr = sprWall104Out;
;
image_index = scrFRSourceIRandom(image_number);
;
fr_topSmallCurse = undefined;
;
}
}
}
}
if (((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 32)) && (distance_to_object((scrFROther(other))) > ((scrFROther(other)).curseRange + 8)))) {
{
if ((sprite_index == sprWall4Bot)) {
{
if (((distance_to_object(Bones) > 16) && (distance_to_object(TopDecalCave) > 16))) {
{
sprite_index = scrFRAreaSourceSprite(sprWall104Bot);
;
topspr = sprWall104Top;
;
outspr = sprWall104Out;
;
image_index = scrFRSourceIRandom(image_number);
;
fr_topSmallCurse = scrFRSourceIRandom(1);
;
}
}
}
}
}
}
}
}
if(__fr_break20) break;
}}
{ var __fr_with21 = scrFRWithValues(TopSmall), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 32))) {
{
if ((sprite_index == sprWall4Trans)) {
{
sprite_index = scrFRAreaSourceSprite(sprWall104Trans);
;
image_index = scrFRSourceIRandom(image_number);
;
fr_topSmallCurse = scrFRSourceIRandom(3);
;
fr_topSmallCurseRot = scrFRSourceChoose(0, 90, 180, 270);
;
}
}
}
}
}
}
if(__fr_break23) break;
}}
{ var __fr_with24 = scrFRWithValues(TopDecalCave), __fr_break26=false;
for (var __fr_index25=0; __fr_index25<array_length(__fr_with24); ++__fr_index25) {
if(scrFRScopeExists(__fr_with24[__fr_index25])) with (__fr_with24[__fr_index25]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 8))) {
{
if ((sprite_index == sprTopDecalCave)) {
{
sprite_index = scrFRAreaSourceSprite(sprTopDecalInvCave);
;
}
}
}
}
}
}
if(__fr_break26) break;
}}
{ var __fr_with27 = scrFRWithValues(Bones), __fr_break29=false;
for (var __fr_index28=0; __fr_index28<array_length(__fr_with27); ++__fr_index28) {
if(scrFRScopeExists(__fr_with27[__fr_index28])) with (__fr_with27[__fr_index28]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 8))) {
{
if ((sprite_index == sprCaveDecal)) {
{
sprite_index = scrFRAreaSourceSprite(sprInvCaveDecal);
;
}
}
}
}
}
}
if(__fr_break29) break;
}}
{ var __fr_with30 = scrFRWithValues(Detail), __fr_break32=false;
for (var __fr_index31=0; __fr_index31<array_length(__fr_with30); ++__fr_index31) {
if(scrFRScopeExists(__fr_with30[__fr_index31])) with (__fr_with30[__fr_index31]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange + 16))) {
{
if ((sprite_index == sprDetail4)) {
{
sprite_index = scrFRAreaSourceSprite(sprDetail104);
;
image_index = scrFRSourceIRandom(image_number);
;
}
}
}
}
}
}
if(__fr_break32) break;
}}
{ var __fr_with33 = scrFRWithValues(Crystal), __fr_break35=false;
for (var __fr_index34=0; __fr_index34<array_length(__fr_with33); ++__fr_index34) {
if(scrFRScopeExists(__fr_with33[__fr_index34])) with (__fr_with33[__fr_index34]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
if ((spr_idle == sprCrystalProp)) {
{
scrFRInstanceCreate(x, y, FR_OBJECT_INV_CRYSTAL);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
}
}
if(__fr_break35) break;
}}
{ var __fr_with36 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_CoveEntrance")), __fr_break38=false;
for (var __fr_index37=0; __fr_index37<array_length(__fr_with36); ++__fr_index37) {
if(scrFRScopeExists(__fr_with36[__fr_index37])) with (__fr_with36[__fr_index37]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceClosed;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Caves"].sprInvCoveEntranceOpen;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
if(__fr_break38) break;
}}
{ var __fr_with39 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_SpikeTrap")), __fr_break41=false;
for (var __fr_index40=0; __fr_index40<array_length(__fr_with39); ++__fr_index40) {
if(scrFRScopeExists(__fr_with39[__fr_index40])) with (__fr_with39[__fr_index40]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedIdle;
;
spr_spiking = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedSpiking;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Caves"].sprSpikeTrapCursedGameover;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
if(__fr_break41) break;
}}
{ var __fr_with42 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_SpiderTrap")), __fr_break44=false;
for (var __fr_index43=0; __fr_index43<array_length(__fr_with42); ++__fr_index43) {
if(scrFRScopeExists(__fr_with42[__fr_index43])) with (__fr_with42[__fr_index43]) {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(1, 2)) {
{
fr_Objects_Frontier_Caves_mod_gml_SpiderTrap_create(x, y, true);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break44) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with45 = scrFRWithValues(scrFRMatching(Bones, "name", "NTTEBigDecal")), __fr_break47=false;
for (var __fr_index46=0; __fr_index46<array_length(__fr_with45); ++__fr_index46) {
if(scrFRScopeExists(__fr_with45[__fr_index46])) with (__fr_with45[__fr_index46]) {
{
if ((distance_to_object((scrFROther(other))) < ((scrFROther(other)).curseRange - 16))) {
{
if ((sprite_index == frMacro_Objects_Frontier_Caves_mod_gml__tespr.BigTopDecal[?4])) {
{
{ var __fr_with48 = scrFRWithValues(fr_Objects_Frontier_Caves_mod_gml_CurseCaveSpreader_create(x, y)), __fr_break50=false;
for (var __fr_index49=0; __fr_index49<array_length(__fr_with48); ++__fr_index49) {
if(scrFRScopeExists(__fr_with48[__fr_index49])) with (__fr_with48[__fr_index49]) {
{
curseRange = 32;
;
}
}
if(__fr_break50) break;
}}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml__tespr.BigTopDecal[?104]);
;
}
}
}
}
}
}
if(__fr_break47) break;
}}
{ var __fr_with51 = scrFRWithValues(scrFRMatching(Crystal, "spr_idle", frMacro_Objects_Frontier_Caves_mod_gml__tespr.BigCrystalPropIdle)), __fr_break53=false;
for (var __fr_index52=0; __fr_index52<array_length(__fr_with51); ++__fr_index52) {
if(scrFRScopeExists(__fr_with51[__fr_index52])) with (__fr_with51[__fr_index52]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
spr_idle = frMacro_Objects_Frontier_Caves_mod_gml__tespr.InvBigCrystalPropIdle;
;
spr_hurt = frMacro_Objects_Frontier_Caves_mod_gml__tespr.InvBigCrystalPropHurt;
;
spr_dead = frMacro_Objects_Frontier_Caves_mod_gml__tespr.InvBigCrystalPropDead;
;
}
}
}
}
if(__fr_break53) break;
}}
{ var __fr_with54 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_idle", frMacro_Objects_Frontier_Caves_mod_gml__tespr.MortarIdle)), __fr_break56=false;
for (var __fr_index55=0; __fr_index55<array_length(__fr_with54); ++__fr_index55) {
if(scrFRScopeExists(__fr_with54[__fr_index55])) with (__fr_with54[__fr_index55]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
scrFRModCall("mod", "telib", "obj_create", x, y, "InvMortar");
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break56) break;
}}
{ var __fr_with57 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_idle", frMacro_Objects_Frontier_Caves_mod_gml__tespr.CrystalBatIdle)), __fr_break59=false;
for (var __fr_index58=0; __fr_index58<array_length(__fr_with57); ++__fr_index58) {
if(scrFRScopeExists(__fr_with57[__fr_index58])) with (__fr_with57[__fr_index58]) {
{
if ((distance_to_object((scrFROther(other))) < (scrFROther(other)).curseRange)) {
{
scrFRModCall("mod", "telib", "obj_create", x, y, "InvCrystalBat");
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break59) break;
}}
}
}
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Caves.mod.gml:859
function fr_Objects_Frontier_Caves_mod_gml_CurseCaveDraws_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_cursecavedraws";
;
scrFRBindDraw(fr_Objects_Frontier_Caves_mod_gml_CurseCaveWallTransOut_draw, (- 6));
;
scrFRBindDraw(fr_Objects_Frontier_Caves_mod_gml_CurseCaveWallTopOut_draw, (- 10));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:869
function fr_Objects_Frontier_Caves_mod_gml_CurseCaveWallTransOut_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(TopSmall, "fr_topSmallCurse", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Caves"].sprWall104TransSpread, fr_topSmallCurse, (x + 8), y, 1, 1, fr_topSmallCurseRot, c_white, 1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:874
function fr_Objects_Frontier_Caves_mod_gml_CurseCaveWallTopOut_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(Wall, "fr_topSmallCurse", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Caves"].sprWall104TopSpread, fr_topSmallCurse, (x + 8), y, 1, 1, 0, c_white, 1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:882
function fr_Objects_Frontier_Caves_mod_gml_Whale_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Whale";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleDead;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhaleWeap;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "WHALE"];
spr_shadow = shd48;
;
spr_shadow_y = 2;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
water_breathing = true;
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
spr_bubble_x = 0;
;
spr_bubble_y = 0;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndWhaleHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndWhaleDead;
;
mask_index = sprFRBase_mskRhinoFreak;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 56, "=");
;
hp = max_hp;
;
raddrop = 17;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
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
gunangle = 180;
;
wepangle = 110;
;
fuseTime = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Whale_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_GunEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_Whale_death;
;
on_alrm1 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Whale_alrm1];
;
on_alrm2 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Whale_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:943
function fr_Objects_Frontier_Caves_mod_gml_Whale_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Caves_mod_gml_alarm2_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Caves.mod.gml:963
function fr_Objects_Frontier_Caves_mod_gml_Whale_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if ((fr_Objects_Frontier_Caves_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_look(frMacro_Objects_Frontier_Caves_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 160)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
} else {
{
if ((fr_Objects_Frontier_Caves_mod_gml_chance(2, 3) && (frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 32))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (100 + scrFRSourceIRandom(20)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
fuseTime = 30;
;
scrFRSoundPitch(sndToxicBarrelGas, (1.2 + scrFRSourceRandom(0.2)));
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
}
}
}
} else {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(scrFRSourceRandom(360), 30);
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1004
function fr_Objects_Frontier_Caves_mod_gml_Whale_alrm2() {
if ((fuseTime > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(25, (scrFROther(other)).gunangle)), (y + lengthdir_y(25, (scrFROther(other)).gunangle)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = (0.2 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd((__fr_other4.gunangle + (__fr_other4.right * 100)), (1 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRInstanceExists(target) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible)) {
{
gunangle = fr_Objects_Frontier_Caves_mod_gml_angle_lerp_ct(gunangle, frMacro_Objects_Frontier_Caves_mod_gml_target_direction, 0.12);
}
}
if (((-- fuseTime) <= 0)) {
{
scrFRSoundPitch(sndGrenadeRifle, (0.6 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosion, (1.4 + scrFRSourceRandom(0.2)));
;
wkick = 12;
;
{ var __fr_with5 = scrFRWithValues(fr_Objects_Frontier_Caves_mod_gml_Cannonball_create(x, y)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
direction = __fr_other8.gunangle;
;
image_angle = direction;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
var __fr_other11=scrFROther(other);
hitid = __fr_other11.hitid;
;
repeat (12) {
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, (scrFROther(other)).gunangle)), (y + lengthdir_y(10, (scrFROther(other)).gunangle)), Smoke)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
var __fr_other15=scrFROther(other);
scrFRMotionAdd((__fr_other15.direction + scrFRSourceRandomRange((- 10), 10)), (2 + scrFRSourceRandom(2)));
}
}
if(__fr_break14) break;
}}
}
repeat (6) {
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(16, (scrFROther(other)).gunangle)), (y + lengthdir_y(16, (scrFROther(other)).gunangle)), BloodStreak)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprEnemyStreak);
;
var __fr_other19=scrFROther(other);
direction = (__fr_other19.direction + scrFRSourceRandomRange((- 40), 40));
;
image_angle = direction;
;
speed = ((3 + scrFRSourceRandom(4))) * timescale;
;
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break18) break;
}}
}
}
}
if(__fr_break7) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1063
function fr_Objects_Frontier_Caves_mod_gml_Whale_death() {
scrFRPickupDrop(50, 20);
;
}

// Original Objects/Frontier_Caves.mod.gml:1066
function fr_Objects_Frontier_Caves_mod_gml_EliteWhale_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Moby";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleDead;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteWhaleWeap;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "MOBY"];
spr_shadow = shd48;
;
spr_shadow_y = 2;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
water_breathing = true;
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
spr_bubble_x = 0;
;
spr_bubble_y = 0;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndEliteWhaleHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndEliteWhaleDead;
;
mask_index = sprFRBase_mskRhinoFreak;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 70, "=");
;
hp = max_hp;
;
raddrop = 24;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
;
canmelee = 0;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
target_x = 0;
;
target_y = 0;
;
walk = 0;
;
gunangle = 180;
;
wepangle = 120;
;
ammoType = "Barrel";
;
fuseTime = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_EliteWhale_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_MortarEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_EliteWhale_death;
;
on_alrm1 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_EliteWhale_alrm1];
;
on_alrm2 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_EliteWhale_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:1130
function fr_Objects_Frontier_Caves_mod_gml_EliteWhale_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Caves_mod_gml_alarm2_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Caves.mod.gml:1150
function fr_Objects_Frontier_Caves_mod_gml_EliteWhale_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if (fr_Objects_Frontier_Caves_mod_gml_enemy_target(x, y)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_look(frMacro_Objects_Frontier_Caves_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 176)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
} else {
{
if ((fr_Objects_Frontier_Caves_mod_gml_chance(2, 3) && (frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 32))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (100 + scrFRSourceIRandom(20)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
fuseTime = 30;
;
scrFRSoundPitch(sndToxicBarrelGas, (1.2 + scrFRSourceRandom(0.2)));
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (50 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
}
}
}
} else {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(scrFRSourceRandom(360), 30);
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1191
function fr_Objects_Frontier_Caves_mod_gml_EliteWhale_alrm2() {
if ((fuseTime > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(25, (scrFROther(other)).gunangle)), (y + lengthdir_y(25, (scrFROther(other)).gunangle)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = (0.2 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd((__fr_other4.gunangle + (__fr_other4.right * 100)), (1 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((ammoType == "Barrel")) {
{
if (scrFRInstanceExists(target)) {
{
gunangle = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
target_x = target.x;
;
target_y = target.y;
;
}
}
}
}
if (((-- fuseTime) <= 0)) {
{
scrFRSoundPitch(sndGrenadeRifle, (0.6 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosion, (1.4 + scrFRSourceRandom(0.2)));
;
wkick = 12;
;
if ((ammoType == "Barrel")) {
{
{ var __fr_with5 = scrFRWithValues(fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_create(x, y)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
zspeed = 10;
;
var __fr_other8=scrFROther(other);
direction = point_direction(x, y, __fr_other8.target_x, __fr_other8.target_y);
;
var __fr_other9=scrFROther(other);
speed = (((point_distance(x, y, __fr_other9.target_x, __fr_other9.target_y) * zfriction) / (zspeed * 2))) * timescale;
;
image_angle = direction;
;
var __fr_other10=scrFROther(other);
team = __fr_other10.team;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11;
;
var __fr_other12=scrFROther(other);
hitid = __fr_other12.hitid;
;
repeat (12) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, (scrFROther(other)).gunangle)), (y + lengthdir_y(10, (scrFROther(other)).gunangle)), Smoke)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
var __fr_other16=scrFROther(other);
scrFRMotionAdd((__fr_other16.direction + scrFRSourceRandomRange((- 10), 10)), (2 + scrFRSourceRandom(2)));
}
}
if(__fr_break15) break;
}}
}
}
}
if(__fr_break7) break;
}}
fuseTime += 25;
;
ammoType = "Cannonball";
;
}
} else {
{
scrFRSoundPitch(sndGrenadeRifle, (0.6 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosion, (1.4 + scrFRSourceRandom(0.2)));
;
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
wkick = 12;
;
{ var __fr_with17 = scrFRWithValues(fr_Objects_Frontier_Caves_mod_gml_MortarCannonball_create(x, y)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
zspeed = 10;
;
var __fr_other20=scrFROther(other);
direction = point_direction(x, y, __fr_other20.target_x, __fr_other20.target_y);
;
var __fr_other21=scrFROther(other);
speed = (((point_distance(x, y, __fr_other21.target_x, __fr_other21.target_y) * zfriction) / (zspeed * 2))) * timescale;
;
image_angle = direction;
;
var __fr_other22=scrFROther(other);
team = __fr_other22.team;
;
var __fr_other23=scrFROther(other);
creator = __fr_other23;
;
var __fr_other24=scrFROther(other);
hitid = __fr_other24.hitid;
;
repeat (12) {
{ var __fr_with25 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, (scrFROther(other)).gunangle)), (y + lengthdir_y(10, (scrFROther(other)).gunangle)), Smoke)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
var __fr_other28=scrFROther(other);
scrFRMotionAdd((__fr_other28.direction + scrFRSourceRandomRange((- 10), 10)), (2 + scrFRSourceRandom(2)));
}
}
if(__fr_break27) break;
}}
}
}
}
if(__fr_break19) break;
}}
ammoType = "Barrel";
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1281
function fr_Objects_Frontier_Caves_mod_gml_EliteWhale_death() {
scrFRPickupDrop(70, 25);
;
}

// Original Objects/Frontier_Caves.mod.gml:1284
function fr_Objects_Frontier_Caves_mod_gml_Parrot_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Parrot";
var _frl_topStyle = scrFRSourceChoose(1, 2, 3, 4);
;
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotTopLayerIdle, _frl_topStyle);
spr_idle2 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerIdle;
;
spr_idle3 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerIdle;
;
spr_walk = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotTopLayerWalk, _frl_topStyle);
;
spr_walk2 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerWalk;
;
spr_walk3 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerWalk;
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotTopLayerHurt, _frl_topStyle);
;
spr_hurt2 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotBaseLayerHurt;
;
spr_hurt3 = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotMiddleLayerHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotDead;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotGameover;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
sprite_index2 = spr_idle2;
;
sprite_index3 = spr_idle3;
;
spr_weap = sprHammer;
;
var _frl_colorHue = scrFRSourceRandom(255);
;
pColor1 = make_color_hsv(_frl_colorHue, (155 + scrFRSourceRandom(100)), 255);
;
pColor2 = scrFRSourceChoose(c_white, make_color_hsv((30 + scrFRSourceRandom(170)), (155 + scrFRSourceRandom(100)), 255));
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_gameover, "PARROT"];
spr_shadow = shd24;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 10, "=");
;
hp = max_hp;
;
raddrop = 3;
;
maxspeed = (4) * timescale;
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
gunangle = 180;
;
wepangle = (- 140);
;
meleeWeapon = false;
;
myWeapon = scrFRSourceChoose("flintlock", "cutlass");
{ var __fr_switch_value4=myWeapon, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("flintlock")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("cutlass")) __fr_switch_case5=1;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
{
meleeWeapon = false;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotWeapFlintlock;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndGunParrotDead;
;
break;
;
}
case 1:
{
meleeWeapon = true;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotWeapCutlass;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndSwordParrotHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndSwordParrotDead;
;
maxspeed = (4.5) * timescale;
;
break;
;
}
}
}
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(30)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Parrot_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_Parrot_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Parrot_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_Parrot_death;
;
on_alrm1 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Parrot_alrm1];
;
on_alrm2 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Parrot_alrm2];
;
if ((global.fr_module_vars[$ "mod:Frontier_Caves"].settingLowQualityParrots == true)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotLQHurt;
;
pColor1 = make_color_rgb(0, 184, 0);
;
on_step = fr_Objects_Frontier_Caves_mod_gml_ParrotLQ_step;
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_ParrotLQ_draw;
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

// Original Objects/Frontier_Caves.mod.gml:1387
function fr_Objects_Frontier_Caves_mod_gml_Parrot_step() {
; // macro hoisted: p_sprite2
; // macro hoisted: p_sprite3
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Caves_mod_gml_alarm2_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
sprite_index2 = frMacro_Objects_Frontier_Caves_mod_gml_p_sprite2;
;
sprite_index3 = frMacro_Objects_Frontier_Caves_mod_gml_p_sprite3;
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Caves.mod.gml:1407
function fr_Objects_Frontier_Caves_mod_gml_Parrot_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(30)), "=");
;
if ((fr_Objects_Frontier_Caves_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_look(frMacro_Objects_Frontier_Caves_mod_gml_target_direction);
;
if ((meleeWeapon == true)) {
{
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 48)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (5 + scrFRSourceIRandom(10)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + fr_Objects_Frontier_Caves_mod_gml_orandom(50)), (scrFRAlarmRead(scrFRSelf(self), 1) - 5));
;
}
}
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance < 64)) {
{
if ((fr_Objects_Frontier_Caves_mod_gml_chance(4, 5) && (frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 4))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, HitWarning)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
}
}
if(__fr_break3) break;
}}
walk = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
fuseTime = 12;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
gunangle = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(5)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
}
}
}
}
if ((meleeWeapon == false)) {
{
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 160)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
} else {
{
if ((fr_Objects_Frontier_Caves_mod_gml_chance(2, 3) && (frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 48))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(10)), "=");
;
fuseTime = 16;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
gunangle = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
scrFRSoundPitch(sndEmpty, (1.3 + scrFRSourceRandom(0.2)));
scrFRSoundPitch(sndSwapMachinegun, (1.3 + scrFRSourceRandom(0.2)));
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Caves_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
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
if (fr_Objects_Frontier_Caves_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1481
function fr_Objects_Frontier_Caves_mod_gml_Parrot_alrm2() {
if ((fuseTime > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
if ((meleeWeapon == false)) {
{
if ((fuseTime >= 8)) {
{
if ((scrFRInstanceExists(target) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible)) {
{
gunangle = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
}
}
}
}
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(12, (scrFROther(other)).gunangle)), (y + lengthdir_y(12, (scrFROther(other)).gunangle)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = (0.2 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd((__fr_other4.gunangle + (__fr_other4.right * 100)), (1 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if (((-- fuseTime) <= 0)) {
{
if ((meleeWeapon == true)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemySlash)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
damage = 3;
;
speed = (2) * timescale;
;
var __fr_other8=scrFROther(other);
direction = (__fr_other8.gunangle + scrFRSourceRandomRange((- 3), 3));
;
image_angle = direction;
;
var __fr_other9=scrFROther(other);
creator = __fr_other9;
;
var __fr_other10=scrFROther(other);
team = __fr_other10.team;
var __fr_other11=scrFROther(other);
hitid = __fr_other11.hitid;
;
}
}
if(__fr_break7) break;
}}
scrFRMotionAdd(gunangle, 1.5);
;
wkick = (- 4);
;
wepangle *= (- 1);
;
scrFRSoundPlay(sndAssassinAttack);
;
scrFRSoundPitch(sndScrewdriver, (0.7 + scrFRSourceRandom(0.3)));
;
}
} else {
{
scrFRSoundPitch(sndExplosionS, (1.4 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndHeavyRevolver, (1.4 + scrFRSourceRandom(0.2)));
;
wkick = 12;
;
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet4)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
damage = 3;
;
speed = ((13 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
var __fr_other15=scrFROther(other);
direction = (__fr_other15.gunangle + scrFRSourceRandomRange((- 10), 10));
;
image_angle = direction;
;
var __fr_other16=scrFROther(other);
creator = __fr_other16;
;
var __fr_other17=scrFROther(other);
team = __fr_other17.team;
;
var __fr_other18=scrFROther(other);
hitid = __fr_other18.hitid;
;
}
}
if(__fr_break14) break;
}}
repeat (scrFRSourceIRandomRange(6, 12)) {
{ var __fr_with19 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprWhiteSmoke);
;
var __fr_other22=scrFROther(other);
direction = (__fr_other22.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break21) break;
}}
}
repeat (7) {
{ var __fr_with23 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
speed = ((6 + (scrFRSourceRandom(3) * power(0.8, scrFRGetSkill(mut_euphoria))))) * timescale;
;
var __fr_other26=scrFROther(other);
direction = (__fr_other26.gunangle + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
var __fr_other27=scrFROther(other);
creator = __fr_other27;
;
var __fr_other28=scrFROther(other);
team = __fr_other28.team;
;
var __fr_other29=scrFROther(other);
hitid = __fr_other29.hitid;
;
}
}
if(__fr_break25) break;
}}
}
}
}
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1558
function fr_Objects_Frontier_Caves_mod_gml_Parrot_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
sprite_index2 = spr_hurt2;
;
sprite_index3 = spr_hurt3;
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

// Original Objects/Frontier_Caves.mod.gml:1570
function fr_Objects_Frontier_Caves_mod_gml_Parrot_death() {
repeat ((6 + scrFRSourceIRandom(4))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Feather)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprParrotFeather);
;
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.pColor1;
;
}
}
if(__fr_break3) break;
}}
}
scrFRPickupDrop(20, 0);
}

// Original Objects/Frontier_Caves.mod.gml:1579
function fr_Objects_Frontier_Caves_mod_gml_Parrot_draw() {
if ((meleeWeapon == false)) {
{
if ((gunangle < 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index2, image_index, x, y, (image_xscale * right), image_yscale, image_angle, pColor1, image_alpha);
;
scrFRDrawSpriteExt(sprite_index3, image_index, x, y, (image_xscale * right), image_yscale, image_angle, pColor2, image_alpha);
;
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
if ((gunangle < 180)) {
{
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index2, image_index, x, y, (image_xscale * right), image_yscale, image_angle, pColor1, image_alpha);
;
scrFRDrawSpriteExt(sprite_index3, image_index, x, y, (image_xscale * right), image_yscale, image_angle, pColor2, image_alpha);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle >= 180)) {
{
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1609
function fr_Objects_Frontier_Caves_mod_gml_ParrotLQ_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Caves_mod_gml_alarm2_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Caves.mod.gml:1625
function fr_Objects_Frontier_Caves_mod_gml_ParrotLQ_draw() {
if ((meleeWeapon == false)) {
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
if ((gunangle < 180)) {
{
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle >= 180)) {
{
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1651
function fr_Objects_Frontier_Caves_mod_gml_Starfish_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Starfish";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishDead;
;
spr_tell = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishTell;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishChrg;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "STARFISH"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Caves"].shdStarfish;
;
nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)];
water_breathing = true;
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
spr_bubble_x = 0;
;
spr_bubble_y = 0;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
raddrop = 2;
;
maxspeed = (1) * timescale;
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
charge = 0;
;
charge_wait = 0;
;
charge_dir = 0;
;
charge_speed = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Starfish_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_Starfish_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_Starfish_death;
;
on_alrm1 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_Starfish_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:1712
function fr_Objects_Frontier_Caves_mod_gml_Starfish_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
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
if ((((sprite_index != spr_chrg) && (sprite_index != spr_tell)) || frMacro_Objects_Frontier_Caves_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
}
}
if (((charge > 0) || (charge_wait > 0))) {
{
direction = charge_dir;
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
if ((charge_wait > 0)) {
{
charge_wait -= scrFRSourceScale();
;
x += ((fr_Objects_Frontier_Caves_mod_gml_orandom(1) - lengthdir_x((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
y += ((fr_Objects_Frontier_Caves_mod_gml_orandom(1) - lengthdir_y((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
}
}
if ((charge_wait <= 0)) {
{
scrFRSoundPitch(sndRatkingCharge, (1.5 + scrFRSourceRandom(0.2)));
;
}
}
}
} else {
if ((charge > 0)) {
{
charge -= scrFRSourceScale();
;
image_angle = charge_dir;
;
right = 1;
;
charge_speed -= (0.1 * scrFRSourceScale());
;
if (((charge_speed <= 1) || (charge <= 0))) {
{
charge = 0;
;
image_angle = 0;
;
}
}
scrFRMotionAdd(direction, charge_speed);
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall)) {
{
charge_dir += 180;
;
charge_speed -= 1;
;
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

// Original Objects/Frontier_Caves.mod.gml:1786
function fr_Objects_Frontier_Caves_mod_gml_Starfish_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
if ((fr_Objects_Frontier_Caves_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible)) {
{
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 140)) {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(3, 4)) {
{
charge = 40;
;
charge_wait = 10;
;
charge_dir = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
charge_speed = 5;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + (20 + scrFRSourceIRandom(15))), "=");
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(1, 3)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1814
function fr_Objects_Frontier_Caves_mod_gml_Starfish_death() {
scrFRPickupDrop(10, 0);
;
}

// Original Objects/Frontier_Caves.mod.gml:1817
function fr_Objects_Frontier_Caves_mod_gml_Starfish_draw() {
if ((charge <= 0)) {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}
} else {
{
scrFRDrawSpriteExt(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1824
function fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Powderfish";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishDead;
;
spr_tell = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishTell;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishChrg;
;
spr_glow = global.fr_module_vars[$ "mod:Frontier_Caves"].sprEliteStarfishChrgLight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "POWDERFISH"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Caves"].shdStarfish;
;
nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)];
water_breathing = true;
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
spr_bubble_x = 0;
;
spr_bubble_y = 0;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 16, "=");
;
hp = max_hp;
;
raddrop = 9;
;
maxspeed = (1.8) * timescale;
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
charge = 0;
;
charge_wait = 0;
;
charge_dir = 0;
;
charge_speed = 0;
;
charge_bounces = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_death;
;
on_alrm1 = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:1887
function fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Caves_mod_gml_alarm1_run)) {
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
if ((((sprite_index != spr_chrg) && (sprite_index != spr_tell)) || frMacro_Objects_Frontier_Caves_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
}
}
if (((charge > 0) || (charge_wait > 0))) {
{
direction = charge_dir;
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
if ((charge_wait > 0)) {
{
charge_wait -= scrFRSourceScale();
;
x += ((fr_Objects_Frontier_Caves_mod_gml_orandom(1) - lengthdir_x((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
y += ((fr_Objects_Frontier_Caves_mod_gml_orandom(1) - lengthdir_y((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
}
}
if ((charge_wait <= 0)) {
{
scrFRSoundPitch(sndRatkingCharge, (1.5 + scrFRSourceRandom(0.2)));
;
}
}
}
} else {
if ((charge > 0)) {
{
if ((charge_bounces <= 0)) {
{
charge_speed -= (0.6 * scrFRSourceScale());
;
}
}
if ((charge_speed <= 0)) {
{
charge = 0;
;
}
}
scrFRMotionAdd(direction, charge_speed);
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 6), 6)), (y + scrFRSourceRandomRange((- 6), 6)), TrapFire)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 15), 15));
;
image_speed = (0.8) * timescale;
;
speed = (2) * timescale;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6;
;
var __fr_other7=scrFROther(other);
hitid = __fr_other7.hitid;
;
}
}
if(__fr_break3) break;
}}
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall)) {
{
charge_dir += (180 + fr_Objects_Frontier_Caves_mod_gml_orandom(30));
;
charge_speed -= 1;
;
charge_bounces -= 1;
;
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

// Original Objects/Frontier_Caves.mod.gml:1970
function fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
if (((fr_Objects_Frontier_Caves_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Caves_mod_gml_target_visible) && (charge <= 0))) {
{
if ((frMacro_Objects_Frontier_Caves_mod_gml_target_distance > 172)) {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk((frMacro_Objects_Frontier_Caves_mod_gml_target_direction + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Caves_mod_gml_chance(4, 5)) {
{
charge = 1;
;
charge_wait = 20;
;
charge_dir = frMacro_Objects_Frontier_Caves_mod_gml_target_direction;
;
charge_speed = 7;
;
charge_bounces = 3;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + (20 + scrFRSourceIRandom(15))), "=");
;
}
}
}
}
}
} else {
{
if ((charge <= 0)) {
{
fr_Objects_Frontier_Caves_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Caves_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:1999
function fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if (((charge > 0) && (charge_wait <= 0))) {
{
scrFRDrawSpriteExt(spr_glow, image_index, x, y, ((image_xscale * right) * 1.5), (image_yscale * 1.5), image_angle, image_blend, (image_alpha - 0.6));
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2005
function fr_Objects_Frontier_Caves_mod_gml_EliteStarfish_death() {
scrFRPickupDrop(16, 0);
;
}

// Original Objects/Frontier_Caves.mod.gml:2008
function fr_Objects_Frontier_Caves_mod_gml_StarfishSing_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Starfish";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sprStarfishSingDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "STARFISH"];
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Caves"].shdStarfish;
;
nts_color_blood = [c_orange, make_color_rgb(135, 70, 35)];
water_breathing = true;
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
spr_bubble_x = 0;
;
spr_bubble_y = 0;
;
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 16, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (1) * timescale;
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
sndSing = noone;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Caves", fr_Objects_Frontier_Caves_mod_gml_StarfishSing_step];
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Caves_mod_gml_StarfishSing_death;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:2063
function fr_Objects_Frontier_Caves_mod_gml_StarfishSing_step() {
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Caves_mod_gml_enemy_sprite);
;
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((! audio_is_playing(sndSing))) {
{
sndSing = scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Caves"].sndStarfishSing);
;
}
}
if (scrFRInstanceExists(Player)) {
{
var _frl__nearestPlayer = instance_nearest(x, y, Player);
var _frl__dis = distance_to_object(_frl__nearestPlayer);
var _frl__honkVol = ((256 - _frl__dis) / 256);
;
scrFRSoundVolume(sndSing, clamp((1 * _frl__honkVol), 0, 10));
;
}
}
if ((scrFRSourceRandom(10) < 1)) {
{
fr_Objects_Frontier_Caves_mod_gml_MusicNote_create((x + scrFRSourceRandomRange((- 10), 10)), (y - 10));
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2087
function fr_Objects_Frontier_Caves_mod_gml_StarfishSing_death() {
scrFRSoundStop(sndSing);
;
}

// Original Objects/Frontier_Caves.mod.gml:2090
function fr_Objects_Frontier_Caves_mod_gml_MusicNote_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprMusicNote);
;
image_index = scrFRSourceIRandom(image_number);
image_speed = (0) * timescale;
;
speed = ((1 + scrFRSourceRandom(1.5))) * timescale;
;
direction = 90;
;
lifetime = 10;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_MusicNote_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:2104
function fr_Objects_Frontier_Caves_mod_gml_MusicNote_step() {
lifetime -= scrFRSourceScale();
;
if ((lifetime < 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2113
function fr_Objects_Frontier_Caves_mod_gml_Cannonball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonball);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Caves"].mskCannonball;
;
speed = ((12 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
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
hitid = [sprite_index, "CANNONBALL"];
;
on_step = fr_Objects_Frontier_Caves_mod_gml_Cannonball_step;
;
on_destroy = fr_Objects_Frontier_Caves_mod_gml_Cannonball_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:2134
function fr_Objects_Frontier_Caves_mod_gml_Cannonball_step() {
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), NTTEFullSweat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = c_black;
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
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), BulletHit)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonballTrail);
;
var __fr_other8=scrFROther(other);
direction = ((__fr_other8.direction + 180) + scrFRSourceRandomRange((- 20), 20));
;
speed = (3) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}
image_angle += (40 * scrFRSourceScale());
;
}

// Original Objects/Frontier_Caves.mod.gml:2150
function fr_Objects_Frontier_Caves_mod_gml_Cannonball_destroy() {
scrFRSoundPlay(sndExplosionL);
;
scrFRSoundPlay(sndExplosionS);
;
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
{
i = 0;
for (; (i < 360); i += 90) {
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
}
repeat (5) {
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((6 + scrFRSourceRandom(3))) * timescale;
;
var __fr_other12=scrFROther(other);
hitid = __fr_other12.hitid;
;
}
}
if(__fr_break11) break;
}}
}
}

// Original Objects/Frontier_Caves.mod.gml:2169
function fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "lobbedBarrel";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprMortarBarrel);
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
hitid = [sprite_index, "BARREL"];
;
z = 5;
;
zspeed = 0;
;
zfriction = 1;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_step;
;
on_destroy = fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_destroy;
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:2194
function fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_step() {
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
if ((z <= 4)) {
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
if (((distance_to_object(Floor) < 20) || scrFRPlaceMeeting(x, y, Player))) {
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
depth = (- 10);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2243
function fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_destroy() {
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GunpowderCreep_create", (x + fr_Objects_Frontier_Caves_mod_gml_orandom(32)), (y + fr_Objects_Frontier_Caves_mod_gml_orandom(32)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
hitid = __fr_other4.hitid;
;
}
}
if(__fr_break3) break;
}}
}
repeat ((4 + scrFRSourceIRandom(3))) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprMortarBarrelDebris);
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
scrFRSoundPitch(sndWallBreakJungle, (1.2 + scrFRSourceRandom(0.2)));
;
}

// Original Objects/Frontier_Caves.mod.gml:2260
function fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 70)), (image_yscale + (z / 70)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Caves.mod.gml:2263
function fr_Objects_Frontier_Caves_mod_gml_MortarCannonball_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "lobbedCannonball";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonball);
;
speed = ((12 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
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
hitid = [sprite_index, "CANNONBALL"];
;
z = 5;
;
zspeed = 0;
;
zfriction = 1;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_MortarCannonball_step;
;
on_destroy = fr_Objects_Frontier_Caves_mod_gml_Cannonball_destroy;
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_MortarBarrel_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Caves.mod.gml:2288
function fr_Objects_Frontier_Caves_mod_gml_MortarCannonball_step() {
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), ((y - z) + scrFRSourceRandomRange((- 8), 8)), NTTEFullSweat)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = c_black;
;
var __fr_other4=scrFROther(other);
direction = (((__fr_other4.direction + 180) + (__fr_other4.z / 70)) + scrFRSourceRandomRange((- 20), 20));
;
var __fr_other5=scrFROther(other);
image_xscale = (1 + (__fr_other5.z / 70));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), ((y - z) + scrFRSourceRandomRange((- 8), 8)), BulletHit)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprCannonballTrail);
;
var __fr_other9=scrFROther(other);
direction = (((__fr_other9.direction + 180) + (__fr_other9.z / 70)) + scrFRSourceRandomRange((- 20), 20));
;
speed = (3) * timescale;
;
var __fr_other10=scrFROther(other);
image_xscale = (1 + (__fr_other10.z / 70));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break8) break;
}}
}
}
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
image_angle -= (sign((hspeed / timescale)) * (abs(((vspeed / timescale) / 2)) + abs((hspeed / timescale))));
;
if ((z <= 4)) {
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
var _frl__m = 4;
;
if (((speed / timescale) > _frl__m)) {
speed = (_frl__m) * timescale;
}
}
}
if ((zspeed < (- 10))) {
{
if (((distance_to_object(Floor) < 20) || scrFRPlaceMeeting(x, y, Player))) {
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
depth = (- 10);
;
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2346
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprDebris4);
;
image_index = scrFRSourceIRandom(image_number);
;
image_alpha = 0;
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = (- 10);
;
turnSpeed = ((4 + scrFRSourceRandom(6)) * scrFRSourceChoose((- 1), 1));
;
speed = (0) * timescale;
;
typ = 1;
;
damage = 6;
;
hitid = [sprite_index, "FALLING ROCK"];
;
ammo_type = (- 1);
;
z = 300;
;
zspeed = (- 8);
;
team = "rock";
;
smacked = false;
;
on_step = fr_Objects_Frontier_Caves_mod_gml_FallingRock_step;
;
on_hit = fr_Objects_Frontier_Caves_mod_gml_FallingRock_hit;
;
on_destroy = fr_Objects_Frontier_Caves_mod_gml_FallingRock_destroy;
;
on_draw = fr_Objects_Frontier_Caves_mod_gml_FallingRock_draw;
;
{ var __fr_with4 = scrFRWithValues(scrFRBindDraw(fr_Objects_Frontier_Caves_mod_gml_FallingRock_warningDraw, (- 1))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
telegraph_angle = 0;
;
telegraph_scale = 0;
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

// Original Objects/Frontier_Caves.mod.gml:2386
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_step() {
image_angle += turnSpeed;
;
if ((smacked == false)) {
{
if ((team != "rock")) {
{
smacked = true;
;
speed = (14) * timescale;
;
turnSpeed = (12 + scrFRSourceChoose((- 1), 1));
;
z = 0;
telegraph_scale = 0;
;
exit;
;
}
}
z += (zspeed * scrFRSourceScale());
;
if (((z <= 150) && (image_alpha < 1))) {
{
image_alpha += 0.1;
;
}
}
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
depth = (- 3);
;
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2422
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_hit() {
if (scrFRProjectileCanHit((scrFROther(other)))) {
{
if (scrFRInstanceIs((scrFROther(other)), Player)) {
{
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
}
} else {
{
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, (damage * 3));
;
}
}
}
}
}

// Original Objects/Frontier_Caves.mod.gml:2431
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_destroy() {

}

// Original Objects/Frontier_Caves.mod.gml:2433
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 260)), (image_yscale + (z / 260)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Caves.mod.gml:2436
function fr_Objects_Frontier_Caves_mod_gml_FallingRock_warningDraw() {
telegraph_angle += 6;
;
if ((telegraph_scale < 1)) {
{
telegraph_scale += 0.1;
;
}
}
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Caves"].sprFallingRockWarning, 0, x, y, telegraph_scale, telegraph_scale, telegraph_angle, c_white, 1);
;
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
; // macro hoisted: _tespr
;
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

// Original Objects/Frontier_Caves.mod.gml:2466
function fr_Objects_Frontier_Caves_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Caves.mod.gml:2467
function fr_Objects_Frontier_Caves_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Caves.mod.gml:2468
function fr_Objects_Frontier_Caves_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Caves.mod.gml:2469
function fr_Objects_Frontier_Caves_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Caves.mod.gml:2470
function fr_Objects_Frontier_Caves_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Caves.mod.gml:2471
function fr_Objects_Frontier_Caves_mod_gml_enemy_face(_frl__dir=undefined) {
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

// Original Objects/Frontier_Caves.mod.gml:2472
function fr_Objects_Frontier_Caves_mod_gml_enemy_look(_frl__dir=undefined) {
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

// Original Objects/Frontier_Caves.mod.gml:2473
function fr_Objects_Frontier_Caves_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Caves.mod.gml:2474
function fr_Objects_Frontier_Caves_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Caves.mod.gml:2475
function fr_Objects_Frontier_Caves_mod_gml_GunEnemy_draw() {
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

// Original Objects/Frontier_Caves.mod.gml:2476
function fr_Objects_Frontier_Caves_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Caves.mod.gml:2477
function fr_Objects_Frontier_Caves_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Caves_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Caves.mod.gml:2478
function fr_Objects_Frontier_Caves_mod_gml_nothing() {

}

// Original Objects/Frontier_Caves.mod.gml:2479
function fr_Objects_Frontier_Caves_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Caves.mod.gml:2489
function fr_Objects_Frontier_Caves_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Caves.mod.gml:2498
function fr_Objects_Frontier_Caves_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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

// Original Objects/Frontier_Caves.mod.gml:2521
function fr_Objects_Frontier_Caves_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Caves.mod.gml:2533
function fr_Objects_Frontier_Caves_mod_gml_MuzzleFlash_anim() {
image_index = 1;
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Caves.mod.gml:2537
function fr_Objects_Frontier_Caves_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Caves"].sprGenericTrail);
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
