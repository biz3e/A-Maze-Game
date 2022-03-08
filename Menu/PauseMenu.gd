extends MarginContainer

onready var option = [$CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Resume, $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Quit]

var i = 0

func _ready():
	get_tree().paused = true
	set_current_selection(0)

func _input(event):
	if Input.is_action_pressed("ui_down") && i < 1:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i += 1
		set_current_selection(i)
	elif Input.is_action_pressed("ui_down") && i == 1:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i = 0
		set_current_selection(i)
	elif Input.is_action_pressed("ui_up") && i > 0:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i -= 1
		set_current_selection(i)
	elif Input.is_action_pressed("ui_up") && i == 0:
		option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i = 1
		set_current_selection(i)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_DOWN:
				if i < 1:
					option[i].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					i += 1
					set_current_selection(i)
				elif i == 1:
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
					i = 1
					set_current_selection(i)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(i)

func handle_selection(currentSelection):
	if currentSelection == 0:
		get_tree().paused = false
		queue_free()
	elif currentSelection == 1:
		get_tree().paused = false
		var mainMenu = load("res://Menu/MainMenu.tscn")
		get_node("/root").add_child(mainMenu.instance())
		get_node("/root/Main").queue_free()


func set_current_selection(currentSelection):
	option[currentSelection].set("custom_colors/font_color", Color(1, 1, 1, 1))
	yield(get_tree().create_timer(1), "timeout")
