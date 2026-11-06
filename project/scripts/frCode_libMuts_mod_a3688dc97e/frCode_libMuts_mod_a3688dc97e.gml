// Original dependencies/libMuts.mod.gml:1
function fr_dependencies_libMuts_mod_gml___load() {

}

// Original dependencies/libMuts.mod.gml:20
function fr_dependencies_libMuts_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libMuts", _frl_name]);
;
}

// Original dependencies/libMuts.mod.gml:23
function fr_dependencies_libMuts_mod_gml_init() {
fr_dependencies_libMuts_mod_gml_addScript("skill_get_category");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_set_category");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_get_avail");
;
fr_dependencies_libMuts_mod_gml_addScript("get_skills");
;
fr_dependencies_libMuts_mod_gml_addScript("get_ultras");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_decide");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_get_image");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_get_icon");
;
fr_dependencies_libMuts_mod_gml_addScript("skill_is_ultra");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
global.fr_module_vars[$ "mod:libMuts"].isLoaded = true;
;
global.fr_module_vars[$ "mod:libMuts"].mut_categories = {"offensive": [mut_gamma_guts, mut_scarier_face, mut_long_arms, mut_shotgun_shoulders, mut_laser_brain, mut_eagle_eyes, mut_impact_wrists, mut_bolt_marrow, mut_stress, mut_trigger_fingers, mut_sharp_teeth], "defensive": [mut_rhino_skin, mut_bloodlust, mut_second_stomach, mut_boiling_veins, mut_strong_spirit], "utility": [mut_extra_feet, mut_plutonium_hunger, mut_throne_butt, mut_euphoria, mut_last_wish, mut_patience, mut_hammerhead, mut_heavy_heart], "ammo": [mut_rabbit_paw, mut_lucky_shot, mut_back_muscle, mut_recycle_gland, mut_open_mind]};
}

// Original dependencies/libMuts.mod.gml:44
function fr_dependencies_libMuts_mod_gml_skill_get_category(_frl_mut=undefined) {
{
var _frl_i = 0;
for (; (_frl_i < scrFRLQSize(global.fr_module_vars[$ "mod:libMuts"].mut_categories)); _frl_i++) {
if (is_array(scrFRLQValue(global.fr_module_vars[$ "mod:libMuts"].mut_categories, _frl_i))) {
{
var _frl_length = array_length(scrFRLQValue(global.fr_module_vars[$ "mod:libMuts"].mut_categories, _frl_i));
;
{
var _frl_i2 = 0;
for (; (_frl_i2 < _frl_length); _frl_i2++) {
if ((scrFRArrayFindIndex(scrFRLQValue(global.fr_module_vars[$ "mod:libMuts"].mut_categories, _frl_i), _frl_mut) != (- 1))) {
{
return scrFRLQKey(global.fr_module_vars[$ "mod:libMuts"].mut_categories, _frl_i);
;
}
}
}
}
}
}
}
}
if ((is_string(_frl_mut) and (scrFRModCall("skill", _frl_mut, "skill_type") != undefined))) {
{
var _frl_skill_type = scrFRModCall("skill", _frl_mut, "skill_type");
;
if (is_string(_frl_skill_type)) {
{
return string_lower(_frl_skill_type);
;
}
} else {
if (is_real(_frl_skill_type)) {
{
{ var __fr_switch_value1=_frl_skill_type, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(0)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(3)) __fr_switch_case2=3;
if(__fr_switch_case2==-1) __fr_switch_case2=4;
switch(__fr_switch_case2) {
case 0:
return "offensive";
;
break;
;
case 1:
return "defensive";
;
break;
;
case 2:
return "utility";
;
break;
;
case 3:
return "ammo";
;
break;
;
case 4:
return _frl_skill_type;
;
}
}
}
} else {
{
return _frl_skill_type;
;
}
}
}
}
} else {
if ((is_string(_frl_mut) and fr_dependencies_libMuts_mod_gml_skill_is_ultra(_frl_mut))) {
{
return "ultra";
;
}
}
}
return (- 1);
;
}

