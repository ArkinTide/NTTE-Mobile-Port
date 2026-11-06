#macro frMacro_Frontier_StatusEffects_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_StatusEffects"].scr

#macro frMacro_Frontier_StatusEffects_mod_gml_call scrFRScriptCall

#macro frMacro_Frontier_StatusEffects_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

// Original Frontier_StatusEffects.mod.gml:1
function fr_Frontier_StatusEffects_mod_gml___load() {

}

// Original Frontier_StatusEffects.mod.gml:1
function fr_Frontier_StatusEffects_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_StatusEffects_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Frontier_StatusEffects_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_StatusEffects_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_StatusEffects.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_StatusEffects", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprGenericTrail = sprFR_sprGenericTrail_afddfe484c53;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBloodLust = sprFR_sprBuffBloodLust_63ff541f0982;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffAmmoGain = sprFR_sprBuffAmmoGain_928f827d21b2;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBonusHeal = sprFR_sprBuffBonusHeal_9422b05d97e9;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBonusHealEnd = sprFR_sprBuffBonusHealEnd_72ba05b81140;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffMaxHealthGainStart = sprFR_sprBuffMaxHealthGainStar_76e6167e8f72;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffMaxHealthGainEnd = sprFR_sprBuffMaxHealthGainEnd_aa535f44deb3;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossStart = sprFR_sprDebuffMaxHealthLossSt_6b071d1c81c3;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossEnd = sprFR_sprDebuffMaxHealthLossEn_7912968e2ce4;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossGameover = sprFR_sprDebuffMaxHealthLossEn_ce1398be2004;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlight = sprFR_sprDebuffBlight_778f7a0fe320;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlightStreak = sprFR_sprDebuffBlightStreak_fa6dd05883de;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprVoltergeistLightning = [sprFR_sprVoltergeistLightning_c3762615fa62, sprFR_sprVoltergeistLightning2_8892eec6098f, sprFR_sprVoltergeistLightning3_abd1f0f77904, sprFR_sprVoltergeistLightning4_189ab66503d6, sprFR_sprVoltergeistLightning5_1ef81ba8c1a6];
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprPetrolStreak = sprFR_sprPetrolStreak_d2e1ad425a48;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlague = sprFR_sprDebuffPlague_6ed8e5bf38f4;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlagueStreak = sprFR_sprDebuffPlagueStreak_9a93f48155b6;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffAugmentGammaGuts = sprFR_sprDebuffAugmentGammaGut_3eaa3656866d;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffAugmentGammaGutsGreen = sprFR_sprDebuffAugmentGammaGut_c69991810a34;
;
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].settingGreenAugments = false;
;
fr_Frontier_StatusEffects_mod_gml_status_effects_init();
;
}
_fr.pc=0;
break;
case 3: // Frontier_StatusEffects.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Frontier_StatusEffects.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Frontier_StatusEffects.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_StatusEffects.mod.gml:40
function fr_Frontier_StatusEffects_mod_gml_step() {
if ((! scrFRInstanceExists(SpiralCont))) {
{
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{
var _frl_i = (array_length(targets) - 1);
for (; (_frl_i >= 0); _frl_i--) {
if (scrFRInstanceExists(scrFRIndexGet(targets, _frl_i))) {
{
var _frl_value = (scrFRVariableGet(scrFRIndexGet(targets, _frl_i), key) - scrFRSourceScale());
;
scrFRVariableSet(scrFRIndexGet(targets, _frl_i), key, _frl_value);
}
} else {
// BEGIN FRONTIER RETIRED STATUS TARGET
targets = fr_Frontier_StatusEffects_mod_gml_array_delete(targets, _frl_i);
continue;
// END FRONTIER RETIRED STATUS TARGET
}
if ((_frl_value <= 0)) {
{
targets = fr_Frontier_StatusEffects_mod_gml_array_delete(targets, _frl_i);
}
}
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAugmentBeacon.targets), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffAugmentBeacon_ammo"))) {
{
fr_buffAugmentBeacon_ammo = false;
;
fr_buffAugmentBeacon_prevhealth = hp;
;
}
}
if (frMacro_Frontier_StatusEffects_mod_gml_current_frame_active) {
{
if ((fr_buffAugmentBeacon_ammo == false)) {
{
fr_buffAugmentBeacon_ammo = true;
;
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_blend = (global.fr_module_vars[$ "mod:Frontier_StatusEffects"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.8;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitchVolume(sndRogueCanister, 1.4, 0.6);
scrFRSoundPitchVolume(sndFrogPistol, 0.9, 0.6);
}
}
if ((reload >= 0)) {
{
reload -= 0.5;
;
}
}
var _frl__diff = (fr_buffAugmentBeacon_prevhealth - hp);
if ((_frl__diff > 1)) {
{
if ((fr_buffAugmentBeacon_prevhealth > hp)) {
{
hp += 1;
;
}
}
}
}
fr_buffAugmentBeacon_prevhealth = hp;
;
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "mod:Frontier_StatusEffects"].settingGreenAugments ? sprPlasmaTrail : sprPopoPlasmaTrail));
;
speed = (1.5) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break12) break;
}}
}
}
if (((fr_buffAugmentBeacon_time <= 1) && (fr_buffAugmentBeacon_ammo == true))) {
{
fr_buffAugmentBeacon_ammo = false;
;
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
image_blend = (global.fr_module_vars[$ "mod:Frontier_StatusEffects"].settingGreenAugments ? make_colour_rgb(0, 255, 0) : make_colour_rgb(0, 255, 255));
;
depth = (- 3);
;
image_xscale = 0.8;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break15) break;
}}
scrFRSoundPitchVolume(sndFrogPistol, 0.7, 0.6);
}
}
}
}
}
}
}
}
if(__fr_break6) break;
}}
if ((array_length(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBloodLust.targets) > 0)) {
{
{ var __fr_with16 = scrFRWithValues(scrFRMatchingLE(enemy, "my_health", 0)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffBloodLust_check"))) {
{
fr_buffBloodLust_check = true;
;
{ var __fr_with19 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBloodLust.targets), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((scrFRSourceRandom(13) < 1)) {
{
scrFRSoundPlay(sndBloodlustProc);
{ var __fr_with22 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
var __fr_other25=scrFROther(other);
creator = __fr_other25;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBloodLust);
;
}
}
if(__fr_break24) break;
}}
if (((hp >= max_hp) || ((hp + 1) == max_hp))) {
{
frMacro_Frontier_StatusEffects_mod_gml_call(frMacro_Frontier_StatusEffects_mod_gml_scr.pickup_text, "HP", "max");
}
} else {
{
hp += 1;
;
frMacro_Frontier_StatusEffects_mod_gml_call(frMacro_Frontier_StatusEffects_mod_gml_scr.pickup_text, "HP", "add", 1);
}
}
}
}
}
}
}
}
if(__fr_break21) break;
}}
__fr_break18=true; break;
;
}
}
}
}
if(__fr_break18) break;
}}
}
}
{ var __fr_with26 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBloodLust.targets), __fr_break28=false;
for (var __fr_index27=0; __fr_index27<array_length(__fr_with26); ++__fr_index27) {
if(scrFRScopeExists(__fr_with26[__fr_index27])) with (__fr_with26[__fr_index27]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((scrFRSourceRandom(13) < 1)) {
{
{ var __fr_with29 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullSweat)), __fr_break31=false;
for (var __fr_index30=0; __fr_index30<array_length(__fr_with29); ++__fr_index30) {
if(scrFRScopeExists(__fr_with29[__fr_index30])) with (__fr_with29[__fr_index30]) {
{
image_blend = make_colour_rgb(133, 27, 0);
direction = scrFRSourceRandomRange(60, 120);
}
}
if(__fr_break31) break;
}}
}
}
if ((fr_buffBloodLust_time <= 1)) {
{
scrFRSoundPitchVolume(sndBloodLauncherExplo, 0.7, 0.5);
scrFRSoundPitchVolume(sndBloodHammer, 0.5, 0.4);
repeat (30) {
{ var __fr_with32 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullSweat)), __fr_break34=false;
for (var __fr_index33=0; __fr_index33<array_length(__fr_with32); ++__fr_index33) {
if(scrFRScopeExists(__fr_with32[__fr_index33])) with (__fr_with32[__fr_index33]) {
{
image_blend = make_colour_rgb((133 + scrFRSourceRandomRange((- 20), 20)), (27 + scrFRSourceRandomRange((- 20), 20)), 0);
}
}
if(__fr_break34) break;
}}
}
repeat (2) {
{ var __fr_with35 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break37=false;
for (var __fr_index36=0; __fr_index36<array_length(__fr_with35); ++__fr_index36) {
if(scrFRScopeExists(__fr_with35[__fr_index36])) with (__fr_with35[__fr_index36]) {
{
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break37) break;
}}
}
}
}
}
}
}
}
if(__fr_break28) break;
}}
{ var __fr_with38 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAmmoGain.targets), __fr_break40=false;
for (var __fr_index39=0; __fr_index39<array_length(__fr_with38); ++__fr_index39) {
if(scrFRScopeExists(__fr_with38[__fr_index39])) with (__fr_with38[__fr_index39]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffAmmoGain_ammo"))) {
{
fr_buffAmmoGain_ammo = false;
;
}
}
if ((fr_buffAmmoGain_ammo == false)) {
{
fr_buffAmmoGain_ammo = true;
;
scrFRSoundPitchVolume(sndEmpty, 1.4, 0.6);
scrFRSoundPitchVolume(sndAmmoPickup, 0.9, 0.6);
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [1], 8, "+=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [2], 2, "+=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [3], 2, "+=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [4], 2, "+=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [5], 3, "+=");
;
}
}
if ((scrFRSourceRandom(15) < scrFRSourceScale())) {
{
{ var __fr_with41 = scrFRWithValues(scrFRInstanceCreate(x, y, RecycleGland)), __fr_break43=false;
for (var __fr_index42=0; __fr_index42<array_length(__fr_with41); ++__fr_index42) {
if(scrFRScopeExists(__fr_with41[__fr_index42])) with (__fr_with41[__fr_index42]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffAmmoGain);
;
speed = (1.5) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break43) break;
}}
}
}
if (((fr_buffAmmoGain_time <= 1) && (fr_buffAmmoGain_ammo == true))) {
{
fr_buffAmmoGain_ammo = false;
;
scrFRSoundPitchVolume(sndEmpty, 0.7, 0.6);
repeat (15) {
{ var __fr_with44 = scrFRWithValues(scrFRInstanceCreate(x, y, RecycleGland)), __fr_break46=false;
for (var __fr_index45=0; __fr_index45<array_length(__fr_with44); ++__fr_index45) {
if(scrFRScopeExists(__fr_with44[__fr_index45])) with (__fr_with44[__fr_index45]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffAmmoGain);
;
image_index = scrFRSourceIRandom(2);
;
speed = (1.5) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break46) break;
}}
}
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [1], 8, "-=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [2], 2, "-=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [3], 2, "-=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [4], 2, "-=");
;
scrFRAmmoIndexWrite(scrFRSelf(self), "typ_ammo", [5], 3, "-=");
;
}
}
}
}
}
}
if(__fr_break40) break;
}}
{ var __fr_with47 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffHealthUp.targets), __fr_break49=false;
for (var __fr_index48=0; __fr_index48<array_length(__fr_with47); ++__fr_index48) {
if(scrFRScopeExists(__fr_with47[__fr_index48])) with (__fr_with47[__fr_index48]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffHealthUp_hp"))) {
{
fr_buffHealthUp_hp = false;
;
}
}
if ((fr_buffHealthUp_hp == false)) {
{
fr_buffHealthUp_hp = true;
;
{ var __fr_with50 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break52=false;
for (var __fr_index51=0; __fr_index51<array_length(__fr_with50); ++__fr_index51) {
if(scrFRScopeExists(__fr_with50[__fr_index51])) with (__fr_with50[__fr_index51]) {
{
var __fr_other53=scrFROther(other);
creator = __fr_other53;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffMaxHealthGainStart);
;
}
}
if(__fr_break52) break;
}}
scrFRSoundPitchVolume(sndHealthChest, 1.4, 0.6);
scrFRSoundPitchVolume(sndHPPickupBig, 0.9, 0.6);
scrFRMaxHealthWrite(id, 2, "+=");
;
hp += 2;
;
}
}
if (((fr_buffHealthUp_time <= 1) && (fr_buffHealthUp_hp == true))) {
{
fr_buffHealthUp_hp = false;
;
scrFRSoundPitchVolume(sndHealthChest, 0.7, 0.6);
{ var __fr_with54 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break56=false;
for (var __fr_index55=0; __fr_index55<array_length(__fr_with54); ++__fr_index55) {
if(scrFRScopeExists(__fr_with54[__fr_index55])) with (__fr_with54[__fr_index55]) {
{
var __fr_other57=scrFROther(other);
creator = __fr_other57;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffMaxHealthGainEnd);
;
}
}
if(__fr_break56) break;
}}
scrFRMaxHealthWrite(id, 2, "-=");
;
if ((hp >= max_hp)) {
{
hp -= 2;
;
}
}
}
}
}
}
}
}
if(__fr_break49) break;
}}
{ var __fr_with58 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBonusHeal.targets), __fr_break60=false;
for (var __fr_index59=0; __fr_index59<array_length(__fr_with58); ++__fr_index59) {
if(scrFRScopeExists(__fr_with58[__fr_index59])) with (__fr_with58[__fr_index59]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((scrFRSourceRandom(40) < scrFRSourceScale())) {
{
{ var __fr_with61 = scrFRWithValues(scrFRInstanceCreate(x, (y - 10), HealFX)), __fr_break63=false;
for (var __fr_index62=0; __fr_index62<array_length(__fr_with61); ++__fr_index62) {
if(scrFRScopeExists(__fr_with61[__fr_index62])) with (__fr_with61[__fr_index62]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBonusHeal);
;
speed = ((1 + scrFRSourceRandom(0.5))) * timescale;
;
direction = scrFRSourceRandomRange(60, 180);
}
}
if(__fr_break63) break;
}}
}
}
if ((!scrFRVariableExists(scrFRSelf(self), "fr_BonusHealStatusPrevHealth"))) {
{
fr_BonusHealStatusPrevHealth = hp;
;
}
}
var _frl_diff = (fr_BonusHealStatusPrevHealth - hp);
;
if ((_frl_diff != 0)) {
{
if ((_frl_diff < 0)) {
{
if ((hp < max_hp)) {
{
hp += 1;
;
if ((hp == max_hp)) {
{
frMacro_Frontier_StatusEffects_mod_gml_call(frMacro_Frontier_StatusEffects_mod_gml_scr.pickup_text, "HP", "max");
}
} else {
{
frMacro_Frontier_StatusEffects_mod_gml_call(frMacro_Frontier_StatusEffects_mod_gml_scr.pickup_text, "HP", "add", 1);
;
}
}
}
}
repeat (3) {
{ var __fr_with64 = scrFRWithValues(scrFRInstanceCreate(x, (y - 8), HealFX)), __fr_break66=false;
for (var __fr_index65=0; __fr_index65<array_length(__fr_with64); ++__fr_index65) {
if(scrFRScopeExists(__fr_with64[__fr_index65])) with (__fr_with64[__fr_index65]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBonusHeal);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
direction = scrFRSourceRandomRange(60, 180);
;
}
}
if(__fr_break66) break;
}}
}
}
}
}
}
fr_BonusHealStatusPrevHealth = hp;
;
if ((fr_buffBonusHeal_time <= 1)) {
{
scrFRSoundPitchVolume(sndHitFlesh, 0.7, 0.5);
scrFRSoundPitchVolume(sndHPPickup, 0.3, 0.2);
{ var __fr_with67 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break69=false;
for (var __fr_index68=0; __fr_index68<array_length(__fr_with67); ++__fr_index68) {
if(scrFRScopeExists(__fr_with67[__fr_index68])) with (__fr_with67[__fr_index68]) {
{
var __fr_other70=scrFROther(other);
creator = __fr_other70;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprBuffBonusHealEnd);
;
}
}
if(__fr_break69) break;
}}
}
}
}
}
}
}
if(__fr_break60) break;
}}
{ var __fr_with71 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffFirerateUp.targets), __fr_break73=false;
for (var __fr_index72=0; __fr_index72<array_length(__fr_with71); ++__fr_index72) {
if(scrFRScopeExists(__fr_with71[__fr_index72])) with (__fr_with71[__fr_index72]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffFirerateUp_check"))) {
{
fr_buffFirerateUp_check = false;
;
}
}
if ((fr_buffFirerateUp_check == false)) {
{
if ((fr_buffFirerateUp_time >= 1)) {
{
fr_buffFirerateUp_check = true;
;
scrFRSoundPitchVolume(sndAmmoChest, 1.4, 0.6);
scrFRSoundPitchVolume(sndSwapPistol, 1.5, 0.6);
reloadspeed += 0.25;
;
}
}
}
}
if ((scrFRSourceRandom(15) < 1)) {
{
var _frl__spr = scrFRWeaponSprite(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
var _frl__wth = (sprite_get_width(_frl__spr) - sprite_get_xoffset(_frl__spr));
var _frl__hth = (sprite_get_width(_frl__spr) - sprite_get_yoffset(_frl__spr));
;
{ var __fr_with74 = scrFRWithValues(scrFRInstanceCreate(((x + lengthdir_x(scrFRSourceRandom(_frl__wth), (wepangle + gunangle))) + scrFRSourceRandomRange((- 2), 2)), ((y + lengthdir_y(scrFRSourceRandom(_frl__hth), (wepangle + gunangle))) + scrFRSourceRandomRange((- 2), 2)), CaveSparkle)), __fr_break76=false;
for (var __fr_index75=0; __fr_index75<array_length(__fr_with74); ++__fr_index75) {
if(scrFRScopeExists(__fr_with74[__fr_index75])) with (__fr_with74[__fr_index75]) {
{
speed = (0.6) * timescale;
;
direction = 90;
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other77=scrFROther(other);
depth = (__fr_other77.depth - 1);
;
}
}
if(__fr_break76) break;
}}
}
}
if (((fr_buffFirerateUp_time <= 1) && (fr_buffFirerateUp_check == true))) {
{
fr_buffFirerateUp_check = false;
;
scrFRSoundPitchVolume(sndEmpty, 0.7, 0.6);
reloadspeed -= 0.25;
;
}
}
}
}
}
}
if(__fr_break73) break;
}}
{ var __fr_with78 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffSpeedUp.targets), __fr_break80=false;
for (var __fr_index79=0; __fr_index79<array_length(__fr_with78); ++__fr_index79) {
if(scrFRScopeExists(__fr_with78[__fr_index79])) with (__fr_with78[__fr_index79]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffSpeedUp_check"))) {
{
fr_buffSpeedUp_check = false;
;
}
}
if ((fr_buffSpeedUp_check == false)) {
{
fr_buffSpeedUp_check = true;
;
scrFRSoundPitchVolume(sndSwapHammer, 1.4, 0.6);
;
if (((maxspeed / timescale) > 0)) {
{
maxspeed += (0.75) * timescale;
;
}
}
}
}
if ((scrFRSourceRandom(3) < scrFRSourceScale())) {
{
{ var __fr_with81 = scrFRWithValues(fr_Frontier_StatusEffects_mod_gml_generic_trail_create(((x - ((hspeed / timescale) * 3)) + scrFRSourceRandomRange((- 5), 5)), ((y - ((vspeed / timescale) * 3)) + scrFRSourceRandomRange((- 5), 5)))), __fr_break83=false;
for (var __fr_index82=0; __fr_index82<array_length(__fr_with81); ++__fr_index82) {
if(scrFRScopeExists(__fr_with81[__fr_index82])) with (__fr_with81[__fr_index82]) {
{
var __fr_other84=scrFROther(other);
image_xscale = ((__fr_other84.speed / timescale) * 1.6);
;
image_yscale = 0.025;
;
image_speed = (6) * timescale;
;
var __fr_other85=scrFROther(other);
image_angle = __fr_other85.direction;
;
image_blend = c_white;
;
var __fr_other86=scrFROther(other);
direction = (__fr_other86.direction + 180);
;
speed = (1) * timescale;
;
}
}
if(__fr_break83) break;
}}
}
}
if (((fr_buffSpeedUp_time <= 1) && (fr_buffSpeedUp_check == true))) {
{
fr_buffSpeedUp_check = false;
;
scrFRSoundPitchVolume(sndAmmoChest, 1.4, 0.6);
maxspeed -= (0.75) * timescale;
;
}
}
}
}
}
}
if(__fr_break80) break;
}}
{ var __fr_with87 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffDeeplabsSpeedUp.targets), __fr_break89=false;
for (var __fr_index88=0; __fr_index88<array_length(__fr_with87); ++__fr_index88) {
if(scrFRScopeExists(__fr_with87[__fr_index88])) with (__fr_with87[__fr_index88]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffDeeplabsSpeedUp_check"))) {
{
fr_buffDeeplabsSpeedUp_check = false;
;
}
}
if ((fr_buffDeeplabsSpeedUp_check == false)) {
{
fr_buffDeeplabsSpeedUp_check = true;
;
scrFRSoundPitchVolume(sndSwapHammer, 1.4, 0.6);
;
if (((maxspeed / timescale) > 0)) {
{
maxspeed += (1) * timescale;
;
}
}
}
}
if ((scrFRSourceRandom(5) < scrFRSourceScale())) {
{
{ var __fr_with90 = scrFRWithValues(fr_Frontier_StatusEffects_mod_gml_generic_trail_create(((x - ((hspeed / timescale) * 3)) + scrFRSourceRandomRange((- 5), 5)), ((y - ((vspeed / timescale) * 3)) + scrFRSourceRandomRange((- 5), 5)))), __fr_break92=false;
for (var __fr_index91=0; __fr_index91<array_length(__fr_with90); ++__fr_index91) {
if(scrFRScopeExists(__fr_with90[__fr_index91])) with (__fr_with90[__fr_index91]) {
{
var __fr_other93=scrFROther(other);
image_xscale = ((__fr_other93.speed / timescale) * 1.6);
;
image_yscale = 0.025;
;
image_speed = (6) * timescale;
;
var __fr_other94=scrFROther(other);
image_angle = __fr_other94.direction;
;
image_blend = c_white;
;
var __fr_other95=scrFROther(other);
direction = (__fr_other95.direction + 180);
;
speed = (1) * timescale;
;
}
}
if(__fr_break92) break;
}}
}
}
if (((fr_buffDeeplabsSpeedUp_time <= 1) && (fr_buffDeeplabsSpeedUp_check == true))) {
{
fr_buffDeeplabsSpeedUp_check = false;
;
maxspeed -= (1) * timescale;
;
}
}
}
}
}
}
if(__fr_break89) break;
}}
{ var __fr_with96 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffVoltergeist.targets), __fr_break98=false;
for (var __fr_index97=0; __fr_index97<array_length(__fr_with96); ++__fr_index97) {
if(scrFRScopeExists(__fr_with96[__fr_index97])) with (__fr_with96[__fr_index97]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((scrFRSourceRandom(30) < scrFRSourceScale())) {
{
{ var __fr_with99 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break101=false;
for (var __fr_index100=0; __fr_index100<array_length(__fr_with99); ++__fr_index100) {
if(scrFRScopeExists(__fr_with99[__fr_index100])) with (__fr_with99[__fr_index100]) {
{
var _frl__variant = scrFRSourceIRandom(4);
;
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprVoltergeistLightning, _frl__variant));
;
var __fr_other102=scrFROther(other);
depth = (__fr_other102.depth - 1);
;
}
}
if(__fr_break101) break;
}}
}
}
if ((scrFRAlarmRead(scrFRSelf(self), 1) > 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 1, "-=");
;
}
}
}
}
}
}
if(__fr_break98) break;
}}
{ var __fr_with103 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffOiledUp.targets), __fr_break105=false;
for (var __fr_index104=0; __fr_index104<array_length(__fr_with103); ++__fr_index104) {
if(scrFRScopeExists(__fr_with103[__fr_index104])) with (__fr_with103[__fr_index104]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_buffOiledUp_check"))) {
{
fr_buffOiledUp_check = false;
;
}
}
if ((fr_buffOiledUp_check == false)) {
{
fr_buffOiledUp_check = true;
;
if (((maxspeed / timescale) > 0)) {
{
maxspeed += (2) * timescale;
;
}
}
}
}
if ((scrFRSourceRandom(3) < scrFRSourceScale())) {
{
{ var __fr_with106 = scrFRWithValues(scrFRInstanceCreate(x, (y + 6), AcidStreak)), __fr_break108=false;
for (var __fr_index107=0; __fr_index107<array_length(__fr_with106); ++__fr_index107) {
if(scrFRScopeExists(__fr_with106[__fr_index107])) with (__fr_with106[__fr_index107]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprPetrolStreak);
;
var __fr_other109=scrFROther(other);
depth = (__fr_other109.depth + 1);
;
var __fr_other110=scrFROther(other);
direction = ((__fr_other110.direction + 180) + scrFRSourceRandomRange((- 35), 35));
;
image_angle = direction;
;
}
}
if(__fr_break108) break;
}}
}
}
if (((fr_buffOiledUp_time <= 1) && (fr_buffOiledUp_check == true))) {
{
fr_buffOiledUp_check = false;
;
maxspeed -= (2) * timescale;
;
}
}
}
}
}
}
if(__fr_break105) break;
}}
{ var __fr_with111 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffHealthDown.targets), __fr_break113=false;
for (var __fr_index112=0; __fr_index112<array_length(__fr_with111); ++__fr_index112) {
if(scrFRScopeExists(__fr_with111[__fr_index112])) with (__fr_with111[__fr_index112]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_debuffHealthDown_hp"))) {
{
fr_debuffHealthDown_hp = false;
;
}
}
if ((fr_debuffHealthDown_hp == false)) {
{
fr_debuffHealthDown_hp = true;
;
{ var __fr_with114 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break116=false;
for (var __fr_index115=0; __fr_index115<array_length(__fr_with114); ++__fr_index115) {
if(scrFRScopeExists(__fr_with114[__fr_index115])) with (__fr_with114[__fr_index115]) {
{
var __fr_other117=scrFROther(other);
creator = __fr_other117;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossStart);
;
}
}
if(__fr_break116) break;
}}
scrFRSoundPitchVolume(sndCursedReminder, 1.4, 0.6);
scrFRSoundPitchVolume(sndHealthChest, 0.4, 0.6);
scrFRMaxHealthWrite(id, 2, "-=");
;
if ((hp >= max_hp)) {
{
hp -= 2;
;
lasthit = [global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossGameover, "BAD DIET CHOICES"];
}
}
}
}
if (((fr_debuffHealthDown_time <= 1) && (fr_debuffHealthDown_hp == true))) {
{
fr_debuffHealthDown_hp = false;
;
scrFRSoundPitchVolume(sndHealthChest, 0.7, 0.6);
{ var __fr_with118 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBloodLust)), __fr_break120=false;
for (var __fr_index119=0; __fr_index119<array_length(__fr_with118); ++__fr_index119) {
if(scrFRScopeExists(__fr_with118[__fr_index119])) with (__fr_with118[__fr_index119]) {
{
var __fr_other121=scrFROther(other);
creator = __fr_other121;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffMaxHealthLossEnd);
;
}
}
if(__fr_break120) break;
}}
scrFRMaxHealthWrite(id, 2, "+=");
;
hp += 2;
;
}
}
}
}
}
}
if(__fr_break113) break;
}}
{ var __fr_with122 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffBlight.targets), __fr_break124=false;
for (var __fr_index123=0; __fr_index123<array_length(__fr_with122); ++__fr_index123) {
if(scrFRScopeExists(__fr_with122[__fr_index123])) with (__fr_with122[__fr_index123]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_debuffBlight_tick"))) {
{
fr_debuffBlight_tick = 300;
;
}
}
if ((scrFRSourceRandom(18) < scrFRSourceScale())) {
{
{ var __fr_with125 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), Bubble)), __fr_break127=false;
for (var __fr_index126=0; __fr_index126<array_length(__fr_with125); ++__fr_index126) {
if(scrFRScopeExists(__fr_with125[__fr_index126])) with (__fr_with125[__fr_index126]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlight);
;
direction = (90 + scrFRSourceRandomRange((- 20), 20));
;
speed = ((0.5 + scrFRSourceRandom(1))) * timescale;
;
}
}
if(__fr_break127) break;
}}
}
}
if ((fr_debuffBlight_tick <= 0)) {
{
fr_debuffBlight_tick += 240;
if ((hp > 1)) {
{
lasthit = [global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlight, "UNINTENDED GAME DESIGN"];
scrFRProjectileHitRaw(scrFRSelf(self), 1, snd_hurt);
{ var __fr_with128 = scrFRWithValues(scrFRInstanceCreate(x, y, PopupText)), __fr_break130=false;
for (var __fr_index129=0; __fr_index129<array_length(__fr_with128); ++__fr_index129) {
if(scrFRScopeExists(__fr_with128[__fr_index129])) with (__fr_with128[__fr_index129]) {
{
mytext = "@(color:11412616)-1 HP";
}
}
if(__fr_break130) break;
}}
scrFRSoundPitchVolume(sndBloodHurt, 1.2, 0.6);
;
scrFRSoundPitch(sndCursedReminder, 0.4);
;
repeat (6) {
{ var __fr_with131 = scrFRWithValues(scrFRInstanceCreate(x, y, Curse)), __fr_break133=false;
for (var __fr_index132=0; __fr_index132<array_length(__fr_with131); ++__fr_index132) {
if(scrFRScopeExists(__fr_with131[__fr_index132])) with (__fr_with131[__fr_index132]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlight);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break133) break;
}}
}
repeat ((2 + scrFRSourceRandom(2))) {
{ var __fr_with134 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break136=false;
for (var __fr_index135=0; __fr_index135<array_length(__fr_with134); ++__fr_index135) {
if(scrFRScopeExists(__fr_with134[__fr_index135])) with (__fr_with134[__fr_index135]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlightStreak);
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break136) break;
}}
}
}
}
}
} else {
{
fr_debuffBlight_tick -= scrFRSourceScale();
;
}
}
if ((fr_debuffBlight_time <= 1)) {
{
scrFRSoundPitchVolume(sndStrongSpiritGain, 0.4, 0.6);
repeat (8) {
{ var __fr_with137 = scrFRWithValues(scrFRInstanceCreate(x, y, Curse)), __fr_break139=false;
for (var __fr_index138=0; __fr_index138<array_length(__fr_with137); ++__fr_index138) {
if(scrFRScopeExists(__fr_with137[__fr_index138])) with (__fr_with137[__fr_index138]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffBlight);
;
direction = scrFRSourceRandom(360);
;
speed = ((0.5 + scrFRSourceRandom(1))) * timescale;
;
}
}
if(__fr_break139) break;
}}
}
fr_debuffBlight_tick = 300;
;
}
}
}
}
}
}
if(__fr_break124) break;
}}
}
}
{ var __fr_with140 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffPlague.targets), __fr_break142=false;
for (var __fr_index141=0; __fr_index141<array_length(__fr_with140); ++__fr_index141) {
if(scrFRScopeExists(__fr_with140[__fr_index141])) with (__fr_with140[__fr_index141]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_debuffPlague_tick"))) {
{
fr_debuffPlague_tick = 25;
;
}
}
if (scrFRInstanceIs(scrFRSelf(self), hitme)) {
{
if ((scrFRSourceRandom(18) < scrFRSourceScale())) {
{
{ var __fr_with143 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), Bubble)), __fr_break145=false;
for (var __fr_index144=0; __fr_index144<array_length(__fr_with143); ++__fr_index144) {
if(scrFRScopeExists(__fr_with143[__fr_index144])) with (__fr_with143[__fr_index144]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlague);
;
direction = (90 + scrFRSourceRandomRange((- 20), 20));
;
speed = ((0.5 + scrFRSourceRandom(1))) * timescale;
;
}
}
if(__fr_break145) break;
}}
}
}
if (((! scrFRInstanceIs(scrFRSelf(self), Player)) || (scrFRVariableExists(scrFRSelf(self), "notoxic") && (notoxic == false)))) {
{
if ((fr_debuffPlague_tick <= 0)) {
{
fr_debuffPlague_tick += 25;
lasthit = [global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlague, "PLAGUE"];
var _frl__dmg = (scrFRInstanceIs(scrFRSelf(self), Player) ? 1 : 6);
;
scrFRProjectileHitRaw(scrFRSelf(self), _frl__dmg, snd_hurt);
repeat (2) {
{ var __fr_with146 = scrFRWithValues(scrFRInstanceCreate(x, y, Curse)), __fr_break148=false;
for (var __fr_index147=0; __fr_index147<array_length(__fr_with146); ++__fr_index147) {
if(scrFRScopeExists(__fr_with146[__fr_index147])) with (__fr_with146[__fr_index147]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlague);
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break148) break;
}}
}
repeat ((1 + scrFRSourceRandom(2))) {
{ var __fr_with149 = scrFRWithValues(scrFRInstanceCreate(x, y, BloodStreak)), __fr_break151=false;
for (var __fr_index150=0; __fr_index150<array_length(__fr_with149); ++__fr_index150) {
if(scrFRScopeExists(__fr_with149[__fr_index150])) with (__fr_with149[__fr_index150]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffPlagueStreak);
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break151) break;
}}
}
}
} else {
{
fr_debuffPlague_tick -= scrFRSourceScale();
;
}
}
}
}
if ((hp <= 0)) {
{
if ((fr_plagueLevel > 0)) {
{
repeat (clamp((size * 2), 1, 100)) {
{ var __fr_with152 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "PlagueGas_create", x, y, (fr_plagueLevel - 1))), __fr_break154=false;
for (var __fr_index153=0; __fr_index153<array_length(__fr_with152); ++__fr_index153) {
if(scrFRScopeExists(__fr_with152[__fr_index153])) with (__fr_with152[__fr_index153]) {
{
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break154) break;
}}
}
}
}
}
}
if ((fr_debuffPlague_time <= 1)) {
{
fr_debuffPlague_tick = 25;
;
fr_plagueLevel = (- 1);
;
}
}
}
}
}
}
}
}
if(__fr_break142) break;
}}
{ var __fr_with155 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffAugmentGammaGuts.targets), __fr_break157=false;
for (var __fr_index156=0; __fr_index156<array_length(__fr_with155); ++__fr_index156) {
if(scrFRScopeExists(__fr_with155[__fr_index156])) with (__fr_with155[__fr_index156]) {
{
if (scrFRInstanceExists(scrFRSelf(self))) {
{
if (scrFRInstanceIs(scrFRSelf(self), hitme)) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_debuffAugmentGammaGuts_prevhealth"))) {
{
fr_debuffAugmentGammaGuts_prevhealth = hp;
;
fr_debuffAugmentGammaGuts_reset = true;
;
}
}
if ((fr_debuffAugmentGammaGuts_reset == true)) {
{
fr_debuffAugmentGammaGuts_prevhealth = hp;
;
fr_debuffAugmentGammaGuts_reset = false;
;
}
}
var _frl__diff = (fr_debuffAugmentGammaGuts_prevhealth - hp);
if ((_frl__diff > 0)) {
{
if ((fr_debuffAugmentGammaGuts_prevhealth > hp)) {
{
hp -= (_frl__diff * 0.65);
repeat ((2 + scrFRSourceIRandom(2))) {
{ var __fr_with158 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break160=false;
for (var __fr_index159=0; __fr_index159<array_length(__fr_with158); ++__fr_index159) {
if(scrFRScopeExists(__fr_with158[__fr_index159])) with (__fr_with158[__fr_index159]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "mod:Frontier_StatusEffects"].settingGreenAugments ? global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffAugmentGammaGutsGreen : global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprDebuffAugmentGammaGuts));
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((sprite_get_width(sprite_index) / 2)) * timescale;
;
friction = (0.3) * (timescale * timescale);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other161=scrFROther(other);
depth = (__fr_other161.depth - 1);
;
}
}
if(__fr_break160) break;
}}
}
}
}
}
}
fr_debuffAugmentGammaGuts_prevhealth = hp;
;
if ((fr_debuffAugmentGammaGuts_time <= 1)) {
{
fr_debuffAugmentGammaGuts_reset = true;
;
}
}
}
}
}
}
}
}
if(__fr_break157) break;
}}
}

