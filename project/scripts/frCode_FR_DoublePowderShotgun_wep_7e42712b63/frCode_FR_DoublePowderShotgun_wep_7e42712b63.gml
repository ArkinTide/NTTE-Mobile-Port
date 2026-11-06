// Original Weapons/FR_DoublePowderShotgun.wep.gml:1
function fr_Weapons_FR_DoublePowderShotgun_wep_gml___load() {

}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:1
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprWeapon = sprFR_sprDoublePowderShotgun_dd0c3a2cc6a1;
;
global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprGunpowderShell = sprFR_sprGunpowderShell_082772075542;
;
global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprGunpowderShellBig = sprFR_sprGunpowderShellBig_5c3f0b64cab8;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:8
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_name() {
return scrFRLocalize("DOUBLE POWDER SHOTGUN");
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:9
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_text() {
return scrFRLocalize("THINGS ARE HEATING UP");
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:10
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprWeapon;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:11
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:12
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:13
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_DoublePowderShotgun", 10);
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:14
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:15
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_load() {
return 42;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:16
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_cost() {
return 6;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:17
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:18
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:19
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_handy_data() {
return {"x": 4, "y": 4, "bhand": true, "bx": 14, "by": 5};
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:21
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndGrenadeShotgun, 1, (1.2 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndDoubleFireShotgun, 1, (0.8 + scrFRSourceRandom(0.2)));
;
repeat (13) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "GunpowderShell_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((10 + scrFRSourceRandom(7))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 26), 26) * __fr_other4.accuracy));
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
scrFRWeaponPost(8, 7, 7);
;
scrFRMotionAdd((gunangle + 180), 3);
}

// Original Weapons/FR_DoublePowderShotgun.wep.gml:46
function fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_reloaded() {
wkick = (- 4);
;
scrFRSoundPlay(sndShotReload);
;
repeat (fr_Weapons_FR_DoublePowderShotgun_wep_gml_weapon_cost()) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((scrFRGetSkill(mut_shotgun_shoulders) ? global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprGunpowderShellBig : global.fr_module_vars[$ "weapon:FR_DoublePowderShotgun"].sprGunpowderShell));
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.gunangle + (__fr_other4.right * 90)) + scrFRSourceRandomRange((- 40), 40)), (2 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
}
