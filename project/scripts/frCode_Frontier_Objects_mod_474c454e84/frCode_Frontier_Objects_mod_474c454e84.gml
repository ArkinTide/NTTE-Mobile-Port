#macro frMacro_Objects_Frontier_Objects_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Objects"].scr

#macro frMacro_Objects_Frontier_Objects_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Objects_mod_gml_burden_splashtexts scrFRSourceChoose("JINKIES!", "YIKES!", "UH OH!", "OH NO", "WOAH!", "EEK!", "AHH!!", "AIEEE!!!")

#macro frMacro_Objects_Frontier_Objects_mod_gml_anim_end scrFRAnimationEnd()

#macro frMacro_Objects_Frontier_Objects_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Objects_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Objects_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Objects_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Objects_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Objects_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Objects_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

// Original Objects/Frontier_Objects.mod.gml:1
function fr_Objects_Frontier_Objects_mod_gml___load() {

}

// Original Objects/Frontier_Objects.mod.gml:1
function fr_Objects_Frontier_Objects_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Objects_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Objects_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Objects_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Objects.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Objects", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatue = sprFR_sprOasisStatue_56ce1c1555a8;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueHurt = sprFR_sprOasisStatueHurt_cbf32506ef22;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueDead = sprFR_sprOasisStatueDead_30c48fbd07c1;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueActive = sprFR_sprOasisStatueActive_a2c004051c4f;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisDust = sprFR_sprOasisDust_72a7dc09ace3;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisSparkle = sprFR_sprOasisSparkle_541ac4fa645e;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].mskOasisStatuePrompt = sprFR_mskOasisStatuePrompt_13d49d15f99f;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchanger = sprFR_sprGoldExchanger_17270d850b5b;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerHurt = sprFR_sprGoldExchangerHurt_f2e31984e578;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerDead = sprFR_sprGoldExchangerDead_20154c1e009a;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerSwap = sprFR_sprGoldExchangerSwap_f29cc6c157f1;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprCarHeadlights = sprFR_sprCarHeadlights_e8a85c746d4b;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprCarLight = sprFR_sprCarLight_d19b20b4f56f;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sndCarHonk = sndFR_sndCarHonk_e2cc771d9261;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderIdle = sprFR_sprHoarderIdle_295dba9bd44a;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderWalk = sprFR_sprHoarderWalk_36b68cdca2b2;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderHurt = sprFR_sprHoarderHurt_86b5e1d667bb;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderDead = sprFR_sprHoarderDead_59778116c9b5;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderScare = sprFR_sprHoarderScare_787d79981bf4;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderSprint = sprFR_sprHoarderSprint_82e495d8003e;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderEscape = sprFR_sprHoarderEscape_ce324a90b9ff;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderBell = sprFR_sprHoarderBell_6cb673963379;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderLoop = sndFR_sndHoarderLoop_4e9890d921f8;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderStop = sndFR_sndHoarderStop_258e9dc50e34;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderJingle = [sndFR_sndHoarderJingle_bf21ca12a450, sndFR_sndHoarderJingle2_d7e9aa3139f7, sndFR_sndHoarderJingle3_cd922925da9d];
global.fr_module_vars[$ "mod:Frontier_Objects"].sprBurdenSparkle = sprFR_sprBurdenSparkle_37375f9adc8e;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSurgerySparkle = sprFR_sprSurgerySparkle_59097938db99;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprBetaSurgeryStation = sprFR_sprBetaSurgeryStation_1e3452007894;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBIcon = sprFR_sprPetSlaughterBIcon_c332d31a14e3;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBIdle = sprFR_sprPetSlaughterBIdle_7b78aa1b55ad;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBWalk = sprFR_sprPetSlaughterBWalk_4e58ff174282;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBHurt = sprFR_sprPetSlaughterBHurt_af17b74dd65f;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBDead = sprFR_sprPetSlaughterBDead_9732b4b95816;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBSpwn = sprFR_sprPetSlaughterBSpwn_3cedb5bb4cd3;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBBite = sprFR_sprPetSlaughterBBite_baeec56eebe1;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBTransform = sprFR_sprSlaughterBTransform_e27a8532fc35;
;
global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_example = [];
;
global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_example = scrFRArrayClone(array_create(128, undefined));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_example", [wep_double_shotgun], wep_double_flame_shotgun, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_example", [wep_shotgun], wep_flame_shotgun, "=");
global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_gold = [];
;
global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_gold = scrFRArrayClone(array_create(128, undefined));
;
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_revolver], wep_golden_revolver, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_wrench], wep_golden_wrench, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_machinegun], wep_golden_machinegun, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_shotgun], wep_golden_shotgun, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_crossbow], wep_golden_crossbow, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_grenade_launcher], wep_golden_grenade_launcher, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_laser_pistol], wep_golden_laser_pistol, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_plasma_gun], wep_golden_plasma_gun, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_slugger], wep_golden_slugger, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_splinter_gun], wep_golden_splinter_gun, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_screwdriver], wep_golden_screwdriver, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_bazooka], wep_golden_bazooka, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_assault_rifle], wep_golden_assault_rifle, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_nuke_launcher], wep_golden_nuke_launcher, "=");
scrFRMemberIndexWrite(global.fr_module_vars[$ "mod:Frontier_Objects"], "fr_exchange_gold", [wep_disc_gun], wep_golden_disc_gun, "=");
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Objects.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Objects.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Objects.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Objects.mod.gml:97
function fr_Objects_Frontier_Objects_mod_gml_ZAxisToss_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (- 2);
;
mask_index = mskPlayer;
;
spr_shadow_y = 0;
;
direction = scrFRSourceRandom(360);
;
friction = (0.1) * (timescale * timescale);
;
creator = noone;
;
z = 0;
;
zspeed = 8;
;
zfriction = 0.5;
;
team = (- 1);
;
portalGuy = false;
;
impactEffect = true;
;
on_end_step = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_ZAxisToss_end_step];
;
on_cleanup = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_ZAxisToss_cleanup];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:123
function fr_Objects_Frontier_Objects_mod_gml_ZAxisToss_end_step() {
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
if ((scrFRInstanceExists(creator) && ((z > 0) || (zspeed > 0)))) {
{
if ((scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall) || (distance_to_object(InvisiWall) < 16))) {
{
speed = (0) * timescale;
;
z += ((zspeed * scrFRSourceScale()) / 2);
}
} else {
{
speed = (clamp((speed / timescale), 2, 6)) * timescale;
;
}
}
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x = __fr_other4.x;
;
var __fr_other5=scrFROther(other);
y = (__fr_other5.y - __fr_other5.z);
;
mask_index = mskNone;
;
depth = (- 10);
;
if (scrFRInstanceIs(scrFRSelf(self), enemy)) {
{
canfly = true;
;
}
}
if (scrFRVariableExists(scrFRSelf(self), "spr_shadow_y")) {
{
var __fr_other6=scrFROther(other);
spr_shadow_y = (__fr_other6.spr_shadow_y + __fr_other6.z);
;
}
}
var _frl__ang = (point_direction(0, 0, ((scrFROther(other)).hspeed / timescale), (- (scrFROther(other)).zspeed)) - 90);
;
if (scrFRVariableExists(scrFRSelf(self), "angle")) {
{
angle = _frl__ang;
;
}
} else {
{
image_angle = _frl__ang;
;
}
}
if (((scrFROther(other)).portalGuy == true)) {
{
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 1;
;
if ((image_xscale < 1)) {
{
image_xscale += 0.1;
;
image_yscale = image_xscale;
;
}
}
}
}
}
}
if(__fr_break3) break;
}}
}
} else {
{
scrFRScriptCall(on_cleanup);
;
on_cleanup = [];
;
{ var __fr_with7 = scrFRWithValues(creator), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if ((scrFRInstanceIs(scrFRSelf(self), hitme) && (scrFRPlaceMeeting(x, y, Floor) || (GameCont.area != scrFRAreaTryResolve("coast"))))) {
{
{ var __fr_with10 = scrFRWithValues((scrFROther(other))), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
var __fr_other13=scrFROther(other);
scrFRProjectileHit(__fr_other13, 1);
;
}
}
if(__fr_break12) break;
}}
}
}
if (((scrFROther(other)).portalGuy == true)) {
{
if ((image_xscale < 1)) {
{
image_xscale = 1;
;
image_yscale = image_xscale;
;
}
}
}
}
if (((! scrFRPlaceMeeting(x, y, Floor)) || scrFRPlaceMeeting(x, y, Wall))) {
{
scrFRInstanceCreate(x, y, PortalClear);
}
}
}
}
if(__fr_break9) break;
}}
if ((impactEffect == true)) {
{
repeat ((5 + scrFRVariableGet(creator, "size", 0))) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
scrFRMotionAdd(scrFRSourceRandom(360), 3);
;
var __fr_other17=scrFROther(other);
scrFRMotionAdd(__fr_other17.direction, 1);
;
}
}
if(__fr_break16) break;
}}
}
}
}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Objects.mod.gml:218
function fr_Objects_Frontier_Objects_mod_gml_ZAxisToss_cleanup() {
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
mask_index = __fr_other4.mask_index;
;
var __fr_other5=scrFROther(other);
depth = __fr_other5.depth;
;
if (scrFRVariableExists(scrFRSelf(self), "spr_shadow_y")) {
var __fr_other6=scrFROther(other);
spr_shadow_y = __fr_other6.spr_shadow_y;
}
if (scrFRVariableExists(scrFRSelf(self), "angle")) {
angle = 0;
} else {
image_angle = 0;
}
;
if ((scrFRInstanceIs(scrFRSelf(self), enemy) && scrFRPlaceMeeting(x, y, Floor))) {
{
canfly = false;
;
}
}
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:231
function fr_Objects_Frontier_Objects_mod_gml_ZAxisWeaponToss_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (- 2);
;
mask_index = mskPlayer;
;
spr_shadow_y = 0;
;
direction = scrFRSourceRandom(360);
;
friction = (0.1) * (timescale * timescale);
;
creator = noone;
;
z = 0;
;
zspeed = 8;
;
zfriction = 0.5;
;
team = (- 1);
;
impactEffect = true;
;
landangle = scrFRSourceRandom(360);
;
on_end_step = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_ZAxisWeaponToss_end_step];
;
on_cleanup = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_ZAxisWeaponToss_cleanup];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:257
function fr_Objects_Frontier_Objects_mod_gml_ZAxisWeaponToss_end_step() {
z += (zspeed * scrFRSourceScale());
;
zspeed -= (zfriction * scrFRSourceScale());
;
if ((scrFRInstanceExists(creator) && ((z > 0) || (zspeed > 0)))) {
{
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall)) {
{
speed = (0) * timescale;
;
z += ((zspeed * scrFRSourceScale()) / 2);
}
} else {
{
speed = (clamp((speed / timescale), 2, 6)) * timescale;
;
}
}
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
x = __fr_other4.x;
;
var __fr_other5=scrFROther(other);
y = (__fr_other5.y - __fr_other5.z);
;
mask_index = mskNone;
;
depth = (- 10);
;
var _frl__ang = (point_direction(0, 0, ((scrFROther(other)).hspeed / timescale), (- (scrFROther(other)).zspeed)) - (scrFROther(other)).landangle);
;
rotation = _frl__ang;
;
}
}
if(__fr_break3) break;
}}
}
} else {
{
scrFRScriptCall(on_cleanup);
;
on_cleanup = [];
;
{ var __fr_with6 = scrFRWithValues(creator), __fr_break8=false;
for (var __fr_index7=0; __fr_index7<array_length(__fr_with6); ++__fr_index7) {
if(scrFRScopeExists(__fr_with6[__fr_index7])) with (__fr_with6[__fr_index7]) {
{
if (((! scrFRPlaceMeeting(x, y, Floor)) || scrFRPlaceMeeting(x, y, Wall))) {
{
scrFRInstanceCreate(x, y, PortalClear);
}
}
}
}
if(__fr_break8) break;
}}
if ((impactEffect == true)) {
{
repeat (5) {
{ var __fr_with9 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
scrFRMotionAdd(scrFRSourceRandom(360), 3);
;
var __fr_other12=scrFROther(other);
scrFRMotionAdd(__fr_other12.direction, 1);
;
}
}
if(__fr_break11) break;
}}
}
}
}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Objects.mod.gml:312
function fr_Objects_Frontier_Objects_mod_gml_ZAxisWeaponToss_cleanup() {
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
mask_index = __fr_other4.mask_index;
;
var __fr_other5=scrFROther(other);
depth = __fr_other5.depth;
;
if (scrFRVariableExists(scrFRSelf(self), "spr_shadow_y")) {
var __fr_other6=scrFROther(other);
spr_shadow_y = __fr_other6.spr_shadow_y;
}
if (scrFRVariableExists(scrFRSelf(self), "angle")) {
angle = 0;
} else {
image_angle = 0;
}
;
if ((scrFRInstanceIs(scrFRSelf(self), enemy) && scrFRPlaceMeeting(x, y, Floor))) {
{
canfly = false;
;
}
}
}
}
if(__fr_break3) break;
}}
; // macro hoisted: burden_splashtexts
}

