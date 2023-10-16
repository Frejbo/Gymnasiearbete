extends StaticBody2D

func unlock():
	$AnimatedSprite2D.play("open")
	await $AnimatedSprite2D.animation_finished
	$CollisionShape2D.disabled = true
