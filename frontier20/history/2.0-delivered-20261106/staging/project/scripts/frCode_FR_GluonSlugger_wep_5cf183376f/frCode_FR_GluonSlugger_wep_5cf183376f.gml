// Original Weapons/FR_GluonSlugger.wep.gml:1
function fr_Weapons_FR_GluonSlugger_wep_gml___load() {

}

// Original Weapons/FR_GluonSlugger.wep.gml:1
function fr_Weapons_FR_GluonSlugger_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprWeapon = sprFR_sprGluonSlugger_1091a87d587d;
;
global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprGluonSlugShell = sprFR_sprGluonSlugShell_dba465404bfa;
;
global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprGluonSlugShellBig = sprFR_sprGluonSlugShellBig_0e0ccf09dfae;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:8
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_name() {
return "SLUGLUON";
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:9
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_text() {
return "ITS QUARKY!!!!!";
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:10
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprWeapon;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:11
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:12
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:13
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") == true) ? 21 : (- 1));
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:14
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:15
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_load() {
return 40;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:16
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_cost() {
return 4;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:17
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:19
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_GluonSlugger.wep.gml:20
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_handy_data() {
return {"x": 2, "y": 4, "bhand": true, "bx": 13, "by": 5};
}

// Original Weapons/FR_GluonSlugger.wep.gml:22
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndHeavySlugger, 1.2, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndPlasmaHit, 1.2, (1 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles2", "GluonSlug_create", (x + lengthdir_x(10, gunangle)), (y + lengthdir_y(10, gunangle)))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 8), 8) * __fr_other4.accuracy));
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
scrFRWeaponPost(14, 40, 30);
;
scrFRMotionAdd((gunangle + 180), 1);
}

// Original Weapons/FR_GluonSlugger.wep.gml:45
function fr_Weapons_FR_GluonSlugger_wep_gml_weapon_reloaded() {
wkick = (- 4);
scrFRSoundPlay(sndShotReload);
scrFRSoundPitch(sndPlasmaReloadUpg, 0.8);
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, Shell)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite((scrFRGetSkill(mut_shotgun_shoulders) ? global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprGluonSlugShellBig : global.fr_module_vars[$ "weapon:FR_GluonSlugger"].sprGluonSlugShell));
;
var __fr_other4=scrFROther(other);
scrFRMotionAdd(((__fr_other4.gunangle + (__fr_other4.right * 90)) + scrFRSourceRandomRange((- 40), 40)), (2 + scrFRSourceRandom(2)));
;
}
}
if(__fr_break3) break;
}}
}
