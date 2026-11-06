#macro frMacro_Frontier_Events_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Events"].scr

#macro frMacro_Frontier_Events_mod_gml_call scrFRScriptCall

#macro frMacro_Frontier_Events_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Frontier_Events_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Frontier_Events_mod_gml__tespr scrFRModGet("mod", "teassets", "spr")

#macro frMacro_Frontier_Events_mod_gml__temus (scrFRModGet("mod", "teassets", "snd")).mus

#macro frMacro_Frontier_Events_mod_gml__vagabondsspr scrFRModGet("mod", "vagabonds_assets", "sprite")

#macro frMacro_Frontier_Events_mod_gml_area_current (scrFRInstanceExists(GameCont) ? [GameCont.area, GameCont.subarea] : [(- 1), (- 1)])

#macro frMacro_Frontier_Events_mod_gml_FloorNormal scrFRMatching(Floor, "object_index", Floor)

#macro frMacro_Frontier_Events_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_Frontier_Events_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

#macro frMacro_Frontier_Events_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Frontier_Events_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Frontier_Events.mod.gml:1
function fr_Frontier_Events_mod_gml___load() {

}

// Original Frontier_Events.mod.gml:1
function fr_Frontier_Events_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Frontier_Events_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:9
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Events", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "PortalStorm", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "MeteorShower", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "Casino", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "PaintorCamp", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "Thunderstorm", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "ScrapyardsNight", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "Blizzard", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "Aurora", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "Blackout", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "BoilingWater", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "SerpentLair", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "DebugEvent1", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "CoastNight", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "HoarderSpawn", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "CurseSpread", "Frontier_Events");
;
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_add, "HauntedCity", "Frontier_Events");
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingNightEventSpawnChance = 0.2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingPaintorCampEventSpawnChance = 0.03;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingThunderstormEventSpawnChance = 0.1;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingCurseSpreadEventSpawnChance = 0.08;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingBlizzardEventSpawnChance = 0.1;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingHauntedCityEventSpawnChance = 0.06;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingBlackoutEventSpawnChance = 0.2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingSerpentLairEventSpawnChance = 0.13;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingPortalStormEventSpawnChance = 0.02;
;
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].eventAmbiencePlaying = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic = (- 4);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = (- 4);
;
global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].pickupMeteorFalls = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].maxPickupMeteors = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].nightLoop = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns = true;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingLightningFlash = true;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingMaxAuroras = 3;
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingVeeOneHundred = (1 > 0);
;
global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops = false;
;
global.fr_module_vars[$ "mod:Frontier_Events"].musDesertNight = sndFR_musDesertNight_9b00b29bba8c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].musCasino = sndFR_musCasino_665fb3900448;
;
global.fr_module_vars[$ "mod:Frontier_Events"].musThunderstorm = sndFR_musThunderstorm_479939d45f5d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].musScrapyardsNight = sndFR_musScrapyardsNight_66d742ea9133;
;
global.fr_module_vars[$ "mod:Frontier_Events"].musFrozenCityNight = sndFR_musFrozenCityNight_a0898edec1db;
;
global.fr_module_vars[$ "mod:Frontier_Events"].ambBlizzard = sndFR_ambBlizzard_7b33b7ddd201;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroNight = sndFR_sndEventIntroNight_b82a5678c267;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroWeather = sndFR_sndEventIntroWeather_91ead3afb3f5;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroSerpent = sndFR_sndEventIntroSerpent_f11682210ca0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndImpostorAlert = sndFR_sndImpostorAlert_11149f1cf619;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank = sndFR_sndBlank_7a95d727acba;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank2 = sndFR_sndBlank_7a95d727acba;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdowns = sprFR_sprEventDropdowns_25108078e246;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdownsBack = sprFR_sprEventDropdownsBack_795bfb47c20e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCasinoFloor = sprFR_sprCasinoFloor_65bd465d2d3c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVignette = sprFR_sprVignette_835991339c2f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVignetteOuter = sprFR_sprVignetteOuter_a4a0caae4542;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVignetteOuterBlackout = sprFR_sprVignetteOuterBlackout_8f293091b4e3;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSolidColorFog = sprFR_sprSolidColorFog_9ebc4a1429e4;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprPalaceTrapScorchMark = sprFR_sprPalaceTrapScorchMark_8c1e1df9f7c4;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor1BNight = sprFR_sprFloor1BNight_3a99c83e7bc7;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWindNightEvent = sprFR_sprWindNightEvent_b3ccd821ce0a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorGlow = sprFR_sprMeteorGlow_9e37aa655f3a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorSparkle = sprFR_sprMeteorSparkle_a90307df372f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorHit = sprFR_sprMeteorHit_f91b4bf8c30d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullNight = sprFR_sprBigSkullNight_fe836490c9bb;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullHurtNight = sprFR_sprBigSkullHurtNight_6191aa06922a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullDeadNight = sprFR_sprBigSkullDeadNight_19e6a741d5e2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullOpenNight = sprFR_sprBigSkullOpenNight_30a64e6e4a73;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullOpenHurtNight = sprFR_sprBigSkullOpenHurtNight_3c4404eb0f6b;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDesertProtoStatueDecalNight = sprFR_sprDesertProtoStatueDeca_bf6edff2f9f7;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDesertProtoStatueDecalDeadNight = sprFR_sprDesertProtoStatueDeca_3c81c714e4c6;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall1BotBNight = sprFR_sprWall1BotBNight_97c9ae7c1389;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusSnowFloorDesertBNight = sprFR_sprSnowFloorDesertBNight_e6f0a16ff0d9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusFloorDesertBOutNight = sprFR_sprFloorDesertBOutNight_b8d8c013aacf;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertBNight = sprFR_sprDetailDesertBNight_a8991a5a4cd0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertMudBNight = sprFR_sprDetailDesertMudBNight_88b05428f246;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertMudBigNight = sprFR_sprDetailDesertMudBigNig_a879276d684f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFogThunderstorm = sprFR_sprFogThunderstorm_87c6d4059bc5;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRainDropThunderstorm = sprFR_sprRainDropThunderstorm_22089d2857a6;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircle = sprFR_sprLightningStrikeWarnin_c2f2ddd24278;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleBlink = sprFR_sprLightningStrikeWarnin_3efd40af5ca9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleAce = sprFR_sprLightningStrikeWarnin_b67ef3c77413;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleBlinkAce = sprFR_sprLightningStrikeWarnin_686f8328e177;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3Night = sprFR_sprFloor3Night_6df86447c1a0;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3BNight = sprFR_sprFloor3BNight_97c2576d1bfc;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3ExploNight = sprFR_sprFloor3ExploNight_fd2c893aa2ff;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3BotNight = sprFR_sprWall3BotNight_0b4a851d4a7c;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TopNight = sprFR_sprWall3TopNight_d1691cc95e54;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TransNight = sprFR_sprWall3TransNight_5c6a0c2e98a8;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3OutNight = sprFR_sprWall3OutNight_78f7106fe006;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDebris3Night = sprFR_sprDebris3Night_58fa7c0ae863;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetail3Night = sprFR_sprDetail3Night_916acb591137;
global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapDecalNight = sprFR_sprScrapDecalNight_1b903dbc7e9a;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTopDecalScrapyardNight = sprFR_sprTopDecalScrapyardNigh_797c74fb65a8;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTrapNight = sprFR_sprTrapNight_e9e02d130082;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTrapScorchMarkNight = sprFR_sprTrapScorchMarkNight_e1cabf7157fc;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCarIdleNight = sprFR_sprCarIdleNight_4b0c6be0f852;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCarHurtNight = sprFR_sprCarHurtNight_ab4f2eb5ab50;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVenusCarIdleNight = sprFR_sprVenusCarIdleNight_927d78665750;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVenusCarHurtNight = sprFR_sprVenusCarHurtNight_27e70889f8b6;
global.fr_module_vars[$ "mod:Frontier_Events"].sprVenusCarIdleNight = sprFR_sprVenusCarIdleNight_927d78665750;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresIdleNight = sprFR_sprTiresIdleNight_3700ce3dc1cc;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresHurtNight = sprFR_sprTiresHurtNight_f9a3dbcee4ef;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresDeadNight = sprFR_sprTiresDeadNight_2c7461226f35;
global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardProtoStatueDecalNight = sprFR_sprScrapyardProtoStatueD_16b8505dcc42;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardProtoStatueDecalDeadNight = sprFR_sprScrapyardProtoStatueD_88f6b06b6b23;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardCoveEntranceClosedNight = sprFR_sprScrapyardCoveEntrance_e5fe289578dc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardCoveEntranceOpenNight = sprFR_sprScrapyardCoveEntrance_cec113a8e7ba;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCoveEntranceDebrisNight = sprFR_sprCoveEntranceDebrisNig_03e69adab614;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5Night = sprFR_sprFloor5Night_1f0217657d44;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5BNight = sprFR_sprFloor5BNight_7b1fa1091232;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorNight = sprFR_sprSnowFloorNight_e9c389b46e17;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5ExploNight = sprFR_sprFloor5ExploNight_33a4e4627d6c;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5BotNight = sprFR_sprWall5BotNight_ad21063924c9;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TopNight = sprFR_sprWall5TopNight_36f5c6c9b825;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TransNight = sprFR_sprWall5TransNight_44ec8b9a18c0;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5OutNight = sprFR_sprWall5OutNight_4d3ccfd0c1d5;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDebris5Night = sprFR_sprDebris5Night_68f8f45735c2;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetail5Night = sprFR_sprDetail5Night_acb04320bbc8;
global.fr_module_vars[$ "mod:Frontier_Events"].sprIceDecalNight = sprFR_sprIceDecalNight_d1de6a976368;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTopDecalCityNight = sprFR_sprTopDecalCityNight_f1d8c61ded04;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFrozenCarNight = sprFR_sprFrozenCarNight_87acbb492d63;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFrozenCarHurtNight = sprFR_sprFrozenCarHurtNight_2a463c283ccb;
global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightNight = sprFR_sprStreetLightNight_b1264830f249;
global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightHurtNight = sprFR_sprStreetLightHurtNight_f63dbbefc1e0;
global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightDeadNight = sprFR_sprStreetLightDeadNight_2f401b8fd319;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFlakeNight = sprFR_sprSnowFlakeNight_71c014a341b8;
global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantNight = sprFR_sprHydrantNight_bda1e9b75ed2;
global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantHurtNight = sprFR_sprHydrantHurtNight_00596cd7ee30;
global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantDeadNight = sprFR_sprHydrantDeadNight_0849abfd6370;
global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleNight = sprFR_sprIcicleNight_1e3d8f90e3ad;
global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleHurtNight = sprFR_sprIcicleHurtNight_1b55f70859c8;
global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleDeadNight = sprFR_sprIcicleDeadNight_769507461193;
global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandNight = sprFR_sprNewsStandNight_9416aa1ff6d5;
global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandHurtNight = sprFR_sprNewsStandHurtNight_ca12ac69113b;
global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandDeadNight = sprFR_sprNewsStandDeadNight_260392a4c052;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineNight = sprFR_sprSodaMachineNight_c159b5442914;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineHurtNight = sprFR_sprSodaMachineHurtNight_aaf17a77c3f5;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineDeadNight = sprFR_sprSodaMachineDeadNight_637c1b72b492;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManNight = sprFR_sprSnowManNight_90e724d2ea27;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManHurtNight = sprFR_sprSnowManHurtNight_6a901e79e956;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManDeadNight = sprFR_sprSnowManDeadNight_b435f923a402;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCityProtoStatueDecalNight = sprFR_sprCityProtoStatueDecalN_9eb099aa16ee;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCityProtoStatueDecalDeadNight = sprFR_sprCityProtoStatueDecalD_e7b7cbe5d200;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBlizzardSnow = sprFR_sprBlizzardSnow_3c831a8e2c63;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBlizzardSnowNight = sprFR_sprBlizzardSnowNight_db66d5dcd4cc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFogBlackout = sprFR_sprFogBlackout_c9b9f6f1db50;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWall6BotBlackout = sprFR_sprWall6BotBlackout_699113af41bb;
global.fr_module_vars[$ "mod:Frontier_Events"].sprServerOff = sprFR_sprServerOff_82c79b939750;
global.fr_module_vars[$ "mod:Frontier_Events"].sprServerOffHurt = sprFR_sprServerOffHurt_ade1921de33c;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTerminalOff = sprFR_sprTerminalOff_4614aa7f9698;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprTerminalOffHurt = sprFR_sprTerminalOffHurt_c16cd23d16da;
;
global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoast = sprFR_sprFloorCoast_a8c9ebc0cf1e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight = sprFR_sprFloorCoastNight_db34ffe5c1ba;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastBNight = sprFR_sprFloorCoastBNight_934c937976e8;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastTrans = sprFR_sprCoastTrans_604bf48f6273;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastTransNight = sprFR_sprCoastTransNight_c3e36e843055;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailCoastNight = sprFR_sprDetailCoastNight_48a1f8006614;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingBushNight = sprFR_sprBloomingBushNight_901418da47d6;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusNight = sprFR_sprBloomingCactusNight_30cd136b1012;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusHurtNight = sprFR_sprBloomingCactusHurtNig_4269b784e729;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusDeadNight = sprFR_sprBloomingCactusDeadNig_2e550c5f1087;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2Night = sprFR_sprBloomingCactus2Night_a2d8c20132eb;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2HurtNight = sprFR_sprBloomingCactus2HurtNi_abb8fb07fa5f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2DeadNight = sprFR_sprBloomingCactus2DeadNi_96db9d1ace11;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3Night = sprFR_sprBloomingCactus3Night_44926134f0cc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3HurtNight = sprFR_sprBloomingCactus3HurtNi_49c5ee26995d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3DeadNight = sprFR_sprBloomingCactus3DeadNi_f47ec41860d0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusNight = sprFR_sprBigBloomingCactusNigh_b51e09a8f69b;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusHurtNight = sprFR_sprBigBloomingCactusHurt_09b8a43d0900;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusDeadNight = sprFR_sprBigBloomingCactusDead_a47edf430d5e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1IdleNight = sprFR_sprRock1IdleNight_4105740e8fc8;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1HurtNight = sprFR_sprRock1HurtNight_c144c6d1075a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1DeadNight = sprFR_sprRock1DeadNight_222cfe7d04dc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1BottNight = sprFR_sprRock1BottNight_b66bc0c69dbc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2IdleNight = sprFR_sprRock2IdleNight_3ccbc9f38013;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2HurtNight = sprFR_sprRock2HurtNight_41fff667cb64;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2DeadNight = sprFR_sprRock2DeadNight_cdce0ebb0ec9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2BottNight = sprFR_sprRock2BottNight_27e98bf8a0fd;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBuriedCarNight = sprFR_sprBuriedCarNight_3dad21eb9e73;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBuriedCarHurtNight = sprFR_sprBuriedCarHurtNight_f42cf76a4d53;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrafficCrabDead = sprFR_sprTrafficCrabDead_ced0c3987238;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrafficCrabHide = sprFR_sprTrafficCrabHide_8ecc57de05c8;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmIdleNight = sprFR_sprPalmNight_dcac75e940ff;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmHurtNight = sprFR_sprPalmHurtNight_6e283d3c47b9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmDeadNight = sprFR_sprPalmDeadNight_7472ac527dca;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmFortIdleNight = sprFR_sprPalmFortNight_535bb6d32a04;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmFortHurtNight = sprFR_sprPalmFortHurtNight_d495968f419b;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellIdleNight = sprFR_sprShellIdleNight_1c2210cb2064;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellHurtNight = sprFR_sprShellHurtNight_6e05737dcb6c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellDeadNight = sprFR_sprShellDeadNight_b0506c58de01;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellBottNight = sprFR_sprShellBottNight_9c11c6f7b452;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingChunk = sprFR_sprPalankingChunk_beab5e4bd3cb;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingChunkNight = sprFR_sprPalankingChunkNight_bc2d26ffc7d9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBott = sprFR_sprPalankingBase_7806693b44e4;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBottNight = sprFR_sprPalankingBaseNight_413666080bc2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingTaunt = sprFR_sprPalankingTaunt_1cfb453b0aea;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingCall = sprFR_sprPalankingCall_0a97aab4a7a6;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingIdle = sprFR_sprPalankingIdle_23b21c85b775;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingWalk = sprFR_sprPalankingWalk_511879089940;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingHurt = sprFR_sprPalankingHurt_38a29717ce28;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingDead = sprFR_sprPalankingDead_735583671982;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBurp = sprFR_sprPalankingBurp_36d630f6c100;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingFire = sprFR_sprPalankingFire_ec6ccf5774b9;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinIdle = sprFR_sprBloomingAssassinIdle_fcd88e61e04e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinWalk = sprFR_sprBloomingAssassinWalk_76aacb6756e5;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHurt = sprFR_sprBloomingAssassinHurt_1786d1e7a98a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinDead = sprFR_sprBloomingAssassinDead_277444c67c7c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHide = sprFR_sprBloomingAssassinHide_1d6e11354d62;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastProtoStatueDecalNight = sprFR_sprCoastProtoStatueDecal_526892fafe81;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastProtoStatueDecalDeadNight = sprFR_sprCoastProtoStatueDecal_0a821ab374ad;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorMeat = sprFR_sprFloorMeat_228a37864618;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorMeat = sprFR_sprSnowFloorMeat_039a100556ac;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatBot = sprFR_sprWallMeatBot_c847be4c7b25;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatTop = sprFR_sprWallMeatTop_80c15d02704e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatOut = sprFR_sprWallMeatOut_fa69cc64f768;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprMeatBones = sprFR_sprMeatBones_be4e76f46cd7;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoon = sprFR_sprBloodCocoon_1388c2624093;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoonHurt = sprFR_sprBloodCocoonHurt_0295e8dcbdce;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoonDead = sprFR_sprBloodCocoonDead_32598636a503;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactus = sprFR_sprBloodCactus_fd10133056ac;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactusHurt = sprFR_sprBloodCactusHurt_18edd730d16f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactusDead = sprFR_sprBloodCactusDead_15974a54e1e0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalDesert = sprFR_sprBigTopDecalDesert_b78c5780d48a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalDesertScorpion = sprFR_sprBigTopDecalScorpion_fa34960f9847;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWallBandit = sprFR_sprWallBandit_f84303464921;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1BotRubble = sprFR_sprWall1BotRubble_094d60b42497;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1TopRubble = sprFR_sprWall1TopRubble_7d986b635a53;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1OutRubble = sprFR_sprWall1OutRubble_803f501d78ee;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRock = sprFR_sprScorpionRock_eb2f8b04be4e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockHurt = sprFR_sprScorpionRockHurt_c8ec1bc2e805;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockDead = sprFR_sprScorpionRockDead_78b295178205;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockAlly = sprFR_sprScorpionRockAlly_34ac530c25fa;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorScorpion = sprFR_sprFloorScorpion_5aab1dee142e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatSnowFloorScorpion = sprFR_sprSnowFloorScorpion_ab6655749ae4;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullIdle = sprFR_sprCowSkull_f1554c6cbc56;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullHurt = sprFR_sprCowSkullHurt_c52045a3bb64;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullDead = sprFR_sprCowSkullDead_da4c23a467c2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFake = sprFR_sprCactusFakeIdle_ade9c966c40a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFakeHurt = sprFR_sprCactusFakeHurt_160cbf5d6ed8;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFakeDead = sprFR_sprCactusFakeDead_2e6c4b20f332;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake = sprFR_sprTinyCactaurFake_fa454812c5f5;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFakeHurt = sprFR_sprTinyCactaurFake_Hurt_e52994790612;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFakeDead = sprFR_sprTinyCactaurFake_Dead_5746200a5b54;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake2 = sprFR_sprTinyCactaurFake2_f6a0f5086a17;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake2Hurt = sprFR_sprTinyCactaurFake2_Hurt_0ba9459e665c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3 = sprFR_sprTinyCactaurFake3_68c0c9a31348;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3Hurt = sprFR_sprTinyCactaurFake3_Hurt_25ed58bfa2f0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3Dead = sprFR_sprTinyCactaurFake3_Dead_3494105b3330;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditCampfire = sprFR_sprBanditCampfire_e9e71694e639;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentIdle = sprFR_sprBanditTent_e1d24bfb04ac;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentHurt = sprFR_sprBanditTentHurt_4e9a85ce3f2d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentDead = sprFR_sprBanditTentDead_31a2b4425ffd;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallIdle = sprFR_sprBanditTentWall_5519eaa96491;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallHurt = sprFR_sprBanditTentWallHurt_339ff3c2fe00;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallDead = sprFR_sprBanditTentWallDead_ee7f4f220d58;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishBecomeIdle = sprFR_sprBigFishBuild_0c281a3ae44a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishSpwn = sprFR_sprBigFishSpawn_8ba3812eecc6;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishLeap = sprFR_sprBigFishLeap_a8e74e1f8109;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishRise = sprFR_sprBigFishRise_61a1b0019c2c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalScrapyard = sprFR_sprBigTopDecalScrapyard_58e9b30045dd;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFirePitScorch = sprFR_sprFirePitScorch_ef3fc8987e07;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatSludgePool = sprFR_sprSludgePool_7f1596db8f9d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTopDecalScrapyardAlt = sprFR_sprTopDecalScrapyardAlt_def5ba19c20e;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrapSpin = sprFR_sprTrapSpin_46703f8836bc;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSeal = sprFR_sprFloorSeal_bc062db7895c;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSealRoom = sprFR_sprFloorSealRoom_8206d7b5d00a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSealRoomBig = sprFR_sprFloorSealRoomBig_802b52cdfa43;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFront = sprFR_sprIglooFront_bc30e188f855;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFrontHurt = sprFR_sprIglooFrontHurt_abc561e06e26;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFrontDead = sprFR_sprIglooFrontDead_d91e1e0db31a;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSide = sprFR_sprIglooSide_06b1d399e86d;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSideHurt = sprFR_sprIglooSideHurt_d5440ec7776f;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSideDead = sprFR_sprIglooSideDead_919c0d313c00;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingStatue = [sprFR_sprPalankingStatue1_52addc727920, sprFR_sprPalankingStatue2_af744df693c2, sprFR_sprPalankingStatue3_b567bb559233, sprFR_sprPalankingStatue4_922ad82c6966];
global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingStatueDead = sprFR_sprPalankingStatueDead_fe6ad04eab69;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpost = sprFR_sprSnowFloorOutpost_dc4990865b41;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpostSnow = sprFR_sprSnowFloorOutpostSnow_ae62566cced3;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpostSnowNight = sprFR_sprSnowFloorOutpostSnowN_0216c9ce3a49;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCityWallOutpostBot = sprFR_sprCityWallOutpostBot_9f56069842c2;
;
global.fr_module_vars[$ "mod:Frontier_Events"].sprCityWallOutpostBotNight = sprFR_sprCityWallOutpostBotNig_2d4de223c58a;
;
vertex_format_begin();
vertex_format_add_position();
global.fr_module_vars[$ "mod:Frontier_Events"].lightningformat = vertex_format_end();
}
_fr.pc=0;
break;
case 3: // Frontier_Events.mod.gml:8
{
;
}
_fr.pc=2;
break;
case 4: // Frontier_Events.mod.gml:8
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Frontier_Events.mod.gml:8
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:372
function fr_Frontier_Events_mod_gml_game_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_game_start_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Frontier_Events_mod_gml_game_start_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_game_start");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:400
{
;
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Events"].musDesertNight);
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:400
_fr.wait_ticks=max(0,2); _fr.pc=1; return;
break;
case 3: // Frontier_Events.mod.gml:399
{
;
}
_fr.pc=2;
break;
case 4: // Frontier_Events.mod.gml:399
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Frontier_Events.mod.gml:396
{
;
scrFRModSet("mod", "radioactive", "track_found", false);
;
}
_fr.pc=4;
break;
case 6: // Frontier_Events.mod.gml:396
_fr.wait_ticks=max(0,1); _fr.pc=5; return;
break;
case 7: // Frontier_Events.mod.gml:395
_fr.pc = (scrFRTaskFork(_fr, 6)) ? 6 : 0;
break;
case 8: // Frontier_Events.mod.gml:394
_fr.pc = (scrFRModExists("mod", "radioactive", "menuhandler")) ? 7 : 0;
break;
case 9: // Frontier_Events.mod.gml:393
_fr.pc = (scrFRModLoaded("mod", "radioactive")) ? 8 : 0;
break;
case 10: // Frontier_Events.mod.gml:392
_fr.pc = (frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "MeteorShower")) ? 9 : 0;
break;
case 11: // Frontier_Events.mod.gml:373
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
if (scrFRModLoaded("mod", "teassets")) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml__tespr), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
FloorCoast = global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoast;
;
CoastTrans = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastTrans;
;
PalankingChunk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingChunk;
;
PalankingBott = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBott;
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRSpriteRestore(sprWind);
;
scrFRSpriteRestore(sprLeaf);
;
fr_Frontier_Events_mod_gml_SerpentLair_cleanup();
;
}
_fr.pc=10;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:407
function fr_Frontier_Events_mod_gml_draw_dark() {
draw_set_color($808080);
;
if (frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Blackout")) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=race, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(scrFRRaceTryResolve("eyes"))) __fr_switch_case5=0;
if(__fr_switch_case5==-1) __fr_switch_case5=1;
switch(__fr_switch_case5) {
case 0:
var _frl__eyesRadius = 0.3;
;
break;
;
case 1:
var _frl__eyesRadius = 0;
;
}
}
gpu_set_blendmode(bm_normal);
gpu_set_fog(1, c_white, 0, 0);
scrFRDrawSetVisibleAll(false);
;
scrFRDrawSetVisible(index, true);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprVignette, 0, x, y, ((global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale + _frl__eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), ((global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale + _frl__eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), 0, c_white, 1);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprVignetteOuterBlackout, 0, x, y, (((global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale + _frl__eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)) * 8), (((global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale + _frl__eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)) * 8), 0, c_white, 1);
scrFRDrawSetVisibleAll(true);
;
gpu_set_fog(0, c_white, 0, 0);
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:435
function fr_Frontier_Events_mod_gml_draw_dark_end() {
draw_set_color($000000);
;
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingLightningFlash == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomProjectile, "name", "Lightning Strike")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
draw_circle(x, y, (640 + scrFRSourceRandom(7)), false);
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_meteor")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
draw_circle(x, y, (20 + scrFRSourceRandom(5)), false);
}
if(__fr_break6) break;
}}
;
}

