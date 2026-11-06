if (lockstep_stop) exit
// The native ToxicGas growth increment lacks a timescale multiplier; keep the
// Cat spray's area and lifetime consistent at 30, 60 and 120 physical FPS.
if (image_xscale+growspeed*timescale<1) {
    image_xscale+=growspeed*timescale; image_yscale+=growspeed*timescale
}
if (growspeed>-0.005) growspeed-=0.0002*timescale
if (image_xscale<0.4) { growspeed-=0.01*timescale; image_angle+=rot*timescale }
if (image_xscale<0) instance_destroy()
