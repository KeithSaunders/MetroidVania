extends Resource

class_name PlayerStats


# Health Player Stats
var max_health = 4 setget set_max_health
var health = max_health setget set_health

# Missle Player Stats
var max_missiles = 3
var missiles = max_missiles setget set_missiles

# Player Upgrades
var double_jump_unlocked = false setget set_double_jump_unlocked
var wall_slide_unlocked = false setget set_wall_slide_unlocked
var missiles_unlocked = false setget set_missiles_unlocked

# Playerstat Signal to update
signal player_died
signal player_health_update(value)
signal player_missiles_update(value)
signal player_missiles_unlocked(value)
signal player_double_jump_unlocked(value)

signal player_health_upgrade()

# warning-ignore:unused_signal
signal wall_slide_unlocked(value)


func set_health(value):
	screenshake(value, .5, 0.5)
	health = clamp(value, 0, max_health)
	emit_signal("player_health_update", health)
	if health == 0:
		emit_signal("player_died")
		
func set_max_health(value):
	max_health = max_health + value
	print("Max Heatlh is:")
	print(max_health)
		
func player_upgrade_health(value):
	print("Player Upgrade Health in PlayerStats")
	set_max_health(value)
	emit_signal("player_health_upgrade")
	set_health(max_health)
	

func full_stats():
	self.health = max_health
	if missiles_unlocked == true:
		missiles = max_missiles
		
func screenshake(healthValue, shakeStrength, duration):
	if healthValue < health:
		Events.emit_signal("add_screenshake", shakeStrength, duration)

func set_missiles(value):
	missiles = clamp(value, 0, max_missiles)
	emit_signal("player_missiles_update", missiles)

func set_missiles_unlocked(value):
	missiles_unlocked = value
	SaveandLoader.custom_data.missiles_unlocked = value
	emit_signal("player_missiles_unlocked", missiles_unlocked)
	
func set_double_jump_unlocked(value):
	double_jump_unlocked = value
	emit_signal("player_double_jump_unlocked", double_jump_unlocked)

# warning-ignore:unused_argument
func set_wall_slide_unlocked(value):
	pass
