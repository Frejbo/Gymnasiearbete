extends Area2D

var startTime : float
var time
signal complete

func _process(_delta):
	if $"../player".velocity != Vector2.ZERO:
		startTime = Time.get_ticks_msec()
	set_process(false)


func _on_body_entered(body):
	if !Globals.should_submit:
		get_tree().quit()
	
	if body != $"../player":
		return
	$"../player".set_physics_process(false)
	$"../player".hide()
	$"vänta".show()
	time = (Time.get_ticks_msec() - startTime)/1000
	complete.emit()
	print(time)
