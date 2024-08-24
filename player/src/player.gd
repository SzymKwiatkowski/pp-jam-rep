extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -500.0
@export var ascend_gravity = 1100
@export var descend_gravity = 2000

var jump_counter: int = 2
var jump_request: bool = false
@export var jump_request_expiration_time = 1 # seconds


func _process(delta):
	# Expire jump request if
	if jump_request:
		jump_request_expiration_time -= delta
		if jump_request_expiration_time < 0:
			jump_request = false
			jump_request_expiration_time = 0.1


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

	# Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	# Is on floor must be after applying movement with move_and_slide()
	if is_on_floor():
		jump_counter = 2