// Original Frontier_StatusEffects.mod.gml:854
function fr_Frontier_StatusEffects_mod_gml_status_effects_init() {
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects = [];
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAugmentBeacon = {"targets": [], "key": "fr_buffAugmentBeacon_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBloodLust = {"targets": [], "key": "fr_buffBloodLust_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAmmoGain = {"targets": [], "key": "fr_buffAmmoGain_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffHealthUp = {"targets": [], "key": "fr_buffHealthUp_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBonusHeal = {"targets": [], "key": "fr_buffBonusHeal_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffFirerateUp = {"targets": [], "key": "fr_buffFirerateUp_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffSpeedUp = {"targets": [], "key": "fr_buffSpeedUp_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffVoltergeist = {"targets": [], "key": "fr_buffVoltergeist_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffOiledUp = {"targets": [], "key": "fr_buffOiledUp_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffDeeplabsSpeedUp = {"targets": [], "key": "fr_buffDeeplabsSpeedUp_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffHealthDown = {"targets": [], "key": "fr_debuffHealthDown_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffBlight = {"targets": [], "key": "fr_debuffBlight_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffPlague = {"targets": [], "key": "fr_debuffPlague_time"};
global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffAugmentGammaGuts = {"targets": [], "key": "fr_debuffAugmentGammaGuts_time"};
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAugmentBeacon);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBloodLust);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffAmmoGain);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffHealthUp);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffBonusHeal);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffFirerateUp);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffSpeedUp);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffVoltergeist);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffOiledUp);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].buffDeeplabsSpeedUp);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffHealthDown);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffBlight);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffPlague);
;
array_push(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].statusEffects, global.fr_module_vars[$ "mod:Frontier_StatusEffects"].debuffAugmentGammaGuts);
;
}

