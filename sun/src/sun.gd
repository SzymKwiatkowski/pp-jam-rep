extends Node2D

signal kill_player

@export var sun_speed = 50
@export var pivot_x: int = 440
@export var pivot_y: int = 320

var start_pos = null

@onready var pivot_point: Vector2 = Vector2(pivot_x, pivot_y)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_pos == null:
		start_pos = global_position

	var distance = delta/sun_speed
	position = global_position
	position = pivot_point + (position - pivot_point).rotated(distance)

	global_position = position


func light_contact(target_position):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, target_position, 1, [self])
	var result = space_state.intersect_ray(query)

	if result == null:
		return false

	if !result.has("collider"):
		return false

	if result.collider is Player:
		kill_player.emit()
