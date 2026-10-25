if type == SpiralType.Proto {
    image_angle += (10 + sin(image_angle / 300) * 2 + orandom(1)) * timescale
}
else {
    image_angle += (8 + sin(image_angle / 300) * 1) * timescale
}

// [60帧适配] 环的「生成」基准是 30Hz：隔帧生成，与 Spiral/Step_0.gml 的生长同节拍。
//   用实例内开关（而非 current_frame_active）是因为 Create 的预热循环不推进 current_frame。
//
// NTTE source30Hz ring/time phase, including120Hz (four frames/tick).
ntte_full_spiral_phase=scrNTTEFullValue(id,"ntte_full_spiral_phase",0)+timescale
spawn_toggle=ntte_full_spiral_phase>=1
if(spawn_toggle) ntte_full_spiral_phase-=floor(ntte_full_spiral_phase)

if (spawn_toggle) {
	time ++
}

var _cx = view_width div 2,
	_cy = view_height div 2

if (type == SpiralType.IDPD || type == SpiralType.Venuz) {
    x = _cx
    y = _cy
}
else {
	x = _cx + sin(image_angle / 921) * sin(image_angle / 500) * 80
	y = _cy + cos(image_angle / 583) * sin(image_angle / 500) * 50
}

if spawn_toggle && random(16) < 1 && type != SpiralType.Venuz {
    if (type == SpiralType.Proto || random(3) < 1) && !bossfight {
        with (instance_create(x, y, SpiralDebris)) depth = other.image_angle
    }
}

if type != SpiralType.Venuz {
    if (spawn_toggle) {
        with instance_create(x, y, Spiral) {
            image_xscale = 0
            image_yscale = 0

            depth = other.image_angle
            image_angle = other.image_angle
            
            if other.type == SpiralType.IDPD {
                sprite_index = sprSpiralIDPD
                
                if other.time % 11 <= 1 {
                    sprite_index = sprSpiralIDPD2
                }
                
                x = _cx
                y = _cy
            }
            
            if other.type == SpiralType.Proto {
                sprite_index = sprSpiralProto
                image_xscale = random(0.01)
                image_yscale = image_xscale
            }
        }
    }
}
else {
	if (spawn_toggle) {
		instance_create(x, y, SpiralStar)
	}
}

if !instance_exists(NothingSpiral) && !instance_exists(MainMenu) {
	if !active && (!scrGameIsGenerationScreen() && !instance_exists(Credits)) {
		instance_destroy()
	}
}
