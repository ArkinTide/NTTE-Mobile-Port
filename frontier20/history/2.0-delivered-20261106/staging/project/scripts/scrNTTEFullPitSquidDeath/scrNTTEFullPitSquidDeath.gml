// Original PitSquid staged death, with the recovered NTT pickup-drop rules.
function scrNTTEFullPitSquidDeath() {
    if (hp>0 || !instance_exists(GameCont)) return;
    x=ntte_full_x; y=ntte_full_y
    snd_play(snd_dead,0.6); snd_play(sndBallMamaHalfHP,0.6,2); snd_dead=-1
    var _death=instance_create(x,y,NTTEFullPitSquidDeath)
    _death.ntte_full_eye=ntte_full_eye; _death.ntte_full_eye_dir=ntte_full_eye_dir
    _death.ntte_full_eye_turn=ntte_full_eye_turn; _death.ntte_full_eye_distance=ntte_full_eye_distance
    _death.ntte_full_pit_height=ntte_full_pit_height; _death.direction=direction
    _death.speed=min(speed,2*timescale); _death.raddrop=raddrop
    _death.image_xscale=image_xscale; _death.image_yscale=image_yscale; _death.image_angle=image_angle
    raddrop=0
    with (MusCont) alarm[1]=1
}

function scrNTTEFullPitSquidDeathCreate() {
    friction=0.01*timescale*timescale; visible=false; raddrop=0
    ntte_full_eye=[]; ntte_full_eye_dir=random(360); ntte_full_eye_turn=0; ntte_full_eye_distance=0
    ntte_full_pit_height=0; ntte_full_explode=true; ntte_full_sink=false; ntte_full_timers=[30,-1,-1,-1]
    var _prevent=instance_create(0,0,NTTEFullPortalPrevent); _prevent.creator=id
}

function scrNTTEFullPitSquidDeathStep() {
    if (lockstep_stop) return;
    var _due=scrNTTEFullTrenchClock()
    if (_due[0] && (ntte_full_explode || !ntte_full_sink)) {
        ntte_full_timers[0]=ntte_full_sink ? 30:33; ntte_full_sink=!ntte_full_sink
        if (ntte_full_explode) ntte_full_eye_turn-=12+random(4)
        else vspeed+=2/3*timescale
    }
    if (ntte_full_pit_height<=0.1) { instance_destroy(); return; }
    var _goal=ntte_full_sink ? (ntte_full_explode ? 0.5:0):1
    if (ntte_full_explode && !ntte_full_sink && ntte_full_pit_height!=_goal && abs(_goal-ntte_full_pit_height)<0.2) {
        ntte_full_explode=false
        for(var _i=0;_i<array_length(ntte_full_eye);++_i) {
            var _eye=ntte_full_eye[_i]
            instance_create(_eye.x,_eye.y,NTTEFullBubbleExplosion); snd_play(sndNothingDeath2,0.6,0.8)
            var _x=x,_y=y
            x=_eye.x;y=_eye.y;scrNTTEFullPickupDropBody(80,0);x=_x;y=_y
        }
        scrRadDrop(x,y,raddrop); raddrop=0
    }
    ntte_full_pit_height+=(_goal-ntte_full_pit_height)/(ntte_full_sink ? 30:4)*timescale
    ntte_full_eye_distance-=ntte_full_eye_distance/5*timescale
    ntte_full_eye_dir+=ntte_full_eye_turn*timescale
    ntte_full_eye_turn-=ntte_full_eye_turn*(ntte_full_explode ? 0.1:0.05)*timescale
    for(var _i=0;_i<array_length(ntte_full_eye);++_i) {
        var _eye=ntte_full_eye[_i],_distance=(24+ntte_full_eye_distance)*max(ntte_full_pit_height,0),
            _dir=image_angle+ntte_full_eye_dir+360*_i/array_length(ntte_full_eye)
        _eye.x=x+hspeed+lengthdir_x(_distance*image_xscale,_dir)+orandom(2/3)
        _eye.y=y+vspeed+lengthdir_y(_distance*image_yscale,_dir)+orandom(2/3)
        _eye.distance-=_eye.distance*0.3*timescale
        if (random(16)<timescale) {
            var _fx=instance_create(_eye.x+orandom(8),_eye.y+orandom(8),PortalL)
            _fx.image_xscale=0.5; _fx.image_yscale=0.5
        }
    }
}

function scrNTTEFullPitSquidDeathDraw() {
    var _xs=image_xscale*max(ntte_full_pit_height,0),_ys=image_yscale*max(ntte_full_pit_height,0),
        _col=merge_color(c_black,image_blend,clamp(ntte_full_pit_height,0,1)),_lid=scrNTTERefSprite("PitSquidEyelid")
    for(var _i=0;_i<array_length(ntte_full_eye);++_i) {
        var _eye=ntte_full_eye[_i],_distance=_eye.distance*max(ntte_full_pit_height,0)
        if (ntte_full_explode) {
            // NTTE SOURCE PITSQUID DEATH EYE FLASH: trench.area956..959.
            gpu_set_fog(((current_frame % 6)<2 || (!ntte_full_sink && ntte_full_pit_height<1)),_col,0,0)
            draw_sprite_ext(scrNTTERefSprite("PitSquidCornea"),image_index,_eye.x,_eye.y,_xs,_ys,image_angle,_col,image_alpha)
            draw_sprite_ext(scrNTTERefSprite("PitSquidPupil"),image_index,
                _eye.x+lengthdir_x(_distance*image_xscale,_eye.dir),_eye.y+lengthdir_y(_distance*image_yscale,_eye.dir),
                _xs/2,_ys,image_angle,_col,image_alpha)
            gpu_set_fog(false,0,0,0)
        }
        draw_sprite_ext(_lid,ntte_full_explode ? 0:sprite_get_number(_lid)-1,_eye.x,_eye.y,_xs,_ys,image_angle,_col,image_alpha)
    }
}

function scrNTTEFullPitSquidDeathDestroy() {
    instance_create(x,y,Bubble)
    with (NTTEFullPortalPrevent) if (creator==other.id) instance_destroy()
    var _corpse=instance_create(xstart,ystart,Corpse); _corpse.alarm[0]=10
}
