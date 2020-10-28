extends Control



func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)





func _on_StartButton_pressed() -> void:
# warning-ignore-all:return_value_discarded
	get_tree().change_scene("res://Scenes/Scenes/Levels/Level_Intro.tscn")

func _on_LoadButton_pressed() -> void:
	SaveandLoader.is_loading = true
	get_tree().change_scene("res://Scenes/Scenes/World.tscn")
	


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
