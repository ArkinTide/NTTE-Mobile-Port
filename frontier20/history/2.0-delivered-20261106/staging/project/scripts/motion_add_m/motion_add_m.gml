/// @function motion_add_m
/// @param direction
/// @param speed
/// @param limit=16
function motion_add_m(_direction, _speed, _limit = undefined) {
    motion_add(_direction, _speed)

    // [ts-fix] 60帧适配：_limit 的语义是「缩放后单位」（与 speed 一致，
    // 调用方传的设计常量已由改写工具乘过 timescale）。
    // GML 的函数默认参数必须是常量，不能直接写 `_limit = 16 * timescale`，
    // 故用 undefined 作哨兵，在函数体内补上缩放后的默认限速（16 是 30fps 设计常量）。
    if (is_undefined(_limit)) _limit = 16 * timescale

    if speed > _limit {
        speed = _limit
    }
}