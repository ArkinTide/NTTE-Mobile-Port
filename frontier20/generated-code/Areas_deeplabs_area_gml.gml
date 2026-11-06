#macro frMacro_Areas_deeplabs_area_gml_scr global.fr_module_vars[$ "area:deeplabs"].scr

#macro frMacro_Areas_deeplabs_area_gml_call scrFRScriptCall

#macro frMacro_Areas_deeplabs_area_gml_deeplabsDebug false

#macro frMacro_Areas_deeplabs_area_gml_autoBomb true

#macro frMacro_Areas_deeplabs_area_gml_reposition true

#macro frMacro_Areas_deeplabs_area_gml_roomX global.fr_module_vars[$ "area:deeplabs"].roomStartX

#macro frMacro_Areas_deeplabs_area_gml_roomY global.fr_module_vars[$ "area:deeplabs"].roomStartY

#macro frMacro_Areas_deeplabs_area_gml_roomDir global.fr_module_vars[$ "area:deeplabs"].roomDirect

#macro frMacro_Areas_deeplabs_area_gml_roomDirEnd global.fr_module_vars[$ "area:deeplabs"].roomDirectEnd

#macro frMacro_Areas_deeplabs_area_gml_normalRotSpeed scrFRSourceRandomRange(0.7, 1.5)

#macro frMacro_Areas_deeplabs_area_gml_normalBobSpeed (scrFRSourceRandomRange(0.04, 0.06) * scrFRSourceChoose((- 1), 1))

#macro frMacro_Areas_deeplabs_area_gml__tespr scrFRModGet("mod", "teassets", "spr")

#macro frMacro_Areas_deeplabs_area_gml_WepMimicID 553

#macro frMacro_Areas_deeplabs_area_gml_WepMimicIdle 2087

#macro frMacro_Areas_deeplabs_area_gml_normalRotRange [0.7, 1.5]

#macro frMacro_Areas_deeplabs_area_gml_normalBobRange [0.04, 0.06]

#macro frMacro_Areas_deeplabs_area_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Areas_deeplabs_area_gml_anim_end scrFRAnimationEnd()

// Original Areas/deeplabs.area.gml:1
function fr_Areas_deeplabs_area_gml___load() {

}

// Original Areas/deeplabs.area.gml:1
function fr_Areas_deeplabs_area_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_deeplabs_area_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Areas_deeplabs_area_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_deeplabs_area_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/deeplabs.area.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "area", "deeplabs", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "area:deeplabs"].settingDarkCoreExplosion = false;
;
global.fr_module_vars[$ "area:deeplabs"].settingLabsRouteAltMode = false;
;
global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred = (1 > 0);
;
global.fr_module_vars[$ "area:deeplabs"].settingEnemyRandomizer = false;
global.fr_module_vars[$ "area:deeplabs"].enemyRandomizerSpawnpool = [];
; // macro hoisted: deeplabsDebug
;
; // macro hoisted: autoBomb
;
; // macro hoisted: reposition
;
global.fr_module_vars[$ "area:deeplabs"].deeplabsSpecial = false;
;
global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret = (- 4);
;
global.fr_module_vars[$ "area:deeplabs"].safeZone = noone;
;
global.fr_module_vars[$ "area:deeplabs"].areaBackgroundPos = 0;
;
global.fr_module_vars[$ "area:deeplabs"].bombTimer = 120;
;
global.fr_module_vars[$ "area:deeplabs"].subjectNodeNum = 0;
;
global.fr_module_vars[$ "area:deeplabs"].panelSound = noone;
;
fr_Areas_deeplabs_area_gml_deeplabsRoom_init();
;
global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic = noone;
;
global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume = 0;
;
global.fr_module_vars[$ "area:deeplabs"].esploded = false;
;
global.fr_module_vars[$ "area:deeplabs"].musDeeplabs = sndFR_musDeeplabs_41c0a4c9c814;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsOutro = sndFR_sndDeeplabsOutro_3c3d6a7f2438;
;
global.fr_module_vars[$ "area:deeplabs"].musDeeplabsAftermath = sndFR_musDeeplabsAftermath_718a80872eea;
;
global.fr_module_vars[$ "area:deeplabs"].ambDeeplabs = sndFR_ambDeeplabs_0b618c29e379;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsTremor = [sndFR_sndDeeplabsTremor_f13c00d4c980, sndFR_sndDeeplabsTremor2_857d2cc35a51, sndFR_sndDeeplabsTremor3_9a50fae4cee0, sndFR_sndDeeplabsTremor4_40899576c78b, sndFR_sndDeeplabsTremor5_105b32157ec4, sndFR_sndDeeplabsTremor6_c7789d82328b, sndFR_sndDeeplabsTremor7_1ccc70d86efb];
global.fr_module_vars[$ "area:deeplabs"].sndBlank = sndFR_sndBlank_7a95d727acba;
;
global.fr_module_vars[$ "area:deeplabs"].sndBlank2 = sndFR_sndBlank_7a95d727acba;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsSpill = sndFR_sndDeeplabsSpill_ad63e08e2a35;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreIdle = [sndFR_sndDeeplabsCoreIdle_747be2063f83, sndFR_sndDeeplabsCoreIdle2_87a7dddc7619, sndFR_sndDeeplabsCoreIdle3_20368b3009a1, sndFR_sndDeeplabsCoreIdle4_6a5c6a03d557, sndFR_sndDeeplabsCoreIdle5_a5dacdb07e03];
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreExplosion = sndFR_sndDeeplabsCoreExplosion_56412b874c87;
;
global.fr_module_vars[$ "area:deeplabs"].sndPuzzleCompleted = sndFR_sndPuzzleCompleted_0c3467a369a9;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsPodFly = sndFR_sndDeeplabsPodFly_fb7a4c7892d6;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreControls = sndFR_sndAlienware_5fecffabce5f;
;
global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreControlsDanger = sndFR_sndAlienwareMeltdown_2a8f50d888bf;
;
global.fr_module_vars[$ "area:deeplabs"].sprAreaIcon = sprFR_sprLabsRouteIcon_654cbb1bced6;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloor = sprFR_sprFloorDeeplabs_0e39be3ae465;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorB = sprFR_sprFloorDeeplabs_0e39be3ae465;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorExplo = sprFR_sprFloorDeeplabsExplo_2fe1e6b8a669;
;
global.fr_module_vars[$ "area:deeplabs"].sprWallBot = sprFR_sprWallDeeplabsBot_2a70b3959ee9;
;
global.fr_module_vars[$ "area:deeplabs"].sprWallTop = sprFR_sprWallDeeplabsTop_08f04981424b;
;
global.fr_module_vars[$ "area:deeplabs"].sprWallOut = sprFR_sprWallDeeplabsOut_5e31c67af742;
;
global.fr_module_vars[$ "area:deeplabs"].sprWallTrans = sprFR_sprWallDeeplabsTrans_0ea3174d649b;
;
global.fr_module_vars[$ "area:deeplabs"].sprDebris = sprFR_sprDebrisDeeplabs_1741c56c3074;
;
global.fr_module_vars[$ "area:deeplabs"].sprDetail = sprFR_sprDetailDeeplabs_8efa60676f88;
;
global.fr_module_vars[$ "area:deeplabs"].sprFogDeeplabs = sprFR_sprFogDeeplabs_bfd74b2dbac5;
;
global.fr_module_vars[$ "area:deeplabs"].sprFogDeeplabs2 = sprFR_sprFogDeeplabs2_a17e3799f598;
;
global.fr_module_vars[$ "area:deeplabs"].sprTerminalOff = sprFR_sprTerminalOff_c5be73529540;
;
global.fr_module_vars[$ "area:deeplabs"].sprTerminalOffHurt = sprFR_sprTerminalOffHurt_93f9f365843f;
;
global.fr_module_vars[$ "area:deeplabs"].sprBigTube = sprFR_sprBigTube_396473fe547b;
;
global.fr_module_vars[$ "area:deeplabs"].sprBigTubeBack = sprFR_sprBigTubeBack_39d8f66c3db8;
;
global.fr_module_vars[$ "area:deeplabs"].mskBigTube = sprFR_mskBigTube_8d48b0438488;
;
global.fr_module_vars[$ "area:deeplabs"].sprBigTubeHurt = sprFR_sprBigTubeHurt_0a8579bf37e1;
;
global.fr_module_vars[$ "area:deeplabs"].sprBigTubeDead = sprFR_sprBigTubeDead_44e7e4fdb226;
;
global.fr_module_vars[$ "area:deeplabs"].sprTubeStreak = sprFR_sprTubeStreak_aeb983f54f94;
;
global.fr_module_vars[$ "area:deeplabs"].sprTubeDebris = sprFR_sprDebrisTube_27c026d14447;
;
global.fr_module_vars[$ "area:deeplabs"].sprTubeDebrisBig = sprFR_sprDebrisTubeBig_f4a22c66d7f5;
;
global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTube = sprFR_sprProtoStatueTube_b02b5893bf90;
;
global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeHurt = sprFR_sprProtoStatueTubeHurt_732106a4ac10;
;
global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeDead = sprFR_sprProtoStatueTubeDead_269f7ca1cc35;
;
global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeDeadFront = sprFR_sprProtoStatueTubeDeadFr_ae9ba1535605;
;
global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeBack = sprFR_sprProtoStatueTubeBack_2d8ba774232d;
;
global.fr_module_vars[$ "area:deeplabs"].mskHugeTube = sprFR_mskHugeTube_9665c4676bd9;
;
global.fr_module_vars[$ "area:deeplabs"].sprHugeTube = sprFR_sprHugeTube_f9d5bc46ff8c;
;
global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeBack = sprFR_sprHugeTubeBack_a2cff9d454ca;
;
global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeHurt = sprFR_sprHugeTubeHurt_68b280b2a0ea;
;
global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeDead = sprFR_sprHugeTubeDead_8a6af3b8beac;
;
global.fr_module_vars[$ "area:deeplabs"].shdHugeTube = sprFR_shdHugeTube_0424ee8c815f;
;
global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTube = sprFR_sprVoltergeistTube_b78512fccb08;
;
global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTubeHurt = sprFR_sprVoltergeistTubeHurt_3005c0534e33;
;
global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTubeDead = sprFR_sprVoltergeistTubeDead_45ce1603b9c5;
;
global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects = sprFR_sprBigTubeObjects_355da93fcd4e;
;
global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeObjects = sprFR_sprHugeTubeObjects_8bd0b24cecec;
;
global.fr_module_vars[$ "area:deeplabs"].sprGenerator = sprFR_sprGenerator_4c43f1666787;
;
global.fr_module_vars[$ "area:deeplabs"].sprGeneratorHurt = sprFR_sprGeneratorHurt_21a6f3f31efb;
;
global.fr_module_vars[$ "area:deeplabs"].sprGeneratorDead = sprFR_sprGeneratorDead_53782e8667a3;
;
global.fr_module_vars[$ "area:deeplabs"].sprGeneratorActive = sprFR_sprGeneratorActive_9d55bdcee50c;
;
global.fr_module_vars[$ "area:deeplabs"].sprBombTimer = sprFR_sprBombTimer_ca19b21d7670;
;
global.fr_module_vars[$ "area:deeplabs"].sprBombTimerBack = sprFR_sprBombTimerBack_d91e68419df4;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk = sprFR_sprFloorCatwalk_3785ba5797ee;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical = sprFR_sprFloorCatwalkVertical_089ddc83505b;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkDownRight = sprFR_sprFloorCatwalkDownRight_5bcdffca3d96;
;
global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkDestroyed = sprFR_sprFloorCatwalkDestroyed_2992fa790f1d;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrier = sprFR_sprBarrier_cbfc1275fe8b;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierOff = sprFR_sprBarrierOff_f0ecd7949359;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierZapper = sprFR_sprBarrierZapper_d4940640ee41;
;
global.fr_module_vars[$ "area:deeplabs"].mskBarrierZapper = sprFR_mskBarrierZapper_b13bb1e84a8e;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierVertical = sprFR_sprBarrierVertical_506587db40b3;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalOff = sprFR_sprBarrierVerticalOff_2fff760b51f3;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalBack = sprFR_sprBarrierVerticalBack_cdc39492e909;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalBackOff = sprFR_sprBarrierVerticalBackOf_9b477b84e9a1;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierZapperVertical = sprFR_sprBarrierZapperVertical_75a7e4f2ac8d;
;
global.fr_module_vars[$ "area:deeplabs"].mskBarrierZapperVertical = sprFR_mskBarrierZapperVertical_2c2b18435aa0;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierGameover = sprFR_sprBarrierGameover_41098912a5c9;
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierFizzle = [sprFR_sprBarrierFizzle_59d97319db3c, sprFR_sprBarrierFizzle2_4814e163396b, sprFR_sprBarrierFizzle3_6d68cc0498e4, sprFR_sprBarrierFizzle4_a84f317f3cdf];
;
global.fr_module_vars[$ "area:deeplabs"].sprBarrierIcon = sprFR_sprBarrierIcon_5b70b2cc0247;
;
global.fr_module_vars[$ "area:deeplabs"].mskRoomHitbox = sprFR_mskRoomHitbox_3c8e366d5181;
;
global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorIdle = sprFR_sprEnemyElevatorIdle_07cb6080c2ec;
;
global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorActive = sprFR_sprEnemyElevatorActive_d9d735abbea3;
;
global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorDone = sprFR_sprEnemyElevatorDone_65e7bfe6c0b1;
;
global.fr_module_vars[$ "area:deeplabs"].sprColorBulb = sprFR_sprColorBulb_fb621e5d52fc;
;
global.fr_module_vars[$ "area:deeplabs"].sprColorBulbOverlay = sprFR_sprColorBulbOverlay_c0c49073ba13;
;
global.fr_module_vars[$ "area:deeplabs"].mskPressureButton = sprFR_mskColorButton_6c06d62e78a1;
;
global.fr_module_vars[$ "area:deeplabs"].sprPressureButton = sprFR_sprColorButton_6758060763f4;
;
global.fr_module_vars[$ "area:deeplabs"].sprPressureButtonOverlay = sprFR_sprColorButtonOverlay_6eb44a36993e;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretBase = sprFR_sprSpinTurretBase_3c3f846f2315;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTop = sprFR_sprSpinTurretTop_946cbd5b7cf6;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopOff = sprFR_sprSpinTurretTopOff_eaf8a0d5e5ae;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGun = sprFR_sprSpinTurretGun_77634fae7563;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretDead = sprFR_sprSpinTurretDead_a1b4a8f4b399;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGameover = sprFR_sprSpinTurretGameover_b3faba36a3aa;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopPossessed = sprFR_sprSpinTurretTopPossesse_23af3119d4eb;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopOffPossessed = sprFR_sprSpinTurretTopOffPosse_6b8cf245974a;
;
global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGameoverPossessed = sprFR_sprSpinTurretGameoverPos_e776dc771a07;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTurret = sprFR_sprLaserTurret_9c8f18c73c28;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretGameover = sprFR_sprLaserTurretGameover_bd8632aefea3;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretSource = sprFR_sprLaserTurretSource_d16db1212672;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretSourceTop = sprFR_sprLaserTurretSourceTop_f7a65787a2c2;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeam = sprFR_sprLaserTrapBeam_7e0265d2a83e;
;
global.fr_module_vars[$ "area:deeplabs"].mskLaserTrapBeam = sprFR_mskLaserTrapBeam_f1734486c953;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeamEnd = sprFR_sprLaserTrapBeamEnd_fe4f63251cab;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeamStart = sprFR_sprLaserTrapBeamStart_61f54fe29304;
;
global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapHead = sprFR_sprLaserTrapHead_33067a73fd0d;
global.fr_module_vars[$ "area:deeplabs"].sprBotLayer3x5 = sprFR_sprBotLayer3x5_2e8e681b7c85;
;
global.fr_module_vars[$ "area:deeplabs"].sprColorPuzzleBack = sprFR_sprColorPuzzleBack_e5ef3f528188;
;
global.fr_module_vars[$ "area:deeplabs"].sprColorPuzzleFront = sprFR_sprColorPuzzleFront_2b3062a2d9ce;
;
global.fr_module_vars[$ "area:deeplabs"].sprLUpRoomMain = sprFR_sprLUpRoomMain_a268931c726d;
;
global.fr_module_vars[$ "area:deeplabs"].sprLUpRoomFront = sprFR_sprLUpRoomFront_b52392905265;
;
global.fr_module_vars[$ "area:deeplabs"].sprFreakParkMain = sprFR_sprFreakParkMain_9e7c59df38b1;
;
global.fr_module_vars[$ "area:deeplabs"].sprFreakParkMainFront = sprFR_sprFreakParkMainFront_df3a418f8dff;
;
global.fr_module_vars[$ "area:deeplabs"].sprFreakParkFront = sprFR_sprFreakParkFront_58141c35e0eb;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x6RDMain = sprFR_spr6x6RDMain_f90da40cbf62;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x6RDMainFront = sprFR_spr6x6RDMainFront_bf10ad6c485c;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x6RDFront = sprFR_spr6x6RDFront_ab1a15f21392;
;
global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomMain = sprFR_sprLDownRoomMain_5212fc971d35;
;
global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomMainFront = sprFR_sprLDownRoomMainFront_f4ba11c0def1;
;
global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomFront = sprFR_sprLDownRoomFront_2cc5b4119a4a;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x6RRMain = sprFR_spr6x6RRMain_dfc158eaf310;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x6RRFront = sprFR_spr6x6RRFront_8de51fc24c63;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x10UUMain = sprFR_spr6x10UUMain_5a5880d4dd8c;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x10UUMainFront = sprFR_spr6x10UUMainFront_af4b11ec2800;
;
global.fr_module_vars[$ "area:deeplabs"].spr6x10UUFront = sprFR_spr6x10UUFront_224b46222f47;
;
global.fr_module_vars[$ "area:deeplabs"].spr9x9DRRoomMain = sprFR_spr9x9DRRoomMain_071540d30f50;
;
global.fr_module_vars[$ "area:deeplabs"].spr9x9DRRoomFront = sprFR_spr9x9DRRoomFront_d94432aa4d49;
;
global.fr_module_vars[$ "area:deeplabs"].spr9x5DRMain = sprFR_spr9x5DRMain_7475534d68ce;
;
global.fr_module_vars[$ "area:deeplabs"].spr9x5DRFront = sprFR_spr9x5DRFront_d4f152fa87cc;
;
global.fr_module_vars[$ "area:deeplabs"].sprFiringSquadMain = sprFR_sprFiringSquadMain_b37e05be15f7;
;
global.fr_module_vars[$ "area:deeplabs"].sprFiringSquadFront = sprFR_sprFiringSquadFront_06ed0e36173e;
;
global.fr_module_vars[$ "area:deeplabs"].spr5x8URMain = sprFR_spr5x8URMain_19b46e8f8534;
;
global.fr_module_vars[$ "area:deeplabs"].spr5x8URMainFront = sprFR_spr5x8URMainFront_707f8b8d4af2;
;
global.fr_module_vars[$ "area:deeplabs"].spr5x8URFront = sprFR_spr5x8URFront_4895d7da4f73;
;
global.fr_module_vars[$ "area:deeplabs"].sprChokepointMain = sprFR_sprChokepointMain_a90afdf0ff34;
;
global.fr_module_vars[$ "area:deeplabs"].sprChokepointFront = sprFR_sprChokepointFront_bd9632586e5b;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartRoomMain = sprFR_sprStartRoomMain_9c35eb13d55b;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartRoomFront = sprFR_sprStartRoomFront_d8a1dad21f65;
;
global.fr_module_vars[$ "area:deeplabs"].sprElevatorPlatformMain = sprFR_sprElevatorPlatformMain_92750b681c0b;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartTopRoomMain = sprFR_sprStartTopRoomMain_151085b0b3a4;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartTopRoomMainFront = sprFR_sprStartTopRoomMainFront_1824cb20f998;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartBotRoomMain = sprFR_sprStartBotRoomMain_49c7da56f943;
;
global.fr_module_vars[$ "area:deeplabs"].sprStartBotRoomFront = sprFR_sprStartBotRoomFront_30f514a5749b;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMain = sprFR_sprEndRoomMain_af3465f7fecc;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainFront = sprFR_sprEndRoomMainFront_e42810986e58;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomFront = sprFR_sprEndRoomFront_2f1714ad7128;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomRoof = sprFR_sprEndRoomRoof_b050c673c1b8;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomForcefield = sprFR_sprEndRoomForcefield_60b9da72f15e;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainCharred = sprFR_sprEndRoomMainCharred_a1a2c891a3d3;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainFrontCharred = sprFR_sprEndRoomMainFrontCharr_cc9279610d19;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomFrontCharred = sprFR_sprEndRoomFrontCharred_3d3ac51fa645;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomRoofCharred = sprFR_sprEndRoomRoofCharred_c5a77c171ffd;
;
global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerMain = sprFR_sprDoubleTowerMain_767cdd54f58a;
;
global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerFront = sprFR_sprDoubleTowerFront_119ee7b8488c;
;
global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerMainFront = sprFR_sprDoubleTowerMainFront_1e8f92a30dc5;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorDownMain = sprFR_sprEndRoomConnectorDownM_5fcb33cffd1d;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorDownFront = sprFR_sprEndRoomConnectorDownF_efb821aebced;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorRightMain = sprFR_sprEndRoomConnectorRight_d99e1975ddca;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorRightFront = sprFR_sprEndRoomConnectorRight_989b3e914c59;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreIdle = sprFR_sprCoreIdle_14ecc8d14d19;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreDanger = sprFR_sprCoreDanger_bebfec0d072e;
;
global.fr_module_vars[$ "area:deeplabs"].sprCorePupil = sprFR_sprCorePupil_14e0aff3743a;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCover = sprFR_sprCoreEyeCover_2fba1a1fb8bf;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCoverStrt = sprFR_sprCoreEyeCoverStrt_c90de17a69d2;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCoverEnd = sprFR_sprCoreEyeCoverEnd_89434b5b09d2;
;
global.fr_module_vars[$ "area:deeplabs"].mskCoreControls = sprFR_mskCoreControls_3eb83a3bb20e;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsIdle = sprFR_sprCoreControlsIdle_86fc7901e922;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsSpill = sprFR_sprCoreControlsSpill_15c2ee532045;
;
global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsDanger = sprFR_sprCoreControlsDanger_c1fbb8a59cd2;
;
global.fr_module_vars[$ "area:deeplabs"].sprDangerScreen = sprFR_sprDangerScreen_8b5d54f7cc69;
;
global.fr_module_vars[$ "area:deeplabs"].sprDangerScreenOff = sprFR_sprDangerScreenOff_1c7caa98dfd7;
;
global.fr_module_vars[$ "area:deeplabs"].bombText = "";
;
global.fr_module_vars[$ "area:deeplabs"].bombController = noone;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorIdle = sprFR_sprEndRoomElevatorIdle_af5a581df6f5;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorArrive = sprFR_sprEndRoomElevatorArrive_95505dcea125;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorOpen = sprFR_sprEndRoomElevatorOpen_162ba53711e6;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverOpen = sprFR_sprEndRoomElevatorCoverO_37cad34dbc4b;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorLeave = sprFR_sprEndRoomElevatorLeave_6c225955c52c;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverLeave = sprFR_sprEndRoomElevatorCoverL_cabafb4d309a;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverGone = sprFR_sprEndRoomElevatorCoverG_10ebf54375b2;
;
global.fr_module_vars[$ "area:deeplabs"].sprEndRoomPod = sprFR_sprEndRoomPod_19ffdfdb9545;
global.fr_module_vars[$ "area:deeplabs"].sprFallingDebris = sprFR_sprFallingDebris_aefea367bf93;
;
global.fr_module_vars[$ "area:deeplabs"].sprFallingDebrisBig = sprFR_sprFallingDebrisBig_8cf25709815a;
;
global.fr_module_vars[$ "area:deeplabs"].sprCharSmoke = sprFR_sprCharSmoke_c3a31f1889ec;
;
global.fr_module_vars[$ "area:deeplabs"].sprSolidColorFog = sprFR_sprSolidColorFog_9ebc4a1429e4;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "name", "Spin Turret")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
fr_Areas_deeplabs_area_gml_BigTubeObjects_init();
;
}
_fr.pc=0;
break;
case 3: // Areas/deeplabs.area.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Areas/deeplabs.area.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Areas/deeplabs.area.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/deeplabs.area.gml:293
function fr_Areas_deeplabs_area_gml_cleanup() {
if (surface_exists(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret)) {
{
surface_free(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret);
}
}
}

