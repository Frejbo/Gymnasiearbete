extends AnimatedSprite2D

var standardScale = scale.x


func jump():
	stop()
	play("jump")

func _process(_delta):
	var axis = Input.get_axis("left", "right")
	if axis > 0:
		scale.x = standardScale
	elif axis < 0:
		scale.x = -standardScale
	
	if animation == "jump" && is_playing():
		return
	
	if axis == 0:
		play("idle")
		return
	elif $"..".is_on_floor():
		play("running")
	
	
