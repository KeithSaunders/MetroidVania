extends Node2D




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	# Requires parent to get local angle relative to the parent model, in
	# this case it is the Player. If you do not store the parent, it will get
	# the local mouse position angle, relative globaly and cause graphical
	# glitches.
	var player = get_parent()
	self.rotation = player.get_local_mouse_position().angle()
	
