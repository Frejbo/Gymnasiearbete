extends AnimationPlayer

func _ready() -> void:
	get_node("/root/main/ParallaxBackground/Timer").startC.connect(play)
