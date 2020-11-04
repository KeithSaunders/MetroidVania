extends Powerup


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _pickup():
	playerStats.wall_slide_unlocked = true
	._pickup()
