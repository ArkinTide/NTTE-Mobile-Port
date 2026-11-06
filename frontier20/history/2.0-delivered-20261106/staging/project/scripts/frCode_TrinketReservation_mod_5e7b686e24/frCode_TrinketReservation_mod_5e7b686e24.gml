#macro frMacro_Trinkets_TrinketReservation_mod_gml_trinketPower (scrFRModCall("mod", "Trinkets", "trinket_get", index, "TrinketReservation") + scrFRIndexGet(GameCont.tk_trinketPower, index))

// Original Trinkets/TrinketReservation.mod.gml:1
function fr_Trinkets_TrinketReservation_mod_gml___load() {

}

// Original Trinkets/TrinketReservation.mod.gml:1
function fr_Trinkets_TrinketReservation_mod_gml_init() {
global.fr_module_vars[$ "mod:TrinketReservation"].sprTrinket = sprFR_sprReservation_f2b5c13042c0;
;
global.fr_module_vars[$ "mod:TrinketReservation"].sprTrinketHud = sprFR_sprReservation_31f7bf0614b5;
;
; // macro hoisted: trinketPower
;
global.fr_module_vars[$ "mod:TrinketReservation"].lastCounts = [0, 0, 0, 0];
;
}

// Original Trinkets/TrinketReservation.mod.gml:8
function fr_Trinkets_TrinketReservation_mod_gml_trinket_name() {
return "RESERVATION";
;
}

// Original Trinkets/TrinketReservation.mod.gml:9
function fr_Trinkets_TrinketReservation_mod_gml_trinket_text() {
return "@wMORE @(color:4419071)MEAL CHESTS";
;
}

// Original Trinkets/TrinketReservation.mod.gml:10
function fr_Trinkets_TrinketReservation_mod_gml_trinket_ttip() {
return "ALL YOU CAN EAT";
;
}

// Original Trinkets/TrinketReservation.mod.gml:11
function fr_Trinkets_TrinketReservation_mod_gml_trinket_sprt() {
return global.fr_module_vars[$ "mod:TrinketReservation"].sprTrinket;
;
}

// Original Trinkets/TrinketReservation.mod.gml:12
function fr_Trinkets_TrinketReservation_mod_gml_trinket_sprt_hud() {
return global.fr_module_vars[$ "mod:TrinketReservation"].sprTrinketHud;
;
}

// Original Trinkets/TrinketReservation.mod.gml:13
function fr_Trinkets_TrinketReservation_mod_gml_trinket_area() {
return 6;
;
}

// Original Trinkets/TrinketReservation.mod.gml:14
function fr_Trinkets_TrinketReservation_mod_gml_trinket_swap() {
return sndSwapGold;
;
}

// Original Trinkets/TrinketReservation.mod.gml:16
function fr_Trinkets_TrinketReservation_mod_gml_trinket_step() {
if ((tk_trinketReservation != frMacro_Trinkets_TrinketReservation_mod_gml_trinketPower)) {
{
fr_Trinkets_TrinketReservation_mod_gml_stats_lose();
;
tk_trinketReservation = frMacro_Trinkets_TrinketReservation_mod_gml_trinketPower;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:TrinketReservation"], "lastCounts", [index], tk_trinketReservation, "=");
;
fr_Trinkets_TrinketReservation_mod_gml_stats_gain();
;
}
}
}

// Original Trinkets/TrinketReservation.mod.gml:25
function fr_Trinkets_TrinketReservation_mod_gml_trinket_take() {
if ((!scrFRVariableExists(scrFRSelf(self), "tk_trinketReservation"))) {
{
tk_trinketReservation = 0;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:TrinketReservation"], "lastCounts", [index], tk_trinketReservation, "=");
;
}
}
}

// Original Trinkets/TrinketReservation.mod.gml:31
function fr_Trinkets_TrinketReservation_mod_gml_trinket_lose() {
if ((scrFRModCall("mod", "Trinkets", "trinket_get", index, "TrinketReservation") == 1)) {
{
fr_Trinkets_TrinketReservation_mod_gml_stats_lose();
;
tk_trinketReservation = 0;
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:TrinketReservation"], "lastCounts", [index], tk_trinketReservation, "=");
;
}
}
}

// Original Trinkets/TrinketReservation.mod.gml:39
function fr_Trinkets_TrinketReservation_mod_gml_trinket_lose_death(_frl__index=undefined) {
GameCont.fr_mealChestChance -= scrFRIndexGet(global.fr_module_vars[$ "mod:TrinketReservation"].lastCounts, _frl__index);
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:TrinketReservation"], "lastCounts", [_frl__index], 0, "=");
;
}

// Original Trinkets/TrinketReservation.mod.gml:43
function fr_Trinkets_TrinketReservation_mod_gml_stats_gain() {
GameCont.fr_mealChestChance += tk_trinketReservation;
;
}

// Original Trinkets/TrinketReservation.mod.gml:46
function fr_Trinkets_TrinketReservation_mod_gml_stats_lose() {
GameCont.fr_mealChestChance -= tk_trinketReservation;
;
}
