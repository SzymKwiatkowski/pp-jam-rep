extends CharacterBody2D


@export var speed = 300.0
@export var jump_velocity = -500.0
@export var ascend_gravity = 1100
@export var descend_gravity = 2000

#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_counter: int = 2


func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		if velocity.y > 0:
			velocity.y += descend_gravity * delta
		else:
			velocity.y += ascend_gravity * delta

	# Handle double jump
	if Input.is_action_just_pressed("jump") and jump_counter > 0:
		velocity.y = jump_velocity
		jump_counter -= 1

	# Handle horizontal movement
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

	if is_on_floor():
		# Is on floor must be after applying movement with move_and_slide()
		jump_counter = 2
