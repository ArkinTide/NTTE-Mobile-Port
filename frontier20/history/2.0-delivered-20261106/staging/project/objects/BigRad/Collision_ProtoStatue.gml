// BEGIN NTTE PROTO STATUE ENTRY TEST BIG RAD CONTACT BEFORE
var _ntte_proto_big_rad_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) _ntte_proto_big_rad_sample=scrNTTEFullProtoEntryRadBefore(other.id);
// END NTTE PROTO STATUE ENTRY TEST BIG RAD CONTACT BEFORE
if lockstep_stop
	exit

if !speed && other.hp < other.max_hp * 0.7 {
    other.rad += 10
    snd_play(sndStatueXP)
    with instance_create(x + orandom(3), y + orandom(3), RadEat)
    sprite_index = sprEatBigRad
    instance_destroy()
}
// BEGIN NTTE PROTO STATUE ENTRY TEST BIG RAD CONTACT AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryRadAfter(_ntte_proto_big_rad_sample);
// END NTTE PROTO STATUE ENTRY TEST BIG RAD CONTACT AFTER