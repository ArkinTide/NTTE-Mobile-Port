#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_scr global.fr_module_vars[$ "mod:Frontier_Deeplabs"].scr

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_call scrFRScriptCall

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_subjectFollowRange 104

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_subjectNodeRange 320

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end (((image_index + image_speed) >= image_number) || ((image_index + image_speed) < 0))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_current_frame_active (frac(scrFRSourceFrame()) < scrFRSourceScale())

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_target_visible (! collision_line(x, y, target.x, target.y, Wall, false, false))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction point_direction(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance point_distance(x, y, target.x, target.y)

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite (((sprite_index != spr_hurt) || frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end) ? (((speed / timescale) == 0) ? spr_idle : spr_walk) : sprite_index)

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm0_run (((scrFRAlarmRead(scrFRSelf(self), 0) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 0, -1, false))) && (scrFRScriptCall(on_alrm0) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run (((scrFRAlarmRead(scrFRSelf(self), 1) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 1, -1, false))) && (scrFRScriptCall(on_alrm1) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm2_run (((scrFRAlarmRead(scrFRSelf(self), 2) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 2, -1, false))) && (scrFRScriptCall(on_alrm2) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm3_run (((scrFRAlarmRead(scrFRSelf(self), 3) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 3, -1, false))) && (scrFRScriptCall(on_alrm3) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm4_run (((scrFRAlarmRead(scrFRSelf(self), 4) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 4, -1, false))) && (scrFRScriptCall(on_alrm4) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm5_run (((scrFRAlarmRead(scrFRSelf(self), 5) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 5, -1, false))) && (scrFRScriptCall(on_alrm5) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm6_run (((scrFRAlarmRead(scrFRSelf(self), 6) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 6, -1, false))) && (scrFRScriptCall(on_alrm6) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm7_run (((scrFRAlarmRead(scrFRSelf(self), 7) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 7, -1, false))) && (scrFRScriptCall(on_alrm7) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm8_run (((scrFRAlarmRead(scrFRSelf(self), 8) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 8, -1, false))) && (scrFRScriptCall(on_alrm8) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm9_run (((scrFRAlarmRead(scrFRSelf(self), 9) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (! scrFRAlarmIncrement(scrFRSelf(self), 9, -1, false))) && (scrFRScriptCall(on_alrm9) || (! scrFRInstanceExists(scrFRSelf(self)))))

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_bbox_center_x (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2)

#macro frMacro_Objects_Frontier_Deeplabs_mod_gml_bbox_center_y (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2)

// Original Objects/Frontier_Deeplabs.mod.gml:1
function fr_Objects_Frontier_Deeplabs_mod_gml___load() {

}

// Original Objects/Frontier_Deeplabs.mod.gml:1
function fr_Objects_Frontier_Deeplabs_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_Objects_Frontier_Deeplabs_mod_gml_init_resume, id, scrFROther(other), _args, 2, []);
}
function fr_Objects_Frontier_Deeplabs_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_Objects_Frontier_Deeplabs_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // Objects/Frontier_Deeplabs.mod.gml:5
{
scrFRScriptCall(["mod", "lib", "getRef"], "mod", "Frontier_Deeplabs", "scr");
;
; // macro hoisted: scr
; // macro hoisted: call
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerHurt = sndFR_sndSlicerHurt_94dff01ab06a;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerDead = sndFR_sndSlicerDead_9d4ebf00c668;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerChrg = sndFR_sndSlicerChrg_e6d60bb7aec9;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerFire = sndFR_sndSlicerFire_e118ee340e6b;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherHurt = sndFR_sndThrasherHurt_80bc2da43fd9;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherDead = sndFR_sndThrasherDead_7f30a74663b3;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherMele = sndFR_sndThrasherMele_45454aa186e9;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherChrg = sndFR_sndThrasherChrg_d119abefa9b8;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherSpit = sndFR_sndThrasherSpit_52873347700a;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherBubblePop = sndFR_sndThrasherBubblePop_b1c641246c44;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskThrasher = sprFR_mskThrasher_e8734af02f4b;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherIdle = sprFR_sprThrasherIdle_821264df4916;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherWalk = sprFR_sprThrasherWalk_e6a44173005a;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherHurt = sprFR_sprThrasherHurt_65d587ac7f7b;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherDead = sprFR_sprThrasherDead_eaf1639fcb59;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherTell = sprFR_sprThrasherTell_a2e2a1f081c7;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherChrg = sprFR_sprThrasherCharge_ea40e0bfdb2f;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherSpit = sprFR_sprThrasherSpit_798ae8ca91de;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerIdle = sprFR_sprSlicerIdle_b87050b18114;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerWalk = sprFR_sprSlicerWalk_afc4555937a4;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerHurt = sprFR_sprSlicerHurt_43dc6d9810f7;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerDead = sprFR_sprSlicerDead_b3e19d5e9261;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerFire = sprFR_sprSlicerFire_38252befeb86;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonIdle = sprFR_sprSurgeonIdle_4cf0be1c8da4;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonWalk = sprFR_sprSurgeonWalk_39c3c76ad075;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonHurt = sprFR_sprSurgeonHurt_523263277976;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonDead = sprFR_sprSurgeonDead_ea9da7f045c9;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonWeap = sprFR_sprSurgeonWeap_f896effc3792;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonWeapMelee = sprFR_sprSurgeonWeapMelee_cc6f918f0eef;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskSurgeonMinion = sprFR_mskSurgeonMinion_9ba75a61c1c1;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinion = sprFR_sprSurgeonMinion_607f407a617c;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinionHurt = sprFR_sprSurgeonMinionHurt_1332f113bea3;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinionDead = sprFR_sprSurgeonMinionDead_5a82fe01e80a;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprDeeplabsPod = sprFR_sprDeeplabsPod_dce670900de0;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskDeeplabsPod = sprFR_mskDeeplabsPod_e74bbe72f0e4;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprFishFreakDead = sprFR_sprFishFreakDead_3dbc40f78215;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskGatorBubble = sprFR_mskGatorBubble_73a6441b9adc;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskGatorBubbleSlowBox = sprFR_mskGatorBubbleSlowBox_8faf9382af6b;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubble = sprFR_sprGatorBubble_1786038cd0b3;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubblePop = sprFR_sprGatorBubblePop_b0e38b8083c3;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubbleTrail = sprFR_sprGatorBubbleTrail_b7772433bbac;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprRavenSlicer = sprFR_sprRavenSlicer_a64d1fc23eaa;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprRavenSlicerTrail = sprFR_sprRavenSlicerTrail_e8a523cde187;
;
global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSoulSmoke = sprFR_sprSoulSmoke_030add39b40b;
;
; // macro hoisted: subjectFollowRange
; // macro hoisted: subjectNodeRange
}
_fr.pc=0;
break;
case 3: // Objects/Frontier_Deeplabs.mod.gml:4
{
;
}
_fr.pc=2;
break;
case 4: // Objects/Frontier_Deeplabs.mod.gml:4
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // Objects/Frontier_Deeplabs.mod.gml:4
_fr.pc=((! scrFRModLoaded("mod", "lib")))?4:1;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original Objects/Frontier_Deeplabs.mod.gml:77
function fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomHitme)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Test Subject";
spr_idle = sprGatorIdle;
;
spr_walk = sprGatorWalk;
;
spr_hurt = sprGatorHurt;
;
spr_dead = sprGatorDead;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "TEST SUBJECT"];
spr_shadow = shd24;
;
spr_shadow_y = 0;
;
snd_hurt = sndRavenHit;
;
snd_dead = sndRavenDie;
;
mask_index = mskPlayer;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 24, "=");
;
hp = max_hp;
;
raddrop = 8;
;
maxspeed = (4.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 2;
;
canmelee = false;
;
team = 9910;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
friction = (0.4) * (timescale * timescale);
;
gunangle = 0;
;
goalX = undefined;
;
goalY = undefined;
;
nodding = false;
;
desiredNode = (- 1);
;
currentNode = (- 1);
;
currentNodeNum = (- 1);
;
nodeDirection = 1;
;
fr_trapImmune = true;
;
regenTime = 60;
;
imSafe = false;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_step];
;
on_end_step = fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_endstep;
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt;
;
on_destroy = fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_death;
;
on_alrm1 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:143
function fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((nodding == true)) {
{
if ((distance_to_object(Player) < (frMacro_Objects_Frontier_Deeplabs_mod_gml_subjectFollowRange + 16))) {
{
nodding = false;
;
currentNodeNum = (- 1);
;
currentNode = (- 1);
;
desiredNode = undefined;
;
}
}
if ((distance_to_object(currentNode) <= 4)) {
{
if ((currentNode != desiredNode)) {
{
currentNode = frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(FRCustomObject, "fr_subjectNode", (currentNodeNum + nodeDirection)));
;
currentNodeNum = currentNode.fr_subjectNode;
;
}
} else {
{
nodding = false;
;
currentNodeNum = (- 1);
;
currentNode = (- 1);
;
desiredNode = undefined;
;
}
}
}
}
}
}
if ((hp < max_hp)) {
{
if ((regenTime > 0)) {
{
regenTime -= scrFRSourceScale();
;
}
} else {
{
hp += 1;
;
regenTime += 75;
;
}
}
}
}
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite);
;
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
if ((hp <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:196
function fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_endstep() {
if (scrFRPlaceMeeting(x, y, InvisiWall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, InvisiWall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), InvisiWall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
if (scrFRPlaceMeeting(x, y, Wall)) {
{
x = xprevious;
;
y = yprevious;
;
var _frl_f = (friction / (timescale * timescale));
;
if (scrFRPlaceMeeting((x + (hspeed / timescale)), y, Wall)) {
hspeed *= (- 1);
}
if (scrFRPlaceMeeting(x, (y + (vspeed / timescale)), Wall)) {
vspeed *= (- 1);
}
while ((((hspeed / timescale) != 0) && scrFRPlaceMeeting((x + (hspeed / timescale)), y, Wall))) hspeed -= (clamp((hspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
while ((((vspeed / timescale) != 0) && scrFRPlaceMeeting(x, (y + (vspeed / timescale)), Wall))) vspeed -= (clamp((vspeed / timescale), (- _frl_f), _frl_f)) * timescale;
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:217
function fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (10 + scrFRSourceIRandom(20)), "=");
;
if ((nodding == false)) {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(x, y)) {
{
if ((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > frMacro_Objects_Frontier_Deeplabs_mod_gml_subjectFollowRange)) {
{
if (((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > frMacro_Objects_Frontier_Deeplabs_mod_gml_subjectNodeRange) || collision_line(x, y, target.x, target.y, InvisiWall, false, false))) {
{
nodding = true;
;
var _frl__player = instance_nearest(x, y, Player);
;
var _frl__node = frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_array, _frl__player.x, _frl__player.y, scrFRMatching(FRCustomObject, "name", "fr_subjectNode"));
;
var _frl__nearestNode = frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(FRCustomObject, "name", "fr_subjectNode"));
;
desiredNode = _frl__node;
;
currentNode = _frl__nearestNode;
;
currentNodeNum = _frl__nearestNode.fr_subjectNode;
;
nodeDirection = ((currentNodeNum < desiredNode.fr_subjectNode) ? 1 : (- 1));
;
scrFRAlarmWrite(scrFRSelf(self), 1, 8, "=");
;
}
} else {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction);
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
}
}
}
} else {
{
direction = point_direction(x, y, currentNode.x, currentNode.y);
;
gunangle = direction;
;
scrFRAlarmWrite(scrFRSelf(self), 1, 4, "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(direction, scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_face(direction);
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:265
function fr_Objects_Frontier_Deeplabs_mod_gml_TestSubject_death() {
repeat ((6 + scrFRSourceIRandom(4))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Feather)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprRavenFeather);
;
}
}
if(__fr_break3) break;
}}
}
scrFRPickupDrop(55, 0);
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Corpse)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
size = __fr_other7.size;
;
var __fr_other8=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other8.spr_dead);
;
var __fr_other9=scrFROther(other);
image_xscale = (scrFRVariableExists(__fr_other9, "right") ? __fr_other9.right : __fr_other9.image_xscale);
;
var __fr_other10=scrFROther(other);
direction = __fr_other10.direction;
;
var __fr_other11=scrFROther(other);
speed = ((__fr_other11.speed / timescale)) * timescale;
;
var __fr_other12=scrFROther(other);
mask_index = __fr_other12.mask_index;
;
var __fr_other13=scrFROther(other);
speed += (max(0, ((- __fr_other13.hp) / 5))) * timescale;
;
speed += ((8 * scrFRGetSkill(mut_impact_wrists))) * timescale;
;
speed = (min((speed / timescale), 16)) * timescale;
;
return scrFRSelf(self);
;
}
}
if(__fr_break6) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:290
function fr_Objects_Frontier_Deeplabs_mod_gml_DeeplabsPodDecal_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprDeeplabsPod);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskDeeplabsPod;
;
depth = (- 9);
;
on_step = fr_Objects_Frontier_Deeplabs_mod_gml_DeeplabsPodDecal_step;
;
var _frl__xoff = ((sprite_get_xoffset(mask_index) - (((sprite_get_bbox_left(mask_index) + sprite_get_bbox_right(mask_index)) + 1) / 2)) * image_xscale);
var _frl__yoff = ((sprite_get_yoffset(mask_index) - (((sprite_get_bbox_top(mask_index) + sprite_get_bbox_bottom(mask_index)) + 1) / 2)) * image_yscale);
var _frl__dis = 48;
var _frl__dir = scrFRSourceRandom(360);
var _frl__tries = 20;
;
{ var __fr_with4 = scrFRWithValues(frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_bbox, 10016, 10016, Floor)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var _frl__top = instance_nearest(x, y, Floor);
;
_frl__dir = point_direction(frMacro_Objects_Frontier_Deeplabs_mod_gml_bbox_center_x, frMacro_Objects_Frontier_Deeplabs_mod_gml_bbox_center_y, _frl__top.x, _frl__top.y);
;
}
}
if(__fr_break6) break;
}}
x = (fr_Objects_Frontier_Deeplabs_mod_gml_pround(_frl__x, 16) + _frl__xoff);
;
y = (fr_Objects_Frontier_Deeplabs_mod_gml_pround(_frl__y, 16) + _frl__yoff);
;
while ((((_frl__tries--) > 0) && ((((scrFRPlaceMeeting(x, y, Floor) || scrFRPlaceMeeting(x, y, Bones)) || scrFRPlaceMeeting(x, y, TopPot)) || scrFRPlaceMeeting(x, y, PortalClear)) || scrFRPlaceMeeting(x, y, FRCustomObject)))) {
x = (fr_Objects_Frontier_Deeplabs_mod_gml_pround(((x - _frl__xoff) + lengthdir_x(_frl__dis, _frl__dir)), 16) + _frl__xoff);
;
y = (fr_Objects_Frontier_Deeplabs_mod_gml_pround(((y - _frl__yoff) + lengthdir_y(_frl__dis, _frl__dir)), 16) + _frl__yoff);
;
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:334
function fr_Objects_Frontier_Deeplabs_mod_gml_DeeplabsPodDecal_step() {
if (frMacro_Objects_Frontier_Deeplabs_mod_gml_current_frame_active) {
{
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + 28), (y + 20), Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_fadesmoke = true;
;
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = 90;
;
speed = (3) * timescale;
friction = ((- 0.1)) * (timescale * timescale);
;
depth = (- 10);
;
growspeed = 0.10;
;
fr_fadesmoke = true;
;
}
}
if(__fr_break3) break;
}}
}
}
if ((scrFRSourceRandom(3) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate((x + 6), (y - 16), Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
fr_fadesmoke = true;
;
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
direction = 90;
;
speed = (3) * timescale;
friction = ((- 0.1)) * (timescale * timescale);
;
depth = (- 7);
;
growspeed = 0.10;
;
fr_fadesmoke = true;
;
}
}
if(__fr_break6) break;
}}
}
}
}
}
{ var __fr_with7 = scrFRWithValues(scrFRMatching(Dust, "fr_fadesmoke", true)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_alpha -= 0.07;
;
}
}
if(__fr_break9) break;
}}
if (scrFRPlaceMeeting(x, y, Floor)) {
{
repeat (8) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Explosion)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
depth = (- 12);
;
damage = 0;
;
hitid = [sprExplosion, "HOW"];
}
}
if(__fr_break12) break;
}}
}
scrFRSoundPlay(sndExplosionCar);
;
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:382
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, (_frl__y + 8), FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Thrasher";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherDead;
;
spr_tell = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherTell;
;
spr_chrg = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherChrg;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprThrasherSpit;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "THRASHER"];
spr_shadow = shd64;
;
spr_shadow_y = (- 1);
;
nts_color_blood = [make_color_rgb(96, 59, 52), c_black];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherDead;
;
snd_mele = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherMele;
;
snd_chrg = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherChrg;
;
snd_spit = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherSpit;
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskThrasher;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 48, "=");
;
hp = max_hp;
;
raddrop = 4;
;
maxspeed = (2) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
;
canmelee = true;
;
meleedamage = 4;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
charge = 0;
;
charge_wait = 0;
;
charge_dir = 0;
;
charge_speed = 0;
;
myBubble = noone;
;
fr_bubblePopper = true;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(10)), "=");
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_step];
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_death;
;
on_alrm1 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:446
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run)) {
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
if (((((sprite_index != spr_chrg) && (sprite_index != spr_tell)) && (sprite_index != spr_fire)) || frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite);
;
}
}
if (((charge > 0) || (charge_wait > 0))) {
{
direction = charge_dir;
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
if ((charge_wait > 0)) {
{
charge_wait -= scrFRSourceScale();
;
x += ((fr_Objects_Frontier_Deeplabs_mod_gml_orandom(1) - lengthdir_x((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
y += ((fr_Objects_Frontier_Deeplabs_mod_gml_orandom(1) - lengthdir_y((charge_wait / 10), charge_dir)) * scrFRSourceScale());
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_tell);
;
}
}
if ((charge_wait <= 0)) {
{
scrFRSoundPitchVolume(snd_chrg, (0.9 + scrFRSourceRandom(0.2)), 0.7);
;
}
}
}
} else {
if ((charge > 0)) {
{
var _frl__nearestBubble = frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(FRCustomProjectile, "name", "fr_GatorBubble"));
;
if (scrFRPlaceMeeting(x, y, _frl__nearestBubble)) {
{
{ var __fr_with1 = scrFRWithValues(_frl__nearestBubble), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((image_xscale >= maxSize)) {
{
powerPopped = true;
;
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break3) break;
}}
}
}
charge_speed -= (0.10 * scrFRSourceScale());
;
if ((charge_speed <= 0)) {
{
charge = 0;
;
image_index = 7;
;
}
}
scrFRMotionAdd(direction, charge_speed);
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
if ((sprite_index != spr_hurt)) {
{
sprite_index = scrFRAreaSourceSprite(spr_chrg);
;
}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
image_xscale = 0.5;
;
image_yscale = image_xscale;
;
}
}
if(__fr_break6) break;
}}
if ((scrFRPlaceMeeting((x + hspeed), (y + vspeed), Wall) || scrFRPlaceMeeting((x + hspeed), (y + vspeed), InvisiWall))) {
{
charge_speed = 0;
;
charge = 0;
;
image_index = 7;
;
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, PortalClear)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
image_xscale = 0.8;
;
image_yscale = 0.8;
;
}
}
if(__fr_break9) break;
}}
scrFRSoundPitch(sndBouncerBounce, (0.7 + scrFRSourceRandom(0.1)));
scrFRInstanceCreate(x, y, Dust);
;
}
}
}
}
}
right = ((((direction + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:541
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(10)), "=");
;
var _frl__bubbleCount = array_length(scrFRMatching(projectile, "name", "fr_GatorBubble"));
var _frl__nearestBubble = frMacro_Objects_Frontier_Deeplabs_mod_gml_call(frMacro_Objects_Frontier_Deeplabs_mod_gml_scr.instance_nearest_array, x, y, scrFRMatching(projectile, "name", "fr_GatorBubble"));
;
if ((fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Deeplabs_mod_gml_target_visible)) {
{
if (((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance < 144) && fr_Objects_Frontier_Deeplabs_mod_gml_chance(4, 5))) {
{
var _frl__spitBubble = true;
;
if (((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance < 72) && fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3))) {
{
_frl__spitBubble = false;
;
}
}
if ((((! scrFRInstanceExists(myBubble)) && fr_Objects_Frontier_Deeplabs_mod_gml_chance(2, 3)) && (_frl__spitBubble == true))) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, 10, "=");
;
image_index = 0;
;
sprite_index = scrFRAreaSourceSprite(spr_fire);
;
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
direction = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 15), 15));
;
speed = (10) * timescale;
;
var __fr_other5=scrFROther(other);
__fr_other5.myBubble = scrFRSelf(self);
;
var __fr_other6=scrFROther(other);
team = __fr_other6.team;
;
var __fr_other7=scrFROther(other);
creator = __fr_other7;
;
}
}
if(__fr_break3) break;
}}
scrFRSoundPitch(snd_spit, (0.9 + scrFRSourceRandom(0.2)));
repeat (5) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), PlasmaTrail)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubbleTrail);
;
var __fr_other11=scrFROther(other);
depth = (__fr_other11.depth - 1);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other12=scrFROther(other);
direction = (__fr_other12.gunangle + scrFRSourceRandomRange((- 30), 30));
image_angle = scrFRSourceRandom(360);
;
speed = ((1 + scrFRSourceRandom(1))) * timescale;
;
}
}
if(__fr_break10) break;
}}
}
}
} else {
{
var _frl__validDir = (((_frl__bubbleCount > 0) && (distance_to_object(_frl__nearestBubble) < 144)) ? scrFRSourceChoose(point_direction(x, y, _frl__nearestBubble.x, _frl__nearestBubble.y), frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction, frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction) : frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction);
;
charge_dir = _frl__validDir;
;
charge = 30;
;
charge_wait = 10;
;
charge_speed = 6.5;
;
scrFRAlarmWrite(scrFRSelf(self), 1, ((charge + charge_wait) + 30), "=");
;
}
}
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(2, 3)) {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + scrFRSourceRandomRange((- 20), 20)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}
} else {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:607
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorAmalgam_death() {
scrFRPickupDrop(45, 8);
}

// Original Objects/Frontier_Deeplabs.mod.gml:610
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Slicer";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerDead;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSlicerFire;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "SLICER"];
spr_shadow = shd32;
;
spr_shadow_y = 3;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
snd_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerHurt;
;
snd_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 24, "=");
;
hp = max_hp;
;
raddrop = 8;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 3;
;
canmelee = true;
;
meleedamage = 2;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_step];
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_death;
;
on_alrm1 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_alrm1];
;
on_alrm2 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:665
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm2_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((sprite_index != spr_fire) || frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite);
;
}
}
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:687
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(20)), "=");
;
if ((fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Deeplabs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > 144)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(2, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (80 + scrFRSourceIRandom(20)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 6, "=");
;
scrFRSoundPitch(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerChrg, (0.9 + scrFRSourceRandom(0.2)));
;
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
sprite_index = scrFRAreaSourceSprite(spr_fire);
;
image_index = 0;
;
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:722
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_alrm2() {
if (scrFRInstanceExists(target)) {
{
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
}
}
scrFRSoundPitch(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndSlicerFire, (0.9 + scrFRSourceRandom(0.2)));
;
var _frl__spread = (- 24);
;
repeat (3) {
{ var __fr_with1 = scrFRWithValues(fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_create(x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5;
;
var __fr_other6=scrFROther(other);
hitid = __fr_other6.hitid;
;
var __fr_other7=scrFROther(other);
direction = (__fr_other7.gunangle + _frl__spread);
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
_frl__spread += 24;
;
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:743
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenAmalgam_death() {
repeat ((6 + scrFRSourceIRandom(4))) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Feather)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprRavenFeather);
;
}
}
if(__fr_break3) break;
}}
}
scrFRPickupDrop(55, 0);
}

