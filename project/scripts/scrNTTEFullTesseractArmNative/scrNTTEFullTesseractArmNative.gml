// tecaves3845..3975. Detached actual projectile arm and delayed owned blast.
function scrNTTEFullTesseractArmDeathCreate() {
    name="TesseractArmDeath";sprite_index=scrNTTERefSprite("TesseractWeapon")
    image_speed=0;depth=-4;hitid=-1;mask_index=mskExploder
    friction=timescale*timescale/3;strike=noone;force=8;knockback_speed=8*timescale
    damage=4;raddrop=16;typ=0
}
function scrNTTEFullTesseractArmDeathStep() {
    if(lockstep_stop) return;
    if(instance_exists(strike) && strike.active) {
        strike.xstart=x;strike.ystart=y;strike.image_angle=image_angle
    }
    if(speed<timescale) instance_destroy()
}
function scrNTTEFullTesseractArmDeathHit(_victim) {
    if(lockstep_stop || !scrNTTEFullRedSlashCanHit(_victim)) return;
    scrNTTEFullNativeProjectileHitNP(_victim,damage,force,40)
}
function scrNTTEFullTesseractArmDeathWall(_wall) {
    if(lockstep_stop || !instance_exists(_wall)) return;
    speed*=0.95
    with(_wall) {instance_create(x,y,FloorExplo);instance_destroy()}
}
function scrNTTEFullTesseractArmDeathDraw() {
    var _speed=speed/timescale,_friction=friction/(timescale*timescale),
        _flash=_speed<1+_friction || (_friction!=0 && ((_speed/_friction) mod 6)<3),_fog=gpu_get_fog()
    if(_flash) gpu_set_fog(true,image_blend,0,0)
    draw_self();gpu_set_fog(_fog)
}
function scrNTTEFullTesseractArmDeathDestroy() {
    instance_create(x,y,PortalClear)
    var _explosion=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullRedExplosion,direction)
    _explosion.mask_index=mskPopoPlasmaImpact
    repeat(2) scrNTTEFullWorldPickupDrop(60,0)
    scrRadDrop(x,y,raddrop)
    for(var _i=0;_i<10;++_i) {
        var _fx=scrNTTEFullMergedStockFX(x+scrNTTEFullSourceRandomRange(-8,8),y+scrNTTEFullSourceRandomRange(-8,8),
            [direction+scrNTTEFullSourceRandomRange(-120,120),_i*0.5+scrNTTEFullSourceRandomRange(1,6)],NTTEFullCatDoorDebris)
        _fx.sprite_index=scrNTTERefSprite("CrystalBrainChunk")
        _fx.image_index=scrNTTEFullSourceIRandom(_fx.image_number-1);_fx.ntte_full_flash=2
        with(_fx) scrNTTEFullMergedStockFX(x,y,scrNTTEFullSourceRandomRange(4,8),Smoke)
    }
    scrNTTEFullMergedBasicSoundAt(x,y,sndPlantPotBreak,scrNTTEFullSourceRandomRange(0.7,1),5,64)
    scrNTTEFullMergedBasicSoundAt(x,y,sndExplosion,scrNTTEFullSourceRandomRange(0.9,1.1),5,64)
    scrNTTEFullMergedBasicSoundAt(x,y,sndIDPDNadeExplo,scrNTTEFullSourceRandomRange(0.5,0.7),5,64)
    if(instance_exists(strike)) {
        strike.ammo=min(strike.ammo,1)
        strike.ntte_strike_alarm=min(strike.ntte_strike_alarm,strike.time)
    }
}
