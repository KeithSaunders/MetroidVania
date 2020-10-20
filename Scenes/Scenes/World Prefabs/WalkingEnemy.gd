extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

# Enumerator to set up a dictionary. Going to be established as the left and
# right direction
enum DIRECTION {
	LEFT = -1, 
	RIGHT = 1
	}

# REMEMBER! Extends the max_speed, this will export the direction as well.
export(DIRECTION) var WALKING_DIRECTION = DIRECTION.RIGHT

var state

onready var sprite = $Sprite
onready var floorLeft = $FloorLeft
onready var floorRight = $FloorRight
onready var wallLeft = $WallLeft
onready var wallRight = $WallRight

func _ready() -> void:
	state = WALKING_DIRECTION
	
func _physics_process(delta: float) -> void:
	match state:
		DIRECTION.RIGHT:
			motion.x = MAX_SPEED
			
			# Check if Right raytrace is off of the floor OR if the right
			# wall ray trace is colliding. If colliding, turn left
			if not floorRight.is_colliding() or wallRight.is_colliding():
				state = DIRECTION.LEFT
			
		DIRECTION.LEFT:
			motion.x = -MAX_SPEED
			if not floorLeft.is_colliding() or wallLeft.is_colliding():
				state = DIRECTION.RIGHT
	
	sprite.scale.x = sign(motion.x)
	motion = move_and_slide_with_snap(motion, Vector2.DOWN * 4, Vector2.UP, true, 4, deg2rad(46))
