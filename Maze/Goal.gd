extends Node2D

onready var global = get_node("/root/Global")

func _on_Area2D_area_entered(_area):
	global.lvl += 1
	var main = get_node("/root/Main")
	main.resetGame()
