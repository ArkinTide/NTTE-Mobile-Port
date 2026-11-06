// Original dependencies/libSaves.mod.gml:1
function fr_dependencies_libSaves_mod_gml___load() {

}

// Original dependencies/libSaves.mod.gml:21
function fr_dependencies_libSaves_mod_gml_addScript(_frl_name=undefined) {
scrFRLQSet(scrFRIndexGet(scrFRMatching(FRCustomObject, "name", "libGlobal"), 0).scriptReferences, _frl_name, ["mod", "libSaves", _frl_name]);
;
}

// Original dependencies/libSaves.mod.gml:24
function fr_dependencies_libSaves_mod_gml_init() {
var _args = [];
for(var _i=0;_i<argument_count;++_i) array_push(_args, argument[_i]);
return scrFRTaskStart(fr_dependencies_libSaves_mod_gml_init_resume, id, scrFROther(other), _args, 5, []);
}
function fr_dependencies_libSaves_mod_gml_init_resume(_fr) {
var _budget=0;
while(!_fr.done) {
assert(++_budget<100000,"Frontier runaway continuation: fr_dependencies_libSaves_mod_gml_init");
if (!scrFRScopeExists(_fr.scope)) { if(array_length(_fr.with_stack)>_fr.with_floor) {scrFRTaskWithNext(_fr); continue;} _fr.done=true; return; }
with (_fr.scope) { switch (_fr.pc) {
case 0: _fr.done=true; return;
case 1: // dependencies/libSaves.mod.gml:35
{
scrFRScriptCall(["mod", "libGeneral", "obj_setup"], "libSaves", "UnlockCont");
;
global.fr_module_vars[$ "mod:libSaves"].saves = {};
;
global.fr_module_vars[$ "mod:libSaves"].isLoaded = true;
;
}
_fr.pc=0;
break;
case 3: // dependencies/libSaves.mod.gml:34
{
;
}
_fr.pc=2;
break;
case 4: // dependencies/libSaves.mod.gml:34
_fr.wait_ticks=max(0,1); _fr.pc=3; return;
break;
case 2: // dependencies/libSaves.mod.gml:34
_fr.pc=((! scrFRModLoaded("mod", "libGeneral")))?4:1;
break;
case 5: // dependencies/libSaves.mod.gml:25
{
fr_dependencies_libSaves_mod_gml_addScript("save_load");
;
fr_dependencies_libSaves_mod_gml_addScript("save_get");
;
fr_dependencies_libSaves_mod_gml_addScript("save_set");
;
fr_dependencies_libSaves_mod_gml_addScript("save_reset");
;
fr_dependencies_libSaves_mod_gml_addScript("unlock_popup");
;
fr_dependencies_libSaves_mod_gml_addScript("unlock_splat");
;
fr_dependencies_libSaves_mod_gml_addScript("unlock_splat_ext");
;
scrFRScriptCall(["mod", "lib", "updateRef"]);
;
}
_fr.pc=2;
break;
default: throw "Frontier invalid continuation PC";
}}
}
}


// Original dependencies/libSaves.mod.gml:39
function fr_dependencies_libSaves_mod_gml_save_load() { return scrFRSaveLoad((argument_count>0 ? argument[0] : undefined),(argument_count>1 ? argument[1] : undefined),argument_count==2); }

// Original dependencies/libSaves.mod.gml:59
function fr_dependencies_libSaves_mod_gml_save_get() {
if ((!scrFRVariableExists(global.fr_module_vars[$ "mod:libSaves"].saves, (argument_count>0 ? argument[0] : undefined)))) {
{
fr_dependencies_libSaves_mod_gml_save_load((argument_count>0 ? argument[0] : undefined));
;
}
}
if ((scrFRVariableExists(global.fr_module_vars[$ "mod:libSaves"].saves, (argument_count>0 ? argument[0] : undefined)) && scrFRVariableExists(scrFRLQGet(global.fr_module_vars[$ "mod:libSaves"].saves, (argument_count>0 ? argument[0] : undefined), noone), (argument_count>1 ? argument[1] : undefined)))) {
{
return scrFRLQGet(scrFRLQGet(global.fr_module_vars[$ "mod:libSaves"].saves, (argument_count>0 ? argument[0] : undefined)), (argument_count>1 ? argument[1] : undefined));
;
}
}
if ((argument_count == 3)) {
{
return (argument_count>2 ? argument[2] : undefined);
;
}
}
return noone;
;
}