// Original Objects/Frontier_Deeplabs.mod.gml:751
function fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Seer";
spr_idle = sprNecromancerIdle;
;
spr_walk = sprNecromancerWalk;
;
spr_hurt = sprNecromancerHurt;
;
spr_dead = sprNecromancerDead;
;
spr_fire = sprRhinoFreakIdle;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "SEER"];
spr_shadow = shd24;
;
spr_shadow_y = 1;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
image_blend = c_yellow;
;
snd_hurt = sndNecromancerHurt;
;
snd_dead = sndNecromancerDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 15, "=");
;
hp = max_hp;
;
raddrop = 6;
;
maxspeed = (2.5) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = false;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_step];
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_death;
;
on_alrm1 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_alrm1];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:807
function fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if (((sprite_index != spr_fire) || frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite);
;
}
}
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:828
function fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(20)), "=");
;
if (fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(x, y)) {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > 192)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30)), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
}
} else {
{
if ((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > 32)) {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (100 + scrFRSourceIRandom(20)), "=");
;
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
sprite_index = scrFRAreaSourceSprite(spr_fire);
;
scrFRSoundPitch(sndGrenadeRifle, (1.3 + scrFRSourceRandom(0.2)));
;
wkick = 12;
;
repeat (12) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(10, (scrFROther(other)).gunangle)), (y + lengthdir_y(10, (scrFROther(other)).gunangle)), Smoke)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
image_xscale = (0.2 + scrFRSourceRandomRange(0.1, 0.5));
;
image_yscale = image_xscale;
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd((__fr_other4.gunangle + scrFRSourceRandomRange((- 10), 10)), (2 + scrFRSourceRandom(2)));
}
}
if(__fr_break3) break;
}}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + 180) + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:892
function fr_Objects_Frontier_Deeplabs_mod_gml_MothAmalgam_death() {
scrFRPickupDrop(55, 0);
}

