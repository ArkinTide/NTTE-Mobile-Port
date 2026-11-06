array_foreach(sprites, function(_sprite) {
	if (sprite_exists(_sprite)) {
		sprite_flush(_sprite)
		sprite_delete(_sprite)
	}
})

if (!opt_resolution_last) {
	UberCont.opt_resolution = opt_resolution_last
	with (UberCont) scrSetViewSize(false)
}

self.screenshots_cleanup()

if (surface_exists(text_surface)) {
	surface_free(text_surface)
}

directory_destroy_recursive(game_directory + "install")

if (reload_needed) {
	if (global.safemode) {
		show_message_async("The game is running in safe mode. Resourcepacks won't be applied until the game is restarted.")
	}
	
	// 重载/重启前先把已替换精灵还原为原版：
	// 否则 game_restart()/load_resourcepacks() 删除纹理组后，旧精灵悬空引用
	// → 彩色垃圾块甚至崩溃（关闭/切换资源包时的已知故障）。
	discard_custom_sprites(true)
	
	if (reload_needed == 2) {
		game_restart()
	}
	else {
		load_resourcepacks()
	}
}