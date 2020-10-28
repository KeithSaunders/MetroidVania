extends Camera2D

var mainInstance = ResourceLoader.MainInstances
var shake = 0

onready var timer = $Timer

func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("add_screenshake", self, "_on_Events_add_screenshake")
	mainInstance.WorldCamera = self
	
func queue_free():
	mainInstance.WorldCamera = null
	.queue_free()


# Random offset per frame on horizontal and vertical for the camera
# Default is 0
func _process(_delta: float) -> void:
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
