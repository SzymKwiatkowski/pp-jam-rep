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

@onready var ray_cast = $Raycast

func _process(delta):
	# Expire jump request if
	if jump_request:
		jump_request_expiration_time -= delta
		if jump_request_expiration_time < 0:
			jump_request = false
			jump_request_expiration_time = 0.1


func _physics_process(delta):
	# Fix camera vertically
	
	
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

	# Is on floor must be after applying movement with move_and_slide()
	if is_on_floor():
		if animation_player.current_animation != "move" and velocity != Vector2.ZERO:
			animation_player.play("move")
		elif animation_player.current_animation != "idle" and velocity == Vector2.ZERO:
			animation_player.play("idle")
		jump_counter = 2

	#print("Player pos", global_position, global_transform.origin)
	light_contact.emit(global_position)
	pass

func die():
	print("Trying to die")
	pass
