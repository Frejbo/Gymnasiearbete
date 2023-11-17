extends Area2D

var startTime : float
var time
signal complete

func _input(event):
	if event.is_action("left") or event.is_action("right"):
		startTime = Time.get_ticks_msec()
		print("Started running: ", startTime/1000, " seconds.")
		set_process_input(false)


func _on_body_entered(body):
	if !Globals.should_submit:
		OS.alert("Du har redan skickat in ditt svar, stänger spelet.", "Du klarade spelet")
		get_tree().quit()
	
	if body != $"../player":
		return
	$"../player".set_physics_process(false)
	$"../player".hide()
	$"vänta".show()
	time = (Time.get_ticks_msec() - startTime)/1000
	complete.emit()
	print(time)
