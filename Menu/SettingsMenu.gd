extends MarginContainer

onready var global = get_node("/root/Global")
onready var option = [$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Soundtrack, $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer6/HBoxContainer/Back]
onready var selector = [$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/HBoxContainer/lSelector, $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/HBoxContainer/rSelector]
onready var back = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer6/HBoxContainer/Back
onready var currentTrack = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/HBoxContainer/CurrentSoundtrack

var i = 0

func _ready():
	set_current_selection_x(0)
	set_current_selection_y(0)

func _input(_event):
	if Input.is_action_pressed("ui_down") && i < 1:
		currentTrack.set("custom_colors/font_color", Color8(170, 170, 170, 255))
		selector[0].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		selector[1].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i += 1
		set_current_selection_y(i)
	elif Input.is_action_pressed("ui_down") && i == 1:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i == 0
		set_current_selection_y(i)
	elif Input.is_action_pressed("ui_up") && i > 0:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i -= 1
		set_current_selection_y(i)
	elif Input.is_action_pressed("ui_up") && i == 0:
		currentTrack.set("custom_colors/font_color", Color8(170, 170, 170, 255))
		selector[0].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		selector[1].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i = 1
		set_current_selection_y(i)
	elif Input.is_action_pressed("ui_left") && i == 0:
		set_current_selection_x(0)
	elif Input.is_action_pressed("ui_right") && i == 0:
		set_current_selection_x(1)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(i)


func handle_selection(currentSelection):
	if currentSelection == 0:
		pass
	elif currentSelection == 1:
		get_tree().paused = false
		var mainMenu = load("res://Menu/MainMenu.tscn")
		get_node("/root").add_child(mainMenu.instance())
		get_node("/root/SettingsMenu").queue_free()


func set_current_selection_y(currentSelection):
	option[currentSelection].set("custom_colors/font_color", Color(1, 1, 1, 1))
	if currentSelection == 0:
		currentTrack.set("custom_colors/font_color", Color(1, 1, 1, 1))


func set_current_selection_x(currentSelection):
	if currentSelection == 0:
		if global.track == 0:
			selector[0].text = ""
		elif global.track == 1:
			global.track -= 1
			selector[0].set("custom_colors/font_color", Color(1, 1, 1, 1))
			global.music.set_stream(global.stream[global.track])
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -2)
			selector[0].text = ""
			yield(get_tree().create_timer(0.25), "timeout")
			selector[0].set("custom_colors/font_color", Color8(170, 170, 170, 255))
			currentTrack.text = global.trackNames[global.track]
		else:
			selector[1].text = ">"
			global.track -= 1
			selector[0].set("custom_colors/font_color", Color(1, 1, 1, 1))
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -2)
			yield(get_tree().create_timer(0.25), "timeout")
			selector[0].set("custom_colors/font_color", Color8(170, 170, 170, 255))
			currentTrack.text = global.trackNames[global.track]
	elif currentSelection == 1:
		if global.track == 3:
			selector[1].text = ""
		elif global.track == 2:
			global.track += 1
			selector[1].set("custom_colors/font_color", Color(1, 1, 1, 1))
			global.music.set_stream(global.stream[global.track])
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -2)
			selector[1].text = ""
			yield(get_tree().create_timer(0.25), "timeout")
			currentTrack.text = global.trackNames[global.track]
			selector[1].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		else:
			selector[0].text = "<"
			global.track += 1
			selector[1].set("custom_colors/font_color", Color(1, 1, 1, 1))
			global.music.set_stream(global.stream[global.track])
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -2)
			yield(get_tree().create_timer(0.25), "timeout")
			selector[1].set("custom_colors/font_color", Color8(170, 170, 170, 255))
			currentTrack.text = global.trackNames[global.track]
	yield(get_tree().create_timer(1), "timeout")

