#macro frMacro_Mutations_AugmentLastWish_skill_gml_scr global.fr_module_vars[$ "skill:AugmentLastWish"].scr

#macro frMacro_Mutations_AugmentLastWish_skill_gml_call scrFRScriptCall

// Original Mutations/AugmentLastWish.skill.gml:1
function fr_Mutations_AugmentLastWish_skill_gml___load() {

}

// Original Mutations/AugmentLastWish.skill.gml:1
function fr_Mutations_AugmentLastWish_skill_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Mutations_AugmentLastWish_skill_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_Mutations_AugmentLastWish_skill_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Mutations_AugmentLastWish_skill_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Mutations/AugmentLastWish.skill.gml:23
{
scrFRScriptCall(["mod", "lib", "getRef"], "skill", "AugmentLastWish", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
}
_fr.pc=0;
break;
case 3: // Mutations/AugmentLastWish.skill.gml:22
{
;
}
_fr.pc=2;
break;
case 4: // Mutations/AugmentLastWish.skill.gml:22
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Mutations/AugmentLastWish.skill.gml:22
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
case 5: // Mutations/AugmentLastWish.skill.gml:4
{
global.fr_module_vars[$ "skill:AugmentLastWish"].sprSkillIcon = sprFR_sprAugmentLastWish_7e3b95a11c0f;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].sprSkillHud = sprFR_sprAugmentLastWishIcon_2aa9e08615e4;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerChest = sprFR_sprRationerChest_34ac9316f52b;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerChestGlow = sprFR_sprRationerChestGlow_4a5be749852e;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerProc = sprFR_sprAugmentRationerProc_e4388abd817f;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].sprGreenRationerProc = sprFR_sprGreenAugmentRationerP_4f4ae2071dc1;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].procced = true;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].procTime = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].settingGreenAugments = false;
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Mutations/AugmentLastWish.skill.gml:27
function fr_Mutations_AugmentLastWish_skill_gml_skill_name() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLastWish:0", "RATIONER"));
;
}

// Original Mutations/AugmentLastWish.skill.gml:28
function fr_Mutations_AugmentLastWish_skill_gml_skill_text() {
return scrFRLocalize(scrFRLoc("Frontier:AugmentLastWish:1", "@(color:16776960)DUPLICATE @wAND @(color:16776960)STORE @wSOME#PICKUPS @sFOR THE @wNEXT @sLEVEL"));
;
}

// Original Mutations/AugmentLastWish.skill.gml:29
function fr_Mutations_AugmentLastWish_skill_gml_skill_tip() {
return scrFRLocalize("AMMO MANAGEMENT IS IMPORTANT!");
;
}

// Original Mutations/AugmentLastWish.skill.gml:30
function fr_Mutations_AugmentLastWish_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentLastWish"].sprSkillIcon);
;
}

// Original Mutations/AugmentLastWish.skill.gml:31
function fr_Mutations_AugmentLastWish_skill_gml_skill_icon() {
return global.fr_module_vars[$ "skill:AugmentLastWish"].sprSkillHud;
;
}

// Original Mutations/AugmentLastWish.skill.gml:32
function fr_Mutations_AugmentLastWish_skill_gml_skill_avail() {
return ((scrFRModGet("mod", "Frontier_IDPD", "settingMainPoolAugments") == true) ? 1 : 0);
;
}

// Original Mutations/AugmentLastWish.skill.gml:33
function fr_Mutations_AugmentLastWish_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/AugmentLastWish.skill.gml:34
function fr_Mutations_AugmentLastWish_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/AugmentLastWish.skill.gml:35
function fr_Mutations_AugmentLastWish_skill_gml_skill_augment() {
return mut_last_wish;
;
}

// Original Mutations/AugmentLastWish.skill.gml:37
function fr_Mutations_AugmentLastWish_skill_gml_game_start() {
global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups = 0;
;
}

// Original Mutations/AugmentLastWish.skill.gml:42
function fr_Mutations_AugmentLastWish_skill_gml_skill_lose() {
global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups = 0;
;
}

