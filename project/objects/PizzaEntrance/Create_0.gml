image_speed = 0

with (prop) {
    if (point_distance(x, y, other.x, other.y) < 64) instance_destroy(id, false)
}
// BEGIN NTTE SEWER PIZZA TEST PROBE PizzaEntrance.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(id))
    scrNTTEFullSewerPizzaEntryProbe("PizzaEntrance.Create.after");
// END NTTE SEWER PIZZA TEST PROBE PizzaEntrance.Create.after
