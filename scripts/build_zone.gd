extends Area2D
class_name BuildZone

# Attach this to an Area2D with one rectangular CollisionShape2D child.
# Marks the region where this player is allowed to place towers
# (e.g. "behind their base").

func is_point_inside(point: Vector2) -> bool:
	for child in get_children():
		if child is CollisionShape2D and child.shape is RectangleShape2D:
			var extents: Vector2 = child.shape.size / 2.0
			var local_point: Vector2 = to_local(point) - child.position
			return abs(local_point.x) <= extents.x and abs(local_point.y) <= extents.y
	return false
