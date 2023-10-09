extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(.5).timeout
	visible_characters = 0
	for i in range(get_total_character_count()):
		await get_tree().create_timer(.01).timeout
		visible_characters += 1
	visible_characters = -1
