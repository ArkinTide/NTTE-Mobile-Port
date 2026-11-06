#macro frMacro_Objects_Frontier_Bosses_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Bosses_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Bosses"].scr

#macro frMacro_Objects_Frontier_Bosses_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Bosses_mod_gml_minSearchDiff 1

#macro frMacro_Objects_Frontier_Bosses_mod_gml_celestialColorsHigh [make_color_rgb(237, 90, 144), c_aqua, c_yellow, c_green, c_purple, c_blue, c_red]

#macro frMacro_Objects_Frontier_Bosses_mod_gml_celestialColorsMedium [make_color_rgb(237, 90, 144), c_aqua, c_yellow, c_green]

#macro frMacro_Objects_Frontier_Bosses_mod_gml_celestialColorsLow [make_color_rgb(237, 90, 144), c_aqua]

#macro frMacro_Objects_Frontier_Bosses_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Bosses_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Bosses_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Bosses_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Bosses_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Bosses.mod.gml:1
function fr_Objects_Frontier_Bosses_mod_gml___load() {

}

// Original Objects/Frontier_Bosses.mod.gml:1
function fr_Objects_Frontier_Bosses_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Bosses_mod_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Objects_Frontier_Bosses_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Bosses_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Bosses.mod.gml:7
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Bosses", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: minSearchDiff
fr_Objects_Frontier_Bosses_mod_gml_debug_init();
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].musRoboBoss = sndFR_musBossRobocenter_735cf282268b;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].musGraveyardBoss = musBoss3;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkDead = sndFR_sndBulwarkDead_5881251f86f1;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkAggro = sndFR_sndBulwarkAggro_145ed7ef494a;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLowHP = sndFR_sndBulwarkLowHP_381bddd849a7;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkHatchClose = sndFR_sndBulwarkHatchClose_f1f619fb02bc;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkHatchOpen = sndFR_sndBulwarkHatchOpen_bca7e56c0f2c;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserFire = sndFR_sndBulwarkLaserFire_b5fb98ff487f;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserWarn = sndFR_sndBulwarkLaserWarn_9053c62e5a4e;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserEnd = sndFR_sndBulwarkLaserEnd_2c21d72319a8;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserLoop = sndFR_sndBulwarkLaserLoop_98ffeabbb8cb;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockWarn = sndFR_sndBulwarkShockWarn_7bf98cdd2f50;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockLoop = sndFR_sndBulwarkShockLoop_51019a0c5d9d;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockEnd = sndFR_sndBulwarkShockEnd_1e9799bc7358;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskGraveyardBoss = sprFR_mskGraveyardBoss_35e3b9b64efb;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossIdle = sprFR_sprGraveyardBossIdle_7f7246009096;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWalk = sprFR_sprGraveyardBossWalk_6150c0e512f2;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossHurt = sprFR_sprGraveyardBossHurt_a0bbb37f8e04;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossDead = sprFrogQueenDead;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWingUp = sprFR_sprGraveyardBossWingUp_cb00ac9ca48c;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWingDown = sprFR_sprGraveyardBossWingDown_9a5ca374b309;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlameTell = sprFR_sprGraveyardBossFlameTel_20ddf98af232;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlame = sprFR_sprGraveyardBossFlame_fec4ab306f05;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlameEnd = sprFR_sprGraveyardBossFlameEnd_db8bf94bb982;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBellTell = sprFR_sprGraveyardBossBellTell_47d9e7ca20be;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBell = sprFR_sprGraveyardBossBell_4fc76f831973;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBellEnd = sprFR_sprGraveyardBossBellEnd_223a07150734;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossJumpWarning = sprFR_sprLobbedJunkWarning_862f209e3bad;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBoss = sprFR_mskRoboBoss_598f2d5e3455;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossIdle = sprFR_sprRoboBossIdle_9088b50bfd29;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossHurt = sprFR_sprRoboBossHurt_3f3ee0ac7069;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossExplode = sprFR_sprRoboBossExplode_76c77f4f0b3a;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomIdle = sprFR_sprRoboBossBottomIdle_8af86d3387a5;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomOpen = sprFR_sprRoboBossBottomOpen_7ab7fb5577f6;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomOpening = sprFR_sprRoboBossBottomOpening_9214f37318c6;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottom2Open = sprFR_sprRoboBossBottom2Open_03b97d14e041;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottom2Opening = sprFR_sprRoboBossBottom2Openin_b358e17adf30;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomClosing = sprFR_sprRoboBossBottomClosing_4a8b727f9868;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossMiddleIdle = sprFR_sprRoboBossMiddleIdle_14a94ade1bae;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossMiddleActive = sprFR_sprRoboBossMiddleActive_e692abe003c8;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTopIdle = sprFR_sprRoboBossTopIdle_83a4ee4e7072;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTopActive = sprFR_sprRoboBossTopActive_89b150354bd0;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipIdle = sprFR_sprRoboBossTipIdle_2124e153dba1;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipOpen = sprFR_sprRoboBossTipOpen_db063d433d6e;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipOpening = sprFR_sprRoboBossTipOpening_5712145bd162;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipClosing = sprFR_sprRoboBossTipClosing_a1546ab82de3;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEye = sprFR_sprRoboBossEye_21ab032ac1b4;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEyeHurt = sprFR_sprRoboBossEyeHurt_745f399e8b50;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossDebris = sprFR_sprRoboBossDebris_7317cab0ede5;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEpicFail = sprFR_sprRoboBossEpicFail_3e45fb825bb9;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskBellRingSmall = sprFR_mskBellRingSmall_8ca33ae800d3;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskBellRing = sprFR_mskBellRing_6f939dc61f21;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingStart = sprFR_sprBellRingStart_2014212fa634;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingLoop = sprFR_sprBellRingLoop_2c88249bbc5a;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingEnd = sprFR_sprBellRingEnd_b04ed33e45f3;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeam = sprFR_sprLaserTrapBeam_7e0265d2a83e;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBossBeam = sprFR_mskLaserTrapBeam_f1734486c953;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamEnd = sprFR_sprLaserTrapBeamEnd_fe4f63251cab;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamStart = sprFR_sprLaserTrapBeamStart_61f54fe29304;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamHead = sprFR_sprLaserTrapHead_33067a73fd0d;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprWarningLaser = sprFR_sprWarningLaser_ff894a34491e;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBossOrbital = sprFR_mskRoboBossOrbital_dc95a56e6bc9;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbital = sprFR_sprRoboBossOrbital_f1e94bfd98c8;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalWarning = sprFR_sprRoboBossOrbitalWarnin_1a526ed2da63;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalWarningBlink = sprFR_sprRoboBossOrbitalWarnin_0d5b5e7b7c6e;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalTrail = sprFR_sprBallTrapBalLTrail_161a0caed742;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEgg = sprFR_sprSwarmbotFired_a2513e88fd28;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEggWarning = sprFR_sprSwarmerEggWarning_f7fdd11242bb;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEggDebris = sprFR_sprSwarmerEggDebris_71b366367aad;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprWhiteSmoke = sprFR_sprWhiteSmoke_af86c6156b99;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBullet = sprFR_sprRoboBossBullet_afb90e1e06ff;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprPetrolStreak = sprFR_sprPetrolStreak_d2e1ad425a48;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkLaserLoop = noone;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop = noone;
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Bosses.mod.gml:6
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Bosses.mod.gml:6
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Bosses.mod.gml:6
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Objects/Frontier_Bosses.mod.gml:3
{
; // macro hoisted: current_frame_active
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Bosses.mod.gml:104
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 2;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
name = "GRAVEYARDBOSS";
boss = true;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossDead;
;
spr_flame = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlame;
;
spr_flame_tell = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlameTell;
;
spr_flame_end = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossFlameEnd;
;
spr_bell = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBell;
;
spr_bell_tell = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBellTell;
;
spr_bell_end = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossBellEnd;
;
spr_wing_tell = sprFrogQueenHurt;
;
spr_wing_up = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWingUp;
;
spr_wing_woah = sprFrogQueenHurt;
;
spr_wing_down = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGraveyardBossWingDown;
;
spr_wing_land = sprFrogQueenFire;
;
spr_special = spr_flame;
;
spr_special_end = spr_flame_end;
;
spr_tell = spr_flame_tell;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "GRAVEYARDBOSS"];
spr_shadow = shd96;
;
spr_shadow_y = (- 18);
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
right = 0;
;
fr_glow = [160, 192];
;
bossname = "GRAVEYARDBOSS";
;
col = c_yellow;
;
snd_hurt = sndGatorHit;
;
snd_dead = sndGatorDie;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskGraveyardBoss;
;
truemask = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskGraveyardBoss;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, fr_Objects_Frontier_Bosses_mod_gml_boss_hp(250), "=");
;
hp = max_hp;
;
raddrop = 12;
;
maxspeed = (3.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 8;
;
canmelee = 0;
;
meleedamage = 6;
;
canfly = true;
;
gunangle = direction;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
intro = false;
;
ammo = 0;
;
partner = noone;
;
attacking = false;
;
flameangle = gunangle;
;
myBell = noone;
;
bellChance = 0;
;
bellProc = false;
;
bellDuration = 0;
;
myHunter = noone;
;
z = 0;
;
zspeed = 0;
;
zfriction = 1;
;
jumpdir = 0;
;
jumpspeed = 0;
;
jumptarget_x = 0;
;
jumptarget_y = 0;
;
jumpwoah = false;
;
jumping = false;
;
jumps = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 10, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 3, 0, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 4, 0, "=");
;
on_step = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_step];
;
on_draw = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_draw;
;
on_hurt = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_hurt;
;
on_death = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_death;
;
on_alrm1 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm1];
;
on_alrm2 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm2];
;
on_alrm3 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm3];
;
on_alrm4 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm4];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:213
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm2_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm3") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm3_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm3") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm4_run)) {
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
if ((jumping == true)) {
{
if ((z <= 12)) {
{
depth = (- 2);
;
}
} else {
{
depth = (- 10);
;
}
}
scrFRMotionSet(jumpdir, jumpspeed);
z += (zspeed * scrFRSourceScale());
;
y -= (zspeed * scrFRSourceScale());
;
spr_shadow_y += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
if (((jumpwoah == false) && (zspeed <= 0))) {
{
jumpwoah = true;
;
spr_tell = spr_wing_woah;
;
spr_special = spr_wing_down;
;
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
image_index = 0;
;
}
}
if ((z <= 0)) {
{
z = 0;
;
spr_shadow_y = (- 18);
;
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpImpact();
;
}
}
}
}
if (((((sprite_index != spr_special) && (sprite_index != spr_tell)) && (sprite_index != spr_special_end)) || frMacro_Objects_Frontier_Bosses_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Bosses_mod_gml_enemy_sprite);
;
}
}
if ((sprite_index == spr_tell)) {
{
if (frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_special);
;
}
}
}
}
if ((((sprite_index != spr_special) && (sprite_index != spr_tell)) && (attacking == true))) {
{
sprite_index = scrFRAreaSourceSprite(spr_special);
;
}
}
right = (((((attacking ? gunangle : direction) + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Bosses.mod.gml:285
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(20)), "=");
;
if ((! scrFRInstanceExists(myHunter))) {
{
if (scrFRInstanceExists(LilHunter)) {
{
myHunter = instance_nearest(x, y, LilHunter);
;
}
}
}
}
if (((jumps <= 0) && (jumping == false))) {
{
if ((! intro)) {
{
intro = true;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Bosses_mod_gml_boss_intro("GraveyardBoss")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
loops = GameCont.loops;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Bosses"].musGraveyardBoss);
;
scrFRSoundPitch(sndBigDogHit, 0.2);
;
scrFRSoundPitch(sndTVOn, 0.3);
;
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_enemy_target(x, y)) {
{
if (frMacro_Objects_Frontier_Bosses_mod_gml_target_visible) {
{
if (((bellChance > 30) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 4))) {
{
bellChance -= 20;
;
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_BellStart();
;
}
} else {
{
if ((frMacro_Objects_Frontier_Bosses_mod_gml_target_distance > 96)) {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(1, 4)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 20, "=");
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(frMacro_Objects_Frontier_Bosses_mod_gml_target_direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_look(direction);
;
}
} else {
{
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpStart(0);
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(3, 4)) {
{
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_FlameStart();
;
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(1, 3)) {
{
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpStart(0);
}
} else {
{
fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(frMacro_Objects_Frontier_Bosses_mod_gml_target_direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_look(direction);
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
if (((bellChance > 30) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 3))) {
{
bellChance -= 20;
;
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_BellStart();
;
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpStart(1);
;
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(frMacro_Objects_Frontier_Bosses_mod_gml_target_direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_look(direction);
;
}
} else {
{
if (fr_Objects_Frontier_Bosses_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_look(direction);
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
} else {
{
fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_look(direction);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:371
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm2() {
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
scrFRSoundPitchVolume(sndGrenadeRifle, (1.1 + scrFRSourceRandom(0.2)), 0.8);
;
fr_Objects_Frontier_Bosses_mod_gml_enemy_face(flameangle);
;
repeat (1) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapFire)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.flameangle + scrFRSourceRandomRange((- 4), 4));
;
friction = (0.10) * (timescale * timescale);
;
speed = ((6 + scrFRSourceRandom(1))) * timescale;
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
repeat (1) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapFire)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
direction = (__fr_other11.flameangle + scrFRSourceRandomRange((- 4), 4));
;
friction = (0.10) * (timescale * timescale);
;
speed = ((4 + scrFRSourceRandom(1))) * timescale;
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
if(__fr_break10) break;
}}
}
repeat (1) {
{ var __fr_with15 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
var __fr_other18=scrFROther(other);
direction = (__fr_other18.flameangle + scrFRSourceRandomRange((- 5), 5));
;
speed = ((7 + scrFRSourceRandom(4))) * timescale;
;
var __fr_other19=scrFROther(other);
team = __fr_other19.team;
;
var __fr_other20=scrFROther(other);
creator = __fr_other20;
;
var __fr_other21=scrFROther(other);
hitid = __fr_other21.hitid;
;
}
}
if(__fr_break17) break;
}}
}
flameangle += 6;
;
if (((-- ammo) <= 0)) {
{
attacking = false;
;
if (fr_Objects_Frontier_Bosses_mod_gml_enemy_target(x, y)) {
{
direction = frMacro_Objects_Frontier_Bosses_mod_gml_target_direction;
;
gunangle = direction;
;
}
}
spr_special_end = spr_flame_end;
;
sprite_index = scrFRAreaSourceSprite(spr_special_end);
;
image_index = 0;
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:426
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm3() {
if ((jumps > 0)) {
{
jumping = true;
;
attacking = true;
;
z = 5;
;
zspeed = 15;
;
zfriction = clamp((1.2 / (distance_to_object(target) / 70)), 0.8, 1.2);
;
var _frl__target_x = (target.x + ((target.hspeed / timescale) * scrFRSourceRandomRange(10, 20)));
var _frl__target_y = (target.y + ((target.vspeed / timescale) * scrFRSourceRandomRange(10, 20)));
;
jumpdir = point_direction(x, y, _frl__target_x, _frl__target_y);
;
jumpspeed = ((point_distance(x, y, _frl__target_x, _frl__target_y) * zfriction) / (zspeed * 2));
;
jumptarget_x = _frl__target_x;
;
jumptarget_y = _frl__target_y;
;
mask_index = mskNone;
;
direction = jumpdir;
;
gunangle = jumpdir;
;
{ var __fr_with1 = scrFRWithValues(scrFRBindDraw(fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossJumpWarning_draw, (- 1), _frl__target_x, _frl__target_y, (scrFROther(other)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speen = scrFRSourceRandom(360);
;
}
}
if(__fr_break3) break;
}}
repeat (12) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapFire)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
image_speed = (0.4) * timescale;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
var __fr_other9=scrFROther(other);
hitid = __fr_other9.hitid;
;
}
}
if(__fr_break6) break;
}}
}
repeat (6) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(4))) * timescale;
;
var __fr_other13=scrFROther(other);
team = __fr_other13.team;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
var __fr_other15=scrFROther(other);
hitid = __fr_other15.hitid;
;
}
}
if(__fr_break12) break;
}}
}
repeat (4) {
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprPetrolStreak);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break18) break;
}}
}
if (((-- jumps) <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 40, "=");
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:485
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_alrm4() {
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 4, 1, "=");
;
if ((! scrFRInstanceExists(myBell))) {
{
if ((bellProc == false)) {
{
myBell = fr_Objects_Frontier_Bosses_mod_gml_BellRing_create(x, y, bellDuration, scrFRSelf(self));
;
bellProc = true;
;
if (scrFRInstanceExists(myHunter)) {
{
{ var __fr_with1 = scrFRWithValues(myHunter), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRInstanceIs(scrFRSelf(self), LilHunterFly))) {
{
var __fr_other4=scrFROther(other);
fr_Objects_Frontier_Bosses_mod_gml_BellRing_create(x, y, __fr_other4.bellDuration, scrFRSelf(self));
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
ammo = 1;
;
}
}
}
}
if (((-- ammo) <= 0)) {
{
bellProc = false;
;
attacking = false;
;
spr_special_end = spr_bell_end;
;
sprite_index = scrFRAreaSourceSprite(spr_special_end);
;
image_index = 0;
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:516
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_FlameStart() {
scrFRAlarmWrite(scrFRSelf(self), 2, 12, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 1, (70 + scrFRSourceIRandom(10)), "=");
;
ammo = 22;
;
flameangle = (frMacro_Objects_Frontier_Bosses_mod_gml_target_direction - 45);
;
gunangle = flameangle;
;
direction = flameangle;
;
spr_tell = spr_flame_tell;
;
spr_special = spr_flame;
;
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
image_index = 0;
;
attacking = true;
;
}

// Original Objects/Frontier_Bosses.mod.gml:530
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpStart(_frl__extraJumpRange=undefined) {
jumps = (1 + scrFRSourceIRandom(_frl__extraJumpRange));
;
scrFRAlarmWrite(scrFRSelf(self), 3, 15, "=");
;
gunangle = frMacro_Objects_Frontier_Bosses_mod_gml_target_direction;
;
spr_tell = spr_wing_tell;
;
spr_special = spr_wing_up;
;
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
image_index = 0;
;
attacking = true;
;
}

// Original Objects/Frontier_Bosses.mod.gml:541
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_JumpImpact() {
jumping = false;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 1.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
repeat (16) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapFire)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((5 + scrFRSourceRandom(1))) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
image_speed = (0.4) * timescale;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
var __fr_other9=scrFROther(other);
hitid = __fr_other9.hitid;
;
}
}
if(__fr_break6) break;
}}
}
repeat (8) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
direction = scrFRSourceRandom(360);
;
speed = ((8 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other13=scrFROther(other);
team = __fr_other13.team;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
var __fr_other15=scrFROther(other);
hitid = __fr_other15.hitid;
;
}
}
if(__fr_break12) break;
}}
}
repeat (4) {
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprPetrolStreak);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break18) break;
}}
}
scrFRSoundPitchVolume(sndExplosionL, (1.2 + scrFRSourceRandom(0.2)), 2);
;
{ var __fr_with19 = scrFRWithValues(fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_create(x, y)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
var __fr_other22=scrFROther(other);
creator = __fr_other22;
;
var __fr_other23=scrFROther(other);
team = __fr_other23.team;
;
}
}
if(__fr_break21) break;
}}
scrFRPickupDrop(5, 0);
;
mask_index = truemask;
;
jumpwoah = false;
;
if ((jumps <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (5 + scrFRSourceIRandom(10)), "=");
;
spr_special_end = spr_wing_land;
;
sprite_index = scrFRAreaSourceSprite(spr_special_end);
;
image_index = 0;
;
attacking = false;
;
if ((! intro)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 5, "=");
;
}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 3, 30, "=");
;
spr_tell = spr_wing_land;
;
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
image_index = 0;
;
spr_special = spr_wing_up;
;
attacking = false;
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:618
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_BellStart() {
scrFRAlarmWrite(scrFRSelf(self), 4, 10, "=");
;
bellDuration = 30;
;
ammo = bellDuration;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((bellDuration + 30) + scrFRSourceIRandom(5)), "=");
;
scrFRSoundPitchVolume(sndStrongSpiritLost, (1.2 + scrFRSourceRandom(0.2)), 3);
spr_tell = spr_bell_tell;
;
spr_special = spr_bell;
;
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
image_index = 0;
;
attacking = true;
;
}

