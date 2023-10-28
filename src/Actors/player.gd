extends Actor

# _physics_process is function if we defined on node
# godot engine will be call every frame in your game
# this is generaly where set player movement
func _physics_process(_delta):
	
	var interrup_jump := Input.is_action_just_released("jump") and velocity.y < 0.0
	
	velocity = calculate_move_velocity(
		velocity,
		get_direction(),
		speed,
		interrup_jump
	)
	move_and_slide()

func get_direction()-> Vector2:
	# get_action_strength -> if key pres return 1 else return 0
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	

## calculate_move_velocity is function for check movement player 
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	interrup_jump: bool
) -> Vector2:
	
	var new_velocity: = linear_velocity
	# check movement direction left or right
	new_velocity.x = speed.x * direction.x
	# for gravity
	# get_physics_process_delta_time -> function for get delta time
	new_velocity.y += grafity * get_physics_process_delta_time()
	if direction.y == -1.0: # if jump 
		new_velocity.y = speed.y * direction.y
	if interrup_jump:
		new_velocity.y = 0.0
	return new_velocity
	
	
