function scrTarget() {
	gml_pragma("forceinline")
    if (variable_instance_exists(id,"ntte_charmed") && ntte_charmed) target=scrNTTENearestHostile(x,y,1000)
    else target = instance_nearest(x, y, Player)
}