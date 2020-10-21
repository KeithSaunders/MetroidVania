extends Camera2D


var shake = 0

onready var timer = $Timer

func _ready() -> void:
	Events.connect("add_screenshake", self, "_on_Events_add_screenshake")


# Random offset per frame on horizontal and vertical for the camera
# Default is 0
func _process(delta: float) -> void:
	offset_h = rand_range(-shake, shake)
	offset_v = rand_range(-shake, shake)

# Sets shake to the amount to be applied to process and sets the timer
# wait time and starts the timer to later timeout
func screen_shake(amount, duration):
	shake = amount
	timer.wait_time = duration
	timer.start()
	
# Set shake to 0 on timeout
func _on_Timer_timeout() -> void:
	shake = 0

func _on_Events_add_screenshake(amount, duration):
	screen_shake(amount, duration)
