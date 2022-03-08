extends MarginContainer

onready var option = [$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Start, $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Settings, $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Quit]
var i = 0


func _ready():
	set_current_selection(0)


func _input(event):
	if Input.is_action_pressed("ui_down") && i < 2:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i += 1
		set_current_selection(i)
	elif Input.is_action_pressed("ui_down") && i == 2:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i = 0
		set_current_selection(i)
	elif Input.is_action_pressed("ui_up") && i > 0:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i -= 1
		set_current_selection(i)
	elif Input.is_action_pressed("ui_up") && i == 0:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i = 2
		set_current_selection(i)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_DOWN:
				if i < 2:
					option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					i += 1
					set_current_selection(i)
				elif i == 2:
					option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					i = 0
					set_current_selection(i)
			elif event.button_index == BUTTON_WHEEL_UP:
				if i > 0:
					option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					i -= 1
					set_current_selection(i)
				elif i == 0:
					option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					i = 2
					set_current_selection(i)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(i)


func handle_selection(currentSelection):
	if currentSelection == 0:
		var LevelMenu = load("res://Menu/LevelMenu.tscn")
		get_node("/root").add_child(LevelMenu.instance())
		queue_free()
	elif currentSelection == 1:
		var SettingsMenu = load("res://Menu/SettingsMenu.tscn")
		get_node("/root").add_child(SettingsMenu.instance())
		queue_free()
	elif currentSelection == 2:
		get_tree().quit()


func set_current_selection(currentSelection):
	option[currentSelection].set("custom_colors/font_color", Color(1, 1, 1, 1))
	yield(get_tree().create_timer(1), "timeout")
