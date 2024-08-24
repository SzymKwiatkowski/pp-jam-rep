extends Control

@export var player_scene: PackedScene
@export var player_camera: PackedScene
@export var map_scene: PackedScene
@export var sun_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://level/scn/level_base.tscn")


func _on_quit_pressed():
	queue_free()
	get_tree().quit()
