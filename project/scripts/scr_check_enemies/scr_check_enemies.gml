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
        // A dormant van reservation is not an arriving hostile. It can only
        // arm after a police death; counting it can lock an otherwise empty room.
        if(object_index==WantVan && !canspawn) continue
        ++_count
    }
// BEGIN FRONTIER PENDING POLICE CLEAR
_count+=scrFRPendingPoliceCount();
// END FRONTIER PENDING POLICE CLEAR
    return _count>_amount
}
