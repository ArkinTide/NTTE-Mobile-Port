if speed > 0 {
    alarm[1] = random(20) / speed * timescale + 1
    instance_create(x, y, Dust)
}