// Original Frontier_StatusEffects.mod.gml:957
function fr_Frontier_StatusEffects_mod_gml_status_apply_set(_frl__target=undefined, _frl__status=undefined, _frl__duration=undefined) {
var _frl_effectTime = scrFRVariableGet(_frl__target, _frl__status.key);
;
if ((_frl_effectTime == undefined)) {
{
_frl_effectTime = 0;
;
}
}
_frl_effectTime = max(_frl__duration, _frl_effectTime);
scrFRVariableSet(_frl__target, _frl__status.key, _frl_effectTime);
if ((scrFRArrayFindIndex(_frl__status.targets, _frl__target) == (- 1))) {
{
array_push(_frl__status.targets, _frl__target);
}
}
}

// Original Frontier_StatusEffects.mod.gml:971
function fr_Frontier_StatusEffects_mod_gml_status_apply_add(_frl__target=undefined, _frl__status=undefined, _frl__duration=undefined) {
var _frl_effectTime = scrFRVariableGet(_frl__target, _frl__status.key);
;
if ((_frl_effectTime == undefined)) {
{
_frl_effectTime = 0;
;
}
}
if ((_frl_effectTime > 0)) {
{
_frl_effectTime += _frl__duration;
;
}
}
_frl_effectTime = max(_frl__duration, _frl_effectTime);
scrFRVariableSet(_frl__target, _frl__status.key, _frl_effectTime);
if ((scrFRArrayFindIndex(_frl__status.targets, _frl__target) == (- 1))) {
{
array_push(_frl__status.targets, _frl__target);
}
}
}