// Original dependencies/libSaves.mod.gml:73
function fr_dependencies_libSaves_mod_gml_save_set(_frl__mod=undefined, _frl__name=undefined, _frl__value=undefined) {
if ((!scrFRVariableExists(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod))) {
{
var _frl_save = {};
;
scrFRLQSet(_frl_save, _frl__name, _frl__value);
;
scrFRLQSet(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod, _frl_save);
;
}
} else {
{
scrFRLQSet(scrFRLQGet(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod), _frl__name, _frl__value);
;
}
}
scrFRStringSave(scrFRJsonEncode(scrFRLQGet(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod)), (_frl__mod + "Save.json"));
;
}

// Original dependencies/libSaves.mod.gml:83
function fr_dependencies_libSaves_mod_gml_save_reset(_frl__mod=undefined, _frl__lwo=undefined) {
scrFRLQSet(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod, _frl__lwo);
;
scrFRStringSave(scrFRJsonEncode(scrFRLQGet(global.fr_module_vars[$ "mod:libSaves"].saves, _frl__mod)), (_frl__mod + "Save.json"));
;
}

// Original dependencies/libSaves.mod.gml:88
function fr_dependencies_libSaves_mod_gml_unlock_popup(_frl__name=undefined, _frl__text=undefined) {
if ((! array_length(scrFRMatching(FRCustomObject, "name", "UnlockCont")))) {
{
scrFRScriptCall(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
;
}
}
var _frl__unlock = {"nam": [_frl__name, _frl__name], "txt": _frl__text, "spr": (- 1), "img": 0, "snd": 0};
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "UnlockCont")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((splash_index >= (array_length(unlock) - 1)) && (splash_timer <= 0))) {
{
splash_delay = 40;
;
}
}
array_push(unlock, _frl__unlock);
;
}
}
if(__fr_break3) break;
}}
return _frl__unlock;
;
}

// Original dependencies/libSaves.mod.gml:112
function fr_dependencies_libSaves_mod_gml_unlock_splat(_frl__name=undefined, _frl__text=undefined, _frl__sprite=undefined, _frl__sound=undefined) {
if ((! array_length(scrFRMatching(FRCustomObject, "name", "UnlockCont")))) {
{
scrFRScriptCall(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
;
}
}
var _frl__unlock = {"nam": [_frl__name, _frl__name], "txt": _frl__text, "spr": _frl__sprite, "img": 0, "snd": _frl__sound};
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "UnlockCont")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((splash_index >= (array_length(unlock) - 1)) && (splash_timer <= 0))) {
{
splash_delay = 40;
;
}
}
array_push(unlock, _frl__unlock);
;
}
}
if(__fr_break3) break;
}}
return _frl__unlock;
;
}

// Original dependencies/libSaves.mod.gml:137
function fr_dependencies_libSaves_mod_gml_unlock_splat_ext(_frl__name=undefined, _frl__gameovername=undefined, _frl__text=undefined, _frl__sprite=undefined, _frl__image=undefined, _frl__sound=undefined) {
if ((! array_length(scrFRMatching(FRCustomObject, "name", "UnlockCont")))) {
{
scrFRScriptCall(["mod", "libGeneral", "obj_create"], 0, 0, "UnlockCont");
;
}
}
var _frl__unlock = {"nam": [_frl__name, _frl__gameovername], "txt": _frl__text, "spr": _frl__sprite, "img": _frl__image, "snd": _frl__sound};
;
{ var __fr_with1 = scrFRWithValues(scrFRMatching(FRCustomObject, "name", "UnlockCont")), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (((splash_index >= (array_length(unlock) - 1)) && (splash_timer <= 0))) {
{
splash_delay = 40;
;
}
}
array_push(unlock, _frl__unlock);
;
}
}
if(__fr_break3) break;
}}
return _frl__unlock;
;
}

// Original dependencies/libSaves.mod.gml:161
function fr_dependencies_libSaves_mod_gml_UnlockCont_create(_frl__x=undefined, _frl__y=undefined) {
{ var __fr_with1 = scrFRWithValues(scrFRInstanceCreate(_frl__x, _frl__y, FRCustomObject)), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
depth = (UberCont.depth - 1);
;
persistent = true;
;
unlock = [];
;
unlock_sprit = sprMutationSplat;
;
unlock_image = 0;
;
unlock_delay = 50;
;
unlock_index = 0;
;
unlock_porty = 0;
;
unlock_delay_continue = 0;
;
splash_sprit = sprUnlockPopupSplat;
;
splash_image = 0;
;
splash_delay = 0;
;
splash_index = (- 1);
;
splash_texty = 0;
;
splash_timer = 0;
;
splash_timer_max = 150;
;
return scrFRSelf(self);
;
}
}
if(__fr_break3) break;
}}
}

