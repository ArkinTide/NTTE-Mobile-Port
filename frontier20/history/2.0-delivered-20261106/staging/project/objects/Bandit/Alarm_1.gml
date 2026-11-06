// BEGIN NTTE CUZ CONNECTED TEST BANDIT SHOT BEFORE
var _ntte_cuz_bandit_sample=undefined;
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { _ntte_cuz_bandit_sample=scrNTTEFullCuzConnectedBanditBefore(id); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST BANDIT SHOT BEFORE
alarm[1] = 20 + random(10)

scrTarget()
if instance_exists(target) {
    if collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        if point_distance(target.x, target.y, x, y) > 48 {
            if random(4) < 1 {
                wkick = 4
                snd_play(GameCont.underwater ? sndOasisShoot : sndEnemyFire)
                with instance_create(x, y, EnemyBullet1) {
                    motion_add(other.gunangle + random(20) - 10, (4) * timescale)
                    image_angle = direction
                    creator = other.id
                    team = other.team
                    hitid = other.hitid
                }
                gunangle = mcr_target_direction
                alarm[1] = 20 + random(5)
            } else {
                direction = mcr_target_direction + random(180) - 90
                speed = (0.4) * timescale
                walk = 10 + random(10)
                gunangle = mcr_target_direction
            }

        } else {
            direction = point_direction(target.x, target.y, x, y) + random(20) - 10
            speed = (0.4) * timescale
            walk = 40 + random(10)
            gunangle = mcr_target_direction
        }

        if target.x < x right = -1
        else if target.x > x right = 1
    } else if random(4) < 1 {
        motion_add(random_angle, (0.4) * timescale)
        walk = 20 + random(10)
        alarm[1] = walk + 10 + random(30)
        gunangle = direction
        if hspeed > 0 right = 1
        else if hspeed < 0 right = -1
    }
} else if random(10) < 1 {
    motion_add(random_angle, (0.4) * timescale)
    walk = 20 + random(10)
    alarm[1] = walk + 10 + random(30)
    gunangle = direction
    if hspeed > 0 right = 1
    else if hspeed < 0 right = -1
}
// BEGIN NTTE CUZ CONNECTED TEST BANDIT SHOT AFTER
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullCuzConnectedTest)) try { scrNTTEFullCuzConnectedBanditAfter(_ntte_cuz_bandit_sample); }
catch(_ntte_cuz_connected_error) { scrNTTEFullCuzConnectedAbort(_ntte_cuz_connected_error); }
// END NTTE CUZ CONNECTED TEST BANDIT SHOT AFTER