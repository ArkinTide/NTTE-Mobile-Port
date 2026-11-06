scrNTTEFullSkinTimeStatTick()
draw_set_halign(fa_center)
draw_set_valign(fa_middle)

if instance_exists(SpiralCont) {
    with SkillText {
        // 同 LevCont/Draw_64：floor() 对齐 60 帧闪烁占空比（30 帧恒等）。
        // 显式比较（与 LevCont/Draw_64 同源）。
        if (disappear <= 0) or floor(disappear) % 2 == 0 draw_text_nt(x, y, "@d" + loc(txt))
    }
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)