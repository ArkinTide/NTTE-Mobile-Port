// Original weps/tesla coil.wep.gml, actual TeslaCoil constructor/event path.
function scrNTTEFullTeslaWeaponFire(_primary=true) {
    var _owner=scrNTTEFullElectroWeaponCreator(),
        _shot=scrNTTEFullMergedBasicProjectileCreate(x,y,NTTEFullTeslaCoil,gunangle),
        _count=0,_capture_creator=_shot.creator
    // NPC synchronous Fish contexts are destroyed after fire returns. Source
    // grouping/counting is already by the durable owner during this callback.
    _shot.creator=_owner
    _shot.ntte_full_primary=_primary
    if(!_primary) _shot.ntte_full_offy-=4
    var _xd=_shot.ntte_full_offx,_yd=_shot.ntte_full_offy
    with(NTTEFullTeslaCoil) if(creator==_owner && ntte_full_primary==_primary) _count++
    if(_count==1) {
        scr_weapon_post(gunangle,-10,10,8)
        _yd*=scrNTTEFullValue(_owner,"right",1)
        var _fx=instance_create(x+lengthdir_x(_xd,gunangle)+lengthdir_x(_yd,gunangle-90),
            y+lengthdir_y(_xd,gunangle)+lengthdir_y(_yd,gunangle-90)-(_primary?0:4),LightningHit)
        scrNTTEFullNativeMotionAddFT(_fx,gunangle,0.5)
        if(scr_skill_get(mut_laser_brain)>0) {
            snd_play(sndGuitarHit7,2.4+random(0.4),0.6)
            snd_play(sndLaserUpg,0.8+random(0.2),0.6)
            snd_play(sndDevastatorExplo,1.4+random(0.4),0.6)
        }
        else {
            snd_play(sndGuitarHit6,1.6+random(0.4),0.4)
            snd_play(sndLaser,1.4+random(0.4),1)
        }
    }
    // ActorFire collects synchronous proxy-owned shots on callback return,
    // then remaps them to the durable owner. Grouping above temporarily used
    // the durable owner; preserve the collector's actual source identity.
    _shot.creator=_capture_creator
    return _shot
}
function scrNTTEFullTeslaWeaponReloaded() {
    snd_play(sndLightningReload,0.5+random(0.5),0.8)
}