// Original Objects/Frontier_Deeplabs.mod.gml:895
function fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Surgeon";
spr_idle = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonIdle;
;
spr_walk = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonWalk;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonDead;
;
spr_fire = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonIdle;
;
spr_fire_strt = sprSniperIdle;
;
spr_fire_end = sprSniperIdle;
;
spr_weap = mskNone;
;
spr_weap_melee = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonWeapMelee;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
depth = (- 2);
;
hitid = [spr_idle, "SURGEON"];
spr_shadow = shd24;
;
spr_shadow_y = 1;
;
nts_color_blood = [c_red, make_color_rgb(134, 44, 35)];
snd_hurt = sndNecromancerHurt;
;
snd_dead = sndNecromancerDead;
;
mask_index = mskBandit;
;
direction = scrFRSourceRandom(360);
;
scrFRMaxHealthWrite(id, 8, "=");
;
hp = max_hp;
;
raddrop = 6;
;
maxspeed = (3) * timescale;
;
walkspeed = (maxspeed / timescale);
;
size = 1;
;
canmelee = false;
;
meleedamage = 0;
;
canmelee = false;
;
team = 1;
;
targetvisible = 0;
;
target = 0;
;
walk = 0;
;
gunangle = 0;
;
wepangle = 110;
;
meleeMode = false;
;
hasBalls = false;
;
orbiterTime = 0;
;
ballCount = 0;
;
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(10)), "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 0, "=");
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_step];
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_MeleeEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt;
;
on_death = fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_death;
;
on_alrm1 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_alrm1];
;
on_alrm2 = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_alrm2];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:960
function fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_step() {
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm1") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm1_run)) {
exit;
}
if ((scrFRVariableExists(scrFRSelf(self), "on_alrm2") and frMacro_Objects_Frontier_Deeplabs_mod_gml_alarm2_run)) {
exit;
}
if ((walk > 0)) {
{
walk -= scrFRSourceScale();
;
speed += ((walkspeed * scrFRSourceScale())) * timescale;
;
gunangle = direction;
;
}
}
if (((speed / timescale) > (maxspeed / timescale))) {
{
speed = ((maxspeed / timescale)) * timescale;
;
}
}
if ((scrFRAlarmRead(scrFRSelf(self), 2) <= 0)) {
{
if (((distance_to_object(target) < 48) && frMacro_Objects_Frontier_Deeplabs_mod_gml_target_visible)) {
{
if (((meleeMode == false) && (scrFRAlarmRead(scrFRSelf(self), 2) <= 0))) {
{
meleeMode = true;
spr_weap = spr_weap_melee;
;
scrFRInstanceCreate((x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)), WepSwap);
;
scrFRSoundPitchVolume(sndSwapHammer, 1, 0.6);
;
}
}
}
} else {
{
if (((meleeMode == true) && (scrFRAlarmRead(scrFRSelf(self), 3) <= 0))) {
{
meleeMode = false;
;
spr_weap = mskNone;
;
scrFRInstanceCreate((x + lengthdir_x(12, gunangle)), (y + lengthdir_y(12, gunangle)), WepSwap);
;
}
}
}
}
}
}
if (((((sprite_index != spr_fire) && (sprite_index != spr_fire_strt)) && (sprite_index != spr_fire_end)) || frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(frMacro_Objects_Frontier_Deeplabs_mod_gml_enemy_sprite);
;
}
}
right = ((((gunangle + 270) mod 360) > 180) ? 1 : (- 1));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1000
function fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_alrm1() {
scrFRAlarmWrite(scrFRSelf(self), 1, (30 + scrFRSourceIRandom(20)), "=");
;
if ((fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(x, y) && frMacro_Objects_Frontier_Deeplabs_mod_gml_target_visible)) {
{
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction);
;
if ((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_distance > 160)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk((frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30)), scrFRAlarmRead(scrFRSelf(self), 1));
;
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(3, 5)) {
{
if ((meleeMode == true)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, HitWarning)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth - 1);
;
}
}
if(__fr_break3) break;
}}
scrFRAlarmWrite(scrFRSelf(self), 2, 10, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 1, (60 + scrFRSourceIRandom(30)), "=");
;
}
} else {
{
sprite_index = scrFRAreaSourceSprite(spr_fire_strt);
;
scrFRAlarmWrite(scrFRSelf(self), 1, 200, "=");
;
scrFRAlarmWrite(scrFRSelf(self), 2, 30, "=");
;
orbiterTime = 70;
;
}
}
}
} else {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (20 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), scrFRAlarmRead(scrFRSelf(self), 1));
}
}
}
}
}
} else {
{
if (fr_Objects_Frontier_Deeplabs_mod_gml_chance(1, 3)) {
{
scrFRAlarmWrite(scrFRSelf(self), 1, (40 + scrFRSourceIRandom(15)), "=");
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(scrFRSourceRandom(360), (scrFRAlarmRead(scrFRSelf(self), 1) - 10));
;
fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(direction);
;
}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1038
function fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_alrm2() {
if ((meleeMode == true)) {
{
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
scrFRSoundPitch(sndSwapSword, (0.6 + scrFRSourceRandom(0.2)));
;
scrFRSoundPlay(sndAssassinAttack);
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemySlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
damage = 3;
;
speed = (2) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + scrFRSourceRandomRange((- 3), 3));
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
creator = __fr_other5;
;
var __fr_other6=scrFROther(other);
team = __fr_other6.team;
var __fr_other7=scrFROther(other);
hitid = __fr_other7.hitid;
;
}
}
if(__fr_break3) break;
}}
scrFRMotionAdd(gunangle, 3.5);
;
wkick = (- 4);
;
wepangle *= (- 1);
;
}
} else {
{
if ((orbiterTime > 0)) {
{
scrFRAlarmWrite(scrFRSelf(self), 2, 1, "=");
;
if ((hasBalls == false)) {
{
sprite_index = scrFRAreaSourceSprite(spr_fire);
;
hasBalls = true;
;
var _frl__angle = 0;
;
repeat (3) {
{ var __fr_with8 = scrFRWithValues(fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_create(x, y, _frl__angle, scrFRSelf(self))), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
fr_surgeonBall = __fr_other12;
;
}
}
if(__fr_break10) break;
}}
_frl__angle += 120;
;
ballCount += 1;
;
}
}
} else {
{
if ((ballCount == 0)) {
{
orbiterTime = 1;
;
}
}
}
}
if (((-- orbiterTime) <= 0)) {
{
if ((ballCount > 0)) {
{
gunangle = frMacro_Objects_Frontier_Deeplabs_mod_gml_target_direction;
;
{ var __fr_with13 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_surgeonBall", scrFRSelf(self))), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
orbitMode = false;
;
var _frl__dir = (((scrFROther(other)).gunangle + 180) + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(30));
;
scrFRMotionSet(_frl__dir, (5 + scrFRSourceRandom(2)));
;
direction = _frl__dir;
;
image_angle = _frl__dir;
;
turnDelay = 5;
;
}
}
if(__fr_break15) break;
}}
{ var __fr_with16 = scrFRWithValues(scrFRMatching(FRCustomEnemy, "fr_surgeonBall", scrFRSelf(self))), __fr_break18=false;
for (var __fr_index17=0; __fr_index17<array_length(__fr_with16); ++__fr_index17) {
if(scrFRScopeExists(__fr_with16[__fr_index17])) with (__fr_with16[__fr_index17]) {
{
orbitMode = false;
;
}
}
if(__fr_break18) break;
}}
scrFRSoundPitch(sndFireShotgun, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndEraser, (1.1 + scrFRSourceRandom(0.3)));
;
scrFRInstanceCreate(x, y, PortalClear);
;
}
}
sprite_index = scrFRAreaSourceSprite(spr_fire_end);
;
hasBalls = false;
;
orbiterTime = 0;
;
ballCount = 0;
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1109
function fr_Objects_Frontier_Deeplabs_mod_gml_Surgeon_death() {
scrFRPickupDrop(55, 0);
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSoulSmoke);
;
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
image_xscale = (0.4 + scrFRSourceRandom(0.2));
;
image_yscale = image_xscale;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(4)) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1122
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_create(_frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomEnemy)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Spectre";
;
spr_idle = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinion;
;
spr_hurt = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinionHurt;
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonMinionDead;
;
spr_trail = sprPlasmaTrail;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
image_speed = (0.4) * timescale;
;
hitid = [sprite_index, "SPECTRE"];
;
depth = (- 9);
;
image_xscale = 1;
;
right = 1;
;
image_xscale = 1.5;
;
image_yscale = 1.5;
;
scrFRMaxHealthWrite(id, 4, "=");
;
hp = max_hp;
;
speed = (0) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
size = 1;
;
canmelee = true;
;
meleedamage = 2;
;
team = 1;
;
lifeTime = 450;
;
givekill = 0;
;
size = 1;
;
fr_surgeonBall = noone;
;
creator = _frl__creator;
;
pather = fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_create(x, y, _frl__angle, _frl__creator);
;
orbitMode = true;
;
canfly = true;
;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_step];
;
on_end_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_endstep];
;
on_draw = fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw;
;
on_hurt = fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_hurt;
;
on_death = fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_death;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1169
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_step() {
if (((sprite_index == spr_hurt) && frMacro_Objects_Frontier_Deeplabs_mod_gml_anim_end)) {
{
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
}
}
if ((orbitMode == true)) {
{
if ((! scrFRInstanceExists(creator))) {
{
pather.orbitMode = false;
;
orbitMode = false;
;
}
}
}
}
if ((scrFRSourceRandom(25) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSoulSmoke);
;
var __fr_other4=scrFROther(other);
depth = (__fr_other4.depth + 1);
;
image_xscale = (0.4 + scrFRSourceRandom(0.2));
;
image_yscale = image_xscale;
;
}
}
if(__fr_break3) break;
}}
}
}
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
hp = 0;
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1198
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_endstep() {
if (scrFRInstanceExists(pather)) {
{
x = pather.x;
;
y = pather.y;
;
image_angle = pather.image_angle;
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1205
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
sprite_index = scrFRAreaSourceSprite(spr_hurt);
;
image_index = 0;
;
scrFRSoundHit(snd_hurt, 0.3);
;
scrFRMotionSet(_frl__dir, _frl__spd);
;
direction = _frl__dir;
;
turnDelay = 6;
;
nexthurt = (scrFRSourceFrame() + 6);
;
hp -= _frl__dmg;
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1217
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinion_death() {
if ((scrFRInstanceExists(creator) && (orbitMode == true))) {
{
creator.ballCount -= 1;
;
}
}
if (scrFRInstanceExists(pather)) {
{
{ var __fr_with1 = scrFRWithValues(pather), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, CaveSparkle)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_dead);
;
var __fr_other8=scrFROther(other);
image_angle = __fr_other8.image_angle;
;
var __fr_other9=scrFROther(other);
depth = __fr_other9.depth;
;
}
}
if(__fr_break6) break;
}}
repeat (3) {
{ var __fr_with10 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSoulSmoke);
;
var __fr_other13=scrFROther(other);
depth = (__fr_other13.depth + 1);
;
image_xscale = (0.4 + scrFRSourceRandom(0.2));
;
image_yscale = image_xscale;
;
direction = scrFRSourceRandom(360);
;
speed = (scrFRSourceRandom(4)) * timescale;
;
}
}
if(__fr_break12) break;
}}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1242
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_create(_frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__creator=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_SpectrePather";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
scrFRMaxHealthWrite(id, 3, "=");
;
hp = max_hp;
;
speed = (3) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
turnPower = 0.2;
;
normalspeed = 2.5;
;
turnDelay = 0;
;
angle = _frl__angle;
;
dist = 0;
;
maxDist = 25;
;
orbitSpeed = 5;
;
orbitMode = true;
;
fr_surgeonBall = _frl__creator;
;
pather = noone;
;
creator = _frl__creator;
on_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_step];
;
on_end_step = ["mod", "Frontier_Deeplabs", fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_endstep];
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1272
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_step() {
if ((orbitMode == true)) {
{
if ((! scrFRInstanceExists(creator))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((dist < maxDist)) {
{
dist += (1 * scrFRSourceScale());
;
}
}
angle += (orbitSpeed * scrFRSourceScale());
;
image_angle = (angle + 90);
;
}
} else {
{
target = instance_nearest(x, y, Player);
;
if ((turnDelay <= 0)) {
{
if (scrFRInstanceExists(target)) {
{
direction -= (angle_difference(direction, point_direction(x, y, target.x, target.y)) * power(turnPower, scrFRSourceScale()));
;
}
}
}
} else {
{
turnDelay -= scrFRSourceScale();
;
}
}
image_angle = direction;
;
if (((scrFRSourceRandom(20) < 1) && (turnDelay <= 0))) {
{
direction += scrFRSourceRandom(360);
;
scrFRMotionSet(direction, (4 + scrFRSourceRandom(2)));
;
turnDelay = 5;
;
}
}
if (((speed / timescale) != normalspeed)) {
{
if (((speed / timescale) > normalspeed)) {
{
speed -= (0.25) * timescale;
;
}
} else {
{
speed += (0.5) * timescale;
;
}
}
}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1313
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonMinionPather_endstep() {
if ((orbitMode == true)) {
{
xprevious = (creator.x + lengthdir_x(dist, angle));
;
yprevious = (creator.y + lengthdir_y(dist, angle));
;
x = (creator.x + lengthdir_x(dist, angle));
;
y = (creator.y + lengthdir_y(dist, angle));
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1324
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GatorBubble";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubble);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubblePop;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGatorBubbleTrail;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
hitid = [sprite_index, "SLUDGE BUBBLE"];
;
depth = (- 3);
;
turnspeed = ((3 + scrFRSourceRandom(2)) * scrFRSourceChoose(1, (- 1)));
;
fr_bloom = [1.1, 0.2];
;
image_xscale = 0.2;
;
image_yscale = image_xscale;
;
maxSize = (0.8 + scrFRSourceRandom(0.2));
;
bubble_tiltspeed = scrFRSourceRandomRange(0.03, 0.1);
;
bubble_tiltrange = scrFRSourceRandomRange(25, 45);
;
mask_index = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskGatorBubble;
;
speed = (2) * timescale;
;
friction = (0.20) * (timescale * timescale);
;
typ = 0;
;
damage = 0;
;
team = 1;
;
lifeTime = 250;
;
maxed = false;
;
growspeed = 0.025;
;
powerPopped = false;
;
slowBox = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_create(x, y, scrFRSelf(self));
;
on_step = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_step;
;
on_hit = fr_Objects_Frontier_Deeplabs_mod_gml_nothing;
;
on_wall = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_wall;
;
on_destroy = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1366
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_step() {
if ((! scrFRInstanceExists(slowBox))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
image_angle = (0 + (sin((scrFRSourceFrame() * bubble_tiltspeed)) * bubble_tiltrange));
if ((maxed == false)) {
{
image_xscale += growspeed;
;
image_yscale = image_xscale;
;
if ((image_xscale >= maxSize)) {
{
maxed = true;
;
scrFRInstanceCreate(x, y, PortalClear);
;
repeat (5) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), AcidStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = point_direction(__fr_other4.x, __fr_other4.y, x, y);
;
image_angle = direction;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
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
if (((speed / timescale) > 0)) {
{
if ((scrFRSourceRandom(8) < 1)) {
{
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), PlasmaTrail)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other8.spr_trail);
;
var __fr_other9=scrFROther(other);
depth = (__fr_other9.depth - 1);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other10=scrFROther(other);
direction = ((__fr_other10.direction + 180) + scrFRSourceRandomRange((- 45), 45));
image_angle = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break7) break;
}}
}
}
}
}
if (scrFRPlaceMeeting((x + hspeed), (y + vspeed), InvisiWall)) {
{
fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_wall();
;
}
}
lifeTime -= scrFRSourceScale();
;
if ((lifeTime <= 0)) {
{
image_xscale -= 0.05;
;
image_yscale = image_xscale;
;
if ((image_xscale <= 0.2)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
}
}
slowBox.image_xscale = image_xscale;
;
slowBox.image_yscale = image_yscale;
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1423
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_wall() {
move_bounce_solid(true);
;
if (((speed / timescale) > 0)) {
{
var _frl__wall = (scrFROther(other));
;
repeat (2) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), AcidStreak)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
direction = point_direction(_frl__wall.x, _frl__wall.y, x, y);
;
image_angle = direction;
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break3) break;
}}
}
scrFRSoundPitch(sndBouncerBounce, (0.4 + scrFRSourceRandom(0.2)));
;
}
}
speed = (((speed / timescale) * 0.70)) * timescale;
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1438
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubble_destroy() {
if (scrFRInstanceExists(slowBox)) {
{
{ var __fr_with1 = scrFRWithValues(slowBox), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break3) break;
}}
}
}
scrFRSoundPitch(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sndThrasherBubblePop, (0.9 + scrFRSourceRandom(0.1)));
;
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
var __fr_other7=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other7.spr_dead);
;
}
}
if(__fr_break6) break;
}}
repeat (5) {
{ var __fr_with8 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 8), 8)), (y + scrFRSourceRandomRange((- 8), 8)), AcidStreak)), __fr_break10=false;
for (var __fr_index9=0; __fr_index9<array_length(__fr_with8); ++__fr_index9) {
if(scrFRScopeExists(__fr_with8[__fr_index9])) with (__fr_with8[__fr_index9]) {
{
var __fr_other11=scrFROther(other);
direction = point_direction(__fr_other11.x, __fr_other11.y, x, y);
;
image_angle = direction;
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break10) break;
}}
{ var __fr_with12 = scrFRWithValues(scrFRInstanceCreate((x + scrFRSourceRandomRange((- 16), 16)), (y + scrFRSourceRandomRange((- 16), 16)), PlasmaTrail)), __fr_break14=false;
for (var __fr_index13=0; __fr_index13<array_length(__fr_with12); ++__fr_index13) {
if(scrFRScopeExists(__fr_with12[__fr_index13])) with (__fr_with12[__fr_index13]) {
{
var __fr_other15=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other15.spr_trail);
;
var __fr_other16=scrFROther(other);
depth = (__fr_other16.depth - 1);
;
image_index = scrFRSourceChoose(0, 1);
;
var __fr_other17=scrFROther(other);
direction = point_direction(__fr_other17.x, __fr_other17.y, x, y);
;
image_angle = scrFRSourceRandom(360);
;
speed = ((2 + scrFRSourceRandom(3))) * timescale;
;
}
}
if(__fr_break14) break;
}}
}
if ((powerPopped == true)) {
{
repeat (18) {
{ var __fr_with18 = scrFRWithValues(scrFRInstanceCreate(x, y, EnemyBullet2)), __fr_break20=false;
for (var __fr_index19=0; __fr_index19<array_length(__fr_with18); ++__fr_index19) {
if(scrFRScopeExists(__fr_with18[__fr_index19])) with (__fr_with18[__fr_index19]) {
{
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((4 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other21=scrFROther(other);
team = __fr_other21.team;
;
var __fr_other22=scrFROther(other);
hitid = __fr_other22.hitid;
;
var __fr_other23=scrFROther(other);
creator = __fr_other23;
;
}
}
if(__fr_break20) break;
}}
}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1478
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_create(_frl__x=undefined, _frl__y=undefined, _frl__bubble=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_GatorBubbleSlowBox";
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].mskGatorBubbleSlowBox);
;
image_alpha = 0;
;
creator = _frl__bubble;
;
team = creator.team;
;
on_wall = fr_Objects_Frontier_Deeplabs_mod_gml_nothing;
;
on_hit = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_hit;
;
on_end_step = fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_endstep;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1495
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_hit() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
x = (xprevious + ((0.5 * scrFRSourceScale()) * (hspeed / timescale)));
;
y = (yprevious + ((0.5 * scrFRSourceScale()) * (vspeed / timescale)));
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1501
function fr_Objects_Frontier_Deeplabs_mod_gml_GatorBubbleSlowBox_endstep() {
if (scrFRInstanceExists(creator)) {
{
x = creator.x;
;
y = creator.y;
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1507
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_ravenslicer";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprRavenSlicer);
;
spr_dead = sprDiscBounce;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprRavenSlicerTrail;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
spinAngle = 1;
;
depth = (- 3);
;
mask_index = mskEnemyBullet1;
;
maxspeed = ((7 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
speed = (((maxspeed / timescale) - 1)) * timescale;
;
friction = (0.1) * (timescale * timescale);
;
typ = 1;
;
damage = 3;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "RAVEN SLICER"];
;
reverse = false;
;
on_step = fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_step;
;
on_wall = fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_wall;
;
on_destroy = fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1540
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_step() {
image_angle += ((18 + ((speed / timescale) * 5)) * scrFRSourceScale());
;
if ((((speed / timescale) <= 0.5) && (reverse == false))) {
{
reverse = true;
;
direction += 180;
;
friction = ((- 0.3)) * (timescale * timescale);
;
repeat (3) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), (y + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth + 1);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other6=scrFROther(other);
direction = (__fr_other6.direction + 180);
;
}
}
if(__fr_break3) break;
}}
}
}
}
if ((reverse == true)) {
{
if (((speed / timescale) >= (maxspeed / timescale))) {
{
friction = (0) * (timescale * timescale);
;
}
}
}
}
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), (y + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), BulletHit)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other10.spr_trail);
;
var __fr_other11=scrFROther(other);
depth = (__fr_other11.depth + 1);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other12=scrFROther(other);
direction = (__fr_other12.direction + 180);
;
}
}
if(__fr_break9) break;
}}
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1570
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_wall() {
scrFRSoundPitch(sndHitWall, (0.7 + scrFRSourceRandom(0.2)));
;
scrFRInstanceDestroy();
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1574
function fr_Objects_Frontier_Deeplabs_mod_gml_RavenSlicer_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1579
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonBullet_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_surgeonBullet";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonBullet);
;
image_index = scrFRSourceIRandom(image_number);
;
spr_dead = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonBulletHit;
;
spr_trail = global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprSurgeonBulletTrail;
;
image_speed = (0.4) * timescale;
;
image_angle = scrFRSourceRandom(360);
;
fr_bloom = [2, 0.1];
;
image_alpha = 0.8;
;
mask_index = mskEnemyBullet1;
;
maxspeed = ((8 * power(0.8, scrFRGetSkill(mut_euphoria)))) * timescale;
;
speed = (((maxspeed / timescale) - 1)) * timescale;
;
friction = (0.2) * (timescale * timescale);
;
typ = 1;
;
damage = 2;
;
var __fr_other4=scrFROther(other);
creator = __fr_other4;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
hitid = [sprite_index, "GLOBBLOB"];
;
on_step = fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonBullet_step;
;
on_destroy = fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonBullet_destroy;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1610
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonBullet_step() {
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate((x + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), (y + fr_Objects_Frontier_Deeplabs_mod_gml_orandom(6)), BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_trail);
;
var __fr_other5=scrFROther(other);
depth = (__fr_other5.depth + 1);
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
var __fr_other6=scrFROther(other);
direction = (__fr_other6.direction + 180);
;
}
}
if(__fr_break3) break;
}}
}
}
if (((speed / timescale) <= 0)) {
{
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1623
function fr_Objects_Frontier_Deeplabs_mod_gml_SurgeonBullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1628
function fr_Objects_Frontier_Deeplabs_mod_gml_DeeplabsOutputDecal_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_deeplabsOutputDecal";
;
sprite_index = scrFRAreaSourceSprite(mskNone);
;
depth = 7;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1638
function fr_Objects_Frontier_Deeplabs_mod_gml_TubeAmmoChest_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, AmmoChest)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
scrFRModCall("area", "deeplabs", "BigTube_throw");
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
fr_Objects_Frontier_Deeplabs_mod_gml_TubeAmmoChestController_create(_frl__x, _frl__y);
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1646
function fr_Objects_Frontier_Deeplabs_mod_gml_TubeAmmoChestController_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
eep = 1;
;
on_step = fr_Objects_Frontier_Deeplabs_mod_gml_TubeAmmoChestController_step;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1656
function fr_Objects_Frontier_Deeplabs_mod_gml_TubeAmmoChestController_step() {
if ((eep > 0)) {
{
eep -= scrFRSourceScale();
;
}
} else {
{
{ var __fr_with1 = scrFRWithValues(instance_nearest(x, y, chestprop)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRInstanceIs(scrFRSelf(self), AmmoChestMystery)) {
{
instance_change(AmmoChest, 0);
;
scrFRModCall("area", "deeplabs", "BigTube_throw");
}
}
}
}
if(__fr_break3) break;
}}
scrFRInstanceDestroy();
;
}
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1674
function fr_Objects_Frontier_Deeplabs_mod_gml_FishFreakCorpse_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Corpse)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprFishFreakDead);
;
image_index = 0;
;
direction = scrFRSourceRandom(360);
;
speed = ((4 + scrFRSourceRandom(5))) * timescale;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1684
function fr_Objects_Frontier_Deeplabs_mod_gml_FrozenCar_spawn(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Car)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
spr_idle = sprFrozenCar;
;
spr_hurt = sprFrozenCarHurt;
;
sprite_index = scrFRAreaSourceSprite(spr_idle);
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
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
; // macro hoisted: bbox_center_x
; // macro hoisted: bbox_center_y
}

