extends Node2D

onready var bulletHitbox = $BulletHitbox
onready var playerCollider = $PlayerCollider
onready var animationPlayer = $AnimationPlayer
onready var timer = $DoorTimer


const COLLIDER = preload("res://Scenes/Scenes/World Prefabs/ShootablePlayerCollider.tscn")

const SHOOTABLEDOORSHAPE = preload("res://Resources/ShootableDoor.tres")
const EMPTYDOORSHAPE = preload("res://Resources/EmptyDoorShape.tres")


func door_shot():
	if animationPlayer.get_current_animation() != "Close":
		animationPlayer.play("Open")
		disable()
		print("Triggered disable")
		
func door_close():
	enable()
	animationPlayer.play("Close")
	print("Triggered enable")	
	
func _on_BulletHitbox_area_entered(area: Area2D) -> void:
	door_shot()
	print("Door Shot")



func disable():
	var collider = get_node("PlayerCollider")
	if collider:
		collider.queue_free()
	else:
		pass
	
func enable():
	var collider = CollisionShape2D.new()
	collider.name = "PlayerCollider"
	collider.set_shape(SHOOTABLEDOORSHAPE)
	self.add_child(collider)
	
	
