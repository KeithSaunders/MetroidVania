extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_EnemyStats_enemy_died() -> void:
	# Die and spawn acid
	
	# Call Parent function
	._on_EnemyStats_enemy_died()

func _on_VisibilityNotifier2D_screen_entered() -> void:
	# Begin animation for hatching
	
	pass # Replace with function body.