// Original dependencies/libMuts.mod.gml:88
function fr_dependencies_libMuts_mod_gml_skill_set_category(_frl_mut=undefined, _frl_category=undefined) {
if (is_array(_frl_mut)) {
{
if ((is_array(_frl_category) && (array_length(_frl_category) != array_length(_frl_mut)))) {
{
scrFRTrace("Lib error! if you're passing arrays into skill_set_category, please keep the lengths the same and/or make category a single value.");
;
return;
;
}
} else {
if (is_array(_frl_category)) {
{
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl_mut)); _frl_i++) {
fr_dependencies_libMuts_mod_gml_skill_set_category(scrFRIndexGet(_frl_mut, _frl_i), scrFRIndexGet(_frl_category, _frl_i));
}
}
}
} else {
{
{
var _frl_i = 0;
for (; (_frl_i < array_length(_frl_mut)); _frl_i++) {
fr_dependencies_libMuts_mod_gml_skill_set_category(scrFRIndexGet(_frl_mut, _frl_i), _frl_category);
}
}
}
}
}
}
} else {
{
if (is_array(_frl_category)) {
{
scrFRTrace("Lib error! for skill_set_category, if mut is a single value category cannot be an array.");
;
return;
;
}
} else {
{
array_push(scrFRLQGet(global.fr_module_vars[$ "mod:libMuts"].mut_categories, _frl_category), _frl_mut);
;
}
}
}
}
}

// Original dependencies/libMuts.mod.gml:117
function fr_dependencies_libMuts_mod_gml_skill_get_avail() {
var _frl_includeobtained = 0;
;
if (((argument_count > 1) && (argument_count>1 ? argument[1] : undefined))) {
{
_frl_includeobtained = 1;
;
}
}
if (is_array((argument_count>0 ? argument[0] : undefined))) {
{
{ var __fr_with1 = scrFRWithValues((argument_count>0 ? argument[0] : undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! fr_dependencies_libMuts_mod_gml_skill_get_avail(scrFRSelf(self)))) {
{
return false;
;
}
}
}
}
if(__fr_break3) break;
}}
return true;
;
}
}
if (((argument_count > 2) && (argument_count>2 ? argument[2] : undefined))) {
{
{ var __fr_with4 = scrFRWithValues(SkillIcon), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((skill == (argument_count>0 ? argument[0] : undefined))) {
{
return false;
;
}
}
}
}
if(__fr_break6) break;
}}
}
}
if (is_real((argument_count>0 ? argument[0] : undefined))) {
{
return ((_frl_includeobtained || (! scrFRGetSkill((argument_count>0 ? argument[0] : undefined)))) && scrFRSkillActive((argument_count>0 ? argument[0] : undefined)));
;
}
}
if (is_string((argument_count>0 ? argument[0] : undefined))) {
{
var _frl_avail = true;
;
if ((! scrFRModLoaded("skill", (argument_count>0 ? argument[0] : undefined)))) {
{
_frl_avail = false;
;
}
} else {
if ((scrFRScriptExists("skill", (argument_count>0 ? argument[0] : undefined), "skill_avail") && (! scrFRModCall("skill", (argument_count>0 ? argument[0] : undefined), "skill_avail")))) {
{
_frl_avail = false;
;
}
}
}
return ((_frl_avail && (_frl_includeobtained || (! scrFRGetSkill((argument_count>0 ? argument[0] : undefined))))) && scrFRSkillActive((argument_count>0 ? argument[0] : undefined)));
;
}
}
return false;
;
}

