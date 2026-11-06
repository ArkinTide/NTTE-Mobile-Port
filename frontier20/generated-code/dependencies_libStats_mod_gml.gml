// Original dependencies/libStats.mod.gml:1
function fr_dependencies_libStats_mod_gml___load() {

}

// Original dependencies/libStats.mod.gml:16
function fr_dependencies_libStats_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libStats", _frl_name]);
;
}

// Original dependencies/libStats.mod.gml:19
function fr_dependencies_libStats_mod_gml_init() {
fr_dependencies_libStats_mod_gml_addScript("change_health");
;
fr_dependencies_libStats_mod_gml_addScript("change_ammo");
;
fr_dependencies_libStats_mod_gml_addScript("change_max_hp");
;
fr_dependencies_libStats_mod_gml_addScript("change_accuracy");
;
fr_dependencies_libStats_mod_gml_addScript("change_speed");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libStats"].isLoaded = true;
;
}

// Original dependencies/libStats.mod.gml:28
function fr_dependencies_libStats_mod_gml_change_health(_frl_obj=undefined, _frl_amount=undefined) {
_frl_obj.hp = min((_frl_obj.hp + _frl_amount), _frl_obj.max_hp);
;
if ((scrFRVariableExists(_frl_obj, "lsthealth") && (_frl_amount < 0))) {
{
_frl_obj.lsthealth = _frl_obj.hp;
;
}
}
}

// Original dependencies/libStats.mod.gml:39
function fr_dependencies_libStats_mod_gml_change_ammo(_frl_player=undefined, _frl_type=undefined, _frl_amount=undefined) {
scrFRMemberIndexWrite(_frl_player, "ammo", [_frl_type], max(min((scrFRIndexGet(_frl_player.ammo, _frl_type) + _frl_amount), scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), _frl_type)), 0), "=");
;
}

// Original dependencies/libStats.mod.gml:46
function fr_dependencies_libStats_mod_gml_change_max_hp(_frl_player=undefined, _frl_amount=undefined) {
scrFRMaxHealthWrite(_frl_player, _frl_amount, "+=");
;
scrFRMaxHealthWrite(_frl_player, max(_frl_player.max_hp, 1), "=");
;
_frl_player.hp = min(_frl_player.hp, _frl_player.max_hp);
;
}

// Original dependencies/libStats.mod.gml:56
function fr_dependencies_libStats_mod_gml_change_accuracy(_frl_player=undefined, _frl_amount=undefined) {
_frl_player.accuracy *= _frl_amount;
;
}

// Original dependencies/libStats.mod.gml:65
function fr_dependencies_libStats_mod_gml_change_speed(_frl_player=undefined, _frl_amount=undefined) {
if (((_frl_player.maxspeed / timescale) > 0.1)) {
{
_frl_player.maxspeed += (_frl_amount) * timescale;
;
_frl_player.maxspeed = (max((_frl_player.maxspeed / timescale), 0.1)) * timescale;
;
}
}
}
