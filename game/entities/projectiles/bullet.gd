extends Area2D

@export var speed: float = 500.0

# makes sure the bullet comes from the gun
var direction: Vector2 = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	var timer = get_node("Timer")
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
func _on_body_entered(body: Node2D) -> void:
	# Later: check if body is an enemy, deal damage here
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
