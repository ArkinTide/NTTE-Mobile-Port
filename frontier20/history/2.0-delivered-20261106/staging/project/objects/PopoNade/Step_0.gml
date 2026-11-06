if speed == 0 {
    with instance_create(x + orandom(48), y + orandom(48), IDPDPortalCharge) {
        motion_add(point_direction(x, y, other.x, other.y), (2 + random(1)) * timescale)
        alarm[0] = point_distance(x, y, other.x, other.y) / speed * timescale + 1
        depth -= timescale
    }
}

if (alarm[0] <= 20 && !sound) {
	snd_play_hit(sndIDPDNadeAlmost, 0.2)
	sound = true
}