// Original Frontier_Events.mod.gml:446
function fr_Frontier_Events_mod_gml_LabsOutpost_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("UNWELCOME GUESTS", "FIELD TESTING")));
;
}

// Original Frontier_Events.mod.gml:447
function fr_Frontier_Events_mod_gml_LabsOutpost_area() {
return [1, 2, 3, 4, 5, 7];
;
}

// Original Frontier_Events.mod.gml:448
function fr_Frontier_Events_mod_gml_LabsOutpost_chance() {
return 0;
;
}

// Original Frontier_Events.mod.gml:450
function fr_Frontier_Events_mod_gml_LabsOutpost_create() {

}

// Original Frontier_Events.mod.gml:457
function fr_Frontier_Events_mod_gml_PortalStorm_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : "@sJUST MORE @ePORTALS"));
;
}

// Original Frontier_Events.mod.gml:458
function fr_Frontier_Events_mod_gml_PortalStorm_area() {
return [1, 2, 3, 4, 5, 6, 7];
;
}

// Original Frontier_Events.mod.gml:459
function fr_Frontier_Events_mod_gml_PortalStorm_chance() {
return (((GameCont.loops < 1) || ((GameCont.area == scrFRAreaTryResolve(7)) && (GameCont.subarea == 3))) ? 0 : (global.fr_module_vars[$ "mod:Frontier_Events"].settingPortalStormEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.04)));
;
}

// Original Frontier_Events.mod.gml:460
function fr_Frontier_Events_mod_gml_PortalStorm_hard() {
return 33;
;
}

// Original Frontier_Events.mod.gml:462
function fr_Frontier_Events_mod_gml_PortalStorm_create() {
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(7, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroWeather);
;
}
}
stormPortals = 0;
;
portalStormCooldown = 120;
;
maxPortals = (2 + GameCont.loops);
;
}

// Original Frontier_Events.mod.gml:473
function fr_Frontier_Events_mod_gml_PortalStorm_step() {
if ((portalStormCooldown >= 0)) {
{
portalStormCooldown -= scrFRSourceScale();
}
}
if ((stormPortals < maxPortals)) {
{
{ var __fr_with1 = scrFRWithValues(Floor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSourceRandom(600) < 1)) {
{
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 32), 32)), (y + scrFRSourceRandomRange((- 32), 32)), PortalL);
}
}
}
}
if(__fr_break3) break;
}}
if (((((os_type==os_windows && scrNTTEFullSmokeEnabled()) ? scrFREventTestsPortalChance(100) : scrFRSourceRandom(100)) < scrFRSourceScale()) && (portalStormCooldown <= 0))) {
{
{ var __fr_with4 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((os_type==os_windows && scrNTTEFullSmokeEnabled()) ? scrFREventTestsPortalEligibility(ProtoStatue, Player) : ((distance_to_object(ProtoStatue) > 64) && (distance_to_object(Player) < 224)))) {
{
fr_Frontier_Events_mod_gml_StormPortal_create(x, y);
var __fr_other7=scrFROther(other);
__fr_other7.stormPortals += 1;
;
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
}

// Original Frontier_Events.mod.gml:495
function fr_Frontier_Events_mod_gml_StormPortal_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_stormportal";
spr_spwn = sprBigPortalSpawn;
;
spr_idle = sprBigPortal;
;
spr_gone = sprBigPortalDisappear;
;
sprite_index = scrFRAreaSourceSprite(spr_spwn);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
fr_bloom = [2, 0.1];
;
fr_glow = [64, 96];
;
lifetime = 100;
;
ammo = 0;
;
portalDone = false;
;
portalArea = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, {"Desert": 1, "Sewers": 1, "Scrapyards": 1, "Crystal Caves": 1, "Frozen City": 1, "Labs": 1, "Palace": 1, "Oasis": 1, "Pizza": 1, "Mansion": 1, "Cursed Caves": 1, "Jungle": 1, "Cove": frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.save_get, "Frontier", "unlock_bubbles"), "Robocenter": 1, "Coast": scrFRModLoaded("mod", "ntte"), "Lair": scrFRModLoaded("mod", "ntte"), "Warp Zone": scrFRModLoaded("mod", "ntte"), "Undergrowth": scrFRModLoaded("mod", "undergrowth")});
scrFRAlarmWrite(scrFRSelf(self), 1, 0, "=");
;
on_step = fr_Frontier_Events_mod_gml_StormPortal_step;
;
on_alrm1 = ["mod", "Frontier_Events", fr_Frontier_Events_mod_gml_StormPortal_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:547
function fr_Frontier_Events_mod_gml_StormPortal_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Frontier_Events_mod_gml_alarm1_run)) {
exit;
}
if ((frMacro_Frontier_Events_mod_gml_anim_end && (sprite_index == spr_spwn))) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 2;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndPortalOpen, 0.6, 2);
if ((portalArea == "Oasis")) {
{
scrFRSoundPitchVolume(sndOasisPortal, 0.5, 2);
}
}
if ((portalArea == "Mansion")) {
{
scrFRSoundPitchVolume(sndVenuz, 0.9, 2);
}
}
scrFRViewShakeAt(x, y, 100);
ammo = (20 + scrFRSourceIRandom(15));
;
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
}
}
if (((scrFRSourceRandom(10) < 1) && (sprite_index == spr_idle))) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 40), 40)), (y + scrFRSourceRandomRange((- 40), 40)), PortalL)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 1;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
}
}
if (((scrFRSourceRandom(10) < 1) && (sprite_index == spr_idle))) {
{
scrFRSoundPlay(asset_get_index(("sndPortalLightning" + string(scrFRSourceIRandomRange(1, 8)))));
}
}
if ((portalDone == true)) {
{
if ((frMacro_Frontier_Events_mod_gml_anim_end && (sprite_index == spr_gone))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:590
function fr_Frontier_Events_mod_gml_StormPortal_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, 10, "=");
;
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "=");
;
{ var __fr_switch_value1=portalArea, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Desert")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Sewers")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Scrapyards")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Crystal Caves")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Frozen City")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Labs")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Palace")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Oasis")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Pizza")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Mansion")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Cursed Caves")) __fr_switch_case2=10;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Jungle")) __fr_switch_case2=11;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Cove")) __fr_switch_case2=12;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Robocenter")) __fr_switch_case2=13;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Coast")) __fr_switch_case2=14;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Lair")) __fr_switch_case2=15;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Warp Zone")) __fr_switch_case2=16;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Undergrowth")) __fr_switch_case2=17;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Bandit, "Basegame", ""], 12], [[BigMaggot, "Basegame", ""], 5], [[Scorpion, "Basegame", ""], 3], [[GoldScorpion, "Basegame", ""], 1]]);
break;
;
}
case 1:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Rat, "Basegame", ""], 10], [[FrogEgg, "Basegame", ""], 7], [[Gator, "Basegame", ""], 7], [[Ratking, "Basegame", ""], 5], [[BuffGator, "Basegame", ""], 3], [[SuperFrog, "Basegame", ""], 2], [["Paintor_create", "MOD", "Frontier_Objects"], 1], [["Cat", "OBJ", "telib"], (4 * scrFRModLoaded("mod", "ntte"))]]);
break;
;
}
case 2:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Raven, "Basegame", ""], 12], [[MeleeBandit, "Basegame", ""], 6], [[Salamander, "Basegame", ""], 5], [[Sniper, "Basegame", ""], 5], [[Car, "Basegame", ""], 3]]);
break;
;
}
case 3:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Spider, "Basegame", ""], 12], [[LaserCrystal, "Basegame", ""], 6], [["Mortar", "OBJ", "telib"], (4 * scrFRModLoaded("mod", "ntte"))]]);
break;
;
}
case 4:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[SnowBot, "Basegame", ""], 10], [[Wolf, "Basegame", ""], 10], [[SnowTank, "Basegame", ""], 4], [[GoldSnowTank, "Basegame", ""], 1], [[Bandit, "Basegame", "Snow"], 3]]);
break;
;
}
case 5:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Freak, "Basegame", ""], 10], [[ExploFreak, "Basegame", ""], 7], [[RhinoFreak, "Basegame", ""], 4], [[Necromancer, "Basegame", ""], 2]]);
break;
;
}
case 6:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Guardian, "Basegame", ""], 10], [[ExploGuardian, "Basegame", ""], 7], [[DogGuardian, "Basegame", ""], 5], [["PortalGuardian", "OBJ", "telib"], (2 * scrFRModLoaded("mod", "ntte"))], [["GupGuardian_create", "MOD", "Frontier_Palace"], 3]]);
break;
;
}
case 7:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[BoneFish, "Basegame", ""], 12], [[Crab, "Basegame", ""], 5], [["Diver", "OBJ", "telib"], (3 * scrFRModLoaded("mod", "ntte"))]]);
break;
;
}
case 8:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[PizzaBox, "Basegame", ""], 60], [[Turtle, "Basegame", ""], 4], [[Rat, "Basegame", ""], 1]]);
break;
;
}
case 9:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Molefish, "Basegame", ""], 12], [[Molesarge, "Basegame", ""], 7], [[FireBaller, "Basegame", ""], 6], [[SuperFireBaller, "Basegame", ""], 3], [[Jock, "Basegame", ""], 3]]);
break;
;
}
case 10:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[InvSpider, "Basegame", ""], 12], [[InvLaserCrystal, "Basegame", ""], 6], [["InvMortar", "OBJ", "telib"], 4]]);
break;
;
}
case 11:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[[Bush, "Basegame", ""], 5], [[JungleBandit, "Basegame", ""], 15], [[JungleAssassin, "Basegame", ""], 6], [[JungleFly, "Basegame", ""], 3]]);
break;
;
}
case 12:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["Parrot_create", "MOD", "Frontier_Caves"], 20], [["Whale_create", "MOD", "Frontier_Caves"], 9], [["EliteWhale_create", "MOD", "Frontier_Caves"], 3], [["Starfish_create", "MOD", "Frontier_Caves"], 12], [["EliteStarfish_create", "MOD", "Frontier_Caves"], 6]]);
break;
;
}
case 13:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["Swarmbot_create", "MOD", "Frontier_Labs"], 10], [["MissileDrone_create", "MOD", "Frontier_Labs"], 2], [["Engineer_create", "MOD", "Frontier_Labs"], 4]]);
break;
;
}
case 14:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["Gull", "OBJ", "telib"], 17], [["Pelican", "OBJ", "telib"], 4], [["Diver", "OBJ", "telib"], 9], [["TrafficCrab", "OBJ", "telib"], 7]]);
break;
;
}
case 15:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["Cat", "OBJ", "telib"], 12], [["Bat", "OBJ", "telib"], 6], [[Rat, "Basegame", ""], 17]]);
break;
;
}
case 16:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["RedSpider", "OBJ", "telib"], 18], [["CrystalBrain", "OBJ", "telib"], 5]]);
break;
;
}
case 17:
{
var _frl__portalObject = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.pool, [[["Firefly", "OBJ", "undergrowth"], 20], [["PitcherPlant", "OBJ", "undergrowth"], 9], [["Flytrap", "OBJ", "undergrowth"], 5], [["GoldPitcherPlant", "OBJ", "undergrowth"], 1]]);
break;
;
}
}
}
{ var __fr_switch_value3=scrFRIndexGet(_frl__portalObject, 1), __fr_switch_case4=-1;
if(__fr_switch_case4==-1 && __fr_switch_value3==("Basegame")) __fr_switch_case4=0;
if(__fr_switch_case4==-1 && __fr_switch_value3==("MOD")) __fr_switch_case4=1;
if(__fr_switch_case4==-1 && __fr_switch_value3==("OBJ")) __fr_switch_case4=2;
if(__fr_switch_case4==-1) __fr_switch_case4=-1;
switch(__fr_switch_case4) {
case 0:
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, (y + 10), scrFRIndexGet(_frl__portalObject, 0))), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
if ((scrFRIndexGet(_frl__portalObject, 2) == "Snow")) {
{
spr_idle = sprSnowBanditIdle;
;
spr_walk = sprSnowBanditWalk;
;
spr_hurt = sprSnowBanditHurt;
;
spr_dead = sprSnowBanditDead;
;
spr_weap = sprFRBase_SnowBanditGun;
;
}
}
image_xscale = 0.3;
;
image_yscale = image_xscale;
;
{ var __fr_with8 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
portalGuy = true;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandomRange(2, 4)) * timescale;
;
zspeed = 9;
;
zfriction = 0.7;
;
var __fr_other11=scrFROther(other);
creator = __fr_other11;
;
var __fr_other12=scrFROther(other);
depth = __fr_other12.depth;
;
var __fr_other13=scrFROther(other);
mask_index = __fr_other13.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other14=scrFROther(other);
spr_shadow_y = __fr_other14.spr_shadow_y;
;
}
}
}
}
if(__fr_break10) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break7) break;
}}
}
break;
;
case 1:
{
{ var __fr_with15 = scrFRWithValues(scrFRModCall("mod", scrFRIndexGet(_frl__portalObject, 2), scrFRIndexGet(_frl__portalObject, 0), x, (y + 10))), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
image_xscale = 0.3;
;
image_yscale = image_xscale;
;
{ var __fr_with18 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
portalGuy = true;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandomRange(2, 4)) * timescale;
;
zspeed = 9;
;
zfriction = 0.7;
;
var __fr_other21=scrFROther(other);
creator = __fr_other21;
;
var __fr_other22=scrFROther(other);
depth = __fr_other22.depth;
;
var __fr_other23=scrFROther(other);
mask_index = __fr_other23.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other24=scrFROther(other);
spr_shadow_y = __fr_other24.spr_shadow_y;
;
}
}
}
}
if(__fr_break20) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break17) break;
}}
}
break;
;
case 2:
{
{ var __fr_with25 = scrFRWithValues(scrFRModCall("mod", scrFRIndexGet(_frl__portalObject, 2), "obj_create", x, (y + 10), scrFRIndexGet(_frl__portalObject, 0))), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
image_xscale = 0.3;
;
image_yscale = image_xscale;
;
{ var __fr_with28 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
portalGuy = true;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandomRange(2, 4)) * timescale;
;
zspeed = 9;
;
zfriction = 0.7;
;
var __fr_other31=scrFROther(other);
creator = __fr_other31;
;
var __fr_other32=scrFROther(other);
depth = __fr_other32.depth;
;
var __fr_other33=scrFROther(other);
mask_index = __fr_other33.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other34=scrFROther(other);
spr_shadow_y = __fr_other34.spr_shadow_y;
;
}
}
}
}
if(__fr_break30) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break27) break;
}}
}
break;
;
}
}
if (((-- ammo) <= 0)) {
{
portalDone = true;
;
sprite_index = scrFRAreaSourceSprite(spr_gone);
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:846
function fr_Frontier_Events_mod_gml_HoarderSpawn_area() {
return [1, 2, 3, 4, 5, 6, 7, 104, 105, "cove", "graveyard", "robocenter", "coast"];
}

// Original Frontier_Events.mod.gml:847
function fr_Frontier_Events_mod_gml_HoarderSpawn_chance() {
return (((GameCont.area == scrFRAreaTryResolve(7)) && (GameCont.subarea == 3)) ? 0 : ((GameCont.fr_hoarderLoop == GameCont.loops) ? 0 : 0.03));
;
}

// Original Frontier_Events.mod.gml:848
function fr_Frontier_Events_mod_gml_HoarderSpawn_hard() {
return 5;
;
}

// Original Frontier_Events.mod.gml:849
function fr_Frontier_Events_mod_gml_HoarderSpawn_create() {
fr_Frontier_Events_mod_gml_HoarderSpawner_create(10016, 10016);
;
}

// Original Frontier_Events.mod.gml:852
function fr_Frontier_Events_mod_gml_HoarderSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_hoarderSpawner";
;
tries = 0;
;
maxTries = 30;
;
hoarderSpawned = false;
;
on_step = fr_Frontier_Events_mod_gml_HoarderSpawner_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:865
function fr_Frontier_Events_mod_gml_HoarderSpawner_step() {
if (((tries >= maxTries) || (hoarderSpawned == true))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, scrFRMatching(frMacro_Frontier_Events_mod_gml_FloorNormal, "fr_hoarderSpawn", undefined))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_hoarderSpawn = true;
;
if ((distance_to_point(10016, 10016) > 256)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "Hoarder_create", (x + 16), (y + 16))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRPlaceMeeting(x, y, Wall)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
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
var __fr_other10=scrFROther(other);
__fr_other10.hoarderSpawned = true;
;
GameCont.fr_hoarderLoop = GameCont.loops;
;
}
}
var __fr_other11=scrFROther(other);
__fr_other11.tries += 1;
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:892
function fr_Frontier_Events_mod_gml_FleshPlague_area() {
return [1, 2, 3, 4, 7];
;
}

// Original Frontier_Events.mod.gml:893
function fr_Frontier_Events_mod_gml_FleshPlague_chance() {
return 0;
}

// Original Frontier_Events.mod.gml:894
function fr_Frontier_Events_mod_gml_FleshPlague_hard() {
return 8;
;
}

// Original Frontier_Events.mod.gml:895
function fr_Frontier_Events_mod_gml_FleshPlague_create() {
scrFRTrace("MEAT");
repeat (2) { var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, scrFRMatching(Floor, "object_index", Floor))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((point_distance(x, y, 10000, 10000) > 128)) {
{
fr_Frontier_Events_mod_gml_PlagueSpreader_create((x + 16), (y + 16));
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:904
function fr_Frontier_Events_mod_gml_PlagueSpreader_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_FleshPlagueSpreader";
on_step = fr_Frontier_Events_mod_gml_PlagueSpreader_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:915
function fr_Frontier_Events_mod_gml_PlagueSpreader_step() {
{ var __fr_with1 = scrFRWithValues(SnowFloor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object((scrFROther(other))) < 64)) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((distance_to_object((scrFROther(other))) < 64)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorMeat);
;
image_speed = (0.4) * timescale;
;
material = 4;
;
traction = 2;
;
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, SnowFloor)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorMeat);
;
var __fr_other10=scrFROther(other);
image_index = __fr_other10.image_index;
;
image_speed = (0.4) * timescale;
;
image_angle += scrFRSourceRandomRange((- 1), 1);
;
}
}
if(__fr_break9) break;
}}
if (((scrFRSourceRandom(40) < 1) and (! scrFRPlaceMeeting((x + 16), (y + 16), prop)))) {
{
fr_Frontier_Events_mod_gml_BloodCocoon_create((x + 16), (y + 16));
}
}
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with11 = scrFRWithValues(Detail), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
if ((distance_to_object((scrFROther(other))) < 64)) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break13) break;
}}
{ var __fr_with14 = scrFRWithValues(Cactus), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
if ((distance_to_object((scrFROther(other))) < 64)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactus;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactusHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCactusDead;
;
}
}
}
}
if(__fr_break16) break;
}}
{ var __fr_with17 = scrFRWithValues(Bones), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
if ((distance_to_object((scrFROther(other))) < 72)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeatBones);
;
image_index = scrFRSourceIRandom(image_number);
;
}
}
}
}
if(__fr_break19) break;
}}
{ var __fr_with20 = scrFRWithValues(Wall), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
if ((distance_to_object((scrFROther(other))) < 72)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatBot);
;
topspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatTop;
;
outspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWallMeatOut;
;
if ((scrFRSourceRandom(3) < 1)) {
{
var _frl_boneflip = scrFRSourceChoose(0, 16);
{ var __fr_with23 = scrFRWithValues(scrFRInstanceCreate((x + _frl_boneflip), y, Bones)), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeatBones);
;
image_index = scrFRSourceIRandom(image_number);
;
if ((_frl_boneflip == 0)) {
{
image_xscale = (- 1);
;
}
}
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
if(__fr_break22) break;
}}
scrFRInstanceDestroy();
;
}

