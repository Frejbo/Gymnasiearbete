extends CanvasLayer

signal try_again

func _on_try_again() -> void:
	try_again.emit()
