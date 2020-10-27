extends Area2D

class_name Powerup

var playerStats = ResourceLoader.PlayerStats
onready var animationPlayer = $AnimationPlayer

func _pickup():
	if playerStats.health < playerStats.max_health:
		playerStats.health += 1
		animationPlayer.play("HealthUp")
	else:
		queue_free()