// Original Frontier_Events.mod.gml:995
function fr_Frontier_Events_mod_gml_DebugEvent1_area() {
return [1, 2, 3, 4, 5, 6, 7, "graveyard", "robocenter", "cove"];
}

// Original Frontier_Events.mod.gml:996
function fr_Frontier_Events_mod_gml_DebugEvent1_chance() {
return 0.0005;
;
}

// Original Frontier_Events.mod.gml:997
function fr_Frontier_Events_mod_gml_DebugEvent1_create() {
debugActivated = false;
;
debugTimer = 120;
;
}

// Original Frontier_Events.mod.gml:1012
function fr_Frontier_Events_mod_gml_DebugEvent1_step() {
if ((debugTimer > 0)) {
{
debugTimer -= scrFRSourceScale();
;
}
}
if (((debugActivated == false) && (debugTimer <= 0))) {
{
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "index", 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRModCall("mod", "Frontier_Bosses", "DebuggingObject_create", (x + 400), (y + scrFRSourceRandomRange((- 40), 40)));
;
}
}
if(__fr_break3) break;
}}
debugActivated = true;
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:1028
function fr_Frontier_Events_mod_gml_MeteorShower_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("A GIFT FROM THE STARS", "MOONLIGHT")));
;
}

// Original Frontier_Events.mod.gml:1029
function fr_Frontier_Events_mod_gml_MeteorShower_area() {
return 1;
;
}

// Original Frontier_Events.mod.gml:1030
function fr_Frontier_Events_mod_gml_MeteorShower_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops ? global.fr_module_vars[$ "mod:Frontier_Events"].nightLoop : ((((! (GameCont.subarea == 1)) && (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits == 0)) || scrFRModLoaded("area", "scorpionboss")) ? 0 : ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.25)) + (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits > 0))));
;
}

// Original Frontier_Events.mod.gml:1033
function fr_Frontier_Events_mod_gml_MeteorShower_hard() {
return 0;
;
}

// Original Frontier_Events.mod.gml:1034
function fr_Frontier_Events_mod_gml_MeteorShower_setup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_MeteorShower_setup_resume, id, scrFROther(other), _args, 15, []);
}
function fr_Frontier_Events_mod_gml_MeteorShower_setup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_MeteorShower_setup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:1074
{
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = true;
;
scrFRBindEndStep(fr_Frontier_Events_mod_gml_MeteorShower_applysprites, 0);
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:1071
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:1071
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:1067
{
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=3;
break;
case 5: // Frontier_Events.mod.gml:1067
_fr.wait_ticks=max(0,1); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:1066
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 7: // Frontier_Events.mod.gml:1062
{
_fr.vars._EventMusic = global.fr_module_vars[$ "mod:Frontier_Events"].musDesertNight;
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=6;
break;
case 8: // Frontier_Events.mod.gml:1056
{
;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:1056
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Frontier_Events.mod.gml:1054
{
;
scrFRModSet("mod", "radioactive", "track_found", false);
;
}
_fr.pc=9;
break;
case 11: // Frontier_Events.mod.gml:1054
_fr.wait_ticks=max(0,1); _fr.pc=10; return;
break;
case 12: // Frontier_Events.mod.gml:1053
_fr.pc = (scrFRTaskFork(_fr, 11)) ? 11 : 7;
break;
case 13: // Frontier_Events.mod.gml:1052
_fr.pc = (scrFRModExists("mod", "radioactive", "menuhandler")) ? 12 : 7;
break;
case 14: // Frontier_Events.mod.gml:1051
_fr.pc = (scrFRModLoaded("mod", "radioactive")) ? 13 : 7;
break;
case 15: // Frontier_Events.mod.gml:1037
{
if ((GameCont.subarea == 1)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits += 1;
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = true;
;
}
_fr.pc=14;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:1080
function fr_Frontier_Events_mod_gml_MeteorShower_create() {
if ((GameCont.subarea == 1)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops == false)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(1, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroNight);
;
}
}
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "mod:Frontier_Events"].pickupMeteorFalls = 0;
;
global.fr_module_vars[$ "mod:Frontier_Events"].maxPickupMeteors = (6 + (3 * GameCont.loops));
;
compatCheck = false;
;
compatTimer = 10;
;
scrFRSpriteReplace(sprWind, sprFR_sprWindNightEvent_b3ccd821ce0a);
;
{ var __fr_with4 = scrFRWithValues(TopCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
darkness = 1;
;
}
}
if(__fr_break6) break;
}}
background_set_colour(make_color_rgb(106, 122, 175));
;
{ var __fr_with7 = scrFRWithValues([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, Bones]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with10 = scrFRWithValues(scrFRSelf(self)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_meteorshower_check = true;
;
fr_Frontier_Events_mod_gml_MeteorShower_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break12) break;
}}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", sprCactus, sprCactus2, sprCactus3, sprCactusB, sprCactusB2, sprCactusB3)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRInstanceCreate(x, y, NightCactus);
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(BonePile), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRInstanceCreate(x, y, NightBonePile);
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(TopDecalDesert), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRInstanceCreate(x, y, TopDecalNightDesert);
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(BigSkull, "spr_idle", sprBigSkullOpen)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullOpenNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullOpenHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullDeadNight;
;
}
}
if(__fr_break24) break;
}}
}

// Original Frontier_Events.mod.gml:1140
function fr_Frontier_Events_mod_gml_MeteorShower_compatsprite() {
var _frl_scorpcity = false;

{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_pelagicbottom")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_blend = scrFRBackgroundColour();
;
}
}
if(__fr_break3) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with4 = scrFRWithValues(scrFRMatching(TopPot, "name", "NTTEWallEnemy")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWallBandit);
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.ScorpionRock)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRock;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockDead;
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.BigCactusIdle)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
spr_idle = frMacro_Frontier_Events_mod_gml__tespr.BigNightCactusIdle;
;
spr_hurt = frMacro_Frontier_Events_mod_gml__tespr.BigNightCactusHurt;
;
spr_dead = frMacro_Frontier_Events_mod_gml__tespr.BigNightCactusDead;
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(Wall, "topspr", frMacro_Frontier_Events_mod_gml__tespr.Wall1TopRubble)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1BotRubble);
;
topspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1TopRubble;
;
outspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatWall1OutRubble;
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorScorpion)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorScorpion);
;
var _frl_scorpcity = true;
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(SnowFloor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.SnowFloorScorpion)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatSnowFloorScorpion);
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(BigSkull, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.CowSkullIdle)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCowSkullDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching(Bones, "name", "NTTEBigDecal")), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalDesert);
;
if (_frl_scorpcity) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalDesertScorpion);
;
}
}
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(FRCustomHitme, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.BigFishBecomeIdle)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishBecomeIdle;
;
}
}
if(__fr_break30) break;
}}
fr_Frontier_Events_mod_gml_NightBigFishController_create(10016, 10016);
;
{ var __fr_with31 = scrFRWithValues(scrFRMatching(FRCustomProp, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.BanditTentIdle)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentDead;
;
}
}
if(__fr_break33) break;
}}
{ var __fr_with34 = scrFRWithValues(scrFRMatching(FRCustomProp, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.BanditTentWallIdle)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditTentWallDead;
;
}
}
if(__fr_break36) break;
}}
{ var __fr_with37 = scrFRWithValues(scrFRMatching(FR_OBJECT_EFFECT, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.BanditCampfire)), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBanditCampfire);
;
}
}
if(__fr_break39) break;
}}
{ var __fr_with40 = scrFRWithValues(scrFRMatching(TopSmall, "sprite_index", sprWall1Top)), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
sprite_index = scrFRAreaSourceSprite(sprWall0Top);
;
}
}
if(__fr_break42) break;
}}
{ var __fr_with43 = scrFRWithValues(scrFRMatching(TopDecalDesert, "sprite_index", sprDesertTopDecal)), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
sprite_index = scrFRAreaSourceSprite(sprNightDesertTopDecal);
;
}
}
if(__fr_break45) break;
}}
}
}
if (scrFRModLoaded("mod", "Details+")) {
{
{ var __fr_with46 = scrFRWithValues(scrFRMatchingNE(Wall, "detailsPlus_mudWall", undefined)), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
if ((sprite_index == sprWall0Bot)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall1BotBNight);
;
}
}
}
}
if(__fr_break48) break;
}}
{ var __fr_with49 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "detailsPlus_ProtoStatueDecal")), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprDesertProtoStatueDecalNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprDesertProtoStatueDecalDeadNight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break51) break;
}}
{ var __fr_with52 = scrFRWithValues(scrFRMatching(Floor, "detailsPlus_isMud", true)), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusFloorDesertBOutNight);
;
}
}
if(__fr_break54) break;
}}
{ var __fr_with55 = scrFRWithValues(scrFRMatching(SnowFloor, "detailsPlus_isMud", true)), __fr_break57=false;
for (var __fr_index56=0; __fr_index56<array_length(__fr_with55); ++__fr_index56) {
if(scrFRScopeExists(__fr_with55[__fr_index56])) with (__fr_with55[__fr_index56]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusSnowFloorDesertBNight);
;
}
}
if(__fr_break57) break;
}}
{ var __fr_with58 = scrFRWithValues(scrFRMatching(Detail, "detailsPlus_altDetail", true)), __fr_break60=false;
for (var __fr_index59=0; __fr_index59<array_length(__fr_with58); ++__fr_index59) {
if(scrFRScopeExists(__fr_with58[__fr_index59])) with (__fr_with58[__fr_index59]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertBNight);
;
}
}
if(__fr_break60) break;
}}
{ var __fr_with61 = scrFRWithValues(scrFRMatching(FR_OBJECT_EFFECT, "detailsPlus_bdetail", true)), __fr_break63=false;
for (var __fr_index62=0; __fr_index62<array_length(__fr_with61); ++__fr_index62) {
if(scrFRScopeExists(__fr_with61[__fr_index62])) with (__fr_with61[__fr_index62]) {
{
sprite_index = scrFRAreaSourceSprite(((detailsPlus_bdetailBig == true) ? global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertMudBigNight : global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailsPlusDetailDesertMudBNight));
;
}
}
if(__fr_break63) break;
}}
}
}
if (scrFRModLoaded("mod", "vagabonds_master")) {
{
{ var __fr_with64 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", frMacro_Frontier_Events_mod_gml__vagabondsspr.Cactaur_FakeIdle)), __fr_break66=false;
for (var __fr_index65=0; __fr_index65<array_length(__fr_with64); ++__fr_index65) {
if(scrFRScopeExists(__fr_with64[__fr_index65])) with (__fr_with64[__fr_index65]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFake;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFakeHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatCactuarFakeDead;
;
}
}
if(__fr_break66) break;
}}
{ var __fr_with67 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", frMacro_Frontier_Events_mod_gml__vagabondsspr.TinyCactaur_Fake1Idle)), __fr_break69=false;
for (var __fr_index68=0; __fr_index68<array_length(__fr_with67); ++__fr_index68) {
if(scrFRScopeExists(__fr_with67[__fr_index68])) with (__fr_with67[__fr_index68]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFakeHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFakeDead;
;
}
}
if(__fr_break69) break;
}}
{ var __fr_with70 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", frMacro_Frontier_Events_mod_gml__vagabondsspr.TinyCactaur_Fake2Idle)), __fr_break72=false;
for (var __fr_index71=0; __fr_index71<array_length(__fr_with70); ++__fr_index71) {
if(scrFRScopeExists(__fr_with70[__fr_index71])) with (__fr_with70[__fr_index71]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake2;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake2Hurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFakeDead;
;
}
}
if(__fr_break72) break;
}}
{ var __fr_with73 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", frMacro_Frontier_Events_mod_gml__vagabondsspr.TinyCactaur_Fake3Idle)), __fr_break75=false;
for (var __fr_index74=0; __fr_index74<array_length(__fr_with73); ++__fr_index74) {
if(scrFRScopeExists(__fr_with73[__fr_index74])) with (__fr_with73[__fr_index74]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3Hurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTinyCactuarFake3Dead;
;
}
}
if(__fr_break75) break;
}}
{ var __fr_with76 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", sprCactus, sprCactus2, sprCactus3, sprCactusB, sprCactusB2, sprCactusB3)), __fr_break78=false;
for (var __fr_index77=0; __fr_index77<array_length(__fr_with76); ++__fr_index77) {
if(scrFRScopeExists(__fr_with76[__fr_index77])) with (__fr_with76[__fr_index77]) {
{
scrFRInstanceCreate(x, y, NightCactus);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break78) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:1294
function fr_Frontier_Events_mod_gml_MeteorShower_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_MeteorShower_cleanup_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Frontier_Events_mod_gml_MeteorShower_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_MeteorShower_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:1316
{
scrFRSpriteRestore(sprWind);
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = false;
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:1314
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:1314
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:1304
{
if ((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "MeteorShower"))) {
{
if ((GameCont.area == scrFRAreaTryResolve(1))) {
{
if ((GameCont.proto == 1)) {
{
scrFRSoundMusic(mus1b);
;
}
} else {
{
scrFRSoundMusic(mus1);
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
}
}
}
}
}
_fr.pc=3;
break;
case 6: // Frontier_Events.mod.gml:1303
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Events.mod.gml:1303
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Frontier_Events.mod.gml:1303
_fr.pc=(scrFRInstanceExists(SkillIcon))?7:4;
break;
case 8: // Frontier_Events.mod.gml:1302
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Events.mod.gml:1301
{
;
}
_fr.pc=8;
break;
case 10: // Frontier_Events.mod.gml:1301
_fr.wait_ticks=max(0,2); _fr.pc=9; return;
break;
case 11: // Frontier_Events.mod.gml:1297
{
if (((GameCont.area != scrFRAreaTryResolve(1)) && (GameCont.area != scrFRAreaTryResolve(100)))) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
}
}
}
_fr.pc=10;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:1319
function fr_Frontier_Events_mod_gml_MeteorShower_step() {
if ((compatCheck == false)) {
{
compatTimer -= scrFRSourceScale();
;
if ((compatTimer <= 0)) {
{
compatCheck = true;
;
fr_Frontier_Events_mod_gml_MeteorShower_compatsprite();
;
}
}
}
}
if ((scrFRSourceRandom(10) < scrFRSourceScale())) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, FireFly);
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(100) < scrFRSourceScale())) {
{
{ var __fr_with4 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, frMacro_Frontier_Events_mod_gml_FloorNormal)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_Frontier_Events_mod_gml_FallenStar_create((x + 16), (y + 16));
}
}
if(__fr_break6) break;
}}
}
}
if ((global.fr_module_vars[$ "mod:Frontier_Events"].pickupMeteorFalls > global.fr_module_vars[$ "mod:Frontier_Events"].maxPickupMeteors)) {
{
if ((scrFRSourceRandom(100) < scrFRSourceScale())) {
{
{ var __fr_with7 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, frMacro_Frontier_Events_mod_gml_FloorNormal)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_Frontier_Events_mod_gml_PickupStar_create((x + 16), (y + 16));
;
global.fr_module_vars[$ "mod:Frontier_Events"].pickupMeteorFalls += 1;
;
}
}
if(__fr_break9) break;
}}
}
}
}
}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(BigSkull, "spr_idle", sprBigSkull)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigSkullDeadNight;
;
}
}
if(__fr_break12) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRock)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
if ((friendly && (spr_idle == global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRock))) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatScorpionRockAlly;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_index = 0;
;
}
}
}
}
if(__fr_break15) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:1374
function fr_Frontier_Events_mod_gml_MeteorShower_applysprites() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot], "fr_meteorshower_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_meteorshower_check = true;
;
fr_Frontier_Events_mod_gml_MeteorShower_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1382
function fr_Frontier_Events_mod_gml_MeteorShower_sprite_set(_frl__obj=undefined) {
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Floor)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(FloorExplo)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Wall)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Top)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(TopSmall)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Debris)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Detail)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Bones)) __fr_switch_case2=7;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_switch_value3=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case4=-1;
if(__fr_switch_case4==-1) __fr_switch_case4=0;
switch(__fr_switch_case4) {
case 0:
if (((! styleb) and (sprite_index == sprFloor1))) {
sprite_index = scrFRAreaSourceSprite(sprFloor0);
}
if ((styleb and (sprite_index == sprFloor1B))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor1BNight);
}
break;
;
}
}
break;
;
case 1:
{ var __fr_switch_value5=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case6=-1;
if(__fr_switch_case6==-1) __fr_switch_case6=0;
switch(__fr_switch_case6) {
case 0:
sprite_index = scrFRAreaSourceSprite(sprFloor0Explo);
;
break;
;
}
}
break;
;
case 2:
{ var __fr_switch_value7=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case8=-1;
if(__fr_switch_case8==-1) __fr_switch_case8=0;
switch(__fr_switch_case8) {
case 0:
if ((sprite_index == sprWall1Bot)) {
{
sprite_index = scrFRAreaSourceSprite(sprWall0Bot);
;
outspr = sprWall0Out;
;
topspr = sprWall0Top;
;
}
}
break;
;
}
}
break;
;
case 3:
{ var __fr_switch_value9=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case10=-1;
if(__fr_switch_case10==-1) __fr_switch_case10=0;
switch(__fr_switch_case10) {
case 0:
if ((sprite_index == sprWall1Top)) {
sprite_index = scrFRAreaSourceSprite(sprWall0Top);
}
break;
;
}
}
break;
;
case 4:
{ var __fr_switch_value11=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case12=-1;
if(__fr_switch_case12==-1) __fr_switch_case12=0;
switch(__fr_switch_case12) {
case 0:
sprite_index = scrFRAreaSourceSprite(sprWall0Trans);
;
break;
;
}
}
break;
;
case 5:
if ((sprite_index == sprDebris1)) {
sprite_index = scrFRAreaSourceSprite(sprDebris0);
}
break;
;
case 6:
if ((sprite_index == sprDetail1)) {
{
sprite_index = scrFRAreaSourceSprite(sprDetail0);
;
}
}
break;
;
case 7:
if ((sprite_index == sprBones)) {
{
sprite_index = scrFRAreaSourceSprite(sprNightBones);
;
}
}
break;
;
}
}
}

