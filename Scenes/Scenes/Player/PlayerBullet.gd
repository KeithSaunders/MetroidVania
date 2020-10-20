extends "res://Scenes/Scenes/Player/Projectile.gd"


# Removes the physics process from the bullet. It is renables on the bullet being
# fired in the animation player. Prevents the bullet from moving before the muzzle
# flare is called.
func _ready() -> void:
	set_process(false)

# Destroy on wall collision
func _on_Hitbox_body_entered(body: Node) -> void:
	queue_free()
