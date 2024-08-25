class_name Player
extends CharacterBody2D

signal light_contact(position: Vector2)

@export var animation_player: AnimationPlayer
@export var sprite: Sprite2D
@export var speed = 300.0
@export var jump_velocity = -500.0
@export var ascend_gravity = 1100
@export var descend_gravity = 2000

var jump_counter: int = 2
var jump_request: bool = false
@export var jump_request_expiration_time = 1 # seconds

var drop_from_map_threshold = 500

@onready var hp_bar = $HealthBar

var sun_area: Area2D

func _ready():
	hp_bar.setup(100)


func _process(delta):
	# Expire jump request if
	if jump_request:
		jump_request_expiration_time -= delta
		if jump_request_expiration_time < 0:
			jump_request = false
			jump_request_expiration_time = 0.1

	if is_exposed():
		hp_bar.take_damage(0.25)
	
	if hp_bar.value == 0:
		die()


func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += descend_gravity * delta
		else:
			velocity.y += ascend_gravity * delta

	# Handle double jump
	if Input.is_action_just_pressed("jump"):
		jump_request = true
	
	# Consume jump request if we have jumps available
	if jump_request and jump_counter > 0:
		velocity.y = jump_velocity
		jump_counter -= 1
		jump_request = false
		jump_request_expiration_time = 0.1
		animation_player.play("jump")

	# Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		if direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	if global_position.y > drop_from_map_threshold:
		die()
		
	# Is on floor must be after applying movement with move_and_slide()
	if is_on_floor():
		if animation_player.current_animation != "move" and velocity != Vector2.ZERO:
			animation_player.play("move")
		elif animation_player.current_animation != "idle" and velocity == Vector2.ZERO:
			animation_player.play("idle")
		jump_counter = 2

	light_contact.emit(global_position)


func die():
	get_tree().change_scene_to_file("res://ui/scn/game_over_screen.tscn")


func is_exposed():
	if not sun_area:
		return false
	var space_state = get_world_2d().direct_space_state
	#query = PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 100))
	#var collision = get_world_2d().direct_space_state.intersect_ray(query)

	var query = PhysicsRayQueryParameters2D.create(
		global_position, sun_area.global_position)
	query.collide_with_areas = true
	var result = space_state.intersect_ray(query)

	if not result:
		return false
	
	if !result.has("collider"):
		return false
	
	if result.collider == sun_area:
		return true

	return false
