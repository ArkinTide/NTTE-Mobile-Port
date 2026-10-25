if lockstep_stop
	exit

if fall {
    fall -= timescale
	image_angle += (rot) * timescale

    x += (0.35 * sin(fall / 7)) * timescale
    y += (0.3) * timescale

    if speed > (0.2) * timescale {
        // 每帧乘性衰减改为按 30Hz 逻辑帧结算
        if (current_frame_active) speed *= 0.9
    }
	else speed = 0
}

if !speed
	image_speed = 0