// Original Mutations/AugmentLastWish.skill.gml:47
function fr_Mutations_AugmentLastWish_skill_gml_step() {
if ((scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu))) {
{
global.fr_module_vars[$ "skill:AugmentLastWish"].level_start = true;
;
}
} else {
if (global.fr_module_vars[$ "skill:AugmentLastWish"].level_start) {
{
global.fr_module_vars[$ "skill:AugmentLastWish"].level_start = false;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].procced = false;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].procTime = 12;
;
}
}
}
if ((global.fr_module_vars[$ "skill:AugmentLastWish"].procTime > 0)) {
{
global.fr_module_vars[$ "skill:AugmentLastWish"].procTime -= scrFRSourceScale();
;
}
}
if (((global.fr_module_vars[$ "skill:AugmentLastWish"].procced == false) && (global.fr_module_vars[$ "skill:AugmentLastWish"].procTime <= 0))) {
{
global.fr_module_vars[$ "skill:AugmentLastWish"].procced = true;
{ var __fr_with1 = scrFRWithValues(frMacro_Mutations_AugmentLastWish_skill_gml_call(frMacro_Mutations_AugmentLastWish_skill_gml_scr.instance_random, Player)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups > 0)) {
{
{ var __fr_with4 = scrFRWithValues(fr_Mutations_AugmentLastWish_skill_gml_RationerChest_create(x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
{ var __fr_with7 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = scrFRSourceRandom(360);
;
speed = (2) * timescale;
zspeed = 4;
;
zfriction = 0.7;
;
var __fr_other10=scrFROther(other);
creator = __fr_other10;
;
var __fr_other11=scrFROther(other);
depth = __fr_other11.depth;
;
var __fr_other12=scrFROther(other);
mask_index = __fr_other12.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other13=scrFROther(other);
spr_shadow_y = __fr_other13.spr_shadow_y;
;
}
}
}
}
if(__fr_break9) break;
}}
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
}
{ var __fr_with14 = scrFRWithValues(scrFRMatching(HPPickup, "fr_rationer", undefined)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
fr_rationer = false;
;
}
}
if(__fr_break16) break;
}}
{ var __fr_with17 = scrFRWithValues(scrFRMatching(HPPickup, "fr_rationer", false)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
if (((distance_to_object(Player) < 12) || (distance_to_object(Portal) < 12))) {
{
fr_rationer = true;
;
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with20 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentLastWish"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentLastWish"].sprGreenRationerProc : global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerProc));
;
}
}
if(__fr_break22) break;
}}
global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups += 1;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups += 1;
;
}
}
}
}
}
}
if(__fr_break19) break;
}}
{ var __fr_with23 = scrFRWithValues(scrFRMatching(AmmoPickup, "fr_rationer", undefined)), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
fr_rationer = false;
;
}
}
if(__fr_break25) break;
}}
{ var __fr_with26 = scrFRWithValues(scrFRMatching(AmmoPickup, "fr_rationer", false)), __fr_break28=false;
for (var __fr_index27=0; __fr_index27<array_length(__fr_with26); ++__fr_index27) {
if(scrFRScopeExists(__fr_with26[__fr_index27])) with (__fr_with26[__fr_index27]) {
{
if ((distance_to_object(Player) < 12)) {
{
fr_rationer = true;
;
if ((scrFRSourceRandom(5) < 1)) {
{
{ var __fr_with29 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break31=false;
for (var __fr_index30=0; __fr_index30<array_length(__fr_with29); ++__fr_index30) {
if(scrFRScopeExists(__fr_with29[__fr_index30])) with (__fr_with29[__fr_index30]) {
{
sprite_index = scrFRAreaSourceSprite((global.fr_module_vars[$ "skill:AugmentLastWish"].settingGreenAugments ? global.fr_module_vars[$ "skill:AugmentLastWish"].sprGreenRationerProc : global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerProc));
;
}
}
if(__fr_break31) break;
}}
global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups += 1;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups += 1;
;
}
}
}
}
}
}
if(__fr_break28) break;
}}
}

// Original Mutations/AugmentLastWish.skill.gml:117
function fr_Mutations_AugmentLastWish_skill_gml_RationerChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerChest);
;
spr_glow = global.fr_module_vars[$ "skill:AugmentLastWish"].sprRationerChestGlow;
;
image_speed = (0) * timescale;
;
if ((global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups <= 10)) {
{
image_index = 0;
;
}
} else {
{
image_index = 1;
;
}
}
if ((global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups >= 50)) {
{
image_index = 2;
;
}
}
popTime = 45;
;
opened = false;
;
on_step = fr_Mutations_AugmentLastWish_skill_gml_RationerChest_step;
;
on_draw = fr_Mutations_AugmentLastWish_skill_gml_RationerChest_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Mutations/AugmentLastWish.skill.gml:143
function fr_Mutations_AugmentLastWish_skill_gml_RationerChest_step() {
if ((popTime > 0)) {
{
popTime -= scrFRSourceScale();
;
}
} else {
{
if ((opened == false)) {
{
opened = true;
;
repeat ((global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups * scrFRGetSkill("AugmentLastWish"))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), HPPickup)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_rationer = true;
;
}
}
if(__fr_break3) break;
}}
}
repeat ((global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups * scrFRGetSkill("AugmentLastWish"))) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 10), 10)), (y + scrFRSourceRandomRange((- 10), 10)), AmmoPickup)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_rationer = true;
;
}
}
if(__fr_break6) break;
}}
}
scrFRInstanceCreate(x, y, PortalClear);
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedHPPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedAmmoPickups = 0;
;
global.fr_module_vars[$ "skill:AugmentLastWish"].storedTotalPickups = 0;
;
scrFRSoundPitch(sndAmmoChest, 1.3);
;
scrFRSoundPitch(sndIDPDNadeAlmost, 1.3);
;
repeat (10) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Mutations/AugmentLastWish.skill.gml:182
function fr_Mutations_AugmentLastWish_skill_gml_RationerChest_draw() {
draw_self();
;
scrFRDrawSpriteExt(spr_glow, image_index, x, y, image_xscale, image_yscale, image_angle, make_colour_rgb(0, 255, 255), clamp((1 / popTime), 0, 1));
}
