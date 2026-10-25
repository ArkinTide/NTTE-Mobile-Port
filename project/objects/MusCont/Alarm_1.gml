// BEGIN NTTE CUZ AUDIO TEST ALARM 1 BEFORE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm1.before"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 1 BEFORE
/// @description Boss win jingle
snd_stop(song)

var _snd = sndBossWin,
	_amb = custom_sound_check(amb)

if (instance_exists(CrownPed)) _snd = sndVaultBossWin

_snd = custom_sound_check(_snd)

snd_play_music(_snd, false)
snd_play_ambience(_amb)

var _area = GameCont.area

if (_area != area_palace || _area != area_campfire) alarm[3] = 180

// BEGIN NTTE CUZ AUDIO TEST ALARM 1 AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicAlarm("MusCont.Alarm1.after"); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST ALARM 1 AFTER