extends Node2D

@export var player : CharacterBody2D

@export var layerInFront : int = 3
@export var layerBehind : int = 1

var player_position : int

func _process(delta: float) -> void:
	player_position = player.position.y
