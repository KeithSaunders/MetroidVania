extends KinematicBody2D

onready var stats = $EnemyStats

const EnemyDeathEffect = preload("res://Scenes/Scenes/Effects/EnemyDeathEffect.tscn")
const HealthPickUp = preload("res://Scenes/Scenes/World Prefabs/ItemDrop/HealthDrop.tscn")

onready var playerStats = ResourceLoader.PlayerStats

export (int) var MAX_SPEED = 15


var motion = Vector2.ZERO

# Triggers on hitbox colliding with hurtbox and signaling to the 
# hutbox to take damage or 'hit'
func _on_Hurtbox_hit(damage) -> void:
	stats.health -= damage


func _on_EnemyStats_enemy_died() -> void:
	queue_free()
	SoundFx.play("EnemyDie")
	var chance = dropChance()
	dropHealth(chance)
	Utils.instance_scene_on_main(EnemyDeathEffect, global_position + Vector2(0,-8))
	
func dropHealth(chance):
	var chance_to_drop = rand_range(0, 100)
	if chance_to_drop <= chance:
		Utils.instance_scene_on_main(HealthPickUp, global_position)
	
func dropChance():
	var chance = 0
	if playerStats.health == playerStats.max_health:
		chance = 0
	if playerStats.health < playerStats.max_health:
		chance = (playerStats.health / playerStats.max_health) - 20
		if chance < 0:
			chance = 10
	return chance
