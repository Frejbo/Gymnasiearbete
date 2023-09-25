extends AnimatedSprite2D

var standardScale = scale.x
var jumping = false

func set_anim(input:float):
	
	if input > 0 and not jumping:
		scale.x = standardScale
		play("running")
	elif input < 0 and not jumping:
		scale.x = -standardScale
		play("running")
	elif jumping:
		play("jumping")
	else:
		play("idle")
		

