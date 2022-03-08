extends MarginContainer

onready var global = get_node("/root/Global")
onready var endGame = false

func _ready():
	if global.lvl <= 20:
		$CenterContainer/VBoxContainer/CenterContainer/Title.text = "Level " + str(global.lvl)
	else:
		$CenterContainer/VBoxContainer/CenterContainer/Title.text = "nice."
		endGame = true


func _input(_event):
	if Input.is_action_just_pressed("ui_accept") && endGame == true:
		var mainMenu = load("res://Menu/MainMenu.tscn")
		get_node("/root").add_child(mainMenu.instance())
		queue_free()
