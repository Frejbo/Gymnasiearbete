extends AnimatedSprite2D

var standardScale = scale
var landing : bool = false

enum legs {LEGS_BOTH, LEG_BACK, LEG_FRONT}

func jump():
	stop()
	play("jump")
	spawn_footstep(legs.LEG_BACK, 10)

func _process(_delta):
	var axis = Input.get_axis("left", "right")
	if $"..".is_on_floor():
		if landing:
			spawn_footstep(legs.LEG_FRONT, 10, 150)
			# landar
			if axis == 0:
				play("landing_to_idle")
			else:
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
		spawn_footstep(legs.LEG_FRONT, 3)
	elif frame == 8:
		spawn_footstep(legs.LEG_BACK, 5)


func spawn_footstep(leg:legs = legs.LEGS_BOTH, amount : int = 1, spread : float = 50) -> void:
	$footstep.stream = load(get_footstep_meta(legs.LEG_FRONT)["sound"])
	$footstep.play()
	
	for i in range(amount):
		var particle := preload("res://dirt_particle.tscn").instantiate()
		randomize()
		var force = Vector2(randf_range(($"..".velocity.x / 50) * scale.x - spread, ($"..".velocity.x / 50) * scale.x + spread), randf_range(-150, -250))
		match leg:
			legs.LEG_BACK:
				particle.set_color(get_footstep_meta(legs.LEG_BACK)["color"])
				particle.position = $back.global_position
				$"../..".add_child(particle)
				particle.apply_impulse(force)
			legs.LEG_FRONT:
				particle.set_color(get_footstep_meta(legs.LEG_FRONT)["color"])
				particle.position = $front.global_position
				$"../..".add_child(particle)
				particle.apply_impulse(force)
			legs.LEGS_BOTH:
				particle.set_color(get_footstep_meta(legs.LEG_BACK)["color"])
				particle.position = $back.global_position
				$"../..".add_child(particle)
				particle.apply_impulse(force)
				
				particle = preload("res://dirt_particle.tscn").instantiate()
				particle.set_color(get_footstep_meta(legs.LEG_FRONT)["color"])
				particle.position = $front.global_position
				$"../..".add_child(particle)
				particle.apply_impulse(force)


const colors = {
	0: {"color":Color.DIM_GRAY, "sound":"res://sounds/footsteps/stone.ogg"},
	1: {"color":Color.SADDLE_BROWN, "sound":"res://sounds/footsteps/stone.ogg"},
	3: {"color":Color.DIM_GRAY, "sound":"res://sounds/footsteps/stone.ogg"}
}
func get_footstep_meta(leg:legs) -> Dictionary:
	var raycast : RayCast2D
	match leg:
		legs.LEG_BACK:
			raycast = $back/RayCast2D
		legs.LEG_FRONT:
			raycast = $front/RayCast2D
	
	var tilemap := $"../../map/TileMap"
	var local_point = tilemap.local_to_map(raycast.get_collision_point() / tilemap.scale)
	var cell = tilemap.get_cell_source_id(1, local_point)
	
	if colors.has(cell):
		return colors[cell]
	else:
		return colors[0]
