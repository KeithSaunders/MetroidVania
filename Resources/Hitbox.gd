extends Area2D


export (int) var damage = 1

# When a hurt box ENTERS the hitbox area, emit hit signal to the hitbox 
# to trigger a 'hit' and take damage
func _on_Hitbox_area_entered(hurtbox: Area2D) -> void:
	hurtbox.emit_signal("hit", damage)
