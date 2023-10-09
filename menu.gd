extends Control

@export var confirmationBox : CheckBox

var game = preload("res://main.tscn")

func _enter_tree():
	print(FileAccess.file_exists("user://last"))

func _on_start_pressed():
	if confirmationBox.button_pressed:
		var file = FileAccess.open("user://last", FileAccess.WRITE)
		file.close()
		get_tree().change_scene_to_packed(game)
	else:
		for i in range(2):
			confirmationBox.set("theme_override_colors/font_color", Color.WHITE)
			await get_tree().create_timer(.05).timeout
			confirmationBox.set("theme_override_colors/font_color", Color.RED)
			await get_tree().create_timer(.05).timeout
			confirmationBox.set("theme_override_colors/font_color", Color.WHITE)