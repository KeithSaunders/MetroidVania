extends Powerup


func _pickup():
	if playerStats.double_jump_unlocked == false:
		playerStats.double_jump_unlocked = true
		queue_free()
	else:
		queue_free()
