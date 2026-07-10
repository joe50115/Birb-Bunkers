extends CharacterBody2D

@export var speed: float = 200.0

@onready var gun: Node2D = $gun

var aim_direction: Vector2 = Vector2.RIGHT
var using_controller_aim: bool = false


func _input(event: InputEvent) -> void:
	# Moving the mouse switches aiming back to the mouse.
	if event is InputEventMouseMotion:
		using_controller_aim = false


func _physics_process(_delta: float) -> void:
	var direction := Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()


	# Read the right-stick direction every frame.
	var stick_aim := Input.get_vector(
		"aim_left",
		"aim_right",
		"aim_up",
		"aim_down"
	)

	if stick_aim.length() > 0.2:
		using_controller_aim = true
		aim_direction = stick_aim.normalized()

	# Use mouse aiming whenever the mouse was the last aiming device.
	elif not using_controller_aim:
		var mouse_aim := get_global_mouse_position() - gun.global_position

		if mouse_aim.length() > 1.0:
			aim_direction = mouse_aim.normalized()


	# Rotate the physical gun toward the aim direction.
	gun.rotation = aim_direction.angle()


	# Fire in the exact direction the gun is facing.
	if Input.is_action_just_pressed("fire"):
		gun.fire(aim_direction)