// Original Objects/Frontier_Bosses.mod.gml:631
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_draw() {
if ((((sprite_index == spr_special) || (sprite_index == spr_special_end)) || (sprite_index == spr_tell))) {
{
if ((nexthurt >= (scrFRSourceFrame() + 4))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
gpu_set_fog(0, 0, 0, 0);
;
}

// Original Objects/Frontier_Bosses.mod.gml:640
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
bellChance += _frl__dmg;
;
if ((attacking == false)) {
{
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
}
}
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionAdd(_frl__dir, (_frl__spd / 5));
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_Bosses.mod.gml:653
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_death() {
scrFRPickupDrop(45, 8);
{ var __fr_with1 = scrFRWithValues(MusCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
scrFRAlarmWrite(scrFRSelf(self), 1, 1);
}
if(__fr_break3) break;
}}
;
}

// Original Objects/Frontier_Bosses.mod.gml:659
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_create(_frl__x, _frl__y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
jumpwoah = true;
;
attacking = true;
;
spr_special = spr_wing_down;
;
sprite_index = scrFRAreaSourceSprite(spr_special);
;
mask_index = mskNone;
;
jumping = true;
;
zfriction = 0.8;
;
z = 500;
;
y = (_frl__y - 500);
;
spr_shadow_y = (spr_shadow_y + 500);
;
{ var __fr_with4 = scrFRWithValues(scrFRBindDraw(fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossJumpWarning_draw, (- 1), x, _frl__y, scrFRSelf(self))), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
speen = scrFRSourceRandom(360);
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

// Original Objects/Frontier_Bosses.mod.gml:676
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GraveyardBossSpawner";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
time2Spawn = 240;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSpawner_step;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:687
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSpawner_step() {
time2Spawn -= scrFRSourceScale();
;
if ((time2Spawn <= 0)) {
{
if (scrFRInstanceExists(Player)) {
{
{ var __fr_with1 = scrFRWithValues(frMacro_Objects_Frontier_Bosses_mod_gml_call(frMacro_Objects_Frontier_Bosses_mod_gml_scr.instance_random, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Objects_Frontier_Bosses_mod_gml_GraveyardBoss_spawn(x, y);
;
if ((GameCont.loops > 0)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(10016, 10016, WantLH)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRAlarmWrite(scrFRSelf(self), 0, 1, "=");
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
}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:703
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossJumpWarning_draw(_frl__target_x=undefined, _frl__target_y=undefined, _frl__creator=undefined) {
speen += (6 * scrFRSourceScale());
;
if ((! scrFRInstanceExists(_frl__creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((_frl__creator.jumping == false)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalWarning, 0, _frl__target_x, _frl__target_y, 1, 1, speen, c_white, 1);
;
}

// Original Objects/Frontier_Bosses.mod.gml:715
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskGraveyardBoss;
;
speed = (0) * timescale;
;
lifeTime = 4;
;
damage = 6;
;
hitList = [];
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_step;
;
on_wall = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_hit;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:731
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_step() {
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
y = creator.y;
;
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:743
function fr_Objects_Frontier_Bosses_mod_gml_GraveyardBossSlam_hit() {
if ((scrFRArrayFindIndex(hitList, (scrFROther(other))) == (- 1))) {
{
var __fr_other1=scrFROther(other);
array_push(hitList, __fr_other1);
;
{ var __fr_with2 = scrFRWithValues((scrFROther(other))), __fr_break4=false;
for (var __fr_index3=0; __fr_index3<array_length(__fr_with2); ++__fr_index3) {
if(scrFRScopeExists(__fr_with2[__fr_index3])) with (__fr_with2[__fr_index3]) {
{
var __fr_other5=scrFROther(other);
scrFRProjectileHit(scrFRSelf(self), __fr_other5.damage, (__fr_other5.knockback_speed / timescale));
}
}
if(__fr_break4) break;
}}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:751
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
name = "BULWARK SYSTEM";
boss = true;
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossIdle;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossHurt;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossIdle;
;
spr_bot_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomIdle;
;
spr_bot_strt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomOpening;
;
spr_bot_chrg = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomOpen;
;
spr_bot_stop = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottomClosing;
;
spr_bot_strt2 = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottom2Opening;
;
spr_bot_chrg2 = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBottom2Open;
;
image_index_bot = 0;
;
spr_mid_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossMiddleIdle;
;
spr_mid_chrg = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossMiddleActive;
;
image_index_mid = 0;
;
spr_top_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTopIdle;
;
spr_top_chrg = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTopActive;
;
image_index_top = 0;
;
spr_tip_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipIdle;
;
spr_tip_strt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipOpening;
;
spr_tip_chrg = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipOpen;
;
spr_tip_stop = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossTipClosing;
;
image_index_tip = 0;
;
spr_eye = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEye;
;
spr_eye_hurt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEyeHurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
sprite_index_bot = spr_bot_idle;
;
sprite_index_bit = mskNone;
;
sprite_index_mid = spr_mid_idle;
;
sprite_index_top = spr_top_idle;
;
sprite_index_tip = spr_tip_idle;
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_gameover, "BULWARK SYSTEM"];
spr_shadow = shd24;
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
;
right = 0;
;
fr_glow = [160, 192];
;
bossname = "BULWARK SYSTEM";
;
col = c_red;
;
eyepos = 0;
;
snd_hurt = sndGatorHit;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkDead;
;
snd_aggro = global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkAggro;
;
snd_lowhp = global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLowHP;
;
shockSoundLoop = noone;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBoss;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, fr_Objects_Frontier_Bosses_mod_gml_boss_hp(800), "=");
;
hp = max_hp;
;
raddrop = 120;
;
maxspeed = (0) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 8;
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
intro = false;
;
corpse = false;
;
laserActive = false;
;
orbitalsActive = false;
;
bulletsActive = false;
;
eggsActive = false;
;
eggsCooldown = 0;
;
currentAttacks = 0;
;
laserAngle = 0;
;
laserWarnings = 0;
;
laserCount = min((2 + GameCont.loops), 8);
;
ammo = 0;
;
eggWindup = 0;
;
eggDirection = 0;
;
ammo2 = 0;
bulletOffset = 0;
;
lowhp = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 190, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 3, 0, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 4, 0, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 5, 0, "=");
;
on_step = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_step];
;
on_draw = fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_draw;
;
on_hurt = fr_Objects_Frontier_Bosses_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_death;
;
on_alrm1 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm1];
;
on_alrm2 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm2];
;
on_alrm3 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm3];
;
on_alrm4 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm4];
;
on_alrm5 = ["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm5];
;
scrFRBindDraw(fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_highdraw, (- 5), scrFRSelf(self));
fr_Objects_Frontier_Bosses_mod_gml_RoboBossEye_create(x, y, scrFRSelf(self), 20, spr_eye, spr_eye_hurt);
;
fr_Objects_Frontier_Bosses_mod_gml_RoboBossEye_create(x, y, scrFRSelf(self), (- 20), spr_eye, spr_eye_hurt);
;
x = round(x);
;
y = round(y);
;
xstart = x;
;
ystart = y;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:877
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_step() {
if (frMacro_Objects_Frontier_Bosses_mod_gml_current_frame_active) {
{
image_index_bot += (image_speed / timescale);
;
image_index_mid += (image_speed / timescale);
;
image_index_top += (image_speed / timescale);
;
image_index_tip += (image_speed / timescale);
;
}
}
x = xstart;
;
y = ystart;
;
laserAngle += (1 * scrFRSourceScale());
;
eggsCooldown -= scrFRSourceScale();
;
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm2_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm3") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm3_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm4") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm4_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm5") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm5_run)) {
exit;
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
} else {
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Bosses_mod_gml_enemy_sprite);
}
;
if (((sprite_index_bot == spr_bot_strt) && (image_index_bot > 5))) {
{
sprite_index_bot = spr_bot_chrg;
;
sprite_index_bit = spr_bot_chrg2;
;
}
}
if (((sprite_index_bot == spr_bot_chrg) && (laserActive == false))) {
{
image_index_bot = 0;
;
sprite_index_bot = spr_bot_stop;
;
sprite_index_bit = mskNone;
;
}
}
if (((sprite_index_bot == spr_bot_stop) && (image_index_bot > 4))) {
{
sprite_index_bot = spr_bot_idle;
;
}
}
if (((sprite_index_tip == spr_tip_strt) && (image_index_tip > 4))) {
{
sprite_index_tip = spr_tip_chrg;
;
}
}
if (((sprite_index_tip == spr_tip_chrg) && (eggsActive == false))) {
{
image_index_tip = 0;
;
sprite_index_tip = spr_tip_stop;
;
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkHatchClose);
;
}
}
if (((sprite_index_tip == spr_tip_stop) && (image_index_tip > 4))) {
{
sprite_index_tip = spr_tip_idle;
;
}
}
if ((lowhp == false)) {
{
if ((hp <= (max_hp / 2))) {
{
scrFRSoundPlay(snd_lowhp);
;
lowhp = true;
;
}
}
}
}
if (scrFRInstanceExists(target)) {
{
eyepos = frMacro_Objects_Frontier_Bosses_mod_gml_target_direction;
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:949
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (60 + scrFRSourceRandom(30)), "=");
;
if (scrFRInstanceExists(target)) {
{
if ((! intro)) {
{
if (((distance_to_object(Player) < 192) || (hp < max_hp))) {
{
intro = true;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Bosses_mod_gml_boss_intro("RoboBoss")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
loops = GameCont.loops;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundMusic(global.fr_module_vars[$ "mod:Frontier_Bosses"].musRoboBoss);
;
scrFRSoundPlay(snd_aggro);
;
}
}
}
} else {
{
if ((((currentAttacks < 2) && (eggsCooldown <= 0)) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 2))) {
{
ammo = (8 + (4 * GameCont.loops));
;
eggWindup = 12;
;
scrFRAlarmWrite(scrFRSelf(self), 4, 1, "=");
;
eggsCooldown += 500;
;
eggsActive = true;
;
currentAttacks += 1;
;
image_index_tip = 0;
;
sprite_index_tip = spr_tip_strt;
;
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkHatchOpen);
;
}
}
if ((((currentAttacks < 2) && (laserActive == false)) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 2))) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 5, "=");
;
laserWarnings = 3;
;
laserActive = true;
;
currentAttacks += 1;
;
image_index_bot = 0;
;
sprite_index_bot = spr_bot_strt;
;
sprite_index_bit = spr_bot_strt2;
;
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserWarn);
;
}
}
if ((((currentAttacks < 2) && (orbitalsActive == false)) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 2))) {
{
var _frl__orbitalTime = 360;
;
scrFRAlarmWrite(scrFRSelf(self), 3, (_frl__orbitalTime + 40), "=");
;
orbitalsActive = true;
;
currentAttacks += 1;
;
image_index_top = 0;
;
sprite_index_top = spr_top_chrg;
;
{
i = 0;
for (; (i < 360); i += (360 / 3)) {
var __fr_other4=scrFROther(other);
fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_create(x, y, __fr_other4, __fr_other4.i, _frl__orbitalTime);
;
}
}
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop);
;
}
}
if ((((currentAttacks < 2) && (bulletsActive == false)) && fr_Objects_Frontier_Bosses_mod_gml_chance(1, 2))) {
{
scrFRAlarmWrite(scrFRSelf(self), 5, 1, "=");
;
ammo2 = 10;
;
bulletsActive = true;
;
currentAttacks += 1;
;
image_index_mid = 0;
;
sprite_index_mid = spr_mid_chrg;
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1015
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm2() {
if ((laserWarnings > 0)) {
{
var _frl__madeLaser = false;
;
scrFRAlarmWrite(scrFRSelf(self), 2, 5, "=");
;
laserWarnings -= 1;
;
{
i = 0;
for (; (i < 360); i += (360 / laserCount)) {
var __fr_other1=scrFROther(other);
fr_Objects_Frontier_Bosses_mod_gml_WarningBeam_create(x, y, laserAngle, __fr_other1.i);
;
}
}
}
} else {
{
if ((laserWarnings <= (- 1))) {
{
laserActive = false;
;
currentAttacks -= 1;
;
exit;
;
}
}
laserWarnings = (- 1);
;
var _frl__laserTime = 180;
;
scrFRAlarmWrite(scrFRSelf(self), 2, _frl__laserTime, "=");
;
{
i = 0;
for (; (i < 360); i += (360 / laserCount)) {
var __fr_other2=scrFROther(other);
fr_Objects_Frontier_Bosses_mod_gml_Beam_create(x, y, laserAngle, __fr_other2.i, _frl__laserTime);
;
}
}
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserFire);
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkLaserLoop = scrFRSoundLoop(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserLoop);
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1040
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm3() {
orbitalsActive = false;
;
currentAttacks -= 1;
;
sprite_index_top = spr_top_idle;
;
}

// Original Objects/Frontier_Bosses.mod.gml:1046
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm4() {
if ((ammo > 0)) {
{
if ((eggWindup > 1)) {
{
eggWindup -= 1;
;
}
}
scrFRAlarmWrite(scrFRSelf(self), 4, eggWindup, "=");
;
eggDirection += 32;
;
scrFRSoundPitchVolume(sndGrenadeRifle, (1.1 + scrFRSourceRandom(0.2)), 0.8);
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_create(x, (y - 20))), __fr_break3=false;
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
direction = __fr_other4.eggDirection;
;
speed = (2) * timescale;
;
var __fr_other5=scrFROther(other);
image_angle = point_direction(0, 0, (__fr_other5.hspeed / timescale), (- zspeed));
;
var __fr_other6=scrFROther(other);
team = __fr_other6.team;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
var __fr_other8=scrFROther(other);
hitid = __fr_other8.hitid;
;
{ var __fr_with9 = scrFRWithValues(scrFRBindDraw(fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_warningDraw, (- 1))), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
speen = scrFRSourceRandom(360);
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
}
}
if(__fr_break11) break;
}}
}
}
if(__fr_break3) break;
}}
if (((-- ammo) <= 0)) {
{
eggsActive = false;
;
currentAttacks -= 1;
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1083
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_alrm5() {
if ((ammo2 > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 5, 14, "=");
;
bulletOffset += 6;
;
{
i = 0;
for (; (i < 360); i += ((360 / 14) + (2 * GameCont.loops))) {
scrFRSoundPitchVolume(sndTurretFire, (0.6 + scrFRSourceRandom(0.2)), 1.5);
;
scrFRSoundPitchVolume(sndGrenadeHitWall, (0.6 + scrFRSourceRandom(0.1)), 0.7);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet1)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBullet);
;
typ = 2;
;
speed = (3) * timescale;
;
damage = 100;
;
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + __fr_other4.i) + __fr_other4.bulletOffset);
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
if ((((direction >= 160) && (direction <= 360)) || (direction <= 20))) {
{
depth = (- 6);
}
}
}
}
if(__fr_break3) break;
}}
}
}
if (((-- ammo2) <= 0)) {
{
bulletsActive = false;
currentAttacks -= 1;
;
sprite_index_mid = spr_mid_idle;
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1114
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_death() {
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkLaserLoop);
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop);
;
fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_create(x, y);
;
scrFRPickupDrop(400, 40);
;
if (scrFRModLoaded("mod", "adaptation")) {
{
scrFRModCall("mod", "adaptation", "rerollBall_create", x, y);
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1128
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_draw() {
if ((nexthurt >= (scrFRSourceFrame() + 3))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
scrFRDrawSpriteExt(sprite_index_bot, image_index_bot, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
gpu_set_fog(0, 0, 0, 0);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1135
function fr_Objects_Frontier_Bosses_mod_gml_RoboBoss_highdraw(_frl__boss=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl__boss), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((nexthurt >= (scrFRSourceFrame() + 3))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
scrFRDrawSpriteExt(sprite_index_bit, image_index_bot, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index_mid, image_index_mid, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index_top, image_index_top, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index_tip, image_index_tip, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
;
gpu_set_fog(0, 0, 0, 0);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1147
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossEye_create(_frl__x=undefined, _frl__y=undefined, _frl__boss=undefined, _frl__offset=undefined, _frl__sprite=undefined, _frl__sprite_hurt=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = _frl__sprite;
;
spr_hurt = _frl__sprite_hurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
depth = (- 6);
;
offset = _frl__offset;
;
creator = _frl__boss;
;
xgoal = _frl__boss.x;
;
ygoal = _frl__boss.y;
;
moveSpeed = 4;
;
distance = 28;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_RoboBossEye_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1166
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossEye_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((creator.nexthurt >= (scrFRSourceFrame() + 3))) {
{
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
}
} else {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
x += (fr_Objects_Frontier_Bosses_mod_gml_approach(x, xgoal, moveSpeed, (0.3 * scrFRSourceScale())) - lengthdir_x(0, creator.eyepos));
y += (fr_Objects_Frontier_Bosses_mod_gml_approach(y, ygoal, moveSpeed, (0.3 * scrFRSourceScale())) - lengthdir_y(0, creator.eyepos));
xgoal = (creator.x + lengthdir_x(distance, (creator.eyepos + offset)));
ygoal = ((creator.y + lengthdir_y(distance, (creator.eyepos + offset))) - 45);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1184
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RoboBossDeath";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossExplode);
;
image_speed = (0.4) * timescale;
;
fr_glow = [160, 192];
;
lifeTime = 90;
;
hitid = [global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossEpicFail, "BULWARK SYSTEM"];
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_step;
;
on_destroy = fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1201
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_step() {
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeathPortalSpawner_create(x, y);
scrFRInstanceDestroy();
;
exit;
;
}
}
if (frMacro_Objects_Frontier_Bosses_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 40), 20)), Explosion)), __fr_break3=false;
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
scrFRSoundPitchVolume(sndExplosion, (0.8 + scrFRSourceRandom(0.4)), 0.7);
;
}
}
if ((scrFRSourceRandom((lifeTime / 6)) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 40), 20)), Explosion)), __fr_break7=false;
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
scrFRSoundPitchVolume(sndExplosion, (0.8 + scrFRSourceRandom(0.4)), 0.7);
;
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1223
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeath_destroy() {
repeat (10) {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 20), 20)), (y + scrFRSourceRandomRange((- 40), 20)), Explosion);
;
}
scrFRSoundPitchVolume(sndExplosionXL, 1, 0.8);
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossDebris);
;
image_index = scrFRSourceIRandom(image_number);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
speed = ((8 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues(MusCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
scrFRAlarmWrite(scrFRSelf(self), 1, 1);
}
if(__fr_break6) break;
}}
;
}

