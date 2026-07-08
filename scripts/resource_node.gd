extends Area2D
class_name ResourceNode

@export var max_resources: int = 500
@export var harvest_amount: int = 10
@export var regen_per_second: float = 5.0

var current_resources: float

@onready var label: Label = $Label  # optional child Label to show remaining amount


func _ready() -> void:
	add_to_group("resource_node")
	current_resources = max_resources
	_update_label()


func _process(delta: float) -> void:
	if current_resources < max_resources:
		current_resources = min(max_resources, current_resources + regen_per_second * delta)
		_update_label()


func harvest() -> int:
	var amount: int = min(harvest_amount, int(current_resources))
	current_resources -= amount
	_update_label()
	return amount


func _update_label() -> void:
	if label:
		label.text = str(int(current_resources))
