// Original Skins/RobotBluescreenedB.skin.gml:1
function fr_Skins_RobotBluescreenedB_skin_gml___load() {

}

// Original Skins/RobotBluescreenedB.skin.gml:1
function fr_Skins_RobotBluescreenedB_skin_gml_init() {
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprIdle = sprFR_sprRobotBluescreenedBIdl_b3c8fbaec704;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprWalk = sprFR_sprRobotBluescreenedBWal_fa8738a42e87;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprHurt = sprFR_sprRobotBluescreenedBHur_dc03d6a30a3c;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprDead = sprFR_sprRobotBluescreenedBDea_8b53bbdcd986;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprGoSit = sprFR_sprRobotBluescreenedBGoS_26d665edeccd;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprSit = sprFR_sprRobotBluescreenedBSit_ba582b61e1e9;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprPortrait = sprFR_sprRobotBluescreenedBPor_55636d43d6e9;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprLoadout = sprFR_sprRobotBluescreenedBLoa_65e528f2bd2b;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprMapIcon = sprFR_sprRobotBluescreenedBMap_6a041dbf9e8d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprBackupPortrait = sprFR_sprRobotBPortraitBackup_44b50a2f7a29;
;
}

// Original Skins/RobotBluescreenedB.skin.gml:15
function fr_Skins_RobotBluescreenedB_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_RobotBluescreenedB_skin_gml_skin_sprite(sprLoadoutSkin));
;
}

// Original Skins/RobotBluescreenedB.skin.gml:16
function fr_Skins_RobotBluescreenedB_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/RobotBluescreenedB.skin.gml:17
function fr_Skins_RobotBluescreenedB_skin_gml_skin_name() {
return "BLUESCREENED B SKIN";
;
}

// Original Skins/RobotBluescreenedB.skin.gml:18
function fr_Skins_RobotBluescreenedB_skin_gml_skin_lock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedB.skin.gml:19
function fr_Skins_RobotBluescreenedB_skin_gml_skin_unlock() {
return "N/A";
;
}

// Original Skins/RobotBluescreenedB.skin.gml:20
function fr_Skins_RobotBluescreenedB_skin_gml_skin_ttip() {
return scrFRSourceChoose("SYSTEM CRITICAL");
;
}

// Original Skins/RobotBluescreenedB.skin.gml:21
function fr_Skins_RobotBluescreenedB_skin_gml_skin_portrait() {
return (scrFRInstanceExists(Player) ? fr_Skins_RobotBluescreenedB_skin_gml_skin_sprite(sprBigPortrait) : global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprBackupPortrait);
;
}

// Original Skins/RobotBluescreenedB.skin.gml:22
function fr_Skins_RobotBluescreenedB_skin_gml_skin_mapicon() {
return fr_Skins_RobotBluescreenedB_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/RobotBluescreenedB.skin.gml:24
function fr_Skins_RobotBluescreenedB_skin_gml_skin_sprite(_frl__spr=undefined) {
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
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:RobotBluescreenedB"].sprMapIcon;
;
}
}
}

// Original Skins/RobotBluescreenedB.skin.gml:37
function fr_Skins_RobotBluescreenedB_skin_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "bskin", "RobotBluescreenedB")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve(1);
;
scrFRPlayerSetSkin(index, 1);
;
spr_idle = sprMutant8BIdle;
;
spr_walk = sprMutant8BWalk;
;
spr_hurt = sprMutant8BHurt;
;
spr_dead = sprMutant8BDead;
;
spr_gosit = sprMutant8BGoSit;
;
spr_sit = sprMutant8BSit;
;
}
}
if(__fr_break3) break;
}}
}
