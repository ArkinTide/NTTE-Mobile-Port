if lockstep_stop
	exit

if z > 0 {
    image_angle += rotspeed * speed
}

// 每帧乘性衰减改为按 30Hz 逻辑帧结算
if (current_frame_active) speed *= 0.9

if speed < (3) * timescale {
    if z > 0 {
        z -= (0.4) * timescale
    } else {
        image_alpha -= (0.1) * timescale

        if image_alpha < 0 {
            instance_destroy()
        }
    }
}

z += speed / 5