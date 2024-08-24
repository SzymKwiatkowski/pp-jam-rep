extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_counter: int = 2

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle double jump
	if Input.is_action_just_pressed("jump") and jump_counter > 0:
		velocity.y = JUMP_VELOCITY
		jump_counter -= 1

	# Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if is_on_floor():
		jump_counter = 2
