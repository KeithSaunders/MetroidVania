extends HBoxContainer

var playerStats = ResourceLoader.PlayerStats

onready var missile_label = $MissileLabel

func _ready() -> void:
	playerStats.connect("player_missles_update", self, "_on_player_missles_update")
	
func _on_player_missles_update(missles):
	missile_label.text = str(missles)
