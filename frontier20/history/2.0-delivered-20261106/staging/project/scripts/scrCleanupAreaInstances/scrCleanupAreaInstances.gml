function scrCleanupAreaInstances() {
	// Event callbacks need the old terrain and must run before family teardown.
	scrNTTEFullWorldEventsCleanup();
	instance_destroy(Floor, false)
	instance_destroy(Wall, false)
	instance_destroy(damagesource, false)
	
	with (hitme) if (!instance_is(self, Player)) instance_destroy(id, false)
	
	instance_destroy(TopSmall)
	instance_destroy(Spiral)
	instance_destroy(SpiralCont)
	instance_destroy(SpiralDebris)
	instance_destroy(SpiralStar)
	instance_destroy(Detail)
	instance_destroy(DPDecorBatch,false)
	instance_destroy(DPStaticDecor,false)
	instance_destroy(DPStatueDecor,false)
	instance_destroy(NTTEDesertDecor, false)
	instance_destroy(NTTEAlert, false)
	instance_destroy(NTTECatHole, false)
	instance_destroy(TopPot)
	
	instance_destroy(FloorMaker, false)
	instance_destroy(GenCont, false)
}
