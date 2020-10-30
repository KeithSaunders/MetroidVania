extends Powerup

onready var animation = $AnimationPlayer

func _pickup():
	._pickup()
	if playerStats.double_jump_unlocked == false:
		playerStats.double_jump_unlocked = true
		animation.play("PickedUp")
	else:
		queue_free()
