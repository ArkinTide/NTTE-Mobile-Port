if lockstep_stop
	exit

// [60帧适配] 生长积分：每帧积分 + 全部增量乘 timescale（与 Spiral/Step_0.gml 同法）。
//   30fps（_dt=1）与原版逐项等价；60fps 下生长曲线与原版一致。
//
var _dt = timescale;

x = xstart + lengthdir_x(dist * image_xscale, angle)
y = ystart + lengthdir_y(dist * image_xscale, angle)
//angle += turnspeed

dist += grow * _dt

grow += (0.0005) * _dt
image_xscale += (grow / 1.5) * _dt
image_yscale += (grow / 1.5) * _dt
grow += (0.001 * image_xscale * (grow + 1)) * _dt

if !instance_exists(SpiralCont) grow *= power(1.5, _dt)
else {
    if SpiralCont.type = 2 grow *= power((image_xscale / 10) + 1, _dt)
}

grow *= power((image_xscale / 20) + 1, _dt)
if image_xscale > 30 instance_destroy()

//image_angle += rotspeed