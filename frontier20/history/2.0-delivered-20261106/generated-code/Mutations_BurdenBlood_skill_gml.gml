// Original Mutations/BurdenBlood.skill.gml:1
function fr_Mutations_BurdenBlood_skill_gml___load() {

}

// Original Mutations/BurdenBlood.skill.gml:1
function fr_Mutations_BurdenBlood_skill_gml_init() {
global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillIcon = sprFR_sprBurdenBlood_393eaf22e7fd;
global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillHud = sprFR_sprBurdenBloodIcon_a7cea8aa06e0;
global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillHudOff = sprFR_sprBurdenBloodOffIcon_40c24bafe14c;
global.fr_module_vars[$ "skill:BurdenBlood"].level_start = (scrFRInstanceExists(GenCont) || scrFRInstanceExists(Menu));
;
}

// Original Mutations/BurdenBlood.skill.gml:11
function fr_Mutations_BurdenBlood_skill_gml_skill_name() {
return "BLOSSOMING BLOODSHED";
;
}

// Original Mutations/BurdenBlood.skill.gml:12
function fr_Mutations_BurdenBlood_skill_gml_skill_text() {
return ("@sMORE @wENEMIES#@sFEWER @gRADS@s" + ((scrFRCrownCurrent() == crwn_blood) ? "#@s(@rDisabled @sby @wCrown of Blood@s)" : ""));
;
}

// Original Mutations/BurdenBlood.skill.gml:13
function fr_Mutations_BurdenBlood_skill_gml_skill_tip() {
return "TRY NEW THINGS";
;
}

// Original Mutations/BurdenBlood.skill.gml:14
function fr_Mutations_BurdenBlood_skill_gml_skill_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillIcon);
;
}

// Original Mutations/BurdenBlood.skill.gml:15
function fr_Mutations_BurdenBlood_skill_gml_skill_icon() {
return ((scrFRCrownCurrent() == crwn_blood) ? global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillHudOff : global.fr_module_vars[$ "skill:BurdenBlood"].sprSkillHud);
}

// Original Mutations/BurdenBlood.skill.gml:16
function fr_Mutations_BurdenBlood_skill_gml_skill_avail() {
return 0;
;
}

// Original Mutations/BurdenBlood.skill.gml:17
function fr_Mutations_BurdenBlood_skill_gml_skill_wepspec() {
return 0;
;
}

// Original Mutations/BurdenBlood.skill.gml:18
function fr_Mutations_BurdenBlood_skill_gml_skill_sacrifice() {
return false;
;
}

// Original Mutations/BurdenBlood.skill.gml:19
function fr_Mutations_BurdenBlood_skill_gml_skill_burden() {
return true;
;
}

// Original Mutations/BurdenBlood.skill.gml:22
function fr_Mutations_BurdenBlood_skill_gml_step() {
if ((scrFRCrownCurrent() != crwn_blood)) {
{
{ var __fr_with1 = scrFRWithValues(GenCont), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((!scrFRVariableExists(scrFRSelf(self), "fr_bloodGeneration"))) {
{
if ((scrFRAlarmRead(scrFRSelf(self), 0) == 1)) {
{
fr_bloodGeneration = true;
;
{ var __fr_with4 = scrFRWithValues(Floor), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
if (((((scrFRSourceRandom((8 + GameCont.hard)) < GameCont.hard) && (! scrFRPlaceMeeting(x, y, chestprop))) && (! scrFRPlaceMeeting(x, y, RadChest))) && (point_distance(x, y, (scrFROther(other)).spawn_x, (scrFROther(other)).spawn_y) > (scrFROther(other)).safedist))) {
{
var _frl__meeting = scrFRPlaceMeeting(x, y, hitme);
;
fr_Mutations_BurdenBlood_skill_gml_area_pop_enemies();
;
if ((scrFRInstanceExists(scrFRSelf(self)) && (! _frl__meeting))) {
{
if ((scrFRPlaceMeeting(x, y, hitme) && scrFRPlaceMeeting(x, y, Wall))) {
{
{ var __fr_with7 = scrFRWithValues(scrFRMatchingLE(scrFRMatchingGE(scrFRMatchingLE(scrFRMatchingGE(Wall, "bbox_right", bbox_left), "bbox_left", scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")), "bbox_bottom", bbox_top), "bbox_top", scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom"))), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
if (scrFRPlaceMeeting(x, y, (scrFROther(other)))) {
{
scrFRInstanceDestroy();
;
}
}
}
}
if(__fr_break9) break;
}}
}
}
}
}
}
}
}
}
if(__fr_break6) break;
}}
}
}
}
}
}
}
if(__fr_break3) break;
}}
{ var __fr_with10 = scrFRWithValues(scrFRMatching(enemy, "fr_bloodRads", undefined)), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
fr_bloodRads = true;
;
raddrop--;
;
}
}
if(__fr_break12) break;
}}
}
}
}