// Original Objects/Frontier_Objects.mod.gml:326
function fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_create(_frl__x=undefined, _frl__y=undefined, _frl__text=undefined, _frl__subtext=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_popup";
depth = (- 1000);
;
image_angle = 0;
;
mytext = scrFRLocalize(_frl__text);
;
text_color = c_white;
;
lifetime = 100;
;
shake = 6;
;
subtext = _frl__subtext;
;
sub_color = c_white;
;
sub_lifetime = 80;
;
sub_shake = 6;
;
sub_sound = sndRecGlandProc;
sub_sound_pitch = 1.75;
;
on_draw = fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_draw;
;
on_step = fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:355
function fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_step() {
lifetime -= scrFRSourceScale();
shake = max((shake - scrFRSourceScale()), 0);
if ((lifetime < sub_lifetime)) {
{
sub_shake = max((sub_shake - scrFRSourceScale()), 0);
if ((sub_shake == (6 - scrFRSourceScale()))) {
{
scrFRSoundPitch(sub_sound, sub_sound_pitch);
;
}
}
}
}
if ((lifetime <= 0)) {
scrFRInstanceDestroy();
}
}

// Original Objects/Frontier_Objects.mod.gml:370
function fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_draw() {
var _frl_align = draw_get_halign();
draw_set_halign(1);
if (((lifetime > 30) or ((lifetime mod 3) < 2))) {
{
fr_Objects_Frontier_Objects_mod_gml_draw_text_tilt_shadow((x + scrFRSourceRandom(shake)), (y + scrFRSourceRandom(shake)), mytext, image_angle, text_color);
if ((lifetime < sub_lifetime)) {
{
fr_Objects_Frontier_Objects_mod_gml_draw_text_tilt_shadow(((x + scrFRSourceRandom(sub_shake)) + lengthdir_x(8, (image_angle - 90))), ((y + scrFRSourceRandom(sub_shake)) + lengthdir_y(8, (image_angle - 90))), subtext, image_angle, sub_color);
}
}
}
}
draw_set_halign(_frl_align);
}

// Original Objects/Frontier_Objects.mod.gml:382
function fr_Objects_Frontier_Objects_mod_gml_draw_text_tilt_shadow(_frl_x=undefined, _frl_y=undefined, _frl_str=undefined, _frl_angle=undefined, _frl_color=undefined) {
scrFRDrawTextTransformedColor((_frl_x + 1), (_frl_y + 1), _frl_str, 1, 1, _frl_angle, c_black, c_black, c_black, c_black, 1);
scrFRDrawTextTransformedColor(_frl_x, _frl_y, _frl_str, 1, 1, _frl_angle, _frl_color, _frl_color, _frl_color, _frl_color, 1);
}

// Original Objects/Frontier_Objects.mod.gml:386
function fr_Objects_Frontier_Objects_mod_gml_SpecialPopupTextJinkies_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_create(_frl__x, _frl__y, "", frMacro_Objects_Frontier_Objects_mod_gml_burden_splashtexts)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sub_lifetime = 60;
;
image_angle = 5;
;
sub_color = c_gray;
;
sub_sound_pitch = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:396
function fr_Objects_Frontier_Objects_mod_gml_OasisStatue_create(_frl__x=undefined, _frl__y=undefined, _frl__level=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProp)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_OasisStatue";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatue;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueDead;
;
spr_active = global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisStatueActive;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_shadow = mskNone;
;
image_speed = (0.4) * timescale;
;
right = 1;
;
image_xscale = 1;
;
snd_hurt = sndOasisHurt;
;
snd_dead = sndOasisExplosionSmall;
;
hard_level = _frl__level;
;
activated = false;
;
mytext = scrFRLocalize(scrFRLoc("Frontier:OceanStatuePrompt", "ACTIVATE?"));
;
use_text = scrFRLoc("Frontier:OceanStatueText:0", "DIFFICULTY LEVEL");
;
use_subtext = scrFRLoc("Frontier:OceanStatueText:1", "RESTORED");
;
burden_text = scrFRLoc("Frontier:OceanStatueText:2", "BURDENED WITH");
;
burden_subtext = scrFRLoc("Frontier:OceanStatueText:3", "PELAGIC#PREDICAMENT");
;
pick = (- 1);
;
scrFRMaxHealthWrite(id, 200, "=");
;
hp = max_hp;
;
VAGGYBONDESPLSNOSHOOT = true;
;
giveDifficulty = (scrFRModLoaded("area", "oasis") ? false : true);
;
if ((activated == true)) {
{
spr_idle = spr_active;
}
}
on_step = fr_Objects_Frontier_Objects_mod_gml_OasisStatue_step;
;
on_hurt = fr_Objects_Frontier_Objects_mod_gml_Prop_hurt;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
mask_index = global.fr_module_vars[$ "mod:Frontier_Objects"].mskOasisStatuePrompt;
;
on_step = fr_Objects_Frontier_Objects_mod_gml_OasisStatuePrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:445
function fr_Objects_Frontier_Objects_mod_gml_OasisStatuePrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = 1;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
if ((creator.activated == true)) {
{
scrFRInstanceDestroy();
}
}
}

