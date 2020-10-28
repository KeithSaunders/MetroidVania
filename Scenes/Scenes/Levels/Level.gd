extends Node2D


const WORLD = preload("res://Scenes/Scenes/World.gd")

func _ready():
	var parent = get_parent()
	if parent is WORLD:
		parent.current_level = self

		
func save():
	# Create a save_dictioary that gets the following information
	# 1. File name with get_filename()
	# 2. Gets the parent and path, to add as a child later.
	# 3. Gets the position x
	# 4. Gets the position y
	var save_dictionary = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position_x" : position.x,
		"position_y" : position.y
	}
	print("got here")
	return save_dictionary
