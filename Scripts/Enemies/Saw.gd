extends CharacterBody2D

@export var SPEED = Vector2(10000, 10000)
@export var isImortal : bool

func _ready() -> void:
	if isImortal:
		var col : CollisionShape2D = get_node("Hurtbox/CollisionShape2D2")
		col.disabled = true

func _physics_process(delta: float) -> void:
	velocity = SPEED * delta

	move_and_slide()
	
	if is_on_floor() or is_on_ceiling():
		SPEED *= Vector2(1, -1)
	if is_on_wall():
		SPEED *= Vector2(-1, 1)
