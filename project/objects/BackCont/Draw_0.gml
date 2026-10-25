if lockstep_stop
	exit

//draw
with Scorch {
    draw_sprite(sprScorchTop, image_index, x, y)
}

if surface_exists(shad) {
    scrNTTEFullIOSShadowPresent(shad,view_xview,view_yview,shadow_color,0.4,
        scrNTTEFullValue(id,"ntte_full_ios_shadow_fixture",undefined),
        scrNTTEFullValue(id,"ntte_full_ios_shadow_shader_fixture",undefined))
}