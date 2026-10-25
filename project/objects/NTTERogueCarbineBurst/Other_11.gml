// NTTE merged deferred emission dispatch around real native event.
var _ntte_runtime_event=scrNTTEFullMergedRuntimeEventBegin();
try {
// NTTE real-creator firing mount around deferred native event.
var _ntte_runtime_mount=scrNTTEFullMergedRuntimeMountedEventBegin();
try {
/// @description One shot in the Rogue Carbine burst

with (scr_projectile_create(x, y, NTTERogueCarbineBullet, direction, 16)) {
	scr_projectile_spread(4)
}

var _ntte_audio_pitch=random_range(1.4, 1.6),_ntte_audio_voice=snd_play_gun(sndHeavyMachinegun);
if(_ntte_audio_voice>=0) audio_sound_pitch(_ntte_audio_voice,_ntte_audio_pitch);
var _ntte_audio_pitch=random_range(0.6, 1.1),_ntte_audio_voice=snd_play_gun(sndRogueRifle);
if(_ntte_audio_voice>=0) audio_sound_pitch(_ntte_audio_voice,_ntte_audio_pitch);
var _ntte_audio_pitch=random_range(0.6, 0.8),_ntte_audio_voice=snd_play_gun(sndGruntFire);
if(_ntte_audio_voice>=0) audio_sound_pitch(_ntte_audio_voice,_ntte_audio_pitch);
var _ntte_audio_pitch=random_range(2.4, 2.8),_ntte_audio_voice=snd_play_gun(sndIDPDNadeLoad);
if(_ntte_audio_voice>=0) audio_sound_pitch(_ntte_audio_voice,_ntte_audio_pitch);

// Epsilon's effects API differs from NTT's weapon_post parameters.
scr_weapon_post(direction, 5, 2, 7)
with (scrBulletShotShellFX(Shell)) sprite_index = sprHeavyShell
}
finally {
    scrNTTEFullMergedRuntimeMountEnd(_ntte_runtime_mount);
}
}
finally {
    scrNTTEFullMergedRuntimeEventEnd(_ntte_runtime_event);
}
