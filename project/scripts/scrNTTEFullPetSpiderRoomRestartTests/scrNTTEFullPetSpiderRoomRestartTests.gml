// Same strict old/fixed case: ordinary persistent companions, genuine native
// BigPortal transitions, native scheduled EndStep and renderer Draw/CleanUp.
function scrNTTEFullPetSpiderRoomRestartTests() {
    scrNTTEFullWorldEventsRoomRestartTests()
    with(NTTEFullWorldEventsRoomRestartTest) ntte_pet_spider_restart_test=true
}
function scrNTTEFullPetSpiderRestartEnabled() {
    return !restored && scrNTTEFullValue(id,"ntte_pet_spider_restart_test",false)
}
function scrNTTEFullPetSpiderRestartBeginRate() {
    spider_ready=false;spider_initial_ready=false;spider_ids=[];spider_prompts=[]
    // NTTE SPIDER NATURAL HIDDEN PORTAL TEST HOOK
    if(scrNTTEFullValue(id,"ntte_spider_portal_hidden_test",false)) scrNTTEFullPetSpiderPortalHiddenBeginRate()
    spider_renderers=[];spider_cleanup_log=[];spider_ends=0;spider_starts=0
    spider_gen_hidden=0;spider_gen_reset=0;spider_last_renderer=noone;spider_empty_stage=0;spider_settled_hop=0
}
function scrNTTEFullPetSpiderRestartInitialStep() {
    if(!spider_ready) {
        Player.ntte_pet_max=2
        repeat(2) {
            var _pet=scrNTTEFullPetCreate(Player.x,Player.y,"Spider")
            assert(scrNTTEFullPetTake(_pet,Player.id),"Ordinary source pet pickup failed for Spider restart witness")
            assert(_pet.persistent && _pet.leader==Player.id && instance_exists(_pet.prompt),"Spider witness was not ordinarily adopted")
            array_push(spider_ids,_pet);array_push(spider_prompts,_pet.prompt)
        }
        spider_ready=true;spider_ready_draw=draw_frames
        return false
    }
    if(draw_frames-spider_ready_draw<8) return false
    // NTTE SPIDER NATURAL HIDDEN PORTAL TEST HOOK
    if(scrNTTEFullValue(id,"ntte_spider_portal_hidden_test",false) && !scrNTTEFullPetSpiderPortalHiddenAgeSetup()) return false;
    scrNTTEFullPetSpiderRestartRenderer("initial two-spider singleton")
    spider_initial_ready=true
    return true
}
function scrNTTEFullPetSpiderRestartRenderer(_where) {
    assert(array_length(spider_ids)==2 && instance_number(NTTEFullPetWebDraw)==1,
        "Persistent Spider lost its single room-local renderer after real room_restart: "+_where)
    for(var _i=0;_i<array_length(spider_ids);++_i)
        assert(instance_exists(spider_ids[_i]) && spider_ids[_i].persistent && spider_ids[_i].pet=="Spider"
            && instance_exists(spider_prompts[_i]),"Actual restart replaced/lost an adopted Spider or its persistent prompt")
    var _renderer=instance_find(NTTEFullPetWebDraw,0)
    assert(!_renderer.persistent && surface_exists(_renderer.ntte_web_surface) && _renderer.ntte_web_camera>=0,
        "Spider renderer did not execute genuine Draw with room-local surface/camera ownership")
    if(_renderer!=spider_last_renderer) {array_push(spider_renderers,_renderer);spider_last_renderer=_renderer}
    scrNTTESmokeLog("SPIDER RESTART RENDERER "+_where+" "+json_stringify({rate:rates[pass_index],hop:hops,
        pets:spider_ids,renderer:_renderer,surface:_renderer.ntte_web_surface,camera:_renderer.ntte_web_camera,
        rendered_ids:spider_renderers,cleanup_count:array_length(spider_cleanup_log)}))
}
function scrNTTEFullPetSpiderRestartBeforeHop() {
    spider_gen_hidden=0;spider_gen_reset=0
}
function scrNTTEFullPetSpiderRestartTransientPrompts(_prompts) {
    var _kept=[]
    for(var _i=0;_i<array_length(_prompts);++_i) {
        var _prompt=_prompts[_i],_slot=array_get_index(spider_prompts,_prompt)
        if(_slot<0) array_push(_kept,_prompt)
        else assert(instance_exists(spider_ids[_slot]) && spider_ids[_slot].prompt==_prompt
            && _prompt.creator==spider_ids[_slot] && spider_ids[_slot].persistent,
            "Only exact fixture-owned persistent Spider prompts may leave the world's transient-prompt set")
    }
    return _kept
}
function scrNTTEFullPetSpiderRestartMonitor() {
    // NTTE SPIDER NATURAL HIDDEN PORTAL TEST HOOK
    if(scrNTTEFullValue(id,"ntte_spider_portal_hidden_test",false)) scrNTTEFullPetSpiderPortalHiddenMonitor()
    if(!spider_ready || !instance_exists(GenCont)) return;
    var _hidden=true,_reset=true
    for(var _i=0;_i<array_length(spider_ids);++_i) {
        var _pet=spider_ids[_i]
        assert(instance_exists(_pet),"Persistent Spider lost during genuine generation")
        _hidden=_hidden && !_pet.visible
        _reset=_reset && array_length(_pet.web_list)==0 && _pet.web_timer==_pet.web_timer_max
            && _pet.web_list_x1==infinity && _pet.web_list_y1==infinity
            && _pet.web_list_x2==-infinity && _pet.web_list_y2==-infinity
    }
    if(_hidden) {spider_gen_hidden++;if(_reset) spider_gen_reset++}
}
function scrNTTEFullPetSpiderRestartRoomEnd() {
    if(!spider_ready) return;
    assert(instance_number(NTTEFullPetWebDraw)==1,"Measured RoomEnd lacks exactly one old Spider renderer")
    spider_old_renderer=instance_find(NTTEFullPetWebDraw,0)
    assert(!spider_old_renderer.persistent && surface_exists(spider_old_renderer.ntte_web_surface),"Old renderer lacks genuine allocated surface at RoomEnd")
    spider_cleanup_before=array_length(spider_cleanup_log)
    // Authored vertex is fixture setup at actual engine RoomEnd. A real
    // scheduled destination EndStep must clear it; no event is synthesized.
    for(var _i=0;_i<array_length(spider_ids);++_i) with(spider_ids[_i]) {
        scrNTTEFullPetSpiderWebAdd(x,y)
        assert(array_length(web_list)>0,"RoomEnd web sentinel was not installed")
    }
    spider_ends++
    // NTTE SPIDER NATURAL HIDDEN PORTAL TEST HOOK
    if(scrNTTEFullValue(id,"ntte_spider_portal_hidden_test",false)) scrNTTEFullPetSpiderPortalHiddenRoomEnd()
}
function scrNTTEFullPetSpiderRestartRoomStart() {
    if(!spider_ready) return;
    assert(!instance_exists(spider_old_renderer) && instance_number(NTTEFullPetWebDraw)==0,
        "Old room-local Spider renderer survived actual room disposal")
    assert(array_length(spider_cleanup_log)==spider_cleanup_before+1,
        "Actual renderer CleanUp did not release its old room resources exactly once")
    for(var _i=0;_i<array_length(spider_ids);++_i)
        assert(instance_exists(spider_ids[_i]) && spider_ids[_i].persistent,"Engine failed to retain adopted Spider identity")
    spider_starts++
}
function scrNTTEFullPetSpiderRestartCleanupProbe(_surface,_camera) {
    var _observer=instance_find(NTTEFullWorldEventsRoomRestartTest,0)
    if(!instance_exists(_observer) || !scrNTTEFullValue(_observer,"ntte_pet_spider_restart_test",false) || _observer.restored) return;
    assert(!surface_exists(_surface),"Spider renderer CleanUp retained its allocated surface")
    array_push(_observer.spider_cleanup_log,{renderer:id,surface:_surface,camera:_camera})
    scrNTTESmokeLog("SPIDER RESTART ACTUAL CLEANUP "+json_stringify({renderer:id,surface:_surface,camera:_camera,
        surface_live:surface_exists(_surface),rate:_observer.rates[_observer.pass_index]}))
}
function scrNTTEFullPetSpiderRestartAfterDraws() {
    scrNTTEFullPetSpiderRestartRenderer("post-restart settled Draw8")
    assert(spider_ends==hops && spider_starts==hops && array_length(spider_renderers)==hops+1,
        "Spider rebuild lacks exact engine disposal/new-singleton ancestry")
    assert(spider_gen_hidden>0 && spider_gen_reset>0,
        "Real hidden GenCont EndStep never reset old Spider webs/timer/bounds")
    scrNTTESmokeLog("SPIDER RESTART HIDDEN GENERATION RESET "+json_stringify({rate:rates[pass_index],hop:hops,
        hidden_samples:spider_gen_hidden,reset_samples:spider_gen_reset}))
    spider_settled_hop=hops
}
function scrNTTEFullPetSpiderRestartEmptyStep() {
    if(spider_empty_stage==0) {
        spider_empty_cleanup=array_length(spider_cleanup_log);spider_empty_draw=draw_frames
        // Explicit terminal fixture teardown of owned pets only, after all
        // measured hops. Renderer must detect no Spiders and end by own Draw.
        for(var _i=0;_i<array_length(spider_ids);++_i) instance_destroy(spider_ids[_i])
        spider_empty_stage=1
        return false
    }
    if(draw_frames-spider_empty_draw<8) return false
    assert(instance_number(NTTEFullPetWebDraw)==0 && array_length(spider_cleanup_log)==spider_empty_cleanup+1,
        "No-Spider renderer failed its own Draw termination/resource CleanUp")
    for(var _i=0;_i<array_length(spider_prompts);++_i)
        assert(!instance_exists(spider_prompts[_i]),"Terminal pet cleanup orphaned Spider prompt")
    assert(array_length(spider_renderers)==3 && array_length(spider_cleanup_log)==3,
        "Two true restarts accumulated renderers or duplicated resource cleanup")
    scrNTTESmokeLog("PASS SPIDER REAL ROOM RESTART two owned Spider IDs retained; singleton shared, three distinct room renderers/three actual CleanUps; hidden GenCont web reset; no-Spider self-cleanup @"+string(rates[pass_index]))
    return true
}
