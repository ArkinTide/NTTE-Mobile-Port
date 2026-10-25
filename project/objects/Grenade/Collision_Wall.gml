// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
// 每次撞墙都结算（= 原始 30 帧语义）。
// 撞墙是「单帧事件」：门控会让约一半的撞墙跳过 speed *= 0.8 → 子弹保住满速 → 回弹过快（F23）。
// 恢复「每次撞墙都结算」= 原始 30 帧语义（30 帧下门控本来恒为真，行为不变）。
if lockstep_stop
	exit

if sticky {

    snd_play(sndGrenadeStickWall)
	
    if speed > 0
		instance_create(x, y, Dust)
	
	speed = 0
    move_contact_solid(direction, 12)
}
else {
    if speed > (1) * timescale
		snd_play(sndGrenadeHitWall)
    
	move_bounce_solid(true)
	speed *= 0.6
    
	instance_create(x, y, Dust)
}
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}
