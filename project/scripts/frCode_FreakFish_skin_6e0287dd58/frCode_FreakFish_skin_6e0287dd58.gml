// Original Skins/FreakFish.skin.gml:1
function fr_Skins_FreakFish_skin_gml___load() {

}

// Original Skins/FreakFish.skin.gml:1
function fr_Skins_FreakFish_skin_gml_init() {
global.fr_module_vars[$ "skin:FreakFish"].sprIdle = sprFR_sprFishFreakIdle_35ee8f627bec;
;
global.fr_module_vars[$ "skin:FreakFish"].sprWalk = sprFR_sprFishFreakWalk_48b3b4bfd395;
;
global.fr_module_vars[$ "skin:FreakFish"].sprHurt = sprMutant1BHurt;
;
global.fr_module_vars[$ "skin:FreakFish"].sprDead = sprMutant1BDead;
;
global.fr_module_vars[$ "skin:FreakFish"].sprGoSit = sprMutant1BGoSit;
;
global.fr_module_vars[$ "skin:FreakFish"].sprSit = sprMutant1BSit;
;
global.fr_module_vars[$ "skin:FreakFish"].sprPortrait = mskNone;
;
global.fr_module_vars[$ "skin:FreakFish"].sprLoadout = sprFreak1Idle;
;
global.fr_module_vars[$ "skin:FreakFish"].sprMapIcon = sprFreak1Walk;
;
global.fr_module_vars[$ "skin:FreakFish"].sprLabsIcon = sprFR_sprLabsRouteIcon_654cbb1bced6;
;
}

// Original Skins/FreakFish.skin.gml:15
function fr_Skins_FreakFish_skin_gml_skin_button() {
sprite_index = scrFRAreaSourceSprite(fr_Skins_FreakFish_skin_gml_skin_sprite(sprLoadoutSkin));
;
image_index = (! fr_Skins_FreakFish_skin_gml_skin_avail());
;
}

// Original Skins/FreakFish.skin.gml:19
function fr_Skins_FreakFish_skin_gml_skin_race() {
return "/";
;
}

// Original Skins/FreakFish.skin.gml:20
function fr_Skins_FreakFish_skin_gml_skin_name() {
return scrFRLocalize((((argument_count <= 0) || (argument_count>0 ? argument[0] : undefined)) ? "FREAK" : fr_Skins_FreakFish_skin_gml_skin_lock()));
;
}

// Original Skins/FreakFish.skin.gml:21
function fr_Skins_FreakFish_skin_gml_skin_lock() {
return scrFRLocalize((("COMPLETE " + ("@1(" + string(real(global.fr_module_vars[$ "skin:FreakFish"].sprLabsIcon)) + ":0)")) + "3-1"));
;
}

// Original Skins/FreakFish.skin.gml:22
function fr_Skins_FreakFish_skin_gml_skin_unlock() {
return scrFRLocalize((("FOR COMPLETING " + ("@1(" + string(real(global.fr_module_vars[$ "skin:FreakFish"].sprLabsIcon)) + ":0)")) + "3-1"));
;
}

// Original Skins/FreakFish.skin.gml:23
function fr_Skins_FreakFish_skin_gml_skin_ttip() {
return scrFRLocalize(scrFRSourceChoose("SOMETHINGS WRONG"));
;
}

// Original Skins/FreakFish.skin.gml:24
function fr_Skins_FreakFish_skin_gml_skin_avail() {
return 1;
;
}

// Original Skins/FreakFish.skin.gml:25
function fr_Skins_FreakFish_skin_gml_skin_portrait() {
return fr_Skins_FreakFish_skin_gml_skin_sprite(sprBigPortrait);
;
}

// Original Skins/FreakFish.skin.gml:26
function fr_Skins_FreakFish_skin_gml_skin_mapicon() {
return fr_Skins_FreakFish_skin_gml_skin_sprite(sprMapIcon);
;
}

// Original Skins/FreakFish.skin.gml:28
function fr_Skins_FreakFish_skin_gml_skin_sprite(_frl__spr=undefined) {
{ var __fr_switch_value1=_frl__spr, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1Idle)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1Walk)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1Hurt)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1Dead)) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1GoSit)) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMutant1Sit)) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprBigPortrait)) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprLoadoutSkin)) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==(sprMapIcon)) __fr_switch_case2=8;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return global.fr_module_vars[$ "skin:FreakFish"].sprIdle;
;
case 1:
return global.fr_module_vars[$ "skin:FreakFish"].sprWalk;
;
case 2:
return global.fr_module_vars[$ "skin:FreakFish"].sprHurt;
;
case 3:
return global.fr_module_vars[$ "skin:FreakFish"].sprDead;
;
case 4:
return global.fr_module_vars[$ "skin:FreakFish"].sprGoSit;
;
case 5:
return global.fr_module_vars[$ "skin:FreakFish"].sprSit;
;
case 6:
return global.fr_module_vars[$ "skin:FreakFish"].sprPortrait;
;
case 7:
return global.fr_module_vars[$ "skin:FreakFish"].sprLoadout;
;
case 8:
return global.fr_module_vars[$ "skin:FreakFish"].sprMapIcon;
;
}
}
}