// Original dependencies/libMuts.mod.gml:161
function fr_dependencies_libMuts_mod_gml_get_skills() {
var _frl_allskills = [];
var _frl_modskills = scrFRModNames("skill");
;
var _frl_categories = [];
;
if ((argument_count > 2)) {
{
if (is_array((argument_count>2 ? argument[2] : undefined))) {
{
_frl_categories = (argument_count>2 ? argument[2] : undefined);
;
}
} else {
if (is_real((argument_count>2 ? argument[2] : undefined))) {
{
{ var __fr_switch_value1=(argument_count>2 ? argument[2] : undefined), __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(0)) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==(1)) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==(2)) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==(3)) __fr_switch_case2=3;
if(__fr_switch_case2==-1) __fr_switch_case2=4;
switch(__fr_switch_case2) {
case 0:
_frl_categories = ["offensive"];
;
break;
;
case 1:
_frl_categories = ["defensive"];
;
break;
;
case 2:
_frl_categories = ["utility"];
;
break;
;
case 3:
_frl_categories = ["ammo"];
;
break;
;
case 4:
_frl_categories = [(argument_count>2 ? argument[2] : undefined)];
;
}
}
}
} else {
{
_frl_categories = [(argument_count>2 ? argument[2] : undefined)];
;
}
}
}
}
}
{
var _frl_i = 1;
for (; (_frl_i <= 29); _frl_i += 1) {
var _frl_whitelist = false;
;
if ((argument_count > 2)) {
{
_frl_whitelist = (argument_count>1 ? argument[1] : undefined);
;
}
}
var _frl_nope = _frl_whitelist;
;
{ var __fr_with3 = scrFRWithValues(_frl_categories), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
if (((fr_dependencies_libMuts_mod_gml_skill_get_category(_frl_i) == scrFRSelf(self)) && _frl_whitelist)) {
{
_frl_nope = false;
;
__fr_break5=true; break;
;
}
} else {
if (((fr_dependencies_libMuts_mod_gml_skill_get_category(_frl_i) != scrFRSelf(self)) && (! _frl_whitelist))) {
{
_frl_nope = true;
;
__fr_break5=true; break;
;
}
}
}
}
}
if(__fr_break5) break;
}}
if (_frl_nope) {
{
continue;
;
}
}
if (((argument_count > 0) && (argument_count>0 ? argument[0] : undefined))) {
{
if (fr_dependencies_libMuts_mod_gml_skill_get_avail(_frl_i, 0, 1)) {
{
array_push(_frl_allskills, _frl_i);
;
}
}
}
} else {
{
array_push(_frl_allskills, _frl_i);
;
}
}
}
}
{
_frl_i = 0;
for (; (_frl_i < array_length_1d(_frl_modskills)); _frl_i++) {
if (scrFRModLoaded("skill", scrFRIndexGet(_frl_modskills, _frl_i))) {
{
if (scrFRScriptExists("skill", scrFRIndexGet(_frl_modskills, _frl_i), "skill_ultra")) {
{
continue;
;
}
}
var _frl_whitelist = false;
;
if ((argument_count > 2)) {
{
_frl_whitelist = (argument_count>1 ? argument[1] : undefined);
;
}
}
var _frl_nope = _frl_whitelist;
;
{ var __fr_with6 = scrFRWithValues(_frl_categories), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (((fr_dependencies_libMuts_mod_gml_skill_get_category(scrFRIndexGet(_frl_modskills, _frl_i)) == scrFRSelf(self)) && _frl_whitelist)) {
{
_frl_nope = false;
;
__fr_break8=true; break;
;
}
} else {
if (((fr_dependencies_libMuts_mod_gml_skill_get_category(scrFRIndexGet(_frl_modskills, _frl_i)) != scrFRSelf(self)) && (! _frl_whitelist))) {
{
_frl_nope = true;
;
__fr_break8=true; break;
;
}
}
}
}
}
if(__fr_break8) break;
}}
if (_frl_nope) {
{
continue;
;
}
}
if (((argument_count > 0) && (argument_count>0 ? argument[0] : undefined))) {
{
if (fr_dependencies_libMuts_mod_gml_skill_get_avail(scrFRIndexGet(_frl_modskills, _frl_i), 0, 1)) {
{
array_push(_frl_allskills, scrFRIndexGet(_frl_modskills, _frl_i));
;
}
}
}
} else {
{
array_push(_frl_allskills, scrFRIndexGet(_frl_modskills, _frl_i));
;
}
}
}
}
}
}
return _frl_allskills;
;
}

// Original dependencies/libMuts.mod.gml:261
function fr_dependencies_libMuts_mod_gml_get_ultras() {
var _frl_ultraskills = [];
var _frl_modskills = scrFRModNames("skill");
;
{
var _frl_i = Race.Fish;
for (; (_frl_i <= Race.Frog); _frl_i++) {
{
var _frl_i2 = 1;
for (; (_frl_i2 <= scrFRUltraCount(_frl_i)); _frl_i2++) {
array_push(_frl_ultraskills, (((_frl_i * 3) + _frl_i2) - 4));
;
}
}
}
}
{ var __fr_with1 = scrFRWithValues(scrFRModNames("race")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl_num = 1;
;
while (((scrFRModCall("race", scrFRSelf(self), "race_ultra_name", _frl_num) != "") && (scrFRModCall("race", scrFRSelf(self), "race_ultra_name", _frl_num) != 0))) {
array_push(_frl_ultraskills, [scrFRSelf(self), _frl_num, scrFRModCall("race", scrFRSelf(self), "race_ultra_name", _frl_num), scrFRModCall("race", scrFRSelf(self), "race_ultra_text", _frl_num)]);
;
_frl_num++;
;
}
}
}
if(__fr_break3) break;
}}
{
_frl_i = 0;
for (; (_frl_i < array_length_1d(_frl_modskills)); _frl_i++) {
if (scrFRModLoaded("skill", scrFRIndexGet(_frl_modskills, _frl_i))) {
{
if (scrFRScriptExists("skill", scrFRIndexGet(_frl_modskills, _frl_i), "skill_ultra")) {
{
var _frl_ult = scrFRModCall("skill", scrFRIndexGet(_frl_modskills, _frl_i), "skill_ultra");
;
if (((is_string(_frl_ult) && (scrFRModLoaded("race", _frl_ult) || string_count(string_lower(_frl_ult), "fish crystal eyes melting plant venuz steroids robot chicken rebel horror rogue skeleton frog"))) || (is_real(_frl_ult) && (_frl_ult != (- 1))))) {
{
array_push(_frl_ultraskills, scrFRIndexGet(_frl_modskills, _frl_i));
;
}
}
}
}
}
}
}
}
return _frl_ultraskills;
;
}

