extends Area2D

# Resource that both doors will share or a connection between the doors
export (Resource) var connection = null

# The level path that the door points too
export (String, FILE, "*.tscn") var new_level_path = ""

# Variable to make the door active
var active = true

# Function to call when the player hits the door
func _on_Door_body_entered(Player: Node) -> void:
	# Emit the hit_door signal. Also passes the Door as a paramaeter
	Player.emit_signal("hit_door", self)
	
	# Turns the door off after emitted to prevent bugs
	active = false
