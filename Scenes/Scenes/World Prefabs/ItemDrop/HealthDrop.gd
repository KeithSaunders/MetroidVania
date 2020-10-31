extends ItemDrop

export (int) var ACCELERATION = 100
export (int) var MAX_SPEED = 10
var motion = Vector2.ZERO

onready var wallRight = $WallRight
onready var wallLeft = $WallLeft
onready var floorCheck = $FloorCheck

func _process(delta: float) -> void:
	gravity(ACCELERATION, delta)
	check_walls()

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
	
func check_walls():
	if wallLeft.is_colliding() and wallRight.is_colliding():
		position.y = -10
	if wallRight.is_colliding():
		position.x += -5
	if wallLeft.is_colliding():
		position.x += 5
	if floorCheck.is_colliding():
		position.y = -8
