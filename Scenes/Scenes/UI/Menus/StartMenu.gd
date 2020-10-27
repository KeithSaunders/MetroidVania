extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Scenes/Scenes/Levels/Level_Intro.tscn")


func _on_LoadButton_pressed() -> void:
	pass # Replace with function body.


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