// Original Frontier_Events.mod.gml:1443
function fr_Frontier_Events_mod_gml_NightBigFishController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_NightBigFishController";
;
on_step = fr_Frontier_Events_mod_gml_NightBigFishController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1452
function fr_Frontier_Events_mod_gml_NightBigFishController_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(enemy, "bossname", "BIG FISH"), "fr_bigFishCheck", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_bigFishCheck = true;
;
spr_spwn = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishSpwn;
;
spr_dive = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishLeap;
;
spr_rise = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigFishRise;
;
sprite_index = scrFRAreaSourceSprite(spr_spwn);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1463
function fr_Frontier_Events_mod_gml_SolarShower_text() {
return scrFRLocalize("HOT HOT HOT HOT HOT!");
}

// Original Frontier_Events.mod.gml:1464
function fr_Frontier_Events_mod_gml_SolarShower_area() {
return 1;
;
}

// Original Frontier_Events.mod.gml:1465
function fr_Frontier_Events_mod_gml_SolarShower_chance() {
return 0;
}

// Original Frontier_Events.mod.gml:1467
function fr_Frontier_Events_mod_gml_SolarShower_create() {
solarshowerCooldown = 60;
;
scrFRBindDraw(fr_Frontier_Events_mod_gml_SolidColorFog_add, (- 12), make_colour_rgb(255, 90, 0), 0.20);
;
}

// Original Frontier_Events.mod.gml:1472
function fr_Frontier_Events_mod_gml_SolarShower_step() {
if ((solarshowerCooldown >= 0)) {
{
solarshowerCooldown -= scrFRSourceScale();
;
}
}
if (((scrFRInstanceExists(enemy) && (solarshowerCooldown <= 0)) || (scrFRInstanceExists(BigMaggotBurrow) && (solarshowerCooldown <= 0)))) {
{
if ((scrFRSourceRandom(8) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((distance_to_object(ProtoStatue) > 64) && (distance_to_object(Player) < 124))) {
{
fr_Frontier_Events_mod_gml_SolarFlareSpawn_create((x + scrFRSourceRandomRange((- 32), 32)), y);
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

// Original Frontier_Events.mod.gml:1498
function fr_Frontier_Events_mod_gml_Casino_area() {
return [2, "sewers"];
;
}

// Original Frontier_Events.mod.gml:1499
function fr_Frontier_Events_mod_gml_Casino_chance() {
return ((scrFRModLoaded("area", "scorpionboss") ? 0.05 : 0.25) + ((scrFRModLoaded("area", "scorpionboss") ? 0.05 : 0.25) * scrFRGetSkill(mut_rabbit_paw)));
;
}

// Original Frontier_Events.mod.gml:1500
function fr_Frontier_Events_mod_gml_Casino_setup() {
global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic = scrFRSoundLoop(global.fr_module_vars[$ "mod:Frontier_Events"].musCasino);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic, 0);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = (- 4);
;
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingVeeOneHundred == true)) {
{
var _frl__sewerTune = MusCont.song;
;
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic))) {
{
if ((_frl__sewerTune != sndBossWin)) {
{
scrFRSoundStop(_frl__sewerTune);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = scrFRSoundLoop(_frl__sewerTune);
;
}
}
}
}
}
} else {
{
fr_Frontier_Events_mod_gml_CasinoMusicHandler_create(0, 0);
;
}
}
}

// Original Frontier_Events.mod.gml:1524
function fr_Frontier_Events_mod_gml_Casino_create() {
GameCont.fr_casinoAlert = false;
;
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.array_shuffle, frMacro_Frontier_Events_mod_gml_FloorNormal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRPlaceMeeting(x, y, Wall))) {
{
var _frl__fx = frMacro_Frontier_Events_mod_gml_bbox_center_x;
var _frl__fy = frMacro_Frontier_Events_mod_gml_bbox_center_y;
var _frl__w = (5 * 32);
var _frl__h = (3 * 32);
var _frl__ang = (90 * scrFRSourceIRandom(3));
var _frl__border = 32;
var _frl__end = false;
;
{
var _frl__dir = _frl__ang;
for (; (_frl__dir < (_frl__ang + 270)); _frl__dir += 90) {
if ((! scrFRPlaceMeeting((x + lengthdir_x(32, _frl__dir)), (y + lengthdir_y(32, _frl__dir)), Floor))) {
{
{
var _frl__dis = (_frl__border + scrFRSourceChoose(32, 64, 96));
for (; (_frl__dis >= _frl__border); _frl__dis -= 32) {
var _frl__hallXOff = lengthdir_x((_frl__dis - _frl__border), (_frl__dir + 180));
var _frl__hallYOff = lengthdir_y((_frl__dis - _frl__border), (_frl__dir + 180));
var _frl__cx = (_frl__fx + lengthdir_x(((16 + _frl__dis) + (_frl__w / 2)), _frl__dir));
var _frl__cy = (_frl__fy + lengthdir_y(((16 + _frl__dis) + (_frl__h / 2)), _frl__dir));
;
if ((! collision_rectangle((((_frl__cx - (_frl__w / 2)) - _frl__border) + min(0, _frl__hallXOff)), (((_frl__cy - (_frl__h / 2)) - _frl__border) + min(0, _frl__hallYOff)), ((((_frl__cx + (_frl__w / 2)) + _frl__border) + max(0, _frl__hallXOff)) - 1), ((((_frl__cy + (_frl__h / 2)) + _frl__border) + max(0, _frl__hallYOff)) - 1), Floor, false, false))) {
{
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.floor_fill, _frl__cx, _frl__cy, (_frl__w / 32), (_frl__h / 32), "");
;
{
var _frl__l = _frl__border;
for (; (_frl__l <= _frl__dis); _frl__l += 32) {
{ var __fr_with4 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.floor_set, ((_frl__fx - 16) + lengthdir_x(_frl__l, _frl__dir)), ((_frl__fy - 16) + lengthdir_y(_frl__l, _frl__dir)), true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{

}
}
if(__fr_break6) break;
}}
}
}
var __fr_other7=scrFROther(other);
__fr_other7.x = _frl__cx;
;
var __fr_other8=scrFROther(other);
__fr_other8.y = _frl__cy;
;
{ var __fr_with9 = scrFRWithValues(fr_Frontier_Events_mod_gml_CasinoCarpet_create((scrFROther(other)).x, (scrFROther(other)).y)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
scrFRModCall("mod", "Frontier_Sewers", "CasinoSlotMachine_create", (x - 48), (y - 38));
;
{ var __fr_with12 = scrFRWithValues(scrFRModCall("mod", "Frontier_Sewers", "Counter_create", (x + 48), (y - 25))), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
scrFRModCall("mod", "Frontier_Sewers", "BartenderGator_create", (x - 7), (y - 14));
;
scrFRModCall("mod", "Frontier_Sewers", "CasinoSoda_create", (x + 9), (y - 14), scrFRSelf(self));
;
scrFRModCall("mod", "Frontier_Sewers", "CasinoSoda_create", (x + 16), (y - 15), scrFRSelf(self));
;
scrFRModCall("mod", "Frontier_Sewers", "CasinoSoda_create", (x + 23), (y - 16), scrFRSelf(self));
;
}
}
if(__fr_break14) break;
}}
{ var __fr_with15 = scrFRWithValues(scrFRModCall("mod", "Frontier_Sewers", "Couch_create", (x + 48), (y + 36))), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
scrFRModCall("mod", "Frontier_Sewers", "CouchgoerGator_create", (x + 8), (y - 14));
;
scrFRModCall("mod", "Frontier_Sewers", "CouchgoerCat_create", (x - 9), (y - 14));
;
}
}
if(__fr_break17) break;
}}
scrFRModCall("mod", "Frontier_Sewers", "CasinoTV_create", (x + 42), (y + 4));
;
}
}
if(__fr_break11) break;
}}
_frl__end = true;
;
break;
;
}
}
}
}
if (_frl__end) {
break;
}
}
}
}
}
if (_frl__end) {
__fr_break3=true; break;
}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1601
function fr_Frontier_Events_mod_gml_Casino_cleanup() {
if (audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic)) {
{
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic);
;
}
}
if (audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic)) {
{
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic);
;
}
}
}

// Original Frontier_Events.mod.gml:1611
function fr_Frontier_Events_mod_gml_CasinoCarpet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoCarpet";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCasinoFloor);
;
depth = 8;
;
on_step = ((global.fr_module_vars[$ "mod:Frontier_Events"].settingVeeOneHundred == true) ? fr_Frontier_Events_mod_gml_CasinoCarpetV100_step : fr_Frontier_Events_mod_gml_nothing);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1624
function fr_Frontier_Events_mod_gml_CasinoMusicHandler_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_casinoMusicHandler";
;
sewerTune = (scrFRModLoaded("mod", "radioactive") ? scrFRModGet("mod", "radioactive", "ra2") : mus2);
;
ballMumTrack = (scrFRModLoaded("mod", "radioactive") ? scrFRModGet("mod", "radioactive", "raballMom") : musBoss5);
;
deadMumTrack = (scrFRModLoaded("mod", "radioactive") ? scrFRModGet("mod", "radioactive", "rabossDead") : musBossDead);
;
tesseract = false;
;
tinnitusStopper = false;
;
moved = false;
;
if (scrFRModLoaded("mod", "ntte")) {
{
tesseract = true;
;
tesseractTrack = frMacro_Frontier_Events_mod_gml__temus.Tesseract;
;
}
}
if (scrFRModLoaded("mod", "radioactive")) {
{
if (scrFRModExists("mod", "radioactive", "menuhandler")) {
{
tinnitusStopper = true;
;
}
}
}
}
mask_index = global.fr_module_vars[$ "mod:Frontier_Events"].sprCasinoFloor;
;
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = scrFRSoundLoop(sewerTune);
;
on_step = fr_Frontier_Events_mod_gml_CasinoMusicHandler_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1657
function fr_Frontier_Events_mod_gml_CasinoMusicHandler_step() {
if ((moved == false)) {
{
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_CasinoCarpet")) > 0)) {
{
var _frl__carpet = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(FRCustomObject, "name", "fr_CasinoCarpet"));
;
x = _frl__carpet.x;
;
y = _frl__carpet.y;
;
moved = true;
;
}
}
}
}
if (tinnitusStopper) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FrogQueen, "intro", 1)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
intro = 2;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((! audio_is_playing(sndBossWin))) {
{
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank))) {
{
if (((audio_is_playing(musBoss5) || audio_is_playing(ballMumTrack)) && (sewerTune != ballMumTrack))) {
{
sewerTune = ballMumTrack;
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic);
}
}
if (tesseract) {
{
if ((audio_is_playing(tesseractTrack) && (sewerTune != tesseractTrack))) {
{
sewerTune = tesseractTrack;
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic);
;
}
}
}
}
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank);
;
}
}
}
} else {
{
if ((sewerTune != deadMumTrack)) {
{
sewerTune = global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank2;
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic);
;
}
}
}
}
if (((audio_is_playing(musBossDead) || audio_is_playing(deadMumTrack)) && (sewerTune != deadMumTrack))) {
{
sewerTune = deadMumTrack;
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic);
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = scrFRSoundLoop(sewerTune);
;
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Events"].sndBlank);
;
}
}
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic))) {
{
if ((sewerTune != undefined)) {
{
scrFRSoundStop(sewerTune);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = scrFRSoundLoop(sewerTune);
;
}
}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(Player, "index", 0)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((! collision_line(x, y, (scrFROther(other)).x, (scrFROther(other)).y, Wall, false, false))) {
{
var _frl__dis = distance_to_object((scrFROther(other)));
;
var _frl__arcade_max = 70;
;
var _frl__sewer_max = 20;
;
var _frl__arcade_vol = ((_frl__arcade_max - _frl__dis) / _frl__arcade_max);
;
var _frl__sewer_vol = ((_frl__sewer_max - _frl__dis) / _frl__sewer_max);
;
if ((_frl__dis > 40)) {
{
var __fr_other7=scrFROther(other);
global.fr_module_vars[$ "mod:Frontier_Events"].music_setting = max(audio_sound_get_gain(__fr_other7.sewerTune), 0);
;
}
}
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic, clamp((_frl__sewer_vol * (- 1)), 0, 1));
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic, clamp((_frl__arcade_vol * global.fr_module_vars[$ "mod:Frontier_Events"].music_setting), 0, 1));
;
}
} else {
{
var __fr_other8=scrFROther(other);
global.fr_module_vars[$ "mod:Frontier_Events"].music_setting = max(audio_sound_get_gain(__fr_other8.sewerTune), 0);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic, 1);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic, 0);
;
}
}
}
}
if(__fr_break6) break;
}}
}

// Original Frontier_Events.mod.gml:1739
function fr_Frontier_Events_mod_gml_CasinoCarpetV100_step() {
var _frl__sewerTune = MusCont.song;
;
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic))) {
{
if ((_frl__sewerTune != sndBossWin)) {
{
scrFRSoundStop(_frl__sewerTune);
;
global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic = scrFRSoundLoop(_frl__sewerTune);
;
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "index", 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! collision_line(x, y, (scrFROther(other)).x, (scrFROther(other)).y, Wall, false, false))) {
{
var _frl__dis = distance_to_object((scrFROther(other)));
;
var _frl__arcade_max = 70;
;
var _frl__sewer_max = 20;
;
var _frl__arcade_vol = ((_frl__arcade_max - _frl__dis) / _frl__arcade_max);
;
var _frl__sewer_vol = ((_frl__sewer_max - _frl__dis) / _frl__sewer_max);
;
if ((_frl__dis > 40)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].music_setting = max(audio_sound_get_gain(_frl__sewerTune), 0);
;
}
}
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic, clamp((_frl__sewer_vol * (- 1)), 0, 1));
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic, clamp((_frl__arcade_vol * global.fr_module_vars[$ "mod:Frontier_Events"].music_setting), 0, 1));
;
}
} else {
{
global.fr_module_vars[$ "mod:Frontier_Events"].music_setting = max(audio_sound_get_gain(_frl__sewerTune), 0);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].sewerMusic, 1);
;
scrFRSoundVolume(global.fr_module_vars[$ "mod:Frontier_Events"].casinoMusic, 0);
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1775
function fr_Frontier_Events_mod_gml_PaintorCamp_area() {
return [2, "sewers", 102, "lair", 3, "scrapyard", 4, 6, "labs", 7, "palace", "cove", "robocenter"];
;
}

// Original Frontier_Events.mod.gml:1776
function fr_Frontier_Events_mod_gml_PaintorCamp_chance() {
return (((GameCont.area == scrFRAreaTryResolve(7)) && (GameCont.subarea == 3)) ? 0 : (global.fr_module_vars[$ "mod:Frontier_Events"].settingPaintorCampEventSpawnChance + ((scrFRCrownCurrent() == "crime") * 0.03)));
;
}

// Original Frontier_Events.mod.gml:1777
function fr_Frontier_Events_mod_gml_PaintorCamp_create() {
fr_Frontier_Events_mod_gml_PaintorCampSpawner_create(10016, 10016);
;
}

// Original Frontier_Events.mod.gml:1780
function fr_Frontier_Events_mod_gml_PaintorCampSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_paintorCampSpawner";
;
tries = 0;
;
maxTries = 30;
;
gatorGoal = ((3 + scrFRSourceIRandom(2)) + GameCont.loops);
;
on_step = fr_Frontier_Events_mod_gml_PaintorCampSpawner_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1793
function fr_Frontier_Events_mod_gml_PaintorCampSpawner_step() {
if (((tries >= maxTries) || (gatorGoal <= 0))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, scrFRMatching(frMacro_Frontier_Events_mod_gml_FloorNormal, "fr_paintorSpawned", undefined))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_point(10016, 10016) > 192)) {
{
fr_paintorSpawned = true;
;
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Sewers", "Paintor_create", (x + 16), (y + 16))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRPlaceMeeting(x, y, Wall)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
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
scrFRModCall("mod", "Frontier_Sewers", "Graffiti_create", (x + 16), (y + 16));
;
var __fr_other10=scrFROther(other);
__fr_other10.gatorGoal -= 1;
;
}
}
var __fr_other11=scrFROther(other);
__fr_other11.tries += 1;
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1817
function fr_Frontier_Events_mod_gml_SlimyPipes_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : "CLOGGED PIPES"));
;
}

// Original Frontier_Events.mod.gml:1818
function fr_Frontier_Events_mod_gml_SlimyPipes_chance() {
return (0.20 * (! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Casino")));
;
}

// Original Frontier_Events.mod.gml:1819
function fr_Frontier_Events_mod_gml_SlimyPipes_area() {
return [2, "sewers"];
;
}

// Original Frontier_Events.mod.gml:1820
function fr_Frontier_Events_mod_gml_SlimyPipes_create() {
var _frl__maxPipes = 5;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Wall, "fr_SludgeTrap", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_SludgeTrap = true;
;
if ((scrFRPlaceMeeting(x, y, Floor) && (_frl__maxPipes > 0))) {
{
outindex = 0;
;
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "SludgeTrap_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
_frl__maxPipes -= 1;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:1861
function fr_Frontier_Events_mod_gml_Thunderstorm_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("STORM A-BREWIN'", "THUNDERSTRUCK")));
;
}

// Original Frontier_Events.mod.gml:1862
function fr_Frontier_Events_mod_gml_Thunderstorm_area() {
return [3, "junkyard", "bigdog", "ravenboss"];
;
}

// Original Frontier_Events.mod.gml:1863
function fr_Frontier_Events_mod_gml_Thunderstorm_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingThunderstormEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.65));
;
}

// Original Frontier_Events.mod.gml:1865
function fr_Frontier_Events_mod_gml_Thunderstorm_setup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_Thunderstorm_setup_resume, id, scrFROther(other), _args, 14, []);
}
function fr_Frontier_Events_mod_gml_Thunderstorm_setup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_Thunderstorm_setup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:1891
{
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = true;
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:1888
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:1888
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:1884
{
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=3;
break;
case 5: // Frontier_Events.mod.gml:1884
_fr.wait_ticks=max(0,1); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:1883
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 7: // Frontier_Events.mod.gml:1879
{
_fr.vars._EventMusic = global.fr_module_vars[$ "mod:Frontier_Events"].musThunderstorm;
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=6;
break;
case 8: // Frontier_Events.mod.gml:1873
{
;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:1873
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Frontier_Events.mod.gml:1871
{
;
scrFRModSet("mod", "radioactive", "track_found", false);
;
}
_fr.pc=9;
break;
case 11: // Frontier_Events.mod.gml:1871
_fr.wait_ticks=max(0,1); _fr.pc=10; return;
break;
case 12: // Frontier_Events.mod.gml:1870
_fr.pc = (scrFRTaskFork(_fr, 11)) ? 11 : 7;
break;
case 13: // Frontier_Events.mod.gml:1869
_fr.pc = (scrFRModExists("mod", "radioactive", "menuhandler")) ? 12 : 7;
break;
case 14: // Frontier_Events.mod.gml:1868
_fr.pc = (scrFRModLoaded("mod", "radioactive")) ? 13 : 7;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:1893
function fr_Frontier_Events_mod_gml_Thunderstorm_create() {
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(4, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroWeather);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
thunderstormCooldown = 60;
;
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRSourceRandom(25) < 1)) {
{
scrFRInstanceCreate(x, y, LightBeam);
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(TopCont), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
TopCont.fog = global.fr_module_vars[$ "mod:Frontier_Events"].sprFogThunderstorm;
;
darkness = 1;
;
}
}
if(__fr_break9) break;
}}
}

// Original Frontier_Events.mod.gml:1922
function fr_Frontier_Events_mod_gml_Thunderstorm_step() {
if ((thunderstormCooldown >= 0)) {
{
thunderstormCooldown -= scrFRSourceScale();
}
}
if (((scrFRInstanceExists(enemy) && (thunderstormCooldown <= 0)) || (scrFRInstanceExists(RavenFly) && (thunderstormCooldown <= 0)))) {
{
if (frMacro_Frontier_Events_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
repeat (scrFRSourceRandom((8 / scrFRInstanceNumber(Player)))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 450), 450)), (y + scrFRSourceRandomRange((- 250), 250)), RainDrop)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprRainDropThunderstorm);
;
}
}
if(__fr_break6) break;
}}
repeat (4) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 450), 450)), (y + scrFRSourceRandomRange((- 250), 250)), RainSplash);
}
}
}
}
if(__fr_break3) break;
}}
if ((scrFRSourceRandom(50) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (((distance_to_object(ProtoStatue) > 64) && (distance_to_object(Player) < 160))) {
{
fr_Frontier_Events_mod_gml_LightningStrikeSpawn_create(x, y);
}
}
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

// Original Frontier_Events.mod.gml:1956
function fr_Frontier_Events_mod_gml_Thunderstorm_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_Thunderstorm_cleanup_resume, id, scrFROther(other), _args, 9, []);
}
function fr_Frontier_Events_mod_gml_Thunderstorm_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_Thunderstorm_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:1971
{
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:1971
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Frontier_Events.mod.gml:1961
{
if (((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Thunderstorm")) && (! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "ScrapyardsNight")))) {
{
if ((GameCont.area == scrFRAreaTryResolve(3))) {
{
if ((GameCont.proto == 1)) {
{
scrFRSoundMusic(mus3b);
;
}
} else {
{
scrFRSoundMusic(mus3);
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
}
}
}
}
}
_fr.pc=2;
break;
case 5: // Frontier_Events.mod.gml:1960
{
;
}
_fr.pc=4;
break;
case 6: // Frontier_Events.mod.gml:1960
_fr.wait_ticks=max(0,1); _fr.pc=5; return;
break;
case 4: // Frontier_Events.mod.gml:1960
_fr.pc=(scrFRInstanceExists(SkillIcon))?6:3;
break;
case 7: // Frontier_Events.mod.gml:1959
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 0;
break;
case 8: // Frontier_Events.mod.gml:1958
{
;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:1958
_fr.wait_ticks=max(0,2); _fr.pc=8; return;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:1975
function fr_Frontier_Events_mod_gml_ScrapyardsNight_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : "FIRELIGHT"));
}

// Original Frontier_Events.mod.gml:1976
function fr_Frontier_Events_mod_gml_ScrapyardsNight_area() {
return [3, "junkyard", "bigdog", "ravenboss"];
;
}

// Original Frontier_Events.mod.gml:1977
function fr_Frontier_Events_mod_gml_ScrapyardsNight_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops ? global.fr_module_vars[$ "mod:Frontier_Events"].nightLoop : (((! (GameCont.subarea == 1)) && (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits == 0)) ? 0 : ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.25)) + (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits > 0))));
;
}

