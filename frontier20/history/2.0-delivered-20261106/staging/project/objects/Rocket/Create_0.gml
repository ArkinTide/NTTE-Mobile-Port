event_inherited()
alarm[1] = 5
active = 0
damage = 20
typ = 2

snd = sndRocketFly
snd_play(snd)

image_speed = (0.4) * timescale

knockback_speed = 10 * timescale

maxspeed = (12) * timescale
accel = 2
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
// BEGIN NTTE SEWER PIZZA TEST PROBE Rocket.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("Rocket.Create.after");
// END NTTE SEWER PIZZA TEST PROBE Rocket.Create.after
