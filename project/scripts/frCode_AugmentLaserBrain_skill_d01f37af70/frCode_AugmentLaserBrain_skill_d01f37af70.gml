#macro frMacro_Mutations_AugmentLaserBrain_skill_gml_refundChance 2.5

#macro frMacro_Mutations_AugmentLaserBrain_skill_gml_reloadBuff 0.6

// Original Mutations/AugmentLaserBrain.skill.gml:1
function fr_Mutations_AugmentLaserBrain_skill_gml___load() {

}

// Original Mutations/AugmentLaserBrain.skill.gml:1
function fr_Mutations_AugmentLaserBrain_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprSkillIcon = sprFR_sprAugmentLaserBrain_cfdc1901785c;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprSkillHud = sprFR_sprAugmentLaserBrainIcon_44bffc1d80db;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced = false;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles = true;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingGreenAugments = false;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeam = sprFR_sprPopoBeam_fa44a6c765e2;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamCharge = sprFR_sprPopoBeamCharge_d543c7062871;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamStart = sprFR_sprPopoBeamStart_0b7772f32267;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamEnd = sprFR_sprPopoBeamEnd_bdf4e82f118a;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoLaserFlak = sprFR_sprPopoLaserFlak_444472aeb13b;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmaImpactSmallDefpack = sprFR_sprPopoPlasmaImpactSmall_11805d640d5f;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmite = sprFR_sprPopoPlasmite_25de30240a9b;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmiteUpg = sprFR_sprPopoPlasmiteUpg_0f46fd12d743;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmiteBig = sprFR_sprPopoPlasmiteBig_bf85d9748af9;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEShank = sprFR_sprPopoEShank_09c02a1266ee;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoSonicExplosion = sprFR_sprPopoESonicExplosion_b61ae55a0e2d;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyEffect = sprFR_sprPopoEnergyEffect_13c30457e33a;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPSD = sprFR_sprPopoPSD_7d7a86579622;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyChainsaw = sprFR_sprPopoEnergyChainsaw_ab6f382584d4;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyChainsawActive = sprFR_sprPopoEnergyChainsawAct_a858efbd54bf;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoAllyLaserCharge = sprFR_sprPopoAllyLaserCharge_466264113f16;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyBatSlash = sprFR_sprPopoEnergyBatSlash_d360839d2124;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoVlasmaBullet = sprFR_sprPopoVlasmaBullet_c7cb897c09a5;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoVlasmaCannon = sprFR_sprPopoVlasmaCannon_106d8920b455;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmaImpactSmall = sprFR_sprPopoPlasmaImpactSmall_bffdaf500625;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyBat = sprFR_sprPopoEnergyBat_116fb1111b86;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyShovel = sprFR_sprPopoEnergyShovel_190119db5761;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergySword = sprFR_sprPopoEnergySword_9e5a14bb551d;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyScrewdriver = sprFR_sprPopoEnergyScrewdriver_153a7d2b3bae;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyHammer = sprFR_sprPopoEnergyHammer_eab00e0da3d5;
;
; // macro hoisted: refundChance
; // macro hoisted: reloadBuff
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_spriteinit();
;
fr_Mutations_AugmentLaserBrain_skill_gml_game_start();
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:50
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_spriteinit() {
var _frl__path = "../sprites/projectiles/popoenergy/";
var _frl__weppath = "../sprites/weapons/popovariants/";
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentBaseSprites = [[sprLaserBrain, ("" + string(_frl__path) + "sprPopoLaserBrain.png"), 7, (- 3), 8], [sprLaser, ("" + string(_frl__path) + "sprPopoLaser.png"), 1, 2, 3], [sprLaserStart, ("" + string(_frl__path) + "sprPopoLaserStart.png"), 8, 8, 6], [sprLaserEnd, ("" + string(_frl__path) + "sprPopoLaserEnd.png"), 8, 10, 8], [sprPlasmaBall, ("" + string(_frl__path) + "sprPopoPlasmaBall.png"), 2, 12, 12], [sprPlasmaBallBig, ("" + string(_frl__path) + "sprPopoPlasmaBallBig.png"), 2, 16, 16], [sprPlasmaBallHuge, ("" + string(_frl__path) + "sprPopoPlasmaBallHuge.png"), 2, 24, 24], [sprPlasmaImpact, ("" + string(_frl__path) + "sprPopoPlasmaImpact.png"), 7, 16, 16], [sprPlasmaTrail, ("" + string(_frl__path) + "sprPopoPlasmaTrail.png"), 3, 4, 4], [sprEnergyShank, ("" + string(_frl__path) + "sprPopoEnergyShank.png"), 2, (- 5), 8], [sprEnergySlash, ("" + string(_frl__path) + "sprPopoEnergySlash.png"), 3, (- 8), 24], [sprHeavyEnergySlash, ("" + string(_frl__path) + "sprPopoHeavyEnergySlash.png"), 3, (- 8), 24], [sprGunGunFire, ("" + string(_frl__path) + "sprPopoGunGunFire.png"), 12, 8, 8], [sprEnergySword, ("" + string(_frl__weppath) + "sprPopoEnergySword.png"), 7, 2, 1], [sprEnergyScrewDriver, ("" + string(_frl__weppath) + "sprPopoEnergyScrewdriver.png"), 7, (- 2), 2], [sprEnergyHammer, ("" + string(_frl__weppath) + "sprPopoEnergyHammer.png"), 7, 5, 5]];
global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentBaseSpritesRestore = [sprLaserBrain, sprLaser, sprLaserStart, sprLaserEnd, sprPlasmaBall, sprPlasmaBallBig, sprPlasmaBallHuge, sprPlasmaImpact, sprPlasmaTrail, sprEnergyShank, sprEnergySlash, sprHeavyEnergySlash, sprGunGunFire, sprEnergySword, sprEnergyScrewDriver, sprEnergyHammer];
global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods = [];
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpriteStorage = ds_list_create();
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSprites = ds_list_create();
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:99
function fr_Mutations_AugmentLaserBrain_skill_gml_game_start() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentLaserBrain_skill_gml_game_start_resume, id, scrFROther(other), _args, 6, []);
}
function fr_Mutations_AugmentLaserBrain_skill_gml_game_start_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentLaserBrain_skill_gml_game_start");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentLaserBrain.skill.gml:179
{
;
}
_fr.pc=0;
break;
case 2: // Mutations/AugmentLaserBrain.skill.gml:179
_fr.result=undefined; _fr.done=true; return;
break;
case 3: // Mutations/AugmentLaserBrain.skill.gml:177
{
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite();
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentLaserBrain.skill.gml:177
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 5: // Mutations/AugmentLaserBrain.skill.gml:176
_fr.pc = (((global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced == true) && (! scrFRGetSkill("AugmentLaserBrain")))) ? 4 : 0;
break;
case 6: // Mutations/AugmentLaserBrain.skill.gml:102
{
if (scrFRModLoaded("mod", "defpack tools")) {
{
_fr.vars._knownIndex = 0;
;
_fr.vars._seeMe = 0;
;
_fr.vars._sprPath = scrFRModGet("mod", "defpack tools", "spr");
repeat (array_length(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods)) {
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, _fr.vars._knownIndex) == "defpack tools")) {
{
_fr.vars._seeMe += 1;
;
}
}
_fr.vars._knownIndex += 1;
;
}
if ((_fr.vars._seeMe <= 0)) {
{
array_push(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, "defpack tools");
;
{ var __fr_with1 = scrFRWithValues(_fr.vars._sprPath), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", LaserFlakBullet, "LaserFlakBullet", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoLaserFlak);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", PlasmaImpactSmall, "PlasmaImpactSmall", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmaImpactSmallDefpack);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", Plasmite, "Plasmite", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmite);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "defpack tools", "spr", PlasmiteUpg, "PlasmiteUpg", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmiteUpg);
;
}
}
if(__fr_break3) break;
}}
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "mega laser cannon", "sprBeam", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeam);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "mega laser cannon", "sprBeamCharge", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamCharge);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "mega laser cannon", "sprBeamStart", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamStart);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "mega laser cannon", "sprBeamEnd", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoBeamEnd);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "plasmite cannon", "sprPlasmiteBig", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmiteBig);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "energy chainsaw", "sprChainsawShank", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEShank);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "psd", "sprSonicExplosion", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoSonicExplosion);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "psd", "sprEnergyEffect", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyEffect);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "psd", "sprEnergyDevice", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPSD);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "energy chainsaw", "sprChainsaw", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyChainsaw);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "energy chainsaw", "sprChainsawActive", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyChainsawActive);
;
}
}
}
}
if (scrFRModLoaded("mod", "teassets")) {
{
_fr.vars._knownIndex = 0;
;
_fr.vars._seeMe = 0;
;
_fr.vars._sprPath = scrFRModGet("mod", "teassets", "spr");
repeat (array_length(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods)) {
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, _fr.vars._knownIndex) == "teassets")) {
{
_fr.vars._seeMe += 1;
;
}
}
_fr.vars._knownIndex += 1;
;
}
if ((_fr.vars._seeMe <= 0)) {
{
array_push(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, "teassets");
;
{ var __fr_with4 = scrFRWithValues(_fr.vars._sprPath), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", AllyLaserCharge, "AllyLaserCharge", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoAllyLaserCharge);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", EnergyBatSlash, "EnergyBatSlash", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyBatSlash);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", VlasmaBullet, "VlasmaBullet", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoVlasmaBullet);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", VlasmaCannon, "VlasmaCannon", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoVlasmaCannon);
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext("mod", "teassets", "spr", PlasmaImpactSmall, "PlasmaImpactSmall", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoPlasmaImpactSmall);
;
}
}
if(__fr_break6) break;
}}
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "energy bat", "sprWep", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyBat);
;
}
}
}
}
if (scrFRModLoaded("weapon", "energy_shovel")) {
{
_fr.vars._knownIndex = 0;
;
_fr.vars._seeMe = 0;
;
repeat (array_length(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods)) {
if ((scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, _fr.vars._knownIndex) == "energy_shovel")) {
{
_fr.vars._seeMe += 1;
;
}
}
_fr.vars._knownIndex += 1;
;
}
if ((_fr.vars._seeMe <= 0)) {
{
array_push(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpritesMods, "energy_shovel");
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite("weapon", "energy_shovel", "sprite", global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyShovel);
;
}
}
}
}
}
_fr.pc=5;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentLaserBrain.skill.gml:182
function fr_Mutations_AugmentLaserBrain_skill_gml_load_options(_frl__options=undefined) {
var _frl__prevSettingProjectiles = global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles;
var _frl__prevSettingGreen = global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingGreenAugments;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles = _frl__options.settingAugmentProjectiles;
;
global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingGreenAugments = _frl__options.settingGreenAugments;
;
if (scrFRGetSkill("AugmentLaserBrain")) {
{
if (((global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced == true) && (global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles == false))) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite();
;
}
}
if (((global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced == true) && (global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles != _frl__prevSettingProjectiles))) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_resprite();
;
}
}
if (((global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced == true) && (global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles != _frl__prevSettingGreen))) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite();
;
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_resprite();
;
}
}
}
}
}

