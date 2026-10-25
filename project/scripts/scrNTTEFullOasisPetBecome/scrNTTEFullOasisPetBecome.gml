// teoasis1170..1290. A real traveling BigRad pays for the Slaughterfish.
function scrNTTEFullOasisPetBecomeCreate() {
    spr_idle=scrNTTERefSprite("SlaughterPropIdle"); spr_hurt=scrNTTERefSprite("SlaughterPropHurt"); spr_dead=scrNTTERefSprite("SlaughterPropDead")
    spr_walk=spr_idle; sprite_index=spr_idle; mask_index=mskFrogEgg; image_xscale=choose(-1,1); max_hp=30; size=1; depth=-1
}
function scrNTTEFullOasisPetBecomeAfterCreate() {
    spr_shadow=shd24; spr_shadow_y=-2; snd_hurt=sndHitRock; snd_dead=sndOasisDeath
    team=0; raddrop=0; prompt=scrNTTEFullPromptCreate(id,"SHARE")
}
function scrNTTEFullOasisPetBecomeCleanup() {
    if(instance_exists(prompt)) instance_destroy(prompt,false)
    prompt=noone
}
function scrNTTEFullOasisPetBecomeStep() {
    if(lockstep_stop) return;
    if(hp<=0) { instance_destroy(); return }
    sprite_index=scrNTTEFullWorldEnemySprite()
    if(instance_exists(prompt)) {
        prompt.visible=GameCont.rad>=10 && raddrop<=0
        if(prompt.pick>=0) {
            var _player=noone,_index=prompt.pick
            with(Player) if(index==_index) _player=id
            if(instance_exists(_player)) {
                GameCont.rad-=10
                var _rad=instance_create(_player.x,_player.y,BigRad)
                with(_rad) { snd_play(sndHitFlesh,2.5,0.5); motion_add(random(360),4*timescale); depth=-2 }
                scrNTTEFullRadPathAssign(_rad,id)
            }
        }
    }
    if(raddrop>0) {
        snd_play(sndRadPickup,0.5+orandom(0.1),6)
        var _eat=instance_nearest(x,y,RadEat)
        if(instance_exists(_eat)) { _eat.x=x; _eat.y=y; _eat.depth=-3 }
        var _pet=scrNTTEFullPetCreate(x,y,"Slaughter"); _pet.right=image_xscale
        scrNTTEFullOasisPetBecomeCleanup(); instance_destroy(id,false)
    }
}
function scrNTTEFullOasisPetBecomeDeath() {
    scrNTTEFullOasisPetBecomeCleanup()
    repeat(3) with(instance_create(x,y,Dust)) speed=3*timescale
    // Source predicts the next instance ID. Capture the actual native corpse
    // instead; parent prop will still supply original death sound/radiation.
    var _corpse=instance_create(x,y,Corpse)
    _corpse.sprite_index=spr_dead; _corpse.image_xscale=image_xscale; _corpse.image_yscale=image_yscale; _corpse.size=size
    var _revive=instance_create(x,y,NTTEFullOasisPetBecomeCorpse); _revive.inst=_corpse
    corpse=false
}
function scrNTTEFullOasisPetBecomeCorpseCreate() { visible=false; inst=noone; time=300 }
function scrNTTEFullOasisPetBecomeCorpseStep() {
    if(lockstep_stop) return;
    if(!instance_exists(inst)) { instance_destroy(); return }
    if(time>0) {
        time-=timescale
        if(random(1+time/5)<timescale) with(instance_create(inst.x+orandom(4),inst.y+orandom(4),Dust)) speed=0
        return;
    }
    with(inst) {
        var _prop=instance_create(x,y,NTTEFullOasisPetBecome)
        _prop.image_xscale=image_xscale; _prop.sprite_index=_prop.spr_hurt
        snd_play_hit(sndOasisMelee,0.4)
        with(instance_create(x,y,NTTEFullWaterStreak)) {
            motion_set(random(360),2*timescale); image_angle=direction+180
            var _smoke=instance_create(x,y,Smoke); /* NTTE NATIVE EFFECT LIFETIME oasis-pet-smoke */ if(instance_exists(_smoke)) {_smoke.direction=direction; _smoke.speed=2*timescale }
        }
        instance_destroy()
    }
}
