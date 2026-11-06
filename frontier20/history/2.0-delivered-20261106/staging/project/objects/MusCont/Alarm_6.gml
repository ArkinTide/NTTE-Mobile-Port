// BEGIN NTTE CUZ AUDIO TEST ALARM 6 BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm6.before"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 6 BEFORE
/// @description Special campfire theme
with Campfire {
	if (sprite_index != sprCampfireBear) exit
}

audio_stop_sound(song)
audio_stop_sound(amb)

song = musThemeP
song = custom_sound_check(song)

snd_play_music(song, false)
snd_play_ambience(amb, true)
// BEGIN NTTE CUZ AUDIO TEST ALARM 6 AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm6.after"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 6 AFTER