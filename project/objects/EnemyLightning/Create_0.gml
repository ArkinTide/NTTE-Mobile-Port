// Original NTT scoped merged Lightning constructor
if(variable_global_exists("ntte_full_merged_lightning_construct") && global.ntte_full_merged_lightning_construct) {
    event_perform_object(projectile,ev_create,0)
    scrNTTEFullMergedLightningConstruct()
    exit;
}
event_inherited()
damage = 2

// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();
