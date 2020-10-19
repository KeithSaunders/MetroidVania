extends KinematicBody2D
# Preload Effects
const DustEffect = preload("res://Scenes/Scenes/Effects/DustEffect.tscn")
const PlayerBullet = preload("res://Scenes/Scenes/Player/PlayerBullet.tscn")

# Get Access
onready var sprite = $Sprite
onready var spriteAnimator = $SpriteAnimator
onready var coyoteJumpTimer = $CoyoteJumpTimer
onready var fireBulletTimer = $FireBulletTimer
onready var playergun = $Sprite/PlayerGun
onready var muzzle = $Sprite/PlayerGun/Sprite/Muzzle

# Exportant variables
export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25
export (int) var JUMP_FORCE = 128
export (int) var MAX_SLOPE_ANGLE = 46
export (int) var GRAVITY = 200
export (int) var BULLETSPEED = 250

# Global Variables
var motion = Vector2.ZERO
var snap_vector = Vector2.ZERO
var just_jumped = false


func _physics_process(delta: float) -> void:
	var just_jumped = false
	var input_vector = get_input_vector()
	apply_horizontal_force(input_vector, delta)
	update_snap_vector()
	apply_friction(input_vector)
	jump_check()
	apply_gravity(delta)
	update_animation(input_vector)
	move()
	
	if Input.is_action_pressed("fire") and fireBulletTimer.time_left == 0:
		fire_bullet()
	
func fire_bullet():
	var bullet = Utils.instance_scene_on_main(PlayerBullet, muzzle.global_position)
	
	# Bullet velocity will fire to the right, based on the gun's rotation. Will shoot to the left
	# based on the sprite scale
	bullet.velocity = Vector2.RIGHT.rotated(playergun.rotation) * BULLETSPEED
	
	# Will be -1 or 1 based on sprite scale and will shoot accordingly (based on mouse position)
	# Only impacts the x-axis. Not y-axis
	bullet.velocity.x *= sprite.scale.x
	
	# Access the rotation passed prior (based on the playergun) and applies it to the bullet
	bullet.rotation = bullet.velocity.angle()
	
	# One shot timer to set firerate | allows holding left button down
	fireBulletTimer.start()

func create_dust_effect():
	var dust_position = global_position
	dust_position.x += rand_range(-4, 4)
	Utils.instance_scene_on_main(DustEffect, dust_position)


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
		snap_vector = -get_floor_normal()
	
func jump_check():
	if is_on_floor() or coyoteJumpTimer.time_left > 0:
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
	sprite.scale.x = sign(get_local_mouse_position().x)
	if input_vector.x != 0:
		spriteAnimator.play("Run")
		spriteAnimator.playback_speed = input_vector.x * sprite.scale.x
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
	if was_on_floor and not is_on_floor() and not just_jumped:
		motion.y = 0
		position.y = last_position.y
		coyoteJumpTimer.start()
		
	# Landing
	if was_in_air and is_on_floor():
		motion.x = last_motion.x
		create_dust_effect()
	
	# Prevent Sliding 
	if is_on_floor() and get_floor_velocity().length() == 0 and abs(motion.x) < 1:
		position.x = last_position.x

