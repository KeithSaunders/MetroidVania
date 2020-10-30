extends ItemDrop

export (int) var ACCELERATION = 100
export (int) var MAX_SPEED = 10
var motion = Vector2.ZERO

func _process(delta: float) -> void:
	gravity(ACCELERATION, delta)

func _on_ItemDropPickupArea_area_entered(area: Area2D) -> void:
	if playerStats.health < playerStats.max_health:
		playerStats.health += 1
		SoundFx.play("HealthPickup")
#		animate.play("HealthUp")
	queue_free()


func gravity(acceleration, delta):
	var speed = delta * acceleration
	speed = clamp(speed, 0, MAX_SPEED) * Vector2.DOWN
	move_and_collide(speed)
	
