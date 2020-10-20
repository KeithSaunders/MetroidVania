extends KinematicBody2D

export (int) var MAX_SPEED = 15
var motion = Vector2.ZERO

# Triggers on hitbox colliding with hurtbox and signaling to the 
# hutbox to take damage or 'hit'
func _on_Hurtbox_hit(damage) -> void:
	queue_free()