// Original Frontier_Events.mod.gml:1981
function fr_Frontier_Events_mod_gml_ScrapyardsNight_setup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_ScrapyardsNight_setup_resume, id, scrFROther(other), _args, 17, []);
}
function fr_Frontier_Events_mod_gml_ScrapyardsNight_setup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_ScrapyardsNight_setup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:2018
{
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = true;
;
scrFRBindEndStep(fr_Frontier_Events_mod_gml_ScrapyardsNight_applysprites, 0);
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:2015
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:2015
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:2011
{
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=3;
break;
case 5: // Frontier_Events.mod.gml:2011
_fr.wait_ticks=max(0,1); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:2010
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 7: // Frontier_Events.mod.gml:2007
{
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=6;
break;
case 8: // Frontier_Events.mod.gml:2006
_fr.pc = ((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Thunderstorm"))) ? 7 : 1;
break;
case 9: // Frontier_Events.mod.gml:2005
{
_fr.vars._EventMusic = global.fr_module_vars[$ "mod:Frontier_Events"].musScrapyardsNight;
;
}
_fr.pc=8;
break;
case 10: // Frontier_Events.mod.gml:1996
{
;
}
_fr.pc=9;
break;
case 11: // Frontier_Events.mod.gml:1996
_fr.result=undefined; _fr.done=true; return;
break;
case 12: // Frontier_Events.mod.gml:1994
{
;
scrFRModSet("mod", "radioactive", "track_found", false);
;
}
_fr.pc=11;
break;
case 13: // Frontier_Events.mod.gml:1994
_fr.wait_ticks=max(0,1); _fr.pc=12; return;
break;
case 14: // Frontier_Events.mod.gml:1993
_fr.pc = (scrFRTaskFork(_fr, 13)) ? 13 : 9;
break;
case 15: // Frontier_Events.mod.gml:1992
_fr.pc = (scrFRModExists("mod", "radioactive", "menuhandler")) ? 14 : 9;
break;
case 16: // Frontier_Events.mod.gml:1991
_fr.pc = (scrFRModLoaded("mod", "radioactive")) ? 15 : 9;
break;
case 17: // Frontier_Events.mod.gml:1984
{
if ((GameCont.subarea == 1)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits += 1;
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = true;
;
}
_fr.pc=16;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:2023
function fr_Frontier_Events_mod_gml_ScrapyardsNight_create() {
if ((GameCont.subarea == 1)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops == false)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(2, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroNight);
;
}
}
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
compatCheck = false;
;
compatTimer = 10;
;
{ var __fr_with4 = scrFRWithValues(TopCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
darkness = 1;
;
}
}
if(__fr_break6) break;
}}
background_set_colour(make_color_rgb(83, 85, 119));
;
{ var __fr_with7 = scrFRWithValues([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalScrapyard]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with10 = scrFRWithValues(scrFRSelf(self)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_scrapyardsnight_check = true;
;
fr_Frontier_Events_mod_gml_ScrapyardsNight_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break12) break;
}}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with13 = scrFRWithValues(Trap), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprTrapNight);
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(TrapScorchMark), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((sprite_index == sprTrapScorchMark)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprTrapScorchMarkNight);
;
}
}
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(Tires), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprTiresDeadNight;
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(CarVenus), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprVenusCarIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprVenusCarHurtNight;
;
}
}
if(__fr_break24) break;
}}
}

// Original Frontier_Events.mod.gml:2080
function fr_Frontier_Events_mod_gml_ScrapyardsNight_compatsprite() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "detailsPlus_ProtoStatueDecal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardProtoStatueDecalNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardProtoStatueDecalDeadNight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_pelagicbottom")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = scrFRBackgroundColour();
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_CoveEntrance")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardCoveEntranceClosedNight;
;
spr_open = global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapyardCoveEntranceOpenNight;
;
spr_debris = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoveEntranceDebrisNight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break9) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with10 = scrFRWithValues(scrFRMatching(Bones, "name", "NTTEBigDecal")), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBigTopDecalScrapyard);
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomObject, "spr_floor", frMacro_Frontier_Events_mod_gml__tespr.SludgePool)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
{ var __fr_with16 = scrFRWithValues(floors), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatSludgePool);
;
}
}
if(__fr_break18) break;
}}
}
}
if(__fr_break15) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(TopDecalScrapyard, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.TopDecalScrapyardAlt)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprTopDecalScrapyardNight);
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(FRCustomObject, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.TrapSpin)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrapSpin);
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching(Scorchmark, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FirePitScorch)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFirePitScorch);
;
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(TopSmall, "sprite_index", sprWall3Top)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TopNight);
;
}
}
if(__fr_break30) break;
}}
{ var __fr_with31 = scrFRWithValues(scrFRMatching(Floor, "sprite_index", sprFloor3)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3Night);
;
}
}
if(__fr_break33) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:2156
function fr_Frontier_Events_mod_gml_ScrapyardsNight_applysprites() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot], "fr_scrapyardsnight_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_scrapyardsnight_check = true;
;
fr_Frontier_Events_mod_gml_ScrapyardsNight_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:2164
function fr_Frontier_Events_mod_gml_ScrapyardsNight_sprite_set(_frl__obj=undefined) {
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Floor)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(FloorExplo)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Wall)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Top)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(TopSmall)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Debris)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Detail)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Bones)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(TopDecalScrapyard)) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Car)) __fr_switch_case2=9;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_switch_value3=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case4=-1;
if(__fr_switch_case4==-1) __fr_switch_case4=0;
switch(__fr_switch_case4) {
case 0:
if (((! styleb) and (sprite_index == sprFloor3))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3Night);
}
if ((styleb and (sprite_index == sprFloor3B))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3BNight);
}
break;
;
}
}
break;
;
case 1:
{ var __fr_switch_value5=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case6=-1;
if(__fr_switch_case6==-1) __fr_switch_case6=0;
switch(__fr_switch_case6) {
case 0:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor3ExploNight);
;
break;
;
}
}
break;
;
case 2:
{ var __fr_switch_value7=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case8=-1;
if(__fr_switch_case8==-1) __fr_switch_case8=0;
switch(__fr_switch_case8) {
case 0:
if ((sprite_index == sprWall3Bot)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3BotNight);
;
outspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3OutNight;
;
topspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TopNight;
;
}
}
break;
;
}
}
break;
;
case 3:
{ var __fr_switch_value9=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case10=-1;
if(__fr_switch_case10==-1) __fr_switch_case10=0;
switch(__fr_switch_case10) {
case 0:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TopNight);
;
break;
;
}
}
break;
;
case 4:
{ var __fr_switch_value11=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case12=-1;
if(__fr_switch_case12==-1) __fr_switch_case12=0;
switch(__fr_switch_case12) {
case 0:
if ((sprite_index == sprWall3Trans)) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall3TransNight);
}
break;
;
}
}
break;
;
case 5:
if ((sprite_index == sprDebris3)) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDebris3Night);
}
break;
;
case 6:
if ((sprite_index == sprDetail3)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetail3Night);
;
}
}
break;
;
case 7:
if ((sprite_index == sprScrapDecal)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprScrapDecalNight);
;
}
}
break;
;
case 8:
if ((sprite_index == sprTopDecalScrapyard)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprTopDecalScrapyardNight);
;
}
}
break;
;
case 9:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCarIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCarHurtNight;
;
break;
;
}
}
}

// Original Frontier_Events.mod.gml:2236
function fr_Frontier_Events_mod_gml_ScrapyardsNight_step() {
if ((compatCheck == false)) {
{
compatTimer -= scrFRSourceScale();
;
if ((compatTimer <= 0)) {
{
compatCheck = true;
;
fr_Frontier_Events_mod_gml_ScrapyardsNight_compatsprite();
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:2246
function fr_Frontier_Events_mod_gml_ScrapyardsNight_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_ScrapyardsNight_cleanup_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Frontier_Events_mod_gml_ScrapyardsNight_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_ScrapyardsNight_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:2269
{
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = false;
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:2267
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:2267
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:2257
{
if (((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Thunderstorm")) && (! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "ScrapyardsNight")))) {
{
if ((GameCont.area == scrFRAreaTryResolve(3))) {
{
if ((GameCont.proto == 1)) {
{
scrFRSoundMusic(mus3b);
;
}
} else {
{
scrFRSoundMusic(mus3);
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
}
}
}
}
}
_fr.pc=3;
break;
case 6: // Frontier_Events.mod.gml:2256
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Events.mod.gml:2256
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Frontier_Events.mod.gml:2256
_fr.pc=(scrFRInstanceExists(SkillIcon))?7:4;
break;
case 8: // Frontier_Events.mod.gml:2255
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Events.mod.gml:2254
{
;
}
_fr.pc=8;
break;
case 10: // Frontier_Events.mod.gml:2254
_fr.wait_ticks=max(0,2); _fr.pc=9; return;
break;
case 11: // Frontier_Events.mod.gml:2249
{
if ((((((GameCont.area != scrFRAreaTryResolve(3)) && (GameCont.area != scrFRAreaTryResolve(100))) && (GameCont.area != scrFRAreaTryResolve("bigdog"))) && (GameCont.area != scrFRAreaTryResolve("junkyard"))) && (GameCont.area != scrFRAreaTryResolve("ravenboss")))) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
}
}
}
_fr.pc=10;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:2273
function fr_Frontier_Events_mod_gml_CurseSpread_area() {
return 4;
;
}

// Original Frontier_Events.mod.gml:2274
function fr_Frontier_Events_mod_gml_CurseSpread_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingCurseSpreadEventSpawnChance + ((scrFRCrownCurrent() == crwn_curses) * 0.12));
;
}

// Original Frontier_Events.mod.gml:2275
function fr_Frontier_Events_mod_gml_CurseSpread_create() {
repeat ((3 + scrFRSourceIRandom(2))) {
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRModCall("mod", "Frontier_Caves", "CurseCaveSpreader_create", (x + 16), (y + 16));
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues(Spider), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((scrFRSourceRandom(4) < 1)) {
{
scrFRInstanceCreate(x, y, InvSpider);
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(LaserCrystal), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
scrFRInstanceCreate(x, y, InvLaserCrystal);
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, WeaponChest)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRInstanceCreate(x, y, CursedBigChest);
{ var __fr_with13 = scrFRWithValues(scrFRModCall("mod", "Frontier_Caves", "CurseCaveSpreader_create", x, y)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
curseRange = 48;
;
}
}
if(__fr_break15) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with16 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, BigWeaponChest)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRInstanceCreate(x, y, CursedBigChest);
{ var __fr_with19 = scrFRWithValues(scrFRModCall("mod", "Frontier_Caves", "CurseCaveSpreader_create", x, y)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
curseRange = 48;
;
}
}
if(__fr_break21) break;
}}
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with22 = scrFRWithValues(scrFRMatchingNE(prop, "top_object", undefined)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
depth = (- 11);
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.MortarIdle)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
if ((scrFRSourceRandom(4) < 1)) {
{
scrFRModCall("mod", "telib", "obj_create", x, y, "InvMortar");
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.CrystalBatIdle)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
scrFRModCall("mod", "telib", "obj_create", x, y, "InvCrystalBat");
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break30) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:2337
function fr_Frontier_Events_mod_gml_Blizzard_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("SO COLD", "THE WIND IS HOWLING")));
;
}

// Original Frontier_Events.mod.gml:2338
function fr_Frontier_Events_mod_gml_Blizzard_area() {
return 5;
;
}

// Original Frontier_Events.mod.gml:2339
function fr_Frontier_Events_mod_gml_Blizzard_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingBlizzardEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.55));
;
}

// Original Frontier_Events.mod.gml:2341
function fr_Frontier_Events_mod_gml_Blizzard_create() {
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(5, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroWeather);
;
}
}
blizzardVignetteColor = make_colour_rgb(107, 187, 255);
;
blizzardFogColor = make_color_rgb(7, 48, 83);
;
spr_snowflakes = global.fr_module_vars[$ "mod:Frontier_Events"].sprBlizzardSnow;
;
if (frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Aurora")) {
{
blizzardVignetteColor = make_colour_rgb(63, 43, 150);
;
blizzardFogColor = make_colour_rgb(70, 65, 210);
;
spr_snowflakes = global.fr_module_vars[$ "mod:Frontier_Events"].sprBlizzardSnowNight;
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos = 0;
;
var _frl_spr_snow = spr_snowflakes;
;
scrFRSoundAmbient(global.fr_module_vars[$ "mod:Frontier_Events"].ambBlizzard);
scrFRBindDraw(fr_Frontier_Events_mod_gml_SolidColorFog_add, (- 12), blizzardFogColor, 0.75);
;
scrFRBindDraw(fr_Frontier_Events_mod_gml_Blizzard_vignette, (- 13), x, y, blizzardVignetteColor);
;
scrFRBindDraw(fr_Frontier_Events_mod_gml_BlizzardSnow_draw, (- 9), _frl_spr_snow, (- 8), 2);
;
}

// Original Frontier_Events.mod.gml:2381
function fr_Frontier_Events_mod_gml_Blizzard_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_Blizzard_cleanup_resume, id, scrFROther(other), _args, 9, []);
}
function fr_Frontier_Events_mod_gml_Blizzard_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_Blizzard_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:2391
{
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:2391
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Frontier_Events.mod.gml:2385
{
if ((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Blizzard"))) {
{
if ((GameCont.area == scrFRAreaTryResolve(5))) {
{
scrFRSoundAmbient(amb5);
global.fr_module_vars[$ "mod:Frontier_Events"].eventAmbiencePlaying = false;
;
}
}
}
}
}
_fr.pc=2;
break;
case 5: // Frontier_Events.mod.gml:2384
{
;
}
_fr.pc=4;
break;
case 6: // Frontier_Events.mod.gml:2384
_fr.wait_ticks=max(0,1); _fr.pc=5; return;
break;
case 4: // Frontier_Events.mod.gml:2384
_fr.pc=(scrFRInstanceExists(SkillIcon))?6:3;
break;
case 7: // Frontier_Events.mod.gml:2383
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 0;
break;
case 8: // Frontier_Events.mod.gml:2382
{
;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:2382
_fr.wait_ticks=max(0,2); _fr.pc=8; return;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:2394
function fr_Frontier_Events_mod_gml_Blizzard_step() {
var _frl__snowDirection = (190 + (sin((scrFRSourceFrame() * 0.06)) * 20));
var _frl__spr_snow = spr_snowflakes;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(SnowFlake, "fr_blizzardSnowCheck", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(_frl__spr_snow);
;
direction = _frl__snowDirection;
;
speed = (8) * timescale;
;
fr_blizzardSnowCheck = true;
;
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos += scrFRSourceScale();
;
}

// Original Frontier_Events.mod.gml:2422
function fr_Frontier_Events_mod_gml_Blizzard_vignette(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined) {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=race, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(scrFRRaceTryResolve("eyes"))) __fr_switch_case5=0;
if(__fr_switch_case5==-1) __fr_switch_case5=1;
switch(__fr_switch_case5) {
case 0:
var _frl_eyesRadius = 0.3;
break;
;
case 1:
var _frl_eyesRadius = 0;
}
}
scrFRDrawSetVisibleAll(false);
;
scrFRDrawSetVisible(index, true);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprVignette, 0, x, y, ((0.6 + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), ((0.6 + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), 0, _frl__color, 1);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprVignetteOuter, 0, x, y, (((0.6 + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)) * 3), (((0.6 + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)) * 3), 0, _frl__color, 1);
;
scrFRDrawSetVisibleAll(true);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:2441
function fr_Frontier_Events_mod_gml_BlizzardSnow_draw(_frl__sprite=undefined, _frl__xSpeed=undefined, _frl__ySpeed=undefined) {
draw_sprite_tiled(_frl__sprite, 0, (global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos * _frl__xSpeed), ((global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos * _frl__ySpeed) + (sin((scrFRSourceFrame() * 0.1)) * 20)));
draw_sprite_tiled(_frl__sprite, 1, ((global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos * _frl__xSpeed) * 0.8), (((global.fr_module_vars[$ "mod:Frontier_Events"].blizzardSnowPos + 45) * _frl__ySpeed) + (sin((scrFRSourceFrame() * 0.06)) * 30)));
}

// Original Frontier_Events.mod.gml:2445
function fr_Frontier_Events_mod_gml_SolidColorFog_add(_frl__color=undefined, _frl__alpha=undefined) {
gpu_set_blendmode(bm_add);
draw_sprite_tiled_ext(global.fr_module_vars[$ "mod:Frontier_Events"].sprSolidColorFog, 0, x, y, 160, 160, _frl__color, _frl__alpha);
;
gpu_set_blendmode(bm_normal);
}

// Original Frontier_Events.mod.gml:2450
function fr_Frontier_Events_mod_gml_SolidColorFog_normal(_frl__color=undefined, _frl__alpha=undefined) {
draw_sprite_tiled_ext(global.fr_module_vars[$ "mod:Frontier_Events"].sprSolidColorFog, 0, x, y, 160, 160, _frl__color, _frl__alpha);
;
}

// Original Frontier_Events.mod.gml:2455
function fr_Frontier_Events_mod_gml_Aurora_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("PRETTY", "SHINING COLORS")));
;
}

// Original Frontier_Events.mod.gml:2456
function fr_Frontier_Events_mod_gml_Aurora_area() {
return [5, "city"];
;
}

// Original Frontier_Events.mod.gml:2457
function fr_Frontier_Events_mod_gml_Aurora_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops ? global.fr_module_vars[$ "mod:Frontier_Events"].nightLoop : (((! (GameCont.subarea == 1)) && (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits == 0)) ? 0 : ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.25)) + (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits > 0))));
;
}

// Original Frontier_Events.mod.gml:2461
function fr_Frontier_Events_mod_gml_Aurora_setup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_Aurora_setup_resume, id, scrFROther(other), _args, 15, []);
}
function fr_Frontier_Events_mod_gml_Aurora_setup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_Aurora_setup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:2493
{
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = true;
;
scrFRBindEndStep(fr_Frontier_Events_mod_gml_Aurora_applysprites, 0);
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:2491
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:2491
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:2487
{
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=3;
break;
case 5: // Frontier_Events.mod.gml:2487
_fr.wait_ticks=max(0,1); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:2486
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 7: // Frontier_Events.mod.gml:2482
{
_fr.vars._EventMusic = global.fr_module_vars[$ "mod:Frontier_Events"].musFrozenCityNight;
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=6;
break;
case 8: // Frontier_Events.mod.gml:2476
{
;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:2476
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Frontier_Events.mod.gml:2474
{
;
scrFRModSet("mod", "radioactive", "track_found", false);
;
}
_fr.pc=9;
break;
case 11: // Frontier_Events.mod.gml:2474
_fr.wait_ticks=max(0,1); _fr.pc=10; return;
break;
case 12: // Frontier_Events.mod.gml:2473
_fr.pc = (scrFRTaskFork(_fr, 11)) ? 11 : 7;
break;
case 13: // Frontier_Events.mod.gml:2472
_fr.pc = (scrFRModExists("mod", "radioactive", "menuhandler")) ? 12 : 7;
break;
case 14: // Frontier_Events.mod.gml:2471
_fr.pc = (scrFRModLoaded("mod", "radioactive")) ? 13 : 7;
break;
case 15: // Frontier_Events.mod.gml:2464
{
if ((GameCont.subarea == 1)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits += 1;
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = true;
;
}
_fr.pc=14;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:2498
function fr_Frontier_Events_mod_gml_Aurora_create() {
if ((GameCont.subarea == 1)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops == false)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(3, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroNight);
;
}
}
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
global.fr_module_vars[$ "mod:Frontier_Events"].currentAuroras = 0;
;
allowAuroras = true;
;
changeSnow = true;
;
compatCheck = false;
;
compatTimer = 10;
;
if (frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Blizzard")) {
{
allowAuroras = false;
;
changeSnow = false;
;
}
}
{ var __fr_with4 = scrFRWithValues(TopCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
darkness = 1;
;
}
}
if(__fr_break6) break;
}}
background_set_colour(make_color_rgb(77, 73, 127));
;
{ var __fr_with7 = scrFRWithValues([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalCity, SnowFloor, SnowMan, SnowBotCar, CarThrow]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with10 = scrFRWithValues(scrFRSelf(self)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_aurora_check = true;
;
fr_Frontier_Events_mod_gml_Aurora_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break12) break;
}}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with13 = scrFRWithValues(StreetLight), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprStreetLightDeadNight;
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(SodaMachine), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprSodaMachineDeadNight;
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(SnowMan), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowManDeadNight;
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(Hydrant), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
if ((spr_idle == sprHydrant)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprHydrantDeadNight;
;
}
}
if ((spr_idle == sprNewsStand)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprNewsStandDeadNight;
;
}
}
if ((spr_idle == sprIcicle)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprIcicleDeadNight;
;
}
}
}
}
if(__fr_break24) break;
}}
}

