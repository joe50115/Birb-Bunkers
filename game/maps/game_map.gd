extends Node2D

# Drag player_test.tscn into this slot.
@export var player_scene: PackedScene

@onready var players: Node2D = $Players

@onready var spawn_points: Array[Marker2D] = [
	$SpawnPoints/Player1Spawn,
	$SpawnPoints/Player2Spawn,
	$SpawnPoints/Player3Spawn,
	$SpawnPoints/Player4Spawn
]


func _ready() -> void:
	# Temporary test:
	# Spawns four players with player IDs 0–3.
	for player_id in range(4):
		spawn_player(player_id)


func spawn_player(player_id: int) -> void:
	if player_scene == null:
		push_error("Player Scene has not been assigned.")
		return

	if player_id < 0 or player_id >= spawn_points.size():
		push_error("Invalid player ID: " + str(player_id))
		return

	var player: Node2D = player_scene.instantiate()

	players.add_child(player)

	player.global_position = spawn_points[player_id].global_position

	# These variables must exist in the player script.
	player.player_id = player_id
	player.device_id = player_id
