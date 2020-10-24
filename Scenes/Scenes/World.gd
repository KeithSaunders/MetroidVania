extends Node

var MainInstances = ResourceLoader.MainInstances

onready var current_level = $Level_00

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	MainInstances.Player.connect("hit_door", self, "_on_Player_hit_door")
	
func _on_Player_hit_door(door):
	# Waits to process function
	call_deferred("change_levels", door)


func change_levels(door):
	var offset = current_level.position
	current_level.queue_free()
	
	var New_Level = load(door.new_level_path)
	var new_level = New_Level.instance()
	add_child(new_level)
	
	var newDoor = get_door_with_connection(door, door.connection)
	
	var exit_position = newDoor.position - offset
	
	new_level.position = door.position - exit_position
	
func get_door_with_connection(notDoor, connection):
	var doors = get_tree().get_nodes_in_group("Door")
	for door in doors:
		if door.connection == connection and door != notDoor:
			return door
	return null
