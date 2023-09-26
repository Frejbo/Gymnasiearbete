extends Node2D

@onready var direction = ["Höger", "Vänster"].pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "Vänster":
		$TileMap.scale.x = -1
		$complete.position.x = -$complete.position.x
