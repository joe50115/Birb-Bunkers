extends CharacterBody2D

# Player movement speed
@export var speed: float = 200.0

# Reference to the player's gun
@onready var gun: Gun = $gun

<<<<<<< HEAD
var player_id: int = 0
var device_id: int = -1
var character_id: int = 0
=======
@export var speed: float = 200.0  #player speed

@onready var gun: Node2D = $gun  #

>>>>>>> 1894ab828ea66abd6ab672e274b7418c89a11e1b

# Stores the current aim direction and active aiming device
var aim_direction: Vector2 = Vector2.RIGHT
var using_controller_aim: bool = false

var harvestable_in_range: Array = []
var resources: Dictionary = {"wood": 0}


func _ready() -> void:
	var harvest_area = get_node("HarvestArea")
	harvest_area.area_entered.connect(_on_harvest_area_entered)
	harvest_area.area_exited.connect(_on_harvest_area_exited)


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

	# Fire in the exact direction the gun is facing.
	if Input.is_action_pressed("fire"):

		gun.fire(aim_direction)
		
	
	

	# Harvest whatever's closest in range.
	if Input.is_action_just_pressed("harvest") and not harvestable_in_range.is_empty():
		var target = harvestable_in_range[0]
		var data: Dictionary = target.harvest()
		resources[data["type"]] = resources.get(data["type"], 0) + data["amount"]
		harvestable_in_range.erase(target)
		update_resource_label()

func _on_harvest_area_entered(area: Area2D) -> void:
	if area.has_method("harvest"):
		harvestable_in_range.append(area)
		get_node("HUD").get_node("HarvestPrompt").visible = true

func _on_harvest_area_exited(area: Area2D) -> void:
	harvestable_in_range.erase(area)
	if harvestable_in_range.is_empty():
		get_node("HUD").get_node("HarvestPrompt").visible = false

func update_resource_label() -> void:
	get_node("HUD").get_node("ResourceLabel").text = "Wood: %d" % resources["wood"]
