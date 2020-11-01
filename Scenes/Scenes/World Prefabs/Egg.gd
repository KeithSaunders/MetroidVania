extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

onready var animationPlayer = $AnimationPlayer

const harpy = preload("res://Scenes/Scenes/World Prefabs/Harpy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_EnemyStats_enemy_died() -> void:
	# Die and spawn acid
	
	# Call Parent function
	._on_EnemyStats_enemy_died()

func spawn_from_hatch():
	Utils.instance_scene_on_main(harpy, global_position)
	


func _on_VisibilityNotifier2D_screen_entered() -> void:
	# Begin animation for hatching
	animationPlayer.play("Shake")

func hatch():
	animationPlayer.play("Hatch")
