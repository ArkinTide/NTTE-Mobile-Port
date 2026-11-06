function custom_sound_check(snd) {
// BEGIN FRONTIER SOUND REPLACEMENTS
if(variable_global_exists("fr_enabled") && global.fr_enabled) snd=scrFRSoundResolve(snd);
// END FRONTIER SOUND REPLACEMENTS







































	gml_pragma("forceinline")
    return global.custom_sounds[$ string(snd)] ?? snd
}