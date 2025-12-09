extends PointLight2D

@export var range: float = 200.0
@export var spot_angle: float = 60.0


# make public function to check if a position is in the light area
func is_position_in_light(position: Vector2) -> bool:
	var to_position: Vector2 = position - global_position
	var distance: float = to_position.length()
	if distance > self.range:
		return false
	
	var angle_to_position: float = to_position.angle()
	var half_spot_angle: float = deg_to_rad(self.spot_angle / 2)
	var light_direction: float = rotation
	var angle_difference: float = abs(ang_diff(angle_to_position, light_direction))
	
	return angle_difference <= half_spot_angle

func ang_diff(angle1: float, angle2: float) -> float:
	var diff: float = angle1 - angle2
	while diff > PI:
		diff -= TAU
	while diff < -PI:
		diff += TAU
	return diff

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
