// Remaining teassets.surface_setup consumers. Logical camera dimensions stay
// unchanged; quality changes the texture dimensions and reciprocal draw scale.
function scrNTTEFullQualitySurfaceSize(_logical,_scale) {
    return max(1,floor(_logical*_scale))
}
function scrNTTEFullQualityCamera(_camera,_x,_y,_w,_h) {
    camera_set_view_pos(_camera,_x,_y);camera_set_view_size(_camera,_w,_h)
    camera_apply(_camera);matrix_set(matrix_world,matrix_build_identity())
}
