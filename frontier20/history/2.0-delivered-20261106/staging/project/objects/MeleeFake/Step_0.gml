if lockstep_stop
	exit


scrTarget()

var _wakeup_call;

if hp < max_hp || !scr_check_enemies() || (instance_exists(target) && scrTargetIsVisible(target, 64, true) && !instance_exists(Portal)) {
	_wakeup_call = true
}
else _wakeup_call = false

if _wakeup_call {
	var _object = self.__get_spawn_enemy_object()
	snd_play(sndAssassinGetUp)
	var _awake = instance_create(x, y, _object)
	_awake.team = team
	instance_destroy(id, false)
	exit
}

scrFirstFrameAnim(0.4)
