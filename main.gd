extends Node2D

@onready var direction = ["Vänster", "Höger"].pick_random()

var nodes = []
func _ready():
	if direction == "Vänster":
		getAllNodes()
		for n in nodes:
			if n.is_in_group("Invert ScaleX"):
				n.scale.x *= -1
			if n.is_in_group("Invert PosX"):
				n.position.x *= -1

func getAllNodes(node = self):
	for n in node.get_children():
		if n.get_child_count() > 0:
			nodes.append(n)
			getAllNodes(n)
		else:
			nodes.append(n)
