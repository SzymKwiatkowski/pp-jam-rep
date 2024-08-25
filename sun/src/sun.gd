extends Node2D

signal kill_player

@export var sun_speed = 3.0
var sun_angle = 0.0
var pivot_point = Vector2.ZERO



# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	var sun_angle_new = 0.0
	if Input.is_action_just_pressed("scroll_up"):
		sun_angle_new += sun_speed*5.0
	elif Input.is_action_just_pressed("scroll_down"):
		sun_angle_new -= sun_speed*5.0
	else:
		sun_angle_new += sun_speed
	
	sun_angle += deg_to_rad(sun_angle_new*delta)
	var desired_position = pivot_point + (position-pivot_point).rotated(deg_to_rad(sun_angle_new*delta))
	desired_position.y = desired_position.y.MAX()
	position = desired_position
	
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
