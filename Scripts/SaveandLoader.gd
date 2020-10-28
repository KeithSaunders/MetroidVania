extends Node


func save_game():
	# Create a new File named save_game
	var save_game = File.new()
	# Open the file in the users appdata, additionally begin writing
	save_game.open("user://savegame.save", File.WRITE)
	# Gets all nodes in the persists group into var persistingNodes
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	# Go through all of the nodes in the groups
	for node in persistingNodes:
		# Apply the function (defined in each node) and save
		var node_data = node.save()
		# Converts the save_data to json
		save_game.store_line(to_json(node_data))
	# Close the save_game file
	save_game.close()
		
func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
	
	var persistingNodes = get_tree().get_nodes_in_group("Persists")
	for node in persistingNodes:
		node.queue_free()
		
	save_game.open("user://savegame.save", File.READ)
	while not save_game.eof_reached():
		var line_string = save_game().get_line()
		if line_string != "":
			var current_line = parse_json(line_string)
			if current_line != null:
				var newNode = load(current_line["filename"]).instance()
				get_node(current_line["parent"]).add_child(newNode, true)
				newNode.position = Vector2(current_line["position_x"], current_line["position_y"])
				for property in current_line.keys():
					if (property == "filename" 
					or property == "parent"
					or property == "position_x"
					or property == "position_y"):
						continue
					newNode.set(property, current_line[property])
	save_game.close()
				
