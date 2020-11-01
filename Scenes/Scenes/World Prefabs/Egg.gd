extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

onready var animationPlayer = $AnimationPlayer

const harpy = preload("res://Scenes/Scenes/World Prefabs/Harpy.tscn")


func _physics_process(delta: float) -> void:
	apply_gravity(delta)

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
	
func apply_gravity(delta):

	motion.y += delta * 200 
	motion.y = min(MAX_SPEED, motion.y)
	move_and_collide(Vector2(0, motion.y))
