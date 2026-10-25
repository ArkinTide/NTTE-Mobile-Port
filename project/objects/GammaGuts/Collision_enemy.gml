// [60帧适配] 本碰撞体每帧执行；60fps 下会变成 60 次/秒（30fps 是 30 次/秒）→
// 攻击间隔减半。用 current_frame_active 隔帧到 30Hz（30fps 下恒真，行为不变）。
if (!current_frame_active) exit

if other.object_index == Van || !scr_can_hit(other.id, false) exit

if scr_hit(other.id, damage) && other.hp <= 0 {
    sprite_index = sprGammaBlast
    image_index = 0
	
    with enemy {
        if point_distance(x, y, other.x, other.y) <= 32 {
			scr_hit_self(8)
        }
    }
	
    image_alpha = 0.2
    snd_play(sndGammaGutsKill)
}