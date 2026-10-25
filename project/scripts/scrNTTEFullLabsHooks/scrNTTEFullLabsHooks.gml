// telabs3045..3061. Fish Freak keeps the actual native Freak AI and stats.
function scrNTTEFullFreakSetup(_instance) {
    if (!instance_exists(_instance)) return;
    var _underwater=GameCont.underwater
    with (_instance) {
        if (!variable_instance_exists(id,"fish_freak")) fish_freak=_underwater || (GameCont.area==area_labs && GameCont.loops>0 && random(7)<1)
        if (fish_freak) {
            spr_idle=scrNTTERefSprite("FishFreakIdle"); spr_walk=scrNTTERefSprite("FishFreakWalk")
            spr_hurt=scrNTTERefSprite("FishFreakHurt"); spr_dead=scrNTTERefSprite("FishFreakDead"); hitid=[spr_idle,"FREAK"]
        }
    }
}
function scrNTTEFullFishFreakCreate(_x,_y) {
    var _freak=instance_create(_x,_y,Freak)
    _freak.fish_freak=true; scrNTTEFullFreakSetup(_freak)
    return _freak
}
function scrNTTEFullLabsHooksInit() { global.ntte_full_fish_freak_create=scrNTTEFullFishFreakCreate }
