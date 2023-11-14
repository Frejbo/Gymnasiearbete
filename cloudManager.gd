extends ParallaxLayer


func _on_timer_timeout():
	add_cloud()

func add_cloud():
	var c = preload("res://cloud.tscn").instantiate()
	c.position.x = randf_range(0, 50000)
	c.position.y = randf_range(-400, -1000)
	add_child(c)

func _ready():
	await get_tree().create_timer(5).timeout
	set_physics_process(false)

func _physics_process(_delta):
	add_cloud()
