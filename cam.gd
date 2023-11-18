extends Camera2D

@onready var z = zoom

var volume = Vector2.ONE
var rot = 0.0
var started = false

func _ready() -> void:
	get_node("/root/main/ParallaxBackground/Timer").startC.connect(r)

func r():
	started = true

func _process(_delta: float) -> void:
	if !started:
		return
	var v = AudioServer.get_bus_effect_instance(0, 2).get_magnitude_for_frequency_range(20, 20000)
#	if !v: return
	v = clamp(v, Vector2(.1, .1), Vector2(10, 10))
	volume = Vector2(lerp(volume.x, v.x, .07), lerp(volume.y, v.y, .1))
	var r = volume.x * sin(Time.get_ticks_msec()/500)
	rot += r#lerp(rot, r, .02)
	rotation_degrees = rot * 2
	zoom = z * volume * 15
