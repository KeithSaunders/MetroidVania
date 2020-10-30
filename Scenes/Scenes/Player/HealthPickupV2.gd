extends KinematicBody2D

export (int) var ACCELERATION = 100
export (int) var MAX_SPEED = 10

var motion = Vector2.ZERO

func _process(delta: float) -> void:
	gravity(ACCELERATION, delta)

func gravity(acceleration, delta):
	var speed = delta * acceleration
	self.motion += clamp(speed, 0, MAX_SPEED) * Vector2.DOWN
	
