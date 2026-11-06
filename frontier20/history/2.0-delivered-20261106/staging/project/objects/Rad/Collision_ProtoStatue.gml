// BEGIN NTTE PROTO STATUE ENTRY TEST RAD CONTACT BEFORE
var _ntte_proto_rad_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) _ntte_proto_rad_sample=scrNTTEFullProtoEntryRadBefore(other.id);
// END NTTE PROTO STATUE ENTRY TEST RAD CONTACT BEFORE
if lockstep_stop
	exit

if !speed && other.hp < other.max_hp * 0.7 {
    other.rad ++
	snd_play(sndStatueXP)

    instance_create(x + orandom(3), y + orandom(3), RadEat)

    instance_destroy()
}
// BEGIN NTTE PROTO STATUE ENTRY TEST RAD CONTACT AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullProtoStatueNaturalEntryTest)) scrNTTEFullProtoEntryRadAfter(_ntte_proto_rad_sample);
// END NTTE PROTO STATUE ENTRY TEST RAD CONTACT AFTER