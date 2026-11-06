if !roll && race != Race.Frog {
	move_contact_solid(direction, clamp(speed, 1, maxspeed))
	
	if place_meeting(x + hspeed, y, InvisiWall) {
		hspeed /= 2
		
		if place_meeting(x + hspeed, y, InvisiWall) {
			hspeed = 0
		}
	}
	
	if place_meeting(x, y + vspeed, InvisiWall) {
		vspeed /= 2
		
		if place_meeting(x, y + vspeed, InvisiWall) {
			vspeed = 0
		}
	}
	
	x += hspeed
	y += vspeed
}
else {
	move_bounce_solid(true)
	
	if (race != Race.Frog) {
		// 本处不缩放（结算单位是「事件」而非「帧」）。
		// 这是「一次撞墙事件」的角速度踢腿（把翻滚的 angle 直接推到接近 540 → 结束翻滚），
		// 结算单位是「事件」而非「帧」→ 不该缩放。
		// 60 帧下原本踢腿只有一半 → 翻滚要多撞好几次才结束 → 回弹距离被放大（F8）。
		angle += ((720 - abs(angle)) * right * 0.7)
	}
	
	x += hspeed
	y += vspeed
}