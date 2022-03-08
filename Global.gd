extends Node

const size = [5, 6, 7, 8, 10, 12, 14, 15, 20, 21, 24, 28, 30, 35, 40, 42, 56, 60, 70, 84, 105, 120]

var lvl = 0

var music = AudioStreamPlayer.new()
var stream = [load("res://Kahoot.wav"), load("res://Love Me Long Time.wav") , load("res://Amelia BGM.wav"), load("res://Gura BGM.wav")]
var trackNames = ["Kahoot", "Love me Long Time", "Amelia BGM", "Gura BGM"]
var track = 0

func _ready():
	music.set_pause_mode(Node.PAUSE_MODE_PROCESS)
	add_child(music)
	music.set_stream(stream[track])
	music.volume_db = 0
	music.play()

func _process(_delta):
	if music.is_playing() == false:
		music.play()
