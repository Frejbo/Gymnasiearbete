extends RigidBody2D

func _on_animation_player_animation_finished(_anim_name):
	queue_free()

func set_color(color : Color) -> void:
	$Sprite2D.self_modulate = color
