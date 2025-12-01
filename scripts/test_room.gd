extends Node2D

@onready var distortion = $"CanvasLayer/ColorRect".material

func _ready():
	randomize()
	start_implant_glitches()

func start_implant_glitches():
	await get_tree().create_timer(randf_range(2,5)).timeout
	distortion.set("shader_parameter/glitch_strength", 0.2)
	await get_tree().create_timer(0.2).timeout
	distortion.set("shader_parameter/glitch_strength", 0.0)
	start_implant_glitches()
