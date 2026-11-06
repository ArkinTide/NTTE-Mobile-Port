#macro frMacro_dependencies_libBoilerplate_mod_gml_scr global.fr_module_vars[$ "mod:libBoilerplate"].scr

#macro frMacro_dependencies_libBoilerplate_mod_gml_call scrFRScriptCall

#macro frMacro_dependencies_libBoilerplate_mod_gml_mod_current_type scrFRIndexGet(["mod", "libBoilerplate", 0], 0)

// Original dependencies/libBoilerplate.mod.gml:1
function fr_dependencies_libBoilerplate_mod_gml___load() {

}

// Original dependencies/libBoilerplate.mod.gml:1
function fr_dependencies_libBoilerplate_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libBoilerplate_mod_gml_init_resume, id, scrFROther(other), _args, 9, []);
}
function fr_dependencies_libBoilerplate_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libBoilerplate_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libBoilerplate.mod.gml:23
{
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: mod_current_type
}
_fr.pc=0;
break;
case 2: // dependencies/libBoilerplate.mod.gml:17
{
;
}
_fr.pc=1;
break;
case 3: // dependencies/libBoilerplate.mod.gml:17
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // dependencies/libBoilerplate.mod.gml:9
{
scrFRScriptCall(["mod", "lib", "getRef"], frMacro_dependencies_libBoilerplate_mod_gml_mod_current_type, "libBoilerplate", "scr");
;
_fr.vars.modules = ["libImprovements"];
;
{ var __fr_with1 = scrFRWithValues(_fr.vars.modules), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
frMacro_dependencies_libBoilerplate_mod_gml_call(frMacro_dependencies_libBoilerplate_mod_gml_scr.import, scrFRSelf(self));
}
if(__fr_break3) break;
}}
;
global.fr_module_vars[$ "mod:libBoilerplate"].libLoaded = true;
;
}
_fr.pc=3;
break;
case 6: // dependencies/libBoilerplate.mod.gml:6
{
;
}
_fr.pc=5;
break;
case 7: // dependencies/libBoilerplate.mod.gml:6
_fr.wait_ticks=max(0,1); _fr.pc=6; return;
break;
case 5: // dependencies/libBoilerplate.mod.gml:6
_fr.pc=((! scrFRModLoaded("mod", "lib")))?7:4;
break;
case 8: // dependencies/libBoilerplate.mod.gml:4
_fr.pc = (scrFRTaskFork(_fr, 5)) ? 5 : 1;
break;
case 9: // dependencies/libBoilerplate.mod.gml:3
{
global.fr_module_vars[$ "mod:libBoilerplate"].libLoaded = false;
;
}
_fr.pc=8;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}

