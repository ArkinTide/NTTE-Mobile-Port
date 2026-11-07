// Source PlayerSit.alarm0==1 crown unlock precedes scene destruction.
scrNTTEFullCrownLoadoutUnlockCurrent()
scrNTTEFullProgressSave()

scrFRSessionPrepare(); // FRONTIER VICTORY SESSION RETIRE
with all {
    if(scrFRSessionPreserve(id)) continue; // FRONTIER VICTORY STORAGE
    if (object_index == UberCont || object_index == GameCont || object_index == TopCont
		|| object_index == BackCont || object_index == Player || object_index == MusCont
		|| object_index == Console
	) {
        continue
    }
	instance_destroy(id, false)
}

scrFRSessionRetired(true); // FRONTIER VICTORY RETIRED CONTINUATIONS
instance_create(0, 0, Credits)