// Original Mutations/AugmentLaserBrain.skill.gml:204
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLaserBrain:0", "PORTABLE FUSION REACTOR"));
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:205
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLaserBrain:1", "@wENERGY WEAPONS @(color:16776960)RELOAD FASTER#@sAND OFTEN @(color:16776960)REFUND @yAMMO"));
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:206
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_tip() {
return scrFRLocalize("DONT DROP IT");
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:207
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprSkillIcon);
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:208
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprSkillHud;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:209
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:210
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:211
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:212
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_augment() {
return mut_laser_brain;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:214
function fr_Mutations_AugmentLaserBrain_skill_gml_cleanup() {
if ((global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced == true)) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite();
;
}
}
}

// Original Mutations/AugmentLaserBrain.skill.gml:219
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_take() {
if ((global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingAugmentProjectiles == true)) {
{
if ((global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingGreenAugments == false)) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_resprite();
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(WepPickup, "wep", wep_energy_sword, wep_energy_screwdriver, wep_energy_hammer, "energy chainsaw", "psd", "energy_shovel")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = make_colour_rgb(0, 255, 255);
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
}

// Original Mutations/AugmentLaserBrain.skill.gml:232
function fr_Mutations_AugmentLaserBrain_skill_gml_skill_lose() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "fr_AugmentBoilingVeinsController")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite();
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:238
function fr_Mutations_AugmentLaserBrain_skill_gml_step() {
scrFRBindEndStep(fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_endstep, 0);
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:241
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_endstep() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentLaserBrain_lastEnergy"))) {
{
fr_augmentLaserBrain_lastEnergy = scrFRIndexGet(ammo, 5);
;
}
}
var _frl__wep = fr_Mutations_AugmentLaserBrain_skill_gml_wep_raw(scrFRWeaponSlotRead(scrFRSelf(self), "wep"));
;
if ((scrFRWeaponType(_frl__wep) == 5)) {
{
if ((reload > 0)) {
{
reload -= (frMacro_Mutations_AugmentLaserBrain_skill_gml_reloadBuff * scrFRGetSkill("AugmentLaserBrain"));
;
}
}
}
}
if ((race == scrFRRaceTryResolve("steroids"))) {
{
var _frl__bwep = fr_Mutations_AugmentLaserBrain_skill_gml_wep_raw(scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((scrFRWeaponType(_frl__bwep) == 5)) {
{
if ((breload > 0)) {
{
breload -= (frMacro_Mutations_AugmentLaserBrain_skill_gml_reloadBuff * scrFRGetSkill("AugmentLaserBrain"));
;
}
}
}
}
}
}
if ((scrFRIndexGet(ammo, 5) != fr_augmentLaserBrain_lastEnergy)) {
{
if ((scrFRIndexGet(ammo, 5) < fr_augmentLaserBrain_lastEnergy)) {
{
if ((scrFRSourceRandom(frMacro_Mutations_AugmentLaserBrain_skill_gml_refundChance) < 1)) {
{
fr_Mutations_AugmentLaserBrain_skill_gml_fusion_refund();
;
}
}
}
}
}
}
fr_augmentLaserBrain_lastEnergy = scrFRIndexGet(ammo, 5);
;
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:276
function fr_Mutations_AugmentLaserBrain_skill_gml_fusion_refund() {
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [5], fr_augmentLaserBrain_lastEnergy, "=");
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, LaserBrain)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentLaserBrain.skill.gml:282
function fr_Mutations_AugmentLaserBrain_skill_gml_wep_raw(_frl__wep=undefined) {
var _frl__rawWep = _frl__wep;
;
while (is_struct(_frl__rawWep)) {
_frl__rawWep = (scrFRVariableExists(_frl__rawWep, "wep") ? scrFRWeaponSlotRead(_frl__rawWep, "wep") : wep_none);
;
}
if ((is_string(_frl__rawWep) && scrFRScriptExists("weapon", _frl__rawWep, "weapon_raw"))) {
{
_frl__rawWep = scrFRModCall("weapon", _frl__rawWep, "weapon_raw", _frl__wep);
;
}
}
return _frl__rawWep;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:305
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite(_frl__baseModType=undefined, _frl__baseMod=undefined, _frl__baseVar=undefined, _frl__popospr=undefined) {
ds_list_add(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpriteStorage, [[_frl__baseModType, _frl__baseMod, _frl__baseVar, undefined, undefined], scrFRModGet(_frl__baseModType, _frl__baseMod, _frl__baseVar)]);
;
ds_list_add(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSprites, [[_frl__baseModType, _frl__baseMod, _frl__baseVar, undefined, undefined], _frl__popospr]);
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:309
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_addsprite_ext(_frl__baseModType=undefined, _frl__baseMod=undefined, _frl__spriteVar=undefined, _frl__sprite=undefined, _frl__spriteName=undefined, _frl__popospr=undefined) {
var _frl__sprSource = scrFRModGet(_frl__baseModType, _frl__baseMod, _frl__spriteVar);
;
{ var __fr_with1 = scrFRWithValues(_frl__sprSource), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
ds_list_add(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpriteStorage, [[_frl__baseModType, _frl__baseMod, _frl__spriteVar, _frl__sprite, _frl__spriteName], _frl__sprite]);
;
ds_list_add(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSprites, [[_frl__baseModType, _frl__baseMod, _frl__spriteVar, _frl__sprite, _frl__spriteName], _frl__popospr]);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentLaserBrain.skill.gml:317
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_resprite() {
if ((global.fr_module_vars[$ "skill:AugmentLaserBrain"].settingGreenAugments == false)) {
{
var _frl__spr = global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentBaseSprites;
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl__spr)); _frl_i++) {
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 1) != undefined)) {
{
scrFRSpriteReplacePath(scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 2), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 3), scrFRIndexGet(scrFRIndexGet(_frl__spr, _frl_i), 4));
;
}
}
}
}
var _frl__sprites = global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSprites;
;
{
var _frl_i = 0;
for (; (_frl_i < ds_list_size(_frl__sprites)); _frl_i++) {
var _frl__spr = ds_list_find_value(_frl__sprites, _frl_i);
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 3) != undefined)) {
{
if ((scrFRIndexGet(_frl__spr, 1) != undefined)) {
{
var _frl__sprSource = scrFRModGet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2));
;
scrFRLQSet(_frl__sprSource, scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 4), scrFRIndexGet(_frl__spr, 1));
}
}
}
} else {
{
if ((scrFRIndexGet(_frl__spr, 1) != undefined)) {
{
scrFRModSet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2), scrFRIndexGet(_frl__spr, 1));
;
}
}
}
}
}
}
if (scrFRModLoaded("mod", "WeaponsOverhaul")) {
{
scrFRWeaponSetSprite(wep_energy_hammer, global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyHammer);
;
scrFRWeaponSetSprite(wep_energy_screwdriver, global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergyScrewdriver);
;
scrFRWeaponSetSprite(wep_energy_sword, global.fr_module_vars[$ "skill:AugmentLaserBrain"].sprPopoEnergySword);
;
}
}
}
}
global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced = true;
;
}

