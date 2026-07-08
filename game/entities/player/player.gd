extends CharacterBody2D
class_name Player

# --- Movement ---
@export var speed: float = 250.0

# --- Resources ---
var resources: int = 100
signal resources_changed(new_amount: int)

# Currently overlapping resource node (set by HarvestArea signals)
var nearby_resource_node: Node = null

@onready var resource_label: Label = $HUD/ResourceLabel
@onready var harvest_prompt: Label = $HUD/HarvestPrompt


func _ready() -> void:
	resource_label.text = "Resources: %d" % resources
	harvest_prompt.visible = false


func _physics_process(_delta: float) -> void:
	var input_dir := Vector2.ZERO

	if Input.is_physical_key_pressed(KEY_A):
		input_dir.x -= 1
	if Input.is_physical_key_pressed(KEY_D):
		input_dir.x += 1
	if Input.is_physical_key_pressed(KEY_W):
		input_dir.y -= 1
	if Input.is_physical_key_pressed(KEY_S):
		input_dir.y += 1

	if input_dir.length() > 0.0:
		input_dir = input_dir.normalized()

	velocity = input_dir * speed
	move_and_slide()


func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed and not event.echo and event.physical_keycode == KEY_E:
		_try_harvest()


func _try_harvest() -> void:
	if nearby_resource_node and nearby_resource_node.has_method("harvest"):
		var gained: int = nearby_resource_node.harvest()
		if gained > 0:
			resources += gained
			resources_changed.emit(resources)
			print("Harvested %d, total: %d" % [gained, resources])





# --- Connect these two from the HarvestArea (Area2D) node's signals ---
func _on_harvest_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("resource_node"):
		nearby_resource_node = area


func _on_harvest_area_area_exited(area: Area2D) -> void:
	if area == nearby_resource_node:
		nearby_resource_node = null
