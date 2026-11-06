// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:1
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml___load() {

}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:1
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_init() {
global.fr_module_vars[$ "weapon:bouncer volley gun"].sprWeapon = sprFR_sprBouncerVolleyGun_4d267e60f4b0;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:6
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_name() {
return "BOUNCER VOLLEY GUN";
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:7
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_text() {
return "OOIUUGHHH IM BOUNCINNG";
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:8
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:bouncer volley gun"].sprWeapon;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:9
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_type() {
return 1;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:10
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:11
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_area() {
return (- 1);
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:12
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:13
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_load() {
return 14;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:14
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_cost() {
return 7;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:15
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:16
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:17
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 5, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/Iris Weapons/bouncer volley gun.wep.gml:18
function fr_Weapons_Iris_Weapons_bouncer_volley_gun_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndBouncerShotgun, (0.9 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndBouncerSmg, (1.2 + scrFRSourceRandom(0.3)), 1);
;
repeat (9) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, BouncerBullet)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((7 + scrFRSourceRandomRange((- 2), 2))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 14), 14) * __fr_other4.accuracy));
;
image_angle = direction;
;
var __fr_other5=scrFROther(other);
team = __fr_other5.team;
;
var __fr_other6=scrFROther(other);
creator = __fr_other6;
;
}
}
if(__fr_break3) break;
}}
}
scrFRWeaponPost(10, 16, 20);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (6) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
}
}
if(__fr_break9) break;
}}
}
}
