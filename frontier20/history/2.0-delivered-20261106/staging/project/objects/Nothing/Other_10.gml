event_inherited()

if hp < (max_hp * 0.7) && !sndhalfhp {
    snd_hurt = sndNothingHurtMid
    snd_play(sndNothingMidHP)
    sndhalfhp = 1
}

if hp < (max_hp * 0.4) && sndhalfhp == 1 {
    snd_hurt = sndNothingHurtLow
    snd_play(sndNothingLowHP)
    sndhalfhp = 2
}

with enemy {
    if id != other.id && object_index != Guardian {
        instance_destroy()
    }
}

with Portal {
    instance_destroy()
}

if walk && instance_exists(Player) {
    if BackCont.shake < 3 {
        BackCont.shake = 3
    }

    if !(sprite_index == spr_hurt && image_index < 1) {
        y += (1) * timescale
    }

    motion_add(walkdir, (2) * timescale * timescale)

    if speed > (4) * timescale {
        speed = (4) * timescale
    }

    walk-= timescale
} else if speed > (1) * timescale speed = (1) * timescale

dmg+= timescale

if sprite_index == spr_hurt {
    dmg = 0
}

if !instance_exists(Player) && !sndtaunt {
    tauntdelay += (1) * timescale

    if tauntdelay > 150 {
        snd_play(sndNothingTaunt)
        sndtaunt = 1
    }
}