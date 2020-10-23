extends "res://Scenes/Scenes/Player/Projectile.gd"


const BRICK_LAYER_BIT = 4

# OVERRIDE
func _on_Hitbox_body_entered(body: Node) -> void:
	if body.get_collision_layer_bit(BRICK_LAYER_BIT):
		body.queue_free()
		
	# Call Parent function
	._on_Hitbox_body_entered(body)