// Original Mutations/BurdenBlood.skill.gml:70
function fr_Mutations_BurdenBlood_skill_gml_area_pop_enemies() {
var _frl__game = GameCont;
;
if (scrFRSourceAreaIsString(_frl__game.area)) {
{
try {
scrFRModCall("area", _frl__game.area, "area_pop_enemies");
;
} catch(__fr_caught1) { var _frl__error=__fr_caught1;
{
if (scrFRInstanceIs((scrFROther(other)), GenCont)) {
scrFRTrace(_frl__error);
}
}
}
}
} else {
{
var _frl__spawnLoop = (scrFRSourceRandom(2) < scrFRSourceRandom(_frl__game.loops));
var _frl__spawnAlt = (styleb == 1);
var _frl__x = (((bbox_left + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_right")) + 1) / 2);
var _frl__y = (((bbox_top + scrFRSourceBBoxRead(scrFRSelf(self), "bbox_bottom")) + 1) / 2);
var _frl__obj = (- 1);
var _frl__num = 1;
var _frl__off = 0;
;
{ var __fr_switch_value2=_frl__game.area, __fr_switch_case3=-1;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(1))) __fr_switch_case3=0;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(2))) __fr_switch_case3=1;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(3))) __fr_switch_case3=2;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(4))) __fr_switch_case3=3;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(5))) __fr_switch_case3=4;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(6))) __fr_switch_case3=5;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(7))) __fr_switch_case3=6;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(101))) __fr_switch_case3=7;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(103))) __fr_switch_case3=8;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(104))) __fr_switch_case3=9;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(105))) __fr_switch_case3=10;
if(__fr_switch_case3==-1 && __fr_switch_value2==(scrFRAreaTryResolve(106))) __fr_switch_case3=11;
if(__fr_switch_case3==-1) __fr_switch_case3=-1;
switch(__fr_switch_case3) {
case 0:
if ((scrFRVariableGet(UberCont, "showtutorial", false) == false)) {
{
if (_frl__spawnLoop) {
{
_frl__obj = [Bandit, Bandit, Scorpion, Scorpion, JungleFly, JungleFly, Maggot, MeleeBandit, Sniper];
;
}
} else {
if (_frl__spawnAlt) {
{
_frl__obj = [BigMaggot, BigMaggot, MaggotSpawn, Maggot];
;
}
} else {
if ((scrFRSourceRandom(7) < 1)) {
{
_frl__obj = [Scorpion, MaggotSpawn];
;
}
} else {
if ((scrFRSourceRandom(30) < 1)) {
{
_frl__obj = Bandit;
;
_frl__num = 3;
;
_frl__off = 2;
;
scrFRInstanceCreate(_frl__x, _frl__y, Barrel);
;
}
} else {
{
_frl__obj = [Bandit, Bandit, Bandit, Bandit, Bandit, Bandit, Scorpion, Maggot];
;
}
}
}
}
}
}
}
break;
;
case 1:
if (_frl__spawnLoop) {
{
_frl__obj = [Exploder, Exploder, Ratking, Ratking, Rat, BuffGator, SuperFireBaller, LaserCrystal];
;
}
} else {
if (_frl__spawnAlt) {
{
_frl__obj = [Gator, Gator, Rat, Rat, Exploder];
;
}
} else {
if ((scrFRSourceRandom(9) < 1)) {
{
_frl__obj = [Ratking, Ratking, Ratking, Exploder, Exploder, Exploder, MeleeFake];
;
}
}
}
}
break;
;
case 2:
if (((scrFRSourceRandom(5) < 4) && ((_frl__game.subarea != 3) || (scrFRSourceRandom(2) < 1)))) {
{
if (_frl__spawnLoop) {
{
_frl__obj = [Raven, Raven, Sniper, Sniper, MeleeFake, MeleeFake, Salamander, BuffGator, SnowBot];
;
}
} else {
if ((_frl__spawnAlt && (scrFRSourceRandom(3) < 1))) {
{
_frl__obj = Salamander;
;
}
} else {
if ((scrFRSourceRandom(4) < 1)) {
{
_frl__obj = [Sniper, Sniper, Sniper, Sniper, MeleeFake, MeleeFake, MeleeBandit, Exploder];
;
}
} else {
if ((scrFRSourceRandom(10) < 1)) {
{
_frl__obj = Raven;
;
_frl__num = 2;
;
_frl__off = 2;
;
if ((scrFRSourceRandom(8) < 1)) {
scrFRInstanceCreate(_frl__x, _frl__y, Car);
}
}
} else {
if ((scrFRSourceRandom(20) < 1)) {
{
_frl__obj = Salamander;
;
}
} else {
if ((scrFRSourceRandom(4) < 3)) {
{
_frl__obj = [Raven, Raven, Bandit];
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
break;
;
case 3:
if (_frl__spawnLoop) {
{
_frl__obj = [LaserCrystal, LaserCrystal, LaserCrystal, Spider, Spider, LightningCrystal, RhinoFreak, ExploFreak, BuffGator];
;
}
} else {
{
_frl__obj = [Spider, Spider, Spider, Spider, LaserCrystal];
;
}
}
break;
;
case 4:
if (_frl__spawnLoop) {
{
_frl__obj = [SnowBot, SnowBot, SnowBot, SnowTank, SnowTank, Wolf, DogGuardian, ExploGuardian, Necromancer];
;
}
} else {
if (((scrFRVariableGet(UberCont, "xmas", false) == true) && (scrFRSourceRandom(1000) < 1))) {
{
_frl__obj = Yeti;
;
}
} else {
if ((scrFRSourceRandom(3) < 2)) {
{
_frl__obj = [SnowBot, SnowBot, SnowBot, Wolf, Wolf, SnowTank];
;
}
}
}
}
break;
;
case 5:
if (((! scrFRInstanceIs((scrFROther(other)), GenCont)) || (point_distance(x, y, (scrFROther(other)).spawn_x, (scrFROther(other)).spawn_y) > ((scrFROther(other)).safedist + 40)))) {
{
if (_frl__spawnLoop) {
{
_frl__obj = [RhinoFreak, RhinoFreak, ExploFreak, Necromancer, BecomeTurret, LaserCrystal, Ratking];
;
}
} else {
if ((scrFRSourceRandom(14) < 1)) {
{
_frl__obj = [Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, Freak, ExploFreak, ExploFreak, RhinoFreak];
;
_frl__num = 10;
;
_frl__off = 4;
;
}
} else {
if ((scrFRSourceRandom(8) < 1)) {
{
_frl__obj = [Necromancer, Necromancer, Necromancer, Necromancer, Necromancer, Necromancer, BecomeTurret, BecomeTurret, BecomeTurret, ExploFreak, RhinoFreak];
;
}
}
}
}
}
}
break;
;
case 6:
if (((_frl__game.subarea != 3) && (scrFRSourceRandom(2) < 1))) {
{
if (_frl__spawnLoop) {
{
_frl__obj = [ExploGuardian, ExploGuardian, DogGuardian, DogGuardian, JungleBandit, JungleBandit, Sniper, ExploFreak];
;
}
} else {
if ((scrFRSourceRandom(4) < 1)) {
{
_frl__obj = [Guardian, Guardian, Guardian, Guardian, ExploGuardian, DogGuardian];
;
}
} else {
if ((scrFRSourceRandom(16) < 1)) {
{
_frl__obj = IDPDSpawn;
;
}
}
}
}
}
}
break;
;
case 7:
if ((scrFRSourceRandom(4) < 1)) {
{
_frl__obj = Crab;
;
}
} else {
if ((scrFRSourceRandom(3) < 1)) {
{
_frl__obj = BoneFish;
;
_frl__num = 3;
;
_frl__off = 2;
;
}
}
}
break;
;
case 8:
if ((scrFRSourceRandom(5) < 1)) {
{
_frl__obj = [FireBaller, FireBaller, FireBaller, Jock, Jock, SuperFireBaller];
;
}
} else {
if ((scrFRSourceRandom(4) < 1)) {
{
_frl__obj = [Molefish, Molefish, Molefish, Molefish, Molesarge];
;
_frl__num = 3;
;
if ((scrFRSourceRandom(5) < 1)) {
scrFRInstanceCreate(_frl__x, _frl__y, GoldBarrel);
}
}
}
}
break;
;
case 9:
if ((scrFRSourceRandom(5) < 4)) {
{
_frl__obj = [InvSpider, InvSpider, InvLaserCrystal];
;
}
}
break;
;
case 10:
if ((scrFRSourceRandom(8) < 1)) {
{
_frl__obj = JungleFly;
;
}
} else {
if ((scrFRSourceRandom(30) < 1)) {
{
_frl__obj = JungleBandit;
;
_frl__num = 3;
;
_frl__off = 2;
;
scrFRInstanceCreate(_frl__x, _frl__y, Barrel);
;
}
} else {
{
_frl__obj = [JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleBandit, JungleAssassinHide, JungleAssassinHide, Maggot];
;
}
}
}
break;
;
case 11:
if (((_frl__game.subarea != 3) && (scrFRSourceRandom(12) < 1))) {
{
if ((scrFRSourceRandom(7) < 1)) {
{
_frl__obj = [EliteGrunt, EliteShielder, EliteInspector];
;
}
} else {
if ((scrFRSourceRandom(4) < 1)) {
{
_frl__obj = Grunt;
;
_frl__num = 5;
;
}
} else {
if ((scrFRSourceRandom(3) < 1)) {
{
_frl__obj = [Grunt, Shielder, Inspector];
;
}
}
}
}
}
}
break;
;
}
}
if ((_frl__num > 0)) {
repeat (_frl__num) {
var _frl_o = _frl__obj;
;
if (is_array(_frl_o)) {
{
_frl_o = scrFRIndexGet(_frl_o, scrFRSourceIRandom((array_length(_frl__obj) - 1)));
;
}
}
if (object_exists(_frl_o)) {
{
scrFRInstanceCreate((_frl__x + scrFRSourceRandomRange((- _frl__off), _frl__off)), (_frl__y + scrFRSourceRandomRange((- _frl__off), _frl__off)), _frl_o);
;
}
}
}
}
}
}
}
