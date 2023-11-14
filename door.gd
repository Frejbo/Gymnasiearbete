extends StaticBody2D

func unlock():
	$audio.play()
	$AnimatedSprite2D.play("open")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = true
