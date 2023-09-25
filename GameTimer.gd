extends Area2D

var startTime : float
var time
signal complete

func _process(_delta):
	if $"../player".velocity != Vector2.ZERO:
		startTime = Time.get_ticks_msec()
	set_process(false)




func _on_body_entered(body):
	if body != $"../player":
		return
	
	time = (Time.get_ticks_msec() - startTime)/1000
	complete.emit()
	print(time)
