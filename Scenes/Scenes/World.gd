extends Node

var MainInstances = ResourceLoader.MainInstances

onready var current_level = $Level_00

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	
	# Get access to the player and connect the hit door signal to the 
	# on player hit door function
	MainInstances.Player.connect("hit_door", self, "_on_Player_hit_door")
	
func _on_Player_hit_door(door):
	# Waits to process function
	call_deferred("change_levels", door)


func change_levels(door):
	# Gets the current level position
	var offset = current_level.position
	# Removes from the current tree
	current_level.queue_free()
	
	# Load the new level based on the file path
	var New_Level = load(door.new_level_path)
	# Unpack the level and instance
	var new_level = New_Level.instance()
	# Add the level as a child of World.
	add_child(new_level)
	
	# Gets the new door or door to next level, passes in the door that was 
	# collided with and the resource.tres file
	var newDoor = get_door_with_connection(door, door.connection)
	
	# Finds the exit position by finding the difference between the new door
	# and the old current level
	var exit_position = newDoor.position - offset
	
	# Sets the new level position with the offset of the collided door position
	new_level.position = door.position - exit_position
	
func get_door_with_connection(notDoor, connection):
	# Gets all of the doors currently in the tree, that are in the group door
	var doors = get_tree().get_nodes_in_group("Door")
	# For loop through the doors
	for door in doors:
		# If the .tres file is the same AND is not the door that was collided
		# with, then return that door as the new door
		if door.connection == connection and door != notDoor:
			return door
	return null
