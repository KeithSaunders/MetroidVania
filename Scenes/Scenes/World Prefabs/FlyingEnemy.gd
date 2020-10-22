extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"


export (int) var ACCELERATION = 100

var mainInstances = ResourceLoader.MainInstances

onready var	sprite = $Sprite

func _process(delta: float) -> void:
	var player = mainInstances.Player
	if player != null:
		chase_player(delta, player)
		
func chase_player(delta, player):
	var direction = (player.global_position - global_position).normalized()
	motion += direction * ACCELERATION * delta
	motion = motion.clamped(MAX_SPEED)
	sprite.flip_h = global_position < player.global_position
	motion = move_and_slide(motion)
