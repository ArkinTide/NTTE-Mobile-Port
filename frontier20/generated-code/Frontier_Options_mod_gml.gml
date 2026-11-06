#macro frMacro_Frontier_Options_mod_gml_pirate_conversions 45

#macro frMacro_Frontier_Options_mod_gml_genstat_x frMacro_Frontier_Options_mod_gml_screen_center_x

#macro frMacro_Frontier_Options_mod_gml_genstat_y (frMacro_Frontier_Options_mod_gml_screen_center_y - 48)

#macro frMacro_Frontier_Options_mod_gml_charstat_x (frMacro_Frontier_Options_mod_gml_screen_center_x + 32)

#macro frMacro_Frontier_Options_mod_gml_charstat_y (frMacro_Frontier_Options_mod_gml_screen_center_y - 64)

#macro frMacro_Frontier_Options_mod_gml_covestat_y (frMacro_Frontier_Options_mod_gml_genstat_y + 58)

#macro frMacro_Frontier_Options_mod_gml_spec_x (frMacro_Frontier_Options_mod_gml_screen_center_x - 150)

#macro frMacro_Frontier_Options_mod_gml_spec_y (frMacro_Frontier_Options_mod_gml_screen_center_y - 60)

#macro frMacro_Frontier_Options_mod_gml_cred_x (frMacro_Frontier_Options_mod_gml_screen_center_x + 20)

#macro frMacro_Frontier_Options_mod_gml_cred_y (frMacro_Frontier_Options_mod_gml_screen_center_y - 64)

#macro frMacro_Frontier_Options_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Options"].scr

#macro frMacro_Frontier_Options_mod_gml_call scrFRScriptCall

#macro frMacro_Frontier_Options_mod_gml_mod_current_type global.fr_module_vars[$ "mod:Frontier_Options"].mod_current_type

#macro frMacro_Frontier_Options_mod_gml_CONFIG_FILE ("Frontier_Options" + " config.json")

#macro frMacro_Frontier_Options_mod_gml_screen_center_x (view_width / 2)

#macro frMacro_Frontier_Options_mod_gml_screen_center_y (view_height / 2)

#macro frMacro_Frontier_Options_mod_gml_screen_x (scrFRViewCoordinate(0) + (view_width / 2))

#macro frMacro_Frontier_Options_mod_gml_screen_y (scrFRViewCoordinate(1) + (view_height / 2))

#macro frMacro_Frontier_Options_mod_gml_statsPage global.fr_module_vars[$ "mod:Frontier_Options"].selectedStatsPage

#macro frMacro_Frontier_Options_mod_gml_charPage global.fr_module_vars[$ "mod:Frontier_Options"].selectedCharacterPage

// Original Frontier_Options.mod.gml:1
function fr_Frontier_Options_mod_gml___load() {

}

