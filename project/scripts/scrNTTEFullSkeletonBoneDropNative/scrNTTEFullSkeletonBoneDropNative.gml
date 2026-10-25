// Original ted esert EndStep rewards dead BonePile/BonePileNight/BigSkull.
// Native prop BeginStep already destroys them before an EndStep scan can run.
function scrNTTEFullSkeletonBoneDropNative() {
    if(!(instance_is(id,BonePile) || instance_is(id,NightBonePile) || instance_is(id,BigSkull)
        || instance_is(id,MaggotSpawn) || instance_is(id,NTTEMaggotNest)
        || instance_is(id,NTTEFullBigMaggotSpawn))) return;
    if(hp>0 || scrNTTEFullValue(id,"ntte_full_bone_drop_done",false)) return;
    // EelSkull's earlier child Destroy uses this same guard before inheritance.
    ntte_full_bone_drop_done=true
    // The requested 20% nest reward is rolled once, including failed rolls.
    if((instance_is(id,MaggotSpawn) || instance_is(id,NTTEMaggotNest)
        || instance_is(id,NTTEFullBigMaggotSpawn)) && random(1)>=0.2) return;
    var _bone=instance_create(x,y,WepPickup)
    scrNTTEFullBoneDropVisual(_bone)
    with(_bone) motion_add(random(360),3*timescale)
    // telib.fx(x,y,3,Dust): exact origin, additive random motion3,
    // and reorientation only when the original effect initially faced motion.
    repeat(2) with(instance_create(x,y,Dust)) {
        var _face=(image_angle==direction)
        motion_add(random(360),3*timescale)
        if(_face) image_angle=direction
    }
}

function scrNTTEFullBoneDropVisual(_bone) {
    with(_bone) {
        wep=wep_ntte_bone
        name=scr_weapon_get_name(wep);type=scr_weapon_get_type(wep)
        sprite_index=scr_weapon_get_sprite(wep)
    }
}
