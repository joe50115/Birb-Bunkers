extends CharacterBody2D

# Player movement speed
@export var speed: float = 200.0

# Reference to the player's gun
@onready var gun: Gun = $gun

# Stores the current aim direction and active aiming device
var aim_direction: Vector2 = Vector2.RIGHT
var using_controller_aim: bool = false


# Switch back to mouse aiming when the mouse moves
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		using_controller_aim = false


# Runs movement, aiming, and shooting every physics frame
func _physics_process(_delta: float) -> void:
	handle_movement()
	handle_aim()
	handle_shooting()


# Moves the player using the movement actions
func handle_movement() -> void:
	var direction := Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)

	velocity = direction * speed
	move_and_slide()


# Aims with the controller or mouse and rotates the gun
func handle_aim() -> void:
	var stick_aim := Input.get_vector(
		"aim_left",
		"aim_right",
		"aim_up",
		"aim_down"
	)

	if stick_aim.length() > 0.2:
		using_controller_aim = true
		aim_direction = stick_aim.normalized()

	elif not using_controller_aim:
		var mouse_aim := get_global_mouse_position() - gun.global_position

		if mouse_aim.length() > 1.0:
			aim_direction = mouse_aim.normalized()

	gun.rotation = aim_direction.angle()


# Fires the gun in the current aim direction
func handle_shooting() -> void:
	if Input.is_action_just_pressed("fire"):
		gun.fire(aim_direction)
