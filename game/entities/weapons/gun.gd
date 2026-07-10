extends Node2D

# makes it easier to attach bllets to the gun in inspector
@export var bullet_scene: PackedScene

#flag to prevent firing before cooldown finishes limits rate of fire
var can_fire: bool = true  


func _ready() -> void:
	var cooldown_timer = get_node("FireCoolDown") #
	cooldown_timer.timeout.connect(_on_cooldown_finished)

func fire(direction: Vector2) -> void:
	print("fire() called, can_fire = ", can_fire)
	if not can_fire:
		return
	print("Spawning bullet")

	
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = get_node("muzzle").global_position
	bullet.direction = direction.normalized()
	
	can_fire = false
	get_node("FireCoolDown").start()

func _on_cooldown_finished() -> void:
	can_fire = true
