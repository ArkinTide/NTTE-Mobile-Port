scrNTTEFullAnglerConfigure(true)
event_perform_object(enemy,ev_create,0)
scrNTTEFullAnglerAfterCreate()

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
scrNTTEFullAnglerTrailEnsure();
if(object_index==NTTEFullAnglerGold) scrNTTEFullEnemyCreationHPFinish(); // NTTE FINAL ENEMY HP
