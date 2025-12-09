extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var target: CharacterBody2D = null

var flashlight = null

func _ready():
	target = get_tree().current_scene.get_node_or_null("Player")
	
	flashlight = target.get_node("Flashlight") if target else null

func _physics_process(delta: float) -> void:
	if target == null:
		return
	var direction = (target.global_position - global_position).normalized()
	velocity = direction * SPEED
		
	# Stop if in flashlight cone
	if flashlight and flashlight.visible and is_in_flashlight(flashlight):
		velocity = Vector2.ZERO
	else:
		direction = (target.global_position - global_position).normalized()
		velocity = direction * SPEED
	move_and_slide()

func is_in_flashlight(light) -> bool:
# Simple cone check
	var to_position: Vector2 = global_position - light.global_position
	var distance: float = to_position.length()
	if distance > light.range:
		return false
	
	var angle_to_position: float = to_position.angle()
	var half_spot_angle: float = deg_to_rad(light.spot_angle / 2)
	var light_direction: float = light.rotation
	var angle_difference: float = abs(ang_diff(angle_to_position, light_direction))
	
	return angle_difference <= half_spot_angle
	
func ang_diff(angle1: float, angle2: float) -> float:
	var diff: float = angle1 - angle2
	while diff > PI:
		diff -= TAU
	while diff < -PI:
		diff += TAU
	return diff