// Original Objects/Frontier_Objects.mod.gml:450
function fr_Objects_Frontier_Objects_mod_gml_OasisStatue_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (frMacro_Objects_Frontier_Objects_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + 8), (y - 3), Bubble)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
friction = (0.2) * (timescale * timescale);
;
scrFRMotionSet((90 + scrFRSourceRandomRange((- 5), 5)), scrFRSourceRandomRange(3, 5));
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + 6), (y - 10), Bubble)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
friction = (0.2) * (timescale * timescale);
;
scrFRMotionSet((90 + scrFRSourceRandomRange((- 5), 5)), scrFRSourceRandomRange(3, 5));
;
}
}
if(__fr_break6) break;
}}
}
}
if ((scrFRSourceRandom(15) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x - 20), (y - 9), Bubble)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
friction = (0.2) * (timescale * timescale);
;
scrFRMotionSet((90 + scrFRSourceRandomRange((- 5), 5)), scrFRSourceRandomRange(3, 5));
;
}
}
if(__fr_break9) break;
}}
}
}
if (((pick != (- 1)) and (activated == false))) {
{
activated = true;
;
spr_idle = spr_active;
;
scrFRViewShakeAt(x, y, 100);
repeat (20) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Bubble)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(5)) * timescale;
;
}
}
if(__fr_break12) break;
}}
}
repeat (20) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 30), 30)), (y + scrFRSourceRandomRange((- 20), 20)), CaveSparkle)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisSparkle);
;
image_angle = scrFRSourceRandom(360);
;
}
}
if(__fr_break15) break;
}}
}
repeat (20) {
{ var __fr_with16 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 35), 30)), (y + 13), Smoke)), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(2)) * timescale;
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprOasisDust);
}
}
if(__fr_break18) break;
}}
}
scrFRSoundPitchVolume(sndStrongSpiritLost, 0.7, 1);
scrFRSoundPitchVolume(sndOasisBossMelee, 0.6, 1);
if ((giveDifficulty == true)) {
{
GameCont.hard += hard_level;
;
{ var __fr_with19 = scrFRWithValues(fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_create(x, (y - 60), use_text, use_subtext)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
sub_lifetime = 100;
;
sub_color = make_colour_rgb(81, 209, 200);
;
}
}
if(__fr_break21) break;
}}
}
}
if ((! scrFRGetSkill("BurdenPelagicPredicament"))) {
{
{ var __fr_with22 = scrFRWithValues(fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_create(x, (y - 40), burden_text, burden_subtext)), __fr_break24=false;
for (var __fr_index23=0; __fr_index23<array_length(__fr_with22); ++__fr_index23) {
if(scrFRScopeExists(__fr_with22[__fr_index23])) with (__fr_with22[__fr_index23]) {
{
sub_color = make_colour_rgb(81, 209, 200);
;
sub_sound = sndCursedReminder;
;
}
}
if(__fr_break24) break;
}}
{ var __fr_with25 = scrFRWithValues(fr_Objects_Frontier_Objects_mod_gml_SpecialPopupText_create((x + 50), (y - 25), "", frMacro_Objects_Frontier_Objects_mod_gml_burden_splashtexts)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
sub_lifetime = 60;
;
image_angle = 5;
;
sub_color = c_gray;
;
sub_sound_pitch = 0;
;
}
}
if(__fr_break27) break;
}}
scrFRSetSkill("BurdenPelagicPredicament", 1);
{ var __fr_with28 = scrFRWithValues(Player), __fr_break30=false;
for (var __fr_index29=0; __fr_index29<array_length(__fr_with28); ++__fr_index29) {
if(scrFRScopeExists(__fr_with28[__fr_index29])) with (__fr_with28[__fr_index29]) {
{
{ var __fr_with31 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break33=false;
for (var __fr_index32=0; __fr_index32<array_length(__fr_with31); ++__fr_index32) {
if(scrFRScopeExists(__fr_with31[__fr_index32])) with (__fr_with31[__fr_index32]) {
{
image_blend = make_colour_rgb(136, 86, 180);
;
depth = (- 3);
;
}
}
if(__fr_break33) break;
}}
repeat (8) {
{ var __fr_with34 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), BulletHit)), __fr_break36=false;
for (var __fr_index35=0; __fr_index35<array_length(__fr_with34); ++__fr_index35) {
if(scrFRScopeExists(__fr_with34[__fr_index35])) with (__fr_with34[__fr_index35]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprBurdenSparkle);
;
image_index = scrFRSourceChoose(0, 1);
;
image_xscale = scrFRSourceRandomRange(0.5, 1);
;
image_yscale = image_xscale;
;
direction = (90 + scrFRSourceRandomRange((- 32), 32));
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break36) break;
}}
}
}
}
if(__fr_break30) break;
}}
}
}
}
}
if ((! scrFRInstanceExists(scrFRSelf(self)))) {
{
exit;
;
}
}
if ((hp <= 0)) {
{
{ var __fr_with37 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break39=false;
for (var __fr_index38=0; __fr_index38<array_length(__fr_with37); ++__fr_index38) {
if(scrFRScopeExists(__fr_with37[__fr_index38])) with (__fr_with37[__fr_index38]) {
{
var __fr_other40=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other40.spr_dead);
;
var __fr_other41=scrFROther(other);
image_xscale = __fr_other41.image_xscale;
;
var __fr_other42=scrFROther(other);
size = __fr_other42.size;
;
}
}
if(__fr_break39) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Objects.mod.gml:540
function fr_Objects_Frontier_Objects_mod_gml_weapon_can_exchange(_frl__wep=undefined, _frl__array=undefined) {
return (((is_real(_frl__wep) && (floor(_frl__wep) == _frl__wep)) && (_frl__wep < 128)) && (scrFRIndexGet(_frl__array, _frl__wep) != undefined));
;
}

// Original Objects/Frontier_Objects.mod.gml:543
function fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = 1;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((! scrFRInstanceExists(creator))) {
{
exit;
;
}
}
if ((creator.can_swap == false)) {
{
scrFRInstanceDestroy();
}
}
}

// Original Objects/Frontier_Objects.mod.gml:556
function fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GoldExchanger";
;
var _frl_me = scrFRSelf(self);
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchanger;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerDead;
;
spr_swap = global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchangerSwap;
;
spr_deny = global.fr_module_vars[$ "mod:Frontier_Objects"].sprGoldExchanger;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
spr_shadow = shd64;
;
spr_shadow_y = 6;
;
image_speed = (0.4) * timescale;
;
depth = 0;
;
snd_hurt = sndHitMetal;
;
snd_dead = sndComputerBreak;
;
mytext = scrFRLocalize("@(color:3844043)EXCHANGE#@wWEAPON?");
;
pick = (- 1);
;
targetplayer = noone;
;
playerwep = noone;
;
outputwep = noone;
;
validwep = true;
;
can_swap = true;
;
scrFRMaxHealthWrite(id, 200, "=");
;
hp = max_hp;
;
team = 0;
;
VAGGYBONDESPLSNOSHOOT = true;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerPrompt_step;
;
creator = _frl_me;
;
}
}
if(__fr_break6) break;
}}
on_step = fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_step;
;
on_hurt = fr_Objects_Frontier_Objects_mod_gml_Prop_hurt;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:602
function fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_step() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_step_resume, id, scrFROther(other), _args, 14, []);
}
function fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_step_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerGold_step");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Objects.mod.gml:713
{
if ((hp <= 0)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
var __fr_other5=scrFROther(other);
image_xscale = __fr_other5.image_xscale;
;
var __fr_other6=scrFROther(other);
size = __fr_other6.size;
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
_fr.pc=0;
break;
case 2: // Objects/Frontier_Objects.mod.gml:712
{
;
}
_fr.pc=1;
break;
case 3: // Objects/Frontier_Objects.mod.gml:712
_fr.result=undefined; _fr.done=true; return;
break;
case 4: // Objects/Frontier_Objects.mod.gml:712
_fr.pc = ((! scrFRInstanceExists(scrFRSelf(_fr.scope)))) ? 3 : 1;
break;
case 5: // Objects/Frontier_Objects.mod.gml:677
{
if ((validwep == true)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, WepPickup)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
scrFRWeaponSlotWrite(scrFRSelf(self), "wep", __fr_other10.outputwep);
;
direction = 270;
;
speed = (6) * timescale;
;
repeat (15) {
{ var __fr_with11 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break13=false;
for (var __fr_index12=0; __fr_index12<array_length(__fr_with11); ++__fr_index12) {
if(scrFRScopeExists(__fr_with11[__fr_index12])) with (__fr_with11[__fr_index12]) {
{
direction = (270 + scrFRSourceRandomRange((- 70), 70));
;
image_angle = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
depth = (- 2);
;
}
}
if(__fr_break13) break;
}}
}
repeat (15) {
{ var __fr_with14 = scrFRWithValues(scrFRInstanceCreate(x, y, Feather)), __fr_break16=false;
for (var __fr_index15=0; __fr_index15<array_length(__fr_with14); ++__fr_index15) {
if(scrFRScopeExists(__fr_with14[__fr_index15])) with (__fr_with14[__fr_index15]) {
{
sprite_index = scrFRAreaSourceSprite(sprMoney);
;
image_angle = scrFRSourceRandom(360);
;
scrFRMotionSet(scrFRSourceRandom(360), scrFRSourceRandomRange(2, 4));
;
}
}
if(__fr_break16) break;
}}
}
}
}
if(__fr_break9) break;
}}
}
}
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
can_swap = true;
;
pick = (- 1);
;
{ var __fr_with17 = scrFRWithValues(frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.prompt_create, mytext)), __fr_break19=false;
for (var __fr_index18=0; __fr_index18<array_length(__fr_with17); ++__fr_index18) {
if(scrFRScopeExists(__fr_with17[__fr_index18])) with (__fr_with17[__fr_index18]) {
{
on_step = fr_Objects_Frontier_Objects_mod_gml_WeaponExchangerPrompt_step;
;
creator = _fr.vars.me;
;
}
}
if(__fr_break19) break;
}}
}
_fr.pc=4;
break;
case 6: // Objects/Frontier_Objects.mod.gml:674
_fr.wait_ticks=max(0,(image_number / (image_speed / timescale))); _fr.pc=5; return;
break;
case 7: // Objects/Frontier_Objects.mod.gml:626
{
validwep = false;
;
can_swap = false;
;
if ((((!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(targetplayer, "wep"), 0)) and fr_Objects_Frontier_Objects_mod_gml_weapon_can_exchange(playerwep, global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_gold)) or (is_string(playerwep) and scrFRScriptExists("weapon", playerwep, "wep_exchange_gold")))) {
{
sprite_index = scrFRAreaSourceSprite(spr_swap);
;
scrFRWeaponSlotWrite(targetplayer, "wep", wep_none);
;
validwep = true;
;
{ var __fr_with20 = scrFRWithValues(targetplayer), __fr_break22=false;
for (var __fr_index21=0; __fr_index21<array_length(__fr_with20); ++__fr_index21) {
if(scrFRScopeExists(__fr_with20[__fr_index21])) with (__fr_with20[__fr_index21]) {
{
fr_Objects_Frontier_Objects_mod_gml_player_swap(scrFRSelf(self));
swapmove = true;
;
drawempty = 30;
;
}
}
if(__fr_break22) break;
}}
if (is_string(playerwep)) {
{
if (scrFRScriptExists("weapon", playerwep, "wep_exchange_gold")) {
{
outputwep = scrFRModCall("weapon", playerwep, "wep_exchange_gold");
}
}
}
} else {
{
outputwep = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Objects"].fr_exchange_gold, playerwep);
}
}
scrFRSoundPitchVolume(sndGoldUnlock, 1.2, 2);
;
}
} else {
{
scrFRSoundPitchVolume(sndVanHurt, 1.2, 1);
;
scrFRSoundPitchVolume(sndExplosionS, 1.8, 0.6);
repeat (5) {
{ var __fr_with23 = scrFRWithValues(scrFRInstanceCreate(x, y, Smoke)), __fr_break25=false;
for (var __fr_index24=0; __fr_index24<array_length(__fr_with23); ++__fr_index24) {
if(scrFRScopeExists(__fr_with23[__fr_index24])) with (__fr_with23[__fr_index24]) {
{
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break25) break;
}}
}
sprite_index = scrFRAreaSourceSprite(spr_deny);
validwep = false;
;
{ var __fr_with26 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, PopupText)), __fr_break28=false;
for (var __fr_index27=0; __fr_index27<array_length(__fr_with26); ++__fr_index27) {
if(scrFRScopeExists(__fr_with26[__fr_index27])) with (__fr_with26[__fr_index27]) {
{
mytext = scrFRLocalize("NOT VENUZ#APPROVED!");
}
}
if(__fr_break28) break;
}}
}
}
}
_fr.pc=6;
break;
case 8: // Objects/Frontier_Objects.mod.gml:624
{
;
}
_fr.pc=7;
break;
case 9: // Objects/Frontier_Objects.mod.gml:624
_fr.result=undefined; _fr.done=true; return;
break;
case 10: // Objects/Frontier_Objects.mod.gml:622
{
scrFRSoundPlay(sndCursedReminder);
;
pick = (- 1);
;
}
_fr.pc=9;
break;
case 11: // Objects/Frontier_Objects.mod.gml:621
_fr.pc = ((targetplayer.curse == 1)) ? 10 : 7;
break;
case 12: // Objects/Frontier_Objects.mod.gml:619
{
targetplayer = instance_nearest(x, y, Player);
playerwep = scrFRWeaponSlotRead(targetplayer, "wep");
}
_fr.pc=11;
break;
case 13: // Objects/Frontier_Objects.mod.gml:615
_fr.pc = (((pick != (- 1)) and (can_swap == true))) ? 12 : 4;
break;
case 14: // Objects/Frontier_Objects.mod.gml:604
{
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
_fr.vars.me = scrFRSelf(self);
;
if (frMacro_Objects_Frontier_Objects_mod_gml_anim_end) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
}
_fr.pc=13;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Objects.mod.gml:723
function fr_Objects_Frontier_Objects_mod_gml_player_swap(_frl__player=undefined) {
{ var __fr_with1 = scrFRWithValues(["%wep", "%curse", "%reload", "%wkick", "%wepflip", "%wepangle", "%can_shoot", "%clicked", "%interfacepop", "drawempty%"]), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var _frl__name = [string_replace(scrFRSelf(self), "%", ""), string_replace(scrFRSelf(self), "%", "b")];
var _frl__temp = scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 0), 0);
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 0), scrFRVariableGet(_frl__player, scrFRIndexGet(_frl__name, 1), 0));
;
scrFRVariableSet(_frl__player, scrFRIndexGet(_frl__name, 1), _frl__temp);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:736
function fr_Objects_Frontier_Objects_mod_gml_CarHonkController_create(_frl__x=undefined, _frl__y=undefined, _frl__owner=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_CarHonkController";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprCarHeadlights);
;
spr_light = global.fr_module_vars[$ "mod:Frontier_Objects"].sprCarLight;
;
image_xscale = _frl__owner.image_xscale;
;
depth = (- 1);
;
image_speed = (0) * timescale;
;
lightsOn = false;
;
mask_index = mskNone;
;
owner = _frl__owner;
;
active = false;
;
honkTime = 0;
;
mySound = noone;
;
honkOffset = scrFRSourceIRandomRange((- 6), 6);
on_step = fr_Objects_Frontier_Objects_mod_gml_CarHonkController_step;
;
on_draw = fr_Objects_Frontier_Objects_mod_gml_CarHonkController_draw;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:763
function fr_Objects_Frontier_Objects_mod_gml_CarHonkController_step() {
if ((! scrFRInstanceExists(owner))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
} else {
{
if ((owner.nexthurt >= (scrFRSourceFrame() + 4))) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
active = true;
;
}
}
}
}
x = owner.x;
;
y = owner.y;
}
}
if ((active == true)) {
{
honkTime -= scrFRSourceScale();
;
if ((honkTime <= 0)) {
{
lightsOn = false;
;
image_index = 0;
;
}
}
if (fr_Objects_Frontier_Objects_mod_gml_every((30 + honkOffset))) {
{
mySound = scrFRSoundPitch(global.fr_module_vars[$ "mod:Frontier_Objects"].sndCarHonk, (1 + fr_Objects_Frontier_Objects_mod_gml_orandom(0.02)));
lightsOn = true;
;
honkTime = 15;
;
image_index = 1;
;
}
}
if (scrFRInstanceExists(Player)) {
{
var _frl__nearestPlayer = instance_nearest(x, y, Player);
var _frl__dis = distance_to_object(_frl__nearestPlayer);
var _frl__honkVol = ((320 - _frl__dis) / 320);
;
scrFRSoundVolume(mySound, clamp((1 * _frl__honkVol), 0, 10));
;
}
}
}
}
}

