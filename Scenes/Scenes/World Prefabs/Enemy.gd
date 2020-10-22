extends KinematicBody2D

onready var stats = $EnemyStats

const EnemyDeathEffect = preload("res://Scenes/Scenes/Effects/EnemyDeathEffect.tscn")

export (int) var MAX_SPEED = 15
var motion = Vector2.ZERO

# Triggers on hitbox colliding with hurtbox and signaling to the 
# hutbox to take damage or 'hit'
func _on_Hurtbox_hit(damage) -> void:
	stats.health -= damage


func _on_EnemyStats_enemy_died() -> void:
	queue_free()
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position)
	
	
