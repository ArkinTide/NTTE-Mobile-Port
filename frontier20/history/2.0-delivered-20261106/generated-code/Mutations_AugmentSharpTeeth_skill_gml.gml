// Original Mutations/AugmentSharpTeeth.skill.gml:1
function fr_Mutations_AugmentSharpTeeth_skill_gml___load() {

}

// Original Mutations/AugmentSharpTeeth.skill.gml:1
function fr_Mutations_AugmentSharpTeeth_skill_gml_init() {
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprSkillIcon = sprFR_sprAugmentSharpTeeth_f46d46708968;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprSkillHud = sprFR_sprAugmentSharpTeethIcon_00a76aecfa6c;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprRadius = sprFR_sprAugmentSharpTeethRadi_2e835acc0fd8;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprNull = sprFR_sprAugmentSharpTeethNull_9ec2254a74bb;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprGreenRadius = sprFR_sprGreenAugmentSharpTeet_489b06abc4b0;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprGreenNull = sprFR_sprGreenAugmentSharpTeet_f96ed70f2e57;
;
global.fr_module_vars[$ "skill:AugmentSharpTeeth"].settingGreenAugments = false;
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:14
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_name() {
return loc("Frontier:AugmentSharpTeeth:0", "NULL PLATING");
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:15
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_text() {
return loc("Frontier:AugmentSharpTeeth:1", "@(color:16776960)NULLIFICATION BLAST#@sWHEN @wTAKING DAMAGE");
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:16
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_tip() {
return "NONE IS MORE FUN";
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:17
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprSkillIcon);
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:18
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprSkillHud;
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:19
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:20
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:21
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:22
function fr_Mutations_AugmentSharpTeeth_skill_gml_skill_augment() {
return mut_sharp_teeth;
;
}

// Original Mutations/AugmentSharpTeeth.skill.gml:24
function fr_Mutations_AugmentSharpTeeth_skill_gml_step() {
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_blast_armor"))) {
{
fr_blast_armor = false;
;
}
}
if (((hp < lsthealth) && (sprite_index == spr_hurt))) {
{
if ((fr_blast_armor == true)) {
{
fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_create(x, y);
scrFRSoundPitchVolume(sndGruntFire, (0.4 + scrFRSourceRandom(0.2)), 0.6);
}
}
fr_blast_armor = false;
;
}
} else {
{
fr_blast_armor = true;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentSharpTeeth.skill.gml:41
function fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentSharpTeeth"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprGreenRadius : global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprRadius));
;
depth = (- 10);
;
image_xscale = 0;
;
image_yscale = 0;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
team = creator.team;
;
typ = 0;
;
on_anim = fr_Mutations_AugmentSharpTeeth_skill_gml_nothing;
;
on_end_step = fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_endstep;
;
on_wall = fr_Mutations_AugmentSharpTeeth_skill_gml_nothing;
;
on_hit = fr_Mutations_AugmentSharpTeeth_skill_gml_nothing;
;
on_projectile = fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_nullify;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentSharpTeeth.skill.gml:61
function fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_endstep() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_endstep_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_endstep_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_endstep");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentSharpTeeth.skill.gml:74
_fr.result=undefined; _fr.done=true; return;
break;
case 2: // Mutations/AugmentSharpTeeth.skill.gml:72
{
;
scrFRInstanceDestroy();
;
}
_fr.pc=1;
break;
case 3: // Mutations/AugmentSharpTeeth.skill.gml:72
_fr.wait_ticks=max(0,1); _fr.pc=2; return;
break;
case 4: // Mutations/AugmentSharpTeeth.skill.gml:71
_fr.pc = ((image_xscale >= 1)) ? 3 : 0;
break;
case 5: // Mutations/AugmentSharpTeeth.skill.gml:62
{
if (scrFRInstanceExists(creator)) {
{
x = creator.x;
;
y = creator.y;
;
}
}
image_xscale += ((0.1 / scrFRGetSkill("AugmentSharpTeeth")) * scrFRSourceScale());
;
image_yscale = image_xscale;
;
image_alpha -= ((0.1 / scrFRGetSkill("AugmentSharpTeeth")) * scrFRSourceScale());
;
}
_fr.pc=4;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentSharpTeeth.skill.gml:77
function fr_Mutations_AugmentSharpTeeth_skill_gml_NullRadius_nullify() {
if ((scrFRInstanceExists(scrFRSelf(self)) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRSoundPitchVolume(sndPickupDisappear, (1.3 + scrFRSourceRandom(0.2)), 0.4);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentSharpTeeth"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprGreenNull : global.fr_module_vars[$ "skill:AugmentSharpTeeth"].sprNull));
;
}
}
if(__fr_break6) break;
}}
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Mutations/AugmentSharpTeeth.skill.gml:88
function fr_Mutations_AugmentSharpTeeth_skill_gml_nothing() {

}