// Original Objects/Frontier_Objects.mod.gml:796
function fr_Objects_Frontier_Objects_mod_gml_CarHonkController_draw() {
if (scrFRInstanceExists(owner)) {
{
if ((owner.nexthurt >= (scrFRSourceFrame() + 4))) {
{
gpu_set_fog(1, c_white, 0, 0);
;
}
}
}
}
draw_self();
;
gpu_set_fog(0, 0, 0, 0);
;
}

// Original Objects/Frontier_Objects.mod.gml:805
function fr_Objects_Frontier_Objects_mod_gml_PortalPusher_create(_frl__x=undefined, _frl__y=undefined, _frl__dis=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_PortalPusher";
sprite_index = scrFRAreaSourceSprite(mskNone);
;
mask_index = mskNone;
;
portalDis = _frl__dis;
;
on_step = fr_Objects_Frontier_Objects_mod_gml_PortalPusher_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:822
function fr_Objects_Frontier_Objects_mod_gml_PortalPusher_step() {
if ((distance_to_object(Portal) < portalDis)) {
{
if (frMacro_Objects_Frontier_Objects_mod_gml_current_frame_active) {
{
{ var __fr_with1 = scrFRWithValues(instance_nearest(x, y, Portal)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
scrFRMotionAdd((point_direction(__fr_other4.x, __fr_other4.y, x, y) + scrFRSourceRandomRange((- 30), 30)), 0.4);
;
friction = (0.3) * (timescale * timescale);
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}

// Original Objects/Frontier_Objects.mod.gml:832
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_create(_frl__x=undefined, _frl__y=undefined, _frl__skill=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SurgeryStation";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprBetaSurgeryStation);
;
fr_glow = [48, 64];
;
image_speed = (0) * timescale;
;
depth = (- 1);
;
mask_index = mskWepPickup;
;
mytext = scrFRLocalize("");
;
opened = false;
;
pick = (- 1);
;
newskill = _frl__skill;
;
surgeryname = "SURGERY NAME";
;
description = "@sSURGERY DESCRIPTION";
;
image_index = ((! scrFRGetSkill(newskill)) ? 0 : 1);
;
if ((! scrFRGetSkill(newskill))) {
{
on_step = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_step];
;
on_end_step = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_end_step];
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.prompt_create, mytext)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
on_step = fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStationPrompt_step;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break6) break;
}}
}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:868
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_spawn(_frl__x=undefined, _frl__y=undefined, _frl__skill=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_create(_frl__x, _frl__y, _frl__skill)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((! scrFRGetSkill(_frl__skill))) {
{
scrFRModCall("skill", _frl__skill, "surgery_setup");
;
}
}
surgeryname = scrFRModCall("skill", _frl__skill, "skill_name");
;
description = scrFRModCall("skill", _frl__skill, "skill_text");
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:878
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStationPrompt_step() {
if ((pick != (- 1))) {
{
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
pick = 1;
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

// Original Objects/Frontier_Objects.mod.gml:886
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_step() {
x = xstart;
;
y = ystart;
;
speed = (0) * timescale;
;
if (((pick != (- 1)) && (opened == false))) {
{
opened = true;
;
image_index = 1;
;
name = "fr_AugmentStationOpened";
;
scrFRSetSkill(newskill, 1);
;
frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_set, "Frontier", "surgeries_received", (frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_get, "Frontier", "surgeries_received") + 1));
;
scrFRSoundPitch(sndBloodLauncher, (0.8 + scrFRSourceRandom(0.3)));
;
{ var __fr_with1 = scrFRWithValues(Player), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, ImpactWrists)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_blend = make_colour_rgb(88, 15, 22);
;
depth = (- 3);
;
}
}
if(__fr_break6) break;
}}
repeat (8) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), BulletHit)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprSurgerySparkle);
;
image_index = scrFRSourceChoose(0, 1);
;
image_xscale = scrFRSourceRandomRange(0.5, 1);
;
image_yscale = image_xscale;
;
direction = (90 + scrFRSourceRandomRange((- 32), 32));
;
speed = (scrFRSourceRandom(3)) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
}
if(__fr_break3) break;
}}
}
}
}

