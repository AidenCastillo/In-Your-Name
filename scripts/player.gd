extends CharacterBody2D

@export var speed: float = 150

func _physics_process(delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input != Vector2.ZERO:
		input = input.normalized()

	velocity = input * speed
	move_and_slide()
func _ready():
	await get_tree().process_frame

	var spawn = get_tree().current_scene.get_node_or_null(GameState.spawn_point)
	if spawn:
		global_position = spawn.global_position
