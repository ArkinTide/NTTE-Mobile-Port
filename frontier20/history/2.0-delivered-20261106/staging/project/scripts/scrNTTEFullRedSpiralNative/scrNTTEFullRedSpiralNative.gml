// tecaves3280..3306,5139..5155; red.area_setup_spiral159..187.
function scrNTTEFullRedSpiralBind() {
    if(!instance_exists(NTTEFullSpiralStarfield)) return;
    with(Spiral) if(sprite_index==sprSpiral) {
        sprite_index=scrNTTERefSprite("SpiralStarfield")
        colors=[make_color_rgb(30,14,29),make_color_rgb(16,10,25)];lanim=-100
    }
}
function scrNTTEFullSpiralStarfieldCreate() {
    sprite_index=scrNTTERefSprite("Starfield");image_index=0;turnspeed=0
    scrNTTEFullRedSpiralBind()
}
function scrNTTEFullSpiralStarfieldStep() {
    if(lockstep_stop) return;
    image_xscale=0.8+0.4*image_index+(instance_exists(SpiralCont)?arctan(SpiralCont.time/100):0)
    image_yscale=image_xscale;rotspeed=image_xscale;dist=0;grow=0
}
function scrNTTEFullRedSpiralSetup() {
    // ntte.mod2728..2803 forces one original logical tick and restores RNG
    // around every area setup; preview debris must not advance game state.
    var _old_timescale=timescale,_old_random=random_get_seed(),_old_source=scrNTTEFullSourceSeedState()
    GameCont.ntte_full_source_seed=scrNTTEFullSourceSeedCopy(_old_source)
    timescale=1
    try {scrNTTEFullRedSpiralSetupBody()}
    finally {timescale=_old_timescale;random_set_seed(_old_random);GameCont.ntte_full_source_seed=_old_source}
}
function scrNTTEFullRedSpiralSetupBody() {
    time=0
    if(scrNTTEFullSourceRandom(3)<1) {
        var _players=scrNTTEFullInstances(Player)
        if(array_length(_players)>0) {
            var _player=_players[scrNTTEFullSourceIRandom(array_length(_players)-1)],
                _debris=instance_create(x,y,SpiralDebris)
            _debris.sprite_index=_player.spr_hurt;_debris.image_index=1;_debris.turnspeed*=2/3
            var _ticks=scrNTTEFullSourceIRandomRange(8,12)
            repeat(_ticks) with(_debris) event_perform(ev_step,ev_step_normal)
        }
    }
    for(var _i=sprite_get_number(scrNTTERefSprite("Starfield"))-1;_i>=0;--_i) {
        var _starfield=instance_create(x,y,NTTEFullSpiralStarfield);_starfield.image_index=_i
    }
}
