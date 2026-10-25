if instance_exists(MenuOptions) && MenuOptions.editing_mode && !UberCont.opt_gamepad {
    var _touch=index!=-1?index:get_nearest_touch(rad);
    if(_touch!=-1) scrMobileControlsRemapSample(_touch,
        device_mouse_x_to_gui(_touch),device_mouse_y_to_gui(_touch),
        device_mouse_check_button(_touch,mb_left));
}
