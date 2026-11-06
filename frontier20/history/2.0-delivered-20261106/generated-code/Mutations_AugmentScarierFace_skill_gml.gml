#macro frMacro_Mutations_AugmentScarierFace_skill_gml_scr global.fr_module_vars[$ "skill:AugmentScarierFace"].scr

#macro frMacro_Mutations_AugmentScarierFace_skill_gml_call scrFRScriptCall

#macro frMacro_Mutations_AugmentScarierFace_skill_gml_enemy_boss (scrFRVariableExists(scrFRSelf(self), "boss") ? boss : (scrFRVariableExists(scrFRSelf(self), "intro") || (scrFRArrayFindIndex([Nothing, Nothing2, NTTEFullCoastBoss, FR_OBJECT_OASIS_BOSS], scrFRObjectIndex(scrFRSelf(self))) >= 0)))

// Original Mutations/AugmentScarierFace.skill.gml:1
function fr_Mutations_AugmentScarierFace_skill_gml___load() {

}

// Original Mutations/AugmentScarierFace.skill.gml:1
function fr_Mutations_AugmentScarierFace_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentScarierFace_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentScarierFace_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentScarierFace_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentScarierFace.skill.gml:8
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentScarierFace", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
; // macro hoisted: enemy_boss
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentScarierFace.skill.gml:7
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentScarierFace.skill.gml:7
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentScarierFace.skill.gml:7
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentScarierFace.skill.gml:3
{
global.fr_module_vars[$ "skill:AugmentScarierFace"].sprSkillIcon = sprFR_sprAugmentScarierFace_8676d9383670;
global.fr_module_vars[$ "skill:AugmentScarierFace"].sprSkillHud = sprFR_sprAugmentScarierFaceIco_97e9079d8a26;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentScarierFace.skill.gml:14
function fr_Mutations_AugmentScarierFace_skill_gml_skill_name() {
return loc("Frontier:AugmentScarierFace:0", "SABOTAGE");
;
}

// Original Mutations/AugmentScarierFace.skill.gml:15
function fr_Mutations_AugmentScarierFace_skill_gml_skill_text() {
return loc("Frontier:AugmentScarierFace:1", "@(color:16776960)BOSSES @sARE @wWEAKER @sAND#@wDROP MORE LOOT");
;
}

// Original Mutations/AugmentScarierFace.skill.gml:16
function fr_Mutations_AugmentScarierFace_skill_gml_skill_tip() {
return "CALCULATED STRIKE";
;
}

// Original Mutations/AugmentScarierFace.skill.gml:17
function fr_Mutations_AugmentScarierFace_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentScarierFace"].sprSkillIcon);
;
}

// Original Mutations/AugmentScarierFace.skill.gml:18
function fr_Mutations_AugmentScarierFace_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentScarierFace"].sprSkillHud;
;
}

// Original Mutations/AugmentScarierFace.skill.gml:19
function fr_Mutations_AugmentScarierFace_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentScarierFace.skill.gml:20
function fr_Mutations_AugmentScarierFace_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentScarierFace.skill.gml:21
function fr_Mutations_AugmentScarierFace_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentScarierFace.skill.gml:22
function fr_Mutations_AugmentScarierFace_skill_gml_skill_augment() {
return mut_scarier_face;
;
}

// Original Mutations/AugmentScarierFace.skill.gml:24
function fr_Mutations_AugmentScarierFace_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(enemy, "fr_augmentSabotage", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentSabotage"))) {
{
fr_augmentSabotage = true;
;
}
}
if (frMacro_Mutations_AugmentScarierFace_skill_gml_enemy_boss) {
{
scrFRMaxHealthWrite(id, (2 * scrFRGetSkill("AugmentScarierFace")), "/=");
;
if ((hp > max_hp)) {
{
hp = max_hp;
;
}
}
if ((!scrFRVariableExists(scrFRSelf(self), "fr_augmentSabotageBoss"))) {
{
fr_augmentSabotageBoss = true;
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(scrFRMatching(enemy, "fr_augmentSabotageBoss", true)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if ((hp <= 0)) {
{
repeat ((3 + scrFRSourceIRandom(2))) {
var _frl__lootPool = frMacro_Mutations_AugmentScarierFace_skill_gml_call(frMacro_Mutations_AugmentScarierFace_skill_gml_scr.pool, [[[AmmoChest, "Basegame", ""], 12], [[WeaponChest, "Basegame", ""], 7], [[HealthChest, "Basegame", ""], 5], [[RogueChest, "Basegame", ""], ((array_length(scrFRMatching(Player, "race", "rogue", "vanthro")) > 0) * 5)], [[RadChest, "Basegame", ""], 5], [["MealChest_create", "MOD", "Frontier_Pickups"], 3], [["TrinketChest_create", "MOD", "Frontier_Pickups"], (3 * scrFRModLoaded("mod", "TreasureTrove"))], [["BonusAmmoChest", "OBJ", "telib"], (2 * scrFRModLoaded("mod", "telib"))], [["BonusHealthChest", "OBJ", "telib"], (2 * scrFRModLoaded("mod", "telib"))], [["CatChest", "OBJ", "telib"], (1 * scrFRModLoaded("mod", "telib"))], [["BatChest", "OBJ", "telib"], (1 * scrFRModLoaded("mod", "telib"))], [["RatChest", "OBJ", "telib"], (1 * scrFRModLoaded("mod", "telib"))], [["OrchidChest", "OBJ", "telib"], (1 * scrFRModLoaded("mod", "telib"))], [["RedChest", "OBJ", "telib"], (0.5 * scrFRModLoaded("mod", "telib"))], [["RedAmmoChest", "OBJ", "telib"], (1 * scrFRModLoaded("mod", "telib"))], [["HammerHeadChest", "OBJ", "telib"], (3 * scrFRModLoaded("mod", "telib"))]]);
{ var __fr_switch_value7=scrFRIndexGet(_frl__lootPool, 1), __fr_switch_case8=-1;
if(__fr_switch_case8==-1 && __fr_switch_value7==("Basegame")) __fr_switch_case8=0;
if(__fr_switch_case8==-1 && __fr_switch_value7==("MOD")) __fr_switch_case8=1;
if(__fr_switch_case8==-1 && __fr_switch_value7==("OBJ")) __fr_switch_case8=2;
if(__fr_switch_case8==-1) __fr_switch_case8=-1;
switch(__fr_switch_case8) {
case 0:
{
scrFRInstanceCreate(x, y, scrFRIndexGet(_frl__lootPool, 0));
;
}
break;
;
case 1:
{
scrFRModCall("mod", scrFRIndexGet(_frl__lootPool, 2), scrFRIndexGet(_frl__lootPool, 0), x, y);
}
break;
;
case 2:
{
scrFRModCall("mod", scrFRIndexGet(_frl__lootPool, 2), "obj_create", x, y, scrFRIndexGet(_frl__lootPool, 0));
}
break;
;
}
}
}
}
}
}
}
if(__fr_break6) break;
}}
}