// Original Frontier_Options.mod.gml:1
function fr_Frontier_Options_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Options_mod_gml_init_resume, id, scrFROther(other), _args, 10, []);
}
function fr_Frontier_Options_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Options_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Options.mod.gml:657
{
fr_Frontier_Options_mod_gml_CustomOptions_load();
;
}
_fr.pc=0;
break;
case 2: // Frontier_Options.mod.gml:654
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Options.mod.gml:654
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Options.mod.gml:85
{
if (scrFRScriptExists("mod", "custom_options", "scr_import")) {
{
scrFRModCall("mod", "custom_options", "scr_import", ["mod", "Frontier_Options", 0], "scr");
;
}
}
global.fr_module_vars[$ "mod:Frontier_Options"].loaded = true;
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "visuals", {"options": [{"option": "settingVanillaGlow", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":1)") + " VANILLAGLOW")}, "desc": {"text": "@wSOME BASEGAME OBJECTS AND EFFECTS\r\n    \t\t\t\t\t\t\t\t#@yGLOW IN THE DARK\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingEventDropdowns", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":2)") + " EVENT DROPDOWNS")}, "desc": {"text": "@(color:6983599)EVENTS @wHAVE DROPDOWN CARDS\r\n    \t\t\t\t\t\t\t\t#WHEN STARTING THE LEVEL\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingLightningFlash", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":3)") + " LIGHTNING FLASH")}, "desc": {"text": "@(color:6983599)LIGHTNING STRIKES @wCAUSE THE SCREEN\r\n    \t\t\t\t\t\t\t\t#TO FLASH WHEN STRIKING@s\r\n    \t\t\t\t\t\t\t\t#(@(color:6382049)DISABLE IF PHOTOSENSITIVE@s)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingMaxAuroras", "kind": "range", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":4)") + " MAX AURORAS")}, "desc": {"text": "@wHOW MANY EXTRA @(color:6983599)AURORAS@w#CAN RENDER AT THE SAME TIME\r\n    \t\t\t\t\t\t\t\t#@s(@(color:6382049)LOWER IF AURORAS ARE LAGGING@s)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @w3"}, "range": {"minimum": 0, "maximum": 5}}, {"option": "settingGreenAugments", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":6)") + " GREEN AUGMENT EFFECTS")}, "desc": {"text": "@(color:16776960)AUGMENT @wEFFECTS ARE @(color:65280)GREEN\r\n    \t\t\t\t\t\t\t\t#@s(AVOIDS CONFUSION WITH IDPD ENEMIES)\r\n    \t\t\t\t\t\t\t\t#@(color:6381921)(IT DOESNT LOOK AS GOOD THOUGH)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingAugmentProjectiles", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":7)") + " AUGMENTED PROJECTILES")}, "desc": {"text": "@wSOME @(color:16776960)AUGMENTS @wRESPRITE PROJECTILES\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingPelagicBubbles", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":17)") + " PELAGIC WATER BUBBLES")}, "desc": {"text": "@wWATER-BREATHING ENEMIES SPAWNED \r\n    \t\t\t\t\t\t\t\t#BY @(color:13160785)PELAGIC PREDICAMENT @wHAVE BUBBLES\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingLowQualityParrots", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":20)") + " LOWER QUALITY PARROTS")}, "desc": {"text": "@wREDUCES VISUAL QUALITY OF PARROTS\r\n    \t\t\t\t\t\t\t\t#@s(@(color:6382049)ENABLE IF PARROTS ARE LAGGING@s)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingLowQualitySerpent", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":21)") + " LOWER QUALITY SERPENT")}, "desc": {"text": "@wREDUCES VISUAL QUALITY OF \r\n    \t\t\t\t\t\t\t\t#PALACE SERPENT\r\n    \t\t\t\t\t\t\t\t#@s(@(color:6382049)ENABLE IF SERPENT IS LAGGING@s)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingDarkCoreExplosion", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":22)") + " DARK CORE EXPLOSION")}, "desc": {"text": "@wCHANGES COLOR OF\r\n    \t\t\t\t\t\t\t\t#@(color:8220209)CORE EXPLOSION EFFECT @wTO BLACK\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "gameplay", {"options": [{"option": "settingBigStrikeChests", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":11)") + " BIG STRIKE CANISTERS")}, "desc": {"text": "@wTOGGLES @bLARGE STRIKE CANISTERS\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingNewIDPD", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":9)") + " NEW I.D.P.D.")}, "desc": {"text": "@wTOGGLES NEW @bI.D.P.D. @wUNITS\r\n    \t\t\t\t\t\t\t\t#@w(ALSO TOGGLES @bSTRIKERS@w)\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@sTO USE ALONGSIDE @(color:16776960)POPO @sMOD SEE\r\n    \t\t\t\t\t\t\t\t#@sWIGGLERCOLA.ITCH.IO/CUSTOM-IDPD-HANDLER\r\n    \t\t\t\t\t\t\t\t#@sFOR INSTRUCTIONS\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingTradeFishMode", "kind": "choice", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":25)") + " TRADEFISH MODE")}, "desc": {"text": "@(color:3516363)TRADEABLE @wWEAPON DROPS#GET @(color:9959231)GHOSTLY INDICATORS\r\n\t\t\t\t\t\t\t\t\t#@s(APPLIES ON LEVEL START)\r\n\t\t\t\t\t\t\t\t\t#\r\n\t\t\t\t\t\t\t\t\t#@(color:3516363)NEW@s: @wNEVER BEFORE TRADED WEPS ONLY\r\n\t\t\t\t\t\t\t\t\t#@(color:3516363)ALL@s: @wALL TRADEABLE WEAPONS\r\n\t\t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}, "values": ["OFF", "NEW", "ALL"], "display": ["OFF", "NEW", "ALL"]}, {"option": "settingThroneTeleporters", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":12)") + " THRONE ROOM TELEPORTER")}, "desc": {"text": "@wTOGGLES @gTHRONE ROOM TELEPORTER\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingLabsRouteAltMode", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":13)") + " LABS ROUTE ALT MODE")}, "desc": {"text": "@wTOGGLES LABS ROUTE AREAS APPEARING\r\n    \t\t\t\t\t\t\t\t#AS ALT AREAS INSTEAD OF A NEW ROUTE\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@(color:9667202)GRAVEYARD HAS A 50% CHANCE\r\n    \t\t\t\t\t\t\t\t#TO REPLACE FROZEN CITY\r\n    \t\t\t\t\t\t\t\t#@(color:9856357)ROBOTICS CENTER HAS A 50% CHANCE\r\n    \t\t\t\t\t\t\t\t#TO REPLACE NORMAL LABS\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@s(LABS ROUTE ENTRANCE DISABLED)\r\n    \t\t\t\t\t\t\t\t#@(color:6381921)(ADDS A DEEPLABS ENTRANCE TO 6-1)\r\n    \t\t\t\t\t\t\t\t#@s(OVERRIDDEN BY BLAAC'S HARDMODE@s)\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingAltCoveEntrance", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":23)") + " ALT COVE ENTRANCE")}, "desc": {"text": "@wCHANGES @(color:6721553)COVE'S @wENTRANCE TO APPEAR\r\n    \t\t\t\t\t\t\t\t#IN @sSCRAPYARD @w(3-3)\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@sACTS AS A CRYSTAL CAVES ALTERNATIVE\r\n    \t\t\t\t\t\t\t\t#INSTEAD OF AS AN ADDITIONAL LEVEL\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingCrushTrapSpawnrate", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":35)") + " CRUSHTRAP SPAWNRATE")}, "desc": {"text": "@wCHANGES SPAWNRATE MULTIPLIER#FOR CRUSH TRAPS IN PALACE#@sDEFAULT: @w100%"}, "range": {"minimum": 0, "maximum": 2}, "steps": 0.01, "format": {"dec": 0}}]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "gameplay2", {"options": [{"option": "settingMainPoolPirateWeps", "kind": "choice", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":14)") + " MAIN POOL PIRATE WEPS")}, "desc": {"text": "@wTOGGLES @(color:3516363)PIRATE VARIANT WEAPONS\r\n    \t\t\t\t\t\t\t\t#@wAPPEARING IN THE NORMAL WEAPON POOL\r\n    \t\t\t\t\t\t\t\t#\r\n\t\t\t\t\t\t\t\t\t#@(color:3516363)FOUND@s: @wONLY PREVIOUSLY TRADED WEPS DROP\r\n\t\t\t\t\t\t\t\t\t#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES\r\n\t\t\t\t\t\t\t\t\t#POTENTIALLY UNBALANCED IN NORMAL PLAY\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}, "values": [0, 1, "FOUND"], "display": ["OFF", "ON", "FOUND"]}, {"option": "settingMainPoolLabsWeps", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":15)") + " MAIN POOL CACHE WEPS")}, "desc": {"text": "@wTOGGLES @(color:8220209)CACHE-EXCLUSIVE WEAPONS\r\n    \t\t\t\t\t\t\t\t#@wAPPEARING IN THE NORMAL WEAPON POOL\r\n    \t\t\t\t\t\t\t\t#\r\n\t\t\t\t\t\t\t\t\t#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES\r\n\t\t\t\t\t\t\t\t\t#POTENTIALLY UNBALANCED IN NORMAL PLAY\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingMainPoolAugments", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":16)") + " MAIN POOL AUGMENTS")}, "desc": {"text": "@wTOGGLES @(color:16776960)AUGMENTS @wAPPEARING\r\n    \t\t\t\t\t\t\t\t#IN THE NORMAL MUTATION POOL\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@(color:6382049)SETTING INTENDED FOR ALT GAMEMODES\r\n    \t\t\t\t\t\t\t\t#POTENTIALLY UNBALANCED IN NORMAL PLAY\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingCyberspaceEnabled", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":19)") + " ROBOT ADDITIONS")}, "desc": {"text": "@wTOGGLES ROBOT'S @bNEW EXTRA PASSIVE\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wON"}}, {"option": "settingSurgeriesBeta", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":18)") + " SURGERIES (BETA)")}, "desc": {"text": "@wTOGGLES @(color:2964223)SURGERIES @wAPPEARING\r\n    \t\t\t\t\t\t\t\t#INSIDE OF @gVAULTS\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@sSURGERIES ARE RANDOMLY GENERATED\r\n    \t\t\t\t\t\t\t\t#STAT-SWAPPING MUTATIONS\r\n    \t\t\t\t\t\t\t\t#(RANDOMIZED ON VAULT VISIT)\r\n    \t\t\t\t\t\t\t\t#@(color:6381921)(NOT PLANNED TO STAY IN VAULTS)\r\n    \t\t\t\t\t\t\t\t#(MAY NOT EVER GET IMPLEMENTED FULLY)\r\n    \t\t\t\t\t\t\t\t#\r\n    \t\t\t\t\t\t\t\t#@(color:6382049)THIS FEATURE IS SOMEWHAT INCOMPLETE\r\n    \t\t\t\t\t\t\t\t#AND PROBABLY UNBALANCED,\r\n    \t\t\t\t\t\t\t\t#USE AT YOUR OWN RISK!\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "events", {"options": [{"option": "settingNightLoops", "kind": "bool", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":26)") + " NIGHT LOOPS")}, "desc": {"text": "@wCHANGES @(color:11500138)NIGHT EVENTS @wTO APPEAR BASED\r\n    \t\t\t\t\t\t\t\t#ON LOOP INSTEAD OF PER-AREA\r\n    \t\t\t\t\t\t\t\t#@sDEFAULT: @wOFF"}}, {"option": "settingNightEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":24)") + " NIGHT EVENTS")}, "desc": {"text": "@wBASE CHANCE FOR NIGHT EVENTS TO OCCUR#@s(ALSO AFFECTS NIGHT LOOPS)#@sDEFAULT: @w20%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingPaintorCampEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":27)") + " PAINTOR CAMP")}, "desc": {"text": "@wBASE CHANCE FOR PAINTOR CAMP TO SPAWN#@sDEFAULT: @w3%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingThunderstormEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":28)") + " THUNDERSTORM")}, "desc": {"text": "@wBASE CHANCE FOR THUNDERSTORM TO OCCUR#@sDEFAULT: @w10%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingCurseSpreadEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":29)") + " CURSE SPREAD")}, "desc": {"text": "@wBASE CHANCE FOR SPREADING CURSE TO OCCUR#@sDEFAULT: @w8%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingBlizzardEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":30)") + " BLIZZARD")}, "desc": {"text": "@wBASE CHANCE FOR BLIZZARD TO OCCUR#@sDEFAULT: @w10%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingHauntedCityEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":31)") + " HAUNTED CITY")}, "desc": {"text": "@wBASE CHANCE FOR HAUNTED CITY TO OCCUR#@sDEFAULT: @w6%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingBlackoutEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":32)") + " BLACKOUT")}, "desc": {"text": "@wBASE CHANCE FOR BLACKOUT TO OCCUR#@sDEFAULT: @w20%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingSerpentLairEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":33)") + " SERPENT LAIR")}, "desc": {"text": "@wBASE CHANCE FOR SERPENT LAIR TO OCCUR#@sDEFAULT: @w13%"}, "steps": 0.01, "format": {"dec": 0}}, {"option": "settingPortalStormEventSpawnChance", "kind": "slider", "suffix": "%", "name": {"text": (("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons)) + ":34)") + " PORTAL STORM")}, "desc": {"text": "@wBASE CHANCE FOR PORTAL STORM TO OCCUR#@sDEFAULT: @w2%"}, "steps": 0.01, "format": {"dec": 0}}]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "stats", {"reference": ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_page_stats_draw]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_add_page, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "options", "credits", {"reference": ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_page_credits_draw]});
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_mod_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "FRONTIER");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "visuals", "VISUALS");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "gameplay", "GAMEPLAY");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "gameplay2", "GAMEPLAY");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "events", "EVENTS");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "stats", "STATS");
;
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_set_page_display_name, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options", "credits", "CREDITS");
;
}
_fr.pc=3;
break;
case 6: // Frontier_Options.mod.gml:81
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Options.mod.gml:81
_fr.wait_ticks=max(0,0); _fr.pc=6; return;
break;
case 5: // Frontier_Options.mod.gml:80
_fr.pc=((! scrFRScriptExists("mod", "custom_options", "scr_import")))?7:4;
break;
case 8: // Frontier_Options.mod.gml:78
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // Frontier_Options.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Options", "scr");
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprSettingsIcons = sprFR_sprSettingsIcons_7f98f913280d;
;
global.fr_module_vars[$ "mod:Frontier_Options"].mskStatsPageButton = sprFR_mskStatsPageButton_6838a31bcde0;
;
global.fr_module_vars[$ "mod:Frontier_Options"].mskStatsCharacterButton = sprFR_mskStatsCharacterButton_40b27d9fe33a;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsPortraits = sprFR_sprStatsPortraits_281f8b4b5858;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsCharacters = sprFR_sprStatsCharacters_f4e3f9ebc414;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsCharSplat = sprFR_sprStatsCharSplat_870afe557ec2;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsPageSelectorSplat = sprFR_sprStatsPageSelector_47adbb706981;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprCoveIcon = sprFR_sprCoveIcon_d8c4c6e747c1;
;
global.fr_module_vars[$ "mod:Frontier_Options"].sprCreditsSplattie = sprFR_sprCreditsSplattie_6446f185a534;
;
global.fr_module_vars[$ "mod:Frontier_Options"].selectedStatsPage = "general";
;
global.fr_module_vars[$ "mod:Frontier_Options"].selectedCharacterPage = undefined;
;
global.fr_module_vars[$ "mod:Frontier_Options"].statsCharacterPageCheck = false;
;
global.fr_module_vars[$ "mod:Frontier_Options"].statsPageController = noone;
;
global.fr_module_vars[$ "mod:Frontier_Options"].statsCharPageController = noone;
;
if (scrFRModLoaded("mod", "libSaves")) {
{
if ((frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "unlock_bubbles") > 0)) {
{
global.fr_module_vars[$ "mod:Frontier_Options"].selectedCharacterPage = "bubbles";
}
}
}
}
; // macro hoisted: pirate_conversions
frMacro_Frontier_Options_mod_gml_mod_current_type = scrFRIndexGet(["mod", "Frontier_Options", 0], 0);
;
global.fr_module_vars[$ "mod:Frontier_Options"].options = {"settingVanillaGlow": true, "settingEventDropdowns": true, "settingLightningFlash": true, "settingMaxAuroras": 3, "settingGreenAugments": false, "settingAugmentProjectiles": true, "settingVisualDecryptors": true, "settingVeeOneHundred": false, "settingNewIDPD": true, "settingEventText": false, "settingBigStrikeChests": true, "settingThroneTeleporters": true, "settingMainPoolPirateWeps": false, "settingMainPoolAugments": false, "settingLabsRouteAltMode": false, "settingMainPoolLabsWeps": false, "settingPelagicBubbles": true, "settingSurgeriesBeta": false, "settingCyberspaceEnabled": true, "settingLowQualityParrots": false, "settingLowQualitySerpent": false, "settingDarkCoreExplosion": false, "settingAltCoveEntrance": false, "settingNightLoops": false, "settingTradeFishMode": "OFF", "settingNightEventSpawnChance": 0.2, "settingPaintorCampEventSpawnChance": 0.03, "settingThunderstormEventSpawnChance": 0.1, "settingCurseSpreadEventSpawnChance": 0.08, "settingBlizzardEventSpawnChance": 0.1, "settingHauntedCityEventSpawnChance": 0.06, "settingBlackoutEventSpawnChance": 0.2, "settingSerpentLairEventSpawnChance": 0.13, "settingPortalStormEventSpawnChance": 0.02, "settingCrushTrapSpawnrate": 1};
;
global.fr_module_vars[$ "mod:Frontier_Options"].loaded = false;
;
}
_fr.pc=8;
break;
case 11: // Frontier_Options.mod.gml:4
{
;
}
_fr.pc=10;
break;
case 12: // Frontier_Options.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=11; return;
break;
case 10: // Frontier_Options.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?12:9;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Options.mod.gml:659
function fr_Frontier_Options_mod_gml_ExternalOptions_load() {
var _frl__options = global.fr_module_vars[$ "mod:Frontier_Options"].options;
;
scrFRModSet("mod", "Frontier_Main", "settingNewIDPD", _frl__options.settingNewIDPD);
;
scrFRModSet("mod", "Frontier_Main", "settingBigStrikeChests", _frl__options.settingBigStrikeChests);
;
scrFRModSet("mod", "Frontier_Main", "settingVanillaGlow", _frl__options.settingVanillaGlow);
;
scrFRModSet("mod", "Frontier_Main", "settingVisualDecryptors", _frl__options.settingVisualDecryptors);
;
scrFRModSet("mod", "Frontier_Main", "settingThroneTeleporters", _frl__options.settingThroneTeleporters);
;
scrFRModSet("mod", "Frontier_Main", "settingLabsRouteAltMode", _frl__options.settingLabsRouteAltMode);
;
scrFRModSet("mod", "Frontier_Main", "settingSurgeriesBeta", _frl__options.settingSurgeriesBeta);
;
scrFRModSet("mod", "Frontier_Main", "settingAltCoveEntrance", _frl__options.settingAltCoveEntrance);
;
scrFRModSet("mod", "Frontier_Main", "settingCyberspaceEnabled", _frl__options.settingCyberspaceEnabled);
;
scrFRModSet("mod", "Frontier_Main", "settingTradeFishMode", _frl__options.settingTradeFishMode);
;
scrFRModSet("mod", "Frontier_Main", "settingCrushTrapSpawnrate", _frl__options.settingCrushTrapSpawnrate);
;
scrFRModSet("mod", "Frontier_Events", "settingEventText", _frl__options.settingEventText);
;
scrFRModSet("mod", "Frontier_Events", "settingEventDropdowns", _frl__options.settingEventDropdowns);
;
scrFRModSet("mod", "Frontier_Events", "settingLightningFlash", _frl__options.settingLightningFlash);
;
scrFRModSet("mod", "Frontier_Events", "settingMaxAuroras", _frl__options.settingMaxAuroras);
;
scrFRModSet("mod", "Frontier_Events", "settingNightLoops", _frl__options.settingNightLoops);
;
scrFRModSet("mod", "Frontier_StatusEffects", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("area", "graveyard", "settingLabsRouteAltMode", _frl__options.settingLabsRouteAltMode);
;
scrFRModSet("area", "robocenter", "settingLabsRouteAltMode", _frl__options.settingLabsRouteAltMode);
;
scrFRModSet("area", "deeplabs", "settingLabsRouteAltMode", _frl__options.settingLabsRouteAltMode);
;
scrFRModSet("area", "cyberspace", "settingCyberspaceEnabled", _frl__options.settingCyberspaceEnabled);
;
scrFRModSet("area", "deeplabs", "settingDarkCoreExplosion", _frl__options.settingDarkCoreExplosion);
;
scrFRModSet("area", "cove", "settingAltCoveEntrance", _frl__options.settingAltCoveEntrance);
;
scrFRModSet("mod", "Frontier_Projectiles2", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("mod", "Frontier_Projectiles", "settingNaturalPirateWeps", _frl__options.settingMainPoolPirateWeps);
;
scrFRModSet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps", _frl__options.settingMainPoolLabsWeps);
;
scrFRModSet("mod", "Frontier_IDPD", "settingNewIDPD", _frl__options.settingNewIDPD);
;
scrFRModSet("mod", "Frontier_IDPD", "settingMainPoolAugments", _frl__options.settingMainPoolAugments);
;
scrFRModSet("mod", "Frontier_Pickups", "settingVisualDecryptors", _frl__options.settingVisualDecryptors);
;
scrFRModSet("mod", "Frontier_Caves", "settingLowQualityParrots", _frl__options.settingLowQualityParrots);
;
scrFRModSet("mod", "Frontier_Caves", "settingTradeFishMode", _frl__options.settingTradeFishMode);
;
scrFRModSet("mod", "Frontier_Palace", "settingLowQualitySerpent", _frl__options.settingLowQualitySerpent);
;
scrFRModSet("skill", "AugmentBloodlust", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModCall("skill", "AugmentBoilingVeins", "load_options", _frl__options);
scrFRModSet("skill", "AugmentEuphoria", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentExtraFeet", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentImpactWrists", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModCall("skill", "AugmentLaserBrain", "load_options", _frl__options);
scrFRModSet("skill", "AugmentLastWish", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentLuckyShot", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentOpenMind", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentRabbitPaw", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "AugmentSharpTeeth", "settingGreenAugments", _frl__options.settingGreenAugments);
;
scrFRModSet("skill", "BurdenPelagicPredicament", "settingPelagicBubbles", _frl__options.settingPelagicBubbles);
;
scrFRModSet("mod", "Frontier_Main", "settingNightEventSpawnChance", _frl__options.settingNightEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingNightEventSpawnChance", _frl__options.settingNightEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingPaintorCampEventSpawnChance", _frl__options.settingPaintorCampEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingThunderstormEventSpawnChance", _frl__options.settingThunderstormEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingCurseSpreadEventSpawnChance", _frl__options.settingCurseSpreadEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingBlizzardEventSpawnChance", _frl__options.settingBlizzardEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingHauntedCityEventSpawnChance", _frl__options.settingHauntedCityEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingBlackoutEventSpawnChance", _frl__options.settingBlackoutEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingSerpentLairEventSpawnChance", _frl__options.settingSerpentLairEventSpawnChance);
;
scrFRModSet("mod", "Frontier_Events", "settingPortalStormEventSpawnChance", _frl__options.settingPortalStormEventSpawnChance);
;
}

// Original Frontier_Options.mod.gml:731
function fr_Frontier_Options_mod_gml_page_stats_draw() {
if ((! scrFRInstanceExists(global.fr_module_vars[$ "mod:Frontier_Options"].statsPageController))) {
{
global.fr_module_vars[$ "mod:Frontier_Options"].statsPageController = fr_Frontier_Options_mod_gml_statsPageController_create(frMacro_Frontier_Options_mod_gml_screen_center_x, frMacro_Frontier_Options_mod_gml_screen_center_y);
}
}
{ var __fr_with1 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_Options"].statsPageController), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
keepMeAlive = 2;
;
}
}
if(__fr_break3) break;
}}
if (scrFRInstanceExists(CampChar)) {
{
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsPageSelectorSplat, 0, (frMacro_Frontier_Options_mod_gml_screen_center_x + 130), (frMacro_Frontier_Options_mod_gml_screen_center_y + 65));
}
}
; // macro hoisted: genstat_x
; // macro hoisted: genstat_y
; // macro hoisted: charstat_x
; // macro hoisted: charstat_y
; // macro hoisted: covestat_y
{ var __fr_switch_value4=frMacro_Frontier_Options_mod_gml_statsPage, __fr_switch_case5=-1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("general")) __fr_switch_case5=0;
if(__fr_switch_case5==-1 && __fr_switch_value4==("characters")) __fr_switch_case5=1;
if(__fr_switch_case5==-1 && __fr_switch_value4==("unlocks")) __fr_switch_case5=2;
if(__fr_switch_case5==-1) __fr_switch_case5=-1;
switch(__fr_switch_case5) {
case 0:
{
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
draw_set_valign(0);
;
draw_set_halign(fa_center);
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_genstat_x, (frMacro_Frontier_Options_mod_gml_genstat_y - 10), "@wGENERAL");
;
draw_set_halign(fa_right);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_genstat_x + 32), frMacro_Frontier_Options_mod_gml_genstat_y, "@sMEALS EATEN\r\n\t\t\t\t\t#AUGMENTS TAKEN\r\n\t\t\t\t\t#PROTO CACHES OPENED\r\n\t\t\t\t\t#CORE DETONATIONS\r\n\t\t\t\t\t#HOARDER K/E RATIO\r\n\t\t\t\t\t#CYBERSPACE VISITS\r\n\t\t\t\t\t");
;
draw_set_halign(fa_left);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_genstat_x + 36), frMacro_Frontier_Options_mod_gml_genstat_y, ((((((((((((("@w" + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "meals_eaten"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "augments_taken"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "caches_opened"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "deeplabs_finales"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "hoarder_kills"))) + "@s:@w") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "hoarder_escapes"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "cyberspace_visits"))));
;
draw_set_halign(fa_center);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_genstat_x - 4), frMacro_Frontier_Options_mod_gml_covestat_y, "@wWEAPONS TRADED");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_genstat_x, (frMacro_Frontier_Options_mod_gml_covestat_y + 14), ("@1(" + string(real(global.fr_module_vars[$ "mod:Frontier_Options"].sprCoveIcon)) + ":0)"));
draw_set_halign(fa_right);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_genstat_x - 6), (frMacro_Frontier_Options_mod_gml_covestat_y + 10), "@sTOTAL\r\n\t\t\t\t\t#UNIQUE#");
;
draw_set_halign(fa_left);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_genstat_x + 6), (frMacro_Frontier_Options_mod_gml_covestat_y + 10), ((((("@w" + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "pirate_trades"))) + "#") + string(array_length(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "pirate_conversions")))) + "@s/@w") + string(frMacro_Frontier_Options_mod_gml_pirate_conversions)));
;
draw_set_halign(_frl__halign);
draw_set_valign(_frl__valign);
break;
;
}
case 1:
{
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
draw_set_valign(0);
;
{ var __fr_switch_value6=frMacro_Frontier_Options_mod_gml_charPage, __fr_switch_case7=-1;
if(__fr_switch_case7==-1 && __fr_switch_value6==("bubbles")) __fr_switch_case7=0;
if(__fr_switch_case7==-1) __fr_switch_case7=-1;
switch(__fr_switch_case7) {
case 0:
{
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsPortraits, 0, (frMacro_Frontier_Options_mod_gml_screen_center_x - 100), (frMacro_Frontier_Options_mod_gml_screen_center_y - 20));
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsCharSplat, 0, (frMacro_Frontier_Options_mod_gml_screen_center_x - 100), (frMacro_Frontier_Options_mod_gml_screen_center_y + 56));
draw_set_font(fntBig);
;
draw_set_halign(fa_left);
;
draw_set_valign(fa_top);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_screen_center_x - 156), (frMacro_Frontier_Options_mod_gml_screen_center_y + 48), "@(color:0)BUBBLES");
scrFRDrawText((frMacro_Frontier_Options_mod_gml_screen_center_x - 156), (frMacro_Frontier_Options_mod_gml_screen_center_y + 47), "BUBBLES");
draw_set_font(fntM1);
draw_set_halign(fa_right);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_charstat_x + 32), frMacro_Frontier_Options_mod_gml_charstat_y, "@sKILLS\r\n\t\t\t\t\t\t#LOOPS\r\n\t\t\t\t\t\t#RUNS\r\n\t\t\t\t\t\t#DEATHS\r\n\t\t\t\t\t\t#WINS\r\n\t\t\t\t\t\t#TIME\r\n\t\t\t\t\t\t#BUBBLES\r\n\t\t\t\t\t\t");
;
draw_set_halign(fa_left);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_charstat_x + 36), frMacro_Frontier_Options_mod_gml_charstat_y, ((((((((((((((((("@w" + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_kills"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_loops"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_runs"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_deaths"))) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_wins"))) + "#") + scrFRStringLPad(string(floor((frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_time") / power(60, 2)))), "0", 1)) + ":") + scrFRStringLPad(string(floor(((frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_time") / power(60, 1)) % 60))), "0", 2)) + ":") + scrFRStringLPad(string(floor(((frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_time") / power(60, 0)) % 60))), "0", 2)) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_bubbles"))));
;
var _frl__bestArea = "N/A";
if (is_string(scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 0))) {
{
_frl__bestArea = ((! scrFRModLoaded("area", scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 0))) ? "@rAREA NOT LOADED" : string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.area_get_name, scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 0), scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 1), scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 2))));
}
} else {
{
_frl__bestArea = ((((string(scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 0)) + "-") + string(scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 1))) + " L") + string(scrFRIndexGet(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_area"), 2)));
}
}
draw_set_halign(fa_center);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_charstat_x + 30), (frMacro_Frontier_Options_mod_gml_charstat_y + 64), "@wBEST RUN");
;
draw_set_halign(fa_right);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_charstat_x + 32), (frMacro_Frontier_Options_mod_gml_charstat_y + 74), "@sAREA\r\n\t\t\t\t\t\t#KILLS");
;
draw_set_halign(fa_left);
;
scrFRDrawText((frMacro_Frontier_Options_mod_gml_charstat_x + 36), (frMacro_Frontier_Options_mod_gml_charstat_y + 74), ((("@w" + _frl__bestArea) + "#") + string(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "bubbles_best_kills"))));
;
draw_set_halign(_frl__halign);
draw_set_valign(_frl__valign);
break;
;
}
}
}
if ((! scrFRInstanceExists(global.fr_module_vars[$ "mod:Frontier_Options"].statsCharPageController))) {
{
global.fr_module_vars[$ "mod:Frontier_Options"].statsCharPageController = fr_Frontier_Options_mod_gml_statsCharacterPageController_create(frMacro_Frontier_Options_mod_gml_screen_x, frMacro_Frontier_Options_mod_gml_screen_y);
}
}
{ var __fr_with8 = scrFRWithValues(global.fr_module_vars[$ "mod:Frontier_Options"].statsCharPageController), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
keepMeAlive = 2;
;
}
}
if(__fr_break10) break;
}}
scrFRDrawSpriteExt(global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsCharSplat, 0, (frMacro_Frontier_Options_mod_gml_screen_center_x - 110), (frMacro_Frontier_Options_mod_gml_screen_center_y - 54), 1, 1, 180, c_white, 1);
scrFRDrawSprite(global.fr_module_vars[$ "mod:Frontier_Options"].sprStatsCharacters, (frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "unlock_bubbles") ? 1 : 0), (frMacro_Frontier_Options_mod_gml_screen_center_x - 112), (frMacro_Frontier_Options_mod_gml_screen_center_y - 76));
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
break;
;
}
case 2:
{
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
draw_set_valign(0);
draw_set_halign(fa_center);
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_screen_center_x, (frMacro_Frontier_Options_mod_gml_screen_center_y - 24), "nothing to see here");
scrFRDrawSprite(sprSalamanderWalk, (scrFRSourceFrame() * 0.8), frMacro_Frontier_Options_mod_gml_screen_center_x, frMacro_Frontier_Options_mod_gml_screen_center_y);
scrFRDrawSprite(sprSalamanderWalk, (scrFRSourceFrame() * 0.8), (frMacro_Frontier_Options_mod_gml_screen_center_x + 48), frMacro_Frontier_Options_mod_gml_screen_center_y);
scrFRDrawSprite(sprSalamanderWalk, (scrFRSourceFrame() * 0.8), (frMacro_Frontier_Options_mod_gml_screen_center_x - 48), frMacro_Frontier_Options_mod_gml_screen_center_y);
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
break;
;
}
}
}
}

