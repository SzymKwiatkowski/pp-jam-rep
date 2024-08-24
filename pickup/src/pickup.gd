extends Node2D


@export var item: Item


# Called when the node enters the scene tree for the first time.
func _ready():
	var item_instance = item.Scene.instantiate()
	add_child(item_instance)
	item_instance.pickup_contact.connect(_on_player_contact)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_contact():
	# TODO: add player actions
	pass
