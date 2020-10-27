extends Control

onready var fadeInCollider = $FadeIn
onready var fadeOutCollider = $FadeOut
onready var animationPlayer = $AnimationPlayer




var triggered = false



func fade_in():
	if triggered == false:
		animationPlayer.play("Appear")
		triggered = true
		print("triggered")
	
func fade_out():
	animationPlayer.play("Disappear")
	



func _on_FadeIn_body_entered(body: Node) -> void:
	fade_in()


func _on_FadeOut_body_exited(body: Node) -> void:
	fade_out()



