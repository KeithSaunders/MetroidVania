extends HBoxContainer

var playerStats = ResourceLoader.PlayerStats

onready var missile_label = $MissileLabel

func _ready() -> void:
#self.set_visible(false)
	playerStats.connect("player_missiles_update", self, "_on_player_missiles_update")
	playerStats.connect("player_missiles_unlocked", self, "_on_player_missiles_unlocked")
	
func _on_player_missiles_update(missiles):
	missile_label.text = str(missiles)
	
func _on_player_missiles_unlocked(value):
	self.visible = value
