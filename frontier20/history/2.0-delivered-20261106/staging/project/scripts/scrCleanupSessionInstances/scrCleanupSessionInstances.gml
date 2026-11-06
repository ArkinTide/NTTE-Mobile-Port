function scrCleanupSessionInstances() {
	with all {
	    if (object_index == UberCont
			|| object_index == CoopController
			|| object_index == Console
		) {
			continue
		}
		
		instance_destroy(id, false)
	}

	// 会话销毁 = 本局结束 → 丢掉「未消费的 debugclear 还原标记」。
	// 正常流程里它由 GenCont/Alarm_1 消费；但若在关卡加载完成前就退出到主菜单（或 Retry），
	// 它会残留 → **下一局开局被传到上一局的坐标**。这是会话状态的正确生命周期。
	if (variable_global_exists("debugclear_restore")) global.debugclear_restore = undefined
}