// Original Objects/Frontier_Bosses.mod.gml:1244
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossDeathPortalSpawner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = mskNone;
;
spr_walk = mskNone;
;
snd_hurt = mskNone;
;
spr_dead = mskNone;
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
givekill = 0;
;
scrFRMaxHealthWrite(id, 1, "=");
;
hp = 0;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1257
function fr_Objects_Frontier_Bosses_mod_gml_BellRing_create(_frl__x=undefined, _frl__y=undefined, _frl__duration=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_strt = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingStart;
;
spr_loop = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingLoop;
;
spr_done = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprBellRingEnd;
;
sprite_index = scrFRAreaSourceSprite(spr_strt);
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
image_alpha = 0.6;
;
depth = (_frl__creator.depth - 1);
;
speed = (0) * timescale;
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
myHitbox = fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_create(x, y, scrFRSelf(self));
;
lifeTime = _frl__duration;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_BellRing_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1283
function fr_Objects_Frontier_Bosses_mod_gml_BellRing_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
if (scrFRInstanceIs(creator, LilHunterFly)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
x = creator.x;
;
y = creator.y;
;
}
}
lifeTime -= scrFRSourceScale();
;
if ((sprite_index == spr_strt)) {
{
if (frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(((lifeTime <= 0) ? spr_done : spr_loop));
;
myHitbox.mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskBellRing;
;
}
}
}
}
if ((sprite_index == spr_loop)) {
{
if (frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) {
{
if ((lifeTime <= 0)) {
{
sprite_index = scrFRAreaSourceSprite(spr_done);
;
}
}
}
}
}
}
if ((sprite_index == spr_done)) {
{
if (frMacro_Objects_Frontier_Bosses_mod_gml_anim_end) {
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

// Original Objects/Frontier_Bosses.mod.gml:1319
function fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskBellRingSmall;
;
speed = (0) * timescale;
;
knockback_speed = (8) * timescale;
;
typ = 0;
;
damage = 2;
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
hitid = [sprite_index, "BELL RING"];
;
candeflect = false;
;
on_anim = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_step;
;
on_wall = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_hit;
;
on_destroy = fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_destroy;
;
on_projectile = fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1347
function fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
x = creator.x;
;
y = creator.y;
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1356
function fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_hit() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd((point_direction(x, y, __fr_other4.x, __fr_other4.y) + 180), 8);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1361
function fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_destroy() {
if (scrFRInstanceExists(creator)) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
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

// Original Objects/Frontier_Bosses.mod.gml:1368
function fr_Objects_Frontier_Bosses_mod_gml_BellRingHitbox_nullify() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
repeat (2) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
direction = __fr_other7.direction;
;
speed = ((2 + scrFRSourceRandom(1))) * timescale;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprWhiteSmoke);
;
}
}
if(__fr_break6) break;
}}
}
scrFRInstanceCreate(x, y, ThrowHit);
;
scrFRSoundPitch(sndCrystalRicochet, (0.6 + scrFRSourceRandom(0.2)));
direction += (180 + scrFRSourceRandomRange((- 30), 30));
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