// Original Frontier_Events.mod.gml:2579
function fr_Frontier_Events_mod_gml_Aurora_compatsprite() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE([Wall, Floor, SnowFloor], "fr_aurorasprite", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(fr_aurorasprite);
;
if (scrFRVariableExists(scrFRSelf(self), "fr_auroratopspr")) {
{
topspr = fr_auroratopspr;
;
outspr = fr_auroraoutspr;
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "detailsPlus_ProtoStatueDecal")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCityProtoStatueDecalNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCityProtoStatueDecalDeadNight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_pelagicbottom")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_blend = scrFRBackgroundColour();
;
}
}
if(__fr_break9) break;
}}
if (scrFRModLoaded("mod", "ntte")) {
{
{ var __fr_with10 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.IglooFrontIdle)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFront;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFrontHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooFrontDead;
;
}
}
if(__fr_break12) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.IglooSideIdle)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSide;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSideHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatIglooSideDead;
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorSeal)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSeal);
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorSealRoom)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSealRoom);
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorSealRoomBig)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatFloorSealRoomBig);
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_dead", frMacro_Frontier_Events_mod_gml__tespr.PalankingStatueDead)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingStatueDead;
;
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(TopSmall, "sprite_index", sprWall5Top)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TopNight);
;
}
}
if(__fr_break30) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:2639
function fr_Frontier_Events_mod_gml_Aurora_step() {
if ((compatCheck == false)) {
{
compatTimer -= scrFRSourceScale();
;
if ((compatTimer <= 0)) {
{
compatCheck = true;
;
fr_Frontier_Events_mod_gml_Aurora_compatsprite();
;
}
}
}
}
if ((((scrFRSourceRandom(70) < scrFRSourceScale()) && (global.fr_module_vars[$ "mod:Frontier_Events"].currentAuroras < global.fr_module_vars[$ "mod:Frontier_Events"].settingMaxAuroras)) && (allowAuroras == true))) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_random, Floor)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Frontier_Events_mod_gml_AuroraLightController_create(x, y);
global.fr_module_vars[$ "mod:Frontier_Events"].currentAuroras += 1;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((changeSnow == true)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRMatching(SnowFlake, "fr_aurora_check", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with7 = scrFRWithValues(scrFRSelf(self)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_aurora_check = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFlakeNight);
;
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
}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(SnowBotCar, "spr_idle", sprSnowBotRedCarIdle)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with13 = scrFRWithValues(scrFRSelf(self)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
fr_aurora_check = true;
;
spr_idle = sprSnowBotCarIdle;
;
spr_hurt = sprSnowBotCarHurt;
;
spr_walk = sprSnowBotCarWalk;
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
{ var __fr_with16 = scrFRWithValues(scrFRMatching(CarThrow, "fr_aurora_check", undefined)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with19 = scrFRWithValues(scrFRSelf(self)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
fr_aurora_check = true;
;
sprite_index = scrFRAreaSourceSprite(sprFrozenCarThrown);
;
}
}
if(__fr_break21) break;
}}
}
}
}
if(__fr_break18) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_dead", global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingStatueDead)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingStatue, phase);
;
}
}
if(__fr_break24) break;
}}
}

// Original Frontier_Events.mod.gml:2688
function fr_Frontier_Events_mod_gml_AuroraLightController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_auroraController";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
color1 = scrFRSourceChoose(c_fuchsia, c_aqua, 16745694, c_teal);
;
color2 = scrFRSourceChoose(c_lime, c_blue, c_lime);
;
wavespeed = scrFRSourceRandomRange(2500, 4500);
;
waveheight = scrFRSourceRandomRange(4, 6);
;
auroraheight = scrFRSourceRandomRange(50, 70);
aurorafade = 0;
;
lifetime = scrFRSourceRandomRange(600, 1000);
aurorabobheight = scrFRSourceRandomRange(10, 15);
aurorabobspeed = scrFRSourceRandomRange(0.01, 0.015);
on_step = fr_Frontier_Events_mod_gml_AuroraLightController_step;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:2708
function fr_Frontier_Events_mod_gml_AuroraLightController_step() {
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Frontier_Events_mod_gml_AuroraLights_draw, (- 12))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
color1 = __fr_other4.color1;
;
var __fr_other5=scrFROther(other);
color2 = __fr_other5.color2;
;
var __fr_other6=scrFROther(other);
wavespeed = __fr_other6.wavespeed;
;
var __fr_other7=scrFROther(other);
waveheight = __fr_other7.waveheight;
;
var __fr_other8=scrFROther(other);
aurorafade = __fr_other8.aurorafade;
;
var __fr_other9=scrFROther(other);
auroraheight = __fr_other9.auroraheight;
;
var __fr_other10=scrFROther(other);
aurorabobheight = __fr_other10.aurorabobheight;
;
var __fr_other11=scrFROther(other);
aurorabobspeed = __fr_other11.aurorabobspeed;
;
var __fr_other12=scrFROther(other);
x = __fr_other12.x;
var __fr_other13=scrFROther(other);
y = __fr_other13.y;
}
}
if(__fr_break3) break;
}}
if ((lifetime > 0)) {
{
lifetime -= scrFRSourceScale();
;
}
}
if (((aurorafade < 0.5) && (lifetime > 0))) {
{
aurorafade += (0.005 * scrFRSourceScale());
}
}
if (((aurorafade > 0) && (lifetime <= 0))) {
{
aurorafade -= (0.005 * scrFRSourceScale());
}
}
if (((aurorafade <= 0) && (lifetime <= 0))) {
{
scrFRInstanceDestroy();
}
}
}

// Original Frontier_Events.mod.gml:2745
function fr_Frontier_Events_mod_gml_AuroraLights_draw() {
var _frl_aurorabob = (sin((scrFRSourceFrame() * aurorabobspeed)) * aurorabobheight);
draw_primitive_begin(pr_trianglestrip);
{
i = 10;
for (; (i <= 30); i++) {
draw_vertex_color(((scrFRViewCoordinate(0) + (i * (view_width / 16))) - (view_width / 1.5)), ((y + (sin(((current_time / wavespeed) + i)) * waveheight)) + _frl_aurorabob), color1, aurorafade);
draw_vertex_color(((scrFRViewCoordinate(0) + (i * (view_width / 16))) - (view_width / 1.5)), (((y + (sin(((current_time / wavespeed) + i)) * waveheight)) + auroraheight) + _frl_aurorabob), color2, 0);
}
}
draw_primitive_end();
scrFRInstanceDestroy();
}

// Original Frontier_Events.mod.gml:2755
function fr_Frontier_Events_mod_gml_Aurora_applysprites() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, Bones, prop, TopPot, CarThrow, SnowBotCar], "fr_aurora_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_aurora_check = true;
;
fr_Frontier_Events_mod_gml_Aurora_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:2763
function fr_Frontier_Events_mod_gml_Aurora_sprite_set(_frl__obj=undefined) {
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Floor)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(FloorExplo)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Wall)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Top)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(TopSmall)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(SnowFloor)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Debris)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Detail)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Bones)) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==(TopDecalCity)) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Car)) __fr_switch_case2=10;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_switch_value3=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case4=-1;
if(__fr_switch_case4==-1) __fr_switch_case4=0;
switch(__fr_switch_case4) {
case 0:
if (((! styleb) and (sprite_index == sprFloor5))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5Night);
}
if ((styleb and (sprite_index == sprFloor5B))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5BNight);
}
break;
;
}
}
break;
;
case 1:
{ var __fr_switch_value5=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case6=-1;
if(__fr_switch_case6==-1) __fr_switch_case6=0;
switch(__fr_switch_case6) {
case 0:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloor5ExploNight);
;
break;
;
}
}
break;
;
case 2:
{ var __fr_switch_value7=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case8=-1;
if(__fr_switch_case8==-1) __fr_switch_case8=0;
switch(__fr_switch_case8) {
case 0:
if ((sprite_index == sprWall5Bot)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5BotNight);
;
outspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5OutNight;
;
topspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TopNight;
;
}
}
break;
;
}
}
break;
;
case 3:
{ var __fr_switch_value9=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case10=-1;
if(__fr_switch_case10==-1) __fr_switch_case10=0;
switch(__fr_switch_case10) {
case 0:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TopNight);
;
break;
;
}
}
break;
;
case 4:
{ var __fr_switch_value11=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case12=-1;
if(__fr_switch_case12==-1) __fr_switch_case12=0;
switch(__fr_switch_case12) {
case 0:
if ((sprite_index == sprWall5Trans)) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TransNight);
}
break;
;
}
}
break;
;
case 5:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorNight);
;
break;
;
case 6:
if ((sprite_index == sprDebris5)) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDebris5Night);
}
break;
;
case 7:
if ((sprite_index == sprDetail5)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetail5Night);
;
}
}
break;
;
case 8:
if ((sprite_index == sprIceDecal)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprIceDecalNight);
;
}
}
break;
;
case 9:
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprTopDecalCityNight);
;
break;
;
case 10:
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprFrozenCarNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprFrozenCarHurtNight;
;
break;
;
}
}
}

// Original Frontier_Events.mod.gml:2838
function fr_Frontier_Events_mod_gml_Aurora_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_Aurora_cleanup_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Frontier_Events_mod_gml_Aurora_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_Aurora_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:2860
{
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = false;
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:2858
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:2858
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:2848
{
if ((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Aurora"))) {
{
if ((GameCont.area == scrFRAreaTryResolve(5))) {
{
if ((GameCont.proto == 1)) {
{
scrFRSoundMusic(mus5b);
;
}
} else {
{
scrFRSoundMusic(mus5);
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
}
}
}
}
}
_fr.pc=3;
break;
case 6: // Frontier_Events.mod.gml:2847
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Events.mod.gml:2847
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Frontier_Events.mod.gml:2847
_fr.pc=(scrFRInstanceExists(SkillIcon))?7:4;
break;
case 8: // Frontier_Events.mod.gml:2846
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Events.mod.gml:2845
{
;
}
_fr.pc=8;
break;
case 10: // Frontier_Events.mod.gml:2845
_fr.wait_ticks=max(0,2); _fr.pc=9; return;
break;
case 11: // Frontier_Events.mod.gml:2841
{
if (((((GameCont.area != scrFRAreaTryResolve(5)) && (GameCont.area != scrFRAreaTryResolve(100))) && (GameCont.area != scrFRAreaTryResolve(105))) && (GameCont.area != scrFRAreaTryResolve("city")))) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
}
}
}
_fr.pc=10;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:2864
function fr_Frontier_Events_mod_gml_HauntedCity_area() {
return [5, "city"];
;
}

// Original Frontier_Events.mod.gml:2865
function fr_Frontier_Events_mod_gml_HauntedCity_chance() {
return global.fr_module_vars[$ "mod:Frontier_Events"].settingHauntedCityEventSpawnChance;
;
}

// Original Frontier_Events.mod.gml:2866
function fr_Frontier_Events_mod_gml_HauntedCity_create() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([SnowTank, SnowBot, Wolf, GoldSnowTank], "fr_hauntedcity", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_hauntedcity = true;
;
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "Voltergeist_create", x, y)), __fr_break6=false;
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
scrFRModCall("mod", "Frontier_Labs", "Voltergeist_possess_manual");
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
repeat ((3 + scrFRSourceIRandom(3))) {
var _frl__ghostRoomFloor = [];
var _frl__ghostRoomIndex = (- 1);
{ var __fr_with8 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_FloorNormal), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
if ((point_distance(frMacro_Frontier_Events_mod_gml_bbox_center_x, frMacro_Frontier_Events_mod_gml_bbox_center_y, 10016, 10016) > 48)) {
{
if ((((! scrFRPlaceMeeting(x, y, Wall)) && (! scrFRPlaceMeeting(x, y, prop))) && (! scrFRPlaceMeeting(x, y, chestprop)))) {
{
array_push(_frl__ghostRoomFloor, scrFRSelf(self));
;
_frl__ghostRoomIndex++;
;
}
}
}
}
}
}
if(__fr_break10) break;
}}
frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.array_shuffle, _frl__ghostRoomFloor);
;
if ((_frl__ghostRoomIndex >= 0)) {
{ var __fr_with11 = scrFRWithValues(scrFRIndexGet(_frl__ghostRoomFloor, (_frl__ghostRoomIndex--))), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var _frl__w = 1;
var _frl__h = 1;
var _frl__type = "";
var _frl__dirOff = 0;
var _frl__floorDis = scrFRSourceChoose(0, (- 16));
var _frl__spawnX = x;
var _frl__spawnY = y;
var _frl__spawnDis = 128;
var _frl__spawnFloor = frMacro_Frontier_Events_mod_gml_FloorNormal;
;
{ var __fr_with14 = scrFRWithValues(frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.floor_room, _frl__spawnX, _frl__spawnY, _frl__spawnDis, _frl__spawnFloor, _frl__w, _frl__h, _frl__type, _frl__dirOff, _frl__floorDis)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
var _frl__myx = (x - 16);
var _frl__myy = (y - 16);
;
{
var _frl_j = 0;
for (; (_frl_j < array_length(floors)); _frl_j++) {
{ var __fr_with17 = scrFRWithValues(scrFRIndexGet(floors, _frl_j)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
fr_labsentrance_check = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpost);
;
image_index = scrFRSourceIRandom(5);
;
depth -= 2;
;
{ var __fr_with20 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceIRandomRange((- 1), 1)), (y - scrFRSourceIRandomRange(2, 3)), SnowFloor)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpostSnow);
;
var __fr_other23=scrFROther(other);
image_speed = ((__fr_other23.image_speed / timescale)) * timescale;
;
var __fr_other24=scrFROther(other);
image_index = __fr_other24.image_index;
;
image_angle += scrFRSourceRandomRange((- 1), 1);
var __fr_other25=scrFROther(other);
depth = (__fr_other25.depth + 1);
;
fr_aurorasprite = global.fr_module_vars[$ "mod:Frontier_Events"].sprSnowFloorOutpostSnowNight;
;
}
}
if(__fr_break22) break;
}}
var _frl__prop = scrFRSourceChoose("tube", "pump");
;
{ var __fr_switch_value26=_frl__prop, __fr_switch_case27=-1;
if(__fr_switch_case27==-1 && __fr_switch_value26==("pump")) __fr_switch_case27=0;
if(__fr_switch_case27==-1 && __fr_switch_value26==("tube")) __fr_switch_case27=1;
if(__fr_switch_case27==-1) __fr_switch_case27=-1;
switch(__fr_switch_case27) {
case 0:
scrFRModCall("area", "graveyard", "VolterPump_create", (x + 16), (y + 16));
;
break;
;
case 1:
scrFRModCall("area", "deeplabs", "VoltergeistTube_create", (x + 16), (y + 18));
;
break;
;
}
}
}
}
if(__fr_break19) break;
}}
}
}
}
}
if(__fr_break16) break;
}}
{ var __fr_with28 = scrFRWithValues(Wall), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
if ((point_distance(x, y, _frl__myx, _frl__myy) < 32)) {
{
fr_labsentrance_check = true;
;
topspr = sprWall5Top;
;
outspr = sprWall5Out;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprCityWallOutpostBot);
;
fr_aurorasprite = global.fr_module_vars[$ "mod:Frontier_Events"].sprCityWallOutpostBotNight;
;
fr_auroratopspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5TopNight;
;
fr_auroraoutspr = global.fr_module_vars[$ "mod:Frontier_Events"].sprWall5OutNight;
;
}
}
}
}
if(__fr_break30) break;
}}
}
}
if(__fr_break13) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:2968
function fr_Frontier_Events_mod_gml_Blackout_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("LIGHTS OUT", "SYSTEM FAILURE")));
;
}

// Original Frontier_Events.mod.gml:2969
function fr_Frontier_Events_mod_gml_Blackout_chance() {
return global.fr_module_vars[$ "mod:Frontier_Events"].settingBlackoutEventSpawnChance;
;
}

// Original Frontier_Events.mod.gml:2970
function fr_Frontier_Events_mod_gml_Blackout_area() {
return [6, "labs"];
;
}

// Original Frontier_Events.mod.gml:2972
function fr_Frontier_Events_mod_gml_Blackout_setup() {
scrFRBindEndStep(fr_Frontier_Events_mod_gml_Blackout_applysprites, 0);
;
}

// Original Frontier_Events.mod.gml:2976
function fr_Frontier_Events_mod_gml_Blackout_create() {
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(6, 1, sndFootPlaSand5);
;
}
}
blackoutScaleTime = 0;
;
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Frontier_Events_mod_gml_Blackout_fog, (- 12))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x = __fr_other4.x;
;
var __fr_other5=scrFROther(other);
y = __fr_other5.y;
;
}
}
if(__fr_break3) break;
}}
if (frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "Blackout")) {
{
{ var __fr_with6 = scrFRWithValues(scrFRMatching(Wall, "fr_blackout_check", undefined)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with9 = scrFRWithValues(scrFRSelf(self)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
fr_blackout_check = true;
;
fr_Frontier_Events_mod_gml_Blackout_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break11) break;
}}
}
}
}
if(__fr_break8) break;
}}
}
}
{ var __fr_with12 = scrFRWithValues(Server), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprServerOff;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprServerOffHurt;
;
}
}
if(__fr_break14) break;
}}
{ var __fr_with15 = scrFRWithValues(Terminal), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
fr_Frontier_Events_mod_gml_TerminalOff_create(x, y);
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break17) break;
}}
}

// Original Frontier_Events.mod.gml:3009
function fr_Frontier_Events_mod_gml_TerminalOff_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprTerminalOff;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprTerminalOffHurt;
;
spr_dead = sprTerminalDead;
;
spr_shadow = shd24;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
scrFRMaxHealthWrite(id, 10, "=");
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

// Original Frontier_Events.mod.gml:3027
function fr_Frontier_Events_mod_gml_Blackout_applysprites() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Wall, "fr_blackout_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_blackout_check = true;
;
fr_Frontier_Events_mod_gml_Blackout_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3035
function fr_Frontier_Events_mod_gml_Blackout_sprite_set(_frl__obj=undefined) {
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Wall)) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_switch_value3=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case4=-1;
if(__fr_switch_case4==-1) __fr_switch_case4=0;
switch(__fr_switch_case4) {
case 0:
if ((sprite_index == sprWall6Bot)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprWall6BotBlackout);
;
}
}
break;
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:3048
function fr_Frontier_Events_mod_gml_Blackout_step() {
if (fr_Frontier_Events_mod_gml_every(60)) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Events"].sndImpostorAlert);
;
blackoutScaleTime = 45;
;
}
}
if ((blackoutScaleTime > 0)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale = clamp((blackoutScaleTime / 30), 0.25, 0.8);
;
blackoutScaleTime -= scrFRSourceScale();
;
}
} else {
{
global.fr_module_vars[$ "mod:Frontier_Events"].blackoutScale = 0.25;
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomHitme, "name", "fr_ElectricityTrap"), "activated", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = spr_off;
;
activated = false;
;
if (scrFRInstanceExists(myBall)) {
{
{ var __fr_with4 = scrFRWithValues(myBall), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break6) break;
}}
}
}
myBall = noone;
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3082
function fr_Frontier_Events_mod_gml_Blackout_vignette(_frl__scale=undefined) {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_switch_value4=race, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==(scrFRRaceTryResolve("eyes"))) __fr_switch_case5=0;
if(__fr_switch_case5==-1) __fr_switch_case5=1;
switch(__fr_switch_case5) {
case 0:
var _frl_eyesRadius = 0.3;
break;
;
case 1:
var _frl_eyesRadius = 0;
}
}
scrFRDrawSetVisibleAll(false);
;
scrFRDrawSetVisible(index, true);
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprVignette, 0, x, y, ((_frl__scale + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), ((_frl__scale + _frl_eyesRadius) + (scrFRGetSkill("bat ears") * 0.3)), 0, make_colour_rgb(0, 0, 0), 1);
;
scrFRDrawSetVisibleAll(true);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Frontier_Events.mod.gml:3111
function fr_Frontier_Events_mod_gml_Blackout_fog() {
gpu_set_blendmode(bm_add);
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprFogBlackout, (scrFRSourceFrame() / 10), (scrFRViewCoordinate(0) + 1000), scrFRViewCoordinate(1), 160, 160, scrFRSourceRandom(360), c_white, 0.28);
gpu_set_blendmode(bm_normal);
}

// Original Frontier_Events.mod.gml:3118
function fr_Frontier_Events_mod_gml_BoilingWater_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : "ITS JUST @eBOILING WATER?"));
;
}

// Original Frontier_Events.mod.gml:3119
function fr_Frontier_Events_mod_gml_BoilingWater_chance() {
return ((GameCont.subarea == 3) ? 0 : 0.125);
;
}

// Original Frontier_Events.mod.gml:3120
function fr_Frontier_Events_mod_gml_BoilingWater_area() {
return [7, "palace"];
;
}

