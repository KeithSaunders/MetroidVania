extends Powerup

export (int) var ACCELERATION = 100
export (int) var MAX_SPEED = 10

onready var animate = $AnimationPlayer

func _process(delta: float) -> void:
	gravity(ACCELERATION, delta)


# Overrides the function
func _pickup():
	if playerStats.health < playerStats.max_health:
		playerStats.health += 1
		SoundFx.play("HealthPickup")
		animate.play("HealthUp")
	else:
		queue_free()

func gravity(acceleration, delta):
	var speed = delta * acceleration
	self.position += clamp(speed, 0, MAX_SPEED) * Vector2.DOWN
	
