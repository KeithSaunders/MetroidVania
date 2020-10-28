extends StaticBody2D


onready var animationPlayer = $AnimationPlayer

func _on_SaveArea_body_entered(body: Node) -> void:
	animationPlayer.play("Animate")
	SaveandLoader.save_game()
	print("Saved")
	print(body)