// Original Frontier_Options.mod.gml:945
function fr_Frontier_Options_mod_gml_page_credits_draw() {
; // macro hoisted: spec_x
; // macro hoisted: spec_y
; // macro hoisted: cred_x
; // macro hoisted: cred_y
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
draw_set_valign(0);
draw_set_halign(0);
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, frMacro_Frontier_Options_mod_gml_spec_y, "-SPECIAL THANKS-");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 11), "@sAEVUSONIAN");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 22), "CRINGERHOMBUS");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 33), "@sDRAGONSTRIVE");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 44), "GECKOBONE");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 55), "@sGOLDEN EPSILON");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 66), "JSBURG");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 77), "@sMCCHOMK");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 88), "SANIBLUES");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 99), "@sSQUIDDY");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_spec_x, (frMacro_Frontier_Options_mod_gml_spec_y + 110), "YOKIN");
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_cred_x, (frMacro_Frontier_Options_mod_gml_cred_y + 22), "WIGGLERCOLA");
;
draw_set_font(fntSmall);
scrFRDrawText((frMacro_Frontier_Options_mod_gml_cred_x - 4), (frMacro_Frontier_Options_mod_gml_cred_y + 30), "@(color:16745694)WIGGLERCOLA MAKE MOD");
;
draw_set_font(fntM1);
;
scrFRDrawText(frMacro_Frontier_Options_mod_gml_cred_x, (frMacro_Frontier_Options_mod_gml_cred_y + 77), "SPLATTIE");
;
draw_set_font(fntSmall);
scrFRDrawText((frMacro_Frontier_Options_mod_gml_cred_x - 4), (frMacro_Frontier_Options_mod_gml_cred_y + 85), "@(color:65280)MUSIC AND SFX");
;
draw_set_font(fntM1);
;
draw_set_halign(_frl__halign);
;
draw_set_valign(_frl__valign);
;
}