// Original Areas/deeplabs.area.gml:298
function fr_Areas_deeplabs_area_gml_area_subarea() {
return 1;
;
}

// Original Areas/deeplabs.area.gml:299
function fr_Areas_deeplabs_area_gml_area_goal() {
return 130;
;
}

// Original Areas/deeplabs.area.gml:300
function fr_Areas_deeplabs_area_gml_area_next() {
return (scrFRModLoaded("area", "scorpionboss") ? ["palace", 1] : [7, 1]);
;
}

// Original Areas/deeplabs.area.gml:301
function fr_Areas_deeplabs_area_gml_area_background_color() {
return make_color_rgb(20, 22, 23);
;
}

// Original Areas/deeplabs.area.gml:302
function fr_Areas_deeplabs_area_gml_area_shadow_color() {
return c_black;
;
}

// Original Areas/deeplabs.area.gml:303
function fr_Areas_deeplabs_area_gml_area_darkness() {
return true;
;
}

// Original Areas/deeplabs.area.gml:304
function fr_Areas_deeplabs_area_gml_area_fog() {
return global.fr_module_vars[$ "area:deeplabs"].sprFogDeeplabs;
;
}

// Original Areas/deeplabs.area.gml:305
function fr_Areas_deeplabs_area_gml_area_secret() {
return false;
;
}

// Original Areas/deeplabs.area.gml:306
function fr_Areas_deeplabs_area_gml_area_outside() {
return false;
;
}

// Original Areas/deeplabs.area.gml:308
function fr_Areas_deeplabs_area_gml_area_name() {
return scrFRLocalize(((global.fr_module_vars[$ "area:deeplabs"].settingLabsRouteAltMode == true) ? ("@1(" + string(real(global.fr_module_vars[$ "area:deeplabs"].sprAreaIcon)) + ":0)6-?") : (("@1(" + string(real(global.fr_module_vars[$ "area:deeplabs"].sprAreaIcon)) + ":0)3-") + string(GameCont.subarea))));
;
}

// Original Areas/deeplabs.area.gml:311
function fr_Areas_deeplabs_area_gml_area_text() {
return scrFRLocalize(scrFRSourceChoose("A CITY OF PROGRESS", "DONT SLIP OVER THE RAILING", "TOTALLY TUBULAR"));
;
}

// Original Areas/deeplabs.area.gml:319
function fr_Areas_deeplabs_area_gml_area_mapdata(_frl__lastX=undefined, _frl__lastY=undefined, _frl__lastArea=undefined, _frl__lastSubarea=undefined, _frl__subarea=undefined, _frl__loops=undefined) {
return [(108 + (9.5 * (_frl__subarea - 1))), (- 9), (_frl__subarea == 1)];
}

// Original Areas/deeplabs.area.gml:324
function fr_Areas_deeplabs_area_gml_area_areaicon() {
return [global.fr_module_vars[$ "area:deeplabs"].sprAreaIcon, ((global.fr_module_vars[$ "area:deeplabs"].settingLabsRouteAltMode == true) ? "6-?" : ("3-" + string(GameCont.subarea)))];
}

// Original Areas/deeplabs.area.gml:330
function fr_Areas_deeplabs_area_gml_area_sprite(_frl_q=undefined) {
{ var __fr_switch_value1=_frl_q, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1B)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprFloor1Explo)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Trans)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Bot)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Out)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprWall1Top)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprDebris1)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprDetail1)) __fr_switch_case2=8;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_deeplabs_area_gml_area_setup_floor();
;
__fr_break5=true; break;
;
}
}
}
if(__fr_break5) break;
}}
return global.fr_module_vars[$ "area:deeplabs"].sprFloor;
;
case 1:
{ var __fr_with6 = scrFRWithValues([scrFRSelf(self), (scrFROther(other))]), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
if (scrFRInstanceIs(scrFRSelf(self), Floor)) {
{
fr_Areas_deeplabs_area_gml_area_setup_floor();
;
__fr_break8=true; break;
;
}
}
}
if(__fr_break8) break;
}}
return global.fr_module_vars[$ "area:deeplabs"].sprFloorB;
;
case 2:
return global.fr_module_vars[$ "area:deeplabs"].sprFloorExplo;
;
case 3:
return global.fr_module_vars[$ "area:deeplabs"].sprWallTrans;
;
case 4:
return global.fr_module_vars[$ "area:deeplabs"].sprWallBot;
;
case 5:
return global.fr_module_vars[$ "area:deeplabs"].sprWallOut;
;
case 6:
return global.fr_module_vars[$ "area:deeplabs"].sprWallTop;
;
case 7:
return global.fr_module_vars[$ "area:deeplabs"].sprDebris;
;
case 8:
return global.fr_module_vars[$ "area:deeplabs"].sprDetail;
;
}
}
}

// Original Areas/deeplabs.area.gml:343
function fr_Areas_deeplabs_area_gml_area_setup() {
scrFRSoundMusic(global.fr_module_vars[$ "area:deeplabs"].sndBlank);
;
scrFRSoundAmbient(global.fr_module_vars[$ "area:deeplabs"].ambDeeplabs);
;
goal = fr_Areas_deeplabs_area_gml_area_goal();
;
background_set_colour(fr_Areas_deeplabs_area_gml_area_background_color());
;
BackCont.shadow_color = fr_Areas_deeplabs_area_gml_area_shadow_color();
;
TopCont.darkness = fr_Areas_deeplabs_area_gml_area_darkness();
;
TopCont.fog = fr_Areas_deeplabs_area_gml_area_fog();
;
safespawn = 0;
;
goal = 1;
;
scrFRSoundAssign(sndWallBreakRock, sndWallBreakLabs);
;
room_list = [];
;
frMacro_Areas_deeplabs_area_gml_roomX = 10000;
;
frMacro_Areas_deeplabs_area_gml_roomY = 10000;
;
scrFRBindDraw(fr_Areas_deeplabs_area_gml_deeplabsFog_draw, 30);
;
global.fr_module_vars[$ "area:deeplabs"].bombText = "";
;
global.fr_module_vars[$ "area:deeplabs"].subjectNodeNum = 0;
;
}

// Original Areas/deeplabs.area.gml:371
function fr_Areas_deeplabs_area_gml_area_setup_floor() {
material = 3;
;
}

// Original Areas/deeplabs.area.gml:374
function fr_Areas_deeplabs_area_gml_area_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Areas_deeplabs_area_gml_area_start_resume, id, scrFROther(other), _args, 6, []);
}
function fr_Areas_deeplabs_area_gml_area_start_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Areas_deeplabs_area_gml_area_start");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Areas/deeplabs.area.gml:511
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsRoomDecalCore")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Areas_deeplabs_area_gml_CoreEyeCover_create((x - 79), (y - 10), scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
if ((frMacro_Areas_deeplabs_area_gml_deeplabsDebug == true)) {
{
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((sprite_index == global.fr_module_vars[$ "area:deeplabs"].sprFloor)) {
{
sprite_index = scrFRAreaSourceSprite(scrFRModGet("area", "devzone", "sprFloor"));
}
}
}
}
if(__fr_break6) break;
}}
}
}
if ((scrFRInstanceExists(WantPopo) || scrFRInstanceExists(WantVan))) {
{
{ var __fr_with7 = scrFRWithValues(WantPopo), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(WantVan), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break12) break;
}}
}
}
if (((scrFRInstanceExists(VanSpawn) || scrFRInstanceExists(IDPDSpawn)) || (array_length(scrFRMatching(FRCustomObject, "name", "IDPDPortal")) > 0))) {
{
{ var __fr_with13 = scrFRWithValues(IDPDSpawn), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(VanSpawn), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break18) break;
}}
{ var __fr_with19 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "IDPDPortal")), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break21) break;
}}
scrFRSoundStop(sndIDPDPortalSpawn);
;
scrFRSoundStop(sndEliteIDPDPortalSpawn);
;
scrFRSoundStop(sndVanWarning);
;
}
}
{ var __fr_with22 = scrFRWithValues(Server), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 5;
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(Terminal), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
spr_shadow_y = 1;
;
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(Tube), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 7;
;
}
}
if(__fr_break30) break;
}}
{ var __fr_with31 = scrFRWithValues(MutantTube), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
spr_shadow = shd32;
;
spr_shadow_y = 7;
;
}
}
if(__fr_break33) break;
}}
fr_Areas_deeplabs_area_gml_EndRoomStupid_create();
;
if ((global.fr_module_vars[$ "area:deeplabs"].settingEnemyRandomizer == true)) {
{
{ var __fr_with34 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsEnemySpawnTube")), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
_fr.vars._newSpawn = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, global.fr_module_vars[$ "area:deeplabs"].enemyRandomizerSpawnpool);
;
_fr.vars._range = scrFRIndexGet(_fr.vars._newSpawn, 2);
;
enemyMod = scrFRIndexGet(_fr.vars._newSpawn, 0);
;
enemyScript = scrFRIndexGet(_fr.vars._newSpawn, 1);
;
enemyCount = scrFRSourceIRandomRange(scrFRIndexGet(_fr.vars._range, 0), scrFRIndexGet(_fr.vars._range, 1));
;
}
}
if(__fr_break36) break;
}}
}
}
}
_fr.pc=0;
break;
case 2: // Areas/deeplabs.area.gml:502
{
{
{ var __fr_with37 = scrFRWithValues(WepPickup), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
x = 9666;
;
y = 10132;
;
}
}
if(__fr_break39) break;
}}
}
}
_fr.pc=1;
break;
case 3: // Areas/deeplabs.area.gml:502
_fr.wait_ticks=max(0,2); _fr.pc=2; return;
break;
case 4: // Areas/deeplabs.area.gml:494
{
{ var __fr_with40 = scrFRWithValues(Player), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
x = 9666;
;
y = 10132;
;
}
}
if(__fr_break42) break;
}}
{ var __fr_with43 = scrFRWithValues(CrownObject), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
x = 9666;
;
y = 10132;
;
}
}
if(__fr_break45) break;
}}
}
_fr.pc=3;
break;
case 5: // Areas/deeplabs.area.gml:493
_fr.pc = ((frMacro_Areas_deeplabs_area_gml_reposition == true)) ? 4 : 1;
break;
case 6: // Areas/deeplabs.area.gml:436
{
{ var __fr_with46 = scrFRWithValues(RadChest), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break48) break;
}}
{ var __fr_with49 = scrFRWithValues(HealthChest), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
scrFRDelete(scrFRSelf(self));
}
}
if(__fr_break51) break;
}}
{ var __fr_with52 = scrFRWithValues(Detail), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break54) break;
}}
{ var __fr_with55 = scrFRWithValues(HostileHorror), __fr_break57=false;
for (var __fr_index56=0; __fr_index56<array_length(__fr_with55); ++__fr_index56) {
if(scrFRScopeExists(__fr_with55[__fr_index56])) with (__fr_with55[__fr_index56]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break57) break;
}}
{ var __fr_with58 = scrFRWithValues(RogueChest), __fr_break60=false;
for (var __fr_index59=0; __fr_index59<array_length(__fr_with58); ++__fr_index59) {
if(scrFRScopeExists(__fr_with58[__fr_index59])) with (__fr_with58[__fr_index59]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break60) break;
}}
{ var __fr_with61 = scrFRWithValues(Wall), __fr_break63=false;
for (var __fr_index62=0; __fr_index62<array_length(__fr_with61); ++__fr_index62) {
if(scrFRScopeExists(__fr_with61[__fr_index62])) with (__fr_with61[__fr_index62]) {
{
if ((distance_to_object(Player) < 64)) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break63) break;
}}
scrFRInstanceCreate(10000, 10000, Floor);
{ var __fr_with64 = scrFRWithValues(scrFRMatching(Wall, "area", "deeplabs")), __fr_break66=false;
for (var __fr_index65=0; __fr_index65<array_length(__fr_with64); ++__fr_index65) {
if(scrFRScopeExists(__fr_with64[__fr_index65])) with (__fr_with64[__fr_index65]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_deeplabsWall"))) {
{
scrFRInstanceCreate(x, y, InvisiWall);
;
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break66) break;
}}
{ var __fr_with67 = scrFRWithValues(TopSmall), __fr_break69=false;
for (var __fr_index68=0; __fr_index68<array_length(__fr_with67); ++__fr_index68) {
if(scrFRScopeExists(__fr_with67[__fr_index68])) with (__fr_with67[__fr_index68]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break69) break;
}}
background_set_colour(c_black);
;
fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_create(10016, 10016);
;
global.fr_module_vars[$ "area:deeplabs"].bombController = fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_create(10016, 10016);
;
TopCont.darkness = false;
;
scrFRBindDraw(fr_Areas_deeplabs_area_gml_BarrierEnemyIcon_draw, (- 3));
;
{ var __fr_with70 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsBecomeChest")), __fr_break72=false;
for (var __fr_index71=0; __fr_index71<array_length(__fr_with70); ++__fr_index71) {
if(scrFRScopeExists(__fr_with70[__fr_index71])) with (__fr_with70[__fr_index71]) {
{
scrFRInstanceCreate(x, y, myChest);
;
scrFRInstanceDestroy();
;
}
}
if(__fr_break72) break;
}}
{ var __fr_with73 = scrFRWithValues(AmmoChestMystery), __fr_break75=false;
for (var __fr_index74=0; __fr_index74<array_length(__fr_with73); ++__fr_index74) {
if(scrFRScopeExists(__fr_with73[__fr_index74])) with (__fr_with73[__fr_index74]) {
{
scrFRInstanceCreate(x, y, AmmoChest);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break75) break;
}}
scrFRInstanceCreate(10016, 10016, becomenemy);
;
}
_fr.pc=5;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Areas/deeplabs.area.gml:587
function fr_Areas_deeplabs_area_gml_area_make_floor() {
var _frl__x = (10016 - 16);
var _frl__y = (10016 - 16);
;
if ((frMacro_Areas_deeplabs_area_gml_deeplabsDebug == true)) {
{
scrFRTraceColor("|", c_yellow);
;
scrFRTraceColor("START GENERATION!", c_yellow);
;
scrFRTraceColor("|", c_yellow);
;
}
}
fr_Areas_deeplabs_area_gml_scrFloorFill(_frl__x, _frl__y, 8, 9);
fr_Areas_deeplabs_area_gml_scrFloorFill(_frl__x, (_frl__y + 160), 6, 1);
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((_frl__x + 224), (_frl__y - 96), 6, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((_frl__x + 352), (_frl__y - 96), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((_frl__x - 224), (_frl__y + 96), 6, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
fr_Areas_deeplabs_area_gml_scrFloorFill((_frl__x - 352), (_frl__y + 96), 3, 3);
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((_frl__x - 400), (_frl__y + 29), global.fr_module_vars[$ "area:deeplabs"].sprElevatorPlatformMain);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((_frl__x - 256), (_frl__y - 64), 4, 3);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((_frl__x - 300), (_frl__y - 103), global.fr_module_vars[$ "area:deeplabs"].sprStartTopRoomMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((_frl__x - 345), (_frl__y - 103), global.fr_module_vars[$ "area:deeplabs"].sprStartTopRoomMainFront);
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((_frl__x - 263), (_frl__y - 32), "Loot");
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((_frl__x - 223), (_frl__y - 32), (- 1));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((_frl__x - 183), (_frl__y - 32), (- 1));
;
scrFRInstanceCreate((_frl__x - 183), (_frl__y - 93), Terminal);
;
scrFRInstanceCreate((_frl__x - 203), (_frl__y - 93), Server);
;
scrFRInstanceCreate((_frl__x - 227), (_frl__y - 93), Server);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((_frl__x - 256), (_frl__y + 256), 6, 4);
(fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((_frl__x - 377), (_frl__y + 219), global.fr_module_vars[$ "area:deeplabs"].sprStartBotRoomMain)).depth -= 1;
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((_frl__x - 329), (_frl__y + 347), global.fr_module_vars[$ "area:deeplabs"].sprStartBotRoomFront);
;
var _frl__serverX = 0;
;
repeat (5) {
scrFRInstanceCreate(((_frl__x - 308) + _frl__serverX), (_frl__y + 230), Server);
{
image_xscale = 1;
;
}
_frl__serverX += 24;
;
}
fr_Areas_deeplabs_area_gml_BigTube_spawn((_frl__x - 156), (_frl__y + 256), "Loot");
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((_frl__x - 156), (_frl__y + 312), "Loot");
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((_frl__x - 188), (_frl__y - 178), global.fr_module_vars[$ "area:deeplabs"].sprStartRoomMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((_frl__x - 393), (_frl__y - 68), global.fr_module_vars[$ "area:deeplabs"].sprStartRoomFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalCore_create((_frl__x + 32), (_frl__y + 13));
;
fr_Areas_deeplabs_area_gml_StartRoomHitbox_create((_frl__x - 96), (_frl__y + 16));
;
fr_Areas_deeplabs_area_gml_DeeplabsCorePanel_create((_frl__x + 32), (_frl__y - 128));
;
fr_Areas_deeplabs_area_gml_PanelSoundController_create((_frl__x + 32), (_frl__y - 200));
;
if ((frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.save_get, "Frontier", "deeplabs_finales") == 0)) {
{
var _frl__barrierX = _frl__x;
;
repeat (3) {
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_Barrier_create((_frl__barrierX + 240), (_frl__y - 73), false, undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_starterBarrier = true;
;
playSound = false;
;
}
}
if(__fr_break3) break;
}}
_frl__barrierX -= 16;
;
}
}
}
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((_frl__x + 32), (_frl__y - 80));
;
frMacro_Areas_deeplabs_area_gml_roomDir = "right";
;
if (scrFRInstanceIs((real(id) + 1), Floor)) {
{
scrFRDelete((real(id) + 1));
;
}
}
var _frl__roomGoal = ((12 + GameCont.loops) + scrFRSourceIRandom(2));
var _frl__roomCount = 0;
;
repeat (_frl__roomGoal) {
var _frl__pool = global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsR;
var _frl__dirID = 0;
var _frl__traceCol = c_green;
;
{ var __fr_switch_value4=frMacro_Areas_deeplabs_area_gml_roomDir, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("right")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("up")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("down")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
_frl__pool = global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsR;
_frl__dirID = 0;
;
_frl__traceCol = c_green;
;
break;
;
case 1:
_frl__pool = global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsU;
_frl__dirID = 1;
;
_frl__traceCol = c_aqua;
;
break;
;
case 2:
_frl__pool = global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsD;
_frl__dirID = 2;
;
_frl__traceCol = c_orange;
;
break;
;
}
}
var _frl__roomType = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, _frl__pool);
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "area:deeplabs"], "roomLast", [_frl__dirID], _frl__roomType, "=");
;
if ((_frl__roomCount == (_frl__roomGoal - 1))) {
{
_frl__roomType = "EndRoom";
;
}
}
fr_Areas_deeplabs_area_gml_deeplabsRoom_create(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, _frl__roomType);
;
if ((frMacro_Areas_deeplabs_area_gml_deeplabsDebug == true)) {
{
scrFRTraceColor(_frl__roomType, _frl__traceCol);
fr_Areas_deeplabs_area_gml_DeeplabsRoomNametag_create(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, _frl__roomType);
}
}
_frl__roomCount += 1;
;
fr_Areas_deeplabs_area_gml_deeplabsRoomPools_construct();
;
{ var __fr_with6 = scrFRWithValues(FloorMaker), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
scrFRInstanceDestroy();
}
if(__fr_break8) break;
}}
;
}
}

// Original Areas/deeplabs.area.gml:820
function fr_Areas_deeplabs_area_gml_deeplabsRoom_init() {
global.fr_module_vars[$ "area:deeplabs"].room_count = 0;
;
global.fr_module_vars[$ "area:deeplabs"].roomStartX = 10000;
;
global.fr_module_vars[$ "area:deeplabs"].roomStartY = 10000;
;
global.fr_module_vars[$ "area:deeplabs"].roomDirect = "right";
;
global.fr_module_vars[$ "area:deeplabs"].roomDirectEnd = "right";
;
global.fr_module_vars[$ "area:deeplabs"].roomLast = [undefined, undefined, undefined];
;
; // macro hoisted: roomX
;
; // macro hoisted: roomY
;
; // macro hoisted: roomDir
;
; // macro hoisted: roomDirEnd
;
fr_Areas_deeplabs_area_gml_deeplabsRoomPools_construct();
;
}

// Original Areas/deeplabs.area.gml:834
function fr_Areas_deeplabs_area_gml_deeplabsRoomPools_construct() {
global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsR = [["6x6RR", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 0) == "6x6RR") * 0.5))], ["6x6RD", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 0) == "6x6RD") * 0.5))], ["LUpRoom", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 0) == "LUpRoom") * 0.5))], ["LDownRoom", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 0) == "LDownRoom") * 0.5))], ["DoubleTower", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 0) == "DoubleTower") * 0.8))]];
global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsU = [["5x8UR", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 1) == "5x8UR") * 0.5))], ["6x10UU", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 1) == "6x10UU") * 0.5))], ["FreakPark", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 1) == "FreakPark") * 0.5))]];
global.fr_module_vars[$ "area:deeplabs"].deeplabsRoomsD = [["FiringSquad", (0.7 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 2) == "FiringSquad") * 0.5))], ["Chokepoint", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 2) == "Chokepoint") * 0.5))], ["9x5DR", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 2) == "9x5DR") * 0.5))], ["9x9DR", (1 - ((scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].roomLast, 2) == "9x9DR") * 0.5))]];
}

