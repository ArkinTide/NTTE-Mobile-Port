if(!is_undefined(on_hit)) {
    if(!lockstep_stop && (team!=other.team || other.team==team_none)) scrFRActorCallback("on_hit");
} else event_inherited();
