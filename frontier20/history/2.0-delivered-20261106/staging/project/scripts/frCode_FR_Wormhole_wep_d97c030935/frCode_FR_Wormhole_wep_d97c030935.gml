// Original Weapons/FR_Wormhole.wep.gml:1
function fr_Weapons_FR_Wormhole_wep_gml___load() {

}

// Original Weapons/FR_Wormhole.wep.gml:1
function fr_Weapons_FR_Wormhole_wep_gml_init() {
global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWeapon = [sprFR_sprUnstableWormholeInact_0415bb6bbd2a, sprFR_sprUnstableWormholeBulle_0ac213d7ddc6, sprFR_sprUnstableWormholeShell_3173ffc01ba7, sprFR_sprUnstableWormholeBolt_a9cb4383503c, sprFR_sprUnstableWormholeExplo_74619495ce7b, sprFR_sprUnstableWormholeEnerg_1da24655e02e];
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWormholeBall = sprFR_sprUnstableWormholeBall_3d5824f66cf1;
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWormholeSpark = sprFR_sprWormholeSpark_28ea2c299e2f;
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].knownMods = [];
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeList_init();
;
}

// Original Weapons/FR_Wormhole.wep.gml:19
function fr_Weapons_FR_Wormhole_wep_gml_weapon_name() {
return "UNSTABLE WORMHOLE";
;
}

// Original Weapons/FR_Wormhole.wep.gml:20
function fr_Weapons_FR_Wormhole_wep_gml_weapon_text() {
return "WHAT'S HAPPENING";
;
}

// Original Weapons/FR_Wormhole.wep.gml:21
function fr_Weapons_FR_Wormhole_wep_gml_weapon_sprt(_frl__wep=undefined) {
return ((! is_struct(_frl__wep)) ? scrFRIndexGet(global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWeapon, 0) : scrFRIndexGet(global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWeapon, _frl__wep.spriteIndex));
;
}

// Original Weapons/FR_Wormhole.wep.gml:22
function fr_Weapons_FR_Wormhole_wep_gml_weapon_type(_frl__wep=undefined) {
if (is_struct(_frl__wep)) {
{
return _frl__wep.wormholeType;
;
}
} else {
{
return 1;
;
}
}
}

// Original Weapons/FR_Wormhole.wep.gml:29
function fr_Weapons_FR_Wormhole_wep_gml_weapon_melee() {
return false;
;
}

// Original Weapons/FR_Wormhole.wep.gml:30
function fr_Weapons_FR_Wormhole_wep_gml_weapon_area() {
return ((scrFRModGet("mod", "Frontier_Projectiles", "settingNaturalLabsWeps") == true) ? 20 : (- 1));
;
}

// Original Weapons/FR_Wormhole.wep.gml:31
function fr_Weapons_FR_Wormhole_wep_gml_weapon_auto() {
return true;
;
}

// Original Weapons/FR_Wormhole.wep.gml:32
function fr_Weapons_FR_Wormhole_wep_gml_weapon_load() {
return 38;
;
}

// Original Weapons/FR_Wormhole.wep.gml:33
function fr_Weapons_FR_Wormhole_wep_gml_weapon_cost(_frl__wep=undefined) {
return ((! is_struct(_frl__wep)) ? 8 : _frl__wep.ammoCost);
;
}

// Original Weapons/FR_Wormhole.wep.gml:34
function fr_Weapons_FR_Wormhole_wep_gml_weapon_swap() {
scrFRSoundPitchVolume(sndNothing2Ball, (0.9 + scrFRSourceRandom(0.1)), 0.6);
;
return sndSwapMotorized;
;
}

// Original Weapons/FR_Wormhole.wep.gml:37
function fr_Weapons_FR_Wormhole_wep_gml_weapon_handy() {
return true;
;
}

// Original Weapons/FR_Wormhole.wep.gml:38
function fr_Weapons_FR_Wormhole_wep_gml_weapon_handy_data() {
return {"x": (- 1), "y": 4, "bhand": true, "bx": 8, "by": 5};
}

// Original Weapons/FR_Wormhole.wep.gml:40
function fr_Weapons_FR_Wormhole_wep_gml_weapon_reloaded() {
wkick += 3;
;
}

