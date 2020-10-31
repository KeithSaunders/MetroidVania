extends Powerup



func _pickup():
	playerStats.player_upgrade_health(1)
	print("Pickup Health Upgrade")
	queue_free()
