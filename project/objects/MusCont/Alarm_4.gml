// BEGIN NTTE CUZ AUDIO TEST ALARM 4 BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm4.before"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 4 BEFORE
/// @description Crown Guardian fight music
audio_stop_sound(song)
song = custom_sound_check(mus100b)
snd_play_music(song, true)
// BEGIN NTTE CUZ AUDIO TEST ALARM 4 AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm4.after"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 4 AFTER