// Original Objects/Frontier_Bosses.mod.gml:1387
function fr_Objects_Frontier_Bosses_mod_gml_WarningBeam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined, _frl__offset=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprWarningLaser);
;
mask_index = mskLaser;
;
image_speed = (0) * timescale;
;
depth = (- 3);
;
direction = _frl__direction;
;
offset = _frl__offset;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 1;
;
lifetime = 3;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_WarningBeam_step;
;
on_hit = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_wall = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_draw = fr_Objects_Frontier_Bosses_mod_gml_warning_draw;
;
var _frl_scanLength = fr_Objects_Frontier_Bosses_mod_gml_binary_search(["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_check_laser_style], 500);
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

// Original Objects/Frontier_Bosses.mod.gml:1419
function fr_Objects_Frontier_Bosses_mod_gml_Beam_create(_frl__x=undefined, _frl__y=undefined, _frl__direction=undefined, _frl__offset=undefined, _frl__lifeTime=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RoboBossBeam";
;
image_angle = _frl__direction;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeam);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBossBeam;
;
spr_tail = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamStart;
;
spr_head = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamHead;
;
image_speed = (0) * timescale;
;
depth = (- 3);
;
direction = _frl__direction;
;
offset = _frl__offset;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = 1;
;
lifetime = _frl__lifeTime;
;
hitid = creator.hitid;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_Beam_step;
;
on_hit = fr_Objects_Frontier_Bosses_mod_gml_Beam_hit;
;
on_wall = fr_Objects_Frontier_Bosses_mod_gml_nothing;
;
on_draw = fr_Objects_Frontier_Bosses_mod_gml_Beam_draw;
;
on_destroy = fr_Objects_Frontier_Bosses_mod_gml_Beam_destroy;
;
var _frl__scanLength = fr_Objects_Frontier_Bosses_mod_gml_binary_search(["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_check_laser_style], 1000);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
yprevious = y;
scrFRSoundPosition(sndEnergyHammerUpg, 0.3);
scrFRSoundSetPitch(sndEnergyHammerUpg, 0);
scrFRSoundPitchVolume(sndEnergyHammerUpg, (0.4 * scrFRSourceRandomRange(0.9, 1.1)), 0.25);
scrFRSoundPitchVolume(sndLaserCannon, (1.5 + scrFRSourceRandom(0.3)), 0.2);
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1462
function fr_Objects_Frontier_Bosses_mod_gml_Beam_step() {
if (scrFRInstanceExists(creator)) {
{
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
direction = (creator.laserAngle + offset);
;
image_angle = direction;
;
var _frl__scanLength = fr_Objects_Frontier_Bosses_mod_gml_binary_search(["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_check_laser_style], 1000);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
yprevious = y;
if ((scrFRSourceRandom(5) < 1)) {
{
var _frl__r = scrFRSourceRandomRange(0, ((image_xscale * 2) + 12));
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(((x - lengthdir_x(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), ((y - lengthdir_y(_frl__r, direction)) + scrFRSourceRandomRange((- 5), 5)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossBeamEnd);
var __fr_other4=scrFROther(other);
image_angle = __fr_other4.direction;
image_speed = (0.4) * timescale;
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth - 1);
;
var __fr_other6=scrFROther(other);
scrFRMotionSet(__fr_other6.direction, scrFRSourceChoose(1, 2));
}
}
if(__fr_break3) break;
}}
}
}
image_yscale = (1 * scrFRSourceRandomRange(0.8, 1.4));
}
} else {
scrFRInstanceDestroy();
}
;
}

// Original Objects/Frontier_Bosses.mod.gml:1498
function fr_Objects_Frontier_Bosses_mod_gml_Beam_destroy() {
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkLaserLoop);
;
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserEnd))) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkLaserEnd);
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1504
function fr_Objects_Frontier_Bosses_mod_gml_WarningBeam_step() {
if (scrFRInstanceExists(creator)) {
{
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
direction = (creator.laserAngle + offset);
;
image_angle = direction;
;
var _frl__scanLength = fr_Objects_Frontier_Bosses_mod_gml_binary_search(["mod", "Frontier_Bosses", fr_Objects_Frontier_Bosses_mod_gml_check_laser_style], 1000);
;
x = (xstart + lengthdir_x(_frl__scanLength, image_angle));
;
y = (ystart + lengthdir_y(_frl__scanLength, image_angle));
;
image_xscale = (_frl__scanLength / 2);
;
xprevious = x;
yprevious = y;
}
} else {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1525
function fr_Objects_Frontier_Bosses_mod_gml_warning_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, image_yscale, image_angle, image_blend, 1.0);
;
scrFRDrawSpriteExt(sprite_index, image_index, xstart, ystart, image_xscale, (image_yscale * 1.7), image_angle, image_blend, 0.2);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1529
function fr_Objects_Frontier_Bosses_mod_gml_binary_search(_frl_checkScript=undefined, _frl_searchLength=undefined) {
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
while ((_frl_lenDiff > frMacro_Objects_Frontier_Bosses_mod_gml_minSearchDiff)) {
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

// Original Objects/Frontier_Bosses.mod.gml:1556
function fr_Objects_Frontier_Bosses_mod_gml_check_laser_style(_frl_length=undefined) {
x = (xstart + lengthdir_x(_frl_length, image_angle));
;
y = (ystart + lengthdir_y(_frl_length, image_angle));
;
image_xscale = (_frl_length / 2);
;
return scrFRPlaceMeeting(x, y, Wall);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1564
function fr_Objects_Frontier_Bosses_mod_gml_Beam_hit() {
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
var __fr_other5=scrFROther(other);
lasthit = __fr_other5.hitid;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1574
function fr_Objects_Frontier_Bosses_mod_gml_Beam_draw() {
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

// Original Objects/Frontier_Bosses.mod.gml:1584
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__angle=undefined, _frl__lifeTime=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_RoboBossOrbital";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalWarning;
;
spr_blink = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalWarningBlink;
;
spr_active = global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbital;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
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
fr_glow = [64, 72];
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Bosses"].mskRoboBossOrbital;
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
dist = 160;
;
orbitSpeed = 2;
;
lifetime = _frl__lifeTime;
;
dangerTime = 60;
;
dangerous = false;
;
allGrownUp = false;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_step;
;
on_end_step = fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_endstep;
;
on_wall = fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_wall;
;
on_hit = fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_hit;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1627
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_step() {
lifetime -= scrFRSourceScale();
;
dangerTime -= scrFRSourceScale();
;
image_angle += (4 * scrFRSourceScale());
;
dist = (160 + (sin((scrFRSourceFrame() * 0.03)) * 50));
;
if (((! scrFRInstanceExists(creator)) || ((lifetime <= 0) && (image_xscale <= 0)))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((lifetime <= 0)) {
{
image_xscale -= 0.1;
;
image_yscale -= 0.1;
;
}
}
if ((allGrownUp == false)) {
{
if ((image_xscale < 1)) {
{
image_xscale += 0.2;
;
image_yscale += 0.2;
;
}
} else {
{
allGrownUp = true;
;
}
}
}
}
if ((dangerous == false)) {
{
if ((dangerTime <= 15)) {
{
if ((sprite_index != spr_blink)) {
{
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockWarn))) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockWarn);
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_blink);
;
}
}
}
} else {
{
if ((sprite_index != spr_idle)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
}
if ((dangerTime <= 0)) {
{
dangerTime += 60;
;
dangerous = true;
;
beamscale = 1;
;
if ((sprite_index != spr_active)) {
{
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop))) {
{
global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop = scrFRSoundLoop(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockLoop);
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_active);
;
}
}
}
}
}
} else {
{
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 30), 30)), (y + scrFRSourceRandomRange((- 30), 30)), PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprRoboBossOrbitalTrail);
;
}
}
if(__fr_break3) break;
}}
}
}
if ((dangerTime <= 0)) {
{
dangerTime += 60;
;
dangerous = false;
;
if ((! audio_is_playing(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockEnd))) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Bosses"].sndBulwarkShockEnd);
;
scrFRSoundStop(global.fr_module_vars[$ "mod:Frontier_Bosses"].bulwarkShockLoop);
;
}
}
}
}
}
}
angle -= (orbitSpeed * scrFRSourceScale());
;
}