// Original Areas/deeplabs.area.gml:858
function fr_Areas_deeplabs_area_gml_deeplabsRoom_create(_frl__x=undefined, _frl__y=undefined, _frl__type=undefined) {
var _frl__dir = "right";
var _frl__layout = "";
;
{ var __fr_switch_value1=_frl__type, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("EndRoom")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("6x6RR")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("6x6RD")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("FiringSquad")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Chokepoint")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("5x8UR")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("LUpRoom")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("LDownRoom")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("6x10UU")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("FreakPark")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("9x5DR")) __fr_switch_case2=10;
if(__fr_switch_case2==-1 && __fr_switch_value1==("9x9DR")) __fr_switch_case2=11;
if(__fr_switch_case2==-1 && __fr_switch_value1==("DoubleTower")) __fr_switch_case2=12;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
global.fr_module_vars[$ "area:deeplabs"].bombTimer = 120;
;
if (frMacro_Areas_deeplabs_area_gml_deeplabsDebug) {
{
scrFRTrace(("END ROOM DIR: " + frMacro_Areas_deeplabs_area_gml_roomDir));
}
}
{ var __fr_switch_value3=frMacro_Areas_deeplabs_area_gml_roomDir, __fr_switch_case4=-1;
if(__fr_switch_case4==-1 && __fr_switch_value3==("right")) __fr_switch_case4=0;
if(__fr_switch_case4==-1 && __fr_switch_value3==("up")) __fr_switch_case4=1;
if(__fr_switch_case4==-1 && __fr_switch_value3==("down")) __fr_switch_case4=2;
if(__fr_switch_case4==-1) __fr_switch_case4=-1;
switch(__fr_switch_case4) {
case 0:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 64), frMacro_Areas_deeplabs_area_gml_roomY, 5, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 192), frMacro_Areas_deeplabs_area_gml_roomY, 3, 3);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY - 128), 1, 4, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 1, 2, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY - 320), 5, 5, global.fr_module_vars[$ "area:deeplabs"].sprFloor);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX + 128), (frMacro_Areas_deeplabs_area_gml_roomY - 48), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorRightMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorRightFront);
;
fr_Areas_deeplabs_area_gml_SafeRoom_populate(208, (- 304));
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 208), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 208), (frMacro_Areas_deeplabs_area_gml_roomY - 304));
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 64), 1, 4, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 160), 1, 2, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 256), 5, 5, global.fr_module_vars[$ "area:deeplabs"].sprFloor);
;
fr_Areas_deeplabs_area_gml_SafeRoom_populate(16, (- 240));
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 240));
;
break;
;
case 2:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 32), 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 128), 3, 3);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 160), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 7, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 320), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 3, 3);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 320), frMacro_Areas_deeplabs_area_gml_roomY, 1, 4, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom((frMacro_Areas_deeplabs_area_gml_roomX + 320), (frMacro_Areas_deeplabs_area_gml_roomY - 96), 1, 2, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom((frMacro_Areas_deeplabs_area_gml_roomX + 320), (frMacro_Areas_deeplabs_area_gml_roomY - 192), 5, 5, global.fr_module_vars[$ "area:deeplabs"].sprFloor);
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 80), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorDownMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 41), (frMacro_Areas_deeplabs_area_gml_roomY + 156), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomConnectorDownFront);
;
fr_Areas_deeplabs_area_gml_SafeRoom_populate(336, (- 176));
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 144));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 336), (frMacro_Areas_deeplabs_area_gml_roomY + 144));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 336), (frMacro_Areas_deeplabs_area_gml_roomY - 176));
;
break;
;
}
}
frMacro_Areas_deeplabs_area_gml_roomDirEnd = frMacro_Areas_deeplabs_area_gml_roomDir;
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 128), (frMacro_Areas_deeplabs_area_gml_roomY + 64), 6, 6);
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 320), (frMacro_Areas_deeplabs_area_gml_roomY + 128), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY - 144), global.fr_module_vars[$ "area:deeplabs"].spr6x6RRMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY - 100), global.fr_module_vars[$ "area:deeplabs"].spr6x6RRFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureExtraBomb_create((frMacro_Areas_deeplabs_area_gml_roomX - 260), (frMacro_Areas_deeplabs_area_gml_roomY + 132), global.fr_module_vars[$ "area:deeplabs"].sprDangerScreen, global.fr_module_vars[$ "area:deeplabs"].sprDangerScreenOff, 0.6);
;
_frl__layout = scrFRSourceChoose("BallDodge", "BallFight");
;
{ var __fr_switch_value5=_frl__layout, __fr_switch_case6=-1;
if(__fr_switch_case6==-1 && __fr_switch_value5==("BallDodge")) __fr_switch_case6=0;
if(__fr_switch_case6==-1 && __fr_switch_value5==("BallFight")) __fr_switch_case6=1;
if(__fr_switch_case6==-1) __fr_switch_case6=-1;
switch(__fr_switch_case6) {
case 0:
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 80));
;
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY - 80));
;
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 192), (frMacro_Areas_deeplabs_area_gml_roomY - 32));
;
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY - 112));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 208), (frMacro_Areas_deeplabs_area_gml_roomY - 32), 9, 6);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 88), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 192), (frMacro_Areas_deeplabs_area_gml_roomY - 32));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 32), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY + 32), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY - 112));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
case 2:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 128), (frMacro_Areas_deeplabs_area_gml_roomY + 64), 6, 6);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY + 192), 1, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY + 224), "down", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
_frl__dir = "down";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 196), (frMacro_Areas_deeplabs_area_gml_roomY - 273), global.fr_module_vars[$ "area:deeplabs"].spr6x6RDMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 196), (frMacro_Areas_deeplabs_area_gml_roomY - 64), global.fr_module_vars[$ "area:deeplabs"].spr6x6RDMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 192), (frMacro_Areas_deeplabs_area_gml_roomY - 228), global.fr_module_vars[$ "area:deeplabs"].spr6x6RDFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY - 160), 10, 8);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 48), true, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("LaserWhack", "Spin2Lose");
;
{ var __fr_switch_value7=_frl__layout, __fr_switch_case8=-1;
if(__fr_switch_case8==-1 && __fr_switch_value7==("LaserWhack")) __fr_switch_case8=0;
if(__fr_switch_case8==-1 && __fr_switch_value7==("Spin2Lose")) __fr_switch_case8=1;
if(__fr_switch_case8==-1) __fr_switch_case8=-1;
switch(__fr_switch_case8) {
case 0:
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY - 160), 1, 96, 2, 640);
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 120), _frl__barrier, true, _frl__roomHitbox, 15, scrFRSourceChoose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 208), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Deeplabs", "GatorAmalgam_create", 1], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY - 240));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 96));
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_SpinTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY - 96), 1);
;
fr_Areas_deeplabs_area_gml_SpinTurret_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 1);
;
fr_Areas_deeplabs_area_gml_BecomeChest_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 192), AmmoChest);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY - 224), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "Swarmbot_create", (4 + scrFRSourceIRandom(2))], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))], ["Basegame", Freak, (8 + scrFRSourceIRandom(4))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY - 128), _frl__barrier, true, _frl__roomHitbox, 10, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(2))], ["Frontier_Deeplabs", "RavenAmalgam_create", (2 + scrFRSourceIRandom(1))], ["Basegame", FireBaller, (2 + scrFRSourceIRandom(1))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY - 240));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 96));
;
break;
;
}
}
break;
;
case 3:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 160), 3, 7);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 160), 1, 5);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 64), (frMacro_Areas_deeplabs_area_gml_roomY + 224), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 128), (frMacro_Areas_deeplabs_area_gml_roomY + 224), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 272), (frMacro_Areas_deeplabs_area_gml_roomY - 176), global.fr_module_vars[$ "area:deeplabs"].sprFiringSquadMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 201), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].sprFiringSquadFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 48), 5, 8);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 112), _frl__roomHitbox, 0, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 80), _frl__roomHitbox, 5, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 48), _frl__roomHitbox, 10, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 16), _frl__roomHitbox, 15, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__roomHitbox, 20, undefined);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY - 32), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((_frl__x + 16), (_frl__y + 96));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((_frl__x + 16), (_frl__y + 240));
;
break;
;
case 4:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 96), 3, 3);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 224), 11, 5);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 192), (frMacro_Areas_deeplabs_area_gml_roomY + 256), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 256), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
var _frl__wallX = 240;
;
repeat (7) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY - 64));
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY - 48));
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 64));
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 48));
_frl__wallX -= 16;
;
}
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 506), (frMacro_Areas_deeplabs_area_gml_roomY - 196), global.fr_module_vars[$ "area:deeplabs"].sprChokepointMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 457), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].sprChokepointFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 272), (frMacro_Areas_deeplabs_area_gml_roomY - 64), 11, 11);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 88), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("Basic");
;
{ var __fr_switch_value9=_frl__layout, __fr_switch_case10=-1;
if(__fr_switch_case10==-1 && __fr_switch_value9==("Basic")) __fr_switch_case10=0;
if(__fr_switch_case10==-1) __fr_switch_case10=-1;
switch(__fr_switch_case10) {
case 0:
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 432), (frMacro_Areas_deeplabs_area_gml_roomY - 60), _frl__roomHitbox, 20, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY - 60), _frl__roomHitbox, 20, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeChest_create((frMacro_Areas_deeplabs_area_gml_roomX - 400), (frMacro_Areas_deeplabs_area_gml_roomY - 16), AmmoChest);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__barrier, true, _frl__roomHitbox, 12, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 192), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__barrier, false, _frl__roomHitbox, 15, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
break;
;
}
}
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 272), (frMacro_Areas_deeplabs_area_gml_roomY - 160));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 272), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 5:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 32), 1, 2, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 192), 5, 8);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 96), (frMacro_Areas_deeplabs_area_gml_roomY - 256), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 251), (frMacro_Areas_deeplabs_area_gml_roomY - 48), global.fr_module_vars[$ "area:deeplabs"].spr5x8URMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 251), (frMacro_Areas_deeplabs_area_gml_roomY + 232), global.fr_module_vars[$ "area:deeplabs"].spr5x8URMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 201), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].spr5x8URFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 96), 5, 12);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("Basic", "Split");
;
{ var __fr_switch_value11=_frl__layout, __fr_switch_case12=-1;
if(__fr_switch_case12==-1 && __fr_switch_value11==("Basic")) __fr_switch_case12=0;
if(__fr_switch_case12==-1 && __fr_switch_value11==("Split")) __fr_switch_case12=1;
if(__fr_switch_case12==-1) __fr_switch_case12=-1;
switch(__fr_switch_case12) {
case 0:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 136), (frMacro_Areas_deeplabs_area_gml_roomY + 16), _frl__barrier, true, _frl__roomHitbox, 20, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 136), (frMacro_Areas_deeplabs_area_gml_roomY + 80), _frl__barrier, false, _frl__roomHitbox, 15, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 192));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
if ((scrFRSourceRandom(2) < 1)) {
{
var _frl__wallY = 0;
;
repeat (3) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), ((frMacro_Areas_deeplabs_area_gml_roomY + 32) + _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), ((frMacro_Areas_deeplabs_area_gml_roomY + 32) + _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), ((frMacro_Areas_deeplabs_area_gml_roomY + 112) + _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), ((frMacro_Areas_deeplabs_area_gml_roomY + 112) + _frl__wallY));
;
_frl__wallY += 16;
;
}
var _frl__trap = scrFRSourceChoose("BallTrap", "SpinTurret", "LaserTrap", "Turret");
;
{ var __fr_switch_value13=_frl__trap, __fr_switch_case14=-1;
if(__fr_switch_case14==-1 && __fr_switch_value13==("BallTrap")) __fr_switch_case14=0;
if(__fr_switch_case14==-1 && __fr_switch_value13==("SpinTurret")) __fr_switch_case14=1;
if(__fr_switch_case14==-1 && __fr_switch_value13==("LaserTrap")) __fr_switch_case14=2;
if(__fr_switch_case14==-1 && __fr_switch_value13==("Turret")) __fr_switch_case14=3;
if(__fr_switch_case14==-1) __fr_switch_case14=-1;
switch(__fr_switch_case14) {
case 0:
scrFRModCall("mod", "Frontier_Labs", "BallTrap_create", (frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 96));
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_SpinTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 96), 2);
;
break;
;
case 2:
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 96), 2, 80, 3, 320);
;
break;
;
case 3:
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 96), _frl__roomHitbox, 4, undefined);
;
break;
;
}
}
}
} else {
{
var _frl__wallY = 0;
;
repeat (8) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), ((frMacro_Areas_deeplabs_area_gml_roomY + 32) + _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), ((frMacro_Areas_deeplabs_area_gml_roomY + 32) + _frl__wallY));
;
_frl__wallY += 16;
;
}
}
}
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 168), (frMacro_Areas_deeplabs_area_gml_roomY + 192), (- 1));
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY + 144), Server);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 80), (frMacro_Areas_deeplabs_area_gml_roomY + 144), Server);
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 152), (frMacro_Areas_deeplabs_area_gml_roomY - 16), _frl__barrier, true, _frl__roomHitbox, 15, scrFRSourceChoose(["Frontier_Deeplabs", "RavenAmalgam_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Basegame", Freak, (8 + scrFRSourceIRandom(4))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 72), (frMacro_Areas_deeplabs_area_gml_roomY - 16), _frl__barrier, true, _frl__roomHitbox, 15, scrFRSourceChoose(["Frontier_Deeplabs", "RavenAmalgam_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Basegame", Freak, (8 + scrFRSourceIRandom(4))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 192));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 192));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
case 6:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 160), frMacro_Areas_deeplabs_area_gml_roomY, 8, 4);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 224), (frMacro_Areas_deeplabs_area_gml_roomY - 128), 4, 4);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY - 288), "up", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
_frl__dir = "up";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY + 32), global.fr_module_vars[$ "area:deeplabs"].sprLUpRoomMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY + 348), global.fr_module_vars[$ "area:deeplabs"].sprLUpRoomFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 288), 12, 8);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 144), true, _frl__roomHitbox);
_frl__layout = scrFRSourceChoose("Basic");
;
{ var __fr_switch_value15=_frl__layout, __fr_switch_case16=-1;
if(__fr_switch_case16==-1 && __fr_switch_value15==("Basic")) __fr_switch_case16=0;
if(__fr_switch_case16==-1) __fr_switch_case16=-1;
switch(__fr_switch_case16) {
case 0:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 176), _frl__barrier, true, _frl__roomHitbox, 30, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 256), _frl__barrier, false, _frl__roomHitbox, 20, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 336), _frl__barrier, false, _frl__roomHitbox, 10, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY + 384), (- 1));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 384), (- 1));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY + 384), (- 1));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY + 336));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 336));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 192));
;
break;
;
}
}
break;
;
case 7:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 160), frMacro_Areas_deeplabs_area_gml_roomY, 8, 4);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 224), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 4, 4);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 224), 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 288), "down", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
_frl__dir = "down";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 248), (frMacro_Areas_deeplabs_area_gml_roomY - 368), global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 248), (frMacro_Areas_deeplabs_area_gml_roomY - 88), global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY - 299), global.fr_module_vars[$ "area:deeplabs"].sprLDownRoomFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 64), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 11, 8);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 80), true, _frl__roomHitbox);
_frl__layout = scrFRSourceChoose("Basic");
;
{ var __fr_switch_value17=_frl__layout, __fr_switch_case18=-1;
if(__fr_switch_case18==-1 && __fr_switch_value17==("Basic")) __fr_switch_case18=0;
if(__fr_switch_case18==-1) __fr_switch_case18=-1;
switch(__fr_switch_case18) {
case 0:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 160), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", 2]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 272), _frl__barrier, true, _frl__roomHitbox, 10, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY - 272), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 320), _frl__roomHitbox, 0, undefined);
;
fr_Areas_deeplabs_area_gml_BecomeChest_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 320), AmmoChest);
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY - 304));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 304));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY - 128));
;
break;
;
}
}
break;
;
case 8:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 32), 1, 2, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 6, 10);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 96), (frMacro_Areas_deeplabs_area_gml_roomY - 384), "up", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
_frl__dir = "up";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 186), (frMacro_Areas_deeplabs_area_gml_roomY + 48), global.fr_module_vars[$ "area:deeplabs"].spr6x10UUMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 186), (frMacro_Areas_deeplabs_area_gml_roomY + 392), global.fr_module_vars[$ "area:deeplabs"].spr6x10UUMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 137), (frMacro_Areas_deeplabs_area_gml_roomY + 378), global.fr_module_vars[$ "area:deeplabs"].spr6x10UUFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 224), 6, 14);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 48), true, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("SlowWheels", "CoverShooter");
;
{ var __fr_switch_value19=_frl__layout, __fr_switch_case20=-1;
if(__fr_switch_case20==-1 && __fr_switch_value19==("SlowWheels")) __fr_switch_case20=0;
if(__fr_switch_case20==-1 && __fr_switch_value19==("CoverShooter")) __fr_switch_case20=1;
if(__fr_switch_case20==-1) __fr_switch_case20=-1;
switch(__fr_switch_case20) {
case 0:
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 160), 3, 64, 1, 640);
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY + 288), 3, 64, 1, 640);
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 80), (frMacro_Areas_deeplabs_area_gml_roomY + 288), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 96), _frl__barrier, true, _frl__roomHitbox, 30, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 80), (frMacro_Areas_deeplabs_area_gml_roomY + 352));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 96));
;
break;
;
case 1:
var _frl__wallX = 0;
;
repeat (5) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - 48) + _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY + 272));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - 48) + _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY + 288));
;
_frl__wallX += 16;
;
}
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 320), Terminal);
;
fr_Areas_deeplabs_area_gml_BigTube_spawn(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 330), (- 1));
;
if ((scrFRSourceRandom(3) < 1)) {
{
fr_Areas_deeplabs_area_gml_BecomeTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 256), _frl__roomHitbox, 15, undefined);
;
}
}
fr_Areas_deeplabs_area_gml_BecomeChest_create(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY + 256), AmmoChest);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 128), Server);
;
fr_Areas_deeplabs_area_gml_VoltergeistTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 160));
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 32), (frMacro_Areas_deeplabs_area_gml_roomY + 192), Server);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 96), _frl__barrier, true, _frl__roomHitbox, 15, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(2))], ["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", GoldSnowTank, 1]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX + 32), (frMacro_Areas_deeplabs_area_gml_roomY + 96), _frl__barrier, false, _frl__roomHitbox, 15, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(2))], ["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 192), _frl__barrier, true, _frl__roomHitbox, 5, scrFRSourceChoose(["Basegame", SnowBot, (2 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(2))], ["Frontier_Deeplabs", "GatorAmalgam_create", 1]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 80), (frMacro_Areas_deeplabs_area_gml_roomY + 352));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 80), (frMacro_Areas_deeplabs_area_gml_roomY + 288));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX + 16), (frMacro_Areas_deeplabs_area_gml_roomY + 96));
;
break;
;
}
}
break;
;
case 9:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 32), 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill(frMacro_Areas_deeplabs_area_gml_roomX, (frMacro_Areas_deeplabs_area_gml_roomY - 224), 9, 8);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 160), (frMacro_Areas_deeplabs_area_gml_roomY - 224), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 224), (frMacro_Areas_deeplabs_area_gml_roomY - 224), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
var _frl__wallX = 208;
;
repeat (5) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY - 64));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY - 48));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 144), (frMacro_Areas_deeplabs_area_gml_roomY - 64));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 144), (frMacro_Areas_deeplabs_area_gml_roomY - 48));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY + 112));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY + 96));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 144), (frMacro_Areas_deeplabs_area_gml_roomY + 112));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create(((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX) - 144), (frMacro_Areas_deeplabs_area_gml_roomY + 96));
;
_frl__wallX -= 16;
;
}
var _frl__wallY = 32;
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), ((frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY) + 112));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 144), ((frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY) + 112));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), ((frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY) + 112));
;
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), ((frMacro_Areas_deeplabs_area_gml_roomY - _frl__wallY) + 112));
;
_frl__wallY -= 16;
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 448), (frMacro_Areas_deeplabs_area_gml_roomY - 112), global.fr_module_vars[$ "area:deeplabs"].sprFreakParkMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 448), (frMacro_Areas_deeplabs_area_gml_roomY - 9), global.fr_module_vars[$ "area:deeplabs"].sprFreakParkMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 393), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].sprFreakParkFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 48), 9, 13);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 77), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("FreakMode", "Haunted House");
;
{ var __fr_switch_value21=_frl__layout, __fr_switch_case22=-1;
if(__fr_switch_case22==-1 && __fr_switch_value21==("FreakMode")) __fr_switch_case22=0;
if(__fr_switch_case22==-1 && __fr_switch_value21==("Haunted House")) __fr_switch_case22=1;
if(__fr_switch_case22==-1) __fr_switch_case22=-1;
switch(__fr_switch_case22) {
case 0:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 8), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (14 + scrFRSourceIRandom(6))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 48), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))]));
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY - 12), MutantTube);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 12), MutantTube);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY + 80), MutantTube);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY + 80), MutantTube);
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 128));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_VoltergeistTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY - 12));
;
fr_Areas_deeplabs_area_gml_VoltergeistTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 12));
;
fr_Areas_deeplabs_area_gml_HugeTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 288), (frMacro_Areas_deeplabs_area_gml_roomY + 64), "Frozen City");
;
fr_Areas_deeplabs_area_gml_HugeTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 192), (frMacro_Areas_deeplabs_area_gml_roomY + 64), "Frozen City");
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 48), _frl__barrier, true, _frl__roomHitbox, 20, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (2 + scrFRSourceIRandom(1))], ["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", GoldSnowTank, 1]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY + 8), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "VesselOrbiter_spawn", (2 + scrFRSourceIRandom(1))], ["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", Wolf, (2 + scrFRSourceIRandom(1))], ["Basegame", SnowBot, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 144), (frMacro_Areas_deeplabs_area_gml_roomY + 8), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "VesselOrbiter_spawn", (2 + scrFRSourceIRandom(1))], ["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", Wolf, (2 + scrFRSourceIRandom(1))], ["Basegame", SnowBot, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 128));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
case 10:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 96), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 9, 5);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 128), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 320), (frMacro_Areas_deeplabs_area_gml_roomY + 128), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 408), (frMacro_Areas_deeplabs_area_gml_roomY - 80), global.fr_module_vars[$ "area:deeplabs"].spr9x5DRMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 393), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].spr9x5DRFront);
;
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), frMacro_Areas_deeplabs_area_gml_roomY, 9, 8);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 77), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
_frl__layout = scrFRSourceChoose("Spider Chamber", "City Slickers");
;
_frl__layout = "City Slickers";
{ var __fr_switch_value23=_frl__layout, __fr_switch_case24=-1;
if(__fr_switch_case24==-1 && __fr_switch_value23==("Spider Chamber")) __fr_switch_case24=0;
if(__fr_switch_case24==-1 && __fr_switch_value23==("City Slickers")) __fr_switch_case24=1;
if(__fr_switch_case24==-1) __fr_switch_case24=-1;
switch(__fr_switch_case24) {
case 0:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY - 40), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Spider, (3 + scrFRSourceIRandom(2))], ["Basegame", InvSpider, (2 + scrFRSourceIRandom(2))], ["Basegame", LaserCrystal, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY + 40), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", Spider, (3 + scrFRSourceIRandom(2))], ["Basegame", InvSpider, (2 + scrFRSourceIRandom(2))], ["Basegame", LaserCrystal, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY + 48), "Spider");
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY + 48), scrFRSourceChoose("Spider", "Loot"));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY + 48), "Spider");
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 224), (frMacro_Areas_deeplabs_area_gml_roomY + 60), Terminal);
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY - 32));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY - 40), _frl__barrier, true, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", SnowBot, (2 + scrFRSourceIRandom(2))], ["Basegame", Wolf, (2 + scrFRSourceIRandom(1))], ["Basegame", GoldSnowTank, 1]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY + 40), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Basegame", SnowTank, (1 + scrFRSourceIRandom(1))], ["Basegame", SnowBot, (2 + scrFRSourceIRandom(2))], ["Basegame", Wolf, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_HugeTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY + 64), "Frozen City");
;
fr_Areas_deeplabs_area_gml_HugeTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY + 64), "Frozen City");
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 256), (frMacro_Areas_deeplabs_area_gml_roomY - 48), (- 1));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY - 32));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 128), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
case 11:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite(frMacro_Areas_deeplabs_area_gml_roomX, frMacro_Areas_deeplabs_area_gml_roomY, 1, 3, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkVertical);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 64), (frMacro_Areas_deeplabs_area_gml_roomY + 64), 7, 1);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 64), (frMacro_Areas_deeplabs_area_gml_roomY + 192), 9, 7);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 64), (frMacro_Areas_deeplabs_area_gml_roomY + 320), 7, 1);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 224), (frMacro_Areas_deeplabs_area_gml_roomY + 192), 2, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 288), (frMacro_Areas_deeplabs_area_gml_roomY + 192), "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 448), (frMacro_Areas_deeplabs_area_gml_roomY - 144), global.fr_module_vars[$ "area:deeplabs"].spr9x9DRRoomMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 392), (frMacro_Areas_deeplabs_area_gml_roomY + 28), global.fr_module_vars[$ "area:deeplabs"].spr9x9DRRoomFront);
;
_frl__layout = scrFRSourceChoose("Turbine", "Big Turbine");
;
{ var __fr_switch_value25=_frl__layout, __fr_switch_case26=-1;
if(__fr_switch_case26==-1 && __fr_switch_value25==("Big Turbine")) __fr_switch_case26=0;
if(__fr_switch_case26==-1 && __fr_switch_value25==("Turbine")) __fr_switch_case26=1;
if(__fr_switch_case26==-1) __fr_switch_case26=-1;
switch(__fr_switch_case26) {
case 0:
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 16), 9, 11);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 77), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16), 2, 160, 3, 640);
;
fr_Areas_deeplabs_area_gml_BecomeChest_create((frMacro_Areas_deeplabs_area_gml_roomX - 208), (frMacro_Areas_deeplabs_area_gml_roomY - 16), AmmoChest);
;
var _frl__wallX = 288;
;
repeat (6) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY - 48));
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - _frl__wallX), (frMacro_Areas_deeplabs_area_gml_roomY + 64));
_frl__wallX -= 16;
;
}
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 96), Terminal);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 108), _frl__barrier, true, _frl__roomHitbox, 5, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", (4 + scrFRSourceIRandom(2))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))], ["Basegame", Freak, (5 + scrFRSourceIRandom(4))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY + 108), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY + 108), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY - 96));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY - 96));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY - 16), 9, 11);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 77), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
fr_Areas_deeplabs_area_gml_LaserTurret_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 16), 3, 50, 16, 640);
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY + 112), _frl__barrier, false, _frl__roomHitbox, 15, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 240), (frMacro_Areas_deeplabs_area_gml_roomY + 112), _frl__barrier, false, _frl__roomHitbox, 0, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 176), (frMacro_Areas_deeplabs_area_gml_roomY + 112), _frl__barrier, true, _frl__roomHitbox, 15, scrFRSourceChoose(["Basegame", Freak, (7 + scrFRSourceIRandom(3))], ["Basegame", RhinoFreak, 1], ["Frontier_Labs", "Swarmbot_create", 5], ["Basegame", Spider, (2 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 160), (frMacro_Areas_deeplabs_area_gml_roomY - 112), _frl__barrier, true, _frl__roomHitbox, 30, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (1 + scrFRSourceIRandom(1))], ["Frontier_Labs", "Swarmbot_create", 5], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 304), (frMacro_Areas_deeplabs_area_gml_roomY - 96));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
case 12:
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 32), frMacro_Areas_deeplabs_area_gml_roomY, 3, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 128), frMacro_Areas_deeplabs_area_gml_roomY, 4, 6);
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY - 48), 4, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 256), (frMacro_Areas_deeplabs_area_gml_roomY + 64), 4, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFill((frMacro_Areas_deeplabs_area_gml_roomX + 384), frMacro_Areas_deeplabs_area_gml_roomY, 4, 6);
fr_Areas_deeplabs_area_gml_scrFloorFillSprite((frMacro_Areas_deeplabs_area_gml_roomX + 480), frMacro_Areas_deeplabs_area_gml_roomY, 1, 1, global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
fr_Areas_deeplabs_area_gml_scrFloorFillConnector((frMacro_Areas_deeplabs_area_gml_roomX + 512), frMacro_Areas_deeplabs_area_gml_roomY, "right", global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalk);
;
_frl__dir = "right";
;
fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX - 512), (frMacro_Areas_deeplabs_area_gml_roomY - 80), global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerMain);
;
fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 308), (frMacro_Areas_deeplabs_area_gml_roomY - 39), global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerMainFront);
;
fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX - 544), (frMacro_Areas_deeplabs_area_gml_roomY - 20), global.fr_module_vars[$ "area:deeplabs"].sprDoubleTowerFront);
;
_frl__layout = scrFRSourceChoose("Normal", "Scorp Tower");
;
{ var __fr_switch_value27=_frl__layout, __fr_switch_case28=-1;
if(__fr_switch_case28==-1 && __fr_switch_value27==("Normal")) __fr_switch_case28=0;
if(__fr_switch_case28==-1 && __fr_switch_value27==("Scorp Tower")) __fr_switch_case28=1;
if(__fr_switch_case28==-1) __fr_switch_case28=-1;
switch(__fr_switch_case28) {
case 0:
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 288), (frMacro_Areas_deeplabs_area_gml_roomY + 32), 14, 6);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 50), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY - 48), (- 1));
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 380), (frMacro_Areas_deeplabs_area_gml_roomY - 48), (- 1));
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 432), (frMacro_Areas_deeplabs_area_gml_roomY + 88), Server);
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 384), (frMacro_Areas_deeplabs_area_gml_roomY + 80), _frl__barrier, true, _frl__roomHitbox, 10, scrFRSourceChoose(["Frontier_Labs", "Swarmbot_create", (4 + scrFRSourceIRandom(2))], ["Basegame", Freak, (5 + scrFRSourceIRandom(4))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 80), _frl__barrier, false, _frl__roomHitbox, 5, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(2))], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY - 64), _frl__barrier, false, _frl__roomHitbox, 5, scrFRSourceChoose(["Frontier_Labs", "MissileDrone_create", (2 + scrFRSourceIRandom(1))], ["Frontier_Deeplabs", "RavenAmalgam_create", (1 + scrFRSourceIRandom(2))], ["Frontier_Deeplabs", "GatorAmalgam_create", (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY + 80));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 156), (frMacro_Areas_deeplabs_area_gml_roomY + 80));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
case 1:
var _frl__roomHitbox = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create((frMacro_Areas_deeplabs_area_gml_roomX - 288), (frMacro_Areas_deeplabs_area_gml_roomY + 32), 14, 6);
var _frl__barrier = fr_Areas_deeplabs_area_gml_Barrier_create((frMacro_Areas_deeplabs_area_gml_roomX - 50), (frMacro_Areas_deeplabs_area_gml_roomY + 23), false, _frl__roomHitbox);
;
var _frl__wallY = 0;
;
repeat (5) {
fr_Areas_deeplabs_area_gml_DeeplabsWall_create((frMacro_Areas_deeplabs_area_gml_roomX - 368), ((frMacro_Areas_deeplabs_area_gml_roomY + 48) - _frl__wallY));
;
_frl__wallY += 16;
;
}
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 336), frMacro_Areas_deeplabs_area_gml_roomY, Server);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX - 336), (frMacro_Areas_deeplabs_area_gml_roomY + 48), Server);
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY - 48), (- 1));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY + 80), _frl__barrier, true, _frl__roomHitbox, 10, scrFRSourceChoose(["Frontier_Labs", "Swarmbot_create", (4 + scrFRSourceIRandom(2))], ["Basegame", Freak, (5 + scrFRSourceIRandom(4))], ["Basegame", RhinoFreak, (1 + scrFRSourceIRandom(1))], ["Basegame", ExploFreak, (1 + scrFRSourceIRandom(1))]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY + 80), _frl__barrier, false, _frl__roomHitbox, 5, scrFRSourceChoose(["Basegame", Scorpion, (2 + scrFRSourceIRandom(1))], ["Basegame", Scorpion, (2 + scrFRSourceIRandom(1))], ["Basegame", GoldScorpion, 1]));
;
fr_Areas_deeplabs_area_gml_EnemySpawnTube_create((frMacro_Areas_deeplabs_area_gml_roomX - 112), (frMacro_Areas_deeplabs_area_gml_roomY - 64), _frl__barrier, false, _frl__roomHitbox, 5, scrFRSourceChoose(["Basegame", Scorpion, (2 + scrFRSourceIRandom(1))], ["Basegame", Scorpion, (2 + scrFRSourceIRandom(1))], ["Basegame", GoldScorpion, 1]));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 416), (frMacro_Areas_deeplabs_area_gml_roomY + 64));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 352), (frMacro_Areas_deeplabs_area_gml_roomY + 80));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 156), (frMacro_Areas_deeplabs_area_gml_roomY + 80));
;
fr_Areas_deeplabs_area_gml_TestSubjectNode_create((frMacro_Areas_deeplabs_area_gml_roomX - 96), (frMacro_Areas_deeplabs_area_gml_roomY + 16));
;
break;
;
}
}
break;
;
}
}
frMacro_Areas_deeplabs_area_gml_roomDir = _frl__dir;
;
}

