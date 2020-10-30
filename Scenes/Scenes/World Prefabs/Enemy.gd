extends KinematicBody2D

onready var stats = $EnemyStats

const EnemyDeathEffect = preload("res://Scenes/Scenes/Effects/EnemyDeathEffect.tscn")
const HealthPickUp = preload("res://Scenes/Scenes/World Prefabs/ItemDrop/HealthDrop.tscn")

export (int) var MAX_SPEED = 15
export (int) var DROP_CHANCE = 100

var motion = Vector2.ZERO

# Triggers on hitbox colliding with hurtbox and signaling to the 
# hutbox to take damage or 'hit'
func _on_Hurtbox_hit(damage) -> void:
	stats.health -= damage


func _on_EnemyStats_enemy_died() -> void:
	queue_free()
	SoundFx.play("EnemyDie")
	dropHealth(DROP_CHANCE)
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position + Vector2(0,-5))
	
func dropHealth(chance):
	var chance_to_drop = rand_range(0, 100)
	if chance_to_drop <= chance:
		Utils.instance_scene_on_main(HealthPickUp, global_position)
	
	
	
