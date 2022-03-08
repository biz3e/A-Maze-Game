extends MarginContainer

const Main = preload("res://Maze/Main.tscn")

onready var global = get_node("/root/Global")
onready var selector = [[$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level1, 
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level2, 
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level3, 
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level4,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level5,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level6,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level7,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level8,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level9,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer/Level10],
[$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level11,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level12,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level13,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level14,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level15,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level16,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level17,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level18,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level19,
$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/VBoxContainer2/Level20]]

var i = 0
var j = 0


func _ready():
	set_current_selection(0, 0)


func _input(event):
	if Input.is_action_pressed("ui_down") && j < 9:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		j += 1
		set_current_selection(i, j)
	elif Input.is_action_pressed("ui_down") && j == 9:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		j = 0
		set_current_selection(i, j)
	elif Input.is_action_pressed("ui_up") && j > 0:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		j -= 1
		set_current_selection(i, j)
	elif Input.is_action_pressed("ui_up") && j == 0:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		j = 9
		set_current_selection(i, j)
	elif Input.is_action_pressed("ui_right") && i == 0:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i += 1
		set_current_selection(i, j)
	elif Input.is_action_pressed("ui_left") && i > 0:
		selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
		i -= 1
		set_current_selection(i, j)
	elif event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_DOWN:
				if j < 9:
					selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					j += 1
					set_current_selection(i, j)
				elif j == 9:
					selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					j = 0
					set_current_selection(i, j)
			elif event.button_index == BUTTON_WHEEL_UP:
				if j > 0:
					selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					j -= 1
					set_current_selection(i, j)
				elif j == 0:
					selector[i][j].set("custom_colors/font_color", Color8(170, 170, 170, 255))
					j = 9
					set_current_selection(i, j)
	elif Input.is_action_just_pressed("ui_cancel"):
		var mainMenu = load("res://Menu/MainMenu.tscn")
		get_node("/root").add_child(mainMenu.instance())
		get_node("/root/LevelMenu").queue_free()
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(i, j)


func set_current_selection(currentSelectionx, currentSelectiony):
	selector[currentSelectionx][currentSelectiony].set("custom_colors/font_color", Color(1, 1, 1, 1))
	yield(get_tree().create_timer(1), "timeout")


func handle_selection(currentSelectionx, currentSelectiony):
	global.lvl = int(selector[currentSelectionx][currentSelectiony].text)
	var main = Main.instance()
	get_parent().add_child(main)
	main.loadGame()
	queue_free()

