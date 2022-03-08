extends Node

const left = 1
const up = 2
const down = 3
const right = 4

onready var global = get_node("/root/Global")
onready var mazeCellsFollowing
onready var mazeCellsPrevious
onready var mazeCellsVisited
onready var rng = RandomNumberGenerator.new()

signal mazeGenComplete

func make_2d_array():
	var array = []
	for i in global.size[global.lvl]:
		array.append([])
		for j in global.size[global.lvl]:
			array[i].append(0)
	return array

func findUnvisitedcell(hasValue):
	var direction = [0, 0, 0, 0]
	var moved = true
	for i in global.size[global.lvl]:
		for j in global.size[global.lvl]:
			if mazeCellsVisited[i][j] == 0:
				if j - 1 >= 0:
					if mazeCellsVisited[i][j - 1] == 1:
						direction[0] = 1
				if i - 1 >= 0:
					if mazeCellsVisited[i - 1][j] == 1:
						direction[1] = 1
				if i + 1 < global.size[global.lvl]:
					if mazeCellsVisited[i + 1][j] == 1:
						direction[2] = 1
				if j + 1 < global.size[global.lvl]:
					if mazeCellsVisited[i][j + 1] == 1:
						direction[3] = 1
				for z in range(4):
					if direction[z] == 1:
						moved = false
				while moved == false:
					var x = rng.randi() % 4
					if x == 0 && direction[0] == 1:
						mazeCellsPrevious[i][j] = left
						mazeCellsVisited[i][j] = 1
						moved = true
						return [i, j]
					if x == 1 && direction[1] == 1:
						mazeCellsPrevious[i][j] = up
						mazeCellsVisited[i][j] = 1
						moved = true
						return [i, j]
					if x == 2 && direction[2] == 1:
						mazeCellsPrevious[i][j] = down
						mazeCellsVisited[i][j] = 1
						moved = true
						return [i, j]
					if x == 3 && direction[3] == 1:
						mazeCellsPrevious[i][j] = right
						mazeCellsVisited[i][j] = 1
						moved = true
						return [i, j]
			elif i == global.size[global.lvl] - 1 && j == global.size[global.lvl] - 1:
				hasValue[0] = false
				return[0, 0]

func generate_maze():
	mazeCellsFollowing = make_2d_array()
	mazeCellsPrevious = make_2d_array()
	mazeCellsVisited = make_2d_array()
	
	var cell = [0, 0]
	var i = 0
	var j = 0
	var direction = 0
	var hasValue = [true]
	mazeCellsVisited[i][j] = 1
	rng.randomize()

	while hasValue[0] == true:
		direction = rng.randi() % 4 + 1
		if (direction == left) && (j - 1 >= 0):
			if mazeCellsVisited[i][j - 1] == 0:
				mazeCellsFollowing[i][j] = left
				j = j - 1
				mazeCellsVisited[i][j] = 1
			else:
				cell = findUnvisitedcell(hasValue)
				i = cell[0]
				j = cell[1]
		elif (direction == up) && (i - 1 >= 0):
			if mazeCellsVisited[i - 1][j] == 0:
				mazeCellsFollowing[i][j] = up
				i = i - 1
				mazeCellsVisited[i][j] = 1
			else:
				cell = findUnvisitedcell(hasValue)
				i = cell[0]
				j = cell[1]
		elif (direction == down) && (i + 1 < global.size[global.lvl]):
			if mazeCellsVisited[i + 1][j] == 0:
				mazeCellsFollowing[i][j] = down
				i = i + 1
				mazeCellsVisited[i][j] = 1
			else:
				cell = findUnvisitedcell(hasValue)
				i = cell[0]
				j = cell[1]
		elif (direction == right) && (j + 1 < global.size[global.lvl]):
			if mazeCellsVisited[i][j + 1] == 0:
				mazeCellsFollowing[i][j] = right
				j = j + 1
				mazeCellsVisited[i][j] = 1
			else:
				cell = findUnvisitedcell(hasValue)
				i = cell[0]
				j = cell[1]
		else:
				cell = findUnvisitedcell(hasValue)
				i = cell[0]
				j = cell[1]
	emit_signal("mazeGenComplete")

