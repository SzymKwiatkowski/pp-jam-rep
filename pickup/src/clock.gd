extends Node2D

signal pickup_contact

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	var player = body as Player
	if player == null:
		return
	
	pickup_contact.emit()
