@tool
extends TileMap


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	clear()
#	print("HEJ")
	var map = $"../TileMap_höger"
	for cell in map.get_used_cells(0):
		set_cell(0, cell, 0, Vector2.ZERO)
#	print("HEj")

#func _on_tile_map_höger_changed():
