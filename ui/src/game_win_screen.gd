extends Control


func _enter_tree():
	$MarginContainer/VBoxContainer/Score.text = "%f" % RootGameManager.level_end()


func _on_retry_pressed():
	RootGameManager.level_start()
	get_tree().change_scene_to_packed(RootGameManager.current_level)


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://ui/scn/menu.tscn")
