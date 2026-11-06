function sprite_strip_save(spr, path) {
    var n = sprite_get_number(spr)
    var w = sprite_get_width(spr)
    var h = sprite_get_height(spr)

    if !(w or h or n) return undefined

    var s = surface_create(w * n, h)
    surface_set_target(s)
	
	draw_clear_alpha(c_black, 0)
	
    // 透明度修复 —— 与 RectCompactor.gml 同一问题，
    // 这里备份的是原版精灵；若沿用 bm_normal，存出的 PNG 会带预乘颜色，
    // 之后 discard_custom_sprites() 用 sprite_replace() 还原时，
    // 连原版精灵都会被二次预乘而变暗。各帧在 surface 上并排且不重叠，故可安全用纯拷贝。
    gpu_set_blendmode_ext_sepalpha(bm_one, bm_zero, bm_one, bm_zero)
    
    for (var i = 0; i < n; i++) {
        draw_sprite(spr, i, i * w + sprite_get_xoffset(spr), sprite_get_yoffset(spr))
    }
    
    gpu_set_blendmode(bm_normal)

    surface_reset_target()

    surface_save(s, path)

    surface_free(s)
}