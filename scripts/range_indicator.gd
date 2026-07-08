extends Node2D
class_name RangeIndicator

@export var radius: float = 150.0
@export var fill_color: Color = Color(1, 1, 1, 0.12)
@export var outline_color: Color = Color(1, 1, 1, 0.4)


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, fill_color)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 64, outline_color, 2.0)
