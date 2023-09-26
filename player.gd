extends CharacterBody2D

# moving
@export var MAX_SPEED := 5.0
var speed = MAX_SPEED
@export var ACCELERATION := 0.8
@export var DEACCELERATION := 0.5
# jumping
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak)
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func _physics_process(delta) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= get_gravity() * delta
#
	# Get the input direction and handle the movement/deceleration.
#	var input_dir := Input.get_axis("left", "right")
	
#	if input_dir:
	var y := velocity.y
	velocity.y = 0
	velocity = velocity.limit_length(speed)
	velocity.y = y
#	velocity = velocity.normalized() * velocity.length()
#	else:
	
	
	
	move_horizontally()
	
	move_and_slide()

func move_horizontally():
	var x = velocity.x
		
	var input = Input.get_axis("left", "right")
#	$AnimatedSprite2D.set_anim(input)
	speed = clamp(speed + (input * MAX_SPEED * ACCELERATION), -MAX_SPEED, MAX_SPEED)
	
	if !input:
		speed *= DEACCELERATION
#		slowing down after key is released
	velocity.x = speed
#	$AnimationTree.set("parameters/blend_position", speed / MAX_SPEED)

func _input(event) -> void:
	# Jumping
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_velocity
		$AnimatedSprite2D.jump()
