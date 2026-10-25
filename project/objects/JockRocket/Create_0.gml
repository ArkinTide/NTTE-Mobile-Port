event_inherited()
alarm[1] = 5
active = 0

damage = 4

typ = 2 //0 = nothing, 1 = deflectable, 2 = destructable

snd = sndRocketFly
snd_play(snd)

maxspeed = (5) * timescale
accel = 0.3
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
