/// @description Create main menu buttons

var _step_size = 24,
    _buttons = [0, 2, 3, 4],
    _button_x = floor(view_xview_center),
    _button_y = floor(view_yview_center - _step_size * (array_length(_buttons) - 1) / 2)

for (var i = 0; i < array_length(_buttons); ++i) {
    with instance_create(_button_x, _button_y, MainMenuButton) {
        image_index = _buttons[i]
    }
    _button_y += _step_size
}

instance_create(0, 0, ButtonDiscord)
instance_create(0, 0, ButtonAchievements)

instance_destroy()