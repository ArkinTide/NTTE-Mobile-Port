#macro frMacro_Characters_bubbles_race_gml_scr global.fr_module_vars[$ "race:bubbles"].scr

#macro frMacro_Characters_bubbles_race_gml_call scrFRScriptCall

#macro frMacro_Characters_bubbles_race_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Characters_bubbles_race_gml_ult_Barricade 1

#macro frMacro_Characters_bubbles_race_gml_ult_Barrage 2

// Original Characters/bubbles.race.gml:1
function fr_Characters_bubbles_race_gml___load() {

}

// Original Characters/bubbles.race.gml:1
function fr_Characters_bubbles_race_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Characters_bubbles_race_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Characters_bubbles_race_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Characters_bubbles_race_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Characters/bubbles.race.gml:104
{
scrFRScriptCall(["mod", "lib", "getRef"], "race", "bubbles", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: current_frame_active
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "race", "bubbles")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Characters_bubbles_race_gml_assign_sprites();
;
fr_Characters_bubbles_race_gml_assign_sounds();
;
}
}
if(__fr_break3) break;
}}
}
_fr.pc=0;
break;
case 3: // Characters/bubbles.race.gml:103
{
;
}
_fr.pc=2;
break;
case 4: // Characters/bubbles.race.gml:103
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Characters/bubbles.race.gml:103
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Characters/bubbles.race.gml:7
{
global.fr_module_vars[$ "race:bubbles"].lastKills = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastTime = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastLoop = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastBubbles = 0;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesSlct = sndFR_sndBubblesSlct_e3c72164b025;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesCnfm = sndFR_sndBubblesCnfm_021f525862d5;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesWrld = sndFR_sndBubblesWrld_0f2dbbb73064;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesHurt = sndFR_sndBubblesHurt_995d1b785665;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesDead = sndFR_sndBubblesDead_45b4db12ca2a;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesLowA = sndFR_sndBubblesLowA_e884ce0301ea;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesLowH = sndFR_sndBubblesLowH_8848c8abeb1f;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesChst = sndFR_sndBubblesChst_598c8f0abe5a;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesValt = sndFR_sndBubblesValt_acae3a213aab;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesCrwn = sndFR_sndBubblesCrwn_ddd1ebb3f590;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesSpch = sndFR_sndBubblesSpch_0ec8bec828a7;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesIDPD = sndFR_sndBubblesIDPD_79cef1a088f5;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesCptn = sndFR_sndBubblesCptn_2db223269ed0;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec = sndFR_sndBubblesSpec_30a9c88b86df;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec2 = sndFR_sndBubblesSpec2_aef52261acb0;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec3 = sndFR_sndBubblesSpec3_f2bbc3e47c9c;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblePop = sndFR_sndBubblePop_f658ec98084a;
;
global.fr_module_vars[$ "race:bubbles"].sndBoom = sndFR_sndBoom_adef1aa58a4e;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesUltraA = sndFR_sndBubblesUltraA_3599f3f0ab42;
;
global.fr_module_vars[$ "race:bubbles"].sndBubblesUltraB = sndFR_sndBubblesUltraB_daddc6e69851;
;
global.fr_module_vars[$ "race:bubbles"].mskBubbleProjectile = sprFR_mskBubblesProjectile_1c6942e66e67;
;
global.fr_module_vars[$ "race:bubbles"].mskBubbleProjectileBurstBullet = sprFR_mskBubblesProjectileBurs_0efa9cb4ac58;
;
global.fr_module_vars[$ "race:bubbles"].sprCoveIcon = sprFR_sprUnlockCoveIcon_e09a807bffde;
;
global.fr_module_vars[$ "race:bubbles"].sprReviveChest = sprFR_sprBubblesReviveChest_eb5b46b01717;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprIdle", [0], sprFR_sprBubblesIdle_25aad4c7234e, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprWalk", [0], sprFR_sprBubblesWalk_362a4d9e3041, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprHurt", [0], sprFR_sprBubblesHurt_879142cf6e0a, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprDead", [0], sprFR_sprBubblesDead_d86d4cf53862, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprGoSit", [0], sprFR_sprBubblesGoSit_1d83345c6711, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSit", [0], sprFR_sprBubblesSit_834bc492ae55, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprFire", [0], sprFR_sprBubblesFire_87332a274f22, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectile", [0], sprFR_sprBubblesProjectile_13e6f6109b38, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBig", [0], sprFR_sprBubblesProjectileBig_eb2fa54916b8, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleTrail", [0], sprFR_sprBubblesTrail_bf53af1d8b06, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileNullify", [0], sprFR_sprBubblesProjectileNull_c43fa6d59f02, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSmallBubbleExplosion", [0], sprFR_sprBubblesExplosion_faf187f8be82, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleSprayParticle", [0], sprFR_sprBubblesSprayParticle_05c0ba0476c1, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBurst", [0], sprFR_sprBubblesProjectileBurs_ab336607af89, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBurstBullet", [0], sprFR_sprBubblesProjectileBurs_5dc5a89f9bce, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprIdle", [1], sprFR_sprBubblesBIdle_3ae52bb5a23c, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprWalk", [1], sprFR_sprBubblesBWalk_c74aedd61586, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprHurt", [1], sprFR_sprBubblesBHurt_f819918ca934, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprDead", [1], sprFR_sprBubblesBDead_0d8d1a82a442, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprGoSit", [1], sprFR_sprBubblesBGoSit_a8fcd74550e2, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSit", [1], sprFR_sprBubblesBSit_d12be3b182f6, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprFire", [1], sprFR_sprBubblesBFire_c8ede329c34a, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectile", [1], sprFR_sprBubblesBProjectile_a8b6b9253761, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBig", [1], sprFR_sprBubblesBProjectileBig_b1e6c358bdde, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleTrail", [1], sprFR_sprBubblesBTrail_e54e74f2b4a9, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileNullify", [1], sprFR_sprBubblesBProjectileNul_078056a98ead, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSmallBubbleExplosion", [1], sprFR_sprBubblesBExplosion_04a29c7adfc3, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleSprayParticle", [1], sprFR_sprBubblesBSprayParticle_f90cc70ba4dc, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBurst", [1], sprFR_sprBubblesBProjectileBur_e075a9343da4, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprBubbleProjectileBurstBullet", [1], sprFR_sprBubblesBProjectileBur_74df2302aeed, "=");
;
global.fr_module_vars[$ "race:bubbles"].sprSelect = sprFR_sprBubblesSelect_9a983e1c7c7a;
;
global.fr_module_vars[$ "race:bubbles"].sprPortrait = sprFR_sprBubblesPortrait_8a6537488dd6;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSkinIcon", [0], sprFR_sprBubblesLoadout_93a0fa80537a, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprSkinIcon", [1], sprFR_sprBubblesBLoadout_f4c7d6401510, "=");
;
global.fr_module_vars[$ "race:bubbles"].sprMapIcon = sprFR_sprBubblesMapIcon_00381e9d69a6;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprUltra", [1], sprFR_sprEGSkillIconA_f7ee37afe3ab, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprUltra", [2], sprFR_sprEGSkillIconB_20248ea5da02, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprUltraIcon", [1], sprFR_sprEgIconHUDA_12c91b00ea2a, "=");
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "race:bubbles"], "sprUltraIcon", [2], sprFR_sprEGIconHUDB_46b2b7887c32, "=");
;
global.fr_module_vars[$ "race:bubbles"].sprCampfireSlct = sprFR_sprBubblesMenuSlct_deec296b0277;
;
global.fr_module_vars[$ "race:bubbles"].sprCampfireMenu = sprFR_sprBubblesMenu_00660023b603;
;
global.fr_module_vars[$ "race:bubbles"].sprCampfireTo = sprFR_sprBubblesMenuTo_7de51be6b460;
;
global.fr_module_vars[$ "race:bubbles"].sprCampfireFrom = sprFR_sprBubblesMenuFrom_7de652b748e8;
;
global.fr_module_vars[$ "race:bubbles"].sprGuardianBubble = sprFR_sprGuardianBubble_e1b8caae3772;
;
global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleTrail = sprFR_sprGuardianBubbleTrail_59fc88abbd99;
;
global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleNullify = sprFR_sprGuardianBubbleNullify_375f0c2c38bd;
;
global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleExplosion = sprFR_sprGuardianBubbleExplosi_de8062731327;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Characters/bubbles.race.gml:117
function fr_Characters_bubbles_race_gml_guh() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(scrFRMouseCoordinate(0), scrFRMouseCoordinate(1), CampChar)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
race = scrFRRaceResolve("bubbles");
;
spr_to = global.fr_module_vars[$ "race:bubbles"].sprCampfireFrom;
;
spr_from = global.fr_module_vars[$ "race:bubbles"].sprCampfireTo;
;
spr_slct = global.fr_module_vars[$ "race:bubbles"].sprCampfireSlct;
;
spr_menu = global.fr_module_vars[$ "race:bubbles"].sprCampfireMenu;
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:127
function fr_Characters_bubbles_race_gml_race_name() {
return scrFRLocalize(scrFRLoc("Frontier:BubblesName", "BUBBLES"));
;
}