// Original Weapons/FR_Wormhole.wep.gml:43
function fr_Weapons_FR_Wormhole_wep_gml_weapon_fire(_frl__wep=undefined) {
var _frl_c = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
scrFRSoundPitchVolume(sndNothing2Beam, (1.2 + scrFRSourceRandom(0.3)), 0.75);
;
scrFRSoundPitchVolume(sndSuperFlakCannon, (1.2 + scrFRSourceRandom(0.3)), 1);
;
var _frl__bonus = ((scrFRSourceRandom(5) < 1) ? true : false);
;
repeat ((1 + _frl__bonus)) {
{ var __fr_switch_value1=_frl__wep.wormholeSpawnType, __fr_switch_case2=-1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Basegame")) __fr_switch_case2=0;
if(__fr_switch_case2==-1 && __fr_switch_value1==("Mod")) __fr_switch_case2=1;
if(__fr_switch_case2==-1 && __fr_switch_value1==("OBJ")) __fr_switch_case2=2;
if(__fr_switch_case2==-1) __fr_switch_case2=-1;
switch(__fr_switch_case2) {
case 0:
repeat (scrFRSourceIRandomRange(_frl__wep.wormholeProjectileMin, _frl__wep.wormholeProjectileMax)) {
{ var __fr_with3 = scrFRWithValues(scrFRInstanceCreate(x, y, _frl__wep.wormholeSpawnObject)), __fr_break5=false;
for (var __fr_index4=0; __fr_index4<array_length(__fr_with3); ++__fr_index4) {
if(scrFRScopeExists(__fr_with3[__fr_index4])) with (__fr_with3[__fr_index4]) {
{
var __fr_other6=scrFROther(other);
direction = (__fr_other6.gunangle + (scrFRSourceRandomRange((- _frl__wep.wormholeProjectileSpread), _frl__wep.wormholeProjectileSpread) * __fr_other6.accuracy));
;
image_angle = direction;
;
var __fr_other7=scrFROther(other);
team = __fr_other7.team;
;
var __fr_other8=scrFROther(other);
creator = __fr_other8;
;
speed = (scrFRSourceRandomRange(_frl__wep.wormholeProjectileSpeedMin, _frl__wep.wormholeProjectileSpeedMax)) * timescale;
}
}
if(__fr_break5) break;
}}
}
break;
;
case 1:
repeat (scrFRSourceIRandomRange(_frl__wep.wormholeProjectileMin, _frl__wep.wormholeProjectileMax)) {
{ var __fr_with9 = scrFRWithValues(scrFRModCall("mod", _frl__wep.wormholeSpawnMod, _frl__wep.wormholeSpawnObject, x, y)), __fr_break11=false;
for (var __fr_index10=0; __fr_index10<array_length(__fr_with9); ++__fr_index10) {
if(scrFRScopeExists(__fr_with9[__fr_index10])) with (__fr_with9[__fr_index10]) {
{
var __fr_other12=scrFROther(other);
direction = (__fr_other12.gunangle + (scrFRSourceRandomRange((- _frl__wep.wormholeProjectileSpread), _frl__wep.wormholeProjectileSpread) * __fr_other12.accuracy));
;
image_angle = direction;
;
var __fr_other13=scrFROther(other);
team = __fr_other13.team;
;
var __fr_other14=scrFROther(other);
creator = __fr_other14;
;
speed = (scrFRSourceRandomRange(_frl__wep.wormholeProjectileSpeedMin, _frl__wep.wormholeProjectileSpeedMax)) * timescale;
}
}
if(__fr_break11) break;
}}
}
break;
;
case 2:
repeat (scrFRSourceIRandomRange(_frl__wep.wormholeProjectileMin, _frl__wep.wormholeProjectileMax)) {
{ var __fr_with15 = scrFRWithValues(scrFRModCall("mod", _frl__wep.wormholeSpawnMod, "obj_create", x, y, _frl__wep.wormholeSpawnObject)), __fr_break17=false;
for (var __fr_index16=0; __fr_index16<array_length(__fr_with15); ++__fr_index16) {
if(scrFRScopeExists(__fr_with15[__fr_index16])) with (__fr_with15[__fr_index16]) {
{
var __fr_other18=scrFROther(other);
direction = (__fr_other18.gunangle + (scrFRSourceRandomRange((- _frl__wep.wormholeProjectileSpread), _frl__wep.wormholeProjectileSpread) * __fr_other18.accuracy));
;
image_angle = direction;
;
var __fr_other19=scrFROther(other);
team = __fr_other19.team;
;
var __fr_other20=scrFROther(other);
creator = __fr_other20;
;
speed = (scrFRSourceRandomRange(_frl__wep.wormholeProjectileSpeedMin, _frl__wep.wormholeProjectileSpeedMax)) * timescale;
}
}
if(__fr_break17) break;
}}
}
break;
;
}
}
if (_frl__bonus) {
{
fr_Weapons_FR_Wormhole_wep_gml_wormhole_next_projectile(_frl__wep, false);
;
}
}
}
scrFRWeaponPost(10, 2, 2);
;
scrFRMotionAdd((gunangle + 180), 1);
repeat (6) {
{ var __fr_with21 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break23=false;
for (var __fr_index22=0; __fr_index22<array_length(__fr_with21); ++__fr_index22) {
if(scrFRScopeExists(__fr_with21[__fr_index22])) with (__fr_with21[__fr_index22]) {
{
var __fr_other24=scrFROther(other);
direction = (__fr_other24.gunangle + scrFRSourceRandomRange((- 45), 45));
;
speed = ((3 + scrFRSourceRandom(2))) * timescale;
;
image_blend = c_black;
;
}
}
if(__fr_break23) break;
}}
}
repeat (8) {
{ var __fr_with25 = scrFRWithValues(scrFRInstanceCreate(x, y, Dust)), __fr_break27=false;
for (var __fr_index26=0; __fr_index26<array_length(__fr_with25); ++__fr_index26) {
if(scrFRScopeExists(__fr_with25[__fr_index26])) with (__fr_with25[__fr_index26]) {
{
var __fr_other28=scrFROther(other);
direction = (__fr_other28.gunangle + scrFRSourceRandomRange((- 25), 25));
;
speed = ((5 + scrFRSourceRandom(4))) * timescale;
;
image_blend = c_black;
;
}
}
if(__fr_break27) break;
}}
}
{ var __fr_with29 = scrFRWithValues(scrFRMatching(FRCustomObject, "fr_wormball", (scrFROther(other)))), __fr_break31=false;
for (var __fr_index30=0; __fr_index30<array_length(__fr_with29); ++__fr_index30) {
if(scrFRScopeExists(__fr_with29[__fr_index30])) with (__fr_with29[__fr_index30]) {
{
scrFRInstanceDestroy();
;
}
}
if(__fr_break31) break;
}}
fr_Weapons_FR_Wormhole_wep_gml_wormhole_next_projectile(_frl__wep, true);
;
}

