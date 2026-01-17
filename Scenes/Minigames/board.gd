extends Control

@export var board_size = 4
@export var tile_size = 80
@export var tile_scene : PackedScene = preload("res://Scenes/Minigames/tile.tscn")
@export var slide_duration = 0.15

var board = []
var tiles = []
var empty = Vector2()
var is_animating = false
var tiles_animating = 0

var background_texture = null
var number_visible = false

enum GAME_STATES {
	NOT_STARTED,
	STARTED,
	WON
}

var current_state = GAME_STATES.NOT_STARTED

signal game_started
signal game_won
signal moves_updated

# Sets up the board
func board_setup():
	var value = 1
	for r in range(board_size):
		board.append([])
		for c in range(board_size):
			#choose empty cell
			if(value == board_size*board_size):
				board.append(0)
				empty = Vector2(c, r)
			else:
				board[r].append(value)

				var tile = tile_scene.instantiate()
				tile.set_position(Vector2(c * tile_size, r * tile_size))
				tile.set_text(value)
				if background_texture:
					tile.set_sprite_texture(background_texture)
				tile.set_sprite(value - 1, board_size, tile_size)
				tile.set_number_visible(number_visible)
				add_child(tile)
				tiles.append(tile)
				
			value += 1

# Checks if board is solved
func is_board_solved():
	var count = 1
	for r in range(board_size):
		for c in range (board_size):
			if(board[r][c] != count):
				if r == c and c == board_size - 1 and board[r][c] == 0:
					return true
				else:
					return false
			count += 1
	return true

# Prints board  in output
func print_board():
	print("----Board----")
	for r in range(board_size):
		var row = ''
		for c in range(board_size):
			row += str(board[r][c]).pad_zeros(2) + " "
		print(row)

# Returns r, c of tile that is in vlaue position
func value_to_grid(value):
	for r in range(board_size):
		for c in range(board_size):
			if (board[r][c] == value):
				return Vector2(c, r)
	return null

# Return tile object based on value
func get_tile_by_val(value):
	for tile in tiles:
		if str(tile.number) == str(value):
			return tile
	return null

func _ready():
	tile_size = floor(get_size().x / board_size)
	set_size(Vector2(tile_size*board_size, tile_size*board_size))
	board_setup()
