extends CharacterBody2D

func _ready():
	$AnimatedSprite2D.frame = randi_range(0, $AnimatedSprite2D.sprite_frames.get_frame_count("clouds"))
	velocity.x = randf_range(30, 50)

func _physics_process(_delta):
	move_and_slide()


func _on_timer_timeout():
	$AnimationPlayer.play_backwards("fadeIn")
	await $AnimationPlayer.animation_finished
	queue_free()
