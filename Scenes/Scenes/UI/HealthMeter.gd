extends Control

var playerStats = ResourceLoader.PlayerStats

onready var full = $Full

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerStats.connect("player_health_update", self, "_on_player_health_update")
	
func _on_player_health_update(value):
	full.rect_size.x = value * 5 + 1