// Original Characters/bubbles.race.gml:128
function fr_Characters_bubbles_race_gml_race_text() {
return scrFRLocalize(scrFRLoc("Frontier:BubblesText", "@wLESS @sENEMY @wCONTACT DAMAGE#@(color:16234606)BUBBLE @wSPRAY"));
;
}

// Original Characters/bubbles.race.gml:129
function fr_Characters_bubbles_race_gml_race_tb_text() {
return scrFRLocalize(scrFRLoc("Frontier:BubblesThronebutt", "@wHEAVIER @(color:16234606)BUBBLES"));
;
}

// Original Characters/bubbles.race.gml:130
function fr_Characters_bubbles_race_gml_race_lock() {
return scrFRLocalize((("REACH " + "4-") + ("@1(" + string(real(global.fr_module_vars[$ "race:bubbles"].sprCoveIcon)) + ":0)")));
;
}

// Original Characters/bubbles.race.gml:131
function fr_Characters_bubbles_race_gml_race_unlock() {
return scrFRLocalize("FOR REACHING COVE");
;
}

// Original Characters/bubbles.race.gml:132
function fr_Characters_bubbles_race_gml_race_avail() {
return frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", "unlock_bubbles");
;
}

// Original Characters/bubbles.race.gml:133
function fr_Characters_bubbles_race_gml_race_portrait() {
return global.fr_module_vars[$ "race:bubbles"].sprPortrait;
;
}

// Original Characters/bubbles.race.gml:134
function fr_Characters_bubbles_race_gml_race_mapicon() {
return global.fr_module_vars[$ "race:bubbles"].sprMapIcon;
;
}

// Original Characters/bubbles.race.gml:135
function fr_Characters_bubbles_race_gml_race_menu_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "race:bubbles"].sprSelect);
;
image_index = (! fr_Characters_bubbles_race_gml_race_avail());
;
}

// Original Characters/bubbles.race.gml:136
function fr_Characters_bubbles_race_gml_race_revive_sprite() {
return global.fr_module_vars[$ "race:bubbles"].sprReviveChest;
;
}

// Original Characters/bubbles.race.gml:138
function fr_Characters_bubbles_race_gml_race_ttip() {
if (((GameCont.level >= 10) && fr_Characters_bubbles_race_gml_chance(1, 5))) {
{
return scrFRLocalize(scrFRSourceChoose("ILL BE YOUR KILLER FISH#FOR THE EVENING", "SHIVER ME TIMBERS", "ALL HANDS ON DECK", "LEVIATHAN"));
;
}
}
return scrFRLocalize(scrFRSourceChoose("@(color:16234606)BUBBLES @wDESTROY PROJECTILES", "FISH N' CHIPS", "HEAD EMPTY", "STAY HYDRATED", "FISHY BUSINESS", "FIND SHINIES", "FOLLOW THE CODE"));
;
}

// Original Characters/bubbles.race.gml:161
function fr_Characters_bubbles_race_gml_race_menu_select() {
return global.fr_module_vars[$ "race:bubbles"].sndBubblesSlct;
;
}

// Original Characters/bubbles.race.gml:162
function fr_Characters_bubbles_race_gml_race_menu_confirm() {
return global.fr_module_vars[$ "race:bubbles"].sndBubblesCnfm;
;
}

// Original Characters/bubbles.race.gml:165
function fr_Characters_bubbles_race_gml_race_cf() {
return true;
;
}

