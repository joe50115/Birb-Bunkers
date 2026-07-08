extends Node2D
class_name BuildingSystem

# Attach this as a child of the Player node.
@export var tower_scene: PackedScene
@export var build_zone_path: NodePath  # points to this player's BuildZone Area2D

var placing: bool = false
var ghost: Node2D = null
var player: Node = null
var build_zone: BuildZone = null


func _ready() -> void:
	player = get_parent()
	if build_zone_path != NodePath(""):
		build_zone = get_node_or_null(build_zone_path)


func _unhandled_key_input(event: InputEvent) -> void:
	if not (event.pressed and not event.echo):
		return
	if event.physical_keycode == KEY_1:
		_start_placing()
	elif event.physical_keycode == KEY_ESCAPE:
		_cancel_placing()


func _start_placing() -> void:
	if placing or not tower_scene:
		return
	placing = true
	ghost = tower_scene.instantiate()
	ghost.modulate = Color(1, 1, 1, 0.5)
	get_tree().current_scene.add_child(ghost)


func _cancel_placing() -> void:
	placing = false
	if ghost:
		ghost.queue_free()
		ghost = null


func _process(_delta: float) -> void:
	if placing and ghost:
		ghost.global_position = get_global_mouse_position()
		var valid := build_zone == null or build_zone.is_point_inside(ghost.global_position)
		ghost.modulate = Color(1, 1, 1, 0.5) if valid else Color(1, 0.3, 0.3, 0.5)


func _unhandled_input(event: InputEvent) -> void:
	if not placing or not (event is InputEventMouseButton) or not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_LEFT:
		_confirm_placement()
	elif event.button_index == MOUSE_BUTTON_RIGHT:
		_cancel_placing()


func _confirm_placement() -> void:
	var pos: Vector2 = get_global_mouse_position()

	if build_zone and not build_zone.is_point_inside(pos):
		print("Can't build there - outside your base zone")
		return

	var cost: int = 50
	if ghost and "cost" in ghost:
		cost = ghost.cost

	if player and player.has_method("spend") and player.spend(cost):
		var placed: Node2D = tower_scene.instantiate()
		placed.global_position = pos
		get_tree().current_scene.add_child(placed)
		_cancel_placing()
	else:
		print("Not enough resources")