// Original Objects/Frontier_Objects.mod.gml:928
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_end_step() {
var _frl__fadeIn = 0;
;
if (((opened == false) && instance_place(x, y, Player))) {
{
scrFRBindDraw(fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_text, (- 1000), x, y, surgeryname, description, instance_nearest(x, y, Player));
_frl__fadeIn = 0.4;
;
}
}
if ((opened == false)) {
{
scrFRBindDraw(fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_effects, (- 10), x, y, newskill, _frl__fadeIn, instance_nearest(x, y, Player));
}
}
}

// Original Objects/Frontier_Objects.mod.gml:940
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_effects(_frl__x=undefined, _frl__y=undefined, _frl__newskill=undefined, _frl__fadeIn=undefined) {
var _frl__bob = (sin((scrFRSourceFrame() * 0.1)) * 2);
var _frl__rotBob = (sin((scrFRSourceFrame() * 0.2)) * 8);
var _frl__holoBob = (sin((scrFRSourceFrame() * 0.05)) * 0.15);
var _frl__icon = frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.skill_get_icon, _frl__newskill);
var _frl__spr = scrFRIndexGet(_frl__icon, 0);
var _frl__img = scrFRIndexGet(_frl__icon, 1);
;
scrFRDrawSpriteExt(_frl__spr, _frl__img, _frl__x, ((_frl__y - 32) + _frl__bob), 1, 1, (0 + _frl__rotBob), c_white, (0.6 + _frl__fadeIn));
scrFRInstanceDestroy();
}

