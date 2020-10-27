extends Node2D

const DustEffect = preload("res://Scenes/Scenes/Effects/DustEffect.tscn")


func create_dust_effect():
	var dust_position = global_position
	dust_position.x += rand_range(-4, 4)
	Utils.instance_scene_on_main(DustEffect, dust_position)