// Original Frontier_Options.mod.gml:987
function fr_Frontier_Options_mod_gml_cleanup() {
if (global.fr_module_vars[$ "mod:Frontier_Options"].loaded) {
{
frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.option_remove_mod, frMacro_Frontier_Options_mod_gml_mod_current_type, "Frontier_Options");
;
}
}
}

// Original Frontier_Options.mod.gml:992
function fr_Frontier_Options_mod_gml_CustomOptions_load() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Frontier_Options_mod_gml_CustomOptions_load_resume, id, scrFROther(other), _args, 17, []);
}
function fr_Frontier_Options_mod_gml_CustomOptions_load_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Frontier_Options_mod_gml_CustomOptions_load");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Frontier_Options.mod.gml:1033
{
fr_Frontier_Options_mod_gml_ExternalOptions_load();
;
}
_fr.pc=0;
break;
case 2: // Frontier_Options.mod.gml:1030
{
;
}
_fr.pc=1;
break;
case 3: // Frontier_Options.mod.gml:1030
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Frontier_Options.mod.gml:1026
{
scrFRFileUnload(_fr.vars._path);
;
global.fr_module_vars[$ "mod:Frontier_Options"].loaded = true;
;
}
_fr.pc=3;
break;
case 5: // Frontier_Options.mod.gml:1010
{
_fr.vars.option_count = scrFRLQSize(global.fr_module_vars[$ "mod:Frontier_Options"].options);
;
_fr.vars._obj = {};
;
{
_fr.vars.i = 0;
for (; (_fr.vars.option_count > _fr.vars.i); _fr.vars.i++) {
_fr.vars._key = scrFRLQKey(global.fr_module_vars[$ "mod:Frontier_Options"].options, _fr.vars.i);
;
scrFRLQSet(_fr.vars._obj, _fr.vars._key, scrFRLQGet(_fr.vars._options, _fr.vars._key, scrFRLQGet(global.fr_module_vars[$ "mod:Frontier_Options"].options, _fr.vars._key)));
;
}
}
global.fr_module_vars[$ "mod:Frontier_Options"].options = _fr.vars._obj;
;
}
_fr.pc=4;
break;
case 6: // Frontier_Options.mod.gml:1007
{
;
}
_fr.pc=5;
break;
case 7: // Frontier_Options.mod.gml:1007
_fr.result=undefined; _fr.done=true; return;
break;
case 8: // Frontier_Options.mod.gml:1006
{
scrFRTrace(scrFRJsonErrorText());
;
}
_fr.pc=7;
break;
case 9: // Frontier_Options.mod.gml:1005
_fr.pc = ((_fr.vars._options == scrFRJsonError())) ? 8 : 5;
break;
case 10: // Frontier_Options.mod.gml:1003
{
_fr.vars._options = scrFRJsonDecode(scrFRStringLoad(_fr.vars._path));
;
}
_fr.pc=9;
break;
case 11: // Frontier_Options.mod.gml:1022
{
fr_Frontier_Options_mod_gml_CustomOptions_save();
;
}
_fr.pc=4;
break;
case 12: // Frontier_Options.mod.gml:1002
_fr.pc = (scrFRFileExists(_fr.vars._path)) ? 10 : 11;
break;
case 14: // Frontier_Options.mod.gml:999
{
;
}
_fr.pc=13;
break;
case 15: // Frontier_Options.mod.gml:999
_fr.wait_ticks=max(0,0); _fr.pc=14; return;
break;
case 13: // Frontier_Options.mod.gml:998
_fr.pc=((! scrFRFileLoaded(_fr.vars._path)))?15:12;
break;
case 16: // Frontier_Options.mod.gml:994
{
_fr.vars._path = frMacro_Frontier_Options_mod_gml_CONFIG_FILE;
;
scrFRFileLoad(_fr.vars._path);
;
}
_fr.pc=13;
break;
case 17: // Frontier_Options.mod.gml:993
_fr.pc = (scrFRTaskFork(_fr, 16)) ? 16 : 1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Frontier_Options.mod.gml:1035
function fr_Frontier_Options_mod_gml_CustomOptions_save() {
scrFRStringSave(scrFRJsonEncode(global.fr_module_vars[$ "mod:Frontier_Options"].options, chr(9)), frMacro_Frontier_Options_mod_gml_CONFIG_FILE);
;
fr_Frontier_Options_mod_gml_ExternalOptions_load();
;
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: mod_current_type
; // macro hoisted: CONFIG_FILE
; // macro hoisted: screen_center_x
; // macro hoisted: screen_center_y
; // macro hoisted: screen_x
; // macro hoisted: screen_y
; // macro hoisted: statsPage
; // macro hoisted: charPage
}

