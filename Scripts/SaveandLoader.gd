extends Node

var is_loading = false

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
		# Gets the line and places in the var line_string
		var line_string = save_game.get_line()
		# Check if the line is blank or empty string
		if line_string != "":
			# parse the json string and places in current_line
			var current_line = parse_json(line_string)
			# If the current_line is not null
			if current_line != null:
				# loads the filename node and instances in the newNode
				var newNode = load(current_line["filename"]).instance()
				# Gets the parent node and adds the child
				get_node(current_line["parent"]).add_child(newNode, true)
				# Sets the newNode position
				newNode.position = Vector2(current_line["position_x"], current_line["position_y"])
				# Checks each key and checks the properties for the following properties
				for property in current_line.keys():
					if (property == "filename" 
					or property == "parent"
					or property == "position_x"
					or property == "position_y"):
						continue
					# Sets the property and the current_line[property] key and value
					newNode.set(property, current_line[property])
	# Closes the save game
	save_game.close()
				
