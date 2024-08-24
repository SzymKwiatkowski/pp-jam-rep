extends Node2D

signal kill_player

@export var sun_speed = 3
@export var pivot_y: int = -30

var start_pos = null
@export var player_camera_reference: PlayerCamera
@export var player_offest: Vector2
var sun_distance = 0.0
var start_y = null

var pivot_offset: Vector2 = Vector2(0, pivot_y)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sun_base_position = player_camera_reference.global_position + player_offest
	var pivot_point = player_camera_reference.global_position + pivot_offset

	sun_distance += delta/sun_speed
	position = pivot_point + (sun_base_position - pivot_point).rotated(sun_distance)

	global_position = position

	if start_y == null:
		start_y = position.y
	else:
		if position.y > start_y:
			kill_player.emit()


func light_contact(target_position):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(global_position, target_position, 1, [self])
	var result = space_state.intersect_ray(query)

	if result == null:
		return false

	if !result.has("collider"):
		return false

	#if result.collider is Player:
		#kill_player.emit()