// Original Weapons/FR_Wormhole.wep.gml:131
function fr_Weapons_FR_Wormhole_wep_gml_wormhole_next_projectile(_frl__wep=undefined, _frl__switchAmmo=undefined) {
if (_frl__switchAmmo) {
{
if ((_frl__wep.wormholeType < 5)) {
{
_frl__wep.wormholeType += 1;
;
}
} else {
{
_frl__wep.wormholeType = 1;
;
}
}
}
}
_frl__wep.spriteIndex = _frl__wep.wormholeType;
;
var _frl__ammoCosts = [1, 32, 8, 7, 6, 10];
;
_frl__wep.ammoCost = scrFRIndexGet(_frl__ammoCosts, _frl__wep.wormholeType);
var _frl__listList = [global.fr_module_vars[$ "weapon:FR_Wormhole"].typelessWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].bulletWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].shellWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].boltWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].explosiveWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].energyWormholeList];
var _frl__list = scrFRIndexGet(_frl__listList, _frl__wep.wormholeType);
;
ds_list_shuffle(_frl__list);
;
var _frl__projectile = ds_list_find_value(_frl__list, 0);
;
_frl__wep.wormholeSpawnObject = scrFRIndexGet(_frl__projectile, 0);
;
_frl__wep.wormholeSpawnType = scrFRIndexGet(_frl__projectile, 1);
;
_frl__wep.wormholeSpawnMod = scrFRIndexGet(_frl__projectile, 2);
;
_frl__wep.wormholeProjectileMin = scrFRIndexGet(_frl__projectile, 3);
;
_frl__wep.wormholeProjectileMax = scrFRIndexGet(_frl__projectile, 4);
;
_frl__wep.wormholeProjectileSpread = scrFRIndexGet(_frl__projectile, 5);
;
_frl__wep.wormholeProjectileSpeedMin = scrFRIndexGet(_frl__projectile, 6);
;
_frl__wep.wormholeProjectileSpeedMax = scrFRIndexGet(_frl__projectile, 7);
;
}

