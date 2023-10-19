extends CharacterBody2D



func _on_area_2d_body_entered(body):
	$AnimatedSprite2D.play("break")
