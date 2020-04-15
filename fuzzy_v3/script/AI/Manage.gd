extends Node

func _ready():
	pass # Replace with function body.

func create_gameAI(game_name):
	match game_name:
		"MagicCube":
			return MagicCubeAI.new()
		_:
			return 