// Original Characters/bubbles.race.gml:166
function fr_Characters_bubbles_race_gml_race_cf_sprnotselected() {
return global.fr_module_vars[$ "race:bubbles"].sprCampfireMenu;
;
}

// Original Characters/bubbles.race.gml:167
function fr_Characters_bubbles_race_gml_race_cf_sprselected() {
return global.fr_module_vars[$ "race:bubbles"].sprCampfireSlct;
;
}

// Original Characters/bubbles.race.gml:168
function fr_Characters_bubbles_race_gml_race_cf_sprselecting() {
return global.fr_module_vars[$ "race:bubbles"].sprCampfireTo;
;
}

// Original Characters/bubbles.race.gml:169
function fr_Characters_bubbles_race_gml_race_cf_sprdeselecting() {
return global.fr_module_vars[$ "race:bubbles"].sprCampfireFrom;
;
}

// Original Characters/bubbles.race.gml:170
function fr_Characters_bubbles_race_gml_race_cf_shadowx() {
return 0;
;
}

// Original Characters/bubbles.race.gml:171
function fr_Characters_bubbles_race_gml_race_cf_shadowy() {
return 0;
;
}

// Original Characters/bubbles.race.gml:172
function fr_Characters_bubbles_race_gml_race_cf_corpse() {
return true;
;
}

// Original Characters/bubbles.race.gml:173
function fr_Characters_bubbles_race_gml_race_cf_spawnparticles() {
repeat (15) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = (scrFRSourceRandomRange(2, 3)) * timescale;
;
direction = scrFRSourceRandom(360);
;
sprite_index = scrFRAreaSourceSprite(sprFishBoost);
;
depth = (- 16);
;
}
}
if(__fr_break3) break;
}}
}
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Bubble)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
speed = (scrFRSourceRandomRange(1, 2)) * timescale;
;
}
}
if(__fr_break6) break;
}}
}
repeat (3) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBubblePop)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = (scrFRSourceRandomRange(1, 3)) * timescale;
;
direction = scrFRSourceRandom(360);
;
}
}
if(__fr_break9) break;
}}
}
repeat (5) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, FishBoost)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
speed = (scrFRSourceRandomRange(1, 2)) * timescale;
;
direction = scrFRSourceRandom(360);
;
depth = (- 16);
;
}
}
if(__fr_break12) break;
}}
}
if ((scrFRSourceRandom(50) < 1)) {
{
scrFRSoundPlay(global.fr_module_vars[$ "race:bubbles"].sndBoom);
;
}
}
}

// Original Characters/bubbles.race.gml:207
function fr_Characters_bubbles_race_gml_race_skins() {
return 2;
;
}

// Original Characters/bubbles.race.gml:208
function fr_Characters_bubbles_race_gml_race_skin_button(_frl__skin=undefined) {
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprSkinIcon, _frl__skin));
;
image_index = (! fr_Characters_bubbles_race_gml_race_skin_avail(_frl__skin));
;
}

// Original Characters/bubbles.race.gml:209
function fr_Characters_bubbles_race_gml_race_skin_avail(_frl__skin=undefined) {
{ var __fr_switch_value1=_frl__skin, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(0)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return 1;
;
case 1:
return frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", "unlock_bubbles_bskin");
;
}
}
}

// Original Characters/bubbles.race.gml:216
function fr_Characters_bubbles_race_gml_race_skin_lock(_frl__skin=undefined) {
{ var __fr_switch_value1=_frl__skin, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(0)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return scrFRLocalize("YOU MESSED UP#YOUR FILE SOMEHOW LOL");
;
case 1:
return scrFRLocalize(((((("TRADE 10#UNIQUE WEAPONS#" + ("@1(" + string(global.fr_module_vars[$ "race:bubbles"].sprCoveIcon) + ":0)")) + "@s(@w") + string(array_length(frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", "pirate_conversions")))) + "@s/@w10@s)") + ("@1(" + string(global.fr_module_vars[$ "race:bubbles"].sprCoveIcon) + ":0)")));
;
}
}
}

// Original Characters/bubbles.race.gml:223
function fr_Characters_bubbles_race_gml_race_skin_unlock(_frl__skin=undefined) {
{ var __fr_switch_value1=_frl__skin, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return scrFRLocalize("FOR TRADING 15 UNIQUE WEAPONS");
;
}
}
}

// Original Characters/bubbles.race.gml:229
function fr_Characters_bubbles_race_gml_race_skin_name(_frl__skin=undefined) {
if (fr_Characters_bubbles_race_gml_race_skin_avail(_frl__skin)) {
{
return scrFRLocalize((chr((65 + _frl__skin)) + " SKIN"));
;
}
} else {
{
return scrFRLocalize(fr_Characters_bubbles_race_gml_race_skin_lock(_frl__skin));
;
}
}
}

// Original Characters/bubbles.race.gml:237
function fr_Characters_bubbles_race_gml_race_swep() {
{ var __fr_switch_value1=scrFRPlayerSkin((scrFRVariableExists((scrFROther(other)), "index") ? (scrFROther(other)).index : 0)), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1) __fr_switch_case2=1;
switch(__fr_switch_case2) {
case 0:
return "FR_BubblesShovel";
;
case 1:
return "FR_BubblesCutlass";
;
}
}
}

// Original Characters/bubbles.race.gml:245
function fr_Characters_bubbles_race_gml_race_ultra_button() {
sprite_index = scrFRAreaSourceSprite(scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprUltra, (argument_count>0 ? argument[0] : undefined)));
;
}

// Original Characters/bubbles.race.gml:246
function fr_Characters_bubbles_race_gml_race_ultra_icon() {
return scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprUltraIcon, (argument_count>0 ? argument[0] : undefined));
;
}

// Original Characters/bubbles.race.gml:247
function fr_Characters_bubbles_race_gml_race_ultra_name() {
{ var __fr_switch_value1=(argument_count>0 ? argument[0] : undefined), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return scrFRLocalize(scrFRLoc("Frontier:BubblesUltraA:Name", "BUBBLE BARRICADE"));
;
case 1:
return scrFRLocalize(scrFRLoc("Frontier:BubblesUltraB:Name", "BUBBLE BARRAGE"));
;
}
}
; // macro hoisted: ult_Barricade
; // macro hoisted: ult_Barrage
}

