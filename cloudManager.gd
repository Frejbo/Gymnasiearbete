extends ParallaxLayer

func add_cloud():
	var c = preload("res://cloud.tscn").instantiate()
	c.position.x = randf_range(-2000, 7000)
	c.position.y = randf_range(-400, -800)
	add_child(c)

func _ready():
	await get_tree().create_timer(.7).timeout
	set_physics_process(false)

func _physics_process(_delta):
	add_cloud()
