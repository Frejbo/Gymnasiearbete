extends CharacterBody2D

var enabled := true
func _on_area_2d_body_entered(body):
	if body == self: return
	if not enabled: return
	enabled = false
	$AnimatedSprite2D.play("break")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = true
	modulate.a = 0
	$AnimatedSprite2D.frame = 0
	
	await get_tree().create_timer(2).timeout
	
	$CollisionShape2D.disabled = false
	$AnimationPlayer.play("dissolveIn")
	enabled = true