// Original Objects/Frontier_Bosses.mod.gml:1700
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_wall() {
if ((dangerous == true)) {
{
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
}
}

// Original Objects/Frontier_Bosses.mod.gml:1708
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_endstep() {
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

// Original Objects/Frontier_Bosses.mod.gml:1716
function fr_Objects_Frontier_Bosses_mod_gml_RoboBossOrbital_hit() {
if ((dangerous == true)) {
{
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
var __fr_other5=scrFROther(other);
hitid = __fr_other5.hitid;
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

// Original Objects/Frontier_Bosses.mod.gml:1728
function fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "lobbedEgg";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEgg);
;
image_index = scrFRSourceIRandom(3);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
speed = ((12 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
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
hitid = [sprite_index, "EGG"];
;
z = 0;
;
zspeed = 0;
;
zfriction = 1;
;
turnspeed = (3 + (scrFRSourceRandom(2) * scrFRSourceChoose((- 1), 1)));
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_step;
;
on_destroy = fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_destroy;
;
on_draw = fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1757
function fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_step() {
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y - z), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprWhiteSmoke);
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
growspeed = (- 0.08);
;
image_alpha = 0.80;
;
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
}
}
if(__fr_break3) break;
}}
}
}
var __fr_other5=scrFROther(other);
image_angle = point_direction(0, 0, (__fr_other5.hspeed / timescale), (- zspeed));
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
var _frl_m = 4;
;
if (((speed / timescale) > _frl_m)) {
speed = (_frl_m) * timescale;
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
depth = (- 9);
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1806
function fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = 0.4;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "Swarmbot_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
givekill = 0;
;
dropPercent = 35;
;
}
}
if(__fr_break6) break;
}}
scrFRSoundPitch(sndBouncerBounce, (1.3 + scrFRSourceRandom(0.1)));
repeat (2) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Debris)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEggDebris);
;
mask_index = mskNone;
;
speed = (2) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1824
function fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 260)), (image_yscale + (z / 260)), image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1827
function fr_Objects_Frontier_Bosses_mod_gml_MortarEgg_warningDraw() {
speen += (6 * scrFRSourceScale());
;
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
}
}
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprSwarmerEggWarning, 0, creator.x, creator.y, 1, 1, speen, c_white, 1);
;
}

