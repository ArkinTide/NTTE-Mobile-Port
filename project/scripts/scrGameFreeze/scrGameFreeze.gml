function scrGameFreeze() {
    var scrn = surface_create(view_width, view_height)

    surface_set_target(scrn)
    draw_surface(application_surface, 0, 0)

    gpu_set_blendmode(bm_add)
    with BackCont {
        if surface_exists(shad) {
            scrNTTEFullIOSShadowPresent(shad,0,0,shadow_color,0.3,
                scrNTTEFullValue(id,"ntte_full_ios_shadow_fixture",undefined),
                scrNTTEFullValue(id,"ntte_full_ios_shadow_shader_fixture",undefined))
        }
    }
    gpu_set_blendmode(bm_normal)
    /*
	draw_set_color(c_black)
	gpu_set_blendmode(bm_add)
	draw_rectangle(0, 0, view_width, view_height, 0)
	gpu_set_blendmode(bm_normal)
	draw_set_color(c_white)*/

    surface_reset_target()

    with instance_create(view_xview, view_yview, PauseImage) {
        surf = scrn

        instance_deactivate_all(1)
        instance_activate_object(CoopController)
        instance_activate_object(UberCont)
    }
}