// Original Frontier_Options.mod.gml:1055
function fr_Frontier_Options_mod_gml_statsPageController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
keepMeAlive = 2;
;
on_step = fr_Frontier_Options_mod_gml_statsPageController_step;
;
fr_Frontier_Options_mod_gml_statsPageSelectorButton_create((frMacro_Frontier_Options_mod_gml_screen_x + 128), (frMacro_Frontier_Options_mod_gml_screen_y + 64), scrFRSelf(self), "general", "general");
fr_Frontier_Options_mod_gml_statsPageSelectorButton_create((frMacro_Frontier_Options_mod_gml_screen_x + 128), (frMacro_Frontier_Options_mod_gml_screen_y + 74), scrFRSelf(self), "mutants", "characters");
return scrFRSelf(self);
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Options.mod.gml:1071
function fr_Frontier_Options_mod_gml_statsPageController_step() {
keepMeAlive -= scrFRSourceScale();
;
if ((keepMeAlive <= 0)) {
{
global.fr_module_vars[$ "mod:Frontier_Options"].statsPageController = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_isThisMyStatsButton", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
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

// Original Frontier_Options.mod.gml:1081
function fr_Frontier_Options_mod_gml_statsPageSelectorButton_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__text=undefined, _frl__page=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.create_button, _frl__x, _frl__y, mskNone, fr_Frontier_Options_mod_gml_statsPageSelectorButton_click, fr_Frontier_Options_mod_gml_statsPageSelectorButton_hover)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_isThisMyStatsButton = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Options"].mskStatsPageButton);
mytext = scrFRLocalize(_frl__text);
;
textColor = "@s";
;
depth = (- 10010);
page = _frl__page;
;
creator = _frl__creator;
;
hoverTime = 0;
;
clickScr = ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_statsPageSelectorButton_click];
hoverScr = ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_statsPageSelectorButton_hover];
on_end_step = fr_Frontier_Options_mod_gml_statsPageSelectorButton_endstep;
;
on_draw = fr_Frontier_Options_mod_gml_statsPageSelectorButton_draw;
;
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Options.mod.gml:1101
function fr_Frontier_Options_mod_gml_statsPageSelectorButton_click() {
global.fr_module_vars[$ "mod:Frontier_Options"].selectedStatsPage = page;
scrFRSoundPlay(sndClick);
}

