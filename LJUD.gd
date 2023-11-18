extends Timer

signal startC

func _on_timeout() -> void:
	print("startar")
	startC.emit()
	$"../Front/AnimationPlayer".play("1")
	$"../Back/AnimationPlayer".play("3")
