alarm[0] = 40
// 60帧适配：兜底计时器。
// 提示文字的消失阶段原本只靠 alarm[0] 触发，一旦 alarm 计时异常（60fps 下曾因
// 补偿失效而永不触发），文字就会「黏在原地」并残留到后续加载界面。
// 这里加一个按 timescale 推进的计数器，两者取先到者，保证一定会消失。
showtime = 0
ticked = false
txt = ""
disappear = 0

with SkillText {
    if (id != other.id) y -= string_height("Aa")
}