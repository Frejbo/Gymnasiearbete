extends CharacterBody2D

@onready var target = get_node("/root/main/player")
var goal_pos : Vector2
@onready var MAX_SPEED = target.MAX_SPEED

const MAX_DISTANCE = 400
var collected = false
func _physics_process(_delta):
	goal_pos.x = target.position.x
	goal_pos.y = target.position.y -75
	
	var influence = 1-(position.distance_to(goal_pos) / MAX_DISTANCE)
	influence = clamp(influence, 0, 1)
	if collected:
		follow_target()
	else:
		
		velocity = ((goal_pos - position)) * (influence*(4*influence))
		move_and_slide()
		
		if influence >= .9:
			$AnimatedSprite2D/collect.play("collect")
			print("Collected key")
			collected = true

func follow_target():
	var weight = 1-(1 / position.distance_to(goal_pos))
	velocity = lerp(velocity, (goal_pos - position)*5, .05)
	velocity = velocity.limit_length(MAX_SPEED)

	move_and_slide()
