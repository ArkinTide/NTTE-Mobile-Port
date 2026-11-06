// Original Skins/RobotBluescreenedTurret.skin.gml:1
function fr_Skins_RobotBluescreenedTurret_skin_gml___load() {

}

// Original Skins/RobotBluescreenedTurret.skin.gml:1
function fr_Skins_RobotBluescreenedTurret_skin_gml_init() {
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprIdle = sprFR_sprRobotBluescreenedTurr_400f1744574d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprWalk = sprFR_sprRobotBluescreenedTurr_6daa721cd819;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprHurt = sprFR_sprRobotBluescreenedTurr_c9c47390648c;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprDead = sprFR_sprRobotBluescreenedTurr_7d60fe367068;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprGoSit = sprFR_sprRobotBluescreenedGoSi_0d80fc89c0be;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprSit = sprFR_sprRobotBluescreenedSit_b3b1b4f15974;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprPortrait = sprFR_sprRobotBluescreenedTurr_8ef55966252a;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprLoadout = sprFR_sprRobotBluescreenedTurr_e997a479931b;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprMapIcon = sprFR_sprRobotBluescreenedTurr_0f8dd0f3690d;
;
global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprBackupPortrait = sprFR_sprRobotTurretPortraitBa_45639152041f;
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:15
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_RobotBluescreenedTurret_skin_gml_skin_sprite(sprLoadoutSkin));
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:16
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:17
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_name() {
return scrFRLocalize("BLUESCREENED TURRET");
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:18
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_lock() {
return scrFRLocalize("N/A");
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:19
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_unlock() {
return scrFRLocalize("N/A");
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:20
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_ttip() {
return scrFRLocalize(scrFRSourceChoose("SYSTEM CRITICAL"));
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:21
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_portrait() {
return (scrFRInstanceExists(Player) ? fr_Skins_RobotBluescreenedTurret_skin_gml_skin_sprite(sprBigPortrait) : global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprBackupPortrait);
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:22
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_mapicon() {
return fr_Skins_RobotBluescreenedTurret_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/RobotBluescreenedTurret.skin.gml:24
function fr_Skins_RobotBluescreenedTurret_skin_gml_skin_sprite(_frl__spr=undefined) {
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
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:RobotBluescreenedTurret"].sprMapIcon;
;
}
}
}

// Original Skins/RobotBluescreenedTurret.skin.gml:37
function fr_Skins_RobotBluescreenedTurret_skin_gml_game_start() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(Player, "bskin", "RobotBluescreenedTurret")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
bskin = scrFRSkinResolve("turret");
;
scrFRPlayerSetSkin(index, "turret");
;
spr_idle = scrFRModGet("skin", "turret", "spr_idle");
;
spr_walk = scrFRModGet("skin", "turret", "spr_walk");
;
spr_hurt = scrFRModGet("skin", "turret", "spr_hurt");
;
spr_dead = scrFRModGet("skin", "turret", "spr_dead");
;
spr_gosit = scrFRModGet("skin", "turret", "spr_hurt");
;
spr_sit = scrFRModGet("skin", "turret", "spr_hurt");
;
}
}
if(__fr_break3) break;
}}
}
