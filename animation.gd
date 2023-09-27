extends AnimatedSprite2D

var standardScale = scale.x
var landing : bool = false

func jump():
	stop()
	play("jump")

func _process(_delta):
	
	
	var axis = Input.get_axis("left", "right")
	if $"..".is_on_floor():
		if landing:
			# landar
			if axis == 0:
				play("landing_to_idle")
				print("Landing to idle")
			else:
				print("Landing to run")
				play("landing_to_running")
			landing = false
	else:
		if not landing:
			landing = true
	if axis > 0:
		scale.x = standardScale
	elif axis < 0:
		scale.x = -standardScale
	
	
	if (animation == "jump" or animation == "landing_to_idle" or animation == "landing_to_running") && is_playing() or landing:# && !$"..".is_on_floor():
		return
		print("not doing aaanythingggg tonight")
	
	if axis == 0:
		play("idle")
		return
	elif $"..".is_on_floor():
		play("running")
	
	