// Original Characters/bubbles.race.gml:255
function fr_Characters_bubbles_race_gml_race_ultra_text() {
{ var __fr_switch_value1=(argument_count>0 ? argument[0] : undefined), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return scrFRLocalize(scrFRLoc("Frontier:BubblesUltraA:Text", "@sGAIN @wDEFENSIVE @(color:16234606)BUBBLE @wORBITALS#@sTAKE @wEVEN LESS @sCONTACT DAMAGE"));
;
case 1:
return scrFRLocalize(scrFRLoc("Frontier:BubblesUltraB:Text", "@(color:16234606)BUBBLES @wCONVERT @sAND @wREFIRE#@sABSORBED @wPROJECTILES @sWHEN POPPED"));
;
}
}
}

// Original Characters/bubbles.race.gml:261
function fr_Characters_bubbles_race_gml_race_ultra_take() {
if (scrFRInstanceExists(SkillIcon)) {
{ var __fr_switch_value1=(argument_count>0 ? argument[0] : undefined), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=1;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
scrFRSoundPlay(global.fr_module_vars[$ "race:bubbles"].sndBubblesUltraA);
;
break;
;
case 1:
scrFRSoundPlay(global.fr_module_vars[$ "race:bubbles"].sndBubblesUltraB);
;
break;
;
}
}
}
}

// Original Characters/bubbles.race.gml:268
function fr_Characters_bubbles_race_gml_race_handy() {
return true;
;
}

// Original Characters/bubbles.race.gml:269
function fr_Characters_bubbles_race_gml_race_handy_data0() {
return {"hand_color": make_color_rgb(0, 184, 0), "dual_fire": false};
}

// Original Characters/bubbles.race.gml:274
function fr_Characters_bubbles_race_gml_race_handy_data1() {
return {"hand_color": make_color_rgb(174, 155, 126), "dual_fire": false};
}

// Original Characters/bubbles.race.gml:279
function fr_Characters_bubbles_race_gml_race_handy_data2() {
return {"hand_color": make_color_rgb(201, 209, 222), "dual_fire": false};
}

// Original Characters/bubbles.race.gml:286
function fr_Characters_bubbles_race_gml_create() {
if ((! fr_Characters_bubbles_race_gml_race_avail())) {
{
race = scrFRRaceResolve("fish");
;
scrFRPlayerSetRace(index, race);
;
exit;
;
}
}
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprIdle, bskin);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprDead, bskin);
;
spr_bubble = (- 1);
;
spr_bubble_pop = (- 1);
;
bubbles_maxBubbleCharge = 100;
;
bubbles_bubbleCharge = bubbles_maxBubbleCharge;
;
bubbles_bubbleCooldown = 0;
;
bubbles_reducedEnemies = [];
;
bubbles_ultraOrbitalSize = 1;
;
water_breathing = true;
;
race_gets_chilly = true;
;
hatOffset = [0, 2];
alcoholTolerance = 50;
;
charisma = 1;
;
fr_Characters_bubbles_race_gml_assign_sprites();
;
fr_Characters_bubbles_race_gml_assign_sounds();
;
}

// Original Characters/bubbles.race.gml:322
function fr_Characters_bubbles_race_gml_assign_sprites() {
if ((scrFRObjectIndex(scrFRSelf(self)) == Player)) {
{
spr_idle = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprIdle, bskin);
;
spr_walk = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprWalk, bskin);
;
spr_hurt = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprHurt, bskin);
;
spr_dead = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprDead, bskin);
;
spr_gosit = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprGoSit, bskin);
;
spr_sit = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprSit, bskin);
;
spr_fire = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprFire, bskin);
;
spr_bubbleprojectile = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleProjectile, bskin);
;
spr_bubbleprojectilebig = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleProjectileBig, bskin);
;
spr_bubbletrail = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleTrail, bskin);
;
spr_bubbleexplo = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprSmallBubbleExplosion, bskin);
;
spr_nullify = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleProjectileNullify, bskin);
;
spr_sprayparticle = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleSprayParticle, bskin);
;
spr_burst = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleProjectileBurst, bskin);
;
spr_burstbullet = scrFRIndexGet(global.fr_module_vars[$ "race:bubbles"].sprBubbleProjectileBurstBullet, bskin);
;
}
}
}

// Original Characters/bubbles.race.gml:342
function fr_Characters_bubbles_race_gml_assign_sounds() {
snd_wrld = global.fr_module_vars[$ "race:bubbles"].sndBubblesWrld;
;
snd_hurt = global.fr_module_vars[$ "race:bubbles"].sndBubblesHurt;
;
snd_dead = global.fr_module_vars[$ "race:bubbles"].sndBubblesDead;
;
snd_lowa = global.fr_module_vars[$ "race:bubbles"].sndBubblesLowA;
;
snd_lowh = global.fr_module_vars[$ "race:bubbles"].sndBubblesLowH;
;
snd_chst = global.fr_module_vars[$ "race:bubbles"].sndBubblesChst;
;
snd_valt = global.fr_module_vars[$ "race:bubbles"].sndBubblesValt;
;
snd_crwn = global.fr_module_vars[$ "race:bubbles"].sndBubblesCrwn;
;
snd_spch = global.fr_module_vars[$ "race:bubbles"].sndBubblesSpch;
;
snd_idpd = global.fr_module_vars[$ "race:bubbles"].sndBubblesIDPD;
;
snd_cptn = global.fr_module_vars[$ "race:bubbles"].sndBubblesCptn;
;
}

// Original Characters/bubbles.race.gml:357
function fr_Characters_bubbles_race_gml_race_frontier() {
return true;
;
}

// Original Characters/bubbles.race.gml:358
function fr_Characters_bubbles_race_gml_race_frontier_savestats() {
var _frl_newKills = (GameCont.kills - global.fr_module_vars[$ "race:bubbles"].lastKills);
global.fr_module_vars[$ "race:bubbles"].lastKills = GameCont.kills;
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_kills")), (frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_kills"))) + _frl_newKills));
var _frl_newLoop = (GameCont.loops - global.fr_module_vars[$ "race:bubbles"].lastLoop);
global.fr_module_vars[$ "race:bubbles"].lastLoop = GameCont.loops;
if ((_frl_newLoop > 0)) {
{
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_loops")), (frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_loops"))) + _frl_newLoop));
}
}
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_time")), (frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_time"))) + global.fr_module_vars[$ "race:bubbles"].lastTime));
global.fr_module_vars[$ "race:bubbles"].lastTime = 0;
;
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_bubbles")), (frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_bubbles"))) + global.fr_module_vars[$ "race:bubbles"].lastBubbles));
global.fr_module_vars[$ "race:bubbles"].lastBubbles = 0;
;
if ((GameCont.kills >= frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_best_kills"))))) {
{
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_best_area")), [GameCont.area, GameCont.subarea, GameCont.loops]);
;
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_best_kills")), GameCont.kills);
;
}
}
}

