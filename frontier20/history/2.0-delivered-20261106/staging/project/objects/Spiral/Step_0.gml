if lockstep_stop
	exit

// [60帧适配] 螺旋环的生长：每帧积分，三个增量都按 timescale 折算。
//   30fps（timescale=1）→ 与原版逐项等价；60fps → 实时生长曲线与原版一致，但每帧更新（真 60 帧）。
//   ⚠️ 三个增量必须都折算：只折算第一行会让 compounding 项在 60fps 下偏快，环数 118 → 146。
//
var _dt = timescale;

grow += 0.0002 * _dt

if (sprite_index == sprSpiralProto) {
    grow += 0.0003 * _dt
}

image_xscale += grow * _dt
image_yscale += grow * _dt
grow += (0.0005 * image_xscale * (grow + 1)) * _dt

var _m;

if (!instance_exists(SpiralCont)) {
	grow *= power(1.5, _dt)
	_m = 3
}
else {
	_m = 2.5
}

if (image_xscale > _m && (lanim < 0 || lanim > 6)) {
    instance_destroy()
}

lanim += (0.2 + random(0.3)) * _dt