// Original Areas/deeplabs.area.gml:1896
function fr_Areas_deeplabs_area_gml_scrFloorFill(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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

// Original Areas/deeplabs.area.gml:1910
function fr_Areas_deeplabs_area_gml_scrFloorFillSprite(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined, _frl__sprite=undefined) {
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
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
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

// Original Areas/deeplabs.area.gml:1926
function fr_Areas_deeplabs_area_gml_scrFloorFillConnector(_frl__x=undefined, _frl__y=undefined, _frl__dir=undefined, _frl__sprite=undefined) {
var _frl_o = 32;
var _frl__w = 1;
var _frl__h = 1;
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
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_blend = (frMacro_Areas_deeplabs_area_gml_deeplabsDebug ? c_aqua : c_white);
;
{ var __fr_switch_value4=_frl__dir, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("right")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("up")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("down")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
frMacro_Areas_deeplabs_area_gml_roomX = (x + 32);
;
frMacro_Areas_deeplabs_area_gml_roomY = y;
;
break;
;
case 1:
frMacro_Areas_deeplabs_area_gml_roomX = x;
;
frMacro_Areas_deeplabs_area_gml_roomY = (y - 32);
;
break;
;
case 2:
frMacro_Areas_deeplabs_area_gml_roomX = x;
;
frMacro_Areas_deeplabs_area_gml_roomY = (y + 32);
;
break;
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
}
}

// Original Areas/deeplabs.area.gml:1960
function fr_Areas_deeplabs_area_gml_scrFloorFillEndRoom(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined, _frl__sprite=undefined) {
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
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
fr_endroom = true;
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

// Original Areas/deeplabs.area.gml:1977
function fr_Areas_deeplabs_area_gml_scrFloorFillStupid(_frl__x=undefined, _frl__y=undefined, _frl__w=undefined, _frl__h=undefined) {
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
sprite_index = scrFRAreaSourceSprite(mskNone);
;
image_blend = c_red;
;
fr_endroom = true;
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

// Original Areas/deeplabs.area.gml:1995
function fr_Areas_deeplabs_area_gml_area_pop_enemies() {

}

// Original Areas/deeplabs.area.gml:2028
function fr_Areas_deeplabs_area_gml_area_pop_props() {

}

// Original Areas/deeplabs.area.gml:2047
function fr_Areas_deeplabs_area_gml_area_pop_extras() {

}

// Original Areas/deeplabs.area.gml:2050
function fr_Areas_deeplabs_area_gml_area_finish() {
if ((subarea < fr_Areas_deeplabs_area_gml_area_subarea())) {
{
subarea++;
;
}
} else {
{
var _frl__next = fr_Areas_deeplabs_area_gml_area_next();
;
area = scrFRAreaResolve(scrFRIndexGet(_frl__next, 0));
;
subarea = scrFRIndexGet(_frl__next, 1);
;
}
}
if ((global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred == true)) {
{
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic);
;
}
}
}

// Original Areas/deeplabs.area.gml:2073
function fr_Areas_deeplabs_area_gml_area_transit() {
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].panelSound);
;
scrFRSoundRestore(sndWallBreakRock);
;
}

// Original Areas/deeplabs.area.gml:2080
function fr_Areas_deeplabs_area_gml_deeplabsFog_draw() {
var _frl__backgroundPos = global.fr_module_vars[$ "area:deeplabs"].areaBackgroundPos;
;
draw_set_alpha(0.6);
draw_sprite_tiled(global.fr_module_vars[$ "area:deeplabs"].sprFogDeeplabs2, 0, ((x - (_frl__backgroundPos * 0.3)) + 128), (y - 64));
draw_set_alpha(0.4);
draw_sprite_tiled(global.fr_module_vars[$ "area:deeplabs"].sprFogDeeplabs2, 0, (x - (_frl__backgroundPos * 0.5)), y);
draw_set_alpha(1);
}

// Original Areas/deeplabs.area.gml:2088
function fr_Areas_deeplabs_area_gml_SafeRoom_populate(_frl__safeX=undefined, _frl__safeY=undefined) {
global.fr_module_vars[$ "area:deeplabs"].safeZone = fr_Areas_deeplabs_area_gml_SafeZone_create((frMacro_Areas_deeplabs_area_gml_roomX + _frl__safeX), (frMacro_Areas_deeplabs_area_gml_roomY + _frl__safeY));
;
scrFRModCall("mod", "Frontier_Pickups", "DeeplabsCache_create", (frMacro_Areas_deeplabs_area_gml_roomX + _frl__safeX), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY + 40)));
;
fr_Areas_deeplabs_area_gml_EndRoomElevator_create((frMacro_Areas_deeplabs_area_gml_roomX + _frl__safeX), ((frMacro_Areas_deeplabs_area_gml_roomY + _frl__safeY) - 72));
;
var _frl__wallY = 0;
;
repeat (3) {
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 32)), (((frMacro_Areas_deeplabs_area_gml_roomY + _frl__safeY) - 80) + _frl__wallY), InvisiWall);
;
scrFRInstanceCreate((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX + 16)), (((frMacro_Areas_deeplabs_area_gml_roomY + _frl__safeY) - 80) + _frl__wallY), InvisiWall);
;
_frl__wallY += 16;
;
}
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 60)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY - 66)), "Loot");
;
fr_Areas_deeplabs_area_gml_BigTube_spawn((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX + 60)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY - 66)), "Loot");
;
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_RoomDecalStructure_create((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 160)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY - 173)), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMain)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_coreDetoKill = false;
;
depth = 7;
;
spr_charred = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainCharred;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 160)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY + 51)), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainFront)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_coreDetoKill = false;
;
spr_charred = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomMainFrontCharred;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(fr_Areas_deeplabs_area_gml_RoomDecalFront_create((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 112)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY + 17)), global.fr_module_vars[$ "area:deeplabs"].sprEndRoomFront)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_coreDetoKill = false;
;
spr_charred = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomFrontCharred;
;
}
}
if(__fr_break9) break;
}}
fr_Areas_deeplabs_area_gml_EndRoomRoof_create((frMacro_Areas_deeplabs_area_gml_roomX + (_frl__safeX - 112)), (frMacro_Areas_deeplabs_area_gml_roomY + (_frl__safeY - 169)));
;
}

// Original Areas/deeplabs.area.gml:2125
function fr_Areas_deeplabs_area_gml_Terminal_create(_frl__x=undefined, _frl__y=undefined) {
scrFRInstanceCreate(_frl__x, _frl__y, Terminal);
;
}

// Original Areas/deeplabs.area.gml:2128
function fr_Areas_deeplabs_area_gml_TerminalOff_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprTerminalOff;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprTerminalOffHurt;
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

// Original Areas/deeplabs.area.gml:2149
function fr_Areas_deeplabs_area_gml_BigTube_create(_frl__x=undefined, _frl__y=undefined) {
; // macro hoisted: normalRotSpeed
; // macro hoisted: normalBobSpeed
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_BigTube";
;
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprBigTube;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprBigTubeHurt;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprBigTubeDead;
;
spr_back = global.fr_module_vars[$ "area:deeplabs"].sprBigTubeBack;
;
spr_shadow = shd64B;
;
spr_shadow_y = 9;
;
depth = (- 1);
;
huge = false;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndLabsTubeBreak;
;
truemaxhealth = 10;
;
scrFRMaxHealthWrite(id, (1 / 0), "=");
;
hp = max_hp;
;
size = 12;
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskBigTube;
;
image_xscale = 1;
;
team = 0;
;
fr_allowDespawn = true;
;
tubeHealthed = false;
;
spr_object = sprBanditIdle;
;
spr_object_index = 1;
;
object_startangle = 0;
;
object_rotspeed = frMacro_Areas_deeplabs_area_gml_normalRotSpeed;
;
object_bobspeed = frMacro_Areas_deeplabs_area_gml_normalBobSpeed;
;
object_bobheight = 2;
;
object_flip = scrFRSourceChoose(1, (- 1));
;
object_color = make_color_rgb(40, 87, 9);
;
object = Bandit;
;
object_spawntype = "Basegame";
;
object_mod = undefined;
;
object_throw = true;
;
object_debris = true;
;
on_step = fr_Areas_deeplabs_area_gml_BigTube_step;
;
on_death = fr_Areas_deeplabs_area_gml_BigTube_destroy;
;
scrFRBindDraw(fr_Areas_deeplabs_area_gml_BigTube_draw_back, (depth + 1), scrFRSelf(self));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2207
function fr_Areas_deeplabs_area_gml_BigTube_step() {
object_startangle += (object_rotspeed * scrFRSourceScale());
;
if ((tubeHealthed == false)) {
{
if ((distance_to_object(Player) < 320)) {
{
tubeHealthed = true;
;
scrFRMaxHealthWrite(id, truemaxhealth, "=");
;
hp = max_hp;
;
}
}
}
}
}

// Original Areas/deeplabs.area.gml:2217
function fr_Areas_deeplabs_area_gml_BigTube_draw_back(_frl__tube=undefined) {
if ((! scrFRInstanceExists(_frl__tube))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__tube), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(spr_back, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
var _frl__y = (y + (sin((scrFRSourceFrame() * object_bobspeed)) * object_bobheight));
scrFRDrawSpriteExt(spr_object, spr_object_index, x, _frl__y, object_flip, image_yscale, object_startangle, object_color, image_alpha);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2228
function fr_Areas_deeplabs_area_gml_BigTube_destroy() {
if ((object_debris == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprExploderExplo);
}
}
if(__fr_break3) break;
}}
repeat (scrFRSourceRandomRange(3, 5)) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeDebris);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(5)) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
repeat (scrFRSourceRandomRange(2, 4)) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeDebrisBig);
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(5)) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
repeat (scrFRSourceRandomRange(3, 6)) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 12), 12)), (y + scrFRSourceRandomRange((- 12), 12)), BloodStreak)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeStreak);
direction = scrFRSourceIRandom(360);
;
}
}
if(__fr_break12) break;
}}
}
if ((huge == true)) {
{
repeat (scrFRSourceRandomRange(3, 6)) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 32), 32)), (y + scrFRSourceRandomRange((- 24), 24)), BloodStreak)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeStreak);
direction = scrFRSourceIRandom(360);
;
}
}
if(__fr_break15) break;
}}
}
repeat (4) {
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 32), 23)), (y + scrFRSourceRandomRange((- 20), 20)), BulletHit)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(sprExploderExplo);
}
}
if(__fr_break18) break;
}}
}
repeat (scrFRSourceRandomRange(2, 4)) {
{ var __fr_with19 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeDebrisBig);
;
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break21) break;
}}
}
}
}
}
}
{ var __fr_switch_value22=object_spawntype, __fr_switch_case23=-1;
if(__fr_switch_case23==-1 && __fr_switch_value22==("Basegame")) __fr_switch_case23=0;
if(__fr_switch_case23==-1 && __fr_switch_value22==("Mod")) __fr_switch_case23=1;
if(__fr_switch_case23==-1 && __fr_switch_value22==("OBJ")) __fr_switch_case23=2;
if(__fr_switch_case23==-1) __fr_switch_case23=-1;
switch(__fr_switch_case23) {
case 0:
{ var __fr_with24 = scrFRWithValues(scrFRInstanceCreate(x, y, object)), __fr_break26=false;
for (var __fr_index25=0; __fr_index25<array_length(__fr_with24); ++__fr_index25) {
if(scrFRScopeExists(__fr_with24[__fr_index25])) with (__fr_with24[__fr_index25]) {
{
if (((scrFROther(other)).object_throw == true)) {
{
fr_Areas_deeplabs_area_gml_BigTube_throw();
;
mask_index = mskNone;
;
}
}
}
}
if(__fr_break26) break;
}}
break;
;
case 1:
{ var __fr_with27 = scrFRWithValues(scrFRModCall("mod", object_mod, object, x, y)), __fr_break29=false;
for (var __fr_index28=0; __fr_index28<array_length(__fr_with27); ++__fr_index28) {
if(scrFRScopeExists(__fr_with27[__fr_index28])) with (__fr_with27[__fr_index28]) {
{
if (((scrFROther(other)).object_throw == true)) {
{
fr_Areas_deeplabs_area_gml_BigTube_throw();
;
mask_index = mskNone;
;
}
}
}
}
if(__fr_break29) break;
}}
break;
;
case 2:
{ var __fr_with30 = scrFRWithValues(scrFRModCall("mod", object_mod, "obj_create", x, y, object)), __fr_break32=false;
for (var __fr_index31=0; __fr_index31<array_length(__fr_with30); ++__fr_index31) {
if(scrFRScopeExists(__fr_with30[__fr_index31])) with (__fr_with30[__fr_index31]) {
{
if (((scrFROther(other)).object_throw == true)) {
{
fr_Areas_deeplabs_area_gml_BigTube_throw();
;
mask_index = mskNone;
;
}
}
}
}
if(__fr_break32) break;
}}
break;
;
}
}
}

// Original Areas/deeplabs.area.gml:2322
function fr_Areas_deeplabs_area_gml_BigTube_throw() {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
z = 14;
;
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
zspeed = (4 + scrFRSourceRandom(2));
;
zfriction = 0.7;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
depth = __fr_other5.depth;
;
var __fr_other6=scrFROther(other);
mask_index = __fr_other6.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other7=scrFROther(other);
spr_shadow_y = __fr_other7.spr_shadow_y;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2337
function fr_Areas_deeplabs_area_gml_BigTube_spawn(_frl__x=undefined, _frl__y=undefined, _frl__pool=undefined) {
if ((_frl__pool == (- 1))) {
{
_frl__pool = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [["Basic", 1], ["Loot", 0.1]]);
;
}
}
var _frl__object = "Ammo Chest";
;
{ var __fr_switch_value1=_frl__pool, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Basic")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Loot")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Spider")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
_frl__object = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [["Bandit", 1], ["Ballguy", 1], ["Fish Freak", 0.2], ["Spider", 0.7]]);
;
break;
;
case 1:
_frl__object = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [["Ammo Chest", 2], ["Weapon Chest", 0.6], ["Strike Canister", 0.8], ["Mystery Chest", 0.4], ["Mimic", 0.3], ["Health Mimic", 0.3], ["Weapon Mimic", (0.3 * (1 > 0))], ["Meal Chest", 0.4], ["Trinket Chest", (0.15 * scrFRModLoaded("mod", "TreasureTrove"))], ["Cat Chest", (0.08 * scrFRModLoaded("mod", "ntte"))], ["Bat Chest", (0.08 * scrFRModLoaded("mod", "ntte"))], ["Rat Chest", (0.08 * scrFRModLoaded("mod", "ntte"))], ["Orchid Chest", (0.15 * scrFRModLoaded("mod", "ntte"))], ["Bonus Ammo Chest", (0.4 * scrFRModLoaded("mod", "ntte"))], ["Bonus Health Chest", (0.4 * scrFRModLoaded("mod", "ntte"))], ["HammerHead Chest", (0.15 * scrFRModLoaded("mod", "ntte"))], ["Spirit Chest", (0.06 * scrFRModLoaded("mod", "ntte"))], ["Red Ammo Chest", (0.06 * scrFRModLoaded("mod", "ntte"))]]);
;
break;
;
case 2:
_frl__object = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [["Spider", 1], ["Cursed Spider", 0.7], ["Cocoon", 0.5]]);
;
break;
;
}
}
fr_Areas_deeplabs_area_gml_BigTube_forceSpawn(_frl__x, _frl__y, _frl__object);
;
}

