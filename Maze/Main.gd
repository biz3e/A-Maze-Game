extends Node

var mazeGenComplete = false
onready var global = get_node("/root/Global")
onready var mazeNode = get_node("Maze")
onready var mazeGen = $MazeGenerator
onready var vertWalls = []
onready var horizWalls = []
onready var border = []
onready var player = []
onready var goal = []
onready var borderThickness = 1.5
onready var borderLength = 840
onready var cellSize = borderLength/global.size[global.lvl]
onready var playerPos = Vector2.ZERO

const Border = preload("res://Wall/Border.tscn")
const Wall = preload("res://Wall/Wall.tscn")
const Player = preload("res://Player/Player.tscn")
const Goal = preload("res://Maze/Goal.tscn")

func make_2d_array(arraySize):
	var array = []
	for i in arraySize:
		array.append([])
		for j in arraySize:
			array[i].append([])
	return array

func generate_border():
	for i in range(4):
		border.append(Border.instance())
		mazeNode.add_child(border[i])

# This is setting the position and size of the top and bottom borders
	border[0].global_position = Vector2(960, 120)
	border[0].scale = Vector2(borderLength + borderThickness, borderThickness)
	border[1].global_position = Vector2(960, 960)
	border[1].scale = Vector2(borderLength + borderThickness, borderThickness)
	
# This sets the position and size of the side borders
	border[2].global_position = Vector2(border[1].global_position.x - borderLength/2, (border[1].global_position.y - border[0].global_position.y)/2 + border[0].global_position.y)
	border[2].scale = Vector2(borderThickness, borderLength + borderThickness)
	border[3].global_position = Vector2(border[1].global_position.x + borderLength/2, (border[1].global_position.y - border[0].global_position.y)/2 + border[0].global_position.y)
	border[3].scale = Vector2(borderThickness, borderLength + borderThickness)

func place_wall_right(v, currentPos, vertWallsArray, currentCellSize):
	vertWallsArray.append(Wall.instance())
	mazeNode.add_child(vertWalls[v])
	vertWallsArray[v].scale = Vector2(borderThickness, currentCellSize + borderThickness)
	vertWallsArray[v].global_position = Vector2(currentPos.x + currentCellSize/2, currentPos.y)

func place_wall_down(h, currentPos, horizWallsArray, currentCellSize):
	horizWallsArray.append(Wall.instance())
	mazeNode.add_child(horizWalls[h])
	horizWallsArray[h].scale = Vector2(currentCellSize + borderThickness, borderThickness)
	horizWallsArray[h].global_position = Vector2(currentPos.x, currentPos.y + currentCellSize/2)

func place_goal(currentPos, currentCellSize):
	goal.append(Goal.instance())
	mazeNode.add_child(goal[0])
	goal[0].scale = Vector2(currentCellSize * 0.6, currentCellSize * 0.6)
	goal[0].global_position = Vector2(currentPos.x, currentPos.y)

func build_maze():
	var mazeCellsFollowing = mazeGen.mazeCellsFollowing
	var mazeCellsPrevious = mazeGen.mazeCellsPrevious
	var left = 1
	var up = 2
	var down = 3
	var right = 4
	var v = 0
	var h = 0
	
	var currentPos = Vector2((border[2].global_position.x + cellSize/2), (border[0].global_position.y - cellSize/2))
	
	for i in global.size[global.lvl]:
		currentPos.y = currentPos.y + cellSize
		for j in global.size[global.lvl]:
			if i == global.size[global.lvl] - 1 && j == global.size[global.lvl] - 1:
				place_goal(currentPos, cellSize)
			elif i == global.size[global.lvl] - 1:
				if mazeCellsFollowing[i][j] != right && mazeCellsFollowing[i][j + 1] != left && mazeCellsPrevious[i][j] != right && mazeCellsPrevious[i][j + 1] != left:
					place_wall_right(v, currentPos, vertWalls, cellSize)
					v = v + 1
			elif j == global.size[global.lvl] - 1:
				if mazeCellsFollowing[i][j] != down && mazeCellsFollowing[i + 1][j] != up && mazeCellsPrevious[i][j] != down && mazeCellsPrevious[i + 1][j] != up:
					place_wall_down(h, currentPos, horizWalls, cellSize)
					h = h + 1
			else:
				if mazeCellsFollowing[i][j] != right && mazeCellsFollowing[i][j + 1] != left && mazeCellsPrevious[i][j] != right && mazeCellsPrevious[i][j + 1] != left:
					place_wall_right(v, currentPos, vertWalls, cellSize)
					v = v + 1
				if mazeCellsFollowing[i][j] != down && mazeCellsFollowing[i + 1][j] != up && mazeCellsPrevious[i][j] != down && mazeCellsPrevious[i + 1][j] != up:
					place_wall_down(h, currentPos, horizWalls, cellSize)
					h = h + 1
			if j == global.size[global.lvl] - 1:
				currentPos.x = border[2].global_position.x + cellSize/2
			else:
				currentPos.x = currentPos.x + cellSize


func add_player():
	playerPos = Vector2((border[2].global_position.x + cellSize/2), (border[0].global_position.y + cellSize/2))
	player.append(Player.instance())
	mazeNode.add_child(player[0])
	player[0].scale = Vector2(cellSize*0.4, cellSize*0.4)
	player[0].global_position = Vector2(playerPos.x, playerPos.y)


func _on_MazeGenerator_mazeGenComplete():
	 mazeGenComplete = true


func loadGame():
	get_tree().paused = true
	vertWalls = []
	horizWalls = []
	border = []
	player = []
	goal = []
	cellSize = borderLength/global.size[global.lvl]
	playerPos = Vector2.ZERO
	if global.lvl <= 20:
		var LevelDisplay = load("res://Menu/LevelDisplay.tscn")
		var levelDisplay = LevelDisplay.instance()
		get_node("/root").add_child(levelDisplay)
		yield(get_tree().create_timer(1), "timeout")
		mazeGen.generate_maze()
		if mazeGenComplete == true:
			generate_border()
			build_maze()
			add_player()
			levelDisplay.queue_free()
			get_tree().paused = false
	else:
		var LevelDisplay = load("res://Menu/LevelDisplay.tscn")
		var levelDisplay = LevelDisplay.instance()
		get_node("/root").add_child(levelDisplay)
		yield(get_tree().create_timer(2), "timeout")
		get_tree().paused = false
		queue_free()


func resetGame():
	mazeNode.queue_free()
	mazeNode = Node.new()
	add_child(mazeNode)
	loadGame()


func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if mazeGenComplete == true:
			player[0].change_zoom(Vector2(1, 1))
			var pauseMenu = load("res://Menu/PauseMenu.tscn")
			add_child(pauseMenu.instance())

