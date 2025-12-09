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
	var dir_to_enemy = (global_position - light.global_position).normalized()
	var light_dir = Vector2.RIGHT.rotated(light.global_rotation)  # Right is default direction
	var angle_diff = light_dir.angle_to(dir_to_enemy)
	var max_angle = deg_to_rad(30)  # half cone angle
	var distance = global_position.distance_to(light.global_position)
	if angle_diff < max_angle and distance < light.texture.get_size().x:  # simple cone check
		return true
	return false
