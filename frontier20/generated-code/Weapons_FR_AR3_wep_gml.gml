// Original Weapons/FR_AR3.wep.gml:1
function fr_Weapons_FR_AR3_wep_gml___load() {

}

// Original Weapons/FR_AR3.wep.gml:1
function fr_Weapons_FR_AR3_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_AR3"].sprWeapon = sprFR_sprAR3_86972ca2065f;
;
}

// Original Weapons/FR_AR3.wep.gml:6
function fr_Weapons_FR_AR3_wep_gml_weapon_name() {
return scrFRLocalize("H.E.P.V.O.D.D.");
;
}

// Original Weapons/FR_AR3.wep.gml:7
function fr_Weapons_FR_AR3_wep_gml_weapon_text() {
return scrFRLocalize("'HIGH ENERGY PELLET'-BASED#VAPORIZATION-ORIENTED#DISTURBANCE DISRUPTOR");
;
}

// Original Weapons/FR_AR3.wep.gml:8
function fr_Weapons_FR_AR3_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_AR3"].sprWeapon;
;
}

// Original Weapons/FR_AR3.wep.gml:9
function fr_Weapons_FR_AR3_wep_gml_weapon_type() {
return 5;
;
}

// Original Weapons/FR_AR3.wep.gml:10
function fr_Weapons_FR_AR3_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_AR3.wep.gml:11
function fr_Weapons_FR_AR3_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") == true) ? 21 : (- 1));
;
}

// Original Weapons/FR_AR3.wep.gml:12
function fr_Weapons_FR_AR3_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_AR3.wep.gml:13
function fr_Weapons_FR_AR3_wep_gml_weapon_load() {
return 24;
;
}

// Original Weapons/FR_AR3.wep.gml:14
function fr_Weapons_FR_AR3_wep_gml_weapon_cost() {
return 6;
;
}

// Original Weapons/FR_AR3.wep.gml:15
function fr_Weapons_FR_AR3_wep_gml_weapon_swap() {
return sndSwapMachinegun;
;
}

// Original Weapons/FR_AR3.wep.gml:16
function fr_Weapons_FR_AR3_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_AR3.wep.gml:17
function fr_Weapons_FR_AR3_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 5, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/FR_AR3.wep.gml:19
function fr_Weapons_FR_AR3_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
if ((scrFRGetSkill(mut_laser_brain) > 0)) {
{
scrFRSoundPitch(sndEnergyHammerUpg, (0.7 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndPlasmaHit, (0.45 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndPlasmaUpg, (1.15 + scrFRSourceRandom(0.3)));
;
}
} else {
{
scrFRSoundPitch(sndEnergyHammerUpg, (0.7 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndPlasmaHit, (0.45 + scrFRSourceRandom(0.3)));
;
scrFRSoundPitch(sndPlasma, (1.15 + scrFRSourceRandom(0.3)));
;
}
}
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "EnergyPellet_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 4), 4) * __fr_other4.accuracy));
;
image_angle = direction;
;
}
}
if(__fr_break3) break;
}}
scrFRWeaponPost(10, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (3) {
{ var __fr_with5 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break7=false;
for (var __fr_index6=0; __fr_index6<array_length(__fr_with5); ++__fr_index6) {
if(scrFRScopeExists(__fr_with5[__fr_index6])) with (__fr_with5[__fr_index6]) {
{
sprite_index = scrFRAreaSourceSprite(sprSmoke);
;
var __fr_other8=scrFROther(other);
direction = (__fr_other8.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
depth = (- 3);
}
}
if(__fr_break7) break;
}}
}
}