// Original Frontier_StatusEffects.mod.gml:985
function fr_Frontier_StatusEffects_mod_gml_array_delete(_frl__array=undefined, _frl__index=undefined) {
var _frl__new = scrFRArraySlice(_frl__array, 0, _frl__index);
;
array_copy(_frl__new, _frl__index, _frl__array, (_frl__index + 1), (array_length(_frl__array) - (_frl__index + 1)));
;
return _frl__new;
;
}

// Original Frontier_StatusEffects.mod.gml:991
function fr_Frontier_StatusEffects_mod_gml_every(_frl__num=undefined) {
return (frac((scrFRSourceFrame() / _frl__num)) < (scrFRSourceScale() / _frl__num));
}

// Original Frontier_StatusEffects.mod.gml:994
function fr_Frontier_StatusEffects_mod_gml_color(_frl__e=undefined, _frl__from=undefined, _frl__to=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl__e), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if ((image_blend == _frl__from)) {
image_blend = _frl__to;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
}

// Original Frontier_StatusEffects.mod.gml:998
function fr_Frontier_StatusEffects_mod_gml_color_revert(_frl__col=undefined) {
scrFRBindEndStep(fr_Frontier_StatusEffects_mod_gml_color, 0, scrFRSelf(self), _frl__col, image_blend);
image_blend = _frl__col;
}

// Original Frontier_StatusEffects.mod.gml:1002
function fr_Frontier_StatusEffects_mod_gml_generic_trail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_StatusEffects"].sprGenericTrail);
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
}
