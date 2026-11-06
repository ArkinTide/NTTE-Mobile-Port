snd_play(sndNothingStart)
raddrop = 500
max_hp = 1500

with BigGeneratorInactive {
    with instance_create(x, y, BigGenerator) {
        image_xscale = other.image_xscale
    }

    instance_destroy(id, 0)
}

max_hp *= 1 + (GameCont.loops / 3)
meleedamage = 10
size = 8

spr_idle = sprNothingMiddle
spr_walk = sprNothingMiddle
spr_hurt = sprNothingMiddle
spr_dead = sprNothingMiddle

event_inherited()
hitid = HitId.Throne

hp = max_hp

snd_hurt = sndNothingHurtHigh
snd_dead = sndNothingDeath2

walk = 0
footstep = 0
walkdir = 0
ammo = 0
mode = 0
introwalk = 0
targetx = x
targety = y + 1000
alarm[1] = 30
scrTarget()
friction = (1.7) * timescale * timescale
wave = 0
dmg = 0
flame = sprThroneFlameIdle
flanim = 0
sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0

hitid = HitId.Throne
// NTTE Coast constructor wading variables
scrNTTEFullCoastConstructWading();

// BEGIN NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Nothing.Create.after
if(os_type==os_windows && scrNTTEFullSmokeEnabled() && instance_exists(NTTEFullPalaceArtifactPortalCarryTest)) try { scrNTTEFullPalaceArtifactPortalCarryExitProbe("Nothing.Create.after"); }
catch(_ntte_palace_carry_error) { scrNTTEFullPalaceArtifactPortalCarryAbort(_ntte_palace_carry_error); }
// END NTTE PALACE ARTIFACT PORTAL CARRY TEST EXIT Nothing.Create.after