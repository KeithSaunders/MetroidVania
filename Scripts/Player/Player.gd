extends KinematicBody2D
# Preload Effects
const DustEffect = preload("res://Scenes/Scenes/Effects/DustEffect.tscn")
const PlayerBullet = preload("res://Scenes/Scenes/Player/PlayerBullet.tscn")
const JumpEffect = preload("res://Scenes/Scenes/Effects/JumpEffect.tscn")
const WallDustEffect = preload("res://Scenes/Scenes/Effects/WallDustEffect.tscn")
const PlayerMissile = preload("res://Scenes/Scenes/Player/PlayerMissle.tscn")

# Created Resources (in ResourceLoader script
var playerStats = ResourceLoader.PlayerStats
var mainInstances = ResourceLoader.MainInstances

# Get Access
onready var sprite = $Sprite
onready var spriteAnimator = $SpriteAnimator
onready var coyoteJumpTimer = $CoyoteJumpTimer
onready var fireBulletTimer = $FireBulletTimer
onready var playergun = $Sprite/PlayerGun
onready var muzzle = $Sprite/PlayerGun/Sprite/Muzzle
onready var blinkAnimator = $BlinkAnimator

# Export variables
export (int) var ACCELERATION = 512
export (int) var MAX_SPEED = 64
export (float) var FRICTION = 0.25
export (int) var JUMP_FORCE = 128
export (int) var MAX_SLOPE_ANGLE = 46
export (int) var GRAVITY = 200
export (int) var BULLETSPEED = 250
export (int) var WALLSLIDESPEED = 48
export (int) var MAXWALLSLIDESPEED = 128
export (int) var MISSILESPEED = 150

enum {
	MOVE,
	WALL_SLIDE
}

# Global Variables
var state = MOVE
var motion = Vector2.ZERO
var snap_vector = Vector2.ZERO
var just_jumped = false
var double_jump = true
var invicible = false setget set_invicible

func _ready():
	playerStats.connect("player_died", self, "_on_died")
	# Gives our resource a reference when the player exists
	mainInstances.Player = self
	
func _exit_tree() -> void:
	# Removes the reference to our player when the player exits the tree
	mainInstances.Player = null

func _physics_process(delta: float) -> void:

	# warning-ignore:shadowed_variable
	# warning-ignore:unused_variable
	# warning-ignore:shadowed_variable
	var just_jumped = false
	
	match state:
		MOVE:
			# warning-ignore:shadowed_variable
			var input_vector = get_input_vector()
			apply_horizontal_force(input_vector, delta)
			apply_friction(input_vector)
			update_snap_vector()
			jump_check()
			apply_gravity(delta)
			update_animation(input_vector)
			move()
			wall_slide_check()
		WALL_SLIDE:
			spriteAnimator.play("Animate_Wall_Slide")
			var wall_axis = get_wall_axis()
			if wall_axis != 0:
				sprite.scale.x = wall_axis
			wall_slide_jump_check(wall_axis)
			wall_slide_drop(delta)
			move()
			wall_detach(delta, wall_axis)
	
	if Input.is_action_pressed("fire") and fireBulletTimer.time_left == 0:
		fire_bullet()
		
	if Input.is_action_pressed("fire_missile") and fireBulletTimer.time_left == 0:
		fire_missile()
	
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

func fire_missile():
	if playerStats.missiles > 0:
		var missile = Utils.instance_scene_on_main(PlayerMissile, muzzle.global_position)
		missile.velocity = Vector2.RIGHT.rotated(playergun.rotation) * MISSILESPEED
		missile.velocity.x *= sprite.scale.x
		motion -= missile.velocity * 0.25
		missile.rotation = missile.velocity.angle()
		fireBulletTimer.start()
		playerStats.missiles -= 1

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
			
		# Double Jump
		if Input.is_action_just_pressed("ui_up") and double_jump == true:
			jump(JUMP_FORCE * 0.75)
			double_jump = false
			
func jump(force):
	Utils.instance_scene_on_main(JumpEffect, global_position)
	motion.y = -force
	snap_vector = Vector2.ZERO
			
func apply_gravity(delta):
	if not is_on_floor():
		motion.y += GRAVITY * delta
		motion.y = min(motion.y, JUMP_FORCE)
		
func update_animation(input_vector):
	var facing = sign(get_local_mouse_position().x)
	if facing != 0:
		sprite.scale.x = facing
	
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
		position.y = last_position.y
		motion.y = 0
		coyoteJumpTimer.start()
		
	# Landing
	if was_in_air and is_on_floor():
		motion.x = last_motion.x
		create_dust_effect()
		Utils.instance_scene_on_main(JumpEffect, global_position)
		double_jump = true
	
	# Prevent Sliding 
	if is_on_floor() and get_floor_velocity().length() == 0 and abs(motion.x) < 1:
		position.x = last_position.x

func _on_Hurtbox_hit(damage) -> void:
	if not invicible:
		playerStats.health -= damage
		blinkAnimator.play("Blink")

func _on_died():
	queue_free()

func set_invicible(value):
	invicible = value
	
func wall_slide_check():
	if not is_on_floor() and is_on_wall():
		state = WALL_SLIDE
		create_dust_effect()
		double_jump = true

func get_wall_axis():
	# True/False if collides
	var is_right_wall = test_move(transform, Vector2.RIGHT)
	var is_left_wall = test_move(transform, Vector2.LEFT)
	
	return int(is_left_wall) - int(is_right_wall)
	
func wall_slide_jump_check(wall_axis):
	if Input.is_action_just_pressed("ui_up"):
		motion.x = wall_axis * MAX_SPEED
		motion.y = -JUMP_FORCE/1.25
		var dust_position = global_position + Vector2(wall_axis * 4,-2)
		var dust = Utils.instance_scene_on_main(WallDustEffect, dust_position)
		dust.scale.x = wall_axis
		state = MOVE
		

func wall_slide_drop(delta):
	var max_slide_speed = WALLSLIDESPEED
	if Input.is_action_pressed("ui_down"):
		max_slide_speed = MAXWALLSLIDESPEED
	motion.y = min(motion.y + GRAVITY * delta, max_slide_speed)

func wall_detach(delta, wall_axis):
	if wall_axis == 0 or is_on_floor():
		state = MOVE
		
	if Input.is_action_just_pressed("ui_right"):
		motion.x = ACCELERATION * delta
		state = MOVE
		
	if Input.is_action_just_pressed("ui_left"):
		motion.x = -ACCELERATION * delta
		state = MOVE
