// Source teevents event_setup precedes source floors. Native custom builders
// eagerly build in Create, so prepare their goal/safespawn before event rolls
// and defer the complete floor callback until after selected event setup.
function scrNTTEFullAreaGeneratorPrepare() {
    if(scrNTTEFullValue(id,"ntte_full_area_prepared",false)) return;
    ntte_full_area_prepared=true
    ntte_full_sync_generation=variable_global_exists("ntte_full_sync_generation") && global.ntte_full_sync_generation
    var _builder=scrNTTEFullAreaNativeBuilder(GameCont.area)
    if(!is_struct(_builder)) return;
    if(is_callable(_builder.setup)) {var _callback=method(id,_builder.setup);_callback()}
}
function scrNTTEFullAreaGeneratorBuild() {
    if(ntte_full_sync_generation) return;
    var _builder=scrNTTEFullAreaNativeBuilder(GameCont.area)
    if(!is_struct(_builder)) return;
    var _callback=method(id,_builder.make_floor);_callback()
    alarm[2]=2;alarm[0]=3
}