// Original Areas/deeplabs.area.gml:2391
function fr_Areas_deeplabs_area_gml_BigTube_forceSpawn(_frl__x=undefined, _frl__y=undefined, _frl__object=undefined) {
var _frl__objectIndex = ds_list_find_index(global.fr_module_vars[$ "area:deeplabs"].tubeObjectName, _frl__object);
var _frl__objectVars = ds_list_find_value(global.fr_module_vars[$ "area:deeplabs"].tubeObjectVars, _frl__objectIndex);
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_BigTube_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__rotRange = scrFRIndexGet(_frl__objectVars, 7);
var _frl__bobRange = scrFRIndexGet(_frl__objectVars, 8);
object = scrFRIndexGet(_frl__objectVars, 0);
;
object_spawntype = scrFRIndexGet(_frl__objectVars, 1);
;
object_mod = scrFRIndexGet(_frl__objectVars, 2);
;
object_throw = scrFRIndexGet(_frl__objectVars, 3);
;
object_debris = scrFRIndexGet(_frl__objectVars, 10);
;
spr_object = scrFRIndexGet(_frl__objectVars, 4);
;
spr_object_index = scrFRIndexGet(_frl__objectVars, 5);
;
object_startangle = scrFRSourceRandom(scrFRIndexGet(_frl__objectVars, 6));
;
object_rotspeed = (scrFRSourceRandomRange(scrFRIndexGet(_frl__rotRange, 0), scrFRIndexGet(_frl__rotRange, 1)) * scrFRSourceChoose(1, (- 1)));
;
object_bobspeed = scrFRSourceRandomRange(scrFRIndexGet(_frl__bobRange, 0), scrFRIndexGet(_frl__bobRange, 1));
;
object_bobheight = scrFRIndexGet(_frl__objectVars, 9);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2419
function fr_Areas_deeplabs_area_gml_BigTubeObjects_init() {
; // macro hoisted: _tespr
;
; // macro hoisted: WepMimicID
; // macro hoisted: WepMimicIdle
global.fr_module_vars[$ "area:deeplabs"].tubeObjectName = ds_list_create();
;
global.fr_module_vars[$ "area:deeplabs"].tubeObjectVars = ds_list_create();
;
; // macro hoisted: normalRotRange
;
; // macro hoisted: normalBobRange
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Bandit", Bandit, "Basegame", undefined, true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Ballguy", Exploder, "Basegame", undefined, true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 8, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Spider", Spider, "Basegame", undefined, true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 2, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Cursed Spider", InvSpider, "Basegame", undefined, true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 3, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Cocoon", Cocoon, "Basegame", undefined, true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 7, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Fish Freak", "FishFreakCorpse_create", "Mod", "Frontier_Deeplabs", false, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 1, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Ammo Chest", "TubeAmmoChest_create", "Mod", "Frontier_Deeplabs", 0, sprAmmoChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Weapon Chest", WeaponChest, "Basegame", undefined, true, sprWeaponChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Mystery Chest", AmmoChestMystery, "Basegame", undefined, true, sprAmmoChestMystery, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Health Chest", HealthChest, "Basegame", undefined, true, sprHealthChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Mimic", Mimic, "Basegame", undefined, true, sprMimicIdle, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Health Mimic", SuperMimic, "Basegame", undefined, true, sprSuperMimicIdle, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Weapon Mimic", frMacro_Areas_deeplabs_area_gml_WepMimicID, "Basegame", undefined, true, frMacro_Areas_deeplabs_area_gml_WepMimicIdle, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Strike Canister", RogueChest, "Basegame", undefined, true, sprRogueAmmoChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Meal Chest", "MealChest_create", "Mod", "Frontier_Pickups", true, scrFRModGet("mod", "Frontier_Pickups", "sprMealChest"), 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
if (scrFRModLoaded("mod", "TreasureTrove")) {
{
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Trinket Chest", "TrinketChest_create", "Mod", "Trinkets", true, scrFRModGet("mod", "Trinkets", "sprTrinketChest"), 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
}
}
if (scrFRModLoaded("mod", "ntte")) {
{
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Bat Chest", "BatChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.BatChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Cat Chest", "CatChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.CatChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Rat Chest", "RatChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.RatChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Orchid Chest", "OrchidChest", "OBJ", "telib", true, global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects, 9, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 2, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Bonus Ammo Chest", "BonusAmmoChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.BonusAmmoChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Bonus Health Chest", "BonusHealthChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.BonusHealthChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("HammerHead Chest", "HammerHeadChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.HammerHeadChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Spirit Chest", "SpiritChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.SpiritChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Red Ammo Chest", "RedAmmoChest", "OBJ", "telib", true, frMacro_Areas_deeplabs_area_gml__tespr.RedAmmoChest, 0, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
}
}
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Snow Tank", SnowTank, "Basegame", undefined, false, global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeObjects, 0, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Golden Snow Tank", GoldSnowTank, "Basegame", undefined, false, global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeObjects, 1, 0, [0, 0], frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
fr_Areas_deeplabs_area_gml_BigTubeObject_add("Frozen Car", "FrozenCar_spawn", "Mod", "Frontier_Deeplabs", false, sprFrozenCar, 1, 360, frMacro_Areas_deeplabs_area_gml_normalRotRange, frMacro_Areas_deeplabs_area_gml_normalBobRange, 3, true);
;
}

// Original Areas/deeplabs.area.gml:2469
function fr_Areas_deeplabs_area_gml_BigTubeObject_add(_frl__name=undefined, _frl__object=undefined, _frl__objectSpawntype=undefined, _frl__objectMod=undefined, _frl__objectThrow=undefined, _frl__objectSprite=undefined, _frl__objectSpriteIndex=undefined, _frl__objectStartAngleRandom=undefined, _frl__objectRotSpeedRange=undefined, _frl__objectBobSpeedRange=undefined, _frl__objectBobHeight=undefined, _frl__objectDebris=undefined) {
ds_list_add(global.fr_module_vars[$ "area:deeplabs"].tubeObjectName, _frl__name);
;
ds_list_add(global.fr_module_vars[$ "area:deeplabs"].tubeObjectVars, [_frl__object, _frl__objectSpawntype, _frl__objectMod, _frl__objectThrow, _frl__objectSprite, _frl__objectSpriteIndex, _frl__objectStartAngleRandom, _frl__objectRotSpeedRange, _frl__objectBobSpeedRange, _frl__objectBobHeight, _frl__objectDebris]);
}

// Original Areas/deeplabs.area.gml:2474
function fr_Areas_deeplabs_area_gml_HugeTube_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_BigTube_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprHugeTube;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeHurt;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeDead;
;
spr_back = global.fr_module_vars[$ "area:deeplabs"].sprHugeTubeBack;
;
spr_shadow = global.fr_module_vars[$ "area:deeplabs"].shdHugeTube;
;
spr_shadow_y = 16;
;
huge = true;
;
truemaxhealth = 18;
;
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskHugeTube;
;
object_bobheight = 8;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2493
function fr_Areas_deeplabs_area_gml_HugeTube_spawn(_frl__x=undefined, _frl__y=undefined, _frl__pool=undefined) {
var _frl__object = "Ammo Chest";
;
{ var __fr_switch_value1=_frl__pool, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Frozen City")) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
_frl__object = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [["Snow Tank", 1], ["Golden Snow Tank", 0.2], ["Frozen Car", 1]]);
;
break;
;
}
}
fr_Areas_deeplabs_area_gml_HugeTube_forceSpawn(_frl__x, _frl__y, _frl__object);
;
}

// Original Areas/deeplabs.area.gml:2508
function fr_Areas_deeplabs_area_gml_HugeTube_forceSpawn(_frl__x=undefined, _frl__y=undefined, _frl__object=undefined) {
var _frl__objectIndex = ds_list_find_index(global.fr_module_vars[$ "area:deeplabs"].tubeObjectName, _frl__object);
var _frl__objectVars = ds_list_find_value(global.fr_module_vars[$ "area:deeplabs"].tubeObjectVars, _frl__objectIndex);
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_HugeTube_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__rotRange = scrFRIndexGet(_frl__objectVars, 7);
var _frl__bobRange = scrFRIndexGet(_frl__objectVars, 8);
object = scrFRIndexGet(_frl__objectVars, 0);
;
object_spawntype = scrFRIndexGet(_frl__objectVars, 1);
;
object_mod = scrFRIndexGet(_frl__objectVars, 2);
;
object_throw = scrFRIndexGet(_frl__objectVars, 3);
;
object_debris = scrFRIndexGet(_frl__objectVars, 10);
;
spr_object = scrFRIndexGet(_frl__objectVars, 4);
;
spr_object_index = scrFRIndexGet(_frl__objectVars, 5);
;
object_startangle = scrFRSourceRandom(scrFRIndexGet(_frl__objectVars, 6));
;
object_rotspeed = (scrFRSourceRandomRange(scrFRIndexGet(_frl__rotRange, 0), scrFRIndexGet(_frl__rotRange, 1)) * scrFRSourceChoose(1, (- 1)));
;
object_bobspeed = scrFRSourceRandomRange(scrFRIndexGet(_frl__bobRange, 0), scrFRIndexGet(_frl__bobRange, 1));
;
object_bobheight = scrFRIndexGet(_frl__objectVars, 9);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2536
function fr_Areas_deeplabs_area_gml_ProtoStatueTube_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((_frl__x + 16), (_frl__y + 2), FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ProtoStatueTube";
;
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTube;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeHurt;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeDead;
;
spr_back = global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeBack;
;
spr_object = sprPStat1Idle;
;
spr_object_2 = global.fr_module_vars[$ "area:deeplabs"].sprBigTubeObjects;
;
spr_shadow = shd64B;
;
spr_shadow_y = 9;
;
depth = (- 2);
;
color = make_color_rgb(40, 87, 9);
;
banditRot = scrFRSourceRandom(360);
;
banditRot2 = scrFRSourceRandom(360);
;
banditRot3 = scrFRSourceRandom(360);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndLabsTubeBreak;
;
scrFRMaxHealthWrite(id, 34, "=");
;
hp = max_hp;
;
size = 12;
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskBigTube;
;
image_xscale = 1;
;
team = 0;
;
myStatue = undefined;
;
on_step = fr_Areas_deeplabs_area_gml_ProtoStatueTube_step;
;
on_death = fr_Areas_deeplabs_area_gml_ProtoStatueTube_destroy;
;
scrFRBindDraw(fr_Areas_deeplabs_area_gml_ProtoStatueTube_draw_back, (depth + 1), scrFRSelf(self));
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2576
function fr_Areas_deeplabs_area_gml_ProtoStatueTube_step() {
banditRot += (2 * scrFRSourceScale());
banditRot2 += (3 * scrFRSourceScale());
banditRot3 += (1 * scrFRSourceScale());
}

// Original Areas/deeplabs.area.gml:2581
function fr_Areas_deeplabs_area_gml_ProtoStatueTube_draw_back(_frl__tube=undefined) {
var _frl__bob = (sin((scrFRSourceFrame() * 0.04)) * 4);
var _frl__rotBob = (sin((scrFRSourceFrame() * 0.06)) * 8);
;
if ((! scrFRInstanceExists(_frl__tube))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
{ var __fr_with1 = scrFRWithValues(_frl__tube), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(spr_back, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
var _frl__y = ((y + 5) + _frl__bob);
;
scrFRDrawSpriteExt(spr_object_2, 0, (x - 14), (_frl__y + 7), image_xscale, image_yscale, banditRot, color, image_alpha);
;
scrFRDrawSpriteExt(spr_object, 0, x, _frl__y, image_xscale, image_yscale, _frl__rotBob, color, image_alpha);
;
scrFRDrawSpriteExt(spr_object_2, 0, (x + 12), (_frl__y + 15), image_xscale, image_yscale, banditRot2, color, image_alpha);
;
scrFRDrawSpriteExt(spr_object_2, 0, (x - 12), (_frl__y - 9), (- image_xscale), image_yscale, banditRot3, color, image_alpha);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2598
function fr_Areas_deeplabs_area_gml_ProtoStatueTube_destroy() {
repeat (4) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 45), 45)), (y + scrFRSourceRandomRange((- 45), 45)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprExploderExplo);
}
}
if(__fr_break3) break;
}}
}
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 20), 20)), Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break6) break;
}}
}
repeat (scrFRSourceRandomRange(5, 7)) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeDebris);
;
direction = scrFRSourceRandom(360);
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
repeat (scrFRSourceRandomRange(4, 7)) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeDebrisBig);
;
direction = scrFRSourceRandom(360);
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break12) break;
}}
}
repeat (scrFRSourceRandomRange(6, 9)) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 12), 12)), (y + scrFRSourceRandomRange((- 12), 12)), BloodStreak)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprTubeStreak);
;
depth = (- 3);
;
speed = (4) * timescale;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
}
}
if(__fr_break15) break;
}}
}
scrFRInstanceCreate(x, (y + 22), ProtoStatue);
fr_Areas_deeplabs_area_gml_OOOOUGH_create(x, y);
}

// Original Areas/deeplabs.area.gml:2641
function fr_Areas_deeplabs_area_gml_OOOOUGH_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
on_step = fr_Areas_deeplabs_area_gml_OOOOUGH_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2648
function fr_Areas_deeplabs_area_gml_OOOOUGH_step() {
var _frl__me = scrFRSelf(self);
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Corpse, "sprite_index", global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeDead)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Areas_deeplabs_area_gml_ProtoStauteTubeDeadFront_create(x, (y + 33), scrFRSelf(self));
;
{ var __fr_with4 = scrFRWithValues(_frl__me), __fr_break6=false;
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
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2657
function fr_Areas_deeplabs_area_gml_ProtoStauteTubeDeadFront_create(_frl__x=undefined, _frl__y=undefined, _frl__corpse=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprProtoStatueTubeDeadFront);
image_index = 0;
;
image_speed = (0) * timescale;
;
depth = (- 2);
;
myCorpse = _frl__corpse;
;
on_step = fr_Areas_deeplabs_area_gml_ProtoStauteTubeDeadFront_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2669
function fr_Areas_deeplabs_area_gml_ProtoStauteTubeDeadFront_step() {
if ((! scrFRInstanceExists(myCorpse))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((myCorpse.image_index == 2)) {
{
image_index = 1;
;
}
}
}

// Original Areas/deeplabs.area.gml:2678
function fr_Areas_deeplabs_area_gml_VoltergeistTube_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_voltergeisttube";
;
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTube;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTubeHurt;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprVoltergeistTubeDead;
;
spr_shadow = shd32;
;
spr_shadow_y = 3;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
fr_glow = [32, 64];
;
depth = (- 1);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndHydrantBreak;
;
truemaxhealth = 8;
scrFRMaxHealthWrite(id, (1 / 0), "=");
;
hp = max_hp;
;
trueHealthed = false;
;
on_step = fr_Areas_deeplabs_area_gml_VoltergeistTube_step;
;
on_death = fr_Areas_deeplabs_area_gml_VoltergeistTube_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2708
function fr_Areas_deeplabs_area_gml_VoltergeistTube_step() {
if ((trueHealthed == false)) {
{
if ((distance_to_object(Player) < 320)) {
{
trueHealthed = true;
;
scrFRMaxHealthWrite(id, truemaxhealth, "=");
;
hp = max_hp;
;
on_step = fr_Areas_deeplabs_area_gml_nothing;
;
}
}
}
}
}

// Original Areas/deeplabs.area.gml:2718
function fr_Areas_deeplabs_area_gml_VoltergeistTube_destroy() {
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "Voltergeist_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(5)), "=");
;
armorLock = 5;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Areas/deeplabs.area.gml:2728
function fr_Areas_deeplabs_area_gml_TestSubjectNode_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_subjectNode";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = mskPlasma;
;
if ((frMacro_Areas_deeplabs_area_gml_deeplabsDebug == true)) {
{
sprite_index = scrFRAreaSourceSprite(sprFlakBullet);
;
image_speed = (0) * timescale;
;
image_blend = c_aqua;
;
}
}
active = false;
;
fr_subjectNode = global.fr_module_vars[$ "area:deeplabs"].subjectNodeNum;
;
global.fr_module_vars[$ "area:deeplabs"].subjectNodeNum += 1;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2749
function fr_Areas_deeplabs_area_gml_DeeplabsGenerator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsGenerator";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprGenerator;
;
spr_hurt = global.fr_module_vars[$ "area:deeplabs"].sprGeneratorHurt;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprGeneratorDead;
;
spr_open = global.fr_module_vars[$ "area:deeplabs"].sprGeneratorActive;
;
spr_shadow = shd32;
;
spr_shadow_y = 5;
;
image_xscale = 1;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
mask_index = mskMaggot;
;
scrFRMaxHealthWrite(id, 100, "=");
;
hp = max_hp;
;
team = 0;
;
mytext = scrFRLocalize("ENTER?");
active = false;
;
size = 10;
;
on_step = fr_Areas_deeplabs_area_gml_DeeplabsGenerator_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2783
function fr_Areas_deeplabs_area_gml_DeeplabsGenerator_step() {
if (((active == false) and scrFRPlaceMeeting(x, y, Lightning))) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.prompt_create, mytext)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
on_step = fr_Areas_deeplabs_area_gml_DeeplabsGeneratorPrompt_step;
;
opened = false;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndLightningHit, 0.6, 2);
;
scrFRSoundPitchVolume(sndLightningReload, 0.6, 2);
;
scrFRSoundPitchVolume(sndStrongSpiritLost, 0.4, 0.5);
;
spr_idle = spr_open;
;
}
}
}

// Original Areas/deeplabs.area.gml:2803
function fr_Areas_deeplabs_area_gml_DeeplabsGeneratorPrompt_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((pick != (- 1)) && (opened == false))) {
{
scrFRInstanceCreate(x, y, Portal);
global.fr_module_vars[$ "area:deeplabs"].deeplabsSpecial = true;
;
opened = true;
;
scrFRSoundPlay(sndPortalAppear);
}
}
}

