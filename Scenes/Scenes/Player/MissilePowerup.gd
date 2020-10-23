extends Powerup

export (int) var BOUNCESPEED = 3

onready var bounceTime = $BounceTimer

enum DIRECTION{
	UP = -1,
	DOWN = 1
}

func _ready():
	bounceTime.start()

func _physics_process(delta: float) -> void:
	bounce(delta)


func _pickup():
	if playerStats.missiles_unlocked == false:
		playerStats.missiles_unlocked = true
		queue_free()
	if playerStats.missiles_unlocked == true:
		playerStats.missiles += 1
		queue_free()
		
func bounce(delta):
	var time = bounceTime.get_time_left()
	if time > 0.5:
		global_position +=  Vector2(0, BOUNCESPEED * delta * DIRECTION.UP)
	if time < 0.5:
		global_position += Vector2(0, BOUNCESPEED * delta * DIRECTION.DOWN)
	
	
