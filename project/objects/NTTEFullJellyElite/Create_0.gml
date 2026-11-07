scrNTTEFullJellyConfigure(true)
event_perform_object(enemy,ev_create,0)
scrNTTEFullJellyAfterCreate()

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
if(object_index==NTTEFullJellyElite) scrNTTEFullEnemyCreationHPFinish(); // NTTE FINAL ENEMY HP