// Original Areas/deeplabs.area.gml:2823
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsFinaleProjectileHandler";
;
on_begin_step = fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_beginstep;
;
on_step = fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2833
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_beginstep() {
if (scrFRInstanceExists(Player)) {
{
if (scrFRInstanceExists(projectile)) {
{
var _frl__inst = scrFRMatchingGT(projectile, "speed", 0);
;
if (array_length(_frl__inst)) {
{ var __fr_with1 = scrFRWithValues(_frl__inst), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((distance_to_object(Player) > 1000) && (distance_to_object(Floor) > 1000))) {
{
scrFRInstanceDestroy();
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
}
}
if (scrFRInstanceExists(UltraBolt)) {
{
if ((!scrFRVariableExists(GameCont, "fr_deeplabs_ultrabolt_floors"))) {
{
GameCont.fr_deeplabs_ultrabolt_floors = [];
;
}
}
{ var __fr_with4 = scrFRWithValues(UltraBolt), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((! scrFRPlaceMeeting(x, y, Floor))) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(0, 0, Floor)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
name = "UltraBoltCoastFix";
;
mask_index = sprBoltTrail;
;
var __fr_other10=scrFROther(other);
x = __fr_other10.x;
;
var __fr_other11=scrFROther(other);
y = __fr_other11.y;
;
xprevious = x;
;
yprevious = y;
;
visible = false;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
array_push(GameCont.fr_deeplabs_ultrabolt_floors, scrFRSelf(self));
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
}
}
}

// Original Areas/deeplabs.area.gml:2869
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleProjectileHandler_step() {
global.fr_module_vars[$ "area:deeplabs"].areaBackgroundPos += scrFRSourceScale();
;
if ((scrFRVariableExists(GameCont, "fr_deeplabs_ultrabolt_floors") && array_length(GameCont.fr_deeplabs_ultrabolt_floors))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(GameCont.fr_deeplabs_ultrabolt_floors, "id")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
GameCont.fr_deeplabs_ultrabolt_floors = [];
;
}
}
}

// Original Areas/deeplabs.area.gml:2881
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsFinaleController";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
global.fr_module_vars[$ "area:deeplabs"].esploded = false;
;
bombStarted = false;
;
bombTimer = 120;
;
dropDowned = false;
;
goalCountdown = 60;
;
goalBomb = false;
;
lastTremorSound = (- 1);
;
exploEffected = false;
;
playedOutro = false;
;
global.fr_module_vars[$ "area:deeplabs"].bombTimer = bombTimer;
;
on_step = fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_step;
;
on_end_step = fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_endstep;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:2910
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_step() {
if (((scrFRInstanceExists(Sniper) || scrFRInstanceExists(Wolf)) || scrFRInstanceExists(Bandit))) {
{
{ var __fr_with1 = scrFRWithValues(Sniper), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object(Player) > 768)) {
{
givekill = 0;
;
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(Wolf), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((distance_to_object(Player) > 768)) {
{
givekill = 0;
;
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(Bandit), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((distance_to_object(Player) > 768)) {
{
givekill = 0;
;
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
if ((bombStarted == true)) {
{
if (frMacro_Areas_deeplabs_area_gml_current_frame_active) {
{
if ((scrFRSourceRandom((45 + bombTimer)) < 1)) {
{
fr_Areas_deeplabs_area_gml_DeeplabsDoTremor(lastTremorSound);
;
}
}
}
}
{ var __fr_with10 = scrFRWithValues(Player), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffDeeplabsSpeedUp"), 4);
;
if ((!scrFRVariableExists(scrFRSelf(self), "fr_deeplabsIMSAFE"))) {
{
fr_deeplabsIMSAFE = false;
;
}
}
fr_deeplabsIMSAFE = scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone);
;
}
}
if(__fr_break12) break;
}}
if ((dropDowned == false)) {
{
if ((global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred == true)) {
{
global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic = scrFRSoundLoop(global.fr_module_vars[$ "area:deeplabs"].musDeeplabs);
;
global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume = audio_sound_get_gain(global.fr_module_vars[$ "area:deeplabs"].sndBlank);
;
scrFRSoundVolume(global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic, global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume);
;
}
} else {
{
scrFRSoundMusic(global.fr_module_vars[$ "area:deeplabs"].musDeeplabs);
;
}
}
scrFRSoundAmbient(global.fr_module_vars[$ "area:deeplabs"].sndBlank2);
;
dropDowned = true;
;
{ var __fr_with13 = scrFRWithValues(scrFRBindDraw(fr_Areas_deeplabs_area_gml_DeeplabsFinaleDropdown_draw, (- 1000))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
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
if(__fr_break15) break;
}}
}
}
bombTimer -= (scrFRSourceScale() / 30);
;
global.fr_module_vars[$ "area:deeplabs"].bombTimer = bombTimer;
;
if (((goalBomb == true) && (bombTimer >= 2.5))) {
{
global.fr_module_vars[$ "area:deeplabs"].bombText = scrFRSourceChoose("@r!:X?:!=", "@rX:?!:X?", "@r=:+X:?X");
;
}
} else {
{
global.fr_module_vars[$ "area:deeplabs"].bombText = ((((("@r" + scrFRStringLPad(string(floor(((bombTimer / power(60, 1)) % 60))), "-1", 2)) + ":") + scrFRStringLPad(string(floor(((bombTimer / power(60, 0)) % 60))), "0", 2)) + ":") + scrFRStringLPad(string(floor(((bombTimer / power(100, (- 1))) % 100))), "0", 2));
}
}
if ((array_length(scrFRMatching(Player, "fr_deeplabsIMSAFE", true)) == scrFRInstanceNumber(Player))) {
{
if ((! scrFRInstanceExists(Player))) {
{
if ((global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred == true)) {
{
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic);
;
}
}
}
}
goalCountdown -= scrFRSourceScale();
;
}
}
if (((goalCountdown <= 0) && (goalBomb == false))) {
{
goalBomb = true;
;
if ((bombTimer > 3)) {
{
bombTimer = 3;
;
}
}
}
}
if ((global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred == true)) {
{
if ((audio_sound_get_gain(global.fr_module_vars[$ "area:deeplabs"].sndBlank) != global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume)) {
{
global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume = audio_sound_get_gain(global.fr_module_vars[$ "area:deeplabs"].sndBlank);
;
scrFRSoundVolume(global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic, global.fr_module_vars[$ "area:deeplabs"].deeplabsMusicVolume);
;
}
}
}
}
if ((playedOutro == false)) {
{
if ((bombTimer <= 2.8)) {
{
playedOutro = true;
;
if (scrFRInstanceExists(Player)) {
{
if ((global.fr_module_vars[$ "area:deeplabs"].settingVeeOneHundred == true)) {
{
scrFRSoundPitchVolume(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsOutro, 1, audio_sound_get_gain(global.fr_module_vars[$ "area:deeplabs"].sndBlank));
;
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].deeplabsMusic);
;
scrFRSoundAmbient(global.fr_module_vars[$ "area:deeplabs"].ambDeeplabs);
;
}
} else {
{
scrFRSoundPitchVolume(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsOutro, 1, audio_sound_get_gain(global.fr_module_vars[$ "area:deeplabs"].musDeeplabs));
;
scrFRSoundMusic(global.fr_module_vars[$ "area:deeplabs"].sndBlank);
;
scrFRSoundAmbient(global.fr_module_vars[$ "area:deeplabs"].ambDeeplabs);
;
}
}
}
}
}
}
}
}
if ((bombTimer <= 0)) {
{
if ((exploEffected == false)) {
{
exploEffected = true;
;
TopCont.fog = (- 1);
;
fr_Areas_deeplabs_area_gml_ExploEffect_create(x, y);
;
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].panelSound);
;
scrFRSoundMusic(global.fr_module_vars[$ "area:deeplabs"].sndBlank);
;
scrFRSoundPitchVolume(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreExplosion, (0.95 + scrFRSourceRandom(0.2)), 1.5);
;
{ var __fr_with16 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsEndRoof")), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
notYet = false;
;
canfade = true;
;
image_alpha = 15;
;
}
}
if(__fr_break18) break;
}}
}
}
global.fr_module_vars[$ "area:deeplabs"].bombText = "@rX:XX:XX";
if ((bombTimer <= (- 1))) {
{
bombStarted = false;
;
global.fr_module_vars[$ "area:deeplabs"].esploded = true;
;
{ var __fr_with19 = scrFRWithValues(hitme), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
if ((! scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone))) {
{
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
lasthit = [global.fr_module_vars[$ "area:deeplabs"].sprDangerScreen, "CORE DETONATION"];
;
hp = 0;
;
scrFRInstanceDestroy();
;
}
} else {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
}
}
if(__fr_break21) break;
}}
{ var __fr_with22 = scrFRWithValues(scrFRMatching([FRCustomObject, FR_OBJECT_EFFECT], "fr_coreDetoKill", true)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(scrFRMatching([FRCustomObject, FR_OBJECT_EFFECT], "fr_coreDetoKill", false)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
if (scrFRVariableExists(scrFRSelf(self), "spr_charred")) {
{
sprite_index = scrFRAreaSourceSprite(spr_charred);
;
}
}
}
}
if(__fr_break27) break;
}}
{ var __fr_with28 = scrFRWithValues(scrFRMatching(FRCustomProjectile, "name", "fr_DeeplabsBarrierZapper")), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break30) break;
}}
{ var __fr_with31 = scrFRWithValues(WepPickup), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
if ((! scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break33) break;
}}
{ var __fr_with34 = scrFRWithValues(chestprop), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
if ((! scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break36) break;
}}
{ var __fr_with37 = scrFRWithValues(Corpse), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
if ((! scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break39) break;
}}
{ var __fr_with40 = scrFRWithValues(Floor), __fr_break42=false;
for (var __fr_index41=0; __fr_index41<array_length(__fr_with40); ++__fr_index41) {
if(scrFRScopeExists(__fr_with40[__fr_index41])) with (__fr_with40[__fr_index41]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_endroom"))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break42) break;
}}
{ var __fr_with43 = scrFRWithValues(Wall), __fr_break45=false;
for (var __fr_index44=0; __fr_index44<array_length(__fr_with43); ++__fr_index44) {
if(scrFRScopeExists(__fr_with43[__fr_index44])) with (__fr_with43[__fr_index44]) {
{
if ((! scrFRPlaceMeeting(x, y, global.fr_module_vars[$ "area:deeplabs"].safeZone))) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
}
}
if(__fr_break45) break;
}}
{ var __fr_with46 = scrFRWithValues(global.fr_module_vars[$ "area:deeplabs"].safeZone), __fr_break48=false;
for (var __fr_index47=0; __fr_index47<array_length(__fr_with46); ++__fr_index47) {
if(scrFRScopeExists(__fr_with46[__fr_index47])) with (__fr_with46[__fr_index47]) {
{
scrFRInstanceCreate(x, (y + 144), InvisiWall);
;
scrFRInstanceCreate((x - 16), (y + 144), InvisiWall);
;
{ var __fr_with49 = scrFRWithValues(scrFRInstanceCreate(x, (y + 112), FRCustomObject)), __fr_break51=false;
for (var __fr_index50=0; __fr_index50<array_length(__fr_with49); ++__fr_index50) {
if(scrFRScopeExists(__fr_with49[__fr_index50])) with (__fr_with49[__fr_index50]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprFloorCatwalkDestroyed);
;
depth = 9;
;
}
}
if(__fr_break51) break;
}}
fr_Areas_deeplabs_area_gml_SmokeFader_create(x, y);
;
fr_Areas_deeplabs_area_gml_SmokeGeyser_create((x - 112), (y - 80));
;
fr_Areas_deeplabs_area_gml_SmokeGeyser_create((x - 128), (y + 16));
;
fr_Areas_deeplabs_area_gml_SmokeGeyser_create((x - 96), (y + 96));
;
fr_Areas_deeplabs_area_gml_SmokeGeyser_create((x + 64), (y + 180));
;
}
}
if(__fr_break48) break;
}}
{ var __fr_with52 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsCache")), __fr_break54=false;
for (var __fr_index53=0; __fr_index53<array_length(__fr_with52); ++__fr_index53) {
if(scrFRScopeExists(__fr_with52[__fr_index53])) with (__fr_with52[__fr_index53]) {
{
active = true;
;
}
}
if(__fr_break54) break;
}}
{ var __fr_with55 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsEndElevator")), __fr_break57=false;
for (var __fr_index56=0; __fr_index56<array_length(__fr_with55); ++__fr_index56) {
if(scrFRScopeExists(__fr_with55[__fr_index56])) with (__fr_with55[__fr_index56]) {
{
startArrive = true;
;
}
}
if(__fr_break57) break;
}}
}
}
}
}
}
}
}

// Original Areas/deeplabs.area.gml:3135
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleController_endstep() {
{ var __fr_with1 = scrFRWithValues(enemy), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRPlaceMeeting(x, y, InvisiWall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(FR_OBJECT_PICKUP), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRPlaceMeeting(x, y, InvisiWall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(chestprop), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRPlaceMeeting(x, y, InvisiWall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(Debris), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if (scrFRPlaceMeeting(x, y, InvisiWall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
}
}
if(__fr_break12) break;
}}
}

// Original Areas/deeplabs.area.gml:3186
function fr_Areas_deeplabs_area_gml_DeeplabsFinaleDropdown_draw(_frl__controller=undefined) {
if (scrFRInstanceExists(Player)) {
{
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
if ((global.fr_module_vars[$ "area:deeplabs"].esploded == true)) {
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
height -= ((3 + fr_callback__dropdownExtraSpeed) * scrFRSourceScale());
;
}
}
}
}
if ((height <= (- 50))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
scrFRDrawSprite(global.fr_module_vars[$ "area:deeplabs"].sprBombTimerBack, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + height));
;
scrFRDrawSpriteExt(global.fr_module_vars[$ "area:deeplabs"].sprBombTimer, 0, (scrFRViewCoordinate(0) + (view_width / 2)), ((scrFRViewCoordinate(1) + height) + bounceHeight), 1, 1, 0, c_white, 1);
;
scrFRDrawText((scrFRViewCoordinate(0) + (view_width / 2)), (((scrFRViewCoordinate(1) + height) + bounceHeight) + 12), global.fr_module_vars[$ "area:deeplabs"].bombText);
;
}
}
}

// Original Areas/deeplabs.area.gml:3239
function fr_Areas_deeplabs_area_gml_RoomDecalFront_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecal";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_speed = (0.4) * timescale;
;
depth = (- 4);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3254
function fr_Areas_deeplabs_area_gml_RoomDecalBack_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecal";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_speed = (0.4) * timescale;
;
depth = 8;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3269
function fr_Areas_deeplabs_area_gml_RoomDecalStructure_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecal";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_speed = (0.4) * timescale;
;
depth = 9;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3284
function fr_Areas_deeplabs_area_gml_RoomDecalStructureExtra_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined, _frl__spd=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecal";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_speed = (_frl__spd) * timescale;
;
depth = 8;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3299
function fr_Areas_deeplabs_area_gml_RoomDecalStructureExtraBomb_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined, _frl__pre_sprite=undefined, _frl__spd=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecalBombChange";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__pre_sprite);
;
spr_postBomb = _frl__sprite;
;
image_speed = (0.4) * timescale;
;
depth = 8;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3315
function fr_Areas_deeplabs_area_gml_RoomDecalStructureFront_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecal";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
image_speed = (0.4) * timescale;
;
depth = 11;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3330
function fr_Areas_deeplabs_area_gml_RoomDecalCore_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomDecalCore";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprCoreIdle;
;
spr_uhoh = global.fr_module_vars[$ "area:deeplabs"].sprCoreDanger;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = 9;
;
fr_coreDetoKill = true;
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 35), (y + 67), scrFRSelf(self), 3, 0);
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 64), (y + 67), scrFRSelf(self), 3, 0);
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 28), (y + 53), scrFRSelf(self), 2, 1);
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 71), (y + 54), scrFRSelf(self), 2, 1);
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 25), (y + 41), scrFRSelf(self), 2, 2);
;
fr_Areas_deeplabs_area_gml_CoreEye_create((x - 75), (y + 42), scrFRSelf(self), 2, 2);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3356
function fr_Areas_deeplabs_area_gml_RoomDecalCore_activate() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsCoreEye")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsCoreEyeCover")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(spr_end);
;
image_index = 0;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsRoomDecalCore")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(spr_uhoh);
;
}
}
if(__fr_break9) break;
}}
frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.save_set, "Frontier", "deeplabs_finales", (frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.save_get, "Frontier", "deeplabs_finales") + 1));
;
}

// Original Areas/deeplabs.area.gml:3371
function fr_Areas_deeplabs_area_gml_CoreEyeCover_create(_frl__x=undefined, _frl__y=undefined, _frl__core=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsCoreEyeCover";
mask_index = mskBandit;
;
spr_strt = global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCoverStrt;
;
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCover;
;
spr_end = global.fr_module_vars[$ "area:deeplabs"].sprCoreEyeCoverEnd;
;
sprite_index = scrFRAreaSourceSprite(spr_strt);
;
didIt = false;
;
image_index = 0;
;
image_speed = (0) * timescale;
;
depth = 7;
;
myCore = _frl__core;
;
soundCooldown = 0;
;
lastSound = (- 1);
;
on_step = fr_Areas_deeplabs_area_gml_CoreEyeCover_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3395
function fr_Areas_deeplabs_area_gml_CoreEyeCover_step() {
if ((didIt == false)) {
{
if (scrFRInstanceExists(Player)) {
{
var _frl__nearestPlayer = instance_nearest(myCore.x, myCore.y, Player);
;
{ var __fr_with1 = scrFRWithValues(_frl__nearestPlayer), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object((scrFROther(other)).myCore) < 56)) {
{
var __fr_other4=scrFROther(other);
__fr_other4.image_speed = (0.4) * timescale;
;
var __fr_other5=scrFROther(other);
__fr_other5.didIt = true;
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
} else {
{
if ((sprite_index == spr_strt)) {
{
if ((image_index >= (image_number - 1))) {
{
{ var __fr_with6 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsCoreEye")), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
moveSpeed = 2;
;
canGo = true;
;
}
}
if(__fr_break8) break;
}}
}
}
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
}
}
if (scrFRInstanceExists(Player)) {
{
if ((distance_to_object(Player) < 224)) {
{
if ((soundCooldown > 0)) {
{
soundCooldown -= scrFRSourceScale();
;
}
} else {
{
if ((scrFRSourceRandom(120) < 1)) {
{
soundCooldown += 60;
;
var _frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreIdle) - 1));
;
if ((_frl__sound == lastSound)) {
{
_frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreIdle) - 1));
;
}
}
lastSound = _frl__sound;
;
scrFRSoundPitch(scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreIdle, _frl__sound), (1 + scrFRSourceRandomRange((- 0.1), 0.1)));
;
}
}
}
}
}
}
}
}
if ((sprite_index == spr_end)) {
{
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Areas/deeplabs.area.gml:3446
function fr_Areas_deeplabs_area_gml_CoreEye_create(_frl__x=undefined, _frl__y=undefined, _frl__core=undefined, _frl__range=undefined, _frl__eyeIndex=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, (_frl__y - 45), FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsCoreEye";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprCorePupil);
;
image_index = _frl__eyeIndex;
;
image_speed = (0) * timescale;
;
depth = 8;
;
creator = _frl__core;
;
xPos = _frl__x;
;
yPos = _frl__y;
;
xgoal = _frl__x;
;
ygoal = _frl__y;
;
moveSpeed = 0;
;
distance = _frl__range;
;
eyepos = 0;
canGo = false;
;
on_step = fr_Areas_deeplabs_area_gml_CoreEye_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3469
function fr_Areas_deeplabs_area_gml_CoreEye_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (scrFRInstanceExists(Player)) {
{
var _frl__player = instance_nearest(creator.x, creator.y, Player);
{
eyepos = point_direction(x, y, _frl__player.x, _frl__player.y);
;
}
}
}
if ((canGo == true)) {
{
x += (fr_Areas_deeplabs_area_gml_approach(x, xgoal, moveSpeed, (0.3 * scrFRSourceScale())) - lengthdir_x(0, eyepos));
y += (fr_Areas_deeplabs_area_gml_approach(y, ygoal, moveSpeed, (0.3 * scrFRSourceScale())) - lengthdir_y(0, eyepos));
xgoal = (xPos + lengthdir_x(distance, eyepos));
ygoal = ((yPos + lengthdir_y(distance, eyepos)) - 45);
;
}
}
}

// Original Areas/deeplabs.area.gml:3488
function fr_Areas_deeplabs_area_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Areas/deeplabs.area.gml:3491
function fr_Areas_deeplabs_area_gml_EndRoomRoof_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsEndRoof";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprEndRoomRoof);
;
spr_charred = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomRoofCharred;
;
spr_forcefield = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomForcefield;
;
image_speed = (0.4) * timescale;
;
depth = (- 11);
;
fr_endRoom = true;
;
canfade = true;
;
notYet = true;
;
fr_coreDetoKill = false;
;
on_step = fr_Areas_deeplabs_area_gml_EndRoomRoof_step;
;
on_draw = fr_Areas_deeplabs_area_gml_EndRoomRoof_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3520
function fr_Areas_deeplabs_area_gml_EndRoomRoof_step() {
if (((notYet == true) && (global.fr_module_vars[$ "area:deeplabs"].bombTimer <= 2))) {
{
canfade = false;
;
}
}
if (((canfade == true) && scrFRPlaceMeeting(x, y, Player))) {
{
if ((image_alpha > 0)) {
{
image_alpha -= (0.1 * scrFRSourceScale());
;
}
}
}
} else {
{
if ((image_alpha < 1)) {
{
image_alpha += (0.1 * scrFRSourceScale());
;
}
}
}
}
}

// Original Areas/deeplabs.area.gml:3563
function fr_Areas_deeplabs_area_gml_EndRoomRoof_draw() {
scrFRDrawSpriteExt(spr_forcefield, (scrFRSourceFrame() * 0.4), (x + 112), (y + 249), 1, 1, 0, c_white, clamp(image_alpha, 0, 0.6));
;
scrFRDrawSpriteExt(spr_forcefield, (scrFRSourceFrame() * 0.4), (x + 112), (y + 249), 1.1, 1.1, 0, c_white, clamp(image_alpha, 0, 0.2));
;
}

// Original Areas/deeplabs.area.gml:3567
function fr_Areas_deeplabs_area_gml_EndRoomStupid_create() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_stupidCrapForMorons";
;
{ var __fr_switch_value4=frMacro_Areas_deeplabs_area_gml_roomDirEnd, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("right")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("up")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("down")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
stupidX = (frMacro_Areas_deeplabs_area_gml_roomX + 288);
;
stupidY = (frMacro_Areas_deeplabs_area_gml_roomY - 320);
;
break;
;
case 1:
stupidX = (frMacro_Areas_deeplabs_area_gml_roomX + 96);
;
stupidY = (frMacro_Areas_deeplabs_area_gml_roomY - 256);
;
break;
;
case 2:
stupidX = (frMacro_Areas_deeplabs_area_gml_roomX + 416);
;
stupidY = (frMacro_Areas_deeplabs_area_gml_roomY - 192);
;
break;
;
}
}
on_step = fr_Areas_deeplabs_area_gml_EndRoomStupid_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3594
function fr_Areas_deeplabs_area_gml_EndRoomStupid_step() {
fr_Areas_deeplabs_area_gml_scrFloorFillStupid(stupidX, stupidY, 2, 7);
;
fr_Areas_deeplabs_area_gml_scrFloorFillStupid((stupidX - 224), stupidY, 2, 7);
;
fr_Areas_deeplabs_area_gml_scrFloorFillStupid((stupidX - 96), (stupidY - 128), 9, 2);
;
fr_Areas_deeplabs_area_gml_scrFloorFillStupid((stupidX - 96), (stupidY + 96), 9, 2);
;
var _frl__wallOffX = 0;
;
_frl__wallOffY = 0;
;
repeat (4) {
var _frl__wallOffY = 0;
;
repeat (18) {
scrFRInstanceCreate((stupidX + _frl__wallOffX), ((stupidY + _frl__wallOffY) - 128), InvisiWall);
;
_frl__wallOffY += 16;
;
}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
_frl__wallOffY = 0;
;
repeat (4) {
var _frl__wallOffY = 0;
;
repeat (18) {
scrFRInstanceCreate(((stupidX + _frl__wallOffX) - 224), ((stupidY + _frl__wallOffY) - 128), InvisiWall);
;
_frl__wallOffY += 16;
;
}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
_frl__wallOffY = 0;
;
repeat (18) {
var _frl__wallOffY = 0;
;
repeat (4) {
scrFRInstanceCreate(((stupidX + _frl__wallOffX) - 224), ((stupidY + _frl__wallOffY) - 128), InvisiWall);
;
_frl__wallOffY += 16;
;
}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
_frl__wallOffY = 0;
;
repeat (4) {
var _frl__wallOffY = 0;
;
repeat (4) {
scrFRInstanceCreate(((stupidX + _frl__wallOffX) - 160), ((stupidY + _frl__wallOffY) + 96), InvisiWall);
;
_frl__wallOffY += 16;
;
}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
_frl__wallOffY = 0;
;
repeat (4) {
var _frl__wallOffY = 0;
;
repeat (4) {
scrFRInstanceCreate(((stupidX + _frl__wallOffX) - 64), ((stupidY + _frl__wallOffY) + 96), InvisiWall);
;
_frl__wallOffY += 16;
;
}
_frl__wallOffX += 16;
;
}
fr_Areas_deeplabs_area_gml_EndRoomWallHandler_create(stupidX, stupidY);
;
scrFRInstanceDestroy();
;
}

// Original Areas/deeplabs.area.gml:3669
function fr_Areas_deeplabs_area_gml_EndRoomWallHandler_create(_frl__stupidX=undefined, _frl__stupidY=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_whateverman";
;
on_end_step = fr_Areas_deeplabs_area_gml_EndRoomWallHandler_endstep;
;
stupidX = _frl__stupidX;
;
stupidY = _frl__stupidY;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3680
function fr_Areas_deeplabs_area_gml_EndRoomWallHandler_endstep() {
if ((array_length(scrFRMatching(Wall, "fr_woahwow", true)) < 42)) {
{
if ((! scrFRInstanceExists(Portal))) {
{
var _frl__wallOffY = 0;
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(stupidX, ((stupidY + _frl__wallOffY) - 80), Wall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
fr_woahwow = true;
;
}
}
if(__fr_break3) break;
}}
_frl__wallOffY += 16;
;
}
var _frl__wallOffY = 0;
;
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((stupidX - 176), ((stupidY + _frl__wallOffY) - 80), Wall)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
fr_woahwow = true;
;
}
}
if(__fr_break6) break;
}}
_frl__wallOffY += 16;
;
}
var _frl__wallOffX = 0;
;
repeat (10) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(((stupidX - 160) + _frl__wallOffX), (stupidY - 80), Wall)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
fr_woahwow = true;
;
}
}
if(__fr_break9) break;
}}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
repeat (4) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(((stupidX - 160) + _frl__wallOffX), (stupidY + 96), Wall)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
fr_woahwow = true;
;
}
}
if(__fr_break12) break;
}}
_frl__wallOffX += 16;
;
}
var _frl__wallOffX = 0;
;
repeat (4) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(((stupidX - 64) + _frl__wallOffX), (stupidY + 96), Wall)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
topspr = mskNone;
;
outspr = mskNone;
;
fr_woahwow = true;
;
}
}
if(__fr_break15) break;
}}
_frl__wallOffX += 16;
;
}
}
}
}
}
}

// Original Areas/deeplabs.area.gml:3746
function fr_Areas_deeplabs_area_gml_DeeplabsCorePanel_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsCorePanel";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsIdle;
;
spr_strt = global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsSpill;
;
spr_active = global.fr_module_vars[$ "area:deeplabs"].sprCoreControlsDanger;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
mytext = scrFRLocalize("SPILL?");
active = false;
;
bombStarted = false;
;
fr_coreDetoKill = true;
;
on_step = fr_Areas_deeplabs_area_gml_DeeplabsCorePanel_step;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Areas_deeplabs_area_gml_DeeplabsCorePanelPrompt_step;
;
used = false;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskCoreControls;
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

// Original Areas/deeplabs.area.gml:3777
function fr_Areas_deeplabs_area_gml_DeeplabsCorePanel_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((active == true)) {
{
if (((sprite_index == spr_strt) && (bombStarted == false))) {
{
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsFinaleController")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bombStarted = true;
;
}
}
if(__fr_break3) break;
}}
bombStarted = true;
;
sprite_index = scrFRAreaSourceSprite(spr_active);
;
image_index = 0;
;
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].panelSound);
;
global.fr_module_vars[$ "area:deeplabs"].panelSound = scrFRSoundLoop(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreControlsDanger);
;
{ var __fr_with4 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_PanelSoundController")), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
soundRange = dangerSoundRange;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsBarrier"), "fr_starterBarrier", true)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_Areas_deeplabs_area_gml_Barrier_deactivate();
;
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_deeplabsRoomDecalBombChange")), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(spr_postBomb);
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
}

