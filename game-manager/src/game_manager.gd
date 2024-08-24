extends Node


var current_level: PackedScene
var time: float
var level_running: bool

func _process(delta):
	if level_running:
		time += delta


func level_start():
	time = 0
	level_running = true


func level_end():
	level_running = false
	return time
