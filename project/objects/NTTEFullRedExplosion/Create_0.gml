// tecaves.mod.gml::RedExplosion_create, original MeatExplosion parent.
event_inherited()
sprite_index=scrNTTERefSprite("RedExplosion")
image_angle=random(360)
hitid=[sprite_index,"ANNIHILATION"]
mask_index=mskPlasma
damage=200
force=2
team=team_player
target=noone
audio_stop_sound(sndMeatExplo)
var _sound=snd_play(sndUltraEmpty,1.1+random(0.2),2)
if(_sound!=-1) audio_sound_set_track_position(_sound,0.1)
_sound=snd_play(sndExplosionS,0.8+random(0.4),3)
if(_sound!=-1) audio_sound_set_track_position(_sound,0.03)
_sound=snd_play(sndIDPDNadeExplo,1.2+random(0.4),3)
if(_sound!=-1) audio_sound_set_track_position(_sound,0.4)
