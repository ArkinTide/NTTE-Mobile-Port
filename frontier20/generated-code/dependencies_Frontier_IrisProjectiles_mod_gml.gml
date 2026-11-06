#macro frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr

#macro frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_msk global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.msk

#macro frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons scrFRGetSkill("excitedneurons")

#macro frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_brain_active (scrFRGetSkill(mut_laser_brain) > 0)

// Original dependencies/Frontier_IrisProjectiles.mod.gml:1
function fr_dependencies_Frontier_IrisProjectiles_mod_gml___load() {
; // macro hoisted: spr
; // macro hoisted: msk
; // macro hoisted: neurons
; // macro hoisted: brain_active
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:10
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_init() {
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr = {};
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.msk = {};
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.FireBullet = sprFR_2e38014ba2f5ece58360018c_739482c12be2;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.FireBulletHit = sprFR_51d4b4b45526303932e569d2_22054c059df7;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.FireBulletBounce = sprFR_0caafdcd11b66bf4121c70aa_81545163d666;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.GammaBullet = sprFR_d0b052b4e32c5bfed1e2ca73_3c12ef662b75;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.GammaBulletHit = sprFR_b55f25bb7b9ed339d402ae23_41b88feee68b;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.GammaBulletBounce = sprFR_e9012a0f57526fc2d83dd1ba_a89b2ad338e1;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.ToxicBullet = sprFR_d66363e2ac2c0ba8e41b3c59_5f3f7faf3e39;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.ToxicBulletHit = sprFR_efc9df4c995fe769bee116f8_a76e8bf6fbac;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.ToxicBulletBounce = sprFR_0f097584450052f802c8ee4e_831575318696;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.PsyBullet = sprFR_a187f4cb8456c534b18cd28b_dcea145d4cd5;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.PsyBulletHit = sprFR_cef17752acb0d3ec64b6d419_b06b95d84ada;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.PsyBulletBounce = sprFR_565b6a4820266012ad8f8f55_4ec1a735dfeb;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.msk.PsyBullet = sprFR_a91fdacc4f4d2e2a41dd3e01_42898eab27d9;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBullet = sprFR_b0a6d47b071a1341764dd4de_b62296e47713;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletUpg = sprFR_590d2d92257b8b833bdfcbba_3c19c232b89e;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletHit = sprFR_086ae3c3e5b1c1f115b3ff07_a9e4d212d44c;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletBounce = sprFR_9aaf006efd4bcdbe5cecd695_4ab1adf47484;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletBounceUpg = sprFR_77a6f3135835287b8d0ed884_6203aae692a7;
;
global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletUpgBounce = global.fr_module_vars[$ "mod:Frontier_IrisProjectiles"].spr.LightningBulletBounceUpg;
;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:34
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_script_ref_call_self(_frl_scr=undefined) {
return scrFRScriptCall(_frl_scr);
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:40
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_chance_raw(_frl_percentage=undefined) {
return (scrFRSourceRandom(100) <= _frl_percentage);
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:44
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_angle_approach(_frl_a=undefined, _frl_b=undefined, _frl_n=undefined, _frl_dn=undefined) {
return (angle_difference(_frl_a, _frl_b) * (1 - power(((_frl_n - 1) / _frl_n), _frl_dn)));
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:48
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_instance_nearest_matching_ne(_frl__x=undefined, _frl__y=undefined, _frl_obj=undefined, _frl_varname=undefined, _frl_value=undefined) {
var _frl_num = scrFRInstanceNumber(_frl_obj);
var _frl_man = instance_nearest(_frl__x, _frl__y, _frl_obj);
var _frl_mans = [];
var _frl_n = 0;
var _frl_found = (- 4);
;
if (scrFRInstanceExists(_frl_obj)) {
{
while (((((++ _frl_n) <= _frl_num) && (scrFRVariableGet(_frl_man, _frl_varname) == _frl_value)) || (scrFRInstanceIs(_frl_man, prop) && (! scrFRInstanceIs(_frl_man, BigGenerator))))) {
_frl_man.x += 10000;
array_push(_frl_mans, _frl_man);
_frl_man = instance_nearest(_frl__x, _frl__y, _frl_obj);
}
if (((scrFRVariableGet(_frl_man, _frl_varname) != _frl_value) && ((! scrFRInstanceIs(_frl_man, prop)) || scrFRInstanceIs(_frl_man, BigGenerator)))) {
_frl_found = _frl_man;
}
{ var __fr_with1 = scrFRWithValues(_frl_mans), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
x -= 10000;
}
if(__fr_break3) break;
}}
}
}
return _frl_found;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:66
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_shell_hit() {
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, ((scrFRSourceFrame() < fallofftime) ? damage : (damage - falloff)), (knockback_speed / timescale), direction);
;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:70
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_iris_bullet_anim() {
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_anim();
if ((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0)) {
{
speed -= ((((speed / timescale) / 4) + 1)) * timescale;
image_angle = scrFRSourceRandom(360);
if ((on_step != undefined)) {
{
bouncer_step_wrap = on_step;
on_step = fr_dependencies_Frontier_IrisProjectiles_mod_gml_iris_bouncer_step;
}
} else {
{
on_step = fr_dependencies_Frontier_IrisProjectiles_mod_gml_bouncer_spin;
}
}
}
}
on_anim = fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_anim;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:87
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_iris_bouncer_step() {
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bouncer_spin();
fr_dependencies_Frontier_IrisProjectiles_mod_gml_script_ref_call_self(bouncer_step_wrap);
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:92
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bouncer_spin() {
image_angle += ((bouncer_turn_dir * bouncer_turn_speed) * scrFRSourceScale());
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:96
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_init() {
name = "Bullet";
sprite_index = scrFRAreaSourceSprite(sprBullet1);
spr_dead = sprBulletHit;
mask_index = mskBullet1;
image_speed = (1) * timescale;
defbloom = {"xscale": 2, "yscale": 2, "alpha": .1};
recycle_amount = 1;
knockback_speed = (8) * timescale;
damage = 3;
typ = 1;
bounce = (0 + (4 * frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons));
bounce_color = c_orange;
snd_bounce = {"snd": sndBouncerBounce, "pitch": 1, "vol": 1};
bouncer_turn_dir = scrFRSourceChoose((- 1), 1);
bouncer_turn_speed = 6;
bouncer_step_wrap = undefined;
on_anim = fr_dependencies_Frontier_IrisProjectiles_mod_gml_iris_bullet_anim;
on_wall = fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_wall;
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_hit;
on_destroy = fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_destroy;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:133
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl_x, _frl_y, FRCustomProjectile)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_init();
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:141
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_slash_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl_x, _frl_y, FRCustomSlash)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_init();
name = "Slash Bullet";
typ = 0;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:152
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_hit() {
var __fr_other1=scrFROther(other);
scrFRProjectileHit(__fr_other1, damage, (knockback_speed / timescale), direction);
;
fr_dependencies_Frontier_IrisProjectiles_mod_gml_recycle_gland_roll();
scrFRInstanceDestroy();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:158
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:162
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_anim() {
image_index = 1;
image_speed = (0) * timescale;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:167
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_wall() {
scrFRInstanceCreate(x, y, Dust);
if (((bounce--) > 0)) {
{
move_bounce_solid(false);
direction += scrFRSourceRandomRange((- bouncer_turn_speed), bouncer_turn_speed);
if (frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons) {
{
image_blend = merge_color(image_blend, bounce_color, .2);
scrFRInstanceCreate((x + (hspeed / timescale)), (y + (vspeed / timescale)), CaveSparkle);
damage += 1;
speed += (.5) * timescale;
}
}
scrFRSoundHitExt(snd_bounce.snd, (snd_bounce.pitch + scrFRRandomNonsync(.1)), snd_bounce.vol);
return true;
}
}
scrFRSoundHit(sndHitWall, .2);
scrFRInstanceDestroy();
return false;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:191
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_recycle_gland_roll() {
var _frl__chance = ((argument_count > 0) ? (argument_count>0 ? argument[0] : undefined) : 60);
;
var _frl__gland = (scrFRGetSkill(mut_recycle_gland) + (10 * scrFRGetSkill("recycleglandx10")));
;
if ((recycle_amount != 0)) {
{
if (fr_dependencies_Frontier_IrisProjectiles_mod_gml_chance_raw((_frl__chance * _frl__gland))) {
{
scrFRInstanceCreate(x, y, RecycleGland);
scrFRSoundPlay(sndRecGlandProc);
var _frl_num = (recycle_amount * _frl__gland);
{ var __fr_with1 = scrFRWithValues(creator), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
if (scrFRInstanceIs(scrFRSelf(self), Player)) {
{
scrFRMemberIndexWrite(scrFRSelf(self), "ammo", [1], min((scrFRIndexGet(ammo, 1) + _frl_num), scrFRIndexGet(scrFRAmmoArray(scrFRSelf(self), "typ_amax"), 1)), "=");
}
}
}
if(__fr_break3) break;
}}
return true;
}
}
}
}
return false;
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:210
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_psy_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_bullet(_frl_x, _frl_y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Psy Bullet";
sprite_index = scrFRAreaSourceSprite(((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0) ? frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.PsyBulletBounce : frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.PsyBullet));
mask_index = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_msk.PsyBullet;
spr_dead = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.PsyBulletHit;
bounce_color = c_purple;
damage = 4;
typ = 2;
knockback_speed = ((- 10)) * timescale;
timer = (scrFRSourceIRandom(6) + 4);
range = 70;
turnspeed = .3;
on_step = fr_dependencies_Frontier_IrisProjectiles_mod_gml_psy_step;
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_psy_hit;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:232
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_psy_step() {
if ((timer > 0)) {
{
timer -= scrFRSourceScale();
}
}
if ((timer <= 0)) {
{
var _frl_closeboy = fr_dependencies_Frontier_IrisProjectiles_mod_gml_instance_nearest_matching_ne(x, y, hitme, "team", team);
if (((scrFRInstanceExists(_frl_closeboy) && (distance_to_object(_frl_closeboy) < range)) && (collision_line(x, y, _frl_closeboy.x, _frl_closeboy.y, Wall, 0, 0) < 0))) {
{
var _frl_dir = undefined;
var _frl_spd = undefined;
var _frl_dif = undefined;
;
_frl_dir = point_direction(x, y, _frl_closeboy.x, _frl_closeboy.y);
;
_frl_spd = (((speed / timescale) * 5) * scrFRSourceScale());
_frl_dif = clamp(fr_dependencies_Frontier_IrisProjectiles_mod_gml_angle_approach(direction, _frl_dir, (1 / turnspeed), scrFRSourceScale()), (- _frl_spd), _frl_spd);
direction -= _frl_dif;
;
image_angle -= _frl_dif;
}
}
}
}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:253
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_psy_hit() {
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
var __fr_other4=scrFROther(other);
scrFRMotionAdd(point_direction(x, y, __fr_other4.x, __fr_other4.y), 5);
}
if(__fr_break3) break;
}}
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_hit();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:259
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_gamma_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_slash_bullet(_frl_x, _frl_y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Gamma Bullet";
sprite_index = scrFRAreaSourceSprite(((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0) ? frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.GammaBulletBounce : frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.GammaBullet));
spr_dead = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.GammaBulletHit;
bounce_color = c_lime;
knockback_speed = (4) * timescale;
damage = 2;
typ = 1;
pierce = 1;
lasthit = (- 4);
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_gamma_hit;
on_projectile = fr_dependencies_Frontier_IrisProjectiles_mod_gml_gamma_projectile;
on_grenade = fr_dependencies_Frontier_IrisProjectiles_mod_gml_nothing;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:282
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_gamma_projectile() {
if ((scrFRInstanceExists((scrFROther(other))) && ((scrFROther(other)).typ > 0))) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
scrFRInstanceDestroy();
}
if(__fr_break3) break;
}}
if ((scrFRInstanceExists(scrFRSelf(self)) && ((-- pierce) < 0))) {
scrFRInstanceDestroy();
}
}
}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:290
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_gamma_hit() {
if ((lasthit != (scrFROther(other)))) {
{
var __fr_other1=scrFROther(other);
lasthit = __fr_other1;
sleep(((damage * 2) + 3));
scrFRViewShakeMaxAt(x, y, (damage * 2));
var __fr_other2=scrFROther(other);
scrFRProjectileHit(__fr_other2, damage, (knockback_speed / timescale), direction);
if (fr_dependencies_Frontier_IrisProjectiles_mod_gml_recycle_gland_roll(40)) {
{
recycle_amount = 0;
}
}
if (((-- pierce) < 0)) {
scrFRInstanceDestroy();
}
}
}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:303
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_nothing() {

}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:306
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_lightning_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_bullet(_frl_x, _frl_y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Lightning Bullet";
var _frl_s = "LightningBullet";
;
if (frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_brain_active) {
_frl_s += "Upg";
}
if ((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0)) {
_frl_s += "Bounce";
}
sprite_index = scrFRAreaSourceSprite(scrFRLQGet(frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr, _frl_s));
spr_dead = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.LightningBulletHit;
bounce_color = c_aqua;
charge = scrFRSourceChoose(2, 2, 3);
knockback_speed = (5) * timescale;
damage = 3;
typ = 2;
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_new_thunder_hit;
on_destroy = fr_dependencies_Frontier_IrisProjectiles_mod_gml_new_thunder_destroy;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:336
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_new_thunder_hit() {
if ((!scrFRVariableExists((scrFROther(other)), "thunder_charge"))) {
{
var __fr_other1=scrFROther(other);
__fr_other1.thunder_charge = 0;
}
}
var __fr_other2=scrFROther(other);
__fr_other2.thunder_charge += charge;
var _frl__team = team;
var _frl__c = creator;
;
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_hit();
var _frl_laserbrain = ceil(scrFRGetSkill(mut_laser_brain));
;
if (((scrFROther(other)).hp <= 0)) {
{
var _frl__charge = max((scrFROther(other)).thunder_charge, 5);
;
while ((_frl__charge > 0)) {
var _frl_r = min(((scrFRSourceIRandom(_frl__charge) + 1) + _frl_laserbrain), (12 + _frl_laserbrain));
;
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate((scrFROther(other)).x, (scrFROther(other)).y, Lightning)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
image_angle = scrFRSourceRandom(360);
direction = image_angle;
ammo = (_frl_r + 1);
creator = _frl__c;
team = _frl__team;
scrFRAlarmWrite(scrFRSelf(self), 0, (scrFRSourceIRandom(1) + 1), "=");
}
}
if(__fr_break5) break;
}}
_frl__charge -= max((_frl_r - _frl_laserbrain), 1);
}
var __fr_other6=scrFROther(other);
scrFRViewShakeAt(__fr_other6.x, __fr_other6.y, (__fr_other6.thunder_charge / 5));
var __fr_other7=scrFROther(other);
scrFRSoundPitchVolume(sndLightningCannonEnd, (1 + max((1 - (__fr_other7.thunder_charge / 30)), (- .8))), .4);
if (_frl_laserbrain) {
{
scrFRSoundPitchVolume(sndLightningPistolUpg, .8, .4);
}
}
}
}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:366
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_new_thunder_destroy() {
scrFRInstanceCreate((x + scrFRSourceRandomRange((- 5), 5)), (y + scrFRSourceRandomRange((- 5), 5)), LightningHit);
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_destroy();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:371
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_toxic_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_bullet(_frl_x, _frl_y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Toxic Bullet";
sprite_index = scrFRAreaSourceSprite(((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0) ? frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.ToxicBulletBounce : frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.ToxicBullet));
spr_dead = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.ToxicBulletHit;
bounce_color = c_lime;
knockback_speed = (8) * timescale;
damage = 4;
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_toxic_hit;
on_destroy = fr_dependencies_Frontier_IrisProjectiles_mod_gml_toxic_destroy;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:388
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_toxic_hit() {
var __fr_other1=scrFROther(other);
fr_dependencies_Frontier_IrisProjectiles_mod_gml_poison(__fr_other1);
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_hit();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:393
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_poison(_frl_target=undefined) {
{ var __fr_with1 = scrFRWithValues(_frl_target), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "poisoned"))) {
{
poisoned = 60;
;
}
} else {
{
if ((poisoned <= 60)) {
{
poisoned = 100;
;
}
} else {
{
poisoned += (40 - (poisoned mod 20));
}
}
}
}
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:409
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_toxic_destroy() {
repeat (scrFRSourceChoose(1, 1, 2)) { var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, ToxicGas)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
friction *= 10;
;
growspeed /= 8;
;
var __fr_other4=scrFROther(other);
move_contact_solid(__fr_other4.direction, (__fr_other4.speed / timescale));
;
}
}
if(__fr_break3) break;
}}
fr_dependencies_Frontier_IrisProjectiles_mod_gml_bullet_destroy();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:418
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_fire_bullet(_frl_x=undefined, _frl_y=undefined) {
{ var __fr_with1 = scrFRWithValues(fr_dependencies_Frontier_IrisProjectiles_mod_gml_create_bullet(_frl_x, _frl_y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "Fire Bullet";
sprite_index = scrFRAreaSourceSprite(((frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_neurons > 0) ? frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.FireBulletBounce : frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.FireBullet));
spr_dead = frMacro_dependencies_Frontier_IrisProjectiles_mod_gml_spr.FireBulletHit;
bounce_color = c_red;
image_speed = (0) * timescale;
;
damage = 5;
falloff = 2;
fallofftime = (scrFRSourceFrame() + 4);
defbloom.alpha = .2;
on_step = fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_step;
on_destroy = fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_destroy;
on_hit = fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_bullet_hit;
return real(id);
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:439
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_bullet_hit() {
fr_dependencies_Frontier_IrisProjectiles_mod_gml_shell_hit();
fr_dependencies_Frontier_IrisProjectiles_mod_gml_recycle_gland_roll();
scrFRInstanceDestroy();
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:446
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_step() {
if ((fallofftime >= scrFRSourceFrame())) {
{
image_index = 1;
;
}
}
if (((fallofftime < scrFRSourceFrame()) && (defbloom.alpha != .1))) {
{
defbloom.alpha = .1;
;
image_index = 2;
;
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
team = __fr_other4.team;
var __fr_other5=scrFROther(other);
creator = __fr_other5.creator;
damage = 1;
;
}
}
if(__fr_break3) break;
}}
}
}
}

// Original dependencies/Frontier_IrisProjectiles.mod.gml:461
function fr_dependencies_Frontier_IrisProjectiles_mod_gml_fire_destroy() {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BulletHit)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
sprite_index = scrFRAreaSourceSprite(__fr_other4.spr_dead);
image_index = 1;
}
}
if(__fr_break3) break;
}}
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Flame)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
var __fr_other8=scrFROther(other);
team = __fr_other8.team;
;
var __fr_other9=scrFROther(other);
creator = __fr_other9.creator;
;
var __fr_other10=scrFROther(other);
scrFRMotionAdd(__fr_other10.direction, scrFRSourceRandomRange(4, 6));
friction = (2) * (timescale * timescale);
;
damage = 1;
;
}
}
if(__fr_break7) break;
}}
}