// Original Characters/bubbles.race.gml:390
function fr_Characters_bubbles_race_gml_game_start() {
global.fr_module_vars[$ "race:bubbles"].lastKills = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastTime = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastLoop = 0;
;
global.fr_module_vars[$ "race:bubbles"].lastBubbles = 0;
;
frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_set, "Frontier", ("bubbles" + string("_runs")), (frMacro_Characters_bubbles_race_gml_call(frMacro_Characters_bubbles_race_gml_scr.save_get, "Frontier", ("bubbles" + string("_runs"))) + 1));
}

// Original Characters/bubbles.race.gml:402
function fr_Characters_bubbles_race_gml_level_start() {
fr_Characters_bubbles_race_gml_race_frontier_savestats();
bubbles_bubbleCharge = bubbles_maxBubbleCharge;
;
if (scrFRModLoaded("mod", "ntte")) {
{
if ((bskin == scrFRSkinResolve(1))) {
{
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomHitme, "name", "NTTEPet"), "pet", "Slaughter")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((leader == (scrFROther(other)))) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_skeletonized"))) {
{
scrFRModCall("mod", "Frontier_Objects", "SlaughterB_applyskin");
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
}
}
}
}

// Original Characters/bubbles.race.gml:422
function fr_Characters_bubbles_race_gml_step() {
global.fr_module_vars[$ "race:bubbles"].lastTime += (scrFRSourceScale() / 30);
;
if (array_length(bubbles_reducedEnemies)) {
{
var _frl__temp = [];
;
{ var __fr_with1 = scrFRWithValues(scrFRMatchingGT(fr_Characters_bubbles_race_gml_array_prune(bubbles_reducedEnemies), "meleedamage", 0)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((distance_to_object((scrFROther(other))) < 10)) {
{
array_push(_frl__temp, scrFRSelf(self));
;
}
} else {
{
meleedamage = base_contact_damage;
;
}
}
}
}
if(__fr_break3) break;
}}
bubbles_reducedEnemies = _frl__temp;
;
}
}
{ var __fr_with4 = scrFRWithValues(instance_nearest(x, y, enemy)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((meleedamage <= 0)) {
{
continue;
;
}
}
if ((!scrFRVariableExists(scrFRSelf(self), "base_contact_damage"))) {
{
base_contact_damage = meleedamage;
;
}
}
if ((scrFRArrayFindIndex((scrFROther(other)).bubbles_reducedEnemies, scrFRSelf(self)) == (- 1))) {
{
if ((distance_to_object((scrFROther(other))) < 10)) {
{
var __fr_other7=scrFROther(other);
array_push(__fr_other7.bubbles_reducedEnemies, scrFRSelf(self));
;
var _frl__reduction = (2 + scrFRUltraGet("bubbles", frMacro_Characters_bubbles_race_gml_ult_Barricade));
;
meleedamage = max(1, (meleedamage - _frl__reduction));
;
}
}
}
}
}
}
if(__fr_break6) break;
}}
if ((bubbles_bubbleCharge < bubbles_maxBubbleCharge)) {
{
bubbles_bubbleCharge += scrFRSourceScale();
;
}
}
if ((bubbles_bubbleCharge > bubbles_maxBubbleCharge)) {
{
bubbles_bubbleCharge = bubbles_maxBubbleCharge;
;
}
}
if (((can_spec && (bubbles_bubbleCharge > 0)) && (bubbles_bubbleCooldown <= 0))) {
{
if (scrFRButtonCheck(index, "spec")) {
{
bubbles_bubbleCharge -= ((5 * scrFRSourceScale()) + (scrFRGetSkill(mut_throne_butt) * 7));
;
if (frMacro_Characters_bubbles_race_gml_current_frame_active) {
{
scrFRSoundPitchVolume(scrFRSourceChoose(global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec, global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec2, global.fr_module_vars[$ "race:bubbles"].sndBubblesSpec3), scrFRSourceRandomRange(0.8, 1.1), 0.5);
;
scrFRSoundPitchVolume(sndOasisHurt, scrFRSourceRandomRange(0.8, 1.2), 0.4);
;
}
}
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_fire);
}
}
speed = (((maxspeed / timescale) + 2)) * timescale;
;
scrFRMotionAdd(gunangle, (- 3));
;
if (frMacro_Characters_bubbles_race_gml_current_frame_active) {
{
fr_Characters_bubbles_race_gml_BubbleProjectile_spray();
;
if (scrFRGetSkill(mut_throne_butt)) {
{
bubbles_bubbleCooldown += 3;
;
}
}
}
}
}
}
}
}
if ((bubbles_bubbleCharge <= 0)) {
{
bubbles_bubbleCooldown = 30;
;
}
}
if ((bubbles_bubbleCooldown > 0)) {
{
bubbles_bubbleCooldown -= scrFRSourceScale();
;
}
}
if ((scrFRUltraGet("bubbles", frMacro_Characters_bubbles_race_gml_ult_Barricade) > 0)) {
{
if ((array_length(scrFRMatching(scrFRMatching(FRCustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", scrFRSelf(self))) != 3)) {
{
if ((! scrFRInstanceExists(PortalShock))) {
{
fr_Characters_bubbles_race_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 0, 19);
;
fr_Characters_bubbles_race_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 120, 19);
;
fr_Characters_bubbles_race_gml_BubbleOrbital_create(x, y, scrFRSelf(self), 240, 19);
;
if ((array_length(scrFRMatching(scrFRMatching(FRCustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", scrFRSelf(self))) > 3)) {
{
{ var __fr_with8 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomSlash, "name", "bubbles_ultraOrbital"), "ownerid", scrFRSelf(self))), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
scrFRInstanceDestroy();
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
if ((bubbles_ultraOrbitalSize < 1)) {
{
bubbles_ultraOrbitalSize += (0.04 * scrFRSourceScale());
;
}
} else {
{
bubbles_ultraOrbitalSize = 1;
;
}
}
if ((bubbles_ultraOrbitalSize < 0)) {
{
bubbles_ultraOrbitalSize = 0;
;
}
}
}
}
}

// Original Characters/bubbles.race.gml:548
function fr_Characters_bubbles_race_gml_BubbleProjectile_spray() {
global.fr_module_vars[$ "race:bubbles"].lastBubbles += 1;
;
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FishBoost)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 45), 45));
;
image_angle = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
depth = (- 3);
;
var __fr_other5=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other5.spr_sprayparticle);
;
}
}
if(__fr_break3) break;
}}
}
if ((scrFRSourceRandom(3) < 1)) {
{
scrFRInstanceCreate(x, y, Bubble);
}
}
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(3, gunangle)), (y + lengthdir_y(3, gunangle)), FRCustomSlash)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
name = "bubbles_bubbleProjectile";
var __fr_other9=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other9.spr_bubbleprojectile);
;
mask_index = global.fr_module_vars[$ "race:bubbles"].mskBubbleProjectile;
;
var __fr_other10=scrFROther(other);
spr_bubbletrail = __fr_other10.spr_bubbletrail;
;
var __fr_other11=scrFROther(other);
spr_bubbleexplo = __fr_other11.spr_bubbleexplo;
;
var __fr_other12=scrFROther(other);
spr_nullify = __fr_other12.spr_nullify;
;
var __fr_other13=scrFROther(other);
spr_burst = __fr_other13.spr_burst;
;
var __fr_other14=scrFROther(other);
spr_burstbullet = __fr_other14.spr_burstbullet;
;
rotation_speed = (scrFRSourceRandomRange(5, 10) * scrFRSourceScale());
image_speed = (0) * timescale;
image_index = 0;
;
image_xscale = scrFRSourceRandomRange(0.8, 1.3);
;
image_yscale = image_xscale;
;
image_angle = 0;
;
depth = (- 3);
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.05];
;
trailRange = 6;
;
bubble_tiltspeed = scrFRSourceRandomRange(0.17, 0.2);
;
bubble_tiltrange = scrFRSourceRandomRange(35, 50);
;
damage = (1 + (scrFRGetSkill(mut_throne_butt) * 3));
var __fr_other15=scrFROther(other);
direction = (point_direction(x, y, scrFRMouseCoordinate(0, __fr_other15.index), scrFRMouseCoordinate(1, __fr_other15.index)) + scrFRSourceRandomRange((- 20), 20));
var __fr_other16=scrFROther(other);
team = __fr_other16.team;
;
speed = ((5.5 + scrFRSourceRandomRange(0.8, 2.3))) * timescale;
;
friction = ((0.2 + (scrFRGetSkill(mut_throne_butt) * 0.4))) * (timescale * timescale);
;
ultra_b_charges = 0;
;
ammo_type = (- 1);
;
if (scrFRGetSkill(mut_throne_butt)) {
{
var __fr_other17=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other17.spr_bubbleprojectilebig);
;
mask_index = mskSuperFlakBullet;
;
friction = (0.1) * (timescale * timescale);
;
speed = ((2.5 + scrFRSourceRandomRange(0.8, 2.3))) * timescale;
;
trailRange = 12;
;
}
}
lifeTime = (scrFRGetSkill(mut_throne_butt) ? 75 : 0);
;
on_projectile = fr_Characters_bubbles_race_gml_BubbleProjectile_nullify;
;
on_anim = fr_Characters_bubbles_race_gml_nothing;
;
on_step = fr_Characters_bubbles_race_gml_BubbleProjectile_step;
;
on_wall = fr_Characters_bubbles_race_gml_BubbleProjectile_wall;
;
on_hit = fr_Characters_bubbles_race_gml_BubbleProjectile_hit;
;
on_destroy = fr_Characters_bubbles_race_gml_BubbleProjectile_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break8) break;
}}
}

