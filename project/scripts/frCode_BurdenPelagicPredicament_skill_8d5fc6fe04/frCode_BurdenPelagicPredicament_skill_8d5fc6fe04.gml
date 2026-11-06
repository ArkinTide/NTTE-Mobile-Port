#macro frMacro_Mutations_BurdenPelagicPredicament_skill_gml_scr global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].scr

#macro frMacro_Mutations_BurdenPelagicPredicament_skill_gml_call scrFRScriptCall

// Original Mutations/BurdenPelagicPredicament.skill.gml:1
function fr_Mutations_BurdenPelagicPredicament_skill_gml___load() {

}

// Original Mutations/BurdenPelagicPredicament.skill.gml:1
function fr_Mutations_BurdenPelagicPredicament_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_BurdenPelagicPredicament_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_BurdenPelagicPredicament_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_BurdenPelagicPredicament_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/BurdenPelagicPredicament.skill.gml:25
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "BurdenPelagicPredicament", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/BurdenPelagicPredicament.skill.gml:24
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/BurdenPelagicPredicament.skill.gml:24
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/BurdenPelagicPredicament.skill.gml:24
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/BurdenPelagicPredicament.skill.gml:4
{
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprSkillIcon = sprFR_sprBurdenPelagicPredicam_d8be85ed1f90;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprSkillHud = sprFR_sprBurdenPelagicPredicam_fc6a5d58fa9f;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipe = sprFR_sprPelagicPipe_f6f66044edf3;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeHurt = sprFR_sprPelagicPipeHurt_7d748d2964e4;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeDead = sprFR_sprPelagicPipeDead_9b95c22a00e1;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeBottom = sprFR_sprPelagicPipeBottom_15cdb09be29e;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprCrabDeadClean = sprFR_sprCrabDeadClean_c463f2c49306;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmall = sprFR_sprPelagicBubbleSmall_851354ef2121;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmallPop = sprFR_sprPelagicBubbleSmallPop_21d67f941ac5;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleMed = sprFR_sprPelagicBubbleMed_f8062723d1e2;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBig = sprFR_sprPelagicBubbleBig_a4bedd984d47;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBigPop = sprFR_sprPelagicBubbleBigPop_da48e3795b43;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleShark = sprFR_sprPelagicBubbleShark_dfaf5b134797;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].settingPelagicBubbles = true;
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].settingVeeOneHundred = (1 > 0);
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/BurdenPelagicPredicament.skill.gml:29
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:BurdenOcean:0", "PELAGIC PREDICAMENT"));
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:30
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:BurdenOcean:1", "@q@(color:13160785)THE SEA CALLS"));
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:31
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_tip() {
return scrFRLocalize("SOMETHING SMELLS FISHY");
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:32
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprSkillIcon);
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:33
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprSkillHud;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:34
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_avail() {
return 0;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:35
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:36
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:37
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_burden() {
return true;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:39
function fr_Mutations_BurdenPelagicPredicament_skill_gml_skill_take() {
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].level_start = false;
;
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:42
function fr_Mutations_BurdenPelagicPredicament_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].level_start = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].level_start) {
{
var _frl__normalArea = (((((GameCont.hard > 1) && (scrFRInstanceNumber(enemy) > scrFRInstanceNumber(HostileHorror))) && (! (GameCont.area == scrFRAreaTryResolve("deeplabs")))) && (GameCont.area != scrFRAreaTryResolve("village"))) && (GameCont.area != scrFRAreaTryResolve("cyberspace")));
;
global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].level_start = false;
;
if ((_frl__normalArea || (GameCont.area == scrFRAreaTryResolve("devzone")))) {
{
var _frl__spawns = scrFRSourceRandomRange((- 3), (3 * scrFRGetSkill("BurdenPelagicPredicament")));
;
repeat (_frl__spawns) {
{ var __fr_with1 = scrFRWithValues(frMacro_Mutations_BurdenPelagicPredicament_skill_gml_call(frMacro_Mutations_BurdenPelagicPredicament_skill_gml_scr.instance_random, scrFRMatching(Floor, "object_index", Floor))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((((! scrFRPlaceMeeting(x, y, prop)) && (! scrFRPlaceMeeting(x, y, chestprop))) && (point_distance(x, y, 10000, 10000) > 128))) {
{
scrFRSoundPitchVolume(sndOasisExplosionSmall, (0.4 + scrFRSourceRandom(0.3)), 1);
fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicProp_create((x + 16), (y + 16));
;
{ var __fr_with4 = scrFRWithValues(Player), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
repeat (5) {
scrFRInstanceCreate(x, y, Bubble);
;
}
}
}
if(__fr_break6) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}
if ((global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].settingPelagicBubbles == true)) {
{
if (((_frl__spawns > 0) && (fr_Mutations_BurdenPelagicPredicament_skill_gml_area_get_underwater(GameCont.area) == false))) {
{
fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemyController_create(10016, 10016);
;
}
}
}
}
}
}
}
}
}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:78
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicProp_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
frMacro_Mutations_BurdenPelagicPredicament_skill_gml_call(frMacro_Mutations_BurdenPelagicPredicament_skill_gml_scr.floor_fill, x, y, 3, 3, "");
repeat ((3 + (GameCont.hard / 3))) {
fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemies_spawn(x, y);
}
name = "fr_pelagicprop";
spr_idle = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipe;
;
spr_hurt = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeHurt;
;
spr_dead = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeDead;
;
spr_shadow = shd24;
snd_hurt = sndHitMetal;
;
snd_dead = sndSewerPipeBreak;
;
scrFRMaxHealthWrite(id, 12, "=");
;
hp = max_hp;
;
team = 1;
;
on_step = fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicProp_step;
;
fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicBottom_create(x, y, image_xscale);
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:114
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicBottom_create(_frl__x=undefined, _frl__y=undefined, _frl__flip=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_pelagicbottom";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicPipeBottom);
;
image_blend = ((global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].settingVeeOneHundred == true) ? scrAreaGetBackroundColor(GameCont.area) : (scrFRSourceAreaIsString(GameCont.area) ? scrFRBackgroundColour() : scrAreaGetBackroundColor(GameCont.area)));
;
image_xscale = _frl__flip;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:125
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicProp_step() {
if ((scrFRSourceRandom(40) < 1)) {
{
scrFRInstanceCreate(x, y, Bubble);
}
}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:130
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemies_spawn(_frl__x=undefined, _frl__y=undefined) {
var _frl__creechure = frMacro_Mutations_BurdenPelagicPredicament_skill_gml_call(frMacro_Mutations_BurdenPelagicPredicament_skill_gml_scr.pool, [["BoneFish", 6], ["Crab", 1], ["Whale", (0.6 * (GameCont.hard >= 10))], ["Moby", (0.1 * (GameCont.hard >= 14))], ["Starfish", (1 * (GameCont.hard >= 7))], ["Elite Starfish", (1 * (GameCont.hard >= 10))], ["Puffer", ((1.5 * (GameCont.hard >= 5)) * scrFRModLoaded("mod", "ntte"))], ["HammerShark", ((0.3 * (GameCont.hard >= 18)) * scrFRModLoaded("mod", "ntte"))], ["Eel", ((2 * (GameCont.hard >= 10)) * scrFRModLoaded("mod", "ntte"))], ["Jelly", ((1 * (GameCont.hard >= 11)) * scrFRModLoaded("mod", "ntte"))], ["Elite Jelly", ((0.4 * (GameCont.hard >= 18)) * scrFRModLoaded("mod", "ntte"))]]);
{ var __fr_switch_value1=_frl__creechure, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("BoneFish")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Crab")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Whale")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Moby")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Starfish")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Elite Starfish")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Puffer")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("HammerShark")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Eel")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Jelly")) __fr_switch_case2=9;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Elite Jelly")) __fr_switch_case2=10;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
{
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, y, BoneFish)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmall;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmallPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 30);
;
}
}
if(__fr_break5) break;
}}
break;
;
}
case 1:
{
{ var __fr_with6 = scrFRWithValues(scrFRInstanceCreate(x, y, Crab)), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
spr_dead = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprCrabDeadClean;
;
}
}
if(__fr_break8) break;
}}
break;
;
}
case 2:
{
scrFRModCall("mod", "Frontier_Caves", "Whale_create", x, y);
;
break;
;
}
case 3:
{
scrFRModCall("mod", "Frontier_Caves", "EliteWhale_create", x, y);
;
break;
;
}
case 4:
{
scrFRModCall("mod", "Frontier_Caves", "Starfish_create", x, y);
;
break;
;
}
case 5:
{
scrFRModCall("mod", "Frontier_Caves", "EliteStarfish_create", x, y);
;
break;
;
}
case 6:
{
{ var __fr_with9 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "Puffer")), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleMed;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmallPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 30);
;
}
}
if(__fr_break11) break;
}}
break;
;
}
case 7:
{
{ var __fr_with12 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "HammerShark")), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleShark;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBigPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 22);
;
}
}
if(__fr_break14) break;
}}
break;
;
}
case 8:
{
{ var __fr_with15 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "Eel")), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmall;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleSmallPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 30);
;
}
}
if(__fr_break17) break;
}}
break;
;
}
case 9:
{
{ var __fr_with18 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "Jelly")), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBig;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBigPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 30);
;
}
}
if(__fr_break20) break;
}}
break;
;
}
case 10:
{
{ var __fr_with21 = scrFRWithValues(scrFRModCall("mod", "telib", "obj_create", x, y, "JellyElite")), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
spr_pelagicbubble = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBig;
;
spr_pelagicbubblepop = global.fr_module_vars[$ "skill:BurdenPelagicPredicament"].sprPelagicBubbleBigPop;
;
spr_pelagicbubble_tiltspeed = scrFRSourceRandomRange(0.15, 0.3);
;
spr_pelagicbubble_tiltrange = scrFRSourceRandomRange(18, 30);
;
}
}
if(__fr_break23) break;
}}
break;
;
}
}
}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:226
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemyController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_pelagiccontroller";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
on_end_step = fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemyController_endstep;
;
scrFRBindDraw(fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicBubble_draw, (- 3));
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:237
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicEnemyController_endstep() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(enemy, "spr_pelagicbubble", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSourceRandom(100) < 1)) {
{
scrFRInstanceCreate((x + scrFRSourceRandomRange(((- sprite_width) / 2), (sprite_width / 2))), (y + scrFRSourceRandomRange(((- sprite_height) / 2), (sprite_height / 2))), Bubble);
}
}
if ((hp <= 0)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, NTTEFullBubblePop)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_pelagicbubblepop);
;
}
}
if(__fr_break6) break;
}}
repeat (4) {
scrFRInstanceCreate(x, y, Bubble);
;
}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:252
function fr_Mutations_BurdenPelagicPredicament_skill_gml_PelagicBubble_draw() {
{ var __fr_with1 = scrFRWithValues(scrFRMatchingNE(enemy, "spr_pelagicbubble", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRDrawSpriteExt(spr_pelagicbubble, 0, x, y, image_xscale, image_yscale, (image_angle + (sin((scrFRSourceFrame() * spr_pelagicbubble_tiltspeed)) * spr_pelagicbubble_tiltrange)), c_white, 1);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/BurdenPelagicPredicament.skill.gml:257
function fr_Mutations_BurdenPelagicPredicament_skill_gml_area_get_underwater(_frl__area=undefined) {
if (scrFRSourceAreaIsString(_frl__area)) {
{
var _frl__scrt = "area_underwater";
;
if (scrFRScriptExists("area", _frl__area, _frl__scrt)) {
{
return scrFRModCall("area", _frl__area, _frl__scrt);
;
}
}
}
}
return (_frl__area == 101);
;
}