// Original Objects/Frontier_Objects.mod.gml:951
function fr_Objects_Frontier_Objects_mod_gml_BetaSurgeryStation_text(_frl__x=undefined, _frl__y=undefined, _frl__surgeryName=undefined, _frl__description=undefined, _frl__player=undefined) {
var _frl__bob = (sin((scrFRSourceFrame() * 0.1)) * 1);
var _frl__halign = draw_get_halign();
var _frl__valign = draw_get_valign();
;
var _frl__yoff = (((16 * round((string_count("#", _frl__description) + 1))) + 28) + _frl__bob);
var _frl__xtextoff = 0;
;
draw_set_font(fntSmall);
;
draw_set_halign(1);
draw_set_valign(0);
scrFRDrawText((_frl__x + _frl__xtextoff), (_frl__y - _frl__yoff), _frl__description);
draw_set_font(fntM1);
;
draw_set_valign(2);
scrFRDrawText((_frl__x + _frl__xtextoff), ((_frl__y - _frl__yoff) - 1), _frl__surgeryName);
draw_set_halign(_frl__halign);
draw_set_valign(_frl__valign);
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Objects.mod.gml:974
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Hoarder";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderDead;
;
spr_scare = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderScare;
;
spr_sprint = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderSprint;
;
spr_leave = global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderEscape;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "HOARDER"];
spr_shadow = shd24;
;
spr_shadow_y = 5;
;
fr_glow = [20, 30];
;
snd_hurt = scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderJingle, 2);
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderStop;
;
snd_loop = global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderLoop;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 32, "=");
;
hp = max_hp;
;
raddrop = 8;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
sprintspeed = 5.5;
;
size = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
panic = false;
;
chaseTime = 120;
;
leaving = false;
;
dropLoot = true;
;
getOut = false;
;
myDanger = undefined;
;
leaveIndex = 0;
;
lastJingle = (- 1);
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_Hoarder_step];
;
on_draw = fr_Objects_Frontier_Objects_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Objects_mod_gml_Hoarder_hurt;
;
on_death = fr_Objects_Frontier_Objects_mod_gml_Hoarder_death;
;
on_alrm1 = ["mod", "Frontier_Objects", fr_Objects_Frontier_Objects_mod_gml_Hoarder_alrm1];
;
fr_Objects_Frontier_Objects_mod_gml_Hoarder_jingle(lastJingle, 1280);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:1039
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Objects_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((panic == true)) {
{
if (frMacro_Objects_Frontier_Objects_mod_gml_current_frame_active) {
{
if (((scrFRSourceRandom(5) < 1) && (leaveIndex == 0))) {
{
scrFRInstanceCreate(x, y, NTTEFullSweat);
;
}
}
}
}
chaseTime -= scrFRSourceScale();
;
if ((chaseTime <= 0)) {
{
if (audio_is_playing(snd_loop)) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderStop);
;
scrFRSoundStop(snd_loop);
;
}
}
leaving = true;
;
walk = 0;
;
if ((sprite_index != spr_leave)) {
{
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_leave);
;
}
} else {
{
leaveIndex = image_index;
;
if (frMacro_Objects_Frontier_Objects_mod_gml_anim_end) {
{
hp = 0;
;
exit;
;
}
}
if (((chaseTime <= (- 40)) && (getOut == false))) {
{
getOut = true;
;
image_index = 14;
;
}
}
if (((image_index >= 14) && (dropLoot == true))) {
{
mask_index = mskNone;
;
spr_dead = mskNone;
;
dropLoot = false;
;
snd_dead = (- 1);
;
givekill = 0;
;
raddrop = 0;
;
canfly = true;
;
spr_shadow = mskNone;
;
getOut = true;
;
scrFRSoundPitchVolume(sndExplosionS, (1.4 + scrFRSourceRandom(0.1)), 0.3);
;
scrFRSoundPitchVolume(sndBurn, (1.4 + scrFRSourceRandom(0.1)), 0.6);
;
repeat (10) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteSmoke_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
image_xscale = (0.5 + scrFRSourceRandom(0.5));
;
image_yscale = image_xscale;
;
direction = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}
}
}
}
}
} else {
{
if ((scrFRInstanceExists(Player) && ((speed / timescale) > 3))) {
{
if ((! audio_is_playing(snd_loop))) {
{
snd_loop = scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderLoop);
;
}
}
var _frl__nearestPlayer = instance_nearest(x, y, Player);
var _frl__dis = distance_to_object(_frl__nearestPlayer);
var _frl__sprintVol = ((640 - _frl__dis) / 640);
;
scrFRSoundVolume(snd_loop, clamp((1 * _frl__sprintVol), 0, 10));
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Objects_mod_gml_chance(1, 100)) {
{
fr_Objects_Frontier_Objects_mod_gml_Hoarder_jingle(lastJingle, 320);
;
}
}
var _frl__nearestProjectile = frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.instance_nearest_array, x, y, scrFRMatchingNE(projectile, "team", team));
;
if (((((distance_to_object(Player) < 128) && frMacro_Objects_Frontier_Objects_mod_gml_target_visible) || (distance_to_object(_frl__nearestProjectile) < 96)) || (hp < max_hp))) {
{
panic = true;
;
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_scare);
;
spr_walk = spr_sprint;
maxspeed = (sprintspeed) * timescale;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 13, "=");
;
walk = 0;
;
scrFRSoundPitch(sndMutant6Slct, 2);
}
}
}
}
if ((((sprite_index != spr_scare) && (sprite_index != spr_leave)) || frMacro_Objects_Frontier_Objects_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Objects_mod_gml_enemy_sprite);
;
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Objects.mod.gml:1143
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
if ((leaving == false)) {
{
if ((fr_Objects_Frontier_Objects_mod_gml_enemy_target(x, y) && (panic == true))) {
{
var _frl__nearestProjectile = frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.instance_nearest_array, x, y, scrFRMatchingNE(projectile, "team", team));
;
var _frl__nearestPlayer = instance_nearest(x, y, Player);
;
if ((distance_to_object(_frl__nearestProjectile) < distance_to_object(_frl__nearestPlayer))) {
{
myDanger = _frl__nearestProjectile;
;
}
} else {
{
myDanger = _frl__nearestPlayer;
;
}
}
fr_Objects_Frontier_Objects_mod_gml_enemy_walk(((point_direction(x, y, myDanger.x, myDanger.y) + 180) + scrFRSourceRandomRange((- 30), 30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Objects_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Objects_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1164
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
if (fr_Objects_Frontier_Objects_mod_gml_chance(1, 4)) {
{
var _frl__object = scrFRSourceChoose(AmmoPickup, HPPickup, BigRad);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, _frl__object)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
z = 8;
;
direction = scrFRSourceRandom(360);
;
speed = (2) * timescale;
;
zspeed = 4;
;
zfriction = 0.7;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
var __fr_other8=scrFROther(other);
depth = __fr_other8.depth;
;
var __fr_other9=scrFROther(other);
mask_index = __fr_other9.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other10=scrFROther(other);
spr_shadow_y = __fr_other10.spr_shadow_y;
;
}
}
}
}
if(__fr_break6) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break3) break;
}}
}
}
audio_sound_pitch(scrFRSoundHit(sndMutant6Slct, 0.5), 2.3);
;
scrFRMotionAdd(_frl__dir, 5);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_Objects.mod.gml:1193
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_death() {
if ((dropLoot == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Pickups", "HoarderBag_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
{ var __fr_with4 = scrFRWithValues(scrFRModCall("mod", "Frontier_Objects", "ZAxisToss_create", x, y)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
z = 8;
;
direction = scrFRSourceRandom(360);
;
speed = (2) * timescale;
;
zspeed = 4;
;
zfriction = 0.7;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
var __fr_other8=scrFROther(other);
depth = __fr_other8.depth;
;
var __fr_other9=scrFROther(other);
mask_index = __fr_other9.mask_index;
;
if (scrFRVariableExists((scrFROther(other)), "spr_shadow_y")) {
{
var __fr_other10=scrFROther(other);
spr_shadow_y = __fr_other10.spr_shadow_y;
;
}
}
}
}
if(__fr_break6) break;
}}
mask_index = mskNone;
;
}
}
if(__fr_break3) break;
}}
frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_set, "Frontier", "hoarder_kills", (frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_get, "Frontier", "hoarder_kills") + 1));
;
repeat ((6 + scrFRSourceIRandom(6))) {
fr_Objects_Frontier_Objects_mod_gml_HoarderBell_create(x, y);
;
}
}
} else {
{
frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_set, "Frontier", "hoarder_escapes", (frMacro_Objects_Frontier_Objects_mod_gml_call(frMacro_Objects_Frontier_Objects_mod_gml_scr.save_get, "Frontier", "hoarder_escapes") + 1));
;
}
}
if (audio_is_playing(snd_loop)) {
{
scrFRSoundPlay(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderStop);
;
scrFRSoundStop(snd_loop);
;
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1227
function fr_Objects_Frontier_Objects_mod_gml_Hoarder_jingle(_frl__lastJingle=undefined, _frl__maxDis=undefined) {
if (scrFRInstanceExists(Player)) {
{
var _frl__nearestPlayer = instance_nearest(x, y, Player);
var _frl__dis = distance_to_object(_frl__nearestPlayer);
var _frl__jingleVol = ((_frl__maxDis - _frl__dis) / _frl__maxDis);
;
var _frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderJingle) - 1));
;
if ((_frl__sound == _frl__lastJingle)) {
{
_frl__sound = scrFRSourceIRandom((array_length(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderJingle) - 1));
;
}
}
lastJingle = _frl__sound;
;
scrFRSoundPitchVolume(scrFRIndexGet(global.fr_module_vars[$ "mod:Frontier_Objects"].sndHoarderJingle, _frl__sound), (1 + scrFRSourceRandom(0.15)), _frl__jingleVol);
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1246
function fr_Objects_Frontier_Objects_mod_gml_HoarderBell_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprHoarderBell);
;
image_index = scrFRSourceIRandom(image_number);
;
image_speed = (0) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(4))) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
direction = scrFRSourceRandom(360);
;
lifetime = 120;
;
on_step = fr_Objects_Frontier_Objects_mod_gml_HoarderBell_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:1263
function fr_Objects_Frontier_Objects_mod_gml_HoarderBell_step() {
if ((lifetime > 0)) {
{
lifetime -= scrFRSourceScale();
;
}
} else {
{
image_alpha -= (0.07 * scrFRSourceScale());
;
if ((image_alpha <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1273
function fr_Objects_Frontier_Objects_mod_gml_SlaughterBSkinner_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_slaughterskinner";
;
on_step = fr_Objects_Frontier_Objects_mod_gml_SlaughterBSkinner_step;
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:1280
function fr_Objects_Frontier_Objects_mod_gml_SlaughterBSkinner_step() {
{ var __fr_with1 = scrFRWithValues(scrFRMatching(scrFRMatching(FRCustomHitme, "name", "NTTEPet"), "fr_slaughterskinner", undefined)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((leader != noone)) {
{
fr_slaughterskinner = true;
;
if ((pet == "Slaughter")) {
{
if (scrFRInstanceExists(leader)) {
{
if (((leader.race == scrFRRaceTryResolve("bubbles")) && (leader.bskin == scrFRSkinResolve(1)))) {
{
fr_Objects_Frontier_Objects_mod_gml_SlaughterB_applyskin();
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
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Objects.mod.gml:1294
function fr_Objects_Frontier_Objects_mod_gml_SlaughterB_applyskin() {
scrFRModCall("mod", "petlib", "pet_set_skin", scrFRSelf(self), ["mod", "Frontier_Objects", "SlaughterSkeleton"]);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBTransform);
;
depth = (- 3);
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitchVolume(sndStrongSpiritLost, 1.2, 1);
fr_skeletonized = true;
;
}

// Original Objects/Frontier_Objects.mod.gml:1305
function fr_Objects_Frontier_Objects_mod_gml_SlaughterSkeleton_sprite(_frl__name=undefined) {
{ var __fr_switch_value1=_frl__name, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("icon")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("idle")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("walk")) __fr_switch_case2=2;
if(__fr_switch_case2==-1 && __fr_switch_value1==("hurt")) __fr_switch_case2=3;
if(__fr_switch_case2==-1 && __fr_switch_value1==("dead")) __fr_switch_case2=4;
if(__fr_switch_case2==-1 && __fr_switch_value1==("spwn")) __fr_switch_case2=5;
if(__fr_switch_case2==-1 && __fr_switch_value1==("fire")) __fr_switch_case2=6;
if(__fr_switch_case2==-1 && __fr_switch_value1==("shadow_y")) __fr_switch_case2=7;
if(__fr_switch_case2==-1 && __fr_switch_value1==("bubble")) __fr_switch_case2=8;
if(__fr_switch_case2==-1 && __fr_switch_value1==("bubble_pop")) __fr_switch_case2=9;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBIcon;
;
case 1:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBIdle;
;
case 2:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBWalk;
;
case 3:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBHurt;
;
case 4:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBDead;
;
case 5:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBSpwn;
;
case 6:
return global.fr_module_vars[$ "mod:Frontier_Objects"].sprSlaughterBBite;
;
case 7:
return (- 2);
;
case 8:
return (- 1);
;
case 9:
return (- 1);
;
}
}
; // macro hoisted: anim_end
; // macro hoisted: current_frame_active
; // macro hoisted: target_visible
; // macro hoisted: target_direction
; // macro hoisted: target_distance
; // macro hoisted: enemy_sprite
; // macro hoisted: alarm0_run
; // macro hoisted: alarm1_run
; // macro hoisted: alarm2_run
; // macro hoisted: alarm3_run
; // macro hoisted: alarm4_run
; // macro hoisted: alarm5_run
; // macro hoisted: alarm6_run
; // macro hoisted: alarm7_run
; // macro hoisted: alarm8_run
; // macro hoisted: alarm9_run
}

// Original Objects/Frontier_Objects.mod.gml:1337
function fr_Objects_Frontier_Objects_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Objects.mod.gml:1338
function fr_Objects_Frontier_Objects_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Objects.mod.gml:1339
function fr_Objects_Frontier_Objects_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Objects.mod.gml:1340
function fr_Objects_Frontier_Objects_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Objects.mod.gml:1341
function fr_Objects_Frontier_Objects_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Objects.mod.gml:1342
function fr_Objects_Frontier_Objects_mod_gml_enemy_face(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1343
function fr_Objects_Frontier_Objects_mod_gml_enemy_look(_frl__dir=undefined) {
_frl__dir = (((_frl__dir % 360) + 360) % 360);
;
if (((_frl__dir < 90) || (_frl__dir > 270))) {
right = 1;
} else {
if (((_frl__dir > 90) && (_frl__dir < 270))) {
right = (- 1);
}
}
if (scrFRVariableExists(scrFRSelf(self), "gunangle")) {
gunangle = _frl__dir;
}
}

// Original Objects/Frontier_Objects.mod.gml:1344
function fr_Objects_Frontier_Objects_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Objects.mod.gml:1345
function fr_Objects_Frontier_Objects_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Objects.mod.gml:1346
function fr_Objects_Frontier_Objects_mod_gml_GunEnemy_draw() {
if ((gunangle < 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
if ((gunangle >= 180)) {
{
scrFRDrawSpriteExt(spr_weap, 0, (x + lengthdir_x((- wkick), gunangle)), (y + lengthdir_y((- wkick), gunangle)), 1, right, gunangle, image_blend, image_alpha);
;
}
}
}

// Original Objects/Frontier_Objects.mod.gml:1347
function fr_Objects_Frontier_Objects_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Objects_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Objects_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Objects.mod.gml:1348
function fr_Objects_Frontier_Objects_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Objects_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Objects_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Objects.mod.gml:1349
function fr_Objects_Frontier_Objects_mod_gml_nothing() {

}

// Original Objects/Frontier_Objects.mod.gml:1350
function fr_Objects_Frontier_Objects_mod_gml_every(_frl__num=undefined) {
return (frac((scrFRSourceFrame() / _frl__num)) < (scrFRSourceScale() / _frl__num));
}

// Original Objects/Frontier_Objects.mod.gml:1351
function fr_Objects_Frontier_Objects_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionAdd(_frl__dir, _frl__spd);
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_Objects.mod.gml:1361
function fr_Objects_Frontier_Objects_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
hp -= _frl__dmg;
;
nexthurt = (scrFRSourceFrame() + 6);
;
scrFRSoundHit(snd_hurt, 0.3);
;
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
}

// Original Objects/Frontier_Objects.mod.gml:1370
function fr_Objects_Frontier_Objects_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
if ((_frl__angleMelee != 0)) {
{
_frl__angle += (_frl__angleMelee * (1 - (_frl__kick / 20)));
;
}
}
if ((_frl__kick != 0)) {
{
_frl__x -= lengthdir_x(_frl__kick, _frl__angle);
;
_frl__y -= lengthdir_y(_frl__kick, _frl__angle);
;
}
}
scrFRDrawSpriteExt(_frl__sprite, _frl__image, _frl__x, _frl__y, 1, _frl__flip, _frl__angle, _frl__blend, _frl__alpha);
;
}

// Original Objects/Frontier_Objects.mod.gml:1393
function fr_Objects_Frontier_Objects_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Objects.mod.gml:1405
function fr_Objects_Frontier_Objects_mod_gml_MuzzleFlash_anim() {
image_index = 1;
;
image_speed = (0) * timescale;
;
}

// Original Objects/Frontier_Objects.mod.gml:1409
function fr_Objects_Frontier_Objects_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Objects"].sprGenericTrail);
;
mask_index = mskNone;
;
image_speed = (2) * timescale;
;
image_yscale = (1 / 50);
;
image_xscale = 1;
;
depth = 0;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}
