extends AnimatedSprite2D

var standardScale = scale
var landing : bool = false

enum legs {LEGS_BOTH, LEG_BACK, LEG_FRONT}

func jump():
	stop()
	play("jump")
	spawn_footstep(legs.LEG_BACK)

func _process(_delta):
	var axis = Input.get_axis("left", "right")
	if $"..".is_on_floor():
		if landing:
			spawn_footstep(legs.LEG_FRONT)
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
			if animation == "jump" && is_playing(): return
			play("fall")
	if axis > 0:
		scale.x = standardScale.x
	elif axis < 0:
		scale.x = -standardScale.x
	
	
	if (animation == "jump" or animation == "landing_to_idle" or animation == "landing_to_running") && is_playing() or landing:# && !$"..".is_on_floor():
		return
		print("not doing aaanythingggg tonight")
	
	if axis == 0:
		play("idle")
		return
	elif $"..".is_on_floor():
		if animation != "running":
			stop()
		play("running")


func _on_frame_changed():
	if not animation == "running": return
	if not $"..".is_on_floor(): return
	
	if frame == 4:
		spawn_footstep(legs.LEG_FRONT)
	elif frame == 7:
		spawn_footstep(legs.LEG_BACK)


func spawn_footstep(leg:legs = legs.LEGS_BOTH) -> void:
	var particle := preload("res://dirt_particle.tscn").instantiate()
	
	match leg:
		legs.LEG_BACK:
			particle.position = $back.global_position
			$"../..".add_child(particle)
			particle.apply_impulse(Vector2(-10*scale.x, -200))
		legs.LEG_FRONT:
			particle.position = $front.global_position
			$"../..".add_child(particle)
			particle.apply_impulse(Vector2(-10*scale.x, -200))
		legs.LEGS_BOTH:
			particle.position = $back.global_position
			$"../..".add_child(particle)
			particle.apply_impulse(Vector2(-10*scale.x, -200))
			
			particle = preload("res://dirt_particle.tscn").instantiate()
			particle.position = $front.global_position
			$"../..".add_child(particle)
			particle.apply_impulse(Vector2(-10*scale.x, -200))