// Original Frontier_Events.mod.gml:3122
function fr_Frontier_Events_mod_gml_BoilingWater_create() {
{ var __fr_with1 = scrFRWithValues(Floor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((((! scrFRPlaceMeeting(x, y, Player)) || (! scrFRPlaceMeeting(x, y, enemy))) || (! scrFRPlaceMeeting(x, y, hitme))) || (! scrFRPlaceMeeting(x, y, chestprop))) || (! scrFRPlaceMeeting(x, y, prop)))) {
{
if ((scrFRSourceRandom(30) < 1)) {
{
var _frl_myx = (x + scrFRSourceChoose(0, 16));
;
var _frl_myy = (y + scrFRSourceChoose(0, 16));
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(_frl_myx, _frl_myy, Wall)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRInstanceCreate(x, y, NOWALLSHEREPLEASE);
if (((point_distance(_frl_myx, _frl_myy, Player.x, Player.y) > 90) && (distance_to_object(BigWeaponChest) > 64))) {
{
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Palace", "RadFlameTrap_create", _frl_myx, _frl_myy)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapScorchMark)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprPalaceTrapScorchMark);
;
depth = 8;
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

// Original Frontier_Events.mod.gml:3144
function fr_Frontier_Events_mod_gml_SerpentLair_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : scrFRSourceChoose("YOU'RE HISSTORY", "IT BITES")));
;
}

// Original Frontier_Events.mod.gml:3145
function fr_Frontier_Events_mod_gml_SerpentLair_chance() {
return ((GameCont.subarea == 3) ? 0 : global.fr_module_vars[$ "mod:Frontier_Events"].settingSerpentLairEventSpawnChance);
;
}

// Original Frontier_Events.mod.gml:3146
function fr_Frontier_Events_mod_gml_SerpentLair_area() {
return [7, "palace"];
;
}

// Original Frontier_Events.mod.gml:3147
function fr_Frontier_Events_mod_gml_SerpentLair_create() {
serpentLairCooldown = 110;
;
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(8, 2, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroSerpent);
;
}
}
}

// Original Frontier_Events.mod.gml:3155
function fr_Frontier_Events_mod_gml_SerpentLair_step() {
if ((serpentLairCooldown >= 0)) {
{
serpentLairCooldown -= scrFRSourceScale();
}
}
if ((serpentLairCooldown <= 0)) {
{
if ((scrFRInstanceExists(enemy) && scrFRInstanceExists(Player))) {
{
if ((scrFRSourceRandom(50) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_PalaceSerpent")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
scrFRModCall("mod", "Frontier_Palace", "PalaceSerpentSpawner_create", 10016, 10016);
;
serpentLairCooldown += 200;
}
}
}
}
}
}
}

// Original Frontier_Events.mod.gml:3171
function fr_Frontier_Events_mod_gml_SerpentLair_cleanup() {
var _frl__serpentSound = scrFRModGet("mod", "Frontier_Palace", "serpentSound");
if (audio_is_playing(_frl__serpentSound)) {
{
scrFRSoundStop(_frl__serpentSound);
;
}
}
var _frl__serpentRumbleSound = scrFRModGet("mod", "Frontier_Palace", "serpentSoundRumble");
if (audio_is_playing(_frl__serpentRumbleSound)) {
{
scrFRSoundStop(_frl__serpentRumbleSound);
;
}
}
}

// Original Frontier_Events.mod.gml:3184
function fr_Frontier_Events_mod_gml_EventDropdown_queue(_frl__mainIndex=undefined, _frl__backIndex=undefined, _frl__sound=undefined) {
var _frl__controller = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_nearest_array, 10016, 10016, scrFRMatching(FRCustomObject, "name", "fr_EventDropdownController"));
;
if ((! scrFRInstanceExists(_frl__controller))) {
{
fr_Frontier_Events_mod_gml_EventDropdownController_create(10016, 10016);
;
var _frl__controller = frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.instance_nearest_array, 10016, 10016, scrFRMatching(FRCustomObject, "name", "fr_EventDropdownController"));
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__controller), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
array_push(dropdownsQueue, [_frl__mainIndex, _frl__backIndex]);
;
array_push(soundsQueue, _frl__sound);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3195
function fr_Frontier_Events_mod_gml_EventDropdownController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_EventDropdownController";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
removeMeID = undefined;
;
dropdownDelay = 20;
;
dropdownAllowed = true;
;
arrayIndex = 0;
;
dropdownsQueue = [];
;
soundsQueue = [];
;
on_step = fr_Frontier_Events_mod_gml_EventDropdownController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3213
function fr_Frontier_Events_mod_gml_EventDropdownController_step() {
if ((array_length(dropdownsQueue) < 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((dropdownDelay > 0)) {
{
dropdownDelay -= scrFRSourceScale();
;
}
} else {
{
if (((dropdownAllowed == true) && (arrayIndex <= (array_length(dropdownsQueue) - 1)))) {
{
var _frl__dropdown = scrFRIndexGet(dropdownsQueue, arrayIndex);
var _frl__front = scrFRIndexGet(_frl__dropdown, 0);
var _frl__back = scrFRIndexGet(_frl__dropdown, 1);
;
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Frontier_Events_mod_gml_EventDropdown_draw, (- 1000), scrFRSelf(self), _frl__front, _frl__back)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
imDown = false;
;
upDelay = 35;
;
height = (- 50);
;
letsBounce = false;
;
bounceHeight = 0;
;
bouncedUp = false;
;
letsAGo = false;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPlay(scrFRIndexGet(soundsQueue, arrayIndex));
arrayIndex += 1;
;
dropdownDelay = 10;
;
dropdownAllowed = false;
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:3245
function fr_Frontier_Events_mod_gml_EventDropdown_draw(_frl__controller=undefined, _frl__front=undefined, _frl__back=undefined) {
if ((imDown == false)) {
{
height += (6 * scrFRSourceScale());
;
if ((height >= 20)) {
{
imDown = true;
;
letsBounce = true;
;
}
}
}
}
if ((letsBounce == true)) {
{
if ((bouncedUp == false)) {
{
bounceHeight += (4 * scrFRSourceScale());
;
if ((bounceHeight >= 8)) {
{
bouncedUp = true;
;
}
}
}
} else {
{
bounceHeight -= (2 * scrFRSourceScale());
;
if ((bounceHeight <= 0)) {
{
letsBounce = false;
;
bounceHeight = 0;
;
}
}
}
}
}
}
if ((imDown == true)) {
{
if ((upDelay > 0)) {
{
upDelay -= scrFRSourceScale();
;
}
} else {
{
if ((letsAGo == false)) {
{
bounceHeight += (4 * scrFRSourceScale());
if ((bounceHeight >= 12)) {
{
letsAGo = true;
;
fr_callback__dropdownExtraSpeed = 0;
;
}
}
}
} else {
{
fr_callback__dropdownExtraSpeed += 1;
;
height -= ((10 + fr_callback__dropdownExtraSpeed) * scrFRSourceScale());
;
}
}
}
}
if ((height <= (- 50))) {
{
{ var __fr_with1 = scrFRWithValues(_frl__controller), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
dropdownAllowed = true;
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdownsBack, _frl__back, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + height));
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Events"].sprEventDropdowns, _frl__front, (scrFRViewCoordinate(0) + (view_width / 2)), ((scrFRViewCoordinate(1) + height) + bounceHeight), 1, 1, 0, c_white, 1);
;
}

// Original Frontier_Events.mod.gml:3304
function fr_Frontier_Events_mod_gml_CoastNight_text() {
return scrFRLocalize(((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventText == false) ? undefined : "MOONLIT WAVES"));
}

// Original Frontier_Events.mod.gml:3305
function fr_Frontier_Events_mod_gml_CoastNight_area() {
return "coast";
;
}

// Original Frontier_Events.mod.gml:3306
function fr_Frontier_Events_mod_gml_CoastNight_chance() {
return (global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops ? global.fr_module_vars[$ "mod:Frontier_Events"].nightLoop : (((! (GameCont.subarea == 1)) && (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits == 0)) ? 0 : ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightEventSpawnChance + ((scrFRCrownCurrent() == "storms") * 0.25)) + (global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits > 0))));
;
}

// Original Frontier_Events.mod.gml:3309
function fr_Frontier_Events_mod_gml_CoastNight_setup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_CoastNight_setup_resume, id, scrFROther(other), _args, 7, []);
}
function fr_Frontier_Events_mod_gml_CoastNight_setup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_CoastNight_setup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:3342
{
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = true;
;
scrFRBindEndStep(fr_Frontier_Events_mod_gml_CoastNight_applysprites, 0);
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:3340
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:3340
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:3336
{
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=3;
break;
case 5: // Frontier_Events.mod.gml:3336
_fr.wait_ticks=max(0,1); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:3335
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 7: // Frontier_Events.mod.gml:3311
{
{ var __fr_with1 = scrFRWithValues(Floor), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((sprite_index == frMacro_Frontier_Events_mod_gml__tespr.FloorCoast)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight);
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(frMacro_Frontier_Events_mod_gml__tespr), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
FloorCoast = global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight;
;
CoastTrans = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastTransNight;
;
PalankingChunk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingChunkNight;
;
PalankingBott = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBottNight;
;
}
}
if(__fr_break6) break;
}}
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = true;
;
if ((GameCont.subarea == 1)) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits += 1;
;
}
}
_fr.vars._EventMusic = frMacro_Frontier_Events_mod_gml__temus.CoastB;
;
if ((! audio_is_playing(_fr.vars._EventMusic))) {
{
scrFRSoundMusic(_fr.vars._EventMusic);
;
}
}
}
_fr.pc=6;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:3347
function fr_Frontier_Events_mod_gml_CoastNight_create() {
if ((GameCont.subarea == 1)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingEventDropdowns == true)) {
{
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingNightLoops == false)) {
{
fr_Frontier_Events_mod_gml_EventDropdown_queue(9, 0, global.fr_module_vars[$ "mod:Frontier_Events"].sndEventIntroNight);
;
}
}
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_area_halfdark";
}
}
if(__fr_break3) break;
}}
compatCheck = false;
;
compatTimer = 10;
;
{ var __fr_with4 = scrFRWithValues(TopCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
darkness = 1;
;
}
}
if(__fr_break6) break;
}}
scrFRSpriteReplace(sprWind, sprFR_sprWindNightEvent_b3ccd821ce0a);
scrFRSpriteReplace(sprLeaf, sprFR_sprLeafNight_a1eb08c7f294);
background_set_colour(make_color_rgb(16, 21, 61));
;
{ var __fr_with7 = scrFRWithValues([Floor, FloorExplo, Wall, Top, TopSmall, Debris, Detail, prop, TopPot, Bones, TopDecalScrapyard]), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with10 = scrFRWithValues(scrFRSelf(self)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_coastnight_check = true;
;
fr_Frontier_Events_mod_gml_CoastNight_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break12) break;
}}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with13 = scrFRWithValues(scrFRMatching(Detail, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.DetailCoast)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailCoastNight);
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", scrFRIndexGet(frMacro_Frontier_Events_mod_gml__tespr.BloomingCactusIdle, 0))), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactusDeadNight;
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", scrFRIndexGet(frMacro_Frontier_Events_mod_gml__tespr.BloomingCactusIdle, 1))), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2Night;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2HurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus2DeadNight;
;
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching(Cactus, "spr_idle", scrFRIndexGet(frMacro_Frontier_Events_mod_gml__tespr.BloomingCactusIdle, 2))), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3Night;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3HurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingCactus3DeadNight;
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.BigBloomingCactusIdle)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBigBloomingCactusDeadNight;
;
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", scrFRIndexGet(frMacro_Frontier_Events_mod_gml__tespr.RockIdle, 0))), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1IdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1HurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1DeadNight;
;
spr_bott = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock1BottNight;
;
}
}
if(__fr_break30) break;
}}
{ var __fr_with31 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", scrFRIndexGet(frMacro_Frontier_Events_mod_gml__tespr.RockIdle, 1))), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2IdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2HurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2DeadNight;
;
spr_bott = global.fr_module_vars[$ "mod:Frontier_Events"].sprRock2BottNight;
;
}
}
if(__fr_break33) break;
}}
{ var __fr_with34 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.ShellIdle)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellDeadNight;
;
spr_bott = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatShellBottNight;
;
}
}
if(__fr_break36) break;
}}
{ var __fr_with37 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.PalmIdle)), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmDeadNight;
;
}
}
if(__fr_break39) break;
}}
{ var __fr_with40 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.PalmFortIdle)), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmFortIdleNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmFortHurtNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalmDeadNight;
;
}
}
if(__fr_break42) break;
}}
{ var __fr_with43 = scrFRWithValues(scrFRMatching(FRCustomProp, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.BuriedCarIdle)), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBuriedCarNight;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBuriedCarHurtNight;
;
}
}
if(__fr_break45) break;
}}
{ var __fr_with46 = scrFRWithValues(scrFRMatching(Bush, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.BloomingBushIdle)), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloomingBushNight;
;
}
}
if(__fr_break48) break;
}}
{ var __fr_with49 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_hide", frMacro_Frontier_Events_mod_gml__tespr.CrabHide)), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
spr_hide = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrafficCrabHide;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatTrafficCrabDead;
;
if ((sprite_index == frMacro_Frontier_Events_mod_gml__tespr.CrabHide)) {
{
sprite_index = scrFRAreaSourceSprite(spr_hide);
;
}
}
}
}
if(__fr_break51) break;
}}
{ var __fr_with52 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_bott", frMacro_Frontier_Events_mod_gml__tespr.PalankingBott)), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
{
spr_bott = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBottNight;
;
spr_taun = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingTaunt;
;
spr_call = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingCall;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingDead;
;
spr_burp = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBurp;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingFire;
;
}
}
if(__fr_break54) break;
}}
{ var __fr_with55 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "spr_idle", frMacro_Frontier_Events_mod_gml__tespr.BloomingAssassinHide)), __fr_break57=false;
for (var __fr_index56=0; __fr_index56<array_length(__fr_with55); ++__fr_index56) {
if(scrFRScopeExists(__fr_with55[__fr_index56])) with (__fr_with55[__fr_index56]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHide;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHide;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinDead;
;
}
}
if(__fr_break57) break;
}}
}

// Original Frontier_Events.mod.gml:3481
function fr_Frontier_Events_mod_gml_CoastNight_compatsprite() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "detailsPlus_ProtoStatueDecal")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastProtoStatueDecalNight;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastProtoStatueDecalDeadNight;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(Detail, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.DetailCoast)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprDetailCoastNight);
;
}
}
if(__fr_break6) break;
}}
}

// Original Frontier_Events.mod.gml:3493
function fr_Frontier_Events_mod_gml_CoastNight_applysprites() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching([Floor, FloorExplo, Wall, Debris, Detail, JungleAssassin], "fr_coastnight_check", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_coastnight_check = true;
;
fr_Frontier_Events_mod_gml_CoastNight_sprite_set(scrFRObjectIndex(scrFRSelf(self)));
;
}
}
if(__fr_break6) break;
}}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3501
function fr_Frontier_Events_mod_gml_CoastNight_sprite_set(_frl__obj=undefined) {
{ var __fr_switch_value1=_frl__obj, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Floor)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(FloorExplo)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Wall)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Top)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(Debris)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(JungleAssassin)) __fr_switch_case2=5;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_switch_value3=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case4=-1;
if(__fr_switch_case4==-1) __fr_switch_case4=0;
switch(__fr_switch_case4) {
case 0:
if (((! styleb) && (sprite_index == frMacro_Frontier_Events_mod_gml__tespr.FloorCoast))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight);
}
if ((styleb && (sprite_index == frMacro_Frontier_Events_mod_gml__tespr.FloorCoastB))) {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastBNight);
}
break;
;
}
}
break;
;
case 1:
{ var __fr_switch_value5=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case6=-1;
if(__fr_switch_case6==-1) __fr_switch_case6=0;
switch(__fr_switch_case6) {
case 0:
sprite_index = scrFRAreaSourceSprite(sprFloor0Explo);
;
break;
;
}
}
break;
;
case 2:
{ var __fr_switch_value7=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case8=-1;
if(__fr_switch_case8==-1) __fr_switch_case8=0;
switch(__fr_switch_case8) {
case 0:
if ((sprite_index == sprWall1Bot)) {
{
sprite_index = scrFRAreaSourceSprite(sprWall0Bot);
;
outspr = sprWall0Out;
;
topspr = sprWall0Top;
;
}
}
break;
;
}
}
break;
;
case 3:
{ var __fr_switch_value9=scrFRIndexGet(frMacro_Frontier_Events_mod_gml_area_current, 0), __fr_switch_case10=-1;
if(__fr_switch_case10==-1) __fr_switch_case10=0;
switch(__fr_switch_case10) {
case 0:
if ((sprite_index == sprWall1Top)) {
sprite_index = scrFRAreaSourceSprite(sprWall0Top);
}
break;
;
}
}
break;
;
case 4:
if ((sprite_index == sprDebris1)) {
sprite_index = scrFRAreaSourceSprite(sprDebris0);
}
break;
;
case 5:
if ((spr_idle == frMacro_Frontier_Events_mod_gml__tespr.BloomingAssassinIdle)) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatBloomingAssassinDead;
;
}
}
break;
;
}
}
}

// Original Frontier_Events.mod.gml:3551
function fr_Frontier_Events_mod_gml_CoastNight_step() {
if ((compatCheck == false)) {
{
compatTimer -= scrFRSourceScale();
;
if ((compatTimer <= 0)) {
{
compatCheck = true;
;
fr_Frontier_Events_mod_gml_CoastNight_compatsprite();
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorCoast), "fr_coastNightRetexture2", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_coastNightRetexture2 = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(scrFRMatching(Floor, "sprite_index", frMacro_Frontier_Events_mod_gml__tespr.FloorCoast), "fr_coastNightRetexture", undefined)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_coastNightRetexture = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoastNight);
;
}
}
if(__fr_break6) break;
}}
}

// Original Frontier_Events.mod.gml:3569
function fr_Frontier_Events_mod_gml_CoastNight_cleanup() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_CoastNight_cleanup_resume, id, scrFROther(other), _args, 11, []);
}
function fr_Frontier_Events_mod_gml_CoastNight_cleanup_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_CoastNight_cleanup");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:3600
{
global.fr_module_vars[$ "mod:Frontier_Events"].isNight = false;
;
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:3598
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:3598
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Events.mod.gml:3588
{
if ((! frMacro_Frontier_Events_mod_gml_call(frMacro_Frontier_Events_mod_gml_scr.event_get_active, "CoastNight"))) {
{
if ((GameCont.area == scrFRAreaTryResolve("coast"))) {
{
if ((GameCont.proto == 1)) {
{
scrFRSoundMusic(frMacro_Frontier_Events_mod_gml__temus.CoastB);
;
}
} else {
{
scrFRSoundMusic(frMacro_Frontier_Events_mod_gml__temus.Coast);
;
}
}
global.fr_module_vars[$ "mod:Frontier_Events"].eventMusicPlaying = false;
;
}
}
}
}
}
_fr.pc=3;
break;
case 6: // Frontier_Events.mod.gml:3587
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Events.mod.gml:3587
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // Frontier_Events.mod.gml:3587
_fr.pc=(scrFRInstanceExists(SkillIcon))?7:4;
break;
case 8: // Frontier_Events.mod.gml:3586
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Events.mod.gml:3585
{
;
}
_fr.pc=8;
break;
case 10: // Frontier_Events.mod.gml:3585
_fr.wait_ticks=max(0,2); _fr.pc=9; return;
break;
case 11: // Frontier_Events.mod.gml:3572
{
if (((GameCont.area != scrFRAreaTryResolve("coast")) && (GameCont.area != scrFRAreaTryResolve(100)))) {
{
global.fr_module_vars[$ "mod:Frontier_Events"].nightCredits = 0;
;
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Events_mod_gml__tespr), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
FloorCoast = global.fr_module_vars[$ "mod:Frontier_Events"].sprFloorCoast;
;
CoastTrans = global.fr_module_vars[$ "mod:Frontier_Events"].sprCoastTrans;
;
PalankingChunk = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingChunk;
;
PalankingBott = global.fr_module_vars[$ "mod:Frontier_Events"].sprCompatPalankingBott;
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRSpriteRestore(sprWind);
;
scrFRSpriteRestore(sprLeaf);
;
}
_fr.pc=10;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:3603
function fr_Frontier_Events_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Frontier_Events.mod.gml:3613
function fr_Frontier_Events_mod_gml_BloodCocoon_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoon;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoonHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Events"].sprBloodCocoonDead;
;
snd_hurt = sndHitFlesh;
;
snd_dead = sndCocoonBreak;
;
scrFRMaxHealthWrite(id, 12, "=");
;
hp = max_hp;
;
on_death = fr_Frontier_Events_mod_gml_BloodCocoon_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3635
function fr_Frontier_Events_mod_gml_BloodCocoon_destroy() {
scrFRModCall("mod", "Frontier_Pickups", "BloodLustPickup_create", x, y);
}

// Original Frontier_Events.mod.gml:3642
function fr_Frontier_Events_mod_gml_LightningStrikeSpawn_create(_frl__x=undefined, _frl__y=undefined) {
var _frl_foundAce = false;
;
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((race == scrFRRaceTryResolve("ace"))) {
{
_frl_foundAce = true;
;
__fr_break3=true; break;
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
name = "fr_lightningspawn";
var __fr_other7=scrFROther(other);
creator = __fr_other7;
team = 1;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircle);
;
spr_blink = global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleBlink;
;
if ((_frl_foundAce == true)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleAce);
;
spr_blink = global.fr_module_vars[$ "mod:Frontier_Events"].sprLightningWarningCircleBlinkAce;
;
}
}
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
timer = 45;
;
image_xscale = 0.1;
;
image_yscale = image_xscale;
;
fr_bloom = [1.1, 0.1];
;
on_step = fr_Frontier_Events_mod_gml_LightningStrikeSpawn_step;
;
on_destroy = fr_Frontier_Events_mod_gml_LightningStrikeSpawn_destroy;
;
}
}
if(__fr_break6) break;
}}
}

