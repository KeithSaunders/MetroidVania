extends StaticBody2D

var playerStats = ResourceLoader.PlayerStats
onready var animationPlayer = $AnimationPlayer

func _on_SaveArea_body_entered(body: Node) -> void:
	SoundFx.play("Save", 1, -10)
	animationPlayer.play("Animate")
	restore_stats()
	SaveandLoader.save_game()

func restore_stats():
	playerStats.full_stats()
	