// Original dependencies/libSaves.mod.gml:190
function fr_dependencies_libSaves_mod_gml_UnlockCont_step() {
if (scrFRInstanceExists(Menu)) {
{
scrFRInstanceDestroy();
;
exit;
;
}
}
depth = (UberCont.depth - 1);
;
if ((splash_delay > 0)) {
splash_delay -= scrFRSourceScale();
} else {
{
var _frl__img = 0;
;
if (((scrFRInstanceExists(Player) || scrFRInstanceExists(FR_OBJECT_BACK_MAIN_MENU)) || scrFRInstanceExists(PauseButton))) {
{
if ((splash_timer > 0)) {
{
splash_timer -= scrFRSourceScale();
;
_frl__img = (sprite_get_number(splash_sprit) - 1);
;
if (((splash_image >= _frl__img) && (splash_texty > 0))) {
{
splash_texty -= scrFRSourceScale();
;
}
}
}
} else {
{
splash_texty = 2;
;
if ((splash_index < (array_length(unlock) - 1))) {
{
splash_index++;
;
splash_timer = splash_timer_max;
;
}
}
}
}
}
}
splash_image += (clamp((_frl__img - splash_image), (- 1), 1) * scrFRSourceScale());
;
}
}
if (scrFRInstanceExists(UnlockScreen)) {
unlock_delay = 1;
} else {
if ((((! scrFRInstanceExists(Player)) && (! scrFRInstanceExists(FR_OBJECT_BACK_MAIN_MENU))) && (! scrFRInstanceExists(PauseButton)))) {
{
while ((((unlock_index >= 0) && (unlock_index < array_length(unlock))) && (scrFRIndexGet(unlock, unlock_index).spr == (- 1)))) {
unlock_index++;
;
}
if ((unlock_index < array_length(unlock))) {
{
{ var __fr_with1 = scrFRWithValues(FR_OBJECT_GAMEOVER_BUTTON), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if (scrFRLetterbox()) {
scrFRAlarmWrite(scrFRSelf(self), 0, 30);
} else {
scrFRInstanceDestroy();
}
;
}
}
if(__fr_break3) break;
}}
{ var __fr_with4 = scrFRWithValues(TopCont), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
gameoversplat = 0;
;
go_addy1 = 9999;
;
dead = false;
;
}
}
if(__fr_break6) break;
}}
if ((unlock_delay > 0)) {
{
unlock_delay -= scrFRSourceScale();
;
var _frl__delayOver = (unlock_delay <= 0);
;
unlock_delay_continue = 20;
;
unlock_porty = 0;
;
{ var __fr_with7 = scrFRWithValues(TopCont), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
visible = _frl__delayOver;
;
if (darkness) {
{
visible = true;
;
darkness = 2;
;
}
}
}
}
if(__fr_break9) break;
}}
scrFRLetterbox(_frl__delayOver);
;
if (_frl__delayOver) {
{
scrFRSoundPlay(sndCharUnlock);
;
scrFRSoundPlay(scrFRIndexGet(unlock, unlock_index).snd);
;
}
}
}
} else {
{
var _frl__img = (sprite_get_number(unlock_sprit) - 1);
;
unlock_image += (clamp((_frl__img - unlock_image), (- 1), 1) * scrFRSourceScale());
;
if ((unlock_porty < 3)) {
{
unlock_porty += scrFRSourceScale();
;
}
}
if ((unlock_delay_continue > 0)) {
unlock_delay_continue -= scrFRSourceScale();
} else {
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
if ((scrFRButtonPressed(_frl_i, "fire") || scrFRButtonPressed(_frl_i, "okay"))) {
{
if ((unlock_index < array_length(unlock))) {
{
unlock_index++;
;
unlock_delay = 1;
;
}
}
break;
;
}
}
}
}
}
}
}
}
} else {
{
{ var __fr_with10 = scrFRWithValues(TopCont), __fr_break12=false;
for (var __fr_index11=0; __fr_index11<array_length(__fr_with10); ++__fr_index11) {
if(scrFRScopeExists(__fr_with10[__fr_index11])) with (__fr_with10[__fr_index11]) {
{
go_addy1 = 55;
;
dead = true;
;
}
}
if(__fr_break12) break;
}}
scrFRInstanceDestroy();
;
}
}
}
}
}
}

