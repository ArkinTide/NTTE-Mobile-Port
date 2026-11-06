// Dedicated extension of the unchanged two-hop Spider real-restart case.
// Natural120tick vertices and genuine native Portal pickup create the window.
function scrNTTEFullPetSpiderPortalHiddenTests() {
    scrNTTEFullPetSpiderRoomRestartTests()
    with(NTTEFullWorldEventsRoomRestartTest) ntte_spider_portal_hidden_test=true
}
function scrNTTEFullPetSpiderPortalHiddenBeginRate() {
    spider_hidden_seeded=false;spider_hidden_armed=false;spider_hidden_samples=0
    spider_hidden_expired=false;spider_hidden_entered=false;spider_hidden_released=false
}
function scrNTTEFullPetSpiderPortalHiddenAgeSetup() {
    var _pet=spider_ids[0]
    assert(instance_exists(_pet) && _pet.visible && !instance_exists(_pet.revive) && !instance_exists(GenCont),
        "Hidden Spider setup lacks ordinary visible live companion after real generation")
    return true
}
function scrNTTEFullPetSpiderPortalHiddenSetup() {
    if(hops!=0) return;
    assert(instance_exists(portal) && portal.sprite_index==sprBigPortalSpawn,
        "Hidden Spider setup missed actual newly constructed native Portal")
    var _pet=spider_ids[0]
    assert(_pet.visible && !instance_exists(_pet.revive),"Portal setup requires ordinary visible Spider")
    {
        spider_hidden_seed_clock=_pet.web_frame
        var _count=array_length(_pet.web_list)
        // Three coincident ordinary vertices make the first expired point's
        // source i+2 shrink target coincide, guaranteeing natural deletion.
        with(_pet) repeat(3) scrNTTEFullPetSpiderWebAdd(x,y)
        spider_hidden_vertex=_pet.web_list[_count]
        spider_hidden_deadline=spider_hidden_vertex.frame
        assert(spider_hidden_deadline==spider_hidden_seed_clock+120,
            "Witness was not authored by ordinary source120tick SpiderWebAdd")
        spider_hidden_seeded=true
    }
    // Delay only fixture-owned Player contact while native Spawn animation
    // completes. Keep the companion away from automatic Portal attraction.
    with(Player) {x+=512;y+=512;xprevious=x;yprevious=y}
    _pet.x=Player.x;_pet.y=Player.y;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
    spider_hidden_pet=_pet;spider_hidden_portal=portal;spider_hidden_renderer=instance_find(NTTEFullPetWebDraw,0)
    spider_hidden_armed=true;spider_hidden_samples=0
}
function scrNTTEFullPetSpiderPortalHiddenMonitor() {
    if(!spider_hidden_armed || hops!=0 || phase!=4) return;
    assert(instance_exists(spider_hidden_pet) && instance_exists(spider_hidden_portal)
        && room_ends==0 && room_starts==0 && !instance_exists(GenCont),
        "Natural hidden-web measurement escaped old-room pre-GenCont Portal window")
    var _pet=spider_hidden_pet
    if(!spider_hidden_released) {
        assert(_pet.visible && array_get_index(_pet.web_list,spider_hidden_vertex)>=0
            && _pet.web_frame<spider_hidden_deadline,
            "Witness expired or Spider entered Portal before controlled ordinary contact")
        // Wait on actual scheduled visible EndStep, never rewrite its age.
        if(_pet.web_frame-spider_hidden_seed_clock>=118) {
            assert(spider_hidden_portal.sprite_index==sprBigPortal && spider_hidden_portal.endgame==100,
                "Near-expiry release requires genuinely open, unentered native Portal")
            with(Player) {x=other.spider_hidden_portal.x;y=other.spider_hidden_portal.y;xprevious=x;yprevious=y}
            // Native PetStep place_meeting performs visibility/mask changes.
            _pet.x=spider_hidden_portal.x;_pet.y=spider_hidden_portal.y;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
            spider_hidden_released=true
        } else {
            _pet.x=Player.x;_pet.y=Player.y;_pet.xprevious=_pet.x;_pet.yprevious=_pet.y
        }
        return;
    }
    if(_pet.visible) return;
    assert(!lockstep_stop && !instance_exists(_pet.revive) && _pet.mask_index==mskNone && _pet.persistent,
        "Spider did not become hidden through ordinary live Portal absorption")
    assert(instance_exists(spider_hidden_renderer) && instance_number(NTTEFullPetWebDraw)==1,
        "Old-room Spider renderer disappeared before measured web-aging window")
    if(!spider_hidden_entered) {
        assert(array_get_index(_pet.web_list,spider_hidden_vertex)>=0 && spider_hidden_deadline>_pet.web_frame,
            "Hidden enter lacks the same still-live ordinary vertex before its natural deadline")
        spider_hidden_entered=true;spider_hidden_last_clock=_pet.web_frame
        spider_hidden_last_draw=draw_frames
        scrNTTESmokeLog("SPIDER NATURAL PORTAL HIDDEN ENTER "+json_stringify({rate:rates[pass_index],
            pet:_pet.id,portal:spider_hidden_portal.id,clock:_pet.web_frame,deadline:spider_hidden_deadline,
            visible:_pet.visible,mask:_pet.mask_index,renderer:spider_hidden_renderer}))
        return;
    }
    assert(draw_frames>spider_hidden_last_draw,
        "Hidden Spider age sample did not cross a genuine native Draw frame")
    assert(abs((_pet.web_frame-spider_hidden_last_clock)-timescale)<0.0001,
        "Natural hidden Spider web age stopped or advanced twice before Portal room disposal")
    spider_hidden_last_clock=_pet.web_frame;spider_hidden_last_draw=draw_frames;spider_hidden_samples++
    if(_pet.web_frame>spider_hidden_deadline) {
        assert(array_get_index(_pet.web_list,spider_hidden_vertex)<0,
            "Hidden Spider's ordinary expired vertex did not dissipate through real source EndStep")
        spider_hidden_expired=true
    }
}
function scrNTTEFullPetSpiderPortalHiddenRoomEnd() {
    if(hops!=0) return;
    assert(spider_hidden_armed && spider_hidden_entered && spider_hidden_samples>=8 && spider_hidden_expired,
        "Real Portal ended before enough hidden no-GenCont age/deletion witnesses")
    scrNTTESmokeLog("PASS SPIDER NATURAL PORTAL HIDDEN WEB "+json_stringify({rate:rates[pass_index],
        pet:spider_hidden_pet.id,samples:spider_hidden_samples,deadline:spider_hidden_deadline,
        actual_clock:spider_hidden_pet.web_frame,expired_vertex_absent:spider_hidden_expired,
        old_renderer:spider_hidden_renderer,engine_room_end:room_ends}))
    spider_hidden_armed=false
}
