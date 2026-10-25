max_hp = 10000000000
size = 3
spr_idle = sprVenuzCouch
spr_hurt = sprVenuzCouch
spr_dead = sprVenuzCouchDead
event_inherited()
image_xscale = 1
snd_hurt = sndHitRock

var _yv = scrPlayerCountRace(Race.Venuz),
	_cuz = scrPlayerCountRace(Race.Cuz)

if (!_yv && !_cuz) {
	with (instance_create(x + 21, y, YungCuz)) image_xscale *= -1
	instance_create(x - 12, y, YungVenuzCouch)
}
else if (!(_yv && _cuz)) {
	instance_create(x - 12, y, _cuz ? YungVenuzCouch : YungCuz)
}
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

// BEGIN NTTE CUZ CONNECTED TEST Couch.Create
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedProbe("Couch.Create",id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST Couch.Create