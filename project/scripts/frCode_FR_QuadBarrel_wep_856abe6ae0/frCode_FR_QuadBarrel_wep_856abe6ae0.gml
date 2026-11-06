// Original Weapons/FR_QuadBarrel.wep.gml:1
function fr_Weapons_FR_QuadBarrel_wep_gml___load() {

}

// Original Weapons/FR_QuadBarrel.wep.gml:1
function fr_Weapons_FR_QuadBarrel_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_QuadBarrel"].sprWeapon = sprFR_sprQuadBarrel_886f4d2fa430;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:6
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_name() {
return scrFRLocalize("QUAD-BARREL");
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:7
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_text() {
return scrFRLocalize("BLOW THE MAN DOWN");
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:8
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_sprt() {
return global.fr_module_vars[$ "weapon:FR_QuadBarrel"].sprWeapon;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:9
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_type() {
return 2;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:10
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:11
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_area() {
return scrFRModCall("mod", "Frontier_Projectiles", "check_piratedrops", "FR_QuadBarrel", 12);
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:12
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_auto() {
return false;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:13
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_load() {
return 120;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:14
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_cost() {
return 15;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:15
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_swap() {
return sndSwapShotgun;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:16
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_QuadBarrel.wep.gml:17
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_handy_data() {
return {"x": 7, "y": 5, "bhand": true, "bx": 14, "by": 7};
}

// Original Weapons/FR_QuadBarrel.wep.gml:19
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundGun(sndSuperFlakCannon, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndDoubleShotgun, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRSoundGun(sndNukeExplosion, 1, (1 + scrFRSourceRandom(0.2)));
;
scrFRInstanceCreate(x, y, PortalClear);
;
repeat (56) {
{ var __fr_with1 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "Grapeshot_create", x, y)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
speed = ((10 + scrFRSourceRandom(10))) * timescale;
;
var __fr_other4=scrFROther(other);
direction = (__fr_other4.gunangle + (scrFRSourceRandomRange((- 32), 32) * __fr_other4.accuracy));
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
repeat (16) {
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, Bullet2)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
speed = ((4 + scrFRSourceRandom(16))) * timescale;
;
var __fr_other10=scrFROther(other);
direction = (__fr_other10.gunangle + (scrFRSourceRandomRange((- 32), 32) * __fr_other10.accuracy));
;
image_angle = direction;
friction = ((0.4 + scrFRSourceRandomRange((- 0.2), 0.2))) * (timescale * timescale);
;
var __fr_other11=scrFROther(other);
team = __fr_other11.team;
;
var __fr_other12=scrFROther(other);
creator = __fr_other12;
;
}
}
if(__fr_break9) break;
}}
}
repeat (4) {
{ var __fr_with13 = scrFRWithValues(scrFRInstanceCreate(x, y, FlakBullet)), __fr_break15=false;
for (var __fr_index14=0; __fr_index14<array_length(__fr_with13); ++__fr_index14) {
if(scrFRScopeExists(__fr_with13[__fr_index14])) with (__fr_with13[__fr_index14]) {
{
speed = ((4 + scrFRSourceRandom(16))) * timescale;
;
var __fr_other16=scrFROther(other);
direction = (__fr_other16.gunangle + (scrFRSourceRandomRange((- 32), 32) * __fr_other16.accuracy));
;
image_angle = direction;
friction = ((0.4 + scrFRSourceRandomRange((- 0.2), 0.2))) * (timescale * timescale);
;
var __fr_other17=scrFROther(other);
team = __fr_other17.team;
;
var __fr_other18=scrFROther(other);
creator = __fr_other18;
;
}
}
if(__fr_break15) break;
}}
}
repeat (12) {
{ var __fr_with19 = scrFRWithValues(scrFRInstanceCreate(x, y, Slug)), __fr_break21=false;
for (var __fr_index20=0; __fr_index20<array_length(__fr_with19); ++__fr_index20) {
if(scrFRScopeExists(__fr_with19[__fr_index20])) with (__fr_with19[__fr_index20]) {
{
speed = ((4 + scrFRSourceRandom(16))) * timescale;
;
var __fr_other22=scrFROther(other);
direction = (__fr_other22.gunangle + (scrFRSourceRandomRange((- 32), 32) * __fr_other22.accuracy));
;
image_angle = direction;
friction = ((0.4 + scrFRSourceRandomRange((- 0.2), 0.2))) * (timescale * timescale);
;
var __fr_other23=scrFROther(other);
team = __fr_other23.team;
;
var __fr_other24=scrFROther(other);
creator = __fr_other24;
;
}
}
if(__fr_break21) break;
}}
}
repeat (16) {
{ var __fr_with25 = scrFRWithValues(scrFRModCall("mod", "Frontier_Projectiles", "WhiteDust_create", x, y)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
speed = ((5 + scrFRSourceRandom(8))) * timescale;
;
var __fr_other28=scrFROther(other);
direction = (__fr_other28.gunangle + (scrFRSourceRandomRange((- 22), 22) * __fr_other28.accuracy));
;
var __fr_other29=scrFROther(other);
team = __fr_other29.team;
;
var __fr_other30=scrFROther(other);
creator = __fr_other30;
;
depth = (- 3);
;
}
}
if(__fr_break27) break;
}}
}
scrFRWeaponPost(16, 70, 70);
;
scrFRMotionAdd((gunangle + 180), 20);
}

// Original Weapons/FR_QuadBarrel.wep.gml:87
function fr_Weapons_FR_QuadBarrel_wep_gml_weapon_reloaded() {
scrFRSoundPitchVolume(sndClick, (0.5 + scrFRSourceRandom(0.3)), 0.45);
;
wkick -= 3;
;
}
