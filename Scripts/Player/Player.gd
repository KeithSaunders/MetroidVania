extends KinematicBody2D

onready var sprite = $Sprite
onready var spriteAnimator = $SpriteAnimator

export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25
export (int) var JUMP_FORCE = 128
export (int) var MAX_SLOPE_ANGLE = 46
export (int) var GRAVITY = 200

var motion = Vector2.ZERO
var snap_vector = Vector2.ZERO
var just_jumped = false


func _physics_process(delta: float) -> void:
	var just_jumped = false
	var input_vector = get_input_vector()
	apply_horizontal_force(input_vector, delta)
	apply_friction(input_vector)
	apply_gravity(delta)
	update_snap_vector()
	jump_check()
	update_animation(input_vector)
	move()

func get_input_vector():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	return input_vector
	
func apply_horizontal_force(input_vector, delta):
	if input_vector.x != 0:
		motion.x += input_vector.x * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x, 0, FRICTION)
		
func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN
	
func jump_check():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			jump(JUMP_FORCE)
			just_jumped = true
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
			
func jump(force):
	motion.y = -force
	snap_vector = Vector2.ZERO
			
func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)
		
func update_animation(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x)
		spriteAnimator.play("Run")
	else:
		spriteAnimator.play("Idle")
	if not is_on_floor():
		spriteAnimator.play("Jump")
		
func move():
	# Variable before motion is called
	var last_position = position
	var last_motion = motion
	var was_on_floor = is_on_floor()
	var was_in_air = not is_on_floor()

	motion = move_and_slide_with_snap(motion, snap_vector * 4, Vector2.UP, true, 4,  deg2rad(MAX_SLOPE_ANGLE))
	
	# Checks on move and slide with snap	
	# Just left the ground
#	if was_on_floor and not is_on_floor() and not just_jumped:
#		motion.y = 0
#		position.y = last_position.y
		
	# Landing
#	if was_in_air and is_on_floor():
#		motion.x = last_motion.x
		
	# Prevent sliding
##		position.x = last_position.x