// Original Frontier_Events.mod.gml:3678
function fr_Frontier_Events_mod_gml_LightningStrikeSpawn_step() {
if (frMacro_Frontier_Events_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 20), 20)), FireFly)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprLightning);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
direction = scrFRSourceRandom(360);
;
depth = (- 3);
;
}
}
if(__fr_break3) break;
}}
if ((image_xscale < 1)) {
{
image_xscale += 0.25;
;
image_yscale = image_xscale;
}
}
}
}
if ((timer > 0)) {
{
timer -= scrFRSourceScale();
}
}
if ((timer < 12)) {
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

// Original Frontier_Events.mod.gml:3694
function fr_Frontier_Events_mod_gml_LightningStrikeSpawn_destroy() {
fr_Frontier_Events_mod_gml_LightningStrike_create(x, y);
}

// Original Frontier_Events.mod.gml:3697
function fr_Frontier_Events_mod_gml_LightningStrike_create(_frl__x=undefined, _frl__y=undefined) {
scrFRSoundPitchVolume(sndExplosion, scrFRSourceRandomRange(1.2, 1.5), 1.2);
scrFRSoundPitchVolume(sndExplosionS, scrFRSourceRandomRange(0.6, 0.8), 1.2);
scrFRSoundPitchVolume(sndLightningPistolUpg, scrFRSourceRandomRange(0.6, 0.8), 1.2);
scrFRSoundPitchVolume(sndLightningCannonUpg, scrFRSourceRandomRange(0.7, 1.2), 1.4);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
vbuf = vertex_create_buffer();
fr_Frontier_Events_mod_gml_lightning_refresh();
hitid = [sprLightningHit, "Lightning Strike"];
name = "Lightning Strike";
time = 4;
;
timestart = time;
;
create_frame = scrFRSourceFrame();
;
colors = [c_black, c_white, c_white, merge_color(c_white, c_white, .3), c_white];
wantdust = 1;
;
damage = 100;
;
knockback_speed = (40) * timescale;
;
mask_index = sprPlasmaBall;
;
image_xscale = 2.5;
;
image_yscale = 2.5;
;
on_wall = fr_Frontier_Events_mod_gml_lightning_wall;
;
on_draw = fr_Frontier_Events_mod_gml_lightning_draw;
;
on_destroy = fr_Frontier_Events_mod_gml_lightning_destroy;
;
on_step = fr_Frontier_Events_mod_gml_lightning_step;
;
on_hit = fr_Frontier_Events_mod_gml_lightning_hit;
;
depth = (- 8);
;
hitlist = [];
;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3731
function fr_Frontier_Events_mod_gml_lightning_wall() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, FloorExplo);
scrFRInstanceDestroy();
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3737
function fr_Frontier_Events_mod_gml_lightning_draw() {
gpu_set_fog(1, scrFRIndexGet(colors, min((scrFRSourceFrame() - create_frame), (array_length_1d(colors) - 1))), 0, 0);
vertex_submit(vbuf, pr_trianglestrip, (- 1));
gpu_set_fog(0, 0, 0, 0);
{
var _frl_i = 0;
for (; (_frl_i < array_length(ypoints)); _frl_i++) {
scrFRDrawSprite(sprLightningHit, (1 + scrFRSourceIRandom(2)), scrFRIndexGet(xpoints, _frl_i), scrFRIndexGet(ypoints, _frl_i));
}
}
}

// Original Frontier_Events.mod.gml:3746
function fr_Frontier_Events_mod_gml_lightning_hit() {
if ((scrFRArrayFindIndex(hitlist, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitlist, __fr_other1);
;
{ var __fr_with2 = scrFRWithValues((scrFROther(other))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
{ var __fr_switch_value5=race, __fr_switch_case6=-1;
if(__fr_switch_case6==-1 && __fr_switch_value5==(scrFRRaceTryResolve("robot"))) __fr_switch_case6=0;
if(__fr_switch_case6==-1) __fr_switch_case6=1;
switch(__fr_switch_case6) {
case 0:
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffFirerateUp"), 450);
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_add", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffSpeedUp"), 450);
hp -= 3;
;
break;
;
case 1:
if (scrFRScriptExists("race", race, "race_fr_thunderstruck")) {
{
scrFRModCall("race", race, "race_fr_thunderstruck");
}
} else {
{
var __fr_other7=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other7.damage, (__fr_other7.knockback_speed / timescale));
lasthit = [sprLightningHit, "LIGHTNING STRIKE"];
}
}
}
}
}
} else {
{
var __fr_other8=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other8.damage, (__fr_other8.knockback_speed / timescale));
lasthit = [sprLightningHit, "LIGHTNING STRIKE"];
}
}
}
}
if(__fr_break4) break;
}}
}
}
}

// Original Frontier_Events.mod.gml:3778
function fr_Frontier_Events_mod_gml_lightning_refresh() {
ypoints = [];
xpoints = [];
var _frl_mmax = 100;
;
var _frl_mmin = (- 100);
;
var _frl_xx = x;
;
var _frl_yy = y;
;
var _frl_ang = scrFRSourceRandomRange(70, 110);
var _frl_width = 0.8;
var _frl_length = 10;
var _frl_bwidth = 0.8;
var _frl_n = 0;
vertex_begin(vbuf, global.fr_module_vars[$ "mod:Frontier_Events"].lightningformat);
vertex_position(vbuf, _frl_xx, _frl_yy);
while ((_frl_yy > (y - (2 * view_height)))) {
vertex_position(vbuf, (_frl_xx + (_frl_width * ((_frl_n mod 2) ? (- 1) : 1))), _frl_yy);
_frl_n++;
_frl_xx += lengthdir_x(_frl_length, _frl_ang);
_frl_yy += lengthdir_y(_frl_length, _frl_ang);
_frl_length = scrFRSourceRandom(6);
_frl_width = (((y - _frl_yy) / 75) + _frl_bwidth);
_frl_ang = clamp((_frl_ang + (((scrFRSourceRandomRange(7, 30) * scrFRSourceChoose((- 1), 1)) * min((y - _frl_yy), 20)) / 20)), 40, 140);
if (((_frl_ang == 40) or (_frl_ang == 140))) {
_frl_ang -= (scrFRSourceRandomRange(5, 20) * sign((_frl_ang - 90)));
}
if ((! scrFRSourceIRandom(5))) {
{
array_push(xpoints, _frl_xx);
array_push(ypoints, _frl_yy);
}
}
}
vertex_end(vbuf);
vertex_freeze(vbuf);
}

// Original Frontier_Events.mod.gml:3809
function fr_Frontier_Events_mod_gml_slope(_frl_x1=undefined, _frl_x2=undefined, _frl_y1=undefined, _frl_y2=undefined) {
return ((_frl_y2 - _frl_y1) / (_frl_x2 - _frl_x1));
}

// Original Frontier_Events.mod.gml:3812
function fr_Frontier_Events_mod_gml_lightning_destroy() {
if ((global.fr_module_vars[$ "mod:Frontier_Events"].settingLightningFlash == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Frontier_Events_mod_gml_lightning_flash, (- 30))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fadeoutmax = room_speed;
fadeout = fadeoutmax;
psuedowait = 2;
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRInstanceCreate(x, y, MeltSplat);
{
var _frl_i = 1;
for (; (_frl_i < array_length_1d(ypoints)); _frl_i++) {
if ((! scrFRSourceIRandom(4))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(scrFRIndexGet(xpoints, _frl_i), scrFRIndexGet(ypoints, _frl_i), FireFly)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
depth = __fr_other7.depth;
;
image_speed /= 1.5;
;
sprite_index = scrFRAreaSourceSprite(sprLightning);
;
hspeed += (scrFRSourceRandomRange((- 0.5), 0.5)) * timescale;
;
vspeed += (scrFRSourceRandomRange((- 0.5), 0.5)) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
}
}
vertex_delete_buffer(vbuf);
}

// Original Frontier_Events.mod.gml:3834
function fr_Frontier_Events_mod_gml_lightning_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_lightning_step_resume, id, scrFROther(other), _args, 18, []);
}
function fr_Frontier_Events_mod_gml_lightning_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_lightning_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:3874
{
time -= scrFRSourceScale();
if ((time <= 0)) {
scrFRInstanceDestroy();
}
}
_fr.pc=0;
break;
case 2: // Frontier_Events.mod.gml:3872
{
wantdust = 0;
}
_fr.pc=1;
break;
case 3: // Frontier_Events.mod.gml:3850
scrFRTaskWithNext(_fr);
break;
case 4: // Frontier_Events.mod.gml:3850
scrFRTaskWithAbort(_fr);
break;
case 5: // Frontier_Events.mod.gml:3867
_fr.result=undefined; _fr.done=true; return;
break;
case 6: // Frontier_Events.mod.gml:3866
{
if (scrFRInstanceExists(scrFRSelf(self))) {
scrFRInstanceDestroy();
}
}
_fr.pc=5;
break;
case 8: // Frontier_Events.mod.gml:3864
_fr.wait_ticks=max(0,0); _fr.pc=7; return;
break;
case 9: // Frontier_Events.mod.gml:3854
{
time += scrFRSourceScale();
image_alpha -= (scrFRSourceScale() / 45);
if (fr_Frontier_Events_mod_gml_PercentChance((45 - time))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRMotionAdd(90, scrFRSourceRandomRange(1, 2));
var __fr_other4=scrFROther(other);
image_xscale = ((1 - (__fr_other4.time / 45)) * scrFRSourceRandomRange(0.5, 1));
image_yscale = image_xscale;
gravity = ((- (friction / (timescale * timescale)))) * (timescale * timescale);
}
}
if(__fr_break3) break;
}}
}
}
}
_fr.pc=8;
break;
case 7: // Frontier_Events.mod.gml:3853
_fr.pc=((scrFRInstanceExists(scrFRSelf(_fr.scope)) && (time < 45)))?9:6;
break;
case 10: // Frontier_Events.mod.gml:3852
_fr.pc = (scrFRTaskFork(_fr, 7)) ? 7 : 3;
break;
case 11: // Frontier_Events.mod.gml:3851
{
time = 0;
;
}
_fr.pc=10;
break;
case 12: // Frontier_Events.mod.gml:3850
scrFRTaskWithEnter(_fr,scrFRWithValues(scrFRInstanceCreate(x, y, Scorchmark)),11,2);
break;
case 13: // Frontier_Events.mod.gml:3849
_fr.pc = (point_in_rectangle(x, y, (_fr.vars.closeboy.x - 16), (_fr.vars.closeboy.y - 16), (_fr.vars.closeboy.x + 16), (_fr.vars.closeboy.y + 16))) ? 12 : 2;
break;
case 14: // Frontier_Events.mod.gml:3848
{
_fr.vars.closeboy = instance_nearest(x, y, Floor);
;
}
_fr.pc=13;
break;
case 15: // Frontier_Events.mod.gml:3847
_fr.pc = (scrFRInstanceExists(Floor)) ? 14 : 2;
break;
case 16: // Frontier_Events.mod.gml:3837
{
repeat (12) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
scrFRMotionSet(scrFRSourceRandom(360), (3 + scrFRSourceRandom(5)));
}
}
if(__fr_break7) break;
}}
}
repeat (8) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 30), 30)), (y + scrFRSourceRandomRange((- 30), 30)), LightningSpawn)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
image_angle = (point_direction(__fr_other11.x, __fr_other11.y, x, y) + scrFRSourceRandomRange((- 8), 8));
}
}
if(__fr_break10) break;
}}
}
}
_fr.pc=15;
break;
case 17: // Frontier_Events.mod.gml:3836
_fr.pc = ((wantdust != 0)) ? 16 : 1;
break;
case 18: // Frontier_Events.mod.gml:3835
{
scrFRViewShakeMaxAt(x, y, 30);
}
_fr.pc=17;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:3878
function fr_Frontier_Events_mod_gml_lightning_flash() {
psuedowait -= scrFRSourceScale();
if ((psuedowait <= 0)) {
{
gpu_set_blendmode(bm_add);
scrFRDrawSpriteExt(sprSuperFlakBullet, 1, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)), 100, 100, scrFRSourceRandom(360), c_white, ((fadeout / fadeoutmax) * 0.45));
gpu_set_blendmode(bm_normal);
fadeout -= 4;
if ((! fadeout)) {
scrFRInstanceDestroy();
}
}
}
}

// Original Frontier_Events.mod.gml:3893
function fr_Frontier_Events_mod_gml_PickupStar_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Frontier_Events_mod_gml_FallenStar_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__pickup = scrFRSourceChoose("ammo", "health", "rads");
{ var __fr_switch_value4=_frl__pickup, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("ammo")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("health")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("rads")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
starColor = $14cbf9;
;
trailColor = starColor;
;
image_blend = starColor;
;
dropItem = AmmoPickup;
;
break;
;
case 1:
starColor = $7e74ff;
;
trailColor = starColor;
;
image_blend = starColor;
;
dropItem = HPPickup;
;
break;
;
case 2:
starColor = $55ff47;
;
trailColor = starColor;
;
image_blend = starColor;
;
dropItem = BigRad;
;
break;
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

// Original Frontier_Events.mod.gml:3920
function fr_Frontier_Events_mod_gml_FallenStar_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((_frl__x + scrFRSourceRandomRange((- 380), 380)), (_frl__y - 1000), FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_fallenstar";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorGlow);
;
depth = (- 13);
;
starColor = scrFRSourceChoose($ffcf2d, $fff171, $e1ff71, $fff9bf);
;
trailColor = starColor;
;
image_blend = starColor;
;
image_xscale = 0.6;
trailDis = (- 4);
;
rotSpeed = ((20 + scrFRSourceRandom(15)) * scrFRSourceChoose(1, (- 1)));
;
image_speed = (0.4) * timescale;
;
if ((scrFRSourceRandom(3) < 1)) {
{
image_xscale = 1;
;
trailDis = (- 8);
;
}
}
image_yscale = image_xscale;
;
speed = ((10 + scrFRSourceRandom(4))) * timescale;
;
dropItem = undefined;
;
landingZone = {"x": _frl__x, "y": _frl__y};
;
direction = point_direction(x, y, landingZone.x, landingZone.y);
on_step = fr_Frontier_Events_mod_gml_FallenStar_step;
;
on_end_step = fr_Frontier_Events_mod_gml_FallenStar_endstep;
;
on_destroy = fr_Frontier_Events_mod_gml_FallenStar_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:3959
function fr_Frontier_Events_mod_gml_FallenStar_step() {
if (frMacro_Frontier_Events_mod_gml_current_frame_active) {
{
image_angle += rotSpeed;
;
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorSparkle);
;
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.starColor;
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + 180) + scrFRSourceRandomRange((- 35), 35));
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
var __fr_other6=scrFROther(other);
depth = (__fr_other6.depth - 1);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((y > landingZone.y)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Frontier_Events.mod.gml:3979
function fr_Frontier_Events_mod_gml_FallenStar_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Events_mod_gml_FallenStar_endstep_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Frontier_Events_mod_gml_FallenStar_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Events_mod_gml_FallenStar_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Events.mod.gml:3984
scrFRTaskWithNext(_fr);
break;
case 2: // Frontier_Events.mod.gml:3984
scrFRTaskWithAbort(_fr);
break;
case 3: // Frontier_Events.mod.gml:3997
_fr.result=undefined; _fr.done=true; return;
break;
case 5: // Frontier_Events.mod.gml:3995
_fr.wait_ticks=max(0,0); _fr.pc=4; return;
break;
case 6: // Frontier_Events.mod.gml:3994
{
image_alpha -= 0.09;
;
}
_fr.pc=5;
break;
case 4: // Frontier_Events.mod.gml:3993
_fr.pc=(scrFRInstanceExists(scrFRSelf(_fr.scope)))?6:3;
break;
case 7: // Frontier_Events.mod.gml:3992
_fr.pc = (scrFRTaskFork(_fr, 4)) ? 4 : 1;
break;
case 8: // Frontier_Events.mod.gml:3985
{
var __fr_other1=scrFROther(other);
depth = (__fr_other1.depth + 1);
;
image_xscale = point_distance(_fr.vars._x, _fr.vars._y, _fr.vars._xPrev, _fr.vars._yPrev);
var __fr_other2=scrFROther(other);
image_yscale *= (__fr_other2.image_xscale * 9);
;
image_speed *= 3;
;
image_angle = point_direction(_fr.vars._x, _fr.vars._y, _fr.vars._xPrev, _fr.vars._yPrev);
var __fr_other3=scrFROther(other);
image_blend = __fr_other3.trailColor;
;
image_alpha = 1;
}
_fr.pc=7;
break;
case 9: // Frontier_Events.mod.gml:3984
scrFRTaskWithEnter(_fr,scrFRWithValues(fr_Frontier_Events_mod_gml_GenericTrail_create(_fr.vars._x, _fr.vars._y)),8,0);
break;
case 10: // Frontier_Events.mod.gml:3980
{
_fr.vars._x = (x + lengthdir_x(trailDis, direction));
_fr.vars._y = (y + lengthdir_y(trailDis, direction));
_fr.vars._xPrev = (xprevious + lengthdir_x(trailDis, direction));
_fr.vars._yPrev = (yprevious + lengthdir_y(trailDis, direction));
;
}
_fr.pc=9;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Events.mod.gml:4001
function fr_Frontier_Events_mod_gml_FallenStar_destroy() {
if ((dropItem != undefined)) {
{
scrFRInstanceCreate(x, y, dropItem);
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorHit);
;
var __fr_other4=scrFROther(other);
image_blend = __fr_other4.starColor;
;
}
}
if(__fr_break3) break;
}}
repeat (7) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorSparkle);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.starColor;
;
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
image_angle = scrFRSourceRandom(360);
;
}
}
if(__fr_break7) break;
}}
}
scrFRSoundHit(sndHitWall, 0.2);
;
}

// Original Frontier_Events.mod.gml:4024
function fr_Frontier_Events_mod_gml_SolarFlareSpawn_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSolarFlareWarning);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
fr_bloom = [1.2, 0.2];
;
if ((scrFRSourceRandom(1) < 1)) {
{
var _frl_big = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprSolarFlareWarningBig);
;
}
} else {
{
var _frl_big = false;
;
}
}
flare = fr_Frontier_Events_mod_gml_SolarFlare_create(_frl__x, _frl__y, _frl_big);
;
on_step = fr_Frontier_Events_mod_gml_SolarFlareSpawn_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:4048
function fr_Frontier_Events_mod_gml_SolarFlareSpawn_step() {
image_angle += (4 * scrFRSourceScale());
;
if ((! scrFRInstanceExists(flare))) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Frontier_Events.mod.gml:4055
function fr_Frontier_Events_mod_gml_SolarFlare_create(_frl__x=undefined, _frl__y=undefined, _frl__big=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((_frl__x + scrFRSourceRandomRange((- 380), 380)), (_frl__y - 1000), FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_solarflare";
sprite_index = scrFRAreaSourceSprite((_frl__big ? sprPlasmaBallHuge : sprHeavyBullet));
;
image_angle = direction;
;
image_index = 0;
;
image_speed = (0) * timescale;
;
depth = (- 9);
;
fr_bloom = [1.2, 0.2];
;
target = {"x": _frl__x, "y": _frl__y};
direction = point_direction(x, y, target.x, target.y);
speed = (scrFRSourceRandomRange(16, 20)) * timescale;
;
bigFlare = _frl__big;
on_step = fr_Frontier_Events_mod_gml_SolarFlare_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Events.mod.gml:4080
function fr_Frontier_Events_mod_gml_SolarFlare_step() {
if (frMacro_Frontier_Events_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = __fr_other4.depth;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorSparkle);
;
image_xscale = scrFRSourceRandomRange(0.5, 1);
;
image_yscale = image_xscale;
;
speed = (5) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
var __fr_other5=scrFROther(other);
direction = (__fr_other5.direction + 180);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((y > target.y)) {
{
y = target.y;
;
}
}
if ((y >= target.y)) {
{
repeat (scrFRSourceRandomRange(5, 9)) {
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), BulletHit)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
var __fr_other9=scrFROther(other);
depth = __fr_other9.depth;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprMeteorSparkle);
;
image_xscale = scrFRSourceRandomRange(0.5, 1);
;
image_yscale = image_xscale;
;
speed = (scrFRSourceRandom(6)) * timescale;
;
friction = (0.4) * (timescale * timescale);
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break8) break;
}}
}
if ((bigFlare == true)) {
{
scrFRInstanceCreate(x, y, Explosion);
}
} else {
{
scrFRInstanceCreate(x, y, SmallExplosion);
}
}
scrFRSoundPitchVolume(sndHitWall, scrFRSourceRandomRange(0.5, 0.9), 0.5);
;
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Frontier_Events.mod.gml:4122
function fr_Frontier_Events_mod_gml_PercentChance(_frl_percentage=undefined) {
return (scrFRSourceRandom(100) <= (_frl_percentage * scrFRSourceScale()));
}

// Original Frontier_Events.mod.gml:4125
function fr_Frontier_Events_mod_gml_nothing() {

}

// Original Frontier_Events.mod.gml:4128
function fr_Frontier_Events_mod_gml_every(_frl__num=undefined) {
return (frac((scrFRSourceFrame() / _frl__num)) < (scrFRSourceScale() / _frl__num));
}

// Original Frontier_Events.mod.gml:4131
function fr_Frontier_Events_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Events"].sprGenericTrail);
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
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
; // macro hoisted: _tespr
;
; // macro hoisted: _temus
;
; // macro hoisted: _vagabondsspr
;
; // macro hoisted: area_current
; // macro hoisted: FloorNormal
; // macro hoisted: bbox_center_x
; // macro hoisted: bbox_center_y
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
