extends CharacterBody2D

@onready var target = get_node("/root/main/player")
var goal_pos : Vector2
@onready var MAX_SPEED = target.MAX_SPEED

@export var DRAG_DISTANCE : int= 300
@export var COLLECT_DISTANCE : int = 50
@export var Y_OFFSET : int = -75

var collected = false
func _physics_process(_delta):
	goal_pos.x = target.global_position.x
	goal_pos.y = target.global_position.y + Y_OFFSET
	
	var influence = 1-(global_position.distance_to(goal_pos) / DRAG_DISTANCE)
	
	influence = clamp(influence, 0, 1)
	if collected:
		follow_target()
	else:
		
		velocity = ((goal_pos - global_position)) * (influence*(4*influence))
		move_and_slide()
		if global_position.distance_to(Vector2(target.global_position.x, target.global_position.y+Y_OFFSET)) <= COLLECT_DISTANCE:
			$AnimatedSprite2D/collect.play("collect")
			print("Collected key")
			collected = true

func follow_target():
	velocity = lerp(velocity, (goal_pos - global_position)*5, .05)
	velocity = velocity.limit_length(MAX_SPEED)

	move_and_slide()
