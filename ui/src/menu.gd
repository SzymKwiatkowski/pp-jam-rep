extends Control

@export var player_scene: PackedScene
@export var map_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_pressed():
	var player_instance = player_scene.instantiate()
	var map_instance = map_scene.instantiate()
	var main_instance = get_parent()
	main_instance.add_child(map_instance)
	main_instance.add_child(player_instance)
	queue_free()
	


func _on_quit_pressed():
	queue_free()
	get_tree().quit()
