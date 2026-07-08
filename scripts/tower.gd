extends Node2D
class_name Tower

@export var tower_range: float = 150.0
@export var damage: int = 10
@export var fire_rate: float = 1.0
@export var cost: int = 50

@onready var range_indicator: Node2D = get_node_or_null("RangeIndicator")


func _ready() -> void:
	if range_indicator:
		range_indicator.visible = false


func show_range(value: bool) -> void:
	if range_indicator:
		range_indicator.visible = value
