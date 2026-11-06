#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CIdleID 1320

#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CWalkID 1322

#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CHurtID 1319

#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CDeadID 1317

#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CGoSitID 1318

#macro frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CSitID 1321

// Original Skins/RobotBluescreenedC.skin.gml:1
function fr_Skins_RobotBluescreenedC_skin_gml___load() {

}

// Original Skins/RobotBluescreenedC.skin.gml:1
function fr_Skins_RobotBluescreenedC_skin_gml_init() {
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprIdle = sprFR_sprRobotBluescreenedCIdl_36188d8faff1;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprWalk = sprFR_sprRobotBluescreenedCWal_c3e0a05dfa4d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprHurt = sprFR_sprRobotBluescreenedCHur_2f2888812adc;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprDead = sprFR_sprRobotBluescreenedCDea_fb52bc120d20;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprGoSit = sprFR_sprRobotBluescreenedCGoS_80785c925ebe;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprSit = sprFR_sprRobotBluescreenedCSit_1662de356888;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprPortrait = sprFR_sprRobotBluescreenedCPor_a3d4607318d1;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprLoadout = sprFR_sprRobotBluescreenedCLoa_e8859f2b3c2d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprMapIcon = sprFR_sprRobotBluescreenedCMap_0dfae0618a3b;
;
global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprBackupPortrait = sprFR_sprRobotCPortraitBackup_c8fb67a38108;
;
}

// Original Skins/RobotBluescreenedC.skin.gml:15
function fr_Skins_RobotBluescreenedC_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_RobotBluescreenedC_skin_gml_skin_sprite(sprLoadoutSkin));
;
}

// Original Skins/RobotBluescreenedC.skin.gml:16
function fr_Skins_RobotBluescreenedC_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/RobotBluescreenedC.skin.gml:17
function fr_Skins_RobotBluescreenedC_skin_gml_skin_name() {
return "BLUESCREENED C SKIN";
;
}

// Original Skins/RobotBluescreenedC.skin.gml:18
function fr_Skins_RobotBluescreenedC_skin_gml_skin_lock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedC.skin.gml:19
function fr_Skins_RobotBluescreenedC_skin_gml_skin_unlock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedC.skin.gml:20
function fr_Skins_RobotBluescreenedC_skin_gml_skin_ttip() {
return scrFRSourceChoose("SYSTEM CRITICAL");
;
}

// Original Skins/RobotBluescreenedC.skin.gml:21
function fr_Skins_RobotBluescreenedC_skin_gml_skin_portrait() {
return (scrFRInstanceExists(Player) ? fr_Skins_RobotBluescreenedC_skin_gml_skin_sprite(sprBigPortrait) : global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprBackupPortrait);
;
}

// Original Skins/RobotBluescreenedC.skin.gml:22
function fr_Skins_RobotBluescreenedC_skin_gml_skin_mapicon() {
return fr_Skins_RobotBluescreenedC_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/RobotBluescreenedC.skin.gml:24
function fr_Skins_RobotBluescreenedC_skin_gml_skin_sprite(_frl__spr=undefined) {
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
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:RobotBluescreenedC"].sprMapIcon;
;
}
}
}

// Original Skins/RobotBluescreenedC.skin.gml:37
function fr_Skins_RobotBluescreenedC_skin_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "bskin", "RobotBluescreenedC")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve(2);
;
scrFRPlayerSetSkin(index, 2);
;
spr_idle = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CIdleID;
;
spr_walk = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CWalkID;
;
spr_hurt = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CHurtID;
;
spr_dead = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CDeadID;
;
spr_gosit = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CGoSitID;
;
spr_sit = frMacro_Skins_RobotBluescreenedC_skin_gml_sprMutant8CSitID;
;
}
}
if(__fr_break3) break;
}}
; // macro hoisted: sprMutant8CIdleID
; // macro hoisted: sprMutant8CWalkID
; // macro hoisted: sprMutant8CHurtID
; // macro hoisted: sprMutant8CDeadID
; // macro hoisted: sprMutant8CGoSitID
; // macro hoisted: sprMutant8CSitID
}
