extends Node2D

onready var bulletHitbox = $BulletHitbox
onready var playerCollider = $PlayerCollider
onready var animationPlayer = $AnimationPlayer
onready var timer = $DoorTimer



const SHOOTABLEDOORSHAPE = preload("res://Resources/ShootableDoor.tres")
const SIDEWAYSSHOOTABLEDOORSHAPE = preload("res://Resources/SidewaysShootableDoor.tres")
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
	orientation_check(collider)
	self.add_child(collider)
	
func orientation_check(collider):
	if self.rotation_degrees == 90 or self.rotation_degrees == 180:
		collider.set_shape(SIDEWAYSSHOOTABLEDOORSHAPE)
	else:
		collider.set_shape(SHOOTABLEDOORSHAPE)
	
	