// Original Objects/Frontier_Bosses.mod.gml:1837
function fr_Objects_Frontier_Bosses_mod_gml_debug_init() {
global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface = noone;
global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list = [];
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].celestialColorsList = frMacro_Objects_Frontier_Bosses_mod_gml_celestialColorsHigh;
; // macro hoisted: celestialColorsHigh
;
; // macro hoisted: celestialColorsMedium
;
; // macro hoisted: celestialColorsLow
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprCelestialSparkle = sprFR_sprCelestialSparkle_6eb888792373;
;
global.fr_module_vars[$ "mod:Frontier_Bosses"].sprTrespasserSideways = sprFR_15ac06ff2011e6d90d5eb872_44531d6c9b28;
;
}

// Original Objects/Frontier_Bosses.mod.gml:1849
function fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_spawn(_frl__x=undefined, _frl__y=undefined) {
if ((scrFRArrayFindIndex(scrFRMatching(FRCustomObject, "name", "fr_celestialDrawController"), (scrFROther(other))) < 0)) {
{
fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_create(_frl__x, _frl__y);
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1854
function fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_celestialDrawController";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
draw_bind_celeste = noone;
;
on_end_step = fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_endstep;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1865
function fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_endstep() {
if ((! scrFRInstanceExists(draw_bind_celeste))) {
{
draw_bind_celeste = scrFRBindDraw(fr_Objects_Frontier_Bosses_mod_gml_celestial_draw, (- 14), scrFRSelf(self));
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1870
function fr_Objects_Frontier_Bosses_mod_gml_DebuggingObject_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_TrespasserSighting";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprTrespasserSideways);
;
image_speed = (0.4) * timescale;
;
depth = (- 12);
;
right = 1;
;
fr_glow = [96, 128];
maxspeed = (12) * timescale;
speed = ((maxspeed / timescale)) * timescale;
;
friction = (1) * (timescale * timescale);
;
direction = 180;
;
lifetime = 400;
;
on_step = fr_Objects_Frontier_Bosses_mod_gml_TrespasserSighting_step;
;
if ((array_length(scrFRMatching(FRCustomObject, "name", "fr_celestialDrawController")) == 0)) {
{
fr_Objects_Frontier_Bosses_mod_gml_CelestialDrawController_spawn(10016, 10016);
;
}
}
array_push(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list, scrFRSelf(self));
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Bosses.mod.gml:1899
function fr_Objects_Frontier_Bosses_mod_gml_TrespasserSighting_step() {
if ((image_index < 8)) {
{
speed = ((maxspeed / timescale)) * timescale;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + 25), (y + scrFRSourceRandomRange((- 25), 25)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprCelestialSparkle);
;
image_blend = make_colour_hsv(((scrFRSourceFrame() * 16) mod 255), 220, 255);
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
image_xscale = (0.7 + scrFRSourceRandom(0.3));
;
image_yscale = image_xscale;
;
image_index = scrFRSourceIRandom(1);
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 4)) * timescale;
;
var __fr_other6=scrFROther(other);
direction = (__fr_other6.direction + 180);
;
}
}
if(__fr_break3) break;
}}
}
}
lifetime -= scrFRSourceScale();
;
if ((lifetime <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:1921
function fr_Objects_Frontier_Bosses_mod_gml_celestial_draw() {
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (array_length(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list)) {
{
global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list = scrFRMatchingNE(scrFRMatchingNE(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list, "id"), "celestial_time", 0);
if ((! surface_exists(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface))) {
{
global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface = surface_create(view_width, view_height);
}
}
var _frl_so_x = scrFRViewCoordinate(0);
;
var _frl_so_y = scrFRViewCoordinate(1);
;
surface_set_target(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface);
draw_clear_alpha(c_white, 0);
;
gpu_set_fog(1, c_white, 0, 0);
;
var _frl__hurt = [];
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_list), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRVariableExists(scrFRSelf(self), "nexthurt") && (nexthurt > scrFRSourceFrame()))) {
{
array_push(_frl__hurt, scrFRSelf(self));
}
} else {
{
var _frl__noise = ((scrFRSourceRandom(3) < 1) ? scrFRSourceRandomRange(1, 3) : scrFRSourceRandomRange(0.5, 1));
;
}
}
var _frl_uvs = sprite_get_uvs(sprite_index, image_index);
var _frl_width = (scrFRIndexGet(_frl_uvs, 6) * sprite_width);
var _frl_height = (scrFRIndexGet(_frl_uvs, 7) * sprite_height);
draw_primitive_begin_texture(pr_trianglefan, sprite_get_texture(sprite_index, image_index));
var _frl_unspike = false;
{
var _frl_i = 0;
for (; (_frl_i <= 360); _frl_i += 45) {
var _frl__wide = (abs(dsin(_frl_i)) < abs(dcos(_frl_i)));
var _frl__tall = ((2 * abs(dsin(_frl_i))) > abs(dcos(_frl_i)));
var _frl__sqr = ((! _frl__wide) && (! _frl__tall));
var _frl__hor = (sign(dcos(_frl_i)) * ((_frl__wide || _frl__sqr) ? 1 : abs((1 / dtan(_frl_i)))));
var _frl__ver = (sign(dsin(_frl_i)) * ((_frl__tall || _frl__sqr) ? 1 : abs(dtan(_frl_i))));
var _frl__vx = (0.5 - ((_frl__hor / 2) * right));
var _frl__vy = (0.5 - (_frl__ver / 2));
var _frl__spike = (((scrFRSourceRandom(6) < 1) && (! _frl_unspike)) ? (scrFRSourceRandomRange(3, 8) * _frl__noise) : 0);
var _frl__dir = point_direction(0, 0, (((- _frl__hor) * _frl_width) / 2), (((- _frl__ver) * _frl_height) / 2));
_frl_unspike = (_frl__spike > 0);
draw_vertex_texture((((x - _frl_so_x) - ((_frl__hor * _frl_width) / 2)) + lengthdir_x(_frl__spike, _frl__dir)), (((y - _frl_so_y) - ((_frl__ver * _frl_height) / 2)) + lengthdir_y(_frl__spike, _frl__dir)), _frl__vx, _frl__vy);
}
}
draw_primitive_end();
}
}
if(__fr_break3) break;
}}
gpu_set_fog(0, c_white, 0, 0);
;
surface_reset_target();
;
fr_Objects_Frontier_Bosses_mod_gml_draw_surface_rgb(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface, _frl_so_x, _frl_so_y, 1, 1, 0, 1, 4);
;
if (array_length(_frl__hurt)) {
{
surface_set_target(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface);
;
draw_clear_alpha(c_white, 0);
gpu_set_fog(1, c_white, 0, 0);
{ var __fr_with4 = scrFRWithValues(_frl__hurt), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRDrawSpriteExt(sprite_index, image_index, (x - _frl_so_x), ((y - _frl_so_y) - (scrFRVariableExists(scrFRSelf(self), "z") ? z : 0)), image_xscale, image_yscale, image_angle, c_white, 1);
;
var _frl__noise = 4;
;
}
}
if(__fr_break6) break;
}}
gpu_set_fog(0, c_white, 0, 0);
;
surface_reset_target();
;
fr_Objects_Frontier_Bosses_mod_gml_draw_surface_rgb(global.fr_module_vars[$ "mod:Frontier_Bosses"].celestial_surface, _frl_so_x, _frl_so_y, 1, 1, 0, 1, 6);
}
}
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:2021
function fr_Objects_Frontier_Bosses_mod_gml_draw_surface_rgb(_frl__surf=undefined, _frl__x=undefined, _frl__y=undefined, _frl__xscale=undefined, _frl__yscale=undefined, _frl__angle=undefined, _frl__alpha=undefined, _frl__scatter=undefined) {
var _frl__c = global.fr_module_vars[$ "mod:Frontier_Bosses"].celestialColorsList;
var _frl__w = (scrFRSourceFrame() * scrFRSourceScale());
;
gpu_set_blendmode(bm_add);
;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__c)); _frl_i++) {
gpu_set_fog(true, scrFRIndexGet(_frl__c, _frl_i), 0, 0);
;
var _frl__s = (_frl_i * 120);
;
var _frl__h = lengthdir_x((sin(((_frl__w + _frl__s) * 0.2)) * _frl__scatter), (_frl__w + _frl__s));
var _frl__v = lengthdir_y((sin(((_frl__w + _frl__s) * 0.2)) * _frl__scatter), (_frl__w + _frl__s));
;
draw_surface_ext(_frl__surf, (_frl__x + _frl__h), (_frl__y + _frl__v), _frl__xscale, _frl__yscale, _frl__angle, c_white, _frl__alpha);
;
}
}
gpu_set_fog(false, c_white, 0, 0);
;
gpu_set_blendmode(bm_normal);
;
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