// Original Areas/deeplabs.area.gml:3809
function fr_Areas_deeplabs_area_gml_DeeplabsCorePanelPrompt_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((pick != (- 1)) && (used == false))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
active = true;
;
sprite_index = scrFRAreaSourceSprite(spr_strt);
image_index = 0;
;
scrFRSoundPlay(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsSpill);
;
fr_Areas_deeplabs_area_gml_RoomDecalCore_activate();
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
{ var __fr_with4 = scrFRWithValues(creator), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (active) {
{
{ var __fr_with7 = scrFRWithValues((scrFROther(other))), __fr_break9=false;
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
}
if(__fr_break6) break;
}}
}

// Original Areas/deeplabs.area.gml:3837
function fr_Areas_deeplabs_area_gml_SafeZone_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsSafeZone";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].mskRoomHitbox);
;
image_alpha = (frMacro_Areas_deeplabs_area_gml_deeplabsDebug ? 0.2 : 0);
;
image_xscale = 5;
;
image_yscale = 5.5;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3849
function fr_Areas_deeplabs_area_gml_EndRoomElevator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsEndElevator";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorIdle;
;
spr_arrive = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorArrive;
;
spr_open = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorOpen;
;
spr_cover_open = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverOpen;
;
spr_leave = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorLeave;
;
spr_cover_leave = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverLeave;
;
spr_cover_gone = global.fr_module_vars[$ "area:deeplabs"].sprEndRoomElevatorCoverGone;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_cover = mskNone;
;
image_speed = (0.6) * timescale;
;
depth = 5;
;
mytext = scrFRLocalize("EXIT");
arrived = false;
;
leftthestation = false;
;
leaveTime = 90;
;
spawnedPortal = false;
;
launchedPod = false;
;
arrivalTime = 270;
;
startArrive = false;
;
musicks = false;
;
on_step = fr_Areas_deeplabs_area_gml_EndRoomElevator_step;
;
{ var __fr_with4 = scrFRWithValues(scrFRBindDraw(fr_Areas_deeplabs_area_gml_EndRoomElevatorCover_draw, (- 5), scrFRSelf(self))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
x = __fr_other7.x;
;
var __fr_other8=scrFROther(other);
y = __fr_other8.y;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, (y + 16), InvisiWall)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
fr_elevwall = true;
;
}
}
if(__fr_break11) break;
}}
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate((x - 16), (y + 16), InvisiWall)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
fr_elevwall = true;
;
}
}
if(__fr_break14) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:3899
function fr_Areas_deeplabs_area_gml_EndRoomElevator_step() {
if ((arrived == false)) {
{
if ((startArrive == true)) {
{
if ((arrivalTime > 0)) {
{
if ((arrivalTime <= 100)) {
{
if ((musicks == false)) {
{
musicks = true;
;
if (scrFRInstanceExists(Player)) {
{
scrFRSoundMusic(global.fr_module_vars[$ "area:deeplabs"].musDeeplabsAftermath);
;
}
}
}
}
}
}
arrivalTime -= scrFRSourceScale();
;
}
} else {
{
startArrive = false;
;
if ((sprite_index != spr_arrive)) {
{
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_arrive);
;
repeat (10) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, ((y + scrFRSourceRandomRange((- 8), 8)) + 16), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRModGet("mod", "Frontier_Labs", "sprWhiteSmoke"));
;
direction = scrFRSourceChoose(90, 270);
speed = (3) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
if (scrFRInstanceExists(Player)) {
{
scrFRSoundPitch(sndToxicBoltGas, (0.75 + scrFRSourceRandom(0.1)));
;
}
}
}
}
}
}
}
}
if ((sprite_index == spr_arrive)) {
{
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
arrived = true;
;
if (scrFRInstanceExists(Player)) {
{
scrFRSoundPitchVolume(sndCursedReminder, 3, 2);
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_open);
;
spr_cover = spr_cover_open;
image_index = 0;
;
{ var __fr_with4 = scrFRWithValues(scrFRMatching(InvisiWall, "fr_elevwall", true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.prompt_create, mytext)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
on_step = fr_Areas_deeplabs_area_gml_EndRoomElevatorPrompt_step;
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
} else {
{
if ((sprite_index == spr_leave)) {
{
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_cover = spr_cover_gone;
;
leftthestation = true;
;
}
}
}
}
if ((leftthestation == true)) {
{
{ var __fr_with11 = scrFRWithValues(Player), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
var __fr_other14=scrFROther(other);
x = __fr_other14.x;
;
var __fr_other15=scrFROther(other);
y = __fr_other15.y;
;
}
}
if(__fr_break13) break;
}}
if ((leaveTime > 0)) {
{
leaveTime -= scrFRSourceScale();
;
if ((leaveTime < 60)) {
{
if ((launchedPod == false)) {
{
launchedPod = true;
;
fr_Areas_deeplabs_area_gml_EndRoomPod_create(x, y);
;
GameCont.fr_deeplabsDecal = true;
;
scrFRSoundPitchVolume(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsPodFly, 1, 1.5);
;
scrFRSoundPitch(sndExplosionS, 0.7);
;
scrFRSoundPitch(sndClusterLauncher, 0.7);
;
}
}
}
}
}
} else {
{
if ((spawnedPortal == false)) {
{
spawnedPortal = true;
;
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate(x, y, Portal)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
image_alpha = 0;
;
}
}
if(__fr_break18) break;
}}
scrFRSoundPitch(sndExplosionS, 0.8);
{ var __fr_with19 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_endroompod")), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
repeat (15) {
{ var __fr_with22 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
growspeed = 0.25;
;
var __fr_other25=scrFROther(other);
depth = (__fr_other25.depth + 1);
;
direction = (270 + scrFRSourceRandomRange((- 50), 50));
;
speed = ((6 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break24) break;
}}
}
}
}
if(__fr_break21) break;
}}
}
}
}
}
}
}
}
}
}

// Original Areas/deeplabs.area.gml:4008
function fr_Areas_deeplabs_area_gml_EndRoomElevatorCover_draw(_frl__elevator=undefined) {
scrFRDrawSprite(_frl__elevator.spr_cover, _frl__elevator.image_index, x, y);
}

// Original Areas/deeplabs.area.gml:4011
function fr_Areas_deeplabs_area_gml_EndRoomElevatorPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(spr_leave);
;
spr_cover = spr_cover_leave;
;
scrFRSoundPitchVolume(sndCursedReminder, 1.5, 2);
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y + 16), InvisiWall)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_elevwall = true;
;
}
}
if(__fr_break6) break;
}}
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x - 16), (y + 16), InvisiWall)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_elevwall = true;
;
}
}
if(__fr_break9) break;
}}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/deeplabs.area.gml:4030
function fr_Areas_deeplabs_area_gml_EndRoomPod_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_endroompod";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprEndRoomPod);
;
depth = 12;
;
direction = 90;
;
speed = (14) * timescale;
;
friction = ((- 0.01)) * (timescale * timescale);
;
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
scrFRViewSet("object", index, __fr_other7, "=");
;
}
}
if(__fr_break6) break;
}}
on_step = fr_Areas_deeplabs_area_gml_EndRoomPod_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4050
function fr_Areas_deeplabs_area_gml_EndRoomPod_step() {
if (((speed / timescale) > 14.08)) {
{
depth = (- 12);
;
}
}
if (frMacro_Areas_deeplabs_area_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
growspeed = 0.25;
;
depth = 16;
;
direction = (270 + scrFRSourceRandomRange((- 12), 12));
;
speed = (5) * timescale;
;
}
}
if(__fr_break3) break;
}}
repeat (2) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 16), 16)), BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(sprGroundFlameDisappear, sprGroundFlameBigDisappear, sprTrapFire));
;
image_speed = (0.25) * timescale;
;
direction = (270 + scrFRSourceRandomRange((- 24), 24));
image_angle = scrFRSourceRandom(360);
;
speed = (6) * timescale;
;
image_yscale = (- scrFRSourceRandomRange(1, 1.5));
depth = 15;
;
}
}
if(__fr_break6) break;
}}
}
}
}
}

// Original Areas/deeplabs.area.gml:4077
function fr_Areas_deeplabs_area_gml_Barrier_create(_frl__x=undefined, _frl__y=undefined, _frl__horizontal=undefined, _frl__spawnHitbox=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsBarrier";
sprite_index = scrFRAreaSourceSprite((_frl__horizontal ? global.fr_module_vars[$ "area:deeplabs"].sprBarrier : global.fr_module_vars[$ "area:deeplabs"].sprBarrierVertical));
;
spr_inactive = (_frl__horizontal ? global.fr_module_vars[$ "area:deeplabs"].sprBarrierOff : global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalOff);
;
vertical = _frl__horizontal;
;
image_speed = (0.4) * timescale;
;
playSound = true;
;
solvedMyRiddles = false;
;
myZapper = noone;
;
myBack = noone;
;
enemyMode = false;
;
enemyModeTime = 750;
startHitbox = _frl__spawnHitbox;
;
fr_coreDetoKill = true;
;
if ((! _frl__horizontal)) {
{
myBack = fr_Areas_deeplabs_area_gml_BarrierBack_create(x, y, vertical);
;
depth = (- 3);
;
}
}
on_step = fr_Areas_deeplabs_area_gml_Barrier_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4106
function fr_Areas_deeplabs_area_gml_Barrier_step() {
if ((solvedMyRiddles == false)) {
{
if ((! scrFRInstanceExists(myZapper))) {
{
myZapper = fr_Areas_deeplabs_area_gml_BarrierZapper_create(x, y, vertical, scrFRSelf(self));
;
}
}
if ((enemyMode == true)) {
{
if ((enemyModeTime > 0)) {
{
enemyModeTime -= scrFRSourceScale();
;
}
}
if (((enemyModeTime <= 0) || (array_length(scrFRMatching(enemy, "fr_myBarrier", scrFRSelf(self))) <= 0))) {
{
fr_Areas_deeplabs_area_gml_Barrier_deactivate();
;
}
}
}
}
}
}
}

// Original Areas/deeplabs.area.gml:4122
function fr_Areas_deeplabs_area_gml_Barrier_deactivate() {
solvedMyRiddles = true;
;
sprite_index = scrFRAreaSourceSprite(spr_inactive);
;
if (scrFRInstanceExists(myBack)) {
{
{ var __fr_with1 = scrFRWithValues(myBack), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(spr_inactive);
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(enemy, "fr_myBarrier", scrFRSelf(self))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_myBarrier = undefined;
;
}
}
if(__fr_break6) break;
}}
if ((playSound == true)) {
{
if ((distance_to_object(Player) < 512)) {
{
scrFRSoundPlay(global.fr_module_vars[$ "area:deeplabs"].sndPuzzleCompleted);
;
scrFRSoundPitchVolume(sndLightningHit, (1 + scrFRSourceRandom(0.2)), 1);
;
}
}
}
}
if (scrFRInstanceExists(myZapper)) {
{
{ var __fr_with7 = scrFRWithValues(myZapper), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
repeat (6) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].sprBarrierFizzle, __fr_other13.image_index));
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break12) break;
}}
}
scrFRInstanceDestroy();
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Areas/deeplabs.area.gml:4160
function fr_Areas_deeplabs_area_gml_BarrierBack_create(_frl__x=undefined, _frl__y=undefined, _frl__horizontal=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsBarrierBack";
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalBack);
;
spr_inactive = global.fr_module_vars[$ "area:deeplabs"].sprBarrierVerticalBackOff;
;
depth = 0;
;
image_speed = (0.4) * timescale;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4174
function fr_Areas_deeplabs_area_gml_BarrierZapper_create(_frl__x=undefined, _frl__y=undefined, _frl__vertical=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsBarrierZapper";
sprite_index = scrFRAreaSourceSprite((_frl__vertical ? global.fr_module_vars[$ "area:deeplabs"].sprBarrierZapper : global.fr_module_vars[$ "area:deeplabs"].sprBarrierZapperVertical));
;
fr_bloom = (_frl__vertical ? [2, 0.1] : [1.2, 0.1]);
;
depth = (- 3);
;
image_speed = (0.4) * timescale;
;
image_index = _frl__creator.image_index;
;
mask_index = (_frl__vertical ? global.fr_module_vars[$ "area:deeplabs"].mskBarrierZapper : global.fr_module_vars[$ "area:deeplabs"].mskBarrierZapperVertical);
;
damage = 6;
;
on_hit = fr_Areas_deeplabs_area_gml_BarrierZapper_hit;
;
on_wall = fr_Areas_deeplabs_area_gml_nothing;
;
team = 9910;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4195
function fr_Areas_deeplabs_area_gml_BarrierZapper_hit() {
if (scrFRProjectileCanHitMelee((scrFROther(other)))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
lasthit = [global.fr_module_vars[$ "area:deeplabs"].sprBarrierGameover, "BARRIER"];
;
var __fr_other4=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other4.damage);
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Areas/deeplabs.area.gml:4203
function fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__xScale=undefined, _frl__yScale=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsRoomStartHitbox";
;
active = false;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].mskRoomHitbox);
;
image_alpha = (frMacro_Areas_deeplabs_area_gml_deeplabsDebug ? 0.2 : 0);
;
image_xscale = _frl__xScale;
;
image_yscale = _frl__yScale;
;
on_step = fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4218
function fr_Areas_deeplabs_area_gml_EnemyRoomHitbox_step() {
if (scrFRPlaceMeeting(x, y, Player)) {
{
active = true;
;
}
}
if ((active == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "spawnHitbox", scrFRSelf(self))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
active = true;
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

// Original Areas/deeplabs.area.gml:4229
function fr_Areas_deeplabs_area_gml_StartRoomHitbox_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsStartingRoomHitbox";
;
active = false;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].mskRoomHitbox);
;
image_alpha = (frMacro_Areas_deeplabs_area_gml_deeplabsDebug ? 0.1 : 0);
;
image_xscale = 21;
;
image_yscale = 21;
;
active = false;
;
on_step = fr_Areas_deeplabs_area_gml_StartRoomHitbox_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4245
function fr_Areas_deeplabs_area_gml_StartRoomHitbox_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object((scrFROther(other))) > 16)) {
{
{ var __fr_with4 = scrFRWithValues((scrFROther(other))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
active = true;
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
if ((active == true)) {
{
if ((frMacro_Areas_deeplabs_area_gml_autoBomb == true)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsFinaleController")), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((bombStarted == false)) {
{
fr_Areas_deeplabs_area_gml_RoomDecalCore_activate();
;
bombStarted = true;
;
}
}
}
}
if(__fr_break9) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_DeeplabsCorePanel")), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
if ((active == false)) {
{
active = true;
;
sprite_index = scrFRAreaSourceSprite(spr_strt);
;
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].panelSound);
;
global.fr_module_vars[$ "area:deeplabs"].panelSound = scrFRSoundLoop(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreControlsDanger);
;
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_PanelSoundController")), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
soundRange = dangerSoundRange;
;
}
}
if(__fr_break15) break;
}}
}
}
}
}
if(__fr_break12) break;
}}
}
}
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/deeplabs.area.gml:4278
function fr_Areas_deeplabs_area_gml_DeeplabsDoTremor(_frl__lastTremorSound=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.instance_random, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsTremor) - 1));
;
if ((_frl__sound == _frl__lastTremorSound)) {
{
_frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsTremor) - 1));
;
}
}
var __fr_other4=scrFROther(other);
__fr_other4.lastTremorSound = _frl__sound;
;
scrFRSoundPitch(scrFRIndexGet(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsTremor, _frl__sound), (1 + scrFRSourceRandomRange((- 0.1), 0.1)));
;
var _frl__shakes = (1 + scrFRSourceIRandom(10));
var _frl__power = (50 + scrFRSourceIRandom(70));
;
fr_Areas_deeplabs_area_gml_ShakeItShakeIt_create(scrFRSelf(self), _frl__power, _frl__shakes);
;
repeat ((_frl__shakes / 3)) {
fr_Areas_deeplabs_area_gml_FallingDebris_spawn((x + scrFRSourceRandomRange((- 96), 96)), (y - scrFRSourceRandom(256)));
;
}
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4303
function fr_Areas_deeplabs_area_gml_FallingDebris_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Areas_deeplabs_area_gml_FallingDebris_create(_frl__x, (_frl__y - 384))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__back = scrFRSourceChoose(true, false);
;
depth = ((_frl__back == true) ? 12 : (- 12));
;
isback = ((_frl__back == true) ? true : false);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4310
function fr_Areas_deeplabs_area_gml_FallingDebris_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsFallingDebris";
;
sprite_index = scrFRAreaSourceSprite(((scrFRSourceRandom(5) < 1) ? global.fr_module_vars[$ "area:deeplabs"].sprFallingDebrisBig : global.fr_module_vars[$ "area:deeplabs"].sprFallingDebris));
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_alpha = 0;
;
lifeTime = 90;
;
fallspeed = ((10 + scrFRSourceRandom(6)) * scrFRSourceScale());
;
rotspeed = ((12 + scrFRSourceRandom(20)) * scrFRSourceScale());
;
isback = false;
;
floortime = 0;
;
on_step = fr_Areas_deeplabs_area_gml_FallingDebris_step;
;
on_destroy = fr_Areas_deeplabs_area_gml_FallingDebris_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4330
function fr_Areas_deeplabs_area_gml_FallingDebris_step() {
if ((image_alpha < 1)) {
{
image_alpha += 0.05;
;
}
}
y += fallspeed;
image_angle += rotspeed;
if (isback) {
{
if (scrFRPlaceMeeting(x, y, Floor)) {
{
floortime += (2 * scrFRSourceScale());
;
if ((floortime >= 20)) {
{
lifeTime = 0;
}
}
}
}
}
}
if ((scrFRSourceRandom(2) < 1)) {
{
if ((! (isback && scrFRPlaceMeeting(x, y, Floor)))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(sprGroundFlameDisappear, sprGroundFlameBigDisappear));
;
var _frl__dir = scrFRSourceRandomRange((- 35), 35);
;
image_index = 1;
;
image_angle = (180 + _frl__dir);
direction = (270 + _frl__dir);
;
speed = (2) * timescale;
;
image_yscale = (- scrFRSourceRandomRange(1, 1.5));
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
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
}

// Original Areas/deeplabs.area.gml:4374
function fr_Areas_deeplabs_area_gml_FallingDebris_destroy() {
repeat (6) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(scrFRSourceChoose(sprGroundFlameDisappear, sprGroundFlameBigDisappear));
;
image_index = 1;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
speed = (2) * timescale;
;
image_yscale = (- scrFRSourceRandomRange(1, 1.5));
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Areas/deeplabs.area.gml:4387
function fr_Areas_deeplabs_area_gml_ShakeItShakeIt_create(_frl__player=undefined, _frl__power=undefined, _frl__times=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsTremorShaker";
;
shaker = _frl__player;
;
shakePower = _frl__power;
;
shakes = (1 + _frl__times);
;
shakeTime = 2;
;
on_step = fr_Areas_deeplabs_area_gml_ShakeItShakeIt_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4401
function fr_Areas_deeplabs_area_gml_ShakeItShakeIt_step() {
shakeTime -= scrFRSourceScale();
;
if ((shakeTime <= 0)) {
{
if (((shakes > 0) && scrFRInstanceExists(shaker))) {
{
shakes -= 1;
;
shakeTime = 2;
;
scrFRViewShakeAt(shaker.x, shaker.y, shakePower);
;
shakePower *= 0.75;
;
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

// Original Areas/deeplabs.area.gml:4414
function fr_Areas_deeplabs_area_gml_ColorPuzzleController_create(_frl__x=undefined, _frl__y=undefined, _frl__count=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_colorPuzzleController";
;
myPattern = [];
;
repeat (_frl__count) {
var _frl__color = frMacro_Areas_deeplabs_area_gml_call(frMacro_Areas_deeplabs_area_gml_scr.pool, [[make_color_rgb(252, 58, 0), (scrFRArrayFindIndex(myPattern, make_color_rgb(252, 58, 0)) == (- 1))], [make_color_rgb(255, 133, 0), (scrFRArrayFindIndex(myPattern, make_color_rgb(255, 133, 0)) == (- 1))], [make_color_rgb(255, 230, 0), (scrFRArrayFindIndex(myPattern, make_color_rgb(255, 230, 0)) == (- 1))], [make_color_rgb(67, 255, 0), (scrFRArrayFindIndex(myPattern, make_color_rgb(67, 255, 0)) == (- 1))], [make_color_rgb(0, 255, 255), (scrFRArrayFindIndex(myPattern, make_color_rgb(0, 255, 255)) == (- 1))], [make_color_rgb(253, 58, 255), (scrFRArrayFindIndex(myPattern, make_color_rgb(253, 58, 255)) == (- 1))]]);
array_push(myPattern, _frl__color);
;
}
patternLength = _frl__count;
;
inputPattern = [];
;
myBarrier = noone;
;
myButton = [];
;
myBulb = [];
;
puzzleSolved = false;
;
currentBulb = 0;
;
on_step = fr_Areas_deeplabs_area_gml_ColorPuzzleController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4447
function fr_Areas_deeplabs_area_gml_ColorPuzzleController_step() {
if ((array_length(inputPattern) >= patternLength)) {
{
if (scrFRArrayEquals(inputPattern, myPattern)) {
{
puzzleSolved = true;
;
var _frl__button = 0;
;
repeat (array_length(myButton)) {
{ var __fr_with1 = scrFRWithValues(scrFRIndexGet(myButton, _frl__button)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
color = c_gray;
;
fr_Areas_deeplabs_area_gml_PressureButton_disable();
;
}
}
if(__fr_break3) break;
}}
_frl__button += 1;
;
}
}
} else {
{
inputPattern = [];
;
currentBulb = 0;
;
var _frl__bulb = 0;
;
repeat (array_length(myBulb)) {
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(myBulb, _frl__bulb)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
color = c_white;
;
}
}
if(__fr_break6) break;
}}
_frl__bulb += 1;
;
}
}
}
}
}
if ((puzzleSolved == true)) {
{
{ var __fr_with7 = scrFRWithValues(myBarrier), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
fr_Areas_deeplabs_area_gml_Barrier_deactivate();
;
}
}
if(__fr_break9) break;
}}
scrFRInstanceDestroy();
;
exit;
;
}
}
}

// Original Areas/deeplabs.area.gml:4488
function fr_Areas_deeplabs_area_gml_ColorBulb_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_colorBulb";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprColorBulb);
;
spr_overlay = global.fr_module_vars[$ "area:deeplabs"].sprColorBulbOverlay;
;
color = _frl__color;
;
fr_coreDetoKill = true;
;
on_draw = fr_Areas_deeplabs_area_gml_ColorBulb_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4502
function fr_Areas_deeplabs_area_gml_ColorBulb_draw() {
draw_self();
;
scrFRDrawSpriteExt(spr_overlay, 0, x, y, 1, 1, 0, color, 1);
;
scrFRDrawSpriteExt(spr_overlay, 0, x, (y + 1), 1.2, 1.2, 0, color, 0.4);
;
}

// Original Areas/deeplabs.area.gml:4507
function fr_Areas_deeplabs_area_gml_ColorButton_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsPressureButton";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprPressureButton);
;
spr_overlay = global.fr_module_vars[$ "area:deeplabs"].sprPressureButtonOverlay;
;
image_index = 0;
;
depth = 0;
;
image_speed = (0) * timescale;
;
color = _frl__color;
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskPressureButton;
;
pressed = false;
;
outputSignal = false;
;
owner = _frl__owner;
;
pressDelay = 30;
;
fr_coreDetoKill = true;
;
on_step = fr_Areas_deeplabs_area_gml_ColorButton_step;
;
on_draw = fr_Areas_deeplabs_area_gml_PressureButton_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4531
function fr_Areas_deeplabs_area_gml_ColorButton_step() {
if (scrFRPlaceMeeting(x, y, Player)) {
{
pressed = true;
;
pressDelay = 20;
;
image_index = 1;
;
if ((outputSignal == false)) {
{
outputSignal = true;
;
var _frl__buttonColor = color;
;
{ var __fr_with1 = scrFRWithValues(owner), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRIndexGet(myBulb, currentBulb)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
color = _frl__buttonColor;
;
}
}
if(__fr_break6) break;
}}
array_push(inputPattern, _frl__buttonColor);
;
currentBulb += 1;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitch(sndClick, (0.7 + scrFRSourceRandom(0.2)));
;
}
}
}
} else {
{
if ((pressDelay > 0)) {
{
pressDelay -= scrFRSourceScale();
;
if (((pressed == true) && (pressDelay <= 0))) {
{
pressed = false;
;
image_index = 0;
;
outputSignal = false;
;
}
}
}
}
}
}
}

