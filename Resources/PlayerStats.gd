extends Resource

class_name PlayerStats

var max_health = 4
var max_missles = 3
var missles = max_missles setget set_missles
var health = max_health setget set_health

signal player_health_update(value)
signal player_died
signal player_missles_update(value)

func set_health(value):
	screenshake(value, .5, 0.5)
	health = clamp(value, 0, max_health)
	emit_signal("player_health_update", health)
	if health == 0:
		emit_signal("player_died")
		
func screenshake(healthValue, shakeStrength, duration):
	if healthValue < health:
		Events.emit_signal("add_screenshake", shakeStrength, duration)

func set_missles(value):
	missles = clamp(value, 0, max_missles)
	emit_signal("player_missles_update", missles)
