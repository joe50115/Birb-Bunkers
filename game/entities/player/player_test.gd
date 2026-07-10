extends CharacterBody2D  #connects the script to the node


# makes speed var for player show up in inspector
@export var speed: float = 200.0

# a physic process is a type of func that calls every physic frame
func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	
	
	# move characters in x,y planes based on input
	if Input.is_action_pressed("move_up"): 
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	
	direction	 = direction.normalized() # makes all directions even diagnolly move equally
	velocity = direction * speed
	
	move_and_slide()

	if Input.is_action_just_pressed("fire"):
		var gun = get_node("gun")
		var aim_direction = (get_global_mouse_position() - gun.global_position).normalized()
		gun.fire(aim_direction)
