class_name Sun
extends Node2D

signal kill_player

@export var sun_speed = 1.5
var sun_angle = 0.0
var pivot_point = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var sun_new_pos = 0.0
	if Input.is_action_just_pressed("scroll_up"):
		sun_new_pos += sun_speed*5.0*10
	elif Input.is_action_just_pressed("scroll_down"):
		sun_new_pos -= sun_speed*5.0*10
	else:
		sun_new_pos += sun_speed
	
	
	position.x += sun_new_pos
	
	if position.y > 0:
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
