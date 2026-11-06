#macro frMacro_Objects_Frontier_Sewers_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Sewers"].scr

#macro frMacro_Objects_Frontier_Sewers_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Sewers_mod_gml_p_sprite2 (((sprite_index2 != spr_hurt2) || frMacro_Objects_Frontier_Sewers_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle2 : spr_walk2) : sprite_index)

#macro frMacro_Objects_Frontier_Sewers_mod_gml_scoreAmmo 0

#macro frMacro_Objects_Frontier_Sewers_mod_gml_scoreHealth 1

#macro frMacro_Objects_Frontier_Sewers_mod_gml_scoreRads 2

#macro frMacro_Objects_Frontier_Sewers_mod_gml_scoreWeapon 3

#macro frMacro_Objects_Frontier_Sewers_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Sewers_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Sewers_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Sewers_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Sewers_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Sewers_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Sewers_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Sewers.mod.gml:1
function fr_Objects_Frontier_Sewers_mod_gml___load() {

}

// Original Objects/Frontier_Sewers.mod.gml:1
function fr_Objects_Frontier_Sewers_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Sewers_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Sewers_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Sewers_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Sewers.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Sewers", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Sewers"].sndWoodBreak = sndFR_sndWoodBreak_f483cf606c9f;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorIdle = sprFR_sprCasinoGatorIdle_0843bf732c45;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorWalk = sprFR_sprCasinoGatorWalk_3a106a76c3bd;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorHurt = sprFR_sprCasinoGatorHurt_0776c8db29f7;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorDead = sprFR_sprCasinoGatorDead_9337e06d5443;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorWeap = sprFR_sprCasinoGatorWeap_8bf5926c1721;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorIdle = sprFR_sprPaintorIdle_472bf51c5b72;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayIdle = sprFR_sprPaintorOverlayIdle_69ffe6d8c67e;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorWalk = sprFR_sprPaintorWalk_74d8f68a219b;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayWalk = sprFR_sprPaintorOverlayWalk_fabcc326ec9a;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorHurt = sprFR_sprPaintorHurt_2d595a487280;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayHurt = sprFR_sprPaintorOverlayHurt_7ae4653d769f;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorDead = sprFR_sprPaintorDead_f9404ddb3da2;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorWeap = sprFR_sprPaintorWeap_d6f22dd9cf47;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorGameover = sprFR_sprPaintorGameover_c5abb9b5689b;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSludgeTrap = sprFR_sprSludgeTrap_37ed66898d28;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSludgeSplat = sprFR_sprSludgeSplat_2c9f82ecaa1f;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGas = sprFR_sprPaintGas_b4a69c62a354;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGasSmall = sprFR_sprPaintGasSmall_f9857d4efdd3;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGasBig = sprFR_sprPaintGasBig_1d6d4f4ba171;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShell = sprFR_sprPaintShell_70bb3bc31e62;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellOverlay = sprFR_sprPaintShellOverlay_2e7296bc5b87;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellDisappear = sprFR_sprPaintShellDisappear_52b8be29540b;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellDisappearOverlay = sprFR_sprPaintShellDisappearOv_938881f618c9;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak = sprFR_sprPaintStreak_11a9db06c62d;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintBomb = sprFR_sprPaintBomb_38979e28d4a9;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintSplat = sprFR_sprPaintSplat_b126f445ccc7;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintDust = sprFR_sprPaintDust_eea85fd7c071;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachine = sprFR_sprSlotMachine_1f50157e1e6a;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineHurt = sprFR_sprSlotMachineHurt_059394891b6d;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineDead = sprFR_sprSlotMachineDead_20525036189a;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineSpin = sprFR_sprSlotMachineSpin_e4fb520998b0;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLights = sprFR_sprSlotMachineLights_8e521ce02f33;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsLoser = sprFR_sprSlotMachineLightsLose_0625ad58a305;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsWinner = sprFR_sprSlotMachineLightsWinn_5f9dc5e054fd;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsSpinning = [sprFR_sprSlotMachineLightsSpin_88e83c7f4dd6, sprFR_sprSlotMachineLightsSpin_21f502419c3b, sprFR_sprSlotMachineLightsSpin_b162e50cd957, sprFR_sprSlotMachineLightsSpin_0e2bf5dc0913];
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotSpinning = sprFR_sprSlotSpinning_5f93dbfccbf7;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlot = [sprFR_sprSlotAmmo_bc48a6397e15, sprFR_sprSlotHP_b9b593e6a226, sprFR_sprSlotRads_60161c6e27f9, sprFR_sprSlotWeapon_08ff090d9200];
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounter = sprFR_sprCounter_86973baa1ef9;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounterHurt = sprFR_sprCounterHurt_034db5d91452;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounterDead = sprFR_sprCounterDead_644432695bda;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSodaCans = sprFR_sprSodaCans_a7b815996b8c;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprBartenderGator = sprFR_sprBartenderGator_e3d906644c25;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].shdCounter = sprFR_shdCounter_834d4cf5b456;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].mskCounter = sprFR_mskCounter_b94f9ed64245;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouch = sprFR_sprCouch_996a7d00f340;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchHurt = sprFR_sprCouchHurt_7033c4620e76;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchDead = sprFR_sprCouchDead_8e78081e6d05;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchgoerGator = sprFR_sprCouchgoerGator_eea791412384;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchgoerCat = sprFR_sprCouchgoerCat_cc84cf136657;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTV = sprFR_sprCasinoTV_77ae960b3279;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVHurt = sprFR_sprCasinoTVHurt_47f40b22f352;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVDead = sprFR_sprCasinoTVDead_a6a2ab7f117c;
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVCraft = [sprFR_sprCasinoTVCraft1_8d9a7b4bb6c3, sprFR_sprCasinoTVCraft2_6b3ab00f7fac, sprFR_sprCasinoTVCraft3_bcf7b9214e4e];
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVUpturned = [sprFR_sprCasinoTVUpturned1_57567594d13a, sprFR_sprCasinoTVUpturned2_433ee31151b0, sprFR_sprCasinoTVUpturned3_baf7a621b34d];
;
global.fr_module_vars[$ "mod:Frontier_Sewers"].sprGraffiti = sprFR_sprGraffiti_68d5086808bd;
;
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Sewers.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Sewers.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Sewers.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Sewers.mod.gml:91
function fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Bartender";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorDead;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoGatorWeap;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "BARTENDER"];
spr_shadow = shd24;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
snd_hurt = sndGatorHit;
;
snd_dead = sndGatorDie;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 18, "=");
;
hp = max_hp;
;
raddrop = 12;
;
maxspeed = (3.5) * timescale;
;
walkspeed = (maxspeed / timescale);
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
gunangle = 180;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 10, "=");
;
on_step = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_step];
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_GunEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_death;
;
on_alrm1 = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_alrm1];
;
on_alrm2 = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:142
function fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Sewers_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Sewers_mod_gml_alarm2_run)) {
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
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Sewers_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Sewers.mod.gml:158
function fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if ((fr_Objects_Frontier_Sewers_mod_gml_enemy_target(x, y) and frMacro_Objects_Frontier_Sewers_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(frMacro_Objects_Frontier_Sewers_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Sewers_mod_gml_target_distance > 128)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk((frMacro_Objects_Frontier_Sewers_mod_gml_target_direction + fr_Objects_Frontier_Sewers_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
if ((frMacro_Objects_Frontier_Sewers_mod_gml_target_distance < 128)) {
{
if ((fr_Objects_Frontier_Sewers_mod_gml_chance(3, 4) && (frMacro_Objects_Frontier_Sewers_mod_gml_target_distance > 32))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (45 + scrFRSourceIRandom(20)), "=");
;
scrFRInstanceCreate(x, y, HitWarning);
scrFRAlarmWrite(scrFRSelf(self), 2, 10, "=");
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Sewers_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
}
}
}
}
} else {
{
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(scrFRSourceRandom(360), 30);
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:193
function fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_alrm2() {
var _frl__spd = 1;
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((8 + _frl__spd)) * timescale;
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
_frl__spd += 1;
;
scrFRSoundPitch(sndFireShotgun, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndEraser, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRMotionAdd(gunangle, (- 1));
}
}

// Original Objects/Frontier_Sewers.mod.gml:210
function fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_death() {
scrFRPickupDrop(200, 0);
;
}

// Original Objects/Frontier_Sewers.mod.gml:213
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Paintor";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorIdle;
;
spr_idle2 = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorWalk;
;
spr_walk2 = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorHurt;
;
spr_hurt2 = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorOverlayHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorDead;
;
spr_weap = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorWeap;
;
spr_gameover = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintorGameover;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
sprite_index2 = spr_idle2;
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_gameover, "PAINTOR"];
spr_shadow = shd24;
;
spr_shadow_y = (- 1);
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
var _frl__colorHue = scrFRSourceChoose(scrFRSourceRandom(50), (106 + scrFRSourceRandom(149)));
;
color = make_color_hsv(_frl__colorHue, 255, 255);
;
color2 = make_color_hsv(_frl__colorHue, 255, (230 + scrFRSourceIRandom(10)));
;
color3 = make_color_hsv(_frl__colorHue, 255, (200 + scrFRSourceIRandom(10)));
;
snd_hurt = sndGatorHit;
;
snd_dead = sndGatorDie;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 18, "=");
;
hp = max_hp;
;
raddrop = 12;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
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
gunangle = 180;
;
ammo = 0;
;
target_x = 10016;
;
target_y = 10016;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 45, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_Paintor_step];
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_Paintor_draw;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_Paintor_hurt;
;
on_death = fr_Objects_Frontier_Sewers_mod_gml_Paintor_death;
;
on_alrm1 = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_Paintor_alrm1];
;
on_alrm2 = ["mod", "Frontier_Sewers", fr_Objects_Frontier_Sewers_mod_gml_Paintor_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:280
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_step() {
; // macro hoisted: p_sprite2
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Sewers_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Sewers_mod_gml_alarm2_run)) {
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
if (frMacro_Objects_Frontier_Sewers_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite((((speed / timescale) > 0) ? spr_walk : spr_idle));
;
sprite_index2 = (((speed / timescale) > 0) ? spr_walk2 : spr_idle2);
;
}
} else {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Sewers_mod_gml_enemy_sprite);
;
if ((sprite_index2 != spr_hurt2)) {
{
sprite_index2 = frMacro_Objects_Frontier_Sewers_mod_gml_p_sprite2;
;
}
}
}
}
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Sewers.mod.gml:322
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(30)), "=");
;
if ((ammo > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 3, "=");
;
if (fr_Objects_Frontier_Sewers_mod_gml_enemy_target(x, y)) {
{
gunangle = ((gunangle + clamp(angle_difference(frMacro_Objects_Frontier_Sewers_mod_gml_target_direction, gunangle), (- 10), 10)) + scrFRSourceRandomRange((- 5), 5));
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(gunangle);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet3)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((14 + scrFRSourceRandomRange((- 2), 2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 10), 10));
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
var _frl__randColorHue = scrFRSourceChoose(scrFRSourceRandom(50), (106 + scrFRSourceRandom(149)));
var _frl__randColor = make_color_hsv(_frl__randColorHue, 255, 255);
var _frl__randColor2 = make_color_hsv(_frl__randColorHue, 255, (230 + scrFRSourceIRandom(10)));
var _frl__randColor3 = make_color_hsv(_frl__randColorHue, 255, (200 + scrFRSourceIRandom(10)));
var _frl__shellColor = scrFRSourceChoose("Random", "Gator");
;
{ var __fr_switch_value8=_frl__shellColor, __fr_switch_case9=-1;
if(__fr_switch_case9==-1 && __fr_switch_value8==("Random")) __fr_switch_case9=0;
if(__fr_switch_case9==-1 && __fr_switch_value8==("Gator")) __fr_switch_case9=1;
if(__fr_switch_case9==-1) __fr_switch_case9=-1;
switch(__fr_switch_case9) {
case 0:
{ var __fr_with10 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintShell_create(x, y, _frl__randColor, _frl__randColor2, _frl__randColor3)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
speed = ((14 + scrFRSourceRandomRange((- 2), 2))) * timescale;
;
var __fr_other13=scrFROther(other);
direction = (__fr_other13.gunangle + scrFRSourceRandomRange((- 10), 10));
;
image_angle = direction;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
var __fr_other15=scrFROther(other);
team = __fr_other15.team;
var __fr_other16=scrFROther(other);
hitid = __fr_other16.hitid;
;
}
}
if(__fr_break12) break;
}}
repeat (2) {
{ var __fr_with17 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak);
;
image_index = scrFRSourceIRandom(1);
;
image_blend = _frl__randColor;
;
var __fr_other20=scrFROther(other);
direction = (__fr_other20.gunangle + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break19) break;
}}
}
break;
;
case 1:
{ var __fr_with21 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintShell_create(x, y, color, color2, color3)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
speed = ((14 + scrFRSourceRandomRange((- 2), 2))) * timescale;
;
var __fr_other24=scrFROther(other);
direction = (__fr_other24.gunangle + scrFRSourceRandomRange((- 10), 10));
;
image_angle = direction;
;
var __fr_other25=scrFROther(other);
creator = __fr_other25;
;
var __fr_other26=scrFROther(other);
team = __fr_other26.team;
var __fr_other27=scrFROther(other);
hitid = __fr_other27.hitid;
;
}
}
if(__fr_break23) break;
}}
repeat (2) {
{ var __fr_with28 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak);
;
image_index = scrFRSourceIRandom(1);
;
var __fr_other31=scrFROther(other);
image_blend = __fr_other31.color;
;
var __fr_other32=scrFROther(other);
direction = (__fr_other32.gunangle + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break30) break;
}}
}
break;
;
}
}
scrFRSoundPitch(sndPopgun, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndHitFlesh, (1.1 + scrFRSourceRandom(0.3)));
;
wkick += 3;
;
}
}
if (((-- ammo) <= 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 60, "=");
;
if ((fr_Objects_Frontier_Sewers_mod_gml_chance(1, 8) && (scrFRAlarmRead(scrFRSelf(self), 2) <= 0))) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Sewers_mod_gml_enemy_target(x, y)) {
{
if ((frMacro_Objects_Frontier_Sewers_mod_gml_target_distance > 160)) {
{
if (frMacro_Objects_Frontier_Sewers_mod_gml_target_visible) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk((frMacro_Objects_Frontier_Sewers_mod_gml_target_direction + fr_Objects_Frontier_Sewers_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
if ((fr_Objects_Frontier_Sewers_mod_gml_chance(1, 4) && (scrFRAlarmRead(scrFRSelf(self), 2) <= 0))) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
}
} else {
{
if (fr_Objects_Frontier_Sewers_mod_gml_chance(1, 3)) {
{
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(direction);
;
}
}
}
}
}
}
}
}
if (((frMacro_Objects_Frontier_Sewers_mod_gml_target_distance < 160) && frMacro_Objects_Frontier_Sewers_mod_gml_target_visible)) {
{
if ((fr_Objects_Frontier_Sewers_mod_gml_chance(3, 4) && (frMacro_Objects_Frontier_Sewers_mod_gml_target_distance > 48))) {
{
scrFRInstanceCreate(x, y, HitWarning);
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(frMacro_Objects_Frontier_Sewers_mod_gml_target_direction);
;
scrFRAlarmWrite(scrFRSelf(self), 1, 8, "=");
;
ammo = 5;
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(((gunangle + 180) + fr_Objects_Frontier_Sewers_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
if ((fr_Objects_Frontier_Sewers_mod_gml_chance(1, 3) && (scrFRAlarmRead(scrFRSelf(self), 2) <= 0))) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Sewers_mod_gml_chance(1, 3)) {
{
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(direction);
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Sewers_mod_gml_chance(1, 3)) {
{
fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(scrFRSourceRandom(360), 30);
;
fr_Objects_Frontier_Sewers_mod_gml_enemy_look(direction);
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:468
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_alrm2() {
if (scrFRInstanceExists(target)) {
{
if ((frMacro_Objects_Frontier_Sewers_mod_gml_target_distance < 224)) {
{
target_x = ((target.x + (target.hspeed / timescale)) + scrFRSourceRandomRange((- 24), 24));
;
target_y = ((target.y + (target.vspeed / timescale)) + scrFRSourceRandomRange((- 24), 24));
;
var _frl__randColorHue = scrFRSourceChoose(scrFRSourceRandom(50), (106 + scrFRSourceRandom(149)));
var _frl__randColor = make_color_hsv(_frl__randColorHue, 255, 255);
var _frl__randColor2 = make_color_hsv(_frl__randColorHue, 255, (230 + scrFRSourceIRandom(10)));
var _frl__randColor3 = make_color_hsv(_frl__randColorHue, 255, (200 + scrFRSourceIRandom(10)));
var _frl__bombColor = scrFRSourceChoose("Random", "Gator", "Gator");
;
{ var __fr_switch_value1=_frl__bombColor, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Random")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Gator")) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{ var __fr_with3 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_create(x, y, _frl__randColor, _frl__randColor2, _frl__randColor3)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
mask_index = mskNone;
;
z = 13;
;
zspeed = (11 + scrFRSourceRandom(2));
;
zfriction = 0.6;
;
var __fr_other6=scrFROther(other);
direction = point_direction(x, y, __fr_other6.target_x, __fr_other6.target_y);
;
var __fr_other7=scrFROther(other);
speed = (((point_distance(x, y, __fr_other7.target_x, __fr_other7.target_y) * zfriction) / (zspeed * 2))) * timescale;
;
image_angle = direction;
;
var __fr_other8=scrFROther(other);
target_x = __fr_other8.target_x;
;
var __fr_other9=scrFROther(other);
target_y = __fr_other9.target_y;
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
}
}
if(__fr_break5) break;
}}
break;
;
case 1:
{ var __fr_with13 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_create(x, y, color, color2, color3)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
mask_index = mskNone;
;
z = 13;
;
zspeed = (11 + scrFRSourceRandom(2));
;
zfriction = 0.6;
;
var __fr_other16=scrFROther(other);
direction = point_direction(x, y, __fr_other16.target_x, __fr_other16.target_y);
;
var __fr_other17=scrFROther(other);
speed = (((point_distance(x, y, __fr_other17.target_x, __fr_other17.target_y) * zfriction) / (zspeed * 2))) * timescale;
;
image_angle = direction;
;
var __fr_other18=scrFROther(other);
target_x = __fr_other18.target_x;
;
var __fr_other19=scrFROther(other);
target_y = __fr_other19.target_y;
;
var __fr_other20=scrFROther(other);
team = __fr_other20.team;
;
var __fr_other21=scrFROther(other);
creator = __fr_other21;
;
var __fr_other22=scrFROther(other);
hitid = __fr_other22.hitid;
;
}
}
if(__fr_break15) break;
}}
break;
;
}
}
scrFRSoundPitchVolume(sndMeleeFlip, (0.8 + scrFRSourceRandom(0.1)), 1.5);
;
scrFRAlarmWrite(scrFRSelf(self), 2, 380, "=");
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 60, "=");
;
}
}
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:531
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
sprite_index2 = spr_hurt2;
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

// Original Objects/Frontier_Sewers.mod.gml:542
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_draw() {
if ((gunangle < 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
scrFRDrawSpriteExt(sprite_index2, image_index, x, y, (image_xscale * right), image_yscale, image_angle, color, image_alpha);
;
if ((gunangle >= 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:554
function fr_Objects_Frontier_Sewers_mod_gml_Paintor_death() {
scrFRPickupDrop(22, 10);
;
repeat (6) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create(x, y, scrFRSourceChoose(true, false))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other4.color, __fr_other4.color2, __fr_other4.color3);
;
direction = scrFRSourceRandom(360);
;
speed = (5) * timescale;
;
friction = (0.7) * (timescale * timescale);
;
lifetime = (100 + scrFRSourceIRandom(20));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak);
;
image_index = scrFRSourceIRandom(1);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.color;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((5 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Sewers.mod.gml:574
function fr_Objects_Frontier_Sewers_mod_gml_PaintBombLinger_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__color2=undefined, _frl__color3=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
color = _frl__color;
;
color2 = _frl__color2;
;
color3 = _frl__color3;
;
image_blend = color;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGasBig);
;
depth = (- 8);
;
image_angle = scrFRSourceRandom(360);
;
rotateSpeed = 1.2;
;
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
fr_bloom = [1.2, 0.1];
;
mask_index = mskNone;
;
lifetime = 300;
;
range = 60;
;
allGrownUp = false;
;
maxSize = 1;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_PaintBombLinger_step;
;
on_hit = fr_Objects_Frontier_Sewers_mod_gml_nothing;
;
on_wall = fr_Objects_Frontier_Sewers_mod_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:605
function fr_Objects_Frontier_Sewers_mod_gml_PaintBombLinger_step() {
if ((scrFRSourceRandom(20) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create((x + scrFRSourceRandomRange((- range), range)), (y + scrFRSourceRandomRange((- range), range)), false)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(2)) * timescale;
;
friction = (0.05) * (timescale * timescale);
;
var __fr_other4=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other4.color, __fr_other4.color2, __fr_other4.color3);
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(12) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create((x + scrFRSourceRandomRange((- range), range)), (y + scrFRSourceRandomRange((- range), range)), true)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(2)) * timescale;
;
friction = (0.05) * (timescale * timescale);
;
var __fr_other8=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other8.color, __fr_other8.color2, __fr_other8.color3);
}
}
if(__fr_break7) break;
}}
}
}
lifetime -= scrFRSourceScale();
;
image_angle += rotateSpeed;
;
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.2;
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