// Original dependencies/libSaves.mod.gml:307
function fr_dependencies_libSaves_mod_gml_UnlockCont_draw() {
var _frl__vx = scrFRViewCoordinate(0);
var _frl__vy = scrFRViewCoordinate(1);
var _frl__gw = view_width;
var _frl__gh = view_height;
;
if ((unlock_delay <= 0)) {
{
if ((unlock_image > 0)) {
{
var _frl__unlock = scrFRIndexGet(unlock, unlock_index);
var _frl__nam = scrFRIndexGet(_frl__unlock.nam, 1);
var _frl__spr = _frl__unlock.spr;
var _frl__img = _frl__unlock.img;
var _frl__x = (_frl__gw / 2);
var _frl__y = (_frl__gh - 20);
;
var _frl__px = ((_frl__vx + _frl__x) - 60);
var _frl__py = (((_frl__vy + _frl__y) + 9) + unlock_porty);
;
scrFRDrawSprite(_frl__spr, _frl__img, _frl__px, _frl__py);
;
scrFRDrawSprite(unlock_sprit, unlock_image, (_frl__vx + _frl__x), (_frl__vy + _frl__y));
;
var _frl__tx = (_frl__vx + _frl__x);
var _frl__ty = (((_frl__vy + _frl__y) - 92) + (unlock_porty < 2));
;
draw_set_font(fntBig);
;
draw_set_halign(fa_center);
;
draw_set_valign(fa_top);
;
var _frl__t = string_upper(_frl__nam);
;
scrFRDrawText(_frl__tx, _frl__ty, _frl__t);
;
_frl__ty += (string_height(_frl__t) + 3);
;
if ((unlock_porty >= 3)) {
{
gpu_set_fog(1, 0, 0, 0);
;
scrFRDrawSprite(sprTextUnlocked, 4, (_frl__tx + 1), _frl__ty);
;
scrFRDrawSprite(sprTextUnlocked, 4, _frl__tx, (_frl__ty + 1));
;
scrFRDrawSprite(sprTextUnlocked, 4, (_frl__tx + 1), (_frl__ty + 1));
;
gpu_set_fog(0, 0, 0, 0);
;
scrFRDrawSprite(sprTextUnlocked, 4, _frl__tx, _frl__ty);
;
}
}
if ((unlock_delay_continue <= 0)) {
{
var _frl__cx = _frl__x;
var _frl__cy = (_frl__y - 4);
var _frl__blend = make_color_rgb(102, 102, 102);
;
{
var _frl_i = 0;
for (; (_frl_i < INPUT_MAX_PLAYERS); _frl_i++) {
if (point_in_rectangle((scrFRMouseCoordinate(0, _frl_i) - scrFRViewCoordinate(0, _frl_i)), (scrFRMouseCoordinate(1, _frl_i) - scrFRViewCoordinate(1, _frl_i)), (_frl__cx - 64), (_frl__cy - 12), (_frl__cx + 64), (_frl__cy + 16))) {
{
_frl__blend = c_white;
;
break;
;
}
}
}
}
scrFRDrawSpriteExt(sprFRBase_UnlockContinue, 0, (_frl__vx + _frl__cx), (_frl__vy + _frl__cy), 1, 1, 0, _frl__blend, 1);
;
}
}
}
}
}
}
if ((splash_image > 0)) {
{
var _frl__x = (_frl__vx + _frl__gw);
var _frl__y = (_frl__vy + _frl__gh);
;
scrFRDrawSprite(splash_sprit, splash_image, _frl__x, _frl__y);
;
if ((splash_texty < 2)) {
{
var _frl__unlock = scrFRIndexGet(unlock, splash_index);
var _frl__nam = scrFRIndexGet(_frl__unlock.nam, 0);
var _frl__txt = _frl__unlock.txt;
var _frl__tx = (_frl__x - 4);
var _frl__ty = ((_frl__y - 16) + splash_texty);
;
draw_set_font(fntM1);
;
draw_set_halign(fa_right);
;
draw_set_valign(fa_bottom);
;
if ((_frl__nam != "")) {
{
scrFRDrawText(_frl__tx, _frl__ty, _frl__nam);
;
}
}
if ((splash_texty <= 0)) {
{
_frl__ty += string_height((_frl__nam + " "));
;
scrFRDrawText(_frl__tx, _frl__ty, ("@s" + _frl__txt));
;
}
}
}
}
}
}
}
