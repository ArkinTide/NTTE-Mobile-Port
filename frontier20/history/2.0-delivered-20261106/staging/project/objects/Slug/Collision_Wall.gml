// NTTE merged native collision entry, preserving inherited dispatch.
var _ntte_merge_collision=scrNTTEFullMergedNativeCollisionBegin(id,other.id);
if(!is_undefined(_ntte_merge_collision) && !_ntte_merge_collision.allow) { scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision); exit; }
try {
// 每次撞墙都结算（= 原始 30 帧语义）。
// 撞墙是「单帧事件」：门控会让约一半的撞墙跳过 speed *= 0.8 → 子弹保住满速 → 回弹过快（F23）。
// 恢复「每次撞墙都结算」= 原始 30 帧语义（30 帧下门控本来恒为真，行为不变）。
if lockstep_stop
	exit

if speed > (6) * timescale and !snd_is_playing(sndShotgunHitWall) snd_play(sndShotgunHitWall)
sleep(1)
move_bounce_solid(true)
speed *= 0.8
speed += wallbounce
wallbounce *= 0.9

if speed > (18) * timescale speed = (18) * timescale
instance_create(x, y, Dust)
}
finally {
    scrNTTEFullMergedNativeCollisionEnd(_ntte_merge_collision);
}
