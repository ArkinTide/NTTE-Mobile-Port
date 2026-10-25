function scrExtraWepsReset() {
	ntte_extra_states = []
	extra_weps = []
	extra_weps_curse = []
	extra_weps_reload = []
	extra_weps_wkick = []
	extra_weps_wepflip = []
	extra_weps_wepangle = []
	extra_weps_can_shoot = []
}

function scrExtraWepsInit() {
	scrExtraWepsReset()
	max_extra_weps = 0
}

function scrExtraWepStoreCurrent() {
	array_push(ntte_extra_states, variable_instance_exists(id,"ntte_state") ? ntte_state : undefined)
	array_push(extra_weps, wep)
	array_push(extra_weps_curse, curse)
	array_push(extra_weps_reload, reload)
	array_push(extra_weps_wkick, wkick)
	array_push(extra_weps_wepflip, wepflip)
	array_push(extra_weps_wepangle, wepangle)
	array_push(extra_weps_can_shoot, can_shoot)
}

function scrExtraWepRestoreFirst() {
	ntte_state = array_length(ntte_extra_states) ? array_shift(ntte_extra_states) : undefined
	wep = array_shift(extra_weps)
	curse = array_shift(extra_weps_curse)
	reload = array_shift(extra_weps_reload)
	wkick = array_shift(extra_weps_wkick)
	wepflip = array_shift(extra_weps_wepflip)
	wepangle = array_shift(extra_weps_wepangle)
	can_shoot = array_shift(extra_weps_can_shoot)
}