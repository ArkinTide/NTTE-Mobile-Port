// tepickups3268..3340 and tescrapyard734..744. Genuine source ultimate reward.
function scrNTTEFullHugeWeaponChestCreate() {
    sprite_index=scrNTTERefSprite("HugeWeaponChest");spr_dead=scrNTTERefSprite("HugeWeaponChestOpen")
    spr_shadow=shd64;spr_shadow_y=4;depth=-1;snd_open=sndBigWeaponChest
    wep=wep_ntte_ultra_quasar_rifle;curse=false;nochest=2;on_open=scrNTTEFullHugeWeaponChestOpen
    instance_create(x,y,PortalClear)
}
function scrNTTEFullHugeQuestChestCreate() {
    sprite_index=scrNTTERefSprite("HugeQuestChest");spr_dead=scrNTTERefSprite("HugeQuestChestOpen")
    spr_shadow=shd64;spr_shadow_y=6
}
function scrNTTEFullHugeWeaponChestOpen(_opener) {
    GameCont.nochest=0
    with(instance_create(x,y-12,FXChestOpen)) { sprite_index=sprMutant6Dead;image_index=11 }
    scrNTTEFullTrenchShake(x,y,30);sleep(30)
    with(instance_create(x,y,PortalClear)) { image_xscale=1.5;image_yscale=image_xscale }
    if(instance_is(_opener,Player)) snd_play(_opener.snd_chst)
    scrNTTEFullUnlockSet("race:beetle",true)
    var _y=y,_count=1+scr_ultra_get(Race.Steroids,UltraSkill.Ambidextrous)
    repeat(_count) {
        var _pickup=scrWeaponPickupCreate(x,_y,wep)
        _y-=1;_pickup.ammo=true;_pickup.curse=curse
    }
}
