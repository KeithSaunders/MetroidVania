extends Node2D


const PlayerCinematic = preload("res://Scenes/Scenes/Player/PlayerCinematic.tscn")


onready var animationPlayer = $AnimationPlayer


func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	

	
func play_cinematic():
	animationPlayer.play("Animate")
	
	
func change_scene():
	get_tree().change_scene("res://Scenes/Scenes/World.tscn")


func _on_Level_Intro_ready() -> void:
	play_cinematic()
