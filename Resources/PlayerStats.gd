extends Resource

class_name PlayerStats

var max_health = 4
var max_missiles = 3
var missiles = max_missiles setget set_missiles
var health = max_health setget set_health

signal player_health_update(value)
signal player_died
signal player_missiles_update(value)

func set_health(value):
	screenshake(value, .5, 0.5)
	health = clamp(value, 0, max_health)
	emit_signal("player_health_update", health)
	if health == 0:
		emit_signal("player_died")
		
func screenshake(healthValue, shakeStrength, duration):
	if healthValue < health:
		Events.emit_signal("add_screenshake", shakeStrength, duration)

func set_missiles(value):
	missiles = clamp(value, 0, max_missiles)
	emit_signal("player_missiles_update", missiles)
