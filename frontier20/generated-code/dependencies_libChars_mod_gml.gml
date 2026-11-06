// Original dependencies/libChars.mod.gml:1
function fr_dependencies_libChars_mod_gml___load() {

}

// Original dependencies/libChars.mod.gml:15
function fr_dependencies_libChars_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libChars", _frl_name]);
;
}

// Original dependencies/libChars.mod.gml:18
function fr_dependencies_libChars_mod_gml_init() {
fr_dependencies_libChars_mod_gml_addScript("");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libChars"].isLoaded = true;
;
}
