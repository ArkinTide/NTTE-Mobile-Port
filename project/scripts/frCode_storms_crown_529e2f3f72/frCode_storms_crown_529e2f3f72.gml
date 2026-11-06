// Original Crowns/storms.crown.gml:1
function fr_Crowns_storms_crown_gml___load() {

}

// Original Crowns/storms.crown.gml:1
function fr_Crowns_storms_crown_gml_init() {
global.fr_module_vars[$ "crown:storms"].sprCrownStormsIdle = sprFR_sprCrownStormsIdle_acf30266e9a2;
;
global.fr_module_vars[$ "crown:storms"].sprCrownStormsWalk = sprFR_sprCrownStormsWalk_b7682b0fbabf;
;
global.fr_module_vars[$ "crown:storms"].sprCrownStormsIcon = sprFR_sprCrownStormsIcon_43d2dc158031;
;
}

// Original Crowns/storms.crown.gml:6
function fr_Crowns_storms_crown_gml_crown_object() {
spr_idle = global.fr_module_vars[$ "crown:storms"].sprCrownStormsIdle;
spr_walk = global.fr_module_vars[$ "crown:storms"].sprCrownStormsWalk;
;
if (scrFRInstanceIs((scrFROther(other)), CrownIcon)) {
{
scrFRSoundPitch(sndCrownProtection, 1.1);
;
scrFRSoundPitchVolume(sndExplosion, 1.2, 0.9);
scrFRSoundPitchVolume(sndExplosionS, 0.7, 0.9);
scrFRSoundPitchVolume(sndLightningPistolUpg, 0.7, 0.9);
scrFRSoundPitchVolume(sndLightningCannonUpg, 1, 0.9);
}
}
}

// Original Crowns/storms.crown.gml:20
function fr_Crowns_storms_crown_gml_crown_name() {
return scrFRLocalize(scrFRLoc("Frontier:CrownStorms:0", "CROWN OF STORMS"));
;
}

// Original Crowns/storms.crown.gml:21
function fr_Crowns_storms_crown_gml_crown_text() {
return scrFRLocalize(scrFRLoc("Frontier:CrownStorms:0", "@sMORE @(color:6983599)METEOROLOGICAL @sAND @(color:6983599)WEATHER EVENTS"));
;
}

// Original Crowns/storms.crown.gml:22
function fr_Crowns_storms_crown_gml_crown_tip() {
return scrFRLocalize("UNPREDICTABLE FORECAST");
;
}

// Original Crowns/storms.crown.gml:23
function fr_Crowns_storms_crown_gml_crown_button() {
sprite_index = scrFRAreaSourceSprite(global.fr_module_vars[$ "crown:storms"].sprCrownStormsIcon);
;
}

// Original Crowns/storms.crown.gml:24
function fr_Crowns_storms_crown_gml_crown_avail() {
return (GameCont.loops <= 0);
;
}

// Original Crowns/storms.crown.gml:26
function fr_Crowns_storms_crown_gml_step() {
{ var __fr_with1 = scrFRWithValues(CrownObject), __fr_break3=false;
for (var __fr_index2=0; __fr_index2<array_length(__fr_with1); ++__fr_index2) {
if(scrFRScopeExists(__fr_with1[__fr_index2])) with (__fr_with1[__fr_index2]) {
{
if ((scrFRSourceRandom(25) < 1)) {
{
{ var __fr_with4 = scrFRWithValues(scrFRInstanceCreate(x, y, Breath)), __fr_break6=false;
for (var __fr_index5=0; __fr_index5<array_length(__fr_with4); ++__fr_index5) {
if(scrFRScopeExists(__fr_with4[__fr_index5])) with (__fr_with4[__fr_index5]) {
{
direction = scrFRSourceRandom(360);
image_angle = direction;
image_xscale = scrFRSourceRandom(1);
image_yscale = image_xscale;
image_blend = make_colour_rgb(50, 57, 62);
}
}
if(__fr_break6) break;
}}
}
}
if ((scrFRSourceRandom(50) < 1)) {
{
{ var __fr_with7 = scrFRWithValues(scrFRInstanceCreate(x, y, LightningHit)), __fr_break9=false;
for (var __fr_index8=0; __fr_index8<array_length(__fr_with7); ++__fr_index8) {
if(scrFRScopeExists(__fr_with7[__fr_index8])) with (__fr_with7[__fr_index8]) {
{
direction = scrFRSourceRandom(360);
image_angle = direction;
image_xscale = scrFRSourceRandom(0.7);
image_yscale = image_xscale;
}
}
if(__fr_break9) break;
}}
}
}
}
}
if(__fr_break3) break;
}}
}
