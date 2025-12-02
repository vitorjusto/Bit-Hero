extends SpecialBase

const JUMP_VELOCITY = -400.0
@onready var proj : PackedScene = load("res://Scenes/Player/PlayerProjectile.tscn")
@onready var player : Player = get_tree().root.get_node("/root/Main/Player")
@onready var main : Main = get_tree().root.get_node("/root/Main")
var timer = 100

func _physics_process(delta: float) -> void:
	velocity = speed * delta
	
	if move_and_slide():
		explode()
		return
	
	timer -= delta * 60
	if timer <= 0:
		explode()
		return

func explode():
	ShootProjectile(0)
	ShootProjectile(22.5)
	ShootProjectile(45)
	ShootProjectile(67.5)
	ShootProjectile(90)
	ShootProjectile(112.5)
	ShootProjectile(135)
	ShootProjectile(157.5)
	ShootProjectile(180)
	ShootProjectile(202.5)
	ShootProjectile(225)
	ShootProjectile(247.5)
	ShootProjectile(270)
	ShootProjectile(292.5)
	ShootProjectile(315)
	ShootProjectile(337.5)

	call_deferred("queue_free")
func ShootProjectile(angle : float):
	var instance : PlayerProjectile = proj.instantiate()
	instance.position = self.position
	
	var rad = deg_to_rad(angle)
	instance.SPEED = Vector2(sin(rad) * -50000, cos(rad) * -50000)
	
	main.call_deferred("add_child", instance)

func onExplode() -> void:
	explode()