// Original Frontier_Options.mod.gml:1105
function fr_Frontier_Options_mod_gml_statsPageSelectorButton_hover() {
textColor = "@s";
;
hoverTime = 2;
;
}

// Original Frontier_Options.mod.gml:1109
function fr_Frontier_Options_mod_gml_statsPageSelectorButton_endstep() {
if ((global.fr_module_vars[$ "mod:Frontier_Options"].selectedStatsPage == page)) {
{
textColor = "@w";
;
}
} else {
{
if ((hoverTime < 1)) {
{
textColor = "@(color:4210752)";
;
}
}
}
}
if ((hoverTime > 0)) {
{
hoverTime -= scrFRSourceScale();
;
}
}
}

// Original Frontier_Options.mod.gml:1121
function fr_Frontier_Options_mod_gml_statsPageSelectorButton_draw() {
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
draw_set_valign(0);
draw_set_halign(fa_center);
scrFRDrawText(x, (y - 4), (textColor + mytext));
draw_set_halign(_frl__halign);
draw_set_valign(_frl__valign);
}

// Original Frontier_Options.mod.gml:1137
function fr_Frontier_Options_mod_gml_statsCharacterPageController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
keepMeAlive = 2;
;
on_step = fr_Frontier_Options_mod_gml_statsCharacterPageController_step;
;
fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_create((frMacro_Frontier_Options_mod_gml_screen_x - 112), (frMacro_Frontier_Options_mod_gml_screen_y - 76), noone, 1, 0, "bubbles", "BUBBLES", frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.save_get, "Frontier", "unlock_bubbles"));
return scrFRSelf(self);
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Options.mod.gml:1149
function fr_Frontier_Options_mod_gml_statsCharacterPageController_step() {
keepMeAlive -= scrFRSourceScale();
;
if ((keepMeAlive <= 0)) {
{
global.fr_module_vars[$ "mod:Frontier_Options"].statsCharPageController = noone;
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_isThisMyCharacterStatsButton", true)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDelete(scrFRSelf(self));
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

// Original Frontier_Options.mod.gml:1159
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__unlockedframe=undefined, _frl__lockedframe=undefined, _frl__characterPage=undefined, _frl__name=undefined, _frl__unlock=undefined) {
{ var __fr_with1 = scrFRWithValues(frMacro_Frontier_Options_mod_gml_call(frMacro_Frontier_Options_mod_gml_scr.create_button, _frl__x, _frl__y, mskNone, fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_click, fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_hover)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_isThisMyCharacterStatsButton = true;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Options"].mskStatsCharacterButton);
image_frame = _frl__unlockedframe;
;
depth = (- 10010);
mytext = scrFRLocalize(_frl__name);
;
characterPage = _frl__characterPage;
;
creator = _frl__creator;
;
hovering = false;
;
hoverTime = 0;
;
clickScr = ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_click];
hoverScr = ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_hover];
on_end_step = fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_endstep;
;
on_draw = fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_draw;
;
if ((_frl__unlock == 0)) {
{
image_frame = _frl__lockedframe;
;
mytext = scrFRLocalize("LOCKED");
;
clickScr = ["mod", "Frontier_Options", fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButtonLocked_click];
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Frontier_Options.mod.gml:1186
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_click() {
global.fr_module_vars[$ "mod:Frontier_Options"].selectedCharacterPage = characterPage;
;
scrFRSoundPlay(sndClick);
}

// Original Frontier_Options.mod.gml:1190
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButtonLocked_click() {
scrFRSoundPlay(sndEmpty);
}

// Original Frontier_Options.mod.gml:1193
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_hover() {
hoverTime = 2;
;
}

// Original Frontier_Options.mod.gml:1196
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_endstep() {
if ((hoverTime > 1)) {
{
hovering = true;
}
} else {
{
hovering = false;
;
}
}
if ((hoverTime > 0)) {
{
hoverTime -= scrFRSourceScale();
;
}
}
}

// Original Frontier_Options.mod.gml:1206
function fr_Frontier_Options_mod_gml_statsCharacterPageSelectorButton_draw() {
if ((hovering == true)) {
{
scrFRDrawTooltip(x, (y - 8), mytext);
}
}
}
