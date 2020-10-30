extends Node


var sounds_path = "res://Music and Sounds/"

var sounds = {
	"Bullet" : load(sounds_path + "Bullet.wav"),
	"Click" : load(sounds_path + "Click.wav"),
	"EnemyDie" : load(sounds_path + "EnemyDie.wav"),
	"Explosion" : load(sounds_path + "Explosion.wav"),
	"Hurt" : load(sounds_path + "Hurt.wav"),
	"Jump" : load(sounds_path + "Jump.wav"),
	"Pause" : load(sounds_path + "Pause.wav"),
	"Powerup" : load(sounds_path + "Powerup.wav"),
	"Step" : load(sounds_path + "Step.wav"),
	"Unpause" : load(sounds_path + "Unpause.wav"),
	"MissileShoot" : load(sounds_path + "MissileShoot.wav"),
	"Save" : load(sounds_path + "Save.wav"),
	"HealthPickup" : load(sounds_path + "HealthPickup.wav"),
}

onready var sound_players = get_children()

func play(sound_string, pitch_scale = 1, volume = 0):
	for sound_player in sound_players:
		if not sound_player.playing:
			sound_player.pitch_scale = pitch_scale
			sound_player.volume_db = volume
			sound_player.stream = sounds[sound_string]
			sound_player.play()
			return
	print("Not enough Audio Stream Players")
