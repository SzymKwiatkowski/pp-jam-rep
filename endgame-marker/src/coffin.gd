extends Node2D


var end_level_request: bool = false


func _on_body_entered(body):
	if body as Player:
		end_level_request = true


func _process(_delta):
	if end_level_request == true:
		end_level_request = false
		get_tree().change_scene_to_file("res://ui/scn/game_win_screen.tscn")
