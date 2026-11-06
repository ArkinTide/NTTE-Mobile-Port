/// @function scrBulletShotShellFX
/// @param object
/// @param spread=25
function scrBulletShotShellFX(_object, _spread=25) {
	var _ctx = (instance_is(self, projectileburst) ? creator : id)
	
	if (!instance_exists(_ctx)) return noone
	
	var _shot_angle=scrNTTEFullActorFiringAngle(id);
	with instance_create(x, y, _object) {
		motion_add(_shot_angle + _ctx.right * 100 + orandom(25), (random_range(2, 4)) * timescale)
		return id
	}
	
	return noone
}