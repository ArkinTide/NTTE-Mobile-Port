// Original Skins/RobotBluescreened.skin.gml:1
function fr_Skins_RobotBluescreened_skin_gml___load() {

}

// Original Skins/RobotBluescreened.skin.gml:1
function fr_Skins_RobotBluescreened_skin_gml_init() {
global.fr_module_vars[$ "skin:RobotBluescreened"].sprIdle = sprFR_sprRobotBluescreenedIdle_a644726d369f;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprWalk = sprFR_sprRobotBluescreenedWalk_01a962562455;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprHurt = sprFR_sprRobotBluescreenedHurt_53e25a52cb01;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprDead = sprFR_sprRobotBluescreenedDead_5b940f1435ce;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprGoSit = sprFR_sprRobotBluescreenedGoSi_0d80fc89c0be;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprSit = sprFR_sprRobotBluescreenedSit_b3b1b4f15974;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprPortrait = sprFR_sprRobotBluescreenedPort_b032eafe42bb;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprLoadout = sprFR_sprRobotBluescreenedLoad_30e7f166ad21;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprMapIcon = sprFR_sprRobotBluescreenedMapI_31f8dc29168c;
;
global.fr_module_vars[$ "skin:RobotBluescreened"].sprBackupPortrait = sprFR_sprRobotPortraitBackup_4537db83e4ba;
;
}

// Original Skins/RobotBluescreened.skin.gml:15
function fr_Skins_RobotBluescreened_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_RobotBluescreened_skin_gml_skin_sprite(sprLoadoutSkin));
;
}

// Original Skins/RobotBluescreened.skin.gml:16
function fr_Skins_RobotBluescreened_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/RobotBluescreened.skin.gml:17
function fr_Skins_RobotBluescreened_skin_gml_skin_name() {
return "BLUESCREENED";
;
}

// Original Skins/RobotBluescreened.skin.gml:18
function fr_Skins_RobotBluescreened_skin_gml_skin_lock() {
return "N/A";
;
}

// Original Skins/RobotBluescreened.skin.gml:19
function fr_Skins_RobotBluescreened_skin_gml_skin_unlock() {
return "N/A";
;
}

// Original Skins/RobotBluescreened.skin.gml:20
function fr_Skins_RobotBluescreened_skin_gml_skin_ttip() {
return scrFRSourceChoose("SYSTEM CRITICAL");
;
}

// Original Skins/RobotBluescreened.skin.gml:21
function fr_Skins_RobotBluescreened_skin_gml_skin_portrait() {
return (scrFRInstanceExists(Player) ? fr_Skins_RobotBluescreened_skin_gml_skin_sprite(sprBigPortrait) : global.fr_module_vars[$ "skin:RobotBluescreened"].sprBackupPortrait);
;
}

// Original Skins/RobotBluescreened.skin.gml:22
function fr_Skins_RobotBluescreened_skin_gml_skin_mapicon() {
return fr_Skins_RobotBluescreened_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/RobotBluescreened.skin.gml:24
function fr_Skins_RobotBluescreened_skin_gml_skin_sprite(_frl__spr=undefined) {
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
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:RobotBluescreened"].sprMapIcon;
;
}
}
}

// Original Skins/RobotBluescreened.skin.gml:37
function fr_Skins_RobotBluescreened_skin_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "bskin", "RobotBluescreened")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve(0);
;
scrFRPlayerSetSkin(index, 0);
;
spr_idle = sprMutant8Idle;
;
spr_walk = sprMutant8Walk;
;
spr_hurt = sprMutant8Hurt;
;
spr_dead = sprMutant8Dead;
;
spr_gosit = sprMutant8GoSit;
;
spr_sit = sprMutant8Sit;
;
}
}
if(__fr_break3) break;
}}
}
