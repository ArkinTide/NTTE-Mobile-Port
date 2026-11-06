// Source ntte.mod ntte_setup is called after begin/normal/end-step callbacks.
// Deferred setup observes complete child Create state; parent enemy.Create
// runs before Grunt/PopoFreak set their final faction, size and health.
function scrNTTEFullSystemProductionSetup() {
    if(!instance_exists(GameCont) || lockstep_stop) return;
    var _fresh=true
    while(_fresh) {
        _fresh=false
        with(enemy) if(!scrNTTEFullValue(id,"ntte_system_setup_seen",false)) {
            ntte_system_setup_seen=true;_fresh=true
            scrNTTEFullMagneticPulseSetup(id)
        }
        with(FloorMaker) if(!scrNTTEFullValue(id,"ntte_system_floor_setup_seen",false)) {
            ntte_system_floor_setup_seen=true;_fresh=true
            scrNTTEFullRedCrownFloorMaker(id)
        }
    }
}
function scrNTTEFullSystemProductionStep() {
    if(!instance_exists(GameCont) || lockstep_stop) return;
    scrNTTEFullToadBreathStep()
    scrNTTEFullAnnihilationStep()
    scrNTTEFullCrimeStep()
    scrNTTEFullSystemProductionSetup()
}
function scrNTTEFullSystemProductionEndStep() {
    if(!instance_exists(GameCont) || lockstep_stop) return;
    scrNTTEFullToadBreathEndStep()
    scrNTTEFullSystemPortalEndStep()
    scrNTTEFullSystemProductionSetup()
}
// Source tepickups.ntte_end_step6185..6246. The latch belongs to the
// existence of any non-endgame portal, independently of individual IDs.
function scrNTTEFullSystemPortalEndStep() {
    var _portal=false
    with(Portal) if(endgame<=0) {_portal=true;break;}
    if(!_portal) {GameCont.ntte_portal_closed=false;return;}
    if(!instance_exists(Player) || scrNTTEFullValue(GameCont,"ntte_portal_closed",false)) return;
    GameCont.ntte_portal_closed=true
    var _ticks=scrNTTEFullOrchidPortalTick()
    if(_ticks>0) {
        var _seed=random_get_seed()
        snd_play(sndMut,1.5+orandom(0.2))
        random_set_seed(_seed)
    }
    scrNTTEFullAnnihilationPortalTick()
}
// NTT draw_dark uses world matrices; Epsilon scrDarkness uses a view-sized
// surface at local coordinates. Preserve source radii and phase ordering.
function scrNTTEFullSystemBatEarsDark(_phase,_view_x,_view_y) {
    var _num=scrNTTEFullSkillGet("bat ears")
    if(_num<=0) return;
    if(_phase=="normal") draw_clear(draw_get_color())
    else if(_phase=="end") with(Player)
        draw_circle(x-_view_x,y-_view_y,((130*(1+(race==Race.Eyes)))+random(4))*_num,false)
}
