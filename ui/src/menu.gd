extends Control


func _on_play_level_1_pressed():
	display_loading()
	load_level("res://level/scn/level_1.tscn")


func _on_play_level_2_pressed():
	display_loading()
	load_level("res://level/scn/level_2.tscn")


func _on_play_level_3_pressed():
	display_loading()
	load_level("res://level/scn/level_3.tscn")


func load_level(level: String):
	var current_level = load(level)
	RootGameManager.current_level = current_level
	RootGameManager.level_start()
	get_tree().change_scene_to_packed(current_level)


func display_loading():
	$MarginContainer.visible = false
	$Label.visible = true


func _on_quit_pressed():
	queue_free()
	get_tree().quit()
