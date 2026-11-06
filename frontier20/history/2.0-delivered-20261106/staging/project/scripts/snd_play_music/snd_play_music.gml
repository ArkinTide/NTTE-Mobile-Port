/// @function snd_play_music
/// @param {Asset.GMSound} sound_index
/// @param is_looped=true
function snd_play_music(_sound_index, _looped = true) {
    _sound_index = custom_sound_check(_sound_index)
	
	if (audio_exists(_sound_index)) {
	    audio_stop_sound(_sound_index)
		audio_sound_gain(_sound_index, UberCont.opt_musvol, 0)
		var _s = audio_play_sound(_sound_index, 128, _looped)
		with (MusCont) music_sound = _s
// BEGIN NTTE CUZ AUDIO TEST REAL VOICE
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest) && variable_instance_exists(instance_find(NTTEFullCuzConnectedTest,0),"ntte_cuz_audio")) try { var _ntte_cuz_audio_event_receiver=id; with(instance_find(NTTEFullCuzConnectedTest,0)) { scrNTTEFullCuzMusicNativeCall(_sound_index,_looped,_s); } } catch(_ntte_cuz_audio_error) { with(instance_find(NTTEFullCuzConnectedTest,0)) scrNTTEFullCuzConnectedAbort(_ntte_cuz_audio_error); }
// END NTTE CUZ AUDIO TEST REAL VOICE
	    return _s
	}
	return -1
}

/// @function snd_play_ambience
/// @param {Asset.GMSound} sound_index
/// @param is_looped=true
function snd_play_ambience(_sound_index, _looped = true) {
    _sound_index = custom_sound_check(_sound_index)
	
	if (audio_exists(_sound_index)) {
	    audio_stop_sound(_sound_index)
	    var _s = audio_play_sound(_sound_index, 128, _looped)
		if (_s >= 0) {
			audio_sound_gain(_sound_index, UberCont.opt_ambvol, 0)
			audio_sound_set_track_position(_s, random(audio_sound_length(_sound_index)))
			return _s
		}
	}
	return -1
}