// Original Objects/Frontier_Bosses.mod.gml:2058
function fr_Objects_Frontier_Bosses_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Bosses.mod.gml:2059
function fr_Objects_Frontier_Bosses_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Bosses.mod.gml:2060
function fr_Objects_Frontier_Bosses_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Bosses.mod.gml:2061
function fr_Objects_Frontier_Bosses_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Bosses.mod.gml:2062
function fr_Objects_Frontier_Bosses_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Bosses.mod.gml:2063
function fr_Objects_Frontier_Bosses_mod_gml_enemy_face(_frl__dir=undefined) {
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

// Original Objects/Frontier_Bosses.mod.gml:2064
function fr_Objects_Frontier_Bosses_mod_gml_enemy_look(_frl__dir=undefined) {
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

// Original Objects/Frontier_Bosses.mod.gml:2065
function fr_Objects_Frontier_Bosses_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Bosses.mod.gml:2066
function fr_Objects_Frontier_Bosses_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Bosses.mod.gml:2067
function fr_Objects_Frontier_Bosses_mod_gml_GunEnemy_draw() {
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

// Original Objects/Frontier_Bosses.mod.gml:2068
function fr_Objects_Frontier_Bosses_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Bosses_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Bosses_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Bosses.mod.gml:2069
function fr_Objects_Frontier_Bosses_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Bosses_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Bosses_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Bosses.mod.gml:2071
function fr_Objects_Frontier_Bosses_mod_gml_nothing() {

}

// Original Objects/Frontier_Bosses.mod.gml:2074
function fr_Objects_Frontier_Bosses_mod_gml_enemy_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm0") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm0_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Bosses_mod_gml_alarm1_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Bosses_mod_gml_enemy_sprite);
;
}

// Original Objects/Frontier_Bosses.mod.gml:2091
function fr_Objects_Frontier_Bosses_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Bosses.mod.gml:2101
function fr_Objects_Frontier_Bosses_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Bosses"].sprGenericTrail);
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

// Original Objects/Frontier_Bosses.mod.gml:2113
function fr_Objects_Frontier_Bosses_mod_gml_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return ((_frl_b - _frl_a) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original Objects/Frontier_Bosses.mod.gml:2117
function fr_Objects_Frontier_Bosses_mod_gml_corpse_drop() {
{ var __fr_with1 = scrFRWithValues((argument_count>0 ? argument[0] : undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
size = __fr_other7.size;
;
var __fr_other8=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other8.spr_dead);
;
var __fr_other9=scrFROther(other);
image_xscale = (scrFRVariableExists(__fr_other9, "right") ? __fr_other9.right : __fr_other9.image_xscale);
;
var __fr_other10=scrFROther(other);
direction = ((argument_count > 1) ? (argument_count>1 ? argument[1] : undefined) : __fr_other10.direction);
;
var __fr_other11=scrFROther(other);
speed = (((argument_count > 2) ? (argument_count>2 ? argument[2] : undefined) : (__fr_other11.speed / timescale))) * timescale;
;
if (((! scrFRInstanceIs((scrFROther(other)), prop)) && scrFRInstanceIs((scrFROther(other)), hitme))) {
{
var __fr_other12=scrFROther(other);
mask_index = __fr_other12.mask_index;
;
var __fr_other13=scrFROther(other);
speed += (max(0, ((- __fr_other13.hp) / 5))) * timescale;
;
var __fr_other14=scrFROther(other);
speed += (((8 * scrFRGetSkill(mut_impact_wrists)) * scrFRInstanceIs(__fr_other14, enemy))) * timescale;
;
}
}
speed = (min((speed / timescale), 16)) * timescale;
;
if ((size > 0)) {
{
speed /= size;
;
}
}
return scrFRSelf(self);
;
}
}
if(__fr_break6) break;
}}
}
}
if(__fr_break3) break;
}}
return noone;
;
}