// Original Characters/bubbles.race.gml:628
function fr_Characters_bubbles_race_gml_BubbleProjectile_step() {
image_angle = (0 + (sin((scrFRSourceFrame() * bubble_tiltspeed)) * bubble_tiltrange));
if ((scrFRSourceRandom(25) < scrFRSourceScale())) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- trailRange), trailRange)), (y + scrFRSourceRandomRange((- trailRange), trailRange)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_bubbletrail);
;
var __fr_other5=scrFROther(other);
speed = (((__fr_other5.speed / timescale) / 4)) * timescale;
;
var __fr_other6=scrFROther(other);
direction = ((__fr_other6.direction + 180) + scrFRSourceRandomRange((- 15), 15));
;
}
}
if(__fr_break3) break;
}}
}
}
if (((speed / timescale) < 2)) {
{
if ((lifeTime > 0)) {
{
lifeTime -= scrFRSourceScale();
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

// Original Characters/bubbles.race.gml:651
function fr_Characters_bubbles_race_gml_BubbleProjectile_nullify() {
// FRONTIER BUBBLES FRIENDLY PROJECTILE FILTER
if(team!=team_none && (scrFROther(other)).team==team) return;

if (scrFRInstanceExists(scrFRSelf(self))) {
{
var _frl_me = scrFRSelf(self);
;
if (((scrFROther(other)).typ > 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
;
}
}
if(__fr_break6) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
if ((scrFRUltraGet("bubbles", frMacro_Characters_bubbles_race_gml_ult_Barrage) > 0)) {
{
ultra_b_charges += 1;
;
}
}
}
}
}
}
}

// Original Characters/bubbles.race.gml:667
function fr_Characters_bubbles_race_gml_BubbleProjectileSub_nullify() {
// FRONTIER BUBBLES FRIENDLY PROJECTILE FILTER
if(team!=team_none && (scrFROther(other)).team==team) return;

if (scrFRInstanceExists(scrFRSelf(self))) {
{
var _frl_me = scrFRSelf(self);
;
if (((scrFROther(other)).typ > 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
;
}
}
if(__fr_break6) break;
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
}
}

// Original Characters/bubbles.race.gml:680
function fr_Characters_bubbles_race_gml_BubbleProjectile_wall() {
move_bounce_solid(true);
;
speed *= 0.7;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + (hspeed / timescale)), (y + (vspeed / timescale)), MeleeHitWall)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
image_angle = ((direction + 180) - angle_difference(__fr_other4.direction, (direction + 180)));
image_yscale = scrFRSourceRandomRange(0.5, 0.8);
;
image_speed *= 2;
;
image_index = scrFRSourceIRandom(1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:690
function fr_Characters_bubbles_race_gml_BubbleProjectile_hit() {
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage);
;
scrFRInstanceDestroy();
;
}

// Original Characters/bubbles.race.gml:694
function fr_Characters_bubbles_race_gml_BubbleProjectile_destroy() {
if ((ultra_b_charges > 0)) {
{
fr_Characters_bubbles_race_gml_BubbleProjectileBurst_create(x, y, ultra_b_charges);
}
}
scrFRSoundPitchVolume(sndOasisHurt, scrFRSourceRandomRange(0.8, 1.2), 0.1);
;
scrFRSoundPitchVolume(sndOasisExplosionSmall, scrFRSourceRandomRange(0.8, 1.2), 0.2);
;
scrFRSoundPitchVolume(global.fr_module_vars[$ "race:bubbles"].sndBubblePop, scrFRSourceRandomRange(0.5, 1.2), 0.75);
;
repeat (scrFRSourceIRandom(3)) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 1), 1)), (y + scrFRSourceRandomRange((- 1), 1)), Bubble)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_bubbleexplo);
;
mask_index = mskSmallExplosion;
;
var __fr_other8=scrFROther(other);
spr_nullify = __fr_other8.spr_nullify;
;
image_speed = (0.4) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.05];
;
ammo_type = (- 1);
;
speed = (0) * timescale;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10.creator;
;
ultra_b_charges = 0;
;
on_projectile = fr_Characters_bubbles_race_gml_BubbleProjectileSub_nullify;
;
on_wall = fr_Characters_bubbles_race_gml_nothing;
;
on_hit = fr_Characters_bubbles_race_gml_nothing;
;
}
}
if(__fr_break6) break;
}}
}

