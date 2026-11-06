if lockstep_stop
	exit

// [60帧适配] 生长积分：每帧积分 + 全部增量乘 timescale（与 Spiral/Step_0.gml 同法）。
//   30fps（_dt=1）与原版逐项等价；60fps 下生长曲线与原版一致。
//
var _dt = timescale;

x = xstart + lengthdir_x(dist * image_xscale, angle)
y = ystart + lengthdir_y(dist * image_yscale, angle)
angle += turnspeed * _dt

dist += grow * _dt

grow += (0.0005) * _dt
image_xscale += (grow / 1.5) * _dt
image_yscale += (grow / 1.5) * _dt
grow += (0.001 * image_xscale * (grow + 1)) * _dt

if !instance_exists(SpiralCont) {
	grow *= power(1.5, _dt)
}
else {
    if (SpiralCont.type == SpiralType.Proto) {
		grow *= power(image_xscale * 0.1 + 1, _dt)
	}
}

grow *= power(image_xscale * 0.05 + 1, _dt)

// NTTE original screen-local SpiralDebris bounds
// NTT009d571a/009d5760/009d583e/009d5884 uses -16,width+16,height+16;
// scrDrawSpiral adds world camera offsets only at draw time.
if ((x < -16 || x > view_width + 16) || (y < -16 || y > view_height + 16)) {
	instance_destroy()
}

if (!sound && image_xscale > 1.3) {
	var _snd = choose(sndPortalFlyby1, sndPortalFlyby2, sndPortalFlyby3, sndPortalFlyby4)
    snd_play_pitchvol(_snd, 0.1, UberCont.opt_ambvol)
    sound = true
}

image_angle += (rotspeed) * timescale