// Original Objects/Frontier_Bosses.mod.gml:2156
function fr_Objects_Frontier_Bosses_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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

// Original Objects/Frontier_Bosses.mod.gml:2179
function fr_Objects_Frontier_Bosses_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Bosses.mod.gml:2193
function fr_Objects_Frontier_Bosses_mod_gml_boss_intro(_frl__name=undefined) {
{ var __fr_with1 = scrFRWithValues(MusCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1);
;
scrFRAlarmWrite(scrFRSelf(self), 3, (- 1));
;
}
}
if(__fr_break3) break;
}}
if ((_frl__name != "")) {
{
{ var __fr_with4 = scrFRWithValues(scrFRBindBeginStep(fr_Objects_Frontier_Bosses_mod_gml_boss_intro_step, 0)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
boss = _frl__name;
;
loops = 0;
;
intro = true;
;
spr_main = ("../sprites/menu/intros/spr" + string(boss) + "Main.png");
spr_back = ("../sprites/menu/intros/spr" + string(boss) + "Back.png");
spr_name = ("../sprites/menu/intros/spr" + string(boss) + "Name.png");
return real(id);
;
}
}
if(__fr_break6) break;
}}
}
}
return noone;
;
}

// Original Objects/Frontier_Bosses.mod.gml:2225
function fr_Objects_Frontier_Bosses_mod_gml_boss_intro_step() {
if (intro) {
{
intro = false;
;
if ((((! intro) && (UberCont.opt_bossintro == true)) && (GameCont.loops <= loops))) {
{
scrFRSpriteReplaceImage(sprBossIntro, spr_main, 0);
;
scrFRSpriteReplaceImage(sprBossIntroBackLayer, spr_back, 0);
;
scrFRSpriteReplaceImage(sprBossName, spr_name, 0);
;
var _frl__lastSub = GameCont.subarea;
var _frl__lastLoop = GameCont.loops;
var _frl__lastIntro = UberCont.opt_bossintro;
;
GameCont.loops = 0;
;
UberCont.opt_bossintro = true;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, BanditBoss)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRSelf(self)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
event_perform(ev_alarm, 6);
;
}
}
if(__fr_break6) break;
}}
scrFRSoundStop(sndBigBanditIntro);
;
scrFRDelete(scrFRSelf(self));
;
}
}
if(__fr_break3) break;
}}
GameCont.subarea = _frl__lastSub;
;
GameCont.loops = _frl__lastLoop;
;
UberCont.opt_bossintro = _frl__lastIntro;
;
}
}
}
} else {
{
scrFRSpriteRestore(sprBossIntro);
;
scrFRSpriteRestore(sprBossIntroBackLayer);
;
scrFRSpriteRestore(sprBossName);
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Bosses.mod.gml:2268
function fr_Objects_Frontier_Bosses_mod_gml_boss_hp(_frl__hp=undefined) {
var _frl__players = 0;
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
_frl__players += scrFRPlayerIsActive(_frl_i);
;
}
}
return round(((_frl__hp * (1 + ((1 / 3) * GameCont.loops))) * (1 + (0.5 * (_frl__players - 1)))));
;
}
