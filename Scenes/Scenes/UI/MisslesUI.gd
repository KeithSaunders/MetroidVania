extends HBoxContainer

var playerStats = ResourceLoader.PlayerStats

onready var missile_label = $MissileLabel

func _ready() -> void:
	playerStats.connect("player_missiles_update", self, "_on_player_missiles_update")
	
func _on_player_missiles_update(missiles):
	missile_label.text = str(missiles)
