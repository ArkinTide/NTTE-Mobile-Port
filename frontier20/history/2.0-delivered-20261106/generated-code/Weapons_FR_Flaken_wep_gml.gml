// Original Weapons/FR_Flaken.wep.gml:1
function fr_Weapons_FR_Flaken_wep_gml___load() {

}

// Original Weapons/FR_Flaken.wep.gml:1
function fr_Weapons_FR_Flaken_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_Flaken"].sprWeapon = sprFR_sprFlaken_5e6ab742ec0c;
;
global.fr_module_vars[$ "weapon:FR_Flaken"].sprInkFlakRing = sprFR_sprInkFlakRing_2190b1560efc;
;
}

// Original Weapons/FR_Flaken.wep.gml:7
function fr_Weapons_FR_Flaken_wep_gml_weapon_name() {
return "FLAKEN";
;
}

// Original Weapons/FR_Flaken.wep.gml:8
function fr_Weapons_FR_Flaken_wep_gml_weapon_text() {
return scrFRSourceChoose("DON'T STAND TOO CLOSE", "I CANT SEE");
;
}

// Original Weapons/FR_Flaken.wep.gml:9
function fr_Weapons_FR_Flaken_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_Flaken"].sprWeapon;
;
}

// Original Weapons/FR_Flaken.wep.gml:10
function fr_Weapons_FR_Flaken_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_Flaken.wep.gml:11
function fr_Weapons_FR_Flaken_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_Flaken.wep.gml:12
function fr_Weapons_FR_Flaken_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_Flaken", 12);
;
}

// Original Weapons/FR_Flaken.wep.gml:13
function fr_Weapons_FR_Flaken_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_Flaken.wep.gml:14
function fr_Weapons_FR_Flaken_wep_gml_weapon_load() {
return 25;
;
}

// Original Weapons/FR_Flaken.wep.gml:15
function fr_Weapons_FR_Flaken_wep_gml_weapon_cost() {
return 2;
;
}

// Original Weapons/FR_Flaken.wep.gml:16
function fr_Weapons_FR_Flaken_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_Flaken.wep.gml:17
function fr_Weapons_FR_Flaken_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_Flaken.wep.gml:18
function fr_Weapons_FR_Flaken_wep_gml_weapon_handy_data() {
return {"x": 1, "y": 4, "bhand": true, "bx": 10, "by": 5};
}

// Original Weapons/FR_Flaken.wep.gml:20
function fr_Weapons_FR_Flaken_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndOasisChest, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndSlugger, 1, (1 + scrFRSourceRandom(0.2)));
;
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "InkBigFlak_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 3), 3) * __fr_other4.accuracy));
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
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate((x + lengthdir_x(14, gunangle)), (y + lengthdir_y(14, gunangle)), CaveSparkle)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_Flaken"].sprInkFlakRing);
;
image_speed = (0.6) * timescale;
;
var __fr_other10=scrFROther(other);
image_angle = __fr_other10.gunangle;
;
}
}
if(__fr_break9) break;
}}
scrFRWeaponPost(8, 6, 10);
;
scrFRMotionAdd((gunangle + 180), 2);
}

// Original Weapons/FR_Flaken.wep.gml:47
function fr_Weapons_FR_Flaken_wep_gml_weapon_reloaded() {
scrFRSoundPitchVolume(sndOasisShoot, (1.2 + scrFRSourceRandom(0.3)), 0.45);
;
wkick -= 3;
;
}
