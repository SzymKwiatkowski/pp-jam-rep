extends Camera2D

var to_follow: Node2D


func _process(delta):
	if to_follow:
		global_position.x = to_follow.global_position.x
