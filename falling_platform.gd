extends CharacterBody2D

var enabled := true
func _on_area_2d_body_entered(body):
	if body == self: return
	if not enabled: return
	$breaking.play()
	enabled = false
	$AnimatedSprite2D.play("break")
	while $AnimatedSprite2D.frame < 12:
		await $AnimatedSprite2D.frame_changed
	$CollisionShape2D.disabled = true
	await $AnimatedSprite2D.animation_finished
	modulate.a = 0
	$AnimatedSprite2D.frame = 0
	
	await get_tree().create_timer(2).timeout
	
	$CollisionShape2D.disabled = false
	$AnimationPlayer.play("dissolveIn")
	enabled = true
