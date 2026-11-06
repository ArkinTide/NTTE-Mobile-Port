// BEGIN NTTE PROTO STATUE ENTRY TEST RAD CHEST DEATH BEFORE
var _ntte_proto_prop_death_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest) && object_index==RadChest) _ntte_proto_prop_death_sample=scrNTTEFullProtoEntryDeathBefore("rad_chest");
// END NTTE PROTO STATUE ENTRY TEST RAD CHEST DEATH BEFORE
// NTTE SKELETON BONE DROP: source ted esert EndStep death reward.
scrNTTEFullSkeletonBoneDropNative()
if (corpse && sprite_exists(spr_dead)) {
	with (instance_create(x, y, Corpse)) {
		image_xscale = other.image_xscale
		image_yscale = other.image_yscale
		sprite_index = other.spr_dead
		size = other.size
        scrDPStatueCorpseLink(other.id,id);
	}
}

if (is_numeric(snd_dead) && audio_exists(snd_dead)) snd_play_hit(snd_dead, 0.2)

if (raddrop > 0) scrRadDrop(x, y, raddrop)
// BEGIN NTTE PROTO STATUE ENTRY TEST RAD CHEST DEATH AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryDeathAfter(_ntte_proto_prop_death_sample);
// END NTTE PROTO STATUE ENTRY TEST RAD CHEST DEATH AFTER