// Original Characters/bubbles.race.gml:734
function fr_Characters_bubbles_race_gml_BubbleProjectileBurst_create(_frl__x=undefined, _frl__y=undefined, _frl__charges=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ProjectileBurst";
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_burst);
;
var __fr_other5=scrFROther(other);
spr_burstbullet = __fr_other5.spr_burstbullet;
;
var __fr_other6=scrFROther(other);
spr_bubbleexplo = __fr_other6.spr_bubbleexplo;
;
var __fr_other7=scrFROther(other);
spr_nullify = __fr_other7.spr_nullify;
;
var __fr_other8=scrFROther(other);
spr_bubbletrail = __fr_other8.spr_bubbletrail;
;
image_index = 2;
;
image_speed = (0) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.1];
;
ammo = _frl__charges;
;
burstDelay = 4;
;
var __fr_other9=scrFROther(other);
team = __fr_other9.team;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10.creator;
;
on_step = fr_Characters_bubbles_race_gml_BubbleProjectileBurst_step;
on_hit = fr_Characters_bubbles_race_gml_nothing;
;
on_wall = fr_Characters_bubbles_race_gml_nothing;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:760
function fr_Characters_bubbles_race_gml_BubbleProjectileBurst_step() {
image_angle += (10 * scrFRSourceScale());
;
if ((burstDelay > 0)) {
{
burstDelay -= scrFRSourceScale();
;
}
}
if ((ammo > 0)) {
{
if ((burstDelay <= 0)) {
{
scrFRSoundPitchVolume(sndOasisShoot, (1.2 + scrFRSourceRandom(0.2)), 0.7);
var __fr_other1=scrFROther(other);
fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_create(x, y, __fr_other1.spr_burstbullet, __fr_other1.spr_bubbleexplo, __fr_other1.spr_nullify, __fr_other1.spr_bubbletrail);
burstDelay = 2;
;
ammo -= 1;
;
}
}
}
}
if ((ammo <= 0)) {
{
image_xscale -= 0.2;
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

// Original Characters/bubbles.race.gml:784
function fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_create(_frl__x=undefined, _frl__y=undefined, _frl__sprite=undefined, _frl__spr_explo=undefined, _frl__spr_null=undefined, _frl__spr_trail=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ProjectileBurstBullet";
;
sprite_index = scrFRAreaSourceSprite(_frl__sprite);
;
spr_bubbleexplo = _frl__spr_explo;
;
spr_nullify = _frl__spr_null;
;
spr_trail = _frl__spr_trail;
;
image_speed = (0.4) * timescale;
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.1];
;
if (scrFRInstanceExists(enemy)) {
{
var _frl__nearestGuy = instance_nearest(x, y, enemy);
;
if ((! collision_line(x, y, _frl__nearestGuy.x, _frl__nearestGuy.y, Wall, false, false))) {
{
direction = (point_direction(x, y, _frl__nearestGuy.x, _frl__nearestGuy.y) + scrFRSourceRandomRange((- 15), 15));
;
}
} else {
{
direction = scrFRSourceRandom(360);
;
}
}
}
} else {
{
direction = scrFRSourceRandom(360);
;
}
}
mask_index = global.fr_module_vars[$ "race:bubbles"].mskBubbleProjectileBurstBullet;
;
damage = 5;
;
speed = ((11 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
image_angle = direction;
;
ultra_b_charges = 0;
;
on_anim = fr_Characters_bubbles_race_gml_nothing;
;
on_step = fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_step;
;
on_hit = fr_Characters_bubbles_race_gml_BubbleProjectile_hit;
;
on_wall = fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_wall;
;
on_destroy = fr_Characters_bubbles_race_gml_BubbleProjectile_destroy;
;
on_projectile = fr_Characters_bubbles_race_gml_BubbleProjectileSub_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:824
function fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_step() {
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other5=scrFROther(other);
direction = ((__fr_other5.direction + 180) + scrFRSourceRandomRange((- 5), 5));
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Characters/bubbles.race.gml:833
function fr_Characters_bubbles_race_gml_BubbleProjectileBurstBullet_wall() {
scrFRInstanceDestroy();
;
}

// Original Characters/bubbles.race.gml:837
function fr_Characters_bubbles_race_gml_BubbleOrbital_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__angle=undefined, _frl__dist=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_ultraOrbital";
;
sprite_index = scrFRAreaSourceSprite(_frl__creator.spr_bubbleprojectile);
;
spr_nullify = _frl__creator.spr_nullify;
;
image_speed = (0) * timescale;
;
depth = (- 3);
;
var __fr_other4=scrFROther(other);
image_xscale = __fr_other4.bubbles_ultraOrbitalSize;
;
image_yscale = image_xscale;
;
direction = _frl__creator.gunangle;
;
image_angle = _frl__creator.gunangle;
image_alpha = 0.8;
;
speed = (0) * timescale;
;
fr_bloom = [1.2, 0.05];
;
var __fr_other5=scrFROther(other);
ownerid = __fr_other5.id;
;
angle = _frl__angle;
;
dist = _frl__dist;
;
creator = _frl__creator;
;
team = _frl__creator.team;
;
typ = 0;
;
ammo_type = (- 1);
;
prism_duplicate = true;
;
on_wall = fr_Characters_bubbles_race_gml_nothing;
;
on_hit = fr_Characters_bubbles_race_gml_nothing;
;
on_projectile = fr_Characters_bubbles_race_gml_BubbleOrbital_nullify;
;
on_grenade = fr_Characters_bubbles_race_gml_nothing;
;
on_step = fr_Characters_bubbles_race_gml_BubbleOrbital_step;
;
on_end_step = fr_Characters_bubbles_race_gml_BubbleOrbital_endstep;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:876
function fr_Characters_bubbles_race_gml_BubbleOrbital_nullify() {
// FRONTIER BUBBLES FRIENDLY PROJECTILE FILTER
if(team!=team_none && (scrFROther(other)).team==team) return;

if (((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0)) && (creator.bubbles_ultraOrbitalSize > 0.2))) {
{
var _frl_me = scrFRSelf(self);
;
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(_frl_me.spr_nullify);
;
}
}
if(__fr_break6) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
if (scrFRInstanceExists(creator)) {
{
{ var __fr_with7 = scrFRWithValues(creator), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((bubbles_ultraOrbitalSize > 0)) {
{
bubbles_ultraOrbitalSize -= 0.10;
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Characters/bubbles.race.gml:897
function fr_Characters_bubbles_race_gml_BubbleOrbital_step() {
if (((! scrFRInstanceExists(creator)) || (! (scrFRUltraGet("bubbles", frMacro_Characters_bubbles_race_gml_ult_Barricade) > 0)))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if (frMacro_Characters_bubbles_race_gml_current_frame_active) {
{
if ((scrFRSourceRandom(2) > 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.creator.spr_bubbletrail);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
image_xscale = creator.bubbles_ultraOrbitalSize;
;
image_yscale = image_xscale;
;
angle += (6 * scrFRSourceScale());
;
direction = angle;
;
image_angle += (12 * scrFRSourceScale());
;
}

// Original Characters/bubbles.race.gml:919
function fr_Characters_bubbles_race_gml_BubbleOrbital_wall() {
xprevious = (x + (hspeed / timescale));
;
yprevious = (y + (vspeed / timescale));
;
}

// Original Characters/bubbles.race.gml:923
function fr_Characters_bubbles_race_gml_BubbleOrbital_endstep() {
{ var __fr_with1 = scrFRWithValues(ownerid), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
__fr_other4.xprevious = (x + lengthdir_x(__fr_other4.dist, __fr_other4.angle));
;
var __fr_other5=scrFROther(other);
__fr_other5.yprevious = (y + lengthdir_y(__fr_other5.dist, __fr_other5.angle));
;
var __fr_other6=scrFROther(other);
__fr_other6.x = (x + lengthdir_x(__fr_other6.dist, __fr_other6.angle));
;
var __fr_other7=scrFROther(other);
__fr_other7.y = (y + lengthdir_y(__fr_other7.dist, __fr_other7.angle));
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:932
function fr_Characters_bubbles_race_gml_race_ntte_guardian_step() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((speed / timescale) > 5)) {
{
fr_Characters_bubbles_race_gml_GuardianBubble_create(x, y);
;
scrFRInstanceCreate(x, y, Bubble);
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:940
function fr_Characters_bubbles_race_gml_GuardianBubble_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "bubbles_guardianBubble";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "race:bubbles"].sprGuardianBubble);
;
mask_index = global.fr_module_vars[$ "race:bubbles"].mskBubbleProjectile;
;
spr_bubbletrail = global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleTrail;
;
spr_bubbleexplo = global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleExplosion;
;
spr_nullify = global.fr_module_vars[$ "race:bubbles"].sprGuardianBubbleNullify;
;
rotation_speed = (scrFRSourceRandomRange(5, 10) * scrFRSourceScale());
image_speed = (0) * timescale;
image_index = 0;
;
image_xscale = scrFRSourceRandomRange(0.8, 1.3);
;
image_yscale = image_xscale;
;
image_angle = 0;
;
depth = (- 3);
;
image_alpha = 0.8;
;
fr_bloom = [1.2, 0.05];
;
trailRange = 6;
;
bubble_tiltspeed = scrFRSourceRandomRange(0.17, 0.2);
;
bubble_tiltrange = scrFRSourceRandomRange(35, 50);
;
damage = 5;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.direction + scrFRSourceRandomRange((- 80), 80));
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
speed = (3) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
ultra_b_charges = 0;
;
lifeTime = 75;
;
ammo_type = (- 1);
;
on_projectile = fr_Characters_bubbles_race_gml_BubbleProjectile_nullify;
;
on_anim = fr_Characters_bubbles_race_gml_nothing;
;
on_step = fr_Characters_bubbles_race_gml_BubbleProjectile_step;
;
on_wall = fr_Characters_bubbles_race_gml_BubbleProjectile_wall;
;
on_hit = fr_Characters_bubbles_race_gml_BubbleProjectile_hit;
;
on_destroy = fr_Characters_bubbles_race_gml_BubbleProjectile_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Characters/bubbles.race.gml:991
function fr_Characters_bubbles_race_gml_nothing() {

}

// Original Characters/bubbles.race.gml:992
function fr_Characters_bubbles_race_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Characters/bubbles.race.gml:993
function fr_Characters_bubbles_race_gml_array_prune(_frl__array=undefined) {
return scrFRMatchingNE(_frl__array, "id");
;
}
