extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sun.pivot_point = $Map.get_pivot_pos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
