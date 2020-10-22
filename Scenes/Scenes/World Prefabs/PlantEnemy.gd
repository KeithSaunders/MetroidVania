extends "res://Scenes/Scenes/World Prefabs/Enemy.gd"

const EnemyBullet = preload("res://Scenes/Scenes/World Prefabs/EnemyBullet.tscn")

export (int) var BULLETSPEED = 30
export (float) var SPREAD = 15

onready var fireDirection = $FireDirection
onready var bulletSpawnPoint = $BulletSpawnPoint

func fire_bullet():
	var bullet = Utils.instance_scene_on_main(EnemyBullet, bulletSpawnPoint.global_position)
	var velocity = (fireDirection.global_position - global_position).normalized() * BULLETSPEED
	velocity = velocity.rotated(deg2rad(rand_range(-SPREAD, SPREAD)))
	bullet.velocity = velocity