// Original Weapons/FR_Wormhole.wep.gml:162
function fr_Weapons_FR_Wormhole_wep_gml_step() {
var _frl__wep = ((argument_count>0 ? argument[0] : undefined) ? scrFRWeaponSlotRead(scrFRSelf(self), "wep") : scrFRWeaponSlotRead(scrFRSelf(self), "bwep"));
;
if ((! is_struct(_frl__wep))) {
{
fr_Weapons_FR_Wormhole_wep_gml_lwo_initialize(_frl__wep);
;
exit;
;
}
}
if ((scrFRSourceWeaponEqual(scrFRWeaponSlotRead((scrFROther(other)), "wep"), _frl__wep) || ((scrFROther(other)).race == scrFRRaceResolve("steroids")))) {
{
if ((((scrFROther(other)).reload <= 0) && (scrFRIndexGet((scrFROther(other)).ammo, _frl__wep.wormholeType) >= _frl__wep.ammoCost))) {
{
if ((array_length(scrFRMatching(FRCustomObject, "fr_wormball", (scrFROther(other)))) == 0)) {
{
{ var __fr_with1 = scrFRWithValues((scrFROther(other))), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
fr_Weapons_FR_Wormhole_wep_gml_WormholeBall_create(x, y, scrFRSelf(self), (_frl__wep.spriteIndex - 1), _frl__wep);
;
scrFRSoundPitchVolume(sndPlasma, (0.4 + scrFRSourceRandom(0.3)), 0.6);
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
}

// Original Weapons/FR_Wormhole.wep.gml:180
function fr_Weapons_FR_Wormhole_wep_gml_lwo_initialize(_frl__wep=undefined) {
var _frl__creator = ((scrFRInstanceIs(scrFRSelf(self), FRFireCont) && scrFRVariableExists(scrFRSelf(self), "creator")) ? creator : scrFRSelf(self));
;
_frl__wep = {"wep": _frl__wep, "wormholeType": scrFRSourceIRandomRange(1, 5), "wormholeSpawnObject": 0, "wormholeSpawnType": 0, "wormholeSpawnMod": 0, "wormholeProjectileMin": 0, "wormholeProjectileMax": 0, "wormholeProjectileSpread": 0, "wormholeProjectileSpeedMin": 0, "wormholeProjectileSpeedMax": 0, "spriteIndex": 0, "ammoCost": 1};
;
fr_Weapons_FR_Wormhole_wep_gml_wormhole_next_projectile(_frl__wep, true);
if ((scrFRVariableExists(_frl__creator, "wep") && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(_frl__creator, "wep"), scrFRWeaponSlotRead(_frl__wep, "wep")))) {
{
scrFRWeaponSlotWrite(_frl__creator, "wep", _frl__wep);
;
}
}
if ((scrFRVariableExists(_frl__creator, "bwep") && scrFRSourceWeaponEqual(scrFRWeaponSlotRead(_frl__creator, "bwep"), scrFRWeaponSlotRead(_frl__wep, "wep")))) {
{
scrFRWeaponSlotWrite(_frl__creator, "bwep", scrFRLQClone(_frl__wep));
;
}
}
}

// Original Weapons/FR_Wormhole.wep.gml:210
function fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(_frl__spawnObject=undefined, _frl__spawnType=undefined, _frl__spawnMod=undefined, _frl__ammoType=undefined, _frl__projectileMin=undefined, _frl__projectileMax=undefined, _frl__projectileSpread=undefined, _frl__projectileSpeedMin=undefined, _frl__projectileSpeedMax=undefined) {
var _frl__listList = [global.fr_module_vars[$ "weapon:FR_Wormhole"].typelessWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].bulletWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].shellWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].boltWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].explosiveWormholeList, global.fr_module_vars[$ "weapon:FR_Wormhole"].energyWormholeList];
var _frl__list = scrFRIndexGet(_frl__listList, _frl__ammoType);
;
ds_list_add(_frl__list, [_frl__spawnObject, _frl__spawnType, _frl__spawnMod, _frl__projectileMin, _frl__projectileMax, _frl__projectileSpread, _frl__projectileSpeedMin, _frl__projectileSpeedMax]);
;
}

// Original Weapons/FR_Wormhole.wep.gml:225
function fr_Weapons_FR_Wormhole_wep_gml_WormholeList_init() {
global.fr_module_vars[$ "weapon:FR_Wormhole"].typelessWormholeList = ds_list_create();
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].bulletWormholeList = ds_list_create();
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].shellWormholeList = ds_list_create();
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].boltWormholeList = ds_list_create();
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].explosiveWormholeList = ds_list_create();
;
global.fr_module_vars[$ "weapon:FR_Wormhole"].energyWormholeList = ds_list_create();
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Bullet1, "Basegame", undefined, 1, 45, 60, 20, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(HeavyBullet, "Basegame", undefined, 1, 18, 30, 15, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(BouncerBullet, "Basegame", undefined, 1, 16, 46, 32, 6, 10);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(UltraBullet, "Basegame", undefined, 1, 16, 24, 12, 14, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("FlameBullet_create", "Mod", "Frontier_Projectiles", 1, 16, 24, 20, 12, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("TeleBullet_create", "Mod", "Frontier_Projectiles2", 1, 10, 20, 26, 10, 16);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Bullet2, "Basegame", undefined, 2, 26, 48, 25, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(FlameShell, "Basegame", undefined, 2, 24, 40, 18, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Slug, "Basegame", undefined, 2, 14, 32, 18, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(HeavySlug, "Basegame", undefined, 2, 5, 12, 16, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(HyperSlug, "Basegame", undefined, 2, 7, 15, 20, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(FlakBullet, "Basegame", undefined, 2, 3, 8, 16, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(SuperFlakBullet, "Basegame", undefined, 2, 2, 6, 22, 12, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("Grapeshot_create", "Mod", "Frontier_Projectiles", 2, 20, 48, 20, 10, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("InkBigFlak_create", "Mod", "Frontier_Projectiles", 2, 2, 5, 20, 10, 16);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("GluonSlug_create", "Mod", "Frontier_Projectiles2", 2, 1, 4, 20, 8, 11);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Bolt, "Basegame", undefined, 3, 8, 14, 20, 16, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(HeavyBolt, "Basegame", undefined, 3, 4, 14, 14, 16, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Splinter, "Basegame", undefined, 3, 12, 40, 35, 12, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Disc, "Basegame", undefined, 3, 12, 40, 14, 4, 9);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Seeker, "Basegame", undefined, 3, 12, 20, 18, 6, 9);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(ToxicBolt, "Basegame", undefined, 3, 4, 16, 18, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(UltraBolt, "Basegame", undefined, 3, 3, 14, 12, 16, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("BallistaBolt_create", "Mod", "Frontier_Projectiles", 3, 3, 10, 14, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("Sawblade_create", "Mod", "Frontier_Projectiles", 3, 5, 20, 20, 7, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("PlagueBolt_create", "Mod", "Frontier_Projectiles2", 3, 1, 3, 24, 15, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Grenade, "Basegame", undefined, 4, 8, 20, 15, 8, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(HeavyGrenade, "Basegame", undefined, 4, 6, 18, 15, 8, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(BloodGrenade, "Basegame", undefined, 4, 8, 20, 15, 6, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(BloodBall, "Basegame", undefined, 4, 2, 7, 15, 6, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Flare, "Basegame", undefined, 4, 4, 8, 22, 8, 14);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(ClusterNade, "Basegame", undefined, 4, 5, 15, 20, 10, 14);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(SmallGrenade, "Basegame", undefined, 4, 12, 46, 24, 10, 16);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(FlameBall, "Basegame", undefined, 4, 3, 9, 22, 5, 10);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(ToxicGrenade, "Basegame", undefined, 4, 8, 20, 24, 12, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Nuke, "Basegame", undefined, 4, 1, 12, 7, 6, 10);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(UltraGrenade, "Basegame", undefined, 4, 2, 8, 20, 12, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Flame, "Basegame", undefined, 4, 64, 100, 22, 6, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("FlameRocket_create", "Mod", "Frontier_Projectiles", 4, 3, 9, 26, 2, 6);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("Blunderball_create", "Mod", "Frontier_Projectiles", 4, 3, 12, 18, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("HeavyBlunderball_create", "Mod", "Frontier_Projectiles", 4, 3, 8, 16, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("HiveRocket_create", "Mod", "Frontier_Projectiles2", 4, 2, 7, 16, 2, 6);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("FireworkCandle_create", "Mod", "Frontier_Projectiles", 4, 3, 11, 26, 13, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("FireworkRocket_create", "Mod", "Frontier_Projectiles", 4, 1, 3, 26, 14, 17);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(PlasmaBall, "Basegame", undefined, 5, 8, 16, 7, 8, 8);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(PlasmaBig, "Basegame", undefined, 5, 3, 5, 16, 8, 8);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(PlasmaHuge, "Basegame", undefined, 5, 1, 3, 14, 8, 8);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(LightningBall, "Basegame", undefined, 5, 3, 8, 14, 4, 10);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(LaserCannon, "Basegame", undefined, 5, 2, 4, 20, 0, 0);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add(Devastator, "Basegame", undefined, 5, 2, 5, 26, 6, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("EnergyPellet_create", "Mod", "Frontier_Projectiles2", 5, 4, 12, 16, 5, 10);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("StarBullet_create", "Mod", "Frontier_Projectiles", 5, 10, 32, 24, 9, 15);
;
if (scrFRModLoaded("mod", "ntte")) {
{
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("BoneArrow", "OBJ", "telib", 3, 6, 13, 14, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("BatDisc", "OBJ", "telib", 3, 6, 13, 14, 8, 14);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("BubbleBomb", "OBJ", "telib", 4, 8, 16, 14, 4, 9);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("ElectroPlasma", "OBJ", "telib", 5, 7, 12, 14, 4, 9);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("QuasarBeam", "OBJ", "telib", 5, 2, 5, 14, 0, 0);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("LightningDisc", "OBJ", "telib", 5, 5, 12, 14, 6, 14);
;
}
}
if (scrFRModLoaded("mod", "defpack tools")) {
{
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_light_bullet", "Mod", "defpack tools", 1, 10, 24, 24, 14, 22);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_split_shell", "Mod", "defpack tools", 2, 10, 24, 32, 8, 16);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_burster", "Mod", "defpack tools", 2, 10, 24, 32, 8, 16);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_stickydisc", "Mod", "defpack tools", 3, 2, 12, 20, 3, 6);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_megadisc", "Mod", "defpack tools", 3, 1, 6, 20, 3, 6);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_shuriken", "Mod", "defpack tools", 3, 4, 12, 24, 12, 22);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_knife", "Mod", "defpack tools", 3, 4, 12, 24, 12, 22);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_bouncerdisc", "Mod", "defpack tools", 3, 4, 12, 24, 3, 6);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("create_vector", "Mod", "defpack tools", 5, 2, 5, 40, 9, 14);
;
}
}
if (scrFRModLoaded("mod", "va_weptools")) {
{
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("ribbonBullet_create", "Mod", "va_weptools", 1, 12, 30, 24, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("gluonBullet_create", "Mod", "va_weptools", 1, 12, 30, 24, 14, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("pierceShell_create", "Mod", "va_weptools", 2, 16, 32, 48, 11, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("toxicPierceShell_create", "Mod", "va_weptools", 2, 16, 32, 24, 11, 20);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("pinFlak_create", "Mod", "va_weptools", 2, 4, 7, 32, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("dusterFlak_create", "Mod", "va_weptools", 2, 4, 7, 32, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("superDusterFlak_create", "Mod", "va_weptools", 2, 2, 5, 24, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("superPinFlak_create", "Mod", "va_weptools", 2, 2, 5, 24, 11, 18);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("digsaw_create", "Mod", "va_weptools", 3, 4, 12, 24, 6, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("smartsaw_create", "Mod", "va_weptools", 3, 4, 12, 24, 6, 12);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("bigsaw_create", "Mod", "va_weptools", 3, 2, 5, 42, 1, 3);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("bigbrainsaw_create", "Mod", "va_weptools", 3, 1, 4, 42, 2, 4);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("breachGrenade_create", "Mod", "va_weptools", 4, 4, 12, 30, 17, 23);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("toxicBreachGrenade_create", "Mod", "va_weptools", 4, 4, 12, 30, 17, 23);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("heavyBreachGrenade_create", "Mod", "va_weptools", 4, 2, 4, 16, 7, 11);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("breakerGrenade_create", "Mod", "va_weptools", 4, 2, 4, 16, 16, 19);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("qube_create", "Mod", "va_weptools", 5, 3, 6, 20, 2, 5);
;
fr_Weapons_FR_Wormhole_wep_gml_WormholeProjectile_add("superQube_create", "Mod", "va_weptools", 5, 1, 3, 20, 3, 6);
;
}
}
}

// Original Weapons/FR_Wormhole.wep.gml:373
function fr_Weapons_FR_Wormhole_wep_gml_wep_raw(_frl__wep=undefined) {
var _frl__rawWep = _frl__wep;
;
while (is_struct(_frl__rawWep)) {
_frl__rawWep = (scrFRVariableExists(_frl__rawWep, "wep") ? scrFRWeaponSlotRead(_frl__rawWep, "wep") : wep_none);
;
}
if ((is_string(_frl__rawWep) && scrFRScriptExists("weapon", _frl__rawWep, "weapon_raw"))) {
{
_frl__rawWep = scrFRModCall("weapon", _frl__rawWep, "weapon_raw", _frl__wep);
;
}
}
return _frl__rawWep;
;
}

// Original Weapons/FR_Wormhole.wep.gml:397
function fr_Weapons_FR_Wormhole_wep_gml_WormholeBall_create(_frl__x=undefined, _frl__y=undefined, _frl__creator=undefined, _frl__index=undefined, _frl__wep=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
name = "fr_wormholeBall";
;
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWormholeBall);
;
image_speed = (0) * timescale;
;
image_index = _frl__index;
;
creator = _frl__creator;
;
fr_wormball = creator;
;
depth = (- 1);
;
fr_bloom = [1.6, 0.1];
;
weapong = _frl__wep;
;
distance = (- 24);
;
grown = false;
;
image_xscale = 0;
;
image_yscale = image_xscale;
;
x = ((creator.x - lengthdir_x((distance + creator.wkick), creator.gunangle)) + scrFRSourceRandomRange((- 1), 1));
;
y = ((creator.y - lengthdir_y((distance + creator.wkick), creator.gunangle)) + scrFRSourceRandomRange((- 1), 1));
;
on_end_step = fr_Weapons_FR_Wormhole_wep_gml_WormholeBall_endstep;
;
repeat (6) {
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWormholeSpark);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
image_index = scrFRSourceChoose(0, 1);
;
}
}
if(__fr_break6) break;
}}
}
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original Weapons/FR_Wormhole.wep.gml:432
function fr_Weapons_FR_Wormhole_wep_gml_WormholeBall_endstep() {
if (((! scrFRInstanceExists(creator)) || (!scrFRSourceWeaponEqual(scrFRWeaponSlotRead(creator, "wep"), weapong)))) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
if ((grown == false)) {
{
if ((image_xscale < 1)) {
{
image_xscale += (0.1 * scrFRSourceScale());
;
}
} else {
{
grown = true;
;
}
}
}
} else {
{
image_xscale = (1 + scrFRSourceRandomRange((- 0.15), 0.15));
;
}
}
image_yscale = image_xscale;
;
x = ((creator.x - lengthdir_x((distance + creator.wkick), creator.gunangle)) + scrFRSourceRandomRange((- 1), 1));
;
y = ((creator.y - lengthdir_y((distance + creator.wkick), creator.gunangle)) + scrFRSourceRandomRange((- 1), 1));
;
if ((scrFRSourceRandom(10) < 1)) {
{
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(x, y, PlasmaTrail)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "weapon:FR_Wormhole"].sprWormholeSpark);
;
direction = scrFRSourceRandom(360);
;
image_angle = direction;
;
speed = ((1 + scrFRSourceRandom(2))) * timescale;
;
image_index = scrFRSourceChoose(0, 1);
;
}
}
if(__fr_break3) break;
}}
}
}
}
