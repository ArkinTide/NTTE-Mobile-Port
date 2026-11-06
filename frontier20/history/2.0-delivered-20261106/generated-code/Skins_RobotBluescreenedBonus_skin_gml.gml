#macro frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr scrFRModGet("mod", "teassets", "spr")

// Original Skins/RobotBluescreenedBonus.skin.gml:1
function fr_Skins_RobotBluescreenedBonus_skin_gml___load() {

}

// Original Skins/RobotBluescreenedBonus.skin.gml:1
function fr_Skins_RobotBluescreenedBonus_skin_gml_init() {
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprIdle = sprFR_sprRobotBluescreenedBonu_fc28aa916b61;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprWalk = sprFR_sprRobotBluescreenedBonu_3b568f671288;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprHurt = sprFR_sprRobotBluescreenedBonu_e1189066696e;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprDead = sprFR_sprRobotBluescreenedBonu_cec48d24039e;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprGoSit = sprFR_sprRobotBluescreenedBonu_72164e17873e;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprSit = sprFR_sprRobotBluescreenedBonu_d1a368e2ba1d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprPortrait = sprFR_sprRobotBluescreenedBonu_564499f0041f;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprLoadout = sprFR_sprRobotBluescreenedBonu_3725eddfd94c;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprMapIcon = sprFR_sprRobotBluescreenedBonu_33bb2ed99ffb;
;
global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprBackupPortrait = sprFR_sprRobotBonusPortraitBac_a53cd0ed403a;
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:15
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_RobotBluescreenedBonus_skin_gml_skin_sprite(sprLoadoutSkin));
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:16
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:17
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_name() {
return "BLUESCREENED BONUS";
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:18
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_lock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:19
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_unlock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:20
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_ttip() {
return scrFRSourceChoose("SYSTEM CRITICAL");
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:21
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_portrait() {
return (scrFRInstanceExists(Player) ? fr_Skins_RobotBluescreenedBonus_skin_gml_skin_sprite(sprBigPortrait) : global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprBackupPortrait);
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:22
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_mapicon() {
return fr_Skins_RobotBluescreenedBonus_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/RobotBluescreenedBonus.skin.gml:24
function fr_Skins_RobotBluescreenedBonus_skin_gml_skin_sprite(_frl__spr=undefined) {
{ var __fr_switch_value1=_frl__spr, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8Idle)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8Walk)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8Hurt)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8Dead)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8GoSit)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant8Sit)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprBigPortrait)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprLoadoutSkin)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMapIcon)) __fr_switch_case2=8;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:RobotBluescreenedBonus"].sprMapIcon;
;
}
}
}

// Original Skins/RobotBluescreenedBonus.skin.gml:37
function fr_Skins_RobotBluescreenedBonus_skin_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "bskin", "RobotBluescreenedBonus")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve("bonus robot");
;
scrFRPlayerSetSkin(index, "bonus robot");
;
spr_idle = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusIdle;
;
spr_walk = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusWalk;
;
spr_hurt = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusHurt;
;
spr_dead = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusDead;
;
spr_gosit = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusGoSit;
;
spr_sit = frMacro_Skins_RobotBluescreenedBonus_skin_gml__tespr.RobotBonusSit;
;
}
}
if(__fr_break3) break;
}}
; // macro hoisted: _tespr
;
}
