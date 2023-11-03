extends CharacterBody2D

func _on_area_2d_body_entered(body):
	if body == self: return
	$AnimatedSprite2D.play("break")
	await $AnimatedSprite2D.animation_finished
	await get_tree().create_timer(1).timeout
	hide()
	$AnimatedSprite2D.play("break", -1.0, false)
	
func _on_animated_sprite_2d_frame_changed() -> void:
	print($AnimatedSprite2D.frame)
	if $AnimatedSprite2D.frame >= 13:
		$CollisionShape2D.disabled = true
