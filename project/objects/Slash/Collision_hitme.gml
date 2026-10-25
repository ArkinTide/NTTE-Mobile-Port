// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST SLASH BEFORE
var _ntte_palace_carry_slash_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { _ntte_palace_carry_slash_sample=scrNTTEFullPalaceArtifactPortalCarrySlashBefore(other.id); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST SLASH BEFORE
// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
if scr_projectile_generic_hit(false) {
    if (guitar || electricguitar) {
        var _sound_name = electricguitar ? "sndElectricGuitarHit" : "sndGuitarHit",
			_sound_index = asset_get_index(_sound_name + string(irandom(6) + 1))
		
        if (audio_exists(_sound_index)) snd_play_pitch(_sound_index, 0.2)
	}
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}

// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST SLASH AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarrySlashAfter(_ntte_palace_carry_slash_sample); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST SLASH AFTER