// Original Objects/Frontier_Deeplabs.mod.gml:1713
function fr_Objects_Frontier_Deeplabs_mod_gml_pround(_frl__num=undefined, _frl__precision=undefined) {
return ((_frl__precision == 0) ? _frl__num : (round((_frl__num / _frl__precision)) * _frl__precision));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1714
function fr_Objects_Frontier_Deeplabs_mod_gml_orandom(_frl__num=undefined) {
return scrFRSourceRandomRange((- _frl__num), _frl__num);
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1715
function fr_Objects_Frontier_Deeplabs_mod_gml_chance(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < _frl__numer);
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1716
function fr_Objects_Frontier_Deeplabs_mod_gml_chance_ct(_frl__numer=undefined, _frl__denom=undefined) {
return (scrFRSourceRandom(_frl__denom) < (_frl__numer * scrFRSourceScale()));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1717
function fr_Objects_Frontier_Deeplabs_mod_gml_angle_lerp_ct(_frl__ang1=undefined, _frl__ang2=undefined, _frl__num=undefined) {
return (_frl__ang2 + (angle_difference(_frl__ang1, _frl__ang2) * power((1 - _frl__num), scrFRSourceScale())));
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1718
function fr_Objects_Frontier_Deeplabs_mod_gml_enemy_walk(_frl__dir=undefined, _frl__num=undefined) {
direction = _frl__dir;
;
walk = _frl__num;
;
if (((speed / timescale) < (friction / (timescale * timescale)))) {
speed = ((friction / (timescale * timescale))) * timescale;
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1719
function fr_Objects_Frontier_Deeplabs_mod_gml_enemy_face(_frl__dir=undefined) {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1720
function fr_Objects_Frontier_Deeplabs_mod_gml_enemy_look(_frl__dir=undefined) {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1721
function fr_Objects_Frontier_Deeplabs_mod_gml_enemy_target(_frl__x=undefined, _frl__y=undefined) {
target = (scrFRInstanceExists(Player) ? instance_nearest(_frl__x, _frl__y, Player) : ((scrFRInstanceExists(target) && (target >= 0)) ? target : noone));
;
return (target != noone);
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1722
function fr_Objects_Frontier_Deeplabs_mod_gml_BasicEnemy_draw() {
scrFRDrawSpriteExt(sprite_index, image_index, x, y, (image_xscale * right), image_yscale, image_angle, image_blend, image_alpha);
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1723
function fr_Objects_Frontier_Deeplabs_mod_gml_GunEnemy_draw() {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1724
function fr_Objects_Frontier_Deeplabs_mod_gml_MeleeEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Deeplabs_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Deeplabs_mod_gml_draw_weapon(spr_weap, 0, x, y, gunangle, wepangle, wkick, 1, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1725
function fr_Objects_Frontier_Deeplabs_mod_gml_MortarEnemy_draw() {
if ((gunangle <= 180)) {
fr_Objects_Frontier_Deeplabs_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
image_xscale *= right;
;
draw_self();
;
image_xscale /= right;
;
if ((gunangle > 180)) {
fr_Objects_Frontier_Deeplabs_mod_gml_draw_weapon(spr_weap, 0, x, y, lerp(90, 45, dcos(gunangle)), 0, wkick, right, image_blend, image_alpha);
}
}

// Original Objects/Frontier_Deeplabs.mod.gml:1726
function fr_Objects_Frontier_Deeplabs_mod_gml_nothing() {

}

// Original Objects/Frontier_Deeplabs.mod.gml:1727
function fr_Objects_Frontier_Deeplabs_mod_gml_Enemy_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1737
function fr_Objects_Frontier_Deeplabs_mod_gml_Prop_hurt(_frl__dmg=undefined, _frl__spd=undefined, _frl__dir=undefined) {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1746
function fr_Objects_Frontier_Deeplabs_mod_gml_draw_weapon(_frl__sprite=undefined, _frl__image=undefined, _frl__x=undefined, _frl__y=undefined, _frl__angle=undefined, _frl__angleMelee=undefined, _frl__kick=undefined, _frl__flip=undefined, _frl__blend=undefined, _frl__alpha=undefined) {
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

// Original Objects/Frontier_Deeplabs.mod.gml:1769
function fr_Objects_Frontier_Deeplabs_mod_gml_sound_play_hit_ext(_frl__sound=undefined, _frl__pitch=undefined, _frl__volume=undefined) {
var _frl__snd = scrFRSoundHit(_frl__sound, 0);
;
scrFRSoundSetPitch(_frl__snd, _frl__pitch);
;
scrFRSoundVolume(_frl__snd, (audio_sound_get_gain(_frl__snd) * _frl__volume));
;
return _frl__snd;
;
}

// Original Objects/Frontier_Deeplabs.mod.gml:1781
function fr_Objects_Frontier_Deeplabs_mod_gml_GenericTrail_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, Wind)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "mod:Frontier_Deeplabs"].sprGenericTrail);
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
