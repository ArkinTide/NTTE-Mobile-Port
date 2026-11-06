// BEGIN NTTE CUZ AUDIO TEST ALARM 0 BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm0.before"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 0 BEFORE
/// @description Main menu theme switch-up
if !audio_is_playing(custom_sound_check(musThemeB)) {
	var _sound = custom_sound_check(musThemeA)
	
	if (audio_exists(_sound)) audio_sound_gain(_sound, 0, 1500)
	
    song = custom_sound_check(musThemeB)
	
    snd_play_music(song, false)
	
	if (instance_exists(Menu) || instance_exists(MenuGen)) {
		snd_play_ambience(amb)
	}
}
// BEGIN NTTE CUZ AUDIO TEST ALARM 0 AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm0.after"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 0 AFTER