extends Node2D

const explosionEffect = preload("res://Scenes/Scenes/Effects/ExplosionEffect.tscn")

var velocity = Vector2.ZERO

func _process(delta: float) -> void:
	position += velocity * delta


func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	queue_free()


func _on_Hitbox_body_entered(_body: Node) -> void:
	Utils.instance_scene_on_main(explosionEffect, global_position)
	queue_free()
	



func _on_Hitbox_area_entered(_area: Area2D) -> void:
	Utils.instance_scene_on_main(explosionEffect, global_position)
	queue_free()
