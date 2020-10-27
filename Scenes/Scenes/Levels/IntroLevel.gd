extends Node2D


const PlayerCinematic = preload("res://Scenes/Scenes/Player/PlayerCinematic.tscn")


onready var animationPlayer = $AnimationPlayer
var skip = false

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("fire") and skip == false:
		animationPlayer.play('Skip')
		skip = true
	if Input.is_action_pressed("fire") and skip == true:
		change_scene()
	
func play_cinematic():
	animationPlayer.play("Animate")
	
	
func change_scene():
	get_tree().change_scene("res://Scenes/Scenes/World.tscn")


func _on_Level_Intro_ready() -> void:
	play_cinematic()
	
	
