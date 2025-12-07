extends SpecialBase

const JUMP_VELOCITY = -400.0
@onready var player : Player = get_tree().root.get_node("/root/Main/Player")
@onready var playerProjectileManager : PlayerProjectileManager = get_tree().root.get_node("/root/Main/PlayerProjectileManager")
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
	playerProjectileManager.ShootSpecialProjectile(self.position, 0)
	playerProjectileManager.ShootSpecialProjectile(self.position, 22.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 45)
	playerProjectileManager.ShootSpecialProjectile(self.position, 67.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 90)
	playerProjectileManager.ShootSpecialProjectile(self.position, 112.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 135)
	playerProjectileManager.ShootSpecialProjectile(self.position, 157.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 180)
	playerProjectileManager.ShootSpecialProjectile(self.position, 202.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 225)
	playerProjectileManager.ShootSpecialProjectile(self.position, 247.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 270)
	playerProjectileManager.ShootSpecialProjectile(self.position, 292.5)
	playerProjectileManager.ShootSpecialProjectile(self.position, 315)
	playerProjectileManager.ShootSpecialProjectile(self.position, 337.5)

	call_deferred("queue_free")

func onExplode() -> void:
	explode()
