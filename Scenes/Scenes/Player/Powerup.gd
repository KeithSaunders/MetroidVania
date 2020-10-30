extends Area2D

class_name Powerup

var playerStats = ResourceLoader.PlayerStats


func _pickup():
	
	SoundFx.play("Powerup", 1, -15)
	
