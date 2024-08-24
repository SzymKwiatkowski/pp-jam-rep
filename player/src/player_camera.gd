class_name PlayerCamera
extends Camera2D

@export var to_follow: Node2D


func _process(delta):
	if to_follow:
		global_position.x = to_follow.global_position.x
