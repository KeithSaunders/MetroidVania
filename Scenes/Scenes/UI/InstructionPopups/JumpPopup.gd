extends Control

onready var fadeInCollider = $FadeIn
onready var fadeOutCollider = $FadeOut
onready var animationPlayer = $AnimationPlayer

var fade_in_triggered = false
var fade_out_triggered = false

func _ready():
	if SaveandLoader.event_data.tutorial_popups == true:
		queue_free()


func fade_in():
	if fade_in_triggered == false:
		animationPlayer.play("Appear")
		fade_in_triggered = true

	
func fade_out():
	if fade_out_triggered == false:
		animationPlayer.play("Disappear")
		fade_out_triggered = true

func _on_FadeIn_body_entered(body: Node) -> void:
	fade_in()


func _on_FadeOut_body_exited(body: Node) -> void:
	fade_out()



