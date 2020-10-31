extends Control

var playerStats = ResourceLoader.PlayerStats

onready var full = $Full
onready var empty = $Empty

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerStats.connect("player_health_update", self, "_on_player_health_update")
	playerStats.connect("player_health_upgrade", self, "_on_player_health_upgrade")
	
func _on_player_health_update(value):
	full.rect_size.x = value * 5 + 1
	
func _on_player_health_upgrade():
	var health_size = playerStats.max_health
	full.rect_size.x = health_size * 5 + 1
	empty.rect_size.x = health_size * 5 + 1
	
	