// Original Mutations/AugmentLaserBrain.skill.gml:354
function fr_Mutations_AugmentLaserBrain_skill_gml_AugmentLaserBrain_restoresprite() {
{
var _frl_i = 0;
for (; (_frl_i < array_length(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentBaseSpritesRestore)); _frl_i++) {
scrFRSpriteRestore(scrFRIndexGet(global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentBaseSpritesRestore, _frl_i));
;
}
}
var _frl__storage = global.fr_module_vars[$ "skill:AugmentLaserBrain"].augmentSpriteStorage;
;
{
var _frl_i = 0;
for (; (_frl_i < ds_list_size(_frl__storage)); _frl_i++) {
var _frl__spr = ds_list_find_value(_frl__storage, _frl_i);
if ((scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 3) != undefined)) {
{
var _frl__sprSource = scrFRModGet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2));
;
scrFRLQSet(_frl__sprSource, scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 4), scrFRIndexGet(_frl__spr, 1));
}
} else {
{
scrFRModSet(scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 0), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 1), scrFRIndexGet(scrFRIndexGet(_frl__spr, 0), 2), scrFRIndexGet(_frl__spr, 1));
;
}
}
}
}
if (scrFRModLoaded("mod", "WeaponsOverhaul")) {
{
scrFRWeaponSetSprite(wep_energy_hammer, scrFRModGet("mod", "WeaponsOverhaul", "sprEnergyHammer"));
;
scrFRWeaponSetSprite(wep_energy_screwdriver, scrFRModGet("mod", "WeaponsOverhaul", "sprEnergyScrewdriver"));
;
scrFRWeaponSetSprite(wep_energy_sword, scrFRModGet("mod", "WeaponsOverhaul", "sprEnergySword"));
;
}
}
global.fr_module_vars[$ "skill:AugmentLaserBrain"].spritesReplaced = false;
;
}