// Original dependencies/libMuts.mod.gml:296
function fr_dependencies_libMuts_mod_gml_skill_decide() {
var _frl_skills = undefined;
;
if ((argument_count >= 3)) {
{
_frl_skills = fr_dependencies_libMuts_mod_gml_get_skills((argument_count>0 ? argument[0] : undefined), (argument_count>1 ? argument[1] : undefined), (argument_count>2 ? argument[2] : undefined));
;
}
} else {
if ((argument_count >= 2)) {
{
_frl_skills = fr_dependencies_libMuts_mod_gml_get_skills((argument_count>0 ? argument[0] : undefined), (argument_count>1 ? argument[1] : undefined));
;
}
} else {
if ((argument_count >= 1)) {
{
_frl_skills = fr_dependencies_libMuts_mod_gml_get_skills((argument_count>0 ? argument[0] : undefined));
;
}
} else {
{
_frl_skills = fr_dependencies_libMuts_mod_gml_get_skills(true);
;
}
}
}
}
if ((array_length(_frl_skills) == 0)) {
{
return mut_last_wish;
;
}
}
return scrFRIndexGet(_frl_skills, scrFRSourceIRandom((array_length(_frl_skills) - 1)));
;
}

// Original dependencies/libMuts.mod.gml:322
function fr_dependencies_libMuts_mod_gml_skill_get_image(_frl__mut=undefined) {
var _frl_retVal = [sprSkillIcon, 0];
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(0, 0, FR_OBJECT_EFFECT)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (is_real(_frl__mut)) {
{
_frl_retVal = [sprSkillIcon, _frl__mut];
}
} else {
{
sprite_index = scrFRAreaSourceSprite(sprSkillIcon);
;
{ var __fr_with4 = scrFRWithValues(GameCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
t_mutindex = mutindex;
;
}
}
if(__fr_break6) break;
}}
scrFRModCall("skill", _frl__mut, "skill_button");
{ var __fr_with7 = scrFRWithValues(GameCont), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
mutindex = t_mutindex;
;
}
}
if(__fr_break9) break;
}}
var _frl_retVal = [sprite_index, image_index];
;
}
}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
return _frl_retVal;
;
}

// Original dependencies/libMuts.mod.gml:350
function fr_dependencies_libMuts_mod_gml_skill_get_icon(_frl__mut=undefined) {
if (is_real(_frl__mut)) {
{
return [sprSkillIconHUD, _frl__mut];
;
}
}
if ((is_string(_frl__mut) && scrFRScriptExists("skill", _frl__mut, "skill_icon"))) {
{
return [scrFRModCall("skill", _frl__mut, "skill_icon"), 0];
;
}
}
return [sprEGIconHUD, 2];
;
}

// Original dependencies/libMuts.mod.gml:365
function fr_dependencies_libMuts_mod_gml_skill_is_ultra(_frl__mut=undefined) {
if (is_real(_frl__mut)) {
{
{
var _frl_i = Race.Fish;
for (; (_frl_i <= Race.Frog); _frl_i++) {
{
var _frl_i2 = 1;
for (; (_frl_i2 <= scrFRUltraCount(_frl_i)); _frl_i2++) {
if ((_frl__mut == (((_frl_i * 3) + _frl_i2) - 4))) {
{
return true;
;
}
}
}
}
}
}
return false;
;
}
}
if (scrFRScriptExists("skill", _frl__mut, "skill_ultra")) {
{
var _frl_ult = scrFRModCall("skill", _frl__mut, "skill_ultra");
;
if (((is_string(_frl_ult) && (scrFRModLoaded("race", _frl_ult) || string_count(string_lower(_frl_ult), "fish crystal eyes melting plant venuz steroids robot chicken rebel horror rogue skeleton frog"))) || (is_real(_frl_ult) && (_frl_ult != (- 1))))) {
{
return true;
;
}
}
}
}
return false;
;
}
