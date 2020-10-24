extends Node2D

const WORLD = preload("res://Scenes/Scenes/World.gd")

func _ready() -> void:
	var parent = get_parent()
	if parent is WORLD:
		parent.current_level = self