// Original Areas/deeplabs.area.gml:4560
function fr_Areas_deeplabs_area_gml_PressureButton_draw() {
draw_self();
;
scrFRDrawSpriteExt(spr_overlay, image_index, x, y, 1, 1, 0, color, 1);
;
}

// Original Areas/deeplabs.area.gml:4564
function fr_Areas_deeplabs_area_gml_PressureButton_disable() {
image_index = 1;
;
on_step = fr_Areas_deeplabs_area_gml_nothing;
;
}

// Original Areas/deeplabs.area.gml:4568
function fr_Areas_deeplabs_area_gml_SpinTurret_create(_frl__x=undefined, _frl__y=undefined, _frl__speedMultiplier=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Spin Turret";
spr_base = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretBase;
;
spr_top_on = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTop;
;
spr_top_off = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopOff;
;
spr_top = spr_top_off;
;
spr_gun = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGun;
;
spr_gameover = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGameover;
;
spr_dead = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
hitid = [spr_gameover, "SPIN TURRET"];
;
spr_shadow = shd24;
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
active = true;
;
shootAngle = scrFRSourceRandom(360);
;
drawAngle = shootAngle;
;
shootTime = 60;
;
size = 5;
;
shootDivide = _frl__speedMultiplier;
;
fr_possessable = true;
;
fr_possessed = false;
;
on_step = fr_Areas_deeplabs_area_gml_SpinTurret_step;
;
on_hurt = fr_Areas_deeplabs_area_gml_Prop_hurt;
;
on_draw = fr_Areas_deeplabs_area_gml_SpinTurret_draw;
;
on_possessed = ["area", "deeplabs", fr_Areas_deeplabs_area_gml_SpinTurret_possessed];
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4614
function fr_Areas_deeplabs_area_gml_SpinTurret_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Areas_deeplabs_area_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((distance_to_object(Player) < 160)) {
{
active = true;
;
spr_top = spr_top_on;
;
}
} else {
{
active = false;
;
spr_top = spr_top_off;
;
}
}
if ((active == true)) {
{
shootTime -= scrFRSourceScale();
;
drawAngle -= (angle_difference(drawAngle, shootAngle) * power(0.1, scrFRSourceScale()));
;
if ((shootTime <= 0)) {
{
{
i = 0;
for (; (i < 360); i += 90) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(14, ((scrFROther(other)).i + (scrFROther(other)).shootAngle))), (y + lengthdir_y(14, ((scrFROther(other)).i + (scrFROther(other)).shootAngle))), EnemyBullet1)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (8) * timescale;
;
damage = 3;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.i + __fr_other4.shootAngle);
;
image_angle = direction;
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
}
}
shootTime = (60 / shootDivide);
;
shootAngle += 33;
;
scrFRSoundPitch(sndTurretFire, (0.7 + scrFRSourceRandom(0.3)));
}
}
}
}
if ((hp <= 0)) {
{
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other11.spr_dead);
;
var __fr_other12=scrFROther(other);
image_xscale = __fr_other12.image_xscale;
;
var __fr_other13=scrFROther(other);
size = __fr_other13.size;
;
}
}
if(__fr_break10) break;
}}
scrFRSoundPlay(snd_dead);
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/deeplabs.area.gml:4666
function fr_Areas_deeplabs_area_gml_SpinTurret_draw() {
if ((nexthurt >= (scrFRSourceFrame() + 4))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
scrFRDrawSprite(spr_base, 0, x, y);
if ((! surface_exists(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret))) {
{
global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret = surface_create(view_width, view_height);
;
}
}
surface_set_target(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret);
var _frl_ns_x = scrFRViewCoordinate(0);
;
var _frl_ns_y = scrFRViewCoordinate(1);
;
var _frl_stack = 1;
;
var _frl_height = 4;
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
for (; (_frl_i < sprite_get_number(spr_gun)); _frl_i++) {
scrFRDrawSpriteExt(spr_gun, _frl_i, (x - _frl_ns_x), ((y - (_frl_i - _frl_o)) - _frl_ns_y), 1, 1, drawAngle, image_blend, 1);
;
}
}
}
}
}
}
surface_reset_target();
draw_surface_ext(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret, (_frl_ns_x + 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret, (_frl_ns_x - 1), _frl_ns_y, 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret, _frl_ns_x, (_frl_ns_y + 1), 1, 1, 0, c_black, 1);
draw_surface_ext(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret, _frl_ns_x, (_frl_ns_y - 1), 1, 1, 0, c_black, 1);
draw_surface(global.fr_module_vars[$ "area:deeplabs"].surfaceSpinTurret, _frl_ns_x, _frl_ns_y);
scrFRDrawSprite(spr_top, 0, x, y);
gpu_set_fog(0, 0, 0, 0);
;
}

// Original Areas/deeplabs.area.gml:4709
function fr_Areas_deeplabs_area_gml_SpinTurret_possessed() {
scrFRModCall("mod", "Frontier_StatusEffects", "status_apply_set", scrFRSelf(self), scrFRModGet("mod", "Frontier_StatusEffects", "buffVoltergeist"), (1 / 0));
;
hitid = [spr_idle, "POSSESSED#SPIN TURRET"];
;
spr_top_on = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopPossessed;
;
spr_top_off = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretTopOffPossessed;
;
spr_gameover = global.fr_module_vars[$ "area:deeplabs"].sprSpinTurretGameoverPossessed;
;
shootDivide *= 2;
;
}

// Original Areas/deeplabs.area.gml:4722
function fr_Areas_deeplabs_area_gml_LaserTurret_create(_frl__x=undefined, _frl__y=undefined, _frl__laserCount=undefined, _frl__laserLength=undefined, _frl__laserSpeed=undefined, _frl__laserDis=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Laser Turret";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprLaserTurret;
;
spr_gameover = global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretGameover;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = 5;
;
hitid = [spr_gameover, "LASER TURRET"];
;
spr_shadow = shd24;
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
active = false;
;
shootAngle = scrFRSourceRandom(360);
;
size = 5;
;
laserCount = _frl__laserCount;
;
laserLength = _frl__laserLength;
;
laserSpeed = _frl__laserSpeed;
;
activeDis = _frl__laserDis;
;
fr_coreDetoKill = true;
;
on_step = fr_Areas_deeplabs_area_gml_LaserTurret_step;
;
fr_Areas_deeplabs_area_gml_LaserTurretSourceTop_create(x, y);
;
fr_Areas_deeplabs_area_gml_LaserTurretSource_create(x, y);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4760
function fr_Areas_deeplabs_area_gml_LaserTurret_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if ((distance_to_object(Player) < activeDis)) {
{
if ((active == false)) {
{
active = true;
;
{
var _frl_i = 0;
for (; (_frl_i < 360); _frl_i += (360 / laserCount)) {
fr_Areas_deeplabs_area_gml_LaserTurretBeam_create(x, y, shootAngle, _frl_i, laserLength);
;
}
}
}
}
}
} else {
{
if ((active == true)) {
{
active = false;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomProjectile, "name", "fr_LaserTurretBeam"), "creator", scrFRSelf(self))), __fr_break3=false;
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
}
}
shootAngle += (laserSpeed * scrFRSourceScale());
;
}

// Original Areas/deeplabs.area.gml:4783
function fr_Areas_deeplabs_area_gml_LaserTurretBeam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined, _frl__offset=undefined, _frl__length=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LaserTurretBeam";
;
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeam);
;
mask_index = global.fr_module_vars[$ "area:deeplabs"].mskLaserTrapBeam;
;
spr_tail = global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeamStart;
;
spr_head = global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapHead;
;
image_speed = (0) * timescale;
;
direction = _frl__direction;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 1;
;
typ = 0;
;
offset = _frl__offset;
;
length = _frl__length;
on_step = fr_Areas_deeplabs_area_gml_LaserTurretBeam_step;
;
on_hit = fr_Areas_deeplabs_area_gml_LaserTurretBeam_hit;
;
on_wall = fr_Areas_deeplabs_area_gml_nothing;
;
on_draw = fr_Areas_deeplabs_area_gml_LaserTurretBeam_draw;
;
var _frl_scanLength = fr_Areas_deeplabs_area_gml_binary_search(["area", "deeplabs", fr_Areas_deeplabs_area_gml_check_laser_style], length);
;
x = (xstart + lengthdir_x(_frl_scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl_scanLength, image_angle));
;
image_xscale = (_frl_scanLength / 2);
;
xprevious = x;
yprevious = y;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4818
function fr_Areas_deeplabs_area_gml_LaserTurretBeam_step() {
if (scrFRInstanceExists(creator)) {
{
if ((creator.active == false)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
direction = (creator.shootAngle + offset);
;
image_angle = direction;
;
var _frl__scanLength = fr_Areas_deeplabs_area_gml_binary_search(["area", "deeplabs", fr_Areas_deeplabs_area_gml_check_laser_style], length);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
yprevious = y;
if ((scrFRSourceRandom(15) < 1)) {
{
var _frl__r = scrFRSourceRandomRange(0, ((image_xscale * 2) + 12));
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x - lengthdir_x(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), ((y - lengthdir_y(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprLaserTrapBeamEnd);
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.direction;
image_speed = (0.4) * timescale;
;
var __fr_other5=scrFROther(other);
scrFRMotionSet(__fr_other5.direction, scrFRSourceChoose(1, 2));
}
}
if(__fr_break3) break;
}}
}
}
image_yscale = (1 * scrFRSourceRandomRange(0.8, 1.1));
}
} else {
scrFRInstanceDestroy();
}
}

// Original Areas/deeplabs.area.gml:4852
function fr_Areas_deeplabs_area_gml_binary_search(_frl_checkScript=undefined, _frl_searchLength=undefined) {
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

// Original Areas/deeplabs.area.gml:4879
function fr_Areas_deeplabs_area_gml_check_laser_style(_frl_length=undefined) {
x = (xstart + lengthdir_x(_frl_length, image_angle));
;
y = (ystart + lengthdir_y(_frl_length, image_angle));
;
image_xscale = (_frl_length / 2);
;
return scrFRPlaceMeeting(x, y, Wall);
;
}

// Original Areas/deeplabs.area.gml:4887
function fr_Areas_deeplabs_area_gml_LaserTurretBeam_hit() {
var _frl__team = team;
var _frl__ang = direction;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_trapImmune"))) {
{
if ((nexthurt <= scrFRSourceFrame())) {
{
var __fr_other4=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other4.damage);
lasthit = [global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretGameover, "LASER TURRET"];
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

// Original Areas/deeplabs.area.gml:4899
function fr_Areas_deeplabs_area_gml_LaserTurretBeam_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2), (image_yscale * 2), (image_angle - 45), image_blend, 1.0);
}
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, (image_yscale * 1.7), image_angle, image_blend, 0.2);
;
if ((x != xstart)) {
scrFRDrawSpriteExt(spr_head, 0, x, y, (image_yscale * 2.7), (image_yscale * 2.7), (image_angle - 45), image_blend, 0.2);
}
}

// Original Areas/deeplabs.area.gml:4909
function fr_Areas_deeplabs_area_gml_LaserTurretSourceTop_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LaserTurretSource";
;
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretSourceTop);
;
depth = (- 1);
;
fr_bloom = [1.6, 0.1];
;
on_step = fr_Areas_deeplabs_area_gml_LaserTurretSource_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4923
function fr_Areas_deeplabs_area_gml_LaserTurretSource_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_LaserTurretSource";
;
fr_coreDetoKill = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprLaserTurretSource);
;
depth = 4;
;
fr_bloom = [1.6, 0.1];
;
on_step = fr_Areas_deeplabs_area_gml_LaserTurretSource_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4937
function fr_Areas_deeplabs_area_gml_LaserTurretSource_step() {
image_xscale = (1 + scrFRSourceRandomRange((- 0.1), 0.1));
;
image_yscale = image_xscale;
;
}

// Original Areas/deeplabs.area.gml:4942
function fr_Areas_deeplabs_area_gml_EnemySpawnTube_create(_frl__x=undefined, _frl__y=undefined, _frl__barrier=undefined, _frl__activateBarrier=undefined, _frl__spawnHitbox=undefined, _frl__delay=undefined, _frl__enemy=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsEnemySpawnTube";
spr_idle = global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorIdle;
;
spr_active = global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorActive;
;
spr_done = global.fr_module_vars[$ "area:deeplabs"].sprEnemyElevatorDone;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_index = 0;
;
depth = 5;
;
image_speed = (0.8) * timescale;
;
enemyMod = scrFRIndexGet(_frl__enemy, 0);
;
enemyScript = scrFRIndexGet(_frl__enemy, 1);
;
enemyCount = scrFRIndexGet(_frl__enemy, 2);
;
myBarrier = _frl__barrier;
;
activateDis = 192;
;
active = false;
;
spawned = false;
;
imDone = false;
;
activateDelay = _frl__delay;
;
spriteProcced = false;
;
activateBarrier = _frl__activateBarrier;
;
spawnHitbox = _frl__spawnHitbox;
;
fr_coreDetoKill = true;
;
on_step = fr_Areas_deeplabs_area_gml_EnemySpawnTube_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:4972
function fr_Areas_deeplabs_area_gml_EnemySpawnTube_step() {
if ((imDone == false)) {
{
if ((active == true)) {
{
if ((activateDelay > 0)) {
{
activateDelay -= scrFRSourceScale();
;
}
} else {
{
if ((spriteProcced == false)) {
{
spriteProcced = true;
;
sprite_index = scrFRAreaSourceSprite(spr_active);
;
scrFRSoundPitchVolume(sndToxicBoltGas, (1.3 + scrFRSourceRandom(0.2)), 0.8);
;
}
}
if (((image_index >= 13) && (spawned == false))) {
{
spawned = true;
;
scrFRSoundPitchVolume(sndCursedReminder, 3, 2);
;
repeat ((enemyCount * ((1 + (GameCont.loops * 0.7)) + ((scrFRCrownCurrent() == crwn_blood) || (scrFRGetSkill("BurdenBlood") * 0.3))))) {
{ var __fr_switch_value1=enemyMod, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Basegame")) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, (y + 12), enemyScript)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
var __fr_other6=scrFROther(other);
fr_myBarrier = __fr_other6.myBarrier;
;
image_alpha = 0;
;
var __fr_other7=scrFROther(other);
scrFRBindDraw(fr_Areas_deeplabs_area_gml_EnemyFade_draw, (__fr_other7.depth - 1), scrFRSelf(self));
}
}
if(__fr_break5) break;
}}
break;
;
case 1:
{ var __fr_with8 = scrFRWithValues(scrFRModCall("mod", enemyMod, enemyScript, x, (y + 12))), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
fr_myBarrier = __fr_other11.myBarrier;
;
image_alpha = 0;
;
var __fr_other12=scrFROther(other);
scrFRBindDraw(fr_Areas_deeplabs_area_gml_EnemyFade_draw, (__fr_other12.depth - 1), scrFRSelf(self));
;
scrFRAlarmWrite(scrFRSelf(self), 1, 0.12, "*=");
;
}
}
if(__fr_break10) break;
}}
break;
;
}
}
}
if (((myBarrier != undefined) && (activateBarrier == true))) {
{
if ((myBarrier.enemyMode == false)) {
{
myBarrier.enemyMode = true;
;
}
}
}
}
}
}
if (((sprite_index == spr_active) && frMacro_Areas_deeplabs_area_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_done);
;
imDone = true;
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

// Original Areas/deeplabs.area.gml:5021
function fr_Areas_deeplabs_area_gml_BecomeTurret_create(_frl__x=undefined, _frl__y=undefined, _frl__spawnHitbox=undefined, _frl__delay=undefined, _frl__barrier=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_DeeplabsBecomeTurret";
myBarrier = _frl__barrier;
;
active = false;
;
activateDelay = _frl__delay;
;
spawnHitbox = _frl__spawnHitbox;
;
on_step = fr_Areas_deeplabs_area_gml_BecomeTurret_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5035
function fr_Areas_deeplabs_area_gml_BecomeTurret_step() {
if ((active == true)) {
{
if ((activateDelay > 0)) {
{
activateDelay -= scrFRSourceScale();
;
}
} else {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Turret)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x = __fr_other4.x;
;
var __fr_other5=scrFROther(other);
y = __fr_other5.y;
;
var __fr_other6=scrFROther(other);
fr_myBarrier = __fr_other6.myBarrier;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 20, "=");
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
}
}

// Original Areas/deeplabs.area.gml:5050
function fr_Areas_deeplabs_area_gml_DeeplabsWall_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_deeplabsWall = true;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5057
function fr_Areas_deeplabs_area_gml_ExploEffect_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_explo = global.fr_module_vars[$ "area:deeplabs"].sprSolidColorFog;
;
explo_alpha = 0;
;
fadeOut = false;
;
depth = (- 15);
;
exploColor = ((global.fr_module_vars[$ "area:deeplabs"].settingDarkCoreExplosion == true) ? c_black : c_white);
;
on_step = fr_Areas_deeplabs_area_gml_ExploEffect_step;
;
on_draw = fr_Areas_deeplabs_area_gml_ExploEffect_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5072
function fr_Areas_deeplabs_area_gml_ExploEffect_step() {
if ((fadeOut == false)) {
{
if ((explo_alpha < 2.5)) {
{
explo_alpha += (0.1 * scrFRSourceScale());
;
}
} else {
{
fadeOut = true;
;
}
}
}
} else {
{
if (scrFRInstanceExists(Player)) {
{
if ((explo_alpha > 0)) {
{
explo_alpha -= (0.025 * scrFRSourceScale());
;
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

// Original Areas/deeplabs.area.gml:5089
function fr_Areas_deeplabs_area_gml_ExploEffect_draw() {
draw_sprite_tiled_ext(spr_explo, 0, (scrFRViewCoordinate(0) + (view_width / 2)), (scrFRViewCoordinate(1) + (view_height / 2)), 10, 10, exploColor, explo_alpha);
}

// Original Areas/deeplabs.area.gml:5092
function fr_Areas_deeplabs_area_gml_BarrierEnemyIcon_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(enemy, "fr_myBarrier", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSprite(global.fr_module_vars[$ "area:deeplabs"].sprBarrierIcon, 0, x, ((y - (sprite_height / 2)) - 2));
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5097
function fr_Areas_deeplabs_area_gml_EnemyFade_draw(_frl__target=undefined) {
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

// Original Areas/deeplabs.area.gml:5112
function fr_Areas_deeplabs_area_gml_DeeplabsRoomNametag_create(_frl__x=undefined, _frl__y=undefined, _frl__name=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
roomName = _frl__name;
;
on_draw = fr_Areas_deeplabs_area_gml_DeeplabsRoomNametag_draw;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5121
function fr_Areas_deeplabs_area_gml_DeeplabsRoomNametag_draw() {
scrFRDrawText(x, y, roomName);
;
}

// Original Areas/deeplabs.area.gml:5124
function fr_Areas_deeplabs_area_gml_BecomeChest_create(_frl__x=undefined, _frl__y=undefined, _frl__chest=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsBecomeChest";
myChest = _frl__chest;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5132
function fr_Areas_deeplabs_area_gml_SmokeGeyser_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
smokeCount = (0.3 + scrFRSourceRandom(0.13));
;
on_step = fr_Areas_deeplabs_area_gml_SmokeGeyser_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5141
function fr_Areas_deeplabs_area_gml_SmokeGeyser_step() {
if (frMacro_Areas_deeplabs_area_gml_current_frame_active) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "area:deeplabs"].sprCharSmoke);
;
direction = 90;
;
var __fr_other4=scrFROther(other);
speed = ((__fr_other4.smokeCount * 4)) * timescale;
;
depth = (- 7);
;
friction = ((- 0.4)) * (timescale * timescale);
;
depth = (- 12);
;
var __fr_other5=scrFROther(other);
growspeed = clamp(__fr_other5.smokeCount, 0, 0.25);
;
fr_fadesmoke = true;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
if ((smokeCount > 0.02)) {
{
smokeCount -= (0.0005 * scrFRSourceScale());
;
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Areas/deeplabs.area.gml:5162
function fr_Areas_deeplabs_area_gml_SmokeFader_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
on_step = fr_Areas_deeplabs_area_gml_SmokeFader_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5170
function fr_Areas_deeplabs_area_gml_SmokeFader_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Dust, "fr_fadesmoke", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_alpha -= 0.05;
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5175
function fr_Areas_deeplabs_area_gml_PanelSoundController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PanelSoundController";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
global.fr_module_vars[$ "area:deeplabs"].panelSound = scrFRSoundLoop(global.fr_module_vars[$ "area:deeplabs"].sndDeeplabsCoreControls);
;
scrFRSoundVolume(global.fr_module_vars[$ "area:deeplabs"].panelSound, 0);
;
nearestX = x;
;
nearestY = y;
;
soundRange = 232;
;
dangerSoundRange = 420;
;
on_step = fr_Areas_deeplabs_area_gml_PanelSoundController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Areas/deeplabs.area.gml:5197
function fr_Areas_deeplabs_area_gml_PanelSoundController_step() {
if (((! scrFRInstanceExists(Player)) || (distance_to_object(Player) > 1000))) {
{
scrFRSoundStop(global.fr_module_vars[$ "area:deeplabs"].panelSound);
;
scrFRInstanceDestroy();
;
exit;
;
}
}
var _frl__nearest = instance_nearest(x, y, Player);
;
if (scrFRInstanceExists(_frl__nearest)) {
{
nearestX = _frl__nearest.x;
;
nearestY = _frl__nearest.y;
;
var _frl__dis = distance_to_point(nearestX, nearestY);
var _frl__panelVol = ((soundRange - _frl__dis) / soundRange);
;
scrFRSoundVolume(global.fr_module_vars[$ "area:deeplabs"].panelSound, clamp(_frl__panelVol, 0, 1));
;
}
}
}

// Original Areas/deeplabs.area.gml:5214
function fr_Areas_deeplabs_area_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Areas/deeplabs.area.gml:5223
function fr_Areas_deeplabs_area_gml_nothing() {

}

// Original Areas/deeplabs.area.gml:5225
function fr_Areas_deeplabs_area_gml_array_delete() {
var _frl__array = (argument_count>0 ? argument[0] : undefined);
var _frl__index = (argument_count>1 ? argument[1] : undefined);
var _frl__count = ((argument_count > 2) ? (argument_count>2 ? argument[2] : undefined) : 1);
var _frl__clone = scrFRArraySlice(_frl__array, 0, _frl__index);
;
array_copy(_frl__clone, array_length(_frl__clone), _frl__array, (_frl__index + _frl__count), (array_length(_frl__array) - (_frl__index + _frl__count)));
;
return _frl__clone;
;
; // macro hoisted: current_frame_active
; // macro hoisted: anim_end
}
