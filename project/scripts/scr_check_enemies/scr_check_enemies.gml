/// @function scr_check_enemies
/// @param amount=0
function scr_check_enemies(_amount = 0) {
    var _count=0
    with (enemy) {
        if (team==team_player || instance_is(id,Van) || instance_is(id,BigDogMissile)) continue
        ++_count
    }
    // Transforming enemies may not have their combat fields until they hatch.
    with (becomenemy) {
        if (variable_instance_exists(id,"team") && team==team_player) continue
        ++_count
    }
    return _count>_amount
}
