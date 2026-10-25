/// @function scrFirstFrameAnim
/// @param image_speed
function scrFirstFrameAnim(_image_speed) {
	gml_pragma("forceinline")
	// [ts-fix] 60帧适配：调用方传入的是设计常量（0.4），按 timescale 缩放
	image_index += ((image_index < 1) ? random(_image_speed * 0.05) : _image_speed) * timescale
}