extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

onready var leftWallCheck = $LeftWallCheck
onready var rightWallCheck = $RightWallCheck

var mainInstance = ResourceLoader.MainInstances

const Bullet = preload("res://Scenes/Scenes/World Prefabs/EnemyBullet.tscn")

export (int) var ACCELERATION = 70

signal died



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	chase_player(delta)
	
func chase_player(delta):
	var player = mainInstance.Player
	if player != null:
		var direction_to_move = sign(player.global_position.x - global_position.x)
		motion.x += ACCELERATION * delta * direction_to_move
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		global_position += motion * delta
		rotation_degrees = lerp(rotation_degrees, (motion.x / MAX_SPEED) * 10, 0.3)
		
		if rightWallCheck.is_colliding() and motion.x > 0:
			motion.x *= -0.5
			
		if leftWallCheck.is_colliding() and motion.x < 0:
			motion.x *= -0.5

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(Bullet, global_position)
	var velocity = Vector2.DOWN * 50
	velocity = velocity.rotated(deg2rad(rand_range(-30,30)))
	bullet.velocity = velocity
	
func _on_Timer_timeout() -> void:
	fire_bullet()
