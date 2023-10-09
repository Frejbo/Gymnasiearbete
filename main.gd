extends Node2D

@onready var direction = ["Höger", "Vänster"].pick_random()

# Called when the node enters the scene tree for the first time.
func _ready():
	if direction == "Vänster":
		$TileMap.scale.x *= -1
		$complete.position.x *= -1
		$player/AnimatedSprite2D.scale.x *= -1
		$mist.position.x *= -1
		$Key.position.x *= -1
		
		for layer in $ParallaxBackground.get_children():
			layer.get_child(0).scale.x *= -1
