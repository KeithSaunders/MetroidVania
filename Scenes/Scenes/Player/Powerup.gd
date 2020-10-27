extends Area2D

class_name Powerup

var playerStats = ResourceLoader.PlayerStats

func _pickup():
	if playerStats.health < playerStats.max_health:
		playerStats.health += 1
	queue_free()
