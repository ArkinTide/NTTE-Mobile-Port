// NTTE SOURCE LEAD RIBS BEFORE CHILD DEATH
if(hp<=0) scrNTTEFullLeadRibsDeath(id);
event_inherited()

repeat irandom_range(5, 8) {
	with instance_create(x, y, Feather) {
		sprite_index = sprLeaf
	}
}