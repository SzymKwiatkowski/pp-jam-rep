class_name Sun
extends Node2D

@export var sun_speed = 10000
@export var pivot_x: int = 100
@export var pivot_y: int = 100

@onready var pivot_point: Vector2 = Vector2(pivot_x, pivot_y)
@onready var light_node = $Light


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = delta/sun_speed
	position = global_position
	position = pivot_point + (position - pivot_point).rotated(distance)
	global_position = position
	
	Player.light_contact(global_position)
	
