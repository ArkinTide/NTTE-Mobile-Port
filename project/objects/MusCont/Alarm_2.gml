// BEGIN NTTE CUZ AUDIO TEST ALARM 2 BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm2.before"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 2 BEFORE
/// @description Stage-dependent boss music
if(scrNTTEFullMusicBoss()) exit;
scrNTTEFullMusicCancelIntro();
audio_stop_sound(song)
audio_stop_sound(amb)

switch GameCont.area {
	case area_desert: song = musBoss1 break
	case area_sewers: song = musBoss5 break
	case area_scrapyards: song = musBoss2 break
	case area_city: song = musBoss3 break
	case area_palace: song = musBoss4A break
	case area_campfire: song = musBoss4B break
	case area_caves: song = musBoss6 break
	case area_cursed_caves: song = musBoss6B break
	case area_labs: song = musBoss7 break
	case area_hq: song = musBoss8 break
	case area_crib: song = musBoss9 break
}

song = custom_sound_check(song)
amb = custom_sound_check(amb)

snd_play_music(song, true)
snd_play_ambience(amb)
// BEGIN NTTE CUZ AUDIO TEST ALARM 2 AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm2.after"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 2 AFTER