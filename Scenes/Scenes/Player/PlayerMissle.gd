extends "res://Scenes/Scenes/Player/Projectile.gd"

const ENEMY_DEATH_EFFECT = preload("res://Scenes/Scenes/Effects/EnemyDeathEffect.tscn")
const BRICK_LAYER_BIT = 4


# OVERRIDE
func _on_Hitbox_body_entered(body: Node) -> void:
	if body.get_collision_layer_bit(BRICK_LAYER_BIT):
		body.queue_free()
		Utils.instance_scene_on_main(ENEMY_DEATH_EFFECT, body.global_position + Vector2(0,8))
	# Call Parent function
	._on_Hitbox_body_entered(body)
