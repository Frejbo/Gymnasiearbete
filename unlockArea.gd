extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("key_required"):
		return
	print(body)
	get_parent().target = body
	while global_position.distance_to(body.global_position) > 150:
		await get_tree().physics_frame
	$dissolve.play("dissolve")
	await get_tree().create_timer($dissolve.get_animation("dissolve").length / 2).timeout
	body.unlock()
	await $dissolve.animation_finished
	get_parent().queue_free()