// Original Objects/Frontier_Sewers.mod.gml:643
function fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create(_frl__x=undefined, _frl__y=undefined, _frl__small=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGas);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
depth = (- 9);
;
rotateSpeed = ((scrFRSourceRandomRange(2, 5) * scrFRSourceChoose((- 1), 1)) * scrFRSourceScale());
;
image_xscale = 0;
;
image_yscale = image_xscale;
;
fr_bloom = [1.5, 0.1];
;
mask_index = mskNone;
;
speed = (0) * timescale;
;
typ = 0;
;
damage = 0;
;
team = 0;
;
hitid = [sprite_index, "PAINT"];
;
lifetime = 200;
;
allGrownUp = false;
;
maxSize = 1;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_PaintGas_step;
;
on_hit = fr_Objects_Frontier_Sewers_mod_gml_nothing;
;
if ((_frl__small == true)) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintGasSmall);
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

// Original Objects/Frontier_Sewers.mod.gml:678
function fr_Objects_Frontier_Sewers_mod_gml_PaintGas_step() {
lifetime -= scrFRSourceScale();
;
image_angle += rotateSpeed;
;
if (((image_xscale < maxSize) && (allGrownUp == false))) {
{
image_xscale += 0.2;
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

// Original Objects/Frontier_Sewers.mod.gml:699
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__color2=undefined, _frl__color3=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PaintShell";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShell);
;
spr_overlay = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellOverlay;
;
spr_fade = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellDisappear;
;
spr_fade_over = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellDisappearOverlay;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintShellDisappear;
;
color = _frl__color;
;
color2 = _frl__color2;
;
color3 = _frl__color3;
;
speed = (((10 + scrFRSourceRandom(2)) * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
friction = (0.6) * (timescale * timescale);
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
hitid = [sprite_index, "PAINT SHELL"];
;
minspeed = 1.2;
;
on_anim = fr_Objects_Frontier_Sewers_mod_gml_PaintShell_anim;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_PaintShell_step;
;
on_wall = fr_Objects_Frontier_Sewers_mod_gml_PaintShell_wall;
;
on_hit = fr_Objects_Frontier_Sewers_mod_gml_PaintShell_hit;
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_PaintShell_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:732
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_anim() {
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

// Original Objects/Frontier_Sewers.mod.gml:742
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_step() {
if ((scrFRSourceRandom(16) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.direction + 180) + fr_Objects_Frontier_Sewers_mod_gml_orandom(10)), ((__fr_other4.speed / timescale) / 2));
}
}
if(__fr_break3) break;
}}
}
}
if ((((speed / timescale) < minspeed) && (sprite_index != spr_fade))) {
{
fr_Objects_Frontier_Sewers_mod_gml_PaintShell_spreadpaint();
;
sprite_index = scrFRAreaSourceSprite(spr_fade);
;
spr_overlay = spr_fade_over;
;
image_index = 0;
;
image_speed = (0.4) * timescale;
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:758
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_wall() {
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
speed = (((speed / timescale) * 0.9)) * timescale;
;
}

// Original Objects/Frontier_Sewers.mod.gml:769
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_spreadpaint() {
scrFRSoundPitch(sndHitFlesh, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndToxicBoltGas, (1.2 + scrFRSourceRandom(0.2)));
;
repeat (4) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create(x, y, scrFRSourceChoose(true, false))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other4.color, __fr_other4.color2, __fr_other4.color3);
;
direction = scrFRSourceRandom(360);
;
speed = (5) * timescale;
;
friction = (0.5) * (timescale * timescale);
;
lifetime = (80 + scrFRSourceIRandom(20));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak);
;
image_index = scrFRSourceIRandom(1);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.color;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((5 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}

// Original Objects/Frontier_Sewers.mod.gml:790
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_hit() {
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
fr_Objects_Frontier_Sewers_mod_gml_PaintShell_spreadpaint();
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Sewers.mod.gml:795
function fr_Objects_Frontier_Sewers_mod_gml_PaintShell_draw() {
draw_self();
;
scrFRDrawSpriteExt(spr_overlay, image_index, x, y, image_xscale, image_yscale, image_angle, color, image_alpha);
gpu_set_blendmode(bm_add);
;
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * 1.6), (image_yscale * 1.6), image_angle, image_blend, 0.3);
;
scrFRDrawSpriteExt(spr_overlay, image_index, x, y, (image_xscale * 1.6), (image_yscale * 1.6), image_angle, color, 0.3);
;
gpu_set_blendmode(bm_normal);
;
}

// Original Objects/Frontier_Sewers.mod.gml:803
function fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined, _frl__color2=undefined, _frl__color3=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PaintBomb";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintBomb);
;
color = _frl__color;
;
color2 = _frl__color2;
;
color3 = _frl__color3;
;
speed = (((10 + scrFRSourceRandom(2)) * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
friction = (0.6) * (timescale * timescale);
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
hitid = [sprite_index, "PAINT BOMB"];
;
z = 0;
;
zspeed = 0;
;
zfriction = 1;
;
turnspeed = ((10 * scrFRSourceChoose((- 1), 1)) * scrFRSourceScale());
;
target_x = 0;
;
target_y = 0;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_step;
;
on_destroy = fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_destroy;
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:835
function fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_step() {
if ((scrFRSourceRandom(4) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), ((y - z) + scrFRSourceRandomRange((- 8), 8)), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprBreath);
;
depth = (- 11);
;
var __fr_other4=scrFROther(other);
direction = (((__fr_other4.direction + 180) + (__fr_other4.z / 70)) + scrFRSourceRandomRange((- 20), 20));
;
speed = (scrFRSourceRandom(1)) * timescale;
;
var __fr_other5=scrFROther(other);
image_blend = __fr_other5.color;
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
mask_index = mskEnemyBullet1;
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
depth = (- 10);
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:883
function fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_destroy() {
scrFRSoundPitch(sndHitFlesh, (1.1 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndToxicBarrelGas, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndExplosionS, (1.1 + scrFRSourceRandom(0.1)));
;
fr_Objects_Frontier_Sewers_mod_gml_PaintBombLinger_create(x, y, color, color2, color3);
;
repeat (8) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_PaintGas_create(x, y, scrFRSourceChoose(true, false))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_blend = scrFRSourceChoose(__fr_other4.color, __fr_other4.color2, __fr_other4.color3);
;
direction = scrFRSourceRandom(360);
;
speed = (8) * timescale;
;
friction = (0.5) * (timescale * timescale);
;
lifetime = (80 + scrFRSourceIRandom(20));
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintStreak);
;
image_index = scrFRSourceIRandom(1);
;
var __fr_other8=scrFROther(other);
image_blend = __fr_other8.color;
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((8 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
var __fr_other9=scrFROther(other);
fr_Objects_Frontier_Sewers_mod_gml_PaintSplat_create(x, y, __fr_other9.color);
}

// Original Objects/Frontier_Sewers.mod.gml:908
function fr_Objects_Frontier_Sewers_mod_gml_PaintSplat_create(_frl__x=undefined, _frl__y=undefined, _frl__color=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_paintSplat";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprPaintSplat);
;
image_angle = scrFRSourceRandom(360);
;
image_blend = _frl__color;
;
depth = 7;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:920
function fr_Objects_Frontier_Sewers_mod_gml_PaintBomb_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, (y - z), (image_xscale + (z / 260)), (image_yscale + (z / 260)), image_angle, color, image_alpha);
;
}

// Original Objects/Frontier_Sewers.mod.gml:923
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrap_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, TrapScorchMark)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSludgeSplat);
;
depth = 7;
;
}
}
if(__fr_break6) break;
}}
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSludgeTrap);
;
depth = (- 1);
;
creator = instance_position(x, y, Wall);
;
fire_timer = (80 + scrFRSourceRandomRange(0, 30));
;
fire_mode = scrFRSourceChoose(1, 2);
on_step = fr_Objects_Frontier_Sewers_mod_gml_SludgeTrap_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:945
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrap_step() {
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((fire_timer > 0)) {
{
fire_timer -= scrFRSourceScale();
;
}
}
if (((! scrFRInstanceExists(Portal)) && (fire_timer <= 0))) {
{
fire_timer += 180;
;
fr_Objects_Frontier_Sewers_mod_gml_SludgeTrap_fire();
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:961
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrap_fire() {
if ((distance_to_object(Player) < 192)) {
{
scrFRSoundPitch(sndOasisMelee, (0.8 + scrFRSourceRandom(0.2)));
;
scrFRSoundPitch(sndOasisChest, (0.8 + scrFRSourceRandom(0.2)));
;
}
}
{ var __fr_switch_value1=fire_mode, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
if ((! instance_position((x + 8), (y + 20), Wall))) {
{
{ var __fr_with3 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_create((x + 8), (y + 16))), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
direction = 270;
;
}
}
if(__fr_break5) break;
}}
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate((x + 8), (y + 20), AcidStreak)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = (270 + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
}
}
if(__fr_break8) break;
}}
}
}
}
if ((! instance_position((x + 8), (y - 16), Wall))) {
{
{ var __fr_with9 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_create((x + 8), (y - 8))), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
direction = 90;
;
}
}
if(__fr_break11) break;
}}
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate((x + 8), (y - 16), AcidStreak)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = (90 + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
}
}
if(__fr_break14) break;
}}
}
}
}
fire_mode = 2;
;
break;
;
case 1:
if ((! instance_position((x - 16), (y + 4), Wall))) {
{
{ var __fr_with15 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_create((x - 2), (y + 8))), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
direction = 180;
;
}
}
if(__fr_break17) break;
}}
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate((x - 16), (y + 4), AcidStreak)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = (180 + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
}
}
if(__fr_break20) break;
}}
}
}
}
if ((! instance_position((x + 24), (y + 4), Wall))) {
{
{ var __fr_with21 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_create((x + 16), (y + 8))), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
direction = 0;
;
}
}
if(__fr_break23) break;
}}
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with24 = scrFRWithValues(scrFRInstanceCreate((x + 16), (y + 8), AcidStreak)), __fr_break26=false;
for (var __fr_index25=0; __fr_index25<array_length(__fr_with24); ++__fr_index25) {
if(scrFRScopeExists(__fr_with24[__fr_index25])) with (__fr_with24[__fr_index25]) {
{
speed = ((2 + scrFRSourceRandom(2))) * timescale;
;
direction = (0 + scrFRSourceRandomRange((- 45), 45));
;
image_angle = direction;
;
}
}
if(__fr_break26) break;
}}
}
}
}
fire_mode = 1;
;
break;
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1034
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = mskEnemyBullet1;
;
speed = (5) * timescale;
;
damage = 0;
;
sludgeDelay = 0;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_step;
;
on_hit = fr_Objects_Frontier_Sewers_mod_gml_nothing;
;
on_destroy = fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1049
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_step() {
sludgeDelay -= scrFRSourceScale();
;
if ((sludgeDelay <= 0)) {
{
sludgeDelay += ((speed / timescale) / 2);
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "GatorCreep_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
lifetime = 180;
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceCreate(x, y, AcidStreak);
}
}
if (((speed / timescale) <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1064
function fr_Objects_Frontier_Sewers_mod_gml_SludgeTrapProjectile_destroy() {
repeat ((3 + scrFRSourceIRandom(2))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, AcidStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = ((__fr_other4.direction + 180) + scrFRSourceRandomRange((- 25), 25));
;
speed = ((5 + scrFRSourceRandom(2))) * timescale;
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with5 = scrFRWithValues(scrFRModCall("mod", "Frontier_Labs", "GatorCreepBig_create", x, y)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
image_xscale = scrFRSourceChoose(0.4, 0.5);
;
image_yscale = image_xscale;
;
lifetime = 180;
;
}
}
if(__fr_break7) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1079
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoSlotMachine";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachine;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineDead;
;
spr_spin = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineSpin;
;
spr_lights = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLights;
;
spr_slots = [scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlot, scrFRSourceIRandom(3)), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlot, scrFRSourceIRandom(3)), scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlot, scrFRSourceIRandom(3))];
;
spr_shadow = shd64;
;
spr_shadow_y = 6;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
mask_index = mskBandit;
;
scrFRMaxHealthWrite(id, 150, "=");
;
hp = max_hp;
;
team = 0;
;
cost = 15;
;
pick = (- 1);
;
mytext = scrFRLocalize((("SPIN?#" + string(cost)) + "@g RADS"));
;
spinning = false;
;
spinTime = 0;
;
spins = 0;
;
spinLuck = 0;
;
slotScores = [0, 0, 0, 0];
;
lastScore = (- 1);
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_step;
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_draw;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_Prop_hurt;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Sewers_mod_gml_call(frMacro_Objects_Frontier_Sewers_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachinePrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
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

// Original Objects/Frontier_Sewers.mod.gml:1130
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachinePrompt_step() {
if (((! scrFRInstanceExists(creator)) || (creator.spinning == true))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_startspin();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1141
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_step() {
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
var __fr_other5=scrFROther(other);
image_xscale = __fr_other5.image_xscale;
;
var __fr_other6=scrFROther(other);
size = __fr_other6.size;
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
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Objects_Frontier_Sewers_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((spinning == true)) {
{
if ((spinTime > 0)) {
{
spinTime -= scrFRSourceScale();
;
if ((spins < 3)) {
{
if (((spinTime % 3) == 0)) {
{
scrFRSoundPitchVolume(sndHitMetal, (2.8 + scrFRSourceRandom(0.3)), 0.4);
;
}
}
}
}
}
} else {
{
if ((spins < 3)) {
{
spinTime = 27;
;
spins += 1;
;
var _frl__roll = frMacro_Objects_Frontier_Sewers_mod_gml_call(frMacro_Objects_Frontier_Sewers_mod_gml_scr.pool, [[frMacro_Objects_Frontier_Sewers_mod_gml_scoreAmmo, (1 + ((lastScore == frMacro_Objects_Frontier_Sewers_mod_gml_scoreAmmo) * spinLuck))], [frMacro_Objects_Frontier_Sewers_mod_gml_scoreHealth, (1 + ((lastScore == frMacro_Objects_Frontier_Sewers_mod_gml_scoreHealth) * spinLuck))], [frMacro_Objects_Frontier_Sewers_mod_gml_scoreRads, (1 + ((lastScore == frMacro_Objects_Frontier_Sewers_mod_gml_scoreRads) * spinLuck))], [frMacro_Objects_Frontier_Sewers_mod_gml_scoreWeapon, (1 + ((lastScore == frMacro_Objects_Frontier_Sewers_mod_gml_scoreWeapon) * spinLuck))]]);
scrFRMemberIndexWrite(scrFRSelf(self), "slotScores", [_frl__roll], 1, "+=");
;
lastScore = _frl__roll;
;
scrFRMemberIndexWrite(scrFRSelf(self), "spr_slots", [(spins - 1)], scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlot, _frl__roll), "=");
spr_lights = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsSpinning, spins);
;
scrFRSoundPitch(sndMenuCredits, 0.7);
;
}
} else {
{
spinning = false;
canspin = true;
;
fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_endspin();
;
}
}
}
}
}
}
; // macro hoisted: scoreAmmo
; // macro hoisted: scoreHealth
; // macro hoisted: scoreRads
; // macro hoisted: scoreWeapon
}

// Original Objects/Frontier_Sewers.mod.gml:1217
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_startspin() {
if ((GameCont.rad < cost)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
mytext = scrFRLocalize("NOT ENOUGH RADS!");
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose();
}
} else {
{
GameCont.rad -= cost;
;
spinning = true;
;
spins = 0;
;
spinTime = 27;
;
scrFRSoundPlay(sndServerBreak);
sprite_index = scrFRAreaSourceSprite(spr_spin);
;
spr_lights = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsSpinning, 0);
;
spr_slots = [global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotSpinning, global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotSpinning, global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotSpinning];
;
slotScores = [0, 0, 0, 0];
;
lastScore = (- 1);
;
spinLuck = 0;
;
spinLuck += (scrFRGetSkill(mut_rabbit_paw) * 2);
var _frl__targetplayer = instance_nearest(x, y, Player);
if ((_frl__targetplayer.race == scrFRRaceTryResolve("horsie"))) {
{
spinLuck += 2;
;
}
}
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1260
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_endspin() {
var _frl__fail = true;
;
if ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreAmmo) >= 2)) {
{
repeat (scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreAmmo)) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, (y + 10), AmmoPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRMotionAdd((270 + scrFRSourceRandomRange((- 20), 20)), 3);
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitchVolume(sndCanBounce2, 0.6, 3);
_frl__fail = false;
;
}
}
if ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreHealth) >= 2)) {
{
repeat ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreHealth) - 1)) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, (y + 10), HPPickup)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
scrFRMotionAdd((270 + scrFRSourceRandomRange((- 20), 20)), 3);
;
}
}
if(__fr_break6) break;
}}
}
scrFRSoundPitchVolume(sndCanBounce2, 0.6, 3);
_frl__fail = false;
;
}
}
if ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreRads) >= 2)) {
{
repeat ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreRads) * 15)) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, (y + 10), Rad)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
scrFRMotionAdd((270 + scrFRSourceRandomRange((- 20), 20)), 3);
;
}
}
if(__fr_break9) break;
}}
}
scrFRSoundPitchVolume(sndCanBounce2, 0.6, 3);
_frl__fail = false;
;
}
}
if ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreWeapon) >= 2)) {
{
repeat ((scrFRIndexGet(slotScores, frMacro_Objects_Frontier_Sewers_mod_gml_scoreWeapon) - 1)) {
{ var __fr_with10 = scrFRWithValues(scrFRModCall("mod", "Frontier_Pickups", "WeaponCapsule_create", x, (y + 10))), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
scrFRMotionAdd((270 + scrFRSourceRandomRange((- 20), 20)), 3);
;
}
}
if(__fr_break12) break;
}}
}
scrFRSoundPitchVolume(sndCanBounce2, 0.6, 3);
_frl__fail = false;
;
}
}
{ var __fr_with13 = scrFRWithValues(frMacro_Objects_Frontier_Sewers_mod_gml_call(frMacro_Objects_Frontier_Sewers_mod_gml_scr.prompt_create, mytext)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
on_step = fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachinePrompt_step;
;
var __fr_other16=scrFROther(other);
creator = __fr_other16;
;
}
}
if(__fr_break15) break;
}}
if ((_frl__fail == true)) {
{
fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose();
;
}
} else {
{
fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_win();
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1314
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_win() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_win_resume, id, scrFROther(other), _args, 18, []);
}
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_win_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_win");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Sewers.mod.gml:1326
{
;
}
_fr.pc=0;
break;
case 2: // Objects/Frontier_Sewers.mod.gml:1326
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Objects/Frontier_Sewers.mod.gml:1326
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 2 : 0;
break;
case 4: // Objects/Frontier_Sewers.mod.gml:1324
{
;
spr_lights = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLights;
;
}
_fr.pc=3;
break;
case 5: // Objects/Frontier_Sewers.mod.gml:1324
_fr.wait_ticks=max(0,8); _fr.pc=4; return;
break;
case 6: // Objects/Frontier_Sewers.mod.gml:1323
{
scrFRSoundPitchVolume(sndCursedReminder, 1.6, 2);
;
}
_fr.pc=5;
break;
case 7: // Objects/Frontier_Sewers.mod.gml:1322
{
;
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Sewers.mod.gml:1322
_fr.result=undefined; _fr.done=true; return;
break;
case 9: // Objects/Frontier_Sewers.mod.gml:1322
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 8 : 6;
break;
case 10: // Objects/Frontier_Sewers.mod.gml:1321
{
;
}
_fr.pc=9;
break;
case 11: // Objects/Frontier_Sewers.mod.gml:1321
_fr.wait_ticks=max(0,4); _fr.pc=10; return;
break;
case 12: // Objects/Frontier_Sewers.mod.gml:1320
{
scrFRSoundPitchVolume(sndCursedReminder, 1.3, 2);
;
}
_fr.pc=11;
break;
case 13: // Objects/Frontier_Sewers.mod.gml:1319
{
;
}
_fr.pc=12;
break;
case 14: // Objects/Frontier_Sewers.mod.gml:1319
_fr.result=undefined; _fr.done=true; return;
break;
case 15: // Objects/Frontier_Sewers.mod.gml:1319
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 14 : 12;
break;
case 16: // Objects/Frontier_Sewers.mod.gml:1318
{
;
}
_fr.pc=15;
break;
case 17: // Objects/Frontier_Sewers.mod.gml:1318
_fr.wait_ticks=max(0,4); _fr.pc=16; return;
break;
case 18: // Objects/Frontier_Sewers.mod.gml:1316
{
spr_lights = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsWinner;
;
scrFRSoundPitchVolume(sndCursedReminder, 1, 2);
;
}
_fr.pc=17;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Sewers.mod.gml:1328
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose_resume, id, scrFROther(other), _args, 13, []);
}
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_lose");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Sewers.mod.gml:1338
{
spr_lights = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLights;
;
}
_fr.pc=0;
break;
case 2: // Objects/Frontier_Sewers.mod.gml:1337
{
;
}
_fr.pc=1;
break;
case 3: // Objects/Frontier_Sewers.mod.gml:1337
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Objects/Frontier_Sewers.mod.gml:1337
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 3 : 1;
break;
case 5: // Objects/Frontier_Sewers.mod.gml:1336
{
;
}
_fr.pc=4;
break;
case 6: // Objects/Frontier_Sewers.mod.gml:1336
_fr.wait_ticks=max(0,16); _fr.pc=5; return;
break;
case 7: // Objects/Frontier_Sewers.mod.gml:1335
{
scrFRSoundPitchVolume(sndCursedReminder, 0.8, 2);
;
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Sewers.mod.gml:1334
{
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Sewers.mod.gml:1334
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Objects/Frontier_Sewers.mod.gml:1334
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 9 : 7;
break;
case 11: // Objects/Frontier_Sewers.mod.gml:1333
{
;
}
_fr.pc=10;
break;
case 12: // Objects/Frontier_Sewers.mod.gml:1333
_fr.wait_ticks=max(0,2); _fr.pc=11; return;
break;
case 13: // Objects/Frontier_Sewers.mod.gml:1329
{
spr_lights = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSlotMachineLightsLoser;
;
scrFRSoundPitchVolume(sndCursedReminder, 1, 2);
;
}
_fr.pc=12;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Sewers.mod.gml:1341
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSlotMachine_draw() {
draw_self();
;
if ((sprite_index != spr_hurt)) {
{
scrFRDrawSprite(spr_lights, (scrFRSourceFrame() * 0.4), (x + 1), (y - 4));
scrFRDrawSprite(scrFRIndexGet(spr_slots, 0), (scrFRSourceFrame() * 1.6), (x - 7), (y + 3));
scrFRDrawSprite(scrFRIndexGet(spr_slots, 1), (scrFRSourceFrame() + (1 * 1.6)), (x + 1), (y + 3));
scrFRDrawSprite(scrFRIndexGet(spr_slots, 2), (scrFRSourceFrame() + (2 * 1.6)), (x + 9), (y + 3));
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1351
function fr_Objects_Frontier_Sewers_mod_gml_Counter_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoCounter";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounter;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounterHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCounterDead;
;
spr_shadow = global.fr_module_vars[$ "mod:Frontier_Sewers"].shdCounter;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Sewers"].mskCounter;
;
snd_hurt = sndHitPlant;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sndWoodBreak;
;
team = 0;
;
scrFRMaxHealthWrite(id, 15, "=");
;
hp = max_hp;
;
size = 3;
;
allowSpecial = true;
;
on_death = fr_Objects_Frontier_Sewers_mod_gml_Couch_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1380
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_create(_frl__x=undefined, _frl__y=undefined, _frl__table=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoSoda";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSodaCans;
;
spr_hurt = mskNone;
;
spr_dead = mskNone;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0) * timescale;
;
depth = (_frl__table.depth - 1);
;
sodaIndex = 0;
;
table = _frl__table;
;
scrFRMaxHealthWrite(id, 1, "=");
;
hp = max_hp;
;
team = 0;
;
wepDrop = undefined;
;
var _frl__specialAllowed = _frl__table.allowSpecial;
;
var _frl__soder = frMacro_Objects_Frontier_Sewers_mod_gml_call(frMacro_Objects_Frontier_Sewers_mod_gml_scr.pool, [[[0, true, "expresso"], ((1 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[1, true, "extra double triple coffee"], ((1 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[2, true, "frog milk"], ((0.9 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[3, true, "guardian juice"], ((0.8 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[4, true, "munitions mist"], ((1 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[5, true, "saltshake"], ((1 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools"))], [[7, true, "sunset mayo"], (((1 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools")) * (scrFRGetSkill(mut_boiling_veins) > 0))], [[8, true, "pheromone fizz"], (((0.9 * _frl__specialAllowed) * scrFRModLoaded("mod", "defpack tools")) * scrFRModLoaded("mod", "ntte"))], [[9, false, "chug splash"], 1], [[10, false, "vodka"], 1.2], [[11, false, "glass"], 1.2], [[12, false, "choccy milk"], 0.9], [[13, false, "melonlimeorsomething"], 1], [[14, false, "yellow!!"], 1], [[15, false, "ourple"], 1], [[16, false, "crossroads cola"], 0.8], [[17, false, "venuz special"], 0.9]]);
image_index = scrFRIndexGet(_frl__soder, 0);
;
sodaIndex = scrFRIndexGet(_frl__soder, 0);
;
if ((scrFRIndexGet(_frl__soder, 1) == true)) {
{
{ var __fr_with4 = scrFRWithValues(_frl__table), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
allowSpecial = false;
;
}
}
if(__fr_break6) break;
}}
wepDrop = scrFRIndexGet(_frl__soder, 2);
;
}
}
on_step = fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_step;
;
on_death = fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_destoy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1441
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_step() {
if ((! scrFRInstanceExists(table))) {
{
fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_destoy();
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1447
function fr_Objects_Frontier_Sewers_mod_gml_CasinoSoda_destoy() {
GameCont.fr_casinoAlert = true;
;
var _frl__index = sodaIndex;
;
if ((wepDrop != undefined)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", __fr_other4.wepDrop);
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
scrFRSoundPitch(scrFRSourceChoose(sndCanBounce1, sndCanBounce2), (0.8 + scrFRSourceRandom(0.3)));
;
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
scrFRMotionAdd(scrFRSourceRandom(360), 3);
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprSodaCans);
;
image_index = _frl__index;
;
image_speed = (0) * timescale;
;
image_angle = direction;
;
}
}
if(__fr_break7) break;
}}
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1470
function fr_Objects_Frontier_Sewers_mod_gml_Couch_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoCouch";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouch;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchDead;
;
depth = (- 3);
;
snd_hurt = sndHitPlant;
;
snd_dead = sndWheelPileBreak;
;
scrFRMaxHealthWrite(id, 10, "=");
;
hp = max_hp;
;
size = 3;
;
team = 0;
;
on_death = fr_Objects_Frontier_Sewers_mod_gml_Couch_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1495
function fr_Objects_Frontier_Sewers_mod_gml_Couch_destroy() {
GameCont.fr_casinoAlert = true;
;
}

// Original Objects/Frontier_Sewers.mod.gml:1498
function fr_Objects_Frontier_Sewers_mod_gml_BartenderGator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CasinoBartender";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprBartenderGator;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 1);
;
team = 1;
;
scrFRMaxHealthWrite(id, 12, "=");
;
hp = max_hp;
;
VAGGYBONDESPLSNOSHOOT = true;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_Couchgoer_step;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_BartenderGator_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1520
function fr_Objects_Frontier_Sewers_mod_gml_BartenderGator_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
GameCont.fr_casinoAlert = true;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Sewers_mod_gml_CasinoGator_create(x, (y + 8))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, HitWarning);
if ((_frl__dmg > 0)) {
{
scrFRProjectileHit(scrFRSelf(self), _frl__dmg);
}
}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Sewers.mod.gml:1530
function fr_Objects_Frontier_Sewers_mod_gml_CouchgoerGator_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchgoerGator;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 3);
;
team = 1;
;
scrFRMaxHealthWrite(id, 12, "=");
;
hp = max_hp;
;
VAGGYBONDESPLSNOSHOOT = true;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_Couchgoer_step;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_CouchgoerGator_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1549
function fr_Objects_Frontier_Sewers_mod_gml_CouchgoerGator_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
GameCont.fr_casinoAlert = true;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Gator)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, HitWarning);
if ((_frl__dmg > 0)) {
{
scrFRProjectileHit(scrFRSelf(self), _frl__dmg);
}
}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
}

// Original Objects/Frontier_Sewers.mod.gml:1559
function fr_Objects_Frontier_Sewers_mod_gml_CouchgoerCat_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCouchgoerCat;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 3);
;
team = 1;
;
scrFRMaxHealthWrite(id, 10, "=");
;
hp = max_hp;
;
VAGGYBONDESPLSNOSHOOT = true;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_Couchgoer_step;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_CouchgoerCat_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1578
function fr_Objects_Frontier_Sewers_mod_gml_CouchgoerCat_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
GameCont.fr_casinoAlert = true;
;
if (scrFRModLoaded("mod", "tesewers")) {
{
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "Cat")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceCreate(x, y, HitWarning);
;
if ((_frl__dmg > 0)) {
{
scrFRProjectileHit(scrFRSelf(self), _frl__dmg);
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
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(2)) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
}
}
scrFRInstanceDestroy();
}

// Original Objects/Frontier_Sewers.mod.gml:1599
function fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTV;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVDead;
;
spr_screen = scrFRSourceChoose(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVCraft, global.fr_module_vars[$ "mod:Frontier_Sewers"].sprCasinoTVUpturned);
;
spr_scene = scrFRIndexGet(spr_screen, scrFRSourceIRandom(2));
;
scene_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
spr_shadow = shd32;
;
spr_shadow_y = 2;
;
snd_hurt = sndHitPlant;
;
snd_dead = sndPlantPotBreak;
;
team = 0;
;
scrFRMaxHealthWrite(id, 5, "=");
;
hp = max_hp;
;
screen_timer = 1;
;
VAGGYBONDESPLSNOSHOOT = true;
;
on_step = fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_step;
;
on_draw = fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_draw;
;
on_hurt = fr_Objects_Frontier_Sewers_mod_gml_Prop_hurt;
;
on_destroy = fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Sewers.mod.gml:1633
function fr_Objects_Frontier_Sewers_mod_gml_Couchgoer_step() {
if ((GameCont.fr_casinoAlert == true)) {
{
scrFRProjectileHit(scrFRSelf(self), 0);
;
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1638
function fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Objects_Frontier_Sewers_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((screen_timer > 0)) {
{
screen_timer -= scrFRSourceScale();
}
} else {
{
screen_timer = (60 + scrFRSourceIRandom(40));
;
screen_index = scrFRSourceIRandom(2);
;
spr_scene = scrFRIndexGet(spr_screen, screen_index);
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
var __fr_other5=scrFROther(other);
image_xscale = __fr_other5.image_xscale;
;
var __fr_other6=scrFROther(other);
size = __fr_other6.size;
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

// Original Objects/Frontier_Sewers.mod.gml:1670
function fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_draw() {
draw_self();
if ((sprite_index != spr_hurt)) {
{
scrFRDrawSprite(spr_scene, (scrFRSourceFrame() * 0.4), (x - 1), (y + 3));
}
}
}

// Original Objects/Frontier_Sewers.mod.gml:1676
function fr_Objects_Frontier_Sewers_mod_gml_CasinoTV_destroy() {
GameCont.fr_casinoAlert = true;
;
}

// Original Objects/Frontier_Sewers.mod.gml:1679
function fr_Objects_Frontier_Sewers_mod_gml_Graffiti_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_graffitiDecal";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Sewers"].sprGraffiti);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
depth = 7;
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

// Original Objects/Frontier_Sewers.mod.gml:1708
function fr_Objects_Frontier_Sewers_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Sewers.mod.gml:1709
function fr_Objects_Frontier_Sewers_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Sewers.mod.gml:1710
function fr_Objects_Frontier_Sewers_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Sewers.mod.gml:1711
function fr_Objects_Frontier_Sewers_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Sewers.mod.gml:1712
function fr_Objects_Frontier_Sewers_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Sewers.mod.gml:1713
function fr_Objects_Frontier_Sewers_mod_gml_enemy_face(_frl__dir=undefined) {
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

// Original Objects/Frontier_Sewers.mod.gml:1714
function fr_Objects_Frontier_Sewers_mod_gml_enemy_look(_frl__dir=undefined) {
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

// Original Objects/Frontier_Sewers.mod.gml:1715
function fr_Objects_Frontier_Sewers_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Sewers.mod.gml:1716
function fr_Objects_Frontier_Sewers_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Sewers.mod.gml:1717
function fr_Objects_Frontier_Sewers_mod_gml_GunEnemy_draw() {
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

// Original Objects/Frontier_Sewers.mod.gml:1718
function fr_Objects_Frontier_Sewers_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Sewers_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Sewers_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Sewers.mod.gml:1719
function fr_Objects_Frontier_Sewers_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Sewers_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Sewers_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Sewers.mod.gml:1720
function fr_Objects_Frontier_Sewers_mod_gml_nothing() {

}

// Original Objects/Frontier_Sewers.mod.gml:1721
function fr_Objects_Frontier_Sewers_mod_gml_every(_frl__num=undefined) {
return (frac((scrFRSourceFrame() / _frl__num)) < (scrFRSourceScale() / _frl__num));
}

// Original Objects/Frontier_Sewers.mod.gml:1722
function fr_Objects_Frontier_Sewers_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Sewers.mod.gml:1732
function fr_Objects_Frontier_Sewers_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Sewers.mod.gml:1741
function fr_Objects_Frontier_Sewers_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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
