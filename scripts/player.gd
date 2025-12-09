extends CharacterBody2D

@export var speed: float = 150
@onready var hold_point = $HoldPoint
@export var held_item: Node2D = null
@onready var flashlight = $Flashlight
var has_flashlight := false
var flashlight_rotation := 0.0


func pick_up_item(item: Node2D):
	if held_item != null:
		return

	held_item = item
	item.pick_up(hold_point)
	
	print(item.name)
	if item.name == "FlashlightItem":
		has_flashlight = true
		flashlight.enabled = true

func drop_item():
	if held_item == null:
		return

	held_item.drop(get_tree().current_scene)
	held_item = null

func _input(event):
	if event.is_action_pressed("flashlight_toggle") and has_flashlight:
		print("flash on")
		flashlight.enabled = !flashlight.enabled

func _physics_process(_delta):
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	if input != Vector2.ZERO:
		input = input.normalized()

	velocity = input * speed
	
	if has_flashlight and flashlight.visible:
		var mouse_pos = get_global_mouse_position()
		var new_rotation = (mouse_pos - flashlight.global_position).angle()
		
		# Only update if mouse moved a noticeable amount
		if abs((new_rotation - flashlight_rotation)) > 0.01:
			flashlight_rotation = new_rotation
		
		flashlight.global_rotation = flashlight_rotation
	
	move_and_slide()
func _ready():
	await get_tree().process_frame

	var spawn = get_tree().current_scene.get_node_or_null(GameState.spawn_point)
	if spawn:
		global_position = spawn.global_position
