extends Node2D

@export var target_scene: String
@export var floor_spawn: String = "ElevatorExit"
@export var locked: bool = false

var player_inside := false


func _on_area_2d_body_entered(body):
	print("enter")
	if body.name == "Player":
		player_inside = true


func _on_area_2d_body_exited(body):
	print("exit")
	if body.name == "Player":
		player_inside = false


func _process(_delta):
	
	if player_inside and Input.is_action_just_pressed("interact"):
		if locked:
			print("Elevator locked")
			return

		GameState.request_scene_change(target_scene, floor_spawn)
		get_tree().change_scene_to_file(target_scene)
