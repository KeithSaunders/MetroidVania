extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

# Enumerator to set up a dictionary. Going to be established as the left and
# right direction
enum DIRECTION {
	LEFT = -1, 
	RIGHT = 1
	}

# REMEMBER! Extends the max_speed, this will export the direction as well.
export(DIRECTION) var WALKING_DIRECTION
