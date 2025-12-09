extends Node2D

var battery = GameState.battery
var FlashLightBatteryProg = ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FlashLightBatteryProg = $FlashLightBatteryProg
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	battery -= 0.1
	FlashLightBatteryProg.value = battery
	pass
