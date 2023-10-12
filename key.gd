extends CharacterBody2D

@onready var player = get_node("/root/main/player")

func _on_body_entered(body) -> void:
	if body != player: return
	
#	var speed = position.distance_to(player.position)/100
	
#	tween.follow_property(player, "position", null, self, "position", speed, Tween.TRANS_QUAD, Tween.EASE_IN)
	
#	tween.tween_property(self, "position", player.position, 1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
#	tween.tween_callback(queue_free)

func _physics_process(delta):
#	var weight = 1 - (1 / position.distance_to(player.position) * 10 * delta)
	var weight = 1 - (1 / position.distance_to(player.position))
	weight = clamp(weight, .9, 1)
	velocity += lerp(velocity, (player.position - position) * delta * (weight*10), weight)
	velocity = velocity.limit_length(1000)
	# * delta * 200
	print(weight)
#	position = lerp(position, player.position, weight)
	
	move_and_slide()
