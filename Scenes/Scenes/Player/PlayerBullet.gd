extends "res://Scenes/Scenes/Player/Projectile.gd"


# Removes the physics process from the bullet. It is renables on the bullet being
# fired in the animation player. Prevents the bullet from moving before the muzzle
# flare is called.
func _ready() -> void:
	SoundFx.play("Bullet", rand_range(0.8, 1.0))
	set_process(false)

